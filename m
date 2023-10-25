Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A435B7D6EF9
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbjJYOYI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjJYOYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 10:24:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDD393;
        Wed, 25 Oct 2023 07:24:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCwvXW027680;
        Wed, 25 Oct 2023 14:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8rtCjundGuO4a3M7+Ty19+jVAF4rXbEZ7st7ntS0W7g=;
 b=iy1U86r+uZE3exG0Sy8Y+T/ELRxXWAUZRLyBBz50TKad5RdWCpedMzSln+4CQpxj5PRf
 LR7IPK/BJqEEPf+/JjY4rJJD5iLs9OABXMqLU0JFByVQQLEh+u+fe8tFpYSPlbBBownG
 prkgXRv9EL9D6lCz9HGMWykbELzxQu7blTG2FYIsC1YQo1HuQWwdenhyZBZKpImzFib/
 RiAtUe5KlYfi30oVElXEETEsZfGPk3P8YW/nNlaOWAuYEdlwcURCUkrYpn1sDNG91uyB
 iT4oU9HyVD0x2Dw1TX8Fx6KgeDenPxQouD8e0QbJ6llRR9B1NeV9YZQKWR9uQe36TVbY 8g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e37vbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 14:23:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEFTe6001564;
        Wed, 25 Oct 2023 14:23:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53d78xa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 14:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJQFTn4eM128X2G2ArNAxPz+qZZvyIsAvcFEaf7RQYvNbtz10q52z+ETj1+81xelrWa9lwCZ4geWJAq1JvNKdGfYMqeC1kXg8uTW6W0xBnTb51dw3ILJe7OtxIRYF1nkdFR8IchEY90hGw1Yzx6Ls42rhA6nHhegv23P/I4cQ9WrijIbl5XeMwm9EGx57qPsEFdOiHf3nQNQGESkZxoW7spe/Go2JYmwM8VTondJaqESV973tqk5nBCzfrSiYuy5EKHg/mMrvL+Kxi/WiwtLcdAUdb7fyR7ZU5ZgH4G7xsvJcPrxWnGj0in5GFWXeRGApfSxYWo6HrKJcz91nQibZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rtCjundGuO4a3M7+Ty19+jVAF4rXbEZ7st7ntS0W7g=;
 b=fBGeTiht+dweyUwMxUlk3EfqtN3XSdddkOsNBRTn8a9MCrhkncS68Mf9mla0C+OunwE1rYy1rNI0Tmu3wWUwaroOHf72YmITon8JmqBcAeKACHYCNbOzgrE4jNT4DOAc/iGSAJEn8NcINGK9VFFijTM/bOcXIPSwhjbRqtsqLPTkGHtGFoRYFlmQf5RWZUzpBs10ZrDaBqNvoFZBVWsv9XpMXRDUS8KfPkLzXIAiokrQiL0EmriaZDF4R5vCUoUJFqltk9UX5vgGTKpkonDsLgymouSWVakseVN4ZB/nNC+wkdn7DZezIYh2Vo0huR4H0GQhjZXbUMeCU18qMx0yDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rtCjundGuO4a3M7+Ty19+jVAF4rXbEZ7st7ntS0W7g=;
 b=Xo+6N0cyFJpDidH9eg8hS0kx2vmZbASBc7RQ2FttNBxGi9cBqE49cuC3QB365pGRhNY8PHChmeDGlYgJl6EkNyw2KjqPhzHBxPAUbobKyCu9RIFOQ8dNwlgmnQMY/A30xo+/7du8pz15zO8xUG7sDiWqjkf7UL5CORJymDZMIYY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5297.namprd10.prod.outlook.com (2603:10b6:208:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 14:23:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 14:23:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd changes for v6.7 (early)
Thread-Topic: [GIT PULL] nfsd changes for v6.7 (early)
Thread-Index: AQHaB07bbxXYSsT3IU+LcX+3TR9y/w==
Date:   Wed, 25 Oct 2023 14:23:42 +0000
Message-ID: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5297:EE_
x-ms-office365-filtering-correlation-id: 7f76b9f1-cbd8-4fac-506e-08dbd565fde2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1O/lWkrwhIHW/D1smNopWvJahEqfP5juQpth54j3sbsUJIwb31QPurSAATFbqQr8v8rYP4r0uhwECaz8qW2uGC4ajdP00W872suKD5CNM+9YxR5Me2rDWVromLInw7KTlnoYtIxKnL30v6pSbCMFmcUjpkDEdfVKl/Z9pLIOMRiFX0Zt7DK5bcNuAna+dOdgSscntC8ND8fMxkRlNasx7bR0pU0nMfANEihAbQGxJTK8AH4aZ67K/LlPIHpjS8cpiNInNOVYdu9VzO9KoWBy7O+J4F+HrsYYOQQpG+6NZJphEUCZ71ym/0/+j8ujSULl67Pp8pwZEqZ/Oage8fc7oluBwPkJOiQ19/EPirq3aE+l9rd0vkfulJlF9dyTdK/5hcOai6b9Wvz5Qr4SDMCJmKgND1R0wCjhIJf6HKHn2LupaiD98cpQvP4jIUWojy0/domkQT7M7mqh7vBEXmmCnkygo4sLOZL5qTg4Plk6/eS9bdF92EXdrmsaGi3u3YRhMPM0sAA6faSOcnYihGDZS85G+N72/sqvxaAQ8Aig4+4bh5ZXZTYoik8nszd9gBwCZ9HAif+bcCmGGGiANCEaFi+6UjFLhGfIFl0RMLhftpJNTj02p3mHAo3yrSjQQ17
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(86362001)(36756003)(2906002)(66446008)(64756008)(66476007)(122000001)(6916009)(66946007)(2616005)(38100700002)(478600001)(6506007)(71200400001)(316002)(6486002)(966005)(6512007)(54906003)(76116006)(91956017)(83380400001)(4326008)(5660300002)(8676002)(41300700001)(33656002)(8936002)(38070700009)(26005)(4001150100001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7Jws5JMJihPs+m3n0mXsZVc7dHfphNQMaYDTGYP1nobxQ/jL7eIxRbZDHn3?=
 =?us-ascii?Q?vdAIKWDldwa7KOYCnWGwgpGdPTpXVwnNthfHmuateuZNv+NgacArBeHU8EMu?=
 =?us-ascii?Q?hbosqGGasArC4b+G8/O109qMxJPdsOCIJBG5pTPFWdP8t0Bdnpee+zDaOiAS?=
 =?us-ascii?Q?E+XUST4+jo7JBYHqs9CFNPm1MOTQYS0tmo/r11miRZZXruzRYUV4qXoF2E37?=
 =?us-ascii?Q?MSqyapFFIsEu2SWDONHhPj/T+khl3jJPYunDwUnnVEGs1b/FucTGe4CncJbw?=
 =?us-ascii?Q?FEEN3jm1HzEeia2whnzPiWeNEoLTApOs9j8Yu785euKfUkOI1b/ZCiH2bDj+?=
 =?us-ascii?Q?99TMphmh8PJxKnKnCs9gUshwDpFkClnVIuJBJNi0ie1VW7sV/tmGYsGDncfX?=
 =?us-ascii?Q?XicTWumBCxM67zvJOE2P5AP+dJ7QmbZmbsguVPRqQwRCx5SSzNzIZ8hyTfUt?=
 =?us-ascii?Q?WDidzvjzhPtQXCxN9f9dFnffOw1rorUL99nrkJkdBBQOkCUZmRDKnlsdSoSq?=
 =?us-ascii?Q?5vGUdE42cUOgdu8W9qhz4iC6gQL8DHQHyogKy3BIJD36Q4VsF3nF6uEGksEO?=
 =?us-ascii?Q?9BvPMDKpxKXXDa+inJSII8ii9BOLbvJiSJT5JMwOAs3hvWKUuc2mjJJcT+eR?=
 =?us-ascii?Q?Sj5DQrmFR3nMXV+MHQZprAOugzcG/Rb1wBE6JH0LmjHRILxjqJ/eP4JoOcQj?=
 =?us-ascii?Q?ERRtcEkZiKgq2o1EetoKXpEKWavD4xa/0nfIhX1ZPH0iRGOm46odir2Nky9T?=
 =?us-ascii?Q?qkoJ0raGNE1VxToatQH2h7jArfu5IeAaUH3y7ZCRYUIAKep8dvoRSBBYyHaG?=
 =?us-ascii?Q?vE/tntU1v4kcWI86M1kpZ+gbCFBIvl/gJzQIckjpAOMOuYKX3TdUQSuYpoGB?=
 =?us-ascii?Q?mwFrAHJLfqL0nhwPCbqwdfquDTnGB9XR+j+bv0jr7xqW399bh5I+N35d1iSU?=
 =?us-ascii?Q?bwIBpFw3YuEhsxshS3DESx9x5uMYaaEliM4+n0VcfgTd754K8hLMEYQlAeZK?=
 =?us-ascii?Q?h8rlkZKPxeWsUMaKDIb9vd0fnXStoj7okLMYXpzQ2c6rbgweO+aiSCjdu1bH?=
 =?us-ascii?Q?RuY1EHe2hPzPadX/IgXtBgBrNq37XGMvVxoaQHBvTZ7Puz85JwCGIpN07yYu?=
 =?us-ascii?Q?jNGUTOszt1MaEiBCG7i1/FnaBQLWjF6pcDFhOXeKSDpfi4+2HTlvUKLwKQac?=
 =?us-ascii?Q?MBVkvIStKXkUnoi35GjlpIm/2gbDA3c/pyMG7yQFsdooYs6jCPhJ5lWtWO9X?=
 =?us-ascii?Q?/TaMb4xHcWYXkqbDOu8SgtCOaQRYpN2F1H8Ykbtz17PrKtw5ba0CWjxy8oMq?=
 =?us-ascii?Q?Aw/wA1QM3/owTOxmYPw77VYJZnSYTcxGMHWjshHksPfWqM/bgDFd0b61pCj0?=
 =?us-ascii?Q?Pr5uF4xWzxleMTg/nkJgGeTVQICMa3tLx5IpRu2LgTNCyuf8yvkhbq7kqBDt?=
 =?us-ascii?Q?OsEfpJB8ApQASRBbfMdRwb2egxseCvezjy72m67tSpLqqM5ms1eHmDWtf9ps?=
 =?us-ascii?Q?tms4dosFVhhUigDnuinWvfnJjUIFWsM5+BO/sa1T+KqvvPprB+zJtmHv5/ej?=
 =?us-ascii?Q?KTLgWHCRTj2FTiPfye2t73FXMMHnTr4ogCuohQbjnO4Pw7VYovy2Xcs2bqzM?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33125F0017AB864EB36B9844741769B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ryC7XfL6T9Eicd7Xv6Ktm8+PwLNqNIJWYwSlxcMychisT8KnNa1aoPzFNw98T5RQDNu80P6PRBYFAEIhL+K5wqGl3g2pSWpd4Tyj38yuT3Pnn/2JqAPE8dWi8ne2uGyz3fCzvUB3C3jowaLrttwDMXdKBanHQhoMdbzGPE/uY8Um8TNVvXlHGhFLThRx/QUSFQP4q/v595xsP1dHFP9uwRDGQZwCeVIvsCzyW5hlaPlYzPRMRyBA5Lr6ApsI2P59geMJVGGEIBpnCSEzKYimR07SIHbLK0NTr6IHakZfB1FMGdazla+44CnIGRU0EnSX1XaATyKtigRpoDYnppzpcAYlLKiCmqV7y99nF0s5qGvYc0vt9XkTTQPsBeW3bP6589TiPkZWm+2f0118+UGLIFfkg6x9WmSV6ZgrZhJYz78w8XR6vYYKJaPtr4fq2A3o3Hhwyzp93w3fg+DIeDz+ow28NGSaGsE0iThxJ3Ut9O579WbdVo2FlQKYqxgSLfVkwOv/Mplryh3EHTDanAJtBFpCqHUkAQf8aIpSuDCT1FPsoXccyYUK4rVBSeRlOMbexevkOqk30HpDZC9cZqsbOsEzp39MYloRdMYsGYlD/oqnrdS86DnDaIHRIkdIS51ldRr3JTSso9F06eHU3vSdgyr413sBGR5x5eBG2m0RpLaD263PE9A51ymWLE3crSs/tTvQF9ZdC8KutHedA2pU5qD5laMhulyf5NVYkRFfVyrxS4OtQf6JqdR+gTEY/ozkJgq/dn206p8lOjEsdRO1qEogGw/s1EjtNlUvy4eVmeNHFAgr1VoF8VbvPseVz3mstFAyDgAx7+B6oFYKPSSvJj5zP9DtgToeXxa9YWX31sw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f76b9f1-cbd8-4fac-506e-08dbd565fde2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 14:23:42.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/W9HVljam16i9FAtN3UyiSJilIAD90YCA7DOWfg5SlsA634Pe9XA/RNLmKDKxnpSUTlK5cNNJOZnqiwxgPFyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=733
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250125
X-Proofpoint-GUID: pCGuwkIJiNsTr5EYJEvKveogCYbdSk4z
X-Proofpoint-ORIG-GUID: pCGuwkIJiNsTr5EYJEvKveogCYbdSk4z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb=
:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.7

for you to fetch changes up to 3fd2ca5be07f6a43211591a45b43df9e7b6eba00:

  svcrdma: Fix tracepoint printk format (2023-10-16 12:44:40 -0400)

----------------------------------------------------------------
NFSD 6.7 Release Notes

This release completes the SunRPC thread scheduler work that was
begun in v6.6. The scheduler can now find an svc thread to wake in
constant time and without a list walk. Thanks again to Neil Brown
for this overhaul.

Lorenzo Bianconi contributed infrastructure for a netlink-based
NFSD control plane. The long-term plan is to provide the same
functionality as found in /proc/fs/nfsd, plus some interesting
additions, and then migrate the NFSD user space utilities to
netlink.

A long series to overhaul NFSD's NFSv4 operation encoding was
applied in this release. The goals are to bring this family of
encoding functions in line with the matching NFSv4 decoding
functions and with the NFSv2 and NFSv3 XDR functions, preparing
the way for better memory safety and maintainability.

A further improvement to NFSD's write delegation support was
contributed by Dai Ngo. This adds a CB_GETATTR callback,
enabling the server to retrieve cached size and mtime data from
clients holding write delegations. If the server can retrieve
this information, it does not have to recall the delegation in
some cases.

The usual panoply of bug fixes and minor improvements round out
this release. As always I am grateful to all contributors,
reviewers, and testers.

----------------------------------------------------------------
Alexander Aring (4):
      lockd: introduce safe async lock op
      lockd: don't call vfs_lock_file() for pending requests
      lockd: fix race in async lock request handling
      lockd: add doc to enable EXPORT_OP_ASYNC_LOCK

Chuck Lever (92):
      SUNRPC: Clean up bc_svc_process()
      tools: ynl: Add source files for nfsd netlink protocol
      SUNRPC: Remove BUG_ON call sites
      NFSD: Add simple u32, u64, and bool encoders
      NFSD: Rename nfsd4_encode_bitmap()
      NFSD: Clean up nfsd4_encode_setattr()
      NFSD: Add struct nfsd4_fattr_args
      NFSD: Add nfsd4_encode_fattr4__true()
      NFSD: Add nfsd4_encode_fattr4__false()
      NFSD: Add nfsd4_encode_fattr4_supported_attrs()
      NFSD: Add nfsd4_encode_fattr4_type()
      NFSD: Add nfsd4_encode_fattr4_fh_expire_type()
      NFSD: Add nfsd4_encode_fattr4_change()
      NFSD: Add nfsd4_encode_fattr4_size()
      NFSD: Add nfsd4_encode_fattr4_fsid()
      NFSD: Add nfsd4_encode_fattr4_lease_time()
      NFSD: Add nfsd4_encode_fattr4_rdattr_error()
      NFSD: Add nfsd4_encode_fattr4_aclsupport()
      NFSD: Add nfsd4_encode_nfsace4()
      NFSD: Add nfsd4_encode_fattr4_acl()
      NFSD: Add nfsd4_encode_fattr4_filehandle()
      NFSD: Add nfsd4_encode_fattr4_fileid()
      NFSD: Add nfsd4_encode_fattr4_files_avail()
      NFSD: Add nfsd4_encode_fattr4_files_free()
      NFSD: Add nfsd4_encode_fattr4_files_total()
      NFSD: Add nfsd4_encode_fattr4_fs_locations()
      NFSD: Add nfsd4_encode_fattr4_maxfilesize()
      NFSD: Add nfsd4_encode_fattr4_maxlink()
      NFSD: Add nfsd4_encode_fattr4_maxname()
      NFSD: Add nfsd4_encode_fattr4_maxread()
      NFSD: Add nfsd4_encode_fattr4_maxwrite()
      NFSD: Add nfsd4_encode_fattr4_mode()
      NFSD: Add nfsd4_encode_fattr4_numlinks()
      NFSD: Add nfsd4_encode_fattr4_owner()
      NFSD: Add nfsd4_encode_fattr4_owner_group()
      NFSD: Add nfsd4_encode_fattr4_rawdev()
      NFSD: Add nfsd4_encode_fattr4_space_avail()
      NFSD: Add nfsd4_encode_fattr4_space_free()
      NFSD: Add nfsd4_encode_fattr4_space_total()
      NFSD: Add nfsd4_encode_fattr4_space_used()
      NFSD: Add nfsd4_encode_fattr4_time_access()
      NFSD: Add nfsd4_encode_fattr4_time_create()
      NFSD: Add nfsd4_encode_fattr4_time_delta()
      NFSD: Add nfsd4_encode_fattr4_time_metadata()
      NFSD: Add nfsd4_encode_fattr4_time_modify()
      NFSD: Add nfsd4_encode_fattr4_mounted_on_fileid()
      NFSD: Add nfsd4_encode_fattr4_fs_layout_types()
      NFSD: Add nfsd4_encode_fattr4_layout_types()
      NFSD: Add nfsd4_encode_fattr4_layout_blksize()
      NFSD: Add nfsd4_encode_fattr4_suppattr_exclcreat()
      NFSD: Add nfsd4_encode_fattr4_sec_label()
      NFSD: Add nfsd4_encode_fattr4_xattr_support()
      NFSD: Copy FATTR4 bit number definitions from RFCs
      NFSD: Use a bitmask loop to encode FATTR4 results
      NFSD: Rename nfsd4_encode_fattr()
      NFSD: Add nfsd4_encode_count4()
      NFSD: Clean up nfsd4_encode_stateid()
      NFSD: Make @lgp parameter of ->encode_layoutget a const pointer
      NFSD: Clean up nfsd4_encode_layoutget()
      NFSD: Clean up nfsd4_encode_layoutcommit()
      NFSD: Clean up nfsd4_encode_layoutreturn()
      NFSD: Make @gdev parameter of ->encode_getdeviceinfo a const pointer
      NFSD: Clean up nfsd4_encode_getdeviceinfo()
      NFSD: Remove a layering violation when encoding lock_denied
      NFSD: Add nfsd4_encode_lock_owner4()
      NFSD: Refactor nfsd4_encode_lock_denied()
      NFSD: Add nfsd4_encode_open_read_delegation4()
      NFSD: Add nfsd4_encode_open_write_delegation4()
      NFSD: Add nfsd4_encode_open_none_delegation4()
      NFSD: Add nfsd4_encode_open_delegation4()
      NFSD: Clean up nfsd4_encode_open()
      NFSD: Add a utility function for encoding sessionid4 objects
      NFSD: Add nfsd4_encode_channel_attr4()
      NFSD: Restructure nfsd4_encode_create_session()
      NFSD: Clean up nfsd4_encode_sequence()
      NFSD: Rename nfsd4_encode_dirent()
      NFSD: Clean up nfsd4_encode_rdattr_error()
      NFSD: Add an nfsd4_encode_nfs_cookie4() helper
      NFSD: Clean up nfsd4_encode_entry4()
      NFSD: Clean up nfsd4_encode_readdir()
      NFSD: Clean up nfsd4_encode_access()
      NFSD: Clean up nfsd4_do_encode_secinfo()
      NFSD: Clean up nfsd4_encode_exchange_id()
      NFSD: Clean up nfsd4_encode_test_stateid()
      NFSD: Clean up nfsd4_encode_copy()
      NFSD: Clean up nfsd4_encode_copy_notify()
      NFSD: Clean up nfsd4_encode_offset_status()
      NFSD: Clean up nfsd4_encode_seek()
      NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
      NFSD: Fix frame size warning in svc_export_parse()
      svcrdma: Drop connection after an RDMA Read error
      svcrdma: Fix tracepoint printk format

Dai Ngo (4):
      NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace po=
int
      NFSD: add trace points to track server copy progress
      NFSD: add support for CB_GETATTR callback
      NFSD: handle GETATTR conflict with write delegation

KaiLong Wang (3):
      NFSD: Clean up errors in stats.c
      nfsd: Clean up errors in nfs4state.c
      nfsd: Clean up errors in nfs3proc.c

Kinglong Mee (1):
      nfs: fix the typo of rfc number about xattr in NFSv4

Lorenzo Bianconi (2):
      NFSD: introduce netlink stubs
      NFSD: add rpc_status netlink support

NeilBrown (18):
      SUNRPC: move all of xprt handling into svc_xprt_handle()
      SUNRPC: rename and refactor svc_get_next_xprt()
      SUNRPC: integrate back-channel processing with svc_recv()
      lockd: hold a reference to nlmsvc_serv while stopping the thread.
      SUNRPC: change how svc threads are asked to exit.
      SUNRPC: add list of idle threads
      SUNRPC: discard SP_CONGESTED
      llist: add interface to check if a node is on a list.
      SUNRPC: change service idle list to be an llist
      llist: add llist_del_first_this()
      lib: add light-weight queuing mechanism.
      SUNRPC: rename some functions from rqst_ to svc_thread_
      SUNRPC: only have one thread waking up at a time
      SUNRPC: use lwq for sp_sockets - renamed to sp_xprts
      SUNRPC: change sp_nrthreads to atomic_t
      SUNRPC: discard sp_lock
      SUNRPC: change the back-channel queue to lwq
      NFSD: simplify error paths in nfsd_svc()

Sicong Huang (1):
      NFSD: clean up alloc_init_deleg()

Trond Myklebust (2):
      nfsd: Handle EOPENSTALE correctly in the filecache
      nfsd: Don't reset the write verifier on a commit EAGAIN

 Documentation/filesystems/nfs/exporting.rst |    7 +
 Documentation/netlink/specs/nfsd.yaml       |   89 +++
 fs/lockd/svc.c                              |    7 +-
 fs/lockd/svclock.c                          |   43 +-
 fs/locks.c                                  |   12 +-
 fs/nfs/callback.c                           |   46 +-
 fs/nfsd/Makefile                            |    3 +-
 fs/nfsd/blocklayoutxdr.c                    |    6 +-
 fs/nfsd/blocklayoutxdr.h                    |    4 +-
 fs/nfsd/export.c                            |   32 +-
 fs/nfsd/export.h                            |    4 +-
 fs/nfsd/filecache.c                         |   27 +-
 fs/nfsd/flexfilelayoutxdr.c                 |    6 +-
 fs/nfsd/flexfilelayoutxdr.h                 |    4 +-
 fs/nfsd/netlink.c                           |   32 ++
 fs/nfsd/netlink.h                           |   22 +
 fs/nfsd/nfs3proc.c                          |    5 +-
 fs/nfsd/nfs4callback.c                      |   97 +++-
 fs/nfsd/nfs4layouts.c                       |    6 +-
 fs/nfsd/nfs4proc.c                          |   32 +-
 fs/nfsd/nfs4state.c                         |  156 +++++-
 fs/nfsd/nfs4xdr.c                           | 2700 +++++++++++++++++++++++=
+++++++++++++++++++++++++++-----------------------------------------
 fs/nfsd/nfsctl.c                            |  203 +++++++
 fs/nfsd/nfsd.h                              |   17 +
 fs/nfsd/nfsfh.c                             |    2 +-
 fs/nfsd/nfsfh.h                             |    3 +-
 fs/nfsd/nfssvc.c                            |   42 +-
 fs/nfsd/pnfs.h                              |    6 +-
 fs/nfsd/state.h                             |   27 +-
 fs/nfsd/stats.c                             |    4 +-
 fs/nfsd/stats.h                             |   18 +-
 fs/nfsd/trace.h                             |   87 +++
 fs/nfsd/vfs.c                               |   61 ++-
 fs/nfsd/vfs.h                               |    4 +-
 fs/nfsd/xdr4.h                              |  154 +++++-
 fs/nfsd/xdr4cb.h                            |   18 +
 include/linux/exportfs.h                    |   14 +
 include/linux/iversion.h                    |    2 +-
 include/linux/llist.h                       |   46 ++
 include/linux/lockd/lockd.h                 |    2 +-
 include/linux/lwq.h                         |  124 +++++
 include/linux/nfs4.h                        |  262 ++++++---
 include/linux/sunrpc/svc.h                  |   45 +-
 include/linux/sunrpc/svc_xprt.h             |    2 +-
 include/linux/sunrpc/xprt.h                 |    3 +-
 include/trace/events/rpcrdma.h              |   10 +-
 include/trace/events/sunrpc.h               |    1 -
 include/uapi/linux/nfsd_netlink.h           |   39 ++
 lib/Kconfig                                 |    5 +
 lib/Makefile                                |    2 +-
 lib/llist.c                                 |   28 +
 lib/lwq.c                                   |  158 ++++++
 net/sunrpc/backchannel_rqst.c               |   13 +-
 net/sunrpc/svc.c                            |  155 +++---
 net/sunrpc/svc_xprt.c                       |  238 ++++----
 net/sunrpc/xprtrdma/backchannel.c           |    6 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c     |    3 +-
 tools/net/ynl/Makefile.deps                 |    1 +
 tools/net/ynl/generated/Makefile            |    2 +-
 tools/net/ynl/generated/nfsd-user.c         |   95 ++++
 tools/net/ynl/generated/nfsd-user.h         |   33 ++
 61 files changed, 3531 insertions(+), 1744 deletions(-)
 create mode 100644 Documentation/netlink/specs/nfsd.yaml
 create mode 100644 fs/nfsd/netlink.c
 create mode 100644 fs/nfsd/netlink.h
 create mode 100644 include/linux/lwq.h
 create mode 100644 include/uapi/linux/nfsd_netlink.h
 create mode 100644 lib/lwq.c
 create mode 100644 tools/net/ynl/generated/nfsd-user.c
 create mode 100644 tools/net/ynl/generated/nfsd-user.h

--
Chuck Lever


