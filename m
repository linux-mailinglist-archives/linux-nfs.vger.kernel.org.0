Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7933F3E872D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 02:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhHKAUN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 20:20:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43878 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235579AbhHKAUM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 20:20:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B0FOwH006614;
        Wed, 11 Aug 2021 00:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zq72IN5UNepBF5Zq3VO26rHeRWE2QtDxnj4Jkpxbwwk=;
 b=YSg+1xhGPtdqvGXGzuH+vIxjjQJwEKJCjQFaH8aY9DxaJzvUin6u+2GgX/1i4JBNCA3s
 z0spOtQc4SSzoR30DaE4ZosxJfU+C0p8Dqm9h3M1ZXTk2UeuHc5YcTkETVGstv+P7FRz
 SlJ+WSY+qPFxLjxbR2cE28h2YjC4XUNlV7i679TWVEJUwVRh6U1dF7XypTmj7LXppcjs
 AIUjkZiB+qzPq18E5A8fmQH7DSzk/4J5KebBURIrvi+PxH+xf0CEt32s3R9rYRoLLXRj
 Qpgy1pDpfG1X9AitPipARl47D+9rmQWxBGDHXDu/8bLJBfetmLfNPEr0uaLhvwo3KlzB EQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Zq72IN5UNepBF5Zq3VO26rHeRWE2QtDxnj4Jkpxbwwk=;
 b=xcPTnkeP8g2r8StN8k1paD0h+nblKNTmuAcf4Tg3T1e6pd0o7or5MNP196f5dOogLGwq
 RInaqCkWX9zlVaXhLOmpf582ZtPQk2HH752brAfL8xGZJaRNxfxbP8V+DB06wF4O1oHA
 bwV2SzF6JftzXhvrewKMM0m38aW3qM2m59PTCwgDGQuEEw67WTCyW/hcy7bBM8IJZZvJ
 VdC2mJLVJZ5pdE7d7inMTK/OUsoRTX2FdTKizGu0eN7itI98QaZKlHWvLBkPmh/ACVIV
 dzxxZnzcsKJp3gTo49wBmfBOIpc50NQbRZ4pKghpqa9jTHMFP8dG6Vm+0Sw/5X3hsBEi ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17dvu3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 00:19:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17B0GVqt092295;
        Wed, 11 Aug 2021 00:19:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 3abx3uqp8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 00:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjcUeTQ/NloUsFEJ5I4hd0LelskOv1R73pD6HWk+7LUoLkwRMi7jgjJK7Pb/Pisb9wc5WZ4OT6wj8mYfeLLRxRJ8fbZKc4URBgW7fA4itfa9k4Ix0gPTjb0mOPODZLqzHzagF/mxfEuLSLieeBSmXttGbU/Scv0cVEAo2FbtG7uXr/zfoO+TCcWPN5Yt0d+T1r3Fe1xXuo9Y8HxP/yJtBWcEfuYTDdSamzrjaoFZhaK1yV+VeJG3tD8BTnpj23UcddIQMx1MQn1yDvixPq6p/Rvv+Zpi3zKVt0tpLTmAuFll20B1PZvtMqQO3jOyx7cJKw7xiEvWNA/rQ151q311/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq72IN5UNepBF5Zq3VO26rHeRWE2QtDxnj4Jkpxbwwk=;
 b=E6pd4Y7PS6qIelIZicRs/RJHx0qzxPAVP0XbRhka44EheDizcHIbm+d/u0uohri2OKuRSDH8lCPYLC1i6WnIk+e4s8H7Op2FGeYPUKlRNV8eNJvOORhT4enSxHX+6Le40Hk1pbQLhDHe31sRUNc1lF8HfnQk3jdtTiaPOHoozM7DxsTccsLVTQ0HKIWTx/H9W3hNJdcbV7FWT5NN0EfB20DbcH9yOYmfUPozgjTcy1cwdthkjUSmHYghzZnlfUCY9I5W95ZXuTGn43SX1imsLuaHXRQp2ASQ/QpgF5mvDL39M6oIaqLSf/QQzGVVtnxEOjS1Wd7Fpb0VJSAJOhZ29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq72IN5UNepBF5Zq3VO26rHeRWE2QtDxnj4Jkpxbwwk=;
 b=RYLS9MoTA66yvjnBVn9w5LNDtDyYel1mrXvkn2br734rt8NTmmkPWM9N+XbBD0rrpDJcuqEiUD/vDkcEq4JIrYJMnCmSdYYuP6L75fOuQKwpZghBY0f8gwJAyNhHgEBPfU1zjxXADWkVVEb/Ccw8kVLV0X86QuzbhLk6BronrIs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2485.namprd10.prod.outlook.com (2603:10b6:a02:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 00:19:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 00:19:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXQ==
Date:   Wed, 11 Aug 2021 00:19:44 +0000
Message-ID: <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>,<141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
In-Reply-To: <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d200be0-4384-4e9e-6e78-08d95c5db871
x-ms-traffictypediagnostic: BYAPR10MB2485:
x-microsoft-antispam-prvs: <BYAPR10MB24853F164F3B76E7DACF9C6A93F89@BYAPR10MB2485.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kLmALn5pw7/Sd477Kh00obsT+gD4tOmJItD3uVHIpT22DPSgPyuunf5k/5a3lrKVDUrR1pkyVNqkpp/RikU4YqT9Wik1RqqJeVtEcHKRLaRxF8SyU8FDIORT0q49x5XNgto1MMsXo3o5/dWpfEhCn/3PfoBe0v5QDMLREM/OMQgOgf1a9R7fOnrL2bXzcZ9XkCvaBtesJ6fvs4l5QWEuuStqQ9gn40gRCJEFht7nTKX6aJrakklSECu+wEaE8Wi9bP7u0Pu8CHoUMwqWNzNjEOHssJk4dV56+m62D3EtX0+XE/Tr2LeknSUSlLKXJbU7UhVCMuLfgTmWpXdObI/TZbCDHv1MQQlloyppgUFFDK1E2Vloa9q/0UF6j75vW6oJhi6ADyquvbDScmS4ayZnyHwPl3BGIeHtDtjM/JRxkMEY0ShDmbooIKIlD73BcUIqd/cpUDyCcMnH7ExcE+p+CWD8jT/fJCA3Nr8aiGIAwv4WWVa8+mv2ANAVRSsqqRu2Qpqh6ZGDTFUewfgcN64Onn2bhRaVJl39Qw+Scqtobhjyirxbbjauvvn6WI6vtsvjTo01wBPH02uskgyU6rYXOoC0620/viulLcy90sbUXpUPM/CPCD1Ab7Lnv0KwNe6zDt5grVi5OEgdCP8rD3WGiKOBqJD9usz1wVNmIZt2zcIXTfOkyveSc8rqpkBO/RAsIPOfb2plzYsFlBjcCxpDwgi92mWWKKuwI0GPlnJb0EtXGnAIofMYFJ3R2n6mQ5A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(66946007)(6486002)(38100700002)(86362001)(122000001)(6512007)(6916009)(2616005)(66556008)(33656002)(76116006)(36756003)(316002)(66446008)(6506007)(91956017)(66476007)(64756008)(186003)(53546011)(4326008)(2906002)(26005)(508600001)(71200400001)(5660300002)(8676002)(38070700005)(83380400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW1MSGFDQmN3ZmRoODVzSjk1a09vUUZ0MjFrVVo2UWxDY1Bsck9POEtHa3Vv?=
 =?utf-8?B?UVJuMWtOamwxWHUzbW0vbmxzSTRucEd0RWt6WGM1cUc2dndEZVlkMU5zSXJF?=
 =?utf-8?B?UmV2TDVMQi90aTIvbzNaLzNFMTlyVU11KzZKbDI0SkpCU3RyelE1TldkeVRX?=
 =?utf-8?B?T1djYjZETDBkd1FLWUl2OGpmOXFRT3ZLU29LREZac3FZc3hMVkh3UG1zdytj?=
 =?utf-8?B?bnl6WVRjdkw5b1FPWEpkYlA3NUZUUG9NenNtVzE2UTF0ZUx5UWFoWkZjZHl4?=
 =?utf-8?B?N1huZlhjS0xEV0tSV1Nacm1ESE5hNldVcjMwdlZFR0pNMW9FRWwwVG9LeW13?=
 =?utf-8?B?R3pOd1F3dFNTNlhIUi9XdUY4OHFYajlQU1VIcXRzb2pkREZYRWo2WmorcWlw?=
 =?utf-8?B?UmVRSHI4eWZkOFlmM0d4WXNJd2U5RjFRc1MvNnlPenlsQkYvY1FWWjhMMmdG?=
 =?utf-8?B?MHM0NUp1MGRQbEJyQXAwQ2ludElMbzVyVUFvRFdjUVVqanpXOWo0Yno4R3p3?=
 =?utf-8?B?RWdIZk0yakdKb2tZaEJQSk1HSWhBakZ5R0dtdTRNRzhyb2tFTy9zL2R4VEs2?=
 =?utf-8?B?Y01TRmw5c1NSSmNpR3VEc1lhaC81Y2xRc1Fsb2tnanBHeXBwbnFHNGxlR1FJ?=
 =?utf-8?B?cXE0RHFuNTZJT0YrdzZpR1B5V0M0ZWRrSnpnRENReFNDU0d6Q1pqb29rT0JE?=
 =?utf-8?B?SFkxa05pWGZUeEU3QU5VVTRuS3JUaHNHeXZ0TXpnSkxhbkQ3aDFpa3hYRVVM?=
 =?utf-8?B?L29Qc05waEMzMXZEQ1IzREhDZEx0M3RmSTBRaEk2MzcyZEpoOTJhclJGdWZJ?=
 =?utf-8?B?dEVTYmRkVUI4K3p3aXNpZC80QjQyYU5DUFBodUk2SnRuUlh2M29vdUVITzR5?=
 =?utf-8?B?VFlaVEcyQUYzTHlQR0VVYmpTbmlGQXRreUhrMVV6L25RYnZmWi9IMmtIZUFE?=
 =?utf-8?B?R2xZb3dHa0JEWmU5d01sR2dyUmxlN1h4OXZoQTBmYnoxRjQrN2UwREdJQTJL?=
 =?utf-8?B?Tm91SlJGNTd5K1hNVDhoblBjWlkzRG91ZGc3WUpjS3d0TmNiWFp2WDRkaVp6?=
 =?utf-8?B?MDZvdnFUWGJ4VTNiZHBHSklPNXNUc2JUMUlqOFBmWHpJcHVCa1dRU0IvTksz?=
 =?utf-8?B?anpTNUJKYVJOcWgzRFZvL3VoZ2wxUG45MWwrTDRxdVAwRi9aaW9OeTJPbEIr?=
 =?utf-8?B?cXpBM0RlSjd0NGh1cFBkOHo2cDVLdkZPaUpUS1RHWXlQcHhRQkthU0xTYUdt?=
 =?utf-8?B?MGJpTUxpOThIcnd1WjFFVFBSNEplbVpBOTJzZU9HZFh6THRmU2xhSUlFQmZR?=
 =?utf-8?B?R2kyTUJMUHl1TTRybll2Yjl6MHIrRGVib0pwYkdqT1NBUjlub3k4ZXlnRlo4?=
 =?utf-8?B?dHhXams3SnpvVWdIUnA4NEdCZCtIQmlHR1kzTE5BMFNkcGhOZWNFcWJyZHZJ?=
 =?utf-8?B?MDRvY295Q0pXckpZYmxSSXlkeVcxR29wazBPeERVc0ZsV0NSNmUzTk1qM3Rp?=
 =?utf-8?B?TURhNHVIOGFkUGNvRWQ3QW1qeEpVeFhwN1ZVWkUrVjdoUlRVdU96bGhvMlhu?=
 =?utf-8?B?dFFrUXd6YnJUQ0w1WCtMaFBsYWNCRFhySFgvVW5WK0JmQUxpTmRhUm5maVR5?=
 =?utf-8?B?Z3p1WCtCTFd0T1R6QzFnY1ZJYVFiZUdHSnRBUldLalg2aGxSRzE0VEpXZVRP?=
 =?utf-8?B?TnErblNyYzZUdlQxbTJRNGFDUERJWFc1Z2lvaDJ6Q012Z0hzcHIwWUFUeUxI?=
 =?utf-8?Q?vAl21VkRoe22LYlHE5MxFiRXF/k4JPWnk1dNXEA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d200be0-4384-4e9e-6e78-08d95c5db871
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 00:19:44.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2uspIDmRFn07uzlJbxzYCdyVZd6BqNeMvFcJa0+dHRwE9og+YwdriC0ZNF0RRAC25rgxlhGPOx5P1A/gAXNEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2485
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110000
X-Proofpoint-GUID: YLz3WdyeXHJtdZYT1YzFdo9YjmB1UqyI
X-Proofpoint-ORIG-GUID: YLz3WdyeXHJtdZYT1YzFdo9YjmB1UqyI
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIEF1ZyAxMCwgMjAyMSwgYXQgODowNyBQTSwgVGltbyBSb3RoZW5waWVsZXIgPHRpbW9A
cm90aGVucGllbGVyLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiAxMC4wOC4yMDIxIDIzOjQwLCBU
aW1vIFJvdGhlbnBpZWxlciB3cm90ZToNCj4+PiBPbiAxMC4wOC4yMDIxIDE5OjE3LCBDaHVjayBM
ZXZlciBJSUkgd3JvdGU6DQo+Pj4gDQo+Pj4gV2hhdCBJIHNlZSBpbiB0aGlzIGRhdGEgaXMgdGhh
dCB0aGUgc2VydmVyIGlzIHJlcG9ydGluZw0KPj4+IA0KPj4+ICAgICBTRVE0X1NUQVRVU19DQl9Q
QVRIX0RPV04NCj4+PiANCj4+PiBhbmQgdGhlIGNsaWVudCBpcyBhdHRlbXB0aW5nIHRvIHJlY292
ZXIgKHJlcGVhdGVkbHkpIHVzaW5nDQo+Pj4gQklORF9DT05OX1RPX1NFU1NJT04uIEJ1dCBhcHBh
cmVudGx5IHRoZSByZWNvdmVyeSBkaWRuJ3QNCj4+PiBhY3R1YWxseSB3b3JrLCBiZWNhdXNlIHRo
ZSBzZXJ2ZXIgY29udGludWVzIHRvIHJlcG9ydCBhDQo+Pj4gY2FsbGJhY2sgcGF0aCBwcm9ibGVt
Lg0KPj4+IA0KPj4+IFsxNzEyMzg5LjEyNTY0MV0gbmZzNDFfaGFuZGxlX3NlcXVlbmNlX2ZsYWdf
ZXJyb3JzOiAiMTAuMTEwLjEwLjIwMCIgKGNsaWVudCBJRCA2NzY1Zjg2MDBhNjc1ODE0KSBmbGFn
cz0weDAwMDAwMDAxDQo+Pj4gWzE3MTIzODkuMTI5MjY0XSBuZnM0X2JpbmRfY29ubl90b19zZXNz
aW9uOiBiaW5kX2Nvbm5fdG9fc2Vzc2lvbiB3YXMgc3VjY2Vzc2Z1bCBmb3Igc2VydmVyIDEwLjEx
MC4xMC4yMDAhDQo+Pj4gDQo+Pj4gWzE3MTIzODkuMTcxOTUzXSBuZnM0MV9oYW5kbGVfc2VxdWVu
Y2VfZmxhZ19lcnJvcnM6ICIxMC4xMTAuMTAuMjAwIiAoY2xpZW50IElEIDY3NjVmODYwMGE2NzU4
MTQpIGZsYWdzPTB4MDAwMDAwMDENCj4+PiBbMTcxMjM4OS4xNzgzNjFdIG5mczRfYmluZF9jb25u
X3RvX3Nlc3Npb246IGJpbmRfY29ubl90b19zZXNzaW9uIHdhcyBzdWNjZXNzZnVsIGZvciBzZXJ2
ZXIgMTAuMTEwLjEwLjIwMCENCj4+PiANCj4+PiBbMTcxMjM4OS4xOTU2MDZdIG5mczQxX2hhbmRs
ZV9zZXF1ZW5jZV9mbGFnX2Vycm9yczogIjEwLjExMC4xMC4yMDAiIChjbGllbnQgSUQgNjc2NWY4
NjAwYTY3NTgxNCkgZmxhZ3M9MHgwMDAwMDAwMQ0KPj4+IFsxNzEyMzg5LjIwMzg5MV0gbmZzNF9i
aW5kX2Nvbm5fdG9fc2Vzc2lvbjogYmluZF9jb25uX3RvX3Nlc3Npb24gd2FzIHN1Y2Nlc3NmdWwg
Zm9yIHNlcnZlciAxMC4xMTAuMTAuMjAwIQ0KPj4+IA0KPj4+IEkgZ3Vlc3MgaXQncyB0aW1lIHRv
IHN3aXRjaCB0byB0cmFjaW5nIG9uIHRoZSBzZXJ2ZXIgc2lkZQ0KPj4+IHRvIHNlZSBpZiB5b3Ug
Y2FuIG5haWwgZG93biB3aHkgdGhlIHNlcnZlcidzIGNhbGxiYWNrDQo+Pj4gcmVxdWVzdHMgYXJl
IGZhaWxpbmcuIE9uIHlvdXIgTkZTIHNlcnZlciwgcnVuOg0KPj4+IA0KPj4+ICAgIyB0cmFjZS1j
bWQgcmVjb3JkIC1lIG5mc2QgLWUgc3VucnBjIC1lIHJwY2dzcyAtZSBycGNyZG1hDQo+Pj4gDQo+
Pj4gYXQgcm91Z2hseSB0aGUgc2FtZSBwb2ludCBkdXJpbmcgeW91ciB0ZXN0IHRoYXQgeW91IGNh
cHR1cmVkDQo+Pj4gdGhlIHByZXZpb3VzIGNsaWVudC1zaWRlIHRyYWNlLg0KPj4gSSB3b25kZXIg
aWYgcmV2ZXJ0aW5nIDY4MjBiZjc3ODY0ZCBvbiB0aGUgc2VydmVyLCB0byBoYXZlIGFuIGVhc2ll
ciB3YXkgdG8gcmVwcm9kdWNlIHRoaXMgc3RhdGUsIHdvdWxkIGJlIHdvcnRoIGl0Lg0KPj4gQ2F1
c2UgaXQgc2VlbXMgbGlrZSB0aGUgYWN0dWFsIHVuZGVybHlpbmcgaXNzdWUgaXMgdGhlIGluYWJp
bGl0eSBvZiB0aGUgTkZTIHNlcnZlciAoYW5kL29yIGNsaWVudCkgdG8gcmVlc3RhYmxpc2ggdGhl
IGJhY2tjaGFubmVsIGlmIGl0IGdldHMgZGlzY29ubmVjdGVkIGZvciB3aGF0ZXZlciByZWFzb24/
DQo+PiBSaWdodCBub3cgSSBhbHJlYWR5IHJlYm9vdGVkIHRoZSBjbGllbnQsIGFuZCBldmVyeXRo
aW5nIGlzIHdvcmtpbmcgYWdhaW4sIHNvIEknbGwgaGF2ZSB0byB3YWl0IGEgcG90ZW50aWFsbHkg
bG9uZyB0aW1lIGZvciB0aGlzIHRvIGhhcHBlbiBhZ2FpbiBvdGhlcndpc2UuDQo+IA0KPiBJIGFj
dHVhbGx5IGVuZGVkIHVwIGRvaW5nIHRoYXQsIGFuZCBzdXJlIGVub3VnaCwgb24gNS4xMi4xOSwg
d2l0aCA2ODIwYmY3Nzg2NGQgcmV2ZXJ0ZWQsIGl0IGVuZHMgdXAgZ2V0dGluZyBzdHVjayB2ZXJ5
IHF1aWNrbHkuDQo+IFVzaW5nIHhmc19pbyB3aXRoIGNvcHlfcmFuZ2UgdGhpcyB0aW1lLCB0byBo
YXZlIGEgbW9yZSBpc29sYXRlZCB0ZXN0IGNhc2UuDQo+IA0KPiBUaG91Z2ggdGhlIHRyYWNlIGxv
Z3MgSSdtIGdldHRpbmcgZnJvbSB0aGF0IGxvb2sgZGlmZmVyZW50LCBzZWUgYXR0YWNoZWQgdHJh
Y2VzIGFuZCBycGNkZWJ1ZyBlbmFibGVkIGRtZXNnIGZyb20gYm90aCBjbGllbnQgYW5kIHNlcnZl
ci4NCj4gVGhlcmUgaXMgbm8gYXBwZWFyYW5jZSBvZiAibmZzNDFfaGFuZGxlX3NlcXVlbmNlX2Zs
YWdfZXJyb3JzIiBvciAibmZzNF9iaW5kX2Nvbm5fdG9fc2Vzc2lvbiIgd2hhdHNvZXZlciwgYW5k
IGl0IGRvZXMgbm90IHNlZW0gbGlrZSBpdCdzIHRyeWluZyB0byByZWNvdmVyIHRoZSB0aW1lZCBv
dXQgY2FsbGJhY2sgY2hhbm5lbCBhdCBhbGwuDQoNClRoYW5rcywgSeKAmWxsIHRha2UgYSBsb29r
IGF0IHRoZSBuZXcgaW5mb3JtYXRpb24gdG9tb3Jyb3cuDQoNCg0KPiBTbyBJJ20gbm90IHN1cmUg
aWYgdGhlIG90aGVyIGlzc3VlIHRoYXQgc3B1cmlvdXNseSBoYXBwZW5zIGlzIHJlbGF0ZWQuDQo+
IEJ1dCB0aGVyZSBkZWZpbml0ZWx5IGlzIGFuIGlzc3VlIHdpdGggaXQgbm90IHJlLWVzdGFibGlz
aGluZyB0aGUgYmFja2NoYW5uZWwsIHNvIGZpeGluZyBvbmUgbWlnaHQgZml4IHRoZSBvdGhlciBh
cyB3ZWxsLg0KPiA8cnBjZGVidWcudGFyLnh6Pg0K
