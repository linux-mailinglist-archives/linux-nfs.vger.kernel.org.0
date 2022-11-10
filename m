Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C356623DBE
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Nov 2022 09:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiKJIqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Nov 2022 03:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKJIqe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Nov 2022 03:46:34 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EC286C4;
        Thu, 10 Nov 2022 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668069993; x=1699605993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zvLKYbtPacHnfccemkzgAuTE7K2RqkgmskRqlj9joLY=;
  b=NFbsDYKY8EAvlVWDcT30qes1vetyfhx5oTA+0IYWZNZoUY4VhI6vvTL8
   ouXJY8CwgVcrfja7rfuiD2Y8w+/uUiz6f72R4qXr8liIYvsxsUzbn6mw5
   6+Cg7Nny1P9o1wnQKdBjR2NaViymh4XwDZg7f4dbS0dyYJCq2eBh2xQn4
   y+VBQMoyhDLMSWGDH9Cbg54xcjiGStSF/GyvyTLQOt1DpqBjfwwDjjjDF
   nRNUe36FRIEvjGg6nnYp5PAFricsOO/LTVM54ZILfF8arUxp11I/O/v1g
   UouYdM7lNynDcsACg3k9FyTo1isCuj2lloAi9LHeZRpANG7FkeUnpvYBA
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,153,1665417600"; 
   d="scan'208";a="328039629"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2022 16:46:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7UOlJVK2jAkpyEM4+lcL7OFA5QrEPevdxEfRwHKNWn7wg9jvyJQLTb8fW0z5IQ5iG/TS0m9Msawx2iJDgLqSxHPyAkWTynf2IZAtutWTD9fp17BXjpwvxkq3WOze1ccRYiNANrdqUJBlnC8ATGw2bzoG3ZN9N2cwY+hB4ro4+DvolybTUObsZ+LXLszEs8fjg8piXxQyzIp3KkjCyukSSIecp4iP4gKdVJVnRtnmlLpVk7qIhxXp3xJdL9MN9WQBN0quKeMwsdWNAhL7vV5qE/rG2zAaExPE/GLCwNIMUWXYK5cuZtfXu89tl+Ne7v4m2hEnEbjNJejyhanRm7EfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvLKYbtPacHnfccemkzgAuTE7K2RqkgmskRqlj9joLY=;
 b=K/TY9DNhqga/C8ULITBtr0aCnJpeQRaAcm+A0S2s834EZ4kETWiuqXVdxnmIGC3q+3v4v2qYDGaIXTkgqj4b/c1QdQDHw1ulEMEeqbivtCm55oNDY7ERDrxsjBZ8t76Hqp44+hlNUi21yhGjj1uRFc1rf5o1uQxk3uMKD7hqE22YRtwvQec4l9QOzp61zUv2wJueFPuYMuY7aZWYM+vKJAQs6r6IzvqtPvFIevgu+U+1WbGBM8IgliUTeulasJD5SOaisl8CEnpJPBnn/MMShKHnVcFSsU4jpLwdrHSgaU0ELZWeWhw9tHS6MczOg0T+u3LKgwbHRwPeOu4QlPI1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvLKYbtPacHnfccemkzgAuTE7K2RqkgmskRqlj9joLY=;
 b=MvSS5yKhXnh7JkDyCtffNdLgOdFE4rMCaYwCiGqJ8tk+Ar+d5iWcYQxJc6dtkPUKtJTKvbPPtlATEYfyKFAviAle6aA8ed7z5IJUHMFZ7SWjzkSyl45CrJMkv8dhIvHmg4s2P4gm1OU+xQw31qH82fAeWZ8XBFX4k5S8Py+SDAI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6485.namprd04.prod.outlook.com (2603:10b6:a03:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 08:46:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:46:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     Zorro Lang <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Thread-Topic: generic/650 makes v6.0-rc client unusable
Thread-Index: AQHY8/KDAlsuTLAdeUqIt7enJlIXlK42Zj0AgAFztgA=
Date:   Thu, 10 Nov 2022 08:46:29 +0000
Message-ID: <20221110084628.ztsdhukgtc56ih5e@shindev>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
 <20221109041951.wlgxac3buutvettq@shindev>
 <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
In-Reply-To: <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6485:EE_
x-ms-office365-filtering-correlation-id: 9c4f39e5-ddf1-47c6-6bf2-08dac2f80f54
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fT1dM5akc+s48Cs2ph0TAk9hAoX5AeaC+FGXhT9gxDItNiaye3gfhwBEYuuVSJZ3pxutqD9m3mEMSPJybfsa+e5aci7jwUu8fa08tYnUZ7m22slwaQ6uNNQ811UzOncGohoY0IdGuLwiOr4Xl6geINxkY3EsSjitq7oTSyKsFSGhOC9/gjl9HbKoqL479u8G/rfkIkZsMpckOxlJFV3Ck67OjXu2j2YT1PYroBmMwk+Oru6Y7pQrMmiXRTk3CVdf6qv+KdVZfvenlGEIF/f4lWkuJYIGT44G4bw0zc71TYqsBVdMUj8vinxAwz/qH3O2BFVHO/7mjzkl+sdLrr4gTFqt9+tpLs8zAiWgEV1AE6XGjn3YjaeRAmIw2Tvv9MsxTwFAF4eQJM96QUI032oFMRxf85tlE+7kvunMkmLM0OMsqDWq0jFqqIEgqgPvJ6z//2ICpiXOsHEVm2fPO85pGGLC0OAI/+ZdJ00GKBX0v6l7juFG5H6fODJMXPXKAS7KdbIHDerg/Nn24vp2CpR09SfaplFtFtz2DVvS/ueBWiyfux8eWUvkcmmPp2lHccQNsHHDYfUjTFd8q0E4UjhuYKqRYzYNiNXnrLHe5wapwfLcH7TRlda0A5BYYRRrJ5WKuoK5NKRVcmlGiJ/DPuFUwPSjfKz3sXE5LIg7EH4GvzjVxsdJ3rEgz0tUcr3Xz83INF3H5Du/uNxzGq27knDM5y7it6jpgBgTw+cZHPhJzGHwurlbEZuU12g6bCqkfDykRpYfk1w9dYL0WF6KZQxavVDhkwkZqP5Fn3q7zP0pa7E1iP+qHwBaYjkrs7vGYBqBTNlwpWrVdQmBU0V6VcyG4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(316002)(966005)(6486002)(9686003)(6512007)(66446008)(66556008)(44832011)(66946007)(8676002)(64756008)(76116006)(26005)(66476007)(4326008)(91956017)(2906002)(8936002)(41300700001)(5660300002)(53546011)(186003)(1076003)(86362001)(6506007)(478600001)(38100700002)(33716001)(122000001)(82960400001)(6916009)(54906003)(83380400001)(38070700005)(71200400001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TzpvWcdUyuUwTEnFBGiiw5qarM1VLo1dSl1n4gV+PxiwikpdUBEJxsktTwUj?=
 =?us-ascii?Q?z34bWXHLRf5CsJ/frlyOf+ULTgc0fwTyvndIaJwgmwlOAxCABUfElOYxmrKF?=
 =?us-ascii?Q?6dtOyxQALeiEluik2JIwKJx7hrOmt/nknOFYo08DuKXSAvK6a5+9fEHfUfhD?=
 =?us-ascii?Q?0upKS5Ku/d8j0CohKkh96EgFhvbmRcjSVx3oqd3WJa2SmINbxb7D79749K1J?=
 =?us-ascii?Q?neGLU2/whROwlWLp/v6MloGnwaVX9kEbKGcLfutAwRmGhOQ19G2vfFUb0gLf?=
 =?us-ascii?Q?Q6qf3PI9SNyxSwlJ4U+wiocnDTgKa3qXabnsOHyDLMwqKMMKXbPMwbEYEPDm?=
 =?us-ascii?Q?1jQSaMXzk3HG1Hi9wfKnSB2UdZ41IaUfmvyNYhKD3FGw6M5euHWE0Vijv2hO?=
 =?us-ascii?Q?Fj1z6jtUTRhT09cx+GyiAWe8LFWd4kKCab2T6Fqu8VABq0dSbyYnt+P2kl2U?=
 =?us-ascii?Q?74qL2t+TmZtepivLClDcnlRI3lSwQwyKA2FUjCa0tgD0IU2VkvIqaNPyLw2W?=
 =?us-ascii?Q?PEME4P4de3RzhP8lGtdhMeu04fILpsUlMn/1+O77ksehP0T0/sbGdrDL0DS+?=
 =?us-ascii?Q?nerOVRJqrI/Q44GV7RwTXLhVRizMeSDPiyyyz40Wg0+gYuYPw+o0vMv7kHkF?=
 =?us-ascii?Q?L3IzgSl7sLD1UM4IFACZVFz/Em7KUv/TMUXbZrKGXuVxTQ0bCM3Jgp9CCfbV?=
 =?us-ascii?Q?GjCPvMkJdar+99/S/iumAMCIlEbtur6lVNPPgI6Y18MrT4tjT/1Ibu7vpmAP?=
 =?us-ascii?Q?+UuHbl/9T2WSRoJ9SOXIstzS+vcwdjnHMFbjW22DQvvpFGZMmN5AHX/+H/5t?=
 =?us-ascii?Q?JUDlmdixIMu+ZtKKk72Ez9Z47Tlja3caZzwjUrCZMucF4s6KZoxpY17+M9Uj?=
 =?us-ascii?Q?zPi6htQAgIQeoMDPf2a2dlpOtScYEsBxjgyfUZvA/w8e/S8/4tdm2IihHRyL?=
 =?us-ascii?Q?w1I8r0C3MnrRtY0sHBImkLmYmE5NQkXGPjOdX35Qi+8LyV/6x9enSSd2r9YZ?=
 =?us-ascii?Q?1a4YgA2QyLnTWLgxJ7pLEr1LHdUfft66KqE3gteVBeqf1MOgI58wl3I3gFa0?=
 =?us-ascii?Q?uNjb12kwE+E9TzhCnSOaYLe4pH3lBhmgR9mQ/tOwrbawSUlK/ZWHZC7nNUe9?=
 =?us-ascii?Q?ojS0C2+2+6ikw7MdeGItTMTEXZcJkQZQhHa/NfsWQLVsuog7D+hfzJFXhbtg?=
 =?us-ascii?Q?2uIkldCuCUh325KU2UBHy6886WjZsI+WkYm1LQ/PbVOQHIYClKhfs/XiVfUL?=
 =?us-ascii?Q?koJeZIbTHDcpaIgSeANHIZdhEIfIk4rZr1ms0Zk9wLRx5/47RNQ+Gs/8W1xt?=
 =?us-ascii?Q?N5/MB9xfpLDTsv3X/8ShYixdpDStIMOorLzWbad7vqmhlq9tlaesh7Eh4f97?=
 =?us-ascii?Q?JFvTbhVv/4f042zWrkpi694yFajmBtrFZwF2QPxqctfZjbZ1xhNmIWzZahv5?=
 =?us-ascii?Q?B9vSgbImfZaCC5HJdY0GbPKmotxYsUHrv9FCCBJjfOWS/CyCRhzEdkK28Fec?=
 =?us-ascii?Q?oIZ7iWkR7w6X9oUSjC5nuaTf0GhnJ2JVNfck/zpsapqhBqVQ67qQ0iXqZONb?=
 =?us-ascii?Q?17xN7aafFc4LwvyQUoAH51hAVPM2meLvavABkh7eEnvBepeHwtUYu7ylsowZ?=
 =?us-ascii?Q?/uOQELNYoAzHLsOfYsjANig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80F15FC1BA6F024A9AFD0466608E40E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4f39e5-ddf1-47c6-6bf2-08dac2f80f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 08:46:29.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qwn0J0XijdefPbAqWWSmgp5RoRSZCTI1z7ikbDUUMR4zJd6y7HKFT9H6QC19NKYtjCCsaqrPBeNtB30WiOk60uTENjRMAIyt6NdqLqx+6w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6485
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Nov 09, 2022 / 10:36, Filipe Manana wrote:
> On Wed, Nov 9, 2022 at 4:22 AM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > On Sep 04, 2022 / 21:15, Zorro Lang wrote:
> > > On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
> > > > While investigating some of the other issues that have been
> > > > reported lately, I've found that my v6.0-rc3 NFS/TCP client
> > > > goes off the rails often (but not always) during generic/650.
> > > >
> > > > This is the test that runs a workload while offlining and
> > > > onlining CPUs. My test client has 12 physical cores.
> > > >
> > > > The test appears to start normally, but then after a bit
> > > > the NFS server workload drops to zero and the NFS mount
> > > > disappears. I can't run programs (sudo, for example) on
> > > > the client. Can't log in, even on the console. The console
> > > > has a constant stream of "can't rotate log: Input/Output
> > > > error" type messages.
> >
> > I also observe this failure when I ran fstests using btrfs on my HDDs.
> > The failure is recreated almost always.
>=20
> I'm wondering what do you get in dmesg, any traces?

I show the log I observed at the end of this e-mail [1]. No BUG message.
The WARN "didn't collect load info for all cpus, balancing is broken" is
repeated. But I once the hang without this WARN.

The last message left was from xfs "ctx ticket reservation ran out. Need to=
 up
reservation". This is for the system disk, not for the test target file sys=
tem.

> I've excluded the test from my runs for over an year now, due to some
> crash that I reported
> to the mm and cpu hotplug people here:
>=20
> https://lore.kernel.org/linux-mm/CAL3q7H4AyrZ5erimDyO7mOVeppd5BeMw3CS=3Dw=
GbzrMZrp56ktA@mail.gmail.com/
>=20
> Unfortunately I had no reply from anyone who works or maintains those
> subsystems.
>=20
> It didn't happen very often, and I haven't tested again with recent kerne=
ls.

Thanks for sharing your experience. Hmm, your failure symptom is different =
from
mine.


[1]

Nov 09 11:50:09 redsun40 root[3480]: run xfstest generic/650
Nov 09 11:50:09 redsun40 unknown: run fstests generic/650 at 2022-11-09 11:=
50:09
Nov 09 11:50:09 redsun40 systemd[1]: Started fstests-generic-650.scope - /u=
sr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oo=
m_score_adj; exec ./tests/generic/650.
Nov 09 11:50:11 redsun40 kernel: smpboot: CPU 10 is now offline
Nov 09 11:50:11 redsun40 kernel: MMIO Stale Data CPU bug present and SMT on=
, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guid=
e/hw-vuln/processor_mmio_stale_data.html for more details.
Nov 09 11:50:11 redsun40 kernel: smpboot: CPU 14 is now offline
Nov 09 11:50:14 redsun40 kernel: smpboot: CPU 25 is now offline
Nov 09 11:50:15 redsun40 kernel: smpboot: Booting Node 0 Processor 14 APIC =
0x1c
Nov 09 11:50:15 redsun40 kernel: x86/cpu: SGX disabled by BIOS.
Nov 09 11:50:15 redsun40 kernel: x86/tme: not enabled by BIOS
Nov 09 11:50:15 redsun40 kernel: CPU0: Thermal monitoring enabled (TM1)
Nov 09 11:50:15 redsun40 kernel: x86/cpu: User Mode Instruction Prevention =
(UMIP) activated
Nov 09 11:50:15 redsun40 kernel: smpboot: CPU 30 is now offline
Nov 09 11:50:17 redsun40 kernel: smpboot: CPU 2 is now offline
Nov 09 11:50:19 redsun40 kernel: smpboot: CPU 20 is now offline
Nov 09 11:50:22 redsun40 kernel: smpboot: CPU 31 is now offline
Nov 09 11:50:23 redsun40 kernel: smpboot: CPU 23 is now offline
Nov 09 11:50:24 redsun40 kernel: smpboot: Booting Node 0 Processor 10 APIC =
0x14
Nov 09 11:50:26 redsun40 kernel: smpboot: CPU 10 is now offline
Nov 09 11:50:28 redsun40 kernel: smpboot: Booting Node 0 Processor 20 APIC =
0x9
Nov 09 11:50:29 redsun40 kernel: smpboot: CPU 21 is now offline
Nov 09 11:50:30 redsun40 kernel: smpboot: CPU 16 is now offline
Nov 09 11:50:31 redsun40 /usr/sbin/irqbalance[1143]: WARNING, didn't collec=
t load info for all cpus, balancing is broken
Nov 09 11:50:31 redsun40 kernel: smpboot: Booting Node 0 Processor 30 APIC =
0x1d
Nov 09 11:50:32 redsun40 kernel: smpboot: CPU 18 is now offline
Nov 09 11:50:33 redsun40 kernel: smpboot: Booting Node 0 Processor 2 APIC 0=
x4
Nov 09 11:50:34 redsun40 kernel: smpboot: CPU 4 is now offline
Nov 09 11:50:35 redsun40 kernel: smpboot: CPU 19 is now offline
Nov 09 11:50:36 redsun40 kernel: smpboot: Booting Node 0 Processor 31 APIC =
0x1f
Nov 09 11:50:37 redsun40 kernel: smpboot: CPU 27 is now offline
Nov 09 11:50:38 redsun40 kernel: smpboot: CPU 26 is now offline
Nov 09 11:50:39 redsun40 kernel: smpboot: CPU 11 is now offline
Nov 09 11:50:41 redsun40 /usr/sbin/irqbalance[1143]: WARNING, didn't collec=
t load info for all cpus, balancing is broken

...

Nov 09 12:28:51 redsun40 kernel: smpboot: Booting Node 0 Processor 31 APIC =
0x1f
Nov 09 12:28:52 redsun40 /usr/sbin/irqbalance[1143]: WARNING, didn't collec=
t load info for all cpus, balancing is broken
Nov 09 12:28:52 redsun40 kernel: smpboot: Booting Node 0 Processor 14 APIC =
0x1c
Nov 09 12:28:52 redsun40 /usr/sbin/irqbalance[1143]: WARNING, didn't collec=
t load info for all cpus, balancing is broken
Nov 09 12:28:53 redsun40 kernel: smpboot: CPU 24 is now offline
Nov 09 12:28:55 redsun40 kernel: smpboot: Booting Node 0 Processor 26 APIC =
0x15
Nov 09 12:28:57 redsun40 kernel: smpboot: CPU 29 is now offline
Nov 09 12:28:58 redsun40 kernel: smpboot: Booting Node 0 Processor 20 APIC =
0x9
Nov 09 12:28:59 redsun40 kernel: smpboot: Booting Node 0 Processor 24 APIC =
0x11
Nov 09 12:29:00 redsun40 kernel: x86: Booting SMP configuration:
Nov 09 12:29:00 redsun40 kernel: smpboot: Booting Node 0 Processor 1 APIC 0=
x2
Nov 09 12:29:01 redsun40 kernel: smpboot: CPU 19 is now offline
Nov 09 12:29:02 redsun40 /usr/sbin/irqbalance[1143]: WARNING, didn't collec=
t load info for all cpus, balancing is broken
Nov 09 12:29:04 redsun40 kernel: smpboot: Booting Node 0 Processor 7 APIC 0=
xe
Nov 09 12:29:04 redsun40 kernel: smpboot: CPU 1 is now offline
Nov 09 12:29:04 redsun40 kernel: XFS (nvme0n1p3): ctx ticket reservation ra=
n out. Need to up reservation


--=20
Shin'ichiro Kawasaki=
