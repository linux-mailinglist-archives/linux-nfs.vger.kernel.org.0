Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7B839BCE6
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFDQUu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Jun 2021 12:20:50 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:40947 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFDQUu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Jun 2021 12:20:50 -0400
Received: by mail-ed1-f45.google.com with SMTP id t3so11788435edc.7;
        Fri, 04 Jun 2021 09:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJ5cjXCOgtaH+RVcO+GAu8ygPECeGhi8hgXC8lzc7nA=;
        b=r5pPVjwJqyKvSU94RbaRUy3SqIVuou806o+AJe48Cs9IMTxGowFjFqAgzO57IfbHKn
         v6QQfmAH8IAc+cfaKsvlTy8VcXNG7Ln3+JZOKv6FDUEszhfEIpNoamLHwJ4iCG7pCXTg
         TJpzhqYbizUowz0G+I5BZWAlUwtT4YfoxmMOXEQxbGTiGO8BxjgJg4UWIaq5UNCGHcsp
         6dsnDRsWZstskwPwmXQJJ0qwVthSnyQtjGkHVgDc9awqSim6QTAufYb2xnrReToqFLGe
         mDgrfA3t3IjkOMr1DQRn47Ixy+edjv4cRnu45u0bWNHMbgnl/COr+mz0/lhVUd2k1AjN
         N7ZA==
X-Gm-Message-State: AOAM5310K+OtWgF4tyjnAcIRN/mhuwdP4zbPFtxhHfEzVU0mI+HcakBr
        RHyYvShgAE3TLmNeibOO1Ic3JxmUl24slgjdAKsC9cAJ
X-Google-Smtp-Source: ABdhPJxVhSUk2uKqdHMy8x0HDCUAC85wBWxWuxZsM9lt+YM7FXxwcjY2+VLMytCZfalSQljpUZf2R5hUjN64s+z9iK0=
X-Received: by 2002:a05:6402:524d:: with SMTP id t13mr5566749edd.209.1622823528589;
 Fri, 04 Jun 2021 09:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122137.1161772-1-zgxgoo@gmail.com>
In-Reply-To: <20210602122137.1161772-1-zgxgoo@gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 4 Jun 2021 12:18:32 -0400
Message-ID: <CAFX2Jfmg1Xh0yMr_8VL6=u0MRiN3jQ7TJa4Cd7NjM41+vSC-Eg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_fs=2Fnfs=3A_fix_some_=2DWmissing=2Dprototypes_wa?=
        =?UTF-8?Q?rnings_we_get_a_warning_when_building_kernel_with_W=3D1=3A_fs=2Fnf?=
        =?UTF-8?Q?s=2Fnfs4file=2Ec=3A318=3A1=3A_warning=3A_no_previous_prototype_for_=E2=80=98nf?=
        =?UTF-8?Q?s42=5Fssc=5Fopen=E2=80=99_=5B=2DWmissing=2Dprototypes=5D_fs=2Fnfs=2Fnfs4file=2Ec=3A402?=
        =?UTF-8?Q?=3A6=3A_warning=3A_no_previous_prototype_for_=E2=80=98nfs42=5Fssc=5Fclose=E2=80=99?=
        =?UTF-8?Q?_=5B=2DWmissing=2Dprototypes=5D?=
To:     Alex <zgxgoo@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Alex,

Thanks for the patch!

On Wed, Jun 2, 2021 at 8:26 AM Alex <zgxgoo@gmail.com> wrote:
>
> Add the missing declaration in head file fs/nfs/nfs4_fs.h to fix this.

It looks like the declarations are already in the file
linux/nfs_ssc.h, which is included by nfs4file.c but they're only
there if CONFIG_NFSD_V4_2_INTER_SSC=y (I'm guessing you compiled with
this set to 'n'). A better solution is probably to define a #else
condition with empty functions for the case when
CONFIG_NFSD_V4_2_INTER_SSC=n.

I hope this helps!
Anna

>
> Signed-off-by: Alex <zgxgoo@gmail.com>
> ---
>  fs/nfs/nfs4_fs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index 0c9505dc852c..0cb79afa0a63 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -656,4 +656,10 @@ static inline void nfs4_xattr_cache_zap(struct inode *inode)
>
>
>  #endif /* CONFIG_NFS_V4 */
> +
> +/* nfs4file.c */
> +#ifdef CONFIG_NFS_V4_2
> +struct file *nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh, nfs4_stateid *stateid);
> +void nfs42_ssc_close(struct file *filep);
> +#endif
>  #endif /* __LINUX_FS_NFS_NFS4_FS.H */
> --
> 2.25.1
>
