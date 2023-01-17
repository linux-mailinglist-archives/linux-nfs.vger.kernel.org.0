Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0866E1E3
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jan 2023 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjAQPR3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Jan 2023 10:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjAQPRK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Jan 2023 10:17:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E13FF0A
        for <linux-nfs@vger.kernel.org>; Tue, 17 Jan 2023 07:17:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WptWKaRzav1cx3LqnQsyYl+sZdEQkjA4MahiQAOretgx8Z5mqiU1sjohmEZmUG/3yIsEz30A3j0M2eVuXlJV37kW19EtkAWuIuAguzapIoBrAw+jVQoOu+YpNko0itOQ3Rq4WpluWI51PJIGxRDuIa3lulga0upGvh8a+L95PiDGNLU/mTb6z2jmQHvwcq/jalhnI5Blh52rFFXjeVZYKRn7VJRbACQCVBQdrvAaPr8TLdl+y6SVjJP6SngtBBycuuDJkvrisQvfrJ0rAWEZjeO+0BZ0k9cT6IYnj427s+VcbfRxGJWh6Sd8tTovgAi80TNmEK0fEPqm+RXRN7/xIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl8qYXNBP94WGlgVWNvrBRK3/bfutPbx0WZMlO3jRb4=;
 b=AfLE81i2go2icyfONAR64yP+JEiHgEhL0u3JL/ohbRN7JBwgcS3eRQSEzvjjTJJm+TSvTTMK9BvhA128G2+dPcHA00TP85wCztGyf44rtAqbwcVczLIgWSeuMJhojKf6d7a1OzcT19AgRiCsZ1HKyXKZDTMDR2lvI18C9Ip/2G9mlrUfzX/90ONq6GRVSCli/StWTvEHbxswlgwEFNbarRun7pH/1zhgkjl/K/JQAMSuxntRfMCxfU6wSwlMw8kxX8Zm5yR280MqFDXxCWSOzlZ1sJCz3jDK82tBdMGOyJ8Pc3SO/hZUyNFQ4K5ALk4bIF9AsxJfs5E8ov4P3N/GpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl8qYXNBP94WGlgVWNvrBRK3/bfutPbx0WZMlO3jRb4=;
 b=HZaaQ+pSjeoShxZdXWXSponYIvgc1YQj0PI/R+FZMvKbNLexxfNSi+BwXIuz8n9TLAbpaAP66D4MfOJBACBMju6Kc+u5eSYwx3pikv0R12J8GfDqBrAxfqhupYWiW33L8coRVgYhzuBSumYBMidC2Hvu6Dvb5WW797H2WUQgkOb6oMh1aMdLjcRScDeHyO5+J7ztv4SWAn7lRMdRFbjYrtVn18g9jJWK/2qEeEsc+4hnKX4BIs9Yi5MtM+r5J7wtNqdBk+r+wEpsCDik6BqGJJCS4AN3Ytve2gk8MMoOSuJAr45ysgcXaXCTtgLQ4TdORE3nHe5JBSXuRrsnLpAOzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 15:17:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 15:17:00 +0000
Date:   Tue, 17 Jan 2023 11:16:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shachar Kagan <skagan@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>
Cc:     chuck.lever@oracle.com, neilb@suse.de, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Message-ID: <Y8a766ypSbKbevTJ@nvidia.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101144647.136696-4-jlayton@kernel.org>
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a71ab63-6c24-42fd-d4ef-08daf89de177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AscOGu48EAvGfRpZADd+gnoOm5rwmRX+C4pnotLWLt6DbqLJ7SWa03BZdLW8fFnoMr1TXe/KLpIbSfynD7YIZPjH7Vuu15RxXe2MVrRZ+U/UViSrpWnFPJcdQ3/RWRXIPFQp32zEaJiwJc6yVyXSBnWZkvzXbk4x2jcjWIHvih+HgDpoYGucdomdTI/xPHHp0u0XsjCXs27XzxrmTLl7n1eHoMzuFjuu5AbnH9Ry7Q9sgyjSrx2hjBRgc2RJzcBQHWU819DS7yGJ4LtQAV6r1EjZmjstw2qqGosQtnbM3JHXl+IzHS8IYYv40E8cm4vPEXkG6u29fVRk2IpOO8dSfHMLMjPX0e2xWik9hnZ9gg+H4VWAI2IQZNHWCXvHQT76wZ+BY7cM2iKdOMPq+WKPk4ZOdTMdpCy0Ci67vhPNdeEO9KiAdRQybjeKVfYUCboKTENh3ZmeZ0AoFhkVypUuoS5Xlzf6LP1ntL9u9Cs0V734Uw+Ebi/l+5NyT2DnrK/ii/fjEC+HfVogJr/hEhpH1gvxLTwk/96NQtM4PKR0N7bVm7LcA5zYiqXH2NK5MedE+VPq7UGT9rsqA47rpgtuV30iqJlbQN4AatW/RDQdWOa9pAtHM9C26MndXZ/tRd65OQkp9VjWeCmvOqCNoj1pWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(83380400001)(66899015)(45080400002)(6636002)(6486002)(6512007)(110136005)(478600001)(36756003)(38100700002)(2616005)(186003)(86362001)(2906002)(30864003)(41300700001)(26005)(6506007)(66946007)(4326008)(8676002)(8936002)(66556008)(5660300002)(66476007)(316002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUKvHa8I3UH6QK2CSXTUCsxhH2Q43sUGO+lloKQXnRlKR81jrwYkJkjdkdy7?=
 =?us-ascii?Q?VseFEr/AmD0v7n0x1XSJXp8KKcvQDXrOY5RBDyez/IBnMCd8KUkvQlL18Wpf?=
 =?us-ascii?Q?YO2GtqE42JBUPCTR9rqRanyf72oDN3NphtSpRGlk2xkyx+Albc51gX2PTcwu?=
 =?us-ascii?Q?WTPdqX3G4LWBSShw6VBQil8ijzaQpiNTW6xgp2XH+rYik9MqxVAUq2golLbi?=
 =?us-ascii?Q?cHNqdmqLMv7Yf91hieuLoUH0rTsvEBXcBfjqvSAkxrZaAqe/WFDW3EORZrdZ?=
 =?us-ascii?Q?NdfK/Vu7nO9rhNfq6GXDzb95O8T6GtzvmRHRzjLLPsiqDfEF7GB2HlCkHEtV?=
 =?us-ascii?Q?T0I+2ioJX6yi35aWYm7JJwHoXSSBqRWRl1Y/tcklkS6fEWiBRfeZRZC3zP8e?=
 =?us-ascii?Q?6nwknxYxiSecYPZSjbDBpBVewufSB5SDqCIA9hOpUrUNmr/T/g0ZVuQgRnCr?=
 =?us-ascii?Q?qkd7U5jTte93ZwVPiqG28T1wtWHqqaxudCxgrVFQo+64U1XWsE9yg0tR2oAB?=
 =?us-ascii?Q?EaBTsBYCQArXrPbcdIL44PfDXMacEJ6jknDExQQhDaRidmOqntYOPF4vTbWF?=
 =?us-ascii?Q?zNYv//AX5M/tOh//26T8zs2JJBKMxVoupISF+nPzY3l82tcXmX+3cthEjy2O?=
 =?us-ascii?Q?swVQs0VOgUeG1MelyeKfF69fHcF/vpRjD0zSLU2hrBbjjMBGSsStuxgnYOim?=
 =?us-ascii?Q?zixXHINT2ZgMp63cLY/o4bfpjjuW46NLEymx9/tqtZg1NVgzCMCnmbCOpN+G?=
 =?us-ascii?Q?qn2GsYwf2rLhTMtRhODiCBw/d4LnXLH2a9B+L0kxeoIFkN5pf8f3a7TzUwgy?=
 =?us-ascii?Q?g+o4EgDt/Dfj+5Hi5P7K2JgDQ93p04lp/g+FrqJo24emfWQKzJDAgGrogJ4q?=
 =?us-ascii?Q?y64FYOX76vT2rSsmt20+jF+/IpoOcaWvXzqxT1aF86hSC7jZNXfyrMsMrRhx?=
 =?us-ascii?Q?c63iDXlK7M6pB2N2v2LIki8Q4DAFfP/JsjIQ8LHwEpQgKhCWOOrDMv45LEFF?=
 =?us-ascii?Q?XDQI8oy/I5rJDr7Iy62NmmLac3EQ0+BXNT6aX41fGuU3py52pysySuk+Zsom?=
 =?us-ascii?Q?Yw8l3AMIy9KLZGz09EZG3+kB1JCsl/Sblqaw/uZN3mAfqXfvrRKXOishUMlJ?=
 =?us-ascii?Q?I6gXOSlokg8Grc7nZQej4c6dn5AydqT7jTimNBomd+6owaULNi1YVqA/JPaC?=
 =?us-ascii?Q?lngzarKU3hA+DStRkKXxJV+VeATJ894TcmP0jJNnqR43ph3T76HYvgtJGb4o?=
 =?us-ascii?Q?zehVorgm8O9uY22pKV2qwjHx5fDKdHYqZaYrRzfQOHfWt3vzuemmZSLlY0mC?=
 =?us-ascii?Q?GwyuS4iPvETc0Exb+ENgUfP5kCZCBVgvH33S9nnQqGvxsX97MSpqspbD2IXs?=
 =?us-ascii?Q?QzTubsaV3LjbJwW0aRbkUlyVdDrblze3nEf2lyhsAsYifJg/tMJBAlNcGZ/B?=
 =?us-ascii?Q?ZT1IZ6YJSUnGJoN9ySQ7fSH0eQ0UErrsSnu4IyGbuersav9af3PDF2rvJ1c0?=
 =?us-ascii?Q?UyMy/oibeHZZLPy9R24WyIQSGSMVS8U7J5PbYBAX05mdjPFtJRlxPnNxXzSq?=
 =?us-ascii?Q?SQdbZyxxM9hjDR9dn6P6llGPq61yFGA+iV4wyXdI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a71ab63-6c24-42fd-d4ef-08daf89de177
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:17:00.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62/RI5G1TxjxyGmWv9uizxDdWKr3x9UG8V5NH0CrC8LTyJaEM2fOAF88roJldnfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 01, 2022 at 10:46:45AM -0400, Jeff Layton wrote:
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed. This
> in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, which we believe to have led to races.
> 
> There are other problems in here too. nfsd_file_close_inode_sync can end
> up freeing an nfsd_file while there are still outstanding references to
> it, and there are a number of subtle ToC/ToU races.
> 
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object.
> 
> With this change, the LRU carries a reference. Take special care to
> deal with it when removing an entry from the list.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Our test team is getting crashes that bisection pointed at this
patch. It seems like there are multiple parallel crash reports so the
whole thing is a mess to read:

[  875.548965] BUG: kernel NULL pointer dereference, address: 00000000000000d0
[  875.548968] ------------[ cut here ]------------
[  875.548972] refcount_t: underflow; use-after-free.
[  875.548992] WARNING: CPU: 4 PID: 12145 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
[  875.549851] #PF: supervisor read access in kernel mode
[  875.550158] Modules linked in:
[  875.550752] #PF: error_code(0x0000) - not-present page
[  875.551269]  nfsd
[  875.551878] PGD 0
[  875.552069]  iptable_raw
[  875.552677] P4D 0
[  875.552824]  bonding mlx5_vfio_pci
[  875.553095]
[  875.553255]  rdma_ucm ipip
[  875.553525] Oops: 0000 [#1] SMP
[  875.553733]  tunnel4
[  875.553941] CPU: 0 PID: 12147 Comm: nfsd Not tainted 6.1.0-rc7_ac3a2585f018 #1
[  875.554109]  ip_gre ib_umad
[  875.554517] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.554656]  nf_tables vfio_pci
[  875.555508] RIP: 0010:vfs_setlease+0x27/0x70
[  875.555695]  vfio_pci_core vfio_virqfd
[  875.557015] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.557209]  vfio_iommu_type1
[  875.557406] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.557634]  mlx5_ib
[  875.558446]
[  875.558628]  vfio
[  875.558862] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.559006]  ib_uverbs
[  875.559092] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.559218]  ib_ipoib
[  875.559557] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.559704]  mlx5_core
[  875.560021] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.560165]  ip6_gre
[  875.560488] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.560634]  gre
[  875.560959] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
[  875.561108]  ip6_tunnel
[  875.561432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.561554]  tunnel6
[  875.561928] CR2: 00000000000000d0 CR3: 00000001ca27d001 CR4: 0000000000372eb0
[  875.562084]  geneve
[  875.562349] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.562493]  nfnetlink_cttimeout
[  875.562822] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.562962]  openvswitch
[  875.563292] Call Trace:
[  875.563298]  <TASK>
[  875.563503]  nsh
[  875.563839]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.563997]  vhost_net
[  875.564124]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.564262]  vhost
[  875.564357]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.564661]  vhost_iotlb
[  875.564798]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.565084]  tap
[  875.565187]  svc_process_common+0x2b6/0x4d0
[  875.565483]  ip6table_mangle
[  875.565607]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.565878]  ip6table_nat
[  875.565972]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.566228]  iptable_mangle
[  875.566371]  svc_process+0xd4/0xf0
[  875.566622]  ip6table_filter
[  875.566748]  nfsd+0xcb/0x180 [nfsd]
[  875.567063]  ip6_tables
[  875.567194]  kthread+0xb9/0xe0
[  875.567412]  xt_conntrack
[  875.567557]  ? kthread_complete_and_exit+0x20/0x20
[  875.567776]  xt_MASQUERADE
[  875.567892]  ret_from_fork+0x1f/0x30
[  875.568084]  nf_conntrack_netlink
[  875.568212]  </TASK>
[  875.568500]  nfnetlink
[  875.568631] Modules linked in:
[  875.568853]  xt_addrtype
[  875.569025]  nfsd
[  875.569167]  iptable_nat
[  875.569270]  iptable_raw
[  875.569464]  nf_nat
[  875.569572]  bonding
[  875.569701]  br_netfilter
[  875.569810]  mlx5_vfio_pci
[  875.569971]  overlay
[  875.570064]  rdma_ucm
[  875.570211]  rpcrdma
[  875.570317]  ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs
[  875.570492]  ib_iser
[  875.570590]  ib_ipoib
[  875.570737]  libiscsi
[  875.570834]  mlx5_core
[  875.571499]  scsi_transport_iscsi
[  875.571592]  ip6_gre
[  875.571736]  rdma_cm
[  875.571835]  gre
[  875.571984]  iw_cm
[  875.572126]  ip6_tunnel
[  875.572272]  ib_cm
[  875.572366]  tunnel6
[  875.572489]  ib_core
[  875.572581]  geneve
[  875.572738]  fuse
[  875.572834]  nfnetlink_cttimeout
[  875.572978]  [last unloaded: nf_tables]
[  875.573076]  openvswitch
[  875.573214]
[  875.573299]  nsh
[  875.573503] CPU: 4 PID: 12145 Comm: nfsd Not tainted 6.1.0-rc7_ac3a2585f018 #1
[  875.573666]  vhost_net
[  875.573826] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.573898]  vhost
[  875.574022] RIP: 0010:refcount_warn_saturate+0xd8/0xe0
[  875.574318]  vhost_iotlb
[  875.574469] Code: ff 48 c7 c7 70 60 26 82 c6 05 d7 aa fb 00 01 e8 35 3c 4a 00 0f 0b c3 48 c7 c7 18 60 26 82 c6 05 c3 aa fb 00 01 e8 1f 3c 4a 00 <0f> 0b c3 0f 1f 44 00 00 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 13
[  875.574913]  tap
[  875.575056] RSP: 0018:ffff88811d127db0 EFLAGS: 00010282
[  875.575265]  ip6table_mangle
[  875.575426]
[  875.576149]  ip6table_nat
[  875.576274] RAX: 0000000000000000 RBX: ffff88810669f138 RCX: ffff88852ca1b548
[  875.576486]  iptable_mangle
[  875.576669] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88852ca1b540
[  875.576740]  ip6table_filter
[  875.576915] RBP: ffff8881028410f0 R08: 80000000fffff3b3 R09: ffff88811d127d48
[  875.577203]  ip6_tables
[  875.577379] R10: 0000000000000b16 R11: 0000000000000001 R12: 0000000000000000
[  875.577663]  xt_conntrack
[  875.577846] R13: ffff8881dd380e00 R14: ffff888110e5a028 R15: ffff888110e5a1a0
[  875.578136]  xt_MASQUERADE
[  875.578294] FS:  0000000000000000(0000) GS:ffff88852ca00000(0000) knlGS:0000000000000000
[  875.578579]  nf_conntrack_netlink
[  875.578754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.579040]  nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm
[  875.579218] CR2: 00007fd8ec0017a8 CR3: 000000016a0db004 CR4: 0000000000372ea0
[  875.579538]  ib_cm
[  875.579745] Call Trace:
[  875.579977]  ib_core
[  875.580688]  <TASK>
[  875.580983]  fuse
[  875.581118]  nfsd_file_free+0x1c4/0x200 [nfsd]
[  875.581222]  [last unloaded: nf_tables]
[  875.581366]  destroy_unhashed_deleg+0xac/0xc0 [nfsd]
[  875.581457]
[  875.581586]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.581775] CR2: 00000000000000d0
[  875.582012]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.582216] ---[ end trace 0000000000000000 ]---
[  875.582217] BUG: kernel NULL pointer dereference, address: 00000000000000d0
[  875.582219] #PF: supervisor read access in kernel mode
[  875.582220] #PF: error_code(0x0000) - not-present page
[  875.582222] PGD 0 P4D 0
[  875.582228] Oops: 0000 [#2] SMP
[  875.582229] CPU: 8 PID: 12143 Comm: nfsd Tainted: G      D            6.1.0-rc7_ac3a2585f018 #1
[  875.582231] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.582232] RIP: 0010:vfs_setlease+0x27/0x70
[  875.582236] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.582238] RSP: 0018:ffff888119c97db0 EFLAGS: 00010246
[  875.582239] RAX: 0000000000000000 RBX: ffff88824866c690 RCX: ffff888119c97dd8
[  875.582241] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560b200
[  875.582242] RBP: ffff88812560b200 R08: ffff8881dd381800 R09: ffffffff82407758
[  875.582243] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.582244] R13: ffff8881dd381800 R14: ffff8881010cc028 R15: ffff8881010cc1a0
[  875.582245] FS:  0000000000000000(0000) GS:ffff88852cc00000(0000) knlGS:0000000000000000
[  875.582247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.582248] CR2: 00000000000000d0 CR3: 000000011c26d004 CR4: 0000000000372ea0
[  875.582250] Call Trace:
[  875.582251]  <TASK>
[  875.582253]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.582268]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.582280]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.582292]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.582302]  svc_process_common+0x2b6/0x4d0
[  875.582305]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.582315]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.582323]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.582339]  svc_process_common+0x2b6/0x4d0
[  875.582343]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.582357]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.582371]  svc_process+0xd4/0xf0
[  875.582374]  nfsd+0xcb/0x180 [nfsd]
[  875.582388]  kthread+0xb9/0xe0
[  875.582392]  ? kthread_complete_and_exit+0x20/0x20
[  875.582398]  ret_from_fork+0x1f/0x30
[  875.582401]  </TASK>
[  875.582402] ---[ end trace 0000000000000000 ]---
[  875.582518] RIP: 0010:vfs_setlease+0x27/0x70
[  875.582673]  svc_process+0xd4/0xf0
[  875.582873] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.583075]  nfsd+0xcb/0x180 [nfsd]
[  875.583350] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.583559]  kthread+0xb9/0xe0
[  875.583767]
[  875.583878]  ? kthread_complete_and_exit+0x20/0x20
[  875.584013] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.584363]  ret_from_fork+0x1f/0x30
[  875.584810] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.584990]  </TASK>
[  875.585722] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.585936] Modules linked in:
[  875.586219] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.586507]  nfsd
[  875.586793] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.587094]  iptable_raw
[  875.587383] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
[  875.587703]  bonding
[  875.587935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.588223]  mlx5_vfio_pci
[  875.588331] CR2: 00000000000000d0 CR3: 00000001ca27d001 CR4: 0000000000372eb0
[  875.588426]  rdma_ucm
[  875.588631] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.588835]  ipip
[  875.589035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.589215]  tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
[  875.650660] CR2: 00000000000000d0
[  875.650952] ---[ end trace 0000000000000000 ]---
[  875.650952] BUG: unable to handle page fault for address: 000000012547108f
[  875.651147] RIP: 0010:vfs_setlease+0x27/0x70
[  875.651493] #PF: supervisor read access in kernel mode
[  875.651670] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.651920] #PF: error_code(0x0000) - not-present page
[  875.652644] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.652902] PGD 0
[  875.653070]
[  875.653329] P4D 0
[  875.653418] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.653501]
[  875.653593] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.653944] Oops: 0000 [#3] SMP
[  875.654013] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.654359] CPU: 7 PID: 12140 Comm: nfsd Tainted: G      D W          6.1.0-rc7_ac3a2585f018 #1
[  875.654491] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.654837] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.655184] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.655529] RIP: 0010:vfs_setlease+0x1d/0x70
[  875.655970] FS:  0000000000000000(0000) GS:ffff88852cc00000(0000) knlGS:0000000000000000
[  875.656318] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
[  875.656497] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.656889] RSP: 0018:ffff88824874bdb0 EFLAGS: 00010246
[  875.657608] CR2: 00000000000000d0 CR3: 000000011c26d004 CR4: 0000000000372ea0
[  875.657899]
[  875.665061] RAX: ffff8881807150d0 RBX: ffff8881034da230 RCX: ffff88824874bdd8
[  875.665670] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000125471067
[  875.666275] RBP: 0000000125471067 R08: ffff888248d72500 R09: ffffffff82407758
[  875.666886] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.667495] R13: ffff888248d72500 R14: ffff888103348028 R15: ffff8881033481a0
[  875.668102] FS:  0000000000000000(0000) GS:ffff88852cb80000(0000) knlGS:0000000000000000
[  875.668839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.669347] CR2: 000000012547108f CR3: 00000001805ff002 CR4: 0000000000372ea0
[  875.669950] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.670550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.671160] Call Trace:
[  875.671452]  <TASK>
[  875.671724]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.672197]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.672658]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.673139]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.673571]  svc_process_common+0x2b6/0x4d0
[  875.673980]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.674397]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.674877]  svc_process+0xd4/0xf0
[  875.675237]  nfsd+0xcb/0x180 [nfsd]
[  875.675606]  kthread+0xb9/0xe0
[  875.675942]  ? kthread_complete_and_exit+0x20/0x20
[  875.676394]  ret_from_fork+0x1f/0x30
[  875.676769]  </TASK>
[  875.677044] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
[  875.681102] CR2: 000000012547108f
[  875.681459] ---[ end trace 0000000000000000 ]---
[  875.681460] BUG: kernel NULL pointer dereference, address: 00000000000000d0
[  875.681689] RIP: 0010:vfs_setlease+0x27/0x70
[  875.682042] #PF: supervisor read access in kernel mode
[  875.682259] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.682517] #PF: error_code(0x0000) - not-present page
[  875.683402] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.683656] PGD 0
[  875.683865]
[  875.684122] P4D 0
[  875.684233] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.684321]
[  875.684430] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.684787] Oops: 0000 [#4] SMP
[  875.684874] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.685226] CPU: 3 PID: 12146 Comm: nfsd Tainted: G      D W          6.1.0-rc7_ac3a2585f018 #1
[  875.685397] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.685748] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.686175] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.686525] RIP: 0010:vfs_setlease+0x27/0x70
[  875.687063] FS:  0000000000000000(0000) GS:ffff88852cb80000(0000) knlGS:0000000000000000
[  875.687412] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.687629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.688023] RSP: 0018:ffff88811b81fdb0 EFLAGS: 00010246
[  875.688915] CR2: 000000012547108f CR3: 00000001805ff002 CR4: 0000000000372ea0
[  875.689200]
[  875.689462] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.689809] RAX: 0000000000000000 RBX: ffff88824866c230 RCX: ffff88811b81fdd8
[  875.689896] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.690242] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560ad00
[  875.698805] RBP: ffff88812560ad00 R08: ffff8881dd381b00 R09: ffffffff82407740
[  875.699422] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.700031] R13: ffff8881dd381b00 R14: ffff888110e5e028 R15: ffff888110e5e1a0
[  875.700643] FS:  0000000000000000(0000) GS:ffff88852c980000(0000) knlGS:0000000000000000
[  875.701384] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.701892] CR2: 00000000000000d0 CR3: 0000000180622003 CR4: 0000000000372ea0
[  875.702501] Call Trace:
[  875.702797]  <TASK>
[  875.703065]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.703536]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.703992]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.704463]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.704897]  svc_process_common+0x2b6/0x4d0
[  875.705305]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.705717]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.706194]  svc_process+0xd4/0xf0
[  875.706549]  nfsd+0xcb/0x180 [nfsd]
[  875.706919]  kthread+0xb9/0xe0
[  875.707257]  ? kthread_complete_and_exit+0x20/0x20
[  875.707706]  ret_from_fork+0x1f/0x30
[  875.708073]  </TASK>
[  875.708348] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
[  875.721375] CR2: 00000000000000d0
[  875.721738] ---[ end trace 0000000000000000 ]---
[  875.721738] BUG: kernel NULL pointer dereference, address: 0000000000000028
[  875.721972] RIP: 0010:vfs_setlease+0x27/0x70
[  875.722317] #PF: supervisor read access in kernel mode
[  875.722530] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.722782] #PF: error_code(0x0000) - not-present page
[  875.723675] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.723929] PGD 0
[  875.724135]
[  875.724393] P4D 0
[  875.724499] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.724584]
[  875.724695] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.725055] Oops: 0000 [#5] SMP
[  875.725140] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.725485] CPU: 2 PID: 12142 Comm: nfsd Tainted: G      D W          6.1.0-rc7_ac3a2585f018 #1
[  875.725647] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.725992] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.726411] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.726755] RIP: 0010:vfs_setlease+0x1d/0x70
[  875.727285] FS:  0000000000000000(0000) GS:ffff88852c980000(0000) knlGS:0000000000000000
[  875.727631] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
[  875.727843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.728225] RSP: 0018:ffff88811b813db0 EFLAGS: 00010246
[  875.729115] CR2: 00000000000000d0 CR3: 0000000180622003 CR4: 0000000000372ea0
[  875.729396]
[  875.735502] RAX: ffff888180715000 RBX: ffff8881034da000 RCX: ffff88811b813dd8
[  875.736015] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
[  875.736531] RBP: 0000000000000000 R08: ffff888248d73200 R09: ffffffff824065b8
[  875.737043] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.737560] R13: ffff888248d73200 R14: ffff88824501c028 R15: ffff88824501c1a0
[  875.738063] FS:  0000000000000000(0000) GS:ffff88852c900000(0000) knlGS:0000000000000000
[  875.738678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.739118] CR2: 0000000000000028 CR3: 0000000105b6e003 CR4: 0000000000372ea0
[  875.739636] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.740138] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.740658] Call Trace:
[  875.740907]  <TASK>
[  875.741135]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.741558]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.741941]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.742334]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.742711]  svc_process_common+0x2b6/0x4d0
[  875.743064]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.743406]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.743816]  svc_process+0xd4/0xf0
[  875.744121]  nfsd+0xcb/0x180 [nfsd]
[  875.744437]  kthread+0xb9/0xe0
[  875.744733]  ? kthread_complete_and_exit+0x20/0x20
[  875.745123]  ret_from_fork+0x1f/0x30
[  875.745434]  </TASK>
[  875.745663] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
[  875.749118] CR2: 0000000000000028
[  875.749415] ---[ end trace 0000000000000000 ]---
[  875.749415] BUG: kernel NULL pointer dereference, address: 0000000000000028
[  875.749614] RIP: 0010:vfs_setlease+0x27/0x70
[  875.750031] #PF: supervisor read access in kernel mode
[  875.750214] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.750521] #PF: error_code(0x0000) - not-present page
[  875.751290] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.751596] PGD 0
[  875.751766]
[  875.752079] P4D 0
[  875.752173] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.752276]
[  875.752371] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.752797] Oops: 0000 [#6] SMP
[  875.752874] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.753291] CPU: 4 PID: 12145 Comm: nfsd Tainted: G      D W          6.1.0-rc7_ac3a2585f018 #1
[  875.753429] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.753848] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.754219] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.754638] RIP: 0010:vfs_setlease+0x1d/0x70
[  875.755100] FS:  0000000000000000(0000) GS:ffff88852c900000(0000) knlGS:0000000000000000
[  875.755522] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
[  875.755709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.756176] RSP: 0018:ffff88811d127db0 EFLAGS: 00010246
[  875.756949] CR2: 0000000000000028 CR3: 0000000105b6e003 CR4: 0000000000372ea0
[  875.757293]
[  875.757527] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.757946] RAX: ffff888180715068 RBX: ffff8881034da118 RCX: ffff88811d127dd8
[  875.758023] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.758441] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
[  875.768979] RBP: 0000000000000000 R08: ffff888248d72a00 R09: ffffffff824067b0
[  875.769725] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.770466] R13: ffff888248d72a00 R14: ffff888110e5a028 R15: ffff888110e5a1a0
[  875.771201] FS:  0000000000000000(0000) GS:ffff88852ca00000(0000) knlGS:0000000000000000
[  875.772096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.772725] CR2: 0000000000000028 CR3: 0000000113338003 CR4: 0000000000372ea0
[  875.773464] Call Trace:
[  875.773824]  <TASK>
[  875.774160]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.774737]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.775292]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.775863]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.776398]  svc_process_common+0x2b6/0x4d0
[  875.776910]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.777411]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.777994]  svc_process+0xd4/0xf0
[  875.778437]  nfsd+0xcb/0x180 [nfsd]
[  875.778894]  kthread+0xb9/0xe0
[  875.779305]  ? kthread_complete_and_exit+0x20/0x20
[  875.779859]  ret_from_fork+0x1f/0x30
[  875.780316]  </TASK>
[  875.780651] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
[  875.785657] CR2: 0000000000000028
[  875.786087] ---[ end trace 0000000000000000 ]---
[  875.786088] BUG: kernel NULL pointer dereference, address: 0000000000000028
[  875.786366] RIP: 0010:vfs_setlease+0x27/0x70
[  875.786700] #PF: supervisor read access in kernel mode
[  875.786962] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.787209] #PF: error_code(0x0000) - not-present page
[  875.788286] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.788528] PGD 0
[  875.788794]
[  875.789047] P4D 0
[  875.789181] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.789264]
[  875.789396] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.789735] Oops: 0000 [#7] SMP
[  875.789841] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.790181] CPU: 0 PID: 12141 Comm: nfsd Tainted: G      D W          6.1.0-rc7_ac3a2585f018 #1
[  875.790380] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.790715] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.791221] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.791561] RIP: 0010:vfs_setlease+0x1d/0x70
[  875.792214] FS:  0000000000000000(0000) GS:ffff88852ca00000(0000) knlGS:0000000000000000
[  875.792552] Code: 19 37 76 00 49 89 ee e9 ac fc ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f <48> 8b 45 28 4c 89 e2 48 89 ef 48 8b 80 d0 00 00 00 48 85 c0 74 2c
[  875.792825] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.793203] RSP: 0018:ffff888244b23db0 EFLAGS: 00010246
[  875.794279] CR2: 0000000000000028 CR3: 0000000113338003 CR4: 0000000000372ea0
[  875.794556]
[  875.801646] RAX: ffff8881807151a0 RBX: ffff8881034da460 RCX: ffff888244b23dd8
[  875.802232] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
[  875.802821] RBP: 0000000000000000 R08: ffff888248d72f00 R09: ffffffff824062b8
[  875.812350] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.812947] R13: ffff888248d72f00 R14: ffff888245018028 R15: ffff8882450181a0
[  875.813536] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
[  875.814245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.814741] CR2: 0000000000000028 CR3: 00000001ca27d001 CR4: 0000000000372eb0
[  875.815331] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.815919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.816504] Call Trace:
[  875.816801]  <TASK>
[  875.817061]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.817525]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.817968]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.818422]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.818838]  svc_process_common+0x2b6/0x4d0
[  875.819238]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.819642]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.820101]  svc_process+0xd4/0xf0
[  875.820449]  nfsd+0xcb/0x180 [nfsd]
[  875.820821]  kthread+0xb9/0xe0
[  875.821149]  ? kthread_complete_and_exit+0x20/0x20
[  875.821590]  ret_from_fork+0x1f/0x30
[  875.821946]  </TASK>
[  875.822213] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
[  875.826147] CR2: 0000000000000028
[  875.826491] ---[ end trace 0000000000000000 ]---
[  875.826492] BUG: kernel NULL pointer dereference, address: 00000000000000d0
[  875.826715] RIP: 0010:vfs_setlease+0x27/0x70
[  875.827026] #PF: supervisor read access in kernel mode
[  875.827237] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.827455] #PF: error_code(0x0000) - not-present page
[  875.828299] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
[  875.828516] PGD 0 P4D 0
[  875.828722]
[  875.828943]
[  875.829075] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8
[  875.829152] Oops: 0000 [#8] SMP
[  875.829234] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560a200
[  875.829529] CPU: 6 PID: 12144 Comm: nfsd Tainted: G      D W          6.1.0-rc7_ac3a2585f018 #1
[  875.829690] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: ffffffff824064e0
[  875.829993] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  875.830400] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.830699] RIP: 0010:vfs_setlease+0x27/0x70
[  875.831221] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888110e621a0
[  875.831516] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
[  875.831723] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
[  875.832014] RSP: 0018:ffff88811467fdb0 EFLAGS: 00010246
[  875.832874] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.833205]
[  875.833454] CR2: 0000000000000028 CR3: 00000001ca27d001 CR4: 0000000000372eb0
[  875.833698] RAX: 0000000000000000 RBX: ffff88824866c460 RCX: ffff88811467fdd8
[  875.833784] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.834078] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88812560b000
[  875.834411] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.834706] RBP: ffff88812560b000 R08: ffff8881dd381300 R09: ffffffff824069c0
[  875.841961] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  875.842471] R13: ffff8881dd381300 R14: ffff8881010ca028 R15: ffff8881010ca1a0
[  875.842999] FS:  0000000000000000(0000) GS:ffff88852cb00000(0000) knlGS:0000000000000000
[  875.843608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  875.844056] CR2: 00000000000000d0 CR3: 0000000105b6e002 CR4: 0000000000372ea0
[  875.844565] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  875.845081] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  875.845590] Call Trace:
[  875.845835]  <TASK>
[  875.846072]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
[  875.846465]  nfsd4_delegreturn+0x119/0x150 [nfsd]
[  875.846850]  nfsd4_proc_compound+0x282/0x5d0 [nfsd]
[  875.847263]  nfsd_dispatch+0x15d/0x250 [nfsd]
[  875.847627]  svc_process_common+0x2b6/0x4d0
[  875.847968]  ? nfsd_svc+0x330/0x330 [nfsd]
[  875.848322]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[  875.848720]  svc_process+0xd4/0xf0
[  875.849025]  nfsd+0xcb/0x180 [nfsd]
[  875.849344]  kthread+0xb9/0xe0
[  875.849625]  ? kthread_complete_and_exit+0x20/0x20
[  875.850001]  ret_from_fork+0x1f/0x30
[  875.850313]  </TASK>
[  875.850539] Modules linked in: nfsd iptable_raw bonding mlx5_vfio_pci rdma_ucm ipip tunnel4 ip_gre ib_umad nf_tables vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_type1 mlx5_ib vfio ib_uverbs ib_ipoib mlx5_core ip6_gre gre ip6_tunnel tunnel6 geneve nfnetlink_cttimeout openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_nat iptable_mangle ip6table_filter ip6_tables xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core fuse [last unloaded: nf_tables]
[  875.853944] CR2: 00000000000000d0
[  875.854240] ---[ end trace 0000000000000000 ]---

> ---
>  fs/nfsd/filecache.c | 247 ++++++++++++++++++++++----------------------
>  fs/nfsd/trace.h     |   1 +
>  2 files changed, 123 insertions(+), 125 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 0bf3727455e2..e67297ad12bf 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -303,8 +303,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
>  		if (key->gc)
>  			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>  		nf->nf_inode = key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
>  		nf->nf_may = key->need;
>  		nf->nf_mark = NULL;
>  	}
> @@ -353,24 +352,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
>  	return false;
>  }
>  
> -static bool
> +static void
>  nfsd_file_free(struct nfsd_file *nf)
>  {
>  	s64 age = ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> -	bool flush = false;
>  
>  	trace_nfsd_file_free(nf);
>  
>  	this_cpu_inc(nfsd_file_releases);
>  	this_cpu_add(nfsd_file_total_age, age);
>  
> +	nfsd_file_unhash(nf);
> +
> +	/*
> +	 * We call fsync here in order to catch writeback errors. It's not
> +	 * strictly required by the protocol, but an nfsd_file coule get
> +	 * evicted from the cache before a COMMIT comes in. If another
> +	 * task were to open that file in the interim and scrape the error,
> +	 * then the client may never see it. By calling fsync here, we ensure
> +	 * that writeback happens before the entry is freed, and that any
> +	 * errors reported result in the write verifier changing.
> +	 */
> +	nfsd_file_fsync(nf);
> +
>  	if (nf->nf_mark)
>  		nfsd_file_mark_put(nf->nf_mark);
>  	if (nf->nf_file) {
>  		get_file(nf->nf_file);
>  		filp_close(nf->nf_file, NULL);
>  		fput(nf->nf_file);
> -		flush = true;
>  	}
>  
>  	/*
> @@ -378,10 +388,9 @@ nfsd_file_free(struct nfsd_file *nf)
>  	 * WARN and leak it to preserve system stability.
>  	 */
>  	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> -		return flush;
> +		return;
>  
>  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> -	return flush;
>  }
>  
>  static bool
> @@ -397,17 +406,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>  }
>  
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>  {
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>  		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
>  }
>  
> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>  {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
>  		trace_nfsd_file_lru_del(nf);
> +		return true;
> +	}
> +	return false;
>  }
>  
>  struct nfsd_file *
> @@ -418,86 +433,80 @@ nfsd_file_get(struct nfsd_file *nf)
>  	return NULL;
>  }
>  
> -static void
> +/**
> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispose list
> + * @nf: nfsd_file to be unhashed and queued
> + * @dispose: list to which it should be queued
> + *
> + * Attempt to unhash a nfsd_file and queue it to the given list. Each file
> + * will have a reference held on behalf of the list. That reference may come
> + * from the LRU, or we may need to take one. If we can't get a reference,
> + * ignore it altogether.
> + */
> +static bool
>  nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
>  {
>  	trace_nfsd_file_unhash_and_queue(nf);
>  	if (nfsd_file_unhash(nf)) {
> -		/* caller must call nfsd_file_dispose_list() later */
> -		nfsd_file_lru_remove(nf);
> +		/*
> +		 * If we remove it from the LRU, then just use that
> +		 * reference for the dispose list. Otherwise, we need
> +		 * to take a reference. If that fails, just ignore
> +		 * the file altogether.
> +		 */
> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> +			return false;
>  		list_add(&nf->nf_lru, dispose);
> +		return true;
>  	}
> +	return false;
>  }
>  
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> -{
> -	trace_nfsd_file_put(nf);
> -
> -	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> -	}
> -}
> -
> -static void
> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> -{
> -	if (nfsd_file_unhash(nf))
> -		nfsd_file_put_noref(nf);
> -}
> -
> +/**
> + * nfsd_file_put - put the reference to a nfsd_file
> + * @nf: nfsd_file of which to put the reference
> + *
> + * Put a reference to a nfsd_file. In the v4 case, we just put the
> + * reference immediately. In the GC case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
>  void
>  nfsd_file_put(struct nfsd_file *nf)
>  {
>  	might_sleep();
> +	trace_nfsd_file_put(nf);
>  
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) == 2)
> -		nfsd_file_unhash_and_put(nf);
> -
> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> -}
> -
> -static void
> -nfsd_file_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	while(!list_empty(dispose)) {
> -		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> +	/*
> +	 * The HASHED check is racy. We may end up with the occasional
> +	 * unhashed entry on the LRU, but they should get cleaned up
> +	 * like any other.
> +	 */
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref == 1), then transfer
> +		 * it to the LRU. If the add to the LRU fails, just put it as
> +		 * usual.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
> +			nfsd_file_schedule_laundrette();
> +			return;
> +		}
>  	}
> +	if (refcount_dec_and_test(&nf->nf_ref))
> +		nfsd_file_free(nf);
>  }
>  
>  static void
> -nfsd_file_dispose_list_sync(struct list_head *dispose)
> +nfsd_file_dispose_list(struct list_head *dispose)
>  {
> -	bool flush = false;
>  	struct nfsd_file *nf;
>  
>  	while(!list_empty(dispose)) {
>  		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
> -		if (!refcount_dec_and_test(&nf->nf_ref))
> -			continue;
> -		if (nfsd_file_free(nf))
> -			flush = true;
> +		nfsd_file_free(nf);
>  	}
> -	if (flush)
> -		flush_delayed_fput();
>  }
>  
>  static void
> @@ -567,21 +576,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>  	struct list_head *head = arg;
>  	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
>  
> -	/*
> -	 * Do a lockless refcount check. The hashtable holds one reference, so
> -	 * we look to see if anything else has a reference, or if any have
> -	 * been put since the shrinker last ran. Those don't get unhashed and
> -	 * released.
> -	 *
> -	 * Note that in the put path, we set the flag and then decrement the
> -	 * counter. Here we check the counter and then test and clear the flag.
> -	 * That order is deliberate to ensure that we can do this locklessly.
> -	 */
> -	if (refcount_read(&nf->nf_ref) > 1) {
> -		list_lru_isolate(lru, &nf->nf_lru);
> -		trace_nfsd_file_gc_in_use(nf);
> -		return LRU_REMOVED;
> -	}
> +	/* We should only be dealing with GC entries here */
> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>  
>  	/*
>  	 * Don't throw out files that are still undergoing I/O or
> @@ -592,40 +588,30 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>  		return LRU_SKIP;
>  	}
>  
> +	/* If it was recently added to the list, skip it */
>  	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>  		trace_nfsd_file_gc_referenced(nf);
>  		return LRU_ROTATE;
>  	}
>  
> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_hashed(nf);
> -		return LRU_SKIP;
> +	/*
> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
> +	 * one, then just remove it from the LRU and ignore it.
> +	 */
> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +		trace_nfsd_file_gc_in_use(nf);
> +		list_lru_isolate(lru, &nf->nf_lru);
> +		return LRU_REMOVED;
>  	}
>  
> +	/* Refcount went to zero. Unhash it and queue it to the dispose list */
> +	nfsd_file_unhash(nf);
>  	list_lru_isolate_move(lru, &nf->nf_lru, head);
>  	this_cpu_inc(nfsd_file_evictions);
>  	trace_nfsd_file_gc_disposed(nf);
>  	return LRU_REMOVED;
>  }
>  
> -/*
> - * Unhash items on @dispose immediately, then queue them on the
> - * disposal workqueue to finish releasing them in the background.
> - *
> - * cel: Note that between the time list_lru_shrink_walk runs and
> - * now, these items are in the hash table but marked unhashed.
> - * Why release these outside of lru_cb ? There's no lock ordering
> - * problem since lru_cb currently takes no lock.
> - */
> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	list_for_each_entry(nf, dispose, nf_lru)
> -		nfsd_file_hash_remove(nf);
> -	nfsd_file_dispose_list_delayed(dispose);
> -}
> -
>  static void
>  nfsd_file_gc(void)
>  {
> @@ -635,7 +621,7 @@ nfsd_file_gc(void)
>  	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>  			    &dispose, list_lru_count(&nfsd_file_lru));
>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
>  }
>  
>  static void
> @@ -660,7 +646,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
>  	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
>  				   nfsd_file_lru_cb, &dispose);
>  	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
>  	return ret;
>  }
>  
> @@ -671,8 +657,11 @@ static struct shrinker	nfsd_file_shrinker = {
>  };
>  
>  /*
> - * Find all cache items across all net namespaces that match @inode and
> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
> + * Find all cache items across all net namespaces that match @inode, unhash
> + * them, take references and then put them on @dispose if that was successful.
> + *
> + * The nfsd_file objects on the list will be unhashed, and each will have a
> + * reference taken.
>   */
>  static unsigned int
>  __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> @@ -690,8 +679,9 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
>  				       nfsd_file_rhash_params);
>  		if (!nf)
>  			break;
> -		nfsd_file_unhash_and_queue(nf, dispose);
> -		count++;
> +
> +		if (nfsd_file_unhash_and_queue(nf, dispose))
> +			count++;
>  	} while (1);
>  	rcu_read_unlock();
>  	return count;
> @@ -703,15 +693,23 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
>   *
>   * Unhash and put all cache item associated with @inode.
>   */
> -static void
> +static unsigned int
>  nfsd_file_close_inode(struct inode *inode)
>  {
> -	LIST_HEAD(dispose);
> +	struct nfsd_file *nf;
>  	unsigned int count;
> +	LIST_HEAD(dispose);
>  
>  	count = __nfsd_file_close_inode(inode, &dispose);
>  	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	while(!list_empty(&dispose)) {
> +		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
> +		list_del_init(&nf->nf_lru);
> +		trace_nfsd_file_closing(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> +	}
> +	return count;
>  }
>  
>  /**
> @@ -723,19 +721,15 @@ nfsd_file_close_inode(struct inode *inode)
>  void
>  nfsd_file_close_inode_sync(struct inode *inode)
>  {
> -	LIST_HEAD(dispose);
> -	unsigned int count;
> -
> -	count = __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
> +	if (nfsd_file_close_inode(inode))
> +		flush_delayed_fput();
>  }
>  
>  /**
>   * nfsd_file_delayed_close - close unused nfsd_files
>   * @work: dummy
>   *
> - * Walk the LRU list and close any entries that have not been used since
> + * Walk the LRU list and destroy any entries that have not been used since
>   * the last scan.
>   */
>  static void
> @@ -1056,8 +1050,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	rcu_read_lock();
>  	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>  			       nfsd_file_rhash_params);
> -	if (nf)
> -		nf = nfsd_file_get(nf);
> +	if (nf) {
> +		if (!nfsd_file_lru_remove(nf))
> +			nf = nfsd_file_get(nf);
> +	}
>  	rcu_read_unlock();
>  	if (nf)
>  		goto wait_for_construction;
> @@ -1092,11 +1088,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			goto out;
>  		}
>  		open_retry = false;
> -		nfsd_file_put_noref(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
>  		goto retry;
>  	}
>  
> -	nfsd_file_lru_remove(nf);
>  	this_cpu_inc(nfsd_file_cache_hits);
>  
>  	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
> @@ -1106,7 +1102,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			this_cpu_inc(nfsd_file_acquisitions);
>  		*pnf = nf;
>  	} else {
> -		nfsd_file_put(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
>  		nf = NULL;
>  	}
>  
> @@ -1133,7 +1130,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	 * then unhash.
>  	 */
>  	if (status != nfs_ok || key.inode->i_nlink == 0)
> -		nfsd_file_unhash_and_put(nf);
> +		nfsd_file_unhash(nf);
>  	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>  	smp_mb__after_atomic();
>  	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 940252482fd4..a44ded06af87 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>  
>  TRACE_EVENT(nfsd_file_alloc,
