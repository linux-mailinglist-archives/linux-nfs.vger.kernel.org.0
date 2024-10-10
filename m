Return-Path: <linux-nfs+bounces-7030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5378998BD0
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56AC28A5F0
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842071CC16E;
	Thu, 10 Oct 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gKW1gsty"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C01C9ED3;
	Thu, 10 Oct 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574480; cv=none; b=Ayd0GAYWXCUNLKv+BGdsKZHmzibPSGEhQ5oe4ra/irHqDUSWYSzeWOu7INshN71zQr2jb4qa8WSuJ+kCEhGW4dtSQH1sbNfcLIIk7R7vjD4tG0MSn+JfaIkytVn0TT1fHo1eVqinDcCrmEt6hImj9AdiYWKI//L4myMDQufRROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574480; c=relaxed/simple;
	bh=IP04WyH8b5ClX6RyMbLRjoix/rEmabeVB5T705Da+EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP5wr/imK9eVD4gRLouqtJ7FxhCjqyRNwMz9edyP5V4/k/9GOqSCd67WNLFQVjydUjCvzMLGCT0fZCbYE2jkiGd7tKlNFtFxpmeYnMgx3y78Gpx4lwbFzDwRl7a/RX+iPkZzKrcR0SvHHWpFMqGRhBgLvIUVgvsWicGYHi0SpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gKW1gsty; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX13NR6zVX;
	Thu, 10 Oct 2024 17:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574017;
	bh=Df586XROJKMF1yQSr381EiSbt/vI6xpJkJY3x0sWo24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKW1gstyIqxFplH2KkdMo3/4XmIDKzp7/O2Ibj1sLoDJfTS6MRKhEY4nvBxMuja5W
	 bYy0A4L+fiNz/URueq3YROpu+osO3p+sBKsvN5EUPTCIl8TWIenJiDHdm8IPu39l1f
	 +y6wzQ55DHIZMxcNqruev0BkrBpS0PAFPPVEOm7g=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYX06nnGz9Rb;
	Thu, 10 Oct 2024 17:26:56 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Eric Paris <eparis@redhat.com>
Subject: [RFC PATCH v1 2/7] audit: Fix inode numbers
Date: Thu, 10 Oct 2024 17:26:42 +0200
Message-ID: <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use the new inode_get_ino() helper to log the user space's view of
inode's numbers instead of the private kernel values.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/lsm_audit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..c39a22b27cce 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -227,7 +227,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 		break;
 	}
@@ -240,7 +240,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 		break;
 	}
@@ -253,7 +253,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 
 		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
@@ -271,7 +271,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		}
 		break;
 	}
@@ -290,7 +290,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		}
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
-		audit_log_format(ab, " ino=%lu", inode->i_ino);
+		audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		rcu_read_unlock();
 		break;
 	}
-- 
2.46.1


