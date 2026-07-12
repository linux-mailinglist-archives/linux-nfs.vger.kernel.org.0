Return-Path: <linux-nfs+bounces-23275-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uf+lLwn9U2qCggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23275-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A82745DEB
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jyod3Qez;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23275-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23275-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D759E3003635
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB236921E;
	Sun, 12 Jul 2026 20:46:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416BD3B42F8
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889160; cv=none; b=I5q446mVDkZUB9cRNshTBEq3PGECyeHN5rSviYhV5wm8pazn6yEY1nQHLLY3i/ghFX8oUYHa8+EnRwe3vFYhZ8fJZvEQZyojSVWo3sIsJ1UWGjBDDl0z62nvbyUaTQkqtP6c4H8G2PZFtdR8/nceBBS8TAF5ukxV/Er1P+XsE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889160; c=relaxed/simple;
	bh=t2IFeyc3it4UWSltH9c5H4wB05MkGVD86AxEfbUo4Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmoUwRW5DVmGN5OYBxhgGJqtrsxVHqZ+KnKn0O05/87fn7SD46U3IA0AgEN2GxTGWOu1clW6ennIVpgAij1294myQaObjcjyrZnJLofLVgdiy6BVyecca+gvh1xdnzZbwXYN+x4jJc4NzvjLPPikZND4OCl4ZxnLGHbi9VUO720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyod3Qez; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE1A1F00A3D;
	Sun, 12 Jul 2026 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783889159;
	bh=31ZQc39LBPeJ9niGOAVJ0mHO0NN0s8qc3GkM2PHCjtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyod3QezKHeLeHYAIkCSYiHG13zNSwnXRzrz887HPRT6btdeFcnt29US1Swq/Wp58
	 FAdCjGBaMNzq43GtOa4rskbu1rjOHbLk2w/BflabA1n+fvp3w2/guJCe6wyIXwuV30
	 YLHavUg1iH7u7EL32pXEuXqBklAQrcNA7I/qeUW7+B5R3bSaErL+taEF1v/kjm2tLf
	 cLb7lL8/Q7/aIX77OW43Ci1DNuyNDFLqa92/EZ35gCkouSaKf1xYGAni42wmNiglz/
	 XKT/jG3Mk1bMKLUjBxXllmCes6Y9pv8QiQ53vpQ9Znu4PjjyvJb83SKQnQdrqkX5Th
	 /kS6WQQVeimIw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 4/9] NFSD: Remove '#include "nfsd.h"' from fs/nfsd/cache.h
Date: Sun, 12 Jul 2026 16:45:49 -0400
Message-ID: <20260712204554.125308-5-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-23275-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 62A82745DEB

Clean up: cache.h does not need the full definition of struct
nfsd_net. A forward declaration suffices.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/cache.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index bb7addef4a31..3bc4856e34b8 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -10,7 +10,8 @@
 #define NFSCACHE_H
 
 #include <linux/sunrpc/svc.h>
-#include "nfsd.h"
+
+struct nfsd_net;
 
 /*
  * Representation of a reply cache entry.
-- 
2.54.0


