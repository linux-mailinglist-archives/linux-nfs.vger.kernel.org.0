Return-Path: <linux-nfs+bounces-22991-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D5rHF/VBSWrszgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22991-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 19:25:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCF0708140
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 19:25:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XNYTcx6U;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22991-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22991-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9144301CDAA
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D435F60E;
	Sat,  4 Jul 2026 17:24:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D640376A01
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jul 2026 17:24:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185865; cv=none; b=hyhNWwaml640YT9eYxvznxV7xjIFqDaIDMUgK1xQeLIleAfST7XG0wykEgcJpIemhEKNYuQgrzpuKHPyPodzmq7g0oLLf1tTohs/xkKH1Bb2nGGNTbkzfIjOHyWLJU6/cqN60SOKkQibUl+/gVzBiz9tRqZAf9xX6y+kCqNlIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185865; c=relaxed/simple;
	bh=mLbu5NxpQGUaotQi8An6gHfrLO6XJVpNbJHvvs4xUDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUg+VfcFO5b1yQygkYBNRnP0lkYVFEXfVQY/QUa4S0hMcJKNyZv/oztMY33m/H+alEbchtXR2MIOp9fTB50BTeeKenLSN2nTwXEkpxyPiMxdt5h5Hp/RYQaissI1sff5LBEmBgJqBmZZ19hN+J+NDz30ZjhCSRh6TVOc6hcH8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNYTcx6U; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacd69a9c0so12245105ad.1
        for <linux-nfs@vger.kernel.org>; Sat, 04 Jul 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783185863; x=1783790663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DSnqMqiMbLJNwIDj4iLOM57cvPMuBmzdO+biTwlkGE=;
        b=XNYTcx6Ux0HfwCvXxwRDGFkETlz+0OFL/09WTdHla7bjncuPYablNrlV/JRbATypXi
         eYZxth7/gcv8XN5s03Dw41MBi9Zj2qUGnsdwloLA/a/j9hSAhaQ0sFPM/k9ox1P5wZb6
         X6gR1xpHX37fgjNTDoLFTwOguHmuQRa2jeXT2HA/k23JMNjR7j+SrY9tyPJbiO595OaD
         E3i5UmgHjBhp9mSdsoVepQ+jS1oH9ecfXWAfIwqEVbXQ3HtpC/KMeMIr1tB61DyqGz3M
         0rE+NlmA03pyVqNVEvHX35TEjri7jHh5P8cg3S4MI0iGclFvtsiFPa/TQTGL+BIr8yyT
         pIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783185863; x=1783790663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DSnqMqiMbLJNwIDj4iLOM57cvPMuBmzdO+biTwlkGE=;
        b=kHNZFkq1CK1eqY0gOtd/Wp/Qspo0cNEhgswH5F0gTCddEigpX2OJWjNUyNmKygN1hx
         l3gnXLFT1FBjoG35LhUt/KYqnU7ZFUIP8vj3kGKBDphF/h5rzPSgipo8sp3I1Ox5jdZu
         U6Q0HkwaIUHR1P1jqiqk1iza5BHmqCNZotNHaBYrVZWdorxSVcdWVl+tNhRqOBv/Ba+C
         tOqW/ehkBGJXYZ36oppyJC4odoCAQ0iXYCu/bMaMtmn16p1mTY5peF4Hjr+IgD0mQRK4
         9/fptKF5atc2Ggq73bQYvw/M014FvQisl00J7ELEeVsf2w0AsEAd+RLSVTNHSHq2Ve5y
         dC2g==
X-Forwarded-Encrypted: i=1; AHgh+RrNfQBYVbt5oYGR5JU0H/IkU5aBForBHjnLfOaExC+HJyQRACxjQs5/utK7qFbEblX+JjUG6jhZo+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11T/dSj3jLmlo3I8gt2xrePPqlWCdmQkOJQWhZPPMfiwcasOj
	wK/lMo37c3Eanu9ak9b+GbdOIMeP1HJbdOXPGsPaeXz3dZBDOJSn8Gjv
X-Gm-Gg: AfdE7cmOzRQIEsGF9YskvyEUcVB1S8xBE0j4O9/pJOVWwSyXr+8J6xzM1NPkW5j7tuu
	AMbd80svDzt+DTqH68nWYcDwVA45xoF/0B02f68iBXzYa3r4k6TAXDqY3GAmCut1Hzkya8bllPv
	30gS3bPfI3lmg9sFeOV2srA2PxlrJdQ0pdIOeO0ydO1ubW/SWlO8NuNPkZ4t1lSMgmLSM910mMW
	6HlXzpb7gZQUsbic+VDkI4D13eV9VoUAHfgGQJBAn+R8Q/+trj0eCempQC3bZbjVcECr1bPd2JT
	H7CVUpVRoc63eTGpfHWTEBV5ZymbLjjA7ZRwxm33KmE4X473a+a+g9xYVMQqJGxs9sCZfl4lvgY
	3RF0+VEPRkGbvP3lEC5+udRVLYHEL532vGNVdI5bDzMtHGd50wF7uZhR7nnNa9e8W/OzWilapvA
	2ub073MAEDhQ==
X-Received: by 2002:a17:903:28e:b0:2c9:97a7:f548 with SMTP id d9443c01a7336-2cbb9f38c77mr37813255ad.46.1783185863346;
        Sat, 04 Jul 2026 10:24:23 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad77658b5sm25123875ad.50.2026.07.04.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 10:24:22 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] nfsd: Fix dentry refcount leak in nfsd_set_fh_dentry()
Date: Sun,  5 Jul 2026 01:23:00 +0800
Message-ID: <20260704172300.254447-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22991-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CCF0708140

nfsd_set_fh_dentry() gets a dentry reference before checking whether an
NFSv2 or NFSv3 filehandle resolves to a V4ROOT export. Such filehandles
are rejected, but the rejection path jumps to out before the dentry is
stored in fhp->fh_dentry.

As a result, fh_put() will not see the dentry, and the out path only
drops the export reference. The dentry reference obtained by dget() or
exportfs_decode_fh_raw() is therefore leaked.

Add a separate error path for the V4ROOT rejection case that drops the
dentry reference before dropping the export reference.

Fixes: 8a7348a9ed70 ("nfsd: fix refcount leak in nfsd_set_fh_dentry()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/nfsd/nfsfh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 429ca5c6ec08..2ca5bb5b5e88 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -345,20 +345,22 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			fhp->fh_no_wcc = true;
 		fhp->fh_64bit_cookies = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
-			goto out;
+			goto out_dput;
 		break;
 	case NFS_FHSIZE:
 		fhp->fh_no_wcc = true;
 		if (EX_WGATHER(exp))
 			fhp->fh_use_wgather = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
-			goto out;
+			goto out_dput;
 	}
 
 	fhp->fh_dentry = dentry;
 	fhp->fh_export = exp;
 
 	return 0;
+out_dput:
+	dput(dentry);
 out:
 	exp_put(exp);
 	return error;
-- 
2.43.0


