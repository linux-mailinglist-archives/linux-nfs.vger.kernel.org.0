Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414B26F1EF8
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjD1TyD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 15:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbjD1TyC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 15:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C258359C
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 12:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C159060FBF
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 19:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDB5C433D2
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682711640;
        bh=mmA731S5SbhaKcTMkTi/cAwxVpbAF6Hb/QTkDuy6wqw=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=RcL6/otaHRt0uTp28od08sXuTYmu7I03yRf5uGRwY8zr7hCK0UyQsRtDkmXhEj9C/
         d44Td8Al1R7uqaIl1/yVTMdrWioAb7n/sj5pQDfRFpRiDDwEeBY43fld+F6dSu9sK2
         Jj++QPGi1k03+TRylAD4z3oZB/3JhFUbt/C2evzfC1/XH7xOL6UnGi4CnVJJsyBnJ/
         Cn4q4XKdhXyKzdtHzyjOkQVPHtDZz6Vu043fgQJvov8WjTsBehz+MR5x7mwROFjvje
         FxaV6YZwnLZGtJXDngI02q0XcRabCg/cKLsvydIvs6rPS2ZJyBXSuFwRYcml6t4+9H
         23pkekXI+cuWA==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-3ef69281e68so1598741cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 12:54:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDxhLTdFxhk8GxRNUQ91me73YTedDRKM4+5jUZ/DlVC+4wkVPITa
        H/FCH1daYw6U0fr8GQGDe0bTQMt0LF4gecMQzDA=
X-Google-Smtp-Source: ACHHUZ5wYY/zVMJ4DWab3qkn4fQX8k88l7OVRgxbnwyC4PvlQbSK+33FgK/DOBKzaul+i+MVAKc119rRPKK9cg4oNiA=
X-Received: by 2002:a05:622a:60c:b0:3f0:a892:3c0e with SMTP id
 z12-20020a05622a060c00b003f0a8923c0emr10148773qta.47.1682711639238; Fri, 28
 Apr 2023 12:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230428195215.234246-1-anna@kernel.org>
In-Reply-To: <20230428195215.234246-1-anna@kernel.org>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 28 Apr 2023 15:53:43 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfmezew=2JjLkygdu79pAXm=pmbnF2fjN6+rMWDpOiAB9Q@mail.gmail.com>
Message-ID: <CAFX2Jfmezew=2JjLkygdu79pAXm=pmbnF2fjN6+rMWDpOiAB9Q@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: Rework scratch handling for READ_PLUS
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry about the repost, I accidentally pointed a script to the wrong file!

Anna

On Fri, Apr 28, 2023 at 3:52=E2=80=AFPM Anna Schumaker <anna@kernel.org> wr=
ote:
>
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> Instead of using a tiny, static scratch buffer, we should use a kmalloc()=
-ed
> buffer that is allocated when checking for read plus usage. This lets us
> use the buffer before decoding any part of the READ_PLUS operation
> instead of setting it right before segment decoding, meaning it should
> be a little more robust.
>
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  fs/nfs/nfs42xdr.c       |  4 ++--
>  fs/nfs/nfs4proc.c       | 17 ++++++++++++-----
>  include/linux/nfs_xdr.h |  1 +
>  3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index d80ee88ca996..a6df815a140c 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -1122,7 +1122,6 @@ static int decode_read_plus(struct xdr_stream *xdr,=
 struct nfs_pgio_res *res)
>         uint32_t segments;
>         struct read_plus_segment *segs;
>         int status, i;
> -       char scratch_buf[16];
>         __be32 *p;
>
>         status =3D decode_op_hdr(xdr, OP_READ_PLUS);
> @@ -1143,7 +1142,6 @@ static int decode_read_plus(struct xdr_stream *xdr,=
 struct nfs_pgio_res *res)
>         if (!segs)
>                 return -ENOMEM;
>
> -       xdr_set_scratch_buffer(xdr, &scratch_buf, sizeof(scratch_buf));
>         status =3D -EIO;
>         for (i =3D 0; i < segments; i++) {
>                 status =3D decode_read_plus_segment(xdr, &segs[i]);
> @@ -1348,6 +1346,8 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *=
rqstp,
>         struct compound_hdr hdr;
>         int status;
>
> +       xdr_set_scratch_buffer(xdr, res->scratch, sizeof(res->scratch));
> +
>         status =3D decode_compound_hdr(xdr, &hdr);
>         if (status)
>                 goto out;
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 5607b1e2b821..18f25ff4bff7 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5439,6 +5439,8 @@ static bool nfs4_read_plus_not_supported(struct rpc=
_task *task,
>
>  static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header =
*hdr)
>  {
> +       if (hdr->res.scratch)
> +               kfree(hdr->res.scratch);
>         if (!nfs4_sequence_done(task, &hdr->res.seq_res))
>                 return -EAGAIN;
>         if (nfs4_read_stateid_changed(task, &hdr->args))
> @@ -5452,17 +5454,22 @@ static int nfs4_read_done(struct rpc_task *task, =
struct nfs_pgio_header *hdr)
>  }
>
>  #if defined CONFIG_NFS_V4_2 && defined CONFIG_NFS_V4_2_READ_PLUS
> -static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
> +static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
>                                     struct rpc_message *msg)
>  {
>         /* Note: We don't use READ_PLUS with pNFS yet */
> -       if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds=
_clp)
> +       if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds=
_clp) {
>                 msg->rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_READ_PLU=
S];
> +               hdr->res.scratch =3D kmalloc(32, GFP_KERNEL);
> +               return hdr->res.scratch !=3D NULL;
> +       }
> +       return false;
>  }
>  #else
> -static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
> +static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
>                                     struct rpc_message *msg)
>  {
> +       return false;
>  }
>  #endif /* CONFIG_NFS_V4_2 */
>
> @@ -5472,8 +5479,8 @@ static void nfs4_proc_read_setup(struct nfs_pgio_he=
ader *hdr,
>         hdr->timestamp   =3D jiffies;
>         if (!hdr->pgio_done_cb)
>                 hdr->pgio_done_cb =3D nfs4_read_done_cb;
> -       msg->rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_READ];
> -       nfs42_read_plus_support(hdr, msg);
> +       if (!nfs42_read_plus_support(hdr, msg))
> +               msg->rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_READ];
>         nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
>  }
>
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index e86cf6642d21..2fd973d188c4 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -670,6 +670,7 @@ struct nfs_pgio_res {
>                 struct {
>                         unsigned int            replen;         /* used b=
y read */
>                         int                     eof;            /* used b=
y read */
> +                       void *                  scratch;        /* used b=
y read */
>                 };
>                 struct {
>                         struct nfs_writeverf *  verf;           /* used b=
y write */
> --
> 2.40.0
>
