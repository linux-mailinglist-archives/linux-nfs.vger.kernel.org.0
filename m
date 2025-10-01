Return-Path: <linux-nfs+bounces-14842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84649BB1359
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99AA77A6CB0
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93E2836A0;
	Wed,  1 Oct 2025 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH4n0xl0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513D220F2A
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334701; cv=none; b=Lebcqt9+vKkvWMa9lfSBPJywz7IsVbm/dN+qC8PNY3BrX6dYO2MiMlnOEWBI08usN/f5maERING1x8S/suAAA541SQb20/71PJHKqwDSbPoyLhFw/3lWKVcPunLLcHNgX+bub0J9Zpp4mz7boh2oeu1q+n3MzqhhGRmnUFiGVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334701; c=relaxed/simple;
	bh=s6keYVZYaDou8P9XZsfnX670Sr/Ow+HYOMNR5SHqbqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxGA8Zfsr2FiCtD6hfidYoFngbTyEtgXq52yostQXJAYKZPHk1DC5uBiSwD4FzhNm90ydCVqrcC2xDTU0M37oJuqwscF0Iup1GfpO5ZcPH8no8ThQKynVJ9JvMShTV1LDWJ6TQ+W7C830YuDv8aMVf69FnluP5PKZqCN1izc+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH4n0xl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047D2C4CEF1;
	Wed,  1 Oct 2025 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759334701;
	bh=s6keYVZYaDou8P9XZsfnX670Sr/Ow+HYOMNR5SHqbqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TH4n0xl0WIerB39f/aswU2/0pl4xApsHA7RcYU14zxX4CeBKlQah+ZH1r3tLPoIeB
	 0ljDyH8mNWxhf+Cbre7o3NRYZWJszoRM1k/9yjm1vs4LmimNQC01CsCdO/Jq2g4RMr
	 oeZGe2bc5VXbFi/y5dUswHcKsVkxfYad7TF5D4m8ejWs+EkOinAvsZqofF61WVx0rt
	 Uac7QgQmeZn4N+hD0jRIETtolS1V8I0WEzqeHbdnm58k3uuwwWm5Xz0zo2a0v3BaHD
	 emQhmpt4yDWRa5OV+xFPvzDbg5lDbpHxGxTZZvtgbFyXdjGxloD4jt26x5T8L7Tmzd
	 LMZ4y7IkzZSoQ==
Date: Wed, 1 Oct 2025 12:04:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [GIT PULL v2] NFS LOCALIO O_DIRECT changes for Linux 6.18
Message-ID: <aN1RK55xjYEmXCUE@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org>
 <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org>
 <aNgSOM9EzMS_Q6bR@kernel.org>
 <aNwEo7wOMrwcmq9b@kernel.org>
 <aNwwOvAZh5VAliWW@kernel.org>
 <2951eea3-772b-4a1a-9169-3d9a3c0661c5@oracle.com>
 <aNxL88GmEzJ5hsHl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNxL88GmEzJ5hsHl@kernel.org>

On Tue, Sep 30, 2025 at 05:30:27PM -0400, Mike Snitzer wrote:
> On Tue, Sep 30, 2025 at 04:53:49PM -0400, Anna Schumaker wrote:
> > Hi Mike,
> > 
> > On 9/30/25 3:32 PM, Mike Snitzer wrote:
> > > Hi Anna,
> > > 
> > > Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
> > > which will be included in the NFSD pull request for 6.18, I figured it
> > > worth proposing a post-NFSD-merge pull request for your consideration
> > > as the best way forward logistically (to ensure linux-next coverage,
> > > you could pull this in _before_ Chuck sends his pull to Linus).
> > 
> > I've applied your patches with the one NFSD patch acked-by Chuck and pushed
> > it out to my linux-next for a few days of wider testing. I agree with Chuck
> > that the remaining fixes can go in through an -rc once they're ready.
> 
> Perfect, thanks for the update.
> 
> Note that there will be merge conflicts that both linux-next and Linus
> will need to resolve.  Due to these nfsd-next commits:
> 
> c926f0298d3cd NFSD: Relocate the fh_want_write() and fh_drop_write() helpers
> c1f203e46c55a NFSD: Move the fh_getattr() helper
> 2ee3a75e42081 nfsd: discard nfsd_file_get_local() 

I looked to see that linux-next merges nfs before nfsd, so I inverted
the merge test:

$ git checkout -b nfs-merge-nfsd-next-6.18 anna-nfs/linux-next
branch 'nfs-merge-nfsd-next-6.18' set up to track 'anna-nfs/linux-next'.
Switched to a new branch 'nfs-merge-nfsd-next-6.18'

$ git merge cel/nfsd-next
Auto-merging fs/nfsd/filecache.c
Auto-merging fs/nfsd/filecache.h
Auto-merging fs/nfsd/localio.c
Auto-merging fs/nfsd/vfs.h
CONFLICT (content): Merge conflict in fs/nfsd/vfs.h
Auto-merging include/linux/nfslocalio.h
Auto-merging include/linux/sunrpc/svc_xprt.h
Auto-merging include/linux/sunrpc/xdr.h
Auto-merging net/sunrpc/svc.c
Auto-merging net/sunrpc/svc_xprt.c
Automatic merge failed; fix conflicts and then commit the result.

I've pushed the branch with my merge conflict resolution here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-merge-nfsd-next-6.18

Please feel free to point people at it as needed. As merge conflicts
go, pretty easy one.

Mike

ps. here is the merge commit:

$ git show a282c1cde64
commit a282c1cde643abab584a244076d94b575307301d
Merge: 1f0d4ab0f532 db155b7c7c85
Author: Mike Snitzer <snitzer@kernel.org>
Date:   Wed Oct 1 11:45:44 2025 -0400

    Merge remote-tracking branch 'cel/nfsd-next' into nfs-merge-nfsd-next-6.18
    
    Resolves merge conflict in fs/nfsd/nfsfh.c and fs/nfsd/vfs.h
    
    Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --cc fs/nfsd/localio.c
index 9e0a37cd29d8,269fa9391dc4..be710d809a3b
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@@ -132,9 -122,7 +132,8 @@@ static const struct nfsd_localio_operat
  	.nfsd_net_put  = nfsd_net_put,
  	.nfsd_open_local_fh = nfsd_open_local_fh,
  	.nfsd_file_put_local = nfsd_file_put_local,
- 	.nfsd_file_get_local = nfsd_file_get_local,
  	.nfsd_file_file = nfsd_file_file,
 +	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
  };
  
  void nfsd_localio_ops_init(void)
diff --cc fs/nfsd/nfsfh.c
index 74cf1f4de174,062cfc18d8c6..0bc2608a80b0
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@@ -662,6 -684,29 +684,33 @@@ out_negative
  	return nfserr_serverfault;
  }
  
+ /**
+  * fh_getattr - Retrieve attributes on a local file
+  * @fhp: File handle of target file
+  * @stat: Caller-supplied kstat buffer to be filled in
+  *
+  * Returns nfs_ok on success, otherwise an NFS status code is
+  * returned.
+  */
+ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
+ {
+ 	struct path p = {
+ 		.mnt		= fhp->fh_export->ex_path.mnt,
+ 		.dentry		= fhp->fh_dentry,
+ 	};
++	struct inode *inode = d_inode(p.dentry);
+ 	u32 request_mask = STATX_BASIC_STATS;
+ 
++	if (S_ISREG(inode->i_mode))
++		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
++
+ 	if (fhp->fh_maxsize == NFS4_FHSIZE)
+ 		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
+ 
+ 	return nfserrno(vfs_getattr(&p, stat, request_mask,
+ 				    AT_STATX_SYNC_AS_STAT));
+ }
+ 
  /**
   * fh_fill_pre_attrs - Fill in pre-op attributes
   * @fhp: file handle to be updated
diff --cc include/linux/nfslocalio.h
index 7ca2715edccc,59ea90bd136b..3d91043254e6
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@@ -63,10 -63,7 +63,9 @@@ struct nfsd_localio_operations 
  						struct nfsd_file __rcu **pnf,
  						const fmode_t);
  	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
- 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
  	struct file *(*nfsd_file_file)(struct nfsd_file *);
 +	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
 +					u32 *, u32 *, u32 *);
  } ____cacheline_aligned;
  
  extern void nfsd_localio_ops_init(void);

