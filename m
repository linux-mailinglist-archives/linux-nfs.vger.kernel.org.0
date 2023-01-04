Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023DE65DCF9
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 20:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbjADTkf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 14:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjADTke (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 14:40:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20704.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::704])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B43395DF;
        Wed,  4 Jan 2023 11:40:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUnUQvlExJ/cA0SctKoSquSnEL21SzNTjOUr59zGEtx23332y8gAhU+6jPDEhCGh+zTcFvc3SsKG6xmyW4gl3B2Fi6BCWOyZ4v74PUWdPab5gBA+6zveTjmkoinfB3bRls0Yb6qZFFz0SyQD4ADXrTVBMq24ZyIdBypOiFMF+j8SAgFo1d0q0HtSGewoh239s+phmP1Oi7l2U6NCcmshPwa928TFluvvdxhLsijlUrKt9v9+MCvoNvOjzBXTV70ff5DMlsl1sLha1Fb1oOo+EDeCQbHR56VJfQ6/bKC+Ia2+b3go4ICyCFEj5ah1A4MHg6j7sQejqpQM9AzFX3u02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+MMQbni3Pk43j58duxt00NU8vsOpYDp0FMYz9qal9Q=;
 b=VR632aA4kTt47lHfggd399ZqKDncK9RlO2jzDKRMzVlm2//sD/kF0+nseCEB1SsygI9QIrcRWE5m/TaUmSwlvP1IBj3ILdnCPMRwpGx5rmeX5AaBRrr2GUuk3S24iT8dDWEDgfUMvxzs8YiHzcHqbdJBo0xi92O+YixTMWW9uqYVFSbpSQTZvdcdpi6x/M4YuFOFXQqP8dMv9ZMfbDYEVcZ4i1CmdSqGXKH4IqIJIygSw1iL7IcYTPtNAhuYUGmFaADh6uHEd/FhDjCZOR3I2FjoTleDwM7sdFEaD05rV0gmCVzwW9wrgm1QYL5Y26y9ZdzZBmd8PiW7kpwjxSWB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+MMQbni3Pk43j58duxt00NU8vsOpYDp0FMYz9qal9Q=;
 b=MeH2SWcs4rV0VTRsGA2IjmYT6TYvXZkXE/VfpRE8NFf//eDs/g5XVnTUtUjVk4BPsWhsPQcSGkoJvFLxQueeN5AE03JiP7y4/VMNkqg4f5tr1hqy2wMy45xWJmY8U/lg98wRcBzgZ89J28XeBEuLbA6rD3dEiE9XIOpXK1jMOo8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO1PR13MB5032.namprd13.prod.outlook.com (2603:10b6:303:f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 19:40:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 19:40:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Jeffrey Layton <jlayton@redhat.com>
CC:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: weird smp memory-barrier issue with nfsd filecache code
Thread-Topic: weird smp memory-barrier issue with nfsd filecache code
Thread-Index: AQHZIHHAUCxppRZUpESNx7p0m3j7Za6Op9wA
Date:   Wed, 4 Jan 2023 19:40:28 +0000
Message-ID: <5316FDA2-F413-434D-9E39-A87EEB447D69@hammerspace.com>
References: <4c566912cddf72718d0308a2f26bf38d0829901c.camel@redhat.com>
In-Reply-To: <4c566912cddf72718d0308a2f26bf38d0829901c.camel@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO1PR13MB5032:EE_
x-ms-office365-filtering-correlation-id: af018444-3e6f-4b94-b694-08daee8b88a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2UY046U8bVAy33XMlKcYaATbnagj7d6l9KDuWvri2VwC5vEFAY+9/+aZUKxuosHNTfpZL4zqnaBMFA3Lwf89p3hPT0ykCuuQ7BnTB/QfEpjpze79rLF52CwafqWZplGkXOlLSrW173UenKfb4krDt0vERpo2p0sMxdlAq4R5vWoeAMuN/FTYH83/MXFtwjt6qh980D6mgJZ1eAbaRConsComfaLokqojZE+IDDm7mCS5qSpVH1YK96ti0YG+LZXOBcQyON+6+DP4HBJ6RhuSFIM4q6/HoHtLk9S7I5o//sJm85kHvdfHueb/TZEFAkzI3rWTJmrh9W5tVBtXZ9sk9028BzjmfKVayCdgzqxcW1zLBb4NBPSGOpG5C1SHldtL9kDKt1zAj2FaLpX4AXhNMlwlkckjQmoqVh2TOY/AHylZiiLXmqkpG6piYsnJoWNKTyCIS88yCayfZ8OKY+4aXILLt84JTPEGmLl+nvvO8rhOKdFEgoQGgDTr+1RhrSablEDC+amBG4wayqA10ykKIYO++6luRgSmWTh6Gx6mFuxo19Ai/AdY63P0SNnJd3PCBBTPHeVmmkNeG+JhUMHN//1t7Bz/bww0MI2AhwpP7ilGzM13Dljb04HBzKdV8CzNSyBDFwbVFxgdTd7Jbe2CN+cmCah2A7kqAjNH1M+uvXsZcNZ1teqC2cgfuPDs2nFlZFA6XMcvBIJu+onE7egtmP1xfOfFBnVYURKF+vxmDvkkLmHmXOtHnKNh1+xeE9hesuw/jRh+jTIVhik4ru5dcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(136003)(39830400003)(376002)(451199015)(6512007)(478600001)(6486002)(5660300002)(36756003)(71200400001)(2616005)(122000001)(38100700002)(45080400002)(8936002)(33656002)(6506007)(76116006)(66476007)(66946007)(41300700001)(66446008)(66556008)(4326008)(8676002)(91956017)(38070700005)(64756008)(53546011)(83380400001)(6916009)(316002)(26005)(186003)(54906003)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aM+jDeKGHzVBrDGog/5sTnvSDYQ8wkQHhcDJHV2fM8sRbpwxK5LTKFk//2pQ?=
 =?us-ascii?Q?T5UEjH3GMeK3zVrlT5FdF2HrJoLyI68A1+gl1bdMeBDRID1aIqdPUP7bYuGC?=
 =?us-ascii?Q?MWmiLxhdCTg+ptUywECKVZimSMk+gn1ZGAhwG1FIvzbwsJcITs0RMhTrPmPo?=
 =?us-ascii?Q?rvFh1aLpmqqPk44NuprZYqPjTSp16XNdBWh/XcoxrUiBDsYuvLIJfzBaDpmh?=
 =?us-ascii?Q?cY1cNet4v1ZnaBLFOfEeqBfuCVhiFMmN07qlKPHs6dAHhStLAOTcRMPeH2nV?=
 =?us-ascii?Q?1fkscpgMQHlTJYeE0Rq2rEd48fLUENH3MLhhgmBMjy0O3qZJgiI6P4BOK/ut?=
 =?us-ascii?Q?wmP2PLIlmYaDxc8BEk+g8XzYBwUV1VhsUaK5zhFrq/LWMQGiVHA4Pz+vBNZ7?=
 =?us-ascii?Q?kJ5dvHZ3TIyt6rioZV1qPn+9JDij+DsMWZrOo12ha0HvoRqinTCJFxBnhvii?=
 =?us-ascii?Q?iMVXAcIVyRBSXCCiZIRv1+dpenwsBz28zVCvAAIImU0i3MjJLeeuGGHp8mWo?=
 =?us-ascii?Q?r2I6DQzB9vQVmG9a/YUWmldD2tb1oYHur3pxffIkX8e9XPfHbKJNvmaPJ8eu?=
 =?us-ascii?Q?LDnY6jsTUVow6i4FCcVLPJc/BL1bVvrvb8cp9JTTsjxgJX24AGkuRr3YXi+8?=
 =?us-ascii?Q?jE8sAfRI2mAIlf3nRH1iZkaZB1gtHjR+343KzJp/jJ2JncgG9/JRs5MRUIxl?=
 =?us-ascii?Q?CGO3NiRlwbg7/nGBUqv8xHhqMtK8Hn2oEM2J6Bj6S83jcC4CT0xlWhoX7a3D?=
 =?us-ascii?Q?cLDldVdhqjJ/QkYJM7+vSiIxapjKPLbFQ52e30wsbsUOEOfOwyWFn8V5paU7?=
 =?us-ascii?Q?0d/i/ZwnBuHQKJs63+sAD5gx54IVnDygwaA/zB4DHHzhGCdCwkLMtyq5MibB?=
 =?us-ascii?Q?JlAkizuTXdj1YmYlQIKfAgQA/9pyiVSFZOnTEzKAwB5iCmF9U6AWlw1SwKL6?=
 =?us-ascii?Q?dSwIulTZL751t0Ek0xBSH70vWzyUw8dxAFbdq4hpCRwgA97emHtdyObJ/7BB?=
 =?us-ascii?Q?pcsRqv4tUnqtE3RV7K3eame2Tsih2sFVfNi7u/hVy9OSiIZKsXHZEcT2m7NJ?=
 =?us-ascii?Q?wDI6/ysoQM1DuKTS03cGk8r3Fq4Udu99Ay9WBNDxzizxJ2EYfU0avgx+6wXs?=
 =?us-ascii?Q?X1yMq1c5YFioWd0IZKT5KH86RuKRdxgNJO+L8GlGSqWgfHOi6Gnf3EikMane?=
 =?us-ascii?Q?UzYPtjFTJ/YEq2m+UKAlQFbLJ2emLNxePhFlKiAsCT9TlStGjTo6KpjyFgcu?=
 =?us-ascii?Q?s0Z9PmNEP+cNsSB1iJGXLgWaAgxzemS4Rdy4tqdWZoXxFtfcsN8IwALrWscy?=
 =?us-ascii?Q?fN9e/zzx9rm3LNSHkXxUcw6FX97kNJIh01CKlbcFeuZDu6WkfaRxn0xUrIO3?=
 =?us-ascii?Q?x7V7zB6QU3kmtKJA/C6+y//ChQPp18cTcAFGo56fLVTwg9YGaYHKubvpJERY?=
 =?us-ascii?Q?+3v1YIkJ6n7yKHWzDYl8DHMzZa7erhx9vamRQOzya45SNd+X2bQ6yRe39Gwv?=
 =?us-ascii?Q?p+KN1Ji3q7X1qvFfOkX7aRtaBXY6yPWaZ1BjqhZpZdvRa4e+b5qcK51lCKRV?=
 =?us-ascii?Q?sC+GqRss3VFtlRmvhJ5LS2vkZp3KlLspAxkwyNPwldmYQHsNIrcufTiXuBoW?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EA6E89A9FC55948B80774D426C786E5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af018444-3e6f-4b94-b694-08daee8b88a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 19:40:28.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4GbjaIWp6f8mUJS2e0UIi8tNPq5nHMMT5dYfkjVxtk61QuuoTIgF4G46T57TkzmF1IXjTEOKr+ZnOBspiLpKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 4, 2023, at 14:20, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> I had a report of a crash today. The kernel in question is older but has
> a backport of the most recent nfsd filecache patches. In particular
> nfsd_file_do_acquire is pretty much identical to the current mainline
> code:
>=20
> [1803883.048506] BUG: kernel NULL pointer dereference, address: 000000000=
0000020
> [1803883.048972] #PF: supervisor read access in kernel mode
> [1803883.049378] #PF: error_code(0x0000) - not-present page
> [1803883.049798] PGD 0 P4D 0=20
> [1803883.050171] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [1803883.050563] CPU: 16 PID: 3591 Comm: nfsd Kdump: loaded Tainted: G   =
        OE    --------- ---  5.14.0-210.jlayton.nfsd92.2.el9.x86_64 #1
> [1803883.051386] Hardware name: Supermicro Super Server/H11SSL-NC, BIOS 1=
.0b 04/27/2018
> [1803883.051820] RIP: 0010:nfsd_file_do_acquire+0x7fb/0x8b0 [nfsd]
> [1803883.052286] Code: 00 00 00 41 bc 00 00 27 18 e9 46 fc ff ff 89 c2 e9=
 df fb ff ff 48 8b 6c 24 20 65 48 ff 05 d5 57 cc 3e 49 8b 45 28 8b 74 24 08=
 <48> 8b 78 20 e8 9c 5d ff ff 89 c7 e8 95 27 ff ff 41 89 c4 e9 30 fc
> [1803883.053180] RSP: 0018:ffffb4ca5269fc40 EFLAGS: 00010206
> [1803883.053639] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000=
000000002
> [1803883.054106] RDX: 0000000080000000 RSI: 0000000000000002 RDI: ffff9c9=
722b6af40
> [1803883.054576] RBP: ffff9c90265f0000 R08: 0000000000000006 R09: 0000000=
00000062b
> [1803883.055056] R10: 0000000000000866 R11: 000000000000062b R12: ffffb4c=
a55e7d000
> [1803883.055544] R13: ffff9c936c971ea0 R14: ffff9c936c971ea0 R15: ffff9c9=
36c971ee0
> [1803883.056067] FS:  0000000000000000(0000) GS:ffff9c9b0f700000(0000) kn=
lGS:0000000000000000
> [1803883.056577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1803883.057093] CR2: 0000000000000020 CR3: 0000000c3e450000 CR4: 0000000=
0003506e0
> [1803883.057621] Call Trace:
> [1803883.058155]  <TASK>
> [1803883.058700]  nfs4_get_vfs_file+0x3dd/0x410 [nfsd]
> [1803883.059283]  nfsd4_process_open2+0x412/0x9f0 [nfsd]
> [1803883.059854]  nfsd4_open+0x282/0x4b0 [nfsd]
> [1803883.060398]  nfsd4_proc_compound+0x44b/0x6f0 [nfsd]
> [1803883.060966]  nfsd_dispatch+0x149/0x270 [nfsd]
> [1803883.061520]  svc_process_common+0x3bc/0x5e0 [sunrpc]
> [1803883.062099]  ? nfsd_svc+0x190/0x190 [nfsd]
> [1803883.062667]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
> [1803883.063238]  svc_process+0xb7/0xf0 [sunrpc]
> [1803883.063826]  nfsd+0xd5/0x190 [nfsd]
> [1803883.064408]  kthread+0xd9/0x100
> [1803883.064959]  ? kthread_complete_and_exit+0x20/0x20
> [1803883.065501]  ret_from_fork+0x22/0x30
> [1803883.066052]  </TASK>
> [1803883.066592] Modules linked in: mst_pciconf(OE) mst_pci(OE) overlay n=
fsd nfs_acl binfmt_misc dm_cache_smq dm_cache dm_persistent_data dm_bio_pri=
son dm_bufio rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache netf=
s rbd libceph dns_resolver 8021q garp mrp stp llc bonding nft_fib_inet nft_=
fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6=
 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defr=
ag_ipv4 rfkill ip_set nf_tables nfnetlink rpcrdma sunrpc rdma_ucm ib_srpt i=
b_isert iscsi_target_mod target_core_mod ipmi_ssif ib_iser libiscsi scsi_tr=
ansport_iscsi intel_rapl_msr ib_umad intel_rapl_common rdma_cm ib_ipoib iw_=
cm amd64_edac edac_mce_amd ib_cm kvm_amd kvm mlx5_ib mlx4_ib ib_uverbs irqb=
ypass rapl pcspkr ib_core joydev acpi_ipmi i2c_piix4 k10temp ipmi_si ipmi_d=
evintf ipmi_msghandler acpi_cpufreq xfs libcrc32c raid1 sd_mod sg mlx5_core=
 ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect crct10dif_pclmu=
l sysimgblt crc32_pclmul nvme
> [1803883.066656]  fb_sys_fops crc32c_intel ahci mpt3sas drm_ttm_helper nv=
me_core ttm libahci mlxfw ghash_clmulni_intel igb mlx4_core tls nvme_common=
 drm libata raid_class psample scsi_transport_sas t10_pi ccp pci_hyperv_int=
f sp5100_tco dca i2c_algo_bit dm_mirror dm_region_hash dm_log dm_mod fuse
> [1803883.074377] CR2: 0000000000000020
>=20
> We got a coredump from this one, and I did a bit of analysis:
>=20
> wait_for_construction:
>        wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE=
);
>=20
>        /* Did construction of this file fail? */
>        if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>                trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
>                if (!open_retry) {
>                        status =3D nfserr_jukebox;
>                        goto out;
>                }
>                open_retry =3D false;
>                if (refcount_dec_and_test(&nf->nf_ref))
>                        nfsd_file_free(nf);
>                goto retry;
>        }
>=20
>        this_cpu_inc(nfsd_file_cache_hits);
>=20
>        status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file),=
 may_flags));     <<<< CRASH HERE
> out:
>        if (status =3D=3D nfs_ok) {
>                if (open)
>                        this_cpu_inc(nfsd_file_acquisitions);
>                *pnf =3D nf;
>        } else {
>                if (refcount_dec_and_test(&nf->nf_ref))
>                        nfsd_file_free(nf);
>                nf =3D NULL;
>        }
>=20
> out_status:
>        put_cred(key.cred);
>        if (open)
>                trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, s=
tatus);
>        return status;
>=20
> open_file:
>        trace_nfsd_file_alloc(nf);
>        nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
>        if (nf->nf_mark) {
>                if (open) {
>                        status =3D nfsd_open_verified(rqstp, fhp, may_flag=
s,
>                                                    &nf->nf_file);
>                        trace_nfsd_file_open(nf, status);
>                } else
>                        status =3D nfs_ok;
>        } else
>                status =3D nfserr_jukebox;
>        /*
>         * If construction failed, or we raced with a call to unlink()
>         * then unhash.
>         */
>        if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
>                status =3D nfserr_jukebox;
>        if (status !=3D nfs_ok)
>                nfsd_file_unhash(nf);
>        clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>        smp_mb__after_atomic();
>        wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>        goto out;
>=20
> Relevant disassembly:
>=20
> /usr/src/debug/kernel-5.14.0-210.jlayton.nfsd92.2.el9/linux-5.14.0-210.jl=
ayton.nfsd92.2.el9.x86_64/./include/linux/fs.h: 1348                       =
               =20
> 0xffffffffc1368883 <nfsd_file_do_acquire+0x7f3>:        mov    0x28(%r13)=
,%rax
> /usr/src/debug/kernel-5.14.0-210.jlayton.nfsd92.2.el9/linux-5.14.0-210.jl=
ayton.nfsd92.2.el9.x86_64/fs/nfsd/filecache.c: 1145                        =
               =20
> 0xffffffffc1368887 <nfsd_file_do_acquire+0x7f7>:        mov    0x8(%rsp),=
%esi
> 0xffffffffc136888b <nfsd_file_do_acquire+0x7fb>:        mov    0x20(%rax)=
,%rdi         <<< CRASH HERE
>=20
> crash> struct -o nfsd_file
> struct nfsd_file {
>   [0x0] struct rhash_head nf_rhash;
>   [0x8] struct list_head nf_lru;
>  [0x18] struct callback_head nf_rcu;
>  [0x28] struct file *nf_file;
>  [0x30] const struct cred *nf_cred;
>  [0x38] struct net *nf_net;
>  [0x40] unsigned long nf_flags;
>  [0x48] struct inode *nf_inode;
>  [0x50] refcount_t nf_ref;
>  [0x54] unsigned char nf_may;
>  [0x58] struct nfsd_file_mark *nf_mark;
>  [0x60] ktime_t nf_birthtime;
> }
>=20
> nf_file is 0x28 bytes into that struct, so the mov at +0x7f3 is probably
> the dereferencing of that. That means that the addr of the nfsd_file is
> (probably) in %r13. Based on that, nf_file looks like a legit address.
>=20
> crash> struct nfsd_file ffff9c936c971ea0
> struct nfsd_file {
>  nf_rhash =3D {
>    next =3D 0xffffb4ca55ef9209
>  },
>  nf_lru =3D {
>    next =3D 0xffff9c936c971ea8,
>    prev =3D 0xffff9c936c971ea8

The above means nf_lru is not hashed (next=3D=3Dprev=3D=3D&nf_lru)

>  },
>  nf_rcu =3D {
>    next =3D 0xffff9c93995c3218,
>    func =3D 0x0
>  },
>  nf_file =3D 0xffff9c9b3b080600,
>  nf_cred =3D 0xffff9c9423a55a40,
>  nf_net =3D 0xffffffffa200cd40 <init_net>,
>  nf_flags =3D 0x1,

The above value would normally imply it is hashed (nf_flags=3D=3D(1<<NFSD_F=
ILE_HASHED))

>  nf_inode =3D 0xffff9c9c204c5500,
>  nf_ref =3D {
>    refs =3D {
>      counter =3D 0x2
>    }
>  },
>  nf_may =3D 0x2,
>  nf_mark =3D 0xffff9c9633a85b40,
>  nf_birthtime =3D 0x668a348ce435a
> }
>=20
> In this code, one task is opening a file for the cache and another is
> waiting on the construction to complete. After we open the file, we
> populate the nf_file field, clear NFSD_FILE_PENDING and wake up anyone
> waiting on it.
>=20
> Here though, the waiter had finished waiting but when it went to fetch
> nf->nf_file in the register, it still appeared to be NULL. In the core,
> it is populated with a valid file pointer however.
>=20
> clear_bit_unlock does a full barrier (on x86) before clearing the bit.
> According to memory-barriers.txt, wait_on_bit should imply a read memory
> barrier.
>=20
> Why was %rax zeroed out?
> --=20

Are you sure the back ported values for NFSD_FILE_HASHED and NFSD_FILE_PEND=
ING are correct?


_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

