Return-Path: <linux-nfs+bounces-808-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022381E619
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Dec 2023 10:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AADE1F226E7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Dec 2023 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262A4CDF6;
	Tue, 26 Dec 2023 09:02:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C84CB58;
	Tue, 26 Dec 2023 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [124.90.106.3] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 26 Dec 2023 17:01:05 +0800
 (GMT+08:00)
Date: Tue, 26 Dec 2023 17:01:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Trond Myklebust" <trond.myklebust@hammerspace.com>, 
	"Anna Schumaker" <anna@kernel.org>, 
	"Jeff Layton" <jlayton@kernel.org>, "Neil Brown" <neilb@suse.de>, 
	"Olga Kornievskaia" <kolga@netapp.com>, 
	"Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Simo Sorce" <simo@redhat.com>, 
	"Steve Dickson" <steved@redhat.com>, 
	"Kevin Coffman" <kwc@citi.umich.edu>, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: fix a memleak in gss_import_v2_context
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZYhivG2MxmtePvo3@tissot.1015granger.net>
References: <20231224082035.3538560-1-alexious@zju.edu.cn>
 <ZYhivG2MxmtePvo3@tissot.1015granger.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <45874bb1.58022.18ca55b2eab.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgBnb3NSloplDFl9AQ--.44789W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgIBAGWJUhg7uQAAsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBPbiBTdW4sIERlYyAyNCwgMjAyMyBhdCAwNDoyMDozM1BNICswODAwLCBaaGlwZW5nIEx1IHdy
b3RlOgo+ID4gVGhlIGN0eC0+bWVjaF91c2VkLmRhdGEgYWxsb2NhdGVkIGJ5IGttZW1kdXAgaXMg
bm90IGZyZWVkIGluIG5laXRoZXIKPiA+IGdzc19pbXBvcnRfdjJfY29udGV4dCBub3IgaXQgb25s
eSBjYWxsZXIgcmFkZW9uX2RyaXZlcl9vcGVuX2ttcy4KPiA+IFRodXMsIHRoaXMgcGF0Y2ggcmVm
b3JtIHRoZSBsYXN0IGNhbGwgb2YgZ3NzX2ltcG9ydF92Ml9jb250ZXh0IHRvIHRoZQo+ID4gZ3Nz
X2tyYjVfaW1wb3J0X2N0eF92MiwgcHJldmVudGluZyB0aGUgbWVtbGVhayB3aGlsZSBrZWVwcGlu
ZyB0aGUgcmV0dXJuCj4gPiBmb3JtYXRpb24uCj4gPiAKPiA+IEZpeGVzOiA0N2Q4NDgwNzc2Mjkg
KCJnc3Nfa3JiNTogaGFuZGxlIG5ldyBjb250ZXh0IGZvcm1hdCBmcm9tIGdzc2QiKQo+ID4gU2ln
bmVkLW9mZi1ieTogWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVkdS5jbj4KPiA+IC0tLQo+ID4g
IG5ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfbWVjaC5jIHwgOSArKysrKysrKy0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRp
ZmYgLS1naXQgYS9uZXQvc3VucnBjL2F1dGhfZ3NzL2dzc19rcmI1X21lY2guYyBiL25ldC9zdW5y
cGMvYXV0aF9nc3MvZ3NzX2tyYjVfbWVjaC5jCj4gPiBpbmRleCBlMzFjZmRmN2VhZGMuLjFlNTRi
ZDYzZTNmMCAxMDA2NDQKPiA+IC0tLSBhL25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfbWVj
aC5jCj4gPiArKysgYi9uZXQvc3VucnBjL2F1dGhfZ3NzL2dzc19rcmI1X21lY2guYwo+ID4gQEAg
LTM5OCw2ICszOTgsNyBAQCBnc3NfaW1wb3J0X3YyX2NvbnRleHQoY29uc3Qgdm9pZCAqcCwgY29u
c3Qgdm9pZCAqZW5kLCBzdHJ1Y3Qga3JiNV9jdHggKmN0eCwKPiA+ICAJdTY0IHNlcV9zZW5kNjQ7
Cj4gPiAgCWludCBrZXlsZW47Cj4gPiAgCXUzMiB0aW1lMzI7Cj4gPiArCWludCByZXQ7Cj4gPiAg
Cj4gPiAgCXAgPSBzaW1wbGVfZ2V0X2J5dGVzKHAsIGVuZCwgJmN0eC0+ZmxhZ3MsIHNpemVvZihj
dHgtPmZsYWdzKSk7Cj4gPiAgCWlmIChJU19FUlIocCkpCj4gPiBAQCAtNDUwLDggKzQ1MSwxNCBA
QCBnc3NfaW1wb3J0X3YyX2NvbnRleHQoY29uc3Qgdm9pZCAqcCwgY29uc3Qgdm9pZCAqZW5kLCBz
dHJ1Y3Qga3JiNV9jdHggKmN0eCwKPiA+ICAJfQo+ID4gIAljdHgtPm1lY2hfdXNlZC5sZW4gPSBn
c3Nfa2VyYmVyb3NfbWVjaC5nbV9vaWQubGVuOwo+ID4gIAo+ID4gLQlyZXR1cm4gZ3NzX2tyYjVf
aW1wb3J0X2N0eF92MihjdHgsIGdmcF9tYXNrKTsKPiA+ICsJcmV0ID0gZ3NzX2tyYjVfaW1wb3J0
X2N0eF92MihjdHgsIGdmcF9tYXNrKTsKPiA+ICsJaWYgKHJldCkgewo+ID4gKwkJcCA9IEVSUl9Q
VFIocmV0KTsKPiA+ICsJCWdvdG8gb3V0X2ZyZWU7Cj4gPiArCX07Cj4gPiAgCj4gPiArb3V0X2Zy
ZWU6Cj4gPiArCWtmcmVlKGN0eC0+bWVjaF91c2VkLmRhdGEpOwo+IAo+IElmIHRoZSBjYWxsZXIn
cyBlcnJvciBmbG93IGRvZXMgbm90IGludm9rZQo+IGdzc19rcmI1X2RlbGV0ZV9zZWNfY29udGV4
dCgpLCB0aGVuIEkgd291bGQgZXhwZWN0IG1vcmUgdGhhbiBqdXN0Cj4gbWVjaF91c2VkLmRhdGEg
d291bGQgYmUgbGVha2VkLiBXaGF0IGlmLCBpbnN0ZWFkLCB5b3UgY2hhbmdlZAo+IGdzc19rcmI1
X2ltcG9ydF9zZWNfY29udGV4dCgpIGxpa2UgdGhpcyAodW50ZXN0ZWQpOgo+IAo+IDQ3MSAgICAg
ICAgIHJldCA9IGdzc19pbXBvcnRfdjJfY29udGV4dChwLCBlbmQsIGN0eCwgZ2ZwX21hc2spOwo+
IDQ3MiAgICAgICAgIG1lbXplcm9fZXhwbGljaXQoJmN0eC0+S3Nlc3MsIHNpemVvZihjdHgtPktz
ZXNzKSk7Cj4gNDczICAgICAgICAgaWYgKHJldCkgeyAgICAgIAo+ICAgIC0gICAgICAgICAgICAg
ICAga2ZyZWUoY3R4KTsgICAgICAgICAgICAgICAgICAgICAgCj4gICAgKyAgICAgICAgICAgICAg
ICBnc3Nfa3JiNV9kZWxldGVfc2VjX2NvbnRleHQoY3R4KTsKPiA0NzUgICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7Cj4gNDc2ICAgICAgICAgfSAgICAKPiAKPiBPYnZpb3VzbHkgeW91IHdvdWxk
IG5lZWQgdG8gYWRkIGEgZm9yd2FyZCBkZWNsYXJhdGlvbiBvZgo+IGdzc19rcmI1X2ltcG9ydF9z
ZWNfY29udGV4dCgpIHRvIG1ha2UgdGhpcyBjb21waWxlLiBUaGUgcXVlc3Rpb24KPiBpcyB3aGV0
aGVyIGdzc19rcmI1X2RlbGV0ZV9zZWNfY29udGV4dCgpIHdpbGwgZGVhbCB3aXRoIGEgcGFydGlh
bGx5LQo+IGluaXRpYWxpemVkIEBjdHguCgpTaW5jZSB0aGUgY3R4IGlzIGFsbG9jYXRlZCBqdXN0
IGluIGdzc19rcmI1X2ltcG9ydF9zZWNfY29udGV4dCwgCnRvZ2V0aGVyIHdpdGggdGhhdCBhbGwg
b2YgZ3NzX2tyYjVfaW1wb3J0X3NlY19jb250ZXh0LCBnc3NfaW1wb3J0X3YyX2NvbnRleHQod2l0
aCB0aGlzIHBhdGNoKQphbmQgZ3NzX2tyYjVfaW1wb3J0X2N0eF92MiBhcmUgYWxsb2NhdGlvbi1m
cmVlIGJhbGFuY2VkLiBJdCBzZWVtcyB0aGF0IHdlIGRvbid0IG5lZWQgdG8gCnJlbGVhc2UgYW55
dGhpbmcgZWxzZSBieSBpbnZva2luZyBnc3Nfa3JiNV9kZWxldGVfc2VjX2NvbnRleHQuCgpJZiBJ
IG1pc3Mgc29tZXRoaW5nIGxlYWtlZCwgcGxlYXNlIGxldCBtZSBrbm93LgoKCj4gCj4gSG93IGRp
ZCB5b3UgZmluZCB0aGlzIGxlYWssIGFuZCB3aGF0IGtpbmQgb2YgdGVzdGluZyB3YXMgZG9uZSB0
bwo+IGNvbmZpcm0gdGhlIGZpeCBpcyBzYWZlPwoKSSBmb3VuZCB0aGlzIG1lbWxlYWsgYnkgc3Rh
dGljIGFuYWx5c2lzLiAKVGhlIHNhZmV0eSBpc3N1ZSBjYW4ndCBiZSBzb2x2ZWQgYnkgYXV0b21h
dGljIHRvb2xzIGFzIGZhciBhcyBJIGtub3cuClNvIEkgY2hlY2sgcGF0Y2hlcyBtYW51ZWxseSBi
ZWZvcmUgc2VuZGluZyBwYXRjaGVzLgoKPiA+ICBvdXRfZXJyOgo+ID4gIAlyZXR1cm4gUFRSX0VS
UihwKTsKPiA+ICB9Cj4gPiAtLSAKPiA+IDIuMzQuMQo+ID4gCj4gCj4gLS0gCj4gQ2h1Y2sgTGV2
ZXIK

