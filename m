Return-Path: <linux-nfs+bounces-9573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCEDA1B788
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0869F3ACEC6
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D281433CA;
	Fri, 24 Jan 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VijKR7EJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sbr2jKWw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3612E4A
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727472; cv=fail; b=ePZ024LoJ2wYXP+PuIfOBPa+5MEYh8ikeqvmfYNs+vrE1Lw8eLuArSQ9FZ4O0Y5/RKDSM+Of6huEVgRopkTrHeIa6AN2zD6SoKXJ8w9tF2gbApId/AvpFM35dCn3VWOC2phtiYRB88YoC0jhyaXLEMlGheT5yGQFlJU9itD5JF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727472; c=relaxed/simple;
	bh=Re164cxRgHvDLTOOCAyfKN9xD1ekK+B6qhZZwEFsrK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kXBtPTwf7/k6GYXmZMjYnQ8k6vfypGA7sdy2mokedoGmT19bJTNQZGx7lSqPdp6BzYmy2ZLtAK1BcIy8B7RFiGhFNa2FZHzaoHS9KW5MuoiJV+xKfHKRGgEY/TfvIiJHBlxaIlGNYf6GoB/kGG6UrqPEMTxJWE7oLS3v1W9t+fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VijKR7EJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sbr2jKWw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8fwbb018166;
	Fri, 24 Jan 2025 14:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jssTpcKmLutdQjT2ktepFXzFGLBvSGpTv4RV323VNRw=; b=
	VijKR7EJwl1iTHWZ6rv8wQSxhsDYT6xtUHn7KxHpJnroRUSc99INO8thx+UJadsy
	66leW0px9iHQh53YTjwH4pVLLDAjEpRtxuz+ogSt/yyqwDvdBNca05Vwi2IcjUd7
	/0KtPVH3oL7KasMqr/MS18d219rUy7mXbZg09c1T6kofhb6t++jW7Fa38NlEQMeb
	C0vJ9jtkvMiHnlRpykTlRG3OeMZcnLylCE/hc8I5Cd5rmy05K8UWi/O2kuBZ2ahN
	5Z9Sgh3h0T+FG6FccbUQJejfsCzEx+YmkbrAArQi5q2EgVh3SqEaQfJ+l5FBSeLb
	xXCi5e2M+MeY7LHNnnITSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96ak8rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:04:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50ODMkOU030437;
	Fri, 24 Jan 2025 14:04:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 449196ga60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6MrKbPViKwLyQaAHZXhlRmU1n8tPEcvWLOk+HEetjE4caaBjaD84cHVe96aFd3Jo0UJD7uzPcs/hhpXLY3t7Iyq62zjj/IEDD4Qxk4p92GjW+Ev1n4WfYtYnvpEXHJSyG+71fk5hoNeNFf5+KWf7yGAvSxv8QTgfCy/iwajamFE0rEzRIQLcTn0RCvIZRbxETTOVVEANH/8ruR3gM5WvgTzqaksuxw3YHCV4qhVlAuLMot6Ue0H8NKOcz8OqMQ7DL6J0/aiYn1whYu72c7rB60fcaR7AW18DQ0yR+aKJRXB9ArSO+83VOnxQYcjDVDH8+lmT6H4pKQe368SoozNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jssTpcKmLutdQjT2ktepFXzFGLBvSGpTv4RV323VNRw=;
 b=wC5aY09qQthuxZTjNvN/e1xLXyAumpzWpmY7Gtwv4mJPrR74vFBRVXNl412LXFOnARVxfSOSQvQAr8awUIOo3Ste2D/DEWeQOdLPOj/tBc0E23xre4bvo9iR703UpifV79kJM+z7EXpkZtApQp45lTTEXNqFr4u8di0oiEXnu8C9OSiCOPUDkBWL0AMh2elTl5YHRIB6s9QnfSG3obhIRj/yl71+9Oea1KP1bnyc1b58Aas9sOFO5dMbUN9YMExxlRzwNJoh9eBtBoY9lsMsXepzUVvDqbMA3WCDy75xUZr7e5gjxoSm8d56QCNlgmEu+WZnk12qEFWMWjlVzX4L3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jssTpcKmLutdQjT2ktepFXzFGLBvSGpTv4RV323VNRw=;
 b=Sbr2jKWwI57hZk3ebBVF4OzyPg/O8xYrxeWBfpHtdsrY3hh38V97uCdwDSA9P8VXZ7/ibCWG9U4MZ2WgnYvGlgc21xMGMKWWLKwpPH+O0DUmIKiN9pmM1ssro9B004ofQlf17q/8jeXVqA9L+RpiCDt9IAohMdglV9E9OzJSVHs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Fri, 24 Jan
 2025 14:04:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 14:04:12 +0000
Message-ID: <3dc5971a-5fb0-4bb6-856f-ffb15d18bb4e@oracle.com>
Date: Fri, 24 Jan 2025 09:04:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] NFSD: Return NFS4ERR_FILE_OPEN only when linking
 an open file
To: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20250123195242.1378601-1-cel@kernel.org>
 <20250123195242.1378601-5-cel@kernel.org>
 <0a1607952bc35549c925da8599ce366feb951850.camel@kernel.org>
 <CAOQ4uxgmucVZtOL=M=UEOaWuPaLoQusY+ux+JLP+n3V_PBq2Gw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxgmucVZtOL=M=UEOaWuPaLoQusY+ux+JLP+n3V_PBq2Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:610:20::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3fff13-2808-482d-0497-08dd3c7ffaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHVWdzRmRENxcHNJMGVHR083WFB0YnB5WUxqd3RqK3lCeTcvOUdrOHlJSUli?=
 =?utf-8?B?UjN2NUl1eXdqcVhKVUJQSEF3Vjdsd1h5NFlaT0FMZ2tHY0RnUGdLWHpmSFdH?=
 =?utf-8?B?VXQxWmx3R1BTRzFvb05yYzN1K2pZZmF6S212cG5MTEFJM2FyWkJQUXdkZ1lM?=
 =?utf-8?B?alhiTUt5UVNrdWo4cFhuMXNveE5sUTVqTXh1engrWUtxdTZwbDEyVk9mQUVT?=
 =?utf-8?B?YWJhOUdUa3VxL0xzZDRCTm5uei9DYlE3N1piSzNIMFcwazZZTmVFeHUvaGZ1?=
 =?utf-8?B?d1BnTmdNWXR6OFdiNWVJdTlMUzhnSW8yVFJIU2dRYVZZWktZejlLSk9Bcnc2?=
 =?utf-8?B?L3ZDcUhRb2hiUm5ZQmExVlpGSFFreGVudGRwREdUVVo3VnJCL2hnNVhvNWpO?=
 =?utf-8?B?RWNVT21KK2xqc1JETUovd2ZNdEpzMkg4VkxtYnZNSWo5UEM5blRtelpkWHRm?=
 =?utf-8?B?Z3huWENUMFVncmFFdGFFa3hwblhBQTJBb3VGWG9KbFhKZmxxY29UT0dzY2Vq?=
 =?utf-8?B?USs0QWtmckJyeTJvT3VsL1d0czhycnk5aUFFYUtCcFc0QlJJNDBSbFFsOWN1?=
 =?utf-8?B?bDhuUTB0blpSNGo3eC9obnRIdWVTQWg5WjF6SnplcU5DbUhETXRZUmRDM0NY?=
 =?utf-8?B?NjBlNlpxbGliSStXUHozRXRlVWFLd3BMVWhBUmNrMXgvb3ZiRzNXMXVOc2Js?=
 =?utf-8?B?SFNxdyt6Y3VBQ0RQR3JWWXBIa0FvUXBDcFN3REt4WDFka211clNwVG9NOGxP?=
 =?utf-8?B?MjVmL1Bid09rTVJNNFovUWQvc1o4UnRBYWk2T05wcFp6bHhlUWFJaWJveUlJ?=
 =?utf-8?B?aHJDSlF4L1RjUlN1bG9HT2hhc1FXQkVKU1JncVhKcEpvVmVCWGVPdDdNejFl?=
 =?utf-8?B?VTViSXlHajY0RTdzemJqbklzTnp4R2k0NVNjQzFqbHc1UzA5T1YrRmJkeVg4?=
 =?utf-8?B?SFlqSU9tdk5Cb0dhaVZvRlZ4S2hYSEVjN1NGR2JkcUd4V3cyMTFROElycndy?=
 =?utf-8?B?S2VLRFZXa1MrYytuNGNIcE42N2QvVGcydjZpQ1pIb2V1c3NkWEpNREhadDdi?=
 =?utf-8?B?WW9jOGQySEN2UVRtSHlRemV2RnZscHFYazhONlJQYXZYN0U5Y2JGMjZiM2dV?=
 =?utf-8?B?eUFEYkJBdVRZV01CUVJjL3NRclhKa1I4ZnhzTDd3VHlPYm1xRjhNanBodEFY?=
 =?utf-8?B?SmptemFvK3FlYXpiQWdBcXJac2N1YjhFK2JQa3JNeUl6SE15T3ZXVlpVQlhT?=
 =?utf-8?B?OVVFWEluZ3QzSnJjaTJ6SG94eDdxY3gzeW1GYitESmd0OTVFeGlPLzhTM3Ir?=
 =?utf-8?B?L3hISXdQc0Z1NFlDNlI0dHdPeE1MbVBJZVVKRk1mWmpzaVBEN0UycUwrdnl5?=
 =?utf-8?B?TWkrZ2ZQZE5xYjBLNDFBVDhEM3dLbzZnUFdRZzBmM3JWTUZOTlBLR1dTci93?=
 =?utf-8?B?OSt3MTl3VUM1bnBVSk1uL0tCTkdoMzNHV0FoMERtUkZwOHg1by9ZUTNKbWls?=
 =?utf-8?B?YW1ycFMxT3N5YkdKOTJId0VyckxQWWpxdVdYU0NvTnZVOW5EWGYxTnErRG5B?=
 =?utf-8?B?cVRQUCtQcG9STnRhQ0tnMlQrODcxYk5LZWNnZDZTY1VONzhFa1dneEV5bXhT?=
 =?utf-8?B?aEZadUNyRWNzeGJjaklSQUcrYm8vbjd3cW5IaFBKZWczZDJLY045RnZPTGZw?=
 =?utf-8?B?eEZNb1R1cnZtNUVadkY5ZDhwdmtXSHEzUUxOeVQ0ekJBSk5UMUZ3bGJxZjhl?=
 =?utf-8?B?azZSdWUwSDdlNkxlRzIxNzQzVThubWhTdWhrV3pOOEdvSFVaVnhFVUU4K0h4?=
 =?utf-8?B?N1hHc2kxMEdha1N5bXF2Z0hGM212K3M0Nk1rVFlBV1E5QWNSQmRMU2VaZFhy?=
 =?utf-8?Q?03xXBKMibv4Tq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUIyVzdsOFBJOCtod1puQ24xM1ZCOGpwZ0J4S2hNQnZqMjVISWV6Wi82TXJ6?=
 =?utf-8?B?YkYxRFZDbkFmKzFmS3JaUGFjTHRDcjhua0dWOUcwNEgybnlnMnFLQWlEa25r?=
 =?utf-8?B?SjhYOHNReDh0Wnp3b2F3ZzZqRWdkcDFueDBqcy9NYzFvY2wyUlU1bU9YK2NR?=
 =?utf-8?B?QzB5REVXSDZqK1hPMzcxNDg2em5Kc29hT0VJejJtazVqb01ITXk2RHFzdnBH?=
 =?utf-8?B?MTR5RGFOSjNvODJ6aklQVVVHYlV4SUZMQ0FwSXE0NEdQbU51YWpPVWcybzlX?=
 =?utf-8?B?QWRncGVxa3YxS1hZa0tqaWxEbC9mY2NQYmRTRmdNRDlVZWl5NXZZUG9UMW9k?=
 =?utf-8?B?ZWdKMG9JZkVIZ0hObktnTzRYaTR0MHVHRy8xN3VlT1hhUXdOSVI1YzAxMnBy?=
 =?utf-8?B?Q0x6ODdXWWxPVzZ4SldpQWd2d2hyRlY1SXkrelZ6TTBESUNSOWdueVBtQzJT?=
 =?utf-8?B?NGcybGRlczBONXB0amNxOTBGWTFmc3lwMksrUTBMVUJITjU2c3hKTkpxZ05W?=
 =?utf-8?B?OFUycjhrb0RQMFJtNzlQWmtwT05lY1FLVFZLT0NDSFVLV1dsWk5sWVpDT3RQ?=
 =?utf-8?B?dzhHZ2IyVkdyVEo5UXNNcERrTElOb2JQSTg0YWxFVkdSMjVmRWZSTXg3SnJ3?=
 =?utf-8?B?amVUZTR1WmpJRWdZOFRwYSt5eFVsVnRhcCttMEU2VEQ3Rm1tV3NaUFNpY2NH?=
 =?utf-8?B?eUpCd0VSSEtDZU9rcTVVZDVZQUZzM1pOR3FIUWF5SWk4SU1rY2FwQ2dDK2VN?=
 =?utf-8?B?QUpML3IySC93a2xxME5nWDZDUGEwNU5HaUdPeURURjhPQUExQUVYMzI4NGRa?=
 =?utf-8?B?UFBicjF0L0F3ZHVmamI2UWdLd09KZkh0TDliTWtiL0NTbSthQ1gvRjc2eS9n?=
 =?utf-8?B?RWtOMm1KZVNTMUJ6RlllMFFGZ3N1ZE95SmdDSEc0cXNNN21KS09WNEVYZVdY?=
 =?utf-8?B?WWFEVEZsOERyejNUSHpGSXRxZFZtWlp0NUI5bUVjTTJrNjlCVGJRSHNEbU9E?=
 =?utf-8?B?Mnh2aFU5YzV6djBvM3VLQVVKS0twdnZpRGRLVEdPSHpqWTBlc2JaemFUNE82?=
 =?utf-8?B?Rmx0NEZta3plZ0xwMDJUTVRiUXkyWE84R09XTHIrc3hvazdGRFFiY0dsYmZ0?=
 =?utf-8?B?ZXI5MWFZUkZJK1BzWmFIbnB5SkkraHgxRmRvOEY1WXR4b3Q1L2VsZkd1aWdm?=
 =?utf-8?B?UHhxZkE0SHNPZys3aVcwUHlEQjZ1NUs1VzllR20rUWJrYTkwWmtHMi95SURJ?=
 =?utf-8?B?aURlanZnNW9oQUJXSjd4c3hrTkhWczZ2a3dxc2kwY3B2WGxuMUJGeXE1ZFU2?=
 =?utf-8?B?d2MyVS9lTkJNeVBEcU5ZNitkcmxOd1FYOGtOcmYzcEtEV2V2dTl0UWRsbk5N?=
 =?utf-8?B?cEtGYWNWalZEREhpMFI2SVRjdC8vS3ZvMDZjejVBcEV0OEVoMFNISFVPL1Yy?=
 =?utf-8?B?Y1YzWFplTllZSnk5WXZBdXFYeDZvTnZScmlGK0hWbFRKVjhLYXJZTDNrZ3hj?=
 =?utf-8?B?cHhtSXE0bi82UjNHTVFRYS9EMWRhRk12WjlESFR1aVVKK2hHUlFpcXg0eFE0?=
 =?utf-8?B?c1RZMUpENWRnV0RNQXRrTzVpb2FXanVxL1NpQXlMUnp3ODAxV2ZHOTRnbFF4?=
 =?utf-8?B?RWx2bHQ1c1p2VFhrQmVPT25LNVQ4TzFONlorNkE1dE5lUjhyQnZtTmw0Y3ds?=
 =?utf-8?B?NnE5NDVJY0FQQ2xHdDJIK2dJbDk2R3BMRGdSeEFYL0s1U3VmNnV3dGlhZXdU?=
 =?utf-8?B?UWI2WmRpamdPZnMvNmZTMmhSWTQwK1FESzhzWUJjWnBIMFRuSm90Vy9SU21M?=
 =?utf-8?B?dFNvMmhtb0YydGpMQ2lwRlhxUERpbkJDcHk0WXIvNG10UzRBd3RSb05FQUtp?=
 =?utf-8?B?cmRkUzljWjRFd3BsYWVDYVpRL0Mzajk3UitidHU2cGNvRVJiRmtRa3V1SkhD?=
 =?utf-8?B?aTRRYnhmRWJmajdjVllDQlNqd1dLZlAzQW5LVGJmeXJoUmZiSkpEdHZVcG9T?=
 =?utf-8?B?Zkx3cG9ERFRSS2NFd21qVks4eXkwSHFLTDRJS3lRNGhsbFl0MXlST3ZGd0dz?=
 =?utf-8?B?aEExL3dPRUg3amg4YWxFbERSZnVmSGNHUU5XaWVsQ0E4WXVjYkxKcnR0aEM1?=
 =?utf-8?B?cVpBTURhdlZCaWlGd094ZGgxd1VWVlJJeTBhSmwybnFTNytoOUdiV3E0aG9U?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5TvK+C/SNAsLyYzr3Q0HHNdw4KWKJ7Xt0mxGl3mfo5Jwai6bj9jfM5SlFalLNw2d3Eui6NFSkyX2VWPV72WeniOmrfvFqcz4kTBo27vab3XtOz3N54xJpvkey0XZ0kVtALDRsEikWNFwzyDkzfLQegzmTavwAzCH/NBGqYfUQqW8hPcZhIf+0Mj/G7OagoaOnVU6pYSaICx5mYgAacUkL4/e/yZHXoEmeMWGWSdTznspaKMaozj9f2dZ9s6m5OIFPM0w8EfRkZa2y61uHqP/kpPPos8l/oaRx3DSwm1EX1PPMm8w5at/mHtiWcfXAMZVmuH3k9Vq2eoou4MDEfGngYrqOMckoqHsw51H+OMIJ4gFQPqCU1T9oBolfY0Nm0mS9jPqpB+Qfk7g/yQhBYbyRtqURqpcdbwNTMxuPfF+ZPMZKueDgyphSF34nTbbUZXh3mC5R51aaBWbjn6FvCXFnF7IZdWTNqAayKdC4SnYxa94YAyJVz6lRNXnnjvvNVHjms49GIFlvxtAT3ivLJx705tPyp2M4X4CDMbv/AMkiO61heSMljQN5LEXYHWMYbcruivhmgd0T+59MAU78wTsRAV78BX2Xm1jAgHyB8rMxmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3fff13-2808-482d-0497-08dd3c7ffaf7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 14:04:12.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cIPA8U12IhqE+Q97Xu8W1kW1GZaaQ2N9VhBh5ByjLHdp1+fPwrwIMqvsfT0kpsVPfz5jxfjrf/2DkAL9A32BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501240102
X-Proofpoint-GUID: 6NO-c92bmGefL1-mAEqnYSAIq9YenQEf
X-Proofpoint-ORIG-GUID: 6NO-c92bmGefL1-mAEqnYSAIq9YenQEf

On 1/24/25 6:22 AM, Amir Goldstein wrote:
> On Thu, Jan 23, 2025 at 9:54 PM Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Thu, 2025-01-23 at 14:52 -0500, cel@kernel.org wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> RFC 8881 Section 18.9.4 paragraphs 1 - 2 tell us that RENAME should
>>> return NFS4ERR_FILE_OPEN only when the target object is a file that
>>> is currently open. If the target is a directory, some other status
>>> must be returned.
>>>
>>> Generally I expect that a delegation recall will be triggered in
>>> some of these circumstances. In other cases, the VFS might return
>>> -EBUSY for other reasons, and NFSD has to ensure that errno does
>>> not leak to clients as a status code that is not permitted by spec.
>>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   fs/nfsd/vfs.c | 44 +++++++++++++++++++++++++++++++-------------
>>>   1 file changed, 31 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 5cfb5eb54c23..566b9adf2259 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1699,9 +1699,17 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>        return err;
>>>   }
>>>
>>> -/*
>>> - * Create a hardlink
>>> - * N.B. After this call _both_ ffhp and tfhp need an fh_put
>>> +/**
>>> + * nfsd_link - create a link
>>> + * @rqstp: RPC transaction context
>>> + * @ffhp: the file handle of the directory where the new link is to be created
>>> + * @name: the filename of the new link
>>> + * @len: the length of @name in octets
>>> + * @tfhp: the file handle of an existing file object
>>> + *
>>> + * After this call _both_ ffhp and tfhp need an fh_put.
>>> + *
>>> + * Returns a generic NFS status code in network byte-order.
>>>    */
>>>   __be32
>>>   nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>>> @@ -1709,6 +1717,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>>>   {
>>>        struct dentry   *ddir, *dnew, *dold;
>>>        struct inode    *dirp;
>>> +     int             type;
>>>        __be32          err;
>>>        int             host_err;
>>>
>>> @@ -1728,11 +1737,11 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>>>        if (isdotent(name, len))
>>>                goto out;
>>>
>>> +     err = nfs_ok;
>>> +     type = d_inode(tfhp->fh_dentry)->i_mode & S_IFMT;
>>>        host_err = fh_want_write(tfhp);
>>> -     if (host_err) {
>>> -             err = nfserrno(host_err);
>>> +     if (host_err)
>>>                goto out;
>>> -     }
>>>
>>>        ddir = ffhp->fh_dentry;
>>>        dirp = d_inode(ddir);
>>> @@ -1740,7 +1749,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>>>
>>>        dnew = lookup_one_len(name, ddir, len);
>>>        if (IS_ERR(dnew)) {
>>> -             err = nfserrno(PTR_ERR(dnew));
>>> +             host_err = PTR_ERR(dnew);
>>>                goto out_unlock;
>>>        }
>>>
>>> @@ -1756,17 +1765,26 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>>>        fh_fill_post_attrs(ffhp);
>>>        inode_unlock(dirp);
>>>        if (!host_err) {
>>> -             err = nfserrno(commit_metadata(ffhp));
>>> -             if (!err)
>>> -                     err = nfserrno(commit_metadata(tfhp));
>>> -     } else {
>>> -             err = nfserrno(host_err);
>>> +             host_err = commit_metadata(ffhp);
>>> +             if (!host_err)
>>> +                     host_err = commit_metadata(tfhp);
>>>        }
>>> +
>>>        dput(dnew);
>>>   out_drop_write:
>>>        fh_drop_write(tfhp);
>>> +     if (host_err == -EBUSY) {
>>> +             /*
>>> +              * See RFC 8881 Section 18.9.4 para 1-2: NFSv4 LINK
>>> +              * status distinguishes between reg file and dir.
>>> +              */
>>> +             if (type != S_IFDIR)
>>> +                     err = nfserr_file_open;
>>> +             else
>>> +                     err = nfserr_acces;
>>
>> I guess nothing in NFS protocol spec prohibits you from hardlinking a
>> directory, but hopefully any Linux filesystem will be returning -EPERM
>> when someone tries it! IOW, I suspect the above will probably be dead
>> code, but I don't think it'll hurt anything.
>>
> 
> Not to mention that unlike rmdir() and rename(), vfs does not return EBUSY
> for link(), so this code is not really testable as is, is it?

You suggested that the VFS could return -EBUSY for just about anything
for FuSE.


> I would drop this patch if I were you, but as you wish.

I can, but how do we know we'll never get -EBUSY here?


-- 
Chuck Lever

