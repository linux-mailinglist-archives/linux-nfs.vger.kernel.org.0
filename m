Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB36154B0
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 23:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKAWGB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 18:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKAWFn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 18:05:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166781D338
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 15:05:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA78222CB1;
        Tue,  1 Nov 2022 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667340326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGJHbUjBDzyTuzcH4eyn74IPeIW9YkkvB8Ku+5SniPs=;
        b=P2YcXByV38pFzj06sVVWU4uzt/wbHkSCYwV7mPFxzdtNyRsYyKjzIaMk6llPJkwmqfL6Kg
        zexO5J7X99id8bbDZ3HCzfYI44RA7tK7SOWtKhXQZi/L1v1dK7bm/1OC9wXoyVSthJxnvq
        Pwh494TSnXCGaJRX7CLYJJYlok02aYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667340326;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGJHbUjBDzyTuzcH4eyn74IPeIW9YkkvB8Ku+5SniPs=;
        b=mLOAiutr5of1dLNd8FPg/GX7BWalnYy7+j7QAPtfYThnLyhEfKxzovmmEgu18aEtnFzvzA
        KJK95Z5WgzE7KbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87B6413AAF;
        Tue,  1 Nov 2022 22:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3vSYDyWYYWNrCwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 01 Nov 2022 22:05:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
In-reply-to: <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
References: <20221101144647.136696-1-jlayton@kernel.org>,
 <20221101144647.136696-4-jlayton@kernel.org>,
 <166733783854.19313.2332783814411405159@noble.neil.brown.name>,
 <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
Date:   Wed, 02 Nov 2022 09:05:21 +1100
Message-id: <166734032156.19313.13594422911305212646@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAwMiBOb3YgMjAyMiwgSmVmZiBMYXl0b24gd3JvdGU6Cj4gT24gV2VkLCAyMDIyLTEx
LTAyIGF0IDA4OjIzICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gPiBPbiBXZWQsIDAyIE5vdiAy
MDIyLCBKZWZmIExheXRvbiB3cm90ZToKPiA+ID4gVGhlIGZpbGVjYWNoZSByZWZjb3VudGluZyBp
cyBhIGJpdCBub24tc3RhbmRhcmQgZm9yIHNvbWV0aGluZyBzZWFyY2hhYmxlCj4gPiA+IGJ5IFJD
VSwgaW4gdGhhdCB3ZSBtYWludGFpbiBhIHNlbnRpbmVsIHJlZmVyZW5jZSB3aGlsZSBpdCdzIGhh
c2hlZC4gVGhpcwo+ID4gPiBpbiB0dXJuIHJlcXVpcmVzIHRoYXQgd2UgaGF2ZSB0byBkbyB0aGlu
Z3MgZGlmZmVyZW50bHkgaW4gdGhlICJwdXQiCj4gPiA+IGRlcGVuZGluZyBvbiB3aGV0aGVyIGl0
cyBoYXNoZWQsIHdoaWNoIHdlIGJlbGlldmUgdG8gaGF2ZSBsZWQgdG8gcmFjZXMuCj4gPiA+IAo+
ID4gPiBUaGVyZSBhcmUgb3RoZXIgcHJvYmxlbXMgaW4gaGVyZSB0b28uIG5mc2RfZmlsZV9jbG9z
ZV9pbm9kZV9zeW5jIGNhbiBlbmQKPiA+ID4gdXAgZnJlZWluZyBhbiBuZnNkX2ZpbGUgd2hpbGUg
dGhlcmUgYXJlIHN0aWxsIG91dHN0YW5kaW5nIHJlZmVyZW5jZXMgdG8KPiA+ID4gaXQsIGFuZCB0
aGVyZSBhcmUgYSBudW1iZXIgb2Ygc3VidGxlIFRvQy9Ub1UgcmFjZXMuCj4gPiA+IAo+ID4gPiBS
ZXdvcmsgdGhlIGNvZGUgc28gdGhhdCB0aGUgcmVmY291bnQgaXMgd2hhdCBkcml2ZXMgdGhlIGxp
ZmVjeWNsZS4gV2hlbgo+ID4gPiB0aGUgcmVmY291bnQgZ29lcyB0byB6ZXJvLCB0aGVuIHVuaGFz
aCBhbmQgcmN1IGZyZWUgdGhlIG9iamVjdC4KPiA+ID4gCj4gPiA+IFdpdGggdGhpcyBjaGFuZ2Us
IHRoZSBMUlUgY2FycmllcyBhIHJlZmVyZW5jZS4gVGFrZSBzcGVjaWFsIGNhcmUgdG8KPiA+ID4g
ZGVhbCB3aXRoIGl0IHdoZW4gcmVtb3ZpbmcgYW4gZW50cnkgZnJvbSB0aGUgbGlzdC4KPiA+IAo+
ID4gVGhlIHJlZmNvdW50aW5nIGFuZCBscnUgbWFuYWdlbWVudCBhbGwgbG9vayBzYW5lIGhlcmUu
Cj4gPiAKPiA+IFlvdSBuZWVkIHRvIGhhdmUgbW92ZWQgdGhlIGZpbmFsIHB1dCAoYW5kIGNvcnJl
c3BvbmRpbmcgZnN5bmMpIHRvCj4gPiBkaWZmZXJlbnQgdGhyZWFkcy4gIEkgdGhpbmsgSSBzZWUg
eW91IGFuZCBDaHVjayBkaXNjdXNzaW5nIHRoYXQgYW5kIEkKPiA+IGhhdmUgbm8gc2Vuc2Ugb2Yg
d2hhdCBpcyAicmlnaHQiLsKgCj4gPiAKPiAKPiBZZWFoLCB0aGlzIGlzIGEgdG91Z2ggY2FsbC4g
SSBnZXQgQ2h1Y2sncyByZXRpY2VuY2UuCj4gCj4gT25lIHRoaW5nIHdlIGNvdWxkIGNvbnNpZGVy
IGlzIG9mZmxvYWRpbmcgdGhlIFNZTkNfTk9ORSB3cml0ZWJhY2sKPiBzdWJtaXNzaW9uIHRvIGEg
d29ya3F1ZXVlLiBJJ20gbm90IHN1cmUgdGhvdWdoIHdoZXRoZXIgdGhhdCdzIGEgd2luIC0tCj4g
aXQgbWlnaHQganVzdCBhZGQgbmVlZGxlc3MgY29udGV4dCBzd2l0Y2hlcy4gT1RPSCwgdGhhdCB3
b3VsZCBtYWtlIGl0Cj4gZmFpcmx5IHNpbXBsZSB0byBraWNrIG9mZiB3cml0ZWJhY2sgd2hlbiB0
aGUgUkVGRVJFTkNFRCBmbGFnIGlzIGNsZWFyZWQsCj4gd2hpY2ggd291bGQgcHJvYmFibHkgYmUg
dGhlIGJlc3QgdGltZSB0byBkbyBpdC4KPiAKPiBBbiBlbnRyeSB0aGF0IGVuZHMgdXAgYmVpbmcg
aGFydmVzdGVkIGJ5IHRoZSBMUlUgc2Nhbm5lciBpcyBnb2luZyB0byBiZQo+IHRvdWNoZWQgYnkg
aXQgYXQgbGVhc3QgdHdpY2U6IG9uY2UgdG8gY2xlYXIgdGhlIFJFRkVSRU5DRUQgZmxhZywgYW5k
Cj4gYWdhaW4gfjJzIGxhdGVyIHRvIHJlYXAgaXQuCj4gCj4gSWYgd2Ugc2NoZWR1bGUgd3JpdGVi
YWNrIHdoZW4gd2UgY2xlYXIgdGhlIGZsYWcgdGhlbiB3ZSBoYXZlIGEgcHJldHR5Cj4gZ29vZCBp
bmRpY2F0aW9uIHRoYXQgbm90aGluZyBlbHNlIGlzIGdvaW5nIHRvIGJlIHVzaW5nIGl0ICh0aG91
Z2ggSQo+IHRoaW5rIHdlIG5lZWQgdG8gY2xlYXIgUkVGRVJFTkNFRCBldmVuIHdoZW4gbmZzZF9m
aWxlX2NoZWNrX3dyaXRlYmFjawo+IHJldHVybnMgdHJ1ZSAtLSBJJ2xsIGZpeCB0aGF0IGluIHRo
ZSBjb21pbmcgc2VyaWVzKS4KPiAKPiBJbiBhbnkgY2FzZSwgSSdkIHByb2JhYmx5IGxpa2UgdG8g
ZG8gdGhhdCBzb3J0IG9mIGNoYW5nZSBpbiBhIHNlcGFyYXRlCj4gc2VyaWVzIGFmdGVyIHdlIGdl
dCB0aGUgZmlyc3QgcGFydCBzb3J0ZWQuCj4gCj4gPiBCdXQgaXQgd291bGQgYmUgbmljZSB0byBl
eHBsYWluIGluCj4gPiB0aGUgY29tbWVudCB3aGF0IGlzIGJlaW5nIG1vdmVkIGFuZCB3aHksIHNv
IEkgY291bGQgdGhlbiBjb25maXJtIHRoYXQKPiA+IHRoZSBjb2RlIG1hdGNoZXMgdGhlIGludGVu
dC4KPiA+IAo+IAo+IEknbSBoYXBweSB0byBhZGQgY29tbWVudHMsIGJ1dCBJJ20gYSBsaXR0bGUg
dW5jbGVhciBvbiB3aGF0IHlvdSdyZQo+IGNvbmZ1c2VkIGJ5IGhlcmUuIEl0J3MgYSBiaXQgdG9v
IGJpZyBvZiBhIHBhdGNoIGZvciBtZSB0byBnaXZlIGEgZnVsbAo+IHBsYXktYnktcGxheSBkZXNj
cmlwdGlvbi4gQ2FuIHlvdSBlbGFib3JhdGUgb24gd2hhdCB5b3UnZCBsaWtlIHRvIHNlZT8KPiAK
CkkgZG9uJ3QgbmVlZCBibG93LWJ5LWJsb3csIGJ1dCBhbGwgdGhlIGJlaGF2aW91cmFsIGNoYW5n
ZXMgc2hvdWxkIGF0CmxlYXN0IGJlIGZsYWdnZWQgaW4gdGhlIGludHJvLCBhbmQgcG9zc2libHkg
ZXhwbGFpbmVkLgpUaGUgb25lIEkgcGFydGljdWxhcmx5IG5vdGljZWQgaXMgaW4gbmZzZF9maWxl
X2Nsb3NlX2lub2RlKCkgd2hpY2gKcHJldmlvdXNseSB1c2VkIG5mc2RfZmlsZV9kaXNwb3NlX2xp
c3QoKSB3aGljaCBoYW5kcyB0aGUgZmluYWwgY2xvc2Ugb2ZmCnRvIG5mc2RfZmlsZWNhY2hlX3dx
LgpCdXQgdGhpcyBwYXRjaCBub3cgZG9lcyB0aGUgZmluYWwgY2xvc2UgaW4tbGluZSBzbyBhbiBm
c25vdGlmeSBldmVudAptaWdodCBub3cgZG8gdGhlIGZzeW5jLiAgSSB3YXMgYXNzdW1pbmcgdGhh
dCB3YXMgZGVsaWJlcmF0ZSBhbmQgd2FudGVkCml0IHRvIGJlIGV4cGxhaW5lZC4gIEJ1dCBtYXli
ZSBpdCB3YXNuJ3QgZGVsaWJlcmF0ZT8KClRoZSBtb3ZlbWVudCBvZiBmbHVzaF9kZWxheWVkX2Zw
dXQoKSB0aHJldyBtZSBhdCBmaXJzdCwgYnV0IEkgdGhpbmsgSQp1bmRlcnN0YW5kIGl0IG5vdyAt
IHRoZSBuZXcgY29kZSBmb3IgY2xvc2VfaW5vZGVfc3luYyBpcyBtdWNoIGNsZWFuZXIsCm5vdCBu
ZWVkaW5nIGRpc3Bvc2VfbGlzdF9zeW5jLgoKVGhhbmtzLApOZWlsQnJvd24KCg==
