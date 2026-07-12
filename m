Return-Path: <linux-nfs+bounces-23277-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BkxAHwr9U2qFggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23277-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F884745DF6
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eis1QJ2g;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23277-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23277-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0B00300361E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3357E0E4;
	Sun, 12 Jul 2026 20:46:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFB352C28
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889161; cv=none; b=PT80ix23/bWrNd17YBLpEIu2+u7i8nCWfLc6gHlJ+5W+cYgXvlfH0/aBaacmdWg58zRhwydC1Jn5/j/oW92aTqHCkUWVGaNV3M92wZrrpdzFWipskU3LEJddewHNPZ6P+2I3J5K1/NGz89SxyxlY6JqdtKWI7G63U7nWbstweR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889161; c=relaxed/simple;
	bh=FiYF5JkJFBiibf1IE69q7qzqCicjTk0g3fmxAtYhhks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ptwfb5d+zkCrT+tRvwMPGbWNuAkR7OBRw6JWtzm4sBsFyYM3X4XPXCzoCEB8kUifGttlfLmZB5c/C19EmSez+PKYUwvKs4nNVj2ZBhmUcHddCM9gqZ6Vcq2vZJrDMLs7qCD/udkceYsBmkvL7Iy2Sd+vfOxSil17ZAmqLC4ujmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eis1QJ2g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624811F00A3E;
	Sun, 12 Jul 2026 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783889159;
	bh=aXOIlKR4yZy4vfHsMiZmXuzfnPzYyf1k9FaNsb9kDr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eis1QJ2gKf6P3qY77VZc37a8Z2DmHhWK+UE1Kqc1WUzYAwg+mkHWlFCW0NL/nIDjq
	 7um1z13yvK+udUDgLI2qHwvtrGW+q8azOx9QvEZhIdD1k4Y5zG9IfawddcxOYyl6Hj
	 0CwpFsJ6JeHWTc1R175H+vRurDldCHPTdF0Mi8em49f0YZkCZxmZL3NmWXTjkp8Zfk
	 q2CshDAuew2yF4Sd0EkmyUsSC9p9/jt/cDyif6U6A4iuut10cFpTDPg5sPnaXvJmBt
	 mzeuJqIrPNAJJe36oeh4QqkwFKHEeiun8z1YSMNq/8hwK8AKjIZTiR/7jQO94Aemy9
	 KsyOhGGjJHaWQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 5/9] NFSD: Move the export.h include from nfsd.h to auth.c
Date: Sun, 12 Jul 2026 16:45:50 -0400
Message-ID: <20260712204554.125308-6-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23277-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F884745DF6

Nothing declared in fs/nfsd/nfsd.h references a type, macro, or
function that export.h defines. The include is present only so
that source files including nfsd.h pick up export.h's definitions
transitively. Of the twenty source files that include nfsd.h, only
auth.c relies on that side effect: it names struct svc_export and the
NFSEXP_* flags yet includes no header that supplies them.

Add the export.h include directly to auth.c, then drop it from nfsd.h
so the header carries only the dependencies its own declarations
require.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/auth.c | 1 +
 fs/nfsd/nfsd.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index 4dc327e02456..e3b4a35caac6 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -3,6 +3,7 @@
 
 #include <linux/sched.h>
 #include "nfsd.h"
+#include "export.h"
 #include "auth.h"
 
 int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4583d7d51a88..b35e9a9a112d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -23,8 +23,6 @@
 
 #include <uapi/linux/nfsd/debug.h>
 
-#include "export.h"
-
 #undef ifdebug
 #ifdef CONFIG_SUNRPC_DEBUG
 # define ifdebug(flag)		if (nfsd_debug & NFSDDBG_##flag)
-- 
2.54.0


