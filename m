Return-Path: <linux-nfs+bounces-813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E281EA28
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Dec 2023 22:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618B51F218EF
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Dec 2023 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B314C8B;
	Tue, 26 Dec 2023 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1Z1zK91"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECB4C87
	for <linux-nfs@vger.kernel.org>; Tue, 26 Dec 2023 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c6bd30ee89so4885689a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 26 Dec 2023 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703625842; x=1704230642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gXj6atQGa3CCXZ7MV893XWtrEK6g8JaSv1wnUBmQOBc=;
        b=m1Z1zK911GMeGcVJbd9zKvLLb24EK2oiOyY5NCbLZL1wjlbXVp76Z1KeQO89ujLkI4
         aGxfEWEZVci4QYjDmaxL91N2gTOJx5zrvTgheIlDnyY46EP3c76oEqG6b5uMVEwM2+ZR
         hdTtrnBxp4p38sVy97EjsmWLycav21pnbKwfUqxOR7G7JiUrXBtXSKPyMiq3iv3IOTSH
         odP0P3NukARfj7XAh/fFsEPaGJUHOLxPTFd+H7FgRq3KpYrLeFYDSe2nip98YjuuhKf2
         9ZjdXVPFzAiTU0EPKd7tHCV0D5ifQe2hd+s3+S9MbOlJR5lNQ5xKO9LtsGWWN28k1xyK
         PREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703625842; x=1704230642;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXj6atQGa3CCXZ7MV893XWtrEK6g8JaSv1wnUBmQOBc=;
        b=O5eODOuMwFyeQFVOSIDi7ujNSYqXYqzK2z+dZoDiltNu83X/Q7YxuPmCYSjzyDmvqr
         Zov9zBy8xAKJtti/dkGYDtituKAWom1KeFaig+JJviDpkBdy3Hd5g0Laf2551bdnqIgz
         fZRSJVoLUa1IzOLWOcXxjHCUfhtxyjJkE28vAXYpCpq7f8RA4KtX05QjBkmTfr63P0A/
         kWS/7EVukmtc3UMjK/rHDdNt+JSgoRCfL8yztR/SY9giywnV1llH4rctSq0zW/v0z4Ig
         kRf8iFBvjvSdr4qOuQZRH3sNQouVBn8gY0Vncb7BP4EbSkEA5+24Ptggm0mkijxAsEmn
         xiYA==
X-Gm-Message-State: AOJu0YzMyIewXVlR4RQiBBIV1HSzLkn8xB8+3Sw+/V9nHkDxcbFARvy6
	F+wq0gDt0vnvZ+3oh5glpbdkPjVkPLoJWjQ7mlA=
X-Google-Smtp-Source: AGHT+IGBCxn5ae9LfInMHUxvtWkVHyvBSOr4MiUqi0DzSWtBhk/a3C6l4mIoBZGNBdE4zEhBW+c1kg9Z/F7o
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a65:64c4:0:b0:5ca:44c0:4a5 with SMTP id
 t4-20020a6564c4000000b005ca44c004a5mr66269pgv.4.1703625842439; Tue, 26 Dec
 2023 13:24:02 -0800 (PST)
Date: Tue, 26 Dec 2023 21:23:55 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGpEi2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyMz3bLUoqRiXWMDCwMDM2PDFOM0QyWg2oKi1LTMCrA50bG1tQCUXI6 LVwAAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703625841; l=853;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=It8Le0eVbcjK1msrpkzQZ4fWEk4P7H+dOJKoReyil1U=; b=SrIMkp54bIj88ln2kxZ9sU0wHEdOeIrfTs84FnqQgcoNG7jkAr/RkSjv/ARlLBNI5DPufPm7p
 hhXOMa9NKajCQ81gFqLAfzg88hnE9eagm7lyq+nshD0ropGP7QNIoXC
X-Mailer: b4 0.12.4
Message-ID: <20231226-verbs-v1-1-3a2cecf11afd@google.com>
Subject: [PATCH] xprtrdma: removed unnecessary headers from verbs.c
From: Tanzir Hasan <tanzirh@google.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

asm-generic/barrier.h and asm/bitops.h are already brought into the
header and the file can still be built with their removal.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 net/sunrpc/xprtrdma/verbs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 28c0771c4e8c..5436560dda85 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -55,9 +55,6 @@
 #include <linux/sunrpc/svc_rdma.h>
 #include <linux/log2.h>
 
-#include <asm-generic/barrier.h>
-#include <asm/bitops.h>
-
 #include <rdma/ib_cm.h>
 
 #include "xprt_rdma.h"

---
base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
change-id: 20231226-verbs-30800631d3f1

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


