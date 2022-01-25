Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0549BAC5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386574AbiAYR5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 12:57:15 -0500
Received: from mta-202b.oxsus-vadesecure.net ([51.81.232.241]:46589 "EHLO
        nmtao202.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358920AbiAYRzR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 12:55:17 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 12:55:17 EST
DKIM-Signature: v=1; a=rsa-sha256; bh=XmcQlS+siyP820cZfOMhgmtMsRjsZpUk8XA7dT
 rDdY8=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1643133007;
 x=1643737807; b=IGb+5SEdHqRIltx57ZnyIvWgYZjt/tLydO5iE0P7Q+R7i/aAxafpGIK
 0btFYm+KFbRrsMyiWU5td8MP7QP+rIaYG6LvoP7/Doi4t7LWHTuZX95mWdDa796C1vXrePG
 7dGMge7raHCa0aK9pLvxnkERrby2VyIOV11BEfOBOo3eIK0wsAkfT3CxcCYEHDwOe2WYn98
 FLF9Tp6/DdamO30J/fMXL32RHylW1JwXWl8MXEauxhX34MK1OUgllqqfzy+AUcpJxFfy+Ti
 5MHuckSm5GadDICWjhr55wXZg8o6eXec52t3NmIWEKv6Bos8DBqOYaKiGpzhu1W7ey6lSru
 YMA==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 9b31d9ef-16cd94c398743a29; Tue, 25 Jan 2022 17:50:06 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Chuck Lever III'" <chuck.lever@oracle.com>,
        "'Bruce Fields'" <bfields@fieldses.org>
Cc:     "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <164312364841.2592.937810018356237855.stgit@bazille.1015granger.net> <20220125164620.GB15537@fieldses.org> <25C6BF9C-9C4A-4469-A2E1-D0CB2DF27E9F@oracle.com>
In-Reply-To: <25C6BF9C-9C4A-4469-A2E1-D0CB2DF27E9F@oracle.com>
Subject: RE: [PATCH RFC] NFSD: COMMIT operations must not return NFS?ERR_INVAL
Date:   Tue, 25 Jan 2022 09:50:06 -0800
Message-ID: <0b7301d81213$fdb75a00$f9260e00$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQKCEBwWHvphjR02yj3g9BK8c6jF3ALCxhxsAXVRCEKq/kYJgA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It's probably worth having a pynfs test case for this to keep all us server
implementers honest.

Ganesha doesn't check commit range, but the underlying file systems might
check and return EINVAL which we currently would just pass up. I guess I
should check and fix the range also...

Frank

> -----Original Message-----
> From: Chuck Lever III [mailto:chuck.lever@oracle.com]
> Sent: Tuesday, January 25, 2022 9:02 AM
> To: Bruce Fields <bfields@fieldses.org>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Subject: Re: [PATCH RFC] NFSD: COMMIT operations must not return
> NFS?ERR_INVAL
> 
> 
> 
> > On Jan 25, 2022, at 11:46 AM, J. Bruce Fields <bfields@fieldses.org>
wrote:
> >
> > On Tue, Jan 25, 2022 at 10:15:18AM -0500, Chuck Lever wrote:
> >> Since, well, forever, the Linux NFS server's nfsd_commit() function
> >> has returned nfserr_inval when the passed-in byte range arguments
> >> were non-sensical.
> >>
> >> However, according to RFC 1813 section 3.3.21, NFSv3 COMMIT requests
> >> are permitted to return only the following non-zero status codes:
> >>
> >>      NFS3ERR_IO
> >>      NFS3ERR_STALE
> >>      NFS3ERR_BADHANDLE
> >>      NFS3ERR_SERVERFAULT
> >>
> >> NFS3ERR_INVAL is not included in that list. Likewise, NFS4ERR_INVAL
> >> is not listed in the COMMIT row of Table 6 in RFC 8881.
> >>
> >> Instead of dropping or failing a COMMIT request in a byte range that
> >> is not supported, turn it into a valid request by treating one or
> >> both arguments as zero.
> >
> > Offset 0 means start-of-file, count 0 means until-end-of-file, so at
> > worst you're extending the range, and committing data you don't need to.
> > Since committing is something the server's free to do at any time,
> > that's harmless.  OK!
> 
> Right, committing more than requested is allowed.
> 
> 
> > (Are the checks really necessary?  I can't tell what vfs_fsync_range()
> > does with weird values.)
> 
> In general we want to ensure the math doesn't overflow.
> But I can have a closer look at vfs_fsync_range().
> 
> 
> > --b.
> >
> >>
> >> As a clean-up, I replaced the signed v. unsigned integer comparisons
> >> because I found that logic difficult to reason about.
> >>
> >> Reported-by: Dan Aloni <dan.aloni@vastdata.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> fs/nfsd/nfs3proc.c |    6 ------
> >> fs/nfsd/vfs.c      |   43 ++++++++++++++++++++++++++++---------------
> >> fs/nfsd/vfs.h      |    4 ++--
> >> 3 files changed, 30 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c index
> >> 8ef53f6726ec..8cd2953f53c7 100644
> >> --- a/fs/nfsd/nfs3proc.c
> >> +++ b/fs/nfsd/nfs3proc.c
> >> @@ -651,15 +651,9 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
> >> 				argp->count,
> >> 				(unsigned long long) argp->offset);
> >>
> >> -	if (argp->offset > NFS_OFFSET_MAX) {
> >> -		resp->status = nfserr_inval;
> >> -		goto out;
> >> -	}
> >> -
> >> 	fh_copy(&resp->fh, &argp->fh);
> >> 	resp->status = nfsd_commit(rqstp, &resp->fh, argp->offset,
> >> 				   argp->count, resp->verf);
> >> -out:
> >> 	return rpc_success;
> >> }
> >>
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c index
> >> 99c2b9dfbb10..384c62591f45 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1110,42 +1110,55 @@ nfsd_write(struct svc_rqst *rqstp, struct
> >> svc_fh *fhp, loff_t offset, }
> >>
> >> #ifdef CONFIG_NFSD_V3
> >> -/*
> >> - * Commit all pending writes to stable storage.
> >> +/**
> >> + * nfsd_commit - Commit pending writes to stable storage
> >> + * @rqstp: RPC request being processed
> >> + * @fhp: NFS filehandle
> >> + * @offset: offset from beginning of file
> >> + * @count: count of bytes to sync
> >> + * @verf: filled in with the server's current write verifier
> >>  *
> >>  * Note: we only guarantee that data that lies within the range
> >> specified
> >>  * by the 'offset' and 'count' parameters will be synced.
> >>  *
> >>  * Unfortunately we cannot lock the file to make sure we return full
> >> WCC
> >>  * data to the client, as locking happens lower down in the filesystem.
> >> + *
> >> + * Return values:
> >> + *   An nfsstat value in network byte order.
> >>  */
> >> __be32
> >> -nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >> -               loff_t offset, unsigned long count, __be32 *verf)
> >> +nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
> >> +	    u32 count, __be32 *verf)
> >> {
> >> +	u64			maxbytes;
> >> +	loff_t			start, end;
> >> 	struct nfsd_net		*nn;
> >> 	struct nfsd_file	*nf;
> >> -	loff_t			end = LLONG_MAX;
> >> -	__be32			err = nfserr_inval;
> >> -
> >> -	if (offset < 0)
> >> -		goto out;
> >> -	if (count != 0) {
> >> -		end = offset + (loff_t)count - 1;
> >> -		if (end < offset)
> >> -			goto out;
> >> -	}
> >> +	__be32			err;
> >>
> >> 	err = nfsd_file_acquire(rqstp, fhp,
> >> 			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE,
> &nf);
> >> 	if (err)
> >> 		goto out;
> >> +
> >> +	start = 0;
> >> +	end = LLONG_MAX;
> >> +	/* NB: s_maxbytes is a (signed) loff_t, thus @maxbytes always
> >> +	 * contains a value that is less than LLONG_MAX. */
> >> +	maxbytes = fhp->fh_dentry->d_sb->s_maxbytes;
> >> +	if (offset < maxbytes) {
> >> +		start = offset;
> >> +		if (count && (offset + count - 1 < maxbytes))
> >> +			end = offset + count - 1;
> >> +	}
> >> +
> >> 	nn = net_generic(nf->nf_net, nfsd_net_id);
> >> 	if (EX_ISSYNC(fhp->fh_export)) {
> >> 		errseq_t since = READ_ONCE(nf->nf_file->f_wb_err);
> >> 		int err2;
> >>
> >> -		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
> >> +		err2 = vfs_fsync_range(nf->nf_file, start, end, 0);
> >> 		switch (err2) {
> >> 		case 0:
> >> 			nfsd_copy_write_verifier(verf, nn); diff --git
> a/fs/nfsd/vfs.h
> >> b/fs/nfsd/vfs.h index 9f56dcb22ff7..2c43d10e3cab 100644
> >> --- a/fs/nfsd/vfs.h
> >> +++ b/fs/nfsd/vfs.h
> >> @@ -74,8 +74,8 @@ __be32		do_nfsd_create(struct svc_rqst *,
> struct svc_fh *,
> >> 				char *name, int len, struct iattr *attrs,
> >> 				struct svc_fh *res, int createmode,
> >> 				u32 *verifier, bool *truncp, bool *created);
> >> -__be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
> >> -				loff_t, unsigned long, __be32 *verf);
> >> +__be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh
*fhp,
> >> +				u64 offset, u32 count, __be32 *verf);
> >> #endif /* CONFIG_NFSD_V3 */
> >> #ifdef CONFIG_NFSD_V4
> >> __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh
*fhp,
> 
> --
> Chuck Lever
> 


