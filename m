Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7761E2B9092
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKSLC6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 06:02:58 -0500
Received: from mail-dm6nam11on2111.outbound.protection.outlook.com ([40.107.223.111]:48416
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgKSLC5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Nov 2020 06:02:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT6ofxGhcTn0EEnqdV2VbXip3czCZeQqLsmDj+bMHlpCNzFOCSr7IDg92Rmd9q6Dw9cFTvgtoKpz5MltvWsyG+oUPONWz1fnhcK+LmvQiteqg5VJd/neX9ljHs/hTjgU8cUcDufDfJYPSaW3RzdL3G1Qn9KoNuzI17jK04pOqIhra91z4mT4q5ZSCThA2LZUISYdAGfqt+04/Em18JkTB+TkDdKk4LVgUgii0rrGUeFCa+d5S5YG3pD97FY96LpJOwSXzMWz86up230XT9g8x72NGTbOnFlCeP+iRnw/u3iNJiq5Nsgq5c3DmODdYpD0vQ2p/wNz4aC66EeKUtucSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy9HoLRL7mNjMUxwSDXynNta1WlSm2baMuIHMTAxu4Q=;
 b=lO/Kwc4isX8uaVZKAjv0akEy5cmgUapGsyh+EOtmVu3hPqoHKuXsJH2vSMAUZ5faz+8QA25I75ILuy1em3FXv2tDbqynsIsguubFJu3gRsIwWEOHdccK2++gBYSvBCMhdPojFDgR2AZxIGjiwHMOFltn06w183iPZZ5EQLH01T8H3zG7fuiOHoOH7vGLRUmek2mEsLb7CaJvGDaZp8dwD47Kbq9K5hNqs7TLTkGIvj1TF9NIh7H+SwOumqIIK6S97+sHZNhY/WuvV+mkhDrqFVlCR/rZ7naSI0FQ2fbhkTR2nAc+I2/eDKCMHNo9jYEfrd8J+TfSHJVW7BP2a+1j/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tintri.com; dmarc=pass action=none header.from=tintri.com;
 dkim=pass header.d=tintri.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Tintri.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy9HoLRL7mNjMUxwSDXynNta1WlSm2baMuIHMTAxu4Q=;
 b=HUxGF5yjV5DYxhFGW5hOhb1g27PIEOULeKEVtY71zGMx+pduPXGtkGt7pv3mPtxc894S9NxKVpixKkCp350xwmWDkdKAjKKCyEP8hrjXgeH616Np8DNOpxeavNqh7t+vXfCY01aFkiaGoH2hNhZ9RL7QWXvRbMNs5ChMup1Xjws=
Received: from BY5PR11MB4152.namprd11.prod.outlook.com (2603:10b6:a03:191::11)
 by BY5PR11MB4370.namprd11.prod.outlook.com (2603:10b6:a03:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Thu, 19 Nov
 2020 11:02:54 +0000
Received: from BY5PR11MB4152.namprd11.prod.outlook.com
 ([fe80::94f0:8429:77a2:738]) by BY5PR11MB4152.namprd11.prod.outlook.com
 ([fe80::94f0:8429:77a2:738%6]) with mapi id 15.20.3541.028; Thu, 19 Nov 2020
 11:02:54 +0000
From:   Suresh Jayaraman <sjayaraman@tintri.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Kernel panic at nfs4_select_rw_stateid
Thread-Topic: Kernel panic at nfs4_select_rw_stateid
Thread-Index: AQHWvmHEhS7lC4rThEK29ckD9f6PfQ==
Date:   Thu, 19 Nov 2020 11:02:53 +0000
Message-ID: <BY5PR11MB4152E8FCCB193D20EBB9BF86B8E00@BY5PR11MB4152.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=tintri.com;
x-originating-ip: [106.200.227.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5ee2afb-ca82-493b-ea42-08d88c7aaa1b
x-ms-traffictypediagnostic: BY5PR11MB4370:
x-microsoft-antispam-prvs: <BY5PR11MB4370D7D71021BCADBE19486EB8E00@BY5PR11MB4370.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+gbwQJtnla90D+GCB3E3iwlmFaxgNkWS5nR84wFOpsDNN4xS23Rzql9k90/3GORi/ePMoAu3mconccALQm2Eo0kM3PLD6AN4DxGaH0oKg1n8Sz4671psmqtMmTaYVQ9LSCzkeoeLXp3hfvtEDW+l9xZ4aFayAOkfqpc6tAOXVneDQ9IsB+AARbm1rMDPvLqr5dwzueWM0KRofcyF7CXjIj2oyn+Gv8IEmPqnd8ipEsaLGkJkooNisf5OrqXP5GC7mDh0U5o6fr+5Ckpwsi6/l84g/L+kmbglg0+PlipUzscfP063xsd3Pu3VjlNiRQ3eHOxQlDQ0SndzPGmzluyw7u46NWHeBkoXjaLUTaEV4SL9tCjbDqClwoBYqj2p0PI2gULHzOxRkl7+vRFAo0HOkMzT8faqXqLwX9tPcMont0ieGjtYoZbXmAND/dxXF1HPWm2UgtlV6uaJmggi6Je6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4152.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39850400004)(55016002)(91956017)(316002)(86362001)(5660300002)(4326008)(76116006)(8676002)(26005)(83380400001)(2906002)(64756008)(66476007)(66556008)(52536014)(66446008)(66946007)(8936002)(9686003)(6506007)(478600001)(7696005)(45080400002)(6916009)(54906003)(71200400001)(966005)(33656002)(186003)(56380200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xeL7Dve5y/4zWbH7HdjrMfOQaNyMp3gQY5a3jaNWk78YmB+jCKEJNK3uJ2fzHz8H/E/VxC74EJOKgg3ENx146QBDlEs/OpyVTBluKerFuGPjH2KQmHNfO8Vf10Bsk1g2s3bjHAEAMoghSuH91tmZgYk0/GxFqInZtPG6UFz+MSSOYmfht6Ez6N1z4y/Qk7D749402vg9u6Zgwo86wSqJaoLOWUyzj80DCcseX7Rxjr8dOamp9hLMAXtU5vkaBNu/8RQeKQb/Tgk8+rimLgAMB8qE6HL0CgY5pESxOlLm/yVWbG/hu6Kk/rxE6im00gg1WVgR0Wug2eAG7r8fvJFBtrQsAVcDzq4OVlHYh1Gh90MKLXtTrr9Y89EbFlXg3T4rD9HbNmQFa/ZfgOKdqgVl38Mcijr2CLHtaUM4DNildpG5TGQyF0e+lSBmdCWmAWk4smpLUud7OhsEVY34LakVTRES7sS6kpDj/e0V3BEjFVq79okJjDh5CO+bH3j23b1snRui/3xrdiln761IUkYWBZgTNmEiOyeRtQF2Z8BrGinxiraL315e+bfV6Cyt8jZEibCMzhbIAw9MFGKzdHMqOpkxVQyW2gKrkVRJ974Z4Gwo7tx8aoUrRgigzsRrZdnsYmM7zsJhfgFTUnyQ7Zci8m2NZUcscpsx6XBmTw5wgN/S1rmvccy97k4X141F/15+P1vFuH1pfapQLnXLTf86k+wTOdlu87BG9QWnqPag1YoyqLxF6KQnyZl8YD9BDjhRJVY0Vr0rfkY44I+39aNDU97DZx60U8c35+osSO/QJxsEw968xlx8+BERVIxPee6s6r6wbyHCN2hSVzB61C3noXZT3ZAL2umBQzcjXIeMLsvstFweJltJbeO4eIs/9g+wLbVWvKIpuczIrtu0FahVXw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Tintri.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4152.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ee2afb-ca82-493b-ea42-08d88c7aaa1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 11:02:53.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7aa633be-c8f9-43fe-aff7-41aa956c6e9e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8R8kFuB6FAoxvYnxoxVoPK5SQpQGqFCdrKTtVxB0LY/24KdWhExxGnJvTpmnUYNFiAbws96BBqJEqEFyASaAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4370
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,=0A=
=0A=
We have a report of an NFSv4.1 client crash in kernel version 4.18 (CentOS =
8.2) with the IntelliFlash NFSv41 server. =0A=
=0A=
[95480.028498] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000050 =0A=
[95480.028550] PGD 0 P4D 0 =0A=
[95480.028570] Oops: 0000 [#1] SMP PTI =0A=
[95480.028591] CPU: 37 PID: 504425 Comm: kworker/u98:1 Kdump: loaded Tainte=
d: G OE --------- - - 4.18.0-193.14.2.el8_2.x86_64 #1 =0A=
[95480.028648] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, B=
IOS P89 10/21/2019 =0A=
[95480.028717] Workqueue: rpciod rpc_async_schedule [sunrpc] =0A=
[95480.028763] RIP: 0010:nfs4_select_rw_stateid+0x64/0x180 [nfsv4] =0A=
[95480.028792] Code: 41 89 f6 48 89 fb 48 85 d2 0f 84 f6 00 00 00 48 8b 47 =
40 a8 01 0f 84 ea 00 00 00 48 8b 42 18 4c 8b 7a 20 4c 8d 67 48 4c 89 e7 <48=
> 8b 50 40 48 89 54 24 08 e8 4e 8e 77 f6 48 8b 54 24 08 4c 89 fe =0A=
[95480.028877] RSP: 0018:ffffb4cd225a7dc0 EFLAGS: 00010202 =0A=
[95480.028903] RAX: 0000000000000010 RBX: ffff8dd23bee4180 RCX: ffff8dcfb54=
276c8 =0A=
[95480.028936] RDX: ffff8d5400b69980 RSI: 0000000000000001 RDI: ffff8dd23be=
e41c8 =0A=
[95480.028972] RBP: ffffb4cd225a7e00 R08: 0000000000000000 R09: 0000646f696=
37072 =0A=
[95480.029006] R10: 8080808080808080 R11: ffff8dd27f968bc0 R12: ffff8dd23be=
e41c8 =0A=
[95480.029040] R13: ffff8dcfb54276c8 R14: 0000000000000001 R15: ffff8dd24af=
fa940 =0A=
[95480.029073] FS: 0000000000000000(0000) GS:ffff8dd27f940000(0000) knlGS:0=
000000000000000 =0A=
[95480.029111] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 =0A=
[95480.029140] CR2: 0000000000000050 CR3: 0000005a5a60a005 CR4: 00000000001=
626e0 =0A=
[95480.029175] Call Trace: =0A=
[95480.029206] ? nfs4_setup_sequence+0x36/0x190 [nfsv4] =0A=
[95480.029246] ? rpc_exit+0x30/0x30 [sunrpc] =0A=
[95480.029280] ? __rpc_atrun+0x20/0x20 [sunrpc] =0A=
[95480.029314] nfs4_proc_pgio_rpc_prepare+0x5c/0x80 [nfsv4] =0A=
[95480.029357] nfs_pgio_prepare+0x2d/0x40 [nfs] =0A=
[95480.029390] __rpc_execute+0x85/0x340 [sunrpc] =0A=
[95480.029418] ? finish_task_switch+0xd7/0x2b0 =0A=
[95480.029454] rpc_async_schedule+0x29/0x40 [sunrpc] =0A=
[95480.029482] process_one_work+0x1a7/0x3b0 =0A=
[95480.029504] worker_thread+0x30/0x390 =0A=
[95480.029524] ? create_worker+0x1a0/0x1a0 =0A=
[95480.029547] kthread+0x112/0x130 =0A=
[95480.029567] ? kthread_flush_work_fn+0x10/0x10 =0A=
[95480.029593] ret_from_fork+0x35/0x40 =0A=
[95480.029615] Modules linked in: vport_stt(OE) vhost_net vhost tap act_pol=
ice cls_u32 sch_ingress cls_fw sch_sfq sch_htb tun rpcsec_gss_krb5 auth_rpc=
gss nfsv4 dns_resolver nfs lockd grace fscache binfmt_misc xt_CT nft_counte=
r nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib ip6_tables ip_tables nft_c=
ompat nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_ta=
bles_set openvswitch(OE) nft_chain_nat_ipv6 nf_conntrack_ipv6 nf_nat_ipv6 n=
f_defrag_ipv6 udp_tunnel nft_chain_route_ipv6 nft_chain_nat_ipv4 nf_conntra=
ck_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack nft_chain_route_ipv4=
 ip_set nf_tables nfnetlink sunrpc intel_rapl_msr intel_rapl_common sb_edac=
 x86_pkg_temp_thermal intel_powerclamp coretemp vfat fat kvm_intel kvm irqb=
ypass ipmi_ssif iTCO_wdt iTCO_vendor_support crct10dif_pclmul crc32_pclmul =
ghash_clmulni_intel intel_cstate intel_uncore ipmi_si intel_rapl_perf ipmi_=
devintf i2c_i801 ioatdma pcspkr ipmi_msghandler lpc_ich hpwdt hpilo dca acp=
i_tad wmi acpi_power_meter ext4 =0A=
[95480.029655] mbcache jbd2 sd_mod sg mgag200 drm_vram_helper ttm bnx2x i2c=
_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm =
mdio hpsa(O) libcrc32c scsi_transport_sas crc32c_intel dm_mirror dm_region_=
hash dm_log dm_mod [last unloaded: ip_tables] =0A=
[95480.032776] CR2: 0000000000000050=0A=
=0A=
[root@centos8-vm3 ~]# gdb /usr/lib/debug/usr/lib/modules/4.18.0-193.el8.x86=
_64/kernel/fs/nfs/nfsv4.ko.debug=0A=
GNU gdb (GDB) Red Hat Enterprise Linux 8.2-11.el8=0A=
...=0A=
Reading symbols from /usr/lib/debug/usr/lib/modules/4.18.0-193.el8.x86_64/k=
ernel/fs/nfs/nfsv4.ko.debug...done.=0A=
(gdb) list *(nfs4_select_rw_stateid+0x64)=0A=
0x200f4 is in nfs4_select_rw_stateid (fs/nfs/nfs4state.c:998).=0A=
993=0A=
994		if (test_bit(LK_STATE_IN_USE, &state->flags) =3D=3D 0)=0A=
995			goto out;=0A=
996=0A=
997		fl_owner =3D l_ctx->lockowner;=0A=
998		fl_flock_owner =3D l_ctx->open_context->flock_owner;   <=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D HERE=0A=
999=0A=
1000		spin_lock(&state->state_lock);=0A=
1001		lsp =3D __nfs4_find_lock_state(state, fl_owner, fl_flock_owner);=0A=
1002		if (lsp && test_bit(NFS_LOCK_LOST, &lsp->ls_flags)) =0A=
=0A=
It appears that l_ctx->open_context becomes invalid prematurely resulting i=
n a NULL pointer dereference. nfs4_copy_lock_stateid() already ensured that=
 l_ctx (lock context) is not null.=0A=
=0A=
Looking at the NFS client changelog the following fix looked relevant, but =
4.18 already includes this fix. Looking further, it doesn't look like the i=
ssue is fixed in mainline.=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/f=
s/nfs/inode.c?id=3D154945112dac10b7109d816275f3e4896b0b064e=0A=
author	Trond Myklebust <trondmy@gmail.com>=0A=
NFS: Ensure that all nfs lock contexts have a valid open context=0A=
Force the lock context to keep a reference to the parent open context so th=
at we can guarantee the validity of the latter.=0A=
=0A=
This issue was seen multiple times in a virtualized setup that is running m=
ultiple VMs on KVM and hard to reproduce at will.=0A=
Is this a known issue fixed in recent kernels? Any other debugging informat=
ion that could help to track down this issue?=0A=
=0A=
Thanks,=0A=
Suresh=
