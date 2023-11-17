Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE07EF4FA
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 16:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjKQPQx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 10:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQPQw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 10:16:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53FD57
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 07:16:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C109C433C9
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700234209;
        bh=rzdTtGq8+YDjnbwXqHnHuokXpoEfkz9nXuVvXAUg4tY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cNSTmCWk0fdedpwUcxfG+VYy8fXSewnLkfkqJpu2uJaMiyXPoJS+IVljN6l2ehcBf
         yUS8MWPFEOzh54V7Y3VjQMPys0I13yRwCWgDylYgI1qV6Yldgklh741Wa3YmNyOAm1
         CW+5QTRAk0I2PJ19DlKrm/VzDX3U0F4L6BRGESK9e2UE+olxDml/JxGCK2ZgG62zlv
         SHl2aGGffpgdS0TRNY2+6CbGFRMGr6pNKVZ0YJqqCVFDQbk0xConejbn+gssO0TYt+
         4bowe2Q7w0tTMt4gt3Twrpyd9GgkD376OahPrGLZY70azEARBmveV3Z9uJ5fl9evCb
         gpy/IUQc+Rmow==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-41ea8debcdaso11371071cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 07:16:49 -0800 (PST)
X-Gm-Message-State: AOJu0YzdktF7MxOcxoBcLyCzGqXRjipDmyktxDsgzV0RBEBveT+XPRPj
        Snh2NLSWUnTVzmQWuKbcZppNZCkwi8s++Ij1DpA=
X-Google-Smtp-Source: AGHT+IEI6g7JolSAmNnTaP24peBf/7xG0VVRn4iIQje+mo3hk1NaEDAJmWA4EHGHRlQR7T//Exlr73G/2/Y4MHtbdRg=
X-Received: by 2002:a05:622a:315:b0:41e:1c35:91d6 with SMTP id
 q21-20020a05622a031500b0041e1c3591d6mr14856010qtw.39.1700234208368; Fri, 17
 Nov 2023 07:16:48 -0800 (PST)
MIME-Version: 1.0
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700220277.git.bcodding@redhat.com>
 <0bdf152bc69f7dcf91c9c70ffcbab92ac03682f0.1700220277.git.bcodding@redhat.com>
In-Reply-To: <0bdf152bc69f7dcf91c9c70ffcbab92ac03682f0.1700220277.git.bcodding@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 17 Nov 2023 10:16:32 -0500
X-Gmail-Original-Message-ID: <CAFX2Jf=CW0wDYd1U6eqzJoyvmejnD9vnSTCCWfGG8NL_nxe4aw@mail.gmail.com>
Message-ID: <CAFX2Jf=CW0wDYd1U6eqzJoyvmejnD9vnSTCCWfGG8NL_nxe4aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] NFS: drop unused nfs_direct_req bytes_left
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben,

On Fri, Nov 17, 2023 at 6:25=E2=80=AFAM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> Now that we're calculating how large a remaining IO should be based
> on the current request's offset, we no longer need to track bytes_left on
> each struct nfs_direct_req.  Drop the field, and clean up the direct
> request tracepoints.

v2 works better for me! Thanks for fixing that up!

Anna

>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/direct.c   | 6 ++----
>  fs/nfs/internal.h | 1 -
>  fs/nfs/nfstrace.h | 6 ++----
>  3 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 5918c67dae0d..c03926a1cc73 100644
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
> @@ -441,7 +440,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
>                 goto out;
>
>         dreq->inode =3D inode;
> -       dreq->bytes_left =3D dreq->max_count =3D count;
> +       dreq->max_count =3D count;
>         dreq->io_start =3D iocb->ki_pos;
>         dreq->ctx =3D get_nfs_open_context(nfs_file_open_context(iocb->ki=
_filp));
>         l_ctx =3D nfs_get_lock_context(dreq->ctx);
> @@ -874,7 +873,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct=
 nfs_direct_req *dreq,
>                         bytes -=3D req_len;
>                         requested_bytes +=3D req_len;
>                         pos +=3D req_len;
> -                       dreq->bytes_left -=3D req_len;
>
>                         if (defer) {
>                                 nfs_mark_request_commit(req, NULL, &cinfo=
, 0);
> @@ -981,7 +979,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, str=
uct iov_iter *iter,
>                 goto out;
>
>         dreq->inode =3D inode;
> -       dreq->bytes_left =3D dreq->max_count =3D count;
> +       dreq->max_count =3D count;
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
