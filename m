Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1A5A95A9
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 13:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiIAL0F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 07:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiIAL0F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 07:26:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB12132ED9;
        Thu,  1 Sep 2022 04:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F971B825C9;
        Thu,  1 Sep 2022 11:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B36C433D6;
        Thu,  1 Sep 2022 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662031561;
        bh=ypVl01yuB6aIuwds2khZ+OY7xKgsZJREnfbYXivAWs0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q7iX8ECEHji51gHr9FzGbt3GNN3d9JkTPGc0T3530VejKeFS1LQZ+E9z7sS6EDrHh
         4A3uPZKIFmMBjsGXls3a+m52krTl3AOeWmgkpr2gL9QmnLd0xtFQ8YCyvIdlgUb8zm
         c9CzmUk3Ost/zzdjghaihXaynbYqSsYeddKsNBrPCdWVc5abIyTbXngu0skwNKLF3m
         Y61laEDyDQqcabLc4bEsSUMrndOx7G76YDyEjnNuML4W6aLCjdZRjRUJeXLocMkZTg
         KkUWLiYAoGv7i5Y9ENhmuTPf3Rex9RxOoWaM3UBYIK2b7KZkkKlvGyCyjtCtSSW3pP
         6U3KKeZHDGYMg==
Message-ID: <ec2c210d9d2353b31ea7121f80f5231e402926ed.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] nfsd: Propagate some error code returned by
 memdup_user()
From:   Jeff Layton <jlayton@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 07:25:59 -0400
In-Reply-To: <d8af52e13f53dcb14d72486d6ac92607d5f42716.1662009844.git.christophe.jaillet@wanadoo.fr>
References: <14d802144c88da0eb9e201b3acbf4bde376b2473.1662009844.git.christophe.jaillet@wanadoo.fr>
         <d8af52e13f53dcb14d72486d6ac92607d5f42716.1662009844.git.christophe.jaillet@wanadoo.fr>
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
> Propagate the error code returned by memdup_user() instead of a hard code=
d
> -EFAULT.
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative. The whole call chains have not been checked to
> see if there was no path explicitly expecting a -EFAULT.
> ---
>  fs/nfsd/nfs4recover.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 2968cf604e3b..78b8cd9651d5 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -808,7 +808,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
>  				return -EFAULT;
>  			name.data =3D memdup_user(&ci->cc_name.cn_id, namelen);
>  			if (IS_ERR(name.data))
> -				return -EFAULT;
> +				return PTR_ERR(name.data);
>  			name.len =3D namelen;
>  			get_user(princhashlen, &ci->cc_princhash.cp_len);
>  			if (princhashlen > 0) {
> @@ -817,7 +817,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
>  						princhashlen);
>  				if (IS_ERR(princhash.data)) {
>  					kfree(name.data);
> -					return -EFAULT;
> +					return PTR_ERR(princhash.data);
>  				}
>  				princhash.len =3D princhashlen;
>  			} else
> @@ -830,7 +830,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
>  				return -EFAULT;
>  			name.data =3D memdup_user(&cnm->cn_id, namelen);
>  			if (IS_ERR(name.data))
> -				return -EFAULT;
> +				return PTR_ERR(name.data);
>  			name.len =3D namelen;
>  		}
>  		if (name.len > 5 && memcmp(name.data, "hash:", 5) =3D=3D 0) {

I *think* this error gets propagated to userland on a write to
rpc_pipefs, and the callers already handle a variety of errors. This
looks reasonable to me.=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
