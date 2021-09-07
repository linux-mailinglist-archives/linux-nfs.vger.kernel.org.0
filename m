Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89069403073
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhIGVs4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 17:48:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59944 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhIGVs4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 17:48:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 078FE221F1;
        Tue,  7 Sep 2021 21:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631051269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcWLkgnWSe/rUhjNLetTfZeFCbOn3W5emy9I2J3bCKg=;
        b=mqxFx3+qoBoUuxd9L8LFgVOy2l6PFj0DvrwQ82EKELNMQ99i2K8/h27PU4pznzw88spl3i
        Ex+8/1nufBnDmzt2HeFWf93Pay3h+F+heUFTAR31od0GIvXi5U5IxoJNAGDjBBH602q2q7
        slmNGvSoE3YKuYJq6K+PcgIBHV1c6iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631051269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcWLkgnWSe/rUhjNLetTfZeFCbOn3W5emy9I2J3bCKg=;
        b=FApcpmQGpLJpIq2Ok1GXPZmKTexWSsSEAlmWdk3pW8PrXZuFAybno1m0+3HrWVY7gy7r06
        hSqgcLYkS/p2UJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D47E13CAC;
        Tue,  7 Sep 2021 21:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qjrxNgLeN2FdIAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Sep 2021 21:47:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Matthew Wilcox" <willy@infradead.org>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Mel Gorman" <mgorman@suse.com>, "Linux-MM" <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
In-reply-to: <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>,
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>,
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>,
 <163096695999.2518.10383290668057550257@noble.neil.brown.name>,
 <163097529362.2518.16697605173806213577@noble.neil.brown.name>,
 <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
Date:   Wed, 08 Sep 2021 07:47:43 +1000
Message-id: <163105126377.2518.15592120108305789302@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 08 Sep 2021, Chuck Lever III wrote:
> 
> > On Sep 6, 2021, at 8:41 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > When does a single-page GFP_KERNEL allocation fail?  Ever?
> > 
> > I know that if I add __GFP_NOFAIL then it won't fail and that is
> > preferred to looping.
> > I know that if I add __GFP_RETRY_MAILFAIL (or others) then it might
> > fail.
> > But that is the semantics for a plain GFP_KERNEL ??
> > 
> > I recall a suggestion one that it would only fail if the process was
> > being killed by the oom killer.  That seems reasonable and would suggest
> > that retrying is really bad.  Is that true?
> > 
> > For svc_alloc_args(), it might be better to fail and have the calling
> > server thread exit.  This would need to be combined with dynamic
> > thread-count management so that when a request arrived, a new thread
> > might be started.
> 
> I don't immediately see a benefit to killing server threads
> during periods of memory exhaustion, but sometimes I lack
> imagination.


Dining philosophers problem.  If you cannot get all the resources you
need, a polite response is to release *all* the resources you have
before trying again.

> 
> 
> > So maybe we really don't want reclaim_progress_wait(), and all current
> > callers of congestion_wait() which are just waiting for allocation to
> > succeed should be either change to use __GFP_NOFAIL, or to handle
> > failure.
> 
> I had completely forgotten about GFP_NOFAIL. That seems like the
> preferred answer, as it avoids an arbitrary time-based wait for
> a memory resource. (And maybe svc_rqst_alloc() should also get
> the NOFAIL treatment?).

Apart from what others have said, GFP_NOFAIL is not appropriate for
svc_rqst_alloc() because it cannot honour kthread_stop().

NeilBrown
