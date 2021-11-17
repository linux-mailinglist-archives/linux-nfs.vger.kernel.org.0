Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3536454C1A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 18:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhKQRmh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 12:42:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233436AbhKQRmd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 12:42:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGiwV5022032;
        Wed, 17 Nov 2021 17:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C9rlQdeKsXx7QlsD89rLd+CxX7BsZp7LEL1cPP3QIbQ=;
 b=IeR6Q+FzrgA7Olhr3TlyvKrj4qaVQi0QGUHLByNoSlf0wrYrV+lHV7MNU9Jl7KJJKzNR
 smTWY7EgkXc5Fxslab6d3VfLL9prOYetdZcyMsPijNNfKpLX54ViQJ4a4Db3JclVdhIv
 aP0tNE3KRVx3K/jlJ/k2NWUe1vGKIfH4M4rXq92d65VTgBePgyrfN0WkAxVM6R7rhpHn
 Hs2vjXm2yt+b2wP2dElA1a+TyW0dJRLGn6bJhXfcC7U4tisK+8NDKYCU2dHWo9T9KxNx
 V+T/1ftXfn1INaklrW3KVyx78mh06yRjmymc02Aovkrs38EZUQ9yrVWQn0bn2Qu29wt7 hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd205a6y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:39:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHaGjc095128;
        Wed, 17 Nov 2021 17:39:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3ca2fy4e1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMAbhbRxFSIEa6R3z9J/S0izjINRkQM6uuov+iC2AWeaPmPELP/99Z+CrRuwVTaQCzN7cVbpqbsS4CatzlZTRHRW5JLWHB23yeC0hAaP1BZ/pm+bZuIB1wHI/83BiH1VFDTqbmsV12DWt4YVrMmV7a3IJN9vFCdT8XIlf46z1N6KMh+w0BCPSnHh8mLYZsWlD2Nw6ujDhclbflx+ty1hKBtYeJWCSi56SeoyTLTJ48KzMcuWs0kNfgRqcm71LtEdKT/QiksTKELxQsea6VCyvDGtFbSzMqJ/W/8Eaqp+JkZORydWrokeu6S93cZHz7TzGZ2YzZ9MqsEsWTrLQ9gz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9rlQdeKsXx7QlsD89rLd+CxX7BsZp7LEL1cPP3QIbQ=;
 b=CCjqWaFsyb2UgeLYtCekIOYurq7+8332aCGxi9iVF5AGy2gbeiG73OolgRPBI0DgTTHvJj+CsDOC8VX45URAhZFgUtACGHICR34nplQQlp7fyRczP4WCBIv9+9X6w/2IY7qpT9IxEAwaoGDNtWR43Qit10zAl41eR7n+S0G0rUIwxopAHWHz6SJNYnZX8OY649Vq+wdSUpcEkl19kUTo1ofLF64D35WciqVc+FXXrthnUy/vdhcj+94zFE1dRmzvp5AYSDtBcoq5hjcKFz5ZZVS1+6xdR8E/HRWmNlv2l2R2l11jbnWp3XCFbl78mYIZUKPtwaOE9ACMYr+VWnb7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9rlQdeKsXx7QlsD89rLd+CxX7BsZp7LEL1cPP3QIbQ=;
 b=d4JE/XYk2QBYO3F0EapQ9kxqn2zO1kKaCo1Gdzzh355RsBRyXz7Pbr3iDLYYvFZLMLx6y4YNAL3ej6epVE9LTUCpSrYW2MjByK0CL9NbBjc0cCQTHurUrVYf35tR92zQpHzh4GZd8G85Qx24eRUhnqG61EcIYutaPQtJcqQUoLI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3463.namprd10.prod.outlook.com (2603:10b6:a03:118::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 17 Nov
 2021 17:39:31 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%6]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 17:39:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs hang bugs
Thread-Topic: nfs hang bugs
Thread-Index: AdfXGKZZEGN92FvlTmSq+6WLaIGDTgEwWy4A
Date:   Wed, 17 Nov 2021 17:39:31 +0000
Message-ID: <E776762F-9A7F-4740-BDC3-32EF7222A5DC@oracle.com>
References: <dd15ba35692346c1b170f993cb52b164@xiaomi.com>
In-Reply-To: <dd15ba35692346c1b170f993cb52b164@xiaomi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: xiaomi.com; dkim=none (message not signed)
 header.d=none;xiaomi.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dce26eed-28fe-4952-75e4-08d9a9f13642
x-ms-traffictypediagnostic: BYAPR10MB3463:
x-microsoft-antispam-prvs: <BYAPR10MB34637EC77273057A05BE8576939A9@BYAPR10MB3463.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7aHdvI+N2PO9C9VVXJ5v7jtTlPJn3LAXcwsmMuue5BDcpqqrjZywTIR6DPt37fqW6P28KQm7h1Z4BDXNv9Gdaz619iJxdPcRtjIiudIHtNwnmlkYik0yme0fhB2ex6BSRn5qzlvEEa+9TfTQGkMZQYy911I+dD7BelZaFhlvaom7mWvFiNRdUqafCXxX/gaQtkyhEMNM8XE9uKPd/o5umTCg+pKQAqsvDorOzQ6P5mD7UyY/dnFc5Bz4YAGTyoXT4HqCQVmbID0WucP43AK01q+IHwoULubH5ynKVRTsOKjTAT/K9Hmp9wsaGa3/Vh9ALNjwIBVABj/lua/yHMrgjV/8K1JupEJUxeCp6erj6eANGqg+ZwEde2laQBpQqNUyyWJVYdLwxRc0fisjqNqbgUF7DtwygssZ+rE3v9M4/Na8H3JUqK8nNvgFNMkbX9Ver4I7Ner2QQIdOJFQyuRHeiAQSDmAgDPQ/exW0FkqadbqdtY2u741lsGHkPpZQiNsaYlZWPRQK2Tct2u8FtnTFc9NzmZOtKZWofDrym7UC8idr3zBfT1Y4YvaP5zIvsRhiXCp0kLMiCS7sz7+3zwRiuoaNa8QprAIPNj02z6ja08Ey1oIGl+UAg16REx3lJAG8oowOfhPgMLAm6Luc2dkrReay8Be7mjKwBCI7aFu78fDSvvSaWkpr+uJluu89dTkPDI35wR6t6J5CjMRtYJxbZZBFS5HrIbvPhUFKHXq9rMAFKmgm5PRAaTQ7/s0fAeI5cXoXbMzE/FRUiGS+PUFeYjcfF0ex/yML/Lx5L8DP6emjfl5jNAg3xwdPeIojFsJYh55Ke1hGfq09/i55O/wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(53546011)(6506007)(66476007)(91956017)(6512007)(5660300002)(6916009)(508600001)(38100700002)(3480700007)(26005)(86362001)(122000001)(66556008)(66446008)(36756003)(64756008)(4326008)(7116003)(2906002)(38070700005)(33656002)(66946007)(2616005)(316002)(6486002)(966005)(8676002)(8936002)(71200400001)(186003)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJtcW02NDVPOWNyTk1yWmhweUMrNWs3K2dkZjhZaXVJUStIbWQxMFFNQWQ0?=
 =?utf-8?B?ekQ5N1NReVhJcFhFRUoyRFlLVDdBWTBkdmN4YWZVdDJKb0g1dWhQMWxFeVhI?=
 =?utf-8?B?QzJ1ZW54cUNkMUtHYzZrV3pmWlF5N29ya0x2cGU5NndjTzdtOGI3QnVjUzZQ?=
 =?utf-8?B?WE51bW04K3JTa21FZ1Q2Q25FK1FJY3NBN0l5eVQ1M0xVNlFoY2xGL2FmT1RC?=
 =?utf-8?B?SmFRV0h1Zk1qY2NXcDIvbjUxRXhKV0VDNlVPUEF4NHB3WDNHaDlGeWtUWXFw?=
 =?utf-8?B?Sm8rek1WcUhhZmlNUmJFSGxFNnNJOGtJdTA4VkpnZTROdWlxRVo3ckpaWm1z?=
 =?utf-8?B?MnZCVFlyZDBrQ3lUZ0w2dkRXWllhZmU0ODNEQTM5aFhJTnA3Mk1oWWxPUXFR?=
 =?utf-8?B?M3E2MElLMUxOdktINkd4NHJKOEVaNjUxbUV4dGUzL1dlQ0xKQ1JqZFZMbDNU?=
 =?utf-8?B?ZWZKR1JILy9YYXVFdzdvb0p4aVBRWk9MWjF1UmlwenAvaDVaYVBybkRiYURP?=
 =?utf-8?B?UjZ4S3JNUEFicUI3d3V6TjBtdXlaS1kvNkdtQURaR1FPRlovVytSU0UxZW9O?=
 =?utf-8?B?UmZJenpFRlg2MjNRVEw1a3lmQ2VPQ2ZtNkNJUjR0d1NpNjNnTTlVVDRlNk1q?=
 =?utf-8?B?cncyWTZNK1Z3TFhsVmUrczB0Uko2U0lZSnVMNy83anZDYmFZcS9ERG43Wit3?=
 =?utf-8?B?ZlNiMjdnaEUwMUlpL0srOUkvU0s0S1RIU2lYUDZteW1oSVZuMnE0eHVLNjJ5?=
 =?utf-8?B?L2Z5QmZJSktwL0hkOFh6c01wV0VZMmVvL2o3L2hpUHFlNk5OYXdWYTBnL2VX?=
 =?utf-8?B?R2N6VC8rWlNqZnlkdVZsOHkvUmtPdkxIMnB3ZGhndGltSVFhMXcreXE0bWdn?=
 =?utf-8?B?ZWpDcmZIYXVacEpIZGNOK0tlM3JjVE43K0NNVUN0cjAzWC91d25GYVUrRkd3?=
 =?utf-8?B?TEpRcVp5RkY1bkEyMmtWRGp2NTZXWVFBUGlzM0V0dFBVMGpvalU2MzNZaUlE?=
 =?utf-8?B?STdxU1RKQklYQ1RTUzlmV0ROd2xOMUNmL2toVzZTVlVZNzArWDBzZnE5Z3Mx?=
 =?utf-8?B?VnZXYkRnaGNMeE9Ud21nZzQxblNTZ3JVWDRuQ3hEVWNNbjlVaERxVUlqZ1J3?=
 =?utf-8?B?QytYcFZUMC9JeE1DblpjMjZvMmpSTmRveVk4ZFM1dFFXMWdzTXRIZW1yWGRx?=
 =?utf-8?B?bWp4aVJ4UEUzcjNlMEpNalpLdmNzSzdpeDlIUW95UFRieHI0REpkdTV4Sldz?=
 =?utf-8?B?WVZtMWthYlh3eDh2OHNFVWw0ekxjVDluNXRLTW9lZENJaXBkN3Fsd3M5ck50?=
 =?utf-8?B?dEZGUU1GQWpWSGUrc09SK1B1M3grSFJDN1AwNlRVZEZTR3ZqNGZEUnFuL2dW?=
 =?utf-8?B?TkVQdmxSZjZyOHNyLzdYbndsZjJOYWNEaFAzWDY1bEZSclZnQVdmUWcwblox?=
 =?utf-8?B?UWlLUEVZYXd6ZEdvSE8wTTBocUpDT3B2K1ZZNUUvNGs5SFU4ZFhNdE93MFY4?=
 =?utf-8?B?RFFZblN0bHpzK09MVUh4MHZSL0dJYXFwekNBNnhaV1NDL2NHdWdBWUtZeHdN?=
 =?utf-8?B?QTZhQUgyTElwazEzd0dPb1VTMSs2RXVUa1ZsS3BqODNiMU9QQVg1QjJiNkZX?=
 =?utf-8?B?TUdCL1lxZDVLcEphWmdqRitjOEZUR2RWL2t3VGVBWXg2bk5rTHg4WWZGTVdW?=
 =?utf-8?B?M2xyOVVlbVZ0czUxWlZvdTU5U0NSMUc0SHhzUzRoWGM5YWxBQitiamNHb0Jr?=
 =?utf-8?B?eHNrak5vMHFQY3ozODVPMzF1VnkwUGl2Qi9VMElZTnIwMUhlNzhXWkJ0OG5V?=
 =?utf-8?B?MjAvSFJoTG9ISXo4aXA5TnZ6ZDQzazB0ZkhhdFk4b3hHOEZyamtRRFdZRE4z?=
 =?utf-8?B?K2ltYktURExXQWRnL3JnQ0dheHY5OVdqaCtWNkh0RVJaeXRNRWpBVGZnV1ZS?=
 =?utf-8?B?UGFiU2JKWC80M0lOV1RCVlNCR20rUzBRYUdYY1cyR1ZrUG4xZkdtN2VrK1lC?=
 =?utf-8?B?TnNxZ1hWNCthT2ZvZzYzbnA4S29weW40L21QemNOTi92c25JTjdrRExSOStq?=
 =?utf-8?B?UGNlUDNub3ZTQm96NzFlQStUR3pBRmRDeDRvOVd6SHZpUGNSSXBLMkhha0xM?=
 =?utf-8?B?WHJQMTdqWGg0ZkJCTzBESG1JVWJhUkcxdlRqaVFEYm14bUpzNW16MTd2ditv?=
 =?utf-8?Q?yPLPJUg6Pb30GVLh8jsM5j8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFF5C4C7D81C7E4E98DE88800EE98485@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce26eed-28fe-4952-75e4-08d9a9f13642
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 17:39:31.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mepicRCnGfnVCExwrROmoRHKVR76v1t0dv9V+ShheNuYtxYz+fiGIoUHkxAmizA3WTO0teuKLV5bmoXaqWEnFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3463
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170081
X-Proofpoint-ORIG-GUID: pWsRiWGCVAGfq2Pm_dwuetLZwfL3rL8z
X-Proofpoint-GUID: pWsRiWGCVAGfq2Pm_dwuetLZwfL3rL8z
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkhDQoNCj4gT24gTm92IDExLCAyMDIxLCBhdCAxMTozOSBBTSwg56iL5rSLIDxjaGVuZ3lhbmdA
eGlhb21pLmNvbT4gd3JvdGU6DQo+IA0KPiBIaS4gSSdtIGFuIHNlcnZlciBlbmdpbmVlciB3aG8g
aG9sZCBnZXJyaXQgc2VydmVycy4gQW5kIHVzZXMgbmZzIGFzIG15IGhhcmRkaXNrLg0KPiBTb21l
IHRpbWUgSSBmb3VuZCB3aGVuIEkgcnVuIGBnaXQgcGFjay1yZWZzYCwgaXQgd2lsbCBoYW5nLCBh
bmQgaXQgY2F1c2VzIGRlYWRsb2NrIGluIGtlcm5lbCwgcHJldmVudCBvdGhlciBmcyBjb21tYW5k
IHRvIGV4ZWN1dGUgbGlrZSBgbHNgDQo+IFByZXR0eSBtdWNoIGxpa2UgdGhpcywgYnV0IG5vdCB0
aGUgc2FtZSBpc3N1ZS4gIGh0dHBzOi8vYWJvdXQuZ2l0bGFiLmNvbS9ibG9nLzIwMTgvMTEvMTQv
aG93LXdlLXNwZW50LXR3by13ZWVrcy1odW50aW5nLWFuLW5mcy1idWcvDQo+IA0KPiBTaW5jZSBJ
J20gbmV3IHRvIE5GUywgSSBkb24ndCBrbm93IHdoYXQgZWxzZSBjYW4gSSBwcm92aWRlLiBJZiB0
aGVyZSBhbnl3YXkgdG8gZ2V0IG1vcmUgZGVidWcgaW5mb3JtYXRpb24sIHBsZWFzZSBmZWVsIGZy
ZWUgdG8gYXNrIG1lLg0KPiANCj4gTXkgTkZTIHNlcnZlcjogVWJ1bnR1IDE2LjA0DQo+IE15IE5G
UyBjbGllbnQ6IFVidW50dSAxOC4wNA0KDQpKdXN0IHRvIG5vdGUgdGhhdCB0aGlzIGlzIGEgZGV2
ZWxvcGVyIG1haWxpbmcgbGlzdCwgbm90DQpyZWFsbHkgZm9yIHVzZXIgaXNzdWVzLiBGb3IgZmFz
dGVyIHJlc3BvbnNlLCBpdCdzIGJlc3QNCnRvIHdvcmsgZGlyZWN0bHkgd2l0aCB5b3VyIExpbnV4
IGRpc3RyaWJ1dG9yLg0KDQpZb3VyIGRlc2NyaXB0aW9uIHNvdW5kcyBsaWtlIGEgbmV0d29yayBv
ciBzZXJ2ZXIgaXNzdWU6DQp0aGUgY2xpZW50IGxvb2tzIGxpa2UgaXQncyBsZWdpdGltYXRlbHkg
d2FpdGluZyBmb3IgYQ0KcmVzcG9uc2UgcmF0aGVyIHRoYW4gc3R1Y2sgc29tZXdoZXJlIHVuZXhw
ZWN0ZWQuDQoNClNvbWUgb3RoZXIgaW5mb3JtYXRpb24gZm9yIGZvbGtzIGhlcmUgdG8gaGVscCBv
dXQ6DQotIE1vdW50IG9wdGlvbnMgb24gdGhlIGNsaWVudA0KLSBTZXJ2ZXIgY29uZmlndXJhdGlv
biBhbmQgdW51c3VhbCBsb2cgbWVzc2FnZXMNCi0gSWYgeW91IGhhdmUgYSByZXByb2R1Y2VyLCB5
b3UgY291bGQgcG9zdCBpdCBoZXJlDQoNCg0KPiBgZ2l0IHBhY2stcmVmcyBzdHJhY2VgDQo+IHdy
aXRlKDMsICJ1c2Vycy85NC8xMDAzMDk0XG44ODY3NDE4MTdjMWQ4MjQiLi4uLCA4MTkyKSA9IDgx
OTINCj4gd3JpdGUoMywgImVycy85NS8xMDA2Nzk1XG43ZWM5NWY2YWQ3NzJmNmQ2MyIuLi4sIDgx
OTIpID0gODE5Mg0KPiB3cml0ZSgzLCAicy85Ni8xMDExMTk2XG41ZTMxMGJmODQ5MTI3NmE2YThk
Ii4uLiwgODE5MikgPSA4MTkyDQo+IHdyaXRlKDMsICI5OC8xMDAwOTk4XG4zZTFmMTc3ZjA0Mjdl
N2FhNzkwNjUiLi4uLCA4MTkyKSA9IDgxOTINCj4gd3JpdGUoMywgIi8xMDA0ODk5XG4xNGU1NzJi
MDViM2JiODU3ZDE0ZDk5MCIuLi4sIDM3MjYpID0gMzcyNg0KPiBjbG9zZSgzKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPSAwDQo+IGFjY2VzcygiaG9va3MvcmVmZXJlbmNlLXRyYW5z
YWN0aW9uIiwgWF9PSykgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpDQo+
IG11bm1hcCgweDdmN2MyZWY1YjAwMCwgMzkwMzExOCkgICAgICAgICA9IDANCj4gcmVuYW1lKCIv
aG9tZS93b3JrL3JlcG9zaXRvcmllcy9taXVpL0FsbC1Vc2Vycy5naXQvLi9wYWNrZWQtcmVmcy5u
ZXciLCAiL2hvbWUvd29yay9yZXBvc2l0b3JpZXMvbWl1aS9BbGwtVXNlcnMuZ2l0Ly4vcGFja2Vk
LXJlZnMiDQo+IA0KPiBgZ2l0IHBhY2stcmVmcyBrZXJuZWwgc3RhY2tgDQo+IFs8MD5dIHJwY193
YWl0X2JpdF9raWxsYWJsZSsweDI0LzB4YTAgW3N1bnJwY10NCj4gWzwwPl0gX19ycGNfd2FpdF9m
b3JfY29tcGxldGlvbl90YXNrKzB4MmQvMHgzMCBbc3VucnBjXQ0KPiBbPDA+XSBuZnNfcmVuYW1l
KzB4YzUvMHgzMTAgW25mc10NCj4gWzwwPl0gdmZzX3JlbmFtZSsweDNkYy8weGE4MA0KPiBbPDA+
XSBkb19yZW5hbWVhdDIrMHg0Y2EvMHg1OTANCj4gWzwwPl0gX194NjRfc3lzX3JlbmFtZSsweDIw
LzB4MzANCj4gWzwwPl0gZG9fc3lzY2FsbF82NCsweDU3LzB4MTkwDQo+IFs8MD5dIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCj4gDQo+IA0KPiBgbHNgIHN0cmFjZToN
Cj4gLi4uLi4uDQo+IC4uLi4uDQo+IG1tYXAoTlVMTCwgMTY4MzA1NiwgUFJPVF9SRUFELCBNQVBf
UFJJVkFURSwgMywgMCkgPSAweDdmNjMyNTFiMDAwMA0KPiBjbG9zZSgzKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPSAwDQo+IGlvY3RsKDEsIFRDR0VUUywge0IzODQwMCBvcG9zdCBp
c2lnIGljYW5vbiBlY2hvIC4uLn0pID0gMA0KPiBpb2N0bCgxLCBUSU9DR1dJTlNaLCB7d3Nfcm93
PTMzLCB3c19jb2w9MTEzLCB3c194cGl4ZWw9MCwgd3NfeXBpeGVsPTB9KSA9IDANCj4gb3BlbmF0
KEFUX0ZEQ1dELCAiLiIsIE9fUkRPTkxZfE9fTk9OQkxPQ0t8T19DTE9FWEVDfE9fRElSRUNUT1JZ
KSA9IDMNCj4gZnN0YXQoMywge3N0X21vZGU9U19JRkRJUnwwNzU1LCBzdF9zaXplPTQwOTYsIC4u
Ln0pID0gMA0KPiBnZXRkZW50cygzDQo+IA0KPiBgbHMga2VybmVsIHN0YWNrYDoNCj4gWzwwPl0g
cndzZW1fZG93bl93cml0ZV9zbG93cGF0aCsweDIzZC8weDRjMA0KPiBbPDA+XSBpdGVyYXRlX2Rp
cisweDEyNi8weDFiMA0KPiBbPDA+XSBfX3g2NF9zeXNfZ2V0ZGVudHMrMHhhYi8weDE0MA0KPiBb
PDA+XSBkb19zeXNjYWxsXzY0KzB4NTcvMHgxOTANCj4gWzwwPl0gZW50cnlfU1lTQ0FMTF82NF9h
ZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQ0KPiANCj4gIy8qKioqKirmnKzpgq7ku7blj4rlhbbpmYTk
u7blkKvmnInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nk
uIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbk
u5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbp
g6jliIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hm
ga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbp
gq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwgYW5k
IGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJ
QU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hv
c2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNv
bnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8s
IHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0
aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBw
cm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUg
aXQhKioqKioqLyMNCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
