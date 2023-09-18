Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F37A3F6F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 04:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjIRCUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Sep 2023 22:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIRCUS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Sep 2023 22:20:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74AF122
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 19:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIykSAoaRYJJ727ViX5GUbvowzM+XIOqjEOblUyC5QF0R5+BnZYZQhtWHhRobzFPxyxW+N7zXCr7Yzir/EhLjlOHriCndwXzJYCLjKN/Kk30m/AgL6l+Nx4RCKOQ01p91/mN1CzvLN6qtJ0kqZyHpzli0qhWBq0VXcGide6+pzVoD8Q54+b7TIgA+FF2s7bVSUws7B/r+RCzFOK16sSf3nAs+qaQ78ssEKVDgcVKH6kOAAlNjKKPeTrYSXpnXTh1VV8FEEeD+7Jx2MiSV+n6DDKDzAkkZArZ5V6NVST9Cp4usdhErcSThYNLict4SnnD2l5WVApwsY9MvxJqeR2cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT53lNxy1nCEzUGboGISW/20sWWoofKByyc04/mkYcA=;
 b=LFQIPutFegQ6ZYDH5YwSPHaudOgz7D/BTOFJ+rVcVC9fF2vbRHefYxcFXTE/oELQLUpBaNrUtzKM39qeQUAxqolGd+YFE8d1597fTKNeawtXaYvODviGLWwi+kRC/PbjscVxKElhmTTo02gPGxsbehKeFl4dcIveeCdsgQqeRt5F11fjnhMVnpKFHuSlK317K3QXeepAl4NvjlE3F2EHFMBfZx9AW9IsxzkR8MQPTvHNuI9YBU/eFr4wE7TB8e4zBbdpbVSHWCUINH+aFPbtPo3LSFyctkds3S0CiJA/SxjN52CkAVxZGdTe2W1JN+Oi1aC6WFwhY5KGam29LOGTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT53lNxy1nCEzUGboGISW/20sWWoofKByyc04/mkYcA=;
 b=JTqZp+l9YsXkbZpnkFq8JEIqEBh/6isR+fw2WeM66qFb1JH8znSRXVCH2U2DWcbCGHX24WmRiercGU9as5/xvyxeYH/9iJDggn+TPnIW18T2HoQc3cKqhtpUbAcI2uAk/qFPG7adZXj8gdWgeCiDhqvlEeBtchK0300064nrfek=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5313.namprd13.prod.outlook.com (2603:10b6:510:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 02:20:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 02:20:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH 1/2] NFSv4: Fix a nfs4_state_manager() race
Thread-Topic: [PATCH 1/2] NFSv4: Fix a nfs4_state_manager() race
Thread-Index: AQHZ6bx0T7le0+VsZE6O+8DR2maFYbAfyFaAgAARdQA=
Date:   Mon, 18 Sep 2023 02:20:06 +0000
Message-ID: <b8b29efbeb4467b1d255a8546ef9e0387a9709a6.camel@hammerspace.com>
References: <20230917230551.30483-1-trondmy@kernel.org>
         <169499985553.8274.16707412085976640956@noble.neil.brown.name>
In-Reply-To: <169499985553.8274.16707412085976640956@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5313:EE_
x-ms-office365-filtering-correlation-id: e2a433bc-095f-4ea1-05ec-08dbb7edc642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 028VfTfpLqVrmuzxrHMLgnvab6iWvnT7D6+NhSKtw7AHfxw+BEdHEdWHAMy1QEiE/9eUGFfGv4Ve8POWqIvbkug1F6IOM23CCy7Dw3jYhO7LNZiQRRo2Fc1ZbTfflQ+9kjM6kkzI/5faeP1L3G41cX01ppS9MBMIdmkq+7nICH1G23Hjmz68BAZHuRM6jpeYGSEC6fbilvHiQpWTXRps90hbiXQFRqUM9T5OzyzEc5WmESJZjkJmT10fUkMF5/hDES48ltAW86GlNjynntEy0rdEEANfM7ToaCnHlqSBwBNuzVke5lukKxwm6zgMYo0Xjb4erpfmQVgRvrDrNuW2Z8IUO2DxBEqRB1JS9s1FXTOSk7GXICbd4jDMKp/mv9VGIy2JMsIZWb/5ERtfhhU2v9hlG9YG2bZBq2fv8Et1HKAORCHw+jx+iKpvBmt1UvYpcq8d/b6RiOYDDS2iEoF6H0u56zaAbFz/fnJ8gHwFj+WspO1gLm42ggRn/sqvXLM0bP9qeDJbJMtUHX+jDZRPVlH4WMYvumQVpA/PgWkopgsoLmZLTvwJOi2dwjjqNTPyqktjdTskEbWoZ29KBS8gl6/Y4+ZWWrowzv79cO/TyzaAyVLj/BwirerG3vN3M1lWni5vFYGEUR2HBesW+Zc5vY9Sd4QeeNAfDxTZms6vKtw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39830400003)(84040400005)(451199024)(1800799009)(186009)(36756003)(66556008)(26005)(2616005)(2906002)(5660300002)(38100700002)(38070700005)(86362001)(8676002)(4326008)(8936002)(6916009)(122000001)(316002)(41300700001)(76116006)(66946007)(54906003)(64756008)(66446008)(66476007)(478600001)(71200400001)(83380400001)(6486002)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHdUZUIxUnlkVFhFTE4wbitkdHRGVUF4VW9UazlPWVhvNXpJeDIxeDI4NW1m?=
 =?utf-8?B?RTUyQmRwcTV4c1VzeG9EVlNhZDlib05UNDBqNEpDQUlUajU5eU4vbkgwOE9i?=
 =?utf-8?B?c2FpNjY1Q2pTYzhNOXFoa0V5T3FVVTd6bm5aanJUT1dmUkRXbzZKaDlkNmgr?=
 =?utf-8?B?RVZKZWFLQlBBc25GTHRRdWNtcnpoYnNvdVBsQlAvR0dTcWhZVUpiMFZEeEpJ?=
 =?utf-8?B?cmo2TDhiQmtJRE5vaFI0NzZYd25wV052bFdZdVJKZWRDWnViNDNSUHFZRE05?=
 =?utf-8?B?RXRTeHlJTkxhRmxCTG5iRHowQVpKTWp4R2thTkZnZnltaS9RZUdJajlJVjhj?=
 =?utf-8?B?ZFg5a25Bd3Y2RHNVVXhtZ1FSVmdlRHpjVnc2blNKSGx0Tm5RUEhSbHNmaSs4?=
 =?utf-8?B?NHRscjNJQmVmTksyem5xdEtLZ3lFT0FLOVhUZUhBSitMNEo0R0VLaXhXU09Z?=
 =?utf-8?B?KzA1WDl0S21PQW0vdmF4WnZwNDAyeCtneFhvSVlwSlZweHh4Wjlra2NCZ1ky?=
 =?utf-8?B?SFVKYUdhSjZyY29MMVllM2tBRFlya3gwWitNNU1ETy9nUVNjSzQ3SGRsRTF3?=
 =?utf-8?B?Sm9naUJlRjBqV1hyYUtMVkx5cVAveU9YZkcxN3hNc2k3dHJEY3hsM0RLWTQy?=
 =?utf-8?B?MUMrTjI4aVVibzRYdFhER2Y4ZWdXYlpQR3d6cjJnN0tXenVlMUdTRFFJZ1J1?=
 =?utf-8?B?U2grVE0wOEdDbm15eTM2aWN6ZEU4dzFEUXYwcW9pRlZPTmg1eHFkK2JuZjIy?=
 =?utf-8?B?VTZHWURJMmVuS3FJVG9zZHgrak5sMllNVHZRRHVRNklrRTBKOVBBam51NVZL?=
 =?utf-8?B?NllBSllwbC9UblNWcHhlN0szU1dYczEyRkdTVzAyalRIcE9yUGJOcVZnQk1Y?=
 =?utf-8?B?NVNha0VVZUEyOU5Zb01nbkp5YU41RlBwQUFPRytlV01BZVVGUHJvRWpJUFdy?=
 =?utf-8?B?TWo0dXExR2YvT2FBOUJ0WDZPL0F6UTJSZGh2RHo5cnNPVWcvajVuSGRYb2JK?=
 =?utf-8?B?RnBIUmZ4NmRnQTQ1aW13c1ZWOElmS3JlRkJaT2NlSCtIRDBnSkw4cVlSdFhR?=
 =?utf-8?B?VnlBQXRHUW56MFVYMzhBUWVOREpwU0QwMm5XYi80RzN6NnpOdWUvZk95ejlz?=
 =?utf-8?B?VWtiZ0dmU1ZYV3FjMGlDcWdGcEJjbmZ1TG1xU0tVeWVKU2dLb2gzZjVVdUhl?=
 =?utf-8?B?M0ErVVFHZUlKcEJITXprY3JWWHdEamFFS0VTNENoWk9ZdzBmMEtDMjlkRVFz?=
 =?utf-8?B?QTFaNy9GUkMrbnpxaktJT3l4TDF4UzRFc3lZdHYyTit2UEx2dnhyeUlwYU1E?=
 =?utf-8?B?OXRTMmViR1FqeXNETC92Q2NjVnZ3L3VEdjZQOVRjQnQ5U0VzU2U0MEVXQ1I5?=
 =?utf-8?B?VzM3RXgwK0RKalVkVFVCUXFTNU5oSWdzQUUyeU5nTlJ2RStNdUJTUWpVMStn?=
 =?utf-8?B?ajhlRWxXT3BMNjFYS2pYUlFNUHdHMUlmODErMVppK0QzaTFMOXFpcnRXODBq?=
 =?utf-8?B?UnUwaGRVYVlvWFJoQ29pL1VVSGk4Z1Awb3RVcDErWWc3WGFTM0VreWJWdElv?=
 =?utf-8?B?Z3RzVWxublNIdVJ3dk9hbHFPS1Z1QUFwUHY2UjdWdWV1YTlVV2NEUUx3MGRr?=
 =?utf-8?B?WThiSFh0RFVxbG5WZmsyWGlrUlIxSHR5dkRyMUY5NUhGL0hWL3ZydkgvRk82?=
 =?utf-8?B?QTAvd1R0c3FUZXowU0ppNFRIcDZoR2MxS2I4S3dkcVI0bTBKQ1FlTlRlUWVH?=
 =?utf-8?B?NGQyNTFqSHFzNHdjQnJxbWI1RWQ2OFQ3WHZFRkxCSEV0Zm5EdHU0SXpiYW4z?=
 =?utf-8?B?eWpSL210ZWlycEQvZWdiS0RBZks4QTVNMVhZNWJSaVlEODBmVzA0QlQrRXlF?=
 =?utf-8?B?OEUrKy9QNWo4dXdiUEQ2SGFuT21HL3IrczRYZ3hPNUdZTE1JT215THROS3Bo?=
 =?utf-8?B?SGlYbUJveGk3VmF2TnUvUHJuMnpxcHkzNExEc0FnVTg0eVpYVWlsYSt5eUtC?=
 =?utf-8?B?OWwzZUZFVm1Sd0d4QldRQ2JpOWtHUUc5M2p5TG5uT2dleTR4NEt5T2xVOThU?=
 =?utf-8?B?Q284WFNjRkVUZEJ1bG5UUng1VWp6dzlxZW1nOEFPeS9VMFlqeDZ4OXVPWjN1?=
 =?utf-8?B?YnljWGRUR2YwMTFucGpqeE1OOTU4TUFpNDZsVGRSYXRhUEIxMWUzQTNwZkxi?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C5CBE5B58E91D44BE3B78C899028250@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a433bc-095f-4ea1-05ec-08dbb7edc642
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 02:20:06.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hrttFVlnmqKFJif1D5A1DTYrDGZAgxOsBJcBbcx7rjOvr+oyEUhJ6wPkJ0cZB/up4td2ie66hRoomatkMB+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDExOjE3ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgMTggU2VwIDIwMjMsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTog
VHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0K
PiA+IElmIHRoZSBORlM0Q0xOVF9SVU5fTUFOQUdFUiBmbGFnIGdvdCBzZXQganVzdCBiZWZvcmUg
d2UgY2xlYXJlZA0KPiA+IE5GUzRDTE5UX01BTkFHRVJfUlVOTklORywgdGhlbiB3ZSBtaWdodCBo
YXZlIHdvbiB0aGUgcmFjZSBhZ2FpbnN0DQo+ID4gbmZzNF9zY2hlZHVsZV9zdGF0ZV9tYW5hZ2Vy
KCksIGFuZCBhcmUgcmVzcG9uc2libGUgZm9yIGhhbmRsaW5nIHRoZQ0KPiA+IHJlY292ZXJ5IHNp
dHVhdGlvbi4NCj4gPiANCj4gPiBGaXhlczogYWVhYmIzYzk2MTg2ICgiTkZTdjQ6IEZpeCBhIE5G
U3Y0IHN0YXRlIG1hbmFnZXIgZGVhZGxvY2siKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15
a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiAtLS0NCj4gPiDC
oGZzL25mcy9uZnM0c3RhdGUuYyB8IDcgKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMg
Yi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiBpbmRleCBlMDc5OTg3YWY0YTMuLjBiYzE2MGZiYWJl
YyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiArKysgYi9mcy9uZnMv
bmZzNHN0YXRlLmMNCj4gPiBAQCAtMjcwMyw2ICsyNzAzLDEzIEBAIHN0YXRpYyB2b2lkIG5mczRf
c3RhdGVfbWFuYWdlcihzdHJ1Y3QNCj4gPiBuZnNfY2xpZW50ICpjbHApDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnM0X2VuZF9kcmFpbl9zZXNzaW9uKGNscCk7DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnM0X2NsZWFyX3N0YXRlX21hbmFnZXJf
Yml0KGNscCk7DQo+ID4gwqANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KHRlc3RfYml0KE5GUzRDTE5UX1JVTl9NQU5BR0VSLCAmY2xwLT5jbF9zdGF0ZSkNCj4gPiAmJg0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIXRlc3RfYW5kX3NldF9i
aXQoTkZTNENMTlRfTUFOQUdFUl9SVU5OSU5HLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmNscC0+
Y2xfc3RhdGUpKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBtZW1mbGFncyA9IG1lbWFsbG9jX25vZnNfc2F2ZSgpOw0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiArDQo+IA0KPiBJIGNhbm5vdCBzZWUgd2hh
dCByYWNlIHRoaXMgY2xvc2VzLg0KPiBXaGVuIHdlIGNsZWFyZWQgTUFOQUdFUl9SVU5OSU5HLCB0
aGUgb25seSBwb3NzaWJsZSBjb25zZXF1ZW5jZSBpcw0KPiB0aGF0DQo+IG5mczRfd2FpdF9jbG50
X3JlY292ZXIgY291bGQgaGF2ZSB3b2tlbiB1cC7CoCBUaGlzIGxlYWRzIHRvDQo+IG5mczRfc2No
ZWR1bGVfc3RhdGVfbWFuYWdlcigpIGJlaW5nIHJ1biwgd2hpY2ggc2V0cyBSVU5fTUFOQUdFUg0K
PiB3aGV0aGVyDQo+IGl0IHdhcyBzZXQgb3Igbm90Lg0KPiANCj4gSSB1bmRlcnN0YW5kIHRoYXQg
dGhlcmUgYXJlIHByb2JsZW1zIHdpdGggTUFOQUdFUl9BVkFJTEFCTEUgd2hpY2gNCj4geW91cg0K
PiBuZXh0IHBhdGNoIGFkZHJlc3NlcywgYnV0IEkgY2Fubm90IHNlZSB3aGF0IHRoaXMgb25lIGFj
dHVhbGx5IGZpeGVzLg0KPiBDYW4geW91IGhlbHAgbWU/DQo+IA0KDQpJZiBORlM0Q0xOVF9SVU5f
TUFOQUdFUiBnZXRzIHNldCB3aGlsZSB3ZSdyZSBoYW5kbGluZyB0aGUgcmVib290DQpyZWNvdmVy
eSBvciBuZXR3b3JrIHBhcnRpdGlvbiwgdGhlbiBORlM0Q0xOVF9NQU5BR0VSX1JVTk5JTkcgd2ls
bCBiZQ0Kc2V0LCBzbyBuZnM0X3NjaGVkdWxlX3N0YXRlX21hbmFnZXIoKSB3aWxsIGp1c3QgZXhp
dCByYXRoZXIgdGhhbiBzdGFydA0KYSBuZXcgdGhyZWFkLiBJZiB3ZSBkb24ndCBjYXRjaCB0aGF0
IHNpdHVhdGlvbiBiZWZvcmUgd2Ugc3RhcnQgaGFuZGxpbmcNCnRoZSBhc3luY2hyb25vdXMgZGVs
ZWdhdGlvbiByZXR1cm5zLCB0aGVuIHdlIGNhbiBkZWFkbG9jay4NCg0KSWYsIE9UT0gsIG5mczRf
c2NoZWR1bGVfc3RhdGVfbWFuYWdlcigpIHJ1bnMgYWZ0ZXIgd2UndmUgY2xlYXJlZA0KTkZTNENM
TlRfTUFOQUdFUl9SVU5OSU5HLCB0aGVuIHdlIHNob3VsZCBiZSBPSyAoYXNzdW1pbmcgYm90aCBw
YXRjaGVzDQphcmUgYXBwbGllZCkuDQoNCkNoZWVycw0KIFRyb25kDQoNCj4gVGhhbmtzLA0KPiBO
ZWlsQnJvd24NCj4gDQo+IA0KPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmICghdGVzdF9hbmRfc2V0X2JpdChORlM0Q0xOVF9SRUNBTExfUlVOTklORywNCj4gPiAmY2xw
LT5jbF9zdGF0ZSkpIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZg0KPiA+ICh0ZXN0X2FuZF9jbGVhcl9iaXQoTkZTNENMTlRfREVMRUdSRVRV
Uk4sICZjbHAtPmNsX3N0YXRlKSkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfY2xpZW50X3JldHVybl9tYXJr
ZWRfZGVsZWdhdGlvbg0KPiA+IHMoY2xwKTsNCj4gPiAtLSANCj4gPiAyLjQxLjANCj4gPiANCj4g
PiANCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
