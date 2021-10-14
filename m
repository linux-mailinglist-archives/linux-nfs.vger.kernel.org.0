Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7142E46E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 00:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhJNWxY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 18:53:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43936 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhJNWxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 18:53:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 534252196F;
        Thu, 14 Oct 2021 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634251878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlXcAuuDIvW3z2VorqCFxSCxEKvxyRCe+a9pWvJPKl0=;
        b=X/FkL1hce1jZo89F4w4pYvTG64yZd41tDI/XCY5af2n7Pi++6vdsikhz0eeG9pR03mrpys
        BEobTmuNE2xd8dPrpe9ruOvtyfJx5qK6ODs2tsxaueEV1Mac7eNkdeC3YSkQf4+jsoKasZ
        LxNbERbbkRFAj7iv/BgVVRRQlDtFGqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634251878;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlXcAuuDIvW3z2VorqCFxSCxEKvxyRCe+a9pWvJPKl0=;
        b=ZP3ZmPIUFFTbgsaZXx1kroIBUJAZ3CtJVUifqkkLX8l5EA2iEeDcmbYzxfrRJyYl/TAFGl
        nGutCE1auIJ79PBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0029A13522;
        Thu, 14 Oct 2021 22:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 37jHJ2O0aGEWRAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Oct 2021 22:51:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
In-reply-to: <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>,
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>,
 <20210812144428.GA9536@fieldses.org>,
 <162880418532.15074.7140645794203395299@noble.neil.brown.name>,
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>,
 <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>,
 <20211011143028.GB22387@fieldses.org>,
 <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>,
 <163398946770.17149.14605560717849885454@noble.neil.brown.name>,
 <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
Date:   Fri, 15 Oct 2021 09:51:12 +1100
Message-id: <163425187213.17149.4082212844733494965@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAxNSBPY3QgMjAyMSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+IE9uIFR1ZSwgMjAy
MS0xMC0xMiBhdCAwODo1NyArMTEwMCwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gVHVlLCAxMiBP
Y3QgMjAyMSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOgo+ID4gPiAKPiA+ID4gU2NvdHQgc2VlbXMg
d2VsbCBwb3NpdGlvbmVkIHRvIGlkZW50aWZ5IGEgcmVwcm9kdWNlci4gTWF5YmUgd2UKPiA+ID4g
Y2FuIGdpdmUgaGltIHNvbWUgbGlrZWx5IGNhbmRpZGF0ZXMgZm9yIHBvc3NpYmxlIGJ1Z3MgdG8g
ZXhwbG9yZQo+ID4gPiBmaXJzdC4KPiA+IAo+ID4gSGFzIHRoaXMgcGF0Y2ggYmVlbiB0cmllZD8K
PiA+IAo+ID4gTmVpbEJyb3duCj4gPiAKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMv
c2NoZWQuYyBiL25ldC9zdW5ycGMvc2NoZWQuYwo+ID4gaW5kZXggYzA0NWY2M2QxMWZhLi4zMDhm
NTk2MWNiNzggMTAwNjQ0Cj4gPiAtLS0gYS9uZXQvc3VucnBjL3NjaGVkLmMKPiA+ICsrKyBiL25l
dC9zdW5ycGMvc2NoZWQuYwo+ID4gQEAgLTgxNCw2ICs4MTQsNyBAQCBycGNfcmVzZXRfdGFza19z
dGF0aXN0aWNzKHN0cnVjdCBycGNfdGFzayAqdGFzaykKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKg
wqDCoHRhc2stPnRrX3RpbWVvdXRzID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqB0YXNrLT50a19m
bGFncyAmPSB+KFJQQ19DQUxMX01BSk9SU0VFTnxSUENfVEFTS19TRU5UKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoGNsZWFyX2JpdChSUENfVEFTS19TSUdOQUxMRUQsICZ0YXNrLT50a19ydW5zdGF0ZSk7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgcnBjX2luaXRfdGFza19zdAo+IAo+IFdlIHNob3VsZG4ndCBh
dXRvbWF0aWNhbGx5ICJ1bnNpZ25hbCIgYSB0YXNrIG9uY2UgaXQgaGFzIGJlZW4gdG9sZCB0bwo+
IGRpZS4gVGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8gaGVyZSBzaG91bGQgcmF0aGVyIGJlIHRvIGNo
YW5nZQo+IHJwY19yZXN0YXJ0X2NhbGwoKSB0byBleGl0IGVhcmx5IGlmIHRoZSB0YXNrIHdhcyBz
aWduYWxsZWQuCj4gCgpNYXliZS4gIEl0IGRlcGVuZHMgb24gZXhhY3RseSB3aGF0IHRoZSBzaWdu
YWwgbWVhbnQgKHJwY19raWxsYWxsX3Rhc2tzKCkKaXMgYSBiaXQgZGlmZmVyZW50IGZyb20gZ2V0
dGluZyBhIFNJR0tJTEwpLCBhbmQgZXhhY3RseSB3aGF0IHRoZSB0YXNrIGlzCnRyeWluZyB0byBh
Y2hpZXZlLgoKQmVmb3JlIENvbW1pdCBhZTY3YmQzODIxYmIgKCJTVU5SUEM6IEZpeCB1cCB0YXNr
IHNpZ25hbGxpbmciKQp0aGF0IGlzIGV4YWN0bHkgd2hhdCB3ZSBkaWQuCklmIHdlIHdhbnQgdG8g
Y2hhbmdlIHRoZSBiZWhhdmlvdXIgb2YgYSB0YXNrIHJlc3BvbmRpbmcgdG8KcnBjX2tpbGxhbGxf
dGFza3MoKSwgd2Ugc2hvdWxkIGNsZWFybHkganVzdGlmeSBpdCBpbiBhIHBhdGNoIGRvaW5nCmV4
YWN0bHkgdGhhdC4KCk5laWxCcm93bgo=
