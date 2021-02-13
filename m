Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5425131ACB3
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 16:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBMPsh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 10:48:37 -0500
Received: from mail-eopbgr670091.outbound.protection.outlook.com ([40.107.67.91]:30699
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229584AbhBMPsf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 13 Feb 2021 10:48:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMFlG9htgVU7uapBNrRg2V6/cipH6xLwycX/cxbz63Fpd8e34ee0Zv0ilNTPxrYj28iLlYm1rmN4IJ1CvZCrWIYOzLx7k2mllqux4lQ0QCq8Q1BPB7s7ycKQ4Ukz23+t0xHhtFn/lT/4caOFLDpZrcvlxsLjDx1GWnOgRs5pi5xKtXMrekgzGsxbJICKVvyaesstTZ64g0YjrxajffjSRsOWGdIBwSiFW1aRlHjIsUwYq1hG9wt6A+otAqEdv/8De16hIEFI0fgr1o5J48B/iblNGn4Du8UW8sJbAUGtWKCsjYwKGx6z+KWspqgC8OYbLzDMDf4y0konbDf+3Vhiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaArMmK01fJPu+7LPxhFvlR+OPFMdJKQKYwBPokFx7s=;
 b=hLob223xYDKxmkBm23JWTCZ88zh5cPMgBunA7J8ZYu3Xxj4B8DV/Km3rSM7C02JX3ZdDyo1AaZYXrvbgvotvFMrfBaZEmY+xRYIGmFp6SIS+rrir5P3yb0g7sMnFzjE9TJkOQmwcHLG133vZTaWABeqRP20IgaUqY3LpdgfJix1WWRoYgGPo7tyYuYD5bEEyZHgcrMfSQW/eBk0EKJdmxUZ/ghLjiZfIqQ/bBSsFIFf92Oedgoqyb+ApUnbjuWi705ur420ZELA+9OOdG82UhQMVc2GoQxFob04FRIb4t97juwNUVSqFJp99ZQNmRQTPjje0/y0YHvryAllkOUyZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yorku.ca; dmarc=pass action=none header.from=yorku.ca;
 dkim=pass header.d=yorku.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yuoffice.onmicrosoft.com; s=selector2-yuoffice-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaArMmK01fJPu+7LPxhFvlR+OPFMdJKQKYwBPokFx7s=;
 b=v9uzfkowxgZCHP1ju8Liw5YpeRcXKMdZAzgHKACEj603nobCzl1XeirxJs4nwekf1ni7XAf6+pClaq36xB3aYG6r0rqU53YDurSbzld/EqEVLwOXt5pP1iDoGwiBRZ4qOFzUoxzAEbSEoWhlnjoMEIgCrZRm6KWUFQAHa0v3coQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=yorku.ca;
Received: from QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:33::24)
 by QB1PR01MB3810.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Sat, 13 Feb
 2021 15:47:36 +0000
Received: from QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f402:54b6:2a5f:afd0]) by QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f402:54b6:2a5f:afd0%4]) with mapi id 15.20.3825.039; Sat, 13 Feb 2021
 15:47:36 +0000
Subject: Re: NFS server issue after new AD group added to AD user
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ad4ee9a5-9285-b29e-8876-f3c7bb1bdbae@yorku.ca>
 <3795c23197b4f171b143821c033fa1687d3163e7.camel@hammerspace.com>
 <3b87a2d0-697c-c750-48c1-79c016a41052@yorku.ca>
 <ae8a2304d15e518a86b919e9fef2eb2e3c2e02df.camel@hammerspace.com>
From:   Jason Keltz <jas@yorku.ca>
Message-ID: <28713a71-fd2f-30e5-f29b-c1b1e7b5d242@yorku.ca>
Date:   Sat, 13 Feb 2021 10:47:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ae8a2304d15e518a86b919e9fef2eb2e3c2e02df.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [170.133.224.154]
X-ClientProxiedBy: QB1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::44) To QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:33::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.136] (170.133.224.154) by QB1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend Transport; Sat, 13 Feb 2021 15:47:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 592287ac-28f4-48df-0970-08d8d036af20
X-MS-TrafficTypeDiagnostic: QB1PR01MB3810:
X-Microsoft-Antispam-PRVS: <QB1PR01MB381057A836FD7EF56AB3485BD48A9@QB1PR01MB3810.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5zrAONAkAqW7W+Tkk8dcQsuTRSqOsigKRAiMMVQtcIFHsCkzSHSe0kDVVQtTsGW1Vt4MiH2d3MSLeUEHxfUuQKO+8D8ongfSonh2Za5iyTc706h4CkHZ9c3y0SEx3fs/Jb8kH4keT/TWNCkZwHWJ1EaX2teQYSojY9BjBEAwrswF56LOcs9PpEm0W5luB86PKazf4iKwHKE+z3ivC1cHKe+obqgcmzIMejM6UG3YkCKAmpGHuK7g6SqanLYJU1GOg9/A37sdpTJGFomW4pFMGYVqcWuory6pbhgTaEJqVoR2fNzmgYrBPUWPJ9Z4B7RORy9XhCfCk96Vtl4GPXokWMDltGy5ZqstHfRA7KWq0O5KuRwQdDfFzR6yT4aXDgYi1SPWK58IZX8uVRc185Qh0mp9rd2oDmE32OHxzIox5QzlPlZGTTZE5ikDXodKIpP/HaA9YftxSA6DK0oQW9V2039iRW77VZsXZqy5E15URgpeUI1zcLZEl3etx+6t1k2k6PNwNB+THYnX6fo0p00tBRABe4w2QI+J1J7Skg8U4ziQBNqPKl7Z7Su5qoKznnzR5Wd2Fm8L9DVaHdIqZN9Fyneqr2/4z5WziWcTIZQQp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(2616005)(26005)(66556008)(30864003)(956004)(66476007)(66946007)(5660300002)(16576012)(36756003)(16526019)(31696002)(86362001)(478600001)(186003)(53546011)(110136005)(2906002)(786003)(316002)(6486002)(83380400001)(52116002)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TkFlNUhNMEhoeGpsaXdnUnkrVFNaWXE4Z2JVb0hNL05ZeUZBUjhacE1WRzJs?=
 =?utf-8?B?L3FpdnZJYkNxY3B6QkNMdkcwL0xXUFFpZ1ZlbU9id1V0Z0FZVm1aSW41Q1pW?=
 =?utf-8?B?SDNKVHprdDUyV2VpR3VjNHYxZVE3bjhnckY5b3FMK0FGd2ZGN0VsNkNaMEVE?=
 =?utf-8?B?ZUM0VHV2cGY1OHd2UHdjemh3ZU5KYWtjUEJEUzF3d294VG1QVVVVTys2QXFI?=
 =?utf-8?B?N1ZYMmtMWVZhY1hoTkNpdWJyUFk0YWdia2tmV1NOWHI0NGpKOWxZSURrZlRu?=
 =?utf-8?B?anlJTWkzTFFkMEV1YlNVSmRrcDVGMTgzZndQMWt4MGtOcGxqNHVwSkJsYlgw?=
 =?utf-8?B?dmNZd0d1T292bDVpNGpIN2YxRHVyVGZaQTNiMUllN1VudFo1Q1FFQmRUbHN0?=
 =?utf-8?B?N2xjK0hUYzZsZEQxaDV2Sjk2UFBQMzYxQytkekRUa296REVISzFmVE52UlBt?=
 =?utf-8?B?R0c4VFNNZWNwck9BZ0FpcHVpSGowQVNnS0pCTGh4Q0xlbFZwQVVHRy8yU1cr?=
 =?utf-8?B?MkkrMDNWZy9FMExxeWNYN0NJbWpjRENRb3ZUQmozNGxrOFArSHh5SGNnODAy?=
 =?utf-8?B?dzcrY2xzMUprdzROd2MxTEFkTStmVE8wNG9EZjBFbXFxdlRodzI0RDhFeXhM?=
 =?utf-8?B?anRTL3J3UmZ6TWZpa3NhWnZEWnc2aEMveXVmWmdBMzJENmVaSkZMZkFiUWZW?=
 =?utf-8?B?eVFLNWFHUUF1elhDVk9FeldXUm1ZNVZyZGsxbC9US001SVVLNFJZMkdzQVNO?=
 =?utf-8?B?QlUwb01tME5hMDd0K0dpaWVwd2VnbkZDc2ZwcnBXTVp0ZEg3a1pIa0NaMVFy?=
 =?utf-8?B?KzVRbmVCb1AxajBwZlRvNjR4M0c1QjlydUVTRThLNzZCQTN5QXd2a29CalhF?=
 =?utf-8?B?YXFzeU45RDYvV2tOd1lSVS9xZ3dmOVVHRFE3a1kzR3NpNThBOE0ybEdFeFNx?=
 =?utf-8?B?ZmY0K2pGMlp2OWtmV2RJSEFXNDlXa3AvMTZrdDFjNDlvTjk4T3A0TG8wQlQx?=
 =?utf-8?B?Nm5xWWgxeStyUXFORFFnOWVkK2dCL1BPb2ZUY2lNWU1EK2dBZW9XMGw1ei9G?=
 =?utf-8?B?TzFMRnJJSk11VnhhN0JPNHlVMEphTU1xRFhLOGNDZDBVVnV3OTY5aHl6WFI2?=
 =?utf-8?B?a1FLWE9Nc0ZxUzJUakg2aTFUZ0hVeUphaUhyQ3NWa0RJQzQwMTZvbW5aRk9S?=
 =?utf-8?B?YnBvQkZnVXlRTHVPMWtvRG5QWjlrYkVXQ0thTGpFY0FvQzBldVVPclF2NjQx?=
 =?utf-8?B?WkxuRUJUbVRDWEFTcSt6OS96Q2dBWk1KSExvNnBJdFd4Vlhyamg1RDlMWDZ5?=
 =?utf-8?B?cEQ2MURUOGFlS3FhY3JMd1VNS09aVTZub05MMnRldTJLRk1PdklDdVRjcmgw?=
 =?utf-8?B?emdLeEdEUHhKYlRCKzNYMnVEVm1hMTN4RXVuK0t5Q095VCthanYvdmI3V3I3?=
 =?utf-8?B?U2V0ZEZUem16RjRpMERkbnV1VVRMdFhndDJsSGZwL0Rrbk9haVdrcjZwU0ND?=
 =?utf-8?B?UFA1a3cvVGt0N29kTFZxRjkybno4aUdDY3lmZ3Qrb2pBc3RtRzkxbzFueGZy?=
 =?utf-8?B?blF4RUdLTmNoV1dBR293RE5EendDd2JhT1ZSSnRIalFxbHJjc3M0RHRueXhx?=
 =?utf-8?B?MC9ucWZzU3JoZU9lRDdibHljWE14ZEg4RytVZ0RySTFrcDJzdnlQYnNTaHdV?=
 =?utf-8?B?a2NKOVp0ZlF2aEdCWGtrd29RVFJGVHo3aElQTzBBRUNsN251MEx3dnNqMTA3?=
 =?utf-8?Q?/VFlhZ8Ezwk2HCdMaBRIdSDhdxARu97tN2GQSp6?=
X-OriginatorOrg: yorku.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 592287ac-28f4-48df-0970-08d8d036af20
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 15:47:35.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 34531318-7011-4fd4-87f0-a43816c49bd0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgqlawfAwSU5Y2Xlvi7wyBBGo5hjwICM+wrdYtZy2zl6TmQtOXGYD6OsuQmxb8VV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3810
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/13/2021 9:28 AM, Trond Myklebust wrote:
> On Fri, 2021-02-12 at 21:12 -0500, Jason Keltz wrote:
>> On 2/12/2021 7:56 PM, Trond Myklebust wrote:
>>> On Fri, 2021-02-12 at 19:13 -0500, Jason Keltz wrote:
>>>> Hi.
>>>>
>>>> I'm having a very frustrrating NFS related problem that I am
>>>> hoping
>>>> someone might be able to shed some light on.
>>>>
>>>> I have several file servers, and clients all running CentOS 7.8
>>>> (kernel
>>>> 3.10.0-1127.18.2.el7).  They are joined to an Active Directory
>>>> domain
>>>> controller (Samba).
>>>>
>>>> uid, gid, homedir information is in the directory. All the
>>>> clients
>>>> are
>>>> running Winbind.
>>>>
>>>> I can freely ssh between all the CentOS machines, and my home
>>>> directory
>>>> is auto-mounted from the NFS server using NFSv4.1 and krb5.  It's
>>>> pretty
>>>> nice!
>>>>
>>>> If I add myself to a new AD group (group name is cmosp18 gid is
>>>> 100006)
>>>> , and I wait 5 minutes (the winbind cache timeout), then I can
>>>> log
>>>> out
>>>> of a system and back in, and I will be in the new group (that is
>>>> "groups" command shows that I'm in the group).
>>>>
>>>> I can cd into /tmp, create a file, and chgrp it to the new group
>>>> and
>>>> it
>>>> works exactly as I would expect.  However, if I try to go into my
>>>> home
>>>> directory, create a file there, and chgrp it to the new group,
>>>> the
>>>> NFSv4
>>>> server returns EPERM for the chgrp.  From the strace of chgrp:
>>>>
>>>> fchownat(AT_FDCWD, "l", -1, 100006, 0)  = -1 EPERM (Operation not
>>>> permitted)
>>>>
>>>> If I try the same operation from the same client to the same
>>>> server
>>>> but
>>>> using NFSv3 (also krb5), it works successfully.
>>>>
>>>> I'd think this means that there is an NFS4 id mapping issue, but
>>>> I
>>>> don't
>>>> see what that is.  The client seems to be able to map my user and
>>>> group
>>>> correctly. "groups" command on both the client and server shows
>>>> I'm
>>>> in
>>>> the group.  The server seems to map my user and group correctly.
>>>>
>>>> If I login to the file server as me, and create the file in my
>>>> home
>>>> directory, make it owned by the new group, then I login to the
>>>> client, I
>>>> can see the file (owner and group shows up perfectly fine) (even
>>>> though
>>>> I can't create it on the client).
>>>>
>>>> In addition, if I login to a client that I haven't logged into,
>>>> then
>>>> I
>>>> can change the group of the file in my home directory to the new
>>>> group
>>>> as well.
>>>>
>>>> Here's a tcpdump between my host and the nfs server when the
>>>> chgrp is
>>>> rejected:
>>>>
>>>>    > 15:43:50.950575 IP (tos 0x0, ttl 64, id 34491, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc54d (incorrect -> 0xd37d), seq 912:1112, ack 729, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954964 ecr 510044867], length 200: NFS request
>>>> xid
>>>> 2301246825 196 getattr fh 0,1/53
>>>>    > 15:43:50.951333 IP (tos 0x0, ttl 63, id 17178, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0x4785 (correct), seq 729:929, ack 1112, win 1769, options
>>>> [nop,nop,TS
>>>> val 510052992 ecr 5954964], length 200: NFS reply xid 2301246825
>>>> reply
>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:50.951379 IP (tos 0x0, ttl 64, id 34492, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 52)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.],
>>>> cksum
>>>> 0xc485 (incorrect -> 0x733d), seq 1112, ack 929, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954965 ecr 510052992], length 0
>>>>    > 15:43:50.952260 IP (tos 0x0, ttl 64, id 34493, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc54d (incorrect -> 0x8815), seq 1112:1312, ack 929, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954966 ecr 510052992], length 200: NFS request
>>>> xid
>>>> 2318024041 196 getattr fh 0,1/53
>>>>    > 15:43:50.953121 IP (tos 0x0, ttl 63, id 17179, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0xd848 (correct), seq 929:1129, ack 1312, win 1769, options
>>>> [nop,nop,TS
>>>> val 510052994 ecr 5954966], length 200: NFS reply xid 2318024041
>>>> reply
>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:50.958636 IP (tos 0x0, ttl 64, id 34494, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 264)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc559 (incorrect -> 0x85f1), seq 1312:1524, ack 1129, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954972 ecr 510052994], length 212: NFS request
>>>> xid
>>>> 2334801257 208 getattr fh 0,1/53
>>>>    > 15:43:50.959401 IP (tos 0x0, ttl 63, id 17180, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0x8a16 (correct), seq 1129:1329, ack 1524, win 1769, options
>>>> [nop,nop,TS
>>>> val 510053000 ecr 5954972], length 200: NFS reply xid 2334801257
>>>> reply
>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:50.959794 IP (tos 0x0, ttl 64, id 34495, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc54d (incorrect -> 0xaea5), seq 1524:1724, ack 1329, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954973 ecr 510053000], length 200: NFS request
>>>> xid
>>>> 2351578473 196 getattr fh 0,1/53
>>>>    > 15:43:50.960530 IP (tos 0x0, ttl 63, id 17181, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0xc23a (correct), seq 1329:1529, ack 1724, win 1769, options
>>>> [nop,nop,TS
>>>> val 510053001 ecr 5954973], length 200: NFS reply xid 2351578473
>>>> reply
>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:50.960878 IP (tos 0x0, ttl 64, id 34496, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 264)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc559 (incorrect -> 0x04e5), seq 1724:1936, ack 1529, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954974 ecr 510053001], length 212: NFS request
>>>> xid
>>>> 2368355689 208 getattr fh 0,1/53
>>>>    > 15:43:50.961618 IP (tos 0x0, ttl 63, id 17182, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0xcc54 (correct), seq 1529:1729, ack 1936, win 1769, options
>>>> [nop,nop,TS
>>>> val 510053002 ecr 5954974], length 200: NFS reply xid 2368355689
>>>> reply
>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:50.961933 IP (tos 0x0, ttl 64, id 34497, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 256)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc551 (incorrect -> 0x0e22), seq 1936:2140, ack 1729, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954975 ecr 510053002], length 204: NFS request
>>>> xid
>>>> 2385132905 200 getattr fh 0,1/53
>>>>    > 15:43:50.962656 IP (tos 0x0, ttl 63, id 17183, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 356)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0xb114 (correct), seq 1729:2033, ack 2140, win 1769, options
>>>> [nop,nop,TS
>>>> val 510053003 ecr 5954975], length 304: NFS reply xid 2385132905
>>>> reply
>>>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:50.963142 IP (tos 0x0, ttl 64, id 34498, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 264)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc559 (incorrect -> 0x80f7), seq 2140:2352, ack 2033, win 8934,
>>>> options
>>>> [nop,nop,TS val 5954977 ecr 510053003], length 212: NFS request
>>>> xid
>>>> 2401910121 208 getattr fh 0,1/53
>>>>    > 15:43:50.964055 IP (tos 0x0, ttl 63, id 17184, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 252)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0x2d91 (correct), seq 2033:2233, ack 2352, win 1769, options
>>>> [nop,nop,TS
>>>> val 510053005 ecr 5954977], length 200: NFS reply xid 2401910121
>>>> reply
>>>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:51.003985 IP (tos 0x0, ttl 64, id 34499, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 52)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.],
>>>> cksum
>>>> 0xc485 (incorrect -> 0x690b), seq 2352, ack 2233, win 8934,
>>>> options
>>>> [nop,nop,TS val 5955018 ecr 510053005], length 0
>>>>    > 15:43:51.027598 IP (tos 0x0, ttl 64, id 34500, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 272)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc561 (incorrect -> 0x83a6), seq 2352:2572, ack 2233, win 8934,
>>>> options
>>>> [nop,nop,TS val 5955041 ecr 510053005], length 220: NFS request
>>>> xid
>>>> 2418687337 216 getattr fh 0,1/53
>>>>    > 15:43:51.027992 IP (tos 0x0, ttl 63, id 17185, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 412)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0x9b87 (correct), seq 2233:2593, ack 2572, win 1769, options
>>>> [nop,nop,TS
>>>> val 510053069 ecr 5955041], length 360: NFS reply xid 2418687337
>>>> reply
>>>> ok 356 getattr NON 5 ids 0/-1374905249 sz 9481761
>>>>    > 15:43:51.028003 IP (tos 0x0, ttl 64, id 34501, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 52)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.],
>>>> cksum
>>>> 0xc485 (incorrect -> 0x666f), seq 2572, ack 2593, win 8934,
>>>> options
>>>> [nop,nop,TS val 5955042 ecr 510053069], length 0
>>>>    > 15:43:51.028359 IP (tos 0x0, ttl 64, id 34502, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 320)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc591 (incorrect -> 0x688b), seq 2572:2840, ack 2593, win 8934,
>>>> options
>>>> [nop,nop,TS val 5955042 ecr 510053069], length 268: NFS request
>>>> xid
>>>> 2435464553 264 getattr fh 0,1/53
>>>>    > 15:43:51.028741 IP (tos 0x0, ttl 63, id 17186, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 196)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0x7ac5 (correct), seq 2593:2737, ack 2840, win 1769, options
>>>> [nop,nop,TS
>>>> val 510053070 ecr 5955042], length 144: NFS reply xid 2435464553
>>>> reply
>>>> ok 140 getattr ERROR: Operation not permitted
>>>>    > 15:43:51.204032 IP (tos 0x0, ttl 64, id 34503, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 52)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.],
>>>> cksum
>>>> 0xc485 (incorrect -> 0x6422), seq 2840, ack 2737, win 8934,
>>>> options
>>>> [nop,nop,TS val 5955218 ecr 510053070], length 0
>>>>    > 15:44:08.039984 IP (tos 0x0, ttl 64, id 34504, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 256)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc551 (incorrect -> 0x8c10), seq 2840:3044, ack 2737, win 8934,
>>>> options
>>>> [nop,nop,TS val 5972054 ecr 510053070], length 204: NFS request
>>>> xid
>>>> 2452241769 200 getattr fh 0,1/53
>>>>    > 15:44:08.040888 IP (tos 0x0, ttl 63, id 17187, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 356)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0xea43 (correct), seq 2737:3041, ack 3044, win 1769, options
>>>> [nop,nop,TS
>>>> val 510070082 ecr 5972054], length 304: NFS reply xid 2452241769
>>>> reply
>>>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>>>    > 15:44:08.040945 IP (tos 0x0, ttl 64, id 34505, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 52)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.],
>>>> cksum
>>>> 0xc485 (incorrect -> 0xdded), seq 3044, ack 3041, win 8934,
>>>> options
>>>> [nop,nop,TS val 5972054 ecr 510070082], length 0
>>>>    > 15:44:11.053805 IP (tos 0x0, ttl 64, id 34506, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 256)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>>>> cksum
>>>> 0xc551 (incorrect -> 0x883a), seq 3044:3248, ack 3041, win 8934,
>>>> options
>>>> [nop,nop,TS val 5975067 ecr 510070082], length 204: NFS request
>>>> xid
>>>> 2469018985 200 getattr fh 0,1/53
>>>>    > 15:44:11.054532 IP (tos 0x0, ttl 63, id 17188, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 356)
>>>>    >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>>>> cksum
>>>> 0xebd7 (correct), seq 3041:3345, ack 3248, win 1769, options
>>>> [nop,nop,TS
>>>> val 510073095 ecr 5975067], length 304: NFS reply xid 2469018985
>>>> reply
>>>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>>>    > 15:44:11.054594 IP (tos 0x0, ttl 64, id 34507, offset 0,
>>>> flags
>>>> [DF],
>>>> proto TCP (6), length 52)
>>>>    >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.],
>>>> cksum
>>>> 0xc485 (incorrect -> 0xc466), seq 3248, ack 3345, win 8934,
>>>> options
>>>> [nop,nop,TS val 5975068 ecr 510073095], length 0
>>>>
>>>> At 15:43:51.028741 it appears that it's the server saying no.
>>>> But
>>>> how
>>>> can I debug why it is denying access?
>>>>
>>>> I restart nfs-idmap on the NFS  server, and run nfsidmap -c on
>>>> the
>>>> client.  Here's the rpc.idmapd log during the chgrp -- the server
>>>> knows
>>>> me, my uid, my gid, the group I'm trying to change a file to
>>>> (cmosp18),
>>>> and its GID:
>>>>
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: using
>>>> domain:
>>>> eecs.yorku.ca
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: Realms
>>>> list:
>>>> 'EECS.YORKU.CA'
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: loaded
>>>> plugin
>>>> /lib64/libnfsidmap/nsswitch.so for method nsswitch
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap:
>>>> using
>>>> domain: eecs.yorku.ca
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap:
>>>> Realms
>>>> list:
>>>> 'EECS.YORKU.CA'
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Expiration time is 600
>>>> seconds.
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap:
>>>> loaded
>>>> plugin /lib64/libnfsidmap/nsswitch.so for method nsswitch
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened
>>>> /proc/net/rpc/nfs4.nametoid/channel
>>>>    > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened
>>>> /proc/net/rpc/nfs4.idtoname/channel
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>> authbuf=gss/krb5
>>>> authtype=user
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>> calling
>>>> nsswitch->uid_to_name
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>> nsswitch->uid_to_name returned 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>> final
>>>> return
>>>> value is 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id
>>>> "1004" -
>>>> name "jas@eecs.yorku.ca"
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>> authbuf=gss/krb5
>>>> authtype=group
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>> calling
>>>> nsswitch->gid_to_name
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>> nsswitch->gid_to_name returned 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>> final
>>>> return
>>>> value is 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id
>>>> "1000"
>>>> ->
>>>> name "tech@eecs.yorku.ca"
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>> authbuf=gss/krb5
>>>> authtype=user
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>> calling
>>>> nsswitch->uid_to_name
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>> nsswitch->uid_to_name returned 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>>>> final
>>>> return
>>>> value is 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id "0"
>>>> ->
>>>> name
>>>> "root@eecs.yorku.ca"
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb:
>>>> authbuf=gss/krb5
>>>> authtype=group
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>> calling
>>>> nsswitch->gid_to_name
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>> nsswitch->gid_to_name returned 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>>>> final
>>>> return
>>>> value is 0
>>>>    > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id
>>>> "0" ->
>>>> name "root@eecs.yorku.ca"
>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfsdcb:
>>>> authbuf=gss/krb5
>>>> authtype=group
>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid:
>>>> calling
>>>> nsswitch->name_to_gid
>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid: name
>>>> 'cmosp18@eecs.yorku.ca' domain 'eecs.yorku.ca': resulting
>>>> localname
>>>> 'cmosp18'
>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid: name
>>>> 'cmosp18@eecs.yorku.ca' gid 100006
>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid:
>>>> nsswitch->name_to_gid returned 0
>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid:
>>>> final
>>>> return
>>>> value is 0
>>>>    > Feb 12 15:51:11 nfs rpc.idmapd[13384]: Server : (group) name
>>>> "cmosp18@eecs.yorku.ca" -> id "100006"
>>>>
>>>> The client knows all the same information as well.  I've had the
>>>> client
>>>> sitting for hours already, and I still can't chgrp the file.  On
>>>> the
>>>> other hand, I rebooted the client, and then, right after login, I
>>>> can
>>>> chgrp the file.
>>>>
>>>> How can I debug this further?
>>>>
>>>> I was supposed to be moving 300+ systems to the domain this
>>>> coming
>>>> week,
>>>> but I may have to abort that move if I can't solve this problem.
>>>>
>>>> Thanks very much for any assistance....
>>>>
>>> Have you enabled the '-g' option in rpc.mountd on your server (man
>>> 8
>>> rpc.mountd)? Chances are that you are hitting the 16 group limit in
>>> AUTH_SYS, so you probably want to ensure that the server is mapping
>>> your user to the correct set of groups.
>> Hi Trond,
>>
>> All of the mounts are Kerberos mounts so shouldn't be affected by the
>> 16
>> group limit, right?
> If you are using one of the sec=krb5/krb5i/krb5p then you should be
> unaffected by the 16 group limit because the NFS client doesn't
> transmit any group information to the server. The mapping from an
> authorised account to a set of supplementary groups must happen on the
> server, not the client.

Hi Trond,

Yes - I am using only sec=krb5.

My account was added to a new supplementary group in AD.

I logged out of my workstation and back in, and the workstation sees me 
in the new supplementary group.

The file server also sees me in the new supplementary group.

The file server won't let me access files in that group from my 
workstation, but my workstation recognizes the group (ls -l shows group 
name perfectly, and group shows up in nfsidmap).

If I login to a workstation I was previously not logged into, I can 
access files in that group with my ID.

If I reboot my workstation, I can access files in the new supplementary 
group.

What debug information can I provide to help explain this puzzling problem?

Thanks,

Jason.

