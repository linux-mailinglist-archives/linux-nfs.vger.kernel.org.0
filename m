Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D06C30D8
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 12:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCULup (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjCULuj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 07:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8BA1B2CE
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 04:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB75061B3B
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 11:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADB0C4339B;
        Tue, 21 Mar 2023 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679399432;
        bh=cJevmNICYQ/6oBkKFKxDgWp9/h4rZ2QaVJEdbr7S4xM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TOxeDmgDjVRfiLR5sv/1FE5DTZ0jWqprjX8CKBcZb2HNFK+P3IEM4c+hUqb3feY8f
         NxeGHktnL7EXSTPUGoaN2p9+Uzcgj6ksl/bd6gdUbIuA2GS92CY1aCt/emKSR9UVuh
         Fn0P75yyW41WqW5EFgg9S+o1nIuGjQUipODaCcHr8+4hiQ0kC8SCsorcldzsX7CejQ
         +rB1/dvP2XP3aC1Cc48shIF0XNsUgdzQUS5aTMtXmlxZoWL0Gz3uF5RUcFZGP8bH4s
         RwydMTSBtOaZl1Nw/2nsmriguhp5e0MGKeoB19d/DG8xlGZP81neKkI2aDjtzlu1rQ
         vJssceqz8j3aw==
Message-ID: <3dec5ea0dd4efbf96767333d3de90457b9fd3ecd.camel@kernel.org>
Subject: Re: [PATCH RFC 5/5] NFSD: Handle new xprtsec= export option
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Tue, 21 Mar 2023 07:50:30 -0400
In-Reply-To: <167932229302.3131.3108041458819604050.stgit@manet.1015granger.net>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
         <167932229302.3131.3108041458819604050.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-03-20 at 10:24 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Enable administrators to require clients to use transport layer
> security when accessing particular exports.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/export.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++=
++---
>  fs/nfsd/export.h |   11 +++++++++++
>  2 files changed, 61 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 668c7527b17e..171ebc21bf07 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -439,7 +439,6 @@ static int check_export(struct path *path, int *flags=
, unsigned char *uuid)
>  		return -EINVAL;
>  	}
>  	return 0;
> -
>  }
> =20
>  #ifdef CONFIG_NFSD_V4
> @@ -546,6 +545,31 @@ static inline int
>  secinfo_parse(char **mesg, char *buf, struct svc_export *exp) { return 0=
; }
>  #endif
> =20
> +static int xprtsec_parse(char **mesg, char *buf, struct svc_export *exp)
> +{
> +	unsigned int i, mode, listsize;
> +	int err;
> +
> +	err =3D get_uint(mesg, &listsize);
> +	if (err)
> +		return err;
> +	if (listsize > 3)
> +		return -EINVAL;

Might want to make a note that the limit of 3 here is arbitrary, and
that it might need to be lifted in the future (if/when we grow other
xprtsec options).

> +
> +	exp->ex_xprtsec_modes =3D 0;
> +	for (i =3D 0; i < listsize; i++) {
> +		err =3D get_uint(mesg, &mode);
> +		if (err)
> +			return err;
> +		mode--;
> +		if (mode > 2)
> +			return -EINVAL;
> +		/* Ad hoc */
> +		exp->ex_xprtsec_modes |=3D 1 << mode;
> +	}
> +	return 0;
> +}
> +
>  static inline int
>  nfsd_uuid_parse(char **mesg, char *buf, unsigned char **puuid)
>  {
> @@ -608,6 +632,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  	exp.ex_client =3D dom;
>  	exp.cd =3D cd;
>  	exp.ex_devid_map =3D NULL;
> +	exp.ex_xprtsec_modes =3D NFSEXP_XPRTSEC_ALL;
> =20
>  	/* expiry */
>  	err =3D -EINVAL;
> @@ -650,6 +675,8 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  				err =3D nfsd_uuid_parse(&mesg, buf, &exp.ex_uuid);
>  			else if (strcmp(buf, "secinfo") =3D=3D 0)
>  				err =3D secinfo_parse(&mesg, buf, &exp);
> +			else if (strcmp(buf, "xprtsec") =3D=3D 0)
> +				err =3D xprtsec_parse(&mesg, buf, &exp);
>  			else
>  				/* quietly ignore unknown words and anything
>  				 * following. Newer user-space can try to set
> @@ -663,6 +690,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
>  		err =3D check_export(&exp.ex_path, &exp.ex_flags, exp.ex_uuid);
>  		if (err)
>  			goto out4;
> +
>  		/*
>  		 * No point caching this if it would immediately expire.
>  		 * Also, this protects exportfs's dummy export from the
> @@ -824,6 +852,7 @@ static void export_update(struct cache_head *cnew, st=
ruct cache_head *citem)
>  	for (i =3D 0; i < MAX_SECINFO_LIST; i++) {
>  		new->ex_flavors[i] =3D item->ex_flavors[i];
>  	}
> +	new->ex_xprtsec_modes =3D item->ex_xprtsec_modes;
>  }
> =20
>  static struct cache_head *svc_export_alloc(void)
> @@ -1035,9 +1064,26 @@ static struct svc_export *exp_find(struct cache_de=
tail *cd,
> =20
>  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
>  {
> -	struct exp_flavor_info *f;
> -	struct exp_flavor_info *end =3D exp->ex_flavors + exp->ex_nflavors;
> +	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nflavors;
> +	struct svc_xprt *xprt =3D rqstp->rq_xprt;
> +
> +	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
> +		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
> +			goto ok;
> +	}
> +	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
> +		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
> +		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> +			goto ok;
> +	}
> +	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
> +		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
> +		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> +			goto ok;
> +	}
> +	goto denied;
> =20
> +ok:
>  	/* legacy gss-only clients are always OK: */
>  	if (exp->ex_client =3D=3D rqstp->rq_gssclient)
>  		return 0;
> @@ -1062,6 +1108,7 @@ __be32 check_nfsd_access(struct svc_export *exp, st=
ruct svc_rqst *rqstp)
>  	if (nfsd4_spo_must_allow(rqstp))
>  		return 0;
> =20
> +denied:
>  	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
>  }
> =20
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index d03f7f6a8642..61e1e8383c3d 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -77,8 +77,19 @@ struct svc_export {
>  	struct cache_detail	*cd;
>  	struct rcu_head		ex_rcu;
>  	struct export_stats	ex_stats;
> +	unsigned long		ex_xprtsec_modes;
>  };
> =20
> +enum {
> +	NFSEXP_XPRTSEC_NONE	=3D 0x01,
> +	NFSEXP_XPRTSEC_TLS	=3D 0x02,
> +	NFSEXP_XPRTSEC_MTLS	=3D 0x04,
> +};
> +
> +#define NFSEXP_XPRTSEC_ALL	(NFSEXP_XPRTSEC_NONE | \
> +				 NFSEXP_XPRTSEC_TLS | \
> +				 NFSEXP_XPRTSEC_MTLS)
> +
>  /* an "export key" (expkey) maps a filehandlefragement to an
>   * svc_export for a given client.  There can be several per export,
>   * for the different fsid types.
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
