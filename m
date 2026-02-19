Return-Path: <linux-nfs+bounces-19043-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMllOSaLl2n/0AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19043-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:13:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 507131630D4
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1F20300682B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7432AAC4;
	Thu, 19 Feb 2026 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUsEDFFb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093D329E7E
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539234; cv=none; b=s/f9Sqp/MnhbjqhFu5MvqMgVuhza3r6u+3aJ8E/7TDU9VrUQknZgikbnly8qeFaPv9sKG2pwZPcOZyQPvKRUHnt7jURtYK2cyPATMLOO+aPT7mjeIgikExsWUM5XZKpDYZzXPUz+gcpmPda+E8PEBkPLm+zlGN4boSHz3Bd9gnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539234; c=relaxed/simple;
	bh=LTpSIvaK6zmtX9S4eNKjhMxY6+/e7lCyrQRDkCdwUwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQ77abP5XoTlRAbzJa5h5O/dJH8Q8GhKFrKkvLV02P0sXaQM4pe+PhYgl49Hf2wazF5nzIvW7xkXKHuSaae3RE1Bsrsxy6ZNaMRuumnHgsymsZkMcvKxspY+b5SIr5qsGKF7+r443BqDXGABYp1na6mAcmTbtz1/QMmHoHMmeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUsEDFFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D08CC4CEF7;
	Thu, 19 Feb 2026 22:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539234;
	bh=LTpSIvaK6zmtX9S4eNKjhMxY6+/e7lCyrQRDkCdwUwo=;
	h=From:To:Cc:Subject:Date:From;
	b=sUsEDFFbGF+lI785sF8rf1/INVbIseNXpC7ltM5vgPFhXzIfVqzIthpZvxPni+Ox+
	 UaiPVaxYvNm/ikxyfLiRvBm5fsxvBK4zZvG9fUNtg39ApFhtFGS8kP4yVzg0jwyPEw
	 Zo5Nw++JzAaK7Ld9LECbouAUdT0YmfG2KdjJgWW+bYwm1nUViOgBHJBU18Oxq3oXs2
	 NNg9u1XctkafqkP/duhs9LwHvZX9DpaEYCVVbUD+bVDAh0d6t81Gq0ofadH6UXEfFr
	 hhiAhMB6vMfCALTsZyyZTPL9UAGXq8iUaWEEnLEbQY1wNv1mGgVYNZhocqJ+8ctcmi
	 BPrePtSVSi2hA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
Date: Thu, 19 Feb 2026 17:13:41 -0500
Message-ID: <20260219221352.40554-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19043-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 507131630D4
X-Rspamd-Action: no action

Hi,

This patchset aims to enable NFS v4.1 ACLs to be fully supported from
an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).

The first 6 patches focus on nfs4_acl passthru enablement (primarily
for NFSD), patch 7 adds 4.1 nfs4_acl passthru support (DACL and SACL),
patch 8 optimizes particular nfs4_acl passthru implementation in NFSD
to skip memcpy if nfs4_acl passthru isn't needed, patches 9-11 offer
the corresponding required NFSv4 client changes.

This work is based on the NFS and NFSD code that has been merged
during the 7.0 merge window.

This patchset is marked as RFC because I expect there will be
suggestions for possible NFSD implementation improvements.

All review appreciated, thanks.
Mike

Mike Snitzer (11):
  exportfs: add ability to advertise NFSv4 ACL passthru support
  NFSD: factor out nfsd_supports_nfs4_acl() to nfsd/acl.h
  NFS/NFSD: data structure enablement for nfs4_acl passthru support
  NFSD: prepare to support SETACL nfs4_acl passthru
  NFSD: add NFS4 reexport support for SETACL nfs4_acl passthru
  NFSD: add NFS4 reexport support for GETACL nfs4_acl passthru
  NFSD: add NFS4ACL_DACL and NFS4ACL_SACL passthru support
  NFSD: avoid extra nfs4_acl passthru work unless needed
  NFSv4: add reexport support for SETACL nfs4_acl passthru
  NFSv4: add reexport support for GETACL nfs4_acl passthru
  NFSv4: set EXPORT_OP_NFSV4_ACL_PASSTHRU flag

 fs/nfs/export.c          |  23 ++++-
 fs/nfs/nfs4proc.c        | 112 +++++++++++++++-------
 fs/nfs/nfs4xdr.c         |   2 +-
 fs/nfsd/acl.h            |  11 ++-
 fs/nfsd/nfs4acl.c        |  69 +++++++++++++-
 fs/nfsd/nfs4proc.c       |  32 +++++--
 fs/nfsd/nfs4xdr.c        | 194 +++++++++++++++++++++++++++++++++------
 fs/nfsd/nfsd.h           |   5 +-
 fs/nfsd/xdr4.h           |   2 +
 include/linux/exportfs.h |  22 +++++
 include/linux/nfs4.h     |  23 ++++-
 include/linux/nfs_xdr.h  |  11 +--
 include/linux/nfsacl.h   |   7 ++
 13 files changed, 431 insertions(+), 82 deletions(-)

-- 
2.44.0


