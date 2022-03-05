Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F34CE1D5
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Mar 2022 02:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiCEBQV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Mar 2022 20:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiCEBQR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Mar 2022 20:16:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4456022759F
        for <linux-nfs@vger.kernel.org>; Fri,  4 Mar 2022 17:15:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB7101F385;
        Sat,  5 Mar 2022 01:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646442926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msp/FzJGgYMlRvaupHVPiO3unZFs7Y6rp5qq6Bjqc2w=;
        b=Eepk0LkWBFh/ioTZEe3d5TtrH5jtQfAusTm5feEfrdHXuHgUF6FM1KfCnTGszyAoE7yA+d
        MBL1pJnwvui3X7uwpjDpRyRk2dYL+rzxJj46kR6MRk9uA137eu2J+QRSyVICKhyy1lTsns
        eqq50ODSEbaOS4NZlyzXlJF/D2Ie9oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646442926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msp/FzJGgYMlRvaupHVPiO3unZFs7Y6rp5qq6Bjqc2w=;
        b=WS+kXXmzVQM7/SQAZFqYZMjK1IKlR7d/ye3/SRAtMqqQ45ePsXRWh4DY7dEXiDVe933bgn
        gTwk75dAqEHA2gAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 844CB13AF2;
        Sat,  5 Mar 2022 01:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZhjUEKy5ImI/BwAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 05 Mar 2022 01:15:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a container
In-reply-to: <3d4467af-e6f7-694b-e711-6fafb6490fc8@redhat.com>
References: <cover.1644515977.git.bcodding@redhat.com>,
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>,
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>,
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>,
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>,
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>,
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>,
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>,
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>,
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>,
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>,
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>,
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>,
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>,
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>,
 <164627798608.17899.14049799069550646947@noble.neil.brown.name>,
 <fe1527f96f5b8f6280b24985603bbf99cde58864.camel@hammerspace.com>,
 <164635642445.13165.9587906660448735526@noble.neil.brown.name>,
 <3d4467af-e6f7-694b-e711-6fafb6490fc8@redhat.com>
Date:   Sat, 05 Mar 2022 12:15:19 +1100
Message-id: <164644291986.29369.9221388603458952735@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAwNSBNYXIgMjAyMiwgU3RldmUgRGlja3NvbiB3cm90ZToKPiBIZXkhCj4gCj4gT24g
My8zLzIyIDg6MTMgUE0sIE5laWxCcm93biB3cm90ZToKPiA+IE9uIEZyaSwgMDQgTWFyIDIwMjIs
IFRyb25kIE15a2xlYnVzdCB3cm90ZToKPiA+PiBPbiBUaHUsIDIwMjItMDMtMDMgYXQgMTQ6MjYg
KzExMDAsIE5laWxCcm93biB3cm90ZToKPiA+Pj4gT24gV2VkLCAwMiBNYXIgMjAyMiwgQ2h1Y2sg
TGV2ZXIgSUlJIHdyb3RlOgo+ID4+Pgo+ID4+Pgo+ID4+Pj4KPiA+Pj4+Cj4gPj4+PiBUaGUgcmVt
YWluaW5nIHBhcnQgb2YgdGhpcyB0ZXh0IHByb2JhYmx5IHNob3VsZCBiZQo+ID4+Pj4gcGFydCBv
ZiB0aGUgbWFuIHBhZ2UgZm9yIEJlbidzIHRvb2wsIG9yIHdoYXRldmVyIGlzCj4gPj4+PiBjb21p
bmcgbmV4dC4KPiA+Pj4KPiA+Pj4gTXkgcG9zaXRpb24gaXMgdGhhdCB0aGVyZSBpcyBubyBuZWVk
IGZvciBhbnkgdG9vbC7CoCBUaGUgdG90YWwgYW1vdW50Cj4gPj4+IG9mCj4gPj4+IGNvZGUgbmVl
ZGVkIGlzIGEgY291cGxlIG9mIGxpbmVzIGFzIHByZXNlbnRlZCBpbiB0aGUgdGV4dCBiZWxvdy7C
oCBXaHkKPiA+Pj4gcHJvdmlkZSBhIHdyYXBwZXIganVzdCBmb3IgdGhhdD8KPiA+Pj4gV2UgKmNh
bm5vdCogYXV0b21hdGljYWxseSBkZWNpZGUgaG93IHRvIGZpbmQgYSBuYW1lIG9yIHdoZXJlIHRv
IHN0b3JlCj4gPj4+IGEKPiA+Pj4gZ2VuZXJhdGVkIHV1aWQsIHNvIHRoZXJlIGlzIG5vIGFkZGVk
IHZhbHVlIHRoYXQgYSB0b29sIGNvdWxkIHByb3ZpZGUuCj4gPj4+Cj4gPj4+IFdlIGNhbm5vdCB1
bmlsYXRlcmFsbHkgZml4IGNvbnRhaW5lciBzeXN0ZW1zLsKgIFdlIGNhbiBvbmx5IHRlbGwKPiA+
Pj4gcGVvcGxlCj4gPj4+IHdobyBidWlsZCB0aGVzZSBzeXN0ZW1zIG9mIHRoZSByZXF1aXJlbWVu
dHMgZm9yIE5GUy4KPiA+Pj4KPiA+Pgo+ID4+IEkgZGlzYWdyZWUgd2l0aCB0aGlzIHBvc2l0aW9u
LiBUaGUgdmFsdWUgb2YgaGF2aW5nIGEgc3RhbmRhcmQgdG9vbCBpcwo+ID4+IHRoYXQgaXQgYWxz
byBjcmVhdGVzIGEgc3RhbmRhcmQgZm9yIGhvdyBhbmQgd2hlcmUgdGhlIHVuaXF1aWZpZXIgaXMK
PiA+PiBnZW5lcmF0ZWQgYW5kIHBlcnNpc3RlZC4KPiA+Pgo+ID4+IE90aGVyd2lzZSB5b3UgaGF2
ZSB0byBkZWFsIHdpdGggdGhlIGZhY3QgdGhhdCB5b3UgbWF5IGhhdmUgYSBzeXN0ZW1kCj4gPj4g
c2NyaXB0IHRoYXQgcGVyc2lzdHMgc29tZXRoaW5nIGluIG9uZSBmaWxlLCBhIERvY2tlcmZpbGUg
cmVjaXBlIHRoYXQKPiA+PiBnZW5lcmF0ZXMgc29tZXRoaW5nIGF0IGNvbnRhaW5lciBidWlsZCB0
aW1lLCBhbmQgdGhlbiBhIGhvbWUtbWFkZQo+ID4+IHNjcmlwdCB0aGF0IGxvb2tzIGZvciBzb21l
dGhpbmcgaW4gYSBkaWZmZXJlbnQgbG9jYXRpb24uIElmIHlvdSdyZQo+ID4+IHRyeWluZyB0byBk
ZWJ1ZyB3aHkgeW91ciBjb250YWluZXJzIGFyZSBhbGwgZ2VuZXJhdGluZyB0aGUgc2FtZQo+ID4+
IHVuaXF1aWZpZXIsIHRoZW4gdGhhdCBjYW4gYmUgYSBwcm9ibGVtLgo+ID4gCj4gPiBJIGRvbid0
IHNlZSBob3cgYSB0b29sIGNhbiBwcm92aWRlIGFueSBjb25zaXN0ZW5jeS4KPiA+IElzIHRoZXJl
IHNvbWUgc3RhbmRhcmQgdGhhdCBzYXkgaG93IGNvbnRhaW5lcnMgc2hvdWxkIGJlIGJ1aWx0LCBh
bmQKPiA+IHdoZXJlIHRvb2xzIGNhbiBzdG9yZSBwZXJzaXN0ZW50IGRhdGE/ICBJZiBub3QsIHRo
ZSB0b29sIG5lZWRzIHRvIGJlCj4gPiBjb25maWd1cmVkLCBhbmQgdGhhdCBpcyBub3QgaW1wb3J0
YW50bHkgZGlmZmVyZW50IGZyb20gYmFzaCBiZWluZwo+ID4gY29uZmlndXJlZCB3aXRoIGEgMS1s
aW5lIHNjcmlwdCB0byB3cml0ZSBvdXQgdGhlIGlkZW50aWZpZXIuCj4gPiAKPiA+IEknbSBub3Qg
c3Ryb25nbHkgYWdhaW5zdCBhIHRvb2xzLCBJIGp1c3QgY2FuJ3Qgc2VlIHRoZSBiZW5lZml0Lgo+
IEkgdGhpbmsgSSBhZ3JlZSB3aXRoIHRoaXMuLi4gVGhpbmtpbmcgYWJvdXQgaXQuLi4gaGF2aW5n
IGEgY29tbWFuZCB0aGF0Cj4gdHJpZXMgdG8gbWFuaXB1bGF0ZSBkaWZmZXJlbnQgY29udGFpbmVy
cyBpbiBkaWZmZXJlbnQgd2F5cyBqdXN0Cj4gc2VlbXMgbGlrZSBhIHJlY2lwZSBmb3IgZGlzYXN0
ZXIuLi4gSSBqdXN0IGRvbid0IHNlZSBob3cgYSBjb21tYW5kIHdvdWxkCj4gZXZlciBnZXQgaXQg
cmlnaHQuLi4gSGVsbCB3ZSBjYW4ndCBhZ3JlZSBvbiBpdHMgY29tbWFuZCdzIG5hbWUKPiBtdWNo
IGxlc3Mgd2hhdCBpdCB3aWxsIGRvLiA6LSkKPiAKPiBTbyBJIGxpa2UgaWRlYSBvZiBkb2N1bWVu
dGluZyB3aGVuIG5lZWRzIHRvIGhhcHBlbiBpbiB0aGUKPiBkaWZmZXJlbnQgdHlwZXMgb2YgY29u
dGFpbmVycy4uLiBTbyBJIHRoaW5rIHRoZSBtYW4gcGFnZQo+IGlzIHRoZSB3YXkgdG8gZ28uLi4g
YW5kIEkgdGhpbmsgaXQgaXMgdGhlIHNhZmVzdCB3YXkgdG8gZ28uCj4gCj4gQ2h1Y2ssIGlmIHlv
dSB3b3VsZCBsaWtlIHR3ZWFrIHRoZSB2ZXJiaWFnZS4uLiBieSBhbGwgbWVhbnMuCj4gCj4gTmVp
bCwgd2lsbCBiZSBhIFYyIGZvciBtYW4gcGFnZSBwYXRjaCBmcm9tIHRoaXMgZGlzY3Vzc2lvbgo+
IG9yIHNob3VsZCBJIGp1c3QgdGFrZSB0aGUgb25lIHlvdSBwb3N0ZWQ/IElmIHlvdSBkbyBwb3N0
Cj4gYSBWMiwgcGxlYXNlIHN0YXJ0IGEgbmV3IHRocmVhZC4KCkknbGwgcG9zdCBhIFYyLiAgQ2h1
Y2sgbWFkZSBzb21lIGV4Y2VsbGVudCBzdHJ1Y3R1cmFsIHN1Z2dlc3Rpb25zLgoKVGhhbmtzLApO
ZWlsQnJvd24K
