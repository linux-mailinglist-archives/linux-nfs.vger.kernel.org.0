Return-Path: <linux-nfs+bounces-21057-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHqkKdde6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21057-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:03:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B3455DE7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F9130158B9
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E5637188A;
	Thu, 23 Apr 2026 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5t4zFjr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295436D4E1
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967060; cv=none; b=iJJAC7GrXDnD6B9c2LM+sJi/Pm8JVAWiIMl5zyEUmWRmiOx5b9oSCrauhT1V3B3c9zhC9rkQPha3yrvnJ3kihJj6LxlkCZKs3PRSiulFLyTcUsWKeW9MP2vE2gWwWPbzY5xpym74hQrqxyX0Mu2288KeZoku4r2cbW1v6rQwXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967060; c=relaxed/simple;
	bh=k2/JeMnGIr+8Bq/rjASbVd0aErnX0ZsnqCRH1xGRGqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAVnBwdHISFp8Uek4Za2Q4I548MluO6VIXaVY4zitpKMAWQEX81UHczZdZjI2Cc6sbDbf7CP2op8qpzh20QRRN5zQr/DBBYCQEFSdOOuaaqV9g/fOmqAiUYH/MYwnidRYS8uVQtEzyQRk6ZOmud88CGYDBC86ESJEaGNtWckcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5t4zFjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC660C2BCAF;
	Thu, 23 Apr 2026 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967059;
	bh=k2/JeMnGIr+8Bq/rjASbVd0aErnX0ZsnqCRH1xGRGqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e5t4zFjrfWa05ksGZZviYbIM+FfIuv0gEriLPfV7r0G2Aaw44UYrz1ckHzGNx3O/I
	 iQQf3PqsPZg2c2+x8HqpTovR7CYeNIJKsAOn+lUCo0Tg+G5ldoAvlvzWrcF36I5tSX
	 A6Rp+4oSRC7D9ImQCzF2anpn08bQKfikZuNQPRy0yFg0hLfByG5dE9Ri5LzXRgTefm
	 MoVgseVY81gyBhDk+yIvL9r6QrVHovHy75eSO6P3iMexHyu/d/FIVgWLOIxKQNSQ/m
	 cPOMtc7ZM5hlAvjpMeG7+330cZ8ZeukiT7UDiSsDOfJd8HiSlW77v7ys4B09RTVVOY
	 xIfIwof7Pv70Q==
Message-ID: <a917f460-6b75-4941-9278-df788cab9f43@kernel.org>
Date: Thu, 23 Apr 2026 13:57:37 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Put cache get-reqs dump attrs under reply
To: Jeff Layton <jlayton@kernel.org>, Thorsten Leemhuis
 <linux@leemhuis.info>, NeilBrown <neilb@ownmail.net>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260423171732.322623-1-cel@kernel.org>
 <ffdac7ec-2a0c-48fe-915d-cb9e11b73d7a@leemhuis.info>
 <13219731-89be-4c49-8842-69935c21eb2f@kernel.org>
 <b5d6ce7d4d34ee2b30556e0e671abc10ebf4535b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <b5d6ce7d4d34ee2b30556e0e671abc10ebf4535b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21057-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,leemhuis.info,ownmail.net,redhat.com,oracle.com,talpey.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:email,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D37B3455DE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 10:50 AM, Jeff Layton wrote:
> On Thu, 2026-04-23 at 13:26 -0400, Chuck Lever wrote:
>> On 4/23/26 10:24 AM, Thorsten Leemhuis wrote:
>>> On 4/23/26 19:17, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> The new get-reqs dump operations added to sunrpc_cache.yaml and
>>>> nfsd.yaml place the "requests" nested attribute under dump.request.
>>>> A netlink dump carries an empty request; its payload travels back
>>>> in the reply. Because the spec names no reply attributes, the YNL
>>>> C code generator synthesizes a forward reference to a
>>>> <op>_rsp struct that is never defined, breaking any consumer of
>>>> these specs.
>>>>
>>>> This first surfaced when Thorsten Leemhuis built tools/net/ynl
>>>> against -next:
>>>
>>> Thx for the quick fix, this makes things work. In case anybody cares:
>>>
>>> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
>>
>> Thanks! Applied to nfsd-next.
>>
>>
> 
> Many thanks! I was just sitting down to look at Thorsten's mail.

'Twas my own damn fault: it was a merge-resolution-gone-wrong.


-- 
Chuck Lever

