Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0455836EC
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 04:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiG1CcS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 22:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiG1CcQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 22:32:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994721C12F
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 19:32:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42C1B5BE38;
        Thu, 28 Jul 2022 02:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658975534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TI5k2WD81Hs6XBTn2pIw+85/09dMlXkDwP5Qew8L9Cc=;
        b=s8b3h79r0n5XYF8bp52RwbkxL0i0dtlawgMXVgcYO/yZbkH4QCG1QSyb1p7foSTM32zCZu
        wIeEKobtdwpNu2Coe20A7lC6Gm2OSJp/OQG5tIgs99elO+q1afLqcNJpZKnhWRScr84nbU
        W+1CB4eAPwvbt8d2O3O2ex3OIcL110k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658975534;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TI5k2WD81Hs6XBTn2pIw+85/09dMlXkDwP5Qew8L9Cc=;
        b=GeazUPyDa5ufWZ+WhmQhASPjVOj7RWLgk0gw3o9NtMFOJPmiLZu3R+uQ3D2+pwNWPVus4+
        QNvGGdoo4voU1BBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CE7C13A7E;
        Thu, 28 Jul 2022 02:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 15u+MSz14WLLUwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 28 Jul 2022 02:32:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: don't unhash dentry during unlink.
In-reply-to: <5b74b45995703dc19db20ef2d14a17d144110047.camel@hammerspace.com>
References: <165708423191.17141.6465885406851939941@noble.neil.brown.name>,
 <165881043914.4359.13549022003264375515@noble.neil.brown.name>,
 <5b74b45995703dc19db20ef2d14a17d144110047.camel@hammerspace.com>
Date:   Thu, 28 Jul 2022 12:32:09 +1000
Message-id: <165897552988.4359.8511775297546393866@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyOCBKdWwgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFR1ZSwgMjAy
Mi0wNy0yNiBhdCAxNDo0MCArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gCj4gPiBIaSBUcm9u
ZCwKPiA+IMKgZGlkIHlvdSBoYXZlIGEgY2hhbmdlIHRvIGxvb2sgYXQgdGhpcyBwYXRjaD8KPiAK
PiBJIGRpZCB0YWtlIGEgbG9vaywgYW5kIHRoZSBwYXRjaCBkb2VzIHNlZW0gYWNjZXB0YWJsZSB0
byBtZSBhcyBpdAo+IHN0YW5kcy4KClRoYW5rcy4KCj4gCj4gSG93ZXZlciB3aXRob3V0IHRoZSBm
dWxsIGNvbnRleHQgb2YgdGhlIG90aGVyIHBhdGNoZXMgeW91J3JlIHdyaXRpbmcsCj4gSSdtIG5v
dCBhYmxlIHRvIGFzY2VydGFpbiB3aGV0aGVyIG9yIG5vdCBhIGJldHRlciBhcHByb2FjaCB0aGFu
Cj4gb3ZlcmxvYWRpbmcgdGhlIG1lYW5pbmcgb2YgRENBQ0hFX0RPTlRDQUNIRSBtaWdodCBleGlz
dC4gSSdtIHdvbmRlcmluZwo+IGlmIHBlcmhhcHMgY28tb3B0aW5nIHN0cnVjdCBuZnNfdW5saW5r
ZGF0YSBhbmQvb3IgY3JlYXRpbmcgc29tZXRoaW5nCj4gc2ltaWxhciBmb3IgdGhlIG5vbi1zaWxs
eXJlbmFtZSBjYXNlIG1pZ2h0IG5vdCB3b3JrIGp1c3QgYXMgd2VsbD8KClRoZSBzaWduaWZpY2Fu
dCBwYXJ0IG9mIHRoZSBjb250ZXh0IGlzIHRoYXQgaV9yd3NlbSB3aWxsIG5vIGxvbmdlcgpwcm92
aWRlIGV4Y2x1c2lvbiBiZXR3ZWVuIG5vbi1jYWNoZWQgbG9va3VwIGFuZCB1bmxpbmssIHNvIHRo
ZQpkX3VuaGFzaCgpIHRyaWNrIHdvbid0IHdvcmsgYW55IG1vcmUuCgpVc2luZyBkX2ZzZGF0YSBz
b21laG93IHdvdWxkIGJlIGEgYmV0dGVyIHNvbHV0aW9uIHByb3ZpZGluZyB3ZSBjYW4gbWFrZQpp
dCB3b3JrLgpJJ3ZlIGxvb2tlZCBhZ2FpbiB0aHJvdWdoIHRoZSB1c2Ugb2YgZF9mc2RhdGEgYW5k
IEkgc2VlIG5vdyB0aGF0IGFuCm5mc191bmxpbmtkYXRhIGlzIG9ubHkgc3RvcmVkIHRoZXJlIHdo
ZW4gRENBQ0hFX05GU19SRU5BTUVEIGlzIHNldCwgYW5kCmluIHRoYXQgY2FzZSB3ZSB3b24ndCBi
ZSBjYWxsZWQgdG8gdW5saW5rLiAgSXQgaXMgc29tZXRpbWVzIHNldCB0byBhCiJkZXZuYW1lIiwg
YnV0IHRoYXQgaXMgb25seSBmb3IgZGlyZWN0b3JpZXMgKEkgdGhpbmspIGFuZCBvbmx5IHJlbGV2
YW50CndoaWxlIHRoZSBkZW50cnkgSVNfUk9PVCgpIC0gaWYgaXQgaXMgYmVpbmcgdW5saW5rZWQs
IGl0IGNhbm5vdCBiZQpJU19ST09UKCkuCgpTbyBkX2ZzZGF0YSBjYW4gb25seSBiZSBOVUxMIGF0
IHRoZSB0aW1lIG9mIGludGVyZXN0LgpTbyBJIGNhbiBzZXQgaXQgdG8gc29tZSBvdGhlciB2YWx1
ZSAoKHZvaWQqKTEgPz8pIHRvIGJsb2NrIGRfcmV2YWxpZGF0ZQp3aGlsZSB0aGUgdW5saW5rIGlz
IHByb2dyZXNzaW5nLgpJIGFsc28gbm90aWNlZCB0aGF0IEkgbmVlZCB0byBtYWtlIHRoZSBzYW1l
IGNoYW5nZSBpbiBuZnNfcmVuYW1lKCkgd2hlbgp0aGUgdGFyZ2V0IGV4aXN0cy4KCkknbGwgbGV0
IHlvdSBrbm93IHdoZW4gSSBoYXZlIHNvbWV0aGluZyBzdWl0YWJsZSBhbG9uZyB0aG9zZSBsaW5l
cy4KClRoYW5rcywKTmVpbEJyb3duCg==
