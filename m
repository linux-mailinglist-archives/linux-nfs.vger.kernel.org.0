Return-Path: <linux-nfs+bounces-14526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13063B81D40
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D381C22E49
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1662868AF;
	Wed, 17 Sep 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XqIov49C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C827A92D
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142116; cv=none; b=RQMbIBRX1GEXImV3ZRhuEZvKsXBWrzut6vRD2o0TXn7C+r3BVyHXgFpz2PvvU8L9R7thxM7QcjpPV4OclzgebTX8CceIYf+g3pnsZSQawQWnobdesjTaOzNWw6m/VjaeC0L6dVRpruZUPHs7hiBiiVNTmUx4QeZyOUyflAKzGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142116; c=relaxed/simple;
	bh=1xeGAreEi2x2Aquc/6dLVE/3TMfMr/uLa0az8bFjmD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hamVHtmGD1R3wGR4kkxwuGgjTwuPWMl/BYHeZrTRngW/gVxBSkRaBJKTXw8F3CqTCjPzeBNts7yECm5xRsdI+4x2F5O2F1xFpfW6DTiy6uuD0eIS/BznIMM3a1WstTPJV0lHC/uVL71Jk5ffLVe4pd02HWEZ34kBuFphMI4rW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XqIov49C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0415e03e25so39967366b.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142113; x=1758746913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=XqIov49CY3PEvVV6rv3GRmrdKP/mEqZuvnsXrA1/91bFK+v6qsgIeWlnNQZStaosQr
         ykSAHREPOrINFUQe35SLYJ10qle+81UpTidUJNOwRb0+XRe/5hED6puPgMwC6iCL6StT
         A3bL7k+/tn14s+gpOhlWuKOL/4AEF1N5YgXbnN3L0dg3ueJmt4c0m0A3e5XHyOEK9ZFa
         2tsKi/IkPYkgpFyokgRayrKM2OKnoNzt5Q+0SwrcvuEpBK3CAj+2pkoklGOtmNLUA4ry
         JnNkrmtNU7rH+VSOgOsNb1avd1ijfDVXKFFjSVsF46HvnXM6anqO4qWoneK32RC4W05z
         htZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142113; x=1758746913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=ffHVSBA2ndo+aK+fiESUFt+Jfjb12yhB3DqxWUNXZNG4fwYop3iVQ4sZ3Ei3HC6Ziq
         Ob8yC19d4VtGeshEgGr/eZQrygeFhZN0z87ekisQUH+844eMZuqYeSBYkCRt/Tb+MtI+
         iIAVZw7/fNUw+OKyqljr5glyMLB63B3hqIqt+qQSFn70ikxQP0RaYKHqHAWCyLz5ajbZ
         DY2ffOKPFGMOMyJvR0hG55tNTco82erc/ddMHzBGLjUiEWQ0DykP/QRBA3ph8wB4+/x5
         u2x3bA5SwZ9e+nCT/nM1RGq8an3IzxZiGDbh/BTc9yV9tqug36qwyElyU/L6dkXMa1mm
         fQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXDtrmzJbVdxRlGA2W6LgT8zvNRJeiQ4CwkRu7xK4sLn92acGkF0ZVWBNyAjykZrBH0R8EeEyaFQCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUFLjcRF9ZsjS9bg49YTYMwWyvnNST0cHUa9R/C9NSUb7ytPt
	GgOicH6IqmQTSVHhB4CkzWPOaVIDO57iS7rOYYQd+tb86cKwn1oUlsNDWdVrX9oP6mH9k0dyfU4
	C4DBO
X-Gm-Gg: ASbGnctcVbVsV+NqyeZELemt1P+3dC6GalbBVGvtjxr0qBqx3c4yrQT3x/SvoNRz4Dr
	Hl7vf7Sc2IdURNkveUmHKDkEXJOwmgpJZCWPCN4+4P2CXdRT/NTt9QarH90/V6Cpbp7GX+9Yt6x
	XzRwdcl8HkUcNTWyTpJyLNPYnqDSEEuYXwjdkNLb1YBThgQKi1r7l5tUeU1+naWZMza5eGrd8aQ
	/CyxF2UDQb2zazqdPIVtzmU4AgmIiefbCc8eimhQrjSn92HbNLdF6Ml4CbdMq05MAJI/Qd+y+Yv
	i5fuPabDueK6XfvgnYz6kamEyj4pv/Ei9fL7YC+vWUQU0AqEDZIGUahuycIZliSGviAKOqte+CM
	nkyCHO66RUlSAIexKstkY4JjsA+efp4bX2b6QgXTB4w==
X-Google-Smtp-Source: AGHT+IGq1wGKdwnYSzSssFija0igOVoFcFHK5uQnnhvVamuCXHHO4tQf3m5ewNbhRJz8ytZhiAPuSw==
X-Received: by 2002:a17:907:3d86:b0:b04:85bc:a90c with SMTP id a640c23a62f3a-b1bbc544ff0mr432943166b.48.1758142112954;
        Wed, 17 Sep 2025 13:48:32 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe890cbsm42545766b.53.2025.09.17.13.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:32 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 1/9] NFSv4/flexfiles: Remove cred local variable dependency
Date: Wed, 17 Sep 2025 20:48:19 +0000
Message-Id: <20250917204827.495253-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917204827.495253-1-jcurley@purestorage.com>
References: <20250917204827.495253-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No-op preparation change to remove dependency on cred local
variable. Subsequent striping diff has a cred per stripe so this local
variable can't be trusted to be the same.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 4bea008dbebd..a437d20ebcdf 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -532,10 +532,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (mirror != fls->mirror_array[i]) {
 			/* swap cred ptrs so free_mirror will clean up old */
 			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->ro_cred, cred);
+				cred = xchg(&mirror->ro_cred, fls->mirror_array[i]->ro_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
 			} else {
-				cred = xchg(&mirror->rw_cred, cred);
+				cred = xchg(&mirror->rw_cred, fls->mirror_array[i]->rw_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
-- 
2.34.1


