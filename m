Return-Path: <linux-nfs+bounces-19388-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAMZKFhUoWk+sQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19388-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:22:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107C1B476D
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 979A131018C2
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642E38BF71;
	Fri, 27 Feb 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xvXH3SpK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CA38B7A8;
	Fri, 27 Feb 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180225; cv=fail; b=l0hLEWB1xCCe5wd/Kc6I8MiL78dekqy2Pucj8RBjiaRXEVwqo8m3DLDlCzRbz/NPhpy12lOm8Fj3iDIu3ZWe9wrEO5OGchur1InJ+vGVVhWNBBwdK5UUPX6KEXD0PfBnESgkHpgTN88zWazMgt9oDJ6ga8LP+bovjul0Ys4HAgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180225; c=relaxed/simple;
	bh=seupKc5yYORVS+7fxH8bhAQJFlv7Heru6XJFmBChB3g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iZ0URxTcYwz3KAOGiFV2xFuD5LNq8ArpY/rzLOsXspvI86xk9QFkXs+M/4auRU6CPHetqSiFfME3Q2w2/xoxnl6FO2HFSpW0rnQ0WW7/S46Delr1DQzHe+0KSXKr4R26rWIyMox/SJTufOWhtCP0qYycZgbTegXCpv1EeGeO8T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xvXH3SpK; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZ18qERdE2H5nbtxb1Gd1wytzv1vcWfbJNEfo6Ig9W24MWubd+VYmy28VsIvnUKV6R8uYc9UIeCOsravegoqRyAAmR0geTBAnU31TNR0fEodwfRBLGux0aOpLV4I8bf6OXqpQHcRqkUJVfXjHlbzaBI3JoW+Ex9NnvxOwr9iayABo64LpnojGhXqgcxD+0dBSyX7ZRaVy4luG0+u0uoW/hodGjjdC+mu1I5N55rXUFGlHX+imfJ+GGplhucuoqyZGQPcPmpbteNJhhRcumAJqsfxnVl97lbV1aC7kUgVo442bwYxQk52qbH7DBtcBqiG7+eA/uS3mhPX2Yym+YhP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DJ9JFzdAMLMY83YZ2I2J1IOSGBpgnMQGvle6DnbQx4=;
 b=Gu+1uZ8dQDC16PJdv/q+BRDEsWOqhigR5V+EfcH16I4oAVEB17rVqXsiPuoOc11vF2SGy81HgXohcaCFKt5teP92wT/BmXirox3HWXqPWVxvVHGmUqONGotNl8gKQ1xjrKQ5Nf+ZidGVgSW9wEToFvNui+FM0fld0l6EYZ2tg1sMi3VUq3WotdDNCrByVmB9GfEsZymLRZy+wgpCuhj0xZ+XpvCJNZjdO7OmOWUE7fga0zQD0ZXEOGUq97l9vwBDJsuDba+XJyajjSxld1ih4PG1BwBRFHoG01Y5l/ZxDOvUIKKwYCE2Da5PtFS6huF7jH0fMOY2WK4krZaWParNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DJ9JFzdAMLMY83YZ2I2J1IOSGBpgnMQGvle6DnbQx4=;
 b=xvXH3SpKmImNJbVZRdVMVUOOZ7JKxpVkE7MyVy4O+0H3f/oofwWjaaO86Rfjt44cbDvu9zOufX1b14V71UawbGWwiY4f+HAU0teGaMGtc+Zq6syJbTBJDY+av6gDvMamMetn1Hf4v4Zha6lQnjPEx6moY7MXE8YJmUTurKGyPz4MJnOnHJYjiNJFGXFhU68mwBgk+RxrEML7ppMiwkmPAmTrGcWaxitXakJw0+yFS/4MItXxf/UVT056g59JfNFW6WNX7U1t1BdkwUOwgN4TobnuMbjc8r4+kYSXRkNkdZHJ0IGJqgMzZZK2vYMQE9I5w7u5hPnYsZ1LjB9y9n99vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:17:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 08:17:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 27 Feb 2026 16:18:22 +0800
Subject: [PATCH 3/3] NFS: nfs4proc: Mark ptr as __maybe_unused in
 nfs4_proc_create_session
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-nfs-v1-3-2a6ea2ca8528@nxp.com>
References: <20260227-nfs-v1-0-2a6ea2ca8528@nxp.com>
In-Reply-To: <20260227-nfs-v1-0-2a6ea2ca8528@nxp.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: aed66a83-3fc8-4e8b-17f0-08de75d894f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	k5BughwiGcYuflrADrlHh6fUkKlwrGmRldshfRKEP4RgyKfUzNSEx7do3j747YjsdqR0pYAZXja6xTWaAOYTFY47TPZ6KwbbttuF7Vkz9AR8wyOCvV46iFV6UDhFJCsvtrgom4JI5ZlLsfwML+k3vE4q9wtzuw4AslF8f5M6fKPSKvaW98MTnvZ7xRFbMWzME/BZUVxl9gea7QB6RoUlTjHy7+IExYNHWKvx6cQ0mSHzWsiLUCPosp4YrOE14L+BrY2cgDx31wslkwZYr624L+rITbT4x3lBExsOab1C4PSU++zWREhXVYEVNcPI6O8z2iNGF+pAm7Cd1u+3bEXwZUV+f+Z3dpV8XicNoZElt+MGqpJvBcISAUdsUS3QbYgHnY90ku7Sl41KsXCaGUpf3zVFGKl80isXxYvJX3hk+cX1OPdLzUVsuFCsgvO8WRvqtWAlcWx2Vi17kCt+vks3CcvrEh6N/EvyVJCaKhTloZgqtapqBMHo9gQOfTOrWzZUucadL+vHOWgUuyHHBmtz2QEcsvuKVUG+2lj17+eBitYRXe5hKQLxk2gsH2uzDaVe5mznv0lESzyZWnNZUmmnqNUSa2K9hvJFxnN2wXH7U9dHM3Dy2qgL+A24uSMaW3JIQ8LOLr6CEGNYjWuEfE+QqL/PnLToC9HABlRraKvNLjMgY9GuCxxuKyif2X8vZAv8O3tyJqq3Qp2qt4BUZtjgiv+Ea928S5KEfJPr8e3atqe8fY9+RLQSt1Z/TbMX/Q9I7mWzA31617OLw6jGxBJvEuYPUdAAM1yjMOrPTM1EtnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVJxdWNWYXV0Q2c4QXdNUDAvRGl1ZEFGam5iRVEveGN5dG9qbytQS3hVNDR1?=
 =?utf-8?B?QkZuSzVPL0tIYlJMcUdXMVZiUEd2d0hVVFdOMCtsaVY4RW1TZm1JUXpaL0FS?=
 =?utf-8?B?ZUJBV3FBelJ6cXcxb0plTnlpK3ZnL013enhsMFE4enZZTDY0QmQvNmFMTmNu?=
 =?utf-8?B?Qm9VTmphME1tY3A1TFVWZk9NLzQ5akRJVEh0Ulk1bUhpdXY0NStvaFJ1SjlT?=
 =?utf-8?B?NmhJMkorSmppb3BLakZqSDlGZ2lVYmxtaGdTSXorZk1qTWVmWGUxUm9RanVX?=
 =?utf-8?B?QUQyVis0enhHdkVnL3JvNUhabDlPTjZ5enZPSHRKTU5wNUM3eG9SVUJOT0ZY?=
 =?utf-8?B?WWl1ekE3TXJEanVVa1VucDVaM09la0RuQ0NJRVVuRUJGUUljL1pWdmtBenJD?=
 =?utf-8?B?bE5HY3FZUVZqWW1BajRTcU5HOUg1QThpWXpsaU43VEYvbE9oKzE3WWg2RHBq?=
 =?utf-8?B?dFE0dXRXeEMvYXdiWG43Rkh2Tk0wOG9qWUlwZ212N293VWVZV1c1aXQ5RmFo?=
 =?utf-8?B?UWFkWEdQQWNIYS9GVFJDb1dTSzduVXFNT05PTkVqYWpWclI4dmhzUlRBUnNX?=
 =?utf-8?B?UFFadlhzVm9hNElvOFAwWkpZTktjSUp0aUZZRU1QVnYzOGxiQkFlYllmSFZi?=
 =?utf-8?B?dGFiczM5Zjh2Q1hiWVp6Z2JHYkRHanczYThteEZpMlVBdkc1d1JiUGNDNUcy?=
 =?utf-8?B?NlhOTnFhYnRHL2x3emwyZXBXRnVkRVJqd2VVZ3pHWDA3QWRPTU8wUFFJS21U?=
 =?utf-8?B?K1BTcnBsck95OXJ0UnQ0b20zNUoveU9jcnk0OXRxOHdIQnlYd1RmeTBqejc3?=
 =?utf-8?B?ditDN1lMTzRiVmhNbWNRZGNXUUdwMDJZM3p6dlBlN0NWVWlnZlVYaVp1Y3RW?=
 =?utf-8?B?K2hjRjB5QTN0NWFPejQxTnlnSEdNSVZGbWx1UXgvM1RWc1B1OVYrbVBoc1o2?=
 =?utf-8?B?dy9mc3FDM0JqUVVsMm8xSFVLSnIxZy9SVy9USTVKL24vc3Y1NEtWVWhIK3J4?=
 =?utf-8?B?aXFJYjk4WmlaNzA2eEJTdVk0QnB6OGU4UVBDNjBXaHpKMFlrVExHcDdZYWt0?=
 =?utf-8?B?MTY1UEUzRU1rdll3NHpVTFpQVTNtZVh0MHhFek51WHVuYXQ3eXRJSDY3WGVr?=
 =?utf-8?B?VncybWdJMDVqZDdXYnNZTXo3b3FVU3d4dHRnNC9EQXJibXBFZFNUVmRiTlEy?=
 =?utf-8?B?ZWZCK1VERVZ0K2N6cjZXRVBQS2o4TDlCMmVvOW5wYVpKZkMxTjQrZG5xTTU2?=
 =?utf-8?B?M2VqdW1tZ3lNalBsNkExQkJUell5UW84aHBVSm56ZTZZNlJRRGpNZXNUUS9L?=
 =?utf-8?B?Tk1KekFlcXVHenlxbW50SUJOM1JxZ0FVbDUwdTF6SHRiM0UwUmJ5UWxlcnpo?=
 =?utf-8?B?TUF6NUkrdmwzSlp2MEF0Z056aVVkNFZHcnFtODJ1aGdLSVVDRW1sZXgwRjVp?=
 =?utf-8?B?dVlRK01LR09LNGx3NnQzcHA3dTcrTS92WDRMQ1VuVWVxWU5DVVdHL0duMElr?=
 =?utf-8?B?RkNPbmppQUJKSlpDOHFNY3hKUTdqRE5jM1hyeVVlY1JIZGlUVmRPTTlaaUFT?=
 =?utf-8?B?cS9Ic01YNTNORVg5S3BqN3dXbHhROHpETEkwSnRUY1RKNzRiVXllbGhMaVBy?=
 =?utf-8?B?cUYwa3dxcndpWCtRUXQ3dEhVQ2lRZTNOUmI0TFIzTVUyaUVEQ2VkZnhiK09S?=
 =?utf-8?B?dWpaaHpid2cwck41YUV0Y21IcTdCSURQeHc0UGx4UkE0Kzl0LzF1V1o3UVhx?=
 =?utf-8?B?ZlFuY3FoOUxuRjJ6a1FIR3FqanFUc20zQTd3R1IrRzBVMUFKQzNNQUtMWk1n?=
 =?utf-8?B?KzRvY0FQd21tblAreGRvd2ZGdFQ5UmZNNndGZW9KUWRtTE40YnpwNDkyQUR3?=
 =?utf-8?B?eUMvbVpoZS9MMHNMY2VSL2xTRXAwWG8ySTZGVDVac3Q4VDd3MGt3eEZYVEJU?=
 =?utf-8?B?bWhzL2RNVS94ckhNZFBHZ21oeWdlb2xLaTNLc1lqK01pbUdnNlhHSlhpRHkv?=
 =?utf-8?B?WEIvc3ltcEppcVRpSDhTaUc3WkttbS9zR3hveWQ5SkhnenlQcTlidHpQZVhU?=
 =?utf-8?B?eGp1cW9jdDlqKzVsQmdkRzgxK1UrSW5rY2o5TTRqRCt6dm8vNmd2eEdsejli?=
 =?utf-8?B?VE1Hc3VNRjFQL2ptMGZ2N3IvSSsrRW5SWFpQVXhCcG5FMGtZbVJBQklqelYy?=
 =?utf-8?B?Qm04dUdlenNLNlBZVW9sNWxnQ1ZHMWk0ZnltdWlaQ0tKSllzVE5zNEhTdmdX?=
 =?utf-8?B?ZjY2QWMzdkdjRW1nWEZJQWJ1OGtwTnFkODZickFJc2lvUndRKytuYys2N0xu?=
 =?utf-8?B?RlNHeXcra3ZyU0w2MGM0WUJHTHk2K25mYUZabWxPYTUxY3pjc3I3Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed66a83-3fc8-4e8b-17f0-08de75d894f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:17:00.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9krfRaUH+P796dfkfEY1H7ZIuwkwnJF0jH2MggIAXj5HzbtwuJzS2c/hnFQq1piyiafSqFlvn4ObqitPwGE7Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19388-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Queue-Id: 2107C1B476D
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

Fix the following compiler warning when building with W=1:

  nfs4proc.c: In function 'nfs4_proc_create_session':
  nfs4proc.c:9244:16: error: variable 'ptr' set but
  not used [-Werror=unused-but-set-variable]
   9244 |  unsigned *ptr;
        |            ^~~

The variable 'ptr' is assigned but only used in dprintk() debug statements.
When debug output is disabled, the variable appears unused to the compiler.

Mark it as __maybe_unused to indicate this is intentional.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743f72a008a9dcde29207bf7a36c407..64e0221c39423dae58a30018a28d874198de57aa 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9241,7 +9241,7 @@ static int _nfs4_proc_create_session(struct nfs_client *clp,
 int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 {
 	int status;
-	unsigned *ptr;
+	unsigned *ptr __maybe_unused;
 	struct nfs4_session *session = clp->cl_session;
 	struct nfs4_add_xprt_data xprtdata = {
 		.clp = clp,

-- 
2.37.1


