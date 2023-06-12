Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0040C72C85C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbjFLO0j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbjFLO0A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52AC2950;
        Mon, 12 Jun 2023 07:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 483BF60AEA;
        Mon, 12 Jun 2023 14:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349F0C433EF;
        Mon, 12 Jun 2023 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579865;
        bh=nL7l6jMDIUNe58Kj1nogyDqcGnGnbDiPkg0Tqwab0VU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CnZ7XZLzrNzlKkGqwSkmLdk5A6XurVS25ZHTvIFnhnO9iqQ/0vC5pyhfzTsQZU2tE
         gZsfwa9umjFjMIHepG5RNJGdOzJ3O3oycepnwvVCJL+ftBuqtLXdQ8wXhJusvBswGL
         UokPLx5FmsE5MVPtCIAtoAKOZLIbxDg+npb8CdGkVa4MMaQ29V6MAsR7bw5LIo2jPK
         40vUTVEaYwPDQV5PA4T0TLczQsqg+/Heo9bp681YuijdGBIQsYF/DCphOsUKIRIyPk
         wRbpRmFPZhWJgWGEajM0dudLGZH+sEeKeJijeQx9J0VHZsXJU83cI+VBSkE5xgeHih
         vM1/YYM2IN2qw==
Message-ID: <e3225c285c67f4b2840ee3f5ac138e6e8c63fc89.camel@kernel.org>
Subject: Re: [PATCH v2 1/5] SUNRPC: Revert cc93ce9529a6 ("svcrdma: Retain
 the page backing rq_res.head[0].iov_base")
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Mon, 12 Jun 2023 10:24:23 -0400
In-Reply-To: <168657900128.5619.7769165526407423007.stgit@manet.1015granger.net>
References: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
         <168657900128.5619.7769165526407423007.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-06-12 at 10:10 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Pre-requisite for releasing pages in the send completion handler.
> Reverted by hand: patch -R would not apply cleanly.
>=20

I'm guessing because there were other patches to this area in the
interim that you didn't want to revert?

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c |    5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/=
svc_rdma_sendto.c
> index a35d1e055b1a..8e7ccef74207 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -975,11 +975,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>  	ret =3D svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
>  	if (ret < 0)
>  		goto put_ctxt;
> -
> -	/* Prevent svc_xprt_release() from releasing the page backing
> -	 * rq_res.head[0].iov_base. It's no longer being accessed by
> -	 * the I/O device. */
> -	rqstp->rq_respages++;
>  	return 0;
> =20
>  reply_chunk:
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
