Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E072C87A
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbjFLO2c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjFLO15 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0A4218;
        Mon, 12 Jun 2023 07:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 487D1615E3;
        Mon, 12 Jun 2023 14:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A4FC433EF;
        Mon, 12 Jun 2023 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579933;
        bh=1QN+wibte9UdTu/xl/F/Vy1jMSH7s2/Fs8zWQdoJGww=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q/0nv8b+VV1GagZm73urXz743ObDdOITodqUsVl1wHgf7afkNIEhVUjvtdINbE/8L
         B9+VpXmKqRT/9tnKomHxdhnU2SfQ4hY1mDuPaXdOTQDXbu0vSkChRvReotGMim+32L
         sS4Tn6qERob8CY97vhKctesIvMJFlZvQTxaLVJ0Nu/s3cVxkbBqhO7TmJMN7dSVxj7
         d5dkvTLqf5Vq1alp4blYp1qVMoFtC4b5cvWuwFfiZapysWqO4HayZbbEaLH2kh6vLp
         yDXPdGi3XWAxR0zSK0koYGl1stoEjK+myLFhAmeWIR1CDaz7jmDBbzn5+dH+ZJaDwO
         bTB2DK0B9xjbg==
Message-ID: <17dbe8ebd9034cd181297409fa689ad363f84697.camel@kernel.org>
Subject: Re: [PATCH v2 0/5] svcrdma: Go back to releasing pages-under-I/O
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 12 Jun 2023 10:25:31 -0400
In-Reply-To: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
References: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Mon, 2023-06-12 at 10:09 -0400, Chuck Lever wrote:
> Return to the behavior of releasing reply buffer pages as part of
> sending an RPC Reply over RDMA. I measured a performance improvement
> (which is documented in 4/4). Matching the page release behavior of
> socket transports also means we should be able to share a little
> more code between transports as MSG_SPLICE_PAGES rolls out.
>=20
> Changes since v1:
> - Add a related fix
> - Clarify some of the patch descriptions
>=20
> ---
>=20
> Chuck Lever (5):
>       SUNRPC: Revert cc93ce9529a6 ("svcrdma: Retain the page backing rq_r=
es.head[0].iov_base")
>       SUNRPC: Revert 579900670ac7 ("svcrdma: Remove unused sc_pages field=
")
>       svcrdma: Revert 2a1e4f21d841 ("svcrdma: Normalize Send page handlin=
g")
>       svcrdma: Prevent page release when nothing was received
>       SUNRPC: Optimize page release in svc_rdma_sendto()
>=20
>=20
>  include/linux/sunrpc/svc_rdma.h            |  4 +-
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  8 +---
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 12 ++---
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 53 ++++++++++++++--------
>  4 files changed, 44 insertions(+), 33 deletions(-)
>=20
> --
> Chuck Lever
>=20

Kind of cool that we're getting to the place where micro-optimizations
like this make such a big difference! This all looks fine to me:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
