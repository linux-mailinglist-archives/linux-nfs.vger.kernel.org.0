Return-Path: <linux-nfs+bounces-17435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B3CF11E0
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B533009FBC
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D944400;
	Sun,  4 Jan 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBnfrtT1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9323535E
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543024; cv=none; b=BEfzDrvOAt+Y+BNpYWoz7kOcujlnK7boQuJCPK4RFXGdOTOfGtRBwFhLdLP0iu5vjgVNXxXgh/oRFf+NKQ4ExEleu9WpvHjsJtcavjshUCrJsASXwQzF8DU9OiyMZBWtnMpVxRyVOtbxfEQ6WgBlrmrRnJSazFgik54B4BE743E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543024; c=relaxed/simple;
	bh=IFyIe0m+yAIpXlrr/8Fs2XLks4mh51jdapS7piAplw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gb8X6J0NNmhOUVM1Q2SZWP4JZ+EkCgtkHAB1p2/7oN30B0FZ+v+VLZhma8WkYxqxFYEah3ZHp23fxS84QDFddPSFKHSHr4j73WIbx4qU5VwEpOkP8S9Wu02lkeXdgbsMf4zwpqxmK3AO7H4u73bIFajKZ3M7OOA/h7616quWZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBnfrtT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFFDC4CEF7;
	Sun,  4 Jan 2026 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543022;
	bh=IFyIe0m+yAIpXlrr/8Fs2XLks4mh51jdapS7piAplw0=;
	h=From:To:Cc:Subject:Date:From;
	b=oBnfrtT1epNC0cHpK7X7LfMrjZ/AUoQdfctaQJcsVfgY6UKHUDdvezWlU4QkjtWdx
	 tWBiYb/FGJNTe4QO+YIc1AxfhSSUU8YmNGMMIYNz+KgCy0fCUdjFQZ1tS2UArnLAVb
	 4DCjl/bgEKUSc1Qx2KE4uL55l3ien+XN2oKOu2NsCFWh0fpS2pE0TpsGbRX23gfWMY
	 lXvL2UpyF6q+5PlnkSREppXJXkMsi8MRm2pzwcsQwqW0RxWsQQREPoQ/f6sY1AVFCo
	 G+Ni+xINyLmNzh3dfsjec8+sNlhK7ItuOelnWcE+gPmyWqeDMgdYeacBQSsBbkAYqN
	 RPCegwFlKTf7g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 00/12] Add NFSv4.2 POSIX ACL support
Date: Sun,  4 Jan 2026 11:10:10 -0500
Message-ID: <20260104161019.3404489-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The Internet draft "POSIX Draft ACL support for Network File
System Version 4, Minor Version 2":

  https://datatracker.ietf.org/doc/draft-ietf-nfsv4-posix-acls/

defines an extension to NFSv4.2 that enables POSIX draft ACLs
to be retrieved and set directly, without the lossy
NFSv4->POSIX draft mapping algorithm. The extension adds four
new attributes to the protocol.

This patch series implements the server side of this extension
for knfsd. The mechanism is analogous to the NFS_ACL sideband
protocol used with NFSv2/3, enabling POSIX draft ACLs to be
manipulated directly by getfacl(1) and setfacl(1).

The current implementation does not support "per file" scope,
where individual file objects store either an NFSv4 ACL or a
POSIX draft ACL. Instead, the implementation assumes POSIX
draft ACLs apply to an entire file system when support for
POSIX draft ACLs is indicated.

Based on the nfsd-testing branch from:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Changes since v1:
- Fold the patches with fixes into the first 8 patches
- Ensure the series is bisect-able
- Add CONFIG_NFSD_V4_POSIX_ACLS -- this feature is experimental
- Set "SUPPATTR" bits only at the end of series
- Use xdrgen, where practical, instead of hand-coded XDR
- Refactor SETATTR/CREATE to integrate better with existing APIs


Chuck Lever (3):
  NFSD: Add a Kconfig setting to enable support for NFSv4 POSIX ACLs
  Add RPC language definition of NFSv4 POSIX ACL extension
  NFSD: Add POSIX ACL file attributes to SUPPATTR bitmasks

Rick Macklem (9):
  NFSD: Add nfsd4_encode_fattr4_acl_trueform
  NFSD: Add nfsd4_encode_fattr4_acl_trueform_scope
  NFSD: Add nfsd4_encode_fattr4_posix_default_acl
  NFSD: Add nfsd4_encode_fattr4_posix_access_acl
  NFSD: Do not allow NFSv4 (N)VERIFY to check POSIX ACL attributes
  NFSD: Refactor nfsd_setattr()'s ACL error reporting
  NFSD: Add support for XDR decoding POSIX draft ACLs
  NFSD: Add support for POSIX draft ACLs for file creation
  NFSD: Add POSIX draft ACL support to the NFSv4 SETATTR operation

 Documentation/sunrpc/xdr/nfs4_1.x    |  56 +++++
 fs/nfsd/Kconfig                      |  19 ++
 fs/nfsd/acl.h                        |   1 +
 fs/nfsd/nfs4acl.c                    |  17 +-
 fs/nfsd/nfs4proc.c                   |  96 ++++++--
 fs/nfsd/nfs4xdr.c                    | 356 ++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                | 167 ++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  12 +-
 fs/nfsd/nfsd.h                       |  17 +-
 fs/nfsd/vfs.c                        |  34 ++-
 fs/nfsd/vfs.h                        |   3 +-
 fs/nfsd/xdr4.h                       |   6 +
 include/linux/nfs4.h                 |   4 +
 include/linux/sunrpc/xdrgen/nfs4_1.h |  73 +++++-
 14 files changed, 822 insertions(+), 39 deletions(-)

-- 
2.52.0


