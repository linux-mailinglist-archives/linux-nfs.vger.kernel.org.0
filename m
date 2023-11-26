Return-Path: <linux-nfs+bounces-75-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B67F9314
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 15:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E6C1C20C01
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26584D26E;
	Sun, 26 Nov 2023 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWlTwPws"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F163BC8
	for <linux-nfs@vger.kernel.org>; Sun, 26 Nov 2023 06:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701008602; x=1732544602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I9M2EdrusCdxfAavjq67JQoSrsc4PejnNf215/C00ZY=;
  b=WWlTwPwse6/gIMPlfyfwih0UC4uPtXprKzQI0Xoit9gORJ2AWIpFUjbi
   KqmrdbrzOcyvCd0izDFWUrLtN9eLl1BDUKJakruoTXarQR44KbfojyOvW
   AWLZeHVjknyuLZYqcIBId0P2ZAPDa12f2gWGdCiIV9kB0yLroHpZxkzG0
   ymEysLbHn1Efjst3mt/IyE/ZIfpw1zc3fwqif9/nF+9WJkgh197P77ITA
   6YAvxuqPvvJ34QltE9tnNPGA0bu7qwKbgZKS/tvRF9tXvggdLJvIdgmMO
   6yUudmj2iyyli0Vb/G2DdCFg+9LFDnnvYctuLzGX52XUCX8Uf3cIbJx3/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="396475397"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="396475397"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 06:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="767928459"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="767928459"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 06:23:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 06:23:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 06:23:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 06:23:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwbCo6VBwUHTtOJHbg/VXsk16JxRCaj1nnkXub502TbgIENxXGXFhUTIoac5V3UQ+lddNcBkDuuzcDzUU5lMPk3c4pRrrFMsf6PB2wIFXnJLa17R5rV2RX2v7DqZVrSanvdOXyPWy62N1rlcabbog6pEM9lNADyjgBa01r/KWSeuLrA9s3F+hECKFCAcAaXZhY+Ma9gepGaJzcBb7tMF9FgnFNsQrMj8LfxPDq/DbTZeSOBw7lT+E1Mk8ZayN09cI8NH8Qjl0E11H8dpBJKmimDLBbEzBF2SSDArmA1ZFqa/4a3WPSPHmKrM4Bw5UToyRjkT+gFQXWTP7qJsLxIpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgFyOPqGB8YmmPyTjhj+YHJECOyKh9ymllq8wCZub+c=;
 b=jEGyOxzCgUb/Ah2c70NuIJU2dN4Robniy9jsFQVH/XaTJg6qVHkdpQGfFpIXM2UHuimMYyOnfnmtZlhewZ5gvIWEyymWckOUD4h90MSArgumLJY73qUrfHSVVtNphWGH9ytUA1TuijUImk7cZ3+6rtaKbM+Uly8jvSXFnG6AYqcRsa3VOqQZ5PX8CxS7XTGlsvdW1fXLUL8fBnzgJXI/dg9d5OLeqZfl2ITfe8pIN753R3AHxnAtBQ3Cgeicx+CTHxdWYwkrQFkfv3np6zy9U/beXPH+nDHPKwWq2x3L1MbaYDi/5yaCEoKcic7zygvSybuLG5/Lfdep8i6FmZHrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 14:23:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Sun, 26 Nov 2023
 14:23:17 +0000
Date: Sun, 26 Nov 2023 22:23:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, <linux-nfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [jlayton:kdevops] [nfsd]  59119280b2:
 WARNING:at_fs/nfsd/nfs4state.c:#nfs4_free_deleg[nfsd]
Message-ID: <202311262158.f7bcb59d-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e3f4af-6118-42fe-fd6c-08dbee8b3ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMZaWel5DAwq8vXV0gGJHzzXqPff7iLnmxO545DLytnl/WdN9zFWdvtK5KrrpV/E7K3PJ3s59x+qQlAgxp79s7dwnMIeAR4u6YmlDEwMu2JcI2ODwZAM+i1QpisiCpXiXhuv0ma4NDKvS2A62U9v9dUqSbuzs2sFikmR3kZivd+dO3Vw0OcTYYIJH60IbJAU440nZ3CqclCu6Xk5ZPboScgaNBl/zmeMFbLzOk+U0Yb+iEhxGEnZtFzeLIL0n69DPYSCgVnOf3SMk03n6dHl4vguKKgrtmDzf+LUOq99umK6ez/yLhphVB8UhKyAuAcgHDiXr/n8fhtzlNIiq3nFMEMvK2T1n9qw01BcOfUZDxj4kzcyBsF3AtdhKa6vZCDc9TqGLmvzLkYmjY4pR1pE2EplfX1va6KwwT/jFIL9oji3zEd4dLqNItrUNKLnaku65ocPA5lNHqC2rcXOaNpBgFEhVUCSz+uStibZtcZ2AEEj3cBAuKasjsyFW7kdCuN69rzKypzZ0kCImaoixyf6O48dtsMOzBj+7ihkXaWPDjO+CzU5ZsxUsZn1r8SOfUhQDAB2HS0LpvmhGxkeFL8+M2F7xa9X9DseLzNWov2Qs0jAh4qIdXXJltyECuLdYhB7qZPuK2gOY4svZhOvg6Km/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(2616005)(107886003)(26005)(1076003)(6666004)(45080400002)(6512007)(6506007)(82960400001)(8936002)(8676002)(4326008)(86362001)(5660300002)(966005)(6486002)(478600001)(6916009)(316002)(66476007)(66556008)(66946007)(38100700002)(83380400001)(2906002)(30864003)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67NUCb/ivF9th4dIzSpH0+PTVDE3FkA8wg9EhvapC/0DQfLt9VU1macf0ohD?=
 =?us-ascii?Q?7+X2z0oVpzNaDDhN/4UJbKzi9HW33RMJVgZ6Pg1/LszME6wyRNLfx4HDeGk3?=
 =?us-ascii?Q?/hdWr6FSO7s3hxGJ8AbgMZddh8MeJS0Yx0LM7i6IXO1owu9keXQ+vhzuFQUz?=
 =?us-ascii?Q?2HYMcgGlVSETaiUfVJudKkM2Oo5cWQZ5QOmUpcFeCEXN6UbeaAibIYvPCX/d?=
 =?us-ascii?Q?UmWPB1qz/BM9SFnlZTwUyCZ5eOmjxiPThgFwQjPTCmRKObv0KmfShY31nJVN?=
 =?us-ascii?Q?wQJdGEG8lcL6mVzmUbzKrSbmrvYv33b8RWakipFNRSbahpyw6Lr+P/CWxORN?=
 =?us-ascii?Q?Tet2YkBOJTMm/TohITzWvVtleiYWcLg8kp75qAFptnwfobkd4fgI6T2xwcHt?=
 =?us-ascii?Q?ft7MeM9XR8YKD+3Z5S+msCXl+trC+nFMaZQjL1cuEKxLC4RfksxjqYSgegCB?=
 =?us-ascii?Q?o1FV4AE7zhYeosMsNJ91reqyuLFioNg8cPRzVTB/OJZ7GZvcaqJdi+sA65Ym?=
 =?us-ascii?Q?uGQAaxJhAKlkE0sdb1tSKk0/bcHB2WO+5sdn5O+QHWy7G5bZ6R7GxVwhUQ6f?=
 =?us-ascii?Q?Ch4NzhdfsL0axZ/KSSTkgh9Y3491mnCl5HQ5z43gP9rfru4UcvxzC52fbBpj?=
 =?us-ascii?Q?U+AwFPpGg1JqjTToHwuhWhtMObaRJv/tSeWbhfVVIJc74f8/AkigIbdAybXc?=
 =?us-ascii?Q?ZU/XgFoun3fWeowLp9Fgyezb4fK4QIwwoZnw8KzUU5RWyIjX9yZ1rsNc9kV8?=
 =?us-ascii?Q?BV3D6HOogfll1Lfo37b+pZeL4IAcC4zKBgdiwXJnWRAGasFcoXQwSS4wKaNT?=
 =?us-ascii?Q?+xT7IMziVXMq9xU/rEgeqbZKotO/Ooz0zvvvIgo0gHVTYL7ubguZtqKvf64v?=
 =?us-ascii?Q?h1BN8NkWXylE7/zljFddpKxQgwMCzcKfjb2oEkNJEe/kedPqyppL8SC5fGdB?=
 =?us-ascii?Q?PNxduC89aCua+opSO2AL05OmmCgm7q+SUCkBQ1D5yta1v0v3Ff35uPLgAwvj?=
 =?us-ascii?Q?8VGQ7JMp/EP9q0NE/FYHMLmkE4O+e301DAB8CjZRShkjzBGI4ogrljqL/bZv?=
 =?us-ascii?Q?osamemVdwpqcaBXz7YMkJkOUIpffXJ1wIqLJGzU7nmfDeL+ifngixItc8zPp?=
 =?us-ascii?Q?AiGRRdimWjY6uUA9EjE4fhUf4grwqpjGhQDDsCEDVQGxsP6XTQ2YUHVLe68y?=
 =?us-ascii?Q?oG8UmEr5tYmeVC+XPBFepvO/8rZ8I2pcrACkjPOli5TZLDfCX+LLS+F0SGAI?=
 =?us-ascii?Q?jWU6vbUGbB4gdqDqtccteXICcPXDpEf7DomI3QL7GLcQi8BkZvNbQPZJtuO7?=
 =?us-ascii?Q?EE5nF/uhOCPG/4mBXxOM7QQeuzDeYEOshirGYiqjfi6swbqEjldV/nEmYL4e?=
 =?us-ascii?Q?Tm+QG2apSotN1y2krsmtcfZpwjvLHbMmH6ejJbepzytPpoI728u1RaVTK/if?=
 =?us-ascii?Q?9UQlCoYcG6yqDRpRLt8V3xLa6tUYntVR0EC2RbHcPHM2h4ziGqlUHsSqNrVo?=
 =?us-ascii?Q?VNa7D76J9oWHOWVLm80utnDNmzuTJqAZH6qrgpsMlg+Bv+pQbgh8nRkSHzRH?=
 =?us-ascii?Q?K1+wxhqjY8O5Hpd5GLGTT4IeJgM/WQTaczapRrVJvPCLh0qVf/T2ZGQUiMqn?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e3f4af-6118-42fe-fd6c-08dbee8b3ba6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 14:23:17.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5If989uodUQJ6m6QPe1OXyj/YsI+95HCmfbTAXVD29ZqtHyfAF0gbhHUJMHTvfuRV6QYZVt2gMtdmtWblF/O9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/nfsd/nfs4state.c:#nfs4_free_deleg[nfsd]" on:

commit: 59119280b27517466283f5af16ac639ef557b043 ("nfsd: allow delegation state ids to be revoked and then freed")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git kdevops

in testcase: postmark
version: postmark-x86_64-1.53-0_20220517
with following parameters:

	disk: 1HDD
	fs: ext4
	fs1: nfsv4
	number: 5000n
	trans: 30000s
	subdirs: 100d
	cpufreq_governor: performance



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311262158.f7bcb59d-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231126/202311262158.f7bcb59d-oliver.sang@intel.com


[  431.926136][ T2773] ------------[ cut here ]------------
[  431.931417][ T2773] WARNING: CPU: 7 PID: 2773 at fs/nfsd/nfs4state.c:1075 nfs4_free_deleg+0x68/0xb0 [nfsd]
[  431.941055][ T2773] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod ipmi_devintf ipmi_msghandler btrfs intel_rapl_msr blake2b_generic intel_rapl_common xor raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft kvm crc64 sg irqbypass i915 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper drm_kms_helper rapl ttm mei_wdt ahci intel_cstate wmi_bmof libahci video mei_me i2c_i801 intel_uncore i2c_designware_platform mei idma64 i2c_smbus libata joydev i2c_designware_core wmi intel_pmc_core acpi_pad drm fuse ip_tables
[  432.000509][ T2773] CPU: 7 PID: 2773 Comm: nfsd Not tainted 6.7.0-rc1-00019-g59119280b275 #1
[  432.008883][ T2773] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  432.016929][ T2773] RIP: 0010:nfs4_free_deleg+0x68/0xb0 [nfsd]
[  432.022776][ T2773] Code: 75 46 48 8b 3d 89 4c 03 00 e8 34 49 49 c0 f0 48 ff 0d 64 4c 03 00 c3 cc cc cc cc 0f 0b 48 8b 56 48 48 8d 46 48 48 39 c2 74 be <0f> 0b 48 8b 56 58 48 8d 46 58 48 39 c2 74 bc 0f 0b 48 8b 56 68 48
[  432.042104][ T2773] RSP: 0018:ffffc900007e3ce0 EFLAGS: 00010283
[  432.047995][ T2773] RAX: ffff8888075391d0 RBX: ffff888807539188 RCX: 0000000000000000
[  432.055786][ T2773] RDX: ffff888154805598 RSI: ffff888807539188 RDI: ffff888807539188
[  432.063576][ T2773] RBP: ffff888814310de0 R08: ffff88880fd35a68 R09: ffff888814310ac0
[  432.071369][ T2773] R10: ffffc900007e3cb0 R11: ffffc900007e3cb8 R12: ffff888814310a80
[  432.079155][ T2773] R13: ffff888154805560 R14: ffffc900007e3d50 R15: ffff8888143fa028
[  432.086961][ T2773] FS:  0000000000000000(0000) GS:ffff8887c05c0000(0000) knlGS:0000000000000000
[  432.095680][ T2773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  432.102088][ T2773] CR2: 00007fa2e8a8d000 CR3: 000000081ca18005 CR4: 00000000003706f0
[  432.109889][ T2773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  432.117688][ T2773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  432.125472][ T2773] Call Trace:
[  432.128600][ T2773]  <TASK>
[  432.131383][ T2773]  ? nfs4_free_deleg+0x68/0xb0 [nfsd]
[  432.136624][ T2773]  ? __warn+0x81/0x130
[  432.140522][ T2773]  ? nfs4_free_deleg+0x68/0xb0 [nfsd]
[  432.145764][ T2773]  ? report_bug+0x15d/0x1b0
[  432.150095][ T2773]  ? handle_bug+0x3c/0x70
[  432.154265][ T2773]  ? exc_invalid_op+0x17/0x70
[  432.158764][ T2773]  ? asm_exc_invalid_op+0x1a/0x20
[  432.163610][ T2773]  ? nfs4_free_deleg+0x68/0xb0 [nfsd]
[  432.168851][ T2773]  nfs4_put_stid+0x6e/0xb0 [nfsd]
[  432.173747][ T2773]  nfsd4_lookup_stateid+0x117/0x130 [nfsd]
[  432.179417][ T2773]  nfsd4_delegreturn+0xa8/0x170 [nfsd]
[  432.184747][ T2773]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  432.190333][ T2773]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  432.195317][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.200120][ T2773]  svc_process_common+0x2f5/0x5f0
[  432.204967][ T2773]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  432.210545][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.215348][ T2773]  svc_process+0x131/0x170
[  432.219591][ T2773]  svc_handle_xprt+0x4b0/0x5b0
[  432.224181][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.228986][ T2773]  svc_recv+0x17e/0x2f0
[  432.232981][ T2773]  nfsd+0x77/0xf0 [nfsd]
[  432.237095][ T2773]  kthread+0xcd/0x130
[  432.240905][ T2773]  ? __pfx_kthread+0x10/0x10
[  432.245340][ T2773]  ret_from_fork+0x31/0x70
[  432.249584][ T2773]  ? __pfx_kthread+0x10/0x10
[  432.254000][ T2773]  ret_from_fork_asm+0x1b/0x30
[  432.258588][ T2773]  </TASK>
[  432.261448][ T2773] ---[ end trace 0000000000000000 ]---
[  432.266729][ T2773] ------------[ cut here ]------------
[  432.272001][ T2773] WARNING: CPU: 7 PID: 2773 at fs/nfsd/nfs4state.c:1076 nfs4_free_deleg+0x77/0xb0 [nfsd]
[  432.281633][ T2773] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod ipmi_devintf ipmi_msghandler btrfs intel_rapl_msr blake2b_generic intel_rapl_common xor raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft kvm crc64 sg irqbypass i915 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper drm_kms_helper rapl ttm mei_wdt ahci intel_cstate wmi_bmof libahci video mei_me i2c_i801 intel_uncore i2c_designware_platform mei idma64 i2c_smbus libata joydev i2c_designware_core wmi intel_pmc_core acpi_pad drm fuse ip_tables
[  432.342363][ T2773] CPU: 7 PID: 2773 Comm: nfsd Tainted: G        W          6.7.0-rc1-00019-g59119280b275 #1
[  432.352660][ T2773] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  432.361183][ T2773] RIP: 0010:nfs4_free_deleg+0x77/0xb0 [nfsd]
[  432.367532][ T2773] Code: 48 ff 0d 64 4c 03 00 c3 cc cc cc cc 0f 0b 48 8b 56 48 48 8d 46 48 48 39 c2 74 be 0f 0b 48 8b 56 58 48 8d 46 58 48 39 c2 74 bc <0f> 0b 48 8b 56 68 48 8d 46 68 48 39 c2 74 ba 0f 0b eb b6 66 66 2e
[  432.387816][ T2773] RSP: 0018:ffffc900007e3ce0 EFLAGS: 00010283
[  432.394210][ T2773] RAX: ffff8888075391e0 RBX: ffff888807539188 RCX: 0000000000000000
[  432.402467][ T2773] RDX: ffff888807538520 RSI: ffff888807539188 RDI: ffff888807539188
[  432.410705][ T2773] RBP: ffff888814310de0 R08: ffff88880fd35a68 R09: ffff888814310ac0
[  432.418929][ T2773] R10: ffffc900007e3cb0 R11: ffffc900007e3cb8 R12: ffff888814310a80
[  432.427153][ T2773] R13: ffff888154805560 R14: ffffc900007e3d50 R15: ffff8888143fa028
[  432.435424][ T2773] FS:  0000000000000000(0000) GS:ffff8887c05c0000(0000) knlGS:0000000000000000
[  432.444598][ T2773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  432.451440][ T2773] CR2: 00007fa2e8a8d000 CR3: 000000081ca18005 CR4: 00000000003706f0
[  432.459635][ T2773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  432.467847][ T2773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  432.476047][ T2773] Call Trace:
[  432.479614][ T2773]  <TASK>
[  432.482816][ T2773]  ? nfs4_free_deleg+0x77/0xb0 [nfsd]
[  432.488466][ T2773]  ? __warn+0x81/0x130
[  432.492786][ T2773]  ? nfs4_free_deleg+0x77/0xb0 [nfsd]
[  432.498449][ T2773]  ? report_bug+0x15d/0x1b0
[  432.503248][ T2773]  ? handle_bug+0x3c/0x70
[  432.507831][ T2773]  ? exc_invalid_op+0x17/0x70
[  432.512754][ T2773]  ? asm_exc_invalid_op+0x1a/0x20
[  432.518007][ T2773]  ? nfs4_free_deleg+0x77/0xb0 [nfsd]
[  432.523612][ T2773]  nfs4_put_stid+0x6e/0xb0 [nfsd]
[  432.528894][ T2773]  nfsd4_lookup_stateid+0x117/0x130 [nfsd]
[  432.534947][ T2773]  nfsd4_delegreturn+0xa8/0x170 [nfsd]
[  432.540669][ T2773]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  432.546617][ T2773]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  432.551980][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.557183][ T2773]  svc_process_common+0x2f5/0x5f0
[  432.562465][ T2773]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  432.568443][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.573623][ T2773]  svc_process+0x131/0x170
[  432.578320][ T2773]  svc_handle_xprt+0x4b0/0x5b0
[  432.583361][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.588567][ T2773]  svc_recv+0x17e/0x2f0
[  432.592967][ T2773]  nfsd+0x77/0xf0 [nfsd]
[  432.597485][ T2773]  kthread+0xcd/0x130
[  432.601708][ T2773]  ? __pfx_kthread+0x10/0x10
[  432.606551][ T2773]  ret_from_fork+0x31/0x70
[  432.611274][ T2773]  ? __pfx_kthread+0x10/0x10
[  432.616095][ T2773]  ret_from_fork_asm+0x1b/0x30
[  432.621086][ T2773]  </TASK>
[  432.624365][ T2773] ---[ end trace 0000000000000000 ]---
[  432.630051][ T2773] ------------[ cut here ]------------
[  432.635729][ T2773] WARNING: CPU: 7 PID: 2773 at fs/nfsd/nfs4state.c:598 put_nfs4_file+0x5c/0x70 [nfsd]
[  432.645518][ T2773] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod ipmi_devintf ipmi_msghandler btrfs intel_rapl_msr blake2b_generic intel_rapl_common xor raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft kvm crc64 sg irqbypass i915 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper drm_kms_helper rapl ttm mei_wdt ahci intel_cstate wmi_bmof libahci video mei_me i2c_i801 intel_uncore i2c_designware_platform mei idma64 i2c_smbus libata joydev i2c_designware_core wmi intel_pmc_core acpi_pad drm fuse ip_tables
[  432.706995][ T2773] CPU: 7 PID: 2773 Comm: nfsd Tainted: G        W          6.7.0-rc1-00019-g59119280b275 #1
[  432.717352][ T2773] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  432.725840][ T2773] RIP: 0010:put_nfs4_file+0x5c/0x70 [nfsd]
[  432.731956][ T2773] Code: 48 39 c2 75 29 48 8b 43 38 48 8d 7b 38 48 39 c7 75 18 48 c7 c6 50 a1 f6 c0 5b e9 2f f0 23 c0 be 03 00 00 00 5b e9 a4 53 7d c0 <0f> 0b eb e4 0f 0b eb d3 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
[  432.752213][ T2773] RSP: 0018:ffffc900007e3d00 EFLAGS: 00010283
[  432.758570][ T2773] RAX: ffff8888075391d0 RBX: ffff888154805560 RCX: 0000000000000041
[  432.766808][ T2773] RDX: ffff8881548055a8 RSI: 00000000cccccccd RDI: ffff888154805598
[  432.775045][ T2773] RBP: 0000000000000000 R08: ffff88880fd35a68 R09: ffff888814310ac0
[  432.783331][ T2773] R10: ffffc900007e3cb0 R11: ffffc900007e3cb8 R12: 0000000000000004
[  432.791559][ T2773] R13: 000000003f270000 R14: ffffc900007e3d50 R15: ffff8888143fa028
[  432.799783][ T2773] FS:  0000000000000000(0000) GS:ffff8887c05c0000(0000) knlGS:0000000000000000
[  432.808951][ T2773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  432.815796][ T2773] CR2: 00007fa2e8a8d000 CR3: 000000081ca18005 CR4: 00000000003706f0
[  432.824016][ T2773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  432.832298][ T2773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  432.840518][ T2773] Call Trace:
[  432.844077][ T2773]  <TASK>
[  432.847349][ T2773]  ? put_nfs4_file+0x5c/0x70 [nfsd]
[  432.852843][ T2773]  ? __warn+0x81/0x130
[  432.857209][ T2773]  ? put_nfs4_file+0x5c/0x70 [nfsd]
[  432.862713][ T2773]  ? report_bug+0x15d/0x1b0
[  432.867468][ T2773]  ? handle_bug+0x3c/0x70
[  432.872041][ T2773]  ? exc_invalid_op+0x17/0x70
[  432.876950][ T2773]  ? asm_exc_invalid_op+0x1a/0x20
[  432.882233][ T2773]  ? put_nfs4_file+0x5c/0x70 [nfsd]
[  432.887705][ T2773]  nfsd4_lookup_stateid+0x117/0x130 [nfsd]
[  432.893765][ T2773]  nfsd4_delegreturn+0xa8/0x170 [nfsd]
[  432.899490][ T2773]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  432.905489][ T2773]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  432.910860][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.916056][ T2773]  svc_process_common+0x2f5/0x5f0
[  432.921345][ T2773]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  432.927348][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.932553][ T2773]  svc_process+0x131/0x170
[  432.937277][ T2773]  svc_handle_xprt+0x4b0/0x5b0
[  432.942342][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  432.947543][ T2773]  svc_recv+0x17e/0x2f0
[  432.951945][ T2773]  nfsd+0x77/0xf0 [nfsd]
[  432.956461][ T2773]  kthread+0xcd/0x130
[  432.960684][ T2773]  ? __pfx_kthread+0x10/0x10
[  432.965518][ T2773]  ret_from_fork+0x31/0x70
[  432.970174][ T2773]  ? __pfx_kthread+0x10/0x10
[  432.974998][ T2773]  ret_from_fork_asm+0x1b/0x30
[  432.979995][ T2773]  </TASK>
[  432.983301][ T2773] ---[ end trace 0000000000000000 ]---
[  432.989139][ T2773] ------------[ cut here ]------------
[  432.994788][ T2773] refcount_t: addition on 0; use-after-free.
[  433.001003][ T2773] WARNING: CPU: 3 PID: 2773 at lib/refcount.c:25 refcount_warn_saturate+0x9b/0x130
[  433.010488][ T2773] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod ipmi_devintf ipmi_msghandler btrfs intel_rapl_msr blake2b_generic intel_rapl_common xor raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft kvm crc64 sg irqbypass i915 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper drm_kms_helper rapl ttm mei_wdt ahci intel_cstate wmi_bmof libahci video mei_me i2c_i801 intel_uncore i2c_designware_platform mei idma64 i2c_smbus libata joydev i2c_designware_core wmi intel_pmc_core acpi_pad drm fuse ip_tables
[  433.072022][ T2773] CPU: 3 PID: 2773 Comm: nfsd Tainted: G        W          6.7.0-rc1-00019-g59119280b275 #1
[  433.082412][ T2773] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  433.090906][ T2773] RIP: 0010:refcount_warn_saturate+0x9b/0x130
[  433.097288][ T2773] Code: 01 01 e8 48 48 9a ff 0f 0b c3 cc cc cc cc 80 3d 54 c9 80 01 00 75 a8 48 c7 c7 58 f9 73 82 c6 05 44 c9 80 01 01 e8 25 48 9a ff <0f> 0b c3 cc cc cc cc 80 3d 30 c9 80 01 00 75 85 48 c7 c7 88 f9 73
[  433.117589][ T2773] RSP: 0018:ffffc900007e3c08 EFLAGS: 00010282
[  433.123941][ T2773] RAX: 0000000000000000 RBX: ffff888807539188 RCX: 0000000000000000
[  433.132213][ T2773] RDX: ffff8887c04e8c00 RSI: ffff8887c04dc740 RDI: ffff8887c04dc740
[  433.140458][ T2773] RBP: ffff888154805574 R08: 0000000000000000 R09: ffffc900007e3a98
[  433.148671][ T2773] R10: 0000000000000003 R11: ffffffff82dd8f88 R12: ffff888814ab00d8
[  433.156900][ T2773] R13: ffff888154805560 R14: ffff888101a57290 R15: 000000010002ae91
[  433.165130][ T2773] FS:  0000000000000000(0000) GS:ffff8887c04c0000(0000) knlGS:0000000000000000
[  433.174343][ T2773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  433.181247][ T2773] CR2: 000055a9c30d9e18 CR3: 000000081ca18003 CR4: 00000000003706f0
[  433.189463][ T2773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  433.197652][ T2773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  433.205853][ T2773] Call Trace:
[  433.209413][ T2773]  <TASK>
[  433.212618][ T2773]  ? refcount_warn_saturate+0x9b/0x130
[  433.218355][ T2773]  ? __warn+0x81/0x130
[  433.222691][ T2773]  ? refcount_warn_saturate+0x9b/0x130
[  433.228399][ T2773]  ? report_bug+0x15d/0x1b0
[  433.233144][ T2773]  ? prb_read_valid+0x1b/0x30
[  433.238057][ T2773]  ? handle_bug+0x3c/0x70
[  433.242617][ T2773]  ? exc_invalid_op+0x17/0x70
[  433.247540][ T2773]  ? asm_exc_invalid_op+0x1a/0x20
[  433.252795][ T2773]  ? refcount_warn_saturate+0x9b/0x130
[  433.258488][ T2773]  ? refcount_warn_saturate+0x9b/0x130
[  433.264175][ T2773]  nfsd_break_deleg_cb+0x161/0x170 [nfsd]
[  433.270212][ T2773]  __break_lease+0x22f/0x6b0
[  433.275035][ T2773]  vfs_unlink+0xe0/0x2b0
[  433.279516][ T2773]  nfsd_unlink+0x18a/0x330 [nfsd]
[  433.284799][ T2773]  nfsd4_remove+0x4f/0xb0 [nfsd]
[  433.289999][ T2773]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  433.295973][ T2773]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  433.301363][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  433.306575][ T2773]  svc_process_common+0x2f5/0x5f0
[  433.311840][ T2773]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  433.317819][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  433.323021][ T2773]  svc_process+0x131/0x170
[  433.327679][ T2773]  svc_handle_xprt+0x4b0/0x5b0
[  433.332674][ T2773]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  433.337868][ T2773]  svc_recv+0x17e/0x2f0
[  433.342297][ T2773]  nfsd+0x77/0xf0 [nfsd]
[  433.346799][ T2773]  kthread+0xcd/0x130
[  433.351022][ T2773]  ? __pfx_kthread+0x10/0x10
[  433.355847][ T2773]  ret_from_fork+0x31/0x70
[  433.360502][ T2773]  ? __pfx_kthread+0x10/0x10
[  433.365357][ T2773]  ret_from_fork_asm+0x1b/0x30
[  433.370366][ T2773]  </TASK>
[  433.373618][ T2773] ---[ end trace 0000000000000000 ]---
[  523.923299][   T66] list_del corruption. prev->next should be ffff8888075391d0, but was 0000000000000000. (prev=ffff888154805598)
[  523.935302][   T66] ------------[ cut here ]------------
[  523.941019][   T66] kernel BUG at lib/list_debug.c:62!
[  523.946593][   T66] invalid opcode: 0000 [#1] SMP PTI
[  523.951983][   T66] CPU: 2 PID: 66 Comm: kworker/u16:4 Tainted: G        W          6.7.0-rc1-00019-g59119280b275 #1
[  523.962807][   T66] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  523.971268][   T66] Workqueue: nfsd4 laundromat_main [nfsd]
[  523.977268][   T66] RIP: 0010:__list_del_entry_valid_or_report+0xa7/0xf0
[  523.984344][   T66] Code: a2 ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 58 04 74 82 e8 ad 7b a2 ff 0f 0b 48 89 fe 48 89 c2 48 c7 c7 90 04 74 82 e8 99 7b a2 ff <0f> 0b 48 89 d1 48 c7 c7 e0 04 74 82 48 89 f2 48 89 c6 e8 82 7b a2
[  524.004473][   T66] RSP: 0018:ffffc900002bbdb0 EFLAGS: 00010246
[  524.010730][   T66] RAX: 000000000000006d RBX: ffff888807539188 RCX: 0000000000000000
[  524.018872][   T66] RDX: 0000000000000000 RSI: ffff8887c049c740 RDI: ffff8887c049c740
[  524.027011][   T66] RBP: ffff888154805574 R08: 0000000000000000 R09: ffffc900002bbc58
[  524.035149][   T66] R10: 0000000000000003 R11: ffffffff82dd8f88 R12: ffff8888075391d0
[  524.043335][   T66] R13: ffff8888075391f0 R14: ffff88881d7708b0 R15: ffff88881d7708b0
[  524.051512][   T66] FS:  0000000000000000(0000) GS:ffff8887c0480000(0000) knlGS:0000000000000000
[  524.060589][   T66] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  524.067380][   T66] CR2: 0000000000451c00 CR3: 000000081ca18005 CR4: 00000000003706f0
[  524.075549][   T66] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  524.083669][   T66] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  524.091783][   T66] Call Trace:
[  524.095297][   T66]  <TASK>
[  524.098467][   T66]  ? die+0x36/0xb0
[  524.102414][   T66]  ? do_trap+0xda/0x130
[  524.106736][   T66]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  524.113125][   T66]  ? do_error_trap+0x65/0xb0
[  524.117875][   T66]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  524.124313][   T66]  ? exc_invalid_op+0x50/0x70
[  524.129145][   T66]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  524.135571][   T66]  ? asm_exc_invalid_op+0x1a/0x20
[  524.140747][   T66]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  524.147128][   T66]  unhash_delegation_locked+0xb0/0x130 [nfsd]
[  524.153422][   T66]  nfs4_laundromat+0x54c/0x6b0 [nfsd]
[  524.158972][   T66]  laundromat_main+0x19/0x70 [nfsd]
[  524.164399][   T66]  process_one_work+0x173/0x330
[  524.169457][   T66]  worker_thread+0x27f/0x3b0
[  524.174239][   T66]  ? __pfx_worker_thread+0x10/0x10
[  524.179554][   T66]  kthread+0xcd/0x130
[  524.183698][   T66]  ? __pfx_kthread+0x10/0x10
[  524.188496][   T66]  ret_from_fork+0x31/0x70
[  524.193068][   T66]  ? __pfx_kthread+0x10/0x10
[  524.197815][   T66]  ret_from_fork_asm+0x1b/0x30
[  524.202735][   T66]  </TASK>
[  524.205930][   T66] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod ipmi_devintf ipmi_msghandler btrfs intel_rapl_msr blake2b_generic intel_rapl_common xor raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft kvm crc64 sg irqbypass i915 crct10dif_pclmul crc32_pclmul crc32c_intel drm_buddy ghash_clmulni_intel intel_gtt sha512_ssse3 drm_display_helper drm_kms_helper rapl ttm mei_wdt ahci intel_cstate wmi_bmof libahci video mei_me i2c_i801 intel_uncore i2c_designware_platform mei idma64 i2c_smbus libata joydev i2c_designware_core wmi intel_pmc_core acpi_pad drm fuse ip_tables
[  524.267205][   T66] ---[ end trace 0000000000000000 ]---
[  524.272869][   T66] RIP: 0010:__list_del_entry_valid_or_report+0xa7/0xf0
[  524.279975][   T66] Code: a2 ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 58 04 74 82 e8 ad 7b a2 ff 0f 0b 48 89 fe 48 89 c2 48 c7 c7 90 04 74 82 e8 99 7b a2 ff <0f> 0b 48 89 d1 48 c7 c7 e0 04 74 82 48 89 f2 48 89 c6 e8 82 7b a2
[  524.300191][   T66] RSP: 0018:ffffc900002bbdb0 EFLAGS: 00010246
[  524.306554][   T66] RAX: 000000000000006d RBX: ffff888807539188 RCX: 0000000000000000
[  524.314807][   T66] RDX: 0000000000000000 RSI: ffff8887c049c740 RDI: ffff8887c049c740
[  524.323077][   T66] RBP: ffff888154805574 R08: 0000000000000000 R09: ffffc900002bbc58
[  524.331358][   T66] R10: 0000000000000003 R11: ffffffff82dd8f88 R12: ffff8888075391d0
[  524.339619][   T66] R13: ffff8888075391f0 R14: ffff88881d7708b0 R15: ffff88881d7708b0
[  524.347872][   T66] FS:  0000000000000000(0000) GS:ffff8887c0480000(0000) knlGS:0000000000000000
[  524.357080][   T66] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  524.363964][   T66] CR2: 0000000000451c00 CR3: 000000081ca18005 CR4: 00000000003706f0
[  524.372264][   T66] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  524.380530][   T66] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  524.388778][   T66] Kernel panic - not syncing: Fatal exception
[  524.395126][   T66] Kernel Offset: disabled



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


