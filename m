Return-Path: <linux-nfs+bounces-19205-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGckD1v/nWkNTAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19205-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:43:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0118C2DF
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF80C30293E2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D730EF74;
	Tue, 24 Feb 2026 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubM4K1tP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE42F12DA
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962136; cv=none; b=GvQrDhPMngX8Xahlqj7yfEDOyvTY2X9djOo4FyO03y0g16MiG1OdTUTObO9y39t9p/3Uqw1EoCVwTSRfrBgYGHkFcKLrTJF44GjSZnhiAKxc0TzFRvBpPJFTRiWLhAj3eOoPcCBCKzA/L9iMDCs1b5Bj0AgX6lhocV/ON0q1xlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962136; c=relaxed/simple;
	bh=bsGLxv0ZKlr0beaARk+ISpI2uJEmr7oAFebNmvr8eRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVEgW+RjtCpOy/gJ/PF3gqBXXQ6uwOgYyZ+HX8/MtRXPIzXQy4Jo7cxgV72wM3W20wrc9mKVy5khjmVvrqYP+S1HLyEdoKaGKFBj2NdAho5PH6VlevwTUwMSpY6PeMfrYJKSXoOWw28uzsE80fhU3chOjydvIYOu+okHK7RUsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubM4K1tP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46958C116D0;
	Tue, 24 Feb 2026 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771962135;
	bh=bsGLxv0ZKlr0beaARk+ISpI2uJEmr7oAFebNmvr8eRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ubM4K1tP1FQsb2Zx/hZfAtjjNw4sanTJV5GcFy3tc+7G5xmm9Mgx9NjZz7WKtlk8G
	 o4HEPZQ9czztGLw6YgpqRXdtAWt0xTjRh0Q1shwE6rU8c3gu3arqbvhE3ZKvttJdJH
	 UCE0c+paTLlg8SNZf2F1wqhtSTEQcunntRKbE8blOegWxNy/4WuBG5QbpAtsO89lzN
	 Vo8fBFDE7XIdaFLoJ8KXj9YH9oBXycq7ydioJ4sAHzHsohM59JcSt5C+I+WMHRQw6P
	 163OpE6pbp8W2/U1Op4bUX3obmQUP8vK6bxeZvyYPvmihUcABhsw4kaj+sNsOO/Gki
	 gdaz1hDBvd1yw==
Message-ID: <20cd1871-581d-4fdd-b4fe-10684719c419@kernel.org>
Date: Tue, 24 Feb 2026 14:42:14 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: use dynamic allocation for oversized NFSv4.0 replay
 cache
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260224193354.57849-1-cel@kernel.org>
 <887c1ca78b34974160dee3ce7f25d6d077da93ab.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <887c1ca78b34974160dee3ce7f25d6d077da93ab.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19205-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 8BF0118C2DF
X-Rspamd-Action: no action

On 2/24/26 2:39 PM, Jeff Layton wrote:
> On Tue, 2026-02-24 at 14:33 -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Commit 1e8e9913672a ("nfsd: fix heap overflow in NFSv4.0 LOCK
>> replay cache") capped the replay cache copy at NFSD4_REPLAY_ISIZE
>> to prevent a heap overflow, but set rp_buflen to zero when the
>> encoded response exceeded the inline buffer. A retransmitted LOCK
>> reaching the replay path then produced only a status code with no
>> operation body, resulting in a malformed XDR response.
>>
>> When the encoded response exceeds the 112-byte inline rp_ibuf, a
>> buffer is kmalloc'd to hold it. If the allocation fails, rp_buflen
>> remains zero, preserving the behavior from the capped-copy fix.
>> The buffer is freed when the stateowner is released or when a
>> subsequent operation's response fits in the inline buffer.
>>
>> Fixes: 1e8e9913672a ("nfsd: fix heap overflow in NFSv4.0 LOCK replay cache")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4state.c | 16 ++++++++++++++++
>>  fs/nfsd/nfs4xdr.c   | 23 ++++++++++++++++-------
>>  fs/nfsd/state.h     | 12 +++++++-----
>>  3 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index ba49f49bb93b..b4d0e82b2690 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1496,8 +1496,24 @@ release_all_access(struct nfs4_ol_stateid *stp)
>>  	}
>>  }
>>  
>> +/**
>> + * nfs4_replay_free_cache - release dynamically allocated replay buffer
>> + * @rp: replay cache to reset
>> + *
>> + * If @rp->rp_buf points to a kmalloc'd buffer, free it and reset
>> + * rp_buf to the inline rp_ibuf. Always zeroes rp_buflen.
>> + */
>> +void nfs4_replay_free_cache(struct nfs4_replay *rp)
>> +{
>> +	if (rp->rp_buf != rp->rp_ibuf)
>> +		kfree(rp->rp_buf);
>> +	rp->rp_buf = rp->rp_ibuf;
>> +	rp->rp_buflen = 0;
>> +}
>> +
>>  static inline void nfs4_free_stateowner(struct nfs4_stateowner *sop)
>>  {
>> +	nfs4_replay_free_cache(&sop->so_replay);
>>  	kfree(sop->so_owner.data);
>>  	sop->so_ops->so_free(sop);
>>  }
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 690f7a3122ec..2a0946c630e1 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -6282,14 +6282,23 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>>  		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
>>  
>>  		so->so_replay.rp_status = op->status;
>> -		if (len <= NFSD4_REPLAY_ISIZE) {
>> -			so->so_replay.rp_buflen = len;
>> -			read_bytes_from_xdr_buf(xdr->buf,
>> -						op_status_offset + XDR_UNIT,
>> -						so->so_replay.rp_buf, len);
>> -		} else {
>> -			so->so_replay.rp_buflen = 0;
>> +		if (len > NFSD4_REPLAY_ISIZE) {
>> +			char *buf = kmalloc(len, GFP_KERNEL);
>> +
>> +			nfs4_replay_free_cache(&so->so_replay);
>> +			if (buf) {
>> +				so->so_replay.rp_buf = buf;
>> +			} else {
>> +				/* rp_buflen already zeroed; skip caching */
>> +				goto status;
>> +			}
>> +		} else if (so->so_replay.rp_buf != so->so_replay.rp_ibuf) {
>> +			nfs4_replay_free_cache(&so->so_replay);
>>  		}
>> +		so->so_replay.rp_buflen = len;
>> +		read_bytes_from_xdr_buf(xdr->buf,
>> +					op_status_offset + XDR_UNIT,
>> +					so->so_replay.rp_buf, len);
>>  	}
>>  status:
>>  	op->status = nfsd4_map_status(op->status,
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 3159c7b67f50..9b05462da4cc 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -554,10 +554,10 @@ struct nfs4_client_reclaim {
>>   *   ~32(deleg. ace) = 112 bytes
>>   *
>>   * Some responses can exceed this. A LOCK denial includes the conflicting
>> - * lock owner, which can be up to 1024 bytes (NFS4_OPAQUE_LIMIT). Responses
>> - * larger than REPLAY_ISIZE are not cached in rp_ibuf; only rp_status is
>> - * saved. Enlarging this constant increases the size of every
>> - * nfs4_stateowner.
>> + * lock owner, which can be up to 1024 bytes (NFS4_OPAQUE_LIMIT). When a
>> + * response exceeds REPLAY_ISIZE, a buffer is dynamically allocated. If
>> + * that allocation fails, only rp_status is saved. Enlarging this constant
>> + * increases the size of every nfs4_stateowner.
>>   */
>>  
>>  #define NFSD4_REPLAY_ISIZE       112 
>> @@ -569,12 +569,14 @@ struct nfs4_client_reclaim {
>>  struct nfs4_replay {
>>  	__be32			rp_status;
>>  	unsigned int		rp_buflen;
>> -	char			*rp_buf;
>> +	char			*rp_buf; /* rp_ibuf or kmalloc'd */
>>  	struct knfsd_fh		rp_openfh;
>>  	int			rp_locked;
>>  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
>>  };
>>  
>> +extern void nfs4_replay_free_cache(struct nfs4_replay *rp);
>> +
>>  struct nfs4_stateowner;
>>  
>>  struct nfs4_stateowner_operations {
> 
> 
> Certainly a reasonable approach if we care about full correctness when
> dealing with a large lockowner on NFSv4.0. Do we?

The idea would be to either:

o Backport your fix and not this update, or
o Squash these two together, and backport both

Admittedly this is a narrow corner case for a minor version that is
destined for the scrap heap.


-- 
Chuck Lever

