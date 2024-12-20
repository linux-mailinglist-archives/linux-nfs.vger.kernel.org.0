Return-Path: <linux-nfs+bounces-8686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73109F95B0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B82216E501
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A4218EAD;
	Fri, 20 Dec 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOBLWjV2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AE218EAC
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709359; cv=none; b=W1XXOMNiwAfXxVB6rOABNsTK37VR50GT1p02ds4FDt2+6FHWM31u8PjIRxmq733q8tfKF/QGgNJc4eTGnGCYP7mKIiQMOoYwXPTkGcuyXzBy1ViPn8n9/NiwUi4Fk2dFQfxJDek7jGcmdgdNQyjZd1UiN+QqrijFtRneY3HiBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709359; c=relaxed/simple;
	bh=kbxdZNTjuKan7odfwfa5biJV0Mm90GgtZkwsB+SSedM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwzAEjgoYwJSgZWeifpSR9/R4048DW4qxCGiMxpo7wm2+WUDEH+ENGD8f1XyRSfhOmv5WPtfv6lJpo1RNajUQ6ByjVAW//uAxq2o8yULqpaPWLpcXc/VdBi0CyyCmiGZQ1VTGCH+bMMJZZpQJjpvAC//A6Mcm3wN/OooSNMwHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOBLWjV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81222C4CECD;
	Fri, 20 Dec 2024 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709359;
	bh=kbxdZNTjuKan7odfwfa5biJV0Mm90GgtZkwsB+SSedM=;
	h=From:To:Cc:Subject:Date:From;
	b=MOBLWjV24q3KcZY0r7zD7pZOI4f6sypMB7LjVNTCHYrjqRMgoQg2VlLaE1+OJMpMz
	 4JQzLPJVBQjhlED9Fr+dz/ILuxArt31evUs2v9nTfNOn/U+FS2g4uOIwRE9za1RXxN
	 1NSt70TQt3FIb5xYroyreaHqjaxdVyoYkab3D1ipDD8tnuxFJKO5WijE1aUBirfc0Q
	 f2EW+yult+haM/iEnlCDMyfDNX9K3wtY2VSp2TloRAVnBVSjE8lUy1kSKVjCai2n7B
	 2o1ZC0q1WqpOs9p/agQ8kEtz9jNLt2pJTLljfbV7k5aB8QaA4v18m81FvPBGedGyke
	 coKQkNh2QTF8g==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/7] Client-side OFFLOAD_STATUS implementation
Date: Fri, 20 Dec 2024 10:42:28 -0500
Message-ID: <20241220154227.16873-9-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=chuck.lever@oracle.com; h=from:subject; bh=Z3frVZgNXvqHTxVR1XSAKaPqBXmV76O8HFXn59MvSow=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBjtRuyUKL/qWgP0RBlXM5+j61JD6W9Pm64t zcU0GmRcnuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQYwAKCRAzarMzb2Z/ l+mrEACo3N9jHzOL0s6xpHuFUJVvVmaLXEoT8z5aENq64TXayOtRm+Bf3JDv3rnwd8QJC/p8Lmr rHTnDzMgJtn5s9kR/dzb0MUROlyX+OD1YVyh7llfL+9JeO3sOj5JdaB8V2ccb2IS1vLYQxJGR5/ xKh5XZ6DlKj4MPNEKpAAvo+Qt18DBRtf5Z7J717a8VGlo5EI9cZlAriCgeKOoPkURUzsb0U0XRo e277kccqieT3raFe0JQy4j6gszoi3UAbQI8EIO37WNYJGKi4KfB7JEqrMuaHtDGiD+mQeHtJNha PwPojr0k35Soi8ZK8iW5tGRpyRvL4c4vrBl3gMT2/smMgw9cGL09ID/8podhwouDTF/XISHF7eK pFsl3oCvsSN6gg+wqo7Idk6cdP2fHwHj+IpFBxtFfXczAFs3FAMlebivumzflL7n6ib/tefz8Fw Y9DwedIrNTCrv4ikPzohW4J9fUe+bFTTWRgabKJOsdX1OD6bLk/5qG3NxKWuTNqLlkZo0pWPa+b oGT+pShJxxgHmpm6YMLXpNt5wOK9e+2Nmlbf/9EYJAbqNfhnr/X6wUfUP3VzKocIn7blBmf7Ii/ d5Ehj5lU1y3nJMufbUY+Ni3JF/TnVm19oZ11vb6dGsC9z7FppSotmd89y31+6nPaL+DNWg73ZiB 8ZxUGx7l5ogCKbw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

SCSI implementation experience has shown that an interrupt-only
COPY offload implementation is not reliable. There are too many
common scenarios where the client can miss the completion interrupt
(in our case, this is a CB_OFFLOAD callback).

Therefore, a polling mechanism is needed. The NFSv4.2 protocol
provides one in the form of the new OFFLOAD_STATUS operation. Linux
NFSD implements OFFLOAD_STATUS already. This series adds a Linux NFS
client implementation of the OFFLOAD_STATUS operation that can query
the state of a background COPY on the server.

These patches are also available here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=fix-async-copy

Changes since v1:
- nfs42_proc_offload_status() now uses a synchronous RPC

Chuck Lever (7):
  NFS: CB_OFFLOAD can return NFS4ERR_DELAY
  NFS: Fix typo in OFFLOAD_CANCEL comment
  NFS: Rename struct nfs4_offloadcancel_data
  NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
  NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
  NFS: Use NFSv4.2's OFFLOAD_STATUS operation
  NFS: Refactor trace_nfs4_offload_cancel

 fs/nfs/callback_proc.c    |   2 +-
 fs/nfs/nfs42proc.c        | 188 ++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs42xdr.c         |  88 +++++++++++++++++-
 fs/nfs/nfs4proc.c         |   3 +-
 fs/nfs/nfs4trace.h        |  11 ++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   5 +-
 9 files changed, 275 insertions(+), 25 deletions(-)

-- 
2.47.0


