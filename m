Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4E64B01C
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 08:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiLMHA0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 02:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiLMHAY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 02:00:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D414D17
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 23:00:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD2L3LK004046;
        Tue, 13 Dec 2022 07:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ESdY2k5f9htXGjsK0dX8cP2OczKUQKA7myHWWIKnrUs=;
 b=qHoe5R54WZTBoD6M66L1uCfC03Y8hfnBcAMUzK9UdbbdZxijBxn/P59CGxuy39/2e1qq
 9U+fWuyWMjtP80+sbzJGUApK5PgmoSM8/PhMjj+vNOX994+TYZ2sls5NJ2HRuyrSncv2
 Vle6tnmzZkcVvu7/o2W6PutDVtpTdwMNeu9Y+pFdMnDBDgZ4M4ky9ofhd/+r7qYuL0ei
 juOboaSGLgcFdmmNrBz1hNh9qbqNhoU3fOFvCTAxK9Q8+6UVSL4sYOq4Eb+/INg3XTJB
 bvrQcDOawLdc54F4w6YNzxnXE8kH/gMSNfxAQq8KkYMD7Dqd9Yr5pJ1oz+v39ykzUHB1 Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcgw2cng2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 07:00:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BD6IxOw018569;
        Tue, 13 Dec 2022 07:00:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjbs216-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 07:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCi9psCpCVmQ5b/E2iRQzVvHrU9+cg+8Mfi8WZF7ZoW4uhutnmzYuaqObRbVHU+0w9vTJOUys1SyQnRZYUcvVcw1/dee2wJ26Zkhyf357vYYMQn26kr5YgpwJqwERFMS1x+3FOJ2+mXXr9yxiW0TNKnPjK9FOgYGsg+shHLt70DEukpO/iXNqeJQ4YCa3wiM9XlabKdDeAa8zaNyLuX7VzildBF1O68xw95o7vj46THBoRslfyrW/4BxSJu5HKuuSzYkc1fb2+vQCiFb8D0GaCXDDrk2kGiYAdE8RBVgubtNBJK8AbAZN2DHAciViP9Vf0f8cGHPR0mwxeeO6gmSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESdY2k5f9htXGjsK0dX8cP2OczKUQKA7myHWWIKnrUs=;
 b=L/sStDUqMAHGOY008BAx0JwQsqtTGUDUOmGd/5mEQzwA7J5cvmU3t4fk+dCaWjOeS2BnYdgnF2hOEtGmLydUfO3z7jKvlwSVGAkFXgajxqSBLRGe6UwHJBqUClyVRy3LI8056sBL4HOqiRLOXBYVhANWpNoKYxr7gMbTlcY5vHrGgFBtUAkUxEeoXarDnI2VLYgskjjaEhoMe/rjsgOpUEpt3MqOZG7XxQ8kS9iDlkb9S3DMTgFWqzHInzPQndb2Y8+YrKgGh7ck0dy7QogaIC0hNMEqX+3xLtsSbc9DhXCiQAVUIpOd4VcTYA0Jm1xnbQRPw3sPAy8eUQRX1gOvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESdY2k5f9htXGjsK0dX8cP2OczKUQKA7myHWWIKnrUs=;
 b=LEEn5nBaA2mlG7lCMq1nLvmQ2ssSyhlDfb+7ws7EfHYTdjQNtg7rUdPXmiYapthLgDARKdSivjL9/7JUzC/pfnL9kMirMPd90emz32K4GeOpTJG8SkFmnhCdzWVO6vLzMondb9CK7ZPIwdPKVg1pL8OxYIXjCHynGc38zV6h2Zs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB4875.namprd10.prod.outlook.com (2603:10b6:610:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 07:00:13 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 07:00:12 +0000
Message-ID: <bdb9f9f5-5c13-44c1-8979-89a7b77afc21@oracle.com>
Date:   Mon, 12 Dec 2022 23:00:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Content-Language: en-US
To:     Xingyuan Mo <hdthky0@gmail.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        linux-nfs@vger.kernel.org, security@kernel.org
References: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
 <CALV6CNPysKmTDmeZds61eKrtmA-yGbj1pQKvxOtfkpF3P5ankw@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CALV6CNPysKmTDmeZds61eKrtmA-yGbj1pQKvxOtfkpF3P5ankw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: f861fb9a-8673-4e97-7ea2-08dadcd7ae34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+u/x8UV0SiC92LOyViM4J7j2vmO8eBF7M6I1tvmtYE714SakLcQ+5Xamg0ZnY2rGL7hrENkUtRECL6zBiHoCVwXbAVerYII72b450FqmD1TLjtKFGG40NrSsbNwDJWFWXGVRRHlQw0TB4mItdveAc95oFSBIHvlo8spBpXsWmL4g7QFsYya0uJDGjDs/8cwMgMt1lDqTJatkGM8N79KECX8YtC2OT5xVhPN+mNgcuaXBLx594Ic3/QnKGS92aG5QFbTpcclQzwKey7QbZm/E/gtN0Bs+M10VmcnqT89YWNrYvaajhdtSZ+k1OYAYjflXZumqJqZSAZpgYQb/i5Hoy1nY8i3IznyPxpCk6H/FjJoKr15XHhA4dsUz8Jg7AcRjJJwLSfZ9WKSAgGp9ge44o+t1dcpI/WJOBOEVYZ3hptFteZDMrzu4MnNJmvGGiwLEcv97xbx/huUH04SwMZF8uZHZh78OjgH1QBSfSxmJr4iBY8M2T1FPTGljPWEq5aD0SQOPllmGMnlr9DfZra6qgwARlJhQ3Ou6ws8fM4JTcipVB5m7JG38uQ/ILY+W9r52eFv0njwEo8kv3iTXPsJ18CylFIA9fuGvoZSR/yn7de2wjhVa39fukKkNu6p6DeAnQmGrG51ZJBFFYU2TmDLGHyplaTwz6w5EIeix/jNxWUbaX2wrlf33+RS3mvFzMgE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(5660300002)(36756003)(2906002)(8936002)(6506007)(6512007)(6916009)(316002)(53546011)(41300700001)(86362001)(478600001)(26005)(31696002)(9686003)(38100700002)(186003)(6486002)(83380400001)(2616005)(31686004)(66556008)(4326008)(8676002)(66946007)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZOM21uRjBoT0ZSLzJrYitqQTAvQ25NME5hbXdlc2wwU2dyZEswMG5mMkpK?=
 =?utf-8?B?SXF4VFhWaVFET1NnaGh5YkJmWkQ0ZG0yc3FxRGwzc1A3eStuOHdxaEZueTU0?=
 =?utf-8?B?eFFXZENJdE5JMlpJQ1dJM3pxSHFJQ2IydDh4REFTMjRhV3d4NU1WZzRRYkJW?=
 =?utf-8?B?QUF5b3FqZTM3MXB3MURFbFZES2F3Z0xySlE3YlZIdE9XVUNsZ256TUdZVnpr?=
 =?utf-8?B?K3NuZ1NaQVFBU2F6aXBMUEErc0hwRlJXbkkrUHZvSHV3bHByMWs4dE1XWkMr?=
 =?utf-8?B?SXA4Rzhvc0czUmUzSVAxZzZJWCtzK1FzUXZqcWMwK1lrS2RDNGNXS3FSbnUw?=
 =?utf-8?B?dlRNbFJuOXRqMHpzMGtUci82QTg5dnkyc2tHZ2EzMjBmTUd3Q25hTnhQV1ls?=
 =?utf-8?B?SmJvVE5ZWDVoS1FhUHlPNis0MXFXOVpGVnNYQWljN0FMTy9kZ2tSdVhPY1Yx?=
 =?utf-8?B?N2l6cDR0OVoyZW5VeDZ2SEdYcjBGOTM3SWMzREMzN3pKYXFVckp5MXpVL2Vz?=
 =?utf-8?B?MExPVWtRaGJWRnB6dXZWd0VLNExhZTJJV2hqdERrMU1keEdkeE1qQVFqSHUr?=
 =?utf-8?B?NTlJdVB0K3hnRUMwaFVjRTFzZlpnVmlvbFdhR3AzRGMyNlVjNnJPMm5BTVJF?=
 =?utf-8?B?MElJVjJ6bDV6eitzZC9iUTk1V09uQVg1VEtCOW51VlZlVGhBTE5Tc3JaNkNF?=
 =?utf-8?B?Z1pkUFJmWDlaTzE2N3VVR2Z6S2p4U3dWTjI1b0FrVW82SlI5VWpOWExyQ0t3?=
 =?utf-8?B?RjBxZXZlWWI2MjNsSnRUNlVRV0I5RUNBUXAzdi8xMThDa0Y1cmVWOVdMbnR0?=
 =?utf-8?B?U3AyenRYaXYxaGx1NWU4Nkxob3llcytCZ29rbitXalFUWHZ3UjRqemFmYjds?=
 =?utf-8?B?TWdncmk1QVhmczV4enpXdWd5ajJRMVVVU0kySkFiT1JyenRiNXdWbm5IcFFM?=
 =?utf-8?B?K0pqRXQ2THkzWEdlaGw5SFIwSTdxZTgyamxteTFKaXhzK3QyQUp4T2l2S1N4?=
 =?utf-8?B?RDN3Z2NRVFptSUkxd0toZzhycDRKc2hDOXZmcmRmMjBvN2tKbFhyOCtvQkpn?=
 =?utf-8?B?U0RKeEZoTDMwSXlEdFFDelN5NUlEVW9wQlJjVnFJdjloMmttaXZacjBJdHQx?=
 =?utf-8?B?RFc1NGd5bXJ2ay82aS84NHJXenFlZDREMFQ1R0M5NXJ6dkhWZnZNSlZDMmpP?=
 =?utf-8?B?NnBhYTkrdDFlN2lzOStpWU9OR0Zxc3ZnWXUvSWl4NVN6QVMxREE0cDByUG1I?=
 =?utf-8?B?Yk51NmFpQTFac2krZDFUS0RQQWlNR2o0NVNScGZidWlTTUlNWmJqekRlWDYx?=
 =?utf-8?B?RVo3WDJYRW9ZTHZZRE9rdmZ3UE90bmx1MEx2T3gyTWtHcHJqdVNVczJXbE02?=
 =?utf-8?B?L0QrZGNGMVV3M2N4c0JhQUgzSE1DeEQ5ZmZ3eFcyWXZFcjJqdlpzQmRJYzc2?=
 =?utf-8?B?T2FRQmxYRFpZNi9qSzROczZBa3lOMTlLOXhjNE1YWEsvSWxQaHk2SDJmZkxE?=
 =?utf-8?B?djdmaGpHNTdVUTdGaExhb0dvaDZpb1pXc1dsMWlxclUwcGdkY3A0U2k2N0s5?=
 =?utf-8?B?cFZ0SWtpUTlLRHl5V0dyOTBZTjBnNERHWEp3SGsyWS9VUFBndzRkbDJBNTNE?=
 =?utf-8?B?R01SSDUwTTkzNlJlVkhETUN2VFJpMS9CZ1ZrRXhZNlljUjhyeWxlMVIwUytC?=
 =?utf-8?B?RGRDQkp2a2RxTTM2ZDFBUmtWS0lCUzhNaExPK3hSd0p4cTl2b0ZlYTRQOE1G?=
 =?utf-8?B?MmZYSkJDcHppL0ZBYXFSd0tyQmxRMUJjMVR6RC9OQ3VLRmhZd3p3dlU5NUJv?=
 =?utf-8?B?bWhONmdOV1dMWnVKcS9PSE83ZTF4NEVmaVNsem1SRkl6WE1aRmRyRlg4T2ZT?=
 =?utf-8?B?bDR1a0Q1YTdsVnR3aDRuVUZtaEM0azlvKzN6S0ZuV0lrQnQvZFA0L1Vnc2Jy?=
 =?utf-8?B?YThUSW5SOGYwdCt2bTVrcGFOWU9tTmhIci9Ic0xpQlZPTWRscDZIMjJieWd4?=
 =?utf-8?B?bDNwNmJIS0ZnTC9lWHB3MFJVa1poZUN4cGJ3RnNMbDBOWkRaZmtFYWY2b21n?=
 =?utf-8?B?cW5SMGFmWGlZK0RiNnhmazBTQkt2eEpDOEwzb0h3bXV1NWJFR29vZnk3MjVL?=
 =?utf-8?Q?yURuwJG+mMI3xyvcXv3cLj0H+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f861fb9a-8673-4e97-7ea2-08dadcd7ae34
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 07:00:12.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge0zu3BsuRs/IaMn/ZNp3dVcFnycVFHGupfykyhDBlh32MmQIVrnc2jF5n6GqPA9hSkDBzZwTtk/9uUnods/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130063
X-Proofpoint-ORIG-GUID: Pl-XuP1V_dvyMKV9VBn8ViXis4k9aYrs
X-Proofpoint-GUID: Pl-XuP1V_dvyMKV9VBn8ViXis4k9aYrs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 12/12/22 7:38 PM, Xingyuan Mo wrote:
> On Tue, Dec 13, 2022 at 6:50 AM Dai Ngo <dai.ngo@oracle.com> wrote:
>> Problem caused by source's vfsmount being unmounted but remains
>> on the delayed unmount list. This happens when nfs42_ssc_open()
>> return errors.
>>
>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>> for the laundromat to unmount when idle time expires.
>>
>> We don't need to call nfs_do_sb_deactive when nfs42_ssc_open
>> return errors since the file was not opened so nfs_server->active
>> was not incremented. Same as in nfsd4_copy, if we fail to
>> launch nfsd4_do_async_copy thread then there's no need to
>> call nfs_do_sb_deactive
>>
>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4proc.c | 20 +++++---------------
>>   1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 8beb2bc4c328..b79ee65ae016 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>          return status;
>>   }
>>
>> -static void
>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>> -{
>> -       nfs_do_sb_deactive(ss_mnt->mnt_sb);
>> -       mntput(ss_mnt);
>> -}
>> -
>>   /*
>>    * Verify COPY destination stateid.
>>    *
>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>   {
>>   }
>>
>> -static void
>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>> -{
>> -}
>> -
>>   static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>                                     struct nfs_fh *src_fh,
>>                                     nfs4_stateid *stateid)
>> @@ -1771,7 +1759,7 @@ static int nfsd4_do_async_copy(void *data)
>>                          default:
>>                                  nfserr = nfserr_offload_denied;
>>                          }
>> -                       nfsd4_interssc_disconnect(copy->ss_mnt);
>> +                       /* ss_mnt will be unmounted by the laundromat */
>>                          goto do_callback;
>>                  }
>>                  nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>> @@ -1852,8 +1840,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>          if (async_copy)
>>                  cleanup_async_copy(async_copy);
>>          status = nfserrno(-ENOMEM);
>> -       if (nfsd4_ssc_is_inter(copy))
>> -               nfsd4_interssc_disconnect(copy->ss_mnt);
>> +       /*
>> +        * source's vfsmount of inter-copy will be unmounted
>> +        * by the laundromat
>> +        */
>>          goto out;
>>   }
>>
>> --
>> 2.9.5
>>
> My test results show that this patch can fix the problem.

Thank you Xingyuan for testing the patch.

-Dai

>
> Regards,
> Xingyuan Mo
