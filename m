Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0253976BB
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jun 2021 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhFAPdV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 11:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234359AbhFAPdT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 11:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622561497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+5Ostc+FOuzREh2yofS1vbXJs1fHxV3ObCjOQmXyfQ=;
        b=Bv9eC8tlEcbt8atNptzHu6dHXAuTsoy6Yr7aHdLpRonn4W05vSN/QKidSyIe1F5EV8GEAl
        aqumEbccDheb/qmbRcVSYiMgIV4Kw+tVAnIRkSNsreHIQhIjHHggPPM9JGWE/gpWzNeH/9
        W9hh4bvCmKqBXkomdLu2tLmjSD1IIkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-2bW9sdbuMA2BlvIAX-FMqQ-1; Tue, 01 Jun 2021 11:31:36 -0400
X-MC-Unique: 2bW9sdbuMA2BlvIAX-FMqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D0C8015F8;
        Tue,  1 Jun 2021 15:31:35 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-198.rdu2.redhat.com [10.10.118.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6345960C0F;
        Tue,  1 Jun 2021 15:31:35 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 6934712070B; Tue,  1 Jun 2021 11:31:34 -0400 (EDT)
Date:   Tue, 1 Jun 2021 11:31:34 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Yong Sun <yosun@suse.com>
Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
Message-ID: <YLZS1iMJR59n4hue@pick.fieldses.org>
References: <YLY9pKu38lEWaXxE@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLY9pKu38lEWaXxE@pevik>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 01, 2021 at 04:01:08PM +0200, Petr Vorel wrote:
> I've also find different failures on NFS 4.0:
> 
> SEC7     st_secinfo.testRPCSEC_GSS                                : FAILURE
>            SECINFO returned mechanism list without RPCSEC_GSS

That shouldn't be run by default; see patch, appended.

> LOCK24   st_lock.testOpenUpgradeLock                              : FAILURE
>            OP_LOCK should return NFS4_OK, instead got
>            NFS4ERR_BAD_SEQID

I suspect the server's actually OK here, but I need to look more
closely.

> They're on stable kernel 5.12.3-1-default (openSUSE). I saw them also on older
> kernel 4.19.0-16-amd64 (Debian).
> 
> Any idea how to find whether are these are wrong setup or test bugs or real
> kernel bugs?

For what it's worth, this is what I do as part of my regular regression
tests, for 4.0:

	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-pynfs;h=4ed0f7942b9ff0907cbd3bb0ec1643dad02758f5;hb=HEAD

and for 4.1:

	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-pynfs41;h=b3afc60dfab17aa5037d3f587d3d113bc772970e;hb=HEAD

There are some known 4.0 failures that I skip:
	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs-skip;h=44256bb26e3fae86572e7c7057b1889652fa014b;hb=HEAD

(But LOCK24 isn't on that list because I keep saying I'm going to triage
it....)

And for 4.1:
	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs41-skip;h=c682bed97742cf799b94364872c7575ac9fc188c;hb=HEAD

--b.

commit 98f4ce2e6418
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue Jun 1 11:10:06 2021 -0400

    nfs4.0 secinfo: auth_gss not required
    
    RPCSEC_GSS is mandatory to implement, but that doesn't mean every server
    will have it be configured on.
    
    I try to only add the "all" tag to tests whose failure indicates the
    server is really out of spec, or at least is very unusual and likely to
    cause problems for clients.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/nfs4.0/servertests/st_secinfo.py b/nfs4.0/servertests/st_secinfo.py
index d9363de36969..4c4a44b3c919 100644
--- a/nfs4.0/servertests/st_secinfo.py
+++ b/nfs4.0/servertests/st_secinfo.py
@@ -102,7 +102,7 @@ def testRPCSEC_GSS(t, env):
 
     per section 3.2.1.1 of RFC
 
-    FLAGS: secinfo all
+    FLAGS: secinfo gss
     DEPEND: SEC1
     CODE: SEC7
     """

