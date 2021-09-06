Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288C440212D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Sep 2021 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhIFVxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 17:53:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40542 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhIFVxS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 17:53:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED8731FF3E;
        Mon,  6 Sep 2021 21:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630965131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBx2SyIkVdCnPWpDSlUbp6voL3zod692vz5sUdodVEI=;
        b=ALCfoFP+iiCmeDTxPRduMVBg18Rg8CdOcrEfh18xT6RrQDKmfw780csloGM3w8+RHzxizK
        Q0JAs0uFkHbAfiaGsjDZ+1ik7krsogJ5gJjR/C1I+9UpkCyp8NWChDgbWoouylCao38Og0
        LJi1Cj5n1acmwCOwiuxiLOFaIycHBGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630965131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBx2SyIkVdCnPWpDSlUbp6voL3zod692vz5sUdodVEI=;
        b=CE5TZpN9nJJBkiTZBZGgBYPCN/Kw7Iy3L4A70PkQ77zro997yYaslqZzXq09N3FDlhDayE
        cbxbT/lYhrcTGmAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EE6413C31;
        Mon,  6 Sep 2021 21:52:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xj15B4qNNmFUTgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 06 Sep 2021 21:52:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Mel Gorman" <mgorman@suse.com>, "Linux-MM" <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
In-reply-to: <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>,
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
Date:   Tue, 07 Sep 2021 07:52:07 +1000
Message-id: <163096512753.2518.2763320775379374551@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 07 Sep 2021, Chuck Lever III wrote:
> Hi Neil-
> 
> > On Sep 6, 2021, at 12:44 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > Many places that need to wait before retrying a memory allocation use
> > congestion_wait().  xfs_buf_alloc_pages() is a good example which
> > follows a similar pattern to that in svc_alloc_args().
> > 
> > It make sense to do the same thing in svc_alloc_args(); This will allow
> > the allocation to be retried sooner if some backing device becomes
> > non-congested before the timeout.
> > 
> > Every call to congestion_wait() in the entire kernel passes BLK_RW_ASYNC
> > as the first argument, so we should so.
> > 
> > The second argument - an upper limit for waiting - seem fairly
> > arbitrary.  Many places use "HZ/50" or "HZ/10".  As there is no obvious
> > choice, it seems reasonable to leave the maximum time unchanged.
> > 
> > If a service using svc_alloc_args() is terminated, it may now have to
> > wait up to the full 500ms before termination completes as
> > congestion_wait() cannot be interrupted.  I don't believe this will be a
> > problem in practice, though it might be justification for using a
> > smaller timeout.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > 
> > I happened to notice this inconsistency between svc_alloc_args() and
> > xfs_buf_alloc_pages() despite them doing very similar things, so thought
> > I'd send a patch.
> > 
> > NeilBrown
> 
> When we first considered the alloc_pages_bulk() API, the SUNRPC
> patch in that series replaced this schedule_timeout(). Mel
> suggested we postpone that to a separate patch. Now is an ideal
> time to consider this change again. I've added the MM folks for
> expert commentary.
> 
> I would rather see a shorter timeout, since that will be less
> disruptive in practice and today's systems shouldn't have to wait
> that long for free memory to become available. DEFAULT_IO_TIMEOUT
> might be a defensible choice -- it will slow down this loop
> effectively without adding a significant delay.

DEFAULT_IO_TIMEOUT is local to f2fs, so might not be the best choice.
I could be comfortable with any number from 1 to HZ, and have no basis
on how to make a choice - which is why I deliberately avoided making
one.
Ideally, the full timeout would (almost) never expire in practice.
Ideally, the interface would not even ask that we supply a timeout.
But are not currently at the ideal ;-(

Thanks,
NeilBrown
