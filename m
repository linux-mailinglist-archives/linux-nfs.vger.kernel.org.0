Return-Path: <linux-nfs+bounces-21521-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xxNNEKxVA2qQ4wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21521-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:30:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48B524B45
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C474303FA86
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDAD3C4163;
	Tue, 12 May 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSo+SVnz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323C3C98B5;
	Tue, 12 May 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602377; cv=none; b=LPrBMr/a2Yzl/YQWD4yAcOo2KOIRDK04CguRH2+FyYlxPiJ/7hd0c8eYut/BtWnoehBVOybAirD/tBTPDKOC0wAEJPM4i99wandxOZa1AgKnx5whEPSHiFSXsf/93ok4016tgSv82vXDHp9zwgX8SfgetJnpPhtyKpz/INukg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602377; c=relaxed/simple;
	bh=WZuJNG4sAbNnb7qhDzdMYy4rzXjxDjXnI5ZzLQR+0YI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q1U7ISEbofa1uenRpTFP7zcFNJeD7KSf93BHod/ccJZvb4EKOyqCnjfTagOrbLgiaZZYtVl3igySxeGhcs/fI3kWh/2DzCAHdCgCoy1N5kGFuS8hYRM4IhbIYeSpGWWax/8b1S1j5ubEuFF9Wd8uz5OtM2p0AYz8W/Kz0690smQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSo+SVnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FCBC2BCB0;
	Tue, 12 May 2026 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602376;
	bh=WZuJNG4sAbNnb7qhDzdMYy4rzXjxDjXnI5ZzLQR+0YI=;
	h=From:Subject:Date:To:Cc:From;
	b=WSo+SVnzjHZjGwrPkMA+qBzRAenvW+wDFNgBE222k9ZxbbacKkXisqRf/OsjWmgk3
	 91Rc7aUJo15HSN+OQkqBqmc6TgP+SGj4lmdsTiSRJmfJPZOSzRHpgbirCniUp4SGos
	 ssRSNVbClH2sS6h0zs5lljyn3WBzs9UwRp41bK11sotzYhgX/vG7WfclKpgxA8CwX6
	 RVvZUDbVeXqoW5DGM0WI7ifwphVAiNFQfhvD4uZO8ONQxC2B1pdvb1z9dM0hntT6Li
	 5fPE+2DSC7CP7SEqgdeqtdsUqiBFbnVZSHFJYGX7xdOpuKnjdXLaVlaD5lTNxiOdDI
	 zBK9iMeosi/Pg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] nfs: remove the fileid field from struct nfs_inode
Date: Tue, 12 May 2026 12:12:41 -0400
Message-Id: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Mj3by04sy8fF3DNMtEi+REozTj1BQloOKCotS0zAqwQdGxtbUAkDd
 y8lgAAAA=
X-Change-ID: 20260512-nfsino-1f9a8ca2f3ed
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WZuJNG4sAbNnb7qhDzdMYy4rzXjxDjXnI5ZzLQR+0YI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqA1GCw938TFXNR/pLhPB/pxtAh2CDRxoTyMjb5
 ojVkMeWhZqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagNRggAKCRAADmhBGVaC
 FReTEAC66J2no++XHfJVdEIvu3gFqKV74c8nIzAw79+lUVpT2TVrU4uLxteLAZjh828QzjwoEE+
 YxOKZ3H62JZJUFy804mCsP1T69B26VYgvLV+0kgm4F1IATbikCXLbaW7J/hyUG4Nn1bnZijHQYJ
 2i8nXDf44K1dX5J6rUyf/bxoVpX4eWwG1k0jLRx1AkNvC+xrbKMGZefU7RLklUVySqqlIU5gMEm
 QI2SowvFFUHAeV5gYGMBsZcD60BCovgfShCjEQk87rdfqLjGpSnUOPHAZFDOdPcF90QA87wH0PV
 hzvRCS49+8HGfmthUpkFVZQpdQnA4KUHG2th41aEuVcczPElD73J69kBeAAFYTYNrWCbP4ETheY
 +EbF5VpLYltkoBKgic8lc9lJTbTiVUwoOJEGvkk7ZDDi/DTZx1QRKgTKz+464FxdQ6Y8a1pbCxH
 zLRYpzwQF+xMiRJWzWJJdj9sUfd5USijrUkdJMOQPe9jE2ogBdCJsjKHKqIJiRgkGB7G2B4S43I
 f5EuKQSok5tPLCTQW1FN9fYnTedhPZv3/sh6a7XKjGdEtj84rooEJW69y1amJbj6AzXWl6Mu87p
 e5EYeGRqREqA5fy1OkxySLDKldhgW3iTCzbwBmApvUy4yTpZaUDvQUSHAVMQJ+fSWHRca+4VHkK
 cxnzkznlX8tpQFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 6A48B524B45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21521-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

v7.1-rc1 contains patches to make inode->i_ino to be a u64. With this
change, there is no need to keep a separate "fileid" field in struct
nfs_inode.

This patchset eliminiates that field, and the inode number hashing
machinery that is no longer needed. This shaves 8 bytes off of each
nfs_inode.

Trond/Anna: please consider this for v7.2.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (4):
      nfs: store the full NFS fileid in inode->i_ino
      nfs: remove nfs_compat_user_ino64() and deprecate enable_ino64
      nfs: replace NFS_FILEID() and nfsi->fileid with inode->i_ino
      nfs: remove fileid field from struct nfs_inode

 Documentation/admin-guide/kernel-parameters.txt |  7 --
 fs/nfs/dir.c                                    |  4 +-
 fs/nfs/export.c                                 |  6 +-
 fs/nfs/filelayout/filelayout.c                  |  4 +-
 fs/nfs/flexfilelayout/flexfilelayout.c          |  6 +-
 fs/nfs/inode.c                                  | 87 +++++++++----------------
 fs/nfs/nfs4proc.c                               |  4 +-
 fs/nfs/nfs4trace.h                              | 79 ++++++++++------------
 fs/nfs/nfstrace.h                               | 84 ++++++++++++------------
 fs/nfs/pagelist.c                               |  2 +-
 fs/nfs/pnfs.c                                   |  2 +-
 fs/nfs/unlink.c                                 |  2 +-
 fs/nfs/write.c                                  |  2 +-
 include/linux/nfs_fs.h                          | 25 -------
 14 files changed, 123 insertions(+), 191 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260512-nfsino-1f9a8ca2f3ed

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


