Return-Path: <linux-nfs+bounces-8909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2838A0158C
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4133A2F9B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFEB335C0;
	Sat,  4 Jan 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y/xGKDJa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oCf//kCl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78718E1F
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005056; cv=fail; b=IzcmF1T0X7ZB5AGceTS+LxcmdaTWuYG0FhiycS21oRa/3g1QUgxmXUhntFWwTRfk7ul5kUlEAzWXPl+E9IP2hjQDDZd6mkL4Ur6CPrg2rLA/S6JlSe9s/S1LOXDd7DsZCYXuT+oqnB6m26t6fTSx3t42p9YNMSkfS1cMwDvFbwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005056; c=relaxed/simple;
	bh=b0s9g1g1MioIbIo8sWkWgJmeCagZrnNG/chAgT7qz2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fyxLtzZL8FCIttKSsY1sFjpplX0F4/e+2yjeaC0LYx1QRksMdkqynpugNk0JXU40ejBpmoJwmi9O64sPI3Ieo3GsI2jj7s+I7D79euH3M43Q1w/yonI5543afG6SxviyoLEcg5JGionEIt+ZXFRWfGbPFVxxqNMe9EC1MgqV+k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y/xGKDJa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oCf//kCl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 504Cubgs015838;
	Sat, 4 Jan 2025 15:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=devNN80qwXT8GJdNek1QtEuKRL6Jg3fXy0g8zz/GJRk=; b=
	Y/xGKDJash3IFR8OkiheCZ0/C3gjxR0soITWERlIkYrCkKcKlxZbmQTvrLbkUhhO
	UZLOHQmxtSsNkEyYecuK2xehI6YIvkRxKtoNiH1y0vcQXmjFsUe87vPrQ/68aLRs
	Ql45f8j2ASwqeoPdcQMWqCmUqKqNBV3gJzHzc2v7rNbCAXj9FJz0JeUm+zmimqlc
	8sxGoBiW2E+4Dye3TtjeSPjUn5Hftz6KvrAflsumSCHNn6+QxVDrQPWomARmVbLf
	s8oNI+AqbSVnq0EMckCyJYDJSiwgEgQ7e0KjI1UC0Hk364j6fcGV7YnJmwLwyQtk
	uJ8LIq6zSUIMOSDvTyfoKQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb0k6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 15:37:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 504BdiOn027675;
	Sat, 4 Jan 2025 15:37:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue656qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 15:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tq6cSfqBLkajQuTDmr72QBQZ4NWc4aHJI/L5TpzRk4wyzSPL8q+vKMzDhYpXxUs5pe101GiAUlLNIOL/p5boXh0fDv97FunLUVGBg5eS47kjGNfHUfMyR3NY64Yx4mrzNr1OgcKMv3cyuY5SvMpWT2xspGElUEwSVtHYoe2QKvhLH1JoKKzeCLncdm6yXKZOC4ezQuSGI+S8+8dZz0B6CkOL2yx+bFFUxGmL/sH14wlxJUDcusowXTIIscdIeaw0p0zuHWSvwBDU95QrCDK5erN6Ul9I4MPNCpiC5zGRzp8NZ3rLKBB6sBoiD8yDryJYEFGv8q1n1+fnQ9EB2QPP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=devNN80qwXT8GJdNek1QtEuKRL6Jg3fXy0g8zz/GJRk=;
 b=TnwIkK7qb0UFQQlXeSEIa4PkoChbCErYlYaRg9yh74wmMYUp3Z4azAkQY/KSacxR1bKiE7WD9C3e0v1KwOlIpe1KLv1btUkPLzX41DkwlCMd2/uxOKY7FwpZuViwbhASA1+lAU6itevJ0v17sCB0takl+M6b+zyPW7wZgNR6TDMHBxEuhSos0rIfuQeg4zOMsEvtZzEVK/2zy4WPZTXcpGb0SjhuRQyQoJdkBkBb4uSeLGJVEBztn7HzH7BWn6dVOTK4241yhA97hH1B+A6E1i0nb2MZPXqTQVsFPk2k9nCaP9216eWIP6IdnTX6NPW9ikx0i0Ta734f9/Na19/3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=devNN80qwXT8GJdNek1QtEuKRL6Jg3fXy0g8zz/GJRk=;
 b=oCf//kClg6Zn4MNEdVB3zIIgiLsxzjYntpeUlRal9CtoGDfcwfvlDQnuFES0npjA6gcXirvDFtoXTBgTZDougjPTEZYZhxMRVozjxGJ/A8rgpPIdFeHctrtuGXcnSfn0GjzDYVJmNMAxR9Y/XZy0nwkJU8sToYFr/ocPxGC6F7Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6195.namprd10.prod.outlook.com (2603:10b6:208:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Sat, 4 Jan
 2025 15:37:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 15:37:19 +0000
Message-ID: <3212763d-7c93-45ee-8b27-fe5d6a9e7fe8@oracle.com>
Date: Sat, 4 Jan 2025 10:37:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] NFSD: Change the filecache laundrette workqueue
 again
To: Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20250103010002.619062-1-cel@kernel.org>
 <20250103010002.619062-2-cel@kernel.org>
 <173594463285.22054.5607940116597245970@noble.neil.brown.name>
 <Z3hqXM9ENCQFMRK6@slm.duckdns.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z3hqXM9ENCQFMRK6@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:610:75::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a200d6-550b-4b40-41d3-08dd2cd5ac6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eno5bm0zRzBqU0JRbHNuVldUdis4NnhabndPWGZaK2krUVJuNm1tOCs3eTQr?=
 =?utf-8?B?THFZbGM4cUJ3SHJ6c0NoUC9iQy95UXlxYklMSmV6b1NEMEoxUUVnMnl2VTNh?=
 =?utf-8?B?cCtvNlNHY1crNUtGMFNxSElDTUxmWDZyYVdDYjZxdGJKRXI4VG9lV1ZzL0pa?=
 =?utf-8?B?NDdlMzBGNGsrdWxPNmd4NkcwQlFNWFNmOFhkWDJqOXJUYWpBYU95MmpOQzZW?=
 =?utf-8?B?Qm0zV3I1YS9uRTF6RFU5OThCSlhuVk5pRE9CRUlZWkozUVlPOFFxVlRHWmZw?=
 =?utf-8?B?c0RsSi9yOURweTFpVUpGcTJCcEIydmVvd3NTNUZlekh5Q1BxbVgxbzQ1NGNO?=
 =?utf-8?B?bEo5Z01aYUZKdG9ZdjVxT29ZVHhodHFkTWhBRDlkVEtHaWtBdGVDMHRnd040?=
 =?utf-8?B?dThGalRHTFJsZWI5bzZvTGtCVmoxalRYK2FpYjBuaUpvQWNQbTB5RUFkM3oz?=
 =?utf-8?B?NnJiSEpvSXRXMkdha2hKYUlwZnNSSk9nL2REdDdhS202M1J6TE1QZEVVdTZF?=
 =?utf-8?B?a3FaTmdwTUlvbXc2WERMRkpwL25Nbi9mdWJ1bzMwSlRlUHFKK3R5Y2g0OHA4?=
 =?utf-8?B?MXJ1ZXNZUFQ1a3FiYTZRTkNKMnZGTG5RMWFjVWxyVmFwZTFxZnhqa3QyYW9Z?=
 =?utf-8?B?L3BsT3BVd3hsN0RhS21hUXV2OTA5UldMM3M5SWh0SkI5aVQ0MzJtTk9MU0h4?=
 =?utf-8?B?cGNjWEkxMHpWZ2xScVJwRXpUUlpVMGRZYWdXc0c3aHgxV2JFakNIS1cvYkRk?=
 =?utf-8?B?UHhZMmpMa0lVYlZBcmF1Y2p3bmtQVnRjaTU0N242a0RvS3FqalBTcWxELzV2?=
 =?utf-8?B?dm40RGFWd2NhdDNKMXhSM1daazB4OWdUWm9ZZHViOHE2QU8xazV5UnpYMmg1?=
 =?utf-8?B?eDdZWVIra2FGTGJ1RnVYdlRLcjFibklGVS9oV21zYlFNejl6QVZvYzY4UGhm?=
 =?utf-8?B?QXB6ckR5M25KaHVjaStzNzA2eWROSG80YmFGVGdKdFdMWGp2Yi9TN3ZER21y?=
 =?utf-8?B?NG5SbW81Um5kYVVNdVBZbUFzd1NRVmNhSFJ5MXV2QkVVV0NNV0llS3FYVG9t?=
 =?utf-8?B?c20wNjZ4b3RnUitzVGNuK01DMmlnTlk0NnNKZU1IVlM4b1FpYlcyREZPWVZZ?=
 =?utf-8?B?R1F0TkFRdUdodGs5MGRpNjROY0JqelBTbDRQRWZzTHMzems2SkN2ajl4bHZn?=
 =?utf-8?B?MGk5eDhJMVlWdTlwWHJIUk5SNTcybGxkWElzRjhFWmQ2K2EwbE43VXlQZlUz?=
 =?utf-8?B?ZkQ5eDk2UHV0ZE85dWROREpuR2xPWmJhSmpwTldKeVVEVmlZeEhOc0pUUEVC?=
 =?utf-8?B?NitENk1jOGxES0FtRmhjQkFydkZkVDVvT2M1YzY5YW9LdE1Pdm84VnNmSnUx?=
 =?utf-8?B?T3ZoR09lMnJROWVqaTRsczJ1THZTdVpKQUp2cjlHWWExVHNDNnNleEJ5bFBx?=
 =?utf-8?B?bWF5Q2NhZlhtTldkeW9IRmh3M2RycE5RcG15RUNwdXhpRXpJd2FIQzBqaVNV?=
 =?utf-8?B?ckMzdENUQXlZZ1B1eExZdmFLMVVXUEZWQUdzT3p5dEZGM3lsV201RDJkdUds?=
 =?utf-8?B?Y1BPOGE4Vjc1aGtRR0JIUnUxLzBCalUvTE1xMFBSdXpRTGIwVW9BcjFpQTVY?=
 =?utf-8?B?M01vOUxjTU91aTV4aThienprSGIwaVpzd2x4MGY3SUYwV2JaMW1Ja2cxaDUy?=
 =?utf-8?B?Y0dxK2dCbG1TWGJnOWJjbk9ObDdJeTV3OXdLOEJBYXdRTTJ6NFM4MDBFZ1I3?=
 =?utf-8?B?akxLdmhpWDB5eGw1ZU00c3FOOW83NHc1Y2VuaXUxRkRLUHpTdmtsQ2pZdFNi?=
 =?utf-8?B?UVQ3dkZOMnVtSGtaSlRsWVF0T2dPbmxId2VNZlEvanZFanliUFo4UGFkOHl1?=
 =?utf-8?Q?VoRCfKXjzHBGx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0hlVXV5Sy80NVdBcjl3dlE2YWhOd2VqMk1OeDBWWXpRWGtGeXN4UDhvZnpy?=
 =?utf-8?B?UkhRT3R5QituM0hTOGpoOEFyTS8yZjlyZU8wMndwWEdIR1QybzlTY3R1V1ZL?=
 =?utf-8?B?dXF0Tm5uaGFDelgxSUt0eHhSbVNMTFBWYlpjTTZZaFRWSmo1anZBRU4zeVpm?=
 =?utf-8?B?Qkx0UjlCRG4yVldxUFUxK3NUWkhTNjduYkgrQVhhSkd5T25RUWVuQzNtaUl3?=
 =?utf-8?B?VWdzTTFYcUZSK0pMc2hzYzY2Z0JtOWpQUXBMeEllanhzSkRMMHRoU3plRHNy?=
 =?utf-8?B?NUlselZQNVBkQWxKSUNoeVR6ellNREwvaUtsRytacXo3ZjlpNUhJckQ2OGZC?=
 =?utf-8?B?aTRBdkZXTWpHQWxzR3E5Z3NFNWNMMTdrdk43WGRxL0dFS3laVi9qem14QWsw?=
 =?utf-8?B?TFN1QVNVek1CRDRQN2lTMzBDTUdVY2ZBdTM0YjBHYU5YNFczUXJYaTQ2dE1X?=
 =?utf-8?B?dElXU3VKN1FBdG95OE1mZEJ2dWI2OWJ5dDVlaTV1RjZWY0ZRZmpWY0dRVVJ6?=
 =?utf-8?B?bDUrdWxBaVplUXd6aGpFQkpBR0piR1E5ZXl6alFqUlJtV0cwcUVLTEJmWHgx?=
 =?utf-8?B?UHFCQW0yZElSeUdtbXRCc0c0UGhmRHBQZkMzT0pGVFJHbndQempxSTdiOHZ0?=
 =?utf-8?B?OGZzdDRwY3M1NTBMN212M1dvNm5vOUgxR05KS2pSaXVrQXB1VGF4dk5ISGVH?=
 =?utf-8?B?TEtsWUJtckNQOTFlbjN1U3FOQ20vREYvUGpPTzBUVUxxVVRJYmtDTWlyOXk5?=
 =?utf-8?B?ZWxVQURCSWV3UUNYL3pBTHo5TTRoU2NPQVJFK1FlVHJOLyt6SitTL1F3VGJQ?=
 =?utf-8?B?S2Nyb3IwZzBzZEUvUDRqd3BGV3c4NFlVSnZ0M0tieCttWDVwRTZwZ2k4QjBl?=
 =?utf-8?B?M2pXcmpJM3lQRjRjNTVvUTAxU2MvL0llQUovS01rRzVvWU5LN1FYMmkxMTd0?=
 =?utf-8?B?TmpkeFFwZ2c5ZDQrYjFHSFhGdXVMMjB5a1h1MTdrdFl0SkRPZDZxSm9Wc1kx?=
 =?utf-8?B?R29udk1jQXdwZjZTZWt3d0N1Y0gzU2ZCWVVmQW5jdndWZyt1bXZlNjdEbzI5?=
 =?utf-8?B?WEpjd2Y4ZDl4TEI2VjVNNHlOSGNMeDhCZENPRUNHcGZoZXBZeks2Wmp2a1hl?=
 =?utf-8?B?ZUhDcGk4NjV3RjU3blpLOXI5N1ZxL1lmNDdEcVI5VDlodUdVVWluSDVtYUJv?=
 =?utf-8?B?bjluaHNxNkVCNlhwb25yL3ZWd0Q3VUtvQkxSSFRxdXpvK3E0aXE4RFhvRk9R?=
 =?utf-8?B?Nk5xRTgzSWJremliK0tpQmV6b0tGdzlqZGp2bUFxNFg4WkVNbE15ZHlzbnNn?=
 =?utf-8?B?QU9HenZFbHFYclIybUdITjZkYnNmQXUxSTlhSjUxQ3U3d09YNnk5TmE0Skdt?=
 =?utf-8?B?ZFNETWdJZFY2dWpoMkdPa2JQVzBVVFFMQU9uN1NoaGJaR3lpRzhsUm1EMXNJ?=
 =?utf-8?B?TEx1QkQ0am1sYVZjM2ZQWmdKSzNsTjRSaHAwcXNtQlRjWmNkMWhldXd0ampD?=
 =?utf-8?B?Z2dZMWNVTk1YOWF4N0ttTFZrRGZKOFBUNlNaWnRNSW45OGY1dmowRnBxRk1v?=
 =?utf-8?B?dnRYOFgxOVBGaFdNbG1WSTFmd2pUUlVZWnVCWVN0MVlnbm9vcnZHN1BKakF0?=
 =?utf-8?B?bUJkWEs0bzd1amZhQTZNa3VUZDAxdHlmd0F5My9oQ3R4RkVkL3VxNnBxcURo?=
 =?utf-8?B?WWZ3ckZIRkJGVlJ5c3VteTJmMEgxTmxLbFA4MEtucjRhbU5jSTBvZ2lxd1Nx?=
 =?utf-8?B?RkJVZzF6R1VZcWtRcmlaVVlzYUlQMTJwbTBPelBOMjZXekFzQUdZR2p0Nlo3?=
 =?utf-8?B?Tm1ZYlRrM2E2cUprTnh3WWlOSE9NK1lBeXorR1EybGVuMTJpa1M0L1hLYWIv?=
 =?utf-8?B?OENLNkR2dkFQWlZBT3hKR01BUWdRL0lONVZOOHI5STdFNFdtWWc2S0ZmakpT?=
 =?utf-8?B?a29SU25iYitMRlM5NTFkZ1E2elhlOFJIL2dGWjNVbVhOMk8yY3Yycy9lUEJS?=
 =?utf-8?B?OEp2RTBrK0VZNHptQVRWankzZVhTV3NUWmloelpidHFQUDc1enNtZFNuOXVy?=
 =?utf-8?B?RUU5TUhYSm4xSHRWVXZZVExvNGM5M08raytnb2N0YjBWTFlhc1JmaTFsOXVy?=
 =?utf-8?B?RzRpSVNocVlYaGZLTlZtWG1NajlYV2tqUnhFN3Y3NDZuN2lEK1o3ZS92eVd6?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I2dG2Sla+nuiQMtC2HY4j2ocN1AvXk5KfIMFZR4Pzlad501JE5YzrVlo86Z1w/juG7VHaDG7iW0WpxhgjIk+xSvrcyWvEl8KWgafl+F26sffTE2P4WT+iqgORBNCyT07Zq6PP4iMjP0ZmbIwqzqa9UwYomr/1u5H948Ln8T07fsijMOkCgSMItT2O8UFg/km5YNr1VljFSFRsCyroyLo7MO5H6JoAuptqDHHQRBKkJLLi5jwC3uTdGtffdPWMe6blDn9EZt3OlCvNnlPgWeV/eJ/t5i/7vkvybUj9OlZMBc9LdWnZEi7JxG2mzRmfUcJnOy/Je/1htJlgHqX5YLmB4xUlPHC93MF6CAq37Fg8wL6023n7SlP5tBSXQ8tLo9EjYkmKS7WrR6i/bZ+uZnX2huR84+a12TqwhB57LstzntJdOIqH2fJLxu3Rom/Egbof9hCjXiwK1BFALaAOASmz+7s5okt9G/U2QjL3KEaKQPa4Va4REfEzTOO21MpJVW7D9hf0cJXK/wPr1/rQeMlYL1dK5RhHM79GoMBWefIU/oaTAXbCvfCBzGLzXWiCefSApTLGzutMrbg3GXB1pVl23ReIOkENa9upAVk1eUUqCE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a200d6-550b-4b40-41d3-08dd2cd5ac6b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 15:37:18.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ+JJg09K3UEwc+ngzDrDy8sRB/aBc1RBuGn0HgoZN/coa7wU/RQSUBUELVvSD4IImRIetD2DAeUGgrVSVkorA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501040137
X-Proofpoint-GUID: Sil5QIRTuqrjlbiVfQfYFWrOgTo6e4Pc
X-Proofpoint-ORIG-GUID: Sil5QIRTuqrjlbiVfQfYFWrOgTo6e4Pc

On 1/3/25 5:53 PM, Tejun Heo wrote:
> On Sat, Jan 04, 2025 at 09:50:32AM +1100, NeilBrown wrote:
>> On Fri, 03 Jan 2025, cel@kernel.org wrote:
> ...
>> I think that instead of passing "list_lru_count()" we should pass some
>> constant like 1024.
>>
>> cnt = list_lru_count()
>> while (cnt > 0) {
>>     num = min(cnt, 1024);
>>     list_lru_walk(...., num);
>>     cond_sched()
>>     cnt -= num;
>> }
>>
>> Then run it from system_wq.
>>
>> list_lru_shrink is most often called as list_lru_shrink_walk() from a
>> shrinker, and the pattern there is essentially that above.  A count is
>> taken, possibly scaled down, then the shrinker is called in batches.
> 
> BTW, there's nothing wrong with taking some msecs or even tens of msecs
> running on system_unbound_wq, so the current state may be fine too.

My thinking was that this work is low priority, so there should be
plenty of opportunity to set it aside for a few moments and handle
higher priority work. Maybe not worrisome on systems with a high core
count, but on small SMP (eg VM guests), I've found that tasks like this
can be rude neighbors.

We could do this by adding a cond_resched() call site in the loop,
or take Neil's suggestion of breaking up the free list across multiple
work items that handle one or just a few file releases each.

-- 
Chuck Lever

