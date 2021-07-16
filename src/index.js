import React from 'react';
import ReactDOM from 'react-dom';

import Sample from '../_build/Sample.js';
import SampleWASM from '../_build/Sample.wasm';

const sample = Sample({
    locateFile: () => {
        return SampleWASM;
    },
});

sample.then((core) => {
    console.log(core.add(1, 2));
    console.log(core.greet());
});

ReactDOM.render(
    <div>
        <h1>Using WebAssembly with React From Scratch!</h1>
    </div>,
    document.getElementById('root')
);
