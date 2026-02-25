Return-Path: <linux-nfs+bounces-19231-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Mm/LqBvnmkvVQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19231-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 04:42:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1466F191401
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 04:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1AC330F832B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 03:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE502BE64F;
	Wed, 25 Feb 2026 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xek8m1Xp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AD239086
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990744; cv=none; b=sYwgvSLHjj5XCnZGzCOup21PCqakzvdGidMKuHUUcwuVfVSf7FER4VZYZMVimOC3gEtqgXok62jYUGaJ8o3o2c/SUq8TQZKMkecDT1dfZxOdvceLZBYBhnJOTXsqkEBDh2zfTGg7dOIdrNpjeiexe8c6lz27L8su0ZoXCXAjyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990744; c=relaxed/simple;
	bh=DIh8WtJKsYfFWmCLOMLa1uDVR3z6AtCB+KFcTxnsk9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2MwDBB1h3mC7jB8LxrcfI5Wv3s4AqPzdk7eBmrxj2naZe0yP4yORdxL49OePNtCYRt+jNL8h9UcuKs40OrFt0HEAELVzWYpACtSQqrX0o1sjR+PzsbrSIgBY0Fq/T+pjSqanvUp7rZ6VL72Uvs7Zh40pE/uZTj4m2LFHCCt2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xek8m1Xp; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-358f5aeb46eso436439a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990743; x=1772595543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbcH8R6MMRau4mrpEGGDZ1QNTvGTHu8f4PpAUvn8HKw=;
        b=Xek8m1XppizUUVgCLQ7ndGRly2a4A+0NvpyAiEUP0jKd2p4e8SvlLBHvlN68rq0HV5
         MnImVMdnCIZeM6AMSxi/HJ6Y1ZnCn7sW4X9vdhKdVCDGg8JNVBu5TqXjv/bJw7gg24i3
         wr0nIo4i2oSe2h3PBUfAyhqaOW8WUxnhfQpZtU0NHDN1zD2cDWGcMTS8dHleRO+1vEkR
         HFgBnJ5jFnozgWW78SHAeNOT/BZ77yTd1fhn0zcDtu42Lik5uSC4E/8RRumoO6K9+Y8W
         Fze2ffi0UoPftnSqwExjS0Q0qPtDHtLM7tHI8EZDWCECs17I/R8vSNRQZhp9HPmhaGxp
         Zs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990743; x=1772595543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbcH8R6MMRau4mrpEGGDZ1QNTvGTHu8f4PpAUvn8HKw=;
        b=I+CzY6u7lj3auOB/8b1VaqI/HHWEVv+WJJJDdpt/JBUXCHeVXDDgvLIeFU8JPbVvIv
         V++wPm5E1HDgyn6tAHc0hN4vJuv97vDHxWwO/EDN+dbRrX7VtQmP8yWoPJFOdv2GnjXn
         /kHvklFwpIr8IIbCmd/gpzNMIp7JbJBQtPltQXEhe8nU2/kmkxJZhkokj7L8vjFIYU81
         SNMaMTukjRO5lz19NprHtWRNUlt01RTcWtNFg9u0md1ps4LPo2qDTDYPiORWvJYKP8R/
         lI2d+Rx6xdy6PraDS4R/Cj31t8ZjPdlDpqmjKdbBYviHGnqDokUxxmd2CDyqDAF1RqcL
         VcVA==
X-Forwarded-Encrypted: i=1; AJvYcCX3x1TIpzcctBybZ5bQIZ3RrZ95Veo7f1Bht6alncV2WiTzNcPeKU4+l+YMJFMRtRAXE9KlRiTc1oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWoudzAU7ttLt41zoqSkozBufSrXSjTV/qRq2qH36cLyfp9mV
	p9xrbnDXKxDSXJUA38LiIwc9hRNwygLbmFiNQLlytqFLFPlLK1AdlUjc
X-Gm-Gg: ATEYQzwYOGmT3Q80oZiHwu1v13RXIbMlwuQJ4cYU+qaizLlDABIZ82ExGj0JE858jL/
	Z62MyO9A095j2hWgr4vVxKmmiDv+wTM4pUFJYFZTZd4aWGfBJaNPlLZP7HqRVG1RnaVUgLn+Fxi
	0H787Vm49nFBOTSLz0uPF9klocKnUHzDTETSiMqfLfGE7fvEDSU7IawyCyy31WN/q6v6SC24z3F
	g8C6yNpinLMf4Y0Qn+Zisz1Vg2aRVuIHWRBtPRo/HaKsKFFTwM0hfLnX5smUiEIAvWQcISUDvmi
	4WCANxO4aP27pXtB6A+J24A6+mr7ulb0dLmqy41TystNjCyzM1AeJz3/x/EK9X+D5nUKMOFBDaK
	zO+pLzhYWV1kh3aMx85LKskXrmFwdGeoE9NIZ3zA/G5waA2ZQVg1FK5q1R8IC3ax07q3WhAvuLW
	/dHHERhXVtja1HPnPlWtSxIul7DQHdCDdMajgbd5t84mBDKgw4QNRaCJ9P5Pd5PtCsiYWFqQ==
X-Received: by 2002:a17:90b:3f90:b0:359:7eb:d922 with SMTP id 98e67ed59e1d1-3590f226ddcmr865260a91.30.1771990742896;
        Tue, 24 Feb 2026 19:39:02 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:39:02 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 4/4] sunrpc: sysctl: replace simple_strtol with kstrtouint
Date: Wed, 25 Feb 2026 11:38:40 +0800
Message-ID: <20260225033840.33000-5-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=ericterminal@gmail.com; h=from:subject; bh=VO5IMzOC4K3hwnb1MwA7obneQq8hnuATlXNUArothF8=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5NnFy7tzFYvrrwYZrvs0uTl0WyZgj17bh7bWXj9H ktUtqdnRykLgxgXg6yYIsvd//vm5nrdmnOd+3AuzBxWJpAhDFycAjCRB7cYGfYkbQsNc83T5D7V EcAdsUvkgG9N148DEm3V4R0XV915FMTwz9S6piw0ccG+fidP1kyRFuYGXW3ZZ3eK5hY4sX5+P2c LKwA=
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,kernel.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19231-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1466F191401
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

Use kstrtouint() in proc_dodebug() after trimming trailing
whitespace. This keeps accepted whitespace behavior while enforcing
full-token parsing with standard errno returns.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/sunrpc/sysctl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index bdb587a72..07072218b 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/ctype.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/sysctl.h>
 #include <linux/module.h>
 
@@ -65,10 +66,11 @@ static int
 proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *lenp,
 	     loff_t *ppos)
 {
-	char		tmpbuf[20], *s = NULL;
+	char		tmpbuf[20];
 	char *p;
 	unsigned int	value;
 	size_t		left, len;
+	int		ret;
 
 	if ((*ppos && !write) || !*lenp) {
 		*lenp = 0;
@@ -89,19 +91,17 @@ proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *len
 		if (left > sizeof(tmpbuf) - 1)
 			return -EINVAL;
 		memcpy(tmpbuf, p, left);
+
+		while (left && isspace(tmpbuf[left - 1]))
+			left--;
 		tmpbuf[left] = '\0';
+		if (!tmpbuf[0])
+			goto done;
 
-		value = simple_strtol(tmpbuf, &s, 0);
-		if (s) {
-			left -= (s - tmpbuf);
-			if (left && !isspace(*s))
-				return -EINVAL;
-			while (left && isspace(*s)) {
-				left--;
-				s++;
-			}
-		} else
-			left = 0;
+		ret = kstrtouint(tmpbuf, 0, &value);
+		if (ret)
+			return ret;
+		left = 0;
 		*(unsigned int *) table->data = value;
 		/* Display the RPC tasks on writing to rpc_debug */
 		if (strcmp(table->procname, "rpc_debug") == 0)
-- 
2.47.3


