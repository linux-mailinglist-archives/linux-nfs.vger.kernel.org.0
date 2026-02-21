Return-Path: <linux-nfs+bounces-19074-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BaKCuHImWm/WgMAu9opvQ
	(envelope-from <linux-nfs+bounces-19074-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 16:01:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5616D1AC
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A20301A3B9
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B0D1EEA5F;
	Sat, 21 Feb 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk2tUUGw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB41C5D77
	for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686043; cv=none; b=QIp+KRalwqSewkpGrPgKtO6TinC4QTWXJBYlcmrqYyc/fkNhyaOSLRmYAvcX1M0HDA+C9nIlBbQJNY+FjkdOS1EYPRqfvACDwckRHlN0nJGrbsDuHjqF9TcOLi7TxJfvqiWsgBgkeu40jihJow7fKNJaJ42iwGn+zmJvbxdiNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686043; c=relaxed/simple;
	bh=EKC+gjybz5QCo3/A2SoLkAdJ9dHzP8glwvLLU31BmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3QE5U2HQKUHiLHSYjyyv0h28CI20uAiujzwq7x5N/1g/IJXv/P8VSGl33nTPXH41tKGVU/ZEK1XEbPFQ3bzlOzGgNbh8fRXmzlFTmcoAy7Cymu7CUjrPj6YbkpogJ+cU9LwFAcH9U0ZQgYaRg1JAJ8C0fyMXqslhehk5avfbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk2tUUGw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a871c8b171so18490845ad.3
        for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 07:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771686042; x=1772290842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=Kk2tUUGwvD9uGvq0ltLEbkA6gi0NU9z4MP00tht7MoU2o6bKhEQ6dueKkPeMGPqu3T
         r+i2gbnfgZqBNGm9kfrCE7+uSZaWCNdYObcf3IJCxMQxdP8lSS640twG57Zp/TxJBeCH
         eKkXO17an2qluj9ez+oUTd/Mjhb0d5rImThkDbDzR/Zh2No26sF43Q7+08D7P7ZgelBW
         ac9A19JzfVstuTVnX1ktYq+qhw9iN5VSre+latY9KomlTbH81/2Sw0Il9oIKwc5VdSJ3
         cykMuY6M7c07+TCRFacC4SoRR3WRJCkXs+Tao3xNxLET/B8qr42QlE2DCWV09ZTsAoLd
         g+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771686042; x=1772290842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=kPNEV7P0IMh3C+7AJQLQFE/uN+kk4NDbu4SL9Mr4yBxsMRZKtkED45udFxb+hoR778
         0FtSktMkKywCPg//FvA0J85t5qGtwtjBYcwsonAzxFVkES3D7o1LOw8XcOfDPcSA0lq6
         h5xvK/Ynk1CjQfyQNFopo1gzylul2++wyZ7XFqEz9tlIz5skn/QCAER6IsTxTf9YR6MD
         Rr69sh4pgHql1NcZLhDkZdyHaSz54Phh9zglpuNzutilYa03HPGljQwho/hrMwcL2MxY
         wpWgMDFthktzcdtPAdU5SgsRaRk+EpVpx86TXd/x8kYHuc7sIRwN+ApkHmVJJ4+rp/xi
         RViw==
X-Forwarded-Encrypted: i=1; AJvYcCU4HtsK2N2hXPc4yF8p+nbvHsAvOBlFbZBLD1z0wP8M05mgU7KlvM7qx79u+5BViPjpLByF1bTNaWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAPq6hM7FSJx+Lh8ycJwuXwNb00WGBNvVgOOnm8X65NbUTJXC
	11qz0cPKu0iEemfAO5Hoe5NpopNYCngyqrieV6wDpMnu/TthKgTA88CL
X-Gm-Gg: AZuq6aKH4g+PTgziY100FwjpMzXbBoymawESo9Ixrii1or13GVJv10SdstgrSH9ICai
	LRAcNJkylbNptJSCQbcbhXf4uHHOQqC+sUFN10pr57yvGZox8Ez9NJlHp8Biv0JylaQPFjon/YU
	UHCaYoL1koDK5pmi+yca4IVS/sTaq1XOhp4ry7QNtx80G4T5UcGj08bT9fUpNfcBLxW/KG9p9v6
	sSPU2I+F24azStIGJZBavm5wyQYdTueUFPRNBwQTJWRjr2UzxGxnfbBJBZCm2yvrA6zJchAbQ1Z
	h/WWRZSgse7SlohEFj07NX64uJF8riQsxCKfkWg+5/2xBiLW2jO3oOdXwmlvQ9Z6jCrv8wqkgpy
	WpsysWX1ZUjjgEBZjWHA/nrvfZd8cjMgt3Sx9T/X38iWlmTsKWjqDIXlpkfZyvb+ss60D2zUAp2
	d81LyI+t14Du3VfKnhLWohMPK4XtCXQ7Tb8BXRmK0Zudh89UpnvRIhVI8=
X-Received: by 2002:a17:902:ce90:b0:2a9:5b28:94c0 with SMTP id d9443c01a7336-2ad744e13bemr26077275ad.27.1771686041931;
        Sat, 21 Feb 2026 07:00:41 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.07.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:00:41 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 4/4] mips/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat, 21 Feb 2026 20:45:46 +0600
Message-ID: <20260221145915.81749-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19074-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2B5616D1AC
X-Rspamd-Action: no action

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/mips/include/uapi/asm/fcntl.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 0369a38e3d4f..6aa3f49df17e 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -11,15 +11,15 @@
 
 #include <asm/sgidefs.h>
 
-#define O_APPEND	0x0008
-#define O_DSYNC		0x0010	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x0080
-#define O_CREAT		0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
-#define O_EXCL		0x0400	/* not fcntl */
-#define O_NOCTTY	0x0800	/* not fcntl */
-#define FASYNC		0x1000	/* fcntl, for BSD compatibility */
-#define O_LARGEFILE	0x2000	/* allow large file opens */
+#define O_APPEND	0000010
+#define O_DSYNC		0000020	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000200
+#define O_CREAT		0000400	/* not fcntl */
+#define O_TRUNC		0001000	/* not fcntl */
+#define O_EXCL		0002000	/* not fcntl */
+#define O_NOCTTY	0004000	/* not fcntl */
+#define FASYNC		0010000	/* fcntl, for BSD compatibility */
+#define O_LARGEFILE	0020000	/* allow large file opens */
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -33,9 +33,9 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x4000
+#define __O_SYNC	0040000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_DIRECT	0x8000	/* direct disk access hint */
+#define O_DIRECT	0100000	/* direct disk access hint */
 
 #define F_GETLK		14
 #define F_SETLK		6
-- 
2.53.0


