Return-Path: <linux-nfs+bounces-20495-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBZYIdIOyGl+ggUAu9opvQ
	(envelope-from <linux-nfs+bounces-20495-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:24:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A134F4C1
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D861301BEC5
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99D3A4F3E;
	Sat, 28 Mar 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUHC39t5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ACD345751
	for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718666; cv=none; b=duWMK7QSV+GCj/F4xqWjeLmazXuaiBfIWZBjta7LFJS9BUh5nkoPa0hmcgaxlC2bGJ0w35VPb4b154nX+pzXJqseRxU7mzDdGibvEXe7Id5mUr7mThRgbbRlXPzFqEi0ato/LzyJEZdIkqaxg85JulbZGY99P5cQMZTJngfcTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718666; c=relaxed/simple;
	bh=Q9dm8LTnk+DFIEJAAB7tpFWixf8EizWYmak8EK7I1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKlpF8USs/JjgGEcqvnZXEIqUiBj3lJcW1fZ8XjbgUUogvQ6pIZfaJ1okv2b+9Rq1PZ3BzmNSnr1rWYcWgkXOsLA+r60BZAwEWgI6KoHuk/0h+21mvbfdOHwWCT7QchZs2e7SwfRHnckzNxHLXjkTbJ20ktOELGWqWJaJxsYaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUHC39t5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so27295a91.2
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718665; x=1775323465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=fUHC39t5SVFYPhzjdVkydSn6kkxLe/mQ3HnNYH/M5q3wq6Eoem2pwd7OqgnlJpwO+I
         p/mg53wMg9CJ2i8ZMMAWJuGt9mbPfa3mspXRaSxC7dEBgKRsM5EWJW1Umw8805nuLH1x
         kUvZWoYQ7QEleQ9S6i5L/U2m47KXH+m2Ld9THKApeMdTTV1A6THnMVIXevNDPgCzaPMv
         rBj672km8OsufCBY/xztP1co6wDvqD15FyUDMEPp15Xz5cnxylowDbInB/mSxjDP5kiT
         RgAHkTDt2k9W+GGrPwix3NpyxqfQaRE2k9rmYWyaNIBMT0YIRSDvd+t3q7qICRlLSVQO
         IPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718665; x=1775323465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=ba7HqOfzHe/VNBwxQAMmgE0wt4wNYKCSGRICiOpa6a4OVWCK9BQ2EKKkFfzq+bXOFP
         p65vIEyO1jCOGiz+PvbQP0P6eOFzlsJ7GcXiZcrwyIfEyOAwhputULcwEvwlgoC36fhK
         mMdVtbUXNpxU1T/16Jnmr/IqzKmn3bF69sWA0keW2NGloqbjJ21QUeB4BtiyGdPrvark
         Bj17EhCRHGJLjrTUGiB7/MbzbnMSWEAWSqXZpXaXVhcJFR6PpR6DeLpyWvYGZyZHQLWI
         Wgxzz64XoyNeL6vt2pgmabW4hSTPtrmB3Rv/TZ4N6veuG7esOscPGHkSJfyYGvuht/U+
         bGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZCTGr51FoqD6MSbyQfqGMvYqS6LBkRWaSXZk/EPJC1fnjarBQw1AmPudOOMWyqVWhyF8BdKZVFmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUOi9BTEZq8hTjZLoy21bRBI6aKiCSkpAKIyT3VYZDxMxD2Vn
	71slRxEA3XM/Ix96BS8EhlsqLdw+SXU0H2OAGpvL4+fqENv2Urr5esPs
X-Gm-Gg: ATEYQzy6NTtX0d/9LYE5hIMy0EHBEuoxRAktU92YNqInVEtVxomtx/12aKw3/iusXo7
	bgHYgqcaGdfdXHI08Fq2yLGHR9i2vggX98YEGu1rcOHRPStAi+gLRrWvi3ckgKoAjZ7W/UQhJ6z
	w+yE1ckKdfcjtHZKyARYKt763xE9Q9ECwRdH9zqgaZ3b4anYthuCA/K0BBqDUFiBZbzN9SX7az/
	Ol+Df6CoxRvo+kep9Ru9bFOJRgSLttjePX5Gs19pO3J2anKNiqGPwQbD3M7TZwI2Hj/eqB4VpIO
	Uj49OvAEe9lmcOlw56Eqa+86yn8vDWhHNOkEtbnEGnj9xnyDCZc23PnD9HoYsqH6rQc3ndYUSqG
	UxnxZhP7WJkLBXMOXSf96w1lKOdrHy3IU854riR9QzBNcWLT9dA54Hcvjokq4MT520cIYJf4IQH
	61qzYtznqDZJhiFpOCVrGFi5hNFdrBfs5H9DCnCzIt8F5t8ok9q54cyyo=
X-Received: by 2002:a17:90b:3ec6:b0:35b:9397:7073 with SMTP id 98e67ed59e1d1-35c30126798mr6566152a91.30.1774718664565;
        Sat, 28 Mar 2026 10:24:24 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:24:24 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat, 28 Mar 2026 23:22:24 +0600
Message-ID: <20260328172314.45807-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328172314.45807-1-dorjoychy111@gmail.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20495-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E81A134F4C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/sparc/include/uapi/asm/fcntl.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index bb6e9fa94bc9..33ce58ec57f6 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _SPARC_FCNTL_H
 #define _SPARC_FCNTL_H
 
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_DSYNC		0x2000	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x4000
+#define O_APPEND	0000000010
+#define FASYNC		0000000100	/* fcntl, for BSD compatibility */
+#define O_CREAT		0000001000	/* not fcntl */
+#define O_TRUNC		0000002000	/* not fcntl */
+#define O_EXCL		0000004000	/* not fcntl */
+#define O_DSYNC		0000020000	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000040000
 #if defined(__sparc__) && defined(__arch64__)
-#define O_NDELAY	0x0004
+#define O_NDELAY	0000000004
 #else
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
+#define O_NDELAY	(0000000004 | O_NONBLOCK)
 #endif
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
+#define O_NOCTTY	0000100000	/* not fcntl */
+#define O_LARGEFILE	0001000000
+#define O_DIRECT        0004000000 /* direct disk access hint */
+#define O_NOATIME	0010000000
+#define O_CLOEXEC	0020000000
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -32,12 +32,12 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x800000
+#define __O_SYNC	0040000000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		0x1000000
-#define __O_TMPFILE	0x2000000
-#define OPENAT2_REGULAR	0x4000000
+#define O_PATH		0100000000
+#define __O_TMPFILE	0200000000
+#define OPENAT2_REGULAR	0400000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
-- 
2.53.0


