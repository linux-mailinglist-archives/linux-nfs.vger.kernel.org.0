Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9F583FC1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiG1NQq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiG1NQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 09:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16A7423153
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659014203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkkWqMzEggqJmj9GuqQggR351imMBfW2Vuq05/tvffo=;
        b=OfWO8lFxmkVRKMqKVv0WUShqqQFkpmICHGT30HsXCQcrtgml/Qmwpy5voD45bZvQ17ZZ5y
        FVzcQC+FAnq/xULLfgVr292S+5g2UXNB5mOE4171XcRfk74nwZDt5kapDLmithoMF1cbu9
        w4QmuYnAkWKEuCE7aQ8xuttGHZSMl5Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619--zrNjSbcMvGvogzBS60SSA-1; Thu, 28 Jul 2022 09:16:39 -0400
X-MC-Unique: -zrNjSbcMvGvogzBS60SSA-1
Received: by mail-qv1-f71.google.com with SMTP id kk14-20020a056214508e00b00474530e8d3cso1289505qvb.21
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tkkWqMzEggqJmj9GuqQggR351imMBfW2Vuq05/tvffo=;
        b=3gRhMfCHoXLoQA5M8tC+qT/MdpcY/4RB48M3ZvcXsseA2puH+zuUvq+0a5GkMtOqdS
         MOCPq+qRhIPKGRIuDAntyOFs2OHRerpbgT3JWXKkuYnJQD+093NOA8+QOl1iyGX0jdsn
         b8tJVYpjYd9RWfP0FVApZLdLtFPRNzyrfIJA3SdxsuRcQ2NH1Gn7Mm2U+FR4tBd5Ysz2
         rpInNfvxI/mnG3QE3JwyOZNUh++EbF6vG3IcHLYzv8jUxiLl9dShlH8L9tZVYSPP8b5U
         ktKq7cNvmJhZRL0AMUjiHOhu/a/edx1M9LdkHlt2eTZr6asI9I2UJgqOhIglkzKYm7e0
         GQRw==
X-Gm-Message-State: AJIora/mcdJUYSlUUmlpGCl8KXrW9SvZX6W0dJxBkhF/dzuzZam/Et4I
        7b8HdYSGL2xn/8U1ywnc+F2Q6LaSsMaRtX8L1HVf6O33jPdPv+9jOqYA98yKIahH/tk9flRVb6S
        em7Ap8Z7abFzh59lWlz2S
X-Received: by 2002:a05:622a:1193:b0:31f:33c:ad8 with SMTP id m19-20020a05622a119300b0031f033c0ad8mr22559559qtk.313.1659014198403;
        Thu, 28 Jul 2022 06:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uVLjrM3iXYfg6LmgXuiKet2zb9CiTM9I3cWZO+deSfb4NUYiSQ8Iwf+0nD8hSUIs7xgP45Zw==
X-Received: by 2002:a05:622a:1193:b0:31f:33c:ad8 with SMTP id m19-20020a05622a119300b0031f033c0ad8mr22559540qtk.313.1659014198119;
        Thu, 28 Jul 2022 06:16:38 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.154.36])
        by smtp.gmail.com with ESMTPSA id dm26-20020a05620a1d5a00b006af147d4876sm519425qkb.30.2022.07.28.06.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:16:37 -0700 (PDT)
Message-ID: <d5c47d35-91b1-0d57-34bf-b848aa15c562@redhat.com>
Date:   Thu, 28 Jul 2022 09:16:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Eliminate deadlocks in connects with an MT environment
Content-Language: en-US
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>,
        Libtirpc-devel Mailing List 
        <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220720212057.43986-1-attila.kovacs@cfa.harvard.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220720212057.43986-1-attila.kovacs@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/20/22 5:20 PM, Attila Kovacs wrote:
> In cnlt_dg_freeres() and clnt_vc_freeres(), cond_signal() is called after
> unlocking the mutex (clnt_fd_lock). The manual of pthread_cond_signal()
> allows that, but mentions that for consistent scheduling, cond_signal()
> should be called with the waiting mutex locked.
> 
> clnt_fd_lock is locked on L171, but then not released if jumping to the
> err1 label on an error (L175 and L180). This means that those errors
> will deadlock all further operations that require clnt_fd_lock access.
> 
> Same in clnt_vc.c in clnt_vc_create, on lines 215, 222, and 230 respectively.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed (tag: libtirpc-1-3-3-rc4)

steved.

> ---
> [Reposting Attila's patch with the proper Signed-off-by and format]
> 
>   src/clnt_dg.c |  9 ++++++---
>   src/clnt_vc.c | 12 ++++++++----
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/src/clnt_dg.c b/src/clnt_dg.c
> index b3d82e7..7c5d22e 100644
> --- a/src/clnt_dg.c
> +++ b/src/clnt_dg.c
> @@ -101,9 +101,9 @@ extern mutex_t clnt_fd_lock;
>   #define	release_fd_lock(fd_lock, mask) {	\
>   	mutex_lock(&clnt_fd_lock);	\
>   	fd_lock->active = FALSE;	\
> -	mutex_unlock(&clnt_fd_lock);	\
>   	thr_sigsetmask(SIG_SETMASK, &(mask), NULL); \
>   	cond_signal(&fd_lock->cv);	\
> +	mutex_unlock(&clnt_fd_lock);    \
>   }
>   
>   static const char mem_err_clnt_dg[] = "clnt_dg_create: out of memory";
> @@ -172,12 +172,15 @@ clnt_dg_create(fd, svcaddr, program, version, sendsz, recvsz)
>   	if (dg_fd_locks == (fd_locks_t *) NULL) {
>   		dg_fd_locks = fd_locks_init();
>   		if (dg_fd_locks == (fd_locks_t *) NULL) {
> +			mutex_unlock(&clnt_fd_lock);
>   			goto err1;
>   		}
>   	}
>   	fd_lock = fd_lock_create(fd, dg_fd_locks);
> -	if (fd_lock == (fd_lock_t *) NULL)
> +	if (fd_lock == (fd_lock_t *) NULL) {
> +		mutex_unlock(&clnt_fd_lock);
>   		goto err1;
> +	}
>   
>   	mutex_unlock(&clnt_fd_lock);
>   	thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
> @@ -573,9 +576,9 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
>   	cu->cu_fd_lock->active = TRUE;
>   	xdrs->x_op = XDR_FREE;
>   	dummy = (*xdr_res)(xdrs, res_ptr);
> -	mutex_unlock(&clnt_fd_lock);
>   	thr_sigsetmask(SIG_SETMASK, &mask, NULL);
>   	cond_signal(&cu->cu_fd_lock->cv);
> +	mutex_unlock(&clnt_fd_lock);
>   	return (dummy);
>   }
>   
> diff --git a/src/clnt_vc.c b/src/clnt_vc.c
> index a07e297..3c73e65 100644
> --- a/src/clnt_vc.c
> +++ b/src/clnt_vc.c
> @@ -153,9 +153,9 @@ extern mutex_t  clnt_fd_lock;
>   #define release_fd_lock(fd_lock, mask) {	\
>   	mutex_lock(&clnt_fd_lock);	\
>   	fd_lock->active = FALSE;	\
> -	mutex_unlock(&clnt_fd_lock);	\
>   	thr_sigsetmask(SIG_SETMASK, &(mask), (sigset_t *) NULL);	\
>   	cond_signal(&fd_lock->cv);	\
> +	mutex_unlock(&clnt_fd_lock);    \
>   }
>   
>   static const char clnt_vc_errstr[] = "%s : %s";
> @@ -216,7 +216,9 @@ clnt_vc_create(fd, raddr, prog, vers, sendsz, recvsz)
>   	if (vc_fd_locks == (fd_locks_t *) NULL) {
>   		vc_fd_locks = fd_locks_init();
>   		if (vc_fd_locks == (fd_locks_t *) NULL) {
> -			struct rpc_createerr *ce = &get_rpc_createerr();
> +			struct rpc_createerr *ce;
> +			mutex_unlock(&clnt_fd_lock);
> +			ce = &get_rpc_createerr();
>   			ce->cf_stat = RPC_SYSTEMERROR;
>   			ce->cf_error.re_errno = errno;
>   			goto err;
> @@ -224,7 +226,9 @@ clnt_vc_create(fd, raddr, prog, vers, sendsz, recvsz)
>   	}
>   	fd_lock = fd_lock_create(fd, vc_fd_locks);
>   	if (fd_lock == (fd_lock_t *) NULL) {
> -		struct rpc_createerr *ce = &get_rpc_createerr();
> +		struct rpc_createerr *ce;
> +		mutex_unlock(&clnt_fd_lock);
> +		ce = &get_rpc_createerr();
>   		ce->cf_stat = RPC_SYSTEMERROR;
>   		ce->cf_error.re_errno = errno;
>   		goto err;
> @@ -495,9 +499,9 @@ clnt_vc_freeres(cl, xdr_res, res_ptr)
>   		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
>   	xdrs->x_op = XDR_FREE;
>   	dummy = (*xdr_res)(xdrs, res_ptr);
> -	mutex_unlock(&clnt_fd_lock);
>   	thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
>   	cond_signal(&ct->ct_fd_lock->cv);
> +	mutex_unlock(&clnt_fd_lock);
>   
>   	return dummy;
>   }

