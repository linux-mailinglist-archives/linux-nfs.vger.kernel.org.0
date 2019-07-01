Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA75C45C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2019 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfGAUkV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jul 2019 16:40:21 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:60412 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAUkV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jul 2019 16:40:21 -0400
Date:   Mon, 01 Jul 2019 20:35:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ra09.com;
        s=protonmail; t=1562013313;
        bh=slCRutQCr+bSt8I67YTwOKevmNjUSilgLHnYmublmgY=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=hoAFWOGgFvvPNEEWRS6QPQA+VJwXxzoWQ7lNumIzqbv8IFRxbuLZUwRy1JLWNLCI2
         HYdNzH/sP+Lk6jN5Ivh5CyaRyuAbikkTRAfzlR5mUlIH36oiLKjF3fLH5BcO57iMj0
         pFdsNyqTF3Q9z0TFdEiN0VAj+W2CAnf4m+3VJaAk=
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Jason Alavaliant <alavaliant@ra09.com>
Reply-To: Jason Alavaliant <alavaliant@ra09.com>
Subject: nfs kernel panic - unable to handle kernel paging request,   cgroup_sk_free
Message-ID: <PDiUGfHTuIRU73rC8oLx0lZVf5wdfW6MTgXPCZyRBGmYKeRwnWMH1ADev4aK-j4HGkYLMepA81dL41D_iGh-R_o956ZNaThcaQ2s-2uIAl0=@ra09.com>
Feedback-ID: uLnN9rORzliK3k83qizp5EatIQffMP2ZYWUMA1DIYfBBsqb3fi3cNhQ5DywAeKlI5tf4eGmsF7tjFbMr-RhZiQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I'm hoping somebody will be kind enough to confirm if the below kernel pani=
c is a known issue or not.
I've been searching the list history and I see mention of several reports m=
entioning pbf, cgroups and memory corruption but nothing with a panic that =
seems to match the one I'm seeing exactly.

What I have been able to confirm is;
* occurs on both kernel 4.14 and 4.19 (haven't tested beyond that - I'd sus=
pect more kernel versions are effected)
* only if I'm sharing a volume using the nfs-kernel-server and a client is =
accessing it   (doesn't occur with nfs-kernel-server version 1.2.8 on ubunt=
u 16.04,  only with 1.3.4 (which I use on ubuntu 18.04) )
* does not occur if I switch machines to the ganesha nfs server (replacing =
nfs-kernel-server).

Beyond that despite having several hundred of these kernel panics on machin=
es at the company I'm at.  I've not been able to isolate an reproducible wa=
y to trigger the kernel panic on demand.

[38258.193887] BUG: unable to handle kernel paging request at ffff888c8be54=
980
[38258.193906] IP: cgroup_sk_free+0x3a/0x80
[38258.193909] PGD 25c8067 P4D 25c8067 PUD 0
[38258.193916] Oops: 0002 [#1] PREEMPT SMP PTI
[38258.193920] Modules linked in: tcp_diag inet_diag iptable_filter nvidia_=
uvm(POE) nfnetlink_queue nfnetlink_log nfnetlink bluetooth ecdh_generic nfs=
v3 vtsspp(OE) sep4_1(OE) socperf2_0(OE) pax(OE) talpa_vfshook(OE) talpa_ped=
connector(OE) talp
a_pedevice(OE) talpa_vcdevice(OE) talpa_core(OE) talpa_linux(OE) talpa_sysc=
allhook(OE) xwbios(OE) binfmt_misc snd_hda_codec_hdmi nvidia_drm(POE) nvidi=
a_modeset(POE) coretemp kvm_intel kvm nvidia(POE) gpio_ich iTCO_wdt irqbypa=
ss hp_wmi iTCO_ven
dor_support wmi_bmof sparse_keymap snd_hda_codec_realtek snd_hda_codec_gene=
ric ghash_clmulni_intel pcbc snd_hda_intel snd_hda_codec aesni_intel snd_hd=
a_core aes_x86_64 snd_hwdep crypto_simd snd_pcm glue_helper cryptd drm_kms_=
helper snd_seq_mid
i snd_seq_midi_event serio_raw drm snd_rawmidi snd_seq lpc_ich ipmi_devintf=
 snd_seq_device
[38258.193985]  ipmi_msghandler snd_timer fb_sys_fops syscopyarea sysfillre=
ct sysimgblt snd soundcore shpchp wmi mac_hid sch_fq_codel taniwha(OE) nfs =
nfsd fscache nfs_acl lockd parport_pc grace ppdev auth_rpcgss lp sunrpc par=
port ip_tables x_t
ables autofs4 hid_generic mptsas psmouse mptscsih mptbase firewire_ohci ahc=
i tg3 firewire_core scsi_transport_sas libahci crc_itu_t ptp pps_core flopp=
y
[38258.194016] CPU: 4 PID: 0 Comm: swapper/4 Tainted: P          IOE   4.14=
.103-weta-20190225 #1
[38258.194018] Hardware name: Hewlett-Packard HP Z800 Workstation/0AECh, BI=
OS 786G5 v03.61 03/05/2018
[38258.194020] task: ffff888c141d8000 task.stack: ffffc900062d4000
[38258.194023] RIP: 0010:cgroup_sk_free+0x3a/0x80
[38258.194025] RSP: 0018:ffff888c2f603ab0 EFLAGS: 00010246
[38258.194027] RAX: 000000005c854980 RBX: ffff8886128ccc00 RCX: 00000000000=
00000
[38258.194029] RDX: 0000000000000000 RSI: 0000000000010080 RDI: 00000000000=
00001
[38258.194031] RBP: ffff888c2f603ab8 R08: 0000000000000001 R09: ffffffff816=
d457f
[38258.194033] R10: ffff888c2f603b10 R11: 0000000000000000 R12: ffff888bb25=
8f800
[38258.194035] R13: 0000000000000000 R14: ffff888bb2662c24 R15: ffff888bb25=
8f800
[38258.194038] FS:  0000000000000000(0000) GS:ffff888c2f600000(0000) knlGS:=
0000000000000000
[38258.194040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[38258.194042] CR2: ffff888c8be54980 CR3: 000000000220a003 CR4: 00000000000=
206e0
[38258.194043] Call Trace:
[38258.194046]  <IRQ>
[38258.194054]  __sk_destruct+0xf5/0x160
[38258.194057]  sk_destruct+0x20/0x30
[38258.194059]  __sk_free+0x1b/0xa0
[38258.194061]  sk_free+0x1f/0x30
[38258.194066]  sock_put+0x1a/0x20
[38258.194069]  tcp_v4_rcv+0x9a5/0xa80
[38258.194074]  ? ___bpf_prog_run+0x410/0x11f0
[38258.194080]  ip_local_deliver_finish+0x6e/0x250
[38258.194082]  ip_local_deliver+0xe5/0xf0
[38258.194085]  ? ip_rcv_finish+0x430/0x430
[38258.194088]  ip_rcv_finish+0xe7/0x430
[38258.194091]  ip_rcv+0x28f/0x3d0
[38258.194096]  ? packet_rcv+0x44/0x430
[38258.194100]  __netif_receive_skb_core+0x402/0xb90
[38258.194105]  ? tcp4_gro_receive+0x137/0x1a0
[38258.194108]  __netif_receive_skb+0x18/0x60
[38258.194110]  ? __netif_receive_skb+0x18/0x60
[38258.194113]  netif_receive_skb_internal+0x31/0x110
[38258.194115]  napi_gro_receive+0xe5/0x110
[38258.194122]  tg3_poll_work+0x817/0xec0 [tg3]
[38258.194127]  tg3_poll+0x6b/0x390 [tg3]
[38258.194130]  net_rx_action+0x139/0x3a0
[38258.194136]  __do_softirq+0xe9/0x2d7
[38258.194142]  irq_exit+0x99/0xa0
[38258.194144]  do_IRQ+0xa6/0x100
[38258.194148]  common_interrupt+0x81/0x81
[38258.194149]  </IRQ>
[38258.194153] RIP: 0010:cpuidle_enter_state+0xa5/0x310
[38258.194155] RSP: 0018:ffffc900062d7e88 EFLAGS: 00000202 ORIG_RAX: ffffff=
ffffffff9c
[38258.194158] RAX: ffff888c2f600000 RBX: 000000000001df10 RCX: 00000000000=
0001f
[38258.194160] RDX: 000022cbae0dded5 RSI: ffffffff82055221 RDI: ffffffff820=
82b25
[38258.194162] RBP: ffffc900062d7ec8 R08: 0000000000000004 R09: 00000000000=
20c80
[38258.194163] R10: ffffc900062d7e60 R11: 0000539304a379fa R12: ffff888c2f6=
2a000
[38258.194165] R13: 0000000000000004 R14: ffffffff822c3f18 R15: 00000000000=
00000
[38258.194169]  ? cpuidle_enter_state+0x97/0x310
[38258.194172]  cpuidle_enter+0x17/0x20
[38258.194176]  call_cpuidle+0x23/0x40
[38258.194178]  do_idle+0x18f/0x1e0
[38258.194181]  cpu_startup_entry+0x1d/0x20
[38258.194185]  start_secondary+0x143/0x160
[38258.194188]  secondary_startup_64+0xa5/0xb0
[38258.194191] Code: c3 70 4c 53 82 a8 01 75 07 48 85 c0 48 0f 45 d8 f6 43 =
6c 01 74 03 5b 5d c3 bf 01 00 00 00 e8 ee 4f f8 ff 48 8b 43 18 a8 03 75 20 =
<65> 48 ff 08 bf 01 00 00 00 e8 48 4b f8 ff 65 8b 05 81 53 f0 7e
[38258.194225] RIP: cgroup_sk_free+0x3a/0x80 RSP: ffff888c2f603ab0
[38258.194226] CR2: ffff888c8be54980


Thanks
Jason

