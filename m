Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA707876F5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjHXRVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjHXRVL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 13:21:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF8E50
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 10:21:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcb5423dc7so23491fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692897667; x=1693502467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0pnZrHNwptlcyqwHXsrUPSB7biTKgzjOWKDRuB4F00=;
        b=nOTRInava/OSUGeisf3GyUB9CT3q82aMSUPUwzPhW9j3+xigPh2QH+J3lL2n4iPFVk
         RSp7N1Y/BciHoyjMOBKWJ2ujlPeiNmXvX9yxCzSjTpYvzn7a4CGd8fd14OkdpcqWNUU2
         2zgsVqJl85d6FGI8JPxwPG7DUva7BGZbEGkLw4HE14z7/NEEpHCrYzWBeSfD/y4logUS
         DP1+8Z+b9z2vmqAf3FSodlQeweuzZ5d+iUfpGhx/r/18p9NSo2ITGQbIHqljGysMbHNz
         YZqf4cpbkmiMf9OCRi99sUTQXTE15GwJ2ZcciaW93kxHZ/zIayvcsGB0hAOc24T986xi
         cB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692897667; x=1693502467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0pnZrHNwptlcyqwHXsrUPSB7biTKgzjOWKDRuB4F00=;
        b=jTRO63b9UhOHx+Esgp/sbyeUwckdNvHMG84iPerNfN+cAa8sTbw6kl78T+mzVH8ual
         Eur1+gbGypkFRzW9nADL3NDgVtJO/WpyQx/GnNohnb7GkBIjWSc9fdVQdIFsMLEmmsuW
         5zBSMra9FwO974icay4SnREgSRvyb+VUWoHbPn2AqQLtzwTl0hhu4nBznpvZ/FCIrQ26
         krpTbTJdVFP8H3DCN8tsX3g0FIB7uz74XHkWWz7D0M9iIVlNCda0fumHhfTjmsbJFc3H
         kFvnQYSw65ELD7mDhOyg2wvy6cS3M64kHBJ2j/sdaXdqSW+ES3UAmJeRnP1sbcP0gbQY
         qNPA==
X-Gm-Message-State: AOJu0Yzxh5J7T17Lz5RxRdp2dnr0aXSrcC2ziLFFtGjJ1QvuHdriTWw6
        HtFc6H7NYrDbDxRlXDKtfOIjUFKf0TqGbp7n3jc=
X-Google-Smtp-Source: AGHT+IHiHfVEva2j9bk0N7M2gZka/XZlOzL8asYoREM+KMDcEiA5zxjthyKgaTnBWTj7IyrcCs/s4tNqWACF5RotLrM=
X-Received: by 2002:a05:651c:102f:b0:2b7:34c0:a03a with SMTP id
 w15-20020a05651c102f00b002b734c0a03amr11237187ljm.3.1692897667159; Thu, 24
 Aug 2023 10:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230824162416.17482-1-olga.kornievskaia@gmail.com> <7edc85a1a05fdcd1987d16ed873e64023490df7a.camel@hammerspace.com>
In-Reply-To: <7edc85a1a05fdcd1987d16ed873e64023490df7a.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 24 Aug 2023 13:20:53 -0400
Message-ID: <CAN-5tyHOKAyS7cpFh2aLdMm-=BbYR=_peE_i9A6SuN=OK5E4pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
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

On Thu, Aug 24, 2023 at 12:42=E2=80=AFPM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2023-08-24 at 12:24 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Currently, when GETDEVICEINFO returns multiple locations where each
> > is a different IP but the server's identity is same as MDS, then
> > nfs4_set_ds_client() finds the existing nfs_client structure which
> > has the MDS's max_connect value (and if it's 1), then the 1st IP
> > on the DS's list will get dropped due to MDS trunking rules. Other
> > IPs would be added as they fall under the pnfs trunking rules.
> >
> > Instead, this patch prposed to treat MDS=3DDS as DS trunking and
> > make sure that MDS's max_connect limit does not apply to the
> > 1st IP returned in the GETDEVICEINFO list.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4client.c | 7 ++++++-
> >  net/sunrpc/clnt.c   | 9 ++++++---
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > index 27fb25567ce7..b35acd79b895 100644
> > --- a/fs/nfs/nfs4client.c
> > +++ b/fs/nfs/nfs4client.c
> > @@ -417,6 +417,7 @@ static void nfs4_add_trunk(struct nfs_client
> > *clp, struct nfs_client *old)
> >                 .net =3D old->cl_net,
> >                 .servername =3D old->cl_hostname,
> >         };
> > +       int max_connect =3D old->cl_max_connect;
> >
> >         if (clp->cl_proto !=3D old->cl_proto)
> >                 return;
> > @@ -428,9 +429,12 @@ static void nfs4_add_trunk(struct nfs_client
> > *clp, struct nfs_client *old)
> >
> >         xprt_args.dstaddr =3D clp_sap;
> >         xprt_args.addrlen =3D clp_salen;
> > +       if (clp->cl_max_connect !=3D old->cl_max_connect &&
> > +           test_bit(NFS_CS_DS, &clp->cl_flags))
> > +               max_connect =3D clp->cl_max_connect;
> >
> >         rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> > -                         rpc_clnt_test_and_add_xprt, NULL);
> > +                         rpc_clnt_test_and_add_xprt, &max_connect);
>
> Instead of using rpc_clnt_add_xprt() to set transport parameters after
> the fact, can we please instead just add these parameters to the struct
> rpc_create_args/struct xprt_create? Please see the following patch in
> my testing branch

But we are not setting parameters after the fact. We are making sure
that we are not constraining the pnfs trunking by the MDS trunking
when MDS=3DDS.

> https://git.linux-nfs.org/?p=3Dtrondmy/linux-nfs.git;a=3Dcommitdiff;h=3Dd=
1fb679d1dff0ae9e118d3380c0f5927cd279efe
>
> >  }
> >
> >  /**
> > @@ -1010,6 +1014,7 @@ struct nfs_client *nfs4_set_ds_client(struct
> > nfs_server *mds_srv,
> >                 __set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
> >
> >         __set_bit(NFS_CS_DS, &cl_init.init_flags);
> > +       cl_init.max_connect =3D NFS_MAX_TRANSPORTS;
> >         /*
> >          * Set an authflavor equual to the MDS value. Use the MDS
> > nfs_client
> >          * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as
> > the MDS
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index d7c697af3762..325dad20a924 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -2904,16 +2904,19 @@ static const struct rpc_call_ops
> > rpc_cb_add_xprt_call_ops =3D {
> >   * @clnt: pointer to struct rpc_clnt
> >   * @xps: pointer to struct rpc_xprt_switch,
> >   * @xprt: pointer struct rpc_xprt
> > - * @dummy: unused
> > + * @in_max_connect: pointer to the max_connect value for the passed
> > in xprt transport
> >   */
> >  int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
> >                 struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
> > -               void *dummy)
> > +               void *in_max_connect)
> >  {
> >         struct rpc_cb_add_xprt_calldata *data;
> >         struct rpc_task *task;
> > +       int max_connect =3D clnt->cl_max_connect;
> >
> > -       if (xps->xps_nunique_destaddr_xprts + 1 > clnt-
> > >cl_max_connect) {
> > +       if (in_max_connect)
> > +               max_connect =3D *(int *)in_max_connect;
> > +       if (xps->xps_nunique_destaddr_xprts + 1 > max_connect) {
> >                 rcu_read_lock();
> >                 pr_warn("SUNRPC: reached max allowed number (%d) did
> > not add "
> >                         "transport to server: %s\n", clnt-
> > >cl_max_connect,
>
> --
> Trond Myklebust
> CTO, Hammerspace Inc
> 1900 S Norfolk St, Suite 350 - #45
> San Mateo, CA 94403
>
> www.hammerspace.com
