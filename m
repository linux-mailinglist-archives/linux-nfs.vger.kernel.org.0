Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1A5A53EA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiH2SY1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiH2SY0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 14:24:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5977F098
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 11:24:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGfLC9008199;
        Mon, 29 Aug 2022 18:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iJfAnbQPRd/x9qaZMqtIyT3TLONm2dRaBYOkRdjkMiE=;
 b=Si5zKF04Gx4D1hdJJcx7ZmwLeX4DCyKhMIkEP22wBYAD2PykOsUyCfg9A0XKveVMh41w
 g0n19fY+vY3W0yT+bArNWe5Bv1g0uEFnxIDEbITt3CW79rxax6jdNYbggOdWMh1t+Vwy
 xIq1nRhmIvxCuDq06tF2yfnxlfFG0KFoMwwsqaQHWHs5EI5OY9FCI5fgXuHl5p1VSdBR
 bNmo5BBp8pWK44+uSJ/RIXIeoN+w2SwYHm4bpVJTGfPeTXbMS9Lxf0gI3iYnI43eDyO4
 tR0FoJ8MgQwugCxOXmCZFBuBA9nfL+xwk8f/Ltm3Zbzvh6OJzSmq+JLmui2tUKx/ftnB +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avsc6y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:24:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGoptf033489;
        Mon, 29 Aug 2022 18:24:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q2scaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqyBWAB06Y6MiWztdFgrj8P+GnUl5/39SUN+jzcXX8OiXvnE/bi7y4tpCyVGYNSxbwlocUFAuvl8oaIQ3SoNYxF4gDPWik+0OgLRXe2ntMD1f3vJCV1mbMoVLVe9DZax5wOzTUWeX5KU3phxgtPSavseWosTGMjPCSydBSv1PmUMUCZ8QV+A6fcLVcw5bAIkJv4ZdJF8lGy/0PoRl1FiUOOHo0JMq9FsLWgEZlyUQYYdHItU6EHy30RDOGZu/xQvZPTbJmvWGLPJnVoGETzJm7++f4iSHIC6coclbOBYRqphMKdTSYWjwtREmWpKDg8IoszA2EMNSEGyYi3GsV2Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJfAnbQPRd/x9qaZMqtIyT3TLONm2dRaBYOkRdjkMiE=;
 b=VM2irqsilMetyXJvjfqnORdK9TYLyHVy9dsm5AXx8NdJ+5YZq2BeEOhmVDg14EzyM+s7hi8u4/UiWOY9reFNJdVHXPrt6RuS4/UDQ9SD5JmV/Y1sPHl6elna+pvVUGydh4PNNEf896oQvGhM5jJSNhhgwHLbSeT+Fe0mhe1qv1gxLzfCRre0r+eWstlU0nxye2gSwf2V7giT02nfOox4R3GKQg1+S7Ro3QNksdesBsabV0VMdiNKTzEl/Bvh7Ph2fHGjdO9fnOI4+7NV43YI3CDCF/efRcLpRZB0YEJ7LxaAeECEY9WB3DQmBOYmTmFov9CByJ0Yq8Yrjs5Y0X0Iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJfAnbQPRd/x9qaZMqtIyT3TLONm2dRaBYOkRdjkMiE=;
 b=hZz0qNWghRCXVmY9iwoclDsM7/pjxchHyOOuUS64oZX8vX+7eVYe2qlk4N7WTLtiPrNjGHlKGctNp1KGCqSKsvLZwksMwh/E573qz+HHbWusX6tvqA6y4Uv2Hiu04+Tvon7KQl9q7QzrWkpvAjg+TCD24UKJXfz3LuV5yuBYOJU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BL0PR10MB2788.namprd10.prod.outlook.com (2603:10b6:208:79::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 18:24:16 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:24:15 +0000
Message-ID: <a27ff607-d386-bd19-c6d1-2d51f3af6108@oracle.com>
Date:   Mon, 29 Aug 2022 11:24:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] NFSD: keep track of the number of courtesy clients
 in the system
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1661734063-22023-1-git-send-email-dai.ngo@oracle.com>
 <1661734063-22023-2-git-send-email-dai.ngo@oracle.com>
 <d922f34be03a6df4bb8a0dd12df4a085ba983cb8.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <d922f34be03a6df4bb8a0dd12df4a085ba983cb8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf3dfea6-9bc6-4af2-ae99-08da89ebadb7
X-MS-TrafficTypeDiagnostic: BL0PR10MB2788:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGNWaQSwSTeGKj5NqSWD0B5VTTWE/AUzQooB4PALMbAlIquNUj7+XszWW8dXnEkpFdSNHRkBCp727vIiKlRb0Ll3tZVWIgejpT7lBbqgEKFhGnnf7JI8AMng4WViZlhs/Vq9+aYsagq4/YaDHMR0xkDPUNzFCuPT84T0wfNshKALiEPq5mm1WXEkddwcmVzS2ErdRjDJe4AQbYD0veOkLWefan3uh9jvo79cNqMRCKZdAY6WmvBeBJhxVfvbCfBr1Wtr0om9AjF9LHGJ7DBU+utWQpCJsoUWINjxbq3al7CZAWwhe9nA3IC6vi1tmUZBt9vBo4H5rCx7oWLa+NG2FVWtvZMfqCUpJDMohCnXFbYYQ7++eR7F2SsQheWLNAgeLskbqvXHO2KO+gzqjddJojdFKYvgnIldSjZsmgj4fIP9RMZjKP9YzR+PY4IQvcwVNHOHJyZCqSIlOdqjNqFnx3MIES2LsX5624adHZQBK+iHbmJypjaRh4GG6fKPsnHzPQTHwKrSdfEhaJiQ7FxjLB52+xGa/W6MhQCxrwBza4IGYGGeZ3/AnMlVtxprZfajYevgY69SZESI6O0EvDW/fnCpSu+cXcvtlNmnIGa4t26kt12Gh95/MtHFpQmV958JVBk8fImaX4rRIsdzWgFj2ysUGnlS04WCnUiLNA7Wkrypc2ObQhAwASlmScfZySBnxXK1Dnp2Doi3Xk1vU0Per6gw5nCxDavB9ZBorijHqTd4eFeM+WvIyjZ2zEbzGsP/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(366004)(396003)(6512007)(86362001)(26005)(9686003)(53546011)(31696002)(478600001)(6666004)(6486002)(6506007)(41300700001)(186003)(38100700002)(83380400001)(66476007)(5660300002)(66556008)(4326008)(8676002)(8936002)(66946007)(36756003)(316002)(31686004)(2906002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjdsaWJ6WjZSak5xQzVmSGZUNVEvY3ZReWNxVUFzaFFXRnVJcU9QN2NkTUox?=
 =?utf-8?B?b0s4Z2hTaWlkckJOWWVkbmVOQXdrVXcyOWlHUHdlUU5XaXFQL3dpZWpOZ1Aw?=
 =?utf-8?B?VzczZGN4ZnlYZ1hnVm5xR0UzWHFGbXo2SEZrZEpKbXZEL0oyeU03Z1BpNk9x?=
 =?utf-8?B?WGFhZDEyMDJYN2Y1Zjd1L1BWejZvQWxwRWNRWFZZaG1VRUNwOXorSTExU2Jp?=
 =?utf-8?B?UitEQUYxYXZlL28vMmpJTFN2ME52dWpjMVd3YUVlcjUySTkrTTJmNDh2MVQ4?=
 =?utf-8?B?Sm5sbjJSbHlOdUkrdGJMMU5IRlhuNkdZREdaOVVxRmd1bS9kMHJwb3FROFQ0?=
 =?utf-8?B?VXZmbWFxOFZpemFIelVxdWEvMkZWSVloNksrdUJmUm5HV3cybU81UWYyYnRF?=
 =?utf-8?B?anc3SjFQd1FoSzQ4clFpKzd6eU92YXF1Z0dtZk10RkRtcUFsTFdaY1BOYWRp?=
 =?utf-8?B?bVUrT2hHS3poUnRjbWZ2SUt3aFJyeXh5VS8zZmd1N1EzUlplUFk2ekNZSjBr?=
 =?utf-8?B?Mm9TS3NCeGRoUU9yTFBTcE9VZTZyVFNmN1hGMWllU1VqcnpZaGg2a1NtSFB1?=
 =?utf-8?B?NE10VWMrcXFyYzBzVmxsM2NlRXAvVExvQnV6UnVDejF1NWhnRXNoTzNGNXRh?=
 =?utf-8?B?N1o5d1hPTHNwK0lxNEU5SHRkemd3N0h0WkQ2YkwvaFR5K2ltWDRZMEg0UXlT?=
 =?utf-8?B?YmJ2RDgvL1M3Y0pqdUxQaVByMTVENkFGQndXWWUyVEZZajFPYXlOTXBYL3NP?=
 =?utf-8?B?Y1lFRGZITmMrUTFpL0t6dStpWGdpSUt2OVY3MnhhZ01pR1VJTHRuNEdpTkIy?=
 =?utf-8?B?dWViNndyV2hnZjVJaVhkbmFTZjY0MFNJTk5hbTZ6MnAyVXBkOWtGOUU4dGFy?=
 =?utf-8?B?K3VOdXlleVFjNW1FMldkdXdVci96aHNKaDBYUEpVazVIVWR3eEFHRC9SdlZ4?=
 =?utf-8?B?T2tRSjcycDUzR0h6SkNRTmNWdDVwMWRmOWdxYWo5U292ckIzYTJIckRHYjAv?=
 =?utf-8?B?TWpKUm1wUHQxK2U0N1E3ejh0ZHlaK01HNTNUS2dMNFArM0pxT2xSNUV5RVZj?=
 =?utf-8?B?SFRXRDRBTTArVGd0ZFlsSVBWMDJOeStBQkFMMDZhT3JINHFXRHBhZHY5K1pX?=
 =?utf-8?B?QkZMVFQ3cVYzdmxsRmJ4OXpORUR4UGd3bzR3eHJ1eDF6UXlpSGROOTlMUkdF?=
 =?utf-8?B?dFM4dnlqcjNmMFNLTWhmRmljZmJIT3R5UFM1a1VORTN2akpBRE42QWJ6ZWJT?=
 =?utf-8?B?ZmE5cDFudE9kTjhORGFjWlArZmNqdUpYK1Z1UWNDZ2xHSEU2TERyeVhnMFZm?=
 =?utf-8?B?T053bnY0UjM0aUV5VjJVWCs5Z21YU0RYQUd5RWx2cXdoYzJ2QTJIVWJHQjBt?=
 =?utf-8?B?NW9YOWcyRXl1dytqSjZlRk13NXg5b3BHRWFuZ3M5SUd0NW1qd084dEVMdHZG?=
 =?utf-8?B?K0hxVFN1N0tBZVNUN2gyeG9XaDBwSEc3OXdBeFl6cXJoMmZNTHFSd1pRVzJu?=
 =?utf-8?B?SENHcVVsLzhiSE1xK0hNbDNlY2FzVEdDMVAvN2FXanlpTzZmN2s1NE1jTVRt?=
 =?utf-8?B?UFFueHNlb1ZGaDkxakNPT3kxMXJMdVlRaWU4MStpbVBjQjNJSUlZZ0R5cTNi?=
 =?utf-8?B?ZXVpOW5pVUJTUTRLdXk2eU5jVkZNMWh6Vkd1VEJIY3FDMU9OQXR0SGpoMUc0?=
 =?utf-8?B?ZmlMM1NjUTAvMW5zSW40eGFJYVViek5va3JPQy9JUi8zT0x2dmFTN2dXTUd2?=
 =?utf-8?B?dkpBWTRGRCswUDlBNVZZSnZNcW9FTFJwZHRIR3pvS1J1SU14VWxaYlhSWlpT?=
 =?utf-8?B?RzlzTDN0YXVmOVVIT0ZmdXMzLzhXRm9UVUIrdE5rOEREeW9vSGFRZWpRWGJp?=
 =?utf-8?B?VkxrWVRPbGFGdmhPaUp0b2o4ekVVNCtWNHBWREhIdWNOck5YQjBPcjIrZmti?=
 =?utf-8?B?aTRoTTNWZlRGSndHTzMyazVBZ0wwOThvMnBiS2Q2dGRYZkU3V215V3Z5SFk4?=
 =?utf-8?B?Vks0cXYvcVB6RDlNVE1YWTNZa0tGK1crbWdsNEFqNDFOcklaWENNZk4vZDlT?=
 =?utf-8?B?eEtqRzFTd29JOGNyNEEzRlZsM0FlVkxaa09oOUlFeFNReEhDY25KM1N5U3I1?=
 =?utf-8?Q?wMln4XXqiKRF/VK1FWhq6m/s8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3dfea6-9bc6-4af2-ae99-08da89ebadb7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:24:15.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApLFR6Aef61zEa1PAaAHeglHkf9ypUaYxkXKV6nNq6SSydNb3Md2Kt8uDFK4gCoMkaAHAWW+ZzyVVj+dop3+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290085
X-Proofpoint-GUID: qooGkBMzxbsb47L-wNCvAAuAx01BGvsW
X-Proofpoint-ORIG-GUID: qooGkBMzxbsb47L-wNCvAAuAx01BGvsW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/29/22 9:48 AM, Jeff Layton wrote:
> On Sun, 2022-08-28 at 17:47 -0700, Dai Ngo wrote:
>> Add counter nfs4_courtesy_client_count to nfsd_net to keep track
>> of the number of courtesy clients in the system.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/netns.h     |  2 ++
>>   fs/nfsd/nfs4state.c | 20 +++++++++++++++-----
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index ffe17743cc74..2695dff1378a 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -192,6 +192,8 @@ struct nfsd_net {
>>   
>>   	atomic_t		nfs4_client_count;
>>   	int			nfs4_max_clients;
>> +
>> +	atomic_t		nfsd_courtesy_client_count;
>>   };
>>   
>>   /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c5d199d7e6b4..3d8d7ebb5b91 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -169,7 +169,8 @@ static __be32 get_client_locked(struct nfs4_client *clp)
>>   	if (is_client_expired(clp))
>>   		return nfserr_expired;
>>   	atomic_inc(&clp->cl_rpc_users);
>> -	clp->cl_state = NFSD4_ACTIVE;
>> +	if (xchg(&clp->cl_state, NFSD4_ACTIVE) != NFSD4_ACTIVE)
> The xchg calls seem like overkill. The cl_state is protected by the
> nn->client_lock. Nothing else can race in and change it here.

I use the 'xchg' calls for convenience and readability and not for
protection in this case. But if you think this is overkill or
unnecessary then I remove it.

Fix in v2.

Thanks,
-Dai

>
>> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>>   	return nfs_ok;
>>   }
>>   
>> @@ -190,7 +191,8 @@ renew_client_locked(struct nfs4_client *clp)
>>   
>>   	list_move_tail(&clp->cl_lru, &nn->client_lru);
>>   	clp->cl_time = ktime_get_boottime_seconds();
>> -	clp->cl_state = NFSD4_ACTIVE;
>> +	if (xchg(&clp->cl_state, NFSD4_ACTIVE) != NFSD4_ACTIVE)
>> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>>   }
>>   
>>   static void put_client_renew_locked(struct nfs4_client *clp)
>> @@ -2233,6 +2235,8 @@ __destroy_client(struct nfs4_client *clp)
>>   	if (clp->cl_cb_conn.cb_xprt)
>>   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>>   	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>> +	if (clp->cl_state != NFSD4_ACTIVE)
>> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>>   	free_client(clp);
>>   	wake_up_all(&expiry_wq);
>>   }
>> @@ -4356,6 +4360,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
>>   	max_clients = (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
>>   	max_clients *= NFS4_CLIENTS_PER_GB;
>>   	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>> +
>> +	atomic_set(&nn->nfsd_courtesy_client_count, 0);
>>   }
>>   
>>   static void init_nfs4_replay(struct nfs4_replay *rp)
>> @@ -5864,7 +5870,7 @@ static void
>>   nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>   				struct laundry_time *lt)
>>   {
>> -	unsigned int maxreap, reapcnt = 0;
>> +	unsigned int oldstate, maxreap, reapcnt = 0;
>>   	struct list_head *pos, *next;
>>   	struct nfs4_client *clp;
>>   
>> @@ -5878,8 +5884,12 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>   			goto exp_client;
>>   		if (!state_expired(lt, clp->cl_time))
>>   			break;
>> -		if (!atomic_read(&clp->cl_rpc_users))
>> -			clp->cl_state = NFSD4_COURTESY;
>> +		oldstate = NFSD4_ACTIVE;
>> +		if (!atomic_read(&clp->cl_rpc_users)) {
>> +			oldstate = xchg(&clp->cl_state, NFSD4_COURTESY);
>> +			if (oldstate == NFSD4_ACTIVE)
>> +				atomic_inc(&nn->nfsd_courtesy_client_count);
>> +		}
>>   		if (!client_has_state(clp))
>>   			goto exp_client;
>>   		if (!nfs4_anylock_blockers(clp))
