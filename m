Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A9600FDA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJQNE1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJQNES (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 09:04:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392A5FADE
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 06:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8385B81637
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 13:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C8EC433D6;
        Mon, 17 Oct 2022 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666011850;
        bh=ABHmjdx3OdijdTiO5vp0DDDX4rwp8QFnDJ81bxlazEs=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=T0uWTmAdXm4UxT7LndEYsBHTscyRZWR6WRoQgMc/mczOUexUlpfr7xM0qSL39IgZn
         xEyFd6vdPd7fiUBhHH4eEKD50n0FKPoZfsknp/yx88KADYr8rVHHsnJuZ40Moc32BN
         9OcRvsqfswQEARqpcEo9D7GUeNdUCMLM8SgmRnWJMmuSC8wot97TmTETiMcoJ0MaJj
         LvOQkt7ib6xUPnGvSEe/dfgsNk5ZbEkFoYIOBEWhRZ4LU1GXbnLAEtoraxozq3b70B
         hQ0Eqci7gQVjWH/lI1a+FG70vdmIlo5L4ne/D3/xzetTiMvJEYADHMVN320V+qjrLd
         nnCWIpuhqIrrQ==
Message-ID: <9ae1b87c86abee8e2f7e234256e50fd42fc0e930.camel@kernel.org>
Subject: Re: [PATCH 1 3/3] NFSD: Finish converting the NFSv3 GETACL result
 encoder
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 17 Oct 2022 09:04:08 -0400
In-Reply-To: <166593522862.1710.16255807600348080659.stgit@klimt.1015granger.net>
References: <166593521604.1710.10648202421284171508.stgit@klimt.1015granger.net>
         <166593522862.1710.16255807600348080659.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-10-16 at 11:47 -0400, Chuck Lever wrote:
> For some reason, the NFSv2 GETACL result encoder was fully converted
> to use the new nfs_stream_encode_acl(), but the NFSv3 equivalent was
> not similarly converted.
>=20
> Fixes: 20798dfe249a ("NFSD: Update the NFSv3 GETACL result encoder to use=
 struct xdr_stream")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3acl.c |   30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 9446c6743664..7c798b5f4ec6 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -171,11 +171,7 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, str=
uct xdr_stream *xdr)
>  {
>  	struct nfsd3_getaclres *resp =3D rqstp->rq_resp;
>  	struct dentry *dentry =3D resp->fh.fh_dentry;
> -	struct kvec *head =3D rqstp->rq_res.head;
>  	struct inode *inode;
> -	unsigned int base;
> -	int n;
> -	int w;
> =20
>  	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
>  		return false;
> @@ -187,26 +183,12 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr)
>  		if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
>  			return false;
> =20
> -		base =3D (char *)xdr->p - (char *)head->iov_base;
> -
> -		rqstp->rq_res.page_len =3D w =3D nfsacl_size(
> -			(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
> -			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
> -		while (w > 0) {
> -			if (!*(rqstp->rq_next_page++))
> -				return false;
> -			w -=3D PAGE_SIZE;
> -		}
> -
> -		n =3D nfsacl_encode(&rqstp->rq_res, base, inode,
> -				  resp->acl_access,
> -				  resp->mask & NFS_ACL, 0);
> -		if (n > 0)
> -			n =3D nfsacl_encode(&rqstp->rq_res, base + n, inode,
> -					  resp->acl_default,
> -					  resp->mask & NFS_DFACL,
> -					  NFS_ACL_DEFAULT);
> -		if (n <=3D 0)
> +		if (!nfs_stream_encode_acl(xdr, inode, resp->acl_access,
> +					   resp->mask & NFS_ACL, 0))
> +			return false;
> +		if (!nfs_stream_encode_acl(xdr, inode, resp->acl_default,
> +					   resp->mask & NFS_DFACL,
> +					   NFS_ACL_DEFAULT))
>  			return false;
>  		break;
>  	default:
>=20
>=20

Much cleaner.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
