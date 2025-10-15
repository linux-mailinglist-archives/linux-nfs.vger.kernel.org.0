Return-Path: <linux-nfs+bounces-15273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C365BDFF81
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 20:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4735D35019A
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAA1FECB0;
	Wed, 15 Oct 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwhoWzrZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EF3009EC
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551214; cv=none; b=pLz0pg2AtZWUm4DNs2pNwyb/VnRtZ9ZKss5ZZ+RbeFSLpkAW8BuP+0maTA7C+3DIMhOgoSD0srlM0965+Ni/eLdE99fWt9pme7KuScDm2an+B0ybKR/RQT1sO0o5HFL35vuNh774NVmFlacVKcixsTCHfcmOxGaaKAsVsX6SToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551214; c=relaxed/simple;
	bh=HAPTbu7sg8cyX9xXfYU12Kdico87DO3XrUEIuhQYHvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCt0Ma1MTykKNgAM7rGv7CVkUq6zPImxtkF/PjjIS1CKnO3hFlbEiulsjdId0fgoTL60AtI2mECi9Rlfgg1S8jsh6zEeI0h/OupG7VHCiG5iZbE58E5w5uryGCE3IR+/ZMmWirt32dFFNejHkbcdu6LzlK4G/SsydT7pqp0cLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwhoWzrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196A4C4CEF8;
	Wed, 15 Oct 2025 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760551213;
	bh=HAPTbu7sg8cyX9xXfYU12Kdico87DO3XrUEIuhQYHvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FwhoWzrZLL/MsI45uarNjtpk9oUdnW1QFBAL+kAB9yLQQzg/YMGgK7DI/xdxqPiKx
	 999iFYXIQtepSi4bXZKB0wOoWFZLyOeVCa0/54L15XqLRrKjzjn/fvYsLnkqHdwYOO
	 UrT8zS9pk/yp9dD8nascdC94Mn24WIpCgkQQh0M9JdFVBjop1uvBqkuixpv4l6Krqp
	 h26/nYp2Jf7i855BSPNrOd1rO4QkvSYQ171Mk4EoqpyyaMd7cRBIL8fc1Wd4dwitJD
	 wDyVHFrL2V6kYoUfICk0/P5+lXkIXXsZh+ALqQIOuBdpoDnBsh+DVsvIMWf21NBF3H
	 PFhxQW5g3nF2w==
Message-ID: <c95b46b6-5db4-4588-ac79-4f6d38df0ae2@kernel.org>
Date: Wed, 15 Oct 2025 14:00:12 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251013190113.252097-1-cel@kernel.org>
 <aO_RmCNR8rg9EtlP@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aO_RmCNR8rg9EtlP@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 12:53 PM, Mike Snitzer wrote:
> On Mon, Oct 13, 2025 at 03:01:13PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
>> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
>> not need a subsequent COMMIT operation, saving a round trip and
>> allowing the client to dispense with cached dirty data as soon as
>> it receives the server's WRITE response.
>>
>> This patch refactors nfsd_vfs_write() to return a possibly modified
>> stable_how value to its callers. No behavior change is expected.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs3proc.c |  2 +-
>>  fs/nfsd/nfs4proc.c |  2 +-
>>  fs/nfsd/nfsproc.c  |  3 ++-
>>  fs/nfsd/vfs.c      | 11 ++++++-----
>>  fs/nfsd/vfs.h      |  6 ++++--
>>  fs/nfsd/xdr3.h     |  2 +-
>>  6 files changed, 15 insertions(+), 11 deletions(-)
>>
>> Here's what I had in mind, based on a patch I did a year ago but
>> never posted.
>>
>> If nfsd_vfs_write() promotes an NFS_UNSTABLE write to NFS_FILE_SYNC,
>> it can now set *stable_how and the WRITE encoders will return the
>> updated value to the client.
>>
>>
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index b6d03e1ef5f7..ad14b34583bb 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -236,7 +236,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>>  	resp->committed = argp->stable;
>>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
>>  				  &argp->payload, &cnt,
>> -				  resp->committed, resp->verf);
>> +				  &resp->committed, resp->verf);
>>  	resp->count = cnt;
>>  	resp->status = nfsd3_map_status(resp->status);
>>  	return rpc_success;
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 7f7e6bb23a90..2222bb283baf 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1285,7 +1285,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  	write->wr_how_written = write->wr_stable_how;
>>  	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
>>  				write->wr_offset, &write->wr_payload,
>> -				&cnt, write->wr_how_written,
>> +				&cnt, &write->wr_how_written,
>>  				(__be32 *)write->wr_verifier.data);
>>  	nfsd_file_put(nf);
>>  
>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>> index 8f71f5748c75..706401ed6f8d 100644
>> --- a/fs/nfsd/nfsproc.c
>> +++ b/fs/nfsd/nfsproc.c
>> @@ -251,6 +251,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>>  	struct nfsd_writeargs *argp = rqstp->rq_argp;
>>  	struct nfsd_attrstat *resp = rqstp->rq_resp;
>>  	unsigned long cnt = argp->len;
>> +	u32 committed = NFS_DATA_SYNC;
>>  
>>  	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
>>  		SVCFH_fmt(&argp->fh),
>> @@ -258,7 +259,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>>  
>>  	fh_copy(&resp->fh, &argp->fh);
>>  	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
>> -				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
>> +				  &argp->payload, &cnt, &committed, NULL);
>>  	if (resp->status == nfs_ok)
>>  		resp->status = fh_getattr(&resp->fh, &resp->stat);
>>  	else if (resp->status == nfserr_jukebox)
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index f537a7b4ee01..8b2dc7a88aab 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1262,7 +1262,7 @@ static int wait_for_concurrent_writes(struct file *file)
>>   * @offset: Byte offset of start
>>   * @payload: xdr_buf containing the write payload
>>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
>> - * @stable: An NFS stable_how value
>> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
>>   * @verf: NFS WRITE verifier
>>   *
>>   * Upon return, caller must invoke fh_put on @fhp.
>> @@ -1274,11 +1274,12 @@ __be32
>>  nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  	       struct nfsd_file *nf, loff_t offset,
>>  	       const struct xdr_buf *payload, unsigned long *cnt,
>> -	       int stable, __be32 *verf)
>> +	       u32 *stable_how, __be32 *verf)
>>  {
>>  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>  	struct file		*file = nf->nf_file;
>>  	struct super_block	*sb = file_inode(file)->i_sb;
>> +	u32			stable = *stable_how;
>>  	struct kiocb		kiocb;
>>  	struct svc_export	*exp;
>>  	struct iov_iter		iter;
> 
> Seems we need this instead here?
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5e5e5187d2e5..d0c89f8fdb57 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1479,7 +1479,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct file		*file = nf->nf_file;
>  	struct super_block	*sb = file_inode(file)->i_sb;
> -	u32			stable = *stable_how;
> +	u32			stable;
>  	struct kiocb		kiocb;
>  	struct svc_export	*exp;
>  	errseq_t		since;
> @@ -1511,7 +1511,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	exp = fhp->fh_export;
>  
>  	if (!EX_ISSYNC(exp))
> -		stable = NFS_UNSTABLE;
> +		*stable_how = NFS_UNSTABLE;
> +	stable = *stable_how;
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = offset;
>  	if (stable && !fhp->fh_use_wgather)
> 
> Otherwise, isn't there potential for nfsd_vfs_write's NFS_UNSTABLE
> override to cause a client set stable_how, that was set to something
> other than NFS_UNSTABLE, to silently _not_ be respected by NFSD? But
> client could assume COMMIT not needed? And does this then elevate this
> patch to be a stable@ fix? (no pun intended).
> 
> If not, please help me understand why.

The protocol permits an NFS server to change the stable_how field in a
WRITE response as follows:

UNSTABLE  -> DATA_SYNC
UNSTABLE  -> FILE_SYNC
DATA_SYNC -> FILE_SYNC

It forbids the reverse direction. A client that asks for a FILE_SYNC
WRITE MUST get a FILE_SYNC reply.

What the EX_ISSYNC test is doing is looking for the "async" export
option. When that option is specified, internally NFSD converts all
WRITEs, including FILE_SYNC WRITEs, to UNSTABLE. It then complies with
the protocol by not telling the client about this invalid change and
defies the protocol by not ensuring FILE_SYNC WRITEs are persisted
before replying. See exports(5).

In these cases, each WRITE response still reflects what the client
requested, but it does not reflect what the server actually did.

We tell anyone who will listen (and even those who won't) never to use
the "async" export option because of the silent data corruption risk it
introduces. But it goes faster than using the fully protocol-compliant
"sync" export option, so people use it anyway.


> Thanks!
> 
>> @@ -1434,7 +1435,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>   * @offset: Byte offset of start
>>   * @payload: xdr_buf containing the write payload
>>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
>> - * @stable: An NFS stable_how value
>> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
>>   * @verf: NFS WRITE verifier
>>   *
>>   * Upon return, caller must invoke fh_put on @fhp.
>> @@ -1444,7 +1445,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>   */
>>  __be32
>>  nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>> -	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
>> +	   const struct xdr_buf *payload, unsigned long *cnt, u32 *stable_how,
>>  	   __be32 *verf)
>>  {
>>  	struct nfsd_file *nf;
>> @@ -1457,7 +1458,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
>>  		goto out;
>>  
>>  	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
>> -			     stable, verf);
>> +			     stable_how, verf);
>>  	nfsd_file_put(nf);
>>  out:
>>  	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
>> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
>> index fa46f8b5f132..c713ed0b04e0 100644
>> --- a/fs/nfsd/vfs.h
>> +++ b/fs/nfsd/vfs.h
>> @@ -130,11 +130,13 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  				u32 *eof);
>>  __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  				loff_t offset, const struct xdr_buf *payload,
>> -				unsigned long *cnt, int stable, __be32 *verf);
>> +				unsigned long *cnt, u32 *stable_how,
>> +				__be32 *verf);
>>  __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  				struct nfsd_file *nf, loff_t offset,
>>  				const struct xdr_buf *payload,
>> -				unsigned long *cnt, int stable, __be32 *verf);
>> +				unsigned long *cnt, u32 *stable_how,
>> +				__be32 *verf);
>>  __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
>>  				char *, int *);
>>  __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
>> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
>> index 522067b7fd75..c0e443ef3a6b 100644
>> --- a/fs/nfsd/xdr3.h
>> +++ b/fs/nfsd/xdr3.h
>> @@ -152,7 +152,7 @@ struct nfsd3_writeres {
>>  	__be32			status;
>>  	struct svc_fh		fh;
>>  	unsigned long		count;
>> -	int			committed;
>> +	u32			committed;
>>  	__be32			verf[2];
>>  };
>>  
>> -- 
>> 2.51.0
>>


-- 
Chuck Lever

