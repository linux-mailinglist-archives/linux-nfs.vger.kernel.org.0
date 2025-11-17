Return-Path: <linux-nfs+bounces-16461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 190EFC65A64
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 19:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B325F4E0557
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD3128750C;
	Mon, 17 Nov 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b="TpDKx5U6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021088.outbound.protection.outlook.com [40.107.208.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6523D7CF;
	Mon, 17 Nov 2025 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402625; cv=fail; b=kI2yotsRWm9bg5qkF6vMp5stG/mblGdIbku5lItA7LuUwDDvzA/C8J0kKtYUlHG7nlZ0cOAjTobXAGJ0IjwvmL3QLZMg/rEeHHJw5wDnEzL3TJVV4Ikp4lRLcqDwzBn2YOeGYBtG0+oDPQruytLm5kQiYFbN5/bAzk24jfKORWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402625; c=relaxed/simple;
	bh=JTIokI5p4wKRyBWzmCq0eTWoM6VenDILuTB+ri2/dpw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FB8T9ebxQtFEHSuWR1l4TWeacs3m7U3hCGP8osbmJlQtj/QXtMZf2nMqpJDx9QnpmMxlEYIUTC0N4R6BhfgLjlOwH9mT7chBCJdtxqaqKz3Rx/ixgofB9iIDU50xJSI+op7E1/8zKHM/RJcD6WiW5llbZKHjHgM4TvqDpNVKMLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gatech.edu; spf=pass smtp.mailfrom=gatech.edu; dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b=TpDKx5U6; arc=fail smtp.client-ip=40.107.208.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gatech.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gatech.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWFdIUn6ZlZhs1493v/tEahEZHF0jx0vBwTq+E0bXis/b0wUctM/Hx5mjwqOGTztY74rBB1YHHuIZkx2RIOTyShdb5xuwSHkTz0uuwzGoBgEV42xZTk4nPm91HvkXMMa+xnLvFpM8SbUgKJCbeoPTiUX4ckeas1tClqLEhkk/yNxqeFrRIatJ78XXLh+J0gnTvLpUTD10MKKI3va0Rc6gj1h7Beo8pyZArnm5Jh7mAlh0j9o7LRfAcJnImRY6quAUN/uYZDeJU/cdj/RuaphmBBOuxD5sGrCnn76nLzhY+KCMmll/9YZ2+0w6afQeJZibFnrM1zR3aateM47n9ca+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbDPcZ4iKr7UsW0R47YbQ+7hFMKT2QyShS8bVnOoU6U=;
 b=h51RQGAiqd56/gdW47JnxquJSo5kUSONBSaVZ7lHIiGgo74rFOvBnLeOYZJ8Gz5CzN+Knya1PK/e1XV11PnZN36sq5f+oQjIeByPi9qvEBdfWHfFeLi6wVWuP94tik2NQDTalDrvZXzNiTYQv1VVsrmgw5gSaHVwKo3wT1vkYU7obGXkl2Cn5Mv93fYgv8MF1By6gwe0Ksrv0UdWL66gNcx0QDJDTBXMmAc+34pLPQFyEjVW/mkSCL3JDxnDxPesh6IzpV1SliqprOe7V1HEa3HJUYxeGEHpJVNm4D5/1/Hr7CMR0KGt3HD0RZLjWTi/iMDWeuGHmSecfdAeWYM1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbDPcZ4iKr7UsW0R47YbQ+7hFMKT2QyShS8bVnOoU6U=;
 b=TpDKx5U6qD9F5O1cNP27QCwAOFfu+c4M3fHtMglZxIQHdh0qOmYdT6no9Xe/qcXrJdc89SaVqtegnIO8uoeTpN99hFIa2E0MAJ959jUG1cAw4RswycPuY4XQ418hQkWhPM8HrRqzRyq1vwuPxh0RJpx2kLDLQFUqli/Nz8g6AEhBlaFsrmw1ZBMhAPEFU4frUMfiePLoUfrRnGFlUTuDPnuFCUtIG2VaRzOulT5SlLQ4qQpNUiqd3lEwpbRaCS7nfVIZKfwK4dZneRCkdo+1ADgcFigRUkx1l8Mr3qqlgdRJnpRFVZ8Q3DwpqwjkNt5/hp4PL3mxkK9zkxPYdEcaNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
Received: from LV8PR07MB9999.namprd07.prod.outlook.com (2603:10b6:408:1e6::7)
 by SA1PR07MB9006.namprd07.prod.outlook.com (2603:10b6:806:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Mon, 17 Nov
 2025 18:03:38 +0000
Received: from LV8PR07MB9999.namprd07.prod.outlook.com
 ([fe80::75de:dea2:92ed:dc7b]) by LV8PR07MB9999.namprd07.prod.outlook.com
 ([fe80::75de:dea2:92ed:dc7b%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 18:03:38 +0000
Date: Mon, 17 Nov 2025 13:03:29 -0500
From: Aiden Lambert <alambert48@gatech.edu>
To: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.org, 
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: ensure nfs_safe_remove() atomic nlink drop
Message-ID: <qqu6ndrq6ytkt7rfe7hw62iu34fkt6eckixjgx7bkhqgvzvcm6@h4tj3bkvvidi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To LV8PR07MB9999.namprd07.prod.outlook.com
 (2603:10b6:408:1e6::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR07MB9999:EE_|SA1PR07MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac8f511-67a0-41d3-d243-08de2603a256
X-GT-Tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8iJHZlWvwSJjFNQyrT68/6whyTnbUDzKSZgIQm+F6By4b9LjAmjG+1hvU/wP?=
 =?us-ascii?Q?t05l1/ZMrsxMmUAi3IpCwqXVYpkYBLMOL8G7LoaKspHJBS5H+WMna+WUPdet?=
 =?us-ascii?Q?JySRWcvpbH8R7wuTbnLX4SsHGKd1DAeHzGyv8toVmzZZVToV19EquIoO7tCL?=
 =?us-ascii?Q?1oMHF3ajzWLMSq1d14wGegwuHypRHnNWfdK3in/LtKSrHqlIQUCt+P8k7681?=
 =?us-ascii?Q?YjmvNqLCw+SvMpZ7SawFMuQRYAMWpDqm1sJrrO8hJrhDPOO6Vx2LYRJKFWg4?=
 =?us-ascii?Q?sQU4ugqmAIOI7gLoNrxANxdOL2aEHyqZPKfu9wnO36/nJ3uD9+1K0v6N6NSH?=
 =?us-ascii?Q?66fgRitoGOSNR8q2J8WSEtYpdGWlpqGOVfYKCkJeUy9OOPCwnrJkVRliDFIZ?=
 =?us-ascii?Q?eT07CyRdv7JGL8syhkYQ5NqHzeO9qK3UxkmgrCeSt44CzLYwJdIsFf9cLgN9?=
 =?us-ascii?Q?b3KgtTzN0MsHDG8a18w15B/s/B0BzW7RdTJo3WTXu1BM4xoPzzA/67ZdsMK0?=
 =?us-ascii?Q?XfDwfMzI23tNzaajNncB8Qi1WTaj7c0yJSJXOhvet+oF+LeYzdbjuqmXBEBV?=
 =?us-ascii?Q?FjWlW1ypaum1Usir0/CH02ijPFM8RB6W3C+8wLkZd+RbERlEaDHob3qZNrqy?=
 =?us-ascii?Q?3i3RFSt9v/lEgttqAEp1qMPc5enUskl5EH8+yGODK7+0ggbsXPbdXXtKst1y?=
 =?us-ascii?Q?5DMR7lvLVNPhNZJ3UNYraQBN3fJJKYyhqWNQMR8qTEIyUiZphipYJc/CwVvh?=
 =?us-ascii?Q?VPg7rhaLUMjW9O7tTctTmN4dkYkYwJ8+vTrg2E0prJWtxK4PgbFbWD0RwXv6?=
 =?us-ascii?Q?jx+8ShVXxFcdbGhQcluBMoyuTRl9jIIV6xOQgY36OsfXhaA6ZhAVtPFP2+NB?=
 =?us-ascii?Q?b7l69Lr1ZDNnxmV0RqEStQcy9KARZ7nWLXJ5eMmboGiyir9VPb7FVDmBQunN?=
 =?us-ascii?Q?8mi5794yPoOID3xMOqcPLKkul3FHmQNOa2mkaecg0omkPAyD8te7t4Xddotu?=
 =?us-ascii?Q?vpUI8LZlE5OS/jC6XwYilXOYWJSFTD8Czr701gGKgypxovFjwECq8YUY/eTy?=
 =?us-ascii?Q?Y1Wojr8p/ZFs7F8GCl5M/W1jVjeGLEqfnnOs0n1mTPceRrtlgWfFPy4Mm8Xv?=
 =?us-ascii?Q?DVtYSl/k4Vd8AC+fcRJ0C19WhCsx/pURSpQDV5glrEAddlJmMF4DFOFcSq6e?=
 =?us-ascii?Q?KBb/HmxesfXxwgzjT8XxpiSNhTGI8xCzTmA2jMp3dtkm7KajMY0yuOnWwLaC?=
 =?us-ascii?Q?ajHX68f2uoFFsCYv2uoW3qYP+YZ/YHyjdh1cURrkEXcMMIeR1k7piT0ndTex?=
 =?us-ascii?Q?fzjfMWUiJ+3WLVKas5LrzoE546k2HDFyQxp3yxoOoqSn4vnzOXH9dQ55Qm6M?=
 =?us-ascii?Q?9e5+5YbThvCF8rPMFINd966ZSAL15GCPfmWUKdRQWxbKFs1n9xA9Dbkem/28?=
 =?us-ascii?Q?tmoXumGm44mRm3ZXniAPlNnAFuVn2gpq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR07MB9999.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aE++/sLocHjLCBk9kVf718MaC+5own4mOQQnjCvX9iWpQ+4iwm+fQGQR/QDL?=
 =?us-ascii?Q?SoOqk0UntiHPON0PTpghBhg5eVd3ewxgIVg8jXk8w6/Ga6ta5w2K6QliNyNg?=
 =?us-ascii?Q?GrMsCnZQ3UNgSAd2RXklRR4r88Ax9AMzWkcR20U03QehJ5t9t6QSlZIf4cA0?=
 =?us-ascii?Q?M7ZWwt87nUsOY5X1mN0ie89n2tzCEa49UI19ygsVp9pCtSm525CAfCf6HAqo?=
 =?us-ascii?Q?sJqWuOKEh1XJZS/qV2IPSIelW2D1m6p0uwk+w3LId5h2aJUPoluVQN63ChSe?=
 =?us-ascii?Q?tYS2u1Fnpl6m8+Ikfv9UtIC0r0LWtDO3L03laKZS9JPGCWgDEkqrYCGXQJA3?=
 =?us-ascii?Q?oUXSq3M8hX8CUJaqa2UjlQc6/gkAuLc/FnVzhmbB5XxUJLcqbVvNSb0x5mLX?=
 =?us-ascii?Q?cuZ1nZaZLUDC/FSYYSUKWp6L6euWiOPbB7o5RWmtZFPBxRQYxWTmY1keUGhv?=
 =?us-ascii?Q?nJ2Arm6O8TKh5dQVbamtwzh8uGN7uoMR5h/VKo2NFtBQAd0pql+LBtwtp0c5?=
 =?us-ascii?Q?iHRD6ABvzFgbUhKzBFiGhLGuUQFoWo1BO53PayckxsrKWMesVSJZo+26z/17?=
 =?us-ascii?Q?sykgFXL63LDctmvR2wNmE/z4Z4zyjgzSyKJm0FLxSgLFpHeHfKPMLT1W1xTa?=
 =?us-ascii?Q?ld3PaFeLVvqchvjH0aYGKxUekJ8piAP4BCE6Na0SdYO4aMkdXy+/Ue1S5NzV?=
 =?us-ascii?Q?U8vEwTS3I1HkQh8514jw8WpvNPRDWA2mi0ggmeNFmhRrsnPkKMmRM6O8JJ4d?=
 =?us-ascii?Q?ena2tuPJTWxFez4poOEeDW5lECIYeOexiL1gQ8D7QADZhXJwZBhHxFsgt9ju?=
 =?us-ascii?Q?b+T2o62jpDXjiVla/RhnpOycmQFIwUyv+JWvTnIWQ7aEeWE4+UIpCIcb5GsB?=
 =?us-ascii?Q?WGyFF+l7CLn4F1g4krQBjeiKCO9rtXVSA46foLtw0YaT8UdjzVoWHaq5XrAr?=
 =?us-ascii?Q?J19W+RySvgwBxfo48912AdY0EXSYlQetyJUVwuv7brdcfoqTUUnuR4Ir0w6s?=
 =?us-ascii?Q?6Wb5Y3LYR3PD6/uW9qTiw6HavM3FU6AqctildKYckswaT3usgssdUH19bObf?=
 =?us-ascii?Q?JUz7V3TpW1QpD/uJUo/W+PFMuN1oOc2CYWWkFAD5wOVzkxdyRoU95G+T8K2i?=
 =?us-ascii?Q?iFbyLm+8A7SogiSJTuL/9VB24301aEZNpc6Ku6uns/7Nn1XhBAyrqC1A172Z?=
 =?us-ascii?Q?iozavPilyM++4RoPApi/2cAgSK+SngkRoDkbzMPrMyDLFydcCbhgmZLwEN0x?=
 =?us-ascii?Q?fCZPq8yp2TOCiApB17Y0rxuU4WyV8DZkN2mO1Qnem9tTJjnaaSsxDAMsLior?=
 =?us-ascii?Q?gkTmDoMdXf/RH2aDLYD/QCB2l9jbMT78lhg/u6YCVyr07xB+pK2adh9lj/b8?=
 =?us-ascii?Q?gmN27cX3IoBvbb1v/VxRXh3ccG4Ve+J2kK/47CKqPECaocmDmIC+HVNl84VZ?=
 =?us-ascii?Q?OYxcxC/aH/8NVeV1CaNmLYuP70+GAn6Kn8Cq9UD/gZYg2SqXKcHM7P4BlJwO?=
 =?us-ascii?Q?6Wnl4TTbizTLv/u5BBKbpM93ncOrC3pHEzm+hSbsUihplEq/mz7N8iiqFxfn?=
 =?us-ascii?Q?AvBLelijFkCiFRxV34u9EiGuUHLrFroaIl6iQe0uN6iW7UqM28vMrCILj2JM?=
 =?us-ascii?Q?gomHeE4ZfIyfIn7tLPTQLnavU+AfK5s642ZIbk4r2kf/?=
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac8f511-67a0-41d3-d243-08de2603a256
X-MS-Exchange-CrossTenant-AuthSource: LV8PR07MB9999.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 18:03:38.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqsqv27WZgyzKfl2s+qGpQi3IQuUyD1yP2KQy4Ki0Evz+xqj/xMW4GOzZ36902njedRi0a5Yip3PLn9J7cOU+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB9006

A race condition occurs when both unlink() and link() are running
concurrently on the same inode, and the nlink count from the nfs server
received in link()->nfs_do_access() clobbers the nlink count of the
inode in nfs_safe_remove() after the "remove" RPC is made to the server
but before we decrement the link count. If the nlink value from
nfs_do_access() reflects the decremented nlink of the "remove" RPC, a
double decrement occurs, which can lead to the dropping of the client
side inode, causing the link call to return ENOENT. To fix this, we
record an expected nlink value before the "remove" RPC and compare it
with the value afterwards---if these two are the same, the drop is
performed. Note that this does not take into account nlink values that
are a result of multi-client (un)link operations as these are not
guaranteed to be atomic by the NFS spec.

Signed-off-by: Aiden Lambert <alambert48@gatech.edu>
---
 fs/nfs/dir.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 46d9c65d50f..965787a8eee 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1892,19 +1892,24 @@ static int nfs_dentry_delete(const struct dentry *dentry)
 	return 0;
 
 }
 
-/* Ensure that we revalidate inode->i_nlink */
-static void nfs_drop_nlink(struct inode *inode)
+static void nfs_drop_nlink_locked(struct inode *inode)
 {
-	spin_lock(&inode->i_lock);
 	/* drop the inode if we're reasonably sure this is the last link */
 	if (inode->i_nlink > 0)
 		drop_nlink(inode);
 	NFS_I(inode)->attr_gencount = nfs_inc_attr_generation_counter();
 	nfs_set_cache_invalid(
 		inode, NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
 			       NFS_INO_INVALID_NLINK);
+}
+
+/* Ensure that we revalidate inode->i_nlink */
+static void nfs_drop_nlink(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	nfs_drop_nlink_locked(inode);
 	spin_unlock(&inode->i_lock);
 }
 
 /*
@@ -2505,11 +2510,18 @@ static int nfs_safe_remove(struct dentry *dentry)
 	}
 
 	trace_nfs_remove_enter(dir, dentry);
 	if (inode != NULL) {
+		spin_lock(&inode->i_lock);
+		unsigned int expected_nlink = inode->i_nlink;
+
+		spin_unlock(&inode->i_lock);
+
 		error = NFS_PROTO(dir)->remove(dir, dentry);
-		if (error == 0)
-			nfs_drop_nlink(inode);
+
+		spin_lock(&inode->i_lock);
+		if (error == 0 && expected_nlink == inode->i_nlink)
+			nfs_drop_nlink_locked(inode);
+		spin_unlock(&inode->i_lock);
 	} else
 		error = NFS_PROTO(dir)->remove(dir, dentry);
 	if (error == -ENOENT)
 		nfs_dentry_handle_enoent(dentry);
-- 
2.51.1


