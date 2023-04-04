Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DD6D6498
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjDDOEj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjDDOEh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 10:04:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9B81734;
        Tue,  4 Apr 2023 07:04:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DuNml014927;
        Tue, 4 Apr 2023 14:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BVwJwls8fWGMomXsm+C04sDXrxq/39XoDTBflUYSMvA=;
 b=ETulHMPnp97P2ilEU5B0NjKik+arbGmKvJ2AoJXE1I4d+aobTmlu2ZdOTEnVQnn+2GKj
 guq2IcKY5B9g4cNhMDYIgGB2MUrJD8kt2lT3M07jP/IE6+OgAHlzc3Yv248vxR51DjoO
 nfjA+qnUfsAfiq3Pv8kxttiXGH8tjy7Hu/AFLj7jL2bxIr0pYYGvZbCnFa52PhVTfFPl
 PTythf+CvyDf/d2VD2+TQXn/FZHFcTVcX0+DcsILyLL5Y6RLd5AoV8uFOxx1kB//hs5G
 /GIxDXX5spJ27TxaRJxekVPOm7oBSpoQKlXfoT1Ahn6OTI9O8rBmIc7w/KV9mA+egUy7 kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71nwvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 14:03:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334E0vWO028557;
        Tue, 4 Apr 2023 14:03:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptupvrkk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 14:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYmbqh8uXnZEUVem+EfQfmNs+sBKOTSuKaeLwoz7DQcge+oijSVftRIA5upBJEaOKYCK5+bnm10fiV8jJm9jku3OTY8WATrMx9L0L68gBa34y0nOsTYSiMGzd7KSx2Xwcy61sV7YNHAPMyelO7fxlIjeVr3smJJxjTm3zq3KDx+EGwn59mKGBpLeoIEZNxUh4nwD0pAcHREM41+/ernj79gskxjPObnRnRAIAdn0mO0PV8yKp1S8U3BipMDA2a7hwMK5OcJLg0J4JJia9G3DPXJwiMTTq7TAmrhzAHUmK1z6PQMT0mAI+SvxIrHiYHe8ipjg+yJEQJvi/kBjAKbD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVwJwls8fWGMomXsm+C04sDXrxq/39XoDTBflUYSMvA=;
 b=SdNVfq0qAEsU+/LhKxI3D5JUlSrvK3a1aylUol3q53uVdVZ8u5cmS8XUusmPcNh4jLJUmN70An+gotAZEjQUT50FSq1Gt290900Tdg18sc98bzAtYjKTvv9McJZrok5htT0uO5LWDqO9Ga6A92NX77NisfXgzn8P1OuEvcPpMPOhNS95ZDAz1Ch53f1/IOHfaqUNHkOt5eLg22jT+DUkGH4ubsd7pZ/9BI+kuERgb3y//fhWUltcIuzvp78EuHWlcx1yUhNKnKBxmhsyUUjGhJu9RocGBHxCqHrfWUxSM2Mx3kNiGxB+zUVh0nzztl3DmvNcdt4MccttNPfCP2e/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVwJwls8fWGMomXsm+C04sDXrxq/39XoDTBflUYSMvA=;
 b=rthWt743qIwPfBQmOUqRdjnHQV6Y6/VgU8SBNnuSyiCJp+52JhItdp7WSQ4VBgWkU/zfBRJ0EkMVdoEzZh/ZxicPaOcAMJaeukC0uzNBr8bqlT7SfANOdcowHzBG44eR2ohMRMedPF8oIq+AAqHZg+SDdtsBFDWAv+iNG/27SPs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 14:03:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:03:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for 6.3-rc5
Thread-Topic: [GIT PULL] nfsd fixes for 6.3-rc5
Thread-Index: AQHZZv44WqwjwdR5l0OFADlo8xzX2g==
Date:   Tue, 4 Apr 2023 14:03:24 +0000
Message-ID: <84B35B0A-C629-4C3F-A289-859A9A83E3CD@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4780:EE_
x-ms-office365-filtering-correlation-id: 50a8b667-a7f1-4ffb-3b7f-08db35155b63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gY/Esp3m06W9rmh5F/bQCQ6HjxiLduU25AJ9ZLJvEPZABt0HNe1EfVJLV/q6vQnbDvKDHmAAgRagLJ3EFDc1fXM3IwiKdsNc8qzW3VilaPq+luxlLGLFWjoiXRAnChkS8WvuM8POKBUbs+GtOy9hYacUekR12geCOWSzj11vUpu1dyIxQj3Pv9b32zpS/9Ftz0KFsfvjxsBufAqQwwFXj61Et1+nGUX88n4DWCJASRyxPX7f+viNhdR1zV9hLL/wbi+wPzzXwnaG2QZ7qlB7wgEGU5wIFH+TAaRM6NudEND/5VVCt2k2n12c5YWjvVgbi+nrOd1lfws9acervCnu46Rauu+/d+/gG14yB8y5lvI6BCFEi47jXMyf6DdXSBc65r7nxZN+RAhUZrUeb0qjvgm1NgEZf1eEI0xCNu4L98abXc9SpcXve6a8P5AWjMp4wKTChYlQG7IX2x3sLAhHKvvh08TwXZP9l9Qvhk5JjXC2REPjWmhau9MStFc+xm1ObxybUg8RXsCo1c5xNbYVYEqQ1DOn6+pkbu2Oum9iG0ebPwRCl8EUgWNypjP1M4dgCmz8hp92anVwKx8Tfrpz0I6MVXvbWGWbQD62y+D8PfbpjEkKo2XkM3d2Czc+AtzxV1YY6rNfZlKK3jwc7GcEcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(83380400001)(6916009)(8676002)(4326008)(66946007)(66556008)(66446008)(316002)(76116006)(86362001)(66476007)(2906002)(91956017)(41300700001)(122000001)(54906003)(64756008)(478600001)(33656002)(71200400001)(36756003)(38100700002)(6486002)(966005)(8936002)(2616005)(38070700005)(5660300002)(6512007)(186003)(26005)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3lMzbQmsmmXkViUHRKUSAJVeNqH0mgrYIJKPDKL0M86rBkQSmPNJIT+XY+u4?=
 =?us-ascii?Q?gii/NgTMxu6GePHtm9LUpgDcOkUkLbHzxnhAe2XDDg35esiV8sB5A/rYrKPo?=
 =?us-ascii?Q?VfLmFf/iqdBrQVh67RGuzECT+Goz6XbHMWqK0ti3Mt2NNZmjxm/Rekgn8/Gb?=
 =?us-ascii?Q?QwSPrT0/ODDGQFTP7Qsdj3sDAnoiMUDnUFMUaW2UxFb2sJS/edCXRf3yr/xf?=
 =?us-ascii?Q?eBar1ZaKPKMWEk7VjXf4/rmjLO86KExai4ugctMYD577jwwPJQXpXfJ/Tf8+?=
 =?us-ascii?Q?u2LgYd9gcklX7oTF6rThSqV3N/hOaGcWwDzqq/pM/xJ1PEDRtCj1OPiWZ5ZV?=
 =?us-ascii?Q?nSItHwUsmLC8IYJG9poDzPWs3uGlmSCK0PgjdVH1OStIHQSo+kjxOcU2vk4t?=
 =?us-ascii?Q?tR5X7X6+I+UdNHg07qKV/NSAtY7JGG+c2wAjXfA/3r/Qg5FroD+LLrXt1VJ/?=
 =?us-ascii?Q?w/rpWmWa66PEfIntLnJiUnVIcTZLMyePnn50LiShDmQec6gRH0SKnbQAg4f3?=
 =?us-ascii?Q?2/S5HA76Uzvk9os45ZAzq3MG5z7b5Ol/O5xoQi2+hN7dFhtpPVBACkCHHUWz?=
 =?us-ascii?Q?YtKB/59pykeGOGEw+R3//dPZqr6/gTBRwfmP1KjT2cchB6VX1q/Z6ZJae4FS?=
 =?us-ascii?Q?bkoyYqXThFmPTvikHpLuIqq6TdtF4Fyoaor15yI6nQRx4AVDUeA0mL4lAbjn?=
 =?us-ascii?Q?5LiR4IbJ7TnAog5NoNgxFCbdR8YyiLu5PuKBlVsdpI74qz16QQjYkhtNT+64?=
 =?us-ascii?Q?4Q39bpoDcZfefa8/pieDmPODjhZ/HoPloQgvkSXh6Y2a6/lRn99L04+tpakk?=
 =?us-ascii?Q?yEtMNAuTpNloRpXNTxDkggC/IYA25JRlifbTTax8yonf9q48f6e6FwYIbtba?=
 =?us-ascii?Q?l1m+yqoFdLqW67TKkrggb77X7sINB1hhzIxAfyUqSMVvOPjZnzPLgVBNBjOc?=
 =?us-ascii?Q?fsSHk2Hf07ee6esmEyxtsTWeKxufiAqgfFiAH89CFpM5BZiZN6Fcd78Zca7g?=
 =?us-ascii?Q?AvVbUf8GYwoujo0ljOdP7z6T+DR9EnsWfzNzYras01Pm5FmodEQzXoXYuaZ1?=
 =?us-ascii?Q?OayqRRlu9/xhExN+62AUepGlYNJQ1/Hly9evsHd7JLUdDSgStHCb+iz26ACn?=
 =?us-ascii?Q?kiZrJA9we1wXeRF8vuTzXerwewoWEu9iLnpkoK9IFTmHTO1eWwlpEdi4NCCi?=
 =?us-ascii?Q?wl7W3tIPIXB2oLDz/m4XqqS9RgoelpOybaLeop5FDRPMi2w0+Zgczm0cU1QS?=
 =?us-ascii?Q?GI+yS3rg2gdnF7QUosPxiWnaMU+UfJLlnQvQthym6ysAsjfMKWmm806FPa9T?=
 =?us-ascii?Q?fZjbPhtms6FFeUwrGk6eWprBoo1jJ4RAFH1kBwtWBN0P8LkhXghuWfie8ORq?=
 =?us-ascii?Q?cbjkApx7jO2Ah58AJrGJLFbSThfaHl6POfhUoiJkjytRrt5O7zPcj2lyIgip?=
 =?us-ascii?Q?BXeui4ORulqXmDtN64E5yQSRzEXXBS2IK2tGPtIsT1fnuUCHqhI7XihQAHsU?=
 =?us-ascii?Q?o3trtf2J+lJuDc0jaZ9UyVK7c0zPc8r/jJq9VlC6AExFOcGQn5+SERy2Jbo0?=
 =?us-ascii?Q?OPkKEQzbgPOfjkhIKljQJWG2xK1hT5G8AEuB9diqCn8QlOgMoBZz3OvymSTV?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D37C171A0940B347A3149CBE25368485@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tY30Kk60gyIzi/k4skEawgSXEIaTFDhllOQRqsD3W4xHbSUjQz4pNd/iKYLcocV/3XG6edDN/TJ1KF7j1y/rCdCmjfT9YEucnVqCFGt2Jmfrobg4v3yq28EYuVSrxqiCHs1hDExi071R6KjjK0WKGStUsPuvpYA6KHr8BO523EWWEMJ+blaM1EKVKiVG98NJh7aFxBxUrHCRrQVN9UmDk2D4RWp2Bo1djEaY3FkRe60GpXUO9XmQu3hF58t7BCN2+UeScY0uo2MkVr2sSbKeRp5VN9e+zJJuAK2RoYY/CYGgJ7SwG32l3gMNQgVhQI2+1fN4u8/DtG2zFehW4Mc87wmbbjnmtg6P3V0R6dAIwdXusiZ849LJPGegdaqCPj0X+FKi8ocVplBY/zC9Nqlm5nByPnTReOOCekVoW9Okp3Gg8dMERmn+CFXX5PBDinqvGrGmZjk0LYonzXyqyU1Sd02ycImXGVJaAyTIB0z5XYnht+fqW9zWO944WWRPPhdChN6BM5vSY/FFk9RK5lwE5cwqnhTpt+7dIwML1d9E7rHP0TTb9VP3RCmZxNcslj2EMPQ0rRUkpQJ+sKbzPdR1Dn+rIgJs+ZZ9olVQsZu3Q0mZr8Om3bOzqZCWD+k42wcNVP6Qqa8r/5u1dhEs9mItF2jA7B0q+MmFog/QmWiPT/P2bLsM8FnfQUE9d9DdufgYuYkKvMbtFToLz6zoOJxbKwrKW3QzSgRFjR9MYoufq2rNokhLC/87XMSrtbTIe8ZGNWZdYVESz/LrVEdjA4xZXZFI+LAvv3aBOku5m4urikotAdTn59ME7QcQqFezgl/h3hm+3VoUkyjcJ4FCfAMxMQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a8b667-a7f1-4ffb-3b7f-08db35155b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:03:24.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i/9IGU+8Ua9QXjmJZcdjFADtMMHB1tbWk35z9EjGYxRWAl0tINzePl8+HAsmIx0yOJYjFEq5YOjKA5V7uLuZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=918 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040131
X-Proofpoint-ORIG-GUID: a7v9koofY7XlSFXIWa3icnHoeiOpAMcK
X-Proofpoint-GUID: a7v9koofY7XlSFXIWa3icnHoeiOpAMcK
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 5f24a8725fe7bc2c6adf7ce00dd3e818387d8995=
:

  SUNRPC: Fix a crash in gss_krb5_checksum() (2023-03-22 16:58:26 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.3-5

for you to fetch changes up to 7de82c2f36fb26aa78440bbf0efcf360b691d98b:

  NFSD: callback request does not use correct credential for AUTH_SYS (2023=
-04-04 09:55:27 -0400)

----------------------------------------------------------------
nfsd-6.3 fixes:
- Fix a crash and a resource leak in NFSv4 COMPOUND processing
- Fix issues with AUTH_SYS credential handling
- Try again to address an NFS/NFSD/SUNRPC build dependency regression

----------------------------------------------------------------
Chuck Lever (2):
      NFSD: Avoid calling OPDESC() with ops->opnum =3D=3D OP_ILLEGAL
      NFS: Remove "select RPCSEC_GSS_KRB5

Dai Ngo (1):
      NFSD: callback request does not use correct credential for AUTH_SYS

Jeff Layton (2):
      nfsd: call op_release, even when op_func returns an error
      sunrpc: only free unix grouplist after RCU settles

 fs/nfs/Kconfig            |  1 -
 fs/nfsd/blocklayout.c     |  1 +
 fs/nfsd/nfs4callback.c    |  4 ++--
 fs/nfsd/nfs4xdr.c         | 15 ++++++++-------
 net/sunrpc/svcauth_unix.c | 17 +++++++++++++----
 5 files changed, 24 insertions(+), 14 deletions(-)

--
Chuck Lever


