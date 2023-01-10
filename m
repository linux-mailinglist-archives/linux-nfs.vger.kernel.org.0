Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C7664335
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbjAJO10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 09:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbjAJO1K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 09:27:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635956889
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 06:26:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ADL4Pv031717;
        Tue, 10 Jan 2023 14:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wpze4HZ0cQRU0FcDBsGcJJBME80U36cLqcbSrOaSfAs=;
 b=OwdBSk77xzXDEntQFWZpyDDlEBhVegH/fcCSuC3MLHz6mfLPLC1W+QztOOtoYC2YZusL
 BUw17wbGFDhHCuX+f2/7j0BihayXT0wuZSnFFrpEsNFirwWiNL/pCKnIFQxmfj+2dxz1
 jmptjdkXH6+tU48v7blU47XzdvGY1bL3WFen7x5PE81DLTnHeVHm4bCUmBS4XuIz3ELN
 m30RnJVKv+UIa3zTNx6B2Zjipk9+SvtwG6sUNYrOAF4TdQ3WqWGqfisCC3HouckEd0zR
 G5jo9US7Wg5DalB6JdyGLOD5dmTx5mZqAM05/qyRZEJUHXdTrpMoEQ7nyZmwdLsgTiaW GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185t86xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:26:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AD8jM5040586;
        Tue, 10 Jan 2023 14:26:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n18c7m94c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVqUQhpK+PGWRimK7utw42wTTLhris45h4/BqmLCnXq7O9f0H5DPAv4e7DWzPELo50bIqHK3ylIKxDq3zppjwVxASR5HZuPQJdgKA5CaPTZr0yQ7UlOnziT1+8XPNoPVcDh8lO0xQsypBpqTPzgNXrV95Mx6OUogSLbZ9nJho2l+BmhgvhMJLd2FbbGFf0woUwXV7Tk/R80Kh0PdCZJ2HnlfvMl0PMc3lX4BxeGw+67GNt79QA1a9ljpn+UOcoGfnf26q62S64h3SmwQwMreL8LzsIM+haq43deXJBuwkWugP7GiznENJTPa/bnAHa0UV2Ww3izXvwrFY8n5+DCciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpze4HZ0cQRU0FcDBsGcJJBME80U36cLqcbSrOaSfAs=;
 b=MNZExCGmdqAA9hwLhDjqHyIaQJTlBx+c04tu/pDcEa9dNwue91EDR7s8aoLUmJmNuNdaDhp3R/qxS6PevIE7Lj9eZS/NYoLqieZ29ehCsBJveVQ2QMQ5UGnj5Gb8U4IvH5KKkyTBEABebILfzVBMR26imzagCxN7hksaZxmWuzEMqX+0co6B1QUnxVbENe8lCILj1yi3DAm66ceVhALhDOpUhWZpfQrHrIjZTbkQ3fksR+6igtOM2ap9PzU/ggqktP8c7G9uRYTOEGtSvz5g3hBezFKMw87beeu1Ipj5c91k0AfNiM1gEEVNFYgeXNpx7JWE/mK+sleqa+et0nyEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpze4HZ0cQRU0FcDBsGcJJBME80U36cLqcbSrOaSfAs=;
 b=T3DI6jR08pqhpkVRG0MQVB+crrf5wbtflEeMUODkD3xbwp0RM9jN+q0lWKYqGgi47DHmI6SjlkKY5WUJieniGTFwczPLk8nLk8bcEyfILIOvPNRB/+BGJJarHITZ+roHLei0DEC9cPEraRw6ggfimfPVIzvmqq2HoJaDZAbbOzU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Tue, 10 Jan
 2023 14:26:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 14:26:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "efault@gmx.de" <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Thread-Topic: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Thread-Index: AQHZJL+WL3xe9S8ATEuPlYmGP9jNkK6XtYGA
Date:   Tue, 10 Jan 2023 14:26:17 +0000
Message-ID: <18F8D34A-1863-43BA-BF2B-AF95F68E3F5E@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4190:EE_
x-ms-office365-filtering-correlation-id: b8a2efaf-88a1-457d-1c97-08daf316a333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 438RW8eBfjLaYOezGqrdbMFaDAsR6140mDX1fn9T1zm6TcdBdAjPlo3evmmr8IOqSqOLnPJp8cV0MFo0d+NvDyJugOBmntwjTMO2q1LwVFB843aJSd2vKjyIGha8bvMUMWZhPZtElViO7Wnv+3CmMWAx3Po1CCFZ2oLS2RXlOlKh9k0Kiv0VJbeIqnW+IQtQKPR/8fFO1lmO50uY6nVB5LvenhonbK9ugxgZS8gfTGjqwe8zSPlMM+kdHLWq0DzknwBR6Ckv9NOoIh6+A8+WISMIKR2t5Jo1B66lcEBWTqstL0rxtAMuDwpAuOTfTY6kVsTpL8ymkLIk56pqEywJtHHjszySSTEsoEjOj+o1AmT8/fcZEGJe/tE9fUQ0wEswr9AQ5UFJRUd5/3OkCiarEEF3HqkYT6vdj3bxTLwyS2SOFkpH0oGygOn/3cETkXAITrQztsdK0wPA1JNMvxI/5+mCqLJSzUWtQUiYN3ZRuNDDk8WYijLJZcORdic6aIdPaEfpIQ/42wGfj6yiaX77VNNYhWgADzFefIxzyIBOBZnUsVgmWrmMNIj7dTJPWKbRQNJjTpCaLmyA/2geCImtmI6aMynBjHZQllDkBTM71hezgEoUTBO3t7ycJpeLLZTYt59FnI+iL//7TElDesApoJIF/NXrPvUiAMb6uRn8pl2mgg7qvBi2kkE/RTW49z9quximdwXa1aOrMi6K6A0zHQRpqfoH3/TlQ7tyE6a28VI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(86362001)(6506007)(66946007)(76116006)(91956017)(5660300002)(8936002)(66556008)(64756008)(53546011)(83380400001)(66476007)(66446008)(8676002)(4326008)(41300700001)(6862004)(122000001)(36756003)(6636002)(478600001)(6486002)(33656002)(54906003)(316002)(37006003)(38100700002)(71200400001)(38070700005)(2906002)(186003)(2616005)(6512007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6YLRXsOB3oXykj7SHRCYY/+Qn5IOMtHmH166lVGDS/P4w+vKc/kGW1N4CkL?=
 =?us-ascii?Q?88ee0KkX3lBrL+lNbhfH8et+RKipd0n/14QCRPs6s0/VdFY1RoDo0sDtifRb?=
 =?us-ascii?Q?UnGROy0ZNGCX2pw5trirJHx114ksQYMTffhmQthAwf0Q0/JFk1m6E2F9PSBM?=
 =?us-ascii?Q?0uex75TVh0g8KMBDaG0EAnLq1by0q7DsU00TwF/GfBMAeVljT003TS1PCDZV?=
 =?us-ascii?Q?piuKGOVtdT0WUpGa0xd4XEoW+J640kC/3HHNMQM2By/LLx9Jpg2I/SVDvQtk?=
 =?us-ascii?Q?d5cEz7Z0jQkmDU4rJmEqqt13q/cUHiZ39X8SOvZTg/5VQL3GjuXPCIWJdG+1?=
 =?us-ascii?Q?8Acn+BeXyFdw7v6JEs1yySmiiqvauBnGa7cMv3hb0ohlHdKTgXVEhejZgBwe?=
 =?us-ascii?Q?GjhBM/UcKAdAZV52DWvzMt9UCG87BE7XQo+JEyHhIVLzy+9uyQTzkWXhQrj5?=
 =?us-ascii?Q?56+7/vL/ZceS19e+uOs7LZHQnKSbv9x1fQLlMNmvZkJsQkywDPsMKZF3MLXf?=
 =?us-ascii?Q?yGg7MiKJ4Vpjl8eehdS9eyK/nHXAG0WhxhGvMuX2dSuRNIoXxt/oMMcZ9js2?=
 =?us-ascii?Q?LPlPmo6tCs9ykhHCzHWYV8RzJsLWRBq0JqKxN385RCABn5eLkM97Qc9vDAt4?=
 =?us-ascii?Q?Q/mBh7xDiY4diA89ZFHOvhRNMfpMB64+UXdUXF5Idcx1UeaFxqfz06KBxz9k?=
 =?us-ascii?Q?hit6GE86HZ/fv6AkTBaNpZ/kI96JKEepFJycNmff3GZdK5r6PeXGg+q4Kcpz?=
 =?us-ascii?Q?O0tcvGflLGKEr9p3e2h5WWK3E3VAVxxOtary7r/lkIGMvS3D39cWaStdLtx2?=
 =?us-ascii?Q?M+mX3fpoxGvq76m/k6BcKlC8TLNllunocYnbWDvKtMcEOp7tag/WsrbigbbH?=
 =?us-ascii?Q?ursZflXRTW1C/j3N0cYYtcGCGbXU19iYPW7yGhP25E+5+2ZUAxBa5HMKt+id?=
 =?us-ascii?Q?Ht2pD21t89D+LQZjnD61vZ1PC3E/wRPtJzfBNQM0wIcJ0Mi1Y/ttPKULQE/H?=
 =?us-ascii?Q?lAyg6q2PYMT74ThYMbggpNUhym7PXvuJArz2BCWRtzCcnNNSOnLgsxNE4K6N?=
 =?us-ascii?Q?cRg5jlTrD2KeD8Whe3uMvOLuZTQIktGoolbTA1QoZeO04p/m8BFmwqz4wRVc?=
 =?us-ascii?Q?x2QGjuQlrLaTw/hmtvtSIsqZ12TMmhXAwlWmHGOMUo5n68LUrUp6+zEMahPw?=
 =?us-ascii?Q?+a5Ryb8eHnj2bB5AvVFXhhCdPU8H9Hs/UD8vpad/oFzNccWhc5AlDQlm1Qnz?=
 =?us-ascii?Q?2UMRdoNcCFXaDwuDr2GVVifnLZKejjPclaR21Penv2wnV0cWCvOXJVwprQX7?=
 =?us-ascii?Q?L0jXAs2pbGTdMudklhcHTALhwHNw26dLUaZBrbKPZLjuHEfVm9lqBH5oJQ6U?=
 =?us-ascii?Q?WZrshqgfQZeGRR2p7TcYMLhlWZ9H6kO1WcF8ChO8+aK8FJK9+XTumq/aFcVn?=
 =?us-ascii?Q?vAUdMcQ9N3HErN7x1DAHQhyI52OJIVuqm9w3B9Df8uQlcUu1M1itUmZvM7e1?=
 =?us-ascii?Q?dcT1tbvFkldOp9XU/a6qLSJoe9o/xhVzHViLfDpixDhnJn9r8KMRScCZujuL?=
 =?us-ascii?Q?9t2ZF4e0EvYVaRF/R73Y2tOpWOllrc1rvFgFCo4lUWKO87dRFu0RwWann4tq?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEAAEB3DD7AC7C4499EF56CF73C42B13@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6auF0M9UbDejtRw+K8VRWpCU9TSdOQiRXfWSnP9Eect+aU2mvQaeDK+BaGD0JXwiIjqLSdssFRc/FPbrNYbCwJ6axi3WN0To1Xrq2Gt1KOCt3Gj4WmhCL99Ydmx3h2agUtzMCY5+feng6YZEOjq4J6LT6X9bsFZXQgIS/nFObOAE8piAOqFtZlKzAz7T3P17FKiMVSZEdLoxHxcCwHbL/BJI5Gc3d4mCdQ0Zavi+Uzti+IDBuPIykPrgw8eaAnTCtZcwwoSp5GXcgCVpu7r+A/0DqEw2qeyaqkN5+FNHd35X/fn/zkP6I0MQJg5cdqVXFY5YGSNzh/Sw1Ol9jPdMkUGe1ohK4LnRNJNKMViVoqhEJdB1BoGRYbHBOOla+M1tsjmAVCJNmkveK3T+9BisGQX6ZJQmIzXg27ptFf1MquoCoy4f3gNTU+Rj/GRvcB3MYmIH8xNgwSIndd7goOr77fs4lbH8UnZ3Xd7D4a6aZ53vZsH5npus6Q57qU2FBA2VrvBK0IO9s25GDN7d7xmituXDebLrMq8/bKcor21L9B4ga6iu5/TDW6qS9X/+dcfkjwKrK+Q96WHAp9m2Jc3PX8FHlvyxVjNJ+RNLShZuG2rfyoNsB9NBDieqsJDP7743M71svLOVxA8Itb9T4EM5IP6sK4xeM/ZqiPCO8GGFZr39Ws1kI/6RRe58RX5OU+wBCrZQxrLlN8IK6r4Q6yQO7jwbobT3U3cZt3xJ1Jvhv7Bmv/WQe49+90QaUDgVBRhtG5nvw1BV6Fp2IjhKYjzJAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a2efaf-88a1-457d-1c97-08daf316a333
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 14:26:17.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNXGRRsQDJ49zRTapyMfJ89SKD1XuYJXBMLd0iq/XVIUnOg1HC6E+YUh20aZJBcPylDdlmzP4hbsvYalqflTNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_05,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100090
X-Proofpoint-ORIG-GUID: uFcBpSDA03h8rC8SIwu7-dURdYmOl_A4
X-Proofpoint-GUID: uFcBpSDA03h8rC8SIwu7-dURdYmOl_A4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2023, at 1:48 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently nfsd4_state_shrinker_worker can be schduled multiple times
> from nfsd4_state_shrinker_count when memory is low. This causes
> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>=20
> This patch allows only one instance of nfsd4_state_shrinker_worker
> at a time using the nfsd_shrinker_active flag, protected by the
> client_lock.
>=20
> Replace mod_delayed_work with queue_delayed_work since we
> don't expect to modify the delay of any pending work.
>=20
> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory =
condition")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |  1 +
> fs/nfsd/nfs4state.c | 16 ++++++++++++++--
> 2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8c854ba3285b..801d70926442 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -196,6 +196,7 @@ struct nfsd_net {
> 	atomic_t		nfsd_courtesy_clients;
> 	struct shrinker		nfsd_client_shrinker;
> 	struct delayed_work	nfsd_shrinker_work;
> +	bool			nfsd_shrinker_active;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ee56c9466304..e00551af6a11 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrin=
k, struct shrink_control *sc)
> 	struct nfsd_net *nn =3D container_of(shrink,
> 			struct nfsd_net, nfsd_client_shrinker);
>=20
> +	spin_lock(&nn->client_lock);
> +	if (nn->nfsd_shrinker_active) {
> +		spin_unlock(&nn->client_lock);
> +		return 0;
> +	}
> 	count =3D atomic_read(&nn->nfsd_courtesy_clients);
> 	if (!count)
> 		count =3D atomic_long_read(&num_delegations);
> -	if (count)
> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> +	if (count) {
> +		nn->nfsd_shrinker_active =3D true;
> +		spin_unlock(&nn->client_lock);
> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);

As Jeff said, try just replacing the mod_delayed_work() call
with the queue_delayed_work() call, without the extra gating.


> +	} else
> +		spin_unlock(&nn->client_lock);
> 	return (unsigned long)count;
> }
>=20
> @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *wor=
k)
>=20
> 	courtesy_client_reaper(nn);
> 	deleg_reaper(nn);
> +	spin_lock(&nn->client_lock);
> +	nn->nfsd_shrinker_active =3D 0;
> +	spin_unlock(&nn->client_lock);
> }
>=20
> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *=
stp)
> --=20
> 2.9.5
>=20

--
Chuck Lever



