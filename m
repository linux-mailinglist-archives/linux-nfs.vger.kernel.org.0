Return-Path: <linux-nfs+bounces-6320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD15970705
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B2C1C21073
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A31581FB;
	Sun,  8 Sep 2024 11:43:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089015820C
	for <linux-nfs@vger.kernel.org>; Sun,  8 Sep 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795801; cv=none; b=tYXA9eQLANKnbZji+ltYqEKugGAc4V1pVT9AtKQRGuCl53L3XHaeoV6c8RZNBG4cBhfCk9FcCrxJE0lQGtJC8ggHArwMnC2Z5Hoj1/3t9tK0xq9DPHuwVQzQ7rfPL/M42qXEE2i2YJO2Ojofl++1LGJREZ26swS9lAhy7ON2V1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795801; c=relaxed/simple;
	bh=SWyhkDVizBMP27ItAOwUF6yGeQTaLvnoTuxuKiNwV2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufZsJPOfTzOviCoQj1SIvHnelg54mZmWysLZcEDkJJ/6NN3ATGYUMcCv28aoOaVtKjvhK/IUfd8Ga+kT7dV7+036YC3nF3RgNnnqKUrbqGj/djsw6SMuxN9eHI+LnWimZnCMXgZvieKgJvOYtzM5kbsBsJtWSYteuIQLfWLT8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488BF3J1023946
	for <linux-nfs@vger.kernel.org>; Sun, 8 Sep 2024 04:43:13 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gpbk0n36-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Sun, 08 Sep 2024 04:43:13 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 04:43:12 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 04:43:12 -0700
From: <liezhi.yang@windriver.com>
To: <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 2/2] support/junction/path.c: Fix buld for musl
Date: Sun, 8 Sep 2024 04:43:12 -0700
Message-ID: <20240908114312.3883312-2-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908114312.3883312-1-liezhi.yang@windriver.com>
References: <20240908114312.3883312-1-liezhi.yang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kJjA3JTve_vEipjpK4K6Ll6c3bKizOcf
X-Authority-Analysis: v=2.4 cv=Ye3v5BRf c=1 sm=1 tr=0 ts=66dd8dd1 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=EaEq8P2WXUwA:10 a=t7CeM3EgAAAA:8 a=mDV3o1hIAAAA:8 a=OdVygvz5nBpVOvdqP74A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: kJjA3JTve_vEipjpK4K6Ll6c3bKizOcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_02,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=593 clxscore=1015 bulkscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409080097

From: Robert Yang <liezhi.yang@windriver.com>

Fixed:
path.c:164:24: error: implicit declaration of function 'strchrnul'; did you mean 'strchr'? [-Wimplicit-function-declaration]
[snip]

path.c:239:27: error: 'NAME_MAX' undeclared (first use in this function); did you mean 'AF_MAX'?

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 support/junction/path.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/support/junction/path.c b/support/junction/path.c
index 13a14386..dd0f59a0 100644
--- a/support/junction/path.c
+++ b/support/junction/path.c
@@ -23,6 +23,12 @@
  *	http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
  */
 
+/* For musl */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <limits.h>
+
 #include <sys/types.h>
 #include <sys/stat.h>
 
-- 
2.25.1


