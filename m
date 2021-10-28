Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1138A43E4AE
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhJ1POT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 11:14:19 -0400
Received: from mail-bn7nam10on2095.outbound.protection.outlook.com ([40.107.92.95]:48736
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230406AbhJ1POT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 Oct 2021 11:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okv0ORWZ/WIw4jbdD/HYTe4ndNC3i/YG80B9fgz0V2N0syoYNcoBTn/mlKkcq179hQZj+Tw+O6bV4qMjX2Up44fadXQ2ANplSwvuTCFY1bLNntsqxZePNHh3+KbdYFrC+ZDT2uHM9aZPfa85LCEOMnZe08SpVpjm/rOCQotapwabYnRVb3a4IvorPYL8OcxcBiA+PdViXMqKLP6PttgJKljnE8GBgj51BqY8Iv02XCehtBWuzCgazCmUT6QqdQY6D7YjQGwGH7XRuMno9N1sMEkyS3r5A5D2CyAIUzpajB07WDeTN4GZnIWEA+yTfzeunT+tG4fZb9bxT9mX2OZpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyxaiTjcqRsoZn9ZyIFBtW/RQiCClGEafNFAMa1JvR8=;
 b=Sb4KFKOHmY82T/bxiGV7q09KgV0Ir2APcBlgOAAALpm/08QjAHEtBWlTlhUNM+Uw5iniC7/JQyojfsvlv5FXjFR5sWcombmf5Tb5e8xPVvtx4rZuoFVCyO2Uwwr8NZZaW6GKzJrV55PB/7hRrZkVmqO7mIDq4CFe/d87RtHVJqqhNmJR7cUf4Oue0MrARogq/+QnXgeRyfjgOK2tqpEzPWFemzZN03+2mjVRAaMI5yiXiBvy/tAVLhN9/TMu5Sp0Di3LWmv8JC2JmP5pDpJYcoMj+A0qyizzVPD9CL900AGJkPm5n8JHl2S7PtuIwlkmPn4CPyjLLUwvZJqncVSaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyxaiTjcqRsoZn9ZyIFBtW/RQiCClGEafNFAMa1JvR8=;
 b=G2p+kpZ9ha9uiNru64WfDBN/Q5bwXPHSjGmeDsVxH+TzT9C2etDlY9JuqE2WR4nyfIna1Pejwa/nY3PueSNaLarDz1vzfSF0UMvreBfT5G/C13zkddIitgwDKVDypb5aUDVXEZu6w7cAsgbat+1abxP4Dyeg5ciClMzOi/xsG6A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB3936.namprd14.prod.outlook.com (2603:10b6:208:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 15:11:50 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::a4c4:e5de:c2a9:914b]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::a4c4:e5de:c2a9:914b%2]) with mapi id 15.20.4649.014; Thu, 28 Oct 2021
 15:11:50 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: odd problem, with backtrace
Message-Id: <F793F50C-5A56-4E03-9DA8-1A12707F802B@rutgers.edu>
Date:   Thu, 28 Oct 2021 11:11:49 -0400
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-ClientProxiedBy: MN2PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:160::17) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by MN2PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:160::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5 via Frontend Transport; Thu, 28 Oct 2021 15:11:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762cc1d9-3247-4826-4e3a-08d99a25449d
X-MS-TrafficTypeDiagnostic: MN2PR14MB3936:
X-Microsoft-Antispam-PRVS: <MN2PR14MB39365BC0EDFF70AC483F79AEAA869@MN2PR14MB3936.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSmherZA0aJZ4u4VlSTtz609OMXrO+F4XPG//utcELq6XD9d72YDWrK6p7e1VLmacdhg+KyfJPzxjkuiSiSL7tRFyJhdh9v5BfbWrsnhFYQX2s9/LFRH+dLdFvpRtBGPSbTLZroBOR0PQAEf++g58LKNZA+wJvCIMJadTNVNjUEVi1K6mRaK+CKGR3kVmvcorQwTal4zR7jRQiYf55vKGluELN4vs3BSUvWNd4OM1XiIQAj+r5Y5ikfRhif7pPptWXowLQ/7GsbnPqTo6Pl081naBCObn38K5kuZ29V68vHx0uz0lpe5naPZBbr8A3bx//nG+UeyeqZLgAexm8YbFa9nFT6oJ5mO1SvT+PIZm/RwMWj58FM8dW+q390Dpd5ckvoZb37mqcQODkOnlRZXLzCmbHV5NpTHuUdl09XmDruc1Tk+F3a/p8ZPg+z1yzehATiqML/rP61Ebl6eXZUy5ocw++riz31n4jJYyUKH9EONwEzfdl/pfC/9NgdTVmXUoAjLeFrZUL1aVar6aORg2vx0R6Ruy1eUOaOKiw1qrT9tTDFXWBsb7ozCwg9Nh6MjHaDLpwrlY9ZAsSEamu18dWTFfiihltH2AehsnDaPrt7SgF9oWqwQ8/Fe3tXjCPyfTyxrHvKcyhK6FYBNkOulpW+G+xoEUfJ5anZF0mWnHX0zIDzdy61zxgAiHKcZA9URkYYRCOQZRRKzpTQXbhkUfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(2616005)(52116002)(6512007)(45080400002)(83380400001)(186003)(66556008)(508600001)(38100700002)(66476007)(66946007)(75432002)(6486002)(8676002)(6506007)(8936002)(786003)(316002)(5660300002)(86362001)(2906002)(33656002)(6916009)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TysxWTFaUnNsUENEVWRHQ3FIN0FGK0poTXk4T1o5RjNpRm9yeGhHRkNTRGFz?=
 =?utf-8?B?Rkl1WXpzRVRJaUhiRlI5eitrQWdLaEwwWFV4SkF6TDdJZEM1dnBrNWpkV0Ru?=
 =?utf-8?B?RUZEWlF3WjNEbWo5Rk9JdmNkc3FucHZXUThUdmFMeGJna0EzMFBGMGJRRmRJ?=
 =?utf-8?B?MmJkNlJ4UjBlUmFVN2w4eDI2VlFzN294cjVXU2w4aVRPV0VLek5WTlBZZE5F?=
 =?utf-8?B?QWNpV1c1R3VSUUFjZ29RcmRPelZKUktQYyt0U1JNM0R2Z3BhdkF5cWdud0U5?=
 =?utf-8?B?SjBmQUM3OTVtTEwxR0trWXVrOXZablF1R21JNlV2OEVSUkFNUytvWmlvNkYw?=
 =?utf-8?B?bWxTbUJjSHJJTlFsY1I5YXlGMGJCTGRLYWpIdld6TSt3bWVXaGpvVEFYeWha?=
 =?utf-8?B?YzJyVEZnMkhEMThkOW5yenFDVCt6eDJzZFR5NHUwMzJpbGJqZzFLNkQvUC9l?=
 =?utf-8?B?bDdpYkx0aDM5WUNCdjN6a1NFdFFOYmMrYWxobnljTWZtTVVzOEhCS1k5YXF4?=
 =?utf-8?B?em9sQXJmNmgzMUtIbExGQ3FEclNTVW9WQkMxK215a1JOTGh3a3gyS2pvdUF6?=
 =?utf-8?B?OG5uZXNyUDFoK0xPYW1MMnlNS1BkODVNWFM2VlNubkJldlkxZ3hzMjM3cDZw?=
 =?utf-8?B?RVFjUVZQVUFFbGNqRFdCV2Y4dnl2SEJuK1NjRXZZS2tmOXhoNnU1ZmJJZVJY?=
 =?utf-8?B?VEt6U3FBV3BEdk1lSlk0aHpGLzZoTERteDlXQnl3SkM5V2taT1pGT0lzaGdT?=
 =?utf-8?B?OWFCMnpRTXJqM3VNSjg2SkNNamY3QWpQeW5JR1RBc1dRRXI0eWl1ZHcxZUpr?=
 =?utf-8?B?NGtpVy9aSG9CM0pzYVZpUEN2eVNwVWJsQnFxcU1JeGdsVEZ6VU1JSzNuTXZq?=
 =?utf-8?B?QXpyZWtMTGh2QzUyTjFMT215RFk4MTBpWGJvelkxc1g1YThuOFdlazJDYlgv?=
 =?utf-8?B?NUJra0NFaTBwYmd6M1p2NnBXci8waUZ4aWk3ZnB3MWVhUXQyajFacEZkQkVT?=
 =?utf-8?B?UFNoZ3JxMXZFN3Q0VzJtcUJQN3JOYVdiWVNoVHQ3SGtZcXAydUZBbEluR3Ru?=
 =?utf-8?B?MlhQZFIraTRFakpscU1iZnY2NzFRZGtRUkxneXhmRlV3UlloTXd6RC93cFJF?=
 =?utf-8?B?alRLODhFZ3gxQjJlM05MaXh2dTR2WE9KVTVrWDVQeDBOWFJJQ1lCTGx0UElR?=
 =?utf-8?B?RnJKRHZLTk0zR2RESjMrR0RFMjFUaVZUZkpUM0ovdktsMExQNW1ESzBEQVI3?=
 =?utf-8?B?dnVaaFR5aXJkSE9ZbUJwbEEwM1hibU1PSjlzeHRmM3ZiSWxwN2VQL2JPU0JN?=
 =?utf-8?B?dEZYanp0dTZjVGhWQWozZkJEdGljNXo4cXJEVEVZdGlLYXBDRy9saFRQWEh0?=
 =?utf-8?B?aHdkczJlTnR2Yzh3Ujh0UHI3L3FqT0REa29KWmlSZnQ5a2FEZ1Bvc2szYjlk?=
 =?utf-8?B?c24wMXl2K0pMV2M3a082TzhBOFJibWZHMmE3anFoRTJFdFdRZTBJMEw1aUtB?=
 =?utf-8?B?a0VjU3lWbGZoK1luMkl3cGNnbVArcTZCbXl6MHJwUldqM2lHTEZDck9waytZ?=
 =?utf-8?B?RzJQQWhzdERsejM0M3hneHlMS29aOU9sQXJ5UG9lVWFKcm91QXhsY2crU3Zo?=
 =?utf-8?B?eDFMTGlKRDIzLzhGVDVsczBEaVdvOTJiOEJmRzRYVkZ3NkNiK2pUTStvV2Z3?=
 =?utf-8?B?M0pvWFByQnkwUDZWeHhScTZOdWNiT1FEODFnN1VnYVZQME1hV2JFS0xZNlF2?=
 =?utf-8?B?YnZma2xyU2hvbERaWFVMQ1YzaGZlTVJlL1gyQWsrK3YwSjd3ZThPQzRxU0lT?=
 =?utf-8?B?VlNuNVlZdTZiOTFNSnNMMWdBQjA3Ymt1TndhcDZoZzZ4UFdCN3dvT1pxd1hk?=
 =?utf-8?B?WjZnR3pDY3FTNE9yMW5IRWNYWXBZSkc2ZmhmRVZadCsyMXBhRTI2NytRdnpO?=
 =?utf-8?B?QnIyb2RpZklLcGFTSWR5VnNENTBJY2JmZW9qTjZGU1ZmTUltR2RnUWd4Y3RY?=
 =?utf-8?B?bU1kTHdCamxuSGJrZHlqaHFzZlZzemhRejdkRk1sblAxK2VlTXRaTlp6dGti?=
 =?utf-8?B?NXAyRHNwUnczaWEwN05QWCtjNllWVEIvYnJJa1lNUGFJSjhqQjV0M0EvUlc0?=
 =?utf-8?B?TWRFNEE1RmFNQ1lVV1M5RjhJSlVTM2ZqR1dnTVpiYndIT2tnV2NhZUJmaDBZ?=
 =?utf-8?Q?iZyyryPtA0/hbSFwzV4NLxaMcjWGtaw1hxhzSggtihBh?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 762cc1d9-3247-4826-4e3a-08d99a25449d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 15:11:50.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8TqIsnMV2HWErZ1x6C+WM9E+W0iEexYfasQSOBdNy4IfIbAmmS2irjAwsEqgaQFRPbyhX5tCikXVfK72NQv2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3936
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I=E2=80=99m sending this just in case anyone finds it useful.

We had an episode where two systems hung. Processes on two different system=
s hung. One was in Chrome, trying to do an NFS write. The other I couldn=E2=
=80=99t tell.

We rebooted both machines, but neither could do NFS mount from the server i=
nvolved. Other systems were using it just fine.

I did =E2=80=9Csystemctl restart nfs-server=E2=80=9D, and got the following=
:

Oct 28 10:56:47 communis.lcsr.rutgers.edu systemd[1]: Stopped ZFS file syst=
em shares.
Oct 28 10:56:47 communis.lcsr.rutgers.edu systemd[1]: Stopping ZFS file sys=
tem shares...
Oct 28 10:56:47 communis.lcsr.rutgers.edu systemd[1]: Stopping NFS server a=
nd services...
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050410] --------=
----[ cut here ]------------
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050437] WARNING:=
 CPU: 55 PID: 1201295 at fs/nfsd/nfs4state.c:1966 free_client+0\
xd3/0xe0 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050437] Modules =
linked in: nfsv3 nfsv4 nfs fscache cpuid binfmt_misc ufs qnx4 h\
fsplus hfs minix ntfs msdos jfs xfs algif_hash af_alg rpcsec_gss_krb5 nls_i=
so8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua int\
el_rapl_msr intel_rapl_common isst_if_common skx_edac nfit x86_pkg_temp_the=
rmal intel_powerclamp coretemp zfs(PO) kvm_intel zunicode(PO) k\
vm zlua(PO) zavl(PO) icp(PO) rapl zcommon(PO) znvpair(PO) ipmi_ssif spl(O) =
intel_cstate mei_me joydev input_leds mei ioatdma ipmi_si ipmi_\
devintf ipmi_msghandler acpi_pad acpi_power_meter mac_hid sch_fq_codel nfsd=
 nfs_acl lockd auth_rpcgss grace sunrpc ip_tables x_tables auto\
fs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async=
_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath l\
inear nvme nvme_core i40e hid_generic usbhid hid raid1 ast drm_vram_helper =
i2c_algo_bit crct10dif_pclmul crc32_pclmul ghash_clmulni_intel \
ttm drm_kms_helper aesni_intel crypto_simd syscopyarea sysfillrect cryptd s=
ysimgblt ixgbe
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050477]  glue_he=
lper fb_sys_fops xfrm_algo dca drm vmd ahci i2c_i801 mdio lpc_i\
ch libahci wmi
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050485] CPU: 55 =
PID: 1201295 Comm: nfsd Kdump: loaded Tainted: P           O   \
   5.4.0-74-generic #83-Ubuntu
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050486] Hardware=
 name: Supermicro SYS-2029U-TN24R4T/X11DPU, BIOS 3.3a 07/21/202\
0
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050497] RIP: 001=
0:free_client+0xd3/0xe0 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050499] Code: c0=
 e8 21 6f ab d8 48 8d bb f8 03 00 00 f0 ff 8b f8 03 00 00 0f 88\
 e5 73 01 00 75 05 e8 c6 f8 ff ff 5b 41 5c 41 5d 41 5e 5d c3 <0f> 0b eb 8a =
66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 f0
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050500] RSP: 001=
8:ffffaf920d2ebd60 EFLAGS: 00010202
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050502] RAX: 000=
0000000000001 RBX: ffff95f2dffe8510 RCX: ffff95f2dffe8878
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050502] RDX: fff=
f95f2dffe8878 RSI: 000000000000000d RDI: ffff95e531513400
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050503] RBP: fff=
faf920d2ebd80 R08: 0000000000000000 R09: ffff95f43f9e9a80
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050504] R10: fff=
f95f43f9d7848 R11: 0000000000000000 R12: ffff95f2dffe8878
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050505] R13: dea=
d000000000122 R14: dead000000000100 R15: ffff95f2dffe8510
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050506] FS:  000=
0000000000000(0000) GS:ffff95f43f9c0000(0000) knlGS:00000000000\
00000
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050507] CS:  001=
0 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050508] CR2: 000=
07f7e0305a014 CR3: 000000036d410002 CR4: 00000000007606e0
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050509] DR0: 000=
0000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050509] DR3: 000=
0000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050510] PKRU: 55=
555554
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050510] Call Tra=
ce:
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050523]  __destr=
oy_client+0x1a6/0x1f0 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050533]  nfs4_st=
ate_shutdown_net+0x130/0x210 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050540]  nfsd_sh=
utdown_net+0x2d/0x60 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050546]  nfsd_la=
st_thread+0x106/0x120 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050571]  ? svc_c=
lose_net+0x50/0x160 [sunrpc]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050584]  svc_shu=
tdown_net+0x33/0x40 [sunrpc]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050590]  nfsd_de=
stroy+0x38/0x60 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050597]  nfsd+0x=
127/0x150 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050603]  kthread=
+0x104/0x140
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050609]  ? nfsd_=
destroy+0x60/0x60 [nfsd]
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050611]  ? kthre=
ad_park+0x90/0x90
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050614]  ret_fro=
m_fork+0x1f/0x40
Oct 28 10:56:47 communis.lcsr.rutgers.edu kernel: [6955369.050616] ---[ end=
 trace d13cddb172dc312c ]---
Oct 28 10:56:48 communis.lcsr.rutgers.edu kernel: [6955369.331866] nfsd: la=
st server has exited, flushing export cache
Oct 28 10:56:48 communis.lcsr.rutgers.edu systemd[1]: nfs-server.service: S=
ucceeded.

This is Ubuntu 20.04, 5.4.0-74-generic  All mounts are NFS 4.2.

We=E2=80=99ve disabled Chrome for the moment pending investigation. I=E2=80=
=99m trying to avoid going back to NFS 4.0, but may eventually be forced to=
.

