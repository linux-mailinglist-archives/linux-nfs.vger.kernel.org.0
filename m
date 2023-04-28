Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A576F197C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 15:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346310AbjD1NaA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbjD1N37 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 09:29:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B92B9;
        Fri, 28 Apr 2023 06:29:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S7iIQ8008361;
        Fri, 28 Apr 2023 13:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4HcMU5PcQ5/1tQJyNGvk2XOZtMcTHpAjmQDI6qMbMxk=;
 b=inzQ5wMSPOHzUZ/naQrhPiC2h0s3qq/poNLVEg0uUkRhm4kak/b0QGPQdd2v2dIi4j29
 Ua/C5ekwDXGuLJIsMuyjjHo9Cjrv7bBb4ksoYq0Vm+YmTiyb9RxAjU59qzCZIotn9DzN
 ovRsIFIHpBg4Gh6rZgJqDokXInz0ols8zCj7XVunCAcljIQvl9G5KqwLOHtLcDSwXQtX
 yRYj4Erqze1bJcen77Uq5y6lgFY421PKNI5QL2OHLAIHI9e6NRVkzp5iClpLE8t/SxoC
 079+qtA748DOqUXhXTK4zjB6ZH8BtO5AjXx7/JKWHO8ohWNzFr3ChKPwBWalMsj1BTMB Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460de5bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:29:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SBw7fD028032;
        Fri, 28 Apr 2023 13:29:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b09eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKJw8lqrmUwVv92Jr2495U1b2k7qaECv8olKlG2BXomzBzEgWJzOc4ByNIKeq8eyxy2lCRUmD3leQRi2hzRb3ubnGN8F5tfzOhtSNo7RelIdN3YGBUOpo00JrfLqjDWCx8ffmDGDFHqC09d1i0KJWO71IkSYWzAaUtWMr4HPYw+jr3JpKJdc/uHZXBMggGqfBgXKo0kksZjuTMPiR42WZIxqSsTo/fD1gjV1yeETLygADm4d8JSCyx4t+8i+BBsG02jUxJUZmRpTQpCmMQJIxBzRRs17ygXj+2JtOHx5b4l4mmNew+RRUT4GdwOUxvijeZrNZrQxPb36rmw8DocM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HcMU5PcQ5/1tQJyNGvk2XOZtMcTHpAjmQDI6qMbMxk=;
 b=oCBESfHsEIkV22mBIMbk9jZ6HHCPoZbRI+kWYmeba2/FnLGy05Bv6BpHmYsbNmx5oxdyRw43yxJfpw6+8x5UwlVaXC5MawYpHnJ+WsFtFYQx86F/GV6+pP4a6hM6FM1mL6xeigqvXnIkulPwTHyGPcnG9byMjWR7GP6SIjbvlzwdg+h5iC/55Fvffcv+tafb+6F8l4UnP/w2g8Zq52O79FtqYjhaBpwXC9HmmZtKbvT7yoWTN5ufOZyXc6MeSXi5serXpIG0O4UVWXo8Bt+RhJHgdbo8ymTivjiJOKizuiXXyEf0u1k2v5qvC0DMO5jcnVNau2lz10f36/kq/5MEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HcMU5PcQ5/1tQJyNGvk2XOZtMcTHpAjmQDI6qMbMxk=;
 b=LFdBibOzTJyh78XUa1Tc/rnqzTaYIErqqK5InjxiVIsIYi3WSQnfjte3vLR2uoNLMy6nlS9rSIKG2wIUqRIpgEJsHHjPiRT5OuPfXJS6/CuUq7XcIwdwgbYbNb0dsHhE6uvg+qR4mksx0UIebCjBRNXz+KkvmCX3OhznWpGF4c4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4245.namprd10.prod.outlook.com (2603:10b6:610:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 13:29:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 13:29:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd changes for v6.4
Thread-Topic: [GIT PULL] nfsd changes for v6.4
Thread-Index: AQHZedWBx79ojlLawUa9IaMbB81lMQ==
Date:   Fri, 28 Apr 2023 13:29:49 +0000
Message-ID: <E0771535-05EF-4EAE-9BFF-E070C4D32F3C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4245:EE_
x-ms-office365-filtering-correlation-id: 683e3dbf-9120-4068-9a97-08db47eca445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Axvsk4xAyp/OrjGRtY6e3eb9B/jCpFPTJDt+VEGFKrppnUNwCCBiqeCqMAh6Hw+txCNB9bAOWTHN1SxM56ssnB280uLi3gdcWF/LNlM9dhSCiK6blbtK//h5/ioX4apyxonxBgWtCmNn07Mo9D3Fk2XsmOg7+S5F4wMwfdd7iD+LQblebopdE1+CCw1qbRAkoPvNmoflt2LsrpFeaXzGX3L1WoRhX68hH7AjenX/X78CT5PRsKiNq2+06OtfVb4+fAtOFdw9XI0bUttrxm2qQH1GEt11Z6ox319lyhCsosmmN6ELnUFPio4rKLMI2JjOlWl0e4fmUP5/kdoC0CEbT6tQGtAa46dlZuhP6jsqlgK5JHwjOM9nqXP4Mv5VL4elPrkUQqm6Qkbk8nvokxM9XAWCfAIYVdSPmYAjvMVz3L1Jw9TUaH2u05cq80Q5NZqrTcVhRfYweCNVFZlG17XC5q7G4arwqObnBbOh3dSad2BX1wnl6w6z7Bwuwol3pWib0VdjZVM7DaLWkGwko0JOM9yNjHW6HCFH1ZR4f141NkUTLELw4uDMamDitPLn8sbnhTHclrnrEKd8yr/KU/1a/a6JePFLxdOcITrtyNHt1bJ+Y4JE/rH3cWb655/5C/UBxwvrkdNyN54cyQeN20nhBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(2616005)(91956017)(83380400001)(186003)(54906003)(6486002)(71200400001)(966005)(33656002)(6506007)(478600001)(26005)(6512007)(36756003)(86362001)(38070700005)(41300700001)(316002)(122000001)(8676002)(8936002)(5660300002)(66556008)(66946007)(4326008)(6916009)(64756008)(66446008)(66476007)(76116006)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RQo1ILq/g/nCYf5UUp5fO5UWwOSqyeEavMWHFeMJaolCvh7V6t0N8MbXzOmy?=
 =?us-ascii?Q?Et91zZn+BOnyzGF+nzZkirE8dM/y7AV6tIw7uiMF9fJYr89IVGx+NwSvN+8D?=
 =?us-ascii?Q?Oihlaik4EoyHeB/EnCIkKpi5k+5JBYFBIUG6wB95nXmDEYy1TZb6onmaEaog?=
 =?us-ascii?Q?HPB51n6kNKEwhFQUOehCAacJCSTs/VvOIXG9KNYRJjg/rsSXwHA82kTnT4kT?=
 =?us-ascii?Q?GfMCCZ8362JuYy6cmzmaM3iEhq4ksRDk6ZADTVhVxhQ4rhhJBR55Q3FjQBsz?=
 =?us-ascii?Q?z9pztLXEpIK4tMN70J+2mMm7WusQaFWCMZcEtrfrTAkzasDPKYPM/svaYo25?=
 =?us-ascii?Q?4U9wUT4aY5fEhH0RXCRN1c6Gl4bk2r2SAne3uiRaNyyNgsTyEAx/WSsKW4R7?=
 =?us-ascii?Q?Db9kajcbJufsrnoCHdzgu20g1HgRi95c0IaHXoMlXiEyNjiv+D9FAGM7KUEx?=
 =?us-ascii?Q?7M35D4klAwFPBb3FEU6qfZwpsOOI1GOYHsIVe10HW6863HPMIjbwUAOKqafY?=
 =?us-ascii?Q?dyBTNMh+TAeVUfEEf6nRtnsFkmwn/VkG2V3rYy9LojwiRm0AG6V73r4a7b7M?=
 =?us-ascii?Q?I3k514uIppOGJoNf+CplhZCweVTGRNdvsbjLgeykxA8SfykWw6mnIHR1PXBw?=
 =?us-ascii?Q?6cf50UrpcvcPtFy/GR9b8PY512BqrmI29/Q0dwtHFxnneuDYNrAYBrFdOfQ8?=
 =?us-ascii?Q?bcJPResqE2QeqJ2jEmBXrIq+E0PECt1bnpINvyL4FWYxcubLDUabTUKvA/Eg?=
 =?us-ascii?Q?JT/s+boI35FspthjKu6pNNr45X//si/y4JxPyqvdSrnCKEdKWFOD2jfOwxMB?=
 =?us-ascii?Q?TwCXPXzvO57lCSNt6xslPhE6KKgCp4s5URPov5EzmgplUdGHVU2i/uzLGGqP?=
 =?us-ascii?Q?vRo16Cz8hQp1IHqa4D6ZkZCdY59kq5Po3xK4Nv/rNKDXssYB2hhEMdke2M/6?=
 =?us-ascii?Q?PXTSn31/kbZtI5sFcUc1e2JHtlElRXSqEr7PeurVL/BnHZqUuM7JB3XqV+9/?=
 =?us-ascii?Q?NJvojS0LFi1XRfLvPagMp2vycapJsmugh+9aSQDioZwdHZjeShlV1Au3qYHr?=
 =?us-ascii?Q?QDu0R14pnM+ZfbD5FXEw2vUJQo11nst+Uqu/awsn2O+HnkNwt1tF92DHpRA2?=
 =?us-ascii?Q?Ov835Wj5pC5SOOVJlgCCr1hD+d4ldOQIZ8FHqFiz0eNlW2RU2xeKmPRABfvC?=
 =?us-ascii?Q?SLzpuzdqwkBk8a8Y0fTbML6XHs2LidZexCBs4t87nBR1kArt9FJn/G1Y9K0k?=
 =?us-ascii?Q?GGJdtWkyopILTUTjrs9BjLYMFZrSZf1lafmF3k+NQS7I39ojEZ1/CmxJ73rz?=
 =?us-ascii?Q?oIskDGg9aeHxb7vxDXh6ild1yYXM7+0f32Ju4dR7xlveFbQPqVrGyU+Smeo0?=
 =?us-ascii?Q?+bIDSIqYwHpHib4ipuzfOm8gCWzyTxadoatcZ/ZVGX/H/OVGrbiXdy4za7Lc?=
 =?us-ascii?Q?DpSoRZJwP0UT9djYZWsNlSXHNqU/0fCe8DzQRs8yfeHxguxN4yUtb+CJWJC+?=
 =?us-ascii?Q?U/9Tsn36BetqDKV23zLwdOSr6JaE2QkdNinox4zrDTgir+QxBIWvtWTXPNyN?=
 =?us-ascii?Q?DZoquEmmtXvutAZuLAu7IkUpHgQ1UacND79nAaU0U6ouyvMn7aUByG2CsPlY?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29722E22DED11947A648BBAAD82643D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OS0KxLQLSyABk3eTweoKQ3GLoY5+I86Ug2ujIs074wIshiBn2Y3/FNVPoO936zwOogrEbIAV3DvR+glnKTafQD7/AT5JqdO53nIyjhbvQ44NiGme5bBWfWbKrt0Crzdgy4Fl0wsh6mCOfA8RftuZop+CikOje+2nqwk/XnhGBvqRQux9zUdi52rcLl4f+FEB14ejK+NPGsBhGPb/4d73aeI4TF+0G2mHqix9wEYGSUeKCsZYW8jaWHuD4oh4d/F5U07dYjcO38enQwFsKSSuxVMp6SX9dDkgrLZMtg6iuU5uUpDRkK98lvC7FfikLuvzCWCLit+pzlEsFFPe8+K5sE3Vlf10kVqX2oDda1Umi0POx8OtD1E2OmbratV1yLcPnc41g8dSxfr8B93ezblhaRh8qKrKW6kavJhxks0ltkZtxOMk+p9UJlFj3z2BQuHyA5gezDEQo5dYhd0mFkejQ+2vUWZBTa2tI64JsBiWEdasKTTJS8iIkSDJxQ6L1Lr7WDJe+eqso+b3Rz4K9meomO7K9faTCziAC2ya5h/sejurLBpEivmfn3OcpoiM9P9YcLwYSkfWa1L/4lA4824j/ScAwJOHx3xSFJEVUzAjWrbbD/nK9vSmTU/x1+E2Z4bP7bw+XFPx/bY2b05QGTEDcnAZJlkwwQT5xE/J+7RmrKgcc6AIh8Ej9NMjLV+NDcRBYL5V2x6njlRvsDBETRF6xQxwo6FxX07U2TvL4SXhEugTX+rIxgo0yTgYdnVBFXAi+zwJYww2NCDUleqVItDfwjmI3WuxDqWSgrwREYU/NiIUECXqerBr7OXcQJbuZ+TbEaqetX4oMLHXcL1yIy38FYVmuYQELm4SaAq8BHzFxe8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683e3dbf-9120-4068-9a97-08db47eca445
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 13:29:49.6456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3CX70gNk0yFa7C7tEDlt0vLxFYXpDUnf4z6Qy9SCsfNW9mz64KFfsdnrR8gJJKk/sE6FEaYVloYEM/xezHb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280110
X-Proofpoint-GUID: h02HNN4xsuVnCLHGq03DqQIUq4rFimLf
X-Proofpoint-ORIG-GUID: h02HNN4xsuVnCLHGq03DqQIUq4rFimLf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good day -

Thanks go to this release's contributors and reviewers, and
especially to the netdev maintainers for helping to get the
RPC-with-TLS support prepared for merge.


The following changes since commit 9b78d919632b7149d311aaad5a977e4b48b10321=
:

  net: phy: hide the PHYLIB_LEDS knob (2023-04-26 11:54:50 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.4

for you to fetch changes up to 9280c577431401544e63dfb489a830a42bee25eb:

  NFSD: Handle new xprtsec=3D export option (2023-04-27 18:49:24 -0400)

----------------------------------------------------------------
NFSD 6.4 Release Notes

The big ticket item for this release is support for RPC-with-TLS
[RFC 9289] has been added to the Linux NFS server. The goal is to
provide a simple-to-deploy, low-overhead in-transit confidentiality
and peer authentication mechanism. It can supplement NFS Kerberos
and it can protect the use of legacy non-cryptographic user
authentication flavors such as AUTH_SYS. The TLS Record protocol is
handled entirely by kTLS, meaning it can use either software
encryption or offload encryption to smart NICs.

Work continues on improving NFSD's open file cache. Among the many
clean-ups in that area is a patch to convert the rhashtable to use
the list-hashing version of that data structure.

----------------------------------------------------------------
Chuck Lever (12):
      NFSD: Convert filecache to rhltable
      NFSD: Watch for rq_pages bounds checking errors in nfsd_splice_actor(=
)
      SUNRPC: Ensure server-side sockets have a sock->file
      SUNRPC: Ignore return value of ->xpo_sendto
      SUNRPC: Relocate svc_free_res_pages()
      SUNRPC: Convert svc_xprt_release() to the release_pages() API
      SUNRPC: Be even lazier about releasing pages
      SUNRPC: Recognize control messages in server-side TCP socket code
      SUNRPC: Clear rq_xid when receiving a new RPC Call
      NFSD: Clean up xattr memory allocation flags
      SUNRPC: Support TLS handshake in the server-side TCP socket code
      NFSD: Handle new xprtsec=3D export option

Dai Ngo (1):
      NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop

Jeff Layton (16):
      nfsd: don't open-code clear_and_wake_up_bit
      nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
      nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator
      nfsd: don't kill nfsd_files because of lease break error
      nfsd: add some comments to nfsd_file_do_acquire
      nfsd: don't take/put an extra reference when putting a file
      nfsd: update comment over __nfsd_file_cache_purge
      nfsd: allow reaping files still under writeback
      lockd: purge resources held on behalf of nlm clients when shutting do=
wn
      lockd: remove 2 unused helper functions
      lockd: move struct nlm_wait to lockd.h
      lockd: fix races in client GRANTED_MSG wait logic
      lockd: server should unlock lock if client rejects the grant
      nfs: move nfs_fhandle_hash to common include file
      lockd: add some client-side tracepoints
      nfsd: simplify the delayed disposal list code

Luis Chamberlain (1):
      sunrpc: simplify two-level sysctl registration for svcrdma_parm_table

NeilBrown (1):
      SUNRPC: return proper error from get_expiry()

 fs/lockd/Makefile                 |   6 +-
 fs/lockd/clntlock.c               |  58 ++++++--------
 fs/lockd/clntproc.c               |  42 +++++++---
 fs/lockd/host.c                   |   1 +
 fs/lockd/svclock.c                |  21 ++++-
 fs/lockd/trace.c                  |   3 +
 fs/lockd/trace.h                  | 106 +++++++++++++++++++++++++
 fs/nfs/export.c                   |   9 ++-
 fs/nfs/internal.h                 |  15 ----
 fs/nfsd/export.c                  |  64 +++++++++++++---
 fs/nfsd/export.h                  |   1 +
 fs/nfsd/filecache.c               | 430 ++++++++++++++++++++++++++++++++++=
++++++++++----------------------------------------------------------
 fs/nfsd/filecache.h               |   9 ++-
 fs/nfsd/nfs4idmap.c               |   8 +-
 fs/nfsd/vfs.c                     |  13 ++--
 include/linux/exportfs.h          |   1 +
 include/linux/lockd/lockd.h       |  29 +++----
 include/linux/nfs.h               |  20 +++++
 include/linux/sunrpc/cache.h      |  15 ++--
 include/linux/sunrpc/svc.h        |  16 +---
 include/linux/sunrpc/svc_xprt.h   |   5 +-
 include/linux/sunrpc/svcsock.h    |   4 +-
 include/net/tls.h                 |   2 +
 include/trace/events/sunrpc.h     |  41 +++++++++-
 include/uapi/linux/nfsd/export.h  |  13 ++++
 net/sunrpc/auth_gss/svcauth_gss.c |  12 +--
 net/sunrpc/svc.c                  |  49 ++++++++++--
 net/sunrpc/svc_xprt.c             |  33 ++++----
 net/sunrpc/svcauth_unix.c         |  23 ++++--
 net/sunrpc/svcsock.c              | 174 ++++++++++++++++++++++++++++++++++=
++++---
 net/sunrpc/xprtrdma/svc_rdma.c    |  21 +----
 31 files changed, 802 insertions(+), 442 deletions(-)
 create mode 100644 fs/lockd/trace.c
 create mode 100644 fs/lockd/trace.h

--
Chuck Lever


