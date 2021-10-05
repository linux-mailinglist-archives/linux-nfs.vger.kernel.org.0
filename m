Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49D04227B4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhJENZf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 09:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234103AbhJENZe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 09:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633440224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKbR8FvCeBTSeT0pNhTRGhTE4CVwvkMvkOIjlwXIta8=;
        b=HQtT2lZgRxiH9z/QB/KjtPBEUK22XQUq9Bl35RAo92fid9NCPqmhM60Qre6boyDZV4KeRU
        2q5AV0vkq9E04pJerV7WJv8isptRmRR3kvIlIvuqcUZYL+Am3/6AIi9lhIhx1AwjrDG3l8
        zDoPtT8YxKtURf1BlYg8nvu9IF8+4Os=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-u4y4MrGHN_2wsDT4gJPHaw-1; Tue, 05 Oct 2021 09:23:42 -0400
X-MC-Unique: u4y4MrGHN_2wsDT4gJPHaw-1
Received: by mail-ed1-f70.google.com with SMTP id r21-20020a50c015000000b003db1c08edd3so798320edb.15
        for <linux-nfs@vger.kernel.org>; Tue, 05 Oct 2021 06:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKbR8FvCeBTSeT0pNhTRGhTE4CVwvkMvkOIjlwXIta8=;
        b=ZwtHxmOfMSdbWJEZFnWm2KK1PuWvE1Z9iq6ahE9lcfaDXq/IXENCiqd2lD8Bc00bPF
         5ooCXIZAsmMVCWQH8FEIHM3nwpfxHWxsoM9S1mXMcW7ehcBZIMwZYlF/Y4R9BNznAQ++
         +cCuVpGi3NPJ/KdaUEhI74WfPwBW/fZMnpRHWcf+61hAHBfK21n3dWyK36qBo+P+afJ1
         r8VBTLoHU6u+zN9fThlb6keajN+cYOkq6b2H0A3Kg1wXvyX5VYp9P6lynfkssWVtVtu5
         hLe/04YhM+mMJIrwNLhJvj0eNZbtdx7WG4fFZva8Tn2L/lcCWQQfFbhUYXvjrTwJNVgF
         8ndQ==
X-Gm-Message-State: AOAM531Hdpir4qps84hskaTC9y3J2rcIFZPkw8TM1/u5npL/WZ6fXAty
        ++XQd2f+FfGUYPKzWkDuYko5sXJ2RLb92mUyOe74oUVY8cNv1J7lbIRqsy31U6Nm7J+0X3hE/x/
        P/TBpDL8mPW2+2s7ZLoQ1vG7IRBykUpVKgU5x
X-Received: by 2002:a05:6402:358c:: with SMTP id y12mr25460202edc.159.1633440221783;
        Tue, 05 Oct 2021 06:23:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdGA4t7WXHUSSGDTBF5EAERIk1rUUvS4aOVk+e37jrlTSplgDO4SduLt1XdrwMUBcmAUpFGK19GXYzmIfBAiU=
X-Received: by 2002:a05:6402:358c:: with SMTP id y12mr25460181edc.159.1633440221606;
 Tue, 05 Oct 2021 06:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <1633288958-8481-1-git-send-email-dwysocha@redhat.com>
 <1633288958-8481-2-git-send-email-dwysocha@redhat.com> <1078846.1633438369@warthog.procyon.org.uk>
In-Reply-To: <1078846.1633438369@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 5 Oct 2021 09:23:04 -0400
Message-ID: <CALF+zOk1P22ePaDTwZto-hT+TcqYE=oepqwe13sFjYbPEFYxLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] NFS: Fixup patch 3/8 of fscache-iter-3 v2
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 5, 2021 at 8:52 AM David Howells <dhowells@redhat.com> wrote:
>
> Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> >
> > Handle failed return values of fscache_fallback_read_page() in
> > switch statement.
>
> After some discussion on IRC, the attached is probably better.  Returning 1
> might result in 1 being returned through ->readpage(), which could be a
> problem.
>
> David
> ---
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index 5b0e78742444..68e266a37675 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -346,33 +346,18 @@ int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
>
>         ret = fscache_fallback_read_page(nfs_i_fscache(inode), page);
>         if (ret < 0) {
> -               dfprintk(FSCACHE, "NFS:    readpage_from_fscache: "
> -                        "fscache_fallback_read_page failed ret = %d\n", ret);
> -               return ret;
> -       }
> -
> -       switch (ret) {
> -       case 0: /* Read completed synchronously */
> -               dfprintk(FSCACHE,
> -                        "NFS:    readpage_from_fscache: read successful\n");
> -               nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
> -               SetPageUptodate(page);
> -               return 0;
> -
> -       case -ENOBUFS: /* inode not in cache */
> -       case -ENODATA: /* page not in cache */
>                 nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
>                 dfprintk(FSCACHE,
> -                        "NFS:    readpage_from_fscache %d\n", ret);
> -               SetPageChecked(page);
> -               return 1;
> -
> -       default:
> -               dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
> -               nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
> +                        "NFS:    readpage_from_fscache failed %d\n", ret);
>                 SetPageChecked(page);
> +               return ret;
>         }
> -       return ret;
> +
> +       /* Read completed synchronously */
> +       dfprintk(FSCACHE, "NFS:    readpage_from_fscache: read successful\n");
> +       nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
> +       SetPageUptodate(page);
> +       return 0;
>  }
>
>  /*
>

Yes this looks good.
Acked-by: Dave Wysochanski <dwysocha@redhat.com>

