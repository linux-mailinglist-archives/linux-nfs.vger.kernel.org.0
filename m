Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D985A53EE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiH2S0H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiH2S0G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 14:26:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121B6B673
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 11:26:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGibp6029006;
        Mon, 29 Aug 2022 18:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qbq0yl/LfENiZ7GBQVyUR0CJvPN2ZuqtRgxpIt4Y2mM=;
 b=WtAnwYjHHavfm6zVjZZGo/+SuY222oT/IQD69CAjZGzC2eV2CI1aqVubbf6//ARkJ6p6
 D9U4sFZ2jV78u5UyOADckwFmKcHfqxmOpSYF8oyJdxRLJXJuFODArH8iU1RV7ZqvffpZ
 pKvy1PsJaUs8CO+wRvoO/OauNlbCwDLNxKftx4uVUROVNpAlRhQga2ULdhHR93GMh7jU
 Ya13n2rZ6ERombnzN04uo806kHNSTC3kwCWHvVjEAKRzYKkFxngc4vEJxDxs39MR3Yrw
 kxNelMSQw80xYdx4Em9o5QFy7FschgaG5KLUTZAH0PZiU+nY6Jjy74zv+Yj+vhtiNTUk DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt45xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:26:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGsatF019505;
        Mon, 29 Aug 2022 18:26:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q30n4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:26:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8wHU2YyleBKBftxLj1i/Y1udy/dgHaaXuRowgPWi6ZcM/FMXPJZszcDrSAt5wAAzBvrI1tVwiIq5kxH05YkXERVrPBn76i4n7F4jWTBc9gAazEcLthPjJrc25no9wWyJLBlXcZyZAZOcdEu0dc4rk5eP/Wq0+YaYnUNje7S9zYetg7+D6NmgLIwBcSM4PPmUlVgxvEv7B5KjEOp+tEerR2VnuXcXONfF8mS+TZ1nUwWHbjzCr7zXYG2dGokuPHW790MsT4JKQP+i4KiPljNTRv9iyppZJ4hgj4QUIRInXjVhobnZsV372A2DFhHZacU/DmfHvXeR7aZaePPTKPMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbq0yl/LfENiZ7GBQVyUR0CJvPN2ZuqtRgxpIt4Y2mM=;
 b=ebMvnbuFnKsjwMqT1lIoeabdVVyfxf+WpVL6IA6k9TeXDiXHY8EE09ADAAS/T2P8mmZsezpnJ8llC8aJ7Z1TjzCKu4qhmNoyUvlTZYp1BO9P5sCXEq4wfpzoI40134fqN5u5hg4HWT45E+2ZlWdLAV3Cl335k1lyTdgGwHh71dni8vL5K8jv6rEDujyhZygK5ZcUFJRaQtH4bFQW0yoXLGmlRv3fx5g/JPccKISPVZukq4I/i9+P3pFUqpwN9XtjMhZUD9AR48EhH+oafVDCjlDGXEzOKpqRYB4976k3IGXDWVBwJ89vxl8ImQiyd+60L/kn++Y85OEakCoiWIdpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbq0yl/LfENiZ7GBQVyUR0CJvPN2ZuqtRgxpIt4Y2mM=;
 b=HWN7bvoegc2RCQqQtliqx3PmAUzRyKjz2HBRtCZUEzVa5dbcVlJDZ+XfxVtar+0c4REXAuqaXDu7s3adlwNJL1yRDQkAwNQweXAppM/dlVME21SCBflS1uTSieWmPWRPGyBGlZmJ+5l/jUpEeZFOJPdZ5xRLsLMFfNcpBFbYfg4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB3680.namprd10.prod.outlook.com (2603:10b6:208:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 18:25:57 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:25:57 +0000
Message-ID: <94838eff-af62-8ed4-05cf-10a9cec6a473@oracle.com>
Date:   Mon, 29 Aug 2022 11:25:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1661734063-22023-1-git-send-email-dai.ngo@oracle.com>
 <1661734063-22023-3-git-send-email-dai.ngo@oracle.com>
 <b12994817cda7d9509767182edb1b1f21697648a.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <b12994817cda7d9509767182edb1b1f21697648a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::25) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d3cc7f-af14-4a91-60a5-08da89ebeac1
X-MS-TrafficTypeDiagnostic: MN2PR10MB3680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+bSH8vZASZApn/P5EhWZtrVIZprB3Wr2coBgmyKtjLcDE8aBM8kRnbUMjf7x8aPa9TboNp3vuLyO5WzxVlw1CGPYiuLBTiGS7lp0WjVUo3m35s8lGCFbW7efOAAwGnhlkfYOCuCbI4jAPxXUOSR7eYmK9pSOvCscn3zYPhjlHdyNY86eTbwqOl+48cE9uFd/T/yMsS1eLoKa1qlm4aNPXJVZfqkbfUQeUQz0uf03ZcfDjqwe3JFozz7zcG0+Q64Y5IJ49l0nDw8BUPjiQmOwYQAB7OjUnsNAarOWFdI6ADk71QKOxxEzxxKVQ/vpCn+gSAW6WRZvVGsBmFUfvJrFs2RzTS6RXKzpXzl50IW829c40GuGsdAAf/OR+pPQoNxmNqsJ4E8Dbrr9SLlKn7j4KUMEgM859j4sDLwetRn4tLs4rTEioXaar6XWEnc//1c9/LCXNkwPD/kuMl2MT6Z4d/wO6I0XKlMbrN05CzOTTH2w10hMstoIETUz1TvbcUYLMo+6+AlMlKnjluBui7+Rv0WgaZw/TAQK5HPqPykP5gz213/9ir3k0uiR9vJNWrPPCjDzXpKPCoHcgI3Wr+i3bahwqWr4cJtGI1PAdkAeopVNA/Ai7CEDBVEUqWCQRzwgfMOxhxKC9+tge1+5bTZsbuDKvzM70hNc60YfCNDuK3yBN8jFo7STcZUt+rz8BYMpdNX4JDZX+W5KK4V9uDcxT7yP3jy2dLhx5Br5XaUhKnmJOByZt1HBMhI4t5UO7ZB+BYUWittXboZrIP9gNfYLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(136003)(396003)(366004)(5660300002)(8936002)(41300700001)(186003)(6506007)(2616005)(6512007)(86362001)(31696002)(6666004)(9686003)(26005)(2906002)(83380400001)(53546011)(36756003)(478600001)(316002)(31686004)(4326008)(38100700002)(66476007)(8676002)(6486002)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2pFaUJkL3FldHMzZndqTkRSTkZBS1lyWVFIdVlwMDUvY3RMOTBRU01hb2F1?=
 =?utf-8?B?cUF6MFBGY2dHMktvamVUVlFoOTdzWC9wTExWMXFEbWFtRmluVlJFUm92RzAy?=
 =?utf-8?B?WHZLQStyMDh3Q2dmZEZoYlo5eTRHUWt0My9POHRyaXBJMWFpeXpiRTE2TWp6?=
 =?utf-8?B?Y21meEdRbHFtMDZxWmJxcyszTk9ZdHBSWDFxNEhyVnVVZDg3VmRMN1lOT05E?=
 =?utf-8?B?UlVzM0ZSQ2Rza28vN1FnUlBxZEJ2TnlXV1pLSGZPNE1zMmIyRFJhcVJVaE5o?=
 =?utf-8?B?YTNOTmhQNFhsY3Uwc0d3REM4Y0hMa29BZ0xwUExoYXZQUlBna3Y1WTQzMTVx?=
 =?utf-8?B?QlhTRUFQREI3OUlxcTlIa21wTFlqK0YvckVTdGg0KzFPTzk4NEJBVHdMcW9S?=
 =?utf-8?B?ZWxEN3VnaDB4dDBrQytScnpDbDBldU03QzJnWlUyUXRmWFJTMXBsWmZ6OWZQ?=
 =?utf-8?B?eWY5SEZpVHozZmZRc0htbXFpdU1Cbzk5ZG1Fb3lsQXlOMWpWblRadUFPc2xP?=
 =?utf-8?B?VGc1eGFhckMybGxuMzNSZ2tkQWRyRm5Jd2I0WmVyRDl1cUlGaWZQNGwxcGha?=
 =?utf-8?B?TmVtQmQ0ZmNVZ3BaWHBEMHR1aUJ2dC8rOFRKRGZkcEJTY1hCWVZ5Q1JsMkli?=
 =?utf-8?B?Zjh1K2szYnJiSzMrRXJrU1BDYVlxZXJXS3pNMWFROWpkaVdrOXNuUHdjZXNF?=
 =?utf-8?B?OE9GVWRRSHpuRjhmQWVDbkNkUVIxMGpJY3IyYTd3WG9zcUIzUjBEZ3h0Y2Q4?=
 =?utf-8?B?V1BtZjFZVXorSUo3NlRmemdkZkFadzdDNVp3azVhK3FoR0F0ZnhrWU5taFZU?=
 =?utf-8?B?OVQwZHJRdVM5Q3pUUjBiTWhvOENZNEU4Y3lEQVp4dStwOGVWeGlUM2lXWm9X?=
 =?utf-8?B?NU03UzlUdTZaMmxlazhtZi8xd0VJRHU1MGhMRm41dkt2bVI0ZHd4UzR1SGh2?=
 =?utf-8?B?cC9FTlNiRW0ySzhERW9ESU9ybXlLUG9MQ245cEtwSGVpRnZ3ZTZrdlBkQnJR?=
 =?utf-8?B?T2ZNY0lGNThaUG0rU2ZYQ0c5RnNLaklIZUdBenZ4ZElkdWRnWnIvOWFFcHdj?=
 =?utf-8?B?YXNjVHhuSjN0OSt5clNsaUsvdnBoMTJ1MzRESWFtaVpiZVdjQjlyRWlkMEJT?=
 =?utf-8?B?ck5WSEhya0dIRnlYMWhEN09CWk9sZERBeGZsTXdtR2h2akMyZHJZbnIvbnRn?=
 =?utf-8?B?eXo1SmhLb0E1RFlmTytUWVBUam1hYXZLZVRJZm9WeE9EWmRJL0dRWkJVa01O?=
 =?utf-8?B?YmlibFZVTll3eWFpb3B6WXQ3MlZZdXR6ZkhDazFUbEV5a0lEM0w1RlQ2eHI3?=
 =?utf-8?B?c2luamk3d1NWY1pTVURWNXQrWlZZRzdVU0hWbGMrbkRmbjMrUXFwOXpEZ2tY?=
 =?utf-8?B?RTZ0WDUxdjdKWmlwWFRKSC8zNWU4dkFpL0NZQ1RYYWpxQ3VBdmg5dE9zSU9U?=
 =?utf-8?B?T2ZSanRDMDFsdU0yMkdDZ3ZCSDZIODJsMUM0L1BtdDBFMmtncjNLdGRHTHhE?=
 =?utf-8?B?ZExzbU1WajMrM2xqeFpnR2tjMUN3OTlmOHdjQmVoWUdud1VGbEdHWDM2UjVW?=
 =?utf-8?B?YlEzNU5aTzJnTk5tRWd5SHM5cnY1Z3p4QVBmbWlUNGtVakV5R3VYL0RBNSs4?=
 =?utf-8?B?cERWeVIxR3JueHN6VEhQYUh3amdHanhCT2ZZOUoxT3BtVFlnZTNDeXZpZVVo?=
 =?utf-8?B?YVZCWXlYZXJRdnI5R3Qvc1VESHZ3cGVsNEYySk5nZm1Lc29BODl1Tkg1b1Nt?=
 =?utf-8?B?MHVwSzlwMnhHZVYzL0J3eWxISktyZkFtenBGZXp1RXo0Y0V1TzFQMFdKaytz?=
 =?utf-8?B?cUZha1F1WUk2V0w2NHZOYkhnTEgzeEx2YXdSYzdUYXk1d05wVWNYMHZjT3Vn?=
 =?utf-8?B?RVJHTFo1d1VJc2xqVlRVa2FZUjF3ekhvZ3FhR1pSaEN2RjlvajZneXNnQ3B0?=
 =?utf-8?B?ZTZ2ZTZSUUcwNnRRV3FOTkxERjVDR1J3TWRZand1TzVKdlVuUER1Y1U1K2FJ?=
 =?utf-8?B?VVdBUGova3BXcEdWd1pzck14UDM1VWkxMmFJL3QyckxQRDlDYUFjdWpJaVNu?=
 =?utf-8?B?SFBBQ1JmZUQ2UHUydmtWNW1BTlZ1cFpFWTdpckFXbU1uR2RvU2w4OWRMSmhP?=
 =?utf-8?Q?4wwOWWGXd9hdB+meLu9McCzl1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d3cc7f-af14-4a91-60a5-08da89ebeac1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:25:57.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qln67uiUVXrxrc1v0PbZsf3qMM7Up7nRq+f+Si1KStcBWsXiMGhG+G+41V17h5AaLNDYR7PIek7AujI+vy25uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290085
X-Proofpoint-ORIG-GUID: ujr0nrp2PDhfdMhvcs4UKv-7H-yV06D2
X-Proofpoint-GUID: ujr0nrp2PDhfdMhvcs4UKv-7H-yV06D2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/29/22 10:15 AM, Jeff Layton wrote:
> On Sun, 2022-08-28 at 17:47 -0700, Dai Ngo wrote:
>> Add the courtesy client shrinker to react to low memory condition
>> triggered by the memory shrinker.
>>
>> On the shrinker's count callback, we increment a callback counter
>> and return the number of outstanding courtesy clients. When the
>> laundromat runs, it checks if this counter is not zero and starts
>> reaping old courtesy clients. The maximum number of clients to be
>> reaped is limited to NFSD_CIENT_MAX_TRIM_PER_RUN (128). This limit
>> is to prevent the laundromat from spending too much time reaping
>> the clients and not processing other tasks in a timely manner.
>>
>> The laundromat is rescheduled to run sooner if it detects low
>> low memory condition and there are more clients to reap.
>>
>> On the shrinker's scan callback, we return the number of clients
>> That were reaped since the last scan callback. We can not reap
>> the clients on the scan callback context since destroying the
>> client might require call into the underlying filesystem or other
>> subsystems which might allocate memory which can cause deadlock.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/netns.h     |  3 +++
>>   fs/nfsd/nfs4state.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>>   fs/nfsd/nfsctl.c    |  6 ++++--
>>   fs/nfsd/nfsd.h      |  9 +++++++--
>>   4 files changed, 61 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 2695dff1378a..2a604951623f 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -194,6 +194,9 @@ struct nfsd_net {
>>   	int			nfs4_max_clients;
>>   
>>   	atomic_t		nfsd_courtesy_client_count;
>> +	atomic_t		nfsd_client_shrinker_cb_count;
>> +	atomic_t		nfsd_client_shrinker_reapcount;
>> +	struct shrinker		nfsd_client_shrinker;
>>   };
>>   
>>   /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 3d8d7ebb5b91..9d5a20f0c3c4 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4341,7 +4341,39 @@ nfsd4_init_slabs(void)
>>   	return -ENOMEM;
>>   }
>>   
>> -void nfsd4_init_leases_net(struct nfsd_net *nn)
>> +static unsigned long
>> +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
>> +{
>> +	struct nfsd_net *nn = container_of(shrink,
>> +			struct nfsd_net, nfsd_client_shrinker);
>> +
>> +	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
>> +	return (unsigned long)atomic_read(&nn->nfsd_courtesy_client_count);
>> +}
>> +
>> +static unsigned long
>> +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
>> +{
>> +	struct nfsd_net *nn = container_of(shrink,
>> +			struct nfsd_net, nfsd_client_shrinker);
>> +	unsigned long cnt;
>> +
>> +	cnt = atomic_read(&nn->nfsd_client_shrinker_reapcount);
>> +	atomic_set(&nn->nfsd_client_shrinker_reapcount, 0);
> Is it legit to return that we freed these objects when it hasn't
> actually been done yet? Maybe this should always return 0? I'm not sure
> what the rules are with shrinkers.

nfsd_client_shrinker_reapcount is the actual number of clients that
the laudromat was able to destroy in its last run.

>
> Either way, it seems like "scan" should cue the laundromat to run ASAP.
> When this is called, it may be quite some time before the laundromat
> runs again. Currently, it's always just scheduled it out to when we know
> there may be work to be done, but this is a different situation.

Normally the "scan" callback is used to free unused resources and return
the number of objects freed. For the NFSv4 clients, we can not free the
clients on the "scan" context due to potential deadlock and also the
laundromat might block while destroying the clients. Because of this we
use the "count" callback to notify the laundromat of the low memory
condition.

In the "count" callback we do not call mod_delayed_work to kick start
the laundromat since we do not want to rely on the inner working
mod_delayed_work to guarantee no deadlock. I also think we should do
the minimal while on the memory shrinker's callback context.

Once the laundromat runs it monitors the low memory condition and
reschedules itself to run immediately (NFSD_LAUNDROMAT_MINTIMEOUT) if
needed.

Thanks,
-Dai

>
>> +	return cnt;
>> +}
>> +
>> +static int
>> +nfsd_register_client_shrinker(struct nfsd_net *nn)
>> +{
>> +	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
>> +	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
>> +	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
>> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>> +}
>> +
>> +int
>> +nfsd4_init_leases_net(struct nfsd_net *nn)
>>   {
>>   	struct sysinfo si;
>>   	u64 max_clients;
>> @@ -4362,6 +4394,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
>>   	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>>   
>>   	atomic_set(&nn->nfsd_courtesy_client_count, 0);
>> +	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>> +	return nfsd_register_client_shrinker(nn);
>>   }
>>   
>>   static void init_nfs4_replay(struct nfs4_replay *rp)
>> @@ -5870,12 +5904,17 @@ static void
>>   nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>   				struct laundry_time *lt)
>>   {
>> -	unsigned int oldstate, maxreap, reapcnt = 0;
>> +	unsigned int oldstate, maxreap = 0, reapcnt = 0;
>> +	int cb_cnt;
>>   	struct list_head *pos, *next;
>>   	struct nfs4_client *clp;
>>   
>> -	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
>> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
>> +	cb_cnt = atomic_read(&nn->nfsd_client_shrinker_cb_count);
>> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients ||
>> +							cb_cnt) {
>> +		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
>> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>> +	}
>>   	INIT_LIST_HEAD(reaplist);
>>   	spin_lock(&nn->client_lock);
>>   	list_for_each_safe(pos, next, &nn->client_lru) {
>> @@ -5902,6 +5941,8 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>   		}
>>   	}
>>   	spin_unlock(&nn->client_lock);
>> +	if (cb_cnt)
>> +		atomic_add(reapcnt, &nn->nfsd_client_shrinker_reapcount);
>>   }
>>   
>>   static time64_t
>> @@ -5942,6 +5983,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   		list_del_init(&clp->cl_lru);
>>   		expire_client(clp);
>>   	}
>> +	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0)
>> +		lt.new_timeo = NFSD_LAUNDROMAT_MINTIMEOUT;
>>   	spin_lock(&state_lock);
>>   	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>   		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index 917fa1892fd2..597a26ad4183 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *net)
>>   		goto out_idmap_error;
>>   	nn->nfsd_versions = NULL;
>>   	nn->nfsd4_minorversions = NULL;
>> +	retval = nfsd4_init_leases_net(nn);
>> +	if (retval)
>> +		goto out_drc_error;
>>   	retval = nfsd_reply_cache_init(nn);
>>   	if (retval)
>>   		goto out_drc_error;
>> -	nfsd4_init_leases_net(nn);
>> -
>>   	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>>   	seqlock_init(&nn->writeverf_lock);
>>   
>> @@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *net)
>>   	nfsd_idmap_shutdown(net);
>>   	nfsd_export_shutdown(net);
>>   	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
>> +	nfsd4_leases_net_shutdown(nn);
>>   }
>>   
>>   static struct pernet_operations nfsd_net_ops = {
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 57a468ed85c3..7e05ab7a3532 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -498,7 +498,11 @@ extern void unregister_cld_notifier(void);
>>   extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>>   #endif
>>   
>> -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>> +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
>> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn)
>> +{
>> +	unregister_shrinker(&nn->nfsd_client_shrinker);
>> +};
>>   
>>   #else /* CONFIG_NFSD_V4 */
>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>> @@ -506,7 +510,8 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
>>   	return 0;
>>   }
>>   
>> -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
>> +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
>> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) { };
>>   
>>   #define register_cld_notifier() 0
>>   #define unregister_cld_notifier() do { } while(0)
