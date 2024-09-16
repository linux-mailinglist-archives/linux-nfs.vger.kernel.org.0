Return-Path: <linux-nfs+bounces-6497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E069A9799A7
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 02:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59753B206AF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 00:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3636B;
	Mon, 16 Sep 2024 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zGom9Dy8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="utPmv0Uz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mFn5kDxl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IWb1EwRM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7B360
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726445094; cv=none; b=IH06+PVl9413p+MGetok2Op21uRN9zSBpo+pWpfWeZJiTpWnP1ZVY0zeadNDWnmdPFUzU3nMPwpXxf16jCFYza6whRTcaM07mzYaJVQFNJiEk+WyfYYGHEbPw0n3uXJ6LjoKSknaw4vcAoxX4/2w7Wc78clwJJ+ReocAS6rcNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726445094; c=relaxed/simple;
	bh=Gwof+if0AAc2gB80eBvRDZ2kq+4FL5gRDdJ6R3NMBls=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W0GPmCbYmHvBD+W6G1HoqxJwu0TZRYCTYiaWXi1nwuUTf7nO169a/oWCMMyc8REdvP1Di+ti0H5pShc6nQqwMmQ3+H1V4hWbilkta2sVsHYlWmwQbtxHjz7iMzNT83H1uvwyxPbizvOg9juMdmDoYTpgNMZe5lAn0N5Oi4O6tJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zGom9Dy8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=utPmv0Uz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mFn5kDxl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IWb1EwRM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82AF121BD3;
	Mon, 16 Sep 2024 00:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726445090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0AmlSXylOg5COVwTkv0Tj8bmHViTdme5hytQ3cWAC8=;
	b=zGom9Dy8cwQ0/dI8yGaCra1nOXpkXxmwm6n6StAG0jY1485SW/rNMDg4MI1YkKwA96Q1hO
	78F1i04dGg2JTCYbSc7cgJ7+x0mNZqAgbWb/tHm9VlKUgJ6/V47vGpMIpZKg2/pyUdef94
	ill9XoavtrP92naRRqwlK4T9PExmGZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726445090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0AmlSXylOg5COVwTkv0Tj8bmHViTdme5hytQ3cWAC8=;
	b=utPmv0Uzh/qRqcrcNT2VgFcqpKH08YLiNn014BVmx94EfFQDKKjwRyI+yKpT9eQTkw12ng
	tOp7jw5xEYggPAAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mFn5kDxl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IWb1EwRM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726445089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0AmlSXylOg5COVwTkv0Tj8bmHViTdme5hytQ3cWAC8=;
	b=mFn5kDxlKrPhj75L+FgGLqFYQTBoXgjctXpJgM/cv27NHk6aj2gOVkqq6zIKJHKWhK60nP
	N2t2vDLsaMMAPxl8L3SGIFnETo8NLQDYnCpdmHKJHUz7wNyX2MdGJvOG8Jmo/TrRE3l1CG
	RK1zV//+tjDB2GHNLsef316K4Uzj+H8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726445089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0AmlSXylOg5COVwTkv0Tj8bmHViTdme5hytQ3cWAC8=;
	b=IWb1EwRMcXiMgCgXTZZeo73k+GCfK3XjkDP9skQJfF7buaV2u+UZxa+S6vGDhztZEop4cn
	/fKrc+4XRSVCm0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0443139CE;
	Mon, 16 Sep 2024 00:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KMwPGR9252aYOQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 16 Sep 2024 00:04:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Salvatore Bonaccorso" <carnil@debian.org>
Cc: "Sergio Gelato" <sergio.gelato@astro.su.se>,
 "Steve Dickson" <steved@redhat.com>, "Kevin Coffman" <kwc@citi.umich.edu>,
 linux-nfs@vger.kernel.org
Subject: Re: rpc.idmapd runs out of file descriptors
In-reply-to: <ZuU7S2Gli6oAALPJ@eldamar.lan>
References: <ZmCB_zqdu2cynJ1M@astro.su.se>, <ZuU7S2Gli6oAALPJ@eldamar.lan>
Date: Mon, 16 Sep 2024 10:04:40 +1000
Message-id: <172644508068.17050.10023446336792076121@noble.neil.brown.name>
X-Rspamd-Queue-Id: 82AF121BD3
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,su.se:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 14 Sep 2024, Salvatore Bonaccorso wrote:
> Hi all,
>=20
> On Wed, Jun 05, 2024 at 05:19:27PM +0200, Sergio Gelato wrote:
> > Observed on Debian 12 (nfs-utils 2.6.2):
> >=20
> > May 28 09:40:25 HOSTNAME rpc.idmapd[3602614]: dirscancb: scandir(/run/rpc=
_pipefs/nfs): Too many open files
> > [repeated multiple times]
> >=20
> > Investigation with lsof on one of the affected systems shows that file de=
sciptors are not being closed:
> >=20
> > [...]
> > rpc.idmap 675 root  126r      DIR               0,40        0      10813 =
/run/rpc_pipefs/nfs/clnt11e6 (deleted)
> > rpc.idmap 675 root  127u     FIFO               0,40      0t0      10817 =
/run/rpc_pipefs/nfs/clnt11e6/idmap (deleted)
> > rpc.idmap 675 root  128r      DIR               0,40        0      10834 =
/run/rpc_pipefs/nfs/clnt11ef (deleted)
> > rpc.idmap 675 root  129u     FIFO               0,40      0t0      10838 =
/run/rpc_pipefs/nfs/clnt11ef/idmap (deleted)
> > rpc.idmap 675 root  130r      DIR               0,40        0      10855 =
/run/rpc_pipefs/nfs/clnt11f8 (deleted)
> > rpc.idmap 675 root  131u     FIFO               0,40      0t0      10859 =
/run/rpc_pipefs/nfs/clnt11f8/idmap (deleted)
> >=20
> > Raising the verbosity level to 3 results in no "Stale client:" lines.
> > strace shows no close() calls other than for the /run/rpc_pipefs/nfs dire=
ctory.
> >=20
> > I believe this is because in dirscancb() the loop is exited prematurely
> > the first time nfsopen() returns -1, preventing later entries in the queue
> > from being reaped. I've tested the patch below, which seems indeed to cure
> > the problem. The bug appears to be still unfixed in the current master br=
anch.
>=20
> > From: Sergio Gelato <Sergio.Gelato@astro.su.se>
> > Date: Tue, 4 Jun 2024 16:02:59 +0200
> > Subject: rpc.idmapd: nfsopen() failures should not be fatal
> >=20
> > dirscancb() loops over all clnt* subdirectories of /run/rpc_pipefs/nfs/.
> > Some of these directories contain /idmap files, others don't. nfsopen()
> > returns -1 for the latter; we then want to skip the directory, not abort
> > the entire scan.
> > ---
> >  utils/idmapd/idmapd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> > index e79c124..f3c540d 100644
> > --- a/utils/idmapd/idmapd.c
> > +++ b/utils/idmapd/idmapd.c
> > @@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
> >  			if (nfsopen(ic) =3D=3D -1) {
> >  				close(ic->ic_dirfd);
> >  				free(ic);
> > -				goto out;
> > +				continue;
> >  			}
> > =20
> >  			if (verbose > 2)
>=20
> Did this felt trough the cracks? Does the patch from Sergio looks good
> to you?
>=20
> Regards,
> Salvatore
>=20

It probably fell through the cracks.  It is always good to mail
nfs-utils patches to SteveD as well as the list.  You've done that now
so hopefully he will pick it up.

I think that patch looks good and sensible.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

