Return-Path: <linux-nfs+bounces-3680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9829049FA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 06:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA2B2131F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819E208C3;
	Wed, 12 Jun 2024 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kWKW6bIA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nrkcw/KD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kWKW6bIA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nrkcw/KD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1864A
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166508; cv=none; b=jcZ7VNdBlv3cqIett4Fgk1VQj/oJDIggNqJvXOprjkjsL8SLSF8ewdzEopMv8AhY1AY222sYZmynxeR/d3B4gsnM+wD55jhwmEWgDAAz4/bezH7gq+qnaEeqxXm7t27CaPwbwwmCf4Ik12zXkCml+knJIQoV1e6cEkEYzKvOyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166508; c=relaxed/simple;
	bh=f505b/fVPC2vpoLs0lrxtpuxMJuQyXR0VgxXtm5OZDU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RHt/PA1/RjBx/g8KgzCkFUDC8P9pEo5Ldou/tMZePF5J6f6b/5RW6vV4RFN64BBRCgzFyqRGQL1FJA4QzxU9DNOUwLeoUwBb/hJOZ6QuZ7VJmu+Gj3Dk4bu3azQW7WJRT+PaZt82T0ov6fFqYKTJv69M8xQt3pu5wrlojBmpq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kWKW6bIA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nrkcw/KD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kWKW6bIA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nrkcw/KD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92E2C21906;
	Wed, 12 Jun 2024 04:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718166504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJCaoPb2PGlAskV7iThttkrOuIkz+tFHgcj09BszdIs=;
	b=kWKW6bIAK3Sz+C5xtcOhLF+6OumYY+OJdTfCtWg48tsUH4342TLlPl1h5FIVGoFjKPqmS/
	sqCmDyPrUTDLNRahaPeiiFDiHYc+lJ9ADDwySX5SJ5LdqYrGm8DMyAmH7DflRxIyUhe5kl
	2RIPKn4Qe8q2vtWdOjO3Xh6aGNdtKic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718166504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJCaoPb2PGlAskV7iThttkrOuIkz+tFHgcj09BszdIs=;
	b=Nrkcw/KD8FV6BgT7tYcd25Bur4Buo/o2nnxe6GE09CHSwM606XulPorvlBh45yAzMG4aij
	+vQfEPZ/LdsbVUCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kWKW6bIA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Nrkcw/KD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718166504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJCaoPb2PGlAskV7iThttkrOuIkz+tFHgcj09BszdIs=;
	b=kWKW6bIAK3Sz+C5xtcOhLF+6OumYY+OJdTfCtWg48tsUH4342TLlPl1h5FIVGoFjKPqmS/
	sqCmDyPrUTDLNRahaPeiiFDiHYc+lJ9ADDwySX5SJ5LdqYrGm8DMyAmH7DflRxIyUhe5kl
	2RIPKn4Qe8q2vtWdOjO3Xh6aGNdtKic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718166504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJCaoPb2PGlAskV7iThttkrOuIkz+tFHgcj09BszdIs=;
	b=Nrkcw/KD8FV6BgT7tYcd25Bur4Buo/o2nnxe6GE09CHSwM606XulPorvlBh45yAzMG4aij
	+vQfEPZ/LdsbVUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB86513AA4;
	Wed, 12 Jun 2024 04:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ASGqI+UjaWZkHgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 04:28:21 +0000
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
Subject: Re: [RFC PATCH v2 04/15] sunrpc: add rpcauth_map_to_svc_cred_local
In-reply-to: <20240612030752.31754-5-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>,
 <20240612030752.31754-5-snitzer@kernel.org>
Date: Wed, 12 Jun 2024 14:28:14 +1000
Message-id: <171816649431.14261.3448167153955136615@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 92E2C21906
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add new funtion rpcauth_map_to_svc_cred_local which maps a generic
> rpc_cred to an svc_cred suitable for use in nfsd.

This comment is stale.  There is not such thing as an "rpc_cred".

NeilBrown

>=20
> This is needed by the localio code to map nfs client creds to nfs
> server credentials.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  include/linux/sunrpc/auth.h |  4 ++++
>  net/sunrpc/auth.c           | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
> index 61e58327b1aa..f8b561cf78ab 100644
> --- a/include/linux/sunrpc/auth.h
> +++ b/include/linux/sunrpc/auth.h
> @@ -11,6 +11,7 @@
>  #define _LINUX_SUNRPC_AUTH_H
> =20
>  #include <linux/sunrpc/sched.h>
> +#include <linux/sunrpc/svcauth.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/xdr.h>
> =20
> @@ -184,6 +185,9 @@ int			rpcauth_uptodatecred(struct rpc_task *);
>  int			rpcauth_init_credcache(struct rpc_auth *);
>  void			rpcauth_destroy_credcache(struct rpc_auth *);
>  void			rpcauth_clear_credcache(struct rpc_cred_cache *);
> +bool			rpcauth_map_to_svc_cred_local(struct rpc_auth *,
> +						      const struct cred *,
> +						      struct svc_cred *);
>  char *			rpcauth_stringify_acceptor(struct rpc_cred *);
> =20
>  static inline
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 04534ea537c8..f75728922d57 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -308,6 +308,23 @@ rpcauth_init_credcache(struct rpc_auth *auth)
>  }
>  EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
> =20
> +bool
> +rpcauth_map_to_svc_cred_local(struct rpc_auth *auth, const struct cred *cr=
ed,
> +			      struct svc_cred *svc)
> +{
> +	svc->cr_uid =3D cred->uid;
> +	svc->cr_gid =3D cred->gid;
> +	svc->cr_flavor =3D auth->au_flavor;
> +	if (cred->group_info)
> +		svc->cr_group_info =3D get_group_info(cred->group_info);
> +	/* These aren't relevant for local (network is bypassed) */
> +	svc->cr_principal =3D NULL;
> +	svc->cr_gss_mech =3D NULL;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(rpcauth_map_to_svc_cred_local);
> +
>  char *
>  rpcauth_stringify_acceptor(struct rpc_cred *cred)
>  {
> --=20
> 2.44.0
>=20
>=20
>=20


