Return-Path: <linux-nfs+bounces-1723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60772847DC3
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 01:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F8DB27EFC
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 00:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431F368;
	Sat,  3 Feb 2024 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n9Y5eB+W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yEuu/7b3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z9pk/ywi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YQZqZITh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22C622;
	Sat,  3 Feb 2024 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919977; cv=none; b=habJxkLyi63wy0APRcGwgmz7ho8SxZVM05mWgl4fnKhpTH5O2vg6tCx8dfTM+w43tQVEZNlROPUBGsZUMzTDlVm4JGhMJmYQUjkY66Lp4W4JN8u3jFhCyqVsEsrD/vLm1YrNtAW8ISZEumVhyn3tcANAzJunatLbJITChlak73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919977; c=relaxed/simple;
	bh=sGPrlB3yjincDWQ6gmHuq5pkDDpK5ZNPTZy9ztTc2v8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=M6E7f+9V4rVTx/0lomphVNOhAT7UN1OY8rS1D+dKsTTinNPOG4RWiuv/+tgu4Lj2aHpx9fN0oetFABFVZfgkmAG4HTxkGBChyTBmSsfjwsGrYHP6UmlhxWwjpuEYZGIWgeMM3dBZlDHfgK03dBYHDQkJ5soY7Fv01gKyv/UaaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n9Y5eB+W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yEuu/7b3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z9pk/ywi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YQZqZITh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D60021FCF;
	Sat,  3 Feb 2024 00:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706919973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYk7i6J9iMlbWsML/nl6fudDcEusAXZhQsKFFM9NkxU=;
	b=n9Y5eB+WHqW2hrMK3MJeLX9iLc5P+qsg3O7SJdOr6egGnqEXDlOJhzDjcgKW05pR1M2a5h
	G/nRkM1tE8xCsp2N6UTo9Mg1RZwISNSgfVW4gdLgEh1+1m53j9EgWSnbGNx7kgYAKee+i7
	j5cZ5EynQe+qL/hXZ5SPKKJoLKILEHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706919973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYk7i6J9iMlbWsML/nl6fudDcEusAXZhQsKFFM9NkxU=;
	b=yEuu/7b3fTeMNIxe49+Xiz1FVu7WTojG1G5uarCEIvPwS7YdYJmpUa/8e/yuHxwBHtEnSA
	Ba3mYAgAGDlcrhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706919971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYk7i6J9iMlbWsML/nl6fudDcEusAXZhQsKFFM9NkxU=;
	b=z9pk/ywiObdrap3d/qYIpfmzg7q6Gb/I6HrGTcyuxPqVFS2yMO0ibyj3VQpXU6/N/elCFz
	GGvMmzshEmsQL5neWhFA/neM6JfYKzQ5DaEeAvSR5l8WKH6+tYuVpnUZu02tJdB6wtdMVK
	ESRfl4BiFgmujguWiGdMP5R6FWaDcmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706919971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYk7i6J9iMlbWsML/nl6fudDcEusAXZhQsKFFM9NkxU=;
	b=YQZqZITh9bdGyj5r9FfYSlqr1mRtEqIq0RH7taEZ3qnT2wY/cIAVfsgVKAVOnLNnLSVYEs
	wjXdGjSArqUWENAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97B1C13A58;
	Sat,  3 Feb 2024 00:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MDYGEyGIvWUAKQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 03 Feb 2024 00:26:09 +0000
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
Cc: "linux-stable" <stable@vger.kernel.org>, "Chuck Lever" <cel@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fix RELEASE_LOCKOWNER
In-reply-to: <FF7C90E0-251D-48D2-908B-E2145B0B9BAE@oracle.com>
References:
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>,
 <170682628772.13976.3551007711597007133@noble.neil.brown.name>,
 <FF7C90E0-251D-48D2-908B-E2145B0B9BAE@oracle.com>
Date: Sat, 03 Feb 2024 11:26:06 +1100
Message-id: <170691996664.13976.18138125578593325497@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="z9pk/ywi";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YQZqZITh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 TO_DN_ALL(0.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,nfslock01.sh:url,suse.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 1D60021FCF
X-Spam-Flag: NO

On Sat, 03 Feb 2024, Chuck Lever III wrote:
>=20
>=20
> > On Feb 1, 2024, at 5:24=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Fri, 02 Feb 2024, Chuck Lever wrote:
> >> Passes pynfs, fstests, and the git regression suite. Please apply
> >> these to origin/linux-5.4.y.
> >=20
> > I should have mentioned this a day or two ago but I hadn't quite made
> > all the connection yet...
> >=20
> > The RELEASE_LOCKOWNER bug was masking a double-free bug that was fixed
> > by
> > Commit 47446d74f170 ("nfsd4: add refcount for nfsd4_blocked_lock")
> > which landed in v5.17 and wasn't marked as a bugfix, and so has not gone =
to
> > stable kernels.
>=20
> Then, instructions to stable@vger.kernel.org:
>=20
> Do not apply the patches I just sent for 5.15, 5.10, and 5.4. I will
> apply 47446d74f170, run the tests again, and resend.
>=20
>=20
> > Any kernel earlier than v5.17 that receives the RELEASE_LOCKOWNER fix
> > also needs the nfsd4_blocked_lock fix.  There is a minor follow-up fix
> > for that nfsd4_blocked_lock fix which Chuck queued yesterday.
> >=20
> > The problem scenario is that an nfsd4_lock() call finds a conflicting
> > lock and so has a reference to a particular nfsd4_blocked_lock.  A concur=
rent
> > nfsd4_read_lockowner call frees all the nfsd4_blocked_locks including
> > the one held in nfsd4_lock().  nfsd4_lock then tries to free the
> > blocked_lock it has, and results in a double-free or a use-after-free.
> >=20
> > Before either patch is applied, the extra reference on the lock-owner
> > than nfsd4_lock holds causes nfsd4_realease_lockowner() to incorrectly
> > return an error and NOT free the blocks_lock.
> > With only the RELEASE_LOCKOWNER fix applied, the double-free happens.
>=20
> Our test suite currently does not exercise this use case, apparently.
> I didn't see a problem like this during testing.
>=20

Our OpenQA testing found it (as did our customer :-).
Quoting from a bugzilla that unfortunately is not public (though might
not be accessible to anyone with an account)

https://bugzilla.suse.com/show_bug.cgi?id=3D1219349

     LTP test nfslock01.sh randomly fails on the latest SLE-15SP4 and
     SLE-15SP5 KOTD.  The failures appear only when testing NFS protocol
     v4.0, other versions do not seem to be affected.  The test either
     gets stuck or sometimes triggers kernel oops.  The contents of the
     kernel backtrace vary.  All archs appear to be affected.=20

Does your test suite cover v4.0?  Does it include LTP ?

Thanks,
NeilBrown


>=20
> > With both patches applied the refcount on the nfsd4_blocked_lock prevents
> > the double-free.
> >=20
> > Kernels before 4.9 are (probably) not affected as they didn't have
> > find_or_allocate_block() which takes the second reference to a shared
> > object.  But that is ancient history - those kernels are well past EOL.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> >>=20
> >> ---
> >>=20
> >> Chuck Lever (2):
> >>      NFSD: Modernize nfsd4_release_lockowner()
> >>      NFSD: Add documenting comment for nfsd4_release_lockowner()
> >>=20
> >> NeilBrown (1):
> >>      nfsd: fix RELEASE_LOCKOWNER
> >>=20
> >>=20
> >> fs/nfsd/nfs4state.c | 65 +++++++++++++++++++++++++--------------------
> >> 1 file changed, 36 insertions(+), 29 deletions(-)
> >>=20
> >> --
> >> Chuck Lever
> >>=20
> >>=20
> >>=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20


