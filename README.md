# OpenSTM32 Builder
Containerize the Open STM32 building process to help my team
- Develop CI easily
- Having Pull Request verification

# Usage
Mount your project folder into `/src` then let the build script build all configurations you have.
```bash
docker run -it --rm -v /myProject:/src trinhpham/openstm32
```

# TODO
[] Multiple projects support
[] Able to specify configuration to be built

# Contribution
PR are always welcome, guys :)
