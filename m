Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96225241FF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 03:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349902AbiELBYs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 21:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiELBYr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 21:24:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850A149171
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 18:24:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMP95m024475;
        Thu, 12 May 2022 01:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xc80z/EgWd6vc1owXcfKfaM8a2nkuIzAU2yPAluT4GA=;
 b=BGWlT+q6BiMJ+rNlQvQW9WU9p0vMEaFdQMG1P1ZFUKOQp9xOb8gpvZzHyBFTHu/UiYDo
 eS7VpLXkWQO16DO4sTJJpfPwlFmHjR5Y3yF7AS1A7P91SZVlvBKhEwq4cUe4OAi1C7qx
 1b2I7DziuATtqnUeeBk5KU+CrJdPpVLtuWOfTULqkgvNqC1DtYOwyWYKKK1Zi8koNRTB
 Iju5kx2OGy8j/WNaYhrxHKNC+ubSuriUZNLYXPMy7nh+nWPipSwO8c9F975p9P2vjnsX
 YSkeN+JLXq4eZlJHG+456qFjuPq1g9w1cLH4WuDpMlJyjstmHzNFLpmtPraZCOMEd0Is /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0ucyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 01:24:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24C1KTPB001490;
        Thu, 12 May 2022 01:24:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf74pha1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 01:24:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRdbPL6o4B9fdzVCwh0mSAMYB/duqgC6+m4c5gpNkxtJKPjlh2dmhzfCjlYkNNNpU7tZdErWAUjWaDSGO5j+zPvEVw8Yo+2iIQT8agxEFIlTIcxd7RSRh9OhxRAXDn2ZlojJOFqBbVmf8Bqz1DcLNyK29YcvusCuEXpKUQtpbM5uG7BsO00FY4YfsDvVeSprXZLNUKKsH2vzZS6/AabHNmsnmwLL4pRouKAN1iDaKMJRU4DslP/V1ry0fTlT+Fkmyoe3YyssSw9+PwZTFuPnCAjDNUcdmEvcb+9dvGd8K93D/Nn4jUczLtIOO4wovoQCLD2cK3JLhwAO9/8AHDdWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc80z/EgWd6vc1owXcfKfaM8a2nkuIzAU2yPAluT4GA=;
 b=TySa8xI5hRKP99JeFHd3mslXYjFEdUnimp1WqHDprBxAm29gLe8cgJ/fwk9XPhSOs/aMdA/VAryDzCQoHHQ/L/h1M3qntBUlm/WleX5xY4yQPAQhfOEotYkdEL59AzVUYk6jUurNko3NrqpSfgH+chMiNmij5p9le3Cl7RmqASkQ/micOk0x4CeRDL144Nb4N6KjnVW4lUJERpu2snYsV4fw/6Vb/qH8e8dP4dasZ7aekCOJ2p55BzFRZMCqZsWVL93Iiewj8ti015xFt9TfxhJTTND0Q/BsA/9h06/OXdxC0l6kb2aXYGonQoYa/XbhxekXBeW3FdKmegP49rrpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc80z/EgWd6vc1owXcfKfaM8a2nkuIzAU2yPAluT4GA=;
 b=fbJtwMRhcS4zJCRmEpdYlLC3TpK1now8Qu8y5foz4EaHhgSlP5zjsERMaRtzpnW1/zA6HyCrzMyB+UKQ/v3wM+iwlFRHRPER3QccNSpSjZslPWtSd2+59z0qFwmPC+INcrMaJNXnNTvmORveIp04qUAyh1jpE+HTcyrBpgnFTes=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MWHPR10MB1919.namprd10.prod.outlook.com (2603:10b6:300:10a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 01:24:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::dd6d:626:3df8:680e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::dd6d:626:3df8:680e%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 01:24:37 +0000
Message-ID: <ece7fd1d-5fb3-5155-54ba-347cfc19bd9a@oracle.com>
Date:   Wed, 11 May 2022 18:24:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
 <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
 <2BC5058C-FFEE-4741-9E51-4CC66E7F6306@oracle.com>
 <6942e1963dd3548cb9ba5d8586bd3913beb1ad45.camel@hammerspace.com>
 <342BDD54-5EF0-47BC-8691-E89148B085C1@oracle.com>
 <86cfd1a8afb0a8f68d9bba95c21f04090ebba461.camel@hammerspace.com>
 <FF3D1FC6-12FB-4FAE-B9B9-08AC85437F96@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <FF3D1FC6-12FB-4FAE-B9B9-08AC85437F96@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:5:40::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a87127-0f3d-4e08-0997-08da33b62d93
X-MS-TrafficTypeDiagnostic: MWHPR10MB1919:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1919817A963345A667FAA81887CB9@MWHPR10MB1919.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAnnvxKN0Y+0tQO1QhuMeK7UiCrVPoRwjzSzsMPnMxmXPNwB6WOJ2wvthe2I+BAioVNw91gMOS6Gf349ZgZyfAfw1ey+sJQbAwrb3m2hLK/8G+wmP+GxNj+XQleIwMIO2LFfArRaDG+o8l4jy9AqxbPl5jz+1kN7TyDcOeMtTRrVfDr7bOh6akxThsn7lqyMibjAH/jNqe0o/nkAmcY53YnT6mwQoCTUkEV2O/HnnGbD1S/jNYwvkdJstyqniuPTNYdS8gwQIh6R3OghSEoo7u33zumEuuwv8/0VF43sQVsc9oSJXsOtn/ccVEYTAMdsYRQMO62sv031uaCSRd2QU34tLpvkpKsTPLfu0LPhX4F0YIN/oVs3i8h8w5p7P93BapjgsOzmiZtLca28Do9+92HIqbu8Vq84/zUyEVw20SRsfEF94jx5Y1tXGqFOMMbhtB7iVayhKgfn/RkvWx4bPINoDKSqJAfE8resPu35umpbN2NBfbGDdn2zT6bIkrx6b2qZz0lp5jc8zCfCSGhRlJ41WvrgjTxrHyD33wwjJDINTT3ThqZYZqc/5p5E8rM0+R4V5d5FRJQ/t7WNr29BtmiN6WRJNNs7HDwmFEwlk2kxYuR+lsrMDuA8Y3bHWku8ITj4y2fE2uRVm2FVyydSxEQKXJqwbpglLhh1gb7RfW2J9r7BqM71EpjX8o56hD67d1eI36tvfHbQdpz1SdWe0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(9686003)(45080400002)(508600001)(26005)(6512007)(31696002)(53546011)(186003)(6666004)(86362001)(6506007)(2906002)(5660300002)(30864003)(36756003)(316002)(83380400001)(4326008)(66946007)(66476007)(66556008)(8676002)(38100700002)(31686004)(8936002)(110136005)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9Cank2YndGakg4Y0VzdTZYUjNrRExtWXoySUdhc2lXRWhpeWUrOFNpVytP?=
 =?utf-8?B?ZnhKQ3ZMZ1cyRjZ3Q0dxV3dEZHhPQmNJK0N2Zkl0QmNuRit6ZHFDY2dObHE3?=
 =?utf-8?B?UzJNcmVzYnloUU5zT3UzcjhZRlM0Y0FpZ0NNdzY0aFlNSUpjcnhFdnFqaUpl?=
 =?utf-8?B?a0lXdTErTlJIMUE3RkRpYnpBY2FBcTZLMHA3U0VKSDVUbDRGbnp3VVFXUUNj?=
 =?utf-8?B?U1gzUGZtV2cycWVDZit0RCtNNkpidE5XQUxQSENqS25pYlEvMUZCQkpSVFF4?=
 =?utf-8?B?dHF6WkRPVTR1U1d5TlZuMmVhLzdnTVBUL0xVTURsRkRrVWo2Wk9uVGFBaEl6?=
 =?utf-8?B?K2UvQTZRN3pJK205Y1ovVUZnWWk5bmdkMkpSbzFNLzhpTUFzcjRDTnY2WldH?=
 =?utf-8?B?U2o2OVFHT1pvL3RXK0pabzNNbkFRd2lFaGZpeTJla3M3bldyeWpFeEVnZExP?=
 =?utf-8?B?ZTlnYVVMcEtoVjhURE5NMDIya0xrQ214UUJTMVJaR2FwKzJ4YzhsTC9wdFJ5?=
 =?utf-8?B?ZEpKdTRaY21LSHlBRldwbkNPdEZlSlNoUXBwelNycm5hbFJMM3FDbjU1b0lL?=
 =?utf-8?B?bHJhWnNTeFVBc29hNHdhc2hiUXFpTzdrVXRsQ3pMVW5HZE1kOTUwa3p6eXlv?=
 =?utf-8?B?dk5HRXZERGEwYjd1V2NPalliYW9WU1E5ci9ndDJ5bEVzenZBU013Ukt6MGJU?=
 =?utf-8?B?ZFFoL3NqQVhtMjlyNGV5L01za2ZKZFp2SzVBcnRxV1pLNUVNUDdzby82SWhG?=
 =?utf-8?B?Y01DSms5WkxKcE1hLzZ1RkpxdnZvcmZWZExwMlpOSnlvWkcxTGRYc0d5aVRN?=
 =?utf-8?B?ek9aSmxodHUrVXZKREw0RmtnZEEzTVJoWnp1NDBDUnJSRmFySVg4dm14WWtK?=
 =?utf-8?B?Znp4UytMeElrVGxTdEt5K0xHS0dDWnhkSW9XdzFiYnpocFg1QTFMMllySzNF?=
 =?utf-8?B?SXM0RmI3bDIwQlhob0RUYWNHRUpadDBZdDdNcXZNZHdwRG9nd2tZcSswK1lG?=
 =?utf-8?B?djhPaUtnR0k1bG95eVA1dU9IUXRxVFd1OEl3dTlQY29KdFhCUkRzUVR0SW9i?=
 =?utf-8?B?SmlpSEd0OUdkUFEyK1VpWFJsSEcxalZkclRicm5pQzlXcUlaWkdod3RjSEIz?=
 =?utf-8?B?eE5TWE9tY0syb2FwaWVUdFd3S09yVGlJL3BCRUVhanI5T2IxMmYrdjl0cHcx?=
 =?utf-8?B?dGpLRG9jYWJVbjdnNFVLMFhlRDFYS0tPV0JjTjEvWGVrRE1JeDJjaEIrbkQ4?=
 =?utf-8?B?UnVrVmpEd2VEejhwVFRkVG96YXUyQWdZK1RtaGNUWldvMmxyUmMwUVZCbTAr?=
 =?utf-8?B?TTY4NCs0V01jNklUTjdJSDlMc2xKdERRWEhRQy9JOXlhTUNueFF2TWZWc3Ji?=
 =?utf-8?B?ZndDNWM3TmkxeWhqNFdWWUI1Rm9vZHlBN2hyM1czbVZPNEUrVm41aGd1MDhJ?=
 =?utf-8?B?cHdEK3FHZzFrSVJZcGErL0xEY0VrblRsSVlndWloVXJ3aFpaOG8zZ3doSDIz?=
 =?utf-8?B?TlcxbGlvbnJidU95T01kY0JhSi93c3U2TEVLN3FDZGM1Z3ExdXVteTFiN1JF?=
 =?utf-8?B?a05iNmcvRmxsbVdTaHNsTkpXRmdVY3RwblZXS2cySGxKenhvZy81dUR2TVJ3?=
 =?utf-8?B?RDcwV1RqTE80WlM1aDdiL3ArWjAzc1F4Q3JNZjFHdndFbmxhVWFnQTVPNlhn?=
 =?utf-8?B?UlJoRVdhc2xnYk1CTUVNT1dXRnRsVVBaQW81UGQ3TjBINVNlTlNFazY5SHhw?=
 =?utf-8?B?N1hHVE5tbk5id09ZSHQxeEpTZU1VaDM3NnhCTXA4eTQ2M1l2SDJKd0Zxc1kw?=
 =?utf-8?B?RnpFa0ZVR2FJbm5xNVIrQ2xFWU92Tk9NQTA4cXEyWUloVXFVN2o1SHZOQ2kx?=
 =?utf-8?B?R054WStCK3V6NXFoN29jeTlXaUw5SWphTnJhLzZqUVpNcUdZWE95cWJQK2ZV?=
 =?utf-8?B?ZTlFVURHQlVydzY3WWZDQUJsSnYzR2MyOFpKQlNtenJpYTBlb1V4SUFhLzlK?=
 =?utf-8?B?cVZwUk1INTJlVVQ1bi80QTlqTUJjYVo5RnNQWDBsUXlydU10V1hnanRxZmJU?=
 =?utf-8?B?b0x6LzJBL2JPZGxsZi9qMEtyZ3JUM0lKd2pGVGVXOVI4eG9HY1Boa1pTVHg2?=
 =?utf-8?B?c0xIZVhUaFZ5dXRSMFRWZlREKzJoeVNxWmcyTWFVUllKaDJhUStIVmp1OWN5?=
 =?utf-8?B?SnVHbHpCbGlYN0RheTlRaE5MS0tIc0piUnpCYmRTVk96cVBianl4ak5kVUxi?=
 =?utf-8?B?NTU4NjFqQStWMFo2WjM5YW5sN1FiaGhLY25SWmlObnZHT0Y0N0dlK2g0TlNZ?=
 =?utf-8?B?NUpTcU9RZFo4RzhzQ08zZ1VoVGs1UzFxc2ZaSlRMUXh1OGJZMGEwZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a87127-0f3d-4e08-0997-08da33b62d93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 01:24:36.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiHmUs6/YNNi4jVyON64jj2zVmHrPsWqyWZ5ocz3H8wHdSPvBJzW2d2IGrhzF/oahAaJtpmjMlLH4aHt/KT8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1919
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120006
X-Proofpoint-ORIG-GUID: XEQ5cbwogK8_TV-wsz3jtH1PQgxsRFHj
X-Proofpoint-GUID: XEQ5cbwogK8_TV-wsz3jtH1PQgxsRFHj
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/11/22 11:57 AM, Chuck Lever III wrote:
>
>> On May 11, 2022, at 1:31 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
>>
>> On Wed, 2022-05-11 at 16:27 +0000, Chuck Lever III wrote:
>>>
>>>> On May 11, 2022, at 12:09 PM, Trond Myklebust
>>>> <trondmy@hammerspace.com> wrote:
>>>>
>>>> On Wed, 2022-05-11 at 14:57 +0000, Chuck Lever III wrote:
>>>>>
>>>>>> On May 10, 2022, at 10:24 AM, Chuck Lever III
>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>> On May 3, 2022, at 3:11 PM, dai.ngo@oracle.com wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I just noticed there were couple of oops in my Oracle6 in
>>>>>>> nfs4.dev network.
>>>>>>> I'm not sure who ran which tests (be useful to know) that
>>>>>>> caused
>>>>>>> these oops.
>>>>>>>
>>>>>>> Here is the stack traces:
>>>>>>>
>>>>>>> [286123.154006] BUG: sleeping function called from invalid
>>>>>>> context at kernel/locking/rwsem.c:1585
>>>>>>> [286123.155126] in_atomic(): 1, irqs_disabled(): 0,
>>>>>>> non_block: 0,
>>>>>>> pid: 3983, name: nfsd
>>>>>>> [286123.155872] preempt_count: 1, expected: 0
>>>>>>> [286123.156443] RCU nest depth: 0, expected: 0
>>>>>>> [286123.156771] 1 lock held by nfsd/3983:
>>>>>>> [286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-
>>>>>>> {2:2}, at: nfsd4_release_lockowner+0x306/0x850 [nfsd]
>>>>>>> [286123.156949] Preemption disabled at:
>>>>>>> [286123.156961] [<0000000000000000>] 0x0
>>>>>>> [286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not
>>>>>>> tainted 5.18.0-rc4+ #1
>>>>>>> [286123.157539] Hardware name: innotek GmbH
>>>>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>>>>> [286123.157552] Call Trace:
>>>>>>> [286123.157565]  <TASK>
>>>>>>> [286123.157581]  dump_stack_lvl+0x57/0x7d
>>>>>>> [286123.157609]  __might_resched.cold+0x222/0x26b
>>>>>>> [286123.157644]  down_read_nested+0x68/0x420
>>>>>>> [286123.157671]  ? down_write_nested+0x130/0x130
>>>>>>> [286123.157686]  ? rwlock_bug.part.0+0x90/0x90
>>>>>>> [286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
>>>>>>> [286123.157749]  xfs_file_fsync+0x3b9/0x820
>>>>>>> [286123.157776]  ? lock_downgrade+0x680/0x680
>>>>>>> [286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>>>>> [286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>>>>> [286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>>>>> [286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
>>>>>>> [286123.158088]  check_for_locks+0x152/0x200 [nfsd]
>>>>>>> [286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>>>>> [286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>>>>> [286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>>>>> [286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>>>>> [286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>>>>> [286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450
>>>>>>> [sunrpc]
>>>>>>> [286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>>>>> [286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>>>>> [286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>>>>> [286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
>>>>>>> [286123.159043]  nfsd+0x2d6/0x570 [nfsd]
>>>>>>> [286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>>>>> [286123.159043]  kthread+0x29f/0x340
>>>>>>> [286123.159043]  ? kthread_complete_and_exit+0x20/0x20
>>>>>>> [286123.159043]  ret_from_fork+0x22/0x30
>>>>>>> [286123.159043]  </TASK>
>>>>>>> [286123.187052] BUG: scheduling while atomic:
>>>>>>> nfsd/3983/0x00000002
>>>>>>> [286123.187551] INFO: lockdep is turned off.
>>>>>>> [286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl
>>>>>>> lockd
>>>>>>> grace sunrpc
>>>>>>> [286123.188527] Preemption disabled at:
>>>>>>> [286123.188535] [<0000000000000000>] 0x0
>>>>>>> [286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded
>>>>>>> Tainted: G        W         5.18.0-rc4+ #1
>>>>>>> [286123.190233] Hardware name: innotek GmbH
>>>>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>>>>> [286123.190910] Call Trace:
>>>>>>> [286123.190910]  <TASK>
>>>>>>> [286123.190910]  dump_stack_lvl+0x57/0x7d
>>>>>>> [286123.190910]  __schedule_bug.cold+0x133/0x143
>>>>>>> [286123.190910]  __schedule+0x16c9/0x20a0
>>>>>>> [286123.190910]  ? schedule_timeout+0x314/0x510
>>>>>>> [286123.190910]  ? __sched_text_start+0x8/0x8
>>>>>>> [286123.190910]  ? internal_add_timer+0xa4/0xe0
>>>>>>> [286123.190910]  schedule+0xd7/0x1f0
>>>>>>> [286123.190910]  schedule_timeout+0x319/0x510
>>>>>>> [286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
>>>>>>> [286123.190910]  ? usleep_range_state+0x150/0x150
>>>>>>> [286123.190910]  ? lock_acquire+0x331/0x490
>>>>>>> [286123.190910]  ? init_timer_on_stack_key+0x50/0x50
>>>>>>> [286123.190910]  ? do_raw_spin_lock+0x116/0x260
>>>>>>> [286123.190910]  ? rwlock_bug.part.0+0x90/0x90
>>>>>>> [286123.190910]  io_schedule_timeout+0x26/0x80
>>>>>>> [286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
>>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.190910]  ? wait_for_completion+0x330/0x330
>>>>>>> [286123.190910]  submit_bio_wait+0x135/0x1d0
>>>>>>> [286123.190910]  ? submit_bio_wait_endio+0x40/0x40
>>>>>>> [286123.190910]  ? xfs_iunlock+0xd5/0x300
>>>>>>> [286123.190910]  ? bio_init+0x295/0x470
>>>>>>> [286123.190910]  blkdev_issue_flush+0x69/0x80
>>>>>>> [286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
>>>>>>> [286123.190910]  ? bio_kmalloc+0x90/0x90
>>>>>>> [286123.190910]  ? xfs_iunlock+0x1b4/0x300
>>>>>>> [286123.190910]  xfs_file_fsync+0x354/0x820
>>>>>>> [286123.190910]  ? lock_downgrade+0x680/0x680
>>>>>>> [286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>>>>> [286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>>>>> [286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>>>>> [286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
>>>>>>> [286123.190910]  check_for_locks+0x152/0x200 [nfsd]
>>>>>>> [286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>>>>> [286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>>>>> [286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>>>>> [286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450
>>>>>>> [sunrpc]
>>>>>>> [286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>>>>> [286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>>>>> [286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>>>>> [286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
>>>>>>> [286123.190910]  nfsd+0x2d6/0x570 [nfsd]
>>>>>>> [286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>>>>> [286123.190910]  kthread+0x29f/0x340
>>>>>>> [286123.190910]  ? kthread_complete_and_exit+0x20/0x20
>>>>>>> [286123.190910]  ret_from_fork+0x22/0x30
>>>>>>> [286123.190910]  </TASK>
>>>>>>>
>>>>>>> The problem is the process tries to sleep while holding the
>>>>>>> cl_lock by nfsd4_release_lockowner. I think the problem was
>>>>>>> introduced with the filemap_flush in nfsd_file_put since
>>>>>>> 'b6669305d35a nfsd: Reduce the number of calls to
>>>>>>> nfsd_file_gc()'.
>>>>>>> The filemap_flush is later replaced by nfsd_file_flush by
>>>>>>> '6b8a94332ee4f nfsd: Fix a write performance regression'.
>>>>>> That seems plausible, given the traces above.
>>>>>>
>>>>>> But it begs the question: why was a vfs_fsync() needed by
>>>>>> RELEASE_LOCKOWNER in this case? I've tried to reproduce the
>>>>>> problem, and even added a might_sleep() call in
>>>>>> nfsd_file_flush()
>>>>>> but haven't been able to reproduce.
>>>>> Trond, I'm assuming you switched to a synchronous flush here to
>>>>> capture writeback errors. There's no other requirement for
>>>>> waiting for the flush to complete, right?
>>>> It's because the file is unhashed, so it is about to be closed and
>>>> garbage collected as soon as the refcount goes to zero.
>>>>
>>>>> To enable nfsd_file_put() to be invoked in atomic contexts again,
>>>>> would the following be a reasonable short term fix:
>>>>>
>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>> index 2c1b027774d4..96c8d07788f4 100644
>>>>> --- a/fs/nfsd/filecache.c
>>>>> +++ b/fs/nfsd/filecache.c
>>>>> @@ -304,7 +304,7 @@ nfsd_file_put(struct nfsd_file *nf)
>>>>>   {
>>>>>          set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>>>>          if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0) {
>>>>> -               nfsd_file_flush(nf);
>>>>> +               filemap_flush(nf->nf_file->f_mapping);
>>>>>                  nfsd_file_put_noref(nf);
>>>>>          } else {
>>>>>                  nfsd_file_put_noref(nf);
>>>>>
>>>>>
>>>> filemap_flush() sleeps, and so does nfsd_file_put_noref() (it can
>>>> call
>>>> filp_close() + fput()), so this kind of change isn't going to work
>>>> no
>>>> matter how you massage it.
>>> Er. Wouldn't that mean we would have seen "sleep while spinlock is
>>> held" BUGs since nfsd4_release_lockowner() was added? It's done
>>> at least an fput() while holding clp->cl_lock since it was added,
>>> I think.
>>
>> There is nothing magical about using WB_SYNC_NONE as far as the
>> writeback code is concerned. write_cache_pages() will still happily
>> call lock_page() and sleep on that lock if it is contended. The
>> writepage/writepages code will happily try to allocate memory if
>> necessary.
>>
>> The only difference is that it won't sleep waiting for the PG_writeback
>> bit.
>>
>> So, no, you can't safely call filemap_flush() from a spin locked
>> context, and
>> yes, the bug has been there from day 1. It was not introduced by me.
>>
>> Also, as I said, nfsd_file_put_noref() is not safe to call from a spin
>> locked context. Again, this was not introduced any time recently.
> OK. I'm trying to figure out how bad the problem is and how
> far back to apply the fix.
>
> I agree that the arrangement of the code path means
> nfsd4_release_lockowner() has always called fput() or
> filemap_flush() while cl_lock was held.
>
> But again, I'm not aware of recent instances of this particular
> splat. So I'm wondering if a recent change has made this issue
> easier to hit. We might not be able to answer that until we
> find out how the bake-a-thon testers managed to trigger the
> issue on Dai's server.

I'm able to reproduce this problem with unmodified 5.18.0-rc6
by enhancing the pynfs st_releaselockowner.py to remove the
file before sending the RELEASE_LOCKOWNER.

Here is the diff of the test:

[root@nfsvmf25 pynfs]# git diff nfs4.0/servertests/st_releaselockowner.py
diff --git a/nfs4.0/servertests/st_releaselockowner.py b/nfs4.0/servertests/st_releaselockowner.py
index ccd10fff3ffa..a32f8ed70634 100644
--- a/nfs4.0/servertests/st_releaselockowner.py
+++ b/nfs4.0/servertests/st_releaselockowner.py
@@ -19,8 +19,12 @@ def testFile(t, env):
      res = c.unlock_file(1, fh, res.lockid)
      check(res)
      
+    ops = c.use_obj(c.homedir) + [op.remove(t.word())]
+    res = c.compound(ops)
+    check(res)
  
      # Release lockowner
      owner = lock_owner4(c.clientid, b"lockowner_RLOWN1")
      res = c.compound([op.release_lockowner(owner)])
      check(res)
[root@nfsvmf25 pynfs]#

Here is the stack traces of the problem:

May 11 18:11:54 localhost kernel: BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1513
May 11 18:11:54 localhost kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4234, name: nfsd
May 11 18:11:54 localhost kernel: preempt_count: 1, expected: 0
May 11 18:11:54 localhost kernel: RCU nest depth: 0, expected: 0
May 11 18:11:54 localhost kernel: INFO: lockdep is turned off.
May 11 18:11:54 localhost kernel: Preemption disabled at:
May 11 18:11:54 localhost kernel: [<0000000000000000>] 0x0
May 11 18:11:54 localhost kernel: CPU: 0 PID: 4234 Comm: nfsd Kdump: loaded Tainted: G        W         5.18.0-rc6 #1
May 11 18:11:54 localhost kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
May 11 18:11:54 localhost kernel: Call Trace:
May 11 18:11:54 localhost kernel: <TASK>
May 11 18:11:54 localhost kernel: dump_stack_lvl+0x57/0x7d
May 11 18:11:54 localhost kernel: __might_resched.cold+0x222/0x26b
May 11 18:11:54 localhost kernel: down_write+0x61/0x130
May 11 18:11:54 localhost kernel: ? down_write_killable_nested+0x150/0x150
May 11 18:11:54 localhost kernel: btrfs_inode_lock+0x38/0x70
May 11 18:11:54 localhost kernel: btrfs_sync_file+0x291/0x1020
May 11 18:11:54 localhost kernel: ? rcu_read_lock_bh_held+0x90/0x90
May 11 18:11:54 localhost kernel: ? lock_acquire+0x2f1/0x490
May 11 18:11:54 localhost kernel: ? start_ordered_ops.constprop.0+0xe0/0xe0
May 11 18:11:54 localhost kernel: ? find_any_file+0x64/0x100 [nfsd]
May 11 18:11:54 localhost kernel: ? nfsd_file_put+0x100/0x100 [nfsd]
May 11 18:11:54 localhost kernel: nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
May 11 18:11:54 localhost kernel: nfsd_file_put+0x79/0x100 [nfsd]
May 11 18:11:54 localhost kernel: check_for_locks+0x152/0x200 [nfsd]
May 11 18:11:54 localhost kernel: nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
May 11 18:11:54 localhost kernel: ? lock_downgrade+0x680/0x680
May 11 18:11:54 localhost kernel: ? nfsd4_locku+0xd10/0xd10 [nfsd]
May 11 18:11:54 localhost kernel: ? rcu_read_lock_bh_held+0x90/0x90
May 11 18:11:54 localhost kernel: nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
May 11 18:11:54 localhost kernel: ? rcu_read_lock_held_common+0xe/0xa0
May 11 18:11:54 localhost kernel: nfsd_dispatch+0x4ed/0xc30 [nfsd]
May 11 18:11:54 localhost kernel: ? svc_reserve+0xb5/0x130 [sunrpc]
May 11 18:11:54 localhost kernel: svc_process_common+0xd8e/0x1b20 [sunrpc]
May 11 18:11:54 localhost kernel: ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
May 11 18:11:54 localhost kernel: ? nfsd_svc+0xc50/0xc50 [nfsd]
May 11 18:11:54 localhost kernel: ? svc_sock_secure_port+0x36/0x40 [sunrpc]
May 11 18:11:54 localhost kernel: ? svc_recv+0x1100/0x2390 [sunrpc]
May 11 18:11:54 localhost kernel: svc_process+0x361/0x4f0 [sunrpc]
May 11 18:11:54 localhost kernel: nfsd+0x2d6/0x570 [nfsd]
May 11 18:11:54 localhost kernel: ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
May 11 18:11:54 localhost kernel: kthread+0x29f/0x340
May 11 18:11:54 localhost kernel: ? kthread_complete_and_exit+0x20/0x20
May 11 18:11:54 localhost kernel: ret_from_fork+0x22/0x30
May 11 18:11:54 localhost kernel: </TASK>

-Dai

>
>
>>>> Is there any reason why you need a reference to the nfs_file there?
>>>> Wouldn't holding the fp->fi_lock be sufficient, since you're
>>>> already in
>>>> an atomic context? As long as one of the entries in fp->fi_fds[] is
>>>> non-zero then you should be safe.
>>> Sure, check_for_locks() seems to be the only problematic caller.
>>> Other callers appear to be careful to call nfsd_file_put() only
>>> after releasing spinlocks.
>>>
>>> I would like a fix that can be backported without fuss. I was
>>> thinking changing check_for_locks() might get a little too
>>> hairy for that, but I'll check it out.
> Notably: check_for_locks() needs to drop fi_lock before taking
> flc_lock because the OPEN path can take flc_lock first, then
> fi_lock, via nfsd_break_deleg_cb(). Holding a reference to the
> nfsd_file guarantees that the inode won't go away while
> check_for_locks() examines the flc_posix list without holding
> fi_lock.
>
> So my first take on this was we need nfsd4_release_lockowner()
> to drop cl_lock before check_for_locks() is called.
>
>
> --
> Chuck Lever
>
>
>
