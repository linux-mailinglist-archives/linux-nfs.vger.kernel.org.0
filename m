Return-Path: <linux-nfs+bounces-10178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9FA3A4FE
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 19:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D51B170ACA
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D5270ED0;
	Tue, 18 Feb 2025 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIyiTtnE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bQ8aZqFu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF670246348;
	Tue, 18 Feb 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902254; cv=fail; b=GvXNXdRdiglW1ZFLvbEqyBdhoqNfa8ojIpVMLl3+6G2aZUBz4atMSLvhlVOjbDVSasPoulOiLJU9g7wTzUeiPIDer2QH43Uv4srw096DMNdFpfMb9jfhKahA6zbS0oK7mt2+TZTXv7nYEldntsECXfSpirUFerpN8J56VsWWkiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902254; c=relaxed/simple;
	bh=7TnCZah7ZhX+OkvNZHGOMuDKjCVgqRXEBcoJ2nwfpUA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1bdinUNNDB7YZyPJ1r5nDmOrxCqdVsuBn/z+UiWVMvXdN4Ibe25GQuOeMTrx7lRfQbwJ6q1wt9ke8Y3UjEXeAxGh2MulgGDoxSswFrPifqpP8DS/fwo8Z2LhnRjTpQzkteAA2H+jTr1uyMPP0TjtDdRgaxeSgfduOiZopVupHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIyiTtnE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bQ8aZqFu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMZDr031372;
	Tue, 18 Feb 2025 18:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Vl+VNmWVCef8cshMbgxXDIJ3kyhNS7H9qt/bQKCbDHk=; b=
	HIyiTtnE7byknzREhPOK9KL68Wubo3KrvZB7GA6rslPU8Wr/dk9X1SMRXzbFv7wx
	la3H/gybwK+FogntYY3rg62wtZ+nEP8zqPdQl2ufs9pFO4636aEXLLy7MWCgf/tx
	XOJlGsMIO6k1cJRk+KW6laTjwtmxnTttGbdU0GRWvj8Tncw9OqYRJCs1ghz2mMYI
	PxXpRtZWGVi7l2cGm4VpO9d+l03R+fubQOKo/kIEYIcp+reJ5eDIpDJt/2uKbkzK
	zhuIaPRGUvlHMj9g4xArD9XAoexQFKqpHtKu1jXEGLo1sfQyguYN5DvgX82aILxq
	xHeE5zPa26fETz+rVfCo+A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tqxh6v79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 18:10:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IHb8F2038705;
	Tue, 18 Feb 2025 18:10:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc9cn97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 18:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=il+u6NNrIbHM7LlDq6PQET5h5kPFYH+itsksjb/FRKJaLZijsszGHYGlJbFVubq3d8b56KVuXC64VCa629Ij/4I6k0e02uu5lfhV7tTuL3vZQzzABLMyIj4NjJw/GJoqO8kFLVgTsnaRQsO5f2F93TGQRWQiisD7BdJllWzpA2bnIErNIbY7kG881xzUo6DtJL3EA1HQfT9stP03T03O4MVetxJtVu+f+C/tLyk9YRsv141p/YKFzlMQO7PkHD7AD+iIpcfQgfTkaisAZ1x2/0jmPB/O8o9B5gVxkaipRDzDqj49Zu+G9yNLZelMjzpoPaEtTx4MgofF7iEUahkiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl+VNmWVCef8cshMbgxXDIJ3kyhNS7H9qt/bQKCbDHk=;
 b=B0WQD9F3MJ9sbbD9k/zSH8l8BOZE5Nno04c+lMmVVgbVuN0wO4h6is+8kxiJsce6wJ6hZMHYyIfE7wwe1+oQ0kZ+b9rXEgItkdQVppJkt2hHzvRJuFASyk/lbNsCdlz6dk4jDwVlzOTM9qi52CYO52cXscB/Uj+ikxBOSNM+eqy+enruSz6qAz7gLyjg4FxYuNinHrj6Wq54B27Mo3dhpYbnyRVqA2DxvsTMO0YYzXEHGMpOtutD6o8dkq+BvlzmtDKsM1mzSTXeg3oYDnUWEDpukmGwFUg3cx1ElGkCvIefLM9JFXbTcs0sQgrxVd61J5+vpAYpUbicgBF0pwfoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl+VNmWVCef8cshMbgxXDIJ3kyhNS7H9qt/bQKCbDHk=;
 b=bQ8aZqFu+24dPMdxdeafqlQT3V894CpNzJFDCMRFKNtDn2cwndxEE0t5M8CvZPeOFNoKE5O04ISVvbRLUqs+bn7cpFQq4kajoiLf7HnMpRLERUa/25+Ruoi0VxeJsf3ribbz0NIJ8OM035Y+fUK/EmdFK5mW3LH6HxcXkXSqBSM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 18:10:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 18:10:35 +0000
Message-ID: <57b70bbc-c8d0-4181-98a9-5174517270a0@oracle.com>
Date: Tue, 18 Feb 2025 13:10:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH][next] fs: nfs: acl: Avoid
 -Wflex-array-member-not-at-end warning
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,
        Dai Ngo <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Neil Brown <neilb@suse.de>
References: <Z6GDiLZo5u4CqxBr@kspp>
 <b16ac12f-166a-4d25-bf33-b1ccf6e0dac7@oracle.com>
Content-Language: en-US
In-Reply-To: <b16ac12f-166a-4d25-bf33-b1ccf6e0dac7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:b0::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: b74196b9-85ec-455b-84b8-08dd50478a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWJQTy9oQk9DME4wc2xCUDRka1E1SE5WMkhPcXJmNHRTdUVCZXBRT1prZHN0?=
 =?utf-8?B?YmpReGIwbGtGNVpsT3FRaXlTNDltcmJSMDJhWGJoa3ExVmNxMGg1WVVWbUp6?=
 =?utf-8?B?OFZxb3U5c2F0eHpPYXNOb25OMWJlTDBsNEt3WjlkN0lQT01vRVdzV2xJSEta?=
 =?utf-8?B?NktVTHhkaVhybFE3VDNUVEIzbnRBYWU0VUhwYUc2ZGNJUkRyemNaRWxyUDBW?=
 =?utf-8?B?RFI5SE91TVEzVm1EcDIxQllkSFdxUnpBcG1CeHdnWGtubDNxR1BYZmJoMWtB?=
 =?utf-8?B?UmRkYm5OWVNqa2MxYkZMSDREdnQxWjBYZy93cEFUbUwwK3I5MjRSbjNxaDg0?=
 =?utf-8?B?NmsvVUd3SytxdXhaU2hoL3R6YjBLbDh5OVd6Smd3Ni8wL0lOaDZkN3RDeWhm?=
 =?utf-8?B?eXlpbCt4Y0tKQS9uamhoMjZVMnpHdEIvWVZva0M2MTBDS2M1cWFBQjY1TmRY?=
 =?utf-8?B?TnBOR2dUc0NBMEtLM0pkUkN2dFBIZ1BzMExNWkNQR3NmdWxpQ2x3VnlVaDFY?=
 =?utf-8?B?bnoyallndk9CUzZ6RGFoWHhqT3hvT05IN2VrRkxOUG94NW83RHcvVjRUUFZl?=
 =?utf-8?B?MGRSd3IzNGpreU45M044cFVLYndaaVJ3NFVlcVRzd3FUa1puNkVSK05YN0pt?=
 =?utf-8?B?TFhGQzZwRHVjQlVueUsvWWRESjVxanR6WlgvajFHOC94T28rQUkxNUNzaHI1?=
 =?utf-8?B?Q1M1Y3l0MWt5cWJjRXVucDFhdm0wMTZ4S3dXZE5jS2FCeHppSXB1blY4QkpV?=
 =?utf-8?B?VXErR1JCRVM2ZEFZdytXR0psVFRCV3VUYUxYb1NzWmNiWVJyNGVWVkhSRjRk?=
 =?utf-8?B?bG91bXExTHJEOGc2czcyLzlsbjVhWlJVY3BRaWwyRFQ2bGtpaWZNZmRSK2k4?=
 =?utf-8?B?YW9URjdjVUEzQTYzcXJCMDRIZmhqNTBCck9aclRNZkRWU0lHaWhUbjlUUlNC?=
 =?utf-8?B?dnJTQm9qODNhY1lWekVtSUdYa0I2eGE4bkgwS05mL1ZLS1kyeTM0OXhnSklI?=
 =?utf-8?B?aStFeEExQjllSFVSdS9pQ1plRlZ2ZnJoU2dHRGg3cXNuMG9SRmVEMnZIVHNZ?=
 =?utf-8?B?ZnFrVSs2dTNiMm9WRnNqYUVmeUlKYTN0bXdKZUxxdUVWWFI5YWQ0a0EzUVBM?=
 =?utf-8?B?WStzN2Y5bFRkTm1vWHpJbDFRQjl3dHlLZDBNOEJ5bHdHdmtDc29YVG9aTDhU?=
 =?utf-8?B?RDk5ekRnQmw1YlFya0pxa2NVVm1STkttNCtGeE50cHN0SVpZNm9xQ0VEMFgw?=
 =?utf-8?B?VE1SYk92ZXFlVE5KNXAxTXljeHN2N0cvNVVaN0pvKzhPMXhlWFZpakhnOVhS?=
 =?utf-8?B?Rkg1OVBjN0tBREMvOGlsaFdZeCswalJQVVVUZWF0UHhSUU4zYk12ZzIyR2RE?=
 =?utf-8?B?VGNlWGxMeE83UTNhMTUrWWplTHJsRU1QeFhOc3pVbkM4NVByd2RBNStEb1BT?=
 =?utf-8?B?dDd1ckE1aHJzTUNvd1JvYVdjZURrL1JsMFZza0Y5eGdnTU1LSWFpdWNzZDlV?=
 =?utf-8?B?VmpENXVlR09xTXF2cGlLVkVwdFNBbmpMdmxHRXRxRmhKSERYYk95dGZzeTNl?=
 =?utf-8?B?ZWFHNEtILzZOZ3ZSZUFYK2VnTm5Gdm45YmtudEllQzlEeXBYbzd0c3ZuNmdS?=
 =?utf-8?B?YWpZaDY0Z2NxZ05ycm0vUUhKUmZFL1NJNzQrcTFSYWZkWnViUEsrbDg3TGhM?=
 =?utf-8?B?clhYb2RmUEtQZUhreHIzRFRtcW5tMWx1R0tWN09wRVI5NFpySDlVNVJNUHVN?=
 =?utf-8?B?cEFteENVUXJCc1h1Vml6Qjk1SlRvcmpCcy90dEd3TnRnZFBjK3BnTlkzVkF6?=
 =?utf-8?B?bmRJcmFYclRycjRrMlNGK1hsak94WDdUalJNZUhGWlA2RnpRc1k3R1FWblFB?=
 =?utf-8?Q?5lwkIGPPgQxqR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFMrRUwxY0VXdTV2Zy9KU0VxSWc4QTcwUHRySjZTaFlvQ2VLc0Zvdk1yNUpB?=
 =?utf-8?B?cFVSTDhnNzRpOFlnZ1o2TEpPZlEvd2dTdVhzdGRlS3hnUXV1ODVWY1UxSWxw?=
 =?utf-8?B?RUY4RU5JeWtROGwyZ3JjQkNCUm1OZ1VySGhYY2F5RFFrQ1FGeHZLSnVwbVRz?=
 =?utf-8?B?czBFbk9sdGdnVXlWN3hadGFhMWI4cVRPUGVDb3FEcTYrK2ZvK0lJYVhNS2pJ?=
 =?utf-8?B?dVZVZitJc2w4cGJRS2YxMTJMN3AyYWh4bWkyY3pIcEt0TVBhcTA1V1ZaTnEy?=
 =?utf-8?B?NDJ3cERzdG5aQ3ZuTDhjVjJRY0lRazFKaFpZamNHcUN1d2lpL243L3BUemND?=
 =?utf-8?B?RUhmeklPYVE5b2UvbnJ1eHpFQjdMQnF6Uk0vNVgyUzhhRjRnVDBFTDBKUFMz?=
 =?utf-8?B?U1grVjFUcVYxQ2ZPU0t3S0duRXJOMEVtbXJmUVpPbkhEKy80SGhqUUc3NXFp?=
 =?utf-8?B?RnVFSjI4bXFMaVpyWUYrN28vUk1MU24xaGNSSXg3dUZvUnFnSUdGSlBlSURI?=
 =?utf-8?B?anVJZXhvZE9hYWM4WEI1QWduS1ZiYWRjVjJoWHhvdTRXNmtQSzdjQ0JhSVdi?=
 =?utf-8?B?M1V4T0tVK0luekI2Q2VielFKd3ZZbWZKb0UwM2lXSEp4dVUxaW5EZE9jQlA0?=
 =?utf-8?B?Nk1QdDR3ekE0c0RScm1OOW1yVUtqODFRU2tFTXBDdHhFOFBOMG0rRzZzTkxa?=
 =?utf-8?B?UVd0RE45elhMTUROOEdMTnQrWW9iSER0dklZR2gyMXlib0g4V0RaRExrRE9S?=
 =?utf-8?B?aVFkMU9Ea0VlZGh5UHBMajdJQ3RiQnV6Y0wyQXEwTkVxVDlubW9TZGhUVkRx?=
 =?utf-8?B?ZkRBZnlHRlF5d0FvNm92aXowUzdTN0NvUmNRcDVQdGV5Y05KT1ZxZ2x5S05J?=
 =?utf-8?B?U1FwU1lxcWt2eUxkRHdLS3Z2aWUvM1RmbUQ0MENzdWlNMkU5aTN5TWxuZzJI?=
 =?utf-8?B?ZGpnak01SlIyWTJhaU0rcS9ER0dzS2ozajBOWUFiOVI0eEltSzZDT043ZW9H?=
 =?utf-8?B?cTJUQ0szYmtPVFJEMUgwenFCNHcrY1BFQmZKL01KUzJCUVJYWlZKQ0M1em1r?=
 =?utf-8?B?WDJ6ZnNPSXE2Z2tZamxNSFhwY3hvNmI4UTMzdVVPVE9tZEdyakd0aEYreEhl?=
 =?utf-8?B?cWN1bjhjZlNsN1VLUFJSNmlDTjJYYW9EcmF4eUdGMFBzcnZTeTRsSG1scGlX?=
 =?utf-8?B?ZlRaNlhzWFpFNnR4THRweTFOeERaYUxMN3ZtNHduS0FaWGM4dFRyVXg1ZmQy?=
 =?utf-8?B?Mis5S3NucDVpSVBnR0ExS0ZSMnF0Z0szTndYMUpsTnkzV3pNbk5wa212TmxX?=
 =?utf-8?B?c1lvZmQ2K3kvNW5ScmVHUlp5R3JadzN4Tk5QY0hxK3JJQ0M0eDQxN3gxS3Vr?=
 =?utf-8?B?RW9BSFhHNUJjRzJ0SDNGWFFkNGFFTUVPOGxCM04raFVBY0QyQzd6bS9wWHhT?=
 =?utf-8?B?REc4WjlUV3JvbUVtWGpQQUlXbFB1aW5iajYzbVVGbVQwYUlMc3JsdDRrRml5?=
 =?utf-8?B?b2hHTithcldKZkVXWlZtUHdid3QzSUhzNlh1THBRbjdUdlVrQ25naENHemtJ?=
 =?utf-8?B?d213S3d2VTF2MEZUTmFqc1Yvakx6OEhyOHR2VmFSVEJXSndiSTEyZS9jcWo4?=
 =?utf-8?B?Y0dBc250c1pVeExpMDVEamRaNHBrcE5xS2pzdDk3ZU4zMitxZzhHeW9mUHky?=
 =?utf-8?B?d0ZvaWZ3UXgxZDlkUm41QWlPaWI2aDAwc0pibDA2YU9NNVY3U3k5ejQ3SFJQ?=
 =?utf-8?B?OU04UDlqR0VhYk12cEIzcnJkVTNUdC9CYVRJdjMvN2w3QkpHUm9tNS85eGZz?=
 =?utf-8?B?eFJVR2x1Ri9pbGQrWGo2M2lwMTNUQVM3c1VqMFV0b2hSRzkrZjF0cks3NS94?=
 =?utf-8?B?bjBXSnA1RzNDRXN4RWF0WlhwckwxV2p3OXBNQi9WeUsvc1hQN014dktiR2Fa?=
 =?utf-8?B?OExZMUErUm8zenBTMThwRW9KUVRtTzIya0REc0FKaWprb09Jb0dhajYrcHpX?=
 =?utf-8?B?dkEyazN3QnhKVmxhejdmb3FiS1BZUFpPb0x5OTNnQi95U2t4REtTQU8xTU90?=
 =?utf-8?B?TlVhTHhnZUltZzg0TXcrbzViNG5VZy9FSEl3aVFvNUs2VmlXeU1uUkE4U1dY?=
 =?utf-8?B?N2U4aGRZb3dVWnVZR0NmTjNCUkszSmxaNGVpY014SGlvckJ1RXlkbHFGRksx?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V4ORQ2gKJ7rdgwl9jHkWeC0tQzDM+CpA9mdboSND8Rzly96BcfUdGtRUgiBfhnu3q8QJQynEcsu11Bco3H1aOhs2y6G5QMKdkjv7z8kgfzpve1hIpiDReQH7/q7zQeBrXZc5iKMfLjLTxZ4I+kvhEWIpFNL1VvT4K25qpUXzn5w86wuKrfgK/8I4kSGcdCyhNDld/FDxEEABdTomak7m0aUe5wS8tvw/krh0cX3qsgiNe5sWAqoxl7IXL1J558ULVqNz5ELYjcg1+Ki+eO+YoaPmLluIFSGFcA1ghG9SHzvHaS06XA3VcON+LpWPXye6S2eQH4Oa6s+1tMDTA36dfe14PRo6XUj4r+rBTK2j/iRvnqbxB09jtvfLQPCW8Tyzc3C/ofDGyXKQY02waNif0rlBOyX5KbzNEZruB79usL2jwhWAqS4xCwS8kmOOyfpTtmFk7IZ1w1KaVy78Wp7QX8F2qDDyiR2wod9Sstxz9BEJ3ogsJXW7C+s75g1Q1ZA+dmm+tLFgHACL7gTPzduO4SUxljbA0BQQGPbhidOSCIKxwSyKuEuF8prDQlufQ9Z3lQBasZ4p1qrw7/iyQ4wGhbGZPdwhFz1lOZj8oA6xnvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74196b9-85ec-455b-84b8-08dd50478a28
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:10:34.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMgRn3vU33pPho4WjGq2nwXekc2lsjMxsMMfpKmd6V2Cs6KuCcOYAeTpKdq+kmmr7hKFwc2wfkloxQjfp6dUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180128
X-Proofpoint-ORIG-GUID: AAGL9ktBb8mXIeno4S78T2NIi059ROL4
X-Proofpoint-GUID: AAGL9ktBb8mXIeno4S78T2NIi059ROL4

On 2/10/25 2:48 PM, Chuck Lever wrote:
> On 2/3/25 10:03 PM, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> So, in order to avoid ending up with a flexible-array member in the
>> middle of other structs, we use the `struct_group_tagged()` helper
>> to create a new tagged `struct posix_acl_hdr`. This structure
>> groups together all the members of the flexible `struct posix_acl`
>> except the flexible array.
>>
>> As a result, the array is effectively separated from the rest of the
>> members without modifying the memory layout of the flexible structure.
>> We then change the type of the middle struct member currently causing
>> trouble from `struct posix_acl` to `struct posix_acl_hdr`.
>>
>> We also want to ensure that when new members need to be added to the
>> flexible structure, they are always included within the newly created
>> tagged struct. For this, we use `static_assert()`. This ensures that the
>> memory layout for both the flexible structure and the new tagged struct
>> is the same after any changes.
>>
>> This approach avoids having to implement `struct posix_acl_hdr` as a
>> completely separate structure, thus preventing having to maintain two
>> independent but basically identical structures, closing the door to
>> potential bugs in the future.
>>
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure, through which we can access the flexible-array
>> member, if necessary.
>>
>> So, with these changes, fix the following warning:
>>
>> fs/nfs_common/nfsacl.c:45:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  fs/nfs_common/nfsacl.c    |  8 +++++---
>>  include/linux/posix_acl.h | 11 ++++++++---
>>  2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
>> index ea382b75b26c..e2eaac14fd8e 100644
>> --- a/fs/nfs_common/nfsacl.c
>> +++ b/fs/nfs_common/nfsacl.c
>> @@ -42,7 +42,7 @@ struct nfsacl_encode_desc {
>>  };
>>  
>>  struct nfsacl_simple_acl {
>> -	struct posix_acl acl;
>> +	struct posix_acl_hdr acl;
>>  	struct posix_acl_entry ace[4];
>>  };
>>  
>> @@ -112,7 +112,8 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
>>  	    xdr_encode_word(buf, base, entries))
>>  		return -EINVAL;
>>  	if (encode_entries && acl && acl->a_count == 3) {
>> -		struct posix_acl *acl2 = &aclbuf.acl;
>> +		struct posix_acl *acl2 =
>> +			container_of(&aclbuf.acl, struct posix_acl, hdr);
>>  
>>  		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>>  		 * invoked in contexts where a memory allocation failure is
>> @@ -177,7 +178,8 @@ bool nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
>>  		return false;
>>  
>>  	if (encode_entries && acl && acl->a_count == 3) {
>> -		struct posix_acl *acl2 = &aclbuf.acl;
>> +		struct posix_acl *acl2 =
>> +			container_of(&aclbuf.acl, struct posix_acl, hdr);
>>  
>>  		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>>  		 * invoked in contexts where a memory allocation failure is
>> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
>> index e2d47eb1a7f3..62d497763e25 100644
>> --- a/include/linux/posix_acl.h
>> +++ b/include/linux/posix_acl.h
>> @@ -27,11 +27,16 @@ struct posix_acl_entry {
>>  };
>>  
>>  struct posix_acl {
>> -	refcount_t		a_refcount;
>> -	unsigned int		a_count;
>> -	struct rcu_head		a_rcu;
>> +	/* New members MUST be added within the struct_group() macro below. */
>> +	struct_group_tagged(posix_acl_hdr, hdr,
>> +		refcount_t		a_refcount;
>> +		unsigned int		a_count;
>> +		struct rcu_head		a_rcu;
>> +	);
>>  	struct posix_acl_entry	a_entries[] __counted_by(a_count);
>>  };
>> +static_assert(offsetof(struct posix_acl, a_entries) == sizeof(struct posix_acl_hdr),
>> +	      "struct member likely outside of struct_group_tagged()");
>>  
>>  #define FOREACH_ACL_ENTRY(pa, acl, pe) \
>>  	for(pa=(acl)->a_entries, pe=pa+(acl)->a_count; pa<pe; pa++)
> 
> Trond, Anna -
> 
> Let me know if I need to take this one via the NFSD tree. If not,
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>

Gentle ping: Still waiting for a response.


-- 
Chuck Lever

