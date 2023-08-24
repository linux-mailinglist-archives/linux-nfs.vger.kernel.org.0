Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F578771B
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242833AbjHXRbx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 13:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242873AbjHXRbs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 13:31:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB719B5
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 10:31:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcd48725dbso60741fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692898304; x=1693503104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxAlQUQSNJi9V446bihT9mBye1Gu7hk3oVpzlWpMUto=;
        b=UZ73R4CWHpYRaG/MrutwWRZ4IQ8osmv0uB/G3UkUzjsWSr9Icdk8rG86FSrdKH23eq
         /t4bELn+lglVpOSC4AJ4gwTFNqr7Sw+vz7hjZSSlf6xiiILA0ZBzsLScZPEtyUlD0dZs
         du0hr84iLCnluq6rM9iamnBdSGuliQV+DxEdYo1fOXs0uTi9oA+KyxU7Gz2ZEHecjGJP
         MOpYBEPVfrtu1NKkGTFbDNih8xayPRBP0/aiZSdwbnpAWsXeCEC1UrN59Lsr8eGgGeSP
         hqpjS4zPVdOj4rjdGw6UHvPsFNKYL5a/bd3SmaX92dCW+xjwpEu79SQiT8LL2RsRpjt1
         TCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692898304; x=1693503104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxAlQUQSNJi9V446bihT9mBye1Gu7hk3oVpzlWpMUto=;
        b=BwCAl5ayR3KquEiRZa+OtUHv5fpQwuoBW5GyV8+ihHI3tl7a5RMxfkzaMq4uQW38Gx
         8HNBZEr6FFTvJNhGPhjGO8HvpDSOr2ouo0oxKJ2QKn557SqJeXC8SS1m/5F1uuD7A7Cj
         jVMoneWsM5R0I9yorHR/TiUgeRSTasYtY5F/fU3mJLkGzbrnIydulAQ5Ci7xqdD3yusQ
         8lJeu3KJCiv/RceDl7CWff/nJhfMqygvScPzn+VYghCnB7wXaaUU1FvcurmHh0MFYhvm
         yZtTbBNp8WeSgymmhjA3IxbQ6GeDeoI9jatTJKCDgKaure6bGTkFT9olIGCtLCr43HV+
         /Dxw==
X-Gm-Message-State: AOJu0YwKPZlBOGkXoJPZXikTtlo+BBJk9j5idt8CJFp5MyDDL7XIPlBP
        3VkkVbl1pghXvwVS7HK8lofwUp6HGoNUeVTv/GRNjgAvePo=
X-Google-Smtp-Source: AGHT+IEm1OgzE6emvnpox73BpTe7pRE7luuUTClQxHG8Un2PjqK1BtxspfH9JUJ3YRmAGRshr6BXO3iax6kv+MpZsOg=
X-Received: by 2002:a05:651c:1506:b0:2bb:8d47:9d95 with SMTP id
 e6-20020a05651c150600b002bb8d479d95mr13979639ljf.2.1692898303845; Thu, 24 Aug
 2023 10:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230824162416.17482-1-olga.kornievskaia@gmail.com>
 <7edc85a1a05fdcd1987d16ed873e64023490df7a.camel@hammerspace.com> <CAN-5tyHOKAyS7cpFh2aLdMm-=BbYR=_peE_i9A6SuN=OK5E4pw@mail.gmail.com>
In-Reply-To: <CAN-5tyHOKAyS7cpFh2aLdMm-=BbYR=_peE_i9A6SuN=OK5E4pw@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 24 Aug 2023 13:31:30 -0400
Message-ID: <CAN-5tyGqqYN6dfK9QYiVyzWkqJXSUaFT_dKRp8c-5ZDRrbPG2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 24, 2023 at 1:20=E2=80=AFPM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Thu, Aug 24, 2023 at 12:42=E2=80=AFPM Trond Myklebust
> <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2023-08-24 at 12:24 -0400, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > Currently, when GETDEVICEINFO returns multiple locations where each
> > > is a different IP but the server's identity is same as MDS, then
> > > nfs4_set_ds_client() finds the existing nfs_client structure which
> > > has the MDS's max_connect value (and if it's 1), then the 1st IP
> > > on the DS's list will get dropped due to MDS trunking rules. Other
> > > IPs would be added as they fall under the pnfs trunking rules.
> > >
> > > Instead, this patch prposed to treat MDS=3DDS as DS trunking and
> > > make sure that MDS's max_connect limit does not apply to the
> > > 1st IP returned in the GETDEVICEINFO list.
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  fs/nfs/nfs4client.c | 7 ++++++-
> > >  net/sunrpc/clnt.c   | 9 ++++++---
> > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > index 27fb25567ce7..b35acd79b895 100644
> > > --- a/fs/nfs/nfs4client.c
> > > +++ b/fs/nfs/nfs4client.c
> > > @@ -417,6 +417,7 @@ static void nfs4_add_trunk(struct nfs_client
> > > *clp, struct nfs_client *old)
> > >                 .net =3D old->cl_net,
> > >                 .servername =3D old->cl_hostname,
> > >         };
> > > +       int max_connect =3D old->cl_max_connect;
> > >
> > >         if (clp->cl_proto !=3D old->cl_proto)
> > >                 return;
> > > @@ -428,9 +429,12 @@ static void nfs4_add_trunk(struct nfs_client
> > > *clp, struct nfs_client *old)
> > >
> > >         xprt_args.dstaddr =3D clp_sap;
> > >         xprt_args.addrlen =3D clp_salen;
> > > +       if (clp->cl_max_connect !=3D old->cl_max_connect &&
> > > +           test_bit(NFS_CS_DS, &clp->cl_flags))
> > > +               max_connect =3D clp->cl_max_connect;
> > >
> > >         rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> > > -                         rpc_clnt_test_and_add_xprt, NULL);
> > > +                         rpc_clnt_test_and_add_xprt, &max_connect);
> >
> > Instead of using rpc_clnt_add_xprt() to set transport parameters after
> > the fact, can we please instead just add these parameters to the struct
> > rpc_create_args/struct xprt_create? Please see the following patch in
> > my testing branch
>
> But we are not setting parameters after the fact. We are making sure
> that we are not constraining the pnfs trunking by the MDS trunking
> when MDS=3DDS.

To add to that it's because the 1st address of the DS addresses goes
thru the pnfs.c
rpc_clnt_add_xprt()->rpc_clnt_setup_test_and_add_xprt,() which checks
for the max_connect value of the MDS. Other DS addresses are just
added thru the other path.

Instead of blindly using clnt->cl_max_connect value (of the MDS) when
we are called for PNFS DSs, we pass in the value (max) to be used for
the comparison.

> > https://git.linux-nfs.org/?p=3Dtrondmy/linux-nfs.git;a=3Dcommitdiff;h=
=3Dd1fb679d1dff0ae9e118d3380c0f5927cd279efe
> >
> > >  }
> > >
> > >  /**
> > > @@ -1010,6 +1014,7 @@ struct nfs_client *nfs4_set_ds_client(struct
> > > nfs_server *mds_srv,
> > >                 __set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
> > >
> > >         __set_bit(NFS_CS_DS, &cl_init.init_flags);
> > > +       cl_init.max_connect =3D NFS_MAX_TRANSPORTS;
> > >         /*
> > >          * Set an authflavor equual to the MDS value. Use the MDS
> > > nfs_client
> > >          * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as
> > > the MDS
> > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > > index d7c697af3762..325dad20a924 100644
> > > --- a/net/sunrpc/clnt.c
> > > +++ b/net/sunrpc/clnt.c
> > > @@ -2904,16 +2904,19 @@ static const struct rpc_call_ops
> > > rpc_cb_add_xprt_call_ops =3D {
> > >   * @clnt: pointer to struct rpc_clnt
> > >   * @xps: pointer to struct rpc_xprt_switch,
> > >   * @xprt: pointer struct rpc_xprt
> > > - * @dummy: unused
> > > + * @in_max_connect: pointer to the max_connect value for the passed
> > > in xprt transport
> > >   */
> > >  int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
> > >                 struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
> > > -               void *dummy)
> > > +               void *in_max_connect)
> > >  {
> > >         struct rpc_cb_add_xprt_calldata *data;
> > >         struct rpc_task *task;
> > > +       int max_connect =3D clnt->cl_max_connect;
> > >
> > > -       if (xps->xps_nunique_destaddr_xprts + 1 > clnt-
> > > >cl_max_connect) {
> > > +       if (in_max_connect)
> > > +               max_connect =3D *(int *)in_max_connect;
> > > +       if (xps->xps_nunique_destaddr_xprts + 1 > max_connect) {
> > >                 rcu_read_lock();
> > >                 pr_warn("SUNRPC: reached max allowed number (%d) did
> > > not add "
> > >                         "transport to server: %s\n", clnt-
> > > >cl_max_connect,
> >
> > --
> > Trond Myklebust
> > CTO, Hammerspace Inc
> > 1900 S Norfolk St, Suite 350 - #45
> > San Mateo, CA 94403
> >
> > www.hammerspace.com
