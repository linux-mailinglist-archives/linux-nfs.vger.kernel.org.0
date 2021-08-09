Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DDD3E4AA2
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhHIRP5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 13:15:57 -0400
Received: from mail-mw2nam10on2117.outbound.protection.outlook.com ([40.107.94.117]:54812
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233616AbhHIRP5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 13:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTeA+8ARaPvhDeqJqK0y7Ua3xKMRN34sS6XBLMjZRumG+L5xIA+DBGW82xquBkp4O1BygG4a776wjwR5vaMj2OhT4ZaO3utKr1DKeot4iLtZSE6zAQnH0v16Yk+pfJOQBAnrs0xtqRViYHDQmATqiRMRiYE2N0lTDw3AcC3c3YT9G3A8LGjkQDJ+d8Q6fymk9KTMVENeErTOx16D/iYXpovVTpGHRaLNCUhISEQgxtjjlycWKgbk+HbAeQ2k6RW6ib8Up92FFqFEtE5s2A/EEApaiQvJ5rdn1PlSZwP1WdedEgbYG+E1+FZE84JiUuMD6Woiye/FCiuzMwJyWnFWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwFsuz9hKM92F8J4wHR/m/nxb/RsnvCJybjqpBsTGsI=;
 b=gOpPorfCuj6CLLTiBGxNSV3blrYd48xR5CA2SyCu4VUoRtBVzh4+0GfftzwBeKWIaz4uExlW4czOmGbQpsAVWwOMdjWRkemGJg+CuCkHG2iA1KroADmMraUJv5i7oDx+Q9lZoZwIMUpoxUzq+HpD2aqH3lMir91IIsw4nCIbEyVhMRG6g+I01G5YfNBkHgTjOjJwE/1/EhhCjWhugO6lMqGLKiI0AVuR+tfAJCjsEsy94I3NNK/D77FbMYG8EoMR9rhOUZYo4eUYL8ixUdf6JtX+kFKOENK/dr/P+aH6UKZNUESK8QO3pCGl9Z3UKM8DrRirIZHkuHMLsdFY5xlg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwFsuz9hKM92F8J4wHR/m/nxb/RsnvCJybjqpBsTGsI=;
 b=eI4KUyAa0iHvNcI0pGykudDCvEAn/ASkyFYvPvlXSLsPy+87S7mSJ+VJh0n7HCYILjPqrcQlxJkGu4OUTWvdpDbi8smYdJZRCLk6K5U/NnJFfror1rbfKiXk5WMyMa0OuHdF3UuAiIFWYfhchj/ui/hyEzTgJ6ucp26NDiI5E1g=
Authentication-Results: raptorengineering.com; dkim=none (message not signed)
 header.d=none;raptorengineering.com; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB3471.namprd14.prod.outlook.com (2603:10b6:208:1a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 17:15:35 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 17:15:35 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
From:   hedrick@rutgers.edu
In-Reply-To: <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
Date:   Mon, 9 Aug 2021 13:15:33 -0400
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com>
 <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu>
 <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu>
 <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
To:     Timothy Pearson <tpearson@raptorengineering.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Mon, 9 Aug 2021 17:15:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca62fe18-4b27-4294-678d-08d95b594cdb
X-MS-TrafficTypeDiagnostic: MN2PR14MB3471:
X-Microsoft-Antispam-PRVS: <MN2PR14MB34715C7DA5D9FE70A63D9B7BAAF69@MN2PR14MB3471.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNST4S0MznnGULL5PR7iok/vWjd5x2EYnqJmggsRNGRHWz3YvwrPEriKF50VwMD7ZJVB3Jbr1HZT+TgDZSr8rCrYGBd/uyP2J7nT7Ro2Lewt9HRcAcqGRvALIXfqfJCJC7ju1oL4Wf/g6zKDAOLIhsQ43/Ri7+v2XY+VQeCwlZjMElxxv9THbQdMaFUXbNWOjaSzYN9PyGwY/YANA35zUACRKXIWGpZy/lgWZHg+E2x0V04Crga95F2a+30Nf66WE3u2MYR26fpRZpB6U2WU+dv/StXVprd1j/pPSKHbGCab3kaPgLbvTnTaqEZHrJaQpGoNxDIKqp1fN21lCMSLXZjEGearD+6/sSLx2dzJF2GCPDdTIiZnG2nOymLkGGdt3f51x6vk25vuHKMXw4AHYj67hMasuSakHiRahLageG/VldS22yQEu9Fzd0R+fmQONQxZ837n07rfIajoofUgH5nkDzq9fx43w75BTjPuGXjSIwVdVhdxkjVZIXjI9huyrsaKV4c4QCWSPo/d0u9+yGjjAJGxp8U3ZdoYXEUKZZoqY1KPAXC43VwEGZR2/NTCtcRMQg3tC4AbBmW1o6YHuWGzqrBSBqXzdSflCj4oRKt2Ixzbsi+mP3Ru+/JkhKzH91V3sPMtwIg4qoKOt5vB5X2X4GSrEwM9ulb0+2uR8GqSJD4oFgQ7evmDiQkmPuHQNTpcbGqIxnl62TvY8PJAG+kb/cu4JcVMCFqGpZozyFkXmfiNbsr1Y2J+7rwZvMicGlK3D0+fjhtlbFI0sfY0bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(6916009)(2906002)(38100700002)(66556008)(66476007)(8676002)(316002)(786003)(45080400002)(186003)(75432002)(36756003)(33656002)(4326008)(30864003)(83380400001)(6506007)(6512007)(66946007)(9686003)(54906003)(53546011)(478600001)(5660300002)(86362001)(6486002)(8936002)(52116002)(2616005)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFllcmhOWFNQYUdwRmg2YWZjcEZqRlg4R2VSQVo2WTViL1lEY2kzWnV3NEdt?=
 =?utf-8?B?Z3krK3pKY0ZpRitrcEdkQzd1TXJFaFNZVEZYR2dQVXlGbGpialFnd2UrcTQz?=
 =?utf-8?B?anpmZ1pqNXJvdnl3Y05RTk90d1JGMkhSQlJWTHozZ0JrUGNLSVc5UVREL0g1?=
 =?utf-8?B?SWhQWC9aTDVDcU51RWhpQkpDRFpnUnFlQVZYNEtqeHlmZlQ2b3dBMEFtRlFr?=
 =?utf-8?B?QzNwTEpwbURlODJwRy9Udk55blNuVjBFdDR5MDNTUmQyTFIxQjMwdE5OWU1l?=
 =?utf-8?B?ZG9hbnZJbnB4VTJnbHFTeWxDbzNTL3VQajBVcUVBcFMyQ1RUR1BWNEhiZkxz?=
 =?utf-8?B?eHBqSXpwamhSaUZvWklwZFlpekpuZWF1Nm1ReXc5L3RQSnFuTjJoY1MwR2Zq?=
 =?utf-8?B?WGZHc3dHZEJQbmtLVlB6eHJuUE5HVGoweVdMcGt0ZzNzc0V5cVZ3MTJuY1d0?=
 =?utf-8?B?Zm12NnJvZHVxMFh5bXFVeGxnUlo5RWF6bldFYkFvTlQ1VnBpdFB1SXZBMDFw?=
 =?utf-8?B?cUtIcll6MFN5V3VXZFZid2NCdWdHREZ1Q21IYU9RK2o5eXFOR0cwaEtzTTBi?=
 =?utf-8?B?aFJNY0NsYlQ4Q05aTGFnaUNDcDJOeXE1am9WWmorRlF4Uzc4b25RS3UyTHp5?=
 =?utf-8?B?emhDRGltM3JaL3dCZzZmOUdQRjNlb1YrajdORU1DNjZkby85eXBvbElHcDVi?=
 =?utf-8?B?dGY5SW91aWlCR3BrQUVQbm5CdFBWcGRnZlA3V3RSaWh0RmFLcG1CVXlrUlBr?=
 =?utf-8?B?ZjJxd2h5bEcyd1pDUjJOQkw5ckVvNzdNbTBtMHN5MlErci9iVXNmUmFFazVJ?=
 =?utf-8?B?OXJTaXpYMjM1NHovREo5Q25IdGtzdlNWdmFHd21MWFVFZEM4b2RuY0R6Njh6?=
 =?utf-8?B?TFVOb2w0NFNDVVdTTVhXRXVWTGhyTzRzdGpZVUFoVVRHck1EbllwbE9DVWdB?=
 =?utf-8?B?QWllcFVuWmpPOE5uNWRYK29obUw3K2lvTGpMWEZvc3Z3aWRVckNIaXVBZGpF?=
 =?utf-8?B?TlN6THREaWQzd0RuMUVRemJFcXUyOTlId0VkdEJCTktxRmFyWFJFalc1WTF4?=
 =?utf-8?B?NDNRaFpWUHkzRnJBbWkwU3RUdHBrWFpUVy9wR2N0ZVlJV2hEU1d2UE5ZdGlV?=
 =?utf-8?B?WVNtNHBnWWdJeDVNam5haEVNc1E0L0pZWWZiMC84cWlEZW1lbko2MzROUHMr?=
 =?utf-8?B?M0U3djdyL0czN2VOUTFCR3lrY2g1eWFxckNCUEdONUZkazVRT2JFTkJoT2JF?=
 =?utf-8?B?b2lSby9DczBDSDFNRnZtdTdDQ0g0QTdzTnl5VlZ2VStwNlNhYVhMNmsvZUpz?=
 =?utf-8?B?MVF4N0xnL2RXT0ozOTJXaXg1VUx4WXRxTkFkZGhzWFhVbmpVTXBCRFJ1dlVQ?=
 =?utf-8?B?OFR6RjVhZmVKMElvdTJ1Rk4rWmdZUy9WdHJIRjhvTkNMeS80dDhoTW1zZG51?=
 =?utf-8?B?YUNMVU5LSnBmY2dRcWIyWHRDS3B6a2VQa2FkNEpJNTF5OHY1cUxNSVd4eU0v?=
 =?utf-8?B?ZzZGWEVJZm5mUXdDTnlESEJMWlp6dG12cDVPYXZJbUpYT1RDTENLZWJ1K2xx?=
 =?utf-8?B?NXFhcU9NbVp3d0hINlpzazdkWXpnZ2EwMWhvWFd3R2tGQ1VYRnNGRlVVZkd0?=
 =?utf-8?B?bEdEYkY0eUZlWEl4V1ZaRWxjdk9RZEhqWVNkMUJPc1Y4S2NBMWVjV1F2OWpt?=
 =?utf-8?B?cWpxdnVrSHdpR1J5SGxBZ3oyZEEvaTBFSElXVlZKcHlia2NvOENTRFplT1pW?=
 =?utf-8?B?ZDc4MWUycTh5TGorSmwxRnkrOU5tYktEMmRkenV4WkJXTS9rbGVpbC8xdDIx?=
 =?utf-8?B?R2hEWlVDVUp1RXppUGhUUT09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ca62fe18-4b27-4294-678d-08d95b594cdb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 17:15:35.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqSKUaho5Zx5WQze9D2x4MwpBoKAQPLuaqZF/NYlMn65ik4OVtNFt0RKssJVPYufntfPb5tZeB76b8aYJCxuwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3471
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There seems to be a soft lockup message on the console, but that=E2=80=99s =
all I can find.

I=E2=80=99m currently considering whether it=E2=80=99s best to move to NFS =
4.0, which seems not to cause the issue, or 4.2 with delegations disabled. =
This is the primary server for the department. If it fails, everything fail=
s, VMs because read-only, user jobs fai, etc.

We ran for a year before this showed up, so I=E2=80=99m pretty sure going t=
o 4.0 will fix it. But I have use cases for ACLs that will only work with 4=
.2. Since the problem seems to be in the callback mechanism, and as far as =
I can tell that=E2=80=99s only used for delegations, I assume turning off d=
elegations will fix it.

We=E2=80=99ve also had a history of issues with 4.2 problems on clients. Th=
at=E2=80=99s why we backed off to 4.0 initially. Clients were seeing hangs.

It=E2=80=99s discouraging to hear that even the most recent kernel has prob=
lems.

> On Aug 9, 2021, at 1:06 PM, Timothy Pearson <tpearson@raptorengineering.c=
om> wrote:
>=20
> Did you see anything else at all on the terminal?  The inability to log i=
n is sadly familiar, our boxes are configured to dump a trace over serial e=
very 120 seconds or so if they lock up (/proc/sys/kernel/hung_task_timeout_=
secs) and I'm not sure you'd see anything past the callback messages withou=
t that active.
>=20
> FWIW we ended up (mostly) working around the problem by moving the critic=
al systems (which are all NFSv3) to a new server, but that's a stopgap meas=
ure as we were looking to deploy NFSv4 on a broader scale.  My gut feeling =
is the failure occurs under heavy load where too many NFSv4 requests from a=
 single client are pending due to a combination of storage and network satu=
ration, but it's proven very difficult to debug -- even splitting the v3 ho=
sts from the larger NFS server (reducing traffic + storage load) seems to h=
ave temporarily stabilized things.
>=20
> ----- Original Message -----
>> From: hedrick@rutgers.edu
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Chuck Lever" <chuck.lever=
@oracle.com>, "linux-nfs"
>> <linux-nfs@vger.kernel.org>
>> Sent: Monday, August 9, 2021 11:31:25 AM
>> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy =
load
>=20
>> Incidentally, we=E2=80=99re a computer science department. We have such =
a variety of
>> students and researchers that it=E2=80=99s impossible to know what they =
are all doing.
>> Historically, if there=E2=80=99s a bug in anyth9ing, we=E2=80=99ll see i=
t, and usually enough
>> for it to be fatal.
>>=20
>> question: is backing off to 4.0 or disabling delegations likely to have =
more of
>> an impact on performance?
>>=20
>>> On Aug 9, 2021, at 12:17 PM, hedrick@rutgers.edu wrote:
>>>=20
>>> I just found this because we=E2=80=99ve been dealing with hangs of our =
primary NFS
>>> server. This is ubuntu 20.04, which is 5.10.
>>>=20
>>> Right before the hang:
>>>=20
>>> Aug  8 21:50:46 communis.lcsr.rutgers.edu <http://communis.lcsr.rutgers=
.edu/>
>>> kernel: [294852.644801] receive_cb_reply: Got unrecognized reply: calld=
ir 0x1
>>> xpt_bc_xprt 00000000b260cf95 xid e3faa54e
>>> Aug  8 21:51:54 communis.lcsr.rutgers.edu <http://communis.lcsr.rutgers=
.edu/>
>>> kernel: [294921.252531] receive_cb_reply: Got unrecognized reply: calld=
ir 0x1
>>> xpt_bc_xprt 00000000b260cf95 xid f0faa54e
>>>=20
>>>=20
>>> I looked at the code, and this seems to be an NFS4.1 callback. We just =
started
>>> seeing the problem after upgrading most of our hosts in a way that caus=
ed them
>>> to move from NFS 4.0 to 4.2. I assume 4.2 is using the 4.1 callback. Ra=
ther
>>> than disabling delegations, we=E2=80=99re moving back to NFS 4.0 on the=
 clients (except
>>> ESXi).
>>>=20
>>> We=E2=80=99re using ZFS, so this isn=E2=80=99t just btrfs.
>>>=20
>>> I=E2=80=99m afraid I don=E2=80=99t have any backtrace. I was going to g=
et more information, but
>>> it happened late at night and we were unable to get into the system to =
gather
>>> information. Just had to reboot.
>>>=20
>>>> On Jul 5, 2021, at 5:47 AM, Timothy Pearson <tpearson@raptorengineerin=
g.com
>>>> <mailto:tpearson@raptorengineering.com>> wrote:
>>>>=20
>>>> Forgot to add -- sometimes, right before the core stall and backtrace,=
 we see
>>>> messages similar to the following:
>>>>=20
>>>> [16825.408854] receive_cb_reply: Got unrecognized reply: calldir 0x1 x=
pt_bc_xprt
>>>> 0000000051f43ff7 xid 2e0c9b7a
>>>> [16825.414070] receive_cb_reply: Got unrecognized reply: calldir 0x1 x=
pt_bc_xprt
>>>> 0000000051f43ff7 xid 2f0c9b7a
>>>> [16825.414360] receive_cb_reply: Got unrecognized reply: calldir 0x1 x=
pt_bc_xprt
>>>> 0000000051f43ff7 xid 300c9b7a
>>>>=20
>>>> We're not sure if they are related or not.
>>>>=20
>>>> ----- Original Message -----
>>>>> From: "Timothy Pearson" <tpearson@raptorengineering.com
>>>>> <mailto:tpearson@raptorengineering.com>>
>>>>> To: "J. Bruce Fields" <bfields@fieldses.org <mailto:bfields@fieldses.=
org>>,
>>>>> "Chuck Lever" <chuck.lever@oracle.com <mailto:chuck.lever@oracle.com>=
>
>>>>> Cc: "linux-nfs" <linux-nfs@vger.kernel.org <mailto:linux-nfs@vger.ker=
nel.org>>
>>>>> Sent: Monday, July 5, 2021 4:44:29 AM
>>>>> Subject: CPU stall, eventual host hang with BTRFS + NFS under heavy l=
oad
>>>>=20
>>>>> We've been dealing with a fairly nasty NFS-related problem off and on=
 for the
>>>>> past couple of years.  The host is a large POWER server with several =
external
>>>>> SAS arrays attached, using BTRFS for cold storage of large amounts of=
 data.
>>>>> The main symptom is that under heavy sustained NFS write traffic usin=
g certain
>>>>> file types (see below) a core will suddenly lock up, continually spew=
ing a
>>>>> backtrace similar to the one I've pasted below.  While this immediate=
ly halts
>>>>> all NFS traffic to the affected client (which is never the same clien=
t as the
>>>>> machine doing the large file transfer), the larger issue is that over=
 the next
>>>>> few minutes / hours the entire host will gradually degrade in respons=
iveness
>>>>> until it grinds to a complete halt.  Once the core stall occurs we ha=
ve been
>>>>> unable to find any way to restore the machine to full functionality o=
r avoid
>>>>> the degradation and eventual hang short of a hard power down and rest=
art.
>>>>>=20
>>>>> Tens of GB of compressed data in a single file seems to be fairly goo=
d at
>>>>> triggering the problem, whereas raw disk images or other regularly pa=
tterned
>>>>> data tend not to be.  The underlying hardware is functioning perfectl=
y with no
>>>>> problems noted, and moving the files without NFS avoids the bug.
>>>>>=20
>>>>> We've been using a workaround involving purposefully pausing (SIGSTOP=
) the file
>>>>> transfer process on the client as soon as other clients start to show=
 a
>>>>> slowdown.  This hack avoids the bug entirely provided the host is all=
owed to
>>>>> catch back up prior to resuming (SIGCONT) the file transfer process. =
 From
>>>>> this, it seems something is going very wrong within the NFS stack und=
er high
>>>>> storage I/O pressure and high storage write latency (timeout?) -- it =
should
>>>>> simply pause transfers while the storage subsystem catches up, not lo=
ck up a
>>>>> core and force a host restart.  Interesting, sometimes it does exactl=
y what it
>>>>> is supposed to and does pause and wait for the storage subsystem, but=
 around
>>>>> 20% of the time it just triggers this bug and stalls a core.
>>>>>=20
>>>>> This bug has been present since at least 4.14 and is still present in=
 the latest
>>>>> 5.12.14 version.
>>>>>=20
>>>>> As the machine is in production, it is difficult to gather further in=
formation
>>>>> or test patches, however we would be able to apply patches to the ker=
nel that
>>>>> would potentially restore stability with enough advance scheduling.
>>>>>=20
>>>>> Sample backtrace below:
>>>>>=20
>>>>> [16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
>>>>> [16846.426202] rcu:     32-....: (5249 ticks this GP)
>>>>> idle=3D78a/1/0x4000000000000002 softirq=3D1663878/1663878 fqs=3D1986
>>>>> [16846.426241]  (t=3D5251 jiffies g=3D2720809 q=3D756724)
>>>>> [16846.426273] NMI backtrace for cpu 32
>>>>> [16846.426298] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5=
.12.14 #1
>>>>> [16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>>> [16846.426406] Call Trace:
>>>>> [16846.426429] [c000200010823250] [c00000000074e630] dump_stack+0xc4/=
0x114
>>>>> (unreliable)
>>>>> [16846.426483] [c000200010823290] [c00000000075aebc]
>>>>> nmi_cpu_backtrace+0xfc/0x150
>>>>> [16846.426506] [c000200010823310] [c00000000075b0a8]
>>>>> nmi_trigger_cpumask_backtrace+0x198/0x1f0
>>>>> [16846.426577] [c0002000108233b0] [c000000000072818]
>>>>> arch_trigger_cpumask_backtrace+0x28/0x40
>>>>> [16846.426621] [c0002000108233d0] [c000000000202db8]
>>>>> rcu_dump_cpu_stacks+0x158/0x1b8
>>>>> [16846.426667] [c000200010823470] [c000000000201828]
>>>>> rcu_sched_clock_irq+0x908/0xb10
>>>>> [16846.426708] [c000200010823560] [c0000000002141d0]
>>>>> update_process_times+0xc0/0x140
>>>>> [16846.426768] [c0002000108235a0] [c00000000022dd34]
>>>>> tick_sched_handle.isra.18+0x34/0xd0
>>>>> [16846.426808] [c0002000108235d0] [c00000000022e1e8] tick_sched_timer=
+0x68/0xe0
>>>>> [16846.426856] [c000200010823610] [c00000000021577c]
>>>>> __hrtimer_run_queues+0x16c/0x370
>>>>> [16846.426903] [c000200010823690] [c000000000216378]
>>>>> hrtimer_interrupt+0x128/0x2f0
>>>>> [16846.426947] [c000200010823740] [c000000000029494] timer_interrupt+=
0x134/0x310
>>>>> [16846.426989] [c0002000108237a0] [c000000000016c54]
>>>>> replay_soft_interrupts+0x124/0x2e0
>>>>> [16846.427045] [c000200010823990] [c000000000016f14]
>>>>> arch_local_irq_restore+0x104/0x170
>>>>> [16846.427103] [c0002000108239c0] [c00000000017247c]
>>>>> mod_delayed_work_on+0x8c/0xe0
>>>>> [16846.427149] [c000200010823a20] [c00800000819fe04]
>>>>> rpc_set_queue_timer+0x5c/0x80 [sunrpc]
>>>>> [16846.427234] [c000200010823a40] [c0080000081a096c]
>>>>> __rpc_sleep_on_priority_timeout+0x194/0x1b0 [sunrpc]
>>>>> [16846.427324] [c000200010823a90] [c0080000081a3080]
>>>>> rpc_sleep_on_timeout+0x88/0x110 [sunrpc]
>>>>> [16846.427388] [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0x=
468/0x530
>>>>> [nfsd]
>>>>> [16846.427457] [c000200010823b60] [c0080000081a0a0c] rpc_exit_task+0x=
84/0x1d0
>>>>> [sunrpc]
>>>>> [16846.427520] [c000200010823ba0] [c0080000081a2448] __rpc_execute+0x=
d0/0x760
>>>>> [sunrpc]
>>>>> [16846.427598] [c000200010823c30] [c0080000081a2b18]
>>>>> rpc_async_schedule+0x40/0x70 [sunrpc]
>>>>> [16846.427687] [c000200010823c60] [c000000000170bf0]
>>>>> process_one_work+0x290/0x580
>>>>> [16846.427736] [c000200010823d00] [c000000000170f68] worker_thread+0x=
88/0x620
>>>>> [16846.427813] [c000200010823da0] [c00000000017b860] kthread+0x1a0/0x=
1b0
>>>>> [16846.427865] [c000200010823e10] [c00000000000d6ec]
>>>>> ret_from_kernel_thread+0x5c/0x70
>>>>> [16873.869180] watchdog: BUG: soft lockup - CPU#32 stuck for 49s!
>>>>> [kworker/u130:25:10624]
>>>>> [16873.869245] Modules linked in: rpcsec_gss_krb5 iscsi_target_mod
>>>>> target_core_user uio target_core_pscsi target_core_file target_core_i=
block
>>>>> target_core_mod tun nft_counter nf_tables nfnetlink vfio_pci vfio_vir=
qfd
>>>>> vfio_iommu_spapr_tce vfio vfio_spapr_eeh i2c_dev bridg$
>>>>> [16873.869413]  linear mlx4_ib ib_uverbs ib_core raid1 md_mod sd_mod =
t10_pi
>>>>> hid_generic usbhid hid ses enclosure crct10dif_vpmsum crc32c_vpmsum x=
hci_pci
>>>>> xhci_hcd ixgbe mlx4_core mpt3sas usbcore tg3 mdio_devres of_mdio fixe=
d_phy
>>>>> xfrm_algo mdio libphy aacraid igb raid_cl$
>>>>> [16873.869889] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5=
.12.14 #1
>>>>> [16873.869966] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>>> [16873.870023] NIP:  c000000000711300 LR: c0080000081a0708 CTR: c0000=
000007112a0
>>>>> [16873.870073] REGS: c0002000108237d0 TRAP: 0900   Not tainted  (5.12=
.14)
>>>>> [16873.870109] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,R=
I,LE>  CR:
>>>>> 24004842  XER: 00000000
>>>>> [16873.870146] CFAR: c0080000081d8054 IRQMASK: 0
>>>>>             GPR00: c0080000081a0748 c000200010823a70 c0000000015c0700=
 c0000000e2227a40
>>>>>             GPR04: c0000000e2227a40 c0000000e2227a40 c000200ffb6cc0a8=
 0000000000000018
>>>>>             GPR08: 0000000000000000 5deadbeef0000122 c0080000081ffd18=
 c0080000081d8040
>>>>>             GPR12: c0000000007112a0 c000200fff7fee00 c00000000017b6c8=
 c000000090d9ccc0
>>>>>             GPR16: 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000
>>>>>             GPR20: 0000000000000000 0000000000000000 0000000000000000=
 0000000000000040
>>>>>             GPR24: 0000000000000000 0000000000000000 fffffffffffffe00=
 0000000000000001
>>>>>             GPR28: c00000001a62f000 c0080000081a0988 c0080000081ffd10=
 c0000000e2227a00
>>>>> [16873.870452] NIP [c000000000711300] __list_del_entry_valid+0x60/0x1=
00
>>>>> [16873.870507] LR [c0080000081a0708]
>>>>> rpc_wake_up_task_on_wq_queue_action_locked+0x330/0x400 [sunrpc]

