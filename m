Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C83E86C2
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhHJXwz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 19:52:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31942 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235537AbhHJXwy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 19:52:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ANlNRR032350;
        Tue, 10 Aug 2021 23:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : from : to : references : subject : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=D4LAfYye4yrTX9I9Q5+F2w9dMmuqUZXbFtzn6BoXwm0=;
 b=VsoeEqWsQSuxbYeAujv2D0rebLcNyS3Ch3BX5iDprhKy/HFfMKCUg62aQr8wQdPeuf00
 mv3QLcVBuHU7tE7LyEUVjbcTf5IWHJxd6j09t1VY9NV4BoigLiXtJ2AUaN6+3fr4YU42
 t1n2k2I3pi/QamPjrMUhJdEulZ/5HBd9Y3lvgtuYb8vbuUk5jGqCtD+AUWQYozEh0AuR
 AZejzdflp5tPEAw8FcggZ4sl/D1szpSldCmDf+nmog4xCjZTYmsPnNwtTwsViVyZr5uy
 3tLMVIDVkbQ/123bMj1J6FMwgSTkKd+895XuZ30tHlV0sOpcy0PKckRQa2PeW2JH2krJ 1w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : from : to : references : subject : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=D4LAfYye4yrTX9I9Q5+F2w9dMmuqUZXbFtzn6BoXwm0=;
 b=sYFfqEHKSrKtFvIv9zdHihctZ/Q0W6uqxd2s0pdXQWXmBCXsBGkbYJjPufQIyF8CbEqk
 x5uaHtS/ZT1XCq/dxQKzn3ZwNzrWcr7jB7pE8K3M9PgSVhe5ZMXQ5Z7/30Z27VDbZPee
 Eg1uUG0rLfcs1T09AKDTNb+EQZu0+4zbS0fzdeVBMLBGS1fVHTSSV7qeEk2RlzG3I9PQ
 L671/TsJ408VZ04CbG90nWOgvLc2AZ8K/p/btGS4qP8THWgPXIiCaFXBvzZjn7voIlPF
 rf9DWjluqwuQtj20ZADIja8ExPO4IhFcfGkg3lHQwZS3Mp6xtIjOEEJnGw6JF2hEknWd zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17dvtad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 23:52:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17ANkOCw028228;
        Tue, 10 Aug 2021 23:52:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3a9vv5j4d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 23:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUvld92dgIwKB3XobMamC2Pkc2zeHo4Y4i4uV4zTSsl8eXvhO1CMB38hmZbmmtG2Tlex/03TmNyXdDlNLLRJ9KshgONrG4ovl4cGyoc35G2eMYgXqAlBnSYygvYhOLdQMjcdGplKGhQtablU9MRvWkoy2bw3MtUkGan2aLP/gcyFy5l0VDkvSllqs88ho3fxRpgnJ2/RbdHlC4xAdyWr0dXG9oviavZUDfcpLo99XGy7P8I0RVIHWtHiDYH4YgXIuLcUpTrradRrh3d8hR0do+ZRUORMvzL+sGRy6SEf51tfPRCC5eZw3vLAYKioBzqOoCffqI1lbDSYzFKZz/nVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4LAfYye4yrTX9I9Q5+F2w9dMmuqUZXbFtzn6BoXwm0=;
 b=BmmLpDfTSC+UB3O613wIAEb6lpdZIw6eDZu++qW7UecBwu6G/lQsPTfPMIto7As5wvv0RiC77xiESWX8RXsB5C6hHQchdHlxHqK2gC4hndRcTV2XiFjuFK33NImcQmo+zZnc6kXGfABM0LF+rXvmiSpJq0b5v2gQUMW2GcsWN8u0xOPb6dDAfJ/KXMiFENXv2eFUr80wHt/gOUxohxOQu37T7YKtyHbMoziCpDXHM/dMuaDDBp91fyRg//YQXYdCSrwIloJgPq40oFvnw6Py/8JWA5XChDD5+orkHXCTc9yi8UD7d2V75PPoI2IZPZt5NzdaAQ/fJDKXSnR/EUfQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4LAfYye4yrTX9I9Q5+F2w9dMmuqUZXbFtzn6BoXwm0=;
 b=dWNdfCSY9x7TmGLhobif7Lr1o9LGvfu78qOutRnB42B43kMymuNvs99PRI517plZHYvHZjhhTKBlYd4Yu1CDYhomy5jnUp2f+0WnI1eaqm8Ts1ZceGGr7GDYGBBntsm/joPcnlt7oPjqUSNOypvjUuPxF+lM3BHOYoSRWebinR0=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN0PR10MB4935.namprd10.prod.outlook.com (2603:10b6:408:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Tue, 10 Aug
 2021 23:52:27 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6%5]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 23:52:27 +0000
Message-ID: <4c1c058e-2b52-db5f-807b-b0dd9d6cb1a8@oracle.com>
Date:   Wed, 11 Aug 2021 00:52:21 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:92.0)
 Gecko/20100101 Thunderbird/92.0a1
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Language: en-GB
From:   Calum Mackay <calum.mackay@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
References: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
Organization: Oracle
Subject: =?UTF-8?Q?Re=3a_open=28O=5fTRUNC=29_not_updating_mtime_if_file_alre?=
 =?UTF-8?Q?ady_exists_and_size_doesn=27t_change_=e2=80=94_possible_POSIX_vio?=
 =?UTF-8?Q?lation=3f?=
In-Reply-To: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rdAtlZeXGow5dRmY0JRIvO4m"
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (84.71.130.115) by LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:138::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 23:52:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929fd65a-b297-45a1-e9a7-08d95c59e84e
X-MS-TrafficTypeDiagnostic: BN0PR10MB4935:
X-Microsoft-Antispam-PRVS: <BN0PR10MB49354FD4792618DC4145ADC3E7F79@BN0PR10MB4935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8L7YbC+nxwPbyVN3e5OeM7wPsK7Suv+CPXvMU0PXTQx3YGjFiLbXlTZVCyfSvXeZR3lBmFIB0I9N7xqffEaAHwt6kLfQ3jXPtd1hNleyeaNnJsI9Iwi34aoJ3snEvWXi2r62F6pSdcQgCx/G0hxZF4bIHwijsjsb8V9ecSHvGxQBuoQPewGbQk2PTQOCzfXdjDOnV2mnHEy9NFG/0jo6lURfEw5MKUnIBgS1P4W7Mp3aulW+asrBBMJy+UEn2zsmN5+zw2Rc0UeKrafNeevha3aBqgsnf8LuAQ/M1hUuIG/wFc1Jm6jAO7eGeCMsToxC5tPd5kizILO3M8WjCO8yA2Z1Wj5DCuqlQzi4h4XDRRCcqUbkkTwrVxStMlEVqpmEhVvYlqzXRKFeN4h0lKVYkK8lKK5K+1z92l2a+oxnEskua4W7rJm6aUIXpV7B4xn/ABf3zi3W4EAh1YC1D7oQnXXasUWq83zgVGTyIZ2T608pM0u8yce1L0rOFGSyQxJHp/4ZYdnkhFgL3JpC1SPMOwHhY5Rh9qLH87amiEg9sdYfY82asPJ/hCMPizb4EH3LP3ul6OtFL7h9hq7DP7bcyDCIO2bx1ohmrLwIOv/OThZpXlfYGk6uDaG6ToMflukEp02gdHtM7Cv56rFeSD3BBXRiEbv3IKv8FyPLYWaS1jCNIDIJT/XEhU70aCDXk1ZBauRp9sV5tWZZI6ikPN+B2gca2kPKzwL0Ac/ohay8TJUXNGtTaB3ZtqqrXmf8dKXGl+GoHM/Ok1vAsAcSSNnPHyTfHmuBISJjVwuK+wlc7e+67QqhrOLxFPYEB7Dme1KB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(36916002)(6486002)(2616005)(66556008)(66946007)(66476007)(53546011)(33964004)(235185007)(8936002)(16576012)(5660300002)(44832011)(31696002)(4326008)(956004)(2906002)(6916009)(86362001)(36756003)(21480400003)(186003)(6666004)(83380400001)(38100700002)(508600001)(26005)(966005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmErQTBON1FQRHdmVzZqLzVhdFc2U21xZ3AreVFSNzdzNWpIVklsaDlQRktU?=
 =?utf-8?B?a3VFQW9rUjhBbnEvd0dMdlpCVHI4L0czLzNQM01iNjl1NUlZNzlxT0RpenZ1?=
 =?utf-8?B?cnlpYlRQbTJOTkVZZVFWZXJ3cWRIQlZhNDNTQWs4amdIZFZ3K3p2bzVtREFO?=
 =?utf-8?B?bno0Y3BCbkR0ZXVzNXc2Z1c3Mno2b2kxQ0Q1ZzJHY3ZwTXpmbERicVdSZUZS?=
 =?utf-8?B?TWlVR24zRm9CeVJvall5cW9PbDJjaitNNDlWOTRqMEpmMC92QXBpV2E0cmg4?=
 =?utf-8?B?MEVDaUNUYmE2RHV0NVpyVzRMZHNIcXRPTnllOTlXNVF6T3FVb0Jwc3c1YURj?=
 =?utf-8?B?Z1FrbC9GSjZUaGpKMFg2eVJockExV1hBTXAvVDVHc1BrTmJkMFlLcmRFQmtZ?=
 =?utf-8?B?cFNMV2M3U0pYM2FVY0IzcFRzcFhZVmpHbllOdkZOS25WeGk0am9NZmo5QjRL?=
 =?utf-8?B?ZmFXL0FqODdKc1RCTm5TOUU5NENzRVM3ZjVnek5HQmVsMW1wVU9OTkk3UUF6?=
 =?utf-8?B?ZEFwK1NZWE5HM3ZOeDhQcnpQbEMvajBMdUpYOTRaQitXVEZkdGlpS1p3eWRD?=
 =?utf-8?B?cTAzaDJuRnVBQnRKbjRoazZGNENNZ1JTQStpcTI4NkRKTnNsZEVCQ3BxN3FF?=
 =?utf-8?B?aVFSNFlWUjBFOFBkUnBsRW4rZmh4UGxNUkFNN0xlS2FzMkVNTURuR3RIUEU1?=
 =?utf-8?B?bE9RdHdFdWR3SHBZSG9aOWFmamo5L0c1RUd5US9GTHJQdkFudTVqMGlFQ1Rh?=
 =?utf-8?B?TFhoa0JUM0RHZmk4amhkUklxOWNid29QUzZBZUVzRGtmOUtpWDZhbmdDK0Vx?=
 =?utf-8?B?STkvL1dYb3JyMEVOcWowWU5wTnNyNkpMT0FUNmpZVitKQ1BGMGUvSEdMM1k4?=
 =?utf-8?B?dFY5U1piUUpoeGVPM1hqdnE2WDFKdHNLd2dBYTRsQXFtTVp6L2QxMFBaRE9w?=
 =?utf-8?B?VjA2M0pPQWp2enNvM1lkWmgraVd6Q3prRVpGaXhpTUJna2N6UytqRk5weStN?=
 =?utf-8?B?MlhDNUVyTm9ocFUzUnNqOTRkaGdaYjAzbks3SzBEU0cwVXRCK3ZPdG81T1ZN?=
 =?utf-8?B?dnVlVVc1RFByUWxOUjZlUnZac1Y5WEE2SVV5SSsrNVVDcWRGKzlRdFh5TzF5?=
 =?utf-8?B?NllGRXR5OXpNaXBQMFdMblJVMTBxOGl6eUYxcENSYVJwczI3RHVGdmVGSVFX?=
 =?utf-8?B?NjNwT2dyRjZQb1hhZ2FQWnByOHFDaTBqdjFKSHo0SWJNd3BhK3MxRkpUVkZ1?=
 =?utf-8?B?QjE2NWgvMkxXaHhmdkdjdHZLYVMxVHhyU3Q2ZmJxMkQ1VmpQREpBaXFMcDFX?=
 =?utf-8?B?Z1pQRTFHaSsrMGNQWTh0NHNKd1BDWGdIUWtJdHNFTHRYa3h5VHU4NENvd2xp?=
 =?utf-8?B?ekxtVXJ4MkkrakRPdnFsVEg2SkthNEdmcHBHZ2tDbkI4QWp6ZGgwdmtBZ3lx?=
 =?utf-8?B?bDF6ZE1yNW9xZUVmTmZZeUU2RUFvL3FCcnZ6emk0OUVBWGk1cnJ3YWpLWXFv?=
 =?utf-8?B?dUxwSk1rbVBzZldJalRuMzM1Y0VPdVRBNXhWeUJUSXVXR0J2MEV1bTZ4TDZ5?=
 =?utf-8?B?d2JKRWF1bzJtTTFwaFh6NnNGeHN2OWZXQXJuRVNVemZkWU04RVRNd2ttalpx?=
 =?utf-8?B?UkJxV1hHODJmYnJ3TElBcXA3WXVueGdidk5uWjdERkZndG00bHkxN2Z5U0c4?=
 =?utf-8?B?N1RPTlR6SmRtWHRQQlpUTWlpWlFtOU5UOG84SVVrVmZhTTdVengyR04vWkhC?=
 =?utf-8?Q?OW80JCg4Cx6q7WnjVnGZYgzoyZsMQR53bNX4Okg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929fd65a-b297-45a1-e9a7-08d95c59e84e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 23:52:27.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1NXCmulw2fdVuwKMElOIPY+Txi1/Kh/SjKY8C78iJCV1gt6GUtTqlSAQ3qDod7eAeBNdX/6BhMvDcK5XiHKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4935
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100155
X-Proofpoint-GUID: 0_l0Lga0T5p7xQOrNPslDDN6vpKMvZsT
X-Proofpoint-ORIG-GUID: 0_l0Lga0T5p7xQOrNPslDDN6vpKMvZsT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------rdAtlZeXGow5dRmY0JRIvO4m
Content-Type: multipart/mixed; boundary="------------qFAN0zvTZp6LQ81Xm4fM0g9n";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <4c1c058e-2b52-db5f-807b-b0dd9d6cb1a8@oracle.com>
Subject: =?UTF-8?Q?Re=3a_open=28O=5fTRUNC=29_not_updating_mtime_if_file_alre?=
 =?UTF-8?Q?ady_exists_and_size_doesn=27t_change_=e2=80=94_possible_POSIX_vio?=
 =?UTF-8?Q?lation=3f?=
References: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
In-Reply-To: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>

--------------qFAN0zvTZp6LQ81Xm4fM0g9n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

YW5kIEkgZm9yZ290IHRvIGFkZOKApg0KDQpPbiAxMS8wOC8yMDIxIDEyOjM2IGFtLCBDYWx1
bSBNYWNrYXkgd3JvdGU6DQo+IGhpIFRyb25kLA0KPiANCj4gSSBoYWQgYSByZXBvcnQgdGhh
dCBiYXNoIHNoZWxsICJ0cnVuY2F0ZSIgcmVkaXJlY3Rpb24gd2FzIG5vdCB1cGRhdGluZyAN
Cj4gdGhlIG10aW1lIG9mIGEgZmlsZSwgaWYgdGhhdCBmaWxlIGFscmVhZHkgZXhpc3RlZCwg
YW5kIGl0cyBzaXplIHdhcyANCj4gYWxyZWFkeSB6ZXJvLg0KPiANCj4gVGhhdCdzIHRyaXZp
YWwgdG8gcmVwcm9kdWNlLCBoZXJlIG9uIHY1LjE0LXJjMywgTkZTdjQuMSBtb3VudDoNCj4g
DQo+ICMgZGF0ZTsgPiBmaWxlMQ0KPiBUdWUgMTAgQXVnIDE0OjQxOjA4IFBEVCAyMDIxDQo+
ICMgbHMgLWwgZmlsZTENCj4gLXJ3LXItLXItLSAxIHJvb3Qgcm9vdCAwIEF1ZyAxMCAxNDo0
MSBmaWxlMQ0KPiANCj4gIyBkYXRlOyA+IGZpbGUxDQo+IFR1ZSAxMCBBdWcgMTQ6NDM6MDYg
UERUIDIwMjENCj4gIyBscyAtbCBmaWxlMQ0KPiAtcnctci0tci0tIDEgcm9vdCByb290IDAg
QXVnIDEwIDE0OjQxIGZpbGUxDQo+IA0KPiANCj4gQW4gc3RyYWNlIChvZiB0aGUgc2Vjb25k
LCBhYm92ZSkgc2hvd3MgdGhhdCB0aGUgYmFzaCBzaGVsbCBpcyB1c2luZyANCj4gb3BlbihP
X1RSVU5DKToNCj4gDQo+IDEwNTgxIDE0OjUyOjM2Ljk2NTA0OCBvcGVuKCJmaWxlMSIsIE9f
V1JPTkxZfE9fQ1JFQVR8T19UUlVOQywgMDY2NikgPSAzDQo+IDwwLjAxMjEyND4NCj4gDQo+
IGFuZCBhIHBjYXAgc2hvd3MgdGhhdCB0aGUgY2xpZW50IGlzIHNlbmRpbmcgYW4gT1BFTihP
UEVONF9OT0NSRUFURSksIA0KPiB0aGVuIGEgQ0xPU0UsIGJ1dCBubyBTRVRBVFRSKHNpemU9
MCkuDQo+IA0KPiANCj4gSSB0aGluayB0aGlzIG1pZ2h0IGJlIGJlY2F1c2Ugb2YgdGhpcyBv
cHRpbWlzYXRpb24sIGluIHRoZSBpbm9kZSBzZXRhdHRyIA0KPiBvcCBuZnNfc2V0YXR0cigp
Og0KPiANCj4gIMKgwqDCoMKgaWYgKGF0dHItPmlhX3ZhbGlkICYgQVRUUl9TSVpFKSB7DQo+
IA0KPiAgwqDCoMKgwqDCoMKgwqAg4oCmDQo+IA0KPiAgwqDCoMKgwqDCoMKgwqAgaWYgKGF0
dHItPmlhX3NpemUgPT0gaV9zaXplX3JlYWQoaW5vZGUpKQ0KPiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhdHRyLT5pYV92YWxpZCAmPSB+QVRUUl9TSVpFOw0KPiAgwqDCoMKgwqB9DQo+
IA0KPiAgwqDCoMKgwqAvKiBPcHRpbWl6YXRpb246IGlmIHRoZSBlbmQgcmVzdWx0IGlzIG5v
IGNoYW5nZSwgZG9uJ3QgUlBDICovDQo+ICDCoMKgwqDCoGlmICgoKGF0dHItPmlhX3ZhbGlk
ICYgTkZTX1ZBTElEX0FUVFJTKSAmIH4oQVRUUl9GSUxFfEFUVFJfT1BFTikpIA0KPiA9PSAw
KQ0KPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+IA0KPiBhbmQsIGluZGVlZCwgdGhl
cmUgaXMgbm8gY2hhbmdlIGhlcmU6IHRoZSBmaWxlIGFscmVhZHkgZXhpc3RzLCBhbmQgaXRz
IA0KPiBzaXplIGRvZXNuJ3QgY2hhbmdlLg0KPiANCj4gSG93ZXZlciwgUE9TSVggc2F5cywg
Zm9yIG9wZW4oKToNCj4gDQo+PiBJZiBPX1RSVU5DIGlzIHNldCBhbmQgdGhlIGZpbGUgZGlk
IHByZXZpb3VzbHkgZXhpc3QsIHVwb24gc3VjY2Vzc2Z1bA0KPj4gY29tcGxldGlvbiwgb3Bl
bigpIHNoYWxsIG1hcmsgZm9yIHVwZGF0ZSB0aGUgbGFzdCBkYXRhIG1vZGlmaWNhdGlvbiBh
bmQNCj4+IGxhc3QgZmlsZSBzdGF0dXMgY2hhbmdlIHRpbWVzdGFtcHMgb2YgdGhlIGZpbGUu
DQo+IA0KPiBbaHR0cHM6Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25saW5lcHVicy85Njk5OTE5
Nzk5L2Z1bmN0aW9ucy9vcGVuLmh0bWxdDQo+IA0KPiB3aGljaCBzdWdnZXN0IHRoYXQgdGhp
cyBvcHRpbWlzYXRpb24gbWF5IG5vdCBiZSB2YWxpZCwgaW4gdGhpcyBjYXNlLg0KDQpUaGlz
IGhhcyBiZWVuIGRpc2N1c3NlZCBiZWZvcmUsIHdheSBiYWNrIGluIDIwMDY6DQoNCglodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1uZnMvNDQ4NUMzRkUuNTA3MDUwNEByZWRoYXQu
Y29tLw0KDQpidXQgaW4gcmVsYXRpb24gdG8gU3VTdjQzLCB3aGVyZSBhIHNpbWlsYXIgY2xh
dXNlIGRpZCBzZWVtIHRvIGluY2x1ZGUgDQoiaWYgYW5kIG9ubHkgaWYgdGhlIGZpbGUgc2l6
ZSBjaGFuZ2VzIiB3aGljaCBpc24ndCBpbiB0aGUgUE9TSVggSUVFRSBTdGQgDQoxMDAzLjEt
MjAxNyBJIHF1b3RlZCBhYm92ZS4NCg0KDQpTbywgSSB0YWtlIGl0IHRoYXQgdGhpcyBpcyBz
dGlsbCBpbnRlbnRpb25hbD8NCg0KdGhhbmtzLA0KY2FsdW0uDQoNCg0KPiANCj4gW3RoZXJl
J3MgYSBzaW1pbGFyIGlzc3VlIHBlcmhhcHMgZm9yIGZ0cnVuY2F0ZSgpIHdoZXJlIHRoZSBz
aXplIGRvZXNuJ3QgDQo+IGNoYW5nZV0NCj4gDQo+IA0KPiBJIGhhdmVuJ3QgeWV0IHdvcmtl
ZCBvdXQgd2hldGhlciBpbiB0aGlzIGNhc2UgaXQncyBkZWxpYmVyYXRlLCBidXQgbm90IA0K
PiBQT1NJWCBjb21wbGlhbnQsIG9yIGFjY2lkZW50YWwuDQo+IA0KPiBJJ2xsIGNvbnRpbnVl
IGxvb2tpbmcsIGFuZCBjb21lIHVwIHdpdGggYSBwYXRjaCBpZiBvbmUgaXMgbmVlZGVkLCBi
dXQgDQo+IHdvdWxkIGFwcHJlY2lhdGUgYW55IGNvbW1lbnRzPw0KPiANCj4gDQo+IHRoYW5r
cyB2ZXJ5IG11Y2gsDQo+IA0KPiBjaGVlcnMsDQo+IGNhbHVtLg0KPiANCg0KLS0gDQpDYWx1
bSBNYWNrYXkNCkxpbnV4IEtlcm5lbCBFbmdpbmVlcmluZw0KT3JhY2xlIExpbnV4IGFuZCBW
aXJ0dWFsaXNhdGlvbg0K

--------------qFAN0zvTZp6LQ81Xm4fM0g9n--

--------------rdAtlZeXGow5dRmY0JRIvO4m
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmETETUFAwAAAAAACgkQhSPvAG3BU+Ls
Wg/9H1HX/v8Sp8lUqU5tUGll494y4ikNrrjEw0ZnprpeZE8s0HrP+/Pzr6J3nE2EvQ4eGgSvMrJT
Y0VoAU5vZAcwGwiH+VJ5TPtjFzSst6HL6cWxmh13XA/aPnWq5bIrYY29zthhPvBaV9zMNoMfC+qW
bFEMpJTHeQmGQ15yrRs5u3V4hcfoqq3xPgZzNYHnLzOzvnJCK+nFV5/cjRiegY/CSTRJ8r04dofR
96CIsraPJNbD20+7Bcfa6kQ93ZoKBq4WnyjDjuvDARbgbLIQsPpqeoNhEmin65bgjZ2kZw8o8HAG
s4EZOMawJtzi8CplOSY+t0chBu236LtofebCmRrLRwYc1VhZrMf/SQDg+ak1KvdrHjIk1iAfiOby
ky0j9NOpXdEtMvxQcMnu3cmqF9UQsY4B/lo6yDMGIVOv8Xhk3YWg6s8fWUlHmvbL4ukb8ZesW8W6
D7S9fmx4DSlnBzP8TR2PalUCj7pgO53Q0rWZZTXliJux93WkBe57KUAHXIZJd7cHFKnVGb0QfGE1
Di3Mm+3EL6xPxe3HhvbWJqhnyEp1lFoC8IsGl5SUgkuVayvK+KnrB2uIDTPkfqugWCjq2kYfMAD8
z/BguZRG7SZ8lEPYoilMdcufduNPz1urUbSrFxvrRfwv3A6mbM7D7RA4Ny4PP+QMuWS+7Mlp9viU
oRs=
=X9fb
-----END PGP SIGNATURE-----

--------------rdAtlZeXGow5dRmY0JRIvO4m--
