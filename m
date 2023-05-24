Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5A70FE8B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjEXTan (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 May 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXTan (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 May 2023 15:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F792A4
        for <linux-nfs@vger.kernel.org>; Wed, 24 May 2023 12:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AFE26359F
        for <linux-nfs@vger.kernel.org>; Wed, 24 May 2023 19:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C654DC433D2;
        Wed, 24 May 2023 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684956641;
        bh=bIiS9hFme942pu5OXr26AmS5sLaYk5kvKswfy+P7qmc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fSnUJB95dUbbB2l0AJFq+ITUXm1pHINf8cYQvuBfg4BhU86BiYXJLsxS5esV1CsAl
         CbI1rpvzWGB1/jRN4GHYd+Y9sfSIQn3ZB2Vj6nKbsvh4HES0PBiey8K5RZyRpScx1w
         mO50OfSogr1iWAGQ6cT26+Wn6mHUHrFC+UIn3LINjfTl+JjjPUnub+8J02Qy+SEyLJ
         UZOpYwWKjeMakeED2jRD+2YJUhdNYqvYEDp0jnVicDihupRBBpLc8B0ZypbM1C8Nn0
         32OGdq8b2OCI7dR9cmnbqBy2yKRohlUFj2IXG73XXWJXT7S/eQqGtOHS3K2pdh1NtC
         z9IJ2KD9YaY2A==
Message-ID: <4dafe5e56ac269bad9fc45dfee2f2bdcada0876d.camel@kernel.org>
Subject: Re: [PATCH v2 00/11] client-side RPC-with-TLS
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, anna.schumaker@netapp.com,
        trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 24 May 2023 15:30:39 -0400
In-Reply-To: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
References: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
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

On Tue, 2023-05-23 at 10:29 -0400, Chuck Lever wrote:
> Let's have a look at what is needed to support NFS in-transit
> confidentiality in the Linux NFS client. These apply to net-next
> but previously they've been tested at multiple NFS bake-a-thon
> events.
>=20

Why net-next? Aren't the necessary non-NFS/RPC bits now in mainline at
this point? What's missing?

> This series is also available in the topic-rpc-with-tls-upcall
> branch at
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> Changes since RFC:
> - Add an rpc_authops method to send TLS probes
>=20
> ---
>=20
> Chuck Lever (11):
>       NFS: Improvements for fs_context-related tracepoints
>       SUNRPC: Plumb an API for setting transport layer security
>       SUNRPC: Trace the rpc_create_args
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
>  include/linux/sunrpc/auth.h     |   2 +
>  include/linux/sunrpc/clnt.h     |   2 +
>  include/linux/sunrpc/xprt.h     |  17 ++
>  include/linux/sunrpc/xprtsock.h |   3 +
>  include/trace/events/sunrpc.h   |  96 ++++++++-
>  net/sunrpc/Makefile             |   2 +-
>  net/sunrpc/auth.c               |   2 +-
>  net/sunrpc/auth_tls.c           | 175 ++++++++++++++++
>  net/sunrpc/clnt.c               |   9 +-
>  net/sunrpc/xprtsock.c           | 343 +++++++++++++++++++++++++++++++-
>  17 files changed, 727 insertions(+), 22 deletions(-)
>  create mode 100644 net/sunrpc/auth_tls.c
>=20
> --
> Chuck Lever
>=20

--=20
Jeff Layton <jlayton@kernel.org>
