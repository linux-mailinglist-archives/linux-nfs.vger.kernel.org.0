Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7526706AB7
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjEQOOE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjEQOOD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 10:14:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E4E8;
        Wed, 17 May 2023 07:14:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4nYG014821;
        Wed, 17 May 2023 14:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0KTTP43zKaf0Hp5hHoTF8CKWTKL8ITcaj+hrtvuZkk8=;
 b=0mVEr0aomMJVDzaEolfFSzJmD49XQ4HrrGyvklQmWsSRqIdepv0pPvZyKAuhjSwbtCp5
 kC1EM7xygSyexjZHQpqqXWp+rbLyZFxgUzAtqDq6RUV2T9epZcP6wM7RyDj5/Mp7xaZH
 dnMnD8zFcC6vli7ak5/qD9t0vtJQnANUOdKnq58z1O/E4L/AwvdoVHE4oMhefJZBfycr
 2HL040w/xYycvDfnt29NF1k13kEVuxi6LLs3tGQy7R7f+XwX1+y5D2f93QKy5yFlzFvv
 xo8LFAoqH4B21ZOMjrnUPyCLR/aLBOn3rMC89eKvo78y7pUzVcdquW2AI2h5VayQzVAA JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps08vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 14:13:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HCVBlu036167;
        Wed, 17 May 2023 14:13:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm02g0qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 14:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UepMYg3k1dBCPsEE5Cc/SQChAOQIoGaktjILPqjWwL58zycg8xKj6FNP8BVflc+1KEb0AM6jmNCyIxVFpsjwDetIG8oaV9o+tdDzhj9H8XZN3eXmGAMUyW5OjjfjeTjfXdCgn9xtlW7Soe+XjE+jlDhF6L/dg+2VlghtakhPwICIKBnjNfUjUj8OM6t33E9P4iNHqnbFI959yvNZxO40//3AP962aopheurn6UTldDhLwcUig3nfRB3OXNuJ6EkpNVtXwPh5vZA0sPG4n94dED1GhRO8zSkD6Il6QtqgzByTImYKH7DO5Zj2ZsqTT/ObvjCTXubG819ytXz6vQxCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KTTP43zKaf0Hp5hHoTF8CKWTKL8ITcaj+hrtvuZkk8=;
 b=Dcp5Rt9qNVpmt1RRwerqq2dCIpq5K8Iv7finG6nHfiwLNTuPo7BucFhMWXgEkdRgvCFHLqjxNHdppZGww9q5DQN0qoRweO1eLJKSLrM+IXESHpOvvH1PP2IyXjo9CwUq+SIOyF+ZjaLRdqZbmI8QuW/g1HVvBZeoF4ZyyWHyquvJpXXm2FoZ1I1X/L2k6tRBlseTaq7AIRiFT2QwdQBN+BoYvdLI4QT6zS+JfduFcyBYijAFl0eiPxcGmeKjB2wYFCR4HVO2gKveRSnxE9tLpRvtuGXyGteT+6o1qp3Z5QjqMN59hoU97wi/dbBvBSFjf4kEyjcuR4eD4MXPh+KiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KTTP43zKaf0Hp5hHoTF8CKWTKL8ITcaj+hrtvuZkk8=;
 b=pdIYZGQehaz2fXyRixNE8YmXzXb8vap06CqweX0S5VDQa8qqlS99F2dGOTkQODi/sdOqpg1VbI8RE4DgECmwgRZUJ3/UFrgxmOrK2q+AiDtEsdhDFJrqPbxJbKErdBXf79OqMRVaE8yeHF/dmQY2ZcprVBVxHjsvIG2JVPxdmEI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 14:13:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 14:13:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for v6.4-rc2
Thread-Topic: [GIT PULL] nfsd fixes for v6.4-rc2
Thread-Index: AQHZiMmxSiLym928BUK76+p1/xhUJA==
Date:   Wed, 17 May 2023 14:13:03 +0000
Message-ID: <15471F80-3338-41FA-BF28-A0A69BDE08D3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5957:EE_
x-ms-office365-filtering-correlation-id: 81b758c0-b8f3-4a39-2119-08db56e0d443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3y6mnSid7LqXJvLUm0knZVsfC6jfh33C4bUy7RPjJOKM2D66o7LF99jAdmJ1QU7uQpFiExrpp1E1WIPyxalZPkQ4C+RXh7GfmjMaMJfpLxgTYhVVanqY0vqMeRQW6ugAQOZ7vyRMdWOR8EZk5CcqGZM6oMm5GzYKDDP9VdemUg20egy/WsUXbUqAUFkROOi5BLwdOUnQ8iL/3XrMBDmVm1m4YZeqUg2dei2q0Fgn0W/9/UPuCX2SzkXBTUeQR7VWdXQKnX4/39NKdOEHD/I6X7EqRP/fkyczFR2vmsN7tKLIk/+pOZTVTCkF2ysTGq+aXJPxqZUh5DQCShK4iPH66uHRj8MxPaMK0hSVDmg6mWaF4jxfCL6sM84R9Z7YAmeFZ/6tHBZ2Ee81tKJPd0IvQVxCGZ1r7Z0bUK5Mz590RNzOydYteCzleKnuHG1XqEDW2CJWw2X7WSEvdj4wKQBXDfoQB6Tgc1yfpm0Cj7MpbVKaQweQqW9HF6htRbRHp7tl1EJDLvjSTrdNPcprp73G02aMNjcWCGZfAoZRUEkuH7YnVM4TeKfykguiRdaouUJFVtPMAaCkaU/p1WWqgBpz/WFEznDKzgw2p78J/Hinn2YgIVIn4m7/vvFsNCKYoOx5QBOEH/7/CpfObV2FEKpsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(966005)(2616005)(186003)(41300700001)(38100700002)(71200400001)(6486002)(26005)(6506007)(83380400001)(6512007)(478600001)(54906003)(66476007)(6916009)(66556008)(4326008)(64756008)(91956017)(66446008)(76116006)(316002)(66946007)(122000001)(5660300002)(8936002)(86362001)(8676002)(38070700005)(33656002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M+du3JRJHizx8vz3DPNbBxBPvoqP3jnk8UsUsywbba8LhcenwI2hXNEENFLu?=
 =?us-ascii?Q?vGJDsbky32gTDOHl97udVsLWY2o3SNgwUQXkQxI9wFkmj0tPLaF0/nyajesX?=
 =?us-ascii?Q?C5w9JFqB+g8KUsDwP+lARc6kqLXvNLZ+AWM7B5srfybt8oQw9HN6jQj9s+VM?=
 =?us-ascii?Q?KORslEXemIrhH+uZyWWvOhbj5SquZo3vCmPJLb2qbMReAlgvrR4eb5KPA/26?=
 =?us-ascii?Q?zXwJ7xOMpdo2at/QvEI6vcqHNd0+2n2WUnOPfI49biOF43dwfVucYmuRe0Sj?=
 =?us-ascii?Q?DDJKtQfLOFsF0n6XQG1NrMMZRZ2w3XNdnDwsAcOozrinkxsikSuH+8ANfdG3?=
 =?us-ascii?Q?lZ2iRk4CSWxY+Cxok7hNWA1H7vARd/8Kb/WrZP5+uCCJWhEpnx9rf0QND8N3?=
 =?us-ascii?Q?oMGebJFw/+ENiow3samMfbifbMMNCcDH1Hk1imQBbnSYD6WCpgVDOGzzikQ0?=
 =?us-ascii?Q?IlvZcz/GhZhiPTlaeuEqmpSDhpTFSk0sGdZ/bBYmIG3NNMtborpN+b013Dy6?=
 =?us-ascii?Q?aYAamVxsO9O6qJRHsslYUMh+tExE9hJZQVPKOdDrzk2L8OsWymqNHiauQYmd?=
 =?us-ascii?Q?1YDk1UqlEwWbvh0a4TYnTbdAlVq77fTq/m+oobc9E1HmRgx8+o+Y3yF+iYhf?=
 =?us-ascii?Q?O5JMy0NW6HxK9rtqmOp9CDI8OaMT7LNqgNE9S8nafb/HzdP25eizAbhkdaou?=
 =?us-ascii?Q?i1Ynu8i17jXVE594ZNGieq9STVVwCpJp3AzCKZxE6DB1lsNtICrX0UKBjdNJ?=
 =?us-ascii?Q?L1kcuk1GQw4OllTcp199R6sfQn859OYbhEW9U5G78+EzNKshMT3XAb82gwPd?=
 =?us-ascii?Q?YJXdosGnLeHgNWcRvzn7CnUimowjhpm5YLqO64gTtnmuJsW3kRSZ0hhzY3Bj?=
 =?us-ascii?Q?SFnV/OdfFFWeguM5q2OOjw0/FoCBBEuFRlm5kuH0eDd+P/ti7k/rADI5P4iC?=
 =?us-ascii?Q?9NLhn99Iel75K0c3kEbGoJHJlndrWkRp5Bg7UG5t/ExHDUtpByQHeanvrhG8?=
 =?us-ascii?Q?lIz49l1CY7oVMRsOLMtLM7raPFm3Q+9V8EmCet26Ta0tf9RYeVPzqdShT0U0?=
 =?us-ascii?Q?h8RnwYrDmetB6kITu+wB6ZOyujfUoM7z8uvAkY7Fkhk9q3BgaqN9S8bxzxfv?=
 =?us-ascii?Q?c2YNyjlmotOzUn+u6AFPzaE+L3GdKTSjMJpBP5N9s9S9fxbR7BYPjr0fGdzN?=
 =?us-ascii?Q?C6f5hxfIIWVGN9if7Ma416EUM6kDeY1iDFMaWN5vKBCsaSBMpnuIVTnYx0Oz?=
 =?us-ascii?Q?c/24X4df6/DqZsTXNjo0KEd3PK0nLKDZEuvasjzspdDjid+wEZ2tj19Vdb/q?=
 =?us-ascii?Q?1nvCXOoannOBWEDL8ii4251LcGeYPWcPZ5CqsE9jTJcZ3KpMD+QPKt+miTfl?=
 =?us-ascii?Q?UWzy7JXYxfx4SDUqnGaoJGdEb3APOKRUaAeuFpY28otb8HYg5z/je905yQDg?=
 =?us-ascii?Q?2xEaqQ86G6+C+Q900u/yoZrUvKvwFbppmLycpC/+wo0SBQm9UdvZg86StIZ+?=
 =?us-ascii?Q?xEKgAywnpe+Pg3NMwwZQhvqi6Y2jKupp6JgpOuNV9PqqSLrBAO7kxHV+y+dp?=
 =?us-ascii?Q?O8oWHbgNWPAiSknJaTLl2BZrIGkP2Pe1CwvHb3dUiBPk6ThB6QhRH3by8rUh?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6CBE5856EBAF894F9DB47185BFF5812C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MEhKxtd8lL4kGRPxKdTMUdg3fFucozkgLaec7Wi0Fb+D/GyJSVnh+u+Pzj+UYhFIBOY+LcHtFE0pfAvGG2gG9czpeWeZp+xJq0hbywk4A9E0Hn/lPgyDoj67hbkHiKd0UncYIUhcDr5bhSQ9gINkJOuYVj4gGe1oMiPgO5tDr7vKF/6ypUxLSctJKDxyuJ978M4dMCP9Bh3gqx6L2V4HRDoRBjLZoEQZ8V4vFJ0Hji/oFhL9yylZxrF5vq9kuDu284U40qPSWOP45LS3nw9qny72j5KGfKSlpH6+pvEUNSh17YzXFJBuwZXphJqMuLcYaIvqF9JWuZbE4D2KvpFalQKh0ZPos5+76kRai/Wh6JLOuYUnG2R0/Xpe4svORyQxxrIqFFx4Z2RYg7+sFS41xL7FAJy+aLC3crxQ4TL9nPTna6JETNcdVO9UqZ7pFkUIqTAR8gpeialqPFQiGI9ihMw/cD0V20fXBTy1WfK3cNWzPB5wCvsbMtsHz90kEkTy9bD9unzxhNt1/g0ClTjKxF9CDJHBwTLgKgQ4LDAjaFaTBKXIhBsPKQbfLgaE8NI3fiI7JTVPacC/9IQIWJikaPZLpT8TkPjzDj7nKZ1LnX0+P92RV8FrGWcmWJAJyiAhS39jFiWnv3SzcHmTg9HTkOe5oGJtK+HTZD4rYtZaO/8pKARPPoSW0GDlmZmfM1N9x9SxReR2RM9xdxvoEGC3E+InE7trvypqb+bOuOXchmw0lHEgT4xtAwXh3VL8yl/DMNpTzJqSbjwhPr/aS3CVHFzzuWGU8C3scumd8dtwpyiWS9htWNlqKPmGTnvem+lRjT+vKQitzjiNb8pG5fEEgQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b758c0-b8f3-4a39-2119-08db56e0d443
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 14:13:03.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JY0XvXawboI5IEVdBqUNM2zyr/oHE6MoqD+cyHbe7hRKYQqgCBQdr2Xn6IWWEoatbYX36d8XDhXzZX2vCgKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170116
X-Proofpoint-GUID: dY_4tJn_BhfV59dR0-FU-jiR76ocZ0nD
X-Proofpoint-ORIG-GUID: dY_4tJn_BhfV59dR0-FU-jiR76ocZ0nD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 9280c577431401544e63dfb489a830a42bee25eb=
:

  NFSD: Handle new xprtsec=3D export option (2023-04-27 18:49:24 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.4-1

for you to fetch changes up to 21a3f3328972bdb774c62b301a715b5cebf03fa2:

  NFSD: Remove open coding of string copy (2023-05-15 08:03:04 -0400)

----------------------------------------------------------------
nfsd-6.4 fixes:
- A collection of minor bug fixes

----------------------------------------------------------------
Ard Biesheuvel (1):
      SUNRPC: Avoid relying on crypto API to derive CBC-CTS output IV

Azeem Shaikh (1):
      NFSD: Remove open coding of string copy

Chuck Lever (3):
      SUNRPC: Fix encoding of accepted but unsuccessful RPC replies
      SUNRPC: Fix error handling in svc_setup_socket()
      SUNRPC: Fix trace_svc_register() call site

NeilBrown (2):
      SUNRPC: double free xprt_ctxt while still in use
      SUNRPC: always free ctxt when freeing deferred request

Tom Rix (2):
      nfsd: define exports_proc_ops with CONFIG_PROC_FS
      lockd: define nlm_port_min,max with CONFIG_SYSCTL

 fs/lockd/svc.c                           |  2 +-
 fs/nfsd/nfsctl.c                         | 25 +++++++++++++------------
 fs/nfsd/trace.h                          |  6 +++---
 include/linux/sunrpc/svc_rdma.h          |  2 +-
 include/linux/sunrpc/svc_xprt.h          |  2 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c    | 10 ++++++++++
 net/sunrpc/svc.c                         | 19 ++++++++++++-------
 net/sunrpc/svc_xprt.c                    | 24 ++++++++++++++++++------
 net/sunrpc/svcsock.c                     | 46 ++++++++++++++++++++--------=
------------------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 11 +++++------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
 11 files changed, 85 insertions(+), 64 deletions(-)

--
Chuck Lever


