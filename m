Return-Path: <linux-nfs+bounces-8955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD1A04AE2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A47188297E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE21F76AB;
	Tue,  7 Jan 2025 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x9Hq2QVs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K2deS73Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x9Hq2QVs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K2deS73Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778A1F63FE
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281223; cv=none; b=XJMmRDevlbusyjaWHkMNwqgRR527LP8UGUdJlgjylrdmGqDgCssdSr/Yy49hgkOhg8aRIlLgLGGshT6KVdQLbkGCpilNPL+B2x1G4ua4OW2RroiPDslDRLju/7coX3kPJZ5rt/WrDAYnm3hClqLgSoMWmMmOn5h8tdDBm0t3yCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281223; c=relaxed/simple;
	bh=AXugIeAnGjxqCCS7mgTKnCLS/4QJjWJ6H5YXnrwuuJM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CHKra7+x/Gp9RB6UI+WOkJISBmUwwI51TX+ubXEGAP1Vhg1S0jUfKtk0X7mSX5T8YRLLkmhjox2yH3+ZuQ8AhIELj5bAetT9k4RaJdcWfJQ9CqCUWj90NLprvZYZMkL9eX7xJbU/tm3II8c2EHO/fP7R2oejjYGz8ulgYylRYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x9Hq2QVs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K2deS73Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x9Hq2QVs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K2deS73Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 676091F391;
	Tue,  7 Jan 2025 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736281219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq41A2NRbOBRZWgpGNqbOltPVhdFrFCH37eaE0/1Ls0=;
	b=x9Hq2QVs+G/14yz8JSwYgxgN/3YIVV0o769ll88yUdaTIdlMaT35Yme6c94rqwBVBFRuT+
	63Fwn+bre03v3+W5mfkKBFHV6F5fTTJ1+FQdYiMdzrREg2mHz2o4prdJFJx8udbE+Ns6nP
	g7AjAjVeDiYGmkYijAZTFwfpBSRLkR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736281219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq41A2NRbOBRZWgpGNqbOltPVhdFrFCH37eaE0/1Ls0=;
	b=K2deS73Y6TN12ewN/qSBwLP2oZlARi/ffbOXz3M20J0qguGBKO1lKA03K5hrdJibel+/r3
	wni6BiIhW74E99Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736281219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq41A2NRbOBRZWgpGNqbOltPVhdFrFCH37eaE0/1Ls0=;
	b=x9Hq2QVs+G/14yz8JSwYgxgN/3YIVV0o769ll88yUdaTIdlMaT35Yme6c94rqwBVBFRuT+
	63Fwn+bre03v3+W5mfkKBFHV6F5fTTJ1+FQdYiMdzrREg2mHz2o4prdJFJx8udbE+Ns6nP
	g7AjAjVeDiYGmkYijAZTFwfpBSRLkR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736281219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq41A2NRbOBRZWgpGNqbOltPVhdFrFCH37eaE0/1Ls0=;
	b=K2deS73Y6TN12ewN/qSBwLP2oZlARi/ffbOXz3M20J0qguGBKO1lKA03K5hrdJibel+/r3
	wni6BiIhW74E99Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A65C13A6A;
	Tue,  7 Jan 2025 20:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WkBoM4GMfWeIIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 07 Jan 2025 20:20:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christopher Bii" <christopherbii@hyub.org>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
In-reply-to: <1395c749-90a1-4491-8f7b-7460e896e3c5@hyub.org>
References: <>, <1395c749-90a1-4491-8f7b-7460e896e3c5@hyub.org>
Date: Wed, 08 Jan 2025 07:20:09 +1100
Message-id: <173628120988.22054.17648543209352398934@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 08 Jan 2025, Christopher Bii wrote:
> Hello,
>=20
> You are correct, it would be a configuration error. But the issue is=20
> that when a rootdir is set, export entries are assumed to be relative to=20
> the rootdir path, but this isn't the case.=20

The above statement directly contradicts the documentation which says
that all exports *are* relative to rootdir (more accurately: the path is
prefixed with the rootdir).  So if true it is clearly a bug that needs
to be fixed, and would have nothing to do with symlinks.

But I don't think it is true.

What you have been saying is that if the export point - which is at
$rootdir/$exportpath - is a symlink, then that symlink is resolved
without reference to the rootdir.  This is true but I don't see why it
is a problem.

When you create /etc/exports (or run exportfs) you should only identify
directories, never symlinks.  And all ancestors of these directories
should only be modifiable by privileged processes.

What is your use case for exporting a symlink, or exporting anything in
a directory that is not restricted to privileged users?

Thanks,
NeilBrown


>                                            So my rootdir can have a=20
> restrictive set of permissions, but the export entry path relative to=20
> the system* rootdir may have an entirely different set of permissions.=20
> Or even with restrictive permissions it could be accidentally or=20
> maliciously symlinked.
>=20
> Christopher Bii
>=20
> NeilBrown wrote:
> > On Sat, 07 Dec 2024, Christopher Bii wrote:
> >> Hello,
> >>
> >> It is hinted in the configuration files that an attacker could gain acce=
ss
> >> to arbitrary folders by guessing symlink paths that match exported dirs,
> >> but this is not the case. They can get access to the root export with
> >> certainty by simply symlinking to "../../../../../../../", which will
> >> always return "/".
> >>
> >> This is due to realpath() being called in the main thread which isn't
> >> chrooted, concatenating the result with the export root to create the
> >> export entry's final absolute path which the kernel then exports.
> >>
> >> PS: I already sent this patch to the mailing list about the same subject
> >> but it was poorly formatted. Changes were merged into a single commit. I
> >> have broken it up into smaller commits and made the patch into a single
> >> thread. Pardon the mistake, first contribution.
> >=20
> > I'm still not convinced there is a vulnerability here, but I might have
> > missed part of the conversation...
> >=20
> > Could you please spell out in detail the threat scenario that we are
> > trying to defend against?
> >=20
> >  From my perspective: if you export a path that a non-privileged user can
> > modify, then that is a configuration error.  We should not try to make
> > it "safe".  We could possibly try to detect that situation and fail the
> > export when it happens.
> >=20
> > Why is that perspective not correct?  If this has already been
> > discussed, please point me to the relevant email.
> >=20
> > Thanks,
> > NeilBrown
>=20
>=20


