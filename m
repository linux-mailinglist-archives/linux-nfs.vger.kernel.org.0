Return-Path: <linux-nfs+bounces-5719-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31EF95EA01
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 09:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C11FB20971
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C2A86131;
	Mon, 26 Aug 2024 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T+WPA/CO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F1376E6;
	Mon, 26 Aug 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656192; cv=fail; b=KTNFd3ApJhMda5welSJ/eCmlUs/8wawUb9/fgJJxzoQGcq2xWJ2rGrtjAyBYDL+dhqPyYWgP0mKSpjz4VxqkNE5kSYIe9QRIdulDytp9ZSZmqzQZGrK9WDvoyk64xs9fAzYvEWaNu4U5fpNqpuVS8plPOieuf6NGH0/irsF99WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656192; c=relaxed/simple;
	bh=ikyBGUT6IPvi58Dwf74zS8Reinc4SC3yiabHLbfJlB8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FSDTL47hsigi7hO2xGq0j9TAZJd9BLnhdBAcy3cqEP5E9Tp+fLPcZ9DejDDfK90K+8HDPu7N1NndXj9MSeDZCEvELbLdb9+6wDqzGZKN9euf3nc6P3odkiUwk0PE8byIc16eJsDywRcpErCTSLg2CXiT4UnqotycekKx0pGOjI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T+WPA/CO; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHu9AaoxF4RJcEXmJgfW36x7NW75Yvj+1lRkHj7ogSnW3NKm6i7raXkTAP1I7izNsY+wPJfItd4F8LV5s/KTo4kRHty41WW2k/ocnPjCcrEP3VcGfV+Kwzgz21rm5wg4i9NQJ9LthyKGwfjATuwcRRymyrJORXRuFQ3qpssRrYAChNAV+9Y8krIBfXjp7RPReCIudfScrR5ugWrQcYb8AgC2jqecmaCiWRiKcMn3kh80U2S+QpZ3TC4l7zihgcbcDZsqnwxygwRHC4JJ3239PuN8PbpBxluXnYSorUX4HnyOBTFkvBR+dQcQmPgzA/+R6uPC+VEfUqPsG4tUdIfJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Phkwk+9Ax+xylsb5pcd5+lmHlhcodWaTrzxH4TBQ8=;
 b=NdciGrv67JIfLSAMZHEzTfx/VhTvCCIxfJJ2RyyJAKorZyUYq7HFiJD05bU7M0ZZ4VCXJQ4q+NV+2upowQ6FVrRJV4DqupNNUogrUldZK8lm7v9qeFUnHn3fmB7g+0np8Bt2U+1KPDrBvY7NjVIbP/LdKS7Ib3mSu6ylcrizabS3Rub/n2sxNz8SU0brD64cV7V45XFaEcb48pOhGaUi7q0pTgo/hQ+jLL8xWPzB/sBJh4rUnf6V4s7yCjoyQd6njXms6i6g6N/9ZqfOzUIwPLaq6YXVPTdlPhNz/92k0JbqdcPNps7LsQI0HfxSOvjIRIDHiMGulBSp8ps8Wanx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8Phkwk+9Ax+xylsb5pcd5+lmHlhcodWaTrzxH4TBQ8=;
 b=T+WPA/CO/HLKhJFJcpiDquOUv0PC3pLAB6ySZgnMX+1gCN4vuSEz+ZiNr1x7Le1CHxJu1z2YWTbMk7ja5J5znlRruU6iOjFzqgWPrgnT2F+gvLSurPs996O/OXqhPIGvB001PG+Gx40mpfFYpGJEhP9QeB24hJ30ik49N6HlYXJB2lhBAIbOYaq9tYdFk41+HT8nklVYMCWWI7QROusxRGzTvMGQx9StjIyAgC+qo7esJtYeWQOdCFPh5Q5dF2aYNa13opUqp9YcGyfjmnc+DbvGbQNON9BzCVntOmAkNrX5UOaTMsGxq8On722czGSSbGvAtIuN6GzHx65/uIPXvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by PUZPR06MB5825.apcprd06.prod.outlook.com (2603:1096:301:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:09:44 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:09:43 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] net: sunrpc: Fix error checking for d_hash_and_lookup()
Date: Mon, 26 Aug 2024 15:06:59 +0800
Message-Id: <20240826070659.2287801-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|PUZPR06MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a7a78e-4a81-4d23-2e96-08dcc59e0fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s41g4bkkszfzOJqHhsEM9YdvbuNjl791fivQKROVJpB2JVXJPUzBbnccKiIi?=
 =?us-ascii?Q?W+AQr2jLUuhWxJ+5J+Mj37/dZQb6b2on+9TVKOFGSGVj/mE15wbW03Gixz9Z?=
 =?us-ascii?Q?ziRu4bcIG+rf4DKo9jHS65M2mb2fcMXkDHzVwjAk7xmXvTVauMhMnyS7uDa2?=
 =?us-ascii?Q?P0imOvBgYSUsK+Uf5a77WBlEfeKvbNYf95GKrWosACiExnUIzV8Gq3krN5eq?=
 =?us-ascii?Q?4Tu+sDlwyT00NedOALr0sFCq28c+kyBoepoLCie9hy9o4BETdVG1js0thERP?=
 =?us-ascii?Q?INKnn0zimiEI2ucygWCZVzPBkJsnRMOo/3WkyLsRCEwGp1stSbRhwyC1V9x7?=
 =?us-ascii?Q?PuSaNcvxPyKjHLPbgAt2mILg0sniwiKZDap9sPoeW6r7IiBU92TUD6C0Hb9b?=
 =?us-ascii?Q?byomOOS6bf2EGQuSN/KMdvxpKIK0+n1oEue75UleZRpy0jp0ZwzsWoGt9NfD?=
 =?us-ascii?Q?7B3aOzEMS0sy0xXd4hQhj5LjdHv+KKfai5tVqKuRZcwQghxWFt1tD5xCVdhF?=
 =?us-ascii?Q?bHfDIXeQlvVRZ9utnXuairNSDretvsI6eC6OlgMuMbS4d7lrc2dPmmxR+bPu?=
 =?us-ascii?Q?dG4kO1OZ8XGDeEQdMUe+ItTT4RBoy7qDZktqOMW1yGUxIIxtS+z+IfLhXfvy?=
 =?us-ascii?Q?u93ZkNSnLBD4FXjcpRH4G1u1/Nyk6D68ks6NdhWB9Rg0s6bOio9Ahbs4cvJ1?=
 =?us-ascii?Q?MuejUpUFpshoK7HVc5gYmC5hQs0JRkGc3wQPeGDM2z6yeDBtd5iGnrTuXyQy?=
 =?us-ascii?Q?uKnIxnYrDVWtPQSkiXbZCudC1XPaPLoeqeujaJPaEWEb/GCI0dz/64XbfsFR?=
 =?us-ascii?Q?5kZcVHzpSRFT+1dYumCDdflmczz3YZ+Nzr8GIInsHgcmeJH4g27azjFauwqf?=
 =?us-ascii?Q?y8DVgypBcUreLrBsn9aZWeJ39crOrA6Riq8S6YZimRq9DfiY5XAWDdQ2lm4h?=
 =?us-ascii?Q?oWPP1tar+V4nPCblwuXeOiH7wfxa2lJIiSR6gWsJKf8w4181fbn2AhmRQi2a?=
 =?us-ascii?Q?pfr2tKVJK9QV4RIjA7DshjVwXt5UOPSTv2IC0dBqMtsXi4pRNNy7QR7LAD2g?=
 =?us-ascii?Q?w3laXbsbs4kcjFSH6yAjNMK4T76NO30l9T7lXvf6eDp+/lDoPUQgnWhjOZbt?=
 =?us-ascii?Q?neb45RKI0MHW7hClZUI9zjAzSCrCuD0NwZ7HIWNyf90MwkHvdib6U1MnyKh2?=
 =?us-ascii?Q?crSPRbSS/9G/yJxImEbTEljWIwZ0R/DQ8Z+eOJcPib5uwotfLYXvyJIe/x4I?=
 =?us-ascii?Q?C/Bkc841fjmhk5K4xB8Qrsjm9DfCS1a7j9Pd95QOgDTeYYzQdh1JPtvrtHZP?=
 =?us-ascii?Q?A2lSG98w8UyC5i9NW7wsPu8k/Q3JwMrbVoeedR15L5tCifvCNQGuE6mXQmjO?=
 =?us-ascii?Q?+U5zJ1EsQ0fNStRfv4GoIdCb3LD7MaysQnlLocQL7V9TiA2rvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qOqhVNieRMaWS3GfmMWdHHK+StKQ2yzHF+4MEs54fXjvMJotWhwlOhPpbtGF?=
 =?us-ascii?Q?evlgeqT9Ppg3qEL32SzFR/dcOnjteTCYmJv7z6rlZzLMOqQlKr8acqfDA3hS?=
 =?us-ascii?Q?ogOu4dRFa6z5tSQNmPmohSJwUITjFFTEdW8r9AdXU57K8xigNDz5egFrx0Bq?=
 =?us-ascii?Q?j1HJHXpafQSMUCL7X1iWtpP1f/poU+x6lP2McorNTHnASA3UzrB/Kt5RyKqo?=
 =?us-ascii?Q?BnNBxFyUytvo5ZqPAnfEpGsRJXwtcpDBLPTF+xCR5UOSzOvyGAr00ohxKfFw?=
 =?us-ascii?Q?cJDUtW68+YnPGfOWJWH+u6VivUqgwwAvKjR6qd8z8siWjtfzTSMzfYCiE7MA?=
 =?us-ascii?Q?VtmyJ2v+fsOQJQz7UUSAY83dsdvFmahvjZPhmrUB3cQH9VNRi4ZN/Meul/pS?=
 =?us-ascii?Q?q8aCt304bnM5gkzNzstospXo0HKh0gDf3v0jJo/ThY4aHp92clqQQhkHYVXt?=
 =?us-ascii?Q?GsMoUCtnvoIvjYj7rfJe0JLYZdWi/k1/F38H5wskS1pjvx/OQ6jrjE5CKSfg?=
 =?us-ascii?Q?AFNx839XARml+zS4pl7y9Z7z0aO4wKk1IGAcnjkCjSL/vqBWiNqDCm8/NqEW?=
 =?us-ascii?Q?fHOAJO7VtQbENBa07cekox1p+RLgLqCfwq/NtStRSE/quCM9dkfgs/QcaSja?=
 =?us-ascii?Q?OJIo338H5XW7LnerHKuPiG8DK55GxYgm9TvUfXzdHBkGpNuDJTw0HO6j1ve3?=
 =?us-ascii?Q?bQCp33aBMXiEi53lzl73FLkXc4dDIachSAWlIHZjZL79ZtBkJCWGMmLXps9u?=
 =?us-ascii?Q?OrG+fdb5SVSXRG9las5mUVzopwzxD318wsAdVI9uyJ6iWNWRGalwZI5FIPP0?=
 =?us-ascii?Q?91TjWKET1HTWz615I6wluWgYGfZOGKtfnyafVdmqtYYYkfiqRHp9r2Ee6gYf?=
 =?us-ascii?Q?fMhXAFafNbYrMtWYOluNOYpQbR9GrBDwL3BbuqkmPvjekA2ND0ehSoh+vkN3?=
 =?us-ascii?Q?wzLMf9DH2UHkTW2aRyJZUusI0m1w4Z6+0TTHWhft4rxZWjo4xkxg1YpSxMq5?=
 =?us-ascii?Q?OcZc6/OMpv1tUy+VU+Py4Oj/ScNsEYk6fxlL0fse6ZvjNKDGh04LN+ppOa7a?=
 =?us-ascii?Q?no0uut8sXxBy/fDlaupzTTSyqIGL49RocIuUwpAfCU7gT0cU9JYowYBlD7TP?=
 =?us-ascii?Q?xkqXgtA7OvVN/bnaJrZG7F69gophllzkbl4UeLqBv6jbZDvjh1cfjnKESHbk?=
 =?us-ascii?Q?qwQfq5qVUNpyOPk2nR0MKia9bTIur3+syolqh7ZfAY9z8WYJRfo9+o9ttZkz?=
 =?us-ascii?Q?uzYhFkiQoQtfoP+PkQGPC+hgE20qu4uh2ymaxa/NjtW4m3+LKUlWhW1AutRX?=
 =?us-ascii?Q?Dhb6w+ukvSlIc7fxVQb+SvXDD8Fk4y9U7faIYv2H1cR024oUHm6U9V8wmWNn?=
 =?us-ascii?Q?/lJ/WtpsBKd5SiEKD15wVq5dzlWlhLc7KDWIwJW1vSs1DdSzHW9qBAYPn+WF?=
 =?us-ascii?Q?mu4Tls6DDhvWsDC3JXS4y17+2Xk7wqR96Tn/0y9wta0MnSWeyeT/PK8N7NUq?=
 =?us-ascii?Q?qiGko0TIKrZjhWqt0NIicfRd13oHCMro1xz9+pXKmQJpz+rxuJCueSRHPX2I?=
 =?us-ascii?Q?L1H7EyrM8U+i96hPR3wH4R5siCQ+V0eHWujw7Z4b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a7a78e-4a81-4d23-2e96-08dcc59e0fa6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:09:43.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VrYsBDqICxjHFlJDpEQZxv2Fo/jPPjT0Las22YxDMdQW5l333ndrH1tXzKkHDGRRLnabdTC7HgpI4HeupPAYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5825

The d_hash_and_lookup() function returns either an error pointer or NULL.

It might be more appropriate to check error using IS_ERR_OR_NULL().

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 net/sunrpc/rpc_pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 910a5d850d04..fd03dd46b1f2 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1306,7 +1306,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 
 	/* We should never get this far if "gssd" doesn't exist */
 	gssd_dentry = d_hash_and_lookup(root, &q);
-	if (!gssd_dentry)
+	if (IS_ERR_OR_NULL(gssd_dentry))
 		return ERR_PTR(-ENOENT);
 
 	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
@@ -1318,7 +1318,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	q.name = gssd_dummy_clnt_dir[0].name;
 	q.len = strlen(gssd_dummy_clnt_dir[0].name);
 	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
-	if (!clnt_dentry) {
+	if (IS_ERR_OR_NULL(clnt_dentry)) {
 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);
 		goto out;
-- 
2.34.1


