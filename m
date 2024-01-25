Return-Path: <linux-nfs+bounces-1445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE883CF8C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 23:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501E0B20EC8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395A1118E;
	Thu, 25 Jan 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ik+omz3T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ka5P7m+I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ik+omz3T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ka5P7m+I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D610A29;
	Thu, 25 Jan 2024 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222654; cv=none; b=LU5EzwTcdqiAyuXD7nE5H8wP2Tf3wsl4f92LQm/a8Gl5qMK73FnQYpOcpfFNH4SpLCtX36KemUOv57LmxxVYw8fFmiF8TYHF8sB8s2sPtvO7vF6bYwbXX3+9+iJgpr2fIWnNSvNb/3toNnSENzppWJrDjZZ0UdRXQMQXZlkone4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222654; c=relaxed/simple;
	bh=bEcLKnoiDuJUThr908B6hLtc7qrRem81+ep4jOM4sTQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CfC+hba7ecmVpvMYAmfgGPXtFDCT2L4n7sZChmssy/PiyU3UzVd4O/GyskwjGoz/DeEFyWPHm8tfGuXZNxL2vZATWbTyf6pFza9X4sTURLZNuSd7C+iCcz/jyuHqdYIAEPIGLHsL03UHY8s96QhQwIoOTM9NhpPZkWqdwOx5U0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ik+omz3T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ka5P7m+I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ik+omz3T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ka5P7m+I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EBAF1F8B4;
	Thu, 25 Jan 2024 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706222650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOAX1EJCAQlbflRwiz0hShrT1k9LHp6phR0HRqRWqjk=;
	b=Ik+omz3Tun+0p8h/kguRmxn4+hHyZouhtT7G3+S+z7n095Nijkr67xox8iW0e11vKxcG1m
	AN5LmNTEq9VTpVA2kci6MHhuqs26wpNqbzB2tyGKPT+VNoWUkmYtC47CM9QPGE21/r2awI
	u61NcbzsyRaP+TtPgBu5H5cztkjwAzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706222650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOAX1EJCAQlbflRwiz0hShrT1k9LHp6phR0HRqRWqjk=;
	b=Ka5P7m+I43U4wmGusxkAzGI8f11UHEC+wuBC7KcqWcIgDeAqoW5eQjzwktaSTBj3kRFV10
	iAEhe4XFOHJUyyCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706222650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOAX1EJCAQlbflRwiz0hShrT1k9LHp6phR0HRqRWqjk=;
	b=Ik+omz3Tun+0p8h/kguRmxn4+hHyZouhtT7G3+S+z7n095Nijkr67xox8iW0e11vKxcG1m
	AN5LmNTEq9VTpVA2kci6MHhuqs26wpNqbzB2tyGKPT+VNoWUkmYtC47CM9QPGE21/r2awI
	u61NcbzsyRaP+TtPgBu5H5cztkjwAzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706222650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOAX1EJCAQlbflRwiz0hShrT1k9LHp6phR0HRqRWqjk=;
	b=Ka5P7m+I43U4wmGusxkAzGI8f11UHEC+wuBC7KcqWcIgDeAqoW5eQjzwktaSTBj3kRFV10
	iAEhe4XFOHJUyyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEFA3134C3;
	Thu, 25 Jan 2024 22:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l9pZJTfksmULYwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 25 Jan 2024 22:44:07 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
In-reply-to: <917EC07C-C9D9-4CF2-9ACB-DCA2676DFF67@oracle.com>
References: <cover.1705771400.git.lorenzo@kernel.org>,
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>,
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>,
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>,
 <Za7zHvPJdei/vWm4@tissot.1015granger.net>, <Za-N6BxOMXTGyxmW@lore-desk>,
 <85b02061798a1b750a87b0302681b86651d0c7a3.camel@kernel.org>,
 <Za-9P0NjlIsc1PcE@lore-desk>,
 <3f035d3bc494ec03b83ae237e407c42f2ddc4c53.camel@kernel.org>,
 <ZbDdzwvP6-O2zosC@lore-desk>,
 <8fabd83caa0d44369853a4040a89c069f9b0f935.camel@kernel.org>,
 <917EC07C-C9D9-4CF2-9ACB-DCA2676DFF67@oracle.com>
Date: Fri, 26 Jan 2024 09:44:01 +1100
Message-id: <170622264103.21664.16941742935452333478@noble.neil.brown.name>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ik+omz3T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ka5P7m+I
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.46)[0.820];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 TO_DN_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.03%]
X-Spam-Score: 1.15
X-Rspamd-Queue-Id: 7EBAF1F8B4
X-Spam-Flag: NO

On Thu, 25 Jan 2024, Chuck Lever III wrote:
>=20
>=20
> > On Jan 24, 2024, at 6:24=E2=80=AFAM, Jeff Layton <jlayton@kernel.org> wro=
te:
> >=20
> > On Wed, 2024-01-24 at 10:52 +0100, Lorenzo Bianconi wrote:
> >> [...]
> >>>=20
> >>> That's a great question. We do need to properly support the -H option to
> >>> rpc.nfsd. What we do today is look up the hostname or address using
> >>> getaddrinfo, and then open a listening socket for that address and then
> >>> pass that fd down to the kernel, which I think then takes the socket and
> >>> sticks it on sv_permsocks.
> >>>=20
> >>> All of that seems a bit klunky. Ideally, I'd say the best thing would be
> >>> to allow userland to pass the sockaddr we look up directly via netlink,
> >>> and then let the kernel open the socket. That will probably mean
> >>> refactoring some of the svc_xprt_create machinery to take a sockaddr,
> >>> but I don't think it looks too hard to do.
> >>=20
> >> Do we already have a specific use case for it? I think we can even add it
> >> later when we have a defined use case for it on top of the current serie=
s.
> >>=20
> >=20
> > Yes:
> >=20
> > rpc.nfsd -H makes nfsd listen on a particular address and port. By
> > passing down the sockaddr instead of an already-opened socket
> > descriptor, we can achieve the goal without having to open sockets in
> > userland.
>=20
> Tearing down a listener that was created that way would be a
> use case for:

Only if it was actually useful.
Have you *ever* wanted to do that?  Or heard from anyone else who did?

NeilBrown


>=20
> > Do we ever want/need to remove listening sockets?
> > Normal practice when making any changes is to stop and restart where
> > "stop" removes all sockets, unexports all filesystems, disables all
> > versions.
>=20
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20


