Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7965D6B4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 15:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbjADO6Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 09:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbjADO6J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 09:58:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2838AEA;
        Wed,  4 Jan 2023 06:58:08 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304EBXAZ013125;
        Wed, 4 Jan 2023 14:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MnaKtQ0YHptSBa+QaHfaVsOBA+vtvivPPFEfS3sOZt0=;
 b=2HNb4QfBlw+g7NzXmMqF4NFqHlRrsWb3Ti5PjIjMr3DY8vwOk2vdarPDfmWehbvS3Dh6
 /ZCUzeuMVPb7bFkvEsNYcxuCMwi5xmjhJ05Qsq7ek3qeiJbcm1LWkCivOfcbLNKnFbbP
 84EVdK1QRN9hMwlMI6Sd7L8Y0U6bfndZzqj1Gj8i7AYqnxujN6u1TsFacBfIZUe5OFB7
 jkSkU49pSjlZyco3nDn64KOfQebzOx4bC5gRDbre7r4a2vGk+XpW1ZpCva0T6rccAO99
 QStfNsyTG4lCb10WKVKjHUeijY+9q3K2Lsd6teVG5+JkHxBrrMCPvtarygeY0J0Qux5Q 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0appch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 14:58:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304DrgeA025107;
        Wed, 4 Jan 2023 14:58:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwar82cph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 14:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8/OAbL8hYZuSa9goTUn0nQKCeHUrs+sWRApGijYEkhrCgPnVuTns1l1e74rlVGZuwqbizqzhlXJP+fTRfYtcq4oXzG7PA9VZl1n5clRSundGiBoymMnS6JDBVoLB8mtBsV40Mnkhjpqlqn/jo1hExaTaDJQd5RLHrAWbgzkoGi+XxkRjJobGkU/3lCQk6reoZGnXl0qGmo0mv+JZB0Er8n2wGdcMLSYyWT7Llh+ik4psZORvP1hMxe8HhEL95DdRzn7wiI3/bFLT97B4o6nOtxR/TcUELVnSeBN5h/HXSIFgarPq5vv44JsAK/xITSrv2LPcFs4Q/ucvhJ58wOiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnaKtQ0YHptSBa+QaHfaVsOBA+vtvivPPFEfS3sOZt0=;
 b=nwzdDupqL3Vj6V081mSwsAO9mLQ0+Kw/wkggTEfsSlpTDbyCIXLSGW6GgjRLZgH7figa3FSE99oG92hj5jqmcWCwS8fGR4tXKbZSh7abfsVbLu/K7Fzg65vS5j+Msdm08XH+aL74jDN13Hh+QU3RZZ4aVhzoxuOc/TfefRZQOAT65pRQe5AuRqgJnryQ/wIU7kR3RO8Rqoq0ogPehS4/kNSPcCWWivv+qldCXHPoNnzaB1qUaT32DD2P5EABGaPSS2euHmbi4jTDNwTB6lm9/b/uug2eFRv3Ql1UouEG2IXoAA4/P+wwffFaIaaNjy4wA4BfXHLK0yhxjej/V24dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnaKtQ0YHptSBa+QaHfaVsOBA+vtvivPPFEfS3sOZt0=;
 b=NR/JbgM1pzlqiSiNbFTl3GE4R1M+O67PMbML6p0nbWiKSxsqbcYa1xI4bwUHDsIQxzx5TkXOWzoul/ql2iO3G4aECm6AYAFtvhxWr3DmFAhn2qE2ErvvX1oi2AKGyLRkGDDC3oVLx49UR8fbY8UTTjT1khkxGF3Cpo8sju4/WrU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6282.namprd10.prod.outlook.com (2603:10b6:510:1a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:58:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:58:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL]: first v6.2-rc pull request for nfsd
Thread-Topic: [GIT PULL]: first v6.2-rc pull request for nfsd
Thread-Index: AQHZIEzwUC0ok/2cjEeRAaihM2HQDA==
Date:   Wed, 4 Jan 2023 14:58:01 +0000
Message-ID: <CE9B9622-234C-462D-9125-5DDDB00DB9A2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6282:EE_
x-ms-office365-filtering-correlation-id: 8182c362-e25f-4a6e-5b1d-08daee641363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmsVrBoLf7nEIQ1VUyHyNVwlO0Zk3JWRNXovsxM+YqYOlnK40jFiGomCUlFQ/rt9kUjdsSN08rN8A6hNkKutSVfUP6DSCSot1t/JoPDAooh2LLkmmcL9ucNu4kPqlSLfKcURHw9wDvUB/fj4q3ixfnfw235BgMCwqaZrk15p2v+maoLahcRJjyNYB62D3YL0tb8Jd5oYmOvFD/z1lOojTy9qi0e5+UI7OVGcbj6xoOwwyrJWnHTDoJZfVgzoLsln8Fcc8lWr5LPljJkjY3+KXNlgDLeYx/Lzzv3k/CH822HD8tmRjpqiwIyYlmCF2OHJBEYhMC2JNHXDd9E6aqNHXZYp3vSh67gQ9LWEiK1poVjyBMcUwGpsZ9EJGG74lzFJ6Rj215RZ0UDanhFEscFJmhmTw0PQ+ly78/7KTJ/wdCWwtYdq98zJODScBHRNCXxJzxl+WfSEApsidXz9Q26e23z+DppXjLlCFjcRVXorL2VwrXLhBaDIrkeqqGca8TUDlC7bEjZH1R+Mi5+ToDHgysg5+AqxNU1rx5FFRqUyg9mlAUJ6XzBR1KRmtYna7bUc5DtJ0oV+ZFmQyeMAOHW9NQpT68ZfgfeGVf3fAk8uwH3uXbC1RZ9z2rb/xvlO0lpK0v/ek/fqy5BHqQ8TiXa80ZdKlSlScdCMHDVZb0I06OyGzXIgShvfnRLHTSysS6smfNfRBiCuDhI8X0ipmnaCsr+3i0lyADoMVRMcQaDTl+OrLKUMPNiv1BaQtqpG2n4+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(5660300002)(2906002)(4001150100001)(8936002)(4326008)(41300700001)(8676002)(66476007)(76116006)(316002)(64756008)(66446008)(54906003)(6916009)(66946007)(91956017)(6486002)(966005)(71200400001)(66556008)(478600001)(186003)(2616005)(26005)(6512007)(6506007)(33656002)(83380400001)(38100700002)(38070700005)(86362001)(122000001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C48+Vy+MkqEKFiFUv8uhC9YSYYeNk/boUR+W4Gk1zj8Zo85F7jXgJn79BG2l?=
 =?us-ascii?Q?6mfqMlqlUZyCx9w0RMB0n9WAkWyxESa2QrYtNL5qxoIKLU4aSKE3YhdO5JLU?=
 =?us-ascii?Q?E57Tbed/NVLBpayY8mFEk6i11rEDgaA9PIMMV+KaQKPDPLb8I5ZzoD2D6EIO?=
 =?us-ascii?Q?N4UCA3cf4LRzKgzzxCQkt8trsUzkXb/Af09sEeZ6KmDZ3vLioxI+LduKBYTD?=
 =?us-ascii?Q?t80dtknQL9yDctsDPDt1QR0Ciw2mYO+1E/11nxgQ2ul8gvuJzHgFxrmLympf?=
 =?us-ascii?Q?Rv46OT8lQ9Mz//i1wCwHiovytrzwsI3Ki8AZO/7BQ3UAxgHyl0jWc8c6vvOM?=
 =?us-ascii?Q?HAdSEUY9Jl4WD+1jpF+tSzSmYpBCKbmlMou7avT1EN6T44d9OB+LyD5twNB7?=
 =?us-ascii?Q?qrMSrzsxX6ni8Jlzg9QYBI36LUOvYRsNO3CQXLlG7U3Jmx6Oeq3MQNffVNkw?=
 =?us-ascii?Q?fs2Q0CT3t5hOYPreAGd5w5zlN1+wvA7UFmeg0rYdLYog3Hg9/cBfQ74anUd0?=
 =?us-ascii?Q?0iIBGS7iKGD7Ayoafi/5wp/bVNkeKUTuYvoDb5sDx7O2mv85XA77PxKWV3Fy?=
 =?us-ascii?Q?NKsArwQzkZCrNlHbRWdoEkGFEZO78wTqiUAeuFVGNYHdxSSt9y3Efp1jRSwg?=
 =?us-ascii?Q?o0yqwPwnkLuqonBiHf6rQwtdlxgnJ+6ACuzW4ZXWodT1kbGKphbcfKLDwOOo?=
 =?us-ascii?Q?jJqB9OCkRPQIeRmuXga2zKK2JmVxx23sTr2XAJTjU0aiQjMeyT1BGEAlx+pJ?=
 =?us-ascii?Q?LVTRBnAxaFVw98779JGJ/2npwuUiHf5CAmPk16OTzl3w+L9NsmGyd4h1qWfN?=
 =?us-ascii?Q?H1KqIYuL1HwBOJiOTNrCts5NmiQx+Bj2zh70BoUa8YiEm5CSqAzbnt9qOpvC?=
 =?us-ascii?Q?7Ca/IXJ61uAaHOPD/p099P7UySWEIuwVfOJztay0eMvlrpgE7ocEBOye/BTj?=
 =?us-ascii?Q?Vtu6GxGx49IhlD07sLaC64Occ2RvmI79FTkGmTKr+StUDxbfrmqP7d5DpNMa?=
 =?us-ascii?Q?fBkYNg3IvW7RuJ8JGfuABH/I5GYg2RZxEbVgCwcBBWsMXlixLC50aV2TbzkQ?=
 =?us-ascii?Q?w3CIfca9tvw9DmoRaX/w5bJis7Tp5/wiainWxjc7YswCgup2VIRE3gfDK8qp?=
 =?us-ascii?Q?UbyjaXytQnSn0CVQ3fai0uHC5g2CFLNAbxTGH7NXaKqxUWaBdybpaNkh7j+/?=
 =?us-ascii?Q?jKH3BGK9RG9yYpnwgvtPT8ZXiGr8dkWPtRPHiq4+i1BWbV8EOIyYG1mAkg9B?=
 =?us-ascii?Q?ft+/P89mSfi80V57HSaiQK+6EPKczYT014ijdvotALDTICdSidpJqI9KA8Fp?=
 =?us-ascii?Q?K0xxPmV1PPF6WbN7qwg7aoRE3A+j/Q9XB964zJM4EZ7cv9SB9eaYxreoTyQT?=
 =?us-ascii?Q?SdxYeNdJEOVFQJL5Y+xnFKQbLsqVdvL9J2FRzB5InQItVWlWjgC9b2aF2r4q?=
 =?us-ascii?Q?b24xZwa7hPSr9cLrfkzBKmv7Ti5yeTp+uD8a2dHM+PORY3+HPu4SedSZ1qqf?=
 =?us-ascii?Q?3CK1+My7O/387P1dXDVTNDGtmGjNHeGij5V0x/4YsgSgIPWtLUMySNmwha2m?=
 =?us-ascii?Q?+vvEKzD72ULoZetr+ShFM52PqLHHHBAt9iFWrvHvP0BIBp6LYYcpGEhTBu1K?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7218845229157640BF856E008286B99A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dVnG4k3D6mgvAWmsRk0zYQbPg2uuJd/+FIutTQ6Spwsouj6PSXAF48oOEfWkSYAoqdORyUI/+DHSpXrpT5zhg/fG4oXCfix6VsI/I3daXrf/0wqmdi85kHre2LsLhy95qgrhobtJXUod+UQYyXiiD69xTzgyHAyUUtDMFmvfwqxVcEhcoZvUiLqQLwE23WgoGVt6o+Ah404mgy6ZPR9lBktIoSyjZrN0tWywz6F421c5AvBSMHyDDSgHH9ihdX4Pe5MKrTD6l9QJqDK85EXFBo8iANtScVSjo9iMfmK1Xx6JpsEXOD1jfngtAG0k3lkbYNAXyFF+3GWFoz7/alnbUAMBvZbs71iNj78tUSxo8p4oOB7ILQEMpGzE21dS9Gf79m5ZJynD8NN7pzMGxv+sKxjdRqlbjufqGj/8wrXXHczhj1+VP9HxAdOVEl/Vup/BBUTKlUlal14L70SS3g+caknYJEJOHNhr3Fe7khFB9PGnybYgaEBTX/G/LDFk7oJ+TVc2WawC4rPOQBz+ZV9x4oHLV0WHIO8OYmpen8vZLd1Q/BOe7aR5R0lnOIwye5T3cVLdnqWDumQTC5nUtk4pIwEMajEE90OmlOfTWHIOQKXKWYCk9BLHq5jOJwUGwjQwVplNTobvjgejklqn67+QySCjb8W1jg6BnEGwOedj35cz2rmbgVDvkADvLoHqsh9UonmMyX5shZtwoVMQKiLTn8K1fp3Q/4e1yMRuptq6XCP7qzSnfUKhGM2Fk2oV+DAQEGAfde5bk/iDOCx9RhhTc0TOp112VAOriioz4TscEYhd/u4IoDKnO6DZqUxF8trJEpZwfc4LRy3sPE+bpGGdprDzZ+1XQ7a2m8HNkef8hWDYrpR2Cg7hbWpwdCF6TTbB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8182c362-e25f-4a6e-5b1d-08daee641363
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 14:58:01.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /J7gpCYo6sukuMGNAbjwKAdQDiON+vm3Ps1P2QiASlrdIoRjykhmGDzKKVqePyToXgfoP5EyN9GAA8zBWlRxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=890 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040126
X-Proofpoint-GUID: prv3feRBrPZPgV3RitEXdAleGpoHLd6K
X-Proofpoint-ORIG-GUID: prv3feRBrPZPgV3RitEXdAleGpoHLd6K
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

These have been in nfsd's public for-rc branch for a bit, but it looks
like Mr. Rothwell is not back from holiday yet so the later one ("nfsd:
fix handling...") hasn't made it to linux-next. I'm not sure there's
any sense in waiting more, and it's early in the -rc cycle, so here
they are now.


--- Pull request follows ---

The following changes since commit 75333d48f92256a0dec91dbf07835e804fc411c0=
:

  NFSD: fix use-after-free in __nfs42_ssc_open() (2022-12-14 10:11:54 -0500=
)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.2-2

for you to fetch changes up to cad853374d85fe678d721512cecfabd7636e51f3:

  nfsd: fix handling of readdir in v4root vs. mount upcall timeout (2023-01=
-02 10:45:31 -0500)

----------------------------------------------------------------
nfsd-6.2 fixes:
- Fix a filecache UAF during NFSD shutdown
- Avoid exposing automounted mounts on NFS re-exports

----------------------------------------------------------------
Jeff Layton (2):
      nfsd: shut down the NFSv4 state objects before the filecache
      nfsd: fix handling of readdir in v4root vs. mount upcall timeout

 fs/nfsd/nfs4xdr.c | 11 +++++++++++
 fs/nfsd/nfssvc.c  |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

--
Chuck Lever



