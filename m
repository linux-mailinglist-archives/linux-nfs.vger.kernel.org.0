Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA770D2B3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 06:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjEWEEX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 00:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEWEEV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 00:04:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2110.outbound.protection.outlook.com [40.107.93.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5148690
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 21:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5eJYjGDEiitEsCRQS8jNb4iU/uXTMub1UBRzKeb7UTSs+eNFlzVyE2QbhgPd35DKDJ6ZZiAl9R+GluViSJer+hIYDEPUr93mp+IXMUh6MtFdTjTZOevBfaFfflMe+897VAYCgFzCINFCCPlzB6k5Yv2aLzmJIARRd2ry5ClDPtOoLTxg/AfKaHZ7wMAuU3tfinaDNMLiEGt+dkPdHFxU3LdDSw31XGoNvkV58cfI3lhWghSTwwLkwPqzAPQ35OAzEvNmHfk3NwowCeOy4iHroPDWPaqw9xv4gp90xqMTYeGX89EHJ4Wb4JFQluoaou4Zu9s4T+44EP7BdiLQbWrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haQC+V9jeDqxrS6u8QN1ySGlbLc5rbdCppLZFGyw/34=;
 b=bhUZ16NNoZ6wi9brES/bVHbj+ve3ke0KGzd0ybB+0WhI+/MP3+io9/dW7QHzkP2yz6iodV2N08JKoEY1F88U4gTB8oQy294lHOCOfMze+ds3E8PL2EkR2BMjE1Ez7YBOTIFO5PUlrNOVVZeOHp4jaC2kRtgvZTUiUDvG3jZkraZ/yK9tGLo97sj+fv/KQgPc/3aKmnmzck31e7d3Plhe/za1+AE09azJinGoj1aO9ZAVq7WFi+tLR1AHaG93+dEhYLtgxdCtLjCyJSoBJwrU3TxuI2sGTs/E23aM95sRbQkGHnz3cNu2+eC0Ii+ZP0EUQLk3pjh3GyLaJE2Ew720uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haQC+V9jeDqxrS6u8QN1ySGlbLc5rbdCppLZFGyw/34=;
 b=TrilJ3j0i0BU8nE6wey8eyyTa04sz04WxlgODw7z2nFjrJwjJfuw6icHTqV/BWOIUAgU5xAvSjSMtQThSLOznVuM9tbdhIp38W6538lR803fFP/TB1vAMlcQbbGpeGY0jUaDkFxVbCNhPsFk6yrmA8O9keKGejoRcRDe13gPEHc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB6147.namprd13.prod.outlook.com (2603:10b6:806:333::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 04:04:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 04:04:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "cel@kernel.org" <cel@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] SUNRPC: @clnt specifies auth flavor of RPC ping
Thread-Topic: [PATCH] SUNRPC: @clnt specifies auth flavor of RPC ping
Thread-Index: AQHZjPNpWQgKmEw/iEabHxBcQqYXcK9nJUOAgAAYGQA=
Date:   Tue, 23 May 2023 04:04:15 +0000
Message-ID: <23daa1801e4105f6f3f02e7c446f44278b6c3a20.camel@hammerspace.com>
References: <CAFX2Jfk9up-eyLhe7s65E6+vBTjXrATREFoYJVkCBLAT_56o2g@mail.gmail.com>
         <168479039188.9346.7280595186663128472.stgit@oracle-102.nfsv4bat.org>
         <ZGwnBY11KWX21nzC@manet.1015granger.net>
In-Reply-To: <ZGwnBY11KWX21nzC@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB6147:EE_
x-ms-office365-filtering-correlation-id: ebad3942-f9ed-4388-eaa6-08db5b42c67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjoW5JjCAcyLFXKPM2jeaWCyAQxnBNvh3IImv3hHXfBTtMv6DIBdxUhknuAMhkgDOyP8qIcmn8muuy2DLGycauUAQMEwpGad1ewXlo5/9R1qxQX68bu1acbKuB1VVGGIwOUIqoI1tl9z8cV0xHE71dLFatg/IbIy+dfvB23MJ2r896Iwy0Ud7WrzrS3PNeDZgX2hpkjXc2g8RR0X7z+IOQ5haS+GF2XHRJICxWNOPREnvJ/LtyBwIyD2jiahjW9o6AaTNisaAdkp5XCliyPtT9hn9OgGQvAL7eUYdS17rHtyGaZ6Q1AP778QcKCahlFAqa7Qx6dRxHGOebzNYIGrBlCEalFSxcwAnnpNREUgos8DPb6EwuQt7SydF1Aa38OZznjVg3cI81Oy8XZsKmgc8hqXq2dLX2zsOkbXzmhc3PnjvKfHlYSdWAJJkPBllfNJufYEHOZA7iKhjtUOC34KydA6I5Mp7lnQKnGghGLpJRo0WS/f68ykTw8fS6djIgyKG0x1eluG/yc64jMy3ZB1dlnAD54xTygdhHq/dcGtk6jhDwi2B3kNOQMqDXQhx6iiafwEZiHyerj6nvWcws5RLSjwPgQNa06fiUMd3wAf68lHFi4j/KuiUlkx58HxTXYl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(39830400003)(366004)(451199021)(41300700001)(2616005)(83380400001)(186003)(2906002)(4326008)(76116006)(91956017)(66446008)(66946007)(66556008)(66476007)(6486002)(316002)(64756008)(478600001)(110136005)(54906003)(71200400001)(5660300002)(6512007)(26005)(6506007)(8676002)(8936002)(38070700005)(38100700002)(122000001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmIzSGRZOFFNTk5sb0ptUk5XQ3lWLzRvdWVrcnJPR1dpRW44WTNRZzVNKzhI?=
 =?utf-8?B?UmVVSGtZbDhnTGRqYnpsRFVZcENOYU5WOHpUY3JOTkhyOHdQcDUvbW5iaWRQ?=
 =?utf-8?B?enI2YjZNekpVNkFOcEhUWCs5VDZvaVNYWW1Ddkw3VUVzMk13ckhvejd6ZTNP?=
 =?utf-8?B?Tm01WDBtbGdTVjIrRU9Db0NWdHh3L2FLdm9FT1ZJV2daTU83MUgyN0JpdXNZ?=
 =?utf-8?B?aTFieDlLQzZrY0dPb3VleGxMR3RES3FqaTJjaHlEQVArVk1LWmI4ZVFMWU0w?=
 =?utf-8?B?dnUyWHB2YVJCaVE3eGRhNmNaYWIyNGt4aGUzYit2U1ZFcVVzcXNRVkJXRDJy?=
 =?utf-8?B?T3NJT3ozSktuVHRZd2xtVVVFUXh1ckNETFdMK1BVMUVKQStzc2E5LzhWbStr?=
 =?utf-8?B?VDVzL0FrZ1RlaitkUy9xK1RXL2ZDLzRQQ2hkeUYxT1NGMGsyM1p5SnBnWCtP?=
 =?utf-8?B?R1hNTGdiWittdWo4ZGNheFpVKzdhZ1k3SzNUWXJFUUVjK0k5bEdDME9NaGk5?=
 =?utf-8?B?ajBMNzM3SXErSnpMSm93c3JuWmxlRVErenNEYkw4VUtFd0pVUGxTRHo5d3dE?=
 =?utf-8?B?aVNoR1V2OXplTGRVNmhLVG04WmdGNGMzWUJKK2U3cStRZkE4Y3FodTlSN1VY?=
 =?utf-8?B?Um9PR2w2b0FackZKaTRZWnNZa3gxZWRDak81ZHJSVWp3UDZ0ZEJMeWVocDI5?=
 =?utf-8?B?TTZVcThCMXdqM0g3ZnlBSmU0U0F1L1U5dlpiOFBOUUVQTTJrWkNZeVpzMXRL?=
 =?utf-8?B?NGhQVU54MEJBeVF0Y0EyRGxLV3VqTzAzMFRyTDJjMkZIYjJTTW9aN25OdlEy?=
 =?utf-8?B?eFRBMHg5RWhlZnhyQTljNFBsRU1RUVdPS0VobjZxMDdYdGg3T0Zxd1R6aEJJ?=
 =?utf-8?B?ZmU4amI1TnhudGdlWFJ6TkJEUDNweWh1QytpKzVOVHhBYTVPM0QrS2tYNCtz?=
 =?utf-8?B?VUx4VXpZTGtBZHNaS2tGaGhjWG1UQ0taU3luaFduWWwrUjBQdjRKRG92Uy9N?=
 =?utf-8?B?dFNnZjlyb0o3QjdaZUpPSWJtYXpTSmRjYWNNcWw5dHVZKzJvTFhjcnY2aXpr?=
 =?utf-8?B?cG51d0NOdUFSSE9EekI4VVA4ZUdZam9kSFNpRWRiRFZQNm81WHJFdzRaaldK?=
 =?utf-8?B?M3dScTExaWU5MWQrYWZxU1EyMWRmRWIyYkZZOUJKYysyL2p1NjJDcTJ5THZk?=
 =?utf-8?B?MmlMb3RDNk1sUUMxOHdsVlZ6cGtQWWdheFg4MEJncFk1eVI5bHFZT0xsR3N0?=
 =?utf-8?B?RkYvdkFTb3hQZ01jemdFWUtGU1lKa0drOEIzY01QWndRUGtYeitZaCtxc0dU?=
 =?utf-8?B?TmxWMCtFUlo1MlBkaGlmTm5BNWdlelo4VHRkWHI2VkJTYUdJU0lYQW43b3NN?=
 =?utf-8?B?b1VQSDdRRWZjeDlEYVUzbTVFL2hCZUVJdTd5K28wcTBCdFh3bElrajVySEkv?=
 =?utf-8?B?ZUhkRkR0VmhMTmRwdjdiY3huNWh1cFlIeWtUdW96VCtLZnZhREFldkhlMG03?=
 =?utf-8?B?eFk3dWIvY1dEVUtNejN2TFROeXlSakZqNC9kZU0wMEd1dVJjZnJkSk53aDdW?=
 =?utf-8?B?MEViRXJ0NGNXY0E3N1ByMGZPWllaaTVNMnFObW9jdGFPYnJZcDVKenAvM3pm?=
 =?utf-8?B?OWFmVk04a3RiWmJIQkV0R09tbkxyNHBlYlBXVXlKcGZPa1hKeVg0RzAvMm9F?=
 =?utf-8?B?Zi9MejRHV0VIVFJycWEvaElySnFZYWNGemxHZFRZdmxJeVFyR1hzTGxBamsw?=
 =?utf-8?B?TnZCU3JmN1lFU2N1MndscGt1UXVnQnZhRnl2bXVTV3FnU3ZLK1FMOHl3bTBj?=
 =?utf-8?B?b01GMUI0b0dvZDY2aVkxaDFmL2YxT0lybG41Y3l6QWxMZytNVUIwQ3RJcFB6?=
 =?utf-8?B?em1sbDJnM3dMUlpjVnRjLzNrWjRNSUh2ejBsejFtL0xHZE9wamR1VDcxdjd0?=
 =?utf-8?B?VnZFZFRNK2lqd1JzTGxmSTVLZFZtdmhtajkzWDc5eWc1eEJaTGJ0K1BnN1Y3?=
 =?utf-8?B?UEJMM0VORXZKWXFwcGNCODgxTytlZUtCOHRWUkdZeEFRVjJDL0o2R3JvVmpn?=
 =?utf-8?B?bFBiVWEyWmwzbU1SaGh6ZzlOazdYc245Z1RXbTNGOEpRWXR6bTdaS0JOSGp3?=
 =?utf-8?B?Mm1rODRmc0o5VWtXYXZkNjA4YnE0RVJQTDV4UC9Hc0tGdjZESWcvcmhMRWNv?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2162779F0138A149958A7A6DF8EFCF26@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebad3942-f9ed-4388-eaa6-08db5b42c67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 04:04:15.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+sBvc/PCBhfvg55hBap9rV+jfi7ascrL5GWp6qJ/Og7ivsPTxDUsKpd9SEIdCTTKDIk6EqMW88XkWPC6RHkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTIyIGF0IDIyOjM3IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gTW9uLCBNYXkgMjIsIDIwMjMgYXQgMDU6MjE6MjJQTSAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3Jv
dGU6DQo+ID4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4g
DQo+ID4gV2hlbiBjb25uZWN0aW5nLCB3ZSBkb24ndCB3YW50IHRvIHNlbmQgYm90aCBhIE5VTEwg
cGluZyBhbmQgYW4NCj4gPiBSUENfQVVUSF9UTFMgcHJvYmUsIGJlY2F1c2UsIGV4Y2VwdCBmb3Ig
dGhlIGRldGVjdGlvbiBvZiBSUEMtd2l0aC0NCj4gPiBUTFMgc3VwcG9ydCwgYm90aCBzZXJ2ZSBl
ZmZlY3RpdmVseSB0aGUgc2FtZSBwdXJwb3NlLg0KPiA+IA0KPiA+IE1vZGlmeSBycGNfcGluZygp
IHNvIGl0IGNhbiBzZW5kIGEgVExTIHByb2JlIHdoZW4gQGNsbnQncyBmbGF2b3INCj4gPiBpcyBS
UENfQVVUSF9UTFMuIEFsbCBvdGhlciBjYWxsZXJzIGNvbnRpbnVlIHRvIHVzZSBBVVRIX05PTkUu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+DQo+ID4gLS0tDQo+ID4gwqBuZXQvc3VucnBjL2NsbnQuYyB8wqDCoCAxNCArKysrKysr
KysrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiANCj4gPiBEb2VzIGl0IGhlbHAgdG8gcmVwbGFjZSA0LzEyIHdpdGggdGhpcz/C
oCBDb21waWxlLXRlc3RlZCBvbmx5Lg0KPiA+IA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQv
c3VucnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+ID4gaW5kZXggNGNkYjUzOWI1ODU0
Li4yNzRhZDc0Y2IyYmQgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3N1bnJwYy9jbG50LmMNCj4gPiAr
KysgYi9uZXQvc3VucnBjL2NsbnQuYw0KPiA+IEBAIC0yODI2LDEwICsyODI2LDIyIEBAIEVYUE9S
VF9TWU1CT0xfR1BMKHJwY19jYWxsX251bGwpOw0KPiA+IMKgDQo+ID4gwqBzdGF0aWMgaW50IHJw
Y19waW5nKHN0cnVjdCBycGNfY2xudCAqY2xudCkNCj4gPiDCoHsNCj4gPiArwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgcnBjX21lc3NhZ2UgbXNnID0gew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAucnBjX3Byb2MgPSAmcnBjcHJvY19udWxsLA0KPiA+ICvCoMKgwqDCoMKgwqDCoH07
DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJwY190YXNrX3NldHVwIHRhc2tfc2V0dXBfZGF0
YSA9IHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnJwY19jbGllbnQgPSBj
bG50LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucnBjX21lc3NhZ2UgPSAm
bXNnLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuY2FsbGJhY2tfb3BzID0g
JnJwY19udWxsX29wcywNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmZsYWdz
ID0gUlBDX1RBU0tfU09GVCB8IFJQQ19UQVNLX1NPRlRDT05OLA0KPiA+ICvCoMKgwqDCoMKgwqDC
oH07DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNfdGFza8KgKnRhc2s7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoGludCBzdGF0dXM7DQo+ID4gwqANCj4gPiAtwqDCoMKgwqDCoMKgwqB0YXNr
ID0gcnBjX2NhbGxfbnVsbF9oZWxwZXIoY2xudCwgTlVMTCwgTlVMTCwgMCwgTlVMTCwNCj4gPiBO
VUxMKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoY2xudC0+Y2xfYXV0aC0+YXVfZmxhdm9yICE9
IFJQQ19BVVRIX1RMUykNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmxhZ3Mg
fD0gUlBDX1RBU0tfTlVMTENSRURTOw0KPiANCj4gT2J2aW91c2x5IHRoaXMgbmVlZHMgdG8gYmU6
DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRhc2tfc2V0dXBfZGF0YS5m
bGFncyB8PSBSUENfVEFTS19OVUxMQ1JFRFM7DQo+IA0KPiBUaGlzIGhhcyBiZWVuIGZpeGVkIGlu
IHRoZSB0b3BpYy1ycGMtd2l0aC10bHMtdXBjYWxsIGJyYW5jaC4NCg0KcnBjX3BpbmcoKSBzaG91
bGQgbm90IG5lZWQgdG8ga25vdyBhYm91dCB0aGUgZXhpc3RlbmNlIG9mIEFVVEhfVExTLg0KDQpM
ZXQncyByYXRoZXIgYWRkIGluIGEgc3RydWN0IHJwY19hdXRob3BzIGNhbGxiYWNrIGNvbm5lY3Rf
cGluZygpICg/KQ0KdGhhdCBrbm93cyBob3cgdG8gY2FsbCBycGNfcGluZygpIHdpdGggdGhlIGFw
cHJvcHJpYXRlIGNyZWRzLiBGb3IgdGhlDQpBVVRIIHR5cGVzIG90aGVyIHRoYW4gQVVUSF9UTFMs
IHRoYXQgd2lsbCBiZSBhIGdlbmVyaWMgY2FsbCB3aXRoIHRoZQ0KQVVUSF9OVUxMIGNyZWQuDQoN
ClRoZW4gbGV0J3MgZ2V0IHJpZCBvZiB0aGUgUlBDX1RBU0tfTlVMTENSRURTIHdhcnQgYWx0b2dl
dGhlci4NCg0KPiANCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgdGFzayA9IHJwY19ydW5fdGFz
aygmdGFza19zZXR1cF9kYXRhKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUih0YXNr
KSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKHRh
c2spOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSB0YXNrLT50a19zdGF0dXM7DQo+ID4g
DQo+ID4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
