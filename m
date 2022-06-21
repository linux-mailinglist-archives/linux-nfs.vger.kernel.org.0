Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1982553847
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 18:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiFUQ62 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiFUQ60 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 12:58:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2108.outbound.protection.outlook.com [40.107.243.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C919D1C906
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 09:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhhy9G2B1hNP46euJJ+BxvytBvLQ5+ifFmzF8duZlg5Wbwc7KlHOfIvIf6oQXtlQkprmUDHg6+837vzww2RJnxpvZFc/A+CQ+WtEY7e+n9SKNzr0tHC3WCl5LSdo3n+DpB2sdd0KnUY56c1bgCb8GymQAVSrZ+Kq3tAIxOQKt8X/voLa5kGzCFDRj6G4sYXICdG4H/E+hcKErZFExEoTuiJZJOhDEfm2MjEaC8lp9ecMpb5sXhTrly+X3JuHV2wwmepMzemBfWgRzIHYZIFdI16z8ReEkqZlgh5hAQ1FXS+gQ/dGYEt9N7NFQdWVHIZXEy7Y76kYSFl+nOKm9qPHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBSHRHsI2KcIEM/pVdhQ1Fq4Lgvbn+1iXH4gJXLVnDg=;
 b=aTWz0VkjFY99bA3i5HJPXNj38QIC0Dz0/qvm09BYQPUrDl8U3VzG1H2ZYHTXqYZ6wzY36KflKTDpQEDr5ppGfOqO1AH4sAvtKnjxrTw9H4QLTqzxUI0pWZ2NLOF/5fAIsbDkMHazpVHHWOoyfh2JgfEjFo+V9KuC5MzcCer3GqesWdKrLH9rx+MUOfaUl0uVatoYAJ80W+g0WyUiPrhh7ItzK0eEYU1vU5urukJ4Lpj5Qq5gFqJQWI1RKn0GPE2YYYaiYxjiWxzq9piaEwh7il4zjndlg8Kf8KvKIotGg7uDbXSUoI5JxWsmCX5JRiEpgt2g6oSQCVGih0DSx5vyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBSHRHsI2KcIEM/pVdhQ1Fq4Lgvbn+1iXH4gJXLVnDg=;
 b=JyayDjjD34hUgY2fP5nPJfyIacnYc+GdaMHPVW56Lth1iNF0X8SWCEFpzCdkpgPbnqf3Q8FGJ6PVcaeBqJZOWzU6zTUfzPUbSNV40Qj3YUaUJkkC2pGwtcHm+pFzJXw0NCKll6y3GhGKS4d7/5gAXPcx0ybfaboIphzXhgBJKzpOuHmiBMV+C1KXku0n1EFzKZvq75n1EnQB2T3e5Zz0kJo44uuxIIgs27I7I9Db7GdQShJjM3akIzW+u/iaHb21AztDWhRWE8iSN9RIzmHwQ6VVxVmVHBZOy5VuyII3uPGWpvYKPyoNChp+XlM+1tQylGxkZd5D5s7FMrx9yPnPLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BYAPR01MB4471.prod.exchangelabs.com (2603:10b6:a03:a1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Tue, 21 Jun 2022 16:58:20 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 16:58:19 +0000
Message-ID: <31af1a7f-51a7-87eb-aba1-ad933a845423@cornelisnetworks.com>
Date:   Tue, 21 Jun 2022 12:58:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
 <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
 <DA2DB426-6658-43CC-B331-C66B79BE8395@oracle.com>
 <1fa761b5-8083-793c-1249-d84c6ee21872@leemhuis.info>
 <C305FE22-345C-4D88-A03B-D01E326467C8@oracle.com>
 <540c0a10-e2eb-57e9-9a71-22cf64babd8e@leemhuis.info>
 <916910EC-4F57-4071-8A4E-FC21ED76839A@oracle.com>
 <0faa0fce-52ef-de28-7594-6e93bb47fec6@cornelisnetworks.com>
 <CAN-5tyFWse4YP8dCGtQMDnqm5s+WsK8HqbitD2dAF5PayJMsEw@mail.gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <CAN-5tyFWse4YP8dCGtQMDnqm5s+WsK8HqbitD2dAF5PayJMsEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::31) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d297fc7-331e-401e-5343-08da53a73e5d
X-MS-TrafficTypeDiagnostic: BYAPR01MB4471:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB44712F3D6E39F38ADA6F61C9F4B39@BYAPR01MB4471.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFRfGS8XdweOMKgvK7wxtpjBFMQgzlp8k4MmxAPqeEChgx11lLy0dZGzsdSGRjaZxukY4T4jwQMbwumv7/TbN1pYx6/ka3hkgtnzpbQ8vuVDnR50pAxDyk2eG/fKZhl9KUXjQOb8pe3mDWvkFMIWJFwUh2DhpHS+P9No72dJ0HoU50EfpYbEtiGfFeVrk+71rigfGpNwa9GsHBZO+vHBBRHNodcYCcLsdd/r6+0WGEgAJPizDU9H3GzpJaEuC3krUcxxkRBUWXKakZvSw8DHL2ZK7QnSRN5EU+q0HMDvazQwZiIDP8hjSYWNCyOLm8ev+KmUR0F2fUn6EkQ37vsOiYhKe/xCwebUCc6ZTxh9F61KCuBz1VbPUvn6rWsCh4U5L5957Szfw9RCklC8d8duP+SI1ypJ4Jkn2mLI4g7BfaUUkp9p9YzHAyw/tdD41ofj6sXH/E1NwyHdJE2Px3mEb1n3mn+32TQZ3QmbnJCaCMtrPw4J79uKGrYFb24VXd/023ijqLGQWTa3GLgTwfdkD5oFWHrY+jDYv2JCIkNcrH43Gq+myN7+c6EPc8klHzh34weYu0NQSb+6gnixts/udPcYV7ai2qIY09MM0EfjjPqLznCMTI4rmRawYMRvQsI+2k92fG5GByYE3CZ1SfcX9CGyMze5EibKTejl8jPR5ugKf7tVc+9/9JWU7A/gsGAfmIaH+lsbVvAAFi2QddMRFuZFJke0ULWe9e8cYZ3m1b+0iHXhkmFpQfuGX1A5tQnks22k1xEFNywQqynW7uUD7uSU9F3KQAajbRpwu1pTlOtcExsEPRN6GMgbGEuRfGHps97SeX9smO3CO4uvh2Ey1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(966005)(6486002)(478600001)(6916009)(66946007)(2616005)(31686004)(54906003)(316002)(186003)(41300700001)(66556008)(66476007)(4326008)(8676002)(83380400001)(8936002)(5660300002)(52116002)(2906002)(53546011)(38100700002)(38350700002)(6506007)(6512007)(26005)(31696002)(36756003)(86362001)(44832011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHgxdDlvdE1JaUcwVWNvL2hYeStGYkdITGd1V2o3bDQvS2NFeW1tWWNMcWNx?=
 =?utf-8?B?SWQwTjlBemQrSFlSaFkxZzVucFpGZGxKRU9nVXBScllJVkZ6QXN5cUdlcVZ4?=
 =?utf-8?B?OXZtZEI3R0J5K2hKK0lONWxYdTNOeDZtcWZXdFpMWm9qOHpXS25NOTlUazV6?=
 =?utf-8?B?dGowY25wdXZKRGpXS1FxcnJyUUE3RnRxZTJ0N1BjTVMyL01oMEZ6Ym85NUc1?=
 =?utf-8?B?V3hnUXgxNnRhRFlQVlJvRHo3RDljUEVmSUxHUWZPeHFzd1JlaG9MdTFjRFFp?=
 =?utf-8?B?TjNrYUhaUU5vUlhpcXZBMmJVdVBzaWxxUHpzRmtjdjZXc3FndmtMV1FNNGR1?=
 =?utf-8?B?NUxnN1gzem1yZXUxb1FmTXQ5Szd6UEVzTUkzU3AzYko5RFh5VUxNeFdBeFVC?=
 =?utf-8?B?RGZLY05nOFVzZDFmL1Z3L0EwY2lMU2QyU0lvamV2c1dvRjk4b3d4dWRKZDhZ?=
 =?utf-8?B?VC9FQytUSnFWN0w4WEFrd2dMMkZWQkFTVzNCTDdKYytsSlhMNG5tcjN6cDU3?=
 =?utf-8?B?WjFzcno4ZTFwNXZJZ0w4WTd5dXdzR0pGL0VjMXNDQ0xPQVFydFAxbm5MdG4w?=
 =?utf-8?B?SzFjVTNmOEIzM2MyWUdYd0RYbjdmbkxhKzNmRDE2Z0NRcEsrYTAySnJETnZB?=
 =?utf-8?B?TGFTcWQvZXlDTWpJRWZZanZsTkwyRmVwa1QvL3A4UENmWTVUSjNWRG5BOTJG?=
 =?utf-8?B?NjdyNlBQREVORWtYZEFxNU9DWlBWb0tza0FYU1J4MTh2aTE2M2JnaWZRMGJT?=
 =?utf-8?B?ckVNSkhUOWg5MnRuV1pLaG5HbXhaL0EzdG5pVWFQZXhsUzQ3N3lNT3FORzkx?=
 =?utf-8?B?YnkyNUVJTE1mU3NUV1djMncyQjdVUU1DYUdZVCtlM0Z4dlFOUUNsYW1WelZD?=
 =?utf-8?B?M1REbDdhaDRmSWljeGpZVjErWmh6NTlJempnanBtd0M4Q2c4KzhYUHpjYUtW?=
 =?utf-8?B?REZXSUZrVHNiWVQ2YUVtbVVUODE2RXJCQXI4SWpHNXczbXhrdFk3eWRLOTlj?=
 =?utf-8?B?bUx5WVYwQ29pNm1udnVoVnllUWV2U1BMRHcvbkVnZUZzSWQxSk5BVHF5djZI?=
 =?utf-8?B?ZVlXMVAwWi9yK09MR3ZKUnMrN1kwazZuTVNHL2NzQzN1MlpOUmxlZjdTVisw?=
 =?utf-8?B?dkxUdzhCRFBONCtDQ0FFNEpCZmlDTnFjWTFNZnJRZlo3Q3ZQT1VxYjJzdzdX?=
 =?utf-8?B?REgyaEpvK1JYbDJDb0lhRTVFcDhGSnJSeU9qY1JjRWM1ellGQTRkZUR6UjY1?=
 =?utf-8?B?UWVLdFhZNnJHdmExZ2ZTcXFEMFk5cTNtRzU3RkZsRmc3VVhRM2ZGMGlEUTJw?=
 =?utf-8?B?WHlKcjlpa3RQeXlOM0p6OHlOaUQ1emZ1ZlZkZmZMb1FuRWhuejAvemlvS2tO?=
 =?utf-8?B?ZEhsY2RlQ0NPTVVGWm9ZV0V1TzBPQUdqbVY4ZmlnMHh6VGFmZysxT0VHWWFX?=
 =?utf-8?B?dFFyMkpESnRXSmQ3VysyOGFhd2tXYUY5MGQ3clljeFI4OHV2M3FuVjdCaUs1?=
 =?utf-8?B?cDlIWlNOM2pVcXArUDJjaTFaa2tMV0REd0tURUJMUEtxNjVJbTI1UUdOcjlx?=
 =?utf-8?B?V2N5NmV0NDNmVFgxVURqMytoZ05oM3pmSEpCZTZWbWI3VG1ZR04wWUNoRnp1?=
 =?utf-8?B?WGw0cWNtRytHNDMwdjBXcWdmNTVuQnM2V2dVODFxQWZpNHNVUmlDTHNOSTA0?=
 =?utf-8?B?M1VMYXFQLy9VRmxXa1F5YnhJTGdpVjV5OUdtQ0FVTVlvQUUrcE8yd0tZRnFt?=
 =?utf-8?B?Y2VDQmtWUXVyb3dNZGJGWlNhVVE5NjFLM09VcUNjS2hncnNoZHdjZURLaC9F?=
 =?utf-8?B?SjhRNnpkTWF4NXR5RnRkMzl5cDZnRlRzWis5NGVHa2xzMzhnWDBNZ2FwaHlz?=
 =?utf-8?B?MTdRZDkvRWRxSkRzMWZrVlp4SU5VYjMycDh3N2FKNXVCU1p2VGVNNkNtZFpT?=
 =?utf-8?B?ZzBWelVDSWU2blZDb29KYU9QZ2F5UUQvR21TSVVIZnZ5VldwR0RMbUNta3k3?=
 =?utf-8?B?eFBTeXRLTzVOMjBtSW5oT1ZrMDVRem1SNWlhL1lERW12dTNDbkF3QnRIanpU?=
 =?utf-8?B?a1E1TktzeEt3UVVZSE1LVENVQTNFdGtlb0F2R2EvSnhDT0xIbmZiMGNpWlVl?=
 =?utf-8?B?MWJzSnh2UllVdWIyY0gvVlZxTlB4RWtvdmdpRW44anZwS2xwQlVWbzl4eG1M?=
 =?utf-8?B?QlhETm5QQnJ1V3lkYTlRUzY1bmQwQlZMalgwZU92cGsrMVgvTzZzdlAwaDdQ?=
 =?utf-8?B?NXFkdkVsNWVYRVZLb0R1cjJDWXoxcDZ2a1NEQXVBWSt0RVg4TEFJaENUM2Nt?=
 =?utf-8?B?OGtxSWFUTkVMeHJwWC9XZVhkMmhXdDFzaXFiN2lURHJuQXZJcVp6eER2TkVq?=
 =?utf-8?Q?OSTGOEZYb6BPt4IJtjYjb1aiRd6t3cXBLBt1E?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d297fc7-331e-401e-5343-08da53a73e5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 16:58:19.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOr5Q6fUSvhei6jewRoCHkLTjJeub/49Xpx4sP6NCuQ+BQWf4pGLUF7dZSr0717Rg9/w5OKjOLtYyl3n5/orDIqALliuD7tbmPQFP1XD91zagVmzeDZ1vvXQhbjn91mw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/21/22 12:04 PM, Olga Kornievskaia wrote:
> Hi Dennis,
> 
> Can I ask some basic questions? Have you tried to get any kinds of
> profiling done to see where the client is spending time (using perf
> perhaps)?
> 
> real    4m11.835s
> user    0m0.001s
> sys     0m0.277s
> 
> sounds like 4ms are spent sleeping somewhere? Did it take 4mins to do
> a network transfer (if we had a network trace we could see how long
> network transfer were)? Do you have one (that goes along with
> something that can tell us approximately when the request began from
> the cp's perspective, like a date before hand)?
> 
> I see that there were no rdma changes that went into 5.18 kernel so
> whatever changed either a generic nfs behaviour or perhaps something
> in the rdma core code (is an mellonax card being used here?)
> 
> I wonder if the slowdown only happens on rdma or is it visible on the
> tcp mount as well, have you tried?
> 

Hi Olga,

I have opened a Kernel Bugzilla if you would rather log future responses there:
https://bugzilla.kernel.org/show_bug.cgi?id=216160

To answer your above questions: This is on Omni-Path hardware. I have not tried
the TCP mount, I can though. I don't have any network trace per-se or a profile.
We don't support like a TCP dump or anything like that. However I can tell you
there is nothing going over the network while it appears to be hung. I can
monitor the packet counters.

If you have some ideas where I could put some trace points that could tell us
something I can certainly add those.

-Denny

> 
> 
> On Mon, Jun 20, 2022 at 1:06 PM Dennis Dalessandro
> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>
>> On 6/20/22 10:40 AM, Chuck Lever III wrote:
>>> Hi Thorsten-
>>>
>>>> On Jun 20, 2022, at 10:29 AM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>>
>>>> On 20.06.22 16:11, Chuck Lever III wrote:
>>>>>
>>>>>
>>>>>> On Jun 20, 2022, at 3:46 AM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>>>>
>>>>>> Dennis, Chuck, I have below issue on the list of tracked regressions.
>>>>>> What's the status? Has any progress been made? Or is this not really a
>>>>>> regression and can be ignored?
>>>>>>
>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>
>>>>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>>>>>> reports and sometimes miss something important when writing mails like
>>>>>> this. If that's the case here, don't hesitate to tell me in a public
>>>>>> reply, it's in everyone's interest to set the public record straight.
>>>>>>
>>>>>> #regzbot poke
>>>>>> ##regzbot unlink: https://bugzilla.kernel.org/show_bug.cgi?id=215890
>>>>>
>>>>> The above link points to an Apple trackpad bug.
>>>>
>>>> Yeah, I know, sorry, should have mentioned: either I or my bot did
>>>> something stupid and associated that report with this regression, that's
>>>> why I deassociated it with the "unlink" command.
>>>
>>> Is there an open bugzilla for the original regression?
>>>
>>>
>>>>> The bug described all the way at the bottom was the origin problem
>>>>> report. I believe this is an NFS client issue. We are waiting for
>>>>> a response from the NFS client maintainers to help Dennis track
>>>>> this down.
>>>>
>>>> Many thx for the status update. Can anything be done to speed things up?
>>>> This is taken quite a long time already -- way longer that outlined in
>>>> "Prioritize work on fixing regressions" here:
>>>> https://docs.kernel.org/process/handling-regressions.html
>>>
>>> ENOTMYMONKEYS ;-)
>>>
>>> I was involved to help with the ^C issue that happened while
>>> Dennis was troubleshooting. It's not related to the original
>>> regression, which needs to be pursued by the NFS client
>>> maintainers.
>>>
>>> The correct people to poke are Trond, Olga (both cc'd) and
>>> Anna Schumaker.
>>
>> Perhaps I should open a bugzilla for the regression. The Ctrl+C issue was a
>> result of the test we were running taking too long. It times out after 10
>> minutes or so and kills the process. So a downstream effect of the regression.
>>
>> The test is still continuing to fail as of 5.19-rc2. I'll double check that it's
>> the same issue and open a bugzilla.
>>
>> Thanks for poking at this.
>>
>> -Denny
