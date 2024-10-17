Return-Path: <linux-nfs+bounces-7215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E909A1752
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 02:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72AC1C21565
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125BE2746C;
	Thu, 17 Oct 2024 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u0zc3567";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Xy4yewY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u0zc3567";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Xy4yewY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AB8F6D;
	Thu, 17 Oct 2024 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126280; cv=none; b=tQc/O1HzD4eDdgOlT8vSUgcL/LjYYjFlYjkHECJri/T8B8ul2CaTzu2QqcMaYCNdwDHA40H0Nfcgx6DlVsHZoHpeuDoGPqiCF2uYQYoSOWepW2P/gdJwrf0mS4x9p+rrah390AbH4A2MLfDnO53mFw3LSX/PLrNKbTE9isHnyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126280; c=relaxed/simple;
	bh=cKIZ51gEzSoGE7kPaiN2lX3PPuwPlGCxoH0L2PppxQE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=B9YdEdO6w9jcJkUzou9FI9lsZVKpeVlfXB9+Wdwh0lN8QOGohb9Xve1u0pMlIDZ908Tz0aovr7pADyuJECpZk9KE3gAnBnV+4zEOeLlOmIRqcR6wx1M6B/J8J1xURhCPsDOlsh0XMJg8ctPLtRiMYwpawj1/qMru9ju62envxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u0zc3567; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Xy4yewY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u0zc3567; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Xy4yewY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 267B221AC8;
	Thu, 17 Oct 2024 00:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729126276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeSM4EngDjY2OynP+TSahx2kcNPoWmoIPyvLW6nocqQ=;
	b=u0zc356797/MmyPFnEmvK12kFY6CK/HoK1iXDkZZ4GaK6PPdpv68njQg6SkYKqLqq9MowT
	UDy3XeopUhXgNVCqD3TEHnb09DnTTXH8ZpN7qQ5E+hoob6+Pt8MuxdQvuJz4z8Hy9gk67s
	wHfNdf1BtTKVwwPV/PgPMIrRGnwgE9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729126276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeSM4EngDjY2OynP+TSahx2kcNPoWmoIPyvLW6nocqQ=;
	b=1Xy4yewYWfjGTNV77HB+4mGWmmVTjIzMUm/scBi6aq+u4BYzRW1QdL/7Tp3u9kZv2SpuUQ
	IFEOcE2sC8BZQLBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u0zc3567;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1Xy4yewY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729126276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeSM4EngDjY2OynP+TSahx2kcNPoWmoIPyvLW6nocqQ=;
	b=u0zc356797/MmyPFnEmvK12kFY6CK/HoK1iXDkZZ4GaK6PPdpv68njQg6SkYKqLqq9MowT
	UDy3XeopUhXgNVCqD3TEHnb09DnTTXH8ZpN7qQ5E+hoob6+Pt8MuxdQvuJz4z8Hy9gk67s
	wHfNdf1BtTKVwwPV/PgPMIrRGnwgE9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729126276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeSM4EngDjY2OynP+TSahx2kcNPoWmoIPyvLW6nocqQ=;
	b=1Xy4yewYWfjGTNV77HB+4mGWmmVTjIzMUm/scBi6aq+u4BYzRW1QdL/7Tp3u9kZv2SpuUQ
	IFEOcE2sC8BZQLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD45313433;
	Thu, 17 Oct 2024 00:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b3EUJIBfEGf2QgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 17 Oct 2024 00:51:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, "Kees Cook" <kees@kernel.org>
Subject:
 Re: [PATCH 2/5][next] nfsd: avoid -Wflex-array-member-not-at-end warnings
In-reply-to: <Zw/KoQRfBl5Y9xyS@tissot.1015granger.net>
References: <>, <Zw/KoQRfBl5Y9xyS@tissot.1015granger.net>
Date: Thu, 17 Oct 2024 11:51:01 +1100
Message-id: <172912626140.81717.18213359690044489488@noble.neil.brown.name>
X-Rspamd-Queue-Id: 267B221AC8
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 17 Oct 2024, Chuck Lever wrote:
> On Tue, Oct 15, 2024 at 06:29:31PM -0600, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >=20
> > Address the following warnings by changing the type of the middle struct
> > members in `struct nfsd_genl_rqstp`, which are currently causing trouble,
> > from `struct sockaddr` to `struct sockaddr_legacy`. Note that the latter
> > struct doesn't contain a flexible-array member.
> >=20
> > fs/nfsd/nfsd.h:74:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> > fs/nfsd/nfsd.h:75:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> >=20
> > Also, update some related code, accordingly.
> >=20
> > No binary differences are present after these changes.
> >=20
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  fs/nfsd/nfsctl.c | 4 ++--
> >  fs/nfsd/nfsd.h   | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 3adbc05ebaac..884bfdc7a255 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1599,9 +1599,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
> >  			genl_rqstp.rq_stime =3D rqstp->rq_stime;
> >  			genl_rqstp.rq_opcnt =3D 0;
> >  			memcpy(&genl_rqstp.rq_daddr, svc_daddr(rqstp),
> > -			       sizeof(struct sockaddr));
> > +			       sizeof(struct sockaddr_legacy));
> >  			memcpy(&genl_rqstp.rq_saddr, svc_addr(rqstp),
> > -			       sizeof(struct sockaddr));
> > +			       sizeof(struct sockaddr_legacy));
> > =20
> >  #ifdef CONFIG_NFSD_V4
> >  			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 004415651295..44be32510595 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -71,8 +71,8 @@ struct readdir_cd {
> >  #define NFSD_MAX_OPS_PER_COMPOUND	50
> > =20
> >  struct nfsd_genl_rqstp {
> > -	struct sockaddr		rq_daddr;
> > -	struct sockaddr		rq_saddr;
> > +	struct sockaddr_legacy	rq_daddr;
> > +	struct sockaddr_legacy	rq_saddr;
>=20
> I was hoping to find a struct definition that was simply a union of
> sockaddr_in and sockaddr_in6, which we have in nfs-utils but I guess
> not here in the kernel.
>=20
> Can we use "struct sockaddr_storage" safely here? Then above,
> replace the raw memcpy() with rpc_copy_addr() ?

sockaddr_storage is conceptually the right solution.  It is 128 bytes so
2 of them will waste about 200 bytes on the stack.  Does that matter
these days?  Probably not.

I do like using rpc_copy_addr().

NeilBrown


>=20
>=20
> >  	unsigned long		rq_flags;
> >  	ktime_t			rq_stime;
> >  	__be32			rq_xid;
> > --=20
> > 2.34.1
> >=20
>=20
> --=20
> Chuck Lever
>=20


