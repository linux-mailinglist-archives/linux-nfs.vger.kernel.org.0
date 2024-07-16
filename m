Return-Path: <linux-nfs+bounces-4943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC965931EA7
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 04:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD271C21931
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 02:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE334C9F;
	Tue, 16 Jul 2024 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rks5Gny1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8M1YjoMd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vkd20oMa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fx+aK6L+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320E63C7
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721095470; cv=none; b=OP0YTVgw449+IgSngchvMZkQQD77uW/XHxpE5f4cJWDKUVCEwzBkPcuTtI2UL20twibI7GCFtdZu7gXW3koOcnfYQvlmYjmc/sPyGsMlGugAAeVbWcOd1OGpe1RNkE4e+1l2wi8TGDmaSSmJ/uEXvOCgs4KcC6fFju1ffeijJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721095470; c=relaxed/simple;
	bh=ZHeyhaqzfTeqBoGlT3phEumHFJy9UWAiStqXlEidE0w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=f0KrUSowANRypOkL/5CzIlGr1gVG4et7mCE5JOor7+V+S4/aIHYYX83VhePp7Jni/UtKQWR01bc4b0VDE5qTRzeoZlFG802qezHV63sU3hOtj8Myrke9Xa4ZSNePfNJ0W63qo1CwignTAB6NVqrIhQZFClxynArVE7OSOqlMB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rks5Gny1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8M1YjoMd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vkd20oMa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fx+aK6L+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 919DD1F838;
	Tue, 16 Jul 2024 02:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721095466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1B/xvo4OD3cpv4BfOwtr9todQYT0fjdrzo6WNFNVbk=;
	b=Rks5Gny1+EnJdmAfmhlfUyFTT3KKLe4SZEW3J/jwteLbvKAtNeM2cXB0Pn2bB5NGjq7KG+
	zncC14PQ7GJO+nzZ/PG8HltX4tNvJ0efQz1D6qFQ6h9dbpUXgyxcRzsm6L/lUYITdnZtrk
	FW/eDNIgh7xqtyMXlm9YTTrLG+Dd/+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721095466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1B/xvo4OD3cpv4BfOwtr9todQYT0fjdrzo6WNFNVbk=;
	b=8M1YjoMd37zaWb+YAYvVbeSvKpyktsTzSw17cuZUYkoHBSq2ExNDk6izF1f/7Eh3LENLgF
	S7+jN341wjWXwKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721095465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1B/xvo4OD3cpv4BfOwtr9todQYT0fjdrzo6WNFNVbk=;
	b=Vkd20oMayiEpBAkvB8ceDbDhMFMlKRG+ZxA6ApFQlXAbH+mq+5oDDBfTkN1cIeRLnNWMos
	zmqmxSCM1c45Im1+7iZCe+vE3WYBo4PpWRzQJrI41zHhvDd9jcwzL9v/jMZXfhi197zbQ8
	8DOf8vDIQ37QZbe6h7mC264WDj1TaE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721095465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1B/xvo4OD3cpv4BfOwtr9todQYT0fjdrzo6WNFNVbk=;
	b=fx+aK6L+SNuek5OmHIV21L9A0yOCPIWdAaLvfCQo+jGj+NnczPqpC4wnTG4469if5UQEE4
	PD61R6evaKpHV6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 249FC1389C;
	Tue, 16 Jul 2024 02:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fs60MibVlWYrJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jul 2024 02:04:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Steve Dickson" <steved@redhat.com>
Subject: Re: [PATCH 11/14] nfsd: don't use sv_nrthreads in connection limiting
 calculations.
In-reply-to: <2d74fdf5f3c1f2b0e5264ff3c807b1b38657c9ef.camel@kernel.org>
References: <>, <2d74fdf5f3c1f2b0e5264ff3c807b1b38657c9ef.camel@kernel.org>
Date: Tue, 16 Jul 2024 12:04:16 +1000
Message-id: <172109545615.15471.3319971222860531801@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 

On Tue, 16 Jul 2024, Jeff Layton wrote:
> On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> > The heuristic for limiting the number of incoming connections to nfsd
> > currently uses sv_nrthreads - allowing more connections if more threads
> > were configured.
> >=20
> > A future patch will allow number of threads to grow dynamically so that
> > there is no need to configure sv_nrthreads.=C2=A0 So we need a different
> > solution for limiting connections.
> >=20
> > It isn't clear what problem is solved by limiting connections (as
> > mentioned in a code comment) but the most likely problem is a connection
> > storm - many connections that are not doing productive work.=C2=A0 These =
will
> > be closed after about 6 minutes already but it might help to slow down a
> > storm.
> >=20
> > This patch add a per-connection flag XPT_PEER_VALID which indicates
> > that the peer has presented a filehandle for which it has some sort of
> > access.=C2=A0 i.e the peer is known to be trusted in some way.=C2=A0 We n=
ow only
> > count connections which have NOT be determined to be valid.=C2=A0 There
> > should be relative few of these at any given time.
> >=20
> > If the number of non-validated peer exceed as limit - currently 64 - we
> > close the oldest non-validated peer to avoid having too many of these
> > useless connections.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > =C2=A0fs/nfsd/netns.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0fs/nfsd/nfsfh.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> > =C2=A0include/linux/sunrpc/svc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
> > =C2=A0include/linux/sunrpc/svc_xprt.h |=C2=A0 4 ++++
> > =C2=A0net/sunrpc/svc_xprt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 33 +++++++++++++++++----------------
> > =C2=A05 files changed, 32 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 238fc4e56e53..0d2ac15a5003 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -128,8 +128,8 @@ struct nfsd_net {
> > =C2=A0	unsigned char writeverf[8];
> > =C2=A0
> > =C2=A0	/*
> > -	 * Max number of connections this nfsd container will allow. Defaults
> > -	 * to '0' which is means that it bases this on the number of threads.
> > +	 * Max number of non-validated connections this nfsd container
> > +	 * will allow.=C2=A0 Defaults to '0' gets mapped to 64.
> > =C2=A0	 */
> > =C2=A0	unsigned int max_connections;
> > =C2=A0
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 0b75305fb5f5..08742bf8de02 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -391,6 +391,14 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp=
, umode_t type, int access)
> > =C2=A0		goto out;
> > =C2=A0
> > =C2=A0skip_pseudoflavor_check:
> > +	if (test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags) &&
> > +	=C2=A0=C2=A0=C2=A0 !test_and_set_bit(XPT_PEER_VALID, &rqstp->rq_xprt->x=
pt_flags)) {
> > +		struct svc_serv *serv =3D rqstp->rq_server;
> > +		spin_lock(&serv->sv_lock);
> > +		serv->sv_tmpcnt -=3D 1;
> > +		spin_unlock(&serv->sv_lock);
> > +	}
> > +
>=20
> This is the only place you set XPT_PEER_VALID, but this change affects
> more services than just nfsd. What about lockd? Do we need a similar
> change there?

Lockd calls nlmsvc_ops->fopen which is nlm_fopen() which calls
nfsd_open() which calls fh_verify().  So lockd is safe.

The nfs callback handler might need help, but it sets ->sv_maxconn=3D1024,
so I think it is safe for now.
(lockd defaults nlm_max_connections to 1024, so it is also safe without
calling fh_verify.  Maybe I should clean up)

Thanks,
NeilBrown

