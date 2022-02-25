Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C734C3C57
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 04:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiBYDS2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 22:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiBYDS2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 22:18:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686018C798
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 19:17:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CBB41F380;
        Fri, 25 Feb 2022 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645759075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOhA2aVCQruRjVqsQIv/eDBGU84FKfuyA2h0e80AwIM=;
        b=YlZbOPV2jQsMa9YaiMbcjHD1KQd5983HIzS/h8i3LhNyB9rsH+ykiTaodiqbjH9OaZ9Ubm
        gchKvy8Ng2pYE7hEqI6DBS6zwu1TssXOXwVLXV2A+wUYxgNlMB+7Hc8CU3eBr2Ajva2Z9V
        508J0wp6k6JttsoLkn5FgeBlsxdp4j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645759075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOhA2aVCQruRjVqsQIv/eDBGU84FKfuyA2h0e80AwIM=;
        b=BV3xyddoE4O3rEWnS5cQAWs7wZLlbjcyzj/m4AcAd6S6HwlYfu5x1Sjf1TOOGchzfDBIw2
        1wNPUMCenUKfrICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76B7F13B4B;
        Fri, 25 Feb 2022 03:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JIPUDGJKGGL3UwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 25 Feb 2022 03:17:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
In-reply-to: <73e0a536c0467693db87c3966cf02e20ff3d889b.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>,
 <20220223211305.296816-2-trondmy@kernel.org>,
 <20220223211305.296816-3-trondmy@kernel.org>,
 <20220223211305.296816-4-trondmy@kernel.org>,
 <20220223211305.296816-5-trondmy@kernel.org>,
 <20220223211305.296816-6-trondmy@kernel.org>,
 <20220223211305.296816-7-trondmy@kernel.org>,
 <20220223211305.296816-8-trondmy@kernel.org>,
 <20220223211305.296816-9-trondmy@kernel.org>,
 <20220223211305.296816-10-trondmy@kernel.org>,
 <20220223211305.296816-11-trondmy@kernel.org>,
 <20220223211305.296816-12-trondmy@kernel.org>,
 <20220223211305.296816-13-trondmy@kernel.org>,
 <20220223211305.296816-14-trondmy@kernel.org>,
 <20220223211305.296816-15-trondmy@kernel.org>,
 <20220223211305.296816-16-trondmy@kernel.org>,
 <20220223211305.296816-17-trondmy@kernel.org>,
 <20220223211305.296816-18-trondmy@kernel.org>,
 <20220223211305.296816-19-trondmy@kernel.org>,
 <20220223211305.296816-20-trondmy@kernel.org>,
 <EF67F180-F1D8-4291-92C8-86E5D10D1F25@redhat.com>,
 <73e0a536c0467693db87c3966cf02e20ff3d889b.camel@hammerspace.com>
Date:   Fri, 25 Feb 2022 14:17:49 +1100
Message-id: <164575906990.4638.4113048743095971193@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyNSBGZWIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFRodSwgMjAy
Mi0wMi0yNCBhdCAxMjozMSAtMDUwMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToKPiA+IAo+
ID4gIlRoZSBYQXJyYXkgaW1wbGVtZW50YXRpb24gaXMgZWZmaWNpZW50IHdoZW4gdGhlIGluZGlj
ZXMgdXNlZCBhcmUKPiA+IGRlbnNlbHkKPiA+IGNsdXN0ZXJlZDsgaGFzaGluZyB0aGUgb2JqZWN0
IGFuZCB1c2luZyB0aGUgaGFzaCBhcyB0aGUgaW5kZXggd2lsbAo+ID4gbm90Cj4gPiBwZXJmb3Jt
IHdlbGwuIgo+ID4gCj4gPiBIb3dldmVyLCB0aGUgIm5vdCBwZXJmb3JtIHdlbGwiIG1heSBiZSBv
cmRlcnMgb2YgbWFnbml0dWRlIHNtYWxsZXIKPiA+IHRoYW4KPiA+IGFudGhpbmcgbGlrZSBSUEMu
wqAgRG8geW91IGhhdmUgY29uY2VybnMgYWJvdXQgdGhpcz8KPiAKPiBXaGF0IGlzIHRoZSBkaWZm
ZXJlbmNlIGJldHdlZW4gdGhpcyB3b3JrbG9hZCBhbmQgYSByYW5kb20gYWNjZXNzCj4gZGF0YWJh
c2Ugd29ya2xvYWQ/CgpQcm9iYWJseSB0aGUgcmFuZ2Ugb2YgZXhwZWN0ZWQgYWRkcmVzc2VzLgpJ
ZiBJIHVuZGVyc3RhbmQgdGhlIHByb3Bvc2FsIGNvcnJlY3RseSwgdGhlIHBhZ2UgYWRkcmVzc2Vz
IGluIHRoaXMKd29ya2xvYWQgY291bGQgYmUgYW55IDY0Yml0IG51bWJlci4KRm9yIGEgbGFyZ2Ug
ZGF0YWJhc2UsIGl0IHdvdWxkIGJlIGF0IG1vc3QgNTIgYml0cyAoYXNzdW1pbmcgNjRiaXRzIHdv
cnRoCm9mIGJ5dGVzKSwgYW5kIHZlcnkgbGlrZWx5IHN1YnN0YW50aWFsbHkgc21hbGxlciAtIG1h
eWJlIDQwIGJpdHMgZm9yIGEKcmVhbGx5IHJlYWxseSBiaWcgZGF0YWJhc2UuCgo+IAo+IElmIHRo
ZSBYQXJyYXkgaXMgaW5jYXBhYmxlIG9mIGRlYWxpbmcgd2l0aCByYW5kb20gYWNjZXNzLCB0aGVu
IHdlCj4gc2hvdWxkIG5ldmVyIGhhdmUgY2hvc2VuIGl0IGZvciB0aGUgcGFnZSBjYWNoZS4gSSdt
IHRoZXJlZm9yZSBhc3N1bWluZwo+IHRoYXQgZWl0aGVyIHRoZSBhYm92ZSBjb21tZW50IGlzIHJl
ZmVycmluZyB0byBtaWNyby1vcHRpbWlzYXRpb25zIHRoYXQKPiBkb24ndCBtYXR0ZXIgbXVjaCB3
aXRoIHRoZXNlIHdvcmtsb2Fkcywgb3IgZWxzZSB0aGF0IHRoZSBwbGFuIGlzIHRvCj4gcmVwbGFj
ZSB0aGUgWEFycmF5IHdpdGggc29tZXRoaW5nIG1vcmUgYXBwcm9wcmlhdGUgZm9yIGEgcGFnZSBj
YWNoZQo+IHdvcmtsb2FkLgoKSSBoYXZlbid0IGxvb2tlZCBhdCB0aGUgY29kZSByZWNlbnRseSBz
byB0aGlzIG1pZ2h0IG5vdCBiZSAxMDAlCmFjY3VyYXRlLCBidXQgWEFycmF5IGdlbmVyYWxseSBh
c3N1bWVzIHRoYXQgcGFnZXMgYXJlIG9mdGVuIGFkamFjZW50LgpUaGV5IGRvbid0IGhhdmUgdG8g
YmUsIGJ1dCB0aGVyZSBpcyBhIGNvc3QuCkl0IHVzZXMgYSBtdWx0aS1sZXZlbCBhcnJheSB3aXRo
IDkgYml0cyBwZXIgbGV2ZWwuICBBdCBlYWNoIGxldmVsIHRoZXJlCmFyZSBhIHdob2xlIG51bWJl
ciBvZiBwYWdlcyBmb3IgaW5kZXhlcyB0byB0aGUgbmV4dCBsZXZlbC4KCklmIHRoZXJlIGFyZSB0
d28gZW50cmllcywgdGhhdCBhcmUgMl40NSBzZXBhcmF0ZSwgdGhhdCBpcyA1IGxldmVscyBvZgpp
bmRleGluZyB0aGF0IGNhbm5vdCBiZSBzaGFyZWQuICBTbyB0aGUgcGF0aCB0byBvbmUgZW50cnkg
aXMgNSBwYWdlcywKZWFjaCBvZiB3aGljaCBjb250YWlucyBhIHNpbmdsZSBwb2ludGVyLiAgVGhl
IHBhdGggdG8gdGhlIG90aGVyIGVudHJ5IGlzCmEgc2VwYXJhdGUgc2V0IG9mIDUgcGFnZXMuCgpT
byB3b3JzdCBjYXNlLCB0aGUgaW5kZXggd291bGQgYmUgYWJvdXQgNjQvOSBvciA3IHRpbWVzIHRo
ZSBzaXplIG9mIHRoZQpkYXRhLiAgQXMgdGhlIG51bWJlciBvZiBkYXRhIHBhZ2VzIGluY3JlYXNl
cywgdGhpcyB3b3VsZCBzaHJpbmsKc2xpZ2h0bHksIGJ1dCBJIHN1c3BlY3QgeW91IHdvdWxkbid0
IGdldCBiZWxvdyBhIGZhY3RvciBvZiAzIGJlZm9yZSB5b3UKZmlsbCB1cCBhbGwgb2YgeW91ciBt
ZW1vcnkuCgpOZWlsQnJvd24K
