Return-Path: <linux-nfs+bounces-15276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12870BE039C
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2D14834D8
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964524DD0E;
	Wed, 15 Oct 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oToJG55M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FD325494
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553657; cv=none; b=arjzZ5qo8VB3MlBXYiOfmTvGVy/W4evfTvdGa+kTq3XfW47xoO21PNj9TZvXhVECU9CE41y+T/7dIpQdVNkXpTCeq+lWdryqTXkhygR3ADXNi+BksrJikGMG2brFi370VOCFXF4OrhRJWffb3mAn5ZQzbgh/jsBkebPTJ3YRSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553657; c=relaxed/simple;
	bh=VWR7T5IKhDtjYpO7I8Km7aHidpO5u3Lcm4Ia9r50r8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNLJd2gxedsvX/zUERKC74znRu3iEPiMcoXUJoDYBiowqOe+GtmqhXQqNGK6bLTXboy05mJZoWuwGjSMrVzhvOkoK3shUhXywHTf5T6wBIdkJiIGky0MuHRuhNQ8bZCzZ2/6o+7/zGa/RgLbVfzrqmrGzdqMyUq7SRWzMma+2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oToJG55M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27126C4CEF8;
	Wed, 15 Oct 2025 18:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553656;
	bh=VWR7T5IKhDtjYpO7I8Km7aHidpO5u3Lcm4Ia9r50r8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oToJG55MRpBUcuVuXK6p0KeDqeY3Amx5VV5uXm2sHlXmA9DgdhuXTJy2LzM4dCXfE
	 8HZKtPcAfctKVw6/mdZORP07tXhtJb9ALUgllXtAyyURYdV5XJgRZHQ2DtppdSz2uA
	 XMVJQhzAgEEAI78qsp1MsYzWu8h5OUe62L1jBmqdSJVgnNMLp09xwDxGANSFf5ryFD
	 txoaJ6bPnBB04tgh5o2gOG8k854K0uNc8NNkH7ZdpPNnMbizJ1LhdxV5LGUgJkWUMc
	 hf97u35DARG33ODqzSCXITz7jLP9CICEGaQH7SCekac5oRcvtzmmxmjwma6XOr9xmD
	 bw6DLmnvyf/QQ==
Date: Wed, 15 Oct 2025 14:40:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
Message-ID: <aO_qt2ZQmcI-3irr@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>
 <aO_RmCNR8rg9EtlP@kernel.org>
 <c95b46b6-5db4-4588-ac79-4f6d38df0ae2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95b46b6-5db4-4588-ac79-4f6d38df0ae2@kernel.org>

On Wed, Oct 15, 2025 at 02:00:12PM -0400, Chuck Lever wrote:
> On 10/15/25 12:53 PM, Mike Snitzer wrote:
> > On Mon, Oct 13, 2025 at 03:01:13PM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> >> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
> >> not need a subsequent COMMIT operation, saving a round trip and
> >> allowing the client to dispense with cached dirty data as soon as
> >> it receives the server's WRITE response.
> >>
> >> This patch refactors nfsd_vfs_write() to return a possibly modified
> >> stable_how value to its callers. No behavior change is expected.
> >>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/nfs3proc.c |  2 +-
> >>  fs/nfsd/nfs4proc.c |  2 +-
> >>  fs/nfsd/nfsproc.c  |  3 ++-
> >>  fs/nfsd/vfs.c      | 11 ++++++-----
> >>  fs/nfsd/vfs.h      |  6 ++++--
> >>  fs/nfsd/xdr3.h     |  2 +-
> >>  6 files changed, 15 insertions(+), 11 deletions(-)
> >>
> >> Here's what I had in mind, based on a patch I did a year ago but
> >> never posted.
> >>
> >> If nfsd_vfs_write() promotes an NFS_UNSTABLE write to NFS_FILE_SYNC,
> >> it can now set *stable_how and the WRITE encoders will return the
> >> updated value to the client.
> >>
> >>
> >> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> >> index b6d03e1ef5f7..ad14b34583bb 100644
> >> --- a/fs/nfsd/nfs3proc.c
> >> +++ b/fs/nfsd/nfs3proc.c
> >> @@ -236,7 +236,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
> >>  	resp->committed = argp->stable;
> >>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
> >>  				  &argp->payload, &cnt,
> >> -				  resp->committed, resp->verf);
> >> +				  &resp->committed, resp->verf);
> >>  	resp->count = cnt;
> >>  	resp->status = nfsd3_map_status(resp->status);
> >>  	return rpc_success;
> >> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >> index 7f7e6bb23a90..2222bb283baf 100644
> >> --- a/fs/nfsd/nfs4proc.c
> >> +++ b/fs/nfsd/nfs4proc.c
> >> @@ -1285,7 +1285,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >>  	write->wr_how_written = write->wr_stable_how;
> >>  	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
> >>  				write->wr_offset, &write->wr_payload,
> >> -				&cnt, write->wr_how_written,
> >> +				&cnt, &write->wr_how_written,
> >>  				(__be32 *)write->wr_verifier.data);
> >>  	nfsd_file_put(nf);
> >>  
> >> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> >> index 8f71f5748c75..706401ed6f8d 100644
> >> --- a/fs/nfsd/nfsproc.c
> >> +++ b/fs/nfsd/nfsproc.c
> >> @@ -251,6 +251,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
> >>  	struct nfsd_writeargs *argp = rqstp->rq_argp;
> >>  	struct nfsd_attrstat *resp = rqstp->rq_resp;
> >>  	unsigned long cnt = argp->len;
> >> +	u32 committed = NFS_DATA_SYNC;
> >>  
> >>  	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
> >>  		SVCFH_fmt(&argp->fh),
> >> @@ -258,7 +259,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
> >>  
> >>  	fh_copy(&resp->fh, &argp->fh);
> >>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
> >> -				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
> >> +				  &argp->payload, &cnt, &committed, NULL);
> >>  	if (resp->status == nfs_ok)
> >>  		resp->status = fh_getattr(&resp->fh, &resp->stat);
> >>  	else if (resp->status == nfserr_jukebox)
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index f537a7b4ee01..8b2dc7a88aab 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1262,7 +1262,7 @@ static int wait_for_concurrent_writes(struct file *file)
> >>   * @offset: Byte offset of start
> >>   * @payload: xdr_buf containing the write payload
> >>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
> >> - * @stable: An NFS stable_how value
> >> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
> >>   * @verf: NFS WRITE verifier
> >>   *
> >>   * Upon return, caller must invoke fh_put on @fhp.
> >> @@ -1274,11 +1274,12 @@ __be32
> >>  nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >>  	       struct nfsd_file *nf, loff_t offset,
> >>  	       const struct xdr_buf *payload, unsigned long *cnt,
> >> -	       int stable, __be32 *verf)
> >> +	       u32 *stable_how, __be32 *verf)
> >>  {
> >>  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> >>  	struct file		*file = nf->nf_file;
> >>  	struct super_block	*sb = file_inode(file)->i_sb;
> >> +	u32			stable = *stable_how;
> >>  	struct kiocb		kiocb;
> >>  	struct svc_export	*exp;
> >>  	struct iov_iter		iter;
> > 
> > Seems we need this instead here?
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 5e5e5187d2e5..d0c89f8fdb57 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1479,7 +1479,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> >  	struct file		*file = nf->nf_file;
> >  	struct super_block	*sb = file_inode(file)->i_sb;
> > -	u32			stable = *stable_how;
> > +	u32			stable;
> >  	struct kiocb		kiocb;
> >  	struct svc_export	*exp;
> >  	errseq_t		since;
> > @@ -1511,7 +1511,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	exp = fhp->fh_export;
> >  
> >  	if (!EX_ISSYNC(exp))
> > -		stable = NFS_UNSTABLE;
> > +		*stable_how = NFS_UNSTABLE;
> > +	stable = *stable_how;
> >  	init_sync_kiocb(&kiocb, file);
> >  	kiocb.ki_pos = offset;
> >  	if (stable && !fhp->fh_use_wgather)
> > 
> > Otherwise, isn't there potential for nfsd_vfs_write's NFS_UNSTABLE
> > override to cause a client set stable_how, that was set to something
> > other than NFS_UNSTABLE, to silently _not_ be respected by NFSD? But
> > client could assume COMMIT not needed? And does this then elevate this
> > patch to be a stable@ fix? (no pun intended).
> > 
> > If not, please help me understand why.
> 
> The protocol permits an NFS server to change the stable_how field in a
> WRITE response as follows:
> 
> UNSTABLE  -> DATA_SYNC
> UNSTABLE  -> FILE_SYNC
> DATA_SYNC -> FILE_SYNC
> 
> It forbids the reverse direction. A client that asks for a FILE_SYNC
> WRITE MUST get a FILE_SYNC reply.
> 
> What the EX_ISSYNC test is doing is looking for the "async" export
> option. When that option is specified, internally NFSD converts all
> WRITEs, including FILE_SYNC WRITEs, to UNSTABLE. It then complies with
> the protocol by not telling the client about this invalid change and
> defies the protocol by not ensuring FILE_SYNC WRITEs are persisted
> before replying. See exports(5).
> 
> In these cases, each WRITE response still reflects what the client
> requested, but it does not reflect what the server actually did.
> 
> We tell anyone who will listen (and even those who won't) never to use
> the "async" export option because of the silent data corruption risk it
> introduces. But it goes faster than using the fully protocol-compliant
> "sync" export option, so people use it anyway.

Thanks for all of that, very helpful!

FYI, I'm now actively working on updating the NFSD Direct WRITE
support to rebase on your stable_how patch.

Mike

