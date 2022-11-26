Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A0639742
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Nov 2022 17:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKZQc1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Nov 2022 11:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiKZQc0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Nov 2022 11:32:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B8B1CFEC;
        Sat, 26 Nov 2022 08:32:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQGE8N8029665;
        Sat, 26 Nov 2022 16:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Vst2aPgW6KHi9we/79QnsDmCZ0gcb7if1qQkY1TwmFE=;
 b=RMOu7qjRUm9FwPQaK4TWOb+UkWHtgHq/HcV/KZ+g0LeHT/RnQV/6gG1Il2zguPYRncsp
 qbFMNePF0gSuDpK9ckxR7w2Xrp1YWL3GCIh6aH4sft2SGGN/3+ifHln/jZFKvakifTus
 UoPiDIRA+yrid2xwYx7ATHQMl4OueFuIOeTT6i92kVXghE3Nek9409unmouDA15dDP5z
 AlBAC7DbeiIzBPZWr8Hp8S78J98cT90Op0Cn700PF+KUlCpfuJWxdgqgKeSwxfzatMmx
 LEJe9QkVhZG+THuB4oCbWED1oERnx0YbmcH7BejR0HDuh6lj17OVrCd060bq5IB4JvJ7 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3bca0p7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 16:32:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQF0laP022622;
        Sat, 26 Nov 2022 16:32:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1qv3vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 16:32:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcVmB6vOzqqGXeQyvcF7HI2fv6kWswku44XtgQMi33agq0N1ShFWOeoYhS33WQqHqzyOw3PP2BCznZr8AWyv6pU2/dpQA3tp4t2b9aEnYeABMt69giO1cJcAu1+QzmuCuQL7NJNBkOHL5jzOVIPco8M19pRwOP26/6vjjyHj+dIp7RvhMJeLnq67ll0OUijsLQXSNYaXFDpmgFScFwwWw99H1CLLDiM/IloJrfsWtIy1V5ModYchmbZE2uPnOND9r1xw0acwJWFWYy9v4v2tU9W1qoyuZJD1elvUtSJ3F94QLbAZPEzLxBxxheBiPR4AppclmbnCA5I85KjJMKEElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vst2aPgW6KHi9we/79QnsDmCZ0gcb7if1qQkY1TwmFE=;
 b=cTNm0bAOgjvjLncYuk/GereC4aftB+DcypPSXr8QRpd+rJ7Vp416vSEqxnX8vtkBzO3egiusJ2RS9xOEJiATbasQqtEtkpwqnatIvHq2G7V7T7odxc3q50CTcICQ4zXR2Iu9U68gilkzXIydNs4BP8xr/xsmSGxbCFPGl+XO8eIayVS8X5uVMkvjVJWho35PU9sbyn3LLo3iDwlyImc8/DFDiE71b3l0r7hu3QpFQzuJvESMcC3/uSNvIAUhiJ8LQYfEuAZXDJXClE9zfGc70vrWQeXtd28OpFW84b9QEw00iveRaKp1LbqYJ9kHJq2SI3xuhdErrAoPEO9bZvAZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vst2aPgW6KHi9we/79QnsDmCZ0gcb7if1qQkY1TwmFE=;
 b=Hv8S3MMfaqj4kOVSN6b2lYIkAZJd26x3Cczyr9RQiXLdHmpimju+PbxTcO/unKxitcSm40C6P4oUU1UyEnRZm/oqH81v/3+C3D+e8NHvXHWv+niXVFNddBVugCgun89K9HHWWwS1/OOo73Q0B5RoGCGWRMBTl4FpSfnI+PP5nMw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 16:32:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5857.021; Sat, 26 Nov 2022
 16:32:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd round 6 for v6.1-rc
Thread-Topic: [GIT PULL] nfsd round 6 for v6.1-rc
Thread-Index: AQHZAbSjzI1GQloZkEWxufNRL8hDEg==
Date:   Sat, 26 Nov 2022 16:32:13 +0000
Message-ID: <5941731F-0278-4620-AC7D-006EA5ABDB95@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5680:EE_
x-ms-office365-filtering-correlation-id: 3134dc44-4db9-48cc-f5fb-08dacfcbc634
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNpxSpPZ6nLagSgjBQ9mcOKWUnK2/l4lV4XzZ8/PWjOKXyP+J5tHxtlCvMnN7ULhTB9MJSffY2fvwyb47kngAjy2EF+SQGzMgyyXEQXja4JDMP1ofmZEt92sAeq2XUpcc16TwsrKohp69jCT9itRF9MoK6qc9/V136JZZWuM2Tzil2g3FICeoj8/Kz/NXww2u/dS6ogAdr6E5JXwcP1J9BjV7gVHubejqorgB5HRxMFRVRI7fEre6NqkLnKtPj9Pp4O19xGU38gRj4Y7rXTL4BwkF0YMrHTc9P2FlGk/zxRwdRsV/LHriDp7wHHmpeK7HnmpW4qSV9s/GoBtViEec1Esfctcnh0/fTdsZxJhePziiP32ttJ9ddGfTUU1a0mfNDwOAbH6SCcDWAFfQvngx2W+jiVLKcCArqY6BPIuwQBZTyM6kmSBDKD18ED2vNv5oivlEnUDbv6WwQsDeGNuM9apeb8yOCcqoT7HSEGcQjJ67OwPObqHQZIt7NHpPmeVqpgs/tw/Y86q2ym5QIi3k7yb3EwnJCtINMa3yyUUGgEgwSQNi2Hw900feztrEdrA7n3D6n2cjoGS9KsKpCnr61gyG3JQ1+D3nrkEJzfffAOmebqANrbYwqbeZdq/tMVGzulZ9yy7n8OLbwKyiZmZe7qHFAoGxfX9zykw13JktKYAvwB0drQ9Oo0IcjwADtk5ExUvfamIWOk21eeTMdSX/c/pfDilkRK8d35rrb9uZxYaYRHkWcIY9SGf+LiXApbX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(66946007)(38100700002)(86362001)(33656002)(66446008)(41300700001)(64756008)(966005)(66476007)(8676002)(76116006)(66556008)(4326008)(91956017)(54906003)(8936002)(122000001)(6486002)(316002)(6916009)(4744005)(4001150100001)(5660300002)(83380400001)(2906002)(6506007)(71200400001)(186003)(38070700005)(478600001)(2616005)(6512007)(26005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LHlWD3X3ceS0SYmXDqU2o+AOfWwxpOSpZUfHS+AV+c9qTgKjPiRJCmRY42u9?=
 =?us-ascii?Q?B1g1DerEKlvaiFWOw1oiX7KusZMYnf7xbv003KkN+pRvRgCCrRP/lT15m+/u?=
 =?us-ascii?Q?Ju/9b3B9I47vYtDAzu85DS4j0esT9l27+T5NXA33Zcg1MrIlLwlPl8iIWC4W?=
 =?us-ascii?Q?X+cF6K9FWkiL7VboY1FH3/ebEu+wQQHRF+b6QCDASHvE4aubm2icRk3+lqBO?=
 =?us-ascii?Q?UtgckJBxn4AH1B0KfGNPaMqHIHoxPO6ZGcRTfpDKOLkRm7FZmdXiXso50cc+?=
 =?us-ascii?Q?n3SwjTJedMFeVoySNJ5pu+wCXEevQwRl1vcw5WZl+nDSdNIsKoHYgiDPEj2c?=
 =?us-ascii?Q?IUD0/dGoamKUY+r5Q+J7a32aoQRXchlKpqUSxXvwb+INmfxOZRViVy226Gjz?=
 =?us-ascii?Q?bCdxGXG+xwzcJ62tf99poA5W2138uJoclFKHQMKIp4+xpQrhY9hnLYIxRoAX?=
 =?us-ascii?Q?QACYmX55aI9ukJ3hkxnwGz8RWUdbtC7Fqny/GJDC30D8Yfu7Xupeu6uNTYgk?=
 =?us-ascii?Q?Nz/oyAo98F0arNiDsQwOx8ogfrTo2fc2mx1WxBsdzeQ8spy+MeXZT8ffGL1k?=
 =?us-ascii?Q?6q/TWCA9oUl/DtZPAnBMG+Ip/+9r6H7CylXZ+pz4xQynqYVl54MjaVd89P6+?=
 =?us-ascii?Q?9gbr48fe8nraIl5GkJe3XhurGTWC39IwHPILGK30Sr9Yf4OJOzQu0mexLSMy?=
 =?us-ascii?Q?//lQg3AzR9Rk0UXzOzvcmYvd8Lz4+MB0e6+GKBufDnf/m23cS+6Yu7e48N/0?=
 =?us-ascii?Q?KZ6FAQ4LpBLrWgASBIYPN869joOdqrl1nD52stnEwvOL3+rXvxqdMCZOTa16?=
 =?us-ascii?Q?oWiPqMdCHqLOz2J/XAuOgTmyXA7CGfx4MgBedgWxStIaM+FrBX4pkwUgvoeO?=
 =?us-ascii?Q?1+LKtW+QZ5ZCrchcI0tSIxNeNUpNm5ZiGBEhFnrb4/kxhhzFKjCRF317wNnl?=
 =?us-ascii?Q?jItPpKnQivuICdZji5smvhB45SJHZkQVqwjo/XbOd5pTgkubeN1t4VR6fMkz?=
 =?us-ascii?Q?wdf2A6hulaVykwVgEnrzDR7VqEb7/wPs+2VtWceNDpIwpdQuFZWHqxmZf6qI?=
 =?us-ascii?Q?LBIrWUMdzy24AqYJPkqg/NXdt41PclZc8Ubnw6hh9p8f1H2l7v2dN4MfjtC+?=
 =?us-ascii?Q?PbSTdRXjHoC8o3JISyMUR1WwdHAe00CIV58XpQ9MPLyNV4DLxfGWNqprKd+m?=
 =?us-ascii?Q?Eh4Lvvcb8VbnDw0jUavzL5jxdNO9QdoFGEhWJ9sYovjCltyHd7u7WR+JjaLF?=
 =?us-ascii?Q?HAal9Hmvx0bTh3ss66luzxSlL7CjljahB8MLis+ulgu/bCOz11Svf2odYAuc?=
 =?us-ascii?Q?vAX9TB6PG+fzcoVBZYAVveBEQ0jmwv2lNwnRWVwz96n/7duDWTe+UFqabtCQ?=
 =?us-ascii?Q?P3PNT78AO43s9srze0BDtrEwcJUs60KO3hL9+N2q6XQOiPomVwdejnRTesFO?=
 =?us-ascii?Q?LpAzTbnyROdlEGw+yIfDbiYNXnBo+FMr/chuNsQzpUuyX/j/+zL5gPX0lwmz?=
 =?us-ascii?Q?Hmsoe+nCgKkm4zxji7Na/QR4Rq/dLHYSDke25Fq7Sj6dwOIMnsz5cpwNO0bc?=
 =?us-ascii?Q?1XbE4OFUTM6evwz5D6WCXwJQtZA+jQFUvcqBqTTPfYGjIrDW5JuRC1dIKoSJ?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9B7EC1DB4EA924FA13890D72C8F887D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pIzXqrw1bVCM1jyQMMGBV4snEiLDOGpJjfRW75oyy6N0pD2pEAqnbcG0S9/W88/HvSQ4mlhHd9gl551cI1pnGuZQzR3mU0Zwqur3+y5KZVgl+Lca7uG52HV0oGjaY49LVhAh7YUuvF67MC+d1RO7yOUqEkaISMC99oztfIBpSQ4UPBqCcgn+PYfCOPwKwGwToGLIv4KAFdYNGnee+Q3uTNQHxbTyG1rjDGq/HKCsLCuPYsqk9vxvcbQ9US30Dqd2OmnzX0M5Vq9HyH1UApkqoni6U7UgQy5Ka9a2Ju5fMU4H0RoKy5SAAp+CLiukb9Q98F8+zoCZiECVKpIY1Hb+Z5q9AHsRDYjkivznM14Ye9tSC0FnGn0bLy3AUNpwQpN3HrCvJvpE//zdLEVpcyii2PVbfyVK/nBKBY31M4tYqwjlWeJnjCEs/fJEc9/LOjbgE05ocKWb1681tLZ8fNGAy8vfDzf00Y97wnICNz/m4ZNzn2zSJTuEXzW4lxpJLm3Gn8xYZzu0dJl39z97d9c8kJVEzq+6tCz94jlfrKntNmCiUzLjMIa3kxkmEy30gmokaQVo9MlTmRf1e9SS8g+pdeSaEpIuKbYnp1p5qVoAShDLLZXcv3Eaw/R6Wn1UChSDcdJB33Wr339Ilrc/bm+I8rHNCCCHg5fwPYAtIA73EsitzjpMD42awps3EDdWU6qfpccaCWbWvLfCPX2JoN9OjjFDUZGtAmsxCMqofP+TD09NHQf37yQfNSftpmAuiYiE/ys4kh0YsyU8yxb3jgISyInwZSNvY4c86Hq9TFa6Vr2dQw+svXBv/VBLffXbfzQ4TdDHADl3xkUfoHofPiBEONeDMByQfPIBwlNYRUMcG5HDcteufSB6jOYmT+N8+9jD7KkA1LwBEEZ+/qOahN79Mw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3134dc44-4db9-48cc-f5fb-08dacfcbc634
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 16:32:13.6392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7i39/wArqfnaWRZ7q55k9ha5QEF8hNzKzRQvUmvexS/uqpNXiRy/3GWmWR0SkDRhLl0VE30wSAgvkxEHNUdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260132
X-Proofpoint-ORIG-GUID: zKR_IXlv4ABRPKh-4JRM5OUmFHbvAoY7
X-Proofpoint-GUID: zKR_IXlv4ABRPKh-4JRM5OUmFHbvAoY7
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

A little more fallout from the recent pipe overhaul.


The following changes since commit 5a01c805441bdc86e7af206d8a03735cc9394ffb=
:

  NFSD: Fix trace_nfsd_fh_verify_err() crasher (2022-11-14 08:43:35 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.1-6

for you to fetch changes up to ac8db824ead0de2e9111337c401409d010fba2f0:

  NFSD: Fix reads with a non-zero offset that don't end on a page boundary =
(2022-11-23 14:32:35 -0500)

----------------------------------------------------------------
Fixes:
- Fix rare data corruption on READ operations

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Fix reads with a non-zero offset that don't end on a page bound=
ary

 fs/nfsd/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--
Chuck Lever



