Return-Path: <linux-nfs+bounces-10886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A539A70E2C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 01:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD98C188E3CA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 00:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24EA55;
	Wed, 26 Mar 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bOGnss6K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tt+OKyXF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f1qrOKWR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7k/1j1h9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AA7F9
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948603; cv=none; b=Re0a3f7BQOd8BT5+GdVd1906TGindNdskqRbbH0SxmT4WfL6nhwnLcBjbMtxShzWufDrX7/PFqaPoZaKTKgYl7vnGJEzaxz1GHYzq1TuByztpWHDDZig2K4ntSYVdr6m5qaJye+b7MDJGsIzOeefMxaYwYfBfXr/00ZyG279eYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948603; c=relaxed/simple;
	bh=T5gA2w0xZngUXjbapqafUAIyZuhJpyyNJWuc8wyBXLE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LChnTSYhL/Cwx7dGLp+cxuE8/EKMnhHvivvoKSq6VXtkLKGzP5dXbH5KGryvTKSqaKhVmi3UxDg9PFYGOxRaa8ppYCQEy0B6A7JiDajusNg/xHysAAbmCsLyjel/vikV8sCc5Qb2wjhKMGDp8bHq6qlsXZOsM15abzZQI6rcycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bOGnss6K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tt+OKyXF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f1qrOKWR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7k/1j1h9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCC641F391;
	Wed, 26 Mar 2025 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742948599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPMnn6Q2W0DruOzw4TJ5Oqnkh/XRwhT1Ey20WKPs3+c=;
	b=bOGnss6Kyq5IfA2VjRmolSO3fMOIbCSibjM7GCDEXPmehqiRAPWBFZTXNF+9rqs0lXbeZF
	WyshrZl6Brz0Q+koUM2FXUh6H7S4z+v3OGpjG66J2/C/zDbqrhxMuoogBP1ieQb9fnxdEA
	IX4kcf33JLj4zGit1rYChQRHyJXXEWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742948599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPMnn6Q2W0DruOzw4TJ5Oqnkh/XRwhT1Ey20WKPs3+c=;
	b=tt+OKyXFzc0giCid2dnvO/RLO/Eja7Zkr/GOMqT4W0AcKAEL92NgGP1BFEuccqO7MoTLQT
	q+tCxd8lNA5kt5DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f1qrOKWR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="7k/1j1h9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742948598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPMnn6Q2W0DruOzw4TJ5Oqnkh/XRwhT1Ey20WKPs3+c=;
	b=f1qrOKWRojzVLH+iFt7xQuQSUEiqKfM1aks3xs3ZYoInWoIPUxr12YvMAMFk9LyfJTpZtj
	bX1sFwdd3o1D7juXiJS5SzLG9LVlBg4kDhgaOJRnQC9Ody/e06S/AybXH5VuBHW5gyVY6c
	qGZ6zMiqCOMKH6c6dOzF/nd7BI2k7EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742948598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPMnn6Q2W0DruOzw4TJ5Oqnkh/XRwhT1Ey20WKPs3+c=;
	b=7k/1j1h9WrLGBJFZPzW3y7DUzhX3vMEynkx2b5DGcVzgRVKmV7gOGeJK4RVuAOGp8sgtNk
	LxgSW9VyMmSNXACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D3B1376E;
	Wed, 26 Mar 2025 00:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Z64BvRI42cLUAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Mar 2025 00:23:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Benjamin Coddington" <bcodding@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
In-reply-to: <202ab884-c011-4a8f-94fe-37aa11b9d32d@oracle.com>
References: <>, <202ab884-c011-4a8f-94fe-37aa11b9d32d@oracle.com>
Date: Wed, 26 Mar 2025 11:23:07 +1100
Message-id: <174294858765.9342.3077110145854589812@noble.neil.brown.name>
X-Rspamd-Queue-Id: DCC641F391
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,noble.neil.brown.name:mid];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 22 Mar 2025, Chuck Lever wrote:
> On 3/21/25 10:36 AM, Benjamin Coddington wrote:
> > On 20 Mar 2025, at 13:53, Chuck Lever wrote:
> >=20
> >> On 3/19/25 5:46 PM, NeilBrown wrote:
> >>> On Thu, 20 Mar 2025, Dai Ngo wrote:
> >>>> Hi,
> >>>>
> >>>> Currently when the local file system needs to be unmounted for mainten=
ance
> >>>> the admin needs to make sure all the NFS clients have stopped using an=
y files
> >>>> on the NFS shares before the umount(8) can succeed.
> >>>
> >>> This is easily achieved with
> >>>   echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
> >>>
> >>> Do this after unexporting and before unmounting.
> >>
> >> Seems like administrators would expect that a filesystem can be
> >> unmounted immediately after unexporting it. Should "exportfs" be changed
> >> to handle this extra step under the covers? Doesn't seem like it would
> >> be hard to do, and I can't think of a use case where it would be
> >> harmful.
> >=20
> > No. I think that admins don't expect to lose all their NFS client's state=
 if
> > they're managing the exports.  That would be a really big and invisible c=
hange
> > to existing behavior.
>=20
> To be clear, I mean that a file system should be unlocked only when it
> is specifically unexported. IMO, unexport is usually an administrator
> action that means "I want to stop remote access to this file system now"
> and that's what unlock_filesystem does.

A problem with that position is that "unexport" isn't a well defined
operation.
It is quite possible to edit /etc/exports then run "exportfs -r".  This
may implicit unexport things.

The kernel certainly doesn't have a concept of "unexport".  You can run
"exportfs -f" at any time quite safely.  That tells the kernel to forget
all export information, but allows the kernel to ask mountd for anything
it find that it needs.

>=20
> IMO administrators would be surprised to learn that NFS clients may
> continue to access a file system (via existing open files) after it
> has been explicitly unexported.

They can't access those file while it remains unexported.  But if it is
re-exported, the access they had can continue seamlessly.

The origin model is NLM which is separate from NFS.  Unexporting to NFS
doesn't close the locks held by NLM.  That can be done separately by the
client with a STATMON request.  In fact NLM never drops locks unless
explicitly asked to by the client or forced by the server admin.  So it
isn't a good model, but it is what we had.

>=20
> The alternative is to document unlock_filesystem in man exportfs(8).

Another alternative is to provide new functionality in exportfs.  Maybe
a --force flag or a --close-all flag.
It could examine /proc/fs/nfsd/clients/*/states to determine which
filesystems had active state, then examine the export tables
(/var/lib/nfs/etab) to see what was currently exported, then write
something appropriate to unlock_filesystem for any active filesystems
which are no longer exported.

If we did that we would want to find NLM locks in /proc/locks too and
ensure those were discarded if necessary.

There is also the possibility that a filesystem is still exported to
some clients but not to all.  In that case writing something to
unlock_ip might be appropriate - though that doesn't revoke v4 state
yet.

Thanks,
NeilBrown


>=20
> And perhaps we need a more surgical mechanism that can handle the case
> where the file system is still exported but the security policy has
> changed. Because this does feel like a real information leak.
>=20
>=20
> --=20
> Chuck Lever
>=20


