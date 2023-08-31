Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03778EFAA
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbjHaOjs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOjr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 10:39:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3D1B1;
        Thu, 31 Aug 2023 07:39:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDbN0h013051;
        Thu, 31 Aug 2023 14:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=scIzP8ExV27FqYEeFQaHMX6ajptwCTpnUghpfa8GPx8=;
 b=gAoBmtSnvl5FCCOoeds+DQcEhGbp30B65ENArAJ9XYHlNs5Mfda86ihloXTJk76qXvim
 RQvbV8m7i2szTSqLu0ah3XzFSDjQHSm89Qq9nLcM2Qa0M4/0UQCB67FOxNn0dVYV/U+E
 U816KBLoT8S83Qhs4EhpxkS/gjsfQSR2L0QHq1xjufbcGxm7E1ct8qH3I2UbKZej2One
 f5dzMDOC1Hiw5Yjc+YeVvt+6AvBTRWd0WTB53FAFsOGUUddRf7EPb1udIMfk0d9Y0TbP
 b2grmhf/Hd0qN/w1Zk+LbryR4d+E+bQ1fkrC9vO+ijJjVf2BD5gXf+LfBsP+8eS2PCOo +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9p01rrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 14:39:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDPRFV001262;
        Thu, 31 Aug 2023 14:39:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssyw57tua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 14:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6dlja2M2MLS918ag3C9Lzi08wSDtesoVMB4zq6JauWy6lVECS9mWDpGpErAsIvUhc+FXauxJDLO6D582aEvcIftVEekQnA4nYtA46TAMV0b0ngMAxOrIyCCNtVO5fVYSOjTHMzllLc6ZjOme5o9MoI1dhAYD58i/5HoiDnlssONOU8sX7WLeIvLziucCl6OUCtDVN7saT4XdwWuAH/dNlzQk5lABjILN3Hj3wTiHU6e0Ys0CU3XNi4wf8VbNdEuu3B7ZUV+1nKQAEXFmfOSDTqsJzYnkcvH+b4FfEL8rLY16jnBYhh5FSlh8h1NKQpRyLJv0P7+UoENnJleszTdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scIzP8ExV27FqYEeFQaHMX6ajptwCTpnUghpfa8GPx8=;
 b=kYWWx2TS3pb+QoblwyFYmKleN1xLA6a1haPcaq9J3U2LITUIy8R/q5iFlXr4Fh5aRjofXiZhzG6N/dCE9CmPrumc7NGPZDjEPJgzlW5EnIDsTLzIq+HpELuDJ914xdYkBA71VNyKaNWwG3Naq2I3r6Wia+MmlszdyTyD4UZl26jp6KKP/iy1o8UpH5NSE3kAabtvni2sxXJVF5oAJGIslvOw0KJLZqBnQ1b3NI1UEThdwp++rFQJm2LlrLlXr9aGQJnwveLEfV1Z7c6jMPhruN6itX7Oa31APO/TYfPgp4o03/r4PPZt8d4rbGpvjLbZx0nNha7yEExyjs4VXRSyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scIzP8ExV27FqYEeFQaHMX6ajptwCTpnUghpfa8GPx8=;
 b=I9FhTNYvWWfk7pNdQEUefYbNfVQme/ktd/HV4rc6Z0+y3dmXDvrOX+A94XFWM7DgVpulplJCoS12auubTfmNBOgd9Ljm+FWoBPG8cXmpHRy3T3JagBM2/EWVxDQmg8mO8/pmFPTrw7fX9EvJEex/aTWZaDEw0l/3lPlWV+Gce7A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6265.namprd10.prod.outlook.com (2603:10b6:208:3a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 14:39:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 14:39:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd changes for v6.6
Thread-Topic: [GIT PULL] nfsd changes for v6.6
Thread-Index: AQHZ3Bj2ywGOZONAPkmEjeFXMXHkDw==
Date:   Thu, 31 Aug 2023 14:39:35 +0000
Message-ID: <F7285657-5A35-42E0-87B4-1EAEE8DDF618@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6265:EE_
x-ms-office365-filtering-correlation-id: 59f49640-62a0-44f5-ccd2-08dbaa301918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANBYK3I0xVXjMKG2oftIN/yZOiO4lnGxDwA0TqHF5X6IzC/f635xxWVkU1TIXGFnH+jFXvC0PbBgnWJjAvfnzH97JIy8hz9gouo0p9l2+SVyF6oj+8QmLEYpxLaySBRHNdI5nYwnWmolopOJHyDt80CEHv/BYbBT/idjyWHj8nb6goVGAGTTsGQ1PooI3Oh9Bi6QCRCEwpWRCYKJM1ElpzTxLC550SPg7sQGXczHywt4yywDlit+Pbw5kSjpx7JPafIf/+LNWx2n1FJ7vJDNi+tctdKOi/BZ/1hcCNOfAF0WjezLDFwhjJrNh7/Zj3QoNfnhaPOD/cFYDDn8cMfXeTkMmdd4UVlrF1cVp9CI0G5Pr+Nohvp2Q26d7lCU5ppR0z9paaWPJloiYGJ0ijvb6hIACehNqFNpqCqtWjmO8mB6kH4Iw7owbQhdFNKzoS1Ezg58uBSrk2UjzNXHl8fwcitROUD2Uz+1artxSMpZiEmfMqBpats5qFbkWmZEsC7dJaCIK6Q//v7kgmqP6uFSaTk0kwLXYkK6ZLhA+DJXcOciQDMOFb1jfda1n7e9HJYxmPHjx5jawDDbJ7PD3PN7yibiMxREnVI1i41nU+v11oIy+SHEBhzVJI7SdKjYB1T3sUloCAytB2WYcsSCoB4Sdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(71200400001)(966005)(83380400001)(26005)(64756008)(478600001)(91956017)(66446008)(316002)(66556008)(66946007)(8676002)(66476007)(6916009)(41300700001)(8936002)(5660300002)(54906003)(4326008)(2906002)(66574015)(76116006)(36756003)(33656002)(86362001)(2616005)(122000001)(38100700002)(38070700005)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ch4suKmjQsIkVcpfalS2veWiAwXQbMNW+WtkCfXJfUqboIRGL8yKSRum1HQ?=
 =?us-ascii?Q?yJTQW6whsdhXMJFmCT3ee57VfFvEBGSeT0aK2AvxTCAFCpsK9DPr8wBAWgEC?=
 =?us-ascii?Q?6cvwD7/QwkXyxYm21clImOU/sOU+7/X7rzBfltebj280hM1juzwhbyTDQ9co?=
 =?us-ascii?Q?V4TZLy4+Gm18FzcJH162lTE6LBllaiNqqTU0EznItXBMBhDrpbtM0Kz2ybZf?=
 =?us-ascii?Q?ioW3o8dkBVwipaQfxg/YgxlaiGBCUc2zOLdWmYHgdEAT3IC6uBH61IWKAGZV?=
 =?us-ascii?Q?9eGAtdjrrbwTgFFRXdaS3Ep1clM+nEcmDIbmvHngKT0O38o9Wq05ylZKs3gY?=
 =?us-ascii?Q?Dy8e4h5XNKtptfeyfagZSRmTXH7ydsW3tKSv8rym9o2sZplsb7E0neAa56Kz?=
 =?us-ascii?Q?QFZ/GM8R5FME8d0v1XBFkRfKbPRAv2TXl6z1xQAlBcqCrMqvHBKRn/QQhLuf?=
 =?us-ascii?Q?rbJaejqqtwHfdQ/9S3O/2Msp2m59Z1/x9QP490XRk0nF6YUzCNjnr6HV16Dy?=
 =?us-ascii?Q?Wwn2sodDMDqHPidmfUM66OXxOwRrhDzwLXrErmeypSeLcsdtpemIdu4gcpDq?=
 =?us-ascii?Q?GlJuhcw6GxI7WZg356IaRKRwiDeL+FMEybh/6ReTxErl+D5DwDhud6VZET4D?=
 =?us-ascii?Q?CkOV60w/q4+mrzQPWsNfRlf6Ybz+H00I1fi5L0Pbt6DJUhPX2mA6RwXVLgjM?=
 =?us-ascii?Q?cTO2PDAZMOv8rvhxyI0vvKkoNY70Y59P7kHtBxL4YVUUOjsOE7Tu6s4xBMoD?=
 =?us-ascii?Q?cCXsOtXtzTAVWGu8kruBi3ZVyjP7RSSN32csa0tfp92w+RVFgLh+CduEyAYb?=
 =?us-ascii?Q?k8CTKn1RBpBsOpBeAAiqf6zfkwGHpeV3TwqKTwjglJfLnJUc9R4DT5JHN2NF?=
 =?us-ascii?Q?6RyrYaFGbBzVvmFam9CzwqrPjMbw9p0M89zNcKA0o2pj28cl0uw+yCyslkcM?=
 =?us-ascii?Q?+1/JWF3UkVFKP6wP/Zvs6REh57f0XZkAYU2bTxqJA3LFcHhc5RD0wcraWvbz?=
 =?us-ascii?Q?TChkOv7l/iVU2nTJF25JSzSbkUg+8JwfgM10Wvyaf3wmwDcSCA65BDXVd68n?=
 =?us-ascii?Q?2O+hlOG0VBy/vVBO/69OFV1ZDhHh5LWgHxqcCZm4O1HKkzkxQpMQaBYPtHOU?=
 =?us-ascii?Q?cG4rWeplz9zXftrpmeH1VWn6Ghj64eCIflXIGToYlFpcMKBkrf3GqOjCrcsu?=
 =?us-ascii?Q?eFtb4/oDsxGRUdhyUQY3VCQzayAuxiQI/YMKwI5TFNMl6SP0yE+65rcBKE3n?=
 =?us-ascii?Q?zS/3HXFjQWS4+UoPgF311gPo45LEVKN1Ck0hva9/NdHwSVGGWhu1Qj5wJ9d7?=
 =?us-ascii?Q?7CK9nhBRhm33zyq1tDlr9neWOmQFT6rrvNjDRCExp2b+m4bALSyH63Dx8o3v?=
 =?us-ascii?Q?HyJWAJqdkjcYMMRWy3d1kpYfCaXsfaVLdXmPiMXV1oo+RzYSeTjj2j+T0RNs?=
 =?us-ascii?Q?ry6Rrgk5aCpSB8oR9Y/o6+2QVaLqt3fO2hxysfFG58iFKHgu2axPK1HUfrMU?=
 =?us-ascii?Q?WKyLNKQ9eIzSDqhn4BJFxYQEywx6aYeIDghZV8R0eEBHmB0De85isO0iSN66?=
 =?us-ascii?Q?YNAW9d+THbhwe6n3tczPCc12fo6VoHEc2nY2I9j8nLhuQi+t/rG8Oqafz2I0?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6A4173A0962BD4989EE10F9FCEB71D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VbAujkbZNufqtATkuaXbkJsSSIPHtI5GbsnT3VDfnm+ahq7IOma298BEC/5iH6TV92t0ndCv081eGk3MDqMv29pAPUbkEIkJFBDIR75XNDVe+jrwfgLskOB/g82pKaok4OqlyBYetUrtIoHA8/zroI6KvsMJPresH28WbNuWyJT0AAB6GOMsmH9+8RIjAKV7CyecET11jMldwEm8qINcRIdty/CgdAZVuGEs0fJ43gdrLwg7i/TgSGzcLbm7gDeM1VhflV+EOEzzqtQ3NxWjnXsF9qlNO0E3bcBpIAojgY2rBTxhY3J4YxdkS+F9M+Lc9QI5mVoWR+5wYz8q30GzsST36tR77+e9cQ2+idUcl/f50HhjXuVjlRdo3+nWmfdU45oA1AjS0od8PGgjodiwDF57IEQugBoRChwuwh5AfHqaeA6GbClofsGk1n5ynPDzx2CLmHy5lgcs0Su8taEUydF8XYKDhZCAb7h8pB3X0kRXbkFG4cWyC4jTj267Hmx4WYtdqx1vtVspB8Ry41zeNSzsbpP8cZ9jZzcHW6lMz7E6EFVGNT2hdad/i6Ef1J0lEuWfs5qHA+gfvWM8SMG8xBapMekIsj12O15IPJoIwPXpOxkctCYsCt5/ibpY9kmarCTLnAOBWyCfK0B0Rd9+lQbHOh+mv2o01GCA4DkTibBGvbYWOqRkEvUIrR8ss5uyT9qNUaPWwx2lpOEfmnwJwzVMgE5aUeJ2c7a9A7KcHy3ohT2xELo5xofOpqajFQ2sb+0obZmL+kJTU2ZjKU8EBkQsPd7SnK/vHiR1EF2N7fyGZnBKoEe5Syi4+pNmj6lNhLfJqEBE7VfDEPDnRoN6fegRFePyLL7BeFyg+TmiRZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f49640-62a0-44f5-ccd2-08dbaa301918
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 14:39:35.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpRUgWYcePEGdOzcIJ62UHPpNNzEe+tF8bswb6+jQ+tE0mt+E+glGyayRGXosvPAcTExGpW0aoMUokPgxpIQfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_12,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=815
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310131
X-Proofpoint-ORIG-GUID: xBn1-bkB3REo_XsfagEmZA4Qugrw5cuf
X-Proofpoint-GUID: xBn1-bkB3REo_XsfagEmZA4Qugrw5cuf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Linus-

Aside from observing the significant substance of this PR, one
housekeeping item of note is the first commit in the series,
which is a second fix for c96e2a695e00 ("sunrpc: set the
bv_offset of first bvec in svc_tcp_sendmsg").

The bug was reported during -rc7 and the test results became
available only after the v6.6 merge window opened. Thus I have
rebased the nfsd v6.6 PR on that fix so it can be backported
swiftly and easily to v6.5.y. The reporter has confirmed that
both this small fix and the more significant related changes
in v6.6 do not trigger his qcow2 direct I/O reproducer.

Many and great thanks to all contributors and testers for this
release of nfsd.


-- Pull Request follows --

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c=
:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.6

for you to fetch changes up to b38a6023da6a12b561f0421c6a5a1f7624a1529c:

  Documentation: Add missing documentation for EXPORT_OP flags (2023-08-29 =
17:45:22 -0400)

----------------------------------------------------------------
NFSD 6.6 Release Notes

I'm thrilled to announce that the Linux in-kernel NFS server now
offers NFSv4 write delegations. A write delegation enables a client
to cache data and metadata for a single file more aggressively,
reducing network round trips and server workload. Many thanks to Dai
Ngo for contributing this facility, and to Jeff Layton and Neil
Brown for reviewing and testing it.

This release also sees the removal of all support for DES- and
triple-DES-based Kerberos encryption types in the kernel's SunRPC
implementation. These encryption types have been deprecated by the
Internet community for years and are considered insecure. This
change affects both the in-kernel NFS client and server.

The server's UDP and TCP socket transports have now fully adopted
David Howells' new bio_vec iterator so that no more than one
sendmsg() call is needed to transmit each RPC message. In
particular, this helps kTLS optimize record boundaries when sending
RPC-with-TLS replies, and it takes the server a baby step closer to
handling file I/O via folios.

We've begun work on overhauling the SunRPC thread scheduler to
remove a costly linked-list walk when looking for an idle RPC
service thread to wake. The pre-requisites are included in this
release. Thanks to Neil Brown for his ongoing work on this
improvement.

----------------------------------------------------------------
Alexander Aring (1):
      lockd: nlm_blocked list race fixes

Chuck Lever (30):
      SUNRPC: Fix the recent bv_offset fix
      NFSD: Report zero space limit for write delegations
      SUNRPC: Remove RPCSEC_GSS_KRB5_ENCTYPES_DES
      SUNRPC: Remove Kunit tests for the DES3 encryption type
      SUNRPC: Remove DES and DES3 enctypes from the supported enctypes list
      SUNRPC: Remove code behind CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED
      SUNRPC: Remove krb5_derive_key_v1()
      SUNRPC: Remove gss_import_v1_context()
      SUNRPC: Remove CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM
      SUNRPC: Remove the ->import_ctx method
      SUNRPC: Remove net/sunrpc/auth_gss/gss_krb5_seqnum.c
      NFSD: Refactor nfsd_reply_cache_free_locked()
      NFSD: Rename nfsd_reply_cache_alloc()
      NFSD: Replace nfsd_prune_bucket()
      NFSD: Refactor the duplicate reply cache shrinker
      NFSD: Remove svc_rqst::rq_cacherep
      NFSD: Rename struct svc_cacherep
      SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
      SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
      SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array
      SUNRPC: Revert e0a912e8ddba
      SUNRPC: Reduce thread wake-up rate when receiving large RPC messages
      SUNRPC: change svc_xprt::xpt_flags bits to enum
      SUNRPC: Add enum svc_auth_status
      SUNRPC: Move trace_svc_xprt_enqueue
      SUNRPC: Deduplicate thread wake-up code
      SUNRPC: Count ingress RPC messages per svc_pool
      SUNRPC: Clean up svc_set_num_threads
      NFSD: da_addr_body field missing in some GETDEVICEINFO replies
      Documentation: Add missing documentation for EXPORT_OP flags

Dai Ngo (3):
      locks: allow support for write delegation
      NFSD: handle GETATTR conflict with write delegation
      NFSD: Enable write delegation support

Jeff Layton (5):
      nfsd: add a MODULE_DESCRIPTION
      nfsd: handle failure to collect pre/post-op attrs more sanely
      nfsd: remove unsafe BUG_ON from set_change_info
      nfsd: set missing after_change as before_change + 1
      nfsd: inherit required unset default acls from effective set

NeilBrown (12):
      lockd: remove SIGKILL handling
      nfsd: don't allow nfsd threads to be signalled.
      nfsd: Simplify code around svc_exit_thread() call in nfsd()
      nfsd: separate nfsd_last_thread() from nfsd_put()
      SUNRPC: call svc_process() from svc_recv().
      SUNRPC: change svc_recv() to return void.
      SUNRPC: remove timeout arg from svc_recv()
      SUNRPC: change cache_head.flags bits to enum
      SUNRPC: change svc_pool::sp_flags bits to enum
      SUNRPC: change svc_rqst::rq_flags bits to enum
      SUNRPC: make rqst_should_sleep() idempotent()
      SUNRPC: Remove return value of svc_pool_wake_idle_thread()

Su Hui (1):
      fs: lockd: avoid possible wrong NULL parameter

Yue Haibing (2):
      SUNRPC: Remove unused declarations
      SUNRPC: Remove unused declaration rpc_modcount()

YueHaibing (1):
      sunrpc: Remove unused extern declarations

Zhu Wang (1):
      exportfs: remove kernel-doc warnings in exportfs

 Documentation/filesystems/nfs/exporting.rst |  26 +++++++++
 fs/exportfs/expfs.c                         |   1 +
 fs/lockd/mon.c                              |   3 +
 fs/lockd/svc.c                              |  52 ++++-------------
 fs/lockd/svclock.c                          |  18 +++++-
 fs/locks.c                                  |   7 ---
 fs/nfs/callback.c                           |  23 ++------
 fs/nfsd/blocklayoutxdr.c                    |   9 +++
 fs/nfsd/cache.h                             |   8 ++-
 fs/nfsd/flexfilelayoutxdr.c                 |   9 +++
 fs/nfsd/nfs3proc.c                          |   4 +-
 fs/nfsd/nfs4acl.c                           |  34 +++++++++--
 fs/nfsd/nfs4proc.c                          |  51 ++++++++++++++---
 fs/nfsd/nfs4state.c                         | 162 ++++++++++++++++++++++++=
+++++++++++++++++++++-------
 fs/nfsd/nfs4xdr.c                           |  39 +++++++------
 fs/nfsd/nfscache.c                          | 206 ++++++++++++++++++++++++=
++++++++++++++++++------------------------
 fs/nfsd/nfsctl.c                            |   1 +
 fs/nfsd/nfsd.h                              |   7 ++-
 fs/nfsd/nfsfh.c                             |  26 +++++----
 fs/nfsd/nfsfh.h                             |   6 +-
 fs/nfsd/nfssvc.c                            | 111 +++++++++---------------=
------------
 fs/nfsd/state.h                             |   3 +
 fs/nfsd/stats.c                             |   2 +
 fs/nfsd/stats.h                             |   7 +++
 fs/nfsd/trace.h                             |  27 ++++++++-
 fs/nfsd/vfs.c                               |  52 +++++++++++------
 fs/nfsd/xdr4.h                              |  11 ----
 include/linux/lockd/lockd.h                 |   4 +-
 include/linux/sunrpc/cache.h                |  12 ++--
 include/linux/sunrpc/stats.h                |  23 +++-----
 include/linux/sunrpc/svc.h                  |  52 ++++++++---------
 include/linux/sunrpc/svc_xprt.h             |  38 +++++++------
 include/linux/sunrpc/svcauth.h              |  53 ++++++++---------
 include/linux/sunrpc/svcsock.h              |   9 +--
 include/linux/sunrpc/xdr.h                  |   2 +
 include/trace/events/sunrpc.h               |  80 ++++++++++++++++--------=
--
 net/sunrpc/.kunitconfig                     |   1 -
 net/sunrpc/Kconfig                          |  35 ------------
 net/sunrpc/auth_gss/Makefile                |   2 +-
 net/sunrpc/auth_gss/gss_krb5_internal.h     |  23 --------
 net/sunrpc/auth_gss/gss_krb5_keys.c         |  84 ------------------------=
---
 net/sunrpc/auth_gss/gss_krb5_mech.c         | 257 +-----------------------=
----------------------------------------------------------
 net/sunrpc/auth_gss/gss_krb5_seal.c         |  69 ----------------------
 net/sunrpc/auth_gss/gss_krb5_seqnum.c       | 106 ------------------------=
----------
 net/sunrpc/auth_gss/gss_krb5_test.c         | 196 ------------------------=
---------------------------------------
 net/sunrpc/auth_gss/gss_krb5_unseal.c       |  77 ------------------------=
-
 net/sunrpc/auth_gss/gss_krb5_wrap.c         | 287 ------------------------=
--------------------------------------------------------------------
 net/sunrpc/auth_gss/svcauth_gss.c           |   7 +--
 net/sunrpc/svc.c                            |  97 +++++++++++++++++++-----=
-------
 net/sunrpc/svc_xprt.c                       | 126 +++++++++++++++---------=
----------------
 net/sunrpc/svcauth.c                        |  35 ++++++++++--
 net/sunrpc/svcauth_unix.c                   |   9 ++-
 net/sunrpc/svcsock.c                        | 131 +++++++++++++++++++-----=
------------------
 net/sunrpc/xdr.c                            |  50 ++++++++++++++++
 54 files changed, 970 insertions(+), 1800 deletions(-)
 delete mode 100644 net/sunrpc/auth_gss/gss_krb5_seqnum.c

--
Chuck Lever


