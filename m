Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9D479703
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhLQWXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 17:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhLQWXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 17:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639779820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzBXHckKODAZRj+4Pg4TaTnXBopKnJnXa7QDwpIdsOs=;
        b=gckksz8qzpjjGmY9/vxYr733fvfNYDdW2pKfDwtwldgrT5PVqR+7m/rLxMjOrI9VBbXYop
        EyBCQoRx29+I1MliQXUagg5FCmW1mNvSORUJW+sWMhJ3lfIH6gScO3qi0aFs6gvwxOq7cW
        AiTlb7i0Ni+prd8eaK3ndAZjYbHvwxo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-J2Vy9M8FNQSUtRyYh7pekA-1; Fri, 17 Dec 2021 17:23:39 -0500
X-MC-Unique: J2Vy9M8FNQSUtRyYh7pekA-1
Received: by mail-il1-f198.google.com with SMTP id 11-20020a056e0220cb00b002ac12986811so2294333ilq.9
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 14:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzBXHckKODAZRj+4Pg4TaTnXBopKnJnXa7QDwpIdsOs=;
        b=SfQRhTikFe2DEqTWnxvE5D/5HrTri69LqES0TcFjfYiXU07WW9sUHcOL5NpPxHwHWH
         lChmOQmt3kiqmmCEbzSA77+Z1GL0aDpT1F1OQbBflbO3ksZ7bcjUUeBpJaflbIYyYg7u
         nDM3bC6C9d0knw/WNGfHIlyTLPpp9cU5tOFsVOW1IJj3r9k/b4m7yotH1VfG76peqcYM
         +xYVVswEvhE8TNXa9ftpSAu2O7dzwx2Isps2yqdDxc0hDNG01peMmBr1Dky+93/wE93m
         BiQJXO/aGdYD5iCtujndRylDyUPQ9CKjcTnHgQQmvxxTbPXlfSyQfXh3YUX99dMw3rn+
         1aXQ==
X-Gm-Message-State: AOAM531R0KCdVW0l0SNuvShit7cqcBc/1n9KEtj6QwfmrdtrIYdkpPAE
        2yyp8/fCRyMoMhtnqqQTX4PMXP/9i4br5V5IfKDxW2dRH1E6zLczbVRRosH23tIXGrmCRBgPs+5
        DleyjV0HKbPFr4qWHU2CSP7f5bude0Eq8tzV/
X-Received: by 2002:a05:6638:35a8:: with SMTP id v40mr3339295jal.193.1639779819113;
        Fri, 17 Dec 2021 14:23:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsnAG0rGJu9uR4TlJpL8HDxEAFvLuUfss/SP6OZAEIqnXUc6fCRj4MCM8Z+QtyBj7nAtixlrPAbj0xDKgqrfU=
X-Received: by 2002:a05:6638:35a8:: with SMTP id v40mr3339290jal.193.1639779818930;
 Fri, 17 Dec 2021 14:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20211217215046.40316-1-trondmy@kernel.org> <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org> <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org> <20211217215046.40316-6-trondmy@kernel.org>
In-Reply-To: <20211217215046.40316-6-trondmy@kernel.org>
From:   Bruce Fields <bfields@redhat.com>
Date:   Fri, 17 Dec 2021 17:23:28 -0500
Message-ID: <CAPL3RVFaWgdWQnWOe5B_6=1pNGSOZXp=SVFOBs24aucXphi6wQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] nfsd: NFSv3 should allow zero length writes
To:     trondmy@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 5:07 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> According to RFC1813: "If count is 0, the WRITE will succeed
> and return a count of 0, barring errors due to permissions checking."

Yes, I'm surprised we're not already doing this right.

I wonder how far back this bug goes.

The svc.c code is from 8154ef2776aa "NFSD: Clean up legacy NFS WRITE
argument XDR decoders", but the behavior might predate that code.  The
nfsd_vfs_write() logic, I'm not sure I understand.

We have a pynfs test for the v4 case (WRT4), but I guess we must have
nothing testing the v3 case.

--b.

>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/vfs.c    | 3 +++
>  net/sunrpc/svc.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 4d57befdac6e..38fdfcbb079e 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -969,6 +969,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>
>         trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
>
> +       if (!*cnt)
> +               return nfs_ok;
> +
>         if (sb->s_export_op)
>                 exp_op_flags = sb->s_export_op->flags;
>
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index a3bbe5ce4570..d1ccf37a4588 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1692,7 +1692,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp, struct page **pages,
>          * entirely in rq_arg.pages. In this case, @first is empty.
>          */
>         i = 0;
> -       if (first->iov_len) {
> +       if (first->iov_len || !total) {
>                 vec[i].iov_base = first->iov_base;
>                 vec[i].iov_len = min_t(size_t, total, first->iov_len);
>                 total -= vec[i].iov_len;
> --
> 2.33.1
>

