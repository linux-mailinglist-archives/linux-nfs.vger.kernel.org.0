Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71CD578BB5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiGRU0G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiGRU0G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 16:26:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED526AD8
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 13:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 512C0B8173A
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 20:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC11EC341C0;
        Mon, 18 Jul 2022 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658175961;
        bh=SuMQXeAHWvkdhEh/4MyOvL702Ye2GgbKkMEbCNiqrII=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e8t05wopVD9BXWQJIw8pcHSl9VDn7XlALvervf9XcaC2fWvfkWUH0ZV4DtJsfb+wC
         mIU108dKFIOm439+dQSpKHPEd3sHtZqEvZEjyjysz6FKSpMj9UiGz7SS15kQUzkmrT
         EfNGh5ihKmumSB91NmXYCm/WfDVPZf+0DNDz/FX0WO9UJ9yWHnlV75JFLon7iiQmmU
         gYkwbqOhhPFObkiFJfs+0sxw1g2rKKc5P7/vkFfN3PZRDS/qql/PKWFi4LuShFuSPR
         +DkyzvOHoPhB5UV+TC9JG41uMLJImOvYM85KNnnDABZtk7685mmLxVpON1NNe8DYjR
         7yidW1ZSo6Mcg==
Message-ID: <56188220b31296572324b4709ceafd458db47d42.camel@kernel.org>
Subject: Re: [PATCH v2 00/15] RPC-with-TLS client side
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 18 Jul 2022 16:25:59 -0400
In-Reply-To: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
> Now that the initial v5.19 merge window has closed, it's time for
> another round of review for RPC-with-TLS support in the Linux NFS
> client. This is just the RPC-specific portions. The full series is
> available in the "topic-rpc-with-tls-upcall" branch here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> I've taken two or three steps towards implementing the architecture
> Trond requested during the last review. There is now a two-stage
> connection establishment process so that the upper level can use
> XPRT_CONNECTED to determine when a TLS session is ready to use.
> There are probably additional changes and simplifications that can
> be made. Please review and provide feedback.
>=20
> I wanted to make more progress on client-side authentication (ie,
> passing an x.509 cert from the client to the server) but NFSD bugs
> have taken all my time for the past few weeks.
>=20
>=20
> Changes since v1:
> - Rebased on v5.18
> - Re-ordered so generic fixes come first
> - Addressed some of Trond's review comments
>=20
> ---
>=20
> Chuck Lever (15):
>       SUNRPC: Fail faster on bad verifier
>       SUNRPC: Widen rpc_task::tk_flags
>       SUNRPC: Replace dprintk() call site in xs_data_ready
>       NFS: Replace fs_context-related dprintk() call sites with tracepoin=
ts
>       SUNRPC: Plumb an API for setting transport layer security
>       SUNRPC: Trace the rpc_create_args
>       SUNRPC: Refactor rpc_call_null_helper()
>       SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
>       SUNRPC: Ignore data_ready callbacks during TLS handshakes
>       SUNRPC: Capture cmsg metadata on client-side receive
>       SUNRPC: Add a connect worker function for TLS
>       SUNRPC: Add RPC-with-TLS support to xprtsock.c
>       SUNRPC: Add RPC-with-TLS tracepoints
>       NFS: Have struct nfs_client carry a TLS policy field
>       NFS: Add an "xprtsec=3D" NFS mount option
>=20
>=20
>  fs/nfs/client.c                 |  14 ++
>  fs/nfs/fs_context.c             |  65 +++++--
>  fs/nfs/internal.h               |   2 +
>  fs/nfs/nfs3client.c             |   1 +
>  fs/nfs/nfs4client.c             |  16 +-
>  fs/nfs/nfstrace.h               |  77 ++++++++
>  fs/nfs/super.c                  |   7 +
>  include/linux/nfs_fs_sb.h       |   5 +-
>  include/linux/sunrpc/auth.h     |   1 +
>  include/linux/sunrpc/clnt.h     |  15 +-
>  include/linux/sunrpc/sched.h    |  32 ++--
>  include/linux/sunrpc/xprt.h     |   2 +
>  include/linux/sunrpc/xprtsock.h |   4 +
>  include/net/tls.h               |   2 +
>  include/trace/events/sunrpc.h   | 157 ++++++++++++++--
>  net/sunrpc/Makefile             |   2 +-
>  net/sunrpc/auth.c               |   2 +-
>  net/sunrpc/auth_tls.c           | 120 +++++++++++++
>  net/sunrpc/clnt.c               |  34 ++--
>  net/sunrpc/debugfs.c            |   2 +-
>  net/sunrpc/xprtsock.c           | 310 +++++++++++++++++++++++++++++++-
>  21 files changed, 805 insertions(+), 65 deletions(-)
>  create mode 100644 net/sunrpc/auth_tls.c
>=20
> --
> Chuck Lever
>=20

This looks pretty good overall. Nice work, Chuck. FWIW, I pulled these
and ktls-utils down and gave them a spin and they worked just fine. You
can add:

Tested-by: Jeff Layton <jlayton@kernel.org>
