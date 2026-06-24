Return-Path: <linux-nfs+bounces-22812-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DlQdJd4tPGorlAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22812-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:19:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE24A6C0FE4
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:19:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z755UwTO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22812-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22812-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9E330097CE
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78B82F7EFF;
	Wed, 24 Jun 2026 19:17:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD4320CD9
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 19:17:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328628; cv=none; b=hibC4dIHzo2BphTxhKhC/KkaEraFpGPYQxI5ZRSx49TguPT2pztboF8zt4bn2i3yfHyK7Dr7jLvkl0RIsEXIwqcuRnP1K8hJuuzaXf5bdz6KrRF/x2ufYKLCT4Opb5Vel5lMvnzzOyazye6rQewaKAEhGcoptIQoc+aLaJtInHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328628; c=relaxed/simple;
	bh=Zdm4rS/Ub1+0TTa10Gga7CeEJ4MS58wculQdW3XCrs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pg99To2tkxIYZxy+gk0EWUwv0zl+wNcFzx4etqhGh4CfDxZI7F6hQ+ytU7n8/iSgpH1d5v4cRVycxGKkCBRFDaM4Kbom0kx6mq9PtFvhhxtRUqifpFSNtUotMHosQTPYwRdVkbL+KOV3PDC2zm95SWNU6ASkgYCW748A4uyONgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z755UwTO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381201F000E9;
	Wed, 24 Jun 2026 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782328627;
	bh=sPLkGRgyg8K83f+QhWsXShogUEL9VSzSZlEhhAtBPDk=;
	h=From:To:Cc:Subject:Date;
	b=Z755UwTOcb2t3S8kov5iHW1wRvQABUjOVK+TWfgBT02FSri2oEnzdTd1GqCOVCt8R
	 hxu+QYbSuLxcM4RrmSGl7HL1o0MeoqAm0Gkfz8vqVif1t940ScrDzwyjdIRsPf1b3/
	 w8TMAcvuIQi5QhJ38HaKsjvT3Bk/CKKZHDc2eY2ARQzJ8CpGZokp1VzS4jEiKBS3hv
	 z0/vfWDSdK0zPh7oZoDI2KbVKtLB3sgXgBJ6VxiS6qorm0hzfo1s60Nesy56sqejq1
	 MPC0ro1kLD6/nnGhcI2y83O59myUp01YUkrTG/uY0GUZZZKoQQ4W3J+LfoLFkkJrRr
	 lN0m5FDWVfAhw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] nfs: NFSv4.2 client support for UNCACHEABLE_FILE_DATA
Date: Wed, 24 Jun 2026 15:17:02 -0400
Message-ID: <20260624191706.72544-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22812-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE24A6C0FE4

Hi,

This series adds Linux NFSv4.2 client support for the uncacheable file
data attribute defined by draft-ietf-nfsv4-uncacheable-files [1].

The attribute is an OPTIONAL, per-file, read-write boolean (FATTR4
number 87) that a server may set on a regular file to advise the client
to suppress client-side caching of that file's data -- both write-behind
and read caching.  It is conceptually similar to O_DIRECT but operates at
the protocol level and requires no application changes.  The motivating
use case is HPC-style concurrent writers modifying disjoint byte ranges
of a shared file, where cached/delayed writes cause read-modify-write
hazards ("write holes").

This client honors a server-set attribute; it does not set it (that is
left to server/administrator policy).  When a regular file is marked
uncacheable, the client opens it O_DIRECT, which suppresses read and
write-behind caching and satisfies the spec's durability invariant via
the existing direct-I/O path.  The attribute applies only to regular
files (NF4REG), so the client requests it only for regular files.

The series is organized as:

  1/4  add Documentation/sunrpc/xdr/nfs4_2.x and generate the
       FATTR4_UNCACHEABLE_FILE_DATA definition via xdrgen, mirroring how
       the sibling NFSv4.2 attributes are defined and consumed.
  2/4  decode the attribute via GETATTR, track per-exported-filesystem
       support, and record it on the inode.
  3/4  request the attribute only for regular files, since a server must
       reject a query of it on any other object type with NFS4ERR_INVAL.
  4/4  open uncacheable regular files O_DIRECT.

[1] https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-files/

All review appreciated, thanks.
Mike

Mike Snitzer (3):
  nfs4.2: add nfs4_2.x to generate the UNCACHEABLE_FILE_DATA attribute
  nfs4.2: request UNCACHEABLE_FILE_DATA only for regular files
  nfs4.2: open UNCACHEABLE_FILE_DATA files with O_DIRECT

Tom Haynes (1):
  nfs4.2: add UNCACHEABLE_FILE_DATA attribute support

 Documentation/sunrpc/xdr/nfs4_2.x    | 52 ++++++++++++++++++++++++
 fs/nfs/dir.c                         |  4 ++
 fs/nfs/inode.c                       | 24 +++++++++--
 fs/nfs/nfs4file.c                    |  2 +
 fs/nfs/nfs4proc.c                    | 60 +++++++++++++++++++++++++---
 fs/nfs/nfs4trace.h                   |  4 +-
 fs/nfs/nfs4xdr.c                     | 35 +++++++++++++++-
 fs/nfs/nfstrace.h                    |  3 +-
 fs/nfsd/Makefile                     |  5 ++-
 include/linux/nfs4.h                 |  2 +
 include/linux/nfs_fs.h               |  4 ++
 include/linux/nfs_xdr.h              |  8 +++-
 include/linux/sunrpc/xdrgen/nfs4_2.h | 19 +++++++++
 13 files changed, 209 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/sunrpc/xdr/nfs4_2.x
 create mode 100644 include/linux/sunrpc/xdrgen/nfs4_2.h

-- 
2.47.3


