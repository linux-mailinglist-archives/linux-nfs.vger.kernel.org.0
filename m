Return-Path: <linux-nfs+bounces-22090-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH01OobjGWrrzggAu9opvQ
	(envelope-from <linux-nfs+bounces-22090-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 21:05:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E7607AF1
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 288AE3148C41
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA34436358;
	Fri, 29 May 2026 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgA3kT2p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F74266AA;
	Fri, 29 May 2026 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080505; cv=none; b=LJKoFRF7DV+4QcSJ0k6rG1U+JmkvfNchB0aXqN+HNLs2taoTNDV2ZZwFHzLNeU9nTKDNY9Gg0d55MrIdgn8eYJxxb4R1z8xdIoH4KKzd1ZWB8fhWDqHwieI7OGg0KJx7tjZiDCb8Fy3epVrGpTFEyTxZlMXoR3nNHHd/7uWYE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080505; c=relaxed/simple;
	bh=8VySP+bwgyGqOJUvvziBEVo1uaNjm6SaSpSwjK1CqOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR8PmZI0TtG0A3yCM5Jk+3dr1dHJu8VKI3SFjO3Ik6J45yBGPToMv/XdKRTisL4MPw25RZqTqJhgHI3/4q1DlZCKGLIi5for3nZidSLFP0p3ojjgroCMhctAoevc0AavNlUEcrtWsvktcdIjT+xsDkaT/wKDjfs04E81dG0uVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgA3kT2p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DF51F00893;
	Fri, 29 May 2026 18:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780080500;
	bh=XVmWAOyF+zmjkafSMSvlgIYd0VywlGy87jYbqaFZ7B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LgA3kT2pCdREKPQFZGEPuoAuMlsS2zW0c8YJ0J2e11htI0XBXhRxANtiIiW65zIWn
	 yrQYtIRk0XxuHOQjkTwaYr4+dudQXkvQC7wK9WmzzSO33lvcFUwXmJetFgu4xWHkIg
	 PqLTtbqkhFP1oFyP1N5BfYE56MyTtMJmLZOEXBfaRGQWDmFnKLSyutjcYzhuumUDPI
	 ovVhcGd12hC58dEQP4JKRShiMkC3UQTj9Keq7GFKdlEzhZXR3GNWK/wWpImsvwoUe0
	 wR33hBQdQ6fP/XYvc6wyEfPycMFXvj6omqBHooE5iuTy+B3s7z2CI2wgxkjIhxQQwL
	 tuPVFMCLHxqqg==
Message-ID: <a2a8d609-4e48-4d28-8749-1f0654464bba@kernel.org>
Date: Fri, 29 May 2026 14:48:18 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort
 cost
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 "J. Bruce Fields" <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>,
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>,
 Rick Macklem <rmacklem@uoguelph.ca>, Trond Myklebust <trondmy@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
 <d1d41aef-0add-44d6-ac53-b78334b885a3@app.fastmail.com>
 <92e21cec11e8d7482f03e090fbf6a3de0e8d67d7.camel@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <92e21cec11e8d7482f03e090fbf6a3de0e8d67d7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22090-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D70E7607AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 2:41 PM, Jeff Layton wrote:
> On Fri, 2026-05-29 at 14:34 -0400, Chuck Lever wrote:
>> [ replaced broken email address for Trond ]
>>
>> On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
>>
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index c6c50c376b23..5469c6c207ba 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -448,6 +448,8 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs 
>>> *argp, struct posix_acl **acl)
>>>
>>>  	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
>>>  		return nfserr_bad_xdr;
>>> +	if (count > NFS_ACL_MAX_ENTRIES)
>>> +		return nfserr_resource;
>>
>> nfserr_resource is consistent with other fattr4 decoders, but
>> does not make sense here, IMO. A better choice is nfserr_inval.
>>
> 
> Why not? An ACL that long doesn't violate the spec (as you pointed
> out), the implementation just can't handle it. I do agree that
> nfserr_resource is not the ideal error code, but it's the closest error
> I can see that says "you hit an internal limitation of the server".

Among other reasons, NFS4ERR_RESOURCE does not exist outside of NFSv4.0.
The server is not out of resources in this case.

For NFSv4.1+ NFSD's compound encoder converts it to either
nfserr_rep_too_big or nfserr_rep_too_big_to_cache, neither of which are
close to appropriate.

Rick's NFSv4 POSIX ACL specification uses NFS4ERR_INVAL for just about
every error condition. The specific meaning of INVAL is "invalid input"
which is exactly what we have here.


-- 
Chuck Lever

