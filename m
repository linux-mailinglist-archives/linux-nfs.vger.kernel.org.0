Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3443A73706A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jun 2023 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjFTP1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jun 2023 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjFTP1U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jun 2023 11:27:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD112C
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jun 2023 08:27:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBmcRf001245;
        Tue, 20 Jun 2023 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lFeu2ZMYneGFQ/Vzrs9xW4xjVQG1CNBx3zk8b6g5k60=;
 b=U9joqtJambaBJB36AejiUi1hZJx3x9VHuL4LfuDK4BvCNH0VIcLjo1/n54llTMY8t0Rb
 FmAS7R2rgzkDvDmdItiFj9PKBIrUNmFbOnJrhUdz9uJaaN1cx+DOHFwIS0W2o2VcjM3N
 VBNgcn4Oaiv6QiBzZ3Oo1pDAx+y5uXQfKFAqiYWRGLTMqGBTuddWJXTgX7+xeoEuiA1U
 Botzi9E64i3/jh43/syvgm15iGqUl/D6VaaZMPVzHCF21zEnN897WDbgKOjZMMSzqcgT
 uOOn9I0+EsWdeyGM1BPAwxJZL7tx4TzcfWEa6P8HZCSULrBjAz6FKDB5DgtB7j15Ygrt KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1d2uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 15:27:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KEJIf8007784;
        Tue, 20 Jun 2023 15:27:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w15429f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 15:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l841HJpMy0Ft4onwKXsim8i+aSAzg8Y5fusG4PM37QICVoLq155x9cKo7kplErnxAosc//vZ9KWoGWAP7i5O/TcrODMvEKN3/k4vhFNRdD2fxj5xfYymrtvl6rZZqN3gulq1LaRqT2LYgPbr151KlvmqhK9+ghNjgtGkR1a3XpppBFyXpJBqtmmEEMJE5h9JJqeSh51XuR7Ad1673AgKvYSm/fVelld5439cnPMBUqHIknRdDY/iUX13n9wgWpmcFDICmIKjqabYrHUvtea6VuEKDRLFfZmiAQasN5YqLWr3AF9bCdGInmPD2bpJkKL8JajkjFw/8b0ynN4bevOfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFeu2ZMYneGFQ/Vzrs9xW4xjVQG1CNBx3zk8b6g5k60=;
 b=oG2XbkL0setc1rFyIkkHwytMCtRtrZ4UWeH4b2rcHducGnMizdKVVawAmCSKqkDV+EBUvFW68Pb+BXzcREKFwXOpD93+CRY6Zr+HsClZalf+Gzn5OZ5NMRKY50xFNWiU7mHLZ6gVl8UrNceBXaQHLw1a/6Ycef2uRqHwABR8pcG17M2XVvkiFGFDevHDtZ5nMVGGjDzibPl4xnEimvJMdEjDfiAMhXD1C/zd8FgZk8ujhz5GKzfbafhvoj3wrxz9kCxA2/Eo8woMC+GVekrSr0cZJzJLJBhSVSdNaY05JnpUAHRn11QduDVGIXzgVsUj7tSArI8gU0mKVG3dCu7pHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFeu2ZMYneGFQ/Vzrs9xW4xjVQG1CNBx3zk8b6g5k60=;
 b=0EQ1ObxGK/9n2fNBsxxl6oz0Q7NdhsOuokOSvrTjrT3PqOSoAac+FtjzZGwkb5I24Qp0PYa7NkIR2az0hVdimF9aif7/h7XmYLb63UZVoX13Oxn0SUhvIETYFNhOpPQTsS/1rO2t5nePJVE+b7Pu3vSSeZ0cgiG9D++HN9/viQg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 15:27:13 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 15:27:13 +0000
Message-ID: <5a43e57a-eb00-6f76-87a8-1a80c584b9f8@oracle.com>
Date:   Tue, 20 Jun 2023 08:27:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: NFSv4.0 Linux client fails to return delegation
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
 <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:510:174::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fc5b89-3fe4-47ad-4d43-08db71a2d250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQR2sZAUTD64l4KZ5TFWnTqtMMlAEUzvEY0f/372aim3N0oW/gOUuM+1acZCMz+gMgg8MlWfSJOWQ4sL89z5jyPEHTJjnDv4kcbLdcDrVFvs7GEYFGVFy0yFeWc2GvWH0Sx6Yx7UqDweVgn6n5Jjl9YmGa/tiE08DSWjLlXingPi0ERk/jqn7RtlMRd2xv8h4fxDg0gs+CaMXc31KltM2OMmUSAEhkyYK2rxI0USQbt0glFyLdqJtVfSwevA6mFjsPSeryYabf94qBfi/V2TqCU0J41UdYKL1ylY87sg7ZDHPVHIs9CMqAVtkv+zSKEft4LCxe0hCKyDjd7XCnlL22d1gxiHe63TTPrm0mFiTiNL3ULAXXNfQWO/V/Yak2l3WXyymyBPh+VqtyWkAvyDOQ4H+VkkTEAw6IW/TTsvAiq+C2BKGEiVNH47vluiJmLLF8ZIvY1cLVwQeLvtHE1iL2ADfn4Dj5ksHqVEGocUT9s/fNXNAAcC9umzzU99ofusr1I6MjOsEKDfYUUKyinJqfrv/EvFSPw7EXFw3S3/AP/EjCEbtBF46Dmi8wKvsdreCK4e4WzF/QoFF7lNR5qJojlkv5ZSg6N9sDNy3verJPGHmvIlAdTg1TdfOmnd6GWM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(6486002)(478600001)(83380400001)(186003)(53546011)(6512007)(6506007)(26005)(9686003)(36756003)(2616005)(86362001)(31696002)(38100700002)(6916009)(4326008)(66476007)(66556008)(66946007)(316002)(31686004)(8936002)(8676002)(5660300002)(41300700001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZSRE5aVGZuSUkvbFlTdkszY2UwK0xsQXU1MlgxVVQzdXY3aTZGbC8vTkNs?=
 =?utf-8?B?U2lOcWZEMjJHNzR6Wmt2eDF4Q3k0dTdSL01qd1NmWE85YlFoMUppR1pnSzJS?=
 =?utf-8?B?UStqNGV3YU53MUpPdUZXUGZoUG1YdHBBU3l5U21nY1NWbUZHRkNpT1FUR3FT?=
 =?utf-8?B?WVBScWV3M3B0R3ZyNm9NN1R6MkhEZE9iaFdrMG55akx6aGN6VEtqNkRkNzdk?=
 =?utf-8?B?YWRQSVllQkRxV1lHWm1wUU9FRWorL0drbGpUbmZQMU5TNi9IQ2dVU1pnN2sr?=
 =?utf-8?B?cTkwOGJaN2hXYi83NUhhZVZXS2V3RG9lTHNKb29jdDMyNnAxS05pSzZoeXI2?=
 =?utf-8?B?U0ZhWHFxYXRxUUszVE5NSDc4c0twNnZ6UndiQ2IxZnBtRlNaT0xLekVLd1A0?=
 =?utf-8?B?dGNEZjJFQThDZzFaY0cvY1J4Tmk1RzVsR2g0Mm9XekZxdkxLenhjTkpwMFJt?=
 =?utf-8?B?dXNoUE1rN0pLY0E4cGJ2S0Y0RVZjdmtrc2tFSzVkV3VZT2hSYUw3NmVIT3dY?=
 =?utf-8?B?T1VpWEs0Tnh6VFh3ajVPMXNxUEkzYUhRQ3lGaDQxZm9mcmgzVGZBQXIrREkx?=
 =?utf-8?B?b3NmcU5YckRCeCtZT1BEbkJGQjlqaHhYN1hCUnAzSWNwNTdBeDd0QWVOMnZa?=
 =?utf-8?B?a2R1ZGV1QzJKbTA1RW5QU1NpUUFSSUpZUFRKSGtoR2FULzB0Sm12anRSd1Fh?=
 =?utf-8?B?NE5JL0hDWE85R1J0VHdpbHk1WG1MTmtjYWRJRThzSHJuYS9lYkx6c3Y2dzlD?=
 =?utf-8?B?eXBDdlhXQ0RjamhobGVyQkRwTXBrMEp4QUNoSm01ck5JSGF6RHVnd0VHQnd3?=
 =?utf-8?B?WHFxTnRlSzQ0RlJBaVJRVWRvUmlhQ2I2YnVQNnZKdXU5SG9MUlVwYkpsbWVG?=
 =?utf-8?B?aWcwN3JKUHcrSlBjSENudms2UlQwZkpjN2pyenVWVWhYVmdUOUJwdGxjUkhV?=
 =?utf-8?B?RGU2ZlQ3dTU4ZFNMUWpLTXVWTVVSMjhhd3A2cXdSYkdHanU5ZCtMWEdSWUVR?=
 =?utf-8?B?aG1KY3YwaTBvbmlTSkVnVzY2RjNmOTZYZ1oyN0NVenlmaGV6QkFXRzVHUE1l?=
 =?utf-8?B?bnZXWFdySmNDV3AzdjR2czdKcmQ5bkt0MkZoYStBR1ROR2tKTkxSNmRlN25N?=
 =?utf-8?B?ZXZCRGlyMS9vcVIvUXUvSUQ5N1NsSU1yaFh2bFRnbXVrK1pQQmpsMnJqRmo3?=
 =?utf-8?B?L1ZPNnNySGhnRXBDRUMwc3IvK1NxWXpVa2dpeWlYMnJvN0RhSmdHVjlTeVhw?=
 =?utf-8?B?OCthLzhOLzhqRUVTYkV0VFAwT3JGa1VjOXZWSDVrcUd4M3QzNU5DbWdwK21R?=
 =?utf-8?B?eXVRRE5KYlZGRnM2ZGpnL09KTDFSYnNoVzRDSTNYbEdiWDhJRVMvNzUwNHI4?=
 =?utf-8?B?NFNRcSt2b3lCakJLSjdkNlNOTmJJQkJEOUtwMTY5USs2TnVJb1NHWmx2OUpW?=
 =?utf-8?B?b2dTUFVpcGlLSUZsREpheDNJc1RyekpucEdzSkEwRHZaVW5RM0UvMCt1WVZm?=
 =?utf-8?B?eVNoT3ZOWXpmb2dZQThXSUF5TldIQXVNakdqZnNheURBM0l1YzJJV281OElr?=
 =?utf-8?B?TldnUWxEMEo5ZW9NNm9hNW9hL2pJaEFxWkNHdHpCdVFobTBhMEN5RCtVM1NS?=
 =?utf-8?B?WFQ1T2c2bnUyaDYvSkY4V2FGY21pWHZYUnBuUWZNQmJ3VjR3dUYrY1Vab3h6?=
 =?utf-8?B?ZWtkckZKcmdzM3RXLy9rMEQ3RUI3WmVVL3RXSHZDVXpXVUZlbFdIaVhGdTUv?=
 =?utf-8?B?aG1kaFlaQVFBN3dURWNWQXpGWHNuN1diekd4U1Q4TDRFQm9wSmV6NnhibUpr?=
 =?utf-8?B?d2ltUWxZNkdwcmRJVHAzYmEyeGVUSzFMNlUvaGN4SDhHOHJiSnIvN1NubjE0?=
 =?utf-8?B?VXpjUU5QNnYxOE5rSU9MaEZKZkJpL0JwR0tWREMvcE9qSTN0M3hTT0hCKzEr?=
 =?utf-8?B?b292dVB3ZS9GYTlKVmE0L2FIdzB6ZFZHL0FTT3ZTRks4aWNnRGNJM1RxTDFm?=
 =?utf-8?B?TDhkZWEySnkzREpFbE5GNHViQzlnSldna3JqejNOcXFEWm04N2JXbGZtY2Z1?=
 =?utf-8?B?cDFXbHBRc1RqTHdDWnFUSE9aek52ejcvTkFMRCtmWkdYY3ErLzZyS0ZZNjJD?=
 =?utf-8?Q?3c/MGiORUqUnE/OnVA6u6rX6Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 62xZfIRSbxBQ1//BUhneLC+JnsHjJ9r/BXJRfmtVgyrimQFcbgoTLv8cdD1b/+q7aSYIBKGsmv38CQbLwCbUChwx9XpLKp8oECEG/ke8ELQcF/u/RQI6XJUHHS/ZZQ7fs7uzGEG+hul2VNu0U6H8TE0oTSXDH5m1LJWcniCr6mXIJoR6/HUgQjfcuc81hnCBLmeywswvnZRfpmEZYqwi0qvNBkqqrM/w/F/Yokq9YNisrqnroOPTDWoGYDs0uXejPfNtlKo/Kxg1K5AWKqtppD5HopjD3RWwszR2KELWfMYmHLdyQCpYY53g/5+rppcwbvdl5imEKxfXYrTGLP7uuOxto08JqYnCQbaP3gVlgu5MPGJMgefjDtPe3MbBjxQRRLxXH0jhD7SJ7RSGc0ryqhvlvthFtsCGEGL5/+mYFui77ySAiRjTuS9zzZK9sBtoEZRLDEkrRK678sgcrgzytYY7RszBoDOb952tLp5gscQDhNNRqp38OwZhwpMnDOF0Mi0rhyNs+GCocm4rHw8SnWdF4w+G2prn5CY0j6Mnep9IgGfbS6PHhzw0ht1pq7nqy2fbXBJfYgqBMHkWMuZUmGjYPrVfNRd2Oxz5d3OyTN7y4nG7KLCjnVFFYTnh2RetQxzHwmv0I1rPkrl0F8DykLL0Q7hfl7YOAbidU/00/UBhq2Fwj872R+hcggQtJxZlmEsWUMH9vzkiUt4HTOnzhhPieMPOtKNlOpwZGRgKAFXpahoC9yJGi//KYpnwslVhXmwoW156Uv80PtH9jQiHvqZVa2Qk1OSouhuEwSyE9WZxy8NNoWXBuOUzUHo1rFU+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fc5b89-3fe4-47ad-4d43-08db71a2d250
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:27:13.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nisyzETbKA5K+W50R5iRolUoNnXB2NdqshQ5hd3UTOdKGGwQ3Kk6gk3+RKcwJY7ZsJXgq6HbZhkGXzxgnJ7HVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200139
X-Proofpoint-GUID: 7U3tiLGSgVxPhyyJ0lD5WJcbURGWyCB_
X-Proofpoint-ORIG-GUID: 7U3tiLGSgVxPhyyJ0lD5WJcbURGWyCB_
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/19/23 12:19 PM, Trond Myklebust wrote:
> Hi Dai,
>
> On Mon, 2023-06-19 at 10:02 -0700, dai.ngo@oracle.com wrote:
>> Hi Trond,
>>
>> I'm testing the NFS server with write delegation support and the
>> Linux client
>> using NFSv4.0 and run into a situation that needs your advise.
>>
>> In this scenario, the NFS server grants the write delegation to the
>> client.
>> Later when the client returns delegation it sends the compound PUTFH,
>> GETATTR
>> and DELERETURN.
>>
>> When the NFS server services the GETATTR, it detects that there is a
>> write
>> delegation on this file but it can not detect that this GETATTR
>> request was
>> sent from the same client that owns the write delegation (due to the
>> nature
>> of NFSv4.0 compound). As the result, the server sends CB_RECALL to
>> recall
>> the delegation and replies NFS4ERR_DELAY to the GETATTR request.
>>
>> When the client receives the NFS4ERR_DELAY it retries with the same
>> compound
>> PUTFH, GETATTR, DELERETURN and server again replies the
>> NFS4ERR_DELAY. This
>> process repeats until the recall times out and the delegation is
>> revoked by
>> the server.
>>
>> I noticed that the current order of GETATTR and DELEGRETURN was done
>> by
>> commit e144cbcc251f. Then later on, commit 8ac2b42238f5 was added to
>> drop
>> the GETATTR if the request was rejected with EACCES.
>>
>> Do you have any advise on where, on server or client, this issue
>> should
>> be addressed?
> This wants to be addressed in the server. The client has a very good
> reason for wanting to retrieve the attributes before returning the
> delegation here: it needs to update the change attribute while it is
> still holding the delegation in order to ensure close-to-open cache
> consistency.
>
> Since you do have a stateid in the DELEGRETURN, it should be possible
> to determine that this is indeed the client that holds the delegation.

Thank you Trond. I'll wait for Chuck to decide what to do next.

-Dai

