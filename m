Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBE6F11E3
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 08:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjD1Goz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 02:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345054AbjD1Goy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 02:44:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8F2D5B;
        Thu, 27 Apr 2023 23:44:52 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S6bekQ030950;
        Fri, 28 Apr 2023 06:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=V+SuhcfrwJ5zGNGhrLVg8AVxNPxTXvANFav3wU8ufyU=;
 b=XNDowFQjOBqqZB/ajydRxGaDXrQHyBq31GgKEQv/8rU8AiOHScdBjJr3GD4x45DZmMgJ
 uIifuL80NXpO3toiMnjk+KZvkeXndmvrNv2LpdmMx1vfBHoorx5/JrXa9X3rhQB1YMGV
 DFvcJgIsQeRtrgyckXLbB11Nrj6Jj4pdK+HO3vW/FYTJ1KwxtPv0wjZNY8rYp0gx1Fak
 p8wwn+jWJ3ziU9vli6DMo8gaBJQ+WEsedpMy2vNG2odfYL1DSZvWnNom0TyuvGZzLLbN
 Vugz7JGtZsQRixRbRb+UtMoDzHkvxyhZN1i77xd+8vRjZB24Aj0gJze8keFU9quEKHWG og== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q87h9jyut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 06:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZZBiRKalnKk/yMzDIZozjM7bnDnXWJR+osMwIX8CioD97yoiARy/2HoPsxk2MFznWmtSiBvXzlyFI9c8PDE5L3YigGBF3bpKhkruGrw5v1K9S94DYECYAT6vNuLnG2fjua9gBV4sdEkrCWDeRzkvAE8GKmijoQc3XvYiQZOAkDBZrTzMemB2aVbTDVyHvv2MZlSju3/5UioBKGP0CzbihqlaXWm3GGHmZwBKdV1jDn2HF85Po2CsHi9eFuXxKecJNJs9Ri9OQfwtiY4hiEFxskYDgTriPJWIszRvqZT16uet/2gExtDYUk6XUNPOwAqhPqtHYnJymugaQk16NIgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+SuhcfrwJ5zGNGhrLVg8AVxNPxTXvANFav3wU8ufyU=;
 b=CZi9cWlJWqb/TZKYqKJez3lurC3su+lfqOrk03R1MGKk2OE6anFBpGkpSGmYXFbFqpJJHyIlobMlXzrXwj8zI08uHqyDteyYJDzhbHB1SbFj6LKNKXhg9PEQzLI9mRfhL0wYFXuDlnnATPrYr/z6sNWnd/U6ysTuG8ElcXBsfpqxjXuh3uMe8gKMXt0lvTE7UEj96gh1sN3NUoKNeAdkqhgC/hMmavj+YrOy/LHWQCNJ2epA+yss7lbvR1V0wSlr6b/Z4i8AGunyXtUckZ6gfJIta+Ik2KvsEwt18+Xm5/wStvQWIyi7PXNVb9yA857rn1GORAF4ngWrIUBckmh6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA0PR15MB3888.namprd15.prod.outlook.com (2603:10b6:806:86::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 28 Apr
 2023 06:44:44 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5ced:e1f2:71bf:a4f0]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5ced:e1f2:71bf:a4f0%7]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 06:44:44 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Chuck Lever <cel@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Topic: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Index: AQHZeTCM5PEfyoj3TE6mcGo9CXla4K9ARpCw
Date:   Fri, 28 Apr 2023 06:44:44 +0000
Message-ID: <SA0PR15MB3919E7375CF7DDBE2E0F3B96996B9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
 <SA0PR15MB39193598A4C64E84F6E07582996A9@SA0PR15MB3919.namprd15.prod.outlook.com>
 <29A9F2AE-ECF8-4EFC-B1EB-7B147FB17737@oracle.com>
In-Reply-To: <29A9F2AE-ECF8-4EFC-B1EB-7B147FB17737@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SA0PR15MB3888:EE_
x-ms-office365-filtering-correlation-id: 51759399-33e3-428e-d755-08db47b40d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3jeR25noSpdyyDcAL6jsTmT+/Msem8Qut7jGwpwB9OA3BS5TKsD/iQT9pK0sO9yYYLZ6gLMX9OsVU+Yv3+T2TPyAkqQN/l9Dd7geoHjQDj97nllIL8blIrblo95Yc9zR/r8YJK91gRLe0Q2kIiRSUoBar2t0IUwi5DSpe8qGScAri/JjqX1ejNFDftvJwgGHiIAS7NS2QYW8MrK6JUmQnLVjKwNNwms4qnskku4qpI/8K+RgAj+7RISoSHVjz1hh+lbc0TLOmWSy6e/S+Dswvev8knGGnVXyYoVIuutW4/5hTRg9Daso7+o9HWW3kxTnKEBB9lC75r4fFAtbtlNkI9qYIN7dNcqJS+IWEQcrnWbGqYOSlOe/DYXYTJhoXZmiuLD+FUOiBjbyYe/Hwi842ow7E/iVD4EUu7cQdXgjU6BzFfJUQ/IZwux5UHRRHyR99asmUbNG05J6/fqXZCuyQZYNOIU02UTltxq1rW3vDzCB/UbzGn8q/yKAaKZukZf3k3+yLyT8dNgJreqaNU7m7R0x3N3zMCXcjBD1SDEdiyZyF0BOgVYDEQJ5t38BliXyMNoqMNd3JSaMyD4LwrOmH7awu11f2u+ZB527e+Mti9IqF5x8NSd3HoNyQZGKxlI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(8676002)(8936002)(2906002)(41300700001)(38070700005)(38100700002)(5660300002)(122000001)(33656002)(52536014)(86362001)(478600001)(55016003)(54906003)(9686003)(6506007)(71200400001)(7696005)(66446008)(76116006)(53546011)(66556008)(66476007)(83380400001)(6916009)(186003)(64756008)(66946007)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enl4eUdwSjhSSE9SMTB1UEJKOUVDUzNxdzl2aUlSY2hNb1B4QzJiditoREgv?=
 =?utf-8?B?enhpNDVsRW0vYnFHZjM2TEtEWkl6TXRQUzJRdERqcXlJRGt5dm0vT0E3MU5N?=
 =?utf-8?B?TmVoa0N0czcrOUhVZVd5REhsakc2YXByV3kwMHlRR1U1d09oRDRHWDc5dnlB?=
 =?utf-8?B?VjRyNjlnVnd2bjFKOTZXaGl0a1BWbGFYaFJPdnBvNEhPSnQ5MUlvSWI1ZHBu?=
 =?utf-8?B?VUVMU0Jac0xZaWNtSS8vbExjTDB1aWhzK0ZZaW5Xa1V5VTErQVFSRlRUaEgx?=
 =?utf-8?B?bWFkR0NsL3VxQmw3UnM4aVMwbjE5Ri9BVDhPYzRFMm50eGo1WDFaZmYzZHdU?=
 =?utf-8?B?S0Fnemc5YnRab3JwTVNDdU8vbmdzY0k5L2Q2M1VYMzdlK1hMODNWc1ZIc0Jr?=
 =?utf-8?B?aUo4cE8rMnd5MU5tM3IyeFk5RXJRTURaR1YxU3kzOHdEOEwrakJrLzZHeVJn?=
 =?utf-8?B?WmNVU2Roa3V2bkc4SXlzanZOOVJoWldhbUo4RzhDOHJQTWFwRVpFRnZFbnBk?=
 =?utf-8?B?Vm85d0ZZbXkycjRZd0tkRy8vUUw2bHErWlNXWC9Lc0FERHhjSHVtRXA5bzE5?=
 =?utf-8?B?Z0VoZ0hKdXFJR2ZNWmFkVi95M1dGcFFMSTlBcjA4dG5PazlTODJkWk5BaURU?=
 =?utf-8?B?eU53SkFzcXVzWnZuSWJTaWFXcUFhWTNpM1JieDFVc2FJWDVkbjdWNFdjbnI3?=
 =?utf-8?B?dzRvUFZFSHFFc2FEU01lQWFzQURrUkEwZ1FEWkVxeTZxbDFFU1BRbkYrK1dt?=
 =?utf-8?B?MGNvRlp0dHdmODhFb0wwbzc5NkVBS016RlpJQWwyRTJKZjAra2JMNEx0TXpi?=
 =?utf-8?B?NGw2THVmR05nU2Z6eTN1VmRVTmVobDVYcE1EZlJaVUFSUmlFTEZuRWdJeExM?=
 =?utf-8?B?UWl2cnhDOXJzbWdxTm9KVjRxVUYxZDg0RzVxSnlmbWxYanowRnhoSlhxQitj?=
 =?utf-8?B?TXBtczlPVG5wMC9vOWQ5OXRYcDdCL2g2bDNid1pXeFo0dEpCcisxNW9tQzZC?=
 =?utf-8?B?RmVtY3U3endnaERLNTM1MzMxWWdXZ0ZnNTU4dnFUVlNrbUFUaW5IWEdQVzlW?=
 =?utf-8?B?QTF1bmlZanFaSG9udndzK1VNbW91SVMxUVlHVkZMZ2FFdHJFSFRQb0Y0R1R1?=
 =?utf-8?B?UUZxb3JpcXp5TzhlbWU4bzh0Mk1oa1FTS2h3dFZXOHpETTJUMWc1MXcxK1Qw?=
 =?utf-8?B?QnN2QkRKeFhoK0h6Wlo2YXNKd2lsdWNyeFFMUlQwY21YbVlMbUpBU0ZxaEt6?=
 =?utf-8?B?WUxzTDk1K0JTckNIdDhhYS8xenQ0VURJbEhFU1BOK1pIQjZjbm9oYml2OEs2?=
 =?utf-8?B?aDNtc0dqVVJ6aHJTejR2YlRFWElOSU80MWNjM080cWNHWkVBc3NaRnFxb20z?=
 =?utf-8?B?WVBJdWFZUWMxUDY1Y1hyeDN2aml2QVhzRXhING1zYjJmc1FmOGlKOXVkSTRW?=
 =?utf-8?B?N0JKSFVoUGNEMzJ3czRPV1l2K29UNzZ5U2dKS0JwZXpIcmQ3UGRnbkdqOWNU?=
 =?utf-8?B?UFlNZEhiQitNamY4UkhZeXNKMmMzZjExWWhiNGZBNE5yVnJTM2FvY0xMNzhw?=
 =?utf-8?B?RXprLzJYMDhGTmd6b3k4SEdueUFvTTFITVBBVEhVYkhEejhWSkpuRklBREFi?=
 =?utf-8?B?VmtHR2wzbzdsMVg1L2dOR3NlM0xmZElJVi9aZDlHSmJpVURrMk5Ja2JNcEc5?=
 =?utf-8?B?REhBU2RCdlJxWDI5SDVFOENTR241Nkc5eG9xY0FSenMzYUhFQ25lb3lRNWhj?=
 =?utf-8?B?Y3crd3FCclA4NmEvV2FoZGNNSUpaTVFYd2xrQ0xrK1BOaHJubm1xUTFOOEdB?=
 =?utf-8?B?QkhoMHR0WVZrRlpNemNDNW9YbzJBYzFtd3gzelF5SjNXTHNGQnd0UTJ4NDdx?=
 =?utf-8?B?dWVhZEdxcGtaZlRuMG1VSTV5S3VGbkZSVTJmVkoxTWNhSWIydkhHSFgwYVcz?=
 =?utf-8?B?TFVMS2laaGQ1aWJjRlk3d0J2cDgxWmJwbGRER0k3RENUWXNVZDhLZUpxTjhJ?=
 =?utf-8?B?REw0eEJ0dmJaZSttV3NNRzZEM2pMSGkxNkVyUGs4SHY1WEkrTFhJa3dMeXJ3?=
 =?utf-8?B?MWRLL1Q0OThLZlRjVnkwRkU5MWxIN3c3dU1pSGNxZ2Ztb0l0YWQzbHUwZjI1?=
 =?utf-8?B?MWkwTkxXWCtJajBRZTRkUUU5RG91NFYrUWN2UnBKbDJoWTlUWTNYdk50d05z?=
 =?utf-8?Q?uvT6VTmoF75KpP3QPC0jwlh/T6uI9ZI17QbGzOqavfKA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51759399-33e3-428e-d755-08db47b40d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 06:44:44.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTp+feI52S+fgH7LgKsVWweWCkXhM3jAhqpQU3HIlvAq7wvB7kNJgcRsIwjgYCvGGb2kVGqpuFVPPLFO8C81fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3888
X-Proofpoint-ORIG-GUID: fbWjrU97ZznMfngFxrRwgJBeA4HEBup1
X-Proofpoint-GUID: fbWjrU97ZznMfngFxrRwgJBeA4HEBup1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1Y2sgTGV2ZXIgSUlJ
IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgMjcgQXByaWwgMjAy
MyAxOTo0OA0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENj
OiBDaHVjayBMZXZlciA8Y2VsQGtlcm5lbC5vcmc+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9y
ZzsgTGludXggTkZTDQo+IE1haWxpbmcgTGlzdCA8bGludXgtbmZzQHZnZXIua2VybmVsLm9yZz4N
Cj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIFJGQ10gUkRNQS9jb3JlOiBTdG9yZSB6
ZXJvIEdJRHMgaW4gc29tZQ0KPiBjYXNlcw0KPiANCj4gDQo+IA0KPiA+IE9uIEFwciAyNywgMjAy
MywgYXQgMTo0NiBQTSwgQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBDaHVjayBMZXZlciA8Y2VsQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCAy
NyBBcHJpbCAyMDIzIDE5OjE1DQo+ID4+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2gu
aWJtLmNvbT4NCj4gPj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1uZnNA
dmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIFJGQ10gUkRN
QS9jb3JlOiBTdG9yZSB6ZXJvIEdJRHMgaW4gc29tZSBjYXNlcw0KPiA+Pg0KPiA+PiBGcm9tOiBC
ZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCj4gPj4NCj4gPj4gVHVubmVsIGRl
dmljZXMgaGF2ZSB6ZXJvIEdJRHMsIHNvIHNraXAgdGhlIHplcm8gR0lEIGNoZWNrIHdoZW4NCj4g
Pj4gc2V0dGluZyB1cCBzb2Z0IGlXQVJQIG92ZXIgYSB0dW5uZWwgZGV2aWNlLg0KPiA+Pg0KPiA+
PiBTdWdnZXN0ZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4g
Pj4gLS0tDQo+ID4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMgICAgICB8ICAgIDQg
KysrLQ0KPiA+PiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMgfCAgICAxICsN
Cj4gPj4gaW5jbHVkZS9yZG1hL2l3X2NtLmggICAgICAgICAgICAgICAgIHwgICAgOSArKysrKysr
Ky0NCj4gPj4gMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUu
Yw0KPiA+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4gPj4gaW5kZXggMmU5
MWQ4ODc5MzI2Li4yNDkzY2E0ZjI3MzkgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NhY2hlLmMNCj4gPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2Fj
aGUuYw0KPiA+PiBAQCAtNDEsNiArNDEsNyBAQA0KPiA+PiAjaW5jbHVkZSA8bmV0L2FkZHJjb25m
Lmg+DQo+ID4+DQo+ID4+ICNpbmNsdWRlIDxyZG1hL2liX2NhY2hlLmg+DQo+ID4+ICsjaW5jbHVk
ZSA8cmRtYS9pd19jbS5oPg0KPiA+Pg0KPiA+PiAjaW5jbHVkZSAiY29yZV9wcml2LmgiDQo+ID4+
DQo+ID4+IEBAIC00NDEsNyArNDQyLDggQEAgc3RhdGljIGludCBhZGRfbW9kaWZ5X2dpZChzdHJ1
Y3QgaWJfZ2lkX3RhYmxlDQo+ICp0YWJsZSwNCj4gPj4gICogbGVhdmUgb3RoZXIgdW51c2VkIGVu
dHJpZXMgYXMgdGhlIHplcm8gR0lELiBDb252ZXJ0IHplcm8gR0lEcyB0bw0KPiA+PiAgKiBlbXB0
eSB0YWJsZSBlbnRyaWVzIGluc3RlYWQgb2Ygc3RvcmluZyB0aGVtLg0KPiA+PiAgKi8NCj4gPj4g
LSBpZiAocmRtYV9pc196ZXJvX2dpZCgmYXR0ci0+Z2lkKSkNCj4gPj4gKyBpZiAocmRtYV9pc196
ZXJvX2dpZCgmYXR0ci0+Z2lkKSAmJg0KPiA+PiArICAgICEoYXR0ci0+ZGV2aWNlLT5pd19kcml2
ZXJfZmxhZ3MgJiBJV19GX1NUT1JFXzBHSUQpKQ0KPiA+PiByZXR1cm4gMDsNCj4gPj4NCj4gPj4g
ZW50cnkgPSBhbGxvY19naWRfZW50cnkoYXR0cik7DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gPj4gYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd19tYWluLmMNCj4gPj4gaW5kZXggZGFjYzE3NDYwNGJmLi44NDJhMDM5ZmE0NTcg
MTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0K
PiA+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gPj4gQEAg
LTM1OSw2ICszNTksNyBAQCBzdGF0aWMgc3RydWN0IHNpd19kZXZpY2UgKnNpd19kZXZpY2VfY3Jl
YXRlKHN0cnVjdA0KPiA+PiBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ID4+DQo+ID4+IC8qIERpc2Fi
bGUgVENQIHBvcnQgbWFwcGluZyAqLw0KPiA+PiBiYXNlX2Rldi0+aXdfZHJpdmVyX2ZsYWdzID0g
SVdfRl9OT19QT1JUX01BUDsNCj4gPj4gKyBiYXNlX2Rldi0+aXdfZHJpdmVyX2ZsYWdzID0gSVdf
Rl9TVE9SRV8wR0lEOw0KPiA+Pg0KPiA+IFRoYXQgb3ZlcndyaXRlcyB0aGUgZmlyc3QgYXNzaWdu
bWVudC4gUHJvYmFibHkgYmV0dGVyDQo+ID4gJ3w9IElXX0ZfU1RPUkVfMEdJRDsnID8gT3IgcHV0
IHRoZW0gb24gb25lIGxpbmUuLi4NCj4gDQo+IEQnb2ghIFdpbGwgZml4Lg0KDQpPdGhlcndpc2Ug
bG9va3MgZ29vZCBvZiBjb3Vyc2UuIENvdWxkIHlvdQ0KcGxlYXNlIGNoZWNrIGlmIHRoYXQgZG9l
cyBub3QgYnJlYWsgJ25vcm1hbCcgRXRoZXJuZXQNCmJlaGF2aW9yPyBJIGFtIG9mZiBmcm9tIGFu
eSBrZXJuZWwgdGVzdCBpbmZyYXN0cnVjdHVyZQ0KZm9yIHRoZSBuZXh0IGZvdXIgKCEhKSB3ZWVr
cyB1bmZvcnR1bmF0ZWx5LiBTb3JyeSBhYm91dA0KdGhhdC4NCg0KVGhhbmtzIGZvciB0aGUgcGF0
Y2ghDQpCZXJuYXJkLg0KPiANCj4gPj4gc2Rldi0+YXR0cnMubWF4X3FwID0gU0lXX01BWF9RUDsN
Cj4gPj4gc2Rldi0+YXR0cnMubWF4X3FwX3dyID0gU0lXX01BWF9RUF9XUjsNCj4gPj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvcmRtYS9pd19jbS5oIGIvaW5jbHVkZS9yZG1hL2l3X2NtLmgNCj4gPj4g
aW5kZXggMDNhYmQzMGU2YzhjLi5jNDhmMmNiZTM3YjUgMTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1
ZGUvcmRtYS9pd19jbS5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvcmRtYS9pd19jbS5oDQo+ID4+IEBA
IC05MCw3ICs5MCwxNCBAQCBlbnVtIGl3X2ZsYWdzIHsNCj4gPj4gICogcmVzZXJ2ZSB0aGUgcG9y
dC4gIFRoaXMgaXMgcmVxdWlyZWQgZm9yIHNvZnQgaXdhcnANCj4gPj4gICogdG8gcGxheSBpbiB0
aGUgcG9ydCBtYXBwZWQgaXdhcnAgc3BhY2UuDQo+ID4+ICAqLw0KPiA+PiAtIElXX0ZfTk9fUE9S
VF9NQVAgPSAoMSA8PCAwKSwNCj4gPj4gKyBJV19GX05PX1BPUlRfTUFQID0gQklUKDApLA0KPiA+
PiArDQo+ID4+ICsgLyoNCj4gPj4gKyAgKiBUaGlzIGZsYWcgYWxsb3dzIHRoZSBpbnNlcnRpb24g
b2YgemVybyBHSURzIGludG8gdGhlDQo+ID4+ICsgICogc3RvcmVkIEdJRCB0YWJsZS4gVGhhdCBp
cyBuZWVkZWQgdG8gZW5hYmxlIHNvZnQgaVdBUlANCj4gPj4gKyAgKiBvbiB0dW5uZWwgZGV2aWNl
cy4NCj4gPj4gKyAgKi8NCj4gPj4gKyBJV19GX1NUT1JFXzBHSUQgPSBCSVQoMSksDQo+ID4+IH07
DQo+ID4+DQo+ID4+IC8qKg0KPiANCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+IA0KDQo=
