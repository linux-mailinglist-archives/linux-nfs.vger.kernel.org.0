Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DDE596666
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Aug 2022 02:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiHQAqm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 20:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiHQAql (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 20:46:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC91760C4
        for <linux-nfs@vger.kernel.org>; Tue, 16 Aug 2022 17:46:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22665338CC;
        Wed, 17 Aug 2022 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660697199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51YNmGtZdTp8IyomnqP+5TIo1h3tcNo4dzHZzKDit5w=;
        b=gQJ+JNrSbWi+qWLOX7uLWCRmgm6WTxfFhiLMptP/qlu+tyYVVuxiF9SZeDaCzRVyZHUinu
        zl5n1p2L/TDtD0Ur/g7h8BN2a5Sy61ww/Q6MQ3Fo9XevMt8MnqC+YZvdGUqwN80V3XzkRG
        xZApqPUldHi2XvrkRDUF4wp1jg7a8B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660697199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51YNmGtZdTp8IyomnqP+5TIo1h3tcNo4dzHZzKDit5w=;
        b=+kZIYqiTFzMjLszr3XKm72w1gBWHZ6taygBnAhnG2eJBA24R8yF0cTiUquwx7A1WwNe+o+
        pgTlsnTSQiUNCFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C506139B7;
        Wed, 17 Aug 2022 00:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zl5aL206/GIjUgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Aug 2022 00:46:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Thoughts on mount option to configure client lease renewal time.
In-reply-to: <e6bbd3d63f31f268c1e701f586c0f204a1743edd.camel@hammerspace.com>
References: <166060650771.5425.13177692519730215643@noble.neil.brown.name>,
 <e75a36e0a8d6a3df74e0083b91babde01fefb6f5.camel@hammerspace.com>,
 <166069134019.5425.14734830786295325514@noble.neil.brown.name>,
 <e6bbd3d63f31f268c1e701f586c0f204a1743edd.camel@hammerspace.com>
Date:   Wed, 17 Aug 2022 10:46:33 +1000
Message-id: <166069719332.5425.17973595644872229726@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAxNyBBdWcgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFdlZCwgMjAy
Mi0wOC0xNyBhdCAwOTowOSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gVHVlLCAxNiBB
dWcgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiBPbiBUdWUsIDIwMjItMDgtMTYg
YXQgMDk6MzUgKzEwMDAsIE5laWxCcm93biB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiBDdXJyZW50
bHkgdGhlIExpbnV4IE5GUyByZW5ld3MgbGVhc2VzIGF0IDIvMyBvZiB0aGUgbGVhc2UgdGltZQo+
ID4gPiA+IGFkdmlzZWQKPiA+ID4gPiBieSB0aGUgc2VydmVyLgo+ID4gPiA+IFNvbWUgc2VydmVy
IHZlbmRvcnMgKE5vdCBFeGFjdGx5IFRhcmdldGluZyBBbnkgUGFydGljdWxhciBQYXJ0eSkKPiA+
ID4gPiByZWNvbW1lbmQgdmVyeSBzaG9ydCBsZWFzZSB0aW1lcyAtIGFzIHNob3J0IGEgNSBzZWNv
bmRzIGluIGZhaWwtCj4gPiA+ID4gb3Zlcgo+ID4gPiA+IGNvbmZpZ3VyYXRpb25zLsKgIFRoaXMg
bWVhbnMgMS43IHNlY29uZHMgb2Ygaml0dGVyIGluIGFueSBwYXJ0IG9mCj4gPiA+ID4gdGhlCj4g
PiA+ID4gc3lzdGVtIGNhbiByZXN1bHQgaW4gbGVhc2VzIGJlaW5nIGxvc3QgLSBidXQgaXQgZG9l
cyBhY2hpZXZlIGZhc3QKPiA+ID4gPiBmYWlsLW92ZXIuIAo+ID4gPiA+IAo+ID4gPiA+IElmIHdl
IGNvdWxkIGNvbmZpZ3VyZSBhIDUgc2Vjb25kIGxlYXNlLXJlbmV3YWwgb24gdGhlIGNsaWVudCwg
YnV0Cj4gPiA+ID4gbGVhdmUKPiA+ID4gPiBhIDYwIHNlY29uZCBsZWFzZSB0aW1lIG9uIHRoZSBz
ZXJ2ZXIsIHRoZW4gd2UgY291bGQgZ2V0IHRoZSBiZXN0Cj4gPiA+ID4gb2YKPiA+ID4gPiBib3Ro
Cj4gPiA+ID4gd29ybGRzLsKgIEZhaWxvdmVyIHdvdWxkIGhhcHBlbiBxdWlja2x5LCBidXQgeW91
IHdvdWxkIG5lZWQgYSBtdWNoCj4gPiA+ID4gbG9uZ2VyCj4gPiA+ID4gbG9hZCBzcGlrZSBvciBu
ZXR3b3JrIHBhcnRpdGlvbiB0byBjYXVzZSB0aGUgbG9zcyBvZiBsZWFzZXMuCj4gPiA+ID4gCj4g
PiA+ID4gQXMgdjQuMSBjYW4gZW5kIHRoZSBncmFjZSBwZXJpb2QgZWFybHkgb25jZSBldmVyeW9u
ZSBjaGVja3MgaW4sIGEKPiA+ID4gPiBsYXJnZQo+ID4gPiA+IGdyYWNlIHBlcmlvZCAod2hpY2gg
aXMgbmVlZGVkIGZvciBhIGxhcmdlIGxlYXNlIHRpbWUpIHdvdWxkCj4gPiA+ID4gcmFyZWx5IGJl
Cj4gPiA+ID4gYQo+ID4gPiA+IHByb2JsZW0uCj4gPiA+ID4gCj4gPiA+ID4gU28gbXkgdGhvdWdo
dCBpcyB0byBhZGQgYSBtb3VudCBvcHRpb24gImxlYXNlLXJlbmV3PTUiIGZvciB2NC4xKwo+ID4g
PiA+IG1vdW50cy4KPiA+ID4gPiBUaGUgY2xpZW50cyB0aGVuIHVzZXMgdGhhdCBudW1iZXIgcHJv
dmlkaW5nIGl0IGlzIGxlc3MgdGhhbiAyLzMKPiA+ID4gPiBvZgo+ID4gPiA+IHRoZQo+ID4gPiA+
IHNlcnZlci1kZWNsYXJlZCBsZWFzZSB0aW1lLgo+ID4gPiA+IAo+ID4gPiA+IFdoYXQgZG8gcGVv
cGxlIHRoaW5rIG9mIHRoaXM/wqAgSXMgdGhlcmUgYSBiZXR0ZXIgc29sdXRpb24sIG9yIGEKPiA+
ID4gPiBwcm9ibGVtCj4gPiA+ID4gd2l0aCB0aGlzIG9uZT8KPiA+ID4gPiAKPiA+ID4gPiBOZWls
QnJvd24KPiA+ID4gPiDCoAo+ID4gPiAKPiA+ID4gSSBkb24ndCBzZWUgaG93IHRoZSBORlMgY2xp
ZW50IGNhbiBldmVyIGd1YXJhbnRlZSBhIDUgc2Vjb25kIGxlYXNlCj4gPiA+IHJlbmV3YWwgdGlt
ZSwgc28gYXMgZmFyIGFzIEknbSBjb25jZXJuZWQsIHRoaXMgaXMgbm90IGEgcHJvYmxlbSB3ZQo+
ID4gPiBuZWVkCj4gPiA+IHRvIHNvbHZlLgo+ID4gCj4gPiBJIGNvbXBsZXRlbHkgYWdyZWUgd2l0
aCB0aGUgZmlyc3Qgc3RhdGVtZW50Lgo+ID4gVGhlIHByb2JsZW0gd2UgbmVlZCB0byBzb2x2ZSBp
cyB3aGF0ZXZlciBwcm9ibGVtIGl0IGlzIHRoYXQgbW90aXZhdGVzCj4gPiBzZXJ2ZXIgdmVuZG9y
cyB0byByZWNvbW1lbmQgdW5yZWFsaXN0aWNhbGx5IHNob3J0IGxlYXNlIHRpbWVzLgo+ID4gCj4g
PiBJIGJlbGlldmUgdGhpcyBwcm9ibGVtIGlzIGZhaWwtb3ZlciB0aW1lLgo+ID4gQXNzdW1pbmcg
dGhhdCBhIHNlcnZlciBmYWlsLW92ZXIgaGFwcGVucyBpbnN0YW50bHksIGZ1bGwgTkZTIHNlcnZp
Y2UKPiA+IGRvZXMKPiA+IG5vdCByZXN1bWUgdW50aWwgYWZ0ZXIgdGhlIGdyYWNlIHBlcmlvZCBj
b21wbGV0ZXMuCj4gPiAKPiA+IFByb3ZpZGluZyBjbGllbnRzIHNlbmQgUkVDTEFJTV9DT01QTEVU
RSBhcHByb3ByaWF0ZWx5LCB0aGUgZ3JhY2UKPiA+IHBlcmlvZAo+ID4gY291bGQgZWFzaWx5IGJl
IGFzIGxvbmcgYXM6Cj4gPiAKPiA+IMKgIGNsaWVudCByZW5ldyB0aW1lICsgdGltZSB0byByZWNs
YWltIGFsbCBzdGF0ZQo+ID4gCj4gPiBhcyBjbGllbnRzIHRoYXQgYXJlIGlkbGUgKG9yIGJ1c3kg
dGhpbmtpbmcsIG5vdCBhY2Nlc3NpbmcgdGhlCj4gPiBmaWxlc3lzdGVtKSB3aWxsIG5vdCBub3Rp
Y2UgdGhlIGZhaWxvdmVyIHVudGlsIHRoZXkgc2VuZCBhIHJlbmV3LAo+ID4gd2hpY2gKPiA+IG1h
eSBub3QgYmUgdW50aWwgdGhlIGZ1bGwgcmVuZXcgdGltZSBoYXMgcGFzc2VkLgo+ID4gCj4gPiBU
aGUgb25seSBwYXJ0IG9mIHRoYXQgY2FsY3VsYXRpb24gdGhhdCBjYW4gYmUgY29udHJvbGxlZCBp
cyB0aGUKPiA+IGNsaWVudAo+ID4gcmVuZXcgdGltZSwgYW5kYXQgcHJlc2VudCB0aGF0IGNhbiBv
bmx5IGJlIGNvbnRyb2xsZWQgYnkgcmVkdWNpbmcgdGhlCj4gPiBsZWFzZSB0aW1lLsKgIEhlbmNl
IHRoZSByZWNvbW1lbmRhdGlvbiBmb3IgYSBzaG9ydCBsZWFzZSB0aW1lLgo+ID4gCj4gPiBJZiB3
ZSBjb3VsZCBwcm92aWRlIGFuIGFsdGVybmF0ZSBtZWFucyB0byByZWR1Y2luZyB0aGUgY2xpZW50
IHJlbmV3Cj4gPiB0aW1lCj4gPiAtIGEgbW91bnQgb3B0aW9uIC0gdGhlbiB0aGVyZSB3b3VsZCBi
ZSBubyBpbmNlbnRpdmUgdG8gcmVjb21tZW5kIGFuCj4gPiBpbXByYWN0aWNhbGx5IHNob3J0IGxl
YXNlIHRpbWUuCj4gPiAKPiA+IFRoYW5rcywKPiA+IE5laWxCcm93bgo+IAo+IEluc3RlYWQgb2Yg
d2FzdGluZyBhIGxvYWQgb2YgQ1BVIGN5Y2xlcyBwaW5naW5nIHRoZSBORlMgbGF5ZXIsIHdoeSBu
b3QKPiBmYXJtIHRoaXMgb3V0IHRvIHRoZSBUQ1AgbGF5ZXI/IFdlIGFscmVhZHkgaGF2ZSBrZWVw
YWxpdmUgdG8gZW5zdXJlCj4gdGhhdCB0aGUgY29ubmVjdGlvbiBzdGF5cyB1cC4gQWxsIHdlIHJl
YWxseSBuZWVkIGlzIHRvIGhhbmRsZSB0aGUgY2FzZQo+IHdoZXJlIHRoZSBjb25uZWN0aW9uIGlz
IGJyb2tlbiBieSB0aGUgc2VydmVyLgo+IAo+IFNvIHRoZSBzdWdnZXN0aW9uIHdvdWxkIGJlIHRo
YXQgd2hlbiB0aGUgY29ubmVjdGlvbiBpcyBicm9rZW4sIHdlIHN0YXJ0Cj4gc2VuZGluZyBhIFNF
UVVFTkNFIHBpbmcgaW4gb3JkZXIgdG8gZmlndXJlIG91dCB3aGF0IGhhcHBlbmVkLCBhbmQKPiB3
aGV0aGVyIHdlIG5lZWQgdG8gcmUtZXN0YWJsaXNoIHN0YXRlLgo+IAo+IE5vIG1vdW50IG9wdGlv
bnMgbmVlZGVkLi4uCgpZZXMsIHRoYXQgaXMgYW4gaW50ZXJlc3RpbmcgaWRlYS4KVGhpcyB3b3Vs
ZCBtZWFuIHRoYXQgdGhlIHRpbWVvL3JldHJhbnMgbW91bnQgb3B0aW9ucyB3b3VsZCBkZXRlcm1p
bmUgdGhlCmVmZmVjdGl2ZSBsZWFzZSByZW5ld2FsIHRpbWUgd2hlbiB0aGUgc2VydmVyIHN0b3Bz
IHJlc3BvbmRpbmcuICBUaGF0CnNlZW1zIHRvIG1ha2Ugc2Vuc2UuCgpJJ2xsIGhhdmUgYSBsb29r
IGFuZCBzZWUgaG93IG11Y2ggY2hhbmdlIGlzIHJlcXVpcmVkIHRvIHNlbmQgYSByZW5ldyBpZgp0
aGVyZSBhcmUgbm8gcGVuZGluZyByZXF1ZXN0cyB3aGVuIHRoZSBjb25uZWN0aW9uIGNsb3Nlcy4K
ClRoYW5rcyEKTmVpbEJyb3duCg==
