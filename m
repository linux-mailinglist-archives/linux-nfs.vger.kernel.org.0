Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10E051D8F9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392441AbiEFN1x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbiEFN1v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 09:27:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2123.outbound.protection.outlook.com [40.107.220.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB0694AF
        for <linux-nfs@vger.kernel.org>; Fri,  6 May 2022 06:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9T8eemFyXuQQOLsIQavgu6nNS5a5XF3aYcmWWuaOvUIE53gofd2lGwbe1IYx8k5T1KQjhlNw8WwaH6AGB3AU6dsbe9FsQvDveAt0w9k4wttdh54fYQY0UwBB71tnRIu0dF+lGXH5KiV7+aY8LkXvN7fNFsfSqg5z7RsNdXTBmEyw6YakLi8zYPwGB9f2CYME9V3oWyMRyDx22ndXcF0XEle2xNVIYOveDZk5wEa8o74hYhCm1+pB2YTwcNHWfVnJwX8rak6bKTCnVEBGwl742GqHwt2tfplagywbIJQDhjkc/LSAwhxDeDtzPmnaAQYkVVJrMpuZePJZXZVsFoN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRFdz9qykWFktoHadw89iQ2AQ/GXxt1h9syux5t5fkA=;
 b=IesAhBywCd7Dl9lTyFNszKb15k9nWFJuoyjqUvQ7kWy/8geyKvAnd+ZfHjuKg51LOGDqO8MU/JVFftsB5Sjl9e5ZNa3A7INHBiaYDechCi8O+Litz6jcw2f2YdmHhGYrdUDdaz9Ej7Oaz0kykGfbOPHUh/RG/QnMnJuC3JE6oxAY69x83ot1HkKikgB6q/cfWc6VcqZuUmtysYna5rt4aI62G7bFkHTmFM4mHcfsqB7aJEfx2y765qC32nUFbZuPNksSOYhy4sTIdWBypBrCdtIPNMZoJALpD7/fYOud4Ah+bRLu8p8QuEJgKyxwixEMF46nOylG2kAFwT8nGV9/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRFdz9qykWFktoHadw89iQ2AQ/GXxt1h9syux5t5fkA=;
 b=l211rOpcWofoNNejOy0Q1yP72nTac0GJ5KU7HXI0ly1qOYSDdUubwWBAx29CKyegf2p3OQEcwkd6XSjRN83C80wA4SaGDZo11YPOpTLZggSql/jZtieovNSFA6vrpJtbriYDkxMiWzdcgUONoEgSNaFLMygcZ1trHN1vsPAgJPv8bSrm66+2c8CSwDZO8X5/nuDnarRFtYEd8TR040vkkgwiSZGtIrHhBroZrQqjaCcQt7X7/PDKYykkVEi/7O7eLsEJcxU64tdrES5iY8MdayfSt0FRvWw1W+/FE6ijGAmi3p0VOWR/4Iex0vidfbAgaB/D12czo+K6SyAd8QV+DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BL3PR01MB7209.prod.exchangelabs.com (2603:10b6:208:344::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Fri, 6 May 2022 13:24:06 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379%5]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 13:24:06 +0000
Message-ID: <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
Date:   Fri, 6 May 2022 09:24:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
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
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:208:236::19) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06681976-6c1f-46f0-ef82-08da2f63b1d9
X-MS-TrafficTypeDiagnostic: BL3PR01MB7209:EE_
X-Microsoft-Antispam-PRVS: <BL3PR01MB72098B5A82EEF6DDFA1AEAECF4C59@BL3PR01MB7209.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bMPi5xteuRGMsYU97JwEw8ZWvB9NUpwt/t4diNfxIP6I+1FgKv5VnDFic/RF1/oqZU/9P1LrmHA2jbY6XO6+VMG6Dbrdrvx0MdGjlLT9Hf4rxRqMFlt35a/FQWd4BWVCkKoomOs7SxAWfxztrNPqHLRHc3OXtVOkuRvfpL31AuD7zCq7IC/zC2l/Onw5PHuhhzSF4OmamubiQdM/oO18aM3ejGDlaW1ifUH1jRUEnOWEOMFS6hvDqe4DVacAoa10zFa22vUY6ahRZpummcLQeq8ttcoUG+BZJ1p2XUT2GCvdcCZ8SlXx3bRXPYX8+F5OpZw0cXtmt9ixw1mI8R9QIaveweA67gfXbcHQ2NBve/OOM90RN8GC4uIR9A0AaIar6od05OFv4kAFc8IIrDeFT/0sf0Qo3zl3uBzqcu0+hGAlNS33FuDWvDJct4Epp05GyWhwWJ45ZQi6j4hLysA+miSpefdhonbNThK4mAlxEcCRCWYJ2bJ5npmGh9Mz72LrSrDFVQhZrdhl9+u4Ki9iR/U4m18UcMNN20rcaXGDv87P3NiFlOfe0LCL6adAqOM0VEIlXwzeOJEAp/zz7NfegdV59dF2STM3+btEtITgORacmx2PN3FbiX1DiFkvHN0DpqUIwAmCKjmQmStdhoaYwaT6+a/lJ8AK+sOQfbTiGnCP8CWBFlh/DQl94OZqDwUHIBHjmDciZ54bhRfweL18ZrLkw6f+RB3NmbuSiAzkB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(376002)(39830400003)(346002)(366004)(136003)(66556008)(66946007)(31686004)(83380400001)(66476007)(4326008)(8676002)(6916009)(2616005)(54906003)(186003)(316002)(26005)(2906002)(31696002)(6512007)(86362001)(53546011)(6506007)(6666004)(36756003)(5660300002)(52116002)(44832011)(6486002)(508600001)(38100700002)(8936002)(38350700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXM5aXBxQVVJTk1XNUxXd1FoS0NzaDFXUzJpVjZ4VHhjK0llM05yY0VNZFVF?=
 =?utf-8?B?UktVZTBnL1RVV0l1Q0hGcGdzRWQ2a3JzSW5rN0dnaWpCOUh2VmtXcE5rYTM5?=
 =?utf-8?B?WmJRVEdodGY4ZmZjM2dqZnN3alJZaVlsRDNteHdMdUpJVlFhalgvRWp6WHAy?=
 =?utf-8?B?Z2ZMOStNUzM2N0s5M3RhWFE3bUlxckUvdWFsVkphSWZJcmhLS212NnBjQ0xU?=
 =?utf-8?B?cVJwTU9Kb0xHY2JETHR3NXZtRU5DM0ZOeW0wZ016c0xLRWtpeWVuNzM5OXZT?=
 =?utf-8?B?V040M3dVVWV4SlZJKythMVVkK2lyZmNKYmQzcnlkcjF1Ykx6enhCeVF5Qm5I?=
 =?utf-8?B?ekVVMGI2Y01ZZm55Z2pYMTZHTTJEZnlod1d4c25JSkFvQWdOaFI1aWRCak5D?=
 =?utf-8?B?bjRodHBMT0hWa3h0dHQwMVBjejU0RXdKSkM1cldsdGlYNTc4V3JablZnOXZ5?=
 =?utf-8?B?QWxaaU9mcHBrek5PTkl5cWFhMURWS3dlQk4zOGd0bzhFdG1nWW5HeTNFUktF?=
 =?utf-8?B?ekdYVy9tL3RhTUVsNVRLb0NRaWhtdk9JcGxVaHZDVTBwWkJsZlRPOTlkaExV?=
 =?utf-8?B?cHFKZU1wZlFuV3VCZU1tQjQ4VTZvQXVCeDd3K3FuS3AzbFo5ZUhPUDJBSkli?=
 =?utf-8?B?S1l0ZUdOc3d5aEhieFl3TmlSaGs0ektNUEU0Q1VZMFFPcEIxN3p6N1Z5RWoz?=
 =?utf-8?B?d1AwdFJ2cjFFK05memJ5b2sxTUpTQUFLczhrVUtjakNyVXJZc0JjN1FjS2VF?=
 =?utf-8?B?bkJ5TkJBYnV1QTBldmV2cXkzdWdYS3oyRkxnMSsxbUY1TGxVeW92L0s3Y1Z4?=
 =?utf-8?B?dkpyY21kb2VKYitYNzNBSFhpcFlJV2ZtV2I5TEVkOTFlcWxpcVhmeGw2cjFO?=
 =?utf-8?B?eGVuMVIxSHpmZkxEVHBkVWRJK1c5TmcxUy94RlNiem0raW9WNXozY2tiRGJr?=
 =?utf-8?B?S3hHckMrY1hvVHYrMUlaSGN2VjByMTlJbHBxbnYrZVBLcVdTcEt1ZGxLSWxv?=
 =?utf-8?B?R2hOaHhuanlkQzFFTU9yQ2lIazhmYXBCTytvTXlHTHlWekdVZUU2ZWRMRlBu?=
 =?utf-8?B?aHRRZGYzZ0tlTGgwYm1Vc253dnJvSjhFMlh4bTlwc3B1SHdyWVJsMjhBeUx0?=
 =?utf-8?B?eUFpMkFwSmJFU2tkbW02OW9GekFDUStVbmVxUVZoc3YxNDRTYndESUkwcDM1?=
 =?utf-8?B?NnRMZ3BHM0lzYVFrdnVGZVgrNnJKVVZNbTZJQjNoVFhJWnZweHBFT0h3cnh1?=
 =?utf-8?B?ZW5uS3hDbWRwUVgwRGdBWXVUZ3R0UGNLT3ZuMG56RFp6aS85YUZLQnQyM28v?=
 =?utf-8?B?SHhKL21aK3BaNVlDOEFLUWs4TWwrd2NLc0lSejJuTER4LzlsblA2REV3RFRH?=
 =?utf-8?B?LytBWE9tOWxpblNYaGlZWHVabGFZOTlGazM3THU5ZWhQQWZCVlhwN2lmUm1V?=
 =?utf-8?B?YVJUd0JvUDlJcjVSK2EvbUFtZ1ZTN2FxcElwTWN6Zjk5MFgrWUlMeWl2ZUgz?=
 =?utf-8?B?YzZCb0c0S3hmT0JyTFJOQmdGL1BhYVRHWU4zMGFxa29vQ2ZSTEJsMmRoblpa?=
 =?utf-8?B?L2w4a2pYbmRqbEs1ZTA4L0hOK2xNUlU2Sjc2OVRJVktYK1JnTEpBdmJHcTJr?=
 =?utf-8?B?UGRoYUwrWkVvaHVpcXY2STgxbEc2WmlYZ1N2Z3I4bVY3dFZkM1J4ZTRjaGxE?=
 =?utf-8?B?UVc4djlrUFMwd2NVekVsWTd0K0ZqQ2hJcGU5VlBrbUR0K2RMaDdQU1IrNEho?=
 =?utf-8?B?MXlkMi92aDVia2VMZXdiOHV5NG5kem5HcEZLNm02NTk4SU56U0FWemNxTUE1?=
 =?utf-8?B?bHRWTVdHeWlWNWREVHJEQkRiaGJVTnZLRkV1RS91cUFkK3pvWHNGZ0JzbjJt?=
 =?utf-8?B?ak9vNGFIMzZPd3pnTFlCNnRZNlFEZzYxZ09TL1Z5b0E5RTNHeTJlTmtjb3R4?=
 =?utf-8?B?N05NZGcwKzluOXd6THh4dzd2SHZUamFidlV4SkU3VzBEQ2twa1ZSMHNNUmZC?=
 =?utf-8?B?NUZ3VWFsU0d5ZWN6ZVVBaUVjaHZvc1NQcldoMEVld1RtR2ttWmNhV1phdFFR?=
 =?utf-8?B?d05xZktlNTF0QzBCQUttVkp5a09iU0luZ2RnYjFnSXN5akpTajJ1RGIxZ2xh?=
 =?utf-8?B?SGRFeS9iMUVOeUxFMDFrelJnY1cvSW5oR29ycWhFVS8wSlpWY3A4TVc3M095?=
 =?utf-8?B?V1NSQnJDTUxQYjJJUmdGMCtzMXREd1orL1phMmJySDltdWc0Q3BOVVlXR1lk?=
 =?utf-8?B?Qm1TUGg1K2lNQWFQWW8vZVVMdmNsaVNsdVk1ZUgvUFJVYTFjaFJVMVFQVWFy?=
 =?utf-8?B?dUxDWXNhQ1dkYmRCaWtXRnNKZFBoMHlucjlNa214Sm13U2diOXgxNHF5bVVi?=
 =?utf-8?Q?tV9fVrHMEfqkntRmet6s37zDngjeeDQ+DTALC?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06681976-6c1f-46f0-ef82-08da2f63b1d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 13:24:06.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIbZSjdNzZU4maqBH/TZKb7W82xNuGcQq3MeLuZwBIXeBe7/DgU7xJ5v75c5n/huUzxIe8a9LMxcsjuUm6eeZzhKlP2GDDFZgsz38JjSfYE8R4nYl6vastFTJPBpr3Jw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7209
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4/29/22 9:37 AM, Chuck Lever III wrote:
> 
> 
>> On Apr 29, 2022, at 8:54 AM, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com> wrote:
>>
>> On 4/28/22 3:56 PM, Trond Myklebust wrote:
>>> On Thu, 2022-04-28 at 15:47 -0400, Dennis Dalessandro wrote:
>>>> On 4/28/22 11:42 AM, Dennis Dalessandro wrote:
>>>>> On 4/28/22 10:57 AM, Chuck Lever III wrote:
>>>>>>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro
>>>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>>>
>>>>>>> Hi NFS folks,
>>>>>>>
>>>>>>> I've noticed a pretty nasty regression in our NFS capability
>>>>>>> between 5.17 and
>>>>>>> 5.18-rc1. I've tried to bisect but not having any luck. The
>>>>>>> problem I'm seeing
>>>>>>> is it takes 3 minutes to copy a file from NFS to the local
>>>>>>> disk. When it should
>>>>>>> take less than half a second, which it did up through 5.17.
>>>>>>>
>>>>>>> It doesn't seem to be network related, but can't rule that out
>>>>>>> completely.
>>>>>>>
>>>>>>> I tried to bisect but the problem can be intermittent. Some
>>>>>>> runs I'll see a
>>>>>>> problem in 3 out of 100 cycles, sometimes 0 out of 100.
>>>>>>> Sometimes I'll see it
>>>>>>> 100 out of 100.
>>>>>>
>>>>>> It's not clear from your problem report whether the problem
>>>>>> appears
>>>>>> when it's the server running v5.18-rc or the client.
>>>>>
>>>>> That's because I don't know which it is. I'll do a quick test and
>>>>> find out. I
>>>>> was testing the same kernel across both nodes.
>>>>
>>>> Looks like it is the client.
>>>>
>>>> server  client  result
>>>> ------  ------  ------
>>>> 5.17    5.17    Pass
>>>> 5.17    5.18    Fail
>>>> 5.18    5.18    Fail
>>>> 5.18    5.17    Pass
>>>>
>>>> Is there a patch for the client issue you mentioned that I could try?
>>>>
>>>> -Denny
>>>
>>> Try this one
>>
>> Thanks for the patch. Unfortunately it doesn't seem to solve the issue, still
>> see intermittent hangs. I applied it on top of -rc4:
>>
>> copy /mnt/nfs_test/run_nfs_test.junk to /dev/shm/run_nfs_test.tmp...
>>
>> real    2m6.072s
>> user    0m0.002s
>> sys     0m0.263s
>> Done
>>
>> While it was hung I checked the mem usage on the machine:
>>
>> # free -h
>>              total        used        free      shared  buff/cache   available
>> Mem:           62Gi       871Mi        61Gi       342Mi       889Mi        61Gi
>> Swap:         4.0Gi          0B       4.0Gi
>>
>> Doesn't appear to be under memory pressure.
> 
> Hi, since you know now that it is the client, perhaps a bisect
> would be more successful?

I've been testing all week. I pulled the nfs-rdma tree that was sent to Linus
for 5.18 and tested. I see the problem on pretty much all the patches. However
it's the frequency that it hits which changes.

I'll see 1-5 cycles out of 2500 where the copy takes minutes up to:
"NFS: Convert readdir page cache to use a cookie based index"

After this I start seeing it around 10 times in 500 and by the last patch 10
times in less than 100.

Is there any kind of tracing/debugging I could turn on to get more insight on
what is taking so long when it does go bad?

-Denny




