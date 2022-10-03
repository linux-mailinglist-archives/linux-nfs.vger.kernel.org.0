Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A45F31CB
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJCOMw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJCOMu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 10:12:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193746DBC;
        Mon,  3 Oct 2022 07:12:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293DOaUS030232;
        Mon, 3 Oct 2022 14:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+wqaEBlPqpDH5oW0rIG9NY80qBAQADscGka3FsNiGfc=;
 b=aLwmChjW+npepvJswHNzDkEtNiC0fsYun7ZeASeMB/u9JqvYA31gNGPk/0dfr7kjiDm4
 GC9cfuPH4XKHhPNix5LM/nsZ2L9f2XzAK2CwZ4pRDQeX2quOiRZnEk2RUxNB7deNy/n/
 kG2VncnLSQVa9VcrNmtXVRgACRmna2yuY/HEmf0Jq0mcDNvPuDSmQssRHa8NgENOXsqF
 e55JvNZPfS8GbDh+4QhQ9UyahkDDitbqmZDZSEdYqpNOxBEFmWYnogbP7vGXo0XJOckj
 caRpwqVRLk1wnZr3gTxbOb3pM1yOgRNCliQPIqMw+GAZRL05KLpO4iUwOuEtLW/knpdx /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea3nee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 14:12:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 293DUX6Q030283;
        Mon, 3 Oct 2022 14:12:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc09hwxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 14:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+VYR5anR0/8MyQraIS27YujJONKjtAtQbps6jAm+y9E6iblYFG6s6ZSmX0d+wl8DqX8tth1QNLsWED27jC2pd6Jb3zYIY9zfyW9TYwWsy+2WM/RnwgLS1grgFF9pY8raqOYJLxcFAINdnrWu1cEW4dqNivlrOJkrZOrIdUGbhiucmwA4uA8Ape5Yk4ukX/JPZPdLRyHykuFpnBqkH1/cXWuqTkn/MhDR+h1qqkvdEOrmdhqZcB2w1+MO7J5dIJ7uM1PBMOf4i19munlbqkPZ2kNjX2azKnHHbVpmNJVuqEaXIycg7ZwJXrPt0YECc4+4wX7Tz/OpVWY1N1s4x7iZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wqaEBlPqpDH5oW0rIG9NY80qBAQADscGka3FsNiGfc=;
 b=fmEDeZ8mmzCYkrLyGxbpjcyZ1UQJH904L1Lef+SH1lJeHVYdxlwAx3ns5P4BRpA+Wm1EpYUicT7SF0buEO/xGfQdMUL5/Vp5dts7Z/UVr5c3vTwahFcYx8NVr9e9/uFF9bMfVDoVouktmMkmVRVSvaR0Lnl3MEPvHRCJeeZec0ED7d3siuxzM5+y3m5uGPE0vN0e/yJlQblaUQIW8lKf31CtmYRAzQyTh11VcOtmaQnTZAOXTrNI5e96EBFNbMJu5eb6wOxFSZ36gRGyzHijRtsUjMcjHqdIsDOabmeQ2hl2lT48ftiuddBHEVzSBQyLQr79rjCraxQ0zcKAkiL9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wqaEBlPqpDH5oW0rIG9NY80qBAQADscGka3FsNiGfc=;
 b=FuR+yvUM8K/h8dSD+MFjz8v0wa5sTo+Z4Z9rKPtMUoAs6uyR3ORoNkQ9UM5x9S+qFOks+eKS6vmB6dhrQOgePvquGkaryzEp9WHhevIQIwR9evDukpZgyWtKfltieuJSzqnZoc9LcEb/fmvfmBjNZ/odgpWYs3cws49id1nduNI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 14:12:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 14:12:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for 6.1
Thread-Topic: [GIT PULL] NFSD changes for 6.1
Thread-Index: AQHY1zIxpsdwgqZ4MUKDr+1D+RfM9g==
Date:   Mon, 3 Oct 2022 14:12:38 +0000
Message-ID: <1677F534-541E-480D-8C4B-7BF6126358B0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4582:EE_
x-ms-office365-filtering-correlation-id: 91f69c05-1d48-4f80-5915-08daa54953de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfdtohQdYcFBO6nmbkBHedNgXJ/Nyk6t/vmh4TNV6gy2cNmMFxVfhPEjB7Z4ovzRwqkHia4Q3IiuCV+HfjkfKJPPCyjIM36MnGsLoN4w6e1bhenNlwpd/SJlH9jQLd/76BDkBM91iBSwfTesbFEXb1zeQ8WP8Z27N5EV0Pmj8NnA2/3q6ZOt93WFEiQX2dL65phU4IY26v8Hj2Yf5/D757KtRl2jJTni8eCtpt/tgvcHZCk1mjdqDNZDdt/tYG3tQAjP+AYBlkLP68pFXSHd7/V//neb/OfHBaAzMaz9iYFRUa2E0ujpap24tB8Txklh3SpJmsuMzM5dVkMSL+oHqBE65LcYvzFcOWZ7wHmgKcbHUwfeB8s0CZnjxtT3ZQ56iha20DnQ+g5v2UPUQ7GZUlz+MJqntXGrShUV+QfLjxHIfDKbZKArpS49AS3PPTj5cDd2+Fl9TggJ3n75vSqd53kPaz5ck1eNTYfXraQBRgArk0ysAe5l0+baWxfH4bZO35BBP25R+D9Wjjl4U13mcTG4cWJvcma62Y+z7f1PR35J441AZ+L1HenhJjOAfgRsL2TJoJm4Ka4VDSUfiu6Zgmjy7e51/VoYZ3US5hRRPcerikp76CRHbdusSkBHxsXAVyEP85UwlXOis6Jj322JqDzvFUCZ5W3dj12cQSY75RpuylFa+LAsev+Ibsgy/E5u3vPTIeONTuk0vp4MXrJSKJyKwOPMmNMS0nsT6Vpr5sfeBmM8V8GCHlIryUP835HakmjRo6QNQH0RQJGK+YMmY4U8gBcRmU4Upjlnf1WkC9M4Mssd/gpyBcmIAvTru1++9yq0jm9ZOVhuQIpil/1MyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(71200400001)(6486002)(478600001)(36756003)(316002)(2616005)(91956017)(33656002)(186003)(8936002)(38070700005)(122000001)(2906002)(5660300002)(64756008)(66946007)(4326008)(8676002)(76116006)(66446008)(66476007)(66556008)(6512007)(6506007)(6916009)(54906003)(26005)(966005)(38100700002)(86362001)(83380400001)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pyB7QvSNxW8h0deRVzq+JzR1jHB19w+l3hMzHPQJqnG79NEtbJyTZSZrZxjp?=
 =?us-ascii?Q?LznCaN4JKOXqmyiBC+Iod6jT1duHKuu5nAsQ9R7REvm44JCuUqy+vxXmdHpN?=
 =?us-ascii?Q?EzFdd9LmOMLXKfjbP7MWqnMehYmu3BLfFrc0KQd3znZf50pnfAcVqy6yAh1f?=
 =?us-ascii?Q?ybGnGjfZaXkWmjxcp6+xnYz9BomahvBQTuQ+v/N9/YtS9v1QykEPStGipo4G?=
 =?us-ascii?Q?RxtHzuVGX+hzq11GQ/euynoVrDqFkjxr8jczred994/isbhg49bFAS79N2b+?=
 =?us-ascii?Q?Qns6I+Aq+8lldSsvlvAC2fWls68mmITA7TNzY72bsTncXJGrI7F6p9taGC93?=
 =?us-ascii?Q?tXN52wvks+lBSPdVoWw6qmRfk2wpPQsN50ne1Fi0R5tidioTyeHEwy1kaD/9?=
 =?us-ascii?Q?ufwlsuPNdzu69qgA/joSxaAi3lqxzdCcZKnAbs2FCEMgCYuJA1qYCUmIu4Hj?=
 =?us-ascii?Q?lVfnY9AYGcndKge5ODhG0lF5NgK2iyj2IFXPO4XLegUeiEdHW9uXmR6gAexO?=
 =?us-ascii?Q?sVisJPLNfEieG5eWZg4ZImkrkNrIt5h5Fd8zzKH0WigLXAurDNxbBSivpe67?=
 =?us-ascii?Q?+o/oPrXEJLtfk5YNnswSX9/wf/AItj1kHWwa1ahIRnBKdPDCo7FWl8CQo3a+?=
 =?us-ascii?Q?gXdJ+xV26bvxLcpV9KQ5klLDh19YlJP8uoVvYFPR9J2nLwfdd4UNuhKnD8RX?=
 =?us-ascii?Q?Aeehxe5/JaG1mmiqt/gdUvxpukNwDEJSmZ9f721FzrSSF1BraZKI6Q2AYGq8?=
 =?us-ascii?Q?T4GgiYe3NNWfssL30RVMRhTBuIgOq6iTjou9Xh/ic7j8d1ow4ohFtzyPz5Xz?=
 =?us-ascii?Q?ydr+YcH9myg15Iwfd7FVM6UrYQENxP4/WOU2YeX+iWLM2JaP+ZeZuNk8lx3R?=
 =?us-ascii?Q?XQT7CCcaxQqgislQgy6aW2dIqv6j9RZ0VCUeW+J1VpG1ZwlDcS9yAwZHmQwl?=
 =?us-ascii?Q?BpS164E2kJx92KtWqZkjn455pH5wkkmDQ75SnoFKC1TOCrIpTAubKHlvVgQJ?=
 =?us-ascii?Q?bNS0/3wSruEohlj3IHqoklvdhSt5psyLzE4hjo1U+S1Wsy3ZBy3MRe6E8Spb?=
 =?us-ascii?Q?UYTyGJ+m4vLgXetYiddFrQXriCJhCz1+2EgPYZWfaObUZOqpzYW0uVZnT3nC?=
 =?us-ascii?Q?MN0+fFZxPhh3P4J2dh+nQNLsugGGyNIwYiuIJyaW4B3OYoZt5AJEUDWbRWUa?=
 =?us-ascii?Q?DLSV7jCs/FJk3GIwVMSWehAc6vNH88K7s1sZsjvQ/4xCSFshVxTsBDQHjIBf?=
 =?us-ascii?Q?dWQzJrFFogGiDy76SOdRCx9MOVX4GPHFgz7Iq8zd5XATpp7Hl/Y1VoToYn8Q?=
 =?us-ascii?Q?P3vw8S5J0PszA439c+exU+HQtvFjw+zrPMO6k5zXZhgNg8Ad3eVgf43nnJQK?=
 =?us-ascii?Q?l+g3eqQxtE6Bj2UG2s+nF0MvcsjlG7NpaCOVeg/udneHoXTpa9Hq+Jw48LBo?=
 =?us-ascii?Q?Ojv3b0tBQMTKJWqGg4n2QqYYOOmvfub7Dbru4Z4wrCaPg1vSX2OkebshUaYS?=
 =?us-ascii?Q?n1yylETzSYpT/+UyBQVPBn8CN8JvrdIneBhC0XzEoYNmpxEmt9NQTr19rMYX?=
 =?us-ascii?Q?kgIO16wSEuGycCjqvmRiybmRP0hMFjUXGA1B8wBFbOIYK25O7vVYY7SZTb8P?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A26D67EF0312214A92C472BD0B229F04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f69c05-1d48-4f80-5915-08daa54953de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 14:12:38.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCsulrPLC3wldJ1F1ZEba0xaSjczFEYVuS8sEefz+S2ryuP1NiOBoPT1vK5xmPNf2E5lCyVNy6SRhU7wNQGW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210030085
X-Proofpoint-GUID: 8dtZo-dhXEBpQqtOOwO7TQEi7Z216AB8
X-Proofpoint-ORIG-GUID: 8dtZo-dhXEBpQqtOOwO7TQEi7Z216AB8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

We are still working on an infrequent UAF that happens during
an NFSv4 DELEGRETURN request, as documented here:

  https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394

This appears to have been an issue for the past several
releases (maybe since v5.14 or v5.15?). I expect Jeff and I
will have this addressed in the next couple of weeks.

However, the other v6.1 changes for NFSD are ready for you now.


---- Pull request follows ----

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6=
:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.1

for you to fetch changes up to 895ddf5ed4c54ea9e3533606d7a8b4e4f27f95ef:

  nfsd: extra checks when freeing delegation stateids (2022-09-26 14:50:58 =
-0400)

----------------------------------------------------------------
NFSD 6.1 Release Notes

This release is mostly bug fixes, clean-ups, and optimizations.

One notable set of fixes addresses a subtle buffer overflow issue
that occurs if a small RPC Call message arrives in an oversized
RPC record. This is only possible on a framed RPC transport such
as TCP.

Because NFSD shares the receive and send buffers in one set of
pages, an oversized RPC record steals pages from the send buffer
that will be used to construct the RPC Reply message. NFSD must
not assume that a full-sized buffer is always available to it;
otherwise, it will walk off the end of the send buffer while
constructing its reply.

In this release, we also introduce the ability for the server to
wait a moment for clients to return delegations before it responds
with NFS4ERR_DELAY. This saves a retransmit and a network round-
trip when a delegation recall is needed. This work will be built
upon in future releases.

The NFS server adds another shrinker to its collection. Because
courtesy clients can linger for quite some time, they might be
freeable when the server host comes under memory pressure. A new
shrinker has been added that releases courtesy client resources
during low memory scenarios.

Lastly, of note: the maximum number of operations per NFSv4
COMPOUND that NFSD can handle is increased from 16 to 50. There
are NFSv4 client implementations that need more than 16 to
successfully perform a mount operation that uses a pathname
with many components.

----------------------------------------------------------------
Anna Schumaker (1):
      NFSD: Return nfserr_serverfault if splice_ok but buf->pages have data

ChenXiaoSong (5):
      nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE to define nfsd_proc_ops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define export_features_fops and su=
pported_enctypes_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define client_info_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_reply_cache_stats_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_file_cache_stats_fops

Christophe JAILLET (3):
      nfsd: Fix a memory leak in an error handling path
      nfsd: Avoid some useless tests
      nfsd: Propagate some error code returned by memdup_user()

Chuck Lever (30):
      NFSD: Increase NFSD_MAX_OPS_PER_COMPOUND
      SUNRPC: Fix svcxdr_init_decode's end-of-buffer calculation
      SUNRPC: Fix svcxdr_init_encode's buflen calculation
      NFSD: Protect against send buffer overflow in NFSv2 READDIR
      NFSD: Protect against send buffer overflow in NFSv3 READDIR
      NFSD: Protect against send buffer overflow in NFSv2 READ
      NFSD: Protect against send buffer overflow in NFSv3 READ
      NFSD: Fix handling of oversized NFSv4 COMPOUND requests
      NFSD: Replace dprintk() call site in fh_verify()
      NFSD: Trace NFSv4 COMPOUND tags
      NFSD: Add tracepoints to report NFSv4 callback completions
      NFSD: Add a mechanism to wait for a DELEGRETURN
      NFSD: Refactor nfsd_setattr()
      NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_remove() wait before returning NFS4ERR_DELAY
      SUNRPC: Optimize svc_process()
      SUNRPC: Parametrize how much of argsize should be zeroed
      NFSD: Reduce amount of struct nfsd4_compoundargs that needs clearing
      SUNRPC: Clarify comment that documents svc_max_payload()
      NFSD: Refactor common code out of dirlist helpers
      NFSD: Use xdr_inline_decode() to decode NFSv3 symlinks
      NFSD: Clean up WRITE arg decoders
      SUNRPC: Fix typo in xdr_buf_subsegment's kdoc comment
      NFSD: Clean up nfs4svc_encode_compoundres()
      NFSD: Remove "inline" directives on op_rsize_bop helpers
      NFSD: Remove unused nfsd4_compoundargs::cachetype field
      NFSD: Pack struct nfsd4_compoundres
      NFSD: Rename the fields in copy_stateid_t
      NFSD: Cap rsize_bop result based on send buffer size

Dai Ngo (3):
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition
      NFSD: fix use-after-free on source server when doing inter-server cop=
y

Gaosheng Cui (1):
      nfsd: remove nfsd4_prepare_cb_recall() declaration

Jeff Layton (5):
      nfsd: clean up mounted_on_fileid handling
      nfsd: only fill out return pointer on success in nfsd4_lookup_stateid
      nfsd: fix comments about spinlock handling with delegations
      nfsd: make nfsd4_run_cb a bool return function
      nfsd: extra checks when freeing delegation stateids

Jinpeng Cui (1):
      NFSD: remove redundant variable status

NeilBrown (1):
      NFSD: drop fname and flen args from nfsd_create_locked()

Olga Kornievskaia (1):
      NFSD enforce filehandle check for source file in COPY

Wolfram Sang (2):
      NFSD: move from strlcpy with unused retval to strscpy
      lockd: move from strlcpy with unused retval to strscpy

 fs/lockd/host.c            |   2 +-
 fs/lockd/svc4proc.c        |  24 ++++++++++++
 fs/lockd/svcproc.c         |  24 ++++++++++++
 fs/nfs/callback_xdr.c      |   1 +
 fs/nfsd/cache.h            |   2 +-
 fs/nfsd/filecache.c        |   7 +---
 fs/nfsd/filecache.h        |   2 +-
 fs/nfsd/netns.h            |   4 ++
 fs/nfsd/nfs2acl.c          |   5 +++
 fs/nfsd/nfs3acl.c          |   3 ++
 fs/nfsd/nfs3proc.c         |  43 ++++++++++++++-------
 fs/nfsd/nfs3xdr.c          |  18 ++-------
 fs/nfsd/nfs4callback.c     |  14 ++++++-
 fs/nfsd/nfs4idmap.c        |   8 ++--
 fs/nfsd/nfs4layouts.c      |   2 +-
 fs/nfsd/nfs4proc.c         | 226 +++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++---------------------------------------------
 fs/nfsd/nfs4recover.c      |  14 ++++---
 fs/nfsd/nfs4state.c        | 218 +++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++----------------------
 fs/nfsd/nfs4xdr.c          | 102 ++++++++++++++++++++++++++++++++---------=
--------
 fs/nfsd/nfscache.c         |  13 ++-----
 fs/nfsd/nfsctl.c           |  54 +++++++-------------------
 fs/nfsd/nfsd.h             |  13 ++++++-
 fs/nfsd/nfsfh.c            |   8 +---
 fs/nfsd/nfsproc.c          |  39 +++++++++++--------
 fs/nfsd/nfssvc.c           |   2 +-
 fs/nfsd/nfsxdr.c           |   4 +-
 fs/nfsd/state.h            |  11 +++---
 fs/nfsd/stats.c            |  14 +------
 fs/nfsd/trace.h            | 131 +++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++-----
 fs/nfsd/vfs.c              | 128 ++++++++++++++++++++++++++++++++++++++++-=
---------------------
 fs/nfsd/vfs.h              |   4 +-
 fs/nfsd/xdr4.h             |   9 +++--
 include/linux/sunrpc/svc.h |  20 ++++++++--
 include/linux/sunrpc/xdr.h |   2 +
 net/sunrpc/svc.c           |  34 +++++++++--------
 net/sunrpc/xdr.c           |  24 +++++++++++-
 36 files changed, 829 insertions(+), 400 deletions(-)

--
Chuck Lever



