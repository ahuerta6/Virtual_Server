[← Local AI](README.md)

# Performance measurements

Measurements were recorded on October 19, 2026. The CPU and GPU runs used the same model, four CPU threads, and an 8,192-token context. The CPU baseline preceded the GPU tests; this was not an interleaved controlled experiment.

| Measurement | CPU | RX 580 with Vulkan |
| --- | ---: | ---: |
| Short coding output, median generation | 10.39 tokens/s | 26.97 tokens/s |
| Fresh prompt, 1,187 input tokens: first token | 25.826 s | 5.409 s |
| Fresh prompt, 7,468 input tokens: first token | 252.100 s | 51.142 s |
| Fresh prompt, 7,468 input tokens: generation | 1.58 tokens/s | 7.56 tokens/s |

The short GPU samples were 26.97, 26.89, and 27.01 tokens/s. This is approximately 2.6 times the short-prompt CPU throughput. Large-prompt first-token delay fell by about 80% in the recorded pair.

## What I learned

Uncached prompt processing can dominate the time before an answer begins. Repeated synthetic prompts benefited strongly from cache reuse. Long context also reduced output speed, so the maximum context capacity should not be treated as a performance target.

Reducing inference threads from four to three or two reduced median short-output throughput in the CPU tests. Small batch-size experiments did not demonstrate a substantial repeatable improvement.

The largest measured improvement came from GPU acceleration while retaining the existing model and context capacity.

## Validation and limits

The timing harness called the streaming Ollama API directly, excluding browser and Open WebUI overhead. Three short GPU samples and one fresh/cached pair per context length do not establish performance for every workload. CPU and GPU large-prompt runs produced different output lengths, so total completion time is not an equivalent comparison.

A generated coding response passed three small local checks. A subsequent Open WebUI response also succeeded after final service promotion. These are smoke tests, not a broad assessment of reasoning quality, coding reliability, or tool safety.

No inference benchmark here proves that generated commands are safe to execute. Authorization remains a separate control.
