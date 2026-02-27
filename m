Return-Path: <linux-nfs+bounces-19385-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G+EDPRToWkfsAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19385-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:21:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 784121B471C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D74A3013192
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3436494B;
	Fri, 27 Feb 2026 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hSc4qGik"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18438288D6;
	Fri, 27 Feb 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180219; cv=fail; b=YOdGVPUwAR+G4NJ6Fjlqf5TCFb0NDfwYnkAKg73+o8epYFuiZMqheUg5hqjn6dg/soMPGfmKojrcAHWQHPLQ3VT5cIVCbzIH+SMgJ1aqSKRQe5+C13+f04wCxpvI0GWPKfQA+ImkIZni9mvzgAGWhNjJ2xiDXQGxXiIMJ7TjX5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180219; c=relaxed/simple;
	bh=HhkBorB64Vr9eXaLHNSCzQx1FhLJIC/rmDEaD9y7cu8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=n+mm0JicbxnVNxKbvJxcSffCYUVuoxC/Jo78LQKMTAqSt8zcC4GVYk03m55tHVxGli/35rPiOZBioYjQaXVcX7jp6i48LeqvHY00ukjVmOWRNVdYGk3Z4bSwhrdnYqA1slPImn4hdk2d5yGyKEZVt3qP57ndouCfhAQZ/IMsYuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hSc4qGik; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9WDiWnvgNLeXi6fnMtxKZfLCMtAB7afuSun2HhIt0Sj8iRk2Ah0/h7cBY1rOquVXvcP+brXo+l59lPmErwK1/f+N9U+2mb9FyBEIx2FrZLcOpIn8Y2Ihkm4K9eIfoDOmps9ZrSub+Bt6Sji+eZF1EY8rczt/UmdHDJTXinbvnC8EIGEoLSN1UXkhUA1Q66VT/G+2/DfZpLhu6RNVbztJmsF9gkXgGB9VkRtX+fBkJkY0KKvtT6byuLGpqGsY31pYXveK869FOp7CbFBV+DjGJBgCYQ3BqOccB6zsgoHUmvIW2Qk3DkEKfnUbT6NMX4uHc+TviLyOl+6iZDt9ujK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/fkCobJvV8r4ZjUb7uehu9fPNZIxNHziKbbXpyxXhk=;
 b=DMisf5f9osLIFb5L1uxZYxQ6pfpAmZsFeb0+IDivlrhbIbSQbjxDgrHmig1lqK/XjwzS0NX6ABag/E8gzydJuy38AqT+0+S3+BICw4tozDzEs9WLeUn6maQAEdbY9TYhsOtadCYL4ISjqeY1r/Od9FoSlAMxWcVuGLADi/xWvCxfLoj0tLPoFHiiaepvHBh6kiTGVKREggVjJo5ERiNpcGZyqgRkw4LvjoJeCrxRcFgWQO4rTL1eukin9x/RDhwgitkCyyeXecGRpfstWkxUZNpccEuxyUejAWcrVLBVkUo3VHxPbo+w8sR+HGWwZIrVoe1n3SGR/SHK1L6Y5VDR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/fkCobJvV8r4ZjUb7uehu9fPNZIxNHziKbbXpyxXhk=;
 b=hSc4qGikbkuAl2o9/k2GRBGlT1bzix0LpnOPM/k+Abm3CEMBNm1ePwASzOEoLH5/jYWDSJAtEPVdxbBLPYyxW5yt2+Y7LXaBu2niyJ39dC/A/0lzOtsVaghcsHcGU7H8QN8YkzCMG6jnvJ1rLCDP5kQ0Yx/l/74h7MHexqXJzk2toJq5P4zOK3b8GvtgEJ6qCGpsK9dX7DMOpyi9nmuiR8qllUiuLHAo7fUcNy+vBCxQC4FQa3homBRCor1UvPoXmo3doo6CplE96HvQXAMB9nZ/grZ1b4JIKUL0DB/H4v5GsDOI9Zs5dTmaxjgMHcOZelesONPs3XsIzoIrwqNBaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:16:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 08:16:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] NFS: Address build error when built with W=1
Date: Fri, 27 Feb 2026 16:18:19 +0800
Message-Id: <20260227-nfs-v1-0-2a6ea2ca8528@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtToWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNz3by0Yt20NAMgtDRLS000VgKqLChKTcusAJsSHVtbCwByNke1VQA
 AAA==
X-Change-ID: 20260227-nfs-ff0f0f96fea3
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
X-MS-Office365-Filtering-Correlation-Id: ebe535d9-0b6f-4df1-d1a6-08de75d890d7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	tE9p9LlCeXT5a6GN0EwOpZVH/YvEDCdDMwusvhqWrCKXtKcwbTSEZz19Bxio1vp0hFIAOhToh5vd4/oCO5yWwN2rTSx7ScuL9bERtPwws5WKS5oczf0MXDaLpbTaTEpxBukU9OKe9A33uCU4ZBXJKNm7cq3K8rdleVhqjNRkzxUQNc9/Qbp9FJZOIFlFzrWbhBu0uNKd059mPdFSd+AC2iAwIjZ/Bg0d6TZrlaa6V0t9nPeOVzM+KPxZ1CmNGROSvCBiNEcqInx6X7cb7lloCnp4ARXiwqhm9RCcj2T8h4qfV4UXbscI+m9RugX76UbQ0gsV2nVQj+ZcjLhUM9JSX+2S4rkcryUvKo5q7dxggrWqwDbtSoIzDJtOnxdFJpcIL3FahzGalrviNJegfUyNtG/5hoG/xTrzIKGzfn91OJLU+gnDGhE0v26vTl/yqbHtFT8bS8zVGxebsoPY6xSxaqlC3dhmkZVpnp2rDNGzBZE8MQp2tCzz0mnMarDdYsx5ZLSaX/62XZzdtZfBX9vxzhgKoXDCNgcXqCJrlAzUlyNoMwsCro4AWCYz2QKfs8QwE3OoVrhU83havbUDHY2TKF+wBEIDdgTxQsjTuarHZS0zN9EtcHdNVLLnrZP7oAExf7D+zOj5+Vybw1Tx7RGxdLgAdItSx79M+f7iJ27+AhfzKDIzaDpuuF9D9IUlV/Kj4HNbNZZC+0YKCE9mq/+DcJNvO/i3ecg7DCAluXUd+7aQhKb2JUkWE1JSnX1M41EFk2d15msEkGD3N75JMSuowknEecYA/1vMRYFUWV8NxXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTBIckJodnVLRzJxSHhzb1VteGVFeTIwTkpIRzcybitqL1hocUp2RGJyV0s5?=
 =?utf-8?B?TlNzU1lkS3pOUWE1MlNiVm9XZWl6RkpXTDlvTXpqSkJxRGdLeWpXSllHNXFC?=
 =?utf-8?B?a3EwUlJYVjJycGtWZy9RYmdFNzZlR3NZY1ltZCtHSTR1QmwraGhYYWNnUVNN?=
 =?utf-8?B?aFB1bW5MTGIweVBlSVczQnRQWFk5bmR2a08xenYwNlhLWWloQ1N5QkJLSk9O?=
 =?utf-8?B?V0VBSHo0U0lDSmZPamxmcXkwdXBRWE9YTVkzaE5BdlIzeGVnTHBvK0V5b3g1?=
 =?utf-8?B?T1VJdVRoZ05hOHllL1EvM012YXlKSjNybjRGdk5ma1dpMldzVDJ3U2FoWndh?=
 =?utf-8?B?c0Z6SVFCQnp2di9VVWhuRUdvU2M3cmVBVUMrVk1nc2lkL3JzSmpYNkRrK2Vr?=
 =?utf-8?B?cWlOMlhUUE9YRTVoSWdGNkhEby9WYjE2N2RUZUlzeS9QVUZpdHNqeFV4RjVT?=
 =?utf-8?B?RmhCMDlMV29XNDUyWTdSdlJjbENxMEZuMWswcWc2MmZmbkozbkpIcXpXZGpr?=
 =?utf-8?B?Q2pBQlZ6YWhXV0cvNXdIK3BBU1Q1WUVyeXhFcUJsWTZkOGh3QWt1V0E4NjFU?=
 =?utf-8?B?bmJyNk1ESklMV2NncGlvNk53OFlZZXQ3NEc0WEJtak4xL25VTXVoN3VqN2RK?=
 =?utf-8?B?MEkvc2hOaExrdTBsQ0xpMVZuOVhwQytvODNLMXE0d24vUERJR0VGTVNiRG1D?=
 =?utf-8?B?SkVGdnExbkUyMUx4ZGpPYTAxSXo0TjlpWHQrMDVHWGhKTlBxL0thcmM1d2NO?=
 =?utf-8?B?NWdtMG9CdmdhVnZwcFJDcUVHYzVlVHYxNElpQkgrZFJ2cTlsdlNHQWxSeFRO?=
 =?utf-8?B?S3J4WVU1Ukl5dkFtU3RMZkkzdWFEWTN2RkVyVHhoUXppK2g5TFJIV0R2L0ZZ?=
 =?utf-8?B?QTBWZkEzYzJsejEwYWxaQVFkODFrMXMwbmFEMEYwRnMzRHJYbnZpMW1sMElE?=
 =?utf-8?B?dTcxVExGZmVYT3hub2d6OGJWZjcrbjBuT3ZtTUxQS2tWRGJWTHJFbEt5SHp2?=
 =?utf-8?B?Uzc3WUwyZlZISHNCUE1xcTR3RHpkMVdCM09oT2dtWlc4OU9vc3VyNmFYNzdB?=
 =?utf-8?B?dTNkVmFDTFhmOThwUWVObWlHbiszMThHbjU0UEZLQ2NoTU9yMlNwbmxSMjA4?=
 =?utf-8?B?UklYdFVkZ1ZZbXQ2NmZvaTVPZ2lOT0g1bm9UUEI2S2wvTGFtQzc3R3BWNndS?=
 =?utf-8?B?b01wcy92emJ4SE8yeWJOOTJNSDNiYk9Wb1ZPYWoyeEtUejJjVmV6VHhjWkY2?=
 =?utf-8?B?K2Rhdm04TlVUTTBHV2VJbEVZU0JRVU0rRG5ScitxSDhzT1dMczc5M2lDbUdR?=
 =?utf-8?B?NTBZTjRSeFRuQS9IVUs3MW1Xc0wxU0YxS01BRVFOUWJ0OVNhblBVQVdKeE9a?=
 =?utf-8?B?SFVKR3pTOENIOCtWclplYVhON05QUzlWSG9zNmtXRXMwd0JiYXFIaEk2dmJT?=
 =?utf-8?B?cUZXQlpKTmR1UmRGNEtpdjNua0E2Mm1qbHA1Uk9kSFgxQkN0K21xanovbUlF?=
 =?utf-8?B?bjVWcUdFcHJFZUNreHV0emwyYXUxM2w5cDZpQ2tzdkE0amQ4NHhyMDhoRSsr?=
 =?utf-8?B?TkFPZnA1MU4rUXNIZFk2cEZJZTl1dE9wMDRGMUVmeDEwSFJXTnFwSVFPNEhU?=
 =?utf-8?B?UCszcUtWUDZndi84elZlNEpxZHZkOXg5bGFCLzVjSWRvN2svVWNaa3BwbW9S?=
 =?utf-8?B?N2xodUZGU0JyaytTMDhGSGZtQjU0Y3RXN2RHR25pVHc2U1lCZ3p0b3A0T0Jw?=
 =?utf-8?B?VG5aS3pNRTltVXZYa0pRTW01THl1SzlaT1M1bVAxblIyVFNhU1A0NnFreXA1?=
 =?utf-8?B?QTNzWmtrN1R2VlVkeVRHOC9wUCtIZ0ROVisxQ1NYRzNCcytTRFoyUlU5aEVN?=
 =?utf-8?B?KzdaSlVNRmNRS1JKaFNETm80cTlrdDBZTDJiQmVmdWVTVi9rSXM5cGZycVlV?=
 =?utf-8?B?c2I1R3AwbXQrclE1VXNBc2ZIdWhQdTVTVDAxeXJ0ZFNLcHFaVytSNXlpY3A1?=
 =?utf-8?B?T0ZrQ3pXL0w5RVRIWmZDcHhFaHdFQSsxYi9aTUxHaTdOSjdmM0JqZjdBTENz?=
 =?utf-8?B?c2ZTMWsxRy9mWXNmUmtGWHFoRDZOSDBOR3BQTzN3RUI5eWJmZEJlS0V4QWVO?=
 =?utf-8?B?U0toaWVPRlYyaVErQzNXVklCY21oTWIxbld4ZnduaXFsUkRqZG1Tb2FTdVgr?=
 =?utf-8?B?OUIxWFhSVzZScTBZRG5uN2dRYTRHdkR5U2YrdUkwVVhTRGJmMkxxd0J4U2Uv?=
 =?utf-8?B?dGprcCtrSi9INkhCSUtEenlOUUloenE4LytwNE9lWTAyTmxXR25SZDlVdi9H?=
 =?utf-8?B?c29BVFFVYTBqNFJkSzN4VGtXWHRxdldHWlRHQy9ONU51aTg2OFU2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe535d9-0b6f-4df1-d1a6-08de75d890d7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:16:53.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB2jjnLE+VRvyJtrFEBiDojALFbnBeZDJXfiQaUoUpwmPgF8tZHtQQZFYsZ6MsUXE4JtFFy2092y1/klabdgdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	TAGGED_FROM(0.00)[bounces-19385-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Queue-Id: 784121B471C
X-Rspamd-Action: no action

I built x86_64_defconfig with COMPILE_TEST=y and W=1, then saw
three build errors from fs/nfs: "error: variable set but not used"

Detailed info could be found in each patch commit log.

With the patchset, kernel build pass.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      NFS: flexfilelayout: return ERR_PTR from nfs4_ff_alloc_deviceid_node() and fix caller
      NFS: flexfilelayout: Mark err as __maybe_unused in ff_layout_io_track_ds_error
      NFS: nfs4proc: Mark ptr as __maybe_unused in nfs4_proc_create_session

 fs/nfs/flexfilelayout/flexfilelayout.c    | 4 ++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 2 +-
 fs/nfs/nfs4proc.c                         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
change-id: 20260227-nfs-ff0f0f96fea3

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


