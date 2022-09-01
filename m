Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9955A959E
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 13:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiIALVn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 07:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiIALVd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 07:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A218A12649E;
        Thu,  1 Sep 2022 04:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C58861DBA;
        Thu,  1 Sep 2022 11:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5674C433D6;
        Thu,  1 Sep 2022 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662031288;
        bh=Y1ObXWZoAPO9a3cVwM+9DOIhRMb2NN2/YlncxX1cYIA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g8HIcvDfJ7+Kvvz7+2WkqooremfBKbH+fzUyNPoCCJ2aYsc9DWatob971V4yk03CO
         CF6JpCsGQDyY0QDjoCeC8LtYUjVtluTRQnHT+In0odOoTv1u/fhLc26r3d+JtsKvMH
         5PuERM7bTHJjhKOVQZCMjMVa45wyctq94eCQtHyhw46Akh48FlQ6jSlJYP6T8kKM3x
         RugJdDoqIJ3L6xxhrT6ZYLyWIG8ao+H+lluQYn4OM88a8h3sfyWsoFA+/06aPUwOym
         RBlIYrKDULw2WTZ7K3lmhXwcE94QUucjPYFUeWQRUAZXqT0Kxu8vaaotXrYDElSDNc
         VVGWuzmYv6mxw==
Message-ID: <5c5d87f8329e44275bda36657be4de2390f065d4.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] nfsd: Fix a memory leak in an error handling path
From:   Jeff Layton <jlayton@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 07:21:26 -0400
In-Reply-To: <14d802144c88da0eb9e201b3acbf4bde376b2473.1662009844.git.christophe.jaillet@wanadoo.fr>
References: <14d802144c88da0eb9e201b3acbf4bde376b2473.1662009844.git.christophe.jaillet@wanadoo.fr>
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
> If this memdup_user() call fails, the memory allocated in a previous call
> a few lines above should be freed. Otherwise it leaks.
>=20
> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
