Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C95965DF
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Aug 2022 01:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiHPXJK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 19:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiHPXJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 19:09:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE11D80361
        for <linux-nfs@vger.kernel.org>; Tue, 16 Aug 2022 16:09:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79D5533B22;
        Tue, 16 Aug 2022 23:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660691344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVFj7XyVYJd6jFEQPCZ1DDt8nv4wa3OmOA80u9T63kQ=;
        b=DXeT3o9NEb7Y81N3BSRbYTAf5SP/WXW7jMTjcBCNn4roQ/6wOJPoHKihBKBXiJMUz6nbjA
        u8Mkd9FDVhtASyK4mIS13ZbRiG+vV8qQLeNJPscd75ktIe2daj/6AnNY8fGYpsRWJ05Hny
        /EmNifD3m1wbw3dm0iaaJ5k1WkL9oMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660691344;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVFj7XyVYJd6jFEQPCZ1DDt8nv4wa3OmOA80u9T63kQ=;
        b=SRi7G6Q5YAdPjJQahrE2kNwGnLBDGPWL4iEoNd7QhnlVtM1HF+EEtfIgodJQ5Vs5VUcco6
        Wh/jiSnFtx6PGvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D760139B7;
        Tue, 16 Aug 2022 23:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HlIDFo8j/GK1NwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Aug 2022 23:09:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Thoughts on mount option to configure client lease renewal time.
In-reply-to: <e75a36e0a8d6a3df74e0083b91babde01fefb6f5.camel@hammerspace.com>
References: <166060650771.5425.13177692519730215643@noble.neil.brown.name>,
 <e75a36e0a8d6a3df74e0083b91babde01fefb6f5.camel@hammerspace.com>
Date:   Wed, 17 Aug 2022 09:09:00 +1000
Message-id: <166069134019.5425.14734830786295325514@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAxNiBBdWcgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFR1ZSwgMjAy
Mi0wOC0xNiBhdCAwOTozNSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gCj4gPiBDdXJyZW50
bHkgdGhlIExpbnV4IE5GUyByZW5ld3MgbGVhc2VzIGF0IDIvMyBvZiB0aGUgbGVhc2UgdGltZQo+
ID4gYWR2aXNlZAo+ID4gYnkgdGhlIHNlcnZlci4KPiA+IFNvbWUgc2VydmVyIHZlbmRvcnMgKE5v
dCBFeGFjdGx5IFRhcmdldGluZyBBbnkgUGFydGljdWxhciBQYXJ0eSkKPiA+IHJlY29tbWVuZCB2
ZXJ5IHNob3J0IGxlYXNlIHRpbWVzIC0gYXMgc2hvcnQgYSA1IHNlY29uZHMgaW4gZmFpbC1vdmVy
Cj4gPiBjb25maWd1cmF0aW9ucy7CoCBUaGlzIG1lYW5zIDEuNyBzZWNvbmRzIG9mIGppdHRlciBp
biBhbnkgcGFydCBvZiB0aGUKPiA+IHN5c3RlbSBjYW4gcmVzdWx0IGluIGxlYXNlcyBiZWluZyBs
b3N0IC0gYnV0IGl0IGRvZXMgYWNoaWV2ZSBmYXN0Cj4gPiBmYWlsLW92ZXIuIAo+ID4gCj4gPiBJ
ZiB3ZSBjb3VsZCBjb25maWd1cmUgYSA1IHNlY29uZCBsZWFzZS1yZW5ld2FsIG9uIHRoZSBjbGll
bnQsIGJ1dAo+ID4gbGVhdmUKPiA+IGEgNjAgc2Vjb25kIGxlYXNlIHRpbWUgb24gdGhlIHNlcnZl
ciwgdGhlbiB3ZSBjb3VsZCBnZXQgdGhlIGJlc3Qgb2YKPiA+IGJvdGgKPiA+IHdvcmxkcy7CoCBG
YWlsb3ZlciB3b3VsZCBoYXBwZW4gcXVpY2tseSwgYnV0IHlvdSB3b3VsZCBuZWVkIGEgbXVjaAo+
ID4gbG9uZ2VyCj4gPiBsb2FkIHNwaWtlIG9yIG5ldHdvcmsgcGFydGl0aW9uIHRvIGNhdXNlIHRo
ZSBsb3NzIG9mIGxlYXNlcy4KPiA+IAo+ID4gQXMgdjQuMSBjYW4gZW5kIHRoZSBncmFjZSBwZXJp
b2QgZWFybHkgb25jZSBldmVyeW9uZSBjaGVja3MgaW4sIGEKPiA+IGxhcmdlCj4gPiBncmFjZSBw
ZXJpb2QgKHdoaWNoIGlzIG5lZWRlZCBmb3IgYSBsYXJnZSBsZWFzZSB0aW1lKSB3b3VsZCByYXJl
bHkgYmUKPiA+IGEKPiA+IHByb2JsZW0uCj4gPiAKPiA+IFNvIG15IHRob3VnaHQgaXMgdG8gYWRk
IGEgbW91bnQgb3B0aW9uICJsZWFzZS1yZW5ldz01IiBmb3IgdjQuMSsKPiA+IG1vdW50cy4KPiA+
IFRoZSBjbGllbnRzIHRoZW4gdXNlcyB0aGF0IG51bWJlciBwcm92aWRpbmcgaXQgaXMgbGVzcyB0
aGFuIDIvMyBvZgo+ID4gdGhlCj4gPiBzZXJ2ZXItZGVjbGFyZWQgbGVhc2UgdGltZS4KPiA+IAo+
ID4gV2hhdCBkbyBwZW9wbGUgdGhpbmsgb2YgdGhpcz/CoCBJcyB0aGVyZSBhIGJldHRlciBzb2x1
dGlvbiwgb3IgYQo+ID4gcHJvYmxlbQo+ID4gd2l0aCB0aGlzIG9uZT8KPiA+IAo+ID4gTmVpbEJy
b3duCj4gPiDCoAo+IAo+IEkgZG9uJ3Qgc2VlIGhvdyB0aGUgTkZTIGNsaWVudCBjYW4gZXZlciBn
dWFyYW50ZWUgYSA1IHNlY29uZCBsZWFzZQo+IHJlbmV3YWwgdGltZSwgc28gYXMgZmFyIGFzIEkn
bSBjb25jZXJuZWQsIHRoaXMgaXMgbm90IGEgcHJvYmxlbSB3ZSBuZWVkCj4gdG8gc29sdmUuCgpJ
IGNvbXBsZXRlbHkgYWdyZWUgd2l0aCB0aGUgZmlyc3Qgc3RhdGVtZW50LgpUaGUgcHJvYmxlbSB3
ZSBuZWVkIHRvIHNvbHZlIGlzIHdoYXRldmVyIHByb2JsZW0gaXQgaXMgdGhhdCBtb3RpdmF0ZXMK
c2VydmVyIHZlbmRvcnMgdG8gcmVjb21tZW5kIHVucmVhbGlzdGljYWxseSBzaG9ydCBsZWFzZSB0
aW1lcy4KCkkgYmVsaWV2ZSB0aGlzIHByb2JsZW0gaXMgZmFpbC1vdmVyIHRpbWUuCkFzc3VtaW5n
IHRoYXQgYSBzZXJ2ZXIgZmFpbC1vdmVyIGhhcHBlbnMgaW5zdGFudGx5LCBmdWxsIE5GUyBzZXJ2
aWNlIGRvZXMKbm90IHJlc3VtZSB1bnRpbCBhZnRlciB0aGUgZ3JhY2UgcGVyaW9kIGNvbXBsZXRl
cy4KClByb3ZpZGluZyBjbGllbnRzIHNlbmQgUkVDTEFJTV9DT01QTEVURSBhcHByb3ByaWF0ZWx5
LCB0aGUgZ3JhY2UgcGVyaW9kCmNvdWxkIGVhc2lseSBiZSBhcyBsb25nIGFzOgoKICBjbGllbnQg
cmVuZXcgdGltZSArIHRpbWUgdG8gcmVjbGFpbSBhbGwgc3RhdGUKCmFzIGNsaWVudHMgdGhhdCBh
cmUgaWRsZSAob3IgYnVzeSB0aGlua2luZywgbm90IGFjY2Vzc2luZyB0aGUKZmlsZXN5c3RlbSkg
d2lsbCBub3Qgbm90aWNlIHRoZSBmYWlsb3ZlciB1bnRpbCB0aGV5IHNlbmQgYSByZW5ldywgd2hp
Y2gKbWF5IG5vdCBiZSB1bnRpbCB0aGUgZnVsbCByZW5ldyB0aW1lIGhhcyBwYXNzZWQuCgpUaGUg
b25seSBwYXJ0IG9mIHRoYXQgY2FsY3VsYXRpb24gdGhhdCBjYW4gYmUgY29udHJvbGxlZCBpcyB0
aGUgY2xpZW50CnJlbmV3IHRpbWUsIGFuZGF0IHByZXNlbnQgdGhhdCBjYW4gb25seSBiZSBjb250
cm9sbGVkIGJ5IHJlZHVjaW5nIHRoZQpsZWFzZSB0aW1lLiAgSGVuY2UgdGhlIHJlY29tbWVuZGF0
aW9uIGZvciBhIHNob3J0IGxlYXNlIHRpbWUuCgpJZiB3ZSBjb3VsZCBwcm92aWRlIGFuIGFsdGVy
bmF0ZSBtZWFucyB0byByZWR1Y2luZyB0aGUgY2xpZW50IHJlbmV3IHRpbWUKLSBhIG1vdW50IG9w
dGlvbiAtIHRoZW4gdGhlcmUgd291bGQgYmUgbm8gaW5jZW50aXZlIHRvIHJlY29tbWVuZCBhbgpp
bXByYWN0aWNhbGx5IHNob3J0IGxlYXNlIHRpbWUuCgpUaGFua3MsCk5laWxCcm93bgo=
