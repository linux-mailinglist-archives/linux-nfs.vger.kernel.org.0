Return-Path: <linux-nfs+bounces-21525-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KfJBqFVA2pv4wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21525-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:30:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CBB524B2C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D97530D372B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3F03CC7D6;
	Tue, 12 May 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X66kTsE2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309603CC7C7;
	Tue, 12 May 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602381; cv=none; b=XG5nLbmfKT0ldv9PTdyUxKTgWZ5Tc6egXDdIsI+uctsiseUnDs10AAz+Q24oWnSpDcf0doDIjtV8LJzO3odEFSBgMLoea/FmYpuUqtVHYAujZdD1knHrH3g0qtosBQxngwwSkva/mFGWZdNSP/Yg+VKxfDpCQLDDUAc6AwQ7lW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602381; c=relaxed/simple;
	bh=xSfXSQQnkiNhcDIRyu5/XLP0M8+rWWwcVgu+MrwgSHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABec0Ehm3liaOWeK5UEyjbHUCbg7x4ZeFaLT23/hGpUWNi99g4Kl6EIBhAvIIyf1Vs4k4sq9MsBQebBMRcF5GLdMjH8cvAuqd9kUxrMVAHDpohpXYU9Bhh/3b6Hnm8Y5N8TPhxfCWamMgXa4cGeOjj9QbbPQKFq2/4FHSbcLEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X66kTsE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A778C2BCF5;
	Tue, 12 May 2026 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602380;
	bh=xSfXSQQnkiNhcDIRyu5/XLP0M8+rWWwcVgu+MrwgSHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X66kTsE21ZyaazSKmMdKvGmhGftOCFnMVHk3UNkOPjpzq7azAct0rNAwCDA7AuNAp
	 Ln8W5ozXBQITetIyz5O3yKpr8jGjHYhxpag//DkeWzpPNtvAU+mtPY1t41MRggg35o
	 /zvo3nrGKoO/T27+l43uba9w5AoS/q+bqDK3SJHvdsVUknPzF/KHQJS2p6D8neZiJK
	 s8oaDM1pV1QLCcbb6HTGNAYzrhUGohqfADxdRzWjAB2vC9ulOwvfuEPkaCBi7GwZLf
	 gLNLG09H4hWVr5UYc32oOMMPf1z8pK33ilXfCLJafIZwtTaF+cyomCcKIAocJCIxeD
	 maU2fFlY1ff8w==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 12 May 2026 12:12:45 -0400
Subject: [PATCH 4/4] nfs: remove fileid field from struct nfs_inode
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nfsino-v1-4-284720522f4c@kernel.org>
References: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
In-Reply-To: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xSfXSQQnkiNhcDIRyu5/XLP0M8+rWWwcVgu+MrwgSHg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqA1GHPYL2kyq4LV26QR5FSt+tmqeOTumYNHzeN
 5PUHakZhUqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagNRhwAKCRAADmhBGVaC
 Fb2JD/98vIIHh1T8PUneuGjTWldC/YKp74KRsMMx1/LrxLN4IPTHT2P1GPiDh5LdrVUoY60qwUL
 9EeDUvZlT1PmCQs16GZnqQ8l9bF9zlsbplJLW9rjekaqlSevwyhR4eg849NeYRcXTgqCXT/j+E+
 m8ADXROibMbxwXLeE0Uf3htu7aSRREJbx7y36XOGKMLkXZo7ZLn+fZtUhSQmCjXgvzGh+3Eg17v
 /lBVDfA4pQCwg4VlBVFeIyoCeRaCKRC6pek1MY9AzmdjTUf2fJPQmplWreA8w1MW1Tdf0m9jRSx
 GkGyRw0xjRfetiO81LX6tkpjRfU8JuitDLCiu6yuVAl3VRWymRibvgJdUYThlbqLVrr61JzePB0
 MWzwXa7ccpJLYyBsxniOmLW1Afi6P/d9B3Po30yxbMx49PaXN84/eqHX/kvNGV1Y3DC2qKLRqYn
 ew5H6XL29GvyQLQRIE03XoxbS0tvB0YMAnE3BHHybQYKPnpMgq9cEkTohu+/KctgewEEMDJ9fOH
 HlvQ99nXhO+QHu/VnJfT1Wd6HBqqaCED42KBmUDwi/lQENa2E/gB9SObaZ+yQhCg2PEndAf3O0x
 YthhlH9PBMQtUZXEMsr7as7hOJ81/YyhHysol/JNjLPrZ68wjNJLp9cMec+09RJvXReAaQWIN7Y
 8Hm+IjsGOcNfdRg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 64CBB524B2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21525-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Now that all NFS client code uses inode->i_ino directly to store and
access the 64-bit NFS fileid, the separate fileid field in struct
nfs_inode is unused. Remove it to save 8 bytes per NFS inode.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/nfs_fs.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 83063f4ab488..ec17e602c979 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -145,11 +145,6 @@ struct nfs4_xattr_cache;
  * nfs fs inode data in memory
  */
 struct nfs_inode {
-	/*
-	 * The 64bit 'inode number'
-	 */
-	__u64 fileid;
-
 	/*
 	 * NFS file handle
 	 */

-- 
2.54.0


