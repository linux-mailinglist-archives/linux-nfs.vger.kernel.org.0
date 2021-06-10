Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3913A303E
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJQLr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 12:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhFJQLq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 12:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623341389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/yq4NHRCUn1RcLL3T5oawoSU8+O98wFBq/jul38KJ8=;
        b=dKpSUVXpqE8zu5ZxdUy5vGvb1StJuV7Nb0slxmiLdAwHhmz1VYnV/PY8wg8mK/upgtrnKM
        oAlSKJXywgY9E0NlCqX/Yl89QJ3VqC2xbzuHlE2AduzwrZUg+gUVSxZ3lEKZ/7d7NbqHJT
        6TtXt/BOEu3wrwEObpnyLL0F2DKo0y4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-as-wHcBhNgy60VL3eKH18A-1; Thu, 10 Jun 2021 12:09:48 -0400
X-MC-Unique: as-wHcBhNgy60VL3eKH18A-1
Received: by mail-qk1-f197.google.com with SMTP id r22-20020a37a8160000b02903ab435911daso1551228qke.20
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 09:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/yq4NHRCUn1RcLL3T5oawoSU8+O98wFBq/jul38KJ8=;
        b=Xqu1OnS3JCxe4JzouNNCQZyYONcJE1RPJcNbX+zG4Kkg/TUAjqECEdlgfxwUixpBVl
         0ZFvoJbFYBbOAy/t+9BHuzwuC+VQ2pxbJhuTlKHjNa//yeIc+dzdsHdq6zTtxKp4Nte5
         ZW/kAbRGiFmdrzPjim68QijpOj2JS7QUu9byrU8mlBKccb/8feSrCjr8rp2ggxLLkFHo
         LgGjl1g5CUi9nv3U3hVbA46eW24/rGMMzucAV+xlFIdkAVHTwrFMWIFQYJv9b/NjXMii
         V5zqvelG3ECCXigjPAol603nVxrMXp/WWYuRmS51/SpU5sEbYjvUkIxGUogim6sD2dEL
         f6lQ==
X-Gm-Message-State: AOAM533ht0W1MN3QwKl/LQKSsaPlzH3PHhaNIVrZFIbU6vxImLOPx6nD
        altPlb6e3CHG6Zv8m7ujJrPE7gW3z7rRlTViytpM0Ddr4dki69qU7m8EPBqWN0eB4wxY9TYpbZW
        gC4cMQPhx0ZhMv+veELce7SH74mK56QEqiYazcc3vT0hm/+X/lc5qmCUDZgsa+CNm/ORtDg==
X-Received: by 2002:ac8:5981:: with SMTP id e1mr359496qte.310.1623341387926;
        Thu, 10 Jun 2021 09:09:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyolnYd1zqt2ukf5If2BUT4H/ZkfFwqpyca3E5cwjfsx3U4h+VVl/TvDX21cz10lczrDTUFiQ==
X-Received: by 2002:ac8:5981:: with SMTP id e1mr359474qte.310.1623341387690;
        Thu, 10 Jun 2021 09:09:47 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id w28sm2508676qtt.88.2021.06.10.09.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:09:47 -0700 (PDT)
Subject: Re: [nfs-utils PATCH v3 1/2] gssd: deal with failed thread creation
To:     Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org
References: <20210527191102.590275-1-smayhew@redhat.com>
 <20210527191102.590275-2-smayhew@redhat.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <a86922c9-e74d-d004-bacc-81fe74d7db0b@redhat.com>
Date:   Thu, 10 Jun 2021 12:12:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210527191102.590275-2-smayhew@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/27/21 3:11 PM, Scott Mayhew wrote:
> If we fail to create a thread to handle an upcall, we still need to do a
> downcall to tell the kernel about the failure, otherwise the process
> that is trying to establish gss credentials will hang.
> 
> This patch shifts the thread creation down a level in the call chain so
> now the main thread does a little more work up front (reading & parsing
> the data from the pipefs file) so it has the info it needs to be able
> to do the error downcall.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-5-4-rc6)

steved.
> ---
>   utils/gssd/gssd.c      |  83 +-----------------
>   utils/gssd/gssd.h      |  11 ++-
>   utils/gssd/gssd_proc.c | 188 +++++++++++++++++++++++++++++++++--------
>   3 files changed, 164 insertions(+), 118 deletions(-)
> 
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 1541d371..eb440470 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -364,7 +364,7 @@ out:
>   /* Actually frees clp and fields that might be used from other
>    * threads if was last reference.
>    */
> -static void
> +void
>   gssd_free_client(struct clnt_info *clp)
>   {
>   	int refcnt;
> @@ -416,55 +416,6 @@ gssd_destroy_client(struct clnt_info *clp)
>   
>   static void gssd_scan(void);
>   
> -static int
> -start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> -{
> -	pthread_attr_t attr;
> -	pthread_t th;
> -	int ret;
> -
> -	ret = pthread_attr_init(&attr);
> -	if (ret != 0) {
> -		printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> -			 ret, strerror(errno));
> -		return ret;
> -	}
> -	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> -	if (ret != 0) {
> -		printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> -			 "%s\n", ret, strerror(errno));
> -		return ret;
> -	}
> -
> -	ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> -	if (ret != 0)
> -		printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> -			 ret, strerror(errno));
> -	return ret;
> -}
> -
> -static struct clnt_upcall_info *alloc_upcall_info(struct clnt_info *clp)
> -{
> -	struct clnt_upcall_info *info;
> -
> -	info = malloc(sizeof(struct clnt_upcall_info));
> -	if (info == NULL)
> -		return NULL;
> -
> -	pthread_mutex_lock(&clp_lock);
> -	clp->refcount++;
> -	pthread_mutex_unlock(&clp_lock);
> -	info->clp = clp;
> -
> -	return info;
> -}
> -
> -void free_upcall_info(struct clnt_upcall_info *info)
> -{
> -	gssd_free_client(info->clp);
> -	free(info);
> -}
> -
>   /* For each upcall read the upcall info into the buffer, then create a
>    * thread in a detached state so that resources are released back into
>    * the system without the need for a join.
> @@ -473,44 +424,16 @@ static void
>   gssd_clnt_gssd_cb(int UNUSED(fd), short UNUSED(which), void *data)
>   {
>   	struct clnt_info *clp = data;
> -	struct clnt_upcall_info *info;
> -
> -	info = alloc_upcall_info(clp);
> -	if (info == NULL)
> -		return;
>   
> -	info->lbuflen = read(clp->gssd_fd, info->lbuf, sizeof(info->lbuf));
> -	if (info->lbuflen <= 0 || info->lbuf[info->lbuflen-1] != '\n') {
> -		printerr(0, "WARNING: %s: failed reading request\n", __func__);
> -		free_upcall_info(info);
> -		return;
> -	}
> -	info->lbuf[info->lbuflen-1] = 0;
> -
> -	if (start_upcall_thread(handle_gssd_upcall, info))
> -		free_upcall_info(info);
> +	handle_gssd_upcall(clp);
>   }
>   
>   static void
>   gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(which), void *data)
>   {
>   	struct clnt_info *clp = data;
> -	struct clnt_upcall_info *info;
> -
> -	info = alloc_upcall_info(clp);
> -	if (info == NULL)
> -		return;
> -
> -	if (read(clp->krb5_fd, &info->uid,
> -			sizeof(info->uid)) < (ssize_t)sizeof(info->uid)) {
> -		printerr(0, "WARNING: %s: failed reading uid from krb5 "
> -			 "upcall pipe: %s\n", __func__, strerror(errno));
> -		free_upcall_info(info);
> -		return;
> -	}
>   
> -	if (start_upcall_thread(handle_krb5_upcall, info))
> -		free_upcall_info(info);
> +	handle_krb5_upcall(clp);
>   }
>   
>   static struct clnt_info *
> diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
> index 1e8c58d4..6d53647e 100644
> --- a/utils/gssd/gssd.h
> +++ b/utils/gssd/gssd.h
> @@ -84,14 +84,17 @@ struct clnt_info {
>   
>   struct clnt_upcall_info {
>   	struct clnt_info 	*clp;
> -	char			lbuf[RPC_CHAN_BUF_SIZE];
> -	int			lbuflen;
>   	uid_t			uid;
> +	int			fd;
> +	char			*srchost;
> +	char			*target;
> +	char			*service;
>   };
>   
> -void handle_krb5_upcall(struct clnt_upcall_info *clp);
> -void handle_gssd_upcall(struct clnt_upcall_info *clp);
> +void handle_krb5_upcall(struct clnt_info *clp);
> +void handle_gssd_upcall(struct clnt_info *clp);
>   void free_upcall_info(struct clnt_upcall_info *info);
> +void gssd_free_client(struct clnt_info *clp);
>   
>   
>   #endif /* _RPC_GSSD_H_ */
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index e830f497..ebec414e 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -80,6 +80,8 @@
>   #include "nfslib.h"
>   #include "gss_names.h"
>   
> +extern pthread_mutex_t clp_lock;
> +
>   /* Encryption types supported by the kernel rpcsec_gss code */
>   int num_krb5_enctypes = 0;
>   krb5_enctype *krb5_enctypes = NULL;
> @@ -723,22 +725,133 @@ out_return_error:
>   	goto out;
>   }
>   
> -void
> -handle_krb5_upcall(struct clnt_upcall_info *info)
> +static struct clnt_upcall_info *
> +alloc_upcall_info(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
> +		  char *target, char *service)
>   {
> -	struct clnt_info *clp = info->clp;
> +	struct clnt_upcall_info *info;
> +
> +	info = malloc(sizeof(struct clnt_upcall_info));
> +	if (info == NULL)
> +		return NULL;
> +
> +	memset(info, 0, sizeof(*info));
> +	pthread_mutex_lock(&clp_lock);
> +	clp->refcount++;
> +	pthread_mutex_unlock(&clp_lock);
> +	info->clp = clp;
> +	info->uid = uid;
> +	info->fd = fd;
> +	if (srchost) {
> +		info->srchost = strdup(srchost);
> +		if (info->srchost == NULL)
> +			goto out_info;
> +	}
> +	if (target) {
> +		info->target = strdup(target);
> +		if (info->target == NULL)
> +			goto out_srchost;
> +	}
> +	if (service) {
> +		info->service = strdup(service);
> +		if (info->service == NULL)
> +			goto out_target;
> +	}
> +
> +out:
> +	return info;
> +
> +out_target:
> +	if (info->target)
> +		free(info->target);
> +out_srchost:
> +	if (info->srchost)
> +		free(info->srchost);
> +out_info:
> +	free(info);
> +	info = NULL;
> +	goto out;
> +}
>   
> -	printerr(2, "\n%s: uid %d (%s)\n", __func__, info->uid, clp->relpath);
> +void free_upcall_info(struct clnt_upcall_info *info)
> +{
> +	gssd_free_client(info->clp);
> +	if (info->service)
> +		free(info->service);
> +	if (info->target)
> +		free(info->target);
> +	if (info->srchost)
> +		free(info->srchost);
> +	free(info);
> +}
>   
> -	process_krb5_upcall(clp, info->uid, clp->krb5_fd, NULL, NULL, NULL);
> +static void
> +gssd_work_thread_fn(struct clnt_upcall_info *info)
> +{
> +	process_krb5_upcall(info->clp, info->uid, info->fd, info->srchost, info->target, info->service);
>   	free_upcall_info(info);
>   }
>   
> +static int
> +start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info)
> +{
> +	pthread_attr_t attr;
> +	pthread_t th;
> +	int ret;
> +
> +	ret = pthread_attr_init(&attr);
> +	if (ret != 0) {
> +		printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
> +			 ret, strerror(errno));
> +		return ret;
> +	}
> +	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> +	if (ret != 0) {
> +		printerr(0, "ERROR: failed to create pthread attr: ret %d: "
> +			 "%s\n", ret, strerror(errno));
> +		return ret;
> +	}
> +
> +	ret = pthread_create(&th, &attr, (void *)func, (void *)info);
> +	if (ret != 0)
> +		printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
> +			 ret, strerror(errno));
> +	return ret;
> +}
> +
> +void
> +handle_krb5_upcall(struct clnt_info *clp)
> +{
> +	uid_t			uid;
> +	struct clnt_upcall_info	*info;
> +	int			err;
> +
> +	if (read(clp->krb5_fd, &uid, sizeof(uid)) < (ssize_t)sizeof(uid)) {
> +		printerr(0, "WARNING: failed reading uid from krb5 "
> +			    "upcall pipe: %s\n", strerror(errno));
> +		return;
> +	}
> +	printerr(2, "\n%s: uid %d (%s)\n", __func__, uid, clp->relpath);
> +
> +	info = alloc_upcall_info(clp, uid, clp->krb5_fd, NULL, NULL, NULL);
> +	if (info == NULL) {
> +		printerr(0, "%s: failed to allocate clnt_upcall_info\n", __func__);
> +		do_error_downcall(clp->krb5_fd, uid, -EACCES);
> +		return;
> +	}
> +	err = start_upcall_thread(gssd_work_thread_fn, info);
> +	if (err != 0) {
> +		do_error_downcall(clp->krb5_fd, uid, -EACCES);
> +		free_upcall_info(info);
> +	}
> +}
> +
>   void
> -handle_gssd_upcall(struct clnt_upcall_info *info)
> +handle_gssd_upcall(struct clnt_info *clp)
>   {
> -	struct clnt_info	*clp = info->clp;
>   	uid_t			uid;
> +	char			lbuf[RPC_CHAN_BUF_SIZE];
> +	int			lbuflen = 0;
>   	char			*p;
>   	char			*mech = NULL;
>   	char			*uidstr = NULL;
> @@ -746,20 +859,22 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>   	char			*service = NULL;
>   	char			*srchost = NULL;
>   	char			*enctypes = NULL;
> -	char			*upcall_str;
> -	char			*pbuf = info->lbuf;
>   	pthread_t tid = pthread_self();
> +	struct clnt_upcall_info	*info;
> +	int			err;
>   
> -	printerr(2, "\n%s(0x%x): '%s' (%s)\n", __func__, tid,
> -		info->lbuf, clp->relpath);
> -
> -	upcall_str = strdup(info->lbuf);
> -	if (upcall_str == NULL) {
> -		printerr(0, "ERROR: malloc failure\n");
> -		goto out_nomem;
> +	lbuflen = read(clp->gssd_fd, lbuf, sizeof(lbuf));
> +	if (lbuflen <= 0 || lbuf[lbuflen-1] != '\n') {
> +		printerr(0, "WARNING: handle_gssd_upcall: "
> +			    "failed reading request\n");
> +		return;
>   	}
> +	lbuf[lbuflen-1] = 0;
> +
> +	printerr(2, "\n%s(0x%x): '%s' (%s)\n", __func__, tid,
> +		 lbuf, clp->relpath);
>   
> -	while ((p = strsep(&pbuf, " "))) {
> +	for (p = strtok(lbuf, " "); p; p = strtok(NULL, " ")) {
>   		if (!strncmp(p, "mech=", strlen("mech=")))
>   			mech = p + strlen("mech=");
>   		else if (!strncmp(p, "uid=", strlen("uid=")))
> @@ -777,8 +892,8 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>   	if (!mech || strlen(mech) < 1) {
>   		printerr(0, "WARNING: handle_gssd_upcall: "
>   			    "failed to find gss mechanism name "
> -			    "in upcall string '%s'\n", upcall_str);
> -		goto out;
> +			    "in upcall string '%s'\n", lbuf);
> +		return;
>   	}
>   
>   	if (uidstr) {
> @@ -790,21 +905,21 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>   	if (!uidstr) {
>   		printerr(0, "WARNING: handle_gssd_upcall: "
>   			    "failed to find uid "
> -			    "in upcall string '%s'\n", upcall_str);
> -		goto out;
> +			    "in upcall string '%s'\n", lbuf);
> +		return;
>   	}
>   
>   	if (enctypes && parse_enctypes(enctypes) != 0) {
>   		printerr(0, "WARNING: handle_gssd_upcall: "
>   			 "parsing encryption types failed: errno %d\n", errno);
> -		goto out;
> +		return;
>   	}
>   
>   	if (target && strlen(target) < 1) {
>   		printerr(0, "WARNING: handle_gssd_upcall: "
>   			 "failed to parse target name "
> -			 "in upcall string '%s'\n", upcall_str);
> -		goto out;
> +			 "in upcall string '%s'\n", lbuf);
> +		return;
>   	}
>   
>   	/*
> @@ -818,21 +933,26 @@ handle_gssd_upcall(struct clnt_upcall_info *info)
>   	if (service && strlen(service) < 1) {
>   		printerr(0, "WARNING: handle_gssd_upcall: "
>   			 "failed to parse service type "
> -			 "in upcall string '%s'\n", upcall_str);
> -		goto out;
> +			 "in upcall string '%s'\n", lbuf);
> +		return;
>   	}
>   
> -	if (strcmp(mech, "krb5") == 0 && clp->servername)
> -		process_krb5_upcall(clp, uid, clp->gssd_fd, srchost, target, service);
> -	else {
> +	if (strcmp(mech, "krb5") == 0 && clp->servername) {
> +		info = alloc_upcall_info(clp, uid, clp->gssd_fd, srchost, target, service);
> +		if (info == NULL) {
> +			printerr(0, "%s: failed to allocate clnt_upcall_info\n", __func__);
> +			do_error_downcall(clp->gssd_fd, uid, -EACCES);
> +			return;
> +		}
> +		err = start_upcall_thread(gssd_work_thread_fn, info);
> +		if (err != 0) {
> +			do_error_downcall(clp->gssd_fd, uid, -EACCES);
> +			free_upcall_info(info);
> +		}
> +	} else {
>   		if (clp->servername)
>   			printerr(0, "WARNING: handle_gssd_upcall: "
>   				 "received unknown gss mech '%s'\n", mech);
>   		do_error_downcall(clp->gssd_fd, uid, -EACCES);
>   	}
> -out:
> -	free(upcall_str);
> -out_nomem:
> -	free_upcall_info(info);
> -	return;
>   }
> 

