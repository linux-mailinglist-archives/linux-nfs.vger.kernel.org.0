Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2613752617C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380097AbiEML6i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 07:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiEML6h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 07:58:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2104.outbound.protection.outlook.com [40.107.223.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E793E23E296
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 04:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsnmgaPaBxm6NbN/uFrnNIBN2D1YmIo11uPxDPo4ifxoDy+oODRpSB8ko3vUlFmW+9bGFgUrLrcOcdiFnZHY/qRLL/eYN4UHc6FFwqmQrHkcEffNinGccMQ19/yCyKSVYvYhzfwPOUpvn1aYSk7Zy7tKyBu5bYz9uNLFMEqGiKJpvwX9MkFvvai8P9dKGd5uGecF3pEQrgfDv9IAppnys7h0XxFUSrFKaTlC8B0LjjbweiCJTCQCS+lvZzFs4UI+fRQkIs2Q3hiXtNl1oz+6/TrnNGWyxWoeAzBAr9EycBFQs9BmFoIRuhWcabp4k4Au/6c8xiUjA/TANRInWxIKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isS/EAy7fNDdUKizK+3OAEz4kMDxp8Ob2d61x9RPk5U=;
 b=Gg6vaDPoK/Z3GxlqBiKuZh6XHAQDXD/mlZOAOp2gYRa1lmoadjANC2AIOVXtaX+TxW9UmRKwk+HiuhJvhln16I/BHrT2rro0ijpUFDyCetSCD3tOtwER3vK8TTctTTgVnGORPJoATf8G/4AnnW402MsyQ8D6qnfgm3SYgyDtNCd+HOBNaDeksuCj3dZueOAXqc/ytIiDhYD5Ex/L4Z79tfjk2CPh6XnhR+8Moit2C2818mZMkVTsmTn1O/A0fEnsLbkqWZYDFNfu7OMcIqCfsAmPuSoPxhCvIawONXD2FnQm3x8X+tYQ8+AaFBVpClv/uC5FJ4g8SN/q3qu8Z7MgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isS/EAy7fNDdUKizK+3OAEz4kMDxp8Ob2d61x9RPk5U=;
 b=kr51i9VHEUvOnQGy/Kd7GDV1Oa+4Lwc1Qm/Nb9Dma+S+ypGgGUi7orzZMCqjR34xIcSqPTbKf1eCa+6PwUVdVAvFZQlr6//3YVXyFA6wd22EaRW8u8Us/LtVujxCS28TcgO92a5ab3xzhXphdKYry7oUrCBuisYFL6VRtyZcHSZM7fCWWTdqNNoyJyixYRfmKjF55gcW/e5qje7JnCdIjof0S7Rio23tCngeTb1esA2tyNMrBEC+rKZr2ydv8EyQHMjFFpGBKXDZfoL6gRmLT6Nb+JpISF+npjSby/uRAQmJTl+oDeI3d3Y9N18gIY2rIDlSOwUPMQTxWjbKPLn8WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BYAPR01MB4886.prod.exchangelabs.com (2603:10b6:a03:1b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Fri, 13 May 2022 11:58:33 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::bd41:9ade:6b17:e6d]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::bd41:9ade:6b17:e6d%5]) with mapi id 15.20.5250.016; Fri, 13 May 2022
 11:58:33 +0000
Message-ID: <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
Date:   Fri, 13 May 2022 07:58:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
In-Reply-To: <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78965ff8-662e-4d08-3c04-08da34d7e750
X-MS-TrafficTypeDiagnostic: BYAPR01MB4886:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB48865D4EB847074CEF6AA8CFF4CA9@BYAPR01MB4886.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4ML0yJ8yDTyPhgGjqYWteENyMl5MoeZ5zXcAL9CWvHR9UopkyCJF6hGUoivBnPk8WhKYZT0uuXvIqrOlVfYxD5yW4Lt/rLpT5FPwzKELbjwPYXAtpr1g89xdCt9u7hev98H2JwauW7qtP1xSynwcHdGrOsVoKmk9M4y9tO5yZlojwElH1cC/+mGdKctfDOMyb4LDupbGl8QC4Qp+TDWiJIH11dl4JpCdW9rPp64e2BGpLuazpbFv8OLZMjzT5mFEiVevD9qitrO6O40+KloApwX+ISw0TCUYdVw62I9+mgb00XZS6FqtjmQrHLReA3GJ6mXdJK7AMd3BGaEdwFsXMhDfIPM6LRDS4qNB4P9lzwt7U7bqOeja6XRAWZ4Z6THiTb1jJjPfDTfUilLTrUax/Fdmc+yFsI80UL8faY7UP+0OQ5lOeE1WPBfFVRILa1RWf+iBhb6HSW4iL0AP57qM/4LO1p5q/4GB9AQf5ZWnBJ0NcURIaZwbdsS9K9lLTPUBytXNJoySfyvXDX+LChSPmHyXRIgn59mokpG3Yl7TId1smiQfV1m/T9KV3BmPGGmb9ydQbc81k95HT5ImkjdCaVDo04BYNe1WK/Q9IvBZzkkI18I5nB7n6VD1J8PdK8aDQXTO1dB86xiRLtlLJhbZ5d8L07m6Epuvn3clTW7Wf++JIq9qBP54+PHFe5FVPsD75I5OqHwyYxiVV8Pcf2TiRzsXuaL4U9aVKMmRbn9tRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(136003)(346002)(376002)(396003)(39840400004)(6916009)(53546011)(31686004)(52116002)(86362001)(83380400001)(6486002)(5660300002)(36756003)(26005)(186003)(316002)(44832011)(8936002)(2906002)(6506007)(6512007)(38350700002)(38100700002)(54906003)(31696002)(2616005)(66476007)(66556008)(66946007)(508600001)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXp1ZTF6U25GZnpBcStwZnlyVXNJQVl4by80eHd0azQ2ZzJzb1NWNld4cE1i?=
 =?utf-8?B?QzNhekY0clk4ODkwem14ZVVaaExzdkpWeU9qQnMwdEYxbXo2RmttUVBWUnFX?=
 =?utf-8?B?ZjVVc2V0YTFaSUtjS2tDMDJWclR3TllnY2Z1RzM0Q24rUkEyY2x6ZEpTL3Rt?=
 =?utf-8?B?NXhDd2ZnR3B6c1lCbW1mWSt2L2pLd0RKTWxOMDNTMG96clF1RFZic3VmUE9T?=
 =?utf-8?B?NDJFMGZLdWpaczNDYm15WHdGQ0poRWprNzVJVXBNYTJvbFZjVlBsQ0V6WWJm?=
 =?utf-8?B?Nlg0blpiL01RRW5oeFVVdEdkUmJhTml1MERxeUtEUGNJa21QbVJJUk5Edy9n?=
 =?utf-8?B?VlNqR3NEZSt1UW9aeno0RzBzNkYzRXIzbkJnd2xMeG94YndlaUNScXhQNEZh?=
 =?utf-8?B?VXhmNnNtMWR3cnJvZ1JHWVhZRGZNbVBkTEpVUjRoanBJMmVqRXluRVpJZGxO?=
 =?utf-8?B?MzlXSnFmZkNnKzFabTVPcmFzZWpsTkdTU24yV2RORHBPTFk0Y1Vpd1JDNHUy?=
 =?utf-8?B?M3BzbStDQlZWNXFOekgrR1gxMllKSUVGeWNLZUp0Tm1zOXNOa1RNWCtjdkI2?=
 =?utf-8?B?WHdDcmtsbVY5T0xBdWhRc2tnMTFNUnRKWVBiR2ZZcTBWZ054S0V4bFRrSjR6?=
 =?utf-8?B?bWNDRTB2N3ZjSEVKa1NWSHdCMTVZd20xdTkvZmZydFZFSDFXSWhHY1E3RytK?=
 =?utf-8?B?a0pSNE1Qb1FTVllVem9VeERlK0xnSDRUdlBNbWNFbHpmRWIvWDlTME5zMTJC?=
 =?utf-8?B?RnFMUDZ6NGF4SzQyaW5LNjdNbzA1WjVLWVRXd0YwY2V3MUVLMitXZnVIN2E1?=
 =?utf-8?B?RCtJNUpsMFJlY0ZvL3dZYXNiVDVSdGhMN3U1MmJ6UDR3YmJVenR1STVNZTJZ?=
 =?utf-8?B?L3JRVUxWYWI5VjJQUzZRVVVPWWU5OU5VR3U1ZHdNRnJrWDdQYXJOVXJkOUJM?=
 =?utf-8?B?RHBUd2F4R2hRNGNRTUg3NnZtMXdlSWtwUHVzNkdmK3hjazhRUGVtMlFET1ht?=
 =?utf-8?B?dzRRNDFXbmNKZU81RGxrVTRmYmtEU0ZEZUZnWmxVZk9yODNoUSs5ZkJmeUJF?=
 =?utf-8?B?UWlNc0EwM0s4S210Tkk0aUU3Qjl4MUZXWHZkd1JkN216UlEzcjBkckROUWlV?=
 =?utf-8?B?TzJhL2g3aTVpbTdOdkhXR3NadHhTUUdwWGhmdjNXb2ZmTUc5R0ZCZGwyRlVx?=
 =?utf-8?B?S2t0ck5CSG4veXY4Mkp5L1RReXNCTXAyb2pwNjVKSEpqN0RNM2tIMnN1dFFo?=
 =?utf-8?B?UXdIbE81UjA2NitYUW1VQTU1aWxCdWtoaWVEVEJlY0lnOC8wSVpEd3lpaXo4?=
 =?utf-8?B?WnkzaTZ4VU5XRDZVNVgwcXZZdTBaL0NOMzNUVnBqRGw1aHA1WjVkVSsxRzYw?=
 =?utf-8?B?d0g0NkJ0b3lEL2Q0Ri9HaWtVa2hYV29BMDcrWURuRHpQY0ZHaDYwRE9vMTI1?=
 =?utf-8?B?bE5tc1dTU0Y2SW5Fb0doc3Bic204eWNaVlJMTU5MdExZK3F5cjQwODhZQlMr?=
 =?utf-8?B?VUF0Z0FTWkJlZTVZa1IxUEFQMnl1SmRieFBTNzdlOTdOekNGK0RJTDBXd1VU?=
 =?utf-8?B?Y3NmWVhzZUwveEVjL2RyMHRZb2ZqMGNGYnJJaWpBcC9YZjZoU1NPTHF6KzlR?=
 =?utf-8?B?WUU0V0g5ZHNsNGlDbUZGNGpjNnRpZDF3L3RzSkdRQ2dVcXpLQUZIejRnOGNU?=
 =?utf-8?B?SHZvK0VoR3poMmxyRnhxQWdGdGJRelRKRE5LeWFSMlljTzFFR0twTXBRWGFV?=
 =?utf-8?B?TVF0Rm0xN0FhcXIwMVlSMFhMOFZWY3NnS0p3MFpDcVBqVTBYRUt3UFNwMGdO?=
 =?utf-8?B?L1dTQnZDcTZyOVk5Q0V1YVFiR2puTGlGRjdZVThYakdRN1g3R1ZHTzUrYW90?=
 =?utf-8?B?QkZzVEUzK2l5V3MvYm0wbjVmbVdRQjBNQ3FhUjJYbWFmNXFBN2pSNitqSU5B?=
 =?utf-8?B?d1g2NEUxcThZaWpndTNpdFNkMHVKNzVsOUt4R3Q5ay9hSDd2N0c1bTZUMXBj?=
 =?utf-8?B?eHhPNmdsT3NHeFpIVUhYdTBTZGhvM1QxVm8wWFRjVFlSM1hvQVA5dE5nOGl0?=
 =?utf-8?B?MG4xY3ByQU9kT3pERU5QS2orb2NOSnhyOER0a2VVTUJ4aHJZa3Myb1FlM21j?=
 =?utf-8?B?cHFieUh2R0ExOGx4TWtDZWdlZXFtN2NnV240d0V2d2xaaXQ5MmgxZ3VvVkRt?=
 =?utf-8?B?bTFSMDF4M1FJeW82Nm9XNUpVWENmTlFiZWdaUjRlWm1Ed2lxSWFnQnRUYVFl?=
 =?utf-8?B?REtHUVhHQUpyR1N6NUhuN2UyUDUvaHJHUFoxdTZmRWZSTmVpc2lCaUI4aHdT?=
 =?utf-8?B?QjVWSVU1dm1RcjNtV3ArbzR6SVU5MGhHQUJPTWpCM3BiWUh3VVVVSTgzdGVj?=
 =?utf-8?Q?DlzLOf9Lr67mG0mG7PyRv4rSTU2Vq+DcqLN0s?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78965ff8-662e-4d08-3c04-08da34d7e750
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 11:58:33.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YI1kTCshBPqLBCMY5d8spROZ/+ZQatGLEYAuL6/KgRoM7QVB8L4E6Rq9qY72HhWfVyAQFq5XiB2Qgj85bgzUrNaVsROZ9tS0ZGEhneATfLuezwepcZNary0aVn8zr8Hw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4886
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/6/22 9:24 AM, Dennis Dalessandro wrote:
> On 4/29/22 9:37 AM, Chuck Lever III wrote:
>>
>>
>>> On Apr 29, 2022, at 8:54 AM, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>
>>> On 4/28/22 3:56 PM, Trond Myklebust wrote:
>>>> On Thu, 2022-04-28 at 15:47 -0400, Dennis Dalessandro wrote:
>>>>> On 4/28/22 11:42 AM, Dennis Dalessandro wrote:
>>>>>> On 4/28/22 10:57 AM, Chuck Lever III wrote:
>>>>>>>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro
>>>>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>>>>
>>>>>>>> Hi NFS folks,
>>>>>>>>
>>>>>>>> I've noticed a pretty nasty regression in our NFS capability
>>>>>>>> between 5.17 and
>>>>>>>> 5.18-rc1. I've tried to bisect but not having any luck. The
>>>>>>>> problem I'm seeing
>>>>>>>> is it takes 3 minutes to copy a file from NFS to the local
>>>>>>>> disk. When it should
>>>>>>>> take less than half a second, which it did up through 5.17.
>>>>>>>>
>>>>>>>> It doesn't seem to be network related, but can't rule that out
>>>>>>>> completely.
>>>>>>>>
>>>>>>>> I tried to bisect but the problem can be intermittent. Some
>>>>>>>> runs I'll see a
>>>>>>>> problem in 3 out of 100 cycles, sometimes 0 out of 100.
>>>>>>>> Sometimes I'll see it
>>>>>>>> 100 out of 100.
>>>>>>>
>>>>>>> It's not clear from your problem report whether the problem
>>>>>>> appears
>>>>>>> when it's the server running v5.18-rc or the client.
>>>>>>
>>>>>> That's because I don't know which it is. I'll do a quick test and
>>>>>> find out. I
>>>>>> was testing the same kernel across both nodes.
>>>>>
>>>>> Looks like it is the client.
>>>>>
>>>>> server  client  result
>>>>> ------  ------  ------
>>>>> 5.17    5.17    Pass
>>>>> 5.17    5.18    Fail
>>>>> 5.18    5.18    Fail
>>>>> 5.18    5.17    Pass
>>>>>
>>>>> Is there a patch for the client issue you mentioned that I could try?
>>>>>
>>>>> -Denny
>>>>
>>>> Try this one
>>>
>>> Thanks for the patch. Unfortunately it doesn't seem to solve the issue, still
>>> see intermittent hangs. I applied it on top of -rc4:
>>>
>>> copy /mnt/nfs_test/run_nfs_test.junk to /dev/shm/run_nfs_test.tmp...
>>>
>>> real    2m6.072s
>>> user    0m0.002s
>>> sys     0m0.263s
>>> Done
>>>
>>> While it was hung I checked the mem usage on the machine:
>>>
>>> # free -h
>>>              total        used        free      shared  buff/cache   available
>>> Mem:           62Gi       871Mi        61Gi       342Mi       889Mi        61Gi
>>> Swap:         4.0Gi          0B       4.0Gi
>>>
>>> Doesn't appear to be under memory pressure.
>>
>> Hi, since you know now that it is the client, perhaps a bisect
>> would be more successful?
> 
> I've been testing all week. I pulled the nfs-rdma tree that was sent to Linus
> for 5.18 and tested. I see the problem on pretty much all the patches. However
> it's the frequency that it hits which changes.
> 
> I'll see 1-5 cycles out of 2500 where the copy takes minutes up to:
> "NFS: Convert readdir page cache to use a cookie based index"
> 
> After this I start seeing it around 10 times in 500 and by the last patch 10
> times in less than 100.
> 
> Is there any kind of tracing/debugging I could turn on to get more insight on
> what is taking so long when it does go bad?
> 

Ran a test with -rc6 and this time see a hung task trace on the console as well
as an NFS RPC error.

[32719.991175] nfs: RPC call returned error 512
.
.
.
[32933.285126] INFO: task kworker/u145:23:886141 blocked for more than 122 seconds.
[32933.293543]       Tainted: G S                5.18.0-rc6 #1
[32933.299869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[32933.308740] task:kworker/u145:23 state:D stack:    0 pid:886141 ppid:     2
flags:0x00004000
[32933.318321] Workqueue: rpciod rpc_async_schedule [sunrpc]
[32933.324524] Call Trace:
[32933.327347]  <TASK>
[32933.329785]  __schedule+0x3dd/0x970
[32933.333783]  schedule+0x41/0xa0
[32933.337388]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
[32933.343639]  ? prepare_to_wait+0xd0/0xd0
[32933.348123]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
[32933.354183]  xprt_release+0x26/0x140 [sunrpc]
[32933.359168]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
[32933.365225]  rpc_release_resources_task+0xe/0x50 [sunrpc]
[32933.371381]  __rpc_execute+0x2c5/0x4e0 [sunrpc]
[32933.376564]  ? __switch_to_asm+0x42/0x70
[32933.381046]  ? finish_task_switch+0xb2/0x2c0
[32933.385918]  rpc_async_schedule+0x29/0x40 [sunrpc]
[32933.391391]  process_one_work+0x1c8/0x390
[32933.395975]  worker_thread+0x30/0x360
[32933.400162]  ? process_one_work+0x390/0x390
[32933.404931]  kthread+0xd9/0x100
[32933.408536]  ? kthread_complete_and_exit+0x20/0x20
[32933.413984]  ret_from_fork+0x22/0x30
[32933.418074]  </TASK>

The call trace shows up again at 245, 368, and 491 seconds. Same task, same trace.




