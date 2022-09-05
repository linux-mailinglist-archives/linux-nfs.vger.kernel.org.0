Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79B5AC83F
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Sep 2022 02:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiIEAJk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 20:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIEAJj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 20:09:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09517ABC
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 17:09:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65D91382CB;
        Mon,  5 Sep 2022 00:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662336576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7TFSYgKmn3qgFt6ZLsqrbzmsKcOkS+DPovMc19KCl4=;
        b=NdIBIZKY16VPbinJkSQ8Cm53S+FTR2Rh8p45g63mwTKY1Hzfolb6tHm3XovgjVKV2yh5NA
        4fAOnUYsEZy1M03Sdz3Ze8GXbHoEBAOsDwtXtCxyJGFCEYh9t8BfjdPCkUmkmrP0F9Rciu
        xJAOFrvKkiUoiU55Q1Vw8rb+tHKZqc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662336576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7TFSYgKmn3qgFt6ZLsqrbzmsKcOkS+DPovMc19KCl4=;
        b=e4sHwA66mG7GJE8Zjta8sFmgbLPQohVY0E4aJr1J1RkPaPFgf6Zg5VqwY6lcMt6knj3IG9
        g/k8w4iaohEYviBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0089139C7;
        Mon,  5 Sep 2022 00:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rf7MHj4+FWOIagAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 05 Sep 2022 00:09:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <2e5b8af112d8440757681a1f71de4ec0cc57ae90.camel@hammerspace.com>
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
 <1cfb40103f3f539973587f4565af79d5dc439096.camel@hammerspace.com>,
 <166233410596.1168.312161459644850792@noble.neil.brown.name>,
 <2e5b8af112d8440757681a1f71de4ec0cc57ae90.camel@hammerspace.com>
Date:   Mon, 05 Sep 2022 10:09:31 +1000
Message-id: <166233657158.1168.394810496332729625@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAwNSBTZXAgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIE1vbiwgMjAy
Mi0wOS0wNSBhdCAwOToyOCArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gCj4gPiBXaGVuIEkg
d2FzIGZpcnN0IHByZXNlbnRlZCB3aXRoIHRoaXMgcHJvYmxlbSBJIHRob3VnaHQgbG9nb3V0L2xv
Z2luCj4gPiB3YXMKPiA+IHRoZSBhbnN3ZXIgYW5kIGV2ZW4gcHJvdmlkZWQgYSBwYXRjaCB3aGlj
aCB3b3VsZCBtZWFuIGRpZmZlcmVudAo+ID4gbG9naW5zCj4gPiBnb3QgZGlmZmVyZW50IGNhY2hl
IGtleXMuwqAgVGhpcyB3YXNuJ3QgdmVyeSB3ZWxsIHJlY2VpdmVkIGJlY2F1c2UgaXQKPiA+IHVz
ZWQgdG8gd29yayB3aXRob3V0IGxvZyBvdXQvaW4gKGJlY2F1c2Ugd2UgZGlkbid0IGNhY2hlIGFj
Y2Vzcwo+ID4gaW5kZWZpbml0ZWx5KSwgYnV0IHRoZSBraWxsZXIgd2FzIHRoYXQgaXQgZGlkbid0
IGV2ZW4gd29yayByZWxpYWJseSAtCj4gPiBiZWNhdXNlIG9mIHByb3BhZ2F0aW9uIHZhcmlhYmls
aXR5Lgo+IAo+IFRoZW4gdGhlIG9udXMgaXMgdXBvbiB5b3UgYW5kIHRoZSBwZW9wbGUgd2hvIGRv
bid0IHdhbnQgdGhlIHR3bwo+IHByb3Bvc2VkIHNvbHV0aW9ucyB0byBmaWd1cmUgb3V0IG5ldyBv
bmVzLiBUaW1lb3V0cyBhcmUgbm90IGFjY2VwdGFibGUuCgpXaHkgbm90PyAgVGhleSBoYXZlIGFs
d2F5cyBiZWVuIHBhcnQgb2YgTkZTLgoKQnV0IGxldCdzIGZvcmdldCBhYm91dCB0aW1lb3V0cyBm
b3IgdGhlIG1vbWVudC4KWW91IHN0aWxsIGhhdmVuJ3QgYW5zd2VyZWQgbXkgcXVlc3Rpb246ICBX
aGF0IGlzIHRoZSBjb3N0IG9mIG5vdCBjYWNoaW5nCm5lZ2F0aXZlIGFjY2VzcyByZXN1bHRzPz8K
Ck5laWxCcm93bgo=
