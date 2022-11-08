Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339D621962
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiKHQah (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 11:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiKHQaf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 11:30:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF158006
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 08:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1CF0ECE1C19
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 16:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8E2C43470
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667925031;
        bh=sSLJYygsKf70HtR31/8EngzDDGZf1HgnTDBasYXco10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cMtOhm37/RPNGTYzQGMwXPnArTsiOgjzJK+us1nnCQ8B2IqSoWg1u/AMuc8AECOe3
         mqqjdKOkNhq0vLE7JLMqBIbkcazxZeZ4m02UcEQJvNJqkDICWI91LoOK7NdMCa0L1x
         tQhnHq7YSQrMoUlLo1EVBeQtW94Ki5bPw5cUhW1VhErpMdbb+te91jAyVqJnbx6FFt
         gih3u4jqojtEaW7X3qW0jCYT/zHJo64Ei4YWuTfGb7tQGJSjmmrCyzHrZ7NxKt0rvT
         xOyhm4ynCkPdyycyO0R68FVUWK6Uqj9b51UuB54yU2JpQGeg2a2E9Tw2YVSA2dZXnt
         mJB6v0I0pO2kw==
Received: by mail-qt1-f169.google.com with SMTP id x15so8927611qtv.9
        for <linux-nfs@vger.kernel.org>; Tue, 08 Nov 2022 08:30:30 -0800 (PST)
X-Gm-Message-State: ANoB5pkF6UxWquVKBAIwQ4JbvnQu9EmlnXk+285GtkGdk7HjYNMk8ZM8
        8pURV4sCnWFKiRSGE+HlxWzXiNT6w8XbNFi6l5E=
X-Google-Smtp-Source: AA0mqf7VbmJofHkbJuQhQatDG0EvDPBQezzsZBh8aHY080kRPQo3x+rX7A3y/woDVsDLB4OBHKnR9xnKurEwaETH6ps=
X-Received: by 2002:ac8:5f0b:0:b0:3a5:848e:d161 with SMTP id
 x11-20020ac85f0b000000b003a5848ed161mr9885969qta.196.1667925030130; Tue, 08
 Nov 2022 08:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20220617202336.1099702-1-anna@kernel.org> <9c9363ccabfa9906bcfd2604ec25994b57ee0f44.camel@kernel.org>
 <4fc8385e-2396-e64a-c31d-1ccafa8d263e@talpey.com>
In-Reply-To: <4fc8385e-2396-e64a-c31d-1ccafa8d263e@talpey.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 8 Nov 2022 11:30:14 -0500
X-Gmail-Original-Message-ID: <CAFX2Jf=9Hcg-iQrEyQRnegL7Cm3LSCZsaKi5R194NRXm5W4tpA@mail.gmail.com>
Message-ID: <CAFX2Jf=9Hcg-iQrEyQRnegL7Cm3LSCZsaKi5R194NRXm5W4tpA@mail.gmail.com>
Subject: Re: [PATCH] NFS: Allow setting rsize / wsize to a multiple of PAGE_SIZE
To:     Tom Talpey <tom@talpey.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com, Jianhong Yin <jiyin@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 8, 2022 at 11:11 AM Tom Talpey <tom@talpey.com> wrote:
>
> On 11/8/2022 5:01 AM, Jeff Layton wrote:
> > On Fri, 2022-06-17 at 16:23 -0400, Anna Schumaker wrote:
> >> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>
> >> Previously, we required this to value to be a power of 2 for UDP related
> >> reasons. This patch keeps the power of 2 rule for UDP but allows more
> >> flexibility for TCP and RDMA.
> >>
> >> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >> ---
> >>   fs/nfs/client.c                           | 13 +++++++------
> >>   fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 ++++--
> >>   fs/nfs/internal.h                         | 18 ++++++++++++++++++
> >>   fs/nfs/nfs4client.c                       |  4 ++--
> >>   4 files changed, 31 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> >> index e828504cc396..da8da5cdbbc1 100644
> >> --- a/fs/nfs/client.c
> >> +++ b/fs/nfs/client.c
> >> @@ -708,9 +708,9 @@ static int nfs_init_server(struct nfs_server *server,
> >>      }
> >>
> >>      if (ctx->rsize)
> >> -            server->rsize = nfs_block_size(ctx->rsize, NULL);
> >> +            server->rsize = nfs_io_size(ctx->rsize, clp->cl_proto);
> >>      if (ctx->wsize)
> >> -            server->wsize = nfs_block_size(ctx->wsize, NULL);
> >> +            server->wsize = nfs_io_size(ctx->wsize, clp->cl_proto);
> >>
> >>      server->acregmin = ctx->acregmin * HZ;
> >>      server->acregmax = ctx->acregmax * HZ;
> >> @@ -755,18 +755,19 @@ static int nfs_init_server(struct nfs_server *server,
> >>   static void nfs_server_set_fsinfo(struct nfs_server *server,
> >>                                struct nfs_fsinfo *fsinfo)
> >>   {
> >> +    struct nfs_client *clp = server->nfs_client;
> >>      unsigned long max_rpc_payload, raw_max_rpc_payload;
> >>
> >>      /* Work out a lot of parameters */
> >>      if (server->rsize == 0)
> >> -            server->rsize = nfs_block_size(fsinfo->rtpref, NULL);
> >> +            server->rsize = nfs_io_size(fsinfo->rtpref, clp->cl_proto);
> >>      if (server->wsize == 0)
> >> -            server->wsize = nfs_block_size(fsinfo->wtpref, NULL);
> >> +            server->wsize = nfs_io_size(fsinfo->wtpref, clp->cl_proto);
> >>
> >>      if (fsinfo->rtmax >= 512 && server->rsize > fsinfo->rtmax)
> >> -            server->rsize = nfs_block_size(fsinfo->rtmax, NULL);
> >> +            server->rsize = nfs_io_size(fsinfo->rtmax, clp->cl_proto);
> >>      if (fsinfo->wtmax >= 512 && server->wsize > fsinfo->wtmax)
> >> -            server->wsize = nfs_block_size(fsinfo->wtmax, NULL);
> >> +            server->wsize = nfs_io_size(fsinfo->wtmax, clp->cl_proto);
> >>
> >>      raw_max_rpc_payload = rpc_max_payload(server->client);
> >>      max_rpc_payload = nfs_block_size(raw_max_rpc_payload, NULL);
> >> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> >> index bfa7202ca7be..e028f5a0ef5f 100644
> >> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> >> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> >> @@ -113,8 +113,10 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
> >>                      goto out_err_drain_dsaddrs;
> >>              ds_versions[i].version = be32_to_cpup(p++);
> >>              ds_versions[i].minor_version = be32_to_cpup(p++);
> >> -            ds_versions[i].rsize = nfs_block_size(be32_to_cpup(p++), NULL);
> >> -            ds_versions[i].wsize = nfs_block_size(be32_to_cpup(p++), NULL);
> >> +            ds_versions[i].rsize = nfs_io_size(be32_to_cpup(p++),
> >> +                                               server->nfs_client->cl_proto);
> >> +            ds_versions[i].wsize = nfs_io_size(be32_to_cpup(p++),
> >> +                                               server->nfs_client->cl_proto);
> >>              ds_versions[i].tightly_coupled = be32_to_cpup(p);
> >>
> >>              if (ds_versions[i].rsize > NFS_MAX_FILE_IO_SIZE)
> >> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> >> index 8f8cd6e2d4db..af6d261241ff 100644
> >> --- a/fs/nfs/internal.h
> >> +++ b/fs/nfs/internal.h
> >> @@ -704,6 +704,24 @@ unsigned long nfs_block_size(unsigned long bsize, unsigned char *nrbitsp)
> >>      return nfs_block_bits(bsize, nrbitsp);
> >>   }
> >>
> >> +/*
> >> + * Compute and set NFS server rsize / wsize
> >> + */
> >> +static inline
> >> +unsigned long nfs_io_size(unsigned long iosize, enum xprt_transports proto)
> >> +{
> >> +    if (iosize < NFS_MIN_FILE_IO_SIZE)
> >> +            iosize = NFS_DEF_FILE_IO_SIZE;
> >> +    else if (iosize >= NFS_MAX_FILE_IO_SIZE)
> >> +            iosize = NFS_MAX_FILE_IO_SIZE;
> >> +    else
> >> +            iosize = iosize & PAGE_MASK;
> >> +
> >> +    if (proto == XPRT_TRANSPORT_UDP)
> >> +            return nfs_block_bits(iosize, NULL);
> >> +    return iosize;
> >> +}
> >> +
> >>   /*
> >>    * Determine the maximum file size for a superblock
> >>    */
> >> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> >> index 47a6cf892c95..3c5678aec006 100644
> >> --- a/fs/nfs/nfs4client.c
> >> +++ b/fs/nfs/nfs4client.c
> >> @@ -1161,9 +1161,9 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
> >>              return error;
> >>
> >>      if (ctx->rsize)
> >> -            server->rsize = nfs_block_size(ctx->rsize, NULL);
> >> +            server->rsize = nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
> >>      if (ctx->wsize)
> >> -            server->wsize = nfs_block_size(ctx->wsize, NULL);
> >> +            server->wsize = nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
> >>
> >>      server->acregmin = ctx->acregmin * HZ;
> >>      server->acregmax = ctx->acregmax * HZ;
> >
> > This patch seems to have caused a regression. With this patch in place,
> > I can't set an rsize/wsize value that is less than 4k:
> >
> >      # mount server:/export /mnt -o rsize=1024,wsize=1024
> >
> > ...now yields:
> >
> >      server:/export on /mnt type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.210,local_lock=none,addr=192.168.1.3)
> >
> > ...such that the requested sizes were ignored.
> >
> > Was this an intended effect? If we really do want to deprecate the use
> > of small rsize/wsize with TCP/RDMA, then we probably ought to reject
> > these mount attempts with -EINVAL.
>
> I hope that's not the intent! Small r/w sizes can be quite useful for
> many deployments, for example where network bandwidth is limited or
> highly contended. And RDMA below 4KB shifts to inline-only (no direct
> placement), which is useful for constrained environments and can
> actually improve performance in certain cases.
>
> It seems as if there should be some sort of notice if the sizes are
> ignored, in any case. Asking for 1KB and getting 1MB is a rather
> unfriendly result.

That definitely wasn't the intent! I was trying to allow for rsizes
that aren't necessarily a power of two, but didn't think about the
small rsize case when I did it.  I'll work on a fix!

Anna
>
> Tom.
