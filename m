Return-Path: <linux-nfs+bounces-14958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73219BB7165
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308233A5905
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC31C1ADB;
	Fri,  3 Oct 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1B4Oxpw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B4134BD
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499853; cv=none; b=bDVUFLQ50EE3ZbRxR+ZyWCEbgxZHnH5xmtPkBPPQOMCkafk1YZZxZWCQJrbpRmEOnrrLuQ3HtUviADN4z2TFPg6g96MdQRx5vcWqOJWXHx/X/a4S26cjpzC49FvxW1r1ty4ZClOpPxVd6C2Dbg7az2KukMpxI0tIspCVg5Y9nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499853; c=relaxed/simple;
	bh=p8IR9RaiFT+mnhzvMmJX2PNaRlUaTCuHwWwXEIp3wBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNrLNNPdfg1MrGqdVQQyPn++BiXQB4O+z52h02X4u+1BHW/RHOfpYFn2r0ya6WPe4420Xrrorm/gV2AANxkoSannU1wVwczXrDGJPAVceQdCGr4EPCONZifasalQSi2kteVziz6Ki1gliCpl+XLOZdM1OrOu5wwux0eQP4ZDokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1B4Oxpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290EDC4CEF5;
	Fri,  3 Oct 2025 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759499852;
	bh=p8IR9RaiFT+mnhzvMmJX2PNaRlUaTCuHwWwXEIp3wBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I1B4OxpwdjzCdiOABaC07n7/q5RPIvfutKAUAfebufOmCFkgIfXg43Ts5LzjesZ4N
	 fKuiihFbvWgoW2SkJ2qe0jHjR21FbHn41EemOoUGogec0rVrVMCIgjkGPH0JRZI8o7
	 42tiyRPkhcs1C2/WS5eRZNIuWyHm1idp4W+P8AdkffIMbQJHzOR43iAc4SVcmabEzD
	 QF3+3KBd8+1xMWMWItzQyFDOaxp14HvBzAJdwhexSvcmCcdf4BKw0g9rpQ54Ul5vRi
	 M5Em4sTxMWkOpuWE5Xl88rx3xIhU9d9tFn9lk2pp4Lw/m7HubVhVWvO4Qxh73lOVxB
	 buURkL0xM7HKg==
Message-ID: <2313f8b9-56ae-4b38-a419-1d5ab8582914@kernel.org>
Date: Fri, 3 Oct 2025 09:57:31 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Fix crash in nfsd4_read_release()
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250930140520.2947-1-cel@kernel.org>
 <175928003792.1696783.17556773248679753110@noble.neil.brown.name>
 <57b7be9c-dcbb-477d-b453-736fa7ddcfe4@kernel.org>
 <175947529411.247319.1453292585395648663@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175947529411.247319.1453292585395648663@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 3:08 AM, NeilBrown wrote:
> On Wed, 01 Oct 2025, Chuck Lever wrote:
>> On 9/30/25 8:53 PM, NeilBrown wrote:
>>> On Wed, 01 Oct 2025, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> When tracing is enabled, the trace_nfsd_read_done trace point
>>>> crashes during the pynfs read.testNoFh test.
>>>>
>>>> Fixes: 87c5942e8fae ("nfsd: Add I/O trace points in the NFSv4 read proc")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  fs/nfsd/nfs4proc.c | 7 ++++---
>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index e466cf52d7d7..f9aeefc0da73 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -988,10 +988,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>  static void
>>>>  nfsd4_read_release(union nfsd4_op_u *u)
>>>>  {
>>>> -	if (u->read.rd_nf)
>>>> +	if (u->read.rd_nf) {
>>>> +		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>>>> +				     u->read.rd_offset, u->read.rd_length);
>>>>  		nfsd_file_put(u->read.rd_nf);
>>>> -	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>>>> -			     u->read.rd_offset, u->read.rd_length);
>>>> +	}
>>>>  }
>>>
>>> I must say this looks a bit weird.  rd_nf isn't used in the trace but if
>>> it isn't set, you say the trace crashes...
>>>
>>> That is because rd_fhp being NULL (because there is no current_fh) is
>>> one thing that results in rd_nf being NULL.  Seems a bit indirect.
>>
>> When rd_nf is NULL, no file or file handle is present. That's really all
>> there is to it. You can read it as "when rd_nf is NULL, no processing is
>> needed".
>>
>> The other read trace points are already skipped in this case as well, so
>> there is no need to protect them.
> 
> They are skipped because ALLOWED_WITHOUT_FH is not set so ->op_func
> isn't called.  But ->op_release *is* called.  That seems inconsistent.
> I wonder if we could move the ->op_release call out of
> nfsd4_encode_operation() and only call it in cases were ->op_func
> was called.
> 
> Something like the following?  It isn't as elegant as I would have
> liked, but I think it is better than hiding the ->op_release cxall in
> nfsd4_encode_replay().
> 
> Thanks,
> NeilBrown
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..4ed823d1e6be 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2837,6 +2837,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  
>  	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
>  	while (!status && resp->opcnt < args->opcnt) {
> +		bool called_func = false;
> +

Or call it "release_needed" ?

This change is not something I'd care to have backported into stable
kernels... So maybe keep the modification of nfsd4_read_release for
backport, and then subsequently do this change too?

I was reminded of a release-related change that Jeff did recently, maybe
commit 15a8b55dbb1b ("nfsd: call op_release, even when op_func returns
an error")... might be relevant, might not.


>  		op = &args->ops[resp->opcnt++];
>  
>  		/*
> @@ -2886,6 +2888,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  		if (op->opdesc->op_get_currentstateid)
>  			op->opdesc->op_get_currentstateid(cstate, &op->u);
>  		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
> +		called_func = true;
>  		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
>  
>  		/* Only from SEQUENCE */
> @@ -2914,6 +2917,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			nfsd4_encode_operation(resp, op);
>  			status = op->status;
>  		}
> +		if (called_func && op->opdesc->op_release)
> +			op->opdesc->op_release(&op->u);
> +
>  
>  		trace_nfsd_compound_status(args->opcnt, resp->opcnt,
>  					   status, nfsd4_op_name(op->opnum));
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..e7b4363aadb0 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5885,10 +5885,10 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  	nfsd4_enc encoder;
>  
>  	if (xdr_stream_encode_u32(xdr, op->opnum) != XDR_UNIT)
> -		goto release;
> +		goto out;
>  	op_status_offset = xdr->buf->len;
>  	if (!xdr_reserve_space(xdr, XDR_UNIT))
> -		goto release;
> +		goto out;
>  
>  	if (op->opnum == OP_ILLEGAL)
>  		goto status;
> @@ -5944,10 +5944,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  				      resp->cstate.minorversion);
>  	write_bytes_to_xdr_buf(xdr->buf, op_status_offset,
>  			       &op->status, XDR_UNIT);
> -release:
> -	if (opdesc && opdesc->op_release)
> -		opdesc->op_release(&op->u);
> -
> +out:
>  	/*
>  	 * Account for pages consumed while encoding this operation.
>  	 * The xdr_stream primitives don't manage rq_next_page.
> 
> 


-- 
Chuck Lever

