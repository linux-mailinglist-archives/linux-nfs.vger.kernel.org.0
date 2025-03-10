Return-Path: <linux-nfs+bounces-10541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A539A59363
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 13:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F029316C869
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AE221732;
	Mon, 10 Mar 2025 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="AsiSVLXD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293C2236F6
	for <linux-nfs@vger.kernel.org>; Mon, 10 Mar 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608279; cv=none; b=GEroaiDAS/O8D66bWCih/ZdMDxRdFpIsOKS5h4uuAG2FvRW5l5jPUq7AvrZT8TDJ8FKAUSlCjyymzBRdKmfavxLxh1jcT2V9xcWyuPjQ7pQuMgHSIpb71ybbIQ6wOrIejdNi23/R3yMyu5nFo/C05Vuky86o/EqteTM6qmpBCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608279; c=relaxed/simple;
	bh=02m7HS8p3M2NVYThb+is6nxwVhkFs/922ZI/gp7lgJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6ntg/1OSBkkWXFnZ+JWPpAceMXa2WJY6KqgWHSlIMUU0sCfSlnziWSSCYAlRHAdcjDNL0e35NRoTsubOgnCOgsokmuHXP6KZmDqqvAwOdzyQNkZXL0c+Irg4sF7N8arHzWJg5SkyC64Z/FRxxeX0jGzn5J2ZtlbIBZMqOaNKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=AsiSVLXD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso406218f8f.2
        for <linux-nfs@vger.kernel.org>; Mon, 10 Mar 2025 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1741608256; x=1742213056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2y7BvTsTUHsoTkwoCfrOdlQ2HF7SbMnbZCz2hM5+uw=;
        b=AsiSVLXDN8NI7JBhyUY6Pbyob1Rl2UzVciJeJRrwY/7VipKMCMYn4cCeZ+Rqz+/uxD
         x+jjnLLgkG//jbkzK/IFPKLLPlFOV/P6xyjuRwbZPwb2ZRlDTe/I4UNYxb2n5bFz5GgD
         sp0xnCw3rDFElKZxhYf68HS3x+LBmmEDDBBivbKI1kekbHHro4R6prS95zUAVsjn9FiR
         0svgKJZIf+FLTJYcLMJ/TZaW7q3Z4cywy6kUqUCC7NX1m6zYyGzFPmS5fIuOc/b+WiI/
         ELykhTtGQ22I+3Nqhv5XO72AWO7EyXOLJdYSE+ExnFmTi5HROcwjcGZrUwS4nO8bifhy
         emwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741608256; x=1742213056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2y7BvTsTUHsoTkwoCfrOdlQ2HF7SbMnbZCz2hM5+uw=;
        b=Z2liROySdjPPrXlQkh4Qle+zyodw9s9EOka1D5v4JP5VhGpuHXwSI766dx5+ASEzb4
         IowgD791/P6MqqCwgLCRdMONWwLK+PHVd/vo6IyMt1ao4WhTd/M6my1fx8e+sre1AQgv
         tWh5pTUR3OduVVx/aFJiKjZclpWNj4zdcY0k1dDghT4PS6ubIN7fd4jd5Yp4TpxJWuIj
         BEth8FAD59sWQb/COImB//FKGCCQHA8YOYD90RgmHQdi5rp3yBv3FZPPSfCOCNCUxUWG
         TnqXufeTiu1UlOA9/GHzTICc3GADA06WFEP5Gr3z5ckcUKq/dLxcV61CFalrI8s+tzUy
         f9nw==
X-Gm-Message-State: AOJu0YwaUi22I7/6xF/tjamk9gF0twoN0eJ7iSxkXcs9RtJ3UZ0BY4Ui
	XBzV/uyQZuJ+fjZjm/ZKeDy3ih2jbMY/IMvDS2+iu1GbgWfHpECF3Ci0SLR2p+wxgi6pR3EU79t
	b
X-Gm-Gg: ASbGncsShQ9lzeg1t7ZtubQPeY3CF+HjCzzA9bYB3VHKX2SM3RJtg7E2qDumjFTlqXS
	ZO7aU1cCyJoBv9M6jQ8/Ton0uAhfEHLozgBuAgaIhEDihgW9YLSlZWW9MZbvZSGp9Bd8g6eVd9m
	0zYnxtZSy/uWpgciKNpU96h43igI7l5CMAmtJtJtWlRyVtiAqsFXltKHHHm6bJPQGlh0kcqqFcD
	F83IsShlACO5+HUA4EVWQIBUO7amSHH9EXrsj4M8LeKahB6B9FJkCVaBkEditiJqVbpgdJos5oZ
	At2GT2wr9Nvx5iaRHDzV180v2hVKvmqiBjQSh4ptHGU7Ta47pt0A1ruSC3WyvteUlcrXPnPPUqc
	NyGZsAx99B6JfYReKhnNWNQ==
X-Google-Smtp-Source: AGHT+IGf7ngd+Ob2ja8AkeKjk5suCmE107HS5+F92Tn7iReGULsMjOmCrx5LrF2YBK7vWRHtexfuwA==
X-Received: by 2002:a05:6000:18a3:b0:391:2e19:9ab with SMTP id ffacd0b85a97d-39132da8e5dmr7473554f8f.47.1741608256234;
        Mon, 10 Mar 2025 05:04:16 -0700 (PDT)
Received: from jupiter.vstd.int (IGLD-84-229-89-124.inter.net.il. [84.229.89.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfe2bsm14590852f8f.24.2025.03.10.05.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:04:15 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] utils/mount/nfs.man: add noalignwrite
Date: Mon, 10 Mar 2025 14:04:14 +0200
Message-ID: <20250310120414.2515090-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 utils/mount/nfs.man | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index eab4692a87de..744411688641 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -618,6 +618,17 @@ option is not specified,
 the default behavior depends on the kernel version,
 but is usually equivalent to
 .BR "xprtsec=none" .
+.TP 1.5i
+.BI noalignwrite
+This option disables the default behavior of extending write operations to full
+page boundaries.
+.IP
+Normally, the NFS client rounds non-aligned writes up to the system page size,
+which can lead to "lost writes" when multiple clients write concurrently
+to distinct non-overlapping regions. Use this option when your
+applications perform non-aligned writes and you can guarantee that file
+regions do not overlap, thus avoiding the need for file locking.
+.IP
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
 for NFS versions 2 and 3 only.
-- 
2.47.0


