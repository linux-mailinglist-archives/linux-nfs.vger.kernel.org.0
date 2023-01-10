Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8B664C1C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjAJTOB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbjAJTN3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:13:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BF6D63;
        Tue, 10 Jan 2023 11:13:27 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJ0eSN010219;
        Tue, 10 Jan 2023 19:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b2iMLNxdeAG2PtWVjwERuHfOPDvNpnDWHfj0B/mkLvM=;
 b=uyE0WgFYQ3l2l80sMS53So2y+0y8GerHpixZmAO3Ro1iXwSDaylXiReyHuNTU8fTj4T7
 VFEbP4sVD+lI+MKBv3SPBo1zv8BusUdkvtcGnxqwpVC7X3eMHDtCyQYxaVhSKUUOQ/Ha
 NJSyA+/1AvwmhWdqlpJ2UNTVO9xPWka8eWObvdhZaz5tiodHfvgG4Mdyojlwg0SimCsl
 BU+DDAAbRAxQ9r976CAkU8vlMrOSzHdMupA85YSPx3EGv0G2mK3rKnc04d6Zoc1JFFhz
 PgfGbfgZ7H9FaLV+8a3/A0ejhj4Q3nYBIlPN+TObtdTvRcjZxRTVKLReumtnO+4ljTL0 Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n173bh4x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:13:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AHwjn2030812;
        Tue, 10 Jan 2023 19:13:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1bnafvc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPLAyIs9sALXiQsR5IkGymNLAr1TkqDtD7NnoOgND8WxaE1zOzFjsfv+g+H5gjhGDJ+BwHaQuhEzMSrQb+OM4qWbnkrv9TZNdkihw+fkslt32isi6dStBqPbcbMXvm7QqxWy5X7zXz5wR1PKPJZVhPgp7DuiqBzxbXLELzajUw/7L5xpNxq/z3JRphe4zghIHESGunwaef22ZxAHSJ2dzlc6ef5cesPBwTkPV3Z10lxARbXpT89aoQZrrMvfuvKyAnnoG14lop5120UzVUoJ924Yj/TIsDnXYRO8+oAr9DL1739wei5FOcPFGyY0DKcrgCDJLdAFPOch1Bv9XB7WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2iMLNxdeAG2PtWVjwERuHfOPDvNpnDWHfj0B/mkLvM=;
 b=Yanr0+T3npodo0BE241Dg5lRvDU73X0JkptGvZTozudcEqCBTpudvMHe+I5xjFnux1K5mnx3WKMj1pO34QlvfOuLMp+rh6IW+8P6g+PXCPsQf3jLZjx5Y93O1xRqHdfVgW6CSyO0m3rocjs0f74MFVEBZD3yfFT62ga1kiwE23kCnI9Ee2gJQqraE0tISTuFFamth6P5KvR9BawpigFwHiTVFr2Tftomh4P1afu00lacsQCvx0UsdlVp/AxlaYxdcPFGhiyLArQrnmgvDs+e7l94HavvPtNO44bJubsMSvwFeAXwDg8VdjRpBVvh1Emhb2UmkkKf7RkMTtA408feGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2iMLNxdeAG2PtWVjwERuHfOPDvNpnDWHfj0B/mkLvM=;
 b=KMscy7OIKMdEY2pw7pcW1inFOvHqNKbmAnE+4mvJCPAPuJ4eZ0SSMCYG4vwMszrcu7Itrj9ygNTQiS4yiL19U+ZDXtDUxVdzHBHCVr8NRtb1l/oHHPUwGbXUa7Jad4gsEGh/sHGxPfUNgzcvxdo8mL9KDtUf2J5uxFqTkEkeOrI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5283.namprd10.prod.outlook.com (2603:10b6:208:325::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 19:13:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 19:13:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] second v6.2-rc pull request for nfsd
Thread-Topic: [GIT PULL] second v6.2-rc pull request for nfsd
Thread-Index: AQHZJSea1lrcn6HImEu1kD7zx/Pxrw==
Date:   Tue, 10 Jan 2023 19:13:21 +0000
Message-ID: <C9754BD7-5CC7-4330-9A1B-F6C67EB2CB3F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5283:EE_
x-ms-office365-filtering-correlation-id: f165aa8c-f77d-4661-8f30-08daf33ebd79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qi0xrJ9jOEx/FqdOJT2naIIKjLZV4dg2cqt4IfXcrz8WNWQUgjZtMayg5GUpy7lshHe1oYCn+kMMCOzwbdH7On73aXGn1ESbSyIECciJlDfaLClZKIlwt+yHZlqprrHjBqWizKWY90YaqE8+VwqrOMK8HppGS+EE7Fuz2uaCOUTuqsxWe/7RCzXzwpBUFRAAugsxgRbIODCHFTCMU5/wzQazrc/tmPdrDCsnr69std7rwqBf4pjrzijPc7LBISHf1ietwmUBUfCv3NbgCLSnJc0quZkvzNFkS62Ylt0d2yWYdbbC9sjMc9a6fxVcy38UZDqvtj9luuaj9aL6EjFd5xnlk/vlLsd5qZ0CzLw2LGan0ALDHs7R/L4cdEv/hJMW4ZPJ3JQ2iMngu4yKmmeXCxqCIxtl2jhAzKLuticcZRnYrc+0/IM2FUVSa6EpODJ5pCVKy9YOrQyBtdArQrc+ah6pjmCBtvICYpOQCeTLLkruXHCn5tpXjmQYCoWYB7Ukzt8cJoT7hbp8VFRb2Wgki2YviyPWjcwJNzG7IC96Ueco83JP35WRlmAWXmotxO/TojxzvG0zCdx6Ibmwafl7tb/btsXHq7CBg4WjlpQ10fmoBiIsoFfpLUqeoT12oZ+jAaoWLUi6VX7cGQZw0e1p9unJtD0Dv34oWt5yB5nUTjaltz8ZoTjpXBokPATxfh/24zplXtzRf4vHTP2HQkviqNtKuS1sCAG0BMI41uv1EDJfa4nI0k4+9eS5sV/QxJc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(54906003)(2906002)(33656002)(5660300002)(6486002)(36756003)(86362001)(8936002)(6916009)(8676002)(66946007)(64756008)(4326008)(66476007)(66446008)(76116006)(38070700005)(41300700001)(316002)(66556008)(91956017)(38100700002)(122000001)(6506007)(966005)(71200400001)(83380400001)(26005)(2616005)(186003)(6512007)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RNwlzRho/sPsU+4iBPw3o3aRX0+f54zZuPotmH5iCKigOQlT4EzGm0FNRaS7?=
 =?us-ascii?Q?eCgbXlYYJob2WFoKjv88qEsPyktYWtnwUBlzmo45ed8uikEayVy3DtBcjfWu?=
 =?us-ascii?Q?tZjy4zu/Sqr/xMEJGsrYyMNRVvoErrEGyBIjed59qUsKti336ouYVFrum5wr?=
 =?us-ascii?Q?x7uOwc93fVoYVfHTaaczfrDTf3TnYXQVP2UeSpCVBck//0M1k1zfLNBU8cvC?=
 =?us-ascii?Q?WTer/OugAlGRedDqtYKtTYZQ7ckkyCnjDfvTsZfZRSkh/Lxo8lg3MHblUYD3?=
 =?us-ascii?Q?kuqwSvlxJODR7txD0eE2BgbEbVcY4rx/rcW66F9NHQPtMxSLikwu/p4nL0n9?=
 =?us-ascii?Q?k6aFrKBpBxb/GfVsO6ckW46kFNCr+pJ4o1uvH7QjtQUgmmUMRHH1BKvha371?=
 =?us-ascii?Q?+xWzB9Z7zkGD3r6bJ0y89qb1ULVWxhS0tYUF9xzFg52X1H+cq7c6Sorw5W91?=
 =?us-ascii?Q?Qs+Un4EipkedfMXTr3c7QfLU65tbpDMFfMS/YdQ6VFuXgK16orNjuvF4/byS?=
 =?us-ascii?Q?YzxOZdpf1dbUBIKl1zl3uiESGBFGa1Av5FGMnOhE0AO9fpwmqhMpB/cdc7Qf?=
 =?us-ascii?Q?9XepUsc65bp32BBtAMsWLi8KKECWFcZBT2FpqmaMPK2XTsbIvAw4bdCKKZzm?=
 =?us-ascii?Q?FC6s+yEfTvWOHegf1WIqGD416P5ttlI4KjwRgIDSweNCSoIsunDQZDMu2ac1?=
 =?us-ascii?Q?s3ZeZtB9Na3pBLQ4fvRXP7j0xPT2Un5Rr+qUfo3r8SXLWG78776hCSNrvh5d?=
 =?us-ascii?Q?tDOzGuTSYOiKs4zHrOtok2/aN4u8D9mpwPiVTEohiRAH8Lu711yS/wEYTXuX?=
 =?us-ascii?Q?m+M1gDsf/wkJrMFpYGxE6DjnnY4slTzYkf7iaf3nQjc1KkQ0N+436lczx7KA?=
 =?us-ascii?Q?FJrVwayGhqkft6ZIrCjSKb6dRwFRfsoEbJ2LZB+HW/wIa6UA54x9OhkrsITt?=
 =?us-ascii?Q?7Lar8Z/+Pf/b7zC8kBCvChA8CQ7lhNgmONr1F2kQkafqBNAmKHFwpdwhIuVG?=
 =?us-ascii?Q?RHvn56J1WXlSU2R9Z2IhEKSCY0VSfQ4sWD5kWNTZt3jMYaJenGbO6+quXdKY?=
 =?us-ascii?Q?jymFfyIgEb40YTcjnZ9Xru3URkdn+W56Fl1AeWAqmSsO1dwSVHD4t2Nu0RYv?=
 =?us-ascii?Q?g65oMNy3gyfUK1+DxRfqx8MHW0H/m+yKqN1xfj/Ozz7q5uL4qkLfGn8mvBcm?=
 =?us-ascii?Q?hVRsE3jDZ6XI24KxpCOre6NFmh62bV2Lw40RmB/2qggo4HT0SApSmTbnC87o?=
 =?us-ascii?Q?uvTMX0TG/8f1VUYklSI4kQiubiOWNX7mqhAKivbGX4x/38LAYbCQnu2o8Pap?=
 =?us-ascii?Q?tdmMCngotzpVIHg9PnsK0nrRcUGcsV9GaRKUYsTP3WWiXpFuLnBaf+8xkMKZ?=
 =?us-ascii?Q?ZgjjyGfstr59Vi7rsLNA12oQScAEbkyFILIDo49ZMFgyX0oDI9FA6TLkF0Dx?=
 =?us-ascii?Q?uW+6V8Rr/8F7KFdov49WR02M0v1b8IsBZHfS+IVBKgWDPu6s+kqgIKj3Vfpm?=
 =?us-ascii?Q?6eh5DReWhacEUsgb2oyGcDAWjMVGDgpRSjlgPni2N92R9ZVRT2I/3cbZMylp?=
 =?us-ascii?Q?GBlSKcjkSzMDuO7Lbo6jNp7g+FSLEnXPpkAcpXG2hpF1POdlGnW90OE+Mgog?=
 =?us-ascii?Q?5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6B7B1AC6B249542B2EA1D466D7529BE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z9kfK88eNE9SUZuWSNxmIQaDcFu4wH9YYeYXnXCZl85YoXSOJNTNi56VKt1Q0eeUyb1947JCJ/lboUTecgMeuXBYjH7Iw4kr7vw+FctO2FsNDMQiWgrWVnfdPoOw5YCWydXrFlrTXycRp44l1wp6OulN/ylyD/E2S12G+wr9i5KqXFVpTpuXbPk/7UwvEvIETn18gd3JjsxeUg6JweluCQsDBYTwfih/c+mBeSr5dG+aEQg4/LpPn04gg5oiccVoolqMxtw58zLlAdsh1TZvoWBZJCxLs5wpyQChH1fT6aCoKssGvjtGsuqkeLsPSyEsGpgKHm2whywJu0AJzG/ctiPRqjT1ngaCPWdWfJ9QrP35tDVziZ7IzCMa/fwhS3m5iBEC0l3N7U3ZpNMXFKwEa6jpyBbEwYaSloX/df7XO1gtg5uTrWltDScV3yCNwMvB8+o6E4mjKMUlTvvBZIcgsv7+09EmVsaJYLr38q4UwP78ZlLLe6U8C6D/gp8aJw7Xk1d65k3R15l6TUSpXxPdQGRPMTOZheMNGLJov9b2+kSD0pVun3lgXvunYNC2cOTkWXDio23TFs5pPqx6J/sSRGU4gPa7wpVnCN/RE2wXKh9ucp9V01DtPjhy1iJtsFbaHZVpufrQ4bGPPKVjczzaFFhvjl8BGTN6PVTvz2G5+nk13ohRBOdP976NZmkOC9TfVF3AYKuDLLmUUoOTlV2plJ9kq6axPESrtC+KBg0XvtE6kvMwrWDtvcpBWJhGW+V1XJpi9ncdkQqfdX8+3QayPz6JmYhsPRdIlmDYmUZqyxihWfJ/A0k+ZhRRie7eamvdI/UxqLdsDxkqCurA5cPhTljoZ5A1z7zbaCYxR4E3uDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f165aa8c-f77d-4661-8f30-08daf33ebd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 19:13:21.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTn9zYuHv0tnGfTcWDtQ9E7osbFoglb12kkbLKKj7FPF/Ve0F7gt5qIhjqRuBFs17ZTOsVOI4MjQcgYPBpRoTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_08,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=972 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100126
X-Proofpoint-GUID: Wk05nxSibyJKRUu6Nv9WFcSxfmIkgsmp
X-Proofpoint-ORIG-GUID: Wk05nxSibyJKRUu6Nv9WFcSxfmIkgsmp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit cad853374d85fe678d721512cecfabd7636e51f3=
:

  nfsd: fix handling of readdir in v4root vs. mount upcall timeout (2023-01=
-02 10:45:31 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.2-3

for you to fetch changes up to 5304930dbae82d259bcf7e5611db7c81e7a42eff:

  NFSD: Use set_bit(RQ_DROPME) (2023-01-07 10:16:33 -0500)

----------------------------------------------------------------
nfsd-6.2 fixes:
- Fix a race when creating NFSv4 files
- Revert the use of relaxed bitops

----------------------------------------------------------------
Chuck Lever (2):
      Revert "SUNRPC: Use RMW bitops in single-threaded hot paths"
      NFSD: Use set_bit(RQ_DROPME)

Jeff Layton (1):
      nfsd: fix handling of cached open files in nfsd4_open codepath

 fs/nfsd/filecache.c                      | 40 ++++++++++++++++++++++------=
------------
 fs/nfsd/filecache.h                      |  5 +++--
 fs/nfsd/nfs4proc.c                       |  7 +++----
 fs/nfsd/nfs4state.c                      | 16 ++++------------
 fs/nfsd/nfs4xdr.c                        |  2 +-
 fs/nfsd/nfsproc.c                        |  4 ++--
 fs/nfsd/trace.h                          | 52 +++++++++++++---------------=
------------------------
 net/sunrpc/auth_gss/svcauth_gss.c        |  4 ++--
 net/sunrpc/svc.c                         |  6 +++---
 net/sunrpc/svc_xprt.c                    |  2 +-
 net/sunrpc/svcsock.c                     |  8 ++++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
 12 files changed, 59 insertions(+), 89 deletions(-)

--
Chuck Lever



