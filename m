Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD864A366
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 15:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLLOcL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 09:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiLLOcJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 09:32:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD412ABB
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 06:32:07 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC980dv016055;
        Mon, 12 Dec 2022 14:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8NrLLmV8aalzb3RUdMfWoC53u3dKqTVQlJcKNVA3qhU=;
 b=x7e9W7oqbJuIgfpZg2M1vJ8A3sRAOZHXH8rLrNBznW25v+S13zNz4W7xr8cSZ/o/VZ4k
 bScrWHbpHWotkaetgMOvuBjpCEF7JsoRlEBi1EuTPdYSEKKxAx/gUxQg6ofe9cpl/1Yo
 DUaa7lENoXfS9os25wlohVhLirseLPhyD8jJjK6eXJDaELV+r2ycSe3QDeMnme5TL3XE
 vcsbvdD5+MJsNewtgSGl4rJFygDMG/ms9qzHKmHjEJ1j1BjxxcgXDsMqGjVKX9HATWtK
 pTYkvnucFldGNphfY03BnMdNjavxKlAJZ1P8JWNSuaLbo4vbzx3SxS2go5sgrsiw2tSl bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj5btuaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 14:32:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCE43qB017616;
        Mon, 12 Dec 2022 14:32:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjacqet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 14:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxP6ZQtNqUiXgVqKVTPZELDosjdoxj6hjviDIf8ylwHHHKvD50K41LVGl+a/Be3brmCRzC33SjrxYmWTsPaWeUMegzOAL0SP3FDMf8Pg/wxAqVhujpSVt9Z+rveMb38wEnC0q+SUnhKkhwLKWIMvaw1jHTnkCUJ3o7+tEvoaRNm1+0AP+PlsZniYHHtj3AKXhPqlZZiqi6FtFW/kXRs4CtbY9kU+I4fdxg6zQNbYH5U15rwsppyyPIE61mZcio7vPGwtKWCbcU0Usa3ByUMDb3b8TcowVSf2CAPSiKCzKFjkkxuUFGDHNnY2wwCFPwfZ8GjUskT9n3bEZf4M4at8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NrLLmV8aalzb3RUdMfWoC53u3dKqTVQlJcKNVA3qhU=;
 b=jzY8t7i6MyyBlWea87cg1kXqNSMQ20PgwlPK+TnYM3RY5IjvYaDw1vOEJqSZGW4rUjXIQJObh/PPSGzrscbQ0BpleeB2ChQOvOVqHwR0ifOpW6kC1ZhM6ASLR48FieEKimyPKpggdIiV7h3YhsDW1ebaxPP8cX/sJBg206/JSdrmzqKDxhgoiEtw7N9lJQaLqJA9WjBW/QnwEDLKtooo/7aRPHHG+ZjJKT8KrasvC23efCvr/93Yh0nWjQJp1DG9bIhM2pOILBb3wzlvwzw16uUHEsNmISptV6SvSjmiGlZjr4KnXLqngrA27aARnQOiO+eN5n4eHqw6n1fFpkauiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NrLLmV8aalzb3RUdMfWoC53u3dKqTVQlJcKNVA3qhU=;
 b=cfVacFevY23UBuxuDL6BPbH3MlCfR0mE6RsJDa51og1gI2QSdsOkf9l2a95KAlz8EjWTKS3zAMANYTe2chx/gB5ShuQEWTHcwDJl0LtU4yEMtgQTfoWM75Mkohfm0Yu+x4Mrfhh3dtGPGoeL9xAp+KnSwPH3Qp39Jgpvfol+X8c=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SA3PR10MB6999.namprd10.prod.outlook.com (2603:10b6:806:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 14:31:58 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 14:31:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Aloni <dan.aloni@vastdata.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: Re: [PATCH] nfsd: under NFSv4.1, fix double svc_xprt_put on
 rpc_create failure
Thread-Topic: [PATCH] nfsd: under NFSv4.1, fix double svc_xprt_put on
 rpc_create failure
Thread-Index: AQHZDhpykCJQqZk2SEmjaziIXDXtMa5qUMYA
Date:   Mon, 12 Dec 2022 14:31:58 +0000
Message-ID: <2DF0667C-29E1-4736-A1C0-07492C389FCC@oracle.com>
References: <20221212111106.131472-1-dan.aloni@vastdata.com>
In-Reply-To: <20221212111106.131472-1-dan.aloni@vastdata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|SA3PR10MB6999:EE_
x-ms-office365-filtering-correlation-id: 55f29a0c-cb7d-4b89-13e9-08dadc4da072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTWq9BZiST2/hNLpQC9YpbV4dPYQKWmY53FYQkTLFxI9ydikkbc3M/VdSKCLTdOm3Eri6Y7qhs0UZ+EsuUAnVSOOzHFbWcjNo6ghEk9HnIpvyvHpSh/EgnOPLbJ1qZWKZl56GG+Q0Et2L120xVjibdzvVkgsIt0g/H5GurvhdFvxQzaeYTJ32Z1EQ7Ap2zCG2BVE+z7l5wTBg5Uf5Hq6QkT9ZcAHUXx7hLkaJYgOPWAiA11iES6zE5hucgaWjndO3od74KRLrYLKSYEqkFU/FVp/bw0mFJv2Bxs5rpJ6jHqWWiGAL/uZatdtu+6MafzyD+ZwmmwBUbys9jrzebpcX6HKMSd7weBuxpi3bvFB4FDQbo1ps+V5fRRvjAgYQN7aEMSM1nDcI+a/n31zGsujIbPEIBiLPGse20uzk5c9wmbF+z0Ss2MT/F8wIRi1HX0zjV7duRVUdSQ8wmb3dhD7gRrcs6Xope8IyfT3DHUE5mpwev+nRAmoB8oJIvtO68SePkRtyuEzymDNRrT0AkO+y7k2+7mXi8Z8gDAWITdHqFl8OWcBFgIlt+dqlOcG3GV30YyKd9OSsMhKIndLBUv8jUhJeUV4IwxFL294wsbZM4TXW+hSxFW6+7cZfrxiZr4DJ3BXjhnTILpu092YzBHyoFphWdI6tNQDC09lPyvEh7yAXEs94SRB1hPxYLJhjwtmkWczOCl1bR/czEUxnYYyzGc6+KUxlXEONoImJhGho1c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(4326008)(41300700001)(5660300002)(66476007)(64756008)(8936002)(76116006)(8676002)(66556008)(66446008)(66946007)(33656002)(45080400002)(2906002)(36756003)(6486002)(478600001)(6916009)(316002)(54906003)(71200400001)(53546011)(6512007)(2616005)(83380400001)(38070700005)(6506007)(186003)(26005)(122000001)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8Q9y8nTnUQREFFFzDTcUgDIAVE50/1b0sge+qU55jNr3YrwOJ6WylbbiDsV?=
 =?us-ascii?Q?zD6Ztgp6oLvmN8TF06Hyrn0Olxwi/8nkncu0VjWmidYmNytZfgMHRIeChomP?=
 =?us-ascii?Q?/80Af3+H0eViD6p4Hda3HGwUm5vFN+i3XIbf4F2e37aDQpA0CTkFQA5lBVK1?=
 =?us-ascii?Q?WeN2lC2IkVdHAXrUJ5xA40o5UiDCOPCyq2Pn4Kxq1/SuipH/RZ8zLEIP7F92?=
 =?us-ascii?Q?MOr8D5QmOT+GsU8b+CFiPr0e1jSZx5dLWxlFxeAB/x3RmRZqS8YqlKUwLtje?=
 =?us-ascii?Q?e/NQGE0TKop7AowJ7OQ4nCKhWmt0qX21tn/TXS4kyIJ7lWiWF7msGObXvxLk?=
 =?us-ascii?Q?eeyp2X87Jl3kldiraXMQhTkrMUHJI3uhCOPlvIfNmCoUqDZFX8vVqx8gXWrL?=
 =?us-ascii?Q?r3H2KKoHINxZT9rY348ULCB3elJbHgvvPj/fdx6M9elNA+jjI3rQ9TxSXTjt?=
 =?us-ascii?Q?/00eb0AKsuJJYB97shoJ6tva7UB+QaJTDpJruR00+0O7l1uXBRrRAq0yWKg/?=
 =?us-ascii?Q?XXsVFn5nQ2hl2I3Yc6xDNY3Zk9amUboC7rnbH9zzcnkus8mzx0UPd7piyxqX?=
 =?us-ascii?Q?/qcBXjbH57ppLivFtsnlYreYcqDh0Hw9L6FOqGfDrYHuuD06/wWP/YG8nvgH?=
 =?us-ascii?Q?C1Q5NSGuiJNIgcJsbLhrD9fGPlKolQsRYfoKxsjZibk5FsrSZir8XcBg/TxT?=
 =?us-ascii?Q?FJRG8JKCTVQfA2AjgWTetWrdPz4F+3wt7h3mzPiiBhxozUktgswSy7yCHxKV?=
 =?us-ascii?Q?bVM2wYrcfgYbo1+0kNYpeZ3p3Xc6t4qcfJmFcgr8Ux5IDiuOYHPNvQ7bSp7G?=
 =?us-ascii?Q?zfzHO6ovsrxVKoKDANXNb5k4E1kYjZo/3BEBF+7lRgsS7cIDpU7NDuLbytAG?=
 =?us-ascii?Q?8dbhraG+bzTKSgwt8fJds4b4OCJZxXJJHrUvremW9vQlmhnKjkcDnuxFaS+e?=
 =?us-ascii?Q?xGrLr/aYyeeNGFzrJsk4BnAN858qyp7xjf32rEMopQr4unepiQQHOG4fwd4d?=
 =?us-ascii?Q?BBFjs9xBRt8v9lbNobTsrQvMB6I5EGTfX54PAupB+uaFx8uBK6FaMgfAuNYX?=
 =?us-ascii?Q?Cc5q1kDStfUE5Plc/4o6YnE+u2+QFjEYiqJItWIxpEjE7hLPe20IqgARyuMN?=
 =?us-ascii?Q?L/jI5L1w/RxRMNEL78iCARo/+DgkcNSTypUtXt+A+hhgkKIVVcnY7JBPmGbA?=
 =?us-ascii?Q?w/zh96R72UuoYBMQk3vAdZDChHiIod8OMK0NIdiw44lu3VBApfQL67UlGSEn?=
 =?us-ascii?Q?BFuJvmJW8D86H7EKKPHu60v7eMdSMQgDdSID98SzFe51dttF5bEQJO2Q7njC?=
 =?us-ascii?Q?J4RijRCPGfj9B4Y7rVAzvluUC1J3JEN5oaTkjkQ6y1CNzQ0SUtlgqTVC/YLX?=
 =?us-ascii?Q?j1OCvcpun+ORQ9TqVMeCuKHKGCUcm7pYIwRwc5Sea7c9vCcEF++a5RvwFeQ0?=
 =?us-ascii?Q?uQ4bdV6Groug21Guz7m84phMFjEsy5URa8fTFpHyyGnnZrV8c8ay+T9idQ+H?=
 =?us-ascii?Q?Fhe+5MmNM84/NzujdcHzsroYxw9Hwfu54JRYmsLfRuzkWCRocWHYnaGfDjDy?=
 =?us-ascii?Q?Ogzt3qRtguh2N3ZZkoSXnJgpcAk4U2TRz6cHETz2XdhQbJj15RPNA0FTMPsL?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A6BB3D9D39BFB4BA2585926441818F1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f29a0c-cb7d-4b89-13e9-08dadc4da072
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 14:31:58.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKvPv1G1mRf4AoG+3/eudBBOktjETaHXmjAr4Tt8zTFHnIR0PJ051SirR8UGGSjqmBYk2mt6fU6UXSEBS5orUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120133
X-Proofpoint-GUID: StJlg1ZRrimhoelkb0RcyQJJBPOSNysm
X-Proofpoint-ORIG-GUID: StJlg1ZRrimhoelkb0RcyQJJBPOSNysm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 12, 2022, at 6:11 AM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>=20
> On error situation `clp->cl_cb_conn.cb_xprt` should not be given
> a reference to the xprt otherwise both client cleanup and the
> error handling path of the caller call to put it. Better to
> delay handing over the reference to a later branch.
>=20
> [   72.530665] refcount_t: underflow; use-after-free.
> [   72.531933] WARNING: CPU: 0 PID: 173 at lib/refcount.c:28 refcount_war=
n_saturate+0xcf/0x120
> [   72.533075] Modules linked in: nfsd(OE) nfsv4(OE) nfsv3(OE) nfs(OE) lo=
ckd(OE) compat_nfs_ssc(OE) nfs_acl(OE) rpcsec_gss_krb5(OE) auth_rpcgss(OE) =
rpcrdma(OE) dns_resolver fscache netfs grace rdma_cm iw_cm ib_cm sunrpc(OE)=
 mlx5_ib mlx5_core mlxfw pci_hyperv_intf ib_uverbs ib_core xt_MASQUERADE nf=
_conntrack_netlink nft_counter xt_addrtype nft_compat br_netfilter bridge s=
tp llc nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_=
chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set overlay =
nf_tables nfnetlink crct10dif_pclmul crc32_pclmul ghash_clmulni_intel xfs s=
erio_raw virtio_net virtio_blk net_failover failover fuse [last unloaded: s=
unrpc]
> [   72.540389] CPU: 0 PID: 173 Comm: kworker/u16:5 Tainted: G           O=
E     5.15.82-dan #1
> [   72.541511] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-3.module+e=
l8.7.0+1084+97b81f61 04/01/2014
> [   72.542717] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
> [   72.543575] RIP: 0010:refcount_warn_saturate+0xcf/0x120
> [   72.544299] Code: 55 00 0f 0b 5d e9 01 50 98 00 80 3d 75 9e 39 08 00 0=
f 85 74 ff ff ff 48 c7 c7 e8 d1 60 8e c6 05 61 9e 39 08 01 e8 f6 51 55 00 <=
0f> 0b 5d e9 d9 4f 98 00 80 3d 4b 9e 39 08 00 0f 85 4c ff ff ff 48
> [   72.546666] RSP: 0018:ffffb3f841157cf0 EFLAGS: 00010286
> [   72.547393] RAX: 0000000000000026 RBX: ffff89ac6231d478 RCX: 000000000=
0000000
> [   72.548324] RDX: ffff89adb7c2c2c0 RSI: ffff89adb7c205c0 RDI: ffff89adb=
7c205c0
> [   72.549271] RBP: ffffb3f841157cf0 R08: 0000000000000000 R09: c0000000f=
fefffff
> [   72.550209] R10: 0000000000000001 R11: ffffb3f841157ad0 R12: ffff89ac6=
231d180
> [   72.551142] R13: ffff89ac6231d478 R14: ffff89ac40c06180 R15: ffff89ac6=
231d4b0
> [   72.552089] FS:  0000000000000000(0000) GS:ffff89adb7c00000(0000) knlG=
S:0000000000000000
> [   72.553175] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   72.553934] CR2: 0000563a310506a8 CR3: 0000000109a66000 CR4: 000000000=
0350ef0
> [   72.554874] Call Trace:
> [   72.555278]  <TASK>
> [   72.555614]  svc_xprt_put+0xaf/0xe0 [sunrpc]
> [   72.556276]  nfsd4_process_cb_update.isra.11+0xb7/0x410 [nfsd]
> [   72.557087]  ? update_load_avg+0x82/0x610
> [   72.557652]  ? cpuacct_charge+0x60/0x70
> [   72.558212]  ? dequeue_entity+0xdb/0x3e0
> [   72.558765]  ? queued_spin_unlock+0x9/0x20
> [   72.559358]  nfsd4_run_cb_work+0xfc/0x270 [nfsd]
> [   72.560031]  process_one_work+0x1df/0x390
> [   72.560600]  worker_thread+0x37/0x3b0
> [   72.561644]  ? process_one_work+0x390/0x390
> [   72.562247]  kthread+0x12f/0x150
> [   72.562710]  ? set_kthread_struct+0x50/0x50
> [   72.563309]  ret_from_fork+0x22/0x30
> [   72.563818]  </TASK>
> [   72.564189] ---[ end trace 031117b1c72ec616 ]---
> [   72.566019] list_add corruption. next->prev should be prev (ffff89ac49=
77e538), but was ffff89ac4763e018. (next=3Dffff89ac4763e018).
> [   72.567647] ------------[ cut here ]------------
>=20
> Fixes: a4abc6b12eb1 ('nfsd: Fix svc_xprt refcnt leak when setup callback =
client failed')
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Cc: J. Bruce Fields <bfields@redhat.com>
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>

Applying. Thank you, Dan.


> ---
> fs/nfsd/nfs4callback.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index f0e69edf5f0f..6253cbe5f81b 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -916,7 +916,6 @@ static int setup_callback_client(struct nfs4_client *=
clp, struct nfs4_cb_conn *c
> 	} else {
> 		if (!conn->cb_xprt)
> 			return -EINVAL;
> -		clp->cl_cb_conn.cb_xprt =3D conn->cb_xprt;
> 		clp->cl_cb_session =3D ses;
> 		args.bc_xprt =3D conn->cb_xprt;
> 		args.prognumber =3D clp->cl_cb_session->se_cb_prog;
> @@ -936,6 +935,9 @@ static int setup_callback_client(struct nfs4_client *=
clp, struct nfs4_cb_conn *c
> 		rpc_shutdown_client(client);
> 		return -ENOMEM;
> 	}
> +
> +	if (clp->cl_minorversion !=3D 0)
> +		clp->cl_cb_conn.cb_xprt =3D conn->cb_xprt;
> 	clp->cl_cb_client =3D client;
> 	clp->cl_cb_cred =3D cred;
> 	rcu_read_lock();
> --=20
> 2.23.0
>=20

--
Chuck Lever



