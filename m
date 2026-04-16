Return-Path: <linux-nfs+bounces-20870-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGGUOxMK4WnoogAAu9opvQ
	(envelope-from <linux-nfs+bounces-20870-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:11:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CD1411671
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1B3E3030EB4
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA222541C;
	Thu, 16 Apr 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPY6YOSc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58E3B1B3;
	Thu, 16 Apr 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355809; cv=none; b=ejw1Zql9L1MCg+1gFCX1IkhJZ6VuuijQA/NoPpulimyJ/xA8HOpWoaNnadIoGqFfQC440SwljqJ5l6QA8g6UULC1oMp95Z6nZ2ULFhtJ2ImemD9lhst8EWGaMLjfVFCukHL7SYYPppgDHKWoBlpAZt+UD3HQegdFB/dKWU67f64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355809; c=relaxed/simple;
	bh=zNY1LW774W2Jyur9N4iAkBR1nD1ddz1wz5W+31MleBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8Wqm9anrJ/Qcf13kCofV5Q+qrDXum07Q7TVdMgZDCM5LIYDHtug21V3syGcmJH80imTzTnBHY8oVYqm5BPF8X3lBltYjJvVxK25Vgr3h4eWukB5bCEyTJXXLuSnWvkx4XD1wIGspkBkbL817ZhjL5uBWYiGPEKI55evDHwtO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPY6YOSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B50C2BCB3;
	Thu, 16 Apr 2026 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776355808;
	bh=zNY1LW774W2Jyur9N4iAkBR1nD1ddz1wz5W+31MleBc=;
	h=From:Date:Subject:To:Cc:From;
	b=dPY6YOScrrdGxSw5ooD0raH5WPCG3ZU4JPAjpn4wdvmXSHYcvQc1oeF3tbBTmasAW
	 ybo3Sv3SnlhNS2azwHTXMppSvrEtQj12RBOXg11ES1X+mU7UiygNWNhHqfksqC4jFe
	 yv7zTcYEmZhQHPnnEdh9d61rVc1ZhPDrjytqo9uzobdjMsWtL+zVLfIOTC0gKBQf7C
	 DwRgnrcP8Tk2H85xM7R/S/rsHMWLB9fT/chz4huxN8kyQfghjLvWc2hthTeMZ4ucp3
	 21o4LioN9MevG7PRara4D1cFLudvRnUTMSHScWo470bn/wS7+Urr5ZCyahzSq6csET
	 zmoDYNhNnTu+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 09:10:00 -0700
Subject: [PATCH] nfsd: add missing function name to kerneldoc comment for
 nfsd_nl_parse_one_export
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-nfsd-doc-v1-1-313ee1b29ff6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3by04hTdlPxkXVMzkzQDU4s0szQLCyWg8oKi1LTMCrBR0bG1tQD
 H/vN4WgAAAA==
X-Change-ID: 20260416-nfsd-doc-564f058f6f88
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zNY1LW774W2Jyur9N4iAkBR1nD1ddz1wz5W+31MleBc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4Qnb/a/BkA0WI9YcJhmUZi8gbcLOXTrFtoffg
 xDSgH/6XkOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEJ2wAKCRAADmhBGVaC
 FYnSEADP7KXir2sd2WV+oxG2+sAEI8Ld8RGWOWLFdlJe4pYJmfjCJYBNyZvv3NMzctTZ9bHuGRf
 Ue3a9BPLyDR/UkIZXTcbJKqK6eagEflZtwJFW7Svs/IRxg7zVUa7gH5DG+uCMxDQ3fMsmQIkuMC
 pa7+1OdorS+HHB2dLObqwpma0ZcpiM4k6/gMe/jNrv5U4N65XZyOtTnwDqoHi9D/lmwfwmGUkuo
 I1nWQNzSrW/O5wNoFQb71mbrNeYzxlIARQtpug4g3GTTxKB61x+3emBFe1Gk66HNnqJFdEf655d
 3MQh1Mfl/vyS08FJ6T206r6WAcApRlQNpjRlCyvMeyc/ix/nf6uTAD623/57M+RpTCGBE4MObG5
 MMiERXPUk0f+KjYu68K0s8/mbHudnbMEhmg2aBwuAZ+2OuRj7BwlQ7f+M1UrNWT8BrlSrVt2X6n
 dy2OCWzpDuJIrK8+mbvh1uToUldmxSC19duqeP7vpY0P9fccodBIFvxLMdrrIy77TzCCfPFZsMi
 DZskSgiIfAYPCZOn4tKz7UlHwYHLdz4rC9q7maFB3gmyeg3z/K8UOZ+C0urKCrNlMH57cuzGOmw
 EEuiGYNZj4xslgIAPC0c5mZf6URmdvF+JWpr5pSM66fCK/t3Q0+JAGLG6QHblxpCuylmJlZ1faR
 W4GZvJEk6IvfRjw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20870-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31CD1411671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Anna was seeing these warnings with a clang W=1 build:

Warning: fs/nfsd/export.c:845 Cannot find identifier on line:

@cd: cache_detail for the svc_export cache,
Warning: fs/nfsd/export.c:846 Cannot find identifier on line:

@attr: nested attribute containing svc-export fields,
Warning: fs/nfsd/export.c:847 Cannot find identifier on line:
 *
Warning: fs/nfsd/export.c:848 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst

Fixes: 9d2c4bbf7435 ("nfsd: add netlink upcall for the svc_export cache")
Reported-by: Anna Schumaker <anna@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Trivial doc fix. Feel free to fold into the Fixes patch if you get this
before the sending the PR to Linus.
---
 fs/nfsd/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index f562d383439b..99959cecdbbd 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -843,6 +843,7 @@ static int check_export(const struct path *path, int *flags,
 			unsigned char *uuid);
 
 /**
+ * nfsd_nl_parse_one_export - parse a svc_export entry from a netlink downcall
  * @cd: cache_detail for the svc_export cache
  * @attr: nested attribute containing svc-export fields
  *

---
base-commit: 07a9f86d6ee1a0dc3bac47e9819ec5269d01a603
change-id: 20260416-nfsd-doc-564f058f6f88

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


