Return-Path: <linux-nfs+bounces-4220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA0912C63
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02816B2334A
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684713D521;
	Fri, 21 Jun 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrAYyOPz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5C155CA5
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990517; cv=none; b=ucD16sZavV3bFAJ7F4Io7bLapX7g2JJjlwEY+ceA3VBL2W5kvuTc/4NRW+rTgi38WDblXXATatMssHW+9xoJdduIKDxe2/EMkZIglprzPmnwrqjjWSM4XweoXmoov+pL3WfkgATM2FvP6DtIdhsaarIdvaqNYrVw3WNYFa7FBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990517; c=relaxed/simple;
	bh=LoTaCLhtPqTEkgskv3MVuRLsMSnvlQGs8cAYNuF6iss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qd3Oh31l0a1eTxdjLXSdeXI++dTKmwHzL3EBnIbL+NkeuyK1ytc2S1SmxGt6AlVbGKdF+vFOdtSn+05RLJEkoOoiH8unkMlfwKDqWgyLBa3TPPlJ9ObOWN1cjOLc3FkVb7KhYZCziCuAILP/b/OX6jbZ4zgv3ttpcdXo/cr5+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrAYyOPz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4405e343dd8so9451701cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718990514; x=1719595314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ka+X/b1d6Unv5qU60fi4oS7VfhS29MI0Wf/iGSFL7c=;
        b=HrAYyOPz3LFTKzd5TUvuUeKvAtM9q6FjGUNXQlvQTJ0GshzQmy1DDYtSXuQn4QHa9q
         kVs2wn0CSe58VATVAeMZgthfmpuELpOv6zm0kOG/NV1h+pP9sHVGfqDUluv3zBbtCMge
         mVslwDbB6pger8IwDuuTZCRZCo3dkzS+L58eRpcPU6j6JkYv9dKsmya/eOeSjmBbaCla
         LXpfq3WTcj/yQX3Rpo6r5gXpYA7CXs8ReCI+ofADZcP0PqRHisa5jFe6L1335YqlGrt8
         kbSda/evMVZytasB9NnjptuETWLBKd04+Jzr0DPAkq4DTw9ZpcaaF4oyoC+b/09aZlGS
         pr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718990514; x=1719595314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ka+X/b1d6Unv5qU60fi4oS7VfhS29MI0Wf/iGSFL7c=;
        b=Gt0VPWDXTfMdqLu8vKR9xcTLX34/t5EIZkq3hRSEYhg44KR2M/vnapmDhXHfEilcXn
         u0Bl/9Jr2hpRnWqrbpKNmKTWd5yX90MLePatxft3uYe7oinr47mlpD5PiucczfxaIEIX
         Juta2q2mcOA5Y0tzkl6piup7Lo+/PnveTRDphOk0T0Qi6x9mSAHWWj3ygBRc59y5/V1j
         nt86MGPXRKDykKyWlgk79YAhuMcaeiMDl5u7RA5hFNkN6djravrwqw0t4gAyZCeuf799
         nQ1h1+Phf4mKKjaqL4vRxjti94pjXem9XU7XhpzrK0+F30fy2/7Ns7WJ5xdC663bpQqX
         TQvQ==
X-Gm-Message-State: AOJu0Yzznf0O0sbR+eQSunEVAqsSNpxuNaCnzqXOUfDL+lj5Jw0LXbff
	8RPWZOpQ8tLrRN3onvHFV6PkW7YGYQHkZUOZj6x2+bEx3ks3TAGB1Cg0t4TdNQMeH2ZaIjLBgG+
	i6fQR9UZuoGekLka2nAWpwySIiCo=
X-Google-Smtp-Source: AGHT+IGsrAVxpRb1NxDNqzaT78cJrck2zLX4PtDOf1b0A6eMi3Np8FN6CIXrPtxKNQP7WLpvATb+D/3tandowoWCIN4=
X-Received: by 2002:a05:622a:10:b0:440:279c:f9eb with SMTP id
 d75a77b69052e-444a79bf5f9mr108992361cf.17.1718990514137; Fri, 21 Jun 2024
 10:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621162227.215412-6-cel@kernel.org> <20240621162227.215412-10-cel@kernel.org>
In-Reply-To: <20240621162227.215412-10-cel@kernel.org>
From: Anna Schumaker <schumaker.anna@gmail.com>
Date: Fri, 21 Jun 2024 13:21:37 -0400
Message-ID: <CAFX2JfmGmw1skjts2og5LkLFBwODc30CU=xUb0hr-h2Fe13ekw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] nfs/blocklayout: SCSI layout trace points for
 reservation key reg/unreg
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Fri, Jun 21, 2024 at 12:22=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> An administrator cannot take action on these messages, but the
> reported errors might be helpful for troubleshooting. Transition
> them to trace points so these events appear in the trace log and
> can be easily lined up with other traced NFS client operations.
>
> Examples:
>
>    append_writer-6147  [000]    80.247393: bl_pr_key_reg:        device=
=3Dsdb key=3D0x666dcdabf29514fe
>    append_writer-6147  [000]    80.247842: bl_pr_key_unreg:      device=
=3Dsdb key=3D0x666dcdabf29514fe
>
>      umount.nfs4-6172  [002]    84.950409: bl_pr_key_unreg_err:  device=
=3Dsdb key=3D0x666dcdabf29514fe error=3D24
>
> Christoph points out that:
> > ... Note that the disk_name isn't really what
> > we'd want to trace anyway, as it misses the partition information.
> > The normal way to print the device name is the %pg printk specifier,
> > but I'm not sure how to correctly use that for tracing which wants
> > a string in the entry for binary tracing.
>
> The trace points copy the pr_info() that they are replacing, and
> show only the parent device name and not the partition. I'm still
> looking into how to record both parts of the device name.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/blocklayout/dev.c | 30 +++++++-------
>  fs/nfs/nfs4trace.c       |  7 ++++
>  fs/nfs/nfs4trace.h       | 88 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+), 14 deletions(-)
>
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index 568f685dee4b..6c5d290ca81d 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -10,6 +10,7 @@
>  #include <linux/pr.h>
>
>  #include "blocklayout.h"
> +#include "../nfs4trace.h"
>
>  #define NFSDBG_FACILITY                NFSDBG_PNFS_LD
>
> @@ -26,12 +27,14 @@ bl_free_device(struct pnfs_block_dev *dev)
>                 if (test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags)=
) {
>                         struct block_device *bdev =3D file_bdev(dev->bdev=
_file);
>                         const struct pr_ops *ops =3D bdev->bd_disk->fops-=
>pr_ops;
> -                       int error;
> +                       int status;
>
> -                       error =3D ops->pr_register(file_bdev(dev->bdev_fi=
le),
> -                               dev->pr_key, 0, false);
> -                       if (error)
> -                               pr_err("failed to unregister PR key.\n");
> +                       status =3D ops->pr_register(bdev, dev->pr_key, 0,=
 false);
> +                       if (status)
> +                               trace_bl_pr_key_unreg_err(bdev, dev->pr_k=
ey,
> +                                                         status);
> +                       else
> +                               trace_bl_pr_key_unreg(bdev, dev->pr_key);
>                 }
>
>                 if (dev->bdev_file)
> @@ -243,10 +246,10 @@ static bool bl_pr_register_scsi(struct pnfs_block_d=
ev *dev)
>
>         status =3D ops->pr_register(bdev, 0, dev->pr_key, true);
>         if (status) {
> -               pr_err("pNFS: failed to register key for block device %s.=
",
> -                      bdev->bd_disk->disk_name);
> +               trace_bl_pr_key_reg_err(bdev, dev->pr_key, status);
>                 return false;
>         }
> +       trace_bl_pr_key_reg(bdev, dev->pr_key);
>         return true;
>  }
>
> @@ -351,8 +354,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_=
block_dev *d,
>                 struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mas=
k)
>  {
>         struct pnfs_block_volume *v =3D &volumes[idx];
> -       struct file *bdev_file;
> +       struct block_device *bdev;
>         const struct pr_ops *ops;
> +       struct file *bdev_file;
>         int error;
>
>         if (!bl_validate_designator(v))
> @@ -373,8 +377,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_=
block_dev *d,
>                 return PTR_ERR(bdev_file);
>         }
>         d->bdev_file =3D bdev_file;
> +       bdev =3D file_bdev(bdev_file);
>
> -       d->len =3D bdev_nr_bytes(file_bdev(d->bdev_file));
> +       d->len =3D bdev_nr_bytes(bdev);
>         d->map =3D bl_map_simple;
>         d->pr_key =3D v->scsi.pr_key;
>
> @@ -383,13 +388,10 @@ bl_parse_scsi(struct nfs_server *server, struct pnf=
s_block_dev *d,
>                 goto out_blkdev_put;
>         }
>
> -       pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
> -               file_bdev(d->bdev_file)->bd_disk->disk_name, d->pr_key);
> -
> -       ops =3D file_bdev(d->bdev_file)->bd_disk->fops->pr_ops;
> +       ops =3D bdev->bd_disk->fops->pr_ops;
>         if (!ops) {
>                 pr_err("pNFS: block device %s does not support reservatio=
ns.",
> -                               file_bdev(d->bdev_file)->bd_disk->disk_na=
me);
> +                               bdev->bd_disk->disk_name);
>                 error =3D -EINVAL;
>                 goto out_blkdev_put;
>         }
> diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
> index d22c6670f770..389941ccc9c9 100644
> --- a/fs/nfs/nfs4trace.c
> +++ b/fs/nfs/nfs4trace.c
> @@ -2,6 +2,8 @@
>  /*
>   * Copyright (c) 2013 Trond Myklebust <Trond.Myklebust@netapp.com>
>   */
> +#include <uapi/linux/pr.h>
> +#include <linux/blkdev.h>
>  #include <linux/nfs_fs.h>
>  #include "nfs4_fs.h"
>  #include "internal.h"
> @@ -29,5 +31,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_commit_error);
>
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg_err);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg_err);
> +
>  EXPORT_TRACEPOINT_SYMBOL_GPL(fl_getdevinfo);
>  #endif
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 4de8780a7c48..f2090a491fcb 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -2153,6 +2153,94 @@ TRACE_EVENT(ff_layout_commit_error,
>                 )
>  );
>
> +DECLARE_EVENT_CLASS(pnfs_bl_pr_key_class,
> +       TP_PROTO(
> +               const struct block_device *bdev,
> +               u64 key
> +       ),
> +       TP_ARGS(bdev, key),
> +       TP_STRUCT__entry(
> +               __field(u64, key)
> +               __field(dev_t, dev)
> +               __string(device, bdev->bd_disk->disk_name)
> +       ),
> +       TP_fast_assign(
> +               __entry->key =3D key;
> +               __entry->dev =3D bdev->bd_dev;
                                                ^^^^^^^
b4 tells me this patch adds trailing whitespace at the line above:

Patch failed at 0004 nfs/blocklayout: SCSI layout trace points for
reservation key reg/unreg
/home/anna/Projects/linux-nfs.git/.git/rebase-apply/patch:135:
trailing whitespace.
               __entry->dev =3D bdev->bd_dev;
/home/anna/Projects/linux-nfs.git/.git/rebase-apply/patch:188:
trailing whitespace.
               __entry->dev =3D bdev->bd_dev;
error: patch failed: fs/nfs/blocklayout/dev.c:383
error: fs/nfs/blocklayout/dev.c: patch does not apply

> +               __assign_str(device);
> +       ),
> +       TP_printk("dev=3D%d,%d (%s) key=3D0x%016llx",
> +               MAJOR(__entry->dev), MINOR(__entry->dev),
> +               __get_str(device), __entry->key
> +       )
> +);
> +
> +#define DEFINE_NFS4_BLOCK_PRKEY_EVENT(name) \
> +       DEFINE_EVENT(pnfs_bl_pr_key_class, name, \
> +               TP_PROTO( \
> +                       const struct block_device *bdev, \
> +                       u64 key \
> +               ), \
> +               TP_ARGS(bdev, key))
> +DEFINE_NFS4_BLOCK_PRKEY_EVENT(bl_pr_key_reg);
> +DEFINE_NFS4_BLOCK_PRKEY_EVENT(bl_pr_key_unreg);
> +
> +/*
> + * From uapi/linux/pr.h
> + */
> +TRACE_DEFINE_ENUM(PR_STS_SUCCESS);
> +TRACE_DEFINE_ENUM(PR_STS_IOERR);
> +TRACE_DEFINE_ENUM(PR_STS_RESERVATION_CONFLICT);
> +TRACE_DEFINE_ENUM(PR_STS_RETRY_PATH_FAILURE);
> +TRACE_DEFINE_ENUM(PR_STS_PATH_FAST_FAILED);
> +TRACE_DEFINE_ENUM(PR_STS_PATH_FAILED);
> +
> +#define show_pr_status(x) \
> +       __print_symbolic(x, \
> +               { PR_STS_SUCCESS,               "SUCCESS" }, \
> +               { PR_STS_IOERR,                 "IOERR" }, \
> +               { PR_STS_RESERVATION_CONFLICT,  "RESERVATION_CONFLICT" },=
 \
> +               { PR_STS_RETRY_PATH_FAILURE,    "RETRY_PATH_FAILURE" }, \
> +               { PR_STS_PATH_FAST_FAILED,      "PATH_FAST_FAILED" }, \
> +               { PR_STS_PATH_FAILED,           "PATH_FAILED" })
> +
> +DECLARE_EVENT_CLASS(pnfs_bl_pr_key_err_class,
> +       TP_PROTO(
> +               const struct block_device *bdev,
> +               u64 key,
> +               int status
> +       ),
> +       TP_ARGS(bdev, key, status),
> +       TP_STRUCT__entry(
> +               __field(u64, key)
> +               __field(dev_t, dev)
> +               __field(unsigned long, status)
> +               __string(device, bdev->bd_disk->disk_name)
> +       ),
> +       TP_fast_assign(
> +               __entry->key =3D key;
> +               __entry->dev =3D bdev->bd_dev;
                                                          ^^^^^^
And for this line, too.

Thanks,
Anna

> +               __entry->status =3D status;
> +               __assign_str(device);
> +       ),
> +       TP_printk("dev=3D%d,%d (%s) key=3D0x%016llx status=3D%s",
> +               MAJOR(__entry->dev), MINOR(__entry->dev),
> +               __get_str(device), __entry->key,
> +               show_pr_status(__entry->status)
> +       )
> +);
> +
> +#define DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(name) \
> +       DEFINE_EVENT(pnfs_bl_pr_key_err_class, name, \
> +               TP_PROTO( \
> +                       const struct block_device *bdev, \
> +                       u64 key, \
> +                       int status \
> +               ), \
> +               TP_ARGS(bdev, key, status))
> +DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(bl_pr_key_reg_err);
> +DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(bl_pr_key_unreg_err);
> +
>  #ifdef CONFIG_NFS_V4_2
>  TRACE_DEFINE_ENUM(NFS4_CONTENT_DATA);
>  TRACE_DEFINE_ENUM(NFS4_CONTENT_HOLE);
> --
> 2.45.1
>
>

