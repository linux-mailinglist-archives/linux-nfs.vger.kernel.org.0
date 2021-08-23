Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639B93F4E02
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhHWQJC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 12:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhHWQJB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 12:09:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D764FC061575
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 09:08:18 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6B9D764B9; Mon, 23 Aug 2021 12:08:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6B9D764B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629734898;
        bh=KgQyJSpkGSSC5IoYSM3v7Lh09UqGxQhSUF9+eSMw/EE=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=EbhXUal+3fDucm35N09l9x8v5nxW3C8oWujofmvY9abEssCJtmfffcBBA9B22nBoW
         UxJK6NoxOm7wtwR6DF5igCpIF7i3nIvwGfcmzIym1Tro5m/EbmGgSPg7p7m8X0Qwpj
         YCK9rwPjYUgRK+R4HBNXh1BBmJf6B4HbO245UZCE=
Date:   Mon, 23 Aug 2021 12:08:18 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Message-ID: <20210823160818.GE883@fieldses.org>
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
> Nit: short description should start with "nlm:"
> 
> 
> > On Aug 20, 2021, at 5:02 PM, J. Bruce Fields <bfields@redhat.com> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > We shouldn't really be using a read-only file descriptor to take a write
> > lock.
> > 
> > Most filesystems will put up with it.  But NFS, for example, won't.
> 
> Two overall concerns:
> 
> 1. Would it be easy/possible to split this patch further?

I'm not sure.

> 2. What kind of testing would provide a level of confidence
>    that no regressions have been introduced by this change?

I've just run my usual tests; the only ones relevant to this are
"cthon -a" over v3 (with and without krb5), and a few tests of my own I
wrote for some long-ago regressions
(http://git.linux-nfs.org/?p=bfields/lock-tests.git;a=summary).

(And I also did the same over v3 re-export of a 4.2 mount, but that's
more to check for the fix than for regressions.)

--b.

> 
> 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/lockd/svc4proc.c         |   4 +-
> > fs/lockd/svclock.c          |  25 ++++++---
> > fs/lockd/svcproc.c          |   4 +-
> > fs/lockd/svcsubs.c          | 104 +++++++++++++++++++++++++-----------
> > fs/nfsd/lockd.c             |   8 ++-
> > include/linux/lockd/bind.h  |   3 +-
> > include/linux/lockd/lockd.h |   9 +++-
> > 7 files changed, 114 insertions(+), 43 deletions(-)
> > 
> > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > index aa8eca7c38a1..c7587de948e4 100644
> > --- a/fs/lockd/svc4proc.c
> > +++ b/fs/lockd/svc4proc.c
> > @@ -40,12 +40,14 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
> > 
> > 	/* Obtain file pointer. Not used by FREE_ALL call. */
> > 	if (filp != NULL) {
> > +		int mode = lock_to_openmode(&lock->fl);
> > +
> > 		if ((error = nlm_lookup_file(rqstp, &file, lock)) != 0)
> > 			goto no_locks;
> > 		*filp = file;
> > 
> > 		/* Set up the missing parts of the file_lock structure */
> > -		lock->fl.fl_file  = file->f_file;
> > +		lock->fl.fl_file  = file->f_file[mode];
> > 		lock->fl.fl_pid = current->tgid;
> > 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
> > 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index bc1cf31f3cce..d60e6eea2d57 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -471,6 +471,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
> > {
> > 	struct nlm_block	*block = NULL;
> > 	int			error;
> > +	int			mode;
> > 	__be32			ret;
> > 
> > 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
> > @@ -524,7 +525,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
> > 
> > 	if (!wait)
> > 		lock->fl.fl_flags &= ~FL_SLEEP;
> > -	error = vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> > +	mode = lock_to_openmode(&lock->fl);
> > +	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> > 	lock->fl.fl_flags &= ~FL_SLEEP;
> > 
> > 	dprintk("lockd: vfs_lock_file returned %d\n", error);
> > @@ -577,6 +579,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
> > 		struct nlm_lock *conflock, struct nlm_cookie *cookie)
> > {
> > 	int			error;
> > +	int			mode;
> > 	__be32			ret;
> > 	struct nlm_lockowner	*test_owner;
> > 
> > @@ -595,7 +598,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
> > 	/* If there's a conflicting lock, remember to clean up the test lock */
> > 	test_owner = (struct nlm_lockowner *)lock->fl.fl_owner;
> > 
> > -	error = vfs_test_lock(file->f_file, &lock->fl);
> > +	mode = lock_to_openmode(&lock->fl);
> > +	error = vfs_test_lock(file->f_file[mode], &lock->fl);
> > 	if (error) {
> > 		/* We can't currently deal with deferred test requests */
> > 		if (error == FILE_LOCK_DEFERRED)
> > @@ -641,7 +645,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
> > __be32
> > nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
> > {
> > -	int	error;
> > +	int	error = 0;
> > 
> > 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
> > 				nlmsvc_file_inode(file)->i_sb->s_id,
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
> 
> 
> > 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
> > }
> > @@ -671,6 +680,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
> > {
> > 	struct nlm_block	*block;
> > 	int status = 0;
> > +	int mode;
> > 
> > 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
> > 				nlmsvc_file_inode(file)->i_sb->s_id,
> > @@ -686,7 +696,8 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
> > 	block = nlmsvc_lookup_block(file, lock);
> > 	mutex_unlock(&file->f_mutex);
> > 	if (block != NULL) {
> > -		vfs_cancel_lock(block->b_file->f_file,
> > +		mode = lock_to_openmode(&lock->fl);
> > +		vfs_cancel_lock(block->b_file->f_file[mode],
> > 				&block->b_call->a_args.lock.fl);
> > 		status = nlmsvc_unlink_block(block);
> > 		nlmsvc_release_block(block);
> > @@ -803,6 +814,7 @@ nlmsvc_grant_blocked(struct nlm_block *block)
> > {
> > 	struct nlm_file		*file = block->b_file;
> > 	struct nlm_lock		*lock = &block->b_call->a_args.lock;
> > +	int			mode;
> > 	int			error;
> > 	loff_t			fl_start, fl_end;
> > 
> > @@ -828,7 +840,8 @@ nlmsvc_grant_blocked(struct nlm_block *block)
> > 	lock->fl.fl_flags |= FL_SLEEP;
> > 	fl_start = lock->fl.fl_start;
> > 	fl_end = lock->fl.fl_end;
> > -	error = vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
> > +	mode = lock_to_openmode(&lock->fl);
> > +	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> > 	lock->fl.fl_flags &= ~FL_SLEEP;
> > 	lock->fl.fl_start = fl_start;
> > 	lock->fl.fl_end = fl_end;
> > diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> > index f4e5e0eb30fd..99696d3f6dd6 100644
> > --- a/fs/lockd/svcproc.c
> > +++ b/fs/lockd/svcproc.c
> > @@ -55,6 +55,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
> > 	struct nlm_host		*host = NULL;
> > 	struct nlm_file		*file = NULL;
> > 	struct nlm_lock		*lock = &argp->lock;
> > +	int			mode;
> > 	__be32			error = 0;
> > 
> > 	/* nfsd callbacks must have been installed for this procedure */
> > @@ -75,7 +76,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
> > 		*filp = file;
> > 
> > 		/* Set up the missing parts of the file_lock structure */
> > -		lock->fl.fl_file  = file->f_file;
> > +		mode = lock_to_openmode(&lock->fl);
> > +		lock->fl.fl_file  = file->f_file[mode];
> > 		lock->fl.fl_pid = current->tgid;
> > 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
> > 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
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
> 
> 
> > +}
> > +
> > +/*
> > + * Open the file. Note that if we're reexporting, for example,
> > + * this could block the lockd thread for a while.
> > + *
> > + * We have to make sure we have the right credential to open
> > + * the file.
> > + */
> > +static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
> > +			   struct nlm_file *file, int mode)
> > +{
> > +	struct file **fp = &file->f_file[mode];
> > +	__be32	nfserr;
> > +
> > +	if (*fp)
> > +		return 0;
> > +	nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
> > +	if (nfserr)
> > +		dprintk("lockd: open failed (error %d)\n", nfserr);
> > +	return nfserr;
> > +}
> > +
> > /*
> >  * Lookup file info. If it doesn't exist, create a file info struct
> >  * and open a (VFS) file for the given inode.
> > - *
> > - * FIXME:
> > - * Note that we open the file O_RDONLY even when creating write locks.
> > - * This is not quite right, but for now, we assume the client performs
> > - * the proper R/W checking.
> >  */
> > __be32
> > nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> > @@ -87,41 +111,38 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> > 	struct nlm_file	*file;
> > 	unsigned int	hash;
> > 	__be32		nfserr;
> > +	int		mode;
> > 
> > 	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
> > 
> > 	hash = file_hash(&lock->fh);
> > +	mode = lock_to_openmode(&lock->fl);
> > 
> > 	/* Lock file table */
> > 	mutex_lock(&nlm_file_mutex);
> > 
> > 	hlist_for_each_entry(file, &nlm_files[hash], f_list)
> > -		if (!nfs_compare_fh(&file->f_handle, &lock->fh))
> > +		if (!nfs_compare_fh(&file->f_handle, &lock->fh)) {
> > +			mutex_lock(&file->f_mutex);
> > +			nfserr = nlm_do_fopen(rqstp, file, mode);
> > +			mutex_unlock(&file->f_mutex);
> > 			goto found;
> > -
> > +		}
> > 	nlm_debug_print_fh("creating file for", &lock->fh);
> > 
> > 	nfserr = nlm_lck_denied_nolocks;
> > 	file = kzalloc(sizeof(*file), GFP_KERNEL);
> > 	if (!file)
> > -		goto out_unlock;
> > +		goto out_free;
> > 
> > 	memcpy(&file->f_handle, &lock->fh, sizeof(struct nfs_fh));
> > 	mutex_init(&file->f_mutex);
> > 	INIT_HLIST_NODE(&file->f_list);
> > 	INIT_LIST_HEAD(&file->f_blocks);
> > 
> > -	/*
> > -	 * Open the file. Note that if we're reexporting, for example,
> > -	 * this could block the lockd thread for a while.
> > -	 *
> > -	 * We have to make sure we have the right credential to open
> > -	 * the file.
> > -	 */
> > -	if ((nfserr = nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file)) != 0) {
> > -		dprintk("lockd: open failed (error %d)\n", nfserr);
> > -		goto out_free;
> > -	}
> > +	nfserr = nlm_do_fopen(rqstp, file, mode);
> > +	if (nfserr)
> > +		goto out_unlock;
> > 
> > 	hlist_add_head(&file->f_list, &nlm_files[hash]);
> > 
> > @@ -129,7 +150,6 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
> > 	dprintk("lockd: found file %p (count %d)\n", file, file->f_count);
> > 	*result = file;
> > 	file->f_count++;
> > -	nfserr = 0;
> > 
> > out_unlock:
> > 	mutex_unlock(&nlm_file_mutex);
> > @@ -149,13 +169,34 @@ nlm_delete_file(struct nlm_file *file)
> > 	nlm_debug_print_file("closing file", file);
> > 	if (!hlist_unhashed(&file->f_list)) {
> > 		hlist_del(&file->f_list);
> > -		nlmsvc_ops->fclose(file->f_file);
> > +		if (file->f_file[O_RDONLY])
> > +			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
> > +		if (file->f_file[O_WRONLY])
> > +			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
> > 		kfree(file);
> > 	} else {
> > 		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
> > 	}
> > }
> > 
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
> 
> 
> > +			return 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > /*
> >  * Loop over all locks on the given file and perform the specified
> >  * action.
> > @@ -183,17 +224,10 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
> > 
> > 		lockhost = ((struct nlm_lockowner *)fl->fl_owner)->host;
> > 		if (match(lockhost, host)) {
> > -			struct file_lock lock = *fl;
> > 
> > 			spin_unlock(&flctx->flc_lock);
> > -			lock.fl_type  = F_UNLCK;
> > -			lock.fl_start = 0;
> > -			lock.fl_end   = OFFSET_MAX;
> > -			if (vfs_lock_file(file->f_file, F_SETLK, &lock, NULL) < 0) {
> > -				printk("lockd: unlock failure in %s:%d\n",
> > -						__FILE__, __LINE__);
> > +			if (nlm_unlock_files(file))
> > 				return 1;
> > -			}
> > 			goto again;
> > 		}
> > 	}
> > @@ -247,6 +281,15 @@ nlm_file_inuse(struct nlm_file *file)
> > 	return 0;
> > }
> > 
> > +static void nlm_close_files(struct nlm_file *file)
> > +{
> > +	struct file *f;
> > +
> > +	for (f = file->f_file[0]; f <= file->f_file[1]; f++)
> > +		if (f)
> > +			nlmsvc_ops->fclose(f);
> > +}
> > +
> > /*
> >  * Loop over all files in the file table.
> >  */
> > @@ -277,7 +320,7 @@ nlm_traverse_files(void *data, nlm_host_match_fn_t match,
> > 			if (list_empty(&file->f_blocks) && !file->f_locks
> > 			 && !file->f_shares && !file->f_count) {
> > 				hlist_del(&file->f_list);
> > -				nlmsvc_ops->fclose(file->f_file);
> > +				nlm_close_files(file);
> > 				kfree(file);
> > 			}
> > 		}
> > @@ -411,6 +454,7 @@ nlmsvc_invalidate_all(void)
> > 	nlm_traverse_files(NULL, nlmsvc_is_client, NULL);
> > }
> > 
> > +
> > static int
> > nlmsvc_match_sb(void *datap, struct nlm_file *file)
> > {
> > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > index 3f5b3d7b62b7..606fa155c28a 100644
> > --- a/fs/nfsd/lockd.c
> > +++ b/fs/nfsd/lockd.c
> > @@ -25,9 +25,11 @@
> >  * Note: we hold the dentry use count while the file is open.
> >  */
> > static __be32
> > -nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
> > +nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
> > +		int mode)
> > {
> > 	__be32		nfserr;
> > +	int		access;
> > 	struct svc_fh	fh;
> > 
> > 	/* must initialize before using! but maxsize doesn't matter */
> > @@ -36,7 +38,9 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
> > 	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
> > 	fh.fh_export = NULL;
> > 
> > -	nfserr = nfsd_open(rqstp, &fh, S_IFREG, NFSD_MAY_LOCK, filp);
> > +	access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
> > +	access |= NFSD_MAY_LOCK;
> > +	nfserr = nfsd_open(rqstp, &fh, S_IFREG, access, filp);
> > 	fh_put(&fh);
> >  	/* We return nlm error codes as nlm doesn't know
> > 	 * about nfsd, but nfsd does know about nlm..
> > diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
> > index 0520c0cd73f4..3bc9f7410e21 100644
> > --- a/include/linux/lockd/bind.h
> > +++ b/include/linux/lockd/bind.h
> > @@ -27,7 +27,8 @@ struct rpc_task;
> > struct nlmsvc_binding {
> > 	__be32			(*fopen)(struct svc_rqst *,
> > 						struct nfs_fh *,
> > -						struct file **);
> > +						struct file **,
> > +						int mode);
> 
> Style: "mode_t mode" might be better internal documentation.
> 
> 
> > 	void			(*fclose)(struct file *);
> > };
> > 
> > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> > index 81b71ad2040a..da319de7e557 100644
> > --- a/include/linux/lockd/lockd.h
> > +++ b/include/linux/lockd/lockd.h
> > @@ -10,6 +10,8 @@
> > #ifndef LINUX_LOCKD_LOCKD_H
> > #define LINUX_LOCKD_LOCKD_H
> > 
> > +/* XXX: a lot of this should really be under fs/lockd. */
> > +
> > #include <linux/in.h>
> > #include <linux/in6.h>
> > #include <net/ipv6.h>
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
> 
> 
> > 	struct nlm_share *	f_shares;	/* DOS shares */
> > 	struct list_head	f_blocks;	/* blocked locks */
> > 	unsigned int		f_locks;	/* guesstimate # of locks */
> > @@ -267,6 +270,7 @@ typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
> > /*
> >  * Server-side lock handling
> >  */
> > +int		  lock_to_openmode(struct file_lock *);
> > __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
> > 			      struct nlm_host *, struct nlm_lock *, int,
> > 			      struct nlm_cookie *, int);
> > @@ -301,7 +305,8 @@ int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
> > 
> > static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
> > {
> > -	return locks_inode(file->f_file);
> > +	return locks_inode(file->f_file[0] ?
> > +				file->f_file[0] : file->f_file[1]);
> > }
> > 
> > static inline int __nlm_privileged_request4(const struct sockaddr *sap)
> > -- 
> > 2.31.1
> > 
> 
> --
> Chuck Lever
> 
> 
