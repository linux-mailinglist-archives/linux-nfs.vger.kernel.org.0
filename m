Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F7453B66
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 22:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhKPVGH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 16:06:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36538 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKPVGH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 16:06:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A6731FCA3;
        Tue, 16 Nov 2021 21:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637096589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHOgG0+rTZl4aYfFAakOjsG0el/sfG4ceUHii+lUuWY=;
        b=LtOHPAr56i0naEW6HgduaoR+CDkQKt3vwoMuDXaLjTVyUM8sSMXqggxCeqFGBzcfD+xuRq
        oNozDP/WFS6oWzjSLJu808Wwk2X2CUUEmSXpfCU/xJNtqXiahTQw5WEZx8jA05Jkj5urFx
        BB+XVF2tS9WQf9MBcsgUBDNOkciNqBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637096589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHOgG0+rTZl4aYfFAakOjsG0el/sfG4ceUHii+lUuWY=;
        b=HM89SLiqgf2oZYb6MpBsOK5SCr9gSzWt32YCTVOVxzYITvQAySuC6Jv1xpAWszxeEmPSIl
        DU38K3mbpBGnHrBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 244AB13C60;
        Tue, 16 Nov 2021 21:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J0MaNYsclGF6CAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 21:03:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Don't store cred in nfs_access_entry
In-reply-to: <1b6b267598c8fcf5f50b6a118d88cf7ea938d076.camel@hammerspace.com>
References: <163278643081.17728.10586733395858659759.stgit@noble.brown>,
 <163709576284.13692.2252149084412844753@noble.neil.brown.name>,
 <1b6b267598c8fcf5f50b6a118d88cf7ea938d076.camel@hammerspace.com>
Date:   Wed, 17 Nov 2021 08:03:05 +1100
Message-id: <163709658518.13692.5627971160170656882@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAxNyBOb3YgMjAyMSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFdlZCwgMjAy
MS0xMS0xNyBhdCAwNzo0OSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gCj4gPiBIaSBUcm9u
ZC9Bbm5hLAo+ID4gwqBoYXZlIHlvdSBoYWQgYSBjaGFuY2UgdG8gbG9vayBhdCB0aGVzZSBwYXRj
aGVzPwo+ID4gCj4gCj4gT2ggY3JhcC4uLiBJIGRpZCBzZWUgdGhvc2UgcGF0Y2hlcywgYW5kIGlu
dGVuZGVkIHRvIHBpY2sgdGhlbSB1cCBmb3IKPiB0aGlzIGxhc3QgbWVyZ2Ugd2luZG93LCBidXQg
c29tZWhvdyBmb3Jnb3QgdG8gbW92ZSB0aGVtIGludG8gbXkKPiAndGVzdGluZycgYnJhbmNoLgo+
IAo+IEFubmEsIGNhbiB5b3UgcGxlYXNlIHF1ZXVlIHRoZW0gdXAgZm9yIHRoZSBuZXh0IG1lcmdl
IHdpbmRvdz8KPiAKPiBBcG9sb2dpZXMKPiAgIFRyb25kCgpObyBwcm9ibGVtIC0gdGhhbmtzLgoK
TmVpbEJyb3duCg==
