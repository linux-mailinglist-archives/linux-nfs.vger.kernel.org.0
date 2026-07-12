Return-Path: <linux-nfs+bounces-23273-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YUADFg39U2qHggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23273-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B2745DFF
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z9bUvteD;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23273-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23273-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D209C300D85E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9357E0E4;
	Sun, 12 Jul 2026 20:45:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23734F255
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889158; cv=none; b=V1xHAXboI5nDnV+i4iFlCouPpaIoZ4Ktun68N94P3niPLxtlsiviCB+0Mv7Zvr87s32PP2KF6xft32DH5cR1SbyxQk9uQdw6+RlNUPbQp2TeNkJulVO/4YbtqGTT/j9YQN1rLQgpjWWQxHwBkzD5flYbrL04crXBDh6VkbnLhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889158; c=relaxed/simple;
	bh=jxbcocbFZooNtU3CBQsr6I03ulVKR6sl43RKsCM3Ghk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDteE6sX4Nt/YvxyZFJfivCp+mnkTOwYbufN9b+Cpgocrk60nkFkDSOWYiOne4y/H9UyYL5ho2sS7Ucp/AU7XhRD1/Db4CWGRxHhgvrs/vZ260iLy3SwOWs984ttJ0h2aclPPXdA3OxWyRrt3faMlORWTGMflreCEsm5ss/PHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9bUvteD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE91F00A3D;
	Sun, 12 Jul 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783889156;
	bh=YAB5XSmRDgBBpI6FwxjVr6o5v5Qemk24OELQ8O//mRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z9bUvteD37syhxC2R4syIcn3S0rjgcFsLm68mdPDVO0ME7d4uGucqwRNydf+pLU1m
	 mpmIdxYO/8QKrIghvhKY5FqSiny/7w5v2bFprpFbcHC1cbKdli5JPqRxe4TuR22e4A
	 j7656qkgSnpSPUw7JXI74472NdCMD/egyg8pinSEmh6pS89UyrTlYAyvhF1pN/+a2Q
	 n+1b1g1fDeTa5b76MO7kHvAQ8pZ7GFNxu4+qIODjora/M5MMUs4W1FoKICyL1+Bt4G
	 K/SF/4aCGKvm5GQsiBkvTN4Nwdq2HL7M9BSJjyBpOrEOr728VhR91V1IzVGQeBt0RT
	 RmAzyrqO9KOFA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/9] NFSD: Make "stats.h" self-contained
Date: Sun, 12 Jul 2026 16:45:46 -0400
Message-ID: <20260712204554.125308-2-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712204554.125308-1-cel@kernel.org>
References: <20260712204554.125308-1-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-23273-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 929B2745DFF

The inline helpers in fs/nfsd/stats.h dereference struct nfsd_net and
struct svc_export, yet the header includes neither "netns.h" nor
"export.h", where those types are defined. Each helper therefore
compiles only when its translation unit has already pulled in both
headers ahead of "stats.h" -- a hidden ordering requirement that has
to be honored at every include site.

Include "netns.h" and "export.h" from "stats.h" directly so the
header stands on its own, and no consumer has to order its includes
to satisfy it.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/stats.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index e4efb0e4e56d..87736b7fbf28 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,6 +10,9 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
+#include "export.h"
+#include "netns.h"
+
 struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
-- 
2.54.0


