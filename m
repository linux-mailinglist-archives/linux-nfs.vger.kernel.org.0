Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566963A872D
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFORNI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 13:13:08 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:28549 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhFORNH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 13:13:07 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 13:13:07 EDT
IronPort-SDR: 38DNy/nDuRlomJuzXAc156VYYMc3Qd3/DcSvBC9+TuyHwjOFbT84fvaWn8Wg+4LCVngw7mb34p
 1o+N9dnrJp5ZZMwINTi5UXAu3Z0cl4lBVYsNIfPpbRzlihc/YjG2VOK339kn1p29gTp8O53YD+
 9vJ4aN4odnduXwWxvUQ9ctmssTL0dchc6juEMX2zx/WTveyDHPAmkysbSfl9F2Ii3J7dJv90UV
 k87stnPnMH7aOn6t+4sEwsg/trasyKKkQfVQV2VzlNrKlaYYdigvwlc4HkQhtIjYta12iQeDWU
 CdM=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 279473825
X-IPAS-Result: =?us-ascii?q?A2EJCgCI3Mhgh2U3L2haHgEBCxIMQIFMC4FTUX6BQguEP?=
 =?us-ascii?q?YMCRwEBhTmIUy2aG4FCgREDGDwCCQEBAQEBAQEBAQcCNQoCBAEBAwSESTeCN?=
 =?us-ascii?q?SY3Bg4CBAEBAQEDAgMBAQEBAQQBAQYBAQEBAQEFBAICEAEBAQFshS85AQyDV?=
 =?us-ascii?q?k07AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINUilWE?=
 =?us-ascii?q?RUIAQE4NAIRFQI0Kw0IAQEXAwSCTwGCVQMvAQ6bYgGBEgEWPgIjAUABAQuBC?=
 =?us-ascii?q?IoGgTKBAYIHAQEGBASBNAGEAhhCCQ2BWQMGCQGBBiqCe4Z0hD6BSUSBFScPh?=
 =?us-ascii?q?ygvMSaCWIJkhBoTLIEvFT2RYyeNGVyBI5s+gyYEigyTVAYOBSaUfpBolVSMG?=
 =?us-ascii?q?JJ4hSQCBAIEBQIOAQEGgWqBfzMaCB0TgyRQFwIOjh8MDQkVgzmKfFU4AgYKA?=
 =?us-ascii?q?QEDCXyHTwGBEAEB?=
IronPort-PHdr: A9a23:6uuoExLcFHJLAGSpNtmcuZcyDhhOgF28FhAa54BhiL9UdKmnuZP4M
 x+X6fZsiQrPWoPWo7JBhvHNuq/tEWoH/d6asX8EfZANMn1NicgfkwE6RsLQD0r9Ia30YCEgW
 sdPTllo+ze8K0cGUMr7bkfZ93u16zNaEx7jNA1zc+LyHIO37Yy32um+9oeVbR9PgW+4aK9ya
 giqoBXYrY8bjZYxQps=
IronPort-HdrOrdr: A9a23:PWfLwKEKZZlrgJoRpLqE8ceALOsnbusQ8zAXPi9KJCC9Hvbo9P
 xG4s526facsl94MxsdcOy7Scu9qBjnlKKdj7N+AV+TNjOIhIN/RLsD0bff
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,275,1616475600"; 
   d="scan'208";a="279473825"
X-Utexas-Seen-Outbound: true
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 12:03:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaQKDShhucxlewvR1Of1oFzxRLm7jGO1tgR7nW4APqiprYufgZ7fCCrre05KtZmUuWNGUFC4QloZ3pKI4Wdw+8WixW1w/4QQrMTt0/iPE7MxV/Qg2Aj8XBThK9ubSgjLwYEYpEHAvDDQJ/wrndR4PDyKGcrhHyuDHlBS9fzCuCtAn310O44tTSPzCXe/LRo0KcKiLP5S3XufatQc40iCKadxLTD0UhbY1cFqTN6b9vfVAzGjjeKplhxgzn4uCIUN+TDWGWfNi2IVmbQfzznUg7i1Gcj8YPRmK8aK2+SSG5lSGcKR/INq8MIdKeTvdvHMSjvj1Y9Ra80yNJ3mdFoMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgoUPY1EXwChYiv+4V85DyFBtulf/totD16vjGTO25A=;
 b=hz5+uZWOyo9DQQiCmDsH1G6yCJo6cKQC4QyLiHAnotQmsvhQEk8mp2lb0b7AiHEUprLe5HyXXACPqI/C34RmuP7LUCyAtKkR0yJrFlMfJ3AQGQqT6Kjs+cCJbmFezl8x68sM9J4qIskupMokQksB05o4/eCK8KiXeXlavD3VFEKOw6NHEyr/eEHQJT535a2cpW1MUKU87fa8u8LuUe1r6DLhstNqpqAeGtkx0izvQ47qQXADw3cdYu9e2K4AxUE40KU3BtM86cRkL5Gu+goyoJMVRIFIe/0tcoIZJ8hjs//2tK9Va4cCxMc0+6zzQchwa1CZqp/rdzphoCx9mXQNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgoUPY1EXwChYiv+4V85DyFBtulf/totD16vjGTO25A=;
 b=V2MgeEcc+WzFrUo+2+Czfje6ZbYeScNByAzdic05tk3sNV7X/WgkYNpxh2zl3e5u6GP69TvsImGP1aIf5yh4cGGK/3c/tXfxeasvN2RERTJDzK7wIpsXItwVDjpjBsspYxbhLcyiV9V5bGN8eSwApJYmxpLRwDDJuYAxX6wo7l4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BY5PR06MB6644.namprd06.prod.outlook.com (2603:10b6:a03:239::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 17:03:53 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 17:03:53 +0000
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Subject: Use of /etc/netgroup appears to be broken in the NFS server version
 which ships with Ubuntu 20.04
Message-ID: <2539b705-b72a-d9de-965e-7836dfd2e362@math.utexas.edu>
Date:   Tue, 15 Jun 2021 12:03:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN4PR0401CA0047.namprd04.prod.outlook.com
 (2603:10b6:803:2a::33) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN4PR0401CA0047.namprd04.prod.outlook.com (2603:10b6:803:2a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 17:03:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db0458fc-30a4-4a57-8805-08d9301f8de7
X-MS-TrafficTypeDiagnostic: BY5PR06MB6644:
X-Microsoft-Antispam-PRVS: <BY5PR06MB66440A7F13D100D256C07A0C83309@BY5PR06MB6644.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQVfne6kcRQSDywE1YRPcokvTf8aXnKsA6UXcSlSBe7nQlf4wthDPAda9noClT2k2+5ZZdUwrx9fF5c4d10p5oJKEsdSO/5H8qYn2InKcdFbdz0Rc+xjj5RDG6wUsVuqg8yhZvKRCMjrtAZkpHzhz2iPVEQ2SEWuMi8RNARYvAK4ERcSG5YY6swYCVIhkEr5bCzsrrSYfOYTyp++OYQH/mAN9AeoCEUDCPlEusXKHFen6sWafNJZrjzU7V+SVBuldTZn242Ki43cEjVH45GWdmnl9Zejpne/ZwWjzAdoAUpVMFa+jIC2KUDOQagvX2L95ck+qYrVEBJ2ijOd6H1xcKofMjn1QM+aYDTZUQDTQLZMnGSq1FBIR/gywh7kpDfMdITswk1KuRY8qa3ujGUnFAJ2x5sgBmul2sqozzqjtPEq2R245hZYunkb8KHn2z7f0iKZtyNtSqhOevYYsG161VETwZjDRXhqF8T/KHC/NyOjtaQZmk/2lMD290vhPUdrzJ+q7Rku2+P4I+6XLALwwsHZQBsRaSXMuNuy/4L51nyYx9+7wnNX+XMR3Qw4qZBi1xMFJQtLm0kXC3mMZTUTr8JOA6t+4kAXJnYBjNg6ppa76g6XDWHb92SGgVRSkvpXGvz2g4tIGTXWJoG69ZTbmiFpoWCSqVW0oVEyM5GRtT61XR8HhBziJngKpwpR4Ln6+C/URKH0L7aed1frhxj2IKNKoX1wuIDrwLb4HpyxiX2nfe6CuM8U3g82QMLauBfcAUI2p1F9TT+Qd5gxvuuttarR3wRSYTqVi16qFgvtm5ST97vBSXKwPQZt8B5+nrcqBgJWHLzg++HGVyCJTczjBEZd7sPSodCA33nLN6AmrP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39850400004)(376002)(2906002)(52116002)(66946007)(83380400001)(66556008)(86362001)(966005)(38100700002)(31696002)(5660300002)(31686004)(38350700002)(66476007)(186003)(6916009)(8936002)(478600001)(75432002)(6486002)(8676002)(16576012)(26005)(2616005)(956004)(316002)(786003)(16526019)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkU1MGFKNWNVVFRNUVpOR25NNXBNNEdGN3czNURQZlkycEEvZGk0M3U0ZXNp?=
 =?utf-8?B?cWloc2liT3dCeXAraUQ5dThaZWdDRFMrYTgxVHpKTmlwSFM3SXZkMDlyZWhI?=
 =?utf-8?B?VlhKVlRMQkVSbkFMR21HaHAxUC85V05wM1RBYVNUVXI5bWRHcDVOcDFSdE5m?=
 =?utf-8?B?M1l3MmlPdkNxdWJadEhiMDNka3F0a0o5azM0WFNYNExYa1RUbUZ4QUV2cGs4?=
 =?utf-8?B?WVp2L2ZuMjVqelozbFk0V2RZMWFsWXQxT1ZPVU92SDNXZHlNMUVnUldmaWxr?=
 =?utf-8?B?Nng2WTZGb1JUL0NlRm1uYlZLd2dqWFBVbUlzK1hIMmJwMUd1VndkV3lUckU1?=
 =?utf-8?B?OFFZVFlhRWdHdm8yNFZrNlp6cUR6U1pTNGFzRmR2dThEUm85enROODBMdU1a?=
 =?utf-8?B?ZmRFUHhPUFEvci9DR3pSQlVKZXl1WU5OK1VXN3NlQncrTGV6VTh1eFZjOEZl?=
 =?utf-8?B?azNwYk9tQ3M5WFdmdnVteE5XR2RJMWhQcVJnRnZaYTFXbUg3N0phZngyMHc3?=
 =?utf-8?B?NTg5YlFpbEVoR0pxNWpwSGp2WWI5Y1RrQ3h5Ti9SaHFKQUhoR1JBcXNKbTRK?=
 =?utf-8?B?UnM4dm13U0FIeERwL0EwSE50eThYZnpjcDhQcE9iOXprbXJLZXVlemR4N093?=
 =?utf-8?B?L0xtY0w0Wkw3dHdvZ1VQbjV0Q2pSRFY3UUVpSnhEMTBXb3Vvakpla2sreS9r?=
 =?utf-8?B?RG1vSmV2Qi9VT0EyTy80OHJraFFwMnQvQ0FJQVVTaXE1SEdFUTNTVmdtNnk1?=
 =?utf-8?B?eUlYTFBrdnhVWDF4dllEeC8wUnlzKzdrVUxKbVNIeUdxa0ZObW00eVByd0pz?=
 =?utf-8?B?Z0Y4M1o5ZkZ2SHJJLzM5L3RZdGMreTcyb0NycGNMeWNSSGRtSFRFNDkyTzVm?=
 =?utf-8?B?RU5Dc0RIdkJpeHBjNWlIbkR2SGJ5am1LT3QyQkwrdkxSeDFzNVppaTBmM01T?=
 =?utf-8?B?WEltUC9RZTl2N1VRSU04YlJZUXVSMHMvSnZiODkzTmJOb3pVS3M3SVZqam5x?=
 =?utf-8?B?L3JZK2JmV1FiR3dmQUhTSFY3Q0Fkb1VOSTRTaWZoQkU4SGtGMHpzcEo5QkhO?=
 =?utf-8?B?T2JZc24zQ3lMTEVXNjZYdGU3U0N4ZVJFcGlrWjVjQjZ4NzZSV291WW9SN2tw?=
 =?utf-8?B?MFNack9rME1iR05xcWNPZUxXeEs2VHNFaC8xMzgzQlRtU3FlTDFDTlExZEhZ?=
 =?utf-8?B?UklHZHVxQkFaYW1iY2k3N255akxyNnoxV21xMjd3MkZDekxwaEZuMzkxSjB0?=
 =?utf-8?B?VXFmb3c4dWFmWFc3YVUzT3dtV21WbCs2TWgrNVRRMVpwUGxaWE1QQVlxVS9x?=
 =?utf-8?B?Z2JScVc3dThxckNRTmxCOXo3UFpocE9LUm5VT091Wkd0cVp2Y0RtK1p4N0M5?=
 =?utf-8?B?TjVVMXVZSmxyQUFGZ3p2VzlTWFRtSUVyUThFMEFhV2lPem5aSGY1VDhMWndR?=
 =?utf-8?B?MEdwa1lIQ0VxaXBYYzFUSE1rQVBWeVhnNG52b0MxUWU3a0hPc3JoYWNEV0JQ?=
 =?utf-8?B?QzNNYzk1eTQxUEp4Vkk4TUhFbXZaTGpJckRLK1VMN1NibHR3RmYrZDJwNjhn?=
 =?utf-8?B?ZTFmR0h1N3E5V0xCN3ZMZ2ovcmpEeWZEWlFma05WQ0xpbXVJUkhSc0UweGls?=
 =?utf-8?B?VEpRRkU3elpiU2VCaU5Nd1lDZ1VzdGNzMEcvQmJPRDZiVXN3cE1hV0hEYk0w?=
 =?utf-8?B?cmUxWlFNak5HKzhzbEZ6SXh2eE1ScTEwRGxSajh4MnRXRlRyY2xvV0htM0NI?=
 =?utf-8?Q?/Bb55XtfwKsPzsS/9xXb9aGV0xUVc4jyUUwxO1z?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: db0458fc-30a4-4a57-8805-08d9301f8de7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 17:03:53.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3idDdo7yd7BPKp1vAt+g/79cQV6Bqkuog3z0OKBjmFezoRfEVrb4u1DYCa4pnxs5nBY+pcLZRNyaopBtuDe0Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6644
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sadly, it took me a couple of days to track this down. The /etc/netgroup 
file I'm using works perfectly on another NFS server (Ubuntu 18.04) in 
production, so this wasn't an immediate suspicion.  However, if I use 
this /etc/exports:

   /srv/nfs @cryo_em(rw,sync,fsid=0,crossmnt,no_subtree_check)
   /srv/nfs/cryosparc @cryo_em(rw,sync,fsid=2,crossmnt,no_subtree_check)

Client mounts fail:


root@javelina:~# mount -vvvt nfs4 cerebro:/cryosparc /cryosparc
mount.nfs4: timeout set for Tue Jun 15 11:53:22 2021
mount.nfs4: trying text-based options 
'vers=4.2,addr=128.xx.xx.xxx,clientaddr=129.xxx.xxx.xx'
mount.nfs4: mount(2): Permission denied
mount.nfs4: access denied by server while mounting cerebro:/cryosparc

and if I switch to specifying the host explicitly:

   /srv/nfs javelina.my.domain(rw,sync,fsid=0,crossmnt,no_subtree_check)

   /srv/nfs/cryosparc 
javelina.mydomain(rw,sync,fsid=2,crossmnt,no_subtree_check)

the mount just works.  The tcpdump error message isn't terribly helpful 
here:

11:14:02.856094 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags 
[.], ack 281, win 507, options [nop,nop,TS val 791638255 ecr 
2576087678], length 0
11:14:02.856178 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags 
[P.], seq 1:25, ack 281, win 507, options [nop,nop,TS val 791638255 ecr 
2576087678], length 24: NFS reply xid 2752089303 reply ERR 20: Auth 
Bogus Credentials (seal broken)

but after figuring out the cause of the problem, I did find a 
corroborating RHEL error report (which you'll need a RHEL account to 
access):

   https://access.redhat.com/solutions/3563601

I couldn't figure out how to determine the exact version of the NFS 
server that ships with Ubuntu 20.04.  Maybe someone could explain how to 
do this.  Running
    /usr/sbin/rpc.nfsd --version
doesn't do it.
