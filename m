Return-Path: <linux-nfs+bounces-12280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C6AD4010
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 19:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AB2165804
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00EA242D97;
	Tue, 10 Jun 2025 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9BpxWx3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A9242D90
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575241; cv=none; b=PAbPDeZRlff+6pPNfyCaKesd72WcHpMFcvl7F+D6vZJIL7AW1o1nuFs3hcU65USppllx9efh8+Rib9dtbGUYNHfo4l5dIShnSOfqGVBLX/A+KaOB7uaf5n7tNN3Ts3E/CrMEqHoTBsjTmqShD1wW7awKRQhUkYTRDPUYlo4DKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575241; c=relaxed/simple;
	bh=m96Ovgoo4c3NAVYqPhwqA0+yBZDE+CfkIsBs6jy2iM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgTA6OzrfWcHEfN5wihi6ESCvPaaZSD3uuSeQOXKbdAL5mCcx7xCr3dl7Xb49JlMvH34BpUqILOND4sT5OIQzOiK8g47uwxWtaUMu+b6uG/8J2PBiZ2/r/tGmY2Z0CHytKChxhYBshvyHf3gtkprGgoXZ/atX6bCSw0jjX5BPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9BpxWx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A82DC4CEED;
	Tue, 10 Jun 2025 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749575241;
	bh=m96Ovgoo4c3NAVYqPhwqA0+yBZDE+CfkIsBs6jy2iM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k9BpxWx3zfT1GdWP/yJO7WCay0fMiZ8zpAqaa4Z1ZgqiWfwXe2wwB17bC4TpvceEb
	 BmUTFEOAUcsVFRB/bBzk6DlcD8HZXFu8RlO/h9IyiJj7wtmMUJ/cnPjGXNe8AOk+g3
	 PRtEeyoE9AmcaU0vrxjI3ZraHr+a0C23ON5EhXSGQisqSGvtKpmCeR+XVaeeHuLPWW
	 Y/rzXYzd7qqkky6w8HVfUffrc17nQK/BDd8VIF/SRCsf70LgFbOJF9Qh/jJJwWsTdh
	 o/MkVDYc6n8x0opBv+pdcnAYzbv4Lq9L33UqEp2ZMXq5uMxqcwOiYV8jXLxQSv2dJX
	 wIkIP7f1hih/A==
Message-ID: <f566f15d-5656-4e82-bf11-9da029d43d0e@kernel.org>
Date: Tue, 10 Jun 2025 13:07:19 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] NFSD: Remove the cap on number of operations per
 NFSv4 COMPOUND
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250610160509.97599-1-cel@kernel.org>
 <20250610160509.97599-4-cel@kernel.org>
 <2155635c72f3bf440d25f74fd7924694389fb378.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <2155635c72f3bf440d25f74fd7924694389fb378.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 1:01 PM, Jeff Layton wrote:
> On Tue, 2025-06-10 at 12:05 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> This limit has always been a sanity check; in nearly all cases a
>> large COMPOUND is a sign of a malfunctioning client. The only real
>> limit on COMPOUND size and complexity is the size of NFSD's send
>> and receive buffers.
>>
>> However, there are a few cases where a large COMPOUND is sane. For
>> example, when a client implementation wants to walk down a long file
>> pathname in a single round trip.
>>
>> A small risk is that now a client can construct a COMPOUND request
>> that can keep a single nfsd thread busy for quite some time.
>>
> 
> You're right about the risk there. I wonder what we could do to
> mitigate that?
> 
> Maybe get a timestamp at the start of the compound and then check vs.
> that after every operation? If the compound is taking longer than a
> some timeout, give up and return an error on the next operation?

I'm open to thinking about additional guard rails.

The problem with a timeout is that any single operation can take a long
time -- if the underlying media is malfunctioning or if the remote NFS
server for a re-export is unreachable, for example.


> Also, while I did suggest it, we should consider not removing this
> limit altogether, and rather just increase it to something like a max
> practical limit:
> 
> For instance, we have limits in the channel_attrs for ca_maxrequestsize
> and ca_maxresponsesize. What's the smallest operation? If we had a
> compound comprised of just those operations, how many would fit?
> 
> That would at least act as a sanity check against compounds that are
> clearly nonsensical.

Relying on the size of the COMPOUND itself should be sufficient. If the
whole COMPOUND can't fit in ca_maxrequestsize, that's effectively the
same thing as limiting the number of ops based on the maxrequestsize
value.


>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4proc.c  | 14 ++------------
>>  fs/nfsd/nfs4state.c |  1 -
>>  fs/nfsd/nfs4xdr.c   |  4 +---
>>  fs/nfsd/nfsd.h      |  3 ---
>>  fs/nfsd/xdr4.h      |  1 -
>>  5 files changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index f13abbb13b38..f4edf222e00e 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -2842,20 +2842,10 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>>  
>>  	rqstp->rq_lease_breaker = (void **)&cstate->clp;
>>  
>> -	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->client_opcnt);
>> +	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
>>  	while (!status && resp->opcnt < args->opcnt) {
>>  		op = &args->ops[resp->opcnt++];
>>  
>> -		if (unlikely(resp->opcnt == NFSD_MAX_OPS_PER_COMPOUND)) {
>> -			/* If there are still more operations to process,
>> -			 * stop here and report NFS4ERR_RESOURCE. */
>> -			if (cstate->minorversion == 0 &&
>> -			    args->client_opcnt > resp->opcnt) {
>> -				op->status = nfserr_resource;
>> -				goto encode_op;
>> -			}
>> -		}
>> -
>>  		/*
>>  		 * The XDR decode routines may have pre-set op->status;
>>  		 * for example, if there is a miscellaneous XDR error
>> @@ -2932,7 +2922,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>>  			status = op->status;
>>  		}
>>  
>> -		trace_nfsd_compound_status(args->client_opcnt, resp->opcnt,
>> +		trace_nfsd_compound_status(args->opcnt, resp->opcnt,
>>  					   status, nfsd4_op_name(op->opnum));
>>  
>>  		nfsd4_cstate_clear_replay(cstate);
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index d5694987f86f..4b6ae8e54cd2 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -3872,7 +3872,6 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
>>  	ca->headerpadsz = 0;
>>  	ca->maxreq_sz = min_t(u32, ca->maxreq_sz, maxrpc);
>>  	ca->maxresp_sz = min_t(u32, ca->maxresp_sz, maxrpc);
>> -	ca->maxops = min_t(u32, ca->maxops, NFSD_MAX_OPS_PER_COMPOUND);
>>  	ca->maxresp_cached = min_t(u32, ca->maxresp_cached,
>>  			NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
>>  	ca->maxreqs = min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSION);
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 3afcdbed6e14..ea91bad4eee2 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2500,10 +2500,8 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
>>  
>>  	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
>>  		return false;
>> -	if (xdr_stream_decode_u32(argp->xdr, &argp->client_opcnt) < 0)
>> +	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
>>  		return false;
>> -	argp->opcnt = min_t(u32, argp->client_opcnt,
>> -			    NFSD_MAX_OPS_PER_COMPOUND);
>>  
>>  	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
>>  		argp->ops = vcalloc(argp->opcnt, sizeof(*argp->ops));
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 570065285e67..54a96042f5ac 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -57,9 +57,6 @@ struct readdir_cd {
>>  	__be32			err;	/* 0, nfserr, or nfserr_eof */
>>  };
>>  
>> -/* Maximum number of operations per session compound */
>> -#define NFSD_MAX_OPS_PER_COMPOUND	50
>> -
>>  struct nfsd_genl_rqstp {
>>  	struct sockaddr		rq_daddr;
>>  	struct sockaddr		rq_saddr;
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index aa2a356da784..a23bc56051ca 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -870,7 +870,6 @@ struct nfsd4_compoundargs {
>>  	char *				tag;
>>  	u32				taglen;
>>  	u32				minorversion;
>> -	u32				client_opcnt;
>>  	u32				opcnt;
>>  	bool				splice_ok;
>>  	struct nfsd4_op			*ops;
> 


-- 
Chuck Lever

