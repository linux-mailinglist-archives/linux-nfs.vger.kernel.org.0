Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00C35AB1C5
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiIBNjj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiIBNiq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 09:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D7E588C
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 06:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 528956206B
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 13:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B3CC433C1;
        Fri,  2 Sep 2022 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662124351;
        bh=tyYIsIkZY6uSMJKlwRH66HMPiYM7IXhUQ2tYayZxyTM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=W0F1ueBkY1E0A2EDBtCFG/P0afgRlhgVhfQ8UXFgh09bQK5QNbaX3MB60TH1Rv127
         k6DHKnaH7IzC/3/UlGBq++wKqdbk1iA3A4nYwFLIaHWS4jv+yLsfCQTDaLYVYwrH+J
         yVlCw1628szH7tF0d814F72LQBUk2cK+E65Yvc3ADdCezHV7gm5kCwylDVFd8EKq3U
         GBmPJn3LUog7uW5uxtFIymhfE0RJRCf2UUDacEnYpFFzcgBE4zQAcM/V8NofdZst2S
         xJsYrCP0olvO7TioVkuUST0S8vPgz3vIUrPlXm2PXCuf9+H/PJ5hd9ArbTqElt5AI9
         AQ7ITFEVgke0Q==
Message-ID: <3490fa376a463474cec0024798b2ebe25808141f.camel@kernel.org>
Subject: Re: [PATCH v3 4/6] NFSD: Protect against send buffer overflow in
 NFSv3 READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 02 Sep 2022 09:12:30 -0400
In-Reply-To: <166205941213.1435.18172275008498406790.stgit@manet.1015granger.net>
References: <166204973526.1435.6068003336048840051.stgit@manet.1015granger.net>
         <166205941213.1435.18172275008498406790.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Thu, 2022-09-01 at 15:10 -0400, Chuck Lever wrote:
> Since before the git era, NFSD has conserved the number of pages
> held by each nfsd thread by combining the RPC receive and send
> buffers into a single array of pages. This works because there are
> no cases where an operation needs a large RPC Call message and a
> large RPC Reply message at the same time.
>=20
> Once an RPC Call has been received, svc_process() updates
> svc_rqst::rq_res to describe the part of rq_pages that can be
> used for constructing the Reply. This means that the send buffer
> (rq_res) shrinks when the received RPC record containing the RPC
> Call is large.
>=20
> A client can force this shrinkage on TCP by sending a correctly-
> formed RPC Call header contained in an RPC record that is
> excessively large. The full maximum payload size cannot be
> constructed in that case.
>=20
> Thanks to Aleksi Illikainen and Kari Hulkko for uncovering this
> issue.
>=20
> Reported-by: Ben Ronallo <Benjamin.Ronallo@synopsys.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index a41cca619338..7a159785499a 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -563,13 +563,14 @@ static void nfsd3_init_dirlist_pages(struct svc_rqs=
t *rqstp,
>  {
>  	struct xdr_buf *buf =3D &resp->dirlist;
>  	struct xdr_stream *xdr =3D &resp->xdr;
> -
> -	count =3D clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
> +	unsigned int sendbuf =3D min_t(unsigned int, rqstp->rq_res.buflen,
> +				     svc_max_payload(rqstp));
> =20
>  	memset(buf, 0, sizeof(*buf));
> =20
>  	/* Reserve room for the NULL ptr & eof flag (-2 words) */
> -	buf->buflen =3D count - XDR_UNIT * 2;
> +	buf->buflen =3D clamp(count, (u32)(XDR_UNIT * 2), sendbuf);
> +	buf->buflen -=3D XDR_UNIT * 2;
>  	buf->pages =3D rqstp->rq_next_page;
>  	rqstp->rq_next_page +=3D (buf->buflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
> =20
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
