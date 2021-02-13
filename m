Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB58031AD6B
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBMRqp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 12:46:45 -0500
Received: from mail-eopbgr670109.outbound.protection.outlook.com ([40.107.67.109]:56959
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhBMRqn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 13 Feb 2021 12:46:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SarIaO0ugQtsYmjqyEUu1JbUGCAL44ZSshLlDYRz560fnLb+oauJSQSUelQ+0m5CCeIRHrlRV6d89eun98BPojc+hVg4OLiGjq68JF9ruscS8sDmioiEuKIwTfGBv3gAcX3f3bkZEiUjtpqWK16M4+w/6/HpQqLJN9iep6ywodoVpfOWljPm6lojlulP8UebpbtTkecrxLTinCJsKG7tJgTvyYeEz73ALsv9oXwBg42ndQ5VzwnCnWpOU8uECVu3LJnmUwYOjXltQbzrzsfsW4+9E623iSR4VFqwmtxSJUukcwLdqMnOtPoxkrnUug3M55C8EYOcLLZR2cmOTFkzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhvnEQHq1hmk2rW+z56WGr9VJT3/mGzxvpg3HEa0Dg8=;
 b=myWuUtTtP931DdkPioH/kylowLywAlekU5Lj7hA74710tNL0nuG3ykKhBgswmRIbrw2Vkhuv9CzC1d6Fv/5aoHOWXrdlxxTklmPj/sRlj8tE/ypztgl4rTgaIuTTKyACrzI9Yr2zvXR/82E+j/zXdCGj1HO5NkHtOytgYXFQ6Dyczd/BheHTBHCkgQB7l2JqTYxTgWvXOFE36DbcamHbmefYqEtJmDN6AiwKjnEtkvp4vZbjT2EuTG4mlLBIKPgFVPSMVoMnSuhz7Bhywe2xPk606J43Ig4xyq33rAfb0KHpT5Q0Syac83eticqQ7kA1ZQb5oKPoG71QVfCacDfNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yorku.ca; dmarc=pass action=none header.from=yorku.ca;
 dkim=pass header.d=yorku.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yuoffice.onmicrosoft.com; s=selector2-yuoffice-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhvnEQHq1hmk2rW+z56WGr9VJT3/mGzxvpg3HEa0Dg8=;
 b=Wgi6+hSdTED8QwkHxbyI2BWYSAZ8EG0058EhAaWJA73LJ12VNqfgD7RCDjFE++sF9DSqDX8C5w7XUJe5RbZdY15d4G5hgVpxRsgmD0hhZAZQ/QsBHZKdrIZ3SC33Nt9TiOF1p4A1stNy7tM/zuXtT44RiIKOD/28UgW9YO82D+w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=yorku.ca;
Received: from QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:33::24)
 by YQBPR0101MB4257.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36; Sat, 13 Feb
 2021 17:45:58 +0000
Received: from QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f402:54b6:2a5f:afd0]) by QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f402:54b6:2a5f:afd0%4]) with mapi id 15.20.3825.039; Sat, 13 Feb 2021
 17:45:58 +0000
Subject: Re: NFS server issue after new AD group added to AD user
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ad4ee9a5-9285-b29e-8876-f3c7bb1bdbae@yorku.ca>
 <3795c23197b4f171b143821c033fa1687d3163e7.camel@hammerspace.com>
 <3b87a2d0-697c-c750-48c1-79c016a41052@yorku.ca>
 <ae8a2304d15e518a86b919e9fef2eb2e3c2e02df.camel@hammerspace.com>
 <56d6f05065ade70c8eadc23faf0c46fdc3de1eb5.camel@hammerspace.com>
From:   Jason Keltz <jas@yorku.ca>
Message-ID: <528cb523-1e1f-384c-8235-c401e5f1d985@yorku.ca>
Date:   Sat, 13 Feb 2021 12:45:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <56d6f05065ade70c8eadc23faf0c46fdc3de1eb5.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [170.133.224.154]
X-ClientProxiedBy: YQBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::38)
 To QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:33::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.136] (170.133.224.154) by YQBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend Transport; Sat, 13 Feb 2021 17:45:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e583551-cfd5-456b-7527-08d8d04738b6
X-MS-TrafficTypeDiagnostic: YQBPR0101MB4257:
X-Microsoft-Antispam-PRVS: <YQBPR0101MB4257FB16421CD0C4E0F4BAA4D48A9@YQBPR0101MB4257.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eer1thO4jHKj+NVKhzv8dzFEGBZjqk70QDVDbrHzH8VGmLVDTwVnJLLORQ0Wm9wrdDXkiv04AJVkWWP6lo6duUzOzC/jFVjLc1YrJEVOHsrrieYyJn8ZiRofor8DfWYDUDQDOllQfSEkbIEutoFc6QHX2T1mNeCM3CxjoU8tiE4urfvaD57bvKv4yJ9ys2cmxMTV7VNfKHTDajyDk6HeN4mQVyAQaSN3u2y9s9NOGbT8fPakqGHtSEf1Ml48CVRm0Lmo9jwYui/l5l60P6fLGfQK3hwzZc9MDuYorG5z+G2No1BRAJUyciceIYj62c/PbcY4yBYSvmJ7TTR6jIsYFmYQ3e28IN/J+ksUcpp1K27zrYPytg5z8S0yzpOAwGDhOZtXcdHaM8mbJsRsCw91WUoRJ5WpY5IX1hjkN8Px+Rkq3SWBJP9zEwO6ppLptuKmdayGS9VATPLNwvxwuk4ERk4ix31F+Lrjpaf0ZaCicfGhDHfXyy0uDePQqTqwB9lVWPpXYUyHYR5GMARVyMRiSGrbEvwIZROM4miuhuGVC9HSg1VhnJYISrI7PEwJ7sne7jg+kTF3nD+Z6nEZji8bWsNB77TnQgfgtjzbyjllyR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(8676002)(52116002)(8936002)(86362001)(110136005)(31686004)(6486002)(36756003)(30864003)(5660300002)(316002)(16576012)(786003)(66556008)(66946007)(66476007)(83380400001)(53546011)(26005)(2906002)(31696002)(16526019)(186003)(478600001)(956004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UU9HSFBKaGNSemZpMHM4dVpoNnN5bEphdGVhMnlpV045TU4xbUZqdkZoS3dG?=
 =?utf-8?B?NVdNaTRtWlVUTThXZlByUGc1Y3RwUlF4cmhFNTFDRjRHNjM0RGlFdDBURzJB?=
 =?utf-8?B?WXdoejdKN05reHk5b3YvTU9hcTVoN3Z6OE1ITDRQRWx2N2I5eXJHanJscTg1?=
 =?utf-8?B?QnpYZ09zNkNTbUhjckhOVm16SlNQMXY2bTdpeWk0K1BaZk5mWlpwb2F5aER4?=
 =?utf-8?B?UElFWFhybnFhTjBSS3M5dk8vM0lZYjhUOVltUzdZWVVOSjg4eXF1T2UwNFZI?=
 =?utf-8?B?WG5SenFBLzI1b0tIOWQ2QjkxeVg4aUthenh1Z21SY3NHODhibmFRS0hTV0pz?=
 =?utf-8?B?N0diako0OXVvMGdEQjN4YTczSC9hSmw1UnNrQTJWbHdNaU9Sak1WVERpdHJE?=
 =?utf-8?B?eTZjSmRmd2tXTEYrMU1QRVRLcjRBNnpXV2lOb1h4WFk1dnZ4VmtiKzlDUkI3?=
 =?utf-8?B?cER0cXNjV1M4aldNSXhHa1lKdFdubGhGZWNLTFpDK1RLQ0RvaUcxVEkvKzVR?=
 =?utf-8?B?dGtBVlBLdW5NZjZXc1JlemhnRkJRVS9MbE83MDkyOE9nT0VPNWpZcGpGWVVr?=
 =?utf-8?B?KzZrOFNOcENxV0NGS0N6QU5SNjRqQnZzZVhzMC9sKzhuNWhXOVpQMlFIY3Yy?=
 =?utf-8?B?Y2xOYjJnbndPNmJsSGY3TElReE9xVHh6cFZNdDkxVlQxSysyc0hBb3pPS0Zy?=
 =?utf-8?B?NTVBcG5yUDRScjlPNmZTdVZaRC8zekEyLzArMXhCdmR1eEFaWlpQUXFQYTlZ?=
 =?utf-8?B?TmlGQ0pIQjdoWUUvaUJJcitoOWtONDRnMTRSNFlicFRXZDBDeE15eTViNXJ1?=
 =?utf-8?B?amRhZUhCRyttK3ZKVXNMWnk3SXZaazNaaDk0Uktrc2ZDZ3RDY2RSMEllVGNB?=
 =?utf-8?B?cWR1YVFueUxuaGN0YlFTeW0vajJXcXJZdjlJT3U2L3J5cnk0WHJxQnBGTm10?=
 =?utf-8?B?SDFnZXBLOUZjVllHeEo3QU51d1JsVVhjWFU1Z2NxUXNMS0pvNW5WZDNqdlkr?=
 =?utf-8?B?ZWc4N1djT0t2am5YMytpb2pXNFkvbk5SNFN3SUY4NWxRT01UZXBvbnludmNJ?=
 =?utf-8?B?M0JhcjRYUDBKNUFrQVViSmFIaTc4anRnMmFST1kwRndwZXF0UzdkSHlTM055?=
 =?utf-8?B?ckNFSktQbVNpYnhFeC9pVEZrak4xbzRSa3FXUExlbVN2SEp0dGJwQ0RCRUE2?=
 =?utf-8?B?YmdDbEt3Z2V5L2hSK3lycmxYNkdhUEs2cVRGSUJ0UkdyWjY5dHNnYnFTMmR6?=
 =?utf-8?B?K3JnZ2cxZnROREtkQkl1ZGF3QisvM1RTTWVLd2NhRTZhYnJMNDJ1SEdQdW1O?=
 =?utf-8?B?Z0lMNTV4L3BEN0R5OXNQQXg5YUVGOFZHUkdjRVVyYmhwaURQZThrbEJtYkxY?=
 =?utf-8?B?NHlWektmMnh2WjlZbGEyVFgwSm9qMDk1RTZiNnpYR2lPVVVXdFU2NnZMUUVY?=
 =?utf-8?B?RnJucE9sK1FwejBycU8vME0za0lpanBhcmU0K0NoeklJUFNORm96OFJHSnpP?=
 =?utf-8?B?NjRKelp2MngyQTV3ZW9hNkZyWEVQdXRBVmtjS0E2d25hK2RvVkJacjdsVjNJ?=
 =?utf-8?B?MEhPQWgzRndMalNLSFBjSGUvSDF3OGF0YjVsTUFRMGQvcFZ0YTVZSC80U0Vu?=
 =?utf-8?B?L3RDU2duTWlrbXMrVDZhckpWYStLa3RQUEZPNWRSYitZbTUra2MwV3M4VVZ2?=
 =?utf-8?B?OHByREJvNnQxcUh4bXE5NG1YZGx0KzFIZ1Z1N1ZXRDg0WVhVYnZieW1MNEha?=
 =?utf-8?Q?AWwSt5MOFprfZkq5oMfmuPA25TOripiXMPCEd+n?=
X-OriginatorOrg: yorku.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e583551-cfd5-456b-7527-08d8d04738b6
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 17:45:58.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 34531318-7011-4fd4-87f0-a43816c49bd0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQuugCISjoN9OEExjDbnCCga+DllmaOPfE/bJC03EdFoKiI0g6Uj5UZDEoTpVf8x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB4257
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/13/2021 9:35 AM, Trond Myklebust wrote:
> On Sat, 2021-02-13 at 09:28 -0500, Trond Myklebust wrote:
>> On Fri, 2021-02-12 at 21:12 -0500, Jason Keltz wrote:
>>> On 2/12/2021 7:56 PM, Trond Myklebust wrote:
>>>> On Fri, 2021-02-12 at 19:13 -0500, Jason Keltz wrote:
>>>>> Hi.
>>>>>
>>>>> I'm having a very frustrrating NFS related problem that I am
>>>>> hoping
>>>>> someone might be able to shed some light on.
>>>>>
>>>>> I have several file servers, and clients all running CentOS 7.8
>>>>> (kernel
>>>>> 3.10.0-1127.18.2.el7).  They are joined to an Active Directory
>>>>> domain
>>>>> controller (Samba).
>>>>>
>>>>> uid, gid, homedir information is in the directory. All the
>>>>> clients
>>>>> are
>>>>> running Winbind.
>>>>>
>>>>> I can freely ssh between all the CentOS machines, and my home
>>>>> directory
>>>>> is auto-mounted from the NFS server using NFSv4.1 and krb5.
>>>>> It's
>>>>> pretty
>>>>> nice!
>>>>>
>>>>> If I add myself to a new AD group (group name is cmosp18 gid is
>>>>> 100006)
>>>>> , and I wait 5 minutes (the winbind cache timeout), then I can
>>>>> log
>>>>> out
>>>>> of a system and back in, and I will be in the new group (that
>>>>> is
>>>>> "groups" command shows that I'm in the group).
>>>>>
>>>>> I can cd into /tmp, create a file, and chgrp it to the new
>>>>> group
>>>>> and
>>>>> it
>>>>> works exactly as I would expect.  However, if I try to go into
>>>>> my
>>>>> home
>>>>> directory, create a file there, and chgrp it to the new group,
>>>>> the
>>>>> NFSv4
>>>>> server returns EPERM for the chgrp.  From the strace of chgrp:
>>>>>
>>>>> fchownat(AT_FDCWD, "l", -1, 100006, 0)  = -1 EPERM (Operation
>>>>> not
>>>>> permitted)
>>>>>
>>>>> If I try the same operation from the same client to the same
>>>>> server
>>>>> but
>>>>> using NFSv3 (also krb5), it works successfully.
>>>>>
>>>>> I'd think this means that there is an NFS4 id mapping issue,
>>>>> but
>>>>> I
>>>>> don't
>>>>> see what that is.  The client seems to be able to map my user
>>>>> and
>>>>> group
>>>>> correctly. "groups" command on both the client and server shows
>>>>> I'm
>>>>> in
>>>>> the group.  The server seems to map my user and group
>>>>> correctly.
>>>>>
>>>>> If I login to the file server as me, and create the file in my
>>>>> home
>>>>> directory, make it owned by the new group, then I login to the
>>>>> client, I
>>>>> can see the file (owner and group shows up perfectly fine)
>>>>> (even
>>>>> though
>>>>> I can't create it on the client).
>>>>>
>>>>> In addition, if I login to a client that I haven't logged into,
>>>>> then
>>>>> I
>>>>> can change the group of the file in my home directory to the
>>>>> new
>>>>> group
>>>>> as well.
>>>>>
>>>>> Here's a tcpdump between my host and the nfs server when the
>>>>> chgrp is
>>>>> rejected:
>>>>>
>>>>>    > 15:43:50.950575 IP (tos 0x0, ttl 64, id 34491, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc54d (incorrect -> 0xd37d), seq 912:1112, ack 729, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954964 ecr 510044867], length 200: NFS request
>>>>> xid
>>>>> 2301246825 196 getattr fh 0,1/53
>>>>>    > 15:43:50.951333 IP (tos 0x0, ttl 63, id 17178, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0x4785 (correct), seq 729:929, ack 1112, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510052992 ecr 5954964], length 200: NFS reply xid
>>>>> 2301246825
>>>>> reply
>>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:50.951379 IP (tos 0x0, ttl 64, id 34492, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 52)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [.],
>>>>> cksum
>>>>> 0xc485 (incorrect -> 0x733d), seq 1112, ack 929, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954965 ecr 510052992], length 0
>>>>>    > 15:43:50.952260 IP (tos 0x0, ttl 64, id 34493, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc54d (incorrect -> 0x8815), seq 1112:1312, ack 929, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954966 ecr 510052992], length 200: NFS request
>>>>> xid
>>>>> 2318024041 196 getattr fh 0,1/53
>>>>>    > 15:43:50.953121 IP (tos 0x0, ttl 63, id 17179, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xd848 (correct), seq 929:1129, ack 1312, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510052994 ecr 5954966], length 200: NFS reply xid
>>>>> 2318024041
>>>>> reply
>>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:50.958636 IP (tos 0x0, ttl 64, id 34494, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 264)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc559 (incorrect -> 0x85f1), seq 1312:1524, ack 1129, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954972 ecr 510052994], length 212: NFS request
>>>>> xid
>>>>> 2334801257 208 getattr fh 0,1/53
>>>>>    > 15:43:50.959401 IP (tos 0x0, ttl 63, id 17180, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0x8a16 (correct), seq 1129:1329, ack 1524, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510053000 ecr 5954972], length 200: NFS reply xid
>>>>> 2334801257
>>>>> reply
>>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:50.959794 IP (tos 0x0, ttl 64, id 34495, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc54d (incorrect -> 0xaea5), seq 1524:1724, ack 1329, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954973 ecr 510053000], length 200: NFS request
>>>>> xid
>>>>> 2351578473 196 getattr fh 0,1/53
>>>>>    > 15:43:50.960530 IP (tos 0x0, ttl 63, id 17181, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc23a (correct), seq 1329:1529, ack 1724, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510053001 ecr 5954973], length 200: NFS reply xid
>>>>> 2351578473
>>>>> reply
>>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:50.960878 IP (tos 0x0, ttl 64, id 34496, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 264)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc559 (incorrect -> 0x04e5), seq 1724:1936, ack 1529, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954974 ecr 510053001], length 212: NFS request
>>>>> xid
>>>>> 2368355689 208 getattr fh 0,1/53
>>>>>    > 15:43:50.961618 IP (tos 0x0, ttl 63, id 17182, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xcc54 (correct), seq 1529:1729, ack 1936, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510053002 ecr 5954974], length 200: NFS reply xid
>>>>> 2368355689
>>>>> reply
>>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:50.961933 IP (tos 0x0, ttl 64, id 34497, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 256)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc551 (incorrect -> 0x0e22), seq 1936:2140, ack 1729, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954975 ecr 510053002], length 204: NFS request
>>>>> xid
>>>>> 2385132905 200 getattr fh 0,1/53
>>>>>    > 15:43:50.962656 IP (tos 0x0, ttl 63, id 17183, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 356)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xb114 (correct), seq 1729:2033, ack 2140, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510053003 ecr 5954975], length 304: NFS reply xid
>>>>> 2385132905
>>>>> reply
>>>>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:50.963142 IP (tos 0x0, ttl 64, id 34498, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 264)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc559 (incorrect -> 0x80f7), seq 2140:2352, ack 2033, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5954977 ecr 510053003], length 212: NFS request
>>>>> xid
>>>>> 2401910121 208 getattr fh 0,1/53
>>>>>    > 15:43:50.964055 IP (tos 0x0, ttl 63, id 17184, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 252)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0x2d91 (correct), seq 2033:2233, ack 2352, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510053005 ecr 5954977], length 200: NFS reply xid
>>>>> 2401910121
>>>>> reply
>>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:51.003985 IP (tos 0x0, ttl 64, id 34499, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 52)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [.],
>>>>> cksum
>>>>> 0xc485 (incorrect -> 0x690b), seq 2352, ack 2233, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5955018 ecr 510053005], length 0
>>>>>    > 15:43:51.027598 IP (tos 0x0, ttl 64, id 34500, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 272)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc561 (incorrect -> 0x83a6), seq 2352:2572, ack 2233, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5955041 ecr 510053005], length 220: NFS request
>>>>> xid
>>>>> 2418687337 216 getattr fh 0,1/53
>>>>>    > 15:43:51.027992 IP (tos 0x0, ttl 63, id 17185, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 412)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0x9b87 (correct), seq 2233:2593, ack 2572, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510053069 ecr 5955041], length 360: NFS reply xid
>>>>> 2418687337
>>>>> reply
>>>>> ok 356 getattr NON 5 ids 0/-1374905249 sz 9481761
>>>>>    > 15:43:51.028003 IP (tos 0x0, ttl 64, id 34501, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 52)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [.],
>>>>> cksum
>>>>> 0xc485 (incorrect -> 0x666f), seq 2572, ack 2593, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5955042 ecr 510053069], length 0
>>>>>    > 15:43:51.028359 IP (tos 0x0, ttl 64, id 34502, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 320)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc591 (incorrect -> 0x688b), seq 2572:2840, ack 2593, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5955042 ecr 510053069], length 268: NFS request
>>>>> xid
>>>>> 2435464553 264 getattr fh 0,1/53
>>>>>    > 15:43:51.028741 IP (tos 0x0, ttl 63, id 17186, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 196)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0x7ac5 (correct), seq 2593:2737, ack 2840, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510053070 ecr 5955042], length 144: NFS reply xid
>>>>> 2435464553
>>>>> reply
>>>>> ok 140 getattr ERROR: Operation not permitted
>>>>>    > 15:43:51.204032 IP (tos 0x0, ttl 64, id 34503, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 52)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [.],
>>>>> cksum
>>>>> 0xc485 (incorrect -> 0x6422), seq 2840, ack 2737, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5955218 ecr 510053070], length 0
>>>>>    > 15:44:08.039984 IP (tos 0x0, ttl 64, id 34504, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 256)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc551 (incorrect -> 0x8c10), seq 2840:3044, ack 2737, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5972054 ecr 510053070], length 204: NFS request
>>>>> xid
>>>>> 2452241769 200 getattr fh 0,1/53
>>>>>    > 15:44:08.040888 IP (tos 0x0, ttl 63, id 17187, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 356)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xea43 (correct), seq 2737:3041, ack 3044, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510070082 ecr 5972054], length 304: NFS reply xid
>>>>> 2452241769
>>>>> reply
>>>>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>>>>    > 15:44:08.040945 IP (tos 0x0, ttl 64, id 34505, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 52)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [.],
>>>>> cksum
>>>>> 0xc485 (incorrect -> 0xdded), seq 3044, ack 3041, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5972054 ecr 510070082], length 0
>>>>>    > 15:44:11.053805 IP (tos 0x0, ttl 64, id 34506, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 256)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xc551 (incorrect -> 0x883a), seq 3044:3248, ack 3041, win
>>>>> 8934,
>>>>> options
>>>>> [nop,nop,TS val 5975067 ecr 510070082], length 204: NFS request
>>>>> xid
>>>>> 2469018985 200 getattr fh 0,1/53
>>>>>    > 15:44:11.054532 IP (tos 0x0, ttl 63, id 17188, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 356)
>>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags
>>>>> [P.],
>>>>> cksum
>>>>> 0xebd7 (correct), seq 3041:3345, ack 3248, win 1769, options
>>>>> [nop,nop,TS
>>>>> val 510073095 ecr 5975067], length 304: NFS reply xid
>>>>> 2469018985
>>>>> reply
>>>>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>>>>    > 15:44:11.054594 IP (tos 0x0, ttl 64, id 34507, offset 0,
>>>>> flags
>>>>> [DF],
>>>>> proto TCP (6), length 52)
>>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags
>>>>> [.],
>>>>> cksum
>>>>> 0xc485 (incorrect -> 0xc466), seq 3248, ack 3345, win 8934,
>>>>> options
>>>>> [nop,nop,TS val 5975068 ecr 510073095], length 0
>>>>>
>>>>> At 15:43:51.028741 it appears that it's the server saying no.
>>>>> But
>>>>> how
>>>>> can I debug why it is denying access?
>>>>>
>>>>> I restart nfs-idmap on the NFS  server, and run nfsidmap -c on
>>>>> the
>>>>> client.  Here's the rpc.idmapd log during the chgrp -- the
>>>>> server
>>>>> knows
>>>>> me, my uid, my gid, the group I'm trying to change a file to
>>>>> (cmosp18),
>>>>> and its GID:
>>>>>
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: using
>>>>> domain:
>>>>> eecs.yorku.ca
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: Realms
>>>>> list:
>>>>> 'EECS.YORKU.CA'
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: loaded
>>>>> plugin
>>>>> /lib64/libnfsidmap/nsswitch.so for method nsswitch
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap:
>>>>> using
>>>>> domain: eecs.yorku.ca
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap:
>>>>> Realms
>>>>> list:
>>>>> 'EECS.YORKU.CA'
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Expiration time is
>>>>> 600
>>>>> seconds.
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap:
>>>>> loaded
>>>>> plugin /lib64/libnfsidmap/nsswitch.so for method nsswitch
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened
>>>>> /proc/net/rpc/nfs4.nametoid/channel
>>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened
>>>>> /proc/net/rpc/nfs4.idtoname/channel
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>>> authbuf=gss/krb5
>>>>> authtype=user
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>>> calling
>>>>> nsswitch->uid_to_name
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>>> nsswitch->uid_to_name returned 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>>> final
>>>>> return
>>>>> value is 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id
>>>>> "1004" -
>>>>> name "jas@eecs.yorku.ca"
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>>> authbuf=gss/krb5
>>>>> authtype=group
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>>> calling
>>>>> nsswitch->gid_to_name
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>>> nsswitch->gid_to_name returned 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>>> final
>>>>> return
>>>>> value is 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id
>>>>> "1000"
>>>>> ->
>>>>> name "tech@eecs.yorku.ca"
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>>> authbuf=gss/krb5
>>>>> authtype=user
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>>> calling
>>>>> nsswitch->uid_to_name
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>>> nsswitch->uid_to_name returned 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>>> final
>>>>> return
>>>>> value is 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id
>>>>> "0"
>>>>> ->
>>>>> name
>>>>> "root@eecs.yorku.ca"
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>>> authbuf=gss/krb5
>>>>> authtype=group
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>>> calling
>>>>> nsswitch->gid_to_name
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>>> nsswitch->gid_to_name returned 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>>> final
>>>>> return
>>>>> value is 0
>>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id
>>>>> "0" ->
>>>>> name "root@eecs.yorku.ca"
>>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfsdcb:
>>>>> authbuf=gss/krb5
>>>>> authtype=group
>>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid:
>>>>> calling
>>>>> nsswitch->name_to_gid
>>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid:
>>>>> name
>>>>> 'cmosp18@eecs.yorku.ca' domain 'eecs.yorku.ca': resulting
>>>>> localname
>>>>> 'cmosp18'
>>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid:
>>>>> name
>>>>> 'cmosp18@eecs.yorku.ca' gid 100006
>>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid:
>>>>> nsswitch->name_to_gid returned 0
>>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid:
>>>>> final
>>>>> return
>>>>> value is 0
>>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: Server : (group)
>>>>> name
>>>>> "cmosp18@eecs.yorku.ca" -> id "100006"
>>>>>
>>>>> The client knows all the same information as well.  I've had
>>>>> the
>>>>> client
>>>>> sitting for hours already, and I still can't chgrp the file.
>>>>> On
>>>>> the
>>>>> other hand, I rebooted the client, and then, right after login,
>>>>> I
>>>>> can
>>>>> chgrp the file.
>>>>>
>>>>> How can I debug this further?
>>>>>
>>>>> I was supposed to be moving 300+ systems to the domain this
>>>>> coming
>>>>> week,
>>>>> but I may have to abort that move if I can't solve this
>>>>> problem.
>>>>>
>>>>> Thanks very much for any assistance....
>>>>>
>>>> Have you enabled the '-g' option in rpc.mountd on your server
>>>> (man
>>>> 8
>>>> rpc.mountd)? Chances are that you are hitting the 16 group limit
>>>> in
>>>> AUTH_SYS, so you probably want to ensure that the server is
>>>> mapping
>>>> your user to the correct set of groups.
>>> Hi Trond,
>>>
>>> All of the mounts are Kerberos mounts so shouldn't be affected by
>>> the
>>> 16
>>> group limit, right?
>> If you are using one of the sec=krb5/krb5i/krb5p then you should be
>> unaffected by the 16 group limit because the NFS client doesn't
>> transmit any group information to the server. The mapping from an
>> authorised account to a set of supplementary groups must happen on
>> the
>> server, not the client.
>>
> Let me nuance that a bit... It is possible that the gssproxy daemon
> these days uses the PAC contained in your RPCSEC_GSS cred to resolve
> your group membership in the absence of the '-g' option on rpc.mountd
> (IIRC support for a PAC was one of the main motivations for the rewrite
> of rpc.svcgssd to gssproxy).
> If so, you may need to log out and then log back in again on your
> client in order to update the PAC.

I logged out of the client and back in and the same problem persisted.

I even unmounted the home directory on the client.  I restart gssproxy 
on the server.  When I logged back into the client I still could not 
access the file (even though I was in the group).

If I reboot the client, the problem goes away until I add another group, 
but I can repeat this process over and over again with the same result 
each time.

The gssproxy in version CentOS 7 is older - using gssproxy 0.8.0-28.el7.

Jason.

