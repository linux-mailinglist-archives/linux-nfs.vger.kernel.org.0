Return-Path: <linux-nfs+bounces-20515-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKSKFw99ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20515-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B1035C20B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 743A4301547D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA93D5225;
	Mon, 30 Mar 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adAMj4Hh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EC3D5223
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877923; cv=none; b=MaJU68MA8EGhhI4nOfbOYZGiFkIuQi9Y1pjiaThz3KL/Nm70jZ2EBBZnhzwyJi0l/hPzwYzFDjEyIOeaH+XgqoBuPipZsDgP/CmnUBs98nPt/9S6/2Gv6VywAK+DScwYprBiQCjaaUw0TF2/b5Cc3vq0tQnWgAiZ+1relU1gu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877923; c=relaxed/simple;
	bh=Dd15qHlf2+q2gN73crV5flHjma0isz/mtAlekdePWXc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MiPj1ssDnI6+P/Fh5oQZQxxeHRPMQ6fQdWH68hTvhdMiRfj3A8qTJbqqFHoe5mYU8z91JFk4n0itEMhegAL3ZT+LoAihqdAm7Y7ojuLq4PIcJ4m3DG6ug0zGqAp52+m+eOpfhcKv2LbMmER7aDet9pr5eHgd1dsGfG8ShzBRyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adAMj4Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3987C4CEF7;
	Mon, 30 Mar 2026 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877922;
	bh=Dd15qHlf2+q2gN73crV5flHjma0isz/mtAlekdePWXc=;
	h=From:Subject:Date:To:Cc:From;
	b=adAMj4Hh/meMkfmGMcfpu7uJA3MZ8/cimU6RynxD+S67PgKnu0j24jYfItrcriiXe
	 xm3TcUpc6eYanaeCn4BtQ9qBAmPRiNR+Un7YHpfNbFWhRxtaKaRIng8mnxucg8Lkak
	 zQDWLwntwPhnYQhvj+7NuBbKgYr8eNt0K6anT6FOi0VrkOrW7eKwaZyfmjOnDcTHO2
	 IBSb4WuRA2xvokw8i6Fv3ipsIs1tV6tcQ2lvtuKvaNsg80Vujp0TjXqWnA5NXA5YIH
	 hVw9o2APW8riYrpZcZFWYYCiRewQmyTONpj7u8qK1FVH0jfSIADNz+EuY+ut/tl42h
	 kyCBr0WclaJ1Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils v2 00/16] exportfs/exportd/mountd: allow them to
 use netlink for up/downcalls
Date: Mon, 30 Mar 2026 09:38:20 -0400
Message-Id: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBBEf0X23C3R2KA9+R/FQ6yrLkoim1Qs4
 r83eO/xMTNvDggkTAGe2QFCGwf2LkFxy+A9WTcScp8YClUYpXODtK9eYo+O4sJuRvvQ3WCMJaV
 LSKtVaOD9Mr7ADQE/kZcAbYomDtHL9/ra8qvwV7vlqLC2paqs6nRV981M4mi5exmhPc/zByh+m
 XK6AAAA
X-Change-ID: 20260316-exportd-netlink-a53bf66ae034
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Dd15qHlf2+q2gN73crV5flHjma0isz/mtAlekdePWXc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzWDTaGQXR6HAk1XnZnvfzzy1J4lWNXNRSi1
 lHkj8/OfJSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp81gAKCRAADmhBGVaC
 FWLND/4uFIKNXXIcj7r7D5Ra/JCU4fVl97PxaTPBV0ypjjwDUPvSGlflSSti7WvrFkUn/tuhz62
 SM5BZQOK8F8kgfmO4XSE4SJ6jH2L33ttIzyxM0Ry48H9MDVbc1vfgnNN1NYIkkuvcWf6cDz7yBZ
 dHWp7TVPHtQZvSrR5URgSDExMIpxfTXcOnnUP2mn/pSHJ79dmAQYekNwgToJD8v6GhXYt5a5FK4
 Dj3VfePlxvrlWonLqVsZ/WTZ6orUF+rgamJFQ+15bUZnxYpIX+bHRBsbqgmwCjjW0cvcRKEoUUe
 7IsJiqP7c9n0DBa70HqPuiwKuTmsyvxpEb5JGhnHO8flZNR3iLDpBwdhb6WBL/edkspRX6OGarP
 nQoacG+IbpuP/9sQD1AuJFQKssr1P9xGJMBtHbOrFbJ4RG8mGTub6O1/yOxpQcmP4lmtRLfwxhz
 L7EJ/44q6OlxDFnDPXVyo399HrrBxJzGLu5w7KqhTdban+xk3wGrfmRQzO/NeamZ+kLdO055sMT
 kqDu+Qbf5pR8V9MyPHyOfa8a1TrcaD9SpNx+xJ35EudEHgFquyWqCXIE6WRcwBjLQ8f+1FjIitb
 LeIGbGiLOjJ9OWNyV2SbQGUbIU+ZYPphqZv7b8z0O2QfN7dzKsD2eMpXkqdpTnJfKFELAGHkWTP
 wMu6phIV00Ly3Mw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20515-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8B1035C20B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Minor revision to rebase onto recent upstream changes. Original cover
letter follows:

This adds support for the new netlink-based upcalls and downcalls in
mountd, exportd and exportfs. With this, mountd is no longer reliant on
/proc for sunrpc cache upcalls.

There are also a few bugfixes and cleanups for existing code and
documentation too.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Consolidate UAPI header updates into one patch
- Rebase onto nfs-utils-2-9-1-rc2
- Link to v1: https://lore.kernel.org/r/20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org

---
Jeff Layton (16):
      nfsdctl: move *_netlink.h to support/include/
      support/export: remove unnecessary static variables in nfsd_fh expkey lookup
      exportfs: remove obsolete legacy mode documentation from manpage
      support/include: update netlink headers for all cache upcalls
      build: add libnl3 and netlink header support for exportd and mountd
      xlog: claim D_FAC3 as D_NETLINK
      exportd/mountd: add netlink support for svc_export cache
      exportd/mountd: add netlink support for the nfsd.fh cache
      exportd/mountd: add netlink support for the auth.unix.ip cache
      exportd/mountd: add netlink support for the auth.unix.gid cache
      mountd/exportd: only use /proc interfaces if netlink setup fails
      support/export: check for pending requests after opening netlink sockets
      exportd/mountd: use cache type from notifications to target scanning
      exportfs: add netlink support for cache flush with /proc fallback
      exportfs: use netlink to probe kernel support, skip export_test
      mountd/exportd/exportfs: add --no-netlink option to disable netlink

 configure.ac                                       |   33 +-
 support/export/Makefile.am                         |    5 +-
 support/export/cache.c                             | 1892 +++++++++++++++++---
 support/export/cache_flush.c                       |  166 ++
 support/include/Makefile.am                        |    7 +-
 {utils/nfsdctl => support/include}/lockd_netlink.h |    0
 support/include/nfsd_netlink.h                     |  240 +++
 support/include/sunrpc_netlink.h                   |   84 +
 support/include/xlog.h                             |    2 +-
 support/nfs/cacheio.c                              |   49 +-
 utils/exportd/Makefile.am                          |    2 +-
 utils/exportd/exportd.c                            |   10 +-
 utils/exportd/exportd.man                          |   12 +-
 utils/exportfs/Makefile.am                         |    6 +-
 utils/exportfs/exportfs.c                          |   55 +-
 utils/exportfs/exportfs.man                        |   79 +-
 utils/mountd/Makefile.am                           |    2 +-
 utils/mountd/mountd.c                              |    9 +-
 utils/mountd/mountd.man                            |    9 +
 utils/nfsdctl/nfsd_netlink.h                       |   99 -
 20 files changed, 2350 insertions(+), 411 deletions(-)
---
base-commit: a06a3251c2eb1316f781149f8b7f9acd9d41e7fc
change-id: 20260316-exportd-netlink-a53bf66ae034

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


