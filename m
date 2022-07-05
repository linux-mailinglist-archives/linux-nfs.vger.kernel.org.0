Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00E567758
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiGETIh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGETIg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 15:08:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9D15720
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 12:08:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265HEFJk002553
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jul 2022 19:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kuwf4Vs4uLRtYjsOHTFK15H/hQl2H7jUNnqDQfo1Rkc=;
 b=BkitOAegY8T9xZIGi2YiWBKUQeXbnWuV4Cxt2jBdxbvn0twFico9HN2NEUCWNBOI8lJQ
 3kcLdYrZHa+D73DFf1JfsMgOgw6oM5slI5bawxM+HcnEPp+kUZ0s1S6TXoPJbl+hCKzy
 4Y2RnNibjPAIn9PZZcXNhtFawNlOo7fqhnMWwSCGztTxE8wPul0+FVq+5vmIAMv3XH/J
 chXVJgdf4v4AYHInqdOXTFyhHLmfcdda86lz5avAiWhpfP3iSAzKzT1kvq+N8NoZn57j
 VcXcN0LRnSLJgKRY82d6TW+1nLWTLQiiFug2w2W5FlLgejLy5rJ1LvyPv7pxwCjhT4Lc 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2dmsy0w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jul 2022 19:08:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265J5FnF011480
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jul 2022 19:08:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf8nwws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jul 2022 19:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpCnSJBFdugLIOINfxCNxubTQb/6kONu1YVdq4I7D8ffNzFjCV0nznCOcfa4Aru22gXq1jV1Skoxb22jKawoGASASduLCrm52Yu8UatwW9DKHnVzbUSPFd40yukYqIP1ZPOu9umE/hcL6jejDnPDVsxmBjRCeMPeGarKIqloKt48SZvlfeA90tclNIH+E5yiDbag+t67Mt2qSm4NBaYP1oQk/TeCfn0xYtwP2iNF6s53NivQ39nCMQPOgvqCMUkyof2zIw/vBFzo90NEVNcbLBJ/kebDnfHXw3ULqSStvuddNX0KbSpbtVi0WqMuSBNLWchdNa4fkPcl+tkSVbIpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuwf4Vs4uLRtYjsOHTFK15H/hQl2H7jUNnqDQfo1Rkc=;
 b=TWTXUMSGlpxUGEeR0v3br2yJ6BSZmgwRinIzPD6wT6uQzwL5Pt6lp8TaKMIiglZafh25HkcacQtpjzvi7cFmQPz50aoFrgfb1KM85p8tde+q2QIci3a6cBdNC4EnaB6zN53vTqu5ftKykSlWc+Z4kykxk8Y/xe/UYi8dhfu9ObkD4ULnfq3ZBPg2wYvOhwaZUm9LSzdzjw10emKM0Wlao8jBfmAWWpwPASFGInK1YZW0Y8TkJQ7qUTLwYS2KLBB3eJiXsmPMdo9Fiv69zvwikaX0jx1Zt66Ik5BAdlfI+yZ1K9tux0snBU5ds/HAkid0/Y3BzURMF1VlZPK8ALSsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuwf4Vs4uLRtYjsOHTFK15H/hQl2H7jUNnqDQfo1Rkc=;
 b=OOgTrRVOmU2HLvi1x8QnQWQSddW6VKJUDK8nn1RfOh5JTg1ktxX1roIWkOmgd0vOCC57f7rR6n5YewOsNpmJ3yfGQ2rgiwhkKNccbKfntY3jplqxoz61y4wI8/eqLsFjxVkL+TRkRCGR/1Oc+PH4PUyi2P15R9xCyfvitZh86zs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5971.namprd10.prod.outlook.com (2603:10b6:208:3ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 19:08:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:08:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Topic: [PATCH v2 0/2] NFSD: handling memory shortage problem with
 Courteous server
Thread-Index: AQHYj9kTr28oHI8WDEa3jt5++5AbZq1v3WyAgABAzgCAAAdOgA==
Date:   Tue, 5 Jul 2022 19:08:32 +0000
Message-ID: <B9CE5633-5A78-4F94-B653-D6348B8A229D@oracle.com>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
 <3A5C2D8F-0752-4070-9BEE-31D5E5F9AAAF@oracle.com>
 <61f067af-f634-e9fd-a0e5-4ee70c9e0887@oracle.com>
In-Reply-To: <61f067af-f634-e9fd-a0e5-4ee70c9e0887@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7480f993-8195-48f4-d83e-08da5eb9c10b
x-ms-traffictypediagnostic: IA1PR10MB5971:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5VHxGa6LgcPVAltadBPJw9vSftRxxqUhuRfZQyPtnMTu3KAo3qEB8q3hzas2zcXKngEJYoe+55IDHqXMqed9Yp4oRsQ7/lOdQP8K1rDHjAYnV5PV9KfknDTmnFdwGdkRqlUWvAS+LcFPJjXtIA7Ro7No1WghgNwFiq9eV3eJHqxg0xK1W94tYbRlu7x2glGUOIQAIeJcMAUAl+u2gcSuJy6BDDNso7x1wuR4DhZNHmcz3pai2nABmHL19pnTUj4PxS9oHhAeuSetchIimmnrihKv0dXwAVj0BBfE1TZebeNCfzq/LSLCmxT5BGncUj3LWaSxbg5dLIq/stm1WuN9/vHZHDu+eMD8sIVADy0pN1/zR7XKVdrqdH3rMBy91jxJ1PYaZz8mUoCQcuLciw7QLly6vl44JbPF8sPAIH96cYq1kjqWHgoVnDiE8FlL+cu9rA+WvyyIMRhSnP98lrhoaRKmzpeojqq4GK4XxFe9WlWQyYO90YANg7Xom9AN/8YMg9gOO8L5hoLcgc1mIBYGQ73z82LKHmEeIV/dlRkawL20XyctkeHMgSQ0Wy9lDeIWpaZHcCQwl5uskLYE52/OGCZz89VRKOnrgQRvKgyMg3EfZodmzCS02QN5eCE24yVYhBPiHmoPRb/gNZ33lb4gUgcY1Y26ZmngEPxWLaefDdu41nbxMVDX/U6SA/cgFHl6k4qp2rBXEs/zTO02hC42LFs0vaQR3EWUbQDxSO7ueu4vVb7Jr56fJb5FKmq+gVyiMDtm7emdbAaVUb5wdA0wOUoOOfYXxlzCsZQJ4wA5mh35qis9nZgW6JMpFQ1UE0RvyAVnVSXXq29n7Mgo5FbuCLXdc3sX6HWNuTGUCJ8ISNGbvd4H9iyYSYPUsSCdtCAu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(4326008)(8676002)(66556008)(76116006)(38100700002)(8936002)(316002)(86362001)(66446008)(66946007)(64756008)(37006003)(66476007)(91956017)(6862004)(2616005)(26005)(6636002)(6512007)(6506007)(53546011)(71200400001)(41300700001)(122000001)(38070700005)(6486002)(478600001)(33656002)(5660300002)(2906002)(83380400001)(30864003)(36756003)(186003)(87944003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqVZLNby33zZY1piIyJNswiSsood07h51BoBH1qb+fp2XA+SLMMiS1FroVXe?=
 =?us-ascii?Q?X5ytnF/29ihTHoIQb1l32GLO+JNldoUEo3WQPY+JRnQrA9XTtmItxkIEhKKs?=
 =?us-ascii?Q?Trxk8HWdGDYczsVcmzbWlBhtJRVgtiT0vuZOXzBQfkdZ+PYkK+kXmBxOIYmt?=
 =?us-ascii?Q?WygPgg7JNJZTIWGnqeHwX6eEaAr4El16eRm2q+Iylg2vAgy9Dpe/ycJvqAxN?=
 =?us-ascii?Q?9HbFku85bMS8Ye64fb2Tow98nLKvmwzb3bWo0EJBPf68GFV3QfJSd637vw1V?=
 =?us-ascii?Q?u5oYLqxr0+3UlcJz1HSWsHQxRuOgLjQWn8pxbiK4ugtmMWyCJYVu/bt2iA0F?=
 =?us-ascii?Q?jpEZaEu2qa3bZhsaWhH7WGI1XnQFjwlcWiX2tCa8utrxmLdYIg16oQCsyB1T?=
 =?us-ascii?Q?PxfUGqrnEDEIbOQV75MzeAXszt6uhqCr+Ww+vFx5qTNm+tEzjBoYCzO1FHDP?=
 =?us-ascii?Q?Uilr9mzne2FZSf1EMIChEWggoI+DM7YpTvtirp9MLQhSaSnDbrE6uXYA3Sqd?=
 =?us-ascii?Q?57EO+TOXIcjyjpXHnmwMNBcAU1rAXYLJo9gFr0FFhSLD03KZ8FagsdZRhhmz?=
 =?us-ascii?Q?dv/LdAWNUu9i5KfwBGtUixII/pEeqh+HrhxYjyxSlpsdc6wOqMWOZaI9UMQ2?=
 =?us-ascii?Q?Mh2bfh6YLRxmSOAC4mLkGd7Bcl6e6sWcrHDchlamxw7lmoQlka8tjwjgCLnJ?=
 =?us-ascii?Q?56xB7VD3Gynv3CehqTNbcFQGm1LmLwXdpfw7oFJr2k5sejzq6xYV8SUEzKPq?=
 =?us-ascii?Q?e7qkOIgHNoeB80xxcZEl43g3fBuMOeSNpByUHnyMm1AasrxFFhdEoorcT8Vp?=
 =?us-ascii?Q?zlbpTa+YR3uwii6rJm+K7ll/zKtvD1t2D0AQv7qCgpQ3ItbHMA4ufAUoydkw?=
 =?us-ascii?Q?OQsuKSyqkZ6iLw5+1DbNkFMQufkQmf/8CDIjeI2muvDyR+sCJ8xVMlGejJAT?=
 =?us-ascii?Q?B0nV2F2sldAs8bbEFj2z6XWgHW6xJ3i/euXb2+lVfxML8QVXkqHmdI1VLOUx?=
 =?us-ascii?Q?pWDAUlM+yB/XK4MbZOqGLQOZY/ohIPwEQOkp+suljVLMHet/bqeP4YYzFP3u?=
 =?us-ascii?Q?V8D3FrxAzBXdc1ho0QHGzJo45wZNZ16qx4vvVf7OOVcl9WTk0DHHB+EIZrS3?=
 =?us-ascii?Q?6oZjM+cXJPKarLibCMwvNqBJn5o40V+/yAvUMowneIlJEt2MS3pdTRde1bfP?=
 =?us-ascii?Q?LWHuX1YUxxUURruz8YTuKLL6nUr+2LJDTq+TINjXME3Fdc1G8pS4Sb/RXcqw?=
 =?us-ascii?Q?0P3ccTmrX5+Xql1UN8X3ceKdkAjUxl0Kk7rcsdA+8dENsbMU0kVeXrS+x6lA?=
 =?us-ascii?Q?twNYDmExBkYyUexbhqJDfW9qeEArgCocUbpYnGnH12bXQM2FkMDfDaSWV/Cc?=
 =?us-ascii?Q?Oi7XYB5cnaBHNke8VKp9k8IZReoc8SkUHkQ/YsIDVLDogxUMu/2660+tLqjJ?=
 =?us-ascii?Q?mlb6PzDDENjqIVK9io+FmPUG516jIcXTUxG0wShqP8Ae0ohazt0SD+1Ynvda?=
 =?us-ascii?Q?HFAugq8taHu8wEhG5k/GQ8zfDfrTAqdMJyM7qQYYWp7dF/STsqTOGrUIE/IU?=
 =?us-ascii?Q?BEXfiQXtYFsRON9AnPkrRnqGjlbgOMfzdWxpNuUNnr+CVSDE48qn91koqfnx?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E29ABA00FC2B246A8671CAA819A3B81@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7480f993-8195-48f4-d83e-08da5eb9c10b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 19:08:32.6461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNi8gPEaWd2h6arLddxE1rvt3nKcPgmMj3rj07IB0qSqDHg9cZaUzMBC/cPe4f57FwG2LSh1zF+UacD0UcUx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5971
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_16:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207050083
X-Proofpoint-GUID: ADSAmHwDeyaFgKr7oTu-fTriyg6_fXtA
X-Proofpoint-ORIG-GUID: ADSAmHwDeyaFgKr7oTu-fTriyg6_fXtA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 5, 2022, at 2:42 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 7/5/22 7:50 AM, Chuck Lever III wrote:
>> Hello Dai -
>>=20
>> I agree that tackling resource management is indeed an appropriate
>> next step for courteous server. Thanks for tackling this!
>>=20
>> More comments are inline.
>>=20
>>=20
>>> On Jul 4, 2022, at 3:05 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>>> there are lots of courtesy clients remain in the system it can cause
>>> memory resource shortage that effects the operations of other modules
>>> in the kernel. This problem can be observed by running pynfs nfs4.0
>>> CID5 test in a loop. Eventually system runs out of memory and rpc.gssd
>>> fails to add new watch:
>>>=20
>>> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
>>> No space left on device
>>>=20
>>> and alloc_inode also fails with out of memory:
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
>> These details are a little distracting. IMO you can summarize
>> the above with just this:
>>=20
>>>> Currently the idle timeout for courtesy client is fixed at 1 day. If
>>>> there are lots of courtesy clients remain in the system it can cause
>>>> memory resource shortage. This problem can be observed by running
>>>> pynfs nfs4.0 CID5 test in a loop.
>>=20
>>=20
>> Now I'm going to comment in reverse order here. To add context
>> for others on-list, when we designed courteous server, we had
>> assumed that eventually a shrinker would be used to garbage
>> collect courtesy clients. Dai has found some issues with that
>> approach:
>>=20
>>=20
>>> The shrinker method was evaluated and found it's not suitable
>>> for this problem due to these reasons:
>>>=20
>>> . destroying the NFSv4 client on the shrinker context can cause
>>> deadlock since nfsd_file_put calls into the underlying FS
>>> code and we have no control what it will do as seen in this
>>> stack trace:
>> [ ... stack trace snipped ... ]
>>=20
>> I think I always had in mind that only the laundromat would be
>> responsible for harvesting courtesy clients. A shrinker might
>> trigger that activity, but as you point out, a deadlock is pretty
>> likely if the shrinker itself had to do the harvesting.
>>=20
>>=20
>>> . destroying the NFSv4 client has significant overhead due to
>>> the upcall to user space to remove the client records which
>>> might access storage device. There is potential deadlock
>>> if the storage subsystem needs to allocate memory.
>> The issue is that harvesting a courtesy client will involve
>> an upcall to nfsdcltracker, and that will result in I/O that
>> updates the tracker's database. Very likely this will require
>> further allocation of memory and thus it could deadlock the
>> system.
>>=20
>> Now this might also be all the demonstration that we need
>> that managing courtesy resources cannot be done using the
>> system's shrinker facility -- expiring a client can never
>> be done when there is a direct reclaim waiting on it. I'm
>> interested in other opinions on that. Neil? Bruce? Trond?
>>=20
>>=20
>>> . the shrinker kicks in only when memory drops really low, ~<5%.
>>> By this time, some other components in the system already run
>>> into issue with memory shortage. For example, rpc.gssd starts
>>> failing to add watches in /var/lib/nfs/rpc_pipefs/nfsd4_cb
>>> once the memory consumed by these watches reaches about 1% of
>>> available system memory.
>> Your claim is that a courtesy client shrinker would be invoked
>> too late. That might be true on a server with 2GB of RAM, but
>> on a big system (say, a server with 64GB of RAM), 5% is still
>> more than 3GB -- wouldn't that be enough to harvest safely?
>>=20
>> We can't optimize for tiny server systems because that almost
>> always hobbles the scalability of larger systems for no good
>> reason. Can you test with a large-memory server as well as a
>> small-memory server?
>=20
> I don't have a system with large memory configuration, my VM has
> only 6GB of memory.

Let's ask internally. Maybe Barry's group has a big system it
can lend us.


>> I think the central question here is why is 5% not enough on
>> all systems. I would like to understand that better. It seems
>> like a primary scalability question that needs an answer so
>> a good harvesting heuristic can be derived.
>>=20
>> One question in my mind is what is the maximum rate at which
>> the server converts active clients to courtesy clients, and
>> can the current laundromat scheme keep up with harvesting them
>> at that rate? The destructive scenario seems to be when courtesy
>> clients are manufactured faster than they can be harvested and
>> expunged.
>=20
> That seems to be the case. Currently the laundromat destroys idle
> courtesy clients after 1 day and running CID5 in a loop generates
> a ton of courtesy clients. Before the 1-day expiration occurs,
> memory already drops to almost <1% and problems with rpc.gssd and
> memory allocation were seen as mentioned above.

The issue is not the instantaneous amount of memory available,
it's the change in free memory. If available memory is relatively
constant, even if it's at 25%, there's no reason to trim the
courtesy list. The problem arises when the number of courtesy
clients is increasing quickly.


>=20
>>=20
>> (Also I recall Bruce fixed a problem recently with nfsdcltracker
>> where it was doing three fsync's for every database update,
>> which significantly slowed it down. You should look for that
>> fix in nfs-utils and ensure the above rate measurement is done
>> with the fix applied).
>=20
> will do.
>=20
>>=20
>>=20
>>> This patch addresses this problem by:
>>>=20
>>> . removing the fixed 1-day idle time limit for courtesy client.
>>> Courtesy client is now allowed to remain valid as long as the
>>> available system memory is above 80%.
>>>=20
>>> . when available system memory drops below 80%, laundromat starts
>>> trimming older courtesy clients. The number of courtesy clients
>>> to trim is a percentage of the total number of courtesy clients
>>> exist in the system. This percentage is computed based on
>>> the current percentage of available system memory.
>>>=20
>>> . the percentage of number of courtesy clients to be trimmed
>>> is based on this table:
>>>=20
>>> ----------------------------------
>>> | % memory | % courtesy clients |
>>> | available | to trim |
>>> ----------------------------------
>>> | > 80 | 0 |
>>> | > 70 | 10 |
>>> | > 60 | 20 |
>>> | > 50 | 40 |
>>> | > 40 | 60 |
>>> | > 30 | 80 |
>>> | < 30 | 100 |
>>> ----------------------------------
>> "80% available memory" on a big system means there's still an
>> enormous amount of free memory on that system. It will be
>> surprising to administrators on those systems if the laundromat
>> is harvesting courtesy clients at that point.
>=20
> at 80% and above there is no harvesting going on.

You miss my point. Even 30% available on a big system is still
a lot of memory and not a reason (in itself) to start trimming.


>> Also, if a server is at 60-70% free memory all the time due to
>> non-NFSD-related memory consumption, would that mean that the
>> laundromat would always trim courtesy clients, even though doing
>> so would not be needed or beneficial?
>=20
> it's true that there is no benefit to harvest courtesy clients
> at 60-70% if the available memory stays in this range. But we
> don't know whether available memory will stay in this range or
> it will continue to drop (as in my test case with CID5). Shouldn't
> we start harvest some of the courtesy clients at this point to
> be on the safe side?

The Linux philosophy is to let the workload take as many resources
as it can. The common case is that workload resident sets nearly
always reside comfortably within available resources, so garbage
collection that happens too soon is wasted effort and can even
have negative impact.

The other side of that coin is that when we hit the knee, a Linux
system is easy to push into thrashing because then it will start
pushing things out desperately. That's kind of the situation I
would like to avoid, but I don't think trimming when there is
more than half of memory available is the answer.


>> I don't recall, are courtesy clients maintained on an LRU so
>> that the oldest ones would be harvested first?
>=20
> courtesy clients and 'normal' clients are in the same LRU list
> so the oldest ones would be harvested first.

OK, thanks for confirming.


>>> . due to the overhead associated with removing client record,
>>> there is a limit of 128 clients to be trimmed for each
>>> laundromat run. This is done to prevent the laundromat from
>>> spending too long destroying the clients and misses performing
>>> its other tasks in a timely manner.
>>>=20
>>> . the laundromat is scheduled to run sooner if there are more
>>> courtesy clients need to be destroyed.
>> Both of these last two changes seem sensible. Can they be
>> broken out so they can be applied immediately?
>=20
> Yes. Do you want me to rework the patch just to have these 2
> changes for now while we continue to look for a better solution
> than the proposed fixed percentage?

Yes. Two patches, one for each of these changes.


--
Chuck Lever



