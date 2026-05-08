Return-Path: <linux-nfs+bounces-21445-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA2IEVjs/WlJkwAAu9opvQ
	(envelope-from <linux-nfs+bounces-21445-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 15:59:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 771344F77DF
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 15:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAB2A3015D28
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2026 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414353E3DB4;
	Fri,  8 May 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="M+SCUTwe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F837AA98
	for <linux-nfs@vger.kernel.org>; Fri,  8 May 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248658; cv=none; b=l+f/4KokMpCEsaeNHntgP91DQ2+xM9YweCQXP/DtkF062EglGbYu303Tihdb6YhvY4u2FeKY0/NiWNj2NscU1nA2Ijsv1dXFD9USte4/SL5uQ7DyUuPFVFITIIl9M8c9rdBTfT0Jn1O4uHTNBWrmIsqq4cqPVUjjmyRlXFoRsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248658; c=relaxed/simple;
	bh=YVwF/U5LgAdfK7MkwOUKRHR14J8v0vdZOyUZZIaVnbg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sb5nuez8wp+E4V8uOZloZMWMtDc32RP4882iBps56GeAtO2STRCafB4RDaITQwcyl5jFOOZO0Wjd3mmBQSfV1OsCAvuRWZHf7pC+P6gBMPkqNH2TXLQGDB2zYUIbHtseFEWZjkCnwsd6DUcBHJ05TapeQuAyBbrPu80PystC9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=M+SCUTwe; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648AE56g2482763;
	Fri, 8 May 2026 13:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=vgg2KKMz8
	VLWH7fHpO4ASHn6CN+kaZKQg5py4ifD74c=; b=M+SCUTwemxjMmWAMwH47KgBah
	yKx+UrTLahy43Gq6HP0DAVCjOjefB54bd0Tptb+VESw1tPoje8AKsWsw7ry9oy1d
	ZDBkBV0QUMl4M1evsKrn5HrsdxKZCQFviO2ktP4nvN37CVz39AIdE38VFGxZe/rX
	N45My1sPsV3WxeFTjtIAz6OihVeoMmMOIazAysl0ayQPCbHpmrOhMWPvobWS+MD0
	f8ztYwc0PHDse3gZ5La3ta1nTZ0bTkmMhkyIGDr1X/tziBVQ4ZOPJjh8VKet94Mk
	ghxCP6orRD3iEqKX5mFpiEbaLwJXGK0x2AlYN9A0askiOo2iHsiFJvU0disyg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1dvc078e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 08 May 2026 13:57:33 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 8 May 2026 06:57:32 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 8 May 2026 06:57:32 -0700
From: <liezhi.yang@windriver.com>
To: <steved@redhat.com>
CC: <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH] fh_key_file.c: Fix build error with musl
Date: Fri, 8 May 2026 06:57:32 -0700
Message-ID: <20260508135732.524301-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Mrcqqup8IJ23s4Hr0dRzRATzhgPzr6Nv
X-Authority-Analysis: v=2.4 cv=adZRWxot c=1 sm=1 tr=0 ts=69fdebcd cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=OPN8VZljietPMv7vLR0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0MyBTYWx0ZWRfX562rneHTqDfT
 PaImzaYM63ox7zHsrnyR+l5fUA2MSFc2TAvL7g0tOdAfJK8oWutWqrSV7LDvlViozATVwCwwPJ5
 GP67istiasrxKCxepl+m0xxbRygn3lDYLRtiaLRLevlQjclPrRRXKMrW5mB8mqlLAvEPX9F1wEo
 hTKTegzr+SSNmtyUoIs3jiJPszEVcn5MRmKjeTOsIydKuu/qrbRLJ8FIRKgErK2Ew/MhY+6dE9w
 kHJgTZcx3Sp7teFWAaqO0nZp1DdhkiDGl/eWmo6w1J2a7r4LcjoAfa/4stQOeoKdunfaWhcVf2f
 GMXNjkOdY17kBoZ/UVtvBWdzz8xqPNh6z62sbH9sYkPNJ1opLsrYTtiLmAlRNX0XnXSVtODbBqo
 H2e1QwJAAeOZS8v8okRkO9fbfIYypN/Q5Se8ltsY7GF2FHM3qLBuMeqjxfzRjH/Lu/wvrq/z8Nx
 CfCwGhhZxKG6jtX3beQ==
X-Proofpoint-GUID: Mrcqqup8IJ23s4Hr0dRzRATzhgPzr6Nv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080143
X-Rspamd-Queue-Id: 771344F77DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-21445-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liezhi.yang@windriver.com,linux-nfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Robert Yang <liezhi.yang@windriver.com>

Fixed:
error: implicit declaration of function 'strerror'

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 support/nfs/fh_key_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
index 5f5eafc1..89555cee 100644
--- a/support/nfs/fh_key_file.c
+++ b/support/nfs/fh_key_file.c
@@ -30,6 +30,8 @@
 
 #include "nfslib.h"
 
+#include <string.h>
+
 #define HASH_BLOCKSIZE  256
 int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
 {
-- 
2.49.0


