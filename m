Return-Path: <linux-nfs+bounces-23069-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WyFON0fCS2ooZwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23069-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 16:57:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2B71242E
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 16:57:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lencrpbl;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23069-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23069-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39B6530BCCC9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B038A71E;
	Mon,  6 Jul 2026 14:36:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF503385D64
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 14:36:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348613; cv=none; b=WNPb0nxC7sa0UK4oSTvffJXRuUUrB10IcbSvwvClhpFzc7HbMFnKeRG9jqxDAV6eUaMWMzErU7OKtbiJbUEwuAc1MK9FbZhDU3+50aiSCGypPHtuswhjZm1jySHwxw9+jcWVIEgtVWLZLkjnvj9t0SxQyKbmK8dgcpUy8vDedQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348613; c=relaxed/simple;
	bh=WXQLjYLfxwnHgrL2RyI2A6t6Od6DVnBjwolJYYd0+3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9+SWy/9SMZJtsYdEoBxJCO9Df+wY6dphofvKwLrfLjxlsqipUTFJXmCkjmKv1RFtfTtvaSCnhjAr0BOGVJqSsiawutYueHRMvT/uOlDu6hQdyNr9IZglJlbMJ4f8l/lWZrILaRefnmTDfJFOEH4uHEN4xZ/veDsVDcjya9x80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lencrpbl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215941F000E9;
	Mon,  6 Jul 2026 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348611;
	bh=5DZsMcIN2lcn8rovSx/BdVqousCwJtfpSze8K0FogBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LencrpblymzzJu4LlaPYv5lAfnZsVUE5fn7EpxE/gvX0QwbT1Qrayty9FnqKRZ8YL
	 kI/OePYCnXLZfiuLT415sOpFq5UpvB5raSkgDa0Zrk1wpyCf3S6BWWlk+TOFagTh6v
	 Cd9YMgJeN9yQJGeADFD1ype75uRAeTRBawxJhRQsXeuDyL5rHJQA+uvCWShMMIDfpN
	 f89D91k8QTGVOStHoQms4tGYDDP6H1imOPn9rI6yDCPSU2fei79wGGXOeUAObYZHzh
	 xbAdFZXuJ/vz+4h5DePKvQiI+9gjohBJGdlS9/R8/MbEt41d33ZAvcWtNLKqK/xwYA
	 WOITE1fuS+3RQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 14/14] nfsd: use do_lookup_open() for non-creating open requests too.
Date: Mon,  6 Jul 2026 10:36:46 -0400
Message-ID: <20260706143647.1243020-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705222032.1240057-15-neilb@ownmail.net>
References: <20260705222032.1240057-15-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23069-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71C2B71242E

Hi Neil,

Thanks for jumping on the Sashiko findings. Codex review identified
three correctness concerns which I've confirmed with Claude are not
false positives:

1. do_lookup_open() takes write access unconditionally.

	error = mnt_want_write(parent->mnt);
	if (error)
		return ERR_PTR(error);

   Fine for a create. But a read-only OPEN with no create now returns
   -EROFS on anything mounted read-only at the VFS layer: squashfs,
   iso9660, a read-only bind mount, a snapshot. The old path didn't ask
   for write until nfsd_open() actually opened the file, and for
   O_RDONLY it never asked at all, so these opens worked.

   Worth stressing that this isn't the "ro" export option. That keeps
   the underlying mount writable and is enforced in nfsd, so it's fine.
   Only genuinely read-only mounts break, which is probably why it
   slipped past testing. Can we make the mnt_want_write() conditional on
   O_CREAT? The read-only-open setattr path already re-takes write for
   itself, so it shouldn't need the blanket grab.

2. We open the target before checking it's a regular file.

   do_lookup_open() runs dentry_open() on any positive dentry, and
   nfsd_check_obj_isreg() doesn't run until nfsd4_open_file() returns.
   There's no O_NONBLOCK on that open, so an OPEN of an existing FIFO
   sits in fifo_open() waiting for a peer, and it waits with the parent
   directory's i_rwsem still held from start_creating(). One client can
   pin an nfsd thread and the parent directory that way; a handful of
   them and the pool is spent. A device node does the same thing through
   its ->open. We used to know the type before we opened anything, so
   could we check d_is_reg() ahead of the dentry_open()?

   In fairness this isn't new to 14/14. "always open file in
   nfsd4_create_file()" already opened existing files for the UNCHECKED
   case; this patch just extends it to plain reads.

3. Mount crossing and the target export check are gone.

   nfsd_lookup_dentry() went through nfsd_mountpoint() and
   nfsd_cross_mnt() and revalidated the export it crossed into.
   start_creating() is a plain one-component lookup, and we fh_compose()
   against the parent export. Bind-mount one regular file over another
   inside an export and the new path hands back the covered file instead
   of the mounted one, with no check_nfsd_access() on the real target.
   Narrow, since only file-over-file mounts reach it (a directory trips
   the isreg check), but the behavior did change.

Actually some of the suspect logic is added in earlier patches, only to
be exposed by this final switchover patch, so I'll wait for a re-roll.


--
Chuck Lever

