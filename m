Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC55149FD
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiD2M6Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359578AbiD2M6P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 08:58:15 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2097.outbound.protection.outlook.com [40.107.95.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B18CAB95
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 05:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbZ98uEe/CEUnvXTo1+SUVNnbm+K1iNjuNwNUTtYq/gLHC7SD7O9DYLVyA2ZviQ8tA0b8ZSZhhRenrq06xzRB7YikY9zFhoALmx6P63R+WFvbcRijObxfHvYQAd71niYCc93wmjhFER79nfuAi9uAqYGsnAYPfz6BPojyhXL9kj169rMBnEnU0uf1leaPp73byT+bBgvF4QZf1FWgtVq9m7IrEJkmWdtsIDDeHeqjbd8+GTT7IYxJ6Dr29uEglSgxXfoqaHWAKwE3xMHTvqYvaGKvbT0TEeP5vXJ1u3CSukXgXigXo8cyzMhvkt97qr1P1DISGVAdJDbuMA5tm6ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ7X2kPzc88iurT42dI6pHCMPp+SxnMaX4N22+uogqk=;
 b=i5hoZnw+NDhQdQHDNmP9gaygS1PKQmryP4xtastWEsJ3GpHmzEVfCyue5BqDdxvHaie3qV7cd7mGSYquqZN8muv7w81pK7t8P8zpNgF2mGHLaqpc8KX6flylBTQWhpV0lQ35OmmlaeOV3KuFC+/ZutFWOXSu+qFed2SLbCRERANQjzgjUhEL6xaQHkyTs92EXI5A4UKi6cxF4ynppWWTGP+noVheY9QUsyLvD/62BfKTKzK08yDak0svSnLMOBD+uGPQ6vNcWxpVb+hXVe1Xgd+hMo9z+jS9Y/Sz5F1hHqY70vNuRJUqYJ9r+tXfCaZ0CxP/ocdGedMmxRxScOCHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ7X2kPzc88iurT42dI6pHCMPp+SxnMaX4N22+uogqk=;
 b=ajxqodw90GckKBjJ1TDPzJAPy/LiA7XHaJh8ihAXJwHjrDvGe5Dd/sgqJ/Nftm+undBGr4G4zeeF1EdbWZpT3uu/J65g1o7rLYEg0SSwlFHOtlk+JdASXHr6s+2FRcEVaXQEXBIa3i8Ml3RQ6xn4C5AJGolGdMnrL+XLNomgZkaOHiDlgNV3oDPjQe2EMYnk9T86PlRcvDhC4XubFiGX7bSy157uQwCAVOgnhdlCrlQEjIXdCRm5JwBq3Lmjl/DmTk7/TG9862Md/5n8WljgxHReS6YK7b/eWkZgmY7juuA2c0C/YzBeIt85v4A3vDJMbSxHSBFz3p7gikPRwM0xow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BL0PR01MB4068.prod.exchangelabs.com (2603:10b6:208:4a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 12:54:54 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379%5]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 12:54:54 +0000
Message-ID: <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
Date:   Fri, 29 Apr 2022 08:54:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:208:15e::37) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c8461a-0a97-4862-bdeb-08da29df749c
X-MS-TrafficTypeDiagnostic: BL0PR01MB4068:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB4068AB358A3D46C56C1AAAAFF4FC9@BL0PR01MB4068.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSYMQjWChdkFkpz8PChMYBnY3Ig1WDdnP5nhUVGoIyceJB0YD6qHgtK49K6IZumvBlakp61Y11XO/uVQPB6PMGTo+utx/RCrnaqJRRUWaS/fJwNGOhW8nrWwqoSmynW+bbAZV9RV2b5VcBAg3VAbEvy6MbT1r3TZRsVePK2RH3SRHRsNna59BR04WIrPMIcYQmBIUyOZrndXTqNvUJCtDV30T6MzlLsfkss5QlNc01I9fjZ8YLbrYkiR4wrFJyUU1DNVlFrhYhld7rj1yu3/h3kKr5zPilQ8SO61gABcZDyOIMJJ1G2F1zBcVtIY9M3jFD6HPW5rZrv5XU8Jr04YW5lai5EY4AEGpy9FMyOFj7k5+4DCn96sSuc3yuwlEgcmeq9TZ9Hno8DxizhbcwhrgoE5nSB4RekH7JlkNsgxdJNwuR8SqVWnCCQf764olpL83m/mRnDIdbuwzf+/JTmUVuNsjtlHsy1E0BiEfNdRXaNGCdA0U6M4Pw4w5KQDdw8ZDL0arf/JU7uhfBWgCdgr4d2cth3tqaEWY94yx+uGl2pEp+A+oYaU5eh8tDa7k7c0WPt1b4b31eSgYnCjNN1Q2oy+sdQSfycuTdYMZGpSlbaT0RDSPoyoWlkWea9UD+j7+H6mU2Qu+UH4lefzYfBbmiRHnvht2x7YKVn3S/CHPCJuqc+5rDUvjbnB854ZqR5n0ibQSuPmC5Gg5lTe0k8pDBb6NLrO2c82/tSYY+i3rbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(136003)(376002)(39830400003)(366004)(396003)(4326008)(44832011)(36756003)(31686004)(110136005)(508600001)(316002)(8936002)(6486002)(66556008)(86362001)(186003)(5660300002)(83380400001)(66476007)(2616005)(66946007)(6666004)(31696002)(8676002)(6512007)(2906002)(52116002)(38350700002)(6506007)(26005)(53546011)(38100700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdWUDJIdnUrblNGNzMxeU9jZ3d4Skx0dFZvMzllb09xclgvYjNVbVVxSEI1?=
 =?utf-8?B?K1ZRblB0ekRqQ2Z1RThoeFhIV24rakZyY3U1dVhhVHBhaVoyakdyOThSREMy?=
 =?utf-8?B?ZjBkQVBLSVpNd1dJT1N0THdieGZxMVBIZFdKeFlCT2lPRHlnSXdJT05UbEc2?=
 =?utf-8?B?SmxRRWpBQ1FuZlljd3hra3dlUktDcGFlT3VoMlh1d1BWaXlhbmw1ZTZ2cEtn?=
 =?utf-8?B?Q1lXR01LNHpoMUsxeTdsZ1d2T2Z2elRqdTNpS0U1a21kdlBMNU0rU2hVa1hF?=
 =?utf-8?B?dVhtVVYzVmZxVlpIejFqL1NtdGJWZGkwV3I5UFJEVDVqaUxBeEdkWE44M1hU?=
 =?utf-8?B?TXZ2SHZZNFZRTk5Wd2pYSXZycEg5d3NZWWpKSitPREw4ZHRZNEoxSWVnRFcr?=
 =?utf-8?B?TDJhLzV3d2N5WWMwaFlzQzRiQldMNnQrdEpCSGo4SkRRTzFRV0MxY2p3NFFj?=
 =?utf-8?B?amVaMmNBR3N2ckhPYWdqSGY5bk5jZXFoUVI4VDF6R3BWQ0g0WEVSWEZzbVZt?=
 =?utf-8?B?NnkyWTJYbE1pRmhrNGMyY3ZTKzJQbkdqRkNZaXcxcFUyTHlaVGxuY1RwRmo0?=
 =?utf-8?B?Nm1zZ3IvMUNKcU9oT1pDa0tBTk85Tnd4K0ZlWjNqaVRjTmxZWWNyNVZkZ2hu?=
 =?utf-8?B?eVNsZXNBVHJNTFB3Um5kZDBhdlQvUFFIZTdpTkc3UXhMNmczMnB0SjJQam5M?=
 =?utf-8?B?aXVuZGVRdjRsQmJ1Y3NRMndEbk0zcmJVSjFhQ2RtNDg1MFhJSitQUWs4bllW?=
 =?utf-8?B?ekxSVnhjV3pDamJ1T2xQK2hRaTdqL1F3bE4zRUdLdWNmNnJSTk9IRDU4ZmNx?=
 =?utf-8?B?MHZqbnRPRnJQMXhvYUwxVWU4NTRvcDd1MTJTMC9qcGEzY0tRVFFNd0FHYWo1?=
 =?utf-8?B?c0lJV1pXc04zb2VTMVMvdWVyaDBPN29Ya2l6ck5ZV0VGQ1QwWkVtYTVwakQv?=
 =?utf-8?B?REptV25ObHczT1NwaFg3UXVabFNzemVTMjBuRi84UzJlcklJcUlsMGNjZlJY?=
 =?utf-8?B?YkVLZDJjT0M3U0VYWlpKL3IyaHlVMzNnengvNjVhYmpOVnE4d01jMUFQenpX?=
 =?utf-8?B?ZU01eldmT0dYNGEzYUdDamtEQjZHNjNRb3pLakw1bU5OWGg1UmwzaGlHT0RE?=
 =?utf-8?B?S1VuUzNMcnVxbGJFTXY5VU9IaVdUUk93UTRjNXFwU3laY2kzOTZ6U3lFcnp0?=
 =?utf-8?B?V21ZMjNLNjZ5eFhhcGNLSGMzOElYRWFLbFE3NG5adkV6ODdvdHY5MnhOK3VV?=
 =?utf-8?B?bGQ2THFxUVpscTBmN0RTbXNLc3BlTWVGSUJoVC9WNmpNV2QxcjUyQ2hLMTZE?=
 =?utf-8?B?MVdGMVB2am81VmU5K3hxSzNWR2lncTZkQmNzT01aeUk0NkYwZXJYYmJRdmhL?=
 =?utf-8?B?L3Bvb2pYMXlXdWVhbHdRWURwQUJlUUpqdUVWaDhJQ1BQcHBHcUxMYmh1N0l1?=
 =?utf-8?B?ZnZRQ01uTzl2Y3BoUFp2blZweVd6K2x4WHdkV3dSUjdEMlQ2TG5zOSs1QVI1?=
 =?utf-8?B?RWpwY3JQdloyTlRYWU4rTUdtVVoxV2l6ZUw0aFBMTTZoUFZTTjBJTWZRZS9D?=
 =?utf-8?B?YkFYWlV1YkNLU0J4ZC9kMi85Rk0yQUhBM1F1K1RjU09Jb010a3EvR2ZxeDZE?=
 =?utf-8?B?OFZUU0MreW9VMXFwbkNONWJNUENzbFZGUEVqdjAzMVNXSDZlN2hYTEdsZ2Z0?=
 =?utf-8?B?eUxPdS9aOWdnSXZLUThianpkT255UlozSFZFbWFmSm5hL2hLWGE5QnlPSUtx?=
 =?utf-8?B?VVJnWXh2b3RLZ1VjTFBrSGZsZ3YyOFJZWUlWRnE1Yk9VTC9JOXpUVVBLVFlW?=
 =?utf-8?B?dzk0SzRFNXNqVGFLWnNlWURnNEZSQmxiL0hnNC85QkhQNi9mdzVnQ1p0WGlM?=
 =?utf-8?B?dWJWMGkwRGFSZ0YvekYwN2VuQ25XeU1IYVMwVGl2ZzBYdy9EVVVDZWdLUkY2?=
 =?utf-8?B?R2NEZWFVVlpyQ3BOUjc4RUJlZWRlK3BRVk8rVkc3S1RiekpxTGRZYUsvRUdo?=
 =?utf-8?B?NjNwcFRwc2NQVWl0bXZDMW5HcU1kUWpITG42Y3A4a3FWNHNRRUlkanhPM3BE?=
 =?utf-8?B?RVVvTGhZUGZFcWVRVGNJa3BrQnRkZ2NlWmNUUDJmTkZRdEl3MWt3SlBOR1JP?=
 =?utf-8?B?aGxkd0dBK2xiaXVZWW5uVVptQUluZWVOYm90KzFlTGxkd01NOUtXbnk4YmFP?=
 =?utf-8?B?SHpRZHhEa3U4TFNsaFVGN0R1NUVGaE00OFN5S01ZMysvUFIvSlJjVS8rNzl6?=
 =?utf-8?B?Q3g4WVZHQlFpQ005OGk3SVJWMDU5ZnNHeVdZQjRYSFdMYzVPeTZGb2kzMS9F?=
 =?utf-8?B?TmcyK1Rkcyt6cy9kYzZhcGZXSW92eXRDNXhxbHZiRXJoa05FU2pJYTJCV3Jk?=
 =?utf-8?Q?jmNuISET2TQLxzg6xSi6nUok59mjKnYcUBJnG?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c8461a-0a97-4862-bdeb-08da29df749c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 12:54:54.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1xnrb8hGfUJBy+yWcbWWQTIZFsZVtpLe+MpcspIjs//SzIjeWL2R8nCId/e8g9ZZzHxqn77N+T/xp1ME0A/XxVMUmBt08j8jGkY1GziD2/bN7Byij5StedSyNWSZ5GY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4068
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4/28/22 3:56 PM, Trond Myklebust wrote:
> On Thu, 2022-04-28 at 15:47 -0400, Dennis Dalessandro wrote:
>> On 4/28/22 11:42 AM, Dennis Dalessandro wrote:
>>> On 4/28/22 10:57 AM, Chuck Lever III wrote:
>>>>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro
>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>
>>>>> Hi NFS folks,
>>>>>
>>>>> I've noticed a pretty nasty regression in our NFS capability
>>>>> between 5.17 and
>>>>> 5.18-rc1. I've tried to bisect but not having any luck. The
>>>>> problem I'm seeing
>>>>> is it takes 3 minutes to copy a file from NFS to the local
>>>>> disk. When it should
>>>>> take less than half a second, which it did up through 5.17.
>>>>>
>>>>> It doesn't seem to be network related, but can't rule that out
>>>>> completely.
>>>>>
>>>>> I tried to bisect but the problem can be intermittent. Some
>>>>> runs I'll see a
>>>>> problem in 3 out of 100 cycles, sometimes 0 out of 100.
>>>>> Sometimes I'll see it
>>>>> 100 out of 100.
>>>>
>>>> It's not clear from your problem report whether the problem
>>>> appears
>>>> when it's the server running v5.18-rc or the client.
>>>
>>> That's because I don't know which it is. I'll do a quick test and
>>> find out. I
>>> was testing the same kernel across both nodes.
>>
>> Looks like it is the client.
>>
>> server  client  result
>> ------  ------  ------
>> 5.17    5.17    Pass
>> 5.17    5.18    Fail
>> 5.18    5.18    Fail
>> 5.18    5.17    Pass
>>
>> Is there a patch for the client issue you mentioned that I could try?
>>
>> -Denny
> 
> Try this one

Thanks for the patch. Unfortunately it doesn't seem to solve the issue, still
see intermittent hangs. I applied it on top of -rc4:

copy /mnt/nfs_test/run_nfs_test.junk to /dev/shm/run_nfs_test.tmp...

real    2m6.072s
user    0m0.002s
sys     0m0.263s
Done

While it was hung I checked the mem usage on the machine:

# free -h
              total        used        free      shared  buff/cache   available
Mem:           62Gi       871Mi        61Gi       342Mi       889Mi        61Gi
Swap:         4.0Gi          0B       4.0Gi

Doesn't appear to be under memory pressure.

-Denny
