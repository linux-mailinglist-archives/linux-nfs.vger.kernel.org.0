Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA7572955
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 00:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiGLWbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 18:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiGLWa7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 18:30:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B3BDBA7
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 15:30:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CLED9B009482
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 22:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ohb5dDKs+ho3WSslpP/YrY1tm1inxAJ6tkTc3q33jGw=;
 b=ex9uUhT/+c/tIgpmWESRnZo6zLu1n3PX3Q83G3DQvx6SWoGlFvJJ2JWz2D8GrIX6Fvr/
 RGtx8qXrA2ge734SydPr2yFAfFBkY6rpAn1nok6YRuCeZus94/aSRH95c0Oy3CIOsFer
 D4gmCCIrlwbHyoCZ4PQ7NloizPBGadSCnUgYUYe5rygA8ekBcEVSGoJYCjs+c2M/Jhve
 f0tFWPMR2lL+r/B0q8f/uru4fbpwdL7cdBKCLmqPxEF1xZLUcC2cVOWE/bcNwWvJrYiQ
 nlVLxpwdGcMCKNZLKxgSirN633C4lFVifj13yIB/vIuz+lGlDD9lqo6VtqL95gHHeQBj dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc8hhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 22:30:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CMGQqU002874
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 22:30:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7044bkad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 22:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE64STuLYgcJr6ZDaobptolqf6lUZ7RObHeQ35ZuMHeSG9+9GNLG4Efc0r85E9HjsShOrC6hWUfv8yALzhuskbQCuNC8oqP/3L9gAum5yd0AzKRac8VDYwdD69URgL1w16LXHtp9PMIHwWqf0apa+MHSbzWYmf1lgNRLT92v3YW2CHjeEy0Rg71F/LhIDTuccKEYQnneZgce1LqCV3gX+K+vYN9UZEVpcDrxy18wDKQWKeCxGaUepbufRbLUex+wbfr7LBKnafQEO5dwBjW/NdVIhLw9mHTt9o/Vp/sWIYj9Fcs4cuKDX7MP7oxrK5gbFpgZvjDl7Jl6ZxddyVCUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohb5dDKs+ho3WSslpP/YrY1tm1inxAJ6tkTc3q33jGw=;
 b=Tb04x6C3Eyq5PkTwkiRVkXn6DqYPHQfIRvvNdTrzsQ0dq3E5H8dZHVbU6VZmZY4nCM9PVr/oOK5/InU+994RqyRDUNqLSIhwnj6rm1tNJHCzYOlxzfJYYd1RRZ+BBBEASoQ7qUkopj6xiSPUfQmTZEoIW1guiY0Dg3/odcafZTC/KR4Yz5qAob9TMNefjDyG2dToKlsI4ylLl7rSMH7L+e1AYnsBLctZA7JlVxvM4aUCvD0bh7QDuh9cx+Sdf8E+s09lOUwsg2CteonE9cGYDGfVIkUkmXeRpeYn7bQcDZD+hUxtOm2+yrfQJQQm8GEJWTWYtREvdiumRw98ShBN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ohb5dDKs+ho3WSslpP/YrY1tm1inxAJ6tkTc3q33jGw=;
 b=V/lHd3EmNQtJepsPbvIQmDA424BK5hPlHC+tM9Ae7d0YQbxAMlxdTb4Px/sZivPQ+LyVRPND0Le/hLCOMAkvgGuWWVIqhNpCDK2ksu6+PLith5lMBmWDw1R0WjPpCpVYK4vr+fr2AiM+wrmqc7i9/RJEVQUBDDDpLLDB7AiySPM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 22:30:54 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 22:30:54 +0000
Message-ID: <49904258-a696-387d-f223-d64908d70287@oracle.com>
Date:   Tue, 12 Jul 2022 15:30:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] NFSD: limit the number of v4 clients to 4096 per 4GB
 of system memory
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1657656660-16647-1-git-send-email-dai.ngo@oracle.com>
 <1657656660-16647-3-git-send-email-dai.ngo@oracle.com>
 <D112EBD0-D062-498C-A15F-65A44097AC6B@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <D112EBD0-D062-498C-A15F-65A44097AC6B@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b4c44ae-dbbb-4cb9-911a-08da64562ea7
X-MS-TrafficTypeDiagnostic: CH0PR10MB5180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g91l1lkbIpxrs+/wWYu4cJv2UL+UKpJJqHfG+2x80G6ZjSeW25LdTHu198GYF4uBweInV9AJ1fVKLTbo6HkwPwmallrsIT6IYQMoj+TQHx2rjt0lEOe+hmVhN+cr43CLtc3YhSjo6SHWgbQ4u6MvGXHYmY1Py+qaeCaIDa0YYbbxwZ0t5nAmIswLMyqZk0TvimAtSAymomOoBMxhy37D0egsMJF2qEVxsO6yfh1N23XFT9m/7BAwltKflQ5ELjyqgvqduuAWtV/D5TRFu096q7aROirWKu7I148iH+A7VmQFOKdxAYkLu17GlIL6uW4s/9cS/cjQp6Qr7Dl+iFl4dnZgfIy90dupNNe4PRipyhagHtxbEWH58Qosy5TAMEPkMTlBBaY8RKV2gW5+RyT6RHc4kxhhSjzlYuk90sGgCeIVor3vqGHnAKugUvBi2DIOkdNX1efOkHh0QXZZxaUf/zA5w6NSYxckMFgv6uS1izc1fCmtP1jVWxRfehDiOcktKp57PWea9cIgoSpTgOJHvESRTCaYptR9kwcI8aCKjoPeTsmi9wYZ3ILrM35qbUBIcZPJqYiE7ib9HapADUjMi7gpvz3fzk3ZjSjouiMHEzlgMxEy0eUwLr5xWmk6Dg+xU5iQLyHKmNPrc/8By2n1YnC/xsWfwhxmKFLQZvk/kxYNwOIgrzhphBCl1BSvIV/O1dvlSkH5dFcp3HK+zFcVg0XpNkdlPSJ11fHhWAxlyRx4WnHkYfdUTImzosp6GmxDBVj8TghXNaHv9d/Zt6nmm39PCXmMTp1zZX8I/fA0HwpQA0um1gr91SZsMKR4J7hp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(39860400002)(346002)(396003)(9686003)(316002)(38100700002)(186003)(8676002)(66946007)(37006003)(66556008)(5660300002)(66476007)(31686004)(4326008)(83380400001)(36756003)(6486002)(478600001)(26005)(8936002)(2906002)(6512007)(6666004)(31696002)(53546011)(2616005)(86362001)(6862004)(6506007)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek51M2N3UEZCTTNQbmw2b1d0MkhZaGpoT09NQzh6RE9oRUZKdGJjeUNvNW9l?=
 =?utf-8?B?cEVxeDcrbC9wSjNCRW5SeUlzcEVRMXhaRmlwY3YyUHp5RHRCQ3djYmZPVStm?=
 =?utf-8?B?emFxWncvSVZnbFJUVnEvcVZRdHFxUkU1anRFZGRJNXNVK3JhclBES2pNSkFH?=
 =?utf-8?B?cUFJcVVBclh3dU5xSDBYc2F2eVdQMW00VDlzbEoyMmxFcjZFTHBPNXFiaWZO?=
 =?utf-8?B?K1lyaU82SFZhWEt3WElxWVpXa3B0K0xkN1FsYmxRUmFmRkpsS2VYWGk4K0Rs?=
 =?utf-8?B?MFEvR1JqclZJU1ZSVENJRFR4RXZDZ0pzaTB6bytyaUVjRmZBRUxpR2J4S25W?=
 =?utf-8?B?eUh2SmpFME5zTFFRMDZPLzdaZlU4TlJ4c09sUFZPMEZueGM4THIzZ3pnWnBp?=
 =?utf-8?B?eWdnZ1UxQmZiNm9SbFZCSlZpVjBjVEZyTjFBZ1daUGZUTnorS0I5OHdsM1gz?=
 =?utf-8?B?MWVubmIvN1RaNUQrMmJtYkZYbFF1a29ZOWxPODNsbVQyeHJXVUpqRnc4Yktq?=
 =?utf-8?B?dEFxeFNmWFhsY0ZqK1Iydk1wL29EK1FQRUx3SEl1NzNsak8reGZ1b0NRNWVn?=
 =?utf-8?B?YVBiOFB4Z0wxWUQ3RDlYQmFEVVlxbkFTeGh6cTJ1UlkwQnVWdll6RmorbGhC?=
 =?utf-8?B?cUJvQlpVZW1MQXRaVmZQaTV1cHJPVU8yME1aVGtsWDl5dkMzeWNmWERueTFT?=
 =?utf-8?B?MzlsYW50T2s5MkcrUU91VFZ1aVVWVGZYdG85STdnRFExM3cvQkl5dW9FbVpw?=
 =?utf-8?B?cG0xWFBURi9WUEVmclJKWFYvNUhyeE9ZSHJRSVBlT29mMzRwWVc2L0ozcFZG?=
 =?utf-8?B?WXMrblJTRjJNbkdMWHJYZlJaSnl0Y0F2azhyL05GUmtnVldYRmF3VTZLMDhX?=
 =?utf-8?B?RnVGNHljcG5kNXlKR2hNcnNqUVEvVjZTbWNMSmZ0Z0l4Ri9YUzNOMHJiSXpJ?=
 =?utf-8?B?cWJKTk0yREVKaVFhLzdTTDZuK0NXVXlUaE5SMXczQnBrcUxLa0RnQldsa25J?=
 =?utf-8?B?V21mOTJiZlZtMzAvaWttWk41cFordk5xN1dnYmxkeXFEaXhsR0lnK1dXb0dZ?=
 =?utf-8?B?dS9SNGZsUXo3SFBReSsrUnVFSWRka2VEUDQwQit0cGUyN2lzRmdsdERtdmY1?=
 =?utf-8?B?aE4xaUdJWGxOQnMyTEVPYkdJTEFXSmE5Sjkwd2R6QXk1RG5PQTB2b2YzSkdu?=
 =?utf-8?B?b21OVk1VelBHQW5TYy9YTDhZaHc0a3hCZU5Gem9GTU02VTJYWXJYRmJ1MFpI?=
 =?utf-8?B?bzl4ZHFzVFNrYzllVkdEaWQ5bThRWm1jRFNCam9idHU3WGZDZVdXT0F4RFFy?=
 =?utf-8?B?akx3UVpralNQY2tjV1NyVzQzZkp6UkNlQ01YWENhbFc5SWZ5M08vMzdSRTBB?=
 =?utf-8?B?WWh3OG5vNnhNZ3g4VmxvanNkay9ka1RSUWxpZVZ0RzdUc29VcnFrdWRuN3Bz?=
 =?utf-8?B?cmVBaFFJQjZwdkFrenZEKzRMbDExa3MwR2Q0ZUZ4UTV6SjM5dTgvVUdSaDYr?=
 =?utf-8?B?VFI3bE5ES3FQd1dCcEVVaEdFWkNIa2JFbDdGaDdzUUdaZm05ZjNuYUZqWFVH?=
 =?utf-8?B?MW51T2l1bHAwbzMxZVY3aWpuVUpzeU5IcUx1b2lERXcrSmttU1RFaHV0aDYw?=
 =?utf-8?B?Unk3aXhCcHMwQ2Evczg4dFF0S1FNVDZsTUd0aUV0NkRiQjNkNkRHQ01ESWQ5?=
 =?utf-8?B?VE55OW4vWmpyY0NLTWlWalRqdTNyVU1WTlNnUXpFOFJaWGs4T2NIUVNoWC9G?=
 =?utf-8?B?MW1ocDg2dDcyQnV3Y000RW8xazc4dFI1b3ZzQ3FaQ01aRDJtM2gwRS95bUZC?=
 =?utf-8?B?UHNvSW04ZjY2bGJMVGRZd3hkNWpWMjZFblNHQVo5VEN5RGhHZEFUb3ZLaGxT?=
 =?utf-8?B?Y282cFJMTU9YaUFSRmlJNUxyT0xDRE4wN2NKTlN4Z2loODJXZEtrdTJhM3g4?=
 =?utf-8?B?R0FPRHNSVm9hVUF6WUNuZms0Rjhuak15R2FhMjZsN1ErQ1ZVZG0rTXMyUmxW?=
 =?utf-8?B?TEY0dzVmT0Qybi95STdqYnlCeWNYa3RFdDcvWnRoZzc4QnBNUjNMN2dtbEZx?=
 =?utf-8?B?SjVDRkRiZUZoRFVFY011MnZFQW5YUEVJSlh6MzQ3ZDV5Tm1wb0VRTGpVOS8y?=
 =?utf-8?Q?C/L0/TGDA7PpJxJ+t3yXMwNNC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4c44ae-dbbb-4cb9-911a-08da64562ea7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 22:30:54.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wLxwsnHYsuE3O6bOqRCELQiInHFyieCpONGyz7pfM4cWdUy1ptgpru5/7DeVwJbB/H42TrGZCxYHUudEqPiLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120091
X-Proofpoint-GUID: 0WeMzVFZF0swdKQx6nWGBTVogEAq7prD
X-Proofpoint-ORIG-GUID: 0WeMzVFZF0swdKQx6nWGBTVogEAq7prD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 7/12/22 2:54 PM, Chuck Lever III wrote:
> Hello Dai, lovely to see this!
>
>
>> On Jul 12, 2022, at 4:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently there is no limit on how many v4 clients are supported
>> by the system. This can be a problem in systems with small memory
>> configuration to function properly when a very large number of
>> clients exist that creates memory shortage conditions.
>>
>> This patch enforces a limit of 4096 NFSv4 clients, including courtesy
>> clients, per 4GB of system memory.  When the number of the clients
>> reaches the limit, requests that create new clients are returned
>> with NFS4ERR_DELAY. The laundromat detects this condition and removes
>> older courtesy clients. Due to the overhead of the upcall to remove
>> the client record, the maximun number of clients the laundromat
>> removes on each run is limited to 128. This is done to ensure the
>> laundromat can still process other tasks in a timely manner.
>>
>> Since there is now a limit of the number of clients, the 24-hr
>> idle time limit of courtesy client is no longer needed and was
>> removed.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/netns.h     |  1 +
>> fs/nfsd/nfs4state.c | 17 +++++++++++++----
>> fs/nfsd/nfsctl.c    |  8 ++++++++
>> 3 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index ce864f001a3e..8d72b302a49c 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -191,6 +191,7 @@ struct nfsd_net {
>> 	siphash_key_t		siphash_key;
>>
>> 	atomic_t		nfs4_client_count;
>> +	unsigned int		nfs4_max_clients;
>> };
>>
>> /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 30e16d9e8657..e54db346dc00 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -126,6 +126,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>
>> static struct workqueue_struct *laundry_wq;
>> +#define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
> Let's move these #defines to a header file instead of scattering
> them in the source code. How about fs/nfsd/nfsd.h ?

fix in v2.

>
>
>> int nfsd4_create_laundry_wq(void)
>> {
>> @@ -2059,6 +2060,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>> 	struct nfs4_client *clp;
>> 	int i;
>>
>> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients)
>> +		return NULL;
> So, NFSD will return NFS4ERR_DELAY if it is asked to establish
> a new client and we've hit this limit. The next laundromat run
> should knock a few lingering COURTESY clients out of the LRU
> to make room for a new client.
>
> Maybe you want to kick the laundromat here to get that process
> moving sooner?

Yes, good idea. Fix in v2.

>
>
>> 	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
>> 	if (clp == NULL)
>> 		return NULL;
>> @@ -5796,9 +5799,12 @@ static void
>> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> 				struct laundry_time *lt)
>> {
>> +	unsigned int maxreap = 0, reapcnt = 0;
>> 	struct list_head *pos, *next;
>> 	struct nfs4_client *clp;
>>
>> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients)
>> +		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
> The idea I guess is "don't reap anything until we exceed the
> maximum number of clients". It took me a bit to figure that
> out.

Not sure how to make it more clear, should I add a comment?

>
>
>> 	INIT_LIST_HEAD(reaplist);
>> 	spin_lock(&nn->client_lock);
>> 	list_for_each_safe(pos, next, &nn->client_lru) {
>> @@ -5809,14 +5815,17 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> 			break;
>> 		if (!atomic_read(&clp->cl_rpc_users))
>> 			clp->cl_state = NFSD4_COURTESY;
>> -		if (!client_has_state(clp) ||
>> -				ktime_get_boottime_seconds() >=
>> -				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
>> +		if (!client_has_state(clp))
>> 			goto exp_client;
>> 		if (nfs4_anylock_blockers(clp)) {
>> exp_client:
>> -			if (!mark_client_expired_locked(clp))
>> +			if (!mark_client_expired_locked(clp)) {
>> 				list_add(&clp->cl_lru, reaplist);
>> +				reapcnt++;
>> +			}
>> +		} else {
>> +			if (reapcnt < maxreap)
>> +				goto exp_client;
>> 		}
>> 	}
> Would something like this be more straightforward? I probably
> didn't get the logic exactly right.
>
> 		if (!nfs4_anylock_blockers(clp))
> 			if (reapcnt > maxreap)
> 				continue;

This would not work. If there is no blocker, the client should become
courtesy client if reaping client is not needed. With this logic, when
reapcnt == maxreap == 0 (no reap needed) we still reap the client. If
we change from (reapcnt > maxreap) to (reapcnt >= maxreap) then it
may work. I have to test it out.

> exp_client:
> 		if (!mark_client_expired_locked(clp)) {
> 			list_add(&clp->cl_lru, reaplist);
> 			reapcnt++;
> 		}
> 	}
>
> The idea is: once maxreap has been reached, continue walking the
> LRU looking for clients to convert from ACTIVE to COURTESY, but
> do not reap any more COURTESY clients that might be found.

Right. I'm ok with either logic as long as it works. The clarity of
the logic does not seem much different to me.

>
>
>> 	spin_unlock(&nn->client_lock);
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index 547f4c4b9668..223659e15af3 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -96,6 +96,8 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
>> #endif
>> };
>>
>> +#define	NFS4_MAX_CLIENTS_PER_4GB	4096
> No need for "MAX" in this name.

Fix in v2.

>
> And, ditto the above comment: move this to a header file.

Fix in v2.

>
>
>> +
>> static ssize_t nfsctl_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
>> {
>> 	ino_t ino =  file_inode(file)->i_ino;
>> @@ -1462,6 +1464,8 @@ unsigned int nfsd_net_id;
>> static __net_init int nfsd_init_net(struct net *net)
>> {
>> 	int retval;
>> +	unsigned long lowmem;
>> +	struct sysinfo si;
>> 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> Nit: I prefer the reverse christmas tree style. Can you add
> the new stack variables after "struct nfsd_net *nn ..." ?

FIx in v2.

>
>
>> 	retval = nfsd_export_init(net);
>> @@ -1488,6 +1492,10 @@ static __net_init int nfsd_init_net(struct net *net)
>> 	seqlock_init(&nn->writeverf_lock);
>>
>> 	atomic_set(&nn->nfs4_client_count, 0);
>> +	si_meminfo(&si);
>> +	lowmem = (si.totalram - si.totalhigh) * si.mem_unit;
> There's no reason to restrict this to lowmem, since we're not
> using a struct nfs4_client as the target of I/O.

 From reading the code, my impression is himem is reserved for some
specific usages and the actual available memory does not account
for himem area. Few examples, eventpoll_init, fanotify_user_setup,
etc. These objects are not used for I/O.

>
>
>> +	nn->nfs4_max_clients = (((lowmem * 100) >> 32) *
>> +				NFS4_MAX_CLIENTS_PER_4GB) / 100;
> On a platform where "unsigned long" is a 32-bit type, will
> the shift-right-by-32 continue to work as you expect?

I will try unsigned long long, this would work on 32-bit platform.

>
> Let's try to simplify this computation, because it isn't
> especially clear what is going on. The math might work a
> little better if it were "1024 clients per GB" for example.

I'm not sure how to make it simpler, open for suggestions.

Thanks for your quick review!

-Dai

>
>
>> 	return 0;
>>
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
