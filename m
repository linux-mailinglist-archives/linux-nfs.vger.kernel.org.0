Return-Path: <linux-nfs+bounces-6021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E7D9654D7
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 03:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0210B1F24143
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B044C77;
	Fri, 30 Aug 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NGPxusMZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2068.outbound.protection.outlook.com [40.107.255.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8091D131D;
	Fri, 30 Aug 2024 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982415; cv=fail; b=gDDdICdv9kmDlbiplR6fKJw9lIJHzInH5frLuKzFjZzKAaJobUnZJYUpeL7rk1FbXNL4/rYb3teGPmWAW+J3/qp/vDCDPgFD/74Bm0YWNzX+iNpnXwR4Axc0LY8IrEL6QvqiEIbS15LyVqYL1BLBmCSmVfQ/aLM8ODrFhGSOeSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982415; c=relaxed/simple;
	bh=IXsj9CwF5FL/EA2mYWDihxvV9o7JUOrDcMOsPuvBC/o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y49PGcvMxxonXpqiXdimNY9GYGljcfiS0LZr2zbd4PqcADiYHnBetl2VIvdehbEwaEwEZFh27Khn+n6cHeGL3w04sBSmyO1vEz98hcfybGTRZq7ubtuzwOOg+H2yJM87JBRpaiu6/nPbl0vprvuVZ+KerYc5w44jsqWps8d21K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NGPxusMZ; arc=fail smtp.client-ip=40.107.255.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npILMjPRpOg5d2mHOVh5QfWrEa5r69bHnpJCa3tIvayhrnJZNz3f+I/L+9Tz5o6uzlGzyzgwD4dxWOY5yJVFhJlSu79DUaRbLjyt3SYTmwSvtz7MobyZYLu1QQNKa7m1OxXpulHMwbot3WifytoyyMPPJSb2TCSdLblHrLt3CEszkeir0E+VpAAk3lYzGBLkUQoWceTfLAlNv6X07RCzu43xHowi/8n2TsiL3ZfxSgyLPITTsuMdkY/P++9RbezNJeOUWLdU281UWZL8PsM/ChIRANgYcNHLAfV5bXxBZmLyGjsOE5tMxjsg5znD6RUfztLKwU+NV3OHpODw2Mz/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0ZrTu2OVI4O8FydlgFTjaxLDkH9BKaGQu55v53/0gA=;
 b=A7yxA/iNDhok0eAoUrX6nYeZ0nuDYEG+meLOd1AevNCg9fgwJxU+fvimOTFUnYakDx6X+Ynt5DThDI2oYTJzovH4Cj8n/8BBQCkxmZkaCs2qdmUgm/RutDfxgD/HzHQB3wxvMe9Agmv6VSd+zbizMTsNpO/XbzczuP0vp6m6/arw21p/YmUzr+6I4KCi+YjkyCqamTe4HBiCEchMjBBmshbhKmXEZ7ARqDTH3SMqO1ObYB0TcD0KDX7xKvtHVN399N+DezTUsJ4y811aC3TA7sGr++PjylO1I6kM1SThkBxap/Nj8/AsXiSW6hUfqgmw1zqbjVCHP+ZUD0/hrLHckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0ZrTu2OVI4O8FydlgFTjaxLDkH9BKaGQu55v53/0gA=;
 b=NGPxusMZk6oluv39wivQZd75OmzyNnzc4N+9NcMicVWlsfmv87vM7wVtg/+adXbuM4k3TvoqYU4Yhbjn0TdZle8UNRxgJhGj33+rdOlUFP7mE2VJtTq8suyHuiOp8ec8+edKWZuoDLskz9kIxnpu+nbyPCePaRH9DReCHTcE4LHYM4b8Y5fcmGfgyBOXly0TKVyG+Mdvp1FIvKejNn5XqKXMJbG+mRpMTYi/xnSzQMmcHKnDow81GDRz2xss8/0Vd3Qn4jSCyAtS6eUxYpz3aitzqd2S2SipxbcWgckJA8mwECNKQe0P1mOh5ndORc062vHKIxbBp9w8Qcl7lE4JQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB5968.apcprd06.prod.outlook.com (2603:1096:101:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 01:46:50 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 01:46:50 +0000
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
Subject: [PATCH net-next v1] sunrpc: xprtrdma: Use ERR_CAST() to return
Date: Fri, 30 Aug 2024 09:43:56 +0800
Message-Id: <20240830014356.3465470-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::13) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 447acee2-4463-44ff-1c71-08dcc8959d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSR+32PUxvkmqZS7tVJOlD2yi/JfwcF16BmwxcOdNsVaqPLSQ/I0Le0vxkNb?=
 =?us-ascii?Q?2yFr/xbfwUIiCCkUnhPk6yy7/ZiXtjRF7uCOsrXhTqe0pccDAWoezEz6Lprt?=
 =?us-ascii?Q?Sc81ksmwsKGur5LsGdsIfS79r9d2g7OUvWCo9I2NUI2mgwXaSDeQ+JtUXnBJ?=
 =?us-ascii?Q?hqxvGESHjlY8eK4DvQimYePLaGPkl1MRj5IZPJVFxI3Jl6mCFzbvsaof2mIY?=
 =?us-ascii?Q?Rpc+IUYjMRLZaOcJskWyMELHd5tILjvR7neW8CG4+u0ALv0AcIdGLhyCwNpu?=
 =?us-ascii?Q?woD+1A+gcprx3OVfAc5e5S1hLjuZ8JeWEBpFDOpI4ghU6jv2D+CVJ5fAudHW?=
 =?us-ascii?Q?3Cl1OGT8q8iclU3G17BDwfiqcXt1BcjRqraOt5XJ1M8Q9/7R3wL2147bPp4l?=
 =?us-ascii?Q?BP4aJ9rFBnk2gisH2PTdqL3WWe4SLgk7gGdBROAji1TRdjrb49yq5nheD11x?=
 =?us-ascii?Q?AfbzRq3vdhEZVak64jZJVB8A152AgA0U3p8AyEOl7PousTu76ZrIVvJwDPhm?=
 =?us-ascii?Q?yFQG9lV2H37r6fqLNdo/ZujSBuwVwSuIEs23ttYopAQIaOFwQ6gNV6ziQLEQ?=
 =?us-ascii?Q?508YPkSlzjgwEbnfaUKIaA5/RtI73puzwqQsZ8V6c4BbTzx8QLDyi8cXdBV3?=
 =?us-ascii?Q?SWyk/KmgkjBcEsiG7cy4ufIYynqHMZqW6kYjA6He16eoC2v6xNr0S+GjBMRz?=
 =?us-ascii?Q?pEWfb/zfuk5663UoUf5YsMm/mJjWoWx4AlQgALodv7FC5PZ2LY2bfKpjZbmJ?=
 =?us-ascii?Q?sw5wMKeyWFcQLbRJS05Fbt6xoy7VIDcAYnDJ26TgSBaATBdLz7eHpw8GsLsn?=
 =?us-ascii?Q?PqZVtZBmZppEmNS4ihNcDkSrk7hk8nvorWlDzy8ANYmibU8Jo9kd/uAFJS3C?=
 =?us-ascii?Q?UHQAs1FkJe6eZ6XeTWED8j0ajj4jJ1h8QxdOrJEhiDK61lesIr8TlNqasRgm?=
 =?us-ascii?Q?6IVzlzYKityoRjxcOlxyYfJ9OUVexFC7tW1NgHk3UdVDNEzS3HmnA9IXbMa7?=
 =?us-ascii?Q?s8dxgkm4zBNcK5PcaC0nq1JaSevfpzc4RorOLsofc8PQMYSnA3nvmKJfFDH1?=
 =?us-ascii?Q?VlPj7BpdY1hop9zoBtOkvPN45plBMuj4PnmJi1//h36Zs8Q1S6uzEjr+UcqI?=
 =?us-ascii?Q?YAjgQLstnQkiEcCOGhthv91rGQOsIVYyHl7aCwyacU36MEJHtwcg6OGc7aI/?=
 =?us-ascii?Q?BLzkp7uoiap2MNHKPPCI1C5YL86EKkby1Ste8XYM82tu5NWrXn+kDvWsSBZh?=
 =?us-ascii?Q?oQ3eROcRq/02K6nrmxvcoNyHI+Tz1Wy+IYxtCB23wSwmW5iTfzOqiEqK+Obr?=
 =?us-ascii?Q?J24PrWaEOiVFhfK+gpuNLs0LpjB7s7cwbZUawP6L+TQLLeGnnoXvylHjR7oi?=
 =?us-ascii?Q?Xt5TwXI9FP38//aP2PToysOKNzPWjpJ0t9WCelHkfdzj8Ih+/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWomgxzl6wERChvDjH03RT/OKd3RSdZHKCh+VSVvwJfZTtxIgKf5gWjOrq2l?=
 =?us-ascii?Q?T4TPQWe7j9Lv3YhZBeEWFkM7lVc+IUoQjfhPJfeFfLX8sLU7XCxf6RwSI29M?=
 =?us-ascii?Q?RH35lUSVsenszaP6EMtc1wINHYcXr0b01ug+SocuczR3yii51D1flXfoeQCK?=
 =?us-ascii?Q?dgPRcm9cQ1fgAZGyAoch1IwP/I+bX/HTE0nj0zvibCk3XMiXFUPmzIT5vpxe?=
 =?us-ascii?Q?d9qRMQi2EsfZz8n5NYq5ZYDALnmrXvPDEt/7DlBCXTIp9gB9qPmWOimCX/Zq?=
 =?us-ascii?Q?Xk7a/AJ6HRcvmxGLNkA51xldHC5OlzYKGFnE+faFOR0zthvcvk04K5cRpqXN?=
 =?us-ascii?Q?RnhXdW+qUd/YeaQshHwxYAWTX7kM6/w0Kxmy7ky2RbZPA5vdktAcxDccpajC?=
 =?us-ascii?Q?jTn5Tf1s21g25UHLlyCnRLS1pfXNqKPeesnzN15HgZNC+emgbmShrNXzvjDn?=
 =?us-ascii?Q?WgVNqu30qg8XextWXhlln2pitXoO7aVZY1iqtiuc/Rm6cV/+jdBFZZeXRrKo?=
 =?us-ascii?Q?SUri8PV7g9y//LZ2n0HfPkCwjb8kRUzjjctBPzhOTli77+jQbNIdZBOClYhe?=
 =?us-ascii?Q?QwMKS0Ic6Jp9JRDjomejpPHs04ZNtBPZPvf51EBNo1hTc8fzZwICLJWleiHv?=
 =?us-ascii?Q?3xOs1AGF09Cfc5e+FfVpmt/hGMGJYM0Rn1zjjEQrK0WKh03BaiRfvgfxHUmr?=
 =?us-ascii?Q?R2YNudrBZXjPqvr+I3tPu1suzskg4JjLTB/9St/SfUgtpN86RzYbz3YcxKRm?=
 =?us-ascii?Q?R3okojT33KK+q0u3Z8KGlMR+SAK4wyf1+x5BZ6GTlVOc7TrKfC9zgBMgtviQ?=
 =?us-ascii?Q?INKmhJBMzf3yhUMyjrz6P9hzfw/f/6G2L4x/x0hlqggonbsRne/EBkB6QR7y?=
 =?us-ascii?Q?3Ss94yz91RLHa53MFtYGaBdLVOyWdpE1fkvg/Dhm4Uzs+9ZxkiVIERWGySgq?=
 =?us-ascii?Q?Wsw1PGAWeQh7kkeiZoW0hZqVsjCWTt/5Y8RiszBeEbIkL4ot/xLbVyF3ojqN?=
 =?us-ascii?Q?X5gjxQgEg2C+UH3aij92Ghl4Eo5GVfJtnF360Wn5BEyyYGhcuuBCmmPxns6k?=
 =?us-ascii?Q?+CekDbU3L+ySPsPuoRivVzgZcJ09fA/3sxBQY6kjfmz+1bNe9+IGoRVlhfQf?=
 =?us-ascii?Q?qsskZtxH/zM77tW2Cq4VisOQPyf7EYq1j1mwbxv40Ew2BgP1VIwSqPo/vOTL?=
 =?us-ascii?Q?7WJyIvugpHFpASrR3aLuyaCuJnjM1WqHIUj3AyCl3yl+hLbH9bTE61QnnU5y?=
 =?us-ascii?Q?PauFy6jjAJrYYmgPBemPlzqjBKdU3gF/74KkpoKaUKSZKnyA9wEOWul71HdD?=
 =?us-ascii?Q?iN8kFd74ghFR2L3JeQFWI48iCmYOETtjsQB81DpgW6CrV4t5OEjZf91RHEOf?=
 =?us-ascii?Q?7q9AT/mhSQupN5n3ZOsNnwEDTu3JB2FwONv47jXn47RCZ0mIGgQufYZRA0Kl?=
 =?us-ascii?Q?QxzeHq+iRWaseq54Pacw9k6iVnrcPAOv2gzLv+skF0Tl3OKogxAbb4BfUVo2?=
 =?us-ascii?Q?rKpFFTcOgNNBKz6Z14T0b6pVyAo+TlLm+cnsV2+BXATO2o3T0aG5CW94ZIrs?=
 =?us-ascii?Q?TKaV8+4Nw+It22QDoV9LS9qE/YK4fsslVf1U7PbM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447acee2-4463-44ff-1c71-08dcc8959d9e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:46:50.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7L8T1+UtzG5unHLDEK6rEb5b4Nk6naaCN1q57gqJ2suVhRUOQWWLyi5tDNUW+e1uDx9hjwgb9XamRvwAFDHqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5968

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 581cc5ed7c0c..c3fbf0779d4a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -369,7 +369,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
 		kfree(cma_xprt);
-		return (struct svc_xprt *)listen_id;
+		return ERR_CAST(listen_id);
 	}
 	cma_xprt->sc_cm_id = listen_id;
 
-- 
2.34.1


