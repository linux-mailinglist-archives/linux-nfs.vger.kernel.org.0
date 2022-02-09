Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D44B034B
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 03:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiBJCX4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 21:23:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiBJCX4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 21:23:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2C22BC8
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:23:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B568D1F391;
        Wed,  9 Feb 2022 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644451095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkYwuKQbSYZ/6oxQXH48ZSE36KmoGvlnt5giObVrCoM=;
        b=FrLnCJOcdaaHzmxA/faK/zuuiPPa5t/OXvId5VgF1XLOHZbot/k21dbKfY7q5C4fueoftz
        uLHpVD9NTG6+EcV+glRl8/RdzYLfUHXGNxmowFDuuJ69oN3nCvlD3SYhkir/I0wXV05JLQ
        vurwLAxnGV95JC5k1ZnZaCz1hhIwQeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644451095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkYwuKQbSYZ/6oxQXH48ZSE36KmoGvlnt5giObVrCoM=;
        b=/gJxPd7vnT2mO6B1fBIoaG3fROtayK4RW26a4T51dj9J5YrggUvdqtsF1GulpKcr/+U23f
        kshE85zQ+Ld39/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53336134AD;
        Wed,  9 Feb 2022 23:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m9GaAxZVBGKWVQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 09 Feb 2022 23:58:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "steved@redhat.com" <steved@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
In-reply-to: <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>
References: =?utf-8?q?=3Cc2e8b7c06352d3cad3454de096024fff80e638af=2E16439791?=
 =?utf-8?q?61=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>,
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>,
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>,
 <164444169523.27779.10904328736784652852@noble.neil.brown.name>,
 <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>
Date:   Thu, 10 Feb 2022 10:58:10 +1100
Message-id: <164445109064.27779.13269022853115063257@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAxMCBGZWIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFRodSwgMjAy
Mi0wMi0xMCBhdCAwODoyMSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gCj4gPiBJJ20gbm90
IHN1cmUgaWYgdGhpcyBoYXMgYmVlbiBleHBsaWNpdGx5IGFuc3dlcmVkIG9yIG5vdCwgc28ganVz
dCBpbgo+ID4gY2FzZS4uLiAKPiA+IMKgIGlmICJpcCBuZXRucy9pZGVudGlmeSIgcmVwb3J0IE5B
TUUsIHRoZW4gdXNlIC9ldGMvbmV0bnMvTkFNRS9mb28KPiA+IMKgIGlmIGl0IGZhaWxzIG9yIHJl
cG9ydCBub3RoaW5nLCB1c2UgL2V0Yy9mb28KPiA+IAo+ID4gSSB0aGluayB0aGlzIGlzIHJlcXVp
cmVkIHdoZXRoZXIgd2UgdXNlIG5mczQtaWQsIG5mcy1pZCwgbmZzLQo+ID4gaWRlbnRpdHksCj4g
PiBuZnMuY29uZi5kL2lkZW50aXR5LmNvbmYgb3IgYW55IG90aGVyIGZpbGUgaW4gL2V0Yy4KPiA+
IAo+IAo+IFdobyB1c2VzIHRoaXMgdG9vbCwgYW5kIGZvciB3aGF0PyBUaGlzIGlzbid0IGFueXRo
aW5nIHRoYXQgdGhlIHN0YW5kYXJkCj4gY29udGFpbmVyIG9yY2hlc3RyYXRpb24gbWFuYWdlcnMg
dXNlLgoKQXQgYSBndWVzcywgSSdkIHNheSBpdCB3b3VsZCBiZSB1c2VkIGJ5IGFueW9uZSB3aG8g
anVzdCB3YW50cyB0byBzZXQgdXAKYSBzZXBhcmF0ZSBuZXR3b3JrIG5hbWVzcGFjZSwgbm90IG5l
Y2Vzc2FyaWx5IGEgZnVsbCAiY29udGFpbmVyIi4KCj4gCj4gSSdtIHJ1bm5pbmcgZG9ja2VyIHJp
Z2h0IG5vdzoKPiAKPiBOUl8wOS0yMTo0MTowNyBob3N0IH4gJCBscyAvZXRjL25ldCoKPiAvZXRj
L25ldGNvbmZpZyAgL2V0Yy9uZXR3b3Jrcwo+IE5SXzA5LTIxOjQxOjQ3IGhvc3RzIH4gJCBkb2Nr
ZXIgZXhlYyAtaXQgZjdkZWJjMDc5ZjRlIGJhc2gKPiBbcm9vdEBmN2RlYmMwNzlmNGUgL10jIGxz
IC9ldGMvbmV0Kgo+IC9ldGMvbmV0Y29uZmlnICAvZXRjL25ldHdvcmtzCj4gW3Jvb3RAZjdkZWJj
MDc5ZjRlIC9dIyBpcCBuZXRucyBpZGVudGlmeQo+IAo+IFtyb290QGY3ZGViYzA3OWY0ZSAvXSMg
Cj4gCj4gQXMgeW91IGNhbiBzZWUsIG5laXRoZXIgdGhlIGhvc3Qgbm9yIHRoZSBjb250YWluZXIg
aGF2ZSBhbnl0aGluZyBpbgo+IC9ldGMvbmV0bnMsIGFuZCAnaXAgbmV0bnMgaWRlbnRpZnknIGlz
IGRyYXdpbmcgYSBibGFuayBpbiBib3RoLgo+IAoKT25lIG9mIHRoZSBvcmlnaW5hbCByZWFzb25z
IGdpdmVuIHRvIHJlamVjdCB0aGUgaWRlYSBvZiB1c2luZwovZXRjL25mcy5jb25meywuZH0gd2Fz
IHRoYXQgaXMgd2Fzbid0ICJjb250YWluZXIgYXdhcmUiLgpJIHRyaWVkIHRvIGZpbmQgb3V0IHdo
YXQgdGhpcyBtaWdodCBtZWFuIGFuZCBkaXNjb3ZlcmVkICJpcCBuZXRuZnMiIGFuZAppdHMgbWFu
IHBhZ2Ugd2hpY2ggc2F5czoKCiAgIEZvciBhcHBsaWNhdGlvbnMgdGhhdCBhcmUgYXdhcmUgb2Yg
bmV0d29yayBuYW1lc3BhY2VzLCB0aGUgY29udmVudGlvbgogICBpcyB0byBsb29rIGZvciBnbG9i
YWwgbmV0d29yayBjb25maWd1cmF0aW9uIGZpbGVzIGZpcnN0IGluCiAgIC9ldGMvbmV0bnMvTkFN
RS8gdGhlbiBpbiAvZXRjLy4gIEZvciBleGFtcGxlLCBpZiB5b3Ugd2FudCBhIGRpZmZlcmVudAog
ICB2ZXJzaW9uIG9mIC9ldGMvcmVzb2x2LmNvbmYgZm9yIGEgbmV0d29yayBuYW1lc3BhY2UgdXNl
ZCB0byBpc29sYXRlCiAgIHlvdXIgdnBuIHlvdSB3b3VsZCBuYW1lIGl0IC9ldGMvbmV0bnMvbXl2
cG4vcmVzb2x2LmNvbmYuCgpPYnZpb3VzbHkgY29udGFpbmVycyBkb24ndCAqaGF2ZSogdG8gZm9s
bG93IHRoaXMgbW9kZWwuICBJIGd1ZXNzIHRoZXJlCmlzIGEgZGlmZmVyZW5jZSBiZXR3ZWVuIGJl
aW5nICJjb250YWluZXIgYXdhcmUiIGFuZCBiZWluZyAibmV0d29yawpuYW1lc3BhY2UgYXdhcmUi
LgoKUHJlc3VtYWJseSBhIGZ1bGwgY29udGFpbmVyIG1hbmFnZXIgKGUuZy4gIGRvY2tlcikgd291
bGQgc2V0IGV2ZXJ5dGhpbmcgdXAKc28gdGhhdCB0b29scyBkb24ndCAqbmVlZCogdG8gYmUgY29u
dGFpbmVyIGF3YXJlLiAgV2hlbiB5b3UgcnVuIGRvY2tlciwKZG8geW91IGdldCBhIHNlcGFyYXRl
IC9ldGMvIGZyb20gdGhlIG9uZSBvdXRzaWRlIG9mIGRvY2tlcj8gIElmIHlvdQpjcmVhdGUgL2V0
Yy9uZnMtY2xpZW50LWlkZW50aWZpZXIgaW5zaWRlIHRoZSBkb2NrZXIgY29udGFpbmVyLCBkb2Vz
IGl0CnJlbWFpbiBwcml2YXRlIHRvIHRoYXQgY29udGFpbmVyPyAgRG9lcyBpdCBwZXJzaXN0IHdp
dGggdGhlIGNvbnRhaW5lcj8KClBvc3NpYmx5IE5GUyB0b29scyBkb24ndCBuZWVkIHRvIGNoZWNr
IGluIC9ldGMvbmV0bmZzL05BTUUgYXMgdGhleSBjb3VsZApzaW1wbHkgYmUgcnVuIHdpdGggImlw
IG5ldG5zIGV4ZWMgTkFNRSB0b29sIGFyZ3MiIHdoaWNoIHdvdWxkIHNldCB1cAovZXRjLiAgVGhp
cyBpcyBmaW5lIGZvciByZWFkaW5nIGNvbmZpZyBmaWxlcywgYnV0IGRvZXNuJ3QgbmVjZXNzYXJp
bHkKd29yayBjb3JyZWN0bHkgZm9yIGNyZWF0aW5nIGNvbmZpZyBmaWxlcy4KClBvc3NpYmx5IHRo
ZSBnb2FsIG9mIGhhdmluZyBhbiBORlMgdG9vbCB3aGljaCBhdXRvbWF0aWNhbGx5IGNyZWF0ZXMg
YW5kCnBlcnNpc3RzIGEgY2xpZW50IGlkZW50aWZpZXIgZm9yIHRoZSBjdXJyZW50IGNvbnRhaW5l
ciBpcyBub3QgcHJhY3RpY2FsLiAKTWF5YmUgd2UganVzdCBkb2N1bWVudCB3aGF0IGFueSBjb250
YWluZXItY3JlYXRpb24gcGxhdGZvcm0gbXVzdCBkbyBmb3IKTkZTLCBhbmQgbGV0IHRoZW0gYWxs
IGltcGxlbWVudCB0aGF0IGhvd2V2ZXIgc2VlbXMgYmVzdC4gIFdpdGggdGhlIG5ldwpyYW5kb20t
aWRlbnRpdHktYXQtbmFtZXNwYWNlLWNyZWF0aW9uIHBhdGNoIHRoZSBjb3N0IG9mIG5vdCBkb2lu
Zwphbnl0aGluZyBpcyBsb2NhbGlzZWQgdG8gdGhlIGNvbnRhaW5lcgoKTWF5YmUgd2Ugc2hvdWxk
IGp1c3QgcHJvdmlkZSBhIHRvb2wKICAgbmZzLXNldC1jbGllbnQtaWRlbnRpdHkgTkFNRQpUaGUg
Y29udGFpbmVyIHNldHVwIGNvZGUgcHJvdmlkZXMgc29tZSAiTkFNRSIgZm9yIHRoZSBjb250YWlu
ZXIgd2hpY2ggaXQKaXMgcmVzcG9uc2libGUgZm9yIGtlZXBpbmcgcGVyc2lzdGVudCwgYW5kIHdl
IGp1c3Qgd3JpdGUgaXQgdG8KL3N5cy9mcy9uZnMvbmV0L25mc19jbGllbnQvaWRlbmZpZXIsIHBv
c3NpYmx5IGFmdGVyIGhhc2hpbmcgb3Igd2hhdGV2ZXIuCgpOZWlsQnJvd24K
