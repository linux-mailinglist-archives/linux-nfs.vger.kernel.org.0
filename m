Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7579529620
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 02:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiEQAl7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 20:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiEQAlD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 20:41:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329729C89
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 17:41:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 263B82204A;
        Tue, 17 May 2022 00:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652748060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPxFUTficubKeWIF+uI2Gck3Z0RDw+5GqM0g2HG+hZY=;
        b=LJy5wR8VfcXddPTxof6Jx2F2aamhZWtt3IVeox3gNWEGM4x+BFjovw257ZocglD9S2vp5F
        4OFImYEuQuB1VxE9qLoMgp3aWd9ybrUqTapzV1jBSnqy3gzvDmi99vYiU9oPy/auO1C7Vt
        N5rUayeKl2F67RHmGPZE9M3rWPBNTIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652748060;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPxFUTficubKeWIF+uI2Gck3Z0RDw+5GqM0g2HG+hZY=;
        b=h72pGSXfFnh0kC2p3FJX5k/dLoUlgso8p2duNRSl+8ikmi3ohim37/A3nVnK4GhOHFs5O+
        MznTNMdkYlqR0ODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1797913ADC;
        Tue, 17 May 2022 00:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5/MKMhrvgmKTcQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 17 May 2022 00:40:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
Date:   Tue, 17 May 2022 10:40:55 +1000
Message-id: <165274805538.17247.18045261877097040122@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAxNyBNYXkgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFR1ZSwgMjAy
Mi0wNS0xNyBhdCAxMDowNSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gCj4gPiBIaSwKPiA+
IMKgYW55IHRob3VnaHRzIG9uIHRoZXNlIHBhdGNoZXM/Cj4gCj4gCj4gVG8gbWUsIHRoaXMgcHJv
YmxlbSBpcyBzaW1wbHkgbm90IHdvcnRoIGJyZWFraW5nIGhvdCBwYXRoIGZ1bmN0aW9uYWxpdHkK
PiBmb3IuIElmIHRoZSBjcmVkZW50aWFsIGNoYW5nZXMgb24gdGhlIHNlcnZlciwgYnV0IG5vdCBv
biB0aGUgY2xpZW50IChzbwo+IHRoYXQgdGhlIGNyZWQgY2FjaGUgY29tcGFyaXNvbiBzdGlsbCBt
YXRjaGVzKSwgdGhlbiB3aHkgZG8gd2UgY2FyZT8KPiAKPiBJT1c6IEknbSBhIE5BQ0sgdW50aWwg
Y29udmluY2VkIG90aGVyd2lzZS4KCkluIHdoYXQgd2F5IGlzIHRoZSBob3QgcGF0aCBicm9rZW4/
ICBJdCBvbmx5IGFmZmVjdCBhIHBlcm1pc3Npb24gdGVzdApmYWlsdXJlLiAgV2h5IGlzIHRoYXQg
Y29uc2lkZXJlZCAiaG90IHBhdGgiPz8KClJGQyAxODEzIHNheXMgLSBmb3IgTkZTdjMgYXQgbGVh
c3QgLSAKCiAgICAgIFRoZSBpbmZvcm1hdGlvbiByZXR1cm5lZCBieSB0aGUgc2VydmVyIGluIHJl
c3BvbnNlIHRvIGFuCiAgICAgIEFDQ0VTUyBjYWxsIGlzIG5vdCBwZXJtYW5lbnQuIEl0IHdhcyBj
b3JyZWN0IGF0IHRoZSBleGFjdAogICAgICB0aW1lIHRoYXQgdGhlIHNlcnZlciBwZXJmb3JtZWQg
dGhlIGNoZWNrcywgYnV0IG5vdAogICAgICBuZWNlc3NhcmlseSBhZnRlcndhcmRzLiBUaGUgc2Vy
dmVyIGNhbiByZXZva2UgYWNjZXNzCiAgICAgIHBlcm1pc3Npb24gYXQgYW55IHRpbWUuCgpDbGVh
cmx5IHRoZSBzZXJ2ZXIgY2FuIGFsbG93IGFsbG93IGFjY2VzcyBhdCBhbnkgdGltZS4KVGhpcyBz
ZWVtcyB0byBhcmd1ZSBhZ2FpbnN0IGNhY2hpbmcgLSBvciBhdCBsZWFzdCBhZ2FpbnN0IHJlbHlp
bmcgdG9vCmhlYXZpbHkgb24gdGhlIGNhY2hlLgoKUkZDIDg4ODEgaGFzIHRoZSBzYW1lIHRleHQg
Zm9yIE5GU3Y0LjEgLSBzZWN0aW9uIDE4LjEuNAoKIndoeSBkbyB3ZSBjYXJlPyIgQmVjYXVzZSB0
aGUgc2VydmVyIGhhcyBjaGFuZ2VkIHRvIGdyYW50IGFjY2VzcywgYnV0CnRoZSBjbGllbnQgaXMg
aWdub3JpbmcgdGhlIHBvc3NpYmlsaXR5IG9mIHRoYXQgY2hhbmdlIC0gc28gdGhlIHVzZXIgaXMK
cHJldmVudGVkIGZyb20gZG9pbmcgd29yay4KCk5laWxCcm93bgo=
