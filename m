Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30717EE79A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 20:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKPTjb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 14:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKPTja (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 14:39:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131018D
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 11:39:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqnUHuzZybpAU1GFQiXNf6E1GbcdqHVxVw9ClsnhvtMwbWl2B18CdMQ4y3U1vqOZplJwwA/5xsX/IrPSw9iDDpKAxkDj0JPPBZjew16Wr5kDGqvcyKfqlBGVQXHU4O2tH423tEfwipF2kPGbyhtUDO6JfTV4hafea/Uzracu0O+CFk5wi2x1ceHdbBh4tTFdBQPZDC/nKIlVuHhEdaZEMC2HAALZazuifbgNbCo6DUO8bIEohhYpDjReWlsKkdzWzyV70QYpNlPvtb+1C+2On96fu9G834/iASknACumcSBfFVOL3fOL0dh1wCNYy8cv9/zjp0Ck+z7A2epNXt50pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzYK20p4Tu64gZnhukzH9XyJkc+IFgguwzjRO34UdiQ=;
 b=Eae9g3/40xImvCuHxGGcYmVzkLYF3iDQpNjKeD1w9Qw5KqYULv/MhAjMp5jSA4qDmqtDkHDVmRdPGAJxqKMWZ9OjJwF9HjNwN4ABoaJpSB1iouWEis2FzvKfT50t8pVQs2JsaM6NyV/83Zs4lrg2m3N8lbAqdY1N7FxtC1SWbzrb0ajJ5NXC173zjaDU8t7fnSMX8eRQ+bugrB/qZrHGT0pLyOHZruDhS485DdYcQHxbHpxERDKiDSwMr14kC2XyV4s1/cPmgqF4z3F8etvPnyBxUZuVANa1Fd3dbgMBK7G2U9YN2pBJdKtr+rqQpaSh/Hyjh9X2Xzt0cFDJWdUmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzYK20p4Tu64gZnhukzH9XyJkc+IFgguwzjRO34UdiQ=;
 b=Smg9a3FX4hGyvll6YJfpgoxHuHfRVs7BR51akMpwt33gqvwEUSF8IP9eqWvYsbmOVWJxD/slDFWQGxZQOn6poBOO+cXyyxvrt13pQkwn6m7PoN4KUThR7BB/gnz+bJiaOBw0J6qKxnFUTSfY8hb4U87pmsYTGTHvFOfNs6kdzro=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BY3PR13MB4993.namprd13.prod.outlook.com (2603:10b6:a03:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Thu, 16 Nov
 2023 19:39:22 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 19:39:22 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "martin.l.wege@gmail.com" <martin.l.wege@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Does NFSv4 close-to-open consistency work with server "async"
 mount open?
Thread-Topic: Does NFSv4 close-to-open consistency work with server "async"
 mount open?
Thread-Index: AQHaGFwxPXJ3FiHfkkqokvsQ2jTAZLB84IcAgAB38YA=
Date:   Thu, 16 Nov 2023 19:39:22 +0000
Message-ID: <be43b1cc2a66c8377fe97b99f14acaf5e19bfa66.camel@hammerspace.com>
References: <CANH4o6PU1p6NzS3X6ohGFPjzxKXr3gXn70s-VV+HSzAAPbWyvQ@mail.gmail.com>
         <08A8C65F-5755-41DC-B29A-DE168B23C968@redhat.com>
In-Reply-To: <08A8C65F-5755-41DC-B29A-DE168B23C968@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|BY3PR13MB4993:EE_
x-ms-office365-filtering-correlation-id: e58dcbd5-fd7b-45e5-5a48-08dbe6dbbbbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmTCrDOqJwhGANWwFxeXtJEG8lNd2iKLc++3LeNEDJ4zkZENM/FZ7AQQC4czVHfnzQjVTJBS25Ob0CIry2rPDRgSm9R+UuZtQCIHfC94V6iCXeBSy9iNvH9cPDB+6KusDEHryGCpCAbICkfKCnhbMeJ2QtY4C2i7ncq8LdcNMlGfMZyOMkCpd9lxRq3VQxzLdqtuaRG2gu5L7ly0gTlQG/MEjeOMpyttPKxxJmy41U4Q+Puh5PWk+EbxThVMcM4f3gS+q3q2wg7Q+gQVKjA/hXXm0QsWzv2HNLAF+mTT2ILgDABCUPftOD0BW1XkQvqjUBTuLEjOtgEj6OYyObnPAWS0UvW9UnAfEBo0xC1xX//enz1m3IOBkQS1S6qVIJ94s/q/FpCQXorSpbMOODtc21Aq1retw3X+5oPTHXbDMhVhqB9W7YLXPaOW9NjFvucv4RCsDY2FqVoZ+A2c2z+5KXS80pen8haiPKnUgtxotSm2lAZcxC8OgbosFDBecdfWczJ5d2TKqJxWLpdDC/zsDAcAfypkCVAAMIp47LEus3CBhauvWu+18AF/9kclZCHosoJFGrTo5za+bfCIYE15qz8VOvM9+0SyrFz/ZDKrs3IdB/bTnBa+gNbP2QHPzgRZfC8TlczqnliaTqpYR9Kn8pnd6q+15MkQl4UTGS3fy/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38070700009)(2906002)(5660300002)(71200400001)(2616005)(86362001)(41300700001)(110136005)(91956017)(66556008)(66476007)(316002)(6512007)(76116006)(66446008)(66946007)(83380400001)(64756008)(38100700002)(53546011)(122000001)(478600001)(36756003)(4001150100001)(6486002)(6506007)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2QyRXVyRmFOMU5jTHVRL2lIejI3Zlh3R0NlSW9xenpmZmdzVlM2NUZMam5n?=
 =?utf-8?B?N3NKaWlpSkNQREYrc0pybGI1Rmkvdit2RUh3R2YwL0pucWMzVGlUTXhuZ2Ju?=
 =?utf-8?B?R3VibEdEeUxlSDFqOXhlb3NqWDI2YStVa0lwOE5GaUl0VllKQi9SSUFxYWxn?=
 =?utf-8?B?OUIxK0dMWXRteis5QkRGenMyMkhHWTJreUFPcFlXUEhYMVdhSWY4Ukd6SmNM?=
 =?utf-8?B?QkRWcGxsSkN6N2VYK2tYVkFxY2RYZzVvM0NmV2o5RENFL2x5eFVSemxhaG9K?=
 =?utf-8?B?RFI4ZlBEOUVEMUhCZmVXZHNFRUlnQkhsWGJvMnNYa0wwSHBtZmw1cmpRaVFD?=
 =?utf-8?B?dGVucnNoaXExMUxnQzI4eXpmclZWNmplTG43YXMwanlFM2gveTlnejNsenp0?=
 =?utf-8?B?bGpSUWlmWFlVL3FBd0czUjZKT01KYWdLSDR5OE9BUVRNZ056Ujl2aXRPUTV4?=
 =?utf-8?B?MEVhajhiSDErZGpSVkZhaEFJaUVPblVwVVJVbVhwRTBJNnFEMFdXM1pHV3BJ?=
 =?utf-8?B?dktPR2lvMzJNS1lZZFA5MFN5dTJVL081MVRzSFZiNmVCREQ5b2psMzBpaXIw?=
 =?utf-8?B?ZjFNaWNRY3VxbnpRWWxYcFRLUGJQOUQrVzI4ZHF5Ync5dElTNURzdXNPNHN0?=
 =?utf-8?B?VUhwaFJhUU82M3dPd2dYZk5KSmVnSk9BdzM2N2Z1THBsYmN3Y0I2dC8zQ21T?=
 =?utf-8?B?RXRNVFVBMFA3ZnVSUndSK1VCUjU4d2k0bnNXaTNwODZZZGNBdDh4RmFzYWNn?=
 =?utf-8?B?MzFWeDR6ZDBBTm5oNWQ3MFhqUnUydnNzdjRLYjFzOHhBWWtFNzc2NHZFNFBQ?=
 =?utf-8?B?YXpNaFAyWHJwS290Z29XUm1HeE11S2JKY1NJYmFiYzdtRVJUd3FGS3V6Z282?=
 =?utf-8?B?V2dZb3ZHYjRQZjRQN1JWNVJoTFZnNUVIbUdTRWxLcnpIcjdPUmlWdTJITjBi?=
 =?utf-8?B?dGxQaU9aYysrYitsbVdDRjBSRTllTnltSEtKOU1GOTRnVENUUm5uUlVuQm45?=
 =?utf-8?B?UHp2NHhrUlFlek1JNlNneEN2WWZ6djl4NjdyVUJoRlhHa0RGU0JFODNQQlBo?=
 =?utf-8?B?MWVDMzBtT1FjS29YdTc0eTI4cWFzRW9EMGpTM1YyVkp6ejlBcnFOdkgxT2FU?=
 =?utf-8?B?YlpVVDc4TE10NHRkKytnakFZWUpuUm1FaUM0KytuOVVBN2EzV0NjMUMwR3FD?=
 =?utf-8?B?d1Vxek03R3N4VE9iMFd0VmptM1NOcnp2RVp0OFg2WE85U1p2VnNyL1g0RHM5?=
 =?utf-8?B?cEJsUERodlhpeVIvbkRkUDdyZHFEUnRSa0hIV1B4bFZrRUpXc1ZPS2dBeVRa?=
 =?utf-8?B?cktUUEhZaHV4MUN1cVZFWmZqbG4vdllmOW1CcVN2YzB2d2xxMndWUzFCVHR5?=
 =?utf-8?B?MndsYldzMTdVNWhQZ3NkZS9WUERlVy8xa2VjQ3hrcDZFVld2bExnMG9iL3l3?=
 =?utf-8?B?dkRqTENPemJOVFJNN1hYT3ZqNURubUlrYnYrWEtBN1ZQc2dDRmh1cC9BaGM1?=
 =?utf-8?B?Z3Rhblo5NGhQdExvVncvOGVmSUdDYXNXaHltMXpLaDRvdjBvRytvSG1ralF5?=
 =?utf-8?B?L0ozOTZvVSs0ZU1YRzRoYzJ4aVdUdWxrYkJvQitZQWhBWUt5TDFYSE14UnhN?=
 =?utf-8?B?eHlLcDFpNE5IakphWlMzZ2R5VERuTGJaY01CejI1cjFVTVgwUmk1NHBhSTIv?=
 =?utf-8?B?cmFhWnZ6OGl0TGNGbVQxdU4vbW93d0o3YWpCWFY2a2VnOVRlK1B1U1dUR1I1?=
 =?utf-8?B?TUd5UEtoaTBYZ1piOHVjdlY3THJhS2ZaSkR6MEwyczF0T1lZWU54WENUVmdJ?=
 =?utf-8?B?WTM5cDFiWUFrbFhUNUs2Z05yNHJMYS9VdktzK0d4cHZ1V3Z3bFNLcUNvNjg5?=
 =?utf-8?B?M2dZcmdieWZISUt0aTRTTTFlNGFjczZySzFUVkIrTVVYRTB5S3JsSEhZckpB?=
 =?utf-8?B?S3ZFTG9EVmpLR29PSTlOT1l2N2JMTDBOZVZ1RGtqYUpvZlI4US91NW5jUHkw?=
 =?utf-8?B?NWZScWJzd1RvcTNuUTFJaHBzSUswTHFGZk1OSEwzenU3TGNuRW1tZWVJZlRT?=
 =?utf-8?B?WndpVS83VmtGbjhPRk9TYTBkelc4bU1Ea3dWNTFLdmE0d1UxUVIvbFo0QmJ4?=
 =?utf-8?B?dDRNSzM0ejZ1OVFmU3V6Y0RQODVmN3VsWlZFMHhyMEhVVjYwd1AveUJKQUgy?=
 =?utf-8?B?ajVqbGdNT0lVWTgzRjhWaFRGSUk3YnJ6aGZkTWVjQWgwajJWNHBBRWFUVWRZ?=
 =?utf-8?B?NDZoZ0lLdEtESy95MjlVVGdIYTlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EEB3A93C7FE534FBCB64A4672BFC547@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58dcbd5-fd7b-45e5-5a48-08dbe6dbbbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 19:39:22.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbeO7SWRX9FL84EDbR0NZyOVtpHGm9g98mnTiw+D7bh7W0hlRatbSaOwCaK/CV+kMMX1l2fAs7NDG9/UtVNi0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTE2IGF0IDA3OjMwIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBOb3YgMjAyMywgYXQgMjoxMSwgTWFydGluIFdlZ2Ugd3JvdGU6DQo+IA0K
PiA+IEhlbGxvLA0KPiA+IA0KPiA+IERvZXMgTkZTdjQgY2xvc2UtdG8tb3BlbiBjb25zaXN0ZW5j
eSBvbiB0aGUgY2xpZW50IHdvcmsgd2l0aCBzZXJ2ZXINCj4gPiAiYXN5bmMiIG1vdW50IG9wZW4/
DQo+IA0KPiBZZXMsIEkgYmVsaWV2ZSBpdCBzaG91bGQsIGJ1dCBJIGFtIGxvb2tpbmcgYXQga25m
c2QgY29kZSBhbmQgSSB0aGluaw0KPiBpdA0KPiB3b24ndC4NCj4gDQo+ID4gV2Ugc2VlIHNldmVy
YWwgYnVpbGQgZXJyb3JzIGhlcmUgd2l0aCBwYXJhbGxlbCBHTlUgTWFrZWZpbGUgdXBkYXRlLA0K
PiA+IHdoZXJlIG9uZSBwcm9jZXNzIHdyaXRlcyBhIGZpbGUsIGV4aXN0cywgYW5kIHRoZSBuZXh0
IHByb2Nlc3MNCj4gPiBkb2Vzbid0DQo+ID4gc2VlIGFsbCBkYXRhIChsaW5rZXIgYXI6IGZpbGUg
dG9vIHNob3J0KS4NCj4gPiBCdXQgaWYgeW91IG1hbnVhbGx5IGxvb2sgYXQgaXQgdGhlIGZpbGVz
IGFyZSBPSywgYW5kIGNvbXBsZXRlbHkNCj4gPiB3cml0dGVuLg0KDQpJZiB0aGUgcHJvY2VzcyBk
b2luZyB0aGUgY2hlY2tpbmcgaXMgcnVubmluZyBvbiB0aGUgc2FtZSBvbmUgdGhhdCB3cm90ZQ0K
dGhlIGZpbGUsIHRoZW4gd2Ugc2hvdWxkIGJlIGFibGUgdG8gZW11bGF0ZSBmdWxsIFBPU0lYIHNl
bWFudGljcywgYW5kDQp5b3VyIHByb2JsZW0gaXMgbm90IE5GUyByZWxhdGVkLg0KDQpJZiB0aGUg
dHdvIHByb2Nlc3NlcyBhcmUgcnVubmluZyBvbiBkaWZmZXJlbnQgY2xpZW50cywgdGhlbiB0aGUg
Y2FjaGluZw0KaXNzdWVzIGNvbWUgaW50byBwbGF5LiBJZiB0aGF0IGlzIHRoZSBjYXNlLCB0aGVu
IGlzIHRoZSBsaW5rZXIgb3BlbmluZw0KdGhlIGZpbGUsIG9yIGlzIGl0IGp1c3QgdXNpbmcgc3Rh
dCgpPyBJZiB0aGUgbGF0dGVyLCB0aGVuIGl0IGlzIG5vdA0KcmVseWluZyBvbiBjbG9zZS10by1v
cGVuIGNhY2hlIGNvbnNpc3RlbmN5LCBidXQganVzdCBzdGFuZGFyZCBhdHRyaWJ1dGUNCmNhY2hp
bmcgKGkuZS4gcG9sbGluZykuDQoNCj4gPiANCj4gPiBXaGF0IGlzIHRoaXM/IE5GU3Y0IGNsaWVu
dCBidWcsIE5GU3Y0IHNlcnZlciBidWcsIGFkbWluIGVycm9yDQo+ID4gKGFzeW5jDQo+ID4gYnJl
YWtpbmcgY2xvc2UtdG8tb3BlbiBjb25zaXN0ZW5jeT8NCj4gDQo+IEhhcmQgdG8gc2F5LCBhIHdp
cmUgY2FwdHVyZSB3b3VsZCBzaG93LsKgIE15IGd1ZXNzIGlzIHRoYXQgdGhlDQo+IHNlcnZlcidz
DQo+ICJhc3luYyIgZGlzYWJsZXMgdGhlIHdyaXRlIGdhdGhlciBpbiBuZnNkX3Zmc193cml0ZSgp
Lg0KDQoNClRoZSAiYXN5bmMiIGZsYWcgaW4gL2V0Yy9leHBvcnRzIGRpc2FibGVzIENPTU1JVCBh
bmQgbWV0YWRhdGEgY29tbWl0cy4NCklPVzogaXQgaXMgYSBkYXRhIHBlcnNpc3RlbmNlIHRocmVh
dCwgYnV0IGRvZXMgbm90IGNoYW5nZSBhbnkgY2FjaGluZw0Kc2VtYW50aWNzLg0KDQo+ID4gQWxz
bywgaXMgY2xvc2UtdG8tb3BlbiBjb25zaXN0ZW5jeSBndWFyYW50ZWVkIGJldHdlZW4gZGlmZmVy
ZW50DQo+ID4gTkZTdjQgY2xpZW50cz8NCj4gDQo+IFllcy4NCj4gDQo+IEJlbg0KPiANCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
