Return-Path: <linux-nfs+bounces-2247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B9787719D
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Mar 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E41F215C3
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Mar 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4A940851;
	Sat,  9 Mar 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+zdNEyS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B873FB9F
	for <linux-nfs@vger.kernel.org>; Sat,  9 Mar 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709994438; cv=none; b=qUha897RvtYQY8V5P5qSAlH425d1CzoHtbsgYxEWgclg5tq664gK/DmxmytcGEdq6u+6DHOWnCqLQHONLrOZx7WCyjxw/1AdYGvS6lHggaTq1isaDe5hNBl36sNewYr9prYQWrrUL0FTnYtI+8YN1uEQMZkgoiT1tMHJHNy4i+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709994438; c=relaxed/simple;
	bh=dHK4TwtiwKmc0YjiSG+iWVgvjjRIeCpvaMM4F0R5V9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQQ9NIQm+SBotunHP5WkkmHgfBUpfG0RcqeLJEo/NmAFbRzReM0Zb+DwRxICtfytqbPotMeRPsqiBmWTjdpexAaLf3eZSOh1M6x4VgOxXMZfL/5nRpNhm1r60W+qpBke1LN0QpZQKWmXgh2hn6QCYjcB8mtl5A/OGZ5Tvd81Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+zdNEyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709994435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSNbetzHv4eqL67oG0/Cjb16FpgKNiHeJGRagYm6k3g=;
	b=d+zdNEySWlKvkh6i9hsOzjJmpq46X2aGl6hi09RLsUylDbdkMDtImAWKO/eIdFrH2IFoTW
	3qabzVxGNSY2UG3aulLSpxnMugDWjBgkDl+nAhq79kU2nJsQkzegfcJDYO5SqcVkWGbgei
	h9LvqCG7R0XifIP4t8oSeyCX4IZSMjY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-leY2sx1BMLyFjCFjB-7TKg-1; Sat, 09 Mar 2024 09:27:12 -0500
X-MC-Unique: leY2sx1BMLyFjCFjB-7TKg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-690c19ee50bso105646d6.0
        for <linux-nfs@vger.kernel.org>; Sat, 09 Mar 2024 06:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709994432; x=1710599232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSNbetzHv4eqL67oG0/Cjb16FpgKNiHeJGRagYm6k3g=;
        b=EYURm3Og/X9earAJ+I/9WS4Ijpl2ReckgUqb5KxdGbMpLQJLQViBmR11Rsdu7gLrvx
         Fslp8zjVndqZKaPBVOL4Hbh3w2Z60V0gbbcU7sjT0cfCIBLohx8o2mXc1X976VazIIE9
         9jCHOOJvr+o5WgIututgfzsu0WpceQMCQ61DVnwcqXgXucC3RBQHrWXDa5HnufhgjToV
         uTy+U68OnWYKti3j8EWo9JkzMlLpFchR6/bkdGzn+KTUE+RPCZa+zFu98YOHiOZODPpa
         cxPhcQvCYso5Q6Vk2O8QpR1sKpySsPHQxBsi5iJ1zezy10xVDIWAzpWVAkLvgTO1ocdV
         KIkg==
X-Gm-Message-State: AOJu0Yxf/jGIR3mVVhuU6P4ugeudlryuNEiApUZoSDIRdlRWLBjpovip
	nFMS/DPzD+tbxhhGj73eMM6GAmFdSipfiDsQ8eISQ451P0TSi5FUbxm170ucBIwf6Xss2gvhxng
	/Un8cSkwknmj2DzcDpqaMXYCxcc2kisKSkKyuWX3tBM6swLyC9smcq624+A==
X-Received: by 2002:ad4:58c5:0:b0:68f:1c80:d78e with SMTP id dh5-20020ad458c5000000b0068f1c80d78emr1841898qvb.0.1709994432329;
        Sat, 09 Mar 2024 06:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH54voFMIiD1gf+ApLf++tk/+rfQGiFNhlqU6CkzcxKONEc9fZmBZaDbOjlQV93qcWmgpFQDg==
X-Received: by 2002:ad4:58c5:0:b0:68f:1c80:d78e with SMTP id dh5-20020ad458c5000000b0068f1c80d78emr1841887qvb.0.1709994431997;
        Sat, 09 Mar 2024 06:27:11 -0800 (PST)
Received: from [172.31.1.12] ([70.109.163.43])
        by smtp.gmail.com with ESMTPSA id bu18-20020ad455f2000000b0068f881d0d00sm962215qvb.53.2024.03.09.06.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 06:27:11 -0800 (PST)
Message-ID: <52cc6a79-7c7c-47ec-b1f0-cc0de61fafab@redhat.com>
Date: Sat, 9 Mar 2024 09:27:10 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
References: <20240225234337.19744-1-neilb@suse.de>
 <20240225234337.19744-3-neilb@suse.de>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240225234337.19744-3-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/25/24 6:40 PM, NeilBrown wrote:
> Two callers of local_rpcb() want the target-addr, and local_rcpb() has
> easy access to it.  So accept a pointer and fill it in if not NULL.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   src/rpcb_clnt.c | 35 +++++++++++------------------------
>   1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index 68fe69a320ff..f587580228ab 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -89,7 +89,7 @@ static struct address_cache *copy_of_cached(const char *, char *);
>   static void delete_cache(struct netbuf *);
>   static void add_cache(const char *, const char *, struct netbuf *, char *);
>   static CLIENT *getclnthandle(const char *, const struct netconfig *, char **);
> -static CLIENT *local_rpcb(void);
> +static CLIENT *local_rpcb(char **targaddr);
>   #ifdef NOTUSED
>   static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netconfig *);
>   #endif
> @@ -430,19 +430,12 @@ getclnthandle(host, nconf, targaddr)
>   	    nconf->nc_netid, si.si_af, si.si_proto, si.si_socktype));
>   
>   	if (nconf->nc_protofmly != NULL && strcmp(nconf->nc_protofmly, NC_LOOPBACK) == 0) {
> -		client = local_rpcb();
> +		client = local_rpcb(targaddr);
>   		if (! client) {
>   			LIBTIRPC_DEBUG(1, ("getclnthandle: %s",
>   				clnt_spcreateerror("local_rpcb failed")));
>   			goto out_err;
>   		} else {
> -			struct sockaddr_un sun;
> -
> -			if (targaddr) {
> -				*targaddr = malloc(sizeof(sun.sun_path));
> -				strncpy(*targaddr, _PATH_RPCBINDSOCK,
> -				    sizeof(sun.sun_path));
> -			}
>   			return (client);
>   		}
>   	} else {
> @@ -541,7 +534,8 @@ getpmaphandle(nconf, hostname, tgtaddr)
>    * rpcbind. Returns NULL on error and free's everything.
>    */
>   static CLIENT *
> -local_rpcb()
> +local_rpcb(targaddr)
> +	char **targaddr;
>   {
>   	CLIENT *client;
>   	static struct netconfig *loopnconf;
> @@ -574,6 +568,8 @@ local_rpcb()
>   	if (client != NULL) {
>   		/* Mark the socket to be closed in destructor */
>   		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
> +		if (targaddr)
> +			*targaddr = strdup(sun.sun_path);
>   		return client;
>   	}
>   
> @@ -632,7 +628,7 @@ try_nconf:
>   		endnetconfig(nc_handle);
>   	}
>   	mutex_unlock(&loopnconf_lock);
> -	client = getclnthandle(hostname, loopnconf, NULL);
> +	client = getclnthandle(hostname, loopnconf, targaddr);
>   	return (client);
>   }
>   
> @@ -661,20 +657,11 @@ rpcb_set(program, version, nconf, address)
>   		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
>   		return (FALSE);
>   	}
> -	client = local_rpcb();
> +	client = local_rpcb(&parms.r_addr);
>   	if (! client) {
>   		return (FALSE);
>   	}
>   
> -	/* convert to universal */
> -	/*LINTED const castaway*/
> -	parms.r_addr = taddr2uaddr((struct netconfig *) nconf,
> -				   (struct netbuf *)address);
> -	if (!parms.r_addr) {
> -		CLNT_DESTROY(client);
> -		rpc_createerr.cf_stat = RPC_N2AXLATEFAILURE;
> -		return (FALSE); /* no universal address */
> -	}
>   	parms.r_prog = program;
>   	parms.r_vers = version;
>   	parms.r_netid = nconf->nc_netid;
> @@ -712,7 +699,7 @@ rpcb_unset(program, version, nconf)
>   	RPCB parms;
>   	char uidbuf[32];
>   
> -	client = local_rpcb();
> +	client = local_rpcb(NULL);
>   	if (! client) {
>   		return (FALSE);
>   	}
> @@ -1342,7 +1329,7 @@ rpcb_taddr2uaddr(nconf, taddr)
>   		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
>   		return (NULL);
>   	}
> -	client = local_rpcb();
> +	client = local_rpcb(NULL);
>   	if (! client) {
>   		return (NULL);
>   	}
> @@ -1376,7 +1363,7 @@ rpcb_uaddr2taddr(nconf, uaddr)
>   		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
>   		return (NULL);
>   	}
> -	client = local_rpcb();
> +	client = local_rpcb(NULL);
>   	if (! client) {
>   		return (NULL);
>   	}
It is not clear why... but this patch stop mountd from
registering with rpcbind (both the old and changed via
the latest patches), which means v3 mounts break.
Not good :-)

Turning debugging on... rpcbind is receiving the set prog
but not recording it, since port 0 is returned when
the client tries to do a v3 mount.

Are you guys seeing this??

I remove this patch and everything works!

steved.


