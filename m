Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19A159FCD0
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiHXOKE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiHXOKD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 10:10:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFE980F44;
        Wed, 24 Aug 2022 07:10:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OCsKjx011472;
        Wed, 24 Aug 2022 14:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E7CO5K1ogslR8dO1QJJ9YD17UcyfuvPz/kxtbDfpXoo=;
 b=zE9b+ckFMgJ7OKLqCakJeb5gXRNDVE9yLRZYdKhHww/CxIx/6w9gNRChQPV+kohmBraw
 o9qCaG7mnqTFkXejhIs1Bc9ribGSsF0Y1Ax8Nfwu5GFTD+5dTavgun7Nh8X90PQR/FBz
 rXjtsvHyuUOvqD9c1P18Yu2y6m6+Q4T2rGGp29Qi46XoaxjqKO7+PTlPPxJUzD1kqJQT
 hJTjajoEOFvXUSv8VQLjzY+8nqYAVGl34imb/jH1AEXUVWNdl8bNVUUwi3DUXfO5bxAN
 ceaOkjrbdvja3t3bmdIVvDp90hQ+oiQudePbJyQ32kKnmVf/KQnvZcO9Inx7Kso6uc02 sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nya0a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 14:09:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ODhosv004442;
        Wed, 24 Aug 2022 14:09:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4k15dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 14:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCLNw2lNdRBfLMsH1tSCO4f/WFQhTRnF8qv32qc1p1gSoUgrGsB2OeiBxIZg+6nnLkOYDVUUKXrqCOQizniyPWScIYkANUcqpiwMM7//zaEKUTzBSpK+GcynTEfDguNgecyMxdmOvGGHg5IwG/xBchceNdSb4TptMhy5Sk5X0CWp8j+u38OZgFHA055JWHSzS5CmmfZx2EOjXPuiAKfMg1STdbx5p4AZB281VwUgam7CuCpJHgUJewb7h5YrHLWCBmJPOWHAJ6ZVayrbzj9b/czNod4C8Ixl4RfgpA3UZHM0AYBKwnZnS1g21yqd5C7uLV82J4ql6YHdk/RhlHVGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7CO5K1ogslR8dO1QJJ9YD17UcyfuvPz/kxtbDfpXoo=;
 b=fjJSWejXoU3/GnSbt+us6Nxsrp8kKEVTM+XtTz1q0jL3YYg/mZh0GGARcxEGgzTmUz10WVzCjlUA5xYxIOzvQEnuUgRdr0cocJocdkMKok5OYOfzBgrYdxoULdZGOIM2uo4E4/DduKuUf/ARfnqt8ePUkt9Lzs/66WkMTXHnTv3lAdvXBHp+qmw4u4F7glxRm/crg2Sx2VW3fwIxn+7eh7JeHqOwtJ8u+CRQ8u7YBFPDuEN/o8xusQFvcdY8uMmM0Slus5TW39vem5tCqgc7XZcf8nnfCb/0N58KctEx0FmNs7V7RCNV67idvu0aQ8HyFCo1n0ODeRx9rx3eoMjXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7CO5K1ogslR8dO1QJJ9YD17UcyfuvPz/kxtbDfpXoo=;
 b=d7IQ42MaeZI+yGwEFcEBTH2yQEgnU+MxAw0/RKOFlzajTQ9el7B3BFntzbCndAEszMCmuVzzPTaBU0GbTCnbPrREFnHRkpaRWaQKqIbA//OIiJg5+91u3qLQZYGhZk+Tl38Ei61DqB/bR/X5R/ptorgGFtZoxEXzWvn8mkAGUlk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6182.namprd10.prod.outlook.com (2603:10b6:8:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 14:09:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 14:09:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Thread-Topic: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on
 addr_wq
Thread-Index: AQHYtjxDHzOcFbDad0CgCtqOY9xpUa28It+AgABhkYCAAUS4AIAAULmA
Date:   Wed, 24 Aug 2022 14:09:52 +0000
Message-ID: <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal> <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal>
In-Reply-To: <YwXtePKW+sn/89M6@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a08e2323-3ae7-40d3-60a6-08da85da50ac
x-ms-traffictypediagnostic: DM4PR10MB6182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDoLE6Wfq+B6TLhP0Sw239a3+hoyW55OaTItoSlIRAOp9RoLnyZZMu0oNjJlsE3cjHgUZjQ3awiirSeH/VBHw81tiYxeKOYP6qrnMLOuS/7JNiPSEgLkpd2j5TtyrA5B6aWDgfpmnIHseLeo6YSoKJQdij2iqmd5h8uy5Vc0/+qLpFk+aMidG/MMPo7LIzxhAJHYJWJscFDC19eL9k9sNncqsCfYyfo8xqugI2rXPvUu2D1Z0AvOwXx1uX0Wcap7awGrr7A7NEVJ4sfnUEiR4QKFJO+xh4iulmnqZ6bNunnQDSlu0tRtDbWG6u9oOF0YSNH0rAY3niovzseFSg71MXSoPb2bmKJPGEl1UylthX5iCD0C52ncwCF3sgcmnbJ+kX6SJrlpDOdoKhzTT3NikGE+ksNgjdT/RiLkXUDQX+G+adhx4zm6tBtHWoMLYxJyqv5b0NpRvYUmLszZI0BGXlwoTlpbjim2nBkTq4JF07LEL4v1l985fSwGPU8F6taC281KVTjpV8zjJj+fpxtKVXVsxNYgcutXv9aXTEysvCkWwYXdga8PQAneHvzIPUcxJFCcClGa5Ik6KXmf6jlVTWurcsZ66EjjHYGMpO8dIMF1du9qlxF6BbzCti1TOQ1Xxj+sl438LMauQpRGERZbfGvK+FhCzgN8L8IhslSYfWthA8Oi+RbOegm89sM4kDH9eYCuRvPQpmCEVs71j2JBz+sh69CQGFPFrGTeCqHsyPE9mC0DjwAKa/ogFBvy9sop6xD9o7MmD4V1aNYUjw7pTLGs1G1LE/1RFOTJEjKADMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(366004)(396003)(376002)(4326008)(64756008)(76116006)(66446008)(66946007)(66556008)(86362001)(91956017)(66476007)(8936002)(41300700001)(8676002)(38100700002)(478600001)(54906003)(110136005)(316002)(38070700005)(71200400001)(6486002)(36756003)(186003)(33656002)(2616005)(83380400001)(26005)(2906002)(122000001)(6512007)(6506007)(53546011)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fpdrXV5UOfBOMkODh4TOJUNuYgmSNPqBtYeSOei6PYxmfZTwtikPRpJBXcJe?=
 =?us-ascii?Q?PlpNXuRV8DTbKfb+mCJjSkAVsZPQuCpkzpm/Erw46RC6veSMHb9ol5XeEHON?=
 =?us-ascii?Q?Fxb30BIHwU/I5HMzAUjAp6VM0ZjjkiIVI5/ZARK79dcKEYW4c5wAAIWBHFn9?=
 =?us-ascii?Q?pV+qHxVN96KwkKRYedQjfb26+dI9rJw1x5fzVPuUjHneGntUkn12OHdM/N13?=
 =?us-ascii?Q?XNoNgff8/bYdWjnJnMQ6Reejsqt9Bzo7FELc9m5HOCRGrzgs3yvfr4lMVZMA?=
 =?us-ascii?Q?t9vuzfGMeKx6PtXAB2O6cYNoPt3ln08usd+oogBaUHmeLSdiE+2AM/c9rSdE?=
 =?us-ascii?Q?XIaLZtXIi66+vZUJ6A2mygO17AlTJAY08azil/hQGnGrEFvF6O7fqpgYea0G?=
 =?us-ascii?Q?BkNsyYXss+4/lPWQLnlauiUWRnofDSLzIav7l5zEbMus4ldn2nJk+qtNYq0r?=
 =?us-ascii?Q?RYFcnj+IH1s2FdOJIomX0LAOSyEqsIfWjktUtz700k6wX/Ct3W4EJxhb3Eta?=
 =?us-ascii?Q?A+A3n9UW/H9bOjNQZ+rGTYu9zm3ZOHDkKaj2h0ZYEPkKO/Pm3Piw0T1MpIbI?=
 =?us-ascii?Q?WjBsWexls0oyBhczh1JMQlLugM9SCtNMRLepsHMWWZvsFQqN+AIlxp62Qn5k?=
 =?us-ascii?Q?3K7sPUNsTyI+QGO4BzS2TkmQ/j50OlsX7cI73EuyCVk4CaFBvFjCUDOWvDc6?=
 =?us-ascii?Q?ePu0OeZ+FZGQ6Vvb5ZNIc0vvSor8Y1VU+bItrmhsdRmpqgo/YYUO4tgMZCKu?=
 =?us-ascii?Q?g9aYcve/zq80ygBfxY7F5RtaJ0b/PFZCTO2ZHNtZx0APx96GWfp1AjC5C5zb?=
 =?us-ascii?Q?pbOiu2H1UnkHrQfnnaj2yfWUZlP8gurlqohnEHBA4Vp5DUertjOQfkFqV6qv?=
 =?us-ascii?Q?G2+k5qs2Ooe7dXj26evkHiNsRI+WRDZZrCK0V+Z+8exccERf1oxIdf/ek2sZ?=
 =?us-ascii?Q?o1z8+ag+eYmtLlTmNZ/JUhIzJcS+wAFOPj2VTs0QyCne68TQban9sPL9V40G?=
 =?us-ascii?Q?FOYDzeLDtMFFOMMZlmJTmxX/Ubkhgmg5Sx6gGl7uGtn6KWqbi0kW7LUkMbiq?=
 =?us-ascii?Q?T4VPEfUQocxWjDRrKsXpoixjiISXNxOhad7nhoMFv+T83Gr1wJvfXy+a2DyB?=
 =?us-ascii?Q?zsgGuRRHSn1zUqpa8VDS7YHbPBGOOtuXv58/gErOad3V916Uhi2sGMYa7UGZ?=
 =?us-ascii?Q?dJi3Du6kqSIt2w8PSVJawU0EG+/GUFUVYwNm/gg+/OJ+q50iMy7dljHhAOZw?=
 =?us-ascii?Q?bjnBizBSlk3SpuR0Cscg+Y9fyGz6rmz2/uw5fuEEPV1hUPvknXzh1zUdexMl?=
 =?us-ascii?Q?bowA3RfoY8Mf/v+4t+0s/6+IJg65XKglUw/OqQo+c5EHA/l0ZAVVFuoKDp5m?=
 =?us-ascii?Q?lzkiMcqmeCfRz4qQJSw2IE+FM8bJNe5txgbB0L9DG/4buSPpzmAR7ufRTP71?=
 =?us-ascii?Q?9hnwL9U4HWcl1b+YtT8EK2QFNtNQ7hShCs/BklW6nbPgzRANw4zz1JK6l2tQ?=
 =?us-ascii?Q?XCvwIF/1xhYCqvYPGnavaS3Ki0vG7JMt9n2qRgCtTnoSKOJO7CrK5Tn9p0Oy?=
 =?us-ascii?Q?8tczRKGiUm2yudHjucoNsUiZO0HhP+oHYGsqsqO8muDmVi3wLAfPm84Ramf7?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD9A504979BEAF438E7E0B3545EFAE32@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e2323-3ae7-40d3-60a6-08da85da50ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 14:09:52.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wecz9trc0mOu/A6T5w6vMDBDsCyP68IQG1seopqQLJSToqbFmThDZleuyXtI54oVfxk60n/336twAgn4ywi7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240054
X-Proofpoint-ORIG-GUID: hu9EdNSD6HmUC5MmyW7b6qG-t86-cbUx
X-Proofpoint-GUID: hu9EdNSD6HmUC5MmyW7b6qG-t86-cbUx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 24, 2022, at 5:20 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Tue, Aug 23, 2022 at 01:58:44PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Aug 23, 2022, at 4:09 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Mon, Aug 22, 2022 at 11:30:20AM -0400, Chuck Lever wrote:
>=20
> <...>
>=20
>>>> The xprtiod work queue is WQ_MEM_RECLAIM, so any work queue that
>>>> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
>>>> prevent a priority inversion.
>>>=20
>>> But why do you have WQ_MEM_RECLAIM in xprtiod?
>>=20
>> Because RPC is under a filesystem (NFS). Therefore it has to handle
>> writeback demanded by direct reclaim. All of the storage ULPs have
>> this constraint, in fact.
>=20
> I don't know, this ib_addr workqueue is used when connection is created.

Reconnection is exactly when we need to ensure that creating
a new connection won't trigger more memory allocation, because
that will immediately deadlock.

Again, all network storage ULPs have this constraint.


> Jason, what do you think?
>=20
> Thanks

--
Chuck Lever



