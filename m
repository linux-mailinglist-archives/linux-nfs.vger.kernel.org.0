Return-Path: <linux-nfs+bounces-13111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17AB07848
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713004E4A76
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAA26057A;
	Wed, 16 Jul 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="lZ/UvWGE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40225C81C
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676735; cv=none; b=Ks9MtzxkylEOfZe/4vtYEur+bItYJ0wIev5AwvuyKbzWyhI80J1Xtw53Z92Ksep84ZG5y3wcC5f06XmW0w8FPaNfCCM1Yb89zmNHtokjSzYFZX0kOp9/R8iJz0n9cqcKY8n8iOdHsRa9tBpi7MIuRXKWVH8e9Vq4AVnCaEL9QQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676735; c=relaxed/simple;
	bh=G+S/L4vDU7ik5AAtN9qkBKBLi+s5yYxSyrlW2Liq+UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmJFwW06DfxAnFoVZ+MKt2QgfzqQPMyPI4w6pOQMgAtC1n/T/4cgKPL3yXBz1zU8kDGKySVgmknYVAf42w8Stj6ABHbkdLlLymJl21ON1wqS5T7XLdu6zqPnOQSAe4MfpPwBzfa7+4hZo+DoOi2iLKCt8jwnWT0c2QSZPS1SDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=lZ/UvWGE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so3926009f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752676732; x=1753281532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa4++ALrt6t+/8Jjl/X2ucfX3WrNgLwrbp0fvXsZWM0=;
        b=lZ/UvWGE/MQuu4NfytzroISBiP0LI/yNhRVG+lCK+09feSb1Bb41ecPMPzT0GOWvS4
         YFkD1mkQVV75QBRS+G/WBDdvUQV+as+1AxSlZEWLlwTlOrL+I6v6RW8IK7D2YzGl4Nsp
         IXuKuiMP/xRFIi0ZexOzCxdpzHVFOVAEnxo0U24B7bNh1XjAsBXLCZoSigo4Ak4GXGMl
         OUkIgThJM22zPS60zzFTxd6mVPH4zrpNFbtLAA37sjjGCECglcVgYuQjAerqOWF59MkJ
         H+LwIOoxboMhIUh0lNb2rXHuoEGsf4Yrmns/CWqy6YaKWuDJb0QMKetgWJ55BZg2d8Jr
         zVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676732; x=1753281532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa4++ALrt6t+/8Jjl/X2ucfX3WrNgLwrbp0fvXsZWM0=;
        b=TV49OkA8JxEvNxWHsqL1M1xo+CWwdRlJPvO73G+cYq8cF5Zoz/4aiKCEBu90ujhz1h
         HsX2HulIW7Lkp/q0E8PfCFrA4zt8+yMvttYcPt+TKIB6FfwlvmcwHunSoBEczj0z9bCW
         gn1wCosW3HneawTnYi5mO3ML1K1d4vwxOPB/U9iNcNaLyc9NWDnAATi7sAaZ+SYwfja+
         pSxvMMqQw+hr6xAKiwQ8hKRIdUIZWfmZiKpO4LgPdHGzbMDeDzS4rbCYvHT6CFEajUpV
         tYfn998X37K+3QMBtI2vZ6nWXeoD98Sha6yb4CLlVkO9kHQV+gmejTr7TGk8E9nrruBr
         o3MA==
X-Gm-Message-State: AOJu0YxAbV1gryRusVQ4py7z/Ftz7km0AW7EGkUMQVBURYGqohhhkoS8
	O1OoJQtfdGOHMf4c9UaQFQueQcbcRpjHFDXtnoozCrRFohxNwc20vtAJtp3dQYc+5/d0BCNgcWK
	eHPxsuvY=
X-Gm-Gg: ASbGncvQJEyM5EAS6Xhp77sfP+14LKjrCHvYsgemKLq99inaVKxZ0uG1uFyc9otXSMw
	4kJBXYmn8hSWa0HaBJrjlhDJ3HOn2Uxdaq9qJ+CmJZG1OgnXLIujpkeu2YgA62AVNFBAd/idcAN
	654/cuOUWOh8Tq4eSFAtgjG00pNAuWd7gslTkpE1aQEAWQAt7FlOW3qqgvrJfnWsHYOV0E47gmS
	4/AcpyARiaZWP2rCfZFnkiJi2pWj/QUgKmQ801QFn/vvMpMNQaGas8IZqQyH3kQh798CIZ7STzu
	5yVUAdyvbXE4eX4hv6i+mgtAGwBYq77aBNQRNThalYmB0EcjSfzjGaB5ZmM5b2ItCWrkCrDmv8N
	F6NT9l3luX6n26hhZofNRCuQepDmzx5vNvp6aasbRCkwYmroV
X-Google-Smtp-Source: AGHT+IGf2Nv6Qpohj3Wa6bab7v4TtpxjOwm0RwXHgagimM5JxzC2vsSdod5ASrIKxtXObfnaxVfabw==
X-Received: by 2002:a5d:6f16:0:b0:3a5:2d42:aa25 with SMTP id ffacd0b85a97d-3b60ddc6025mr2426874f8f.50.1752676732281;
        Wed, 16 Jul 2025 07:38:52 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:96ff:526e:2192:5194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm18202521f8f.71.2025.07.16.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:38:51 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-nfs@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pNFS: fix uninitialized pointer access
Date: Wed, 16 Jul 2025 16:38:48 +0200
Message-ID: <20250716143848.14713-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ext_tree_encode_commit() if no block extent is encoded due to lack
of buffer space, ret is set to -ENOSPC and we end up accessing be_prev
despite it being uninitialized.

Fix this behaviour by bailing out right away when no extent is encoded.

Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 fs/nfs/blocklayout/extent_tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 315949a7e92d..82e19205f425 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -598,6 +598,11 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
 			(*count)--;
 			ret = -ENOSPC;
+			/* bail out right away if no extent was encoded */
+			if (!*count) {
+				spin_unlock(&bl->bl_ext_lock);
+				return ret;
+			}
 			break;
 		}
 
-- 
2.49.1


