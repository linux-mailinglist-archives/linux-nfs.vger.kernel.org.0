Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3753D31CEB7
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 18:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBPRLV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 12:11:21 -0500
Received: from mail-bn8nam12on2097.outbound.protection.outlook.com ([40.107.237.97]:61248
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230248AbhBPRLS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Feb 2021 12:11:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpnVoSUX6Tr05EXQ6rP/ADZoOPI3dzI6H7fsCV0niSdH9AbE2XKNTUdE/zeM58QA9cztqhQ0q+ZzVcBcwn73hYiFPaeeM4UkDSnUNGmgLUwMW3e+F3K7/DXKK5OgIm8aEhlep0MLdTTC8pJRbvSCU0qs90BhcZtoIqwL8xEFprnL/HqEvJjJl2YTwA01Da09YKqyDwXF/OIlvQZ+Qt97ToQNqoxSwZNonilKW5f+IBo6QOClTuJCmd57drCO18fYQ1D3228HaAcXh0SgftzumvOuEFlbq/NhmjWWxF2gdFWoQwtUbHVg2BIn4qxFqgKRzywvVU15lNsoIIoQfoY4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkL4CY4MjbjGRpdvvaPRjQQcUBQeaqbohDxX736LJ7s=;
 b=Leu9Y+XtscNEOJ6/uihIROsjTjNPOqpsfE+TmVIKMuUIH84V5T4gVsI+Q4ERCZMIDQfSpgKsBU/DguwZ22fckymVMA0rvsqryNoPMOddMEBrUjB2+BAMc0mYZkZNkzOo0fs/dP4CsI83i22OVZ4uQ37/bYc5YfKWBd1zBmJpaj9gtqZ0ZJJG8uXkkOSoBTLd3rbIjPZr51bpmCUUAQhHxLjHdctIC6B5643smn0m9WLJeSmKJW2O3x6J84xj14Ei61+YSik6ZDzCv7tinUD/stI9/T2cBN8trI9WtsDmOV71fU7HICPGDamjBA7sw/qtb7dL6ZPEH7o0CdIjNTH1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkL4CY4MjbjGRpdvvaPRjQQcUBQeaqbohDxX736LJ7s=;
 b=I/p+aY4e7RHHYd2dbqLZ0zAnyE386O0U40Kx4kX7LCm1s6ZjOJ+91Pf0s61/ON0xttatKaDAXtivBc9HgKMKD7YVcwo8nOA8vfwfx+w4Pod+jZPG7V17G1WQHqIWN84ZBJwerVpbMopwiWGd5ubRDKUlf1cDhDD8X32RDAMhwBg=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4761.namprd13.prod.outlook.com (2603:10b6:610:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Tue, 16 Feb
 2021 17:10:21 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.025; Tue, 16 Feb 2021
 17:10:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkaKHQ4x2Pj5G0O0h0qlFPlIMKpa/JkAgAAMDwA=
Date:   Tue, 16 Feb 2021 17:10:21 +0000
Message-ID: <a0b15faec428fba8d1e10adc7f54cb11a15fc19b.camel@hammerspace.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
         <635D6DE6-3E7B-43EB-93A4-075DE91897BB@oracle.com>
In-Reply-To: <635D6DE6-3E7B-43EB-93A4-075DE91897BB@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ed61c76-c9c1-4628-4b88-08d8d29dbe50
x-ms-traffictypediagnostic: CH0PR13MB4761:
x-microsoft-antispam-prvs: <CH0PR13MB476175BFAE5CB1D167FDE8FBB8879@CH0PR13MB4761.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8zw8t6tO1WvsmGj1dPc3+PY1Cw38bDR516Gfqkcd6Fi9iszBNe+xFulbtgMn23BntG55812xUBEDpGtOySbU157KLHTwzUaQBPV6fq0XMF98FatEW8ZvWz9PuNJ9BSaBRT81DCTEsCrM3fgGwex4+telVY525NHppsmzbXAGHTK/UoQQeMEZMd3M4+PNYKh7ot1nmjXPB0hqpBSF2UktdUnFf7gCfc1eeIIIuzLacUGe5CnEjNQ2uu3Oye36Dc9MnM+EEEydxzGaVK5kueOVwtKLzrpI/1kNuukYDgqN7Msm1gl7J/AkrdAeeWRIsSkn8PgQ7Dgzg7ABST6Gkvoh4XmHHReSKOca7ulcc/qqZPjpXdKpjjvHTq6LeErEIkQpW9s5Fv4cl4OxgB832KC5Oasf+ZOg+1T5owOMt/XUq6Ra4U+fmEFh6FHJ/DD37uP2448L9eMpEs2dZX+FGZTy3/eTh/8II3YdO6TB2YWwPiEthBHeSGtH0lR5z7+TdPAB/T+fPO4+M0lc8GS4g3VOJY/fWNjYMBVuX7FNv/WuA5+2hjLNe4LQWR9xK2hlkUi6O6RYcOjTWOgA7aKrQZAtg/Ur7kqsnm++URESeqJ8HE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(39830400003)(366004)(376002)(71200400001)(6512007)(8936002)(66446008)(66556008)(8676002)(26005)(2906002)(83380400001)(6916009)(316002)(15974865002)(54906003)(6486002)(36756003)(86362001)(76116006)(2616005)(5660300002)(6506007)(186003)(4326008)(64756008)(66476007)(966005)(66946007)(478600001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dkprcVFDUU83SURYWEhjWkEyWEd0Tkc1dXV4eWgxLzhvYzdDMDU3eFRTcEVh?=
 =?utf-8?B?Tko5d29mQlFnMnhoS25ycEJtbXNYQ0ZEOERaVko1RkFRMnJkMW1qakEzcGVn?=
 =?utf-8?B?RzVqZGx3Tlpib1U0blRhNmxhcDM3SXF2U0IyM3QyTGlOUFlIeHJCWVZiRjZX?=
 =?utf-8?B?SE5OT0p4aGRlUEIzbE5oVDNmcmRDc2d2V0NmaVZJOHlhNjNQVzlMSEtsaFN6?=
 =?utf-8?B?eC95ZFV5Q01yUDNQS0c1TXJSRFY3R3B2ci9Vbzgxc3ZtRlpOaUZCT1dRT0px?=
 =?utf-8?B?YStFWmRtd29oc09ZS0c5NXk5YTg4WU5JV2JMNWxIRDdKNTYvRFhPUW5IRVR5?=
 =?utf-8?B?UEFGbXBCQnpEZHArbm9sb0s1dXBzRUphbEVnU2xDbXJXNExRQlBHLzUybkZO?=
 =?utf-8?B?aTZBVGxSL0Ewd1BPSmhrU1RIanIra0ZVdkhYd01vYUgwR3FRWTZ3dGg4S1JF?=
 =?utf-8?B?eDBYOVFoelF6cENXbmNaSXVXbUNSanRQWFNXWk1EMHZTVStIU25YZTdUU2JQ?=
 =?utf-8?B?b0tGd3BTSi8xTUhNMmxCMWJyRkFkRVh2bDlzb1FrZEExdjdkd1FjSkMraGRK?=
 =?utf-8?B?bVRMN1lUZzB2NDF5aDdTTWxkZUt6NlViQ0dBRWhoRWZCUWlyRy9yUUtmT3lo?=
 =?utf-8?B?dVVhSEtmRzROSHEwSDh2dEdRdTN5NFB5RkprM04rdEdJZk1hY0pKWGMzWktt?=
 =?utf-8?B?azlLRmY4blRpd0NwNTYwdlU5b0NRb3F2WFVnaEZlN1FzT0tSeWNONi9wTFlX?=
 =?utf-8?B?d0d2c1BMaXppNERNZDVLR1VucEhESUc0bmh2OGNSN3B1OXliKzBIQUJRRjhj?=
 =?utf-8?B?WXV4aWhQMDJaZlNadFBHd3VlYnYrdmJWMjFkQW1BN2Y4L2Y2ZE03ck9yZzMv?=
 =?utf-8?B?WjVwejNtZzNDNDNhSDNqc1Irb1ZDVXVJMEUxT0RCR2p1eWtKcmNqNW96NDc3?=
 =?utf-8?B?QVQ2ZEl0c3BQem80aVUzbVZYdlMxYnBVTU41MTU1TStVdW9JWnFZb2pwUUFp?=
 =?utf-8?B?MEJXakdTVmVST0poQ0JybHl3SEZmeno3NmlSZ0VFVS9ZaWpBWWNnZ2lPajly?=
 =?utf-8?B?aFEycDZYck1ZMTk2Z29HTHE1OWJwdVJCYW9CQlVEVUpRb09XbFpuWUhyWUNx?=
 =?utf-8?B?NnBCaEpLZUc2N214a1lBQUpqcENpR21xRm9hbTdUOThvQkJHdGpYQVF5UDRn?=
 =?utf-8?B?cDNWU051T2hxQUVUMmdJWldvMUx5eWMydDc4SExSZWxDZVJDcFlIc1h1M21N?=
 =?utf-8?B?aUVMa1IyUVkvcU9OQUxXaERvdHZQYW1sNWNWZ0s0eVlzT1pOWWJIS2lnNGdp?=
 =?utf-8?B?aXlOYmVzMzJDSHVIdVVrWU05OUJJdmtpOEtuWC9Oa2JBSno5YnNJU3RhZmRV?=
 =?utf-8?B?UlYxQzJVck1lTi90UDBvV0xiY1hqNjJTZmtYRW1WSDNnaDc3bGo3dWFncVFJ?=
 =?utf-8?B?ZzFnMWYyZWpEcmJMYXBhMVhJemlkSDcvSWFIVk1VOTVra3pMVGs1WkhyS1kr?=
 =?utf-8?B?UWk2RmdMOGUxTlIrbDNRbVA2MEhkVjNXdUVrako0VjM0cGNXYzRrVmRPOFdZ?=
 =?utf-8?B?ZDJjaFR2dHhuSENIL0tOc2JQc2RRQ0kzdHljaFRza1ZQcEcreFJXUkJjZFhp?=
 =?utf-8?B?ZURDLzdkeHAyT3llaXN1T2lxOWVkSWx0U0ZJZEVCc241UHd6ZnUvV29WMDZw?=
 =?utf-8?B?ZEFDaC9KOFhPMnJ5YVY2aDVJYUpVcnl0dzkvR1EzQWdLclVtK0pML1o3eUk5?=
 =?utf-8?Q?YcyPRn9kYaQL/ZbtfLVpGXZfyEl7niC00fFvylf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D072121AF2E95445A77E0CCE30BF402E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed61c76-c9c1-4628-4b88-08d8d29dbe50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 17:10:21.6007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfsV6/IOGKbSK7H+9rZcJznKR1+dBnwkr+XT0SKbmA0BQPfGS3PwBbfSc56+XuTJXBeCkXEc70VkFwCnhzAEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4761
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTE2IGF0IDE2OjI3ICswMDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGV5IFRyb25kLQ0KPiANCj4gPiBPbiBGZWIgMTMsIDIwMjEsIGF0IDM6MjUgUE0sIHRyb25kbXlA
a2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IFVzZSBhIGNvdW50ZXIgdG8g
a2VlcCB0cmFjayBvZiBob3cgbWFueSByZXF1ZXN0cyBhcmUgcXVldWVkIGJlaGluZA0KPiA+IHRo
ZQ0KPiA+IHhwcnQtPnhwdF9tdXRleCwgYW5kIGtlZXAgVENQX0NPUksgc2V0IHVudGlsIHRoZSBx
dWV1ZSBpcyBlbXB0eS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3Qg
PHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+IA0KPiBMZXQncyBtb3ZlIHRoaXMg
Zm9yd2FyZCBhIGxpdHRsZSBiaXQuDQo+IA0KPiBJJ2QgbGlrZSB0byBzZWUgdGhlIHByZXZpb3Vz
bHkgZGlzY3Vzc2VkIE1TR19NT1JFIHNpbXBsaWZpY2F0aW9uDQo+IGludGVncmF0ZWQgaW50byB0
aGlzIHBhdGNoLg0KPiANCg0KSG1tLi4uIEkgdGhpbmsgSSdkIHByZWZlciB0byBtYWtlIGl0IGlu
Y3JlbWVudGFsIHRvIHRoaXMgb25lLiBJIHdhc24ndA0KdG9vIHN1cmUgYWJvdXQgd2hldGhlciBv
ciBub3QgcmVtb3ZpbmcgTVNHX1NFTkRQQUdFX05PVExBU1QgbWFrZXMgYQ0KZGlmZmVyZW5jZS4N
CkFGQUlDUywgdGhlIGFuc3dlciBpcyBubywgYnV0IGp1c3QgaW4gY2FzZSwgbGV0J3MgbWFrZSBp
dCBlYXN5IHRvIGJhY2sNCnRoaXMgY2hhbmdlIG91dC4NCg0KPiBJbiBhZGRpdGlvbiB0byBEYWly
ZSdzIHRlc3RpbmcsIEkndmUgZG9uZSBzb21lIHRlc3Rpbmc6DQo+IC0gTm8gYmVoYXZpb3IgcmVn
cmVzc2lvbnMgbm90ZWQNCj4gLSBObyBjaGFuZ2VzIGluIGxhcmdlIEkvTyB0aHJvdWdocHV0DQo+
IC0gU2xpZ2h0bHkgc2hvcnRlciBSVFRzIG9uIHNvZnR3YXJlIGJ1aWxkDQo+IA0KPiBBbmQgdGhl
IGN1cnJlbnQgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggaXMgbm93IGluIHRoZSBmb3ItcmMgYnJhbmNo
DQo+IG9mIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Nl
bC9saW51eC5naXQvDQo+IHRvIGdldCBicm9hZGVyIHRlc3RpbmcgZXhwb3N1cmUuDQo+IA0KPiBU
aGlzIHdvcmsgaXMgYSBjYW5kaWRhdGUgZm9yIGEgc2Vjb25kIE5GU0QgUFIgZHVyaW5nIHRoZSA1
LjEyDQo+IG1lcmdlIHdpbmRvdywgYWxvbmcgd2l0aCB0aGUgb3RoZXIgcGF0Y2hlcyBjdXJyZW50
bHkgaW4gdGhlDQo+IGZvci1yYyBicmFuY2guDQo+IA0KPiANCj4gPiAtLS0NCj4gPiBpbmNsdWRl
L2xpbnV4L3N1bnJwYy9zdmNzb2NrLmggfCAyICsrDQo+ID4gbmV0L3N1bnJwYy9zdmNzb2NrLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDggKysrKysrKy0NCj4gPiAyIGZpbGVzIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3N1bnJwYy9zdmNzb2NrLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL3N2
Y3NvY2suaA0KPiA+IGluZGV4IGI3YWM3ZmU2ODMwNi4uYmNjNTU1YzdhZTljIDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3N2Y3NvY2suaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bGludXgvc3VucnBjL3N2Y3NvY2suaA0KPiA+IEBAIC0zNSw2ICszNSw4IEBAIHN0cnVjdCBzdmNf
c29jayB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIFRvdGFsIGxlbmd0aCBvZiB0aGUgZGF0YSAo
bm90IGluY2x1ZGluZyBmcmFnbWVudA0KPiA+IGhlYWRlcnMpDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oCAqIHJlY2VpdmVkIHNvIGZhciBpbiB0aGUgZnJhZ21lbnRzIG1ha2luZyB1cCB0aGlzIHJwYzog
Ki8NCj4gPiDCoMKgwqDCoMKgwqDCoMKgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc2tfZGF0YWxlbjsNCj4gPiArwqDCoMKgwqDCoMKgwqAvKiBOdW1iZXIgb2Yg
cXVldWVkIHNlbmQgcmVxdWVzdHMgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqBhdG9taWNfdMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2tfc2VuZHFsZW47DQo+ID4gDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBwYWdlICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2tfcGFnZXNbUlBD
U1ZDX01BWFBBR0VTXTvCoMKgwqDCoMKgwqAvKg0KPiA+IHJlY2VpdmVkIGRhdGEgKi8NCj4gPiB9
Ow0KPiA+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3N2Y3NvY2suYyBiL25ldC9zdW5ycGMvc3Zj
c29jay5jDQo+ID4gaW5kZXggNWE4MDljNjRkYzdiLi4yMzFmNTEwYTQ4MzAgMTAwNjQ0DQo+ID4g
LS0tIGEvbmV0L3N1bnJwYy9zdmNzb2NrLmMNCj4gPiArKysgYi9uZXQvc3VucnBjL3N2Y3NvY2su
Yw0KPiA+IEBAIC0xMTcxLDE4ICsxMTcxLDIzIEBAIHN0YXRpYyBpbnQgc3ZjX3RjcF9zZW5kdG8o
c3RydWN0IHN2Y19ycXN0DQo+ID4gKnJxc3RwKQ0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBz
dmNfdGNwX3JlbGVhc2VfcnFzdChycXN0cCk7DQo+ID4gDQo+ID4gK8KgwqDCoMKgwqDCoMKgYXRv
bWljX2luYygmc3Zzay0+c2tfc2VuZHFsZW4pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9s
b2NrKCZ4cHJ0LT54cHRfbXV0ZXgpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoc3ZjX3hwcnRf
aXNfZGVhZCh4cHJ0KSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8g
b3V0X25vdGNvbm47DQo+ID4gK8KgwqDCoMKgwqDCoMKgdGNwX3NvY2tfc2V0X2Nvcmsoc3Zzay0+
c2tfc2ssIHRydWUpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBlcnIgPSBzdmNfdGNwX3NlbmRtc2co
c3Zzay0+c2tfc29jaywgJm1zZywgeGRyLCBtYXJrZXIsDQo+ID4gJnNlbnQpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqB4ZHJfZnJlZV9idmVjKHhkcik7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHRyYWNl
X3N2Y3NvY2tfdGNwX3NlbmQoeHBydCwgZXJyIDwgMCA/IGVyciA6IHNlbnQpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoZXJyIDwgMCB8fCBzZW50ICE9ICh4ZHItPmxlbiArIHNpemVvZihtYXJr
ZXIpKSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2Nsb3Nl
Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChhdG9taWNfZGVjX2FuZF90ZXN0KCZzdnNrLT5za19z
ZW5kcWxlbikpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRjcF9zb2NrX3Nl
dF9jb3JrKHN2c2stPnNrX3NrLCBmYWxzZSk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3Vu
bG9jaygmeHBydC0+eHB0X211dGV4KTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHNlbnQ7
DQo+ID4gDQo+ID4gb3V0X25vdGNvbm46DQo+ID4gK8KgwqDCoMKgwqDCoMKgYXRvbWljX2RlYygm
c3Zzay0+c2tfc2VuZHFsZW4pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnhw
cnQtPnhwdF9tdXRleCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PVENPTk47DQo+
ID4gb3V0X2Nsb3NlOg0KPiA+IEBAIC0xMTkyLDYgKzExOTcsNyBAQCBzdGF0aWMgaW50IHN2Y190
Y3Bfc2VuZHRvKHN0cnVjdCBzdmNfcnFzdA0KPiA+ICpycXN0cCkNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChlcnIgPCAwKSA/IGVyciA6IHNlbnQsIHhkci0+bGVuKTsN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc2V0X2JpdChYUFRfQ0xPU0UsICZ4cHJ0LT54cHRfZmxhZ3Mp
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzdmNfeHBydF9lbnF1ZXVlKHhwcnQpOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoGF0b21pY19kZWMoJnN2c2stPnNrX3NlbmRxbGVuKTsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgbXV0ZXhfdW5sb2NrKCZ4cHJ0LT54cHRfbXV0ZXgpOw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVBR0FJTjsNCj4gPiB9DQo+ID4gQEAgLTEyNjEsNyArMTI2Nyw3IEBAIHN0YXRp
YyB2b2lkIHN2Y190Y3BfaW5pdChzdHJ1Y3Qgc3ZjX3NvY2sNCj4gPiAqc3Zzaywgc3RydWN0IHN2
Y19zZXJ2ICpzZXJ2KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Zzay0+
c2tfZGF0YWxlbiA9IDA7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtZW1z
ZXQoJnN2c2stPnNrX3BhZ2VzWzBdLCAwLCBzaXplb2Yoc3Zzay0NCj4gPiA+c2tfcGFnZXMpKTsN
Cj4gPiANCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGNwX3NrKHNrKS0+bm9u
YWdsZSB8PSBUQ1BfTkFHTEVfT0ZGOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB0Y3Bfc29ja19zZXRfbm9kZWxheShzayk7DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzZXRfYml0KFhQVF9EQVRBLCAmc3Zzay0+c2tfeHBydC54cHRfZmxhZ3Mp
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3dpdGNoIChzay0+c2tfc3Rh
dGUpIHsNCj4gPiAtLSANCj4gPiAyLjI5LjINCj4gPiANCj4gDQo+IC0tDQo+IENodWNrIExldmVy
DQo+IA0KPiANCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpDVE8sIEhhbW1lcnNwYWNlIElu
Yw0KNDk4NCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMjA4DQpMb3MgQWx0b3MsIENBIDk0MDIyDQri
gIsNCnd3dy5oYW1tZXIuc3BhY2UNCg0K
