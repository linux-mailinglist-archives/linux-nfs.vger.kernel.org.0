Return-Path: <linux-nfs+bounces-16146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BDC3CCE7
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 323754E39E7
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238434F494;
	Thu,  6 Nov 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HqQaeLCF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QlmUQ0LJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DB34DCFD
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449490; cv=fail; b=jib6ieTNwaZTN/wMnAGcvBt49hs8Y3vn3mEr85wvnderi8Y/t1xQZoy6KcKVUwObR43tC5yQdV3m6z7Go0jO3DuBiJCSRXSO4QJgNUSANQUwy9p6JGydtEJ9+388CAuICyju8IdOXymfjQQc+exUV4avYlB7HXyWOzhBR/QZKGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449490; c=relaxed/simple;
	bh=pLv4o6Ducp1UnEmak8kNQQEGhxUY7VGx6/uYURtCFkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DtMXbm4T/mdUAUG9EEGSxg9JFCO7/IvsVEm6CVUjoGOSn79g9qmFGNHROc20NATrXM79s7vOAnyCoSslJzaL1b8RspS8TcVWr2WB6iGVvCB8OaobvGS8lIGeAkmWeHgW+Lcu5Fc4UENl9ny/TzZX0Ct6DADoxm5wFoJQ6Oi63ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HqQaeLCF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QlmUQ0LJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6BSu0e002665;
	Thu, 6 Nov 2025 17:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eVjFcelVFSIJipUcrx/O9nhqXNZjhLaMwNRC0btvCSg=; b=
	HqQaeLCFiWkT8EW0U7YD6/qf1XjCwTaL4xLJz/CazeFcTQZqvwK8+MBfNvll9Alx
	iKK/ACJzJMGkJ1EUac3plBz5VH1jyhTyeHxEcD54TmvjFfppL4pSESloX53NQoRG
	XuNxUa7YlPEIGRbIqwFJWnC9/BHUzXz6rGCAGyyxYyHa7YAbV6FCZHHO7Sa+OMF+
	6PxWr63AVkZiuJXHeaCjWFyjd0XwDZifnP2cEZMNqRRg/xPWl7e0aLj5/3xyeavQ
	yKaMM0JV20aSkYU/isrv3iRHozqI+zfl8nb/0mp8etTwdiSJP6jcrtK1CyTkJy95
	ZPKw8IbeN3xx+Dd1+xg8nA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8at92jr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:17:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6FfkfN014970;
	Thu, 6 Nov 2025 17:17:57 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncev71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM/TP1/1whYyxZfL8erBw1G5jH3JSTXhvqcp/xqPO0Nc0RnmbHKAsdI19DhdK0SR8unjmZWUOxolBPE4otKG+XBIKvTRhtQHWbPvJvPANAY3q7nEF9gJkYLoBqB+CaczIuhkx1jXiZ9GKAz1Z3YDSEqH4dWPYcy6+HnnPbM5Si/IZlUf11N9w9YMBddE9AnxvHVFn6+wDuc4ZFC7ILI+L5L4fWm5Cdf1FU09jGKnf2Qx79hvZySGt3/6CwQ1rqebsDwB6z4hZerMyh17Jg95mHHz8+r1zaaLAng1BrNY0aR9NNNe4nIiipuRCJ6Hxwcsb2EBDEAkuS7VKweTMYkZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVjFcelVFSIJipUcrx/O9nhqXNZjhLaMwNRC0btvCSg=;
 b=N80ifn1IXA8YjWMnx+1ECfCu9r4vO8/Gs/C0szq5FpNUAA+UY4i0uE0E/r4QkhsGY6kzIeRSYq6OOf+CORM3bxT/dr/vadhND5uCu016y3/x4tbpe5+LCCYPpwK0WAGOpvGbKXAf7VhrPgZXih36PH1MnCdmje0cSVrupejeDk3plArvv52cdU1ueJIJKSShBgeyJGabaW4qIThFBSrLRoeZAJhMWG+Cc7Jlz676xxanbqyPWKTncUFt7JKZ3cg7iLwJytbMTloBnoAY1Ap3mHLnnlOr/UVM9Q3JsR3ei7U/HiM/zoL9HS1r16SyCnRoD9hKY+q02bl5THUVb1UXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjFcelVFSIJipUcrx/O9nhqXNZjhLaMwNRC0btvCSg=;
 b=QlmUQ0LJok5hJldhP8i1T4kj82Pr6eyfBHD3rhyXzG76xHdHhFEyug5NlstCvut+aNBUhYosAnSe5cCbFuyISiYOorYnvuFWWx+RDHk7a7cXLGkL0nevfhyFvwCfE1r2pXV1CAhvm2DJG8Vhq1hekM9L9tjgV5GW/pwiGK08eVk=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 17:17:50 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 17:17:50 +0000
Message-ID: <f024e6a7-b6e3-46d4-8c5d-0f00f9700a09@oracle.com>
Date: Thu, 6 Nov 2025 09:17:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: Fix server hang when there are multiple layout
 conflicts
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251106164821.300872-1-dai.ngo@oracle.com>
 <20251106164821.300872-3-dai.ngo@oracle.com>
 <f6eb3ffb4dd88e63e27aedcdedf70fb6153defb5.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f6eb3ffb4dd88e63e27aedcdedf70fb6153defb5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::29) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH0PR10MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: ee612ebe-11f6-4bc2-a486-08de1d586966
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UmxZWDlxNk5ZMEJ1VzJ2alUzeDVpeEtOUysxVDF6WjRheGlKRUxySlpyM0JJ?=
 =?utf-8?B?d2VEb0N1VXNYOXhyNnJLR3hTVXJOVkNSSjZJT3hyaFhpNkp5YUxjLzliQ0Jz?=
 =?utf-8?B?cmw2QnlieThvMmVYNTBwbGp5dnJmTzcvdzBhMjJQMDdMSU9aL3FDSU1GRGgz?=
 =?utf-8?B?THZnYzZwREpXYjhKQktuSjNPWXNEbExPRXN1cXI2bU1TQnROZmtyMGRTQmF1?=
 =?utf-8?B?ejE0VlI4YnlWQlEzcVdHSEZhUmwzcldETjlhOHh4U096L3J4UzFlVU9JWGFB?=
 =?utf-8?B?aithTjBQczNrWSt0MXBDd0t6OE05c0VuekNIc1FhaGhYZklJelVaYVRnV0JY?=
 =?utf-8?B?UHZKNUpEQS9KTXpTUWF0U1dTR3l0a1htZUhCcTFVUWZXL2hMUUNDV1REK2Zi?=
 =?utf-8?B?eHZGYkJQaGQvSWN1aS81d2hpRFBXNk1YNVdjN3VpeWdBVnU1TnZXZURpWGxk?=
 =?utf-8?B?ejR6V2U1TnBHd1NRdEI4eGZidmtma0F2Zk1qK29ZWVlaZTlaOUcwMXdVa3lx?=
 =?utf-8?B?c1MySHljVGpCU0c1UDhGUWZIdUhFdzNWZDNCYlo4MFRLbXhIRGI0eWVVVmJh?=
 =?utf-8?B?MWwzK1g1SWw5TTdpWXNCWDVoeUlUL2dMckN5eW9kbE4rQUU1eFE4Zk83Z0Nj?=
 =?utf-8?B?Qzd5bHpReVpxU1ZGZnJEMVYrbUNoNjJUTlVEcTZ3dEo0T2xJY1MyQmVFR09P?=
 =?utf-8?B?NmQ0bzBQTXNiMGlwcmxQQjJzcFdJNVg5RWJNV3RZSm1KbWlZbXl4REovRHBn?=
 =?utf-8?B?OURYa2VIUHYwSGthQU9xVklySVhVWDRZZWduQXRZZ2lEd0ZYRHdkc0JqcEpx?=
 =?utf-8?B?Z0V6cXZzY3ZIOUxmVW9Kc0tST2s4R2grQUkxQWRRUkp2dzROMzc2bFpELzQz?=
 =?utf-8?B?eWk3Smc2M1VycnNRTEM3bnZMSkdmWWlOM2MxalFHSkF0MUdJZmllcDQ3YTRZ?=
 =?utf-8?B?Q25jaW9qN0x4bWVuNzFoQi9RYkdtMW55R0lnRlZUclJuNDE4SXBWTlJPRUdF?=
 =?utf-8?B?M1VBK2hpT0gwakdWdExMeHBrWTlqNmN3aGxQSDdJbWFWS0ZaTytzME1mUWxV?=
 =?utf-8?B?eDZjcmgweEJZTjBWUVY5VTVQWlpVNjQ1cHhhbzhTOW5BTVhyeHZrTll4R0ha?=
 =?utf-8?B?WHJXY3VBOUlhSUpYNjdrckFTWFNlVzhmMkY0MTFad0FBUWJQNWlDckZwN3Mr?=
 =?utf-8?B?YUdiSjFXdkpmeDJiUFNJbFdmbXk1RU80c0QrVHhFNTZBK09KQkFhb2F3SXls?=
 =?utf-8?B?R1BhdUNyV2xmYlM3WHRyTE1aek9GeTVEZHVUMitxb0tRczhNcGZXbzBlelBq?=
 =?utf-8?B?K2J3Zkd4bWp0Myt0Q0d6SDJsM1p4Y2c3MnpZdTB0ZHJvQjNZeld3bk1VcTRp?=
 =?utf-8?B?UDk2Q1dreHBmYk83NzF4aG1RUjExN0cxYzVZWVBUU0xFelVROVBIWEg5YUVx?=
 =?utf-8?B?S1l3Nlg4WnB6WVViaEJBZmFLV2RuVlhKMnZsS09OZ3pTNjlwVno1TXFJQW9K?=
 =?utf-8?B?Qnd6N2hWM05TZUwzeGpWMnZVaStERThTd1pNSFJXenRGUXRXZGhPZXJCT2lN?=
 =?utf-8?B?SHVpNStRSUxnV1ZtZUo2NnY2WmxUSUU5MERSME9hVUhOTHJHM0dsclBIUHZj?=
 =?utf-8?B?dHhqY1J5QTNIdW5GNkl2T3FVMmpKT1BWM3E3OXcwamNDdEtWdnlhbWN3Vm9r?=
 =?utf-8?B?TlZwWFB2bnNIMGxqK1NYeGQvSFVFVG0wQU9nbHFSdWgwYWV3K0ZTOGZwNDJw?=
 =?utf-8?B?OURLU2IxUUtlWVJ3cllUZjVZVWdVOEFiNU9pYVVSRHpsMFpDQVhUZHY3MEI0?=
 =?utf-8?B?OEw3M1JtckFLSVFGMDFldGRNTTJ0RmNsdkdQYlh3cVFORXZrOHBkQUtzUEFL?=
 =?utf-8?B?QkJzK05Db0F4M2NDTDlQWkhxMEpjcHFSK3RRcmthSG1uTzBIR0MxaW5ZRFJy?=
 =?utf-8?Q?c8C53ZwgRvX23s7cmhMxtesSI75tmDht?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OTBGZkhkTmZQOFRGWTVoaFJaSHFZbGg4SHNlaXhPTGo3K1dmanpJWlROZDJ0?=
 =?utf-8?B?bU9pMHdVd1EzZk9OeW5sQXN0bVFSMTBFZzRpUkw0U1dxTGVVR2YyWFNRTnM3?=
 =?utf-8?B?aUo4V3A3WE9RdDZIN2pVVDdyZWhjYkFpUVJrSU1FM3AveHlSR0xVZFJJdDlZ?=
 =?utf-8?B?UWxzcW9ta3duLzY5MzFWajl2d1ptOEpOeHIrNDFRUWFGSHAxQ0p3U0t3TWVk?=
 =?utf-8?B?MnZOekpMYkZtVG4wdkZ5WU9TbWhneFMzVmw3ZEYvR3VpRW4vdmVBczBRKzh2?=
 =?utf-8?B?YkhXc1RmNnFRaFQ0NVphYzBOTjdnRUZyWDk2dGN1Z1NlK2NMZEFNZEo4b1lM?=
 =?utf-8?B?VDlSQi9zcytWY2J2b1lwQlFKR1gwSkFua1h4MHV1RmtPV29ZdGxlWnBQUSs3?=
 =?utf-8?B?djRPQU8vV0ZCRkQ5MVo3ZzlvOXg0MlVmZERtWTlQdVdoWXRIYzluS202RGhY?=
 =?utf-8?B?SExpWGtiZSthUllSblNvdWhvcURqZjdzc3hyeSs0NzRpU1pmQld5NEVkY3NM?=
 =?utf-8?B?cjhEUEpOa3plV2JRUTd6S1MraThtOEFoQ1BuMFpYVW95RHdqUkFNN0IvOUhC?=
 =?utf-8?B?OURLdlN6M0FoTHIwUFlXbm9LQUVsN0UxZ1Q4MTduQ0hsWFdscEd4ZXkxN2hV?=
 =?utf-8?B?c0N6MVBjZk44Zk1sUHFhL2x2SUk5WEFheE5MNWVLN1prNVJ0OTExamJXZXVR?=
 =?utf-8?B?NExRcEVRUkt2cURCTEdIc29aSmkyb3AyKzNoMWExUVJtakdtMVhpSnRwRC9M?=
 =?utf-8?B?WmEzSWpWS29mM0xHZ3owTlNqOGNPR2RqNDJNSXVrcWN0ajl4bEdNdWhKeExz?=
 =?utf-8?B?WFBwaHVMLys5cnN2ZGJSQTBDby9QZVRRSnlML3VoM3JoVVFaOHB5cXpjVzFl?=
 =?utf-8?B?MWZBbHhpVUxYSXVibmRwTW04Y094TkxlS1k5bUlsbktaWHFJVGhMT09XbCti?=
 =?utf-8?B?VW1vMEt3SFVuMDYzZnZMTGxGY2NONitmN3VTRWRwcEZ3SklQenhFdGRCS2FW?=
 =?utf-8?B?VzZJcFpYbnNySUZ4VXNtQ3R0bnkyMGhlRU8vWU92eDRDV2VNNFU1NzJpMmxK?=
 =?utf-8?B?dTJob3RmbjArTkJsSEE5cWw2SkdpbGxRYmQ0c3pqMkpycFFud1dMM2Y2dFdK?=
 =?utf-8?B?RmlZQkppenI1U2E4Tlk4NGVKZnNMN2ZtRG1sdFN6WGlFOHRGQmNWcHdNalA5?=
 =?utf-8?B?RTdmUTVnRFZjeU80akVPUWs3amZJMVZUOE5RUGVMdFdGQldQaWRaaVYyRll6?=
 =?utf-8?B?eERHMXZ4UEMrOHZ6eHVhQ245aVBXeCt3dVpMQXVTR0FkbzExWjZLenVUVkgx?=
 =?utf-8?B?R000VjFWd1o5TStpSkpBNUpaNFRNL2tZYTJiZlZxWkZFUDlnMG5rOFhwMG1H?=
 =?utf-8?B?OUpEa0kwSmVWQ1oxb2x0YWhTcGRscnRVenZMbmlSS0xvTG8wY0tLSGlGNStz?=
 =?utf-8?B?SzY3MGhjeUV6aytScnI5M3N5M29EVW9qYnFlZTFQR1lmaUpvSmsyZWRSazFo?=
 =?utf-8?B?WDlDbG05TXhFaElXdHEyTlRpL2o0NDl6cDBHT3VLSjBvc0xWdUFZT2toUjFT?=
 =?utf-8?B?MWRUa2VzaCtsQ05PMHdPZzB2ck9PaHg4Y1hpVEFXdW9RL3pjM0tsd3ZWSERn?=
 =?utf-8?B?UnAwVC9YemlSVlNDWlBtOGJJaDJZMjA5UzhpcXlNbnZBMGg5cGR0M1R1S01x?=
 =?utf-8?B?R3JUb1hVWk8wd2V3Ung2S3VmNFZCSVlJV1M3aytsb1BEekpud255NCt5alhV?=
 =?utf-8?B?NURLUVJJQ3NYK3hnaE8waUhULytaVUNreW92cjZYQ083bVdWSCtKOFVmbkpP?=
 =?utf-8?B?emFNRmxSbHgyZ3hucEhGNlhOL2JwVm1naHFIbDJSRFV2ekhVU01lT3JPZitn?=
 =?utf-8?B?Rm5QcGJIVWVHSkRmTTVocElLUHFDMFUwd1Z2VWEreCtNT2N5QmxhNWUycUM1?=
 =?utf-8?B?YVowbUdQODRsbjFma1NFcC9tajFtQ2w3QnNkZWV0Um40Zm1GOTZ5ZnZWYXhy?=
 =?utf-8?B?U01POVQ3aU9TalpKOGNhUG82cTdRaGFHbEJqQmNuZllLbk5LcXNIckZsZ3I0?=
 =?utf-8?B?QlhuSG9ObE9oZCs1Uk95K2JVbjd5UzZnYnMxdklxZjVUTU9KZCtycUhlMWZt?=
 =?utf-8?Q?VOEphQXruKgVgdowygaBHYZEC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AjMPYL/8A6lav+daR68ruO8QOxzWbuv5TiAX40uxDyZh+ohMRR0GUaKYMpGdvMH/anhqE4GYP08HoF6vmQFl55DfQeMGpBZ+qA6CRpR5oGY0S+H0n5R3W7Ir6UtaQos5yjNOuVAeHF6IDs8FENEGIAjssmFResVrSVc/2Sg/M9cyo/FlLoJzt2C93tlRUGR3V4wnfnBxF1vrNzAVThPR1KqLRnpiOs702737FoTsLmIuyY2n1M4PCns74sEH6eCdy17syGpGaZWWBOH1Y/dEKcNTfhSkoYhEtY6WmNkfcNCyoLCo03Pcez/U4Isn79hDi+6apqS+mIzl5GsVs5mJ4nu2ZBBr55K5VjH+VqhDLYHdBRLA3tB0v3UHvf5GcC3ZW4pHRbWhbPnBn16mQ4vMTMfuQlafxQtOPQ4lkFmXhpu7WGhQ6jITGhTIi1l1amfBciE/+ifsOuOg1Mjdw3xoffPSZKJWQATldgAHPC/2tjG7zi+UZE5WP++NRF+WeAiTxLWTyPcw/iIdhIOI7NzoBwr8bEPhfmcxba1+98atOFW7J+cW7l9dHcTuca3Ynvja+hqmXTlxIpRauZhmrBGR20ColK6Ewtlq6w+HM6Jx3E4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee612ebe-11f6-4bc2-a486-08de1d586966
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:17:49.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3MGelp+sAF6FA59M8l4H0JlyJS5JWOr5qN1ZGJcX8Ul7cp7CbaAzVYo6LLjSVswyX9Xcjop1tp4O4elTm7E6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060138
X-Authority-Analysis: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=690cd846 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=IzfCUEhh-qn3OgLyRzcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TFhr9xtiuf0lj2lFQgYpVBjlr_9AzHAi
X-Proofpoint-ORIG-GUID: TFhr9xtiuf0lj2lFQgYpVBjlr_9AzHAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX9yXTKm2YPj0M
 YkKvV4GSj7WK3z1jvzZ0qZ1Ua+tV7wrW+14ekjlOM59s01UhAb05aMyHyAhvbG3E2O4tF137Kns
 28A4r7IeVACXgznP+eIPmB6SZkJVUxcuKktHn2UPT+dC1vyEjdRCbDcmGnecu4SWTaUzRJicTuE
 Kf0494re8b2xAufE/9EDGk6WKk51cbwzDkqVIkNEhcjOx/6Dd2Vrt5LeHJzcK6/1lfbYkYglehJ
 TEO6NZDGQL8ZTfzSbdaS/4P1fWhnxwnagyr5PgnDN7JLZUjAc7SLCM34r4+cqJkrU7mJSuIPBIv
 Lc5JjUtdNMzITG2KKXU0QRjHh2njCWyiWH7RVJ/6iy6j/xiwwurXdU90klqtuVk6GaIpOGfWAl+
 us5w2NVkIAgCfR8ZTnfZGnpZNl0iZQ==


On 11/6/25 9:14 AM, Jeff Layton wrote:
> On Thu, 2025-11-06 at 08:47 -0800, Dai Ngo wrote:
>> When a layout conflict triggers a call to __break_lease, the function
>> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
>> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
>> its loop, waiting indefinitely for the conflicting file lease to be
>> released.
>>
>> If the number of lease conflicts matches the number of NFSD threads
>> (which defaults to 8), all available NFSD threads become occupied.
>> Consequently, there are no threads left to handle incoming requests
>> or callback replies, leading to a total hang of the NFS server.
>>
>> This issue is reliably reproducible by running the Git test suite
>> on a configuration using SCSI layout.
>>
>> This patch addresses the problem by using the break lease timeout
>> and ensures that the unresponsive client is fenced, preventing it from
>> accessing the data server directly.
>>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4layouts.c | 25 +++++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index 683bd1130afe..b9b1eb32624c 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -747,11 +747,10 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent starvation of
>> +	 * NFSD threads in __break_lease that causes server to
>> +	 * hang.
>>   	 */
>> -	fl->fl_break_time = 0;
> I guess this ends up with whatever the default fl_break_time is which
> is:
>
> 	jiffies + lease_break_time * HZ;

Yes, currently is 45 secs which is, I think, is way too long.

>
> I wonder if this should be based around some multiple of the grace
> period instead?

I think the time to allow for recall reply should be in milliseconds.

-Dai

>
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -764,9 +763,27 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>>   	return lease_modify(onlist, arg, dispose);
>>   }
>>   
>> +static void nfsd_layout_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	struct nfsd_file *nf;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (nf) {
>> +		int type = ls->ls_layout_type;
>> +
>> +		if (nfsd4_layout_ops[type]->fence_client)
>> +			nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +		nfsd_file_put(nf);
>> +	}
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break	= nfsd4_layout_lm_break,
>>   	.lm_change	= nfsd4_layout_lm_change,
>> +	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
>>   };
>>   
>>   int

