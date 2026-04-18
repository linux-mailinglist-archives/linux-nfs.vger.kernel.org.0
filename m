Return-Path: <linux-nfs+bounces-20945-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DtqG3/V42m0LAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20945-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Apr 2026 21:03:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC5422036
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Apr 2026 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30C003005332
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Apr 2026 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3E288C30;
	Sat, 18 Apr 2026 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZKviLAu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19F238150
	for <linux-nfs@vger.kernel.org>; Sat, 18 Apr 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776539002; cv=none; b=f2v7cqgsnVtjSBK6Xrnv95oKPV3klWUfGpWvlpemIfTsEsa0PoOYpwFNTGBoZ125ML9copoc3pv9+K9XrHTymcbKItefkyk80xtRD3CHeiFVgZ8WWRhLoys3AzjaBMtiN8vWU5GWIcwaiBY6OxWOOdOe721c9FcUNTJeumN3P7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776539002; c=relaxed/simple;
	bh=g0z8YNxiBgqdYk61dtTak3Vv/h6JMjfNX/dzjmM1hvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atBs5IbMMub5H0jAdIUqataAnMopJcXLBorMgO4UfkmZ2yluZ94N7AJgi0GIioVPu0fKqlMuUkBpFiXXPnrmBAf00QBQnO/ciEyb/OthDXh2aGNzucmWActgi/psoLTdOjeaFELTW5nc8Xt5DOeNlPgZdVkfTRf0s8VkivHypdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZKviLAu; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3352824eec.1
        for <linux-nfs@vger.kernel.org>; Sat, 18 Apr 2026 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776538995; x=1777143795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsqzOg2VKZDHNlx6p30Sb6Dk9S8WhdSUH/qYOmyW/Ck=;
        b=qZKviLAu9avjPex8jjOGhiWYD7pEWFEZduRQx3ex+6TTgvXzuDssXo0jnUjLRKRJSR
         J+Au4jQA1fLwBB00cmPreFgljLfWG3E1tG5Sujck8EVVILHXjf1m14V6OPJUGvuB0c8e
         QbyuERRRcq18JBwnJ5T8eCEUDAoXOTHdFTMot7LLedYpbBhbnpg88Yk6EmK3JKrWMqKe
         SXNi5pXBt3eUrTSRFWbugf6zCEth9IvTb8E1wGqeGO4rBAC+H23qrcH+jctQtL4wQCoy
         pECf6dTxO8cUhdXscSyA9KTtWTDpuRORkflr4st1g9Eon9PColHa4skllfRZn98BlO3T
         aryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776538995; x=1777143795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsqzOg2VKZDHNlx6p30Sb6Dk9S8WhdSUH/qYOmyW/Ck=;
        b=sP+NPd90yXUhWfpEV4zXk/vuBf88XpIjYQWeT3VVtO2bHwk+E3Al83SQH9aMa5xTr7
         2naKg+O6Dw0HCUsjYSsnPwiSR1sqgI5GoKEFDUuWro/Zgrs1yEhlnLt4ZTYIRAc/uiqA
         TQB3Qn8oRbibIX0iyU2aRyZKWdZgxQCSVFBBLOmSBjqDe4+AQayQjazUbiS+tkCk8Ylz
         bSTuZcpewPfF3UbdlFScZJ9Z37eg3I/jt/faaFJjs81phIfuchIqrp+fpr1R4HxYu+4B
         vdM9E0/D6ccG5iK1/gfV066dAi/x7LtjV+dWS7YNalu+UpJ/nFcItd2h1aMOv6MDR4Is
         UcsQ==
X-Gm-Message-State: AOJu0Yy9PlB0XY8uLv4Gx6jOxET5loT4W0yGrEXf01Q7/mtYlXD0rwcR
	AhZRoEZG2t26rCKD2E/H/Uz6wYvT0O6oOGFu5VoY5VKBNixd7vFadEa7S9sJQyJL
X-Gm-Gg: AeBDiesB125pj13CSexI8XH8/8rb6Lnh26Q8PZ08LxZp9b6M3XWRdGBfW6YhHaP6iY+
	oy5f26tg5PGWvI/xDbt1O026D4fjSuM+YYKT1UFT8LOCtzOCIam9c0H8zbMme3qL2rrp5CDoY5+
	X3HQV+gp5HDcLzW/NCuyyxkLgAAzLTfIeNh90ctNtCxiccaWIZW32x6TL9l340qT0nJ14YnXudW
	SY+59N6KNRFE72tYC+Deh6hGuNBTow7Q4ZhgEHjr0Isi3ySTJ+DjXH1cIo+uMGxFSt6BNaD8nYT
	UxWRy6LcTnP3UiKkTETr0TVDJE8/PC5UqRs1xN1HvsfeFJIOeGlSvXMTJNhy0HvnIj72JWPotB2
	91HnauXLGB1f8LSq+qLs583JwS/yB4NtnVMv9ba8AlwYacSw8DDwfkuQ4Y6kgJrQwc4e1woQmG0
	Yz4h4idaNfK9X3lJJ3ip6SdZ/YXIJettGymF3FDjGni9IxbXIQCxL3TbT3Ymz6ayQCRvV/tcfYq
	A==
X-Received: by 2002:a05:693c:2c0f:b0:2c1:6cfd:73ee with SMTP id 5a478bee46e88-2e47901911amr3888888eec.24.1776538994993;
        Sat, 18 Apr 2026 12:03:14 -0700 (PDT)
Received: from shadow (c-174-160-87-152.hsd1.ca.comcast.net. [174.160.87.152])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2e53d8b3dd9sm7254785eec.27.2026.04.18.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:03:14 -0700 (PDT)
From: Tom Haynes <loghyr@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 1/1] nfs: don't skip revalidate on directory delegation when attrs flagged stale
Date: Sat, 18 Apr 2026 12:03:01 -0700
Message-ID: <20260418190301.3661-2-loghyr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418190301.3661-1-loghyr@gmail.com>
References: <20260418190301.3661-1-loghyr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20945-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[loghyr@gmail.com,linux-nfs@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 28DC5422036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On a local directory mutation (rename/create/unlink) the client marks
CHANGE / MTIME / CTIME as invalid in NFS_I(dir)->cache_validity.  When
a subsequent stat(2) enters __nfs_revalidate_inode() and finds a
directory delegation held, the function currently early-exits and
returns the cached (now stale) mtime to userspace without sending a
GETATTR RPC.

Keep the early-exit for the fast path, but take the RPC when CHANGE,
MTIME, or CTIME are already marked invalid.  The delegation alone is
not a guarantee of cached-attr freshness once the code itself has
flagged the cache as stale.

Assisted-by: Claude:claude-opus-4-7 [bpftrace] [tshark]
Signed-off-by: Tom Haynes <loghyr@gmail.com>
---
 fs/nfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 98a8f0de1199..936bc329f462 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1390,7 +1390,11 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 		status = pnfs_sync_inode(inode, false);
 		if (status)
 			goto out;
-	} else if (nfs_have_directory_delegation(inode)) {
+	} else if (nfs_have_directory_delegation(inode) &&
+		   !(NFS_I(inode)->cache_validity &
+		     (NFS_INO_INVALID_CHANGE |
+		      NFS_INO_INVALID_MTIME  |
+		      NFS_INO_INVALID_CTIME))) {
 		status = 0;
 		goto out;
 	}
-- 
2.53.0


