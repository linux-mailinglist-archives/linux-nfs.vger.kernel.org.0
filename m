Return-Path: <linux-nfs+bounces-2643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A8898FEC
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 23:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5411C2273C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77013BAF5;
	Thu,  4 Apr 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbEA7fU5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2E13B7A1
	for <linux-nfs@vger.kernel.org>; Thu,  4 Apr 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265140; cv=none; b=H0S5hHLwhgzhJQJFIjFVH3KZI74kOI6r1KnM1JRrWcORet5ytsTU1dHilpwOqNmEJp7qSt7Sv0P6YFL1qdpGPpuT6HdLpuLhPs3ksxPq5KB0dGaPGbt4ddeON00WzDXTCnZXqrkarwFT2H9YUDHDTM+OwQ+hef+BjepX4BRey7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265140; c=relaxed/simple;
	bh=rmpxEp+C0OcbGEDkxWOAGQNTi1sVEOjwbv+sDWt+/Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DZcAAyLVqeLkuS/2sedRM/4GePj67YZ1WDJ9diszUKx4B8q8YDxjHOIpsgkhr7vPOHtjn8SAidpRydscgpyuGzN31yzxuKw/5d86Bo7Nq74RkyV8JJWdJvHSHaDZrADIrJzRyrjJHCLcogEagFpIpFEMPspK4gDK6UfoQLUj3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RbEA7fU5; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1142132a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 04 Apr 2024 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712265138; x=1712869938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhX44PZxMShjVYoGq3G73EA+Wi27qMQMkpuZjx12edY=;
        b=RbEA7fU5v5Xf1qRz4w9YceUB3cvxwNfZlsnpdy25hOlE30bd1EW0RmlfRa5oWKjMdL
         nMnY9Jp7JNOYwuOkRscbyz+l0NPIBpOwkPSItGnnLp/zh8lJH7T+0zJh1awVX52cybvI
         I7agHFQI0pzQOlDb2zdfUFejERw5x/qAvVUe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265138; x=1712869938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhX44PZxMShjVYoGq3G73EA+Wi27qMQMkpuZjx12edY=;
        b=Kpdonl374pjCPKTwjdYCxyIk8wCGAfT4RWGAkMQzg2cgUGB3/NKG4A0t//mtMZ8+oP
         YFUFhv7xqMtB3h8xES8BZ9o/J5Az8rp7RPu7RxzYGNVTuo/QE5cH60P7aEf6jciEfOxi
         lrqxc/2UVjCdPZAMwk6Ke3Wy6rFOfNMoO0boJo2v9psF5cc+c7hCMF27q9QT6h1mct3n
         LOPCxo21ySBlBQ7ltm7LpMKrpJDsxNVKeLWDO0Q4LmK1K1KQn+gxJTmG/ynnsd3mGgmZ
         YmT+7MD1wY8usWzjcwiHnPAksTI+DpEhwfJrOyYaCBbgvC4Y5DHTlrUVhDoigshUZdEN
         r47Q==
X-Forwarded-Encrypted: i=1; AJvYcCXI4ExOWLJDuCi0k4zvbFHqvd7ekCbDatD+ahrWm696kQwhPywh8IhfgNpEDjPYJ7ETzhi1PK48WYlpa8En4uLdjgfk/zpq/nqV
X-Gm-Message-State: AOJu0YwevcskoJHjLVwLL6MhEiVCYjurhsqiND6FLg9uwxOtP8gWLMTI
	b8IOA6EByLi51geMY4uscCpTHTnfvCHoGWSNuQLjJkxxtyzHz/RHSIuus4XakQ==
X-Google-Smtp-Source: AGHT+IFqM8VySROclRyf1p9rfcfaz3HrAGbtUdSIx2Fha13TTWK8topWfvLSWg5anuCSRfn4+MFKew==
X-Received: by 2002:a05:6a20:96d3:b0:1a3:ca1f:8baa with SMTP id hq19-20020a056a2096d300b001a3ca1f8baamr974551pzc.32.1712265138584;
        Thu, 04 Apr 2024 14:12:18 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f16-20020a633810000000b005e43cce33f8sm98046pga.88.2024.04.04.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:12:18 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: Set file_handle::handle_bytes before referencing file_handle::f_handle
Date: Thu,  4 Apr 2024 14:12:15 -0700
Message-Id: <20240404211212.it.297-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614; i=keescook@chromium.org;
 h=from:subject:message-id; bh=rmpxEp+C0OcbGEDkxWOAGQNTi1sVEOjwbv+sDWt+/Uc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmDxevvtFzbzRxm8cDZ8cTll2vfRi5DH5lS6YKy
 34KbZHhsfOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZg8XrwAKCRCJcvTf3G3A
 JtYEEACeo0yEzeZpPuvbwu/KgrcUSo8Rn+f6I2gueIa/keJEuxCDBp4sDQIy2MimWUHier93a41
 mEtmjDA6wx8XGrn2UgP50X3KgM8X5CFScX49cahz4RTiZvDNg3Dy3I2MnUNup5iKPjE+B7ya1sv
 oznhMgIx0toVd3tKo7w98bwpztzh20u5Iaw9Joy6wwdcgd4s8SibfWJGbMyr+fl2sdeCamwmXcK
 PYwQFnomcswHly47ebMJIqK7amRQYyqYrh3qauFf4dZL0uIHvteVpMWuE4s/gOh1Ya5q2B2okEl
 wRE5c4u8yH7npBZf7dDFpdf4w0VZYSID0Ela5rzU5nVrTdosygUe8fa15IiERmdBVKhuWPWjczg
 3Dq956Nec2I2cW1z1Wuhs+gU65JmTx0jmPhJlQodhW3Q7XwySIGRCuLceji6aE2pyFdJS3KXAee
 VlQfa0qKqqFRWpGoy54tQWEAPIk4C6b/L8So00406EJ1ZEYlcRxWj/3zkDkpwR3072Ud1qk+pMJ
 4jWZm7FDKQSTpIWPv1nNz2ccHx4pWQfxE0Dzi7y40bhxxGBDkA17iY3PMjORmY5tKyHfI7skXCF
 SWA0hzsdsyVPSIuwJhHE2bHLvzVHynfC9feCKnAhIG8KzmUwwHGDGBpf8ws/PRXRyXCjCj0JN+F
 U4d+fLE gjH5uNFg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since __counted_by(handle_bytes) was added to struct file_handle, we need
to explicitly set it in the one place it wasn't yet happening prior to
accessing the flex array "f_handle". For robustness also check for a
negative value for handle_bytes, which is possible for an "int", but
nothing appears to set.

Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
 v2: more bounds checking, add comments, dropped reviews since logic changed
 v1: https://lore.kernel.org/all/20240403215358.work.365-kees@kernel.org/
---
 fs/fhandle.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 8a7f86c2139a..854f866eaad2 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -40,6 +40,11 @@ static long do_sys_name_to_handle(const struct path *path,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
+	/*
+	 * Since handle->f_handle is about to be written, make sure the
+	 * associated __counted_by(handle_bytes) variable is correct.
+	 */
+	handle->handle_bytes = f_handle.handle_bytes;
 
 	/* convert handle size to multiple of sizeof(u32) */
 	handle_dwords = f_handle.handle_bytes >> 2;
@@ -51,8 +56,8 @@ static long do_sys_name_to_handle(const struct path *path,
 	handle->handle_type = retval;
 	/* convert handle size to bytes */
 	handle_bytes = handle_dwords * sizeof(u32);
-	handle->handle_bytes = handle_bytes;
-	if ((handle->handle_bytes > f_handle.handle_bytes) ||
+	/* check if handle_bytes would have exceeded the allocation */
+	if ((handle_bytes < 0) || (handle_bytes > f_handle.handle_bytes) ||
 	    (retval == FILEID_INVALID) || (retval < 0)) {
 		/* As per old exportfs_encode_fh documentation
 		 * we could return ENOSPC to indicate overflow
@@ -68,6 +73,8 @@ static long do_sys_name_to_handle(const struct path *path,
 		handle_bytes = 0;
 	} else
 		retval = 0;
+	/* the "valid" number of bytes may fewer than originally allocated */
+	handle->handle_bytes = handle_bytes;
 	/* copy the mount id */
 	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
 	    copy_to_user(ufh, handle,
-- 
2.34.1


