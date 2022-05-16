Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409C6528AA4
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbiEPQfO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 12:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbiEPQfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 12:35:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567E3BA54
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 09:35:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dk23so29746939ejb.8
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drBwZ3kZrAODzvtQSn7MfQgTCaWXGPGql0QGqZTR2FE=;
        b=KQL7+QFYo2r8Sd9Pf0aqedX4k5zNhcuWKXrtLX9YIJuMLdbJei9DvlZckzIoNVBlav
         Y/hAJG1cWwgAbGKG5JNPIVsuGXgI4PBulp3lQ60AEtdqpdvi9zSCZs4GlRk1gf380els
         Rrssszjk43gUSgWS6qRsv/4jn4YxXz9uXQrWgkl/C98jnJ6uchoISYwXQKo9wyAliXU0
         Boq3qkW4DJGauPtrg93b5ZKBL3Hqxy2GP9CC4N5Vl6bNXRcYiYREAiCeHDW6veWeUChA
         KCRanN3a/BjYwVDMqbJqJ/rphiivcHQyA9A+/MSU0owYJJ5SyQEKfiYi27OeT5ptkkm8
         TxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drBwZ3kZrAODzvtQSn7MfQgTCaWXGPGql0QGqZTR2FE=;
        b=NsxqWu7tw+3P0qGVcawLzLi8HF2Q9t9Ws8kadCjEIXB6qP2/609uzSSu0vzTQtUgWG
         RtbPuzV5EkXsu087YkXTbIG1DoZBh7tMzvv0ytX6JXtxGZxXA+JdpqxO/eTtZKgO84i1
         Dc0yaF1x8cakJrZlNL5MrQxgx69VjVLRoMgJfcB8DkSLit4GZtMG4sbTe0H9g4u37kLI
         BA6N5uyLuDl3KOLPYNdjDhMwvYCSwfVLiu7hFBBm7Uo5+ob4oPtbJxE3RyCuzNeLsQaI
         m9k8cKRR0GhDEEh+iMHp+O4TpZrX3BZnynKXmOH8mPzBf26NtlibtWbl/5EO+TSXjMdo
         U28Q==
X-Gm-Message-State: AOAM533A8EWSIDI3C021fAmzIlx6MlS8Ba6AEQgJyTUz5x0+1d/GiCGM
        Gj2TyZSNfgipSfI993vB9oges2T6OFPgQotK03ea1jaa
X-Google-Smtp-Source: ABdhPJyH4CEacFLIAvDvTVcOhzqM76zcAioiClFVxlK82pOZQaiFJdZZ3aeDD0ngwsaXAIAlP4rKitFoXEccs0zAeDE=
X-Received: by 2002:a17:907:6d26:b0:6f4:bba2:ebbb with SMTP id
 sa38-20020a1709076d2600b006f4bba2ebbbmr15923958ejc.699.1652718908716; Mon, 16
 May 2022 09:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220413132207.52825-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20220413132207.52825-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 16 May 2022 12:34:57 -0400
Message-ID: <CAN-5tyFJeLWi5UYYSvaYspwOn3VhGMQkKx-QQkXSX1ZR+guD8g@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1 mark qualified async operations as MOVEABLE tasks
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond and Anna,

Any update on taking this patch? Thank you.

On Wed, Apr 13, 2022 at 9:22 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Mark async operations such as RENAME, REMOVE, COMMIT MOVEABLE
> for the nfsv4.1+ sessions.
>
> Fixes: 85e39feead948 ("NFSv4.1 identify and mark RPC tasks that can move between transports")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4proc.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 16106f805ffa..f593bad996af 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4780,7 +4780,11 @@ static void nfs4_proc_unlink_setup(struct rpc_message *msg,
>
>  static void nfs4_proc_unlink_rpc_prepare(struct rpc_task *task, struct nfs_unlinkdata *data)
>  {
> -       nfs4_setup_sequence(NFS_SB(data->dentry->d_sb)->nfs_client,
> +       struct nfs_client *clp = NFS_SB(data->dentry->d_sb)->nfs_client;
> +
> +       if (clp->cl_minorversion)
> +               task->tk_flags |= RPC_TASK_MOVEABLE;
> +       nfs4_setup_sequence(clp,
>                         &data->args.seq_args,
>                         &data->res.seq_res,
>                         task);
> @@ -4823,7 +4827,11 @@ static void nfs4_proc_rename_setup(struct rpc_message *msg,
>
>  static void nfs4_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renamedata *data)
>  {
> -       nfs4_setup_sequence(NFS_SERVER(data->old_dir)->nfs_client,
> +       struct nfs_client *clp = NFS_SERVER(data->old_dir)->nfs_client;
> +
> +       if (clp->cl_minorversion)
> +               task->tk_flags |= RPC_TASK_MOVEABLE;
> +       nfs4_setup_sequence(clp,
>                         &data->args.seq_args,
>                         &data->res.seq_res,
>                         task);
> @@ -5457,7 +5465,11 @@ static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
>  static int nfs4_proc_pgio_rpc_prepare(struct rpc_task *task,
>                                       struct nfs_pgio_header *hdr)
>  {
> -       if (nfs4_setup_sequence(NFS_SERVER(hdr->inode)->nfs_client,
> +       struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
> +
> +       if (clp->cl_minorversion)
> +               task->tk_flags |= RPC_TASK_MOVEABLE;
> +       if (nfs4_setup_sequence(clp,
>                         &hdr->args.seq_args,
>                         &hdr->res.seq_res,
>                         task))
> @@ -5595,7 +5607,11 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
>
>  static void nfs4_proc_commit_rpc_prepare(struct rpc_task *task, struct nfs_commit_data *data)
>  {
> -       nfs4_setup_sequence(NFS_SERVER(data->inode)->nfs_client,
> +       struct nfs_client *clp = NFS_SERVER(data->inode)->nfs_client;
> +
> +       if (clp->cl_minorversion)
> +               task->tk_flags |= RPC_TASK_MOVEABLE;
> +       nfs4_setup_sequence(clp,
>                         &data->args.seq_args,
>                         &data->res.seq_res,
>                         task);
> --
> 2.27.0
>
