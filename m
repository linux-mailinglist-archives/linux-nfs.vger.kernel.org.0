Return-Path: <linux-nfs+bounces-8961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E09A04B7A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 22:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14AB16695A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D941F3D47;
	Tue,  7 Jan 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EyaiQ36q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5x5MioZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EyaiQ36q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5x5MioZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009231D63EB
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284719; cv=none; b=tQe2FOyR+0xdXD2aARPnU8sXuanDEcISYaqIXKXZeuPxLFlKSqOOLnyjLD16OpcXyXN1sZtAcAtJtvt+AHPn2LJtIZBBTV+p+cXpLU1CgozzSZZsvKpHof4IFWP+3jQm5TYpOM3Vwg34vw6fNuZ6QsP1IyEW5rJIcFXmtTSHXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284719; c=relaxed/simple;
	bh=pkW/ZN3RsV3MWCxR9nK2aK2VVr0RkfwPf+YpboVJXFg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=V8WNO7Bx1SWCqlmTe+T0ffCNLJlkFX9JpPdsaoRVvDuGHxmKW0FQnbgzm6nWGifvF/ihBn57b4HPlunUE3VKqueFJ/DFpIh8Xogcz7tLp00AxbBsbNcT99Ctmyg9rFSfPulSGI75BKE3atFUkJ0c4QKoSR/hKmmkoKpdFFE8RDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EyaiQ36q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5x5MioZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EyaiQ36q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5x5MioZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29DBD1F385;
	Tue,  7 Jan 2025 21:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736284716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yN3AW2CNmQRdG1J1ctVvY4nAGCHQ1XOooeUwGBjiG4s=;
	b=EyaiQ36qhFJhjB1lRJWlZzdCNyfuXFpQkdIAbrzL+pLHIO00fUsYQJfE44Yp8VPtoTasYg
	amnywlyyAHk9/t2VF2oMKf0X7DkIPTqzHJqUOibWJ3ldmqG6JfQELycEqeeKegouBOzMUi
	huAEzpXjdPXpLkahj5Gj6uCKrlfYof4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736284716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yN3AW2CNmQRdG1J1ctVvY4nAGCHQ1XOooeUwGBjiG4s=;
	b=F5x5MioZHbwW5PSOdPJmFvKXnLFCk6Xexyz7dBKNGImwJAifvFKy6tAx6N/62szpyfXb9G
	7jrJ4b77ca/BJwCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736284716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yN3AW2CNmQRdG1J1ctVvY4nAGCHQ1XOooeUwGBjiG4s=;
	b=EyaiQ36qhFJhjB1lRJWlZzdCNyfuXFpQkdIAbrzL+pLHIO00fUsYQJfE44Yp8VPtoTasYg
	amnywlyyAHk9/t2VF2oMKf0X7DkIPTqzHJqUOibWJ3ldmqG6JfQELycEqeeKegouBOzMUi
	huAEzpXjdPXpLkahj5Gj6uCKrlfYof4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736284716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yN3AW2CNmQRdG1J1ctVvY4nAGCHQ1XOooeUwGBjiG4s=;
	b=F5x5MioZHbwW5PSOdPJmFvKXnLFCk6Xexyz7dBKNGImwJAifvFKy6tAx6N/62szpyfXb9G
	7jrJ4b77ca/BJwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E554613763;
	Tue,  7 Jan 2025 21:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4TL5JSqafWdrLwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 07 Jan 2025 21:18:34 +0000
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
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
In-reply-to: <f6aa9f24-777d-4e22-a876-07e1a72b47f8@hyub.org>
References: <>, <f6aa9f24-777d-4e22-a876-07e1a72b47f8@hyub.org>
Date: Wed, 08 Jan 2025 08:18:31 +1100
Message-id: <173628471159.22054.14955963398487620158@noble.neil.brown.name>
X-Spam-Level: 
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
X-Spam-Score: -4.30
X-Spam-Flag: NO


(adding back steved and linux-nfs)

On Wed, 08 Jan 2025, Christopher Bii wrote:
> I have a $rootdir set.
> I export $rootdir/$export_entry
> If /$export_entry exists. It will take whatever path that is and prepend=20
> it to rootdir as the export passed to the kernel.
>=20
> $ rootdir=3D"/export"
> $ exportentry_1=3D"/my_export"
>=20
> # exportutils takes the path at exportentry_1, runs it through
> # real_path() and concatenates the result to $rootdir. If it fails and
> # the path doesn't exist. It will still concatenate whatever the entry
> # was. So in the event realpath($exportentry_1) =3D=3D NULL.
> # $rootdir/$exportentry_1 will be sent to the kernel as the path to
> # export. But take this situation
>=20
> $ file $exportentry_1
>  > /my_export: symbolic link to "../../../"
>=20
> # realpath($exportentry_1) =3D=3D "/". So the entry passed to the kernel is
> # $rootdir/
>=20
> Is it clearer?

Maybe - thanks.
You say
  "exportutils takes the path at exportentry_1, runs it through
  # real_path() and concatenates the result to $rootdir."

assuming that is correct (I haven't checked the code but have no reason
to doubt you), then it seems that the fix is to prepend $rootdir
*before* running it through real_path() - then checking it still starts
with $rootdir.
Would that fix the problem?

Your patch set seems much more complex than that.

thanks,
NeilBrown


>=20
> NeilBrown wrote:
> > On Wed, 08 Jan 2025, Christopher Bii wrote:
> >> Hello,
> >>
> >> You are correct, it would be a configuration error. But the issue is
> >> that when a rootdir is set, export entries are assumed to be relative to
> >> the rootdir path, but this isn't the case.
> >=20
> > The above statement directly contradicts the documentation which says
> > that all exports *are* relative to rootdir (more accurately: the path is
> > prefixed with the rootdir).  So if true it is clearly a bug that needs
> > to be fixed, and would have nothing to do with symlinks.
> >=20
> > But I don't think it is true.
> >=20
> > What you have been saying is that if the export point - which is at
> > $rootdir/$exportpath - is a symlink, then that symlink is resolved
> > without reference to the rootdir.  This is true but I don't see why it
> > is a problem.
> >=20
> > When you create /etc/exports (or run exportfs) you should only identify
> > directories, never symlinks.  And all ancestors of these directories
> > should only be modifiable by privileged processes.
> >=20
> > What is your use case for exporting a symlink, or exporting anything in
> > a directory that is not restricted to privileged users?
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> >>                                             So my rootdir can have a
> >> restrictive set of permissions, but the export entry path relative to
> >> the system* rootdir may have an entirely different set of permissions.
> >> Or even with restrictive permissions it could be accidentally or
> >> maliciously symlinked.
> >>
> >> Christopher Bii
> >>
> >> NeilBrown wrote:
> >>> On Sat, 07 Dec 2024, Christopher Bii wrote:
> >>>> Hello,
> >>>>
> >>>> It is hinted in the configuration files that an attacker could gain ac=
cess
> >>>> to arbitrary folders by guessing symlink paths that match exported dir=
s,
> >>>> but this is not the case. They can get access to the root export with
> >>>> certainty by simply symlinking to "../../../../../../../", which will
> >>>> always return "/".
> >>>>
> >>>> This is due to realpath() being called in the main thread which isn't
> >>>> chrooted, concatenating the result with the export root to create the
> >>>> export entry's final absolute path which the kernel then exports.
> >>>>
> >>>> PS: I already sent this patch to the mailing list about the same subje=
ct
> >>>> but it was poorly formatted. Changes were merged into a single commit.=
 I
> >>>> have broken it up into smaller commits and made the patch into a single
> >>>> thread. Pardon the mistake, first contribution.
> >>>
> >>> I'm still not convinced there is a vulnerability here, but I might have
> >>> missed part of the conversation...
> >>>
> >>> Could you please spell out in detail the threat scenario that we are
> >>> trying to defend against?
> >>>
> >>>   From my perspective: if you export a path that a non-privileged user =
can
> >>> modify, then that is a configuration error.  We should not try to make
> >>> it "safe".  We could possibly try to detect that situation and fail the
> >>> export when it happens.
> >>>
> >>> Why is that perspective not correct?  If this has already been
> >>> discussed, please point me to the relevant email.
> >>>
> >>> Thanks,
> >>> NeilBrown
> >>
> >>
> >=20
>=20
>=20


