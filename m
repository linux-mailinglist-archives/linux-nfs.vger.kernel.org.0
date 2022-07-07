Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244B356990F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiGGERY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 00:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiGGERX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 00:17:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E52CE1A
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 21:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nejy98N6skEqzxJlCcin0GFvAP+Bu3OEz48MJXe/Ic6UieNVGEZrkcAzkoEqQD4zM07hAkTscJulKFiDFbvV5L6BUpDetjKy7gsm00lOjq3+FOWqwQx09+DXYhSXahy1tQGDEaOgk6zTmkPqu0jAVXJQwds6ItWqfH1gsViq4ZSM9b5KPVT0Tf8SAgTSd20RTLwlPl9TgiTcwLlM4cKR0jJkAKGNn8Pk/W+gCxEvjqlvtK1azs/OaPZ8Agld9P+NftMkhY8g+pYBbjZXaMhkpzgI6KrCeiD1soEZs5ELqcBqKrvgOfzxnJ7pfFjYWFqot2sBNzSBGoPF/vtJIyYq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVBYJLyBRQQmNDEz3mXb+4191xvGz+2mb3hGFj+UONw=;
 b=PU2vP3gSzPwAgnaS9GWF178G/5/ew/c+tTApQJaceMOv1UfuBwoRGcIYkJgfuy4mmsv7dfqYGcVnXO7xInOZue2mXkyYLRBekzyj/kQjgj3r917+VufpqbQPgpn+SFvxzaE8rckbtUhxoV/j8k+1AFOpqCvDSXVu1Ix+sY4vx++mAsDR6oAqkVaq943Y8/xsHnS5s/z64Tfq6ikzJUJykEiiCBTOjAb1A3mDmvRklDOKJNLBvfhsTPhVErvvoB1TeFHLS8LV3L9X8a1lEyoTZ6rYKlTOhPFRWrmkCndH5u0VAtKtg7ZlSaHvOrpw8L3bTLA/lQz/dPH0w1YEPqmfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVBYJLyBRQQmNDEz3mXb+4191xvGz+2mb3hGFj+UONw=;
 b=Snn4w8gxB/XjYyCHc4fDzMuWCpbCEHEyzGkPxt421a40v12QEqz/lQVtKhDvLW9095ugdEO6sgUOYJTkKdlvg1OBLfXZyK8wL8YUMn02ZIb7orCduvkXW25diyZwaCxGUjmA1RQ++QR45xy+gL4jNsbHbJfAD7xVcpVgQZKsTA8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3476.namprd13.prod.outlook.com (2603:10b6:a03:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 04:17:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%9]) with mapi id 15.20.5417.013; Thu, 7 Jul 2022
 04:17:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: Problem with providing implementation id in NFSv4.1
Thread-Topic: Problem with providing implementation id in NFSv4.1
Thread-Index: AQHYkZ7Rcivz8HkpnEWpmWASAarBlq1yTaWA
Date:   Thu, 7 Jul 2022 04:17:18 +0000
Message-ID: <9058936794e86fc3913046682ad35e38d89e053f.camel@hammerspace.com>
References: <165715642317.17141.14223480428236658557@noble.neil.brown.name>
In-Reply-To: <165715642317.17141.14223480428236658557@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d95def4-896d-4967-05ee-08da5fcf950a
x-ms-traffictypediagnostic: BY5PR13MB3476:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1FaJEz7JHL47rq3//NcDdllmlh/cNdfWGwg8j8GDchTNYDpBlOVXSuaw+8dgaL4kjY6+tKt2QJ3yIfA8uRzVMqcJ7Mv3O68NyDqCnLQpaZkyPOVys6t8muzmM1Uf41qKpIDeKVi5ZALNXQ2559s/7pUPtC6CvpXdxgh7Khd1598Ht4e7vPAVGx4c533O9W3lYOfZnCOlG3xpeeMQtqeAcFJ5H2AcV+B8BWTruLsPLpX3HyfwwyhlXo7zu3JIGBen9glXdWNnlOdFtDPhClv0zV2rcIBDeMIj5KqAEbPsc+NoekCzBDqir3Ga+vk2pwh+ooutLjxxNe0dZTuoHIl37yXMjdaSoVx4Bmij6EECOhOnDi8Voq55uAAZquc3EN250jqdd65Nx0Mt1czHAHHlKFHY5+ZCBEllIUGAR15/w3Xrk2u/bhaA/Aoxb0Q/g4cSjiuV7hKqZEAsvMtz+drwaIq2vPovYKeGojUKucHLpvFTLWxNZCadZpNPNOWir5LGgzS+THJtbCCB+8H1D6hp00DnZe4IwPHWOdk7gecnhfJC/k3pJ7MtfUMS2z1qG0AFvC72bh+lxX0k2rgzwixMBAtxmfpDYLdBTBRuZjpferfUSdcSic2pcb3uKZkixOZmyl/Q9ibHJRhxIEtJ/uNxCGWskuhJ87vsrDgIA1q/XiLIARxlLrhPZv2zOxokEfNW3I2bRJBURfNe+4ILsgJOCROwREbz/bqnKJj7NmdOiNpfyMxDtHpoYTzyC+IBuunvAM85FddT/3hcJ78yTjNCIiTdVMQOHEUdT0a8ER3ZDp2Dv3QS5BAJ75I1KKpsiJq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(346002)(136003)(366004)(376002)(396003)(6506007)(26005)(8936002)(76116006)(110136005)(186003)(6512007)(6486002)(64756008)(86362001)(83380400001)(478600001)(316002)(2616005)(38100700002)(2906002)(41300700001)(8676002)(66476007)(5660300002)(71200400001)(66446008)(66556008)(66946007)(36756003)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXhqUWR2c0xJRzBaYU5QK1hrZ25xUEl6anE4QXZwbFh4WVU5RUVqSFlJc09M?=
 =?utf-8?B?czVtdUFtcjU5QWtsVmdIYmFvbVgrc1JMcWlwa1BoMW1DV29HOWthTmJJMTNK?=
 =?utf-8?B?dVhNQjBvU21sU0tiRmhwRnRGcXZXbCtNQ0hMUkU3RTVtb0tQemdEaXVweUx4?=
 =?utf-8?B?Y25YditJOWxZSDMzMjYybDBMUng1S09TNWFwNnlQUGl1STcvak01WEp5d2Ji?=
 =?utf-8?B?RnZqa25tM3R3L1Jla1ZEVlNYRld6V3VWMWNzTHF4K3M0ZUNiVWI1Wmx1NzBS?=
 =?utf-8?B?OVhIaWhGRWhIbS9ReEdEVjNiMFNkZ3ovOGZLSjFCMG9RZklVRVNnN0tmYjI3?=
 =?utf-8?B?aW4vaWRSTkNic2NvcUF0MGxjeWc4dkx3akN4dTlmeFRqN0xTNkRIWXFmWk1z?=
 =?utf-8?B?bklZUVVQeUFaeEJOaEtoV0xWVzM0UU5KT09wZzQwaUhhQkEyRlBEOGJQcHFU?=
 =?utf-8?B?RjIySEExaFpKZEllZFhyZlV4cUkzTkorQnpCbnZoRjc0OUlLK1l0cWdRSXdk?=
 =?utf-8?B?L0pYcDc4U1NHY0lCR3NweE0xVEZDbVh2TjY2dk5UZG1xNE5nY3prQ3JWR1dN?=
 =?utf-8?B?aW9wSE9WM0xlZmxFWTNkVG1CMXJpVUJ0cHJwbkhZajU3U1dtME45YXVPblhw?=
 =?utf-8?B?eTVDcVFDbjRnL1Q5bGlUTTdIYUE0NlNVS0RHbE9CSlNHT0d2NU1xd2N2bVdV?=
 =?utf-8?B?cWwybVNEVnBlUG9oQUlneitlMks0aFplSFBCSk5jRC84bGc1UktwZk5OUEow?=
 =?utf-8?B?QlpsRkFzdWluOVQ5TXlqUmtTODVHUGgzSzU3dHhYQzJkRWNVQitIOGRQdlV2?=
 =?utf-8?B?Qy95djl5ZXFWZkozaVVFNTM2MVZTRHlBd0QrQTg4NEo2SkZub1FSV0ZRQjFU?=
 =?utf-8?B?Y2FjMmg4OXdWNzYxZ0ptMUVnR1huYmM1UFdjVFJqUzRtUE5Mbk81dnhwYUhC?=
 =?utf-8?B?aEIya3J4SjZwQlVwM2RjWWxVNjZYVkllZEQwTDJhU2FXdkNjazJmQklOczBr?=
 =?utf-8?B?QmtkaFFyNlpYTGJkOFZZMlFJcWV2WUNybHFoNGVGbUowMWFhcENFbk9HUk94?=
 =?utf-8?B?U3phWkR1UTJoWjVJOFl5SXVnYldmeU9ScHF4MWZpMHJxYW9xdnByM3JFZ3FR?=
 =?utf-8?B?N3pXdzF6RXFhVCtmblhOUWc4QUZSQkRBUUdBSXdmOHlKN3NKUTNXWFRPWXlv?=
 =?utf-8?B?SjBzSHZMV0NzRnFPVy9ac0pjL1ZxRVgxbC8ydisyWXJ4MWxGeXhQOHJSYUxB?=
 =?utf-8?B?UnFkd1NidFAya2xzdHNYREs5NjVoODFtMnhIVnN6NXZscmZEVEZDaEhtRzhT?=
 =?utf-8?B?dXlKZG5yVVVnSFpxN3F2eldSMEY1QW5BWjBVamI1QlhGUUlEQ2M0THMxOUZ1?=
 =?utf-8?B?bis1Vnp6NSt0eGdQdVhGckNlc1p5VGw4cFFmUERFTzRyNFpJQklsd1FXdWF3?=
 =?utf-8?B?MW9lZFBmN0Zxa2xZa0dCamtxVnk5UFkrb0dlWnNmaVVha29Qb2IxWDh5aE85?=
 =?utf-8?B?QmhqUGhMa2dJb3U2My9jUmtkb3V0K3lyRVIyc1NZRFAzbEEwTEFSdXZlSWN5?=
 =?utf-8?B?Z0hFUFNhL1V4SHZ3amdaay9Hd1QzZWg4MGs3VlhEY3JDTzlDOW02N3RveGh3?=
 =?utf-8?B?a0VSL0xEWGp5Tk9xWFRRdlpPMWFjT1hoTkw1MzF3b2thQ1V1cEFiOEtFaklp?=
 =?utf-8?B?SFpBRUtnRlBYLy8vV1RjMGVMdUg3cmxOOUdqd0pORlJ3ZFJOb25qY1NyV2FS?=
 =?utf-8?B?cm53eDRVRXJkZ2RUMGtYVGk5VFU1NEFQOXdFSWRLNXp4Rkh5U1pmcVBpUDI2?=
 =?utf-8?B?Q3RlYm1GdGhiRmVES2wzT2hML2hjS1JqUmhGSUFCTHREK2FBb2lWL0RBMUkx?=
 =?utf-8?B?dDRqa1IxdTlTV1lTNGdpV0gwRWwwQk1MWG81K0VyUEIwYXM1U1BsV2xVK0ox?=
 =?utf-8?B?VzNNNWFBVVU2NERoRWtFUjVORzdWdmpxMlpRaTNNc09ZRERNcnZmTXB2RVFv?=
 =?utf-8?B?U1Byb3pGVmcyd2ZxYllQdEFQQWkxUVdhZFV6MzBQNm5nK0VCLzkvbTM0VEFV?=
 =?utf-8?B?QXJrellBaytPd3FWMkhORHlkc09MU0JaV3Z3YVoybXozTjVxUkdUdW9KZ1VK?=
 =?utf-8?B?eEROZytMNmN0Y3lscnRaMjZiQXNOQ0hkYU9YdVRHNzNIN2dBWkN1ODBsczkx?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBAC6CB8E158274B8DC9EF685A4108D6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95def4-896d-4967-05ee-08da5fcf950a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 04:17:18.9208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RENtpwquSFmJwh2X3vskwxrlCQP2Ho0l0xpvi2xGA7evBQhu4UeNbcWvPksuO3QIdtogd6OJVRGs73EOB5xWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTA3IGF0IDExOjEzICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBJbiBORlN2NC4xIHdoZW4gd2UgRVhDSEFOR0VfSUQgdG8gdGFsayB0byBhIG5ldyBzZXJ2ZXIg
LSBwb3NzaWJseSBhDQo+IFBORlMNCj4gRGF0YSBTZXJ2ZXIgdGhhdCB3ZSBoYXZlbid0IHRhbGtl
ZCB0byBiZWZvcmUgLSB3ZSBieSBkZWZhdWx0IHNlbmQgYW4NCj4gaW1wbGVtZW50YXRpb24gaWQu
wqAgVGhpcyBpcyBjcmVhdGVkIGZyb20gc2V2ZXJhbCBmaWVsZHMgb2J0YWluZWQgZnJvbQ0KPiB1
dHNuYW1lKCkuDQo+IHV0c25hbWUoKSBkZXBlbmRzIG9uIGN1cnJlbnQtPm5zcHJveHksIGFuZCB3
aWxsIGNyYXNoIGlmIHRoYXQgaXMNCj4gTlVMTC4NCj4gDQo+IFdoZW4gYSBwcm9jZXNzIGV4aXRz
IGl0IGNhbGxzLCBhbW9uZyBvdGhlciB0aGluZ3MsDQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgZXhp
dF90YXNrX25hbWVzcGFjZXModHNrKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGV4aXRfdGFza193b3Jr
KHRzayk7DQo+IA0KPiBleGl0X3Rhc2tfbmFtZXNwYWNlcygpIHdpbGwgc2V0IC0+bnNwcm94eSB0
byBOVUxMDQo+IGV4aXRfdGFza193b3JrKCkgd2lsbCBydW4gZGVsYXllZCB3b3JrIGl0ZW1zLCBp
bmNsdWRpbmcgZnB1dCgpIG9uIGFsbA0KPiBmaWxlcyB0aGF0IHdlcmUgc3RpbGwgb3BlbiB3aGVu
IHRoZSBwcm9jZXNzIGV4aXRlZC7CoCBUaGlzIHdpbGwgY2F1c2UNCj4gYW55DQo+IHBlbmRpbmcg
d3JpdGVzIHRvIGJlIGZsdXNoZWQgZm9yIE5GUy4NCj4gDQo+IFNvIGlmIGEgcHJvY2VzcyB3cml0
ZXMgdG8gYSBmaWxlIG9uIGEgUE5GUyBzZXJ2ZXIsIGV4aXRzLCBhbmQgdGhlIE1EUw0KPiB0ZWxs
cyB0aGUgY2xpZW50IHRvIHNlbmQgdGhlIGRhdGEgdG8gYSBEUyB3aGljaCBpdCBoYXNuJ3QgZXN0
YWJsaXNoZWQNCj4gYQ0KPiBjb25uZWN0aW9uIHdpdGggYmVmb3JlLCB0aGVuIGl0IHdpbGwgY3Jh
c2ggaW4gZW5jb2RlX2V4Y2hhbmdlX2lkKCkuDQo+IA0KPiBUaGF0IG9yZGVyIG9mIGNhbGxzIGlu
IGRvX2V4aXQoKSBpcyBkZWxpYmVyYXRlIHNvIHdlIGNhbm5vdCBzd2FwIHRoZW0NCj4gLSBzZWUN
Cj4gQ29tbWl0OiA4YWFjNjI3MDZhZGEgKCJtb3ZlIGV4aXRfdGFza19uYW1lc3BhY2VzKCkgb3V0
c2lkZSBvZg0KPiBleGl0X25vdGlmeSgpIikNCj4gDQo+IFRoZSBvcHRpb25zIHRoYXQgSSBjYW4g
c2VlIGFyZToNCj4gMS8gZ2VuZXJhdGUgdGhlIGltcGxlbWVudGF0aW9uLWlkIHN0cmluZyBhdCBt
b3VudCB0aW1lIGFuZCBrZWVwIGl0DQo+IMKgwqAgYXJvdW5kIG11Y2ggbGlrZSB3ZSBkbyBmb3Ig
Y2xfb3duZXJfaWQNCj4gMi8gQ2hlY2sgY3VycmVudC0+bnNwcm94eSBpbiBlbmNvZGVfZXhjaGFu
Z2VfaWQoKSBhbmQgc2tpcCB0aGUNCj4gwqDCoCBpbXBsZW1lbnRhdGlvbiBpZCBpZiAtPm5zcHJv
eHkgaXMgbm90IGF2YWlsYWJsZS4NCj4gwqDCoCBOb3RlIHRoYXQgdGhlcmUgaXMgbm8gcmlzayBm
b3IgYSByYWNlIHdpdGggdGVzdGluZyAtPm54cHJveHkuDQo+IA0KPiBEb2Vzbid0IGFueW9uZSBo
YXZlIGEgc3Ryb25nIG9waW5pb24gb2Ygd2hpY2ggaXMgYmVzdC7CoCBJJ20gaW5jbGluZWQNCj4g
dG8NCj4gZ28gd2l0aCAnMicsIGJ1dCBtb3N0bHkgYmVjYXVzZSBpdCBpcyBsZXNzIGNvZGluZy4N
Cj4gDQoNCkknZCBiZSBmaW5lIHdpdGggaWdub3JpbmcgdGhlIGltcGxlbWVudGF0aW9uIGlkIGlu
IHRoYXQgY2FzZS4gVGhlDQpwcm90b2NvbCBkb2Vzbid0IHJlcXVpcmUgaXQsIHNvIHNlcnZlcnMg
YXJlIGV4cGVjdGUgdG8gYmUgYWJsZSB0byBkZWFsDQp3aXRoIHRoYXQgY2FzZS4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
