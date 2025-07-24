Return-Path: <linux-nfs+bounces-13227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555CB10B5E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021D15819A5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4FA2D9492;
	Thu, 24 Jul 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rP5hRccJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t/tQOnBy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EBF2D8774
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363731; cv=fail; b=dUgGbT3UOlE14ZKk5oluW+p0Ru5hKoP8IcN6Ob02X+s/TjI7rBWL9ktrlz/T2js6KejTykR6D/cspKNUKKCqNOhfMkC+aUpfoKJaPxAI/FoT/+09cT3VC/H31wqTaH9YVx6/BV67y0QCo3LHqikL+T2qUQ4huh1JXtjUC09+5R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363731; c=relaxed/simple;
	bh=mHLwi1wiS92QGZWEmuGE3m3YHzbBwIwbIjLOaGSDE7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IW5WfGsHuEJzsVdKId0xVLe0zCl8al+2pAJ+9V/FuTT2ySwlLKDUmNyyQJG7R1Nqa8ZRhKycuaMLuijheKxztwJ64/jT7JSDD+x3FEHbR7DV1L9Dpt90CZO1Deh9BW/dmegsTHMPvVnDrl9brFXVM4d1jnpXEu4+eMQJQGxnnKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rP5hRccJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t/tQOnBy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRKw5017669;
	Thu, 24 Jul 2025 13:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UXd8xjOzsUFfG8Ro9rxnVy29dBW6jbtoBQXOpS07aF0=; b=
	rP5hRccJ1TpM8tqkVxAcZv/f3MvFmN9lUK0b/0bMU0jBVGGJCSFIPFOgu9STsa/f
	BuIX5ZPNpMwYnFo/wTDfXGtEq6gASdw9eDEZi/oM4MaI9JqEwxLDCHLXQX853yld
	BnE0k0H/WQoqWnP0NERzmBNNAwGPqB/kviSmkrTmxUhZQ11fn1RT/6E/m4i882i1
	nQSO42OZwxJFc7IzNEZdgek8Q0WYiu1BhzxC1JFU9q+rZu99wJwju8ZljghGGHDG
	naR+Lv8Nr+TXHC6IVngsb3IwAke2GqPsYTjE5RZ/nBCCrGkqMeNj9dSSRljFLZbY
	CFKMboREjVUP8Ve9WGy1vA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056ehfsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:28:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OBWFjm006053;
	Thu, 24 Jul 2025 13:28:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbuppk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4JiPTOZTvHPj5ffksLxgkfxxOAcfXrOh8vz2agZPfkwp7Qirmd5WB6XfiYlqcAV7kMB8OLWAmL82MS8P/MG+IT9YzNqTehSqKo85mxUsWOJS0pHLy7+w6+qOyY8THHHiLi2ca/81ywOo53ddu2lyk0r0bd7YEVajFd51m27Rd1YU4HfR/TBKitjieE66xYe8YCfeVs2i6OoQr+IWbjJzI0Y+byi6SptSO5HKXuw/DughfVDX1PDHHUieDoLTOlejYsqlfb/XQfJUwk5zqGAloqL7cab2Gi9CdK8yh5owZhYVJd0eYGj30aGFZj1cP+Ml4NeRp0oL0oZjOL21BdmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXd8xjOzsUFfG8Ro9rxnVy29dBW6jbtoBQXOpS07aF0=;
 b=H4CKrOFbw3b4El6/8JFMaDtluXJhi3RPOiPZUOMoGzk/ePTTCcuw/kSw9Pv13cf40Z+bksA3KlunkA2Vr0uphQp0Uu2krqeNZ3AEooXsLjr/rjempM0SSjpu3nlpqepDMjec450we47WF/+TeripW3ZOmAjMX89eOl73bqtTFlVPtPfHUsOuocYI48PRiy1D2xXZfFIQeA+KEDfCwatIQPEMUp+CnjmDs8uiHQvy1Asz46ZnORTWfG7Vymd37hQs77E17IDVigP5UtCqys1uaoClGxLLzP4+kVSH3DEH0xJ2DAYxk8tsF5hdEo2m73FprWhajkUcfrKc5bhHAgZsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXd8xjOzsUFfG8Ro9rxnVy29dBW6jbtoBQXOpS07aF0=;
 b=t/tQOnByLpBY7z3ly7N64caon6FyRndrHaGnfeP1p6szX7k3uX8u7slfE6VCDXDIS442crA6I2roCrdRQEAAMuUkk/KQ5acoGeawcOKO6OEH2kUZdhU3tcAjtaa18f2yANRRr3L3mso7og+d4V0XxQi5b0+SEDl58igtrPYifOI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6105.namprd10.prod.outlook.com (2603:10b6:510:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 24 Jul
 2025 13:28:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.023; Thu, 24 Jul 2025
 13:28:41 +0000
Message-ID: <558b51b6-6f0d-434d-ac3c-a7989453017f@oracle.com>
Date: Thu, 24 Jul 2025 09:28:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] NFS DIRECT: handle misaligned READ and WRITE for
 LOCALIO
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
 <aIEskxZEnEq1qK80@kernel.org>
 <db121b40-f3da-4ecc-9e07-e3c3c8979b91@oracle.com>
 <aIF14KpfHWI2239c@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aIF14KpfHWI2239c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 0040171b-b9a9-4b9c-ecf9-08ddcab60113
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OXF3MjNEQ2RMTEFwUHBOQ3BkeDNnbW9paE9uaTVxWnJCWmpLdjlJaHA1WS9l?=
 =?utf-8?B?d3I4WmxDVk81M05sZWp3QmJrR05mOHl3QmR6R1IxU0ZmbDUxRDE3YTM0dzVL?=
 =?utf-8?B?a0NQdVFZUUVpRUhMVHViek9lM0ltMnBzY0RkSnNOV0FWbThvdWMxQUhSanFr?=
 =?utf-8?B?QUdhWEV2Y0pBUDZHdWN6TXhreWU3c2l1VTZydXZoc0JCWkxCNngxMGpZMldh?=
 =?utf-8?B?KzVBL3FLRGM0RERsZ2FqUlRaU2JEOEdZSFVVM0pRUExsb0FRUEdHY3VMREpV?=
 =?utf-8?B?MUZrZnRVS2dWWkdQeUxkTjl6M09DK3oyN1pHWGJ2Zk1hbnVFR2NLejc1U2Fp?=
 =?utf-8?B?eWhZbTJMUFVKSEU0c3dxNnc1RGk0TG56M3V4bjFUNmEzRlprWHE3SWtpNWFw?=
 =?utf-8?B?VlR3WHlQTHZ1Q0FzM0xxYmNlK2NOdWxzU1FzSzdYZVdKalIrVmt6MG5HVnNH?=
 =?utf-8?B?UDdiQUgwYUQyTFpEY0tKZGFMNDhjVFAyZXN4NENrS0UyRk5FamdPQktOcm8x?=
 =?utf-8?B?ZGdOYzB0OU9UK0lPdXZhTUdxMzBSdGxIMWFhbWt4T3lVSVFzUU14dG91VUI0?=
 =?utf-8?B?ZFpCeHczV3pnLzA5dDBtZHh1YmFkZUFXdDB4cGJkOE9NRFNNSUFFVVMvbTRC?=
 =?utf-8?B?ekU1bmtzb0htWkNpdEZsTjYyOERqRk5jUGttdWVrSEwwd1ZPbUg0VWx2MWZB?=
 =?utf-8?B?S0RRVWxjeC9CL3ZNSCtMMWpzTmNkVGdBVXlVOUgrNnZXVGc5Z0Z5cUhHUk5p?=
 =?utf-8?B?OGJ5MkIxMHhNYksvQ1EvSFBrTVc2SnZzdnBQUUo2WFdSZjBPQ2VESGk3Zndi?=
 =?utf-8?B?OTM0R1RML3cwZDZhMGV5R2pISC9BMWZ5M1N0OHF0cUhoczgzZ3lOZ3lLYjNS?=
 =?utf-8?B?dGJoc0NWb1BSaTk0ZzVVMTBIN0tCUFhIaFV6Zm0wTnJDRlFOSWFKdGRpK2Nm?=
 =?utf-8?B?TlFHM2FuMEZabVovY1lPa2dTNHZOcGIvcXpBTnhkSUIrNjJqanpGRjR1UjJ5?=
 =?utf-8?B?TDlGRVhiMVpRV0hiZFpQY3pQdVRuOUIvei9pellYbFVKbHQvZElXZ0hkN0Nh?=
 =?utf-8?B?bzhVcVVWdi9wN2tiR2xhaDhrTkJxK1VHSDA2M0dPa0UyQm5Bb2JWQ3V1R0dV?=
 =?utf-8?B?V3dobk9xcXJsNFlhbDVIbXlUN3Rmb0xzM0NRbkpzcW15aTRZRzF5U2c0UGVk?=
 =?utf-8?B?MEJsUkZpYTBUcGFzOVhhd1VDWEJRVnc3RzBBcFh3MHpRY0lxS1dHV3JORGda?=
 =?utf-8?B?V1RyWVJKT1JnOTdYQzl5SXgyeWNyS29xV1B4MWZTY01lYWpiLzl0Q0V4SGdT?=
 =?utf-8?B?UXBxbmMvTkhLbFNkazNtY1hEL21rOFJXbzJvdmNLYStUMnptUHVucVpxMGZi?=
 =?utf-8?B?RWsyeUJzSlVlZHlZRDc0Q0ZrTXBSbklYcmxhZDFaZEZpb3R0MDRqY0pHc2hh?=
 =?utf-8?B?SEpKanJYVzd5dFFVdExJUVFkME5vNDV4bjdwRGxZZ2p6REVrTnhrSEMvRVZ2?=
 =?utf-8?B?R3lqejRUc1RzcnJlMWlkUi9XRURLQnVOeU9pRisvby9qRGVUVEljYUZJTHc5?=
 =?utf-8?B?NjZnSjN1emNIQm1DYUo1YnFKd0N0ZkMvREJBOEVGbGlTNUI1QWtLYUcyakpo?=
 =?utf-8?B?Rkl5OTNyUHdWdmEvL2dmMG1FMUFxNWR3cVVtUzg4M2JUeFRISldKMmNzdll4?=
 =?utf-8?B?QVBEUVJlNEdvbWFTcEJOZkVlY2FvUHhRME40UVp4SGFJbmJ5bkxjN1cvVjVk?=
 =?utf-8?B?QWtxNFhFVG8vYUJRdjlaWWNHdDZZRlVjOWpYUngwMGhpdTlXRVI0eXg1Y2FO?=
 =?utf-8?B?Vmt5UVBBUkNjSk1ZQW0zMWZhMUpDM0kxQmJNSHN6NTA0dEVNMkdWUmtkN0w5?=
 =?utf-8?B?UDlpODlEUTlteUthVnBuRVpUWmk5QmpMSGROL2l0aEtaaktrcFpFV1Z3KzJS?=
 =?utf-8?Q?UxN1cbSpLv0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TVhBU2gzRGhZbWlBVWk1K091SWhLaHI3amFiaFU5OEJlZWNBOHRCWFV4b2hL?=
 =?utf-8?B?Q0pLKzkya090a2IrMlY0K25yR3U5NzFMODIwNHJWVTZQTWM0YTJNSENTbmky?=
 =?utf-8?B?SFRlcTFKdFl2RTdjSk9GaHVjVDFOVFZpcTdvRFMzRmF2ak9TbVFlL2NSSzRy?=
 =?utf-8?B?QmdmOFRxOUZ0L21WNllqOUNvb3daeDg0VUZ5WVY1QnBaVnBVcTI3YmtFb3Nm?=
 =?utf-8?B?SWRLTnpGbkJybWl4Q2kvUUlMemRpMnZpZmZGN2FudlFjM21GZ1g2eVZBVDBl?=
 =?utf-8?B?dnAzT2VYK0l5eHJjQ1BKeXJzc24xbDRQK3JIamkxMmVnUmdXbDQ5QkZqNTdm?=
 =?utf-8?B?SUFIZU5TZUlQVVl1Ry9kTXVOOERPK2N2Z295dVExUG9TT1JLVytSR1NiNWxu?=
 =?utf-8?B?bFUzSkpBWDU4ZGZ6MW1DUHhJU1VMRDNOa3F4dk5GTGNhdUV3T1BZYUYydUZF?=
 =?utf-8?B?RTlYYm1ubVNXVGdVNzNqb1BFV2pRUytzMm12Zng4VHVMRTk3MDNReDBneUZv?=
 =?utf-8?B?R21VMnZqZW1pRkFCMVlScTFKUlhBdVRYTkR0aFN0a20vK0FJOU9RV05seEMx?=
 =?utf-8?B?aWx6ditqaGcwTU1sWHcwOWtTdG9sMU5EZGt5dVNkTXRuVmkybUM5WG51UzF3?=
 =?utf-8?B?TUJBVUk5U0p5c3RpdnllYURKS3N1REhhYTJjNXU5VTkwYlc2QVpCTGZEUi9p?=
 =?utf-8?B?b2p2RDc5WUp3dHptb3ZxYVpFTHhSUHIwMStXVUF2ejRtb0JVYjd3SGNwak9v?=
 =?utf-8?B?UTl0OGdIRGZVR0FwZmJ6cnhlZmNIK0hNbnB5Q2xOUHFNVUJKZE9aaEUrelRt?=
 =?utf-8?B?eWV0ZEVOQ0lJdHc3WFJBLzhkaFJqY0E1QXJ6L3pQcGx1QUxlUkxJVVVsODE5?=
 =?utf-8?B?d3h6eDRZODJiVkJsZUowNGllNkFWN0dTTDU4KzFxenhDczFkelhqUHpLdjdH?=
 =?utf-8?B?WU9xWXhiUVVxYnF4ZmRXWEc0R1B6OFBid3dtNXhITXhVWWpEcFhZdlZGSTMw?=
 =?utf-8?B?WXN2MjRvTmhVOGcvYWZZZkh6Qm56Z2MwRFgvNFNiREJmR05odnUrcEwvUUlP?=
 =?utf-8?B?Z2FQaHF6cGIzNjBFMExpWUhIWFpUVDh3d1RxZGlrOU51eHg1SlF5Q3FNUGJQ?=
 =?utf-8?B?T0ptVU5oRmVFVmFZVkJRQ0Jra0tXV2JaTFRCSno5QTM4Yi9EQlhpa1hBRHVS?=
 =?utf-8?B?Ni9Fa1RxRFNrUEpnUFlmMVZrbmsySWdHT2pNME9Gc0diVmlOb1MxZHJCbExr?=
 =?utf-8?B?bFN4S29TTEhpSEIvb0hnd1lqSFlkU0ZGMVk1MzV5YlU3REdDOGRldmdoeDg1?=
 =?utf-8?B?dzBqRkovWDZiYkpyQnNCbjZNMDBLSUxZejRKelpXWVVuTmNlSStLUDhYUHRk?=
 =?utf-8?B?Q0ZOSStYWjZnSnozRVVPaSswZ1lTWHBtd1NwVWxLcHhVOWxYa09MZUZCL2R6?=
 =?utf-8?B?aTM2MHA3ZUNMRDBZRFl2ZERHd0JwUlUyVEtCV0xrNkxhaFpnNnphWnY3VDA3?=
 =?utf-8?B?SmRoQWFydGh0WkRFQ3NrMlhyUzNxL2hoSGk4ak10cmQwU3NHRFlqUWRmK1pN?=
 =?utf-8?B?Sm9Ga04yNVVVUVFDekVLU1NPYTdLVjV6aVk1b1BMcWVXcm5PVU1rSFJEK0F3?=
 =?utf-8?B?N2pGUG90Si82a1h0MkRRaThyM2p3aDFQWnFQRGhUL2p4WFZEOW91RjBOREpu?=
 =?utf-8?B?M0NHOUhUaFBhbXR6bS9vdjFlczJJa295OFlxTGRya0JCcHB1alhML09yNmR1?=
 =?utf-8?B?Tzl6ZHpMWUdwbWlvblhzdjZDM21OOXJIdFlBZXRmRlMyWUUzdUs1TE1jdkNj?=
 =?utf-8?B?TS9PQmkydzNuSUVLYUpBbGptY0MvZ1p5TiszYWpYNERsQ28wd2pxUmhoNWJK?=
 =?utf-8?B?NGVkU0RIRmRQcXIrMVdtME9UNFhPOXN5VjBoaTZjTnpNMHZTdzM4OVF1MDFo?=
 =?utf-8?B?QUQ1VlJDQUJHK0NUTVJjdDVLaWhlcmljbjczbnAvN240c0ZoaE94UDM5dlZK?=
 =?utf-8?B?YjZXUEFuOWJ3ejJFT241cjl6Qmo1NVJOeHdSZXNNZjltcmp1b3RxOWZ1cEVk?=
 =?utf-8?B?ZkpzWUVhd3hIZ2dyakY1ZjFxRDh2aGt3SmhLOXJVNHBCMjV5N0ZwVkZJR0pY?=
 =?utf-8?B?bVNrRytRakRoanpKUFJkMWJqSElmRkN0RFlHWEsrZVVaZzFscHlua3Q0UTEx?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nOObYspGS5XyR0YXwcmpsG8ldb/VCpCwMQ4A1sIiAWX6fRhRxGRkCkN2KFis3jhAPwfdS7ox7sR27eNU81ALkBoctIOLwIMGnqf+ceSnUMC7tFo5T6PLkP3Vtzgams1zItw0hmnoAOTktvcL/kiEw3mu1w3n0mHrIo2/f2GRYBkVGCeaCFRMy5jqqLFuN4OpIse7HD/P0aAHXZj+hKFl29El+uJvkDmn3+l+rVNPxlL4GrCFecMwndiizncq1QPt/2ly5Yi/F/STLz0n3WbGNo482vVq+MxE4UhULchxFF3Gr6IcZfNrWPGOxX/vJ8LtTFS3v5hc17E8bpLFDwMFkVmMP2UHf154Pfkkh7Bxpcq4jiadBVmq2fp9v22cX/0dKdxWwcx6R7xbPMnnIowlyjdHgGqI2m+ZxHQ+RVk9QyT9xE0YK7itjvBbbYQbANRZVxLi/UraPUpXu4lgLATYJ82ADQZXtPLBv1zaXB0WYcaeBE9opw+jQ/zrxfJ/mQPANF1/YvZLm0FY8ZoXqlxP2mPtmiTRAlLUFzVuR8irH/NNUn4WRZOdaFzSndUG1YUx1vSo7z9wAyoGCtx6AZ7JsBskltWGw6Q0Rkg3MYYb2Yc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0040171b-b9a9-4b9c-ecf9-08ddcab60113
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 13:28:40.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB8MsHgqBNMIluR5gdkKW/JpvU2Lxhp5dm/mnqMK3LOZ19Ep87RKd0hUhIDjPo3U3TI1SdG7mvCEKBqLmyeVRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507240102
X-Proofpoint-ORIG-GUID: sCV9dhaCu8BbGjzPj5O0bgBr6hn3zJ90
X-Proofpoint-GUID: sCV9dhaCu8BbGjzPj5O0bgBr6hn3zJ90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwMiBTYWx0ZWRfX+qxvtRxdq3UO
 jv7IKjQvn9ypWPO7TWXF1fZCXkxQq3KICi6OTR615uFiBfhi2weJqDny8rDzRJRIi2LLc9FRIcm
 NYu4TI5PPRrnUzs4dYWh0PjzJENlmzbGGtxBcjt1xFoVZVoKEKRbqM4ab7uKydd/6EiESwjWq/o
 VVx9QpPnqg1iAft9aF3Lzzf28IGkIXiPflixLQn6YLxYv5DRB4EMMaWag0oer2PxiUJOM9AtaOa
 BhDgExq8FGdfQ/UAFHQVxWuOx+bFa7pE8cKK8+sRkN+eNTNnY1mhuG2NUDZwAQSDBsRQ6Fg5Xf7
 XhwcR1BDPca5mNdhDrDqIeQR5r9sDpMMz8sQqyaQjn/LD8ef++nOYoP0JLHSzosPvJSXoeYuyRQ
 KXHhefL5HFwAxOlcWPf+um1D7LjrUpuyquOXOz/cwSDKpmlS4+KOKT+4LhmWWk8Z4I3KaQIu
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=6882350d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=Q8LltDUBKyJTjxovYx0A:9 a=QEXdDO2ut3YA:10

On 7/23/25 7:53 PM, Mike Snitzer wrote:
> On Wed, Jul 23, 2025 at 02:42:56PM -0400, Chuck Lever wrote:
>> On 7/23/25 2:40 PM, Mike Snitzer wrote:
>>> On Mon, Jul 21, 2025 at 10:49:17PM -0400, Mike Snitzer wrote:
>>>> Hi,
>>>>
>>>> This "NFS DIRECT" series depends on the "NFSD DIRECT" series here:
>>>> https://lore.kernel.org/linux-nfs/20250714224216.14329-1-snitzer@kernel.org/
>>>> (for the benefit of nfsd_file_dio_alignment patch in this series)
>>>>
>>>> The first patch was posted as part of a LOCALIO revert series I posted
>>>> a week or so ago, thankfully that series isn't needed thanks to Trond
>>>> and Neil's efforts.  BUT the first patch is needed, has Reviewed-by
>>>> from Jeff and Neil and is marked for stable@.
>>>>
>>>> The biggest change in v2 is the introduction of O_DIRECT misaligned
>>>> READ and WRITE handling for the benefit of LOCALIO. Please see patches
>>>> 6 and 7 for more details.
>>>
>>> Turns out that these NFS client (fs/nfs/direct.c) changes that focused
>>> on benefiting LOCALIO actually also benefit NFSD if/when it is
>>> configured to use O_DIRECT [0].
>>>
>>> Such that the NFS client's O_DIRECT code will split any misaligned
>>> WRITE IO and NFSD will then happily issue the DIO-aligned "middle" of
>>> a given misaligned WRITE IO down to the underlying filesystem.
>>>
>>> Same goes for READ, NFS client will expand the front of any misaligned
>>> READ such that the bulk of the IO becomes DIO-aligned (only the final
>>> partial tail page is misaligned).
>>>
>>> So with the NFS client changes in this series we actually don't _need_
>>> NFSD to have the same type of misaligned IO analysis and handling to
>>> expand READs or split WRITEs to be DIO-aligned.  Which reduces work
>>> that NFSD needs to do by leaning on the NFS client having the
>>> capability.
>>
>> I'm not quite following. Does that apply to non-Linux NFS clients too?
> 
> No, old Linux clients without these changes or non-Linux clients
> wouldn't have the capabilities offered (extending READs, splitting
> WRITEs to be DIO-aligned).  The question is: do we care?  Long-term:
> probably.

It sounds like we can't rely on clients to align the payload for NFSD.
So I'd say "we care".

Maybe NFSD could recognize when the content is already properly aligned
and take a shorter code path? I'm not familiar enough with your patches
yet to make a guess.


> I'd be fine with the NFSD DIRECT's misaligned IO support (READ already
> implemented/posted [0], WRITE partially implemented but not posted) to 
> be land upstream so that we have the benefit of making the most of
> NFSD's O_DIRECT support even if the client doesn't take steps to issue
> IO that is DIO-aligned.
> 
> Whichever way we go, it is potentially convenient that the less
> "involved" NFSD DIRECT patch 5 [0] could be withheld initially.  Let
> the NFS client do the lifting for us assessing how well NFSD's
> O_DIRECT works and yet have confidence that we can deploy support for
> old Linux clients or non-Linux clients in the future by merging that
> patch 5 (and NFSD misaligned WRITE support comparable to NFS's WRITE
> splitting in this series [1]) in a secondary phase.
> 
> Good to have options.
> 
> Mike
> 
> [0]: https://lore.kernel.org/linux-nfs/20250723154351.59042-6-snitzer@kernel.org/
> [1]: https://lore.kernel.org/linux-nfs/20250722024924.49877-8-snitzer@kernel.org/


-- 
Chuck Lever

