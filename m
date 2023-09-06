Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDE07944AF
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjIFUi7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbjIFUi5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 16:38:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A9B1BC7
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 13:38:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KYObs005544;
        Wed, 6 Sep 2023 20:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ltFYgW1QQW4H6hHMDxIRf59DkFaCDpLPpDxMu8axKWA=;
 b=SX7h5RxkinW1oEhJwAWqYsSv5c6jQmua6qEw23MJIWTklL6p9sZfaYOxB91DbAr7e6xc
 bh7WRM0I7gpGKOrLKTEqeUbR0ffVKgD10Uh6IvmJEjCIovzmWWsysXUcRO/kAmPFKeRQ
 3XOyBn7mgTueDMUv4vZKM2w1nA9VHwjN64Xgebbsdc3E9OCKf4mY519gyzoYxtUlKxpJ
 p737pLRgVGuK3gOO2+EcNhjw6nGlIt3rooeacpCmDgAqtnLL2BONaNfPg6NWSUIULEol
 upMLzemvE6AQxIHX6zzSdDqnNM97x1S8bgJGKjJth9YyYbyh1hOABSkHMuxCU15HpIVd kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sy0jx002r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 20:38:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386KIaJL029115;
        Wed, 6 Sep 2023 20:25:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6rwyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 20:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX+gXOxoPj/MVvEq2u9AP1n2E6FaUAxX3SudQLO7mEJZcrVe4gLscBldzBME3Xc4mvz4bp7GNf+XTBfK94UJX41W7E/hASCB5JsBbZsAKZ152zEARDc512I5k6wiAasBAb9JOOcBLxHvuGIwLBnvByccSNM/qYtboIL2tYdGC0uqzWb6+xECL17VQBmPgRLpDZ2ptVAYu2Y2RpKtt9TCmneRnH96eogcZRhfz1j369CkcsKJAfEjaG6LPO2E+xWzJSJ4x8xUgvcLbT/c7YjaslkotsVMfOxY+S/lV8Mypes/KwXyu5nBk9MFqqePQRcuqSQvW4g5LAc2gP4RehlVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltFYgW1QQW4H6hHMDxIRf59DkFaCDpLPpDxMu8axKWA=;
 b=CccG9B8pRtRRlxqsv99rxVGUK4Qk6PZZ6cT+jQgjU+qHod7VVaHcZBJJmP/zXZoAYmnTnQGvfIoFWP+lbG8lDgJK/k+yUYEa+o99QE+fa2XX8vnOz/5BJYhTv4JDYxSRTlEmkGVoWDhPLNEC13JbvHLmBcq7XKxmUJfsylKNGkBjMLOhhTEcpYlqNDNFZCak2OVi/cjh3q6X9pNoXHwY8TX8/I4DH2xZ8S3EFmUT6KtOn4T79GtKzGMrL8ylbCHM2XhMQRAwC7WdjXxGWzGyoV/JvoXzhRdzAKveJ7UkPVdwUt6+qgG0BG5Q3UrmhNdTVfEvgbWhVGuLmowASuL3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltFYgW1QQW4H6hHMDxIRf59DkFaCDpLPpDxMu8axKWA=;
 b=GyTIxnpWE9PRFwoUEtUCxtJEutCsBPHy8PjT5vWHEkxnBkbKoPlsqA7a6jUIr/Gk9wD45ngObZOGVxKhqFOb+ZcRrGmmEQqFaxRYPcNHDJX/8bnqTuN+9WIDW2E07QUMVfd8Xa7a9IuGuDAPaa7FkoIA/1eBWDxC9wYcltmw+xM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4753.namprd10.prod.outlook.com (2603:10b6:303:6f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 20:25:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 20:25:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] SUNRPC: Fail quickly when server does not recognize
 TLS
Thread-Topic: [PATCH v2] SUNRPC: Fail quickly when server does not recognize
 TLS
Thread-Index: AQHZ4P2F9j++Z9A6/kC/pa1eWMwKZrAOPnIA
Date:   Wed, 6 Sep 2023 20:25:12 +0000
Message-ID: <336C7059-27B6-47FA-9E07-A2F2A53C4E7C@oracle.com>
References: <169403069468.5590.10798268439536368989.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169403069468.5590.10798268439536368989.stgit@oracle-102.nfsv4bat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4753:EE_
x-ms-office365-filtering-correlation-id: 3c311962-d7da-415a-43e3-08dbaf175f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HCh0Mz0g2vwY7KkpycZyVvEVIc9TcMVncRIuqg19DaSoN4tzaPnw0uQebrNQYS56KuGmRq7He7NoXc0OCu6c1IkbQU1fQziiZkc3TiXMwn2eTh+etS4b+M9O+MGZwlzKaAzB/EBzL4A9J4/aCbAPh/AcOSHyByYCgEUI4ao9a8W5Giq21wYS2WKmmUfGxMEiRCat2bi85RpgvHsvNFdYS9ye1zTAoagK6ZOohKPscs4uWZV1Uby+P7DqKsUaPMWoi1sG9B5x4VIgt4G7KUvpN42iGfsvqu91Ohg4UU+hDeprJYK7N8iLTC20mGIrO1qgG+AgFY3NVMVRE5i/QvfDjC19yyvKTkAPZASor4qzO+ifKhwQCKVuxPmHDHD3V+lyshdq4uP+U0dFBHpgMwyqaJp2sUyCP6QVQt+WlwiPce9FhRVoaRQloDYL1DMtyX7XOMuIZ8JJjzc5NE10Gu5ozEfMYpYEGnFvZBcn4KAnCaPl2PJdWVKZO+RHAJOAnEf2UW6u+41x8WvNNgKUs0p3mrpm+yWrAL3Vsh50zBRW1XBwS39X3u8VdaGxDg+sHBNxVQ0XrZ0YRiHmNfrlJKwDSJ1TMuMBAHiPdXPhFmJTK53mxEvME3MkRnY8daTKmsUfCd85VKAR8F/N57ysKi/E8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199024)(186009)(1800799009)(86362001)(33656002)(36756003)(38100700002)(122000001)(38070700005)(478600001)(2906002)(53546011)(316002)(6512007)(6506007)(71200400001)(6486002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(66446008)(91956017)(6916009)(64756008)(54906003)(66476007)(76116006)(66556008)(66946007)(83380400001)(2616005)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?azGJKH5oSwLJtZq12/F7gWu66QZIq95uuR2IdLlc+Awcgif889sfCMsI/pki?=
 =?us-ascii?Q?AnIil5HSGo+2gzNRuZC+VjWmmze513z8l3dCXdTglfsJAiZ5PUtLc04dW9Yj?=
 =?us-ascii?Q?gJ/kG+qD6mr5LRBRbAEDrs6vTfwWcOwzgJB+8jJn99OTxMdA+HbwWsZQEa6N?=
 =?us-ascii?Q?yIRjlutJcflDOVG9XB1ZW3PyyE71H+vV9ITqPPb8oV0lkX1d4eHMGUc4aOa1?=
 =?us-ascii?Q?VU/IVhAiFPMiNTvBdtdOyFcnAQxK7aOo9Tfyjl9KzrMYFZzROvW/qyR4DhkO?=
 =?us-ascii?Q?GoYQzAC0+VkHG0VwS+QGWC+qr5B5ZOU8KYDNBcMU2aOw+n7werGwfSNaugwY?=
 =?us-ascii?Q?pAGxODTQFPZkj7w/j4De2fZZ1ggwOPkvaTg9lCLENz/yC7fxDULqi/F+6T1Z?=
 =?us-ascii?Q?Zaj/w/VCooSJaezd5SOrOAAIf54i3Pj+ww/5nig/xMhKbhfFNHKV2ukFUXq7?=
 =?us-ascii?Q?yriR9HWkcJaGVzUIfAQNFQDyMdYYU4PxcoYe/4XCfhxUHNCMCW1+NNUv1Del?=
 =?us-ascii?Q?istJ2g0UWi17j7MmdkUasOzyakRpNUXcKeihYX89ySwl0nB8OewljNUbMqdc?=
 =?us-ascii?Q?w57Dhn02aAbMJ6ZAipaAHNkFNrGBL1tfPQMXOm4S5nQAhLklNNRzKO69/7Tg?=
 =?us-ascii?Q?+kf9pTX6mn+mrd39pMPR1Wvg6w9B6VimL+DAzjiLRS4rKLsCkxCfbDX4t6Ro?=
 =?us-ascii?Q?qR67J2xbTA1FLfpio4VzKreo8qtMNkALun1o5VZSiq1VTuqIfGOOeq3pXmqs?=
 =?us-ascii?Q?RzQLcrUEByljBVvEqIEb+aez4XDvEH/dmdCP3n7UKEVS0xJaSfZCPBGjkDoa?=
 =?us-ascii?Q?KRfW/BgGRP3hDrYwZMLyJagUK37VtJxsdiBz0ickkYpnFSx1FxDZOy5G3nop?=
 =?us-ascii?Q?EiVDQ6vcM7jy2AeCbGt17m3xmR0pd4rl/Zgyz2ntsgO5U26ovXFe+6g4VAdC?=
 =?us-ascii?Q?hVNj/hZCOtkjyzOUaq9mlIw6SJClNi2boR9z/S6MTKrBPNh1Gysg5za5VU0y?=
 =?us-ascii?Q?9kJ45tS6GEw7v+DTvLGMQ6ysFY7bp5YpY+Tef6wXWJ7LxPgviC+PMHBRXPGZ?=
 =?us-ascii?Q?8TaHNLaxolAL4eJgc4EUHUsYEGZ3/rgI4mQgrUqUS0NHMsnqNh4gUNcHmVJV?=
 =?us-ascii?Q?PI3bGJC+DbHbSYwuYHrMSV2+xzBHRm1lt/RZtcq4NbFT+dgeiWBa6NX3lYew?=
 =?us-ascii?Q?OrWZmVMxO+7AoYx1PgnxEee6XREW6Ic9xYjGKkqBVHw659zYXP4N+7Osf10G?=
 =?us-ascii?Q?7vK4PvIpil+EXE/ZI6R/xBemEFzA+o0WAZotI/bpdYj99lIYpwqIOHIS+cSB?=
 =?us-ascii?Q?44OIqgBPw3WkamYN0HRaYEYiKjiCwdfT8ZqN14yAzi8VQ5A+fqIE2LRnE1pK?=
 =?us-ascii?Q?tU+1akCyQH2D65i2w2eV5hT888XCNWtnaZAc05N+oqVuAegj/HotPscQTU/s?=
 =?us-ascii?Q?yZ8GN42vt5OXHASJ4npuU+RcW6cdl7V1hIgGGYXdq2dSrbbME6he42z7QYDj?=
 =?us-ascii?Q?ifIDJarWdTfLKCsMOhBKOA8U4zC35TOLK2Bc1uikGgbwYWoptYdyiFbWLkd4?=
 =?us-ascii?Q?iAL4HTAOrpCnAP6scGusNrdqCBu8rmbHsCts6/ZNobCPgD2sc3hT2biyrJ1M?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E583D3F4146DFE448AEE364C4B727B0A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /0yIfNrCwbaxnR8g7LHFR7+7uxWr62B0bb1iKhtgmsaVDKrmz0zvPavCmBHAp25tX9aTPl/CczhCLJCnirvxqoYIf8/HzEdlpbx/biR+xCmBelTuMXpb7zABffESlKtSKAEFxR9aCSF0NK2YXWd45XIsx0Hl4+Gpj9irIgRMJiNY6PSkBCudvrebLEL7CqYX1GOTPvcxbw7lcyK4z7f8a1XdVc781eDNSWwbR7NGvd99dLaMvO40FiK176FRHK5O47PYGCWcdu7A7rErZUSZJKppsqJ15oqLvEYWTiTvG52Y01vKAMUWYIIcGFIaNwD1LEd+l2UL5o8Vt7ZSOyHQ8vzt7gHCQOF7/M7mezbTEXNYVrBnAQyiKp21lpJJwu7UyihI2fovdnNA2IpGKnmmZHL8VPDGSfU7UzPtdnAfem1XwkIh4753UTwyjSMr/DClXAou/E/nMOm/9h58GF/nor03TRnEdNH+0IR7r3KkIa/J/01WOU6wHfwRY5Gnngz7M55O/p+b6XxZf7lB4bQ399ABUWKAwSoTqYJdn2JxWvvW050dh6PsN8RGmkF4EvlqPO2N2yifvTu9Y3d/XjcpIx2O2sdk3kq/SmqQynN/b284ineUIWy6OD0TrbLysrf2kOdPpUdL4HjYgjnSKwNI1SYH4Tk8gbGEpOKIEUj8JsshRhWEFV9MCNMJ+b6b8Toh6khAN3Lx7sDDkqvCD6sbW/A/XV9F1Bw3eRC0FEoMnv7NH0zkGYGfEiOgcPZcJ53U5ySS/1+5EwrC9o9NENwQ2kUgq01TY4VgG5KFxdE/e/bT9xsA8DcoMhEpl7Q0hH+KJyznV5FOc1s40AGujQWLNA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c311962-d7da-415a-43e3-08dbaf175f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 20:25:12.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxZwQ8jmJ54TO8CGWzRKW8MjpBWXW48Nbc2TxIDX3TO42e5fo0gSM/9gT1F/x1xznqe//sSXTCsGHhyvzZjj7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060177
X-Proofpoint-ORIG-GUID: Fh4AexkvfiZEokTdDAWrTiwOfwOepae1
X-Proofpoint-GUID: Fh4AexkvfiZEokTdDAWrTiwOfwOepae1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2023, at 4:05 PM, Chuck Lever <cel@kernel.org> wrote:
>=20
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> rpcauth_checkverf() should return a distinct error code when a
> server recognizes the AUTH_TLS probe but does not support TLS so
> that the client's header decoder can respond appropriately and
> quickly. No retries are necessary is in this case, since the server
> has already affirmatively answered "TLS is unsupported".
>=20
> Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/auth.c     |   11 ++++++++---
> net/sunrpc/auth_tls.c |    4 ++--
> net/sunrpc/clnt.c     |   10 +++++++++-
> 3 files changed, 19 insertions(+), 6 deletions(-)
>=20
> This must be applied after 'Revert "SUNRPC: Fail faster on bad verifier"'
>=20
> Changes since RFC:
> - Basic testing has been done
> - Added an explicit check for a zero-length verifier string

This last bullet is stale. Instead, tls_validate() returns
PROTONOSUPPORT if the opaque token is not exactly starttls_len
bytes long.


> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 2f16f9d17966..814b0169f972 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -769,9 +769,14 @@ int rpcauth_wrap_req(struct rpc_task *task, struct x=
dr_stream *xdr)
>  * @task: controlling RPC task
>  * @xdr: xdr_stream containing RPC Reply header
>  *
> - * On success, @xdr is updated to point past the verifier and
> - * zero is returned. Otherwise, @xdr is in an undefined state
> - * and a negative errno is returned.
> + * Return values:
> + *   %0: Verifier is valid. @xdr now points past the verifier.
> + *   %-EIO: Verifier is corrupted or message ended early.
> + *   %-EACCES: Verifier is intact but not valid.
> + *   %-EPROTONOSUPPORT: Server does not support the requested auth type.
> + *
> + * When a negative errno is returned, @xdr is left in an undefined
> + * state.
>  */
> int
> rpcauth_checkverf(struct rpc_task *task, struct xdr_stream *xdr)
> diff --git a/net/sunrpc/auth_tls.c b/net/sunrpc/auth_tls.c
> index de7678f8a23d..87f570fd3b00 100644
> --- a/net/sunrpc/auth_tls.c
> +++ b/net/sunrpc/auth_tls.c
> @@ -129,9 +129,9 @@ static int tls_validate(struct rpc_task *task, struct=
 xdr_stream *xdr)
> if (*p !=3D rpc_auth_null)
> return -EIO;
> if (xdr_stream_decode_opaque_inline(xdr, &str, starttls_len) !=3D starttl=
s_len)
> - return -EIO;
> + return -EPROTONOSUPPORT;
> if (memcmp(str, starttls_token, starttls_len))
> - return -EIO;
> + return -EPROTONOSUPPORT;
> return 0;
> }
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 315bd59dea05..80ee97fb0bf2 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2722,7 +2722,15 @@ rpc_decode_header(struct rpc_task *task, struct xd=
r_stream *xdr)
>=20
> out_verifier:
> trace_rpc_bad_verifier(task);
> - goto out_garbage;
> + switch (error) {
> + case -EPROTONOSUPPORT:
> + goto out_err;
> + case -EACCES:
> + /* Re-encode with a fresh cred */
> + fallthrough;
> + default:
> + goto out_garbage;
> + }
>=20
> out_msg_denied:
> error =3D -EACCES;
>=20
>=20

--
Chuck Lever


