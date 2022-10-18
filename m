Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55660303C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiJRPxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJRPxV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 11:53:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD332D7E0C
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 08:53:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDxiR9000857;
        Tue, 18 Oct 2022 15:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3ZIlOQz8j0dPHvzZDaikuuEhkiKVKcVWhm4WLT4KyRA=;
 b=CCeyiYaLs1iwASfXlzJ/x/3h/rPzYxWlytg/7ctO2fhE9YPFqnUInZsMeKOqBZ4YqlwZ
 6E0E5X6ssM3fIj4XHetmqbdQl64AZ/c4rmyB/sdhltHl0Y45VMNLEernXd5m0hFD+skt
 mZWgOrwNUs6hfz49z3nEC1VewE6IATkXR4DQxNaMTssauFeJP6FWrnV7oC1l8LnYniRf
 pLcF378iQwInBQY0DLhLc4wH8R2HhC6rYsLbr13FTvv9xICW6vjdWf+0jbS0v+N5e9Oj
 w7fD95mqt9GevlSUnkEg4GxOJHr0XpacvDqGYPiFlI3JXAEiAk+wcucEDx9V9jyva4QW 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtfhep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:52:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEtjLI033230;
        Tue, 18 Oct 2022 15:52:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrae6ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYFCmr/aNyzgEEzgTu3vjoJcGZAqCheBDvSVIZtTvN+/zBPx7MjwvkdCz81bSiVkn9l/9Hd9gG9mxhoWzaYRulEBDgQ8DqPukeGBc9BqF7ILdMBPlPLAj18UYIl/4WGVVmQ3JVVfqqlBLgh8K0ugaFC2fGl6oCNBSbqHVALHh1dEeT92ubSxy0/uYXDzdlga3fUuTkJLyvJjvMHStQja12obJ0s1RMLvtXKksvGCg9zFXARaBXAnIns2g8qjjA4DXaupyevVLX69EwcsycyEID4Fv/hAVP0EYsPadGvm0FY76GQ3An9Q6N61MLQqc3eklZH7lQyBnqipWECnNxJBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZIlOQz8j0dPHvzZDaikuuEhkiKVKcVWhm4WLT4KyRA=;
 b=e0Iz0HFKna6RO0kQQidlFXosjIa7GfXakGgILK0AUvqRXg0Z7Y+18m4KzxgbOvtwiZr4RCuyW1CwpdV3dbADZ/4R0t/nE6a4SEMKCzTR3YF1VzYIV51tqbb0uWqbvCmP6JHyIEWfmRdkzE+SwSdc/UfIZsD82jwX0GW56c8uGc4BlTh8NtGNE3Ia3vTTgF2GaTAuLUOYuX06n/Y2z6vXmFJzjrz/Y9duI7TLHN5XcftYQQKRePGXzcDYZ0ZHbiOLNlfhdi9C+SOsXpfNPRiNzPp1k40dKU06DSdX/6sYmyNRrjmk3RTwW4qxmTTtFHONrWycdM8F6b/vbwyM4CvKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZIlOQz8j0dPHvzZDaikuuEhkiKVKcVWhm4WLT4KyRA=;
 b=rB/aeJ8eg2KFSSpXbTSDRJ53Aci7d4ozm/eEMzHzHXUphdtthAnxzVKWYUUd3hPEOesSDs5giy6DpQGW0NexK/pQcVkMSRZcNytJ68s3S4vRQ425kQ0OJW8q3ka+sSR+PmpO/ey9yMpSxNO7WvoY+AJkpEkCq/31+lONVBUOsvI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 15:52:34 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 15:52:34 +0000
Message-ID: <3a63e298-534e-9073-adb3-28ad25a6e596@oracle.com>
Date:   Tue, 18 Oct 2022 08:52:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
 <1666070139-18843-2-git-send-email-dai.ngo@oracle.com>
 <2b3d2faa-c430-b456-f7fb-25dd6273d71a@talpey.com>
 <AD39E6DC-F52D-49A0-8405-7ECB517B64BA@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <AD39E6DC-F52D-49A0-8405-7ECB517B64BA@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6209367a-7f00-4aec-e7a8-08dab120c5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnP2BUsq4qJIkFzSqORi0c6cNh7Mk+5kFkRRjLkiIwDdlrSfrJax3cxrMzDlcTpDtVwDS7LSM0m65UXhRjtgw85F7CrBQf4Av1t4U8WZi0Ap+QlDEMnyBbnNlZsbxjCX8eePfEHu+9uC6UR1zAKBAYnHeWwGvotI9Vb/k394g/V6/P5tEBmSW8FB4Fwb6mJph/p/MsWld/94f16EE3cGNzftkezut4CdU7IPjWkNl6QCukwGtBNzEZ3UXVXwo2372Mj3L/JOBZf7fl8ceDW5n2vGp8XJ/GXPgm24Hg16Fa/5zzVwwqux2Ql03TY0cWERvvHLElMU/85fcGfkji81aDjKaYOP7vPnOTO02py8Yydi/+X0io3K2gfVA096ToSD2Ou6lRwBd0ZxLsWRqeEzFburR/GZ5ZMKD8AnZlNaTJZ79/m8bFwnjU98S9s2IVhRFrmP8bhtL1J0eCAh2+COV/h1Orr52rrrh8NNYfcvawmYiTF9gvrD8TqviVOsVun52l596QaWJHAFKGDHCrhFtOkq5k1+HgDfl1QDyXBXisyF5Oz3UyDSDUcNWrnKO9NdcJED59ptogzCanmmsvLgwmEz2QqlooKOwkTBNy4VGsz36B2i9SDi0XZ38QOI2VRIMlxlCRe8DSUypdNO4QwTkO1BQEeEqpvnEBVb1K69xb4PmqqY2Pr/9K+8U63hAG6hzWcZ1Wsd0woeArUwOiAD0YIR2asoVhgY+d4c1JNA51dbhEWIgBQRDj1VkAT4ALoMBV2t3UqxttCS0xTNOhQDiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(478600001)(5660300002)(83380400001)(36756003)(6486002)(6506007)(66946007)(66556008)(66476007)(4326008)(31696002)(8676002)(8936002)(41300700001)(86362001)(53546011)(6512007)(9686003)(26005)(110136005)(31686004)(2616005)(38100700002)(316002)(186003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FCL04zL1hMQ0xKZE16WitSYW1mN0QwLzYxNnkyam03OWdPN1h1VHVmYjVs?=
 =?utf-8?B?ZlhhaEFjYzF5c1EyWXI2Zy9FbnA0NzI1TTZpc09IeWw2cG9vd3RGaGM5cm1j?=
 =?utf-8?B?MytjNnJlZWVFV2w4cDVYN1UwRkczK01qaVFqZldPdlE0cGlKQTFpb01UYVFD?=
 =?utf-8?B?Y0FvVG9iVS9velFjS2xKYmFnMzQrMURIdXJITTBMYmUvQkE5eDI5Mzcrbkk5?=
 =?utf-8?B?eVEvdlN1ejB1TzcwNjNwVG9RM3dFckllUnVaVjJObkNMbXg5bnpmeE15ZlBG?=
 =?utf-8?B?ejVId1pLWFY5M05GcDVNb3puQ2lTckVsYlF0RXM3K1pZRkpieXpaaDJuZ0Vp?=
 =?utf-8?B?S1ZXck92T1dJa0hrQWpmQVpYRmQxUWxIM3RQS0ZheUZzZnBieXFNNmQvVmtn?=
 =?utf-8?B?T2RTU1VMUjNwSjdUWitVMzFxWkJ4QVJzeEVVR2dhNFZ3K0VhTTYyek5ZOFJQ?=
 =?utf-8?B?R1g5NG5kU0NYVXZVeGRFOFdJd0orYzdRNWRHVUJBZUhoSElHbkJ5VHBORFVO?=
 =?utf-8?B?YzZuUjc1Slh6cWQzdC8vc2tETm9OeXBSWGRwZmpEZjFIQ3g4TURkRVpZQXVm?=
 =?utf-8?B?b2lhUlZzMVpMcHA5dDhFTEpwd2wzclArWW5OdTh0UTJtRFZodHNCY0IrWHpJ?=
 =?utf-8?B?Wm9GTkZWWkpvSVp3VDZqblVhdi9SSXBRTmFiTUh5TWtUc21XcDBtRWxPNVZM?=
 =?utf-8?B?LzVybWpBTjNyNEZqY0t0SmZnOHpoajBLb1BQUmh5U1Bqb25wRENMNWRBM1lo?=
 =?utf-8?B?UmNuWWJiLzVzYmlPUmk3d1JNWmVyYjk2MmJodDdTbHRuYko0aDlZSHdESjI5?=
 =?utf-8?B?QXdLWUtFZnFtRWxUWG5ONXdyOHZjNSt1NFZhL003bG11V3dmVHB5QUJ6bkhX?=
 =?utf-8?B?aXZnd2pIWDhZNnpQRGpybnVoYnBsU2ROeldWdTlReWZlc0tuTUpCdHBTNUZQ?=
 =?utf-8?B?dUtNeTVGTkhRWFQwNm8yNmJFWDU4OVBaL2s2bm4vRmNONnpwOHZtakJpQm0v?=
 =?utf-8?B?YXFTZjkvaWI4SmJuLzZ5NWVJbFZHUEZjN21YT1BjdzY4V3psZGk3ZWVHcFAw?=
 =?utf-8?B?RXBnWE1GanN1NUdHUURUTEtBSEpUa2Jiakp0cHcvMkswZFVUNE1JbC91S0p0?=
 =?utf-8?B?c1ZNUXV1VG1Sc0U1ejJSdUJnSDBQV1BKVFNvcmY1YWxuaE9RU3c4RnR4dHN1?=
 =?utf-8?B?bEJQb29DUkpWZHB6MHc3dmtwMzJYdWJaQzQ2V3NRdm0xTTlLUmswNUMzRGw1?=
 =?utf-8?B?VEloY2dyK203d2huZWhWSUU1eW4zc2h4TEdwWjIyS2pWeGxTVnVUVVR2dERS?=
 =?utf-8?B?RHFDck1mLzdoWmM5NzEwQzBqNWE1ME5SYmFDbkZzM3Y1N1BCdjdNN2tBVEZ6?=
 =?utf-8?B?R09na3lkZUxBMVQrQ2s1dDRRL0NkY0FNTmk1eFJ4aGc3akRvSW9VbDZMeTlj?=
 =?utf-8?B?cHJaemlBQjZPNVhvbEZrTVc0MUlGdExveE50VHR5ckVrR2d6b3BMWml3YWxh?=
 =?utf-8?B?UW40RlJ5UXV2NU5FbXd6a09JNDlHYmRTYnRoUnAyQW1jbHhMS0ZQRXpXa2xv?=
 =?utf-8?B?QjRidU9jdVF0Y1Bxc1Y2OCtDYk1GK0ZEY3FEU2xMTEltOGlUS0hHTDhvdmRs?=
 =?utf-8?B?cHpjN1k5VkdnUXRMU09ldGt5aDFQVTEreTFiMHE1RmxLc0FWb3dURGNUdW1X?=
 =?utf-8?B?dUg2Nm0vOTJIZlIwT25rYzN0UkFpVDE3RU5kQStHYjFqdjI2R0F3TGgwdlM0?=
 =?utf-8?B?L3V0VGU1U0ZrRWNjRHRXSzZEQjRNbXFmeHRxeWl2bTFlcklnUzRxVEEyWU5j?=
 =?utf-8?B?Qm45bUZtZjMvVkF0RllybnFBRVZLWlB0L3BVSUMwNElUZktPdnlLZmxvYVVk?=
 =?utf-8?B?em8vQlBKbCs1WjhEa1d2Ym1BWWI1WFNHeU1KY0g3SDhLcThFV1A3UTk0amtE?=
 =?utf-8?B?cytHd3YxcVV2Y1lFWjRJZHdPMGsrZjY5M0N5OHlpaWo0NURQd0NvcEcxd20w?=
 =?utf-8?B?U29DRlF0OGJJWmlkbmt1dVFuMnJvMGVCaThtM011cklRK3VxSEJ0VWs2aW9P?=
 =?utf-8?B?T2x5RWJEb2F1QmZ0UzIwMkQ4ZGtua2tIR0phVWZLUE11d2hzdmFTTTJnWXla?=
 =?utf-8?Q?eRVT5Dn2fyTnisDRUZM8SRWwx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6209367a-7f00-4aec-e7a8-08dab120c5cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 15:52:34.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGElFRs88wvqj4U8PZj3+t5+jQe3OYPkstx7Qat0Bz23q1kkf4H9yXK1Nnhm5xteFpF6sXYdqX6LozX1TNIyPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_06,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180090
X-Proofpoint-ORIG-GUID: 3oHRdKHRyH3GmlqA-gfjEX6pbPa3rJ14
X-Proofpoint-GUID: 3oHRdKHRyH3GmlqA-gfjEX6pbPa3rJ14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/18/22 7:03 AM, Chuck Lever III wrote:
>
>> On Oct 18, 2022, at 9:25 AM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 10/18/2022 1:15 AM, Dai Ngo wrote:
>>> There is only one nfsd4_callback, cl_recall_any, added for each
>>> nfs4_client. Access to it must be serialized. For now it's done
>>> by the cl_recall_any_busy flag since it's used only by the
>>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>>> then a spinlock must be used.
>> I'm curious if clients have shown any quirks with the operation in
>> your testing. If the (Linux) server hasn't ever been sending it,
>> then I'd expect some possible issues/quirks in the client.
> Is Linux NFSD the first implementation of CB_RECALL_ANY? If other
> servers already have this capability, I would expect clients to
> work adequately.
>
> Of course, if the community doesn't have any unit tests for
> CB_RECALL_ANY... "what's not tested is broken" -- Brian Wong.
>
>
>> For example, do they really start handing back a significant number
>> of useful delegations? Enough to satisfy the server's need without
>> going to specific resource-based recalls?
> I don't think of CB_RECALL_ANY as heroic, it's more of a hint. So
> if a client doesn't return anything, that's not really a problem --
> NFSD is not relying on it, and it certainly does take some time
> before server-side state resources are eventually released.
>
> Another possible use case is for the server to start sending
> CB_RECALL_ANY when a client hits the max per-client delegation
> limit.

Yes, this is what I plan to do once we get the mechanism works
correctly.

-Dai

>
>
> --
> Chuck Lever
>
>
>
