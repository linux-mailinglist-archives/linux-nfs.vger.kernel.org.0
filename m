Return-Path: <linux-nfs+bounces-22070-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC6qE8WSGWrVxggAu9opvQ
	(envelope-from <linux-nfs+bounces-22070-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 15:21:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7EE602C99
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 350F1300E3CF
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B8532ED29;
	Fri, 29 May 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKDJAPko"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5462192F4;
	Fri, 29 May 2026 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060840; cv=none; b=aY1z2W31bWQBoNDQ033w7O63y4kFxP4fITpjbINesbQLFImw4F48NxOGBABxmSPQyhZlEkcPfO4iEM+VOQD7vXx8X5WmcEfAmjJN0qnH59hTomJoCh/yX7FbYNfK15FceMXHIyo/tXVKMRCLKYygRWejAEClqMYy6gTfqAd8VWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060840; c=relaxed/simple;
	bh=y/EaEwd3JiM6WENKF4Mxcw3S5oXc7BXHbjT7oZDjfCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HE8bQyKjMZWFFtQwYrE7KzijpRxaQnRyWuRJpw4C0SyxgYuzLQu3g261Xz3TnW9cDsvMoTI7MPDb7wYMy8zF2SJwDjL6RntFp3ctwR00YIFydAkxyh1Bvlg41iYeJrz8/Q5xzjsnIP1C/nNO71RcV0bvjjPOJQIMDynvlUagxkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKDJAPko; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E661F00893;
	Fri, 29 May 2026 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780060838;
	bh=Q6trBzt1GTp5yNMt0hMaALXlyGUSu0ts4brD1+nXhPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AKDJAPkob2T4VSx/3+H3LtEFh4U3Q7xa2+XDHmTchTYBhgnAzhQeeQKLslARIeZ/W
	 +vprxaFVf1BW2Cvi0b1Ya3ysTWcH6UeoA94hUU/epVd7y6r1T1SmGaJ1pKo5osTpR0
	 D1yBnFL3ndPk3STiwUMrLAhsMdS0pirFFBKs2ZxT9R2aGi7KQP6yh5yHDsv7z3J0Tz
	 8HhS4Dz2SgNqnosfnBbstJqHMjxGXtIxtMZyz4Jqqr9jBVokPQZbLDTIxTW3yUewUU
	 ofr5j07LmVpvuwaEi+XMK6xPZoOjPniP+DjTAPlTWO6SZ4+OsxI8JsGcDGGu93LkFr
	 T1XTv6EyN7Uhw==
Message-ID: <e351bffb-cedc-4f76-a006-ee49a86a5f68@kernel.org>
Date: Fri, 29 May 2026 09:20:36 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort
 cost
To: Jeff Layton <jlayton@kernel.org>, Rick Macklem <rick.macklem@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 Scott Mayhew <smayhew@redhat.com>,
 Trond Myklebust <Trond.Myklebust@netapp.com>,
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>,
 Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
 <CAM5tNy7sSXFUWFVkKEYVt9nLPOCT_-+7KfgZeoZ2UCv_eLMvrQ@mail.gmail.com>
 <bffd1333-a65e-40d9-9553-7de4401a55bd@app.fastmail.com>
 <71e5e6b6-f2d6-48ca-bc66-32064a2e0798@app.fastmail.com>
 <4a35675f5627c2e1e3464cb893ff6e619e41e74b.camel@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <4a35675f5627c2e1e3464cb893ff6e619e41e74b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22070-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 8F7EE602C99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 6:48 AM, Jeff Layton wrote:
> On Thu, 2026-05-28 at 20:07 -0400, Chuck Lever wrote:
>>
>> On Thu, May 28, 2026, at 7:11 PM, Chuck Lever wrote:
>>> On Thu, May 28, 2026, at 6:11 PM, Rick Macklem wrote:
>>>> On Thu, May 28, 2026 at 2:56 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>
>>>>> CAUTION: This email originated from outside of the University of Guelph. Do not click links or open attachments unless you recognize the sender and know the content is safe. If you are unsure, forward the message to ITHelp@uoguelph.ca for review.
>>>>>
>>>>>
>>>>> From: Chris Mason <clm@meta.com>
>>>>>
>>>>> nfsd4_decode_posixacl() reads a u32 entry count off the wire and passes
>>>>> it straight to posix_acl_alloc() and sort_pacl_range(). The latter is
>>>>> an O(n^2) bubble sort, so a client-chosen count drives unbounded CPU in
>>>>> the server's compound processing path.
>>>>>
>>>>>     nfsd4_decode_posixacl()
>>>>>       xdr_stream_decode_u32(&count)       /* uncapped u32 */
>>>>>       posix_acl_alloc(count, GFP_KERNEL)
>>>>>       sort_pacl_range(*acl, 0, count - 1) /* O(n^2) bubble sort */
>>>>>
>>>>> The encoder side in the same file already rejects ACLs whose a_count
>>>>> exceeds NFS_ACL_MAX_ENTRIES, but the decoder introduced in commit
>>>>> 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
>>>>> omitted the symmetric check.
>>>> My recollection is that Chuck didn't like this limit. He argued that it was
>>>> specific to the NFSv3 ACL protocol and that the limit on the size of a NFSv4
>>>> RPC message was sufficient.  I, personally, think that 1024 is a reasonable
>>>> limit for # of ACEs, but Chuck can jump in here if he doesn't agree.
>>>
>>> The NFSACL protocol limits the number of ACEs in an ACL to NFS_ACL_MAX_ENTRIES
>>> (1024). It’s a limit that is defined in the protocol itself.
>>>
>>> The NFSv4 protocol sets no similar limit. In particular, NFS_ACL_MAX_ENTRIES
>>> is not a constant defined or used by the NFSv4.x family of protocols IIRC.
>>>
>>> Using NFS_ACL_MAX_ENTRIES to cap the number of ACEs in NFSv4 ACLs is a
>>> convenience, but it adds technical debt (slight though it may be).
>>>
>>> So… We can define an implementation limit for NFSv4 ACL support in NFSD.
>>> But it shouldn’t be called NFS_ACL_MAX_ENTRIES, IMHO. For clarity of
>>> documentation, pick a number (could be 1024) and state in a comment that
>>> it is an NFSD implementation constraint, not a protocol limit. Name the
>>> constant something like NFSD4_MAX_yada to make it clear it is an
>>> implementation limit, not a protocol limit.
>>
>> A different take on this might be that we want to ensure that ACLs set
>> via the NFSv4 POSIX ACL extension can always be retrieved via NFSACL.
>> In that case, capping the ACE count at the same number makes sense.
>> As long as the reason for this is clearly mentioned.
>>
> 
> First, I'll note that the encoder already has this limit in place:
> 
> static __be32
> nfsd4_encode_posixacl(struct xdr_stream *xdr, struct svc_rqst *rqstp,
>                       struct posix_acl *acl)
> {
> [...]
>         if (acl->a_count > NFS_ACL_MAX_ENTRIES)
>                 return nfserr_resource;
> [...]
> }
> 
> ...so if you set an ACL that is longer than NFS_ACL_MAX_ENTRIES you
> already can't retrieve it with NFSv4. Given that, I went with the above
> suggestion, and added a comment to the patch. Seem ok?
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c6c50c376b23..eaf71c65d665 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -448,6 +448,14 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
>  
>         if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
>                 return nfserr_bad_xdr;
> +       /*
> +        * RFC8881 doesn't define a max number of ACE's, but the NFSACL spec
> +        * does. For NFSv4, cap the number of entries to the v3 limit, as we
> +        * want to ensure that ACLs set via NFSv4 POSIX ACL extensions are
> +        * retrievable via NFSv3.

Or, more precisely, "retrievable via NFSACL."

Otherwise, LGTM.


> +        */
> +       if (count > NFS_ACL_MAX_ENTRIES)
> +               return nfserr_resource;
>  
>         *acl = posix_acl_alloc(count, GFP_KERNEL);
>         if (*acl == NULL)


-- 
Chuck Lever

