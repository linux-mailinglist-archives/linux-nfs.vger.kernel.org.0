Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37B06C3105
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCUL41 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCUL4Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 07:56:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FA4EE7
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 04:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A62B81645
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 11:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E1BC433EF;
        Tue, 21 Mar 2023 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679399754;
        bh=UtZ+jJec1caN+c1nk8yxz5DDDVAXFmE5T0ySg+y1luY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cnG35ysQufAjAyc7RE8EHsy1QonlNHr63G4CrkkdlPOJn1VAG43rHwIbXf2nnXmvE
         QozamC8eMMVY5fPyd7QAPwY2EblLdGC+zadcXF7MlDr5PfvdUGT4wDYap8VpTceEcr
         WrPec+eua7h6XskF+1EmGncGl89ep9pG/OKyUhIvv0kkV3aIbZbvd/B7mNZJ8b7Cv4
         7kNCbDIsKDcaGZAt5vq/xCH8omK/K90m4lDp/RgHfrgXcOfPGwTdj1DAGkwrLuY1KK
         DHguSmQbWaZovZRCoH3Gj1qbzPF4rq3tL/r936jcHh7VV766fJnRE3bH9Ljsz6159g
         4Sp0YLflR/QTg==
Message-ID: <b1da1fdbb190f50409f9fcd18b466defdfc04353.camel@kernel.org>
Subject: Re: [PATCH v1 2/4] exports: Add an xprtsec= export option
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 21 Mar 2023 07:55:52 -0400
In-Reply-To: <167932293857.3437.10836642078898996996.stgit@manet.1015granger.net>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
         <167932293857.3437.10836642078898996996.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The overall goal is to enable administrators to require the use of
> transport layer security when clients access particular exports.
>=20
> This patch adds support to exportfs to parse and display a new
> xprtsec=3D export option. The setting is not yet passed to the kernel.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  support/include/nfs/export.h |    6 +++
>  support/include/nfslib.h     |   14 +++++++
>  support/nfs/exports.c        |   85 ++++++++++++++++++++++++++++++++++++=
++++++
>  utils/exportfs/exportfs.c    |    1=20
>  4 files changed, 106 insertions(+)
>=20
> diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
> index 0eca828ee3ad..b29c6fa4f554 100644
> --- a/support/include/nfs/export.h
> +++ b/support/include/nfs/export.h
> @@ -40,4 +40,10 @@
>  #define NFSEXP_OLD_SECINFO_FLAGS (NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>  					| NFSEXP_ALLSQUASH)
> =20
> +enum {
> +	NFSEXP_XPRTSEC_NONE =3D 1,
> +	NFSEXP_XPRTSEC_TLS =3D 2,
> +	NFSEXP_XPRTSEC_MTLS =3D 3,
> +};
> +

Can we put these into a uapi header somewhere and then just have
nfs-utils use those if they're defined?

>  #endif /* _NSF_EXPORT_H */
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index 6faba71bf0cd..9a188fb84790 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -62,6 +62,18 @@ struct sec_entry {
>  	int flags;
>  };
> =20
> +#define XPRTSECMODE_COUNT 4
> +
> +struct xprtsec_info {
> +	const char		*name;
> +	int			number;
> +};
> +
> +struct xprtsec_entry {
> +	const struct xprtsec_info *info;
> +	int			flags;
> +};
> +
>  /*
>   * Data related to a single exports entry as returned by getexportent.
>   * FIXME: export options should probably be parsed at a later time to
> @@ -83,6 +95,7 @@ struct exportent {
>  	char *          e_fslocdata;
>  	char *		e_uuid;
>  	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
> +	struct xprtsec_entry e_xprtsec[XPRTSECMODE_COUNT + 1];
>  	unsigned int	e_ttl;
>  	char *		e_realpath;
>  };
> @@ -99,6 +112,7 @@ struct rmtabent {
>  void			setexportent(char *fname, char *type);
>  struct exportent *	getexportent(int,int);
>  void 			secinfo_show(FILE *fp, struct exportent *ep);
> +void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
>  void			putexportent(struct exportent *xep);
>  void			endexportent(void);
>  struct exportent *	mkexportent(char *hname, char *path, char *opts);
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 7f12383981c3..da8ace3a65fd 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -99,6 +99,7 @@ static void init_exportent (struct exportent *ee, int f=
romkernel)
>  	ee->e_fslocmethod =3D FSLOC_NONE;
>  	ee->e_fslocdata =3D NULL;
>  	ee->e_secinfo[0].flav =3D NULL;
> +	ee->e_xprtsec[0].info =3D NULL;
>  	ee->e_nsquids =3D 0;
>  	ee->e_nsqgids =3D 0;
>  	ee->e_uuid =3D NULL;
> @@ -248,6 +249,17 @@ void secinfo_show(FILE *fp, struct exportent *ep)
>  	}
>  }
> =20
> +void xprtsecinfo_show(FILE *fp, struct exportent *ep)
> +{
> +	struct xprtsec_entry *p1, *p2;
> +
> +	for (p1 =3D ep->e_xprtsec; p1->info; p1 =3D p2) {
> +		fprintf(fp, ",xprtsec=3D%s", p1->info->name);
> +		for (p2 =3D p1 + 1; p2->info && (p1->flags =3D=3D p2->flags); p2++)
> +			fprintf(fp, ":%s", p2->info->name);
> +	}
> +}
> +
>  static void
>  fprintpath(FILE *fp, const char *path)
>  {
> @@ -344,6 +356,7 @@ putexportent(struct exportent *ep)
>  	}
>  	fprintf(fp, "anonuid=3D%d,anongid=3D%d", ep->e_anonuid, ep->e_anongid);
>  	secinfo_show(fp, ep);
> +	xprtsecinfo_show(fp, ep);
>  	fprintf(fp, ")\n");
>  }
> =20
> @@ -482,6 +495,75 @@ static unsigned int parse_flavors(char *str, struct =
exportent *ep)
>  	return out;
>  }
> =20
> +static const struct xprtsec_info xprtsec_name2info[] =3D {
> +	{ "none",	NFSEXP_XPRTSEC_NONE },
> +	{ "tls",	NFSEXP_XPRTSEC_TLS },
> +	{ "mtls",	NFSEXP_XPRTSEC_MTLS },
> +	{ NULL,		0 }
> +};
> +
> +static const struct xprtsec_info *find_xprtsec_info(const char *name)
> +{
> +	const struct xprtsec_info *info;
> +
> +	for (info =3D xprtsec_name2info; info->name; info++)
> +		if (strcmp(info->name, name) =3D=3D 0)
> +			return info;
> +	return NULL;
> +}
> +
> +/*
> + * Append the given xprtsec mode to the exportent's e_xprtsec array,
> + * or do nothing if it's already there. Returns the index of flavor in
> + * the resulting array in any case.
> + */
> +static int xprtsec_addmode(const struct xprtsec_info *info, struct expor=
tent *ep)
> +{
> +	struct xprtsec_entry *p;
> +
> +	for (p =3D ep->e_xprtsec; p->info; p++)
> +		if (p->info =3D=3D info || p->info->number =3D=3D info->number)
> +			return p - ep->e_xprtsec;
> +
> +	if (p - ep->e_xprtsec >=3D XPRTSECMODE_COUNT) {
> +		xlog(L_ERROR, "more than %d xprtsec modes on an export\n",
> +			XPRTSECMODE_COUNT);
> +		return -1;
> +	}
> +	p->info =3D info;
> +	p->flags =3D ep->e_flags;
> +	(p + 1)->info =3D NULL;
> +	return p - ep->e_xprtsec;
> +}
> +
> +/*
> + * @str is a colon seperated list of transport layer security modes.
> + * Their order is recorded in @ep, and a bitmap corresponding to the
> + * list is returned.
> + *
> + * A zero return indicates an error.
> + */
> +static unsigned int parse_xprtsec(char *str, struct exportent *ep)
> +{
> +	unsigned int out =3D 0;
> +	char *name;
> +
> +	while ((name =3D strsep(&str, ":"))) {
> +		const struct xprtsec_info *info =3D find_xprtsec_info(name);
> +		int bit;
> +
> +		if (!info) {
> +			xlog(L_ERROR, "unknown xprtsec mode %s\n", name);
> +			return 0;
> +		}
> +		bit =3D xprtsec_addmode(info, ep);
> +		if (bit < 0)
> +			return 0;
> +		out |=3D 1 << bit;
> +	}
> +	return out;
> +}
> +
>  /* Sets the bits in @mask for the appropriate security flavor flags. */
>  static void setflags(int mask, unsigned int active, struct exportent *ep=
)
>  {
> @@ -687,6 +769,9 @@ bad_option:
>  			active =3D parse_flavors(opt+4, ep);
>  			if (!active)
>  				goto bad_option;
> +		} else if (strncmp(opt, "xprtsec=3D", 8) =3D=3D 0) {
> +			if (!parse_xprtsec(opt + 8, ep))
> +				goto bad_option;
>  		} else {
>  			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>  					flname, flline, opt);
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 6d79a5b3480d..37b9e4b3612d 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -743,6 +743,7 @@ dump(int verbose, int export_format)
>  #endif
>  			}
>  			secinfo_show(stdout, ep);
> +			xprtsecinfo_show(stdout, ep);
>  			printf("%c\n", (c !=3D '(')? ')' : ' ');
>  		}
>  	}
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
