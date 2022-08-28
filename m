Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4445A402A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 01:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiH1XcS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Aug 2022 19:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH1XcR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Aug 2022 19:32:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF482ED68
        for <linux-nfs@vger.kernel.org>; Sun, 28 Aug 2022 16:32:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA1F4337E8;
        Sun, 28 Aug 2022 23:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661729533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wb/PDEsKkXSW9tFyWROa8/kumcMUzFjGtj7cKerHg2Q=;
        b=INKfKiGm9OiPhSOyCssdhMFAMvdj2S5UUDeSynDBMZJ5TzAPMphGK+lmTHDZrJSdYdg+pm
        HLvKr5jdccDmGRCOCJMeRKTLSBdrMuUCF3CQtM+7lw8cE0Ow/xWHH9Z3Ie2o5Q5zCbOTTz
        sOyIebqlp3BfrVFFVm/Yfj9yEYDf8Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661729533;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wb/PDEsKkXSW9tFyWROa8/kumcMUzFjGtj7cKerHg2Q=;
        b=wZj9XNHJH2EhAcUARJ1sam6Qr/K7jZJy4PM1yzlvDwLqfHXJWWmXK2VaBNXU1uGcJqfJfp
        BDtAosj4MSSQZ2Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5943B13A65;
        Sun, 28 Aug 2022 23:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /V1bBvz6C2MiaAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 28 Aug 2022 23:32:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <c64f102712ed8a5d728c2bf74592715891302f78.camel@hammerspace.com>
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
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>,
 <166155716162.27490.17801636432417958045@noble.neil.brown.name>,
 <c64f102712ed8a5d728c2bf74592715891302f78.camel@hammerspace.com>
Date:   Mon, 29 Aug 2022 09:32:08 +1000
Message-id: <166172952853.27490.16907220841440758560@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyNyBBdWcgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFNhdCwgMjAy
Mi0wOC0yNyBhdCAwOTozOSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gU2F0LCAyNyBB
dWcgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiBPbiBGcmksIDIwMjItMDgtMjYg
YXQgMTA6NTkgLTA0MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6Cj4gPiA+ID4gT24gMTYg
TWF5IDIwMjIsIGF0IDIxOjM2LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6Cj4gPiA+ID4gPiBTbyB1
bnRpbCB5b3UgaGF2ZSBhIGRpZmZlcmVudCBzb2x1dGlvbiB0aGF0IGRvZXNuJ3QgaW1wYWN0IHRo
ZQo+ID4gPiA+ID4gY2xpZW50J3MKPiA+ID4gPiA+IGFiaWxpdHkgdG8gY2FjaGUgcGVybWlzc2lv
bnMsIHRoZW4gdGhlIGFuc3dlciBpcyBnb2luZyB0byBiZQo+ID4gPiA+ID4gIm5vIgo+ID4gPiA+
ID4gdG8KPiA+ID4gPiA+IHRoZXNlIHBhdGNoZXMuCj4gPiA+ID4gCj4gPiA+ID4gSGkgVHJvbmQs
Cj4gPiA+ID4gCj4gPiA+ID4gV2UgaGF2ZSBzb21lIGZvbGtzIG5lZ2F0aXZlbHkgaW1wYWN0ZWQg
YnkgdGhpcyBpc3N1ZSBhcyB3ZWxsLsKgCj4gPiA+ID4gQXJlCj4gPiA+ID4geW91Cj4gPiA+ID4g
d2lsbGluZyB0byBjb25zaWRlciB0aGlzIHZpYSBhIG1vdW50IG9wdGlvbj8KPiA+ID4gPiAKPiA+
ID4gPiBCZW4KPiA+ID4gPiAKPiA+ID4gCj4gPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0aGF0IGFuc3dl
cnMgbXkgY29uY2Vybi4KPiA+IAo+ID4gQ291bGQgeW91IHBsZWFzZSBzcGVsbCBvdXQgYWdhaW4g
d2hhdCB5b3VyIGNvbmNlcm5zIGFyZT/CoCBJIHN0aWxsCj4gPiBkb24ndAo+ID4gdW5kZXJzdGFu
ZC4gCj4gPiBUaGUgb25seSBwZXJmb3JtYW5jZSBpbXBhY3QgaXMgd2hlbiBhIHBlcm1pc3Npb24g
dGVzdCBmYWlscy7CoCBJbiB3aGF0Cj4gPiBjaXJjdW1zdGFuY2UgaXMgcGVybWlzc2lvbiBmYWls
dXJlIGV4cGVjdGVkIG9uIGEgZmFzdC1wYXRoPwo+ID4gCj4gCj4gWW91J3JlIHRyZWF0aW5nIHRo
ZSBwcm9ibGVtIGFzIGlmIGl0IHdlcmUgYSB0aW1lb3V0IGlzc3VlLCB3aGVuIGNsZWFybHkKPiBp
dCBoYXMgbm90aGluZyBhdCBhbGwgdG8gZG8gd2l0aCB0aW1lb3V0cy4gVGhlcmUgaXMgbm8gcHJv
YmxlbSBvZgo+ICdncm91cCBtZW1iZXJzaGlwIGNoYW5nZXMgb24gYSByZWd1bGFyIGJhc2lzJyB0
byBiZSBzb2x2ZWQuCgpZb3UgYXJlIHRoZSBvbmUgd2hvIHN1Z2dlc3RlZCBhIHRpbWVvdXQuICBJ
IHF1b3RlOgoKPiBUaGF0IHdheSwgeW91IGhhdmUgYSBtZWNoYW5pc20gdGhhdCBzZXJ2ZXMgYWxs
IHB1cnBvc2VzOiBpdCBjYW4gZG8gYW4KPiBpbW1lZGlhdGUgb25lLXRpbWUgb25seSBmbHVzaCwg
b3IgeW91IGNhbiBzZXQgdXAgYSB1c2Vyc3BhY2Ugam9iIHRoYXQKPiBpc3N1ZXMgYSBnbG9iYWwg
Zmx1c2ggb25jZSBldmVyeSBzbyBvZnRlbiwgZS5nLiB1c2luZyBhIGNyb24gam9iLgoKImV2ZXJ5
IHNvIG9mdGVuIiA9PSAidGltZW91dCIuICBJIHRob3VnaHQgdGhhdCBtYXliZSB0aGlzIHdhcyBz
b21ld2hlcmUKdGhhdCB3ZSBjb3VsZCBmaW5kIHNvbWUgYWdyZWVtZW50LiAgQXMgSSBzYWlkLCBJ
IHdvdWxkIHNldCB0aGUgdGltZW91dAp0byB6ZXJvLiAgSSBkb24ndCByZWFsbHkgd2FudCB0aGUg
dGltZW91dCAtIG5vdCBtb3JlIHRoYW4gdGhlIGFjCnRpbWVvdXRzIHdlIGFscmVhZHkgaGF2ZS4K
Cj4gCj4gVGhlIHByb2JsZW0gdG8gYmUgc29sdmVkIGlzIHRoYXQgb24gdGhlIHZlcnkgcmFyZSBv
Y2Nhc2lvbiB3aGVuIGEgZ3JvdXAKPiBtZW1iZXJzaGlwIGRvZXMgY2hhbmdlLCB0aGVuIHRoZSBz
ZXJ2ZXIgYW5kIHRoZSBjbGllbnQgbWF5IHVwZGF0ZSB0aGVpcgo+IHZpZXcgb2YgdGhhdCBtZW1i
ZXJzaGlwIGF0IGNvbXBsZXRlbHkgZGlmZmVyZW50IHRpbWVzLiBJbiB0aGUKPiBwYXJ0aWN1bGFy
IGNhc2Ugd2hlbiB0aGUgY2xpZW50IHVwZGF0ZXMgaXRzIHZpZXcgb2YgdGhlIGdyb3VwCj4gbWVt
YmVyc2hpcCBiZWZvcmUgdGhlIHNlcnZlciBkb2VzLCB0aGVuIHRoZSBhY2Nlc3MgY2FjaGUgaXMg
cG9sbHV0ZWQsCj4gYW5kIHRoZXJlIGlzIG5vIHJlbWVkeS4KCkFncmVlZC4KCj4gCj4gU28gbXkg
Y29uY2VybnMgYXJlIGFyb3VuZCB0aGUgbWlzbWF0Y2ggb2YgcHJvYmxlbSBhbmQgc29sdXRpb24u
IEkgc2VlCj4gbXVsdGlwbGUgaXNzdWVzLgo+IAo+ICAgIDEuIFlvdXIgdGltZW91dHMgYXJlIHBl
ciBpbm9kZS4gVGhhdCBtZWFucyB0aGF0IGlmIGlub2RlIEEgc2VlcyB0aGUKPiAgICAgICBwcm9i
bGVtIGJlaW5nIHNvbHZlZCwgdGhlbiB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCBpbm9kZSBC
Cj4gICAgICAgc2VlcyB0aGUgc2FtZSBwcm9ibGVtIGFzIGJlaW5nIHNvbHZlZCAoYW5kIHRoZSBj
b252ZXJzZSBpcyB0cnVlCj4gICAgICAgYXMgd2VsbCkuCgpJcyB0aGF0IGEgcHJvYmxlbT8gIElz
IHRoYXQgZXZlbiBhbnl0aGluZyBuZXc/CklmIEkgY2htb2QgZmlsZSBBIGFuZCBmaWxlIEIgb24g
dGhlIHNlcnZlciwgdGhlbiB0aGUgY2xpZW50IG1heSBzZWUKdGhlIGNoYW5nZSB0byBmaWxlIEEg
YmVmb3JlIHRoZSBjaGFuZ2UgdG8gZmlsZSBCIChvciB2aWNlLXZlcnNhKS4KaS5lLiAgdGhlIGlu
Y29uc2lzdGVudC1jYWNoZSBwcm9ibGVtIG1pZ2h0IGJlIHNvbHZlZCBmb3Igb25lIGJ1dCBub3Qg
dGhlCm90aGVyLiAgSXQgaGFzIGFsd2F5cyBiZWVuIHRoaXMgd2F5LgoKPiAgICAyLiBUaGVyZSBp
cyBubyBxdWljayBvbi10aGUtc3BvdCBzb2x1dGlvbi4gSWYgeW91ciBhZG1pbiB1cGRhdGVzIHRo
ZQo+ICAgICAgIGdyb3VwIG1lbWJlcnNoaXAsIHRoZW4geW91IGFyZSBvbmx5IGd1YXJhbnRlZWQg
dGhhdCB0aGUgY2xpZW50Cj4gICAgICAgYW5kIHNlcnZlciBhcmUgaW4gc3luYyBvbmNlIHRoZSBz
ZXJ2ZXIgaGFzIHBpY2tlZCB1cCB0aGUgc29sdXRpb24KPiAgICAgICAoaG93ZXZlciB5b3UgYXJy
YW5nZSB0aGF0KSwgYW5kIHRoZSBjbGllbnQgY2FjaGUgaGFzIGV4cGlyZWQuCj4gICAgICAgSU9X
OiB5b3VyIG9ubHkgc29sdXRpb24gaXMgdG8gd2FpdCAxIGNsaWVudCBjYWNoZSBleHBpcmF0aW9u
Cj4gICAgICAgcGVyaW9kIGFmdGVyIHRoZSBzZXJ2ZXIgaXMga25vd24gdG8gYmUgZml4ZWQgKG9y
IHRvIHJlYm9vdCB0aGUKPiAgICAgICBjbGllbnQpLgoKVGhpcyBpcyBhbHNvIHRoZSBvbmx5IHNv
bHV0aW9uIHRvIHNlZWluZyBvdGhlciBjaGFuZ2VzIHRoYXQgaGF2ZSBiZWVuCm1hZGUgdG8gaW5v
ZGVzLgpGb3IgZmlsZS9kaXJlY3RvcnkgY29udGVudCB5b3UgY2FuIG9wZW4gdGhlIGZpbGUvZGly
ZWN0b3J5IGFuZCB0aGlzCnRyaWdnZXJzIENUTyBjb25zaXN0ZW5jeSBjaGVja3MuICBCdXQgc3Rh
dCgpIG9yIGFjY2VzcygpIGRvZXNuJ3QuCgpIbW1tLi4gV2hhdCBpZiB3ZSBhZGQgYW4gQUNDRVNT
IGNoZWNrIHRvIHRoZSBPUEVOIHJlcXVlc3QgZm9yIGZpbGVzLCBhbmQKdGhlIGVxdWl2YWxlbnQg
R0VUQVRUUiBmb3IgZGlyZWN0b3JpZXM/ICBUaGF0IHdvdWxkIHByb3ZpZGUgYSBkaXJlY3QKd2F5
IHRvIGZvcmNlIGEgcmVmcmVzaCB3aXRob3V0IGFkZGluZyBhbnkgZXh0cmEgUlBDIHJlcXVlc3Rz
Pz8KCj4gICAgMy4gVGhlcmUgaXMgbm8gc29sdXRpb24gYXQgYWxsIGZvciB0aGUgcG9zaXRpdmUg
Y2FjaGUgY2FzZS4gSWYgeW91cgo+ICAgICAgIHN5c2FkbWluIGlzIHRyeWluZyB0byByZXZva2Ug
YW4gYWNjZXNzIGR1ZSB0byBhIGdyb3VwIG1lbWJlcnNoaXAKPiAgICAgICBjaGFuZ2UsIHRoZWly
IG9ubHkgc29sdXRpb24gaXMgdG8gcmVib290IHRoZSBjbGllbnQuCgpZZXMuICBSZXZva2luZyBy
ZWFkL2V4ZWN1dGUgYWNjZXNzIHRoYXQgeW91IGhhdmUgYWxyZWFkeSBncmFudGVkIGlzIG5vdApy
ZWFsbHkgcG9zc2libGUuICBUaGUgYXBwbGljYXRpb24gbWF5IGhhdmUgYWxyZWFkeSByZWFkIHRo
ZSBmaWxlLiAgSXQKbWlnaHQgZXZlbiBoYXZlIGVtYWlsZWQgdGhlIGNvbnRlbnQgdG8gJEJMQUNL
SEFULiAgRXZlbiByZWJvb3RpbmcgdGhlCmNsaWVudCBpc24ndCByZWFsbHkgYSBzb2x1dGlvbi4K
UmV2b2tpbmcgd3JpdGUgYWNjZXNzIGFscmVhZHkgd29ya3MgZmluZSBhcyBkb2VzIHJldm9raW5n
IHJlYWQgYWNjZXNzIHRvCmEgZmlsZSBiZWZvcmUgcHV0dGluZyBuZXcgY29udGVudCBpbiBpdCAt
IHRoZSBuZXcgY29udGVudCBpcyBzYWZlLgoKPiAgICA0LiBZb3UgYXJlIHR5aW5nIHRoZSBhY2Nl
c3MgY2FjaGUgdGltZW91dCB0byB0aGUgY29tcGxldGVseQo+ICAgICAgIHVucmVsYXRlZCAnYWNy
ZWdtaW4nIGFuZCAnYWNkaXJtaW4nIHZhbHVlcy4gTm90IG9ubHkgZG9lcyB0aGF0Cj4gICAgICAg
bWVhbiB0aGF0IHRoZSBkZWZhdWx0IHZhbHVlcyBmb3IgcmVndWxhciBmaWxlcyBhcmUgZXh0cmVt
ZWx5Cj4gICAgICAgc21hbGwgKDMgc2Vjb25kcyksIG1lYW5pbmcgdGhhdCB3ZSBoYXZlIHRvIHJl
ZnJlc2ggZXh0cmVtZWx5Cj4gICAgICAgb2Z0ZW4uIEhvd2V2ZXIgaXQgYWxzbyBtZWFucyB0aGF0
IHlvdSBoYXZlIHRvIGV4cGxhaW4gd2h5Cj4gICAgICAgZGlyZWN0b3JpZXMgYmVoYXZlIGRpZmZl
cmVudGx5IChsb25nZXIgZGVmYXVsdCB0aW1lb3V0cykgZGVzcGl0ZQo+ICAgICAgIHRoZSBmYWN0
IHRoYXQgdGhlIGdyb3VwIG1lbWJlcnNoaXAgY2hhbmdlZCBhdCBleGFjdGx5IHRoZSBzYW1lCj4g
ICAgICAgdGltZSBmb3IgYm90aCB0eXBlcyBvZiBvYmplY3QuCj4gICAgICAgICAgMS4gQm9udXMg
cG9pbnRzIGZvciBleHBsYWluaW5nIHdoeSBvdXIgZGVmYXVsdCB2YWx1ZXMgYXJlIGRlc2lnbmVk
Cj4gICAgICAgICAgICAgZm9yIGEgZ3JvdXAgbWVtYmVyc2hpcCB0aGF0IGNoYW5nZXMgZXZlcnkg
MyBzZWNvbmRzLgoKSSBkb24ndCBzZWUgd2h5IHlvdSB0cmVhdCB0aGUgYWNjZXNzIGluZm9ybWF0
aW9uIGFzIGRpZmZlcmVudCBmcm9tIGFsbAp0aGUgb3RoZXIgYXR0cmlidXRlcy4gICJib2IgaGFz
IGdyb3VwIHggYWNjZXNzIHRvIHRoZSBkaXJlY3RvcnkiIGFuZAoiZmlsZSBzaXplIGlmIDQyMDAw
IGJ5dGVzIiBhcmUganVzdCBhdHRyaWJ1dGVzIG9mIHRoZSBpbm9kZS4gIFdlIGNvbGxlY3QKdGhl
bSBkaWZmZXJlbnQgd2F5cywgYnV0IHRoZXkgYXJlIG5vdCBkZWVwbHkgZGlmZmVyZW50LgoKVGhl
IG9kZCB0aGluZyBoZXJlIGlzIHRoYXQgd2UgY2FjaGUgdGhlc2UgImFjY2VzcyIgYXR0cmlidXRl
cwppbmRlZmluaXRlbHkgd2hlbiBjdGltZSBkb2Vzbid0IGNoYW5nZSAtIGV2ZW4gdGhvdWdoIHRo
ZXJlIGlzIG5vCmd1YXJhbnRlZSB0aGF0IGN0aW1lIGNhcHR1cmVzIGFjY2VzcyBjaGFuZ2VzLiAg
SSB0aGluayB0aGF0IGNob2ljZSBuZWVkcwp0byBiZSBqdXN0aWZpZWQuClVzaW5nIHRoZSBjYWNo
ZWQgdmFsdWUgaW5kZWZpbml0ZWx5IHdoZW4gaXQgZ3JhbnRzIGFjY2VzcyBpcyBkZWZlbnNpYmxl
CmJlY2F1c2UgaXQgaXMgYSBmcmVxdWVudCBvcGVyYXRpb24gKGNoZWNraW5nIHggYWNjZXNzIGlu
IGEgZGlyZWN0b3J5CndoaWxlIGZvbGxvd2luZyBhIHBhdGNoKS4gIEkgdGhpbmsgdGhhdCBhZGVx
dWF0ZWx5IGp1c3RpZmllcyB0aGUgY2hvaWNlLgpJIGNhbm5vdCBzZWUgdGhlIGp1c3RpZmljYXRp
b24gd2hlbiB0aGUgYWNjZXNzIGlzIGRlbmllZCBieSB0aGUgY2FjaGUuCgo+ICAgIDUuICdub2Fj
JyBzdWRkZW5seSBub3cgdHVybnMgb2ZmIGFjY2VzcyBjYWNoaW5nLCBidXQgb25seSBmb3IKPiAg
ICAgICBuZWdhdGl2ZSBjYWNoZWQgdmFsdWVzLgoKSXMgdGhpcyBhIHN1cnByaXNlPwoKQnV0IHdo
YXQgZG8geW91IHRoaW5rIG9mIGFkZGluZyBhbiBBQ0NFU1MgY2hlY2sgd2hlbiBvcGVuaW5nIGEg
ZGlyL2ZpbGU/CkF0IGxlYXN0IGZvciBORlN2ND8KClRoYW5rcywKTmVpbEJyb3duCg==
