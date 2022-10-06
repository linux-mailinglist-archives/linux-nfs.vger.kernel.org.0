Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055735F6B1B
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJFQAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJFQAA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6FC45994
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 08:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8CBC619F3
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 15:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1351AC433C1;
        Thu,  6 Oct 2022 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665071998;
        bh=T2CvMS1VYMz+C2a54TU1xL/KsaFSLT9nLnEKLZRaWqc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Gk6FGfP1wiq8dodtoHCoRgwcJyCB9bI9ejJZ78Z0C3CyvWEhHJ+/AZJMhFQ8chnIP
         hPsvxzBzossYdldcMPiUG8UZxwbzYR7CsFkp4ahOC1EFNTmRAVUqjepYl1ajpfpv1p
         snyVWq9g/oZiIbkGhEPo4hSEbub1jst0Plk+HWSX/YuAppCvT+NyGHQxg84T0Joc1b
         5clGR9vupu6lM6lKYleQFU52apOdyT0geIoU0Gx88eAO1/ft9KPBnWnl+ikRmMichu
         CIfNZG6+vpLen+ojYrT2e2NrGQrNtlTd8rbePcvYPxYwWjnahnxYT1mkiCyGkxnS0t
         fiRJbscQMxkdw==
Message-ID: <abe560c81f40939a0a1ee374d6ac6d60d4a85aaa.camel@kernel.org>
Subject: Re: [PATCH RFC 6/9] NFSD: Use const pointers as parameters to fh_
 helpers.
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 06 Oct 2022 11:59:56 -0400
In-Reply-To: <166498177448.1527.15278030072978201509.stgit@manet.1015granger.net>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
         <166498177448.1527.15278030072978201509.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-10-05 at 10:56 -0400, Chuck Lever wrote:
> Enable callers to use const pointers where they are able to.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsfh.h |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index c3ae6414fc5c..513e028b0bbe 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -220,7 +220,7 @@ __be32	fh_update(struct svc_fh *);
>  void	fh_put(struct svc_fh *);
> =20
>  static __inline__ struct svc_fh *
> -fh_copy(struct svc_fh *dst, struct svc_fh *src)
> +fh_copy(struct svc_fh *dst, const struct svc_fh *src)
>  {
>  	WARN_ON(src->fh_dentry);
> =20
> @@ -229,7 +229,7 @@ fh_copy(struct svc_fh *dst, struct svc_fh *src)
>  }
> =20
>  static inline void
> -fh_copy_shallow(struct knfsd_fh *dst, struct knfsd_fh *src)
> +fh_copy_shallow(struct knfsd_fh *dst, const struct knfsd_fh *src)
>  {
>  	dst->fh_size =3D src->fh_size;
>  	memcpy(&dst->fh_raw, &src->fh_raw, src->fh_size);
> @@ -243,7 +243,8 @@ fh_init(struct svc_fh *fhp, int maxsize)
>  	return fhp;
>  }
> =20
> -static inline bool fh_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
> +static inline bool fh_match(const struct knfsd_fh *fh1,
> +			    const struct knfsd_fh *fh2)
>  {
>  	if (fh1->fh_size !=3D fh2->fh_size)
>  		return false;
> @@ -252,7 +253,8 @@ static inline bool fh_match(struct knfsd_fh *fh1, str=
uct knfsd_fh *fh2)
>  	return true;
>  }
> =20
> -static inline bool fh_fsid_match(struct knfsd_fh *fh1, struct knfsd_fh *=
fh2)
> +static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
> +				 const struct knfsd_fh *fh2)
>  {
>  	if (fh1->fh_fsid_type !=3D fh2->fh_fsid_type)
>  		return false;
>=20
>=20

Always a good idea.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
