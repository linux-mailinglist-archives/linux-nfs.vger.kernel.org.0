Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02AB588208
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Aug 2022 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiHBSro (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Aug 2022 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHBSrl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Aug 2022 14:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF144AD4B
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659466058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4UuxBHXpC0ccOHAwyI43zeJIoHNd4I+GuYI71/qMfVM=;
        b=KX+WiDGQhU9tnlcDllglhswROWBO2Urag9F8uo4nFLhotW1W9vJJcKKkZ9EzAS3/egP+d9
        AWxrs5kczJ3peYjGIi42/WuvByOPx/mLLQqPg6D/0Dvv/l2BTdhHQ5YfAhV5GUwqR5htEk
        8ZrN3CjkD4zZskRRdJH6KdDa6lPhrlA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-_iRqoHFXNc-C36Vfe7WAvA-1; Tue, 02 Aug 2022 14:47:37 -0400
X-MC-Unique: _iRqoHFXNc-C36Vfe7WAvA-1
Received: by mail-qk1-f200.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso12064290qkb.11
        for <linux-nfs@vger.kernel.org>; Tue, 02 Aug 2022 11:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4UuxBHXpC0ccOHAwyI43zeJIoHNd4I+GuYI71/qMfVM=;
        b=AbyvepxNo76mAACumcwQ5d+N4XXKPNgD0TUVqSe4CNeJhKRjzLOGGO4HjG+iA5oMSw
         4x29aN78WbcsPQzKhsU5+We+fdniNpfZLcQAmWChD6/QDw4ex5zZIjclOYkEHNQsEz5z
         ZAs66n/0D1SlSu8mn19CqzMbIF1hZ6SQcz+v0/oQnrdWAH1xtlxfqs7yDXEHz3mnyO1r
         7Likn9d5DZh/6109JoDW0hNXDigEUZeh0zaNwOLHKfJvXJuhqpSp15bSJcQQvM9siSMk
         QAHDoFdpG305vmax1ViiEim1lURwwThTPDYJR2f0cJw8fOxqBZLHUFEQRYhbTrVjYEwp
         u8CA==
X-Gm-Message-State: AJIora8zwXJG1rF72nYNeNFxoEwb8y9Qsoyn8O9ON2mY2Zk+one4kuVf
        2sSMXMITenH9ZtaxnM6wMdcsg0sq5G615F5TlcfsktoYetMrVVWWxNjEPshVnMoOahltnl6O+Ka
        5QhMZMCtkRyKR3wFDPlSD
X-Received: by 2002:a05:620a:2491:b0:6b5:e53d:25dc with SMTP id i17-20020a05620a249100b006b5e53d25dcmr16216140qkn.540.1659466057031;
        Tue, 02 Aug 2022 11:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sb+rDZUvRZOco+QjGNUlFpDS1HmY27EoGruamhkrfeJ7Pw+nq35AQk+NPm4faqtzsjmeCutA==
X-Received: by 2002:a05:620a:2491:b0:6b5:e53d:25dc with SMTP id i17-20020a05620a249100b006b5e53d25dcmr16216133qkn.540.1659466056719;
        Tue, 02 Aug 2022 11:47:36 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.189.21])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a430c00b006af1f0af045sm11020992qko.107.2022.08.02.11.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 11:47:35 -0700 (PDT)
Message-ID: <aa8b9caf-70dc-2edf-28e4-390bd4e98e92@redhat.com>
Date:   Tue, 2 Aug 2022 14:47:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] SUNRPC: MT-safe overhaul of address cache management in
 rpcb_clnt.c
Content-Language: en-US
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>,
        Libtirpc-devel Mailing List 
        <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220728190228.224400-1-attila.kovacs@cfa.harvard.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220728190228.224400-1-attila.kovacs@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/28/22 3:02 PM, Attila Kovacs wrote:
> From: Attila Kovacs <attipaci@gmail.com>
> 
> rpcb_clnt.c was using a read/write lock mechanism to manage the address
> cache. This was wrong, because the wrote locked deletion of a cached
> entry did not prevent concurrent access by other calls that required
> a read lock (e.g. by check_cache()). Thus, the cache could get
> corrupted.
> 
> Instead of a RW locking mechanist, the cache (a linkedf list) need a
> simple mutex to grant access. To avoid deadlocks while accessing a cache
> from functions that may recurse, the mutexed part of the cache access
> should be isolated more to only the code areas necessary.
> 
> Also, cache lookup should return an independent deep copy of the matching
> cached element, rather than a pointer to the element in the cache, for
> operations that can (and should be) performed outside of the mutexed
> areas for cache access.
> 
> With the changes, the code is more MT-dafe, more robust, and also
> simpler to follow.
> 
> Signed-off-by: Attila Kovacs <attila.kovacs@cfa.harvard.edu>
Committed... (tag: libtirpc-1-3-3-rc5)

steved.
> ---
>   src/mt_misc.c   |   2 +-
>   src/rpcb_clnt.c | 199 ++++++++++++++++++++++++++++++++----------------
>   2 files changed, 133 insertions(+), 68 deletions(-)
> 
> diff --git a/src/mt_misc.c b/src/mt_misc.c
> index 5a49b78..3a2bc51 100644
> --- a/src/mt_misc.c
> +++ b/src/mt_misc.c
> @@ -13,7 +13,7 @@ pthread_rwlock_t	svc_lock = PTHREAD_RWLOCK_INITIALIZER;
>   pthread_rwlock_t	svc_fd_lock = PTHREAD_RWLOCK_INITIALIZER;
>   
>   /* protects the RPCBIND address cache */
> -pthread_rwlock_t	rpcbaddr_cache_lock = PTHREAD_RWLOCK_INITIALIZER;
> +pthread_mutex_t	rpcbaddr_cache_lock = PTHREAD_MUTEX_INITIALIZER;
>   
>   /* protects authdes cache (svcauth_des.c) */
>   pthread_mutex_t	authdes_lock = PTHREAD_MUTEX_INITIALIZER;
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index 06f4528..0b7271a 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -85,7 +85,7 @@ static int cachesize;
>   
>   extern int __rpc_lowvers;
>   
> -static struct address_cache *check_cache(const char *, const char *);
> +static struct address_cache *copy_of_cached(const char *, const char *);
>   static void delete_cache(struct netbuf *);
>   static void add_cache(const char *, const char *, struct netbuf *, char *);
>   static CLIENT *getclnthandle(const char *, const struct netconfig *, char **);
> @@ -94,6 +94,83 @@ static CLIENT *local_rpcb(void);
>   static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netconfig *);
>   #endif
>   
> +
> +/*
> + * Destroys a cached address entry structure.
> + *
> + */
> +static void
> +destroy_addr(addr)
> +	struct address_cache *addr;
> +{
> +	if (addr == NULL)
> +		return;
> +	if(addr->ac_host != NULL)
> +		free(addr->ac_host);
> +	if(addr->ac_netid != NULL)
> +		free(addr->ac_netid);
> +	if(addr->ac_uaddr != NULL)
> +		free(addr->ac_uaddr);
> +	if(addr->ac_taddr != NULL) {
> +		if(addr->ac_taddr->buf != NULL)
> +			free(addr->ac_taddr->buf);
> +	}
> +	free(addr);
> +}
> +
> +/*
> + * Creates an unlinked copy of an address cache entry. If the argument is NULL
> + * or the new entry cannot be allocated then NULL is returned.
> + */
> +static struct address_cache *
> +copy_addr(addr)
> +	const struct address_cache *addr;
> +{
> +	struct address_cache *copy;
> +
> +	if (addr == NULL)
> +		return (NULL);
> +
> +	copy = calloc(1, sizeof(*addr));
> +	if (copy == NULL)
> +		return (NULL);
> +
> +	if (addr->ac_host != NULL) {
> +		copy->ac_host = strdup(addr->ac_host);
> +		if (copy->ac_host == NULL)
> +			goto err;
> +	}
> +	if (addr->ac_netid != NULL) {
> +		copy->ac_netid = strdup(addr->ac_netid);
> +		if (copy->ac_netid == NULL)
> +			goto err;
> +	}
> +	if (addr->ac_uaddr != NULL) {
> +		copy->ac_uaddr = strdup(addr->ac_uaddr);
> +		if (copy->ac_uaddr == NULL)
> +			goto err;
> +	}
> +
> +	if (addr->ac_taddr == NULL)
> +		return (copy);
> +
> +	copy->ac_taddr = calloc(1, sizeof(*addr->ac_taddr));
> +	if (copy->ac_taddr == NULL)
> +		goto err;
> +
> +	memcpy(copy->ac_taddr, addr->ac_taddr, sizeof(*addr->ac_taddr));
> +	copy->ac_taddr->buf = malloc(addr->ac_taddr->len);
> +	if (copy->ac_taddr->buf == NULL)
> +		goto err;
> +
> +	memcpy(copy->ac_taddr->buf, addr->ac_taddr->buf, addr->ac_taddr->len);
> +	return (copy);
> +
> +err:
> +	destroy_addr(copy);
> +	return (NULL);
> +}
> +
>   /*
>    * This routine adjusts the timeout used for calls to the remote rpcbind.
>    * Also, this routine can be used to set the use of portmapper version 2
> @@ -125,67 +202,68 @@ __rpc_control(request, info)
>   }
>   
>   /*
> - *	It might seem that a reader/writer lock would be more reasonable here.
> - *	However because getclnthandle(), the only user of the cache functions,
> - *	may do a delete_cache() operation if a check_cache() fails to return an
> - *	address useful to clnt_tli_create(), we may as well use a mutex.
> - */
> -/*
> - * As it turns out, if the cache lock is *not* a reader/writer lock, we will
> - * block all clnt_create's if we are trying to connect to a host that's down,
> - * since the lock will be held all during that time.
> + * Protect against concurrent access to the address cache and modifications
> + * (esp. deletions) of cache entries.
> + *
> + * Previously a bidirectional R/W lock was used. However, R/W locking is
> + * dangerous as it allows concurrent modification (e.g. deletion with write
> + * lock) at the same time as the deleted element is accessed via check_cache()
> + * and a read lock). We absolutely need a single mutex for all access to
> + * prevent cache corruption. If the mutexing is restricted to only the
> + * relevant code sections, deadlocking should be avoided even with recursed
> + * client creation.
>    */
> -extern rwlock_t	rpcbaddr_cache_lock;
> +extern pthread_mutex_t	rpcbaddr_cache_lock;
>   
>   /*
> - * The routines check_cache(), add_cache(), delete_cache() manage the
> - * cache of rpcbind addresses for (host, netid).
> + *
>    */
> -
>   static struct address_cache *
> -check_cache(host, netid)
> +copy_of_cached(host, netid)
>   	const char *host, *netid;
>   {
> -	struct address_cache *cptr;
> -
> -	/* READ LOCK HELD ON ENTRY: rpcbaddr_cache_lock */
> -
> +	struct address_cache *cptr, *copy = NULL;
> +	mutex_lock(&rpcbaddr_cache_lock);
>   	for (cptr = front; cptr != NULL; cptr = cptr->ac_next) {
>   		if (!strcmp(cptr->ac_host, host) &&
>   		    !strcmp(cptr->ac_netid, netid)) {
>   			LIBTIRPC_DEBUG(3, ("check_cache: Found cache entry for %s: %s\n",
>   				host, netid));
> -			return (cptr);
> +			copy = copy_addr(cptr);
> +			break;
>   		}
>   	}
> -	return ((struct address_cache *) NULL);
> +	mutex_unlock(&rpcbaddr_cache_lock);
> +	return copy;
>   }
>   
>   static void
>   delete_cache(addr)
>   	struct netbuf *addr;
>   {
> -	struct address_cache *cptr, *prevptr = NULL;
> +	struct address_cache *cptr = NULL, *prevptr = NULL;
> +
> +	mutex_lock(&rpcbaddr_cache_lock);
>   
> -	/* WRITE LOCK HELD ON ENTRY: rpcbaddr_cache_lock */
> +	/* LOCK HELD ON ENTRY: rpcbaddr_cache_lock */
>   	for (cptr = front; cptr != NULL; cptr = cptr->ac_next) {
>   		if (!memcmp(cptr->ac_taddr->buf, addr->buf, addr->len)) {
> -			free(cptr->ac_host);
> -			free(cptr->ac_netid);
> -			free(cptr->ac_taddr->buf);
> -			free(cptr->ac_taddr);
> +			/* Unlink from cache. We'll destroy it after releasing the mutex. */
>   			if (cptr->ac_uaddr)
>   				free(cptr->ac_uaddr);
>   			if (prevptr)
>   				prevptr->ac_next = cptr->ac_next;
>   			else
>   				front = cptr->ac_next;
> -			free(cptr);
>   			cachesize--;
>   			break;
>   		}
>   		prevptr = cptr;
>   	}
> +
> +	mutex_unlock(&rpcbaddr_cache_lock);
> +
> +	destroy_addr(cptr);
>   }
>   
>   static void
> @@ -217,7 +295,7 @@ add_cache(host, netid, taddr, uaddr)
>   
>   /* VARIABLES PROTECTED BY rpcbaddr_cache_lock:  cptr */
>   
> -	rwlock_wrlock(&rpcbaddr_cache_lock);
> +	mutex_lock(&rpcbaddr_cache_lock);
>   	if (cachesize < CACHESIZE) {
>   		ad_cache->ac_next = front;
>   		front = ad_cache;
> @@ -250,7 +328,7 @@ add_cache(host, netid, taddr, uaddr)
>   		}
>   		free(cptr);
>   	}
> -	rwlock_unlock(&rpcbaddr_cache_lock);
> +	mutex_unlock(&rpcbaddr_cache_lock);
>   	return;
>   
>   out_free:
> @@ -261,6 +339,7 @@ out_free:
>   	free(ad_cache);
>   }
>   
> +
>   /*
>    * This routine will return a client handle that is connected to the
>    * rpcbind. If targaddr is non-NULL, the "universal address" of the
> @@ -275,11 +354,9 @@ getclnthandle(host, nconf, targaddr)
>   	char **targaddr;
>   {
>   	CLIENT *client;
> -	struct netbuf *addr, taddr;
> -	struct netbuf addr_to_delete;
> +	struct netbuf taddr;
>   	struct __rpc_sockinfo si;
>   	struct addrinfo hints, *res, *tres;
> -	struct address_cache *ad_cache;
>   	char *tmpaddr;
>   
>   	if (nconf == NULL) {
> @@ -294,47 +371,35 @@ getclnthandle(host, nconf, targaddr)
>   		return NULL;
>   	}
>   
> -/* VARIABLES PROTECTED BY rpcbaddr_cache_lock:  ad_cache */
> +
>   
>   	/* Get the address of the rpcbind.  Check cache first */
>   	client = NULL;
>   	if (targaddr)
>   		*targaddr = NULL;
> -	addr_to_delete.len = 0;
> -	rwlock_rdlock(&rpcbaddr_cache_lock);
> -	ad_cache = NULL;
> -
> -	if (host != NULL)
> -		ad_cache = check_cache(host, nconf->nc_netid);
> -	if (ad_cache != NULL) {
> -		addr = ad_cache->ac_taddr;
> -		client = clnt_tli_create(RPC_ANYFD, nconf, addr,
> -		    (rpcprog_t)RPCBPROG, (rpcvers_t)RPCBVERS4, 0, 0);
> -		if (client != NULL) {
> -			if (targaddr && ad_cache->ac_uaddr)
> -				*targaddr = strdup(ad_cache->ac_uaddr);
> -			rwlock_unlock(&rpcbaddr_cache_lock);
> -			return (client);
> -		}
> -		addr_to_delete.len = addr->len;
> -		addr_to_delete.buf = (char *)malloc(addr->len);
> -		if (addr_to_delete.buf == NULL) {
> -			addr_to_delete.len = 0;
> -		} else {
> -			memcpy(addr_to_delete.buf, addr->buf, addr->len);
> +
> +	if (host != NULL)  {
> +		struct address_cache *ad_cache;
> +
> +		/* Get an MT-safe copy of the cached address (if any) */
> +		ad_cache = copy_of_cached(host, nconf->nc_netid);
> +		if (ad_cache != NULL) {
> +			client = clnt_tli_create(RPC_ANYFD, nconf, ad_cache->ac_taddr,
> +							(rpcprog_t)RPCBPROG, (rpcvers_t)RPCBVERS4, 0, 0);
> +			if (client != NULL) {
> +				if (targaddr && ad_cache->ac_uaddr) {
> +					*targaddr = ad_cache->ac_uaddr;
> +					ad_cache->ac_uaddr = NULL; /* De-reference before destruction */
> +				}
> +				destroy_addr(ad_cache);
> +				return (client);
> +			}
> +
> +			delete_cache(ad_cache->ac_taddr);
> +			destroy_addr(ad_cache);
>   		}
>   	}
> -	rwlock_unlock(&rpcbaddr_cache_lock);
> -	if (addr_to_delete.len != 0) {
> -		/*
> -		 * Assume this may be due to cache data being
> -		 *  outdated
> -		 */
> -		rwlock_wrlock(&rpcbaddr_cache_lock);
> -		delete_cache(&addr_to_delete);
> -		rwlock_unlock(&rpcbaddr_cache_lock);
> -		free(addr_to_delete.buf);
> -	}
> +
>   	if (!__rpc_nconf2sockinfo(nconf, &si)) {
>   		rpc_createerr.cf_stat = RPC_UNKNOWNPROTO;
>   		assert(client == NULL);

