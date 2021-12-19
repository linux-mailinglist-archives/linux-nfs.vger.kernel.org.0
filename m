Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD07547A29A
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 23:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhLSWVz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 17:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231572AbhLSWVy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 17:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639952514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uu0KydZd8XVT9WlV0cX93sUE+PfTwa17kDEJFlacyBI=;
        b=UBuOg2ZYmjOBmc95zhTuLqk14mH0wUI4J6sjQyU9CyNJmjYpymnzb6txMObeVy4OBu70aj
        Mahl3e6oO8o+pTvmPHA31pbnSOAi0K5S6JSus3dUw34Vgp0RApu65WJqoYl1iaN9Ygj7jn
        HowAtEImsyY2Tc6MnVJx0nqk+B408kk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-D-eZzd96M-ab1-eA67qf4A-1; Sun, 19 Dec 2021 17:21:52 -0500
X-MC-Unique: D-eZzd96M-ab1-eA67qf4A-1
Received: by mail-io1-f69.google.com with SMTP id m127-20020a6b3f85000000b005f045ba51f9so6112851ioa.4
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 14:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uu0KydZd8XVT9WlV0cX93sUE+PfTwa17kDEJFlacyBI=;
        b=AuYcZnWW26X71GjwlXABqvWI+qKYq8pDq6z0kkQYqQcBBUqB0NLSkxfcBX7erpd0zg
         F9yeVlactrVazcwLN7RqxJp8RW90iPItOlSM/G9Jy4hby+7CVV7AmOBn5aNjFS3Qcni1
         IJGfY552yt/VEuIlL8Wrn3jRDHYyjwC0K6QbGCrauNS569O2sM+grhkHtfgPEHWM9u+g
         QErO/OU8wdXA4ucdmA1nAY86s/oYE/8yBjBBIvVZbVgT8rdyRIGoIsT0LR2DccwNgxAi
         CBFnqm/AL5LH2m7jfoIbXzTmu/HlX5o7Jv2cumENh/KY3Y1Gz2jBnH/oJSDCLRYszb7r
         4Jzg==
X-Gm-Message-State: AOAM530P0zHEbxMwSpdFgXW9ahHcI98OZOc+9TjNqCIN0bGImIwEsxpE
        FrOQ9ZW/iypv9BBU/CYu38Wd1F2Ilts7VXCwFNbTuGsuQ9IGUsrXT98Tl6Ys9jkbvgl6VWkhXQ/
        G3C8EQ+jnpIgYiDzkMOXxLDtjPBOwjORiLzHS
X-Received: by 2002:a05:6e02:1bc6:: with SMTP id x6mr6524486ilv.31.1639952512249;
        Sun, 19 Dec 2021 14:21:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzb96H9WXyASVZvuuNliL0/Fyc5UEV+cVEDFExvu5z2+LhGKu/R+wJczeB4IbD8E29nUZ5vcxd1afd+e12aOAE=
X-Received: by 2002:a05:6e02:1bc6:: with SMTP id x6mr6524482ilv.31.1639952512105;
 Sun, 19 Dec 2021 14:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20211217215046.40316-1-trondmy@kernel.org> <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org> <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org> <20211217215046.40316-6-trondmy@kernel.org>
 <20211217215046.40316-7-trondmy@kernel.org> <20211217215046.40316-8-trondmy@kernel.org>
 <20211217215046.40316-9-trondmy@kernel.org>
In-Reply-To: <20211217215046.40316-9-trondmy@kernel.org>
From:   Bruce Fields <bfields@redhat.com>
Date:   Sun, 19 Dec 2021 17:21:41 -0500
Message-ID: <CAPL3RVHkbVS1Fu=vigWM+0tmyzqCNKLrVz_zWQ6qhZOnoJO+BQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] nfsd: allow lockd to be forcibly disabled
To:     trondmy@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This seems like a really specialized requirement.  Is anyone outside
hammerspace doing this?

--b.

On Fri, Dec 17, 2021 at 5:02 PM <trondmy@kernel.org> wrote:
>
> From: Jeff Layton <jeff.layton@primarydata.com>
>
> In some cases, we may want to use a userland NLM server which will
> require that we turn off lockd.
>
> Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfssvc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index ccb59e91011b..7486a6f5fc21 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -340,8 +340,19 @@ static void nfsd_shutdown_generic(void)
>         nfsd_file_cache_shutdown();
>  }
>
> +/*
> + * Allow admin to disable lockd. This would typically be used to allow (e.g.)
> + * a userspace NLM server of some sort to be used.
> + */
> +static bool nfsd_disable_lockd = false;
> +module_param(nfsd_disable_lockd, bool, 0644);
> +MODULE_PARM_DESC(nfsd_disable_lockd, "Allow lockd to be manually disabled.");
> +
>  static bool nfsd_needs_lockd(struct nfsd_net *nn)
>  {
> +       if (nfsd_disable_lockd)
> +               return false;
> +
>         return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
>  }
>
> --
> 2.33.1
>

