Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E990C3E4C32
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhHISey (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:34:54 -0400
Received: from mail-dm6nam11on2138.outbound.protection.outlook.com ([40.107.223.138]:40419
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232640AbhHISey (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 14:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2hfLkvCHZLEPlIwTsNAjOc6Jrn1SOgMkb8zIVGOH/peoXPN5Cxz307bG1cqYgohyYcptCcBBkFob+qYGXYBkKo14ATOIFWgZp16TxThWX8HLtCOaQ4JPQUNnyX3D7HuNAd7gE9xck1/Mx0VZ6NZ6DC0ngTzHr+nFdYTEoOMgxz2f8edR55NYX9KaV8AC/sCNyLRQukcAW/0QYh8Rib1sOS47j2jrGxT4u8k/JrThEI99N3WfWmr9OIU90UfpuaIFjmCcgF+QmAT/66JgoPKP5gFd/kLjZCHR+BUVJkDaaMGsmWUEhd4VpQ0EeQVnUjIcsQjAR9v3TLrmbT/u62CrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xp/yyt9OxJqJFP7n5E4UIwVpvGlMgx2GGxvE+WFm1QM=;
 b=lpX/QVoJJlt5Zx1TT71u56SLAo0fDkOCLngYkn2rjzXZtc/60zElreywpS2nnyFUEeh7UiQp8/ecaeGVOpO59HfqxT/4YIa/l/wyIORUbIsCJx5Iq01PerFDlB6mh7OeNNf8ndwbYwP1EPC1+8b+T/wxtH/M7JSPDlIXykMozoK5L5B1Lw3602JIZWAFzEVOlXNojP68Qz8CV0FAoBzIhomax+Yd/QYPXJ0Dvb9oS5crCejHmfpsOGlcARavkpy5k9XRRgXXPEUjRmfbdhbp8K4SaDg8HD5TWGPxQtyunQecuTcL+N2gt49E4hpLXXqtJ/yJ7PS740pTvCOQUQgdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xp/yyt9OxJqJFP7n5E4UIwVpvGlMgx2GGxvE+WFm1QM=;
 b=VHaHbIoGDS7Yd9wBicZknX3TQ8sG7oCz19RD82IBdounD6eTmjo2Nzf+KEQNEHZg5/9M742isNOzvbqmxNgX1byB8qNHJEUnYf8eFnDjlwQPbQRojfMSsm/lFFhf6RapvYuBEpLfc/2IC2T2eI9S4igmoziFXy/Ak+d9WeiKXE4=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB4080.namprd14.prod.outlook.com (2603:10b6:208:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 18:34:32 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 18:34:31 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
From:   hedrick@rutgers.edu
In-Reply-To: <20210809183029.GC8394@fieldses.org>
Date:   Mon, 9 Aug 2021 14:34:30 -0400
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC5268A1-2A20-4B56-A642-CAE48BE3166C@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com>
 <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu>
 <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu>
 <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
 <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
 <20210809183029.GC8394@fieldses.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-ClientProxiedBy: BL0PR0102CA0061.prod.exchangelabs.com
 (2603:10b6:208:25::38) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by BL0PR0102CA0061.prod.exchangelabs.com (2603:10b6:208:25::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 18:34:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eee0498-bc08-4acb-44fe-08d95b645437
X-MS-TrafficTypeDiagnostic: MN2PR14MB4080:
X-Microsoft-Antispam-PRVS: <MN2PR14MB40800F601EFEB806D03C42DBAAF69@MN2PR14MB4080.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGf9JyaLN4OtTQOxKJpZNx/bB2vQwCp1SYjLD+bkQ2aA1iTy1rqlMUdyikLd4i96gBZ8Fq5/hMjjhelXgPAY6dEjRLuIDenGWFnb5LuteMRoyFgbLmkBj5q/DY0b0h4algO2xrBASoFuRq65fQvL1oBwPckPEpoV0MWcpRIt8BqwPnx/aPf5u1pEZoD5nIMJqHxzdTDAqfJE35u56+z1jyjpnHjg+x38mykGwk03Qvm7zulIIXevJnu66z3N2hiT0zcSzD/K5ZrG8lX78WNPjq6/V5AYFpoxKPDWPxNNzJolaLbDL2Gdk6xRcGIodY7QWQZo6jaIYmQbGR5X2cjwTyyPguvzFY/2EUFccafmV2g052q7K/gcIDNyIN9ltbwGb6SPG1rfXKlGpmbjNyPVH71D68aSo9zS66xhY4wNLHrVu/8XEddEejrVKR9xD2UrUw4sB+7Lj3y8V/OsI+xVgZYNLnXy75YHGoJfuz4L/TvQVqql5X2ZoAskmat0o+Q8vdAW5mr46ynUiAxrXMVxkvcryese9pqm7xXWrPN2tDgbblQ2l7vmB5V6I17SNFTFEyNOrMoz8rTaLSndnhBd9telAmpijHITtmvTOwMAtm4WSUp09yswWQRvI5NgY/Lb9fHoXm/aR8pvJf++V4fhuSnqiTxNmt6W5K6VJyjX9dY6eaU2lIbzZLxybZOgRnhk8zpvTKVmxT2xKEIi9CGGWXPZwjnn1zXhnNwHmk9hm4AedFYYgWgPAnvE0QQPvDzxWD775qO1Kx78UGcJaVHGUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(6512007)(83380400001)(53546011)(6916009)(786003)(2906002)(4326008)(38100700002)(6506007)(8936002)(36756003)(66946007)(52116002)(66476007)(316002)(9686003)(33656002)(2616005)(86362001)(8676002)(75432002)(54906003)(5660300002)(30864003)(66556008)(6486002)(45080400002)(186003)(478600001)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDc3ZlhHTDZZaTJqQkJWZTVZVC94OUF5bWZ1eDU0WmpnS3pBVWU4R3FNVHdi?=
 =?utf-8?B?ZTU0VUpya0R1TktIeUxrWmVlVkdEZFoyRjBjMVdRR1I2bnNDSzZtMUhlSWFD?=
 =?utf-8?B?TFNRZks4TGt6aGE4Uy96ZU9pd0lhZ1BnU0U1djRiMDNsZlhwY2J0VmFWNjU5?=
 =?utf-8?B?UG95S3FzeGZlRWNqd0ZQTWZXUjJ1RkY1U29GKzhiaXRoNkJHRkwvejdxdDlP?=
 =?utf-8?B?MzhVdERwaWdieHBJbDBNbkg0ZDdqSWplVkc2eUhFSlE0Z1N6ODJ1UUdUdXhr?=
 =?utf-8?B?Yk1EOWlpV2Z5eGhHZkcydmJwTGt5aS9ack5pdU1RYjdaSnlPUDhBa00wWER2?=
 =?utf-8?B?ai93d24wN3ZYY0owSFhnTGlIVm1QeVh4dk0zN2U4ejRFcFBkS1c0U3I2bjJl?=
 =?utf-8?B?a3NJTkJ0djhOdEJWSkk3Y3psQVdvMVMzZGZuMkVtOHY4S24zUzI3Rzl0WEpL?=
 =?utf-8?B?VHN1STlLNmU0UlpKSUkxK2xXVUtkNjJsZDdRbmk1ZlgrYlZqNzdFcC80SmtF?=
 =?utf-8?B?RW9oUWJORnN2dmltSUI3YmQ0cHdvSVp1Z3BvWEdxenFtbkFwT3hPQ0RiTndh?=
 =?utf-8?B?OGZnT2laR3NKeXlZVnhoeGMySHFRVUU3djNSYUVpYmJ1QUJCRnFlN0U4Qzho?=
 =?utf-8?B?MHllaitrYzBuOTJOQkVDRE5hTXpVT2FJazNnTjBVendTeWVsWWhCOHBIVW91?=
 =?utf-8?B?UFNRZ1pPd0FLZnlaZTNuU2FhWEkxNGhoSXBsVFJDcGtGMmh0bnFsUnBkamZ5?=
 =?utf-8?B?eE8rL1JiLzZXODJXTkRjdXlWNUlrY2dha21ISzhyNEx0S2d1S0lXdHpMRFJu?=
 =?utf-8?B?OGZDWVM0SlJlSWVhYVVZS1ZETU5rSVRjU2FEWDhrZVE5ZmV2S2pjMHV4Zi9n?=
 =?utf-8?B?bFp4NldiZmoweW11bjZqemw0am1NdHlzaEJsK2tTa3VhQVlSSjFEQmZFL3lu?=
 =?utf-8?B?Vy9ERFloc2V3V21NVWx2Vng0eWM4YitTSWdDQk1xbE90bm9MNE1ndUNvVWlC?=
 =?utf-8?B?bXRPeU81UGN1N2NubnU4WDRTNHE3NUpqTGZGa3o3YmpqdFZQWGt2Y2hvNlRj?=
 =?utf-8?B?L0RWcVZIZTdOZnlIeU1zNWVnNCtJMWdkOXJwekRRY1RxUVRlM1UxU2VJazJO?=
 =?utf-8?B?ZXlNTzF3RHNhUW15MWcrV2NZTmVKbXJJcEx4T08yZEE1OU45QVd1T2FpSlRX?=
 =?utf-8?B?elhVOHdPNG5WSEVrSGh5V2svdGlzZ09TNW9EVWtXc0hmdTV4OUo3OFhpaUpU?=
 =?utf-8?B?OVYvNXNlYnBhbGFvQ2pnUTBnQjdxdHlRSVZJallKRmw2NFBqZEZiQ2hCNVVY?=
 =?utf-8?B?L1JTdWxhalZOcXVqamhUaUhOZHZEZThwcWxYTVJ4ajU1UWNjQ3JObG0rOGxQ?=
 =?utf-8?B?dlRTSUZaQzN1ckdGaTFFUzNzWmh1dThRbHF6UTRRVS84T3BhaWxsemM5Z0cv?=
 =?utf-8?B?VjRBWmFyaWRmTFRsRFlFczY2djBkM2NsYURyU1NhNGJ3bDV2YVhkMVpkYXpT?=
 =?utf-8?B?ZXlSWWNlQjA0WTR0cUFzblhLU0Y2SnJNRWZqQ3R6cUpGU1RjLytUK0J6eGJm?=
 =?utf-8?B?Vm0vbThhclFSYXBZdXg2V3R6UVNTMXgxL3pmOWJ5WUtYVXZXVStZK1JZdVFn?=
 =?utf-8?B?cm1mNXdWZk93K2FjblBrWjJiR3JOMWFVUjNPSlduMzFYVWdVREFXVmNvS3hy?=
 =?utf-8?B?Y3lQcnFYdmhPOUlUNVozMDI3ZjNUSHRhajl2aXVXUFYrREVRVDdVTXdETW52?=
 =?utf-8?B?QWRWZFJKOVR3RHZodW9iTXdCTFIya1l4RmlJaW1YN1daYUlnckhHQXI4c3NY?=
 =?utf-8?B?MnA5ektuRjBLUkdoSjQwQT09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eee0498-bc08-4acb-44fe-08d95b645437
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 18:34:31.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG/a6slB8VOZe7TiUdWltgZ27MQmVRVjiZL19OdjEofkSIXr1PcOy0cqeEcUziCNA6pvoerZ2+J/aoddvCBS+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4080
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

No, I backed down from Ubuntu 5.4.0-80 to 5.4.0-74. We had been running 74 =
safely for months, so I thought it might be an issue with 80. But after reb=
ooting I pulled the source. There were no changes to NFS, and I=E2=80=99m p=
retty sure no changes to ZFS.

This server has been running 5.4.0 throughout its life. It was 74 for about=
 3 months. Not sure what it was running before.

> On Aug 9, 2021, at 2:30 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Aug 09, 2021 at 01:15:33PM -0400, hedrick@rutgers.edu wrote:
>> There seems to be a soft lockup message on the console, but that=E2=80=
=99s all
>> I can find.
>>=20
>> I=E2=80=99m currently considering whether it=E2=80=99s best to move to N=
FS 4.0, which
>> seems not to cause the issue, or 4.2 with delegations disabled. This
>> is the primary server for the department. If it fails, everything
>> fails, VMs because read-only, user jobs fai, etc.
>>=20
>> We ran for a year before this showed up, so I=E2=80=99m pretty sure goin=
g to
>> 4.0 will fix it.
>=20
> I thought you also upgraded the kernel at the same time?  (What were the
> two kernels involved?)  So we don't know whether it's a new kernel bug,
> or an NFSv4.2-specific bug, or something else.
>=20
>> But I have use cases for ACLs that will only work
>> with 4.2.
>=20
> NFSv4 ACLs on the Linux server are the same in 4.0 and 4.2.
>=20
>> Since the problem seems to be in the callback mechanism, and
>> as far as I can tell that=E2=80=99s only used for delegations, I assume
>> turning off delegations will fix it.
>=20
> It could be.  Though I asked mainly as a way to help narrow down where
> the problem is.
>=20
> --b.
>=20
>> We=E2=80=99ve also had a history of issues with 4.2 problems on clients.
>> That=E2=80=99s why we backed off to 4.0 initially. Clients were seeing h=
angs.
>>=20
>> It=E2=80=99s discouraging to hear that even the most recent kernel has
>> problems.
>>=20
>>> On Aug 9, 2021, at 1:06 PM, Timothy Pearson
>>> <tpearson@raptorengineering.com> wrote:
>>>=20
>>> Did you see anything else at all on the terminal?  The inability to
>>> log in is sadly familiar, our boxes are configured to dump a trace
>>> over serial every 120 seconds or so if they lock up
>>> (/proc/sys/kernel/hung_task_timeout_secs) and I'm not sure you'd see
>>> anything past the callback messages without that active.
>>>=20
>>> FWIW we ended up (mostly) working around the problem by moving the
>>> critical systems (which are all NFSv3) to a new server, but that's a
>>> stopgap measure as we were looking to deploy NFSv4 on a broader
>>> scale.  My gut feeling is the failure occurs under heavy load where
>>> too many NFSv4 requests from a single client are pending due to a
>>> combination of storage and network saturation, but it's proven very
>>> difficult to debug -- even splitting the v3 hosts from the larger
>>> NFS server (reducing traffic + storage load) seems to have
>>> temporarily stabilized things.
>>>=20
>>> ----- Original Message -----
>>>> From: hedrick@rutgers.edu To: "Timothy Pearson"
>>>> <tpearson@raptorengineering.com> Cc: "J. Bruce Fields"
>>>> <bfields@fieldses.org>, "Chuck Lever" <chuck.lever@oracle.com>,
>>>> "linux-nfs" <linux-nfs@vger.kernel.org> Sent: Monday, August 9,
>>>> 2021 11:31:25 AM Subject: Re: CPU stall, eventual host hang with
>>>> BTRFS + NFS under heavy load
>>>=20
>>>> Incidentally, we=E2=80=99re a computer science department. We have suc=
h a
>>>> variety of students and researchers that it=E2=80=99s impossible to kn=
ow
>>>> what they are all doing.  Historically, if there=E2=80=99s a bug in
>>>> anyth9ing, we=E2=80=99ll see it, and usually enough for it to be fatal=
.
>>>>=20
>>>> question: is backing off to 4.0 or disabling delegations likely to
>>>> have more of an impact on performance?
>>>>=20
>>>>> On Aug 9, 2021, at 12:17 PM, hedrick@rutgers.edu wrote:
>>>>>=20
>>>>> I just found this because we=E2=80=99ve been dealing with hangs of ou=
r
>>>>> primary NFS server. This is ubuntu 20.04, which is 5.10.
>>>>>=20
>>>>> Right before the hang:
>>>>>=20
>>>>> Aug  8 21:50:46 communis.lcsr.rutgers.edu
>>>>> <http://communis.lcsr.rutgers.edu/> kernel: [294852.644801]
>>>>> receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt
>>>>> 00000000b260cf95 xid e3faa54e Aug  8 21:51:54
>>>>> communis.lcsr.rutgers.edu <http://communis.lcsr.rutgers.edu/>
>>>>> kernel: [294921.252531] receive_cb_reply: Got unrecognized reply:
>>>>> calldir 0x1 xpt_bc_xprt 00000000b260cf95 xid f0faa54e
>>>>>=20
>>>>>=20
>>>>> I looked at the code, and this seems to be an NFS4.1 callback. We
>>>>> just started seeing the problem after upgrading most of our hosts
>>>>> in a way that caused them to move from NFS 4.0 to 4.2. I assume
>>>>> 4.2 is using the 4.1 callback. Rather than disabling delegations,
>>>>> we=E2=80=99re moving back to NFS 4.0 on the clients (except ESXi).
>>>>>=20
>>>>> We=E2=80=99re using ZFS, so this isn=E2=80=99t just btrfs.
>>>>>=20
>>>>> I=E2=80=99m afraid I don=E2=80=99t have any backtrace. I was going to=
 get more
>>>>> information, but it happened late at night and we were unable to
>>>>> get into the system to gather information. Just had to reboot.
>>>>>=20
>>>>>> On Jul 5, 2021, at 5:47 AM, Timothy Pearson
>>>>>> <tpearson@raptorengineering.com
>>>>>> <mailto:tpearson@raptorengineering.com>> wrote:
>>>>>>=20
>>>>>> Forgot to add -- sometimes, right before the core stall and
>>>>>> backtrace, we see messages similar to the following:
>>>>>>=20
>>>>>> [16825.408854] receive_cb_reply: Got unrecognized reply: calldir
>>>>>> 0x1 xpt_bc_xprt 0000000051f43ff7 xid 2e0c9b7a [16825.414070]
>>>>>> receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt
>>>>>> 0000000051f43ff7 xid 2f0c9b7a [16825.414360] receive_cb_reply:
>>>>>> Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000051f43ff7
>>>>>> xid 300c9b7a
>>>>>>=20
>>>>>> We're not sure if they are related or not.
>>>>>>=20
>>>>>> ----- Original Message -----
>>>>>>> From: "Timothy Pearson" <tpearson@raptorengineering.com
>>>>>>> <mailto:tpearson@raptorengineering.com>> To: "J. Bruce Fields"
>>>>>>> <bfields@fieldses.org <mailto:bfields@fieldses.org>>, "Chuck
>>>>>>> Lever" <chuck.lever@oracle.com <mailto:chuck.lever@oracle.com>>
>>>>>>> Cc: "linux-nfs" <linux-nfs@vger.kernel.org
>>>>>>> <mailto:linux-nfs@vger.kernel.org>> Sent: Monday, July 5, 2021
>>>>>>> 4:44:29 AM Subject: CPU stall, eventual host hang with BTRFS +
>>>>>>> NFS under heavy load
>>>>>>=20
>>>>>>> We've been dealing with a fairly nasty NFS-related problem off
>>>>>>> and on for the past couple of years.  The host is a large POWER
>>>>>>> server with several external SAS arrays attached, using BTRFS
>>>>>>> for cold storage of large amounts of data.  The main symptom is
>>>>>>> that under heavy sustained NFS write traffic using certain file
>>>>>>> types (see below) a core will suddenly lock up, continually
>>>>>>> spewing a backtrace similar to the one I've pasted below.  While
>>>>>>> this immediately halts all NFS traffic to the affected client
>>>>>>> (which is never the same client as the machine doing the large
>>>>>>> file transfer), the larger issue is that over the next few
>>>>>>> minutes / hours the entire host will gradually degrade in
>>>>>>> responsiveness until it grinds to a complete halt.  Once the
>>>>>>> core stall occurs we have been unable to find any way to restore
>>>>>>> the machine to full functionality or avoid the degradation and
>>>>>>> eventual hang short of a hard power down and restart.
>>>>>>>=20
>>>>>>> Tens of GB of compressed data in a single file seems to be
>>>>>>> fairly good at triggering the problem, whereas raw disk images
>>>>>>> or other regularly patterned data tend not to be.  The
>>>>>>> underlying hardware is functioning perfectly with no problems
>>>>>>> noted, and moving the files without NFS avoids the bug.
>>>>>>>=20
>>>>>>> We've been using a workaround involving purposefully pausing
>>>>>>> (SIGSTOP) the file transfer process on the client as soon as
>>>>>>> other clients start to show a slowdown.  This hack avoids the
>>>>>>> bug entirely provided the host is allowed to catch back up prior
>>>>>>> to resuming (SIGCONT) the file transfer process.  From this, it
>>>>>>> seems something is going very wrong within the NFS stack under
>>>>>>> high storage I/O pressure and high storage write latency
>>>>>>> (timeout?) -- it should simply pause transfers while the storage
>>>>>>> subsystem catches up, not lock up a core and force a host
>>>>>>> restart.  Interesting, sometimes it does exactly what it is
>>>>>>> supposed to and does pause and wait for the storage subsystem,
>>>>>>> but around 20% of the time it just triggers this bug and stalls
>>>>>>> a core.
>>>>>>>=20
>>>>>>> This bug has been present since at least 4.14 and is still
>>>>>>> present in the latest 5.12.14 version.
>>>>>>>=20
>>>>>>> As the machine is in production, it is difficult to gather
>>>>>>> further information or test patches, however we would be able to
>>>>>>> apply patches to the kernel that would potentially restore
>>>>>>> stability with enough advance scheduling.
>>>>>>>=20
>>>>>>> Sample backtrace below:
>>>>>>>=20
>>>>>>> [16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
>>>>>>> [16846.426202] rcu:     32-....: (5249 ticks this GP)
>>>>>>> idle=3D78a/1/0x4000000000000002 softirq=3D1663878/1663878 fqs=3D198=
6
>>>>>>> [16846.426241]  (t=3D5251 jiffies g=3D2720809 q=3D756724)
>>>>>>> [16846.426273] NMI backtrace for cpu 32 [16846.426298] CPU: 32
>>>>>>> PID: 10624 Comm: kworker/u130:25 Not tainted 5.12.14 #1
>>>>>>> [16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>>>>> [16846.426406] Call Trace: [16846.426429] [c000200010823250]
>>>>>>> [c00000000074e630] dump_stack+0xc4/0x114 (unreliable)
>>>>>>> [16846.426483] [c000200010823290] [c00000000075aebc]
>>>>>>> nmi_cpu_backtrace+0xfc/0x150 [16846.426506] [c000200010823310]
>>>>>>> [c00000000075b0a8] nmi_trigger_cpumask_backtrace+0x198/0x1f0
>>>>>>> [16846.426577] [c0002000108233b0] [c000000000072818]
>>>>>>> arch_trigger_cpumask_backtrace+0x28/0x40 [16846.426621]
>>>>>>> [c0002000108233d0] [c000000000202db8]
>>>>>>> rcu_dump_cpu_stacks+0x158/0x1b8 [16846.426667]
>>>>>>> [c000200010823470] [c000000000201828]
>>>>>>> rcu_sched_clock_irq+0x908/0xb10 [16846.426708]
>>>>>>> [c000200010823560] [c0000000002141d0]
>>>>>>> update_process_times+0xc0/0x140 [16846.426768]
>>>>>>> [c0002000108235a0] [c00000000022dd34]
>>>>>>> tick_sched_handle.isra.18+0x34/0xd0 [16846.426808]
>>>>>>> [c0002000108235d0] [c00000000022e1e8] tick_sched_timer+0x68/0xe0
>>>>>>> [16846.426856] [c000200010823610] [c00000000021577c]
>>>>>>> __hrtimer_run_queues+0x16c/0x370 [16846.426903]
>>>>>>> [c000200010823690] [c000000000216378]
>>>>>>> hrtimer_interrupt+0x128/0x2f0 [16846.426947] [c000200010823740]
>>>>>>> [c000000000029494] timer_interrupt+0x134/0x310 [16846.426989]
>>>>>>> [c0002000108237a0] [c000000000016c54]
>>>>>>> replay_soft_interrupts+0x124/0x2e0 [16846.427045]
>>>>>>> [c000200010823990] [c000000000016f14]
>>>>>>> arch_local_irq_restore+0x104/0x170 [16846.427103]
>>>>>>> [c0002000108239c0] [c00000000017247c]
>>>>>>> mod_delayed_work_on+0x8c/0xe0 [16846.427149] [c000200010823a20]
>>>>>>> [c00800000819fe04] rpc_set_queue_timer+0x5c/0x80 [sunrpc]
>>>>>>> [16846.427234] [c000200010823a40] [c0080000081a096c]
>>>>>>> __rpc_sleep_on_priority_timeout+0x194/0x1b0 [sunrpc]
>>>>>>> [16846.427324] [c000200010823a90] [c0080000081a3080]
>>>>>>> rpc_sleep_on_timeout+0x88/0x110 [sunrpc] [16846.427388]
>>>>>>> [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0x468/0x530
>>>>>>> [nfsd] [16846.427457] [c000200010823b60] [c0080000081a0a0c]
>>>>>>> rpc_exit_task+0x84/0x1d0 [sunrpc] [16846.427520]
>>>>>>> [c000200010823ba0] [c0080000081a2448] __rpc_execute+0xd0/0x760
>>>>>>> [sunrpc] [16846.427598] [c000200010823c30] [c0080000081a2b18]
>>>>>>> rpc_async_schedule+0x40/0x70 [sunrpc] [16846.427687]
>>>>>>> [c000200010823c60] [c000000000170bf0]
>>>>>>> process_one_work+0x290/0x580 [16846.427736] [c000200010823d00]
>>>>>>> [c000000000170f68] worker_thread+0x88/0x620 [16846.427813]
>>>>>>> [c000200010823da0] [c00000000017b860] kthread+0x1a0/0x1b0
>>>>>>> [16846.427865] [c000200010823e10] [c00000000000d6ec]
>>>>>>> ret_from_kernel_thread+0x5c/0x70 [16873.869180] watchdog: BUG:
>>>>>>> soft lockup - CPU#32 stuck for 49s!  [kworker/u130:25:10624]
>>>>>>> [16873.869245] Modules linked in: rpcsec_gss_krb5
>>>>>>> iscsi_target_mod target_core_user uio target_core_pscsi
>>>>>>> target_core_file target_core_iblock target_core_mod tun
>>>>>>> nft_counter nf_tables nfnetlink vfio_pci vfio_virqfd
>>>>>>> vfio_iommu_spapr_tce vfio vfio_spapr_eeh i2c_dev bridg$
>>>>>>> [16873.869413]  linear mlx4_ib ib_uverbs ib_core raid1 md_mod
>>>>>>> sd_mod t10_pi hid_generic usbhid hid ses enclosure
>>>>>>> crct10dif_vpmsum crc32c_vpmsum xhci_pci xhci_hcd ixgbe mlx4_core
>>>>>>> mpt3sas usbcore tg3 mdio_devres of_mdio fixed_phy xfrm_algo mdio
>>>>>>> libphy aacraid igb raid_cl$ [16873.869889] CPU: 32 PID: 10624
>>>>>>> Comm: kworker/u130:25 Not tainted 5.12.14 #1 [16873.869966]
>>>>>>> Workqueue: rpciod rpc_async_schedule [sunrpc] [16873.870023]
>>>>>>> NIP:  c000000000711300 LR: c0080000081a0708 CTR:
>>>>>>> c0000000007112a0 [16873.870073] REGS: c0002000108237d0 TRAP:
>>>>>>> 0900   Not tainted  (5.12.14) [16873.870109] MSR:
>>>>>>> 900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR:
>>>>>>> 24004842  XER: 00000000 [16873.870146] CFAR: c0080000081d8054
>>>>>>> IRQMASK: 0 GPR00: c0080000081a0748 c000200010823a70
>>>>>>> c0000000015c0700 c0000000e2227a40 GPR04: c0000000e2227a40
>>>>>>> c0000000e2227a40 c000200ffb6cc0a8 0000000000000018 GPR08:
>>>>>>> 0000000000000000 5deadbeef0000122 c0080000081ffd18
>>>>>>> c0080000081d8040 GPR12: c0000000007112a0 c000200fff7fee00
>>>>>>> c00000000017b6c8 c000000090d9ccc0 GPR16: 0000000000000000
>>>>>>> 0000000000000000 0000000000000000 0000000000000000 GPR20:
>>>>>>> 0000000000000000 0000000000000000 0000000000000000
>>>>>>> 0000000000000040 GPR24: 0000000000000000 0000000000000000
>>>>>>> fffffffffffffe00 0000000000000001 GPR28: c00000001a62f000
>>>>>>> c0080000081a0988 c0080000081ffd10 c0000000e2227a00
>>>>>>> [16873.870452] NIP [c000000000711300]
>>>>>>> __list_del_entry_valid+0x60/0x100 [16873.870507] LR
>>>>>>> [c0080000081a0708]
>>>>>>> rpc_wake_up_task_on_wq_queue_action_locked+0x330/0x400 [sunrpc]

