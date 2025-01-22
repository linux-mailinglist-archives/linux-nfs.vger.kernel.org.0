Return-Path: <linux-nfs+bounces-9502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D933FA19A5F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983941883D69
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11F1C5D64;
	Wed, 22 Jan 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ossHRVNh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0oL6Xm5o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NZOUJ0vW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YAQJAQJh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879611B6CE0
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581170; cv=none; b=NikaAfPwc2+qjxcOVvleNzvyvz7/N3fPcshqU9beA4y9v7j6/uUzfT80TlCNVUL9ZxabVTmkqs232OB+JQrraoW5zyvj7r9IOUo1I+vHohqU7z4wtakUY+7Ae3IfA+COxAsASWpWbYEy7nkivyFSZbGyG/XGFGBuJWfvgp1bKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581170; c=relaxed/simple;
	bh=MXxBF2aRTcifvGIxByUXDxpP9+HJ95S8CvP3/DAU64A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KbzR8v3NBpEbI/QVd2jPHvbl8cu+Ur7R3/SY7rmWn6/iUcZ00NH10puP9xrD35c2fcXrWr669+YuyYsxvGAY6UlTwhp1QlcGvoC8dwe+Rp1xu29lW7qpgxTh0vrpRo128BZIklf05gcg5NTcdCbLB5Hild5sATEnTXFxHVJ2dUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ossHRVNh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0oL6Xm5o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NZOUJ0vW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YAQJAQJh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 588B121162;
	Wed, 22 Jan 2025 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737581165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Vfi0kZwTsBb+UpLdkhXx2vjMzkhXagBKr+AYu3PfoY=;
	b=ossHRVNhFJyJ6gVJkIWkUuD94qHEVF2khJRIG0vO5F+nhQ+AX+7C2ev3X2u+qmT2+3RznK
	CfxCtMzuKDXxXdlZyM5BKMtsx2EbhB8TaKONeq/y9YnTJzNEBesMRgVexA/oWcZxguAGBi
	e77eOZ19SJwNsL1hZyhVzd9MGD2kCbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737581165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Vfi0kZwTsBb+UpLdkhXx2vjMzkhXagBKr+AYu3PfoY=;
	b=0oL6Xm5oG4A1MHtuLNAUKcrFckZa1S/wW23+hCzbz7De4UjITkL3CMhMNy2leU225mn8XB
	UJ5YGO8HId38HfCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737581163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Vfi0kZwTsBb+UpLdkhXx2vjMzkhXagBKr+AYu3PfoY=;
	b=NZOUJ0vWZ/gpEDoL9a4lxelXVvdCi9tNE0qhjUFtSDo5a+Rg9PM3DfuS3+Y7k7kxWkjJvc
	AliMInLXmtaU1gKCsFJEOFmvl2/4WUXpuBt1iHIMIwgMlHFi527bxqHyogXbWJBfgzIbcG
	5rMgjpJiOfyUX1xI/nlX7usUKWD7/64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737581163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Vfi0kZwTsBb+UpLdkhXx2vjMzkhXagBKr+AYu3PfoY=;
	b=YAQJAQJhAlYp6Oaqhzt/kUL80t7PVlpDkXIyLTRRYMP0ADWIHEC+YUSCaL8Nh6/3mTIeP8
	gRQ/CSK6itF9HdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C86DC1397D;
	Wed, 22 Jan 2025 21:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGO6HmlikWflEwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 21:26:01 +0000
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
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 04/11] nfs: combine NFS_LAYOUT_RETURN and NFS_LAYOUT_RETURN_LOCK
In-reply-to: <Z5FY36JV1n9qgGMP@kernel.org>
References: <>, <Z5FY36JV1n9qgGMP@kernel.org>
Date: Thu, 23 Jan 2025 08:25:58 +1100
Message-id: <173758115880.22054.14500734969496903328@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 23 Jan 2025, Mike Snitzer wrote:
> On Fri, Dec 06, 2024 at 01:15:30PM +1100, NeilBrown wrote:
> > The flags NFS_LAYOUT_RETURN and NFS_LAYOUT_RETURN_LOCK are effectively
> > identical.
> > The only time either are cleared is in pnfs_clear_layoutreturn_waitbit(),
> > and there both are cleared.
> > The only time NFS_LAYOUT_RETURN is set is in pnfs_prepare_layoutreturn()
> > immediately after NFS_LAYOUT_RETURN_LOCK was set.
> > The only other time that NFS_LAYOUT_RETURN_LOCK is set is in
> > pnfs_mark_layout_stateid_invalid() if NFS_LAYOUT_RETURN was set but
> > NFS_LAYOUT_RETURN_LOCK was not set - but that is an impossible
> > combination given that else where the flags are set or cleared together.
> >=20
> > So we only need one of these flags.  This patch discards
> > NFS_LAYOUT_RETURN_LOCK and does the test_and_set needed for exclusion with
> > NFS_LAYOUT_RETURN.
> >=20
> > Also the wake_up_bit in pnfs_clear_layoutreturn_waitbit() is changed to
> > clear_and_wake_up_bit() which includes all needed barriers internally.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> I appreciate that you've done a general audit of the NFS code and
> looked to improve / optimize the wake_up_bit() callers, etc.  But how
> did you test this specific patch's changes to the pnfs code?

mumble mumble mumble

>=20
> Reason I ask is if you look at the commit that introduced
> NFS_LAYOUT_RETURN_LOCK way back when:
> 6604b203fb63 pNFS: On error, do not send LAYOUTGET until the LAYOUTRETURN h=
as completed

That commit was effectively reverted by=20
Commit: 61f454e30c18 ("pNFS: Fix a deadlock when coalescing writes and return=
ing the layout")

I don't pretend to understand exactly what is going on with these flags=20
but I'm fairly confident that I didn't change behaviour that I didn't
intent to change.
And now that I found that commit I'm even more confident that
NFS_LAYOUT_RETURN_LOCK isn't needed.

Thanks for reviewing my code !!

NeilBrown

>=20
> You'll see that, with your patch, you've seem to have now reverted the
> code back to before stable@ commit 6604b203fb63 was applied.
>=20
> Now there may be merit to doing that due to other changes in the pnfs
> code that didn't exist back then but... your changes look suspicious
> given the evolution of this code.
>=20
> Mike
>=20
>=20


