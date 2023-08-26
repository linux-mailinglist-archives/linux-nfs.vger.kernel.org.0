Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD117897BB
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Aug 2023 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjHZPbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Aug 2023 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHZPar (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Aug 2023 11:30:47 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2132.outbound.protection.outlook.com [40.107.102.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E148B4
        for <linux-nfs@vger.kernel.org>; Sat, 26 Aug 2023 08:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw7luKyFVeXNZLDqZCkBW0n9/2iDHD8ClmGcHD8IPwEIubh9PjJwvHCa5JqDrOhiHj23NBNta1eWMfQQ0emG4PYPlx1c5oTGP/AaDjWwoR4hOufQHEAoMFQi74mrhw+kTF1gqriSFgCvspudlS/iMT3iJGJyL9I1a+lhDlmOQg0KllXCuCPY/5X090fK3hMMp7QZznp4TNtHkxF2KLbrKh6i7SWa7SAvtRf7lhlOcuStCp6/MHW2fjAcFczFwMG8UR09oEGORijERLBeXpABxQQP6JH99W1VSl79/KHjJh3fvkz15uf2U+nkIc5SCEnAVv9awKVlwwH842gOP3NsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uGbb0rePRdXLFWA1QlnwHw4dGcktWmRkhUFHZa593k=;
 b=ZL4T61FJ2sTUqLNQ0IXgddxrwlRTSt/J1D4ZBkjdSVWSHgbAXZlyfRIkS8Q1dH7uHWHFDoge5j0AgywT3xk0o9dxTJN47whQssdk39hqTPQGaHKnPdyVuNc08VRETBqb1iSWwCvU8QPr5Ocltk9K2L490a23DPtn+QVzu+WC4rZJxKYh6Bz0IT1LRalTXPq6wcK9RrlCw53L04xF6BYwUe7oJL2xM12uv3xG68b4Yc+/d8CCEA4zedXDiTxZ0gPqYzGop4SwXC55vPTu2WYp2Kl1c6ze1DX/Qk52AIxlYvTYy4UzbKQg0aVSjzvohl0OSJC5YNzCR2+iadTJ5EMJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uGbb0rePRdXLFWA1QlnwHw4dGcktWmRkhUFHZa593k=;
 b=bFb8qYzYJ162KFfkQGELVB/GHT8gi7Y5inNnTQLntEsnWh7aKfN5Wm6GTS3LT2I3st7JafQ38PnDCSb3ZhskGIc9v2HMz2ZSumhKLRqVU61N+uL2LeTFmpVmLM/hvZGeqJB2U6IxMEbzSB6PnBKeqJCPEsU/KLiL4RUUSUJiB2k=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4581.namprd13.prod.outlook.com (2603:10b6:408:12a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 15:30:40 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 15:30:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "cattelan@thebarn.com" <cattelan@thebarn.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Thread-Topic: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Thread-Index: AQHZ1hDQ1xwLiwfK/kC2UFfMPJTnDq/7Mc0AgAA8mQCAATngAIAAEB8A
Date:   Sat, 26 Aug 2023 15:30:40 +0000
Message-ID: <59f26502253a5bc3e359a676d24ed12c7181fee3.camel@hammerspace.com>
References: <09b207aa-3670-90e8-9a04-1c35c1397a0c@thebarn.com>
         <11a5110b-0769-de07-10a4-d266dbb8c5c0@thebarn.com>
         <cb402253376f2939761169acce1b730bae0e9628.camel@hammerspace.com>
         <56022b0e-08c1-f1da-5509-4e5e9f5a4f7c@thebarn.com>
In-Reply-To: <56022b0e-08c1-f1da-5509-4e5e9f5a4f7c@thebarn.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4581:EE_
x-ms-office365-filtering-correlation-id: e8fb97d5-d701-474e-23d7-08dba64967a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThWLUu+iTcH5jEkTFm9bQUtBaURlboqgSVyVtCH72oPQPE+fMYH9uQg9w3XlGmxAYMYduXLt98zd6TOQbYjNJuwJnmY5swNIevGSrOdFNVtn+zWPPd+hmRaheNJBo1tMAWaP4hWE2OObW2xvbG0IHwu4l6KwtQcJVnJItKGm1j4W+TZ9g76IWi0n+fd/Qq7NEuzmIVh0OLW+/+r+kFqfxzPme7zjS5q5EVj2s14OtA04A7GjPHySDupW8Mmt+jtSbCV+FtFfQKtXB0SVcwleYvbDvm0h40lkfsnakCxQCRlho7c4u976nijLc6jyO+wIFg6JsBA/Du3Ms1lOVh6ZMtZSyh01iD/g+vjTeuwKQitd8QTp/XA7JWt5v8fsKgeHC6DgKtHONIkHnXEsq4OYimged8QatfUFNnVXbx5A1ctnLeXvjwdjLUrMfQkAOEzKdwdT7/P3ztcPJayhBXjGXy+L4A4DDXEqCvI8DV6JncRRR4C8EMgWH+8u1ZrnuvirEYTdqAyhfQf40hPs7aj8hWynNHMD6sZqwKX5Uva8ago9gf4/AgHK420UrEaBLB7qOeI8aG8sZ7ztAYnjRYFDyurpDshkQ0OGuyVpqnkqCuEPTUOnLvRu7hSYSeKSwU/REtjzmFxEYDMW+2aHuBSC9hnHOxLrLz+fAFyFe2hYwkv+f9EZsApIxkSDftD8vELgOxQwc6E8JuuwLP4ieUV8TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(396003)(376002)(366004)(346002)(1800799009)(186009)(451199024)(76116006)(110136005)(66946007)(64756008)(66556008)(66476007)(66446008)(316002)(966005)(478600001)(122000001)(38100700002)(38070700005)(41300700001)(2906002)(86362001)(36756003)(5660300002)(8936002)(8676002)(26005)(2616005)(83380400001)(53546011)(6506007)(6486002)(12101799020)(6512007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTljNjZ0UjZqNHEvNkV5Nkpsei8yQ0o5WTFvY250aHlFcjZ3R014eWZXU2Rm?=
 =?utf-8?B?Q0dmc25nYmtqbWFldEZaMDZhQ2JvSGFyV0Z5N1ZqdkRmeFFVb1hEbzVxSjFF?=
 =?utf-8?B?RUJ6cVEzdDdhZGlNYXUxWjE4bC9XL0RTTmwvc3VCY0hBeDB4Uy81MXpQWFA3?=
 =?utf-8?B?T2VIdjBBUEJYTUtTdGRxd2FrYjRhZGxtRGhvWUVZZlM1eTR3R3pFQ3J0bnVE?=
 =?utf-8?B?M1lKRk9RSjRrSXl1MlFjL2hoMnNKZkVpTlFzWktZOHBPNVBFckMya3FaOXJR?=
 =?utf-8?B?OWlqcHFRYTJFNXhNQTlremdwUnJSczVOclllTjN2NU5RMTVqQ0VPSWhNTFRV?=
 =?utf-8?B?RkMxTjJ5WGk2Y21TMkJzdmxpTWl3K01TYTZoSWhJNlJBTzZsYUFPVTNhQ3hE?=
 =?utf-8?B?dlF5cGZ1NXkvdkE0ZkFkLzIxeU1qZnlzZytxMG11bWNURnhGUWd4M3lLNExW?=
 =?utf-8?B?Rk1LbkFRU3pvUTY0cVExWG9TWUczY2I1cVhVS2tVUVh0SE9qT1ZvbmJScFZ1?=
 =?utf-8?B?SjJFdWEvUkh3SHZvaTl2VFRQTDh2eS94RCtsSnJmK29nbVdnTW9qUU0rdzNU?=
 =?utf-8?B?MXZqTVd2UCtXS2EyWU5tdDhyRXorUGtxMDRIbjJLZytCaEdNc0pVdnRta0ww?=
 =?utf-8?B?cERnZmRsSXlubk5sSFZhQXZIOWd3VFZoalExUmF2VkxaZDlIYno4akxPTTEx?=
 =?utf-8?B?K1JlbFREUGU2SlptaGpGRnZETGlHTnNZT2NDLzdodXMvbEgxOU5NZ3o3L3I4?=
 =?utf-8?B?Z1JITEpQcFVERkU5Qm1ZSHByRjAzOXZDcmlud0gvbnpqVG55R3V0UmxHbEFy?=
 =?utf-8?B?bWE3NGlSTTVTVWUycG9qQkw2U09pYlNkcmRKQWNtcXhkUG52TmNkdzlyY0Jx?=
 =?utf-8?B?a1hRWlExa0VETHpnYUQ0QjJSTkZqTGRwMTRDcjhTWW1yVTZJU092alkxdXFr?=
 =?utf-8?B?MGxZUGRzbDVGYnB5djE1V1N3M1V6OTVrL1Z2TSttK2pabW0reGEwOVRxbnhC?=
 =?utf-8?B?V2ZWU3grbXc2VmxzaDI5ZUJ1N3FkU0dKSUd6SEtEcXB4c3FhLytydi95WjNX?=
 =?utf-8?B?ei9iVHkwdno1S3V2UWFCdWFacHJOVnQ5cGJaNEZVMFpacm5NMnpvQ3pKYlRu?=
 =?utf-8?B?NzRuOHFOZENCdncvTHJNYWUyZGJMS1RGbk9BNUNHUGpEdVFjcGN5N1V0dnpm?=
 =?utf-8?B?WklGdkpkQlpGNDhVT2NBZmtqMGx1VnNhSENIVmp1TmZMVU8wd0xTV0kzM0hK?=
 =?utf-8?B?VDNlR0dELzhQcGtCYlFUQWUxN2QyNVpoY3dQeXg1MGNYRGg3enJjeGFoaVM3?=
 =?utf-8?B?Y3RCTHhINitWUFZQVjVmdkxxMnBCRytjc3dXaGxlckpFWlhYTmlod3h6RnJj?=
 =?utf-8?B?NFFocEtscWRoeVBQOFNLY3pHT3I2cGFiS3hrS283bHYyajJHeVppbnJ3RkNw?=
 =?utf-8?B?TU9EZlJzRjdTdG1hNTd6YlVPbWpRN2VpK2MyTHBqMC9pa0g0N1phbkN4VTRl?=
 =?utf-8?B?SEJGcFQ5VTBRSERnSjAxQ1M1RStxbjNJcmxrUjN3SXNTY2NRSWJFV1lkeVBl?=
 =?utf-8?B?Y2Y5VE1iaW03MDhjRTBKVUtuOTRYem10ekRqbWtMbGs2bGFjbGhwZXJrSDAy?=
 =?utf-8?B?VUtISi9KcXh4Zk9SN0N6QlJ4UlZpZUozWHFHdWZMdGZvSjFwVS95QjBaS0tq?=
 =?utf-8?B?dDJ5TnhiM1FjNmZFTElSL2ZWanJhb25kd3NOeWhyMEtjNnRCTmQ3YjFkbmJG?=
 =?utf-8?B?Tmt3d1V1ejdPTGE5VGE4NG90emZJU05Ic3dpRXZaZzh4cWVIZ3BkR1F2YXZ3?=
 =?utf-8?B?U1Q2MCt4Q0VOSUk0VVRjQTdNeGxFclBBRUpTWlo1VXpjbGNObE4rdmVNbnJB?=
 =?utf-8?B?MjdpeHF0RUlidTBKQUVETlFvaWJXdWprR1czM3VOZXNBZ0tvNnNqeXBTT0lB?=
 =?utf-8?B?d2IveGtMTmRvVVJxcmpZK2xYQnRXL25tQnRmZTdML0Y5RlVLNCtOT0Fya3RK?=
 =?utf-8?B?amx3ak4welRQMjNUa0oxdkNkQWVLMjUvVVVkRHkxMTQ1S1lzSU40MkFVejA4?=
 =?utf-8?B?RmJUYm9LZEQ5T0hRaHM3OWg1eEIzdldPektsb2MzQ3lHc2pSOXpNLzA3aTBZ?=
 =?utf-8?B?SWgvZ3Y2M2wwU0srZFh5QTYzbjlMcWV6STd0YlROay9VMFh6cUZqSjZCQWN1?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC0BA39BAAD4D942BA05B1F5E2B13D2A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fb97d5-d701-474e-23d7-08dba64967a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 15:30:40.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAV/1D9RZEn6S5amnT2J38lbKoZMqx9LqttzIYfP3m/unU1+wx8qUe5XaOolm5XJPmF3uRh3C6YI2RmITYbHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTI2IGF0IDA5OjMyIC0wNTAwLCBSdXNzZWxsIENhdHRlbGFuIHdyb3Rl
Og0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGNhdHRlbGFuQHRoZWJhcm4uY29t
LiBMZWFybiB3aHkgdGhpcw0KPiBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiBPbiA4LzI1LzIzIDI6NDkgUE0sIFRy
b25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gPiA+IE5GU3YzIHNlcnZlcnMgYXJlIGFsbG93
ZWQgdG8gZHJvcCByZXF1ZXN0cywgYW5kIE5GU3YzIGNsaWVudHMNCj4gPiA+ID4gYXJlDQo+ID4g
PiA+IGV4cGVjdGVkIHRvIHJldHJhbnNtaXQgdGhlbSB3aGVuIHRoaXMgaGFwcGVucy4gTkZTdjQg
c2VydmVycw0KPiA+ID4gPiBtYXkNCj4gPiA+ID4gbm90DQo+ID4gPiA+IGRyb3AgcmVxdWVzdHMs
IGFuZCBORlN2NCBjbGllbnRzIGFyZSBleHBlY3RlZCBuZXZlciB0bw0KPiA+ID4gPiByZXRyYW5z
bWl0DQo+ID4gPiA+ICh1bmxlc3MgdGhlIGNvbm5lY3Rpb24gYnJlYWtzKS4gRm9yIHRoYXQgcmVh
c29uIHdlIGRvIHNldA0KPiA+ID4gPiBSUENfVEFTS19OT19SRVRSQU5TX1RJTUVPVVQgb24gTkZT
djQgYW5kIGRvIG5vdCBvbiBORlN2My4NCj4gPiA+ID4gDQo+ID4gPiBXZSBoYXZlIGJlZW4gZG9p
bmcgYSBidW5jaCBvZiBkZWJ1Z2dpbmcgb24gdGhpcyBpc3N1ZSBhbmQgdGhlIGtleQ0KPiA+ID4g
cG9pbnQgLyBwcm9ibGVtIHdlIGFyZQ0KPiA+ID4gcnVubmluZyBpbnRvIGlzIHRoYXQgYmVjYXVz
ZSB0aGlzIGlzIGEga2VyYmVyb3MgZW5hYmxlZCBtb3VudA0KPiA+ID4gd2hlbg0KPiA+ID4gdGhl
IGNsaWVudCBkb2VzIGENCj4gPiA+IHJlLXRyYW5zbWl0IGl0IGVuZHMgdXAgZ2VuZXJhdGluZyBh
IG5ldyBNSUMgaGVhZGVyIC8gY2hlY2tzdW0NCj4gPiA+IHNpbmNlDQo+ID4gPiB0aGUga3JiNSBj
b250ZXh0DQo+ID4gPiBzZXF1ZW5jZSBudW1iZXIgaGFzIG1vdmVkIG9uLg0KPiA+ID4gDQo+ID4g
PiBJZiB0aGF0IHJldHJhbnMgaGFwcGVucyBiZWZvcmUgdGhlIG9yaWdpbmFsIHJlc3BvbnNlIGlz
IHJlY2VpdmVkDQo+ID4gPiB0aGVuDQo+ID4gPiB0aGUgbWljIHZlcmlmaWNhdGlvbg0KPiA+ID4g
ZmFpbHMgc2luY2UgdGhlIGNsaWVudCBpcyBub3cgZXhwZWN0aW5nIGEgcmVzcG9uc2UgdG8gdGhl
IHNlY29uZA0KPiA+ID4gcGFja2V0IGFuZCBub3QgdGhlIGZpcnN0Lg0KPiA+ID4gbWljIGhlYWRl
ciB2ZXJpZmljYXRpb24gZmFpbHMgd2hpY2ggdGhlbiByZXN1bHRzIGluIGFuIEVBQ0NFUw0KPiA+
ID4gZXJyb3INCj4gPiA+IHdoaWNoIGVuZHMgdXAgYXMgYW4gSU8NCj4gPiA+IGVycm9yIGF0IHRo
ZSBhcHBsaWNhdGlvbi4NCj4gPiA+IA0KPiA+ID4gV2hhdCB3ZSBoYXZlIGZvdW5kIHRoYXQgaXMg
aXQgZWFzeSB0byByZXBybyBpbiBvdXIgZW52aXJvbm1lbnQNCj4gPiA+IGFkZGluZw0KPiA+ID4g
YW4gaXB0YWJsZXMNCj4gPiA+IHJ1bGUgdG8gZHJvcCByZXNwb25zZXMgZnJvbSB0aGUgbmZzIHNl
cnZlciBmb3IgNTUtNjMgc2Vjb25kcy4NCj4gPiA+IExlc3MgdGhhbiA1NSBzZWMgYW5kIHRoZSBy
ZXRyYW5zIGRvZXMgbm90IGhhcHBlbiB0aGluZ3MgcmVjb3Zlcg0KPiA+ID4gTW9yZSB0aGFuIDYz
IHNlYyBhbmQgdGhlIHJwYyBjb2RlIGdvZXMgZG93biB0aGUgcmVjb25uZWN0IHBhdGgNCj4gPiA+
IGJlZm9yZQ0KPiA+ID4gZG9pbmcgdGhlIHJldHJhbnMgYW5kDQo+ID4gPiB0aGluZ3MgcmVjb3Zl
ci4NCj4gPiA+IA0KPiA+ID4gSXQgc2VlbXMgbGlrZSBrZXJiZXJvcyBlbmFibGVkIG1vdW50cyBz
aG91bGQgYmUgdXNpbmcNCj4gPiA+IFJQQ19UQVNLX05PX1JFVFJBTlNfVElNRU9VVCBzaW5jZSBk
b2luZw0KPiA+ID4gYSByZXRyYW5zIGNoYW5nZXMgdGhlIEdTUyBjaGVja3N1bSBmcm9tIHRoZSBv
cmlnaW5hbCBjaGVja3N1bS4NCj4gPiA+IA0KPiA+IA0KPiA+IE5vLCB0aGF0IGlzIG5vdCBhbiBv
cHRpb24uIE5GU3YzIHNlcnZlcnMgYXJlIGFsbG93ZWQgdG8gZHJvcCBhbnkNCj4gPiBpbmNvbWlu
ZyBSUEMgcmVxdWVzdCB3aXRob3V0IG5lZWRpbmcgYSByZWFzb24sIHNvIHR1cm5pbmcgb24NCj4g
PiBSUENfVEFTS19OT19SRVRSQU5TX1RJTUVPVVQgd291bGQganVzdCBsZWFkIHRvIGNsaWVudCBo
YW5ncy4NCj4gSSBjYW4gc2VlIHRoYXQgZm9yIFVEUCBidXQgaXMgdGhhdCB0cnVlIGZvciBUQ1Ag
YXMgd2VsbD8NCg0KWWVzLiBGb3IgaW5zdGFuY2UgdGhlIExpbnV4IGtuZnNkIHNlcnZlciB3aWxs
IGRyb3AgcmVxdWVzdHMgaWYgdGhlIEdTUw0Kc2VxdWVuY2UgbnVtYmVyIGxpZXMgb3V0c2lkZSB0
aGUgd2luZG93IChubywgSSBkb24ndCBrbm93IHdoeSBpdA0KZG9lc24ndCBqdXN0IHJldHVybiBS
UENTRUNfR1NTX0NUWFBST0JMRU0pLiBJdCB3aWxsIGFsc28gaGFwcGlseSBkcm9wDQpkZWZlcnJl
ZCByZXF1ZXN0cyAoaS5lLiByZXF1ZXN0cyB3YWl0aW5nIGZvciBhIHJlcGx5IHRvIGFuIHVwY2Fs
bCkgb25jZQ0KdGhleSBzdGFydCBwaWxpbmcgdXAuIEZpbmFsbHksIGlmIHRoZSBrbmZzZCByZXBs
eSBjYWNoZSBzYXlzIHRoYXQgYW4NCmVhcmxpZXIgdHJhbnNtaXNzaW9uIG9mIHRoZSBORlN2MyBS
UEMgcmVxdWVzdCBpcyBzdGlsbCBiZWluZyBwcm9jZXNzZWQsDQp0aGVuIHRoZSBuZXcgcmVxdWVz
dCBnZXRzIGRyb3BwZWQuDQoNCj4gV291bGRuJ3QgdGhlIHJwYyBjb2RlIGJlaGF2ZSB0aGUgc2Ft
ZSBhcyB2NCBhbmQgc2V0dXAgYSBuZXcNCj4gY29ubmVjdGlvbg0KPiBiZWZvcmUgZG9pbmcgdGhl
IHJldHJhbnM/DQo+IEF0IGxlYXN0IGluIG91ciBleHBlcmltZW50YXRpb24gaWYgd2UgbGVhdmUg
dGhlIGNvbm5lY3Rpb24gZG93biBmb3INCj4gbW9yZQ0KPiA2MyBzZWNvbmRzIHdlIGNhbiBzZWUg
ZnJvbSB0aGUgcnBjIHRyYWNlcyB0aGF0IGlzIHdoYXQgaXMgaGFwcGVuaW5nLg0KPiBPbmNlIHRo
ZXJlIGlzIGEgbmV3IGNvbm5lY3Rpb24gdGhlbiBvbGQgbWVzc2FnZSBpcyBpZ25vcmVkIGFuZA0K
PiBwcm9jZXNzaW5nIGNvbnRpbnVlcyB3aXRoIHRoZSBuZXcgc2V0IHJlcXVlc3QgLyByZXNwb25z
ZXMuDQo+IA0KPiA+IA0KPiA+IFRoZSByaWdodCB0aGluZyB0byBkbyBpcyB0byBqdXN0IGZpeCB1
cCBycGNfZGVjb2RlX2hlYWRlcigpIHRvDQo+ID4gcmV0cnkNCj4gPiBpbnN0ZWFkIG9mIGZpcmlu
ZyBvZmYgYW4gZXJyb3IgaW4gdGhpcyBjYXNlLg0KPiBTbyB5b3UgYXJlIHRoaW5raW5nIHRoYXQg
cnBjX2RlY29kZV9oZWFkZXIganVzdCByZXR1cm5zIEVBR0FJTiBpZiB0aGUNCj4gY2hlY2tzdW0g
ZmFpbHM/DQo+IFdoYXQgaGFwcGVucyBpZiB0aGUgR1NTIGNvbnRleHQgYWN0dWFsbHkgZ29lcyBi
YWQgKHRpbWVzIG91dCBldGMpDQo+IHdvdWxkbid0IHRoYXQgYWxzbyByZXN1bHQgaW4gdGhlIGNs
aWVudCBnZXQgc3R1Y2sganVzdCBkb2luZyByZS1zZW5kcw0KPiBvdmVyIGFuZCBvdmVyPw0KDQpJ
ZiB0aGUgR1NTIGNvbnRleHQgZ29lcyBiYWQsIHRoZW4gdGhlIHNlcnZlciBpcyBzdXBwb3NlZCB0
byByZXR1cm4NCmVpdGhlciBSUENTRUNfR1NTX0NSRURQUk9CTEVNIChpZiB0aGUgc2VydmVyIG5v
IGxvbmdlciBoYXMgY29udGV4dCBmb3INCnRoYXQgaGFuZGxlKSBvciBSUENTRUNfR1NTX0NUWFBS
T0JMRU0gKGNvbnRleHQgaXMgc3RhbGUgZHVlIHRvIHRpY2tldA0KZXhwaXJ5LCBldGMpLg0KDQpJ
ZiBpdCBqdXN0IHRpbWVzIG91dCwgdGhlbiBzdXJlbHkgdGhlIHJlcGxheSBjYWNoZSBzaG91bGQg
ZW5zdXJlIHRoYXQNCml0IGdldHMgcHJvY2Vzc2VkIHF1aWNrbHkgYWZ0ZXIgYSByZXRyeSwgbm8/
DQoNCj4gDQo+IEknbSByZWFsbHkgbm90IHRoYXQgdXAgdG8gc3BlZWQgb24gc3VidGxldGllcyBv
ZiBORlMga2VyYmVyb3MuDQo+IA0KPiBPaCBub3RlIHRoaXMgaXNuJ3QgZXZlbiBrcmI1cCBqdXN0
IGtyYjUgbW91bnRzLiAobm90IHRoYXQgc2hvdWxkDQo+IG1hdHRlcg0KPiBhbGwgdGhhdCBtdWNo
KQ0KPiANCj4gLS1SdXNzZWxsIENhdHRlbGFuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
