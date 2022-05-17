Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93032529682
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 03:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiEQBFP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 21:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiEQBFP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 21:05:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C694616A
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 18:05:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 559051F8FB;
        Tue, 17 May 2022 01:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652749512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1z11KFIyVf5e1H1Q8IyLA08Ku48BcwDEhjZMuZK2ZA=;
        b=UM2cnuXGToQbdFA3OYoE06wZFI+/BXnoJRXooder/JfJ4D0Ajf/ELPcQkMXxXrzG6A45/F
        mNbXAzelhloXCcsZ9X/5+S6rKYyuCafgz7A0kDB+bLQvZo8re/qOWhmWPkPj43veKl4I+J
        ikOzQJ5bIIcoTjRI24V6SH8BhdHfHQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652749512;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1z11KFIyVf5e1H1Q8IyLA08Ku48BcwDEhjZMuZK2ZA=;
        b=m1a6a+jfbFOc0U/Tzpzw22FqlZHrX0xCeAKIo9BT6fBn+gDpy9xSxI+wRYfeB5tJr+p5Rx
        EVY3kd7PBV7YUEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4328113ADC;
        Tue, 17 May 2022 01:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1BvuAMf0gmKueAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 17 May 2022 01:05:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
Date:   Tue, 17 May 2022 11:05:07 +1000
Message-id: <165274950799.17247.7605561502483278140@noble.neil.brown.name>
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
Mi0wNS0xNyBhdCAxMDo0MCArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gVHVlLCAxNyBN
YXkgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiBPbiBUdWUsIDIwMjItMDUtMTcg
YXQgMTA6MDUgKzEwMDAsIE5laWxCcm93biB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiBIaSwKPiA+
ID4gPiDCoGFueSB0aG91Z2h0cyBvbiB0aGVzZSBwYXRjaGVzPwo+ID4gPiAKPiA+ID4gCj4gPiA+
IFRvIG1lLCB0aGlzIHByb2JsZW0gaXMgc2ltcGx5IG5vdCB3b3J0aCBicmVha2luZyBob3QgcGF0
aAo+ID4gPiBmdW5jdGlvbmFsaXR5Cj4gPiA+IGZvci4gSWYgdGhlIGNyZWRlbnRpYWwgY2hhbmdl
cyBvbiB0aGUgc2VydmVyLCBidXQgbm90IG9uIHRoZSBjbGllbnQKPiA+ID4gKHNvCj4gPiA+IHRo
YXQgdGhlIGNyZWQgY2FjaGUgY29tcGFyaXNvbiBzdGlsbCBtYXRjaGVzKSwgdGhlbiB3aHkgZG8g
d2UgY2FyZT8KPiA+ID4gCj4gPiA+IElPVzogSSdtIGEgTkFDSyB1bnRpbCBjb252aW5jZWQgb3Ro
ZXJ3aXNlLgo+ID4gCj4gPiBJbiB3aGF0IHdheSBpcyB0aGUgaG90IHBhdGggYnJva2VuP8KgIEl0
IG9ubHkgYWZmZWN0IGEgcGVybWlzc2lvbiB0ZXN0Cj4gPiBmYWlsdXJlLsKgIFdoeSBpcyB0aGF0
IGNvbnNpZGVyZWQgImhvdCBwYXRoIj8/Cj4gCj4gSXQgaXMgYSBwZXJtaXNzaW9uIHRlc3QgdGhh
dCBpcyBjcml0aWNhbCBmb3IgY2FjaGluZyBwYXRoIHJlc29sdXRpb24gb24KPiBhIHBlci11c2Vy
IGJhc2lzLgo+IAo+ID4gCj4gPiBSRkMgMTgxMyBzYXlzIC0gZm9yIE5GU3YzIGF0IGxlYXN0IC0g
Cj4gPiAKPiA+IMKgwqDCoMKgwqAgVGhlIGluZm9ybWF0aW9uIHJldHVybmVkIGJ5IHRoZSBzZXJ2
ZXIgaW4gcmVzcG9uc2UgdG8gYW4KPiA+IMKgwqDCoMKgwqAgQUNDRVNTIGNhbGwgaXMgbm90IHBl
cm1hbmVudC4gSXQgd2FzIGNvcnJlY3QgYXQgdGhlIGV4YWN0Cj4gPiDCoMKgwqDCoMKgIHRpbWUg
dGhhdCB0aGUgc2VydmVyIHBlcmZvcm1lZCB0aGUgY2hlY2tzLCBidXQgbm90Cj4gPiDCoMKgwqDC
oMKgIG5lY2Vzc2FyaWx5IGFmdGVyd2FyZHMuIFRoZSBzZXJ2ZXIgY2FuIHJldm9rZSBhY2Nlc3MK
PiA+IMKgwqDCoMKgwqAgcGVybWlzc2lvbiBhdCBhbnkgdGltZS4KPiA+IAo+ID4gQ2xlYXJseSB0
aGUgc2VydmVyIGNhbiBhbGxvdyBhbGxvdyBhY2Nlc3MgYXQgYW55IHRpbWUuCj4gPiBUaGlzIHNl
ZW1zIHRvIGFyZ3VlIGFnYWluc3QgY2FjaGluZyAtIG9yIGF0IGxlYXN0IGFnYWluc3QgcmVseWlu
ZyB0b28KPiA+IGhlYXZpbHkgb24gdGhlIGNhY2hlLgo+ID4gCj4gPiBSRkMgODg4MSBoYXMgdGhl
IHNhbWUgdGV4dCBmb3IgTkZTdjQuMSAtIHNlY3Rpb24gMTguMS40Cj4gPiAKPiA+ICJ3aHkgZG8g
d2UgY2FyZT8iIEJlY2F1c2UgdGhlIHNlcnZlciBoYXMgY2hhbmdlZCB0byBncmFudCBhY2Nlc3Ms
IGJ1dAo+ID4gdGhlIGNsaWVudCBpcyBpZ25vcmluZyB0aGUgcG9zc2liaWxpdHkgb2YgdGhhdCBj
aGFuZ2UgLSBzbyB0aGUgdXNlcgo+ID4gaXMKPiA+IHByZXZlbnRlZCBmcm9tIGRvaW5nIHdvcmsu
Cj4gCj4gVGhlIHNlcnZlciBlbmZvcmNlcyBwZXJtaXNzaW9ucyBpbiBORlMuIFRoZSBjbGllbnQg
cGVybWlzc2lvbnMgY2hlY2tzCj4gYXJlIHBlcmZvcm1lZCBpbiBvcmRlciB0byBnYXRlIGFjY2Vz
cyB0byBkYXRhIHRoYXQgaXMgYWxyZWFkeSBpbiBjYWNoZS4KClNvIGlmIHRoZSBwZXJtaXNzaW9u
IGNoZWNrIGZhaWxzLCB0aGVuIHRoZSBjbGllbnQgc2hvdWxkIGlnbm9yZSB0aGUKY2FjaGUgYW5k
IGFzayB0aGUgc2VydmVyIGZvciB0aGUgcmVxdWVzdGVkIGRhdGEsIHNvIHRoYXQgdGhlIHNlcnZl
ciBoYXMKYSBjaGFuY2UgdG8gZW5mb3JjZSB0aGUgcGVybWlzc2lvbnMgLSB3aGV0aGVyIGRlbnlp
bmcgb3IgYWxsb3dpbmcgdGhlCmFjY2Vzcy4KCkkgY29tcGxldGVseSBhZ3JlZSB3aXRoIHlvdSwg
YW5kIHRoYXQgaXMgZWZmZWN0aXZlbHkgd2hhdCBteSBwYXRjaAppbXBsZW1lbnRzLgoKTmVpbEJy
b3duCgoKPiBOQUNLCj4gCj4gLS0gCj4gVHJvbmQgTXlrbGVidXN0Cj4gTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQo+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20KPiAKPiAKPiAK
