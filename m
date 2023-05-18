Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C195708332
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 15:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjERNt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjERNtV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 09:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95900E77
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 06:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF6A618D5
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 13:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C73C4339B;
        Thu, 18 May 2023 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684417759;
        bh=Haxgjn+l8zIwOGoUjK5HLIKn5x5c1qsyAX+6hsBR/lU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fuPLluEjPzfyZ0roCpIP2Rxk09KSR9/9vri+sPIMA+vdVl4H8ujanNHyX4U9/YtKf
         7r18LfXjLdXCfzJ+Y7Ue70tc3cvPRJ5mgsuBNL4kHvRx90xhWrc0uY6yjTg0IaEWDF
         E6epbBxJzv1T53g4Cfo89UVcjY4KqNNtJwpfUNCPblPAe5gqFVravVIZFNUODnf6Uj
         4sDBZNkFzlyl+vMcq4P1/MIfw6MIPCU7AlJwNvQ5FN0RTd8jKy9jnsXRFXxTc8GXuF
         jVHPOIYqXnFaeaEP1yk6p2eMWI9SFRVmXLAMzdsN45Uha+6j3O0Ru+OF1i4Q35U2RP
         mO0S8cTmGc47A==
Message-ID: <653b33f74a4d9c1886db230b873146e388543739.camel@kernel.org>
Subject: Re: [PATCH RFC 00/12] client-side RPC-with-TLS
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, anna.schumaker@netapp.com,
        trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Thu, 18 May 2023 09:49:17 -0400
In-Reply-To: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-05-16 at 15:38 -0400, Chuck Lever wrote:
> Now that TLS handshake support is available in the kernel, let's
> have a look at what is needed to support NFS in-transit confiden-
> tiality in the Linux NFS client.
>=20
> These apply to v6.4-rc2 (actually, net-next to be precise), but
> previously they've been tested at multiple NFS bake-a-thon events.
>=20
> ---
>=20
> Chuck Lever (12):
>       NFS: Improvements for fs_context-related tracepoints
>       SUNRPC: Plumb an API for setting transport layer security
>       SUNRPC: Trace the rpc_create_args
>       SUNRPC: Refactor rpc_call_null_helper()
>       SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
>       SUNRPC: Ignore data_ready callbacks during TLS handshakes
>       SUNRPC: Capture CMSG metadata on client-side receive
>       SUNRPC: Add a connect worker function for TLS
>       SUNRPC: Add RPC-with-TLS support to xprtsock.c
>       SUNRPC: Add RPC-with-TLS tracepoints
>       NFS: Have struct nfs_client carry a TLS policy field
>       NFS: Add an "xprtsec=3D" NFS mount option
>=20
>=20
>  fs/nfs/client.c                 |   7 +
>  fs/nfs/fs_context.c             |  55 +++++
>  fs/nfs/internal.h               |   2 +
>  fs/nfs/nfs3client.c             |   1 +
>  fs/nfs/nfs4client.c             |  18 +-
>  fs/nfs/super.c                  |  12 ++
>  include/linux/nfs_fs_sb.h       |   3 +-
>  include/linux/sunrpc/auth.h     |   1 +
>  include/linux/sunrpc/clnt.h     |   2 +
>  include/linux/sunrpc/xprt.h     |  17 ++
>  include/linux/sunrpc/xprtsock.h |   3 +
>  include/trace/events/sunrpc.h   |  96 ++++++++-
>  net/sunrpc/Makefile             |   2 +-
>  net/sunrpc/auth.c               |   2 +-
>  net/sunrpc/auth_tls.c           | 120 +++++++++++
>  net/sunrpc/clnt.c               |  22 +-
>  net/sunrpc/xprtsock.c           | 343 +++++++++++++++++++++++++++++++-
>  17 files changed, 677 insertions(+), 29 deletions(-)
>  create mode 100644 net/sunrpc/auth_tls.c
>=20


These all look reasonable to me. For any that don't already have it, you
can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

I'd really like to see these in linux-next soon, so that there is a
prayer of them making v6.5.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
