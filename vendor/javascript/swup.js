import t from"delegate-it";import{match as e}from"path-to-regexp";function i(){return i=Object.assign?Object.assign.bind():function(t){for(var e=1;e<arguments.length;e++){var C=arguments[e];for(var $ in C)Object.prototype.hasOwnProperty.call(C,$)&&(t[$]=C[$])}return t},i.apply(this,arguments)}const s=(t,e)=>String(t).toLowerCase().replace(/[\s/_.]+/g,"-").replace(/[^\w-]+/g,"").replace(/--+/g,"-").replace(/^-+|-+$/g,"")||e||"",n=({hash:t}={})=>window.location.pathname+window.location.search+(t?window.location.hash:""),o=(t,e={})=>{const C=i({url:t=t||n({hash:!0}),random:Math.random(),source:"swup"},e);window.history.pushState(C,"",t)},r=(t=null,e={})=>{t=t||n({hash:!0});const C=i({},window.history.state||{},{url:t,random:Math.random(),source:"swup"},e);window.history.replaceState(C,"",t)},a=(e,C,$,j)=>{const F=new AbortController;return j=i({},j,{signal:F.signal}),t(e,C,$,j),{destroy:()=>F.abort()}};class l extends URL{constructor(t,e=document.baseURI){super(t.toString(),e),Object.setPrototypeOf(this,l.prototype)}get url(){return this.pathname+this.search}static fromElement(t){const e=t.getAttribute("href")||t.getAttribute("xlink:href")||"";return new l(e)}static fromUrl(t){return new l(t)}}const h=(t,C)=>{try{return e(t,C)}catch(e){throw new Error(`[swup] Error parsing path "${String(t)}":\n${String(e)}`)}};class c extends Error{constructor(t,e){super(t),this.url=void 0,this.status=void 0,this.aborted=void 0,this.timedOut=void 0,this.name="FetchError",this.url=e.url,this.status=e.status,this.aborted=e.aborted||!1,this.timedOut=e.timedOut||!1}}async function u(t,e={}){var C;t=l.fromUrl(t).url;const{visit:$=this.visit}=e,j=i({},this.options.requestHeaders,e.headers),F=null!=(C=e.timeout)?C:this.options.timeout,K=new AbortController,{signal:z}=K;e=i({},e,{headers:j,signal:z});let G,X=!1,J=null;F&&F>0&&(J=setTimeout((()=>{X=!0,K.abort("timeout")}),F));try{G=await this.hooks.call("fetch:request",$,{url:t,options:e},((t,{url:e,options:C})=>fetch(e,C))),J&&clearTimeout(J)}catch(e){if(X)throw this.hooks.call("fetch:timeout",$,{url:t}),new c(`Request timed out: ${t}`,{url:t,timedOut:X});if("AbortError"===(null==e?void 0:e.name)||z.aborted)throw new c(`Request aborted: ${t}`,{url:t,aborted:!0});throw e}const{status:Q,url:Y}=G,Z=await G.text();if(500===Q)throw this.hooks.call("fetch:error",$,{status:Q,response:G,url:Y}),new c(`Server error: ${Y}`,{status:Q,url:Y});if(!Z)throw new c(`Empty response: ${Y}`,{status:Q,url:Y});const{url:tt}=l.fromUrl(Y),et={url:tt,html:Z};return!$.cache.write||e.method&&"GET"!==e.method||t!==tt||this.cache.set(et.url,et),et}class d{constructor(t){this.swup=void 0,this.pages=new Map,this.swup=t}get size(){return this.pages.size}get all(){const t=new Map;return this.pages.forEach(((e,C)=>{t.set(C,i({},e))})),t}has(t){return this.pages.has(this.resolve(t))}get(t){const e=this.pages.get(this.resolve(t));return e?i({},e):e}set(t,e){e=i({},e,{url:t=this.resolve(t)}),this.pages.set(t,e),this.swup.hooks.callSync("cache:set",void 0,{page:e})}update(t,e){t=this.resolve(t);const C=i({},this.get(t),e,{url:t});this.pages.set(t,C)}delete(t){this.pages.delete(this.resolve(t))}clear(){this.pages.clear(),this.swup.hooks.callSync("cache:clear",void 0,void 0)}prune(t){this.pages.forEach(((e,C)=>{t(C,e)&&this.delete(C)}))}resolve(t){const{url:e}=l.fromUrl(t);return this.swup.resolveUrl(e)}}const p=(t,e=document)=>e.querySelector(t),m=(t,e=document)=>Array.from(e.querySelectorAll(t)),w=()=>new Promise((t=>{requestAnimationFrame((()=>{requestAnimationFrame((()=>{t()}))}))}));function g(t){return!!t&&("object"==typeof t||"function"==typeof t)&&"function"==typeof t.then}function f(t,e=[]){return new Promise(((C,$)=>{const j=t(...e);g(j)?j.then(C,$):C(j)}))}function v(t){var e;null==(e=t=t||document.body)||e.getBoundingClientRect()}const y=t=>window.CSS&&window.CSS.escape?CSS.escape(t):t,k=t=>1e3*Number(t.slice(0,-1).replace(",","."));class b{constructor(t){this.swup=void 0,this.swupClasses=["to-","is-changing","is-rendering","is-popstate","is-animating","is-leaving"],this.swup=t}get selectors(){const{scope:t}=this.swup.visit.animation;return"containers"===t?this.swup.visit.containers:"html"===t?["html"]:Array.isArray(t)?t:[]}get selector(){return this.selectors.join(",")}get targets(){return this.selector.trim()?m(this.selector):[]}add(...t){this.targets.forEach((e=>e.classList.add(...t)))}remove(...t){this.targets.forEach((e=>e.classList.remove(...t)))}clear(){this.targets.forEach((t=>{const e=t.className.split(" ").filter((t=>this.isSwupClass(t)));t.classList.remove(...e)}))}isSwupClass(t){return this.swupClasses.some((e=>t.startsWith(e)))}}class S{constructor(t,e){this.id=void 0,this.state=void 0,this.from=void 0,this.to=void 0,this.containers=void 0,this.animation=void 0,this.trigger=void 0,this.cache=void 0,this.history=void 0,this.scroll=void 0;const{to:C,from:$=t.currentPageUrl,hash:j,el:F,event:K}=e;this.id=Math.random(),this.state=1,this.from={url:$},this.to={url:C,hash:j},this.containers=t.options.containers,this.animation={animate:!0,wait:!1,name:void 0,native:t.options.native,scope:t.options.animationScope,selector:t.options.animationSelector},this.trigger={el:F,event:K},this.cache={read:t.options.cache,write:t.options.cache},this.history={action:"push",popstate:!1,direction:void 0},this.scroll={reset:!0,target:void 0}}advance(t){this.state<t&&(this.state=t)}abort(){this.state=8}get done(){return this.state>=7}}function E(t){return new S(this,t)}class P{constructor(t){this.swup=void 0,this.registry=new Map,this.hooks=["animation:out:start","animation:out:await","animation:out:end","animation:in:start","animation:in:await","animation:in:end","animation:skip","cache:clear","cache:set","content:replace","content:scroll","enable","disable","fetch:request","fetch:error","fetch:timeout","history:popstate","link:click","link:self","link:anchor","link:newtab","page:load","page:view","scroll:top","scroll:anchor","visit:start","visit:transition","visit:abort","visit:end"],this.swup=t,this.init()}init(){this.hooks.forEach((t=>this.create(t)))}create(t){this.registry.has(t)||this.registry.set(t,new Map)}exists(t){return this.registry.has(t)}get(t){const e=this.registry.get(t);if(e)return e;console.error(`Unknown hook '${t}'`)}clear(){this.registry.forEach((t=>t.clear()))}on(t,e,C={}){const $=this.get(t);if(!$)return console.warn(`Hook '${t}' not found.`),()=>{};const j=i({},C,{id:$.size+1,hook:t,handler:e});return $.set(e,j),()=>this.off(t,e)}before(t,e,C={}){return this.on(t,e,i({},C,{before:!0}))}replace(t,e,C={}){return this.on(t,e,i({},C,{replace:!0}))}once(t,e,C={}){return this.on(t,e,i({},C,{once:!0}))}off(t,e){const C=this.get(t);C&&e?C.delete(e)||console.warn(`Handler for hook '${t}' not found.`):C&&C.clear()}async call(t,e,C,$){const[j,F,K]=this.parseCallArgs(t,e,C,$),{before:z,handler:G,after:X}=this.getHandlers(t,K);await this.run(z,j,F);const[J]=await this.run(G,j,F,!0);return await this.run(X,j,F),this.dispatchDomEvent(t,j,F),J}callSync(t,e,C,$){const[j,F,K]=this.parseCallArgs(t,e,C,$),{before:z,handler:G,after:X}=this.getHandlers(t,K);this.runSync(z,j,F);const[J]=this.runSync(G,j,F,!0);return this.runSync(X,j,F),this.dispatchDomEvent(t,j,F),J}parseCallArgs(t,e,C,$){return e instanceof S||"object"!=typeof e&&"function"!=typeof C?[e,C,$]:[void 0,e,C]}async run(t,e=this.swup.visit,C,$=!1){const j=[];for(const{hook:F,handler:K,defaultHandler:z,once:G}of t)if(null==e||!e.done){G&&this.off(F,K);try{const t=await f(K,[e,C,z]);j.push(t)}catch(t){if($)throw t;console.error(`Error in hook '${F}':`,t)}}return j}runSync(t,e=this.swup.visit,C,$=!1){const j=[];for(const{hook:F,handler:K,defaultHandler:z,once:G}of t)if(null==e||!e.done){G&&this.off(F,K);try{const t=K(e,C,z);j.push(t),g(t)&&console.warn(`Swup will not await Promises in handler for synchronous hook '${F}'.`)}catch(t){if($)throw t;console.error(`Error in hook '${F}':`,t)}}return j}getHandlers(t,e){const C=this.get(t);if(!C)return{found:!1,before:[],handler:[],after:[],replaced:!1};const $=Array.from(C.values()),j=this.sortRegistrations,F=$.filter((({before:t,replace:e})=>t&&!e)).sort(j),K=$.filter((({replace:t})=>t)).filter((t=>!0)).sort(j),z=$.filter((({before:t,replace:e})=>!t&&!e)).sort(j),G=K.length>0;let X=[];if(e&&(X=[{id:0,hook:t,handler:e}],G)){const C=K.length-1,s=t=>{const C=K[t-1];return C?(e,$)=>C.handler(e,$,s(t-1)):e};X=[{id:0,hook:t,handler:K[C].handler,defaultHandler:s(C)}]}return{found:!0,before:F,handler:X,after:z,replaced:G}}sortRegistrations(t,e){var C,$;return(null!=(C=t.priority)?C:0)-(null!=($=e.priority)?$:0)||t.id-e.id||0}dispatchDomEvent(t,e,C){if(null!=e&&e.done)return;const $={hook:t,args:C,visit:e||this.swup.visit};document.dispatchEvent(new CustomEvent("swup:any",{detail:$,bubbles:!0})),document.dispatchEvent(new CustomEvent(`swup:${t}`,{detail:$,bubbles:!0}))}}const U=t=>{if(t&&"#"===t.charAt(0)&&(t=t.substring(1)),!t)return null;const e=decodeURIComponent(t);let C=document.getElementById(t)||document.getElementById(e)||p(`a[name='${y(t)}']`)||p(`a[name='${y(e)}']`);return C||"top"!==t||(C=document.body),C},C="transition",$="animation";async function x({elements:t,selector:e}){if(!1===e&&!t)return;let j=[];if(t)j=Array.from(t);else if(e&&(j=m(e,document.body),!j.length))return void console.warn(`[swup] No elements found matching animationSelector \`${e}\``);const F=j.map((t=>function(t){const{type:e,timeout:j,propCount:F}=function(t,e){const j=window.getComputedStyle(t),F=A(j,`${C}Delay`),K=A(j,`${C}Duration`),z=H(F,K),G=A(j,`${$}Delay`),X=A(j,`${$}Duration`),J=H(G,X);let Q=null,Y=0,Z=0;return Y=Math.max(z,J),Q=Y>0?z>J?C:$:null,Z=Q?Q===C?K.length:X.length:0,{type:Q,timeout:Y,propCount:Z}}(t);return!(!e||!j)&&new Promise((K=>{const z=`${e}end`,G=performance.now();let X=0;const l=()=>{t.removeEventListener(z,h),K()},h=e=>{if(e.target===t){if(!function(t){return[`${C}end`,`${$}end`].includes(t.type)}(e))throw new Error("Not a transition or animation event.");(performance.now()-G)/1e3<e.elapsedTime||++X>=F&&l()}};setTimeout((()=>{X<F&&l()}),j+1),t.addEventListener(z,h)}))}(t)));F.filter(Boolean).length>0?await Promise.all(F):e&&console.warn(`[swup] No CSS animation duration defined on elements matching \`${e}\``)}function A(t,e){return(t[e]||"").split(", ")}function H(t,e){for(;t.length<e.length;)t=t.concat(t);return Math.max(...e.map(((e,C)=>k(e)+k(t[C]))))}function q(t,e={},C={}){if("string"!=typeof t)throw new Error("swup.navigate() requires a URL parameter");if(this.shouldIgnoreVisit(t,{el:C.el,event:C.event}))return void window.location.assign(t);const{url:$,hash:j}=l.fromUrl(t),F=this.createVisit(i({},C,{to:$,hash:j}));this.performNavigation(F,e)}async function R(t,e={}){if(this.navigating){if(this.visit.state>=6)return t.state=2,void(this.onVisitEnd=()=>this.performNavigation(t,e));await this.hooks.call("visit:abort",this.visit,void 0),delete this.visit.to.document,this.visit.state=8}this.navigating=!0,this.visit=t;const{el:C}=t.trigger;e.referrer=e.referrer||this.currentPageUrl,!1===e.animate&&(t.animation.animate=!1),t.animation.animate||this.classes.clear();const $=e.history||(null==C?void 0:C.getAttribute("data-swup-history"))||void 0;$&&["push","replace"].includes($)&&(t.history.action=$);const j=e.animation||(null==C?void 0:C.getAttribute("data-swup-animation"))||void 0;var F,K;j&&(t.animation.name=j),"object"==typeof e.cache?(t.cache.read=null!=(F=e.cache.read)?F:t.cache.read,t.cache.write=null!=(K=e.cache.write)?K:t.cache.write):void 0!==e.cache&&(t.cache={read:!!e.cache,write:!!e.cache}),delete e.cache;try{await this.hooks.call("visit:start",t,void 0),t.state=3;const C=this.hooks.call("page:load",t,{options:e},(async(t,e)=>{let C;return t.cache.read&&(C=this.cache.get(t.to.url)),e.page=C||await this.fetchPage(t.to.url,e.options),e.cache=!!C,e.page}));if(C.then((({html:e})=>{t.advance(5),t.to.html=e,t.to.document=(new DOMParser).parseFromString(e,"text/html")})),!t.history.popstate){const e=t.to.url+t.to.hash;"replace"===t.history.action||t.to.url===this.currentPageUrl?r(e):(this.currentHistoryIndex++,o(e,{index:this.currentHistoryIndex}))}if(this.currentPageUrl=n(),t.history.popstate&&this.classes.add("is-popstate"),t.animation.name&&this.classes.add(`to-${s(t.animation.name)}`),t.animation.wait&&await C,t.done)return;if(await this.hooks.call("visit:transition",t,void 0,(async()=>{if(!t.animation.animate)return await this.hooks.call("animation:skip",void 0),void await this.renderPage(t,await C);t.advance(4),await this.animatePageOut(t),t.animation.native&&document.startViewTransition?await document.startViewTransition((async()=>await this.renderPage(t,await C))).finished:await this.renderPage(t,await C),await this.animatePageIn(t)})),t.done)return;await this.hooks.call("visit:end",t,void 0,(()=>this.classes.clear())),t.state=7,this.navigating=!1,this.onVisitEnd&&(this.onVisitEnd(),this.onVisitEnd=void 0)}catch(e){if(!e||null!=e&&e.aborted)return void(t.state=8);t.state=9,console.error(e),this.options.skipPopStateHandling=()=>(window.location.assign(t.to.url+t.to.hash),!0),window.history.back()}finally{delete t.to.document}}const V=async function(t){await this.hooks.call("animation:out:start",t,void 0,(()=>{this.classes.add("is-changing","is-animating","is-leaving")})),await this.hooks.call("animation:out:await",t,{skip:!1},((t,{skip:e})=>{if(!e)return this.awaitAnimations({selector:t.animation.selector})})),await this.hooks.call("animation:out:end",t,void 0)},I=function(t){var e;const C=t.to.document;if(!C)return!1;const $=(null==(e=C.querySelector("title"))?void 0:e.innerText)||"";document.title=$;const j=m('[data-swup-persist]:not([data-swup-persist=""])'),F=t.containers.map((t=>{const e=document.querySelector(t),$=C.querySelector(t);return e&&$?(e.replaceWith($.cloneNode(!0)),!0):(e||console.warn(`[swup] Container missing in current document: ${t}`),$||console.warn(`[swup] Container missing in incoming document: ${t}`),!1)})).filter(Boolean);return j.forEach((t=>{const e=t.getAttribute("data-swup-persist"),C=p(`[data-swup-persist="${e}"]`);C&&C!==t&&C.replaceWith(t)})),F.length===t.containers.length},L=function(t){const e={behavior:"auto"},{target:C,reset:$}=t.scroll,j=null!=C?C:t.to.hash;let F=!1;return j&&(F=this.hooks.callSync("scroll:anchor",t,{hash:j,options:e},((t,{hash:e,options:C})=>{const $=this.getAnchorElement(e);return $&&$.scrollIntoView(C),!!$}))),$&&!F&&(F=this.hooks.callSync("scroll:top",t,{options:e},((t,{options:e})=>(window.scrollTo(i({top:0,left:0},e)),!0)))),F},T=async function(t){if(t.done)return;const e=this.hooks.call("animation:in:await",t,{skip:!1},((t,{skip:e})=>{if(!e)return this.awaitAnimations({selector:t.animation.selector})}));await w(),await this.hooks.call("animation:in:start",t,void 0,(()=>{this.classes.remove("is-animating")})),await e,await this.hooks.call("animation:in:end",t,void 0)},N=async function(t,e){if(t.done)return;t.advance(6);const{url:C}=e;this.isSameResolvedUrl(n(),C)||(r(C),this.currentPageUrl=n(),t.to.url=this.currentPageUrl),await this.hooks.call("content:replace",t,{page:e},((t,{})=>{if(this.classes.remove("is-leaving"),t.animation.animate&&this.classes.add("is-rendering"),!this.replaceContent(t))throw new Error("[swup] Container mismatch, aborting");t.animation.animate&&(this.classes.add("is-changing","is-animating","is-rendering"),t.animation.name&&this.classes.add(`to-${s(t.animation.name)}`))})),await this.hooks.call("content:scroll",t,void 0,(()=>this.scrollToContent(t))),await this.hooks.call("page:view",t,{url:this.currentPageUrl,title:document.title})},O=function(t){var e;if(e=t,Boolean(null==e?void 0:e.isSwupPlugin)){if(t.swup=this,!t._checkRequirements||t._checkRequirements())return t._beforeMount&&t._beforeMount(),t.mount(),this.plugins.push(t),this.plugins}else console.error("Not a swup plugin instance",t)};function D(t){const e=this.findPlugin(t);if(e)return e.unmount(),e._afterUnmount&&e._afterUnmount(),this.plugins=this.plugins.filter((t=>t!==e)),this.plugins;console.error("No such plugin",e)}function M(t){return this.plugins.find((e=>e===t||e.name===t||e.name===`Swup${String(t)}`))}function W(t){if("function"!=typeof this.options.resolveUrl)return console.warn("[swup] options.resolveUrl expects a callback function."),t;const e=this.options.resolveUrl(t);return e&&"string"==typeof e?e.startsWith("//")||e.startsWith("http")?(console.warn("[swup] options.resolveUrl needs to return a relative url"),t):e:(console.warn("[swup] options.resolveUrl needs to return a url"),t)}function B(t,e){return this.resolveUrl(t)===this.resolveUrl(e)}const j={animateHistoryBrowsing:!1,animationSelector:'[class*="transition-"]',animationScope:"html",cache:!0,containers:["#swup"],ignoreVisit:(t,{el:e}={})=>!(null==e||!e.closest("[data-no-swup]")),linkSelector:"a[href]",linkToSelf:"scroll",native:!1,plugins:[],resolveUrl:t=>t,requestHeaders:{"X-Requested-With":"swup",Accept:"text/html, application/xhtml+xml"},skipPopStateHandling:t=>{var e;return"swup"!==(null==(e=t.state)?void 0:e.source)},timeout:0};class _{constructor(t={}){var e,C;this.version="4.6.0",this.options=void 0,this.defaults=j,this.plugins=[],this.visit=void 0,this.cache=void 0,this.hooks=void 0,this.classes=void 0,this.currentPageUrl=n(),this.currentHistoryIndex=void 0,this.clickDelegate=void 0,this.navigating=!1,this.onVisitEnd=void 0,this.use=O,this.unuse=D,this.findPlugin=M,this.log=()=>{},this.navigate=q,this.performNavigation=R,this.createVisit=E,this.delegateEvent=a,this.fetchPage=u,this.awaitAnimations=x,this.renderPage=N,this.replaceContent=I,this.animatePageIn=T,this.animatePageOut=V,this.scrollToContent=L,this.getAnchorElement=U,this.getCurrentUrl=n,this.resolveUrl=W,this.isSameResolvedUrl=B,this.options=i({},this.defaults,t),this.handleLinkClick=this.handleLinkClick.bind(this),this.handlePopState=this.handlePopState.bind(this),this.cache=new d(this),this.classes=new b(this),this.hooks=new P(this),this.visit=this.createVisit({to:""}),this.currentHistoryIndex=null!=(e=null==(C=window.history.state)?void 0:C.index)?e:1,this.checkRequirements()&&this.enable()}checkRequirements(){return"undefined"!=typeof Promise||(console.warn("Promise is not supported"),!1)}async enable(){var t;const{linkSelector:e}=this.options;this.clickDelegate=this.delegateEvent(e,"click",this.handleLinkClick),window.addEventListener("popstate",this.handlePopState),this.options.animateHistoryBrowsing&&(window.history.scrollRestoration="manual"),this.options.native=this.options.native&&!!document.startViewTransition,this.options.plugins.forEach((t=>this.use(t))),"swup"!==(null==(t=window.history.state)?void 0:t.source)&&r(null,{index:this.currentHistoryIndex}),await w(),await this.hooks.call("enable",void 0,void 0,(()=>{const t=document.documentElement;t.classList.add("swup-enabled"),t.classList.toggle("swup-native",this.options.native)}))}async destroy(){this.clickDelegate.destroy(),window.removeEventListener("popstate",this.handlePopState),this.cache.clear(),this.options.plugins.forEach((t=>this.unuse(t))),await this.hooks.call("disable",void 0,void 0,(()=>{const t=document.documentElement;t.classList.remove("swup-enabled"),t.classList.remove("swup-native")})),this.hooks.clear()}shouldIgnoreVisit(t,{el:e,event:C}={}){const{origin:$,url:j,hash:F}=l.fromUrl(t);return $!==window.location.origin||!(!e||!this.triggerWillOpenNewWindow(e))||!!this.options.ignoreVisit(j+F,{el:e,event:C})}handleLinkClick(t){const e=t.delegateTarget,{href:C,url:$,hash:j}=l.fromElement(e);if(this.shouldIgnoreVisit(C,{el:e,event:t}))return;if(this.navigating&&$===this.visit.to.url)return void t.preventDefault();const F=this.createVisit({to:$,hash:j,el:e,event:t});t.metaKey||t.ctrlKey||t.shiftKey||t.altKey?this.hooks.callSync("link:newtab",F,{href:C}):0===t.button&&this.hooks.callSync("link:click",F,{el:e,event:t},(()=>{var e;const C=null!=(e=F.from.url)?e:"";t.preventDefault(),$&&$!==C?this.isSameResolvedUrl($,C)||this.performNavigation(F):j?this.hooks.callSync("link:anchor",F,{hash:j},(()=>{r($+j),this.scrollToContent(F)})):this.hooks.callSync("link:self",F,void 0,(()=>{"navigate"===this.options.linkToSelf?this.performNavigation(F):(r($),this.scrollToContent(F))}))}))}handlePopState(t){var e,C,$,j;const F=null!=(e=null==(C=t.state)?void 0:C.url)?e:window.location.href;if(this.options.skipPopStateHandling(t))return;if(this.isSameResolvedUrl(n(),this.currentPageUrl))return;const{url:K,hash:z}=l.fromUrl(F),G=this.createVisit({to:K,hash:z,event:t});G.history.popstate=!0;const X=null!=($=null==(j=t.state)?void 0:j.index)?$:0;X&&X!==this.currentHistoryIndex&&(G.history.direction=X-this.currentHistoryIndex>0?"forwards":"backwards",this.currentHistoryIndex=X),G.animation.animate=!1,G.scroll.reset=!1,G.scroll.target=!1,this.options.animateHistoryBrowsing&&(G.animation.animate=!0,G.scroll.reset=!0),this.hooks.callSync("history:popstate",G,{event:t},(()=>{this.performNavigation(G)}))}triggerWillOpenNewWindow(t){return!!t.matches('[download], [target="_blank"]')}}export{l as Location,s as classify,o as createHistoryRecord,_ as default,a as delegateEvent,y as escapeCssIdentifier,v as forceReflow,n as getCurrentUrl,g as isPromise,h as matchPath,w as nextTick,p as query,m as queryAll,f as runAsPromise,k as toMs,r as updateHistoryRecord};
