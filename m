Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDE6C3BA8
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCUUVk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCUUVj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 16:21:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF43593;
        Tue, 21 Mar 2023 13:20:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGnWiH024686;
        Tue, 21 Mar 2023 20:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xX/XFEUvIt+HZH3nOoO6waag4fYzuF2IAJvsMzzjZWI=;
 b=Z1HnNhGjKQN93FNNiITeTT5C1PS7pTWMK9iONT9y/UWG0S3IzdaXSS7FpNNL0REyTCVW
 DJqnNmBstspzsdMmLvhiTpcyCOqJJPtIgbgXQj4xrv7+wqYowE8m2TsdN+rHeMTdNAHl
 8N91+FhMFq75n77GQc7fmVRgY2kQzsTgq5H31QL105sIosrhpQsB049jyUbLAGZOF8kP
 RF7Yinvq6O8QlSbxoQHkO8xOlSizJpNdT+SMypqshaY6pWiHjPiygUlk7nk5totHlADQ
 MpsdxzGXMAb4knHxC1vD4tA8Ao2gCG6MOljZxO7fEYxs4bF+bivhYDvlp1qnomZe7TQW yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uuf8sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 20:20:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LK9E94034020;
        Tue, 21 Mar 2023 20:20:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pfkc60fb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 20:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neZaA28e+Y1fSFH4DIVCRJC3IkTnje3Gkl/XSsDaqyqJk5n0uv7Ws2SZ1fcrk6umJLKguMfjFABOAOIPi5D35IbppR5XIeSnz76JASAYOA/JMnldpkMDZppf3M32a7sgOnxUD1pR/5Y2tz/UzNXcvrlGytAME1y4Sise/ZtjTtxDQCWKqdp6DPI/dXucNppV1jgEgXp9qnpWsMWzlFMTnjN/pYaGFesrFZyN2BN2o3c29n/8Jqpo3FcubOSNxbC7GkjYX/itWhSpi28aozhKXfnGqySytyVxopY+ndwKpGXm/7y8P724aekr6Ip6YvXDIyB9hisvfLRJ7N61dM2ppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX/XFEUvIt+HZH3nOoO6waag4fYzuF2IAJvsMzzjZWI=;
 b=ZxC2gOrMrSLbZjw3wrRybzEhn4fljrezK6k9eHNkPpGEFu/YGYZuLByIf789+0lfFco8/DCI38U+rgaPTeRXuTi4UQn1W1MqY9tUwd+owM+snnBr4zPef4Qk44X8tXkcwYLomKyeM8RK1BKX81pLo9PkhhSXxb07uHDpM3UnIHipl5FhJStDK/wcIeo1caMaLejkIB/itA2DRihWg17afAh7HcxHiXuJhnfkZvthcXu0U049wWMG00Li/AysCCuLLLw6kovcMIfksXzIIZbNmFsleIQk/PbssvqJxGyJDqKmRHIjugPfjSIdp/dzKlDV0XsN7mKOItls7OldQkriZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX/XFEUvIt+HZH3nOoO6waag4fYzuF2IAJvsMzzjZWI=;
 b=Ma+N2WgNXy3qUCPBoy7MXNgmGyEdRUj2rIuZ4V+OnmUbsGOb0p9uefyPYwtkoVwSiyHP8FWLtyrWfRnugiX9zJiT+XjJawcTiQQx1onMcthfy6WFpzcn9GIgpbVsv6jupam39d8pkHzywR3BOTT/NW4RBrxjCVyEz+mc99zKnfw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4160.namprd10.prod.outlook.com (2603:10b6:208:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 20:20:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 20:20:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for 6.3-rc3
Thread-Topic: [GIT PULL] nfsd fixes for 6.3-rc3
Thread-Index: AQHZXDKJUkc5buE1fUeDj3ONlvU3Lw==
Date:   Tue, 21 Mar 2023 20:20:10 +0000
Message-ID: <2AD73E1B-E81B-4553-9975-11FA02841471@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4160:EE_
x-ms-office365-filtering-correlation-id: af51ced7-291f-4dc3-7bbc-08db2a49abf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzt/f2dpnHBhV6xMoVI2LlcaWk+RTdiXE+UhJZchZBh+tJvO6fhBFxYX4r0+BCod8cwhk/hW2o8pfghMGMClr1xR5J2xQlI4W+jrKiJbr12TWTzKugmHjp9r85kiFosI9U55cuMkaL63zWuIP9B5jhM5cK9ASnoVdSdae7R9CSFBHfqBxYnV9NhvRdktDyu3J5iOm3bWZTjfo5U5O/FATiZVyQELcrjQMxUPtoDGq0l+sMQhHILnGSbY25q60JPh+ZzmXy0PfEJq/W0fwrsUm7sq/DmdBzCgt8KbwV2F+oJla79EnNvjuzP4f9oojY6eHXr/mDW8lq6La2TXRRlyJKvv5y6JbDq6W6ho7dR7RS/ekPUoM5Br9OUIBUKbWesBGBHXtwRLJHPfol8o5ujIVW6SgmDa5MjP3w2L3SElcyL9BtyAlQjmzq/HcB3fdHeA84gV8cmL19iPYN+yR0CmetAgSbgZ33gJx9TyoktNmtmSiu6IpuWCe81wkOL1Cjgwe3hsz1d1qbh+HdELVv63p3iOfRTxHhjDK4fRLqJnQDt5ClSv2KlmCzzs3nt9zxt2avubTgjIq/ERzRgPSV8f61BZdv69qKYENUWAYeQuLESA1RH5I2cU0VtgHwOi0bHxt6U6kjVidwPSbJHlqxyZrpLFK2bpPQbg6czz3bMHEz/H7etCD2l/otpeZHCP3xxorB4TmTye9QIc9OMWDLE/eT9Wmi4VKzssDW+yLvcI3Pg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199018)(8936002)(5660300002)(4744005)(41300700001)(33656002)(36756003)(38070700005)(86362001)(38100700002)(2906002)(122000001)(4326008)(966005)(6486002)(83380400001)(478600001)(54906003)(2616005)(186003)(71200400001)(26005)(6512007)(6506007)(8676002)(66446008)(6916009)(316002)(91956017)(66556008)(76116006)(66946007)(64756008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPiOnj/XuVJS0rO9dSf4fuWpbGbMrmdMk+cB3QQOyvjHN1Qcm0vHw65NOe00?=
 =?us-ascii?Q?gZI7R6Cd+bRNLIwKA8RrMQQ2sK/tzo1dq+axmCLPSxlEpXdSmZ1IJJz5Mws6?=
 =?us-ascii?Q?3h117Zqp1EGiww6gXEkjhABd6oocrKyNuIiKrXSANz2hBD2i1ZLPja5qAubT?=
 =?us-ascii?Q?IzGHR1j81fwFrUJzJNdEahl6IEem1Jc8n+gVzH5NvPSGF2+vblD1G3Qfq0SQ?=
 =?us-ascii?Q?avO5n5Us3I3jIBfIG/CrKwnmH4DPBhCsvVhPYPi3b9hHVvk0ntx5/S0bDswi?=
 =?us-ascii?Q?BVhshRS2ky4j44UpigYRNfkxnBdXzQpdZuoNPDsAj0+gYumIpK2Fehsmy4Qa?=
 =?us-ascii?Q?BZxST+4lb43/r1UoiJ0nS6r7K6hz8i/Qm2/jO5V6BZv4LGtszcf3u9EdnxPi?=
 =?us-ascii?Q?KQ92HAXPubQPO6M/ZTOleRV16PxhfZ1O2c2skQ5afKwkjiuga2mpT5Dw4q9X?=
 =?us-ascii?Q?7gCsnWNrM7nXMB5hQ5KvZuhvT7qljPToqdlltTZVXpEEzhsQ/WASd2/s5LQt?=
 =?us-ascii?Q?5knji8bSnNam3032gUnddprm1nAYQYmoQ/+yOuHAYeNkLwPAQokmUOOBQTG5?=
 =?us-ascii?Q?IN5tfuZbwRrfrA+YBYN61vebEGmzTQmvtmNePA6rcsM3CQSdfSmmRit1I/cZ?=
 =?us-ascii?Q?tFXCIeiJU13dJOkHxKB9+qwfk6HVufbNTNanXyU7hbK0Mx61ILsia0RvuTRB?=
 =?us-ascii?Q?rXPkQjP7fUOj2P5hklYqqdF6pFxigJMs+vePgZ/OE7VF+83xJMt6MEpYGKxu?=
 =?us-ascii?Q?csQUjSgaVKuZCyPrNtfx3zfyUCVXISGaKj0N54SA5Bu9MCDMcXMiZE8iqFK/?=
 =?us-ascii?Q?AD6se1dTo3hW3d55pvZia09lEWL7Br2XAbeP4Zcj3AngujxQsBDOMR++vZwT?=
 =?us-ascii?Q?jfFX7ojvAoiC3YrycvgaeMxvnrtxsZ5vA7vMn2OngAd4r1uxBbJuEn5/b6RZ?=
 =?us-ascii?Q?EnC42kt/LrY+YGDRj+oedFO7NGrlOfEtkTsp1SowprwYtPizPrwVpmoIlPUb?=
 =?us-ascii?Q?TbRF8KCG+/GB744gOyU2EZE81s6Rgw1lLoK6bh0QD4Nc5pypa0DJ+Gq9iEpQ?=
 =?us-ascii?Q?xp7r9v7Qas+k0d4SgRA8tLBT9Xzvg+RiZfvxc4IvV9LdlV6x+LvtFeQjlnSh?=
 =?us-ascii?Q?ErdDSvAMYI6f423raWZBfMkxBN/PEngDxKESvZD0Dk0LikVSnS7cjTbf4YgY?=
 =?us-ascii?Q?2IMEqCQHtPRTT1Tr2KByrhPR0H/lZybw+75FTec9iXd9jyn6A9YCwc1GQGQa?=
 =?us-ascii?Q?UIeZAlXkOhUvGtt0Zf/+RyH2fJywcaoGHOJipJs49fCTi8ax5eziLR+AgtTp?=
 =?us-ascii?Q?oGGXNF+yl8CP+llZvbO+4jFV0QAE09c9Dj+lDZRGqs6FfUCYbDVfr4t+fCk6?=
 =?us-ascii?Q?7+8kisZ3R1DmnpA3vSCMXwzGglbzP8TCe8z2WdbEm7Ng5Zdr38/m+E7o/PU4?=
 =?us-ascii?Q?o2k2YE6WF2FSiwtJ6QNqyM4TeMKR+PXK/byEkFXhhDtK+hrDt6J4pQOr8of2?=
 =?us-ascii?Q?oiXp7rX1HyYRQ6y/6u/DaeqOtKj/+tmvlwugtGP27QNparGYZ4Uz3ryRA4Xz?=
 =?us-ascii?Q?LQOd4twvD1vztSbXi1gngdASB5HrKZxCaIGg8i6zheJaKBlEY3xzQ1Zv/CTG?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CAFE5C96ADF8841849E33FFEDA55A35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sSKT8k4Pi8yPtxk2Rzai67B7xhZBXlMZoZWHF+gmGDO5ZZ0SjINZRpC6urM9e2kzxw++rLPvk/QaJvtEuKVyhaL08+I2OYuw2XCk/UbhOKyBooxyRO08BJi+sMpoB36qCY4U4wO8KyALIqalZ5wVXQbOKkj9cD8XMlASYQtmeOPlY8FJVfhwtwtewM+OxfiDAVQJpl5jp1lnOHu+jpeQoCkDi/q0q4ch3BneeyFsAel3lf4hjvRsasl72zA1gUoPbZuJ4vSt97xg25T/16mXN+wAiPetGzvBc0hluXoVMDIQc9tf+HuP52Od4qVPGgYDC0dS3GWcW5KDbC4MW6BtCe82hU9//cVEP3avGyQ06IKpQOkWkvfXnjVJA3f2x82LHYb2gZA3pTwBRl5kSRf19Rh/OxErNReTgPGKpOB3RTSF0p8bjC3T/eoNlzG9BIsAPERP6MVinbCGeR+XfPMj7B717a2qNe/PIa/Q+ZwIh9Nx5BLNI6BqYmfAEafj1/UuaqdCxuz6ejPa4Oeh0DAk/uIaQDRzHyX0gaTsy3xnFZYePsUQEhpqoZIkNr71b/J3NaR6OxSIPbJes8bgnrMjTFgsi5QHHMS/Np6xVLziqp8+r/D8Uz13noLmjf/u8WUXt2x6MQc6GyQ2KnVb9FNtC8wq9A6ufgqoDnAXAXsSrxmWLOEe1S9AP2P8GAYhfnBA/gSZ9Gk6nUy48jM4VIY3ZB82YqKeeWQ9l53l5FPQI22MfnRX711xrpeVXRnPxeFOXR1eheujpevkqS6241YAlNW/eYe+MBqZy6sGkvSmBCoXxQFuk+4Vd8iWM5fOsoQAgdxq4gHMqt8/Jw7SyQKvuIfMvrl+aFLF3LjQRjji1m4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af51ced7-291f-4dc3-7bbc-08db2a49abf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 20:20:10.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1OT8YpGwsl08ZOhSvbjV0jWsBPmlK7ccFFiEY15jBsosyTYnHnjKI4hEJFSLEfwRZ1fJix7zb/Rfst1dlPTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210162
X-Proofpoint-GUID: CI8gv5kh9jHHjtrwjWM2JnRvhTTM-0JV
X-Proofpoint-ORIG-GUID: CI8gv5kh9jHHjtrwjWM2JnRvhTTM-0JV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus -

The following changes since commit 9ca6705d9d609441d34f8b853e1e4a6369b3b171=
:

  SUNRPC: Fix a server shutdown leak (2023-03-08 08:46:41 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.3-3

for you to fetch changes up to 27c934dd8832dd40fd34776f916dc201e18b319b:

  nfsd: don't replace page in rq_pages if it's a continuation of last page =
(2023-03-17 18:18:15 -0400)

----------------------------------------------------------------
nfsd-6.3 fixes:
- Fix a crash during NFS READs from certain client implementations
- Address a minor kbuild regression in v6.3

----------------------------------------------------------------
Chuck Lever (1):
      NFS & NFSD: Update GSS dependencies

Jeff Layton (1):
      nfsd: don't replace page in rq_pages if it's a continuation of last p=
age

 fs/nfs/Kconfig  | 2 +-
 fs/nfsd/Kconfig | 2 +-
 fs/nfsd/vfs.c   | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

--
Chuck Lever


