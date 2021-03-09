Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17878332298
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 11:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCIKIZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 05:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230045AbhCIKIP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 05:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615284495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SYm0kgjRA7W0E7Yr2IJisxrxfRrnBadUrxfwPSBbTRk=;
        b=P4kzi0hta/VvcwObe2+1VpRC4JI9PLoe9Rdxg27+I6RTDgAiPdJ+IeKMqvTXKxUczVuTiK
        d5/Qtzq8VsEi+rrE85O869bq3gb9mqfEZle6+286XjV/Y063TbOdI3dqxbYGjTFhzKQ4Mp
        JkjA6JPl/vv+g/GJmxLKb07AMQfNKu8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-w0j8nSXgPySdOOskiQ7M3A-1; Tue, 09 Mar 2021 05:08:13 -0500
X-MC-Unique: w0j8nSXgPySdOOskiQ7M3A-1
Received: by mail-yb1-f197.google.com with SMTP id v62so16419249ybb.15
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 02:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYm0kgjRA7W0E7Yr2IJisxrxfRrnBadUrxfwPSBbTRk=;
        b=ruAHm7qV/pE1l6wH0do06mbzumD5wae/i5vmCmDGJtxOlsM/3z7ZbgSGDbAudFqM7V
         E0tclxXzS6KR6KpeE/+4qFQNeR5rtbXLykjsFuMbj9BJfKmQK0UoWXfboew+QK9pmyWi
         pNWdG1GkkflklLRGozxUarXiwbYgbzoip8s1R28SY2xPDMHyisvQfQsTrrKlae+QZbzP
         HKfJE4YT/m8sel5pyq1P72cMmTSQDP1XXW5TvNB1Yfqtf+tMFziw/vDuJ88xYGOrz9Ho
         4Zzf1ytKNzPt/sV7fYlHtPry2pzXlh6EhZZ5yFKC7hUp4gep6vS07bSrAoALsp+6z2Ul
         4jSA==
X-Gm-Message-State: AOAM532qC/B5Tccw6P/6Bz3m355bj969mXXFv71sqF3SGrtF/AhSvrhv
        j2bQ72swS9zJCSVouZfBk4X+wljEs8kMpTyX9XaPoXj7YUbJ0aAICUigNUr4Az6ZbNO3vFG4qqd
        nSN7BbJiHzdIfFRjp/EBy4lij65JbAWnTleEp
X-Received: by 2002:a25:ad67:: with SMTP id l39mr40282820ybe.172.1615284492512;
        Tue, 09 Mar 2021 02:08:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOdXiOr+CcTEln+8TZ0CZvuB0W0M+aAg2Wavc5dcrB2nfJuV742vWVQiWOrCjwyEKAIQngbWmatIoZcEM8YyI=
X-Received: by 2002:a25:ad67:: with SMTP id l39mr40282799ybe.172.1615284492300;
 Tue, 09 Mar 2021 02:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20210115174356.408688-1-omosnace@redhat.com>
In-Reply-To: <20210115174356.408688-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 9 Mar 2021 11:08:01 +0100
Message-ID: <CAFqZXNtssgDmhMS+p6+F2zC=ka3=bM22GpNQLO2NbSLWQroYFg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix return value of _nfs4_get_security_label()
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        David Quigley <dpquigl@davequigley.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 15, 2021 at 6:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
>
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
>

Ping. It's been almost 2 months now, and I can't see the patch applied
anywhere, nor has it received any feedback from the NFS maintainers...
Trond? Anna?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

