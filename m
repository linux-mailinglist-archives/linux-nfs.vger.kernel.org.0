Return-Path: <linux-nfs+bounces-15952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD71C2DD09
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 597FD4E318C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A12208961;
	Mon,  3 Nov 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p39tuykP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cyTsLcKs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C76347C3
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197281; cv=fail; b=M0uXcNdRW28HpukxYNsbJLLUBOtwlYpwHP9sdgCAitwUdPGhLZVfo54VdFCzJsH1D3hUfZR5Vn2BPh35LqNvPb5rkmbFK6b2Cb32fHDmd1A3GQxoICcZnJQPYb8IKOCVGideh/CC7Gm244z4XHK3EH4OeuH1ORh6+3P3vO+4tRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197281; c=relaxed/simple;
	bh=DfCyNXRfD7gqK5h3kaOnzncyDfk73c+M8O48+5DHbEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioWayhO2i87WsUpw1cPknylNzbbWcJxmyK6KQu5tVx4heDVc80LtbdutKMlEPtIZelFajZenmMEXcTXAcCSU3HItlF8rhzKpJSjUiiTCSatfUVCZe5r7z2v5qw2hnhe3KfzoAd8n3/8l9vFds3wBinjGH84KPYOoeYogd1tHErc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p39tuykP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cyTsLcKs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3JA1ws003853;
	Mon, 3 Nov 2025 19:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gI9rhGqz4rmzvwLCaOAwJtE3bJWB4+OauZEBOIF4KmM=; b=
	p39tuykPD5NteoSwKW7Tr99rffLZnhnF3mz/OTRk/Iv8JwlgoENW7kuwVEUZzc0h
	2nZot09w6tZ7vaKkDWQGKDoo3FsamdoBkGVcZgov6dCCNBc4yTQoXokI987fpLGb
	IyYKiLWSe8UVmKNDLBwEo7c216q3SRtDzX3nBO0ZCmCAaBgRcgqYsRGK4tf+zt1k
	Kc9p4k3qVKkKm7reipziEkr/J00fNc4jcu4NP0Q/KvyZRYnIeWK4f5r569N1WMPO
	urpRFNvuopM40anC+8U8SGNS5ox8gcR00Lfj4Fx3y3FzY/CnfnPFg1tdPPd2cVl8
	CGoZzr7imw2ky8bO4RgBxg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a72a680m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:14:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3IB21I039800;
	Mon, 3 Nov 2025 19:14:28 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58njbwcc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:14:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jao3AEQTSg4VD5/xx9DBn5xEoprCWiTcI/ohq3x9bhRWu1MpW1XLBHNkpR5UxIsEEfX3T8GaEVLaFOAXVhWLt6U2J88tgPtJv2GqxLU2hpI2zArpoj1Geylh56q1bSUgJdSe7FvIgEVll1HmeWpOPNApW8o9JdESIoLSBnEPUp1rgi3MGJfQs+ijfijdksR25A3jFW9RtAs+KcKFUc/ETQuT9WPvbpyQXfLB0ll/vBiK4He7kTfVcGx9zLXg+H6fGcaDMRm72vOD0aWOBD3BNDpcA7ub1JlhlxCZtiRw8nZY7RkpJWvBc/EAOar5gdKwJT0IAOFjJ9lZaf/thREa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gI9rhGqz4rmzvwLCaOAwJtE3bJWB4+OauZEBOIF4KmM=;
 b=DgTNM/FmAdVhXYgvOKZAbMcYAUGP9VSQpADMbh9y+31tPUjSEfoRxTPIm/A2MpYZCu7KwUPBwtWOFxHZ5zeXA7FG/AF3t0HWNapzaBw4Cy2eb6pAIXUC1HV23P6JPrKKQr7LLJKRX+E1FdmvbL/mQ8kFKw+JRJk4RDH7kWnFJKi9Yc1fZFH93KkCt1Z4Ikwz4fYdWlfHJlDpau8Rxgu6lbC9ulhG0tgEo+UZv4tYSgbYQiIl77oZwwAMlPXk9dHSMvzgpZd6v2/Vf2WQ6yL+9IkvFnnbod8R2Fdx5UhaXUj3Vues7k9Ndc3uVko5GuHVsjDCSeRjrqnozhsucRG+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI9rhGqz4rmzvwLCaOAwJtE3bJWB4+OauZEBOIF4KmM=;
 b=cyTsLcKsnUobCtZq8Ai6IIpwEiPllC7WPvaDTWQWWhZ7GyyzLXIDpr1XfBV78Oc5RuyF4Hr3YqXrA26vdIbSrB07F0WyJQ8QisMG2Q/HEibched+EM58HKsI1U+dJw+4OPhm56Lci5sDIIO3W54Tg9aYlkE3Nh0a7fg1IASkWEQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:14:19 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:14:19 +0000
Message-ID: <f4ddebf0-7039-47c9-8e20-9622c8b33ddd@oracle.com>
Date: Mon, 3 Nov 2025 11:14:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
 <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
 <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
 <f0d7da8c-2447-4f57-a64c-6a8eb7853019@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f0d7da8c-2447-4f57-a64c-6a8eb7853019@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::18) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4b65bb-4041-4002-3552-08de1b0d3009
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZnEweDZpNE01ODhCQUJ6VWFsWXM2TzhTNXRvVHZFT3hrSSszMWhNVUFYeUdE?=
 =?utf-8?B?T0IxS1RPY0JpeTFDK0hHd2JOSG5SZ2FwRzRXeHB6MVY2dkg4cmE2UlE3U2x3?=
 =?utf-8?B?SElQV1JrNUU5NWxRZ3ZHRmd0cUdQbHBlZ21GUHY1cWFhWnZGU254aXV4NnN6?=
 =?utf-8?B?bDNvOTVRQ2pld2xCVkJuQ29FUzNFNzlMRkhzek9ZNko0MndiMWpZclcvVTlz?=
 =?utf-8?B?b0JJSE5uRUNibTIreWYyNjZ5TDk1VVEwMVEzcEQ4cFMwSG1sczdhOVozTkpX?=
 =?utf-8?B?WGg2SFdVN1RqMG1HVnZ4dTFHM0JDbHN1dXhSbSsrRnYwYmc1ZDB6MGhMRGdH?=
 =?utf-8?B?TVcvdkhwbWJic1ZsWXNxdzFVSHpta3RTdGN6MG9SYklMSUs3cTVWeWI0K29l?=
 =?utf-8?B?Z3BJT01PandITWRQenJVK2doNzE1QTZuMjJvdWdBMmhRNFhjU2RrQ2FYUFpG?=
 =?utf-8?B?ZGcwOGkyaDBoZDEyVERsS3RDRmh1eHBrY1RvVnV5MnUrNVh4YWlRNCtrUCtr?=
 =?utf-8?B?K2FxSnk1Q3R0UCtORDNhc0htZzlya0t3SGlYVW40ZXN1eGErOGJrYS94Nmtm?=
 =?utf-8?B?ZmtNanFkK1hMOFFSanlaS2Zlc1RJYjRxa2FMeC9ka081Q0lEbTdKeVVnMWp2?=
 =?utf-8?B?U1RYMWJWcGhEd0tGR3BNZEM1KzcxMjBKSDBBdDdCYm1KT2dLQUN2b01tTWRN?=
 =?utf-8?B?QUtqcldvWjRINFJ4d2oyaVhRaHZ4MnF3Qk9vd3BKSThnMTNrVjNxSDl2bmxJ?=
 =?utf-8?B?ZWRGMDhmaEFZMmgyTHd6RDhuK0RiK052SDZxeHFFdVdsYTVqdklNZ0M0ZTFx?=
 =?utf-8?B?Z21HS2ppV1NUSHlMVnZPcm5QRlhNNUpkdHlFcVpoaW1ublVybWNPSWVMNVQr?=
 =?utf-8?B?SUIzcDArTlprTFRzSnBzMVdnWHpHRmtpKy9xcnJvcldRNnA5dm5wbnBsK3VJ?=
 =?utf-8?B?Y2ZrbUZic3BsdXE1bWZSQlhMbHVNeUlKS3VGUEF6dzFjVDFMeElqcFBrQWtu?=
 =?utf-8?B?UjdiMGhrUWdRQzlqRkFvaGJRQ2F1M2RyZFVOWVRQNXY2SHV3NS9JZ0x2QlJO?=
 =?utf-8?B?MnR2MW43Q1haRTIrbDF1T1paS2VQazJRNDFUOHh2eTlDaVI0Mk5aVmMraDg5?=
 =?utf-8?B?WFJCdmtiZ0JWRnJNR0lWY3A3K2ZHcVNkTUpuZFIvTFVSWWJxVU9maDQvOTk3?=
 =?utf-8?B?VkFPZkxCejRKeG9WL0o3RHdCaWhNM2txMUtiRTVLUFFHRzl1STJITWp4UDdz?=
 =?utf-8?B?V3A4WDg1V256MTZZVExyYjNqem14QlJqVXF6anUvdzFmempUZThHNTZSaTN1?=
 =?utf-8?B?bXg1czFEVHJBNmxNSXNvQzU1UitEdHZ6dkk2eSt4cGR2cXZnMTM3bmo5MnFT?=
 =?utf-8?B?eXdIRXYwOTlOVUxPTWJ1RkpOcU9VSEN4Nitnc2lodkxaemxjQU83cGNTa056?=
 =?utf-8?B?RXhiem9hOWk1L0I2ZVBNS1FNREMrU3V2M1d5UnBaREpnMkw3Z09QeXk4Qm1H?=
 =?utf-8?B?eGhNU1VzdUFlNW5WWHRTc1FoOGY1bG9pT1lhRkc1ckR2Q3VNOXVZQ2psaFVP?=
 =?utf-8?B?RnNIVFNtcXgxWXEzdms5cVRwbyt0azdNcDJzbmdBM1Uyc0RqUU05cXJ3dHNu?=
 =?utf-8?B?N0tYVWx6MVlJSWRYNWMzSE1MQVF2NXlPSnFwR0xFRGQyMkZYdXlUdk5HZHRr?=
 =?utf-8?B?NTZrdThieDdwYzk3UG9HSUlUNDk5ZStiRnRnNExnUnpOUGllN1JsTUlOa3hB?=
 =?utf-8?B?NUxTdFZtZDlYc1QrZXdVRDNyb2NmYjg1bTZNMEpOdnphTVBPRnNMZms0OWRr?=
 =?utf-8?B?U3FnUDdJQmhlK1VpMTg0aFBaWWt2RFhWaXRCaDRnY2tVOXNlQXhtL01nOFZ3?=
 =?utf-8?B?b3F5MEpDbGpGUllXRWlhUHZLVkhEVzNrUEVHeUhRenNlMDhNY1F1TFBQZzM4?=
 =?utf-8?Q?V1MIpH7+VNPGhDw1v4sOJxneOLl/pi/N?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L042bCtCTHpmcGVHVzRDaEgwaW1qQzVXQnVoeG1mYlNSN3llNG5pcDN2cW9E?=
 =?utf-8?B?c0ZHdThPODZVcDB6SWl6RE0wN3Vra1dxd1crcGQ0aWJtVjQ2ajdtS2V5QTdl?=
 =?utf-8?B?bTFkMmgySXNSMllRa2JLNTJyalo0NGNaTGtYYXBNR3F6REY0ZzR3cE94d3Fm?=
 =?utf-8?B?bXZRSGdteWRiSTdmTHlobjYrZEU1WTA0ZHNhR1k0R1hseWwrQkRSZUFUQmJw?=
 =?utf-8?B?azROVGpCMkY0WmJXWG5mMFdFKzhZaDYzUTVBVy8wVXVScGpnTE1YcnV5aCtW?=
 =?utf-8?B?ZE1VSXpNS0cxK3dyR2FmN0I3VTZxRkp5eXdJS0lEQThENXczYmdCT21OYWF0?=
 =?utf-8?B?aThDNnJtcG55c2dGT1FkWjN6K0phcnc3cXRqOWlHSTRsRFRiM3FqRGxkaXJN?=
 =?utf-8?B?TWowbUdYR3pkTWxuTy9CS0g5YUZRY0ZmUGljandKb2l5eHhHTlBWYThKY21U?=
 =?utf-8?B?elBtOTJMcU5mVXFwa3ErWXgyMzNKbXNmT1F6QlRxQ2xTVmNjTURFZXk0NHU2?=
 =?utf-8?B?QU91a2dHWUhEY2dNT1p5bHNmK1o1S2htWFhXcXRSSU53eUVlZU95UE9Zd0pU?=
 =?utf-8?B?TDRJNWU1Mnl3dmlVRHp0SjZwa3RIcnFHV3FOOUxoNCt2eDBrQ2Z4UjJmNHo2?=
 =?utf-8?B?bndCaXFmK2VPN1hyV0F0ZkxxNEpiQmpLZ1NlYzJVTEV1d211K0RWM2dYVzVt?=
 =?utf-8?B?REY1Yk5GUmR1VG1ueFpjS1Rod3hIakI2Slo5a2hYRjd4dXZmZjBjUC94NE50?=
 =?utf-8?B?dUJScmJweUlPaDJ6cFAxenQ3Z3M4UFhpaEVCT0FoWkd3QVJBQ1lxSnhweUVv?=
 =?utf-8?B?bnRadzlXYjh3RlRrY3ZNU21sTGVwZzFtQ3dRSkdPN0R0TFFsWjZTWGNjRDVZ?=
 =?utf-8?B?RDJUd25zQXhyU2hDUS95bVg1RWhaN0tkUFZCUjVvT2ZzYWx6aUIvSlNnYU9K?=
 =?utf-8?B?RzNpQmRDQUxDS1h0Z2JtVlh4YUxVY0wwRDVLSWZBWkQ1VGEyYXE0cTdheklz?=
 =?utf-8?B?M2dETWVweEhqNDVRbVRnQWM5bG5TYnJjYTl6aG9IWDlaYkgvbnB1d2NHYmRi?=
 =?utf-8?B?Z2NOVjNoQkRTNUI4eXo3SFF1bXkxZ0hSNjdjQjNIcGRKdWxRYU0xcVFqRjZx?=
 =?utf-8?B?YUhZR3JJTjdsNjNtQWFwUkNCOHF3QmhadldoZDlYSjRxMTNlaXEwSFZEdlBi?=
 =?utf-8?B?Z2lWdm1qMHQ5TXZJQXBvMGZtMUoxKzBrK002RXZPMHRJTGFKeTNYMHRFT25H?=
 =?utf-8?B?OVV4dlBVdGhyN0V1cFVuWDJJS2U4VW10cDRzc0g5bnFVMkRCOGFpT1RZeWlG?=
 =?utf-8?B?Smc2Tm5tTkVSYWpTK3k1RzNJalBlbEh5S21XbmV4YlZ6Z0kycWtuTHF6c3ZN?=
 =?utf-8?B?dk1rVWdFTW11aHREOC92QlRpcE5PYnBJekdtZnAzdWtpMkZMdHhpREFLTGhE?=
 =?utf-8?B?RWViZnVBUFpoUm1KYjRESE5YbGE4K3k1ZnZhN1dSVlcvcWtDRFZjZ1dJdGhm?=
 =?utf-8?B?U00wUi8xd1A1bWl6dVN3aFhhelVpbERnTzh0eFNxamlzMDdWdHNtR3VlOG9j?=
 =?utf-8?B?TjZEN3RMa2lLOGcvVDk5RTRSYjRCcERlV0RGRkJnZmVjN24xRmNVZTgyWGp1?=
 =?utf-8?B?SndpSGdYMXZxR0owNHh3aUc0NXBTZm1GYmtHRG1zNFJWcVVyTWFXN2NJWkdF?=
 =?utf-8?B?Ym9sWDlxdUZDUVJvLzgrUnQ4UzV2TUpPOUZLOW9abHlaOEdqR2pJY0YvV1NS?=
 =?utf-8?B?WjU5UG44V0tELzdKK2piR3FtS2ZvM2UxekJVWmI4Q3p2THV6a3dIL2kwdGZx?=
 =?utf-8?B?YVhHRFdscGRVbExSSFNzbGZDaHI4dHhyc0hvdCtwNHAyWnJkRDRXcVlFNi8r?=
 =?utf-8?B?QlkyM29KejZKdVNDSG5MWFlzWC9nT3pEQ1hvL2ZYeTVKY3JRYkhLUFFlYkp3?=
 =?utf-8?B?bjBMQXhjRnBnZXZSY2o5clB3am9CVkVlUkYrTmxtaWVZNG9PejBEWEE0b2Uz?=
 =?utf-8?B?OWFMQnhXQXFlallpRTJCUWZNbmM2RW1ZZk90WlFsR1Q0M2pMQ1V1RCtzdjda?=
 =?utf-8?B?K01KY3d0Rm1US3k4ZlU0VEFNZmVWTjgvQlp5RG1PZVNuQjBOSU5QSUJOVGFt?=
 =?utf-8?Q?4mNlXTYOQzenXQwufsYmi3pp3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OsIUGuj6157qbCPB5KclwXTO7wVYY1HiaG2jxlLunbtFaFmvMAjB98OZj/IQjf6YjpXQ2wh3YX99jEt53Yb8vGGKlO3Sugl2QWYvvQCzCYJOVtYz4PGy4hreijHxSqWAi/EZ5F7mQ9rh5qlUSFpRYj3p7RTvY44yupZy/q/fcBPVmTd3aqfDbApraO4cjOZq3VdOMQdQmg2Sc9vi15l4nZwSeqXq9IASH28G+st6yONX9ijlsvGMSd8QEkgJaRdEvwsOBn8zVSAMOAhlvmDSVHleXGqBHKCr6CuPgDwmAup8fvm8pDNvLclxHvvl4qDpXHuVnu6n48M2jpn/oz8Zm8XggTkkmLtt69b3FEcuwOH5xiSCsUeviR/uGUDNbeXF8tiR1y71OCY/9/bxznQG67xDkIUrxzrMf3zxlJBy0lZ1q5TQDlANVaKN+VDRaFlLXkP4DFgXevquHHC6f6TJjm2T1sILEllYWwGRn3TV2d+MzUVANnrcb7X/+ABSmOtBOtQ0HAW5hj4soaeOAW8v8F1e4Z2alwD9SEsf3bD6gshwLBGx9AmJKJOXKij4zcSGgIUOmpmfBzdnHQHvMvWMI00svVaBivaAYnnvafx0nuk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4b65bb-4041-4002-3552-08de1b0d3009
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:14:18.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m+JZXTbegduWIPBiScNITMNdyKZkd0JU4O1szCazXymRofx29eUlV4IDNC48L/vUtk0YLzD5JPVzOu5jHb3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030172
X-Proofpoint-ORIG-GUID: DTuwsjwtFa40yrWVMN2FQSlEtcFFX31x
X-Proofpoint-GUID: DTuwsjwtFa40yrWVMN2FQSlEtcFFX31x
X-Authority-Analysis: v=2.4 cv=Sq6dKfO0 c=1 sm=1 tr=0 ts=6908ff15 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3wobetPjXWxLU0Hacc8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE3MiBTYWx0ZWRfX9AbVCo3xPSmr
 WlVuM7TOZkgiJyURfPPxcmkymbQc+0JJWErQvSqVX/2TcEmmkEe8h/UtFL66D1W1J+9+4sJYyk4
 BLmbIy/oZTcgMM5mWIZPbwcDiGLfXbEPlZntY/cXR8v6BfqcdVSABExgAgRxtx60h2QVv68Lt6R
 qI+gS9hPZgvEKFIOBw2Wa8PbEejk5+2ATSuj98KimowPODVEgnRYmrKdVRUmfmZJ83rN6JJSzsX
 waGnXnPBuidnuTRQoSZkFuZK9hM7PODVY+rZzAK3IDzTTw5uwPEE0IYFkECd5AAIxKbdxNT3EVT
 LzwjSszicYgaJIZZ7XxyuLtjKJR3R9+bKoL8oKtpkE/gxb8wuhe8YJAQxMhUF9RpMwNfOqk/pPa
 uN8mfS1I/bjxIU7FnuQjk+i+i53LulUeilgenUj/Zq9/Wv4v8fY=


On 11/3/25 10:57 AM, Chuck Lever wrote:
> On 11/3/25 1:50 PM, Dai Ngo wrote:
>> On 11/3/25 6:16 AM, Chuck Lever wrote:
>>> On 11/3/25 6:45 AM, Christoph Hellwig wrote:
>>>> On Sat, Nov 01, 2025 at 11:51:34AM -0700, Dai Ngo wrote:
>>>>> NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
>>>>> to the layout recall, no fencing is needed.
>>>> RFC 5661 specifies that error as:
>>>>
>>>>     The requester has attempted a retry of a Compound that it previously
>>>>     requested not be placed in the reply cache.
>>>>
>>>> which to me doesn't imply a positive action here.
>>> Agreed, this status code seems like a loss of synchronization of session
>>> state between the client and server, or an implementation bug. Ie, it
>>> seems to mean that at the very least, session re-negotiation is needed,
>>> at first blush. Should the server mark a callback channel FAULT, for
>>> instance?
>>>
>>>
>>>> But I'm not an
>>>> expert at reply cache semantics, so I'll leave others to correct me.
>>>> But please add a more detailed comment and commit log as this is
>>>> completely unintuitive.
>>> The session state and the state of the layout are at two different
>>> and separate layers. Connect the dots to show that not fencing is
>>> the correct action and will result in recovery of full backchannel
>>> operation while maintaining the integrity of the file's content.
>>>
>>> So IMHO reviewers need this patch description to provide:
>>>
>>> - How this came up during your testing (and maybe a small reproducer)
>>>
>>> - An explanation of why leaving the client unfenced is appropriate
>>>
>>> - A discussion of what will happen when the server subsequently sends
>>>     another operation on this session slot
>> Here is the sequence of events that leads to NFS4ERR_RETRY_UNCACHED_REP:
>>
>> 1. Server sends CB_LAYOUTRECALL with stateID seqid 2
>> 2. Client replies NFS4ERR_NOMATCHING_LAYOUT
>> 3. Server does not receive the reply due to hard hang - no server thread
>>     available to service the reply (I will post a fix for this problem)
>> 4. Server RPC times out waiting for the reply, nfsd4_cb_sequence_done
>>     is called with cb_seq_status == 1, nfsd4_mark_cb_fault is called
>>     and the request is re-queued.
>> 5. Client receives the same CB_LAYOUTRECALL with stateID seqid 2
>>     again and this time client replies with NFS4ERR_RETRY_UNCACHED_REP.
>>
>> This process repeats forever from step 4.
>>
>> In this scenario, the server does not have a chance to service the reply
>> therefor nfsd4_cb_layout_done was not called so no fencing happens.
>> However,
>> if somehow a server thread becomes available and nfsd4_cb_layout_done is
>> called with NFS4ERR_RETRY_UNCACHED_REP error then the client is fenced.
>> This stops the client from accessing the SCSI target for all layouts which
>> I think it's a bit harsh and unnecessary.
>>
>> This problem can be easily reproduced by running the git test.
> The problem is step 3, above. NFS4ERR_RETRY_UNCACHED_REP is not a
> fix for that,

Agreed, as I said, I will post a separate fix for the hang.

>   and I disagree that fencing is harsh, because
> NFS4ERR_RETRY_UNCACHED_REP is supposed to be quite rare, and of course
> there are other ways this error can happen.

Yes, this error should be rare. But is fencing the client is a correct
solution for it? IMHO, NFS4ERR_RETRY_UNCACHED_REP means the client has
received and replied to the server, it just somehow the server did not
see the reply due to many reasons. I think in this case we should just
mark the back channel down and let the client recover it, instead of
fencing the client.

>
> I don't understand the assessment that "the server does not have a
> chance to service the reply". The server /sends/ replies. For the
> backchannel, there should be an nfsd thread waiting for the reply...
> unless I've misunderstood something.

If all the server threads are waiting in __break_Lease then there is
no available server thread to service the replies, or any incoming
requests from the client. That's the hard hang problem that I mentioned
above.

-Dai


