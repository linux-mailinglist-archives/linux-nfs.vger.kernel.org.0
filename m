Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424277EE8E3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 22:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKPVpG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 16:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKPVpE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 16:45:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD862A7
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 13:45:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8962DC433C7
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700171101;
        bh=ra8eURyPTTUC8KK23OqBAR1lCVcOjqYRRr/h2OEODvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HEhTPC6LXdKw5a48XYUavhYxwYi/dc3JtfROpIVvUJ722UrnHuNO1sgBpkleCSZEG
         cYb3gM7+cQ9H90zIUPD5O6F8CpObKutFYIIiASeOVzqIEZq4D2aKsFOX9m6fXoDk4a
         XeSv8s2IyKLO5XR91XYBNGTbDTa1JfnNhjuQo1Nc5O9TrbUj1JFkZXDO2SepbzRqNd
         sHAG8ywKMKJ5Z9fsFmB/JVggnuwhAEhV6mE9lmCStu3zLrigRn6fwg1965AE/xpFxz
         dJSeGnTwVhdflIbrb1cEuHEjDLZBmmHrRj+an4aOLbJ65a7gOCtBNoVmM9JoDbYRfY
         irUm+mSJqzIrg==
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7ba0c234135so436216241.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 13:45:01 -0800 (PST)
X-Gm-Message-State: AOJu0YwPXikBlhbrQ8YCPSC82SHw9IDgCnpoun1bSDDfJwtgTHvqHVR6
        RowLwx3vTCEpQ3YOnmv2dkB1M9Pk+Q6FzYbVaYc=
X-Google-Smtp-Source: AGHT+IGWgUxsMWqvhjFpE3qj6fBRdmlXokDQN4yLM9mjNHFL3TTUYDLvp+F8lNIgmcv9Ll9lcoEDszBdkypNeY19KqY=
X-Received: by 2002:a1f:c707:0:b0:4af:f838:3ebf with SMTP id
 x7-20020a1fc707000000b004aff8383ebfmr230839vkf.3.1700171100717; Thu, 16 Nov
 2023 13:45:00 -0800 (PST)
MIME-Version: 1.0
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700083991.git.bcodding@redhat.com>
 <952eea7e97246870f83e7a4592e9338007dfe625.1700083991.git.bcodding@redhat.com>
In-Reply-To: <952eea7e97246870f83e7a4592e9338007dfe625.1700083991.git.bcodding@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 16 Nov 2023 16:44:44 -0500
X-Gmail-Original-Message-ID: <CAFX2Jfkc7p+22aK0KvN4yUerS1HuKDC+Njo_AJV1=5pWW0sUYQ@mail.gmail.com>
Message-ID: <CAFX2Jfkc7p+22aK0KvN4yUerS1HuKDC+Njo_AJV1=5pWW0sUYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFS: drop unused nfs_direct_req bytes_left
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben,

On Wed, Nov 15, 2023 at 4:34=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> Now that we're calculating how large a remaining IO should be based
> on the current request's offset, we no longer need to track bytes_left on
> each struct nfs_direct_req.  Drop the field, and clean up the direct
> request tracepoints.

I've been having problems with xfstests generic/465 on all NFS
versions after applying this patch. Looking at wireshark, the client
appears to be resending the same reads over and over again. Have you
seen anything like this in your testing?

Thanks,
Anna

>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/direct.c   | 4 ----
>  fs/nfs/internal.h | 1 -
>  fs/nfs/nfstrace.h | 6 ++----
>  3 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 5918c67dae0d..7167f588b1fc 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -369,7 +369,6 @@ static ssize_t nfs_direct_read_schedule_iovec(struct =
nfs_direct_req *dreq,
>                         bytes -=3D req_len;
>                         requested_bytes +=3D req_len;
>                         pos +=3D req_len;
> -                       dreq->bytes_left -=3D req_len;
>                 }
>                 nfs_direct_release_pages(pagevec, npages);
>                 kvfree(pagevec);
> @@ -441,7 +440,6 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
>                 goto out;
>
>         dreq->inode =3D inode;
> -       dreq->bytes_left =3D dreq->max_count =3D count;
>         dreq->io_start =3D iocb->ki_pos;
>         dreq->ctx =3D get_nfs_open_context(nfs_file_open_context(iocb->ki=
_filp));
>         l_ctx =3D nfs_get_lock_context(dreq->ctx);
> @@ -874,7 +872,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct=
 nfs_direct_req *dreq,
>                         bytes -=3D req_len;
>                         requested_bytes +=3D req_len;
>                         pos +=3D req_len;
> -                       dreq->bytes_left -=3D req_len;
>
>                         if (defer) {
>                                 nfs_mark_request_commit(req, NULL, &cinfo=
, 0);
> @@ -981,7 +978,6 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, str=
uct iov_iter *iter,
>                 goto out;
>
>         dreq->inode =3D inode;
> -       dreq->bytes_left =3D dreq->max_count =3D count;
>         dreq->io_start =3D pos;
>         dreq->ctx =3D get_nfs_open_context(nfs_file_open_context(iocb->ki=
_filp));
>         l_ctx =3D nfs_get_lock_context(dreq->ctx);
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index b1fa81c9dff6..e3722ce6722e 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -936,7 +936,6 @@ struct nfs_direct_req {
>         loff_t                  io_start;       /* Start offset for I/O *=
/
>         ssize_t                 count,          /* bytes actually process=
ed */
>                                 max_count,      /* max expected count */
> -                               bytes_left,     /* bytes left to be sent =
*/
>                                 error;          /* any reported error */
>         struct completion       completion;     /* wait for i/o completio=
n */
>
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 4e90ca531176..03cbc3893cef 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1539,7 +1539,6 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
>                         __field(u32, fhandle)
>                         __field(loff_t, offset)
>                         __field(ssize_t, count)
> -                       __field(ssize_t, bytes_left)
>                         __field(ssize_t, error)
>                         __field(int, flags)
>                 ),
> @@ -1554,19 +1553,18 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
>                         __entry->fhandle =3D nfs_fhandle_hash(fh);
>                         __entry->offset =3D dreq->io_start;
>                         __entry->count =3D dreq->count;
> -                       __entry->bytes_left =3D dreq->bytes_left;
>                         __entry->error =3D dreq->error;
>                         __entry->flags =3D dreq->flags;
>                 ),
>
>                 TP_printk(
>                         "error=3D%zd fileid=3D%02x:%02x:%llu fhandle=3D0x=
%08x "
> -                       "offset=3D%lld count=3D%zd bytes_left=3D%zd flags=
=3D%s",
> +                       "offset=3D%lld count=3D%zd flags=3D%s",
>                         __entry->error, MAJOR(__entry->dev),
>                         MINOR(__entry->dev),
>                         (unsigned long long)__entry->fileid,
>                         __entry->fhandle, __entry->offset,
> -                       __entry->count, __entry->bytes_left,
> +                       __entry->count,
>                         nfs_show_direct_req_flags(__entry->flags)
>                 )
>  );
> --
> 2.41.0
>
