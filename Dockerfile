ARG NODEJS_VERSION=12
FROM public.ecr.aws/lambda/nodejs:${NODEJS_VERSION}

LABEL author="Ben Fortuna <fortuna@micronode.com>"

COPY *.js ${LAMBDA_TASK_ROOT}
#COPY modules/* ${LAMBDA_TASK_ROOT}/modules/

CMD ["app.handler"]
