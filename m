Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85E4A75F4
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 17:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiBBQc2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 11:32:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29656 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231175AbiBBQc1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 11:32:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212GT5S1028331;
        Wed, 2 Feb 2022 16:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vifvIlqRS+989nykL3M6bVi5k+vuGGqltF4bbdeGAks=;
 b=JsB0W09TI+o8T5+R4NLQ8DHyM/qQHlLuEVNXhBiK7IE3kNT1jBrjHnyIyOV8vkal432b
 BfPceiMZgUWACsuhR5kf/QoZInELCEFZmtpZAET+odxPZtgyY7lX0pmRD4jPqA1lMMfp
 W+idVkk5Hnn0aA4jZRJacY/WO7lgUJPUbenbF06n+nGmWC2paczQZGuhkYVId65FO8KK
 Z71IAEKq8M6mAj3K1q3mcrl4hcGEAipMwBuzexnzvqf+yYWVn44w4bfI2B0YiUgi6ms3
 f76F/smRKmrGW4B1j55NgO4CIaDZBMag6e8Qxjxf+Z0l0f/vhOmbAeSP1C3cbYdcBHpS Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fxm5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 16:32:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212GFRUO131049;
        Wed, 2 Feb 2022 16:32:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3030.oracle.com with ESMTP id 3dvtq314du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 16:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZI9so/uGCb6+J9ngQgu7aOxvQJWenj+leAI7QKXb4+SWdSfHcNnlcOceqmG9Wu8jTEgU4iezacn2SXCboKSfQQmPLiH6gbECcPeFcxA+rQ3YXhra0pl4rOE9Fz16R/jMhrhyKAy1myKSk7Ij6qy2t63qmKrzkghoG+W7GF/qVSJ+7fGu5xp7ELuCbh6LGykLL10xAgy+acrbpgGKfWMORVT7TenwsVFVrQRJIQ4lrnZI8EkNQ8Tou/GLqB6BP+AaMVbLAMKp43lw8yTvJwRC2jmfNY9ovK5lRdRZxkd9SW6LWOU8pxW5Ncwkm+hVre/zEial9QB1IZsLfiokPGZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vifvIlqRS+989nykL3M6bVi5k+vuGGqltF4bbdeGAks=;
 b=bUXV6niibwFf/0dgxjt5wnTxY8L+Ytept9iC6w+4aHGzzRyyyGW90vHO1niZXAoKILmOr1qyoqQc/HTE+3LkZg+i38vVSRh1PQL2wrMtb0rzO30HrLnjOg+p+40ILsfpUVVAMqMxZ9xb0Jlx3O3Ex4TDyKJbQ63AoAoctWMXgKtxYafVnBLKx/2271UxyAygeLy2gdXam7oeRgNfkc3B1mqVXS091yt1l18+/2ut6Sjnm7617Yv/G1LMx0hCrDkbYBFtTR+WQovT/bBTiIqb9D1la/KL9I/cI8XiXw88rJfgqKHsNbPaXdibUdQ/Q+3gjglj3OtLgMWzC70mqTfzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vifvIlqRS+989nykL3M6bVi5k+vuGGqltF4bbdeGAks=;
 b=pZ5nFRpivyTJ3xu0enoo2FWw72e/jaqD5SCh6mruQo2vLPLXC2eUyqHcdamtxsKPD/ejtbr6YQFhWkR5eiO6vZOdzDMFciujEB/SrjoguXWbsWlCc3EfW8PngxjjPN54HagQko05qgQkumrqjESgKcQ9g6zRJNgWNnL1roQcmO4=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM5PR1001MB2155.namprd10.prod.outlook.com (2603:10b6:4:2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Wed, 2 Feb
 2022 16:32:23 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 16:32:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] nfsd changes for 5.17-rc
Thread-Topic: [GIT PULL] nfsd changes for 5.17-rc
Thread-Index: AQHYGFJ0guBH5Q3JuEqJoq44X7pK9A==
Date:   Wed, 2 Feb 2022 16:32:22 +0000
Message-ID: <F1000CFA-4575-4BBA-8640-4BF09A3F0811@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74130e02-477f-43b2-a516-08d9e669970f
x-ms-traffictypediagnostic: DM5PR1001MB2155:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB21557861AC05723F8D11601D93279@DM5PR1001MB2155.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FTiZy6ojPpnNJojT289d7AKc8jf9cdDUuAyXLqtm7m3Xed+W3AqmsOrBlNKxPaT8Ui67rW6iH1YuHhgNibkZAOkPonAu7szvB0QQ+sMGZqmafOj2EhqXjcJDgrPtb/zeAxKlQe8PoJ1pfv5vpQRHt64cmXhQCU56YrDBn8L+r4j32p42s1KM77oYxd39Gt2nt5ZwANPvpTarqVytIKGPW5hb9/AQUrKMz3w3NJ20b4iDa4O6YYNhTWVRuPTELEgyCMXiqzmFJl9Ub7HvEr5YeOAWmBS6RiWRpnHHs/vJREDqaCTdQ/D1vahbMM8RX3GrqlvnN0ZgmzWBG1xP1BtbPLlyk6ptZeOOZh28fb+jeMZR89/jqiK7PXEe/XE0Jm8CJ/6yz5yBtxMuBKe6d2hermIlTs1m7AhMqBYTz/Vht7gqvIQjvbDq0sv6h4ctnYOqY5U8hyAnOqJZOWK4lisi+YwmB4Mg7Py5mXtjq2jcbEaQ/PwMLzbqS57Hjhs52DKHao7K4I00X6OykDkEKvC2V3PihyCYZ7CNX9Ikgdv9ZRpPUHf2c0Jmhqak/q5zw1xAYPuwdRY8/poJlUzA4F9wrJiiZ1/JFqLNHaK5w0LuRCqGWy4zG+PwAPYCFX3a0nI0uwJ+DMBs8cDTA6xsf6zo0vjSbFHIhh3MKEhPXGfpT7PtMoMBXRh+vRoGczv/CFht/+tmcp1cguel5YlcnEuS6GnklDOjvnCeu1B6F+qaZqov05/eZMbUNEiDLv5rauwU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6486002)(71200400001)(66476007)(6506007)(66446008)(64756008)(66556008)(508600001)(36756003)(66946007)(6512007)(54906003)(38070700005)(26005)(2906002)(33656002)(186003)(4326008)(38100700002)(83380400001)(6916009)(122000001)(5660300002)(8936002)(8676002)(76116006)(316002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GKQh+veGRz5wnaa/v2MD2KO3pHMjNEF6/lZZ9nH+xkE9tp6BG30K2PA7kEsd?=
 =?us-ascii?Q?UGMNFgZMiuIlY0G/Yx0WRj5xIcjrvgh2qy4luMKplWMMQvU072FoiHH44rEQ?=
 =?us-ascii?Q?4TC2LAvqWyfgMfYF0nDMZWJKttVSzImijRpLk2c7biqDm6Ka0Ud6JtA2L5uC?=
 =?us-ascii?Q?2syAOVI4WO2wYU47d9B2gf5tkOMqyWILk8MrUQ7wQwLV5Y/jv5TdaXUf9MgF?=
 =?us-ascii?Q?wxHYOKAs8BA9D7LV3gYgFEgfwW+PzTenRmcwjR6mnU21Zo7rAd2wcpCRvHss?=
 =?us-ascii?Q?aNs+a+A5v9nItjrZqWjjjcTjOfxJ0jagvNVlXx7ma2tRyfv59PQUYtLaiq+C?=
 =?us-ascii?Q?QvKvM/W2TH+LvDImgSoHKl0aNSADJmZlKdeCDnAybXpqkc4NWhCM9+TeF2rG?=
 =?us-ascii?Q?qaewj+2UYyuwMQafNls8Vxm9Y6wg71vS+aLofxhWhtmuvxO5rxiesuaEe5wB?=
 =?us-ascii?Q?1eeoU+6dRcNS6qdD4vitYiS9+yTItJLJdvBxm6A6O+qmPQXuEUshramnfLGi?=
 =?us-ascii?Q?A5218ASGb6Rha7PgFugJG1mIW86tuIv3a5FqtddA8dxn6veRfH3wzlBOhPOn?=
 =?us-ascii?Q?/7thGCahGUlo+WDtXXiRk26XgLd+5zoLQbI0b8QaN52B9c47wcpC0qS/M2FL?=
 =?us-ascii?Q?AD5sdUK2Bl8a+viqvPfk5mFetYaVSj64Tccx745a6W6x0/bCTdenGA+rk1m0?=
 =?us-ascii?Q?J0/ks50pl75+tf/HpbP0IbvkZUhyvtWOAtSxWeqkb1JkWIRvCoLRd/kEhHQI?=
 =?us-ascii?Q?o8M8G1ECHwBA9SfqWWy7JYojgl0ERcR3tFgcd5aYG+3HzlnxK3cPbE+x5tXM?=
 =?us-ascii?Q?TVPlXJHVOK9VuBSQtfpWOk8AfKAJm54SJOYnKS1VOM4H4fkYYRcPpS0h0PEY?=
 =?us-ascii?Q?t/ON1WlazVW5MwIiR0Loxpt/yFBJ4V6USad0tVAJTk2zAtvZ3+UEo8a2ChO/?=
 =?us-ascii?Q?QzAkA39XctrjYmhzRQCMYBvmcMT3DA4Jw4XOU0/VGqHpWrj7R22/c/+rgFiq?=
 =?us-ascii?Q?RNAc9z/g9cyveEsz6UGAkxf3fQ477/nmCWCQS0pMWR3HR5NwweeG9hgcnkmg?=
 =?us-ascii?Q?p/Fql4tamAXG+L4xeopyCiyR2qBOlqGWQ6QTlCHOrRgAAVYYVbCp8H03ZPrq?=
 =?us-ascii?Q?jAc+OEX6ElLZ/XoTXSzPuhdY7ZWxxn4/zT8T4flJdMKBIh12mEBH46EUsCBg?=
 =?us-ascii?Q?L6ny9G6Ijk1MQ5HOUrV/VMvF8c86Gdsj9hrMhfbUTNphq7Uj7LBUusuMuxWZ?=
 =?us-ascii?Q?5SE21IYmBbAKffPNYw3fIUqvaM0PziY4o5CrtlFvcQDvpX96u/aCz22kOMNs?=
 =?us-ascii?Q?FEaYxX6L+wwYJcl2XDJefX3KgG4glBQJYPQh+pkDRYbgpoSKDGkMTu+qjKGs?=
 =?us-ascii?Q?/HJ7sv5ZH6iIVur2X083HwCt/5UPuGohbTRvOM2zsP3PMeVf2AXRWDq58mwe?=
 =?us-ascii?Q?a2bt2d6LYDvEfS8cd4gVR2XO23zp06yPHXfUlUJtQIYUd9h1sISoM1ZiWkxm?=
 =?us-ascii?Q?qOuKPgNTBYJKlHpG9bPfuvw+LoBBTMJaBOOPUKiWKkJL+SNTlJRLWx8mP83A?=
 =?us-ascii?Q?sUNPwoIWUGP3w1EEmCnNuJnpmkcQRvGeBeQuc+DqLZws2UwMcP+QNieDmbYp?=
 =?us-ascii?Q?7KgZbGmfDjyrmyW5Q7wgNJY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52128F10354C5441AD6D1DDFD209529E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74130e02-477f-43b2-a516-08d9e669970f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 16:32:22.9350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vu+bqo+FpXFHCGKjb9vJLqIFQKPgxeeGyDg2uGHbOeeQ3rw4iborDp6oiSReqJX9fQ0cSQbJ13tD7uWK+wt3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2155
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020091
X-Proofpoint-GUID: dn8-BRS79IZS_t-Gdv26fdsKb9B9Z2HV
X-Proofpoint-ORIG-GUID: dn8-BRS79IZS_t-Gdv26fdsKb9B9Z2HV
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus -

The following changes since commit 16720861675393a35974532b3c837d9fd7bfe08c=
:

  SUNRPC: Fix sockaddr handling in svcsock_accept_class trace points (2022-=
01-10 10:57:34 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
7-1

for you to fetch changes up to ab451ea952fe9d7afefae55ddb28943a148247fe:

  nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client. (202=
2-01-28 09:04:00 -0500)

----------------------------------------------------------------
Notable bug fixes:
- Ensure SM_NOTIFY doesn't crash the NFS server host
- Ensure NLM locks are cleaned up after client reboot
- Fix a leak of internal NFSv4 lease information

----------------------------------------------------------------
Dai Ngo (1):
      nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client.

J. Bruce Fields (2):
      lockd: fix server crash on reboot of client holding lock
      lockd: fix failure to cleanup client locks

 fs/lockd/svcsubs.c  | 18 ++++++++++--------
 fs/nfsd/nfs4state.c |  4 +++-
 2 files changed, 13 insertions(+), 9 deletions(-)

--
Chuck Lever



