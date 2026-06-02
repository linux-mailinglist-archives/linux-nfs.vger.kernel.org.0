Return-Path: <linux-nfs+bounces-22199-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBKKMGu6HmrZJgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22199-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 13:11:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF3462D2D6
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 13:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DF90301C5B4
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7473955FB;
	Tue,  2 Jun 2026 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uKNnPqcZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471EA37754D;
	Tue,  2 Jun 2026 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398287; cv=fail; b=tM8vTR6pmqOwKRAqdZ6CsZU/mWNsOOEusbnDSnQ8sMyZ9G/7IvH1QxfoFDLJKoKZwxvgNiGn9wJFyDWhVplRHb4bGOz+JXMdLoJLveuxyi0NL3ytVuNVe+MfEocwXXaD7dOdappXHSMsjrNRZKoSPXq6BfkUaXGSmWzc//IG51A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398287; c=relaxed/simple;
	bh=KKbsQ9Iku3jGrpz/uP+APbOOzbHtM1GxHuGx2unuCQo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ljphItG6vur7FQnJxRZzCw3szHZTMFuNNZPC/n599evEvGsJ5stBz0k8c+cnHfHf13ZvX3eEELWLX/F2+/RGCKdPSelQlE5h/uqgKNtWOuqQBChF+J3rlYa1xMXrERBmWcBkizDdBVXdvWI8J5xdZ26z5SWcDcnH3BUwxdOZvYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uKNnPqcZ; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxWHIHuW8ZQY8QmFOrlHSaUn9NCMZ8wGvZbJsVu0jGOQBF7EAfT0XKJgCfAGyrOumM/1bTMaqbIMo86S4Twq0yfb2ibnrHp2dbXYipZTbHPEaVxjL+W/NngtViNMYtaBHY2bAiKEMK/YOYhcEp5S/AnZdpDAkkWONWQw05HyvLujhBV9Odg/c9+97Ph9wjEVZQHd7CdHzwgm46XYsPpRXJIlZ4tRJREVZJ5n/OYjHmATrcj+7qMT1eZ+ttjO4o59nGOGRwMFoTmNkFiO/4NM49SCh7sVdiKKU/Jnv1btWT0IhSdT0GEI6FEaKoHmGqubL9L5V6AQ0Wv9e4g18VfBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbbeboqiW8sdzFfRqcIK+SzN0z5m/7XdMh4fl45degE=;
 b=JEEG1kHLlohIU5G8QSES7CPgcTAD0FDQql8ktO3goLLG9BFuUVQhD/LVZRmJVRtqcQWXsNMMmvP740IIK93sXty9/INhYY9mROJcbk1hAdPLmozSaQdWZ3ch7yTsQrsCV8aOfPctpLDbQESD3Q+B7g9ImlNUX0NLWXORtg92C3S3qy5vDlEcPspKRpU6duxiKbPmvMEYXYNKib2HPZZVh1SpZ8uMqeX/yqsMkPlymtBRcaIx4MySjO3JyIcV+lIOLyl+nZ74+DVy0BKjkexogD0ctfT4PN8Krw2AvBHVj0xQJNkxi9Uk8R7eJVVWxBHtcW0hC4nQ6HGab0jrTlZ4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbbeboqiW8sdzFfRqcIK+SzN0z5m/7XdMh4fl45degE=;
 b=uKNnPqcZ9fvgg8xM1DZ9Sq1egNbyClYejLfGEM7YfSbOz96PfLd8F8qgnFWk6gIFRt3vkmZztubdip+zoXYQ512MNm4WdmJ2cnwRaS9XYhN3aKYXh7rngtp5VM4rrmgiwLtK4DOxpT5LfuVujCfnRZkjPPrb9Xzw2sETS/9jhj1QKoemxm/DJPMe4nh3UTWQCyTCe//dICVlkauwLukoFYmwuywFNrNQZ27zg/j9Ov3waz0BiqO3hIAVBXIEvbWFi4wHU+KLWijNdzsJ49vwNl92o6+CAzTpXt9Z3+yr5jUYLpleuJm3tJyeIDqjUeR/L7Zwmol9jREJ6CsAejO9sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com (2603:10a6:5:35::11) by
 AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 11:04:39 +0000
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185]) by DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 11:04:39 +0000
From: xiaoning.wang@oss.nxp.com
To: trondmy@kernel.org,
	anna@kernel.org,
	dros@primarydata.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] WARNING dump caused by PG_UPTODATE in nfs_free_request()
Date: Tue,  2 Jun 2026 19:04:37 +0800
Message-Id: <20260602110438.3489554-1-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To DB7PR04MB4428.eurprd04.prod.outlook.com
 (2603:10a6:5:35::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4428:EE_|AS4PR04MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cfdcbc-c72f-4532-fada-08dec096bc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fKazghlFDJQBkpDZfjzEdm4IZo6D4GH0IoSJ5/EuhhuHCAlW55dR7ZEaSoMH3d/RmYYKgzwu8bpIeoqljWf3QT1/T1voDflRIoywghP3ucCLfUjYm5iQ5tEln/No7BZCEguSrCa/S7Ib2yxlffCbWtHw4wUoWcINk79xYRI6M0AgCmUbKi9RPsAONR2AwH6HrBlD+PXceX/Z6oMzZKG9j6i4ZSgYOnhSdP5n/Ks5f+ABaqOmmoT/O1el1NOh3Ll/EPyrt/DtD/ucRpQKY2bXv1yw6ZovpJEmjg5jeAg6ao6bjRRUPOT70YnFnqJfqBprDaXOyUPN7IYbVpwO1f7/mniGiz92cJ7j1mCIDtGn86goLYYKGupVA+wiOW3E3pdNT0zj3lQtsr+eTdDj5tT8OiV5wBxImgUJhczigqo+Z+yGo4k4EzZqisSe6GhMvxjjHv1yTDY70aaxWrtO8rEt7NZlZ0SGvOab4IjgwOhztA8YqLWNvVi0BNrm9me/bTOR2tEv1GFWxtm2EJh0QcJo5leg66vq+1O+/AA6jCK/JerOFWEiUSiEWkfDNjaSbjw7VrQGz3ndte/OlN4yOhArP9QwpenoPzgTrDoES8URI3l46+o3Az52AbkzqgJC6SZZtOHrUL/XNzbSNy/Jf+xcgFUF+w3iMrXVvCPdQ9cu37RdbOLNZTDueWOnvFypupLW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJaopvkCqcMEeMi3i1rnCGC6P10qOGs7fOy7x0KlFU53APq4jC9llhggJaGU?=
 =?us-ascii?Q?NpY+qqQA+CgTxCiG+e7OT9ykxzCZgotSYG8skcwXwE5SjE5WqQon5IplYe/q?=
 =?us-ascii?Q?uAkZBf059HrOMt2m8bwUZMYma0+87BaPXLuuDZWY83G3z0F9txmpHoBT9k/9?=
 =?us-ascii?Q?gDVE7dzTKPqQcxCFfKHu8XSO2gdapZDq0sMkaX0b8qkFQ1GLitOGkgokYl0Y?=
 =?us-ascii?Q?AUUxY09AqeGQXTcDu8e+9XYF6ISFGErDpYdFwJGJgkdFHUc0ca83j5jAx02O?=
 =?us-ascii?Q?gUT9nxnNmX4GqTYXMSiDuxPWnI0YhUa3gT7GmY4NC2/gfPllSYK8vWNaXcvS?=
 =?us-ascii?Q?nMLet7D5eN5hnuUCbn141auu0l+MN/Reosbd+8G06mAPPc7Wf8ihGPpqM+uF?=
 =?us-ascii?Q?waoR/C5JDVFQio9SQCpw829ncR0mBwCFi1qPM/cheoDAJpXL19P3s0XjEp0r?=
 =?us-ascii?Q?aoCn8u4Q1cK2+w9HUppyZh3D5YypniKS1fsWzf+xJwRP6tp+0uWRPKEBk/3X?=
 =?us-ascii?Q?dwyBLgLE2NsSrZXOAG8W8XWEYyf6mE3gw81lvTnOHmtY8vQwRlnsZ2OvnDg4?=
 =?us-ascii?Q?JHqsXzBdGqlJxJRMEYE9vec1QeRHLAjoNgDC5WyuGkw0ZSPpgdENHq2QYpg3?=
 =?us-ascii?Q?y/BRwPGLq7DB6351Ei6rjTaNiqylK4M2uLDB9RQdoRFaB4MlIqVBXSTbEBa4?=
 =?us-ascii?Q?qMQTy0O8nyDCN2reNYOWTJj9oyYvWyas57DNV9y05OT/ABBVU30iDH0l4tYd?=
 =?us-ascii?Q?EFWDX54VwnYmyapKDp4hcyLCfmPO116ryE+b7I725yxq5x85bRXX4mOnXHTY?=
 =?us-ascii?Q?AnFXAbsXxSfMzEJVqGW/eaVo9ohqLNJiPc9t2CjiHQnJahQ7kxuXkgrfUTTg?=
 =?us-ascii?Q?c2HRMitjRGwxxQfdMnoMNVQkrMfr465SI/vvPREX9a/tz3jbPguTEf1WWn55?=
 =?us-ascii?Q?wbNVDNOvrhUYCYByGSNHG/gSDMlOgRml/91QjM8F2iJof+iQIn+rdIQROn1i?=
 =?us-ascii?Q?zmH5tVOx5Z6Q74A4VGJmaF+gza3+RKh5VwG5PYAvVyvvWkxF4y8Y1y+K6PzR?=
 =?us-ascii?Q?NoYZumYoy5VcP8YC9LIBA17rWoslUZ5BKIeScrJDCU9e8JlL10h7adetUYZp?=
 =?us-ascii?Q?Rf6fBo64v6EsRtSYLSRCgB8MAQ4l6s+qKOSzEWZyWWFYnTvNSL6MPe2RRFu4?=
 =?us-ascii?Q?ple49EakBBHZj76LYYxiXkN2EueqH8KPJNrIdU1LVvXg0tpENpagXksrATSC?=
 =?us-ascii?Q?fnhcXWn1bdGtWxj4Ga455gmfUrOUBPgtuQZUoyJVMGjXpBjc6DpYUWI6ccL7?=
 =?us-ascii?Q?qOCJye3aH7EBo4HVb9qQ3EiUonbLj0MgPnQ5SL69LBR6hCr59gHdIaICK3Te?=
 =?us-ascii?Q?3+nTA4JAonjhLSXlJ6lMwOttKCCraf6G1q9yhDxjsDbmrVEXDQ5iYidNNCvC?=
 =?us-ascii?Q?XYY8JAbQZWZdv6BdxnYdoKFPmEgoq1RQg9SjJJ9CxE3MOmgr8t03VfwZbQd8?=
 =?us-ascii?Q?TBNPetI2Kx7m9JhfGZoH7OSlzaJXTBqWbrNFncNMEWJ96thcC3sCt2IaAYXJ?=
 =?us-ascii?Q?aKOhvLf08T0XVLQhuom+LKIKITm8F3mZ8CHkz7tcnCXgaCQ3n+6HqvWvgUJJ?=
 =?us-ascii?Q?pE9O1f8OZHn37djqjasPVCiVejUmHkL45AJx73HmVcRakSu9g6D/WSUwXD4d?=
 =?us-ascii?Q?i9mS21II66XRQpOoplicVq1rFIW5jmeU0gqaW2i0c7c2TbvQT3e76nzFcyiw?=
 =?us-ascii?Q?J7KiFfQEsLGWWlhuaYWTqeYudONO5qdE5LAsvhDuDxjckXaM6yEj/Jpwztrp?=
X-MS-Exchange-AntiSpam-MessageData-1: /DJ01BJJ+jzupg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cfdcbc-c72f-4532-fada-08dec096bc02
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 11:04:39.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGpYbvfwSA5pHRm487Am8UsTmCCBfCyCYungbDlq3804OLlTDlekPXWoJsel+4T5r0W49hyqWJwiGSuIc92HSr4jvCYSz+FLjnvqUQ/ZZLw3yzMrs6U5MO+kwrJKLVE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508
X-Rspamd-Queue-Id: 2CF3462D2D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22199-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@oss.nxp.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Action: no action

From: Clark Wang <xiaoning.wang@nxp.com>

Hi,

I noticed this issue occasionally occurring in the recent daily test based
on 6.18.

[ 1829.562634] WARNING: CPU: 2 PID: 4406 at /usr/src/kernel/fs/nfs/pagelist.c:587 nfs_free_request+0x1e0/0x240
[ 1829.572381] Modules linked in: wave5 snd_soc_fsl_asoc_card mali_kbase snd_soc_imx_card [...]
[ 1829.601384] CPU: 2 UID: 0 PID: 4406 Comm: kworker/u16:13 Tainted: G           O        6.18.20-2.0.0-g3f60d773760c #1 PREEMPT 
[ 1829.612750] Tainted: [O]=OOT_MODULE
[ 1829.616225] Hardware name: NXP i.MX952 EVK board (DT)
[ 1829.621262] Workqueue: nfsiod rpc_async_release
[ 1829.625785] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1829.632734] pc : nfs_free_request+0x1e0/0x240
[ 1829.637077] lr : nfs_page_group_destroy+0x78/0x108
[ 1829.641853] sp : ffff8000812cbc70
[ 1829.645154] x29: ffff8000812cbc70 x28: 0000000000000000 x27: 0000000000000000
[ 1829.652278] x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000801e9205
[ 1829.659402] x23: ffff000087486900 x22: ffff000081c11e10 x21: ffff000086898e00
[ 1829.666526] x20: ffff000086898e00 x19: ffff000086898e00 x18: ffff0001b75db780
[ 1829.673650] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000042
[ 1829.680774] x14: 000000012a874ebe x13: 0000000046000000 x12: 0000000000000000
[ 1829.687898] x11: ffff00009bcbd800 x10: ffff0000ab133998 x9 : 0000000000000000
[ 1829.695022] x8 : ffff00009bcbd9e8 x7 : 0000000000000000 x6 : 0000000000000001
[ 1829.702146] x5 : 0000000000000000 x4 : 0000000000000080 x3s : 0000000000000005
[ 1829.709270] x2 : 0000000000000244 x1 : 0000000000000204 x0 : 0000000000000204
[ 1829.716395] Call trace:
[ 1829.718831]  nfs_free_request+0x1e0/0x240 (P)
[ 1829.723180]  nfs_page_group_destroy+0x78/0x108
[ 1829.727617]  nfs_page_group_destroy+0xe8/0x108
[ 1829.732046]  nfs_release_request+0x68/0x98
[ 1829.736137]  nfs_readpage_release.isra.0+0x5c/0x70
[ 1829.740921]  nfs_read_completion+0xbc/0x13c
[ 1829.745089]  nfs_pgio_release+0x18/0x24
[ 1829.748911]  rpc_free_task+0x34/0x68
[ 1829.752482]  rpc_async_release+0x2c/0x48
[ 1829.756399]  process_one_work+0x150/0x290
[ 1829.760403]  worker_thread+0x180/0x2f4
[ 1829.764139]  kthread+0x12c/0x204
[ 1829.767363]  ret_from_fork+0x10/0x20
[ 1829.770934] ---[ end trace 0000000000000000 ]---

This WARN dump can be reliably reproduced on my side by using rsize=1024
during NFS mount and disconnecting the connection while reading data from
NFS.

I found when a folio is split into multiple subrequests, the PG_UPTODATE flag
is set each time a subrequest data read succeeds. As earlier subrequests
succeed, this bit accumulates progressively; however, if a later subrequest
fails, all previously accumulated bits must be invalidated.
The problem arises because the error path of nfs_read_completion() does not
properly clear these stale bits, leading to a WARN when the page group is
destroyed.

The logic causing this issue appears to have existed since
"67d0338edd71 ('nfs: page group syncing in read path')", which is a very old
patch. No one seemed to have reported this issue before. I'm not sure if
this was intentionally designed that way? (Sorry, I don't know much about
NFS; Just study some code to try fixing this issue.)

Hope to discuss this with everyone. Thanks!

The fix I proposed clears the previously set flag when an error occurs,
ensuring that subsequent processing within the same folio will not set the
flag again.

Clark Wang (1):
  nfs: keep PG_UPTODATE clear after read errors in page groups

 fs/nfs/read.c            | 25 ++++++++++++++++++++++++-
 include/linux/nfs_page.h |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.34.1


