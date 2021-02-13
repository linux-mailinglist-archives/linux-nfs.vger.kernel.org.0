Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85031A8A5
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 01:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBMAOA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 19:14:00 -0500
Received: from mail-eopbgr670092.outbound.protection.outlook.com ([40.107.67.92]:64271
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229602AbhBMAOA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 19:14:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9YESbUIHDa1/gT1UxkP91vuRPKveEi3RIHzOLhlwMcmqOA96rIwEW6p/LNk6yarFlJdfxNI/a2zjvdgWIOmENUdUZ5TxiQ8J7/3KPOfhIqUjpTNMaME1zyZpJu6H8l+w1HhWQvq1pDdKqhTGKlvHj7P3C6pHujZ3SaRI9PeVaNsKT2qbKJv+tqndQbVUbadsyWnJg3YPc+02XJDEjiwGetYrjie70Duah22YU+iPEplK2koAOlWDMK0+oU7HI1qAfPGMkgGkCqXxmNNFGtN9A9jy/rWqEdqL29kTqI6pMubs7sWqLG6Gd2xwC1sfzjvFbrCKYWgvhOedRB28/4tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ3mu4HeNlifBmj1WUWGUDpC/7WWrd0HoQ9sk0/esTc=;
 b=JkNsH8kaMg8CeupY9Bimw225LbaJo3fCdESsnaN4Z+nZHVurqlraWa9+gYnTsK9JwVxc7onczNPly33ji1JwuaksMYtCVvjHBQQJ3DDErUBboBDkz3xJWWNp/HWAKar5SrMQG7LveqVN4Dagu5Q6TynFJ8tH2BWzDOhYGbBZlwEOsvSl+wtRRr0knmFE96Ed05cj05C2oobKBF89PTl9AegeY2rQaenE9UfvdB2cZMVSiztW+x5xpwxff9VnFBnBgfVs8EtBMqN6w6CpD0eVKsdJp63db1RWehj2Yo4nVM1DRJnd7JqGSmn2W3id8gs3xaaojvKl4WBhOktWgJe/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yorku.ca; dmarc=pass action=none header.from=yorku.ca;
 dkim=pass header.d=yorku.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yuoffice.onmicrosoft.com; s=selector2-yuoffice-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ3mu4HeNlifBmj1WUWGUDpC/7WWrd0HoQ9sk0/esTc=;
 b=GSmZWzKnvh8hOEyw1Qv/xNRmthA9+BwlOdaXOIWvyc/hckyoRKo7a4VwP/uwXYqACe+8EFHiGPjzh5SzB5fL7s1A46LYoBfWs+tWc2PTMWmGuOyqnVZsGhMHf0GZZvDeRmjTLRsXOQCmSP2gj/8e/sktg3VQmsfqRPiASKE80Fs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=yorku.ca;
Received: from YTBPR01MB3278.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:25::20)
 by YT2PR01MB4287.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Sat, 13 Feb
 2021 00:13:16 +0000
Received: from YTBPR01MB3278.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a95e:69b4:3bc4:cd9b]) by YTBPR01MB3278.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a95e:69b4:3bc4:cd9b%6]) with mapi id 15.20.3825.030; Sat, 13 Feb 2021
 00:13:16 +0000
To:     linux-nfs@vger.kernel.org
From:   Jason Keltz <jas@yorku.ca>
Subject: NFS server issue after new AD group added to AD user
Message-ID: <ad4ee9a5-9285-b29e-8876-f3c7bb1bdbae@yorku.ca>
Date:   Fri, 12 Feb 2021 19:13:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [170.133.224.154]
X-ClientProxiedBy: YQBPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::16) To YTBPR01MB3278.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:25::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.136] (170.133.224.154) by YQBPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.35 via Frontend Transport; Sat, 13 Feb 2021 00:13:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30fcce5e-8069-45f2-9b85-08d8cfb42935
X-MS-TrafficTypeDiagnostic: YT2PR01MB4287:
X-Microsoft-Antispam-PRVS: <YT2PR01MB4287E6BEE5ED6103FE34B35CD48A9@YT2PR01MB4287.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkuF7XIwVDi2V+F2KVIEFpIjTUsErh5gb2PG0uUgvYdOHBRKjBalwfjuARyx2HMuculo6S4fF7vEXApfvsBJKz59z41VrXb8PaY9vZIwVgmcY88J2RdaN0wvpCdzc/ExEHxLNZai4rz3G4s0r04O5oLswi3f1ICvhLiTcvYgz9B7TCXpeq+bw1GTZpT7fWMptKUfUGiKyeY4O32QEhEK4Go78q8c1wQjOaKhbMO04b20k3TeOyFIqfLTjEq59WXHcJ+503YztYApyYZ1pxA9/9sDAfeWVXMAoEil7vT72AO85NDrzZkw61gxOm1Y1NvlMZCFxVmjGfD1eF9EjdjPBMoHTDNjcKFa4CAsq4xDNxA7CAMQUJyNYGpceRbpcwvq9UBFTEXOQaXuG8gtsLlBjYWtKiE7Qbm70gxTsbNnwER4pOJ+Vg+uQZuooFsoclhOsniAy4Xp+UosUBPpwOgAz2Q0VGwlbhkGdOiUCXOzegsIKRMGvgJloD4K0300Q++02cv8XlwFNTgP723ZaZyCVu5dyMb7qju7EOwx+zSVM4yoYvpey//6kbkBySBYdNnG5K7XZEzUrSpfZ7VJaPAyQz6Dto3jpbjlv0L1JvImpRgF0be1iIauB6I23drbqx28
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3278.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(8936002)(8676002)(2906002)(66476007)(26005)(6486002)(36756003)(83380400001)(66946007)(16526019)(52116002)(6916009)(186003)(86362001)(316002)(16576012)(66556008)(5660300002)(31686004)(30864003)(478600001)(31696002)(956004)(786003)(2616005)(43740500002)(45980500001)(554374003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZlVLNVIwUDQwNUZOQ21YaHl4Z2hMWU1ZTkJkT042eVB1WitzcW9pakZKUDhK?=
 =?utf-8?B?ZWdQVHpIR09HbTZnUTVWQVNLeU9LdlBlTG5UYVV1enZsbXRCclBzbksra1VO?=
 =?utf-8?B?TE5yNmtlZUJzZUlPcEdleHhybmdjZEFkUWhnY3BIdzBoQXpIaFd3SitRbUR2?=
 =?utf-8?B?dkFPZ2xUZkhnQjdEemFsQ0RhS1oxYm1xR0VxMEJsVStDNXZVd3lyeXhhUW5r?=
 =?utf-8?B?d1psVWp6WVNrRm5OREdMZlBMTnFPb0xpYUdtWEhucGVsN0plRHBiL1J0RHRl?=
 =?utf-8?B?WFZMcjN3anlGOUJkUWRNYndUekhINHlLL2FqNG1FYWJNd2NtNHpQU3hsa0V2?=
 =?utf-8?B?Y1lWYVZZM043NUM2UTlPb0RhN2xWZm1VU1ROaThWcGJGUlkrakx0SzBRWVpJ?=
 =?utf-8?B?SC9LOCtQTk40alNQSEF4L3hKaEdvc3dUYXUxQUpTNUxxZS9ZRjU5Q3IwcDIx?=
 =?utf-8?B?T3NZQk56UXd4c0lVQlNFS05GR1h5djRIVkpUWVlpMGVCQ2tPa0xORGZRRmFj?=
 =?utf-8?B?eTNJMjJLMjRKMHQyM3pUNm53TmljNnNXS2pPOUVjTDNqd0dvc2xwcWlrV2ZN?=
 =?utf-8?B?S2p4dkxtTGU1cFBiR3oydVNtUVFuZlRPelFiMnhXeGx0Q1RZdHh2dXZpMzBt?=
 =?utf-8?B?cDJGZUZwK3BFYldCOEwzcktiMFAvK0gzanRIdnBmZ2VtMjU2TG9DVnd2NWNa?=
 =?utf-8?B?MG9QSzJQUmZPN1dKRkcvUXdqNVVHdTJUTW1FWWwrM3RKcllRa3hKamdCNlVG?=
 =?utf-8?B?dTJQNVVJY0thd1BURk5Pd2FPRjFaUXV1dXo5YUxXUGxGbnA5UzhnWlpwMXFN?=
 =?utf-8?B?Lzd4Y0tOTXVlSnE3RjFuRFhZZFplcHF3dVNWVGRBVk1hLzliOWJxdlc2bWRM?=
 =?utf-8?B?elR2eGs2MGdzN1d5cWFvTVROdkNTTlhIM01aSVNySWFFSHIrdk8xZzVTM1ZR?=
 =?utf-8?B?a29XelZEdWJ3YVVlYkRHeitkTzR4SDNqRHNYc25pQnQzT1R4UGEvWEIvMkpK?=
 =?utf-8?B?Z3I5NEdNTVpJcmxadVJ3d01QdHRoVGhGcHo3eklZclJtOE02cjhwWUp1MUFF?=
 =?utf-8?B?RzBvd2ZTblJCR1NPYWhJWUJ0VnJyT09Rc0Z2a3RWR3pBQlZtS2N3VTROdDRk?=
 =?utf-8?B?OFg1aTRoSGtPQ1kxYVdmeG9UcitaQ2Fmcmk2dTBkbCtBWDJ1bGlTby9nQk8x?=
 =?utf-8?B?ZDRPSWxPNCtlVTFyY0oxTkhod2FLelZBL0NXY2dZeFpzY0h2dXVrcTJWK3Ur?=
 =?utf-8?B?WncyR1FEakFwV1JmQW80TjA0TkNYSzh0QVlDc0NMSG12dEM0dXFSaUJubHpp?=
 =?utf-8?B?RGpVYlVadStXbFZFanZ6ZkRwd1UxMjVnNmIwZ2xyb3hHS0x5N3AyTloxaU1G?=
 =?utf-8?B?eFN4MllwMTRqSzJISEFTbVRVb1JYSFM0Q1Rxdm9SbUxLamRmNVdNUzgvbEJV?=
 =?utf-8?B?SUZqSU5sWG4rQ0RHZDQxTWE1bUpsbEU3SDgzQmFGQ1FXWDVHR3VZMHFQTWty?=
 =?utf-8?B?ZzhmY01uVGl1YVdMWkxDa0RRcVRKK2dLaUZVeUFoVGhnb0kzZnd3dENlL3Z6?=
 =?utf-8?B?NUQ0V0ljdzM3eitKQk9sRkdtTEdFemlwaVVjYlArd3hrVXV0Wkh5QkJVT2Rz?=
 =?utf-8?B?KzRTRXh0QUs1THRtMG5jQit5eHNwMll5Q2ROT0lBR1lMOG5TN2N0WnU5b0VK?=
 =?utf-8?B?Skl5WlUyM1JSVkRtMi9nYlFPdUxyTXpUaEQ1UzlWSkdaWUg4RjZMeG8wVmRD?=
 =?utf-8?Q?HhI0ZUEYoeLgHoLtoLKXdl5rqRwhkE/SUPm/P9C?=
X-OriginatorOrg: yorku.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fcce5e-8069-45f2-9b85-08d8cfb42935
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3278.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 00:13:16.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 34531318-7011-4fd4-87f0-a43816c49bd0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATwdR+RFMFVXLGDsCECGt04SjWjIhIHgjzrjUF9kySk2xnxG+j7z98XV3P44nh6i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB4287
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi.

I'm having a very frustrrating NFS related problem that I am hoping 
someone might be able to shed some light on.

I have several file servers, and clients all running CentOS 7.8 (kernel 
3.10.0-1127.18.2.el7).  They are joined to an Active Directory domain 
controller (Samba).

uid, gid, homedir information is in the directory. All the clients are 
running Winbind.

I can freely ssh between all the CentOS machines, and my home directory 
is auto-mounted from the NFS server using NFSv4.1 and krb5.  It's pretty 
nice!

If I add myself to a new AD group (group name is cmosp18 gid is 100006) 
, and I wait 5 minutes (the winbind cache timeout), then I can log out 
of a system and back in, and I will be in the new group (that is 
"groups" command shows that I'm in the group).

I can cd into /tmp, create a file, and chgrp it to the new group and it 
works exactly as I would expect.  However, if I try to go into my home 
directory, create a file there, and chgrp it to the new group, the NFSv4 
server returns EPERM for the chgrp.  From the strace of chgrp:

fchownat(AT_FDCWD, "l", -1, 100006, 0)  = -1 EPERM (Operation not permitted)

If I try the same operation from the same client to the same server but 
using NFSv3 (also krb5), it works successfully.

I'd think this means that there is an NFS4 id mapping issue, but I don't 
see what that is.  The client seems to be able to map my user and group 
correctly. "groups" command on both the client and server shows I'm in 
the group.  The server seems to map my user and group correctly.

If I login to the file server as me, and create the file in my home 
directory, make it owned by the new group, then I login to the client, I 
can see the file (owner and group shows up perfectly fine) (even though 
I can't create it on the client).

In addition, if I login to a client that I haven't logged into, then I 
can change the group of the file in my home directory to the new group 
as well.

Here's a tcpdump between my host and the nfs server when the chgrp is 
rejected:

 > 15:43:50.950575 IP (tos 0x0, ttl 64, id 34491, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc54d (incorrect -> 0xd37d), seq 912:1112, ack 729, win 8934, options 
[nop,nop,TS val 5954964 ecr 510044867], length 200: NFS request xid 
2301246825 196 getattr fh 0,1/53
 > 15:43:50.951333 IP (tos 0x0, ttl 63, id 17178, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0x4785 (correct), seq 729:929, ack 1112, win 1769, options [nop,nop,TS 
val 510052992 ecr 5954964], length 200: NFS reply xid 2301246825 reply 
ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
 > 15:43:50.951379 IP (tos 0x0, ttl 64, id 34492, offset 0, flags [DF], 
proto TCP (6), length 52)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum 
0xc485 (incorrect -> 0x733d), seq 1112, ack 929, win 8934, options 
[nop,nop,TS val 5954965 ecr 510052992], length 0
 > 15:43:50.952260 IP (tos 0x0, ttl 64, id 34493, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc54d (incorrect -> 0x8815), seq 1112:1312, ack 929, win 8934, options 
[nop,nop,TS val 5954966 ecr 510052992], length 200: NFS request xid 
2318024041 196 getattr fh 0,1/53
 > 15:43:50.953121 IP (tos 0x0, ttl 63, id 17179, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0xd848 (correct), seq 929:1129, ack 1312, win 1769, options [nop,nop,TS 
val 510052994 ecr 5954966], length 200: NFS reply xid 2318024041 reply 
ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
 > 15:43:50.958636 IP (tos 0x0, ttl 64, id 34494, offset 0, flags [DF], 
proto TCP (6), length 264)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc559 (incorrect -> 0x85f1), seq 1312:1524, ack 1129, win 8934, options 
[nop,nop,TS val 5954972 ecr 510052994], length 212: NFS request xid 
2334801257 208 getattr fh 0,1/53
 > 15:43:50.959401 IP (tos 0x0, ttl 63, id 17180, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0x8a16 (correct), seq 1129:1329, ack 1524, win 1769, options [nop,nop,TS 
val 510053000 ecr 5954972], length 200: NFS reply xid 2334801257 reply 
ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
 > 15:43:50.959794 IP (tos 0x0, ttl 64, id 34495, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc54d (incorrect -> 0xaea5), seq 1524:1724, ack 1329, win 8934, options 
[nop,nop,TS val 5954973 ecr 510053000], length 200: NFS request xid 
2351578473 196 getattr fh 0,1/53
 > 15:43:50.960530 IP (tos 0x0, ttl 63, id 17181, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0xc23a (correct), seq 1329:1529, ack 1724, win 1769, options [nop,nop,TS 
val 510053001 ecr 5954973], length 200: NFS reply xid 2351578473 reply 
ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
 > 15:43:50.960878 IP (tos 0x0, ttl 64, id 34496, offset 0, flags [DF], 
proto TCP (6), length 264)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc559 (incorrect -> 0x04e5), seq 1724:1936, ack 1529, win 8934, options 
[nop,nop,TS val 5954974 ecr 510053001], length 212: NFS request xid 
2368355689 208 getattr fh 0,1/53
 > 15:43:50.961618 IP (tos 0x0, ttl 63, id 17182, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0xcc54 (correct), seq 1529:1729, ack 1936, win 1769, options [nop,nop,TS 
val 510053002 ecr 5954974], length 200: NFS reply xid 2368355689 reply 
ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
 > 15:43:50.961933 IP (tos 0x0, ttl 64, id 34497, offset 0, flags [DF], 
proto TCP (6), length 256)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc551 (incorrect -> 0x0e22), seq 1936:2140, ack 1729, win 8934, options 
[nop,nop,TS val 5954975 ecr 510053002], length 204: NFS request xid 
2385132905 200 getattr fh 0,1/53
 > 15:43:50.962656 IP (tos 0x0, ttl 63, id 17183, offset 0, flags [DF], 
proto TCP (6), length 356)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0xb114 (correct), seq 1729:2033, ack 2140, win 1769, options [nop,nop,TS 
val 510053003 ecr 5954975], length 304: NFS reply xid 2385132905 reply 
ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
 > 15:43:50.963142 IP (tos 0x0, ttl 64, id 34498, offset 0, flags [DF], 
proto TCP (6), length 264)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc559 (incorrect -> 0x80f7), seq 2140:2352, ack 2033, win 8934, options 
[nop,nop,TS val 5954977 ecr 510053003], length 212: NFS request xid 
2401910121 208 getattr fh 0,1/53
 > 15:43:50.964055 IP (tos 0x0, ttl 63, id 17184, offset 0, flags [DF], 
proto TCP (6), length 252)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0x2d91 (correct), seq 2033:2233, ack 2352, win 1769, options [nop,nop,TS 
val 510053005 ecr 5954977], length 200: NFS reply xid 2401910121 reply 
ok 196 getattr NON 4 ids 0/-1374905249 sz 9481761
 > 15:43:51.003985 IP (tos 0x0, ttl 64, id 34499, offset 0, flags [DF], 
proto TCP (6), length 52)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum 
0xc485 (incorrect -> 0x690b), seq 2352, ack 2233, win 8934, options 
[nop,nop,TS val 5955018 ecr 510053005], length 0
 > 15:43:51.027598 IP (tos 0x0, ttl 64, id 34500, offset 0, flags [DF], 
proto TCP (6), length 272)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc561 (incorrect -> 0x83a6), seq 2352:2572, ack 2233, win 8934, options 
[nop,nop,TS val 5955041 ecr 510053005], length 220: NFS request xid 
2418687337 216 getattr fh 0,1/53
 > 15:43:51.027992 IP (tos 0x0, ttl 63, id 17185, offset 0, flags [DF], 
proto TCP (6), length 412)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0x9b87 (correct), seq 2233:2593, ack 2572, win 1769, options [nop,nop,TS 
val 510053069 ecr 5955041], length 360: NFS reply xid 2418687337 reply 
ok 356 getattr NON 5 ids 0/-1374905249 sz 9481761
 > 15:43:51.028003 IP (tos 0x0, ttl 64, id 34501, offset 0, flags [DF], 
proto TCP (6), length 52)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum 
0xc485 (incorrect -> 0x666f), seq 2572, ack 2593, win 8934, options 
[nop,nop,TS val 5955042 ecr 510053069], length 0
 > 15:43:51.028359 IP (tos 0x0, ttl 64, id 34502, offset 0, flags [DF], 
proto TCP (6), length 320)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc591 (incorrect -> 0x688b), seq 2572:2840, ack 2593, win 8934, options 
[nop,nop,TS val 5955042 ecr 510053069], length 268: NFS request xid 
2435464553 264 getattr fh 0,1/53
 > 15:43:51.028741 IP (tos 0x0, ttl 63, id 17186, offset 0, flags [DF], 
proto TCP (6), length 196)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0x7ac5 (correct), seq 2593:2737, ack 2840, win 1769, options [nop,nop,TS 
val 510053070 ecr 5955042], length 144: NFS reply xid 2435464553 reply 
ok 140 getattr ERROR: Operation not permitted
 > 15:43:51.204032 IP (tos 0x0, ttl 64, id 34503, offset 0, flags [DF], 
proto TCP (6), length 52)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum 
0xc485 (incorrect -> 0x6422), seq 2840, ack 2737, win 8934, options 
[nop,nop,TS val 5955218 ecr 510053070], length 0
 > 15:44:08.039984 IP (tos 0x0, ttl 64, id 34504, offset 0, flags [DF], 
proto TCP (6), length 256)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc551 (incorrect -> 0x8c10), seq 2840:3044, ack 2737, win 8934, options 
[nop,nop,TS val 5972054 ecr 510053070], length 204: NFS request xid 
2452241769 200 getattr fh 0,1/53
 > 15:44:08.040888 IP (tos 0x0, ttl 63, id 17187, offset 0, flags [DF], 
proto TCP (6), length 356)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0xea43 (correct), seq 2737:3041, ack 3044, win 1769, options [nop,nop,TS 
val 510070082 ecr 5972054], length 304: NFS reply xid 2452241769 reply 
ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
 > 15:44:08.040945 IP (tos 0x0, ttl 64, id 34505, offset 0, flags [DF], 
proto TCP (6), length 52)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum 
0xc485 (incorrect -> 0xdded), seq 3044, ack 3041, win 8934, options 
[nop,nop,TS val 5972054 ecr 510070082], length 0
 > 15:44:11.053805 IP (tos 0x0, ttl 64, id 34506, offset 0, flags [DF], 
proto TCP (6), length 256)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [P.], cksum 
0xc551 (incorrect -> 0x883a), seq 3044:3248, ack 3041, win 8934, options 
[nop,nop,TS val 5975067 ecr 510070082], length 204: NFS request xid 
2469018985 200 getattr fh 0,1/53
 > 15:44:11.054532 IP (tos 0x0, ttl 63, id 17188, offset 0, flags [DF], 
proto TCP (6), length 356)
 >     nfs.eecs.yorku.ca.nfs > j1.eecs.yorku.ca.822: Flags [P.], cksum 
0xebd7 (correct), seq 3041:3345, ack 3248, win 1769, options [nop,nop,TS 
val 510073095 ecr 5975067], length 304: NFS reply xid 2469018985 reply 
ok 300 getattr NON 3 ids 0/-1374905249 sz 9481761
 > 15:44:11.054594 IP (tos 0x0, ttl 64, id 34507, offset 0, flags [DF], 
proto TCP (6), length 52)
 >     j1.eecs.yorku.ca.822 > nfs.eecs.yorku.ca.nfs: Flags [.], cksum 
0xc485 (incorrect -> 0xc466), seq 3248, ack 3345, win 8934, options 
[nop,nop,TS val 5975068 ecr 510073095], length 0

At 15:43:51.028741 it appears that it's the server saying no.  But how 
can I debug why it is denying access?

I restart nfs-idmap on the NFS  server, and run nfsidmap -c on the 
client.  Here's the rpc.idmapd log during the chgrp -- the server knows 
me, my uid, my gid, the group I'm trying to change a file to (cmosp18), 
and its GID:

 > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: using domain: 
eecs.yorku.ca
 > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: Realms list: 
'EECS.YORKU.CA'
 > Feb 12 15:51:08 nfs rpc.idmapd[13383]: libnfsidmap: loaded plugin 
/lib64/libnfsidmap/nsswitch.so for method nsswitch
 > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap: using 
domain: eecs.yorku.ca
 > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap: Realms list: 
'EECS.YORKU.CA'
 > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Expiration time is 600 seconds.
 > Feb 12 15:51:08 nfs rpc.idmapd: rpc.idmapd: libnfsidmap: loaded 
plugin /lib64/libnfsidmap/nsswitch.so for method nsswitch
 > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened 
/proc/net/rpc/nfs4.nametoid/channel
 > Feb 12 15:51:08 nfs rpc.idmapd[13384]: Opened 
/proc/net/rpc/nfs4.idtoname/channel
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5 
authtype=user
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: calling 
nsswitch->uid_to_name
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: 
nsswitch->uid_to_name returned 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: final return 
value is 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id "1004" -> 
name "jas@eecs.yorku.ca"
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5 
authtype=group
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: calling 
nsswitch->gid_to_name
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: 
nsswitch->gid_to_name returned 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: final return 
value is 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id "1000" -> 
name "tech@eecs.yorku.ca"
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5 
authtype=user
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: calling 
nsswitch->uid_to_name
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: 
nsswitch->uid_to_name returned 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_uid_to_name: final return 
value is 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (user) id "0" -> name 
"root@eecs.yorku.ca"
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5 
authtype=group
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: calling 
nsswitch->gid_to_name
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: 
nsswitch->gid_to_name returned 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: nfs4_gid_to_name: final return 
value is 0
 > Feb 12 15:51:10 nfs rpc.idmapd[13384]: Server : (group) id "0" -> 
name "root@eecs.yorku.ca"
 > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfsdcb: authbuf=gss/krb5 
authtype=group
 > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid: calling 
nsswitch->name_to_gid
 > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid: name 
'cmosp18@eecs.yorku.ca' domain 'eecs.yorku.ca': resulting localname 
'cmosp18'
 > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nss_name_to_gid: name 
'cmosp18@eecs.yorku.ca' gid 100006
 > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid: 
nsswitch->name_to_gid returned 0
 > Feb 12 15:51:11 nfs rpc.idmapd[13384]: nfs4_name_to_gid: final return 
value is 0
 > Feb 12 15:51:11 nfs rpc.idmapd[13384]: Server : (group) name 
"cmosp18@eecs.yorku.ca" -> id "100006"

The client knows all the same information as well.  I've had the client 
sitting for hours already, and I still can't chgrp the file.  On the 
other hand, I rebooted the client, and then, right after login, I can 
chgrp the file.

How can I debug this further?

I was supposed to be moving 300+ systems to the domain this coming week, 
but I may have to abort that move if I can't solve this problem.

Thanks very much for any assistance....

Jason.

