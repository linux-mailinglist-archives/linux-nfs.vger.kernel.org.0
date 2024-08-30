Return-Path: <linux-nfs+bounces-6019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3299654C8
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 03:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200841C21385
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 01:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211BC4595B;
	Fri, 30 Aug 2024 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cmFpFsKq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594701D12FB;
	Fri, 30 Aug 2024 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982160; cv=fail; b=F/GBKMqRHQi4WirbUE5IcEW0nVTqt3BXhdnEz3UoeK08dBDWEAPz5eofgX1V2H8pTZd6rS9zxMZGtYP3yXLH1PaOHSlgpd/ofEF1aQJwLf1s1JWzqHXWutR6sy14Zok+pYSyv2Ll36ZHqy9oLzGbFW9aCZEWfwLvGfz16TKtoNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982160; c=relaxed/simple;
	bh=IA8BdYSZcKwSD/QJ09ZhxLP8VTUaEJXSZjdKW/PAgn4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VYZshBjcDpbMJYPJlTQHONdb3KrG8GpcabUOS4N715tc6bZFZG0Y3ZmQWJ1L4RvpwbQMMrnUS2Q3iOHB/wlsuIQPMjjmDM6R7Rc57zxRJrT0Lh/c4Gj2OWf6tNVZo6U4LC39yEO0Xy7xKqtpnY2LAmPTQ0reYIqy3Q5nQanbCLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cmFpFsKq; arc=fail smtp.client-ip=40.107.117.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFSOvvnLV/U44yEQfig/FoX5IaT8Zg0APHVHCuqNR+jo4fsaW1a6tJ9BuMecUPOdSMOdGQNZ4bhwwVHvfxlcqshke3Ha4GUNqSHHJo+mKSelCJm1UGRQYp47wjE2REfXu6MKKSIdkn/WdsTZMAwQ5Tt9dQHpukZ/wTmTaM7qxJ0NeXgeP8sjYeW/v8auz46RoMu5Vwa3virQJTPOWUbUTp78eyUnc30AzonFmF/neb8btUFSV+i2taAI0l6CCtzbdcWforerNGjGNHleQv+wtbbCV8+em2FG1A9I12oVWOLMf3MthTTgqEEDMzROvtabpLtwg0wckFqnqHOH1I48VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuvkPx55Mgq1Dty9EjU+XgJucwG5I7Xj2sITW31Jxcc=;
 b=Ta+phf5CegirS6KmscVi3FG1x0wI+4FdGp9/XRMZr6n3+4cQcF6OP9yjfIGn0yp2D7wujyN87MIFnUwloHaYByoD7ZfiszsZmslPUxzaPvugFKHbt7379tPGtAHqZdn5bohGW17+yjpEPekSR+6CgEwmth9kKqGhWvsZ23pqxnffsu8sXUkhPPkQapAulCLMdn1y+VeUwbb+UOVq6B1mOBqXPAfPze/sZ2wTB9P+CaDZLrEgnCU05sOsxXDWIVxMJVp5h/Es4x3+rKDy03Tnd+tYIu6/O/HIRzsFegVb01EVNdMLRRkVizUMiCNXV3CS3gknqn0n671i93oi6PuyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuvkPx55Mgq1Dty9EjU+XgJucwG5I7Xj2sITW31Jxcc=;
 b=cmFpFsKqxEdYMCDgpss2/ugw0YepzYHTBpJQvYp9E/tOV+hJmtB2LBhE8D+mZJGu9IQt/Nu8HnH0Vyj2jwRuWngKk6W+XF5BY6/ezxx7jRxmBNJQoE28S7kN6oZ3fIH6iiyd7n4rhRFmPHOiEgl8MztYX53Nuitzg9iAUENxvKLvwe1v5XPCwsbY9AoCvc8bg6zXcaPjpRqqWQwxSQhFO6Ppyu0n/gG5mwwhpQ5TgCXGuxFeCk4h984+mob8NDSEI2U9xGP21RtZ4DSiqB3U2mvegrWPdln7/UfeFSCmj6zz+Xvn2BR4/BSlt/DfUQ4C+RK1pkBTSLapBmgVyU/A0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB5968.apcprd06.prod.outlook.com (2603:1096:101:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 01:42:31 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 01:42:31 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
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
Subject: [PATCH net-next v1] sunrpc: Use ERR_CAST() to return
Date: Fri, 30 Aug 2024 09:42:16 +0800
Message-Id: <20240830014216.3464642-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::9) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: dbadecb6-0c31-490b-ce4c-08dcc8950343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zh0g400G63t21YtdWpmKhuUKntdOD3DlHdHFDlEnryKBFlRO+b62exLykgFy?=
 =?us-ascii?Q?2hvtvCrWTKcUaEDiJTw1ZXDlDtbvYc5iaAaFfJ0VJa6dyTnpp8TOvnQ30Frn?=
 =?us-ascii?Q?jXPYvnIRgHY7q4PtokkjSFGEZmUtLSNXLi4i5NMEhTp5ZgE6y1sSXaxHomUr?=
 =?us-ascii?Q?Iy0eL31GoiRZaiJjoS10WCj7QVs9GtgDrWX8tvPIofu39apt7Kuh/J7yS6ZR?=
 =?us-ascii?Q?vUv4VKNlVFsTpIDX8l2o598XkI0NGlV1T50/nQyqIHTB3XAo5aLQm6Z7EBKZ?=
 =?us-ascii?Q?N1fTJH5I44wuFWbrhjH3qNDY1eJpLyP0LnwImlJQluVkRjv7vyAEWLhaexWS?=
 =?us-ascii?Q?o/J/jBJn1gerNla9CJpoCTOkIVqkLpafQI9DDiYIeU+khSEZmqmrrONfBRnT?=
 =?us-ascii?Q?Ibhj9d/8ZKmlSHyadvVhpQbyksVkzKDts8o8zlLdBnC3f0WFVUG+pSWcJpAd?=
 =?us-ascii?Q?6wlpXNw8TV8/vtxkLzvnHEI7hO0GTyqmskO13HL4dpXnciTSm5kk5LT1bO9i?=
 =?us-ascii?Q?DWX4KnFWzyv5sx7GK0NbbioOmoeoSi2jfXUYg0AuykpPFRiOPfoIcImsxdSE?=
 =?us-ascii?Q?1LzyOlkjYA2YvC3mwhJWiHSyK+K6D6UfYB9Wh6kITrlwCv097N/HvZt7WvwO?=
 =?us-ascii?Q?xdtflYxsVvVxsLcwZES/kdlMCPHf9gj1Vy/z+YMEPG+3SMKfo0MKufD87HQu?=
 =?us-ascii?Q?s7bh8LlXWrG3AM0aXXEmN49RnM/y7b9hClG6jY2JAZRcvgOjO8WGm9yyj35/?=
 =?us-ascii?Q?SP0zaDAnsJgn1Lt7RqZOiCPln61b/LG4bfePn5S+nAiI0TyTdriStHvryt94?=
 =?us-ascii?Q?ah3q50reZhWo0WuINEzPQGfNcGCksRkWuN4QYeKVA8NT665KKF3ew64LJZXw?=
 =?us-ascii?Q?OFwJWx+XmJu9CNgFSNTV8NmLNa5dumr3XRLmTE97Y81ozDgGscdvkGZfHK1y?=
 =?us-ascii?Q?8lsg1gRxqap+VNgd5QUqg0IFNqeB0sV7/aMWdoUEcOYVroNsEaJRJk8iOBlF?=
 =?us-ascii?Q?1cIiT5eC0BNaYS6V5o6wRVDai+AJcjeShICkJzaM7w2L5pcOy0rxkH9DLoRc?=
 =?us-ascii?Q?Dk96oN9cKaG0p7k1BylEbzjzagWMW4ropLw0RlGFVYywWe1b/+S+b0pTBuy4?=
 =?us-ascii?Q?87OcR6f3M/ozOK8YTlBlFOMckBjhNVLssBoW7qsHFYX8ydHp0Hugxu5mPfDd?=
 =?us-ascii?Q?t9p5ZN8Mn0paMplpb/Ww773dV7Z4yUmf588AaJCYU5u14Pe1GjxjnhwTxjKN?=
 =?us-ascii?Q?/VN92R4QGUXhStOjJpCNUczRnDFvfSX7gXflPxlp3ZSjfLO4Wi86dXNsE8aK?=
 =?us-ascii?Q?ni/I8QDbOyGi8dzdpAkwfrBDvbclNP2iGs8DbdDVjMI0vz1F5bBAgVr82lIE?=
 =?us-ascii?Q?raYPrR/5Jn6fmsBF88gDJd7HZIISeE918gq6H2QNl3uBOPTcVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NrrjH18LpAmXYgYbe9L7zqOh826A2Q0oMh/2JfrRYm7QNEw1FLzmtsK9A918?=
 =?us-ascii?Q?0GaD8WfL/j02tgFiPm/WEs2ObRHktLbRFukc5a1wlTYnmypTQiHJpyO7klD+?=
 =?us-ascii?Q?XUmfDcn3IXUlD76a4E3uVuwPvWdX4Wag6nQJkPj+giKPMdKXswFrluNJvsAx?=
 =?us-ascii?Q?QqPs7G4B6WuaAXcuhwqg62g295OhcMnQx+VtkNcPc8xj2jlxd9ySC/JUr5wy?=
 =?us-ascii?Q?qKctss6wki6ZQSwQgPlOkyO7I1vLHmh2mxTt42Emce78rLEoxGIQIqbYbhD0?=
 =?us-ascii?Q?v6tca58mCty7ll2xi3LfrKXZBVKazXeom4BS3EN2Pl5+/iVqu1BM5yjl9icC?=
 =?us-ascii?Q?rg10fRJe9jugeZPE6Ej18H0cgdUxYoTG9AqF+pBuepin/f6Ee1NvRqTM6clB?=
 =?us-ascii?Q?Y8nkHZr+EmtaHhwhBua0k7Rhjiopnsx0P2IJR9kEeTq1h94iIq2cPte4nEVf?=
 =?us-ascii?Q?x56fsRmq6MNLLIDBt7IYvJLbmy26fWealZBy/xiNC2jQiSrsG+viONF6B8wy?=
 =?us-ascii?Q?v/96LOjdUcpurYRIQ06bg2QewC5bDag7gq4Bz+oDEAudfGnw7GkeOCZ9Tp8V?=
 =?us-ascii?Q?BKekNz9WwaJ+DzkNktvTYTNoKnIpkEQsroSo1TIrRt7X/z7cylQPjbZ7swTD?=
 =?us-ascii?Q?bkN5PindiKyHMm9PnyCR7k9m8+w1R/X7WEh9+u9dzQ1CbIguXRKNMFbk/O8R?=
 =?us-ascii?Q?mW4a4lv4pNEjH9xMSCjH1sKsU0BcY0QQYFHiFXVO7VRjys9PKoyhIEalWO1I?=
 =?us-ascii?Q?k0hgYuyDHsZwDlvTrG1JOCz2oHGpjpv9KIsXSx++ah1juUo7KstLJrlC8IKQ?=
 =?us-ascii?Q?baofI3dAF7GTngrJZkp7hXoA78SLRsPvoSmX3y+bASBlNua2KlotODDu2O5l?=
 =?us-ascii?Q?mX49h2Y4NLbHwJgIbLD1/ePQzRb5nAT4Y3ioZzNgWfLlpRIv7K4F+EIQJKfw?=
 =?us-ascii?Q?836wZMtgtvUafdGUl6QSZON2lfSW5hCAzxoYq9CsppOLJXUK7aJwh1di9AOe?=
 =?us-ascii?Q?t23fkKPqKCcVd2gq34MYLmVBRTRd5FqluNx2DgCwdr1OdFl309xCTTluNJXA?=
 =?us-ascii?Q?pYQwluIUw1zpEatPceLgFnVhq9A+fB9sshJPCAFxtTvWH3kwhpdmLgdtQelr?=
 =?us-ascii?Q?FQbqeVrdtBW5gRc68aPAEmOZzDLxyPKAR81oHeSJD2z0kbBjfxfSg4O5H+mz?=
 =?us-ascii?Q?aMjDEtKGp0NXFLgr5vGEReicr+7gG7BMrDovvJTTYt32HtQ0XKzDsE0dCpKW?=
 =?us-ascii?Q?nFxWvqeisenO23Gy5DpuSO7EqwHY7TrR4iDzHmMt0Bbho6RQZi2QTW5KNfMd?=
 =?us-ascii?Q?7baRH3qLHK2Cf6P3HBruQ6Nxgy6HWeD9PCE42wtaQNIxyVbfSvFuFnqXjZ6B?=
 =?us-ascii?Q?CnJYCyloQPtqS82+oKL2h/3NYYH6z80lRImRQs116dEp/u8AoOJWC4hZtu3T?=
 =?us-ascii?Q?OWj+KxJxr+1UvAA54OOQDzP8DIw6hzZq5mej712pfFDwPgDK91udH29kpDiR?=
 =?us-ascii?Q?xJLvQ6myfOKDh0ljYHWjsb+DnHInwihB9D1oJzTk1cc4iPweHZZlU/7Sj8b+?=
 =?us-ascii?Q?XS6RmJ5DapxYdkvWr32LCIKY4jLIkCgiZ0EXs6xM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbadecb6-0c31-490b-ce4c-08dcc8950343
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:42:31.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPbjiMfFIQ3eb6oEr6JdrVrcjJXkfO0QDCfGGyo7RycF381Nv49W4KQMQ0E60EBmmDg6ZotCLd7cGUzFccpQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5968

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 09f29a95f2bc..8ee87311b348 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -603,7 +603,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 
 	xprt = xprt_create_transport(&xprtargs);
 	if (IS_ERR(xprt))
-		return (struct rpc_clnt *)xprt;
+		return ERR_CAST(xprt);
 
 	/*
 	 * By default, kernel RPC client connects from a reserved port.
-- 
2.34.1


