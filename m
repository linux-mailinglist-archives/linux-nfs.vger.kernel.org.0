Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7E5AB2C8
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiIBOD3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbiIBOCP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 10:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488E12DCC2
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 06:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D634661E8A
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 13:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027C0C433D6;
        Fri,  2 Sep 2022 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662124523;
        bh=nJvHMV2OoOv1XXgqYkYzNYKg9bepmLrenrTi2gXOZB8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=NT2OIT6F+gM8eEvTI3o1cLkbb5WOmWLd4IJUlgOMTIf9Yoll0e5HWS/wYD7rqdaNv
         D2MgyOaspSQTja9UtW+ot2LKNfrlP55F3PyNGfZtHxxGvGKRqFbEiSYi99nTQzzBHy
         5gZzwPCF9obJYJA7AdCXH9yFA3hg9NW1ZywhcQY3MkP75Vn4C7M88kdBy04ZSSkMWo
         z0VrDDz962UWQz8sRimg4kF5V3ZvKtKmGGmZPnY4MwI52SQgk87gOnSNU+FZt0WFd+
         mXZfY6upB0egIyebGiXwphMGhYOcpWBXXDJAnJLpQX9x8fueGtIyZLs/7u3btNcqRs
         bB6d5zVbkA5sw==
Message-ID: <d6c49af5c8b5635d5537e1cc1f43da7c16617c64.camel@kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Protect against send buffer overflow in
 NFSv3 READ
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 02 Sep 2022 09:15:21 -0400
In-Reply-To: <166205942489.1435.8984764212504461615.stgit@manet.1015granger.net>
References: <166204973526.1435.6068003336048840051.stgit@manet.1015granger.net>
         <166205942489.1435.8984764212504461615.stgit@manet.1015granger.net>
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
> large RPC Reply at the same time.
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
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 7a159785499a..5b1e771238b3 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -150,7 +150,6 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
>  {
>  	struct nfsd3_readargs *argp =3D rqstp->rq_argp;
>  	struct nfsd3_readres *resp =3D rqstp->rq_resp;
> -	u32 max_blocksize =3D svc_max_payload(rqstp);
>  	unsigned int len;
>  	int v;
> =20
> @@ -159,7 +158,8 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
>  				(unsigned long) argp->count,
>  				(unsigned long long) argp->offset);
> =20
> -	argp->count =3D min_t(u32, argp->count, max_blocksize);
> +	argp->count =3D min_t(u32, argp->count, svc_max_payload(rqstp));
> +	argp->count =3D min_t(u32, argp->count, rqstp->rq_res.buflen);
>  	if (argp->offset > (u64)OFFSET_MAX)
>  		argp->offset =3D (u64)OFFSET_MAX;
>  	if (argp->offset + argp->count > (u64)OFFSET_MAX)
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
