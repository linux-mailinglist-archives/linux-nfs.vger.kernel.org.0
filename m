Return-Path: <linux-nfs+bounces-2833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F48A5EDC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 01:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090241F21B71
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 23:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7560157A61;
	Mon, 15 Apr 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S/WjInJq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r+XCgraG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WLQnfDWZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GJv6TrdB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027B1591F9
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225141; cv=none; b=LSEu3K+sCiy9XSY5Ei90b1AU/74ClsI7wqqVPAEDKSAtN0rOgfaVKoIXDD5mTLyt0l6vwI1LJlNut6NS1RwTbcchDRxgiE0oHyCeXT/YtcKjJ5MzfTsi2nt8GLkucjUG0Xa3x4lmIoL+b47qJfgyJcg/710OsEE5f4AJs8Xa5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225141; c=relaxed/simple;
	bh=k4wHKg5t3ZL8F3q7hYY3Q9GplNdzwzZLJ1uXfDOo9wA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Imu6mZv5HKvXPzuGbA83Zfvn1eScyRe7DmM6V3p/98X/KyrOdPCgtAqIxBlvlnuWMdYe5C2CqdZMSDtnC6CN4u455I7stwFUj81bnc/I7LVy3GgXaz+Lh/Lyb9ccqyb7/alYVTREV5dCe24wGFl2xEdvQdanj5CwAd2+yVUyAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S/WjInJq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r+XCgraG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WLQnfDWZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GJv6TrdB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E40F05D517;
	Mon, 15 Apr 2024 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713225138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
	b=S/WjInJqBv/gXswR5607BsAk/LqRfL+QfMz8UXRa01mYvplSCVwg9IYpNTAxLYMtZk2Fw5
	Vls4Xdi3KGsfDERC/4koB5HDtn0wu3u7odukvVYHhE+lL2O0nU8KRmHJx1s5SFwj1fghwf
	qR96oq77AwQrrVEABbvGbdbfmfJLhIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713225138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
	b=r+XCgraG9jI8TPZz+9Q65m07l6jLHCE2P//69M72R94fQaQE1EmnE6Y/RpZz5z1Gwv9G0C
	rnGc3weK9GGpRAAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713225137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
	b=WLQnfDWZgWaXfsBwRdCCvONHMC+H4u4ALdfhSlQYRRlD4rH4RPmRnrPPXMfGyNeFgFT0XX
	N/5K1dEa+WjKs7DUbdXFoGZty0RuQekRoS4E5PLVRNOiORTRrJxlxLHAYGo29PmFinT+3I
	/I7gHMdZInoNUEgUaZXJk8XGbaVBmgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713225137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
	b=GJv6TrdB826oOs+5Wgs2/j/XfWbnLEZXfMZUedIL/evz/c+pnHwZJcVXzZahKqu/GgWa3b
	sCbfrnSwRAITbeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9041368B;
	Mon, 15 Apr 2024 23:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nhYUOK69HWaaUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Apr 2024 23:52:14 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Petr Vorel" <pvorel@suse.cz>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, "Cyril Hrubis" <chrubis@suse.cz>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] proc01: Whitelist /proc/fs/nfsd/nfsv4recoverydir
In-reply-to: <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
References: <>, <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
Date: Tue, 16 Apr 2024 09:52:11 +1000
Message-id: <171322513118.17212.2981486436520645718@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On Tue, 16 Apr 2024, Chuck Lever wrote:
> On Mon, Apr 15, 2024 at 01:43:37PM -0400, Jeff Layton wrote:
> > On Mon, 2024-04-15 at 17:37 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Apr 15, 2024, at 1:35=E2=80=AFPM, Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > >=20
> > > > On Mon, 2024-04-15 at 17:27 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Apr 15, 2024, at 1:21=E2=80=AFPM, Petr Vorel <pvorel@suse.cz> =
wrote:
> > > > > >=20
> > > > > > /proc/fs/nfsd/nfsv4recoverydir started from kernel 6.8 report EIN=
VAL.
> > > > > >=20
> > > > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > > > ---
> > > > > > Hi,
> > > > > >=20
> > > > > > @ Jeff, Chuck, Neil, NFS devs: The patch itself whitelist reading
> > > > > > /proc/fs/nfsd/nfsv4recoverydir in LTP test. I suspect reading fai=
led
> > > > > > with EINVAL in 6.8 was a deliberate change and expected behavior =
when
> > > > > > CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set:
> > > > >=20
> > > > > I'm not sure it was deliberate. This seems like a behavior
> > > > > regression. Jeff?
> > > > >=20
> > > >=20
> > > > I don't think I intended to make it return -EINVAL. I guess that's wh=
at
> > > > happens when there is no entry for it in the write_op array.
> > > >=20
> > > > With CONFIG_NFSD_LEGACY_CLIENT_TRACKING disabled, that file has no
> > > > meaning or value at all anymore. Maybe we should just remove the dent=
ry
> > > > altogether when CONFIG_NFSD_LEGACY_CLIENT_TRACKING is disabled?
> > >=20
> > > My understanding of the rules about modifying this part of
> > > the kernel-user interface is that the file has to stay, even
> > > though it's now a no-op.
> > >=20
> >=20
> > Does it?  Where are these rules written?=20
> >=20
> > What should we have it do now when read and written? Maybe EOPNOTSUPP
> > would be better, if we can make it just return an error?
> >=20
> > We could also make it just discard written data, and present a blank
> > string when read. What do the rules say we are required to do here?
>=20
> The best I could find was Documentation/process/stable-api-nonsense.rst.
>=20
> Tell you what, you and Petr work out what you'd like to do, let's
> figure out the right set of folks to review changes in /proc, and
> we'll go from there. If no-one has a problem removing the file, I'm
> not going to stand in the way.

I don't think we need any external review for this.  While the file is
in /proc, it is not in procfs but in nfsdfs.  So people out side the
nfsd community are unlikely to care.  And this isn't a hard removal.  It
is just a new config option that allows a file to be removed.

I think we do want to completely remove the file, not just let it return
an error:
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -51,7 +51,9 @@ enum {
 #ifdef CONFIG_NFSD_V4
 	NFSD_Leasetime,
 	NFSD_Gracetime,
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	NFSD_RecoveryDir,
+#endif
 	NFSD_V4EndGrace,
 #endif
 	NFSD_MaxReserved
@@ -1360,7 +1362,9 @@ static int nfsd_fill_super(struct super_block *sb, stru=
ct fs_context *fc)
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Gracetime] =3D {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IR=
USR},
+#endif
 		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
 #endif
 		/* last one */ {""}


My understand of the stability rule is "if Linus doesn't hear about it,
then it isn't a regression".  Also known as "no harm, no foul".

So if we manage the change to everyone's satisfaction, then it is
perfectly OK to make the change.  nfs-utils already handles a missing
file fairly well - you get a D_GENERAL log message, but that is all.
Petr's fix for ltp should allow it to work.  I would be greatly
surprised if anything else (except possibly other testing code) would
care.

NeilBrown

