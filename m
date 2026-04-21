Return-Path: <linux-nfs+bounces-20976-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJEkJw8f52mY4AEAu9opvQ
	(envelope-from <linux-nfs+bounces-20976-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 08:54:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91775437336
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 08:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A7163007238
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064862C0299;
	Tue, 21 Apr 2026 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvqqFjGQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBE276041
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754439; cv=none; b=IHk8rkY0qIJ6TvPYZy2lf2/87dT6Fx0ASpfxhAAbncsH5IsbIoYdLAYQhXc/eD6u8xbB4hVRwWGVz/ScT3KtNiys26oWYm9pWr4S6KodwnWD5qvPbYVugWTz+9zMKdMKBlQLOtIDT9lh3Qzo0FoeH/ZeFe8DL59DcTFpUxVIkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754439; c=relaxed/simple;
	bh=d41oJMtdR5hLahQbAurD2fxOHD6TsRZadRYNwDd6EOM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G84ozyOH3kiFbuxYW4Ej5BswcQZM/NpvLEmXCdirW1jdA5N2IGzQULovmEH/37YY7VFK+NZpsDp/zaIO0ZI3lr4zaJyvCFb9ojKsQGEitP1rRwf8rf/YG32FPaj7Aj3hov8nl2T6OB3jPINIho1mqbh86yT5B1rELUA1Pqc32W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--arikrinberg.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvqqFjGQ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--arikrinberg.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8fa5744b82so370987866b.3
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 23:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776754437; x=1777359237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w8qxc+AK88GVmUhBrOqxPzW5lfHN/9VUf3/T0PqVfgM=;
        b=jvqqFjGQMFCruw/dVUhA1aiIb12ZVLiTqJVj+jCmPQ32iEzFPR7mLjLn6OJcgzQM3v
         uS+s4LAWIkMYMkonkphS+XwuRqOMf6P2WJA7YGmBkm/wjqnX0mC6fuzw2Fp0MNKgEJIG
         OrGAJPiS5l4f0eSDEKya6Dl9X2Iskngpi65hv5QpAKxHRiWOJ5RRV2zuWFb+M4jsSDX/
         vwzh1M8kKl2yueSiny5OjhAIeYfE5FzrxIlxb6UGT1e4lWc6avonRfbmfDEfStqmltGs
         gVYN+J0EkPhsK1rCFzGrTyRcoL7FWRXxLfHasQ9Hl+rau2Z9qzpXs6wp7riz0yjqzOQA
         JwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754437; x=1777359237;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8qxc+AK88GVmUhBrOqxPzW5lfHN/9VUf3/T0PqVfgM=;
        b=R5vWJ6ByBjousX6CPowKZXLQFY4CSye805Y1C/D2asrSS7Ml5GKRmQ+EbD/bk6JYoD
         lSo/UanOdo5zRrVO1v49ARn3z4azJ8GYCOJFsaTd/FGwls9NlqYe1qKRkMpfA7dWfaTu
         0e9CK+ox+Rnm/5RuTBkQNeYs/Hl0NcfAWC5KFc2GlNmTz6Ha3z1DrGOs2OIeP9ZLxyst
         lgrY6WZD+fUOGYtXl5GWLa2WJ7Owcwf1vrWmSgRYeoWzqmFvtJhXiz/l0oSdL/oHJpJ+
         tk3jBuGSTVTZhqN+MwTFaZDXwUIfwuZpUZetxnJ8ptzlAFtPfiUiHy6huc2cJ/r2QPU3
         Xyhw==
X-Gm-Message-State: AOJu0Yy/YCB7gW/K7fPM13N2bXX5mPJEH4JzykSAQe4UWlTvh69ljlHX
	dMhogAlNbx9eqk/ogLHis2isrEtwaZJDxVXehyWLS5ZpfLzUwMz1VQjTqqPFSdKLA8kYGmYHXO0
	JjzB+eKWFdXiYimEdrcSZuccnew==
X-Received: from ejbxd14.prod.google.com ([2002:a17:907:78e:b0:b97:99ea:ac7])
 (user=arikrinberg job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c302:b0:b96:e593:fd24 with SMTP id a640c23a62f3a-ba419658d6fmr1003129566b.15.1776754436802;
 Mon, 20 Apr 2026 23:53:56 -0700 (PDT)
Date: Tue, 21 Apr 2026 06:53:49 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421065350.2219737-1-ArikRinberg@google.com>
Subject: [PATCH] NFS: flag files as supporting FMODE_NOWAIT
From: Arik Rinberg <ArikRinberg@google.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arik Rinberg <ArikRinberg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20976-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ArikRinberg@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91775437336
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When opening a file in NFS, set FMODE_NOWAIT in filp->f_mode.

Without this flag, asynchronous I/O frameworks like io_uring assume
that the file system does not support non-blocking I/O. This causes
io_uring to punt all I/O operations to background io-wq worker threads
to avoid blocking the main ring. This results in performance
degredation.

By setting FMODE_NOWAIT, we inform the VFS that NFS supports
asynchronous I/O natively, keeping execution on the fast path and
restoring performance.

Link: https://github.com/axboe/liburing/issues/1499

Signed-off-by: Arik Rinberg <ArikRinberg@google.com>
---
 fs/nfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 5d08b6409c28..8e2100550f10 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -73,7 +73,7 @@ nfs_file_open(struct inode *inode, struct file *filp)
 
 	res = nfs_open(inode, filp);
 	if (res == 0)
-		filp->f_mode |= FMODE_CAN_ODIRECT;
+		filp->f_mode |= FMODE_CAN_ODIRECT | FMODE_NOWAIT;
 	return res;
 }
 
-- 
2.54.0.rc1.555.g9c883467ad-goog


