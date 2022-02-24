Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80834C3435
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiBXR4r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 12:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiBXR4m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 12:56:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43C27908D
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 09:56:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a23so6035058eju.3
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfX+cw27drmutk+iADCjz3rJdwBgKgrBhOzyZnYTQSo=;
        b=eGK5XTyDqq1Fl9YXA54YhwtPJnMpBOuU/ET13qPdn5h96aBxr6opDVqYgz+c1+l+6a
         ro2WezmH5z8Fl4rdZXyAuRGi4d/OEJMylV3vZWJT0vwPdWXe7My+O2CE4byLV4O2WlOL
         qML3wG56SFaMw2WGLZznK6BdP7/6meYt7hlSr6YKepaAG5yB+cq1BNbxHh7TSenwKfAk
         s/dowME7i7Vdp3e9+fyrQ1PE/9KRVtOarMJGgoS8GYybffe54gHGjduv/mgu9BzhAEqQ
         Y522m/gQYTPMi2mYL59Up3ZB8q8PYESwsK5tvuyPvhSOmVVsN8zHQ8CctTW4Hmav2jap
         euCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfX+cw27drmutk+iADCjz3rJdwBgKgrBhOzyZnYTQSo=;
        b=3gki+E91KeLnTzcJYuH8Lx4yAgb82IXS9aP/WQ/3oCedBlz9g6Yq+0+Kra/LWH1G4K
         9HSGCEIudutDjVFfe9fpvh51wRR+kQuc1ATPUXxyf46eAZf4YmWSIsu+A2f+0cMLXeaZ
         5KgQC4FijwyOwMONSaYNi2uNd4vzAxEJtVn6yt2d1bd7kekJhY0cPbR1FtCFob22EPgJ
         /IQEou1hldkrYYtHKvBKSKWrbn64F30w2y+9z+NQ9LoGoSlR7oCNjuybsC8tC3d6a2qB
         FH8LlYl77jrF1GYfOwIhgXbIYghVxyWKjkgW7nQoA2GJI0Hz8giiGT65oDgaenBhbWc4
         wKLg==
X-Gm-Message-State: AOAM533O+VDEwftKShN8CZnJmwPC7xeR43hzlPcA5y7l8EBcDPkVvwBf
        34xASghUcj/PU7FS3PFMDF8Fuf9ovuz/BEFEe/o=
X-Google-Smtp-Source: ABdhPJxEZAMduu2+ubW3g/WUnKAvXtu5z1jG4K6LtQeRPnlZQH9t2bkpFscled0cBYav22LaJUdvp+6nd3eUbBeIqgM=
X-Received: by 2002:a17:906:2bc1:b0:6cf:d009:7f6b with SMTP id
 n1-20020a1709062bc100b006cfd0097f6bmr3218384ejg.17.1645725369545; Thu, 24 Feb
 2022 09:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com> <77E34F86-FC2E-4CBF-AFCA-272BAA7C4040@oracle.com>
In-Reply-To: <77E34F86-FC2E-4CBF-AFCA-272BAA7C4040@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 24 Feb 2022 12:55:58 -0500
Message-ID: <CAN-5tyEWWbxCtWQPaMhYdP3OW-XKbCANZKx4mk9Fz=cwbQBU6g@mail.gmail.com>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking discovery
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Thu, Feb 24, 2022 at 10:30 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Feb 23, 2022, at 12:40 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Introduce a new mount option -- trunkdiscovery,notrunkdiscovery -- to
> > toggle whether or not the client will engage in actively discovery
> > of trunking locations.
>
> An alternative solution might be to change the client's
> probe to treat NFS4ERR_DELAY as "no trunking information
> available" and then allow operation to proceed on the
> known good transport.

I'm not sure what you mean about "the known good transport". I don't
think the ERR_DELAY is associated with a transport. Btw, if you saw a
previous patch which restricts fs_location query to the main transport
makes your statement even more confusing as it would mean there is no
good transport. Or do you mean to say we should have trunking
discovery done asynchronous to mount by a separate kernel thread and
therefore not impact mount steps?

I do object to treating a single ERR_DELAY during discovery as a
permanent error as there are legitimate reasons to a delay in looking
up the information that can be resolved in time by the server.
However, I don't object to putting a time limit or number of tries on
ERR_DELAY as safety wheels.

Lastly, I think perhaps we can do both have a mount option to toggle
discovery as well as safeguard the discovery from broken servers?

> I can't think of a reason why normal operation needs to
> stop until this request succeeds...?
>
>
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/client.c           | 3 ++-
> > fs/nfs/fs_context.c       | 8 ++++++++
> > include/linux/nfs_fs_sb.h | 1 +
> > 3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index d1f34229e11a..84c080ddfd01 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -857,7 +857,8 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
> >       }
> >
> >       if (clp->rpc_ops->discover_trunking != NULL &&
> > -                     (server->caps & NFS_CAP_FS_LOCATIONS)) {
> > +                     (server->caps & NFS_CAP_FS_LOCATIONS &&
> > +                      !(server->flags & NFS_MOUNT_NOTRUNK_DISCOVERY))) {
> >               error = clp->rpc_ops->discover_trunking(server, mntfh);
> >               if (error < 0)
> >                       return error;
> > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > index ea17fa1f31ec..ad1448a63aa0 100644
> > --- a/fs/nfs/fs_context.c
> > +++ b/fs/nfs/fs_context.c
> > @@ -80,6 +80,7 @@ enum nfs_param {
> >       Opt_source,
> >       Opt_tcp,
> >       Opt_timeo,
> > +     Opt_trunkdiscovery,
> >       Opt_udp,
> >       Opt_v,
> >       Opt_vers,
> > @@ -180,6 +181,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
> >       fsparam_string("source",        Opt_source),
> >       fsparam_flag  ("tcp",           Opt_tcp),
> >       fsparam_u32   ("timeo",         Opt_timeo),
> > +     fsparam_flag_no("trunkdiscovery", Opt_trunkdiscovery),
> >       fsparam_flag  ("udp",           Opt_udp),
> >       fsparam_flag  ("v2",            Opt_v),
> >       fsparam_flag  ("v3",            Opt_v),
> > @@ -529,6 +531,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
> >               else
> >                       ctx->flags &= ~NFS_MOUNT_NOCTO;
> >               break;
> > +     case Opt_trunkdiscovery:
> > +             if (result.negated)
> > +                     ctx->flags |= NFS_MOUNT_NOTRUNK_DISCOVERY;
> > +             else
> > +                     ctx->flags &= ~NFS_MOUNT_NOTRUNK_DISCOVERY;
> > +             break;
> >       case Opt_ac:
> >               if (result.negated)
> >                       ctx->flags |= NFS_MOUNT_NOAC;
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index ca0959e51e81..d0920d7f5f9e 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -151,6 +151,7 @@ struct nfs_server {
> > #define NFS_MOUNT_SOFTREVAL           0x800000
> > #define NFS_MOUNT_WRITE_EAGER         0x01000000
> > #define NFS_MOUNT_WRITE_WAIT          0x02000000
> > +#define NFS_MOUNT_NOTRUNK_DISCOVERY  0x04000000
> >
> >       unsigned int            fattr_valid;    /* Valid attributes */
> >       unsigned int            caps;           /* server capabilities */
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
