Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA91446B1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 22:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUV4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 16:56:43 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41687 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUV4n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jan 2020 16:56:43 -0500
Received: by mail-ua1-f68.google.com with SMTP id f7so1641090uaa.8;
        Tue, 21 Jan 2020 13:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lxp4dj0ZUXUCX2OuXjDqEQzdRovkPjxeBfITEqqx0Ts=;
        b=gxjkQH4iyLeK/ARyfGDTzPnwWrrl48J9AQBQSJMYqxohjRnpa9zGcCQEMVH8WLpg+V
         DpnvyDCRQftxWNXQucuFQViwXfdyfJtx3hBJO1BdFFOszu+pRrgE9kEBa9Cf0XIxWRiN
         5LJROjubPmwRKLY1PwmpICBQ5ao0ZH/pZlSSBGPv1AsH4pIu2/F2mAaJIrlDEk9q7763
         wQbC6E3Wysoq+VbttMdvj0H+Gb2JXx2vyd8MlB6mVLt0Eeik+/iWL0Q9/dHs5tg1T2GR
         DcUa3bLYGOJEErqfJtAqlCNaZP568wGQdPNg98+q+L8Qg5zDsLhxYrnLLSYHI5Axrphz
         tcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lxp4dj0ZUXUCX2OuXjDqEQzdRovkPjxeBfITEqqx0Ts=;
        b=UsQOTlD1bwTz2EhLFezCA4ywg0Ip+vbrCktntx49rl+++jyx4g37DzOR5lDSDXhQqr
         MhqI8J1ncx/g5T1gpte04ARcKK3mEeAEoERhbsv3r4l0Vopc9m3jWwF6gaVuHUsRvxA5
         +x5EPirJIQqRGWUzPjokIvAl48n5U3KXKqSn/SDTmq6sGmrE/dti+VPVGCG2zoOtLSHk
         GzrxnrEUjXLfszZzcOf7B8Oapd3EvRkAP0IQA97AL4NhLrrWQ9vziWg+1g4Mhs1hvXiA
         lV51wx26gKQ6VLsrOMFMagPHO8RPOFlsdBPMNg9YoIAobNRTi9fDORMQ5ZI5dDahx0r4
         3J5Q==
X-Gm-Message-State: APjAAAX1PctvnCLUIhawqUU5XHwCsIOe7oBeNf/deFKKFeKwR2pnYaMM
        w0zr+nUN8DZgnNrsMt8R2TtGAHaezJa/e1vnwbY=
X-Google-Smtp-Source: APXvYqzikcSGAFHvTL0ei27v8r29uXDOmKvUxjmozH3h6dpykY0GgxgVOmT22PGRygL4Kw+YqmCYHKmNy8IO8rH0xjw=
X-Received: by 2002:ab0:710c:: with SMTP id x12mr4270380uan.81.1579643802212;
 Tue, 21 Jan 2020 13:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20200113132307.frp6ur5zhzolu5ys@kili.mountain>
In-Reply-To: <20200113132307.frp6ur5zhzolu5ys@kili.mountain>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 21 Jan 2020 16:56:31 -0500
Message-ID: <CAN-5tyEEPq6JX7mMRwX+7DTJJ3zy3-=SVqfqQyXvvbOQxqgDJQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd4: fix double free in nfsd4_do_async_copy()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 13, 2020 at 8:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This frees "copy->nf_src" before and again after the goto.
>
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 1e14b3ed5674..c90c24c35b2e 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1469,7 +1469,6 @@ static int nfsd4_do_async_copy(void *data)
>                 copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>                                               &copy->stateid);
>                 if (IS_ERR(copy->nf_src->nf_file)) {
> -                       kfree(copy->nf_src);
>                         copy->nfserr = nfserr_offload_denied;
>                         nfsd4_interssc_disconnect(copy->ss_mnt);
>                         goto do_callback;
> --
> 2.11.0
>

Reviewed-by: Olga Kornievskaia <kolga@netapp.com>

Bruce, can you add this to your nfsd-next?
