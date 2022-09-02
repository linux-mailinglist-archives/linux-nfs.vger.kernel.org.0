Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C255AB1A3
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiIBNhn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbiIBNgv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 09:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5E6EA882
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 06:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABAD62074
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 13:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A60C433D6;
        Fri,  2 Sep 2022 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662124466;
        bh=QizeWyoBjkNR0FQWB4ktd+594kSKd/dLwPK0C+KmXKs=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ChmNmyr0jlFXsQaxLmYrM5WmaXjYtCIdBrqbuzhMyD9141AFgTraTqGKOfXvCn+iN
         Xta6HEnzCsi8mMF9Y29OaewdwPArH/d80uvg83tmVfcSM1LKXNZGV0ufCaSHhurLHC
         mrdEUhnSWre62NB0DRNcM56HfAOAHJ1G2XUFU1IwZdnKJiWTXovF5QV1icqxbo1UMu
         FwzybIlor4kVWEN4ZwLiriWGc8A+hCuqtVv2ZmPwVc9Tqcoe+i/5+48Bn3sUaGeP1R
         cSZeAUKXPx2GS6JdgRbZQ9n1ooxR/RbUeLdizkIm5FuhF6VKI9SA6xT1/UoPy1YBqp
         M3OMog+PNL4Fw==
Message-ID: <13dd5b2a5d90ebf4dd782d89a34cb2d7ce62f7e2.camel@kernel.org>
Subject: Re: [PATCH v3 5/6] NFSD: Protect against send buffer overflow in
 NFSv2 READ
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 02 Sep 2022 09:14:24 -0400
In-Reply-To: <166205941847.1435.15080240781458940273.stgit@manet.1015granger.net>
References: <166204973526.1435.6068003336048840051.stgit@manet.1015granger.net>
         <166205941847.1435.15080240781458940273.stgit@manet.1015granger.net>
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
>  fs/nfsd/nfsproc.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index ddb1902c0a18..4b19cc727ea5 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -185,6 +185,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
>  		argp->count, argp->offset);
> =20
>  	argp->count =3D min_t(u32, argp->count, NFSSVC_MAXBLKSIZE_V2);
> +	argp->count =3D min_t(u32, argp->count, rqstp->rq_res.buflen);
> =20
>  	v =3D 0;
>  	len =3D argp->count;
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
