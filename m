Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFA421ADE
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 01:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhJDXyX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 19:54:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDXyX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Oct 2021 19:54:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B13DF2230C;
        Mon,  4 Oct 2021 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633391552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4tvvGRYxnfXXchSCSLhlJIRj3/+mWmTCgemZvUPvRFU=;
        b=XZN9cImDPbruzVKfUsRGF7iBU3X8Gd9P4fcqLx2ZR+UA4tqpIEmvdOcmYISFqukUeGMnDZ
        xP9pHKEBEnh2OXYfsHppuHkBGT0pman6Tvh+vFxRDGAahLAVG2afSmi6v1Y28O3I1ArZ3D
        cl3o7kQTN0xDI/GYtYEBrKKytYsDXdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633391552;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4tvvGRYxnfXXchSCSLhlJIRj3/+mWmTCgemZvUPvRFU=;
        b=p0O1F94PEDvRNZoZ0I2lhw2Va856tgYJZyBXIdwcKsF2F2QnNDOeNKnkwWG3dDrExpqg74
        Q3K1BkfYzjsQAaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CBCB13A65;
        Mon,  4 Oct 2021 23:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NoyRFr+TW2FZVgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 04 Oct 2021 23:52:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: fix minor issues with automount expiry.
In-reply-to: <c5d29af93a55854b831d519b01c8f3e29e62fb50.camel@hammerspace.com>
References: <162742773175.21659.17666555162574585184@noble.neil.brown.name>,
 <c5d29af93a55854b831d519b01c8f3e29e62fb50.camel@hammerspace.com>
Date:   Tue, 05 Oct 2021 10:52:28 +1100
Message-id: <163339154883.31063.11931124996892360350@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAwNCBPY3QgMjAyMSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFdlZCwgMjAy
MS0wNy0yOCBhdCAwOToxNSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gCj4gPiAxLyBJZiBh
dXRvbW91bnQgZXhwaXJ5IHRpbWVvdXQgaXMgc2V0IHRvIHplcm8sIG5ldyBtb3VudHMgYXJlIG5v
dAo+ID4gYWRkZWQKPiA+IMKgwqAgdG8gdGhlIGxpc3QuwqAgSWYgdGhlIHRpbWVvdXQgaXMgdGhl
biBjaGFuZ2VkLCB0aG9zZSBwcmV2aW91c2x5Cj4gPiDCoMKgIG1vdW50cyB3aWxsIHN0aWxsIG5v
dCBiZSB0aW1lZCBvdXQuwqAgVGhpcyBpcyBwcm9iYWJseSBub3Qgd2hhdAo+ID4gwqDCoCB3b3Vs
ZCBiZSBleHBlY3RlZC7CoCBTaW1wbHkgcmVmdXNpbmcgdG8gc3RhcnQgdGhlIHRpbWVyCj4gPiDC
oMKgIGlzIHN1ZmZpY2llbnQgdG8gcHJldmVudCB0aW1lb3V0Lgo+ID4gCj4gPiAyLyB0aGUgTU9E
VUxFX1BBUk1fREVTQyBmb3IgbmZzX21vdW50cG9pbnRfZXhwaXJ5X3RpbWVvdXQgaXMgbWlzc2lu
Zwo+ID4gwqDCoCBhIHNwYWNlIGJldHdlZW4gdG8gdHdvIHNlbnRlbmNlcy7CoCBUaGlzIGlzIGhp
ZGRlbiBieSB0aGUgZmFjdCB0aGF0Cj4gPiDCoMKgIHRoZSBzdHJpbmcgaXMgYnJva2VuIG9udG8g
dG8gbGluZSAtIGFnYWluc3QgY3VycmVudCBwb2xpY3kuCj4gPiDCoMKgIFNvIGpvaW4gb250byBh
IHNpbmdsZSAobG9uZykgbGluZSwgYW5kIGFkZCB0aGUgc3BhY2UuCj4gPiAKPiA+IFNpZ25lZC1v
ZmYtYnk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4KPiA+IC0tLQo+ID4gwqBmcy9uZnMvbmFt
ZXNwYWNlLmMgfCA1ICsrLS0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmFtZXNwYWNlLmMg
Yi9mcy9uZnMvbmFtZXNwYWNlLmMKPiA+IGluZGV4IGJjMGM2OThmMzM1MC4uYmU1ZTc3YTgwODEx
IDEwMDY0NAo+ID4gLS0tIGEvZnMvbmZzL25hbWVzcGFjZS5jCj4gPiArKysgYi9mcy9uZnMvbmFt
ZXNwYWNlLmMKPiA+IEBAIC0xOTYsMTAgKzE5NiwxMCBAQCBzdHJ1Y3QgdmZzbW91bnQgKm5mc19k
X2F1dG9tb3VudChzdHJ1Y3QgcGF0aAo+ID4gKnBhdGgpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdvdG8gb3V0X2ZjOwo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBtbnRn
ZXQobW50KTsgLyogcHJldmVudCBpbW1lZGlhdGUgZXhwaXJhdGlvbiAqLwo+ID4gK8KgwqDCoMKg
wqDCoMKgbW50X3NldF9leHBpcnkobW50LCAmbmZzX2F1dG9tb3VudF9saXN0KTsKPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAodGltZW91dCA8PSAwKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIG91dF9mYzsKPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqBtbnRfc2V0X2V4
cGlyeShtbnQsICZuZnNfYXV0b21vdW50X2xpc3QpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHNjaGVk
dWxlX2RlbGF5ZWRfd29yaygmbmZzX2F1dG9tb3VudF90YXNrLCB0aW1lb3V0KTsKPiAKPiBOQUNL
Lgo+IAo+IFRoZSBleGlzdGluZyBjb2RlIGlzIHZlcnkgZGVsaWJlcmF0ZSBhYm91dCBfbm90XyBh
ZGRpbmcgdGhlIG1vdW50cG9pbnQKPiB0byB0aGUgZXhwaXJhdGlvbiBsaXN0IGlmIHRoZSB0aW1l
b3V0IGlzIG5lZ2F0aXZlIG9yIHplcm8uIFRoYXQncyB0aGUKPiB3aG9sZSBwb2ludC4gQ2hhbmdp
bmcgdGhlIHRpbWVvdXQgdmFsdWUgYWZ0ZXIgdGhlIGZhY3QgaXMgbm90IHN1cHBvc2VkCj4gdG8g
YWZmZWN0IHRoZSBzdGF0ZSBvZiB0aG9zZSBtb3VudHBvaW50cy4KPiAKClRoYW5rcyBmb3IgdGhl
IHJlcGx5LgpJdCBqdXN0IHNlZW1lZCBvZGQgdGhhdCBzZXR0aW5nIDw9IDAgd291bGQgdHVybiBl
eHBpcnkgb2ZmIGZvciBhbGwKbW91bnRzLCBidXQgc2V0dGluZyBpbiA+IDAgd291bGQgb25seSB0
dXJuIGl0IGJhY2sgb24gZm9yIHNvbWUgbW91bnRzLgpUaG9zZSB0aGF0IHdlcmUgYXV0by1tb3Vu
dGVkIGJlZm9yZSBpdCB3YXMgc2V0IDw9IDAuCkl0J3Mgbm90IHJlYWxseSBpbXBvcnRhbnQgdGhv
dWdoLgoKVGhhbmtzLApOZWlsQnJvd24K
