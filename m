Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20278487B
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHVRiJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHVRiI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 13:38:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA5A8171D
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 10:38:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40fed08b990so31138621cf.2
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692725869; x=1693330669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dlx0/yl+41lv9MAvE/hUw7QOeNr0B611cAgnYFX0pA=;
        b=MxUqLekxSaT5GcU/KIbiIfPrQ/bXcThgPBGxO2IBJbKG7AnwZ+roxUxf69WnfSS99b
         OVj/GWyJZ6B6OdSZF3otVi372qrrce5sxCLFET7QEAvq4JVNxuuDkbhLUbDtGhtCqU8I
         4e/gXSE1zDNYmZn25LkXW8T7wl05BIQEan/rtbBmLFKi7mACV04JXji8e0WwTVex4roG
         suNt6un+23ukJGlAn1L59GbzyXGEN0z8+5YAk0cd4SaLZcJhGh8ITQcQiKvg7sGxMYIT
         uSTg6taEyc1yUiAlfToGffdUkTowUG6pTxK9qiJzurGduUb3kgDMaF5xs6yFc0zELwhu
         iWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725869; x=1693330669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Dlx0/yl+41lv9MAvE/hUw7QOeNr0B611cAgnYFX0pA=;
        b=Hh827saVn7IQxJGXcmOrA10cpujTw5roSxaIpaFLz+W/2dheJAp2CAYWQRje0qPNOZ
         vyTZNIb+6vofBvBU9XZw6zvNroCaLlUxY0wZF8BioHqqy/6m03NugE991huit2C++Xbu
         xrUurNDTNu53t6r5ORHXyhLAoJDr2bnF4jQTKClkKxnrc20whwrJDvuzye442F+Z3dTk
         MawYVoFrIVsaABL2YtFxDjrf205tfvGdfqhNibt2wbmiY1khKCLeL4freU+230g0CtBl
         NbsasUfDJj3D00Jtdwr4p47em7ra4H9rEi3hMxozgknTMz2neOSWumaKeB0JiZiiGum5
         tPFw==
X-Gm-Message-State: AOJu0YzPPxNPbFp5i1QWGTdOJWD7wSGJ8F6qwOXCiaD8vcXlGtR4EKrN
        /0dYGwGwx56Tolq6vbVqE31ZxDATPFRxCUXuIW0=
X-Google-Smtp-Source: AGHT+IEbfftlwR3H3Ka3FwMRuWAuS8FHkjWgtyMIVfhJoOfhnGuiBWlq6Wg6a5LnMoowJoDtJMjTE9OtDoJrXDIKOTw=
X-Received: by 2002:a05:622a:194:b0:403:b4da:6e53 with SMTP id
 s20-20020a05622a019400b00403b4da6e53mr13272881qtw.44.1692725868892; Tue, 22
 Aug 2023 10:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230713173511.24651-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20230713173511.24651-1-olga.kornievskaia@gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 22 Aug 2023 13:37:33 -0400
Message-ID: <CAFX2Jfn8Y+V-K3UOrB96P5PLSDZ+HL0gst13DKHMpFmzNuRg7A@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
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

Hi Olga,

On Thu, Jul 13, 2023 at 1:39=E2=80=AFPM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Currently, when GETDEVICEINFO returns multiple locations where each
> is a different IP but the server's identity is same as MDS, then
> nfs4_set_ds_client() finds the existing nfs_client structure which
> has the MDS's max_connect value (and if it's 1), then the 1st IP
> on the DS's list will get dropped due to MDS trunking rules. Other
> IPs would be added as they fall under the pnfs trunking rules.
>
> Instead, this patch prposed to treat MDS=3DDS as DS trunking and
> make sure that MDS's max_connect limit does not apply to the
> 1st IP returned in the GETDEVICEINFO list.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4client.c | 7 ++++++-
>  net/sunrpc/clnt.c   | 7 +++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 27fb25567ce7..b35acd79b895 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -417,6 +417,7 @@ static void nfs4_add_trunk(struct nfs_client *clp, st=
ruct nfs_client *old)
>                 .net =3D old->cl_net,
>                 .servername =3D old->cl_hostname,
>         };
> +       int max_connect =3D old->cl_max_connect;
>
>         if (clp->cl_proto !=3D old->cl_proto)
>                 return;
> @@ -428,9 +429,12 @@ static void nfs4_add_trunk(struct nfs_client *clp, s=
truct nfs_client *old)
>
>         xprt_args.dstaddr =3D clp_sap;
>         xprt_args.addrlen =3D clp_salen;
> +       if (clp->cl_max_connect !=3D old->cl_max_connect &&
> +           test_bit(NFS_CS_DS, &clp->cl_flags))
> +               max_connect =3D clp->cl_max_connect;
>
>         rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> -                         rpc_clnt_test_and_add_xprt, NULL);
> +                         rpc_clnt_test_and_add_xprt, &max_connect);
>  }
>
>  /**
> @@ -1010,6 +1014,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_se=
rver *mds_srv,
>                 __set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
>
>         __set_bit(NFS_CS_DS, &cl_init.init_flags);
> +       cl_init.max_connect =3D NFS_MAX_TRANSPORTS;
>         /*
>          * Set an authflavor equual to the MDS value. Use the MDS nfs_cli=
ent
>          * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the =
MDS
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index d7c697af3762..dfdb4bc96367 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2908,12 +2908,15 @@ static const struct rpc_call_ops rpc_cb_add_xprt_=
call_ops =3D {
>   */
>  int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
>                 struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
> -               void *dummy)
> +               void *in_max_connect)

I was wondering if you could fix up the documentation comment above
this function for the new parameter?

I'm seeing this when I compile with W=3D1:

net/sunrpc/clnt.c:2913: warning: Function parameter or member
'in_max_connect' not described in 'rpc_clnt_test_and_add_xprt'
net/sunrpc/clnt.c:2913: warning: Excess function parameter 'dummy'
description in 'rpc_clnt_test_and_add_xprt'

Thanks,
Anna

>  {
>         struct rpc_cb_add_xprt_calldata *data;
>         struct rpc_task *task;
> +       int max_connect =3D clnt->cl_max_connect;
>
> -       if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
> +       if (in_max_connect)
> +               max_connect =3D *(int *)in_max_connect;
> +       if (xps->xps_nunique_destaddr_xprts + 1 > max_connect) {
>                 rcu_read_lock();
>                 pr_warn("SUNRPC: reached max allowed number (%d) did not =
add "
>                         "transport to server: %s\n", clnt->cl_max_connect=
,
> --
> 2.39.1
>
