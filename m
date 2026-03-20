Return-Path: <linux-nfs+bounces-20299-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J00LcSOvWnY+wIAu9opvQ
	(envelope-from <linux-nfs+bounces-20299-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:15:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 541322DF407
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1649303BF6B
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A613E6DD3;
	Fri, 20 Mar 2026 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FclW1RY1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0B3E5EF2
	for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030256; cv=none; b=iiBwq3zn77HsrZCHQBXuzQ/y8j9GBvWrvETAEyPSZOR9Vlk3H6QhlqCpY/OF3+9peOHAaDJ+W/BNTh0ESgyXugCO7NrIoFSGO0d3oSTm0o4bYt9wDVcx0FU4o6HrVUPVAqIOndT05HkRe09GZcG0akqe9vbvFnoMwDC0105VTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030256; c=relaxed/simple;
	bh=sZ044YpPu4R5dXrNGbenZJqvSeauBzwp0RnljpfXqow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQHQe4+CLuNp/uZZXgPwlYaqxQN4e+SvwUx8Nzrf+R8iVWufWVmdal60YxeHnKev4waBXFO5sqfSQ4hpcCVeRpeNwzF1TYJx/pK6MjUXVOuNlq9ljzF7Mf/3LXugyRfky2XDhawLwoN/h75GuRv3aLSC/1LKW2BdNGi48IHhuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FclW1RY1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35ba749f441so2096514a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030253; x=1774635053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISn/U3wnVX56vQY00IkkHQXLUWsuK0LhCSEUHY06MyE=;
        b=FclW1RY1IzKS2ohmjktg7a8TUhDqAQ3MwXtYQEzHo+PRzCm2NMXAI7Y93jT/IefNNp
         xXyRhb4+H0nW5fLbpxzM7YJ5W/7sCRaE7cZT/lvII+tdAvgAA9OauYGWUfFK7lWKvhd7
         L0qCNnLPk7co8nyMS7pyRAiu7F2pC4RsUflsAF+L1DrFSMu3HcCbODwlnB06R+McNjM1
         G4B//ZUPZKSrIvHIjj3PgyHaMSZ5UfaTDkR2hjdhWHtVHDjDunZ126urTbJKD6CJkKI9
         YqbhOrr43jpRlbx0ici5iu+kVyDkA+sKXqV4LPYP+f50Sb8qN+Su5qIhn7vef41UETvc
         n9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030253; x=1774635053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISn/U3wnVX56vQY00IkkHQXLUWsuK0LhCSEUHY06MyE=;
        b=AMk7UJVbuUN8ZXA9+rob9EDA9LxM2WBVvhyt0o96zuY0bOMrFfARM8V7QPHSYynXB/
         y0Z8vOkRnYzQm+3WRSzjcwowAE8IawEWWUzEVJS/EjS9nUfdid0szimYeBa/fSEWqPeD
         ndZtFhNP0tUt7JV66CGbxvsiJiBWlavgfmAZYud+qG4M64WQTjB3z/SwUm7S2/RyUb1H
         teWkVAR6lkKXXuWZqR8XaanOebCdUfPz7SAaHujibiF16aPox1trHBMeFCnwIAf2HHbU
         u+C7hGXI7450uL481Cieqz5KvpZGb6GTm/i+S2W7FSMVXXihO32/O9I7uuXYjLZY5HxW
         XEPA==
X-Forwarded-Encrypted: i=1; AJvYcCUgEADfbSTX48N3Kz8Mn6lmuTX4ovGAXKUYf57pJhPrvKPKvSZOyuKHFAifUOCaz7prX9peNeboZAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAdg8kMyLtnEbsPWPxOZGHrHFKjMUsCyZnyDR+rJs/DzxfI2L
	QyX7M+6JxJ0m6oEbVyW8VJl4J0RfWy2OXfXN2L3RZ6nbYhNz0LZP+T6Z
X-Gm-Gg: ATEYQzziAkYeU9dbSV+32eTLNltNbD7WWNU+p5Y7WOfJRNIEp9flB0o67sGjOYUYxBb
	skj6AZS76ssmzwOo/wgHGJdou9UsdZXSNlzmd9bB7Hwj3xB1XQd5lQ9XiM59Lzd2exd5CI27YYH
	k0aqiOefjr7EfKQNZjC2ifYBqd0fIsgijTGSrR6/CJYNgf1tuhOsR+BIkCMmQ7S15fz5mQbnYJI
	TLFDo7ThgTbMZrlBBxPv9p/hP4QOsxqxRfE5r57ljW3Jk+PPrcYqRDNM8tgY9zMd7oOodVgt8Tv
	8Jd2IYdYpMa/NXwRqAPEw0/FKpWAET5LDy3frxREuHkc1NJQj8ZSKg8qwP1AX/0Vc7ev+XXF26P
	yTql0WSgtAUEZZpZmfiiZJ+QRU00J0lgWOMpEBBneBfcb9D2ScM0sE+Q+cB8Yk6jqYzVJEs8WvE
	EgIlXr9TY0hyrH0nXsIM9Rr5lpeZfr/H16am8vhXHjFkYMy2V709GtiogWjFs5ImSGpts8rAU=
X-Received: by 2002:a17:90b:2d8d:b0:359:fd9a:c506 with SMTP id 98e67ed59e1d1-35bd2d31502mr3244103a91.29.1774030252740;
        Fri, 20 Mar 2026 11:10:52 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:51 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 4/5] nfs: refactor nfs_errorf macros and remove unused ones
Date: Sat, 21 Mar 2026 02:09:54 +0800
Message-Id: <20260320180955.150696-5-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320180955.150696-1-seanwascoding@gmail.com>
References: <20260320180955.150696-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20299-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.780];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 541322DF407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
pattern for safer macro expansion and kernel style compliance.

additionally, remove nfs_warnf() and nfs_fwarnf() as git grep
confirms they have no callers in the current tree.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp@intel.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/internal.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 63e09dfc27a8..59ab43542390 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -161,13 +161,19 @@ enum nfs_lock_status {
 	NFS_LOCK_NOLOCK		= 2,
 };
 
-#define nfs_errorf(fc, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_ferrorf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
+#define nfs_errorf(fc, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dprintk(fmt "\n", ## __VA_ARGS__); \
+} while (0)
+
+#define nfs_ferrorf(fc, fac, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dfprintk(fac, fmt "\n", ## __VA_ARGS__); \
+} while (0)
 
 #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?		\
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
@@ -177,14 +183,6 @@ enum nfs_lock_status {
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
 	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
 
-#define nfs_warnf(fc, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_fwarnf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
-
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
-- 
2.34.1


