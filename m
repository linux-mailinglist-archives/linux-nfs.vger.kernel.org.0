Return-Path: <linux-nfs+bounces-5845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC0961DB7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 06:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B376A1F23C64
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 04:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44A31494AC;
	Wed, 28 Aug 2024 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kjsHOBCx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010032.outbound.protection.outlook.com [52.101.128.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16973145FFF;
	Wed, 28 Aug 2024 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724820315; cv=fail; b=gvMCak9IpWWlwCfl1YOfY1wCrnWlogMl0Eh7IEJg02lY++9M/uiNKdwYZDFo8F8RkWmShZKy6hmpZRR9ggAo9xJdTaFAs5HbWyZg/F27y77gcoGMhOkVTAEl0gZgsWX1sdd2BeVDsDenxeCETe2mMtEPZ3p1MfW7G3emnNUp+Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724820315; c=relaxed/simple;
	bh=sf9e1KBmSef2TpMQ6VifLmXnK7G9NA8CaTWEBcXLSZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=baD1RB8/YtfLKP8InwtWYYqfLDtUNlnFLL1GqXNmqrb9A/iqg2rlzVIF84+0QAjhdnH5IMBa+se2xY/tajMSs2twoH7pWJYmIgqkGzgPlMvhmM5FZlgNQ+uG35SibH7IPwyk0Zl5dq+ulCDOYj0Yk45FO7lOaeoSDiO8ZrQX3V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kjsHOBCx; arc=fail smtp.client-ip=52.101.128.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN+mV5J1VwSZpXy+B7cwN9PnitMENOOeA70iSU8Xv3v2ec1Jl55S4thoazSPg1FUXZpxwzACx2gzy7PlSrvxI+7UtynkiC4X6/dmKYoIhrRwtPMgg0v0Y725PyF+VE+/YU+ftQ6/fw7kx/dVK/aQjBl45cjA5TobMislUtyp9IEGXBG3b5/0ohLO/lUTecLKLg0BLzRUiVzegv4XLnQzQq0LneWKk1tKXxF6+naOyv6NG8R18DU7TCLga/EKmjo7eGutVklZB7CT5vaqXmYNY8X3pS53UeAg3p7cQfULXyxLk70cqJduCMmM5kM4D0015moti2hOvYV1nSFkIKKEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdIagn5oAf3va0tLrftcwcZjzHSCSLIThnhnLBS+MOk=;
 b=dNL4rFHAuji/MdWlP6ZT8B22Ui9zUtDUo6b4tQzsq7KuvNadUesj5fbZa7O9nCr42ufvEQhm1NGvw3+HtHmM8Rq5ykjGrkwY+cgk2dk/vnKdAobIUd5OhPAYih/ANLpFGBnjXbgaqjg69HVLV5uPg78FDW4fm+GTI/AX+bQRtVvyDVfImPb0/StEM6umxE8tX6glnzn0Pr+ocJnviUGdLN3+3mbcHTh5d8qR75pc3C34wh1VLs00KguzIY8jM1sWXL5dJaJXB6SaUEjQS8wSg2DPjCxrHT8zkX5V3aSINgQCuOoKosvGbXoe8FYmMJUhKtN8O/nupldcR0/YsI0/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdIagn5oAf3va0tLrftcwcZjzHSCSLIThnhnLBS+MOk=;
 b=kjsHOBCxXxIB5sZEjYe7/5F5Wm/FXZD/eNC+az5ZJqrxB3ZliM4O/CjHTeBKt7dhj2TmpjPEyKuTD+7wzfrVMurGxUtoERGA37Nw68S5gJjsdf7QR0UbgZaCslBzRpNjjmJm2dgsZy4IvuQpc/aVU7XmQsKGfBTvgFNpt5lY69hQuk1l667FFlkx7k27aX5kNPLSe4ltvU0xh+zAlN/D+I6I1F+Bk17rvnFoy7ReCIunHflvWOlmgPQHpPAvu9Yi4ALvSvZMhuSZQnikzXDs69VPQtQxff0qGzTz+LD+0dgO9B5GoPQRrSDn2Nh/4y8tqki3KdEUCYl/GHeZ0w89UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by KL1PR06MB6847.apcprd06.prod.outlook.com (2603:1096:820:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 04:45:05 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 04:45:05 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: davem@davemloft.net,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
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
Subject: [PATCH v3] sunrpc: Fix error checking for d_hash_and_lookup()
Date: Wed, 28 Aug 2024 12:43:55 +0800
Message-Id: <20240828044355.590260-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0317.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::7) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|KL1PR06MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a9a1fc-3ef6-4784-6f16-08dcc71c2fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sv2B4IbZFz7OwVRW1uQA7+/XU/qbAoFyxUYC1m5N9KrukA/R1U89eE5f+Uqx?=
 =?us-ascii?Q?epDvV9u0zb4XqdIlRSBPkqFLd2dNTXX3e+tgcepjdlBXwQX7/ocbWNZoKmMG?=
 =?us-ascii?Q?UZACPyn0Hr4NYG9iGT+APk5MfBzrOaic0mNzx1cv8+Egeh0a18xFmpLsgusI?=
 =?us-ascii?Q?nUHxGsq0ManHYzt6tkr0jNJDHjP5AWBebgYDFM2AZ7zZv1DLyE6MEd0140m8?=
 =?us-ascii?Q?YYRlM77Et8OH5efnwRBNSqkw+K5+NguGVRuByMenrYfakQjRXdOuqAhZpf5r?=
 =?us-ascii?Q?no+iZhE8bX68YQvkOJtYHWbeoM4DYuA7+KJHKs5XqRXyOvj4dwe/Df1ozsJR?=
 =?us-ascii?Q?UddXCRang8ztU9yOTwimch3cu+KZdXygzKOP7mlJWKlLxdM1PWWXtSpvI3ef?=
 =?us-ascii?Q?t0eJ/W8BH2FNRa1mTDJL6QoZ6iwTZgIdfDxX0c75gxj9WNlAYwH866sNP7vh?=
 =?us-ascii?Q?JYHhdWmk0mSC3tCSvzILEQn/sNe/SeVslnZE1EktKj0ECZBMw2qPBJtLCJW0?=
 =?us-ascii?Q?MYnkgK8/GS9tKmuXLdNGI3nYvwqlnIxfFwc7KL70J1kwPI8z05xbGqf8plaA?=
 =?us-ascii?Q?HLP5/NKuR9W/ZVgyLUbU3X69WdxbiFN5Wue+ShM60Bt6kDD1qfKXDMPhZXoF?=
 =?us-ascii?Q?3ZCyld299aDXJebGtfO/M1nnr8byM0RvkizssPCFKv1K5KjNJ/3YQ9OyvsEP?=
 =?us-ascii?Q?bTZ+zyx1uErbRvWkqEUAmwNQr9ub78oLK0vuRZLiT37zagGD89Z1/slRed2Y?=
 =?us-ascii?Q?OB4rAIxZMg5bq2xT1e7CyAEYjiwYgb/5u65Wkdwz98SSDcbaJOvhi6VLYdsv?=
 =?us-ascii?Q?P0djWeVXUM+HzyNQOM4ViHuaQWK10g3TSBzwc8mlueDLJ1JUBR1V+fKJFqFN?=
 =?us-ascii?Q?jJdPfSpZc5nLELEKm3Wu/yIiLzdx1Y+Yzt2xIvbVUVqSHtzn9Sx9R0zX9ztN?=
 =?us-ascii?Q?mGCDAeXc2YS637Kt3EiplkTMlCWLFQ4OUnXljqXJzV7etr3ecbiRX2L5yS3i?=
 =?us-ascii?Q?gcmYiS7jswfakNQTin8RLiTD1ogqxGWJL00RSrhJy2vg4nY1BnoECU+PimQZ?=
 =?us-ascii?Q?NDwXeTMvaU8hwiCPkf/KgTkw8TnkSnOf8uOtmklFdy0ZldS+fQxY0lZMpCy8?=
 =?us-ascii?Q?G7bl6Bho2stmWm+vLwJ5CjiwC9m4vdP8s50fyaX65F/mdEtcEegS3r0IsXQ3?=
 =?us-ascii?Q?3THtILIXQrHHvpBF8IoqTBvpuyTM28nMKgIA4vbT3x+cl8dAyeXLLNadSrQW?=
 =?us-ascii?Q?T2VhoRo0CaqBZ7nW9nQrftpCzpRycf2PIbjuAyc5Ido8Zze0qHfiS930DfBE?=
 =?us-ascii?Q?sBUBtUKjNo0pFhoIQA/pqqmaleQ9zM3gtwmyiovgl1brXGcZ6JehhKjObE3X?=
 =?us-ascii?Q?2opPP93ol+HKKwEOGFBjq4Z1JNOZklUFZjnPWDBLGfBQfFMjIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJTiu6Hs+EkD2oxwaKdD7RTFU2RU8P6E3vQxfMWu35YQUGXmmc2ZqohtGvtE?=
 =?us-ascii?Q?x/rUW1MbJ3TOsgPB9/p1LvV0yqJ3C1nivXfSBDQWov2AgE6n6yiMDbGWZXeF?=
 =?us-ascii?Q?+mguS+EcokunhlZS+hfT73kLnOtbNZnXWL/kRJ1yqt3GXiA2bHDDThwVZe4I?=
 =?us-ascii?Q?FNTZXZosyaFX8moW7tPzvHsJ2dL5S2//NJXT4l/My6Aia9UffJjGC+VvcmOM?=
 =?us-ascii?Q?vdvKyj/2a+pH6DGcs6TozSTUTfNvwxjXpi/LbUl84Tf/xBndRoCSlxd+fwUE?=
 =?us-ascii?Q?d8R81TRtddEP8YA8xTDqWOffTeLn/7aQ1xI+ZEB+vqlSEa2oZ4ZYlqRjcF+m?=
 =?us-ascii?Q?1+GWOQeKsxTI33G9sFYNk936DqUh9e27k+ELIMRuzNCPkRmJSLJttUNw5QTd?=
 =?us-ascii?Q?Mx1NQnM1azZDdyv9koSw3HwHclt1bE7X/oBbFZp0oJTywe4IY3seRc3k5gkX?=
 =?us-ascii?Q?2Z5jxxjRvj2MT4vcpnp2yVOBri6tQ7aUv/QBMsftaVbY5A2bygxk/zCAUe5N?=
 =?us-ascii?Q?54WLrd5hmDjsNrRAOHesqe5doxPMGIxAYkyBkiDrZW6TiWurY1HswZNTlOm7?=
 =?us-ascii?Q?tGWKMIbA37z6uCz6RF+b/PrLctGXLwhC7wzJWlAiArN9Rq8dJEnIe2Ye1h4L?=
 =?us-ascii?Q?bUMsciIjQqH7zlCiT71czC1Hmi5uE/Xg7AO+lU7PMgnyHcgQikcSKps21v3X?=
 =?us-ascii?Q?brs2Rzj/0RDIXpCGVWiOpF0ZMJ09rSbinSqjgcciyRmvvBYwplBU7FCporFv?=
 =?us-ascii?Q?Wspo+IRcVH9qieDgrr97uaGX1Ulbb6mwyafjpOL8g0VXXctFM0NG1T3JBr4b?=
 =?us-ascii?Q?+saEVWMpW6RQQFvARZ3Zv1myrbxznj6xxJuqB6neOI8xwonaZP/ep6cq546y?=
 =?us-ascii?Q?bPQ/SlBvkrNnZzUVY+e5p/m5wyF+C9P9N9QKvnIg7kEFuwXquvVnj7KLZXO9?=
 =?us-ascii?Q?QwkjEx/mfr1skBPE+pQvyOdFCSmRns39u26MlASxso0J7mLtNZSaDF07IsZ5?=
 =?us-ascii?Q?kD5qwt5L0x7+Tt3UVt6zdZUb+CcawfMAs3eRHP3/t8LLcEHv0m13hJEGd9Ze?=
 =?us-ascii?Q?Z9vlc9bB9gs77LwBwBIKBFtcCdL9tW/2iMgux2J2LK2X5YItOhBV9v4oHuFq?=
 =?us-ascii?Q?oHkfA6kEqm7ZK7u8V0wB6YmHUN3g9LERdEGWNpLuTO2G7qTjWwe1XrAaiTL/?=
 =?us-ascii?Q?TWj8v6NZdiXKakQBmRxoExwf9GrwnSnj1NlPODL2zxRhEkrEslTfEJTRC6f2?=
 =?us-ascii?Q?iT2c5LTHHppxx8Gxaj4DSXljmsgVuSS3Q+tHyS+aliGJwR2nF1V3O/CZO/rb?=
 =?us-ascii?Q?7UHJ3G2Mdf06YVgWmWz8dFIxd0ZLRKuqFe0pLxhOIKuXey5dgpUq7+emirTv?=
 =?us-ascii?Q?OJ381O+u9VJWWDvToeBmH4BORMTCQwb9VVUMheON0X2F1TJk/nhmtugU0xnK?=
 =?us-ascii?Q?XWzMR8Tkh0nZnJZhKnoP3Gsra761DcT7S46JJdyOo8TI+Hu0FXxL+YJnWjpo?=
 =?us-ascii?Q?qFeBf/DvAtiA5mfKsivvHNh46zHVF8XcnZAOIr0bUPC02bEugZC92uF610y1?=
 =?us-ascii?Q?OebgFNa9jAQfDPLIFE9YaRpVecv7cUDlaKuhfizU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a9a1fc-3ef6-4784-6f16-08dcc71c2fb7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 04:45:05.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNMrr0b0HzX2NkKGfH14JMYQsRHcs+KSKHhyemLvQ3z1g187IqFr1Gsn187v/jFWFQlK1toPdcKU0WAVTCcDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6847

The d_hash_and_lookup() function returns either an error pointer or NULL.

It might be more appropriate to check error using IS_ERR_OR_NULL().

Fixes: 4b9a445e3eeb ("sunrpc: create a new dummy pipe for gssd to hold open")
Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v3:
- Rewrite the "fixes".
- Using ERR_CAST(gssd_dentry) instead of ERR_PTR(-ENOENT).

 net/sunrpc/rpc_pipe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 910a5d850d04..13e905f34359 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1306,8 +1306,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 
 	/* We should never get this far if "gssd" doesn't exist */
 	gssd_dentry = d_hash_and_lookup(root, &q);
-	if (!gssd_dentry)
-		return ERR_PTR(-ENOENT);
+	if (IS_ERR_OR_NULL(gssd_dentry))
+		return ERR_CAST(gssd_dentry);
 
 	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
 	if (ret) {
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


