Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1778F328
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjHaTP1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347138AbjHaTP0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 15:15:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D7E67
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 12:15:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VJ4Mcq010150;
        Thu, 31 Aug 2023 19:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : references : to : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zUQUUJirZIuAQnu63sKxHY1I2/jZsOORSIRV9ezhdmc=;
 b=O2YPwP9FFgj7pcv/odMSDN13cfKAy1pfr3/f/OmP5GGyVEG8IeeVsF6QD0bzxbknpXu1
 PrtQjqo0/GDOUtI/jO1fGaARt1D4BEHYl2m+mnIkZwHKedrx1oKfal40fM2T90WJMmTF
 jSqninMp2SqCTgihG3tx4My4snecqlx2Mi0jhqc1KcWlkWm4MCgkG5k1pw18JLrAN+oB
 /6NbgI+UG91qjapS2xdMYUi3qsWKAbgMYs0ZFpG/NKmrg8y8jynujd/ep5YDEl4utQu2
 w4gmcfZh5gEHfochim137L6RcCtUXLvvGyKZQA+LnMOuX7F8RD9xs4dwTcaCmbl9zb/+ CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcth68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 19:15:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VHq2tW024367;
        Thu, 31 Aug 2023 19:15:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6drcy3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 19:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVkOqwkMg2v+LvTksTifMGQ/u6kPyrfwlR2JOZVGbmoeGURSiedTbEAr/N5H9i+SVDsXBf7rePW6YfVFR2RD4T261zoOnlxkQ7MkJnQ8bLbvHuBvrhAiVXIvMxQlzvPzeWqyq+VaWUipkxmVGN4T22hjy35Fm3S2oSvvnZ6MlE2bkPFvBoPvpUJtsrN01Kp/msZdPEiA9LkP48j7Yu3xocWHfPQwhJpVikyyRT5zYQ3qhoRLZXLuNpoHLXl6FidCabB/7RI+KdzfZ+aNYcNOWls+3SFzvooo0g3dWgoUvIdG3UhWE5HHIRNt0iq+ba1rIOAu7TaeIk+xYoaCXv8MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUQUUJirZIuAQnu63sKxHY1I2/jZsOORSIRV9ezhdmc=;
 b=Psn0tPIRPm0VHAerofusMkblDYMSCcFoX6Ijn8/6RrbHE8OWN+W/dwZ+j4aAsU54TWaollqVuR4IM7L/8RkFS1knhR8vBuXveDB/AJ1qUr/9Nh4I/o75KhjP32wTskmzC+8JpyLmP206dQrdyGXQKAMs+pbj1J7LTVivBUud09bDUzKKNRJvYG45/UoBYpPEMeftSAYdVfSLlZguHpmRbZKfKnariXGMFUUU92J4aMZEKZ/EP2m0RLHTdlYz4fyb8XWWIlzthSlJAbwuugjwdUZ2JcL+/E2XbcBR9FiljqiEWpGBpGr1lAa54Q50IK+AGNeWkcmtwiXTYF+8t7sKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUQUUJirZIuAQnu63sKxHY1I2/jZsOORSIRV9ezhdmc=;
 b=ky6QgLoYQo32ataVS7EpXXQmvm/DHds9qT5EcS4X5GNwa77CxEI1RPx/6JwOYzw09WUyjwV4urcFIWlGs8DOKtGyTWMNuEf2bktSZm0J3xjsgyQTm+4L9DTb0E+yqgGHIXqndxKbIcaauuVlhsZvf1nQapEgYOBPwcSaGMarkd8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB7253.namprd10.prod.outlook.com (2603:10b6:208:3de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 19:15:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::fe75:575d:5963:93d7]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::fe75:575d:5963:93d7%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 19:15:09 +0000
Message-ID: <efd1b866-d5ca-339c-7982-c093cd1849e6@oracle.com>
Date:   Thu, 31 Aug 2023 12:15:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Fwd: [PATCH v3 1/1] nfs42: client needs to strip file mode's
 suid/sgid bit after ALLOCATE op
References: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
X-Forwarded-Message-Id: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:805:de::27) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: ec937775-8199-42af-8c0b-08dbaa569766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSPAgpNx3OGyRoaBgLuWeGdHJLieWS+LD2KuMZwRuGk8HmUvipZ4J4Ogm+2UJD7vA1YoxWB8AqnNjAGbkMSUVXOGu482bhdwQU5cucbcCtUFrfJeEfFMiF+eTk+lt30llYOk3Of2mJVCw5QYLltq/FoMGzca27Fp74ckhdbfTVIDB3EtsygH2LpG5M/EcnumEmAHs/ltAvFicRbSyiK2PFTKNQAZUM2M5vELE9LmsS2kl6mWE0crbWWpynOI502sHzmY/pPO3iBrjhFW5IimZhCIUDPJiTERwrZhzTrWNIjXiRwfZDe4EuMvvv0PJ934Mr9YLimKPgzsekvuyBubgS1f2hhGETyZFG6lA1Z4nPb7CEJnRM9PD1eDFMNSLHgi8iKGN/inlQqX9aHYBH8v+8cvmMHAPMlSvvQwYEwK6rOinTSagBCuvScZMeA32pJLEPI5jzsJ+wvuAt51UF5ZCTxRfP/cLVIUsIG+cagGFedKESP9N4y6GJjsiHqk88fYuTgNuObPHj4HuSEXvmKYqs6yyTp7Mj+5X5V3nG8wS1X6yI4Jk8c3r+5iojaqtJeF9D3iqaJcsp/jxW2+mqIwBa5JlZqAd55AHEbeNlXcL2kEa3LrOMJtHw1OA8pc1xRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(31686004)(38100700002)(2906002)(36756003)(31696002)(5660300002)(86362001)(4326008)(8676002)(66556008)(41300700001)(8936002)(83380400001)(6506007)(26005)(2616005)(316002)(6512007)(9686003)(6486002)(6666004)(66946007)(478600001)(66476007)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZsRE5GVFJCRXRGOVR3WThsZ0tLNjBVcEEyejVyY2orL0FWS3BpQWpud3FU?=
 =?utf-8?B?STFGTnZ3MnlmZWRleGZzbFhoQW81aUFybGZrMXFrMXozU2JhOG1zN3VkUmJL?=
 =?utf-8?B?RXpsMHRsemdHNEhjRDYxejdrd1UyakcvbUFJcXVNVmsvd3ltb0x3QTlSQVdk?=
 =?utf-8?B?L280UmdSbXh4QXBVZTl6RGh1UFZEMC9QcUJSc213a2RmK09EZXAzeTVyUmtj?=
 =?utf-8?B?UTlBb2tSVnU1TnFWUmt1cy8wNnJBVkFJTkl3RE1pVjduNFFkczhKeSsrdU9a?=
 =?utf-8?B?VW1tckt4UC92VDJ0UDhjeW54WExrK2pLa0wzcGpvOTdVOHZ4QmdOSkJsTnk1?=
 =?utf-8?B?SDF6SjY3aW5MWCtNQWRkWnI4MFJTM2ppSWZyTEtuOHBYS2wzZHdLRThUaGZW?=
 =?utf-8?B?RkhSOWNjQlB2N0s0YVVPVlVxWmZyVmZxc2g5MlY3UGdNaWVTa3YwR0NTcDNS?=
 =?utf-8?B?ZkN4cCs2eFprZ3cyUG16ZkIyWVI5ZzlhMTZMbkJCZEhKaXNvVU8vZDNDWDVh?=
 =?utf-8?B?bk1QUHFmVXNwUllRdVFJTzFnQ2J6djh5SG5rS2VJNzZwOW1hYy91TklHcnlE?=
 =?utf-8?B?Z3dkeFFJQi84Q1p6SVBhdUovWU1Ha05kVEpsMGtzWEJRRjJHUXpkMXYvNTVk?=
 =?utf-8?B?NTkrc1ZCN0Fjd2tVNXhnL3pWUUZKS1FiZ3NXMkJPNGJYTEs2a3pwMWR0Zm1j?=
 =?utf-8?B?Y0RRMDdMNWw4eHFaRStld1AvOHk0VzY3cFNXT3R4UGRRYmcydmJMcVJUQjNq?=
 =?utf-8?B?K1BybU1YL0VCMFdkMGZ6RVppVURKYnlMUXplbHJRa3dXT0s4cVBMMUVnejIy?=
 =?utf-8?B?NUpCdXd5Z1g2Y3ltbVRRNkR1eEh5ZlR6S2pXdEtxYnhTa0g0dXIrSGdrbnJD?=
 =?utf-8?B?QTI5ZzZqNGlBYjVyTWcyY2NZVk5yaXMvS1VJczV3QjkrbGxlWHZJZGFXNEVx?=
 =?utf-8?B?emlST0drTVVnNndEQlNGb0NRdVZGWjRHZys0OTk2MEZIZDVYRzBRcm5CVlVp?=
 =?utf-8?B?aG5sVElEU2JtK1pjMW1OUmlhZ3F4Q0VpTlM5Vkpkbkx2TFdJN2VZcnJNWkVr?=
 =?utf-8?B?Z0dhVXJHNGM1TVNRVmp6dDVkQm51NkZRUnNPLzRmLzBKQXVHNUdTK3NJZkhw?=
 =?utf-8?B?Vm5KRVZoQ21weTR4MElMS2V3dm9EZlFJbHpac2prZGFpZTFqNDJidWVBVjRO?=
 =?utf-8?B?S3I2dnFzZUtZaERhUTJ4M2Q3NFc5RXFXT3lkLzNtV0dlZW5abk0rUGZRblRD?=
 =?utf-8?B?VitIVUplaUtMWmxxbjN3YmZxbndzQ3VvOWZoSzBhS1AvUDV0L3pLMHhIL1J4?=
 =?utf-8?B?K01NUzdrM3kwem9Ba1dVWjlpZ2wxM0UyS0dNMEY3WUNPSHBUM1NXbHMyR0Vt?=
 =?utf-8?B?cVQ5WHZCQ1NHQnVnQnRqMUFQMzREdHhYaVBZcFo3YmprTWFHMzh0WVJxM2FC?=
 =?utf-8?B?eFlZT0dqTzJzSUZzVHUzc1JkejJJMHArWG9hc3AyNFQ4dDh2ZjFCL3IwcnVi?=
 =?utf-8?B?eHAzdTl0eE1STFZTSU1BRFloV1NkU3FTMG53c2MvWHhMS1EzSnhxM3dNTXA2?=
 =?utf-8?B?UjhVckJRaUxIcVdhenpWMFdmVGxVdWtUVWFGeFRtRTRUWWlYSGZwU2pIS2Fj?=
 =?utf-8?B?MklOK3lFYnlVRWwwUFVYZkVpeDVOdU9uTkJ1SXNsVTFmLzllU1pLN25KVEQv?=
 =?utf-8?B?MUc2ZFRyUzVVamNrTU5DZWtidjRobTlKWGQrZVJaeHdJSUZCSTJGNUhhWXBo?=
 =?utf-8?B?Umt5R2FkUFJYeGdRS0xaTytwZGRHUFpSVGVLZXJRdzVEd1hnSjBFdEFPNURB?=
 =?utf-8?B?T21ESWtUK2hHeXpydzBzdDFGaTZqakNCT21LZWUySFFjVkRzWSt6SG5pYmJI?=
 =?utf-8?B?Um1mZzg5OXVUcmxCWG1ldmVNYWVLekxaVHZ6QVpQTEg4dVZ3K2JpeS9pUjM4?=
 =?utf-8?B?RWl5Y2tnRlBKM01yaThCVGYxUjR1ait4OG1KZGR4MGZKNXNCMFlwNklVU3Nu?=
 =?utf-8?B?UGUzZWlXN0NwejNhSGxvMlVIOEFreWhNT1ljTU16eERvZVpJSXJjVzJmWE9p?=
 =?utf-8?B?T1VZd2ZGRkdlZ0hRcklxN0NYb2FLT0UyVTRhV213NWlJcFVyN0U4clpTSStT?=
 =?utf-8?Q?75xZARiiipElSS331Lbvk3its?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fFF2ldLfweuTrPnJoBDmZ8zYvtpxlA2/cN67FpHAMLNxzWcUvCHPj9cmI/kvTCdgqplk11WW8ZxtQzY5pMSBtbxRrG4uHZRtt6LYbDb66zCfy67WjQEt9r3GKuPGyoWaABa4NhdU/iq7UFO69oqW3yW1DaTrqOim/DzFgQhm/rSEFM0chnHY5uzuqpqenzZHePzp4KYVdSj+RV+d2TiWcMM5rdGbj6Z56MOEzlge2uYVVsWu2D9cuOcq7HP+C5tSX3Xr/UAZB5iYK3aob+3uipul3WlG6abPy2a+r74u+WYkDpX65uN86e/hr+jWX8krcpYkPZa6UuHTJSAAREE5bXQoouKWhVE2tuZtSNKRayQYjByM15yVk8jPIA5cBkY0UHqpqUvwFQXK+9tcLfz8y0cTX48lE6SOCFLbhtrmAtWfsN3yZX4BYr/GiA7hv3I2k2C9sGPplaoQQALhfVJlvwDrSVOepzrFll+59y68aLYzyyNwGOYh/NIUP25xxGQs0UMlRKfs7KlvPbBaJecDq6CM/qmhnScaYYwUG6IGzq++BOW/6lcYpyn0O9lEwQy9XpgeqOrxCi9wI3vyc4wOeO1/iEAzBxL3Hc0qvTXq1auk6Fp43+7hCb5RJ3qP0FWxXm1sEV7jeRi11AO5zwOUsWcMmg00ck6dBGEvgHVZ5IMYIKnDb9oXePpjTU+aVKJgGuKodO0+e+p52+6Z8kSvTHsQkAUNUsCfUeTrBZiExF3tHDNcUspdrYnNICU/y9PkIAyAhaQPG5L8rFe01aYnrF3plD4q97Dpm4nMA46Bl8gd7BvPjvgn+zCUGDGnkvRrDr7uUNxrnd+P+VJP1M9Qig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec937775-8199-42af-8c0b-08dbaa569766
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 19:15:08.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtA3h5RGdgVQ+lwfgJJdSYpXKzmUXGqbm9nlrtr8q3b33naaNsL0lof4fQwh9OWLzZnVEerTOXD3BmAbKXsRkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_17,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310171
X-Proofpoint-ORIG-GUID: 2wTTK6Ini4TgSNsaWKv6TfoOadpRolP5
X-Proofpoint-GUID: 2wTTK6Ini4TgSNsaWKv6TfoOadpRolP5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond, Anna,

Is there anything else you want me to do with this patch?

Thanks,

-Dai

-------- Forwarded Message --------
Subject: 	[PATCH v3 1/1] nfs42: client needs to strip file mode's 
suid/sgid bit after ALLOCATE op
Date: 	Thu, 24 Aug 2023 16:11:47 -0700
From: 	Dai Ngo <dai.ngo@oracle.com>
To: 	trondmy@hammerspace.com, anna@kernel.org
CC: 	linux-nfs@vger.kernel.org



The Linux NFS server strips the SUID and SGID from the file mode
on ALLOCATE op.

Modify _nfs42_proc_fallocate to add NFS_INO_REVAL_FORCED to
nfs_set_cache_invalid's argument to force update of the
file mode suid/sgid bit.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
fs/nfs/nfs42proc.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..9d2f07feeb29 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -81,7 +81,8 @@ static int _nfs42_proc_fallocate(struct rpc_message 
*msg, struct file *filep,
if (status == 0) {
if (nfs_should_remove_suid(inode)) {
spin_lock(&inode->i_lock);
- nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+ nfs_set_cache_invalid(inode,
+ NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
spin_unlock(&inode->i_lock);
}
status = nfs_post_op_update_inode_force_wcc(inode,

-- 
2.9.5

