Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4E5296A8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 03:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiEQBWu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiEQBWs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 21:22:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68B727163
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 18:22:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B3A922043;
        Tue, 17 May 2022 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652750566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggkwnsqQnQWp0PmpS3yKikmiu/ce4pioSNg+BK8Ipho=;
        b=E3U54IcyTTtstiEA5gwkqyqfB4upFcIKHsZXt0u07vpdtM5LpNhNEpkSS3b2UkJonbLX0K
        xHfhLxy9hHlquM414Y/r6RnPgQNV/b/HsxKco/JZMQpsYQpS0EWw1Wvnn5TVw69FYD7YON
        NDDJb0b/nTBdlUrgWk28PVhBA+HiwDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652750566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggkwnsqQnQWp0PmpS3yKikmiu/ce4pioSNg+BK8Ipho=;
        b=nlRlg3wFiSmGg/aiXOCITneJhPE9aQthFD9qmy/tYbm6IZTGkHRv4a4H0dN3Us3lb9V/Xo
        hdKmRSeFtv9go3Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58A1813ADC;
        Tue, 17 May 2022 01:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rvMkBeX4gmKzfQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 17 May 2022 01:22:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>,
 <165274950799.17247.7605561502483278140@noble.neil.brown.name>,
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
Date:   Tue, 17 May 2022 11:22:42 +1000
Message-id: <165275056203.17247.1826100963816464474@noble.neil.brown.name>
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
Mi0wNS0xNyBhdCAxMTowNSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gVHVlLCAxNyBN
YXkgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiBPbiBUdWUsIDIwMjItMDUtMTcg
YXQgMTA6NDAgKzEwMDAsIE5laWxCcm93biB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIDE3IE1heSAy
MDIyLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6Cj4gPiA+ID4gPiBPbiBUdWUsIDIwMjItMDUtMTcg
YXQgMTA6MDUgKzEwMDAsIE5laWxCcm93biB3cm90ZToKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IEhpLAo+ID4gPiA+ID4gPiDCoGFueSB0aG91Z2h0cyBvbiB0aGVzZSBwYXRjaGVzPwo+ID4gPiA+
ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRvIG1lLCB0aGlzIHByb2JsZW0gaXMgc2ltcGx5IG5v
dCB3b3J0aCBicmVha2luZyBob3QgcGF0aAo+ID4gPiA+ID4gZnVuY3Rpb25hbGl0eQo+ID4gPiA+
ID4gZm9yLiBJZiB0aGUgY3JlZGVudGlhbCBjaGFuZ2VzIG9uIHRoZSBzZXJ2ZXIsIGJ1dCBub3Qg
b24gdGhlCj4gPiA+ID4gPiBjbGllbnQKPiA+ID4gPiA+IChzbwo+ID4gPiA+ID4gdGhhdCB0aGUg
Y3JlZCBjYWNoZSBjb21wYXJpc29uIHN0aWxsIG1hdGNoZXMpLCB0aGVuIHdoeSBkbyB3ZQo+ID4g
PiA+ID4gY2FyZT8KPiA+ID4gPiA+IAo+ID4gPiA+ID4gSU9XOiBJJ20gYSBOQUNLIHVudGlsIGNv
bnZpbmNlZCBvdGhlcndpc2UuCj4gPiA+ID4gCj4gPiA+ID4gSW4gd2hhdCB3YXkgaXMgdGhlIGhv
dCBwYXRoIGJyb2tlbj/CoCBJdCBvbmx5IGFmZmVjdCBhIHBlcm1pc3Npb24KPiA+ID4gPiB0ZXN0
Cj4gPiA+ID4gZmFpbHVyZS7CoCBXaHkgaXMgdGhhdCBjb25zaWRlcmVkICJob3QgcGF0aCI/Pwo+
ID4gPiAKPiA+ID4gSXQgaXMgYSBwZXJtaXNzaW9uIHRlc3QgdGhhdCBpcyBjcml0aWNhbCBmb3Ig
Y2FjaGluZyBwYXRoCj4gPiA+IHJlc29sdXRpb24gb24KPiA+ID4gYSBwZXItdXNlciBiYXNpcy4K
PiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gUkZDIDE4MTMgc2F5cyAtIGZvciBORlN2MyBhdCBsZWFz
dCAtIAo+ID4gPiA+IAo+ID4gPiA+IMKgwqDCoMKgwqAgVGhlIGluZm9ybWF0aW9uIHJldHVybmVk
IGJ5IHRoZSBzZXJ2ZXIgaW4gcmVzcG9uc2UgdG8gYW4KPiA+ID4gPiDCoMKgwqDCoMKgIEFDQ0VT
UyBjYWxsIGlzIG5vdCBwZXJtYW5lbnQuIEl0IHdhcyBjb3JyZWN0IGF0IHRoZSBleGFjdAo+ID4g
PiA+IMKgwqDCoMKgwqAgdGltZSB0aGF0IHRoZSBzZXJ2ZXIgcGVyZm9ybWVkIHRoZSBjaGVja3Ms
IGJ1dCBub3QKPiA+ID4gPiDCoMKgwqDCoMKgIG5lY2Vzc2FyaWx5IGFmdGVyd2FyZHMuIFRoZSBz
ZXJ2ZXIgY2FuIHJldm9rZSBhY2Nlc3MKPiA+ID4gPiDCoMKgwqDCoMKgIHBlcm1pc3Npb24gYXQg
YW55IHRpbWUuCj4gPiA+ID4gCj4gPiA+ID4gQ2xlYXJseSB0aGUgc2VydmVyIGNhbiBhbGxvdyBh
bGxvdyBhY2Nlc3MgYXQgYW55IHRpbWUuCj4gPiA+ID4gVGhpcyBzZWVtcyB0byBhcmd1ZSBhZ2Fp
bnN0IGNhY2hpbmcgLSBvciBhdCBsZWFzdCBhZ2FpbnN0IHJlbHlpbmcKPiA+ID4gPiB0b28KPiA+
ID4gPiBoZWF2aWx5IG9uIHRoZSBjYWNoZS4KPiA+ID4gPiAKPiA+ID4gPiBSRkMgODg4MSBoYXMg
dGhlIHNhbWUgdGV4dCBmb3IgTkZTdjQuMSAtIHNlY3Rpb24gMTguMS40Cj4gPiA+ID4gCj4gPiA+
ID4gIndoeSBkbyB3ZSBjYXJlPyIgQmVjYXVzZSB0aGUgc2VydmVyIGhhcyBjaGFuZ2VkIHRvIGdy
YW50IGFjY2VzcywKPiA+ID4gPiBidXQKPiA+ID4gPiB0aGUgY2xpZW50IGlzIGlnbm9yaW5nIHRo
ZSBwb3NzaWJpbGl0eSBvZiB0aGF0IGNoYW5nZSAtIHNvIHRoZQo+ID4gPiA+IHVzZXIKPiA+ID4g
PiBpcwo+ID4gPiA+IHByZXZlbnRlZCBmcm9tIGRvaW5nIHdvcmsuCj4gPiA+IAo+ID4gPiBUaGUg
c2VydmVyIGVuZm9yY2VzIHBlcm1pc3Npb25zIGluIE5GUy4gVGhlIGNsaWVudCBwZXJtaXNzaW9u
cwo+ID4gPiBjaGVja3MKPiA+ID4gYXJlIHBlcmZvcm1lZCBpbiBvcmRlciB0byBnYXRlIGFjY2Vz
cyB0byBkYXRhIHRoYXQgaXMgYWxyZWFkeSBpbgo+ID4gPiBjYWNoZS4KPiA+IAo+ID4gU28gaWYg
dGhlIHBlcm1pc3Npb24gY2hlY2sgZmFpbHMsIHRoZW4gdGhlIGNsaWVudCBzaG91bGQgaWdub3Jl
IHRoZQo+ID4gY2FjaGUgYW5kIGFzayB0aGUgc2VydmVyIGZvciB0aGUgcmVxdWVzdGVkIGRhdGEs
IHNvIHRoYXQgdGhlIHNlcnZlcgo+ID4gaGFzCj4gPiBhIGNoYW5jZSB0byBlbmZvcmNlIHRoZSBw
ZXJtaXNzaW9ucyAtIHdoZXRoZXIgZGVueWluZyBvciBhbGxvd2luZyB0aGUKPiA+IGFjY2Vzcy4K
PiA+IAo+ID4gSSBjb21wbGV0ZWx5IGFncmVlIHdpdGggeW91LCBhbmQgdGhhdCBpcyBlZmZlY3Rp
dmVseSB3aGF0IG15IHBhdGNoCj4gPiBpbXBsZW1lbnRzLgo+ID4gCj4gCj4gTm8uIEknbSBzYXlp
bmcgdGhhdCBubyBtYXR0ZXIgaG93IG1hbnkgc3BlYyBwYXJhZ3JhcGhzIHlvdSBxdW90ZSBhdCBt
ZSwKPiBJJ20gbm90IHdpbGxpbmcgdG8gaW50cm9kdWNlIGEgdGltZW91dCBvbiBhIGNhY2hlIHRo
YXQgaXMgY3JpdGljYWwgZm9yCj4gcGF0aCByZXNvbHV0aW9uIGluIG9yZGVyIHRvIGFkZHJlc3Mg
YSBjb3JuZXIgY2FzZSBvZiBhIGNvcm5lciBjYXNlLgo+IAo+IEknbSBzYXlpbmcgdGhhdCBpZiB5
b3Ugd2FudCB0aGlzIHByb2JsZW0gZml4ZWQsIHRoZW4geW91IG5lZWQgdG8gbG9vawo+IGF0IGEg
ZGlmZmVyZW50IHNvbHV0aW9uIHRoYXQgZG9lc24ndCBoYXZlIHNpZGUtZWZmZWN0cyBmb3IgdGhl
Cj4gOTkuOTk5OTklIGNhc2VzIG9yIG1vcmUgdGhhdCBJIGRvIGNhcmUgYWJvdXQuCgpXaGF0LCBz
cGVjaWZpY2FsbHksIGFzIHRoZSBjYXNlcyB0aGF0IHlvdSBkbyBjYXJlIGFib3V0PwoKSSBhc3N1
bWVkIHRoYXQgdGhlIGNhc2VzIHlvdSBjYXJlIGFib3V0IGFyZSBjYXNlcyB3aGVyZSB0aGUgdXNl
ciAqZG9lcyoKaGF2ZSBhY2Nlc3MsIGFuZCB3aGVyZSB0aGlzIGFjY2VzcyBpcyBjb3JyZWN0bHkg
Y2FjaGVkLCBzbyB0aGF0IGEgCiAgcGVybWlzc2lvbiguLi4sIE1BWV9FWEVDKQpjYWxsIHJldHVy
bnMgaW1tZWRpYXRlbHkgd2l0aCBhIHBvc2l0aXZlIGFuc3dlci4KSSBjYXJlIGFib3V0IHRoZXNl
IGNhc2VzIHRvbywgYW5kIEkndmUgZW5zdXJlZCB0aGF0IHRoZSBwYXRjaCBkb2Vzbid0CmNoYW5n
ZSB0aGUgYmVoYXZpb3VyIGZvciB0aGVzZSBjYXNlcy4KCldoYXQgb3RoZXIgY2FzZXMgLSBjYXNl
cyB3aGVyZSBwZXJtaXNzaW9uKCkgcmV0dXJucyBhbiBlcnJvciAtIGRvIHlvdSBjYXJlCmFib3V0
PyAKClRoYW5rcywKTmVpbEJyb3duCg==
