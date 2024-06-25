Return-Path: <linux-nfs+bounces-4310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800049174A8
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 01:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E1428559D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 23:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E217E8F4;
	Tue, 25 Jun 2024 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B4xS10Om";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q3R5EwNV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B4xS10Om";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q3R5EwNV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA217D88C
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357820; cv=none; b=XIiNiG52bGw9kGiJkfoNmaVOxncFXEDWnRAgvBXtLs3nsH3/gSnSdcGa6ioUZ6RE4wPiIqJfmw2gePcmPMEKHTnQvuzZ8kGaitBxbw4FjrmC4pkTCjRtjzTDe2+GLPWVh9uyfYxZ3+iMzOuiZpqUEWHf4CYM+OaxFr0t1KFVrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357820; c=relaxed/simple;
	bh=/N97H5StUbdIkwq7IowtjWC8xAnK9PdW/q8ytR8Fcms=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YxZaKT30oA/jwdUnLYyAb2EDwFzodBcw6wyvBPDtmuUBRIjdQq3swf3p1rttdJzSgHJBnyLQRtVO7B2edp27jKKWmXgWiRq5Dj7wNe4f9YfGcykS2e8mPa/csl+caJLRN2k0bHTeva9egUKcg/Y3CefZBkzWcfQrPdLhCUXHKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B4xS10Om; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q3R5EwNV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B4xS10Om; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q3R5EwNV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0C751F8B3;
	Tue, 25 Jun 2024 23:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qr2lW9zyXpopJhswIfOC/LLsli6Bhb9oojmkVpaTvWU=;
	b=B4xS10Om00yKKPfFGP3HpaUJn2kP+2aZaCM6p48FRE1UKYRcAydscaUVp1C75A+tM6wa4K
	S4hIsc39EGKE60YSPKBAxSnszisnOrGRdnJyF6H1/n40LP93O4ZOOiADfZ+TL8SL5m6q8Z
	UD5ypZ7csqplR6eiCSdmpJqhlHFvoZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qr2lW9zyXpopJhswIfOC/LLsli6Bhb9oojmkVpaTvWU=;
	b=Q3R5EwNVoVk567Aw5amYaRYE8ZYWAlw486fdQQTR6ztp5Tdkn3WB6OQqxD4VTb+Y3xwPTr
	JXW96s/TZSGdMRBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qr2lW9zyXpopJhswIfOC/LLsli6Bhb9oojmkVpaTvWU=;
	b=B4xS10Om00yKKPfFGP3HpaUJn2kP+2aZaCM6p48FRE1UKYRcAydscaUVp1C75A+tM6wa4K
	S4hIsc39EGKE60YSPKBAxSnszisnOrGRdnJyF6H1/n40LP93O4ZOOiADfZ+TL8SL5m6q8Z
	UD5ypZ7csqplR6eiCSdmpJqhlHFvoZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qr2lW9zyXpopJhswIfOC/LLsli6Bhb9oojmkVpaTvWU=;
	b=Q3R5EwNVoVk567Aw5amYaRYE8ZYWAlw486fdQQTR6ztp5Tdkn3WB6OQqxD4VTb+Y3xwPTr
	JXW96s/TZSGdMRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AD221384C;
	Tue, 25 Jun 2024 23:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H8bjK3VRe2ZfSAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Jun 2024 23:23:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject:
 Re: [PATCH v7 14/20] nfsd: implement server support for NFS_LOCALIO_PROGRAM
In-reply-to: <20240624162741.68216-15-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>,
 <20240624162741.68216-15-snitzer@kernel.org>
Date: Wed, 26 Jun 2024 09:23:30 +1000
Message-id: <171935781035.14261.11537219125500827548@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Tue, 25 Jun 2024, Mike Snitzer wrote:
> LOCALIOPROC_GETUUID encodes the server's uuid_t in terms of the fixed
> UUID_SIZE (16). The fixed size opaque encode and decode XDR methods
> are used instead of the less efficient variable sized methods.
>=20
> Aside from a bit of code in nfssvc.c, all the knowledge of the LOCALIO
> RPC protocol is in fs/nfsd/localio.c which implements just a single
> version (1) that is used independently of what NFS version is used.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> [neilb: factored out and simplified single localio protocol]
> Co-developed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/localio.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfssvc.c  | 29 ++++++++++++++++++-
>  2 files changed, 102 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index f6df66b1d523..aaa5293eb352 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -11,12 +11,15 @@
>  #include <linux/sunrpc/svcauth_gss.h>
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/nfs.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_xdr.h>
>  #include <linux/string.h>
> =20
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "netns.h"
>  #include "filecache.h"
> +#include "cache.h"
> =20
>  #define NFSDDBG_FACILITY		NFSDDBG_FH
> =20
> @@ -249,3 +252,74 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> =20
>  /* Compile time type checking, not used by anything */
>  static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck =3D =
nfsd_open_local_fh;
> +
> +/*
> + * GETUUID XDR encode functions
> + */
> +
> +static __be32 nfsd_proc_null(struct svc_rqst *rqstp)
> +{
> +	return rpc_success;
> +}
> +
> +struct nfsd_getuuidres {
> +	uuid_t			uuid;
> +};
> +
> +static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
> +{
> +	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfsd_getuuidres *resp =3D rqstp->rq_resp;
> +
> +	uuid_copy(&resp->uuid, &nn->nfsd_uuid.uuid);
> +
> +	return rpc_success;
> +}
> +
> +static bool nfslocalio_encode_getuuidres(struct svc_rqst *rqstp,
> +					 struct xdr_stream *xdr)
> +{
> +	struct nfsd_getuuidres *resp =3D rqstp->rq_resp;
> +	u8 uuid[UUID_SIZE];
> +
> +	export_uuid(uuid, &resp->uuid);
> +	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
> +	dprintk("%s: uuid=3D%pU\n", __func__, uuid);
> +
> +	return true;
> +}
> +
> +static const struct svc_procedure nfsd_localio_procedures[2] =3D {

Including a '2' here is unnecessary.

> +	[LOCALIOPROC_NULL] =3D {
> +		.pc_func =3D nfsd_proc_null,
> +		.pc_decode =3D nfssvc_decode_voidarg,
> +		.pc_encode =3D nfssvc_encode_voidres,
> +		.pc_argsize =3D sizeof(struct nfsd_voidargs),
> +		.pc_ressize =3D sizeof(struct nfsd_voidres),
> +		.pc_cachetype =3D RC_NOCACHE,
> +		.pc_xdrressize =3D 0,
> +		.pc_name =3D "NULL",
> +	},
> +	[LOCALIOPROC_GETUUID] =3D {
> +		.pc_func =3D nfsd_proc_getuuid,
> +		.pc_decode =3D nfssvc_decode_voidarg,
> +		.pc_encode =3D nfslocalio_encode_getuuidres,
> +		.pc_argsize =3D sizeof(struct nfsd_voidargs),
> +		.pc_ressize =3D sizeof(struct nfsd_getuuidres),
> +		.pc_cachetype =3D RC_NOCACHE,
> +		.pc_xdrressize =3D XDR_QUADLEN(UUID_SIZE),
> +		.pc_name =3D "GETUUID",
> +	},
> +};
> +
> +static DEFINE_PER_CPU_ALIGNED(unsigned long,
> +			      nfsd_localio_count[ARRAY_SIZE(nfsd_localio_procedures)]);

We have ARRAY_SIZE above and "=3D 2" below, both referring to the same
value.

Maybe #define LOCALIO_NR_PROCEEDURES ARRAY_SIZE(nfsd_localio_procedures)
??

NeilBrown


> +const struct svc_version nfsd_localio_version1 =3D {
> +	.vs_vers	=3D 1,
> +	.vs_nproc	=3D 2,
> +	.vs_proc	=3D nfsd_localio_procedures,
> +	.vs_dispatch	=3D nfsd_dispatch,
> +	.vs_count	=3D nfsd_localio_count,
> +	.vs_xdrsize	=3D XDR_QUADLEN(UUID_SIZE),
> +	.vs_hidden	=3D true,
> +};
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index a477d2c5088a..bc69a2c90077 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -81,6 +81,26 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
>  unsigned long	nfsd_drc_mem_used;
> =20
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +extern const struct svc_version nfsd_localio_version1;
> +static const struct svc_version *nfsd_localio_version[] =3D {
> +	[1] =3D &nfsd_localio_version1,
> +};
> +
> +#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(nfsd_localio_version)
> +
> +static struct svc_program	nfsd_localio_program =3D {
> +	.pg_prog		=3D NFS_LOCALIO_PROGRAM,
> +	.pg_nvers		=3D NFSD_LOCALIO_NRVERS,
> +	.pg_vers		=3D nfsd_localio_version,
> +	.pg_name		=3D "nfslocalio",
> +	.pg_class		=3D "nfsd",
> +	.pg_authenticate	=3D &svc_set_client,
> +	.pg_init_request	=3D svc_generic_init_request,
> +	.pg_rpcbind_set		=3D svc_generic_rpcbind_set,
> +};
> +#endif /* CONFIG_NFSD_LOCALIO */
> +
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static const struct svc_version *nfsd_acl_version[] =3D {
>  # if defined(CONFIG_NFSD_V2_ACL)
> @@ -95,6 +115,9 @@ static const struct svc_version *nfsd_acl_version[] =3D {
>  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
> =20
>  static struct svc_program	nfsd_acl_program =3D {
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	.pg_next		=3D &nfsd_localio_program,
> +#endif /* CONFIG_NFSD_LOCALIO */
>  	.pg_prog		=3D NFS_ACL_PROGRAM,
>  	.pg_nvers		=3D NFSD_ACL_NRVERS,
>  	.pg_vers		=3D nfsd_acl_version,
> @@ -123,6 +146,10 @@ static const struct svc_version *nfsd_version[] =3D {
>  struct svc_program		nfsd_program =3D {
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  	.pg_next		=3D &nfsd_acl_program,
> +#else
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	.pg_next		=3D &nfsd_localio_program,
> +#endif /* CONFIG_NFSD_LOCALIO */
>  #endif
>  	.pg_prog		=3D NFS_PROGRAM,		/* program number */
>  	.pg_nvers		=3D NFSD_NRVERS,		/* nr of entries in nfsd_version */
> @@ -975,7 +1002,7 @@ nfsd(void *vrqstp)
>  }
> =20
>  /**
> - * nfsd_dispatch - Process an NFS or NFSACL Request
> + * nfsd_dispatch - Process an NFS or NFSACL or NFSLOCALIO Request
>   * @rqstp: incoming request
>   *
>   * This RPC dispatcher integrates the NFS server's duplicate reply cache.
> --=20
> 2.44.0
>=20
>=20


