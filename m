Return-Path: <linux-nfs+bounces-10890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D7A70FA0
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 04:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC521886F24
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 03:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475214B96E;
	Wed, 26 Mar 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="twnYPDPB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DdTk3EEh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ecdiq7XQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PcIK33Ul"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD263CB
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742960528; cv=none; b=uW7MDII7gyQaisdSG70WINnKnKeMAe3O+9pz9ajYL01okRf8YLyUcxPnqFHWDEzHN/WVUn4WKuhoLDRKZpfmBmVpipr7Lz6PveMFg788h8kWAHltbt96GP2QtUW5debqWs9YxmyEWnyKLbvr0TnHqUGcli3kCM0IGLDOGsC4rEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742960528; c=relaxed/simple;
	bh=IxFxZYBRTcG2P0DGPIlpEhsvKiqKyRNjAqJ80eiHigM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Gblisdb+4qYF9Jscp4vB7srhDbJnEgswWKxo9mmHzwjTcMnLCF6wAY5d3Fwwv4k3hAnpCb/cPQcsJsTPDDB42TAFOWQ9DDbgW3EgUWhVRP3qddEClueFQUYLK+ZDrOqyeuy102ZKBlvnmr7PtEZqj+1qagHLRgjjAWd0gnxy37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=twnYPDPB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DdTk3EEh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ecdiq7XQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PcIK33Ul; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE84021164;
	Wed, 26 Mar 2025 03:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742960523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3mBZM+g9IJ3PtQ8p9F7Ph++vl4onXVLe9rE51dUiJo=;
	b=twnYPDPBPpgQ6lUMrfBMrZ3VgW9e6+qEzppao6O6F9S54le5KaJPcPWsTWxXS+f/WTtHE1
	M4l0eNVnAS3uzKYZBobBopCNIgaFmrhyeOaJ0q6hmJ/HhoNDld07+jRNQ06OYRMIZanVWE
	VFoUWkHf1zlovSKJwERZieyTimbQa34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742960523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3mBZM+g9IJ3PtQ8p9F7Ph++vl4onXVLe9rE51dUiJo=;
	b=DdTk3EEhhEwkT+pzRLkuXdPwAI9KUbL6JBwa3Q2bT+9znbzQrtmeSEGiT4+X0KQEVG5jOb
	kCaO7L5s+RZ7reBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ecdiq7XQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PcIK33Ul
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742960522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3mBZM+g9IJ3PtQ8p9F7Ph++vl4onXVLe9rE51dUiJo=;
	b=Ecdiq7XQx+OyBr0aJbbLtQLjlaVjbIy8bW+Gk1citBrpmX6nQJN8TijiLLAkQ59yTWH/5l
	6WWHe9DSE+Yjxm7rgcUl+5RachwmBWXDDVRkGDNCNEyINFV2rrt0OKvqtfyV+niJ8KGlLf
	KWQhIxDVZFLLcTwK+uhx9Yq0ZL/Qs88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742960522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3mBZM+g9IJ3PtQ8p9F7Ph++vl4onXVLe9rE51dUiJo=;
	b=PcIK33Ula2c3+9h4bOaDg2fIoDjSXg8AcAOIyADHbXM3cjUg/l/CxRaP2sqo3UPRZeDnlW
	UTp79yTwBFgSPsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ABFC1395F;
	Wed, 26 Mar 2025 03:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4aaSA4h342dyBAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Mar 2025 03:42:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Benjamin Coddington" <bcodding@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
In-reply-to: <8787b756-2003-4a2c-a56c-8f8c626756a1@oracle.com>
References: <>, <8787b756-2003-4a2c-a56c-8f8c626756a1@oracle.com>
Date: Wed, 26 Mar 2025 14:41:56 +1100
Message-id: <174296051697.9342.18114262068417505490@noble.neil.brown.name>
X-Rspamd-Queue-Id: CE84021164
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 26 Mar 2025, Dai Ngo wrote:
> On 3/25/25 5:23 PM, NeilBrown wrote:
> > On Sat, 22 Mar 2025, Chuck Lever wrote:
> >> On 3/21/25 10:36 AM, Benjamin Coddington wrote:
> >>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
> >>>
> >>>> On 3/19/25 5:46 PM, NeilBrown wrote:
> >>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Currently when the local file system needs to be unmounted for maint=
enance
> >>>>>> the admin needs to make sure all the NFS clients have stopped using =
any files
> >>>>>> on the NFS shares before the umount(8) can succeed.
> >>>>> This is easily achieved with
> >>>>>    echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
> >>>>>
> >>>>> Do this after unexporting and before unmounting.
> >>>> Seems like administrators would expect that a filesystem can be
> >>>> unmounted immediately after unexporting it. Should "exportfs" be chang=
ed
> >>>> to handle this extra step under the covers? Doesn't seem like it would
> >>>> be hard to do, and I can't think of a use case where it would be
> >>>> harmful.
> >>> No. I think that admins don't expect to lose all their NFS client's sta=
te if
> >>> they're managing the exports.  That would be a really big and invisible=
 change
> >>> to existing behavior.
> >> To be clear, I mean that a file system should be unlocked only when it
> >> is specifically unexported. IMO, unexport is usually an administrator
> >> action that means "I want to stop remote access to this file system now"
> >> and that's what unlock_filesystem does.
> > A problem with that position is that "unexport" isn't a well defined
> > operation.
> > It is quite possible to edit /etc/exports then run "exportfs -r".  This
> > may implicit unexport things.
> >
> > The kernel certainly doesn't have a concept of "unexport".  You can run
> > "exportfs -f" at any time quite safely.  That tells the kernel to forget
> > all export information, but allows the kernel to ask mountd for anything
> > it find that it needs.
> >
> >> IMO administrators would be surprised to learn that NFS clients may
> >> continue to access a file system (via existing open files) after it
> >> has been explicitly unexported.
> > They can't access those file while it remains unexported.  But if it is
> > re-exported, the access they had can continue seamlessly.
> >
> > The origin model is NLM which is separate from NFS.  Unexporting to NFS
> > doesn't close the locks held by NLM.  That can be done separately by the
> > client with a STATMON request.  In fact NLM never drops locks unless
> > explicitly asked to by the client or forced by the server admin.  So it
> > isn't a good model, but it is what we had.
> >
> >> The alternative is to document unlock_filesystem in man exportfs(8).
> > Another alternative is to provide new functionality in exportfs.  Maybe
> > a --force flag or a --close-all flag.
> > It could examine /proc/fs/nfsd/clients/*/states to determine which
> > filesystems had active state, then examine the export tables
> > (/var/lib/nfs/etab) to see what was currently exported, then write
> > something appropriate to unlock_filesystem for any active filesystems
> > which are no longer exported.
>=20
> Is it possible that at the time of cache_clean/svc_export_put the kernel
> makes an upcall to rpc.mountd to check if svc_export.ex_path is still
> exported?. If it's not then release all the states that use that super_bloc=
k.

I suspect that could be done, but then you would hit Ben's concern.
Temporarily unexported a filesystem would change from the client getting
ESTALE if it happens to access a file while the filesystem is not
exported, to the client definitely getting ADMIN_REVOKED (probably -EIO)
then next time it accesses a file even if the filesystem has been
exported again.

I agree with Ben that there needs to be a deliberate admin action to
revoke state, not just a side-effect of unexport which historically has
not revoked state.

NeilBrown



>=20
> -Dai
>=20
> >
> > If we did that we would want to find NLM locks in /proc/locks too and
> > ensure those were discarded if necessary.
> >
> > There is also the possibility that a filesystem is still exported to
> > some clients but not to all.  In that case writing something to
> > unlock_ip might be appropriate - though that doesn't revoke v4 state
> > yet.
> >
> > Thanks,
> > NeilBrown
> >
> >
> >> And perhaps we need a more surgical mechanism that can handle the case
> >> where the file system is still exported but the security policy has
> >> changed. Because this does feel like a real information leak.
> >>
> >>
> >> --=20
> >> Chuck Lever
> >>
>=20


