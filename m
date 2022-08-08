Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF058CDF8
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiHHSsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiHHSsb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 14:48:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DA433E
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 11:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920EA6123A
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 18:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B209DC433C1;
        Mon,  8 Aug 2022 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659984510;
        bh=3g4jQzoKmYNdHVCFSwW7DzZTZFECERPgub8in86+Zw8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=OHhvlRsQIts/NrPS0KIwM0Z7+jfpz4Cf16KsOb6S/J+4CERkVq8hhWlSp3yBcLSCn
         IfWwn//26+i5Q4VvFR7sEqPwfhB0nBX9ZDmsea+3OkZ9KwkwadiD6qHvUZ+Gzk5UTr
         7orktKVWtORanTS1Sbk940O2CyXTH315+FdCmFjrtt3aO4XUs88AtKFf5xFvXTH848
         2UCI6nRJX5BTqcVK7arVJtM0FmC7qo/OsOu5W6zuon46ln4EuzGOi6em/o6ZsY8ru1
         wA5kfM9OgbyRZfzbxj1Q2cL1y6LSZBphwZoY+xEU5/8Z0ZufaTpRAE0vciEOaBMnvl
         YpRedEH0BHkCg==
Message-ID: <55bc0656a841cc1229d2b1594d4f9eeabfd00ae5.camel@kernel.org>
Subject: Re: [PATCH v3 0/7] Wait for DELEGRETURN before returning
 NFS4ERR_DELAY
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 08 Aug 2022 14:48:28 -0400
In-Reply-To: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
References: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-08-08 at 09:52 -0400, Chuck Lever wrote:
> This RFC series adds logic to the Linux NFS server to make it wait a
> few moments for clients to return a delegation before replying with
> NFS4ERR_DELAY. There are two main benefits:
>=20
> - This improves responsiveness when a delegated file is accessed
>  from another client
> - This removes an unnecessary latency if a client has neglected to
>  return a delegation before attempting a RENAME or SETATTR
>=20
> This series is incomplete:
> - There are likely other operations that can benefit (eg. OPEN)
>=20
> This series applies against v5.19.
>=20
> Changes since v2:
> - Wake immediately after client sends DELEGRETURN
> - More tracepoint improvements
>=20
> Changes since RFC:
> - Eliminate spurious console messages on the server
> - Wait for DELEGRETURN for RENAME operations
    ^^^^
Does REMOVE need similar treatment? Does the Apple client return a
delegation before attempting to unlink?

> - Add CB done tracepoints
> - Rework the retry loop
>=20
> ---
>=20
> Chuck Lever (7):
>       NFSD: Instrument fh_verify()
>       NFSD: Replace dprintk() call site in fh_verify()
>       NFSD: Trace NFSv4 COMPOUND tags
>       NFSD: Add tracepoints to report NFSv4 callback completions
>       NFSD: Add a mechanism to wait for a DELEGRETURN
>       NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
>       NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY
>=20
>=20
>  fs/nfsd/nfs4layouts.c |   2 +-
>  fs/nfsd/nfs4proc.c    |  56 +++++++++++---
>  fs/nfsd/nfs4state.c   |  35 +++++++++
>  fs/nfsd/nfsd.h        |   1 +
>  fs/nfsd/nfsfh.c       |  13 +---
>  fs/nfsd/trace.h       | 171 ++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/xdr4.h        |   2 +
>  7 files changed, 251 insertions(+), 29 deletions(-)
>=20
> --
> Chuck Lever
>=20

The new tracepoints are nice and the patchset makes sense. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
