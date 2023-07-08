Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2474BEBE
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Jul 2023 20:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGHSal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Jul 2023 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHSak (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 8 Jul 2023 14:30:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6664D2;
        Sat,  8 Jul 2023 11:30:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 368HwONP014799;
        Sat, 8 Jul 2023 18:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gTMWO/sh0gltll6H4tFaAXSJRhXlKWLnZbslshRFq0I=;
 b=dXrwZmhC+r4wH+RrO9as9rcMv3zkEJ8inLduTEwUlrL+gSpY7V0oe0g4KAPUqUaqP4fN
 sfhfTGvFKr/Yr8cWZuyPxtraPUnIUmphqj9gvJYzU51KvVNS7cO+5IzJZeQGBCu4xfzx
 t0WB6u2wihuODt0NrXN62uFhrCQmg/WUT91lZJ/Q5UKQMiRlSmNLUQoCTQ1arg6sboXx
 RMzsWiOw/d4iZE5Ib0h9UdNO0u5GwwVc9ZWh1tEZRa2Nf8Wbvcda6XrCx6dvr6iojtgD
 HYC/R/hbmi1EKtsggjAEjIQ0XBDdOqLFJZkWk8aJc2BdfEQBVVJ03MSqdhauPLPkK2p1 VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rqc8e814b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 18:30:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 368GKw6W009010;
        Sat, 8 Jul 2023 18:30:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx820p6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 18:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gocmW64MGcURE7Yz7M20ZSFdy7JQEtHjP4HRi+zoLneByA8UwXqqshQLfBN5LwDtovBD5jgCbuKoa9C4hmYwQSmAZFnnoMwGQl/1D1g+8ExI3YJzzGLNKH7seZ7u9q0qWbTkMKajhvJfdB5A/8wBsfEppGvRmA99gyCPuT1QotgNymgVXo2v8P8ACmUTgEkHBXx8oE+toG/P2Ie6t8Ag3BO6SHHfDwRwEzCHIg+BMeW/g0/57pR/UrhHRvHgNutWYaDk1XQp0xppyBTdvHEVvewC3o1V4ziyBA6GoSlsfZHvAp5mk5/Ylf+QFbx0x4oNH8jqpHafun+ShXSjadYUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTMWO/sh0gltll6H4tFaAXSJRhXlKWLnZbslshRFq0I=;
 b=Jt5YVKhY7BPE/8YpkoGD7gT9aL1Z6u84FlFviS1oWZE4aaDlkvN1d3h6E8lpS1Irf3/z5OIExd35xsolcbiz5blzqRuJgWs86V/ePFwAgzGuSIFY2+2veQGij2aIG2/T1JDLRQi9T8FxXVhWEpmQSNqzH1HzoUGSAkV6VmhItcsCfCufgFTMTaE3RWyrJDHptxPw/LBSUAdw6bWliic0el5b2YmJKMpq6DIQTnWelx71Jua+8mNxreBeTwQ1XtZfMNheZwPBs17o1pF+TC+WOspL7yPsRKzzAogah3wTOF6aWca+wqBNAiolZzPaEFLbTy3t5eG5Q9VwUtDlRDZWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTMWO/sh0gltll6H4tFaAXSJRhXlKWLnZbslshRFq0I=;
 b=TClY0e0D+fOA15UjjC6aVfDGAA0QtWtnXONJDge5ZKkmznxRaZjNRFcd1xfmSVy9hTAEZ5MvxCWykpFEzwGeGNm6HTGhw+KBQSyixuxZy6jEZpUgti+TIVzfKTGTRHbL3v5dTh0ZGvsGTPzxE6Bx1hC02e6aq8jJ8DuJcyiE+Cw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 18:30:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 18:30:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: NFS workload leaves nfsd threads in D state
Thread-Topic: NFS workload leaves nfsd threads in D state
Thread-Index: AQHZscpDyYRxzI2VpUO4O0R79eH5jQ==
Date:   Sat, 8 Jul 2023 18:30:26 +0000
Message-ID: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6898:EE_
x-ms-office365-filtering-correlation-id: 75467b19-2d58-4b3c-ac81-08db7fe16661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iANUDqKzsrd2eJx58Q+RPpZpxh2LgUy8Utwj22kUltGWHXEfKi0VZXVgz5mYkZM0PcxG8hsrvJM5RAt6sNO3pt6WBwHFjPfbnQDoFLD7ZNWKzSJVW+vAUmXxrdNpj4V8RwPb3bdFfFb0bm15d1uvT4hwQOgWc9e4zftfo4T0ezalczw1yHuxRTtjKIANtdAALvIqekt9QGUiXux4gUrtvJ/kiRL1syW40vWlWGjZWpOFJ3a4eZyaSn+kMLE0Kkp04fAbm3Rxp7veRI390MxOp0zgA30znJ5z7kYdKYPJQ45kZXQ2dCiBOEvaxfE5hcyk99ejs8zBUk6N2YLZRsHhbH95t8OqUSwMffcyx62lKmMz87o/KxQVlfeLtxXte0Qs94ZPpVsUkhFm2EK4t1hxdA+p+u3UCbVK9vx4feBHKkHJFfgwQjxpff/Jb2WnSesDHvSqKEmA6TOt0VQzaPCqloJWrg7LUTwiymEGYjL3S1UEuAbCAG/6IYGTcRixpsMO1LP3qW+0oHcoEABZwDz/s357iAfksI6gt4X0n4cMEeECi0or8mQOh/IegflX0n49Ec+82Jro9GEHHdr3YzeytYRwIWWYFxRL274/s0QeusWQzFEWiH8ZMu7dC3ooYomQFRzNocILQk7+IMzkYokMXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(6506007)(186003)(966005)(6512007)(26005)(2616005)(83380400001)(4326008)(41300700001)(66556008)(2906002)(316002)(8936002)(64756008)(5660300002)(8676002)(66476007)(66446008)(6486002)(478600001)(54906003)(110136005)(76116006)(91956017)(66946007)(71200400001)(33656002)(36756003)(122000001)(38070700005)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b1+7hBfzOizm2IC49zdYq4hkWWQBJiUQjIgR/u3kJUB2/sxvyjil/aPEdtbh?=
 =?us-ascii?Q?Kzg1KtEA4iS/CMLn3fgZ5WfUa691QsLJMGC9SZepxnXNBdZAIkVxm6XS+waz?=
 =?us-ascii?Q?275pjBapqsgq3ztpyFZR+tFWzxulUX/9PuBrdFLCna3ZDSsYouk9NGA7Nzwd?=
 =?us-ascii?Q?BjlM06ni2wioU/o+J90qvtiLacSplH6wQYA/oSQ4HwikO28ZzlPJRFXFv6B+?=
 =?us-ascii?Q?eVsyCM23Vj97/zkiCVvS6KlCzc9msl69JBqhJmCltZzg5/l/0z+vvOoeHPU6?=
 =?us-ascii?Q?pWbJadxi3zY8tfWqiDrSUqlKDut4baNibNpZZu47BeSvQC4JmIB2eI2fXYt2?=
 =?us-ascii?Q?7gQIIyflvuiNPmpG9VIsKRhIgWRO77OZ0L8xNQ4sLKoPPVvsB0kkbLwizYyC?=
 =?us-ascii?Q?k4D1d5rZdsX2raPIEj/w/XxhcMRFRol/J5k+wuJZ4AhUxkXo6lg6XqJhDC7x?=
 =?us-ascii?Q?Tg7pWyP1nxk8mPzz09Ynt9Sn8B0jy065Rq3iMWFRPJQq36vSrmHVjaWO5ry+?=
 =?us-ascii?Q?4d2xYMW1nFgDKwN4aJWF3sDg9YCl11aYNKJ3lhg5blWWv4H7ZXmBRNzUDkOM?=
 =?us-ascii?Q?n9dYjF8w0x1Fo/PUmi/vdMn6vFQeNL8xuJkZiiLppkQ7U+thdsmdfgkRQVZs?=
 =?us-ascii?Q?e649eeoTgn9nP2ZSPv/Y2StWl+BO81+nrCkKS8A11I9YUzZ1lONbqzCrDo0k?=
 =?us-ascii?Q?luftdi4FOcYLOXO+EicXwLwExxYbGRhz0KSY5zQ35l95I82IYaik475f6pgE?=
 =?us-ascii?Q?+spvFCV4Erhmps2HicMnzfLxKkBiNsdFSiA3o1cBF6z3Z1/LbCkSq7AtDkgW?=
 =?us-ascii?Q?kmlc6J8o6CgNjDSwqI/ppngAkDaB4p7GCR4eprKYhPiDA06aI4ago387wyLv?=
 =?us-ascii?Q?CNuQRt6WW0KgQoM6EVdJmDTzanNOJQpgQh14RDUyvnWGgz72fwBthO+lKU9g?=
 =?us-ascii?Q?zWp8BTgWF8oPACckaCLcWrl6dxYZbjYV119VwU9vGlguHLgDt0g9B+/Q3b+2?=
 =?us-ascii?Q?DrgsWvg9hqFbsr0kK2JvA9CnP5zbBN0wVBfptri4w9f/IDrR+qe1fJZmKFXM?=
 =?us-ascii?Q?tvSrjDn+elvPbyWlrTXaRegoPHjXU8cFUW6wXlAoiafh+c5ozSvwzwVvHFz0?=
 =?us-ascii?Q?POO89MuMcRG74tChWD4ePeQqzGnwaso5GzKWBJ5Df+1FSBCkPmJtYp2ul6uV?=
 =?us-ascii?Q?21GCppzmD4N65xAPYoqm/+lrMutqSW3GDN4vcLRRcTjdTdPSnjfQcUdsSTvh?=
 =?us-ascii?Q?7iMowigjDx4oL6AQjgOSdL4KkTv5QUwVCKJdY3jhJ09iiiMxCxyKOCF5/1Gl?=
 =?us-ascii?Q?okoivmLLnGspofw3hecWCqkA/zxLoY1W3sUxGb6Qjkypx/xH+4wca9vN8r8B?=
 =?us-ascii?Q?beDVqaAjgJHj2pLGo09syR9/epK0LPyNsB+RJrgb0MQIbknKtOfKlgrDGV1F?=
 =?us-ascii?Q?gjgItmnG1gZ6/uz+XhXKViQb+mG0rqTc/vfos+ulaRhMdXA1Z7LFNtIK8PQJ?=
 =?us-ascii?Q?3v7wsHXwechtC7c3/gCbw7y6sPPmokRMMr1pfbsdxOT67+TTUZunP6av2XQQ?=
 =?us-ascii?Q?cBaKRz0IPq4DfkD1ecGHEwCgs5M94aLcwgC6sLGtWXZGz5O4ZQ0iQrWVnx8y?=
 =?us-ascii?Q?7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56C002998DDA6049AA1D89E392111365@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NKent8FmHxsPRktOsXv0+qmmzX4665WjHP1r7Td0D3zHp29/5J4Z6FhYJomYxgkt/Ckw6SSxqyWN6d9owGgEIEMGFeUGzHgp188dQtGEDRc7HNUqqxh3QIiURQlGpQf1GFgGDZRKOrVqBexH1/K7ncGCiw5gd4qt7A3pWF2/DlwSscyttvKsUPRc/h6sAIb3rwrKU7Ftie3pdkcm/XXeLhrx40IqldPbugPbHMsWv96S8aTcinLfjD3jGgnbl/LikWC4zlYWUJV0Mta5oCFSABkKuC2uKg+z3kYp02QSJQlGVVjahocx1Ux1VDK9wtsFFRij/iVa85FBLpZQvSNR+GtwO72262uoLB1dBFJreJQVFVX3THIT/RTryMxfsIPCuwanBLlkYLh3tQ3RZ1l+GoSK07oLEdKiFO8V0GcLkGAR/m5mNfMNIwsviFczTn0MDpg48NSnSBtXHf0Nk9eGcV9GJl0m6PG5o/QOhDNzniBQGwPsQruF53pARgjN3dbDgSUC7UDpnoT2NyrKA//yD6MsRfyDD8VVALYU8WqyNDV8MaG3FtmRblf+4rVLUNGAR2TdrVLb/l38IMF2W0ptvp802RUEwoUjmYGUYAQYKy+5VvI4HG13Qy+FiaZ+7qpf2UzZWbclbwITRPC0xc1UGO6BAuv4jsIzqKFGmkmaIufDMtUktA8gPUs829N/5ppFkiS9JQGtrb54DZ4Gop+wjFfgv9ZM6QxZsxszrEI/GfD4YLtUYPOzygQ/bcos4T1n0LCs1O9y6eawqyBhnyGDrv+CHO+kz9S13TOksxCq6TWEozRDul0RswQJWKrqIrUJuyF20HsA9jW/S3oOEa8sWA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75467b19-2d58-4b3c-ac81-08db7fe16661
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 18:30:26.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtUwxtNGcjyFiH/JAZbqc4Mfmo5pZtUuEGeqCk/ISNqWiCWLkJl2BL/fJDkDYvx9WHE382+Tpe7Sx5szVufzdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=878 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307080173
X-Proofpoint-ORIG-GUID: lbffQ6pHfYE73L9hU1lg5-XJ8Wmq0DTo
X-Proofpoint-GUID: lbffQ6pHfYE73L9hU1lg5-XJ8Wmq0DTo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi -

I have a "standard" test of running the git regression suite with
many threads against an NFS mount. I found that with 6.5-rc, the
test stalled and several nfsd threads on the server were stuck
in D state.

I can reproduce this stall 100% with both an xfs and an ext4
export, so I bisected with both, and both bisects landed on the
same commit:

615939a2ae734e3e68c816d6749d1f5f79c62ab7 is the first bad commit
commit 615939a2ae734e3e68c816d6749d1f5f79c62ab7
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri May 19 06:40:48 2023 +0200

    blk-mq: defer to the normal submission path for post-flush requests

    Requests with the FUA bit on hardware without FUA support need a post
    flush before returning to the caller, but they can still be sent using
    the normal I/O path after initializing the flush-related fields and
    end I/O handler.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Bart Van Assche <bvanassche@acm.org>
    Link: https://lore.kernel.org/r/20230519044050.107790-6-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

 block/blk-flush.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

On system 1: the exports are on top of /dev/mapper and reside on
an "INTEL SSDSC2BA400G3" SATA device.

On system 2: the exports are on top of /dev/mapper and reside on
an "INTEL SSDSC2KB240G8" SATA device.

System 1 was where I discovered the stall. System 2 is where I ran
the bisects.

The call stacks vary a little. I've seen stalls in both the WRITE
and SETATTR paths. Here's a sample from system 1:

INFO: task nfsd:1237 blocked for more than 122 seconds.
      Tainted: G        W          6.4.0-08699-g9e268189cb14 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:nfsd            state:D stack:0     pid:1237  ppid:2      flags:0x0000=
4000
Call Trace:
 <TASK>
 __schedule+0x78f/0x7db
 schedule+0x93/0xc8
 jbd2_log_wait_commit+0xb4/0xf4
 ? __pfx_autoremove_wake_function+0x10/0x10
 jbd2_complete_transaction+0x85/0x97
 ext4_fc_commit+0x118/0x70a
 ? _raw_spin_unlock+0x18/0x2e
 ? __mark_inode_dirty+0x282/0x302
 ext4_write_inode+0x94/0x121
 ext4_nfs_commit_metadata+0x72/0x7d
 commit_inode_metadata+0x1f/0x31 [nfsd]
 commit_metadata+0x26/0x33 [nfsd]
 nfsd_setattr+0x2f2/0x30e [nfsd]
 nfsd_create_setattr+0x4e/0x87 [nfsd]
 nfsd4_open+0x604/0x8fa [nfsd]
 nfsd4_proc_compound+0x4a8/0x5e3 [nfsd]
 ? nfs4svc_decode_compoundargs+0x291/0x2de [nfsd]
 nfsd_dispatch+0xb3/0x164 [nfsd]
 svc_process_common+0x3c7/0x53a [sunrpc]
 ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
 svc_process+0xc6/0xe3 [sunrpc]
 nfsd+0xf2/0x18c [nfsd]
 ? __pfx_nfsd+0x10/0x10 [nfsd]
 kthread+0x10d/0x115
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>

--
Chuck Lever


