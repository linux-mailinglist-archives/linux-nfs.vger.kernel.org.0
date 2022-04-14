Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628E8500543
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Apr 2022 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiDNEzS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Apr 2022 00:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEzS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Apr 2022 00:55:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0913FB4
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 21:52:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C8471F856;
        Thu, 14 Apr 2022 04:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649911973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDihRIf8tgj1i7iHcjgQIUXcgGeQTRWLHOC0Jf9Y+rU=;
        b=oibUmiWtqWol2lEBMIv6514oPqNM0YWMrKPfKzAnhZqPJRlnREE4b7bo9pU3+KBcHgVEP+
        f/5JCSwCXOriq3mbSwKNBGNufBOLWDy1xFCdvpHTC3J8eT+uU2iWvsQ1KhBXsP7wf7CWEs
        9fSzihBx/UVl0Cmto6By+fEGlHGi/9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649911973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDihRIf8tgj1i7iHcjgQIUXcgGeQTRWLHOC0Jf9Y+rU=;
        b=oXT1NMLODtG1nD7ZOhQFNDkHXSVT6f7aPnW+sqDM5Uip5WhoYlw3jh7wZvUlgJnv/BrQos
        tAzdH44dJMGoMhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5E1613A4A;
        Thu, 14 Apr 2022 04:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id If8LKKOoV2JCJgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Apr 2022 04:52:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Add an explanation of NFSv4 client identifiers
In-reply-to: <64807ea6a8d169e426cff4fa75a6de9b16d3ae35.camel@hammerspace.com>
References: <164970912423.2037.12497015321508491456.stgit@bazille.1015granger.net>,
 <164974719723.11576.583440068909686735@noble.neil.brown.name>,
 <4918188E-9271-47F2-8F5A-D6D5BEB85F36@oracle.com>,
 <164990959799.11576.7740616159032491033@noble.neil.brown.name>,
 <64807ea6a8d169e426cff4fa75a6de9b16d3ae35.camel@hammerspace.com>
Date:   Thu, 14 Apr 2022 14:52:48 +1000
Message-id: <164991196867.11576.15674607042113472005@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAxNCBBcHIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFRodSwgMjAy
Mi0wNC0xNCBhdCAxNDoxMyArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gV2VkLCAxMyBB
cHIgMjAyMiwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOgo+ID4gPiAKPiA+ID4gPiBPbiBBcHIgMTIs
IDIwMjIsIGF0IDM6MDYgQU0sIE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4gd3JvdGU6Cj4gPiA+
ID4gCj4gPiA+ID4gT24gVHVlLCAxMiBBcHIgMjAyMiwgQ2h1Y2sgTGV2ZXIgd3JvdGU6Cj4gPiA+
ID4gPiArCj4gPiA+ID4gPiArSWYgYSBjbGllbnQncyAiY29fb3duZXJpZCIgc3RyaW5nIG9yIHBy
aW5jaXBhbCBhcmUgbm90IHN0YWJsZSwKPiA+ID4gPiA+ICtzdGF0ZSByZWNvdmVyeSBhZnRlciBh
IHNlcnZlciBvciBjbGllbnQgcmVib290IGlzIG5vdAo+ID4gPiA+ID4gZ3VhcmFudGVlZC4KPiA+
ID4gPiA+ICtJZiBhIGNsaWVudCB1bmV4cGVjdGVkbHkgcmVzdGFydHMgYnV0IHByZXNlbnRzIGEg
ZGlmZmVyZW50Cj4gPiA+ID4gPiArImNvX293bmVyaWQiIHN0cmluZyBvciBwcmluY2lwYWwgdG8g
dGhlIHNlcnZlciwgdGhlIHNlcnZlcgo+ID4gPiA+ID4gb3JwaGFucwo+ID4gPiA+ID4gK3RoZSBj
bGllbnQncyBwcmV2aW91cyBvcGVuIGFuZCBsb2NrIHN0YXRlLiBUaGlzIGJsb2NrcyBhY2Nlc3MK
PiA+ID4gPiA+IHRvCj4gPiA+ID4gPiArbG9ja2VkIGZpbGVzIHVudGlsIHRoZSBzZXJ2ZXIgcmVt
b3ZlcyB0aGUgb3JwaGFuZWQgc3RhdGUuCj4gPiA+ID4gPiArCj4gPiA+ID4gPiArSWYgdGhlIHNl
cnZlciByZXN0YXJ0cyBhbmQgYSBjbGllbnQgcHJlc2VudHMgYSBjaGFuZ2VkCj4gPiA+ID4gPiAi
Y29fb3duZXJpZCIKPiA+ID4gPiA+ICtzdHJpbmcgb3IgcHJpbmNpcGFsIHRvIHRoZSBzZXJ2ZXIs
IHRoZSBzZXJ2ZXIgd2lsbCBub3QgYWxsb3cKPiA+ID4gPiA+IHRoZQo+ID4gPiA+ID4gK2NsaWVu
dCB0byByZWNsYWltIGl0cyBvcGVuIGFuZCBsb2NrIHN0YXRlLCBhbmQgbWF5IGdpdmUgdGhvc2UK
PiA+ID4gPiA+IGxvY2tzCj4gPiA+ID4gPiArdG8gb3RoZXIgY2xpZW50cyBpbiB0aGUgbWVhbiB0
aW1lLiBUaGlzIGlzIHJlZmVycmVkIHRvIGFzCj4gPiA+ID4gPiAibG9jawo+ID4gPiA+ID4gK3N0
ZWFsaW5nIi4KPiA+ID4gPiAKPiA+ID4gPiBUaGlzIGlzIG5vdCBhIHBvc3NpYmxlIHNjZW5hcmlv
IHdpdGggTGludXggTkZTIGNsaWVudC7CoCBUaGUKPiA+ID4gPiBjbGllbnQKPiA+ID4gPiBhc3Nl
bWJsZXMgdGhlIHN0cmluZyBvbmNlIGZyb20gdmFyaW91cyBzb3VyY2VzLCB0aGVuIHVzZXMgaXQK
PiA+ID4gPiBjb25zaXN0ZW50bHkgYXQgbGVhc3QgdW50aWwgdW5tb3VudCBvciByZWJvb3QuwqAg
SXMgaXQgd29ydGgKPiA+ID4gPiBtZW50aW9uaW5nPwo+ID4gPiAKPiA+ID4gTmVpbCwgdGhhbmtz
IGZvciB0aGUgZXllcy1vbi4gSSd2ZSBpbnRlZ3JhdGVkIHRoZSBvdGhlciBzdWdnZXN0aW9ucwo+
ID4gPiBpbiB5b3VyIHJlcGx5LiBIb3dldmVyIHRoZXJlIGFyZSBzb21lIGNvcm5lciBjYXNlcyBo
ZXJlIHRoYXQgSSdkCj4gPiA+IGxpa2UgdG8gY29uc2lkZXIgYmVmb3JlIHByb2NlZWRpbmcuCj4g
PiA+IAo+ID4gPiBHZW5lcmFsbHksIHByZXNlcnZpbmcgdGhlIGNsX293bmVyX2lkIHN0cmluZyBp
cyBnb29kIGRlZmVuc2UKPiA+ID4gYWdhaW5zdAo+ID4gPiBsb2NrIHN0ZWFsaW5nLiBMb29rcyBs
aWtlIHRoZSBMaW51eCBORlMgY2xpZW50IGRpZG4ndCBkbyB0aGF0Cj4gPiA+IGJlZm9yZQo+ID4g
PiBjZWIzYTE2YzA3MGMgKCJORlN2NDogQ2FjaGUgdGhlIE5GU3Y0L3Y0LjEgY2xpZW50IG93bmVy
X2lkIGluIHRoZQo+ID4gPiBzdHJ1Y3QgbmZzX2NsaWVudCIpLgo+ID4gPiAKPiA+ID4gSWYgYSBz
ZXJ2ZXIgZmlsZXN5c3RlbSBpcyBtaWdyYXRlZCB0byBhIHNlcnZlciB0aGF0IHRoZSBjbGllbnQK
PiA+ID4gaGFzbid0Cj4gPiA+IGNvbnRhY3RlZCBiZWZvcmUsIGFuZCB0aGUgY2xpZW50J3MgdW5p
cXVpZmllciBvciBob3N0bmFtZSBoYXMKPiA+ID4gY2hhbmdlZAo+ID4gPiBzaW5jZSB0aGUgY2xp
ZW50IGVzdGFibGlzaGVkIGl0cyBsZWFzZSB3aXRoIHRoZSBmaXJzdCBzZXJ2ZXIsIHRoZXJlCj4g
PiA+IGlzIHRoZSBwb3NzaWJpbGl0eSBvZiBsb2NrIHN0ZWFsaW5nIGR1cmluZyB0cmFuc3BhcmVu
dCBzdGF0ZQo+ID4gPiBtaWdyYXRpb24uCj4gPiA+IAo+ID4gPiBJJ20gYWxzbyBub3QgY2VydGFp
biBob3cgdGhlIExpbnV4IE5GUyBjbGllbnQgcHJlc2VydmVzIHRoZQo+ID4gPiBwcmluY2lwYWwK
PiA+ID4gdGhhdCB3YXMgdXNlZCB3aGVuIGEgbGVhc2UgaXMgZmlyc3QgZXN0YWJsaXNoZWQuIEl0
J3MgZ29pbmcgdG8gdXNlCj4gPiA+IEtlcmJlcm9zIGlmIHBvc3NpYmxlLCBidXQgd2hhdCBpZiB0
aGUga2VybmVsJ3MgY3JlZCBjYWNoZSBleHBpcmVzCj4gPiA+IGFuZAo+ID4gPiB0aGUga2V5dGFi
IGhhcyBiZWVuIGFsdGVyZWQgaW4gdGhlIG1lYW50aW1lPyBJIGhhdmVuJ3Qgd2Fsa2VkCj4gPiA+
IHRocm91Z2gKPiA+ID4gdGhhdCBjb2RlIGNhcmVmdWxseSBlbm91Z2ggdG8gdW5kZXJzdGFuZCB3
aGV0aGVyIHRoZXJlIGlzIHN0aWxsIGEKPiA+ID4gdnVsbmVyYWJpbGl0eS4KPiA+ID4gCj4gPiAK
PiA+IEkgZG9uJ3QgdGhpbmsgaWQgc3RhYmlsaXR5IHJlbGF0ZXMgdG8gbG9jayBzdGVhbGluZy4K
PiA+IAo+ID4gLSBnbG9iYWwgdW5pcXVlbmVzcyBndWFyZHMgYWdhaW5zdCBzdGVhbGluZwo+ID4g
LSBzdGFiaWxpdHkgZ3VhcmRzIGFnYWluc3QgbWlzcGxhY2luZyBsb2NrcyBkdXJpbmcgbWlncmF0
aW9uCj4gPiAoInN0b2xlbiIKPiA+IC0gc2VlbXMgYW4gaW5hcHByb3ByaWF0ZSB0ZXJtIGFzIG5v
IGVudGl0eSBhbiBiZSBibGFtZWQgZm9yCj4gPiBzdGVhbGluZykuCj4gPiAKPiA+IENlcnRhaW5s
eSBzdGFiaWxpdHkgb2YgYm90aCB0aGUgaWRlbnRpdHkgYW5kIHRoZSBjcmVkZW50aWFsIGFyZQo+
ID4gaW1wb3J0YW50LsKgIElmIHRoYXQgc3RhYmlsaXR5IGlzIG5vdCBwcm92aWRlZCB0aGVuIHRo
YXQgaXMgYSBrZXJuZWwKPiA+IGJ1Zy4KPiA+IEFzIHlvdSBzYXksIGNlYjNhMTZjMDcwYyBmaXhl
ZCBhIGJ1ZyBpbiB0aGlzIGFyZWEuCj4gPiBJIGRvbid0IHRoaW5rIHRoaXMgZG9jdW1lbnQgaXMg
YW4gYXBwcm9wcmlhdGUgcGxhY2UgdG8gd2FybiBhZ2FpbnN0Cj4gPiBrZXJuZWwgYnVncyAtIHRo
YXQgZG9lc24ndCBmaXQgd2l0aCB0aGUgcHVycG9zZSBnaXZlbiBpbiB0aGUgaW50cm8uCj4gPiAK
PiA+IEkgZG9uJ3Qga25vdyBrbm93IGlmIHRoZSBjcmVkZW50aWFsIGNhbiBjaGFuZ2UgZWl0aGVy
IC0gSSBob3BlIG5vdC4KPiA+IElGIHRoZSBjcmVkZW50aWFsIGNhbiBhY3R1YWxseSBjaGFuZ2Us
IHRoYXQgd291bGQgYmUgYSBrZXJuZWwgYnVnLgo+ID4gSUYgdGhlIHNhbWUgY3JlZGVudGlhbCBj
YW5ub3QgYmUgcmVuZXdlZCwgdGhhdCBpcyBhIHNlcGFyYXRlIHByb2JsZW0sCj4gPiBidXQgc2hv
dWxkIGJlIHRyZWF0ZWQgbGlrZSBhbnkgb3RoZXIgY3JlZGVudGlhbCB0aGF0IGNhbm5vdCBiZQo+
ID4gcmVuZXdlZC4KPiA+IAo+ID4gSSB3b24ndCBhcmd1ZSBzdHJvbmdseSBhZ2FpbnN0IHRoaXMg
dGV4dCAtIEkganVzdCBkb24ndCBzZWUgaG93IGl0IGlzCj4gPiBhcHByb3ByaWF0ZSBhbmQgdGhp
bmsgaXQgY291bGQgYmUgY29uZnVzaW5nLgo+ID4gCj4gCj4gU2VlIFJGQyA1NjYxLCBTZWN0aW9u
IDIuNC4zLgo+IAo+IEl0IGlzIHVwIHRvIHRoZSBzZXJ2ZXIgdG8gZW5mb3JjZSB0aGUgY29ycmVz
cG9uZGVuY2UgYmV0d2VlbiB0aGUgbGVhc2UKPiBhbmQgdGhlIHByaW5jaXBhbCB0aGF0IG93bnMg
dGhhdCBsZWFzZS4KPiAKCkknbSBzb3JyeSBidXQgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSByZWxl
dmFuY2Ugb2YgdGhhdCBzdGF0ZW1lbnQuCgpJIHRoaW5rIHdlIGFyZSB0YWxraW5nIGFib3V0IHRo
ZSBjbGllbnQsIGFuZCB0aGUgaW1wb3J0YW5jZSBvZiB1c2luZyBhCnN0YWJsZSBpZGVudGl0eSBh
bmQgcHJpbmNpcGFsLiAgT2J2aW91cyBpZiB0aGUgY2xpZW50IGNoYW5nZXMgZWl0aGVyCnRoZW4g
dGhlIGNvcnJlY3QgYWN0aW9uIG9mIHRoZSBzZXJ2ZXIgd2lsbCBjYXVzZSBwcm9ibGVtcyBmb3Ig
dGhlCmNsaWVudC4KSSdtIHNheWluZyB0aGF0IHRoZSBzeXMgYWRtaW4gc2hvdWxkbid0IG5lZWQg
dG8gd29ycnkgYWJvdXQgdGhpcyBhcyB0aGUKTkZTIGtlcm5lbCBtb2R1bGUgc2hvdWxkIGVuc3Vy
ZSB0aGVzZSB0aGluZ3MgZG9uJ3QgY2hhbmdlIC0gYW5kIEkgdGhpbmsKdGhhdCBpdCBkb2VzLCB0
aG91Z2ggSSdtIG5vdCBjZXJ0YWluIGFib3V0IHRoZSBwcmluY2lwYWwgYXMgSSBoYXZlbid0CmNo
ZWNrZWQuCgpUaGFua3MsCk5laWxCcm93bgo=
