Return-Path: <linux-nfs+bounces-2902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF928ABF07
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1751F2108F
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2E6AD7;
	Sun, 21 Apr 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbsPKwKb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C627205E18
	for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713697755; cv=none; b=BD4qW5VFR4Z/YC5sT9f9jakHMEZogrrxTq8yBnvS05geVKIRs/w1mHkGw2YeRu1jaGL7EyZr2y8xIbqRYtcA401BiZe8aJyBJdk5jvxGhuD7l7U1mnhvUco7fsmXFqpe5DUjWLLxSJkyTngoaiMa6lt3UfIgLddvilFCiLsM3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713697755; c=relaxed/simple;
	bh=K7whcTXPKX0ok6+ZuOjP4owHPTRcGvZqaw2j0EbjNYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qwRkWOr7BIdVHf3fRcNEjqC53tYmRDXajMVEq3I+m/i4i71nEWMBqH/OepJV5rDRp/mc1CK5Mkv7zFsnbaxxyviRGzMqT+HVpvImTgHLSBaQJpgKpN2xaVvE0XAfjtMdCsl0WJtZJMv4tTy+slsEvTFLlDDNmn0LzWFERSXv3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbsPKwKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713697751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xki1MVnejpTNcusEuGjLJBMsxtxdLN86OpYA4cNlQB0=;
	b=UbsPKwKb01umGVKo7EhQY38k7pa/E/ZmpVqULjgisW795PH4jyrfc8ragb/77QDAI6IiJm
	mQAqhTM/liR2Aqt1EyMMK11SGReEvoqWjtwSkD+7mLssVl0YEOxvDvSR3mnIJuG26wBg+9
	UVDDfmxHZjku7KCzRgecdS03Rrz90Tg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-jBcAyrfPNHikphOeg-bPCg-1; Sun, 21 Apr 2024 07:09:10 -0400
X-MC-Unique: jBcAyrfPNHikphOeg-bPCg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a01116b273so10602096d6.1
        for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 04:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713697749; x=1714302549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xki1MVnejpTNcusEuGjLJBMsxtxdLN86OpYA4cNlQB0=;
        b=ZyiWUXT064TSJ0ZLSWJ7XCTlrqHJYlzEPYDb6QOu2SoCdWoMvtTDSvbZA6u2S1RHje
         nB+R8YoTRx/Gys54HxwPAPmaF6AQOPiI3fn0X2ZADVNro9PbwsGNkLKh9qOP9/f5z0PA
         6yplMEY2/NLXAhG/4xgEyIuId0xNCbtDhGBr406fMqE2WUnVYh1qCJ11lXpEn4rB7eWy
         UkY2NFnu3Oxkezb5ll9EqXs/nu1J3HCvSS0EzQO5URQqkdDIM5ABY2UNyyaW6YAYRgEu
         wVukIGLH65Zu4zqP5FA9dbjoksSbHQRQQh2aK+L/1KkQXWdc+a9NuynXB3B1eRJcGfYR
         ETfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFrETYoCJwG4214DKD4ulxPQ+hHCyCKLUuAdLj+GIRSMfSlYgCnqrOGzWY1YVy2cRWfDhzwRiYxy17LfA6h/qGIT0b8xHeKNUS
X-Gm-Message-State: AOJu0YwbreYNdSWmMbqeF0y1AuB1dFbtF6fK8hUuzuPw0vBCPB6P4SAj
	UL5Qd7gBUg1tpUyTSc91yIkYFO5IwxjLT0ka8wHXiUAga3S+hlSiN/C+vdwp4CSeielopqNdyme
	J5MIgPCvgYHP/Xc+XMUo0kgOWLuB5YWBRK4jReixe2SX/s7DpXST2Nlo9J9vG2IzKKg==
X-Received: by 2002:a05:620a:8b87:b0:78f:1bf4:5262 with SMTP id qx7-20020a05620a8b8700b0078f1bf45262mr6273787qkn.0.1713697749428;
        Sun, 21 Apr 2024 04:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7kfA7cJV8ug3EkN1CG6VHcpyBEk239QmdIJDL/JyGAPWUDvBmRSXl4j1rJgowJbRvw9cvjg==
X-Received: by 2002:a05:620a:8b87:b0:78f:1bf4:5262 with SMTP id qx7-20020a05620a8b8700b0078f1bf45262mr6273768qkn.0.1713697749060;
        Sun, 21 Apr 2024 04:09:09 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.136.115])
        by smtp.gmail.com with ESMTPSA id wx37-20020a05620a5a6500b0078eebee6a49sm1682354qkn.85.2024.04.21.04.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:09:08 -0700 (PDT)
Message-ID: <42faba18-0042-407e-9957-497806cfeed1@redhat.com>
Date: Sun, 21 Apr 2024 07:09:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mount: If a reserved ports is used, do so for the pings
 as well
To: Alexandre Ratchov <alex@caoua.org>, linux-nfs@vger.kernel.org
References: <ZhkMcZDhJhsVjo52@vm1.arverb.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <ZhkMcZDhJhsVjo52@vm1.arverb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/24 6:26 AM, Alexandre Ratchov wrote:
> Hi,
> 
> mount.nfs always uses a high port to probe the server's ports (regardless of
> the "-o resvport" option).  Certain NFS servers (ex.  OpenBSD -current) will
> drop the connection, the probe will fail, and mount.nfs will exit before any
> attempt to mount the file-system.  If mount.nfs doesn't ping the server from
> a high port, mounting the file system will just work.
> 
> Note that the same will happen if the server is behind a firewall that
> blocks connections to the NFS service that originates from a high port.
Committed... (tag: nfs-utils-2-7-1-rc7)

I just hope we don't run out of privilege ports during
a mount storm (aka when a server reboots).

steved.

> 
> ---
>   support/include/nfsrpc.h |  3 ++-
>   support/nfs/getport.c    | 10 +++++++---
>   utils/mount/network.c    | 36 ++++++++++++++++++++----------------
>   utils/mount/network.h    |  4 ++--
>   utils/mount/nfsmount.c   | 16 +++++++++++-----
>   utils/mount/stropts.c    | 24 +++++++++++++++++++++---
>   6 files changed, 63 insertions(+), 30 deletions(-)
> 
> diff --git a/support/include/nfsrpc.h b/support/include/nfsrpc.h
> index fbbdb6a9..9106c195 100644
> --- a/support/include/nfsrpc.h
> +++ b/support/include/nfsrpc.h
> @@ -170,7 +170,8 @@ extern int		nfs_rpc_ping(const struct sockaddr *sap,
>   				const rpcprog_t program,
>   				const rpcvers_t version,
>   				const unsigned short protocol,
> -				const struct timeval *timeout);
> +				const struct timeval *timeout,
> +				const int resvport);
>   
>   /* create AUTH_SYS handle with no supplemental groups */
>   extern AUTH *			 nfs_authsys_create(void);
> diff --git a/support/nfs/getport.c b/support/nfs/getport.c
> index 813f7bf9..ff7e9991 100644
> --- a/support/nfs/getport.c
> +++ b/support/nfs/getport.c
> @@ -730,7 +730,8 @@ static unsigned short nfs_gp_getport(CLIENT *client,
>    */
>   int nfs_rpc_ping(const struct sockaddr *sap, const socklen_t salen,
>   		 const rpcprog_t program, const rpcvers_t version,
> -		 const unsigned short protocol, const struct timeval *timeout)
> +		 const unsigned short protocol, const struct timeval *timeout,
> +		 const int resvport)
>   {
>   	union nfs_sockaddr address;
>   	struct sockaddr *saddr = &address.sa;
> @@ -744,8 +745,11 @@ int nfs_rpc_ping(const struct sockaddr *sap, const socklen_t salen,
>   	nfs_clear_rpc_createerr();
>   
>   	memcpy(saddr, sap, (size_t)salen);
> -	client = nfs_get_rpcclient(saddr, salen, protocol,
> -						program, version, &tout);
> +	client = resvport ?
> +		 nfs_get_priv_rpcclient(saddr, salen, protocol,
> +					program, version, &tout) :
> +		 nfs_get_rpcclient(saddr, salen, protocol,
> +				   program, version, &tout);
>   	if (client != NULL) {
>   		result = nfs_gp_ping(client, tout);
>   		nfs_gp_map_tcp_errorcodes(protocol);
> diff --git a/utils/mount/network.c b/utils/mount/network.c
> index 01ead49f..d9221567 100644
> --- a/utils/mount/network.c
> +++ b/utils/mount/network.c
> @@ -525,7 +525,7 @@ static void nfs_pp_debug2(const char *str)
>    */
>   static int nfs_probe_port(const struct sockaddr *sap, const socklen_t salen,
>   			  struct pmap *pmap, const unsigned long *versions,
> -			  const unsigned int *protos)
> +			  const unsigned int *protos, const int resvp)
>   {
>   	union nfs_sockaddr address;
>   	struct sockaddr *saddr = &address.sa;
> @@ -550,7 +550,7 @@ static int nfs_probe_port(const struct sockaddr *sap, const socklen_t salen,
>   				nfs_pp_debug(saddr, salen, prog, *p_vers,
>   						*p_prot, p_port);
>   				if (nfs_rpc_ping(saddr, salen, prog,
> -							*p_vers, *p_prot, NULL))
> +						 *p_vers, *p_prot, NULL, resvp))
>   					goto out_ok;
>   			} else
>   				rpc_createerr.cf_stat = RPC_PROGNOTREGISTERED;
> @@ -603,7 +603,7 @@ out_ok:
>    * returned; rpccreateerr.cf_stat is set to reflect the nature of the error.
>    */
>   static int nfs_probe_nfsport(const struct sockaddr *sap, const socklen_t salen,
> -			     struct pmap *pmap, int checkv4)
> +			     struct pmap *pmap, int checkv4, int resvp)
>   {
>   	if (pmap->pm_vers && pmap->pm_prot && pmap->pm_port)
>   		return 1;
> @@ -617,13 +617,13 @@ static int nfs_probe_nfsport(const struct sockaddr *sap, const socklen_t salen,
>   		memcpy(&save_sa, sap, salen);
>   
>   		ret = nfs_probe_port(sap, salen, pmap,
> -				     probe_nfs3_only, probe_proto);
> +				     probe_nfs3_only, probe_proto, resvp);
>   		if (!ret || !checkv4 || probe_proto != probe_tcp_first)
>   			return ret;
>   
>   		nfs_set_port((struct sockaddr *)&save_sa, NFS_PORT);
>   		ret =  nfs_rpc_ping((struct sockaddr *)&save_sa, salen,
> -			NFS_PROGRAM, 4, IPPROTO_TCP, NULL);
> +				    NFS_PROGRAM, 4, IPPROTO_TCP, NULL, resvp);
>   		if (ret) {
>   			rpc_createerr.cf_stat = RPC_FAILED;
>   			rpc_createerr.cf_error.re_errno = EAGAIN;
> @@ -632,7 +632,7 @@ static int nfs_probe_nfsport(const struct sockaddr *sap, const socklen_t salen,
>   		return 1;
>   	} else
>   		return nfs_probe_port(sap, salen, pmap,
> -					probe_nfs2_only, probe_udp_only);
> +				      probe_nfs2_only, probe_udp_only, resvp);
>   }
>   
>   /*
> @@ -649,17 +649,17 @@ static int nfs_probe_nfsport(const struct sockaddr *sap, const socklen_t salen,
>    * returned; rpccreateerr.cf_stat is set to reflect the nature of the error.
>    */
>   static int nfs_probe_mntport(const struct sockaddr *sap, const socklen_t salen,
> -				struct pmap *pmap)
> +			     struct pmap *pmap)
>   {
>   	if (pmap->pm_vers && pmap->pm_prot && pmap->pm_port)
>   		return 1;
>   
>   	if (nfs_mount_data_version >= 4)
>   		return nfs_probe_port(sap, salen, pmap,
> -					probe_mnt3_only, probe_udp_first);
> +				      probe_mnt3_only, probe_udp_first, 0);
>   	else
>   		return nfs_probe_port(sap, salen, pmap,
> -					probe_mnt1_first, probe_udp_only);
> +				      probe_mnt1_first, probe_udp_only, 0);
>   }
>   
>   /*
> @@ -676,9 +676,10 @@ static int nfs_probe_version_fixed(const struct sockaddr *mnt_saddr,
>   			struct pmap *mnt_pmap,
>   			const struct sockaddr *nfs_saddr,
>   			const socklen_t nfs_salen,
> -			struct pmap *nfs_pmap)
> +			struct pmap *nfs_pmap,
> +			const int resvp)
>   {
> -	if (!nfs_probe_nfsport(nfs_saddr, nfs_salen, nfs_pmap, 0))
> +	if (!nfs_probe_nfsport(nfs_saddr, nfs_salen, nfs_pmap, 0, resvp))
>   		return 0;
>   	return nfs_probe_mntport(mnt_saddr, mnt_salen, mnt_pmap);
>   }
> @@ -706,7 +707,8 @@ int nfs_probe_bothports(const struct sockaddr *mnt_saddr,
>   			const struct sockaddr *nfs_saddr,
>   			const socklen_t nfs_salen,
>   			struct pmap *nfs_pmap,
> -			int checkv4)
> +			int checkv4,
> +			int resvp)
>   {
>   	struct pmap save_nfs, save_mnt;
>   	const unsigned long *probe_vers;
> @@ -718,7 +720,8 @@ int nfs_probe_bothports(const struct sockaddr *mnt_saddr,
>   
>   	if (nfs_pmap->pm_vers)
>   		return nfs_probe_version_fixed(mnt_saddr, mnt_salen, mnt_pmap,
> -					       nfs_saddr, nfs_salen, nfs_pmap);
> +					       nfs_saddr, nfs_salen, nfs_pmap,
> +					       resvp);
>   
>   	memcpy(&save_nfs, nfs_pmap, sizeof(save_nfs));
>   	memcpy(&save_mnt, mnt_pmap, sizeof(save_mnt));
> @@ -727,7 +730,8 @@ int nfs_probe_bothports(const struct sockaddr *mnt_saddr,
>   
>   	for (; *probe_vers; probe_vers++) {
>   		nfs_pmap->pm_vers = mntvers_to_nfs(*probe_vers);
> -		if (nfs_probe_nfsport(nfs_saddr, nfs_salen, nfs_pmap, checkv4) != 0) {
> +		if (nfs_probe_nfsport(nfs_saddr, nfs_salen, nfs_pmap, checkv4,
> +				      resvp) != 0) {
>   			mnt_pmap->pm_vers = *probe_vers;
>   			if (nfs_probe_mntport(mnt_saddr, mnt_salen, mnt_pmap) != 0)
>   				return 1;
> @@ -759,7 +763,7 @@ int nfs_probe_bothports(const struct sockaddr *mnt_saddr,
>    * Otherwise zero is returned; rpccreateerr.cf_stat is set to reflect
>    * the nature of the error.
>    */
> -int probe_bothports(clnt_addr_t *mnt_server, clnt_addr_t *nfs_server)
> +int probe_bothports(clnt_addr_t *mnt_server, clnt_addr_t *nfs_server, int resvp)
>   {
>   	struct sockaddr *mnt_addr = SAFE_SOCKADDR(&mnt_server->saddr);
>   	struct sockaddr *nfs_addr = SAFE_SOCKADDR(&nfs_server->saddr);
> @@ -767,7 +771,7 @@ int probe_bothports(clnt_addr_t *mnt_server, clnt_addr_t *nfs_server)
>   	return nfs_probe_bothports(mnt_addr, sizeof(mnt_server->saddr),
>   					&mnt_server->pmap,
>   					nfs_addr, sizeof(nfs_server->saddr),
> -					&nfs_server->pmap, 0);
> +					&nfs_server->pmap, 0, resvp);
>   }
>   
>   /**
> diff --git a/utils/mount/network.h b/utils/mount/network.h
> index 0fc98acd..8bcc7ace 100644
> --- a/utils/mount/network.h
> +++ b/utils/mount/network.h
> @@ -39,10 +39,10 @@ typedef struct {
>   static const struct timeval TIMEOUT = { 20, 0 };
>   static const struct timeval RETRY_TIMEOUT = { 3, 0 };
>   
> -int probe_bothports(clnt_addr_t *, clnt_addr_t *);
> +int probe_bothports(clnt_addr_t *, clnt_addr_t *, int);
>   int nfs_probe_bothports(const struct sockaddr *, const socklen_t,
>   			struct pmap *, const struct sockaddr *,
> -			const socklen_t, struct pmap *, int);
> +			const socklen_t, struct pmap *, int, int);
>   int nfs_gethostbyname(const char *, struct sockaddr_in *);
>   int nfs_lookup(const char *hostname, const sa_family_t family,
>   		struct sockaddr *sap, socklen_t *salen);
> diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
> index 3d95da94..a792c6e7 100644
> --- a/utils/mount/nfsmount.c
> +++ b/utils/mount/nfsmount.c
> @@ -123,13 +123,13 @@ nfs2_mount(CLIENT *clnt, mnt2arg_t *mnt2arg, mnt2res_t *mnt2res)
>   
>   static int
>   nfs_call_mount(clnt_addr_t *mnt_server, clnt_addr_t *nfs_server,
> -	       mntarg_t *mntarg, mntres_t *mntres)
> +	       mntarg_t *mntarg, mntres_t *mntres, int resvp)
>   {
>   	CLIENT *clnt;
>   	enum clnt_stat stat;
>   	int msock;
>   
> -	if (!probe_bothports(mnt_server, nfs_server))
> +	if (!probe_bothports(mnt_server, nfs_server, resvp))
>   		goto out_bad;
>   
>   	clnt = mnt_openclnt(mnt_server, &msock);
> @@ -164,7 +164,8 @@ nfs_call_mount(clnt_addr_t *mnt_server, clnt_addr_t *nfs_server,
>   static int
>   parse_options(char *old_opts, struct nfs_mount_data *data,
>   	      int *bg, int *retry, clnt_addr_t *mnt_server,
> -	      clnt_addr_t *nfs_server, char *new_opts, const int opt_size)
> +	      clnt_addr_t *nfs_server, char *new_opts, const int opt_size,
> +	      int *resvp)
>   {
>   	struct sockaddr_in *mnt_saddr = &mnt_server->saddr;
>   	struct pmap *mnt_pmap = &mnt_server->pmap;
> @@ -177,6 +178,7 @@ parse_options(char *old_opts, struct nfs_mount_data *data,
>   
>   	data->flags = 0;
>   	*bg = 0;
> +	*resvp = 1;
>   
>   	len = strlen(new_opts);
>   	tmp_opts = xstrdup(old_opts);
> @@ -365,6 +367,8 @@ parse_options(char *old_opts, struct nfs_mount_data *data,
>   				data->flags &= ~NFS_MOUNT_NOAC;
>   				if (!val)
>   					data->flags |= NFS_MOUNT_NOAC;
> +			} else if (!strcmp(opt, "resvport")) {
> +				*resvp = val;
>   #if NFS_MOUNT_VERSION >= 2
>   			} else if (!strcmp(opt, "tcp")) {
>   				data->flags &= ~NFS_MOUNT_TCP;
> @@ -498,6 +502,7 @@ nfsmount(const char *spec, const char *node, int flags,
>   	static struct nfs_mount_data data;
>   	int val;
>   	static int doonce = 0;
> +	int resvp;
>   
>   	clnt_addr_t mnt_server = {
>   		.hostname = &mounthost
> @@ -582,7 +587,7 @@ nfsmount(const char *spec, const char *node, int flags,
>   	/* parse options */
>   	new_opts[0] = 0;
>   	if (!parse_options(old_opts, &data, &bg, &retry, &mnt_server, &nfs_server,
> -			   new_opts, sizeof(new_opts)))
> +			   new_opts, sizeof(new_opts), &resvp))
>   		goto fail;
>   	if (!nfsmnt_check_compat(nfs_pmap, mnt_pmap))
>   		goto fail;
> @@ -620,6 +625,7 @@ nfsmount(const char *spec, const char *node, int flags,
>   #if NFS_MOUNT_VERSION >= 5
>   	printf(_(", sec = %u"), data.pseudoflavor);
>   	printf(_(", readdirplus = %d"), (data.flags & NFS_MOUNT_NORDIRPLUS) != 0);
> +	printf(_(", resvp = %u"), resvp);
>   #endif
>   	printf("\n");
>   #endif
> @@ -670,7 +676,7 @@ nfsmount(const char *spec, const char *node, int flags,
>   				sleep(30);
>   
>   			stat = nfs_call_mount(&mnt_server, &nfs_server,
> -					      &dirname, &mntres);
> +					      &dirname, &mntres, resvp);
>   			if (stat)
>   				break;
>   			memcpy(nfs_pmap, &save_nfs, sizeof(*nfs_pmap));
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index a92c4200..85b8ca5a 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -337,6 +337,20 @@ static int nfs_verify_lock_option(struct mount_options *options)
>   	return 1;
>   }
>   
> +static const char *nfs_resvport_opttbl[] = {
> +	"noresvport",
> +	"resvport",
> +	NULL,
> +};
> +
> +/*
> + * Returns true unless "noresvport" is set
> + */
> +static int nfs_resvport_option(struct mount_options *options)
> +{
> +	return po_rightmost(options, nfs_resvport_opttbl) != 0;
> +}
> +
>   static int nfs_insert_sloppy_option(struct mount_options *options)
>   {
>   	if (linux_version_code() < MAKE_VERSION(2, 6, 27))
> @@ -550,7 +564,7 @@ static int nfs_construct_new_options(struct mount_options *options,
>    * FALSE is returned if some failure occurred.
>    */
>   static int
> -nfs_rewrite_pmap_mount_options(struct mount_options *options, int checkv4)
> +nfs_rewrite_pmap_mount_options(struct mount_options *options, int checkv4, int resvp)
>   {
>   	union nfs_sockaddr nfs_address;
>   	struct sockaddr *nfs_saddr = &nfs_address.sa;
> @@ -604,7 +618,8 @@ nfs_rewrite_pmap_mount_options(struct mount_options *options, int checkv4)
>   	 * negotiate.  Bail now if we can't contact it.
>   	 */
>   	if (!nfs_probe_bothports(mnt_saddr, mnt_salen, &mnt_pmap,
> -				 nfs_saddr, nfs_salen, &nfs_pmap, checkv4)) {
> +				 nfs_saddr, nfs_salen, &nfs_pmap,
> +				 checkv4, resvp)) {
>   		errno = ESPIPE;
>   		if (rpc_createerr.cf_stat == RPC_PROGNOTREGISTERED)
>   			errno = EOPNOTSUPP;
> @@ -670,6 +685,7 @@ static int nfs_do_mount_v3v2(struct nfsmount_info *mi,
>   {
>   	struct mount_options *options = po_dup(mi->options);
>   	int result = 0;
> +	int resvp;
>   
>   	if (!options) {
>   		errno = ENOMEM;
> @@ -704,11 +720,13 @@ static int nfs_do_mount_v3v2(struct nfsmount_info *mi,
>   		goto out_fail;
>   	}
>   
> +	resvp = nfs_resvport_option(options);
> +
>   	if (verbose)
>   		printf(_("%s: trying text-based options '%s'\n"),
>   			progname, *mi->extra_opts);
>   
> -	if (!nfs_rewrite_pmap_mount_options(options, checkv4))
> +	if (!nfs_rewrite_pmap_mount_options(options, checkv4, resvp))
>   		goto out_fail;
>   
>   	result = nfs_sys_mount(mi, options);


