Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18A95A4E8A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiH2NuV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 09:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiH2NuV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 09:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC148EA5
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 06:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC37B81063
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E4DC433C1;
        Mon, 29 Aug 2022 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661781014;
        bh=qs5xYyzN50TajHHwxGpwnEiIRgnD5vefae0gI/dUjpQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=PBnQY725RjD8h6SulOWsFqp2hIp4cwoN+aGs7kuQEoSkivGy/lvKYZoqi6ubweDFR
         joUIMwU7CogFtf6az12oiQHpM8UVD06OtcWvWXOyaD2ikBYUgAu5ELNwdvrjOXV5Xo
         55YBfbZTc9999MC0ef+/3wke/XDecFlYdcRPjMHk1fF+/Lunnt08kc54a00uvCwjPi
         yh7xssCkey6NHmm47nVcxMtKRrBo8guHZ8khhlD6QkfqlUoflaZpjPUUSRUaKXEB+i
         KvT+Fvere5D9PKzfy636ycVlQrPI9HNK521TyKT/YACByNieQ5XHtVIsX0oCXQhr2m
         cUGTmLB0nt88g==
Message-ID: <b64175263e298bc957c8dbf9c7cd2ee6ed84651c.camel@kernel.org>
Subject: Re: [PATCH v2 7/7] NFSD: Clean up nfs4svc_encode_compoundres()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 09:50:12 -0400
In-Reply-To: <166171266025.21449.2692376100575745686.stgit@manet.1015granger.net>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
         <166171266025.21449.2692376100575745686.stgit@manet.1015granger.net>
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

On Sun, 2022-08-28 at 14:51 -0400, Chuck Lever wrote:
> In today's Linux NFS server implementation, the NFS dispatcher
> initializes each XDR result stream, and the NFSv4 .pc_func and
> .pc_encode methods all use xdr_stream-based encoding. This keeps
> rq_res.len automatically updated. There is no longer a need for
> the WARN_ON_ONCE() check in nfs4svc_encode_compoundres().
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..af51e2a8ceb7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5423,12 +5423,8 @@ bool
>  nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xd=
r)
>  {
>  	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> -	struct xdr_buf *buf =3D xdr->buf;
>  	__be32 *p;
> =20
> -	WARN_ON_ONCE(buf->len !=3D buf->head[0].iov_len + buf->page_len +
> -				 buf->tail[0].iov_len);
> -
>  	/*
>  	 * Send buffer space for the following items is reserved
>  	 * at the top of nfsd4_proc_compound().
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
