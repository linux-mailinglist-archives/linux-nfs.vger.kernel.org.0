Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1316857F148
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Jul 2022 22:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiGWUKZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 23 Jul 2022 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiGWUKY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 23 Jul 2022 16:10:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B37E0FF
        for <linux-nfs@vger.kernel.org>; Sat, 23 Jul 2022 13:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuFVGZP8cGkN4aM+ybO90HjKuupjrozRCW9/xSmRw2Metd/Z8pbFlEZ3CXnM0xUOhDPZGDTqwInE0+4ATKd2V8ujN3wF0jhbbn6a9Is7XTpKFNTWj3QZZRqF0YNv5CMBqfaTeulPzmUHdjNmZZVV2oIkEt94PU+6nnr4Osi41uWZvFZfYN+doqg0tuAoh8/2tPet1reP1gwUsdxPcbgotD232gdELimXOh6Wj4Qu5h19to7lIq9mRlSQpn5PnJaQlPxQSjjeaYSujgn3md4qDtpDlRHT14Uzldf+tYK8/U4rxg/w0ToJckxg60xNiWAp1LNXj2wqY2cFSbdNhqArvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Yocjz+QnrqNYV/xmOn2aoZdzeK3M7ks160h0nhYRk=;
 b=HpUYM2fcQdVZ1ThW5xMrXYXIFPOyZo0ytUYC6+Y9RkZ303WHex7GPWl5HdvlrIJXlzaBHX8JyUOgyExnGYF7QY1FY33N8VtRTl+XjrIXakvYSHBkO6X6OjWXC3uOfxIMONPbjiD5x2omOsPWYB5xSvpRm6vIaND2TftQRcvoE481kF+XsG1bJuPu9GR4dw3t0iKPyoA2s6MJdGXRWcxhFQUYopLQ5n3Jg+q2tGXE0Hy0fIeiaXAZtDZPAiujcWoQ3Qbp6B2QQCLHsYY9S3AxXhfn/T19k50oALCjBlUtC2XhAP7mi0T6NhWZh+7EfH47uNNOwMPd8O7vDRYR23sLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Yocjz+QnrqNYV/xmOn2aoZdzeK3M7ks160h0nhYRk=;
 b=KpR+SLOEzbxwIORQiku8Dl0cHol5wQUKLj1JIS7tsQEvkcxlS/oOqRlDcDVASmJjj1oNEn14sQqUzwJ0W6yiKIdglG/Cg1yboj9YFkDtOGO6wWPtmIdw2M5UYIFiGoaISuXw17iPyTCTOd2vmebYbgpaPltouMen9W9cYMhXDo0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5683.namprd13.prod.outlook.com (2603:10b6:510:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.10; Sat, 23 Jul
 2022 20:10:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%9]) with mapi id 15.20.5482.004; Sat, 23 Jul 2022
 20:10:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/4] SUNRPC: Widen rpc_task::tk_flags
Thread-Topic: [PATCH 2/4] SUNRPC: Widen rpc_task::tk_flags
Thread-Index: AQHYnfAS+oAKGgdygUGDZ0ujrDo8Yq2KrAGAgAAAj4CAAbgBgA==
Date:   Sat, 23 Jul 2022 20:10:16 +0000
Message-ID: <9bbefaf99fa4857a7718bea72127b5dd64e72898.camel@hammerspace.com>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
         <165851073589.361126.4062184829827389945.stgit@morisot.1015granger.net>
         <55155a8f566599ecf802103a8d7d3aa4ea3e421a.camel@hammerspace.com>
         <F3BA47F3-DE56-45DA-8E4A-4E8A65D5541A@oracle.com>
In-Reply-To: <F3BA47F3-DE56-45DA-8E4A-4E8A65D5541A@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27e20ac1-c14b-42c2-3305-08da6ce75c53
x-ms-traffictypediagnostic: PH0PR13MB5683:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGWcjWLXzMCyT5GWsTFj0rc0QOLOTY5Dm7Y2dgU9q4xuUs2OGicweeVHTwDEY8/Yo/idA7Rv2QroSPxyh3tdvqq9fSAscBgEgEHD+TDT6x1ryhsQUuY/CEvdWMHI1gJQbqtGe5VGyg+OmSplcAxnA9nskhfLSklRGlC49yDG2bpAxkNp0pGJBcO/WGNfVdA8f1ELPft8RmMFRjgP3gkMbZ2yeIR+Ak/2YxnHaybAUZDzAzL5roizPMd2m0NHDzguJr3TvsjTUvBWsKqxjraCh2+j9wckpKDwl6kf0alrSyaciQaYdPOJY3VcbLGE9FQU6JZXt8ZiUn2AO2Q+N1YEYYxAeCbu9vjy6cujvrzjollxQQxw/gJbTiL21vslv693gL3ePHvCUIHLebPsTpwf/e6Os7Gx83t8OxzTkZhQVIl8Y/Hit1wTdwgaoKAPNDfr780q+qGg4wcIXLyl5CLejiGbbRVI0HjYIlSlM2XTlefTdsJA1mtC5apAkuuuk/idNgHUQywLcZ6Ulo7cA5IErk9xS/NHbOEmrgMfgy8J3lp+H6gDBEWLiH/UoLLeI1Ur5LDyVxbng5NsB6yxBmOlbZPpnl+Yck42CqRyuVf7ZZ0ApDJKG0Heyjstx2AQZpa5gC2FyV0xrjJiUOpH/Ihvn5uifNnSO3ZwY5ILWTxP2oEk/br24EXHahj6jd7ovpBpaRpLjXTe1/BQcPRbHaleCt44bCvNRI4vFO7BFLTqDppf+8lqduSqmKTaLYiMUdMwbV0DInMF1GbwA9H8SxXA/JOv81+hFn1f9QcAty2T9v+D5ryIUTCxig3EFmIfuivfT//LTOLkunmX/gEvOoAAdbNAJlTJLE0MxNrD8iqMSHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39830400003)(346002)(376002)(76116006)(186003)(66556008)(66946007)(26005)(66446008)(54906003)(71200400001)(4326008)(66476007)(316002)(2616005)(8676002)(6486002)(6506007)(2906002)(83380400001)(64756008)(53546011)(6916009)(36756003)(38070700005)(6512007)(38100700002)(41300700001)(122000001)(478600001)(8936002)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWswWTVYaUxKSEVhbWJYcVpjL3QwdHdzemR1US9oR1ZYMVhvdXh5WXIxYlpv?=
 =?utf-8?B?R0h1ZWJyNmJSK0s3UlBDSmNVTW9hVHVQSnhieWdZNHF6RmFaWUhXQWJJZnRU?=
 =?utf-8?B?YUFBRXo1TVlMd0ZKTXdPNE5nYU9RRXEvSWlTQTNWdW1HRlIvSlVsOVpnd1FZ?=
 =?utf-8?B?QmUzQWs1NTlOeExpQWFSQTkxYUVhYTZQTGVEZ1JBY2taV0ZIdUlRL1c2Njl2?=
 =?utf-8?B?M0JyZ2M3VnN3NzRUd0RCRCtXa0t1SzFJeTVzdkRzbkRSOHAwUkkwa1FHSm1q?=
 =?utf-8?B?M2xYaHhFc05yK2JONXhUUXZDRTk2aWhsVzI3WW96SkhkR0F0UjJvSkpNRTU1?=
 =?utf-8?B?dlNjOHRsSWs4TmhZNm9xenlNT0RsWW1ZZ3N5SEhuREJNNS9iT0ZrN25Gc29B?=
 =?utf-8?B?TFVxSmRDUzMxZkVoams3aThlLytISkxCeDIvTGI2a0tZRElZYi9wb1VHVVRv?=
 =?utf-8?B?clgwRGxZUmhQS2Q5dE5RUS8xV2RQSE9xZ1ZvbUI5Tm1KMGdlMHlRU3pmY0Jn?=
 =?utf-8?B?S2xrZ20xUDNDM0RUUlZYNkh3LytLOGNGYjE1VzdBNXVVdDdzWHcxb3h3UU9J?=
 =?utf-8?B?VHg4NndwR3ZFRGhSQ1YwYll0dCtXOFZvWXFteUZqUWVBN2JVRVJFQU1nRmZM?=
 =?utf-8?B?bE5iOWNPaW1RblNCTWtBS0Z3L3pWUnN0TExCNEpLWEN1OVVtZFFKUGlKdG1K?=
 =?utf-8?B?QmJ0MlNzQUhScGJUMGJyeEhBc0ZiK3paa1ZlOThpOHRtOXN4NitlQjE3WHlh?=
 =?utf-8?B?YzV0cUtvUk0vdmdxSWpUUHJpYXdNQkxnbUdBRnk2YWRqaHVsbGJPQTZJT1Q5?=
 =?utf-8?B?VW9MQ0JPaU95STZuc0p6bXZSNDJlbkNlOXNuWTh5RzJYMlVlWTJZNlU2Ylpl?=
 =?utf-8?B?TTl4U0lJYXJMNXRvRitMZGNsVnhXMktUWTdzTEFuVExYM0w1aXZ0VkpmdUZX?=
 =?utf-8?B?WXRoR2ZjNzhudnRQaGpwa2ZoNlRHZHlxS1U2UmZ5OS95ZlpZV2t6RGk3Zng0?=
 =?utf-8?B?Ums2cUNuY3lkZGY3R3RENWlmUjVoZ21OTFZyNHZlaEt5dHlRa2RHTis4cExv?=
 =?utf-8?B?NCt5OFVPcWVvcnZNRUF5OXpWRnZJbWJQdHF1dlJpTGFlaVFsWFZKbXVTQk9H?=
 =?utf-8?B?L3FXdW5OZnZPalZyZGRTaFR0eXJMTFNkNGFFc3dmOWs2cUYxR1VuVzVZMDJZ?=
 =?utf-8?B?b3N3M2Z3c1I5NTJaU3pVU0FxRXBwcEZmaHZadVN6cWZjTzROWFN5UFk1UFZE?=
 =?utf-8?B?OTBVcGlxYW9BSTFDblRzVTFLTDdjSEhaMjR5bmwzUDdhRFFjZ2hBcjdlUHJD?=
 =?utf-8?B?eFJ5bUd2TmRWOWx5aHZXWmIyY2N1Z3ZzUXA1bUY0anI5MHZING9zbGk2SFlO?=
 =?utf-8?B?YnRXd2hlMWN4SlAwWThXUGt0blIwQ1o4RUhpanllWGlyT0pIMEhJTWJHWjM0?=
 =?utf-8?B?ZFZDSVg5NU16aUtpeU41b0NCc0VIQ3Z5b2ZPOW4wL01MWXBHbDRwdE96eEN6?=
 =?utf-8?B?YXBHYWZHd1RybGhpc3AzY3IxNlV1MlNyOE9pYzBWdDdRUWtHRnpjbmxLZnRq?=
 =?utf-8?B?cWRwbXIrTk8wb1NHaGlYR2ZTV3RwenZOSUxoM0NxOTY2clhtdzFyUHJjUFhJ?=
 =?utf-8?B?eUZPeit6VFJwM3kwRjZjSjJmUVVoQm44QjhVdmovR1VVY1RiYU42Y1BXZUVU?=
 =?utf-8?B?ZW9hN0JycEVIczNST3BUSVdvZ2NrckZ5anZVeW1EK3E1YW5lNWpiU2lyN1Bz?=
 =?utf-8?B?dGJjSXJuWVh6ZWpGZ3BWTlgyTEhvZjQ2c0JGOUpDUDFoVWI0NW05bTFVZURw?=
 =?utf-8?B?VzhKWWVycFVUUUlDUEtmZEwzN2R3MEtVVjBEZktjbWc2VVcxNWpsVW9rL0RZ?=
 =?utf-8?B?alJrOWNKTUs3QVZFS3BnOWFRL01EeExBZ1I0WDQ3NTVNWVZ5TUdXcjVwYjNZ?=
 =?utf-8?B?aHZtYWRMYmgyb2lZWVNFODZGcDI0UW0wSWZ5NzFvQ3Q4V1NLNllNR3B2YUlY?=
 =?utf-8?B?NUpVYmZHa0ljTG9FT29raGtZMng0TEljejhWNEpLZVZBZi93U3lSTnlxOFoy?=
 =?utf-8?B?Z1VxZHQ3L082eDhTYStxSUxJVUxoTFFsUmk4V2VpK1dycEJnVVR6QURyTzho?=
 =?utf-8?B?TkdyaHJBNWpGcVhjUUozMm8vL1dTaVg5ZG9uNDFmSkl2Y1BzYitpTjJzRE5l?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FDA2A831115BA44880F163D156A5F7E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e20ac1-c14b-42c2-3305-08da6ce75c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2022 20:10:16.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: el/CCjkyxA4XmvvkjPbBAxMOJ4nO1QzxnBGPI73Miqq09NpkOJfpDKnKLPkilGtRIlqChk3SD3lN/yWp5Ti0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDE3OjU1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdWwgMjIsIDIwMjIsIGF0IDE6NTMgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJp
LCAyMDIyLTA3LTIyIGF0IDEzOjI1IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IFRo
ZXJlIGlzIGp1c3Qgb25lIHVudXNlZCBiaXQgbGVmdCBpbiBycGNfdGFzazo6dGtfZmxhZ3MsIGFu
ZCBJDQo+ID4gPiB3aWxsDQo+ID4gPiBuZWVkIHR3byBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuIERv
dWJsZSB0aGUgd2lkdGggb2YgdGhlIGZpZWxkIHRvDQo+ID4gPiBhY2NvbW1vZGF0ZSBtb3JlIGZs
YWcgYml0cy4NCj4gPiANCj4gPiBUaGUgdmFsdWVzIDB4OCBhbmQgMHg0MCBhcmUgYm90aCBmcmVl
LCBzbyBJJ20gbm90IHNlZWluZyB3aHkgdGhpcw0KPiA+IHBhdGNoDQo+ID4gaXMgbmVlZGVkIGF0
IHRoaXMgdGltZS4NCj4gDQo+IEl0J3Mgbm90IG5lZWRlZCBub3csIGJ1dCBhcyByZWNlbnRseSBh
cyBsYXN0IHllYXIsIHRoZXJlIHdlcmUgbm8gZnJlZQ0KPiBiaXRzIChhbmQgSSBuZWVkZWQgdGhl
bSBmb3IgUlBDLXdpdGgtVExTIHN1cHBvcnQgYXQgdGhhdCB0aW1lKS4gV2UNCj4gd2lsbA0KPiBo
YXZlIHRvIHdpZGVuIHRoaXMgZmllbGQgc29vbmVyIG9yIGxhdGVyLg0KPiANCj4gSSBkb24ndCBo
YXZlIGEgcHJvYmxlbSBkcm9wcGluZyB0aGlzIG9uZSBpZiB5b3UnZCByYXRoZXIgd2FpdC4NCj4g
DQoNCkkgZHJvcHBlZCBpdCBhZnRlciBhcHBseWluZyB0aGUgb3RoZXIgdjIgcGF0Y2hlcy4gQXMg
SSBzYWlkLCBJIGRvbid0DQpzZWUgYSBuZWVkIGZvciB0aGlzIGV4cGFuc2lvbiB5ZXQsIGFuZCBp
ZiB3ZSBkbyBhdCBzb21lIHBvaW50IHJ1biBvdXQNCm9mIGJpdHMsIEkgY2FuIHNlZSBvdGhlciBm
bGFncyB3ZSBjYW4gZHJvcCAoUlBDX1RBU0tfUk9PVENSRURTIGFuZA0KUlBDX1RBU0tfTlVMTENS
RURTIGJlaW5nIG9idmlvdXMgdGFyZ2V0cykgYmVmb3JlIHdlIG5lZWQgdG8gY29uc2lkZXINCmFj
dHVhbGx5IGV4cGFuZGluZyB0aGUgc2l6ZSBvZiB0aGlzIGZpZWxkLg0KDQpJbiBmYWN0LCBieSBu
b3QgZXhwYW5kaW5nIGl0LCB3ZSBjYW4gdHJpdmlhbGx5IHNocmluayB0aGUgc2l6ZSBvZg0Kc3Ry
dWN0IHJwY190YXNrIGJ5IDggYnl0ZXMgb24geDg2XzY0IHNpbXBseSBieSBtb3ZpbmcgdGhlIGZp
ZWxkDQp0a19ycGNfc3RhdHVzIHRvIGVsaW1pbmF0ZSB0aGUgY3VycmVudCA0IGJ5dGUgaG9sZS4g
SSd2ZSBhZGRlZCBhIHBhdGNoDQp0byBkbyBqdXN0IHRoYXQuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
