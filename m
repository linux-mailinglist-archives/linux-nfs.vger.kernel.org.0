Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B717744188
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjF3RrD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 13:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3RrC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 13:47:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B04273B;
        Fri, 30 Jun 2023 10:46:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UGhlh9030282;
        Fri, 30 Jun 2023 17:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2YIFE5T5tMOSXoPqZvq1kL5VcDkUJgolDF+kXwS851k=;
 b=NtEbl/OZZa/8MRe2o+sYopdyg7u/fXqwqIw2E0+0Sozogal872WZVteNfe88X5BCtnPI
 Qg/Ni+DaME97N8h+IBAA2sF0sJug7z58W5IkY7ezse5M+9LYyB2b7j4oQku49gKs1v8b
 BNj8OsRV6Qc1+IBSR7kvRQGzPmy3/cMnbbHbybjn3P9V9WyI50zNff4BMV+H3w5yhp+E
 NNGLH9yHOhUPmlDm8eTJezmri5Bp3Sbw4+1SyBc98MmuOvYwgQ9NZQH1mUYaWUAMI3Rs
 B3w5QqRLUoQiOqphY0p5n0akGCLB6RV9hgPQOpFF+9IJ+kgtK9izMRXuGf6RsWl/3fo+ Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhd1r2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 17:46:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UHUab2029816;
        Fri, 30 Jun 2023 17:46:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx955sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 17:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea+OX0798/EcAJA82m6HNh+U98yq4ctrGsAwO8sBS2CLn8cOJmz3OlUpvY4kHUwVOU3BaODV8v5WR/rw1xMpb0eF33ccvinjwLQAI86mjcxNTLk+PRhSJUI/mffq4EInAPHQCLw/SmT+lPcIUgkDFNLlSoHtJ1PDdjMS30ePd7dkBRInToc5lctHhJJAkvYv+NDImFBZK+GxSx1w30YyhyRQRmxc4i2t8Zc5UNTObLZJGk6Z5NkLIu0r4rUsy8oM5SAaM2gnbMHcwhVA0LPZtSG3RFxwF1nRXi9/CvJoDjF5/1RqSc5FeNmaEjnKp0o2sUFOdGEcXAXsYdg+uSOksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YIFE5T5tMOSXoPqZvq1kL5VcDkUJgolDF+kXwS851k=;
 b=cSuFr49DSE73J4EBg8JVFyiRiWoXFmgyqrAffMe5URuUgLXIPloK4INOEwpPIYm+XlCmyXyuudzjCQ7YJ1iKCHC6nspgDXwXTGnEXJ0+lr54k17VoWhn8/6qrFcF4POyk9Ee6CPMvZeTRLHr2DjyBvmLRu0/m/4/A+QizLLU3VafgQgiSUgG3a01fHsn+w9RXE0f+LKdXl9v47ljXoi23nAn8cjg4egI+sp+PQdQ1ZYBNycBo5UIrpzf6KmVOHLZOmFZy2rGQiCNXng8iGAgONdikxVr0ITYP4E9JYjbIwr9S6ZsHg13xNvOcoOMrc0gAL5Id4fKBp0xf7I6q65Xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YIFE5T5tMOSXoPqZvq1kL5VcDkUJgolDF+kXwS851k=;
 b=AsYGchoC5RMDNxVowXqNKH+NtTvtLlq+YOTRjH52U0Yg+Oiu4WHeUNDOe8mCkIYVBYBIQ9OaOaBjPC05ho/kbZX5A+gEqrBqGEFsq/GK3RWmMQR9N0WekzS3dfLoWvgLQgOZh+FnYvKi1AecvNCknycVv3zijG8y4pfW71AIjP4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 17:46:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.012; Fri, 30 Jun 2023
 17:46:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for v6.5
Thread-Topic: [GIT PULL] nfsd fixes for v6.5
Thread-Index: AQHZq3rZ54+vVuXhb0GtMypv8Bh5rg==
Date:   Fri, 30 Jun 2023 17:46:51 +0000
Message-ID: <FFAD650F-18C4-4C2A-9BEB-2C18A8FE94C6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6046:EE_
x-ms-office365-filtering-correlation-id: 02e4b3ff-338f-43c3-5a78-08db7991fc42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBChIIpMJaBy94htBCyL1b61cxhelarHkFuE0EbnDemNtx8BtpEdrH+rGXHBE0FszVOkwU9tUgg+0hJ9FjoGQAnoZ3vNMf+DqzPbScO1LLxkCETnrBKZah0q+PVtdBDRKc2re1fVd4jAYVidrzfjoXpaEZPIe4qwmtVpOyHtCjW+9lGZ2LV4lQZPkiyHE8rb9CFmkpREz6IzAxHAUiMOiVFp/Yr9p0jMtOGMwgahuEpevOmf/0s3BAWW4O6scz2tcwC8OtAlqOkQcLhlDHfOk3YGGpV5bVHJlVtmbYCZLNSXw0o0GJYFob8IX6Uc9/rOkyTDFMCyitjf7MHSn9cQdAINcTYvbnzr6i5T4yGZ4z0VmgauC/PczBzr9OlOHto0wwVyNtiBhyGU7Ezbi16zLynOACL+Jo6OZ1WVB6TZMazPHxhNe8UuloJynlJh6a5QcvozVposcDxT8P7oBbKPhsDbTRZ/QSvP8+5HST4OsifCBvAGGjDZRkA3DOCzJE81O6kB6Z+JS9mzN0rmDgs43Cl6oUjxksQhCD4Gwt5Soxf/owEuDJNBFdo/DYILTXdfyBFsTJmOkJ+df6ixMITjECgqcA/N8e/rjNYg8LL8grGskjLJT9d5+X0ayXIsFiizEj/hSlkfgnC58JModaRF/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(8676002)(66946007)(316002)(66556008)(91956017)(8936002)(64756008)(4744005)(186003)(66476007)(66446008)(41300700001)(6506007)(6512007)(4326008)(6916009)(26005)(76116006)(6486002)(54906003)(2616005)(966005)(71200400001)(5660300002)(2906002)(38070700005)(122000001)(478600001)(38100700002)(36756003)(86362001)(33656002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/4ru08VFrZVQY6v0KS2qPTQOxw1kWQyeWr3nizH9+TsEVLPDtovvWR2XzG4?=
 =?us-ascii?Q?eBC4gJs/ZgTZc2ubll2pUoXQ2noiBKZfwlNOWj2wYWjsdVEW7a8u+tk3jCbx?=
 =?us-ascii?Q?2138GkYyWugdNEuUzZMepn5CZH1K2aesj8vjlKpxL+0C84Kub/dMw8pWBBm5?=
 =?us-ascii?Q?Pja0N3cZVRnHk2Iy2jZm+vRwbQDgrD+jlb3zIh67dGtWrUgiVCz0SdRQH9iX?=
 =?us-ascii?Q?f0Jhd43ssc7Q5PEzclXqYwBWEN8phat1ITaqBBWvAkzfkBWnCUuqXWhdbfJf?=
 =?us-ascii?Q?lwO7cz9K6C23K6z+R/T04txl5s167eC5Hyp8i2I29sMdvzkxIZ5/+lRTo7EC?=
 =?us-ascii?Q?hGOWSswZ3EbhBBLCJxB5GKJ7UNPn8VI4Y8WFqwHnSBYoBHaEjhbgLG7nxhNp?=
 =?us-ascii?Q?F/uvkzBa6GMByuNwQQBmqTMdJFMVcdkegDZnUZOxKhWQNBhnz9Us+5DHZw2I?=
 =?us-ascii?Q?pEuVopJrinmIO91qnZmPlv/hkxm2oy+9E66lTWSOVy1vDZpfKX6ZvMuk1VXY?=
 =?us-ascii?Q?KDnn3mghGpE7USQPfhQ+qQFPGBUHLoUWGfzQ5hEwz0G5TRoJFbqUgVVLMXRj?=
 =?us-ascii?Q?9lxWk6FMBFFL8mqY1YQfjvV4WzcyjnwphEdaL8oRpZAo65MW9fgko/urPcnq?=
 =?us-ascii?Q?Zr65UwNiVEtLC7T3YpHOEcxuovDVfIG/DYVZaQqCf3ZHtpAwdCs7sN1yM2+Y?=
 =?us-ascii?Q?MCpuHuA+ZEY6tgdjohAo57+NzOh8EWL9o6IOLDBduZSib5N7hCFRDD6Q9CAw?=
 =?us-ascii?Q?jpK6btyg2qcHeDDXrIfEYbaEoh1xzFZM3kVvQ1MXj0khXYtgoZ//9GN4x7HM?=
 =?us-ascii?Q?IsE4IhT1jbuyz614y3mL5VJzM3/iVwJlw22pVEZRxwEhKDFDR4TTCj6QN+wm?=
 =?us-ascii?Q?8tdx0N1fpS0B7vIukhCEzYMusZYGHLblqAhTIr+lkzq8pH+KF6j+vNkOO3ua?=
 =?us-ascii?Q?eLwKkqze2fEbV9TNGeQCkMSiksgd2TcHZxHtRvPRDJcE/0pAO/+lTPMg8hVN?=
 =?us-ascii?Q?nStZmvU0La65iV/ZrRrtdBwf5r7d3GrhBFyYe58Yla+oBFcqGo+JWk9LysPd?=
 =?us-ascii?Q?oONC5ZGWZHBZ0O6cRyWulQc96HXwXlctRGnZaClKeCBctDJ8GrY1k4QjHKSG?=
 =?us-ascii?Q?HPSnQ5I8ry8Kx1dITzEtegRZdXIbiwsLOmjw2i1yZ5H4BVqtJXysXjfSdmXK?=
 =?us-ascii?Q?eDVEoXUJI1psh6f0O4p68F0vWJkVsyBZDTdiFrcEDeabSJz8gEaXDBPwmTW8?=
 =?us-ascii?Q?paBbj12xk5CMUMc+ADVOnAvGgWUnC0kO6BRTbDmt4CiSN28Z+6BbyLQaFxwG?=
 =?us-ascii?Q?oudPbuY1C5UrDVhSU4WQf3uDWCA6ileI04ZqeD7TzDpN8pV3EaLzpjV0RxeH?=
 =?us-ascii?Q?UY6ZCpl0/4NsjZZ2vruK3qoh6aBzRpQ/DxytQiLdiZqSF+6zvpqPmBlEFbSz?=
 =?us-ascii?Q?1KpLE2zcACbq0/0rSG6M3mjO+0AmCVU10E+RKdnAv5Sugq1fRwxWfzLP6dTv?=
 =?us-ascii?Q?52IQRhDa5VLt2Wa6+INjt62Yfz+uIy3hV2BoYMbc5FGVdJXNQIm/bJxidytC?=
 =?us-ascii?Q?bQxDgDSS5ui81BKIHYDNWUYzzLykTkv3AVEk2rjMZwgEKB+SMq+MaF/o2GEs?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22DB7D430A4A194AA45B5798D35B53A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 88jEbJS8X2d6Eo3rQwmoXJh9dfO3twdIU45bt6YBpRwf04fCWBdgNd+iKY2zbiW6Mr4X6a6IMl5z8CAkHweaQMxn6tWjfUKzD+MLOfOpirvptYS+7owgDp6pbNb+T8hph5SfyEkAmXOyk4hRP4FVfoVN1aWvQ/e+fkIDusK3ZDrEJQk+8ATpF4PsK/tEl07jnBwKnKcmr7rq14ekTLRCq/sal9Gl4nAeI9W3+mPTAeSuGyvLJ2DfzyBOoiJj6Ay+EDJMkDW6d7u+Yu7CFsJR8gWVaCqV/JQaMOlRRUxS3tBjftQRxtcgBvew+Z3OqEx5lGhZdykNgFX5ZUbAkUfopi8/7O+m6FY3YNgBdyCB/4eO488epvgwXnSEk3sYY4miiM9sby1QXuRbkAEiJzPJwNo6qIr4mUVqe8KbCKsH50W42MEueEvaOB+jIotzHdiF3HSyHpSgQF43tRGBUA2DChuf6uF2TAOQ6HIyS/GHS97tU6pnyFlhiwaLt9gRMJaxNIOKa9VY7qMLvVN39GtZE9UpIcRFyAHC4FwqfFjTXh+UHfuyRCwH9W3aRT64vbzP6M5UdC1k9UNk74409NpJO2wLwLQ21hB2WTcAoKUmE8ELP6dUHqGcJaUECVMTmEnrYY28f2r4EksmszpoCOT6RXvLF7gTsciMvvoGyttoG+nYwRwzDL4ue9RV6/41LyKoDh5/lktkWAhmJdel4T4aLP8LgmSqp8nNXG3qBEcMNUp1fucq+dze2kIQQ81tu+ddt6DVeuNYteDOMmCwDTiOXKB7omR3dg0dcpGSFm+Hhxw2C4j0Rbw15CvsOqPktThUDJ4VdHKN0r2Uyb3lRD43Xc4EKOGVKDKHWHJuw9VbhGI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e4b3ff-338f-43c3-5a78-08db7991fc42
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 17:46:51.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+MYVS6KCWxeiEFHKOKAj0gr2aom+sxRjriX6ehG3TjwiDsQTEwWeDlDVJSJH4Lb6jB3kJBuXrEjJKh+7FfA/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_10,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=996 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300153
X-Proofpoint-GUID: PL2BgaWytNJsXewFX5ziy-HJFk7x1gxb
X-Proofpoint-ORIG-GUID: PL2BgaWytNJsXewFX5ziy-HJFk7x1gxb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 75bfb70457a4c4c9f0095e39885382fc5049c5ce=
:

  nfsd: remove redundant assignments to variable len (2023-06-21 15:05:32 -=
0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.5-1

for you to fetch changes up to d7dbed457c2ef83709a2a2723a2d58de43623449:

  nfsd: Fix creation time serialization order (2023-06-27 12:10:47 -0400)

----------------------------------------------------------------
nfsd-6.5 fixes:
- Fix ordering of attributes in NFSv4 GETATTR replies

----------------------------------------------------------------
Tavian Barnes (1):
      nfsd: Fix creation time serialization order

 fs/nfsd/nfs4xdr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--
Chuck Lever


