Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C5C414D8B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhIVP54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 11:57:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51832 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236323AbhIVP5z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 11:57:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MF0PBw028880;
        Wed, 22 Sep 2021 15:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vWx1oyqxLsInm6JO28K3a3yo4xmfC4HLzP5C42mNaZk=;
 b=PbL9G0sqTnFh1BKuo4n152THyVvOnSFnnWDVcrw5Mvf193b0UIUe6YM8k6dTrVUw7PpY
 dc9orGUAaeOHhB0LinAxXlIlnz1pCQgjOxaQdsCp1wCuPY6QGG9LaQLQPNM5tXYbiqQB
 b2BppT5a3oYMETYxV/13uvThZPHCsyQKF3Tqqw94X6+Cp03iIwZgi1QcqZz+VsJcaFg4
 m+bh8vtKzCFU7uNd18IX8HEm8ByKCo4rTg7CwgR5Qc0wJCcOEZJefBxpefv7762E+MgF
 nl/cvUYQ/seRFv1EQrM9Vdb8nQTnQSA3ttAlFg31kDFr2cLop7y1JotKcDWO96VcizDy +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rd7sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 15:56:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MFkHNN154832;
        Wed, 22 Sep 2021 15:56:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3b7q5we8ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 15:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aip5iqYfB4QEpvvbyv82DILK+IE0LVhyDSSO3ikBiiVY9ymCDRtqjfdumf0GwBXoGWY0QbGahIZs8IoOSUOl3yB+xbRklSN9f4nCha8UnDNVwhrFpy7Tp/tNaFzZekFMI6ifKEC2aIB0/qorNzSXD8c0qcXlZ488aE8wBel8a+/7pTFaVCmUhlRt1sWSPKgaYxBVdwAVPyDKoZJpgOO/HjkE7BQLfaMlfShVfPwGvljYR9uYTl8CWsKFznq4NWd3mklEd5NrzL/wrcefHT83ue2QC3XLAWxhh9R2ixa1ROPUZE/vMQ8ZMnw5Ni9Op1HW3dn3gLAZb6Ky6RWUwxH1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vWx1oyqxLsInm6JO28K3a3yo4xmfC4HLzP5C42mNaZk=;
 b=YaXDUjRpMTwSxDZlALwYbXY1l8hHffB0qK3ZK1YckCRdR7JP7hjSWwhW+nbrjGIQuyB/ts2AjJGIiRLg/t4rnvHBIDMOqfE6zkI8fs1gr51M0JB/J7u0OT1Y19pRBTUVw9KTEMl/eu8PJAKApUmO1zxhtPcVt+rkQFK95IcD6dgmOAf+1L8SBj+GTJm3F6qjAb+z19yJ3zlbnZ9nDyWOm1hoHl7JgvO4WqCg59IwPso3Hrpn+Bbo159n4Fz2AnfOjGxuTATNNTbknIFjQRr1xDAK60CAOB3NEmKIWnMhjgMrBxuUWJI+qGRu7YDKNqir1LG8KW1/6+uraZqVvVwFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWx1oyqxLsInm6JO28K3a3yo4xmfC4HLzP5C42mNaZk=;
 b=rUNdxSVR+8tpRNWwhA7aqoBfi+QBFfZDNhv/FpPORx+Eeiud4obo8n9Y7zULZlsIOfrKUumqWotDxKt4TEAUKQxnWnz0IEHvja+rnicBhOjInrcSbyUZHl10tp0kE+jPFYckqvOlcPg25HHFdNSrRg07Ep2FswQR6eRC8+6KOyQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 15:56:18 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 15:56:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] nfsd fixes for 5.15
Thread-Topic: [GIT PULL] nfsd fixes for 5.15
Thread-Index: AQHXr8phIZZnHeWGVUiYICtzhbcuxA==
Date:   Wed, 22 Sep 2021 15:56:17 +0000
Message-ID: <5EFAF4B5-BAC2-4A6D-9C33-07B714FF00B0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0af47ce9-716d-48af-c41c-08d97de183b1
x-ms-traffictypediagnostic: BYAPR10MB3047:
x-microsoft-antispam-prvs: <BYAPR10MB3047BB04B89B30658EB9986693A29@BYAPR10MB3047.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:359;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIis1lpASSSQLxJJfTA6rIaRsC/lFcz8uk9zhc/L9j+IJF2y8y0k+4nncbYUJD7AaSltKrhvuZmOXL3f1jHebh6Nwa4TYXdBqhRRFEXI9utkInykowLY1W0a1fKkydFlgN934ZFfzSPS9HtIat6VV818nrV1v7RLMntezrHndPivvH6p3qTpmPBr6RxPhD82LPL+VjAIDHOzHqpd2e2hnMh8H7I1kV5vOPs2170vQ74pA3jw4yZiGhEslWoRbyaaCvbMT8lQtidHUdSbtHo2uL9pV7yxVjBoJBfmHq1wtFMIH3EsAniT9b12C3TCN+mPM8aVpYARvFB6rNLGyLvAxFEENVyBW31pGtE/OVGEZtg0pnHMEGi9hFM5LpLXT1S9wJsW2Mj/GXS/crrE5LYHyybno2wj8jaI6Ev3MXCCzxWqfOBYWuCEkYHjSBUxhyzdaqbEZosyFkxfI0ONcZbK2nBwImleDPEePVcS3CqfmVZPJMBC2G4GPVbm5/4gG4oLWvp3jG7F1Nm+ero5E/rg94ulrIfyqYxGq5fyO28qsLvT7blHoz0TZnOoEeUcVt6JgwtBC/psMerPl4qj7yJEcomqpR5UXU51IIwh6hAuVOn5mQtt48TJG8q9zzsfjjxXdhMQaRwthRlW/frBX2jqH3kwfe098/vGecpqfTXyUnJrNrjDYGVmObxolQz0hcwu7Z8mn780/enEqu0bJwscuyE9fQXLjrb19tCo6CmcMvh5dPj/kCEX9kFhjSOiN03w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(508600001)(2906002)(36756003)(76116006)(91956017)(66446008)(26005)(8676002)(2616005)(186003)(83380400001)(66946007)(5660300002)(66476007)(4326008)(66556008)(64756008)(6512007)(6486002)(122000001)(86362001)(54906003)(8936002)(316002)(38100700002)(71200400001)(6916009)(38070700005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DdGiduM1fgiFN6/0W6pitTD7HKI6Nvh77L5o9tcRuDPyN/Gi8fBFuY278QUl?=
 =?us-ascii?Q?bekBPV0DtNnnesrYsKjqAv2sU/ZMDEVlvXgPo/wWJQAFbZgQVUlI91E52He1?=
 =?us-ascii?Q?O0uF2IoKRMTmfEQkT2obbxctVHE8KXR/W82RngZjd61Wc7Vgm0pDGRet5kdB?=
 =?us-ascii?Q?KgEliCYJAqmQFzNBd7nZEGEJ7v4Hy2SK8NLVPqAaTEJBsOQV0OFcUsDuyjjG?=
 =?us-ascii?Q?2aWg7OMf6lI+ofidChBaAdFIVvev6x88fdT65r0P/cyVijoIkLKbmH2L+fSX?=
 =?us-ascii?Q?wW6TgnUBKD3+cZFpd9HLYec81aPVq995YmKoEHnQ3RUQoOrN46dEK7ijZ/Dh?=
 =?us-ascii?Q?oaq4qixvkrI+zp7YYAIRdKRPsZb/LBF/uNe41X3iGOLoNj401fgPsUFrLaQJ?=
 =?us-ascii?Q?a5a4n+ys5rL1Yc8Dbe2zbjG1PWvtnCgJ67PS2hjv1MgmaHRUv+8aZ97P8QQ7?=
 =?us-ascii?Q?H9sSXo9FJsyGon3ECEAhqT2uC4y4ZMJk8HoohHRO10WOKUkUOilrSGO7QqlL?=
 =?us-ascii?Q?oYKu8HZbbq3RaGaxIo13UKOrZxj+UaCMFBJUUkvpCfuTJp8MgKQzJfcWScbm?=
 =?us-ascii?Q?RoNLrbsRt423Synz9waxbq7O1m1+eULyva0lDILmY7aWC5fYaK29rRtqkcBP?=
 =?us-ascii?Q?91EbfvyM4belrH1TNxuQqkoyQ7idsWhrKhC5p8HVc6xERlmEEbK7F5+Hf1s3?=
 =?us-ascii?Q?KLiQYqiqmYlZo8A903HkIpbSERERJV8St3I2YkCviNkszagtqoLnZ+MSbCnr?=
 =?us-ascii?Q?Mzo7W6/tcy+1qVMY3QpcrfUOkBQKmRHbVZnlkATtmqxcERY1fBNYdMZ3CDqk?=
 =?us-ascii?Q?RNUjTrvvgC3UUO39TI/4q+FvPCtxrbKwFMN9mw5deLA7rmm97HEG0mj6WBaR?=
 =?us-ascii?Q?PV3BryWcC5/a7Ti/qb5NdhHQh+jvc2YRw/hqfNq60abnRxGNjBCxWYRg6CZb?=
 =?us-ascii?Q?fhtYc6wblUhbqitcaT7jPEyVMAKJ/m874i8y9qIi6tk5B89n/i2+6wncus9x?=
 =?us-ascii?Q?g9jyMsdyCjR8E+GmBUBZtPl6NTdEC9XQLgYFAvf8/w9wlUVqzdmE/shd9lQq?=
 =?us-ascii?Q?EqOecSsDYl9/HgNo1YeowrZxwqQNdqGVKujmwkZhGpga5bD+9fW4duAvDxBv?=
 =?us-ascii?Q?xCIvM9YiopyoYvg+3UWReFpxpuASiUxafJRdgcGGhSBCNDVoutBSCfQ2SuoI?=
 =?us-ascii?Q?q31Rrszp9TRaASwRaRAghO8Vx8U2n1A7YCMoxPUfrntr7OIW0DIdsWI87eJQ?=
 =?us-ascii?Q?xyxRqypAFP05GmvBjq0Z5MFJpW2lVbB2uJ/DmQ24qxgAf9UK3r2DIoK8Mv3h?=
 =?us-ascii?Q?NyyLG7I5E8ng1WNBuqOOEnDd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6829BC59B84BCD498D151FC21A8D5A90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af47ce9-716d-48af-c41c-08d97de183b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 15:56:17.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10yY5WThx4FVus3ifEA5b7PdnoZBPBvjWmmYV6SD97azmzTpc5k1C4QxjsPf7nJBaN610r+ng22MF7CsQNafGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=936 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220110
X-Proofpoint-GUID: qaLlAYDPOoW8dHegv8nRbZYanB4I8BvW
X-Proofpoint-ORIG-GUID: qaLlAYDPOoW8dHegv8nRbZYanB4I8BvW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

As reported in the initial nfsd-5.15 pull request:

- NFSv4.1+ backchannel not getting restored after PATH_DOWN

This PR includes a fix for that bug.


---- cut here ----

The following changes since commit 0c217d5066c84f67cd672cf03ec8f682e5d013c2=
:

  SUNRPC: improve error response to over-size gss credential (2021-09-03 13=
:38:11 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
5-2

for you to fetch changes up to 02579b2ff8b0becfb51d85a975908ac4ab15fba8:

  nfsd: back channel stuck in SEQ4_STATUS_CB_PATH_DOWN (2021-09-17 10:35:12=
 -0400)

----------------------------------------------------------------
Critical bug fixes:
- Fix crash in NLM TEST procedure
- NFSv4.1+ backchannel not restored after PATH_DOWN

----------------------------------------------------------------
Chuck Lever (1):
      NLM: Fix svcxdr_encode_owner()

Dai Ngo (1):
      nfsd: back channel stuck in SEQ4_STATUS_CB_PATH_DOWN

 fs/lockd/svcxdr.h   | 13 ++-----------
 fs/nfsd/nfs4state.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 14 deletions(-)

--
Chuck Lever



