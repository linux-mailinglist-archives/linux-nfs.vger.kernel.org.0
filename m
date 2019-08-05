Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2242A8228F
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2019 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfHEQi6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Aug 2019 12:38:58 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44652 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHEQi5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Aug 2019 12:38:57 -0400
Received: by mail-vs1-f68.google.com with SMTP id v129so56356611vsb.11
        for <linux-nfs@vger.kernel.org>; Mon, 05 Aug 2019 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIlnyrAQubtRedXdK/WQR+4utAEMUGb5wkLmNWPU8B4=;
        b=ZVFjlMNT67wOJwS8e1dCCGNvoVwDzEEEED/uZCRyHmVTGqW4BNGTVPaKxKDMK6OjM0
         qISdcydjpK+M5jgYPuT5fH0NxrnSWy9GWxj4eWo6rM/czsYP2TrDsGjzOdDypESwQ6s8
         AqvM5U6ghOw2DaPoYtphjeekhf7glCXTPC1nnSY8obRqZwGg5CTTCERGqF5Nz3Ym3yCx
         7ci28/qJJyHm+pf0aJCrdbELBjz5aW35+L/IOAq2mvYViQadwbvwLl5bfep+6sMksU39
         Zj2TcKX66av+n0daOup4ualx6YvRoqJL+jRxjw9UEWx5dYFwYu93bGuVXcByt5o3tmpI
         AqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIlnyrAQubtRedXdK/WQR+4utAEMUGb5wkLmNWPU8B4=;
        b=k3fBZiYauieiT9XOcq8Y/9SafTVvERwhgMp6H9w+XFDSGQqI5pSyZnNpPMjBaxyHdc
         la7VMFJJyhYMMU2OpQzh0kKYlvkB7Ha1uLVj3OQ39Q7e3xDIosgpGgoZ+5iF9YumihNl
         jryeB5bAfw0qBxIv+dMMZ+L1GPZhDqZU0ALylZSYhsPda9BJhm5tC+fzfwAQHGiPGo+b
         0zkbvPVAcI+EDjKGqMmwztLVWSQM6uJsUaQXAvrqyHRrQyISOOPhPDbbkXv4SO1PFgWt
         /P0vbjUsc9ki0O5p1P5f0dRfQmc/c7ieGCOSzmb7L8wTtiTs0NSZu97Qz4I+HX0ow0FH
         Kn6Q==
X-Gm-Message-State: APjAAAXdL4uqmhweeBvxlxtmWXkjewBFJ5Q0rX3zmpOoGG7SU8Ggt2YE
        vK3QvwGZzzaKTBvQoNrClXDSTmFk06j0jGYFuEg=
X-Google-Smtp-Source: APXvYqzq0iAqa7ls4JCCOuN55DQS8xdTpSp1U4IrJTLWT65gugWhvudoYFtJY1JjTFK4YF6+CSJCBfxiO3IJSvU/5LY=
X-Received: by 2002:a67:dc1:: with SMTP id 184mr36325218vsn.164.1565023136933;
 Mon, 05 Aug 2019 09:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190803144320.15276-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20190803144320.15276-1-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 5 Aug 2019 12:38:45 -0400
Message-ID: <CAN-5tyGWuJgZN-riN2A-mKuwobCe8USWv6mCXLZfE8i=Je-XwA@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: Fix an Oops in nfs4_do_setattr
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Aug 3, 2019 at 10:45 AM Trond Myklebust <trondmy@gmail.com> wrote:
>
> If the user specifies an open mode of 3, then we don't have a NFSv4 state
> attached to the context, and so we Oops when we try to dereference it.
>
> Reported-by: Olga Kornievskaia <aglo@umich.edu>
> Fixes: 29b59f9416937 ("NFSv4: change nfs4_do_setattr to take...")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: stable@vger.kernel.org # v4.10: 991eedb1371dc: NFSv4: Only pass the...
> Cc: stable@vger.kernel.org # v4.10+
> ---
>  fs/nfs/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 3e0b93f2b61a..12b2b65ad8a8 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3214,7 +3214,7 @@ static int _nfs4_do_setattr(struct inode *inode,
>
>         if (nfs4_copy_delegation_stateid(inode, FMODE_WRITE, &arg->stateid, &delegation_cred)) {
>                 /* Use that stateid */
> -       } else if (ctx != NULL) {
> +       } else if (ctx != NULL && ctx->state) {
>                 struct nfs_lock_context *l_ctx;
>                 if (!nfs4_valid_open_stateid(ctx->state))
>                         return -EBADF;

Thank you Trond. No longer oops-ing with this patch.

> --
> 2.21.0
>
