Return-Path: <linux-nfs+bounces-23272-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c2UOGwn9U2qBggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23272-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A512A745DE9
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SSKNst76;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23272-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23272-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DE92300A380
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DFF352C28;
	Sun, 12 Jul 2026 20:45:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FA7E0E4
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:45:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889157; cv=none; b=mWqXjY9mLpj/+OW+ZBbQ2nxx0kD6jt3FwvN9V3ZFJ0Fc/dDqtmFViyTnPFF8ynFOGomquJdoF3+C8UClOhJ9x9OHCH2Gc6V8/zKd4PnViPmzyCLfo5uoOfWNVZsiWicEmK316g6EG7/f88/nij4yX89AESp/jjzxSmneYQj4luE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889157; c=relaxed/simple;
	bh=cdgv6J5jif0F/zEmXQfM3hf1zFVhvlyMYry+d/C07jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUT+p/G9rD/zuAGtkkiizzcyJ912GqZu6Zp0ASDBll2O58U4aelMXv/y48UM3rZX5oq8RtmbX/6JCCVdW2cVIyFet1A3BQ8x8FWHWucOOsa53kHncmdaRpOCe95eZm0zxRbi4sFte9OVcD4QRDXCfIycEEjdOh0BrdvHdbcy3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSKNst76; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A1C1F000E9;
	Sun, 12 Jul 2026 20:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783889156;
	bh=J1f9zMYiBy1EfKv+pRDPR/b6CLXaHOMxaWDOTqJUtq4=;
	h=From:To:Cc:Subject:Date;
	b=SSKNst76yNno1tr6Pd8MM8RQRqMdTDrMGdpR6SWzlFeov9wFpegSlAC0dFfS3/bMW
	 uLXenBSoLmoK381/c8vEBnPABqko3ouktlJE7DdZBwFUmHmHT55t4uIgFjcpwlIH2c
	 QT2qzSuXLDRnh4+ixHcnNqJq+FLLbE7QVbivCSQdDbYsyhlK5+nNNJc/FNKgB9WNev
	 vsrUOjGPKdQRvv6Mvlp2xTvyTn0crrhR7riupSsamQjDLvroDOyMZhW8vM5MHHXeWl
	 hP6wuZXvFiaCTZK6eX6AWUDHBsQHFmfq4oUmYjaYmWzPd/POoR24LFa8nNQGE4BF0e
	 mnoSo+6OocYng==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/9] Start reorganizing fs/nfsd/nfsd.h
Date: Sun, 12 Jul 2026 16:45:45 -0400
Message-ID: <20260712204554.125308-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23272-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A512A745DE9

fs/nfsd/nfsd.h has become a kitchen sink of unrelated declarations
and definitions, including a broad swathe of headers and other
detritus in NFSD source files. This organization introduces
brittleness that makes it difficult to execute changes that cut
across layers and internal modules that might otherwise be cleanly
siloed. It also pulls in unused items into each TU, making
compilation of nfsd.ko needlessly slower and more computationally-
expensive.

This series begins sorting through this pile to relocate items that
are obviously better placed in NFS version- or task-specific
headers.

Chuck Lever (9):
  NFSD: Make "stats.h" self-contained
  NFSD: Explicitly include "stats.h"
  NFSD: include "netns.h"
  NFSD: Remove '#include "nfsd.h"' from fs/nfsd/cache.h
  NFSD: Move the export.h include from nfsd.h to auth.c
  NFSD: Move struct readdir_cd
  NFSD: Relocate nfsd_user_namespace()
  NFSD: Relocate nfsd4_set_netaddr()
  NFSD: Relocate NFSv4 "supported attributes" to new header

 fs/nfsd/attr4.h     | 162 +++++++++++++++++++++++++++++++++++
 fs/nfsd/auth.c      |  19 +++++
 fs/nfsd/auth.h      |   6 ++
 fs/nfsd/cache.h     |   3 +-
 fs/nfsd/nfs4idmap.c |   1 +
 fs/nfsd/nfs4proc.c  |  32 +++++++
 fs/nfsd/nfs4state.c |   1 +
 fs/nfsd/nfs4xdr.c   |   2 +
 fs/nfsd/nfscache.c  |   2 +
 fs/nfsd/nfsctl.c    |   2 +
 fs/nfsd/nfsd.h      | 202 +-------------------------------------------
 fs/nfsd/nfsfh.c     |   2 +
 fs/nfsd/nfsxdr.c    |   2 +
 fs/nfsd/state.h     |   3 +
 fs/nfsd/stats.c     |   2 +
 fs/nfsd/stats.h     |   3 +
 fs/nfsd/trace.h     |   1 +
 fs/nfsd/vfs.c       |   2 +
 fs/nfsd/vfs.h       |   5 +-
 fs/nfsd/xdr.h       |   1 +
 fs/nfsd/xdr3.h      |   1 +
 fs/nfsd/xdr4.h      |   2 +-
 22 files changed, 253 insertions(+), 203 deletions(-)
 create mode 100644 fs/nfsd/attr4.h

-- 
2.54.0


