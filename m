Return-Path: <linux-nfs+bounces-22939-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8dTjGvMaRmpRKAsAu9opvQ
	(envelope-from <linux-nfs+bounces-22939-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 10:01:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 058416F487B
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 10:01:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZdKpHwc2;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22939-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22939-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98760302572D
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85723A4F5E;
	Thu,  2 Jul 2026 07:44:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14003B4EA9;
	Thu,  2 Jul 2026 07:44:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978266; cv=none; b=D5wroQqQ9FsbzheIIymscXgtzHLR4vBZBMJu1IiSkVJYaaUYJ7H0q2dLC/bZC1w9WOA1gU2irGb1VD+6Rk4fghqCImpgU9QgpyoOEV4rbi7dO/lP75Px0j8AnGyZapTPv/DuVet2Fr48YfxEtDsybl90pzyuV2b/cgc+4Ejze7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978266; c=relaxed/simple;
	bh=86OvD4fbRP1MhaFrjiWmHql7uPFq7+n64G79hRC1syE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZmF4hiPQFHslRGBF4qJfSGLATfVcgzXm7/qFG0/vNZLvFAoRTAOIkmwi7jB2k1rUmIWpvnfoc2RHJaGGHhcEWGHhADt3ligbVFz4FbG/CuWr8vKfk8b3bU2Jx2Ho4/WhToqTv91Gv3Pf7YW7EvGzUYk/TutRfIeA/kH//NTV+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdKpHwc2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F841F000E9;
	Thu,  2 Jul 2026 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782978262;
	bh=pw7UB+las03Zd+n0XXxB46auuLv6eyuJTUsh0sXoIck=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZdKpHwc2j42OHNqT6vySAGjYzBtQ7zSona1+PlfNEsIOXJYT2WxO89xvARtVfCenO
	 90FAp5/2D0wzbkCDmUPenZRdJhzKu3UqFdPQR1xTkxbIeIoVrp4NoGSPvV/LAWAY/+
	 13LDx8rtoqw/x7NdwEXxIS7KOLLOHt9SBUYjc7OSF/kMxtazINW6JhtXf0Bd7Zfz3l
	 r3N5CBpGUTT5oZgqEfAqxjKD/BAz5Qd2ETtUm2GAZUmipaaZKnc0/rpnKUifjRqAJB
	 w0DeFz5B4+ov2oczSldWfH4T/IC6OVdOuIOR4mQksiq/t8mzN/EJLaHVKnLZvcuoXg
	 5AawwGEY4Kkog==
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH/RFC 00/18] VFS/nfsd: replace dentry_create()
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jori Koolstra <jkoolstra@xs4all.nl>, 
 Benjamin Coddington <ben.coddington@hammerspace.com>, 
 Mateusz Guzik <mjguzik@gmail.com>
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Date: Thu, 02 Jul 2026 09:44:17 +0200
Message-Id: <20260702-kurswechsel-grundlos-erdteil-27c448aef1ec@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=brauner@kernel.org;
 h=from:subject:message-id; bh=86OvD4fbRP1MhaFrjiWmHql7uPFq7+n64G79hRC1syE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5iV1+tWCqwHXtvdvOGOrfK3RIcHy7IuFwJ3tQ/MFUz
 wUcamyTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS6s/IsPPxiVP+Zv9n/b3x
 bHXZ+1MNRwOz2rjlS0Qfz/DqDON9vIvhf/i3kFt68w8EJHrsnMLx/uyZG1mrqjS6dCynL44xCe/
 QZAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[brauner:query timed out];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:cel@kernel.org,m:jlayton@kernel.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jkoolstra@xs4all.nl,m:ben.coddington@hammerspace.com,m:mjguzik@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22939-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 058416F487B

On 2026-06-01 16:37 +1000, NeilBrown wrote:
> My recent proposal for inverting the order between inode_lock() on a
> parent dir and d_alloc_parallel()[1] missed that fact that atomic_open()
> has two callers, and would have resulted in easy deadlocks from nfsd
> when re-exporting and NFS filesystem.
> 
> I think the best way to fix this is to provide a richer interface for
> nfsd to use, which includes all the locking as well as inode_operations
> calls.  This allows the nfsd behaviour to share more code with the
> system-call behaviour.
> 
> This series refactors code between lookup_open() and
> open_last_lookups(), and uses the new lookup_open() to provide
> vfs_lookup_open().  It then rearranges the code in nfsd so that it can
> easily use vfs_lookup_open() instead of dentry_create().  Finally
> dentry_create() is removed.
> 
> This series is based on a merge of nfsd-testing, vfs-next/work.dcache,
> and vfs/vfs.fixes (though I can't see my "Fix possible failure to
> unlock.."[2] patch in there yet).  So I probably will need to resubmit
> after a bunch of that has hit mainline - though a few of the patches

Yes, please resubmit. 

> This will conflict with the O_CREAT|O_DIRECTORY work so obviously we'll need to
> work out how to order them once we both have enough positive review.

I have that on my todo but somehow said todo keeps growing...


