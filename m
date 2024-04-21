Return-Path: <linux-nfs+bounces-2906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C08AC143
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886F4B209DE
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A0B10A1F;
	Sun, 21 Apr 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eiewl+dk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B486D2FF
	for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713735520; cv=none; b=tiCGxfEaF+53GUrrlB9bnSPbOcGl+yVXqPeOkpUJ/9xgBzWEmH820u7DhJEWD7l3mp61LW7f5qDvvxjt6B8rPzv0F0KmHPmUjeMS/6sZuTL5DYxElM40lmTN1Xc7fqwxDtRVhieSm/E5tTzgeB5b+bdq7cdNh7ZyTDy456SSQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713735520; c=relaxed/simple;
	bh=XfCasWoF1s4eMhrqsL9G41wlGkdT3Ud+//10DqsoUJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VAFNfGJ06uHmpUHatkCONkl0AJY0dhiHvIgl/anbcv5qElydL1S3bbzP5eUryc/DyhQ28sbqXw+yAKx3FOSxf6NngTkXAiIccOw1xUP8tgnXcRw/e6oldZkQO1UsDZh356+a85hvBvTjOPjzPSBSMfdmoIaomolENEkz5lqMBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eiewl+dk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713735517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7A9JN/2DwCkPhcHNKyvDuCsDSUfj8cJ6FfPSNOSMBM0=;
	b=Eiewl+dkyuBRRM6ZFOvhX5dY4sMBztDNmjszg0z6Geudx6cCerOB0b6FkTMQFWZa20iJRA
	RJMTWZ5/T+EkWOFMM0PcQwuQAM2PP34gthhca5mp3MftEmG1my1adYzg6qvWWzNxfgFpp6
	Vb3kMsYieswEj2kpx2piJGlYTBuf+Gs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-5MWQZkwAOoiEnFJ6AAEV9A-1; Sun, 21 Apr 2024 17:38:35 -0400
X-MC-Unique: 5MWQZkwAOoiEnFJ6AAEV9A-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4379bbdc9b4so17560811cf.2
        for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 14:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713735514; x=1714340314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A9JN/2DwCkPhcHNKyvDuCsDSUfj8cJ6FfPSNOSMBM0=;
        b=n6Bnh7t9FlDVeKukv8gqRKn2CYjVNBPojjFX0ubCwmcAasf2CeleOUC/yqQQ9Bc/3U
         cPoenCyrQX8DJScWAx9OJeV61B44E/9ViF7jRF2gULRymBfhKYGy2B3hMzI+xb+SZjAR
         yq7scptZdpmCHAVI30RyxPoekCftgTCzWTlCWOExWMd9QV8R1pH45bf9kFrRyn3pb8tM
         M8yMMNKdzZae7C8obiObzg1UukSbdE1vAsdhwtiQ8ADZ9JaiyIw4a260DP02YqZEDnOx
         d9Bdl65O0YmIWDxs95Jynj7w5yP5qVYbPGMnfkROTuh96ATTa/viwV/ntzcc5HPwK+p4
         OTrg==
X-Forwarded-Encrypted: i=1; AJvYcCXPb9ZpCKMBO50HWqSt4j97+7JVxZxS1YA87zPtoU/BtjExCG0IgjVkKSj7ObR1WppVZTvZJEtY14GTtTVa+nRmh/AFcNkJLQHR
X-Gm-Message-State: AOJu0YykKdPO1Fp2UWdah/0IEgAhOMIMaO74NxPLkyv0g/aeg32Z+GwE
	tIi1exQANtOMJyhr1Oi+Wl+uP0A3f+TeG+2fFZZfn/3gmh9Hx+YkLIf3DPdGBo0JPrGeCN9ogwQ
	T2ZdsBs+Xc1WTG0y/pu8flYU25wd1IMg+SVh6apc/AA5i2CaaGGMLYqZJqgRBpsDNxg==
X-Received: by 2002:a05:620a:4621:b0:78e:e779:56b8 with SMTP id br33-20020a05620a462100b0078ee77956b8mr10976914qkb.6.1713735514126;
        Sun, 21 Apr 2024 14:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCDE2qDOir7KKEuyQT/oTmSEEI30dk9evHMNJHJPiroo0+iEwwnFY6maBdjO9FbP1IDRCRWA==
X-Received: by 2002:a05:620a:4621:b0:78e:e779:56b8 with SMTP id br33-20020a05620a462100b0078ee77956b8mr10976903qkb.6.1713735513719;
        Sun, 21 Apr 2024 14:38:33 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.153.17])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a113700b0079072d96baasm533911qkk.100.2024.04.21.14.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 14:38:32 -0700 (PDT)
Message-ID: <32779e7d-1f5d-449d-890f-6d26f0d6cf4a@redhat.com>
Date: Sun, 21 Apr 2024 17:38:31 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mount: If a reserved ports is used, do so for the pings
 as well
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "alex@caoua.org" <alex@caoua.org>
References: <ZhkMcZDhJhsVjo52@vm1.arverb.com>
 <42faba18-0042-407e-9957-497806cfeed1@redhat.com>
 <838909fda3f022bdf1ae3775ae0c0395e6102f85.camel@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <838909fda3f022bdf1ae3775ae0c0395e6102f85.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/21/24 12:06 PM, Trond Myklebust wrote:
> On Sun, 2024-04-21 at 07:09 -0400, Steve Dickson wrote:
>>
>>
>> On 4/12/24 6:26 AM, Alexandre Ratchov wrote:
>>> Hi,
>>>
>>> mount.nfs always uses a high port to probe the server's ports
>>> (regardless of
>>> the "-o resvport" option).  Certain NFS servers (ex.  OpenBSD -
>>> current) will
>>> drop the connection, the probe will fail, and mount.nfs will exit
>>> before any
>>> attempt to mount the file-system.  If mount.nfs doesn't ping the
>>> server from
>>> a high port, mounting the file system will just work.
>>>
>>> Note that the same will happen if the server is behind a firewall
>>> that
>>> blocks connections to the NFS service that originates from a high
>>> port.
>> Committed... (tag: nfs-utils-2-7-1-rc7)
>>
>> I just hope we don't run out of privilege ports during
>> a mount storm (aka when a server reboots).
> 
> Agreed, and that is why this change was entirely the wrong thing to do.
Well the patch was sitting around for a while without any objection
so I figured I would go with it since it would make mounts
work on other OSs

> 
> The point of the ping is to allow for fast failover in the case where
> the portmap/rpcbind server returns incorrect or stale information.
> 
> If there are servers out there that deliberately break the convention
> for NULL ping, as described in RFC5531, then we might allow optional
> use of the privileged port for those servers, but please don't force
> this on everyone else.
The patch is on the top of stack... easy revert-able... Is that what
you are suggesting?

steved.

> 
> 
>>
>> steved.
>>
>>>
>>> ---
>>>    support/include/nfsrpc.h |  3 ++-
>>>    support/nfs/getport.c    | 10 +++++++---
>>>    utils/mount/network.c    | 36 ++++++++++++++++++++---------------
>>> -
>>>    utils/mount/network.h    |  4 ++--
>>>    utils/mount/nfsmount.c   | 16 +++++++++++-----
>>>    utils/mount/stropts.c    | 24 +++++++++++++++++++++---
>>>    6 files changed, 63 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/support/include/nfsrpc.h b/support/include/nfsrpc.h
>>> index fbbdb6a9..9106c195 100644
>>> --- a/support/include/nfsrpc.h
>>> +++ b/support/include/nfsrpc.h
>>> @@ -170,7 +170,8 @@ extern int		nfs_rpc_ping(const struct
>>> sockaddr *sap,
>>>    				const rpcprog_t program,
>>>    				const rpcvers_t version,
>>>    				const unsigned short protocol,
>>> -				const struct timeval *timeout);
>>> +				const struct timeval *timeout,
>>> +				const int resvport);
>>>    
>>>    /* create AUTH_SYS handle with no supplemental groups */
>>>    extern AUTH *			 nfs_authsys_create(void);
>>> diff --git a/support/nfs/getport.c b/support/nfs/getport.c
>>> index 813f7bf9..ff7e9991 100644
>>> --- a/support/nfs/getport.c
>>> +++ b/support/nfs/getport.c
>>> @@ -730,7 +730,8 @@ static unsigned short nfs_gp_getport(CLIENT
>>> *client,
>>>     */
>>>    int nfs_rpc_ping(const struct sockaddr *sap, const socklen_t
>>> salen,
>>>    		 const rpcprog_t program, const rpcvers_t version,
>>> -		 const unsigned short protocol, const struct
>>> timeval *timeout)
>>> +		 const unsigned short protocol, const struct
>>> timeval *timeout,
>>> +		 const int resvport)
>>>    {
>>>    	union nfs_sockaddr address;
>>>    	struct sockaddr *saddr = &address.sa;
>>> @@ -744,8 +745,11 @@ int nfs_rpc_ping(const struct sockaddr *sap,
>>> const socklen_t salen,
>>>    	nfs_clear_rpc_createerr();
>>>    
>>>    	memcpy(saddr, sap, (size_t)salen);
>>> -	client = nfs_get_rpcclient(saddr, salen, protocol,
>>> -						program, version,
>>> &tout);
>>> +	client = resvport ?
>>> +		 nfs_get_priv_rpcclient(saddr, salen, protocol,
>>> +					program, version, &tout) :
>>> +		 nfs_get_rpcclient(saddr, salen, protocol,
>>> +				   program, version, &tout);
>>>    	if (client != NULL) {
>>>    		result = nfs_gp_ping(client, tout);
>>>    		nfs_gp_map_tcp_errorcodes(protocol);
>>> diff --git a/utils/mount/network.c b/utils/mount/network.c
>>> index 01ead49f..d9221567 100644
>>> --- a/utils/mount/network.c
>>> +++ b/utils/mount/network.c
>>> @@ -525,7 +525,7 @@ static void nfs_pp_debug2(const char *str)
>>>     */
>>>    static int nfs_probe_port(const struct sockaddr *sap, const
>>> socklen_t salen,
>>>    			  struct pmap *pmap, const unsigned long
>>> *versions,
>>> -			  const unsigned int *protos)
>>> +			  const unsigned int *protos, const int
>>> resvp)
>>>    {
>>>    	union nfs_sockaddr address;
>>>    	struct sockaddr *saddr = &address.sa;
>>> @@ -550,7 +550,7 @@ static int nfs_probe_port(const struct sockaddr
>>> *sap, const socklen_t salen,
>>>    				nfs_pp_debug(saddr, salen, prog,
>>> *p_vers,
>>>    						*p_prot, p_port);
>>>    				if (nfs_rpc_ping(saddr, salen,
>>> prog,
>>> -							*p_vers,
>>> *p_prot, NULL))
>>> +						 *p_vers, *p_prot,
>>> NULL, resvp))
>>>    					goto out_ok;
>>>    			} else
>>>    				rpc_createerr.cf_stat =
>>> RPC_PROGNOTREGISTERED;
>>> @@ -603,7 +603,7 @@ out_ok:
>>>     * returned; rpccreateerr.cf_stat is set to reflect the nature of
>>> the error.
>>>     */
>>>    static int nfs_probe_nfsport(const struct sockaddr *sap, const
>>> socklen_t salen,
>>> -			     struct pmap *pmap, int checkv4)
>>> +			     struct pmap *pmap, int checkv4, int
>>> resvp)
>>>    {
>>>    	if (pmap->pm_vers && pmap->pm_prot && pmap->pm_port)
>>>    		return 1;
>>> @@ -617,13 +617,13 @@ static int nfs_probe_nfsport(const struct
>>> sockaddr *sap, const socklen_t salen,
>>>    		memcpy(&save_sa, sap, salen);
>>>    
>>>    		ret = nfs_probe_port(sap, salen, pmap,
>>> -				     probe_nfs3_only,
>>> probe_proto);
>>> +				     probe_nfs3_only, probe_proto,
>>> resvp);
>>>    		if (!ret || !checkv4 || probe_proto !=
>>> probe_tcp_first)
>>>    			return ret;
>>>    
>>>    		nfs_set_port((struct sockaddr *)&save_sa,
>>> NFS_PORT);
>>>    		ret =  nfs_rpc_ping((struct sockaddr *)&save_sa,
>>> salen,
>>> -			NFS_PROGRAM, 4, IPPROTO_TCP, NULL);
>>> +				    NFS_PROGRAM, 4, IPPROTO_TCP,
>>> NULL, resvp);
>>>    		if (ret) {
>>>    			rpc_createerr.cf_stat = RPC_FAILED;
>>>    			rpc_createerr.cf_error.re_errno = EAGAIN;
>>> @@ -632,7 +632,7 @@ static int nfs_probe_nfsport(const struct
>>> sockaddr *sap, const socklen_t salen,
>>>    		return 1;
>>>    	} else
>>>    		return nfs_probe_port(sap, salen, pmap,
>>> -					probe_nfs2_only,
>>> probe_udp_only);
>>> +				      probe_nfs2_only,
>>> probe_udp_only, resvp);
>>>    }
>>>    
>>>    /*
>>> @@ -649,17 +649,17 @@ static int nfs_probe_nfsport(const struct
>>> sockaddr *sap, const socklen_t salen,
>>>     * returned; rpccreateerr.cf_stat is set to reflect the nature of
>>> the error.
>>>     */
>>>    static int nfs_probe_mntport(const struct sockaddr *sap, const
>>> socklen_t salen,
>>> -				struct pmap *pmap)
>>> +			     struct pmap *pmap)
>>>    {
>>>    	if (pmap->pm_vers && pmap->pm_prot && pmap->pm_port)
>>>    		return 1;
>>>    
>>>    	if (nfs_mount_data_version >= 4)
>>>    		return nfs_probe_port(sap, salen, pmap,
>>> -					probe_mnt3_only,
>>> probe_udp_first);
>>> +				      probe_mnt3_only,
>>> probe_udp_first, 0);
>>>    	else
>>>    		return nfs_probe_port(sap, salen, pmap,
>>> -					probe_mnt1_first,
>>> probe_udp_only);
>>> +				      probe_mnt1_first,
>>> probe_udp_only, 0);
>>>    }
>>>    
>>>    /*
>>> @@ -676,9 +676,10 @@ static int nfs_probe_version_fixed(const
>>> struct sockaddr *mnt_saddr,
>>>    			struct pmap *mnt_pmap,
>>>    			const struct sockaddr *nfs_saddr,
>>>    			const socklen_t nfs_salen,
>>> -			struct pmap *nfs_pmap)
>>> +			struct pmap *nfs_pmap,
>>> +			const int resvp)
>>>    {
>>> -	if (!nfs_probe_nfsport(nfs_saddr, nfs_salen, nfs_pmap, 0))
>>> +	if (!nfs_probe_nfsport(nfs_saddr, nfs_salen, nfs_pmap, 0,
>>> resvp))
>>>    		return 0;
>>>    	return nfs_probe_mntport(mnt_saddr, mnt_salen, mnt_pmap);
>>>    }
>>> @@ -706,7 +707,8 @@ int nfs_probe_bothports(const struct sockaddr
>>> *mnt_saddr,
>>>    			const struct sockaddr *nfs_saddr,
>>>    			const socklen_t nfs_salen,
>>>    			struct pmap *nfs_pmap,
>>> -			int checkv4)
>>> +			int checkv4,
>>> +			int resvp)
>>>    {
>>>    	struct pmap save_nfs, save_mnt;
>>>    	const unsigned long *probe_vers;
>>> @@ -718,7 +720,8 @@ int nfs_probe_bothports(const struct sockaddr
>>> *mnt_saddr,
>>>    
>>>    	if (nfs_pmap->pm_vers)
>>>    		return nfs_probe_version_fixed(mnt_saddr,
>>> mnt_salen, mnt_pmap,
>>> -					       nfs_saddr,
>>> nfs_salen, nfs_pmap);
>>> +					       nfs_saddr,
>>> nfs_salen, nfs_pmap,
>>> +					       resvp);
>>>    
>>>    	memcpy(&save_nfs, nfs_pmap, sizeof(save_nfs));
>>>    	memcpy(&save_mnt, mnt_pmap, sizeof(save_mnt));
>>> @@ -727,7 +730,8 @@ int nfs_probe_bothports(const struct sockaddr
>>> *mnt_saddr,
>>>    
>>>    	for (; *probe_vers; probe_vers++) {
>>>    		nfs_pmap->pm_vers = mntvers_to_nfs(*probe_vers);
>>> -		if (nfs_probe_nfsport(nfs_saddr, nfs_salen,
>>> nfs_pmap, checkv4) != 0) {
>>> +		if (nfs_probe_nfsport(nfs_saddr, nfs_salen,
>>> nfs_pmap, checkv4,
>>> +				      resvp) != 0) {
>>>    			mnt_pmap->pm_vers = *probe_vers;
>>>    			if (nfs_probe_mntport(mnt_saddr,
>>> mnt_salen, mnt_pmap) != 0)
>>>    				return 1;
>>> @@ -759,7 +763,7 @@ int nfs_probe_bothports(const struct sockaddr
>>> *mnt_saddr,
>>>     * Otherwise zero is returned; rpccreateerr.cf_stat is set to
>>> reflect
>>>     * the nature of the error.
>>>     */
>>> -int probe_bothports(clnt_addr_t *mnt_server, clnt_addr_t
>>> *nfs_server)
>>> +int probe_bothports(clnt_addr_t *mnt_server, clnt_addr_t
>>> *nfs_server, int resvp)
>>>    {
>>>    	struct sockaddr *mnt_addr = SAFE_SOCKADDR(&mnt_server-
>>>> saddr);
>>>    	struct sockaddr *nfs_addr = SAFE_SOCKADDR(&nfs_server-
>>>> saddr);
>>> @@ -767,7 +771,7 @@ int probe_bothports(clnt_addr_t *mnt_server,
>>> clnt_addr_t *nfs_server)
>>>    	return nfs_probe_bothports(mnt_addr, sizeof(mnt_server-
>>>> saddr),
>>>    					&mnt_server->pmap,
>>>    					nfs_addr,
>>> sizeof(nfs_server->saddr),
>>> -					&nfs_server->pmap, 0);
>>> +					&nfs_server->pmap, 0,
>>> resvp);
>>>    }
>>>    
>>>    /**
>>> diff --git a/utils/mount/network.h b/utils/mount/network.h
>>> index 0fc98acd..8bcc7ace 100644
>>> --- a/utils/mount/network.h
>>> +++ b/utils/mount/network.h
>>> @@ -39,10 +39,10 @@ typedef struct {
>>>    static const struct timeval TIMEOUT = { 20, 0 };
>>>    static const struct timeval RETRY_TIMEOUT = { 3, 0 };
>>>    
>>> -int probe_bothports(clnt_addr_t *, clnt_addr_t *);
>>> +int probe_bothports(clnt_addr_t *, clnt_addr_t *, int);
>>>    int nfs_probe_bothports(const struct sockaddr *, const socklen_t,
>>>    			struct pmap *, const struct sockaddr *,
>>> -			const socklen_t, struct pmap *, int);
>>> +			const socklen_t, struct pmap *, int, int);
>>>    int nfs_gethostbyname(const char *, struct sockaddr_in *);
>>>    int nfs_lookup(const char *hostname, const sa_family_t family,
>>>    		struct sockaddr *sap, socklen_t *salen);
>>> diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
>>> index 3d95da94..a792c6e7 100644
>>> --- a/utils/mount/nfsmount.c
>>> +++ b/utils/mount/nfsmount.c
>>> @@ -123,13 +123,13 @@ nfs2_mount(CLIENT *clnt, mnt2arg_t *mnt2arg,
>>> mnt2res_t *mnt2res)
>>>    
>>>    static int
>>>    nfs_call_mount(clnt_addr_t *mnt_server, clnt_addr_t *nfs_server,
>>> -	       mntarg_t *mntarg, mntres_t *mntres)
>>> +	       mntarg_t *mntarg, mntres_t *mntres, int resvp)
>>>    {
>>>    	CLIENT *clnt;
>>>    	enum clnt_stat stat;
>>>    	int msock;
>>>    
>>> -	if (!probe_bothports(mnt_server, nfs_server))
>>> +	if (!probe_bothports(mnt_server, nfs_server, resvp))
>>>    		goto out_bad;
>>>    
>>>    	clnt = mnt_openclnt(mnt_server, &msock);
>>> @@ -164,7 +164,8 @@ nfs_call_mount(clnt_addr_t *mnt_server,
>>> clnt_addr_t *nfs_server,
>>>    static int
>>>    parse_options(char *old_opts, struct nfs_mount_data *data,
>>>    	      int *bg, int *retry, clnt_addr_t *mnt_server,
>>> -	      clnt_addr_t *nfs_server, char *new_opts, const int
>>> opt_size)
>>> +	      clnt_addr_t *nfs_server, char *new_opts, const int
>>> opt_size,
>>> +	      int *resvp)
>>>    {
>>>    	struct sockaddr_in *mnt_saddr = &mnt_server->saddr;
>>>    	struct pmap *mnt_pmap = &mnt_server->pmap;
>>> @@ -177,6 +178,7 @@ parse_options(char *old_opts, struct
>>> nfs_mount_data *data,
>>>    
>>>    	data->flags = 0;
>>>    	*bg = 0;
>>> +	*resvp = 1;
>>>    
>>>    	len = strlen(new_opts);
>>>    	tmp_opts = xstrdup(old_opts);
>>> @@ -365,6 +367,8 @@ parse_options(char *old_opts, struct
>>> nfs_mount_data *data,
>>>    				data->flags &= ~NFS_MOUNT_NOAC;
>>>    				if (!val)
>>>    					data->flags |=
>>> NFS_MOUNT_NOAC;
>>> +			} else if (!strcmp(opt, "resvport")) {
>>> +				*resvp = val;
>>>    #if NFS_MOUNT_VERSION >= 2
>>>    			} else if (!strcmp(opt, "tcp")) {
>>>    				data->flags &= ~NFS_MOUNT_TCP;
>>> @@ -498,6 +502,7 @@ nfsmount(const char *spec, const char *node,
>>> int flags,
>>>    	static struct nfs_mount_data data;
>>>    	int val;
>>>    	static int doonce = 0;
>>> +	int resvp;
>>>    
>>>    	clnt_addr_t mnt_server = {
>>>    		.hostname = &mounthost
>>> @@ -582,7 +587,7 @@ nfsmount(const char *spec, const char *node,
>>> int flags,
>>>    	/* parse options */
>>>    	new_opts[0] = 0;
>>>    	if (!parse_options(old_opts, &data, &bg, &retry,
>>> &mnt_server, &nfs_server,
>>> -			   new_opts, sizeof(new_opts)))
>>> +			   new_opts, sizeof(new_opts), &resvp))
>>>    		goto fail;
>>>    	if (!nfsmnt_check_compat(nfs_pmap, mnt_pmap))
>>>    		goto fail;
>>> @@ -620,6 +625,7 @@ nfsmount(const char *spec, const char *node,
>>> int flags,
>>>    #if NFS_MOUNT_VERSION >= 5
>>>    	printf(_(", sec = %u"), data.pseudoflavor);
>>>    	printf(_(", readdirplus = %d"), (data.flags &
>>> NFS_MOUNT_NORDIRPLUS) != 0);
>>> +	printf(_(", resvp = %u"), resvp);
>>>    #endif
>>>    	printf("\n");
>>>    #endif
>>> @@ -670,7 +676,7 @@ nfsmount(const char *spec, const char *node,
>>> int flags,
>>>    				sleep(30);
>>>    
>>>    			stat = nfs_call_mount(&mnt_server,
>>> &nfs_server,
>>> -					      &dirname, &mntres);
>>> +					      &dirname, &mntres,
>>> resvp);
>>>    			if (stat)
>>>    				break;
>>>    			memcpy(nfs_pmap, &save_nfs,
>>> sizeof(*nfs_pmap));
>>> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
>>> index a92c4200..85b8ca5a 100644
>>> --- a/utils/mount/stropts.c
>>> +++ b/utils/mount/stropts.c
>>> @@ -337,6 +337,20 @@ static int nfs_verify_lock_option(struct
>>> mount_options *options)
>>>    	return 1;
>>>    }
>>>    
>>> +static const char *nfs_resvport_opttbl[] = {
>>> +	"noresvport",
>>> +	"resvport",
>>> +	NULL,
>>> +};
>>> +
>>> +/*
>>> + * Returns true unless "noresvport" is set
>>> + */
>>> +static int nfs_resvport_option(struct mount_options *options)
>>> +{
>>> +	return po_rightmost(options, nfs_resvport_opttbl) != 0;
>>> +}
>>> +
>>>    static int nfs_insert_sloppy_option(struct mount_options
>>> *options)
>>>    {
>>>    	if (linux_version_code() < MAKE_VERSION(2, 6, 27))
>>> @@ -550,7 +564,7 @@ static int nfs_construct_new_options(struct
>>> mount_options *options,
>>>     * FALSE is returned if some failure occurred.
>>>     */
>>>    static int
>>> -nfs_rewrite_pmap_mount_options(struct mount_options *options, int
>>> checkv4)
>>> +nfs_rewrite_pmap_mount_options(struct mount_options *options, int
>>> checkv4, int resvp)
>>>    {
>>>    	union nfs_sockaddr nfs_address;
>>>    	struct sockaddr *nfs_saddr = &nfs_address.sa;
>>> @@ -604,7 +618,8 @@ nfs_rewrite_pmap_mount_options(struct
>>> mount_options *options, int checkv4)
>>>    	 * negotiate.  Bail now if we can't contact it.
>>>    	 */
>>>    	if (!nfs_probe_bothports(mnt_saddr, mnt_salen, &mnt_pmap,
>>> -				 nfs_saddr, nfs_salen, &nfs_pmap,
>>> checkv4)) {
>>> +				 nfs_saddr, nfs_salen, &nfs_pmap,
>>> +				 checkv4, resvp)) {
>>>    		errno = ESPIPE;
>>>    		if (rpc_createerr.cf_stat ==
>>> RPC_PROGNOTREGISTERED)
>>>    			errno = EOPNOTSUPP;
>>> @@ -670,6 +685,7 @@ static int nfs_do_mount_v3v2(struct
>>> nfsmount_info *mi,
>>>    {
>>>    	struct mount_options *options = po_dup(mi->options);
>>>    	int result = 0;
>>> +	int resvp;
>>>    
>>>    	if (!options) {
>>>    		errno = ENOMEM;
>>> @@ -704,11 +720,13 @@ static int nfs_do_mount_v3v2(struct
>>> nfsmount_info *mi,
>>>    		goto out_fail;
>>>    	}
>>>    
>>> +	resvp = nfs_resvport_option(options);
>>> +
>>>    	if (verbose)
>>>    		printf(_("%s: trying text-based options '%s'\n"),
>>>    			progname, *mi->extra_opts);
>>>    
>>> -	if (!nfs_rewrite_pmap_mount_options(options, checkv4))
>>> +	if (!nfs_rewrite_pmap_mount_options(options, checkv4,
>>> resvp))
>>>    		goto out_fail;
>>>    
>>>    	result = nfs_sys_mount(mi, options);
>>
>>
> 


