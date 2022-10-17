Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD11600FC4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJQNDH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 09:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJQNCs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 09:02:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11F5FAE2
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 06:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1F51B80D0B
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 13:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056C2C433D6;
        Mon, 17 Oct 2022 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666011754;
        bh=94U6fTnYKtNCesLWxMn7l4EWJoutFavG9yrS3dB585w=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=rkSTZngBZgDmXGTutrOOArx9U4+Qw/L9gZHchqVC/3YnACezp56Trxhgr1uzRSIKx
         mGUcbznPumfWdyBFSV+JpkufNcrWVoNxsvk8lH4R8/rPDAZATIBgygmnBYLzjmD9vS
         BsGUZyxfhDSoujpHSyHo84UZCxHDdfHP6KJChKutBVwsqrfj+LUER3RCXqd4Y7Rm8m
         1ZvBHDFBKdsteP14AiHBTHtfCiTkf1i8gr4Cu/ITpFv9YFRZ0REhuCokA7V+/t+IsR
         aqxo9DjyZOAYFUW2pMxPEhwqLdbP/OOKIJKpjBcZq2ETWQNCiAbEje8BsNC1xv3GWz
         KGHIEDZgO3jMg==
Message-ID: <f636f0470c83d7b39a7a223dbb20d2e7cb6b5f86.camel@kernel.org>
Subject: Re: [PATCH 1 2/3] NFSD: Finish converting the NFSv2 GETACL result
 encoder
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 17 Oct 2022 09:02:32 -0400
In-Reply-To: <166593522241.1710.1607659813797998942.stgit@klimt.1015granger.net>
References: <166593521604.1710.10648202421284171508.stgit@klimt.1015granger.net>
         <166593522241.1710.1607659813797998942.stgit@klimt.1015granger.net>
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
> The xdr_stream conversion inadvertently left some code that set the
> page_len of the send buffer. The XDR stream encoders should handle
> this automatically now.
>=20
> This oversight adds garbage past the end of the Reply message.
> Clients typically ignore the garbage, but NFSD does not need to send
> it, as it leaks stale memory contents onto the wire.
>=20
> Fixes: f8cba47344f7 ("NFSD: Update the NFSv2 GETACL result encoder to use=
 struct xdr_stream")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs2acl.c |   10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index 9edd3c1a30fb..87f224cd30a8 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -246,7 +246,6 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr)
>  	struct nfsd3_getaclres *resp =3D rqstp->rq_resp;
>  	struct dentry *dentry =3D resp->fh.fh_dentry;
>  	struct inode *inode;
> -	int w;
> =20
>  	if (!svcxdr_encode_stat(xdr, resp->status))
>  		return false;
> @@ -260,15 +259,6 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, s=
truct xdr_stream *xdr)
>  	if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
>  		return false;
> =20
> -	rqstp->rq_res.page_len =3D w =3D nfsacl_size(
> -		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
> -		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
> -	while (w > 0) {
> -		if (!*(rqstp->rq_next_page++))
> -			return true;
> -		w -=3D PAGE_SIZE;
> -	}
> -
>  	if (!nfs_stream_encode_acl(xdr, inode, resp->acl_access,
>  				   resp->mask & NFS_ACL, 0))
>  		return false;
>=20
>=20

That makes a lot more sense now.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
