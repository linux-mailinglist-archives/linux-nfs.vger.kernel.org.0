Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65649650D20
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Dec 2022 15:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLSOUB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Dec 2022 09:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLSOT7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Dec 2022 09:19:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F255DFB4;
        Mon, 19 Dec 2022 06:19:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJDxKUJ028874;
        Mon, 19 Dec 2022 14:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Hu0G/H3wOa4+ktnEkx/iTQle2NR6SzyXo7OHROE4D9g=;
 b=p93aMT0ZHfVaGHRuKV/VKznUJC2k4gctPn/BFs4lHAUD0LP/MA3/4zILoij3fZlp2pm0
 dbrHfFG9ZciY4YUbd5wjh26ULDkrg4h2ADkakyWCeRf7ydPv9om7QEDGYmiZtaWEJYfc
 yIspNXg53sTHDrr+aq774V+SGhP8diIn85Cmj/PQl2fZIyJxjsmzlP/cQ4E7+Prxbdlh
 GZFUzFEATGDBK4+zM0kJghnbLHarsK5lRedEEZ74JL9l6qCtA7hDGj06ydqbHTYCQmJr
 oB/ridITOs6/Bo9JJHJ9Y+0oEKCOrPoqTh6L45AXz45kMR+sck3qaAvJqXMoOUVKt1Kf ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tqtxh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 14:19:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BJEICDG012691;
        Mon, 19 Dec 2022 14:19:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh473k0wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 14:19:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZFnLCP+nQNQLG+WgMdbZ0SJq3brwP3wEqoIWwN8a87pEvygB1TNXldUqs44EBAmO8fHoZRHMtuwVIa6S08MeITsrWpwqZM2f5MoVgBfQQVQEoIBUCKcSS8iKuAhU5jDpXdkSB8SYKFrq8JjbWrBVT7wVE7aYdca6GokaMK4ZTgGpIy/h+OVQlBb4cqx6jVUvnySmGCnYqYLb4B9XM9arTqYB4PW46QPHY7AO3afqrZVWWpTuArCPzk/0+f9hPhSu4Fi6v5F0bpuSPFda1GZyW1+eL9fqh5S+U+c1ybfCJpFSTr71wxsuH1aXcAG+fP9o9nl1ODxH2NuE0auKixO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu0G/H3wOa4+ktnEkx/iTQle2NR6SzyXo7OHROE4D9g=;
 b=duKohqDIssmEqyo4EHnOMgwZaUCuGz4g1EgvqkZgaDhLY0CTmin0jA8/AuPgCe1Y1RFz1qCntObocxpdj/mUK7B2WU1i75wwnJHT0/OBII5/HYIUpngRBwicHfXNDOA3NGWuZTYGLWSbopCDW58ZD3qg5J6JBdoKkRfFdnyGC1+dLi55aVCxZ9TWzpywHFCT2XNop1OrXoMah9OMp0jKpff+ld4ENx4dLsm45cvB3zlo1ETu89ATfLd4m8ggwyifhIfKevVRm97YqIX3aL1qBD8sWzwviiLlaOLNB6wXybf9NYftkkAUVyAUWMRUxh8EMoYjgxG++oUFywAPdz7ZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu0G/H3wOa4+ktnEkx/iTQle2NR6SzyXo7OHROE4D9g=;
 b=WFo5+NzNOXjHmygsPvfoUqshhOKOsOo1OcbxWeUQR30MYzGRgTqMQzKPkytGz0a3CXDkaK+NqA28xsNo2xAe4v6a3JmeE37aHcVxYSXk3Jyr/PjzAtsxtAoVj+e9SVbU7P/JeFZn55l6vW7YSReiUbP8o41dPDpwGVxHfDJglYg=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 14:19:52 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 14:19:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] 2nd v6.2 PR for nfsd
Thread-Topic: [GIT PULL] 2nd v6.2 PR for nfsd
Thread-Index: AQHZE7T1deE3iCH3T027oSp1xpLwjg==
Date:   Mon, 19 Dec 2022 14:19:51 +0000
Message-ID: <B9418BA0-EBAC-4CE4-AA12-206083581C42@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4527:EE_
x-ms-office365-filtering-correlation-id: 206b993a-3133-4336-6c56-08dae1cc181a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCSoTNa44tMvLy623PZLa4cFmO8C4i1wsh3rMRvMo7SGpIn5Nqn4Rk4VTfhGfb0mPaxqg6soOaLF4g/ncSkM/zI1m9NLZOFWAZLqPY4L2gcVAi2VPgJPlq81suWcbrlPqmLag84Z2HU4ri3nR9pAlUicd74kufUGrRxVvyjeSbQdIbuLkT+KqwPORVWSTNi34TURckD+dxBvFfCzRHcs89YyAwGwJQ1rOPsq3TMNPPwawpPKJGWNrkg9mo3APieA7u0TM1yAjx2BGxhn2SuwkjIq6DmDj2pstQoXWOkXGA3z+4GYuVOo7sVPLa9QqS/5QasSg/0j/EW83sNZFR34WvBh1iYXnVkG+iy1RP4QAa8YqeY1MscQEZOZJhWv58FVmTWmyRb9VG2AvJWMvUQI/aJsU+5py4UDOEdSoz0cpDHGls8OxGWVIIhLsf3Fcf8k6DwgTKDuuz9Ias0QzNPZZSf+K9EMfTkNfVvPAyQtmU/ZI1WILHPDqouMWWX0B0lleyyZuvvbG3iY2PcNIjixUzUtnO3huDfLfXPq3ifHg21MZoOr0Dlik+SjMLl+En+XOg6VcAHnluB8OdzBUQnKodIetQ0Twc6MmC1dzIOW8rMN9bDso7SpT0uXTj7IW8SwcVYPPJohIahB2xXpEVYnRerA73XooeaTD+UfcBK8FI0KXaXKlJ9h8O24MKqF6yMxeHPfEbPXtp+Jri/nsleNIMI6SiCkeaHuvRaRk5GIt/jQ8cWI7BeOKbcxgoTkfl/7EZ7Pw8uHE8GnkxI/tRA7wxLG0JNfVuNS4+/VCW/XBot7ZXm6xW7oVYiU1uxZ+33S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(6916009)(54906003)(36756003)(4001150100001)(2906002)(38070700005)(316002)(6486002)(83380400001)(478600001)(6506007)(86362001)(2616005)(6512007)(33656002)(71200400001)(186003)(966005)(26005)(8936002)(122000001)(38100700002)(41300700001)(76116006)(4326008)(5660300002)(66946007)(64756008)(66476007)(91956017)(66446008)(66556008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5+1RPaw5ffwUbbY/swLWpqJlGqeN3VzszRVh2deKdqh5O3xhb9UDAfYSnyN2?=
 =?us-ascii?Q?oGox/A4YfG7P/gRYDTaLrGCHV5X/Qj8yFqpwYB+WbZalcJWyy0tzUGeCaiZR?=
 =?us-ascii?Q?hz+c9sTjaBO1oahQ4xCxM5ZuhTZXt7ELfDwYv7U31kEI09i+7fFcthW2zRbR?=
 =?us-ascii?Q?09TsFHeqbYHVBHofK2DyFdIRS2BITTVsciRu53wCSQJ64Lf29IMsbQBAM2U2?=
 =?us-ascii?Q?ipGzDr3Ly42VwzOMMshqjl0WMZ08pbBeLogU2MUHocZZI50Fnk1wBLmmZ0eO?=
 =?us-ascii?Q?XU1Sslecu80/V5yrHNBXpuOJyGarV8l8Ir1Hc+NkxPD7NitsINH8uJo44/yJ?=
 =?us-ascii?Q?3XwgyHa5hKZssa5YQf4uHuVtg4WDYbeQoQV5cGFS3rFbaiyW82NLMqy0RfzR?=
 =?us-ascii?Q?3eYNeBdrMxFCaWuTEQiK/pDiJmSBvsDEHk2TddPnNWgI7p9IGEszEOnqewc/?=
 =?us-ascii?Q?jKVpPwm+PvPz01ZpXumhzK8FAawB+2egB/h99M/0Zz07FEXz4ArlBsTLzJJD?=
 =?us-ascii?Q?o9CBeBQ4IfDMZCucaBZq4SUZYBlSCZgr2Ot8QUTp6IvyR+pL20MvS+XjXQcM?=
 =?us-ascii?Q?GUja1iKM6uIErfYNUZ93I6Dkn6yAgTrJ1+Sxv6eNWjKVPEwi8WDUv/55Z0S2?=
 =?us-ascii?Q?1DPICZ+OR8RolH1j3BN4WwwQBAViozcViAbE1BxQsFkvoysj4TI69rIOrZ67?=
 =?us-ascii?Q?NUny06t+lBnuPPevmrIvbEtSVlZFpWM95pLRfuIR8cAfloIuIuQKf9wUJGDb?=
 =?us-ascii?Q?v9CafpzU1Pn4fiMgg3vvuUXLcpdoTRTvjv6YndkKFV3sKG2fcziJLJvREjOM?=
 =?us-ascii?Q?4+Vo11Zkl3QwZJHXkIF8GxXCPyEeEXroUuLxhd0P9JREFYjjd3xY3TWmYwEL?=
 =?us-ascii?Q?T5h84TPF64fZ11ldrALuKsW3WNSGQl0robJ/X2KT8crw55YVmAuHuWeO+evr?=
 =?us-ascii?Q?W2fJGtv7DyFgIj3xEpV2Lnj++xDLPmnwUAQXMs9WV4HvmjSOveuf7gwhw3WK?=
 =?us-ascii?Q?4CtT7hkUy5b5IXtzTEz7PpLkfAijjVfFFllflq0iuTmN1vFAdXMzBfhWn284?=
 =?us-ascii?Q?Hfvxbqyo/8Lu3U0I1hHYV+LmcstoCq4UhMz39rvZqmla/OFhO6VlVqsZveNK?=
 =?us-ascii?Q?vV/VaRl6kEFdh1QZWuEW5/2Birc/BeDkk360bwj9JtgKLCegEoxCY50foflb?=
 =?us-ascii?Q?+NXbOFnTeoVq+QzDrAb9EPV6Xd/fBJnJLB2WK3tqV5yaImgoChgQpVRZKu5s?=
 =?us-ascii?Q?aBc4p/qL6rFGQU1tMN91Q5k+KoXaNwCHQQOh2g5crOlqPhF3Z1yb3T/5DyVI?=
 =?us-ascii?Q?EAyacuBLj7Z3io2/ypVC+wXYUUP4aChjvPozKou4OYJQNn+aq5dA60Dn9ptt?=
 =?us-ascii?Q?QpbR+5oMIIf3c3Wrl8RtlZSDAiUdiC497y7kGdDEd4y/thZ+2SuFMn/Ggynx?=
 =?us-ascii?Q?JnJNAjSdgOVanbwoPAef/VJ56LJBigKehXyg00CjJFR3VEIn089TVk+wR4Fj?=
 =?us-ascii?Q?FV/JmN4drVO12PLphQ35yR29GwIl5Y3RxVtXXmYnhjBYzGY4nU/3p1BXUtHr?=
 =?us-ascii?Q?/uvkU4pab4mo45JIqx0zG4GYZD53ESE/ytG2Lg4YbLniIZI1EnLzZnNX7pd8?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD0334CCEBB7294190D5E262CB25B2B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206b993a-3133-4336-6c56-08dae1cc181a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 14:19:51.9840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMZM1wz1j47NkHxtqrK5y/R5dqh79WpMeJGRjl0nKs2A8VTuTMl4QTzqyCP4DbfnWfwRKBuBcrQeiWeBSoBJpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190127
X-Proofpoint-GUID: 1NTItqTY70ZujdpkaQasEynDmXOV47p4
X-Proofpoint-ORIG-GUID: 1NTItqTY70ZujdpkaQasEynDmXOV47p4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Linus-

This pull request contains a number of crasher fixes that were not ready
for the initial pull request last week.

In particular, Jeff's patch attempts to address reference count underflows
in NFSD's filecache, which have been very difficult to track down because
there is no reliable reproducer.

Common failure modes:
- https://bugzilla.kernel.org/show_bug.cgi?id=3D216691#c11
- https://bugzilla.kernel.org/show_bug.cgi?id=3D216674#c6
- https://bugzilla.redhat.com/show_bug.cgi?id=3D2138605

The race windows were found by inspection and the clean-ups appear sensible
and pass regression testing, so we include them here in the hope that they
address the problem. However we remain vigilant because we don't have 100%
certainty yet that the problem is fully addressed.


--- Pull request follows ---

The following changes since commit e78e274eb22d966258a3845acc71d3c5b8ee2ea8=
:

  NFSD: Avoid clashing function prototypes (2022-12-10 11:01:13 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.2-1

for you to fetch changes up to 75333d48f92256a0dec91dbf07835e804fc411c0:

  NFSD: fix use-after-free in __nfs42_ssc_open() (2022-12-14 10:11:54 -0500=
)

----------------------------------------------------------------
nfsd-6.2 supplement:
- Address numerous reports of refcount underflows in NFSD's filecache
- Address a UAF in callback setup error handling
- Address a UAF during server-to-server copy

----------------------------------------------------------------
Dai Ngo (1):
      NFSD: fix use-after-free in __nfs42_ssc_open()

Dan Aloni (1):
      nfsd: under NFSv4.1, fix double svc_xprt_put on rpc_create failure

Jeff Layton (1):
      nfsd: rework refcounting in filecache

 fs/nfsd/filecache.c    | 328 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------=
---------------------------------------------------------------------------=
----------
 fs/nfsd/nfs4callback.c |   4 ++-
 fs/nfsd/nfs4proc.c     |  20 ++++---------
 fs/nfsd/trace.h        |  51 ++++++++++++--------------------
 4 files changed, 202 insertions(+), 201 deletions(-)

--
Chuck Lever



