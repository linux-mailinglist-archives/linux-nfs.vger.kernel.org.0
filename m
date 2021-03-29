Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024E334D2F7
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2O6Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 29 Mar 2021 10:58:24 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36572 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhC2O6G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Mar 2021 10:58:06 -0400
Received: by mail-lf1-f46.google.com with SMTP id n138so18916926lfa.3;
        Mon, 29 Mar 2021 07:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=faG4TU2vNgmCikSBekGZBz25Hr88VzPfl/YRL0OakNk=;
        b=GuFQwncG8RT/REvulOWuUFBt8BHPb+/FwvRBN2gGQr/dlVrc/4N6s1D1wxyX2xcZZ8
         OYxWgwEoeoO2+A05V1lR3hOo4nivfnj5YbNdqEAuRzXk/50X3V2XYGjEPK516qj7NKLE
         RH/qTt5lZxVz5mnLgvApwbwjwLhpcLu7ItbJhlC7hmGwqGt3QHVTqyVL0tUpzFP3cmeo
         BP9ToP/9ar5/3kg4Rz7LNkZYzjFXBLiUKT8qDnEDP9Wa2auFjBhpN+7dYPMLNERuflKy
         QKJton/ElFP3Yyf1R2J7TAnFmPhpQ63wLLJGjdmxoEoZDfrzMcdvTPlueMHWjf1PLJFV
         1YZg==
X-Gm-Message-State: AOAM532Gb6Jug2/3FeFBkubrfP20OZXmlfChfNZfKdpehjGkqE2uRwuY
        zfk8vQ0XfDTebbtbQkdG/WWTdS3WboCLGV7muutrJpDgEdyaEw==
X-Google-Smtp-Source: ABdhPJxCgX195e5PeWrEnM6BVpuIityMdSJCA2H/BXYHo3e0Vq6ecNuGbpojxy9Cin10bzIL+xdZBJBo/8Yuj9zVPaE=
X-Received: by 2002:a05:6512:33ca:: with SMTP id d10mr16376219lfg.170.1617029885141;
 Mon, 29 Mar 2021 07:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210323224858.GA293698@embeddedor>
In-Reply-To: <20210323224858.GA293698@embeddedor>
Reply-To: chucklever@gmail.com
From:   Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 29 Mar 2021 10:57:54 -0400
Message-ID: <CAFMMQGtZLNt-jsFFEJVGZaOQyVxckXEGbtan8oDZ-WUNSHkGWg@mail.gmail.com>
Subject: Re: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry for the reply via gmail, the original patch did not show up in
my Oracle mailbox.

I've been waiting for a resolution of this thread (and perhaps a
Reviewed-by). But in
the meantime I've committed this, provisionally, to the for-next topic branch in

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

On Wed, Mar 24, 2021 at 4:39 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> Use an anonymous union with a couple of anonymous structs in order to
> keep userspace unchanged:
>
> $ pahole -C nfs_fhbase_new fs/nfsd/nfsfh.o
> struct nfs_fhbase_new {
>         union {
>                 struct {
>                         __u8       fb_version_aux;       /*     0     1 */
>                         __u8       fb_auth_type_aux;     /*     1     1 */
>                         __u8       fb_fsid_type_aux;     /*     2     1 */
>                         __u8       fb_fileid_type_aux;   /*     3     1 */
>                         __u32      fb_auth[1];           /*     4     4 */
>                 };                                       /*     0     8 */
>                 struct {
>                         __u8       fb_version;           /*     0     1 */
>                         __u8       fb_auth_type;         /*     1     1 */
>                         __u8       fb_fsid_type;         /*     2     1 */
>                         __u8       fb_fileid_type;       /*     3     1 */
>                         __u32      fb_auth_flex[0];      /*     4     0 */
>                 };                                       /*     0     4 */
>         };                                               /*     0     8 */
>
>         /* size: 8, cachelines: 1, members: 1 */
>         /* last cacheline: 8 bytes */
> };
>
> Also, this helps with the ongoing efforts to enable -Warray-bounds by
> fixing the following warnings:
>
> fs/nfsd/nfsfh.c: In function ‘nfsd_set_fh_dentry’:
> fs/nfsd/nfsfh.c:191:41: warning: array subscript 1 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>   191 |        ntohl((__force __be32)fh->fh_fsid[1])));
>       |                              ~~~~~~~~~~~^~~
> ./include/linux/kdev_t.h:12:46: note: in definition of macro ‘MKDEV’
>    12 | #define MKDEV(ma,mi) (((ma) << MINORBITS) | (mi))
>       |                                              ^~
> ./include/uapi/linux/byteorder/little_endian.h:40:26: note: in expansion of macro ‘__swab32’
>    40 | #define __be32_to_cpu(x) __swab32((__force __u32)(__be32)(x))
>       |                          ^~~~~~~~
> ./include/linux/byteorder/generic.h:136:21: note: in expansion of macro ‘__be32_to_cpu’
>   136 | #define ___ntohl(x) __be32_to_cpu(x)
>       |                     ^~~~~~~~~~~~~
> ./include/linux/byteorder/generic.h:140:18: note: in expansion of macro ‘___ntohl’
>   140 | #define ntohl(x) ___ntohl(x)
>       |                  ^~~~~~~~
> fs/nfsd/nfsfh.c:191:8: note: in expansion of macro ‘ntohl’
>   191 |        ntohl((__force __be32)fh->fh_fsid[1])));
>       |        ^~~~~
> fs/nfsd/nfsfh.c:192:32: warning: array subscript 2 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>   192 |    fh->fh_fsid[1] = fh->fh_fsid[2];
>       |                     ~~~~~~~~~~~^~~
> fs/nfsd/nfsfh.c:192:15: warning: array subscript 1 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>   192 |    fh->fh_fsid[1] = fh->fh_fsid[2];
>       |    ~~~~~~~~~~~^~~
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/uapi/linux/nfsd/nfsfh.h | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nfsfh.h
> index ff0ca88b1c8f..427294dd56a1 100644
> --- a/include/uapi/linux/nfsd/nfsfh.h
> +++ b/include/uapi/linux/nfsd/nfsfh.h
> @@ -64,13 +64,24 @@ struct nfs_fhbase_old {
>   *   in include/linux/exportfs.h for currently registered values.
>   */
>  struct nfs_fhbase_new {
> -       __u8            fb_version;     /* == 1, even => nfs_fhbase_old */
> -       __u8            fb_auth_type;
> -       __u8            fb_fsid_type;
> -       __u8            fb_fileid_type;
> -       __u32           fb_auth[1];
> -/*     __u32           fb_fsid[0]; floating */
> -/*     __u32           fb_fileid[0]; floating */
> +       union {
> +               struct {
> +                       __u8            fb_version_aux; /* == 1, even => nfs_fhbase_old */
> +                       __u8            fb_auth_type_aux;
> +                       __u8            fb_fsid_type_aux;
> +                       __u8            fb_fileid_type_aux;
> +                       __u32           fb_auth[1];
> +                       /*      __u32           fb_fsid[0]; floating */
> +                       /*      __u32           fb_fileid[0]; floating */
> +               };
> +               struct {
> +                       __u8            fb_version;     /* == 1, even => nfs_fhbase_old */
> +                       __u8            fb_auth_type;
> +                       __u8            fb_fsid_type;
> +                       __u8            fb_fileid_type;
> +                       __u32           fb_auth_flex[]; /* flexible-array member */
> +               };
> +       };
>  };
>
>  struct knfsd_fh {
> @@ -97,7 +108,7 @@ struct knfsd_fh {
>  #define        fh_fsid_type            fh_base.fh_new.fb_fsid_type
>  #define        fh_auth_type            fh_base.fh_new.fb_auth_type
>  #define        fh_fileid_type          fh_base.fh_new.fb_fileid_type
> -#define        fh_fsid                 fh_base.fh_new.fb_auth
> +#define        fh_fsid                 fh_base.fh_new.fb_auth_flex
>
>  /* Do not use, provided for userspace compatiblity. */
>  #define        fh_auth                 fh_base.fh_new.fb_auth
> --
> 2.27.0
>


-- 
When the world is being engulfed by a comet, go ahead and excrete
where you want to.
