Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB351EA264
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFALEe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jun 2020 07:04:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50786 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbgFALEd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jun 2020 07:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591009472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3R79gibjNhr31zz91Kfpy4/6S90e3DplsNoeLS1xhU=;
        b=HIHyI2pMMp0G1GV/ZUfwM5U3xzcXWb7wHMuyTdeEZOsJlLH4LYuAO03OTcbfkerI/gVT19
        LmlWt/dsvGNgqjf7t7i5dk5hHFvm43FibdC1Qi/juoubKN9Qk7AXQkp77bKvaaXLYGJscU
        4lx6JsyOiGigWSpFWd0jTqOg2T0KnN0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-u7lpZlU6M26KDxrXU0HRsA-1; Mon, 01 Jun 2020 07:04:30 -0400
X-MC-Unique: u7lpZlU6M26KDxrXU0HRsA-1
Received: by mail-qt1-f199.google.com with SMTP id t24so9566812qtj.15
        for <linux-nfs@vger.kernel.org>; Mon, 01 Jun 2020 04:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=F3R79gibjNhr31zz91Kfpy4/6S90e3DplsNoeLS1xhU=;
        b=lg5Ke6UFupogNeY6WAiXgXitocY6lIdxxxo0fCkJTc/bm68i/RjruO1RUwJ2W2xjVz
         loT52+5DjBCbaFi2qehFALafgS/w2h4LZ0y3pbcQB4Actf2cmukLBl3oFN+j10AgpXXB
         h1D0eP06Kb3K4ZrxmnPfbzGvp5HC9FNgTfk3tFOgz4dh+YRE7eDeMxa5VsIaWNtK/b3t
         z7haG90CEL4fLINfO8ZXuiA22WpndtGeZluTx5c4eZ6lca01RJLaLaA9pWK4v/BSpdwJ
         xYvyKT6XfnXfd6IUeSkkpIGL9tEOjqCYyMvueKDEcB86FDM+jiXWY6j7yysWuc/AG0gX
         Ji/A==
X-Gm-Message-State: AOAM531MjPFkIkPGK83lKA++dUoW+6knalP/TanOE5ep3NsF6hWTW00a
        fmx937qGmWlT/dQAEhbAFiko2uZtLUmEif9z5AQGujhTmrSknqPcb56g5K1CIJrFFT3vkuhlBtC
        Zu+WdoxzzVYuZGWM1Zv1a
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr2027123qvp.193.1591009470374;
        Mon, 01 Jun 2020 04:04:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC3q4dKQXpIi+IMBG0AMN0PlbzKj9mlu7+X9iHspa0NwQC3gxcL/v7aS4OHx1t+2xUkGiqUA==
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr2027109qvp.193.1591009470194;
        Mon, 01 Jun 2020 04:04:30 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id t74sm13280973qka.21.2020.06.01.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 04:04:29 -0700 (PDT)
Message-ID: <7d17296d9da7607e75a9df928747877d310bdbaa.camel@redhat.com>
Subject: Re: [PATCH] sunrpc: fixed rollback in rpc_gssd_dummy_populate()
From:   Jeff Layton <jlayton@redhat.com>
To:     Vasily Averin <vvs@virtuozzo.com>, linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 01 Jun 2020 07:04:28 -0400
In-Reply-To: <dc913496-1c07-fa86-9019-52fd5dcc878a@virtuozzo.com>
References: <dc913496-1c07-fa86-9019-52fd5dcc878a@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-06-01 at 11:54 +0300, Vasily Averin wrote:
> __rpc_depopulate(gssd_dentry) was lost on error path
> 
> cc: stable@vger.kernel.org
> Fixes: commit 4b9a445e3eeb ("sunrpc: create a new dummy pipe for gssd to hold open")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  net/sunrpc/rpc_pipe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 39e14d5..e9d0953 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -1317,6 +1317,7 @@ void rpc_put_sb_net(const struct net *net)
>  	q.len = strlen(gssd_dummy_clnt_dir[0].name);
>  	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
>  	if (!clnt_dentry) {
> +		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
>  		pipe_dentry = ERR_PTR(-ENOENT);
>  		goto out;
>  	}

Good catch!

Reviewed-by: Jeff Layton <jlayton@redhat.com>

