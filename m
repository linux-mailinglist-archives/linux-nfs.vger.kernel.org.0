Return-Path: <linux-nfs+bounces-17694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6838ED0B3F7
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3C8C30325C4
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860032773DA;
	Fri,  9 Jan 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4pwt80C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3A364025
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975709; cv=none; b=ife9lEb8V8YDASJi2wG19R+R8ZgSzyysbFZyDHOCjIEnbOgjjkA/lepeFZ1U8a8WDd/UJNm06rJR31KqbJ/bnBV5GrloxgzQvKEnnX9JvpJw0qumQsrrJwFHalgbm5gR0EYPTXonV7rou5UfrVkulXuTflgjTGjo2uhUdFPtuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975709; c=relaxed/simple;
	bh=63ymWEYlxH0WaHOGFyv1vm3+nNcspcdGPCIHlkeZ/bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUvt1YSmRh6wfl6N3zwGPXQtGlwwRlRs5AqNulHgEYACU2Y3wa7xtqSzfMhDh5CPpa/amKDf6zpp/xSZFKnP0r0xfWrITipKg+5xC6OjsORFU4Kqc3zdiE3e6Aaf417aHZR4g/W6YeZUuFBRii0mbafASRPQJH6HblNbHkRNrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4pwt80C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3722C4CEF1;
	Fri,  9 Jan 2026 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975709;
	bh=63ymWEYlxH0WaHOGFyv1vm3+nNcspcdGPCIHlkeZ/bE=;
	h=From:To:Cc:Subject:Date:From;
	b=C4pwt80CDRmHd39leFQFUhKkj93mWZbQ/cTHUOUWAKmRO/txHa/PtoXpVDrzynZdh
	 Vvfbrt5spTPK9vop8tsM95/FH7uoRezWG4gyCW92eItTxQuE4fF4HVRkFILTErpjn8
	 dAYjQRMy59uoYOIGXDO4viSCC51oIimEP+/FVyPYWgQc9SvCyXeEDELJL23N0fIt5v
	 jCz15lc2N/53I0vyQiAGtIhAAmo8iQKIIDJLeMPWNEu8EjcZTBO1Ne5Q+cMBddGFQs
	 F54SPKPCvowxtSwKzwEIjDSEnnynP1qSTKp8BY1Hd10iYc0ZdPncYOOA7B+a+a2lPT
	 ptYiunfQ+aosg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 00/13] Add NFSv4.2 POSIX ACL support
Date: Fri,  9 Jan 2026 11:21:29 -0500
Message-ID: <20260109162143.4186112-1-cel@kernel.org>
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

Changes since v2:
- Remove NFS_MAX_ACL_ENTRIES check
- Clear POSIX ACL fattr4 bits when CONFIG_NFSD_V4_POSIX_ACLS is N
- Add xdrgen support for '%' pass-through
- Update the .x based on Rick's -01 draft

Changes since v1:
- Fold the patches with fixes into the first 8 patches
- Ensure the series is bisect-able
- Add CONFIG_NFSD_V4_POSIX_ACLS -- this feature is experimental
- Set "SUPPATTR" bits only at the end of series
- Use xdrgen, where practical, instead of hand-coded XDR
- Refactor SETATTR/CREATE to integrate better with existing APIs


Chuck Lever (4):
  xdrgen: Implement pass-through lines in specifications
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

 Documentation/sunrpc/xdr/nfs4_1.x             |  61 +++
 fs/nfsd/Kconfig                               |  19 +
 fs/nfsd/acl.h                                 |   1 +
 fs/nfsd/nfs4acl.c                             |  17 +-
 fs/nfsd/nfs4proc.c                            |  99 ++++-
 fs/nfsd/nfs4xdr.c                             | 347 +++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                         | 248 ++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                         |  12 +-
 fs/nfsd/nfsd.h                                |  24 +-
 fs/nfsd/vfs.c                                 |  34 +-
 fs/nfsd/vfs.h                                 |   3 +-
 fs/nfsd/xdr4.h                                |   6 +
 include/linux/nfs4.h                          |   4 +
 include/linux/sunrpc/xdrgen/nfs4_1.h          | 106 +++++-
 tools/net/sunrpc/xdrgen/README                |   2 -
 .../net/sunrpc/xdrgen/generators/passthru.py  |  26 ++
 tools/net/sunrpc/xdrgen/grammars/xdr.lark     |   6 +-
 .../net/sunrpc/xdrgen/subcmds/declarations.py |   4 +-
 .../net/sunrpc/xdrgen/subcmds/definitions.py  |   5 +-
 tools/net/sunrpc/xdrgen/subcmds/source.py     |  24 +-
 .../xdrgen/templates/C/passthru/definition.j2 |   3 +
 .../xdrgen/templates/C/passthru/source.j2     |   3 +
 tools/net/sunrpc/xdrgen/xdr_ast.py            |  39 +-
 23 files changed, 1037 insertions(+), 56 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/generators/passthru.py
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/passthru/definition.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/passthru/source.j2

-- 
2.52.0


