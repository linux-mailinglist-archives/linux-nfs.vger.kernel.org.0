Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6943C568EA0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiGFQEx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGFQEw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 12:04:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7361237D7
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 09:04:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E3xal022831;
        Wed, 6 Jul 2022 16:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3QetRT7jmMnja7DHK6ZskPhtaF6UqxtV8p9eN5cUaas=;
 b=jstAm1GMU2wgit0t0WMb2wm5mO+a0pi3c4nix9cEFshRXBY3HiNSl16N1djOGIMvqQ9e
 r9NpmRNaSBodMiwmqqxjVndLo4W2s/EYt1mT+ME63te9Ddy6HyFUwImJHfyAAuWe2wim
 5GRo+na/wm9TOVSOzrwXrxTsOnYZW1rYOSqNgxz2uQ8XWX0EgOATjj9iUjc0kDhgtinh
 QFpl857cXhgiYQrA61Rq82yLRgWNFt/Jpd4NuHSqpHQEret/fBVfyGpF/1RukUWBBgDq
 CBwBow4685x2JGaaLslgL8d5pwJZQN07S/z5mI6wWCv55rK1Cq/MAEv3GbW1h1xr2Tm0 Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby2gnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:04:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266G10Vv019410;
        Wed, 6 Jul 2022 16:04:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud0xhpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbxD/c5IhcacxjkZXlRazq/+jPhluPIVsWe2RpuFYx/eLKIMeosm4kAS0HuK8ONGaVeMiCBpYGGbGI71nnEsI3H1pqAsaNUf/IMJjjNm40kRPJwJ4MxS7YwfqANH4nL2F8OoWnq1fjwwYTziMQzrUGydnUs0h1W23iIvMz0H7Qu0BbJ8o6Sys6//TVMKkxKCxlAi7IOtF8Unph7K/R66temTa/pVee0p7KgCvk/ciGaq9ZzQ2q5jAGHywbt2Ldwt5BClXtZwO+OmaBaD/dV+ylSgx1Zn5nmoerTzk5TetWdsjSs/mHcgDwPNQ+Wfj41ZF3yOz2vPywvyDHI71JDJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QetRT7jmMnja7DHK6ZskPhtaF6UqxtV8p9eN5cUaas=;
 b=BvqJeZc/vlSId9+n6NDrw7Azlt1rpjOEMKyLv61smjl84NtjG0OmkO9glUY562LYs0dWoRT2xZ1Xrd46S0XW6XPLV7lnVH93VsfYGP4jLfBmDgJYUkJboAdCaEaqIx5mp8qnPQcsNlIFaiiTx9iziS5yXJOEeigwN79N5xrspdjverW/LSpNadilC4qHe7PF5vAKxkGqJCA3S1ofbtpvo1WyaSu4ucXOusEpNGrIuvVxt9fndt1cEnI3J/nBz1LVQ1sK4qWJBZ+/ujF0h4Xlp3vZB1yckeHrS/4fgtNcIVNQ+yWfaPV8NcnVSYddZ/nCr8Dz7og1VoaKw+kew/MDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QetRT7jmMnja7DHK6ZskPhtaF6UqxtV8p9eN5cUaas=;
 b=P40MTexzbxdfqs3GL4WQkaLRDzA5pKGZX5J2W4NPG/j4ThYfBBKrvWRqXUHleD7mWNMVFccQUtQzlv5BVCcJgIpS/452bgKLjF0MpbsElDtlgc1p+JkeUSnf9ITOocaktLhD6dozbgNr/qoAzbCjs9YkKZxWrU2dOoJvkjidGIg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5434.namprd10.prod.outlook.com (2603:10b6:510:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 16:04:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:04:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Topic: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Index: AQHYj9kTr28oHI8WDEa3jt5++5AbZq1v3WyAgABAzgCAAAdOgIABWcuAgAAFMIA=
Date:   Wed, 6 Jul 2022 16:04:44 +0000
Message-ID: <10F92A65-AAD4-444F-8B65-0922BC9A5C5A@oracle.com>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
 <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
 <61f067af-f634-e9fd-a0e5-4ee70c9e0887@oracle.com>
 <B9CE5633-5A78-4F94-B653-D6348B8A229D@oracle.com>
 <20220706154609.GA29941@fieldses.org>
In-Reply-To: <20220706154609.GA29941@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88802878-a62f-4759-2deb-08da5f693e14
x-ms-traffictypediagnostic: PH0PR10MB5434:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANyx4kBsisMBHk5XWXJlociXdnAEVfgIcyjK7NZd+Lw7RdiFE7awYxudlxooJrEDzvEUj1L4A3oUSJLTok4lh6uIIcD9zpdcaxpsM1y3TWL/xL+ExLy7F3oq+j9iCdcFaF8lJ3EG1KLsMYCwNkD9wm/RVL4ZUnlx7hELDdK2UGDb3iStZqb6KCi0nyKJyi5ly62cSZSF6+vD2gk1ze9kiQEFlse+di1VaFHejZB2oqa5C75aVR7GIyj3Cy+Ovbi1w7mRYCtfrfrNqV0lvx/y68wg9UlxdvXOKTqJKBdQTp7/1O1AS4pOrquqvBZ1bL1OMpuRxG/1LpM0W47gt9BNnhNn5mDqpS96IUc1g4/JxFj0Eo8rq3/kiest2hopfbSYKJh7MwEI1gK3YcThk4X0vxduJm1xlO07FB9gC9H5ZnVxWSnc6o7xIzNBGc9sPgmtrjT/q+sI5S55nD0Dw0IdK8sQXe7HOzkiaSbnfh2IvjvvP9tauvJDAOW607cRxI2kzmChGdS5HHgi3chWyLz38RokbxPPyzROAyh1eWLX41rLanBCb+Ran+rqJs82OePbbk5NzQAFoqcw1hrEi0Qq26LJVWRsc3L9wJFSWyh+Xjp2PGxqK4gyWLJX99u2xacRc9SgWQVlzcTT6Tjj1JaXDf59a1CyxpR1jRp3QDbPwDXuCoY8KDiKOlSqmLqq1yHbk95YU7ab1l0A6YZDjqfJEEfhaMZuTqkuPl1Bu148MDwFXtasIvsGliwUzhZPk55xh9Av0DOHEIfe/vJC1BBZKElUXZo8eZy2P5R7XZ7EJFhaFv2IEZfgwIQ5ECESqcTKFMDuBMgXvTIwmc3VJpQHlIaIcH0clfWx7nlcAaCk0tyGP+3u5qIvQNQy8iS6Fruy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(136003)(366004)(346002)(6512007)(64756008)(66946007)(66446008)(2616005)(66556008)(66476007)(8936002)(4326008)(8676002)(91956017)(5660300002)(76116006)(36756003)(41300700001)(6916009)(33656002)(86362001)(2906002)(6486002)(186003)(26005)(53546011)(6506007)(478600001)(122000001)(83380400001)(38070700005)(316002)(30864003)(54906003)(71200400001)(38100700002)(87944003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6lK1M5pKWndIgUnVXxEqMoWDLxgQiG4CEvP6ED/ExpYotAru/vWfB6+wfna1?=
 =?us-ascii?Q?CfPixfMaJe7uFhHZTfyYM/t68vDj2pEZHeeziOTo5jBy4YLfJB431Q0BONyo?=
 =?us-ascii?Q?C9IFDns5oGKvXC0KoKuWGvSoEcAidGWDORS8gCsRxDWTB6LugqWEq7pw7kW5?=
 =?us-ascii?Q?pgbJpUfODHb6yiN1jN2P5trYiy3W0g0DP9O7tUhVNK53erskJCWpjyi3UlYZ?=
 =?us-ascii?Q?VWZwZJBvdHUV/iHQx65a799l1T0sKB/VvtCwgZeAIPMYP6+zpRcAKTNxdoqm?=
 =?us-ascii?Q?Jm3vB2ZqszRhO+fFsTaaVoMh4J3A6S8+Gkf+24F9UVl4K7MXqKsj5y6DE9xh?=
 =?us-ascii?Q?s6e3/MBj06fFuoBj4kuJeTtYGLjXK6tfEdLJwb6QL0n58/5+zMYo2jalhomx?=
 =?us-ascii?Q?c6oBm2MyXK97W2erBbthNoKznDcL9j+iSDjNjWSsPyrQAKkwTQhqYFy60hC9?=
 =?us-ascii?Q?CloLYHOM+H+KcypsD1izk/ixlnBooz5ZzpGc72ULeRFhxqgPgvTZwQY/U01k?=
 =?us-ascii?Q?/n99gpwVJx+sU3FnzWZg1Y4muWC/jzHFPh9Ju4rcxgoaP+3j+TBjZ7ooTSN1?=
 =?us-ascii?Q?zsOrmfFTb0nLc2OKdcKJDd1KJCooz3QWm4v1OACbmzDlDYSMUqJ3FC1jWBwV?=
 =?us-ascii?Q?gX0gMlvNDESdYir0pIKhNFIoIcA4t1MmbrR1qfMMwmEhVromRVvTApfqHn2O?=
 =?us-ascii?Q?AJYDb1LjImasJAf/516Y6abf9ZscASfyxOOTLIS/w445Y/KJNt6wwrBOXN04?=
 =?us-ascii?Q?9T0U0szfhpYtbbiZJFQThFCuPR5hLJPL7ORD6T171pSGE+yCumWhQL7oAUDp?=
 =?us-ascii?Q?vxdiKSP/fbmm7PcRig1yBD/lH6ZGt7dmZ87n5fMUXX/5Nht9ACTLg52TOgr6?=
 =?us-ascii?Q?RuAD/G//xwS2ACKe5F1ZYVVsyU6rwE5kxgPjzfwse4vuHui+eTeN3bD8UPxI?=
 =?us-ascii?Q?Dm7n55FbwcAG0YIhkkhPllGzmoqLFVBBx91C2nUTjS4NfXrAzm9ef4Ca3mey?=
 =?us-ascii?Q?tfi4iTD5px7tvVohrtTz4G5zwVoBqQnpwhACLjaWNbnpotg0Z1i8jP//LxeN?=
 =?us-ascii?Q?6K5XlxY6Fj6IHQUL6lRCM2b4jr/pa/x/IwXRa4K44bcTVEVm5Crf87R4bSVD?=
 =?us-ascii?Q?m6zRa6oVeW2G2x7HooQkdrHMhqJMDR9ESCPlWlVDoNu6Fc2lWxVC4b559KuZ?=
 =?us-ascii?Q?A0iD/xylHzj/RzRLG5UdZOrpd3DbpfifBfOuGvBc+I/Z4sUFIhverXQdGO+C?=
 =?us-ascii?Q?2Hp4fjT2NE6dct5mzyh4HrsZLed8RfUHrr4bbpxrqQpx5wHuDM2e1+I5sojY?=
 =?us-ascii?Q?HInkasafuavNyjIp4HwtzsGHMZE+5UoHcrDnB3bRAUbyQHaBtQDxsjs7Um+u?=
 =?us-ascii?Q?5EQMmUwiFccHHb4hhEGCMMmr95lPC3pxwvloZuRw8m9F+oNJE2PCZl8O9vWD?=
 =?us-ascii?Q?5aeT3ILboEj2706eSuFnpu0sqE4YjZ1h59P9BwmwYMv7uQbFcPbeuL6owSeP?=
 =?us-ascii?Q?rXRG2EiwyN/wxNiUVdSY3l9jeMqS/Agoxq5V7wlydLtNVnG5JsaFuBAKegbk?=
 =?us-ascii?Q?LVjiAXBdzPnzBqSN1zeFeI+jpPyLt3LXLZG7e/NtPrKRSlEtp+a8Ur8WGSKA?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85401051B9F6A54EB18CA6808E92F68C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88802878-a62f-4759-2deb-08da5f693e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:04:44.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDSqWCQReOW3CjKRKWR2835HCeOCGYXL3Q5rIm4Fl3TP1PLYRsBPWKPcwo31Hyhm05P3W7TqCCpbFW8pQZXA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5434
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060064
X-Proofpoint-ORIG-GUID: Us3AAW7AF1rSQqdsiqQ9kROt36lWRbjk
X-Proofpoint-GUID: Us3AAW7AF1rSQqdsiqQ9kROt36lWRbjk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 11:46 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Tue, Jul 05, 2022 at 07:08:32PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jul 5, 2022, at 2:42 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 7/5/22 7:50 AM, Chuck Lever III wrote:
>>>> Hello Dai -
>>>>=20
>>>> I agree that tackling resource management is indeed an appropriate
>>>> next step for courteous server. Thanks for tackling this!
>>>>=20
>>>> More comments are inline.
>>>>=20
>>>>=20
>>>>> On Jul 4, 2022, at 3:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>=20
>>>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>>>>> there are lots of courtesy clients remain in the system it can cause
>>>>> memory resource shortage that effects the operations of other modules
>>>>> in the kernel. This problem can be observed by running pynfs nfs4.0
>>>>> CID5 test in a loop. Eventually system runs out of memory and rpc.gss=
d
>>>>> fails to add new watch:
>>>>>=20
>>>>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e=
:
>>>>> No space left on device
>>>>>=20
>>>>> and alloc_inode also fails with out of memory:
>>>>>=20
>>>>> Call Trace:
>>>>> <TASK>
>>>>> dump_stack_lvl+0x33/0x42
>>>>> dump_header+0x4a/0x1ed
>>>>> oom_kill_process+0x80/0x10d
>>>>> out_of_memory+0x237/0x25f
>>>>> __alloc_pages_slowpath.constprop.0+0x617/0x7b6
>>>>> __alloc_pages+0x132/0x1e3
>>>>> alloc_slab_page+0x15/0x33
>>>>> allocate_slab+0x78/0x1ab
>>>>> ? alloc_inode+0x38/0x8d
>>>>> ___slab_alloc+0x2af/0x373
>>>>> ? alloc_inode+0x38/0x8d
>>>>> ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
>>>>> ? alloc_inode+0x38/0x8d
>>>>> __slab_alloc.constprop.0+0x1c/0x24
>>>>> kmem_cache_alloc_lru+0x8c/0x142
>>>>> alloc_inode+0x38/0x8d
>>>>> iget_locked+0x60/0x126
>>>>> kernfs_get_inode+0x18/0x105
>>>>> kernfs_iop_lookup+0x6d/0xbc
>>>>> __lookup_slow+0xb7/0xf9
>>>>> lookup_slow+0x3a/0x52
>>>>> walk_component+0x90/0x100
>>>>> ? inode_permission+0x87/0x128
>>>>> link_path_walk.part.0.constprop.0+0x266/0x2ea
>>>>> ? path_init+0x101/0x2f2
>>>>> path_lookupat+0x4c/0xfa
>>>>> filename_lookup+0x63/0xd7
>>>>> ? getname_flags+0x32/0x17a
>>>>> ? kmem_cache_alloc+0x11f/0x144
>>>>> ? getname_flags+0x16c/0x17a
>>>>> user_path_at_empty+0x37/0x4b
>>>>> do_readlinkat+0x61/0x102
>>>>> __x64_sys_readlinkat+0x18/0x1b
>>>>> do_syscall_64+0x57/0x72
>>>>> entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>> These details are a little distracting. IMO you can summarize
>>>> the above with just this:
>>>>=20
>>>>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>>>>>> there are lots of courtesy clients remain in the system it can cause
>>>>>> memory resource shortage. This problem can be observed by running
>>>>>> pynfs nfs4.0 CID5 test in a loop.
>>>>=20
>>>>=20
>>>> Now I'm going to comment in reverse order here. To add context
>>>> for others on-list, when we designed courteous server, we had
>>>> assumed that eventually a shrinker would be used to garbage
>>>> collect courtesy clients. Dai has found some issues with that
>>>> approach:
>>>>=20
>>>>=20
>>>>> The shrinker method was evaluated and found it's not suitable
>>>>> for this problem due to these reasons:
>>>>>=20
>>>>> . destroying the NFSv4 client on the shrinker context can cause
>>>>> deadlock since nfsd_file_put calls into the underlying FS
>>>>> code and we have no control what it will do as seen in this
>>>>> stack trace:
>>>> [ ... stack trace snipped ... ]
>>>>=20
>>>> I think I always had in mind that only the laundromat would be
>>>> responsible for harvesting courtesy clients. A shrinker might
>>>> trigger that activity, but as you point out, a deadlock is pretty
>>>> likely if the shrinker itself had to do the harvesting.
>>>>=20
>>>>=20
>>>>> . destroying the NFSv4 client has significant overhead due to
>>>>> the upcall to user space to remove the client records which
>>>>> might access storage device. There is potential deadlock
>>>>> if the storage subsystem needs to allocate memory.
>>>> The issue is that harvesting a courtesy client will involve
>>>> an upcall to nfsdcltracker, and that will result in I/O that
>>>> updates the tracker's database. Very likely this will require
>>>> further allocation of memory and thus it could deadlock the
>>>> system.
>>>>=20
>>>> Now this might also be all the demonstration that we need
>>>> that managing courtesy resources cannot be done using the
>>>> system's shrinker facility -- expiring a client can never
>>>> be done when there is a direct reclaim waiting on it. I'm
>>>> interested in other opinions on that. Neil? Bruce? Trond?
>>>>=20
>>>>=20
>>>>> . the shrinker kicks in only when memory drops really low, ~<5%.
>>>>> By this time, some other components in the system already run
>>>>> into issue with memory shortage. For example, rpc.gssd starts
>>>>> failing to add watches in /var/lib/nfs/rpc_pipefs/nfsd4_cb
>>>>> once the memory consumed by these watches reaches about 1% of
>>>>> available system memory.
>>>> Your claim is that a courtesy client shrinker would be invoked
>>>> too late. That might be true on a server with 2GB of RAM, but
>>>> on a big system (say, a server with 64GB of RAM), 5% is still
>>>> more than 3GB -- wouldn't that be enough to harvest safely?
>>>>=20
>>>> We can't optimize for tiny server systems because that almost
>>>> always hobbles the scalability of larger systems for no good
>>>> reason. Can you test with a large-memory server as well as a
>>>> small-memory server?
>>>=20
>>> I don't have a system with large memory configuration, my VM has
>>> only 6GB of memory.
>>=20
>> Let's ask internally. Maybe Barry's group has a big system it
>> can lend us.
>>=20
>>=20
>>>> I think the central question here is why is 5% not enough on
>>>> all systems. I would like to understand that better. It seems
>>>> like a primary scalability question that needs an answer so
>>>> a good harvesting heuristic can be derived.
>>>>=20
>>>> One question in my mind is what is the maximum rate at which
>>>> the server converts active clients to courtesy clients, and
>>>> can the current laundromat scheme keep up with harvesting them
>>>> at that rate? The destructive scenario seems to be when courtesy
>>>> clients are manufactured faster than they can be harvested and
>>>> expunged.
>>>=20
>>> That seems to be the case. Currently the laundromat destroys idle
>>> courtesy clients after 1 day and running CID5 in a loop generates
>>> a ton of courtesy clients. Before the 1-day expiration occurs,
>>> memory already drops to almost <1% and problems with rpc.gssd and
>>> memory allocation were seen as mentioned above.
>>=20
>> The issue is not the instantaneous amount of memory available,
>> it's the change in free memory. If available memory is relatively
>> constant, even if it's at 25%, there's no reason to trim the
>> courtesy list. The problem arises when the number of courtesy
>> clients is increasing quickly.
>>=20
>>=20
>>>=20
>>>>=20
>>>> (Also I recall Bruce fixed a problem recently with nfsdcltracker
>>>> where it was doing three fsync's for every database update,
>>>> which significantly slowed it down. You should look for that
>>>> fix in nfs-utils and ensure the above rate measurement is done
>>>> with the fix applied).
>>>=20
>>> will do.
>>>=20
>>>>=20
>>>>=20
>>>>> This patch addresses this problem by:
>>>>>=20
>>>>> . removing the fixed 1-day idle time limit for courtesy client.
>>>>> Courtesy client is now allowed to remain valid as long as the
>>>>> available system memory is above 80%.
>>>>>=20
>>>>> . when available system memory drops below 80%, laundromat starts
>>>>> trimming older courtesy clients. The number of courtesy clients
>>>>> to trim is a percentage of the total number of courtesy clients
>>>>> exist in the system. This percentage is computed based on
>>>>> the current percentage of available system memory.
>>>>>=20
>>>>> . the percentage of number of courtesy clients to be trimmed
>>>>> is based on this table:
>>>>>=20
>>>>> ----------------------------------
>>>>> | % memory | % courtesy clients |
>>>>> | available | to trim |
>>>>> ----------------------------------
>>>>> | > 80 | 0 |
>>>>> | > 70 | 10 |
>>>>> | > 60 | 20 |
>>>>> | > 50 | 40 |
>>>>> | > 40 | 60 |
>>>>> | > 30 | 80 |
>>>>> | < 30 | 100 |
>>>>> ----------------------------------
>>>> "80% available memory" on a big system means there's still an
>>>> enormous amount of free memory on that system. It will be
>>>> surprising to administrators on those systems if the laundromat
>>>> is harvesting courtesy clients at that point.
>>>=20
>>> at 80% and above there is no harvesting going on.
>>=20
>> You miss my point. Even 30% available on a big system is still
>> a lot of memory and not a reason (in itself) to start trimming.
>>=20
>>=20
>>>> Also, if a server is at 60-70% free memory all the time due to
>>>> non-NFSD-related memory consumption, would that mean that the
>>>> laundromat would always trim courtesy clients, even though doing
>>>> so would not be needed or beneficial?
>>>=20
>>> it's true that there is no benefit to harvest courtesy clients
>>> at 60-70% if the available memory stays in this range. But we
>>> don't know whether available memory will stay in this range or
>>> it will continue to drop (as in my test case with CID5). Shouldn't
>>> we start harvest some of the courtesy clients at this point to
>>> be on the safe side?
>>=20
>> The Linux philosophy is to let the workload take as many resources
>> as it can. The common case is that workload resident sets nearly
>> always reside comfortably within available resources, so garbage
>> collection that happens too soon is wasted effort and can even
>> have negative impact.
>=20
> In this particular case (pynfs with repeated CID5), I think each client
> is an NFSv4.0 client with a single open. I wonder how much memory that
> ends up using per client? The client itself is only 1k, the inode,
> file, dentry, nfs4 stateid, etc., probably add a few more k. If you're
> filling up gigabytes of memory with that, then you may be talking about
> 10s-hundreds of thousands of clients, which your server probably can't
> handle well anyway, and the bigger problem may be that at a synchronous
> file write per client you're going to be waiting a long time to expire
> them all.

Exactly: the rate at which client leases/state can be created
exceeds the rate at which they can be garbage collected.


> I wonder what more realistic cases might look like?
>=20
> In the 4.1 case you'll probably run into the session limits first.
> Maybe nfsd4_get_drc_mem should be able to suggest purging courtesy
> clients?
>=20
> In the 4.0 case maybe we're more at risk of blowing up the nfs4 file
> cache?
>=20
>> The other side of that coin is that when we hit the knee, a Linux
>> system is easy to push into thrashing because then it will start
>> pushing things out desperately. That's kind of the situation I
>> would like to avoid, but I don't think trimming when there is
>> more than half of memory available is the answer.
>=20
> I dunno, a (possibly somewhat arbitrary) limit on the number of courtesy
> clients doesn't sound so bad to me, especially since we know the IO
> required to expire them is proportional to that number.

Given your analysis above I have to wonder if the issue is not the
number of courtesy clients, but the /total/ number of clients. The
server should maybe want to limit the total number of clients due
to concerns about how much memory they consume and how long it would
take to expunge each of them.


--
Chuck Lever



