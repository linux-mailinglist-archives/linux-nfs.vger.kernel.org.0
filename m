Return-Path: <linux-nfs+bounces-7028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E05998CEB
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 18:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEB8B34BF9
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FB1CCB4F;
	Thu, 10 Oct 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hWNGFBMf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203B1C9ED3
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574475; cv=none; b=Eatci3QjjtyyHEYACRVq4qVlquFGhgJLbK3EoXqjpGjoM5aVAalhVFn1j33vn7HPZdnvx4I2KDQze5/+2egAGxVLi/uUajtXHO47KPtUWGgXA+3sIbJ5E4G5jhCu8IMvkZR5jgtkaoOQyXp2mDpefsqMkx2WHvRvWuYneTId9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574475; c=relaxed/simple;
	bh=Vri/r0kNCh5EU1OTk7JJRg44INfy3aDynIPyEgdheKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZOdmlL+788pXGaLgU+jr1jq5fX4PMaTNCrKEuh6GDwAhco5kPB5+a0EMDYF3BLdZFKSMd6mGe3oAQa0OvaXpRq9dz9B7aCn7z/ojiDLtptzDx7Cz7g68aaF4PvEqsO5nYd5jKqlaCwoUAVsp4Fh4u4gqwxWdIlAbQPAUUD3r2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hWNGFBMf; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX4594xz66K;
	Thu, 10 Oct 2024 17:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574020;
	bh=SdLulSzLT9TYl10U9ZqAnL7lkf3eOC+kIIq0uoFGsDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWNGFBMfIp1QSTsWRQlrQDxzvxvOygpg0kHOobA5wJtDJY3BwxjkdEX1oRPf7WJ7z
	 laIho5wqdxc7WL98l7jtNzi5MDL6aRLiAmClXYe8IGACDGSUoCtKP/Sd/bbRI/j7bz
	 FJjktKckl2gMB65AcGalWicLifgoj9td+JomvmZc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYX2758tzSKb;
	Thu, 10 Oct 2024 17:26:58 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>
Subject: [RFC PATCH v1 4/7] integrity: Fix inode numbers in audit records
Date: Thu, 10 Oct 2024 17:26:44 +0200
Message-ID: <20241010152649.849254-4-mic@digikod.net>
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

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/integrity/integrity_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 0ec5e4c22cb2..e344d5bcf99c 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -62,7 +62,7 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 	if (inode) {
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
-		audit_log_format(ab, " ino=%lu", inode->i_ino);
+		audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 	}
 	audit_log_format(ab, " res=%d errno=%d", !result, errno);
 	audit_log_end(ab);
-- 
2.46.1


