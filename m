Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD83EF5EE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Aug 2021 00:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhHQW4q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 18:56:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49314 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhHQW4p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Aug 2021 18:56:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HMjj0P031941;
        Tue, 17 Aug 2021 22:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U3FQxM6freVq85Fz0VBDv7Mkm2CDgmRtMFYpTXhIZs0=;
 b=nGWVr2uyAJXK0EvAIUhIIprvXSzmj7mlZsDq3tWbL+MfLYs2uqAkJ6udz/vKX2dVBb3s
 PskyODcHnItGw53RRTQjvoMaOPfUTQ79FBNhYjWQnCZMDAF7cBEFyLWIVdY+gtmb8gef
 NBLmX5KrqrFKHWZ8bEj440RbpvN5ybR6+hGQgekofLVHXTLzhpwWnawTOh6eGgKGlEzv
 rNDY4Ijs/Lgiakq/XHcB/iFPmH2Upe4pHJUjTvwXIAfybapS+oRG/VOn5CM02AH19HsD
 lsAughAAggDA/bC36ykvP0GnSBXFKsTdAzgzmaQpNeyXKA5dwdMrEmVY+brUsg/a8TWT Ig== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=U3FQxM6freVq85Fz0VBDv7Mkm2CDgmRtMFYpTXhIZs0=;
 b=tzEmwgEvf/Z4ALf6Hf5PJqXuv5kJWZwt/0CPJLZ6dRBVdk/L3K3ZJQUgqp3R+PXjbKWv
 +cqNwp8YCAmDwGsHJXZQE7w9OVW+704x+qGy1In5UhSogEXRnN0PbvptRrGai4fTmtW7
 s2E4WnDHJHFPBQ9wRUzbT7hjvJmiuai0HV7GpUyhKj/ApxRoCLenL5QIBL0CHDY8TJ41
 U+nGv6uLD4UIC0otXs9QPeQ4TZk+MP/0mHqrp8HA0+4rWNmnG2adHZS1pXMgE8jdeSKj
 unL7s8FLPgdaU3Ax20yH2xLjzDYd9CIJRtpWV73Gm6n3i6n4QJiw03i3iq1UwEsTha+Y Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d98nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 22:56:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HMsuwj065319;
        Tue, 17 Aug 2021 22:56:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ae3vgd7d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 22:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH+aIrF8Cu3dmL6P3aXCLRja+lIDwv8gNET8RV1abJFuO3ik7+NVqu3YPfpHK40O8CrHmaF849u2uh8isrYmQETm4VkSR7KO/JjdnVel2kP8nX2G+0ima/h1cDmBvzRpfyzscH4qDhdDQzqMtPsmduGtZocqqTNfvP26lUTSY3gavLpaSbjIGZ25EOx6yJQSR8J273jjVX/rfJPleSPShvcsnuC4l1ODkXsmQheFnJn2LZHrXpxTwYjf7oWBx3eI1lr0FY/xqzFGpJ9tIoAv3dZ2zVP3g/oK7z44O5vFw6OIDDKcWNVmY2JvKWCmODmfMppv0qY35F7DlQHTQ7fuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3FQxM6freVq85Fz0VBDv7Mkm2CDgmRtMFYpTXhIZs0=;
 b=g1q2CHWO9UEnBNUI+qiuawii8V7fKtU2hVgMfI8+m3ntTUJnuG++qMACN0KsVVnz5dB3+pOtsGhoPDnXC6p6ED+U600H6fcZe3kOZJxnGuZjteo7wqllfRPailNXnzkTTDlrZYiJS8y1Rr+d0I8zAzxxs6q9GWkejiSs7G4uHPjgeUaw6aEVIJWtEg1t/SFJvQlFbMSw2GN8NPL+2wRE+FEsYhxZJFSenOOBUkW08Cy7LES8zJBq88UaI4b2jkc8fnAW2trenxJ41CRKSmh3nimy4EB7T9g6ZY+TkaR9pW+JpR9+NiFYHCwuer6dUpYwHoLx3GYyRFmQuIbtvDGJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3FQxM6freVq85Fz0VBDv7Mkm2CDgmRtMFYpTXhIZs0=;
 b=Njg5RDVnwHFOIZ1C0vvjBp1xm877NQg9JSffitX+ScVbgmbifFVN/H2YMQYuDEW+oPK3fCRADo0493/N7l5ZIw3K1lMBDexLv7itS6SJR+e093qP8hXKNn5NfDYOcsgZZFuTLGmG1vjMrc+6MwA7UvZtZiKl/T9P7uH73IFktZ0=
Authentication-Results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2487.namprd10.prod.outlook.com (2603:10b6:a02:b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Tue, 17 Aug
 2021 22:55:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:55:59 +0000
Subject: Re: Spurious instability with NFSoRDMA under moderate load
To:     Timo Rothenpieler <timo@rothenpieler.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
 <7B44D7FD-9D0F-4A0D-ABE9-E295072D953F@oracle.com>
 <97fe445e-6c4f-b7cf-fa39-fd0c4222a89e@rothenpieler.org>
From:   dai.ngo@oracle.com
Message-ID: <baf4f3b0-6717-8e3d-efd5-fa471ae8e7e3@oracle.com>
Date:   Tue, 17 Aug 2021 15:55:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <97fe445e-6c4f-b7cf-fa39-fd0c4222a89e@rothenpieler.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro.local (72.219.112.78) by PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:55:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c7b09c-66fc-407c-f6ea-08d961d22e2d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2487E452516BC98EEC594FB087FE9@BYAPR10MB2487.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxXng9/1SoHxrFiYbnNv4/U+MTiQKsLoUxJmATVCWTTss/TeRmsQbixloapVVtskeXGw2vz45GSBaxx/lcEgWWqfiCaspelmEblrPg8TNrzHVNmeOut/209jcRUmu28Oda0A/X8zk3MhqRbu9a7wEu6PRDczx5At4tpMoui1t5EbpZIAmN+pVEMnHM40JOlNAyJYu+SLfBQiGkKOT0Fq9SpbHFm8oLHEMtMqmAgeTB8siB2I6Gn0rBIphTeesrV9oGyEea92EXMxQK8916QdVbgU/0peeqwda0BoZcx2KZcOMC1YRuaYyqCIj8dN7J53SfeUWUfgzcr1j4nq3Xc6MSLWR68vOhGzq4yFT1qUOWrRURnEb00H1pf90+jOXKz/dgqbAMQnsF9ZEcXBjHWPt/frgKgwfffrvw4r/p4Ap+jqvJWAH9MkiV/jG2E4AkHra88i+/zCjDIOBHnjmer/xZOG4i6OOfuNs/jm9vAjwSe0MF7sdLnFZnr3zurSpHcoVRIqZ4jWuA91wRPFZdQyNPgiolEe3BLCG1roYp+nQNZ49iWAI/4d7MrRAWAFD6TDTbSpp1b5FboX6btUjuxUv9aQfmUyDdRHdif8Lt9BEb38jYw6KyW340rJDx60iU1RgL2FS6UqUBzbzvNiyTvkrrBiGLVWXf1LOG/pSDBrvsr9ZfGNh13U7FgcrrqjzFKB1OCFkjglPbWfOt4u1YnjkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(366004)(376002)(6512007)(5660300002)(8676002)(478600001)(956004)(9686003)(54906003)(110136005)(2616005)(26005)(316002)(31696002)(4326008)(66556008)(2906002)(8936002)(6506007)(66476007)(31686004)(66946007)(36756003)(86362001)(186003)(38100700002)(53546011)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZZcE5XdUxLRVR1YUlyYThzNkdwcDVvVG0vSlBzbHB5UFFlNUg5NDhxeU9O?=
 =?utf-8?B?bzdGY0tCUUhvMWl6TEs4UHM1cEx3SEdnK0Q4MXN6bTgrSXh3TDlmYWZJTkhp?=
 =?utf-8?B?eHhveC9panl4c2tSYTNnZWtxV2l5TFQvd05zVDhmaHNwT0VSU1dyYWxyUUE2?=
 =?utf-8?B?UGxIMTZ3aW1kYzBWdE9yZGg0UlhSTUNYQzJ1d0VaOTZDRjk5U1VaRUZGWGZZ?=
 =?utf-8?B?bERxY2FoZzlnZmdoT0Fxc29qU1RqMUp5VWE3MkpJTDBsSG5jZVduYU5kenBx?=
 =?utf-8?B?ZzBWZVlqY0Voc1pPVE8vRWw4RUQwU252czFQOG1VQTJpV1pyRXNYOUF5WDlP?=
 =?utf-8?B?a2VsRFYwK3RqNHB5ZEVVK0ZNRTB6NDl3V1lPWEVSaXgyaFZNZmo4N2tFN2dG?=
 =?utf-8?B?czVSdVJ4bnE0eGo0dDc2ZkVnY3E2Z0ZnRk8wMkRQM1ZUZ0FiMnozZVRYSUhP?=
 =?utf-8?B?bWpjbmNUUUJRMVFSc0dwNlJmcTN2djhidE8yVHMwK0dlb1cvRXdpZFY5TVNK?=
 =?utf-8?B?Zmg3L2xKdFR3VytDNVVoL3NoYkp4MnpNNG9oaXJCNUcwYmRXU2h2Slp1ejUr?=
 =?utf-8?B?VnB4TzZETnBpaktEOWtra1ZaR0NLRFRYdjNNRG1RVFhnakhzZ2NuNkIrR29N?=
 =?utf-8?B?Wng4eHJ6clBIZUVWSitSN0tHRDBhOUJTaXUvYXcyeFIzY0lxK2R4citaQmFJ?=
 =?utf-8?B?MkJDTjFRU2RjSGp1ZnJTZFZwZHJvemhJMDlCTDVDUmFncTI5WkdZbngrdWM2?=
 =?utf-8?B?azNBNmszbTBHd2d6eUU3SXI2RG9JdDh2MTNPK0lOOEN3YUNyanVGT1BGaEt1?=
 =?utf-8?B?ZDZUb3hJWWpkK3pJZ1c4dzdnbmY1UERSSU04TWs1TmZOcHJISkR2ZmxsVjhT?=
 =?utf-8?B?dWFuZU8rVWNWdWNtWU42QkJhQy83RndhQUtCQ05ydS8wU0dmdnFnTDBFSmxm?=
 =?utf-8?B?eHVibGdYdFkwMzR2SkJDcEdFanFqeFJFYlA4WGxjU0dGWUlvMzlpQXVOSVds?=
 =?utf-8?B?QkdkWmIzK1hkd0ZZVHRQbW5NWUlDVElnOGtaQ1lIcHBJZEwvWUt4bFFBYnF5?=
 =?utf-8?B?NWlIY1FXbDVmUFVia2hTNHlmMFM1OVFmRWYzdHdVNmkxY1NLQXZ5R2ZTck9r?=
 =?utf-8?B?WktCOTNIT05RbFhFc3BDY3VqSVVNZzJkZldRU1ljWkxJTVJPaUFXRDhWK3Z1?=
 =?utf-8?B?WUNmSHk0TldZeVY2RTdJT1djMnZadzVTU0hzOFJwRXgvVFpValNCdzk4aFJz?=
 =?utf-8?B?clhtSlNFRXZyTGhWNEVOM2VibENSdThrcXQrZ01LbDRGaTNCSVowNUlhVERy?=
 =?utf-8?B?SDFLSTRCL2svWWtocERGQkZldU5jOGhxUkFId0ZsMWtLaHFLTWNLOU0vOWZF?=
 =?utf-8?B?VE1GOGt4UC9ZYkRQNGVrN1NyWFFOUFhHR0k4QUhXdGNYMnNRRlQ4aHZiaFg2?=
 =?utf-8?B?TlRkdkpCdG9UaXZQb00yckN5TENGWUY2TmRKY09NZWlNSi84VlY5d2dhcFpH?=
 =?utf-8?B?YTgrZ0R3RTF6OTNWcm1Xa00zVGpJcC9Pd3pKMTZCNkFZN3lEVjNIN3ZFbkJx?=
 =?utf-8?B?UGxRYmcxclc1S0RYRllaaXlzZkZOekJQTnVVMktaMkp5ZmhOQkVQOEVYTUYw?=
 =?utf-8?B?RUI0WDRJcTRwbHhadTdmVld0SkpROUJxWTZSd2pReEF2K3U1Njh6SWszbHZp?=
 =?utf-8?B?T3lVc2tXWFM0K3BvK0dscWRzZndHOHNVNktxTXBHSGJUM3NaSWxEZ293cEVp?=
 =?utf-8?Q?H/n/EwE3IFUv8h5hfGhOh1LQHw5eHMSgrguI0xd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c7b09c-66fc-407c-f6ea-08d961d22e2d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:55:59.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzRTHOUQx/5yaaqSKrOe8nNtaiWfAJpdSRZ3QTHUe0kwrnW9PS6uhT0ZucCXoxai2K0GAvIuIOCpQQvINlzF+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2487
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170144
X-Proofpoint-GUID: OXihLRVIbzs0Z3AXX29zN1zh1VHx-Wm5
X-Proofpoint-ORIG-GUID: OXihLRVIbzs0Z3AXX29zN1zh1VHx-Wm5
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/17/21 2:51 PM, Timo Rothenpieler wrote:
> On 17.08.2021 23:08, Chuck Lever III wrote:
>> I tried reproducing this using your 'xfs_io -fc "copy_range
>> testfile" testfile.copy' reproducer, but couldn't.
>>
>> A network capture shows that the client tries CLONE first. The
>> server reports that's not supported, so the client tries COPY.
>> The COPY works, and the reply shows that the COPY was synchro-
>> nous. Thus there's no need for a callback, and I'm not tripping
>> over backchannel misbehavior.
>
> Make sure the testfile is of sufficient size. I'm not sure what the 
> threshold is, but if it's too small, it'll just do a synchronous copy 
> for me as well.
> I'm using a 50MB file in my tests.

The threshold for intra-server copy is (2*rsize) of the source server.
Any copy smaller than this is done synchronously.

-Dai

>
>> The export I'm using is an xfs filesystem. Did you already
>> report the filesystem type you're testing against? I can't
>> find it in the thread.
>>
>> If there's a way to force an offload-style COPY, let me know.
>>
>> Oh. Also I looked at what might have been pulled into the
>> linux-5.12.y kernel between .12 and .19, and I don't see
>> anything that's especially relevant to either COPY_OFFLOAD
>> or backchannel.
>
> I'm observing this with both an ext4 and zfs filesystem.
> Can easily test xfs as well if desired.
>
> Are you testing this on a normal network, or with RDMA? With normal 
> tcp, I also can't observe this issue(it doesn't time out the 
> backchannel in the first place), it only happens in RDMA mode.
> I'm using Mellanox ConnectX-4 cards in IB mode for my tests.
>
