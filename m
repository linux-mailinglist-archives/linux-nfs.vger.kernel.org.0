Return-Path: <linux-nfs+bounces-2097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B086A2F4
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBBD28EAF7
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271155C28;
	Tue, 27 Feb 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DMI3ksqi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="akepDCGS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DMI3ksqi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="akepDCGS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6E1E86C
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074806; cv=none; b=m55m9tgt/VkwB8RuS+6K/DuLPJUbjo2sVIMiXD6tjv78Q2LKHl5j0GzLbjA4TYeOKS7+kcv7l8KB3aNUQkGcu+f0syr7WDNQKpEtP0/d+1XVz5XAZIhSHTkTGiGax8frdSFuPc91rCZDICHRbnldM/ATBt0i87NeIg1R//WC3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074806; c=relaxed/simple;
	bh=z3CJzCDgGHPJP2a5E3wYCbCOEoPA/zapeiovSJuehVU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qcrKjRce/ASihLoC89LcbBNQfOt90yatSA17+A7PbU+LkycR3f+WxLvIi2jW303LpJy2I3ROlB8IHKpHD23JEz3TxkCR1bbEYN7soEXut+ow+RjXf93CcDSN4EVCA44H/INtddAo6r/aAzSAuA86cbJXkCU5x72R1UPNVKLSWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DMI3ksqi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=akepDCGS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DMI3ksqi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=akepDCGS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29F161FD9C;
	Tue, 27 Feb 2024 23:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709074802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/E0BoTTpLwexeE2Errx/jHp+OhVd/uD+nqTrFaFWUE=;
	b=DMI3ksqiP6qvyVFfZt94dtIFNbgoWpzWj4S/YoRS1kIMMMS+l78qjbe3llsHi8QCyJzqnK
	7cuJKx3OXHP0iJWoBF07DSDU7zJCXp0CYWg3iQnMY6w1bB0xgfiPgZoTWzijreAdEyqgWS
	cp6V11xbyv2Ofs+TuQ+Ltqg+qqqtw+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709074802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/E0BoTTpLwexeE2Errx/jHp+OhVd/uD+nqTrFaFWUE=;
	b=akepDCGSLww8SsdYkbOcZ9Qbfg4PACH6bDS4mXRxqYR5+aOoGgo/Djvkcl16Hvc3FxfZBa
	MJyQwAcR6SqcJZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709074802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/E0BoTTpLwexeE2Errx/jHp+OhVd/uD+nqTrFaFWUE=;
	b=DMI3ksqiP6qvyVFfZt94dtIFNbgoWpzWj4S/YoRS1kIMMMS+l78qjbe3llsHi8QCyJzqnK
	7cuJKx3OXHP0iJWoBF07DSDU7zJCXp0CYWg3iQnMY6w1bB0xgfiPgZoTWzijreAdEyqgWS
	cp6V11xbyv2Ofs+TuQ+Ltqg+qqqtw+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709074802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/E0BoTTpLwexeE2Errx/jHp+OhVd/uD+nqTrFaFWUE=;
	b=akepDCGSLww8SsdYkbOcZ9Qbfg4PACH6bDS4mXRxqYR5+aOoGgo/Djvkcl16Hvc3FxfZBa
	MJyQwAcR6SqcJZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4732D13A58;
	Tue, 27 Feb 2024 22:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjIJN29p3mWsLwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Feb 2024 22:59:59 +0000
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
Cc: "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
 "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS data corruption on congested network
In-reply-to: <flfkkydzpicimncinmba@mlpw>
References: <ujvntmhlfharduyanjob@tgqn>,
 <170890314859.24797.16728369357798855399@noble.neil.brown.name>,
 <flfkkydzpicimncinmba@mlpw>
Date: Wed, 28 Feb 2024 09:59:56 +1100
Message-id: <170907479656.24797.5574165235102920031@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DMI3ksqi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=akepDCGS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.46 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.15)[-0.764];
	 FREEMAIL_TO(0.00)[poczta.fm];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[poczta.fm];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.46
X-Rspamd-Queue-Id: 29F161FD9C
X-Spam-Flag: NO

On Mon, 26 Feb 2024, Jacek Tomaka wrote:
> Hi NeilBrown,=20
>=20
> > though if your kernel is older than 6.3, that will be
> >          redirty_for_writepage(wbc, page);
>=20
> Things are looking good. I have ran it on 15 machines for good couple of ho=
urs and i do not see the problem. Usually i would see it after 1-3 iterations=
 but now they are reaching 20 iterations without the problem.
>=20
> Thank you for the fix.

Thanks for testing!  I'll get the fix submitted.

NeilBrown


> Regards.
> Jacek Tomaka
>=20
> Temat: Re: NFS data corruption on congested network
> Data: 2024-02-26 0:19
> Nadawca: "NeilBrown" &lt;neilb@suse.de>
> Adresat: "Jacek Tomaka" &lt;Jacek.Tomaka@poczta.fm>;=20
> DW: trond.myklebust@hammerspace.com; anna.schumaker@netapp.com; linux-nfs@v=
ger.kernel.org;=20
>=20
> >=20
> >> On Mon, 26 Feb 2024, NeilBrown wrote:
> >> On Fri, 23 Feb 2024, Jacek Tomaka wrote:
> >>> Hello,
> >>> I ran into an issue where the NFS file ends up being corrupted on
> disk. We started noticing it on certain, quite old hardware after upgrading
> OS from Centos 6 to Rocky 9.2. We do see it on Rocky 9.3 but not on 9.1.
> >>>=20
> >>> After some investigation we have reasons to believe that the
> change was introduced by the following commit:=20
> >>>
> https://github.com/torvalds/linux/commit/6df25e58532be7a4cd6fb15bcd85805947=
402d91
> >>=20
> >> Thanks for the report.
> >> Can you try a change to your kernel?
> >>=20
> >> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> >> index bb79d3a886ae..08a787147bd2 100644
> >> --- a/fs/nfs/write.c
> >> +++ b/fs/nfs/write.c
> >> @@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct folio
> *folio,
> >>  	int err;
> >> =20
> >>  	if (wbc->sync_mode =3D=3D WB_SYNC_NONE &amp;&amp;
> >> -	    NFS_SERVER(inode)->write_congested)
> >> +	    NFS_SERVER(inode)->write_congested) {
> >> +		folio_redirty_for_writepage(wbc, folio);
> >>  		return AOP_WRITEPAGE_ACTIVATE;
> >> +	}
> >> =20
> >>  	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
> >>  	nfs_pageio_init_write(&amp;pgio, inode, 0, false,
> >=20
> > Actually this is only needed before linux 6.8 as only nfs_writepage()
> > can call nfs_writepage_locked() with sync_mode of WB_SYNC_NONE.
> > So v5.18 through v6.7 might need fixing.
> >=20
> > NeilBrown
> >=20
> >=20
> >>=20
> >>=20
> >> though if your kernel is older than 6.3, that will be
> >>          redirty_for_writepage(wbc, page);
> >>=20
> >> Thanks,
> >> NeilBrown
> >>=20
> >>=20
> >>>=20
> >>> We write a number of files on a single thread. Each file is up to
> 4GB. Before closing we call fdatasync. Sometimes the file ends up being
> corrupted. The corruptions is in a form of a number ( more than 3k pages in
> one case) of zero filled pages.
> >>> When this happens the file cannot be deleted from the client
> machine which created the file, even when the process which wrote the file
> completed successfully.
> >>>=20
> >>> The machines have about 128GB of memory, i think and probably
> network that leaves to be desired.
> >>>=20
> >>> My reproducer is currently tied up to our internal software, but i
> suspect setting the write_congested flag randomly should allow to reproduce
> the issue.
> >>>=20
> >>> Regards.
> >>> Jacek Tomaka
> >>>=20
> >>=20
> >>=20
> >>=20
> >=20
> >=20
> >=20
>=20


