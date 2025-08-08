Return-Path: <linux-nfs+bounces-13491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E591B1E2ED
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116047A5854
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886EA22A4F6;
	Fri,  8 Aug 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jbyS77Wz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012009.outbound.protection.outlook.com [52.101.126.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B52367C1;
	Fri,  8 Aug 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637319; cv=fail; b=i50K1NtvpoYJaNABZftOfG9uytKizvVNVuxtQV6FdwLb5/sKLRuNyevSyN5gc3+WAY7Q1xLQYLrhWCgg3aR2eUKpnEw8LcRAFM1rI7VvrzasUEdQrJKRMAUIgFzSkLHyxNX56HpoOUhWuTi+59Kxi0XXDBV0jQDz/VDMQgDvRUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637319; c=relaxed/simple;
	bh=XuBnGouStCy7p38WSACWgvWshSJbPIECS9QcT4np5GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ki9VYrkqgOZtKMNvsLUvr9LCiv6E07RujyGftTLV7MDDxlq24CL37AjBHLItj3flfVX1SShB9OL14zWMDhkAylSlC1XRjjYiZq38JXskVPxSjwQ9k8UJ3uEWdy85PcpqBdmZJHPsfbttAbM4BF+0hac/+lQgUCcP+GBffasFn0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jbyS77Wz; arc=fail smtp.client-ip=52.101.126.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHUeb4nJ6pBf/YbV7aw6QFplV98QDuysSo4brFvZ9mdjUNwoh/FiNlL5I9LLXQvkaGrZlhVboyX9mieNsmQ4X59on4lXrDcLQDm19bL1UFDtVD6UfO3M+azXhqz9YbynmEUbk9QcRMrwn4b7WNoluGpkes4i8bohJCDKUQ96niyadL5gma+Fdp4GmeqpTBoeYBYHwCmd8ZSa909zXuwMzEqnKnjwNG+jfgSFKpNHUoRZLm0kQTe3peGlYCk53dQRH+gj6gmhVIes+LQIxP/EEtPU7/1DQrilsz5pvwBeGg3FLtnYqy+QXpwwEtMQz2SratvvdszALUcpNzjICGtY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfI8qXjpcK4CatclsNQ19TCXdcxob5GxYhlWg2CEfiE=;
 b=iQTFnFD8th4l/QSIPE6Pr1sC9vTp7HA1ICZKDVf/brcKxgUzsBcAtteMPSd5GrUdDFVcAp0/UZbg/WJqNUVtXbAU3dgkcATsM2t2qU9p7xy6uZF/cCcx4w+5TbNxzd4vqStRLpas5WnO9o0kZsHA81znlHVqQZO0ehSsq3mz5/TqxN4ZI5L5UfiZa3AhfVN6uL8FHhZGiHOoFdfZGcaFmbWLjsm6K9ifjTG42F65xvJuWmhBk8qHbgUG9i77Pgmi0FcTtkIW2LbXGwp6RaTUTM+NSkJXtBiaHjQ1+6JOo2dQhrSLggVOQKihtw/BgY9hAKyl8d1cUpILH+hESrb0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfI8qXjpcK4CatclsNQ19TCXdcxob5GxYhlWg2CEfiE=;
 b=jbyS77Wz2NOw4ZGbNJNX/f5Ob9AXBvcXSHpv2G/AujitLstYlhiVpwhUZFcn/wyqxuArckP8cWNEO2BbAjd/RWuNivvuiFB/0ihc1FstuN43qO/QEMkKwYbr8vo2fUGBnbjPe05x0rlIcCn5XHfuanj8XZLmxpGoH4VJdBZshZoVmN7wdef1VlVlU5xd87GCQcYmrBHGxb4w9xHDTp9e9vHUhvUWDWdP90QkEbnsex7QZysi5BTokLYSF8HYc0XEb7epslCLVPAsmWeYSVblc3iF+BnU/K3GxT1jnJD0X7uGFC8i2svIm9qbYrRBNO5ypFxI1uJbS/GH9VqGtdLq8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6463.apcprd06.prod.outlook.com (2603:1096:400:464::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:15:13 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 07:15:12 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 2/6] NFSv4: fix prefered -> preferred
Date: Fri,  8 Aug 2025 15:14:54 +0800
Message-Id: <20250808071459.174087-3-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808071459.174087-1-zhao.xichao@vivo.com>
References: <20250808071459.174087-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 207cd51d-d2ce-4b04-0611-08ddd64b509b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ucTl8EWQ4JYyept3OkRR1ah5DGmTdwuX3zgWIRq6Ye6SAw6dZi+TzJnnzDct?=
 =?us-ascii?Q?ZrhBlSoQtXzAnlPpDVlLSAu3T7TzzQiJbdssrq5+7m4WS9hHvRvpWz5P5E1f?=
 =?us-ascii?Q?kM5YdEcH8YyCOh9naPD6XkbZutb5cl6yo26+iWKCsi9jO0VvYu1I6fRtkE+Z?=
 =?us-ascii?Q?CKL+9Sjrn0y8rN9EYnQ/Yfe1heypis8SUSlPSsryOkkXzd8GRfJ5sbWG4h5+?=
 =?us-ascii?Q?pV0XPvu+JYxd6UA3xcw12HjbOOOqa31XJXZdJ1bQjyNhEjcFBdJ1B9wfFZYn?=
 =?us-ascii?Q?UXhyZoRG2j38ZkqEdVMDsY3fOnlnbqp1Wo75676wymgDMdFdr4L0TUVd7qP2?=
 =?us-ascii?Q?CAiT0zxZBleBfLmSewefj4JyLpwEps8j0jpBfJ1sQosr1wdf6GSDnJwBeCbz?=
 =?us-ascii?Q?awKkJRRreOhgKU4E0Xx9T999DlaPmB4Vsqo+kTIqf/zF8g/+WAgPTwOT9j+1?=
 =?us-ascii?Q?uyfQ0m6dS5jz9H4vGEjXnvHlnXheMOEPcjcbvtNrnqNAhqrAkN3JaRRihg1v?=
 =?us-ascii?Q?P/XQ/vItvBOocqxUR8x5tjIAVKu4dR57k3gRTk+RfSW6MB25KaiT7ieH+Q+3?=
 =?us-ascii?Q?xtnmgAFaPXyF6aQ634SJ6TZI47exZQKL1y42vygakiWBEDpm7wOOwM/HmBWn?=
 =?us-ascii?Q?vrjmRyjNZVWwR/K2Sx4cbGxxIy5V1mNLUmGx4ywDzmdV2IQch/4JT1QtZByO?=
 =?us-ascii?Q?C0gAW0GjiLVzdhEgN8HRXTqruLjZG2Omye9H/2/OuwvPiNFRywkD5UaUv9Tj?=
 =?us-ascii?Q?8RcWZFMXFTLUf4P4O/hNO/W3dsl8EGxoC5BHGpIDs+FFbIL+Y1Zx/Q5w1eUJ?=
 =?us-ascii?Q?BqJrK+ZAoYUPEd9m2wy9KqmFuEmHrJfhUkk3+Ilq89C+4P57br6dBtH0sKDZ?=
 =?us-ascii?Q?rB9EHZUlMCkxttlzHWJeHvag2/96EnccLxkV5Bxg2d27BTtAsFdq17Dzddk7?=
 =?us-ascii?Q?6yMZI8/Orf7eIme86SJNi9TgCbYDLIh5bUfDLcxo1y+iG3mEC2FBw55jAhA8?=
 =?us-ascii?Q?Mi+xfQ2CQeJhgOkDDg/+mR5GqZ2mVsBs1RjHJ5IvzGQy3R+vKNrfqy1yk4Tr?=
 =?us-ascii?Q?85uCQZn5nSGOoSMfqj+zZz+ko6hcJY/8BZ17ImrcdXuNgWZjfrjHo+qd4NRc?=
 =?us-ascii?Q?MNBIU3uySjE1qqJc/x8+PDPugOcSpPKkCiXXimWlAhR5FQFmXR8TS0G8M+bh?=
 =?us-ascii?Q?DS9aluf/XNBk/DTaNie6pxpE6AeXZxgRXM4KIgTQAx2A3NFkY+p/BhjjGpby?=
 =?us-ascii?Q?MeVRefX7pREUD7GbrwhN8BlLHUtYsRTjpDBm+au0aPVojaMs2rDG3tfVh6OT?=
 =?us-ascii?Q?+qWdIUgxo1OHSIBu8wXatSiKsu/CZVKFNSPMJSKCOmjQwdc1dql+qTLIaxnp?=
 =?us-ascii?Q?wE0QUsyBYa5+vhZkpUBWo7WS5fpTBKSqV6/DiwxZBpjP5WR//q4A7hzTGUDP?=
 =?us-ascii?Q?oW/K/YR/rr5IBiaz98q0nI3cuqg/cv5PQvvlrh2dYv4sUdV13KHuTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQrs6NHgbvWCVmeZHvo9+v4GUa2RsYbrbFYOEoF2b1ZYmKDM6bQMmBWSH5VJ?=
 =?us-ascii?Q?x8bTHOQdsVeVilbDZf7yYSpzuOb1QXf5oPDoy6k8mGTQKkBDVyo7iwZV8uat?=
 =?us-ascii?Q?e55eFZP9giI5hIHnN4ciYRn5USCEwvzrH3kCnCBHcv+XCkl6eO0mA2/i8VXd?=
 =?us-ascii?Q?IDK7kl7L/tyUsOEIHRD0ylKPHQ3ofip9XpnMvgO2axAf0/PEcVq7tQTn5IM5?=
 =?us-ascii?Q?kzSGnrq7ptHmtPhK/yVdX/r4QKrMif9nHh1r3CHYw3BPZePVJoKJr21qL2A1?=
 =?us-ascii?Q?AhqdEnz6ckRk9Ib5yE6DLgyAEFbC3o5Gp0KdIJ4AHhOClwD5mdOn8nwJccD5?=
 =?us-ascii?Q?1oWv56DAvT17u5/SToTFMH0nR4qwiZSlBsEWod/1izX08gUVDXj6nyuNgn3/?=
 =?us-ascii?Q?p/U+EF65Kh2jrEeT0CWvIzHcMugwMDq88CIuebEt4C3K1zVXc4m+lwRWxrmY?=
 =?us-ascii?Q?17q8EpPKActQIlDfqxMknuaXbqhADjIAzgWqGXEpJ49GftO5ZEhBj0fs/f7L?=
 =?us-ascii?Q?TNi9ocWZG+qR/S2aRQtX1Iu4Fbks7eTZIPbUcMLypHfsHF3+/hFVNGa9AkXA?=
 =?us-ascii?Q?hyRyVYt0zxCRrPxGW9fimKUsM8c4Aw0jiu3MIfB+5h7hGLImJunM5o9pBPu3?=
 =?us-ascii?Q?0ZSBgz079pyeqO/suZGmfzb6b6EEuw0ReNcuYjOMSVfTWYVdoeK1EMRLJ9r7?=
 =?us-ascii?Q?p1r61KHm5HHo8eT8sJgr/tQMGUPfehAW7KBO5pYYGJ5idwjYVjD/Nz37RB+C?=
 =?us-ascii?Q?dkcX1OohYe6q7QHKIuBatidSdfE78N9DmxbR8h5nQldtvmrfl9dEGxf2g7ft?=
 =?us-ascii?Q?jnYPSIL2kghj9Chroy4hFKEH1wUQgHQDsV0vWvdC881uAOeeEQr3fNr+kPBd?=
 =?us-ascii?Q?8NDVlHyxYYKbzlUCVZAXzIE0YCq65Ufx0w/tcensKXFUAmdEpriMuF6oAciX?=
 =?us-ascii?Q?OYvvHgEIDFPtlTh0nvIAV1zCJ6lYRz0A5DbtxKBgrpqZug6WlfHYA305YK2L?=
 =?us-ascii?Q?CveZxpRncdleW7NVFUbZpdQbNNCcvjJ6SyyBpjN7qvFVoTTMvj20SbAsx4pq?=
 =?us-ascii?Q?rEm5b9VmmUARq9MfyUiKCTDaTmgF9bRrEFzN+8Jx2Nkq5GpX9+39Hq4Ti9fL?=
 =?us-ascii?Q?6yGEaFoVgsjkteoo+N6f8CdgiHTO8h/J/vvxplqhzd6lDmBIQqsv+YAq5xqB?=
 =?us-ascii?Q?eayDQXDWfWunn4gmXLiSIhbRSKXbDKilQgcd5bQY/hSrrZ42KAGYKedyVFG5?=
 =?us-ascii?Q?5hQb0d/wk2YWQ8zM+oB4KWbUPYa6rO5l4GIGpbcLTyppu81bOo5mn6FNag+E?=
 =?us-ascii?Q?2klS2DmI/71JUrXCwRtA8AiW5Fcyp6JKMhU5Ml6Orz0PfBkHCV3QunIqe/7K?=
 =?us-ascii?Q?WZTHodAYMtZY6jT2MfdpY+8q8WIE8D6nxKQ6WV40lRKa15kLYgcAddIMFtyN?=
 =?us-ascii?Q?pybr5XDI2inQoEB+n7zYcDa7UuylQx11CoELbIGXVK87C6HFrdVbxNRWomNl?=
 =?us-ascii?Q?j/LVcpTqU81EAIeoLhtoBRlbQcd8KoMYVHctiY+sIgwc/6fa3/isbkqBwz1B?=
 =?us-ascii?Q?skL7OwvE9FZarvxzUrX2hNCkDTIv60jtnAGhmmEH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207cd51d-d2ce-4b04-0611-08ddd64b509b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:15:12.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnfjSyb/wGqWlQhDXbyUpg5lN1/+593nohtEyE9x+gNSi2/KeuHc+sCnk5R5jASo7x3Y35GiRBePPkVG9bMzig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6463

Spelling fix: prefered -> preferred

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/nfs/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 49ff98571fa5..4ee88a4c1daa 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4930,7 +4930,7 @@ static int decode_attr_pnfstype(struct xdr_stream *xdr, uint32_t *bitmap,
 }
 
 /*
- * The prefered block size for layout directed io
+ * The preferred block size for layout directed io
  */
 static int decode_attr_layout_blksize(struct xdr_stream *xdr, uint32_t *bitmap,
 				      uint32_t *res)
-- 
2.34.1


