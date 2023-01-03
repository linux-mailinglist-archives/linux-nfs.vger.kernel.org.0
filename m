Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7100465C3F2
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jan 2023 17:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjACQdb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 11:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjACQda (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 11:33:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7FFF1
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 08:33:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303G4Du4004623;
        Tue, 3 Jan 2023 16:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hIHutJOpnjDGvzGdivWe2gReFb/WtJhjYaX5CVH8ieE=;
 b=r13CI9NpPFijlUUp1ikNZ9oTw3HJEmYZW7UFepEoKbhv52Xp98XMUbo/DD/4q1OYuHXQ
 CKqgOiTGgfX/RTFgdQc2jsx/deqOJPqKFgPb1+LA1roLR4ongrZyHAAnmLeWLRdEXyqQ
 RzYj7Qe9nq6DvArmlC3pAVbW8usFTXib51OP+LChW751/KinrMisBaWmpIRyl9LRAlyi
 fMV6uPOkka/M3VulPl7c9InNTFOfiT/8u8HUdaRNmBqGD/zRKNW/XyaGbakZk5iBXyKw
 JTyJGTZkc8aQobSypSuywKlKY7UUB/mTgyGJwIHIESd3DdjWfd0gvnzRd0P9eZjqSzbf eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya4cwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 16:33:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303ExWx5021233;
        Tue, 3 Jan 2023 16:33:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh53mu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 16:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjl6yvApWR6uQ9SlkXW7YCTSuf+mokHMyUO6bUMrB1i+lmU+WIRMEEa+ffsXXgykI5oYm3OE/ERs4GdVMmGN/N9mZVlQjPRhSS40sr3rMhf0RfOrICZqhv2qLL7zczOfho77q8KrhMyMsNTyTtptiXBb311zslEZI14IzyCuJKIeahe/m239Eteu56HrM4KFWeKRx5dVLN+cbclmBV/IF+jYdFHtQBtywdAdoi5BUCnTOMQZ344BjTGY00O3GSfQNlTelK+mSFas7EiIS0aoTomyv3S0D8pU9oPvDuQb++tYCz0Vb0UxOc3HecP5Ewp41DwN8WLyHvJTIJYJIFRsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIHutJOpnjDGvzGdivWe2gReFb/WtJhjYaX5CVH8ieE=;
 b=XEQw0gNBxNlvUbbQ/HclmK+zDePZpPIdKdv2HYm8Wf8xWvqjqKdZ96gN/egrCH/1q/ic5qz8yAoepFScOIGbHYcyG7FkQ2+uH/j+3lOFBAY4bBiyWBjumM6V/G74ZECA8d+uecBXzG++NQIHHy8hl0GP8+8roD4VhfH0kw2hNzr6Df/PFCRJUt2H83eHolcml5f6cdC2J558J/z2ihgvyowRAR/QhKBbwa+B4envD0aMz30/XcqJWHh/RLe/T4POGRBDIPQqSbNDCwjrddRveQy5HJG0HrCtB3Zn0nptRVghKw/igbHKVz5yGThM2IO2H9v0CkZCEOviQxxJmbMj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIHutJOpnjDGvzGdivWe2gReFb/WtJhjYaX5CVH8ieE=;
 b=mwmn3AARMhz/z718ZolouI1kkCwASwyulaY1F/7W8Fw9d6WY7pIbdxLmFleKSOObjnoz0lIEPQP0VJjvjOsQ0SGaXT51sC/15ipIL6QYyC15GnYvEZMyWkAb408W26ynSR0rqW+V9Z9vJMBMawAhaLHEXa5qsCzyM1kazXD9+xk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6968.namprd10.prod.outlook.com (2603:10b6:510:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:33:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:33:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 00/25] Server-side RPC call header parsing overhaul
Thread-Topic: [PATCH v1 00/25] Server-side RPC call header parsing overhaul
Thread-Index: AQHZHsyO+pYu4CccG0ipBPGuVGU2ua6MyEaAgAAcTYA=
Date:   Tue, 3 Jan 2023 16:33:20 +0000
Message-ID: <14A17DBB-CD3D-41A4-B2C2-D46DEBB1243C@oracle.com>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
 <159dd1253c7b49b6654cb4373477f69cc7387b1e.camel@kernel.org>
In-Reply-To: <159dd1253c7b49b6654cb4373477f69cc7387b1e.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6968:EE_
x-ms-office365-filtering-correlation-id: 22277524-8da3-4cd0-6a58-08daeda839c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /szwVNa0tlHoyG1PQKZME2HIDfPv40g1HWNJ/91xA74d4lNS4zAyRdH39Jpl4vzHH4glrfh8A6wemoxJ/iLMJqPFBeF4nGJzo2tjkMkoomY4FdzFBUJkCBquRzpffvyuYyRTmF81Y6ZXzGlYsn1aiC8NhZ18W9D4UZE7lCgW6NthRS4x2ZYXnroVBuLXevMpiRhmKDLjVNrmfK7WTZ+WQt3Z0uTu7FwYDLkWGjlVEL5xd++d2Kxia7gJdKjk9yBVer+JJXofq2Zje/2Eg7zsQmTv6vnZXLDtv2dJuzWa6iD7qZkZSOLJEDU/aD5ShwXe3n93/hV0D7+61z9B48bEOAnqxkxSKjMpq8cWN4onoMB8MWwqodECB8mSwCHMSN/RtfSGLCAmpC0SBdrPVsO1EIatxT2vEBsk2a7ulcUTNxZkv5ruzl/A3iqBjolZDbl4Y9FvbZdOzN4ld+j2ep60966ulf6SsBRNzfkepLrNXl8ZwvfiI/QJE3MJF45lnE8tstpH9XjSkgTyUMtziYBvnXziYZ0hOa+ARBK7GgpuFpT46UXZH1X6cf0gebHTKt/68JcpnyK1coBfwgfLBvpWxidstjeUSD1nF0cdtFc053svWMOLlNxsooRlhSVkgDQAswpf+a5JsO59TVVj9aAiwINnxYGte3X8Qih5DPP9pB/5eLymw3w6t94rvr5fPUGGjQmdTN0gxnF+WA2eiHGVvR2B2Og8zAHEUelBODdt1vx+H/X0NdRfdMeRGYy+Ee+F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(41300700001)(8936002)(4326008)(66946007)(91956017)(76116006)(5660300002)(8676002)(6916009)(64756008)(2906002)(316002)(66556008)(66899015)(6486002)(53546011)(6506007)(71200400001)(66446008)(478600001)(66476007)(6512007)(2616005)(86362001)(26005)(186003)(83380400001)(38100700002)(122000001)(38070700005)(36756003)(33656002)(22166006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wJVW79pgeegSzTPyK+SOO7ZW0kH1ITjAxoHJZUcG9BeNhL+A5XM1ydqE4qaR?=
 =?us-ascii?Q?kTv/MjdUbx/HYg9i+C/p8bb8KbiE9diCEUUkW28usiRmjAqD2B8iVOLX0ENT?=
 =?us-ascii?Q?4XZXQ6IHnr4Eqyben+4vfzPWbzAX/5u8a/wL/ITK92Uo/ubYkT69dno8ZWol?=
 =?us-ascii?Q?2gMjf/nWSbzEQdNQZYV8qxZe0/K8nBj3GiVAACgbli8uU+pSfidyw7bE47sP?=
 =?us-ascii?Q?m/Z5pxq8o6M7R9pqFFtDqmwJ0cYa1j3xFZmd843byrV1R1CdAxahfIffaMcs?=
 =?us-ascii?Q?JoBNICvLx3nygNq/X/Dxpnzdpd+SFb8x0lVAE7EL9OSDqPcNDc4x5+3zfJNv?=
 =?us-ascii?Q?+s+ZSaXeRbdRWW02oSgKDv1xAkhCrfP55PG6wlcthxSrMDVWBqwjYJtsX39b?=
 =?us-ascii?Q?d2Cl037lJ/jI6B5JZo6DJ9zJEIggul+wrnj/8qSI0tk9rEsrDNH4m0nanTNR?=
 =?us-ascii?Q?72WDpoPWHfYJ9jyd2YXTRAugSotr3h60VIVy2pssAhBnJzTht4HkHTKlhQvH?=
 =?us-ascii?Q?XZAcZp0dRykzqeTCFXza68bk3AVHWAaU+ARmw3dTw98gJwwZEtMiHgPPN9pQ?=
 =?us-ascii?Q?ik55h9z4Nd8b1alNKuTDqTK9yEAq6oFk0xhbB2PoDudzKrPCtTacI7bF37jr?=
 =?us-ascii?Q?DMKfE1XQjUWYR/VwEcx4W7hBKztBlaUTDMRINz/KqLX+C95Ey4dFrxWZWrzz?=
 =?us-ascii?Q?6TAIuqGypRCgcE0nX8uxaE55nXQFyFupu/NFr83d7fQTusS+9KHELvqqEFeb?=
 =?us-ascii?Q?TcWf1DALt3DejL8gEzGg0WeAofxxpBjYnEK2VILbQwJi4jhz42WYnT3Kbxfe?=
 =?us-ascii?Q?Qob54fStCP29m2gm9rWnY0dhAs41ZkBtZBYl8m01Kmuz0bdNkhNxCjle+yQK?=
 =?us-ascii?Q?UCvq8T8QgCFUmV0RLmKSkSJiHcK053bINDM8UZkWwxtQ+O2ItaZfznCHvX2u?=
 =?us-ascii?Q?bh9XNdCT8l+YOkYgMapHsVONdEkY0Q8NZVIBNKwN+AolUX2MmFnaobjSH3gR?=
 =?us-ascii?Q?VI+fQXpQfyWdj03W8Yd5+IIX5p3joxIC9xoKhSbqnnkx+xdNn2Gz5bQvwu+N?=
 =?us-ascii?Q?AJMZu2IAOG5bhsQ56HNGIg56fTfhBbBVoBhg85Zv7+K9rKL550YYgHGlHYH/?=
 =?us-ascii?Q?Xusx4vsBkZc6Vzhk4VZE7oyJlihG16bjulzrfnlLG4jvzbUdahvJVWduH4N3?=
 =?us-ascii?Q?5P5wMZcZY1xLnmgNqb2Q0zfeiosrWi5Fv0Yrri+Kt3vPERY9WZgbKEenvzqU?=
 =?us-ascii?Q?rnC9soMnkRsSq8IyBK3BhDIMLDFR2wiYI2fMxIJkz8m5PogcCUEZzIvxM3uY?=
 =?us-ascii?Q?kyY1weBNGoJ6WNEygvJDGzv7oNLNk/zR2DMARmCduYMi9fZM+yw4bMJ02d7h?=
 =?us-ascii?Q?xmJNqbIr2OhdmK/30qRr9yyQ/lDMdOwxIIkLYulSHTJPFwaZBTjQ3o2L2XB5?=
 =?us-ascii?Q?twVjSmohav2YKlNPZqEnNmnsBgOxjO1lD0CGxXS+MA8uVNAqbI0oPCe6G2ec?=
 =?us-ascii?Q?miYBs75ByfzXZrgw+fkZ3+S7J2DdaTHRa+rOJ/jJwZTBMT3jB9QNaicVb3DJ?=
 =?us-ascii?Q?00RCkx3l/DpVXgH8ysFAKezddxBcMHmPgZT/edxTGkJN9hMjevD6zZIdb1Nr?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D683036747C97448A812257B0D0A6D25@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N1cb/ZP9BrvRdHkPgMxinM6ZiJbp2vEVD2SuWN3VR5nrDLvsjZThEn6DTr7Zq9fXPeYmRrC7nhcGz+ZTjG4BQ/cqx7Iudvg6+etxEAImnkcdHvkI37jheNrQZLnygDBIBi9NEW7lPJIdSjr1N9koc0kSWHFyQUM9bcYSKndjg4JQ3xV65BQbeWU/t6YBjuOYz+L4xOFnQ8Igu6kx3NsiCVbrIWrRw/CMz1Fu17ja0wnaNV71jTg3h2eIJ5LD/Q90ND7kCKMU6x9/1MM/2VcFvyftwgwJgTwPqjZnIrbdfJVkq0ajUIypaTNA/XnD0ZEQcNg8/oWfcC26f6jW8bG8+XIuYCLIpkCqnHpMOy3dutbPThVPMtIwltvlkX3KRfnd2A3axGr+jQvuV4QaqQQ/4wOO70TS3Csipflt5s+mnDMctQPs6/mW8I2d/wfR2iSOEqNGJoLgvDRmyhRjQCL4NeX+fITXTVKDkHAz64gAeSa4oEikl4zqMx1HSzb9lnjKZ0e4p2WYm7/Xe5lS8aW7cmuvcnl68X9RQwZg4Ybl+BKLb9caE3O05iaHss6F6Rz/AF33DM5m34EEarBX0iAMFiyrJPqUlOQIYKVtM89+Ou/PwghsnTo28gfiwcuBroKCnhK/4BLCLxJW0VtsPbZTkMfP/A2dE4yiQKQUrW3fvb0vWN5gBxey0lPduBMg32dZgrsIMzivvPPKS0Wz0I6OPWHHZqXrorGCZVQNJL3MkY0iuyzi4LLWCBQN2JkFlP6P1n9/LIS4GSiYL5nX1dZ9xHh7i5v1j2uQ8CbNLw3lFmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22277524-8da3-4cd0-6a58-08daeda839c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 16:33:20.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkjqZsr9tM75LnbZzoq47gqLCGzJzXtFMNMxwcuMnPAxQSZ9ybVnYRUAUkfDMKXkqZMZRIObOL35CEMP1ejTaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030141
X-Proofpoint-ORIG-GUID: huYUcOAVwHGSk-PBIdELp4b_LkETURzw
X-Proofpoint-GUID: huYUcOAVwHGSk-PBIdELp4b_LkETURzw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 3, 2023, at 9:52 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-01-02 at 12:05 -0500, Chuck Lever wrote:
>> Happy new year, campers.
>>=20
>> The following series has been percolating for quite a while, thanks
>> to the extended 6.1-rc cycle. I'd like to get this work reviewed
>> for possible inclusion in v6.3, so I'm starting early.
>>=20
>> The purpose of this series is to replace the svc_get* macros in the
>> Linux kernel server's RPC call header parsing code with xdr_stream
>> helpers. I've measured no change in CPU utilization after the
>> overhaul; svc_recv() and friends remain the highest CPU consumers by
>> an order of magnitude.
>>=20
>> Memory safety: Buffer bounds checking after decoding each XDR item
>> is more memory-safe than the current decoding mechanism. Subsequent
>> memory safety improvements to the xdr_stream helpers will benefit
>> all who use them.
>>=20
>> Audit friendliness: The new code has lots of comments and other
>> clean-up to help align it with the relevant RPC specifications. The
>> use of common helpers also makes the decoders easier to audit.
>>=20
>> I've split the full series in half to make it easier to review. The
>> patches posted here handle RPC call header decoding. Remaining
>> patches, to be posted later, deal with RPC reply header encoding.
>>=20
>> Yes, there are a lot of patches, but they are each small, easily
>> chewed mechanical changes.
>>=20
>> ---
>>=20
>> Chuck Lever (25):
>>      SUNRPC: Push svcxdr_init_decode() into svc_process_common()
>>      SUNRPC: Move svcxdr_init_decode() into ->accept methods
>>      SUNRPC: Add an XDR decoding helper for struct opaque_auth
>>      SUNRPC: Convert svcauth_null_accept() to use xdr_stream
>>      SUNRPC: Convert svcauth_unix_accept() to use xdr_stream
>>      SUNRPC: Convert svcauth_tls_accept() to use xdr_stream
>>      SUNRPC: Move the server-side GSS upcall to a noinline function
>>      SUNRPC: Hoist common verifier decoding code into svcauth_gss_proc_i=
nit()
>>      SUNRPC: Remove gss_read_common_verf()
>>      SUNRPC: Remove gss_read_verf()
>>      SUNRPC: Convert server-side GSS upcall helpers to use xdr_stream
>>      SUNRPC: Replace read_u32_from_xdr_buf() with existing XDR helper
>>      SUNRPC: Rename automatic variables in unwrap_integ_data()
>>      SUNRPC: Convert unwrap_integ_data() to use xdr_stream
>>      SUNRPC: Rename automatic variables in unwrap_priv_data()
>>      SUNRPC: Convert unwrap_priv_data() to use xdr_stream
>>      SUNRPC: Convert gss_verify_header() to use xdr_stream
>>      SUNRPC: Clean up svcauth_gss_accept's NULL procedure check
>>      SUNRPC: Convert the svcauth_gss_accept() pre-amble to use xdr_strea=
m
>>      SUNRPC: Hoist init_decode out of svc_authenticate()
>>      SUNRPC: Re-order construction of the first reply fields
>>      SUNRPC: Eliminate unneeded variable
>>      SUNRPC: Decode most of RPC header with xdr_stream
>>      SUNRPC: Remove svc_process_common's argv parameter
>>      SUNRPC: Hoist svcxdr_init_decode() into svc_process()
>>=20
>>=20
>> fs/lockd/svc.c                    |   1 -
>> fs/nfs/callback_xdr.c             |   1 -
>> fs/nfsd/nfssvc.c                  |   1 -
>> include/linux/sunrpc/msg_prot.h   |   5 +
>> include/linux/sunrpc/xdr.h        |   5 +-
>> net/sunrpc/auth_gss/svcauth_gss.c | 512 ++++++++++++++++--------------
>> net/sunrpc/svc.c                  |  69 ++--
>> net/sunrpc/svc_xprt.c             |   1 -
>> net/sunrpc/svcauth.c              |  13 +-
>> net/sunrpc/svcauth_unix.c         | 132 +++++---
>> net/sunrpc/xdr.c                  |  50 ++-
>> 11 files changed, 468 insertions(+), 322 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> I went through the whole set and it's all a mostly logical set of
> methodical changes. You can add:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks Jeff! I've applied these and pushed them to nfsd's for-next,
but comments are still open, and testing results are welcome.


--
Chuck Lever



