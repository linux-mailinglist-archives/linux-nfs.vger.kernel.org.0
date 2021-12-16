Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD5477966
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Dec 2021 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhLPQj4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 11:39:56 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:34679 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhLPQj4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 11:39:56 -0500
Received: by mail-yb1-f171.google.com with SMTP id y68so66158695ybe.1;
        Thu, 16 Dec 2021 08:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEPEGGb1aR8D1SabPjTY1nd05keyniIz1b6jYSVPbm0=;
        b=Hj3A+K0LD6lFKlpqKBfbSF22UO2VLWDi7JcluQ5EIHi/s1C1UTsWd7A/Y+sOQ1bsRx
         4VmN+RyWsMkJv25JbjlktQyYZvzDxnVof8Q9/RHWI5dkkaTMYxYf/kEkOSBSPLgP9SEc
         Kgmd+Odp8yTDu7eIJzcBzjBoZ+htaT78R8ckZWRvSpPgkujBUgQ39mX6pqxWXf7eIoz+
         khFZlUgtsdkCQmf7czWBpokCIjtkZ5tydmjE55hHM3pyyymWBj5J3dgr5LsAHLPD/GJJ
         kwouqmiXhbVUd3ySGWUhaKwu6pzXBm23P98n001WctGNCQO7iQa7WLqornEi0Xb+8U+7
         JC9A==
X-Gm-Message-State: AOAM531Kj4kJ8SPOYz9RpZFLomI5nJiRjvf2ua+KfO1nw2inpZys29r/
        Zd5J5Zmzbea4BFBmSGmkpTH9lQCQeCPPgzA6v0Rf5x4q
X-Google-Smtp-Source: ABdhPJx3uhMKaoI0zA68RqhtsVYo8vhXs4JKxCyeBDG0Ckx6tNJ0VMLxa38S05bvKO+VTn+5h4V0Wbnh5eLsqL1lciE=
X-Received: by 2002:a25:f305:: with SMTP id c5mr4313857ybs.194.1639672795013;
 Thu, 16 Dec 2021 08:39:55 -0800 (PST)
MIME-Version: 1.0
References: <tencent_CE0F8701456CB89F92C73F28480EF3552E06@qq.com>
In-Reply-To: <tencent_CE0F8701456CB89F92C73F28480EF3552E06@qq.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Thu, 16 Dec 2021 11:39:39 -0500
Message-ID: <CAFX2Jfk-gH5V2PL3UkSw=QLDDuzSgbKuzUeh8-ir-VpO0BzMpg@mail.gmail.com>
Subject: Re: [PATCH] nfs: nfs4clinet: check the return value of kstrdup()
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Xiaoke,

On Mon, Dec 13, 2021 at 2:54 AM Xiaoke Wang <xkernel.wang@foxmail.com> wrote:
>
> kstrdup() returns NULL when some internal memory errors happen, it is
> better to check the return value of it so to catch the memory error in
> time.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  fs/nfs/nfs4client.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index af57332..89f13e0 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1372,5 +1372,8 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
>                 server->nfs_client->cl_hostname = kstrdup(hostname, GFP_KERNEL);
>         nfs_server_insert_lists(server);
>
> +       if (server->nfs_client->cl_hostname == NULL)
> +               return -ENOMEM;
> +

Checking the return of kstrdup() makes sense, but I think this should
right after the kstrdup() call and still under that if block.

Anna

>         return nfs_probe_destination(server);
>  }
> --
