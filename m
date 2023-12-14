Return-Path: <linux-nfs+bounces-579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C7812BCA
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Dec 2023 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA6F28224B
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Dec 2023 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16292E85C;
	Thu, 14 Dec 2023 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="W/KqjVYA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B4B7
	for <linux-nfs@vger.kernel.org>; Thu, 14 Dec 2023 01:37:22 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE6eDN9020274
	for <linux-nfs@vger.kernel.org>; Thu, 14 Dec 2023 01:37:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=fLianYXjIPgA1ZVxtF
	jFvHgAHcB1R0IlYgXC92P82KQ=; b=W/KqjVYA/CQbdL90MDCtoGqD/sQwiK9AuK
	9piiUKaE18MF3OGutbtFz5mQQQJFM4HFaZSuqIkvGsHxrw296b7hhzTA8Isd0H4p
	Hf5b7du9wtO2d7MHbyBea3BE3SNDohl5It0HFHuE8Ayas01Dmgjhw51/QTE4u9DX
	sW/6nAmXDRSI9HJMxmGFvmOpKO5sQCqol2z8WS3lWwQZbuTPI9nBXGwYxcGiz2YA
	JwvP5TkYyVUJqxqmQw27mxKknBc+KafLLwCql1npUv0ls+bC0LSb7D2sKFHjWORt
	3lZJOOyEssaOLSH+d6ruptHEGWEHckmRgii49pNYpS0zwgPRFiUQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uyr7dg9w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Thu, 14 Dec 2023 01:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es999FyH5LpKIv2XuIH3WqWLQFRJ2l5TsyMFJSLkflo1FUtz53L11PwHRZoqDg+WytYPa13jDEUkVVwoohlLewwhIeH9oGPgQdHJw/zeD4iqAVCxXibg52GVJgFsWmS8kk2PpWfPFFL4NoWgnIxBqqxtJhE8juItFQMR69GfQKYT4Xq7WpFjWWu5OljpTKa/bpTWGDhl6tYeMs6Xfq286Q1JacPXSRlCLMm1YOSxhSHp9jJEP5jvQrlYLtIinu5fnCfTr+oFU55uZk6bFnQaZw8SaGPCI9wegjtAKX42VFZjnDWgNk3pTw7mEDkeJc/pX4d69tlbvUwTAFjrPvRHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLianYXjIPgA1ZVxtFjFvHgAHcB1R0IlYgXC92P82KQ=;
 b=cqA09bFN65MrfaIx/poyNV1oxl3Do/vI2aQ7D6is+NZSQjvUhjHCVqLp2R9EJuDc4TPqdluK4W+BUjG+f6QnlBhnybWUi7hEKlS2JtZwD+agqYxRXESESDwwW5U2B/M9qTkuGrFk6OF5gQLglKMdF3PGHBGTETTdVL9KQq5Ud4k47MQ3i2xjhXlzTL7JvtnLWh2352pLGS0sTOQEwTtjSljd6c1en+EqPdY9fRQ0cGmlIHdRN9k5TIt42bJJn1QBHsKBItLgq3EZpVHrzC0n5uFkEmHYZjjqBwAXDmG6ZCTzocfBbQwnI3fJDymhJoQbSGN2e7ydeS6mydvlAG2tqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 09:37:19 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5d43:ce18:14be:b2f7]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5d43:ce18:14be:b2f7%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 09:37:19 +0000
From: liezhi.yang@windriver.com
To: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] reexport.h: Include unistd.h to compile with musl
Date: Thu, 14 Dec 2023 18:12:06 +0800
Message-Id: <20231214101206.70608-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f479d03-56d5-4e44-2824-08dbfc8843bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w1JEf16PgyfdDQkBevIcnDjYgMy9GMOXfyLOtnEiuxA86sVpGyqZNQb2MxsuCwhG+LPidKQXAsKs4dPWuA42OXUEgqymN0yB6LgQiJAkp8zcz9mVmh1ClWY9Hh142EKctt6NjIGx6+wVocuE4ELAL4IwgN4fUGR+9K/Upss3ktx9WRW+RockNy23NovR4SwRVgqfCto1LUDcpPrbn1Zz9vbEkh6MhvnynnRfQ+i7HfpYMskCqluVssGoIEQsZ2aqTBkVD/lHDGzuF5c/GjFBNX0u+vC/jLzY47nvztIC22y2BAMEHQh2YfPCAIjxj74UyxMYZPRyKEX4xC4vVUPkeoiNrQFY3tdtdO0Ewqrmj3Zrrbgwp4qogRt41j0eHpntccJQFtlqaPY//LHk0doehBaCJwxOg7fNTJC97QgLrNorIqtZlGybWBoHfnyondZUMyob87VZmMYnExnygUC3OCzYeewsyLJLDPK39qSsrHLCEmXT6GoXG9b8FA4Xc8ElWt8E+oBWr5SIZoO87j7//MuGhAm+eObbtfZWelYexzf6O69K/7q0aqrFCyD8+SrlxvPa2a4KaaZwI3OTNkc1C+Fs58rHqSsZSCuuwxcJtB1Dk1fXL3mLcLySBJeyLlLF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39850400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2616005)(9686003)(6512007)(1076003)(26005)(38100700002)(8676002)(8936002)(316002)(2906002)(4744005)(5660300002)(6486002)(478600001)(6506007)(52116002)(41300700001)(6666004)(6916009)(66476007)(66946007)(66556008)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4BPevQy9k0D96vXz+LQnq1EBHetrQdC96mF+ODZUlfxvzijNYXEcsbMP5gNo?=
 =?us-ascii?Q?gyKDWkOJaRXtyDDI6Wxq84U0vB+IU0EPvyXk+2glcXVR5jgdImWa8KxVTF59?=
 =?us-ascii?Q?dZJji1VerclbEl6IRE9J3iPSAfTLQZia9ysa6xnfm7CLlLbXM/Q/0kSF+mjC?=
 =?us-ascii?Q?eADRqERJb3uIeQygN1G/jBj4Jx2kVKM2hW94A7LYGNEPANX7dlLCzI89g/B9?=
 =?us-ascii?Q?hZ9jnNKok0KpCNGA55opKAeim7wRGGr6fDh2GydTkWCpKAtj1jXi2d0T97Ao?=
 =?us-ascii?Q?sZ9IF5wXM28Daz9Y2KNrrY3OfDoIXQRpUQTTBbGrZJngzP3opYKE6sLwH/Q1?=
 =?us-ascii?Q?hbJ49985GAZWULHOYsGCtpw8zO+53cYgjaSTw9zGyymdP7FFLNKdA7IWaFcp?=
 =?us-ascii?Q?1hi2/YP2glLtaTvuoVdwoWhiJ2vOSqA2xwlSOyK5Xxcys90xNml3N+hN3SKp?=
 =?us-ascii?Q?7V61ORC+PtGgP1CeT5bS6jfWH+1rLjsT+VRX/UZBMDg9q451PYOAVdrcOx/0?=
 =?us-ascii?Q?9kqk9dGETgaHTtC8WjItOCbNG+KRUOHaWhg7VLhqBvg+nkZZPcOIKvR2O7L3?=
 =?us-ascii?Q?E7NIwHfRwVjjdScDLRt8D35fbPqhx+rAPzGKdAE5Ad2uk6zFEuN2pM/hb9Ee?=
 =?us-ascii?Q?z2HiCAMG49V48kowh9YWyIiGOzH4oGnwcGJrllSkyrTSbPigc/Bj1WGGwRHS?=
 =?us-ascii?Q?vjSEkOcomeU8RqgLtvb6RXizHo4j3NyPYIt7SkpfBlzpCDwHgjxRSd4gHj7p?=
 =?us-ascii?Q?fq22l1NEI+knUyQCUp4l1kQ5Qb+Q0exaIGrDVe3TyXBlNbej5wIuqCrO4Efe?=
 =?us-ascii?Q?IbYz7pMmQLrhjcKGreRmd2zEf7yF2nk+WxWSysy4Ft8kpJbebc4I4QDWEM6A?=
 =?us-ascii?Q?C+WB5A4XQcYCwFlo+6dehb8+xdMuBU//PWcuE4cXwUkuD0vsgJTajTTtxqs+?=
 =?us-ascii?Q?+rq74TBbiUh4i3M64Uqqv+phenfbNJYg3Ay8EFbMQrB3WTWaSf8AvKpxWCxG?=
 =?us-ascii?Q?OnwrEip/OyZJxuzpoWjXiRQA1XpqaDVYVgiTR1alodj/Q6LGLDSMKyExJYpd?=
 =?us-ascii?Q?YfhCMdg8c0fkcyOLKmBCFyoKh4C8ZhWU4/Q1O6nKcNQ9Q4VjvOy6jB6hP8UW?=
 =?us-ascii?Q?a1NFqD+Ko18Rw/h10/CVWYM1GHwq/V/G32ooq4jbSTY3UBQYCd1FGPu70MWM?=
 =?us-ascii?Q?Rh/raiy9WonI8EzjUJ5vDeX4EhMnHdEgR7hUBAAlkLhFgWHav3BsiQZNxfJK?=
 =?us-ascii?Q?gNM08KSgHhSJRwCIO++WB2MOGBRVC5dmAsNs1Va+jtLt9S2Mpar7uSlranHk?=
 =?us-ascii?Q?90H9QlxzzpZIqxEKghoHX8jlb4lMZPpl6Rf9L+dGt/4+IhpmouvIvd2+QjNn?=
 =?us-ascii?Q?gEVF47zuN3QS4LWUzx9AjhDakYuHsHfTRAvt5rrw019J3hgAbNUpmBCYQ879?=
 =?us-ascii?Q?us7k3AaNmECd2YtrjnpMvZfbBgsEuZdCxX4KRevcw/EB/7R9sy1qVSvPHCib?=
 =?us-ascii?Q?+LtoLxtiEVIfHZhgRU1TRafXtgCqRKpzCJ3VME2qc0QPidm7AaR/dyFIDPnt?=
 =?us-ascii?Q?ARqsRhgt0lQ4YjlZB1gTxoOAwSob/B42rpg/pVD02nkISYOAsaUEJOm0g1m8?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f479d03-56d5-4e44-2824-08dbfc8843bb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 09:37:19.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMgBZsmswNJeeXRhePcQWabCuMlWQK+3P3GLsK2Fz0U+8UkVTjU+9rmHtiSRsfTR422KTnJ4KOyCr0L9ej5JZw92KeeNPZ+hPJtrHYTHiMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-Proofpoint-ORIG-GUID: outBKoPvwfRXNWtJMj6z3Qfyv40Lx6MT
X-Proofpoint-GUID: outBKoPvwfRXNWtJMj6z3Qfyv40Lx6MT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=561
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140063

From: Robert Yang <liezhi.yang@windriver.com>

Fixed error when compile with musl
reexport.c: In function 'reexpdb_init':
reexport.c:62:17: error: implicit declaration of function 'sleep' [-Werror=implicit-function-declaration]
   62 |                 sleep(1);

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 support/reexport/reexport.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
index 85fd59c1..02f86844 100644
--- a/support/reexport/reexport.h
+++ b/support/reexport/reexport.h
@@ -1,6 +1,8 @@
 #ifndef REEXPORT_H
 #define REEXPORT_H
 
+#include <unistd.h>
+
 #include "nfslib.h"
 
 enum {
-- 
2.35.5


