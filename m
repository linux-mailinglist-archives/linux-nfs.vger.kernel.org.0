Return-Path: <linux-nfs+bounces-8633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6482C9F561C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959B9169750
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22981F8AD6;
	Tue, 17 Dec 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LgfYyfU9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cp0YjIAL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A641F8676;
	Tue, 17 Dec 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459970; cv=fail; b=PIqoG8Z3IoogDIwlDYWiwxx0u+MOB/koTXi8pRkmAucRkMUiQFemBA3RaHx687wm4ayvtHJ9tLA5d4YNZ6auYX7cbx3NS0ty+h2igMjMIXD55ggV78Z3fPNuUQL1CSnA5YYO1hivHHl3heGs6TAtWWWiBxgamNsslcwPhk2lhr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459970; c=relaxed/simple;
	bh=E5QICVzaohnBtxppBG8VR0yIOifPFNxJpCp2bMSrJqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PC5BP9hQrGeamK9EGbw2o4t8wRW0R1r/NMrd+y6c02xUP4vg65OzBR2cIdHMFY35fAvKw77AQkXf0IDKYedWJ9xW3QZMGpLZRfzaThv+Z+0Sw2v/0hu519TPwWpToCf1avcK02ch+T6ofvFuYI+VfroNnsUZQVqoOv7H98e0hFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LgfYyfU9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cp0YjIAL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHCu0te010793;
	Tue, 17 Dec 2024 18:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dEYNxJw/Th7aV/XvzKR793JL9g2ce2LW72PDENJkH3Y=; b=
	LgfYyfU9p1ZaFZpsXuwMp8QFOoz/pL9ZWhVcgpS4BxCccf8JYBsjwVKGIHCvjqdw
	RcfO3FFGpbNkCFPRiOycFCPSDt+0kiWHijF035/SgX7UzGLt/1c4VCy2iO7D9Qpk
	N1EdURemFUab/lEtc4TlAee/TTIQ2Rnm8iG/UvfRftf1xsrNw9PvLYBdHe64rbV2
	EGz6SCU84ppbS1NM0M2PM3OE2tgSlBtH0P8+6f+U+N61D62If1UzLAVqMT/B2aWs
	VNFra0zzWdKlRJW5n5GlhPFqsX3sBl0TieTXCt1XIxBkJMlCRBhEz+rXcg/fyrZ7
	Mxfylvy3XYtD3RC1XK9hWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5ck3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 18:25:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHHVRgG006376;
	Tue, 17 Dec 2024 18:25:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f9r0pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 18:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa5PK7KHyLmVRIw5+txCnhn9R2YVhtIWNiKQByR6E63JHuRSud7gUoon1Ozs3OnnjOQRubfSZkC3k4MDgDzRc++f1i8ubMNHIDie6G4/d4h+H+oTH6cQlLSWZqwnNx1Z/49tMihQsgTluzXjhhZrMd8veMBNLVdnLkeuXw9azskvygl96ufs+LJkkzwGgVx4G/4U5ZVUmALiO/0JfXJ0BBQwMlclYzMvP7qgOHgzu+21nuIqpYUcrtJxl2o+RqUwVgd7E6ggYgngg+PSNgwxE9pzrpxNLMlxVwheGig5nQfmr6RQBO0hRgKtOBIYXFT2Tb68FWYi9+hFe8ir/VTYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEYNxJw/Th7aV/XvzKR793JL9g2ce2LW72PDENJkH3Y=;
 b=DoLfaCJbtwD7IVbklYvrNjAK2aggkBe9EE0hcJg8GU2oOJl2J2ygYMifEVyUBpNjCZrH4+5FVxRxfYR82EGTu/tMaMRoj4ROFLNLlaOqJk48qz7cDUlQTZFqTRlOR4LoU95Wbt7d7A/yIqvZJFg/7dL172MeAvdhIkOWzud0d65pMBjRttijMnjKzTA/GKE+nNYpVjBhp6qElpp9wisDdaRwc2Zt/lYqJb9rfsmejdkVLZBne4xGJwWk/JCrOSufnoVQRzUYVxj/W/pNF1Vk3saeUpAYt8Pcj7u0pwPTzolaWegRuT5FI/rCvYyvlvZ70HZQI3WisuzA6HplKCuc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEYNxJw/Th7aV/XvzKR793JL9g2ce2LW72PDENJkH3Y=;
 b=cp0YjIAL6d1cSfARXcPfwyxe/3E+bExzUC3mqdnEbTfjhrGvTfIMdI2aKiTBlMwONE86S+zVaywh5VnPqAau0PPjX429cQ80w5juQjn3AeoEPDqAdtrKOHwyjb2qcSQsYh09OlDsXbezxap9BBkSKZiUGG8xWl7V9U7wPjPiT54=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 18:25:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 18:25:45 +0000
Message-ID: <7b0ec3c4-77a1-49cf-aadf-7d393c750f8e@oracle.com>
Date: Tue, 17 Dec 2024 13:25:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-50106: nfsd: fix race between laundromat and
 free_stateid
To: Li Lingfeng <lilingfeng3@huawei.com>, cve@kernel.org,
        linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
        yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Hou Tao <houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>
References: <2024110553-CVE-2024-50106-c095@gregkh>
 <ef9774e3-572b-427f-99e9-c6a456ffe4fc@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ef9774e3-572b-427f-99e9-c6a456ffe4fc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e017ef-5d57-47f9-b787-08dd1ec8391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVR5WUtnMGl0SmgzZFltbUxXbzNjVEZaQnNZOEhsdEdRblVscVl5NzUzWmk4?=
 =?utf-8?B?UGNQdkQyUnRLaEt0T2hHelNka2IxMHBwN2lUYVBna0h5K3lLMFVEWDhsRzdB?=
 =?utf-8?B?eE1abEFvMDVkQi9PckRLOUxRK2Vra0hsTmNVb1RNU3YwSHdnTDV2NVVsNTBV?=
 =?utf-8?B?dERuNFZTUXVuNVIvNmN4K0VTbmZWZnVjNDUyclZHdE1nNGcwV3d4MGtlamhr?=
 =?utf-8?B?Y0UrU2xxOW4va0tLQnVrWHVrdU5zRGdPSWZVMUtvYlhscXJmVTlaOE5pRW1L?=
 =?utf-8?B?WkJUbDRkdXV0SnRwdVB0OHBYTHRKb3AzN28wRHlRYTc4Ui9IVG15VUtDcEdE?=
 =?utf-8?B?bVJFUEsxZ0RyaGJXU1ZvNmtRbE9KazFEVDNOdDZrUFE4NGk0M1FhRHFqbldC?=
 =?utf-8?B?bTIwb25DbCtndU1OQmhleGdMbFRrbWxaVnhyRHo0NVdBbGE2V1FSdFJCNUZG?=
 =?utf-8?B?V3V3OTVDQVN3dXpRRDJxaXBWKzNHcGphTjVkMjQyNFRFV1lWTWhCZmQ1YndP?=
 =?utf-8?B?Mk1OMlZEbUczMlJxaE9hcWRidzdIQXE1a2dOS3lpUU90SFl1L2wwaWlhRnNq?=
 =?utf-8?B?dDFEVGRTNTl2NnZBZ2wzaExRYXhGNEtqVTBOci91Z3U3ZlBSaTkwL0VRMEs2?=
 =?utf-8?B?NU4vb3d1ODluandTRDk5RVFMcjl1dmVZbWlXYjcrNytob0txanBRa3hxQkp4?=
 =?utf-8?B?aWJxZjlyazBmckd3NG85emh0RDlic09rL1FnTGE2ZlBQdWxYV1hXOW5HUWtv?=
 =?utf-8?B?ckJhM3M4Nmt1U1hxYjhQUDJiWlVjWEEwUnlIS2FPY1l4Y0lIWXV5UzFFU0Qz?=
 =?utf-8?B?K2FURXBNViswTG9odlFwb0hPMzZ0dVl6NlZnNWowZ0ZxYjVuVWhMOGRrajFR?=
 =?utf-8?B?RmNxdlZsY1N6Vm80RU5KSEc4cVhFMjhUeGhvbU84d1pRZ3ZOZXVHYjZMLzc3?=
 =?utf-8?B?YTJVKzVLRStCWWFwdG1NM0xaaE9Naks0cUVpL2MvV0tnWmhta05FRnZhSW1a?=
 =?utf-8?B?MnBkNFc4bDFadXduZnZNTEJuZm5YWHZLWHhncXk1N1pHVUpEYXlEbXczTzFo?=
 =?utf-8?B?NGZDampiRGJFMW1VTlIyallyU0RBV3BKMkoxdE9jRVFyTndxa0hKallxVWNG?=
 =?utf-8?B?b0lFcGh3eXZ6OW10YlAvbmhyZnovYXVCMG5rdUV3NlU4d0p3M0hTT0grd1dG?=
 =?utf-8?B?TURrSGx3YzEzOE1WUTIrUHFJQTE3cEsyaWlWa0FBeTE4Y0tCbVcxam9CWkYy?=
 =?utf-8?B?SjErNzB5VUJhYmNqd1VSbUx6cGs2OENMZmVmSGE0YXdCUTNiK3psaWdORy9C?=
 =?utf-8?B?ZUM1ZGJkd1RmbE40VUlaQW0yTWw2bVpYdlR6bHYvc1ZnSWlmSE00bE9jNjRE?=
 =?utf-8?B?VzZQSUtaZWhrZWkrV1d0b29lUXBGalhjK3E3RGhNSjlpVFBXdU1hNklObkZz?=
 =?utf-8?B?T0tNcXZzcXJmOVZIR1Y3TE9TM0xqOGY4bExpS1RhQytXV241UEMwWFZOQUZj?=
 =?utf-8?B?VU01WUNGTEMyY0xxUDRLK09WVWRZV3NvL1ppUWhxektQZThTRG4vajc1cVdm?=
 =?utf-8?B?YnM5L3JqS0tnaWt6Ky9wUnZ2bWZGbkM2MCtVdGFYSUtoTHRzMDQ1QktFcGxB?=
 =?utf-8?B?MUM1aFdXVVpBeWphaDAxWkpVdnJLN2VXMmZZYkxCUnlKZHBZRzhQbnJvM0U3?=
 =?utf-8?B?MVBXbGtHT3ZvejUycWwzVEpzanZvbldPd3hPVnRNV2FSWk5uRnVqTTVSSkpI?=
 =?utf-8?B?Y2RUbVFDWFBvL3FUKzFOeFFqUTNLRk1CL3RUREh5YzZiOEE5MU13SHVYUzBn?=
 =?utf-8?B?QlB3WXdSSXBxbkcyK3JSQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckF2RmozZGlsTERWK1lvMjBaQURVd0xMYUVFVWgzUVAvdG43aUthM1doMzlZ?=
 =?utf-8?B?WExRMHlwU0xqZVRheVpzTEFkWDNDdlhKS1RZNnV3S0ZiUldxOFVEQVlIYVVF?=
 =?utf-8?B?dC9SQnBPZ3htNDhXYlVvcUk1akxhd0VrZ0VEUTJXbVNRUk84ZmhXRlBJVFdD?=
 =?utf-8?B?bmtwbVhpSm9pRDhMbU8xd1B0Y3lUVzU2NWJCTGlEUU8zRzJaU2ZFeXFxWUdm?=
 =?utf-8?B?eXZoWjJHdVU2Mk5Xa0pCcyt6TlRjS3IxQUV0NWhmVzQ1QitQSmRWZVBCTXF2?=
 =?utf-8?B?VUMyU01xRFE0R1llN1lqWWdJbXNzVDF6T0paa0Z0ODJHVE1pWWd1VXJjZG9p?=
 =?utf-8?B?SUYxU29SZG5HL3BmZGdNclJ4R1Z5QWtjVlUxb2lZK2F4OTBISUljTDZTdHFG?=
 =?utf-8?B?UlVDRnJBcm1PVUQzT25mbll3R1FFV0hWV3RyNEtzMkZYVU1ma20vM2lZQkRJ?=
 =?utf-8?B?MEFaUjBkcEJKZUpkeVBlQklVT3lsTDFRaXYvUTdiY0pOSkFZRkZtZ0sxR29W?=
 =?utf-8?B?Slg2WWtnWXcvdFZqVFlZcVdyOHRkR2N4L3N5K0Z5OEtXRXp5Qk1WRmJTR2hn?=
 =?utf-8?B?NWRPcWVkUnhieVI2ZzYxK09NSUhjMElOYVpFdTlpc2h1dnU5dGlXSFQ2QnYw?=
 =?utf-8?B?Si92ajJXNGh4L2UzemU3MUJrdFZFQmlaV3BtR0JJWS9RRmdtdVI2RFNCVlJj?=
 =?utf-8?B?MkhMdFViVHh2MnN5TGtYOEkxZkZHR2ZQdG5YOHFUUWlDZForOE81WHJWNXc0?=
 =?utf-8?B?anhrWGhkeFo4bEVwOURuTk0yek93N0krWXhaV1lWWWRPTkxEMVNSaEd0THVP?=
 =?utf-8?B?L3Z0ZldobmRIc0g0VjdFUFlWek5ObkxlcWxOZUpvUkFqbmJ3d3NRTWhDR1N1?=
 =?utf-8?B?d2t6a3huaGlBTjR2bjQ4M09oVTY0RU1GZWNGdFNRTXRGWTJPc21jditjVVVQ?=
 =?utf-8?B?alRUSVVVdGc1R3JXZmJraWtkdTdyYlFxeXl6S2lWWUFPWFVJZkVna0tlZnVt?=
 =?utf-8?B?WTBiVlQyWXFBSnk2YWtlTXFEelU2a1hGS0V6SHN0SlBpc0M2RCt0NUNPNlJm?=
 =?utf-8?B?M3RXcy8yWktCNUkyaHlHOVYyRzRlZ1F6Sy9JWUJVQVFwQ1ZoaTd2aS92T1lv?=
 =?utf-8?B?a2NHODdoTWtmMlVqY1l3NCtlLzA4RmxFYW1mNHVrdmtZVVhWcDlXekJxNVFn?=
 =?utf-8?B?TmdnT2QydHBrTmVpVHVmZm9PNmxtdXppaERrTTVtanNMVHFiRjBoS3J0RlNp?=
 =?utf-8?B?N2s2OXJkNi9GZFgvanl2Y1VKVVgzd1N3QWNMeFVNRkgvK0RWdVNJQkdDSUJG?=
 =?utf-8?B?WWlWNVpIL2tJQ3B6Y29BdDEvNWxncThTRjRiR1pEVndCQmtDbnlUVlFlKzM3?=
 =?utf-8?B?WUUrZThXcXdGY2hWV1FkZEd3azhFV3A2ejZYaDZIUmduL3F4M0FYK0tnc2Jo?=
 =?utf-8?B?SHdJOUtPWW9lYWVxMWxKa2txcHZPcElmQUxYdUQ5bCtydnVOMi9Ld0xkVE9k?=
 =?utf-8?B?MzduK3ppcHNlWm9aNEEwazFDcDM1OW9oblFlMUxRTnJFNUJJK0VVRTBISkdN?=
 =?utf-8?B?d2JHdkRUQWVtaGVNd0VpSjQwREE3ZjBrcmxseG1DWVRYTEt2RGs2UDZaNy9N?=
 =?utf-8?B?Q2NDK00zMzhBRnNldmt2T3BNTVVlR2VNWjQyNnM5eFNGRjNjNktpQk1sdUN4?=
 =?utf-8?B?c0ZDUFlwSnRDdWpza0tjL1grWE16NTZkdlp0ZTlvU2p0Z0ZvUHhJUkkrMGJu?=
 =?utf-8?B?NzNWY3hheUNZNHFvbENZMWR3VldETmZSSnYxdVg1WU9RSCtFOXRTM3g5MkZM?=
 =?utf-8?B?WmJQRFhEVlliUnFkV0dzNWZOV2NRYkJGS3ByTndjZTVkYkxhSjFpdGRkdm92?=
 =?utf-8?B?QW95NWRhdzVpWkdRRnhtNnEvK0hJVFFXK3lSYmpmU0NhdnFJam5DR0QvTlI1?=
 =?utf-8?B?b3NsOUs0U1BsVEtvVTdkYm5EZmx2Q3g5MmFYSTdNRWU1blY0RnF1TUErbC9C?=
 =?utf-8?B?OHZGYlNMVWMxZnQ5MlI5TmJ3ajhEdjRjLzBjWERFQ1BtRjVpSnE5dncrY3NG?=
 =?utf-8?B?UzQza3pZMDk5Z1oyWkNLMnIxZDJIc3pIMnNsdTBMRUFpYkNwa0tmWC9janVl?=
 =?utf-8?B?TjRLL3R4bWxudG1IZFd3NjVIZ2F1SFR6Y056TGx6SlZvMEtsV2djUWxwcFE1?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hiQBUrNxwWeMKQf7M+j2Esmg2yTgOVGRMcluhl7IOKD/4vBCUF7tKOJsMOoYcwedqc2XI7ufgNE5zuvZhmHniUbDEbUJRbjUdAyHnvyDktyoGwP4GIsOTtl82gXhK9cV7nYN6E3U8EwS87ndC2uCxi6mWe2nJ1oWvrBBGSV4Wpd9Dg+2jRZX1phLv2huDAWsu4QBZPpCyGQ/CE1EmixXDjrnAMny2JlHAa8jSnBjkjBhHG0jmGhn4ermMqhXaV9Hf+uSp1dLOReNjcL2t4swUR8kT3qWadORMXwGzXtHGe0IKTePIF2xR8TScJs0eqAHIVEwGaE6TuusaRXb1PDBgdoYbcbJkC6+9XrBZ2V3jkQ84RYB2UoSVSgb637mzB4dxGRrxPbbcwPXeWmo2QoF18C69kuw73C6r6r754XHB1Rc8GPfxIHWtjzfftsuXFE+JVXj8ZkI1ZVP931KUy0vglJXtxRXXlH9DDVXKTQb31N4XXusFbYih7COX7JCeIYN7iI26uO2ZpwTQ+uJU/xkDF8shA0ES5CBm+i5pa/DBoR9xCOpLy+LnQ+6hHiaE1kWLTd3nlLe3kFfMqczm5L3SJE8aNyEptGznuSNK+Ob/3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e017ef-5d57-47f9-b787-08dd1ec8391a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 18:25:45.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9ygPLzaIMvhjiy2YBleXT50DSxAYFiaWyYAHXmY3TKGREFS2lHN01+vkYbsHMlh13V0RUEcOize4FSWvRVkCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_10,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412170140
X-Proofpoint-GUID: 7CXciR2KUADn58TbiAmHVGk0swmSVdSQ
X-Proofpoint-ORIG-GUID: 7CXciR2KUADn58TbiAmHVGk0swmSVdSQ

On 12/17/24 10:30 AM, Li Lingfeng wrote:
> Hi,
> after analysis, we think that this issue is not introduced by commit
> 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is protected by
> clp->cl_lock") but by commit 83e733161fde ("nfsd: avoid race after
> unhash_delegation_locked()").
> Therefore, kernel versions earlier than 6.9 do not involve this issue.

A more practical question is: has anyone reproduced the reported crash
on a pre-v6.9 kernel?

I recall (dimly) that we knew that 8dd91e8d31fe ("nfsd: fix race between
laundromat and free_stateid") could not be cleanly applied before v6.9.
It was less clear at the time whether a more extensive LTS backport
would be required.


> // normal case 1 -- free deleg by delegreturn
> 1) OP_DELEGRETURN
> nfsd4_delegreturn
>   nfsd4_lookup_stateid
>   destroy_delegation
>    destroy_unhashed_deleg
>     nfs4_unlock_deleg_lease
>      vfs_setlease // unlock
>   nfs4_put_stid // put last refcount
>    idr_remove // remove from cl_stateids
>    s->sc_free // free deleg
> 
> 2) OP_FREE_STATEID
> nfsd4_free_stateid
>   find_stateid_locked // can not find the deleg in cl_stateids
> 
> 
> // normal case 2 -- free deleg by laundromat
> nfs4_laundromat
>   state_expired
>   unhash_delegation_locked // set NFS4_REVOKED_DELEG_STID
>   list_add // add the deleg to reaplist
>   list_first_entry // get the deleg from reaplist
>   revoke_delegation
>    destroy_unhashed_deleg
>     nfs4_unlock_deleg_lease
>     nfs4_put_stid
> 
> 
> // abnormal case
> nfs4_laundromat
>   state_expired
>   unhash_delegation_locked
>    // set NFS4_REVOKED_DELEG_STID
>   list_add
>    // add the deleg to reaplist
>                                  1) OP_DELEGRETURN
>                                  nfsd4_delegreturn
>                                   nfsd4_lookup_stateid
> nfsd4_stid_check_stateid_generation
>                                    nfsd4_verify_open_stid
>                                     // check NFS4_REVOKED_DELEG_STID
>                                     // and return nfserr_deleg_revoked
>                                   // skip destroy_delegation
> 
>                                  2) OP_FREE_STATEID
>                                  nfsd4_free_stateid
>                                   // check NFS4_REVOKED_DELEG_STID
>                                   list_del_init
>                                    // remove deleg from reaplist
>                                   nfs4_put_stid
>                                    // free deleg
>   list_first_entry
>    // cant not get the deleg from reaplist
> 
> 
> Before commit 83e733161fde ("nfsd: avoid race after
> unhash_delegation_locked()"), nfs4_laundromat --> unhash_delegation_locked
> would not set NFS4_REVOKED_DELEG_STID for the deleg.
> So the description "it marks the delegation stid revoked" in the CVE fix
> patch does not hold true. And the OP_FREE_STATEID operation will not
> release the deleg.
> 
> Thanks.
> 
> 在 2024/11/6 1:10, Greg Kroah-Hartman 写道:
>> Description
>> ===========
>>
>> In the Linux kernel, the following vulnerability has been resolved:
>>
>> nfsd: fix race between laundromat and free_stateid
>>
>> There is a race between laundromat handling of revoked delegations
>> and a client sending free_stateid operation. Laundromat thread
>> finds that delegation has expired and needs to be revoked so it
>> marks the delegation stid revoked and it puts it on a reaper list
>> but then it unlock the state lock and the actual delegation revocation
>> happens without the lock. Once the stid is marked revoked a racing
>> free_stateid processing thread does the following (1) it calls
>> list_del_init() which removes it from the reaper list and (2) frees
>> the delegation stid structure. The laundromat thread ends up not
>> calling the revoke_delegation() function for this particular delegation
>> but that means it will no release the lock lease that exists on
>> the file.
>>
>> Now, a new open for this file comes in and ends up finding that
>> lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
>> up trying to derefence a freed delegation stateid. Leading to the
>> followint use-after-free KASAN warning:
>>
>> kernel: 
>> ==================================================================
>> kernel: BUG: KASAN: slab-use-after-free in 
>> nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
>> kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
>> kernel:
>> kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted 
>> 6.11.0-rc7+ #9
>> kernel: Hardware name: Apple Inc. Apple Virtualization Generic 
>> Platform, BIOS 2069.0.0.0.0 08/03/2024
>> kernel: Call trace:
>> kernel: dump_backtrace+0x98/0x120
>> kernel: show_stack+0x1c/0x30
>> kernel: dump_stack_lvl+0x80/0xe8
>> kernel: print_address_description.constprop.0+0x84/0x390
>> kernel: print_report+0xa4/0x268
>> kernel: kasan_report+0xb4/0xf8
>> kernel: __asan_report_load8_noabort+0x1c/0x28
>> kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
>> kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
>> kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
>> kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
>> kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
>> kernel: nfsd4_open+0xa08/0xe80 [nfsd]
>> kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
>> kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
>> kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
>> kernel: svc_process+0x3d4/0x7e0 [sunrpc]
>> kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
>> kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
>> kernel: nfsd+0x270/0x400 [nfsd]
>> kernel: kthread+0x288/0x310
>> kernel: ret_from_fork+0x10/0x20
>>
>> This patch proposes a fixed that's based on adding 2 new additional
>> stid's sc_status values that help coordinate between the laundromat
>> and other operations (nfsd4_free_stateid() and nfsd4_delegreturn()).
>>
>> First to make sure, that once the stid is marked revoked, it is not
>> removed by the nfsd4_free_stateid(), the laundromat take a reference
>> on the stateid. Then, coordinating whether the stid has been put
>> on the cl_revoked list or we are processing FREE_STATEID and need to
>> make sure to remove it from the list, each check that state and act
>> accordingly. If laundromat has added to the cl_revoke list before
>> the arrival of FREE_STATEID, then nfsd4_free_stateid() knows to remove
>> it from the list. If nfsd4_free_stateid() finds that operations arrived
>> before laundromat has placed it on cl_revoke list, it marks the state
>> freed and then laundromat will no longer add it to the list.
>>
>> Also, for nfsd4_delegreturn() when looking for the specified stid,
>> we need to access stid that are marked removed or freeable, it means
>> the laundromat has started processing it but hasn't finished and this
>> delegreturn needs to return nfserr_deleg_revoked and not
>> nfserr_bad_stateid. The latter will not trigger a FREE_STATEID and the
>> lack of it will leave this stid on the cl_revoked list indefinitely.
>>
>> The Linux kernel CVE team has assigned CVE-2024-50106 to this issue.
>>
>>
>> Affected and fixed versions
>> ===========================
>>
>>     Issue introduced in 3.17 with commit 2d4a532d385f and fixed in 
>> 6.11.6 with commit 967faa26f313
>>     Issue introduced in 3.17 with commit 2d4a532d385f and fixed in 
>> 6.12-rc5 with commit 8dd91e8d31fe
>>
>> Please see https://www.kernel.org for a full list of currently supported
>> kernel versions by the kernel community.
>>
>> Unaffected versions might change over time as fixes are backported to
>> older supported kernel versions.  The official CVE entry at
>>     https://cve.org/CVERecord/?id=CVE-2024-50106
>> will be updated if fixes are backported, please check that for the most
>> up to date information about this issue.
>>
>>
>> Affected files
>> ==============
>>
>> The file(s) affected by this issue are:
>>     fs/nfsd/nfs4state.c
>>     fs/nfsd/state.h
>>
>>
>> Mitigation
>> ==========
>>
>> The Linux kernel CVE team recommends that you update to the latest
>> stable kernel version for this, and many other bugfixes.  Individual
>> changes are never tested alone, but rather are part of a larger kernel
>> release.  Cherry-picking individual commits is not recommended or
>> supported by the Linux kernel community at all.  If however, updating to
>> the latest release is impossible, the individual changes to resolve this
>> issue can be found at these commits:
>>     https://git.kernel.org/stable/ 
>> c/967faa26f313a62e7bebc55d5b8122eaee43b929
>>     https://git.kernel.org/stable/ 
>> c/8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a


-- 
Chuck Lever

