Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9465C24B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jan 2023 15:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjACOwN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 09:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjACOwG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 09:52:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FBEEE1E
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 06:52:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 524A3B80F99
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 14:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CECC433EF;
        Tue,  3 Jan 2023 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672757523;
        bh=/OpHo+Yq3vUKiy3k0OhVuXclnih6jCTXeAgRXXf3qYQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=B0fN9/jbok7qwmmuSCoslCsds9lMjziy8MtKwB/RJ/isBncuT4PVRzPgJc2J0FZlG
         l/R4FkUx8vs6Cf7S8h1f/DLKuBOKDpN/B5G0SyQn4mCLQqMnT7Hl9cG0GiOeSqKHUD
         NkTE+8MvLX49NsRcM55CNZrWQHmHUfuoICevtN0CqRt1MxbbmJlWObxEfZwp5JLm8+
         /mwbGfyaep5PYcGKCHvAbwXrf82jSVF/ldQo4iAEQxoNL186wFenqhSgQctmNlS0Ub
         oaMzMW7/oImaZlmMXLQN5BCFaY3VShhEbZ3Brkt6+PMPhaiPGureoLaWf3s7O0sc7Q
         wyvQdO1/1VIug==
Message-ID: <159dd1253c7b49b6654cb4373477f69cc7387b1e.camel@kernel.org>
Subject: Re: [PATCH v1 00/25] Server-side RPC call header parsing overhaul
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date:   Tue, 03 Jan 2023 09:52:01 -0500
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
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

On Mon, 2023-01-02 at 12:05 -0500, Chuck Lever wrote:
> Happy new year, campers.
>=20
> The following series has been percolating for quite a while, thanks
> to the extended 6.1-rc cycle. I'd like to get this work reviewed
> for possible inclusion in v6.3, so I'm starting early.
>=20
> The purpose of this series is to replace the svc_get* macros in the
> Linux kernel server's RPC call header parsing code with xdr_stream
> helpers. I've measured no change in CPU utilization after the
> overhaul; svc_recv() and friends remain the highest CPU consumers by
> an order of magnitude.
>=20
> Memory safety: Buffer bounds checking after decoding each XDR item
> is more memory-safe than the current decoding mechanism. Subsequent
> memory safety improvements to the xdr_stream helpers will benefit
> all who use them.
>=20
> Audit friendliness: The new code has lots of comments and other
> clean-up to help align it with the relevant RPC specifications. The
> use of common helpers also makes the decoders easier to audit.
>=20
> I've split the full series in half to make it easier to review. The
> patches posted here handle RPC call header decoding. Remaining
> patches, to be posted later, deal with RPC reply header encoding.
>=20
> Yes, there are a lot of patches, but they are each small, easily
> chewed mechanical changes.
>=20
> ---
>=20
> Chuck Lever (25):
>       SUNRPC: Push svcxdr_init_decode() into svc_process_common()
>       SUNRPC: Move svcxdr_init_decode() into ->accept methods
>       SUNRPC: Add an XDR decoding helper for struct opaque_auth
>       SUNRPC: Convert svcauth_null_accept() to use xdr_stream
>       SUNRPC: Convert svcauth_unix_accept() to use xdr_stream
>       SUNRPC: Convert svcauth_tls_accept() to use xdr_stream
>       SUNRPC: Move the server-side GSS upcall to a noinline function
>       SUNRPC: Hoist common verifier decoding code into svcauth_gss_proc_i=
nit()
>       SUNRPC: Remove gss_read_common_verf()
>       SUNRPC: Remove gss_read_verf()
>       SUNRPC: Convert server-side GSS upcall helpers to use xdr_stream
>       SUNRPC: Replace read_u32_from_xdr_buf() with existing XDR helper
>       SUNRPC: Rename automatic variables in unwrap_integ_data()
>       SUNRPC: Convert unwrap_integ_data() to use xdr_stream
>       SUNRPC: Rename automatic variables in unwrap_priv_data()
>       SUNRPC: Convert unwrap_priv_data() to use xdr_stream
>       SUNRPC: Convert gss_verify_header() to use xdr_stream
>       SUNRPC: Clean up svcauth_gss_accept's NULL procedure check
>       SUNRPC: Convert the svcauth_gss_accept() pre-amble to use xdr_strea=
m
>       SUNRPC: Hoist init_decode out of svc_authenticate()
>       SUNRPC: Re-order construction of the first reply fields
>       SUNRPC: Eliminate unneeded variable
>       SUNRPC: Decode most of RPC header with xdr_stream
>       SUNRPC: Remove svc_process_common's argv parameter
>       SUNRPC: Hoist svcxdr_init_decode() into svc_process()
>=20
>=20
>  fs/lockd/svc.c                    |   1 -
>  fs/nfs/callback_xdr.c             |   1 -
>  fs/nfsd/nfssvc.c                  |   1 -
>  include/linux/sunrpc/msg_prot.h   |   5 +
>  include/linux/sunrpc/xdr.h        |   5 +-
>  net/sunrpc/auth_gss/svcauth_gss.c | 512 ++++++++++++++++--------------
>  net/sunrpc/svc.c                  |  69 ++--
>  net/sunrpc/svc_xprt.c             |   1 -
>  net/sunrpc/svcauth.c              |  13 +-
>  net/sunrpc/svcauth_unix.c         | 132 +++++---
>  net/sunrpc/xdr.c                  |  50 ++-
>  11 files changed, 468 insertions(+), 322 deletions(-)
>=20
> --
> Chuck Lever
>=20

I went through the whole set and it's all a mostly logical set of
methodical changes. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
