Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDDF738F98
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjFUTEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 15:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjFUTEn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 15:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443211FC8;
        Wed, 21 Jun 2023 12:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC6ED616A6;
        Wed, 21 Jun 2023 19:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C959C433C8;
        Wed, 21 Jun 2023 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687374259;
        bh=XX+xnkHYFw12qk3N6BO1yCAkmNYCz3srtgwHCLCbmwk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eoFhaja6StbjSzE51WfycuLc9VD3vd5yWqvsqfE9HX6PWJT1yzcX3K7pxsoKkV2jK
         CSMDtiixzcKkB/W+RI3qooJz0Mj5OZPwcoQKeJRqbmzzkNB0TJlJBnQpM9cYVT/8mB
         YCK866m0pKzbc6edkIvDABbN7i/mScrCT3o1PlDLHxTjCfvwqSOjcYesOzS0rv+ZFx
         3dC6I3p4hMKaiY4E+sM3nzVYWT4lAlB372WdBdO9cjm3QvHKW/VfpC/gzIp9EeZOd4
         uALZBH/U2IqGeiS0mX0ePl+5ix2qw9puLKYxvEu1rYC222AzD0jij5Qi0DExuivjU6
         75+N/n6hRqn8Q==
Message-ID: <03b904b3c5981676dce8a5ad9a3e3b8d9ae80ded.camel@kernel.org>
Subject: Re: [PATCH][next] nfsd: remove redundant assignments to variable len
From:   Jeff Layton <jlayton@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 21 Jun 2023 15:04:17 -0400
In-Reply-To: <20230621145205.2682584-1-colin.i.king@gmail.com>
References: <20230621145205.2682584-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-06-21 at 15:52 +0100, Colin Ian King wrote:
> There are a few assignments to variable len where the value is not
> being read and so the assignments are redundant and can be removed.
> In one case, the variable len can be removed completely. Cleans up
> 4 clang scan warnings of the form:
>=20
> fs/nfsd/export.c:100:7: warning: Although the value stored to 'len'
> is used in the enclosing expression, the value is never actually
> read from 'len' [deadcode.DeadStores]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/nfsd/export.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index ae85257b4238..11a0eaa2f914 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -97,7 +97,7 @@ static int expkey_parse(struct cache_detail *cd, char *=
mesg, int mlen)
>  		goto out;
> =20
>  	err =3D -EINVAL;
> -	if ((len=3Dqword_get(&mesg, buf, PAGE_SIZE)) <=3D 0)
> +	if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
>  		goto out;
> =20
>  	err =3D -ENOENT;
> @@ -107,7 +107,7 @@ static int expkey_parse(struct cache_detail *cd, char=
 *mesg, int mlen)
>  	dprintk("found domain %s\n", buf);
> =20
>  	err =3D -EINVAL;
> -	if ((len=3Dqword_get(&mesg, buf, PAGE_SIZE)) <=3D 0)
> +	if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
>  		goto out;
>  	fsidtype =3D simple_strtoul(buf, &ep, 10);
>  	if (*ep)
> @@ -593,7 +593,6 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  {
>  	/* client path expiry [flags anonuid anongid fsid] */
>  	char *buf;
> -	int len;
>  	int err;
>  	struct auth_domain *dom =3D NULL;
>  	struct svc_export exp =3D {}, *expp;
> @@ -609,8 +608,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
> =20
>  	/* client */
>  	err =3D -EINVAL;
> -	len =3D qword_get(&mesg, buf, PAGE_SIZE);
> -	if (len <=3D 0)
> +	if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
>  		goto out;
> =20
>  	err =3D -ENOENT;
> @@ -620,7 +618,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
> =20
>  	/* path */
>  	err =3D -EINVAL;
> -	if ((len =3D qword_get(&mesg, buf, PAGE_SIZE)) <=3D 0)
> +	if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
>  		goto out1;
> =20
>  	err =3D kern_path(buf, 0, &exp.ex_path);
> @@ -665,7 +663,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  			goto out3;
>  		exp.ex_fsid =3D an_int;
> =20
> -		while ((len =3D qword_get(&mesg, buf, PAGE_SIZE)) > 0) {
> +		while (qword_get(&mesg, buf, PAGE_SIZE) > 0) {
>  			if (strcmp(buf, "fsloc") =3D=3D 0)
>  				err =3D fsloc_parse(&mesg, buf, &exp.ex_fslocs);
>  			else if (strcmp(buf, "uuid") =3D=3D 0)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
