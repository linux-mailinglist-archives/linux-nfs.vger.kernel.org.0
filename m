Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D15F85B9
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Oct 2022 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJHPIL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Oct 2022 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJHPIK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 8 Oct 2022 11:08:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB76326E6;
        Sat,  8 Oct 2022 08:08:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 298EVgel024616;
        Sat, 8 Oct 2022 15:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9c7AYKWiZm534g03fytK57tc4KXztWc2NrLsV9r1xAw=;
 b=Mfg7NpjOcPuSqXlu692wbVVAoYYvKD/80ePHMNgbZDGnEY0QceuQjMjFTxEno4pYEhnX
 VigWWsp2QltrBb1tsEvfQwp0XSW1JdbKy/valFZo1uUF1iz+WINIDaXY7F+9hsWdDt7F
 h5wW5AENcCPEdejsiM8CtEj9xo9hxtKp3Rsw3b4oa/3NHknJGETacCsrgd+P+NzrYv3r
 9+W0oaq3CftVj/jidseJVy/5ZKdN+bhrQ19yaOqGO+54WSg7+VJRVhUea9p+Hgkwogj0
 +mnuPKtYGumuInMjJ9ScSuKOA6ynOATENjuC7f6w949RRvbRoktTj9gj1P+/e3DgYy4n gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2ymcrm5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 15:08:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2988iqOi022128;
        Sat, 8 Oct 2022 15:08:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn89dda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 15:08:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzzRcYWDJhe5bR4D4uKyFhjbv6FPMg9cfGotYv2g0V5VcELfx7xkzMrPrOpSRIVccmu39KPAEEDkyvp/Sq6I0BZbK/AIKKjperMgMNf+O49Xf02rYu34cGKIBUJcqH1mYQEnYf5yv4pfFPMoMWiM1uRaPTpX2qa6nBS+IYcWXC8Qfnbj60qgEv3vraFe5/Dr4z0tw2wDfL2Yz+kG+T4ZDpr5xswbsuJRipo6LBOUG5sKU53Upl+U/rAPHzvuNGWWUiLe6AEdoYcC1BQflA3sVLboJZfi6C6f3FSFlMJu3a54tDFu32o1PsFaOv0TQYQOtwRdnp3e6VBuR63keJG60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c7AYKWiZm534g03fytK57tc4KXztWc2NrLsV9r1xAw=;
 b=Q4yB/GJk8T03nIvD8IPpMhLaPoM3WDu65J8N7OzKyISTONIokemvs8cPMU/gFo4TpJhGu3OvhTNA2zdBq8hO6HG6xnZHxHDY9CUNZu8dti1S5qRvaVVk3MSvtC/aYBuZ36F4Emyz8BkaVwcsMGVbCKSVesqQGykkJMcxtEwiebtzWUTbETFs74AWPfXdx25SN+qR9oEl9rzOob6VYgJV87QueNwbPc3ZIDKqC/YDXafpTH5BsIu8b2yhgMMlOWFq4YVVIAkf3Etn2rx3qcLllyV2rPZlkYpYifZ/eEMDaCTcmwfTZ0SIj+mpXB0nJGyFYScDXNf3BbTcfGM910Vflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c7AYKWiZm534g03fytK57tc4KXztWc2NrLsV9r1xAw=;
 b=rwM2dkBucSjAeQvRLeHqerGJYJXu9eu7KJEacEQLofFLiUiBqEtbX/0His+ktpvdQNJcFa0Fps1Yzyj+3uIYmsILL/VdKUjW4hfq9B4fX7oALU6TbHKtFjsT9TBhMR0FnvCozHEYwqknX4NX+HgzzKG17KyqTHPUi64QoB1EoB0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 15:08:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 15:08:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: [GIT PULL] Additional NFSD changes for 6.1
Thread-Topic: [GIT PULL] Additional NFSD changes for 6.1
Thread-Index: AQHY2yfC59Rd29ILV06wKnfQwt8HWw==
Date:   Sat, 8 Oct 2022 15:08:01 +0000
Message-ID: <F578CDD7-B188-4A5A-A2BC-20FA40759862@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4308:EE_
x-ms-office365-filtering-correlation-id: be74457e-e472-42d8-c274-08daa93ee4d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mRVaCXsC2tSmEvxIxMV6ByFjID6Cz0EvsWf4KoaLftd3s1ew1jP7kPW1bAHkrA7jffHYomiCVb5kgbrqTfiT1UGpIyPwpk++DR++gpzlx/HoSM5dTwU9mCylCS7tRp1bLFoFE+4NXaG35Ke6005fF8z7PZiVzDSOBDhk6/rxxZqEQH1NaKdX++jhViIF/n+khcHW5VWJuQoPnjU5SVndDwCPb/88dW2EhRNpi6XQrCXAhgc7ng+uixigfA1yJ0Y19jVLbWc8dhmm21i3YZLyMc87J4MA/bmo012mV2M6I95dDTGgx9oKQEILA5pptVjMif87Ye9tPXBI0J/Zcail+5LljmnRZzUp/olav0E9NINqRtRi8/3nWQ/8WFRboY/WTXT0BnfI6EV6p6AJy+QEPCmtIMcpB1zbCArHKmVBAeFEFwYAV7a86EwMaysCssbw5vwRkc4K3vpNLsUe0d9lHXGfXnSWPIoiW0rs7X9fr08wixQwCcduRfOskVO3q/NMXWmG3ZDrU1b7eJzX6ebrDyWW/KTPgj58lxVETh86o/ztn/P3EAWzdAY0zZcLe3mU/+vvj5o7G/NbJYOCEFnXlHlqTRRu/RXEyOGAH8zKK/LP4a+kO2ItR3W4qRdYPETeiJNmTtvm5LeJnwzKEALubj3OLQOx0PBXY7MBXxVcvuCjlxiKxJWTrWnySv5Dtxc7fbjs0RGfntiVnsWznAWottpdrbPKQcdTgcAPPaZc7yxSpxc1CCQdYiuvFHdfGWYPXatS/mSen2zJLQA2oF8APPhntkY6RX7H4x8vxMFBrSRQe1m25syxaRE4VttTT8bAvkkLcdznohpLxqB0fJSRGD9JbwEuY14Z0vkRftTOlRzbp6I23P9cu449Hy5coTi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(186003)(83380400001)(478600001)(86362001)(6486002)(6506007)(71200400001)(6512007)(26005)(2616005)(966005)(6916009)(54906003)(38100700002)(38070700005)(316002)(4326008)(91956017)(66476007)(66556008)(64756008)(66946007)(66446008)(2906002)(76116006)(8676002)(36756003)(33656002)(122000001)(41300700001)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xHNa7qjeyGPq4fyebI8K++k4AJgoiphGQgunn/NuwruLbXlvPZSH8H9z+Atg?=
 =?us-ascii?Q?bWVXJFW8KCo/B8frZgY/cLQN4CauQlKkmjV7x6Moj1QBgetusEB7itYGcjDk?=
 =?us-ascii?Q?V7IG/OsJ1qpXXjs8OR4Xe04BhpBBvE6oZRjHyKz9VT8jOPmTYH6RI7PsAfRq?=
 =?us-ascii?Q?fTLea+WPz3jnyZNnlznxx1Hotc8+z/APJzR4UoXy3UDtj15GolVT9DDohrj+?=
 =?us-ascii?Q?Twp/SGswBEj+mcyI7qVbKBzYShf4ouRt18kKwvmVr8FFhYarUIakVRvIhsCJ?=
 =?us-ascii?Q?bhIrzDZaHam/JT6uxv+T2nOA9eUZShOdU0fx8/qN/ErS+HSb2A6RjAB2jt5K?=
 =?us-ascii?Q?wHTCORtbVLovSn8NFdaXPpe+/2SPEesyGhCNZMvGeaZRuDl017mItwUAEHsW?=
 =?us-ascii?Q?H/v/GDiKFBtWEZMbSOvgnV6gkh5pgLb+LG5PrEdp1/znCY51B0nNhi+j1T+F?=
 =?us-ascii?Q?D3n4wzIo6NxcrSw3xuKZ3hwVkHAmtRwMxP7/AGgteVkORJxPq7OWj8tNod9f?=
 =?us-ascii?Q?hoGRXdaLzVkBTf1lFwb4oB7jTBSIoM4LTYfgdz5fZPGUaxAVeVEtOY0XjQOd?=
 =?us-ascii?Q?9OcWWHJrjM+y4ePH4euMDY+l3lMuI4cBvhUqUVhqViHmMgwgK0ECmWdTjpGL?=
 =?us-ascii?Q?THsDQsGjA8pc0elkQNl9eIfkcwaB1kqg+ouisE+eLypJM+yETiRZZtmkISks?=
 =?us-ascii?Q?PWz2d4AwcWXjzoke0t8nk5BvCMB8L4d2qi5izgLD23eusMK9xcZV5E0ON4fq?=
 =?us-ascii?Q?cxnzugvSKCXqwnRVLKioNIWIBr47UsFePgfhVZfPsWj1UhaSx5dBpKK4z34i?=
 =?us-ascii?Q?tZ+ihBWsiej5Le3/FMFoFs6tIRRVimBz28hjyW/XEerH6w6IYjc1xu+ovy8U?=
 =?us-ascii?Q?Zp/EC8KybRmVXXTsteZuEBtcBNDYUStKBkUeqvAye5E3fpk0tbaVKC2DHtrQ?=
 =?us-ascii?Q?XrzV71N8f6yRsH6hLJ/zhPpmUTu2JBjInsMi+KhFJzoIJnOrjY/UXiYwGqEq?=
 =?us-ascii?Q?+/2vaNC0batAll9oRu3cWVKMaaE012nH4kBzoP+20n/TuBQfasDk1odMsweL?=
 =?us-ascii?Q?hIwXlc8NLU3y77AtfAglfZGFfdVKwK4kzO2P8O/mBubdUVHfZUt4K5bQRkxd?=
 =?us-ascii?Q?o9CLKgBHLtBoTCo8OVwvhMfFTyEYWJmSf9bh3UzM2s7qW1vRi9KTr2xStOAe?=
 =?us-ascii?Q?WlXFDGjtUGT6snzBeEq2Gk9pKgP7Du/b2Ys4qn7KAjRypthKQ5kV+pEO2D5I?=
 =?us-ascii?Q?5YpRdsIpoG3VRhIxcuSSPaya7CPwU5LfBjK8+pGTi9OrWhA4oZZY9L2TxrEP?=
 =?us-ascii?Q?Lwjn4GY97P4D37dP8/01+7LKQptYh4LEQX5YPxyIdDimZ1suqbX3hUDAZzS9?=
 =?us-ascii?Q?qNI4bJA7t7iuZxzVSmZoDVs4GLm21pfHWYxukHLnSHgnTgb33pslLgxhA/vo?=
 =?us-ascii?Q?6fthGUJVmxJ/JhBYjcoy4qm90qJbHgTzOzPzRrM0xzEHQp9+5p+NJs4l+GWI?=
 =?us-ascii?Q?4m+zXXcpG6t49dEITxU0A53gNMxVIuI6SyvPHVaGFJmmSWJ/fpLfyXlDweaB?=
 =?us-ascii?Q?VOS3VsX2XYmYXve1qi2LxpzzEhnsMGv+5OuqTieOcmc6t/Sik9EdBowirP3c?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC5C3BB5815F39428B1385B95C1C01D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be74457e-e472-42d8-c274-08daa93ee4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 15:08:01.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgb/QHUydSAjrU2WA2xAGfPxJ513MYqiOidvXsAOVjlVNG83R47r3VW04e+Q1SmBRFh7rW7LzkO39fu436lVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080098
X-Proofpoint-GUID: iFwRY6rENKMz932zytyayk4lFXSDFjyG
X-Proofpoint-ORIG-GUID: iFwRY6rENKMz932zytyayk4lFXSDFjyG
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

Here are two patches that prepare the way for addressing

  https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394


----- Pull request follows ----

The following changes since commit 895ddf5ed4c54ea9e3533606d7a8b4e4f27f95ef=
:

  nfsd: extra checks when freeing delegation stateids (2022-09-26 14:50:58 =
-0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.1-1

for you to fetch changes up to 243a5263014a30436c93ed3f1f864c1da845455e:

  nfsd: rework hashtable handling in nfsd_do_file_acquire (2022-10-05 10:57=
:48 -0400)

----------------------------------------------------------------
Follow-up:
- filecache code clean-ups

----------------------------------------------------------------
Jeff Layton (2):
      nfsd: fix nfsd_file_unhash_and_dispose
      nfsd: rework hashtable handling in nfsd_do_file_acquire

 fs/nfsd/filecache.c | 88 +++++++++++++++++++++++++++++--------------------=
---------------------------------------
 1 file changed, 29 insertions(+), 59 deletions(-)

--
Chuck Lever



