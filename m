Return-Path: <linux-nfs+bounces-8765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2AE9FC2B2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 00:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026BE1883D0F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825A212F86;
	Tue, 24 Dec 2024 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nBYXCr4Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SjkuPZEm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nBYXCr4Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SjkuPZEm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB5212D66
	for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735081210; cv=none; b=k967PqOQpjjjZfJgABY/Ayb1jYza+P6utyuSUlhi/tYW4oHn/3X1mNmWquOoANHpQLX9bsr4hpe1tFMBw2GuxK1nw7g4GIT1X+QkM4yJX9RCADHUb/f/SfxuEz7CgMjcbvT4yGql4dbdlUz3CMRXuW99bxDcmWNH+C/WmxiIgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735081210; c=relaxed/simple;
	bh=SowZ6YYRqB6uLi+iZJ58QWl+C8hoF9lI6v9xZPzg+lo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=g6w6rfy3drustGMrB0T8zCTTTZxVfdDCWDqlsgMh3Aq5qBKRt/3poqCUWlAXs83C4oF0Vfzm0nGdMcGe1AxnSpSAIIxPP2mxKfC5rfTYDQI4gbX6iJ4fdXVudyAkF6TAW+DiZbW67GFWMD+AWqVD7d6UoY2q1JRiFMB+IGKgd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nBYXCr4Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SjkuPZEm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nBYXCr4Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SjkuPZEm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 701C23376C;
	Tue, 24 Dec 2024 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735081200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuwPQz2JXrRadJnFQgkKUSW0srsL/TyTgoBTPOKSep0=;
	b=nBYXCr4YEMsZ/ydCy/izttpB9tJPXYd9jMnsTWPQrANUmtu5x9Gm5ayyu0wtkX83NQzQ5r
	3Apapq12qqU3HrJRwO+Ps4qQRzDkE/xL3udKuT88Cb2pJZvjbME7bFOWwcXOLrmfZkitFg
	/Jug6nPhhoteDG2szJfr4YJd4CcjxAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735081200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuwPQz2JXrRadJnFQgkKUSW0srsL/TyTgoBTPOKSep0=;
	b=SjkuPZEmyfQcuV1/vQJXmUm/NG4mU67tmB2kHe+oZQztmkrIUiwH+5i4JzS5nBgGP3gCcS
	8U93b38TSCZRC3Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nBYXCr4Y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SjkuPZEm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735081200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuwPQz2JXrRadJnFQgkKUSW0srsL/TyTgoBTPOKSep0=;
	b=nBYXCr4YEMsZ/ydCy/izttpB9tJPXYd9jMnsTWPQrANUmtu5x9Gm5ayyu0wtkX83NQzQ5r
	3Apapq12qqU3HrJRwO+Ps4qQRzDkE/xL3udKuT88Cb2pJZvjbME7bFOWwcXOLrmfZkitFg
	/Jug6nPhhoteDG2szJfr4YJd4CcjxAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735081200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuwPQz2JXrRadJnFQgkKUSW0srsL/TyTgoBTPOKSep0=;
	b=SjkuPZEmyfQcuV1/vQJXmUm/NG4mU67tmB2kHe+oZQztmkrIUiwH+5i4JzS5nBgGP3gCcS
	8U93b38TSCZRC3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8469D13999;
	Tue, 24 Dec 2024 22:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nreyDu88a2cLWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 24 Dec 2024 22:59:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Cedric Blancher" <cedric.blancher@gmail.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
In-reply-to:
 <CALXu0UdNBHzLSXVVXOeH1sm6GvB5sqeL=2bRrY8nCxz1gunedA@mail.gmail.com>
References:
 <>, <CALXu0UdNBHzLSXVVXOeH1sm6GvB5sqeL=2bRrY8nCxz1gunedA@mail.gmail.com>
Date: Wed, 25 Dec 2024 09:59:56 +1100
Message-id: <173508119654.11072.10186398747638680920@noble.neil.brown.name>
X-Rspamd-Queue-Id: 701C23376C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 20 Dec 2024, Cedric Blancher wrote:
> On Wed, 11 Dec 2024 at 05:26, NeilBrown <neilb@suse.de> wrote:
> >
> > On Tue, 10 Dec 2024, Cedric Blancher wrote:
> > > On Sun, 8 Dec 2024 at 23:12, NeilBrown <neilb@suse.de> wrote:
> > > > > +
> > > > > + /*
> > > > > + * |pnu.uctx->path| is in UTF-8, but we need the data
> > > > > + * in the current local locale's encoding, as mount(2)
> > > > > + * does not have something like a |MS_UTF8_SPEC| flag
> > > > > + * to indicate that the input path is in UTF-8,
> > > > > + * independently of the current locale
> > > > > + */
> > > >
> > > > I don't understand this comment at all.
> > > > mount(2) doesn't care about locale (as far as I know).  The "source" =
is
> > > > simply a string of bytes that it is up to the filesystem to interpret.
> > > > NFS will always interpret it as utf8.  So no conversion is needed.
> > >
> > > Not all versions of NFS use UTF-8. For example if you have NFSv3 and
> > > the server runs ISO8859-16 (French), then the filenames are encoded
> > > using ISO8859-16, and the NFS client is assumed to use ISO8859-16 too.
> > > mount(2) has options to do filename encoding conversion
> > > NFSv4 is an improvement compared to NFSv3 because it uses UTF-8 on the
> > > wire, but if you use the (ANSSI/Clip-OS) nls=3D/iocharset=3D mount opti=
on
> > > you can enable filename encoding conversion there.
> >
> > I cannot find any evidence that nfs supports iocharset- or nls=3D
> > Other filesystems do: fat, isofs, jfs, smb ntfs3 and others.
> > But not NFS.
> > nfs-utils doesn't appear to have any support either.
>=20
> Gentoo-based ClipOS&RED FLAG Linux certainly support that, first one
> for iso8859-16 mapping, and the second for GB18030. I don't know if
> this is in mainline or not.
> In either case mapping to local encoding is required, or as Roland's
> comment indicates a mount syscall parameter to indicate the encoding
> of the export path string.
>=20
> >
> > So I think that the string you pass on the mount command line, or in
> > /etc/fstab, will be passed unchanged over-the-wire to mountd (For NFSv3)
> > or passed to the kernel and thence to nfsd (for NFSv4).
> >
> > Do you have evidence to prove otherwise?  i.e.  can you demonstrate a
> > case where changing the LOCALE causes a mount command that previously
> > worked to stop working?
>=20
> For SMB certainly yes. For NFSv3 certainly yes too, for example if the
> NFS server runs on a filesystem with a different encoding than the
> client. Might be even a subset or superset of the encoding used by the
> other side, e.g. server uses Level GBK/5, but client only Level GBK/3.

When I said "can you demonstrate" what I really meant was "will you
please demonstrate for us".

i.e.  could you show us a mount command that works, but when you change
LANG (or whatever) to choose a different locale, it doesn't work.  Show
us the command and the result in both cases include explicit setting of
the LOCALE in each case.  Add "-v" so we can see some of what is
happening "under the hood".

As the charset you will be using will not be unicode/utf-8 it might be
tricky to reliably copy/paste the interaction into an email.  Maybe
copy/paste it into a file, check that the file contains the correct
bytes, then attached that file to an email.

It's not that I don't believe you.  It is that fine details can
sometimes have outsized importance and I want to have as much
visibility into what is actually happening as possible.

Thanks,
NeilBrown

