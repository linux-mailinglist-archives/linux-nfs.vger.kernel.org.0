Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B934AFF5B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 22:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiBIVp1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 16:45:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiBIVp0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 16:45:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2119.outbound.protection.outlook.com [40.107.95.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA0C03BFF4
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 13:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEYp1x68VPkLrWiB8prv4yPd+34mWimYZJ8NIPE0In/8eWJGJei6bQEp8VL3QeBEybD93SI/zcDUVBZHERjx8Tb2F6pU60tmLZj830fYWGlBgLQhwSRJHN7RxMIIL8yogCvzX4sahlhO3+v3Hsznqn4awmLafMk9E4ZRHbIiFpGLSQFXMYohoE8RdiM1a6xMXsJlHwbdgsCLfNPnCIVCVkoodT5mqt+YG/ZfkivP/ZBpnZC7vRz+Y0+Z3tmu2L2wtcvixlQ8zV767P//14TftOmRa3DifBCAtKmxWPrH8Yoj2BoRT7yyLsj4yp1gfkqsYCjiK9hjESTVga8BEnrdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwn2LsL/I8NCj3mxCy0q/8FYwjJAkmrkDn5Y/1VUXuc=;
 b=A+bGq1DU4TFoEa1mi6FAwhCAl1vtVfdVo52IBz4tYWPAU0jEYdTgpYL4XZanDLsYGl7ENDZicde2yOReY5no3PO68guIZTKsjfcxw7kUtAOEKu29TfkXqdm+X2jjO3s09IB6TCLMyWWcdiBBw9B2IMmEsWep2f1X+3PkktIZRIdTVxrCIKsKH4no5izN/rA37vJoI8DnS7pHQzzvpqxvSQSE+Wzk+tocu9DGDuTzBqyo63HO5KNC4BuBV7FD96fG7IVIKgFZoNywaujSvYc6Eo9OHpWK8yPhBKaJ/JlFVe+XnLdyP7wRgbdIRiMk4iagTFynMhJyuMyawbNIJM5lmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwn2LsL/I8NCj3mxCy0q/8FYwjJAkmrkDn5Y/1VUXuc=;
 b=Ola9QgobTL1qO1M+0A2Zav2Bc+zcBupAMT+/lYeyMnu4ckeYw53bs0P0ul+4PNDD+avmSG/4bmc/vFevQNGtI6JtbHK4SHU1xgRbLmmDybHJyotT96Nam0Rmh62Mt+BLOWMFTwrEvIO/4IwlI1Sse6wHBcFTHHWngTq8mG2clic=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3944.namprd13.prod.outlook.com (2603:10b6:208:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8; Wed, 9 Feb
 2022 21:45:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 21:45:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "steved@redhat.com" <steved@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca7AZvv8GdXMU2A8wvOnFfYLayJ14OAgAAE+ACAADrbgIABqySAgAAGqAA=
Date:   Wed, 9 Feb 2022 21:45:25 +0000
Message-ID: <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>
References: =?utf-8?q?=3Cc2e8b7c06352d3cad3454de096024fff80e638af=2E16439791?=
 =?utf-8?q?61=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>      ,
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>      ,
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
         <164444169523.27779.10904328736784652852@noble.neil.brown.name>
In-Reply-To: <164444169523.27779.10904328736784652852@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a37cfb80-3f0f-4e5c-5173-08d9ec157b4d
x-ms-traffictypediagnostic: MN2PR13MB3944:EE_
x-microsoft-antispam-prvs: <MN2PR13MB3944B44B3AF09C9F4FD77D94B82E9@MN2PR13MB3944.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bh/xnltzwc6Pki85/FXRAhg6vftP4z9LTG7Kec2Y+LgBSa+3gwCaNos47JDMhvdstYOrOEOGVSP2I78q4HilABQiEPSmuLSNCQWGFVSK4Vwrf7nt2RHM61OTHi1QJLsMV5Phw+LYFKNANjmZZsyMpcDuaQBLkTMQV0W+mkLdveeqtYQ8+DFhsnMEt96lsI4jS4n1IKx6Z1NR5QyWc5swx+SLrkAcXr5jweU7PE0NgvcBh38aZmBtkipox/9+25s33oUT4kjw82yzUlXV1UNnEHVX3DOCqdWOFHBdMIbSjXulHmnDagvuHdlMih3dfoWGymnONeoLeO/q4L4+2hwLz9GZn11tX3CSeN3Jt+KX1jy8leWj26f+hJtjIZ3HSdq1o4Yrs6eXyzXWyVI5Yk60qp9cfqps8fN1F1Mb5rQncs6TlmiIoY0RMHLKWSfZGckU/xIJRX++PV8mHBh7BFXBhZsQ/AdbausXUXY4T7Ep7SyIEyRWHbP64PUciFwRwPICIWYHz7wtGPVAGWtHdk9jA76dlhVnbQlAQH8MMBVnSDqmhiTDHSO9t55TyDcmYrth24GI3TX2PIu333SpJoujsN4mfuiOezI5WvVXHgvcyQBWjbJ9Llf9evx7TR8PjWYXdUaUK8L2QRRX0JVvcszdWhrDfmMRloZxO1OuWS+38djDy9Z0kaj275SZlDp8TeWxWxMT+lqrE7YeDCQhJHusOBlgdbUdZv+eGzkKaru8Sj3BEqVa7Uo8DrVYpzJexfnNeH4N/wQaPGgyTquxWknF8ykIjz5/82EvR4jWItuGA2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66476007)(2906002)(508600001)(6512007)(71200400001)(6486002)(86362001)(38070700005)(2616005)(6506007)(122000001)(53546011)(26005)(186003)(4326008)(5660300002)(66556008)(64756008)(110136005)(54906003)(66946007)(316002)(76116006)(66446008)(36756003)(8676002)(38100700002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFFjakFWZDVJUlRtVEJManBsVnpNRFZwRW10MFl2c2xyM1pVZ09CTFk0MXd4?=
 =?utf-8?B?a2Mvbm5SZmw5UkliMlJSYzNFeWxjeGxXd0xZMWpuK1B4aGhnY2ZDQVhVSWFH?=
 =?utf-8?B?V01FaW4xZ2ZxakNGOEtDTDE2UFFIWVRTdEZOcDF2YzQ0YkwzYzErUU94N2xP?=
 =?utf-8?B?ais3SmpabVRndmNDR21pNkNrYnF2bUxXdXR6dkdyODVyc2dwTWRnWGhjOEFQ?=
 =?utf-8?B?a28rekNZZWc4RnlqdGZQNEFJdEc1QlZiRDQzemxKdmh0bW9jNkYrOE9LTlFN?=
 =?utf-8?B?UGZLY3Jad3JnLzlvZGd2b044TXcvRUtQY0pkcmp1ell6bSt6ejJ0alF0ZVQ1?=
 =?utf-8?B?Wk5tM0RHSjRtcGVwS0wwYWxNeWpkbk5rT0NtUWRCYTQ4RWN6b3NWeHlVSDh3?=
 =?utf-8?B?VVNxS2F6MExwSlJqRWlKSEJGcHNwN0U3UkxjNjduWE1oSE9KYmpQVGFmYWRY?=
 =?utf-8?B?S2Q1K2FVbm5QYVNwZFBBMEtNZXl3MFFVRi9wdTJ4cmpFS0tyZ3J2eXBrbC9T?=
 =?utf-8?B?ZG4zNlkrZmtLTU5IQi8vZStZOGJUbk4yQnA5RDhibFI0WXJPK3NEOGZUUHlF?=
 =?utf-8?B?Q3gzOWFoelBsdkNFNFRDNnZsRGdrb1VtNUlGR3QrR3JZajh6S0RHU3lYU3JG?=
 =?utf-8?B?bmY3SFlaNDhZbmhsY1FaUUFxRXdGTkZrcC9aUWtOcTdOb2JRaUljM1R3ZitL?=
 =?utf-8?B?UVN3UWRWVExlZ2FGUVFlNWtmTFM3NHRhQzRFU3NRQWhEelpxNDVJYjU2bThJ?=
 =?utf-8?B?bm5GSE5UaEFnU1Urd3BWSy95ODREK3ViTnJjRStuT2lSY2lXR2xIaGlON2g2?=
 =?utf-8?B?QlViSWJkZWxsRGhxRVh1bXBRenhrZnFEaUM0TDYvYjExWWIzS1kxT3NiYmVk?=
 =?utf-8?B?VG4wNUF4MWJ5aUZyRVI1SFVlU2ZMN2l2eEs0alg5YnFMODZ2UDYrV1lEUHBr?=
 =?utf-8?B?VkRTOUo3VUZ0M1RuTzBpVTNWMnhzaVNFNHlnT0d3YVBDdCtxNjFkdkhud1Vk?=
 =?utf-8?B?WG04WVZUQUdpUDJ4QlhUbThzcUZxelNZRnNqV0pZS1BTa3YrMHhQb0dRa295?=
 =?utf-8?B?dVQxSFNRODVxOXJONzErV0dtd29PVjRuWnF4ZlBDR0VIbWtxUnI0RnFvTkRC?=
 =?utf-8?B?TnZCOEV6dW1FeWl4VmF2d25PYTAycVExekxNSi92b25tL3dCNW9GWlA3cERu?=
 =?utf-8?B?QXF4TWlENE42cG9XUXZPanRkaUI3MUJESm1lVk40Q0kya1U2SCt2TEdQeFVz?=
 =?utf-8?B?SWNya3RSOHlma2lCK0hDSE9Sb1Ayc1dsTnEvZ3d1aXI5SVBrdFhhWWhCdjBE?=
 =?utf-8?B?aXhSenJDNnZrTXNPSmRLQUJhOG0ydFJqalh0TEJaR1crNkRaS2l0eUpqRUJs?=
 =?utf-8?B?U2FZSFJxU1FwVHB0ckhiVlUrSThqR0E4eHBHZGhkdjBZSjJyWkFwRDlmeklm?=
 =?utf-8?B?UHFqeStEL2kzSUFUK1dBVU44eUdjVVJTTFJaY0lqdW9Ga1AySEQ4Vnh0amRV?=
 =?utf-8?B?VjE2eTR1RXNMRFhMdUQzNzV2SWFmNVlsTSs2RkJxcmlVai93amtwSUhuTEJ3?=
 =?utf-8?B?dmxjdFVpbXFYT0R1TmRMVkxQeTlFODE0cVNNU2dsQkh3WmN4YXMzbHhJRzlo?=
 =?utf-8?B?THB2QnM3SjlDcm1kRHBMQjJoeGlvTkJhUTh5RmtBSDZWejc3RzlBVUR0Ky9C?=
 =?utf-8?B?V2czRFJoTmdPZzhnYy9Mc21oWWsvbEpid2hxZTZwUURHNWZmN0JLZDR4c3Z5?=
 =?utf-8?B?ZHFpaGF3NHhCWGVvQ25FTVlkZllUUlNmaGlLMko4OWpSMitSQ1d6UXVWZGh5?=
 =?utf-8?B?cDREaWlWOVJhNmQ2SHUrNDVZTGdmLzJFUWFLUnMxbnM1aUhLUU5ocGVsZzhz?=
 =?utf-8?B?aWxVSHd3VDU0eVAzWGFscHFyUmRFVWN1NFpRQ3owbzN2MzVtY3lqTGlLQ1dY?=
 =?utf-8?B?K0F5MC9lNDYzMkpTSGFyc0JPK3p1QUI5UlVjSVlFYzZNNytmcHpMaUQ1UFhF?=
 =?utf-8?B?bWZ6am5sRWtOTm42WUdHcFBVejRtaVYxTXZHSTNiNXhzZkt4Rnh3cFp6cC9t?=
 =?utf-8?B?bDhyRGxWd202aG0zWkxiRnVNUkpPRTBaSzVndTVLaVM1YlVrbTJSNTZKbGVT?=
 =?utf-8?B?dUU3cDFCZTc1T1N3Mnc3bGdhbXRjbEFkU2pKSGVGeHc1aWMvQnZ0cURhTnFD?=
 =?utf-8?Q?h2/CMYbFTEwIs1NsJdrRuUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA30B20AA2D42C43802940122B244A89@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37cfb80-3f0f-4e5c-5173-08d9ec157b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 21:45:25.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aLcGMnfjNKqxgMcyZkc4CxTDZ8qmuy6iYyMHDry0ojOKhxRUydjfD9xuJbT1u+ZtDncRsmoUO4FtVTk6JMmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDA4OjIxICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMDkgRmViIDIwMjIsIFN0ZXZlIERpY2tzb24gd3JvdGU6DQo+ID4gDQo+ID4gT24gMi84
LzIyIDExOjIyIEFNLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gOCBGZWIg
MjAyMiwgYXQgMTE6MDQsIFN0ZXZlIERpY2tzb24gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gSGVs
bG8sDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiAyLzQvMjIgNzo1NiBBTSwgQmVuamFtaW4gQ29kZGlu
Z3RvbiB3cm90ZToNCj4gPiA+ID4gPiBUaGUgbmZzNGlkIHByb2dyYW0gd2lsbCBlaXRoZXIgY3Jl
YXRlIGEgbmV3IFVVSUQgZnJvbSBhDQo+ID4gPiA+ID4gcmFuZG9tIHNvdXJjZSBvcg0KPiA+ID4g
PiA+IGRlcml2ZSBpdCBmcm9tIC9ldGMvbWFjaGluZS1pZCwgZWxzZSBpdCByZXR1cm5zIGEgVVVJ
RCB0aGF0DQo+ID4gPiA+ID4gaGFzIGFscmVhZHkNCj4gPiA+ID4gPiBiZWVuIHdyaXR0ZW4gdG8g
L2V0Yy9uZnM0LWlkLsKgIFRoaXMgc21hbGwsIGxpZ2h0d2VpZ2h0IHRvb2wNCj4gPiA+ID4gPiBp
cyANCj4gPiA+ID4gPiBzdWl0YWJsZSBmb3INCj4gPiA+ID4gPiBleGVjdXRpb24gYnkgc3lzdGVt
ZC11ZGV2IGluIHJ1bGVzIHRvIHBvcHVsYXRlIHRoZSBuZnM0DQo+ID4gPiA+ID4gY2xpZW50IA0K
PiA+ID4gPiA+IHVuaXF1aWZpZXIuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiDCoCAuZ2l0aWdub3JlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAxICsNCj4gPiA+ID4gPiDCoCBjb25maWd1cmUuYWPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgNCArDQo+ID4gPiA+ID4gwqAgdG9vbHMvTWFrZWZpbGUuYW3CoMKgwqDCoMKgwqDC
oCB8wqDCoCAxICsNCj4gPiA+ID4gPiDCoCB0b29scy9uZnM0aWQvTWFrZWZpbGUuYW0gfMKgwqAg
OCArKw0KPiA+ID4gPiA+IMKgIHRvb2xzL25mczRpZC9uZnM0aWQuY8KgwqDCoCB8IDE4NA0KPiA+
ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+
IMKgIHRvb2xzL25mczRpZC9uZnM0aWQubWFuwqAgfMKgIDI5ICsrKysrKw0KPiA+ID4gPiA+IMKg
IDYgZmlsZXMgY2hhbmdlZCwgMjI3IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiDCoCBjcmVhdGUg
bW9kZSAxMDA2NDQgdG9vbHMvbmZzNGlkL01ha2VmaWxlLmFtDQo+ID4gPiA+ID4gwqAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHRvb2xzL25mczRpZC9uZnM0aWQuYw0KPiA+ID4gPiA+IMKgIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0b29scy9uZnM0aWQvbmZzNGlkLm1hbg0KPiA+ID4gPiBKdXN0IGEgbml0Li4u
IG5hbWluZyBjb252ZW50aW9uLi4uIEluIHRoZSBwYXN0DQo+ID4gPiA+IHdlIG5ldmVyIHB1dCB0
aGUgcHJvdG9jb2wgdmVyc2lvbiBpbiB0aGUgbmFtZS4NCj4gPiA+ID4gRG8gYSBscyB0b29scyBh
bmQgdXRpbHMgZGlyZWN0b3J5IGFuZCB5b3UNCj4gPiA+ID4gc2VlIHdoYXQgSSBtZWFuLi4uLg0K
PiA+ID4gPiANCj4gPiA+ID4gV291bGQgaXQgYmUgYSBwcm9ibGVtIHRvIGNoYW5nZSB0aGUgbmFt
ZSBmcm9tDQo+ID4gPiA+IG5mczRpZCB0byBuZnNpZD8NCj4gPiA+IA0KPiA+ID4gTm90IGF0IGFs
bC4uIA0KPiA+IEdvb2QuLi4NCj4gPiANCj4gPiA+IGFuZCBJIHRoaW5rIHRoZXJlJ3MgYSBsb3Qg
b2Ygcm9vbSBmb3IgbmFtaW5nIGRpc2N1c3Npb25zIGFib3V0DQo+ID4gPiB0aGUgZmlsZSB0byBz
dG9yZSB0aGUgaWQgdG9vOg0KPiA+ID4gDQo+ID4gPiBUcm9uZCBzZW50IC9ldGMvbmZzNF91dWlk
DQo+ID4gPiBOZWlsIHN1Z2dlc3RzIC9ldGMvbmV0bnMvTkFNRS9uZnMuY29uZi5kL2lkZW50aXR5
LmNvbmYNCj4gPiA+IEJlbiBzZW50IC9ldGMvbmZzNC1pZCAodG8gbWF0Y2ggL2V0Yy9tYWNoaW5l
LWlkKQ0KPiA+IFF1ZXN0aW9uLi4uIGlzIGl0IGtvc2hlciB0byBiZSB3cml0aW5nIC9ldGMgd2hp
Y2ggaXMNCj4gPiBnZW5lcmFsbHkgb24gdGhlIHJvb3QgZmlsZXN5c3RlbT8NCj4gPiANCj4gPiBC
eSBmYXIgTmVpbCBzdWdnZXN0aW9uIGlzIHRoZSBtb3N0IGludHJpZ3VpbmcuLi4gYnV0DQo+ID4g
b24gdGhlIGNvbnRhaW5lcnMgSSdtIGxvb2tpbmcgYXQgdGhlcmUgbm8gL2V0Yy9uZXRucw0KPiA+
IGRpcmVjdG9yeS4NCj4gPiANCj4gPiBJIGhhZCB0byBpbnN0YWxsIHRoZSBpcHJvdXRlIHBhY2th
Z2UgdG8gZG8gdGhlDQo+ID4gImlwIG5ldG5zIGlkZW50aWZ5IiB3aGljaCByZXR1cm5zIE5VTEwu
Li4NCj4gPiBhbHNvIGFkZHMgeWV0IGFub3RoZXIgZGVwZW5kZW5jeSBvbiBuZnMtdXRpbHMuDQo+
ID4gDQo+ID4gU28gaWYgImlwIG5ldG5zIGlkZW50aWZ5IiBkb2VzIHJldHVybiBOVUxMIHdoYXQg
ZGlyZWN0b3J5DQo+ID4gcGF0aCBzaG91bGQgYmUgdXNlZD8NCj4gDQo+IEknbSBub3Qgc3VyZSBp
ZiB0aGlzIGhhcyBiZWVuIGV4cGxpY2l0bHkgYW5zd2VyZWQgb3Igbm90LCBzbyBqdXN0IGluDQo+
IGNhc2UuLi4gDQo+IMKgIGlmICJpcCBuZXRucy9pZGVudGlmeSIgcmVwb3J0IE5BTUUsIHRoZW4g
dXNlIC9ldGMvbmV0bnMvTkFNRS9mb28NCj4gwqAgaWYgaXQgZmFpbHMgb3IgcmVwb3J0IG5vdGhp
bmcsIHVzZSAvZXRjL2Zvbw0KPiANCj4gSSB0aGluayB0aGlzIGlzIHJlcXVpcmVkIHdoZXRoZXIg
d2UgdXNlIG5mczQtaWQsIG5mcy1pZCwgbmZzLQ0KPiBpZGVudGl0eSwNCj4gbmZzLmNvbmYuZC9p
ZGVudGl0eS5jb25mIG9yIGFueSBvdGhlciBmaWxlIGluIC9ldGMuDQo+IA0KDQpXaG8gdXNlcyB0
aGlzIHRvb2wsIGFuZCBmb3Igd2hhdD8gVGhpcyBpc24ndCBhbnl0aGluZyB0aGF0IHRoZSBzdGFu
ZGFyZA0KY29udGFpbmVyIG9yY2hlc3RyYXRpb24gbWFuYWdlcnMgdXNlLg0KDQpJJ20gcnVubmlu
ZyBkb2NrZXIgcmlnaHQgbm93Og0KDQpOUl8wOS0yMTo0MTowNyBob3N0IH4gJCBscyAvZXRjL25l
dCoNCi9ldGMvbmV0Y29uZmlnICAvZXRjL25ldHdvcmtzDQpOUl8wOS0yMTo0MTo0NyBob3N0cyB+
ICQgZG9ja2VyIGV4ZWMgLWl0IGY3ZGViYzA3OWY0ZSBiYXNoDQpbcm9vdEBmN2RlYmMwNzlmNGUg
L10jIGxzIC9ldGMvbmV0Kg0KL2V0Yy9uZXRjb25maWcgIC9ldGMvbmV0d29ya3MNCltyb290QGY3
ZGViYzA3OWY0ZSAvXSMgaXAgbmV0bnMgaWRlbnRpZnkNCg0KW3Jvb3RAZjdkZWJjMDc5ZjRlIC9d
IyANCg0KQXMgeW91IGNhbiBzZWUsIG5laXRoZXIgdGhlIGhvc3Qgbm9yIHRoZSBjb250YWluZXIg
aGF2ZSBhbnl0aGluZyBpbg0KL2V0Yy9uZXRucywgYW5kICdpcCBuZXRucyBpZGVudGlmeScgaXMg
ZHJhd2luZyBhIGJsYW5rIGluIGJvdGguDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
