Return-Path: <linux-nfs+bounces-18408-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGyGEOfdc2nMzAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18408-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 21:45:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FCA7AB65
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 21:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52389300E71F
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 20:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2792D8375;
	Fri, 23 Jan 2026 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI3M6Pxr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1B3EBF29
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201091; cv=none; b=RW0O2HaLfIYdBfzmm6AQ0vtmGWca1JXX/q51FrUuIue4EdNxt/BgIQfKuDE86RU7e9sOmo51GIJSu1deLD9cxkXz/KPTOkMPvTfJkZWI8Itk5qZnpie6JcbMCWoPMEERRaxMyBBVfIkRSIc+wlRa7UIZzpVjD3Z2mFEfcZZ0ejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201091; c=relaxed/simple;
	bh=+A+Z2lBmDWBA7yAR1rFugZLlI0Gvp0EVmtjPDpjUvMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXoxVctNBc929UCvk+OvzXKruKjQLBE+IpfkoVvacGoXdqW9yxUtAWzkeZS0aGa7u90tAG26jqLcuSTssYAD41A7kanfsYYkdEgf0RZuKMqt0jUz0xDmlS5UYsdeMeeY0y//fEAWjWf4zJ4OViHpnJ+3tYb/y6VD95syOun75Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI3M6Pxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE77C4CEF1;
	Fri, 23 Jan 2026 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769201090;
	bh=+A+Z2lBmDWBA7yAR1rFugZLlI0Gvp0EVmtjPDpjUvMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kI3M6Pxr+tPWSwKnNmLRFhm7sM8Fcokt6pUY/dILVUIMLizz0Oyhi584j+jbVjgyk
	 xBM3QtFF9P1MXcMpCkAayGb/DmBtxpuiiYrgotES2vC1ZZ/qS8imA7FQUmVZcpPShR
	 wLE6705+LMABJ1mkPrBiVTIsqs70XD1G0fzhHkfBaBAX7jvzqM9tO/HDcfc1zdX0AO
	 eeiqOgs+Fv64Se0wUPwdaZrOvWMJuUN7AivhqXoue0WZSFnDlkXuLHpaCp6ET8exEH
	 ZkBTmSE9hqpXaEd44uqdT83HXmI6pfi6E1pIPOAPatJCNkff0XkQg5SOxoTXEyhjiq
	 W9PG1j5wdUvKg==
Message-ID: <8f13122c-66eb-4c54-a767-c152cc3db04d@kernel.org>
Date: Fri, 23 Jan 2026 15:44:45 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/42] NFS: Use nlmclnt_rpc_clnt() helper to retrieve
 nlm_host's rpc_clnt
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260123185259.1215767-1-cel@kernel.org>
 <20260123185259.1215767-6-cel@kernel.org>
 <53120eface645028e6a33cfb3cbf1a66ccbe2ca6.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <53120eface645028e6a33cfb3cbf1a66ccbe2ca6.camel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18408-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C6FCA7AB65
X-Rspamd-Action: no action

On 1/23/26 3:23 PM, Jeff Layton wrote:
> On Fri, 2026-01-23 at 13:52 -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The external API definitions for lockd reside in linux/lockd/bind.h.
>> Because "struct nlm_host" is an internal lockd structure, bind.h
>> does not include a definition of it. Dereferencing that structure
>> outside of lockd violates the layering boundary between NFS and
>> lockd.
>>
>> The proper approach is to use the nlmclnt_rpc_clnt() helper function
>> already provided in lockd/bind.h, which retrieves the NLM host's
>> struct rpc_clnt without exposing internal lockd structures. This
>> maintains clean separation between the NFS client and lockd
>> internals.
>>
>> Note that the nlm_host's h_rpcclnt field can be NULL during
>> initialization (host.c:141) or after cleanup (host.c:629). Add a
>> NULL check before calling shutdown_client() to prevent a potential
>> NULL pointer dereference in the sysfs shutdown path.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfs/sysfs.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
>> index ea6e6168092b..186b29de0129 100644
>> --- a/fs/nfs/sysfs.c
>> +++ b/fs/nfs/sysfs.c
>> @@ -12,7 +12,7 @@
>>  #include <linux/string.h>
>>  #include <linux/nfs_fs.h>
>>  #include <linux/rcupdate.h>
>> -#include <linux/lockd/lockd.h>
>> +#include <linux/lockd/bind.h>
>>  
>>  #include "internal.h"
>>  #include "nfs4_fs.h"
>> @@ -284,8 +284,12 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
>>  	if (!IS_ERR(server->client_acl))
>>  		shutdown_client(server->client_acl);
>>  
>> -	if (server->nlm_host)
>> -		shutdown_client(server->nlm_host->h_rpcclnt);
>> +	if (server->nlm_host) {
>> +		struct rpc_clnt *nlm_clnt = nlmclnt_rpc_clnt(server->nlm_host);
>> +
>> +		if (nlm_clnt)
>> +			shutdown_client(nlm_clnt);
> 
> I don't see any locking here. Soon after this thing goes NULL, the
> nlm_clnt can be freed. ISTM that this ought to take a reference to
> nlm_clnt and put it afterward.

So there is no locking here before the patch is applied. The patch does
not change that. Do you mean that the patch should add the additional
reference count bump (and document that fix in the commit message) ?

Mason's prompts did not call this out, so I assumed there wasn't an
obvious UAF possible in this path.


> 
>> +	}
>>  out:
>>  	shutdown_nfs_client(server->nfs_client);
>>  	return count;
> 


-- 
Chuck Lever

