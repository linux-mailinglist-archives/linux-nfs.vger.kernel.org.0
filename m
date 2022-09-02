Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B25AB16E
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiIBNco (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 09:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiIBNcA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 09:32:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511F2F1B60
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 06:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CED30B82AA2
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 13:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D6C433D6;
        Fri,  2 Sep 2022 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662124143;
        bh=8yJaune/I/GjLWkPAbYvzup7MYyVgo8xj9Dqh8wrCGQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Vi9xxENClUxXZQzEckxVa5KtnbzIcfqX+bItUQWraUZn939g5rLKbGjB/tBjwWaNC
         gBODbUNZCGY5KmAF/Es13jm+OoJ4kPW+kHCOWQxms5Y9Zuv3SN45qRvywnpgFj0X0d
         ub0bbOMIkC0VQORHS4rs3RjjaEZISURgRnS+UsxnsktPq5dy/PnhYNplrHujRr/wDl
         893ftDsNMUmcfnig5ooP3w4YubfAN6Oawt9cJP4VCmHBSFf2S8tgaesSs/GMJgUTcP
         v1q/AAlX4Dwh8irsd0ElBferEi+Twe+wJmQPopj7u0UPViSffalJ/x8nwTMn0QYacQ
         V/dRkqPfW8Hpw==
Message-ID: <86bb9bc0a5b9e46c93c9918b7df6708ef7e01830.camel@kernel.org>
Subject: Re: [PATCH v3 3/6] NFSD: Protect against send buffer overflow in
 NFSv2 READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 02 Sep 2022 09:09:01 -0400
In-Reply-To: <166205940565.1435.7170548905174362083.stgit@manet.1015granger.net>
References: <166204973526.1435.6068003336048840051.stgit@manet.1015granger.net>
         <166205940565.1435.7170548905174362083.stgit@manet.1015granger.net>
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
> Restore the previous limit on the @count argument to prevent a
> buffer overflow attack.
>=20
> Fixes: 53b1119a6e50 ("NFSD: Fix READDIR buffer overflow")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsproc.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 7381972f1677..ddb1902c0a18 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -567,12 +567,11 @@ static void nfsd_init_dirlist_pages(struct svc_rqst=
 *rqstp,
>  	struct xdr_buf *buf =3D &resp->dirlist;
>  	struct xdr_stream *xdr =3D &resp->xdr;
> =20
> -	count =3D clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
> -
>  	memset(buf, 0, sizeof(*buf));
> =20
>  	/* Reserve room for the NULL ptr & eof flag (-2 words) */
> -	buf->buflen =3D count - XDR_UNIT * 2;
> +	buf->buflen =3D clamp(count, (u32)(XDR_UNIT * 2), (u32)PAGE_SIZE);


> +	buf->buflen -=3D XDR_UNIT * 2;
>  	buf->pages =3D rqstp->rq_next_page;
>  	rqstp->rq_next_page++;
> =20
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
