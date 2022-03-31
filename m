Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C684EDA40
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiCaNLZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiCaNLZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 09:11:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA6F2558E
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 06:09:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0FFE2210F4;
        Thu, 31 Mar 2022 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648732176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThsWpO0ajvy4COhz3/lf0Htsxhxb1AUA/Jo02CogF/s=;
        b=MBU7dmaIWH9JIns41sfGAkVViQyjGbSgVmoa6UheI9VxwEIMRr78LhTtvPiSd8f5kbeYz7
        dwtMVuWu0/3rVQAEKDrA11CWN1QAdWO77tzDiFykygBa+g+KFHp9W78x5m1KohqFMYq2d3
        aGrTs3Kby/Uoy7u3MznztV04LqQOOxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648732176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThsWpO0ajvy4COhz3/lf0Htsxhxb1AUA/Jo02CogF/s=;
        b=Tz07jS5ugZYE27oW2A29JIdfnkQvDkBg1YWDEbyXkQPxsSFVuClR1KT0cNcmfYMIB4bFTL
        B+KRCTNOyg0SI+CQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F08F5A3B94;
        Thu, 31 Mar 2022 13:09:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B237A0610; Thu, 31 Mar 2022 15:09:35 +0200 (CEST)
Date:   Thu, 31 Mar 2022 15:09:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jack@suse.cz" <jack@suse.cz>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: Performance regression with random IO pattern from the client
Message-ID: <20220331130935.ejqu3kxsjm2tvlly@quack3.lan>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
 <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
 <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
 <20220330161952.haopqr342qlij5hg@quack3.lan>
 <FDDB9D43-A695-46A6-9C82-2205C9779957@oracle.com>
 <e5dcbff2ad43304af5039315c00316f2ee5a4e25.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5dcbff2ad43304af5039315c00316f2ee5a4e25.camel@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed 30-03-22 22:02:39, Trond Myklebust wrote:
> On Wed, 2022-03-30 at 17:56 +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Mar 30, 2022, at 12:19 PM, Jan Kara <jack@suse.cz> wrote:
> > > 
> > > On Wed 30-03-22 15:38:38, Chuck Lever III wrote:
> > > > > On Mar 30, 2022, at 11:03 AM, Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > > 
> > > > > On Wed, 2022-03-30 at 12:34 +0200, Jan Kara wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > during our performance testing we have noticed that commit
> > > > > > b6669305d35a
> > > > > > ("nfsd: Reduce the number of calls to nfsd_file_gc()") has
> > > > > > introduced
> > > > > > a
> > > > > > performance regression when a client does random buffered
> > > > > > writes. The
> > > > > > workload on NFS client is fio running 4 processed doing
> > > > > > random
> > > > > > buffered writes to 4
> > > > > > different files and the files are large enough to hit dirty
> > > > > > limits
> > > > > > and
> > > > > > force writeback from the client. In particular the invocation
> > > > > > is
> > > > > > like:
> > > > > > 
> > > > > > fio --direct=0 --ioengine=sync --thread --directory=/mnt/mnt1
> > > > > > --
> > > > > > invalidate=1 --group_reporting=1 --runtime=300 --
> > > > > > fallocate=posix --
> > > > > > ramp_time=10 --name=RandomReads-128000-4k-4 --new_group --
> > > > > > rw=randwrite --size=4000m --numjobs=4 --bs=4k --
> > > > > > filename_format=FioWorkloads.\$jobnum --end_fsync=1
> > > > > > 
> > > > > > The reason why commit b6669305d35a regresses performance is
> > > > > > the
> > > > > > filemap_flush() call it adds into nfsd_file_put(). Before
> > > > > > this commit
> > > > > > writeback on the server happened from nfsd_commit() code
> > > > > > resulting in
> > > > > > rather long semisequential streams of 4k writes. After commit
> > > > > > b6669305d35a
> > > > > > all the writeback happens from filemap_flush() calls
> > > > > > resulting in
> > > > > > much
> > > > > > longer average seek distance (IO from different files is more
> > > > > > interleaved)
> > > > > > and about 16-20% regression in the achieved writeback
> > > > > > throughput when
> > > > > > the
> > > > > > backing store is rotational storage.
> > > > > > 
> > > > > > I think the filemap_flush() from nfsd_file_put() is indeed
> > > > > > rather
> > > > > > aggressive and I think we'd be better off to just leave
> > > > > > writeback to
> > > > > > either
> > > > > > nfsd_commit() or standard dirty page cleaning happening on
> > > > > > the
> > > > > > system. I
> > > > > > assume the rationale for the filemap_flush() call was to make
> > > > > > it more
> > > > > > likely the file can be evicted during the garbage collection
> > > > > > run? Was
> > > > > > there
> > > > > > any particular problem leading to addition of this call or
> > > > > > was it
> > > > > > just "it
> > > > > > seemed like a good idea" thing?
> > > > > > 
> > > > > > Thanks in advance for ideas.
> > > > > > 
> > > > > >                                                              
> > > > > >   Honza
> > > > > 
> > > > > It was mainly introduced to reduce the amount of work that
> > > > > nfsd_file_free() needs to do. In particular when re-exporting
> > > > > NFS, the
> > > > > call to filp_close() can be expensive because it synchronously
> > > > > flushes
> > > > > out dirty pages. That again means that some of the calls to
> > > > > nfsd_file_dispose_list() can end up being very expensive
> > > > > (particularly
> > > > > the ones run by the garbage collector itself).
> > > > 
> > > > The "no regressions" rule suggests that some kind of action needs
> > > > to be taken. I don't have a sense of whether Jan's workload or
> > > > NFS
> > > > re-export is the more common use case, however.
> > > > 
> > > > I can see that filp_close() on a file on an NFS mount could be
> > > > costly if that file has dirty pages, due to the NFS client's
> > > > "flush on close" semantic.
> > > > 
> > > > Trond, are there alternatives to flushing in the nfsd_file_put()
> > > > path? I'm willing to entertain bug fix patches rather than a
> > > > mechanical revert of b6669305d35a.
> > > 
> > > Yeah, I don't think we need to rush fixing this with a revert.
> > 
> > Sorry I wasn't clear: I would prefer to apply a bug fix over
> > sending a revert commit, and I do not have enough information
> > yet to make that choice. Waiting a bit is OK with me.
> > 
> > 
> > > Also because
> > > just removing the filemap_flush() from nfsd_file_put() would keep
> > > other
> > > benefits of that commit while fixing the regression AFAIU. But I
> > > think
> > > making flushing less aggressive is desirable because as I wrote in
> > > my other
> > > reply, currently it is preventing pagecache from accumulating
> > > enough dirty
> > > data for a good IO pattern.
> > 
> > I might even go so far as to say that a small write workload
> > isn't especially good for solid state storage either.
> > 
> > I know Trond is trying to address NFS re-export performance, but
> > there appear to be some palpable effects outside of that narrow
> > use case that need to be considered. Thus a server-side fix,
> > rather than a fix in the NFS client used to do the re-export,
> > seems appropriate to consider.
> 
> Turns out it is not just the NFS client that is the problem. It is
> rather that we need in general to be able to detect flush errors and
> either report them directly (through commit) or we need to change the
> boot verifier to force clients to resend the unstable writes.
> 
> Hence, I think we're looking at something like this:

Thanks for the fix! I've run the patch through some testing and your fix
indeed restores the good IO pattern and returns the performance back to
original levels. So feel free to add:

Tested-by: Jan Kara <jack@suse.cz>

								Honza

> 
> 8<--------------------------------------------------------------------
> From c0c89267f303432c8f5e490ea9b075856e4be79d Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Wed, 30 Mar 2022 16:55:38 -0400
> Subject: [PATCH] nfsd: Fix a write performance regression
> 
> The call to filemap_flush() in nfsd_file_put() is there to ensure that
> we clear out any writes belonging to a NFSv3 client relatively quickly
> and avoid situations where the file can't be evicted by the garbage
> collector. It also ensures that we detect write errors quickly.
> 
> The problem is this causes a regression in performance for some
> workloads.
> 
> So try to improve matters by deferring writeback until we're ready to
> close the file, and need to detect errors so that we can force the
> client to resend.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/filecache.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..9578a6317709 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -235,6 +235,13 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
>  	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
>  }
>  
> +static void
> +nfsd_file_flush(struct nfsd_file *nf)
> +{
> +	if (nf->nf_file && vfs_fsync(nf->nf_file, 1) != 0)
> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> +}
> +
>  static void
>  nfsd_file_do_unhash(struct nfsd_file *nf)
>  {
> @@ -302,11 +309,14 @@ nfsd_file_put(struct nfsd_file *nf)
>  		return;
>  	}
>  
> -	filemap_flush(nf->nf_file->f_mapping);
>  	is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
> -	nfsd_file_put_noref(nf);
> -	if (is_hashed)
> +	if (!is_hashed) {
> +		nfsd_file_flush(nf);
> +		nfsd_file_put_noref(nf);
> +	} else {
> +		nfsd_file_put_noref(nf);
>  		nfsd_file_schedule_laundrette();
> +	}
>  	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
>  		nfsd_file_gc();
>  }
> @@ -327,6 +337,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
>  	while(!list_empty(dispose)) {
>  		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del(&nf->nf_lru);
> +		nfsd_file_flush(nf);
>  		nfsd_file_put_noref(nf);
>  	}
>  }
> @@ -340,6 +351,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
>  	while(!list_empty(dispose)) {
>  		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del(&nf->nf_lru);
> +		nfsd_file_flush(nf);
>  		if (!refcount_dec_and_test(&nf->nf_ref))
>  			continue;
>  		if (nfsd_file_free(nf))
> -- 
> 2.35.1
> 
> 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
