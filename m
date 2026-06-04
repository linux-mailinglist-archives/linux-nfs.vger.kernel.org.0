Return-Path: <linux-nfs+bounces-22264-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VfIAC1osIWpUAAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22264-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 09:42:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104C63DB2A
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 09:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CHBMf75p;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22264-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22264-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E921F303A24A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DD3955CC;
	Thu,  4 Jun 2026 07:40:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE900394EBD;
	Thu,  4 Jun 2026 07:40:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558845; cv=none; b=TrNHEZqp7A4TmRh8Xhy/Om9PSmi1N8LWA2CupOqet2Ju4njA/NcAQVuN2P7rDHNXodWq+dad3aPp/VF4iKgaeSJwnmvOEKdnZcZBedrDhOkxkKz+mNFEqSKyLLQrutCOUld+IZ/hhfI0G4K873VgrzECBxRmnZpGI76yfl+PBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558845; c=relaxed/simple;
	bh=4QM7ROL1SK9yxh8L5lBMvpm6fMo7dahyZCc93ONZQDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCRLjuIUXmgEFiLWJ34wjjkPjWaCOvh2THhHGZbqRtT13cYVeRwOYiqri3retPsro3bTQ7UkACgTaWnckIagr7i5HaxWqn/+Og0ZMhAAO8uPX3UxYtTf7AWZ9CBINQVV/t7vejxHreMAEcBnFACqEkYhzMqgOgZFYfouwai+HXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHBMf75p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ACD1F00893;
	Thu,  4 Jun 2026 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780558843;
	bh=aNBGIr0KxjA7l3ilDhG+ohSxX/5+Sr0YpPEZ7HNr+3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CHBMf75ppmt7XID9XShlwqpJD1xbaUgL1IQPU1jTt8g7sqO8+MR9rP8lL92IglYyE
	 dEgs8PdJaNZQ34FiZ54RqNT3Q1k28D5Xz8DCqxxXOFfq0vcQcsUn5kbbV7L+vLF3dJ
	 MwyOS6i1E2r6vmC20RYOU3jBhpfLuUXl157dooFv4ddAbyRDvUWIo3IyaRSwrqCA+R
	 Lky90V9f0nK2VWKEQvdyJMwiVyrBhzOJePD+a2P77kis3ux0PUzMIzfKRfvd3viOS3
	 lzB05O0GB8FwW2Ac7mjHgp0j6D5Q4DiO1skwtYKZEdd9HGUGwb001i1ggy0qUDscZQ
	 b6KBy6Z6CWN/w==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
Date: Thu,  4 Jun 2026 09:40:37 +0200
Message-ID: <20260604-hingibt-rechen-medien-fd15311d6cc7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603-vfs-fhandle-uaf-fix-v2-1-d05db76a5084@google.com>
References: <20260603-vfs-fhandle-uaf-fix-v2-1-d05db76a5084@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=brauner@kernel.org; h=from:subject:message-id; bh=4QM7ROL1SK9yxh8L5lBMvpm6fMo7dahyZCc93ONZQDc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQpan+TM51t/11zns/lxdoPZ0baJ24+U7X9K5PQ1YSch kUXtXJaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbitIjhv3c2X+HcZ/nVGw0m vKyZPNFEYSrLH6Ey7qcMhfmca3bxPGBk+Bn+6Mma2euy9uQcSfb0mSgrk3woKehB9+vi5lsOBfW GzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:jannh@google.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,suse.cz,oracle.com,kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-22264-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8104C63DB2A

On Wed, 03 Jun 2026 21:31:57 +0200, Jann Horn wrote:
> may_decode_fh() accesses mount::mnt_ns without holding any locks; that
> means the mount can concurrently be unmounted, and the mnt_namespace can
> concurrently be freed after an RCU grace period.
> 
> This race can happens as follows, assuming that the mount point was
> created by open_tree(..., OPEN_TREE_CLONE):
> 
> [...]

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

[1/1] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
      https://git.kernel.org/vfs/vfs/c/40ab6644b996

