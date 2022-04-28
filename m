Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC965138E9
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349440AbiD1PqG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 11:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349449AbiD1PqC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 11:46:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306DB8207
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 08:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhCpWW7PkmixADL++8HLqA7F6L6t92TiUNT9bJZwt/6pDeARjo5KtHxslKH6CRe+WpOKsyxNPEpDpx3hlqOzfeHXhbsudmxoJI0BT7gC+s0PdY6MPOlxPWxpOJ7I5fZOf8st9gzEf1L3HQ2D8bcABbiWdqtHgndBsy914NdjsPyJtJFMkRdKlSGI1t0DJRqdWiQBeq03w0Q6Ke+z+u5MOCsLC+xvjbNH7/AAn3eUqgJOIWdEzCHKM/6uDnxG7UZLuz/JPiyhHtvTLKcQ6Q2g4let9HkyztTqeQ9d5Sky6iXPvu1GrhgBTqgl9N2+X3cBHI1u/txUmSIRjyJqZilOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH2HoYVuoWmn4M65Uhp48cex+GrsxcKsu9UGDF4vQHM=;
 b=ijWGX1uB0j6G1qYO7WzozC/hfJvdlqYfo8mR7SXadinN1cCiGJKb5W/sAWPVfXKZoiZTGknO707OORx2WGpZcUXYTWAs3XxR5pd3hqDO0cOLL0SDniZV2ZzbCNtXThOAs0gL2LVKWqlf8Co2a70+zba6n0xz3QQ8bIwaxv5rY8KNWrrN88A3IxKrElNX9g9ZUxzCWQW+cCo0slywTRPippfCd6+nuhypikb4BHsJkGxiP9Rgrm5yBEaclkZ0D+iVRlFUlnYIG7xepU7NhTsl17XShBDF9FmjTjoqO/BxpSw1xRsLDuK6SVhadrFDqAUuHQNgPTW4w0RgDDeXOT5yMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH2HoYVuoWmn4M65Uhp48cex+GrsxcKsu9UGDF4vQHM=;
 b=iczGtA580pD/yygQzASEZt+Ce3z6kfcUQXvUWJThLBRNcjj6m0FeRqc+oQyU3ylpNNJJEeyh5VUCjdwGZY1e9ArjRBKRMW6PWEasnWI1/d2USwtrYpOD3bPuSJI/BvsYSuh4dGrLIHdlR/njr9FmFFIYU+pmQsdhz2vGwBBnjoXWfdx+DrXBNyBX+ES7SChZJRPwgY1p8U1pnbu5x7w/aJpALB51J6+UXshEk3TKUiINIgSAqj+2JPjz7ing4lFJKygZAIR0t0iCgZIdXaNTDSQ4zaDVwvq4wQRNwDdBCrHw1OBz4a9+mL61ism6KyBxBQMbdhE+sdRdV777fcIJ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 DM6PR01MB5530.prod.exchangelabs.com (2603:10b6:5:152::27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 28 Apr 2022 15:42:43 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 15:42:43 +0000
Message-ID: <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
Date:   Thu, 28 Apr 2022 11:42:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17)
 To PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bffe5d60-7819-4f40-7e8d-08da292dbc15
X-MS-TrafficTypeDiagnostic: DM6PR01MB5530:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB5530191ACE6DB6D68565C86AF4FD9@DM6PR01MB5530.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TR2Ato2s3pArPCjL418MNXuO5atbJdWFhDJuG3zyhZ0QR8Egn+mYzycWjhIibexwUVGOUWqWbWBhqgMmpv7a0NcNfQDXnj8rXdGQhqQwVJjXX23y7DJjV5KSNiTfHEwZtOX+vCOipHyj3eJvUWQlbpbIj6h7qzjrdeDJAa5ESuVtWdlbYvgev4cf7Nf8d/I48SyxEOGXxUgEOmvsE3RZdTSxv/GXLAiXoNTPj+f9h+6bRzQLThVY9MXvxu2B7MBpsoQRXjTvYxNYH7ClaL/3aHw5Y5qihfZjAJ4EL/dyqoRZqYX6tUEwWPcY1xBRXyWvWQloPh/C5SBH7S0c7V6y6DNDSd4KEAVzUK4hEmrKGmDxkzoiLiJLrxTkssLYNAVCKRgTZkLXnbWC3yerSRYYYbmI1zcJRy9XmbjHY5UczzlwXJt+tr3qfG21cGnGhpY1YVZBGkNvfxt0p5abkM60no6bKZ2KseEuuldB/QIhUb77kPXXj1StHCvCgyw1yGms9ubvbYzWcIATUuZRz1NAGRezaShELFf9XSbnifEi6bEL+a6gEewKwEgzY2o37YZAnl1ZM5z8ERbUPr6d6yzRRaiFwVjste9HvzaYA5yvlWTiotnCKzdsj38Kbdf12j3U8cfRjdbA4+m5vCnd8xQhHwCmn7qD2fWRfaHLTAz7nJ7QUC57ixa0s2THQiUdYeialtk72vWzgUImdtX5op9igJ919g9n950ncgVIXcsxcmw6yM+wi9YQyu65p8tbQnFW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(39840400004)(376002)(136003)(346002)(366004)(83380400001)(38100700002)(38350700002)(186003)(8936002)(8676002)(4326008)(5660300002)(36756003)(44832011)(4744005)(2906002)(31686004)(6506007)(6666004)(6512007)(52116002)(66476007)(2616005)(6486002)(66946007)(66556008)(53546011)(26005)(86362001)(6916009)(508600001)(316002)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBvSDdRY1I5TTM0OXpQVHAyR3FheGRIM2hlelh0Q2VEMHpiSDRwRzlHaHdY?=
 =?utf-8?B?QmZZR1oza2crR1dSSEpFZS9xZFZ0ZWI4U2NkbXZqcllGRUNlQkg2aU5xRzRh?=
 =?utf-8?B?S3NORTlOc1BQUHEvREhUNHZDUmdQZzl0QUtiWFVIUFp4NHFtRmloSjVoMGdS?=
 =?utf-8?B?VTdieVhHSzQydm5mckhtS0wwUEVpekhYcXhUZnBkUGZ1b2NhUGlnM2NUR0kv?=
 =?utf-8?B?VGhwbGtoS0lSY250N05FMXBTU1AyVzF3REswMGVDYjh0bmRDUys4OGg3SU85?=
 =?utf-8?B?dTgwZUIrK0VsM2Rncnpud3BvNC9xWWhIQmRRTUxFMXAxV09LRTIvTHkwaVJY?=
 =?utf-8?B?UUYzbDJKNWtQRWFFTmVLQnh3V2Y4MGFuOVZDQXVYQ3ZuNzFoL25ZblZYVFNP?=
 =?utf-8?B?bVdlZFJiUkFZSnk5VlF2UmNsNlVFeTdhUkxZQ2FOdTI3dmhkY043elJlOFdo?=
 =?utf-8?B?VXhvM2V6RzdEd0ZIa3RieDNSbDdUaDRkV3BMYzZmMjc4MlV5bEZTOGdZbStB?=
 =?utf-8?B?a2dibUNuOGFCaWhiUm5FL0w3dDVhRG9HajU4NDZPU1Y0eGgwMG13Tk03dDFx?=
 =?utf-8?B?aDBVZ1lKV2dreUNscHpDUnh2MVRwSmxPdzR6YzVmSCtkcEVZVE9YMHo4a0t2?=
 =?utf-8?B?MTdPUjVmU3ljbWZFbWdxek9VM3J3aGU4THcwL0hKLy9aN3Vadi9iV0ZHeDhs?=
 =?utf-8?B?NnB0elNWQy9lWmRIejdoOHJPZldZaXI3VkM5UXNJZ3hTaTlXT01zODNBN1hM?=
 =?utf-8?B?Vng1Q09SWEhDSEpDMXYxUXYvMCs5Q1JycVNBVW5QWnJkejFLRkR4Rkkzckx0?=
 =?utf-8?B?WHdyM09HS045UEk1MkdBRE1TcVlmdzcrSXRPejZZakhHS0psb0dLMmRoTlAr?=
 =?utf-8?B?eXBSeVo1YnY5TWZmZU9XSytVSVI4dnI4dWcvb3plbFRPS3hDaDBKcGFSR0sy?=
 =?utf-8?B?bHdrUE92c0YwOGNlakJoaHlSR1lkNnpCRDFlWWxQbjdrcm5tUm9YUU5DY0VX?=
 =?utf-8?B?SGNKcXdnUEh5ajQzT05HUmJFN2dsWi9Wd2cvRWpvMU9kSytJZFFrNkdYUWFM?=
 =?utf-8?B?VEpEYlNET2JTTFkyK1ZMMGxUb0hYV004bFBFeVBQeVZnMnpqUGQ4a21KOEtE?=
 =?utf-8?B?dlF6SW9odmVBVjhIb3Z1ZW56R05WRG5NZXZ0U0d0RmJ6MnE4OUxWSHNTVit1?=
 =?utf-8?B?dkovU041VzBWZ2k4UzhJcUlXZUgyUFdsclRFT2F2YTZNSTV4b0NoSFRrVHhP?=
 =?utf-8?B?TFUvSWJtR0QveEVCN24vRE9pb0Yvc1pHRGI3TGRJSDdXVU5yaXNIYk92Lyt3?=
 =?utf-8?B?WmRCNk8zbmoxcDluQ2F5MVpPREtlcGJPYklIdjErakpOM29BMDg4MllQbHBa?=
 =?utf-8?B?dWc5U08rSkJQdTJpdVdEYzhYT201L1ljclcyRHA1M2kxMnczT2cvN29vaTcr?=
 =?utf-8?B?UFBNbmM2MEVDNG8yRjRqTXA4cXZ3V2l1b1RQTEtqbUMwOWc5MjhuMXNNUmpj?=
 =?utf-8?B?N2pIUm84UDNaMEpvcC9pSmQwYk81dnAvNzY5SnBFVkEvRDduVEFobG44ZHJZ?=
 =?utf-8?B?a3NncnJ6anNrRlZMT1diQk5nWjYrSHZoaFByWTZEdGF0dE5HK1Ixb040WW5q?=
 =?utf-8?B?YjJjL3krYTFKMnJOK0tKaFNZNDJxenlHaStjYURuc2VQbTN3RGk4Q0hyRTZT?=
 =?utf-8?B?SkJTLzh1TUpFeURBbnpGazhqOXMxOFdKVU82NWxJUDI4Tmd2LzNOejdtcWMy?=
 =?utf-8?B?d3ZWZzcxZzVuS2JmL2xSVGR6TzN1ZExEV1hlSTY5cml1d2FVS1Q3a3BsMFVY?=
 =?utf-8?B?djBnSTE2N0N6UDNGb1BrQ1pNYVBzZlZvWklYZmI4SEF5dzNFa0ZKOVExUjVD?=
 =?utf-8?B?Ykkwd2tMSkFQeEptNnJ4TCtsTGNHNTBmWGZkUXhyVkpJckpFTGJiWWFKdzhW?=
 =?utf-8?B?TG1JY1BZT2FOUDc2Sy9HV0FOTmJ1R0VLOEExMDZQR0dHcHFzL1pYQ3Y4QUZO?=
 =?utf-8?B?MWZ4ejVtcVg5bnRhQk00aTRZL0NmNlpmdlBxVlpaT2NKODR2Y3lhbC9pTnBG?=
 =?utf-8?B?MEpnR1QyQ0Jyb292VmZUenpSTHROT05DTk5zOEVNaitBMWFOYStiK1dXd0tZ?=
 =?utf-8?B?eUwxTjl3WG9NdlZaVDhRVHk2MkUwUlN5cTg1aHFkREMyRUQ4RExmeVJPUUdJ?=
 =?utf-8?B?Q0ZNYVR1QXc1U0c2UUQwUm9nNm9mQ3dyNTU1b2dPY0VZTFFMSnZXazBGZU9w?=
 =?utf-8?B?ZjdKQUtESzZQOXJmY3hrNENucWsyRnBML3JyNFJ6NVNkK0RHd0VOcTZweDZ4?=
 =?utf-8?B?UVBMbVNaK1Ryb3A1RE5VTGRoM2RXZDA5N2RYa3ZOdG4yMGtENFBuczNpMXZH?=
 =?utf-8?Q?KyhER+V75jSzbwmsNClZvGZlDxlx/AVyZGkGG?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffe5d60-7819-4f40-7e8d-08da292dbc15
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 15:42:43.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Id1C4Hsj6dVw9BtyBmw8Qd7CevVNzfJ6iGurvsElTcu466Xg38iJcjx0w3YOmJOFR8+U1/AEYsgSbGKNAN/B5t1IqxLJ59I8rtnv/lcyCQ+FBeI+nq1xGaswTLiqgXy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4/28/22 10:57 AM, Chuck Lever III wrote:
>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com> wrote:
>>
>> Hi NFS folks,
>>
>> I've noticed a pretty nasty regression in our NFS capability between 5.17 and
>> 5.18-rc1. I've tried to bisect but not having any luck. The problem I'm seeing
>> is it takes 3 minutes to copy a file from NFS to the local disk. When it should
>> take less than half a second, which it did up through 5.17.
>>
>> It doesn't seem to be network related, but can't rule that out completely.
>>
>> I tried to bisect but the problem can be intermittent. Some runs I'll see a
>> problem in 3 out of 100 cycles, sometimes 0 out of 100. Sometimes I'll see it
>> 100 out of 100.
> 
> It's not clear from your problem report whether the problem appears
> when it's the server running v5.18-rc or the client.

That's because I don't know which it is. I'll do a quick test and find out. I
was testing the same kernel across both nodes.

-Denny

