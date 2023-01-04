Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464E565CBCC
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 03:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjADCM7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 21:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjADCM6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 21:12:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B10317E04
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 18:12:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 249F337AAD;
        Wed,  4 Jan 2023 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672798376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZushDCcfXBngzzgki+tufUM2515MswP//XjuM5rACY=;
        b=jSR+4iAh8VeufZUa4/tIw7z8KdzWD7NtawhrZ5krlMk8pjLOeqZY85NDBRC5GQv3acNuLz
        tf6o2S37kstqsRqV48slOaFP9AjmSqRBNN2xS4P2vjbUv9iMEpmfOa85m0k+7vNWN24vZs
        dA1zqhk7zyPOneYgQ+twgcwwUrh8XcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672798376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZushDCcfXBngzzgki+tufUM2515MswP//XjuM5rACY=;
        b=DLInMLZe/B5DgG7B3ULLFuKV60Ufxmczk0bfJr8GQGdvURcDsAhOd8kiXOHpUC5geeiMOl
        hybRpnXuR8fGOQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 438C41342C;
        Wed,  4 Jan 2023 02:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0/zEOaXgtGOsBAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 04 Jan 2023 02:12:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@kernel.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "Olga Kornievskaia" <aglo@umich.edu>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
In-reply-to: <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>,
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>,
 <167279409373.13974.16504090316814568327@noble.neil.brown.name>,
 <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
Date:   Wed, 04 Jan 2023 13:12:50 +1100
Message-id: <167279837032.13974.12155714770736077636@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAwNCBKYW4gMjAyMywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFdlZCwgMjAy
My0wMS0wNCBhdCAxMjowMSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gV2VkLCAwNCBK
YW4gMjAyMywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiAKPiA+ID4gCj4gPiA+IElmIHRo
ZSBzZXJ2ZXIgc3RhcnRzIHRvIHJlcGx5IE5GUzRFUlJfU1RBTEUgdG8gR0VUQVRUUiByZXF1ZXN0
cywKPiA+ID4gd2h5IGRvCj4gPiA+IHdlIGNhcmUgYWJvdXQgc3RhdGVpZCB2YWx1ZXM/IEp1c3Qg
bWFyayB0aGUgaW5vZGUgYXMgc3RhbGUgYW5kIGRyb3AKPiA+ID4gaXQKPiA+ID4gb24gdGhlIGZs
b29yLgo+ID4gCj4gPiBXZSBoYXZlIGEgdmFsaWQgc3RhdGUgZnJvbSB0aGUgc2VydmVyIC0gd2Ug
cmVhbGx5IHNob3VsZG4ndCBqdXN0Cj4gPiBpZ25vcmUKPiA+IGl0Lgo+ID4gCj4gPiBNYXliZSBp
dCB3b3VsZCBiZSBPSyB0byBtYXJrIHRoZSBpbm9kZSBzdGFsZS7CoCBJIGRvbid0IGtub3cgaWYK
PiA+IHZhcmlvdXMKPiA+IHJldHJ5IGxvb3BzIGFib3J0IHByb3Blcmx5IHdoZW4gdGhlIGlub2Rl
IGlzIHN0YWxlLgo+IAo+IFllcywgdGhleSBhcmUgYWxsIHN1cHBvc2VkIHRvIGRvIHRoYXQuIE90
aGVyd2lzZSB3ZSB3b3VsZCBlbmQgdXAKPiBsb29waW5nIGZvcmV2ZXIgaW4gY2xvc2UoKSwgZm9y
IGluc3RhbmNlLCBzaW5jZSB0aGUgUFVURkgsIEdFVEFUVFIgYW5kCj4gQ0xPU0UgY2FuIGFsbCBy
ZXR1cm4gTkZTNEVSUl9TVEFMRSBhcyB3ZWxsLgoKVG8gbWFyayB0aGUgaW5vZGUgYXMgU1RBTEUg
d2Ugc3RpbGwgbmVlZCB0byBmaW5kIHRoZSBpbm9kZSwgYW5kIHRoYXQgaXMKdGhlIGtleSBiaXQg
bWlzc2luZyBpbiB0aGUgY3VycmVudCBjb2RlLiAgT25jZSB3ZSBmaW5kIHRoZSBpbm9kZSwgd2UK
Y291bGQgbWFyayBpdCBzdGFsZSwgYnV0IG1heWJlIHNvbWUgb3RoZXIgZXJyb3IgcmVzdWx0ZWQg
aW4gdGhlIG1pc3NpbmcKR0VUQVRUUi4uLgoKSXQgbWlnaHQgbWFrZSBzZW5zZSB0byBwdXQgdGhl
IG5ldyBjb2RlIGluIF9uZnM0X3Byb2Nfb3BlbigpIGFmdGVyIHRoZQpleHBsaWNpdCBuZnM0X3By
b2NfZ2V0YXR0cigpIGZhaWxzLiAgV2Ugd291bGQgbmVlZCB0byBmaW5kIHRoZSBpbm9kZQpnaXZl
biBvbmx5IHRoZSBmaWxlaGFuZGxlLiAgSXMgdGhlcmUgYW55IGVhc3kgd2F5IHRvIGRvIHRoYXQ/
CgpUaGFua3MsCk5laWxCcm93bgo=
