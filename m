Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B179D58709C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiHASzT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiHASzQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 14:55:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DBFBB6
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 11:55:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271HsBNL019281;
        Mon, 1 Aug 2022 18:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5rv8tV2O80Qrpk+mvIXngTMJZzbvpfinOVANmmOkqm4=;
 b=E5kIX8dQg6X7zkfmMtD51QsStJQ9rOZ9kHptyl50H1pH2vkXaiVk9BHujw5IZSEHFps0
 zVLCS/zIKMtSOBfKxgNsLO3wIU6OpnDhUZ+I15sxt6u2whFGbV5qABhEb7hAfYIPYxSN
 /6pqX56cTUNQgQVuLznfe+hE7O16c3c0D5IPO1FZmLGcZNh2ln61j0FNXzEAPG+mt32+
 4Vj48Te4+JX24v7SLNbQV8XzBaSRenXpok5pCCmFwOp5tn9pNIy0CNkXUcjI0behqIlx
 VI0l2UqMHB33IOW0kCJN8+P6UQpsRu+zdQnB5IOJ0hkKLsFIMaW3RG+HncvY3r+4TNhN NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9mgrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 18:55:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271I7dui010754;
        Mon, 1 Aug 2022 18:55:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31hq1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 18:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsQVBs5R3p+XzV+tyP+viZKb49FRe4427krQw9lu0Y7wIQgLLG4sc03q5yvJOaLFch5wnFO3FlYn5JGeE8nZRa6SRf8Zcf3VQh0SR2+qdyxBczJJCMgP6kNx1BQ3PpaimoiC8c7ZZuCzL+AjJGHgBRDx9L5i4tpvWyRMHqOPGU4fP2ZiZ6mrethrUBFZwshsT274S4fOqlJutJJWX/u6v1a/i2OcIhcUL4GQuuWdumZ7WA/bibmvB4hTcLjShgcn2Z56ycPLUliGm7z0VRiLLbGQgXd8EhIke8YdU1JuIkXqpoiJtA4JzgfPmFFGOH7lFmIPfi4oYkcFB4o3c5DNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rv8tV2O80Qrpk+mvIXngTMJZzbvpfinOVANmmOkqm4=;
 b=KK4Y6nY/BVlJNHaZYwviLtB7XBVFKtHm+wIASK1YrHdAJURXH8yevhbsL3sDSLZ6ywMDCAZ7TCbOg+wIJHSoZeDbGT2ykC3mXsWsXToBOzEgf7rf/xRu2/0BxcpupYrfvrShY6MztYe75bkD/v6598+fOX4f/cKi2uxv3i69UyfowGmdmuMDjXXUoA2yKMau7hgyjiYeq4gUgmNoX5hMrK7CIOjKJFQRmkOZJ8RuwaPNdOvq4RqDG0+GxW2k0+re++bGNyNQkCawlr1f2TfiaIjDH8yrpM9NzmlWz1ZQ3Cjlo8Gk7+3PvxOuVvLCBd97xlh1sNjssDgssgXnCpLxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rv8tV2O80Qrpk+mvIXngTMJZzbvpfinOVANmmOkqm4=;
 b=ZDXAeQkZVzqpM55T6h99jtoOfUpfkpWsZoAstujXWx6ECHSFwf9OHP2O3SbHHcJspVO2lrg5+13kQO7089PqBd3l3Rn5iih2y1lheSWile2H/B/zYbcyQCL25Ffet6CG+GjJnZ348GZ4wWr7eLDFyRqFPVbopTf8dAcJjs0TM18=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN6PR10MB1746.namprd10.prod.outlook.com (2603:10b6:405:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 18:55:09 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 18:55:09 +0000
Message-ID: <48da33f3-327d-7144-f967-84f063417b0a@oracle.com>
Date:   Mon, 1 Aug 2022 11:55:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
 <37585D43-78F3-4132-8ADF-D11BD11DDCD4@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <37585D43-78F3-4132-8ADF-D11BD11DDCD4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:5:bc::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01085af2-3be1-4a4d-7044-08da73ef5987
X-MS-TrafficTypeDiagnostic: BN6PR10MB1746:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHVLSNkflacWs6tytcxoPWuWA7m8pFrNDkdd/43bBO4Q2daNqCJ2aUaIVdy+e5FDnRNbiRv+XtMovHSmsA4OasSnAs1ucTPkzcZxestv/JNHgRdKGlCj3Lky1ttOXXnF07umvkRpcVEac1i4TM5AkuIhhY1HMpk6Hro4BEJSx5xZQlibgwjTd1dll9UkVK/xAROzLKH9wTAMZvgsTiKxR3UBcmvtZ63vhPIG1Ts7Rhx2l5/kjGwAoQXMAkAll7I3thJ0nvMUtOhB3LQTPoSjgG1qrL9oD6GwtQh5I1nbmpGFrE41bWpxUfQJlCii8lofvxXrYLGjaH/G+p9j/7A6MPxKrqE7IrQV5904Jm3YZ7vHLVcbpEzXi0Th0mrkJIrzPEVIKrmINUFrRyZTWsNca9Mr6/USCIElz4gpJbzbHBQq/RQkCBakdUaIXpy32d+ZgbGPHeqROG1fdi9aeftg9/4I7ENlZBj5ZESJs3Mg92MuZ3diYBeIpPpAC6n6JG03aXAkoS439C8nkwXXMpuj4sAWBw8Ei2+mbWayQUb9Ho+/vRtEqpZvOZCemly2ASItYY2JpqEU1wni3k/y0TwRflt4X7Yke+FSYTM0eRtI89mhNY2QPB7yQmAAKLQWRGDfrTM2JyXWldEaf7KmOETVt9SeiInGjtwdUbw6s7L108D/oJsirmpiqvZ4VeH2DTumziMNP92OLfPSg5UaOEdYYvNoO1OvlogQ8wqRzRKSMmrCl6OA5clWmZDzkwYF3ScLWmPE+ohjpFBjCfgA9lFIK6pmNPo0SGMNklJ7mhzEVpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(478600001)(6862004)(8936002)(186003)(6486002)(5660300002)(9686003)(6666004)(31696002)(6506007)(26005)(6512007)(86362001)(2616005)(53546011)(41300700001)(83380400001)(2906002)(316002)(37006003)(36756003)(54906003)(8676002)(4326008)(38100700002)(31686004)(66946007)(66476007)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdkWFJwc1IvRW5KVVVRdHlPa3Q3V1o4ay9wWWZzVlFHczY2UGFnZUwzaHd1?=
 =?utf-8?B?MmJEUkZwcEtNUUJLemNVRG9aQ2QxZEZ2Zit0NHgzQUFSWEt1bWJvZUUrT1Iw?=
 =?utf-8?B?K01CbkFjUmlMNnFHeXVOVWR6UWlvZTVCRVhDclM3NHM0NC84Rmd2YnJFcEpN?=
 =?utf-8?B?YTVFLzlXYy9OcGdJamNGNldYMCtkWFBIcmE1UW00SnNrZkxRbUVNTDdEVlhu?=
 =?utf-8?B?cmNKMXg1N2lzbzluc0V1WkplS2YvYTljYWpTTENzN1lmQ0YvYXZqZUg1aEJR?=
 =?utf-8?B?ZFZjNnlRSER0QUE3THFnOU5yeFpCbnJGbzZoMysyMzFtZGpCU3h4bEtaU1Vn?=
 =?utf-8?B?UndXcHg2M2hJYTVZd0w2VFlhTjliTk95MWN1MmZPVW1Rc0NCc25YTGJNb1N0?=
 =?utf-8?B?Yy9RL0ZpZW1TT1pXV0dLaHVyVmRkOE16Tit0NmQ4czZpVmNWem80TE51SHVk?=
 =?utf-8?B?a05KRTY3cE0zbE5uU2ZHOU15VGpIQ2tRMnNFUUlSRm1lL0xVdy9oYkUzZk5K?=
 =?utf-8?B?Y1NTdmRydm1mRkgxK1V6Q0N2SFgxSHF3R0RTMWIwVmZIYmlVMksxTlZOV0xC?=
 =?utf-8?B?SENvWW9pNFEvK1Q3dzR2K1hzR21teFV1V2I4V1A1NzJOSEZrU2YzdHFMeXZy?=
 =?utf-8?B?TzdzNVR0VUZkWVRaQWZpT3lWbTNXc2VtUFNEaU43cWVlQW1aMmJ6RHIrUUJK?=
 =?utf-8?B?RjJrUk02OExFUEtQRkNGVnNHYnVuNkpzbGl2WGc4TzF4aDEwblRNVTBtUzdy?=
 =?utf-8?B?UzJJREhiNHAvOTd6cDVVcUJuYmh6N3drMDJxRG9ad2lUcmlHUkExaWJkUW85?=
 =?utf-8?B?aHV5WlZaSzBKc3o5N0JaMFUrejRMNVYrNnovZTJJb0ZoRFZxdVV1UG5MeEFz?=
 =?utf-8?B?cG1ZOVpSVndoUWV2dHV6VUdxNmFQSEcrOXh6bzUzV3NIZE1pUzFIRy9hajhE?=
 =?utf-8?B?K3ZDYkNoQmM2dWc3elV4MVpOWU1UdjNnd0tzY0pQbkE2NWJnQUFUWE9ENTRX?=
 =?utf-8?B?elVnU01sWlhTWmRUVml1ZE1nd3RDMVEvL0lRR2FKbDJYREI1WEswWGdnL1c2?=
 =?utf-8?B?UjlHa2xGNEFxWlNKcWE1dE1tYW1yeXAraFFLeWw2N1QybDR3U2NPM2c0QXZ1?=
 =?utf-8?B?K2VqaTA1ZkJvK0IxYzRKWXorelBVbGxrQkVWaTRlWmpEVVFRb2o3OExFMHgw?=
 =?utf-8?B?MXBZb2NBRXUza25wR29KL3hlMENMdUlESFQrZXZZR1huQmpxTTBEQTZnbXd3?=
 =?utf-8?B?dHJZbFZnRXpidmMyN0xUN2VuQ2hObUxwc1BGSWg0bGlXcFFqWVFuNHpuaGJP?=
 =?utf-8?B?aERGc0R1TTh6M2ZiZllJbHdkeDZjZ2xpZWFqcHZRaFFudGZaRHpnWnlSSlc2?=
 =?utf-8?B?QXc3cmVNdURHUnZhakQxc0J4NFBlaHdlb2M1REMzbWdHVDNSK3NkM3Z5aXdn?=
 =?utf-8?B?emgvbDlFTXZ3UDdmZ2x6anpFSGVkdysxZ2p3bmtpMlRXRG9Pc0RtWmZTbnkv?=
 =?utf-8?B?R1BRcW1KNjNpTUtzUmVIT3JXRGN4Qzd5TTNJVnkvR0lHdVZiUGtkMXdLQ2sv?=
 =?utf-8?B?RkpOQm9Fb0tpK3dKVkg2ek9ITDNHSmNVZU16amU1Wlo4N2REUWNLYXhMZTZw?=
 =?utf-8?B?VW9vMzRKWDZyVndrVSsvekJWeUpWU1VGMGpGZlRwL05GY3pzbDVwTXZ0eXM0?=
 =?utf-8?B?bUVDS0FERUdQb3hJWmJuWFBuYmxjcFJQaHc0bGxQSkpZS1BqZTcrSWVRU1pZ?=
 =?utf-8?B?bWg0UG1VUHdVczdPSTV3dlVVQnhBSVRoNnVPN003VEdlQWswL0NsK0ZKbXY5?=
 =?utf-8?B?ak5YNE5MRisxYnk3U3JKcXNySEJzS1hyZHE4ejR6b0pGTkE1VnpLU211UVlZ?=
 =?utf-8?B?T3hTSGJsOHFpamdtbWdGQXY0ejRGOFZTQkYvWHd4eUtvWThZRkZWbEtlMjdC?=
 =?utf-8?B?bzBaLzRIQ2FOR1A2QUlVSUo3YS9ISFh1c3NJQU5mZ2h6VzFlM0l2b1FGMjFq?=
 =?utf-8?B?R1ZuYjRwL1NLZndCZlF5bHJmbVdPZC83VHFGOUdlVDdiQzhUemZ5bHliQ0Ey?=
 =?utf-8?B?N2xnT0lKSUc1RDdNVnREK0k4SHU2Z2RjMUxYMkhKekJsTm1RYmIzUWp5aVVD?=
 =?utf-8?Q?llHjM1/qgYpDYeoT9+iWSuzbj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01085af2-3be1-4a4d-7044-08da73ef5987
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 18:55:09.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahFAeXf50uIteqCJcfzCCgix6b+gfpdP2jbqXVHdpwpbsQTrq+5cXfpf1BtqXHjneI/yyAL07AWojAuWlUHBWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010094
X-Proofpoint-ORIG-GUID: ucZRNH5x1O-zfN2FGADhPaQ2SaqiRMs0
X-Proofpoint-GUID: ucZRNH5x1O-zfN2FGADhPaQ2SaqiRMs0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/1/22 9:29 AM, Chuck Lever III wrote:
>
>> On Jul 31, 2022, at 4:19 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Use-after-free occurred when the laundromat tried to free expired
>> cpntf_state entry on the s2s_cp_stateids list after inter-server
>> copy completed. The sc_cp_list that the expired copy state was
>> inserted on was already freed.
>>
>> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
>> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
>> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
>> from the s2s_cp_stateids list before freeing the lock state's stid.
>>
>> However, sometimes the CLOSE was sent before the FREE_STATEID request.
>> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
>> frees all lock states on its st_locks list without cleaning up the copy
>> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
>> server returns BAD_STATEID since the lock state was freed. This causes
>> the use-after-free error to occur when the laundromat tries to free
>> the expired cpntf_state.
>>
>> This patch adds a call to nfs4_free_cpntf_statelist in
>> nfsd4_close_open_stateid to clean up the copy state before calling
>> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> I'm interested in Olga's comments as well, so I'm going to
> wait a bit before applying this one.
>
> Also, did you figure out where this crash started to occur?
> I'd like to have a precise sense of whether this should be
> backported.

I think this started with the commit 624322f1adc58 to introduce
COPY_NOTIFY operation.

-Dai

>
>
>> ---
>> fs/nfsd/nfs4state.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 9409a0dc1b76..749f51dff5c7 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>> 	struct nfs4_client *clp = s->st_stid.sc_client;
>> 	bool unhashed;
>> 	LIST_HEAD(reaplist);
>> +	struct nfs4_ol_stateid *stp;
>>
>> 	spin_lock(&clp->cl_lock);
>> 	unhashed = unhash_open_stateid(s, &reaplist);
>> @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>> 		if (unhashed)
>> 			put_ol_stateid_locked(s, &reaplist);
>> 		spin_unlock(&clp->cl_lock);
>> +		list_for_each_entry(stp, &reaplist, st_locks)
>> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>> 		free_ol_stateid_reaplist(&reaplist);
>> 	} else {
>> 		spin_unlock(&clp->cl_lock);
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
