Return-Path: <linux-nfs+bounces-7918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD29C6610
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 01:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248E52816CE
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962D6FD5;
	Wed, 13 Nov 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yhdOflOH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A2Q4nvYx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yhdOflOH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A2Q4nvYx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F35CB8
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457983; cv=none; b=e8Uf+DHqgDSlAqiwQeL4BAoGJwo4b9gbeJ2Pi/nHrsbVLFgkLQLJYRIfnniPZfPZsyvEK4VzNtjJcT680pSf8BYHKmiXcb7zrmk8EmjMAF40zEBM+lEuAhPy+AfLU0oPjDCsRnnlWw/qlyadecLFo9V+dsNN+p3rR8krn5+9yLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457983; c=relaxed/simple;
	bh=IUp5+0AGLlfnp5ZyKfxHnOSmHs1BEvB1CprPfRq985A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Qe8yozd6KU/oKO3ilKTle24+otpjjgHfX/e4xN08HFHoevqK2df1IqtwFpAgJaw7SDXfsv8xQ9FTA1GAqCB8SzJxsWkbY/AeoQZFC+T1tYGjiL3CrJAB3n22eFMJXBvih7gHTVkKw0I9EqSVVYHNe+xDtj/PoMIw0b99aiihWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yhdOflOH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A2Q4nvYx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yhdOflOH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A2Q4nvYx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4DA62122C;
	Wed, 13 Nov 2024 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731457979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDORCVTwspadR0QQ5ypRM2waGl2qx+YLAOrRrrwruiQ=;
	b=yhdOflOHqXgCGLlBEFhQSLOu+3NqMaM8O7MA6ZAc/F8Xh4S1DRwpfovFx+eBmrggfFl41Y
	yPvGp0F0txRlauP3B6nQQ+w1YhBIapekYdqzBMW9mjT2DenO4gv6x5dgTp/65Y6+Lc0XXQ
	GEnjdn24kNgqktGBgpka3+NGM/ZQAwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731457979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDORCVTwspadR0QQ5ypRM2waGl2qx+YLAOrRrrwruiQ=;
	b=A2Q4nvYxUX1kAJnVm4WKtfCVyjaK4rd3DHTDXA8ubmALgc9T1whquBFmTnaiNv1SfZ2L1e
	/GDsMqoW1GgtrWBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yhdOflOH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A2Q4nvYx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731457979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDORCVTwspadR0QQ5ypRM2waGl2qx+YLAOrRrrwruiQ=;
	b=yhdOflOHqXgCGLlBEFhQSLOu+3NqMaM8O7MA6ZAc/F8Xh4S1DRwpfovFx+eBmrggfFl41Y
	yPvGp0F0txRlauP3B6nQQ+w1YhBIapekYdqzBMW9mjT2DenO4gv6x5dgTp/65Y6+Lc0XXQ
	GEnjdn24kNgqktGBgpka3+NGM/ZQAwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731457979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDORCVTwspadR0QQ5ypRM2waGl2qx+YLAOrRrrwruiQ=;
	b=A2Q4nvYxUX1kAJnVm4WKtfCVyjaK4rd3DHTDXA8ubmALgc9T1whquBFmTnaiNv1SfZ2L1e
	/GDsMqoW1GgtrWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB21813301;
	Wed, 13 Nov 2024 00:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yo3uG7nzM2etJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 00:32:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
In-reply-to: <24F9F9A5-7EB3-430D-BDB2-A9314C581817@oracle.com>
References: <>, <24F9F9A5-7EB3-430D-BDB2-A9314C581817@oracle.com>
Date: Wed, 13 Nov 2024 11:32:50 +1100
Message-id: <173145797087.1734440.13669795563206186113@noble.neil.brown.name>
X-Rspamd-Queue-Id: C4DA62122C
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 13 Nov 2024, Chuck Lever III wrote:
>=20
>=20
> > On Nov 12, 2024, at 6:13=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Wed, 13 Nov 2024, Chuck Lever wrote:
> >> On Tue, Nov 12, 2024 at 11:49:30AM +1100, NeilBrown wrote:
> >>>>=20
> >>>> If you have a specific idea for the mechanism we need to create to
> >>>> detect the v3 client reconnects to the server please let me know.
> >>>> Reusing or augmenting an existing thing is fine by me.
> >>>=20
> >>> nfs3_local_probe(struct nfs_server *server)
> >>> {
> >>>  struct nfs_client *clp =3D server->nfs_client;
> >>>  nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;
> >>>=20
> >>>  if (nfs_uuid->connect_cookie !=3D clp->cl_rpcclient->cl_xprt->connect_=
cookie)
> >>>       nfs_local_probe_async()
> >>> }
> >>>=20
> >>> static void nfs_local_probe_async_work(struct work_struct *work)
> >>> {
> >>>  struct nfs_client *clp =3D container_of(work, struct nfs_client,
> >>>                              cl_local_probe_work);
> >>>  clp->cl_uuid.connect_cookie =3D
> >>>     clp->cl_rpcclient->cl_xprt->connect_cookie;
> >>>  nfs_local_probe(clp);
> >>> }
> >>>=20
> >>> Or maybe assign connect_cookie (which we have to add to uuid) inside
> >>> nfs_local_probe().
> >>=20
> >> The problem with per-connection checks is that a change in export
> >> security policy could disable LOCALIO rather persistently. The only
> >> way to recover, if checking is done only when a connection is
> >> established, is to remount or force a disconnect.
> >>=20
> > What export security policy specifically?
> > Do you mean changing from sec=3Dsys to to sec=3Dkrb5i for example?
>=20
> Another example might be altering the IP address list on
> the export. Suppose the client is accidentally blocked
> by this policy, the administrator realizes it, and changes
> it again to restore access.
>=20
> The client does not disconnect in this case, AFAIK.

Yes, that is a simpler case...

How would the localio path get disabled when this happens?
I suspect ->nfsd_open_local_fh would (should?) fail.
It, or nfs_open_local_fh() which calls it, could reset
uuid->connect_cookie to an impossible value so as to force a
probe after the next successful IO.  That would be an important part of
the protocol.

Thanks,
NeilBrown

