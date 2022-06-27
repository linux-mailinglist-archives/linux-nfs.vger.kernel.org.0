Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F555DC1B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiF0N4N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiF0N4M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 09:56:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA3B1E5
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 06:56:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDdEQu002135;
        Mon, 27 Jun 2022 13:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oonQYKxkXmFYGpJX7o8+/Gkw6rDXKaVETxRMqC78cro=;
 b=jiz4U9DktqGgEYt3z7mH2wTD3AZENtgB+Ao7JhyKOUOjuiCnTEA6Bm0VG4FxsOBc8CZX
 W4Vf95qZrM6FGZKzzz66nFZLxo8jidQiO5feGEnQyKrBFfyLuMiPI5/wXljA9fXwCfXk
 RCAVd6dEMPqTscqCJ3Zt5pBWWDSPb5egl0297JmoDG4p2KI03tLKFl+Ut0s6s2Tgg++K
 cqb/c8rNEXK6D+lU0mHqK3Qn+idQysGR+zJnhCbzy24P7LZa+YrHRz7WWF5R41zt1283
 v5s2Ymrxhi9BqtdFF8CNj9H3nbVnwehL3G0tRuDSycfJDs08NRr5ilY1gF10iAHIkhE2 Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52b9nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 13:56:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RDollq012976;
        Mon, 27 Jun 2022 13:56:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1fanq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 13:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+N+oJtWFI/wnoQEYteVswbo3xLT/Hj7dYRnKh5sfm6NDz2K9+gyhaUwjD5BZ9Cqms8ikPQOUjYBP30KOBSal/N4gf5QXwfqqmNshGnpCoN75m9Wl1+K2mo3CZHEissmA/LrHg3IImpNk8JGp6mwTo0Rzeawf1+v4CG8uUCwyaPSAfarht69ii7nwwCdu6GPH+Mab4XccUMB6f0eXjZcGkAFkpUhpsei/A25yiiqC2HO3PvNLYdTTcR3H/+l2p7UaiUYYd6atyas91wAm9iq+uTIM5eRwNKtM2drsj20uIcsUUlG0yW8t7tUB1IksG/rtydM5HjCUA0XuOu/XH1oSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oonQYKxkXmFYGpJX7o8+/Gkw6rDXKaVETxRMqC78cro=;
 b=i7wVhrhiLqjYo5Gn0i1tkPdsS2Z5BucduDvEheUhQSlOIGRECtlw/bEyJPNPuxAUOdz1uamXB1mdPy2dNL/XKsyb9QjbZF4FCTIwbsqNB2XpfyUT/4FNJ86/9mfaEikKavDJmf6k9Pqtp53PXkSG35jir+qAunIQfyxv9inOkNODUX5xat+EIHNE6KhjV9V+0ACOLFWPgncvRPUT1/HsaN/y07xRDOCl1n/x1fLGXw1GCgDz38f5UrQkw/R3lv68JxbpyOKSvHoJFiXqllt5YJ8bx3OqVnGVtW8TdreHicnA2XdBmM2HBgpWEMJDGiM2qrAghMNRe3dDwx+XKuGUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oonQYKxkXmFYGpJX7o8+/Gkw6rDXKaVETxRMqC78cro=;
 b=M5M0cFNWfpYemjLmOzFeBYXjH6jth8arRVDjftZCPq/eQf68lwHcLfRbAWGketPDvLXCQW/f4IcHS7A5W6tfbeKFEOY62FcfclEpajFxla4dRNAZ3nA4/GBEkHxeT2Sj1LvjfTvyHO09W+j1UNNKl08clOJ+U886TefgxDXs9j4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 13:55:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:55:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NLM: Defend against file_lock changes after
 vfs_test_lock()
Thread-Topic: [PATCH] NLM: Defend against file_lock changes after
 vfs_test_lock()
Thread-Index: AQHYfysdIoOx/JiCV0ytFXEmbRLY1a1NqUmAgBWgsACAABLxAA==
Date:   Mon, 27 Jun 2022 13:55:59 +0000
Message-ID: <306758ED-63F0-4025-B257-F68F690790CA@oracle.com>
References: <9688295e35c07d3b3d6c71970b6996348c2d8f1e.1654798464.git.bcodding@redhat.com>
 <53767203-004C-4538-8E29-1241CFB19F43@oracle.com>
 <CALF+zO=JaHByPPVphXNZO8X5fTGniOCHZXWBgw_z=ObfyOC0QQ@mail.gmail.com>
In-Reply-To: <CALF+zO=JaHByPPVphXNZO8X5fTGniOCHZXWBgw_z=ObfyOC0QQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0622d855-94f3-4734-8e8d-08da5844c434
x-ms-traffictypediagnostic: BLAPR10MB5025:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUpQzMT0Ppokun/DgJrHCsXtlwBk+U2MWJCjXZ/jioaOinGBIRCccN7ZMNLbJf2ocgEk3UDxOArTOkmYbRUjVyFzvu58SOvQFaPA/Uvue6Lr+/tMfv22TVaGDk/kwEHuQRif0KDqkeH0nfE/EEqImpivHyrsm0gHN+/Q4cKRLsGq2ApMtrYBqH0aNKOnSj1WaFPO1RAm07NpydfIjDP+Omsz+oUhtkSL/WQkXgPEd0MdleqbBJgUpQkbdIJKDb8QLpFLhFeGRX0/qO/ZqtMdmjEXmGW7wJyFj9ZgAjANWXzUBRxWRZ4UDpvBaRALJqRDTiGxS6aGvkRGiaIQRYGF7Tu+b9r/6wooM3YfKVIn3LipiiM2ViZ4cJYgP6nMuwvD3D3TcHIj6D6m4NED0eCL5jvAnQUyeOMIH4Jz3HND81GJ4ljwNmsell8wqufCWhs5O1g3qCJcFodSSSGl/6MwHPyuExKB1A2yGA9onil0EvPTPwi0ulgwXywCxw684cA9tLbM4ua12eVo4fvzMgOzSN5o/q/D3P9JMx4SLIps79WUFagkU0zg0J0QvFdCdHQlgK9BnQ5op7KCycZ5KZefYRUnNKqpVkNbfE+7USbzgN/p5GAZJRLbHX1D45kLaO4S7/NdTM9cxzM8BS/a9MJvZ3YVgEQMPdkGIxzq0/+KRN8qMhdwZhd8aXecCXmDwUYElZDboanriL5zKg3blAVPmKWUhhEMgFqbQy0rKAbKsb2mjubONqUh0y/5ihstgduzBU2lRJlv1EqCdqozroHBJIYVkbAdXf49qvuXqpZoNsQEuHzzg36+ggUbuVchZY4JIRCT16pH19EROec5nUY2N0kkzggxNPZoVE8HvwCAtRI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(366004)(136003)(39860400002)(6512007)(122000001)(66476007)(26005)(76116006)(91956017)(83380400001)(66946007)(66556008)(66446008)(33656002)(6916009)(64756008)(8676002)(54906003)(4326008)(38070700005)(316002)(38100700002)(2616005)(2906002)(41300700001)(86362001)(6506007)(71200400001)(5660300002)(186003)(478600001)(36756003)(6486002)(966005)(53546011)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oj4Sm7Ee84D5dDaQt5gQS50ChpDO/0PXj+/p76T+TiZxRe8DaCHC8MaaU8D2?=
 =?us-ascii?Q?axn6lGcPNmUQYUDOOLfQGxM7EXAVULifJIqF3iKnRCdfAMG2l+iYFUS8kvdL?=
 =?us-ascii?Q?oTiL3xfJix6z/UhM9aA+NcnYwseuOMhCNXeTuBzriLjKMplKH40wMCJhWmHf?=
 =?us-ascii?Q?+0XgF3vskAdMbSyOXDDnZtiCU3L2RgTtVdvJYsfJkzs1gcc6KgB5YLLAZwfe?=
 =?us-ascii?Q?Ye3pPjIqtiE0LR7kFYUHWQwah1BCnmw7pbmUAomuUmGwY9PraaP4GbVHsjWe?=
 =?us-ascii?Q?/ghS7A912HWKO081aLYbHlC1YzuGMIBK4AgeG3g90IBMBmTdL8aDFUy6tM0C?=
 =?us-ascii?Q?bMTb32mVXuMuTYrbMjfq/Ykg73Dt3qsGxFsYBlmE8rWVY4H4HiHatlGrMZ4a?=
 =?us-ascii?Q?1CnPShvmYl3NiIuIzlCSIG5PnT76XqRmkbWdSrm0/khPHYjJHFWoSNFvba4o?=
 =?us-ascii?Q?5MTWd+u1RZTKUcb7gE3SF8Zbbx4QScxaY6g/MY478gdKxfZeZhKmTjyjE9qE?=
 =?us-ascii?Q?zIXOqkU4rgcZZhGGboCz8sMrnRrITDoktqr/Iwg1OXz6Fj42tytDVDGECzTm?=
 =?us-ascii?Q?zESII/fYo6hel4TmgImf6DdjDQ9urbpn+9kQ1gHu9sqOgszsL4Pe2lwozyzY?=
 =?us-ascii?Q?O61d5LgOiPBpG6zucBmobABHJ2c1l211c8nNYeQKf0cIZNHA5Ou7fTy5kkbs?=
 =?us-ascii?Q?3c0NlKstN0wuaFlkvp0hvqgqCbBSNLAAFm4Vifvz/t3pbEzNJ1/xahVyHrxJ?=
 =?us-ascii?Q?HY1XrosALFoKWBce0AVWAdw4OKf5UjwCuK00qQ+5lhl0vcwWm2miTm173xEg?=
 =?us-ascii?Q?FzcKh6k3FpyUhVG5iPQRQl2FNs0eRPErO5C4adxC4XCUdWJYhfhxhSHpmJk8?=
 =?us-ascii?Q?sLvDvYaVXCfUHfu1L6vUHNuqK5ufKNzdHsOXuShnOvH07C0zEh7WudD+DpJt?=
 =?us-ascii?Q?IsFulA9ljgKtJ64TFDVO4peUVfGjHKyn1s399FMfQ6b3ssJqjgmXWRk2pEKk?=
 =?us-ascii?Q?+rAVJvE/1Qb7UKtPgr0GX6f3x48cR39NUgG2Vzc6uYBpt3gF65fkLqep2OfO?=
 =?us-ascii?Q?fNWoDlYSPRQOwdlIoaM6eXxcxC9imlIph/2DVRCyanYO7eg6YpaK7mLJ75Tf?=
 =?us-ascii?Q?ov5VeyQXTyNjRpQOwJ1z5c0XqJjftKjAFD9+1yqVKR6XTIGVkHG9kgxITpMU?=
 =?us-ascii?Q?VSOTmIRkBICjGs27KRXenr/ufiJxQJPDo4AmTvzopWaLANFeEsWuCEI3z9r8?=
 =?us-ascii?Q?ebq0P4gZZw8VNp97SHRtgBb92XIFUNmq2wDxJBMhIdvAQZD6mJyobOSYD8QC?=
 =?us-ascii?Q?4c0D3V5W5ii94sqQxSTRqQEmpRH15EV/34Feo8gkmBgI3aEcRCs0X07OeNeY?=
 =?us-ascii?Q?sjIH9oyajyiPttUX+wmlXO4RMYwS/ZdwXI3vbQI+i7zbtu1Bd72GqoPJphPp?=
 =?us-ascii?Q?ya36XsBSbDmroUAkiIUknKyJ1YXL2FoflAvnpwb+rY/KL7Ozl9AXWXQYlKeh?=
 =?us-ascii?Q?2QF6CJIG8T6w9kmCf6hiG+k3/aWoT8KVQlUhNqSFlABErAyTeMtzWYTkJYXD?=
 =?us-ascii?Q?ZvZK/1pvvRlYCBbdqOeYIu+gGAECiNHTj5uJGKH38Q75998P5BtBY8JIEghI?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD36E0692D08C044A0CBD058BB8B061A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0622d855-94f3-4734-8e8d-08da5844c434
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 13:55:59.8520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpJ8SKfyUSK6xPmCHEe/UfJUsSqqGf4p7ZALlNHPPPFHknhqyW+AtX0bzRcsrXiOMEeoAb0m+Fw3Ne7AtzAyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270061
X-Proofpoint-ORIG-GUID: ilUdQUOzhe2nCWXdykOyITez5hSwiujJ
X-Proofpoint-GUID: ilUdQUOzhe2nCWXdykOyITez5hSwiujJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 27, 2022, at 8:48 AM, David Wysochanski <dwysocha@redhat.com> wrot=
e:
>=20
> On Mon, Jun 13, 2022 at 4:01 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jun 13, 2022, at 9:40 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> Instead of trusting that struct file_lock returns completely unchanged
>>> after vfs_test_lock() when there's no conflicting lock, stash away our
>>> nlm_lockowner reference so we can properly release it for all cases.
>>>=20
>>> This defends against another file_lock implementation overwriting fl_ow=
ner
>>> when the return type is F_UNLCK.
>>>=20
>>> Reported-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
>>> Tested-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>=20
>> LGTM. Applied internally for more testing. Comment period
>> still open.
>>=20
>=20
> Chuck,
>=20
> Are you planning to take this in the next merge window, or what is the
> status of this patch?

It is destined for the next merge window. It will appear in the
for-next branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

In a week or two.


>>> ---
>>> fs/lockd/svc4proc.c | 4 +++-
>>> fs/lockd/svclock.c | 10 +---------
>>> fs/lockd/svcproc.c | 5 ++++-
>>> include/linux/lockd/lockd.h | 1 +
>>> 4 files changed, 9 insertions(+), 11 deletions(-)
>>>=20
>>> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
>>> index 176b468a61c7..4f247ab8be61 100644
>>> --- a/fs/lockd/svc4proc.c
>>> +++ b/fs/lockd/svc4proc.c
>>> @@ -87,6 +87,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>>> struct nlm_args *argp =3D rqstp->rq_argp;
>>> struct nlm_host *host;
>>> struct nlm_file *file;
>>> + struct nlm_lockowner *test_owner;
>>> __be32 rc =3D rpc_success;
>>>=20
>>> dprintk("lockd: TEST4 called\n");
>>> @@ -96,6 +97,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>>> if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file))=
)
>>> return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success=
;
>>>=20
>>> + test_owner =3D argp->lock.fl.fl_owner;
>>> /* Now check for conflicting locks */
>>> resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp-=
>lock, &resp->cookie);
>>> if (resp->status =3D=3D nlm_drop_reply)
>>> @@ -103,7 +105,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct =
nlm_res *resp)
>>> else
>>> dprintk("lockd: TEST4 status %d\n", ntohl(resp->status));
>>>=20
>>> - nlmsvc_release_lockowner(&argp->lock);
>>> + nlmsvc_put_lockowner(test_owner);
>>> nlmsvc_release_host(host);
>>> nlm_release_file(file);
>>> return rc;
>>> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
>>> index cb3658ab9b7a..9c1aa75441e1 100644
>>> --- a/fs/lockd/svclock.c
>>> +++ b/fs/lockd/svclock.c
>>> @@ -340,7 +340,7 @@ nlmsvc_get_lockowner(struct nlm_lockowner *lockowne=
r)
>>> return lockowner;
>>> }
>>>=20
>>> -static void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
>>> +void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
>>> {
>>> if (!refcount_dec_and_lock(&lockowner->count, &lockowner->host->h_lock)=
)
>>> return;
>>> @@ -590,7 +590,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_=
file *file,
>>> int error;
>>> int mode;
>>> __be32 ret;
>>> - struct nlm_lockowner *test_owner;
>>>=20
>>> dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=3D%d, %Ld-%Ld)\n",
>>> nlmsvc_file_inode(file)->i_sb->s_id,
>>> @@ -604,9 +603,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_=
file *file,
>>> goto out;
>>> }
>>>=20
>>> - /* If there's a conflicting lock, remember to clean up the test lock =
*/
>>> - test_owner =3D (struct nlm_lockowner *)lock->fl.fl_owner;
>>> -
>>> mode =3D lock_to_openmode(&lock->fl);
>>> error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
>>> if (error) {
>>> @@ -635,10 +631,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm=
_file *file,
>>> conflock->fl.fl_end =3D lock->fl.fl_end;
>>> locks_release_private(&lock->fl);
>>>=20
>>> - /* Clean up the test lock */
>>> - lock->fl.fl_owner =3D NULL;
>>> - nlmsvc_put_lockowner(test_owner);
>>> -
>>> ret =3D nlm_lck_denied;
>>> out:
>>> return ret;
>>> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
>>> index 4dc1b40a489a..b09ca35b527c 100644
>>> --- a/fs/lockd/svcproc.c
>>> +++ b/fs/lockd/svcproc.c
>>> @@ -116,6 +116,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct n=
lm_res *resp)
>>> struct nlm_args *argp =3D rqstp->rq_argp;
>>> struct nlm_host *host;
>>> struct nlm_file *file;
>>> + struct nlm_lockowner *test_owner;
>>> __be32 rc =3D rpc_success;
>>>=20
>>> dprintk("lockd: TEST called\n");
>>> @@ -125,6 +126,8 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct n=
lm_res *resp)
>>> if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
>>> return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success=
;
>>>=20
>>> + test_owner =3D argp->lock.fl.fl_owner;
>>> +
>>> /* Now check for conflicting locks */
>>> resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host, &argp->=
lock, &resp->lock, &resp->cookie));
>>> if (resp->status =3D=3D nlm_drop_reply)
>>> @@ -133,7 +136,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct n=
lm_res *resp)
>>> dprintk("lockd: TEST status %d vers %d\n",
>>> ntohl(resp->status), rqstp->rq_vers);
>>>=20
>>> - nlmsvc_release_lockowner(&argp->lock);
>>> + nlmsvc_put_lockowner(test_owner);
>>> nlmsvc_release_host(host);
>>> nlm_release_file(file);
>>> return rc;
>>> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
>>> index fcef192e5e45..70ce419e2709 100644
>>> --- a/include/linux/lockd/lockd.h
>>> +++ b/include/linux/lockd/lockd.h
>>> @@ -292,6 +292,7 @@ void nlmsvc_locks_init_private(struct file_lock *, =
struct nlm_host *, pid_t);
>>> __be32 nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
>>> struct nlm_lock *);
>>> void nlm_release_file(struct nlm_file *);
>>> +void nlmsvc_put_lockowner(struct nlm_lockowner *);
>>> void nlmsvc_release_lockowner(struct nlm_lock *);
>>> void nlmsvc_mark_resources(struct net *);
>>> void nlmsvc_free_host_resources(struct nlm_host *);
>>> --
>>> 2.31.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



