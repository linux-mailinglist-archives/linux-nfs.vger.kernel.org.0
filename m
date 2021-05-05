Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89B373F7C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 May 2021 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhEEQV6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 May 2021 12:21:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42874 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhEEQV5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 May 2021 12:21:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145GG7XJ019414;
        Wed, 5 May 2021 16:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CP2R2vnIhVM167afBkaMOue+poA9bqVNwbPpuXPrUIw=;
 b=qAto5j56hDwP3zUyZIAkesHXZ+HBYrpn9/uPjZte7gkkMORsOLuBAnCNtaY9PgZl/v/e
 YDF3c3EMT3G7z8bDdE8R3DdGmXm8fo1u2+ItKHaZxr9DDrZfY6zeJ1pGb7y6xb0XNCU3
 NdFrr+/3qTy0LvZ/PJ9OpOCA87FuXy8kdk8um1WzHJ42lmdUx8LbvQYS4YNFtHCYFx19
 8HSHhF0RnUctJ9U+yjI+Q2cL9e+gO24KTRbib/wvJB9fSJ+2EHzKK2Ehf04/S5GZxWOx
 LZ19edHeZ3wMXtQjpV36sRplKRv4rV4FZfKgETPggYQiROv96sVU77IZLR0JG8zPUdx+ wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38beetjdjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 16:20:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145GGHG8165861;
        Wed, 5 May 2021 16:20:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 38bebj8dw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 16:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjE//GlU0BV5oZv7/MyaJYAizo0b77g/711P7xFuNc/7dr0Gezue3xeVvx/oQ/mS54BN2CO+lsjnSTdCkt6qRajQJuRsoRvaD2RvEgFuNe0SMvyxMxxXAqGPU7/7RpC2A6LrUYA6jMGTqJOJ0hNcf9S/M86hVid+LdPerCV3lFuDJPZpTD/+dTgy49/O4BgI5r+GW8kV7jm5YUwiSePgZkMep9EhvKLv8X1urF9As7v73cm6rAm3xI44iGfPmZsWk3iVuMkNfDzbIvd3IMnHwWpz//Gs/OjnkswNybeWReYbV4cfGt291QQzwgVFui5Fay8m36YwYCPLabpz6i2vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP2R2vnIhVM167afBkaMOue+poA9bqVNwbPpuXPrUIw=;
 b=F2OU/Mu4zcKSLGU6uoIZIXs3t4PfUHsNyL3bcQGZU5rEdOaEHwfqThBRTsTn6Hn0UflSqOHKK80G2X0L6+6cZTZqC8Sjuec9dWIluR8dzeQ3FW589/SrZS7HRQmR0+rf7k8edcEBGF8GOFC4nO95Kz3mxX4qgY5gX4qsmFCJvGKDs1EHQ9IybXPLubKzGqhOztJDtEhfubOPp66uAx9gxV9tA04rResBy/mNBuo/Spdsl2A2EiFdyLxwmuPFpnAb/F+5ZUOJdEENg+CqEZMvY/W7td9Dw1QhTwsLH+LEKUnIPRzjVrWttMuV1EqkY8HmKY2+OGFLmQTg8LZHZb6lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP2R2vnIhVM167afBkaMOue+poA9bqVNwbPpuXPrUIw=;
 b=G8MrHRxUs/pUc3xk4QVY7SGkvYsPgJZAAh356WJruTqFRV09p+IDlsx8E6oTQZd8ISIYnc5FboFI3PszHF+CWuiHrXqpSHZzsDHWfnCcX2/XNbBZIwx5UtoI80M0EzqHyLS4oAFhszle8+84akpVxkJdUxVxMt4W9Ij53DRZR6Q=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 16:20:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 16:20:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] more nfsd changes for 5.13
Thread-Topic: [GIT PULL] more nfsd changes for 5.13
Thread-Index: AQHXQcqe9WDFDvSoWU+QcvJlhrAQsg==
Date:   Wed, 5 May 2021 16:20:52 +0000
Message-ID: <4FD9AA6A-3880-4C39-9A32-F22A42ADB508@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b0ff849-2178-4f9f-3267-08d90fe1c0fd
x-ms-traffictypediagnostic: SJ0PR10MB4656:
x-microsoft-antispam-prvs: <SJ0PR10MB4656C2E7E79E9B5EB8E7D26F93599@SJ0PR10MB4656.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QmoKzShehh8CQkWSXFDXFsoY8iuVraZ4u9y1R/XAtpnCp//Ph35z2zpxcgorqFKrSiYtlRO1RJyQPNdVUAO74Scdr/Dof3EDS5lPV3NYA+Vhjfuey1fK3dwv4Qo9S79vPne0TIh0EkI/YSMg4h1SNTHMA2QvO0yqa94J2g13/lvNl5HNGUSShVokyHnKepT7mu0/sO9R5Y7D2IkquHFJe71QUz/WTLt6UZleDVBBjg2xEOfxbC/8srbryl8WfUxorpG2GkB0jDwaphxhsfjvI4XoS5Rim6NEcSAagKdD1qYVvp6E1X4iaIcrtjAqfoa48v31Cxkv4VvWnk9qGhNZtlsEmCRps+oDjS+ehA/PDAr1mAUTQkZ+dq7B4vR3/8LiuWw7q6neXlTQXRYLdGtVMt1/rGhiJ0odvAl32+W2JgN8iKao0w3BtawIDOjrzf7ALHDCETGb7tSxlkXn117VsoaUtV/2iErQ7lRowbsKRG8f0aW8uwZUfGHxTYVb0v1pIDbGl+MsgF8hZuOaTdMjwycyfylyNprVkQYtcCxY2TrtFLTWR7lbnZJaPuedmb+RPZWkTB8xaoPMWkFZJn1a/qIq/LSNBm7U/Jx2b/tuMm0wp4X3T6EE608yTc+xGTUFtF4pAmOiSpMIdacHRnRVdP3YVAPKlpEPuhleYQTV8gY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(6512007)(8936002)(6486002)(54906003)(6916009)(83380400001)(478600001)(6506007)(64756008)(66446008)(186003)(8676002)(71200400001)(316002)(122000001)(4326008)(5660300002)(26005)(38100700002)(33656002)(2616005)(86362001)(91956017)(36756003)(66946007)(66476007)(76116006)(66556008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WO05+1zqzLsL1z9C5Jq4CovRWoXieJYrHcr6Yfo6nSBfln9E1GgOvamELnvZ?=
 =?us-ascii?Q?94nnhLV+N02QFVFuIsMeojMsY4sC+2Xpre3ofumxWRQGpzVGQb3DRe8H6WJK?=
 =?us-ascii?Q?fyHTn3QeZLEd1obUNFtj2MwJxZLLIu29/02bMXHxwrFFcsHysfkkRXab7Ta+?=
 =?us-ascii?Q?/do6Dlqa1uOO0B0FFB7dfceT1g7b/sDNT31rVqibZOrmG0uuMsYgrx8SOgwU?=
 =?us-ascii?Q?r0FH6YAUQOGSTWYzhaPgTJ3ykiiXR95nQKavKZ3qyyekIeq/pC2jBYxNO1Lr?=
 =?us-ascii?Q?fQcma0mBLqlfAufAqpCeGIomyU+KAXDE6pi52zWdaIZQamfKz8suq4ufwwGL?=
 =?us-ascii?Q?OwmB8rjg2ISbmdctKQeJoVzEacDejUcAe2b33/UH1bc/klwR/v+AynZJxFEN?=
 =?us-ascii?Q?rGI1UbwQNCc+Cm5I2DKEdC2z3Ijl2EWWC7F0OeNkCZoUskpXQOVjP3NRoC4y?=
 =?us-ascii?Q?K+fvlX84NOV8zWLR3ts2TpZBge1FFmAY+WIs5fPMVDXVgGpViK4QMzYvy8iy?=
 =?us-ascii?Q?4a1zNZ7o1B4SF0u1usd0j0wcq7h0Ny0svLMtNhIdHrMnfEpeMtbZl7T9By+C?=
 =?us-ascii?Q?et9vrbP6xCxBCzSuVvLiWdS/l6S9bnXv+Yq6mwQf4RgMCIzt7u9F7Nk3IVdV?=
 =?us-ascii?Q?Fe/knhuT/woPjrvDHRMR8FHd16wCTf1hdTeQJnLL6CBrVklMSCgj9BgMRZJJ?=
 =?us-ascii?Q?DReuvlGCgLJe5xXf1B7FQ16Dfx37/v196DUMC2h+yGSi/1bE6F52ySefKbMf?=
 =?us-ascii?Q?FwAFV46aivHii4YkKdk6U/dB/ZRvRlKdLCwkyaS57UhHTaqr0uzMdk6g+JyT?=
 =?us-ascii?Q?/ZPXNoUsQNXZY/v/9jjldIU4op4qo7XKPm/mIvYef+U7Y8Aqj80dBz9VrINr?=
 =?us-ascii?Q?UuF+H+BzfQZF/JihIg8gmF3B4N1KuMuL877Mto75KDRolxoItNpKgge3nl1w?=
 =?us-ascii?Q?DBsjkiskwjenlNH4a2K1Sz15GRbO6Qi2ZP+kJC0ea7lag2369O8R7bUJSgVC?=
 =?us-ascii?Q?ZPPwJi5fynlMSMGcuy/mtuD+Ckirb7HM2GmIlUjiSm3Vig77eR0l8dk3PU2j?=
 =?us-ascii?Q?trUVu7oo0bdRUSiYCjbgw/r1COHINQqz3byfl5chlDtfZsMiH28uNpBai0ts?=
 =?us-ascii?Q?LbV8jehYrrKUM7m7hoq0YAy9SGnCBp4MXw4NelkM3oSeGorKv/2SBuPPswEw?=
 =?us-ascii?Q?ujPw0bAlFQ8mMuTR4vGAPXErO1VblW3zQrtLTNyhAvL6777xBJVp+s8LNL1b?=
 =?us-ascii?Q?lyKp5s+nMUUl3SOl/+7jK9j2hpMV3XmWegnvjeO3LojQ1b5wrVQNon9lEpGF?=
 =?us-ascii?Q?3WD3nozsXvanDtop6LFj/DE9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB626FBDEE01054CB38F9C66E6FB8A59@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0ff849-2178-4f9f-3267-08d90fe1c0fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 16:20:52.8597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUPggCYdrHbcaX0UjWZ0jqLyG2sZZLXRM1XIgpVCn+YXGLATURJRpJEi4YBat7UKV4XFPQJOJBzMAvKo08YT9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050114
X-Proofpoint-GUID: jfmfJ1P1c7gHkRZ43VSQP4VsWNM6bFYz
X-Proofpoint-ORIG-GUID: jfmfJ1P1c7gHkRZ43VSQP4VsWNM6bFYz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050114
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit b73ac6808b0f7994a05ebc38571e2e9eaf98a0f4=
:

  NFSD: Use DEFINE_SPINLOCK() for spinlock (2021-04-06 11:27:38 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
3-1

for you to fetch changes up to b9f83ffaa0c096b4c832a43964fe6bff3acffe10:

  SUNRPC: Fix null pointer dereference in svc_rqst_free() (2021-04-23 10:43=
:05 -0400)

----------------------------------------------------------------
Additional fixes and clean-ups for NFSD since tags/nfsd-5.13,
including a fix to grant read delegations for files open for
writing.

----------------------------------------------------------------
Chuck Lever (3):
      svcrdma: Don't leak send_ctxt on Send errors
      svcrdma: Rename goto labels in svc_rdma_sendto()
      svcrdma: Pass a useful error code to the send_err tracepoint

Dan Carpenter (1):
      SUNRPC: fix ternary sign expansion bug in tracing

Gustavo A. R. Silva (1):
      nfsd: Fix fall-through warnings for Clang

J. Bruce Fields (5):
      nfsd: ensure new clients break delegations
      nfsd: hash nfs4_files by inode number
      nfsd: track filehandle aliasing in nfs4_files
      nfsd: reshuffle some code
      nfsd: grant read delegations to clients holding writes

Jiapeng Chong (1):
      nfsd: remove unused function

Vasily Averin (1):
      nfsd: removed unused argument in nfsd_startup_generic()

Yunjian Wang (1):
      SUNRPC: Fix null pointer dereference in svc_rqst_free()

 fs/locks.c                            |   3 +
 fs/nfsd/nfs4state.c                   | 415 ++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++----------------------------------------
 fs/nfsd/nfsctl.c                      |   1 +
 fs/nfsd/nfssvc.c                      |   8 +-
 fs/nfsd/state.h                       |   3 +-
 net/sunrpc/svc.c                      |   3 +-
 net/sunrpc/svcsock.c                  |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |  36 +++++----
 8 files changed, 280 insertions(+), 191 deletions(-)

--
Chuck Lever



