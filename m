Return-Path: <linux-nfs+bounces-7914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D659C64F7
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 00:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361B9282D07
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097BD205ABD;
	Tue, 12 Nov 2024 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SZ2CVvFb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QW6KzpGT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SZ2CVvFb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QW6KzpGT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151521A4D0
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453210; cv=none; b=Ys2MAeCQCfpDL0tnzoKDT3gLdK7XQxywPJXbGaSQF1Gsmg5/uNx3ThP+j69bpcZsbuA0OEVhuqCyoYhOUMAhuRE+Qgv1GrKo1B0NxvjRun2+eY5aF8d7QIDVKw39D/TE5TlfLIcAFbYZCXlYCNT55GmDiN/pKeua6yptL5wL/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453210; c=relaxed/simple;
	bh=fa3x1hZR7PZ8VzxyFFAnOuv8yIHLuO35kZJ8X+wBgGY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cX5XNXueIwu89U2MPzQyMohjyMIRb2pHJIQWo7yBealnSDRzCsSyZ6CxOwvIBcfl6sqrFD+/g4RWJTETxt3ce+9fxHCbTCz21eujuq8N3l49uVcr8cQO5AuWRyuDzKsZGNUT6nt9J2g2Q+67vmEq7xcMD940tqyjneHkiD3aMWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SZ2CVvFb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QW6KzpGT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SZ2CVvFb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QW6KzpGT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D3AC21230;
	Tue, 12 Nov 2024 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731453207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9qpSET5XOucfoWiPM5ruQNZRkAKlFRJVygtoB8yPVE=;
	b=SZ2CVvFb6h/gjULSyCoi31rQS7OczWGF7B7a3QqRiClkGLuA/pz9JzU7C7M80SQm45E3w/
	NJEleavKDJWLQuytpaTFFIVVcxUiOI63ewoILONzX2u6NhPKLfHgwFt3ttg0PGphoL4zaC
	U5X42oryjzYQsFIJURKm/z32fua9BoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731453207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9qpSET5XOucfoWiPM5ruQNZRkAKlFRJVygtoB8yPVE=;
	b=QW6KzpGTBQjTIq1+o87Zo+/MZrWe7WBKTQAA2xkXnf9lJjLuLk6JeFEQ3Ta0gzZby6OECo
	t0egRQO5z9ejJaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731453207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9qpSET5XOucfoWiPM5ruQNZRkAKlFRJVygtoB8yPVE=;
	b=SZ2CVvFb6h/gjULSyCoi31rQS7OczWGF7B7a3QqRiClkGLuA/pz9JzU7C7M80SQm45E3w/
	NJEleavKDJWLQuytpaTFFIVVcxUiOI63ewoILONzX2u6NhPKLfHgwFt3ttg0PGphoL4zaC
	U5X42oryjzYQsFIJURKm/z32fua9BoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731453207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9qpSET5XOucfoWiPM5ruQNZRkAKlFRJVygtoB8yPVE=;
	b=QW6KzpGTBQjTIq1+o87Zo+/MZrWe7WBKTQAA2xkXnf9lJjLuLk6JeFEQ3Ta0gzZby6OECo
	t0egRQO5z9ejJaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4811F13301;
	Tue, 12 Nov 2024 23:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YDBDOxThM2fAEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Nov 2024 23:13:24 +0000
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
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
In-reply-to: <ZzNn2czIB0f66g0Y@tissot.1015granger.net>
References: <>, <ZzNn2czIB0f66g0Y@tissot.1015granger.net>
Date: Wed, 13 Nov 2024 10:13:22 +1100
Message-id: <173145320232.1734440.886416117667950658@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 13 Nov 2024, Chuck Lever wrote:
> On Tue, Nov 12, 2024 at 11:49:30AM +1100, NeilBrown wrote:
> > >=20
> > > If you have a specific idea for the mechanism we need to create to
> > > detect the v3 client reconnects to the server please let me know.
> > > Reusing or augmenting an existing thing is fine by me.
> >=20
> > nfs3_local_probe(struct nfs_server *server)
> > {
> >   struct nfs_client *clp =3D server->nfs_client;
> >   nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;
> >=20
> >   if (nfs_uuid->connect_cookie !=3D clp->cl_rpcclient->cl_xprt->connect_c=
ookie)
> >        nfs_local_probe_async()
> > }
> >=20
> > static void nfs_local_probe_async_work(struct work_struct *work)
> > {
> >   struct nfs_client *clp =3D container_of(work, struct nfs_client,
> >                               cl_local_probe_work);
> >   clp->cl_uuid.connect_cookie =3D
> >      clp->cl_rpcclient->cl_xprt->connect_cookie;
> >   nfs_local_probe(clp);
> > }
> >=20
> > Or maybe assign connect_cookie (which we have to add to uuid) inside
> > nfs_local_probe().=20
>=20
> The problem with per-connection checks is that a change in export
> security policy could disable LOCALIO rather persistently. The only
> way to recover, if checking is done only when a connection is
> established, is to remount or force a disconnect.
>=20
What export security policy specifically?
Do you mean changing from sec=3Dsys to to sec=3Dkrb5i for example?  This
would (hopefully) disable localio.  Then changing the export back to
sec=3Dsys would mean that localio would be possible again.  I wonder how
the client copes with this.  Does it work on a live mount without
remount?  If so it would certainly make sense for the current security
setting to be cached in nfs_uidd and for a probe to be attempted
whenever that changed to sec=3Dsys.

Thanks,
NeilBrown

