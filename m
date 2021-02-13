Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8F31A99F
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 03:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBMCNe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 21:13:34 -0500
Received: from mail-eopbgr660096.outbound.protection.outlook.com ([40.107.66.96]:9680
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhBMCNd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 21:13:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtieF6DnhAeyY0m5N6TqzS97LItcLAxm0rmJFWzqzU3bYhZ1ryFHNBkZxB/4rBCO9iWCV3tCWAbChYGXENgfyo8olu7ldhxg3GnZ/NbQGGbwC9DjtcqP1lmrYWUQzkVztMKouPfQxS/fy5OGvSpWyhYCNxqmqPSxI9cJ8VmB0aBSDutVzRIsiPNi1ekq2F7P1O4XlHcUmDNdCom6XO3DXz7ae/0JvGxQQtsLwERdtSVxDCN1pmuFKnw3FC2N4BHcJrGCXT91Bgu1vFZieHOfwqbwSDxyQNvKEt+KOmmDIyv7GI1/OkZEpV2bRjHa1PwvIEgBDuq1Fw9sMOxB4gu+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW/gM70e/MPxBmURw4zyPC+1mjQ9o1tP4dCM7rI6ctk=;
 b=FdxETXqAugT6q7fbyHQUgeUVNfpbX/4ZT1zwf54YI+QXH86lY0XinKlrm4fp+UQ2YIrPsCBDVJxbfB8yrFNVKxbS72eudtqjRNDQtBae06UKeoItZB3cfe6sag3/w4jghqCLv+w0Ek+IshWe/pUOI0MJkjwK2feIRz6rA6N0AqHKRPZiSpFK4xm7GZjK86ANT6vC/qH5Dk08Yv3JKgqbsh43OUZlsaJhnwOlgV7rQ2ldNn9t9MOTXDTzC82BHF9iS5RM+aXo4tJbNkVeaGmzYB77mVx/bI2LBJ2UfLTM35RUNP9U5geFwo7G3XC6gU0Nm1pHaxAOFG7CCpkPg670oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yorku.ca; dmarc=pass action=none header.from=yorku.ca;
 dkim=pass header.d=yorku.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yuoffice.onmicrosoft.com; s=selector2-yuoffice-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW/gM70e/MPxBmURw4zyPC+1mjQ9o1tP4dCM7rI6ctk=;
 b=kjdLqiDgI5DJHqU4Vfi7/0HfO7C59mE0SP4I/kEfz9wr2tktf2UqxedI7b1AhLzT40dinsRFIERw8xc9Pq7C59pgP9GP2e+eWA1US2O6bX5uVFOWBJpaJAwsdU5hgmd8MF4liBtmr3Y0fOhgdHycgYBisjB6y98JtZGGMFGl8zQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=yorku.ca;
Received: from QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM (52.132.86.88) by
 YQXPR01MB2837.CANPRD01.PROD.OUTLOOK.COM (52.132.93.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Sat, 13 Feb 2021 02:12:49 +0000
Received: from QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f402:54b6:2a5f:afd0]) by QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::f402:54b6:2a5f:afd0%4]) with mapi id 15.20.3825.039; Sat, 13 Feb 2021
 02:12:49 +0000
Subject: Re: NFS server issue after new AD group added to AD user
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ad4ee9a5-9285-b29e-8876-f3c7bb1bdbae@yorku.ca>
 <3795c23197b4f171b143821c033fa1687d3163e7.camel@hammerspace.com>
From:   Jason Keltz <jas@yorku.ca>
Message-ID: <3b87a2d0-697c-c750-48c1-79c016a41052@yorku.ca>
Date:   Fri, 12 Feb 2021 21:12:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <3795c23197b4f171b143821c033fa1687d3163e7.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [170.133.224.154]
X-ClientProxiedBy: YQBPR0101CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::7) To QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:33::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.136] (170.133.224.154) by YQBPR0101CA0134.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36 via Frontend Transport; Sat, 13 Feb 2021 02:12:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda635ac-750d-4545-d396-08d8cfc4dc93
X-MS-TrafficTypeDiagnostic: YQXPR01MB2837:
X-Microsoft-Antispam-PRVS: <YQXPR01MB2837DDAE8C2177B934DCF015D48A9@YQXPR01MB2837.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shnXSZLnb/Q71QfAfpBuhpJ1193RLGt8TBbG8s43S1iEpCld1PZrot/JWSdy0RmCxtug8Puno5qg0DUkfK9JL7zv6ojDheR9iwWz8wOk+WJTYpItUyd1s4aBoUDMe/sytkEMQovoGUjApvxDVx8Avig+ZefcVUJPaqbHJNqLcqxFEjnyvGC6rYTZnS4w28mDtdWfmzlE/hvlxafMhkKnenpbs86TgtnUBtELbTLmhW/8hwPkJa4p+yW54RozXFTkaoXqymiNXKE+wLl9VDZ+y7IQTSy4uLktJhG/F0Ry7YJuQ3nLg/ZeDz8swkDeG13y2wQ03pgmU2gYsxEdT+QUd6ucI8jiGeqdxYdwd/OyHnt46ks+eFC+8UhpUQxe53cB2r1bo1MYa/A+aViLl0zoMuIRjZcu29m+zm199cd1E1uaj4r1A/XQa6w6bru20O6d7r+KkWVcMwrH60PvhgiBVnIHoH8bEosAiL135r5lSW2mNxTtZx0fh+j2VDz7uYBQ5XjhCt8Z2HHDOV85fRW2e+pVUJ8NzcVN+5QiH7fnVy+5KYKoKLrci+CkKExLpFi2pL2mIrkWr7PuTRoO3f6JtlA9+japjvcFilpG+sRVIJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(316002)(2616005)(6486002)(786003)(66946007)(16576012)(83380400001)(52116002)(31696002)(478600001)(956004)(86362001)(8936002)(8676002)(36756003)(26005)(16526019)(53546011)(66556008)(2906002)(186003)(66476007)(110136005)(30864003)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RmVheXlRRXBhcFdiYlFhRi9rY0p3djhqN3RQclNNdUYrVEhUZmdLRG1OUlJk?=
 =?utf-8?B?dHFmMGRrdlBKZHFJQjA4c0ZkT3hEc1ExQVpQUmR3NE5DSmZQM1VsdlBYRHFm?=
 =?utf-8?B?b2RReU1WRmx4ekVQVzFRZ2hOQVZWQjlqUUV1T2tPNHljV0h6VzFETDlESzdY?=
 =?utf-8?B?b2hnR1lYNjVwWStyWDFDR1NwZmd4STlBbmNuSnU0WTRLQTRveEhuYlJHNldP?=
 =?utf-8?B?QUZVTU44ZXB4UHNKMUoxNUJsVGRZN09UYkVGd3ZxK0laZU9DcGhoVWNtM1g5?=
 =?utf-8?B?MjFDT2ttaXFaRUZMT1ZWZU40TnVNZnhudE1rRU5qc0VZU0VXYktkVFlvNWx3?=
 =?utf-8?B?L21jZ0lJRmFJQUJ1azRJdXo0TExHMlNoejRNakU3RVJrV1lFSmNZRVhxY0Nr?=
 =?utf-8?B?MXZZaFN0QlZycHZHdXlYYWxJaVVKUTRvNFpBVW4wNWg2N3ZRcEo1ZVZPbFhW?=
 =?utf-8?B?RzZ0MXpKZWNjYkdHR3dLc3E1MTdWQ2xQREhrTUc2VjFvUkQrYnRCZ3FnMlVi?=
 =?utf-8?B?b2tsRWk5Rk9ubU5XcHh6Tm4vZlJHMDcrMndTT0piMG5HamVuY3QvajBrRStr?=
 =?utf-8?B?WCs3QUl4ODR0KzRuaWN5MmlvSlFFc1UzNytjdkNHbUZXQnY5QUd4TW5yOEFj?=
 =?utf-8?B?R1RMRy9SNSt3WmdmTTMzMHpSaWcyVy9KMUhZdUh0TjdzZ2hQT2Vsa05iR081?=
 =?utf-8?B?dW9zUXVyMldxNFdRb1NFc2FQUG03dUJVWWdhRUV0UVZiNXNYdVFUOEJod0s0?=
 =?utf-8?B?KzBQcWlIRmMwQS9WRTNrS3RWalBrb29EdzJGaWdCUkxzeFArbktIMmtuSWhD?=
 =?utf-8?B?bC96ODg1dFFKejhrVXRuT0JNRFNGVDdSUXNXdG1QeHpjZE93UmdqRkpVT1F3?=
 =?utf-8?B?ZWNlSnpDYTRQc0crdWJxUG94NCtIZkRrcDQweG9OYUVBRlhjS09qNCtJMUF0?=
 =?utf-8?B?amlsY0UxVnhOYVMxWFIxQXVjb1I1N1ErR1ozOFZmNWFZb0JEVU5UUTM5Tkls?=
 =?utf-8?B?NUVDMXhSdFNEYVU2ZFo3NzVlelRHcHN3N1BzVE9ROHpvV0tMM0pPVUtGQmRM?=
 =?utf-8?B?Z0VkZ1hQU2xwanJTQ2NheFFrL0RIZGRRajAvbzQ3NGNIKzVza0RvVE81M2dH?=
 =?utf-8?B?U1hjMGVDMW9JazRZS1VCT3FXNzI2YXhjUFQzdndxVFUycStvcDRiSUd5aEhE?=
 =?utf-8?B?elJVSHZTTzVxbDBnU2xDWWdCb3BWT2dmZGpXTzRMNXZtakVGM29ORzRqT2NL?=
 =?utf-8?B?ZGoyVkxHQ0FhdWZXSXcvcTdsWHBpbVpoYXNHYmQybCtuOXVrVS8rTjJldVJZ?=
 =?utf-8?B?WGdHMThyMnJHMEtyeVV5ZFZucjkzRHJtdXJFOHBjZTEvR1d5TitOdndxWmMv?=
 =?utf-8?B?bEhUT0toRllia2RSY0gvTkNHNG56cDV0bWxobTJGcURVMzdpTXRpUHZlb1Bp?=
 =?utf-8?B?bldZRDgwSHN2ZW5aazloMERQTjVLd0NwMGZUNlpBbFhnMFd1a0lVa24rcEVM?=
 =?utf-8?B?VXdLdHlDZFloY2sxeXpxQllXUGdLOCt2ZU9SL0F5b2UzV0d3OHNqOC9weEV6?=
 =?utf-8?B?T2U0czVoSVBHU2dma2t3ZFZMeWJPbGd5ZS93R3hmT25PRUZRMUwveTdBYWlv?=
 =?utf-8?B?RWlzNHU4S1JvbjZ3STltbWJ0Vm5meUNYTFZ1ODdDRWY2VWxhRTZ2T0lQWDZG?=
 =?utf-8?B?cVVsVkg4WUZnZzVIOTRYeEFMdzJCVjJNek5idFJjMUkrRzVYNmFUajNuKzNl?=
 =?utf-8?Q?s0/lVfgHzwsqqkR7LbXdtVqZZQYhFW04wBX5l0u?=
X-OriginatorOrg: yorku.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: bda635ac-750d-4545-d396-08d8cfc4dc93
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB3267.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 02:12:49.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 34531318-7011-4fd4-87f0-a43816c49bd0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+YONJY/+8d9XxQKbdYtqGZF1c3R/d0a/ke8B+U6RJFXQbYZO6TC34y11QaATtKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2837
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/12/2021 7:56 PM, Trond Myklebust wrote:
> On Fri, 2021-02-12 at 19:13 -0500, Jason Keltz wrote:
>> Hi.
>>
>> I'm having a very frustrrating NFS related problem that I am hoping
>> someone might be able to shed some light on.
>>
>> I have several file servers, and clients all running CentOS 7.8
>> (kernel
>> 3.10.0-1127.18.2.el7).  They are joined to an Active Directory domain
>> controller (Samba).
>>
>> uid, gid, homedir information is in the directory. All the clients
>> are
>> running Winbind.
>>
>> I can freely ssh between all the CentOS machines, and my home
>> directory
>> is auto-mounted from the NFS server using NFSv4.1 and krb5.  It's
>> pretty
>> nice!
>>
>> If I add myself to a new AD group (group name is cmosp18 gid is
>> 100006)
>> , and I wait 5 minutes (the winbind cache timeout), then I can log
>> out
>> of a system and back in, and I will be in the new group (that is
>> "groups" command shows that I'm in the group).
>>
>> I can cd into /tmp, create a file, and chgrp it to the new group and
>> it
>> works exactly as I would expect.  However, if I try to go into my
>> home
>> directory, create a file there, and chgrp it to the new group, the
>> NFSv4
>> server returns EPERM for the chgrp.  From the strace of chgrp:
>>
>> fchownat(AT_FDCWD, "l", -1, 100006, 0)  = -1 EPERM (Operation not
>> permitted)
>>
>> If I try the same operation from the same client to the same server
>> but
>> using NFSv3 (also krb5), it works successfully.
>>
>> I'd think this means that there is an NFS4 id mapping issue, but I
>> don't
>> see what that is.  The client seems to be able to map my user and
>> group
>> correctly. "groups" command on both the client and server shows I'm
>> in
>> the group.  The server seems to map my user and group correctly.
>>
>> If I login to the file server as me, and create the file in my home
>> directory, make it owned by the new group, then I login to the
>> client, I
>> can see the file (owner and group shows up perfectly fine) (even
>> though
>> I can't create it on the client).
>>
>> In addition, if I login to a client that I haven't logged into, then
>> I
>> can change the group of the file in my home directory to the new
>> group
>> as well.
>>
>> Here's a tcpdump between my host and the nfs server when the chgrp is
>> rejected:
>>
>>   > 15:43:50.950575 IP (tos 0x0, ttl 64, id 34491, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc54d (incorrect -> 0xd37d), seq 912:1112, ack 729, win 8934,
>> options
>> [nop,nop,TS val 5954964 ecr 510044867], length 200: NFS request xid
>> 2301246825 196 getattr fh 0,1/53
>>   > 15:43:50.951333 IP (tos 0x0, ttl 63, id 17178, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0x4785 (correct), seq 729:929, ack 1112, win 1769, options
>> [nop,nop,TS
>> val 510052992 ecr 5954964], length 200: NFS reply xid 2301246825
>> reply
>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>   > 15:43:50.951379 IP (tos 0x0, ttl 64, id 34492, offset 0, flags
>> [DF],
>> proto TCP (6), length 52)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum
>> 0xc485 (incorrect -> 0x733d), seq 1112, ack 929, win 8934, options
>> [nop,nop,TS val 5954965 ecr 510052992], length 0
>>   > 15:43:50.952260 IP (tos 0x0, ttl 64, id 34493, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc54d (incorrect -> 0x8815), seq 1112:1312, ack 929, win 8934,
>> options
>> [nop,nop,TS val 5954966 ecr 510052992], length 200: NFS request xid
>> 2318024041 196 getattr fh 0,1/53
>>   > 15:43:50.953121 IP (tos 0x0, ttl 63, id 17179, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0xd848 (correct), seq 929:1129, ack 1312, win 1769, options
>> [nop,nop,TS
>> val 510052994 ecr 5954966], length 200: NFS reply xid 2318024041
>> reply
>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>   > 15:43:50.958636 IP (tos 0x0, ttl 64, id 34494, offset 0, flags
>> [DF],
>> proto TCP (6), length 264)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc559 (incorrect -> 0x85f1), seq 1312:1524, ack 1129, win 8934,
>> options
>> [nop,nop,TS val 5954972 ecr 510052994], length 212: NFS request xid
>> 2334801257 208 getattr fh 0,1/53
>>   > 15:43:50.959401 IP (tos 0x0, ttl 63, id 17180, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0x8a16 (correct), seq 1129:1329, ack 1524, win 1769, options
>> [nop,nop,TS
>> val 510053000 ecr 5954972], length 200: NFS reply xid 2334801257
>> reply
>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>   > 15:43:50.959794 IP (tos 0x0, ttl 64, id 34495, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc54d (incorrect -> 0xaea5), seq 1524:1724, ack 1329, win 8934,
>> options
>> [nop,nop,TS val 5954973 ecr 510053000], length 200: NFS request xid
>> 2351578473 196 getattr fh 0,1/53
>>   > 15:43:50.960530 IP (tos 0x0, ttl 63, id 17181, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0xc23a (correct), seq 1329:1529, ack 1724, win 1769, options
>> [nop,nop,TS
>> val 510053001 ecr 5954973], length 200: NFS reply xid 2351578473
>> reply
>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>   > 15:43:50.960878 IP (tos 0x0, ttl 64, id 34496, offset 0, flags
>> [DF],
>> proto TCP (6), length 264)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc559 (incorrect -> 0x04e5), seq 1724:1936, ack 1529, win 8934,
>> options
>> [nop,nop,TS val 5954974 ecr 510053001], length 212: NFS request xid
>> 2368355689 208 getattr fh 0,1/53
>>   > 15:43:50.961618 IP (tos 0x0, ttl 63, id 17182, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0xcc54 (correct), seq 1529:1729, ack 1936, win 1769, options
>> [nop,nop,TS
>> val 510053002 ecr 5954974], length 200: NFS reply xid 2368355689
>> reply
>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>   > 15:43:50.961933 IP (tos 0x0, ttl 64, id 34497, offset 0, flags
>> [DF],
>> proto TCP (6), length 256)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc551 (incorrect -> 0x0e22), seq 1936:2140, ack 1729, win 8934,
>> options
>> [nop,nop,TS val 5954975 ecr 510053002], length 204: NFS request xid
>> 2385132905 200 getattr fh 0,1/53
>>   > 15:43:50.962656 IP (tos 0x0, ttl 63, id 17183, offset 0, flags
>> [DF],
>> proto TCP (6), length 356)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0xb114 (correct), seq 1729:2033, ack 2140, win 1769, options
>> [nop,nop,TS
>> val 510053003 ecr 5954975], length 304: NFS reply xid 2385132905
>> reply
>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>   > 15:43:50.963142 IP (tos 0x0, ttl 64, id 34498, offset 0, flags
>> [DF],
>> proto TCP (6), length 264)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc559 (incorrect -> 0x80f7), seq 2140:2352, ack 2033, win 8934,
>> options
>> [nop,nop,TS val 5954977 ecr 510053003], length 212: NFS request xid
>> 2401910121 208 getattr fh 0,1/53
>>   > 15:43:50.964055 IP (tos 0x0, ttl 63, id 17184, offset 0, flags
>> [DF],
>> proto TCP (6), length 252)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0x2d91 (correct), seq 2033:2233, ack 2352, win 1769, options
>> [nop,nop,TS
>> val 510053005 ecr 5954977], length 200: NFS reply xid 2401910121
>> reply
>> ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
>>   > 15:43:51.003985 IP (tos 0x0, ttl 64, id 34499, offset 0, flags
>> [DF],
>> proto TCP (6), length 52)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum
>> 0xc485 (incorrect -> 0x690b), seq 2352, ack 2233, win 8934, options
>> [nop,nop,TS val 5955018 ecr 510053005], length 0
>>   > 15:43:51.027598 IP (tos 0x0, ttl 64, id 34500, offset 0, flags
>> [DF],
>> proto TCP (6), length 272)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc561 (incorrect -> 0x83a6), seq 2352:2572, ack 2233, win 8934,
>> options
>> [nop,nop,TS val 5955041 ecr 510053005], length 220: NFS request xid
>> 2418687337 216 getattr fh 0,1/53
>>   > 15:43:51.027992 IP (tos 0x0, ttl 63, id 17185, offset 0, flags
>> [DF],
>> proto TCP (6), length 412)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0x9b87 (correct), seq 2233:2593, ack 2572, win 1769, options
>> [nop,nop,TS
>> val 510053069 ecr 5955041], length 360: NFS reply xid 2418687337
>> reply
>> ok 356 getattr NON 5 ids 0/-1374905249 sz 9481761
>>   > 15:43:51.028003 IP (tos 0x0, ttl 64, id 34501, offset 0, flags
>> [DF],
>> proto TCP (6), length 52)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum
>> 0xc485 (incorrect -> 0x666f), seq 2572, ack 2593, win 8934, options
>> [nop,nop,TS val 5955042 ecr 510053069], length 0
>>   > 15:43:51.028359 IP (tos 0x0, ttl 64, id 34502, offset 0, flags
>> [DF],
>> proto TCP (6), length 320)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc591 (incorrect -> 0x688b), seq 2572:2840, ack 2593, win 8934,
>> options
>> [nop,nop,TS val 5955042 ecr 510053069], length 268: NFS request xid
>> 2435464553 264 getattr fh 0,1/53
>>   > 15:43:51.028741 IP (tos 0x0, ttl 63, id 17186, offset 0, flags
>> [DF],
>> proto TCP (6), length 196)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0x7ac5 (correct), seq 2593:2737, ack 2840, win 1769, options
>> [nop,nop,TS
>> val 510053070 ecr 5955042], length 144: NFS reply xid 2435464553
>> reply
>> ok 140 getattr ERROR: Operation not permitted
>>   > 15:43:51.204032 IP (tos 0x0, ttl 64, id 34503, offset 0, flags
>> [DF],
>> proto TCP (6), length 52)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum
>> 0xc485 (incorrect -> 0x6422), seq 2840, ack 2737, win 8934, options
>> [nop,nop,TS val 5955218 ecr 510053070], length 0
>>   > 15:44:08.039984 IP (tos 0x0, ttl 64, id 34504, offset 0, flags
>> [DF],
>> proto TCP (6), length 256)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc551 (incorrect -> 0x8c10), seq 2840:3044, ack 2737, win 8934,
>> options
>> [nop,nop,TS val 5972054 ecr 510053070], length 204: NFS request xid
>> 2452241769 200 getattr fh 0,1/53
>>   > 15:44:08.040888 IP (tos 0x0, ttl 63, id 17187, offset 0, flags
>> [DF],
>> proto TCP (6), length 356)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0xea43 (correct), seq 2737:3041, ack 3044, win 1769, options
>> [nop,nop,TS
>> val 510070082 ecr 5972054], length 304: NFS reply xid 2452241769
>> reply
>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>   > 15:44:08.040945 IP (tos 0x0, ttl 64, id 34505, offset 0, flags
>> [DF],
>> proto TCP (6), length 52)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum
>> 0xc485 (incorrect -> 0xdded), seq 3044, ack 3041, win 8934, options
>> [nop,nop,TS val 5972054 ecr 510070082], length 0
>>   > 15:44:11.053805 IP (tos 0x0, ttl 64, id 34506, offset 0, flags
>> [DF],
>> proto TCP (6), length 256)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.],
>> cksum
>> 0xc551 (incorrect -> 0x883a), seq 3044:3248, ack 3041, win 8934,
>> options
>> [nop,nop,TS val 5975067 ecr 510070082], length 204: NFS request xid
>> 2469018985 200 getattr fh 0,1/53
>>   > 15:44:11.054532 IP (tos 0x0, ttl 63, id 17188, offset 0, flags
>> [DF],
>> proto TCP (6), length 356)
>>   >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.],
>> cksum
>> 0xebd7 (correct), seq 3041:3345, ack 3248, win 1769, options
>> [nop,nop,TS
>> val 510073095 ecr 5975067], length 304: NFS reply xid 2469018985
>> reply
>> ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
>>   > 15:44:11.054594 IP (tos 0x0, ttl 64, id 34507, offset 0, flags
>> [DF],
>> proto TCP (6), length 52)
>>   >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum
>> 0xc485 (incorrect -> 0xc466), seq 3248, ack 3345, win 8934, options
>> [nop,nop,TS val 5975068 ecr 510073095], length 0
>>
>> At 15:43:51.028741 it appears that it's the server saying no.  But
>> how
>> can I debug why it is denying access?
>>
>> I restart nfs-idmap on the NFS  server, and run nfsidmap -c on the
>> client.  Here's the rpc.idmapd log during the chgrp -- the server
>> knows
>> me, my uid, my gid, the group I'm trying to change a file to
>> (cmosp18),
>> and its GID:
>>
>>   > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: using domain:
>> eecs.yorku.ca
>>   > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: Realms list:
>> 'EECS.YORKU.CA'
>>   > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: loaded plugin
>> /lib64/libnfsidmap/nsswitch.so for method nsswitch
>>   > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap: using
>> domain: eecs.yorku.ca
>>   > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap: Realms
>> list:
>> 'EECS.YORKU.CA'
>>   > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Expiration time is 600
>> seconds.
>>   > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap: loaded
>> plugin /lib64/libnfsidmap/nsswitch.so for method nsswitch
>>   > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened
>> /proc/net/rpc/nfs4.nametoid/channel
>>   > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened
>> /proc/net/rpc/nfs4.idtoname/channel
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5
>> authtype=user
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: calling
>> nsswitch->uid_to_name
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>> nsswitch->uid_to_name returned 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: final
>> return
>> value is 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id "1004" -
>> name "jas@eecs.yorku.ca"
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5
>> authtype=group
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: calling
>> nsswitch->gid_to_name
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>> nsswitch->gid_to_name returned 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: final
>> return
>> value is 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id "1000"
>> ->
>> name "tech@eecs.yorku.ca"
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5
>> authtype=user
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: calling
>> nsswitch->uid_to_name
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name:
>> nsswitch->uid_to_name returned 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: final
>> return
>> value is 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id "0" ->
>> name
>> "root@eecs.yorku.ca"
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5
>> authtype=group
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: calling
>> nsswitch->gid_to_name
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name:
>> nsswitch->gid_to_name returned 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: final
>> return
>> value is 0
>>   > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id "0" ->
>> name "root@eecs.yorku.ca"
>>   > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5
>> authtype=group
>>   > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid: calling
>> nsswitch->name_to_gid
>>   > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid: name
>> 'cmosp18@eecs.yorku.ca' domain 'eecs.yorku.ca': resulting localname
>> 'cmosp18'
>>   > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid: name
>> 'cmosp18@eecs.yorku.ca' gid 100006
>>   > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid:
>> nsswitch->name_to_gid returned 0
>>   > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid: final
>> return
>> value is 0
>>   > Feb 12 15:51:11 nfs rpc.idmapd[13384]: Server : (group) name
>> "cmosp18@eecs.yorku.ca" -> id "100006"
>>
>> The client knows all the same information as well.  I've had the
>> client
>> sitting for hours already, and I still can't chgrp the file.  On the
>> other hand, I rebooted the client, and then, right after login, I can
>> chgrp the file.
>>
>> How can I debug this further?
>>
>> I was supposed to be moving 300+ systems to the domain this coming
>> week,
>> but I may have to abort that move if I can't solve this problem.
>>
>> Thanks very much for any assistance....
>>
> Have you enabled the '-g' option in rpc.mountd on your server (man 8
> rpc.mountd)? Chances are that you are hitting the 16 group limit in
> AUTH_SYS, so you probably want to ensure that the server is mapping
> your user to the correct set of groups.

Hi Trond,

All of the mounts are Kerberos mounts so shouldn't be affected by the 16 
group limit, right?

Jason.


