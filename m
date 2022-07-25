Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D557FFBA
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiGYNYc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGYNYa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:24:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B62C13CCE
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:24:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PDI3h2031054;
        Mon, 25 Jul 2022 13:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=y4eYEyjW5yJBfFUKZ99dcPK3501t3RlE85blkG5qOlM=;
 b=MC/QeG/Zk4CY4WTSDp+voUgXkxpmtfzFnpX3jFAI9xBtvYnVTOcGwhA4lyEOzBadhGMl
 GToy0toSAwaVcGWlxxuFEETla2GSqJdcxZLmyN+6Bb3rXpoppwMThdW1uE/0Not11jf4
 mxXedgf+Ma8X8FcqC8eetWedmPyFIVwna6ZUSqiSv6j9QCmKrKHtjZv+EyAw49UrtwbW
 H6zeOEOsXXJtRA33njQaZzoXQkeLziCTtkNiLGq6wmwSyy8yREGGgoc062VxLz8HpCLY
 RlaGVwDialXAjnLJ/H11/slfPxQLzlbl/rqSHm8xgbaEpOJQQBrBPS4B0nw/iJGxFqXp Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4kbc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 13:23:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PCCW5H017371;
        Mon, 25 Jul 2022 13:23:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64y71x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 13:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0Wms/oAtbiG36NLRgIECc5MjZPgSIFrw34CcaGCmCnvAyAdjnlJ9rQR+5ibnPWpSoWiY4WEQ8hcXFHpQ+JpbMFlrpBncEez7FbV1b1mInVRX41ncL4nKbFyGxsZtjE6nMV2oEMaksR/k5NRkp7G599RaJuNGep3cCg+OrmhXaiYnWpRWjktoF491ysIEyPVUSvc2YRfiFe38NmTIplKHXUDJX1P3fhGbKPVY9JMHl2xD6EQQL8bb5hsR5bt8vwCkp41gXVvS44jH55bPmAmQ7LgqNusF01ktdLFYeU2ZFxm4jksD/CAziT4uSiH9fMxsFaYplVuBAvcJqUjnqNDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4eYEyjW5yJBfFUKZ99dcPK3501t3RlE85blkG5qOlM=;
 b=J58FXRVLmDNt6vZxJFVR0ZHcXBzXHApAd6ZdPWofr5x+AzzObv6KyE4toZZbKUH+BD06TCcHLUBHcyU9qVfUeBuWWrQGc6eIRLiIHe1RS4/AO6Ks+8mImv6WxP7kfT+nqPno1DbuCRJcoDUlLjcIkI6EtZbSFC7+GXO8FQIAqX5MLqOQpb7eduGux8DXgZnmYih+/zLHmg+WHVcA3OMiG6SxgvCgXsF33X7iHHcXw0Ni8BdY12UCrAvCGpOh2lFaO/93xhGRcddJTgPI+gr1q1HDDUHBUCAhDOzvfamJy7nToV49seJd6A7eMr9fjOJFoGzWZYlhDotKrRxhcmIupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4eYEyjW5yJBfFUKZ99dcPK3501t3RlE85blkG5qOlM=;
 b=omxQ1R06qaWtKTmD9Jyqptz39EWyQ8HEPCz2WY5THoaPojxAcNkf5FIsL663sPJnfRmuThUCW+CJPioxrScDZMWtEDX1/CMuLA+KQ/e8oQm4hyFDOQu4rAemOMGei7PJANqGYnlNRy28OrkEJxhD8SHL10qwwuxsd0ZlV6ZblaE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4126.namprd10.prod.outlook.com (2603:10b6:208:15f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 13:23:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 13:23:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Felipe Gasper <felipe@felipegasper.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Supplementary GIDs?
Thread-Topic: Supplementary GIDs?
Thread-Index: AQHYnraiR01diO7wWEOB9yPhO0sZjK2PFhQA
Date:   Mon, 25 Jul 2022 13:23:40 +0000
Message-ID: <7CE7A3E4-118D-4CB0-A952-5DC0014A0882@oracle.com>
References: <4A964428-65EA-49D4-B7B4-35D22D89D418@felipegasper.com>
In-Reply-To: <4A964428-65EA-49D4-B7B4-35D22D89D418@felipegasper.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0a605cc-90af-4dfd-843f-08da6e40e41e
x-ms-traffictypediagnostic: MN2PR10MB4126:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OVewj9CUYfT2oYq4CsuDI8tSwtNV9Z3Uhmv6wYoWDrBIhKP4vIwkqHr2eJHhutUbgG8yHxWeu/Gmr8DzDNG7eYRBI3u7VvjS8+Hv2jh1glJtI2u6K/HBsz9E2+eIxcFmQMtbq6W1vPsFXfqjb+bJ/zxAUyuWz/pMKnQdTkcm+WHL7vtrvTQfPIbwqIrEJq+33DEOQzfmoHfq+9JYvqxGQ2U9rfgRCIeTjq4CBkBXx3Vkh6eGUjyz81rjoEI6jP4vppo4TIinTFFIs13K/1i+uFx7P1EtYWV2/VgYZTDt+sSg9QsSl3kqSPAmZ1DwGNixr41Spl8hFslrw7Et//tl2qTx9CMroMzq8B7r76ECgBji4jb/cfQZHLXGd+8mrRTsD/vZxntdbSa2OF2c10Zmd4xxrRfYfjYGvDY5YsmUEedhAeX3PGD8qEQVGkAhHe+7LNQYBx64QzIB6cELOlSqKn/CRtlVHcn57SBJ9rwKzpCZcvd92Bv/drcL3WdoS3O/oSyYCfkM6kwNtqEv76uAMaWlgaHf6VEDbuBC2VtA3QSPtueUbCT2GLCnXVuaErw8WkSzLyjmV9uwTRXni4bv23UvwqgNqAQcttPl58NvLalTN+PDXDdQQiI0pUKMwX9IipHZ5kWdBIILncpUI7RUJQMmtT+Qr/dl2VKV1pA8J/Pu+gxamIQ/zbLU/5s+m0jJCXK3Ws/6p6+5T+Hp8BUF9+pCZ5Ix46Q8alqSHM7Pc7zRJtLygjsM0mSztDmd/ZE9XR+VJ7M7yQXW0TN77I9qlNc1uAKz2wLurpnoHJp9OWWDZJMg9WxtRoH+7LKbkT2bMQbwTBKd/Nks2pGDf8C/Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(346002)(376002)(83380400001)(186003)(2616005)(66946007)(7116003)(4326008)(71200400001)(76116006)(8676002)(64756008)(66446008)(6916009)(91956017)(6512007)(53546011)(66476007)(36756003)(6506007)(41300700001)(66556008)(2906002)(33656002)(3480700007)(38070700005)(86362001)(122000001)(8936002)(5660300002)(38100700002)(316002)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5KRmZKdWFiU21YTEN1T1U4b01CbGlCeU5GdE1EM2IzVkJmQzYvLzFQTzVi?=
 =?utf-8?B?Z1IzY2RxdzJvN0RhampDamo5R3ovZWhiM0RPd0lVOXZ1OHVUbXFzK0RleGN5?=
 =?utf-8?B?RjQyUmpFMVg5K2ZRVDlkS05oUE05ekxaTHVhUXB4cWJnekJmaTczMHhLSjlz?=
 =?utf-8?B?SEIrajE1UHVZaE8vbHRyV1dWdUJUN1NXV3JLdGpqWVp5QTMwN09Yazdvc0N2?=
 =?utf-8?B?bk1FdEkrWWpWRDNXUFRBd25vdERvMk9neThpcFE3ZUtyWC9TQnExbTd1MlZy?=
 =?utf-8?B?WTE4ZlkzS1Qwam1vd3dxTUpwWFZSazVxMy9RSXRVbkxqaTVVdHpvbk1nbHBZ?=
 =?utf-8?B?TTlsQ2w1MjdiNi9YVFJORndMbm9xaVhBVkRDVzJjbER3ZWUzOGdOYk9ObU1X?=
 =?utf-8?B?OGgwcmR0ZDhBTlNtQWp0TGVLd1RoWmNvYkc0UFZCNllEdldVVU5lNFpDUk1u?=
 =?utf-8?B?bG11UUJzY0d1cllyL1k3dWJVOGxOUFM2UEswaUFqS0I0S0EvUUZrcitkZFpI?=
 =?utf-8?B?cC9FSXhLUFlIaHdCNmdPN1RIMXJ2WVVkbmxHS0phV05FbHZxNWlDRmlzU3lI?=
 =?utf-8?B?KzhDSVdURVB5VDJ3L2dYTEtxclV2dEZteWUwZElHTWg0Kzg4V3h5ZnVlT2R4?=
 =?utf-8?B?SmMwNDJ1dHVkdVFWV0VGeGlTMDM5Vm80QTYrcDlNNDNvMHUvSzY0bHZ3ZmJr?=
 =?utf-8?B?ZUJJUGdqcHEwc21SQ2NiZ0hrWVRSN0E5MVFTczBrd2RCS0ZzeFBDNHNScHFH?=
 =?utf-8?B?TWJ0Ym04aStxQ25KVkthaWx2L1l2dTdTZjlHUWRNUU5KYzZpTUJLZkRIamdG?=
 =?utf-8?B?R0hjMTc5RnRIclpabHdWRndKZnpWTDhhRTNCd01ReWhYZUU1aDY2SEtFNFZ5?=
 =?utf-8?B?eU5zRnNwOFA1aXhYVGIwNWZZMG43Q3JkN2tJZkM0WXlIM3Iza2ZvMWJ0Q2NT?=
 =?utf-8?B?QXprMzRTYW9pYnRETDFHZi9jWmV5RmtPc1RXcHVneFo1L3F5OHBoSHBtRGpB?=
 =?utf-8?B?eFRJZ0JXaVJEb0o2amRPRjAzNzBkS0dCVkpzZG9LZG9CRFNWWVBxcHlMWGtl?=
 =?utf-8?B?M2U3bFJ1NTFDWFNyTm51eFF1WUlNQzVNMmJGdVZWWVg2b3A3cktML0owa3d4?=
 =?utf-8?B?S2w5THBPdkx4SXRLbEhMZXkyeWQvZk92SXFtK3FZMTJMME0rbTcrRXZpUi9r?=
 =?utf-8?B?SlNxNlY2Ym0wTFAyUmFWaUJaQnBNMnNvZVl1dUV0b1l6elpiWU81VnViUkNS?=
 =?utf-8?B?REJ1c2JoOEdWQUxMc0Q3UlhDdHNYR3FleXhKZHZ3K1ZOT0gvWDZmQXZveGdD?=
 =?utf-8?B?NUdieC9jYjlmVldOTXlzUG8wOGxhbzF4WWYyWlByRGJwZ0trM3ZFYXdRNTRp?=
 =?utf-8?B?VUQyVVpCdmlWVTVXNXNkVFI3TnVHdGtXcy9QWEdMcENMc1A5T00rQ1FQVEcz?=
 =?utf-8?B?YWlWcEx6K0N1RTlra3I3bEFndlh5blU3WE5USEw0ZEtORGRUNi95NGtDTk5S?=
 =?utf-8?B?OWlUbEM0djR6clYzWUFtZG5HSWsyaDFZcDF3M0RBenR4ek9penhmdmg3SUxZ?=
 =?utf-8?B?dTlDc2VJM2hCWWhKTjEvajBrRy95NFFtc3RXd0VqK0Y0b0VhVjlpdG5wQm4z?=
 =?utf-8?B?R2xBanNrM21aVGlzSU9wNU94ZHlCdWpEYUxHMC92aFNqWllaK3Rwcko3eERO?=
 =?utf-8?B?WXdoejZtc2FIKzdOSEJDTEVqOUltSkNNL1NhMWJwUVFXRjJkM2VwTnpIbXJ4?=
 =?utf-8?B?Nzk4SldJeFp6RTFhWXUwdjc4T25QRURtTGxjQ3U1R28zbC85YTYrMXEwOXFt?=
 =?utf-8?B?dGR1Zlk4UGpEU21QMUdCVmUvVkFEYW9uVHNhaE1qenlsVnRWbUhaTjgzc2Mv?=
 =?utf-8?B?Ym53dEFGVzlKaDJrT2hFaHd2TUNUQ2VKL1UrTjJab3JHVmNHa1JVeDQyR1kw?=
 =?utf-8?B?ZzZLLzJ0ZHhTZndNN3I1VGh4b3IrMW5NTnJrdXNRL1dRajJIUlhrU2JvV3dG?=
 =?utf-8?B?UURJNDVjaWRjVGRYaUtsSTZzYUo2ek1iZFA5T2FVdzZac1NYOTFOSHpDSHVq?=
 =?utf-8?B?Rm41Sk1UR24zQVBJOFBrbTdoZlBsOW5QS2NRelNLTGlialZUSE9ZOFdsK2xk?=
 =?utf-8?B?cWxROTVIZjc0OFEzeFRIaTN2NWt5cHV6Wkh6U0k3ZlhUMTRBenpVQUw3djZl?=
 =?utf-8?B?OVlaUFJkQU5hKzd0Ynp5emkwNFBxV2pZZm1LT2dUZk9wOU1ibXVLVmtBSC80?=
 =?utf-8?B?b21QdHgrVU9KaGtKUlcvR0hvZWRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <530897D9FE29D84A9568FEB56DEA0F4C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a605cc-90af-4dfd-843f-08da6e40e41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 13:23:40.9889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Od5JDGAILWiz8iW55j3EAfHg9ZjB0MQP9rBk4gObCuTC3n3rU9iJTevfFF4Pl9o7EXmqPyhM41+MhCEwTKRAjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_09,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250056
X-Proofpoint-ORIG-GUID: QsJgB6OJ1qTEjFGljUmLcp5isOBNRQW5
X-Proofpoint-GUID: QsJgB6OJ1qTEjFGljUmLcp5isOBNRQW5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSnVsIDIzLCAyMDIyLCBhdCAxMTo1MyBBTSwgRmVsaXBlIEdhc3BlciA8ZmVsaXBl
QGZlbGlwZWdhc3Blci5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8sDQo+IA0KPiAJSeKAmW0gc2Vl
aW5nIHR3byBkaWZmZXJlbnQgYmVoYXZpb3VycyBiZXR3ZWVuIGtlcm5lbCBORlMgc2VydmVyIHZl
cnNpb25zIGluIEFsbWFMaW51eCA4IGFuZCBVYnVudHUgMjAuIFRoZSBmb2xsb3dpbmcgUGVybCBk
ZW1vbnN0cmF0ZXMgdGhlIGlzc3VlOg0KPiANCj4gLS0tLS0tLS0NCj4gcGVybCAtTUZpbGU6OlRl
bXAgLU1hdXRvZGllIC1Nc3RyaWN0IC1lJ215ICRmaCA9IEZpbGU6OlRlbXA6OnRlbXBmaWxlKCBE
SVIgPT4gIi90aGUvbmZzL21vdW50IiApOyBteSAkbWFpbGdpZCA9IGdldGdybmFtICJtYWlsIjsg
bXkgKCR1aWQsICRnaWQpID0gKGdldHB3bmFtICJiaW4iKVsyLDNdOyBjaG93biAkdWlkLCAkZ2lk
LCAkZmg7ICQpID0gIiRnaWQgJG1haWxnaWQiOyAkPiA9ICR1aWQ7IGNob3duIC0xLCAkbWFpbGdp
ZCwgJGZoJw0KPiAtLS0tLS0tLQ0KPiANCj4gCVdoYXQgdGhpcyBkb2VzLCBhcyByb290LCBpczoN
Cj4gDQo+IDEpIENyZWF0ZXMgYSBmaWxlIHVuZGVyIC9tbnQsIHRoZW4gZGVsZXRlcyBpdCwgbGVh
dmluZyB0aGUgTGludXggZmlsZSBkZXNjcmlwdG9yIG9wZW4uDQo+IA0KPiAyKSBjaG93bnMgdGhl
IGZpbGUgdG8gYmluOmJpbi4NCj4gDQo+IDMpIFNldHMgdGhlIHByb2Nlc3PigJlzIEVVSUQgJiBH
VUlEIHRvIGJpbiAmIGJpbi9tYWlsLg0KPiANCj4gNCkgRG9lcyBmY2hvd24oIGZkLCAtMSwgbWFp
bGdpZCApLg0KPiANCj4gCVdoZW4gdGhlIHNlcnZlciBpcyBBbG1hTGludXggOCwgdGhlIGFib3Zl
IHdvcmtzLiBXaGVuIHRoZSBzZXJ2ZXIgaXMgVWJ1bnR1IDIwLCBpdCBmYWlscyB3aXRoIEVQRVJN
LiAoVGhlIGNsaWVudCBpcyBBbG1hTGludXggOCBpbiBib3RoIGNhc2VzLikgQm90aCBhcmUgY29u
ZmlndXJlZCBpZGVudGljYWxseS4NCg0KT24gZWFjaCBORlMgc2V2ZXIsIGNhbiB5b3UgcnVuICd1
bmFtZSAtYScgYW5kIHNob3cgdXMgdGhlIG91dHB1dD8NCg0KT24gb24gdGhlIE5GUyBjbGllbnQs
IGNhbiB5b3Ugc2hvdyB1cyB0aGUgb3V0cHV0IG9mICduZnNzdGF0IC1tJw0KZHVyaW5nIGVhY2gg
dGVzdCBydW4/DQoNCg0KPiAJRG9lcyBhbnlvbmUga25vdyBvZiBhbnl0aGluZyB0aGF0IGNoYW5n
ZWQgZmFpcmx5IHJlY2VudGx5IGluIHRoZSBrZXJuZWzigJlzIE5GUyBzZXJ2ZXIgdGhhdCBtaWdo
dCBhZmZlY3QgdGhpcz8gSeKAmXZlIGRvbmUgYSBwYWNrZXQgY2FwdHVyZSBhbmQgY29uZmlybWVk
IHRoYXQgaW4gYm90aCBjYXNlcyB0aGVyZeKAmXMgYW4gTkZTIFNFVEFUVFIgc2VudCBpbiBhbiBS
UEMgMi40IHBhY2tldCB3aG9zZSBVSUQgJiBHSURzIG1hdGNoIHRoZSBwcm9jZXNzLg0KPiANCj4g
CVRoYW5rIHlvdSBpbiBhZHZhbmNlIQ0KPiANCj4gY2hlZXJzLA0KPiAtRmVsaXBlDQoNCi0tDQpD
aHVjayBMZXZlcg0KDQoNCg0K
