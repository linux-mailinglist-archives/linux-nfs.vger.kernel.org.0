Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2F3010A5
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Jan 2021 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbhAVTiR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 14:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbhAVTYM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 14:24:12 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB185C061786
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 11:23:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c2so7559483edr.11
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 11:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHkKA0SOvAxdor7YGNW/4jTUyWoPWoOOdjiWjrjEynY=;
        b=GRr8xUycUe99wQjmbNBJk/Gn6bETCDEAn/FtKH99rKcnycQZQgyQsJ5uSkacTIYyc7
         MmK7yKSMWBR2f9/JrxeEylL4yhbf0p2HZard6U2gv+wN9bWnaArSc2//lY4NDj5NippY
         zmyYzI/NnLDTKu5aWTcliRuKQgsj7iUFS2dT0NyJPkFPLkoXMdef1WrXKsu83pYsC24E
         RqA9uc49Pa/2iDdZ67XoNLYI5L87lkTUabcW5DWCtv5EgcLopChGFN+8uMKZBCi8fdXt
         IqI9dA8rRxObtDUlJA6vTfxClo080Ogh5FeNp7haSdkcczr0OjcSNKvunn1gqn0987FR
         7OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHkKA0SOvAxdor7YGNW/4jTUyWoPWoOOdjiWjrjEynY=;
        b=OoHzk/W1QlLSV4fDWekQl5DfvkdViaBIe/yyR2xr13t02moDqI4vc1Sm360GzzImvd
         3YO8JRbxKT7pWrhNgXQbT6h4ukSRuF07zhXbAlFo1jQaBai0AnWIXqVaudWn7O6dqmeF
         cdz8tbsQAUOxWuAGPztGtf+gIGsHZD7HfIa1sgr45nwnRk/CuDdfDnYmo4UhcJidMtpI
         gH9iNjxjXNfI2WEmnRTuI5uAmhgxBGwqULfqCz+JmgR9I334ZVjBliDNxPmnJqmBCDIj
         W10sxHdkkWnxmPibgdlmXMt930MCmzbDvVe02ku4fJpi4Fiyu/Wzx0I8pNYj0UPUsqo9
         eBzg==
X-Gm-Message-State: AOAM530DAeaFPOM7yz4T6GZdZEO4xygjDpVo6RdVU2/r/YZFPnPW8GiV
        nmq2SNktn6MmgYgmZ/NY28DJ4KADaL7poRUhmXqR
X-Google-Smtp-Source: ABdhPJzT10q1bu1UPFwSuzjQxK3sjeXcPvz3DG75lRloWm85Qrqipie1IDcEOrq/CVmI6bnHaC5GvT0v7KUxd8BRx+k=
X-Received: by 2002:a05:6402:4391:: with SMTP id o17mr4433163edc.196.1611343410639;
 Fri, 22 Jan 2021 11:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20210115174356.408688-1-omosnace@redhat.com>
In-Reply-To: <20210115174356.408688-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 14:23:19 -0500
Message-ID: <CAHC9VhQV6k3LhgyvGmWSn+rQpuFY1wK4K-5p=xk-mVdUK6eDnQ@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix return value of _nfs4_get_security_label()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        David Quigley <dpquigl@davequigley.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 15, 2021 at 12:47 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> An xattr 'get' handler is expected to return the length of the value on
> success, yet _nfs4_get_security_label() (and consequently also
> nfs4_xattr_get_nfs4_label(), which is used as an xattr handler) returns
> just 0 on success.
>
> Fix this by returning label.len instead, which contains the length of
> the result.
>
> Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 2f4679a62712a..28465d8aada64 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5971,7 +5971,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
>                 return ret;
>         if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
>                 return -ENOENT;
> -       return 0;
> +       return label.len;
>  }
>
>  static int nfs4_get_security_label(struct inode *inode, void *buf,
> --
> 2.29.2

-- 
paul moore
www.paul-moore.com
