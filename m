Return-Path: <linux-nfs+bounces-2072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF976862DD3
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F221C20D07
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343651B95A;
	Sun, 25 Feb 2024 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MEDnbkuB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TvrihKyd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MEDnbkuB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TvrihKyd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B21B94E
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708902150; cv=none; b=tr6/WWyjAs83jn0FSQa7vOfaDr4BzRU3zMIxtX+9GlvC2OcyTnfyDG54Ay7J/qIjsZ2be37wioAjGQxbtNtNiG6GKxhbYTW3rHyWAO2GR1TQHjHm5sU8yJAYNuI2wVahPma1stADxHT7/aQ6Yq5m1epPTHw5s5Vhim1jsG5PMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708902150; c=relaxed/simple;
	bh=fgQ2jmkvMhib7I66PxHKAP7gHZKkcHZwVCXlboAZwe8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Dx032QCloXjmNB0Q8LiwRWQ4K1DMXnByBoXvgFW9zIoBNJz2tfV4Tu0Q9IcyG8HzumsLEPOtLVeyZpATtOYpXC2m5H0Kg1faCCHNCJ7KVZODzv2G3HNa1VRr8B9MhEdM+sBYLU9edcpKKjhpIA1is/lsYsZYqT2thgO5gwA/iQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MEDnbkuB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TvrihKyd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MEDnbkuB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TvrihKyd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21F9122495;
	Sun, 25 Feb 2024 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708902146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0shubPgbAe05eyAKysJzhQjdYs8pRtNjHCVsCDs7Ak=;
	b=MEDnbkuBalFsqG+5XSLymYgpS2b1PTgEWWNZL9DY16jWei512CbTAH+8zeOSRGD30F4ptt
	gPcqoNi/JKQEadZwIvdv3OBesR/R5fpeUk1jHbYY9dACIfUYzs68QJ0SicZybusJS7FZNq
	n/OeyuTNUqkBzZHN5OZvGAH3xKTfC5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708902146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0shubPgbAe05eyAKysJzhQjdYs8pRtNjHCVsCDs7Ak=;
	b=TvrihKyd9GR2pcNUljuxgOrtCu0ZeHHEydnIwyOkmb1UKattV+jYSjyZ7AHI4IQ6t5rig7
	U1agGeqx1Jdb30DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708902146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0shubPgbAe05eyAKysJzhQjdYs8pRtNjHCVsCDs7Ak=;
	b=MEDnbkuBalFsqG+5XSLymYgpS2b1PTgEWWNZL9DY16jWei512CbTAH+8zeOSRGD30F4ptt
	gPcqoNi/JKQEadZwIvdv3OBesR/R5fpeUk1jHbYY9dACIfUYzs68QJ0SicZybusJS7FZNq
	n/OeyuTNUqkBzZHN5OZvGAH3xKTfC5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708902146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0shubPgbAe05eyAKysJzhQjdYs8pRtNjHCVsCDs7Ak=;
	b=TvrihKyd9GR2pcNUljuxgOrtCu0ZeHHEydnIwyOkmb1UKattV+jYSjyZ7AHI4IQ6t5rig7
	U1agGeqx1Jdb30DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EF5413A5B;
	Sun, 25 Feb 2024 23:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PS2nNP/G22WGHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:02:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jacek Tomaka" <Jacek.Tomaka@poczta.fm>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: NFS data corruption on congested network
In-reply-to: <ujvntmhlfharduyanjob@tgqn>
References: <ujvntmhlfharduyanjob@tgqn>
Date: Mon, 26 Feb 2024 10:02:20 +1100
Message-id: <170890214013.24797.3257981274610636720@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[poczta.fm];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FREEMAIL_TO(0.00)[poczta.fm];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Fri, 23 Feb 2024, Jacek Tomaka wrote:
> Hello,
> I ran into an issue where the NFS file ends up being corrupted on disk. We =
started noticing it on certain, quite old hardware after upgrading OS from Ce=
ntos 6 to Rocky 9.2. We do see it on Rocky 9.3 but not on 9.1.
>=20
> After some investigation we have reasons to believe that the change was int=
roduced by the following commit:=20
> https://github.com/torvalds/linux/commit/6df25e58532be7a4cd6fb15bcd85805947=
402d91

Thanks for the report.
Can you try a change to your kernel?

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb79d3a886ae..08a787147bd2 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct folio *folio,
 	int err;
=20
 	if (wbc->sync_mode =3D=3D WB_SYNC_NONE &&
-	    NFS_SERVER(inode)->write_congested)
+	    NFS_SERVER(inode)->write_congested) {
+		folio_redirty_for_writepage(wbc, folio);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
=20
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
 	nfs_pageio_init_write(&pgio, inode, 0, false,


though if your kernel is older than 6.3, that will be
         redirty_for_writepage(wbc, page);

Thanks,
NeilBrown


>=20
> We write a number of files on a single thread. Each file is up to 4GB. Befo=
re closing we call fdatasync. Sometimes the file ends up being corrupted. The=
 corruptions is in a form of a number ( more than 3k pages in one case) of ze=
ro filled pages.
> When this happens the file cannot be deleted from the client machine which =
created the file, even when the process which wrote the file completed succes=
sfully.
>=20
> The machines have about 128GB of memory, i think and probably network that =
leaves to be desired.
>=20
> My reproducer is currently tied up to our internal software, but i suspect =
setting the write_congested flag randomly should allow to reproduce the issue.
>=20
> Regards.
> Jacek Tomaka
>=20


