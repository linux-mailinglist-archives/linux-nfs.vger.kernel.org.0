Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9732FE143
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 05:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbhAUDwy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 22:52:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46724 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393005AbhAUBzw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 20:55:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L1sGwB026861;
        Thu, 21 Jan 2021 01:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TLdBWSATSwUWrtEr+IwC2SglC9pgS5OjZqHjXxplE0U=;
 b=eCmcTFj5ylDXqjghmoVJ6AuRpAJoUIzAr13KbefMrdrfJun6qODisHXOLgbNLhrnRQtf
 sE6ew80pP9LFq8K8u/graM+XgBgE8BFLdZ1OHMfnupWGxtpNHhc7+21AUnu7S7vtYaSn
 8sRqX6/oaQQ+JXtsBCQZnM6uUbABhzkWrr1lJ4fmc21sBaKJIMT8fMBVMkrFpLQljEqo
 rq/0er0ZjJ8ayB9aKpP1jz+haDPCBy3GGO+V9lsycvGPPvKWaiP+/tK2S+tlguhDuvOO
 I6s3v/XMR6hLAZabwDb367xTBOg8mJ03CUtTV9ce0t/lgGGoE3EfYGxlV9dVQ76mwnZo sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3668qmw6ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 01:55:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L1ZrZp128496;
        Thu, 21 Jan 2021 01:55:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 3668rexa0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 01:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2RbOlky9/UdupWB40M2MnHBk3o7OzjjPboK8ZFwrG00zsllW3I69dZonTHTU+S41LJQKaSislfy/0WrRcJNQuPg8B8GVhdpOjSWGgIWutLgdhxEQ+PVtJ4TddbN2wc7cqnw1c2WhpljOLR0eNvcV76ii7OcO62/+FN7rinhV0GUdsLExpPHraiGtACKt1Ss1azXaBD0mY2PoMntMn65InVuB/kSSvZEKGBt5gflbvwYiGh8nzFIdqheOCcGUjq5ttSkIrWKP2ttqw81rIn5yZXnWdBE+g96AVzePeHngzcD1UqlmfWUuEuzc3igPGEfr2vi2GlsP5pYKh95+EhEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLdBWSATSwUWrtEr+IwC2SglC9pgS5OjZqHjXxplE0U=;
 b=QhFvEgW532u0k1fucV2ffrDMqYjuUm5I+yc2qaS6uN3ArjqXQppCviWktcFvXS3of4s7AXHfIp8az8YAGukXMWG9t68lWsGTQbxgf8MWI7gdPP5S6bp/41w3h9OrNpXQG42f3CR0sNH8Elc6fIW0gUb9p4HXK+dJf8GoLdjwZ3Un/ggmIWcE8xXQWcRzO402nK2qhGGBRUgY4BH9MvNYL+5aie8EVNFcNLxdGrUdelQk53+FGBfO5ADzJmgvb4dkcZWq8mdeucTl3Eh/WUUi/KjoUJcV2kU2vBkEkodv7lOmlqVszBLCpnTSc7X7OpOaqNi4uWseCMwELSmcJ3NTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLdBWSATSwUWrtEr+IwC2SglC9pgS5OjZqHjXxplE0U=;
 b=RZ7w7gUMcgCy4HilGOjBDzMPOkYUcL+lSSP0QgY7Bu52RTCX7lS6wfnOH8LpHlRkHbEb0ZcP4AqFVlBt5Nn5BhYl7SIq2IKsbZuHBH6cbBnBL56hBfoGOHuCYMtIabOCGXRnran7joKlumx9Oo99hINGTEuXvLu20R9HGlKNfxI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 01:54:59 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 01:54:59 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] nfsd: refactor lookup_clientid
Thread-Topic: [PATCH 4/8] nfsd: refactor lookup_clientid
Thread-Index: AQHW7rNqZSoyw/V3W0GmJH/akLdGV6oxAbMAgAAhJQCAADCbtg==
Date:   Thu, 21 Jan 2021 01:54:59 +0000
Message-ID: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
 <1611095729-31104-5-git-send-email-bfields@redhat.com>
 <D646BC66-D79B-4EA7-807E-A60B5255FFF9@oracle.com>,<20210120230102.GC167212@pick.fieldses.org>
In-Reply-To: <20210120230102.GC167212@pick.fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7cd3d40-ae14-4205-766a-08d8bdaf8f9f
x-ms-traffictypediagnostic: BYAPR10MB3718:
x-microsoft-antispam-prvs: <BYAPR10MB37183FDBD6A06312E2056C3293A19@BYAPR10MB3718.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2yUrW+0n9BseeUmoHCsY9alFtZ+SVcEzExncShDYES/kLqbs9aai3R8YUCnSGx2SXsPr+CJorwNVDFTKnTLPWUrtoEHEb49ZkJ33ydYYKMaZOPicYzSlMyOL+MNYL76y3DCQLqLtXO0ilZeXF6N2z0METBeKxVKAWdZyNNMLCjncK/1b1acRS4T5/kHRYFrAnF6CakWqUgeWsuL8Rz20hVYDp+Av7W5/xM/LpxyXMPKSar9aCVQpxoDcNOkwY2912HkBsBuwvMC5STQZe+jg8rWvj5TtdMit1toM3UE9otEU74DOe37FtYImCifWW4u3o9cE4Nnx9c1ikvTMVPxNTAJWUUyhFZzd2d23E2lI2Xm7cH7v1bId4svO25QXxlfAI9z/COBq2rHRSTzIy0F4QcK5XrtUNfRFZxc4nD/tTt8SfJN7xaI5YRm5Tly8SBX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(91956017)(66946007)(76116006)(6512007)(8936002)(186003)(66446008)(2616005)(44832011)(4326008)(64756008)(66556008)(66476007)(6916009)(33656002)(5660300002)(83380400001)(316002)(6506007)(53546011)(2906002)(71200400001)(86362001)(508600001)(26005)(36756003)(8676002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?akJMcytrTmFoVFlBMWhtV29ZUVloZHF6SHRNcTB6N2kvRGNPVk94R1hSTmRv?=
 =?utf-8?B?MUhhd3BBZkhyQU9DZ1FVZVN4VUdmcmVWaTFiSDRQcTFKNjhWOGRwemxNbnZ2?=
 =?utf-8?B?UEtHWEd0aVh0ODRrTFVHeU5lYVRySHE3eHlwc2lmYm5zSDlSK2syMllXaUJX?=
 =?utf-8?B?OE9KM20rekVxbllEc2FTcWgzVmxEdkxxREd4UXA3VUJ0S0VXK3d2NURKb0x1?=
 =?utf-8?B?SloyUGtWQk5xeXhTbVVpTiszQXJyKzVkOGxXa0Ixc2JlaDBNTjYzQzJDUjE2?=
 =?utf-8?B?NzB4SkhRbktxMUt1RFhKcmJVd0J6UTFtTU1vRTZORG5KekxJN1k0SE1WZVE0?=
 =?utf-8?B?NHF2MWUwVDBXNkpnWWtjRFVzeTJuQjM3ZVo2bUxweHVyNytQZkZVZWJsUlNm?=
 =?utf-8?B?T2ZEMUVJQWtaeXkydVU1bUhrUjV3NzNuQ0F5N0w4YzBBZHJQVlpjVFQxeUpQ?=
 =?utf-8?B?SmpQT2UwUmdqVEQ3UzVrQVJkU2tVOW1wOTIveDVVMnd2dU95MkhtUktoc2l4?=
 =?utf-8?B?czY1L2NpQy9qMkhGSi9hZkI4c0ZReHhudG1Nd0pEK280UFNZa0JsN1hrazJJ?=
 =?utf-8?B?VHNQQWFSeDBJNVZGbDhpMGUwcWlwTFpaeFN2aGwxaVhEZlg4VHpSendKMXE0?=
 =?utf-8?B?QmhveXcyd01vc1dkMHc4dUM5WUVvak13SlZUR2dVL0dSRjQ0NE1FQUJ6cnlw?=
 =?utf-8?B?THAvaTNmMTlnY1JBNkxRVDNlTC9sU3N2T1ZFY2YyRHB1UnB3c0VjRU1zcVFp?=
 =?utf-8?B?Yi94c1VUMXJpTmJoQTNibGxHSG1pYTJFTW5UOThGL0k5TTQ1dnBDb0o5dzkv?=
 =?utf-8?B?cXJrUlBzcDlVWjJxZlFXb3pldDc1MU1HZFJPenJKMlFwdVRVR0hKMWJaYjVX?=
 =?utf-8?B?dldDQ2ZKWmtsZkNjUWwwRE4yWUFDbGJHNENPYlNSN2NyT20zZncxTFpEOGY1?=
 =?utf-8?B?TFpqb0pqVDdxS1RDeDRsZ1dWT3l0YlQ1ajZwdWplNDhvQzVudzE5NCtjcVRm?=
 =?utf-8?B?YkhXZ2VLQVh4aXZ0cmZsWGdNNXFJY0hQaThueE9YKzJRQko5RU94aHBFYTFY?=
 =?utf-8?B?WXdZakd3ajI2VFBvWTBLakRpeXhpVkQ0YTA0TmNKc2NLT1hFa2F0ekhHczJv?=
 =?utf-8?B?dlY2SDA5QmJPc1NXeFMzbGdnWU1TZ3VvSnRad29pZVVTeG1FVTZHeDZMdklH?=
 =?utf-8?B?dkxPbVlUTXoxSnBiNEd5VDVaV29nT3BqTjFKK1ovTVdtUTJwUzRMMDNVb2hE?=
 =?utf-8?B?S1V3UkZ5QXQzMyswclZPNHBBenVnY3VydGswREY3QUE4UXVYZ1dOUUk5N1NG?=
 =?utf-8?Q?Sx/i5fHxuMuvIMqG85tlwNe9f2M1ye1KN2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cd3d40-ae14-4205-766a-08d8bdaf8f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 01:54:59.8488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkrIZGJWGlDBxykjd6ysZGltzQoZT9VwlfmYMj+H95yURJJyWgFZ8X0c7iRh2+4Dj2ZbTRxjnzDsKDpsuJt41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210005
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSmFuIDIwLCAyMDIxLCBhdCA2OjAxIFBNLCBKLiBCcnVjZSBGaWVsZHMgPGJmaWVs
ZHNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBXZWQsIEphbiAyMCwgMjAyMSBhdCAw
OTowMjoyNVBNICswMDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IA0KPj4gDQo+Pj4+IE9uIEph
biAxOSwgMjAyMSwgYXQgNTozNSBQTSwgSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJlZGhhdC5j
b20+IHdyb3RlOg0KPj4+IA0KPj4+IEZyb206ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRzQHJl
ZGhhdC5jb20+DQo+Pj4gDQo+Pj4gSSB0aGluayBzZXRfY2xpZW50IGlzIGEgYmV0dGVyIG5hbWUs
IGFuZCB0aGUgbG9va3VwIGl0c2VsZiBJIHdhbnQgdG8NCj4+PiB1c2Ugc29tZXdoZXJlIGVsc2Uu
DQo+PiANCj4+IFNob3VsZCB0aGlzIGJlIHR3byBwYXRjaGVzPw0KPj4gLSBSZW5hbWUgbG9va3Vw
X2NsaWVudGlkKCkgdG8gc2V0X2NsaWVudCgpDQo+PiAtIFJlZmFjdG9yIHRoZSBsb29rdXBfY2xp
ZW50aWQoKSBoZWxwZXINCj4gDQo+IFN1cmUuDQo+IA0KPj4gbmZzNHN0YXRlLmMgc3RvcHMgY29t
cGlsaW5nIHdpdGggdGhpcyBwYXRjaC4gU2VlIGJlbG93Lg0KPiANCj4gT29wcywgdGhhbmtzLg0K
PiANCj4gSWYgdGhlc2UgbG9vayBPSyBvdGhlcndpc2UsIEkgY2FuIHJlc2VuZC4NCg0KWWVzLCBw
bGVhc2UgcmVzZW5kLg0KDQoNCj4gDQo+IC0tYi4NCj4gDQo+PiANCj4+IA0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEouIEJydWNlIEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+
IGZzL25mc2QvbmZzNHN0YXRlLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjYg
ZGVsZXRpb25zKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHN0YXRlLmMg
Yi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4gaW5kZXggYmE5NTViYmYyMWRmLi5kNzEyOGUxNmM4
NmUgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+ICsrKyBiL2ZzL25m
c2QvbmZzNHN0YXRlLmMNCj4+PiBAQCAtNDYzMyw0MCArNDYzMyw0MCBAQCBzdGF0aWMgX19iZTMy
IG5mc2Q0X2NoZWNrX3NlcWlkKHN0cnVjdCBuZnNkNF9jb21wb3VuZF9zdGF0ZSAqY3N0YXRlLCBz
dHJ1Y3QgbmZzNA0KPj4+ICAgIHJldHVybiBuZnNlcnJfYmFkX3NlcWlkOw0KPj4+IH0NCj4+PiAN
Cj4+PiAtc3RhdGljIF9fYmUzMiBsb29rdXBfY2xpZW50aWQoY2xpZW50aWRfdCAqY2xpZCwNCj4+
PiArc3RhdGljIHN0cnVjdCBuZnM0X2NsaWVudCAqbG9va3VwX2NsaWVudGlkKGNsaWVudGlkX3Qg
KmNsaWQsIGJvb2wgc2Vzc2lvbnMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBuZnNkX25ldCAqbm4pDQo+Pj4gK3sNCj4+PiArICAgIHN0cnVjdCBuZnM0X2NsaWVudCAqZm91
bmQ7DQo+Pj4gKw0KPj4+ICsgICAgc3Bpbl9sb2NrKCZubi0+Y2xpZW50X2xvY2spOw0KPj4+ICsg
ICAgZm91bmQgPSBmaW5kX2NvbmZpcm1lZF9jbGllbnQoY2xpZCwgc2Vzc2lvbnMsIG5uKTsNCj4+
PiArICAgIGlmIChmb3VuZCkNCj4+PiArICAgICAgICBhdG9taWNfaW5jKCZmb3VuZC0+Y2xfcnBj
X3VzZXJzKTsNCj4+PiArICAgIHNwaW5fdW5sb2NrKCZubi0+Y2xpZW50X2xvY2spOw0KPj4+ICsg
ICAgcmV0dXJuIGZvdW5kOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgX19iZTMyIHNldF9j
bGllbnQoY2xpZW50aWRfdCAqY2xpZCwNCj4+PiAgICAgICAgc3RydWN0IG5mc2Q0X2NvbXBvdW5k
X3N0YXRlICpjc3RhdGUsDQo+Pj4gICAgICAgIHN0cnVjdCBuZnNkX25ldCAqbm4sDQo+Pj4gICAg
ICAgIGJvb2wgc2Vzc2lvbnMpDQo+Pj4gew0KPj4+IC0gICAgc3RydWN0IG5mczRfY2xpZW50ICpm
b3VuZDsNCj4+PiAtDQo+Pj4gICAgaWYgKGNzdGF0ZS0+Y2xwKSB7DQo+Pj4gLSAgICAgICAgZm91
bmQgPSBjc3RhdGUtPmNscDsNCj4+PiAtICAgICAgICBpZiAoIXNhbWVfY2xpZCgmZm91bmQtPmNs
X2NsaWVudGlkLCBjbGlkKSkNCj4+PiArICAgICAgICBpZiAoIXNhbWVfY2xpZCgmY3N0YXRlLT5j
bHAtPmNsX2NsaWVudGlkLCBjbGlkKSkNCj4+PiAgICAgICAgICAgIHJldHVybiBuZnNlcnJfc3Rh
bGVfY2xpZW50aWQ7DQo+Pj4gICAgICAgIHJldHVybiBuZnNfb2s7DQo+Pj4gICAgfQ0KPj4+IC0N
Cj4+PiAgICBpZiAoU1RBTEVfQ0xJRU5USUQoY2xpZCwgbm4pKQ0KPj4+ICAgICAgICByZXR1cm4g
bmZzZXJyX3N0YWxlX2NsaWVudGlkOw0KPj4+IC0NCj4+PiAgICAvKg0KPj4+ICAgICAqIEZvciB2
NC4xKyB3ZSBnZXQgdGhlIGNsaWVudCBpbiB0aGUgU0VRVUVOQ0Ugb3AuIElmIHdlIGRvbid0IGhh
dmUgb25lDQo+Pj4gICAgICogY2FjaGVkIGFscmVhZHkgdGhlbiB3ZSBrbm93IHRoaXMgaXMgZm9y
IGlzIGZvciB2NC4wIGFuZCAic2Vzc2lvbnMiDQo+Pj4gICAgICogd2lsbCBiZSBmYWxzZS4NCj4+
PiAgICAgKi8NCj4+PiAgICBXQVJOX09OX09OQ0UoY3N0YXRlLT5zZXNzaW9uKTsNCj4+PiAtICAg
IHNwaW5fbG9jaygmbm4tPmNsaWVudF9sb2NrKTsNCj4+PiAtICAgIGZvdW5kID0gZmluZF9jb25m
aXJtZWRfY2xpZW50KGNsaWQsIHNlc3Npb25zLCBubik7DQo+Pj4gLSAgICBpZiAoIWZvdW5kKSB7
DQo+Pj4gLSAgICAgICAgc3Bpbl91bmxvY2soJm5uLT5jbGllbnRfbG9jayk7DQo+Pj4gKyAgICBj
c3RhdGUtPmNscCA9IGxvb2t1cF9jbGllbnRpZChjbGlkLCBzZXNzaW9ucywgbm4pOw0KPj4+ICsg
ICAgaWYgKCFjc3RhdGUtPmNscCkNCj4+PiAgICAgICAgcmV0dXJuIG5mc2Vycl9leHBpcmVkOw0K
Pj4+IC0gICAgfQ0KPj4+IC0gICAgYXRvbWljX2luYygmZm91bmQtPmNsX3JwY191c2Vycyk7DQo+
Pj4gLSAgICBzcGluX3VubG9jaygmbm4tPmNsaWVudF9sb2NrKTsNCj4+PiAtDQo+Pj4gLSAgICAv
KiBDYWNoZSB0aGUgbmZzNF9jbGllbnQgaW4gY3N0YXRlISAqLw0KPj4+IC0gICAgY3N0YXRlLT5j
bHAgPSBmb3VuZDsNCj4+PiAgICByZXR1cm4gbmZzX29rOw0KPj4+IH0NCj4+PiANCj4+PiBAQCAt
NDY4OCw3ICs0Njg4LDcgQEAgbmZzZDRfcHJvY2Vzc19vcGVuMShzdHJ1Y3QgbmZzZDRfY29tcG91
bmRfc3RhdGUgKmNzdGF0ZSwNCj4+PiAgICBpZiAob3Blbi0+b3BfZmlsZSA9PSBOVUxMKQ0KPj4+
ICAgICAgICByZXR1cm4gbmZzZXJyX2p1a2Vib3g7DQo+Pj4gDQo+Pj4gLSAgICBzdGF0dXMgPSBs
b29rdXBfY2xpZW50aWQoY2xpZW50aWQsIGNzdGF0ZSwgbm4sIGZhbHNlKTsNCj4+PiArICAgIHN0
YXR1cyA9IHNldF9jbGllbnQoY2xpZW50aWQsIGNzdGF0ZSwgbm4sIGZhbHNlKTsNCj4+PiAgICBp
ZiAoc3RhdHVzKQ0KPj4+ICAgICAgICByZXR1cm4gc3RhdHVzOw0KPj4+ICAgIGNscCA9IGNzdGF0
ZS0+Y2xwOw0KPj4+IEBAIC01Mjk4LDcgKzUyOTgsNyBAQCBuZnNkNF9yZW5ldyhzdHJ1Y3Qgc3Zj
X3Jxc3QgKnJxc3RwLCBzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4+PiAg
ICBzdHJ1Y3QgbmZzZF9uZXQgKm5uID0gbmV0X2dlbmVyaWMoU1ZDX05FVChycXN0cCksIG5mc2Rf
bmV0X2lkKTsNCj4+PiANCj4+PiAgICB0cmFjZV9uZnNkX2NsaWRfcmVuZXcoY2xpZCk7DQo+Pj4g
LSAgICBzdGF0dXMgPSBsb29rdXBfY2xpZW50aWQoY2xpZCwgY3N0YXRlLCBubiwgZmFsc2UpOw0K
Pj4+ICsgICAgc3RhdHVzID0gc2V0X2NsaWVudChjbGlkLCBjc3RhdGUsIG5uLCBmYWxzZSk7DQo+
Pj4gICAgaWYgKHN0YXR1cykNCj4+PiAgICAgICAgcmV0dXJuIHN0YXR1czsNCj4+PiAgICBjbHAg
PSBjc3RhdGUtPmNscDsNCj4+PiBAQCAtNTY4MSw4ICs1NjgxLDcgQEAgbmZzZDRfbG9va3VwX3N0
YXRlaWQoc3RydWN0IG5mc2Q0X2NvbXBvdW5kX3N0YXRlICpjc3RhdGUsDQo+Pj4gICAgaWYgKFpF
Uk9fU1RBVEVJRChzdGF0ZWlkKSB8fCBPTkVfU1RBVEVJRChzdGF0ZWlkKSB8fA0KPj4+ICAgICAg
ICBDTE9TRV9TVEFURUlEKHN0YXRlaWQpKQ0KPj4+ICAgICAgICByZXR1cm4gbmZzZXJyX2JhZF9z
dGF0ZWlkOw0KPj4+IC0gICAgc3RhdHVzID0gbG9va3VwX2NsaWVudGlkKCZzdGF0ZWlkLT5zaV9v
cGFxdWUuc29fY2xpZCwgY3N0YXRlLCBubiwNCj4+PiAtICAgICAgICAgICAgICAgICBmYWxzZSk7
DQo+Pj4gKyAgICBzdGF0dXMgPSBzZXRfY2xpZW50KCZzdGF0ZWlkLT5zaV9vcGFxdWUuc29fY2xp
ZCwgY3N0YXRlLCBubiwgZmFsc2UpOw0KPj4+ICAgIGlmIChzdGF0dXMgPT0gbmZzZXJyX3N0YWxl
X2NsaWVudGlkKSB7DQo+Pj4gICAgICAgIGlmIChjc3RhdGUtPnNlc3Npb24pDQo+Pj4gICAgICAg
ICAgICByZXR1cm4gbmZzZXJyX2JhZF9zdGF0ZWlkOw0KPj4+IEBAIC01ODIxLDcgKzU4MjAsNyBA
QCBzdGF0aWMgX19iZTMyIGZpbmRfY3BudGZfc3RhdGUoc3RydWN0IG5mc2RfbmV0ICpubiwgc3Rh
dGVpZF90ICpzdCwNCj4+PiANCj4+PiAgICBjcHMtPmNwbnRmX3RpbWUgPSBrdGltZV9nZXRfYm9v
dHRpbWVfc2Vjb25kcygpOw0KPj4+ICAgIG1lbXNldCgmY3N0YXRlLCAwLCBzaXplb2YoY3N0YXRl
KSk7DQo+Pj4gLSAgICBzdGF0dXMgPSBsb29rdXBfY2xpZW50aWQoJmNwcy0+Y3BfcF9jbGlkLCAm
Y3N0YXRlLCBubiwgdHJ1ZSk7DQo+Pj4gKyAgICBzdGF0dXMgPSBzZXRfY2xpZW50aWQoJmNwcy0+
Y3BfcF9jbGlkLCAmY3N0YXRlLCBubiwgdHJ1ZSk7DQo+PiANCj4+IFRoaXMgZG9lc24ndCBjb21w
aWxlLiBJIHRoaW5rIHlvdSBtZWFudCBzZXRfY2xpZW50KCkgaGVyZS4NCj4+IA0KPj4gDQo+Pj4g
ICAgaWYgKHN0YXR1cykNCj4+PiAgICAgICAgZ290byBvdXQ7DQo+Pj4gICAgc3RhdHVzID0gbmZz
ZDRfbG9va3VwX3N0YXRlaWQoJmNzdGF0ZSwgJmNwcy0+Y3BfcF9zdGF0ZWlkLA0KPj4+IEBAIC02
OTAwLDggKzY4OTksNyBAQCBuZnNkNF9sb2NrdChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1
Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4+PiAgICAgICAgIHJldHVybiBuZnNl
cnJfaW52YWw7DQo+Pj4gDQo+Pj4gICAgaWYgKCFuZnNkNF9oYXNfc2Vzc2lvbihjc3RhdGUpKSB7
DQo+Pj4gLSAgICAgICAgc3RhdHVzID0gbG9va3VwX2NsaWVudGlkKCZsb2NrdC0+bHRfY2xpZW50
aWQsIGNzdGF0ZSwgbm4sDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgIGZhbHNlKTsNCj4+PiAr
ICAgICAgICBzdGF0dXMgPSBzZXRfY2xpZW50KCZsb2NrdC0+bHRfY2xpZW50aWQsIGNzdGF0ZSwg
bm4sIGZhbHNlKTsNCj4+PiAgICAgICAgaWYgKHN0YXR1cykNCj4+PiAgICAgICAgICAgIGdvdG8g
b3V0Ow0KPj4+ICAgIH0NCj4+PiBAQCAtNzA4NSw3ICs3MDgzLDcgQEAgbmZzZDRfcmVsZWFzZV9s
b2Nrb3duZXIoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4+PiAgICBkcHJpbnRrKCJuZnNkNF9y
ZWxlYXNlX2xvY2tvd25lciBjbGllbnRpZDogKCUwOHgvJTA4eCk6XG4iLA0KPj4+ICAgICAgICBj
bGlkLT5jbF9ib290LCBjbGlkLT5jbF9pZCk7DQo+Pj4gDQo+Pj4gLSAgICBzdGF0dXMgPSBsb29r
dXBfY2xpZW50aWQoY2xpZCwgY3N0YXRlLCBubiwgZmFsc2UpOw0KPj4+ICsgICAgc3RhdHVzID0g
c2V0X2NsaWVudChjbGlkLCBjc3RhdGUsIG5uLCBmYWxzZSk7DQo+Pj4gICAgaWYgKHN0YXR1cykN
Cj4+PiAgICAgICAgcmV0dXJuIHN0YXR1czsNCj4+PiANCj4+PiBAQCAtNzIzMiw3ICs3MjMwLDcg
QEAgbmZzNF9jaGVja19vcGVuX3JlY2xhaW0oY2xpZW50aWRfdCAqY2xpZCwNCj4+PiAgICBfX2Jl
MzIgc3RhdHVzOw0KPj4+IA0KPj4+ICAgIC8qIGZpbmQgY2xpZW50aWQgaW4gY29uZl9pZF9oYXNo
dGJsICovDQo+Pj4gLSAgICBzdGF0dXMgPSBsb29rdXBfY2xpZW50aWQoY2xpZCwgY3N0YXRlLCBu
biwgZmFsc2UpOw0KPj4+ICsgICAgc3RhdHVzID0gc2V0X2NsaWVudGlkKGNsaWQsIGNzdGF0ZSwg
bm4sIGZhbHNlKTsNCj4+IA0KPj4gRGl0dG8uDQo+PiANCj4+IA0KPj4+ICAgIGlmIChzdGF0dXMp
DQo+Pj4gICAgICAgIHJldHVybiBuZnNlcnJfcmVjbGFpbV9iYWQ7DQo+Pj4gDQo+Pj4gLS0gDQo+
Pj4gMi4yOS4yDQo+Pj4gDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCj4+
IA0KPiANCg==
