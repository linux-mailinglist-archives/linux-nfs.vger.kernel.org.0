Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE96F0E6B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2019 06:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfKFFhe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Nov 2019 00:37:34 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45413 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfKFFhe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Nov 2019 00:37:34 -0500
Received: by mail-io1-f66.google.com with SMTP id s17so25597256iol.12;
        Tue, 05 Nov 2019 21:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtzABwczyZfNxL6XzweD6I6Q63/FdFYN7U2QH0SQbdg=;
        b=eIhxf6+YBKxXXanCrpjy9m6LcWa7mOKSyqdsrTDJFCwvUSKKeqJU/L8V0n/6F3agP3
         HqRUiotx5g/K6NiA2pddwtPSSeemhplxj00BKjVuVleZZWwL8ZRJJhuvQEXjqdyMfwa5
         7rjxE996A5N2goi8Q5tFBNHeEvFnQF7XzzGqZonA2yNoSoKcPcCrblu8RdXbF1kGgji8
         jyEPs0bNsGUCHolkdb67Levt7xX8tSBpcCSTS2ZLeK0qO1tivwUmFSZ9UTVLh7fA0vPp
         RLxKcnvBff5fqT/fkDOQRhGYW9THwF0NMb+CN/ePAIV0zd7toKnAXpv2FghzW/U2WPPO
         iaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtzABwczyZfNxL6XzweD6I6Q63/FdFYN7U2QH0SQbdg=;
        b=IFV7bJoOFoWwyNxyosAd2Kg/gQrWvo0HCXE8MgdO1v78aPiO8KY0fCdtgvmhNvDaUF
         w+sCPzXnlAn4uTBbrxd4Xeu7VR8DQNNCehrIjnNHn+6vbkG3oF1aGUqOiBVhljTSmH14
         VfITP81lZt/4cltpn9XgHXf1u95SG3+bIYuGFjHK7VW+Ha85JAi9Q1hr/srTvkIoF946
         E+k2W6X780N8ut33JglD0k4kH8O4u6jLJ7ZPPro0PjqEk2GoGVYdg8AbYPEq/ZixXfTg
         STehUAXKQhCK1KwoyY2dgYeM6xDDE2bk/6YB/BCGvw6+UuvmhgkrLHCgYprYLgYRx7XW
         WJLA==
X-Gm-Message-State: APjAAAUos+hOwEK62sqg4tTuQAVZjrqSlKGevynT9MHaU5iRsObxTtBI
        5bi1mLjmdU829Og23HsiplR+Njocmh0gpqXCENKL3g==
X-Google-Smtp-Source: APXvYqzv1ZnOAK1rEr6ulQ1qi0lC4bdrx7fbrkHaMMOiwYG3QZDrvYhJvFAjURZg3OzoSr8i0tnquTbI5EU4fUTlqjg=
X-Received: by 2002:a5e:9706:: with SMTP id w6mr2508377ioj.252.1573018652955;
 Tue, 05 Nov 2019 21:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20190920002232.27477-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190920002232.27477-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 5 Nov 2019 23:37:22 -0600
Message-ID: <CAEkB2EQ2BPpXcpRpN-+ErJD5Vkq6LiKONy8XQfvu0F1pO4weqw@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: fix memory leak if nfs4_begin_drain_session fails
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Would you please review this patch?

On Thu, Sep 19, 2019 at 7:22 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In nfs4_try_migration, if nfs4_begin_drain_session fails the allocated
> memory should be released.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  fs/nfs/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index cad4e064b328..124649f12067 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2096,7 +2096,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
>
>         status = nfs4_begin_drain_session(clp);
>         if (status != 0)
> -               return status;
> +               goto out;
>
>         status = nfs4_replace_transport(server, locations);
>         if (status != 0) {
> --
> 2.17.1
>


-- 
Navid.
