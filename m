Return-Path: <linux-nfs+bounces-13109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A56B07714
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969221C23026
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78C1B6CFE;
	Wed, 16 Jul 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHJEH7Yh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517E4C9D;
	Wed, 16 Jul 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672889; cv=none; b=bpMnhTzt1vc5co1DpJdh2DOIS+0T6dqI1nhM6lE9UKQf9NnSHo7bIwBzXfRdaDezxWdvV7p95PSQTTQvUPPm9mwgOvURSPaYNcEmvmuDQ84Nhhie0gDKoTWM7fXdjgz0Ykd/KQhN2VM6jOEvWgC9uUW0Z9srhL2SMfftY1R9hRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672889; c=relaxed/simple;
	bh=Cv22+gj0eNB2YJMPPZnxEB+DFB8DrWp1lbMdSA0X0Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GCc0QgzCM9KvsLJC2+HhYG+XmKo/PEJdPJwqaNqs1STlbc8gD6aBHBhbC9YiKJO1yBapKsHEYyLLmH8Qna0Fxk9yvU5C8A5gdkUyq1ldNZcaAUy8eZwJjnF1AiBv5ZGZN2CHdVHcRxLEFopJ6Z2Miu6lCrCt44/MX8h92gZUymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHJEH7Yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E22C4CEF0;
	Wed, 16 Jul 2025 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752672888;
	bh=Cv22+gj0eNB2YJMPPZnxEB+DFB8DrWp1lbMdSA0X0Aw=;
	h=From:Date:Subject:To:Cc:From;
	b=VHJEH7YhOvdrdbi0GtCmcPYm0XZ8oAFDKOWU+v7+uvxPWxJ6Fm/5MK3YK4rpgEIH9
	 FMtlw3K86yFYW/bpyQ2A4R2EuGEU4nfipI0eKQUOJD5mfV8L2DdPWL7D1xR0D9rY+n
	 Tbw/AskkggUrz4NxVdLs7tiDJqFqQioYgt53MMjzfYhcYI3c5wZOmD0YgR7q/R087C
	 iepPf3DPQWmgD4U1erdP8UfPgJSaRTT4nefSR6Uii+Ia+6cKo37eM9i4Yw1ZNY5L3+
	 EBFVVU0FoXMmriQhKrhmK/89Ly/mHdhmdSrNXsLUaDer9SzFBdVxFf/nW19JFZ9Wli
	 Ptq8+2vnpypVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 16 Jul 2025 09:34:29 -0400
Subject: [PATCH v2] nfsd: don't set the ctime on delegated atime updates
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-tsfix-v2-1-b834899cf4d0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGSqd2gC/12MQQrCMBAAv1L2bCRZ0lQ99R/SQzBruyiJbEpQS
 v5u7NHjDMNskEmYMly6DYQKZ06xAR46uC0+zqQ4NAbU2OvB9GrNd36r4aTRurO2Xhto7Uuo6f1
 znRovnNckn31bzM/+H4pRRgWPxrk+WIdufJBEeh6TzDDVWr+ctWrjmwAAAA==
X-Change-ID: 20250715-tsfix-780246904a01
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2588; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Cv22+gj0eNB2YJMPPZnxEB+DFB8DrWp1lbMdSA0X0Aw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBod6pxVKEsHSrhmAAEE6yOXz7ARiUXZSBp5r+iP
 xbNz4rn4ziJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaHeqcQAKCRAADmhBGVaC
 FYbJD/96cSXlYBaeAKVMvWBQpM834R4LFovK4DAlaXddeOb5MaDkehnGBmC0u5AhjeNekBRz5NB
 Nsn7lzG3PuPuqtsKN+W3MitEIr1DboL6NLY+r+wM2FlwLc1r12Gs7bW0VLbUGSou1BNeJbzsIgi
 0Pu4ipm9ho07SY4hmo+kzKmCM1EdpFzL3SGDET4EfkkfBYTLoGyiVtzXkVuAFfvdVGBnEnZRK6/
 9RCa7kZfbXQqwqY24wQoPEGdti12Ji5Yz0E+tRtMhBVoqF2hORP5xJMGRqLuYYmzY6yK75ulT3T
 elvDSCwjS6gh7+HStkJiOcFbznSazMriXj6TI5vtN0CHlJK+7nBPSePyD1yxyjBXkpZMuoisRew
 DNdfQ+EzAl/tiRkUIJ0mTVRDpllg3WUaiQUlEGedVBux6HJqLg0phvMTmznMPKvmSuR2tPsTsly
 ptz78oPhx4HfBRgBZ5akFZVP5Vzx//Iaun3RyEf/NCtjlHGsYGeCEKA0R6y3BoPAQUnUfx/m0mJ
 jzNaVQZ2xxxmxfcaRKUetX8egp0fKSV1V2QWvjGPsSn72sth4E4pvCBq62r7HRlOluwBpZs7hhL
 jib9JRymRZv3I08UlchgmqLUzdL/VY0kkpNrALeSGb2NXWvqZ6v77NzXrUODvaz7JA7QKbm2NZS
 1iXOizF+pMbBXRA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Clients will typically precede a DELEGRETURN for a delegation with
delegated timestamp with a SETATTR to set the timestamps on the server
to match what the client has.

knfsd implements this by using the nfsd_setattr() infrastructure, which
will set ATTR_CTIME on any update that goes to notify_change(). This is
problematic as it means that the client will get a spurious ctime
updates when updating the atime.

POSIX unfortunately doesn't phrase it succinctly, but updating the atime
due to reads should not update the ctime. In this case, the client is
sending a SETATTR to update the atime on the server to match its latest
value. The ctime should not be advanced in this case as that would
incorrectly indicate a change to the inode.

Fix this by not implicitly setting ATTR_CTIME when ATTR_DELEG is set in
__nfsd_setattr(). The decoder for FATTR4_WORD2_TIME_DELEG_MODIFY already
sets ATTR_CTIME, so this is sufficient to make it skip setting the ctime
on atime-only updates.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I had missed a place where ATTR_CTIME needed to be set in the previous
patch. I think this might be a better approach.

Note that I do still see the occasional test failure due to a client bug
with delegated timestamps, so this isn't enough on its own to enable
them by default. Stay tuned!
---
Changes in v2:
- only implicitly set ATTR_CTIME if ATTR_DELEG isn't set
- Link to v1: https://lore.kernel.org/r/20250715-tsfix-v1-1-da21665d4626@kernel.org
---
 fs/nfsd/vfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ee78b6fb17098b788b07f5cd90598e678244b57e..c25e43dfa4aa4e3f730ffbb93f6b981d90c19c4c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -470,7 +470,15 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 	if (!iap->ia_valid)
 		return 0;
 
-	iap->ia_valid |= ATTR_CTIME;
+	/*
+	 * If ATTR_DELEG is set, then this an update from a client that holds
+	 * a delegation. If this is only an update for the atime, the ctime should
+	 * not be changed. If the update contains the mtime too, then ATTR_CTIME
+	 * should already be set.
+	 */
+	if (!(iap->ia_valid & ATTR_DELEG))
+		iap->ia_valid |= ATTR_CTIME;
+
 	return notify_change(&nop_mnt_idmap, dentry, iap, NULL);
 }
 

---
base-commit: 7351f1092b3cde79f654dc49a82d51c7ada0a1f2
change-id: 20250715-tsfix-780246904a01

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


