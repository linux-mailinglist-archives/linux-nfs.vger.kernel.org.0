Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466823DF942
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 03:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhHDBaq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 21:30:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhHDBao (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 21:30:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DAD41FD88;
        Wed,  4 Aug 2021 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628040630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtRYzBhwKJGPOzNtVqjwvIxG6OraI4B3drDeH3Xi4Hk=;
        b=SRqSh+7i8R+Eptv+hxdsLPGR08Oc+QRMXI8u2Latphb+pZs5Xdva4BcJFcmg9ktjpmI68k
        yjb5JtjaIJgfm8yCT5nHQlEraQA0NrgKFewqvisP86iMrQsAsu7ZQFsMqU6GLafH91I7R3
        2HeKlFNvSY/h46kYHljxzBSbR78z2AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628040630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtRYzBhwKJGPOzNtVqjwvIxG6OraI4B3drDeH3Xi4Hk=;
        b=2DLaayZv5UOIrAlxgmhp/mqqGOlwQ5ayk4ZteFXzQiZsf8s+ngmDzsf1oZMBEqz5p40ezL
        s6CmF4uWmBEOT8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA76E13AEA;
        Wed,  4 Aug 2021 01:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ca58IbTtCWEQJwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 04 Aug 2021 01:30:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
In-reply-to: <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>,
 <20210803203051.GA3043@fieldses.org>,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>,
 <20210803213642.GA4042@fieldses.org>,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>,
 <162803443497.32159.4120609262211305187@noble.neil.brown.name>,
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>,
 <162803867150.32159.9013174090922030713@noble.neil.brown.name>,
 <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
Date:   Wed, 04 Aug 2021 11:30:23 +1000
Message-id: <162804062307.32159.5606967736886802956@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAwNCBBdWcgMjAyMSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFdlZCwgMjAy
MS0wOC0wNCBhdCAxMDo1NyArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gV2VkLCAwNCBB
dWcgMjAyMSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiAKPiA+ID4gTm8uIFdoYXQgeW91
IHByb3Bvc2UgaXMgdG8gb3B0aW1pc2UgZm9yIGEgZnJpbmdlIGNhc2UsIHdoaWNoIHdlCj4gPiA+
IGNhbm5vdAo+ID4gPiBndWFyYW50ZWUgd2lsbCB3b3JrIGFueXdheS4gSSdkIG11Y2ggcmF0aGVy
IG9wdGltaXNlIGZvciB0aGUgY29tbW9uCj4gPiA+IGNhc2UsIHdoaWNoIGlzIHRoZSBvbmx5IGNh
c2Ugd2l0aCBwcmVkaWN0YWJsZSBzZW1hbnRpY3MuCj4gPiA+IAo+ID4gCj4gPiAicHJlZGljdGFi
bGUiPz8KPiA+IAo+ID4gQXMgSSB1bmRlcnN0YW5kIGl0IChJIGhhdmVuJ3QgZXhhbWluZWQgdGhl
IGNvZGUpIHRoZSBjdXJyZW50Cj4gPiBzZW1hbnRpY3MKPiA+IGluY2x1ZGVzOgo+ID4gwqBJZiBh
IGZpbGUgaXMgb3BlbiBmb3IgcmVhZCwgc29tZSBvdGhlciBjbGllbnQgY2hhbmdlZCB0aGUgZmls
ZSwgYW5kCj4gPiB0aGUKPiA+IMKgIGZpbGUgaXMgdGhlbiBvcGVuZWQsIHRoZW4gdGhlIHNlY29u
ZCBvcGVuIG1pZ2h0IHNlZSBuZXcgZGF0YSwgb3IKPiA+IG1pZ2h0Cj4gPiDCoCBzZWUgb2xkIGRh
dGEsIGRlcGVuZGluZyBvbiB3aGV0aGVyIHRoZSByZXF1ZXN0ZWQgZGF0YSBpcyBzdGlsbCBpbgo+
ID4gwqAgY2FjaGUgb3Igbm90Lgo+ID4gCj4gPiBJIGZpbmQgdGhpcyB0byBiZSBsZXNzIHByZWRp
Y3RhYmxlIHRoYW4gdGhlIGVhc3ktdG8tdW5kZXJzdGFuZAo+ID4gc2VtYW50aWNzCj4gPiB0aGF0
IEJydWNlIGhhcyBxdW90ZWQ6Cj4gPiDCoCAtIHJldmFsaWRhdGUgb24gZXZlcnkgb3BlbiwgZmx1
c2ggb24gZXZlcnkgY2xvc2UKPiA+IAo+ID4gSSdtIHN1Z2dlc3Rpbmcgd2Ugb3B0aW1pemUgZm9y
IGZyaW5nZSBjYXNlcywgSSdtIHN1Z2dlc3Rpbmcgd2UKPiA+IHByb3ZpZGUKPiA+IHNlbWFudGlj
cyB0aGF0IGFyZSBzaW1wbGUsIGRvY3VtZW50YXRlZCwgYW5kIHByZWRpY3RhYmxlLgo+ID4gCj4g
Cj4gIlByZWRpY3RhYmxlIiBob3c/Cj4gCj4gVGhpcyBpcyBjYWNoZWQgSS9PLiBCeSBkZWZpbml0
aW9uLCBpdCBpcyBhbGxvd2VkIHRvIGRvIHRoaW5ncyBsaWtlCj4gcmVhZGFoZWFkLCB3cml0ZWJh
Y2sgY2FjaGluZywgbWV0YWRhdGEgY2FjaGluZy4gV2hhdCB5b3UncmUgcHJvcG9zaW5nCj4gaXMg
dG8gb3B0aW1pc2UgZm9yIGEgY2FzZSB0aGF0IGJyZWFrcyBhbGwgb2YgdGhlIGFib3ZlLiBXaGF0
J3MgdGhlCj4gcG9pbnQ/IFdlIG1pZ2h0IGp1c3QgYXMgd2VsbCB0aHJvdyBpbiB0aGUgdG93ZWwg
YW5kIGp1c3QgbWFrZSB1bmNhY2hlZAo+IEkvTyBhbmQgJ25vYWMnIG1vdW50cyB0aGUgZGVmYXVs
dC4KCkhvdyBhcmUgcmVhZGFoZWFkLCBhbmQgb3RoZXIgY2FjaGluZyBicm9rZW4/IEluZGVlZCwg
aG93IGFyZSB0aGV5IGV2ZW4KcHJlZGljdGFibGU/IENhY2hpbmcgaXMgYWxtb3N0IGJ5IGRlZmlu
aXRpb24gYSBiZXN0LWVmZm9ydC4gIFJlYWQKcmVxdWVzdHMgbWF5LCBvciBtYXkgbm90LCBiZSBz
ZXJ2ZWQgZnJvbSByZWFkLWFoZWFkIGRhdGEuICBXcml0ZSBtYXliZQp3cml0dGVuIGJhY2sgc29v
bmVyIG9yIGxhdGVyLiAgVmFyaW91cyBzeXN0ZW0tbG9hZCBmYWN0b3JzIGNhbiBhZmZlY3QKdGhp
cy4gICBZb3UgY2FuIG5ldmVyIHByZWRpY3QgdGhhdCBhIGNhY2hlICp3aWxsKiBiZSB1c2VkLgoK
InJldmFsaWRhdGUgb24gZXZlcnkgb3BlbiwgZmx1c2ggb24gZXZlcnkgY2xvc2UiIChpbiB0aGUg
YWJzZW5jZSBvZgpkZWxlZ2F0aW9ucyBvZiBjb3Vyc2UpIHByb3ZpZGVzIGFjY2VzcyB0byB0aGUg
b25seSBlbGVtZW50IG9mIGNhY2hlCmJlaGF2aW91ciB0aGF0ICpjYW4qIGJlIHByZWRpY3RhYmxl
OiB0aGUgdGltZXMgd2hlbiBpdCAqd29udCogYmUgdXNlZC4KCk5laWxCcm93bgo=
