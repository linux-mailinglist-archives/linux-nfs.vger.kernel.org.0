Return-Path: <linux-nfs+bounces-11024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CC4A7E218
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 16:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D780422649
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA211F8671;
	Mon,  7 Apr 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpNsXdIw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B461F791A;
	Mon,  7 Apr 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035885; cv=none; b=dD3FGbubekT00d5i5sgmUWgUxeLR1yNOKALovYv8RKEtP7vjP59c3U6wbx1r9NWdWHaBhuKR3FEvXy139PhYTuhqE9sbJ69+ztFOgV15Ok48zLFOry3FeynFpJ51Vq6IMvMyMC+komF8IbOX0Kz7JggbKeYDHDWUegJ4V6KGV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035885; c=relaxed/simple;
	bh=EAt+xOboHgCqzw9Hqy/p3L9s5zpHb/iNh2px5rOmrj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=svyngwLHUHYqR4UNnBom6vLcFulHBh+qBDI+V51iCCEryfBo5JULh99aCWAPAKABZi7+bt7BaGzOSGQkQHWVbEAxyh4xa6z4ZbUZdLgqL4nGoK0RfTXmPbeFMJghO49ktmO0iuL++poyci7dJlDMOM0wtvGuGHMKF4000kcl8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpNsXdIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CEC4CEEE;
	Mon,  7 Apr 2025 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035884;
	bh=EAt+xOboHgCqzw9Hqy/p3L9s5zpHb/iNh2px5rOmrj8=;
	h=From:Date:Subject:To:Cc:From;
	b=HpNsXdIwKSTT3SZiYMAu/0oXURLj8UY+VsfcqH//35ltCjiXZDHdEdYGXUqn4ki+8
	 UskggJb84gR8iVDvK4kZTK3g70OpgLZUPAlqZN3AQ23FOLkls0+EeV91FVaX1P36T2
	 5wNFooatXUJxxBm8rCkwD3Ih22q+2/FNSQMvnQa4Hk2WPvp6dni+9/fxZX+Q0qIQsa
	 EBY5n4PBSjxybkd2NL0FvRADVBYtN2bdnUE6juP9dwrfJgkJD3AlOtWCMPHIAAbb1w
	 AWLBipRgdBdby/HU011swRIgS/M707iz7U9BUIwSwD1t+q9x34sNhflmPnBIWk8iii
	 lXlRw43Dy3mYA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 07 Apr 2025 10:24:42 -0400
Subject: [PATCH] nfs: don't negate the op_status in nfs4_flexfiles_io_event
 tracepoints
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-nfs-testing-v1-1-2e637737ce76@kernel.org>
X-B4-Tracking: v=1; b=H4sIACng82cC/x3MQQqAIBBA0avIrBNUMqurRIuo0WZj4UgE4t2Tl
 m/xfwHGRMgwiwIJH2K6YoPuBOznFgNKOprBKGNVr5yMnmVGzhSDHLTRzo8TorHQijuhp/e/LWu
 tH5riES9dAAAA
X-Change-ID: 20250407-nfs-testing-61217f89ee25
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EAt+xOboHgCqzw9Hqy/p3L9s5zpHb/iNh2px5rOmrj8=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGfz4CyiD1K5F8cHzYAPi4T+FXPTQlf5ZbTy2lqjXCjmS5qWn
 okCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJn8+AsAAoJEAAOaEEZVoIVzkkP/jc2
 FxRNVc9dnAAyazVZQMxswo0tnzRpfRsUJcQ6hMPRjOTzvt3pXtl7bVrnMht/tOTyX6qhUHWJjHn
 zfSOmd/IpbYTXeNv7AsVnEwm9AWRkChYcjGUCuVZ0z9uKi9pWYr1XvKDnN8nFKC0yNcj88gZWnf
 NtSmeQ8WWvQHUsOLKGuEYcOOcVIvx6+aorYicgroXIgzR+wPXjKEZSlOb+0gGulIa/FtX1RIPf6
 wOgG0l4Bh0V87WAimTDSImD4iuSnYkkIHu8FJG99ei94ouwA4Kiee4fU7+oH0DGkSkbWGL8Ivqo
 BlAeVRDipF7lkc0VxuZOwpXZyNk9KJZeVwwKIFg0NTi0uDH5ujvrutgJUU6gVGtBUxUh8QjespQ
 /ZF/OBqWN9aDVRU7NAW3Kt01S/Rmr6Is29cBC2wngsWDZo9DZ9yHF2xqhzRaq5LlLkEL3g1hXyo
 n3mUTQJy8z2epyA/rSADyX/B8IWfrdUEHqL5ALFJbKK5acxdaLgl0Basi0ZgRNdaCa7gCPARc2u
 g0sacjlUF7AFvoaOQuWmXpIfWCs8CyS+/zPQDIA/kH6EAslluP7tXA1Kou2LEmAbua3+W5LckH3
 cDdzptLsuzZgoySyJxMFyP5Qyx+a4FkQgPr1x8/swrmpUfLJl2nkKtVzshOQrxn9hCA5XR1pXuH
 hdIe1
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In particular, doing this makes NFS4ERR_NXIO look like -ENXIO when
the tracepoints fire.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index bc67fe6801b138204641319ecaf1115aac76af62..eb7d625d45e83f025ef96952660dded85aa0ca89 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2089,7 +2089,7 @@ DECLARE_EVENT_CLASS(nfs4_flexfiles_io_event,
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%llu count=%u stateid=%d:0x%08x dstaddr=%s",
-			-__entry->error,
+			__entry->error,
 			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,

---
base-commit: e63b29244e588206f4d417ae27dc04bf1d58b982
change-id: 20250407-nfs-testing-61217f89ee25

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


