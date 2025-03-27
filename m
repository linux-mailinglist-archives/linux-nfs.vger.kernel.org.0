Return-Path: <linux-nfs+bounces-10930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D9A7411F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 23:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641A216CF56
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EF1DFE23;
	Thu, 27 Mar 2025 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1PJs45f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dsjFjxOG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1PJs45f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dsjFjxOG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886D1DF246
	for <linux-nfs@vger.kernel.org>; Thu, 27 Mar 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115685; cv=none; b=tlvyuZkKWBIRH9c4So8pK+NRFzXX6LaccrCUHiFZrl172JrSXnkzSZJWazZMd4K2j/JS3W6Vt8l+PfUXoDMoYZbqgcj2VIMkct+lvyKzWuEX5faVtaoHx2YimCSQjSUavd2IEESqerykk5HpT6hmPXyC7h56+GnxpDXybVytwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115685; c=relaxed/simple;
	bh=p9QnoewETrNQuSJHBMVy+4HBU/Tz9Ed+AvFCOYoPvfw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Wn66Um4uNzr6PnOVfZ1egky2yb2i/JI9eWzL/yM2BCzDtp5wYnl2JRgsCnEzTLnIPcj2fhkAlozdISCOuv0vuirLHLKUdF1joXfF8Af2CNFZTLS8KRTyuwRQV8diOkRwNA4YewtvlIe+6TkfADB0WUfmtmFTZ5u7yGsHXzfesmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C1PJs45f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dsjFjxOG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C1PJs45f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dsjFjxOG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C2C81F388;
	Thu, 27 Mar 2025 22:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743115681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Se+hbceQs2QDeOlrb5PMstweGy0zr8tc23LChY/jiqU=;
	b=C1PJs45f9Lq+f4d3Dug+VL49leFqZESP9UXODCytTPd9E5+m8HXBGuFHDrzHIS5PQIhO8H
	4FsTcHFEprJHiZE9UuQkuYI8UWcYZDdAmA9dO1wS2+ym7Ew/lNDKJHWYZvtcV+5MTxcMD2
	6R6JC1hKxEbaz9TI8E0iVPoCgHANfGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743115681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Se+hbceQs2QDeOlrb5PMstweGy0zr8tc23LChY/jiqU=;
	b=dsjFjxOGdqRGAf0GgRbipa7ftqIHMvRL4BAZl2XXBCZM84/YhOtalyCxg2Z0DKZ8LpC0uH
	QHDkWS1iIXKrv7DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743115681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Se+hbceQs2QDeOlrb5PMstweGy0zr8tc23LChY/jiqU=;
	b=C1PJs45f9Lq+f4d3Dug+VL49leFqZESP9UXODCytTPd9E5+m8HXBGuFHDrzHIS5PQIhO8H
	4FsTcHFEprJHiZE9UuQkuYI8UWcYZDdAmA9dO1wS2+ym7Ew/lNDKJHWYZvtcV+5MTxcMD2
	6R6JC1hKxEbaz9TI8E0iVPoCgHANfGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743115681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Se+hbceQs2QDeOlrb5PMstweGy0zr8tc23LChY/jiqU=;
	b=dsjFjxOGdqRGAf0GgRbipa7ftqIHMvRL4BAZl2XXBCZM84/YhOtalyCxg2Z0DKZ8LpC0uH
	QHDkWS1iIXKrv7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D15139D4;
	Thu, 27 Mar 2025 22:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vUYKOp7V5WfVbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Mar 2025 22:47:58 +0000
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
Cc: "Dai Ngo" <dai.ngo@oracle.com>,
 "Benjamin Coddington" <bcodding@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
In-reply-to: <92dc63d6-802e-48c4-9f4c-eae8051fa065@oracle.com>
References: <>, <92dc63d6-802e-48c4-9f4c-eae8051fa065@oracle.com>
Date: Fri, 28 Mar 2025 09:47:55 +1100
Message-id: <174311567599.9342.12939393983924780308@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 27 Mar 2025, Chuck Lever wrote:
> On 3/25/25 11:41 PM, NeilBrown wrote:
> > On Wed, 26 Mar 2025, Dai Ngo wrote:
> >> On 3/25/25 5:23 PM, NeilBrown wrote:
> >>> On Sat, 22 Mar 2025, Chuck Lever wrote:
> >>>> On 3/21/25 10:36 AM, Benjamin Coddington wrote:
> >>>>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
> >>>>>
> >>>>>> On 3/19/25 5:46 PM, NeilBrown wrote:
> >>>>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Currently when the local file system needs to be unmounted for mai=
ntenance
> >>>>>>>> the admin needs to make sure all the NFS clients have stopped usin=
g any files
> >>>>>>>> on the NFS shares before the umount(8) can succeed.
> >>>>>>> This is easily achieved with
> >>>>>>>    echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
> >>>>>>>
> >>>>>>> Do this after unexporting and before unmounting.
> >>>>>> Seems like administrators would expect that a filesystem can be
> >>>>>> unmounted immediately after unexporting it. Should "exportfs" be cha=
nged
> >>>>>> to handle this extra step under the covers? Doesn't seem like it wou=
ld
> >>>>>> be hard to do, and I can't think of a use case where it would be
> >>>>>> harmful.
> >>>>> No. I think that admins don't expect to lose all their NFS client's s=
tate if
> >>>>> they're managing the exports.  That would be a really big and invisib=
le change
> >>>>> to existing behavior.
> >>>> To be clear, I mean that a file system should be unlocked only when it
> >>>> is specifically unexported. IMO, unexport is usually an administrator
> >>>> action that means "I want to stop remote access to this file system no=
w"
> >>>> and that's what unlock_filesystem does.
> >>> A problem with that position is that "unexport" isn't a well defined
> >>> operation.
> >>> It is quite possible to edit /etc/exports then run "exportfs -r".  This
> >>> may implicit unexport things.
> >>>
> >>> The kernel certainly doesn't have a concept of "unexport".  You can run
> >>> "exportfs -f" at any time quite safely.  That tells the kernel to forget
> >>> all export information, but allows the kernel to ask mountd for anything
> >>> it find that it needs.
> >>>
> >>>> IMO administrators would be surprised to learn that NFS clients may
> >>>> continue to access a file system (via existing open files) after it
> >>>> has been explicitly unexported.
> >>> They can't access those file while it remains unexported.  But if it is
> >>> re-exported, the access they had can continue seamlessly.
> >>>
> >>> The origin model is NLM which is separate from NFS.  Unexporting to NFS
> >>> doesn't close the locks held by NLM.  That can be done separately by the
> >>> client with a STATMON request.  In fact NLM never drops locks unless
> >>> explicitly asked to by the client or forced by the server admin.  So it
> >>> isn't a good model, but it is what we had.
> >>>
> >>>> The alternative is to document unlock_filesystem in man exportfs(8).
> >>> Another alternative is to provide new functionality in exportfs.  Maybe
> >>> a --force flag or a --close-all flag.
> >>> It could examine /proc/fs/nfsd/clients/*/states to determine which
> >>> filesystems had active state, then examine the export tables
> >>> (/var/lib/nfs/etab) to see what was currently exported, then write
> >>> something appropriate to unlock_filesystem for any active filesystems
> >>> which are no longer exported.
> >>
> >> Is it possible that at the time of cache_clean/svc_export_put the kernel
> >> makes an upcall to rpc.mountd to check if svc_export.ex_path is still
> >> exported?. If it's not then release all the states that use that super_b=
lock.
> >=20
> > I suspect that could be done, but then you would hit Ben's concern.
> > Temporarily unexported a filesystem would change from the client getting
> > ESTALE if it happens to access a file while the filesystem is not
> > exported, to the client definitely getting ADMIN_REVOKED (probably -EIO)
> > then next time it accesses a file even if the filesystem has been
> > exported again.
> >=20
> > I agree with Ben that there needs to be a deliberate admin action to
> > revoke state, not just a side-effect of unexport which historically has
> > not revoked state.
>=20
> I'm not religiously attached to expunging open/lock state on a simple
> unexport operation. But I think it is critical to document the fact that
> NFSv4 state remains and that will prevent an unmount (I'm not sure we've
> identified any possible security exposures).
>=20
> Neil, do you happen to know if unlock_filesystem and unlock_ip are
> mentioned in man pages? If so, then exportfs(8) should refer to them.
>=20

They aren't mentioned in the nfs-utils package at all, or in
linux/Documentation.
So no: no documentation.

They should be mentioned in nfsd.7 (utils/exportfs/nfsd.man)

I guess someone should update that man page.... Probably the new netlink
interface could be described there too?

NeilBrown

