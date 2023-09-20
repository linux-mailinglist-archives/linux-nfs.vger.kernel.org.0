Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3217A8CFD
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Sep 2023 21:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjITTjN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Sep 2023 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjITTjM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Sep 2023 15:39:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26959E
        for <linux-nfs@vger.kernel.org>; Wed, 20 Sep 2023 12:39:06 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4121f006c30so732471cf.2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Sep 2023 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238746; x=1695843546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHLCMF1vXEj24TmdEN8JSlEeio1PK0CHOlPc/bVWwUg=;
        b=fOlhAzLECkhxTsFu5xxSH5NUsxj5Dg9PT4tBrGyZ7osU4jWOJGp7xK1CDfaPp8XNB5
         4rCSYDZaHVDGIYt1lemf8Ha/FQik9bI9bQwMfMdB/j5uKUmwt5ruIAATQcJ3qRwxEikw
         kpl5z1e/5bfwk0LDTlgXCOov9TthB4o5INT78pzG2kq+tiJ4vqk+HZdLUdQgaxPp93cC
         g+NmkHMBQkFeYc60aELWTDzcj2MDXo4MZigbiDdsnFGc4gx56CilUYDMisUR0arqyTxY
         bytQ+WJAckdt1vYwiNMiV6j3pq3BiH/NGrI2oZXcao2iO/aTMFhXVn56GCbQ3LrPivcx
         T0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238746; x=1695843546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHLCMF1vXEj24TmdEN8JSlEeio1PK0CHOlPc/bVWwUg=;
        b=QvDsJU5VCKujNV8fyYdokr9FpiaEM78RDPUYLsgPy+W2LQPczCA8k0KlxiGypd1+o2
         qR0tudpczTlxc64T6JkZsY4hfDEuaIGTARl5duDVZgCVnGlMpS+N6s2X2VrSbSmt3Waw
         i1eBBS2INU8pdLQm+8GueMRO+IOvB5e5tlVyV05/qr53n1b9rj3XmLlPMwRjvGujZc8r
         sMqIikfi0OZV0QQhFdi4a3nBSrcqBxeRFqYPwTXOqI0l/nD6hWZMrrtfFzV9pLb7fJdu
         ji+tHVwV/fjiOsW+v0boCtz0OYd7YyrtosAEx5Q2FcXlPQm8Fxw3CDnh60YWlImD2/MW
         iBPw==
X-Gm-Message-State: AOJu0Yy7FMegPTDsE/wjmEhbsgUS81fauHqgvKsb2h9ELfSKa4Ywog/5
        MHbvXmUNzCVcqpHgsYHX2pxqzYZj0t6Q2wKoU0M=
X-Google-Smtp-Source: AGHT+IGcahUQFC/JqKZ4OMKFprMLB28DHIRQifnKm1xRSlZXwZUJyT5bytD59+uROJzF1mDJdpNPwHYu/aR2uTVs+aY=
X-Received: by 2002:a05:622a:190a:b0:403:eb5b:1f6 with SMTP id
 w10-20020a05622a190a00b00403eb5b01f6mr3904033qtc.63.1695238745794; Wed, 20
 Sep 2023 12:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230917230551.30483-1-trondmy@kernel.org> <20230917230551.30483-2-trondmy@kernel.org>
In-Reply-To: <20230917230551.30483-2-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 20 Sep 2023 15:38:50 -0400
Message-ID: <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Sun, Sep 17, 2023 at 7:12=E2=80=AFPM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Commit 4dc73c679114 reintroduces the deadlock that was fixed by commit
> aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock") because it
> prevents the setup of new threads to handle reboot recovery, while the
> older recovery thread is stuck returning delegations.

I'm seeing a possible deadlock with xfstests generic/472 on NFS v4.x
after applying this patch. The test itself checks for various swapfile
edge cases, so it seems likely something is going on there.

Let me know if you need more info
Anna

>
> Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is =
enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4proc.c  |  4 +++-
>  fs/nfs/nfs4state.c | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 29 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 5deeaea8026e..a19e809cad16 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10652,7 +10652,9 @@ static void nfs4_disable_swap(struct inode *inode=
)
>          */
>         struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
>
> -       nfs4_schedule_state_manager(clp);
> +       set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
> +       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> +       wake_up_var(&clp->cl_state);
>  }
>
>  static const struct inode_operations nfs4_dir_inode_operations =3D {
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 0bc160fbabec..5751a6886da4 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1209,16 +1209,26 @@ void nfs4_schedule_state_manager(struct nfs_clien=
t *clp)
>  {
>         struct task_struct *task;
>         char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
> +       struct rpc_clnt *clnt =3D clp->cl_rpcclient;
> +       bool swapon =3D false;
>
> -       if (clp->cl_rpcclient->cl_shutdown)
> +       if (clnt->cl_shutdown)
>                 return;
>
>         set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
> -       if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) =
!=3D 0) {
> -               wake_up_var(&clp->cl_state);
> -               return;
> +
> +       if (atomic_read(&clnt->cl_swapper)) {
> +               swapon =3D !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
> +                                          &clp->cl_state);
> +               if (!swapon) {
> +                       wake_up_var(&clp->cl_state);
> +                       return;
> +               }
>         }
> -       set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
> +
> +       if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) !=
=3D 0)
> +               return;
> +
>         __module_get(THIS_MODULE);
>         refcount_inc(&clp->cl_count);
>
> @@ -1235,8 +1245,9 @@ void nfs4_schedule_state_manager(struct nfs_client =
*clp)
>                         __func__, PTR_ERR(task));
>                 if (!nfs_client_init_is_complete(clp))
>                         nfs_mark_client_ready(clp, PTR_ERR(task));
> +               if (swapon)
> +                       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_st=
ate);
>                 nfs4_clear_state_manager_bit(clp);
> -               clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
>                 nfs_put_client(clp);
>                 module_put(THIS_MODULE);
>         }
> @@ -2748,22 +2759,25 @@ static int nfs4_run_state_manager(void *ptr)
>
>         allow_signal(SIGKILL);
>  again:
> -       set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
>         nfs4_state_manager(clp);
> -       if (atomic_read(&cl->cl_swapper)) {
> +
> +       if (test_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) &&
> +           !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state)) =
{
>                 wait_var_event_interruptible(&clp->cl_state,
>                                              test_bit(NFS4CLNT_RUN_MANAGE=
R,
>                                                       &clp->cl_state));
> -               if (atomic_read(&cl->cl_swapper) &&
> -                   test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
> +               if (!atomic_read(&cl->cl_swapper))
> +                       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_st=
ate);
> +               if (refcount_read(&clp->cl_count) > 1 && !signalled())
>                         goto again;
>                 /* Either no longer a swapper, or were signalled */
> +               clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> +               nfs4_clear_state_manager_bit(clp);
>         }
> -       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
>
>         if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
>             test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
> -           !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state)=
)
> +           !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
>                 goto again;
>
>         nfs_put_client(clp);
> --
> 2.41.0
>
