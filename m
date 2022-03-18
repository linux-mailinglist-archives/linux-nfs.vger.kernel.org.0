Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C34DD40E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Mar 2022 06:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiCRFFk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Mar 2022 01:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiCRFFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Mar 2022 01:05:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8DE2AFA33
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 22:04:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 603A11F37F;
        Fri, 18 Mar 2022 05:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647579860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZU6lJnvX+MCH9+t7hFEQz2h4HVh6Nmu1/oDipWHGFM=;
        b=yGmiKqYMkN29rr2CvOUPt6GhhAfRW7GhxmSWbrno1BfcWY93VW/sFLroKp/zha9Tn4/kJF
        pKZRvJmZqwF58DNJIs4X12PXNPv613HS5goMjTBjpVwcBm28Bid6SGd1tZFIfm9jg/nWt0
        2Vi9Way5Nyj0+lyrL2ex0BarlgEoUBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647579860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZU6lJnvX+MCH9+t7hFEQz2h4HVh6Nmu1/oDipWHGFM=;
        b=haecd6TNEo0ImCwu4dMqkQ4eoAgZIOkr+OOMAo8sBVjIObngNCq257H5j/vYOHfYaQBNFU
        c1NElzLj/MSLXoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FD0313B01;
        Fri, 18 Mar 2022 05:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xUeiE9MSNGKpZAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 18 Mar 2022 05:04:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix memory allocation in rpc_malloc()
In-reply-to: <b93457f73c1e9df6c74fcb6d42374ddd3e202385.camel@hammerspace.com>
References: <20220315162052.570677-1-trondmy@kernel.org>,
 <164739558440.9764.6759307849718646101@noble.neil.brown.name>,
 <b93457f73c1e9df6c74fcb6d42374ddd3e202385.camel@hammerspace.com>
Date:   Fri, 18 Mar 2022 16:04:13 +1100
Message-id: <164757985358.24302.15398274267316568244@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAxNyBNYXIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFdlZCwgMjAy
Mi0wMy0xNiBhdCAxMjo1MyArMTEwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gV2VkLCAxNiBN
YXIgMjAyMiwgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90ZToKPiA+ID4gRnJvbTogVHJvbmQgTXlr
bGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPgo+ID4gPiAKPiA+ID4gV2hl
biBhbGxvY2F0aW5nIG1lbW9yeSwgaXQgc2hvdWxkIGJlIHNhZmUgdG8gYWx3YXlzIHVzZSBHRlBf
S0VSTkVMLAo+ID4gPiBzaW5jZSBib3RoIHN3YXAgdGFza3MgYW5kIGFzeW5jaHJvbm91cyB0YXNr
cyB3aWxsIHJlZ3VsYXRlIHRoZQo+ID4gPiBhbGxvY2F0aW9uIG1vZGUgdGhyb3VnaCB0aGUgc3Ry
dWN0IHRhc2sgZmxhZ3MuCj4gPiAKPiA+ICdzdHJ1Y3QgdGFza19zdHJ1Y3QnIGZsYWdzIGNhbiBv
bmx5IGVuZm9yY2UgTk9GUywgTk9JTywgb3IgTUVNQUxMT0MuCj4gPiBUaGV5IGNhbm5vdCBwcmV2
ZW50IHdhaXRpbmcgYWx0b2dldGhlci4KPiA+IFdlIG5lZWQgcnBjaW9kIHRhc2sgdG8gbm90IGJs
b2NrIHdhaXRpbmcgZm9yIG1lbW9yeS7CoCBJZiB0aGV5IGFsbCBkbywKPiA+IHRoZW4gdGhlcmUg
d2lsbCBiZSBubyB0aHJlYWQgZnJlZSB0byBoYW5kbGUgdGhlIHJlcGxpZXMgdG8gV1JJVEUKPiA+
IHdoaWNoCj4gPiB3b3VsZCBhbGxvdyBzd2FwcGVkLW91dCBtZW1vcnkgdG8gYmUgZnJlZWQuCj4g
PiAKPiA+IEFzIHRoZSB2ZXJ5IGxlYXN0IHRoZSByZXNjdWVyIHRocmVhZCBtdXN0bid0IGJsb2Nr
LCBzbyB0aGUgdXNlIG9mCj4gPiBHRlBfTk9XQUlUIGNvdWxkIGRlcGVuZCBvbiBjdXJyZW50X2lz
X3dvcmtxdWV1ZV9yZXNjdWVyKCkuCj4gPiAKPiA+IFdhcyB0aGVyZSBzb21lIHByb2JsZW0geW91
IHNhdyBjYXVzZWQgYnkgdGhlIHVzZSBvZiBHRlBfTk9XQUlUID8/Cj4gPiAKPiAKPiBUaGVyZSBp
cyBubyBwb2ludCBpbiB0cnlpbmcgdG8gZ2l2ZSBycGNpb2Qgc3Ryb25nZXIgcHJvdGVjdGlvbiB0
aGFuCj4gd2hhdCBpcyBnaXZlbiB0byB0aGUgc3RhbmRhcmQgbWVtb3J5IHJlY2xhaW0gcHJvY2Vz
c2VzLiBUaGUgVk0gZG9lcyBub3QKPiBoYXZlIGEgcmVxdWlyZW1lbnQgdGhhdCB3cml0ZXBhZ2Vz
KCkgYW5kIGl0cyBpbGsgdG8gYmUgbm9uLXdhaXRpbmcgYW5kCj4gbm9uLWJsb2NraW5nLCBub3Ig
ZG9lcyBpdCByZXF1aXJlIHRoYXQgdGhlIHRocmVhZHMgdGhhdCBoZWxwIHNlcnZpY2UKPiB0aG9z
ZSB3cml0ZWJhY2tzIGJlIG5vbi1ibG9ja2luZy4KCk15IHVuZGVyc3RhbmRpbmcgaXMgYSBsaXR0
bGUgbW9yZSBudWFuY2VkLiAgSXQgaXMgY2VydGFpbmx5IHRydWUgdGhhdAp3cml0ZXBhZ2VzKCkg
ZXRjIGNhbiBibG9jaywgYnV0IG9ubHkgZm9yIGV2ZW50cyB0aGF0IGFyZSBjZXJ0YWluIHRvCmhh
cHBlbiBpbiBzb21lIGZpbml0ZSB0aW1lLgpUaGlzIGlzIHdoeSB0aGUgYmxvY2sgbGF5ZXIgdXNl
cyBtZW1wb29scywgYW5kIHVzZXMgYSBkaWZmZXJlbnQgbWVtcG9vbAphdCBlYWNoIGxheWVyIGdv
aW5nIGRvd24gdGhlIHN0YWNrLiAgQXQgZWFjaCBsZXZlbCBpdCBpcyBvayB0byB3YWl0IGZvcgpl
dmVudHMgYXQgc29tZSBsb3dlciBsZXZlbCwgYnV0IG5vdCBmb3IgZXZlbnQgYXQgdGhlIHNhbWUg
b3IgaGlnaGVyCmxldmVsLiBUaGF0IGVuc3VyZXMgdGhlcmUgYXJlIG5vIGxvb3BzIGluIHRoZSB3
YWl0aW5nIGRlcGVuZGVuY3kuCgpUaGlzIGlzIHdoZXJlIHJwY2lvZCBmYWxscyBkb3duIHdpdGhv
dXQgdGhlIGNvbW1pdCB0aGF0IHlvdSB3YW50IHRvCnJldmVydC4KcnBjaW9kIHRocmVhZHMgYm90
aCB3YWl0IG9uIHRoZSBycGNfYnVmZmVyX21lbXBvb2wsIGFuZCByZXR1cm4gYnVmcyB0bwppdCB3
aXRoIG1lbXBvb2xfZnJlZSgpLiAgVGhpcyBtZWFucyB0aGF0IGFsbCB0aGUgYXZhaWxhYmxlIHRo
cmVhZHMgY291bGQKYmUgYmxvY2tlZCB3YWl0aW5nIG9uIHRoZSBtbWVwb29sLCBzbyBub25lIHdv
dWxkIGJlIGF2YWlsYWJsZSB0byBmcmVlCmJ1ZmZlcnMgZm9yIHdoaWNoIGEgcmVwbHkgaGFzIGJl
ZW4gcmVjZWl2ZWQuCgpJZiB0aGVyZSB3ZXJlIHNlcGFyYXRlIHdvcmtxdWV1ZXMgKHdpdGggc2Vw
YXJhdGUgcmVzY3VlciB0aHJlYWRzKSBmb3IKc2VuZGluZyByZXF1ZXN0cyBhbmQgZm9yIHJlY2Vp
dmluZyByZXBsaWVzLCB0aGVuIHRoZXJlIHdvdWxkbid0IGJlIGEKcHJvYmxlbSBoZXJlLiAgSSBo
YXZlbid0IGdpdmVuIHRoYXQgcG9zc2liaWxpdHkgbG90IG9mIHRob3VnaHQgYnV0IEkKdGhpbmsg
aXQgd291bGQgYmUgbWVzc3kgdG8gc2VwYXJhdGUgcmVxdWVzdHMgZnJvbSByZXBsaWVzIGxpa2Ug
dGhhdC4KCldpdGhvdXQgdGhlIHNlcGFyYXRpb24sIHdlIG5lZWQgdG8gZW5zdXJlIHJlcXVlc3Rz
IGRvbid0IGJsb2NrIHdhaXRpbmcgZm9yCnNvbWUgb3RoZXIgcmVwbHkgLSBlbHNlIHdlIGNhbiBk
ZWFkbG9jay4KCj4gCj4gV2Ugd291bGRuJ3QgYmUgYWJsZSB0byBkbyB0aGluZ3MgbGlrZSBjcmVh
dGUgYSBuZXcgc29ja2V0IHRvIHJlY29ubmVjdAo+IHRvIHRoZSBzZXJ2ZXIgaWYgd2UgY291bGRu
J3QgcGVyZm9ybSBibG9ja2luZyBhbGxvY2F0aW9ucyBmcm9tIHJwY2lvZC4KPiBOb25lIG9mIHRo
ZSBzb2NrZXQgY3JlYXRpb24gQVBJcyBhbGxvdyB5b3UgdG8gcGFzcyBpbiBhIGdmcCBmbGFnIG1h
c2suCgpGb3IgY2FzZXMgd2hlcmUgbWVtcG9vbHMgYXJlIG5vdCBjb252ZW5pZW50LCB0aGVyZSBp
cyBQRl9NRU1BTExPQy4gIFRoaXMKYWxsb3dzIGFjY2VzcyB0byBnZW5lcmljIHJlc2VydmVzLiAg
SXQgaXMgZGFuZ2Vyb3VzIHRvIHVzZSB0aGlzIGZvcgpyZWd1bGFyIGFsbG9jYXRpb25zIGFzIGl0
IGNhbiBzdGlsbCBiZSBleGhhdXN0ZWQgYW5kIGNhbiBzdGlsbCBjYXVzZQpkZWFkbG9ja3MuICBC
dXQgaXQgaXMgZ2VuZXJhbGx5IHNhZmUgZm9yIHJhcmUgYWxsb2NhdGlvbnMgYXMgeW91IGFyZQp1
bmxpa2VseSB0byBoYXZlIGxvdHMgb2YgdGhlbSBhdCBvbmNlIHJlc3VsdGluZyBpbiBleGhhdXN0
aW9uLgoKQWxsb2NhdGluZyBhIG5ldyBzb2NrZXQgaXMgZXhhY3RseSB0aGUgc29ydCBvZiB0aGlu
ZyB0aGF0IFBGX01FTUFMTE9DIGlzCmdvb2QgZm9yLiAgSXQgaGFwcGVuIHJhcmVseSAoaG91cnMg
b3IgbW9yZSksIGluIGNvbnRyYXN0IHdpdGgKcnBjX21hbGxvYygpIHdoaWNoIGhhcHBlbnMgZnJl
cXVlbnRseSAobXVsdGlwbGUgdGltZXMgYSBzZWNvbmQpLgpJJ20gbm90IGNlcnRhaW4gdGhhdCBz
b2NrZXQgYWxsb2NhdGlvbiBoYXBwZW5zIHVuZGVyIFBGX01FTUFMTE9DIC0gSQpzaG91bGQgY2hl
Y2sgLSBidXQgdGhhdCBpcyB0aGUgY29ycmVjdCBzb2x1dGlvbiBmb3IgdGhhdCBuZWVkLgoKPiAK
PiBXaGF0IHdlIGRvIHJlcXVpcmUgaW4gdGhpcyBzaXR1YXRpb24sIGlzIHRoYXQgd2UgbXVzdCBu
b3QgcmVjdXJzZSBiYWNrCj4gaW50byBORlMuIFRoaXMgaXMgd2h5IHdlIGhhdmUgdGhlIG1lbWFs
bG9jX25vZnNfc2F2ZSgpIC8KPiBtZW1hbGxvY19ub2ZzX3Jlc3RvcmUoKSBwcm90ZWN0aW9uIGlu
IHZhcmlvdXMgcGxhY2VzLCBpbmNsdWRpbmcKPiBycGNfYXN5bmNfc2NoZWR1bGUoKSBhbmQgcnBj
X2V4ZWN1dGUoKS4gVGhhdCBzdGlsbCBhbGxvd3MgdGhlIFZNIHRvCj4gYWN0aXZlbHkgcGVyZm9y
bSBkaXJlY3QgcmVjbGFpbSwgYW5kIHRvIHN0YXJ0IEkvTyBhZ2FpbnN0IGJsb2NrIGRldmljZXMK
PiB3aGVuIGluIGEgbG93IG1lbW9yeSBzaXR1YXRpb24uIFdoeSB3b3VsZCB3ZSBub3Qgd2FudCBp
dCB0byBkbyB0aGF0P8KgCgpDZXJ0YWlubHkgaXQgaXMgaW1wb3J0YW50IHRvIGF2b2lkIHJlY3Vy
c2lvbiBhbmQgdGhlIGltcHJvdmVtZW50cyB0bwpwcm9wZXJseSB1c2UgbWVtYWxsb2Nfbm9mc19z
YXZlKCkgZXRjIHNvIHRoYXQgd2UgZG9uJ3QgbmVlZCBHRlBfTk9GUyBhcmUKZ29vZC4gIENvbnNl
cXVlbnRseSB0aGVyZSBpcyBubyBwcm9ibGVtIHdpdGggc3RhcnRpbmcgcmVjbGFpbS4gIEkgd291
bGQKbm90IG9iamVjdCB0byBfX0dGUF9ESVJFQ1RfUkVDTEFJTSBiZWluZyBwYXNzZWQgdG8ga21h
bGxvYygpIHByb3ZpZGluZwpfX0dGUF9OT1JFVFJZIHdlcmUgcGFzc2VkIGFzIHdlbGwuCkJ1dCBw
YXNzaW5nIF9fR0ZQX0RJUkVDVF9SRUNMQUlNIHRvIG1lbXBvb2xfYWxsb2MoKSBjYXVzZXMgaXQg
dG8gd2FpdAppbmRlZmluaXRlbHkgZm9yIHN1Y2Nlc3MsIGFuZCB0aGF0IHRyaWdnZXJzIHRoZSBk
ZWFkbG9jayBiZWNhdXNlIHJwY2lvZAppcyB3YWl0aW5nIGZvciBzb21ldGhpbmcgdGhhdCBvbmx5
IHJwY2lvZCBjYW4gZG8uCgo+IAo+IFRoZSBhbHRlcm5hdGl2ZSB3aXRoIEdGUF9OT1dBSVQgaXMg
dG8gc3RhbGwgdGhlIFJQQyBJL08gYWx0b2dldGhlciB3aGVuCj4gaW4gYSBsb3cgbWVtb3J5IHNp
dHVhdGlvbiwgYW5kIHRvIGNyb3NzIG91ciBmaW5nZXJzIHRoYXQgc29tZXRoaW5nIGVsc2UKPiBj
YXVzZXMgbWVtb3J5IHRvIGJlIGZyZWVkIHVwLgoKSSBkb24ndCB0aGluayBjcm9zc2luZyBvdXIg
ZmluZ2VycyBpcyBnZW5lcmFsbHkgYSBnb29kIHN0cmF0ZWd5LiAgSQpkb24ndCB0aGluayAic29t
ZXRoaW5nIGVsc2UiIGZyZWVpbmcgdXAgbWVtb3J5IGlzIGxpa2VseSwgdGhvdWdoIG1heWJlCnRo
ZSBvb20ga2lsbGVyIG1pZ2h0LgpQRl9NRU1BTExPQyBlZmZlY3RpdmVseSBpcyBhICJjcm9zcyB5
b3VyIGZpbmdlcnMiIHN0cmF0ZWd5LCBidXQgdGhlcmUgaXQgaXMKbm90ICJzb21ldGhpbmcgd2ls
bCBmcmVlIHVwIG1lbW9yeSIsIGJ1dCByYXRoZXIgIndlJ2xsIG5ldmVyIG5lZWQgYWxsCnRoZSBy
ZXNlcnZlIGF0IHRoZSBzYW1lIHRpbWUiLiAgVGhhdCBpcyBzb21ld2hhdCBtb3JlIGRlZmVuc2li
bGUuCgpUaGFua3MsCk5laWxCcm93bgoKCj4gCj4gLS0gCj4gVHJvbmQgTXlrbGVidXN0Cj4gTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQo+IHRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20KPiAKPiAKPiAK
