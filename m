Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5579EE4A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjIMQdI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIMQdH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 12:33:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128019A7
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 09:33:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEpQ8S028846;
        Wed, 13 Sep 2023 16:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Jci4SprTiMviSmi+6zK0UY/c5npv5H0Le7hv1/D8cBc=;
 b=rm6NpTZxJhBjuBdz5T9FcxWvZPJXbrm3cHVrFdyClie0ZvOA4b+64csd2tdr7aNQi/p2
 h9gphuzOYAkvkMVDcm0w9dGqLt1smkpYpETt1ofaWvLeDANChGE+OXh4a6jxiIu06doH
 XdWoQ1vLKEFGVL7I4t1AnuNYFs7sPm93UBe8N16+LLxBCMSPV/WdtJs976ibqiwl0Csw
 ju9427PQwXGN2txG/BKPmvT5bZMjMzEGf+x3L5pGjLsS5vRQIvqGlPbOg7ekz2yS7LNn
 EzBTDSnHrcH+NbZC60vcdkAuiSF0iA430Xk3bbDf3bFvYNLRTeSYP9TSS5CwqVxGIhH1 Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kapck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 16:32:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DGWdtE007705;
        Wed, 13 Sep 2023 16:32:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f57gf3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 16:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2p2ge712Ol3ij08mw5bADBRoy3Rm8JVTbYw9S/4xIz1RmJ7aOoTfazcHXnRCLniFUK0FdTtaYhCr2ec/zgkxdum/BUymHBP01l0hc5HJPB4KHhDIJj5CTT4nJ34gBsscPq/ozWB4rqCn8SD3uQJJNMHTpqKGAyyIMagxj0omvJiN1oZD5doKL528XTtftlFee7Nf7SD8/NF423quxtH5cLpujXyFWhIdQL9OdwZXRcycoXfmF2TkpZGGCNrpCuIVub1meZ+/m5B/SCn3xdT7R0wIfXRoMclw7ADeta1+y9rN7lb0+SbwTdpWrUCL6qzG2rCMrOJVJIPO52ztiYxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jci4SprTiMviSmi+6zK0UY/c5npv5H0Le7hv1/D8cBc=;
 b=RNJMK/o6MJqGdv6zzAkB2rT34xHOAag4/iz5NDrY6tyOS+zmCaZSskRK9pRGUw4q034B8O0AKO38V7e43AdwCxVt27J5GGmTrBqUZMDkijknmpDGTYqCBR6OhJ+gzYLFp+b3cqzdjnMTn6oIoLy3yzntNwbmxsASpZw1Ny/Arn/X8RAQXIOSeOmXsTXDKqp/SCvgKk139Lc9uWBkVMb+SwufVMH3jlTWfIBvmA+0NwgmVXURGNO2pQRKN88Ecb+KZuYulVSeFHoggTcZihchQ2+AyC+MWyABJ4YKq/gZpeTC+2zQzTey4sNCGjWtr1ka2B+dNSX1JYn/jvOXUDyzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jci4SprTiMviSmi+6zK0UY/c5npv5H0Le7hv1/D8cBc=;
 b=miZL8HpzXa4PtJ8lKK56alGIyXIzJ3AKyzOOwTev6Z7cq+LYRtI+WmJudXoWC7ckuHNdsOjHpD5yHzmHclWd/tu7GDtiuz1qjjYRrhwtGFkf1aHYKaY9J2xwocMEtBxCePPT4S345We+WckJHkCFxt8F13ag5Nx9YxJeWkQ7oA4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by IA1PR10MB7310.namprd10.prod.outlook.com (2603:10b6:208:3ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 13 Sep
 2023 16:32:56 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::1ae9:73e8:fe48:3fcf]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::1ae9:73e8:fe48:3fcf%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 16:32:56 +0000
Message-ID: <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
Date:   Wed, 13 Sep 2023 17:32:49 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Stop using deprecated thread.setDaemon
Content-Language: en-GB
To:     Alexander Zeijlon <alexander.zeijlon@cendio.se>,
        bfields@fieldses.org
References: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FkU4vuQYul01PymDsl3wDQQ0"
X-ClientProxiedBy: AS4P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::17) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|IA1PR10MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 098413d6-3af2-4314-95ed-08dbb4771561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McCPtN3RA2zPdhIcXILwL2/7E0dU0+g5YteYNhFNOHEHVLmZ92I41qEWpctnosGxaZ78ouNeBF5AeBqDwONiYr6PNNs0go91aJ3x/Ce4KDNhIClwzdeotxmUbfq6olEk0TEgxLqWOLf1pqtFV2Yo0zG0b2dXMhaMxdQenkKSYA8ciJDReJ/aJ8+yKrkaMMSVx7agebMk23MWd9TMCBk49sTTbukjfJWnz8T3DkFsHFHRymlD3kSfKPWsdO7M3TeiZMCjosFIRjpSMFvcmmmdSyiMVdkr9EKh6vaY6YrVLzF92OswJ1Nv39vNrfooVnpN5QdgZCyex9qQazW9jHK853eCYPLAmMlQEnrf8w0VjvhnZ77NuC8v2SCSYtmJwon1cuxbRTAmAU3o8XTkMJMP2nYBTnBmppS3e4noh3uZbV2yx/gBHwSJqBkqp6eXH9srALVkE1t+BwraP1WYGS0C+AmF71Dyy1Jy6EuSocRj3l6vh+0WkZ/tK3msiRsju316n/nVpZVf/7dOWUm6XzoBOT1B9KZgv/KLoJaaRRDPaFDhfZhvrbNafdlaHDJL7hkVzWWpHLc2K89k91vszPxk8/1loOD4cd6+ocFZ5dQyIoNML57HBf6Sx+wG7ifmEDCIsRdB+/r70jBQJSswhfR/fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199024)(1800799009)(186009)(38100700002)(36756003)(31696002)(86362001)(31686004)(6486002)(6506007)(5660300002)(66946007)(478600001)(36916002)(53546011)(33964004)(8676002)(6666004)(66476007)(8936002)(66556008)(44832011)(2906002)(4326008)(6512007)(21480400003)(83380400001)(235185007)(41300700001)(316002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUFQakNBWnFTQkRoYUczbmxsTVVwZmRwbnNadG9vNEU1bVROQW5VMXRGdGpv?=
 =?utf-8?B?SmlRL3FzNVFIaFczZm1xam1tQU1XSjJvZjNOTHUvMVh5ZTdmQk52T01SMElL?=
 =?utf-8?B?OHpxVzcrUFdQRWd6M3dkRU1sdmhvbG9zM0RpYTBOZmd0SXpDeStzTmlicmUy?=
 =?utf-8?B?SmUyQ0lvQmVXRXJIQTUybEhOamNWMk9lT1BPQkhhMGxDTURWVUJqN2xCdERR?=
 =?utf-8?B?NnJORUFKTkd1UW4rdEs1aStQZTlGM1ZPS1hDU2dGdVVMRmxZdVAzTHVqYnFZ?=
 =?utf-8?B?ZVFEWXlrSWFlcGZ1VjF5L0FnSjF2bkpVVGQ1emdVWEJVMFlGc2JZTDRuYVRs?=
 =?utf-8?B?N1pNejdqeElCcFJaNTJQeTIrNEs3VHdTMUl4Z3ZjaTR0dlcxaWkxK1JGem1R?=
 =?utf-8?B?YncxZzNaKy9RWDdHTkw0WnNqYk5CNUcvdDR4bzlkRVZHL3MwRGpncXg4WkVu?=
 =?utf-8?B?ZCtEUE9mWDdhVmxuMnRIcDlIbzBOR3ZTV0RXdmwwZ09FSkZTaS9ObXM0L012?=
 =?utf-8?B?ME9hQ3cxNWlWVDh6YlU4ZytsVlc0WmhiejcyRG5ocTZhdEhJNGlUc1B5eHpO?=
 =?utf-8?B?YWpJVjlpTXEvSGVTb1p0SUlIVWRxYnM5aThyUzZScWo0djc0Q3B5cWZjSmlP?=
 =?utf-8?B?eXlTdE02dVFhYWc2WG9BV0h3ZFhzMmJBZFFoUFNJN0JlMEFUeWZIQVZ2ajd4?=
 =?utf-8?B?UC90ckcxL3dyY1VQelEydTlxUnZnVDl4NFJ1RjBNRmVQT0ZtWHBDZ0puN29W?=
 =?utf-8?B?MHVJbzZZc3VZYkZlUEo4NWJDQ2d2ZzBUSTFYRlVNZVBZaEtwNFp6dUJpUFVR?=
 =?utf-8?B?M3ZPQ2hyU3RTQlZRWGhRdTM2QnU2K2VYcDFpVDBIc2hPcWJIWkh2RTJOUWs0?=
 =?utf-8?B?TktjRlM4UW5hMHEvMzkzc0FxbWN1WVUxK1B4b21LV0pIcUduN1BCZGNsS043?=
 =?utf-8?B?MENhVkRpZDRaUy9MVGVtR2FHbmhYOTR6RXo0dnZRcVB5ZldpTlNWSGZzV1ZX?=
 =?utf-8?B?Z0diaE03MVBZdmhUVVl4NWR0N0VtT2ZhVlVqKzNnbnlEemdBZE5CMWpWVmFX?=
 =?utf-8?B?QkppdVZjSjJZdE5VeDZPTFZJYU9TY2hLQTBTRXE2UHlZVzBnNnhzcnlPNldS?=
 =?utf-8?B?bERrQ2ZFYlRGZlVSN1Q2blptRUFxSFBubjlFcG50TmZlVjdwNGtEVUFxZE0y?=
 =?utf-8?B?M3U4UTN2TzNxRGxCcG5SaVFHRCt4ZmUrKzJpU1FIdVJraVA3aWloL1pYZGpi?=
 =?utf-8?B?VEdWR04vK3BQN0FIb3AzbjJranVFZFh6dGI2T0FicWphVUh4M2FPRkg1c1J0?=
 =?utf-8?B?YUhwNFd3eDk1OEpzTEgvZ3NwWjFGRlNsY3J4dHJCanI3ZHkreDZQT1pqVG14?=
 =?utf-8?B?M1QvVmZGdVBCQm5ML2k4Vk1MbkNNaXRIc2w0THZMcUwzejlFWTdGRHFVd0dN?=
 =?utf-8?B?NFlhM3pETHdEWnF3eDQyMkhYM1U4WHdTOVQ5VUlYRDVEY3V4R3U4dkgwWnBE?=
 =?utf-8?B?QmJjNlgxQ0NBbUhWdUNRMzBmWHdOeHV5Zk5HVkw3alRiSkVSTXJPclh4RC9h?=
 =?utf-8?B?cmhqeGZHSVVNdWtZeC9uOWxOajJqeGVsMUR5TnRlZTBBZXF2ZGk3ZXQ5ZFNh?=
 =?utf-8?B?QXVVbUVxVDloYlg5amJmelZnU1ZTWEl6ZlFVZWRmS20vdnhvbXZpdjYwek1z?=
 =?utf-8?B?emxiN2pYOXhQVUNzZVNkOVZLSytUR21DODhSUU54c1pRQnBpMWZSSUZSQWlj?=
 =?utf-8?B?ZGFuMDE1QWhrVTNHczVraUNLVFpFenpPMnQ0QVhSQkpVdnl1NzFHQ3pDcSts?=
 =?utf-8?B?djJiN2RQb09KYVRnZXBYUEdySEx5UjlLZlNuYW1KTFlLcmVhWEJkd3VzM0hX?=
 =?utf-8?B?ak1acHVzNDZXNUNyc3hzSnBzMzN6Zm5PU05FZUthR24yaVhGRy9UZ3dtSTBY?=
 =?utf-8?B?dFVYaHlWWFBlN3dWMExpWCttTEpiTXdHS21NMkh3UmE5NkxPUUluTjIvZ3pt?=
 =?utf-8?B?U1hYTzdaUk9iVnhPQUxZZGE4QXFndVJtY0RueGNqR3pmZ2I1TXZ6SGtVS2hs?=
 =?utf-8?B?MGZaS2RGa2Jzcy91UDEzSThZOXIvK0R2UTlqNjF0SE13WDA2ckx0RWoxQ0Ju?=
 =?utf-8?B?QXdUZHgxeXZyRWIxTTBaL3JQZ2NoWFdrZk9NZ2tiVWtsZW93VWVsUE1aUmZE?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ARVltJoiulALNF2n0/8TTEuz9NGF+tJkFNu7p8i00aEMtguLEhjYiYkDQLtmNYkx7fbVHM/B/nMyFpyCTODiMPLau+gE/49OuUhVSyYwXwbCUxGQL98aY284PGmtD3okljtrYnQcSfkusPss09s19JKs9j+Y0aSGIAkX6ZW+Bj3NkwKFqQQuxI/BYpCPxySp8hrMSLjgEFb4420tKAFCjUvZirWdhVIEgj8Jx2GuucogOaeWga/mHP43uzbOXhesH6zGZhHTime5SQop+eh2/d0Ruh9nDVT15mXlfpNNo1Wck25u0wUqGR8yI09hIA9thEXFtaUBERCyD3X/f5BDGvTkhpy6KWSkGbuJM02/zC6ahVMpWZr6NDqEXEujH5R0+mKEKOstJ2+nFnIYV588xa+oGS3b184MFqvw6PNZwAPWfic9/ZjHaAy8++B3Dy9OTnEU3FdjPDO6Te1r0ZqQAOSRL7aO0PQ4bwv49HIflHgNgEhI30xP+4qX3yJ0qOLSMe7z1K7ZLGfLpjrZwHHGC8GjGbF6/LO5QaZ9OItDsbqLy0uXph8bd5/iTn22HPYk8jGxcuaLHEuAjXcPzJ9EykMFinn2XD+SOXqG151AKvko2uuEF/+voIX64v1zMAn0Wap1nWBVvVKP2NQSibcsdioHL2x8JmhvTq96LKt57DcN6zTSbJoQOKh+HnOO70l9CVqSKOoYbdNO38JS4YgQRlbzP1z2BN45sxKL8Pb4Iw92h4UQTqo47m3LJO+gDsuWmx7QHg6Uep2SGFjgQ8NLWSgKWKjWym7DihPrbcVP/4dGYBoG0diU140qJncqhgmX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098413d6-3af2-4314-95ed-08dbb4771561
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:32:55.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqjmK/cTn1oQQb8HemeR0NtUjy/f15t9+MkDcyhDipJ57jyB1y7+qGmEjaeP5D4VD+MaaA7ok4XYGhLivQDAzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_10,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130137
X-Proofpoint-GUID: FIIwxEn4iukYF2FK9Wr_Hn6zRuqCUfSc
X-Proofpoint-ORIG-GUID: FIIwxEn4iukYF2FK9Wr_Hn6zRuqCUfSc
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------FkU4vuQYul01PymDsl3wDQQ0
Content-Type: multipart/mixed; boundary="------------9yhC0e4nz0nTXgJFelaAOJVV";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Alexander Zeijlon <alexander.zeijlon@cendio.se>, bfields@fieldses.org
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Message-ID: <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
Subject: Re: [PATCH] Stop using deprecated thread.setDaemon
References: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
In-Reply-To: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>

--------------9yhC0e4nz0nTXgJFelaAOJVV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMvMDkvMjAyMyAxMTo0NiBhbSwgQWxleGFuZGVyIFplaWpsb24gd3JvdGU6DQo+IFRo
ZSB0aHJlYWQuc2V0RGFlbW9uIG1ldGhvZCBpcyBkZXByZWNhdGVkIHNpbmNlIFB5dGhvbiB2
ZXJzaW9uIDMuMTAsIHRoZQ0KPiBkYWVtb24gcHJvcGVydHkgc2hvdWxkIG5vdyBiZSBzZXQg
ZGlyZWN0bHkuDQoNClRoYW5rcyBBbGV4YW5kZXIsIEknbGwgYWRkIHRoaXMgdG8gbXkgbGlz
dC4NCg0KY2hlZXJzLA0KY2FsdW0uDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRl
ciBaZWlqbG9uIDxhbGV4YW5kZXIuemVpamxvbkBjZW5kaW8uc2U+DQo+IC0tLQ0KPiAgIG5m
czQuMC9uZnM0bGliLnB5ICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgIG5mczQuMC9z
ZXJ2ZXJ0ZXN0cy9zdF9kZWxlZ2F0aW9uLnB5IHwgNCArKy0tDQo+ICAgbmZzNC4xL25mczRz
dGF0ZS5weSAgICAgICAgICAgICAgICAgfCAyICstDQo+ICAgcnBjL3JwYy5weSAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCA0ICsrLS0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZnM0LjAv
bmZzNGxpYi5weSBiL25mczQuMC9uZnM0bGliLnB5DQo+IGluZGV4IDliMDc0ZjAuLjlhNzJl
YzkgMTAwNjQ0DQo+IC0tLSBhL25mczQuMC9uZnM0bGliLnB5DQo+ICsrKyBiL25mczQuMC9u
ZnM0bGliLnB5DQo+IEBAIC0yOTcsNyArMjk3LDcgQEAgY2xhc3MgTkZTNENsaWVudChycGMu
UlBDQ2xpZW50KToNCj4gICAgICAgICAgICMgU3RhcnQgdXAgY2FsbGJhY2sgc2VydmVyIGFz
c29jaWF0ZWQgd2l0aCB0aGlzIGNsaWVudA0KPiAgICAgICAgICAgc2VsZi5jYl9zZXJ2ZXIg
PSBDQlNlcnZlcihzZWxmKQ0KPiAgICAgICAgICAgc2VsZi50aHJlYWQgPSB0aHJlYWRpbmcu
VGhyZWFkKHRhcmdldD1zZWxmLmNiX3NlcnZlci5ydW4sIG5hbWU9bmFtZSkNCj4gLSAgICAg
ICAgc2VsZi50aHJlYWQuc2V0RGFlbW9uKFRydWUpDQo+ICsgICAgICAgIHNlbGYudGhyZWFk
LmRhZW1vbiA9IFRydWUNCj4gICAgICAgICAgIHNlbGYudGhyZWFkLnN0YXJ0KCkNCj4gICAg
ICAgICAgICMgRXN0YWJsaXNoIGNhbGxiYWNrIGNvbnRyb2wgc29ja2V0DQo+ICAgICAgICAg
ICBzZWxmLmNiX2NvbnRyb2wgPSBzb2NrZXQuc29ja2V0KHNvY2tldC5BRl9JTkVULCBzb2Nr
ZXQuU09DS19TVFJFQU0pDQo+IGRpZmYgLS1naXQgYS9uZnM0LjAvc2VydmVydGVzdHMvc3Rf
ZGVsZWdhdGlvbi5weSBiL25mczQuMC9zZXJ2ZXJ0ZXN0cy9zdF9kZWxlZ2F0aW9uLnB5DQo+
IGluZGV4IGJhNDljZjkuLmJjYzc2OGEgMTAwNjQ0DQo+IC0tLSBhL25mczQuMC9zZXJ2ZXJ0
ZXN0cy9zdF9kZWxlZ2F0aW9uLnB5DQo+ICsrKyBiL25mczQuMC9zZXJ2ZXJ0ZXN0cy9zdF9k
ZWxlZ2F0aW9uLnB5DQo+IEBAIC00MCw3ICs0MCw3IEBAIGRlZiBfcmVjYWxsKGMsIHRoaXNv
cCwgY2JpZCk6DQo+ICAgICAgIGlmIHJlcyBpcyBub3QgTm9uZSBhbmQgcmVzLnN0YXR1cyAh
PSBORlM0X09LOg0KPiAgICAgICAgICAgdF9lcnJvciA9IF9oYW5kbGVfZXJyb3IoYywgcmVz
LCBvcHMpDQo+ICAgICAgICAgICB0ID0gdGhyZWFkaW5nLlRocmVhZCh0YXJnZXQ9dF9lcnJv
ci5ydW4pDQo+IC0gICAgICAgIHQuc2V0RGFlbW9uKDEpDQo+ICsgICAgICAgIHQuZGFlbW9u
ID0gVHJ1ZQ0KPiAgICAgICAgICAgdC5zdGFydCgpDQo+ICAgICAgIHJldHVybiByZXMNCj4g
ICANCj4gQEAgLTQwOSw3ICs0MDksNyBAQCBkZWYgdGVzdENoYW5nZURlbGVnKHQsIGVudiwg
ZnVuY3Q9X3JlY2FsbCk6DQo+ICAgICAgIG5ld19zZXJ2ZXIgPSBDQlNlcnZlcihjKQ0KPiAg
ICAgICBuZXdfc2VydmVyLnNldF9jYl9yZWNhbGwoYy5jYmlkLCBmdW5jdCwgTkZTNF9PSyk7
DQo+ICAgICAgIGNiX3RocmVhZCA9IHRocmVhZGluZy5UaHJlYWQodGFyZ2V0PW5ld19zZXJ2
ZXIucnVuKQ0KPiAtICAgIGNiX3RocmVhZC5zZXREYWVtb24oMSkNCj4gKyAgICBjYl90aHJl
YWQuZGFlbW9uID0gVHJ1ZQ0KPiAgICAgICBjYl90aHJlYWQuc3RhcnQoKQ0KPiAgICAgICBj
LmNiX3NlcnZlciA9IG5ld19zZXJ2ZXINCj4gICAgICAgZW52LnNsZWVwKDMpDQo+IGRpZmYg
LS1naXQgYS9uZnM0LjEvbmZzNHN0YXRlLnB5IGIvbmZzNC4xL25mczRzdGF0ZS5weQ0KPiBp
bmRleCBlNTdiOTBhLi42YjRjYzgxIDEwMDY0NA0KPiAtLS0gYS9uZnM0LjEvbmZzNHN0YXRl
LnB5DQo+ICsrKyBiL25mczQuMS9uZnM0c3RhdGUucHkNCj4gQEAgLTMwOCw3ICszMDgsNyBA
QCBjbGFzcyBEZWxlZ1N0YXRlKEZpbGVTdGF0ZVR5cGVkKToNCj4gICAgICAgICAgICAgICAg
ICAgZS5zdGF0dXMgPSBDQl9JTklUDQo+ICAgICAgICAgICAgICAgICAgIHQgPSB0aHJlYWRp
bmcuVGhyZWFkKHRhcmdldD1lLmluaXRpYXRlX3JlY2FsbCwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYXJncz0oZGlzcGF0Y2hlciwpKQ0KPiAtICAgICAg
ICAgICAgICAgIHQuc2V0RGFlbW9uKFRydWUpDQo+ICsgICAgICAgICAgICAgICAgdC5kYWVt
b24gPSBUcnVlDQo+ICAgICAgICAgICAgICAgICAgIHQuc3RhcnQoKQ0KPiAgICAgICAgICAg
IyBXZSBuZWVkIHRvIHJlbGVhc2UgdGhlIGxvY2sgc28gdGhhdCBkZWxlZ2F0aW9ucyBjYW4g
YmUgcmVjYWxsZWQsDQo+ICAgICAgICAgICAjIHdoaWNoIGNhbiBpbnZvbHZlIG9wZXJhdGlv
bnMgbGlrZSBXUklURSwgTE9DSywgT1BFTiwgZXRjLA0KPiBkaWZmIC0tZ2l0IGEvcnBjL3Jw
Yy5weSBiL3JwYy9ycGMucHkNCj4gaW5kZXggMWZlMjg1YS4uMzYyMWM4ZSAxMDA2NDQNCj4g
LS0tIGEvcnBjL3JwYy5weQ0KPiArKysgYi9ycGMvcnBjLnB5DQo+IEBAIC01OTgsNyArNTk4
LDcgQEAgY2xhc3MgQ29ubmVjdGlvbkhhbmRsZXIob2JqZWN0KToNCj4gICAgICAgICAgICAg
ICBsb2dfcC5sb2coNSwgIlJlY2VpdmVkIHJlY29yZCBmcm9tICVpIiAlIGZkKQ0KPiAgICAg
ICAgICAgICAgIGxvZ19wLmxvZygyLCByZXByKHIpKQ0KPiAgICAgICAgICAgICAgIHQgPSB0
aHJlYWRpbmcuVGhyZWFkKHRhcmdldD1zZWxmLl9ldmVudF9ycGNfcmVjb3JkLCBhcmdzPShy
LCBzKSkNCj4gLSAgICAgICAgICAgIHQuc2V0RGFlbW9uKFRydWUpDQo+ICsgICAgICAgICAg
ICB0LmRhZW1vbiA9IFRydWUNCj4gICAgICAgICAgICAgICB0LnN0YXJ0KCkNCj4gICANCj4g
ICAgICAgZGVmIF9ldmVudF9ycGNfcmVjb3JkKHNlbGYsIHJlY29yZCwgcGlwZSk6DQo+IEBA
IC05MzUsNyArOTM1LDcgQEAgY2xhc3MgQ2xpZW50KENvbm5lY3Rpb25IYW5kbGVyKToNCj4g
ICANCj4gICAgICAgICAgICMgU3RhcnQgcG9sbGluZw0KPiAgICAgICAgICAgdCA9IHRocmVh
ZGluZy5UaHJlYWQodGFyZ2V0PXNlbGYuc3RhcnQsIG5hbWU9IlBvbGxpbmdUaHJlYWQiKQ0K
PiAtICAgICAgICB0LnNldERhZW1vbihUcnVlKQ0KPiArICAgICAgICB0LmRhZW1vbiA9IFRy
dWUNCj4gICAgICAgICAgIHQuc3RhcnQoKQ0KPiAgIA0KPiAgICAgICBkZWYgc2VuZF9jYWxs
KHNlbGYsIHBpcGUsIHByb2NlZHVyZSwgZGF0YT1iJycsIGNyZWRpbmZvPU5vbmUsDQoNCi0t
IA0KQ2FsdW0gTWFja2F5DQpMaW51eCBLZXJuZWwgRW5naW5lZXJpbmcNCk9yYWNsZSBMaW51
eCBhbmQgVmlydHVhbGlzYXRpb24NCg0KDQo=

--------------9yhC0e4nz0nTXgJFelaAOJVV--

--------------FkU4vuQYul01PymDsl3wDQQ0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmUB5DEFAwAAAAAACgkQhSPvAG3BU+LE
bQ//aoadKz1RwZWZE7uL8SptYscCjBagmu0nDk7wBqutE4DV8tePD7Hsc+uEbQm8aUwnLTLzF2/q
ANZsmtYYa8TQaQ6WXaqX2t4Hf1Ke6NlT+3ojCNdTJdnS7LTNucsPXCyCw7jXQIvVRFGYyenTJuda
DOmY1803AYNnme5X+wY5S/5apPJnGBitFO/e/T6W+34OwTYp0yejPBTQOUZzvBnC+XaV8jRFWWli
wja83W9mG5+D2/ssiOj7R2EQt/uTPX7o0tEMEJCH+lSB3glLHWTIj8THmK5c5auI2geYm3IZyLza
pyF9K8UXOHGZw2fix0JH93fbrIXQnN04gT7InqnrUMkIeQkmanGSUYjhgeuhTQKGEijt7qx0U5vP
38KQ4+qRPyM7zIe4zVUwgsyQ73MzL/M2hBAEv4PcUkmUHIBDMynlL1TqS7gvcaBSnSZw0L8y20ph
tH8q1Q3IU5MdOwIyWCMwcHc6szpT22fdPiwidIpETOWKY2F814S94lM0ZT1KU70JlO9bHyY/SCqQ
T+FDB7K0ZOfN3PlyR/9Ub5nWLeuGcz7tFY3dWecmaTGOauv/ls9PW98dLQZrf/hQscQT6S+/9W8I
6xeaKQmBdzYDPUXM+AkT6hOV/jSUm/8+DvFN82Yr+/zqL+JU+x5QWmnYXHinVCWya8mpDvXwjbGk
pRA=
=Iwgr
-----END PGP SIGNATURE-----

--------------FkU4vuQYul01PymDsl3wDQQ0--
