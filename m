Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16F66643B5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbjAJOxk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjAJOxe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 09:53:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBB25FCE
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 06:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43EF861730
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 14:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB74C433F0;
        Tue, 10 Jan 2023 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362412;
        bh=K8i+AOBfZFOGQbMccjMATc/7eIjXMG74VuUV/JltexI=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=VyCjLyugVyWrbE7ctvkfQB111P+yr5DuKmOa8rhwGcF0dgY0UNqWI/8+P74ZtfJrg
         Ey5DdKW7mW6jJ5mCyCT/PBDyIGFJhJsYO9bWHGfRjA/75rdpBSR+YRxItF68nvuHqc
         fQHIqHdPcthllwBC3X7CVLHQZJp2f5KXU0UqCAW7AOdf5KQJhHG+0YxEpYBi+/YTbh
         d2QpfrX6hzDJziq4CwUMFuXyVMIYOpy89VhGN0+ybGAsoNfNGok9lIlLi8EBGcOkOT
         nqzyn64uFzQcV4Ydc8UwSENNxNvNxmFrLAfk9cSz7sACjR/PG1gar7RF/WA2R4lXIB
         99ZEMheq1ksmA==
Message-ID: <64b51ef5ed4b11f8a6d59bf59ce0ab8c36ef454f.camel@kernel.org>
Subject: Re: [PATCH v1 00/27] Server-side RPC reply header parsing overhaul
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date:   Tue, 10 Jan 2023 09:53:30 -0500
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-01-08 at 11:28 -0500, Chuck Lever wrote:
> The purpose of this series is to replace the svc_put* macros in the
> Linux kernel server's RPC reply header construction code with
> xdr_stream helpers. I've measured no change in CPU utilization after
> the overhaul.
>=20
> Memory safety: Buffer bounds checking after encoding each XDR item
> is more memory-safe than the current mechanism. Subsequent memory
> safety improvements to the common xdr_stream helpers will benefit
> all who use them.
>=20
> Audit friendliness: The new code has additional comments and other
> clean-up to help align it with the relevant RPC protocol
> specifications. The use of common helpers also makes the encoders
> easier to audit and maintain.
>=20
> I've split the full series in half to make it easier to review. The
> patches posted here are the second half, handling RPC reply header
> encoding.
>=20
> Note that another benefit of this work is that we are taking one or
> two more strides closer to greater commonality between the client
> and server implementations of RPCSEC GSS.
>=20
> ---
>=20
> Chuck Lever (27):
>       SUNRPC: Clean up svcauth_gss_release()
>       SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_integ()
>       SUNRPC: Record gss_get_mic() errors in svcauth_gss_wrap_integ()
>       SUNRPC: Replace checksum construction in svcauth_gss_wrap_integ()
>       SUNRPC: Convert svcauth_gss_wrap_integ() to use xdr_stream()
>       SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_priv()
>       SUNRPC: Record gss_wrap() errors in svcauth_gss_wrap_priv()
>       SUNRPC: Add @head and @tail variables in svcauth_gss_wrap_priv()
>       SUNRPC: Convert svcauth_gss_wrap_priv() to use xdr_stream()
>       SUNRPC: Check rq_auth_stat when preparing to wrap a response
>       SUNRPC: Remove the rpc_stat variable in svc_process_common()
>       SUNRPC: Add XDR encoding helper for opaque_auth
>       SUNRPC: Push svcxdr_init_encode() into svc_process_common()
>       SUNRPC: Move svcxdr_init_encode() into ->accept methods
>       SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_null_acc=
ept()
>       SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_unix_acc=
ept()
>       SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_tls_acce=
pt()
>       SUNRPC: Convert unwrap data paths to use xdr_stream for replies
>       SUNRPC: Use xdr_stream to encode replies in server-side GSS upcall =
helpers
>       SUNRPC: Use xdr_stream for encoding GSS reply verifiers
>       SUNRPC: Hoist init_encode out of svc_authenticate()
>       SUNRPC: Convert RPC Reply header encoding to use xdr_stream
>       SUNRPC: Final clean-up of svc_process_common()
>       SUNRPC: Remove no-longer-used helper functions
>       SUNRPC: Refactor RPC server dispatch method
>       SUNRPC: Set rq_accept_statp inside ->accept methods
>       SUNRPC: Go back to using gsd->body_start
>=20
>=20
>  fs/lockd/svc.c                    |   5 +-
>  fs/nfs/callback_xdr.c             |   6 +-
>  fs/nfsd/nfscache.c                |   4 +-
>  fs/nfsd/nfsd.h                    |   2 +-
>  fs/nfsd/nfssvc.c                  |  10 +-
>  include/linux/sunrpc/svc.h        | 116 +++----
>  include/linux/sunrpc/xdr.h        |  23 ++
>  include/trace/events/rpcgss.h     |  22 ++
>  net/sunrpc/auth_gss/svcauth_gss.c | 505 +++++++++++++++---------------
>  net/sunrpc/svc.c                  |  91 +++---
>  net/sunrpc/svcauth_unix.c         |  40 ++-
>  net/sunrpc/xdr.c                  |  29 ++
>  12 files changed, 451 insertions(+), 402 deletions(-)
>=20
> --
> Chuck Lever
>=20

I went through the whole set and this all looks like good stuff to me.
The result is a lot more readable, and there is a lot less manual
fiddling with buffer lengths and such.

Do you have a public branch with the current state of this set?

You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
