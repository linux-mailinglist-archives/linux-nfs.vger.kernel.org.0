Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D704EC995
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348751AbiC3QVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348739AbiC3QVj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 12:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B26C4AC
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 09:19:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 80970210E5;
        Wed, 30 Mar 2022 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648657192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Je6/s8Ypzp57VFQNWzctFIQlJ1K47N8QuVcvBmQvgoA=;
        b=EnkKI3rdMgoLnYLo/VbPVM8/IcqoYRu3txlwVxn/X+5vv2peVIPzfR3RYeJvsrotAPphCY
        ZgpGsrEhMrZ0P6TcaWvvsv9hxPdrFgZ+EfRLGwMvWlTOxxJkli4GANJUYB0tREIUJNA9q4
        ifaJDNcd9POMklc1LLGaZnhHRbQj+VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648657192;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Je6/s8Ypzp57VFQNWzctFIQlJ1K47N8QuVcvBmQvgoA=;
        b=4bpERvfk4AQpSDfYHdgXXUOqwNaKbGPBYVLHpc6nGqGOjE3NtiSCydu2gsi035YycY2/r8
        N/CybYAi5CD+poBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D1F6A3B83;
        Wed, 30 Mar 2022 16:19:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1E225A0610; Wed, 30 Mar 2022 18:19:52 +0200 (CEST)
Date:   Wed, 30 Mar 2022 18:19:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "jack@suse.cz" <jack@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: Performance regression with random IO pattern from the client
Message-ID: <20220330161952.haopqr342qlij5hg@quack3.lan>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
 <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
 <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed 30-03-22 15:38:38, Chuck Lever III wrote:
> > On Mar 30, 2022, at 11:03 AM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > 
> > On Wed, 2022-03-30 at 12:34 +0200, Jan Kara wrote:
> >> Hello,
> >> 
> >> during our performance testing we have noticed that commit
> >> b6669305d35a
> >> ("nfsd: Reduce the number of calls to nfsd_file_gc()") has introduced
> >> a
> >> performance regression when a client does random buffered writes. The
> >> workload on NFS client is fio running 4 processed doing random
> >> buffered writes to 4
> >> different files and the files are large enough to hit dirty limits
> >> and
> >> force writeback from the client. In particular the invocation is
> >> like:
> >> 
> >> fio --direct=0 --ioengine=sync --thread --directory=/mnt/mnt1 --
> >> invalidate=1 --group_reporting=1 --runtime=300 --fallocate=posix --
> >> ramp_time=10 --name=RandomReads-128000-4k-4 --new_group --
> >> rw=randwrite --size=4000m --numjobs=4 --bs=4k --
> >> filename_format=FioWorkloads.\$jobnum --end_fsync=1
> >> 
> >> The reason why commit b6669305d35a regresses performance is the
> >> filemap_flush() call it adds into nfsd_file_put(). Before this commit
> >> writeback on the server happened from nfsd_commit() code resulting in
> >> rather long semisequential streams of 4k writes. After commit
> >> b6669305d35a
> >> all the writeback happens from filemap_flush() calls resulting in
> >> much
> >> longer average seek distance (IO from different files is more
> >> interleaved)
> >> and about 16-20% regression in the achieved writeback throughput when
> >> the
> >> backing store is rotational storage.
> >> 
> >> I think the filemap_flush() from nfsd_file_put() is indeed rather
> >> aggressive and I think we'd be better off to just leave writeback to
> >> either
> >> nfsd_commit() or standard dirty page cleaning happening on the
> >> system. I
> >> assume the rationale for the filemap_flush() call was to make it more
> >> likely the file can be evicted during the garbage collection run? Was
> >> there
> >> any particular problem leading to addition of this call or was it
> >> just "it
> >> seemed like a good idea" thing?
> >> 
> >> Thanks in advance for ideas.
> >> 
> >>                                                                 Honza
> > 
> > It was mainly introduced to reduce the amount of work that
> > nfsd_file_free() needs to do. In particular when re-exporting NFS, the
> > call to filp_close() can be expensive because it synchronously flushes
> > out dirty pages. That again means that some of the calls to
> > nfsd_file_dispose_list() can end up being very expensive (particularly
> > the ones run by the garbage collector itself).
> 
> The "no regressions" rule suggests that some kind of action needs
> to be taken. I don't have a sense of whether Jan's workload or NFS
> re-export is the more common use case, however.
> 
> I can see that filp_close() on a file on an NFS mount could be
> costly if that file has dirty pages, due to the NFS client's
> "flush on close" semantic.
> 
> Trond, are there alternatives to flushing in the nfsd_file_put()
> path? I'm willing to entertain bug fix patches rather than a
> mechanical revert of b6669305d35a.

Yeah, I don't think we need to rush fixing this with a revert. Also because
just removing the filemap_flush() from nfsd_file_put() would keep other
benefits of that commit while fixing the regression AFAIU. But I think
making flushing less aggressive is desirable because as I wrote in my other
reply, currently it is preventing pagecache from accumulating enough dirty
data for a good IO pattern.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
