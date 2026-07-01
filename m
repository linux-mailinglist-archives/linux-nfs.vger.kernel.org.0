Return-Path: <linux-nfs+bounces-22906-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N8qzOAkQRWoM6QoAu9opvQ
	(envelope-from <linux-nfs+bounces-22906-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 15:03:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3936EDC72
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 15:03:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WnEaw2Lj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22906-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22906-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A810309A7B1
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2F481252;
	Wed,  1 Jul 2026 12:41:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129CA3FC5A7;
	Wed,  1 Jul 2026 12:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909698; cv=none; b=LJNxcPA+EEYui7oeL0MaMlxqghmD1FFu1PKxrzwyHw3kXR1tuLjOSsvUyPmnvZ9SdaJg+4Fsjt/xd0fe6p6pNtqWSDis7DitXgfz0HdbIrc/0h7PTH1cOGp9NMmcGT7ZEwhJai4rSbwywV0JVrEzd6O+sxTyxWGtGrAupCFfmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909698; c=relaxed/simple;
	bh=ZXIp2Z58snN3F8TwDn5Nz5njprLCjImPlGQhfEUmWKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LoEdofcoEhPvVJdk2ftzsX/daUOqIZsEQpcuCURxT9cj0rABxhNatip4nubDVlpd2Ww3oVgn99gkFQk8+NPQB7JTr5Q8cOMMBVWvfwaIFDXmY6rzu4J4UaN9N0hvIkrbkODHj0KArf9axll0yi8CAtStcrgDn03pvQbbEGQjZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnEaw2Lj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9551F000E9;
	Wed,  1 Jul 2026 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909696;
	bh=GDsgDUzrN7/ijCuT2ET7adecGbro2Ab1VzUfehQAMxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WnEaw2LjeVgDS+XRDYbI097XM9/ZmiYluFr8VTL2rcS9CJCHS7/WoWzvQAwqVC09f
	 AvkdHIdBadDhLYO+lF1VwLFaeddsDRBkz4X0+MAQQSlekJQ5suZKVgxrWpB7FaqV9X
	 UKbWEBv14WHKwyw9LtAZX4Fpen37/5qZIe+dAgL7VIV9hsEaY9YMdlgq8MCuQ/SllJ
	 kVLbr5RTuAc7Nu/psAIBIeNDZKCjZs/TMFyZKL8YWUP7I0NV2HlKFupBeXMCuueGZp
	 XaglIjp7hI8rB9CyD2nrCoHfAUzH9An91GZFRYnkjUUaDOVe51au7RSlSGHvPHXXCR
	 +6oOYx6BwDySg==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Jan Kara <jack@suse.cz>, 
 David Lee <david.lee@trailofbits.com>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jann Horn <jannh@google.com>, 
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>, 
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260701114438.24431-1-david.lee@trailofbits.com>
References: <20260701114438.24431-1-david.lee@trailofbits.com>
Subject: Re: [PATCH] fhandle: reject detached mounts in capable_wrt_mount()
Message-Id: <20260701-umleiten-anbiedern-mittragen-03f9e77a4178@brauner>
Date: Wed, 01 Jul 2026 14:41:29 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZXIp2Z58snN3F8TwDn5Nz5njprLCjImPlGQhfEUmWKU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5cv3tbml1/LO7W3/Wx9/O519lZfDf5073+d/5Te/fh
 s+Vxhf+dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE4zTDXznZSqnX7HOS+wp1
 Tie8n+hh6r7Lr6rkl7vuxA0H2NfILWRkeLJibcWVqw2qnBtPHj9R+89M8sXck3vTD77yjtjwdXl
 mMAcA
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:david.lee@trailofbits.com,m:cel@kernel.org,m:jlayton@kernel.org,m:amir73il@gmail.com,m:jannh@google.com,m:dominik.czarnota@trailofbits.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22906-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,trailofbits.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RSPAMD_EMAILBL_FAIL(0.00)[brauner@kernel.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B3936EDC72

On Wed, 01 Jul 2026 11:44:28 +0000, David Lee wrote:
> fhandle: reject detached mounts in capable_wrt_mount()

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fhandle: reject detached mounts in capable_wrt_mount()
      https://git.kernel.org/vfs/vfs/c/b2f046af8c6c


