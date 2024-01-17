Return-Path: <linux-nfs+bounces-1175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B18300D0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 08:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC351F2508A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F517BE76;
	Wed, 17 Jan 2024 07:54:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB9BBE4C;
	Wed, 17 Jan 2024 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478086; cv=none; b=Y7zVyIswoqBQ/TTeqbI1pBvdwJORSSm7uR03x069+R97NoHm4seJCnH2C4ZMMx8GSnsnkNz3v3liSUEHZosi6JH+tJ09xnPfpAnFQXTEQhLfWgAhl98YBhrbMhYMmnQhgUf5f384XrGgL34rxN5QtQ3BqHBFZCVcK8HbQKOMtOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478086; c=relaxed/simple;
	bh=bft6uYbqYzVjjoyHDm8/hguW0uSZtqXMt+NzZgBgLAg=;
	h=Received:X-Originating-IP:Date:X-CM-HeaderCharset:From:To:Cc:
	 Subject:X-Priority:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam; b=taoDVzeKU9w3qHUDeLVkS3/7vQcHV8UDORJFHmTksffnXL6tD2uYNhIp+jL1WKNr1mG1eedniA8QBYUDfYmZ88x/vV9TmMt9tWjlyoPJN6w8/TnCLkS2lKY7I2vBwM7WjBnLgPbxLWPMAfiVA9MPSIPcF8AMpnmHAc7th6szBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.68.184] ) by
 ajax-webmail-mail-app3 (Coremail) ; Wed, 17 Jan 2024 15:44:45 +0800
 (GMT+08:00)
Date: Wed, 17 Jan 2024 15:44:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
	"Neil Brown" <neilb@suse.de>, "Olga Kornievskaia" <kolga@netapp.com>,
	"Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
	"Trond Myklebust" <trond.myklebust@hammerspace.com>,
	"Anna Schumaker" <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simo Sorce" <simo@redhat.com>,
	"Steve Dickson" <steved@redhat.com>,
	"Kevin Coffman" <kwc@citi.umich.edu>,
	"Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <35F4C7FB-3337-4894-8AA2-C1F4ADCD99C9@oracle.com>
References: <20240112084540.3729001-1-alexious@zju.edu.cn>
 <20240115110905.GR392144@kernel.org>
 <35F4C7FB-3337-4894-8AA2-C1F4ADCD99C9@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7e31d32d.4b14.18d16613364.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgC3LThuhadl66IuAA--.5834W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgIDAGWmzmEYZAAAsT
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gPiBPbiBKYW4gMTUsIDIwMjQsIGF0IDY6MDnigK9BTSwgU2ltb24gSG9ybWFuIDxob3Jtc0Br
ZXJuZWwub3JnPiB3cm90ZToKPiA+IAo+ID4gT24gRnJpLCBKYW4gMTIsIDIwMjQgYXQgMDQ6NDU6
MzhQTSArMDgwMCwgWmhpcGVuZyBMdSB3cm90ZToKPiA+PiBUaGUgY3R4LT5tZWNoX3VzZWQuZGF0
YSBhbGxvY2F0ZWQgYnkga21lbWR1cCBpcyBub3QgZnJlZWQgaW4gbmVpdGhlcgo+ID4+IGdzc19p
bXBvcnRfdjJfY29udGV4dCBub3IgaXQgb25seSBjYWxsZXIgcmFkZW9uX2RyaXZlcl9vcGVuX2tt
cy4KPiA+IAo+ID4gU2hvdWxkIHJhZGVvbl9kcml2ZXJfb3Blbl9rbXMgYmUgZ3NzX2tyYjVfaW1w
b3J0X3NlY19jb250ZXh0Pwo+ID4gCj4gPiBBbHNvLCBwZXJoYXBzIGl0IGlzIHVzZWZ1bCB0byB3
cml0ZSBzb21ldGhpbmcgbGlrZSB0aGlzOgo+ID4gCj4gPiAuLi4gZ3NzX2tyYjVfaW1wb3J0X3Nl
Y19jb250ZXh0LCB3aGljaCBmcmVlcyBjdHggb24gZXJyb3IuCgpZZXMsIHlvdSBhcmUgcmlnaHQs
IEkgcHJvYmVybHkgbWl4ZWQgdXAgaXQgdG8gYW5vdGhlciBwYXRjaCA6KC4KQW5kIHRoZSBmaXJz
dCBzZW50ZW5jZSBvZiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gc2hvdWxkIGJlOgoKVGhlIGN0eC0+
bWVjaF91c2VkLmRhdGEgYWxsb2NhdGVkIGJ5IGttZW1kdXAgaXMgbm90IGZyZWVkIGluIG5laXRo
ZXIKZ3NzX2ltcG9ydF92Ml9jb250ZXh0IG5vciBpdCBvbmx5IGNhbGxlciBnc3Nfa3JiNV9pbXBv
cnRfc2VjX2NvbnRleHQsIAp3aGljaCBmcmVlcyBjdHggb24gZXJyb3IuCgo+IAo+IElmIFpoaXBl
bmcgYWdyZWVzIHRvIHRoaXMgc3VnZ2VzdGlvbiwgSSBjYW4gY2hhbmdlIHRoZQo+IHBhdGNoIGRl
c2NyaXB0aW9uIGluIG15IHRyZWUuIEEgdjMgaXMgbm90IG5lY2Vzc2FyeS4KClllcywgSSBhZ3Jl
ZSB3aXRoIFNpbW9uJ3Mgc3VnZ2VzdGlvbiBhbmQgSSBnaXZlIHRoZSBjb3JyZWN0ZWQgZGVzY3Jp
cHRpb24gCmFib3ZlLgoKPiAKPiA+PiBUaHVzLCB0aGlzIHBhdGNoIHJlZm9ybSB0aGUgbGFzdCBj
YWxsIG9mIGdzc19pbXBvcnRfdjJfY29udGV4dCB0byB0aGUKPiA+PiBnc3Nfa3JiNV9pbXBvcnRf
Y3R4X3YyLCBwcmV2ZW50aW5nIHRoZSBtZW1sZWFrIHdoaWxlIGtlZXBwaW5nIHRoZSByZXR1cm4K
PiA+PiBmb3JtYXRpb24uCj4gPj4gCj4gPj4gRml4ZXM6IDQ3ZDg0ODA3NzYyOSAoImdzc19rcmI1
OiBoYW5kbGUgbmV3IGNvbnRleHQgZm9ybWF0IGZyb20gZ3NzZCIpCj4gPj4gU2lnbmVkLW9mZi1i
eTogWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVkdS5jbj4KPiA+IAo+ID4gSGkgWmhpcGVuZyBM
dSwKPiA+IAo+ID4gT3RoZXIgdGhhbiB0aGUgY29tbWVudCBhYm92ZSwgSSBhZ3JlZSB3aXRoIHlv
dXIgYW5hbHlzaXMuCj4gPiBBbmQgdGhhdCBhbHRob3VnaCB0aGUgcHJvYmxlbSBoYXMgY2hhbmdl
ZCBmb3JtIHNsaWdodGx5LAo+ID4gaXQgd2FzIG9yaWdpbmFsbHkgaW50cm9kdWNlZCBieSB0aGUg
Y2l0ZWQgY29tbWl0Lgo+ID4gSSBhbHNvIGFncmVlIHRoYXQgeW91ciBmaXguCj4gPiAKPiA+IC4u
Lgo+IAo+IC0tCj4gQ2h1Y2sgTGV2ZXIKPiAKPiAK

