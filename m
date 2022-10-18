Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B697603015
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiJRPtx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 11:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJRPte (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 11:49:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FFC96F7
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 08:49:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDxKdg007799;
        Tue, 18 Oct 2022 15:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2kk1oJmrE0RD3UROlYnE9UYCbBmkppkTvuuDwm4WWto=;
 b=SajT8kv6cwVEdSLHbMGIaHkJfKjwxHFqgprPFDMBqVep0dGcPUn6MqIB/mTNGyzs2AHp
 gQDsdnXI5cYARYPvWLsHklycXP/7wSADZz8PVOKLA4b0JHEJLhVyMwXt2XJjwMrVgt63
 u2S+vKFSa7/SqGA0RyP5TqUTO88Nzgso4AUHpGFsQaLkvt+2hyCW6+Sxc3DEDO1LUiPX
 NoGfIElfLrx8eSNEpmEp5wBSFBCvXTkMnbKNZ5tuWyrrK5XCBfkgr5y0EU52snBQ2566
 xH7FZs1ezCOptfv5DzixxQAnoUJKajEAuEXNZlEqBoXSJ7hUsrDbbrcaIB+T4OLY/ETe kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mtyyap5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:49:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEkxQe033236;
        Tue, 18 Oct 2022 15:49:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrae173-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gURRnPTM+LaXbNiouSrogCv+aMOpCZiJZkWyPkkcJbtQYYQq/mSGtpY1t94WLV9D7iK97eb35ogUrp9c9k4MtnCqYj4DV/zMRLs5HCKqYfMrN4DbkRMupz33a6PnV0vBne3QcvvDO+YwdJZ9lvUbuPmzjuFPh8/SNQKsyaJHKZ9Iu4BNsX/l4oRHvG/paUE9kbxK9hj7sfk2Tp9Neg+06Ra4d4wpolqgGJBq+HMEzWUqMZ4ZWk54icnB90jKiNu2N9CwuRELpQzntLOTV1HmgAX2esQ5Vvwp3nUDm02Y6OrXuDzo6QsHMnIT/4gDANmQhVeWkv/ulCYGQAYG0eTMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kk1oJmrE0RD3UROlYnE9UYCbBmkppkTvuuDwm4WWto=;
 b=dMWO8HH5Cu8nckxj8ErZSlMH8KwjPwCE2l158wWuebpFBx5mjFQ/yqeuvpRppREy59HHxCnB6mIlxO5uKP4kYB04/v5OlcOM52UhnL2bMQ0xZOe8r9mjqnemR+7daNcGxntZslCDA3eIrBMvq2WSBvl5uZesWkLlLGWkjkU9EcA1A2IpcpxsUcKf6CiHfDV8kSuucOW1CJYchlpLzGpdBkPdgbwD3z1Fe/s5QLpbBxcfAwlcDizxiRt1nSx2oOAbBtzIrNl6akHMDh/18TydJgmMQj28TVidHXCl1LPgoMeYKvoPmIwsltpsVtxhxX5mU5DmHwe58Q2AXaJtVM1nSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kk1oJmrE0RD3UROlYnE9UYCbBmkppkTvuuDwm4WWto=;
 b=XenBCI2vmRgB2hiJaxTXbsT2NwQhTAAMxwyVlUHLsR8zK7o7q6DkUskgaTVSIuix/bjmrFq+1ULRqlBs7DB2RSe0TyIWfekNb+EpoyTaHQoPI2xXqN0/hOVW4j1slbtnhzeW2uDspzJoTeB2RxkTRQhmwPf8nS9MYYpte5oI3/g=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA2PR10MB4475.namprd10.prod.outlook.com (2603:10b6:806:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 15:49:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 15:49:14 +0000
Message-ID: <8053ca18-0229-2f92-359d-599e4cf08082@oracle.com>
Date:   Tue, 18 Oct 2022 08:49:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Tom Talpey <tom@talpey.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
 <1666070139-18843-2-git-send-email-dai.ngo@oracle.com>
 <2b3d2faa-c430-b456-f7fb-25dd6273d71a@talpey.com>
From:   dai.ngo@oracle.com
In-Reply-To: <2b3d2faa-c430-b456-f7fb-25dd6273d71a@talpey.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA2PR10MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: eba6d5cd-f104-4cbe-e840-08dab1204ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7wy0ciav0QYECUoOzd+Dpty78WZsk19S4UybAUNrFGGV/5kk0AyM8Ks7G/X88T4pRiFgSW50JJWQwIH39rBbewaZ7rFK6IvYdvz0LNn9DOrjBy66XhWkjPARCN8am3yZaNl/Mwrw7ptu5bPqPkTm2skEq9YmCkJQfd22cT1I2N975Y9SU+7VNu1k+ZqhQW/xo691J51Km6uuAJVE60qaJZlPQd4W1o5XMTKmiNhU7dQg1XKyjfSRLfygBe6tzsZ0Ll5JqfWUbe4LCgjBWujH1AReGGmbZrHVnvU95xv9Y/jXBfo3gmEsbt0iry3HHMAeuxj5d6x4AFkGnZIl4Yw97eIbHdwUxER+wPt+YnSSQmjYsvI+SByJKQ93TvLtNEHrb3lWHU4lBnN/kTEPjWoTcDQq1CPDWXWS3bWLQQRXX+LWGQRZOvTGvtCg0OQqVuDCVxk8d5JEH9Kj8rooEOUSn2sdnGvxaAk0vwlmdWmJcTHhimS9fm+mlloL4bwP5oBYYd+saIXwcpWiTAegYzgXy3+a1z0rT5beytBvs5DzNeFTU9M3pB1HZAo49t7rq7NwF4o3FhxZq50FJ682tbcX9hkyIG7RuqBbAG0pBEFKZkRVFIChTi2OSIo+56T8B8pwaNU1CW/2OjYTxpNFG0sJ6Ft1jf2bchQDe38Fxo+5C1dbEYyesqBiNGGXtW3RBKssRCU6HH6+ZTfH0wV6LehLppwsLqbnlSshqKK/cVqv47gVfU5jNr80ngHlro1sZOoZXDdrutEvytVzcCj0Pd6Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199015)(36756003)(31686004)(86362001)(31696002)(38100700002)(2906002)(5660300002)(2616005)(186003)(6486002)(83380400001)(6506007)(316002)(478600001)(6512007)(26005)(9686003)(41300700001)(66946007)(66476007)(66556008)(53546011)(4326008)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTlLdzZjQWtleTZzSFkrWTdmMzdBZ3hQeUkxaThReUNKRkxtUHptMWloai9U?=
 =?utf-8?B?aEpnSTJOaWpYbktTcXZ5eTVNK0gxakgxRTBQZEtBSXpZQ0JYcjVQMytUaWls?=
 =?utf-8?B?M3ZvaUhMc2xCTWJpSmdGRU9mQUZWMk9wOEVOS21qUkFGRjRSWEdYQ3Irc2h1?=
 =?utf-8?B?cGZkRFdjblBBcldkV0czZC95RmRsM01aT3YyZ2h5bUN6cVk5dXl4Vk5yYVNt?=
 =?utf-8?B?Sk9mMEN6Y3RIc1RVZGZjOGRqUVVrdWZSVzljTm9pczdIeDI2RE5JS3diY0R4?=
 =?utf-8?B?VnpOSmtVd2lmUFlnRjgvcjhiNEpJWnlHenByVFd4Rnl3dEtvT0lpZklPd1VK?=
 =?utf-8?B?L1VDd3FqVjFOS0ROeVJRd1lHWStPa25Zb3hNQ0U2Z2VUOW9Yc1hCUi9KcWhV?=
 =?utf-8?B?eCt3M1JCZ3BIZXowTTdRQ0U1MGFidnZ4RFNabHRXUUVhUkQ1SGtHUUJFVUg1?=
 =?utf-8?B?djhnNVA3QmRzck1Oa2hZVTEvN05mdE1TQVUxVEJHaW9KQVdIZklBZVI1Umpn?=
 =?utf-8?B?Wk5vVDBHMVFRN0FWbkZKbDA4NFA1MlRGMlRicTgrZ2Y3aFFMclRjdDZXMk1I?=
 =?utf-8?B?RXEvQmNKblJvK2RNN3hqVnpLM2ZRUllxSFY4YlVFcmNqaG5IaFhrL21YR09K?=
 =?utf-8?B?OEZUaGhwS29ycHh2SWJ0Z3V6LzJBWElRTEdGblJZS3Y5WDRrZk53Q1hlOGxV?=
 =?utf-8?B?MUwrVUhSODhPZFAzTm52TmtjSVVycSsyeGtzR3lROXNFNlJtSmFHWGgvVE9Y?=
 =?utf-8?B?NWJNWWtLbkdTZk1ENytjSEtCR0xSQzA5Q05sUmF2YVhSMllPQXFZU3l0T3JX?=
 =?utf-8?B?RSs2YWFiQmhTSkpGdWhCTlVIbGt5LzBVOWNKdkxYcWlYSWgwczZPOG5uVHZl?=
 =?utf-8?B?VVpWSzI3U3N3MDg4Vm9zVDhjb3BLeU1POFBsZ280dDdZWUIrOGM2eUJyVHpI?=
 =?utf-8?B?UzJXREVXbFNqQ1BUcG8xQkk2UW54R3RIRURubU93cExucHJIMEVHalEvN08w?=
 =?utf-8?B?OHEzbWdrTHl2QmFsK1RjWDBMM0o3b2s5UUJqQ3pNNmgxVllzSlRqSTlpMVhU?=
 =?utf-8?B?VEFES0Uzcmg4TUhsTC82VzNndVdiNnRsOUxzRFNuUnozZGxESHBvZE81NHU2?=
 =?utf-8?B?QlVyNHByRnBRY2Q4MGpVczdwS2h1dkx1elRuUWZBditrWDJJL0lWV3ZxSEVR?=
 =?utf-8?B?MTdUU2kxTHJURmVQSHUvdEwxRFRvTmIwcVo1U0V1ZlhiamdXQjJmai9SUFhS?=
 =?utf-8?B?NFYvbFc4YzlOaHdsVTF1UTBWMTV4NnpHZi8yVEVWSk42eERES2Y5aGlXNzZC?=
 =?utf-8?B?bEcwam9XSWQ1ZGM0dzdBNnd2Y1NPQWtxTmlLamlieG9tbkVtMHJOUmNiRXpQ?=
 =?utf-8?B?djJRaGJYNG12OFdRRTBqbkQwbFFOYnAvck5sbmF0M0FSMW9LWmxYVTJUbFph?=
 =?utf-8?B?NGl5dzd5V3haeGRTd0lzamNYV0dFT2pGU0ZZdHh1aGNvRGJOQWNYSlRrME52?=
 =?utf-8?B?SWFOY3NWWDNBWElIbktqYjNmY0Znd2JzMm5oWk5KaW1kYkkrRiswNlRqUXcv?=
 =?utf-8?B?aGY3aDRpMTVhSEcvRUJjejl3bFUvZHovT3RxcGN1N1BKWXNHbTF0UTFvYVBD?=
 =?utf-8?B?dHRUVUtqa1lXVit5TXRYR2xvbHZISlMvL0pOb2hyL0lKUmw5Q0RFMHlpZG9r?=
 =?utf-8?B?bUd5NzV2YVh1bFpTclZKWHVpZE9zTTdPTk1vTE5renFSYUYxUW1kNGVqY3RM?=
 =?utf-8?B?ZmkrMXVTZnNTUVJQdXZtM0FOL2hkNVY5UlpBdWYvVm5JVmM1MERzN2lVd2FN?=
 =?utf-8?B?T2ZHV0FNTVNzNDFXUjZEdVRRdElYNU92MjlrSWlVVEQ0bzJ1TjlMNnViajRr?=
 =?utf-8?B?YWhPUXY1SksxanJJNXRzSkc5VXMvMkpYenlqZFFlUjV4WnprVlkreklLZlNV?=
 =?utf-8?B?WjhuTWEwNWpEMDdUaFJKUEx5Q3J3a3U2WDNvZ0VPMm1uaEo1S2ZaN25XcmQr?=
 =?utf-8?B?R3VMQk1GMS9FWVB5c0RYZnhXNzZ3UGJuZnNUdkpqeGVoUzBOWHJpeFNocjNW?=
 =?utf-8?B?clN1blZWL2t6RTB6cWlUcVJJcmVZeFNUT2c4T282eE5GSkhpcmFGS0Z6U0w4?=
 =?utf-8?Q?QcUQxbqIU4aKlMl38pMbWxzCW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba6d5cd-f104-4cbe-e840-08dab1204ed4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 15:49:14.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78Dlmq3No+RKkcuEgNY+4sSwtLUDMoBDAjnyktRNwtAmbCwJq0W8Ll6fOasu3owiaiAmjjjx+opVoZUiJoyxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_06,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180090
X-Proofpoint-ORIG-GUID: jMBBO9wyMKHz6rHndXs82UXZdUdLaHUe
X-Proofpoint-GUID: jMBBO9wyMKHz6rHndXs82UXZdUdLaHUe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/18/22 6:25 AM, Tom Talpey wrote:
> On 10/18/2022 1:15 AM, Dai Ngo wrote:
>> There is only one nfsd4_callback, cl_recall_any, added for each
>> nfs4_client. Access to it must be serialized. For now it's done
>> by the cl_recall_any_busy flag since it's used only by the
>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>> then a spinlock must be used.
>
> I'm curious if clients have shown any quirks with the operation in
> your testing. If the (Linux) server hasn't ever been sending it,
> then I'd expect some possible issues/quirks in the client.
>
> For example, do they really start handing back a significant number
> of useful delegations? Enough to satisfy the server's need without
> going to specific resource-based recalls?

In my testing with Linux client that have active delegations, the client
just replies with NFS4_OK without returning any of the active delegations.
I guess to see the client returning the delegation, that delegation must
be not in used but so far I have not been able to force that condition:
not is use but have not returned it to their server yet.

-Dai

>
> Tom.
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4callback.c | 64 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>>   fs/nfsd/state.h        |  8 +++++++
>>   fs/nfsd/xdr4cb.h       |  6 +++++
>>   4 files changed, 105 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index f0e69edf5f0f..03587e1397f4 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct 
>> xdr_stream *xdr,
>>   }
>>     /*
>> + * CB_RECALLANY4args
>> + *
>> + *    struct CB_RECALLANY4args {
>> + *        uint32_t    craa_objects_to_keep;
>> + *        bitmap4        craa_type_mask;
>> + *    };
>> + */
>> +static void
>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>> +            struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>> +{
>> +    __be32 *p;
>> +
>> +    encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>> +    p = xdr_reserve_space(xdr, 4);
>> +    *p++ = xdr_zero;    /* craa_objects_to_keep */
>> +    p = xdr_reserve_space(xdr, 8);
>> +    *p++ = cpu_to_be32(1);
>> +    *p++ = cpu_to_be32(bmval);
>> +    hdr->nops++;
>> +}
>> +
>> +/*
>>    * CB_SEQUENCE4args
>>    *
>>    *    struct CB_SEQUENCE4args {
>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct 
>> rpc_rqst *req, struct xdr_stream *xdr,
>>       encode_cb_nops(&hdr);
>>   }
>>   +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static void
>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>> +        struct xdr_stream *xdr, const void *data)
>> +{
>> +    const struct nfsd4_callback *cb = data;
>> +    struct nfs4_cb_compound_hdr hdr = {
>> +        .ident = cb->cb_clp->cl_cb_ident,
>> +        .minorversion = cb->cb_clp->cl_minorversion,
>> +    };
>> +
>> +    encode_cb_compound4args(xdr, &hdr);
>> +    encode_cb_sequence4args(xdr, cb, &hdr);
>> +    encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>> +    encode_cb_nops(&hdr);
>> +}
>>     /*
>>    * NFSv4.0 and NFSv4.1 XDR decode functions
>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct 
>> rpc_rqst *rqstp,
>>       return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>>   }
>>   +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static int
>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>> +                  struct xdr_stream *xdr,
>> +                  void *data)
>> +{
>> +    struct nfsd4_callback *cb = data;
>> +    struct nfs4_cb_compound_hdr hdr;
>> +    int status;
>> +
>> +    status = decode_cb_compound4res(xdr, &hdr);
>> +    if (unlikely(status))
>> +        return status;
>> +    status = decode_cb_sequence4res(xdr, cb);
>> +    if (unlikely(status || cb->cb_seq_status))
>> +        return status;
>> +    status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, 
>> &cb->cb_status);
>> +    return status;
>> +}
>> +
>>   #ifdef CONFIG_NFSD_PNFS
>>   /*
>>    * CB_LAYOUTRECALL4args
>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo 
>> nfs4_cb_procedures[] = {
>>   #endif
>>       PROC(CB_NOTIFY_LOCK,    COMPOUND,    cb_notify_lock, 
>> cb_notify_lock),
>>       PROC(CB_OFFLOAD,    COMPOUND,    cb_offload, cb_offload),
>> +    PROC(CB_RECALL_ANY,    COMPOUND,    cb_recall_any, cb_recall_any),
>>   };
>>     static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 4e718500a00c..c60c937dece6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] = {
>>       [3] = {""},
>>   };
>>   +static int
>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>> +            struct rpc_task *task)
>> +{
>> +    switch (task->tk_status) {
>> +    case -NFS4ERR_DELAY:
>> +        rpc_delay(task, 2 * HZ);
>> +        return 0;
>> +    default:
>> +        return 1;
>> +    }
>> +}
>> +
>> +static void
>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>> +{
>> +    cb->cb_clp->cl_recall_any_busy = false;
>> +    atomic_dec(&cb->cb_clp->cl_rpc_users);
>> +}
>> +
>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>> +    .done        = nfsd4_cb_recall_any_done,
>> +    .release    = nfsd4_cb_recall_any_release,
>> +};
>> +
>>   static struct nfs4_client *create_client(struct xdr_netobj name,
>>           struct svc_rqst *rqstp, nfs4_verifier *verf)
>>   {
>> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct 
>> xdr_netobj name,
>>           free_client(clp);
>>           return NULL;
>>       }
>> +    nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>> +            NFSPROC4_CLNT_CB_RECALL_ANY);
>>       return clp;
>>   }
>>   diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e2daef3cc003..49ca06169642 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>         unsigned int        cl_state;
>>       atomic_t        cl_delegs_in_recall;
>> +
>> +    bool            cl_recall_any_busy;
>> +    uint32_t        cl_recall_any_bm;
>> +    struct nfsd4_callback    cl_recall_any;
>>   };
>>     /* struct nfs4_client_reset
>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>>       NFSPROC4_CLNT_CB_OFFLOAD,
>>       NFSPROC4_CLNT_CB_SEQUENCE,
>>       NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>> +    NFSPROC4_CLNT_CB_RECALL_ANY,
>>   };
>>   +#define RCA4_TYPE_MASK_RDATA_DLG    0
>> +#define RCA4_TYPE_MASK_WDATA_DLG    1
>> +
>>   /* Returns true iff a is later than b: */
>>   static inline bool nfsd4_stateid_generation_after(stateid_t *a, 
>> stateid_t *b)
>>   {
>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>> index 547cf07cf4e0..0d39af1b00a0 100644
>> --- a/fs/nfsd/xdr4cb.h
>> +++ b/fs/nfsd/xdr4cb.h
>> @@ -48,3 +48,9 @@
>>   #define NFS4_dec_cb_offload_sz        (cb_compound_dec_hdr_sz +      \
>>                       cb_sequence_dec_sz +            \
>>                       op_dec_sz)
>> +#define NFS4_enc_cb_recall_any_sz    (cb_compound_enc_hdr_sz +       \
>> +                    cb_sequence_enc_sz +            \
>> +                    1 + 1 + 1)
>> +#define NFS4_dec_cb_recall_any_sz    (cb_compound_dec_hdr_sz +      \
>> +                    cb_sequence_dec_sz +            \
>> +                    op_dec_sz)
