Return-Path: <linux-nfs+bounces-13574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D7EB225EE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 13:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D1816960D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243B2EBB97;
	Tue, 12 Aug 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nnjCBjy4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013021.outbound.protection.outlook.com [40.107.44.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360112EA17E;
	Tue, 12 Aug 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998461; cv=fail; b=jNTOy50tjLcVZydf+BDccGWnXCgG9ZSGRtLt2CjOkprxPd8gzzeF0cMvsPP2XwFvYaebkX7KkFsU6EfoPfcLxGsa3maCnkWfFLp7osB8qAtPO/bDYX6sNkA75cEa32P6y0EjUErmivgfqRESrLNX3gD2aQdADRGp2X8Y+YeycWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998461; c=relaxed/simple;
	bh=TabD27GdXHONyENLSQtqHBbcV4tr9PnfjMTkED5oLRE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=o07KlMwPB650H9PsX0SbdDTaHVEXNAkBPnIEH/jkc0GlF6q1vg+PjQDe+6ZTXruJnS7jySlgXwrkCFiI5uptZIOB2YqnRIIxpsABp1/EMjf+QRzjo3QhiHpjbaaQs1eQ74z0amW8NYtsZF71pn+5UVhFIBccBA9n9vcPEVgPv3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nnjCBjy4; arc=fail smtp.client-ip=40.107.44.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGFrrX5wlF2BvjKkDWJRXLP1lLV9gw/YYEbcsgGUiIwvf/DZ+8VAZfFLgDCACCf20xi/+8DFe3TS1e6YxdMds810aytIrE47CeoE0nzwRh3UbXVMQpE/c1jm4WkoeQQdGgn9c2E6sk8x+I5dPNJK3htAxvKzw9sw5bdTwCUcBzUQVZHIwmswG12W9mJiNvE+vQaw5+Do7UCyoDcQQYzoeDaXJZ3xssbUOJsBG34wjNRhZDeJNoqQ5FNdxfVCTYOv5Iw9KM+OkdJ09RUKZdbpxnG7kBePmOQIIT/bz59sfpmzBN6f8iS3YLtcOY67AB7pr6CAHyAnyQ3pdKiJqjW1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IwlqlZzNq6ayJ6w/WuOr+H+M6ru0ciLcn/hjII2nxg=;
 b=gYQLpIV/JLRRqjmOEJC1WypVIfGuiVhuZhy5Y210TWxV9ILb7FJSmQ+pPA042zvWGzeSAZuk2uxOIBqFitzbSWXnlYATznjvTlBtDEIwxLhxv5orwi6/48qRBJJblIFydQvQ4jEml0dNPLK1UKL5tIOCeQsHCQvpdpTMxqgWb26ILt97pTth34181PIuzAEjYxlU1z+ph33hbqGtKZ0B12tGuW5n218J8nR1/k2eROyCyTHfwUcl5BGaRhCW2U5+vdIXezmm5b6Hw9dARLi++J0EYMWZ2eG8hn2wEYn/Lmy+HewPIefeBdHF8shNzzWyKM0Q53Zkwl/D8YSOvCgqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IwlqlZzNq6ayJ6w/WuOr+H+M6ru0ciLcn/hjII2nxg=;
 b=nnjCBjy4YK4NVmuBjmSrmcG7mNnIwJXkxIo9AJHcWYZKUWAwGbD/BSAVjO2bh7/zjumQ3hO6avh737wimdq1bVJnIoGw4x2OFNOvzXnv6PwnUDhB0KMGfEjZ7l5DFB3NWBxl5EK3ZgzcEVnAoXroVc9S77bhvqb5HnEinPzHEvwGHGWZURMlYm00MthOqT5A6NbaKUuUzbkEzVk3fn6y3hopbkM6k+mQJmjOQkDO+EsRMCy+pAyQyso1++8IbYNK5zAEnBF5dPIg/TySRoWzcLI58i1HgF0CXtkXx0gTgYBaZFu5+fDfPfq4NYWR1GPzomdg5sgDKixa0226myK4dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by JH0PR06MB7107.apcprd06.prod.outlook.com (2603:1096:990:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 11:34:15 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 11:34:15 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	horms@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] sunrpc: fix "occurence"->"occurrence"
Date: Tue, 12 Aug 2025 19:33:59 +0800
Message-Id: <20250812113359.178412-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|JH0PR06MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: a5eeb4e7-0f7e-467e-1672-08ddd9942a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y2SBBYMwl6utJnEsCd3FVpD++8phSBN6lISXAQwOrGh4s/PYVoasthDK+CRz?=
 =?us-ascii?Q?F4NoPH4xTTL6mZJIeQPuHvWK1OI8v8s4LeaHUvUs1YRmoPLuwR9B8dDIjWsZ?=
 =?us-ascii?Q?JmyqgEd3zo1l9FBJXhLRIzOs2MmPg0cX2YnODwQHCvc+7VWWks8hPxvkVtrt?=
 =?us-ascii?Q?YpwhY6ZZpDkw0b8/Dw6tI2BgqVbrkNQp1XV8cSVHvlkU7/qq0NLs2v9UWjD8?=
 =?us-ascii?Q?k2DqklG+N/0G1OOGe9Rq7FTvYYEsc7v546OyQwM1mnqIhepj/PeyVRPrPgf9?=
 =?us-ascii?Q?8l9EC3ovgm1pgBxHRxaCUk9k3WedfeEuaiVpRsRbFVh6xKHE+koCfYl0HUp+?=
 =?us-ascii?Q?9LSPZJefZeCee36TcccDG9iQFfOSRMYutQru/hWEx8A7KsJTGtScKyHbSvUJ?=
 =?us-ascii?Q?vfrXoNBBVimF6JJkA4z2ZsoGS7x92HcJDRPo0AygPcHyQHdgjaSpgu2TMJsL?=
 =?us-ascii?Q?tr+5ybl9fL4cbNqJpvzs2akT58FyxNZeoxiG1jsWBgRErzoHsxm8k7iVI7Bj?=
 =?us-ascii?Q?OB09qYDDEZOLISwUrG/w8J3919IwOFdSN7o634IMhqWjdVH82CZyMNh/oBHG?=
 =?us-ascii?Q?YY5+9TuAgEzqTfB+zaG8RcfyL04MyWu9oUNu9oPtQimvtjdAzcVzGwdVBbSn?=
 =?us-ascii?Q?BT5+YiFb9DhnZpP0FkVDFzOkL+6SbAeE6Hk+KFcWpRCEenr3LVS9GgoL7JrE?=
 =?us-ascii?Q?rJya/AfONaj8d1Bh+SNIWFwQmNvyFfx7UP4xr6ltuIRYmLFz3dvdgY3AERaL?=
 =?us-ascii?Q?f2d3R+ZzQAaQxUoUABiCLKzbs8827mqI+nWnaJr4CPvWe9B8wrrAzCMepAtn?=
 =?us-ascii?Q?8F4ald4XisRCJt2DQTNEGlDEFEI/vjTQSGxhoYrRHhhSAR5MkXVw8YuiS10T?=
 =?us-ascii?Q?Joerqgz5JNYm5A6hb5rmcG/JRDlwv7QTLQXnyE++p5ECN+I7HBLnOvJpFAah?=
 =?us-ascii?Q?YHfMiRR/Yatateotuf2MaVnnNwsjLWbKcio+eLfSV9pySntNo/zTVrvftutc?=
 =?us-ascii?Q?NcCSwQgQ+8syOj3sdTP8tUxYFj0lYDroB8TJGHUMtkEZM9S4vvG2mRyYTxHa?=
 =?us-ascii?Q?dvbiTzy4CpL2yHfbzor/OQ1PXorl5ouawAHE0zMN1I8AtJrmGWnGbPl+NqFo?=
 =?us-ascii?Q?n2QzxLV6K1lFjoVUGUk1kw2GEzji8Kim2AuL+UjzyoFcMECRV8n1U6etSUCQ?=
 =?us-ascii?Q?CQRlF93BRgWlCSUZdbrO+HZkDW80a89XKveSdeWYFR3xINo2ZLXK5w5NLeO2?=
 =?us-ascii?Q?qrNg7IEZhelfAsOO5Dpp78bEED18hCVb8iyorfqgl/lCvKritmvMaDSHVe95?=
 =?us-ascii?Q?qWvQQ6d5x46KrHZf3LSLd2ld77wtsUOn/DZarINsz03iBK659dsLJoHFvfEW?=
 =?us-ascii?Q?KKW943mahp1mxjlKhlVUwZ8w9gZROxe5p2Oz9+ZVeb4+8d9v34bW0A5EZZoq?=
 =?us-ascii?Q?QwlbUsr0THhmvLwcp3eIU7LnXp3b114BFCyxHcAX+w4pRlvJdjSwcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Okotj3mdsfr82qoDk3sDmtOhwt3vGsiDRZTdpkvCSfusA85jHcWBKRuW5+iV?=
 =?us-ascii?Q?rA2bLboUroq5+rrF5lu5yweMZ3HJMfVL9avByJsMPIV+L4svScYZMwQT0TEx?=
 =?us-ascii?Q?4xfrVRuJduMUbcucRqKQyDYFMH1ExeQFXf58LslF+Ek4JMVqyN/J2s0yJvJH?=
 =?us-ascii?Q?HjaqNo6hf4KorNaSXPwUJHx0d19DhWLqOIiEGhhhueru3aW5NMsGeHJXYecC?=
 =?us-ascii?Q?8t6ndgLc8emKtxBgAm9yaiuGBC6aQhmI1cIrN8axszE1gMT4RlMYYhVMtjEE?=
 =?us-ascii?Q?RzHzp8wIHamjmndX99NRzISRINVvV4DyhBcAj140V9qt2pO9Ht78MYTOWO2Q?=
 =?us-ascii?Q?OqeokDwtRG2NGko/MIP8T8z5uDG3JXbjM6/cfwBE9/GnK1VynYE07QuZBQUt?=
 =?us-ascii?Q?CG9BzfJL//rORhJ979dL6H8QCT5/mXOlfZbaRg55wktgqodCoFYqs93+Yxba?=
 =?us-ascii?Q?k9MbFeimoxI1pBZHybxa36loyaDo3N2q5E0onENZaOn5x7RwxFA8MMIRbxaE?=
 =?us-ascii?Q?l2uCnsKUQBtfQSDd64eXrrCuw5v+wmzp0NfanRhvGPtH/ot+JkA5J0m16BP7?=
 =?us-ascii?Q?r8FUfm2j28hgoAS6GGR/1xemHKSwUYvOUy18AXdnkh7WCo6IlpTy6YW+2caV?=
 =?us-ascii?Q?gyNoDbxBKZIQJF7sI+hCv/lpGQSbCRLC+vObdG6cVrz7DrLFNMzEDcZAd4v+?=
 =?us-ascii?Q?zyYIGdTwi3GhrBUS9qfagJPoAhZk9TIlrp+IYyVV/5ioojIOCiX3UvEZVJCU?=
 =?us-ascii?Q?laeuUcAD1HpyHX/PPzkhFOW6a3Ur/Jady6ADC7Nv0yC4SqdHS/V6xuGjN08S?=
 =?us-ascii?Q?/dkNomTBi3lIwm8ruzqUAtNPTI/J1r3Q++hTfeOFnx81Rskb2IAYKhh/h1hH?=
 =?us-ascii?Q?X+8yOHDRol9Trwr+YVAJWdEmQb81FplqnI+QcXF0cwKJ3EXf5ejQKIPUhtUb?=
 =?us-ascii?Q?BFjwLdFvbmMcJ3a/EBHebDFjAOjIHAjZ7Vb+ThOttUKqu5TGzrkrUjyBfTWq?=
 =?us-ascii?Q?m5ZKKwqY5/uGXevKmjEi9j9KAligyarwaqvh2IJACSKpxqFMnnLEuvms/bYm?=
 =?us-ascii?Q?/muuJbY/Tipx0aJ2end4x2rC9i5BNgTSStX9+72Gvjt2VYumrmZUSrCEtTnB?=
 =?us-ascii?Q?MLOL0qlV0UYPh/j+reINDB4jtDixA0dpcfPVJelgqrGNApFjUvkxjDOOIGiU?=
 =?us-ascii?Q?YUexnI6MJ4cWDzUl0fdjK9tyNDKSSb3GQ29vEH940I4T8s/HD5xh/S+j5XL+?=
 =?us-ascii?Q?jo9B+d8dsGqHBL7u18UDtobE900nKdQUdCCHbtL9pRz91BVzGXyxVKl94gxT?=
 =?us-ascii?Q?m70GzyOFjbOaOe4qgc8LtAp3DHxsEVxgjatfccWfiUd0bgP6l6BQIf25hDyI?=
 =?us-ascii?Q?E1k1+eyHi4qOvWQx/eJUz45gJmR6sBxGT7a//YR8iBaAgyQ5us2XHuoWTLmh?=
 =?us-ascii?Q?OmsLTiXxwL70/ABkfUdcgWYMqT/we2JEcZgoLglQg9tQghIsHo1D/pJQSdMz?=
 =?us-ascii?Q?yWh239I7BfUlrmITAPnMY0cSZ8uQGmuNqloc2qN+1S4uKIsEVee5gzQXDMOR?=
 =?us-ascii?Q?a2MIr6Y8ndS81mdDT7KIcpG9OwZHl/I871UyIFpA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eeb4e7-0f7e-467e-1672-08ddd9942a8b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:34:15.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajs8SpLS+QRZ4GDd8pdaz3S92R2onFR6M53lfEh0Tb0Tu7Hy7nVQquyc6eSlhmIMytWC7vLmftKih3RrH93Z5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7107

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 net/sunrpc/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 09434e1143c5..8b01b7ae2690 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -389,7 +389,7 @@ static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 	saddr = (struct sockaddr *)&xprt->addr;
 	port = rpc_get_port(saddr);
 
-	/* buf_len is the len until the first occurence of either
+	/* buf_len is the len until the first occurrence of either
 	 * '\n' or '\0'
 	 */
 	buf_len = strcspn(buf, "\n");
-- 
2.34.1


