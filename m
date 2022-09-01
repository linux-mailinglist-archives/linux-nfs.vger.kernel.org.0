Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B15A95A1
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 13:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiIALWq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiIALWn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 07:22:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36E2139F7E;
        Thu,  1 Sep 2022 04:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBA27B825CB;
        Thu,  1 Sep 2022 11:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D696FC433C1;
        Thu,  1 Sep 2022 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662031342;
        bh=Wk9C72IkpOX8s0B2jzTyRrsUeM6PkAa/f+7PY+/7coc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ahUwyqsVKEvlEuLjpuDsgG0EkVEojtxmJo5xjQLF2vzHbhda370FDnTxzK/4lWxd6
         +iwLBbttYdNik3b7ypsrqMBh9DeGUCmWq4o3Z7MQ7jSZdbBmzPyXLLETAHeMgDufPz
         l7ZqEce6T4euy+oQ0QUrbzpb5u8WB9iWsVBAwbOweG12+5X9TONYSk19aT9UXV9+Mw
         aMZjZiBICdxVIgAY6Hfw6qtQTAaNOF7lg4tMG4WpKU44mSvFhlI2BSFshohJknXTy2
         XMO0ZVzXqFyK2pjqeAGoZkV2B+y2tejpHIyB0csT5WqRYPWKCbnyJeRez63BZjdl4G
         59oxVdvqvEIUw==
Message-ID: <e9fef086c63de6388d038918ff5a71099c654fc1.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nfsd: Avoid some useless tests
From:   Jeff Layton <jlayton@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 07:22:20 -0400
In-Reply-To: <567c75570345fee506fb56d0c13cf9369931100a.1662009844.git.christophe.jaillet@wanadoo.fr>
References: <14d802144c88da0eb9e201b3acbf4bde376b2473.1662009844.git.christophe.jaillet@wanadoo.fr>
         <567c75570345fee506fb56d0c13cf9369931100a.1662009844.git.christophe.jaillet@wanadoo.fr>
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

On Thu, 2022-09-01 at 07:27 +0200, Christophe JAILLET wrote:
> memdup_user() can't return NULL, so there is no point for checking for it=
.
>=20
> Simplify some tests accordingly.
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  fs/nfsd/nfs4recover.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 248ff9f4141c..2968cf604e3b 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -807,7 +807,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
>  			if (get_user(namelen, &ci->cc_name.cn_len))
>  				return -EFAULT;
>  			name.data =3D memdup_user(&ci->cc_name.cn_id, namelen);
> -			if (IS_ERR_OR_NULL(name.data))
> +			if (IS_ERR(name.data))
>  				return -EFAULT;
>  			name.len =3D namelen;
>  			get_user(princhashlen, &ci->cc_princhash.cp_len);
> @@ -815,7 +815,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
>  				princhash.data =3D memdup_user(
>  						&ci->cc_princhash.cp_data,
>  						princhashlen);
> -				if (IS_ERR_OR_NULL(princhash.data)) {
> +				if (IS_ERR(princhash.data)) {
>  					kfree(name.data);
>  					return -EFAULT;
>  				}
> @@ -829,7 +829,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
>  			if (get_user(namelen, &cnm->cn_len))
>  				return -EFAULT;
>  			name.data =3D memdup_user(&cnm->cn_id, namelen);
> -			if (IS_ERR_OR_NULL(name.data))
> +			if (IS_ERR(name.data))
>  				return -EFAULT;
>  			name.len =3D namelen;
>  		}

Reviewed-by: Jeff Layton <jlayton@kernel.org>
