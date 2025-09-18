Return-Path: <linux-nfs+bounces-14557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A09BB84DF3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE1A7BFE9D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA02628C;
	Thu, 18 Sep 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MyfZiwFU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629B2D3752
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202400; cv=none; b=Aaq0Uzh6c0A8Eqp1mh9PCrjJJFFlWkeGm4eijgjWPz/N5IuE7haX3+R3sMNRltaenWPTYpJXnSn0BJH8Z+fcDAi4qAzm9IYEg/9KshlCjp9cCM0aDdUmRjXaxGoXTSCeEr3gJ6qMLOWHwYr6+rD5rBLw2/dvXh8qo+4JJM5vkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202400; c=relaxed/simple;
	bh=1xeGAreEi2x2Aquc/6dLVE/3TMfMr/uLa0az8bFjmD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqDmmgl9TA7cPSVYKL2I1yTzq63wMaUy/5GT1fdp6mJXFAIL8hSbZxVNuMaGbYy3wb2UlrMgxa274Awd5cGU+ewhFrYygjM8Q1vq4uCxgVeyq68BjgnkX+C0MOP0Okxgy7O2tMrkTCCD0Vh5yDV5I4yF2jXwGoA++d2pAfiXR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MyfZiwFU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f4273a404so3993468a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202397; x=1758807197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=MyfZiwFUm1wFE01V4YnfDBk776nkvAtjh8NZEQRv5qIUr/Y2Lfsc8d36mWFPmzJGaW
         Ux29+vUiSQ+Jvhrm7M5ZIzIhCzYzSeevOoaNO0eo6Oxc2IZYi8iuBKRRdsb+n+hAQSHJ
         NxD3bE4NgWPkr0bQVqvtxm2ztKtNiM0Kr+1BS22Cm++8rztvDIQX9aMjaKXRJJtCU9/r
         xkZ3jYlDZ+i1UWDfLw74IAQtl1CUVP52+w2X0zG9EVKbJoa0QS/7FQBfFBW92Ee6qkz/
         0Zaa07rTCiPJWP3VZa3+Z6EE6u9V4BfdmMS5i0T4vSd47BNNR9gT9xjUWU5DcdFEE8tj
         22SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202397; x=1758807197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=kqcgYBlD6io+tbPHFNhU+sFB5FRaDY85NqGiiMZ7roOTNvn8nNkWABKBQ4/zH9rhEG
         KzsYM13814TrpvK9qSFuR7voj1X7DGNEqcc6aw51tB1sE2flpKkMs+YLH2wc4LxBS8dZ
         EzEKht977gZC1awD+Zg8YjRsMwoVML39Cq0jwvQu3LKCnZ5l1Al4alBpL0uNbMpM05Mq
         gBq/uQ8UwpSyQB8UMeN4/Mbqnb+8Gq0id6vAg0jSZou2hhz3xgTq3XcoB6/ZKxevpz95
         hLYTl5VGfMdsgaYssTrozJfT17ks6gKV5hRwQsZY7hvitVp3DsWnWDPXGlV9F4R7hzWP
         IFZw==
X-Forwarded-Encrypted: i=1; AJvYcCVqzaON42aMXp7M7boRsQGH4eDerYiato2oX6WXt7XGi7LCziPSmL02d1vBgwOlIHocnQEMvzsNQWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WbYJ6W9uenDbM+Wra+WfJuEcv4QXBYNAKlNWV+zKyvguEn9I
	wyxHcUq/wqOXoGh3I69MiiXZNK/J0PbMsYIed32FOuCp/69/HhtdqC3soxO9knvtL1Q=
X-Gm-Gg: ASbGncvOBP4Wyj+YAsyNsls7StWAFicwjDIAVsOrAaLRhxGqNmCYma3tAMMuvOnGaLF
	emo1ZzTRTCZvxeNeDZ4nF7AlZZFMa87IAjQdJCGug8BcJWS2aYZ1apSXTTpCrBMIEuFM+R48BRp
	x2A89VF/55B+mm3DTeHbLgp3I95D9MvvnudkuCBL4SnD2XCLDLCYyZtm0sbgXC8dh0+O6DwWCGM
	1gmJ+TUrwfMKtIcse0vS0L6ZcXT5IugHuFZeFKMwwSqidem1r4rke+ctHWAxblMDw+rZCvoo+a0
	oRxm4dJ4CEW/wZJQ++pzEodYRPwQT0BISXGlTlxV5BwQJS179WuqZDDpbSIwD0bf4pzY9APrZW/
	ChLbIcstADW7SynN/YIm1LFslbgmTTpjZz7rxtEQyzQ==
X-Google-Smtp-Source: AGHT+IHapcjnJqZQEJ5zgf2QPkBkjhfVjVzdsPt8O5L2ufRNc5AZ452E4Q9Qc9jP/0b8uz6LTTVbkQ==
X-Received: by 2002:a17:907:d02:b0:b11:ce93:4388 with SMTP id a640c23a62f3a-b1facbb6f98mr357559766b.25.1758202396604;
        Thu, 18 Sep 2025 06:33:16 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc5f382b0sm203700366b.2.2025.09.18.06.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:16 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 1/9] NFSv4/flexfiles: Remove cred local variable dependency
Date: Thu, 18 Sep 2025 13:33:02 +0000
Message-Id: <20250918133310.508943-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918133310.508943-1-jcurley@purestorage.com>
References: <20250918133310.508943-1-jcurley@purestorage.com>
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


