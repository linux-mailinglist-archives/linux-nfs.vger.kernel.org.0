Return-Path: <linux-nfs+bounces-6257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF796E1BE
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065CE1F25B55
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46317BA5;
	Thu,  5 Sep 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1MLRaoF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63B158D66
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560224; cv=none; b=PanZFMJjBlnxO4/JGZpeCgwlVvsZyn0++QqjjWGfvr29Rp3bOVwHlmYW1f7aXdrASoup30/uVk+5pK0d1slBrfPb7MGG743V032OdY/AYU+rlDs+v+aXfOYDlzL8ujsTULrKmjM7IpM7iktjkNqhocMBJ7YYpPGNDE2T9qK2iHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560224; c=relaxed/simple;
	bh=fpGlx19LirBoyfvbhwbh+Lxynm7wPL1Pt5mWQ2uLvMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjm2gYBZbx4i4Nj+jAAlohJsxuGlVmxXKFtJJeelz+brXbBX5a+rxWOnKNuEbCGp1A/UbfOYEZmc7N+2wY/9EukYUieR+0o5rZhbpFk7ZBzRNhOc4zRkLldt2hYMazpJ2OzBGtH0wqnDjm7F/GAp9VRX1maq8VoidQiGhavwvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1MLRaoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37745C4CEC6;
	Thu,  5 Sep 2024 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725560223;
	bh=fpGlx19LirBoyfvbhwbh+Lxynm7wPL1Pt5mWQ2uLvMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o1MLRaoFQy3NRQ7dVv1kqLIizGQSBZXbZUZaJY+uRBEE/ieizTx50B7stZvLA8U2Q
	 v4ABsnLDu2suGPSWJq+/8VxxlOfulAU1/SmancdEJxFRR6NyQJ9pwNcGDG5Ka9T/df
	 7xkxIqyyjMDEMz0aNZXg2uoCQYYlXWCGf9pRMkLuspAXMgRpk7vmNEzfbjbyKPU8OK
	 59a5aFnuYWJ+MxqgGRUjty58u+Jrr1h0ce+X/jB+SAY/Z7U6FYU/1XPaHyFcCFvSVb
	 NhJ2kdEKyrpsaXePBiYrs4Y8ao2fQpXQEJXi0fBuGE3UPSRqFwcDDkYnByFUdH3SSO
	 LqQJIZpqd3mkQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 14:16:57 -0400
Subject: [PATCH pynfs 1/2] pynfs: update maintainer info
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-cb_getattr-v1-1-0af05c68234f@kernel.org>
References: <20240905-cb_getattr-v1-0-0af05c68234f@kernel.org>
In-Reply-To: <20240905-cb_getattr-v1-0-0af05c68234f@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fpGlx19LirBoyfvbhwbh+Lxynm7wPL1Pt5mWQ2uLvMI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2fWeiORqubDnUR/H78zAiEEc7Z7Tq9Ut/7wql
 a0mLaRP1SeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtn1ngAKCRAADmhBGVaC
 FWUDD/4ziV5cglae2p6lpiRbnRpQOwnaTVS8bB4E/zQweRrLBc3m8cIr9x27IE1i7IznS96L0KL
 o36wMX7iF9FgI5CBCLwgP32T/PJ+Ka274a7Z6cUKE16a20jW7fzMSaKIsJY4sgOIIcRGdwKf4GG
 FQON4+Dtg235NAa/AbJ9mUxW/IzetlmkvqKsJpzU+uUSa1ojrsjaJtakQq7hRWLdk9lhs2J/Do/
 m6KsM7qyjRLpOshXKLdBCk2xdUzuCK9U8ngq/5iMLIt09wl/PvEj+ReQ8Q3swgSGzYFiF2ab/1h
 ee/2PKW02EfmdzfJrVzCsVCV0C+I59QF2S1dv4XaTrcxVyjHBafNTrnuQjfu67atoKC7Cncct/3
 E1VXci78iL2xhrQ9T+gM/WuNj6Zm84q6zPbytmxXiBWdR92va4GYzoEZJxKFJ+Id7/ga33N3hU2
 1UkuzSnCA79oVGxSv5ElXM2zcr6C6/qP7EgGws+HA6Amo1aZTLBqKBGqWUzoBaT6GdXa1RhOXl2
 f0idLm9jS71zTL2RZ6PmWaSiKmcnt3Wn5uurn8LPt34FcKc5N4G1BynvQWXuOq09F9it3PtYRe0
 NMvWJlgBZ5NG6OtuLAFHSI1l5T2k1xHsa/FawXJK4s2n7ZYZ2FsPLVsROBKGOwGKmJ5/bDDuHpe
 8+kjgh51A99YOfw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Calum is the new maintainer. Update the CONTRIBUTING doc.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 CONTRIBUTING | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/CONTRIBUTING b/CONTRIBUTING
index 220b3e0629aa..d15b2b827879 100644
--- a/CONTRIBUTING
+++ b/CONTRIBUTING
@@ -1,15 +1,15 @@
 Check out the latest source code from
 
-	git://git.linux-nfs.org/projects/bfields/pynfs.git
+	git://git.linux-nfs.org/projects/cdmackay/pynfs.git
 
 Commit your changes.  Please make sure each commit is individually
 correct and does only one thing.
 
-When you're done, send the resulting patches to bfields@fieldses.org and
+When you're done, send the resulting patches to calum.mackay@oracle.com and
 cc the linux-nfs@vger.kernel.org mailing list, using something like:
 
 	git format-patch origin..
-	git send-email --to="bfields@fieldses.org" \
+	git send-email --to="calum.mackay@oracle.com" \
 			--cc="linux-nfs@vger.kernel.org 0*
 
 We generally follow similar processes to the Linux kernel, so

-- 
2.46.0


