Return-Path: <linux-nfs+bounces-186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D67FE868
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 05:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE94B20D7D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 04:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1E4CB2E;
	Thu, 30 Nov 2023 04:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ubp277/m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D92D5E
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 20:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701319716; x=1732855716;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=yRd1/GZuadyBEenxDKue4QtpRYimGnwXmGcKKtWTX7I=;
  b=Ubp277/mdoOfPbEOnNjh+pJ71EEnTpXGkv9bIGaGNKYyQx/IGkziv8t3
   UTk9L0LfRLSS11MKym9JzkRpi3B67QslGcko8rfnfxseynEDOB+QXJecS
   bmCKBmm++utlZwFmxBZCzLNKmNjvAOYPvT2iZTSJJg8VrdlMWfC5UELul
   pjcYoGkcdl2aCxsc1kkMMlqY8R4dTIefz8zbvknpEi7Mo+PGJ2mcNGBE4
   YNdW1+EXYXgKMIqTw9FMNXrSWPCq/qfFS7RiprBl9lLKEyRVV2TFnjbVy
   gG/s9Sb43J3zapcBrhzAsD7zs8ijq66wHBY1GDnxtUNVc2ilzIHI2l2ev
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6540553"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6540553"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 20:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="762557451"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="762557451"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 20:48:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 20:48:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 20:48:35 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 20:48:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LepPcQPA8BjLGUGFh9O3A+HLDEwn1hzHIyh2Qgw8ok22LJrBy1HFjf608GWJZRASmQ/ss/q6FGRK7GgrBt2LC/9GTjek2Z5Wbtt7Uc81AVGnISV89LOkeBNgH+6OM5ZuD32QgXorFwTMRMg8BdKsVyxNTcFdLZaAcZQ4LbySunQnx/GD6meKMHtZdAAETs/S3agiXVZkmgebhcKno9dUfgWPzQue3JlrrMxsMy54KHWdd886to25iHhTeejYY6JdFnsZUhmYrx4Aj2N9Ejm3fhcEwC19Hg5M18rnOng3SAp/94ZxCKy3XJhqq306yFFaCbDBTih5331PNQZEvV3oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCXQc6m9ZLpSAIEzRCb9JYnKcdFCtIKSXhKpfaZz0mM=;
 b=LuRRxERij1ygxNCS2wLvUA4wMOJUuXk4WBr9+vTtPpkH6Co2ZdDIR5CdQ8SRvPTrUmAsRB+MhUC1990iS8m2Oyc3f0zAdapVsE2FY+sT8kB8eNu3LQeTyfS4rtQ08lVK528EXKkdXRTC+HukGXS7KIWVrZnJSqCvhYpTg7IYybB3sQ6zInXF841s3ziTNtQzZOX9nLoiTN1Rwn6/K2GRl6Ws+/r3bzOKTNUVVJ/4oYethERmRbYzG5gTxjnogW+blWrxeAouL+yMaY6AjI9TirgSIeiTyPybzFtAEs0zxoDy5O31BOEnsNv7jka4oETL6X8wLaTbhQsP/Nbdm+j4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 04:48:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 04:48:32 +0000
Date: Thu, 30 Nov 2023 12:48:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, "Olga
 Kornievskaia" <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 10/11] nfsd: allow delegation state ids to be revoked and
 then freed
Message-ID: <202311301059.38a31c59-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231124002925.1816-11-neilb@suse.de>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ed1192-8183-468c-b9e4-08dbf15f99f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUW2prQtXtP3kd1o4Pnaet6bXxikGLfVkBXcBjMSM9nGpEn1b+a3CF+7iWgEJPpX4wj93XEU8RtU919EdICoEdIpfjhIWhSVOxnlp3SI2yes34L+2l5VDWjWBh/maF/erAPTHx0C7PDkXDPdNpPMAcFdX5+x9SoTvYKCkhMFCSJdwhUqmdd77TAOqqbgB6xOSgP7NnnD8ZDG+4EzXMDtjjYRibRCqfHGDmrvj560EDcJ+gsK7yLlQ4DseA1oUb3BNWVhvYUNAqYrXVrZfiFzCR31gqpLLC2eZg2h53ydWAlk/sGSV3bVP9fd8WCY2KFgkKvEiZr/Gsre3jAUouSZZrFEryqdldr2Ui/nBEROYJQyQ9VLMVQMehhlc6eveVZSQXjGfKOZP4OJtdi6TJhDIzTYJSKlolgpf78Kw/J9Qs688ISvSE0I6Z90lEQdalB/VIZ5cHfiQaPzjUoJIBhWZ4yv+e+3fPDxr+rGxyF0OhGvcMz7YIPLfojYaxdjl1UL20wBi/hWx/XuAcjEfjf9y2a184pzXIvxCMbp67CelccmBYissL2qfLXYfBZJ0bLXXOsPe4ESE7M7FYAiEhbgApUcUAdvEFz4xGs8EH3PIQcQ5trcQambZO1Ud+7uiL2Y5/WdKja5DFKvGDPTgpnNBun9pJZezQqMFXgZWEU2qBIA7DgVkTZQG5F+tpkdLS/j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(1076003)(26005)(83380400001)(107886003)(6506007)(6666004)(2616005)(6512007)(5660300002)(4326008)(8676002)(8936002)(41300700001)(30864003)(2906002)(966005)(6486002)(45080400002)(478600001)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(202311291699003)(86362001)(36756003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4bvsE6SlmavQALS314+oH2NqApokdlIu7feANhdb/N4zT5THMY726gbWhX8?=
 =?us-ascii?Q?15KkVx6EKXiccP3wi/mYClREW3OGvR0AqVzBlIb1WY1VdriuPjB5fduJBiHS?=
 =?us-ascii?Q?fSKTf5NbB1LN1ZYaiMHHBTd5DuBXWCVwS+nEwhMukoDFaOUhBpLeNo2GXyS1?=
 =?us-ascii?Q?f5ZqDnB9PUgoQ4RntjfX3Tr8a/AECSCoTqmL4vP/2MTKRa8PYc7ASBCFdAl6?=
 =?us-ascii?Q?K6aPg3CtfDDmvogJeEZJ3gF0OqOOS9pzPVFizqspV6XU2ji8YyNgcEZyjmZW?=
 =?us-ascii?Q?7Ho0ULYXEh6V1g/Rl2d7RllHNo5fP6Zh3OLjKu3XJc4etTFXCz3ioGFwbX29?=
 =?us-ascii?Q?d0SmubFpAU7mZnSHD6D1Tjl9jJ/BD9CO2Uxz4UhDoPuHD65/79cwP8qyd8qD?=
 =?us-ascii?Q?XyQj8xcpT9vC13av1GXputXSvAzpu6wUhSne6mIxIZV+PWgNsHnlt5rAaGRI?=
 =?us-ascii?Q?k9AIc0aaaRbLaM7oQyXYeVwLp9qTJFar3Iubj05y8kw8Gg+bHb4OvdlqJ1DT?=
 =?us-ascii?Q?/ozbbLw51LNAZTUcvKhVVgzM/kXd5vDWkm+MjuDjcW4YWqjJs8O7lI269v9o?=
 =?us-ascii?Q?usnNp+RavvIqRbqrGYMjwCoBHmg0VqePpsP/QmAN89UB+g1Z95vtgtVbkkVE?=
 =?us-ascii?Q?7hl5NBJG+gQWKyJHfjNRb4lt4S9CxqZqUMhO0YxddE0k6+tydkUnoJM8KS/O?=
 =?us-ascii?Q?3Yj5pkRF9a+wunCneqFRePrpc2glELc0ruPYDK3jjgXOhlcoBSNe7Ru2L1YW?=
 =?us-ascii?Q?8iwWW0gVaxmhwjNZZjKPOadZGuvvRuen0PiZe8CoDP6BylTHQzw5XhU8id1A?=
 =?us-ascii?Q?GAxCctNU1v6wXIsj6tKCiW36fjKJn9IrC58PBh/xfRH4iapKUL3xxxElxOkx?=
 =?us-ascii?Q?VVPmf9VpJfqnIW5TGXoTlK7xKCPQdhi1iR/W774yRcpIIXlR4MhH0YUKQP2C?=
 =?us-ascii?Q?0s2IaOOeoIeaoPzP34nycW7fkfn4fnNj+Awl1pe8SG8Ua2fegR9lKIN3Uw/X?=
 =?us-ascii?Q?OM0Mr60XzOHlHgkol5qZ3v/0DGCGTiEnPOCt9C7iCp/SArxGdsO0WoGn38vo?=
 =?us-ascii?Q?+BoScE2nS+OsjmC7Je0WValX3a0PwdULRGhbGgazb3ZQvu22echCPM55qqmY?=
 =?us-ascii?Q?Q79Yu2pA9lsGyxltKApAROSTNa8DL0mBgYiKAhcs2JCaX22neSWiE1c0ce2y?=
 =?us-ascii?Q?fO1ocC91tDoYICjoabvuo2pv77vsoRk2dNi57evHr+H0/nLe9quqpwUbeUQe?=
 =?us-ascii?Q?zBRnXr56PZFL1j8qVVkCKeO+c1xKKmfV1MMtR+DQxQDc/3cl/CRt9zRe34IO?=
 =?us-ascii?Q?GmWKwikEdcQ39qc6/aHBCEVqLSDyG4CNXCcGYA8DSPaA+K2JFV/++vAwgniE?=
 =?us-ascii?Q?Y+9lv0/r/bv8Y08M2nderCwRxNYSdT3tWmYKLpadoapZlhEQYzlmI/94ZEpi?=
 =?us-ascii?Q?iKABdDBDDL5MoyXDCYNCsy8Y0bSE6XTDyAwNnK5aXXyO02nfrGYdiBQCYXZ1?=
 =?us-ascii?Q?R7nn/CXCZmDjat6q1/DI3oc1RV6u8H37HNe0v3bM8QfKHneNW4UZZfwfRKou?=
 =?us-ascii?Q?dQ9C/glS9WkvipNg9xQSx8EaKYEuxwWw+1g/CYIii+2ezQ6rA/GNOYJHdYZy?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ed1192-8183-468c-b9e4-08dbf15f99f6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 04:48:31.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHX+W0G7KYMcQEwUXiXaCH1ds+yCZXByini3ZU/l5DrpVZ/ke1SJmEnsH1CmO7wuTM7LamRTHOlcvMgCdIq1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/nfsd/nfs4state.c:#nfs4_free_deleg[nfsd]" on:

commit: 927562a91e483a71dd172f74f070503da5e3d9c0 ("[PATCH 10/11] nfsd: allow delegation state ids to be revoked and then freed")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-hold-cl_lock-for-hash_delegation_locked/20231124-123723
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git f1a09972a45ae63efbd1587337c4be13b1893330
patch link: https://lore.kernel.org/all/20231124002925.1816-11-neilb@suse.de/
patch subject: [PATCH 10/11] nfsd: allow delegation state ids to be revoked and then freed

in testcase: filebench
version: filebench-x86_64-22620e6-1_20221010
with following parameters:

	disk: 1HDD
	fs: xfs
	fs2: nfsv4
	test: webserver.f
	cpufreq_governor: performance



compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311301059.38a31c59-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231130/202311301059.38a31c59-oliver.sang@intel.com


[  307.542673][ T3954] ------------[ cut here ]------------
[  307.548304][ T3954] WARNING: CPU: 43 PID: 3954 at fs/nfsd/nfs4state.c:1075 nfs4_free_deleg+0x68/0xb0 [nfsd]
[  307.558383][ T3954] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss xfs dm_mod kmem device_dax nd_pmem nd_btt dax_pmem btrfs blake2b_generic xor raid6_pq libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ast ahci drm_shmem_helper libahci mei_me intel_cstate ipmi_ssif ioatdma i2c_i801 acpi_ipmi libata drm_kms_helper mei intel_uncore i2c_smbus joydev intel_pch_thermal dca dax_hmem wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[  307.622302][ T3954] CPU: 43 PID: 3954 Comm: nfsd Tainted: G S                 6.7.0-rc2-00157-g927562a91e48 #1
[  307.632555][ T3954] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[  307.644544][ T3954] RIP: 0010:nfs4_free_deleg+0x68/0xb0 [nfsd]
[  307.650693][ T3954] Code: 75 46 48 8b 3d c9 99 03 00 e8 b4 be f9 bf f0 48 ff 0d a4 99 03 00 c3 cc cc cc cc 0f 0b 48 8b 56 48 48 8d 46 48 48 39 c2 74 be <0f> 0b 48 8b 56 58 48 8d 46 58 48 39 c2 74 bc 0f 0b 48 8b 56 68 48
[  307.670673][ T3954] RSP: 0018:ffa000000b187ce0 EFLAGS: 00010206
[  307.676902][ T3954] RAX: ff110001498131b0 RBX: ff11000149813168 RCX: 0000000000000000
[  307.685072][ T3954] RDX: ff11000220359598 RSI: ff11000149813168 RDI: ff11000149813168
[  307.693174][ T3954] RBP: ff11001088cca820 R08: ff11001085b73288 R09: ff11001088cca500
[  307.701270][ T3954] R10: ffa000000b187cb0 R11: ffa000000b187cb8 R12: ff11001088cca4c0
[  307.709374][ T3954] R13: ff11000220359560 R14: ff110001abf0e028 R15: ffa000000b187d50
[  307.717474][ T3954] FS:  0000000000000000(0000) GS:ff11001fff4c0000(0000) knlGS:0000000000000000
[  307.726523][ T3954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  307.733228][ T3954] CR2: 0000000000451c00 CR3: 000000207e01c005 CR4: 0000000000771ef0
[  307.741326][ T3954] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  307.749419][ T3954] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  307.757510][ T3954] PKRU: 55555554
[  307.761182][ T3954] Call Trace:
[  307.764594][ T3954]  <TASK>
[  307.767648][ T3954]  ? nfs4_free_deleg+0x68/0xb0 [nfsd]
[  307.773161][ T3954]  ? __warn+0x81/0x130
[  307.777344][ T3954]  ? nfs4_free_deleg+0x68/0xb0 [nfsd]
[  307.782887][ T3954]  ? report_bug+0x15d/0x1b0
[  307.787494][ T3954]  ? handle_bug+0x3c/0x70
[  307.791978][ T3954]  ? exc_invalid_op+0x17/0x70
[  307.796759][ T3954]  ? asm_exc_invalid_op+0x1a/0x20
[  307.801914][ T3954]  ? nfs4_free_deleg+0x68/0xb0 [nfsd]
[  307.807407][ T3954]  nfs4_put_stid+0x6e/0xb0 [nfsd]
[  307.812556][ T3954]  nfsd4_lookup_stateid+0x11b/0x170 [nfsd]
[  307.818482][ T3954]  nfsd4_delegreturn+0xa8/0x170 [nfsd]
[  307.824060][ T3954]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  307.829931][ T3954]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  307.835155][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  307.840194][ T3954]  svc_process_common+0x2f5/0x5f0
[  307.845298][ T3954]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  307.851118][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  307.856149][ T3954]  svc_process+0x131/0x170
[  307.860636][ T3954]  svc_handle_xprt+0x4b0/0x5b0
[  307.865468][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  307.870500][ T3954]  svc_recv+0x17e/0x2f0
[  307.874720][ T3954]  nfsd+0x77/0xf0 [nfsd]
[  307.879049][ T3954]  kthread+0xcd/0x130
[  307.883087][ T3954]  ? __pfx_kthread+0x10/0x10
[  307.887722][ T3954]  ret_from_fork+0x31/0x70
[  307.892183][ T3954]  ? __pfx_kthread+0x10/0x10
[  307.896830][ T3954]  ret_from_fork_asm+0x1b/0x30
[  307.901627][ T3954]  </TASK>
[  307.904679][ T3954] ---[ end trace 0000000000000000 ]---
[  307.910161][ T3954] ------------[ cut here ]------------
[  307.915636][ T3954] WARNING: CPU: 43 PID: 3954 at fs/nfsd/nfs4state.c:1076 nfs4_free_deleg+0x77/0xb0 [nfsd]
[  307.925562][ T3954] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss xfs dm_mod kmem device_dax nd_pmem nd_btt dax_pmem btrfs blake2b_generic xor raid6_pq libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ast ahci drm_shmem_helper libahci mei_me intel_cstate ipmi_ssif ioatdma i2c_i801 acpi_ipmi libata drm_kms_helper mei intel_uncore i2c_smbus joydev intel_pch_thermal dca dax_hmem wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[  307.988853][ T3954] CPU: 43 PID: 3954 Comm: nfsd Tainted: G S      W          6.7.0-rc2-00157-g927562a91e48 #1
[  307.999025][ T3954] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[  308.010876][ T3954] RIP: 0010:nfs4_free_deleg+0x77/0xb0 [nfsd]
[  308.016969][ T3954] Code: 48 ff 0d a4 99 03 00 c3 cc cc cc cc 0f 0b 48 8b 56 48 48 8d 46 48 48 39 c2 74 be 0f 0b 48 8b 56 58 48 8d 46 58 48 39 c2 74 bc <0f> 0b 48 8b 56 68 48 8d 46 68 48 39 c2 74 ba 0f 0b eb b6 66 66 2e
[  308.036795][ T3954] RSP: 0018:ffa000000b187ce0 EFLAGS: 00010283
[  308.042959][ T3954] RAX: ff110001498131c0 RBX: ff11000149813168 RCX: 0000000000000000
[  308.050984][ T3954] RDX: ff11000149810388 RSI: ff11000149813168 RDI: ff11000149813168
[  308.059011][ T3954] RBP: ff11001088cca820 R08: ff11001085b73288 R09: ff11001088cca500
[  308.067036][ T3954] R10: ffa000000b187cb0 R11: ffa000000b187cb8 R12: ff11001088cca4c0
[  308.075060][ T3954] R13: ff11000220359560 R14: ff110001abf0e028 R15: ffa000000b187d50
[  308.083085][ T3954] FS:  0000000000000000(0000) GS:ff11001fff4c0000(0000) knlGS:0000000000000000
[  308.092068][ T3954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  308.098710][ T3954] CR2: 0000000000451c00 CR3: 000000207e01c005 CR4: 0000000000771ef0
[  308.106747][ T3954] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  308.114797][ T3954] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  308.122857][ T3954] PKRU: 55555554
[  308.126471][ T3954] Call Trace:
[  308.129852][ T3954]  <TASK>
[  308.132887][ T3954]  ? nfs4_free_deleg+0x77/0xb0 [nfsd]
[  308.138353][ T3954]  ? __warn+0x81/0x130
[  308.142486][ T3954]  ? nfs4_free_deleg+0x77/0xb0 [nfsd]
[  308.148003][ T3954]  ? report_bug+0x15d/0x1b0
[  308.152574][ T3954]  ? handle_bug+0x3c/0x70
[  308.156970][ T3954]  ? exc_invalid_op+0x17/0x70
[  308.161708][ T3954]  ? asm_exc_invalid_op+0x1a/0x20
[  308.166817][ T3954]  ? nfs4_free_deleg+0x77/0xb0 [nfsd]
[  308.172280][ T3954]  nfs4_put_stid+0x6e/0xb0 [nfsd]
[  308.177393][ T3954]  nfsd4_lookup_stateid+0x11b/0x170 [nfsd]
[  308.183290][ T3954]  nfsd4_delegreturn+0xa8/0x170 [nfsd]
[  308.188864][ T3954]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  308.194680][ T3954]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  308.199925][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.204965][ T3954]  svc_process_common+0x2f5/0x5f0
[  308.210054][ T3954]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  308.215907][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.220991][ T3954]  svc_process+0x131/0x170
[  308.225468][ T3954]  svc_handle_xprt+0x4b0/0x5b0
[  308.230299][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.235327][ T3954]  svc_recv+0x17e/0x2f0
[  308.239542][ T3954]  nfsd+0x77/0xf0 [nfsd]
[  308.243909][ T3954]  kthread+0xcd/0x130
[  308.247959][ T3954]  ? __pfx_kthread+0x10/0x10
[  308.252594][ T3954]  ret_from_fork+0x31/0x70
[  308.257057][ T3954]  ? __pfx_kthread+0x10/0x10
[  308.261686][ T3954]  ret_from_fork_asm+0x1b/0x30
[  308.266478][ T3954]  </TASK>
[  308.269533][ T3954] ---[ end trace 0000000000000000 ]---
[  308.275016][ T3954] ------------[ cut here ]------------
[  308.280488][ T3954] WARNING: CPU: 43 PID: 3954 at fs/nfsd/nfs4state.c:598 put_nfs4_file+0x5c/0x70 [nfsd]
[  308.290156][ T3954] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss xfs dm_mod kmem device_dax nd_pmem nd_btt dax_pmem btrfs blake2b_generic xor raid6_pq libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ast ahci drm_shmem_helper libahci mei_me intel_cstate ipmi_ssif ioatdma i2c_i801 acpi_ipmi libata drm_kms_helper mei intel_uncore i2c_smbus joydev intel_pch_thermal dca dax_hmem wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[  308.353356][ T3954] CPU: 43 PID: 3954 Comm: nfsd Tainted: G S      W          6.7.0-rc2-00157-g927562a91e48 #1
[  308.363522][ T3954] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[  308.375339][ T3954] RIP: 0010:put_nfs4_file+0x5c/0x70 [nfsd]
[  308.381204][ T3954] Code: 48 39 c2 75 29 48 8b 43 38 48 8d 7b 38 48 39 c7 75 18 48 c7 c6 90 07 48 c1 5b e9 6f 40 d4 bf be 03 00 00 00 5b e9 e4 fa 2e c0 <0f> 0b eb e4 0f 0b eb d3 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
[  308.401096][ T3954] RSP: 0018:ffa000000b187d00 EFLAGS: 00010206
[  308.407207][ T3954] RAX: ff110001498131b0 RBX: ff11000220359560 RCX: 00000000000003e7
[  308.415227][ T3954] RDX: ff110002203595a8 RSI: 00000000cccccccd RDI: ff11000220359598
[  308.423248][ T3954] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffc1480801
[  308.431277][ T3954] R10: ff11000149813168 R11: 0000000000000001 R12: 0000000000000004
[  308.439303][ T3954] R13: 000000003f270000 R14: ff110001abf0e028 R15: ffa000000b187d50
[  308.447330][ T3954] FS:  0000000000000000(0000) GS:ff11001fff4c0000(0000) knlGS:0000000000000000
[  308.456317][ T3954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  308.462972][ T3954] CR2: 0000000000451c00 CR3: 000000207e01c005 CR4: 0000000000771ef0
[  308.471005][ T3954] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  308.479039][ T3954] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  308.487076][ T3954] PKRU: 55555554
[  308.490692][ T3954] Call Trace:
[  308.494048][ T3954]  <TASK>
[  308.497052][ T3954]  ? put_nfs4_file+0x5c/0x70 [nfsd]
[  308.502340][ T3954]  ? __warn+0x81/0x130
[  308.506475][ T3954]  ? put_nfs4_file+0x5c/0x70 [nfsd]
[  308.511782][ T3954]  ? report_bug+0x15d/0x1b0
[  308.516353][ T3954]  ? handle_bug+0x3c/0x70
[  308.520742][ T3954]  ? exc_invalid_op+0x17/0x70
[  308.525477][ T3954]  ? asm_exc_invalid_op+0x1a/0x20
[  308.530566][ T3954]  ? __pfx_nfs4_free_deleg+0x1/0x10 [nfsd]
[  308.536460][ T3954]  ? put_nfs4_file+0x5c/0x70 [nfsd]
[  308.541748][ T3954]  nfsd4_lookup_stateid+0x11b/0x170 [nfsd]
[  308.547655][ T3954]  nfsd4_delegreturn+0xa8/0x170 [nfsd]
[  308.553203][ T3954]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  308.559015][ T3954]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  308.564223][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.569255][ T3954]  svc_process_common+0x2f5/0x5f0
[  308.574345][ T3954]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  308.580150][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.585177][ T3954]  svc_process+0x131/0x170
[  308.589661][ T3954]  svc_handle_xprt+0x4b0/0x5b0
[  308.594494][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.599521][ T3954]  svc_recv+0x17e/0x2f0
[  308.603735][ T3954]  nfsd+0x77/0xf0 [nfsd]
[  308.608074][ T3954]  kthread+0xcd/0x130
[  308.612107][ T3954]  ? __pfx_kthread+0x10/0x10
[  308.616749][ T3954]  ret_from_fork+0x31/0x70
[  308.621218][ T3954]  ? __pfx_kthread+0x10/0x10
[  308.625875][ T3954]  ret_from_fork_asm+0x1b/0x30
[  308.630667][ T3954]  </TASK>
[  308.633720][ T3954] ---[ end trace 0000000000000000 ]---
[  308.639455][ T3954] ------------[ cut here ]------------
[  308.644956][ T3954] refcount_t: addition on 0; use-after-free.
[  308.651007][ T3954] WARNING: CPU: 39 PID: 3954 at lib/refcount.c:25 refcount_warn_saturate+0x9b/0x130
[  308.660431][ T3954] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss xfs dm_mod kmem device_dax nd_pmem nd_btt dax_pmem btrfs blake2b_generic xor raid6_pq libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ast ahci drm_shmem_helper libahci mei_me intel_cstate ipmi_ssif ioatdma i2c_i801 acpi_ipmi libata drm_kms_helper mei intel_uncore i2c_smbus joydev intel_pch_thermal dca dax_hmem wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[  308.723741][ T3954] CPU: 39 PID: 3954 Comm: nfsd Tainted: G S      W          6.7.0-rc2-00157-g927562a91e48 #1
[  308.733961][ T3954] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[  308.745793][ T3954] RIP: 0010:refcount_warn_saturate+0x9b/0x130
[  308.751935][ T3954] Code: 01 01 e8 08 f0 98 ff 0f 0b c3 cc cc cc cc 80 3d 12 3e 9e 01 00 75 a8 48 c7 c7 c8 f7 96 82 c6 05 02 3e 9e 01 01 e8 e5 ef 98 ff <0f> 0b c3 cc cc cc cc 80 3d ee 3d 9e 01 00 75 85 48 c7 c7 f8 f7 96
[  308.771763][ T3954] RSP: 0018:ffa000000b187c08 EFLAGS: 00010282
[  308.777918][ T3954] RAX: 0000000000000000 RBX: ff11000149813168 RCX: 0000000000000000
[  308.785997][ T3954] RDX: ff11001fff3ecd00 RSI: ff11001fff3e0840 RDI: ff11001fff3e0840
[  308.794022][ T3954] RBP: ff11000220359574 R08: 0000000000000000 R09: ffa000000b187a98
[  308.802048][ T3954] R10: 0000000000000003 R11: ffffffff82fdd6e8 R12: ff110001c8bf0870
[  308.810073][ T3954] R13: ff11000220359560 R14: ff1100207a3ad368 R15: 000000010000c13c
[  308.818102][ T3954] FS:  0000000000000000(0000) GS:ff11001fff3c0000(0000) knlGS:0000000000000000
[  308.827095][ T3954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  308.833742][ T3954] CR2: 0000000000451c00 CR3: 000000108649e002 CR4: 0000000000771ef0
[  308.841794][ T3954] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  308.849859][ T3954] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  308.857943][ T3954] PKRU: 55555554
[  308.861565][ T3954] Call Trace:
[  308.864977][ T3954]  <TASK>
[  308.867982][ T3954]  ? refcount_warn_saturate+0x9b/0x130
[  308.873503][ T3954]  ? __warn+0x81/0x130
[  308.877639][ T3954]  ? refcount_warn_saturate+0x9b/0x130
[  308.883168][ T3954]  ? report_bug+0x15d/0x1b0
[  308.887734][ T3954]  ? prb_read_valid+0x1b/0x30
[  308.892481][ T3954]  ? handle_bug+0x3c/0x70
[  308.896911][ T3954]  ? exc_invalid_op+0x17/0x70
[  308.901651][ T3954]  ? asm_exc_invalid_op+0x1a/0x20
[  308.906739][ T3954]  ? refcount_warn_saturate+0x9b/0x130
[  308.912261][ T3954]  ? refcount_warn_saturate+0x9b/0x130
[  308.917790][ T3954]  nfsd_break_deleg_cb+0x161/0x170 [nfsd]
[  308.923605][ T3954]  __break_lease+0x22f/0x6b0
[  308.928267][ T3954]  vfs_unlink+0xe0/0x2b0
[  308.932575][ T3954]  nfsd_unlink+0x18a/0x330 [nfsd]
[  308.937699][ T3954]  nfsd4_remove+0x4f/0xb0 [nfsd]
[  308.942731][ T3954]  nfsd4_proc_compound+0x345/0x630 [nfsd]
[  308.948556][ T3954]  nfsd_dispatch+0xfd/0x230 [nfsd]
[  308.953778][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.958830][ T3954]  svc_process_common+0x2f5/0x5f0
[  308.963971][ T3954]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  308.969797][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.974845][ T3954]  svc_process+0x131/0x170
[  308.979320][ T3954]  svc_handle_xprt+0x4b0/0x5b0
[  308.984138][ T3954]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  308.989149][ T3954]  svc_recv+0x17e/0x2f0
[  308.993347][ T3954]  nfsd+0x77/0xf0 [nfsd]
[  308.997647][ T3954]  kthread+0xcd/0x130
[  309.001664][ T3954]  ? __pfx_kthread+0x10/0x10
[  309.006277][ T3954]  ret_from_fork+0x31/0x70
[  309.010720][ T3954]  ? __pfx_kthread+0x10/0x10
[  309.015325][ T3954]  ret_from_fork_asm+0x1b/0x30
[  309.020109][ T3954]  </TASK>
[  309.023141][ T3954] ---[ end trace 0000000000000000 ]---
[  400.427843][  T786] list_del corruption. prev->next should be ff110001498131b0, but was ff1100108544ea60. (prev=ff11000220359598)
[  400.439548][  T786] ------------[ cut here ]------------
[  400.444876][  T786] kernel BUG at lib/list_debug.c:62!
[  400.450034][  T786] invalid opcode: 0000 [#1] SMP NOPTI
[  400.455266][  T786] CPU: 4 PID: 786 Comm: kworker/u257:1 Tainted: G S      W          6.7.0-rc2-00157-g927562a91e48 #1
[  400.465964][  T786] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
[  400.477438][  T786] Workqueue: nfsd4 laundromat_main [nfsd]
[  400.483084][  T786] RIP: 0010:__list_del_entry_valid_or_report+0xa7/0xf0
[  400.489791][  T786] Code: a1 ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 c8 02 97 82 e8 ed 20 a1 ff 0f 0b 48 89 fe 48 89 c2 48 c7 c7 00 03 97 82 e8 d9 20 a1 ff <0f> 0b 48 89 d1 48 c7 c7 50 03 97 82 48 89 f2 48 89 c6 e8 c2 20 a1
[  400.509242][  T786] RSP: 0018:ffa000000890fdb0 EFLAGS: 00010246
[  400.515165][  T786] RAX: 000000000000006d RBX: ff11000149813168 RCX: 0000000000000000
[  400.522992][  T786] RDX: 0000000000000000 RSI: ff1100103f320840 RDI: ff1100103f320840
[  400.530820][  T786] RBP: ff11000220359574 R08: 0000000000000000 R09: ffa000000890fc58
[  400.538652][  T786] R10: 0000000000000003 R11: ffffffff82fdd6e8 R12: ff110001498131b0
[  400.546478][  T786] R13: ff110001498131d0 R14: ff1100012079c4b0 R15: ff1100012079c4b0
[  400.554307][  T786] FS:  0000000000000000(0000) GS:ff1100103f300000(0000) knlGS:0000000000000000
[  400.563093][  T786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  400.569538][  T786] CR2: 0000000000451c00 CR3: 000000207e01c002 CR4: 0000000000771ef0
[  400.577366][  T786] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  400.585191][  T786] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  400.593018][  T786] PKRU: 55555554
[  400.596420][  T786] Call Trace:
[  400.599569][  T786]  <TASK>
[  400.602365][  T786]  ? die+0x36/0xb0
[  400.605945][  T786]  ? do_trap+0xda/0x130
[  400.609959][  T786]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  400.616053][  T786]  ? do_error_trap+0x65/0xb0
[  400.620497][  T786]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  400.626592][  T786]  ? exc_invalid_op+0x50/0x70
[  400.631131][  T786]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  400.637223][  T786]  ? asm_exc_invalid_op+0x1a/0x20
[  400.642102][  T786]  ? __list_del_entry_valid_or_report+0xa7/0xf0
[  400.648198][  T786]  unhash_delegation_locked+0xb1/0x130 [nfsd]
[  400.654153][  T786]  nfs4_laundromat+0x54c/0x670 [nfsd]
[  400.659409][  T786]  laundromat_main+0x19/0x70 [nfsd]
[  400.664497][  T786]  process_one_work+0x173/0x330
[  400.669211][  T786]  worker_thread+0x27f/0x3b0
[  400.673658][  T786]  ? __pfx_worker_thread+0x10/0x10
[  400.678625][  T786]  kthread+0xcd/0x130
[  400.682469][  T786]  ? __pfx_kthread+0x10/0x10
[  400.686918][  T786]  ret_from_fork+0x31/0x70
[  400.691188][  T786]  ? __pfx_kthread+0x10/0x10
[  400.695893][  T786]  ret_from_fork_asm+0x1b/0x30
[  400.700743][  T786]  </TASK>
[  400.703858][  T786] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss xfs dm_mod kmem device_dax nd_pmem nd_btt dax_pmem btrfs blake2b_generic xor raid6_pq libcrc32c sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ast ahci drm_shmem_helper libahci mei_me intel_cstate ipmi_ssif ioatdma i2c_i801 acpi_ipmi libata drm_kms_helper mei intel_uncore i2c_smbus joydev intel_pch_thermal dca dax_hmem wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[  400.767434][  T786] ---[ end trace 0000000000000000 ]---
[  400.783218][  T786] pstore: backend (erst) writing error (-28)
[  400.789259][  T786] RIP: 0010:__list_del_entry_valid_or_report+0xa7/0xf0
[  400.796164][  T786] Code: a1 ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 c8 02 97 82 e8 ed 20 a1 ff 0f 0b 48 89 fe 48 89 c2 48 c7 c7 00 03 97 82 e8 d9 20 a1 ff <0f> 0b 48 89 d1 48 c7 c7 50 03 97 82 48 89 f2 48 89 c6 e8 c2 20 a1
[  400.816092][  T786] RSP: 0018:ffa000000890fdb0 EFLAGS: 00010246
[  400.822214][  T786] RAX: 000000000000006d RBX: ff11000149813168 RCX: 0000000000000000
[  400.830249][  T786] RDX: 0000000000000000 RSI: ff1100103f320840 RDI: ff1100103f320840
[  400.838278][  T786] RBP: ff11000220359574 R08: 0000000000000000 R09: ffa000000890fc58
[  400.846304][  T786] R10: 0000000000000003 R11: ffffffff82fdd6e8 R12: ff110001498131b0
[  400.854330][  T786] R13: ff110001498131d0 R14: ff1100012079c4b0 R15: ff1100012079c4b0
[  400.862357][  T786] FS:  0000000000000000(0000) GS:ff1100103f300000(0000) knlGS:0000000000000000
[  400.871346][  T786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  400.877996][  T786] CR2: 0000000000451c00 CR3: 000000207e01c002 CR4: 0000000000771ef0
[  400.886025][  T786] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  400.894049][  T786] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  400.902072][  T786] PKRU: 55555554
[  400.905677][  T786] Kernel panic - not syncing: Fatal exception
[  400.957082][  T786] Kernel Offset: disabled


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


