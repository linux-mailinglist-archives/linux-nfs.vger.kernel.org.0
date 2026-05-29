Return-Path: <linux-nfs+bounces-22086-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBRtAl3IGWpXzAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22086-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:09:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B374606275
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F5D230000B2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE1537B3F9;
	Fri, 29 May 2026 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+8Q/i3V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAE37AA9E;
	Fri, 29 May 2026 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074582; cv=none; b=FQPw0DYwkkN5P+RvlQlnU/syrQ4IjkW8Z3p05ifWNvKchfWRAvLZOg2a/sxAYSaY2fywRdDY2eDSFMsdr7BVkh45hMbcYxXJgZ5aT4d84L3nxMpWzBYjgU381pdTL/Om3QIS7/WTelJxzDL/b9BcapFfbppxzOGmf+JiIMvAA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074582; c=relaxed/simple;
	bh=VqEo01HApwVDoNwMm4mS9UtiULW82qqLOCNUR26Dttc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feU2QkyPnQxHYKs3EFblH9daPdg74d73hVQYKPzeLxd80aMATMWir1JUq4bj8Unhu/zzINmyLJ7E7cRgYXmFNMEU3LE3OafQj27F1sxDHGeFs+3ovyz+esg9Lfs5VxjOGBmG1ykoVuc4+9YOiyH7QdwIVpq8ejn355cWlhe0rfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+8Q/i3V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADCE1F00893;
	Fri, 29 May 2026 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780074581;
	bh=YpeAtcMG29fZedJbOmT1T5opRlHfFXYLgaDymxOX2t4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g+8Q/i3VevX+HQ5Hqbh3FNT1FnxN5HgAHkYEIzPMzLd64p6kQDmY+9szF4HRB5uXx
	 K4ep6AWEc0YKllKbxpv3tyM41vKY4/awzS/yissw+QzDQRgKVXkKiydPYzG7GItEli
	 OElrcws/1k55kEWFld46GOW8o6SNdURZaqpBbLlY0Pkzzbio4vVg/OIBXNF9sYZBNL
	 PDTEAmSYL3YbP6XK4RCHlqzme2OqX9OTRVmvCkPDiXLXn2Jxnk0DVTUfbVU5vF4qmZ
	 /1EbNuSfpGk9PLXgE25Vz01v2CEQa6tX3nvFLWZjuSCnsCKWtoqUmmvVw3jCnrYTQW
	 W3uzbg8SUPSJg==
Message-ID: <15756486-5dbc-4d3f-b633-b8cc98d85e40@kernel.org>
Date: Fri, 29 May 2026 13:09:39 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] nfsd: fix partial-write detection in
 nfsd_direct_write
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 "J. Bruce Fields" <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>,
 Trond Myklebust <Trond.Myklebust@netapp.com>,
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>,
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-8-e78708eff77d@kernel.org>
 <5ef47df4-c9f4-4b7a-a493-71be1a95ee90@app.fastmail.com>
 <1ab23163ff7e1b7f01326ef9f222dad25ad6a863.camel@kernel.org>
 <0f23fe53-3796-4102-ab62-f28fd53afaf7@kernel.org>
 <c44f1ab33041c297510117903a9e48ae92bd118f.camel@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <c44f1ab33041c297510117903a9e48ae92bd118f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22086-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 0B374606275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 1:06 PM, Jeff Layton wrote:
> On Fri, 2026-05-29 at 13:03 -0400, Chuck Lever wrote:
>> On 5/29/26 1:01 PM, Jeff Layton wrote:
>>> On Fri, 2026-05-29 at 12:57 -0400, Chuck Lever wrote:
>>>>
>>>> On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
>>>>> From: Chris Mason <clm@meta.com>
>>>>>
>>>>> nfsd_direct_write() walks a list of write segments and, after each
>>>>> vfs_iocb_iter_write(), tries to detect a short write so the loop can
>>>>> stop before placing the next segment at a wrong file offset:
>>>>>
>>>>>     host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
>>>>>     if (host_err < 0)
>>>>>             return host_err;
>>>>>     *cnt += host_err;
>>>>>     if (host_err < segments[i].iter.count)
>>>>>             break;	/* partial write */
>>>>>
>>>>> vfs_iocb_iter_write() runs the iter through ->write_iter(), which
>>>>> advances the iter by the number of bytes written. By the time the
>>>>> check runs, segments[i].iter.count is the residual, not the original
>>>>> request length:
>>>>>
>>>>>     before write_iter: iter.count == original_len
>>>>>     after  write_iter: iter.count == original_len - host_err
>>>>>
>>>>> The condition then reduces to host_err < original_len - host_err, so
>>>>> the break fires only when less than half of the segment was written.
>>>>> Any short write completing between 50% and 99% of the segment slips
>>>>> through; the loop advances to the next segment with kiocb->ki_pos
>>>>> only bumped by the short amount, writing the next segment's payload
>>>>> at the wrong offset and over-reporting *cnt to the NFS client.
>>>>>
>>>>> Snapshot the segment's byte count before the write and compare
>>>>> host_err against that snapshot so any short write breaks the loop.
>>>>>
>>>>> Fixes: 06c5c97293e3 ("NFSD: Implement NFSD_IO_DIRECT for NFS WRITE")
>>>>> Assisted-by: kres:claude-opus-4-7
>>>>> Signed-off-by: Chris Mason <clm@meta.com>
>>>>> ---
>>>>>  fs/nfsd/vfs.c | 5 ++++-
>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>> index 980217f755b7..619f252af4d1 100644
>>>>> --- a/fs/nfsd/vfs.c
>>>>> +++ b/fs/nfsd/vfs.c
>>>>> @@ -1380,6 +1380,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct 
>>>>> svc_fh *fhp,
>>>>>  	struct file *file = nf->nf_file;
>>>>>  	unsigned int nsegs, i;
>>>>>  	ssize_t host_err;
>>>>> +	size_t expected;
>>>>>
>>>>>  	nsegs = nfsd_write_dio_iters_init(nf, rqstp->rq_bvec, nvecs,
>>>>>  					  kiocb, *cnt, segments);
>>>>> @@ -1401,11 +1402,13 @@ nfsd_direct_write(struct svc_rqst *rqstp, 
>>>>> struct svc_fh *fhp,
>>>>>  				kiocb->ki_flags |= IOCB_DONTCACHE;
>>>>>  		}
>>>>>
>>>>> +		expected = iov_iter_count(&segments[i].iter);
>>>>> +
>>>>>  		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
>>>>>  		if (host_err < 0)
>>>>>  			return host_err;
>>>>>  		*cnt += host_err;
>>>>> -		if (host_err < segments[i].iter.count)
>>>>> +		if (host_err < (ssize_t)expected)
>>>>>  			break;	/* partial write */
>>>>>  	}
>>>>>
>>>>>
>>>>> -- 
>>>>> 2.54.0
>>>>
>>>> How many filesystems can return a short write in this case?
>>>> My impression was that only the NFS client can do that.
>>>>
>>>
>>> No idea right offhand, but NFS is exportable. Since
>>> vfs_iocb_iter_write() is allowed to return a short write, I think we
>>> have to deal with that properly here.
>>
>> NFSD_IO_DIRECT is experimental, and doesn't make sense (to me)
>> to use with an NFS re-export.
>>
>> If we can find another filesystem that might return a short write
>> with NFSD_IO_DIRECT, I might consider this a higher priority.
>>
> 
> I'm fairly sure Ceph and CIFS can and they're exportable. For local
> filesystems, I'm not even sure how to audit that.
> 
> Given that the potential effect is data corruption, omitting this patch
> based on guesswork about what filesystems are being exported seems
> unwise.

The guesswork for me is that it's very unclear how likely a short write
result might be and under what circumstances.

In any event, I think this one needs testing to confirm that the logic
change doesn't introduce a regression in known working use cases.


-- 
Chuck Lever

