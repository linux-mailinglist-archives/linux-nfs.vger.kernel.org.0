Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBC3F50E1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhHWS6S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhHWS6R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 14:58:17 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E39C061575
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 11:57:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2E4FF6855; Mon, 23 Aug 2021 14:57:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2E4FF6855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629745054;
        bh=nVFIdiVvGI9zgUe3GKgdDNNj1Qj6UA6oOfOOaFmrL+w=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=VGXIpUOC6JpDUleUJiqwmmIjKI5sORITtnB1UFIVMsrNymHtxQPhmh6PsgtYiT3An
         Os7iskQNK/obx66JBIe9MwgUjLASv53BPNTstMa3wP4EkskHAIlvW1oiRBDDYqclGB
         QfLbLiF6vH7Qlhjfqeo9fzZDsfjLbLFss5Zj241E=
Date:   Mon, 23 Aug 2021 14:57:34 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Message-ID: <20210823185734.GG883@fieldses.org>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-6-git-send-email-bfields@redhat.com>
 <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Aug 21, 2021 at 04:30:43PM +0000, Chuck Lever III wrote:
> > @@ -654,7 +658,12 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
> > 	nlmsvc_cancel_blocked(net, file, lock);
> > 
> > 	lock->fl.fl_type = F_UNLCK;
> > -	error = vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> > +	if (file->f_file[0])
> > +		error = vfs_lock_file(file->f_file[0], F_SETLK,
> > +					&lock->fl, NULL);
> > +	if (file->f_file[1])
> > +		error = vfs_lock_file(file->f_file[1], F_SETLK,
> > +					&lock->fl, NULL);
> 
> Eschew raw integers :-) Should the f_file array be indexed
> using O_ flags as the comment below suggests?

Sure, done.

> > diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> > index f43d89e89c45..a0adaee245ae 100644
> > --- a/fs/lockd/svcsubs.c
> > +++ b/fs/lockd/svcsubs.c
> > @@ -71,14 +71,38 @@ static inline unsigned int file_hash(struct nfs_fh *f)
> > 	return tmp & (FILE_NRHASH - 1);
> > }
> > 
> > +int lock_to_openmode(struct file_lock *lock)
> > +{
> > +	if (lock->fl_type == F_WRLCK)
> > +		return O_WRONLY;
> > +	else
> > +		return O_RDONLY;
> 
> Style: a ternary would be more consistent with other areas
> of the code you change in this patch.

OK.

> > +static int nlm_unlock_files(struct nlm_file *file)
> > +{
> > +	struct file_lock lock;
> > +	struct file *f;
> > +
> > +	lock.fl_type  = F_UNLCK;
> > +	lock.fl_start = 0;
> > +	lock.fl_end   = OFFSET_MAX;
> > +	for (f = file->f_file[0]; f <= file->f_file[1]; f++) {
> > +		if (f && vfs_lock_file(f, F_SETLK, &lock, NULL) < 0) {
> > +			printk("lockd: unlock failure in %s:%d\n",
> > +				__FILE__, __LINE__);
> 
> This needs a KERN_LEVEL and maybe a _once.

How about going with pr_warn for now.  I don't *think* there's much
danger of spamming the logs from this one.  And I'm wondering there
might be some causes (unresponsive server?) that could resolve
themselves, and then come back, and that you'd still want to hear about
the second time.

> > @@ -27,7 +27,8 @@ struct rpc_task;
> > struct nlmsvc_binding {
> > 	__be32			(*fopen)(struct svc_rqst *,
> > 						struct nfs_fh *,
> > -						struct file **);
> > +						struct file **,
> > +						int mode);
> 
> Style: "mode_t mode" might be better internal documentation.

It's confusing that we use the word "mode" both for "access mode" (O_
flags) and "mode bits" (permission bits).  This is the former, and I
thought mode_t was the for the latter.

> > @@ -154,7 +156,8 @@ struct nlm_rqst {
> > struct nlm_file {
> > 	struct hlist_node	f_list;		/* linked list */
> > 	struct nfs_fh		f_handle;	/* NFS file handle */
> > -	struct file *		f_file;		/* VFS file pointer */
> > +	struct file *		f_file[2];	/* VFS file pointers,
> > +						   indexed by O_ flags */
> 
> Right, except that the new code in this patch always indexes
> f_file with raw integers, making the comment misleading. My
> preference is to keep the comment and change the new code to
> index f_file symbolically.

OK.

--b.
