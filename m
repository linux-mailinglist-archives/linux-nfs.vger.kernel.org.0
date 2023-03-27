Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A136CA9F1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Mar 2023 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjC0QF2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjC0QFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 12:05:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B2F4489
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 09:05:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RFxWVL013386;
        Mon, 27 Mar 2023 16:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8i0+8G4MhGNkma0dQUmyselc+sOdNhK2kuo/wQJxfuw=;
 b=K9bWvwPxWwfH8V2fiRf0odP04FYlFfe8icSz4mpJWrDzA5cATsO3AnwDjfBFbErGfrnR
 1M6xb0Q/tctkiTrRPcRyCZxxsxLxJn7em5HjnxqksRu6DD33G66ehFrBx+WknyKt2rUy
 oto26GdECg6vuFDjvG6Ht4I6PCkXap+Cg4faGdCz9+SPACMuRvUj478lpV/HPY3m1qzO
 fhuXojOzMENbwZsiNGhvzB98u5tnWDQlo/UIfnLKnQ8Pqxy64JEEhh5jkmcm7WwciXtu
 9i3ZbVGKJmzm+pTu83coETVVlUKPvOHz1XbX3K8MvQSRT3z0TUE5GWvbWjeDY9hKvI6f kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pke91r0gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 16:05:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RFLlHe005369;
        Mon, 27 Mar 2023 16:05:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd53s3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 16:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1T0A4wveRSr1r2hz6SJKFPmePLzVrLV2dRmqd0xNxQKDYITOfOMZ/HlcJBc5g9mWLonuqGlFe7F2DgHAIEbzbsxWmvD97sun2q7baKMqzfWRjf+PHG1vrW3HPh6guVQ4E+h7UZVvq5FjkHvCzJSiP8aR978JyWiShn+VszUSsdiM2dKDEHp9WojIomNINdmFLjCse9OMYZWgEySEfKDkF5Jpt7DGes7WyHw2jD4aFC/pWNouvai5WTrTVspHvJnp2Roi2AeehUKlhKppBuDuA5aTZZRu9x+Vz61TzrMpbnfUb/q5igyXWaDm8CgNiSThL9fIhlUE6lw4LPlE6OgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i0+8G4MhGNkma0dQUmyselc+sOdNhK2kuo/wQJxfuw=;
 b=BZwUEB7Lmhj/Knk6TBwZ9LNitaILdQhZ/XjhmCh8XEQKRO1EkJNtUkU2G/X+zyH+csOfGLj1DHIWMTarUhVbbAqCa//aj5o/YJjYPYIWyngVE8KHYlHVWszTpzKVHXQ/gdhr7/LO4m5dvhjs2gSju6EPRHcVi618sWd9pdL8eRsJNmlD4DlcTs2rpfSUinDOngt1f6N3fBYHGc4QyLOiH7iUNanzvfRGzCa8IKg+p/AqzsQD2ORYzRipfuRnLinxQmImUMChYKz5kGWBs4ayW2gCI4LZUyy2H10mdrusNYoDIHEzyrKQUUKRcn8OroZWZx0MNno810XOrCndsupqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i0+8G4MhGNkma0dQUmyselc+sOdNhK2kuo/wQJxfuw=;
 b=cvHrW5nd+4jatxDxrRVA691gvWoAblu9LrmGsXl2DmPwXbfyNuoWwINNQe9aYHhzaelJ2jmI1B5hHwTWCZU6O1H6TYzww+rvbwbYcGx9B0y0JRa7b/yVNdvs/UhMbOcDR+X7l/uKg0rTTwTyRTZpjMFC0XKgVxRmwapgqV7HQvQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH3PR10MB7678.namprd10.prod.outlook.com (2603:10b6:610:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 16:05:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::82d2:a5f:8f53:813]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::82d2:a5f:8f53:813%5]) with mapi id 15.20.6222.032; Mon, 27 Mar 2023
 16:05:11 +0000
Message-ID: <69b9c20a-a173-a878-fa7f-63f9c0a97375@oracle.com>
Date:   Mon, 27 Mar 2023 09:05:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Fwd: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Helen Chao <helen.chao@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
 <ACE2DBA2-0F3D-47EF-9167-9D45F5BE57E5@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <ACE2DBA2-0F3D-47EF-9167-9D45F5BE57E5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH3PR10MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2191df-1222-43a4-f644-08db2edd0b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNCv8ODBJS4cwhDqAlkqxv/pqUyZdlGlhqbcJ3bbvEoQGNM9+82KQqvBxOx32SX0MoZptgCVO+lQFMhugZ7SeT0RPWnG7awyd3lmuQbSsDef7poVTtmIYa2gd2Q20oVcf6nfg2m22p6TKjcrZejQfdXxTDu/7KivJPC9AxAf8XJLM6538hOqWLwpn1do8AB0cJ8rhY5QpWxr/qtFUeuiui/OjYez4plzgiK3S8t0QReLXVoXWB7JZEYW0N/uJsGnvp7A8IwFRITDVffPjfXPgGyRQcJ/Gsvyn1Wg62KaOSBAUXbPfOZQxS2xu+DvT61ne0eg9KMNkJsGr3TlxOzm/byLCqQdXhX2jx8bvT0+ZUnPyFARhh7ApZtIyL95Ea3uWMwm9k9ElIvzzS3I1mQs9aliD0ud6CLw5gJA+VP7JN/vxPLqHmKX9OviWNDwVuKOeQZSbJZZRR/zj1p4CxAa+YBv2UkyxiUEldT5nWHoJPGxSb5JTdxUUW1rHBo8UHL3s22JbiMXewcdLEsi4EQ57YauYUCHi3GM8q1F/nnCptcUmJsvyREkibUQ2lj8DiLi37tJsEN6vm66Gmgqk3yhuO550Uwcj9ZmEvQu8E2+OhiyJyfryiK9OS5O52VMOC8h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(2616005)(83380400001)(8676002)(2906002)(66476007)(66946007)(66556008)(4326008)(54906003)(6486002)(478600001)(6512007)(9686003)(316002)(186003)(6506007)(26005)(110136005)(53546011)(31696002)(86362001)(36756003)(41300700001)(8936002)(5660300002)(38100700002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllWMVFlNXJKTUZpWTlOV2lUUEF4L1lybFZJdlJNalJzL3dnZDN2a0E3VGJT?=
 =?utf-8?B?Qk9PeUVPUUh2MUtpdVZFRHp6Q05JNHg2WnRrU0VCMlVLd3kyQUFqc2ptckNV?=
 =?utf-8?B?TWs4WHIvM0JYRkI1OVc4T2Njc0M3ODV3d25Ccmx3MGFQNmtOQjJsSmorbWhG?=
 =?utf-8?B?eTA2dzVTdElnRUtHSE04S29LT0JaTG92ZUd3WmEvMkhIVVVqNlVhdDFMNFJ3?=
 =?utf-8?B?L2VBTThZa3dpWVBMcmVlWTBMcm9XcDgvRWtaSlN6a3hmTlBPYys4dlZwSzlK?=
 =?utf-8?B?WElySmdQcUE4OUdTVk93SGRtdFJGQUxTRjEySDRQbDRhOW42cjZEbEtlV3ZW?=
 =?utf-8?B?TTh0c2haUld0Q1lBYkIydzBYYit6c2FoZ0Qzb1I3NDd1U0dWMFJmTzV0S2VC?=
 =?utf-8?B?RGtZbjEvYTlxZUJNa2NEdkV0TGNPMWd4cWZ3dkRzNW9ZQ2tTRWZrMHVXZklp?=
 =?utf-8?B?VlJFTlEwK0t3QXRMQ21vRE5wLzFYbXRzZG5uRFE2Wm5vMy9ubFZhQmdSdHVD?=
 =?utf-8?B?VS9manBEbDVVQ0p5RFU5a2hXSnB1WFRGekQ0S1VKckZoRUk1QVZhbjJnT1JI?=
 =?utf-8?B?bkFjdHF6d2pjeHlKTFFtbzNuTWNXQ2pnZkhTeTd1V1lHL3U4MjJQRUhsZmtr?=
 =?utf-8?B?aXJuZWJ5ZC9tZVdYRUVIcndWZkVjWXl4ejYrVDgxbDdES2N6NHErWTZQLzFJ?=
 =?utf-8?B?akFSZ0lKSm5NZHgxcG4zVzY1dmE4c29GTTJmcnN4VG1qSmNlQnI3N2REVEUy?=
 =?utf-8?B?K05DUXN4Q0h5SzdwcXdhTGdvVCt2UmVTN3BrLzVySHZJa0JnRFRiS09mTU1E?=
 =?utf-8?B?T21SSmNzYlFRQk9MbkRSYUEwT0JvcHRQcytteXlOaWJRZVd1cTZKWXFGS0R6?=
 =?utf-8?B?anp2OTF5cUZidDVGbkc2UzdXcUhRTkNYSkZpV0hENU5oUDU3RHcxcmVvYUov?=
 =?utf-8?B?Z1VlSC9GSyt5MGM0RkRTdDVTVFVZOW5nZ05ud2d4cGZIZHFkc090Um96VDlw?=
 =?utf-8?B?OUM5WUtYS092WE4zZkMzRGpON2JMUHhKR0J6Q2lrVS9tU2I2ZkgrNDJidW5o?=
 =?utf-8?B?Q3hlWEs3RXpyZ3JrY1YvU2FlWkczSzY1RFNYTjAwSE16TG5jNzRCa3pnN3ZN?=
 =?utf-8?B?TXpSbVNjUEYreWk1WVZTZGZuRjQ0NFZmUW95amxIL0lwNVVwU3ErZUx0MDFG?=
 =?utf-8?B?aHRITDFDSHlEd2doS3BHc2lOckNFZy9qUGRBT0pxMTBSdVhpd3RQRjRRUlFr?=
 =?utf-8?B?d0NxL0I4R0xVdGhjY3NyN3VKcmFZY0tMcE5kbkx2eVZIMXVKVWw0K240OU5s?=
 =?utf-8?B?SEp4aEVzTklBT2tkT0dLUW5xanN2ZzlteldRRzloVitmVFFIWWIxdVVMZXBz?=
 =?utf-8?B?Mitqck1YK0xXbXhsZkRZMS9mTjh5TjdXOWVmQzRsZHN6NnJUeGd2cWsrSExC?=
 =?utf-8?B?d3hReUlMWmhLY08wRWw5Wmx3SGJzREk1bERtampybmV1WFBEQzhVR0RGbDQ1?=
 =?utf-8?B?UWJCRVM2aFJPQVQvUGlXM1ovanptSkVXd3E0b0xxa3lDc0o2SXpRRk03a016?=
 =?utf-8?B?cWc5Smtaa1llRW81SUtlYlZPeVNhZGtnNnpvcGErdFhualRtMkZId2RSQ1BW?=
 =?utf-8?B?QXQvTy9leHd6MW4yZ05ZNUlJYzMvWGtBQk14OUxZMGZ6eEE0UUZ4RWtCRVM5?=
 =?utf-8?B?eXpod2VOeXVhQlJZcmlRLzFhbW5IbjFsd2RCWnZ5V29wS3NENU1HMXRSb0hJ?=
 =?utf-8?B?TTlQbUdqM012bWh0U2RDdUtuL0dnNGN3UjdMR3JHMGJvaFIrMng3Q0RtYlBW?=
 =?utf-8?B?Q0oxS3JxeVlBT3psYnpzOEc3QTNqQUVpRXpubU5XbHVvdVYzdEZwVVBwS3M5?=
 =?utf-8?B?cCs5Z212OGhXUFFxRDBKL0w3blhGMnczdUFoWjRtbXZuTndOcFZvZG5XMEpz?=
 =?utf-8?B?b1lGTXRKUGZWeWxEdWhTSC9GM2FmSnoxWHArV1ZVbDd2ZjdCTWczZ3BaOEJF?=
 =?utf-8?B?WEFJWkRlNnNDVWJac0Q0emdXNm8vbGwwMWptbWt6N2lML1IzTWpSVVFUWmZW?=
 =?utf-8?B?VUljcnVGK2k0Kzc2V3lVRk8vYTFBNmE0dDV1T2hDN2NFQkpHTzk1RG4wYmht?=
 =?utf-8?Q?eFlawa5BQWutUOLlDT4Cfm9w4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ROM6enn/KiITKCqIkgeXHqUzScK2ghpJ8NVpZA/HM/c2q83ovkoPbT1pE060kgcEkQPKrL/INDNwndJcpuVBRr7K7SSHXQMa+0kD4h7IXMCPbGMcPZmls2k365f9nW1OsQNybtg/C0aKVwm89KAYXN7AQ4aDjAqTxcxyolclPPQ+wxhp/iMu79E8tS2ZS5zJWceEeD/UR+et1oMkoYifwLWCW/+7bkXZNku3IQMPn2IDHFtkncw3hFpqK2qsEVBomRrun9A0+iQSRQoeVEr6ubLdy0zZyMWspn6CJsTtXz6BHfxaueoX9B7LzyCrzdj+oIh6pO45E0KkgPg3PEMZHAiFxnV6mgxpES83ldckggxIgCTmLjVJ4RdZNviVDQPaQmKuMf+mVmT0piAOUvPaiSGYlFWQIwrBCADYJ3Ku2YDhnqtKNZUQ2Ay/FaesBDvUtVJmQZpHT1UGX/Ohrp+xEr7ZQZtQBtAlyanavf/p5UeS4fQNrbzBbMlbLt0PR0eSIlXEQft2T8WHyKJfG/abr0vC9yQH8miERTLJ5tvJBV93T5Ra4MYePbrz3gW9jvXa20YExnWxdb/OvI2p1qfVhQp2KqUmsX56kxSsBs+mBV9gjF7KfOyUn39EqMyLvXb/y5UvnXAeuMAwBX5gB4raD5qox/M/8sy4nL1FkJOg/fhUfblHFQFXq96NPTsHqftwh8f/7YQJJZmupxLwGn9eXVsf5gpGSS4vQfqfopg0RmTyUZKgmDAbq+pBSg2+PJ/p3YRiyhLMEHRXhhKs2/3VeV/xXKdF7b5XgsjVdZsO7SeE31bYfaBm8ib2ECAi0w1h/6LVX/KfzfFdwAvGLviUGQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2191df-1222-43a4-f644-08db2edd0b36
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:05:11.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng+XAgxzhHIkGpYipiA5mtT8okYoc6jItkOHtXhOY4n4fJV1MsY9Je41RNXl9X+QpwoOJy84JwsDk2qy9FVboQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270129
X-Proofpoint-GUID: shIzWaZVYKEEghF3uTTEnRCKXu4GJp0e
X-Proofpoint-ORIG-GUID: shIzWaZVYKEEghF3uTTEnRCKXu4GJp0e
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Just a friendly reminder for the status of this patch.

Thanks,

-Dai

On 3/16/23 6:38 AM, Chuck Lever III wrote:
> We need to hear from the NFS client maintainers about
> the below question and the patch.
>
>
>> Begin forwarded message:
>>
>> From: dai.ngo@oracle.com
>> Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in call_bind_status
>> Date: March 14, 2023 at 12:19:30 PM EDT
>> To: Chuck Lever III <chuck.lever@oracle.com>
>> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Helen Chao <helen.chao@oracle.com>
>>
>>
>> On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
>>> On 3/8/23 10:50 AM, Chuck Lever III wrote:
>>>>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>
>>>>> Currently call_bind_status places a hard limit of 3 to the number of
>>>>> retries on EACCES error. This limit was done to accommodate the behavior
>>>>> of a buggy server that keeps returning garbage when the NLM daemon is
>>>>> killed on the NFS server. However this change causes problem for other
>>>>> servers that take a little longer than 9 seconds for the port mapper to
>>>>> become ready when the NFS server is restarted.
>>>>>
>>>>> This patch removes this hard coded limit and let the RPC handles
>>>>> the retry according to whether the export is soft or hard mounted.
>>>>>
>>>>> To avoid the hang with buggy server, the client can use soft mount for
>>>>> the export.
>>>>>
>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> Helen is the royal queen of ^C  ;-)
>>>>
>>>> Did you try ^C on a mount while it waits for a rebind?
>>> She uses a test script that restarts the NFS server while NLM lock test
>>> is running. The failure is random, sometimes it fails and sometimes it
>>> passes depending on when the LOCK/UNLOCK requests come in so I think
>>> it's hard to time it to do the ^C, but I will ask.
>> We did the test with ^C and here is what we found.
>>
>> For synchronous RPC task the signal was delivered to the RPC task and
>> the task exit with -ERESTARTSYS from __rpc_execute as expected.
>>
>> For asynchronous RPC task the process that invokes the RPC task to send
>> the request detected the signal in rpc_wait_for_completion_task and exits
>> with -ERESTARTSYS. However the async RPC was allowed to continue to run
>> to completion. So if the async RPC task was retrying an operation and
>> the NFS server was down, it will retry forever if this is a hard mount
>> or until the NFS server comes back up.
>>
>> The question for the list is should we propagate the signal to the async
>> task via rpc_signal_task to stop its execution or just leave it alone as is.
>>
>> -Dai
>>
>>> Thanks,
>>> -Dai
>>>
>>>>
>>>>> ---
>>>>> include/linux/sunrpc/sched.h | 3 +--
>>>>> net/sunrpc/clnt.c            | 3 ---
>>>>> net/sunrpc/sched.c           | 1 -
>>>>> 3 files changed, 1 insertion(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
>>>>> index b8ca3ecaf8d7..8ada7dc802d3 100644
>>>>> --- a/include/linux/sunrpc/sched.h
>>>>> +++ b/include/linux/sunrpc/sched.h
>>>>> @@ -90,8 +90,7 @@ struct rpc_task {
>>>>> #endif
>>>>>      unsigned char        tk_priority : 2,/* Task priority */
>>>>>                  tk_garb_retry : 2,
>>>>> -                tk_cred_retry : 2,
>>>>> -                tk_rebind_retry : 2;
>>>>> +                tk_cred_retry : 2;
>>>>> };
>>>>>
>>>>> typedef void            (*rpc_action)(struct rpc_task *);
>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>> index 0b0b9f1eed46..63b438d8564b 100644
>>>>> --- a/net/sunrpc/clnt.c
>>>>> +++ b/net/sunrpc/clnt.c
>>>>> @@ -2050,9 +2050,6 @@ call_bind_status(struct rpc_task *task)
>>>>>              status = -EOPNOTSUPP;
>>>>>              break;
>>>>>          }
>>>>> -        if (task->tk_rebind_retry == 0)
>>>>> -            break;
>>>>> -        task->tk_rebind_retry--;
>>>>>          rpc_delay(task, 3*HZ);
>>>>>          goto retry_timeout;
>>>>>      case -ENOBUFS:
>>>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>>>> index be587a308e05..c8321de341ee 100644
>>>>> --- a/net/sunrpc/sched.c
>>>>> +++ b/net/sunrpc/sched.c
>>>>> @@ -817,7 +817,6 @@ rpc_init_task_statistics(struct rpc_task *task)
>>>>>      /* Initialize retry counters */
>>>>>      task->tk_garb_retry = 2;
>>>>>      task->tk_cred_retry = 2;
>>>>> -    task->tk_rebind_retry = 2;
>>>>>
>>>>>      /* starting timestamp */
>>>>>      task->tk_start = ktime_get();
>>>>> -- 
>>>>> 2.9.5
>>>>>
>>>> -- 
>>>> Chuck Lever
> --
> Chuck Lever
>
>
