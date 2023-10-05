Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19947BAB8C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjJEUkS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJEUkR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 16:40:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2791B95;
        Thu,  5 Oct 2023 13:40:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBEDC433CB;
        Thu,  5 Oct 2023 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696538415;
        bh=mW1UI3u88BsWwD9VAiLaVyhING6a02v02PCJjmQjewU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X6QRxBkmmaBoBQTnjkrSp2OKJSiQaqShHMBq8TeHmoq1VhIQNvfFw+JyazjaOaVIm
         aD2ZLI5p/7+fftlhO/ZjJOdeHFeH1rxeuHDfAf8PMLROFmctwtkOTzpfTGC10lueYe
         Tr3HlgtXg3lViFrx1/5tRnfV8BL2FAST0G0KO/bZJ/Ft3L8TsH/xBzNYx3r1mEAev4
         O1dCSRfEqi43ip4N9d7gX0RXSd6NrvJrFP0/jo2geCivuDX7QvqVYaCz7Lp4346Hv8
         aZsY6oG5uZH8+hTtqHUjMe1YQkptddTzT2rUcD+Lf+viLGo/sD7ekLwHbyBtyz6gcg
         cnc+YPijfsYoQ==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-419cc494824so6905131cf.2;
        Thu, 05 Oct 2023 13:40:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx3h0TBQgNHVhkHWPU7uuE3N6buDSRU7WgeE+Wgasrfx9BLngeh
        eCntkqaCTblT3k/mAKzDbNMgWQJwTWSp4emNUQ8=
X-Google-Smtp-Source: AGHT+IEvfeeB4HFpxRNoDCCpQmy0Icz9w0ozf2ZiyWAdtBaFEI4oE2spkokMMY0Ne7h5qDzKkOvdyQiEmCGipWZYl9Q=
X-Received: by 2002:a05:622a:104e:b0:419:51db:5c with SMTP id
 f14-20020a05622a104e00b0041951db005cmr7546095qte.32.1696538414712; Thu, 05
 Oct 2023 13:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <5577791deaa898578c8e8f86336eaca053d9efdd.1687890438.git.bcodding@redhat.com>
In-Reply-To: <5577791deaa898578c8e8f86336eaca053d9efdd.1687890438.git.bcodding@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 5 Oct 2023 16:39:58 -0400
X-Gmail-Original-Message-ID: <CAFX2JfknBFfB-Ef96DdfiC5wAKp5BJXXoXai+Tz4TxtsbASo2g@mail.gmail.com>
Message-ID: <CAFX2JfknBFfB-Ef96DdfiC5wAKp5BJXXoXai+Tz4TxtsbASo2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "NFSv4: Retry LOCK on OLD_STATEID during
 delegation return"
To:     stable@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, Olga.Kornievskaia@netapp.com,
        linux-nfs@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Stable Kernel Team,

Can this patch be backported to v6.1+ kernels? The commit id is
5b4a82a0724a and has been upstream since v6.5. As was mentioned in the
original patch description (below), the commit being reverted by this
patch breaks state recovery in a way that is worse than the initial
bug that it was attempting to fix.

Thanks,
Anna

On Tue, Jun 27, 2023 at 2:31=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> Olga Kornievskaia reports that this patch breaks NFSv4.0 state recovery.
> It also introduces additional complexity in the error paths for cases not
> related to the original problem.  Let's revert it for now, and address th=
e
> original problem in another manner.
>
> This reverts commit f5ea16137a3fa2858620dc9084466491c128535f.
>
> Fixes: f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during delegation =
return")
> Reported-by: Kornievskaia, Olga <Olga.Kornievskaia@netapp.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index d3665390c4cb..6bb14f6cfbc0 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7159,7 +7159,6 @@ static void nfs4_lock_done(struct rpc_task *task, v=
oid *calldata)
>  {
>         struct nfs4_lockdata *data =3D calldata;
>         struct nfs4_lock_state *lsp =3D data->lsp;
> -       struct nfs_server *server =3D NFS_SERVER(d_inode(data->ctx->dentr=
y));
>
>         if (!nfs4_sequence_done(task, &data->res.seq_res))
>                 return;
> @@ -7167,7 +7166,8 @@ static void nfs4_lock_done(struct rpc_task *task, v=
oid *calldata)
>         data->rpc_status =3D task->tk_status;
>         switch (task->tk_status) {
>         case 0:
> -               renew_lease(server, data->timestamp);
> +               renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
> +                               data->timestamp);
>                 if (data->arg.new_lock && !data->cancelled) {
>                         data->fl.fl_flags &=3D ~(FL_SLEEP | FL_ACCESS);
>                         if (locks_lock_inode_wait(lsp->ls_state->inode, &=
data->fl) < 0)
> @@ -7188,8 +7188,6 @@ static void nfs4_lock_done(struct rpc_task *task, v=
oid *calldata)
>                         if (!nfs4_stateid_match(&data->arg.open_stateid,
>                                                 &lsp->ls_state->open_stat=
eid))
>                                 goto out_restart;
> -                       else if (nfs4_async_handle_error(task, server, ls=
p->ls_state, NULL) =3D=3D -EAGAIN)
> -                               goto out_restart;
>                 } else if (!nfs4_stateid_match(&data->arg.lock_stateid,
>                                                 &lsp->ls_stateid))
>                                 goto out_restart;
> --
> 2.40.1
>
