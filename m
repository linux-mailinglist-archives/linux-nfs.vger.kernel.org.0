Return-Path: <linux-nfs+bounces-19386-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFCrDSlUoWkfsAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19386-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:22:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E20731B4750
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A636309EE01
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E63859FB;
	Fri, 27 Feb 2026 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iAqhkAdH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26F3815E6;
	Fri, 27 Feb 2026 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180221; cv=fail; b=V7Jmf2yjrNMcmbGtpxv+fMZgn/968iO0JiRnCLa0RQfQPx/x/qLI8ABP9LV8B/vwxHo1SuYN+YTVQzsJDx9cMTz/6zboCbi7btTKreHuDg53ePMch8oqEateTq1y5lLaWmSJ3XKLANRKpvXzrICcwSR1MoelLN5onF92P3DybLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180221; c=relaxed/simple;
	bh=Bc8cKQRPp8xNJe4QKR/tlcKnkBCrkYlYrKRfpIsyehI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GNUkz8PND+JR64Rsw9V5MBEASMuT8HxAJMtDobrVo5AGZf0gP9G6R4j4lQNyAe8svDkIB+YbDqF5kEPktOSxLf1jPH3zRDsRr2se0WCmSznAaoF5cKLPuReeJUq1hGQYNMf5/Uf63vD2lTdC1rVLy3IFOda6dvmcKRyewKTm5o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iAqhkAdH; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlporNT964hqJR4w7j6zBILnP5jvjTiDRUFk7jAs8krAA6ko/5x7aMz858JdBmee1Iy2DWb2H1/lxx8HZizTfCjK0UVusS8kb9hIAI9WtMY+/IOYRL0gbzwwVRpPe/AGxxPbc2utZ8CBv+RcMOK4nZv6YFDcINrRihS3ZXqadt8h3hfrfAZigTgPXLgUnIth8qZRxNBX/kDwFW3fWXBYPqVpFHQaNmEpeyighK4tmIT2YSvPO/ImNj86mD/ZIAaRQy96lCrBxLR0nMkuQH/bC5KlfBcgJzH+T2ZykfLfh9Bwy5NJQ95AuHBCBGAXSlxC1tE186I6PwKR8rdfuHxFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDuz+0+fXtiXMhLkQDsLn5ADOOvybDDRWZlQ8c5E0MA=;
 b=gFHDJgyuIorU2LwZ46qRGGEAYsg/EsZN8HqaH400nAWGeH7HqaV3+igp3a7DCB3sKxkaS85qBDJt98KqPxmfVIRLpf3n86EyiEn/q6ANhgl+Fo4+wH9CCKblJSWLPjYWdu28R8fLmWDkvltEbxcjJicDHAAiLiaNdvVj53XJxgdo6bdHn2yd3aNUgW9jb3iQu/g5xqZVsBlcIc/DNTyMGYuLC8YcsH2hzq+FCSH0aqBI3NitzWw4qeoEGoD7rZQiurcigdQ1wwfIU1y8y4tNOqRsPEkTQIXjnaANk7WXc3XMJlX9/NaGmP7wfD8uUsq2323LBU/+Gbd27rAFiSdSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDuz+0+fXtiXMhLkQDsLn5ADOOvybDDRWZlQ8c5E0MA=;
 b=iAqhkAdHMMRJ69r/q3uS2uE2VRfs9CRoZ/70jw2+Vjk7veyHI9YuSBqkQ2vVSdHUNKQjQAYoWJUVpVjH6zdJFB0GVBKsp5qwxkiw1Ze0KnnvdSW8kOWL4vkVyepokX3v2p30TgKGmQrzFCh95WQZZoSTOU1p0lzz+6zPydsg9/Fddy5hBpwSp9AiUrmSGvRSi9SZc5q4xD8A1Tltor/4OAmef1iLosnNsM6VtC5awnxXNSNijvXPrzepDq2MyoVj9qvuHzXTc/x/bKHsrirUBBWutx9Q+ya+BxnzN9ds/+JEl4F44ZI7tls/3SIVgRWK2U3DMOExnm6en1vTivE0AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:16:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 08:16:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 27 Feb 2026 16:18:20 +0800
Subject: [PATCH 1/3] NFS: flexfilelayout: return ERR_PTR from
 nfs4_ff_alloc_deviceid_node() and fix caller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-nfs-v1-1-2a6ea2ca8528@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea2baf6e-6f9d-4f36-5556-08de75d89257
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	KVa1VyD+COXTpVKZf0eigX8kI86WfLP7yxSqea0FUWq5foZG+dVsmE9cntOVhIEFNJ3KjqsXgLZ+iLTfEDaHpy+Og+fgEla7RjJc+Fhe9CnsKSyyuS1DG0d+koXO7LNMoF+nYbxpF5i3MYXW+cMepdDrdYOi8TNds2GK5tldCcCyoMzdQxN964j+7Wi/Jb5vb2KKqSJikIBbfqtJ58t8pufa1o7ZDHea8ldxi/fbGBD5ANhWVHg4mNWUZyf4KNlr5PepFeyDFr2moo8+saR4Cw0hFk/b10umVw0t2unmKY55tPRGFeQAypMcuUisZhetSSpa35bufg7VKFUiq0bGh7iIStHNVwOeVvqykRr/810GbcL1X88Lb83I1GOtvoeuWfqBTm7bwavlJQi1hrJe6qmI0GGiR1nLkSr3T6wCi2yvAfyyClHa4KTrZL7dz/epxJrgJ8uO4vhxeOIJz0Q9+ZUwIMwFaqYYKftRc+/cN7UQ58Acr+EGB4Bq3uT3WWX7BKC5FJrYteowSZX96Pm8PR0yzPk01QSbondm7QztJyN83WOs7TQQKHVjhUUI4T1TakStFDuHRXDuz5YzC5N5KKmMLtKMdsth9utkSDoBf0FEUYshGSsFM5fkgstKsQcmJWtHpKI9U4AlTfp7FVl2ziq/75o3qkVJoXoyI4FgdN04JdDfWNW/aTdHrz5fh+UiqGMHsoLhwd0EID37+G31NX5qxy2wwWGB2srjM7B1TuGpZzKWvYSmJjT8503YTJ/NTvDXp7j5IsIvWcrV1Ts5WqlOw07XWXBSK9HRLjnWuD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjZRLzM5cmIycmtsU1JDUzl0TWxGcGpONUZDWE1lYkNPZVBoYWxDcnpuclpS?=
 =?utf-8?B?V21NMVlsMXpJVHhDTVZJZGpGNGRuT1dEZlFvUXVCMEJIRnZZUi8wRTl0TURa?=
 =?utf-8?B?NUhBbVJhNXBaWE5sUkFPczJCZ200WXVxNVFURFhkcnF1WXdxMDlDaHI5azhU?=
 =?utf-8?B?UnhnaW4vT0d4d0JweiswWCtQd3BoTTd4VzNHK1RrTzRMU2lzMiszTWk0SWlz?=
 =?utf-8?B?ZHZOV2owU2V3OFBIVWxmeXhyWGloR1lTUGNxd2JrM21yQVBaOXZmcmRTL3p1?=
 =?utf-8?B?R1c1dmF5SFIyeFlUZ29mQ0Vyek5DWHVlUUE5SGcwSlB0bkxsYzVkT0NwNmxn?=
 =?utf-8?B?RDdNQ0VEQUdSc2NjVFI5TWg1UjNGSjFJTUJWNVdiNWJyN1gwZVp3ZlNPWXBx?=
 =?utf-8?B?YXI3T3dqNUJIdjhqWEF3RlNpcDB3aGRycGhMb04rTm1OWjhxcTF0clduUTVU?=
 =?utf-8?B?ODhXbEtFUmwxL1M1cDlqa2NteDNjdnJTQlNGcWRRVG9tRmZaUUJCU3BpMExF?=
 =?utf-8?B?TVplYmNlS0p5dEJGd0RBN2VJaS9jSnhpaTVUUUVzNEs3eUo4bXkvRDRJVFdz?=
 =?utf-8?B?WHd6bXU0blllMm05RlF5NHRNa0Ztenh6VEV3ZGZEV0pCR2dpMStRRWw0MkVR?=
 =?utf-8?B?VTk1bUhwV1FTRThSTEtlc0hiSElMcE5YM21Fbm1LNU14VjNIUHpDdCtWZzBW?=
 =?utf-8?B?MmpCaVF3NGp3UzUyV00zc0xBOTBtdld6b0ZwNm9BNUQ1REd1SGxuR1RBc0xZ?=
 =?utf-8?B?b21aYXY3WVA3ZVNNa2VrWHE2ODJzZzM5bndudTY0UGZ3VWp2aW9ENWNRVWc5?=
 =?utf-8?B?SGhhOFQ0eWkzVWxXV0xjWDA3YWpuTTZBQlFIVjVpT044b0lKallFNlUxMUJJ?=
 =?utf-8?B?Nmo2dHJyS1lid1FDdHFFK3RCUE9PcDFBdkV0OXVxaUc4ZHE3MitjN2VZU0kx?=
 =?utf-8?B?aVVzemk0ZTNDVEN6TWNTd3RoaS9leEw1OVQ5SzVONFNZZFhEVkFxMXc3MHR4?=
 =?utf-8?B?NTFqUnI5d01CMFE2Zk5RWXNnTzlQanBoMERIMnFwQUpSckFaZ2wzY3BBM1BO?=
 =?utf-8?B?TTd4MXB2aXNDWThvcHV6MmhIUWF2ek5ZNndrd3g0b3ZBY1h1N3U1STNiVDRV?=
 =?utf-8?B?akJtQXVwL05nVEpzLzhtc0RqU3Zvcmg0MS8wZzFhdk1uQUF0S2g2ek8vRnky?=
 =?utf-8?B?Mi9vby92VjZtS2c3eHNsT3lxQzRNV1V0MkRsQWhIQWRoa0xROFFvSlJjaDVw?=
 =?utf-8?B?R2p2UHpIQk9GejRteGk3SzZUdVZsT0J6ZWpoYThBZEQxMGFibTVwelFReG1B?=
 =?utf-8?B?eThzYythYUZpOFVYYUdkZkQ5aFJFVmZtdFhpQkJuY1FhczJNZjAwT3BWSHJ3?=
 =?utf-8?B?dDgwWFJ0OTlZTFRQZllaUnJ1VlJWQUtXL2g5MVZQTG0yY25HQVNPY3VoU2gw?=
 =?utf-8?B?WHA5MGVCQ3hsMHhqTDZXRUZlY0hVYTdUUFZUQmdraVpvN05BUXAveVVQL3Uv?=
 =?utf-8?B?SkN6ZTI4am5qUGJxRkhKRkU5cE9vVDllelNMdkdSbkUyc2cvUU9vOTJFWmM5?=
 =?utf-8?B?cHlSbkpxaWhuSDAzNXJNUmtnSFlncHAveGIvYjV0QWlZYUhSWnZmdGhEalVk?=
 =?utf-8?B?YS92bHVKZkpMTGxlYVh5clh4M0FtK2F2djVLanZySEdXMkVQM2Zva0RtcFBN?=
 =?utf-8?B?KzRNVTh2aCtnOUV6UXZJUW5SZGtIb1V3QVZJWGpwRzVlMzQ4OWJoQmNqQjcy?=
 =?utf-8?B?VXpDS0hBeW5wL0hveXhMN0R6elpIRW9WQm4zdVp3bWo3Mis0UlZpektlS3RV?=
 =?utf-8?B?c1YvUmx3TkZKTUM0TWxSQ3VXRUI3VlQzdGxEZmJKTFlYQzhuRnNlbm1EdXhh?=
 =?utf-8?B?amJSS2hCL3c0YzhaMUl6YS9Dby9KQkU3VkJ4THFJdllIdUJVZU5sVWNXSlJC?=
 =?utf-8?B?YXdFMy91RG1HbFIrb1hoU0RYME1PUG1NQ3VUZGNHQlRWTmxwZWl6YVlqSlIw?=
 =?utf-8?B?WHcwVTd0WmQ1dllOZXc4a3Y1U0FqZTZsbzBkdUwyd2RNb1dYRkp6dGhjdExo?=
 =?utf-8?B?cTZURk5HWUtQSmZGV0VheU9WK1pFS3hwaVpnUG1XeCt4aDBKb1JjUGN6cU1U?=
 =?utf-8?B?T3I5NEFJTVNlQm9MN0huWlFXRklnVkdldkNmNHhlb2h0cktZVzdvSForclpu?=
 =?utf-8?B?R211VG44Z1BjZ1JNeTRQL3lkRng1YjdVMnkzUmNVS0FoY08xK1ZBSFVOSWxl?=
 =?utf-8?B?OWEzMURXNk1qK1BIamtSZU9TUkEyNk9HQytGb1EzWHFiamV4WDNnM2NoRzJW?=
 =?utf-8?B?dTh3N252Sm5rSUFMMXpRVkljMTZXaS9pS3FrRHJtMVI3WVNXaTNoUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2baf6e-6f9d-4f36-5556-08de75d89257
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:16:56.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /odyWc8PfmpbgjpZqw0ItKDHPzMi7Hia8ZHsYSTxs5qqlJBux5tOKRjw/8xnjIFpdQqzq6KnqbeMxdjC2QsPWg==
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
	TAGGED_FROM(0.00)[bounces-19386-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Queue-Id: E20731B4750
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

nfs4_ff_alloc_deviceid_node() initialized 'ret' but never returned it,
triggering W=1:

  fs/nfs/flexfilelayout/flexfilelayoutdev.c:56:9: error: variable 'ret'
  set but not used [-Werror=unused-but-set-variable]

The function also returned NULL on error, dropping the specific errno
stored in 'ret'. Convert it to return ERR_PTR(ret) instead, and update
ff_layout_alloc_deviceid_node() to detect errors using IS_ERR().
This preserves the error code for callers and aligns the helper with
common ERR_PTR-returning allocation patterns. It also resolves the build
warning.

No functional change for success paths; improves error reporting.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f67773d52830d2ab4d12dd04caccc2077d4105e0..cd175204807600ff4e33ff769e03ef7ac700a6dc 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2566,7 +2566,7 @@ ff_layout_alloc_deviceid_node(struct nfs_server *server,
 	struct nfs4_ff_layout_ds *dsaddr;
 
 	dsaddr = nfs4_ff_alloc_deviceid_node(server, pdev, gfp_flags);
-	if (!dsaddr)
+	if (IS_ERR(dsaddr))
 		return NULL;
 	return &dsaddr->id_node;
 }
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c40395ae081429f315ccee6b73eafc742b4f01a4..9e36350b10fa84d5e2a2e6f25fce36ed504285ce 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -181,7 +181,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	kfree(new_ds);
 
 	dprintk("%s ERROR: returning %d\n", __func__, ret);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void extend_ds_error(struct nfs4_ff_layout_ds_err *err,

-- 
2.37.1


