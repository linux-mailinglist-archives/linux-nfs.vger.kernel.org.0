Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017863AE46A
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUIB1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 04:01:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40352 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUIBZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 04:01:25 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C901B1FD2A;
        Mon, 21 Jun 2021 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624262350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY792cC/d7d1DMgD9iBuiHu/NOwzgk7RurwH5JgZgcM=;
        b=VTKTklKTSO/kHlZ3Ffq2YKEc9DJ982asc2Jim/iDgMZMnR1atVr8xhE9NbrlHA+pSek1p5
        try5zvcDJbiNm23EmFzIcRfGE9ht0nHTbyzs2M0EnsSW8t/JEALdch7hqXTGNGEU2Bzpua
        dY1OP4o8Y1JKqP7k2y+Yq1QjD0NtEMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624262350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY792cC/d7d1DMgD9iBuiHu/NOwzgk7RurwH5JgZgcM=;
        b=jNnna9nKpEjZvP/qijcMn7mHCWm89sMb9iQkVNz/8fmh4B5qSY8s7qYJHb3Vo9F62Mkqg3
        o6CF5j4dNcxrNYAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 92708118DD;
        Mon, 21 Jun 2021 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624262350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY792cC/d7d1DMgD9iBuiHu/NOwzgk7RurwH5JgZgcM=;
        b=VTKTklKTSO/kHlZ3Ffq2YKEc9DJ982asc2Jim/iDgMZMnR1atVr8xhE9NbrlHA+pSek1p5
        try5zvcDJbiNm23EmFzIcRfGE9ht0nHTbyzs2M0EnsSW8t/JEALdch7hqXTGNGEU2Bzpua
        dY1OP4o8Y1JKqP7k2y+Yq1QjD0NtEMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624262350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY792cC/d7d1DMgD9iBuiHu/NOwzgk7RurwH5JgZgcM=;
        b=jNnna9nKpEjZvP/qijcMn7mHCWm89sMb9iQkVNz/8fmh4B5qSY8s7qYJHb3Vo9F62Mkqg3
        o6CF5j4dNcxrNYAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ykQHIs5G0GDfFgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Mon, 21 Jun 2021 07:59:10 +0000
Date:   Mon, 21 Jun 2021 09:59:09 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     dongshijiang <dongshijiang@inspur.com>
Cc:     ltp@lists.linux.it, Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Steve Dickson <SteveD@redhat.com>,
        libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org
Subject: Re: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
Message-ID: <YNBGza7f7dOawiaF@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210617070806.174220-1-dongshijiang@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617070806.174220-1-dongshijiang@inspur.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

[Cc libtirpc ML and Steve]

> "Segmentation fault (core dumped)" due to the failure of svcfd_create during the rpc test, so you need to check the return value of the "svcfd_create" function

I'm not sure what is the value of TI-RPC tests. IMHO really messy code does
not in the end cover much of libtirpc functionality. That's why I'm thinking
to propose deleting whole testcases/network/rpc/rpc-tirpc/. libtirpc is being
used in nfs-utils, thus it'd deserve to have some testing, but IMHO this
should be libtirpc.

I'm not planning to dive into the technology to understand it enough be
able to written the tests from scratch and I'm not aware of anybody else
planning it.

> Signed-off-by: dongshijiang <dongshijiang@inspur.com>
> ---
>  .../rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c      | 5 +++++
>  .../rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c   | 5 +++++
>  .../rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c       | 5 +++++
>  .../rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c   | 5 +++++
>  4 files changed, 20 insertions(+)

> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> index 60b96cec3..3557c0068 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> @@ -46,6 +46,11 @@ int main(void)

>  	//First of all, create a server
>  	svcr = svcfd_create(fd, 0, 0);
> +
> +	//check returned value
> +	if ((SVCXPRT *) svcr == NULL) {
> +		return test_status;
> +	}

>  	//Then call destroy macro
>  	svc_destroy(svcr);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c
> index ecd145393..5a4331f4d 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress.c
> @@ -55,6 +55,11 @@ int main(int argn, char *argc[])
>  	//First of all, create a server
>  	for (i = 0; i < nbCall; i++) {
>  		svcr = svcfd_create(fd, 0, 0);
> +
> +		//check returned value
> +		if ((SVCXPRT *) svcr == NULL)
> +			continue;
> +		svcr = NULL;
man svc_destroy(3) states that it deallocates private data structures, including
xprt itself.

Kind regards,
Petr

>  		//Then call destroy macro
>  		svc_destroy(svcr);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> index da3b93022..de4df15f1 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> @@ -48,6 +48,11 @@ int main(void)

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);
> +
> +	//check returned value
> +	if ((SVCXPRT *) svcr == NULL) {
> +		return test_status;
> +	}

>  	//call routine
>  	xprt_register(svcr);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> index d0b7a20d4..fbaec25ad 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> @@ -52,6 +52,11 @@ int main(int argn, char *argc[])

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);
> +
> +	//check returned value
> +	if ((SVCXPRT *) svcr == NULL) {
> +		return test_status;
> +	}

>  	xprt_register(svcr);
>  	//call routine
