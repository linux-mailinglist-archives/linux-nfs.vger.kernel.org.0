Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839CC6C39A1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCUS7A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUS67 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 14:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57A49E1
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 11:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD2761DAD
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 18:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FFAC433D2;
        Tue, 21 Mar 2023 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679425135;
        bh=Xir1Mq4XDfYVbJp8fUjF+pmeNN+uaDa6Kzn4BsRzRtM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AaYBCw8eDEcLxIn6o+MmjAE8jK6XAKuFHyzNt25XI3xfKw8eoj2XrFD6z04P64oPh
         zc+Fqc2dYYjQ9VMGjEAdBkVuCoYoqKc2MO1t8E2xBORdG7p/MCeAHhWxXfgpb2koMq
         0s61u6c/21z+3S6SD6bXRV8GHvuWOxeZm/15TSIgHsLykMFqtpYSUg9ddO2DjvssXT
         ZiVUBDIIn3Q7eozUmvaD3lTAlir//joJmq7A9hVOPBkWwBxqTcHRv9l7O8zLAkxQRh
         SF3M5l96LtNRgMK4Tt/nudyox3V/CZJ4dO+WDWyhEUPNdOQh2VCK7t2pJnSBJe0z0N
         86h4wwB5rsD4A==
Message-ID: <01df993e636b200dbd7636946761208bb183d5c7.camel@kernel.org>
Subject: Re: [PATCH v1 2/4] exports: Add an xprtsec= export option
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 21 Mar 2023 14:58:53 -0400
In-Reply-To: <07F10068-A3E6-4C45-BB1E-F67FF4378155@oracle.com>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
         <167932293857.3437.10836642078898996996.stgit@manet.1015granger.net>
         <b1da1fdbb190f50409f9fcd18b466defdfc04353.camel@kernel.org>
         <07F10068-A3E6-4C45-BB1E-F67FF4378155@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-03-21 at 18:08 +0000, Chuck Lever III wrote:
>=20
> > On Mar 21, 2023, at 7:55 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > The overall goal is to enable administrators to require the use of
> > > transport layer security when clients access particular exports.
> > >=20
> > > This patch adds support to exportfs to parse and display a new
> > > xprtsec=3D export option. The setting is not yet passed to the kernel=
.
> > >=20
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > support/include/nfs/export.h |    6 +++
> > > support/include/nfslib.h     |   14 +++++++
> > > support/nfs/exports.c        |   85 +++++++++++++++++++++++++++++++++=
+++++++++
> > > utils/exportfs/exportfs.c    |    1=20
> > > 4 files changed, 106 insertions(+)
> > >=20
> > > diff --git a/support/include/nfs/export.h b/support/include/nfs/expor=
t.h
> > > index 0eca828ee3ad..b29c6fa4f554 100644
> > > --- a/support/include/nfs/export.h
> > > +++ b/support/include/nfs/export.h
> > > @@ -40,4 +40,10 @@
> > > #define NFSEXP_OLD_SECINFO_FLAGS (NFSEXP_READONLY | NFSEXP_ROOTSQUASH=
 \
> > > 					| NFSEXP_ALLSQUASH)
> > >=20
> > > +enum {
> > > +	NFSEXP_XPRTSEC_NONE =3D 1,
> > > +	NFSEXP_XPRTSEC_TLS =3D 2,
> > > +	NFSEXP_XPRTSEC_MTLS =3D 3,
> > > +};
> > > +
> >=20
> > Can we put these into a uapi header somewhere and then just have
> > nfs-utils use those if they're defined?
>=20
> I moved these to include/uapi/linux/nfsd/export.h in the
> kernel patches, and adjust the nfs-utils patches to use the
> same numeric values in exportfs as the kernel.
>
> But it's not clear how a uAPI header would become visible
> during, say, an RPM build of nfs-utils. Does anyone know
> how that works? The kernel docs I've read suggest uAPI is
> for user space tools that actually live in the kernel source
> tree.
>=20

Unfortunately, you need to build on a box that has kernel headers from
an updated kernel.

The usual way to deal with this is to have a copy in the userland
sources but only define them if one of the relevant constants isn't
already defined.

So you'll probably want to keep something like this in the userland
tree:

#ifndef NFSEXP_XPRTSEC_NONE
# define NFSEXP_XPRTSEC_NONE 1
# define NFSEXP_XPRTSEC_TLS  2
# define NFSEXP_XPRTSEC_MTLS 3
#endif

There may be some way to do that and keep it as an enum too. I'm not
sure.

> I think the cases where only user space or only the kernel
> support xprtsec should work OK: the kernel has a default
> transport layer security policy of "all ok" and old kernels
> ignore export options from user space they don't recognize.
>=20

Great!

> > > #endif /* _NSF_EXPORT_H */
> > > diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> > > index 6faba71bf0cd..9a188fb84790 100644
> > > --- a/support/include/nfslib.h
> > > +++ b/support/include/nfslib.h
> > > @@ -62,6 +62,18 @@ struct sec_entry {
> > > 	int flags;
> > > };
> > >=20
> > > +#define XPRTSECMODE_COUNT 4
> > > +
> > > +struct xprtsec_info {
> > > +	const char		*name;
> > > +	int			number;
> > > +};
> > > +
> > > +struct xprtsec_entry {
> > > +	const struct xprtsec_info *info;
> > > +	int			flags;
> > > +};
> > > +
> > > /*
> > >  * Data related to a single exports entry as returned by getexportent=
.
> > >  * FIXME: export options should probably be parsed at a later time to
> > > @@ -83,6 +95,7 @@ struct exportent {
> > > 	char *          e_fslocdata;
> > > 	char *		e_uuid;
> > > 	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
> > > +	struct xprtsec_entry e_xprtsec[XPRTSECMODE_COUNT + 1];
> > > 	unsigned int	e_ttl;
> > > 	char *		e_realpath;
> > > };
> > > @@ -99,6 +112,7 @@ struct rmtabent {
> > > void			setexportent(char *fname, char *type);
> > > struct exportent *	getexportent(int,int);
> > > void 			secinfo_show(FILE *fp, struct exportent *ep);
> > > +void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
> > > void			putexportent(struct exportent *xep);
> > > void			endexportent(void);
> > > struct exportent *	mkexportent(char *hname, char *path, char *opts);
> > > diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> > > index 7f12383981c3..da8ace3a65fd 100644
> > > --- a/support/nfs/exports.c
> > > +++ b/support/nfs/exports.c
> > > @@ -99,6 +99,7 @@ static void init_exportent (struct exportent *ee, i=
nt fromkernel)
> > > 	ee->e_fslocmethod =3D FSLOC_NONE;
> > > 	ee->e_fslocdata =3D NULL;
> > > 	ee->e_secinfo[0].flav =3D NULL;
> > > +	ee->e_xprtsec[0].info =3D NULL;
> > > 	ee->e_nsquids =3D 0;
> > > 	ee->e_nsqgids =3D 0;
> > > 	ee->e_uuid =3D NULL;
> > > @@ -248,6 +249,17 @@ void secinfo_show(FILE *fp, struct exportent *ep=
)
> > > 	}
> > > }
> > >=20
> > > +void xprtsecinfo_show(FILE *fp, struct exportent *ep)
> > > +{
> > > +	struct xprtsec_entry *p1, *p2;
> > > +
> > > +	for (p1 =3D ep->e_xprtsec; p1->info; p1 =3D p2) {
> > > +		fprintf(fp, ",xprtsec=3D%s", p1->info->name);
> > > +		for (p2 =3D p1 + 1; p2->info && (p1->flags =3D=3D p2->flags); p2++=
)
> > > +			fprintf(fp, ":%s", p2->info->name);
> > > +	}
> > > +}
> > > +
> > > static void
> > > fprintpath(FILE *fp, const char *path)
> > > {
> > > @@ -344,6 +356,7 @@ putexportent(struct exportent *ep)
> > > 	}
> > > 	fprintf(fp, "anonuid=3D%d,anongid=3D%d", ep->e_anonuid, ep->e_anongi=
d);
> > > 	secinfo_show(fp, ep);
> > > +	xprtsecinfo_show(fp, ep);
> > > 	fprintf(fp, ")\n");
> > > }
> > >=20
> > > @@ -482,6 +495,75 @@ static unsigned int parse_flavors(char *str, str=
uct exportent *ep)
> > > 	return out;
> > > }
> > >=20
> > > +static const struct xprtsec_info xprtsec_name2info[] =3D {
> > > +	{ "none",	NFSEXP_XPRTSEC_NONE },
> > > +	{ "tls",	NFSEXP_XPRTSEC_TLS },
> > > +	{ "mtls",	NFSEXP_XPRTSEC_MTLS },
> > > +	{ NULL,		0 }
> > > +};
> > > +
> > > +static const struct xprtsec_info *find_xprtsec_info(const char *name=
)
> > > +{
> > > +	const struct xprtsec_info *info;
> > > +
> > > +	for (info =3D xprtsec_name2info; info->name; info++)
> > > +		if (strcmp(info->name, name) =3D=3D 0)
> > > +			return info;
> > > +	return NULL;
> > > +}
> > > +
> > > +/*
> > > + * Append the given xprtsec mode to the exportent's e_xprtsec array,
> > > + * or do nothing if it's already there. Returns the index of flavor =
in
> > > + * the resulting array in any case.
> > > + */
> > > +static int xprtsec_addmode(const struct xprtsec_info *info, struct e=
xportent *ep)
> > > +{
> > > +	struct xprtsec_entry *p;
> > > +
> > > +	for (p =3D ep->e_xprtsec; p->info; p++)
> > > +		if (p->info =3D=3D info || p->info->number =3D=3D info->number)
> > > +			return p - ep->e_xprtsec;
> > > +
> > > +	if (p - ep->e_xprtsec >=3D XPRTSECMODE_COUNT) {
> > > +		xlog(L_ERROR, "more than %d xprtsec modes on an export\n",
> > > +			XPRTSECMODE_COUNT);
> > > +		return -1;
> > > +	}
> > > +	p->info =3D info;
> > > +	p->flags =3D ep->e_flags;
> > > +	(p + 1)->info =3D NULL;
> > > +	return p - ep->e_xprtsec;
> > > +}
> > > +
> > > +/*
> > > + * @str is a colon seperated list of transport layer security modes.
> > > + * Their order is recorded in @ep, and a bitmap corresponding to the
> > > + * list is returned.
> > > + *
> > > + * A zero return indicates an error.
> > > + */
> > > +static unsigned int parse_xprtsec(char *str, struct exportent *ep)
> > > +{
> > > +	unsigned int out =3D 0;
> > > +	char *name;
> > > +
> > > +	while ((name =3D strsep(&str, ":"))) {
> > > +		const struct xprtsec_info *info =3D find_xprtsec_info(name);
> > > +		int bit;
> > > +
> > > +		if (!info) {
> > > +			xlog(L_ERROR, "unknown xprtsec mode %s\n", name);
> > > +			return 0;
> > > +		}
> > > +		bit =3D xprtsec_addmode(info, ep);
> > > +		if (bit < 0)
> > > +			return 0;
> > > +		out |=3D 1 << bit;
> > > +	}
> > > +	return out;
> > > +}
> > > +
> > > /* Sets the bits in @mask for the appropriate security flavor flags. =
*/
> > > static void setflags(int mask, unsigned int active, struct exportent =
*ep)
> > > {
> > > @@ -687,6 +769,9 @@ bad_option:
> > > 			active =3D parse_flavors(opt+4, ep);
> > > 			if (!active)
> > > 				goto bad_option;
> > > +		} else if (strncmp(opt, "xprtsec=3D", 8) =3D=3D 0) {
> > > +			if (!parse_xprtsec(opt + 8, ep))
> > > +				goto bad_option;
> > > 		} else {
> > > 			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
> > > 					flname, flline, opt);
> > > diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> > > index 6d79a5b3480d..37b9e4b3612d 100644
> > > --- a/utils/exportfs/exportfs.c
> > > +++ b/utils/exportfs/exportfs.c
> > > @@ -743,6 +743,7 @@ dump(int verbose, int export_format)
> > > #endif
> > > 			}
> > > 			secinfo_show(stdout, ep);
> > > +			xprtsecinfo_show(stdout, ep);
> > > 			printf("%c\n", (c !=3D '(')? ')' : ' ');
> > > 		}
> > > 	}
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
