Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6831F47A22C
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 22:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhLSVHX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 16:07:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36836 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhLSVHX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 16:07:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3EF31F37B;
        Sun, 19 Dec 2021 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639948041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WapFKtuHh8K6RAvrImTNVPitR7b6AKQIQukdhMeaVs=;
        b=YLWwrGsA1QsycYJBqxAU8FDOQjrUIDIUXZFie5NdvdJ/64n49FQX531d7dsRBGnhYADXZg
        iJZJpTRkVGupXRZCKVc+TQs9EKbFardaYeXohKU7mZHcELayDnMHerVuxvQNfcSq+h+feh
        WgRlziIuIpMw6QKrhF7EUs/HBcPuQMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639948041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WapFKtuHh8K6RAvrImTNVPitR7b6AKQIQukdhMeaVs=;
        b=xuh4NuAHT4vtIGu/y5zsgNzD9WBK6ZqBQWnKwBalFLrjfSNwqSB8fHXMRsCysz8rVDqZ5D
        tDwDRFwgnnZGxmAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD141133A7;
        Sun, 19 Dec 2021 21:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1AE5HQafv2G3MgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Dec 2021 21:07:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Anna Schumaker" <anna.schumaker@netapp.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-mm@kvack.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/18 V2] Repair SWAP-over-NFS
In-reply-to: <CAFX2Jfn8jER-aV_ttiAe1tkh8f+m=5-whEBTWbHO1uVwf=B4bw@mail.gmail.com>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>,
 <CAFX2Jfn8jER-aV_ttiAe1tkh8f+m=5-whEBTWbHO1uVwf=B4bw@mail.gmail.com>
Date:   Mon, 20 Dec 2021 08:07:15 +1100
Message-id: <163994803576.25899.6298619065481174544@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 18 Dec 2021, Anna Schumaker wrote:
> Hi Neil,
> 
> On Thu, Dec 16, 2021 at 7:07 PM NeilBrown <neilb@suse.de> wrote:
> >
> > swap-over-NFS currently has a variety of problems.
> >
> > swap writes call generic_write_checks(), which always fails on a swap
> > file, so it completely fails.
> > Even without this, various deadlocks are possible - largely due to
> > improvements in NFS memory allocation (using NOFS instead of ATOMIC)
> > which weren't tested against swap-out.
> >
> > NFS is the only filesystem that has supported fs-based swap IO, and it
> > hasn't worked for several releases, so now is a convenient time to clean
> > up the swap-via-filesystem interfaces - we cannot break anything !
> >
> > So the first few patches here clean up and improve various parts of the
> > swap-via-filesystem code.  ->activate_swap() is given a cleaner
> > interface, a new ->swap_rw is introduced instead of burdening
> > ->direct_IO, etc.
> >
> > Current swap-to-filesystem code only ever submits single-page reads and
> > writes.  These patches change that to allow multi-page IO when adjacent
> > requests are submitted.  Writes are also changed to be async rather than
> > sync.  This substantially speeds up write throughput for swap-over-NFS.
> >
> > Some of the NFS patches can land independently of the MM patches.  A few
> > require the MM patches to land first.
> 
> Thanks for fixing swap-over-NFS! Looks like it passes all the
> swap-related xfstests except for generic/357 on NFS v4.2. This test
> checks that we get -EINVAL on a reflinked swapfile, but I'm not sure
> if there is a way to check for that on the client side but if you have
> any ideas it would be nice to get that test passing while you're at
> it!

Thanks for testing!.
I think that testing that swap fails on a reflinked file is bogus.  This
isn't an important part of the API, it is just an internal
implementation detail.
I certainly understand that it could be problematic implementing swap on
a reflinked file within XFS and it is perfectly acceptable to fail such
a request.  But if one day someone decided to implement it - should that
be seen as a regression?

Certainly over NFS there is no reason at all not to swap to a file that
happens to be reflinked on the server.
I don't think it even makes sense to test if the file has holes as the
current nfs_swap_activate() does.  I don't exactly object to the test,
but I think it is misguided and pointless.

Thanks,
NeilBrown
