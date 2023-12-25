Return-Path: <linux-nfs+bounces-802-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B8481E175
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053071C21010
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7E52F63;
	Mon, 25 Dec 2023 15:50:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6EA52F62;
	Mon, 25 Dec 2023 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.64.80] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 25 Dec 2023 23:49:57 +0800
 (GMT+08:00)
Date: Mon, 25 Dec 2023 23:49:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Simon Horman" <horms@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, 
	"Jeff Layton" <jlayton@kernel.org>, "Neil Brown" <neilb@suse.de>, 
	"Olga Kornievskaia" <kolga@netapp.com>, 
	"Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, 
	"Trond Myklebust" <trond.myklebust@hammerspace.com>, 
	"Anna Schumaker" <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	"Simo Sorce" <simo@redhat.com>, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] SUNRPC: fix some memleaks in gssx_dec_option_array
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231224212754.GB5962@kernel.org>
References: <20231224082424.3539726-1-alexious@zju.edu.cn>
 <20231224212754.GB5962@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1996a76c.53ca7.18ca1ab27ca.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgDHhtSlpIll9EH9AA--.34923W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgEAAGWJUhgFnQADs+
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cgo+IAo+IE9uIFN1biwgRGVjIDI0LCAyMDIzIGF0IDA0OjI0OjIyUE0gKzA4MDAsIFpoaXBlbmcg
THUgd3JvdGU6Cj4gPiBUaGUgY3JlZHMgYW5kIG9hLT5kYXRhIG5lZWQgdG8gYmUgZnJlZWQgaW4g
dGhlIGVycm9yLWhhbmRsaW5nIHBhdGhzIGFmdGVyCj4gPiB0aGVyZSBhbGxvY2F0aW9uLiBTbyB0
aGlzIHBhdGNoIGFkZCB0aGVzZSBkZWFsbG9jYXRpb25zIGluIHRoZQo+ID4gY29ycmVzcG9uZGlu
ZyBwYXRocy4KPiA+IAo+ID4gRml4ZXM6IDFkNjU4MzM2YjA1ZiAoIlNVTlJQQzogQWRkIFJQQyBi
YXNlZCB1cGNhbGwgbWVjaGFuaXNtIGZvciBSUENHU1MgYXV0aCIpCj4gPiBTaWduZWQtb2ZmLWJ5
OiBaaGlwZW5nIEx1IDxhbGV4aW91c0B6anUuZWR1LmNuPgo+IAo+IC4uLgo+IAo+ID4gZGlmZiAt
LWdpdCBhL25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX3JwY194ZHIuYyBiL25ldC9zdW5ycGMvYXV0
aF9nc3MvZ3NzX3JwY194ZHIuYwo+IAo+IC4uLgo+IAo+ID4gQEAgLTI2NSwyOSArMjY1LDQxIEBA
IHN0YXRpYyBpbnQgZ3NzeF9kZWNfb3B0aW9uX2FycmF5KHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIs
Cj4gPiAgCj4gPiAgCQkvKiBvcHRpb24gYnVmZmVyICovCj4gPiAgCQlwID0geGRyX2lubGluZV9k
ZWNvZGUoeGRyLCA0KTsKPiA+IC0JCWlmICh1bmxpa2VseShwID09IE5VTEwpKQo+ID4gLQkJCXJl
dHVybiAtRU5PU1BDOwo+ID4gKwkJaWYgKHVubGlrZWx5KHAgPT0gTlVMTCkpIHsKPiA+ICsJCQll
cnIgPSAtRU5PU1BDCj4gCj4gSGkgWmhpcGVuZyBMdSwKPiAKPiB1bmZvcnR1bmF0ZWx5IHRoZSBs
aW5lIGFib3ZlIGNhdXNlcyBhIGJ1aWxkIGZhaWx1cmUuCj4gCj4gLi4uCgpTb3JyeSBmb3IgbXkg
bWlzdGFrZSwgSSdsbCBzZW5kIGEgdmVyc2lvbiAyIG9mIHRoaXMgcGF0Y2ggc29vbi4K

