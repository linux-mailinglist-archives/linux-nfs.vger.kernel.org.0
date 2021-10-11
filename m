Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E197442E420
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 00:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhJNWaP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 18:30:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42838 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhJNWaO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 18:30:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C21021A6F;
        Thu, 14 Oct 2021 22:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634250488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQhFZdazLokqvkVCCjL7FZIUVm22cpdsNzJuvI+VUK0=;
        b=NDMnXhkI20jlvjRdhc9Lhf1PFV/nsua018oCdV3czZXnPaHlvc1EI/vuXA4UBw5PZBousq
        XNjproi2EjkvV+I0rYabBlIyga0zeSsgxNBEPK5IOudJtJxNKQhBCii+UEu2Dj1ggtuYW3
        xFeq4oG8V/Mcyl4m8um8mvWNAWeHgzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634250488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQhFZdazLokqvkVCCjL7FZIUVm22cpdsNzJuvI+VUK0=;
        b=B2Xw2m7TNwOD2ywSGzCBJmX6y9Q4lE4D0+cs535Kt3p/JgRInjAK7bOOH+Zh8mzV2QxdZs
        9ChWyWTBBEttfCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1ED1813B3A;
        Thu, 14 Oct 2021 22:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fmSSL/WuaGHbPAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Oct 2021 22:28:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Charles Hedrick" <hedrick@cs.rutgers.edu>
Cc:     "Charles Hedrick" <hedrick@rutgers.edu>,
        "Chuck Lever III" <chuck.lever@oracle.com>,
        "Benjamin Coddington" <bcodding@redhat.com>,
        "Patrick Goetz" <pgoetz@math.utexas.edu>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: more problems with NFS. sort of repeatable problem with vmplayer
In-reply-to: <2C0DB856-23E5-41A2-A9F5-6E64F5A9FCB6@cs.rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>,
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>,
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>,
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>,
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>,
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>,
 <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>,
 <EE014097-EDF8-484B-81DF-9E7012122BB9@rutgers.edu>,
 <70E12E3F-2DFB-4557-9541-67276E5A195C@rutgers.edu>,
 <2C0DB856-23E5-41A2-A9F5-6E64F5A9FCB6@cs.rutgers.edu>
Date:   Tue, 12 Oct 2021 10:44:14 +1100
Message-id: <163399585460.17149.13892990608606706424@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAwNiBPY3QgMjAyMSwgQ2hhcmxlcyBIZWRyaWNrIHdyb3RlOgoKPiAKPiBJdCB0cmll
ZCBydW5uaW5nIHZtcGxheWVyLiAgU2hvcnRseSBhZnRlciBzdGFydGluZyB0byBjcmVhdGUgYSBu
ZXcgVk0sCj4gdm1wbGF5ZXIgaHVuZy4gIEkgaGFkIGFub3RoZXIgd2luZG93IHdpdGggYSBzaGVs
bC4gIEkgd2VudCBpbnRvIHRoZQo+IGRpcmVjdG9yeSB3aXRoIHRoZSB2bSBmaWxlcyBhbmQgZGlk
IOKAnGxzIC1sdHJj4oCdLiAgSXQgZGlkbuKAmXQgcXVpdGUgaGFuZywKPiBidXQgbG9vayBhYm91
dCBhIG1pbnV0ZSB0byBmaW5pc2ggSSBhbHNvIHNhdyBsb2cgZW50cmllcyBmcm9tIFZNd2FyZQo+
IGNvbXBsYWluaW5nIHRoYXQgZGlzayBvcGVyYXRpb25zIHRvb2sgc2V2ZXJhbCBzZWNvbmRzLiAK
ClVzZWZ1bCBpbmZvcm1hdGlvbiB0byBwcm92aWRlIHdoZW4gYSBwcm9jZXNzIGFwcGVhcnMgdG8g
aGFuZyBvbiBORlMKaW5jbHVkZToKCi0gY2F0IC9wcm9jLyRQSUQvc3RhY2sKCi0gcnBjZGVidWcg
LW0gbmZzIC1zIGFsbDsgcnBjZGVidWcgLW0gcnBjIC1zIGFsbCA7IHNsZWVwIDIgOyAKICAgcnBj
ZGVidWcgLW0gcnBjIC1jIGFsbDsgcnBjZGVidWcgLW0gbmZzIC1jIGFsbAogdGhlbiBjb2xsZWN0
IGtlcm5lbCBsb2dzCgotIHRjcGR1bXAgLXcgZmlsZW5hbWUucGNhcCAtcyAwIC1jIDEwMDAgcG9y
dCAyMDQ5CiAgYW5kIGNvbXByZXNzIGZpbGVuYW1lLnBjYXAgYW5kIHB1dCBpdCBzb21ld2hlcmUg
d2UgY2FuIGZpbmQgaXQuCgotIHRyYWNlLWNtZCByZWNvcmQgLWUgJ25mczoqJyBzbGVlcCAyCiAg
dHJhY2UtY21kIHJlcG9ydCA+IGZpbGVuYW1lCgo+IAo+IFdl4oCZcmUgcHJvYmFibHkgYW4gdW51
c3VhbCBpbnN0YWxsYXRpb24uICBXZeKAmXJlIGEgQ1MgZGVwYXJ0bWVudCwgd2l0aAo+IHJlc2Vh
cmNoZXJzIGFuZCBhbHNvIGEgbGFyZ2UgdGltZS1zaGFyaW5nIGVudmlyb25tZW50IGZvciBzdHVk
ZW50cwo+IChzcHJlYWQgYWNyb3NzIG1hbnkgbWFjaGluZXMsIHdpdGggYSBncmFwaGljYWwgaW50
ZXJmYWNlIHVzaW5nIFhyZGIsCj4gZXRjKS4gIE91ciBwZW9wbGUgdXNlIGV2ZXJ5IHBpZWNlIG9m
IHNvZnR3YXJlIHVuZGVyIHRoZSBzdW4uIAoKUHJvYmFibHkgbm90IGFsbCB0aGF0IHVudXN1YWwu
ICBUaGVyZSBjZXJ0YWlubHkgYXJlIGxvdHMgb2YgbGFyZ2UgYW5kCnZhcmllZCBORlMgc2l0ZXMg
b3V0IHRoZXJlLgoKPiAKPiBDbGllbnQgYW5kIHNlcnZlciBhcmUgYm90aCBVYnVudHUgMjAuMDQu
IFNlcnZlciBpcyBvbiBaRlMgd2l0aCBOVk1lIHN0b3JhZ2UuCgpJZiBpdCBpcyBwb3NzaWJsZSB0
byByZXByb2R1Y2Ugd2l0aG91dCBaRlMsIHRoYXQgd291bGQgcHJvdmlkZSB1c2VmdWwKaW5mb3Jt
YXRpb24uCkkgZG9uJ3QgdGhpbmsgaXQgaXMgKmxpa2VseSogdGhhdCBaRlMgY2F1c2VzIHRoZSBw
cm9ibGVtLCBidXQgbmVpdGhlcgp3b3VsZCBJIGJlIHN1cnByaXNlZCBpZiBpdCBkaWQuCgpOZWls
QnJvd24K
