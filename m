Return-Path: <linux-nfs+bounces-18359-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC6SJCyqc2nOxwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18359-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:04:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CCA78C36
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2548300DE2C
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13728D8FD;
	Fri, 23 Jan 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy7zZJk4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AA28B7DB
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187816; cv=none; b=UCSYaLJNtFflVC3r7pRrPm++kMVV7FsmlcIJRSpjwadSCjIP+k7BJbowGMpwsphZd9vvh1NzEvTNIbmjNaW/f2c/SKn8tJ0QvtPI+QES6S3rdzZnQpgCgttp27uo+qM2g/ygGrmv/eAxX5rzDH2iJnns5XiFdKPcpRCvJORk4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187816; c=relaxed/simple;
	bh=YU9g99kZ/0pkuN67K5+S/8hP/5LlkJEMWjPFN7A3dFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1VyEYtNWj1IsuowE2qZHpQodMnpZMc8lz/64fXI5n15SrMUZqo1x2mXyzai0nkTkLTVXmtUyGgP1XeK6WLWFTGtY3lnRLvTdi6pZhfKRkDBeaUmy358+FI8w9/Hj7lutut6WShXj9vCI/lV764gogRCWNMNOOUrzPTEiU8TAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy7zZJk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F64BC4CEF1;
	Fri, 23 Jan 2026 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769187815;
	bh=YU9g99kZ/0pkuN67K5+S/8hP/5LlkJEMWjPFN7A3dFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fy7zZJk4TT+YKVTAeKje3v3Gra5k26oXW3cMLrV1h35H1zp4Lump4SkKAyGF0ho6g
	 G8uRrnKXn1HArxcforv0+Ydt0QtZRHm4bk0zhUNmOkLBP+MZmEDuUbse3GJo8Lh3px
	 fYz88EbZyaQcqHWvK5ezSPsN8+Gku2utBas3uvfmkJO0ZkQCTQSRl41ls7Urg08RtY
	 nMas/nRZdi8y879Y6P6OM3Vqen+q3guPGlE6qcqi4VIbXdrK7bD6bAPjufhYNg8BNB
	 LJ0uVXeem+Z3t5XvBN4hGgYz/uRPTu3ZVFWi6e+BWLIt0bHcI9T5aZhCdGRbekK18o
	 qBUL2h6lDGqLw==
Message-ID: <315da21d-4a29-4bf5-b99c-dec70c645456@kernel.org>
Date: Fri, 23 Jan 2026 12:03:30 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/14] nfsd: allow unrecognisable filehandle for
 foreign servers in COPY
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251122005236.3440177-1-neilb@ownmail.net>
 <20251122005236.3440177-5-neilb@ownmail.net>
 <aSIoEqzuT6seYiq0@morisot.1015granger.net>
 <aSM5oSoiw_6wDU_K@morisot.1015granger.net>
 <176420492316.634289.7890732620603254090@noble.neil.brown.name>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <176420492316.634289.7890732620603254090@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18359-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Queue-Id: D3CCA78C36
X-Rspamd-Action: no action

On 11/26/25 7:55 PM, NeilBrown wrote:
> On Mon, 24 Nov 2025, Chuck Lever wrote:
>> On Sat, Nov 22, 2025 at 04:16:02PM -0500, Chuck Lever wrote:
>>> On Sat, Nov 22, 2025 at 11:47:02AM +1100, NeilBrown wrote:
>>>> From: NeilBrown <neil@brown.name>
>>>>
>>>> RFC-7862 acknowledges that a filehandle provided as the source of an
>>>> inter-server copy might result in NFS4ERR_STALE when given to PUTFH, and
>>>> gives guidance on how this error can be ignored (section 15.2.3).
>>>>
>>>> NFS4ERR_BADHANDLE is also a possible error in this circumstance if the
>>>> foreign server is running a different implementation of NFS than the
>>>> current one.
>>>
>>> The RFC uses the terms "source" and "destination" server, fwiw.
>>>
>>> It would be interesting to see if nfserr_badhandle can be triggered
>>> during an NFSD <-> NFSD copy.
>>>
>>>
>>>> This appears to be a simple omission in the RFC.
>>>
>>> Perhaps. It might also be the result of the RFC authors giving
>>> implementers flexibility to innovate.
>>>
>>> I would like to consult with the WG and possibly file an errata, or
>>> add this observation to the "NFSv4.2 COPY implementation experience"
>>> document I'm helping Olga with:
>>>
>>> https://datatracker.ietf.org/doc/draft-cel-nfsv4-copy-implementation-experience/
>>>
>>> They might want to consider NFS4ERR_MOVED as well.
>>>
>>>
>>>> There can be no harm in delaying a BADHANDLE error in the same situation
>>>> where we already delay STALE errors, and no harm in sending a locally
>>>> "bad" handle to a foreign server to request a COPY.
>>>
>>> These are plausible claims. But IMO, they need firmer rationale.
>>
>> My comments aren't terribly clear about this, but I agree that PUTFH
>> handling NFS4ERR_BADHANDLE is a concern when there is a subsequent
>> COPY operation in the COMPOUND.
>>
>> I think we can't rely on the letter of RFC 7862, as you pointed out.
>> However, the spirit of RFC 7862 is that PUTFH mustn't fail if a
>> client presents a foreign file handle via a PUTFH that precedes a
>> COPY operation. The lack of BCP14 language specific to other status
>> codes shouldn't stop NFSD from handling other status codes as it
>> needs to (in fact, the absence of such language affords us the
>> opportunity of doing exactly that).
>>
>> The reason for this potential PUTFH failure is an artifact of NFSD's
>> PUTFH implementation, which unconditionally invokes fh_verify.
> 
> RFC8881 says very little in the description of PUTFH.
> However the section on error codes say:
> 
>  15.1.2.1. NFS4ERR_BADHANDLE (Error Code 10001)
> 
>     Illegal NFS filehandle for the current server.  The current
>     filehandle failed internal consistency checks.  Once accepted as
>     valid (by PUTFH), no subsequent status change can cause the
>     filehandle to generate this error. 
> 
> This implies to me that if PUTFH accepts a filehandle, then it is
> "accepted as valid" and that cannot change.  So no other op can claim
> BADHANDLE if PUTFH didn't.  But other OPs do have BADHANDLE as a valid
> error.
> 
> This text also says the "current filehandle" failed, so that implies
> something that has already been accepted by PUTFH (or generated by
> LOOKUP???).
> 
> So I think we are in agreement that the RFC isn't crystal clear but
> doesn't put any barriers in the way of us making this change.
> 
>>
>> I'm wondering if PUTFH needs to check for /specific/ status codes
>> from fh_verify before looking ahead in the incoming COMPOUND, or if
>> it ought to look ahead on /any/ failure of fh_verify.
> 
> I don't have a strong opinion.
> fh_verify() can also generate
>   nfserr_nofilehandle
>   nfserr_jukebox
>   nfserr_perm
> 
> nferr_perm could arguably be handled the same way that nfserr_stale is
> handled.
> 
>>
>> And, is this patch a fix that needs to be backported to LTS kernels?
>> If so, then perhaps it needs to go before the previous patch.
> 
> It doesn't fix a regression, a security hole, and data corruption, a
> kernel panic.  So I don't think it needs to be backported (others might
> think otherwise).
> 
> I think the failure mode is that the client would fallback to handling
> the copy like it would for v4.1.
> 
>>
>> (It seems like NFSv4.2 could have added a PUT_FOREIGN_FH operation
>> to avoid all this nonsense).
> 
> That would make a lot of sense!
> 
>>
>> (I'll also note that now that our MAX_OPS_PER_COMPOUND has increased
>> and might increase again, moving the COPY look ahead checking out of
>> nfsd4_proc_compound is a huge bonus for handling large COMPOUNDs).
> 
> true
> 
> NeilBrown
> 
>>
>>
>>>> So extend the test in nfsd4_putfh to also check for nfserr_badhandle.
>>>>
>>>> Signed-off-by: NeilBrown <neil@brown.name>
>>>> ---
>>>>  fs/nfsd/nfs4proc.c | 9 +++++++--
>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index 112e62b6b9c6..ae34b816371c 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -693,7 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>  	       putfh->pf_fhlen);
>>>>  	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
>>>>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>>> -	if (ret == nfserr_stale && inter_copy_offload_enable) {
>>>> +	if ((ret == nfserr_badhandle || ret == nfserr_stale) &&
>>>> +	    inter_copy_offload_enable) {
>>>>  		struct nfsd4_compoundargs *args = rqstp->rq_argp;
>>>>  		struct nfsd4_compoundres *resp = rqstp->rq_resp;
>>>>  
>>>> @@ -713,7 +714,11 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>  			 *  NOT return NFS4ERR_STALE for either
>>>>  			 *  operation.
>>>>  			 * We limit this to when there is a COPY
>>>> -			 * in the COMPOUND.
>>>> +			 * in the COMPOUND, and extend it to
>>>> +			 * also ignore NFS4ERR_BADHANDLE despite the
>>>> +			 * RFC not requiring this.  If the remote
>>>> +			 * server is running a different NFS implementation,
>>>> +			 * NFS4ERR_BADHANDLE is a likely error.
>>>>  			 */
>>>>  			ret = 0;
>>>>  		}

Hi Neil -

I continue to be interested in improving NFSD's handling of foreign
file handles (and it might be complicated by the addition of file
handle signing). Do you have plans to revise this series, or would
you like me to take it across the finish line?



-- 
Chuck Lever

