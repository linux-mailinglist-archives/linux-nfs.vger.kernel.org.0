Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125D5AC81A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Sep 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIDX2h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDX2g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 19:28:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA9BC1A
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 16:28:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3EDB384D3;
        Sun,  4 Sep 2022 23:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662334110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJuhK+Ze2Z7gDl0iAYZILNCYu8/OHDAy3YMW7ObDO80=;
        b=sawfMnMvqSKiivy6M3CbWZkxKjvnjvlt3ssa714Kng6CW0pAcnZQZpfTQd15a414pnVePY
        WtIBbHxWalBys4S9rrKhUEEHHDcajOyS42MY7T6vHznifTdVNpU6HhoMfZun+MfbHhujeH
        bgAh3SoFxEtMMSkg/Sfgg3sk+xoMCdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662334110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJuhK+Ze2Z7gDl0iAYZILNCYu8/OHDAy3YMW7ObDO80=;
        b=pTz+2K12ASSFBL8N3i2suhRJZ49ZZMOWnxiceA3Da1KDJ8xAb/CbX9nKFzkBuC2i03Bgw1
        M+t7c6JM9HZIEnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36C5D13A6B;
        Sun,  4 Sep 2022 23:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fWVLOJw0FWM/XwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 04 Sep 2022 23:28:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <1cfb40103f3f539973587f4565af79d5dc439096.camel@hammerspace.com>
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
 <c64f102712ed8a5d728c2bf74592715891302f78.camel@hammerspace.com>,
 <166172952853.27490.16907220841440758560@noble.neil.brown.name>,
 <22601f2b7ced45d3b5f44951970f79c22490aced.camel@kernel.org>,
 <166219906850.28768.1525969921769808093@noble.neil.brown.name>,
 <1cfb40103f3f539973587f4565af79d5dc439096.camel@hammerspace.com>
Date:   Mon, 05 Sep 2022 09:28:25 +1000
Message-id: <166233410596.1168.312161459644850792@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAwNCBTZXAgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFNhdCwgMjAy
Mi0wOS0wMyBhdCAxOTo1NyArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gVGhlIHdob2xlIHBv
aW50IG9mIHRoZSBORlMgQUNDRVNTIHJlcXVlc3QgaXMgdGhhdCB0aGUgY2xpZW50IGNhbm5vdAo+
ID4ga25vdwo+ID4gaG93IHRvIGludGVycHJldCBhbnkgYWNjZXNzIGNvbnRyb2xzIHRoYXQgdGhl
IHNlcnZlciBtaWdodCBoYXZlIGluCj4gPiBwbGFjZS7CoCBXaG8ga25vd3MsIHRoZXkgbWlnaHQg
ZXZlbiBiZSB0aW1lIGJhc2VkIGFjY2VzcyBjb250cm9scwo+ID4gKGdhbWVzIGNhbiBvbmx5IGJl
IHBsYXllZCBvbiB0aGUgd2Vla2VuZCkuwqAgT2ssIHRoYXQgaXMgYSBiaXQKPiA+IGV4dHJlbWUs
Cj4gPiBidXQgdGhlIHByaW5jaXBsZSByZW1haW5zLgo+ID4gCj4gPiAqWW91KiBtaWdodCAia25v
dyIgdGhhdCB0aGVyZSBhcmUgdHdvIHBpZWNlcyAoaW4gdGhpcyBzcGVjaWZpYwo+ID4gZXhhbXBs
ZSkKPiA+IGFuZCB0aGF0IG9uZSBkb2Vzbid0IGRpcmVjdGx5IHJlbGF0ZSB0byB0aGUgaW5vZGVz
LCBidXQgdGhlIE5GUwo+ID4gY2xpZW50Cj4gPiBkb2Vzbid0IGtub3cgdGhhdC7CoCBUaGUgTkZT
IGNsaWVudCBvbmx5IGtub3dzIHRoYXQgaXQgY2FuIHJlcXVlc3QKPiA+IEFDQ0VTUwo+ID4gaW5m
b3JtYXRpb24gZm9yIGEgZmlsZWhhbmRsZSBpbiB0aGUgY29udGV4dCBvZiBhIGNyZWRlbnRpYWwu
wqAgVGhlCj4gPiBMaW51eAo+ID4gTkZTIGNsaWVudCB0aGVuIGNhY2hlcyB0aGF0IGFnYWluc3Qg
dGhlIGlub2RlIChzbyBpdCBpcyBhbGwgc29tZWhvdwo+ID4gcmVsYXRlZCB0byB0aGUgaW5vZGUp
Lgo+ID4gCj4gPiBUaGUgc3BlYyBkb2Vzbid0IGdpdmUgdGhlIGNsaWVudCBwZXJtaXNzaW9uIHRv
IGNhY2hlZCB0aGVzZSBkZXRhaWxzCj4gPiBBVAo+ID4gQUxMLsKgIENhY2hpbmcgcG9zaXRpdmUg
cmVzdWx0cyBtYWtlcyBwZXJmZWN0IHNlbnNlIGZyb20gYSBwZXJmb3JtYW5jZQo+ID4gcGVyc3Bl
Y3RpdmUgYW5kIGlzIGVhc2lseSBkZWZlbnNpYmxlLsKgIENhY2hpbmcgbmVnYXRpdmUgcmVzdWx0
cyAuLi7CoAo+ID4gbm90Cj4gPiBzbyBtdWNoLgo+IAo+IE9mIGNvdXJzZSB0aGUgc3BlYyBhbGxv
d3MgdGhlIGNsaWVudCB0byBjYWNoZSBwZXJtaXNzaW9ucyBpbiBib3RoIE5GU3YzCj4gYW5kIE5G
U3Y0LiBPdGhlcndpc2UgdGhlcmUgd291bGQgYmUgbm8gd2F5IHdlIGNvdWxkIGNhY2hlIG9iamVj
dHMgYXQKPiBhbGwuIEVuYWJsaW5nIHRoZSBjbGllbnQgdG8gZ2F0ZSBhY2Nlc3MgdG8gY2FjaGVk
IGRhdGEgc3VjaCBhcwo+IGRpcmVjdG9yeSBjb250ZW50cywgYW5kIGNhY2hlZCBkYXRhIHdpdGhv
dXQgdHJvdWJsaW5nIHRoZSBzZXJ2ZXIgaXMgdGhlCj4gd2hvbGUgcG9pbnQgb2YgdGhlIEFDQ0VT
UyBvcGVyYXRpb24uIFdpdGhvdXQgdGhhdCBhYmlsaXR5LCB3ZSB3b3VsZAo+IGhhdmUgdG8gYXNr
IHRoZSBzZXJ2ZXIgZXZlcnkgdGltZSBhIHVzZXIgdHJpZWQgdG8gJ2NkJyBpbnRvIGEKPiBkaXJl
Y3RvcnksIGNhbGxlZCBvcGVuKCksIGNhbGxlZCBnZXRkZW50cygpLCBjYWxsZWQgcmVhZCgpLCBj
YWxsZWQKPiB3cml0ZSgpLCAuLi4gV2l0aG91dCB0aGF0IGFiaWxpdHksIE5GU3Y0IGRlbGVnYXRp
b25zIHdvdWxkIGJlCj4gcG9pbnRsZXNzLCBiZWNhdXNlIHdlJ2QgaGF2ZSB0byBnbyBhbmQgYXNr
IHRoZSBzZXJ2ZXIgZm9yIGFsbCB0aGVzZQo+IG9wZXJhdGlvbnMuCj4gSSBrbm93IHRoZSBzcGVj
IGlzIGxpdHRlcmVkIHdpdGggbWVhbHkgbW91dGhlZCAiVGhlIHNlcnZlciBjYW4gcmV2b2tlCj4g
YWNjZXNzIHBlcm1pc3Npb24gYXQgYW55IHRpbWUiIHN0YXRlbWVudHMgaW4gdmFyaW91cyBzcG90
cywgYnV0IHRoYXQKPiBsb29rcyBtb3JlIGxpa2Ugc29tZXRoaW5nIHRvIHBsYWNhdGUgYSByZXZp
ZXcgYnkgdGhlIElCTSBsZWdhbCB0ZWFtCj4gKHllcywgaXQgaGFwcGVuZWQpIHJhdGhlciB0aGFu
IGEgYmFzaWMgYXNzdW1wdGlvbiB0aGF0IHdhcyBlbmdpbmVlcmVkCj4gaW50byB0aGUgcHJvdG9j
b2wuIFRoZSBwcm90b2NvbCBzaW1wbHkgY2Fubm90IHdvcmsgYXMgZGVzY3JpYmVkIGluCj4gUkZD
NTY2MSBhbmQgUkZDNzUzMCB3aXRob3V0IHRoZSBhc3N1bXB0aW9uIHRoYXQgeW91IGNhbiBjYWNo
ZS4KCkl0IGlzbid0IGV4cGxpY2l0IHRob3VnaCBpcyBpdD8gIE5vdCBsaWtlIHRoZSBjYWNoaW5n
IG9mIGRhdGEgd2hpY2ggaXMKZXhwbGljaXQuClNvIEkgYWdyZWUgdGhlIHJlYWRpbmcgYmV0d2Vl
biB0aGUgbGluZXMgdGVsbHMgdXMgdGhhdCBzb21lIGNhY2hpbmcgaXMKbmVlZGVkIGFuZCBzbyBw
ZXJtaXR0ZWQsIGJ1dCB0aGF0IGRvZXNuJ3QgbWVhbiB0aGF0IGFueSBhbmQgYWxsIGNhY2hpbmcK
b2YgQUNDRVNTIHJlc3VsdHMgaXMgZ29vZC4gV2Ugc2hvdWxkIGNhY2hlIHdoYXQgd2UgbmVlZCwg
YW5kIG5vIG1vcmUuCgo+IAo+IFRoZSBvdGhlciBwb2ludCBpcyB0aGF0IGFjY2VzcyBjYWNoZSBj
aGFuZ2VzIGR1ZSB0byBBRC9MREFQL05JUyBncm91cAo+IG1lbWJlcnNoaXAgdXBkYXRlcyBoYXBw
ZW4gb25jZSBpbiBhIGJsdWUgbW9vbiwgYW5kIHdoZW4gdGhleSBkbywgdGhleQo+IGFmZmVjdCBf
QUxMXyBjYWNoZWQgdmFsdWVzIGZvciB0aGF0IHVzZXIsIGFuZCBub3QganVzdCBvbmUgYXQgYSB0
aW1lLgo+IFdoZW4gdGhvc2UgdGhpbmdzIGRvIGhhcHBlbiwgdGhlIHVzZXIgbm9ybWFsbHkgZXhw
ZWN0cyB0byBoYXZlIHRvIGxvZwo+IG91dCBhbmQgdGhlbiBsb2cgYmFjayBpbiBzbyB0aGF0IHRo
ZSBuZXcgZ3JvdXAgbWVtYmVyc2hpcHMgYXJlCj4gcmVmbGVjdGVkIGluIHRoYXQgdXNlcidzIGNy
ZWQgKGFzIHBlciBQT1NJWCBwcmVzY3JpYmVkIGJlaGF2aW91cikuIFRoYXQKPiB3aWxsIGNhdXNl
IHRoZSBORlMgY2xpZW50IHRvIHNlbmQgbmV3IEFDQ0VTUyBjYWxscyB0byB0aGUgc2VydmVyLAo+
IGJlY2F1c2UgdGhlIG5ldyBjcmVkIHdpbGwgbm90IGJlIGZvdW5kIGluIHRoZSBleGlzdGluZyBh
Y2Nlc3MgY2FjaGUuCj4gVGhlIG9ubHkgY2FzZSB3aGVyZSB0aGlzIGFzc3VtcHRpb24gZmFpbHMs
IGlzIGlmIHRoZSBzZXJ2ZXIgaXMKPiBpbXBsZW1lbnRpbmcgdGhlICctLW1hbmFnZS1naWRzJyBi
ZWhhdmlvdXIsIGFuZCBjYWNoZXMgaXRzCj4gcmVwcmVzZW50YXRpb24gb2YgdGhlIHVzZXIncyBj
cmVkcyBwYXN0IHRoZSB0aW1lIHdoZW4gdGhlIHVzZXIgbG9nZ2VkCj4gb3V0IGFuZCBsb2dnZWQg
aW4gYWdhaW4uCj4gU28gdGhpcyBpcyBsaXRlcmFsbHkgYSAxIGluIGEgYmlsbGlvbiBjaGFuY2Ug
cHJvYmxlbSB0aGF0IHlvdSdyZSBhc2tpbmcKPiB1cyB0byBmaXguIE9wdGltaXNpbmcgZm9yIHRo
YXQgY2FzZSBieSBhZGRpbmcgaW4gYSB0aW1lb3V0IHRoYXQgYWZmZWN0cwo+IGFsbCBjYWNoZWQg
YWNjZXNzIHZhbHVlIGlzIGp1c3Qgbm90IGluIHRoZSBjYXJkcy4KCkknbGwgYWNjZXB0IDEgaW4g
c2V2ZXJhbCBtaWxsaW9uIChvbmx5IHR3byBlbnRlcnByaXNlcyBpZGVudGlmaWVkIG91dCBvZgpo
b3cgbWFueSB0aGF0IHVzZSBMaW51eCBORlMgY2xpZW50cz8pLiAgT2J2aW91c2x5IHRoYXQgZG9l
c24ndCBqdXN0aWZ5CmFueXRoaW5nIHBvdGVudGlhbGx5IGNvc3RseS4KCkkgZG9uJ3QgdGhpbmsg
dGhlcmUgaXMgYW55IGludGVyZXN0aW5nIGNvc3QgaW4gbm90IGNhY2hpbmcgbmVnYXRpdmUKYWNj
ZXNzIHJlc3VsdHMgYmV5b25kIHRoZSBub3JtYWwgYXR0cmlidXRlLWNhY2hlIHRpbWVvdXQuICBJ
IGRvbid0CnJlY2FsbCB5b3UgYWRkcmVzc2luZyB0aGlzIHBhcnRpY3VsYXIgaXNzdWUuICBXaGF0
IGlzIHRoZSBjb3N0PwoKPiAKPiBJJ3ZlIGFscmVhZHkgc2VudCBvdXQgYSBwYXRjaCB0aGF0IGZv
cmNlcyByZWFsaWdubWVudCBvZiB0aGUgTkZTIGNsaWVudAo+IGJlaGF2aW91ciB3aXRoIHRoYXQg
b2YgUE9TSVggYnkgcmVxdWlyaW5nIHRoZSBjbGllbnQgdG8gcmVjaGVjayBjYWNoZWQKPiBhY2Nl
c3MgdmFsdWVzIGZvciBhbiBleGlzdGluZyBjcmVkZW50aWFsIGFmdGVyIGEgbmV3IGxvZ2luLCBi
dXQgZG9lcwo+IG5vdCBhZGQgYW55IGZ1cnRoZXIgaW1wZWRpbWVudHMgdG8gdGhlIGFjY2VzcyBj
YWNoZS4gV2h5IGlzIHRoYXQKPiBhcHByb2FjaCBub3Qgc3VmZmljaWVudD8KCkkgdGhpbmsgeW91
J3ZlIG9ic2VydmVkIHRoaXMgZmFjdCB5b3Vyc2VsZiwgYnV0IHByb3BhZ2F0aW9uIHRpbWVzIGZv
cgpncm91cCBtZW1iZXJzaGlwIGNoYW5nZXMgKGUuZy4gIHRob3VnaCBMREFQKSBhcmUgbm90IHVu
aWZvcm0uICBJdCBpcwplbnRpcmVseSBwb3NzaWJsZSBmb3IgdGhlIGNsaWVudCB0byBzZWUgYSBu
ZXcgbWVtYmVyc2hpcCBiZWZvcmUgdGhlCnNlcnZlci4gIFNvIHdpdGggLS1tYW5hZ2UtZ2lkcyAo
b3Iga3JiNSkgaXQgaXMgcG9zc2libGUgdG8gbG9nIGluIHRvIHRoZQpjbGllbnQsIGNoZWNrIHRo
YXQgZ3JvdXAgbWVtYmVyc2hpcCBoYXMgYmVlbiB1cGRhdGVkLCBhY2Nlc3MgYSBmaWxlCmFuZCBo
YXZlIHRoYXQgZmFpbC4gIEJ1dCB0aGVuIGEgbWludXRlIGxhdGVyIChpZiB5b3UgY291bGQgZmx1
c2ggdGhlCmFjY2VzcyBjYWNoZSkgaGF2ZSB0aGF0IGFjY2VzcyBzdWNjZWVkLgoKV2hlbiBJIHdh
cyBmaXJzdCBwcmVzZW50ZWQgd2l0aCB0aGlzIHByb2JsZW0gSSB0aG91Z2h0IGxvZ291dC9sb2dp
biB3YXMKdGhlIGFuc3dlciBhbmQgZXZlbiBwcm92aWRlZCBhIHBhdGNoIHdoaWNoIHdvdWxkIG1l
YW4gZGlmZmVyZW50IGxvZ2lucwpnb3QgZGlmZmVyZW50IGNhY2hlIGtleXMuICBUaGlzIHdhc24n
dCB2ZXJ5IHdlbGwgcmVjZWl2ZWQgYmVjYXVzZSBpdAp1c2VkIHRvIHdvcmsgd2l0aG91dCBsb2cg
b3V0L2luIChiZWNhdXNlIHdlIGRpZG4ndCBjYWNoZSBhY2Nlc3MKaW5kZWZpbml0ZWx5KSwgYnV0
IHRoZSBraWxsZXIgd2FzIHRoYXQgaXQgZGlkbid0IGV2ZW4gd29yayByZWxpYWJseSAtCmJlY2F1
c2Ugb2YgcHJvcGFnYXRpb24gdmFyaWFiaWxpdHkuCgpUaGFua3MsCk5laWxCcm93bgoK
