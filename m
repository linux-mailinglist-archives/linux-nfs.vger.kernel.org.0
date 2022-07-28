Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8A583FC4
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiG1NRc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiG1NRb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 09:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E8C4558D7
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659014247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/WJ6akfDNY172xd+VrmPWaOgJ/vjCXncbEmp+4i0Ko=;
        b=SfTSzM6+f5ibqNExusxNB9FHpNO4XFVnsa6WYL7e1P1TMfT7mYeaI9vf8o4bYBsfbXzvWe
        tQEniGmpkUug14Al7u+SWz5+So1BpdFn0qHy2FVgB81DDKUJV0h6g7S6SLKx/Q3q9s7rUC
        gJeE4xdbGmi+YC2HUfnPy4S9xBj5eAo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-qNF9xMQOPbCRgwJ4rHbnbQ-1; Thu, 28 Jul 2022 09:17:26 -0400
X-MC-Unique: qNF9xMQOPbCRgwJ4rHbnbQ-1
Received: by mail-qk1-f200.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so1425213qkp.20
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K/WJ6akfDNY172xd+VrmPWaOgJ/vjCXncbEmp+4i0Ko=;
        b=ztLrIhJ7TSO+sdxQkD2mJ+K9EPOWQdHZaWHupu1UrdXmkZaRVSEtXz+aKqhybn0TBn
         fkbZ37Nk3OGw3A9CU2T6aKyw9PVZXNdsBHu0Mz8i648ZlPzjbdgdoY9YbxkpKSwiPWH/
         FKwEn0XzZ+kPqc5tCbkx9ds3fnuOaCckwPk4ZUpc7V1EjnAyQGqdFxT93dTcpC1SF1wc
         AsWYxBL4Hkptv0fC1QIe99PyZLkKPdyOIXHShWi+wVpG2JFtmcZB8a94qRyML4VZi6/C
         W3TwjD0ooLJYO+YNVfBtJJdQu0vt0bS+JSXmz4SFsobPS4N5IXKLeUNJqLqtM3p/QLg1
         uJAA==
X-Gm-Message-State: AJIora+UJt/Ji1nT7/SODoV0fE4YIUPFM1MnjATXyX6EoOKf7GAqZQxg
        T1Cim2EUciMLsb8mIlfihIAO/WaBAKw/1tmrTNZRllyzP/tmjNjb26zDA+yzcUiA6ZP/CizJ1Zk
        Z90fF/8VkB6y7wtabElN+
X-Received: by 2002:a05:620a:2983:b0:6b5:e5f5:f2c5 with SMTP id r3-20020a05620a298300b006b5e5f5f2c5mr19897527qkp.138.1659014245656;
        Thu, 28 Jul 2022 06:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tEUE/XoJIt//Ucy22CYG8kXEGLJFtYSjo9KJoSiEg4QpZxwY8Ap0mJr24Rvi1z6lCcJjTVDw==
X-Received: by 2002:a05:620a:2983:b0:6b5:e5f5:f2c5 with SMTP id r3-20020a05620a298300b006b5e5f5f2c5mr19897503qkp.138.1659014245345;
        Thu, 28 Jul 2022 06:17:25 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.154.36])
        by smtp.gmail.com with ESMTPSA id bp8-20020a05620a458800b006a6a4b43c01sm541530qkb.38.2022.07.28.06.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:17:24 -0700 (PDT)
Message-ID: <0df0060b-3d74-441f-270b-d42d5cbdda31@redhat.com>
Date:   Thu, 28 Jul 2022 09:17:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] thread safe clnt destruction.
Content-Language: en-US
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>,
        Libtirpc-devel Mailing List 
        <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220726141906.69023-1-attila.kovacs@cfa.harvard.edu>
 <20220726141906.69023-2-attila.kovacs@cfa.harvard.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220726141906.69023-2-attila.kovacs@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/26/22 10:19 AM, Attila Kovacs wrote:
> From: Attila Kovacs <attipaci@gmail.com>
> 
> If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other blocked
> operations pending (such as clnt_*_call(), clnt_*_control(), or
> clnt_*_freeres()) but no active operation currently being executed, then the
> client gets destroyed. Then, as the other blocked operations get subsequently
> awoken, they will try operate on an invalid client handle, potentially causing
> unpredictable behavior and stack corruption.
> 
> Signed-off-by: Attila Kovacs <attipaci@gmail.com>
Committed (tag: libtirpc-1-3-3-rc4)

steved.
> ---
>   src/clnt_dg.c       | 13 ++++++++++++-
>   src/clnt_fd_locks.h |  2 ++
>   src/clnt_vc.c       | 13 ++++++++++++-
>   3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/src/clnt_dg.c b/src/clnt_dg.c
> index b2043ac..166af63 100644
> --- a/src/clnt_dg.c
> +++ b/src/clnt_dg.c
> @@ -101,6 +101,7 @@ extern mutex_t clnt_fd_lock;
>   #define	release_fd_lock(fd_lock, mask) {	\
>   	mutex_lock(&clnt_fd_lock);	\
>   	fd_lock->active = FALSE;	\
> +	fd_lock->pending--;		\
>   	thr_sigsetmask(SIG_SETMASK, &(mask), NULL); \
>   	cond_signal(&fd_lock->cv);	\
>   	mutex_unlock(&clnt_fd_lock);    \
> @@ -311,6 +312,7 @@ clnt_dg_call(cl, proc, xargs, argsp, xresults, resultsp, utimeout)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> +	cu->cu_fd_lock->pending++;
>   	while (cu->cu_fd_lock->active)
>   		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
>   	cu->cu_fd_lock->active = TRUE;
> @@ -571,10 +573,12 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> +	cu->cu_fd_lock->pending++;
>   	while (cu->cu_fd_lock->active)
>   		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
>   	xdrs->x_op = XDR_FREE;
>   	dummy = (*xdr_res)(xdrs, res_ptr);
> +	cu->cu_fd_lock->pending--;
>   	thr_sigsetmask(SIG_SETMASK, &mask, NULL);
>   	cond_signal(&cu->cu_fd_lock->cv);
>   	mutex_unlock(&clnt_fd_lock);
> @@ -602,6 +606,7 @@ clnt_dg_control(cl, request, info)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> +	cu->cu_fd_lock->pending++;
>   	while (cu->cu_fd_lock->active)
>   		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
>   	cu->cu_fd_lock->active = TRUE;
> @@ -742,8 +747,14 @@ clnt_dg_destroy(cl)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> -	while (cu_fd_lock->active)
> +	/* wait until all pending operations on client are completed. */
> +	while (cu_fd_lock->pending > 0) {
> +		/* If a blocked operation can be awakened, then do it. */
> +		if (cu_fd_lock->active == FALSE)
> +			cond_signal(&cu_fd_lock->cv);
> +		/* keep waiting... */
>   		cond_wait(&cu_fd_lock->cv, &clnt_fd_lock);
> +	}
>   	if (cu->cu_closeit)
>   		(void)close(cu_fd);
>   	XDR_DESTROY(&(cu->cu_outxdrs));
> diff --git a/src/clnt_fd_locks.h b/src/clnt_fd_locks.h
> index 359f995..6ba62cb 100644
> --- a/src/clnt_fd_locks.h
> +++ b/src/clnt_fd_locks.h
> @@ -50,6 +50,7 @@ static unsigned int fd_locks_prealloc = 0;
>   /* per-fd lock */
>   struct fd_lock_t {
>   	bool_t active;
> +	int pending;        /* Number of pending operations on fd */
>   	cond_t cv;
>   };
>   typedef struct fd_lock_t fd_lock_t;
> @@ -180,6 +181,7 @@ fd_lock_t* fd_lock_create(int fd, fd_locks_t *fd_locks) {
>   		item->fd = fd;
>   		item->refs = 1;
>   		item->fd_lock.active = FALSE;
> +		item->fd_lock.pending = 0;
>   		cond_init(&item->fd_lock.cv, 0, (void *) 0);
>   		TAILQ_INSERT_HEAD(list, item, link);
>   	} else {
> diff --git a/src/clnt_vc.c b/src/clnt_vc.c
> index 3c73e65..5bbc78b 100644
> --- a/src/clnt_vc.c
> +++ b/src/clnt_vc.c
> @@ -153,6 +153,7 @@ extern mutex_t  clnt_fd_lock;
>   #define release_fd_lock(fd_lock, mask) {	\
>   	mutex_lock(&clnt_fd_lock);	\
>   	fd_lock->active = FALSE;	\
> +	fd_lock->pending--;		\
>   	thr_sigsetmask(SIG_SETMASK, &(mask), (sigset_t *) NULL);	\
>   	cond_signal(&fd_lock->cv);	\
>   	mutex_unlock(&clnt_fd_lock);    \
> @@ -357,6 +358,7 @@ clnt_vc_call(cl, proc, xdr_args, args_ptr, xdr_results, results_ptr, timeout)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> +	ct->ct_fd_lock->pending++;
>   	while (ct->ct_fd_lock->active)
>   		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
>   	ct->ct_fd_lock->active = TRUE;
> @@ -495,10 +497,12 @@ clnt_vc_freeres(cl, xdr_res, res_ptr)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> +	ct->ct_fd_lock->pending++;
>   	while (ct->ct_fd_lock->active)
>   		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
>   	xdrs->x_op = XDR_FREE;
>   	dummy = (*xdr_res)(xdrs, res_ptr);
> +	ct->ct_fd_lock->pending--;
>   	thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
>   	cond_signal(&ct->ct_fd_lock->cv);
>   	mutex_unlock(&clnt_fd_lock);
> @@ -533,6 +537,7 @@ clnt_vc_control(cl, request, info)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> +	ct->ct_fd_lock->pending++;
>   	while (ct->ct_fd_lock->active)
>   		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
>   	ct->ct_fd_lock->active = TRUE;
> @@ -655,8 +660,14 @@ clnt_vc_destroy(cl)
>   	sigfillset(&newmask);
>   	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
>   	mutex_lock(&clnt_fd_lock);
> -	while (ct_fd_lock->active)
> +	/* wait until all pending operations on client are completed. */
> +	while (ct_fd_lock->pending > 0) {
> +		/* If a blocked operation can be awakened, then do it. */
> +		if (ct_fd_lock->active == FALSE)
> +			cond_signal(&ct_fd_lock->cv);
> +		/* keep waiting... */
>   		cond_wait(&ct_fd_lock->cv, &clnt_fd_lock);
> +	}
>   	if (ct->ct_closeit && ct->ct_fd != -1) {
>   		(void)close(ct->ct_fd);
>   	}

