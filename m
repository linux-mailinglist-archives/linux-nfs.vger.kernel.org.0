Return-Path: <linux-nfs+bounces-13708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E8B29EC0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAEB67A3CBD
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10F30DEB1;
	Mon, 18 Aug 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ggKm+t7n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012023.outbound.protection.outlook.com [52.101.126.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDFD3009E3;
	Mon, 18 Aug 2025 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511414; cv=fail; b=YkKKn3O9F732mc96yu/Ff0EMJohtRstkBESSRx4WlafRePLI5lJuZTY572Ozxu8Kj6CvXXv9dt+D8MXfxTgK8dtZO/d1vCajyyR1i6DFVILi5ATSZBUbMLlLN2HqhBGO5GLTU3m8Lb4H4VD8GKB4wcJm78kjtDM8nmeilgiq/is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511414; c=relaxed/simple;
	bh=kV9tC5iAMnM9DNrNpX2/hWYK8PB/M+xZxu1ZUp0GhKo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X7PnayuuH2NPtXajxSTXqxO9cotgx7UvcOhT65RbzW+b7qmyMotkrf5OmQ021Ix8OZrkY3FpHnGbI8IQzMjJUMEVoDrP/angR+46gQeUoe+sIlbNc7DIpcy/ks9iQBDOLVodHQgaNOrgxS3p7WZM/DD2ySxrVwCrYc1DtkMfm8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ggKm+t7n; arc=fail smtp.client-ip=52.101.126.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+UTN7G1z618fZdiSga+4A6IfBY+5ZkyXiTuM1o7W1jP0laXnEi4ElURlbUB4uV3Cu5Vk9E12OuTXbHTvDr1gUVseOyfjpv4owpcUk3g+KcadHVLHot1GLo4hcOz7BBhokJkVOn5UqAFMVX+XjVJUdk9updEKq3m37CV7VpsK8M0Ki6gdqsZ2VBd+n1FvuZfTKETdUSDk5Jb3PAN4QDmxG0BQHMVRVxp2v9Dd2ybkubcpqwUqdyHHVqpvJ7tXE/cDA+TVLWfqnCX+78MzIprixIxQwKRe/OF0rxcRLp2ftORiZYAs9p7UE48A103qR5ZwCLar7n9IZoZaaueIJso8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRXQ+D/zKFNLSUyQvjfW0VH9FyQdlQdgWftDtKyoXDk=;
 b=HeN5LpEbqgDdnltRtdj29iPVN288NWB1kbbiZizi/Q9VNlHFog3oX8Io7yG8jcZ8g/rwVNDj7VACndTGiVBsMHb91hmAbrCPyHNSw4aES58dRaqWD4ybHiotb1XrJ3jII16Fw618SKhu7pX798Qj6HF4+EpSJ8VJm0pMR83czBgUNy8D9MV7x5FNnFot4WPbnjZGEihG0g+BbsUzA8Xd2vyNA/8Tzzq8Vyf7XOhdcVv4vGpXH11NO7igiTa27PcoF+sgsa5X2i3tQ1TrW7IrhGfhB0ngbCwLOAbhzwywu6j3itQbM6+ggSY31b00HBVsSbJHVlvS1ezOvOYtGZ89Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRXQ+D/zKFNLSUyQvjfW0VH9FyQdlQdgWftDtKyoXDk=;
 b=ggKm+t7n2Wp4qbA+B6A9WYiJ/FCVyy/oCRpliq3Qe9/2xwrdOjF57NWMtGN3nqL2sDHUZi+3FT7slaVZ8nas/XaNegWbUlfxL2zez/+ZfQen450RsqznVm42jhA1hxQZuGJXVoM2IQe4pwLJlMr7rc9VpXRrkzyhabo5Mbn6V+umImQFDHvxzh1E1ULKG83Uk8WzeWUeQAoI6i1qAST1UE+mkA3ofVaeXppMefc01Wq8HHF4Zyr2B37Hin39cCSkVTck13+bcQkeXsDuXzSNm/gF0so27l7QJri4TxFJp33pwMqqu42N0xIOojCAJWuuQz9CEB5QQkyMyZjp4qJaMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY2PPF7174D7211.apcprd06.prod.outlook.com (2603:1096:408::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 18 Aug
 2025 10:03:29 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 10:03:29 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] NFSD: Drop redundant conversion to bool
Date: Mon, 18 Aug 2025 18:03:20 +0800
Message-Id: <20250818100320.572105-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY2PPF7174D7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3d4346-1345-41a6-5c89-08ddde3e7ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yX5XkZ3YFaX/fVKkuqCRWj7+sanXvMsvHKaEnoIoimwKoKuqnofmDkP9nb07?=
 =?us-ascii?Q?hiZP1nfFpqFtXkGlrdrytLHWOZxiGJRKA/WLAObagXu1o3XCYr3juVwdWrq1?=
 =?us-ascii?Q?JDMuo3q7cOOvKjmsvPPYc61qrzp9Zsl0FUF6ypWVrlyouXh0acUebLPrdUbr?=
 =?us-ascii?Q?RnZAy6DjzeltaX2CX/WqryaN09dI6kBLQT5b1FQB+s/7itpQ/t+bi+GwI2VM?=
 =?us-ascii?Q?dOCKJOTc9bQZfllPQ5MBlz7VVF9dirfMrP+Guv+68y7PAePQXDIGmv9jgRvB?=
 =?us-ascii?Q?MeQTE0trJRV7aCoRF2ThyLRldACM2PIu2crq7QVJjZpvTU5lptYYowXRI/Cg?=
 =?us-ascii?Q?ruBb5IyCvgH9B/7UX6epNMLcnWJZj6ei0WZYhoocIEY+9NjZc2xvXJRJY1ZN?=
 =?us-ascii?Q?uc0fmQG40nuTrA7WVns4RkGIknt5bQ6lxsc/2OQe8Wh5NoKbkhYjScbIFjbY?=
 =?us-ascii?Q?2pFGwpqghamTd1xmpYamE1a37+01KuDjYyk4aSGDinOis+gndBFaYkV3LpCj?=
 =?us-ascii?Q?/iccvCxe7E72qRgou1m1NO7jh3yhhFt0Wh3okIkVBPPcDKk45qHqB+9MUDx2?=
 =?us-ascii?Q?Ian9DI2cAjCGNNC7TOBQ2YJ6QlT9OpVin9abWd7N5219ykV6/WpkJNzuy+SZ?=
 =?us-ascii?Q?Ag9tXtx+KdTV+tmonKwJRVVH4oQaBHQtOrAnMWU26yWfkdoiroH1bIXWAvKz?=
 =?us-ascii?Q?kNz+GS0S9/LVOpLri/8jLkGm4hJX5heLHE2+/jknTnr/j4wtm1B9G1+NR+J6?=
 =?us-ascii?Q?Lib/8ynVMQdarXIHlUXYkqvnJJ/v1nWAHu3LnRXL5r9yrRnUrhQgO0eoMbA2?=
 =?us-ascii?Q?uUKib+oPBeIHW5+a4RnKNOHYCPahWVu3atLfBUA8lWepj1MhfcFsnslJcH62?=
 =?us-ascii?Q?dIt1BPoLUh+KQZKr6FB98N23IVMYOTf9JsIUfBVqj3S3Ah5JGXpF9vGkL2Zv?=
 =?us-ascii?Q?EX5iyR1YjU5hlxnpWwNQhInocs9kHe1dsHJJwwXVkUhgEdb3XPvVFdLuGr0K?=
 =?us-ascii?Q?w4CW7fAmP9VSbfHi9Wlj8fyR9RLRs6b8++pqGoZAhWj0mCTwi957fe4JDPWB?=
 =?us-ascii?Q?MF8YF5Cl2kjR6mN4V7OQF3aBi10Q0LwCdFbgK1bql4PxKlNDAoPIxZF7fx+b?=
 =?us-ascii?Q?cjaKXYN7oyp73XHkhw5rCwZEuL56q/okcawCQM8AxECpl+8ogXqaljSR/es0?=
 =?us-ascii?Q?ZR8J/uk8wMMpTC9uylaxxspxJZ+qMhzqXpsDJbv44anhM12QKO4qq7v1v6lx?=
 =?us-ascii?Q?jsTn58r15NZmCBlKZMknZ+vy2wtvW94N2rZtCcSa48q6HRfzWhr99eYUZ0Ll?=
 =?us-ascii?Q?mQ371iWvFyTlIgEK+68USKMVgEy3AlTbxLcG637TW8SmOCHSTus3iAp6LBvU?=
 =?us-ascii?Q?uZZjNaF9xzYAw4+Vfi528y49ew6zl3Hnw8i/mg2CCTBHIVJgaZyZUT9dZvWV?=
 =?us-ascii?Q?jWmk/hA4+uf5xxLJw5IhnOlEmgxROWjc6v0E1WbptLZtTEEOUx7zyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAvjfsI8pwlB/OsrYVWTg35JrmPToPv+CYc6HNYfjNW3gmR2pU2YjHFB/CyH?=
 =?us-ascii?Q?1DfBSVMPzrOG2/M5S+a3N0PpkFeg/mwgZP4DIr5DZDb938Dn0AqFZ4Lequjq?=
 =?us-ascii?Q?3IJtoL4GD67SjmxBhNqePviRyV/4HOpcR7NGf6LmMAwyDnEevWFy5bj0Ij15?=
 =?us-ascii?Q?f7GfEzVCHuDkm07rwp+38W3tLd5+jpzLpC8L/0F9ESbF4OkpCuh8bQPM9QpQ?=
 =?us-ascii?Q?flREzj7ixUPz3SGkzVPlRh8YcBd+wwlCcftjT+kTb3RIwNps3wbYvs3zMO9N?=
 =?us-ascii?Q?Tnim1pWKvkdVnkUPsC+MQZZZ6cLh5ajDceh3j50+coSzHlIGEvJYb5XHHkFL?=
 =?us-ascii?Q?6qpL3bKfCjdg4vFjVZ5CJfbJy3XUNDgW7xL1NlLfK4Dk8W/GryQ54bmdpTDG?=
 =?us-ascii?Q?bsOd3jhhePWvQXLtMB8O9gxrES4WHU+qfliegsAMxsx+aC8T4ebX+HnQ2tz/?=
 =?us-ascii?Q?k+Y18k99Vv/kF/bttaO2akT21a9UtqHzbHrmZYu1mXbgt+gG+xg6XjD3WcVP?=
 =?us-ascii?Q?Pj1b7Nawdqgw4nYySSzLCzd4DYGFnr7YVD+ul/kFuRE1denaPylZhz05IEbq?=
 =?us-ascii?Q?44EiissKh+P55Mv+HYUc34KWhL+UEWrsLrobE26CrtfyXGjl/jYT2WwYngq+?=
 =?us-ascii?Q?6CzSozNva97a1vjkc0+wi7r7tABnogI3yu7P5WTjDh5liRPY8n5lVIoVzpMg?=
 =?us-ascii?Q?OgQ6vmpc6887kTRxpvYF6VOgWF5Q1eC/ZkECc+hTL+cl5bGn2DaA2TBucNOS?=
 =?us-ascii?Q?uXUFrTXUuz2pNwMwitt24KDZ0/uVTx3GqZLLnEsAknphi+X33UWTEWA7Nz+v?=
 =?us-ascii?Q?qPujjuLTBzylRhNZj5Hv2SP4KQm6kJqrtVgHd4+RYuYldYnFnrJBDyq7q1Pj?=
 =?us-ascii?Q?mFwO+d0LRSFor78Gp7+hYP4lWBVcChIE7EIBoT1Wi+hxUt9lQWgwMcGBvLJa?=
 =?us-ascii?Q?0uDu8Q08Sxhl6n2e+8MxMGbJ2f555jtSNfXxSELgSxpg/J199NvfchjwKjpb?=
 =?us-ascii?Q?if6QEOdx9VhXtAb5Mxv6DRBSQDIYPTTkleKoVwsJPOeDWkQRfTeCChin5FbV?=
 =?us-ascii?Q?SzJlLUbB5NdqSZx+LImr6O1SZmakFWlgi0IBz575DQ0i8hSTiTCqaC1RUw/i?=
 =?us-ascii?Q?xkf2v1HQ0U+chmVxgFukd0405q/lfLKaftBdchBFliQYp+raIFGuW5v5hfZ1?=
 =?us-ascii?Q?8ZX/MggjzIBqA/byVClU38+brnUWw9CHcxx67RC1VoBcYudokUoZsfWWAMUW?=
 =?us-ascii?Q?G4KnklB+mJD4qGnldEjnWoIzRQ/Jdjvadk/YA3gJpw2neor+/o1W8edyjQUw?=
 =?us-ascii?Q?MpcnRpt/1zi/AslWvAA/seXjoxZ+9Tbf/bPoMUUCDidnv0DX6o66jq+0Adb3?=
 =?us-ascii?Q?S2+qLlFyuGZt1kIV4xbTSrwQaOV308Zo9wawj6fTCqKXqIpT0lHAjpYGDk0w?=
 =?us-ascii?Q?+jS7yRRONYbmFhINktKr60H6cUvL7Zx+WWjmbTA3mzZ/ltVBvsSpxXcLBTe7?=
 =?us-ascii?Q?eb5SUoq6Nw0JzseYH2EBuP/FioEWtQ7nvkaDQ78msa2hSIICHfVJBYyxIkAG?=
 =?us-ascii?Q?62ZNj3Bcp/okf/dBL+nv6U7PghZ1J6sPz7JgGXzW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3d4346-1345-41a6-5c89-08ddde3e7ae0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:03:28.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNsThHhdGH5KO3vELcNHQTay7RBQBJw+MC5AhSqmRqqVdXdhNI7j4hhJfApV1+6slj2SY5JafBXhzeCfvvSYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF7174D7211

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/nfsd/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc..f07d790d56aa 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -26,7 +26,7 @@ static int nfsd_dsr_get(void *data, u64 *val)
 
 static int nfsd_dsr_set(void *data, u64 val)
 {
-	nfsd_disable_splice_read = (val > 0) ? true : false;
+	nfsd_disable_splice_read = (val > 0);
 	return 0;
 }
 
-- 
2.34.1


