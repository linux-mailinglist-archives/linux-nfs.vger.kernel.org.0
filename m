Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9644CCB35
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Mar 2022 02:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiCDBOi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Mar 2022 20:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiCDBOg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Mar 2022 20:14:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1EE728E
        for <linux-nfs@vger.kernel.org>; Thu,  3 Mar 2022 17:13:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E36071F382;
        Fri,  4 Mar 2022 01:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646356428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kt2ysx+nwuxUmOYi0yZEWKGDLJ/zlWyV5s/5pYjxUec=;
        b=jm//m+k0uOr+eHDReZXxHolN45TKaD6mimVttI8Mcne+i7kTUHq8ZlYLctCvztoMqZar5d
        Rsd/kXE8AIm6+J78jZIMTJtUCNtN/HMjsIgQrfpFmeDC3LVNilB08CFe1u+/1BFNdSvIKN
        /cSrhTEBhI2r/ZXSwssAJYoJZponYu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646356428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kt2ysx+nwuxUmOYi0yZEWKGDLJ/zlWyV5s/5pYjxUec=;
        b=cRbQuDa6bylKvOotR5NVYyoPOe7YvCjVuSYnQKBkUA0slhQx8PRPLaelrMxe69OX7dLuWM
        k7c99wO6QTFY4ICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56D0713AF7;
        Fri,  4 Mar 2022 01:13:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QY3LBctnIWKcaAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 04 Mar 2022 01:13:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a container
In-reply-to: <fe1527f96f5b8f6280b24985603bbf99cde58864.camel@hammerspace.com>
References: <cover.1644515977.git.bcodding@redhat.com>,
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>,
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>,
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>,
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>,
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>,
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
 <fe1527f96f5b8f6280b24985603bbf99cde58864.camel@hammerspace.com>
Date:   Fri, 04 Mar 2022 12:13:44 +1100
Message-id: <164635642445.13165.9587906660448735526@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAwNCBNYXIgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFRodSwgMjAy
Mi0wMy0wMyBhdCAxNDoyNiArMTEwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gV2VkLCAwMiBN
YXIgMjAyMiwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOgo+ID4gCj4gPiAKPiA+ID4gCj4gPiA+IAo+
ID4gPiBUaGUgcmVtYWluaW5nIHBhcnQgb2YgdGhpcyB0ZXh0IHByb2JhYmx5IHNob3VsZCBiZQo+
ID4gPiBwYXJ0IG9mIHRoZSBtYW4gcGFnZSBmb3IgQmVuJ3MgdG9vbCwgb3Igd2hhdGV2ZXIgaXMK
PiA+ID4gY29taW5nIG5leHQuCj4gPiAKPiA+IE15IHBvc2l0aW9uIGlzIHRoYXQgdGhlcmUgaXMg
bm8gbmVlZCBmb3IgYW55IHRvb2wuwqAgVGhlIHRvdGFsIGFtb3VudAo+ID4gb2YKPiA+IGNvZGUg
bmVlZGVkIGlzIGEgY291cGxlIG9mIGxpbmVzIGFzIHByZXNlbnRlZCBpbiB0aGUgdGV4dCBiZWxv
dy7CoCBXaHkKPiA+IHByb3ZpZGUgYSB3cmFwcGVyIGp1c3QgZm9yIHRoYXQ/Cj4gPiBXZSAqY2Fu
bm90KiBhdXRvbWF0aWNhbGx5IGRlY2lkZSBob3cgdG8gZmluZCBhIG5hbWUgb3Igd2hlcmUgdG8g
c3RvcmUKPiA+IGEKPiA+IGdlbmVyYXRlZCB1dWlkLCBzbyB0aGVyZSBpcyBubyBhZGRlZCB2YWx1
ZSB0aGF0IGEgdG9vbCBjb3VsZCBwcm92aWRlLgo+ID4gCj4gPiBXZSBjYW5ub3QgdW5pbGF0ZXJh
bGx5IGZpeCBjb250YWluZXIgc3lzdGVtcy7CoCBXZSBjYW4gb25seSB0ZWxsCj4gPiBwZW9wbGUK
PiA+IHdobyBidWlsZCB0aGVzZSBzeXN0ZW1zIG9mIHRoZSByZXF1aXJlbWVudHMgZm9yIE5GUy4K
PiA+IAo+IAo+IEkgZGlzYWdyZWUgd2l0aCB0aGlzIHBvc2l0aW9uLiBUaGUgdmFsdWUgb2YgaGF2
aW5nIGEgc3RhbmRhcmQgdG9vbCBpcwo+IHRoYXQgaXQgYWxzbyBjcmVhdGVzIGEgc3RhbmRhcmQg
Zm9yIGhvdyBhbmQgd2hlcmUgdGhlIHVuaXF1aWZpZXIgaXMKPiBnZW5lcmF0ZWQgYW5kIHBlcnNp
c3RlZC4KPiAKPiBPdGhlcndpc2UgeW91IGhhdmUgdG8gZGVhbCB3aXRoIHRoZSBmYWN0IHRoYXQg
eW91IG1heSBoYXZlIGEgc3lzdGVtZAo+IHNjcmlwdCB0aGF0IHBlcnNpc3RzIHNvbWV0aGluZyBp
biBvbmUgZmlsZSwgYSBEb2NrZXJmaWxlIHJlY2lwZSB0aGF0Cj4gZ2VuZXJhdGVzIHNvbWV0aGlu
ZyBhdCBjb250YWluZXIgYnVpbGQgdGltZSwgYW5kIHRoZW4gYSBob21lLW1hZGUKPiBzY3JpcHQg
dGhhdCBsb29rcyBmb3Igc29tZXRoaW5nIGluIGEgZGlmZmVyZW50IGxvY2F0aW9uLiBJZiB5b3Un
cmUKPiB0cnlpbmcgdG8gZGVidWcgd2h5IHlvdXIgY29udGFpbmVycyBhcmUgYWxsIGdlbmVyYXRp
bmcgdGhlIHNhbWUKPiB1bmlxdWlmaWVyLCB0aGVuIHRoYXQgY2FuIGJlIGEgcHJvYmxlbS4KCkkg
ZG9uJ3Qgc2VlIGhvdyBhIHRvb2wgY2FuIHByb3ZpZGUgYW55IGNvbnNpc3RlbmN5LgpJcyB0aGVy
ZSBzb21lIHN0YW5kYXJkIHRoYXQgc2F5IGhvdyBjb250YWluZXJzIHNob3VsZCBiZSBidWlsdCwg
YW5kCndoZXJlIHRvb2xzIGNhbiBzdG9yZSBwZXJzaXN0ZW50IGRhdGE/ICBJZiBub3QsIHRoZSB0
b29sIG5lZWRzIHRvIGJlCmNvbmZpZ3VyZWQsIGFuZCB0aGF0IGlzIG5vdCBpbXBvcnRhbnRseSBk
aWZmZXJlbnQgZnJvbSBiYXNoIGJlaW5nCmNvbmZpZ3VyZWQgd2l0aCBhIDEtbGluZSBzY3JpcHQg
dG8gd3JpdGUgb3V0IHRoZSBpZGVudGlmaWVyLgoKSSdtIG5vdCBzdHJvbmdseSBhZ2FpbnN0IGEg
dG9vbHMsIEkganVzdCBjYW4ndCBzZWUgdGhlIGJlbmVmaXQuCgpUaGFua3MsCk5laWxCcm93bgo=
