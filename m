Return-Path: <linux-nfs+bounces-8521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28469EC3FC
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 05:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C276E1666F8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 04:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865661BD9D5;
	Wed, 11 Dec 2024 04:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RBn10MZQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hjWZOyPu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xLoGarmj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RpD7iJk/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E471BD9CE
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 04:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733891208; cv=none; b=E/PCSu4KlMxqFZ9GuGrcIWmIJxfXUrDnE+QCx6GEAX5LFyXxeT7MKeNP6pXwcvmN60ufc2yhIYDOD3GzETkuy/PjHLhcwMHPJQSgayVJGdIQf2Iv0hCBcWk1NNEbw4xVQitUshvZsOX2G9bJEl4JpfOLoqshO61njCYLGmd1Tr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733891208; c=relaxed/simple;
	bh=kqibhjvQwYGtTrF7cbpd5pkE7PX9lsUcsgCShPGB0/4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C1o8UC/u7SQGt+gKxumVnTTmvF73Z1YgfC+5ZTzyEnh5zhbh6DzQGgkuJw3/wpscjDIVSTUX5KmKXMWuVd1jwTGqxoZz/MjBhdTxd9BisDBW8bg9y4sdwzk5Thc6wH/L8XYwa6m/yIX7SX8E73bn08enJVtB0MWOwxgmEjwId8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RBn10MZQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hjWZOyPu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xLoGarmj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RpD7iJk/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6EE921166;
	Wed, 11 Dec 2024 04:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733891205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B59BAuKDafYTSmDVwNf0u+gxNW5WDyFneMnXffEU+cs=;
	b=RBn10MZQyYKPneGp+C9m6Wa9Ncjtawp4lj715QzSwDMfWHxb1Da+fPUOEncl8W9H4l/wHI
	gWZcjYv/cplmTCNNwz2DxqajTaEWsHjMW9XPEqqR5R7U8fD/hHTK5sD30+eoTjUVgkN/iO
	jbafE5m1W7oszYrPXY+5y7Q/sgzBwJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733891205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B59BAuKDafYTSmDVwNf0u+gxNW5WDyFneMnXffEU+cs=;
	b=hjWZOyPu5Fdw6+l/yvCEBNdbxSzEiiOAsRwBIJ3GstI84md6MYF7lK5SEkckmFbZgTMzXV
	cZlXF8Cr4oHXHEAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xLoGarmj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="RpD7iJk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733891204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B59BAuKDafYTSmDVwNf0u+gxNW5WDyFneMnXffEU+cs=;
	b=xLoGarmjsosg2vl7fsNXLNGbeowod/TcYaSXRhbRioVfNftg+TvtRQbvc4ozuQt7Bhuw4l
	ry/r9D6cHciB9XIVv7iw9GGMDpLwdltN1rmaSTfO+VHsuBr1QSkoJuYn0N5nxFwHJUWYvw
	VrznyYJxptYLf2maok4z8Qdi39drE1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733891204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B59BAuKDafYTSmDVwNf0u+gxNW5WDyFneMnXffEU+cs=;
	b=RpD7iJk/FyYKpf9fDTzV2PX+SU09Ld4ukQ3zNBg4SLu/3kc7d126c7EwzT/QyCZ6Rewg8y
	35Y5fp2t7aUsNKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3BAF1344A;
	Wed, 11 Dec 2024 04:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UvczIYMUWWf8eQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Dec 2024 04:26:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 <CALXu0Udmn=AqRBAcBPf8=VAP3KN4f-vnEJFLg3OnkyRdT3b9rw@mail.gmail.com>
References:
 <>, <CALXu0Udmn=AqRBAcBPf8=VAP3KN4f-vnEJFLg3OnkyRdT3b9rw@mail.gmail.com>
Date: Wed, 11 Dec 2024 15:26:36 +1100
Message-id: <173389119653.1734440.2969556830872479972@noble.neil.brown.name>
X-Rspamd-Queue-Id: C6EE921166
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 10 Dec 2024, Cedric Blancher wrote:
> On Sun, 8 Dec 2024 at 23:12, NeilBrown <neilb@suse.de> wrote:
> > > +
> > > + /*
> > > + * |pnu.uctx->path| is in UTF-8, but we need the data
> > > + * in the current local locale's encoding, as mount(2)
> > > + * does not have something like a |MS_UTF8_SPEC| flag
> > > + * to indicate that the input path is in UTF-8,
> > > + * independently of the current locale
> > > + */
> >
> > I don't understand this comment at all.
> > mount(2) doesn't care about locale (as far as I know).  The "source" is
> > simply a string of bytes that it is up to the filesystem to interpret.
> > NFS will always interpret it as utf8.  So no conversion is needed.
> 
> Not all versions of NFS use UTF-8. For example if you have NFSv3 and
> the server runs ISO8859-16 (French), then the filenames are encoded
> using ISO8859-16, and the NFS client is assumed to use ISO8859-16 too.
> mount(2) has options to do filename encoding conversion
> NFSv4 is an improvement compared to NFSv3 because it uses UTF-8 on the
> wire, but if you use the (ANSSI/Clip-OS) nls=/iocharset= mount option
> you can enable filename encoding conversion there.

I cannot find any evidence that nfs supports iocharset- or nls=
Other filesystems do: fat, isofs, jfs, smb ntfs3 and others.
But not NFS.
nfs-utils doesn't appear to have any support either.

So I think that the string you pass on the mount command line, or in
/etc/fstab, will be passed unchanged over-the-wire to mountd (For NFSv3)
or passed to the kernel and thence to nfsd (for NFSv4).

Do you have evidence to prove otherwise?  i.e.  can you demonstrate a
case where changing the LOCALE causes a mount command that previously
worked to stop working?

Thanks,
NeilBrown

