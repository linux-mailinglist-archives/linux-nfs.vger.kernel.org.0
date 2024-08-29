Return-Path: <linux-nfs+bounces-5947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6B9645BE
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A377B25CAB
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082901A2C3C;
	Thu, 29 Aug 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jlLpbFs+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CC1990B5;
	Thu, 29 Aug 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936731; cv=fail; b=pUvGRTLhcKbgxtwIYoRrOL/5KyfKyWHeJCFxh4OOdUg4OC+cna6dZw33LcnHNWf74XdpcvAB4qqpLSfQbb65y7JWOL8uEJc1ewyufnvJnigV7V7xOYdo/xaSwu/t+obj893L0iAhfpladfsGa0bQccLBD/Nwydjle8FFvKxWTIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936731; c=relaxed/simple;
	bh=o0y8ihTfbGEl22MwuIzeUvD8LKfoRdtCY027cC3lXQU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qj5Q6ovFNB3Ew/eoy+WapGgWkRFFI4x/eYprBBtn9WfPFR6mGka/VoXIW/agiz0ZqgVGakCf/Zfdm2wW6J5s+byj20WarRXjEHzCwt67zKe0vQmJEEjCQhRDtJwNDpapxY/TmhWQDWOT9l1ZO4XNN2Po3Dkqag3bH4QK4At4COo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jlLpbFs+; arc=fail smtp.client-ip=40.107.215.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt4pOnwmzmK6n0rE8fYLwOZgxouBVN3NNduZZTmsgHOd0eXrD/OqUltbhA8vPEidHSa81MTwZLigOMSnB7KBRfe5Y+QHgVOWT75O6vsJzNuOklgnR+tVXJwyleO1FjltELTv9E5GQYC0edfERrJ8BG4dyAsFXKDpVX2SYtq9PcxDkhQrgrJVEHEBPeFeSREDpc7HsLqzjQNe/23HP68MYBWUAq4D+e7kzG3HQ7TLrFt4iDIiyEhWW2Ww6MucVobdHeyrknLkvbb6Lgu/U1Tn7WX+9GoG+J8P4gAAKNXziJp5YlgO3ilyClhuBF17W4hMNZ6Cl6IxcMwL9SXQvalaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/cQNXmoWE8mYnCLOiBiWfMNomNO2KehMhJm3T+Tqns=;
 b=QEIboG0zBpYujhhf+6IXC8YM0oqSoHoG2Ab8o6J/kBgSZiZgLkgbzo0x13Mgx99oXEX7KgbfejWbuI6NdM3ng1AWeaiBnmGrW/7B/mhFPgfKN9OwAkX6NjiJoD5pWLmCXWWI1nLsZcZhlD0tvyWU4O06yF1hGqW60fcFyF2f1esikSKBJSTLjdd9muiYOK4D2y6xCKrHKtq26nnbzATHMvYhA7oyaCA1FxK4cJeuH0suQXZo9jLbgS9EWBE0YXwioyPfi7YnkLH1GdSKR8sa+n/zh0n6q/OW2fiHzoqeZ93gtsZkHkAtTtGPVbx4iDcUiQ7ff9fXCsslaaKOJQJrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/cQNXmoWE8mYnCLOiBiWfMNomNO2KehMhJm3T+Tqns=;
 b=jlLpbFs+N+lYcr2iiIfZ1SNYZdXgHqMD0ahYYSeKoMUjpsh6kt9rN+xu0ZinlK9Eut//uMg7peIOB/kBFX4DmQsT0yrSOikEukUWrKT0T6RDZkitNVXFhAFrdcRE4yUqOx1B8UCE4btJE9ITOavf4tm1DzGq7ZfdEsJLTb9uKfCQjNeeWEEpqf47q52cCEbaKC5kFm5R03EpOUT8U8X8Fiz/Q8+KK5Y6NT1m3uXnYcQ/pdW7dgEkgSUMrCGbhDlcU6pYb3pu4VL/jmiN/C3Lu7NKD2yChxrnIQ3Q0DYGEiguhjfqqbaP9CNPgi+zeaRksiFbgBJXxN/t+IZihd3t2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SI2PR06MB5193.apcprd06.prod.outlook.com (2603:1096:4:1bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 13:05:19 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 13:05:19 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	neilb@suse.de,
	okorniev@redhat.com,
	tom@talpey.com,
	Dai.Ngo@oracle.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH net-next v1] sunrpc: Use ERR_CAST() to return
Date: Thu, 29 Aug 2024 21:04:34 +0800
Message-Id: <20240829130434.3335629-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0230.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::26) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SI2PR06MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: af1905d2-1397-4a71-33b5-08dcc82b3b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3IBxfrmVDnl3klp7W8jjcLEtl5DnVx2EnBeoerfSr95m7CITo/nVFD7XZem?=
 =?us-ascii?Q?eT7YAa03EHCIoGksNvoUPPfX07rZbiyFtc1PBw37oS6mBxupZSyhAVgV589a?=
 =?us-ascii?Q?RCbb4vZ7Egz+BSFJYhrNsndtsfkI6aPIW751vbMMpp08f6TkAw08K68w2gEz?=
 =?us-ascii?Q?U63TKSUab+fh16z1UQqGQ7X/TrwXZ5znNZcRXqo8DMTtT5RGPk83OX9J6PBx?=
 =?us-ascii?Q?qThhSgRYBxYw01kcQUWn6C0htorlSMKkeBYoqJcXre4jIMIYBOwdYo8ogtpr?=
 =?us-ascii?Q?Hggxt3ocpjtTXyqC6HTfTamZMKHur09CHehsczSsO47B2EHrLbD1p7oMHgqc?=
 =?us-ascii?Q?jks1/P063uPSStyPdZPwhNjelegf0+PZ6ll7yb7trMnLdGL1GEjzIM8l1e42?=
 =?us-ascii?Q?lumWA+s9oMGk7rRzN4pQ0D+sYBvsZUGq2RTiYeQpOonoejhT8/Ov746XXxjF?=
 =?us-ascii?Q?IuS9+Z3Voz8B862vga+N7OxXzOi5UyDz3QOorkmJvd59Y/Bq9f3H6QeVPbcU?=
 =?us-ascii?Q?cji6uYKusnAv5kFgte6EJInmm7G8EsqAVEc+oMqMjuvZQChDxVkxFHLhOuWV?=
 =?us-ascii?Q?/rc+csWAHb2blkqE5yLSexTMpbcQ04BcU1iRL/aFsJuXDWUb/GBf1J4Nhkjf?=
 =?us-ascii?Q?oAqLJkhE/tU2PktLxlPZr5JiVIcOy78rhKawfck9/GVKA8Nhq/MgD+vJDdBc?=
 =?us-ascii?Q?Yjt2WMQAFZd/edaN5Pd/GDrCREDEUqDLJ/pdGMCO8FXGkrp5R2XIPHHemAvg?=
 =?us-ascii?Q?gs7YaKpuX1ZEEFTEabUCO1yOfaY4AdbC6Xaq7c5Fts7CzVawQ5Yf3N07B34C?=
 =?us-ascii?Q?eDBd9Uv5nyyRH8olfjbmQyraBkoFunkH+lJtX6VkAMtRDkN+r/pNTciTpQ/M?=
 =?us-ascii?Q?wocU/AJt8ViCS+lQ8QMVIKYkrbci+osorUoiz/AHOePYaJwidQrWVwHWM+Ww?=
 =?us-ascii?Q?7NSOy4ed74pWzmbJY8Aa7BB0yjoD0OuDhVic4z5QrARn0BLXhE9tHeJtaF1d?=
 =?us-ascii?Q?PYtzIR7GQGyzsA52V9fShE/BTJeIIJXU/NZ0zEzbXzHTdSVEkraOL9nRF7Tz?=
 =?us-ascii?Q?jCTVa+22mpuLywI3SR2qBrsjdSuI/2TCa7MDL7Tfm356XGqJxGhxbhodhnom?=
 =?us-ascii?Q?3Bnt+HOQmIMLK3JKvtwmC0Aaxpu6p3MvsWpdCms8K4gFNQtVIZnfa+bWMZfR?=
 =?us-ascii?Q?cyo2UgDwKYq+06t1S7E6zgDEExNso2h9ZH3rwkCICxvEa88GWp8OzajJUWcD?=
 =?us-ascii?Q?fGuzJdU/vJsk0dBTPcazSpLsQWBFHuyBa2PgemHw/ze8duDL1k1Vf9RRE/92?=
 =?us-ascii?Q?O7relNLJQfmsTE5Z45ESbWx8WjJTN9q3GrtvKC+s+i59mNpKSpQRfF+t+tRR?=
 =?us-ascii?Q?uXtTvqjhsodsAukht+HegtxaArC3gqGLrt7dlovq4LZPOAIrRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3VnW54JGwn3qLJ11hUCEVqUOqZkCMbvL0+B7GirSBDA8PJG1+j0k6xwW1/eI?=
 =?us-ascii?Q?+54+aOgfVN32zwvQN5xUV/GsvCPzaK0Z7CwnkzC4U994nisHYwS8QLRkBp6n?=
 =?us-ascii?Q?RXhVNXNof8BufZvBCZR43fyQ/mws3/e9BcIwPYqVHVJgtZgydh+P0HzD1EP0?=
 =?us-ascii?Q?R4eXkkKhLJcilO40BOCvChV/B5zedF9VSLGGedQ37xcllUbEvc4LxFehIrCm?=
 =?us-ascii?Q?KYeKzIymoZK+eYusdVtC/45OJIG1VDo2/q82rJhQ/W/QQFcCkJA7yPUJCGyN?=
 =?us-ascii?Q?y+1NVSovVb6ync/ZIh9lk5c9l/lY9szRaJGFlvvIYbw1Te/Mb/j9/90rkuYq?=
 =?us-ascii?Q?kudn8EEgQJZKb8bOkIx3Nc/vN74pbVVnD6jfaUUSIUDld1iK1MtvCOSllqsD?=
 =?us-ascii?Q?+tIq9GsBX0/MstV1fthQbK7J6wfPMTF+TrH8ppa3qaCa4WyB+VoqcpgWg9d3?=
 =?us-ascii?Q?/CWrm8dblfSKJWK7PtQmp4Tyv86sWIqqcdLa1xqYndWmhEHcMh7GbLOxXHQo?=
 =?us-ascii?Q?6vGXWWDV6Y1a7QPYm5O//zVUtvyezK/5Q7PhJs7h2fef7aYQiH4b7J3p2rG9?=
 =?us-ascii?Q?pi/h+waD7oHFEAq9qquOHflKCqNUNjjeXQ+wAmPPJ7FeZtYMdsSywV7jhJw4?=
 =?us-ascii?Q?HvdQTva+adcpGoU01OgnV5GYA6kI07HlvZv6jNZV1xqx1HHR24u6z9FOUPFL?=
 =?us-ascii?Q?U0yTCbWXSyppUNt15fkNwJuzTMrYghQvL+giYGZ64pLqVyX+YjcT96SnTqZa?=
 =?us-ascii?Q?ugJ5Au8uAwlfMHW98G84Vb4yjMkgjFad7BWIUbDSAowwyYG+4f6vTbf4tUrN?=
 =?us-ascii?Q?Yq7je5uoLqTF1UjkZsEUxc4Dqw2Te+ZzsA1eBZx+KSMNR84vjxkX2bEHZ/Uw?=
 =?us-ascii?Q?2dHqxIfs3/cTLNoJHvFJDGewmQsWJI37N32YODlcrQ2RWtGaHsuDIE2bEkGz?=
 =?us-ascii?Q?yKVX3g2ISpuxZcJUw2Uc2PKsAQEECKHIrzCbZnvYMYeuP6j2xKecN7AssBQV?=
 =?us-ascii?Q?69emOMhBAn6DMFYz9xm3lZa1q0H/zuYy/wJrWEzStj++ObwFrvmbASKPRlgD?=
 =?us-ascii?Q?XZuwWacCX24k3LEY6x6FVcCuaTKrwUB/DFT3af/s9N6fWlTqq77YcRLI7Up6?=
 =?us-ascii?Q?h92CYv3vCujx7ud48eDYXPp1R07uUFtHDofkSCZFkg+Q1TsMXSHj9VikyXgX?=
 =?us-ascii?Q?FwjDJZ2rEzTgaCYowQibdr+xK4/dpnrWoVDIEDa9bNBAyxMe0fVeHYvN0r4k?=
 =?us-ascii?Q?0c1d+ql+4yxz9LlLngZUi8+ozdeYEsbNDjgfjOlJggYvTP5XtP9igzTt7RpI?=
 =?us-ascii?Q?Na8fDc3T0zLL7nnnBFKACBaIrv7rx4yt2SStX3IwDlmWIXwnqrxPIr1Cc0R7?=
 =?us-ascii?Q?V8njlJBE4ckJawkyNwptC0pA/rSH1BlOHtG5XKnmRKCWsFssXZxmn57euHvt?=
 =?us-ascii?Q?LDAMhOHS65clbgFaceyxJH0R2ltb53IM/uFh3YBjetDY1vwEiwO64NWOAtOS?=
 =?us-ascii?Q?5E5jPMsyCB3gku+scnkcXIjhxaTRTCxmiFtdWkSfxZByqcP7XWLCWL0Zo6vE?=
 =?us-ascii?Q?eVuSDd5Owq6f5fLo/47L0VO5je5KT/1PNdIb+FFs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1905d2-1397-4a71-33b5-08dcc82b3b99
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 13:05:19.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAKI5WlHFw0DjijJ+j0Pixk8URFR12StOMpOTNMPAZIzgDX8MS+h4Lz76YnjjInnt7KKIQdr/5e0GC/92fpJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5193

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 net/sunrpc/clnt.c                        | 2 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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


