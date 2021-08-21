Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5653F3BA7
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Aug 2021 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhHURWi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Aug 2021 13:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhHURWh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Aug 2021 13:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629566517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BnNXf1ko3bc5HF1intlLZUQDkdw0Ps+Gqq7aocL/BE=;
        b=FbI/grLrp0kLUpv2qH/DZJ22AGpEDcRJtm0Ixr9Qy4fScFMcyNeNAz7d6wiga5T8dPQsje
        I2h6ODCTGS44KmnwZPv8+NNUJRk/oVTlbxaqtXq0FTXEZ9sMricJHRPO9SrZgNpEV/caJX
        QootEqzqYbURhERx6RqYRiva3soh+4Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-TOGuMWUmMqeHszKltKRIvA-1; Sat, 21 Aug 2021 13:21:56 -0400
X-MC-Unique: TOGuMWUmMqeHszKltKRIvA-1
Received: by mail-qv1-f69.google.com with SMTP id u6-20020ad448660000b02903500bf28866so9104433qvy.23
        for <linux-nfs@vger.kernel.org>; Sat, 21 Aug 2021 10:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+BnNXf1ko3bc5HF1intlLZUQDkdw0Ps+Gqq7aocL/BE=;
        b=HEmcG2J1pkIpF5/hkLxXkXHPeZBcVZXkKPdhaSIaCljl8hkLls2EvOTNzopqG0/R+i
         aOYPlxgESfNE9cqWDGqxIwyePbdRxZoZm2JgySKpvy0OY2auOgIgluJKc/w3FmzaQExY
         vqIYuWX94NK40PmhQ3NYXEGtJ+ASCZCjYa3OnN9pSXCaeTleB5JY1gqnCCg3F4CNw8Xj
         zxzwnsg5jc8xSkqi6R9FIJGBb06EPkIBehYdm5yaBeUyiScTQTliKRMWh4kfnVTTKF/e
         0EAHcm7PxkDiyAsn4237jWcZB0yvoMlxH6T46iyoh0shDBvIVfJwSbjtP8AZW85QfajH
         xvcA==
X-Gm-Message-State: AOAM530onK7B4K6wFGFOPs7QEOw91KtReEVvByMAoI0sy+7/HZq0ReIp
        1gLYiSs0Hd5AY4asbEELYQSEjCMud9Mxq4OXgrHLqiWA+VeUpy6h5QqrE5Z6kh/2FOZLgiNtO6H
        PUiH6PP0voFgCT2HU/o+F
X-Received: by 2002:ac8:e02:: with SMTP id a2mr23226435qti.318.1629566515631;
        Sat, 21 Aug 2021 10:21:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGaJJ5w2/GSPlms76o4FeRl+ND1B+yoFLcDIsK+T4n5vpEglipBRzcvHSHf1MkR4wpk/5nsQ==
X-Received: by 2002:ac8:e02:: with SMTP id a2mr23226390qti.318.1629566514943;
        Sat, 21 Aug 2021 10:21:54 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.89.127])
        by smtp.gmail.com with ESMTPSA id p1sm3468266qkh.115.2021.08.21.10.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 10:21:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] Fix DoS vulnerability in libtirpc
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, kukuk@thkukuk.de
References: <20210811000818.95985-1-dai.ngo@oracle.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <60a85905-8ecd-a467-97ea-f7dd58241aee@redhat.com>
Date:   Sat, 21 Aug 2021 13:21:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811000818.95985-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/10/21 8:08 PM, Dai Ngo wrote:
> Currently svc_run does not handle poll timeout and rendezvous_request
> does not handle EMFILE error returned from accept(2 as it used to.
> These two missing functionality were removed by commit b2c9430f46c4.
> 
> The effect of not handling poll timeout allows idle TCP conections
> to remain ESTABLISHED indefinitely. When the number of connections
> reaches the limit of the open file descriptors (ulimit -n) then
> accept(2) fails with EMFILE. Since there is no handling of EMFILE
> error this causes svc_run() to get in a tight loop calling accept(2).
> This resulting in the RPC service of svc_run is being down, it's
> no longer able to service any requests.
> 
> if [ $# -ne 3 ]; then
>          echo "$0: server dst_port conn_cnt"
>          exit
> fi
> server=$1
> dport=$2
> conn_cnt=$3
> echo "dport[$dport] server[$server] conn_cnt[$conn_cnt]"
> 
> pcnt=0
> while [ $pcnt -lt $conn_cnt ]
> do
>          nc -v --recv-only $server $dport &
>          pcnt=`expr $pcnt + 1`
> done
> 
> RPC service rpcbind, statd and mountd are effected by this
> problem.
> 
> Fix by enhancing rendezvous_request to keep the number of
> SVCXPRT conections to 4/5 of the size of the file descriptor
> table. When this thresold is reached, it destroys the idle
> TCP connections or destroys the least active connection if
> no idle connnction was found.
> 
> Fixes: 44bf15b8 rpcbind: don't use obsolete svc_fdset interface of libtirpc
> Signed-off-by: dai.ngo@oracle.com
Committed... (tag: libtirpc-1-3-3-rc1)

steved.
> ---
>   src/svc.c    | 17 +++++++++++++-
>   src/svc_vc.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/src/svc.c b/src/svc.c
> index 6db164bbd76b..3a8709fe375c 100644
> --- a/src/svc.c
> +++ b/src/svc.c
> @@ -57,7 +57,7 @@
>   
>   #define max(a, b) (a > b ? a : b)
>   
> -static SVCXPRT **__svc_xports;
> +SVCXPRT **__svc_xports;
>   int __svc_maxrec;
>   
>   /*
> @@ -194,6 +194,21 @@ __xprt_do_unregister (xprt, dolock)
>       rwlock_unlock (&svc_fd_lock);
>   }
>   
> +int
> +svc_open_fds()
> +{
> +	int ix;
> +	int nfds = 0;
> +
> +	rwlock_rdlock (&svc_fd_lock);
> +	for (ix = 0; ix < svc_max_pollfd; ++ix) {
> +		if (svc_pollfd[ix].fd != -1)
> +			nfds++;
> +	}
> +	rwlock_unlock (&svc_fd_lock);
> +	return (nfds);
> +}
> +
>   /*
>    * Add a service program to the callout list.
>    * The dispatch routine will be called when a rpc request for this
> diff --git a/src/svc_vc.c b/src/svc_vc.c
> index f1d9f001fcdc..3dc8a75787e1 100644
> --- a/src/svc_vc.c
> +++ b/src/svc_vc.c
> @@ -64,6 +64,8 @@
>   
>   
>   extern rwlock_t svc_fd_lock;
> +extern SVCXPRT **__svc_xports;
> +extern int svc_open_fds();
>   
>   static SVCXPRT *makefd_xprt(int, u_int, u_int);
>   static bool_t rendezvous_request(SVCXPRT *, struct rpc_msg *);
> @@ -82,6 +84,7 @@ static void svc_vc_ops(SVCXPRT *);
>   static bool_t svc_vc_control(SVCXPRT *xprt, const u_int rq, void *in);
>   static bool_t svc_vc_rendezvous_control (SVCXPRT *xprt, const u_int rq,
>   				   	     void *in);
> +static int __svc_destroy_idle(int timeout);
>   
>   struct cf_rendezvous { /* kept in xprt->xp_p1 for rendezvouser */
>   	u_int sendsize;
> @@ -313,13 +316,14 @@ done:
>   	return (xprt);
>   }
>   
> +
>   /*ARGSUSED*/
>   static bool_t
>   rendezvous_request(xprt, msg)
>   	SVCXPRT *xprt;
>   	struct rpc_msg *msg;
>   {
> -	int sock, flags;
> +	int sock, flags, nfds, cnt;
>   	struct cf_rendezvous *r;
>   	struct cf_conn *cd;
>   	struct sockaddr_storage addr;
> @@ -379,6 +383,16 @@ again:
>   
>   	gettimeofday(&cd->last_recv_time, NULL);
>   
> +	nfds = svc_open_fds();
> +	if (nfds >= (_rpc_dtablesize() / 5) * 4) {
> +		/* destroy idle connections */
> +		cnt = __svc_destroy_idle(15);
> +		if (cnt == 0) {
> +			/* destroy least active */
> +			__svc_destroy_idle(0);
> +		}
> +	}
> +
>   	return (FALSE); /* there is never an rpc msg to be processed */
>   }
>   
> @@ -820,3 +834,49 @@ __svc_clean_idle(fd_set *fds, int timeout, bool_t cleanblock)
>   {
>   	return FALSE;
>   }
> +
> +static int
> +__svc_destroy_idle(int timeout)
> +{
> +	int i, ncleaned = 0;
> +	SVCXPRT *xprt, *least_active;
> +	struct timeval tv, tdiff, tmax;
> +	struct cf_conn *cd;
> +
> +	gettimeofday(&tv, NULL);
> +	tmax.tv_sec = tmax.tv_usec = 0;
> +	least_active = NULL;
> +	rwlock_wrlock(&svc_fd_lock);
> +
> +	for (i = 0; i <= svc_max_pollfd; i++) {
> +		if (svc_pollfd[i].fd == -1)
> +			continue;
> +		xprt = __svc_xports[i];
> +		if (xprt == NULL || xprt->xp_ops == NULL ||
> +			xprt->xp_ops->xp_recv != svc_vc_recv)
> +			continue;
> +		cd = (struct cf_conn *)xprt->xp_p1;
> +		if (!cd->nonblock)
> +			continue;
> +		if (timeout == 0) {
> +			timersub(&tv, &cd->last_recv_time, &tdiff);
> +			if (timercmp(&tdiff, &tmax, >)) {
> +				tmax = tdiff;
> +				least_active = xprt;
> +			}
> +			continue;
> +		}
> +		if (tv.tv_sec - cd->last_recv_time.tv_sec > timeout) {
> +			__xprt_unregister_unlocked(xprt);
> +			__svc_vc_dodestroy(xprt);
> +			ncleaned++;
> +		}
> +	}
> +	if (timeout == 0 && least_active != NULL) {
> +		__xprt_unregister_unlocked(least_active);
> +		__svc_vc_dodestroy(least_active);
> +		ncleaned++;
> +	}
> +	rwlock_unlock(&svc_fd_lock);
> +	return (ncleaned);
> +}
> 

