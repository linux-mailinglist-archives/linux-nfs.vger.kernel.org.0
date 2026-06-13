Return-Path: <linux-nfs+bounces-22544-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fbneF6K+LWpgjQQAu9opvQ
	(envelope-from <linux-nfs+bounces-22544-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 22:33:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDF67FA36
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 22:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b=NaWZOXfS;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22544-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22544-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DDFC300850D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 20:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA0396B9A;
	Sat, 13 Jun 2026 20:33:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2C32B111;
	Sat, 13 Jun 2026 20:33:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382814; cv=none; b=kkTHnjVENWnaZ0qN3R323nRsaIpBi0Y9flpJXdHaOp+N9s1c6ItU5fGTRkqtT270x0Bq9YW1gErwDtq7JhdWmCWbQmdqo+cZpVXfLHKtCPH4uFTkLGE2NGiKM+8G4fivukAmQ2ggQU149hjLZI35wMGD9bIZep8JZEYrBmNKBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382814; c=relaxed/simple;
	bh=s+RIUfmjQ+kw+0Y/ld0ezMtUVvuWPlH9NCe31EoWS8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxpg5ztcU3OuctmUWobGFeQAxZlL1byAYrXiJuOpUt3RE6Aqn02BCfkpkKQMVGnpQjfuL1Zh8YmOaJHHHCjG19uxuxvNeyN0IPPvXFaKePlYjmySMrozbA3NpQbGV5kilFE2tUOlI+THbEFAdx5t1H6I5dW/K9jQeq8sm0e4o0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NaWZOXfS; arc=none smtp.client-ip=80.12.242.19
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662] ([10.64.95.111])
	by smtp.orange.fr with ESMTP
	id YUuKwMjwU8HACYUuKwHwLq; Sat, 13 Jun 2026 22:24:44 +0200
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id YUuBwnQnHUNPnYUuCwDWzm; Sat, 13 Jun 2026 22:24:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1781382277;
	bh=T53gq3dU53YvAa/eX9/b169DvQ27KdVJWE91zst97qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NaWZOXfSZB9xI3PKEsCFJ/SvmhWfbrf9acmXp7Q7bmd1zWPVYGpow2SGAlEu5s2Ix
	 Ihr/lhPIJR+/8aZ88fvqxJCJ9cZPvyFgINMFehGwWWdd7qceA8ON3L1tytss4hD2Ya
	 RCMgAShturqI0DofnKk8ErwT2tTE7yPv0Rm4hqBrQGbJKO1zMPvcyoVOurxK7YfeKP
	 bhrc6WPMNxL43nHN52u1/k2ALaA/wecNyilDHYHv5prqS3/JuV6VwockwhBXehcClk
	 aMpClHhGczV4L/B9y5IktgoYVow79Z5ygg3EdCK8vaFpqGYEQHya4qdK4RhY1FMz7c
	 nzAzWPjxHHBNw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Jun 2026 22:24:37 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <1c8e10c9-def7-4f0d-8aa1-23c8035a38c8@wanadoo.fr>
Date: Sat, 13 Jun 2026 22:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: Use common error handling code in nfs_alloc_server()
To: Markus Elfring <Markus.Elfring@web.de>, anna@kernel.org,
 brauner@kernel.org, chuck.lever@oracle.com, hch@lst.de, trondmy@kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <0d2d7158-45c3-4c8b-8ca5-33a5b3445343@web.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <0d2d7158-45c3-4c8b-8ca5-33a5b3445343@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22544-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:anna@kernel.org,m:brauner@kernel.org,m:chuck.lever@oracle.com,m:hch@lst.de,m:trondmy@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[web.de,kernel.org,oracle.com,lst.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmane.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5BDF67FA36

Le 10/06/2026 à 18:35, Markus Elfring a écrit :
> From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Date: Wed, 10 Jun 2026 18:28:17 +0200
> 
> Use an additional label so that a bit of exception handling can be better
> reused at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>   fs/nfs/client.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 73b95318ba48..50482257667d 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -1063,10 +1063,8 @@ struct nfs_server *nfs_alloc_server(void)
>   		return NULL;
>   
>   	server->s_sysfs_id = ida_alloc(&s_sysfs_ids, GFP_KERNEL);

If an error occurs after a successful ida_alloc(), then ida_free() needs 
to be called in the error handling path.

CJ

> -	if (server->s_sysfs_id < 0) {
> -		kfree(server);
> -		return NULL;
> -	}
> +	if (server->s_sysfs_id < 0)
> +		goto free_server;
>   
>   	server->client = server->client_acl = ERR_PTR(-EINVAL);
>   
> @@ -1087,10 +1085,8 @@ struct nfs_server *nfs_alloc_server(void)
>   	atomic_long_set(&server->nr_active_delegations, 0);
>   
>   	server->io_stats = nfs_alloc_iostats();
> -	if (!server->io_stats) {
> -		kfree(server);
> -		return NULL;
> -	}
> +	if (!server->io_stats)
> +		goto free_server;
>   
>   	server->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
>   
> @@ -1103,6 +1099,10 @@ struct nfs_server *nfs_alloc_server(void)
>   	rpc_init_wait_queue(&server->uoc_rpcwaitq, "NFS UOC");
>   
>   	return server;
> +
> +free_server:
> +	kfree(server);
> +	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(nfs_alloc_server);
>   


