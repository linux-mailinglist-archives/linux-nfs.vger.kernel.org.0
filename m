Return-Path: <linux-nfs+bounces-23245-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IPdHJFBbUWolDAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23245-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 22:51:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFD73E7D3
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 22:51:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qwlrfutb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23245-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23245-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05CCF3018D1A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF4380FCA;
	Fri, 10 Jul 2026 20:51:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E73B0AE3
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2026 20:51:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716680; cv=none; b=pYUkip4NUYzfblZ6rFZ1/TkBoFfAkYG0hlt4XcyNyIDBdsGuVejtU7WdC7zJ8pm1t5zmgGJQQRX0RyR09NPuEQJdfMFW0GqifHmmeonkJi+Wouf+cSDZ/s8hKhTdQfBD9dgBqUe/bk7CrcL4Va5qy1MPlGNsyZMtA4iKCQekGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716680; c=relaxed/simple;
	bh=zbxFsuFgy5nlVMqKFyf+0wuR51+5RSt8f53gKKY2awc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8sUz+b4S/6MdmDpLSVrc9ynbtq87qEC7DwmWWAsouN69X0dij+Qi4Vmi4PU29QSpzwCN275qUL0dOOYfM2gpkUXlKqCh1+gFNj9SPIO2dE1wB0uETxKaQY3ef3mneNgRu9edwAkl1xu6DEFXKJBel+9PQFTpqKp2dvlfroG//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwlrfutb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2060C1F000E9;
	Fri, 10 Jul 2026 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783716678;
	bh=ZmDn0mWRibkfRO1OuY0hgxNvlvxGWma+ZpJnKkA8VvA=;
	h=From:To:Cc:Subject:Date;
	b=QwlrfutbO/aXbhonIxLerATj5thEQ37nx5NKdLdZbdDIzLPd52B+TTYUYp88uW2u1
	 uVcARMjDsE1gBNggVRe3iR7h0nO7Vgtuc1WCIP8Kd9OxK7dg9udvFGmLz1fVa+fiSj
	 IMu7DAbmuTBXq00Z2TGflxEnIa4uTvVUTcGLO90RETK7tso2UNNEqqAqPlq9xHOG5I
	 VuO5HkMmtfENyFuMQEkR4RRaVyQOUoF0sPOvFNp3ZD+xKpcbWQWqp2Vg4O45/CLSFW
	 nzZWQ72JEGilVuGghuOEnhIDP4eJhOyGnak3Wv5DSZFTVfPqDLEq8fp1nlMVKnDiuu
	 VR+T6lm934rNg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 7.2-rc3
Date: Fri, 10 Jul 2026 16:51:17 -0400
Message-ID: <20260710205117.622337-1-anna@kernel.org>
X-Mailer: git-send-email 2.55.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:torvalds@linux-foundation.org,m:anna@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23245-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ADFD73E7D3

Hi Linus,

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.2-2

for you to fetch changes up to 27934d02cbeb8a957dd11c985a579e58d30c5270:

  NFS: Charge unstable writes by request size, not folio size (2026-07-08 14:43:40 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 7.2-rc3

Bugfixes:
 * SUNRPC: Release lower rpc_clnt if killed waiting for XPRT_LOCKED
 * SUNRPC: Pin upper rpc_clnt across the TLS connect_worker
 * NFS: Include MAY_WRITE in open permission mask for O_TRUNC
 * NFS: Charge unstable writes by request size, not folio size

 Thanks,
 Anna

----------------------------------------------------------------
Benjamin Coddington (2):
      NFSv4: include MAY_WRITE in open permission mask for O_TRUNC
      NFS: Charge unstable writes by request size, not folio size

Chuck Lever (2):
      SUNRPC: release lower rpc_clnt if killed waiting for XPRT_LOCKED
      SUNRPC: pin upper rpc_clnt across the TLS connect_worker

 fs/nfs/dir.c                |  2 ++
 fs/nfs/internal.h           | 12 +++++++-----
 fs/nfs/pnfs_nfs.c           |  2 +-
 fs/nfs/write.c              | 14 ++++++++------
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 19 +++++++++++++++++--
 net/sunrpc/xprtsock.c       | 16 ++++++++++++++--
 7 files changed, 50 insertions(+), 16 deletions(-)

