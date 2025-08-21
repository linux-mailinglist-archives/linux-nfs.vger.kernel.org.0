Return-Path: <linux-nfs+bounces-13864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEEB308E4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2260662465B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 22:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F822D23A5;
	Thu, 21 Aug 2025 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q88pIMJS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F112E973D
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813848; cv=none; b=E+xFXhkIRlt/wEarbK2YZfxq4YhppaMMEMl4POfZb/ZS4yI1ukBUkFrHKe+ac6HTBkOPQl/Rd9wvF1xJ8yj3EjqGBY13aRJqmY1BBawspSMPaBF8j85RYx5QjPOGRuvn3ijHT1kBKVHq9B+o/yMWAnNXdXgZXmY9ulwC60aNmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813848; c=relaxed/simple;
	bh=FdEoTcYfHJYUHvWSfZWk2QLCQ5m6OWE9HusseHFy09c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r19hpnNioiSkHcPn23VRdzkdPZf2UuSbKHWODSMc7ajuRzt3OpLiEHCKOOln9fisTU13m7ihHdlRzpBiaZbt0ippMCmaIMdzFapdEFMZUeexxuxSL8cJbJp6terPoN7umsUMyj6jeu1WYtJyPfU9u6ZXH6XL0wCN3OHiXRYC6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q88pIMJS; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e951dd0689bso165678276.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755813845; x=1756418645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9iIvEMYTQA2Jcxed0ZALCJ33xCfOHA0AXGGQAY8ZRg=;
        b=Q88pIMJSqtIDAu7jObRF9DjmwZD1hORvNPMN4xSS21tpRIHJB07WFMG4Pi6mcct5PS
         Uf0tzrH5DVWFymwC5WM/GsUXUP+W0do9nbuMEBcQKvlySHgfE2R+YBARLMbaw5FVpA42
         jFsfdSPcjsGjoshaFH9mCoLC90BAQHkwN4LhF74IiCcugt/sgizg5S8lwL6VfV0Cs0Zd
         GQ1ZFvFTLIMDK0jZ/u6oh1/+HS2tC6+E2/d+fuk5aK1x0idUKeOyayC6odXPT9flIamR
         03LeNLU8Y+QGktIEVvFq21nSRcGi/iDGTyBUyjldAp/WaGkZ9cMWtcxyfg/BnVD7iN91
         6HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755813845; x=1756418645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9iIvEMYTQA2Jcxed0ZALCJ33xCfOHA0AXGGQAY8ZRg=;
        b=ACwYqbEaJxCWztkgNDP6zmo0ULq5Hxew1FnzxBowNS+Be8jCjpRdx6TgIIF6sCMkSV
         ySVOP/sHAmrT4c1J9Us6IDsbqIWkI+y0AcywI+k3OZqhb5nnacIpCR0q9L8dIc9iU9O4
         MxWXiXFlGTxG88PWdEnZVhqVnRExDpKVZj++qOBItGanvF7GvTYLU+mkVtTd0LPRkmnJ
         ySbwtdH4xX3YvrwRwRL6Fdr0UCg1HIE4EYNEnI9cBePpvGSXbCu/jbD0NKg5aB+vjmyA
         VmhJDZQOA52xqyBa1fE+oVIzGv98OgZXcN01q2FqLuQtW6a8917bslSGEz2tbXdKCI/Q
         NKHA==
X-Gm-Message-State: AOJu0YyUS50nKTGnXzWFn2L1ktI86MBVRnM+FN8ol9lfikBfw5whQJrn
	2e5oNsm+LEUYcigVm4S8VRW1xaPwiZvgUVQcA1Wfv+dWczaV9wiLRFAWPAJJsx/3
X-Gm-Gg: ASbGnctC3i2P6OU3otkYv75CYXwg1vx69F2SGSu7uUf4dlW9MfAHAyVJp0SJxw7TUr7
	J3BAF5VEBfz7HAXFxR0GS6Xko0j9eNu7i5taK6uS5KLnK2RPf5FXkC9JBF2qAVsZU5gux9snzWq
	JqkrIMR69QVVh7W+lrKYDu1HqshPZ2mn05gAhp9ZQJw085K6mpDkx6xKUztw1nkPGmVfydFgfnM
	vQBDRrKo39PxaAbYNXvGNHUvGbA4Q2btn4Bw0GB4NeGcjsjqV6/LinwICqLHQvd/jlXPrCDSutC
	BQolhUcN2Aso/KqwanJPQT47k627LrsffQbSOJdQjOsc9mVj+BmrpS54IcaCpnofoqyTRHVZPCS
	iP5d6DIuMxFx/UfKINw==
X-Google-Smtp-Source: AGHT+IEvZdhmaO754esnqeFAYbpLaezIPa496wx1Rv59p4TfW1UATmI2NQ/MiuORcsHLz3suhRrjJw==
X-Received: by 2002:a05:690c:5:b0:71f:b944:ffd with SMTP id 00721157ae682-71fdc5391d7mr9153257b3.48.1755813845366;
        Thu, 21 Aug 2025 15:04:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fba5eeab8sm13253507b3.32.2025.08.21.15.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:04:05 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org
Subject: [PATCH] nfs: cleanup tracepoint declarations
Date: Thu, 21 Aug 2025 15:04:02 -0700
Message-ID: <521823b0d5aec48f9cc79c01bdda054e49f45170.1755812833.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup tracepoint declarations by replacing commas with
semicolons to better match other tracepoint declarations.

No functional changes introduced.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/nfs/nfstrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 96b1323318c2..d7ddf3bb5402 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -966,7 +966,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = offset,
+			__entry->offset = offset;
 			__entry->count = count;
 		),
 
@@ -1016,8 +1016,8 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = offset,
-			__entry->count = count,
+			__entry->offset = offset;
+			__entry->count = count;
 			__entry->ret = ret;
 		),
 
-- 
2.47.3


