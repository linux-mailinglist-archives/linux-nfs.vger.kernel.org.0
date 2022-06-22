Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1F55534C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jun 2022 20:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbiFVScJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiFVScI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 14:32:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A234393F5
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 11:32:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFXqPa027225
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kK/KqnBW/bV3fztGH6DdVoOg/X1dqXWGbtrn1HRw47o=;
 b=Tgmz9SnOS82l3Ck6LwggyHTrubwhUbVFnMj/Q5DhAApXc3YRHczgnl/By6razDRSZiFj
 Wk1cQquuzUAa7qEMcDtlRHNnZKAjf6XHpYqU141ZyScwT44hyc2LYEvjmqcoGxymiriK
 AWGP3+MakxvUP4QdItgmwuKcQ8RBXSoMnaTMZ7YDuiHgnRYUREHUtJrUeszh6rtz6P7p
 gZUMNQh+1kHqWdLrcjHpUhfzwx/50JOPupEBgDFz4jztdcbRJcA5stzmhcV1MMvJ/BNq
 X3//i4QNkyZm59P0FSvou0S02O7eH6JB/MctiSL9AjZdFKbfZUAmJXLk5KdU0SD1ymvX Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf93en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:32:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MIUeux005966
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:32:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9vk9x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocP5nay/UOPHMAzQhjNcz0ZtOg8JBZsJgq/EVGA2aXp836dFLwtk9v4QAVZowWCZchmyW9swYfCQ9sDGwscg0AspeQTFqlRCRTfrXp3Km0fPC8pz8ZeENAjYDJdfCWW0ksLfZhBBcg6htscCpK9b/5HXlbqG7X2DOHVzm7qoVEBEGcHPi+HfU94/J4JXMhYYyy175LPAbCiKiRNqShMpEFXwo56kk/vgbQGAzl5dEtK9vU41oizyn1VEl62qQ9+29to9wxxtREQmif7ELvTkEGCSCSJepPGd9K09hFl67xrUjCK7Da8yLzP4mROOP7d23c23GneXnkQKHSt9xfq/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK/KqnBW/bV3fztGH6DdVoOg/X1dqXWGbtrn1HRw47o=;
 b=kPP8ldDFjHILchIKv3ER79NK1G6JWg8tx9QnTExKDJnTMiIdRfrhzCkTncgARCHi2SgI0qCGHaeFZQd7wHKFH4NTIPdCERXr5ZP1EX7fvBLi2NyYBdstPTvYIqxI8EwluEyedGWj15eo7TKn1f4hay75/h6StCexaz7UftBQ62C42xE3N+Ry+zjgKysrPm/r3MHFD/9O85qKaUcscEa/+BhtuZ7zT6BaeLIl3BXq0e+6o8uu7jjSBLy3K0sT815H3fY6xARvTFK3f2ddP1gFrdj6qEgYNtfegK2KMB/dFqEHE5tSPERTqMGhDnAbEWV2vpzmB44TZc41ps5QzMB0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK/KqnBW/bV3fztGH6DdVoOg/X1dqXWGbtrn1HRw47o=;
 b=lxbbnLQVztvm5kbGvxgQlqt2Gr0n3QNx/dNL1x88c+mmxsLzhqgNr3ofwvWK0aSZsd2Rayp7ttpawfssUvyoEdxsyQOnr15cpbj6msUUmcqmX5/WcLIk1gXZMwlXgEHQWpbnEfQ66KocctzkAshHeiElsyo5IGW0Oxl6y9FI7r4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR1001MB2312.namprd10.prod.outlook.com (2603:10b6:910:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Wed, 22 Jun
 2022 18:32:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 18:32:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Fix memory shortage problem with Courteous
 server.
Thread-Topic: [PATCH 1/1] NFSD: Fix memory shortage problem with Courteous
 server.
Thread-Index: AQHYhmQKbJxYdZBYMEmMSAfehpjGQa1bu7KAgAADLACAAAETgA==
Date:   Wed, 22 Jun 2022 18:32:01 +0000
Message-ID: <725CC37D-020B-4CBF-8A04-473326DFBA30@oracle.com>
References: <1655921718-28842-1-git-send-email-dai.ngo@oracle.com>
 <27586B46-7926-46A7-AFF0-4E0F322B4225@oracle.com>
 <52820d99-48f6-f56a-fc00-3cbb7fa07f8e@oracle.com>
In-Reply-To: <52820d99-48f6-f56a-fc00-3cbb7fa07f8e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6108a2f8-58ac-43b4-bba6-08da547d7fd1
x-ms-traffictypediagnostic: CY4PR1001MB2312:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2312C0FA87344CDAAC038A3193B29@CY4PR1001MB2312.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWb+3LEY8Pu7s844t8BPHghiK8pu+dxpxzJCb7LPfVxpryq6OjtJ+Vk60kLI4mGzu7IOdT/y8CENTvqvXupdZaXxJnuSLGMkA5cFWjGZ7IJVt0ynodhAK4l4K2xg5e97y+T4nED+8KD/qQ50EHVwEm+LorrKZ5+s5m1xLEDT5cVPnncZmiWmYeJl67CmAILr9A9aRtCZr8NW0j8sD+HEfGwY3uUwHaP6IPw7hBoL/ik4uLP5qntx1ar1cQdH6LtiN3WAKCdNMxEXNYTcNvItyNTs+FRQqiV/pXuLHojO2rDC3Gv5WhdyaVdiaTTHdIvaRg+p/laBoevHu/vEPHE0FtTfJpR+4hAQSDXi2lW+YRbRKc7HNaPj5xDN9xtgyDDArC4IKPAbeKYTX5lAcFM54By02dJBJcD3SHcbyeca5z4hh1IOEh3B152hcFFss2w/c64FnqB3JD92eQVPyumnsf/OenVa3nadlJ0sJfEE5JJMb/P/BwauC+ag0S9MwAMHmyD7jmZm05dwHYbPnLYawQlw/ddPqvYx+4zM2crTUhqiDES3WiQ/Lc5TUHzcOQHBs8jhJG+sbUAWncpabXgFuXmk22Jt7UzcKeyq0QfN0AHNN5rVCutaBt29JRaX78Q/8jTolBuHh1KuvapXioi3+PaBL7YNkTg/XsdwcdVWtaroI7PhiK9yMD137AsYSvqFTmqrqx8/2ZPGcFojEUcABvFWbNqb2QROpG/d15NUxw0JKww68XmcdEB8TfWPjR4jSgB9PwMZcy25bmM30rTDzwSTpwEDmjI6CV19r18gv20=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(376002)(366004)(39860400002)(33656002)(71200400001)(26005)(2616005)(186003)(53546011)(8936002)(6486002)(41300700001)(8676002)(86362001)(37006003)(6862004)(6512007)(6636002)(478600001)(316002)(6506007)(66946007)(5660300002)(64756008)(66556008)(38070700005)(76116006)(83380400001)(66446008)(66476007)(38100700002)(122000001)(36756003)(4326008)(2906002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iO3PSwNagWeMbqdXr5HFMRJ35Isx/FIIwUagEOPY2S7LkeSdBw3yMCbIgh4y?=
 =?us-ascii?Q?0Nvjt2Q+YSaeWE0hJtyf+wQIiCwuau+/zUwoWvQig1+HiOtkdYqggcKdAtaM?=
 =?us-ascii?Q?LflBezpdS4SZVdsUwHEt/hxOLWg2ShQaQuTi0p7X9Z3rBArm7Z2VAomPw1/6?=
 =?us-ascii?Q?1a3lA3qKI2XuZXRV2yTSSfI89Cx9K42EXIly3uJNJvA9tuYYpgzh18lk6Z/h?=
 =?us-ascii?Q?lYBFDwrPr46+PiIX3KZH+7CfyVNo4vBuosh5gSEJ+7blHhDNB1c2fFrTQP/T?=
 =?us-ascii?Q?oKiSLkrpLMAXnfiz6n7MnWnxGDvPyRRZYyBWybQeQgjsoO1QaxssA8c/LUuQ?=
 =?us-ascii?Q?ych46PjkFAQ5jDKhjpHoS6tH7bnkg9hm8IyhxOeQYDO3cobIYlRgobRj3cxa?=
 =?us-ascii?Q?8WxUvHwdZaBPfy4Cdc82aexMD+DrCLgjkmIqUwlHja48b4LRsEllz6uHqqZX?=
 =?us-ascii?Q?7cV8q6TaYvHwKgjniwIXKN5ey/tHFI865SQvdmLYaCyiVCHi9lEnPNRaDEmT?=
 =?us-ascii?Q?AG0FuFyk+EgkpUTpO0L+ByH4r74wQhjKVbOMCIhDa9Pn4dKkBceEca3/L8Ho?=
 =?us-ascii?Q?Vep0iYBSatt51kGCZ0O8YcU7w7ePrusiVoq3wIFd/+ZMI/H630Xgx/vI9n3A?=
 =?us-ascii?Q?QBZrUkytueeXb7LkFtT+NZQbveHCyCpUyNUOski1p0SjaKqAgD0Ppwr/kiiI?=
 =?us-ascii?Q?zFk/zXWH31ggZ/s5bEotWA4spgZymhvePAywfcHacWtymDK8VjMlSvPorRhu?=
 =?us-ascii?Q?Vn8IPCPXdnYEbyiMOmv3Kxy08vCNo4SSc6i5mtyubQbSnfIoMVVzjJp+OZBv?=
 =?us-ascii?Q?uDKVPtoqUeW8m0/Wxf/FIqXuwZfWkZCA1UMUAsMDVm2Vl+btkk+LMY+G4dNp?=
 =?us-ascii?Q?sXj+5oOADFR5cxi9GgvblDKG936UdQZqixeGLLrNUyKbbg2+IlxKT9WTIRV4?=
 =?us-ascii?Q?4gtuOi2ap8XKz4pGdMyr8Kkd5+tSGkEmpJxPOi52KGsyQUaDDxXVLCg46kUV?=
 =?us-ascii?Q?rMIvP3DaTckeXGKcJjW0Tkm+p/lyjlX/6lOen9mrpmxfHDazsCNha9Y22laW?=
 =?us-ascii?Q?T+MA49xDBJyPK3BMeg8W91tkKRyqzY5+5VVT3WLqlEa4raqAznmAzleJzhwT?=
 =?us-ascii?Q?G2xu6Aa+aElG15RV6Njb/3Io2bBdk3sFeupKn7kD28wlhVVdP9cbVEOcGZJc?=
 =?us-ascii?Q?8kjGmoUg9CeOv4eGLwEvP9u8MyC98oUVzA6UeNtkttRcswD1PbcUj8qO4AX9?=
 =?us-ascii?Q?jq1HX7pnAI3jEahlUFWUXEyX81DdO6nOEvaaI/5YvtO1RibRIJifXt1ZOTnu?=
 =?us-ascii?Q?bdlvg93puyy1PrNvsKS2ZMDKgQQu7MKmNbQ6ifSXjj6zI/CtITNzGp/4SmXZ?=
 =?us-ascii?Q?Se/ikNv554JLaxDexlB4KXCQemzg4Wqf9zVl+XGhBSRqXh57Xui67Rf+jQeY?=
 =?us-ascii?Q?lgdGy+kRbxW7/T4yXWAOvYz5vmIhJEMWUga3PVtJOI7Hyb6M6knWVFQ8SUWr?=
 =?us-ascii?Q?jp7T411AP83t60022OoABGxu02hhUhk/DHNfxQDP2MSuNmzsiQ4NpB4GD0nV?=
 =?us-ascii?Q?/qOlDXclC48y1ezSu2+MMpwH9iEej0ZA2PeRX1dQ2qDAw2uECzC9v7p5S3q4?=
 =?us-ascii?Q?P8wazeX4TS755AFjtxZsNxwrmeyd4ODHPHFXQuhs6+8xrl/d6X/KIjpHgJtO?=
 =?us-ascii?Q?+xfIFg8k+ZEFPLRWm8LOQYCz27w3PmGHSOw5u/ysJjGx75NwhhLDX8/c+YIg?=
 =?us-ascii?Q?eh3P1kzSLCuDY0PXhixO4XEWnFn7bGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65481175653E174EABF15A6DF02600E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6108a2f8-58ac-43b4-bba6-08da547d7fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 18:32:01.7818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AV+tmBIjOgYqrNzDXCsVgqPor8dbU79vKEWdBMuagC8lojO8xIPl8vseouKv/MyAZ0rAOvjJ6i7P+jLwXrNRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2312
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_05:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220087
X-Proofpoint-ORIG-GUID: buEAp_Cmde_sZrrg55NXN92VipWwEaf8
X-Proofpoint-GUID: buEAp_Cmde_sZrrg55NXN92VipWwEaf8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 22, 2022, at 2:28 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 6/22/22 11:16 AM, Chuck Lever III wrote:
>>=20
>>> On Jun 22, 2022, at 2:15 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Currently the idle timeout for courtesy client is fixed at 1 day.
>>> If there are lots of courtesy clients remain in the system it can
>>> cause memory resource shortage that effects the operations of other
>>> modules in the kernel. This problem can be observed by running pynfs
>>> nfs4.0 CID5 test in a loop. Eventually system runs out of memory
>>> and rpc.gssd fails to add new watch:
>>>=20
>>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
>>> 		No space left on device
>>>=20
>>> and also alloc_inode fails with out of memory:
>>>=20
>>> Call Trace:
>>> <TASK>
>>> dump_stack_lvl+0x33/0x42
>>> dump_header+0x4a/0x1ed
>>> oom_kill_process+0x80/0x10d
>>> out_of_memory+0x237/0x25f
>>> __alloc_pages_slowpath.constprop.0+0x617/0x7b6
>>> __alloc_pages+0x132/0x1e3
>>> alloc_slab_page+0x15/0x33
>>> allocate_slab+0x78/0x1ab
>>> ? alloc_inode+0x38/0x8d
>>> ___slab_alloc+0x2af/0x373
>>> ? alloc_inode+0x38/0x8d
>>> ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
>>> ? alloc_inode+0x38/0x8d
>>> __slab_alloc.constprop.0+0x1c/0x24
>>> kmem_cache_alloc_lru+0x8c/0x142
>>> alloc_inode+0x38/0x8d
>>> iget_locked+0x60/0x126
>>> kernfs_get_inode+0x18/0x105
>>> kernfs_iop_lookup+0x6d/0xbc
>>> __lookup_slow+0xb7/0xf9
>>> lookup_slow+0x3a/0x52
>>> walk_component+0x90/0x100
>>> ? inode_permission+0x87/0x128
>>> link_path_walk.part.0.constprop.0+0x266/0x2ea
>>> ? path_init+0x101/0x2f2
>>> path_lookupat+0x4c/0xfa
>>> filename_lookup+0x63/0xd7
>>> ? getname_flags+0x32/0x17a
>>> ? kmem_cache_alloc+0x11f/0x144
>>> ? getname_flags+0x16c/0x17a
>>> user_path_at_empty+0x37/0x4b
>>> do_readlinkat+0x61/0x102
>>> __x64_sys_readlinkat+0x18/0x1b
>>> do_syscall_64+0x57/0x72
>>> entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>> RIP: 0033:0x7fce5410340e
>>>=20
>>> This patch adds a simple policy to dynamically adjust the idle
>>> timeout based on the percentage of available memory in the system
>>> as follow:
>>>=20
>>> . > 70% : unlimited. Courtesy clients are allowed to remain valid
>>> as long as memory availability is above 70%
>>> . 60% - 70%: 1 day.
>>> . 50% - 60%: 1hr
>>> . 40% - 50%: 30mins
>>> . 30% - 40%: 15mins
>>> . < 30%: disable. Expire all existing courtesy clients and donot
>>> allow new courtesey client
>> I thought our plan was to add a shrinker to do this.
>=20
> I'm not familiar with kernel's memory allocation and don't want to muck
> with it so I start with this simple approach but I'm open for any suggest=
ion
> on how to add a shrinker for this task. Is there any existing model that =
I
> can use as reference?

Fortunately there's nothing complicated about using a shrinker.
Look for register_shrinker() calls to see code examples. There
are two already in NFSD itself.


--
Chuck Lever



