Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA25B5E0C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiILQUm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILQUl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 12:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0E42315F
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 09:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F17561245
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 16:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCDEC433D6;
        Mon, 12 Sep 2022 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662999639;
        bh=yCvuqecQxJP5tSnVH0Tmm65khlb0vb/juPsP+q70WjQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=OgkgqEqxnWIkieuhnfPTlTK9zdr5VbiabIe0JAOL76C5AiPkL3AGshPNi9Eab/4Ph
         xZFPJWG7ohNcU5HB4NRiugomp4nVf7h3MTKMF+JNyZpJ/ej+xKtVp7WnSSFPG35LES
         9yYRM8+qY7AscJ0dQuyrthW2XTv0v+eaIj+NuhaI56l58R98ZjwM1h5daIByfj5e+J
         cQmX3nXhUXHj7zUrZXnrnE1p2yae/LA1HYJF81O2qQlcxJBZfHAaW7mkONpYaXzFmY
         FHucBpjRTVHQERI5ToIYO0PDyvwbsfQH3f+CHlVBfQ0y0bxh5EoEIMqJ38d+zp5nb6
         D903NP/6CYlKQ==
Message-ID: <f9a48b3f0a6497014dc35ceb7835b5c543f48f59.camel@kernel.org>
Subject: Re: [PATCH v4 6/8] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 12:20:37 -0400
In-Reply-To: <166267525333.1842.10708885965116635193.stgit@manet.1015granger.net>
References: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
         <166267525333.1842.10708885965116635193.stgit@manet.1015granger.net>
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

On Thu, 2022-09-08 at 18:14 -0400, Chuck Lever wrote:
> nfsd_setattr() can kick off a CB_RECALL (via
> notify_change() -> break_lease()) if a delegation is present. Before
> returning NFS4ERR_DELAY, give the client holding that delegation a
> chance to return it and then retry the nfsd_setattr() again, once.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D354
> Tested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 02f31d8c727a..03a826ccc165 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -394,6 +394,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>  	int		host_err;
>  	bool		get_write_count;
>  	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
> +	int		retries;
> =20
>  	if (iap->ia_valid & ATTR_SIZE) {
>  		accmode |=3D NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
> @@ -455,7 +456,13 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  	}
> =20
>  	inode_lock(inode);
> -	host_err =3D __nfsd_setattr(dentry, iap);
> +	for (retries =3D 1;;) {
> +		host_err =3D __nfsd_setattr(dentry, iap);
> +		if (host_err !=3D -EAGAIN || !retries--)
> +			break;

Can __nfsd_setattr return -EAGAIN for entirely different reasons? I
try_break_deleg will, but could an underlying filesystem's ->setattr
operation return -EAGAIN for an unrelated reason?

Then again, you're only retrying once, so maybe it's no big deal.

> +		if (!nfsd_wait_for_delegreturn(rqstp, inode))
> +			break;
> +	}
>  	if (attr->na_seclabel && attr->na_seclabel->len)
>  		attr->na_labelerr =3D security_inode_setsecctx(dentry,
>  			attr->na_seclabel->data, attr->na_seclabel->len);
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
