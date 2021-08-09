Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB16B3E4AC8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhHIRZn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 13:25:43 -0400
Received: from mail.rptsys.com ([23.155.224.45]:14197 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234208AbhHIRZm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 13:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 8A42537B2FB578;
        Mon,  9 Aug 2021 12:25:21 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jNdDIEP_ivun; Mon,  9 Aug 2021 12:25:17 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 210F337B2FB574;
        Mon,  9 Aug 2021 12:25:17 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 210F337B2FB574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628529917; bh=8luhyFGmM0vkf8NFccjx9KnEv/XWVI6tnokDF5btbR4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ljnDqt7cGZSt0bzBVbWm93R2QIsBHfhXnp4PWnivNzTcdlGcgaw61exU34ggKRkL6
         RwlN2rkcWDGDWDyPsCDDm2IbuzOsVZQVhd/5Li4C6gFOwE1WhGCQEXWDR1ek11+2od
         f/qJ4fUPRhYfpyBPi93eJI4diGtJ20ycNOEnv2HM=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dnIi3rKjb4Ur; Mon,  9 Aug 2021 12:25:17 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id F070837B2FB571;
        Mon,  9 Aug 2021 12:25:16 -0500 (CDT)
Date:   Mon, 9 Aug 2021 12:25:16 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     hedrick <hedrick@rutgers.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1376198796.1038216.1628529916907.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com> <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu> <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu> <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com> <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC91 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: NfnuV+kMJqgCkkRCCcDm5gmWfDC5Vg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is a bit frustrating, but if there's a workaround with disabling delegat=
ions that would at least be welcome news.  We have a Kerberized environment=
 and ACLs are a huge selling point for v4.

To the latter point, I get the impression that either there aren't too many=
 organizations using NFS at the scale that both yours and ours are, or they=
 haven't yet figured out that the random lockup issue they're seeing origin=
ates in the NFS stack.  My suspicion is the latter, but time will tell.

----- Original Message -----
> From: "hedrick" <hedrick@rutgers.edu>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Chuck Lever" <chuck.lever@=
oracle.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Monday, August 9, 2021 12:15:33 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy l=
oad

> There seems to be a soft lockup message on the console, but that=E2=80=99=
s all I can
> find.
>=20
> I=E2=80=99m currently considering whether it=E2=80=99s best to move to NF=
S 4.0, which seems not
> to cause the issue, or 4.2 with delegations disabled. This is the primary
> server for the department. If it fails, everything fails, VMs because
> read-only, user jobs fai, etc.
>=20
> We ran for a year before this showed up, so I=E2=80=99m pretty sure going=
 to 4.0 will
> fix it. But I have use cases for ACLs that will only work with 4.2. Since=
 the
> problem seems to be in the callback mechanism, and as far as I can tell t=
hat=E2=80=99s
> only used for delegations, I assume turning off delegations will fix it.
>=20
> We=E2=80=99ve also had a history of issues with 4.2 problems on clients. =
That=E2=80=99s why we
> backed off to 4.0 initially. Clients were seeing hangs.
>=20
> It=E2=80=99s discouraging to hear that even the most recent kernel has pr=
oblems.
>=20
>> On Aug 9, 2021, at 1:06 PM, Timothy Pearson <tpearson@raptorengineering.=
com>
>> wrote:
>>=20
>> Did you see anything else at all on the terminal?  The inability to log =
in is
>> sadly familiar, our boxes are configured to dump a trace over serial eve=
ry 120
>> seconds or so if they lock up (/proc/sys/kernel/hung_task_timeout_secs) =
and I'm
>> not sure you'd see anything past the callback messages without that acti=
ve.
>>=20
>> FWIW we ended up (mostly) working around the problem by moving the criti=
cal
>> systems (which are all NFSv3) to a new server, but that's a stopgap meas=
ure as
>> we were looking to deploy NFSv4 on a broader scale.  My gut feeling is t=
he
>> failure occurs under heavy load where too many NFSv4 requests from a sin=
gle
>> client are pending due to a combination of storage and network saturatio=
n, but
>> it's proven very difficult to debug -- even splitting the v3 hosts from =
the
>> larger NFS server (reducing traffic + storage load) seems to have tempor=
arily
>> stabilized things.
>>=20
>> ----- Original Message -----
>>> From: hedrick@rutgers.edu
>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>>> Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Chuck Lever"
>>> <chuck.lever@oracle.com>, "linux-nfs"
>>> <linux-nfs@vger.kernel.org>
>>> Sent: Monday, August 9, 2021 11:31:25 AM
>>> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy=
 load
>>=20
>>> Incidentally, we=E2=80=99re a computer science department. We have such=
 a variety of
>>> students and researchers that it=E2=80=99s impossible to know what they=
 are all doing.
>>> Historically, if there=E2=80=99s a bug in anyth9ing, we=E2=80=99ll see =
it, and usually enough
>>> for it to be fatal.
>>>=20
>>> question: is backing off to 4.0 or disabling delegations likely to have=
 more of
>>> an impact on performance?
>>>=20
>>>> On Aug 9, 2021, at 12:17 PM, hedrick@rutgers.edu wrote:
>>>>=20
>>>> I just found this because we=E2=80=99ve been dealing with hangs of our=
 primary NFS
>>>> server. This is ubuntu 20.04, which is 5.10.
>>>>=20
>>>> Right before the hang:
>>>>=20
>>>> Aug  8 21:50:46 communis.lcsr.rutgers.edu <http://communis.lcsr.rutger=
s.edu/>
>>>> kernel: [294852.644801] receive_cb_reply: Got unrecognized reply: call=
dir 0x1
>>>> xpt_bc_xprt 00000000b260cf95 xid e3faa54e
>>>> Aug  8 21:51:54 communis.lcsr.rutgers.edu <http://communis.lcsr.rutger=
s.edu/>
>>>> kernel: [294921.252531] receive_cb_reply: Got unrecognized reply: call=
dir 0x1
>>>> xpt_bc_xprt 00000000b260cf95 xid f0faa54e
>>>>=20
>>>>=20
>>>> I looked at the code, and this seems to be an NFS4.1 callback. We just=
 started
>>>> seeing the problem after upgrading most of our hosts in a way that cau=
sed them
>>>> to move from NFS 4.0 to 4.2. I assume 4.2 is using the 4.1 callback. R=
ather
>>>> than disabling delegations, we=E2=80=99re moving back to NFS 4.0 on th=
e clients (except
>>>> ESXi).
>>>>=20
>>>> We=E2=80=99re using ZFS, so this isn=E2=80=99t just btrfs.
>>>>=20
>>>> I=E2=80=99m afraid I don=E2=80=99t have any backtrace. I was going to =
get more information, but
>>>> it happened late at night and we were unable to get into the system to=
 gather
>>>> information. Just had to reboot.
>>>>=20
>>>>> On Jul 5, 2021, at 5:47 AM, Timothy Pearson <tpearson@raptorengineeri=
ng.com
>>>>> <mailto:tpearson@raptorengineering.com>> wrote:
>>>>>=20
>>>>> Forgot to add -- sometimes, right before the core stall and backtrace=
, we see
>>>>> messages similar to the following:
>>>>>=20
>>>>> [16825.408854] receive_cb_reply: Got unrecognized reply: calldir 0x1 =
xpt_bc_xprt
>>>>> 0000000051f43ff7 xid 2e0c9b7a
>>>>> [16825.414070] receive_cb_reply: Got unrecognized reply: calldir 0x1 =
xpt_bc_xprt
>>>>> 0000000051f43ff7 xid 2f0c9b7a
>>>>> [16825.414360] receive_cb_reply: Got unrecognized reply: calldir 0x1 =
xpt_bc_xprt
>>>>> 0000000051f43ff7 xid 300c9b7a
>>>>>=20
>>>>> We're not sure if they are related or not.
>>>>>=20
>>>>> ----- Original Message -----
>>>>>> From: "Timothy Pearson" <tpearson@raptorengineering.com
>>>>>> <mailto:tpearson@raptorengineering.com>>
>>>>>> To: "J. Bruce Fields" <bfields@fieldses.org <mailto:bfields@fieldses=
.org>>,
>>>>>> "Chuck Lever" <chuck.lever@oracle.com <mailto:chuck.lever@oracle.com=
>>
>>>>>> Cc: "linux-nfs" <linux-nfs@vger.kernel.org <mailto:linux-nfs@vger.ke=
rnel.org>>
>>>>>> Sent: Monday, July 5, 2021 4:44:29 AM
>>>>>> Subject: CPU stall, eventual host hang with BTRFS + NFS under heavy =
load
>>>>>=20
>>>>>> We've been dealing with a fairly nasty NFS-related problem off and o=
n for the
>>>>>> past couple of years.  The host is a large POWER server with several=
 external
>>>>>> SAS arrays attached, using BTRFS for cold storage of large amounts o=
f data.
>>>>>> The main symptom is that under heavy sustained NFS write traffic usi=
ng certain
>>>>>> file types (see below) a core will suddenly lock up, continually spe=
wing a
>>>>>> backtrace similar to the one I've pasted below.  While this immediat=
ely halts
>>>>>> all NFS traffic to the affected client (which is never the same clie=
nt as the
>>>>>> machine doing the large file transfer), the larger issue is that ove=
r the next
>>>>>> few minutes / hours the entire host will gradually degrade in respon=
siveness
>>>>>> until it grinds to a complete halt.  Once the core stall occurs we h=
ave been
>>>>>> unable to find any way to restore the machine to full functionality =
or avoid
>>>>>> the degradation and eventual hang short of a hard power down and res=
tart.
>>>>>>=20
>>>>>> Tens of GB of compressed data in a single file seems to be fairly go=
od at
>>>>>> triggering the problem, whereas raw disk images or other regularly p=
atterned
>>>>>> data tend not to be.  The underlying hardware is functioning perfect=
ly with no
>>>>>> problems noted, and moving the files without NFS avoids the bug.
>>>>>>=20
>>>>>> We've been using a workaround involving purposefully pausing (SIGSTO=
P) the file
>>>>>> transfer process on the client as soon as other clients start to sho=
w a
>>>>>> slowdown.  This hack avoids the bug entirely provided the host is al=
lowed to
>>>>>> catch back up prior to resuming (SIGCONT) the file transfer process.=
  From
>>>>>> this, it seems something is going very wrong within the NFS stack un=
der high
>>>>>> storage I/O pressure and high storage write latency (timeout?) -- it=
 should
>>>>>> simply pause transfers while the storage subsystem catches up, not l=
ock up a
>>>>>> core and force a host restart.  Interesting, sometimes it does exact=
ly what it
>>>>>> is supposed to and does pause and wait for the storage subsystem, bu=
t around
>>>>>> 20% of the time it just triggers this bug and stalls a core.
>>>>>>=20
>>>>>> This bug has been present since at least 4.14 and is still present i=
n the latest
>>>>>> 5.12.14 version.
>>>>>>=20
>>>>>> As the machine is in production, it is difficult to gather further i=
nformation
>>>>>> or test patches, however we would be able to apply patches to the ke=
rnel that
>>>>>> would potentially restore stability with enough advance scheduling.
>>>>>>=20
>>>>>> Sample backtrace below:
>>>>>>=20
>>>>>> [16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
>>>>>> [16846.426202] rcu:     32-....: (5249 ticks this GP)
>>>>>> idle=3D78a/1/0x4000000000000002 softirq=3D1663878/1663878 fqs=3D1986
>>>>>> [16846.426241]  (t=3D5251 jiffies g=3D2720809 q=3D756724)
>>>>>> [16846.426273] NMI backtrace for cpu 32
>>>>>> [16846.426298] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted =
5.12.14 #1
>>>>>> [16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>>>> [16846.426406] Call Trace:
>>>>>> [16846.426429] [c000200010823250] [c00000000074e630] dump_stack+0xc4=
/0x114
>>>>>> (unreliable)
>>>>>> [16846.426483] [c000200010823290] [c00000000075aebc]
>>>>>> nmi_cpu_backtrace+0xfc/0x150
>>>>>> [16846.426506] [c000200010823310] [c00000000075b0a8]
>>>>>> nmi_trigger_cpumask_backtrace+0x198/0x1f0
>>>>>> [16846.426577] [c0002000108233b0] [c000000000072818]
>>>>>> arch_trigger_cpumask_backtrace+0x28/0x40
>>>>>> [16846.426621] [c0002000108233d0] [c000000000202db8]
>>>>>> rcu_dump_cpu_stacks+0x158/0x1b8
>>>>>> [16846.426667] [c000200010823470] [c000000000201828]
>>>>>> rcu_sched_clock_irq+0x908/0xb10
>>>>>> [16846.426708] [c000200010823560] [c0000000002141d0]
>>>>>> update_process_times+0xc0/0x140
>>>>>> [16846.426768] [c0002000108235a0] [c00000000022dd34]
>>>>>> tick_sched_handle.isra.18+0x34/0xd0
>>>>>> [16846.426808] [c0002000108235d0] [c00000000022e1e8] tick_sched_time=
r+0x68/0xe0
>>>>>> [16846.426856] [c000200010823610] [c00000000021577c]
>>>>>> __hrtimer_run_queues+0x16c/0x370
>>>>>> [16846.426903] [c000200010823690] [c000000000216378]
>>>>>> hrtimer_interrupt+0x128/0x2f0
>>>>>> [16846.426947] [c000200010823740] [c000000000029494] timer_interrupt=
+0x134/0x310
>>>>>> [16846.426989] [c0002000108237a0] [c000000000016c54]
>>>>>> replay_soft_interrupts+0x124/0x2e0
>>>>>> [16846.427045] [c000200010823990] [c000000000016f14]
>>>>>> arch_local_irq_restore+0x104/0x170
>>>>>> [16846.427103] [c0002000108239c0] [c00000000017247c]
>>>>>> mod_delayed_work_on+0x8c/0xe0
>>>>>> [16846.427149] [c000200010823a20] [c00800000819fe04]
>>>>>> rpc_set_queue_timer+0x5c/0x80 [sunrpc]
>>>>>> [16846.427234] [c000200010823a40] [c0080000081a096c]
>>>>>> __rpc_sleep_on_priority_timeout+0x194/0x1b0 [sunrpc]
>>>>>> [16846.427324] [c000200010823a90] [c0080000081a3080]
>>>>>> rpc_sleep_on_timeout+0x88/0x110 [sunrpc]
>>>>>> [16846.427388] [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0=
x468/0x530
>>>>>> [nfsd]
>>>>>> [16846.427457] [c000200010823b60] [c0080000081a0a0c] rpc_exit_task+0=
x84/0x1d0
>>>>>> [sunrpc]
>>>>>> [16846.427520] [c000200010823ba0] [c0080000081a2448] __rpc_execute+0=
xd0/0x760
>>>>>> [sunrpc]
>>>>>> [16846.427598] [c000200010823c30] [c0080000081a2b18]
>>>>>> rpc_async_schedule+0x40/0x70 [sunrpc]
>>>>>> [16846.427687] [c000200010823c60] [c000000000170bf0]
>>>>>> process_one_work+0x290/0x580
>>>>>> [16846.427736] [c000200010823d00] [c000000000170f68] worker_thread+0=
x88/0x620
>>>>>> [16846.427813] [c000200010823da0] [c00000000017b860] kthread+0x1a0/0=
x1b0
>>>>>> [16846.427865] [c000200010823e10] [c00000000000d6ec]
>>>>>> ret_from_kernel_thread+0x5c/0x70
>>>>>> [16873.869180] watchdog: BUG: soft lockup - CPU#32 stuck for 49s!
>>>>>> [kworker/u130:25:10624]
>>>>>> [16873.869245] Modules linked in: rpcsec_gss_krb5 iscsi_target_mod
>>>>>> target_core_user uio target_core_pscsi target_core_file target_core_=
iblock
>>>>>> target_core_mod tun nft_counter nf_tables nfnetlink vfio_pci vfio_vi=
rqfd
>>>>>> vfio_iommu_spapr_tce vfio vfio_spapr_eeh i2c_dev bridg$
>>>>>> [16873.869413]  linear mlx4_ib ib_uverbs ib_core raid1 md_mod sd_mod=
 t10_pi
>>>>>> hid_generic usbhid hid ses enclosure crct10dif_vpmsum crc32c_vpmsum =
xhci_pci
>>>>>> xhci_hcd ixgbe mlx4_core mpt3sas usbcore tg3 mdio_devres of_mdio fix=
ed_phy
>>>>>> xfrm_algo mdio libphy aacraid igb raid_cl$
>>>>>> [16873.869889] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted =
5.12.14 #1
>>>>>> [16873.869966] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>>>> [16873.870023] NIP:  c000000000711300 LR: c0080000081a0708 CTR: c000=
0000007112a0
>>>>>> [16873.870073] REGS: c0002000108237d0 TRAP: 0900   Not tainted  (5.1=
2.14)
>>>>>> [16873.870109] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,=
RI,LE>  CR:
>>>>>> 24004842  XER: 00000000
>>>>>> [16873.870146] CFAR: c0080000081d8054 IRQMASK: 0
>>>>>>             GPR00: c0080000081a0748 c000200010823a70 c0000000015c070=
0 c0000000e2227a40
>>>>>>             GPR04: c0000000e2227a40 c0000000e2227a40 c000200ffb6cc0a=
8 0000000000000018
>>>>>>             GPR08: 0000000000000000 5deadbeef0000122 c0080000081ffd1=
8 c0080000081d8040
>>>>>>             GPR12: c0000000007112a0 c000200fff7fee00 c00000000017b6c=
8 c000000090d9ccc0
>>>>>>             GPR16: 0000000000000000 0000000000000000 000000000000000=
0 0000000000000000
>>>>>>             GPR20: 0000000000000000 0000000000000000 000000000000000=
0 0000000000000040
>>>>>>             GPR24: 0000000000000000 0000000000000000 fffffffffffffe0=
0 0000000000000001
>>>>>>             GPR28: c00000001a62f000 c0080000081a0988 c0080000081ffd1=
0 c0000000e2227a00
>>>>>> [16873.870452] NIP [c000000000711300] __list_del_entry_valid+0x60/0x=
100
>>>>>> [16873.870507] LR [c0080000081a0708]
> >>>>> rpc_wake_up_task_on_wq_queue_action_locked+0x330/0x400 [sunrpc]
