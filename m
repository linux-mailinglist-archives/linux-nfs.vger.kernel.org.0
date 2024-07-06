Return-Path: <linux-nfs+bounces-4670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC2929130
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 07:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B9D2834EF
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 05:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFEC179BD;
	Sat,  6 Jul 2024 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wPIHA1dX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="08GA2UAS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XEefc0O6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QhouyAjm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1FE17753
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245139; cv=none; b=OquPAVr8/kvCbiurC9QohCRG3yvLpGD3VTvn9t6JwakNWHDY7f/k1THnoJtB13WEl4PSe8e+/O/4xK7PSdtTGXf4PMe2h78eQjqJqmrwvITbfMaIQySu5hvi+tSbwPW6GnBcfpojxqNfrep37bfQnlLxPhx26ePBt5GxAbg9J70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245139; c=relaxed/simple;
	bh=HRqaIp93ZY0gFGL+0PnG/fE57JfcVcBMradIo8+6/+I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fWYTHOaMJ77DzqO0U9JKSUckm7TLUsFGeW4Q+2Mgo28wQZjU0sJCpz6uCSKsdZGXsMGDP3cJ387VC/O/J72tqsEOapJJwGMcCs/thUcoPvjh8BbS+rl/EnasDeP207LUzK9TXO81Lr53qjO7T2Xyz2hpQA9kPgttMrvat7FUm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wPIHA1dX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=08GA2UAS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XEefc0O6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QhouyAjm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 887071F8BF;
	Sat,  6 Jul 2024 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720245135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaZdIsrpUd0XevC32UegGpFwaKgqB9DZ4eTCHGLYTWM=;
	b=wPIHA1dXWas0My2odhfrEaDlCC5TUIY+qQ8sDwfPhoLkrl1L+hjYuz8fkfzvDOSOx5+5HP
	OLWqTFbbJB11sm+1Jk7fGH0X9HSmqWzaU0O//ZhWKs/l59BuDMddYX8Qsg9Y2mSMyPUnhX
	ZoFNRove5oUyZcwreF3IM+5uXBRuaeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720245135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaZdIsrpUd0XevC32UegGpFwaKgqB9DZ4eTCHGLYTWM=;
	b=08GA2UASCE5tKwvfwT/ayNC8B1Nf7UkvdliABJXxOV6Jul/q5elpyzMSza+VRHAks4FWxS
	ax2XeriQ/JV0q3BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XEefc0O6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QhouyAjm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720245134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaZdIsrpUd0XevC32UegGpFwaKgqB9DZ4eTCHGLYTWM=;
	b=XEefc0O6APTH/oH+kJm7+l3J6L4raN9X66cJOYmLjnYiWpha2WWuENZ+X7Z6DxSGEXmqey
	nRTeRKmmadm0lyp53l5ksbOKApH56qcl1vhvhCC9egik9BWvOcyJ8QQqRIBPujvDlg4seC
	LfJPsvJrHLHM5meP0Khe3m4CaUDpDrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720245134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaZdIsrpUd0XevC32UegGpFwaKgqB9DZ4eTCHGLYTWM=;
	b=QhouyAjmUm5BbYuR5Ny0dPM0dlYk/RiDB22fLUnq5NLWYk+9NRWbQETVBgNEk3iNtjX0wb
	TrAgbGMPNtVS4wCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EEE51379D;
	Sat,  6 Jul 2024 05:52:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZpCSMIrbiGYHdQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 06 Jul 2024 05:52:10 +0000
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
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Christoph Hellwig" <hch@infradead.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
In-reply-to: <ZojBAC3XYIee9wN2@kernel.org>
References: <>, <ZojBAC3XYIee9wN2@kernel.org>
Date: Sat, 06 Jul 2024 15:52:02 +1000
Message-id: <172024512210.11489.13288458153195942042@noble.neil.brown.name>
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 887071F8BF
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

On Sat, 06 Jul 2024, Mike Snitzer wrote:
> On Fri, Jul 05, 2024 at 02:59:31PM +0000, Chuck Lever III wrote:
> >=20
> >=20
> > > On Jul 5, 2024, at 10:36=E2=80=AFAM, Mike Snitzer <snitzer@kernel.org> =
wrote:
> > >=20
> > > On Fri, Jul 05, 2024 at 07:18:29AM -0700, Christoph Hellwig wrote:
> > >> On Fri, Jul 05, 2024 at 10:15:46AM -0400, Mike Snitzer wrote:
> > >>> NFSv3 is needed because NFSv3 is used to initiate IO to NFSv3 knfsd on
> > >>> the same host.
> > >>=20
> > >> That doesn't really bring is any further.  Why is it required?
> > >>=20
> > >> I think we'll just need to stop this discussion until we have reasonab=
le
> > >> documentation of the use cases and assumptions, because without that
> > >> we'll get hund up in dead loops.
> > >=20
> > > It _really_ isn't material to the core capability that localio provides.
> > > localio supporting NFSv3 is beneficial for NFSv3 users (NFSv3 in
> > > containers).
> > >=20
> > > Hammerspace needs localio to work with NFSv3 to assist with its "data
> > > movers" that run on the host (using nfs and nfsd).
> > >=20
> > > Please just remove yourself from the conversation if you cannot make
> > > sense of this.  If you'd like to be involved, put the work in to
> > > understand the code and be professional.
> >=20
> > Sorry, I can't make sense of this either, and I find the
> > personal attack here completely inappropriate (and a bit
> > hypocritical, to be honest).
>=20
> Hi Chuck,
>=20
> I'm out-gunned with this good-cop/bad-cop dynamic.  I was replying to
> Christoph.  Who has taken to feign incapable of understanding localio
> yet is perfectly OK with flexing like he is an authority on the topic.

Ad Hominem doesn't achieve anything useful.  Please stick with technical
arguments.  (They are the only ones I understand).

NeilBrown

