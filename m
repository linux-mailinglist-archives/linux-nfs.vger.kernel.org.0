Return-Path: <linux-nfs+bounces-19434-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFW5AMwBomnPyAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19434-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 21:42:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673F1BDE1C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 21:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F001F307097A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70C477E5B;
	Fri, 27 Feb 2026 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHwFAr7L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950C477E4F
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224953; cv=none; b=QwPHsoGvUJ0n7pTamr8vy/y5lQpdtauOyXJgIJjwzSWIZlDAFafA8ViwgE7M92QTtvi0Ljr1QrdOTX+g4iCRTf5Rs+pUVlA0dyBpOiQI2OOO/VPRGkFJ7HKbiXTFMTzAmcR8Q+3R8nsm59LITLsKq/bgGMWlM3ApMCOUpPOF9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224953; c=relaxed/simple;
	bh=oKV0USsLJ624asLFG9L1ZWFfd+1SrzcHUIF9emWkmII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPBzWmtu1UM/GD33PGqIRzusIcEhbsMOLrFZeQxkUy0vvCRhSFoe4nAV2MRAMP7tL/UUDmf4uxFGD3KNv9caSIHfA1RUcH3gPKRaHhMJFZB1lMu2DMB8UYHWmi89o3ENFVfr850PE5f2ONNXLQZ4SMSzeySZIKCExSkZby77Y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHwFAr7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF301C116C6;
	Fri, 27 Feb 2026 20:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772224953;
	bh=oKV0USsLJ624asLFG9L1ZWFfd+1SrzcHUIF9emWkmII=;
	h=From:To:Cc:Subject:Date:From;
	b=VHwFAr7LflGggdQC9Xl3cqpW4WqxMqrgVCRa/dPteGVMngoVclsMn4iIcDsyoJfqZ
	 er+7YHjRLCvew+VzP4ngLunJWrzKJ2Y+llw0BeNeWt84OZnor8ECxWslqWrpb105MX
	 CeFJVNIHLCYtfih/hFWD/MT/3dR3Lhqz9rkR1DEJ53wjDafhlTyRiNAUc6AGYjjBNl
	 bTKx5sHy+d96zo0xcyTL/l1RlF2twLzVeaURdlcqQsUCAT1v0ADbOoxLKd/0e+cL64
	 HIC0hzM7FsrtsSYy70Pfdmsemn/PGKcsfZVq3q4gVBzwhuDgLcQSa14QJwqwgKxRJB
	 +gBP8qK06Z/6g==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH] NFS: Fix NFS KConfig typos
Date: Fri, 27 Feb 2026 15:42:31 -0500
Message-ID: <20260227204231.769675-1-anna@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19434-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-nfs.org:url]
X-Rspamd-Queue-Id: 8673F1BDE1C
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

Two issues were noticed after the NFS v4.0 KConfig changes were merged
upstream. First, the text of CONFIG_NFS_V4 should not encourage people
to select it if they are unsure. Second, the new CONFIG_NFS_V4_0 option
should default to "on" instead of "off" to avoid breaking people's
setups if they are using NFS v4.0.

Reported-by: Niklas Cassel <cassel@kernel.org>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 4e0269352534 ("NFS: Add a way to disable NFS v4.0 via KConfig")
Fixes: 7537db24806f ("NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4")
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 12cb0ca738af..6bb30543eff0 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -87,7 +87,7 @@ config NFS_V4
 	  space programs which can be found in the Linux nfs-utils package,
 	  available from http://linux-nfs.org/.
 
-	  If unsure, say Y.
+	  If unsure, say N.
 
 config NFS_SWAP
 	bool "Provide swap over NFS support"
@@ -100,6 +100,7 @@ config NFS_SWAP
 config NFS_V4_0
 	bool "NFS client support for NFSv4.0"
 	depends on NFS_V4
+	default y
 	help
 	  This option enables support for minor version 0 of the NFSv4 protocol
 	  (RFC 3530) in the kernel's NFS client.
-- 
2.53.0


