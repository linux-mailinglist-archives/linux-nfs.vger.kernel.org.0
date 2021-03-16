Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C208233D51F
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Mar 2021 14:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhCPNpJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Mar 2021 09:45:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60948 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhCPNon (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Mar 2021 09:44:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GDi098177353;
        Tue, 16 Mar 2021 13:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=M8gZt9mmZQDoZ4YFzZJe3OiV+ccFuiEcXpKO80FQ0w0=;
 b=TkrAlgTHdE7BptHBu5IWjLjUhlmhDSgyn5fReYDveBTLH1pxOrzBhNLLB0AFfLkR6bfm
 rAoHDO1xbSbVzbUkvw4P432NUiC6x8KsNU77DOi5l/D54zLEAKC3D6gL4j3L+mcLSxsN
 fEWRlcwFjIhySzZKZJ8FTaY+at719s4VWuywUhRfBsMNBpiglyW4QBi3td10tnfB9b4v
 kXXQILbYPqXuqYB/ZQ0dVgS2YJTK5Lz+1nt1mpoKuTUUx0RrgsXFiLweSjHQze4a7pk3
 MSq3bCmHmn8n0mlglawhHHwp+ZT7cCcGD3emsU4Pw6hdtrkvpdIe6HwMkxLp1yTUBPGl Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 378jwbgagn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:44:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GDicdO181500;
        Tue, 16 Mar 2021 13:44:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3030.oracle.com with ESMTP id 3796ytfnvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5daxWdJoElcR48BJHiAXYDjMrkZjfZwTtJAMqsVrwp3Hzp/F7Mt0sZgY/1QE9nsYPg3QBxbNzq1gD5QS3XJbHLuSwbGLpB1Pg9JvX7CYjSera7mXQuWxjVI3yThDfpkWydizon2V0FSMI3W1xukYm98L/oxs76ywTEOEXU1aSSEPQYZ2UGl8z/jofxIjo++r0cv1zEft13JPp74hyCawDp5cIp64VNwft3+RWOr2kr+7LoPW6seAtymbQghSHVqifK6P1xmb7V0QHlszStmcVjqvm9F4bwyibL6gZHcm81a51NmtvW8UqJqV4C8vWs3Z7MkgA9t0eM9PG62XWuhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8gZt9mmZQDoZ4YFzZJe3OiV+ccFuiEcXpKO80FQ0w0=;
 b=HVRe5i0eVH5V0aTpPZiJsOGdi/bqEOescnLVGbgt5qKcxJvApueRHbRS51dk4eRRuCX/h6IzNySQHGdLxplJlJxLTFcYhXeRsZ3p1hy4Z9OJsECDmg1mw4mnBjByaDlDmeFXATN1Gv4NvVFUytyfIFeNHRc6TA23C73iZ1DzSKPZhYatiF3Xzvx2gEtRDI9AFTxtv3jKF0Px9V/fY+yxRB0Z35IMtkftSdtpSyF37m5i0jhf+5z06ocJyBwpn8r4xqX02ph5QaJ8ROz6wSwfEeUiinNe1gMmC+Z9/PokfuoEXT3ixxkyAmVVtbxP8UIwzFURDwIThl56ncnLyzWWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8gZt9mmZQDoZ4YFzZJe3OiV+ccFuiEcXpKO80FQ0w0=;
 b=LuhauG1H14D8kUzOpPidMt/p5h1oYJI7KNGfdZl+lv67jfK+JTEVLd+NvHcKDC8d1Hhcu0VnAiG2bVsUjAul273mfPScQwLgo1aJtPkC7dpjuMUlav4222olR9fdyEvNSvDrfjr/hXNpGHLEGfiMpxY93xR46a/JWQKgkSFoqlo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3559.namprd10.prod.outlook.com (2603:10b6:a03:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 13:44:28 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 13:44:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: [GIT PULL] nfsd fixes for 5.12-rc (first round)
Thread-Topic: [GIT PULL] nfsd fixes for 5.12-rc (first round)
Thread-Index: AQHXGmp8qxep6JAyfUuaU/X8FV8vfg==
Date:   Tue, 16 Mar 2021 13:44:28 +0000
Message-ID: <B73DACE8-1CFE-4289-97E8-B99D0F0F99DC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c244219-d9de-4c3e-090b-08d8e8819ece
x-ms-traffictypediagnostic: BYAPR10MB3559:
x-microsoft-antispam-prvs: <BYAPR10MB355923507A1EA663E9159DCC936B9@BYAPR10MB3559.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN2R3Q2xKgFLq6w5sSKuhUxzOM+gu+o9z4VIHbdTyuJnFxt1HBuhBGQurnenUzlKHAtYFd71qDUOwE9rgKNZqZ2ZfwCPs/cCJJ5U64nyZwbeRQ/unUZW47Bs74wKV3IsluNXs8ipvx2ik+3GvyptU3h2nMOcgsZ9y44lWPMY7vkYNh05EG3UW+Uae2iRNaVEOeE6CMX2FBNLGlMw9al5vCKpXZkPXVdyW4HweBnshIXTqRiINFQLmXmfLdW7ZZG3tPw/Q371Dn/iuojTdBRiKdRHZyXWIvJ9oZF/Ud2E7Ek4l13so+PalZCCCo54n/bFtKC+eARS93oZrtQRfKcwQurFSeWmzELXq+cxa+2SwdDNsd5LRoC1PFvLH13zao1jmywJ38sCVTWqN1zp8df78AWBroTvLII2wjF8oL2J3aMfk5LU25YK+XlrW/jaOE+sMebSsfitEELhoa/qECtNamOwtU00B5Inbpu5tnbvaQmCJylMjmDZnD7ewZ6T7GZC75okMorYUjW/MC7h6GqHuT3s/wz506XWdB0QIa0nMhUKuO+baMCpksvbOuIcmA6nkfJfbkCK/u2J1/zK1WxJoG5LThVafNa2AlpFTHb4UNJAwCDpzCKKzXkqq+I/R5Tf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(6512007)(2906002)(54906003)(8936002)(316002)(8676002)(83380400001)(2616005)(478600001)(5660300002)(33656002)(71200400001)(64756008)(66476007)(66946007)(6486002)(36756003)(91956017)(4326008)(186003)(66556008)(76116006)(86362001)(66446008)(6916009)(6506007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7LQTED9F1p/bGmac3P4xC3qXqkh3Wgpu0HPwa13m/iPgOFzuGm3VSv+DOm61?=
 =?us-ascii?Q?oXTpBzRtLGVGtkFWJ72L7irZgXYX78fiuSsWwTsawR8pA/8wxkVBQCnJS4mI?=
 =?us-ascii?Q?JQKNHmSX21g0twTUShgtC1ptgaGE3a2MMkfLPNNbhUiM/h9/qmLneKJmwt98?=
 =?us-ascii?Q?3f8ol5QVHd3k/1R4oe1MUbIGY6/pio9HkJELpt/r63JPhyg4sNfL/E7B3zBl?=
 =?us-ascii?Q?p49bfCeZcG4okR6BDr4DyLrq7HeOPQHyInxx1F3idDn5XsILzrlxRrhoIhTo?=
 =?us-ascii?Q?7q5iyOsMyv3Qd0ipw1f2XJ15JiQsvY2Pdj79V72khIrqvIcoNpANWCrVw4YA?=
 =?us-ascii?Q?yCPJJqc4BzSjmjlwwEagBeSGRO77EtDbHwUeX7ToswU4xChbTJWDRjCbFZ++?=
 =?us-ascii?Q?wrceKEnKJgtfyME8GIM+DszX6sSN8wZwLdHFhjqXSjMi1ZgQdRVHeH72WbEe?=
 =?us-ascii?Q?BBlhFvmNEd+ntBr0QPNJeu7G4FWwjYuzaWoAXZjMYnUk2gfhAOiKPnwHEQCO?=
 =?us-ascii?Q?wq5n55z4g809HMy4yENsdE+YBELBXbHi3wQsRgSJm/fY99oISStA8ojxDRC1?=
 =?us-ascii?Q?mN4mb2fH6jNfg0+dSMb/0NFrUWyNXhwALFH/mxVbQzkU0LDnPHFs75EL0JGz?=
 =?us-ascii?Q?3QaRZ2tRt5dg5QOVTfIUuCHI5Kw/Qaq70vgG6xyaY65qYokMBYtTevObj7KM?=
 =?us-ascii?Q?iums9o8lLcnIlfgedVa0wsZ0KoFljwDD9bctShW8KOhP2eNqVOMY5MDtLimm?=
 =?us-ascii?Q?F9/WYXgsNEqhnOLsjPcgSw6dPVG8OPCrKjlrsRUYYHhSHgOZJvyIJMKWrxxc?=
 =?us-ascii?Q?njpBG/OISQ1pvAjjUHHeWVe+O+V9Sde+1dqDY2D/AgTsIBb09HLHAk5m7Nn9?=
 =?us-ascii?Q?rT74l+VuvvalhKRGRwXGb4TnxxoFponpqMGFp9CaLV6GHP5F/pw9RZul972g?=
 =?us-ascii?Q?4x+bG59YjTFlGYysZT+8bX5fvmjCZCKQhxXMkHOVfY26YV8lBT7F9xAFCHJt?=
 =?us-ascii?Q?ZF8AaBJW9eTIKnOpYkqM1uF8gAxoy9NFDjm+0oOBL3RUTDaSC+piLXrOXbN+?=
 =?us-ascii?Q?iv/7t5WFBfZ7t7bVbWSEOlh+gTxX09v3vpXCOBjC5hb6G8HCztrpTpLlm184?=
 =?us-ascii?Q?yCSxrOSqAMeHOuHun3hssv+RvrmVwiq+nH4qTGe4RAIXm5tg6Ef5lN2sSjhE?=
 =?us-ascii?Q?OZq7jIDjkfM3ztJLyr6PclOf93SIyC8Lt4n9a6+nyC9u9ZWq+qsxaGWHE22M?=
 =?us-ascii?Q?ek7kXECDe215e+vcV8oYRHHsjCo2HMXkaZN1UXoWcfgUYo+ctp7Y3/822/aK?=
 =?us-ascii?Q?uEVwTBQEz9FyubRnMGZHxW76?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <382ADDD75B4CC441AD730757BE27A497@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c244219-d9de-4c3e-090b-08d8e8819ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 13:44:28.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWlIbJDpJg7NdGNqXtbhcPNxWV2OBdIAGLr6XVZg0fTh472jhVPP6VgvLNRqQ6CgW3jxha/vl2Ld6zd2oEgR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3559
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=978 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160095
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15=
:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
2-2

for you to fetch changes up to bade4be69a6ea6f38c5894468ede10ee60b6f7a0:

  svcrdma: Revert "svcrdma: Reduce Receive doorbell rate" (2021-03-11 15:26=
:07 -0500)

----------------------------------------------------------------
Miscellaneous NFSD fixes for v5.12-rc.

----------------------------------------------------------------
Chuck Lever (1):
      svcrdma: Revert "svcrdma: Reduce Receive doorbell rate"

Daniel Kobras (1):
      sunrpc: fix refcount leak for rpc auth modules

J. Bruce Fields (4):
      nfsd: don't abort copies early
      rpc: fix NULL dereference on kmalloc failure
      Revert "nfsd4: remove check_conflicting_opens warning"
      Revert "nfsd4: a client's own opens needn't prevent delegations"

Joe Korty (1):
      NFSD: Repair misuse of sv_lock in 5.10.16-rt30.

Julian Braha (1):
      fs: nfsd: fix kconfig dependency warning for NFSD_V4

Olga Kornievskaia (2):
      NFSD: fix dest to src mount in inter-server COPY
      NFSD: fix error handling in NFSv4.0 callbacks

Timo Rothenpieler (1):
      svcrdma: disable timeouts on rdma backchannel

Trond Myklebust (1):
      nfsd: Don't keep looking up unhashed files in the nfsd file cache

 fs/locks.c                                 |  3 ---
 fs/nfsd/Kconfig                            |  1 +
 fs/nfsd/filecache.c                        |  2 ++
 fs/nfsd/nfs4callback.c                     |  1 +
 fs/nfsd/nfs4proc.c                         |  2 +-
 fs/nfsd/nfs4state.c                        | 55 +++++++++++++++-----------=
-----------------------------
 include/linux/sunrpc/svc_rdma.h            |  1 -
 net/sunrpc/auth_gss/svcauth_gss.c          | 11 +++++++----
 net/sunrpc/svc.c                           |  6 ++++--
 net/sunrpc/svc_xprt.c                      |  4 ++--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  6 +++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 82 ++++++++++++++++++++++++++=
+++++++++++++-------------------------------------------
 12 files changed, 75 insertions(+), 99 deletions(-)

--
Chuck Lever



