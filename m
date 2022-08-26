Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC535A25FE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbiHZKlY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiHZKlX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 06:41:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEC6D633F;
        Fri, 26 Aug 2022 03:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D3AB830A9;
        Fri, 26 Aug 2022 10:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E471C433D6;
        Fri, 26 Aug 2022 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661510479;
        bh=Npi1VdLL7sUhq6vHYOIAHI/fwJopQoBBqmwR0+Nlh1U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G5gagI8X4Rbi18gQu4NrPLdmovdVIzWQazjCmEr68X8wiaJlr1JLB3Kc19z45jJlW
         rb1jCCRc34jETenoX//2+ir1nLif2zq3wzfU3J9MH5wh8l3Jq/oLTjY58rBVwGVJ91
         jIJdmlJShYPPrEOTVC7IuSU80GAkRw05axYYe4PWpozPeRM882sC09vdAJX0Fnosfq
         wSPYteHJcrJD+u7ncfuvstCFrYukLWPcrBv6V3imWI675Dy7vxtlTPfAvPnSNEtFrj
         sT92+8Sf3u/s89nM6HzX/eaMjcOzxwqHumE9yq7kLpQEfVWp2SaTzIl7s/FWU2emrN
         jEwt3G9ZZ/UVw==
Message-ID: <ec217c92a46b331824882928de3b924021e66d57.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Fix a memory leak in an error handling path
From:   Jeff Layton <jlayton@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nfs@vger.kernel.org
Date:   Fri, 26 Aug 2022 06:41:16 -0400
In-Reply-To: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
References: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
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

On Fri, 2022-08-26 at 12:24 +0200, Christophe JAILLET wrote:
> If this memdup_user() call fails, the memory allocated in a previous call
> a few lines above should be freed. Otherwise it leaks.
>=20
> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Speculative, untested.
> ---
>  fs/nfsd/nfs4recover.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index b29d27eaa8a6..248ff9f4141c 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -815,8 +815,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_=
v2 __user *cmsg,
>  				princhash.data =3D memdup_user(
>  						&ci->cc_princhash.cp_data,
>  						princhashlen);
> -				if (IS_ERR_OR_NULL(princhash.data))
> +				if (IS_ERR_OR_NULL(princhash.data)) {
> +					kfree(name.data);
>  					return -EFAULT;
> +				}
>  				princhash.len =3D princhashlen;
>  			} else
>  				princhash.len =3D 0;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
