Return-Path: <linux-nfs+bounces-6321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68126970706
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 13:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AE12827C7
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F023158521;
	Sun,  8 Sep 2024 11:43:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80846158203
	for <linux-nfs@vger.kernel.org>; Sun,  8 Sep 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795802; cv=none; b=VKiWGgLh6MNdfkRR4Jx6tCvrnhPrneNDUS6l8DkvM9Sbm1L3mhmze2dSJ5/ft9KcocAfjOS707obpVCn4Ez9ywN2FccG65bHaifr9RcZzQCI84KfpzMcgV6l054ciyOBjWzeGHdyVX2ZiMhnAiO8Hi62vnRDbe+0t3nhkCdvG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795802; c=relaxed/simple;
	bh=MGS/t7x6CFK1Ff3es3+Kp7U2+qdPaCL1662Aqr6R01Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxphBpS6oc87S8f88V1oyvK1F83qPFpz8OBpusUZ0fOwZVFmLbORPY2LukY/LysSDvMjGRnD+Y8TePtN5m0FdU7DmclL4OxoC9iGfMq1oD4FOigId6ahJD0f7+JcPPInq8388zJYIbg6vTm94lpTDopKdWaCdCqCS0kX1Zr1oHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488BF3J0023946
	for <linux-nfs@vger.kernel.org>; Sun, 8 Sep 2024 04:43:13 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gpbk0n36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Sun, 08 Sep 2024 04:43:12 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 04:43:12 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 04:43:12 -0700
From: <liezhi.yang@windriver.com>
To: <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 1/2] support/include/junction.h: Define macros for musl
Date: Sun, 8 Sep 2024 04:43:11 -0700
Message-ID: <20240908114312.3883312-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: __pBueujIbQ1VSCFVjuTiE7xwKy_JMrg
X-Authority-Analysis: v=2.4 cv=Ye3v5BRf c=1 sm=1 tr=0 ts=66dd8dd0 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=EaEq8P2WXUwA:10 a=t7CeM3EgAAAA:8 a=ShGS3BTFOA_Yc9cHPcMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: __pBueujIbQ1VSCFVjuTiE7xwKy_JMrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_02,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=747 clxscore=1011 bulkscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409080097

From: Robert Yang <liezhi.yang@windriver.com>

Fixed 1:
In file included from cache.c:1217:
../../support/include/junction.h:128:21: error: expected ';' before 'char'
  128 | __attribute_malloc__
      |                     ^
      |                     ;
  129 | char            **nfs_dup_string_array(char **array);

Fixed 2:
junction.c: In function 'junction_set_sticky_bit':
junction.c:164:39: error: 'ALLPERMS' undeclared (first use in this function)
  164 |         stb.st_mode &= (unsigned int)~ALLPERMS;

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 support/include/junction.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/support/include/junction.h b/support/include/junction.h
index 7257d80b..d127dd55 100644
--- a/support/include/junction.h
+++ b/support/include/junction.h
@@ -26,6 +26,16 @@
 #ifndef _NFS_JUNCTION_H_
 #define _NFS_JUNCTION_H_
 
+/* For musl, refered to glibc's sys/cdefs.h */
+#ifndef __attribute_malloc__
+#define __attribute_malloc__ __attribute__((__malloc__))
+#endif
+
+/* For musl, refered to glibc's sys/stat.h */
+#ifndef ALLPERMS
+#define ALLPERMS (S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO)/* 07777 */
+#endif
+
 #include <stdint.h>
 
 /*
-- 
2.25.1


