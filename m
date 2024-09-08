Return-Path: <linux-nfs+bounces-6322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242C970747
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A872822FD
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBA15C141;
	Sun,  8 Sep 2024 12:12:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0936B0D
	for <linux-nfs@vger.kernel.org>; Sun,  8 Sep 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797545; cv=none; b=iTQFIukeoxe+N27r6MX6n5qiX5cn/NJwldLtvfQJSIs/1JXYR3bCyO9PD79nXaF8Uw98NwM0vxADsXw3Ow7Vthkqrg4d/4vRTfL49cSr6AEgKTCtkiZVeEmUN3HV17Sad4pkrJz/iouVMVxEk8/Zg+I9WN05Hink9ODKDGUyEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797545; c=relaxed/simple;
	bh=MGS/t7x6CFK1Ff3es3+Kp7U2+qdPaCL1662Aqr6R01Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d75lQfscozaI4Yz9fgrcRgCZd3McROSeLFMA3Nh6tcQb44H/5WF0bmVGH1ttjem2JPr7SVrB9VZPrGkgi+1XhiB8muVcvCNrePu9kbEc4XFxCaucCTtSaGah5twyGv4NUvoiHmVup780R/nxK+rxKYrPA3jcRh/G9Itew43N76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488BuSar018023
	for <linux-nfs@vger.kernel.org>; Sun, 8 Sep 2024 05:12:23 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gpbk0ngj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Sun, 08 Sep 2024 05:12:23 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 05:12:17 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 05:12:17 -0700
From: <liezhi.yang@windriver.com>
To: <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 1/2] support/include/junction.h: Define macros for musl
Date: Sun, 8 Sep 2024 05:12:16 -0700
Message-ID: <20240908121217.967390-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3Uc-Y0Xt0gKmxjk8IKaQLxGVASQ-KcES
X-Authority-Analysis: v=2.4 cv=Ye3v5BRf c=1 sm=1 tr=0 ts=66dd94a7 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=t7CeM3EgAAAA:8 a=ShGS3BTFOA_Yc9cHPcMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 3Uc-Y0Xt0gKmxjk8IKaQLxGVASQ-KcES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_04,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=744 clxscore=1015 bulkscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409080102

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


