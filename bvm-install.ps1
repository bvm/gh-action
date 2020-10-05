#!/usr/bin/env pwsh
param(
    [string]
    $dir
)

cd $dir
bvm install
