Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132BA3DF89F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 01:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhHCXrd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 19:47:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhHCXrc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 19:47:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2AB34220DA;
        Tue,  3 Aug 2021 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628034440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwJ7Oiyak7bVkLL9diT5VyvP/qSMlmC/Vxy/DDOKGWo=;
        b=AGJ31JoHh0St5WYIImolTYSjbhYrU6CSePxhc9QaTYj+jtJ9DyTTY0zhrRPHT6E/8YDim+
        IGnJx54HstQuBk4Xe4+gObpC+fFFVAOz9IN2FVgHpwncQrNZTS7/XEhI25o6tqYdlZQFz7
        D3FjY3WdRZyXIGhkxO4YUprTojJ3XZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628034440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwJ7Oiyak7bVkLL9diT5VyvP/qSMlmC/Vxy/DDOKGWo=;
        b=329MHlxiVzs4AIdUrvye5Bh9iVuyidlu7KE7ju4G2tnIPyT6/i9QVtrIo8NQnGSh0wVzot
        ByWCN+dFXkkz36Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DE4113AEA;
        Tue,  3 Aug 2021 23:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f3eoDobVCWFuEAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 03 Aug 2021 23:47:18 +0000
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
In-reply-to: <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>,
 <20210803203051.GA3043@fieldses.org>,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>,
 <20210803213642.GA4042@fieldses.org>,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
Date:   Wed, 04 Aug 2021 09:47:14 +1000
Message-id: <162803443497.32159.4120609262211305187@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAwNCBBdWcgMjAyMSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFR1ZSwgMjAy
MS0wOC0wMyBhdCAxNzozNiAtMDQwMCwgYmZpZWxkc0BmaWVsZHNlcy5vcmcgd3JvdGU6Cj4gPiBP
biBUdWUsIEF1ZyAwMywgMjAyMSBhdCAwOTowNzoxMVBNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qg
d3JvdGU6Cj4gPiA+IE9uIFR1ZSwgMjAyMS0wOC0wMyBhdCAxNjozMCAtMDQwMCwgSi4gQnJ1Y2Ug
RmllbGRzIHdyb3RlOgo+ID4gPiA+IE9uIEZyaSwgSnVsIDMwLCAyMDIxIGF0IDAyOjQ4OjQxUE0g
KzAwMDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToKPiA+ID4gPiA+IE9uIEZyaSwgMjAyMS0wNy0z
MCBhdCAwOToyNSAtMDQwMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToKPiA+ID4gPiA+ID4g
SSBoYXZlIHNvbWUgZm9sa3MgdW5oYXBweSBhYm91dCBiZWhhdmlvciBjaGFuZ2VzIGFmdGVyOgo+
ID4gPiA+ID4gPiA0NzkyMTkyMThmYmUKPiA+ID4gPiA+ID4gTkZTOgo+ID4gPiA+ID4gPiBPcHRp
bWlzZSBhd2F5IHRoZSBjbG9zZS10by1vcGVuIEdFVEFUVFIgd2hlbiB3ZSBoYXZlIE5GU3Y0Cj4g
PiA+ID4gPiA+IE9QRU4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEJlZm9yZSB0aGlzIGNoYW5n
ZSwgYSBjbGllbnQgaG9sZGluZyBhIFJPIG9wZW4gd291bGQKPiA+ID4gPiA+ID4gaW52YWxpZGF0
ZQo+ID4gPiA+ID4gPiB0aGUKPiA+ID4gPiA+ID4gcGFnZWNhY2hlIHdoZW4gZG9pbmcgYSBzZWNv
bmQgUlcgb3Blbi4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IE5vdyB0aGUgY2xpZW50IGRvZXNu
J3QgaW52YWxpZGF0ZSB0aGUgcGFnZWNhY2hlLCB0aG91Z2gKPiA+ID4gPiA+ID4gdGVjaG5pY2Fs
bHkKPiA+ID4gPiA+ID4gaXQgY291bGQKPiA+ID4gPiA+ID4gYmVjYXVzZSB3ZSBzZWUgYSBjaGFu
Z2VhdHRyIHVwZGF0ZSBvbiB0aGUgUlcgT1BFTiByZXNwb25zZS4KPiA+ID4gPiA+ID4gCj4gPiA+
ID4gPiA+IEkgZmVlbCB0aGlzIGlzIGEgZ3JleSBhcmVhIGluIENUTyBpZiB3ZSdyZSBhbHJlYWR5
IGhvbGRpbmcgYW4KPiA+ID4gPiA+ID4gb3Blbi7CoAo+ID4gPiA+ID4gPiBEbyB3ZQo+ID4gPiA+
ID4gPiBrbm93IGhvdyB0aGUgY2xpZW50IG91Z2h0IHRvIGJlaGF2ZSBpbiB0aGlzIGNhc2U/wqAg
U2hvdWxkIHRoZQo+ID4gPiA+ID4gPiBjbGllbnQncyBvcGVuCj4gPiA+ID4gPiA+IHVwZ3JhZGUg
dG8gUlcgaW52YWxpZGF0ZSB0aGUgcGFnZWNhY2hlPwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+IAo+
ID4gPiA+ID4gSXQncyBub3QgYSAiZ3JleSBhcmVhIGluIGNsb3NlLXRvLW9wZW4iIGF0IGFsbC4g
SXQgaXMgdmVyeSBjdXQKPiA+ID4gPiA+IGFuZAo+ID4gPiA+ID4gZHJpZWQuCj4gPiA+ID4gPiAK
PiA+ID4gPiA+IElmIHlvdSBuZWVkIHRvIGludmFsaWRhdGUgeW91ciBwYWdlIGNhY2hlIHdoaWxl
IHRoZSBmaWxlIGlzCj4gPiA+ID4gPiBvcGVuLAo+ID4gPiA+ID4gdGhlbgo+ID4gPiA+ID4gYnkg
ZGVmaW5pdGlvbiB5b3UgYXJlIGluIGEgc2l0dWF0aW9uIHdoZXJlIHRoZXJlIGlzIGEgd3JpdGUg
YnkKPiA+ID4gPiA+IGFub3RoZXIKPiA+ID4gPiA+IGNsaWVudCBnb2luZyBvbiB3aGlsZSB5b3Ug
YXJlIHJlYWRpbmcuIFlvdSdyZSBjbGVhcmx5IG5vdCBkb2luZwo+ID4gPiA+ID4gY2xvc2UtCj4g
PiA+ID4gPiB0by1vcGVuLgo+ID4gPiA+IAo+ID4gPiA+IERvY3VtZW50YXRpb24gaXMgcmVhbGx5
IHVuY2xlYXIgYWJvdXQgdGhpcyBjYXNlLsKgIEV2ZXJ5Cj4gPiA+ID4gZGVmaW5pdGlvbiBvZgo+
ID4gPiA+IGNsb3NlLXRvLW9wZW4gdGhhdCBJJ3ZlIHNlZW4gc2F5cyB0aGF0IGl0IHJlcXVpcmVz
IGEgY2FjaGUKPiA+ID4gPiBjb25zaXN0ZW5jeQo+ID4gPiA+IGNoZWNrIG9uIGV2ZXJ5IGFwcGxp
Y2F0aW9uIG9wZW4uwqAgSSd2ZSBuZXZlciBzZWVuIG9uZSB0aGF0IHNheXMKPiA+ID4gPiAib24K
PiA+ID4gPiBldmVyeSBvcGVuIHRoYXQgZG9lc24ndCBvdmVybGFwIHdpdGggYW4gYWxyZWFkeS1l
eGlzdGluZyBvcGVuIG9uCj4gPiA+ID4gdGhhdAo+ID4gPiA+IGNsaWVudCIuCj4gPiA+ID4gCj4g
PiA+ID4gVGhleSAqdXN1YWxseSogYWxzbyBwcmVmYWNlIHRoYXQgYnkgc2F5aW5nIHRoYXQgdGhp
cyBpcyBtb3RpdmF0ZWQKPiA+ID4gPiBieQo+ID4gPiA+IHRoZQo+ID4gPiA+IHVzZSBjYXNlIHdo
ZXJlIG9wZW5zIGRvbid0IG92ZXJsYXAuwqAgQnV0IGl0J3MgbmV2ZXIgbWFkZSBjbGVhcgo+ID4g
PiA+IHRoYXQKPiA+ID4gPiB0aGF0J3MgcGFydCBvZiB0aGUgZGVmaW5pdGlvbi4KPiA+ID4gPiAK
PiA+ID4gCj4gPiA+IEknbSBub3QgZm9sbG93aW5nIHlvdXIgbG9naWMuCj4gPiAKPiA+IEl0J3Mg
anVzdCBhIHF1ZXN0aW9uIG9mIHdoYXQgZXZlcnkgc291cmNlIEkgY2FuIGZpbmQgc2F5cyBjbG9z
ZS10by0KPiA+IG9wZW4KPiA+IG1lYW5zLsKgIEUuZy4sIE5GUyBJbGx1c3RyYXRlZCwgcC4gMjQ4
LCAiQ2xvc2UtdG8tb3BlbiBjb25zaXN0ZW5jeQo+ID4gcHJvdmlkZXMgYSBndWFyYW50ZWUgb2Yg
Y2FjaGUgY29uc2lzdGVuY3kgYXQgdGhlIGxldmVsIG9mIGZpbGUgb3BlbnMKPiA+IGFuZAo+ID4g
Y2xvc2VzLsKgIFdoZW4gYSBmaWxlIGlzIGNsb3NlZCBieSBhbiBhcHBsaWNhdGlvbiwgdGhlIGNs
aWVudCBmbHVzaGVzCj4gPiBhbnkKPiA+IGNhY2hlZCBjaGFuZ3MgdG8gdGhlIHNlcnZlci7CoCBX
aGVuIGEgZmlsZSBpcyBvcGVuZWQsIHRoZSBjbGllbnQKPiA+IGlnbm9yZXMKPiA+IGFueSBjYWNo
ZSB0aW1lIHJlbWFpbmluZyAoaWYgdGhlIGZpbGUgZGF0YSBhcmUgY2FjaGVkKSBhbmQgbWFrZXMg
YW4KPiA+IGV4cGxpY2l0IEdFVEFUVFIgY2FsbCB0byB0aGUgc2VydmVyIHRvIGNoZWNrIHRoZSBm
aWxlIG1vZGlmaWNhdGlvbgo+ID4gdGltZS4iCj4gPiAKPiA+ID4gVGhlIGNsb3NlLXRvLW9wZW4g
bW9kZWwgYXNzdW1lcyB0aGF0IHRoZSBmaWxlIGlzIG9ubHkgYmVpbmcKPiA+ID4gbW9kaWZpZWQg
YnkKPiA+ID4gb25lIGNsaWVudCBhdCBhIHRpbWUgYW5kIGl0IGFzc3VtZXMgdGhhdCBmaWxlIGNv
bnRlbnRzIG1heSBiZQo+ID4gPiBjYWNoZWQKPiA+ID4gd2hpbGUgYW4gYXBwbGljYXRpb24gaXMg
aG9sZGluZyBpdCBvcGVuLgo+ID4gPiBUaGUgcG9pbnQgY2hlY2tzIGV4aXN0IGluIG9yZGVyIHRv
IGRldGVjdCBpZiB0aGUgZmlsZSBpcyBiZWluZwo+ID4gPiBjaGFuZ2VkCj4gPiA+IHdoZW4gdGhl
IGZpbGUgaXMgbm90IG9wZW4uCj4gPiA+IAo+ID4gPiBMaW51eCBkb2VzIG5vdCBoYXZlIGEgcGVy
LWFwcGxpY2F0aW9uIGNhY2hlLiBJdCBoYXMgYSBwYWdlIGNhY2hlCj4gPiA+IHRoYXQKPiA+ID4g
aXMgc2hhcmVkIGFtb25nIGFsbCBhcHBsaWNhdGlvbnMuIEl0IGlzIGltcG9zc2libGUgZm9yIHR3
bwo+ID4gPiBhcHBsaWNhdGlvbnMKPiA+ID4gdG8gb3BlbiB0aGUgc2FtZSBmaWxlIHVzaW5nIGJ1
ZmZlcmVkIEkvTywgYW5kIHlldCBzZWUgZGlmZmVyZW50Cj4gPiA+IGNvbnRlbnRzLgo+ID4gCj4g
PiBSaWdodCwgc28gYmFzZWQgb24gdGhlIGRlc2NyaXB0aW9ucyBsaWtlIHRoZSBvbmUgYWJvdmUs
IEkgd291bGQgaGF2ZQo+ID4gZXhwZWN0ZWQgYm90aCBhcHBsaWNhdGlvbnMgdG8gc2VlIG5ldyBk
YXRhIGF0IHRoYXQgcG9pbnQuCj4gCj4gV2h5PyBUaGF0IHdvdWxkIGJlIGEgY2xlYXIgdmlvbGF0
aW9uIG9mIHRoZSBjbG9zZS10by1vcGVuIHJ1bGUgdGhhdAo+IG5vYm9keSBlbHNlIGNhbiB3cml0
ZSB0byB0aGUgZmlsZSB3aGlsZSBpdCBpcyBvcGVuLgo+IAoKSXMgdGhlIHJ1bGUKQSAtICAiaXQg
aXMgbm90IHBlcm1pdHRlZCBmb3IgYW55IG90aGVyIGFwcGxpY2F0aW9uL2NsaWVudCB0byB3cml0
ZSB0bwogICAgICB0aGUgZmlsZSB3aGlsZSBhbm90aGVyIGhhcyBpdCBvcGVuIgogb3IKQiAtICAi
aXQgaXMgbm90IGV4cGVjdGVkIGZvciBhbnkgb3RoZXIgYXBwbGljYXRpb24vY2xpZW50IHRvIHdy
aXRlIHRvCiAgICAgIHRoZSBmaWxlIHdoaWxlIGFub3RoZXIgaGFzIGl0IG9wZW4iCgpJIHRoaW5r
IEIsIGJlY2F1c2UgQSBpcyBjbGVhcmx5IG5vdCBlbmZvcmNlZC4gIFRoYXQgc3VnZ2VzdHMgdGhh
dCB0aGVyZQppcyBubyAqbmVlZCogdG8gY2hlY2sgZm9yIGNoYW5nZXMsIGJ1dCBlcXVhbGx5IHRo
ZXJlIGlzIG5vIGJhcnJpZXIgdG8KY2hlY2tpbmcgZm9yIGNoYW5nZXMuICBTbyB0aGF0IGZhY3Qg
dGhhdCBvbmUgYXBwbGljYXRpb24gaGFzIHRoZSBmaWxlCm9wZW4gc2hvdWxkIG5vdCBwcmV2ZW50
IGEgY2hlY2sgd2hlbiBhbm90aGVyIGFwcGxpY2F0aW9uIG9wZW5zIHRoZSBmaWxlLgpFcXVhbGx5
IGl0IHNob3VsZCBub3QgcHJldmVudCBhIGZsdXNoIHdoZW4gc29tZSBvdGhlciBhcHBsaWNhdGlv
biBjbG9zZXMKdGhlIGZpbGUuCgpJdCBpcyBzb21ld2hhdCB3ZWlyZCB0aGF0IGlmIGFuIGFwcGxp
Y2F0aW9uIG9uIG9uZSBjbGllbnQgbWlzYmVoYXZlcyBieQprZWVwaW5nIGEgZmlsZSBvcGVuLCB0
aGF0IHdpbGwgcHJldmVudCBvdGhlciBhcHBsaWNhdGlvbnMgb24gdGhlIHNhbWUKY2xpZW50IGZy
b20gc2VlaW5nIG5vbi1sb2NhbCBjaGFuZ2VzLCBidXQgd2lsbCBub3QgcHJldmVudCBhcHBsaWNh
dGlvbnMKb24gb3RoZXIgY2xpZW50cyBmcm9tIHNlZWluZyBhbnkgY2hhbmdlcy4KCk5laWxCcm93
bgo=
