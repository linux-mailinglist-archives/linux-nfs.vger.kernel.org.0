Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92CA4EC96B
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348675AbiC3QQ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348676AbiC3QQ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 12:16:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1B630C
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 09:14:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4D7EC218FC;
        Wed, 30 Mar 2022 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648656879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9nbrIZwl/w/SmKlzVFYWyq1hd4pLPAEy8n4qbWij28=;
        b=S+hYsWwLyrQn0tUJjU+bJRd7CQ17dqTBogFMmPNL3IKZFp8BKu/fnTjgty1MQ5fla/o5af
        w8ocExGstINtjxl4cO61y0WkMz5Gbc7cP8EGsHpFTvzZ4Qz2s5zKjt60NxgDGnL7ILU5FR
        yk/ObhzbxZwL1G8oQRFnSqMcyWUl3tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648656879;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9nbrIZwl/w/SmKlzVFYWyq1hd4pLPAEy8n4qbWij28=;
        b=utb5Gxljg5K2TfbdXbgU1DDn7YpEuvzH8yhpBxiZqsFGsNL8Bzv3NKFpL5mSElyfjhstAY
        npxV4aLMBXPWsuAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 36BAEA3B8A;
        Wed, 30 Mar 2022 16:14:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 83BFCA0610; Wed, 30 Mar 2022 18:14:32 +0200 (CEST)
Date:   Wed, 30 Mar 2022 18:14:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jack@suse.cz" <jack@suse.cz>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Performance regression with random IO pattern from the client
Message-ID: <20220330161432.xn6z5lyez2iizwj2@quack3.lan>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
 <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed 30-03-22 15:03:30, Trond Myklebust wrote:
> On Wed, 2022-03-30 at 12:34 +0200, Jan Kara wrote:
> > Hello,
> > 
> > during our performance testing we have noticed that commit
> > b6669305d35a
> > ("nfsd: Reduce the number of calls to nfsd_file_gc()") has introduced
> > a
> > performance regression when a client does random buffered writes. The
> > workload on NFS client is fio running 4 processed doing random
> > buffered writes to 4
> > different files and the files are large enough to hit dirty limits
> > and
> > force writeback from the client. In particular the invocation is
> > like:
> > 
> > fio --direct=0 --ioengine=sync --thread --directory=/mnt/mnt1 --
> > invalidate=1 --group_reporting=1 --runtime=300 --fallocate=posix --
> > ramp_time=10 --name=RandomReads-128000-4k-4 --new_group --
> > rw=randwrite --size=4000m --numjobs=4 --bs=4k --
> > filename_format=FioWorkloads.\$jobnum --end_fsync=1
> > 
> > The reason why commit b6669305d35a regresses performance is the
> > filemap_flush() call it adds into nfsd_file_put(). Before this commit
> > writeback on the server happened from nfsd_commit() code resulting in
> > rather long semisequential streams of 4k writes. After commit
> > b6669305d35a
> > all the writeback happens from filemap_flush() calls resulting in
> > much
> > longer average seek distance (IO from different files is more
> > interleaved)
> > and about 16-20% regression in the achieved writeback throughput when
> > the
> > backing store is rotational storage.
> > 
> > I think the filemap_flush() from nfsd_file_put() is indeed rather
> > aggressive and I think we'd be better off to just leave writeback to
> > either
> > nfsd_commit() or standard dirty page cleaning happening on the
> > system. I
> > assume the rationale for the filemap_flush() call was to make it more
> > likely the file can be evicted during the garbage collection run? Was
> > there
> > any particular problem leading to addition of this call or was it
> > just "it
> > seemed like a good idea" thing?
> > 
> > Thanks in advance for ideas.
> 
> It was mainly introduced to reduce the amount of work that
> nfsd_file_free() needs to do. In particular when re-exporting NFS, the
> call to filp_close() can be expensive because it synchronously flushes
> out dirty pages. That again means that some of the calls to
> nfsd_file_dispose_list() can end up being very expensive (particularly
> the ones run by the garbage collector itself).

I see, thanks for info. So I'm pondering what options we have for fixing
the performance regression. Because the filemap_flush() call in
nfsd_file_put() is just too aggressive and doesn't allow enough dirty data
to accumulate in the page cache for a reasonable IO pattern.

E.g. if the concern is just too long nfsd_file_dispose_list() runtime when
there are more files in the dispose list, we could do two iterations there
- the first one that walks all the files and starts async writeback for all
  of them, and the second one which drops the reference which among other
things may end up in ->flush() doing the synchronous writeback (but that
will now have not much to do). This is how generic writeback actually does
things for synchronous writeback because it is much faster than doing
submit one file, wait for one file in a loop if there are multiple files to
write. Would something like this be acceptable for you?

If something like this is not enough, we could also do something like
having another delayed work walking unused files and starting writeback for
them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
