Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08E7321D88
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 17:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhBVQ4C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 11:56:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhBVQzP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 11:55:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MGhsiQ180905;
        Mon, 22 Feb 2021 16:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=y1yTf9d7bQd9TlqHzCvdtTHTiZlzbPhouLMbIg/Tg48=;
 b=HxhgdGIZHw12e/BnUBRNb70Ojfbeg3E39n07LNDAlk1LHy8UNQNI0spESNCGFSFqbWQV
 +s4uV9KYjLnNSqoAc6fGUanXEZmAptjNWNd+peSUAdHaQRuppu+aEXffOM+pvTGUF+Au
 GGIfsfF55XsVFjNmE1Rgx0oXKbDmcdYgbCZLg6pFfTxEFtEbfcZ0o48ekWJW+F9Otsa3
 FP55BgfHVEZ1v/H+KWzlQ4LwqFxYsjWEeeXeBxGzv/pBi7DFd4qG80YcZijP+2kqz7Go
 AydUQXR2hzAxnMYu+i26L+vPtaUie7hL7JJcJW6epPiWDo+ZNoNzJ1AowKwUhFAkrnX4 zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36ttcm4atp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 16:54:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MGk2iL088977;
        Mon, 22 Feb 2021 16:54:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 36uc6qm79h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 16:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHAC970rm7HCuEqlTx+wVx7j+ylSYNAPD1otmRuwO1Z2YyC9Umw38RiLKfvNOASmArfZHnf3D524tM5asdV8YIYgo51iIs98CgEfm3R6Koa6uO/P6DbJ14KnemW2QuuZN+ocTrvxl87JFVvjbec+kRVISU+DDijjfB9KLZx5P81uexol7d12kK/9oddR4JUyOrydsfAjbzULSHPNGVQhFLabsDcGvoNmqbixc+w6fAx4bGw635oNcN1wdBMDFHH9eORnTNUzEQiuZXZjWMWvRNwQ7AUmT4jQZtjLjcAZpM42RYj8xtdAQToiuMACHN1M8ObAKomyjSFU8Ck5qUnhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1yTf9d7bQd9TlqHzCvdtTHTiZlzbPhouLMbIg/Tg48=;
 b=CeJM0BBByhzs0/0tou64IumtjeLPtdxjjP0Cpcas3rN3m4Cs6zUypK8XCUpZfztEmfIKEmljegwluXVUijW9OquotpycU3mMdEMvDQthpRw3roya87U3I35fBOFdRTrO49spS16OY8GaHqag+kMPyukgoOg+jEggFZG2KP0VdnVXmleL+9B+JxUc0tPIaGp5gbG+saPOflzUoRgQg2BCUw7zQDN26pLtMdg2x2WTOSZQQ0KEWWxgVJg6AB4SCknIf5M3PXK68V4GfH58eNlbO+xEL3NLwUkCRE2c+TgZBclrqz/CkR7z6mCZD/axBVk12jSwSTFVSVSg0Pxp3AMjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1yTf9d7bQd9TlqHzCvdtTHTiZlzbPhouLMbIg/Tg48=;
 b=GBmkMUS7nGID1rPGLD/yDh+MsOwDrNdX0kx8c0kOG4q8Hwz7qF5XcZNv6Y8IofAW4eTSPjkA1/nVzltlM4Qc21X4shkHb98mO+tGn/SrmVC+k5fOwR4d7ILBUoRz0JxgAc8fjCsjYcX1PjnlWbPq+63yNlndcnY1o7YGAQwaE44=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Mon, 22 Feb
 2021 16:54:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 16:54:23 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] a few additional nfsd changes for 5.12
Thread-Topic: [GIT PULL] a few additional nfsd changes for 5.12
Thread-Index: AQHXCTtfrnY4JBXOSkineoZugudB0g==
Date:   Mon, 22 Feb 2021 16:54:23 +0000
Message-ID: <73C9BC02-D5AC-4F17-BEAB-1BD5D99F5D6D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 372bd451-50c5-4ff1-53bf-08d8d75281e2
x-ms-traffictypediagnostic: BYAPR10MB2966:
x-microsoft-antispam-prvs: <BYAPR10MB2966B46590248BFAFB6C702E93819@BYAPR10MB2966.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qij04QhjJ69UbO1TEBaeScC/WbYgjjFwWxpHIX6PVkjRKwRufAXd/8K8r+xaekLR4nIO3VDTr5hkc7rvDB5UsyjBEjueMWHYpe1RfrKgyhrDTlZA99gROg48CI8E6z+NC3AAAyg5of1t76Z7SkUHTj2AEZRCdix/qBgu1x7XjU0dnPjxkyQ6TdnFImBFtfxhMzECmle7tf8eEZGNFepeLsGlqhWeet0uXWuOgn4UNhNvfzaMMY566QtnnqdMfQKcjb/vaxZKjYQIiwBiGTxj/KJL7qGmber8e2bZwAumtx4k0ykdzWSs0Sw5he1PidbpZWsHW0/BF/ocRkG8MBanobLzB0hU0Bo8lMEDecsjWXMBPNTWunO0UK1tR8js8c7G/tBZSCepTcImKJJUJ/degnpaQcIiH9J5/Z7M/PXYGiUuIEw50OtfmaDrKhWSPiwAFwT+vzks92L+F/gwgztpejwskZoPJwnMfGTqoadEEkvVdweySwzSA2FGDyvnGuyWYhA/Jmi216yEWb03WGCVO2INzxxSsdapCVeFObLIrbL75M9KeakepihVzBGkyYeVSMQJK50w3MaU/6DH1J1D1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(39860400002)(366004)(316002)(36756003)(83380400001)(6506007)(8936002)(5660300002)(6916009)(8676002)(6486002)(66446008)(6512007)(2906002)(66476007)(66556008)(64756008)(33656002)(2616005)(66946007)(54906003)(26005)(76116006)(86362001)(91956017)(4326008)(478600001)(44832011)(186003)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lRr3aVoZWuuNA2J9IAfqUSzR4sCiAe3qHPamNW38pd7w6WcByHN6lqnthd7+?=
 =?us-ascii?Q?GpZeOP2rfdTouLvPr2sE4BfWA6xU90CS8i4XwrUwKPr0KlLMQSgNlIvTkSkY?=
 =?us-ascii?Q?Og9pg5NQ9zjtU1QVJBHqXDV82BvUwoKtn5wKWYb+xr00msVnJuuTEU3n5W+T?=
 =?us-ascii?Q?bP+GyuGFfgGkH54BGGdCryWEeLMFQRMOq/sExlOXpxsEb9ofqwibXdZCAdza?=
 =?us-ascii?Q?Viwcgeelc7n2asPjpoDzg+DIdhc51ZZJTG5Vf7sEIJ67UzCCY5SgorLmrQkG?=
 =?us-ascii?Q?uB3hmGiwwSGfXagnb6uBYPdtaEXUSUKgJX3kcr5hHzUCw2FMNPmpNX7lPG6g?=
 =?us-ascii?Q?lxL7O6fmNuyxDUc62KjHgkT9j2qO7xgJtPFG3uBmPKxKM3ONpMAdfGTKeScD?=
 =?us-ascii?Q?cmttS1pTJ38oF9ai76BLeLkC/nR4d3mITAWq0vITno1I1iIeltVHt+xNqLC9?=
 =?us-ascii?Q?U2QVe5bAD6TmFuiZ+wlf/1z9QhGat3zofeA17/rGlIzK0qXq2ngQt5kmwZJD?=
 =?us-ascii?Q?2xQv430VPhkoObCRYGUKNXay3L7nVxor63vtEZl7YhSOqOU8fQWtxB3ZQucz?=
 =?us-ascii?Q?lOHJaOABek8NttnaSe+AxqUm1ViyM4DQ6qUz2w8SbnvcUPZp4bU2jAe7JADb?=
 =?us-ascii?Q?OpxClbgcVsTcnt0X05vRzwMdVUxWq+c1kWpWrLzIsGGgfSJSV4xeHdExZKfp?=
 =?us-ascii?Q?8OVB7AD3cBWcr7kjfjZY64XIxptX8XYZnWob7WzK5cqaZINcEPxAquF96J+z?=
 =?us-ascii?Q?gVUaQY5EHru/oktY8hyppyOXNmdF0u1a3v+0PXMVV+wbRSXA+SNJyF0QG3Zn?=
 =?us-ascii?Q?ZCpW+IE7S+/DoCVVlF1UM8s6PpuJkk3r9S2n0qE8qT+3DQUl87HqggemrZfK?=
 =?us-ascii?Q?GIcR5PWsscS/J6p8jsTZVcIr+zlG5TsdMyv5u150+beQw5O1yjC6M9R5WG2j?=
 =?us-ascii?Q?8lbtyNMd9+M/cT+ExRookvO29BNrxyuNhV2z8DeT7k2OyfqBbj5gu42gPnnA?=
 =?us-ascii?Q?1trSTojETTTc/3/emUIqeKX0TXmQ3Xo8yW5a8046NuXzc4bHUXeGpQoW86uy?=
 =?us-ascii?Q?suj2oOivNO5LozGxzdBQcTScWOjn9fFOU8hYsA9Ne97xfOuRS7Rytw84m7eq?=
 =?us-ascii?Q?t7KkUQbH1JawyG2YH6N8vc6AEt6Sw2yZiT2nF+taFIK+0BQdl0xj0qYKQAgq?=
 =?us-ascii?Q?IetFsHRbmJC8PA2MABmIOyp4Yk4Rx51yRlWyeRDogEinG/+vNQpkzb6yEs+W?=
 =?us-ascii?Q?LNXmCxpI+6yBCPV/Ult66/Acs+Nru3RI8UfWMyCoQOeoebXyobXtwI+VurK1?=
 =?us-ascii?Q?bV2NnrVs7tEC+RRZCFS/Gat2xoLgRutHXJo9zeTSxDk90Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C2A7CA2D4177F488A7A3F4C15FE63AD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372bd451-50c5-4ff1-53bf-08d8d75281e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 16:54:23.8402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84wU32Fuw60ZxYBrrMecUpuRTkRCEwd2Mq3zWFy9yKXGcI5EcJvxCW9RaFQRkUQ52rD99u4R6BEbuCYstLfLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2966
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=994 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220151
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220151
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

Hope your power situation has stabilized! Here are a few additional
NFSD commits that can be merged in before 5.12-rc1.


The following changes since commit f40ddce88593482919761f74910f42f4b84c004b=
:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
2-1

for you to fetch changes up to 4d12b727538609d7936fc509c032e0a52683367f:

  SUNRPC: Further clean up svc_tcp_sendmsg() (2021-02-16 12:38:12 -0500)

----------------------------------------------------------------
Optimization:
- Cork the socket while there are queued replies

Fixes:

- DRC shutdown ordering
- svc_rdma_accept() lockdep splat

----------------------------------------------------------------
Chuck Lever (2):
      svcrdma: Hold private mutex while invoking rdma_accept()
      SUNRPC: Further clean up svc_tcp_sendmsg()

J. Bruce Fields (1):
      nfsd: register pernet ops last, unregister first

Trond Myklebust (2):
      SUNRPC: Use TCP_CORK to optimise send performance on the server
      SUNRPC: Remove redundant socket flags from svc_tcp_sendmsg()

 fs/nfsd/nfsctl.c                         | 14 +++++++-------
 include/linux/sunrpc/svcsock.h           |  2 ++
 net/sunrpc/svcsock.c                     | 35 +++++++++++++++++-----------=
-------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  6 +++---
 4 files changed, 29 insertions(+), 28 deletions(-)

--
Chuck Lever



