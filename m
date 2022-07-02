Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B544E5641F4
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Jul 2022 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGBSBa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Jul 2022 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBSB3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Jul 2022 14:01:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26544DE8B;
        Sat,  2 Jul 2022 11:01:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 262DX9tc023099;
        Sat, 2 Jul 2022 18:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pAFcgSGvuZza3VqOJUM/v0yQIOu0q+CZaeQnTVh3RM4=;
 b=I9oYaSTqP9FhmzNJkfrXFEU98ZQTtXlL9wrRDbtmEYSrn4B9MgV+ZtRGqMDL1j7YRuQA
 VA4iUQladOZsnZylQb7P4CckbCw7XVtMJxazGYz1dl3dEw8euLctHsFb2GHe99rrwmym
 YnJun1zRO3XhTmbWkPKPgbXU3pvdhFd3ti5qtuigsSMvu+93XBsxA/p8IG9Xi7lytzp0
 iWU1Qhstq7Z/TubVWUeQpXa8FpcdQXHq8fc/3dlaIh2l3wm92VozC+20tlP0caPWx0yL
 e2cdNATbC9VUPPNZhD4dp6dPWvMkTyyel3d70xtnHFAvW+0LidItAjkXDSJTkpHMK7ds ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju0phg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Jul 2022 18:01:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 262I1FIx009208;
        Sat, 2 Jul 2022 18:01:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf6swe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Jul 2022 18:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPkNRC4d5B8f25UBgo6mZrEgc6/n2j2r36nRoo8OrpS67oLGzy2KuK6MiZ+Lc9vpY9bgifxAiD4wSJSe2WURqB2yWMmq5PYTd7oc+HapwM4HupffdH4sKEcjKsm6/Qw8ov20lcDYLIgobvtjTwKSnUcyTq+lje4gx16qJvIGKoyRnRorLQuAUKEWPH3kotfDftSH0JhNRYCjgCr+bGp3nqpg9gTgrI3nCt2+HzrG2LW+M1Jhjm73LikGJXlGtGJIaOoBn36QTk+nhE9lzkpDyxEqra0qpTv31xSaiN9h6kUFwHrwNLseJ4KztTg1gy6YuYdbEdGV6f+7jNWq8yEqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAFcgSGvuZza3VqOJUM/v0yQIOu0q+CZaeQnTVh3RM4=;
 b=GfXjAiofSzxGgfkUNf+ONY278uoZGtN+ZBKQicmHuvViSqfN6SYA874Mt14mWv1cs3dEBi9U+ELD2Wf1LAAXFNogwVmunWqKIdunL5HgpsoAqvrvjegN1N4fZfzPqi3B0/6BKzRj5/VNDgfN4wZqOrdWYGcI5Hl6SjjYLLj3zjTxZQSjRxXtayRukgWJ2FY+/R91fsfQ1mrmEVyaLLBWTcVVLsTpNO8piuNaAY3U7lSUQjsvHPDk2/fOxZf7XXyHdpdRuwEEVXD6x7+1nnG6pgPxZGj/NHVON/aY41IOCHF9IDTSOFc0NCZE4NGiwLBbVbMaggE3Q+d2H6p51Q76Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAFcgSGvuZza3VqOJUM/v0yQIOu0q+CZaeQnTVh3RM4=;
 b=hQWKUmMOQS/I28aYFmVI1REbHwgb0vORxaQyj2JNSwSa0RfWEyoGC7kSgLp6+h2cW3e7AJuvacoeC6H1MaMRI+ojFl681JwpfKpi5D2B9C4ymUJ42ki/0PTrAJTvEOf6NED+5JeJcESecNDUHA48O+eLCfrqvkcoLoQuk4TZSIY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1744.namprd10.prod.outlook.com (2603:10b6:301:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Sat, 2 Jul
 2022 18:01:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.018; Sat, 2 Jul 2022
 18:01:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] 2nd round of nfsd fixes for 5.19
Thread-Topic: [GIT PULL] 2nd round of nfsd fixes for 5.19
Thread-Index: AQHYjj20HBimTJue9kuWY6hmEWvtQQ==
Date:   Sat, 2 Jul 2022 18:01:07 +0000
Message-ID: <67B9A04C-2112-4A3F-911B-ED192D3B3E7E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9029aeee-7658-441d-0290-08da5c54d6ff
x-ms-traffictypediagnostic: MWHPR10MB1744:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qv9DEkVK43mgFILDA5Mz9H2mZwWM8G2BW+eDYCNRbrm5jXKRMvf+zupuMJjFtuBwABJ1c9bM6mYwSC45QyOgeMOtL9KLFwYMITmfv29rhLiPFJwSNa5unQ9YppTcsEayHYcW1n0/S1UlVcquGWZUq9AyiZ4jTNT6LQvqIRKCfroWig9zDNwNDKI+OoMfTpADHUsP46m4q0vkqRgPOIyiiGgF3fT3NqISy8JrvriGe80WT+EuIj+dnSrvZ2m7CgvLjfYosyHL0S/zQ9aQjELm5bymjXwDCoPMvP3Rfh5KyCS1rjx807lq2S9/J7AhThm+WUrQkpvqwwJc52algmsDRIkNoFY09nbqaCjufm7+LWFIzHQp4SSCgC5StnHwP2EpzZtkx7F14ctwurYC0t71b89wDrbCsfHSUa2glI0vaziFkouST9EDcmjpn6eC2WphqKc4F2sTdynEDMRemZKV8mNPxCPKYK6J0xY7jsWDLgGkPIGzNiT99GatKMpuT+gCvCxDl4W+WlT2mnQFqU7KLtbHqmK5PG4nQaEn/xGDQtLyxmsI2drlvT3fDK5/7iFgev8pUuNOg9Vr1OHUKZk8I1GSbf1zC49bE1d+50cx6sDrW98W/Y7mGOlRczwj3vx4aMPEgRoSDkwRPmF2+F2td1vb53ViKUprZEk7nH95EqvlXQxuU8xRJuL8bWUnlMTl/0s4CwtCeH/H48X3KuyO2PcKYB1lZumONWaJgGW1Jhz+tKu/HRx7Hq/UO7d2ushPfZLSi55WimBywfjdmF0aDTMCinQidBK6qpQHuLEKRuiqCP8toQSwdH12A5CiaviMRyzupBXvOhfZnS3DrW4iEsyIoLw98Pqchh3p3kT36cRz2LlgUlCVnQ/ZwTlMh9Bw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(39860400002)(346002)(396003)(66476007)(8676002)(4744005)(38070700005)(66946007)(5660300002)(66446008)(8936002)(64756008)(2616005)(4326008)(2906002)(36756003)(76116006)(66556008)(86362001)(478600001)(91956017)(6512007)(122000001)(38100700002)(26005)(186003)(6486002)(83380400001)(71200400001)(966005)(6916009)(54906003)(41300700001)(316002)(33656002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/u1LKO4UlvUyQJ+hZJwFO+0+knXKfT92LVHHFWlCPaS/83JDkFrd2lRxbfjW?=
 =?us-ascii?Q?o0C1jVJOsQMF1Af27zqxZcEbo+Q9Hfx9XBCzpPu2eCaK4GBlv4vg2QOa8Bhe?=
 =?us-ascii?Q?+OjEpm0Rn1oW/ag2p2psDU7TjBqz0jCI2yJdmSuWsm14WhSF1W05BfhCysE3?=
 =?us-ascii?Q?4ZfPbv4J2a6Nr3VQ23oc+WpCxE7M+reIb7PGd1gjz6e5/xhc95xmLCC/JO59?=
 =?us-ascii?Q?b/1WQH/X5NSanNn/TgqwLxiGUvZX6fLI+ROrry3xrkagqRHuxpMFiucNuJPl?=
 =?us-ascii?Q?2MUp02hnossvnYMgy5iTLzJRhHHiROJrm7kjG6o0VtecBueG5B1My/8ccWp/?=
 =?us-ascii?Q?IkYIGhRidZqbsPFhkg7pE8fdniuh64zEbfHHuDqbdKF+JSD0xV8hHtabgVVk?=
 =?us-ascii?Q?RY6+951mM84lnE3ObeP2rgGBCzBBQER71AbyrbyxzPs0fxTlqzkA2V9t8vvf?=
 =?us-ascii?Q?nEpQ+c4UPVkWMPDN/Za+kUuLqnVXqV208dqJ36m2qglL6l2Iizw4Lo2uJFi9?=
 =?us-ascii?Q?pSnFGlx1SQaPNmZOg8TA8+ZyUErvYpvprhzKblm2oAQMPX7hD8AbCzRrmtwf?=
 =?us-ascii?Q?pAM6nJDZyCvbmRgAl3oBFjapHRmqXZaiNyIJOqczvrEiWJER56Yzq4LRcb9p?=
 =?us-ascii?Q?CB7WP2brYIn4VQkTEyj2EgvwltdbrraiDMuJ7ZONelk4iZ3L7lyYv0SLa1qG?=
 =?us-ascii?Q?WWj8umsd5pD08XeKa0+Z4pWAyO4D8vPptq1u2o5nHYf69IHLuod0BqsfHbX8?=
 =?us-ascii?Q?mMWkWzN3xNQeFGTEE19V6Q2NJ+uVp2LXAaVEwRIL9uo5Bc2ezoe3ms6wASgx?=
 =?us-ascii?Q?7TQp4w7SwYOClVe9oxuA3ofZqu/o8VEcbF6tz00mJ5TPLgWScjd/WdNgcbkj?=
 =?us-ascii?Q?YiAfvt3+3LLrKge70KoZpOiN0/h7bnmQ0gm/DZq+++f3LSzh+Z/GaSisgCl/?=
 =?us-ascii?Q?6G1CC9UBBiyMPaGmtbNzf/T1044ExUb+qh5Kio3crNcC7Z9t833jYk6FSsku?=
 =?us-ascii?Q?hTgow4CQSinFMGjOTaWYo7eFgGAlfwCQTmdFT63EHfG5v/R9W7IxZ+/zK0CF?=
 =?us-ascii?Q?hhwLo/EV6wWkNQB7AiIEGenX4l+fRblcZWHS6GKoxwc00ePhOx4YveiDiTyD?=
 =?us-ascii?Q?qhXvCTUCyZhZULgcmyg7ZsPGjHRz9LfFuEBlgi5s3kLeIh5pFzimhIDcnNrC?=
 =?us-ascii?Q?GUVUBcJHXshD3j0NsXUv8ARhMTuyoo2oFyQR2/IG9bgeQBFq1rxGxFS6a9Iv?=
 =?us-ascii?Q?u6dDgHkXxhRYAneQ1wom+m8FT5/VqqyTxVXfbQfibFesRBUnO7BdZjn94NKM?=
 =?us-ascii?Q?wArgp1v5SmCzK4bgRHk8BQ2M5pRvuIY3y0WnKwzMsqacIZT0XfxFvCdzJzKJ?=
 =?us-ascii?Q?XKd5W5uRDHylZxE5cM7xiov0PDeCc4nOtpMIOKdbTDS40Mt0/rODow3DAZoB?=
 =?us-ascii?Q?Qp2UYbxNQw1Xl8rv2sJWmuwEGYW/wIuFWrIiEwBtH29EB3DMIUPAumJ7GawS?=
 =?us-ascii?Q?8i+Qt9MRiPGR3JgDCz1RHvBsEIanLPO4x/PFBdHzaXqCOjkepGp1pKTQxEIs?=
 =?us-ascii?Q?4sfUX2k6NOzQOiYQUECza0mlPXuziu7hfd4j32kUi3yifRioUH9uH8zF7NXc?=
 =?us-ascii?Q?dQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70A85D2617EDC04F93F2AD4B0C694927@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029aeee-7658-441d-0290-08da5c54d6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2022 18:01:07.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRaJh2Ll60Z+R0Xw0+GnfovzMja0pR/A8IxN8OrlRX1r78bNGGHUX7ZEzMEB8Ukr1QhJ6nZ4yTUOOr4xvBlNiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1744
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-02_15:2022-06-28,2022-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=916 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207020080
X-Proofpoint-GUID: J6x02SdhqhX1xlGeiVEzM2xlBqNws1OT
X-Proofpoint-ORIG-GUID: J6x02SdhqhX1xlGeiVEzM2xlBqNws1OT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

G'day-

The following changes since commit da9e94fe000e11f21d3d6f66012fe5c6379bd93c=
:

  SUNRPC: Remove pointer type casts from xdr_get_next_encode_buffer() (2022=
-06-08 12:39:37 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5=
.19-2

for you to fetch changes up to a23dd544debcda4ee4a549ec7de59e85c3c8345c:

  SUNRPC: Fix READ_PLUS crasher (2022-06-30 17:41:08 -0400)

----------------------------------------------------------------
Notable regression fixes:
- Fix NFSD crash during NFSv4.2 READ_PLUS operation
- Fix incorrect status code returned by COMMIT operation

----------------------------------------------------------------
Alexey Khoroshilov (1):
      NFSD: restore EINVAL error translation in nfsd_commit()

Chuck Lever (1):
      SUNRPC: Fix READ_PLUS crasher

 fs/nfsd/vfs.c    | 3 ++-
 net/sunrpc/xdr.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--
Chuck Lever



