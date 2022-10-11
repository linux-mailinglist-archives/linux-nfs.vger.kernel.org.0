Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB255FB29E
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 14:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJKMp5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJKMpz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 08:45:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051C1857D5;
        Tue, 11 Oct 2022 05:45:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BBcfmj009671;
        Tue, 11 Oct 2022 12:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qXeQVF+ezfJGG0sSa2EeolPLz772jwZsFlAvZOtC+Fg=;
 b=TEjeUPj0uPtTjjs9BTjXOM0Iq+nMLDV3ReWZG61q9ysqfPr0K2aF0kHHGx3yhjZb6Svj
 WfBgFzLZWvpj2eexLMXqwByrZ6cf7LXIaxZIiXrKAKCxywT8XL0ktB11wPrfKMnfh5KM
 0PxnWXSgWDiv7AMlkKGYWOAKaQOGbCLHDrV8gF4O3F5ZMxdg7b9NOQTVc/UzhaRZ7+VM
 WBreek3DwcCa59hlfjh6SZAIx4CEKBX8pB4wb3IiMyCqCzW/2aWkqG4LB4g949e+AIh2
 WAui6ULBjSHR3vqeUFOFGJzSMHKfTWOTkgI65IuOUIpEd/QM9xMNfuTmMBEjZukHrVSB 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2ymcxdp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 12:45:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BCClNG021845;
        Tue, 11 Oct 2022 12:45:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn42bem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 12:45:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRXrK0/5P1X8sEE4H18AXT5IcAPeooJBwmYcqXS3o+4bND6Ug02lZJrV6iwzK4EFL2MVkI45re0bMaP+xcRBnpUInesb638XCwEDdC6RDLJVZWZkmf+J+uvGvmlyKLgizuCbC25+cdiyrHSWLn0poLu5FVfykan/rsqydK+VhnqyKmMMd2SPY5CeuKFd/uGbbE0It/7lWRW3sp/CA76zDV/MMMlo4wnGVLthUE6L08vRQM/Y1njdV4SGIOaRLZo9wo1c3Qt44Be2jLrTx3Gf6IYNeBVvD4seySgtAbviCS3slJQedILv3d8nMlHp3CLvDvN/X6tMYC8GXUKkJZCJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXeQVF+ezfJGG0sSa2EeolPLz772jwZsFlAvZOtC+Fg=;
 b=c2fJugqNjdl4Xm++uFEpK+mmgfFmI1vy+8qRCqRduePy6s0ShNP3kCGo4QdPcNltaVnhFrd2QokHwV1td4eiFuByAzFvTSjkmc2bg3XzliwJ3jvyB1ez9Ti5uy4F32uXqHr7lw1a00D1qRoAgZNX02sFPTCcQJKr4Dndhf2+VpCSDqYAW6KviMx8H58iFx/U/Ri0a/XAv8FIl3Xk0L03xSsjEPozpLAMtiM+h1hw+OmTA2YQF/F6wIOxCrrm24RsxOcqBY3YgO9x8QrxtVI66WKEQ57/hBFNBueGzMfL6ZPPVSvHh1T2665NDHaNrh9ojNFsNXIp8fsOQfVCeGRYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXeQVF+ezfJGG0sSa2EeolPLz772jwZsFlAvZOtC+Fg=;
 b=v38puAdLWhK/Ubm4bXzmPn0PfX46jq1BKBYMsh5obb2p2wTt+WeWTe0U4szQRSSR4AY55imJX8ZT6gR7Jo3dFdhBlsMgY+RDY/CPqPNdI/Y2sfhbCKhP1ZAYaF6OH8Bqcz7C0TSzB/lf/9vTiZUz6Yv6b4hY2WX11Ot9FetmvLM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6064.namprd10.prod.outlook.com (2603:10b6:8:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 11 Oct
 2022 12:45:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 12:45:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Jeff Layton <jlayton@kernel.org>, Robert Dinse <nanook@eskimo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Bug 216560 - Kernel 6.0.0 Use after Free Error in NFS code
Thread-Topic: Bug 216560 - Kernel 6.0.0 Use after Free Error in NFS code
Thread-Index: AQHY3V5yhuX6s0vXrEqqnTT8ytFPh64JI/CA
Date:   Tue, 11 Oct 2022 12:45:28 +0000
Message-ID: <E0E7F585-3D01-4A76-B972-DF3D8ACD8B36@oracle.com>
References: <2b693b7b-aadd-5353-154c-37a175fc5b99@leemhuis.info>
In-Reply-To: <2b693b7b-aadd-5353-154c-37a175fc5b99@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6064:EE_
x-ms-office365-filtering-correlation-id: 6012687d-fc6b-45ef-32fa-08daab8679ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtLcGJKbgyb3Vm//geZ2xCZ37t7Ts5/geOdbC8kdczw5x+Qf3bHh1NV6VLPhuHr5VKKWfDOrAAPt2DtpxMg5Xcpbl51qWsbubrhW0cuUSzRwnXb4l3i4awC2E9JW4Agea6S8ofK/0Rc8z6bx5GIhT0p5qYy6xH2HkYyBFbN5Wh555OdvFiE8OVL8GOxanpA60vhQb5bRrHEZWkCCZfMdATTDQe7ffZeAVBlN8fIDHiClAQTg9t/WK++44G32s00brOPEtpxkwnJLD73BKKKPux+F2Yxr/i4w9WX2QG701qkWccNJY5q9aSYmmPJJDngda9L7R6za73T5tk7+KgrnyoCfn7+mmkdlj+7L9Yvvn42Ijy0DkoVAeV+U8470cYvUgmePUrO6mr/IkhoXfr68+ucJkGT+iexwdaj7iB63lR/st4At1zR6pXbhT6PX5Mkkn80kyE8T/+0f3PX3vUanTnGa2isaIvOz6331zXhH6DfnKbp/2sAXPTI4MXwUz7kkTC5RuHtuaYYi9TSifjJRRt7sV5FMIdGtFCPbg6Tl9gQoShq0cN3l92M+2EFo+rOkWBbPjngeYsaEMR+p480n7OVlcqEsjpdlNKEx8YOnm80TKnEQZfTpCl2A1dGUSmyNvCicd/DAFUWOYb5F0cpcrYef2LRs7QHs9mlWk0nJcd3Ug2HcuzQSr1JbnKM2L2YDZVcmHz5j9kJVw8T9HMuV4mogt4az+rwm0w0Hz85bEhn3bhxzRtiY1SEENmo9tQAaBTskW3aTVMcTFIB0ZJhB+yICIInmmbcJNMDHwSS0j8of9XWfZzfI3E3NdPnB6fBkr4cDPLaNQ2M2P2HzVSwd8epFEsqyiiqDG/LkuHnfrsczVHWkHJpCrtA076tfEBhc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(71200400001)(2616005)(66899015)(83380400001)(186003)(26005)(66946007)(64756008)(91956017)(66446008)(36756003)(66476007)(54906003)(8676002)(76116006)(33656002)(6506007)(66556008)(2906002)(53546011)(4326008)(122000001)(45080400002)(6916009)(6486002)(8936002)(41300700001)(316002)(38070700005)(6512007)(966005)(86362001)(478600001)(38100700002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QkQmIKUt9BfXDU3553Kexop1ZXPSv/PlrJexhcbScQ1oXwjRXquI3uE+BFZe?=
 =?us-ascii?Q?3v3gMeomcSzWKa+RfDUBXxUt1lJQJLw6p3d1XlrdkZqOYlZ1foxZc1iBLd3e?=
 =?us-ascii?Q?KALOVfQUQ8nSfs3TKZoIgJv5MPVILHsns98z7cyAjFUE/rEzaFik8GPtr9aW?=
 =?us-ascii?Q?qyLo03/U+lRfYHlhfE99gIoru00NT2W6jTbaXYTeiVutPZcj9MrdVYNtsr3T?=
 =?us-ascii?Q?2Ht1lHbJbr2p+o3jFK//q35eulFwT920/dqWPpIlCAsVbgNxPRAaQkdXoOLz?=
 =?us-ascii?Q?S5q1saEfbu6w+ocpzZsfFRkdXoJ01lJMLnxaZRtDC0Iq7KF3fZKtyUG5T3aS?=
 =?us-ascii?Q?/IlEkscRTDiV5dD+lrfejYGxULaYhfHnukGcInfjY6pVL4nGGtIOPLNfmjZP?=
 =?us-ascii?Q?WHYq5m0EaGOn80T6P+luYoSEgbvKJdiYw1qGE9akP8Kl1kiXFlGKp3gLi5Yx?=
 =?us-ascii?Q?IrESb0p5KIYxKM/WEPrZOxYhJ7GDfKPULeSJunVkH+Bm1GVufhLjoHyKreTo?=
 =?us-ascii?Q?N2/5gl33oYewiSlmYt/TNxGE1DS0g1BjOIeguz0QkFnLLZoPX7w0rfONbD4k?=
 =?us-ascii?Q?8JSdGoa4jYaUZPDA7V+/X0eGduf0lBTFeZ/bfXz125jjiM9473UEX/kBtoD5?=
 =?us-ascii?Q?12UweaxxnW+I758yxq86XSZEjEHk3ic7g83ox0Drv6E4wwZXO9FG92wfE20N?=
 =?us-ascii?Q?7+O+21BKVnwtS7CRvn2OJGpqUjPMl5+vnKr7Bh8DI4qWK9ygfwF9JPfYPWTO?=
 =?us-ascii?Q?0D7EuPuXA71giZemPP1TPtVW443nC8Rd32lCJ3FK3Z3fwBUoyDWi4Guv3hHj?=
 =?us-ascii?Q?fwqkukozGMowx9RKIrJkEf3+YFnFAuu2iN7n9o9UtnvgEi1T1G13gP32XOvZ?=
 =?us-ascii?Q?8vHOL5mWwuhBti/48fuV0hvWbewKbJRW4M9Rb8tVRP/JiZpNW9Px3JbpKogd?=
 =?us-ascii?Q?HOXi0YQhkCQNm3P7W76FoylyiLZFaImLvE6ZXMPRTDDIOsO65iGtRXW8OGFD?=
 =?us-ascii?Q?jVfGtrRkydn9RT9Mbz81hE+w+V14rmvMPpiSo98MRd9J2y3e7bQCChWVHLLJ?=
 =?us-ascii?Q?0j8sh457an28y7HaLyRpKGryxa/iYj9pCIaRZR2Gmcfwca9mW9PDQdEqEg7k?=
 =?us-ascii?Q?qbNbRCRSA97dBGs7Zu/LLmm5t5NBmF2PjZInVsO1nb0nrScEZc609w7tl73R?=
 =?us-ascii?Q?LSk+xLuk7iJvBU8I7CEjlNuFbB+Y3Tpi9axVv8zQCdA4+V1FJkr+ZsOU8z58?=
 =?us-ascii?Q?1vkRog8BB88lSSPhoLFK3UkzK0WQz671uKM92+Ao5ORqDWJYEbBbU9nD7+Ir?=
 =?us-ascii?Q?+FY4XjJDFOG8vGMWllJla5WxcQQC/t9HJXQ+DLAptGl6JTLAYZccB7pNWczE?=
 =?us-ascii?Q?qX05VyAL1UUfKd0r1PcfgSvFWafeVBxPNA+r+i5kNmuipIETgX9fBeb1Llv8?=
 =?us-ascii?Q?bW/WVzMBzm8BPPRYzuk8BlLwMvSmnStAjPL0+4cCyeS+EYVCrKJvYAuv6xEC?=
 =?us-ascii?Q?1FwXkz4Fci3ru0WRpFhhEIPefWqJdlWlK1+jIstI7bq6U2kChhJI2imYii5q?=
 =?us-ascii?Q?tKrrSghP1b6DW1xnH0hIt7oDJrokxAwlNT5ZOc5uN9eAJANZ/CrOKuVs7eCX?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D12E4F59C2DC2645A8E0439F5733BF4D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6012687d-fc6b-45ef-32fa-08daab8679ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 12:45:28.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkzWiVMe3D0E54j2i9ldX5JYzwC5vD7Ouky0Fi8saOfbPfmXPuKZBv5yx83G5BIUN277XWSv5ygdT+4P2+PhPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_07,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110072
X-Proofpoint-GUID: __ZgSCoLOv4P22jgm8ef4exyx8UIUERW
X-Proofpoint-ORIG-GUID: __ZgSCoLOv4P22jgm8ef4exyx8UIUERW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 11, 2022, at 6:44 AM, Thorsten Leemhuis <regressions@leemhuis.info=
> wrote:
>=20
> Hi, this is your Linux kernel regression tracker speaking.
>=20
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D216560 :
>=20
>> reated attachment 302961 [details]
>> Config file used ot compile 6.0.0
>>=20
>> NFS Use after Free Call Trace.
>> This is on an i7-6850k based server that is running Ubuntu 22.04 and ser=
ves as an NFS server as well as virtual machine host.  It is equipped with =
128GB of RAM and both SATA hard drives and PCI flash drives for storage.  T=
he configuration file used to compile this kernel is attached as config-6.0=
.0.  Anything else you need please let me know.  Compiled with gcc 12.2.0.
>>=20
>>=20
>> [45414.551153] ------------[ cut here ]------------
>> [45414.551158] refcount_t: underflow; use-after-free.
>> [45414.551169] WARNING: CPU: 11 PID: 2289 at lib/refcount.c:87 refcount_=
dec_not_one+0x68/0x70
>> [45414.551177] Modules linked in: vhost_net vhost vhost_iotlb tap tcp_di=
ag inet_diag unix_diag xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf=
_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat nf_conntrack nf_defr=
ag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink rpcsec_gss_krb5 nfsv4 nfs fscach=
e netfs bridge stp llc binfmt_misc nls_iso8859_1 quota_v2 quota_tree snd_hd=
a_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel inte=
l_rapl_msr snd_intel_dspcfg snd_intel_sdw_acpi intel_rapl_common intel_unco=
re_frequency intel_uncore_frequency_common snd_hda_codec snd_hda_core x86_p=
kg_temp_thermal intel_powerclamp snd_hwdep snd_pcm snd_seq_midi snd_seq_mid=
i_event snd_rawmidi snd_seq snd_seq_device snd_timer eeepc_wmi mei_me kvm_i=
ntel snd asus_wmi kvm platform_profile ledtrig_audio iTCO_wdt intel_pmc_bxt=
 sparse_keymap rapl intel_cstate mei intel_wmi_thunderbolt iTCO_vendor_supp=
ort soundcore wmi_bmof mac_hid sch_fq_codel nct6775 nct6775_core hwmon_vid =
coretemp nfsd parport_pc ppdev
>> [45414.551237]  auth_rpcgss nfs_acl lp lockd parport grace sunrpc ramoop=
s reed_solomon efi_pstore pstore_blk pstore_zone ip_tables x_tables autofs4=
 btrfs blake2b_generic zstd_compress raid456 async_raid6_recov async_memcpy=
 async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linear =
dm_mirror dm_region_hash dm_log raid1 nouveau video i2c_algo_bit drm_ttm_he=
lper ttm drm_display_helper cec rc_core drm_kms_helper syscopyarea sysfillr=
ect sysimgblt fb_sys_fops raid10 crct10dif_pclmul crc32_pclmul ghash_clmuln=
i_intel mxm_wmi aesni_intel crypto_simd cryptd drm nvme e1000e i2c_i801 ahc=
i lpc_ich i2c_smbus r8169 xhci_pci nvme_core libahci xhci_pci_renesas realt=
ek wmi
>> [45414.551282] CPU: 11 PID: 2289 Comm: nfsd Not tainted 6.0.0 #1
>> [45414.551284] Hardware name: ASUS All Series/X99-E, BIOS 2101 07/10/201=
9
>> [45414.551286] RIP: 0010:refcount_dec_not_one+0x68/0x70
>> [45414.551288] Code: d3 6e 00 83 e3 01 74 0f 48 8b 5d f8 b8 01 00 00 00 =
c9 c3 cc cc cc cc 48 c7 c7 38 1a 64 99 c6 05 36 65 53 01 01 e8 bf c4 6a 00 =
<0f> 0b eb da 0f 1f 40 00 55 48 89 e5 41 54 49 89 f4 53 48 89 fb e8
>> [45414.551290] RSP: 0018:ffffa6f041a5bb80 EFLAGS: 00010282
>> [45414.551292] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000=
00000027
>> [45414.551293] RDX: ffff89763fce0568 RSI: 0000000000000001 RDI: ffff8976=
3fce0560
>> [45414.551295] RBP: ffffa6f041a5bb88 R08: 0000000000000000 R09: ffffa6f0=
41a5bb18
>> [45414.551296] R10: 00000000ffffe664 R11: 0000000000000665 R12: ffff8963=
d049b1a0
>> [45414.551297] R13: ffff8963d049b1a0 R14: 0000000000000000 R15: ffff8972=
18d09e90
>> [45414.551298] FS:  0000000000000000(0000) GS:ffff89763fcc0000(0000) knl=
GS:0000000000000000
>> [45414.551300] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [45414.551301] CR2: 00007fea43472718 CR3: 000000015686a005 CR4: 00000000=
003726e0
>> [45414.551303] Call Trace:
>> [45414.551304]  <TASK>
>> [45414.551308]  __nfsd_file_close_inode+0x1ca/0x210 [nfsd]
>> [45414.551340]  nfsd_file_fsnotify_handle_event+0x85/0x120 [nfsd]
>> [45414.551362]  fsnotify_handle_inode_event.isra.0+0x6f/0xe0
>> [45414.551365]  fsnotify+0x615/0x9b0
>> [45414.551368]  vfs_unlink+0x22d/0x2d0
>> [45414.551372]  nfsd_unlink+0x128/0x2f0 [nfsd]
>> [45414.551394]  nfsd4_remove+0x52/0x100 [nfsd]
>> [45414.551411]  nfsd4_proc_compound+0x431/0x6f0 [nfsd]
>> [45414.551425]  ? nfs4svc_decode_compoundargs+0x380/0x410 [nfsd]
>> [45414.551440]  nfsd_dispatch+0x15a/0x250 [nfsd]
>> [45414.551451]  svc_process_common+0x295/0x600 [sunrpc]
>> [45414.551485]  ? nfsd_svc+0x3f0/0x3f0 [nfsd]
>> [45414.551504]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
>> [45414.551522]  svc_process+0xba/0x100 [sunrpc]
>> [45414.551544]  nfsd+0xd1/0x190 [nfsd]
>> [45414.551555]  kthread+0xd1/0xf0
>> [45414.551558]  ? kthread_complete_and_exit+0x20/0x20
>> [45414.551560]  ret_from_fork+0x22/0x30
>> [45414.551563]  </TASK>
>> [45414.551563] ---[ end trace 0000000000000000 ]---
>=20
> See the ticket for more details.
>=20
> Side note: I wonder if these two are related, but this is not my area of
> expertise, so be warned that it might be something totally different:
> https://lore.kernel.org/all/166486048770.14457.133971372966856907@noble.n=
eil.brown.name/
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394

The reported trace looks similar to 394, but this is a new
and unfamiliar failure mode (to my eyes).

As Jeff said we are actively working on filecache refcounting
issues. The challenge is that none of the bug reports include
a reliable reproducer.

I should also mention that we believe some or all of these
issues predate the filecache overhaul done in 6.0, so I'm
not ready to confirm this as a regression in that kernel.
We've seen similar failures reported in kernels as old as
5.15.

Thus my intention is to pursue a conservative approach for
now, and fix this for v6.2 rather than pushing it into v6.1.


> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>=20
> #regzbot introduced: v5.19..v6.0
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216560
> #regzbot ignore-activity
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>=20
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.

--
Chuck Lever



