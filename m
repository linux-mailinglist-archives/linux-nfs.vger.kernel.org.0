Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248F4711050
	for <lists+linux-nfs@lfdr.de>; Thu, 25 May 2023 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbjEYQDq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 May 2023 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbjEYQDo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 May 2023 12:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6913C10B
        for <linux-nfs@vger.kernel.org>; Thu, 25 May 2023 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685030572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiRt50oXKhasmrzR2kh6FHaULiNwoG0spSQORGoTHTA=;
        b=WNYhwdjTeOYsSg1WqmAqLbtvBkqyA1fjxWwNqF1oMMDUvPNQ/OybetPHAO+MNiC4fw5blv
        JvdY1QWhnVKgzpLAXeeI37HK0m6aJQ5nri2uyg2704j3GvwyPNhNlSu7ehb+raz6RK6nir
        MKQ9Ne6XGE3vq4Nz8zUiqFPRKnXz5zI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-tY1k8MNOPXyk70uURub3Lg-1; Thu, 25 May 2023 12:02:51 -0400
X-MC-Unique: tY1k8MNOPXyk70uURub3Lg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-528cb2ec137so1108082a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 May 2023 09:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030570; x=1687622570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiRt50oXKhasmrzR2kh6FHaULiNwoG0spSQORGoTHTA=;
        b=CJGO5Hapexj2D0rQ4hKcryBrB00kf7kU4VwbNy5Dev76qtRVps1Q91h7CnRh4LaAwZ
         Dy26D3I4rZmDRyOmD/2rMyNm2+n+n1SOsmYC9/r+Y7UOF650FofJuUu22DI6NkMZbsvQ
         ny4kUzRM/ignnQg0477cKm+dRQuSBUir8DRmZYS8gDZqNM5XQGhfiozptH2vPkUtaaMC
         EmPp2IUrjUKHQidG1vo70l4M2mp8fSnvY1Hjj4svsvEXHRHfK3BO5wbHEKUiLbiL7xw4
         AGNbQp3uxyqFFfZnPADyLOGgy7ZnMegtRBIP5nKv0KhnVqRngRrLfLHZ9zqT2Wzx/RcL
         6g/w==
X-Gm-Message-State: AC+VfDxo7+kBdeHwLr7V8p1lyFhyJxdbiLpG0JTSXKPPlGt4dd8hRPUM
        mfXFituNQPmGpi8lU89BgAhAl1tlJUkdALz/msxmqkaaHbL2BcflfBsG25cedifmVwR7X8pipiy
        2xSF/z4380XHWztRxkxVpB9lOTczUmisBNrGl
X-Received: by 2002:a17:902:f54c:b0:1af:f64c:f363 with SMTP id h12-20020a170902f54c00b001aff64cf363mr3052067plf.15.1685030569934;
        Thu, 25 May 2023 09:02:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IxaSUVZPKltFK7HOITIsIRGnmd5NzIdTwh6dJNU2vgkdbKhe1zl+1aodXLLyyl7kcWSFpgVAL2XCU4JAoynY=
X-Received: by 2002:a17:902:f54c:b0:1af:f64c:f363 with SMTP id
 h12-20020a170902f54c00b001aff64cf363mr3052030plf.15.1685030569588; Thu, 25
 May 2023 09:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230524063810.1595778-1-hch@lst.de> <20230524063810.1595778-8-hch@lst.de>
In-Reply-To: <20230524063810.1595778-8-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 25 May 2023 18:02:37 +0200
Message-ID: <CAHc6FU6akk6yg1YGpgq-XqMv7soOLA4_Jg17T1M+NKn1PRmJkg@mail.gmail.com>
Subject: Re: [PATCH 07/11] iomap: update ki_pos in iomap_file_buffered_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 24, 2023 at 8:54=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> All callers of iomap_file_buffered_write need to updated ki_pos, move it
> into common code.

Thanks for this set of cleanups, especially for the patch killing
current->backing_dev_info.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/gfs2/file.c         | 4 +---
>  fs/iomap/buffered-io.c | 9 ++++++---
>  fs/xfs/xfs_file.c      | 2 --
>  fs/zonefs/file.c       | 4 +---
>  4 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 904a0d6ac1a1a9..c6a7555d5ad8bb 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1044,10 +1044,8 @@ static ssize_t gfs2_file_buffered_write(struct kio=
cb *iocb,
>         pagefault_disable();
>         ret =3D iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
>         pagefault_enable();
> -       if (ret > 0) {
> -               iocb->ki_pos +=3D ret;
> +       if (ret > 0)
>                 written +=3D ret;
> -       }
>
>         if (inode =3D=3D sdp->sd_rindex)
>                 gfs2_glock_dq_uninit(statfs_gh);
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 063133ec77f49e..550525a525c45c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -864,16 +864,19 @@ iomap_file_buffered_write(struct kiocb *iocb, struc=
t iov_iter *i,
>                 .len            =3D iov_iter_count(i),
>                 .flags          =3D IOMAP_WRITE,
>         };
> -       int ret;
> +       ssize_t ret;
>
>         if (iocb->ki_flags & IOCB_NOWAIT)
>                 iter.flags |=3D IOMAP_NOWAIT;
>
>         while ((ret =3D iomap_iter(&iter, ops)) > 0)
>                 iter.processed =3D iomap_write_iter(&iter, i);
> -       if (iter.pos =3D=3D iocb->ki_pos)
> +
> +       if (unlikely(ret < 0))
>                 return ret;
> -       return iter.pos - iocb->ki_pos;
> +       ret =3D iter.pos - iocb->ki_pos;
> +       iocb->ki_pos +=3D ret;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 431c3fd0e2b598..d57443db633637 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -720,8 +720,6 @@ xfs_file_buffered_write(
>         trace_xfs_file_buffered_write(iocb, from);
>         ret =3D iomap_file_buffered_write(iocb, from,
>                         &xfs_buffered_write_iomap_ops);
> -       if (likely(ret >=3D 0))
> -               iocb->ki_pos +=3D ret;
>
>         /*
>          * If we hit a space limit, try to free up some lingering preallo=
cated
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 132f01d3461f14..e212d0636f848e 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -643,9 +643,7 @@ static ssize_t zonefs_file_buffered_write(struct kioc=
b *iocb,
>                 goto inode_unlock;
>
>         ret =3D iomap_file_buffered_write(iocb, from, &zonefs_write_iomap=
_ops);
> -       if (ret > 0)
> -               iocb->ki_pos +=3D ret;
> -       else if (ret =3D=3D -EIO)
> +       if (ret =3D=3D -EIO)
>                 zonefs_io_error(inode, true);
>
>  inode_unlock:
> --
> 2.39.2
>

