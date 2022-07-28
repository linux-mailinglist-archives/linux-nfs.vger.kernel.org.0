Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73D158423B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiG1OxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiG1OxD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:53:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC260507
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:53:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SD37S8015474;
        Thu, 28 Jul 2022 14:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZEvbbWe7xboCy15MYc1F9z5/VTWd31u75mIuiCR0bx4=;
 b=RYgpRT9G2lXEEg5BsCll/UuR1888ziN8qSCoM8U1nyMHLMrTlcsfSTuZs4dOT9TIk4/0
 DRnqy0+jbKr1O6MNfIeSvSv0nwzShj7VlXfFzfk2ntfig9xFJDkhOmpb2Dm9nj2cshkW
 4MskXLpXEoUQcEjXhzve2TbChqi9KTgeZCaJMnZWSZJTsVGbDqgs0HxbkyBsiIXKyDmu
 L2ltPfisIwy+oKbhAlqntvlHISADbzIR6AqJVm168gKbGmIlJ+1muTdPeHXuqKloCXAF
 pzxGUwJKDf6Zr44SMocnxQ9ilnenfOnxoJE1PqpYpUDsO+jqP4LiJwVqvr/jTK7duv8n Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hswa2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:52:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SEMRFL019980;
        Thu, 28 Jul 2022 14:52:50 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh63ap7fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ovxk6kRzqPmJXDM7bGBxEQO4q1vkD/QaBXovDrVkjCau+F6D2CWpyHw9+r/9hsacw8WX5HIf4b6Lk+f5cMQF1cpBy9xI29hdfQfOBSdJc+g/qJENV3s1KtFdx+gkugXpqlVjkNTAWil9hs0eWOH68pbMlRzcJQ6F277S9dkOX+P5wDQIwfaFwtsqxJz85uBqZ5fn6BVlHcKI4D5jqGcpUhwyssinLArsx60GMMKoZE+yQiqKWPf1Sc8ov6Q0+nvzAeCEFKVtqyeOQjqC9LRU05OCEtWayRMtBwjXwY4VCTFo+2jzG4t6sVTUYdx6ER5B3Hw1dMmh+2XqFsgmhF/ajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEvbbWe7xboCy15MYc1F9z5/VTWd31u75mIuiCR0bx4=;
 b=lyDxGWn5tqmB+CGLTlv07IjoYa3/vRh3Xz2QfRz7KmTIf4pC2vkO9T2dTtLAzNZ5kc9iLEKesrS6x+0oXA2Sh8L2Qavg8t7cz1ViCUpDBukyflicg+6l20u5iS10HRxjSjoqA3Dw+TStaT4DIJCv+mo6bWf5nqtRZXgeLlaOkdP+KEMDhEfqIoCO4epmOlXyWYGE8omoizLAy15IN9u6LRkwLLAOKzS3/A/uXZjxHFN/pvdmbjOuXTE3xzWkfM8Gooqhu4GYF3mLswZsIRjvtHFQPmi1cOK3iiRh8p2xLQcRi0xqQa6xcflC/QA/CbnuuebYFrH0vKcDMmNyvnW59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEvbbWe7xboCy15MYc1F9z5/VTWd31u75mIuiCR0bx4=;
 b=sOSFcPywC8dQRoxMNEqFiNq8+QY5dhoNb6yp3h36JUK04atc7x8FKHzq7b+j1RVorYfejcRTTysQ88GoeM3t75KSUJ7OyEr+OOZhKOzPtF+UZ6VIMHyAJSNPA/08164bhSaS3gXpl8n+I14DBzIy2DgqrZPeLs6MXYQ0ltnl2Fc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3526.namprd10.prod.outlook.com (2603:10b6:a03:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 14:52:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:52:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] NFSD: clean up locking
Thread-Topic: [PATCH 00/13] NFSD: clean up locking
Thread-Index: AQHYoLt1dDclFfeLe0KoCxvHL7Kak62T4ewA
Date:   Thu, 28 Jul 2022 14:52:44 +0000
Message-ID: <44AD17F0-FC0B-4F20-BCED-071CD70DFBBC@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0338b99-94eb-4ec3-ea14-08da70a8d493
x-ms-traffictypediagnostic: BYAPR10MB3526:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dHjoyIn6Ftq+rX839IvK3hlscqoV7wDUj+VWo9s35iX0OJeBMVmF0tjO1sdcJgCZuJpMIRpOAysqsiJRQ0JzJmsc9e/HnQvC8Nl7wMZqQgvXAF9yfkKBPyhL4kM6rFuCD0vBtsqcpctViF6omzY+3OOd4TBcL8aH4Q2aC3SW2xPFfm6ALNuow3ov7fykRRxzxB868MK5U8zSwMVuOh2MaQFti/8oJzhhd/3oyMmOwk78538AtzO8+TA2mvgcwUM87d0Eic3B4FplacjvsFVdyCOyBMO5CRz9zTsQPqQpahpNCwgz5NWXnfMgnmqcjZ0jEFZ+aIBnt/2L3TVvbjgl0CW2030qKBw3NJV2vp+BEIu5IBq+v+75w3gPSEXCTTHl0LuWsHa+vSYmDQ79Nz1Hc/P5UWfdaOC40tqJHpIPGKcWS79VH38z/qffqMbW7iXj2lMxdR2qznP6X0elJdKGwrN8dkEMXaawCQoY2dXCHwTucz5KZDjsWTkXUfAZR3h3C3WPbvmMAQsi9M//EiBkwIFYEMP193NOl/xIwQNa/hdfJsLUGkwmMzUXh5AflCHAfeA/MzrP0zjwx54oOSnMzQ35eNdHHBS6LQvkun7xacgJ0o381b1+EMlswFbGr0xCQjR75oj9fFswl9naZmfjgo4TyrQa1m8DxNLDNowGfK5PxGu3BPtEtX56xy2VSL5qruHvNjXSo29cgStB22FxIq+aFEBy5MvVg2AkH+HC4WtdzZg2WiL90giEcmi0r1b53+cfhhZ5NCuEnoNrbMc7mzEtDThcAQW+/gWybg3lmQ5IHBoJzWsAyI79/GB6436nDVtiCZ2JXzSlO6kAFyoqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(39860400002)(136003)(376002)(26005)(122000001)(38100700002)(478600001)(86362001)(38070700005)(33656002)(8936002)(71200400001)(6486002)(5660300002)(4326008)(54906003)(66476007)(6916009)(66946007)(91956017)(64756008)(6506007)(316002)(2616005)(76116006)(41300700001)(83380400001)(186003)(6512007)(53546011)(2906002)(66556008)(66446008)(8676002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vsXelPHdNTyKRll6XLjU/68sWtCo+0TdRupPLd12zuW1+Q5qIy7PgrlRf2r?=
 =?us-ascii?Q?zvHFU5tXad76sPrD8LlhvCdYcoF5XI64BjMN4E3faDQcaPpl2eIkpeHnOaJ+?=
 =?us-ascii?Q?JjDW1gqZdRHf4z6YGx3s669V0rCDWcNmbLFltsJ+rhgx18DOD+lXuImS2myM?=
 =?us-ascii?Q?tFoXeMaJ7V/tEuR4kdZRbFd/LjrasWV1Vfb7wzJ/v9Z5x91poGBgS8VE290a?=
 =?us-ascii?Q?ajJ/gnTrXR60ezm/KjEsd+TqYa4x0WP4jVJT4QhhmrlwkHCcCMjhMP6U1j/1?=
 =?us-ascii?Q?FqwgQXjxWDj10LNi1Sno1GNrSYAhl2uCiepkDVmsfVz/+IuVH1JwQC4HBWM6?=
 =?us-ascii?Q?hbSUJ0CKoKlMgzfz23S4V7NFPVAArnFpBi7X6kU0dAP18AbF+1/N9E3SiQ5q?=
 =?us-ascii?Q?GiTk2XLVJCtLKIjT5eQINZUFkptwBo9u/ZF2XfQZ1xVr/PTm853XMEU/PZvW?=
 =?us-ascii?Q?V0qIuCi8nbQeaomwLqbAF0RMWvPrLXYgI/wgzlW/umjckyVvn5Fngtq0LwGo?=
 =?us-ascii?Q?fDOyOoMTACC/AQWT7p7YbZ6hNwV6t2miAiKWhmTm++iOnBL2OJ4GymYhv8j9?=
 =?us-ascii?Q?AgjIt5oexuQCB3gtEBnLPfO959FmrRvICftPWRS5nqtaoeDiAs9MbZqyrotg?=
 =?us-ascii?Q?Xl3DFGSIw36f4NMly0nThbTjAqUljBi1UhSD9DSbnuIesYBpuomvDbg5ThjN?=
 =?us-ascii?Q?CqKsvql/sE42YB3L/7Hed2X4GZPxKNPfSRZVJ0fEtRC4micMOEVoUTnavQl7?=
 =?us-ascii?Q?+Q0T02iMRXgBeWiANqfzLpDM4qHCobDw5JsBE4HEpBPnAQzjVS+Zl42UzouR?=
 =?us-ascii?Q?vgmaPhoQ4AZPdAES6OlbdCTm+i9Jco61sbDxmFpDK6wyRUxn0D+TS8CftgUv?=
 =?us-ascii?Q?9zu5r/AuRWw2VvnOEJT+w5Kokh8yF7O/xfa8bihytupQsImJfCrXU0+ILkq6?=
 =?us-ascii?Q?3LQPrrdfA+agfwW6A7lXXEBIuDSlTFTQvvHzvEYipt4v0gA0LNAVTBqRSkeb?=
 =?us-ascii?Q?oeiGEMHORBHaVHsaDNtavktJHH72OFmJ+nl7GQKzgymSQeslWGM/u51Ikr4a?=
 =?us-ascii?Q?Dz0OcAPJJdB/9GyAbxJoANri3zhRHVaA4Z8zyuOhQkV5/iNAD2VwxGbJOcXD?=
 =?us-ascii?Q?pWB/JDS9WkeTULW5QQBlgq2S3J2bN9ngiyyjHeJ9LMW3GAEjRq6fu+uH897z?=
 =?us-ascii?Q?o6lie4RdBgGdIceBPx8B9hymH0J/aoF8pLXTH3Nkxy3Isaw9fXC6k/KwxAE+?=
 =?us-ascii?Q?uu1co3fqD6VRviU4IH+dFh1mdGfB7k+HuSamBgosOC2807Ij9x2NKwQZ9I94?=
 =?us-ascii?Q?C66iPRRZgxkSGD71zIkjp1FPj2fkaic3GDFCxIHDsm+KRF5uaScw5xGyZngS?=
 =?us-ascii?Q?JQDUoUkL0UpBVVqi8Wdbv6LzrAv6CtnqTZiSVPWyuiNvGcgAtJ37l2W2mLZG?=
 =?us-ascii?Q?9gREL12SxOSQskNKh9cUSdOU3ajfyghPddF8v3zs0OzihnsgMwg9GBX+qmok?=
 =?us-ascii?Q?vh72p5NEv8dOSPQFUQ/FYtaPVzkRux9U77fDbd4WJEVRB+DEpRMw0iL5j62d?=
 =?us-ascii?Q?ITQ17lbQDFD+UFoY7aHQ6PHJGzHYqNA2iB93ub0Pa8Vu0+TPfYiW+LT/BqJy?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19FC05C7DCFE884E9275881111A6C111@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0338b99-94eb-4ec3-ea14-08da70a8d493
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:52:44.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZsApXS5RqJDqy+TheRKbz3I0fCKj3IqZuP2pRcT0Lw8MYryWFmXdY1kAmoFUGQTNJUsXRsAsvStEY2CW0wb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280067
X-Proofpoint-ORIG-GUID: A3QsvmNj-AB1kIAqvoS95C3f8MGkaFCQ
X-Proofpoint-GUID: A3QsvmNj-AB1kIAqvoS95C3f8MGkaFCQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> This is the latest version of my series to clean up locking -
> particularly of directories - in preparation for proposed patches which
> change how directory locking works across the VFS.
>=20
> I've included Jeff's patches to validate the dentry after getting a
> delegation.  The second patch has been changed quite a bit to use
> nfsd_lookup_dentry(). I've left Jeff's From: line in place - let me know
> if you'd rather I change it.
>=20
> Setting of ACLs and security labels has been moved from nfs4 code to
> nfsd_setattr() which allows quite a lot of code cleanup.
>=20
> I think I've addressed all the concerns that have been raised, though
> maybe not in the way that was suggested.
>=20
> I've tested this with cthon tests over v2, v3, v4.0, v4.1, and xfstests
> on v3 and v4.1, and pynfs 4.0, 4.1.  No problems appeared.
>=20
> Thanks,
> NeilBrown

Hi Neil-

No objections to this round, looks like a very good set of clean-ups.

I've also resurrected NFSv2 on my test systems, and captured a baseline
without these patches applied.

There are a number of cosmetic issues I found, posting those separately.
If you trust me, I can take care of those here, or you can submit a
v3 (v4?).


> ---
>=20
> Jeff Layton (2):
>      NFSD: drop fh argument from alloc_init_deleg
>      NFSD: verify the opened dentry after setting a delegation
>=20
> NeilBrown (11):
>      NFSD: introduce struct nfsd_attrs
>      NFSD: set attributes when creating symlinks
>      NFSD: add security label to struct nfsd_attrs
>      NFSD: add posix ACLs to struct nfsd_attrs
>      NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before=
 returning.
>      NFSD: always drop directory lock in nfsd_unlink()
>      NFSD: only call fh_unlock() once in nfsd_link()
>      NFSD: reduce locking in nfsd_lookup()
>      NFSD: use explicit lock/unlock for directory ops
>      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
>      NFSD: discard fh_locked flag and fh_lock/fh_unlock
>=20
>=20
> fs/nfsd/acl.h       |   6 +-
> fs/nfsd/nfs2acl.c   |   6 +-
> fs/nfsd/nfs3acl.c   |   4 +-
> fs/nfsd/nfs3proc.c  |  25 ++---
> fs/nfsd/nfs4acl.c   |  46 ++-------
> fs/nfsd/nfs4proc.c  | 153 ++++++++++++-----------------
> fs/nfsd/nfs4state.c |  71 +++++++++++---
> fs/nfsd/nfsfh.c     |  22 ++++-
> fs/nfsd/nfsfh.h     |  58 +----------
> fs/nfsd/nfsproc.c   |  19 ++--
> fs/nfsd/vfs.c       | 230 +++++++++++++++++++++-----------------------
> fs/nfsd/vfs.h       |  31 ++++--
> fs/nfsd/xdr4.h      |   1 +
> 13 files changed, 314 insertions(+), 358 deletions(-)
>=20
> --
> Signature
>=20

--
Chuck Lever



