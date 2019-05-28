Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305432C4C7
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfE1KtU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 06:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfE1KtU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 06:49:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3B7F3086224;
        Tue, 28 May 2019 10:49:17 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96D8E5D6A9;
        Tue, 28 May 2019 10:49:15 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>, bfields@fieldses.org
Cc:     jlayton@kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH -next] lockd: Make two symbols static
Date:   Tue, 28 May 2019 06:49:13 -0400
Message-ID: <97D052EC-1F07-4210-81CC-7E0085C095BD@redhat.com>
In-Reply-To: <20190528090652.13288-1-yuehaibing@huawei.com>
References: <20190528090652.13288-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 28 May 2019 10:49:20 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Maintainers, what's the best thing to do here: fold these into another 
patch version and post it (add attribution)?  Add it as another patch at 
the end of the series?

I have learned my lesson: add sparse to my workflow.

Ben

On 28 May 2019, at 5:06, YueHaibing wrote:

> Fix sparse warnings:
>
> fs/lockd/clntproc.c:57:6: warning: symbol 'nlmclnt_put_lockowner' was 
> not declared. Should it be static?
> fs/lockd/svclock.c:409:35: warning: symbol 'nlmsvc_lock_ops' was not 
> declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/lockd/clntproc.c | 2 +-
>  fs/lockd/svclock.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> index 0ff8ad4..b11f2af 100644
> --- a/fs/lockd/clntproc.c
> +++ b/fs/lockd/clntproc.c
> @@ -54,7 +54,7 @@ nlmclnt_get_lockowner(struct nlm_lockowner 
> *lockowner)
>  	return lockowner;
>  }
>
> -void nlmclnt_put_lockowner(struct nlm_lockowner *lockowner)
> +static void nlmclnt_put_lockowner(struct nlm_lockowner *lockowner)
>  {
>  	if (!refcount_dec_and_lock(&lockowner->count, 
> &lockowner->host->h_lock))
>  		return;
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 5f9f19b..61d3cc2 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -406,7 +406,7 @@ static void nlmsvc_locks_release_private(struct 
> file_lock *fl)
>  	nlmsvc_put_lockowner((struct nlm_lockowner *)fl->fl_owner);
>  }
>
> -const struct file_lock_operations nlmsvc_lock_ops = {
> +static const struct file_lock_operations nlmsvc_lock_ops = {
>  	.fl_copy_lock = nlmsvc_locks_copy_lock,
>  	.fl_release_private = nlmsvc_locks_release_private,
>  };
> -- 
> 2.7.4
