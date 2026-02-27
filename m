Return-Path: <linux-nfs+bounces-19387-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NsmIntToWkfsAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19387-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:19:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C71B465A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB56A306187A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1538A72B;
	Fri, 27 Feb 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jNPDtgUX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105438A702;
	Fri, 27 Feb 2026 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180224; cv=fail; b=u35dMR1RBelw+3VURelRURGHUrEhLjv8jfzuEw4VWJal7MynYeVgCe0SrmDEA8HwuRTO9TLxdV5RGX7u5O2GVn2I6kHgxNJ5S1UpVUNXur6u/u2spgUBT52+9XbEowl2nBX0jh4zIiB8WB5nUkpsTh2+lX1RKvJJc1ILgmeL3Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180224; c=relaxed/simple;
	bh=sTaJdrGelw3lG6J9HML12v/kq63zGeMxOkDG7gg/Mw0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s4UpXDmnpEOERi70nJKFHVyNPOBnVnFRmoGNQsGOZ9tPuLZE0L2/iVihBS/466IEE7pQRVXPGLljMntEwShJ6vktK45KfMAJPBL12/tn518BBvIwZMdOuPpPCkZFlvqEjEp/mIm7hot0XAlWyNndIDfwF08IdpHrclSoCI25gmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jNPDtgUX; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixgZyJqfqK5JoVWVkNRSBalapKeh/Qf7AWQFt1XjYSE6SxbjaiksPjL2KajU7BVntaNLSm77UQp7bYCN+Dtdt/tkqp3YneTM93R6q6y8L9J5HTCHB5wXwq5q0BzzYVV+P3z9H757Rt0SRyGer/VnaNXZVPfaOHA1iT/Gs8iOiIoU6dqPXso4zXR5lBRNii6e0QefJmJee7Sv5RjJ1v1oAfEAfNsCynKnjrHxvu8655tlu/nY6gYpuIReXGj9sth+2vSqWkg5BpgEccl6Zq2I5uaYVxSsOcrVuBWYcBjZ1t+VNuWA6XIMDjlq4+ukDcQTUrpHOWLFospQh14btqi1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emC8WAoHvIEAhVvf6AdKz1R6mVyEc8B/UFBqxTioe5I=;
 b=Ps9uQXI3WIaGWxu+y/cVe+stmg20QAx3vPj+CcUOxGGIfgz6zNopGaqC4SIkw8pT/InalDdwEI829kaZR9fmA+XbHQjEFPqIsZkO1CZ/nRGaPMCmaQRx6cE/Yti68oks7zrZZefb1zZisAkedMFwoCTuMldavU8s/SOqjqNIiVUIkasvjh/F54FQdApYrUiT19bAuanvEETQUrky1AJw6oc/oPSqb66+JLekTuUGtVNZ0fTrzMMQKHQugy3vFIeoqNXN4+n6cD6xyPIqetUtO03rFRU9uAaGZtJgk720AACYdZdcnf27p5AKrNPnaRRo61GpFKLVrPWr5nQo/is2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emC8WAoHvIEAhVvf6AdKz1R6mVyEc8B/UFBqxTioe5I=;
 b=jNPDtgUXLF42GD53UvwelISymr+qT8MX29r/VqCEzw8Zz3RrosuHvhLYrLxLclTIodaYBI8oucWPLUB4CnocT3w5pcNDKWC99w0Qkimmfgui34zxn9OTyRLPWeiRvc17Yt40kHgxebX1azy168xdB+FVnt1L70xePwS/8WEsO+R6XPtRk62iQrXQQ1gSYdah+Ee9PVYlp646GyCfIxETQ+QOfpnyMYXk0sviR4anxIZuKylJg0GgCRvSf+9WCbp2+/OrBXGwKT6hC9G2v22N/S4qVOZVnRnCQRAvgu0pwveR2DaODdcKAofTaD/WGF1CgfnO0wNPfJHaClKW5BnyGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:16:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 08:16:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 27 Feb 2026 16:18:21 +0800
Subject: [PATCH 2/3] NFS: flexfilelayout: Mark err as __maybe_unused in
 ff_layout_io_track_ds_error
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-nfs-v1-2-2a6ea2ca8528@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1580dee8-b702-428d-43fc-08de75d893a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	HoYKxWEddC8ComNFqG8MzOgeBmoDrADX9jw0A94+BR5GhI3zw9xG74jJGw65Rr0SWojFqW6+AEl4EwbpZ0RZF1uglJyIoHTstGPrrbLccwIuZGnOIWLK4pEvDbf2C51D0sPkLysSks8RbH/GXZCR10k8PAqkusEE1R5rvzWWLKODIEbCYNVrLduHbDYzfPwUcVhoKzKzphLXyzVavqTx1vnZlIn3jccGpjqOsjMG1d99gme+7XSsOiR/npAxu2UX1ZKI7nf3NioWTuL3DyVXSVTd8cekt4tTdvI6y1b1ntpUVn7wJRiYi6BkAjb6Cv8X4RygqzQvHo7FCZVX+Qs9wp8yz/L841Hy9DSY3rG/Sroy+ik855rXyOPgJDvZEdBtUKMHOOmK2cCqIKFg19JGQOb7R6rEA5/Ux2PG3OkvAYzuC7PH+sQ84PbSIk419gyLLWBVy7oDb7UlrivoI0pUn8McBiWpL9jh0WbBCv62IlWWk2ZcOCqdrRM+m12ydaeVkkCUqQfVJIsFfaHbYPO9AoU0jbGy68oITtiRCWhgyCyKnSlO+EN4vM22iGFKVCG9IwEeEF9rOPXZ+6BVahhFb/IDnbkQlJTXtGVz0C81KZbiP2GMwPXrt5E1DutFZCEE/picHPFFGxJvZm2NH+ZRcRARHbz57W6+AE+9MU+G4lva6RSXcs83T5NbllyOUdB99abeGJ0t9ycF4/wrBW3A8MnGA8mymonnMZdBoKSXYdhXemCKyzoZDur1MOZ56qkUMe3hw8SOCm6z2uYQNVKkpoS5R7Hs9bcvXfm6rA3EUX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzZ1YkJvcDZ4YzdYOEYybXhWb3BOTFVYdXRzN1p5Z2hzNVdpVVF3R21ycC9j?=
 =?utf-8?B?cnhycnhoQjBXSHI1NGlqRmtJa0ErUGlNUGdTckR5MFc0aXBuTVhKQlQ5M3Fh?=
 =?utf-8?B?ZnltSzE2U2FueEZTaHRWWmxBc0hiTEFIWk5YaFVMMnJNSGJVcU5Fb0lhWGFo?=
 =?utf-8?B?ZjJXSUZXeHFMRkk2LzVrbnR5VFd3RTY4Q0RiKytjZUgwZ3lZSWI3U0RoeUt0?=
 =?utf-8?B?UnN1SGRqZ0h3NmRMc0tFcSt6YW5zQkhJdGlvQUlHa0hEeGs3Z3NtT21VcTRi?=
 =?utf-8?B?ZkwrWTZvUjVkVE9qMjRCMExJbi8xWnNaNzVScHF1Ujl0Z00xWXllMEtWMGpK?=
 =?utf-8?B?MEtXMUhUekJzclVqemZrdHZhSW4xTU9jMnJoWnBiY0ptRVhuOU5MQ1FtNi8x?=
 =?utf-8?B?eVRQN0dMRTRjTXRKZ2pKU2prZGtnZ1laMHZ1ZDVhQmQzNGw2dVd6SUhMKzJJ?=
 =?utf-8?B?SnJsTGpxb1lQbG9GNk0vM1JhdnN0MUtyZDhudFBwM0NCeUZkSTdFd2dZWVN3?=
 =?utf-8?B?M3RDdG91SEtvc1lHWHNzWGJQckJvTzVuWmhjdG5kZVF3VU5IMThZNWZDWi83?=
 =?utf-8?B?MytFMjdPTFRTTzhTWDVlREpxOXJXSnB6NmVaRUMycFE5ZTQvekRlUVJPWDM1?=
 =?utf-8?B?aVVTckZ5SkJpYmpUaWR5ZFFEUDd6dWx0NlJKZllNZjUzQVBHNDU3YS9Ud0NJ?=
 =?utf-8?B?d0dkd0ZUSUFDTm5aOEtRZmliNHIwUXFPQXhzb2NydEU1YXh1MjRWN05ZSURn?=
 =?utf-8?B?TDNGbjdlckJjY0V6V01OWEovbGR6d2VjaXQza0M1S2hKeFI5RW5PR1JDTjRu?=
 =?utf-8?B?eFBQOCtCL2FHYTVabUZHQTdQY3pyL0JmTVU4aW5CL2VmUkY1SVhJMm5HRFJD?=
 =?utf-8?B?Q2wrRVA1UjEvSGpCd3RSOXdGWjhXNjFQYnZpTm1YcytMYVhZNGNBLzdadHJ6?=
 =?utf-8?B?NUpwZWQrRmZnQ0VLSysrZDN1ZXFYVStwQVdldGxUU3Aza2ZVTEp0NWg4YXNv?=
 =?utf-8?B?REQyTnJRNGJzRHhoS0d4YmRUS1VpWUxKaGdKYUsxUHE5SXBDNGFuNThNeXBa?=
 =?utf-8?B?V2R3bUZwa1hUSEpON05LWlVtRi8ydXVlZTVLU1pXMHlCbG9TSWhVbE5zR1Mz?=
 =?utf-8?B?VjVmWXVpcG5EK05RV0p5ODc1RnB0U0ZlS0cvTndUZGVxK0tXR3htd0F6SmZZ?=
 =?utf-8?B?bTJNSnV0a2Jpem5HQmdhWFJwN2dWNzNiUklKVXIrTmx5T1AzREpzZWpPN0Vr?=
 =?utf-8?B?QWNUR2Z6Vnp2dWw5azRza24vWlpMaEwxRmRsc1Z3eGNoeHdaWGFWSXY2RmJq?=
 =?utf-8?B?enY3SVNRSTlQQVJkdGJGeTZqWjhaUTFRdUpzR3o3MTRJTk5RZnNUVzlXd0V5?=
 =?utf-8?B?OHgxNll1ZERudFJJKzdLZndQSkQzTkM2ckYzODZXOTl4Zmp3QW1MeFdJK1Rl?=
 =?utf-8?B?anFCbGEwRjgrYXRnSGxQR2UxL2hjZlBpZEdzUG9SdTB0VitaL2FqMDBVV2pi?=
 =?utf-8?B?b0YvMktYK3lFWkxINVJCL2g1NExndEpKNHJIN2hLOE9WZVVzdDQxMldVMFpt?=
 =?utf-8?B?NW1BQ3FIRGNrenk0azFDTEYxY0xvZ0tDSVVETk1JRXJtaWpZSTZhbEZ6ajFI?=
 =?utf-8?B?WE9hSkcrNG1SeG9Kd2ZIWkpac3ZPd3BpTGR2R1BsV2RMTVNyRitQSGlIVUI1?=
 =?utf-8?B?T0FlUnlkQW16Z0U0Yk1YSjVPWHhhL0FBM2FnM0lwVXBiYlRiSEkzT1NTVk05?=
 =?utf-8?B?WGxVRVFpTTl0NDkxekFOSDV3ZVpHKzNQSjBVbml3L3pIUCtSalpBekdicUhW?=
 =?utf-8?B?SGgyNnl5bXdpa3dTVUpaQnh4Vk10VDRaQWVKUHptc1JsV1RMOFNUZlJNQkdM?=
 =?utf-8?B?b2xsb0t3Qi9ncWc0dVp6MFVvRFVLK2hnVHF3SDM4SzV2VC9uMXJ3Q1FqNFdS?=
 =?utf-8?B?SHhDTFRnYWNBTXNaZ1lpMGpyL2pLQ2xsdUhsMHpQbHVMb2t6T21UZ2hwS1Nv?=
 =?utf-8?B?cmRQZFdMa1hyaFQzQTNyVzE2Ni9SZXpROWZIRE9hZlFrTWZxT1hsUTJWeG8z?=
 =?utf-8?B?VElGN0NlaFhOczRvRDRoanhsVjJwWXAwN0x5VllsVVZKV1V5RGwreUVXaE1N?=
 =?utf-8?B?dVRiZUZ5cUN0U1ZkM2lrSnl6dHhQb09EN0NOTWFtOE42cWFJQ3Rya2lxWnV0?=
 =?utf-8?B?b0NLQmJlNXNwZjFpSS9Wc3NSbUF6ZUFqNk1zbWMzNWZDS3dVTFQ5cTdSUlpn?=
 =?utf-8?B?Um5kQndxVWV2VXUrV1NRRldRdmcveklOb1Fhb01CMVp1ZzVsdndaR3F1ZWYv?=
 =?utf-8?B?bGlieEpsb2UzakorVjhZaHhpb1BYa2FJMytZUHM5RWxjQ2lKRWVPdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1580dee8-b702-428d-43fc-08de75d893a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:16:58.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WmSgdppKPENMe1gy/7CXP28GjOfE0HCqgpE669jDYonr14a7oRG6RCiQvFM0wPRl8xMUQnH76iEMGzMTR78fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19387-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Queue-Id: 6A3C71B465A
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

Fix the following compiler warning when building with W=1:

  flexfilelayout.c: In function 'ff_layout_io_track_ds_error':
  flexfilelayout.c:1503:6:
  error: variable 'err' set but not used [-Werror=unused-but-set-variable]
   1503 |  int err;
        |      ^~~

Variable 'err' is assigned the return value of ff_layout_track_ds_error()
but is only used in the dprintk() debug statement at the end of the
function. When debug output is disabled, the variable appears unused to
the compiler.

Mark it as __maybe_unused to indicate this is intentional.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index cd175204807600ff4e33ff769e03ef7ac700a6dc..1d8099337652a1cdbcaf58d394a6e981e8e7e413 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1500,7 +1500,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	u32 status = *op_status;
-	int err;
+	int err __maybe_unused;
 
 	if (status == 0) {
 		switch (error) {

-- 
2.37.1


