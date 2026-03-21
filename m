Return-Path: <linux-nfs+bounces-20308-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKt6LTeovmmJVwMAu9opvQ
	(envelope-from <linux-nfs+bounces-20308-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:16:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A17052E5B98
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C10CF300AB12
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968C2F6900;
	Sat, 21 Mar 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp+ztG+F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2F36F42C
	for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102554; cv=none; b=M/x5KawQgxtnApzb0uBkOycg047mW+j56L81fif54NE4hy3xr2lC1FZ3iYwNUr8CdoNuHhZEoi9HchAVS75CXr9XcSowezjm6kN4jAqJhsvFT9HRh6ejj2v1ZBoTvwvjrtHJh9K7KZZPGAQ7NgpYR5GHnrhizWoJY9Ydz/EghKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102554; c=relaxed/simple;
	bh=S/UgzQXA3QLqhdcPFe6v/HB9WUgH0Mn6KE3pVNm35Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KidI0lqAQzePlKqFs1Ax7AlLrWS/8IrnDEUWPLN5udIhKXsU+DTluNj9AiP9U4jAml/drhWvksZUKeA5XBPGvZiPFHn24mp0L9F+5RhOl/mXZWprOpgt6v2IeFfBXXtZnZ9NaNK7YqA0Rlvt9icB2lhLXs68yf9tqTkRO89qFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp+ztG+F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b05fd1d147so12244085ad.2
        for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102538; x=1774707338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrbOXEwKxG45bbWSYaSRrFiYiD3hpjnUzEitvzAGFtw=;
        b=kp+ztG+FGkm/U2PLlnzBzA+Gg23QetfBREDEvyWPHjQVIdP7gGZfovMdR1w4gYadww
         6GssXfbQqOOpNarqcr5dWzvU/R3U84n7D5h2SGEvY7x/M81DZL2f5xjgGX1YVpb1lIsQ
         X3JEgvdX7V2jzHhNY3T3nwuSvGaaCo/enImymenBTQ4eBtAbewSLrJ6AQH44oSc3Avaa
         T2XT6nxMaGDi8eG51rgswh3XSGBMrmhVsXEszzACIJioSo97tu5pypm3vQaF7+/j68Jm
         T4krEjr5Eu3/AWOwvVrCqsT5HpxzD8/7K8b2xRL8PNZmBjo9Oa9UH3nPBLKbUmqrPjRe
         6/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102538; x=1774707338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrbOXEwKxG45bbWSYaSRrFiYiD3hpjnUzEitvzAGFtw=;
        b=KbhNMdtyCDpqJVQgI2nPVIlDjQtq5odjKHxrBy+uBdaM3kXJSGUEJgs7t0EktR1Jkj
         eOYhObsp7tLaYLcOqQ4MnjuoqU5381+2CLgx67y5e5ypTpYUl0njZLFr9PjK+85lep7+
         GkANTS6pyaon41ntde9zea8oVrE9W8ew8ghqMf/cgR0KGYX4HK61CjhaCipa2fE9ij7a
         AgWNt4hT3TQcodnznXt4q8s0Kc7zJI/X9a+PScnnZDTzVYmTfj8DYNn33rTIQUHJRsjl
         LMrUZm8NbkC1LKajWyl+qj+/9Odu0iDqdcHrfs4Yq7oVsqQfDwosbHjehbPnNNPNeAMq
         hDcA==
X-Forwarded-Encrypted: i=1; AJvYcCUI97TI3nldeyVPG5laqh2KM5Zouh8qD3Q+jcXumjBMuTAJSlS0eL4l4Ma3jXtgiBc8mL3I8XMBTtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBrBW7eHFZwh1J+w5EoWbrNk3nHwQRUs/bgrSUjh/qEQnNGfw
	kba2b4gpGEqbfRvkS9Ged4kjG0yeu0WdnFTtQqkEn3bUeHuj4Yny2o9i
X-Gm-Gg: ATEYQzylAGZUAhLMdZDcz5pH3+o5V9MqtEPGkQB93I3lYCmbbvLxSo9fk4W85ZHx6Yf
	7UxY0jPHxzpwSX73EszeD1PeuRSiMudRgHMAgbLIdQHI++8WDWqcI28YQcJBSgg5ZiDVrhgH/FV
	Whfb9zmomVwbn8OCKMv50eZ7YT8KgMNwlSVUBE4pjV4caOxDGAUwU9240FLBspif6Go4bHUsWU8
	kFV/ERHCg9kfgZ9NE/664T2TVHHjuk7dzHexGC/BDSD1E3xiQ67M7Ltrri/1uzoSo6Dp2Lzwl+L
	zFVBwWuJjtH3c777CC33Ci48PE+1C4c9xWiB3/q07rhvtM7suHdr/bYgZ/sja8w0nekdUtZV+uI
	poYBeTJFZvJZBhGzLMrJYfEduXdY6XkCaZe6ZZteS38UC00lyx4ZHr1pCAprKGN/acAFRf24jrS
	J5TBMHPIuh95mJj+YLkjQI17dtvbytG4DwDYSi4h3/JO7rtYE+a6hwgca4/lf+PQBTFItrS2k=
X-Received: by 2002:a17:903:2310:b0:2ae:572a:9f19 with SMTP id d9443c01a7336-2b0826fc627mr61129765ad.21.1774102537729;
        Sat, 21 Mar 2026 07:15:37 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:37 -0700 (PDT)
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
Subject: [PATCH v5 4/5] nfs: Refactor nfs_errorf macros and remove unused ones
Date: Sat, 21 Mar 2026 22:15:09 +0800
Message-Id: <20260321141510.68214-5-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321141510.68214-1-seanwascoding@gmail.com>
References: <20260321141510.68214-1-seanwascoding@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20308-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A17052E5B98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
pattern for safer macro expansion and kernel style compliance.

Additionally, remove nfs_warnf() and nfs_fwarnf() as `git grep`
confirms they have no callers in the current tree. Furthermore,
these functions have remained unused since the introduction in
commit ce8866f0913f ("NFS: Attach supplementary error information
to fs_context.").

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


