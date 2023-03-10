Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A86B4E1D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Mar 2023 18:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCJRNb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Mar 2023 12:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCJRNa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Mar 2023 12:13:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E9303EC
        for <linux-nfs@vger.kernel.org>; Fri, 10 Mar 2023 09:13:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEB361B32
        for <linux-nfs@vger.kernel.org>; Fri, 10 Mar 2023 17:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EA8C433EF;
        Fri, 10 Mar 2023 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678468402;
        bh=7cOoLZBZo7l93twDp4l8rMn9mpLjFdtn74GiojcBOsU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N7tRPzNJcDWknNJRmtX2GOrjE/FQDx2N+Xrp2In6JjaXfPPQtmsr/uOiKCh4YWaxi
         RB0MVwgo3xI69EilBjDch80Hl2PLv5pIkgrhp7w25GiLITTTYUOgyLefYRegfzIU7t
         /PErCnCXJ0iRP5cw8kuqgv13lBfum7cTKINQndSpotJ03w1xrh2CEz+Kmgsaea080e
         OKPGtILRYfE3PXGSFTDnEBphhA2qhnjlHiwc2Cea6LPfsXfNZLn2JDrVmLhGqyMW1r
         aqhMzW8b+ksyK+BWi2XsBA0I4jDVeTjiUgRBZpIJtfPhmVypo5jhHdDgpSK3E3YJg5
         odoJ5m+VfrSJw==
Message-ID: <47bdf5f3c522a3976bb7a747bea2a618afa6cb17.camel@kernel.org>
Subject: Re: [PATCH] lockd: add some client-side tracepoints
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 10 Mar 2023 12:13:20 -0500
In-Reply-To: <167846387033.12529.1222975070992586314.stgit@klimt.1015granger.net>
References: <167846387033.12529.1222975070992586314.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-03-10 at 10:58 -0500, Chuck Lever wrote:
> From: Jeff Layton <jlayton@kernel.org>
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/lockd/Makefile   |    6 ++-
>  fs/lockd/clntlock.c |    4 ++
>  fs/lockd/clntproc.c |   14 +++++++
>  fs/lockd/trace.c    |    3 +
>  fs/lockd/trace.h    |  106 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 131 insertions(+), 2 deletions(-)
>  create mode 100644 fs/lockd/trace.c
>  create mode 100644 fs/lockd/trace.h
>=20
> Jeff, how about something like this?
>=20

Looks good. Thanks for fixing it up!
--=20
Jeff Layton <jlayton@kernel.org>
