Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4F5A32B7
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Aug 2022 01:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiHZXja (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZXj3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 19:39:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4EEE3C25
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 16:39:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87AEA33719;
        Fri, 26 Aug 2022 23:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661557167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTrxAE8eQF9rIJ7gQKGtdjHsa2QTs6QVii3gO3axYQg=;
        b=c1iNrOQZgYrk81IOU9h3qVr6uB8COnnfHvl0CzljV7aacrGW920jqhCK06aolH4a6e4O33
        JBwB0PdkavmxoYhxM3swAj6RAjteLqlprPSnEq8dPyKmr5LuIjvZ9i8VUIZ0V1FjJ6LVR/
        cRyMj/JpIGgHDJiVLbk8bEj8hN5DKC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661557167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTrxAE8eQF9rIJ7gQKGtdjHsa2QTs6QVii3gO3axYQg=;
        b=UIRhjLiwf5/sohPHbdjwXb/DKR5XKLRUCpG1BYqZLEppXda0sNaGpWLujZwfSM/vE3ixYY
        0kAzJuOYVo4vVFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2695C13421;
        Fri, 26 Aug 2022 23:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0TyqNK1ZCWOXeQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 23:39:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>,
 <165274950799.17247.7605561502483278140@noble.neil.brown.name>,
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>,
 <165275056203.17247.1826100963816464474@noble.neil.brown.name>,
 <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>,
 <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>,
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
Date:   Sat, 27 Aug 2022 09:39:21 +1000
Message-id: <166155716162.27490.17801636432417958045@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyNyBBdWcgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIEZyaSwgMjAy
Mi0wOC0yNiBhdCAxMDo1OSAtMDQwMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToKPiA+IE9u
IDE2IE1heSAyMDIyLCBhdCAyMTozNiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiBTbyB1
bnRpbCB5b3UgaGF2ZSBhIGRpZmZlcmVudCBzb2x1dGlvbiB0aGF0IGRvZXNuJ3QgaW1wYWN0IHRo
ZQo+ID4gPiBjbGllbnQncwo+ID4gPiBhYmlsaXR5IHRvIGNhY2hlIHBlcm1pc3Npb25zLCB0aGVu
IHRoZSBhbnN3ZXIgaXMgZ29pbmcgdG8gYmUgIm5vIgo+ID4gPiB0bwo+ID4gPiB0aGVzZSBwYXRj
aGVzLgo+ID4gCj4gPiBIaSBUcm9uZCwKPiA+IAo+ID4gV2UgaGF2ZSBzb21lIGZvbGtzIG5lZ2F0
aXZlbHkgaW1wYWN0ZWQgYnkgdGhpcyBpc3N1ZSBhcyB3ZWxsLsKgIEFyZQo+ID4geW91Cj4gPiB3
aWxsaW5nIHRvIGNvbnNpZGVyIHRoaXMgdmlhIGEgbW91bnQgb3B0aW9uPwo+ID4gCj4gPiBCZW4K
PiA+IAo+IAo+IEkgZG9uJ3Qgc2VlIGhvdyB0aGF0IGFuc3dlcnMgbXkgY29uY2Vybi4KCkNvdWxk
IHlvdSBwbGVhc2Ugc3BlbGwgb3V0IGFnYWluIHdoYXQgeW91ciBjb25jZXJucyBhcmU/ICBJIHN0
aWxsIGRvbid0CnVuZGVyc3RhbmQuIApUaGUgb25seSBwZXJmb3JtYW5jZSBpbXBhY3QgaXMgd2hl
biBhIHBlcm1pc3Npb24gdGVzdCBmYWlscy4gIEluIHdoYXQKY2lyY3Vtc3RhbmNlIGlzIHBlcm1p
c3Npb24gZmFpbHVyZSBleHBlY3RlZCBvbiBhIGZhc3QtcGF0aD8KCj4gCj4gSSdkIHJhdGhlciBz
ZWUgdXMgc2V0IHVwIGFuIGV4cGxpY2l0IHRyaWdnZXIgbWVjaGFuaXNtLiBJdCBkb2Vzbid0IGhh
dmUKPiB0byBiZSBwYXJ0aWN1bGFybHkgc29waGlzdGljYXRlZC4gSSBjYW4gaW1hZ2luZSBqdXN0
IGhhdmluZyBhIGdsb2JhbCwKPiBvciBtb3JlIGxpa2VseSBhIHBlci1jb250YWluZXIsIGNvb2tp
ZSB0aGF0IGhhcyBhIGNvbnRyb2wgbWVjaGFuaXNtIGluCj4gL3N5cy9mcy9uZnMsIGFuZCB0aGF0
IGNhbiBiZSB1c2VkIHRvIG9yZGVyIGFsbCB0aGUgaW5vZGVzIHRvIGludmFsaWRhdGUKPiB0aGVp
ciBwZXJtaXNzaW9ucyBjYWNoZXMgd2hlbiB5b3UgYmVsaWV2ZSB0aGVyZSBpcyBhIG5lZWQgdG8g
ZG8gc28uCgpJIGhvcGUgaXQgd291bGQgb25seSBpbnZhbGlkYXRlIG5lZ2F0aXZlIGNhY2hlZCBw
ZXJtaXNzaW9ucywgbm90CnBvc2l0aXZlLgpDYWNoZXMgcG9zaXRpdmUgcGVybWlzc2lvbnMgYXJl
bid0IHJlYWxseSBhIHByb2JsZW0gYXMgd2UnbGwgZmluZCBvdXQKdGhleSB3ZXJlIHdyb25nIGFz
IHNvb24gYXMgd2Ugc2VuZCB0aGUgcmVsZXZhbnQgcmVxdWVzdCB0byB0aGUgc2VydmVyLgpUaGUg
cHJvYmxlbSB3aXRoIGNhY2hlZCBuZWdhdGl2ZSBwZXJtaXNzaW9ucyBpcyB0aGF0IHdlIG5ldmVy
IGV2ZW4gdHJ5CnRvIHNlbmQgYSByZXF1ZXN0IHRvIHRoZSBzZXJ2ZXIuCgpUaGUgY2xpZW50IGRv
ZXNuJ3QgKmtub3cqIHdoZW4gdGhlIHNlcnZlciBjaGFuZ2VzIGl0J3MgdW5kZXJzdGFuZGluZyBv
Zgpncm91cCBtZW1iZXJzaGlwLCBzbyBpdCBjYW5ub3Qga25vdyB3aGVuIHRvIHdyaXRlIHRvIHRo
aXMuICBTbyB0aGUgYmVzdAp0aGUgY2xpZW50IGNhbiBkbyBpcyBpbnZhbGlkYXRlIG5lZ2F0aXZl
IGNhY2hlZCBwZXJtaXNzaW9ucwpwZXJpb2RpY2FsbHkuICBTbyBpZiB0aGlzIC9zeXMvZnMvbmZz
LyB0dW5hYmxlIHdlcmUgdG8gYmUgYWRkZWQsIEkgd291bGQKbGlrZSBpdCB0byBiZSBhIHRpbWUg
aW50ZXJ2YWwgYWZ0ZXIgd2hpY2ggdGhleSBjYW4gZXhwaXJlIChJIHdvdWxkIHNldCBpdAp0byB6
ZXJvIG9mIGNvdXJzZSkuCgpUaGFua3MsCk5laWxCcm93bgoKPiAKPiBpLmUuIHlvdSBjYWNoZSB0
aGUgdmFsdWUgb2YgdGhlIGdsb2JhbCBjb29raWUgaW4gdGhlIGlub2RlLCBhbmQgaWYgeW91Cj4g
bm90aWNlIGEgY2hhbmdlLCB0aGVuIHRoYXQncyB0aGUgc2lnbmFsIHRoYXQgeW91IG5lZWQgdG8g
aW52YWxpZGF0ZSB0aGUKPiBwZXJtaXNzaW9ucyBjYWNoZSBiZWZvcmUgdXBkYXRpbmcgdGhlIGNh
Y2hlZCB2YWx1ZSBvZiB0aGUgY29va2llLgo+IAo+IFRoYXQgd2F5LCB5b3UgaGF2ZSBhIG1lY2hh
bmlzbSB0aGF0IHNlcnZlcyBhbGwgcHVycG9zZXM6IGl0IGNhbiBkbyBhbgo+IGltbWVkaWF0ZSBv
bmUtdGltZSBvbmx5IGZsdXNoLCBvciB5b3UgY2FuIHNldCB1cCBhIHVzZXJzcGFjZSBqb2IgdGhh
dAo+IGlzc3VlcyBhIGdsb2JhbCBmbHVzaCBvbmNlIGV2ZXJ5IHNvIG9mdGVuLCBlLmcuIHVzaW5n
IGEgY3JvbiBqb2IuCj4gCj4gLS0gCj4gVHJvbmQgTXlrbGVidXN0Cj4gTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQo+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20KPiAKPiAKPiAK
