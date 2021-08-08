Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8A3E3BBC
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Aug 2021 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhHHQ5L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 12:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbhHHQ5L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 12:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628441811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUjm5b2WVh3HOndoK2eIxnCtlMoxDy6C//Fd6bC4cWQ=;
        b=fvTxg/A1vlKJC63TnaUN04JlrKi1TAqY/IpS9BE9TgQKA7sEawUXlWWkUiedD8JqmXSXWq
        9RV3gshcKY8evxvy0PMGdfSlclTb2jIRzVzcwYCIPyW2Bof9eYxMjlqDV7osI8VcOz1hjA
        Co3tvbDA80yaYH9zc91kobnYWwJ0mxM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-qopMZW6hNh-lBad1wibaAw-1; Sun, 08 Aug 2021 12:56:50 -0400
X-MC-Unique: qopMZW6hNh-lBad1wibaAw-1
Received: by mail-qt1-f197.google.com with SMTP id 7-20020ac856070000b0290292921115ecso805996qtr.6
        for <linux-nfs@vger.kernel.org>; Sun, 08 Aug 2021 09:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUjm5b2WVh3HOndoK2eIxnCtlMoxDy6C//Fd6bC4cWQ=;
        b=QhlzNbgfrPBux6i5DDmeheGmTSq5HL41tnWNtddlcgcMpVoebe0d6k3fExwlKLBu5m
         s0rolmMy88Gyh1LlS1/pBw0BTRcsVPngXN8BLeV4lcrwXRGKnxcOZ9lkUuVAATlXprkI
         q7Ng1dOrpen6sUlVYGsi982bQZjDMzWXFKqzLMeG0fZFQO1UIbrxNC34vSWr61+TR2dg
         uGDYpGyK8ZAxGuft2+f7NPUplu6cmYZQGfrt4/8ZMh5bmDW+LaCch/jIzGPiD2obZrCP
         /E2pdRHGqYhfo3Jstc1yQ5s3sAq1UvB4lC7emVR7cO45C085ZgZOKJ7X5J1jZcV7etDK
         nmkQ==
X-Gm-Message-State: AOAM532jdboTSH7EulOhkJH69H3BunExqRrwElJEhMjfZPrD7Vnebk8v
        A7fR3zXNrMTJ3nKo1KjWQbRiAQ1j8jgoggvET5O/GJol+5ZT/DWq17/zEwV8pSKbPE3VGHxoEeM
        mdnicRXCPBlHfp8qa2Vcb
X-Received: by 2002:ad4:594f:: with SMTP id eo15mr9286211qvb.60.1628441810046;
        Sun, 08 Aug 2021 09:56:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV//VtvHRaJzQtzDb3umtLu3g08+qAAY+W/fQDJS+hWDsTx8HIhvB3eOzpyQY0+KWoyW02EQ==
X-Received: by 2002:ad4:594f:: with SMTP id eo15mr9286200qvb.60.1628441809879;
        Sun, 08 Aug 2021 09:56:49 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id n20sm5738925qkk.9.2021.08.08.09.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 09:56:49 -0700 (PDT)
Subject: Re: [Libtirpc-devel] [PATCH 1/1] Fix DoS vulnerability in statd and
 mountd
To:     Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Cc:     libtirpc-devel@lists.sourceforge.net,
        Florian Weimer <fweimer@redhat.com>
References: <20210807170248.68817-1-dai.ngo@oracle.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <5d67875a-05bc-df80-3971-e8bde9b588b8@redhat.com>
Date:   Sun, 8 Aug 2021 12:56:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807170248.68817-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 8/7/21 1:02 PM, Dai Ngo wrote:
> Currently my_svc_run does not handle poll time allowing idle TCP
> connections to remain ESTABLISHED indefinitely. When the number
> of connections reaches the limit the open file descriptors
> (ulimit -n) then accept(2) fails with EMFILE. Since libtirpc does
> not handle EMFILE returned from accept(2) this get my_svc_run into
> a tight loop calling accept(2) resulting in the RPC service being
> down, it's no longer able to service any requests.
> 
> Fix by removing idle connections when select(2) times out in my_svc_run
> and when open(2) returns EMFILE/ENFILE in auth_reload.
> 
> Signed-off-by: dai.ngo@oracle.com
> ---
>   support/export/auth.c  | 12 ++++++++++--
>   utils/mountd/svc_run.c | 10 ++++++++--
>   utils/statd/svc_run.c  | 11 ++++++++---
>   3 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/support/export/auth.c b/support/export/auth.c
> index 03ce4b8a0e1e..0bb189fb4037 100644
> --- a/support/export/auth.c
> +++ b/support/export/auth.c
> @@ -81,6 +81,8 @@ check_useipaddr(void)
>   		cache_flush();
>   }
>   
> +extern void __svc_destroy_idle(int, bool_t);
This is adding to the API... Which means mountd
and statd (the next patch) will not compile without
this new API...

Does this mean an SONAME change? That is such a pain!

steved.

> +
>   unsigned int
>   auth_reload()
>   {
> @@ -91,8 +93,14 @@ auth_reload()
>   	int			fd;
>   
>   	if ((fd = open(etab.statefn, O_RDONLY)) < 0) {
> -		xlog(L_FATAL, "couldn't open %s", etab.statefn);
> -	} else if (fstat(fd, &stb) < 0) {
> +		if (errno != EMFILE && errno != ENFILE)
> +			xlog(L_FATAL, "couldn't open %s", etab.statefn);
> +		/* remove idle */
> +		__svc_destroy_idle(5, FALSE);
> +		if ((fd = open(etab.statefn, O_RDONLY)) < 0)
> +			xlog(L_FATAL, "couldn't open %s", etab.statefn);
> +	}
> +	if (fstat(fd, &stb) < 0) {
>   		xlog(L_FATAL, "couldn't stat %s", etab.statefn);
>   		close(fd);
>   	} else if (last_fd != -1 && stb.st_ino == last_inode) {
> diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
> index 167b9757bde2..ada8d0ac8844 100644
> --- a/utils/mountd/svc_run.c
> +++ b/utils/mountd/svc_run.c
> @@ -59,6 +59,7 @@
>   #include "export.h"
>   
>   void my_svc_run(void);
> +extern void __svc_destroy_idle(int , bool_t);
>   
>   #if defined(__GLIBC__) && LONG_MAX != INT_MAX
>   /* bug in glibc 2.3.6 and earlier, we need
> @@ -95,6 +96,7 @@ my_svc_run(void)
>   {
>   	fd_set	readfds;
>   	int	selret;
> +	struct	timeval tv;
>   
>   	for (;;) {
>   
> @@ -102,8 +104,10 @@ my_svc_run(void)
>   		cache_set_fds(&readfds);
>   		v4clients_set_fds(&readfds);
>   
> +		tv.tv_sec = 30;
> +		tv.tv_usec = 0;
>   		selret = select(FD_SETSIZE, &readfds,
> -				(void *) 0, (void *) 0, (struct timeval *) 0);
> +				(void *) 0, (void *) 0, &tv);
>   
>   
>   		switch (selret) {
> @@ -113,7 +117,9 @@ my_svc_run(void)
>   				continue;
>   			xlog(L_ERROR, "my_svc_run() - select: %m");
>   			return;
> -
> +		case 0:
> +			__svc_destroy_idle(30, FALSE);
> +			continue;
>   		default:
>   			selret -= cache_process_req(&readfds);
>   			selret -= v4clients_process(&readfds);
> diff --git a/utils/statd/svc_run.c b/utils/statd/svc_run.c
> index e343c7689860..8888788c81d0 100644
> --- a/utils/statd/svc_run.c
> +++ b/utils/statd/svc_run.c
> @@ -59,6 +59,7 @@
>   
>   void my_svc_exit(void);
>   static int	svc_stop = 0;
> +extern void __svc_destroy_idle(int , bool_t);
>   
>   /*
>    * This is the global notify list onto which all SM_NOTIFY and CALLBACK
> @@ -85,6 +86,7 @@ my_svc_run(int sockfd)
>   	FD_SET_TYPE	readfds;
>   	int             selret;
>   	time_t		now;
> +	struct timeval	tv;
>   
>   	svc_stop = 0;
>   
> @@ -101,7 +103,6 @@ my_svc_run(int sockfd)
>   		/* Set notify sockfd for waiting for reply */
>   		FD_SET(sockfd, &readfds);
>   		if (notify) {
> -			struct timeval	tv;
>   
>   			tv.tv_sec  = NL_WHEN(notify) - now;
>   			tv.tv_usec = 0;
> @@ -111,8 +112,10 @@ my_svc_run(int sockfd)
>   				(void *) 0, (void *) 0, &tv);
>   		} else {
>   			xlog(D_GENERAL, "Waiting for client connections");
> +			tv.tv_sec = 30;
> +			tv.tv_usec = 0;
>   			selret = select(FD_SETSIZE, &readfds,
> -				(void *) 0, (void *) 0, (struct timeval *) 0);
> +				(void *) 0, (void *) 0, &tv);
>   		}
>   
>   		switch (selret) {
> @@ -124,7 +127,9 @@ my_svc_run(int sockfd)
>   			return;
>   
>   		case 0:
> -			/* A notify/callback timed out. */
> +			/* A notify/callback/wait for client timed out. */
> +			if (!notify)
> +				__svc_destroy_idle(30, FALSE);
>   			continue;
>   
>   		default:
> 

