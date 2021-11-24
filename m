Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2E45C98B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 17:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhKXQNb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 11:13:31 -0500
Received: from mail-dm6nam10on2123.outbound.protection.outlook.com ([40.107.93.123]:43137
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229829AbhKXQNa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Nov 2021 11:13:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXvOPYtjbqWjIEqWGGJBK0xxMQzPgwWTIoHvPQ1OIN71cb80/vIYPSsBtNUQ9nKtnnYzskQxO+b9mb1ua2Ns83lOQPgULRfq/gwQyq2YQp7WAOE5+of/AzzwpMMh6iAp/y21oMzhAR0XWjUpgNwZCAP9aOlJY95BT5I3i2JYU0elbldR2u1z7XezVpgxSrqsVzGLbhDjYA+U0dEkXw0iPt9al7Zz7NPRnEh/EKtjt2K7ZY0lOLZOnipiV0yOu5ie65NbQvof7vZA2/uYHwr1OH3K6Vk+4QtKVwZgQE5AbDIH/LU5liM0b74MUIWY9rv10FaQjzb4TzNT8FoJOP3vDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVnjlkSqAQ6q35En+h/CGm1GeekCi40jYXHjMrX7mSc=;
 b=TAKakbnJnFEEaodA2DwO5iK/QgGTODcXTqjOAW2f7ixQ1RyX+yQBETl2hdB7WMGzRDpSaUV32dn2bAlkcpFRX4D4wx/z0NMXZs2ZcGfoUptZp+g7kh/NafH57ZR0bGlcGAoStdmphiBZ5aMVsfHgRJ7KonA/tMetYJdpqpprn/l/e4rkiYElXFqxGqfW5FkPhJj0kedS51c8QESjV486k304Pu8siy7RscJMHeqZAkMuJ8Q7Oz406wwJRwjHYxK/qkGbrtVgWwKa01jA0EzcCKqwTCg+A4xRKrkdDDkdvgIbqJA7IYgnqnYhSWH5NzE3Qxh0JiqX2ucE9X9NGdnqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVnjlkSqAQ6q35En+h/CGm1GeekCi40jYXHjMrX7mSc=;
 b=M3UevZr3ZyoiYfnbFWs3nJD4Td48EvmcMmVJEv55Qt9c2KbBgHk/M6xdlLRQxhmDBS3R+A0H+iDQ8KQblTC7EIFKacAXXtEfkQZT5vivTgfyo5xqzK7ozlhG7yAKObxvjnJXEm75r2zSAyD4Ulvskh6l6yDNPQnTJjZXkE/hcdM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5114.namprd13.prod.outlook.com (2603:10b6:610:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7; Wed, 24 Nov
 2021 16:10:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 16:10:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "olivier@bm-services.com" <olivier@bm-services.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "carnil@debian.org" <carnil@debian.org>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Topic: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Index: AQHWn6R0BWW7FfEHY0ewFe9+CvNb36mUB/AAgAAVOICAAA6DgIAI+hOAgitf9YCAST4LAIAAZRgAgAMoGoCAAAhggIAAAvGA
Date:   Wed, 24 Nov 2021 16:10:18 +0000
Message-ID: <9d89ee19da0393bd9d2dd21092048ee10230094d.camel@hammerspace.com>
References: <20201011075913.GA8065@eldamar.lan>
         <20201012142602.GD26571@fieldses.org> <20201012154159.GA49819@eldamar.lan>
         <20201012163355.GF26571@fieldses.org> <20201018093903.GA364695@eldamar.lan>
         <YV3vDQOPVgxc/J99@eldamar.lan>
         <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
         <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
         <20211124152947.GA30602@fieldses.org>
         <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
In-Reply-To: <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79c573f4-e0cd-4c70-6789-08d9af64e8d1
x-ms-traffictypediagnostic: CH0PR13MB5114:
x-microsoft-antispam-prvs: <CH0PR13MB5114159B243FCD5F0C4582CCB8619@CH0PR13MB5114.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Om5uGc8pupz+zPQDYZapR3ON/943Qv/ZEE4Z/CvxdmCEAPjyV/FIZyNEmGpBW2/KkMgst4Vt1wgEEn95fSg/KL9ey4PtXshQos3Q2AnrgUlJDsy1WfXzg2PiHYy1OlC1rU9QD1fy9BhwwXcniDsoLYwlZmmrTKTFgWXw3NzmXTigJEBwp5We2V8Yt6ASx7LnpBAj2fyCTVcnDveCY8YBee+R7rYImm7TpmgNoKJnKDyGI8Tx835NkR3peifGuCNUDNDMlo7WjFdeVdDlvGzpV7K0yctu7O7kKWgT7RjQoRskkyO5wNgeXbtbMMw905qjmhbTpz6evRnwJPmNFJVjFhdikB+djnhJq58M2cP1cG8Q8r3UJ5P0pn2C5aSbA4g3l8pieu9sorx2gaO3HRWYUjrt03u5PSeEplpRVEE5REixNlgSBpf4p06D7qiFdNd7XK8oqD+sYxOQK2ZY8HqQJK2XEI7LJ1wQbE5YoBeGKxE9Q7v+mHqtUlgojQTHAZ2C9Dma5tZni0bbcS6hwezG2OD2gK2HSsMU240NZKobrGWai4+9zC1gI9e64TGky1VivijmTzujsatk76wV9eDtwXM1WbTpeu2PPRiQglPhgvZ/Cz8B3Ri4IlfE18Gim2iUNbQUXuj6WhGJCvGCGl2RhNruzadsYZ7m+qe8ahZEhlMU1hpJgVJw4LK1ToVXKtoqq0D52j4kLYy/43+nIXsLIklA0B010VOpqtTDUhjB9XjtMAJB6YoEhBELUFdGvvUMbJ+fv95zeMtETlY82nC7GyS7yYBvcOpFt6NPg8BIZC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(2616005)(64756008)(76116006)(2906002)(66476007)(66556008)(36756003)(966005)(86362001)(8936002)(8676002)(6512007)(6486002)(508600001)(66946007)(71200400001)(38070700005)(54906003)(26005)(83380400001)(4326008)(4001150100001)(186003)(316002)(38100700002)(6506007)(53546011)(122000001)(110136005)(66446008)(5660300002)(15974865002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkxVTzJQVkw4MWFZQ3JSUldqM2NXdjVOU0dmS0tCNDBkNEprRHZ2SXhjVnVV?=
 =?utf-8?B?bVpNemFnbkF1aTR0ZWt6U29KV3RBTDBwa2pnc0k0Y2NiZHQxY2RrOUhNd2Z0?=
 =?utf-8?B?dHpCTzlyUWJiNDVLUldkcGkrMTlNV3ErVXd4aWFKOHZJM3Y5U09oRnloZFVx?=
 =?utf-8?B?ekQvTFhoOVVNTnFHUGpvc3I1ZFBnR3RjRmVXOUxldG9OSUw4Y2FVa0pTMUND?=
 =?utf-8?B?b202RlRuazZiQnM5Q2pwVnRwOVRmRUFVNFR6M0JWLy95cVNPU2l4M204aml5?=
 =?utf-8?B?NmFSZDIyR0hVTTBNL0pGQ05seWtET1Vkd0kyU1hya0IxMTlyYVBFUTdNcVNR?=
 =?utf-8?B?bkpqdkFXdk1jQmxORDJyL1V3YVY0eFJ2YzVHM0EzVUE5cGRmeWNEYzVBNFV6?=
 =?utf-8?B?K29mZWorL2RxN3Q4T3VHRWFNcVZwVzQwQ0NFTkhxOXQ4eW5seExuNy9oSmNt?=
 =?utf-8?B?dEdsRWJhVUJDZzlVN3hCd25pWHdyZk5hUlJWck8xcnhMcTRjTzBid0o0OWJW?=
 =?utf-8?B?aGU0SStYN3NaRDJGTmR0UTVpTnZrZmpLWlBOSmRUNVAvdEpPbW5NT1Y4VnlT?=
 =?utf-8?B?eGhiNDBlSWY5elhCMmNVY3BaUmJmK2NXc2NPN3NyQkJkbko0dDRqdVNLTlor?=
 =?utf-8?B?dDVac0tEMzdLNExCUldhN05FZ0J5T0VuaklSN2dsWGVYendFS2srTHo5Tmhq?=
 =?utf-8?B?M2tMdE9TSFM4RkIreitKM3h0NVNzMFdSZkdRSjEzTWNDL0JnZ0w5SXcrZGND?=
 =?utf-8?B?MW5oQWhvVDNacjJMWlRURmxCRFlnVkFqM0ZmS2J3aWJVdkNoRHNTaUM0aEN3?=
 =?utf-8?B?SGFCK0NRWUF0NHNFUDBpaUZkc1ErdUlQZ3o4WE94YW5LWTMvNjh4ZjR4NFdO?=
 =?utf-8?B?N0c0Qkowcjh4M1NQR25BN1lXTFNPaTZxUE1kdVRGL2N5bTlsOVY1MjVoRHBD?=
 =?utf-8?B?Uk9XNjZPand0OGVWNGxPZEx1USs2QkUvMTVQY3BpVktQOWN3djlQTkgvZS9t?=
 =?utf-8?B?a0swNkNHZHFNY0k5VXVvMU1oaktkYStETUpabnFHY09Sbm1vTENiVVFxSW9k?=
 =?utf-8?B?ajE3RFVXcFBYa1RvSGxHYWNVZmMyMDdLZVc4bFF0U1JkTDlWTHowSEd5RUJX?=
 =?utf-8?B?Q3prSWppZUtUWUcvKy96MGFreUt4eGp5WnN1SXJ6Sk45dUFoZlF0Qm50VzVX?=
 =?utf-8?B?MnZJZFRuZmx0U0pqY2RmWGREdnN5c1dWdTVHbFNOMzVVZ3lNTHIzUHRCeUt3?=
 =?utf-8?B?S2tFbXl5bEVGbFl5NnNhdVJCQWlzZmo1VHlnQ3NBV1pQcDFKMVViRDhiV2Vo?=
 =?utf-8?B?NU54cytWU2FWRHRwM2JpdXJwNGRjb0EyVklZaGpZUHBaN2l6RnNEbVQ5Y041?=
 =?utf-8?B?M0NkbytBSG9UTG9FZEMwTm1uRklyNGVPSm5hdFIvblNWM0VxM3ZEVmxBSXdQ?=
 =?utf-8?B?UTd1YjRDVElBVkdPbW9HRUVsWjNkZFRtcGlwYTNEQUdGb3M3eUQzd0dVNjRK?=
 =?utf-8?B?cUtNeEgzSzhLWSswVlhYNTI5UExaTS9zK1pqMzhwUEczUS9PcUdvRlo2TkV2?=
 =?utf-8?B?SHlqUzlMMllHbDRiYW5abDQ5dmxBaEZ6Rm9ZTkFEam1qTlY0ZHNCdHFHcncw?=
 =?utf-8?B?T0E1WWwrQ3YzbFpNRVJLM3JHWHRuSGo0UkpJQy9YUXFUcXA0TmRzZXhxa2tK?=
 =?utf-8?B?S3lJbzFNWnlPYUJqUzRheS9GbVFQbEFLbmpoeDFnaEczbllsZVc0dHZEckYz?=
 =?utf-8?B?cmxxOTJXdUk0MjZSZ0dINllXN3ZxNFlFbk93MGpaL2cvN1ZFSnhxbndPUXdJ?=
 =?utf-8?B?ZVdPWHVuUE14bmlKY2U2WlNIYjhGMVllalYwNU5yNTc3NFNzNHpRbW5wK0VZ?=
 =?utf-8?B?elkwQkpJOEYrc21mV2tpVUFjcldqSzJzbkJUV2g4dlQvR0trU3B6UmdpVFJQ?=
 =?utf-8?B?LzZyWGJsd083TWhjVW5XQjI3ai9SWkRjZmtGcFozN201NDdkdS9nZFduQU9p?=
 =?utf-8?B?RGx3YlMxWDNMTm9UTzBDZ2JaWUNtVHE5aDV3dmVsNGVrRCtDa3dGZGtzV21P?=
 =?utf-8?B?dUZadUZ1cGpKaDQzQUVYSG95emZvSDkwV2k3M1pLdjZ6eE13R0lYWTY2TS9N?=
 =?utf-8?B?UTRrN3VmdnBKUkY4Q0hQaHNBT0RKbDR1eDdtMTQrZ3BJRDdnNG9hN2NoUm5t?=
 =?utf-8?Q?8wpuyDCx2uti8czjoawgFFE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <364C0D942563134BA2E3A152D6FA65CB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c573f4-e0cd-4c70-6789-08d9af64e8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 16:10:18.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bypbl/9I769lqi/zgPF6RKZnvbkkyClFyIAiritJ+mWwv27s9TIZfuALQpcIHpEstWanFdWJzKaVRoBiLQH0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5114
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTI0IGF0IDEwOjU5IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMS0xMS0yNCBhdCAxMDoyOSAtMDUwMCwgQnJ1Y2UgRmllbGRzIHdyb3Rl
Og0KPiA+IE9uIE1vbiwgTm92IDIyLCAyMDIxIGF0IDAzOjE3OjI4UE0gKzAwMDAsIENodWNrIExl
dmVyIElJSSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IE9uIE5vdiAyMiwgMjAyMSwg
YXQgNDoxNSBBTSwgT2xpdmllciBNb25hY28NCj4gPiA+ID4gPG9saXZpZXJAYm0tc2VydmljZXMu
Y29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEhpLA0KPiA+ID4gPiANCj4gPiA+ID4gSSB0
aGluayBteSBwcm9ibGVtIGlzIHJlbGF0ZWQgdG8gdGhpcyB0aHJlYWQuDQo+ID4gPiA+IA0KPiA+
ID4gPiBXZSBhcmUgcnVubmluZyBhIFZNd2FyZSB2Q2VudGVyIHBsYXRmb3JtIHJ1bm5pbmcgOSBn
cm91cHMgb2YNCj4gPiA+ID4gdmlydHVhbCBtYWNoaW5lcy4gRWFjaCBncm91cCBpbmNsdWRlcyBh
IFZNIHdpdGggTkZTIGZvciBmaWxlDQo+ID4gPiA+IHNoYXJpbmcgYW5kIDMgVk1zIHdpdGggTkZT
IGNsaWVudHMsIHNvIHdlIGFyZSBydW5uaW5nIDkNCj4gPiA+ID4gaW5kZXBlbmRlbnQgZmlsZSBz
ZXJ2ZXJzLg0KPiA+ID4gDQo+ID4gPiBJJ3ZlIG9wZW5lZCBodHRwczovL2J1Z3ppbGxhLmxpbnV4
LW5mcy5vcmcvc2hvd19idWcuY2dpP2lkPTM3MQ0KPiA+ID4gDQo+ID4gPiBKdXN0IGEgcmFuZG9t
IHRob3VnaHQ6IHdvdWxkIGVuYWJsaW5nIEtBU0FOIHNoZWQgc29tZSBsaWdodD8NCj4gPiANCj4g
PiBJbiBmYWN0LCB3ZSd2ZSBnb3R0ZW4gcmVwb3J0cyBmcm9tIFJlZGhhdCBRRSBvZiBhIEtBU0FO
IHVzZS1hZnRlci0NCj4gPiBmcmVlDQo+ID4gd2FybmluZyBpbiB0aGUgbGF1bmRyb21hdCB0aHJl
YWQsIHdoaWNoIEkgdGhpbmsgbWlnaHQgYmUgdGhlIHNhbWUNCj4gPiBidWcuDQo+ID4gV2UndmUg
YmVlbiBnZXR0aW5nIG9jY2FzaW9uYWwgcmVwb3J0cyBvZiBwcm9ibGVtcyBoZXJlIGZvciBhIGxv
bmcNCj4gPiB0aW1lLA0KPiA+IGJ1dCB0aGV5J3ZlIGJlZW4gdmVyeSBoYXJkIHRvIHJlcHJvZHVj
ZS4NCj4gPiANCj4gPiBBZnRlciBmb29saW5nIHdpdGggdGhlaXIgcmVwcm9kdWNlciwgSSB0aGlu
ayBJIGZpbmFsbHkgaGF2ZSBpdC4NCj4gPiBFbWJhcnJhc2luZ2x5LCBpdCdzIG5vdGhpbmcgdGhh
dCBjb21wbGljYXRlZC7CoCBZb3UgY2FuIG1ha2UgaXQgbXVjaA0KPiA+IGVhc2llciB0byByZXBy
b2R1Y2UgYnkgYWRkaW5nIGFuIG1zbGVlcCBjYWxsIGFmdGVyIHRoZSB2ZnNfc2V0bGVhc2UNCj4g
PiBpbg0KPiA+IG5mczRfc2V0X2RlbGVnYXRpb24uDQo+ID4gDQo+ID4gSWYgaXQncyBwb3NzaWJs
ZSB0byBydW4gYSBwYXRjaGVkIGtlcm5lbCBpbiBwcm9kdWN0aW9uLCB5b3UgY291bGQNCj4gPiB0
cnkNCj4gPiB0aGUgZm9sbG93aW5nLCBhbmQgSSdkIGRlZmluaXRlbHkgYmUgaW50ZXJlc3RlZCBp
biBhbnkgcmVzdWx0cy4NCj4gPiANCj4gPiBPdGhlcndpc2UsIHlvdSBjYW4gcHJvYmFibHkgd29y
ayBhcm91bmQgdGhlIHByb2JsZW0gYnkgZGlzYWJsaW5nDQo+ID4gZGVsZWdhdGlvbnMuwqAgU29t
ZXRoaW5nIGxpa2UNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3VkbyBlY2hvICJmcy5sZWFz
ZXMtZW5hYmxlID0gMCIgPi9ldGMvc3lzY3RsLmQvbmZzZC0NCj4gPiB3b3JrYXJvdW5kLmNvbmYN
Cj4gPiANCj4gPiBzaG91bGQgZG8gaXQuDQo+ID4gDQo+ID4gTm90IHN1cmUgaWYgdGhpcyBmaXgg
aXMgYmVzdCBvciBpZiB0aGVyZSdzIHNvbWV0aGluZyBzaW1wbGVyLg0KPiA+IA0KPiA+IC0tYi4N
Cj4gPiANCj4gPiBjb21taXQgNmRlNTEyMzc1ODllDQo+ID4gQXV0aG9yOiBKLiBCcnVjZSBGaWVs
ZHMgPGJmaWVsZHNAcmVkaGF0LmNvbT4NCj4gPiBEYXRlOsKgwqAgVHVlIE5vdiAyMyAyMjozMTow
NCAyMDIxIC0wNTAwDQo+ID4gDQo+ID4gwqDCoMKgIG5mc2Q6IGZpeCB1c2UtYWZ0ZXItZnJlZSBk
dWUgdG8gZGVsZWdhdGlvbiByYWNlDQo+ID4gwqDCoMKgIA0KPiA+IMKgwqDCoCBBIGRlbGVnYXRp
b24gYnJlYWsgY291bGQgYXJyaXZlIGFzIHNvb24gYXMgd2UndmUgY2FsbGVkDQo+ID4gdmZzX3Nl
dGxlYXNlLsKgIEENCj4gPiDCoMKgwqAgZGVsZWdhdGlvbiBicmVhayBydW5zIGEgY2FsbGJhY2sg
d2hpY2ggaW1tZWRpYXRlbHkgKGluDQo+ID4gwqDCoMKgIG5mc2Q0X2NiX3JlY2FsbF9wcmVwYXJl
KSBhZGRzIHRoZSBkZWxlZ2F0aW9uIHRvDQo+ID4gZGVsX3JlY2FsbF9scnUuwqANCj4gPiBJZiB3
ZQ0KPiA+IMKgwqDCoCB0aGVuIGV4aXQgbmZzNF9zZXRfZGVsZWdhdGlvbiB3aXRob3V0IGhhc2hp
bmcgdGhlIGRlbGVnYXRpb24sDQo+ID4gaXQNCj4gPiB3aWxsIGJlDQo+ID4gwqDCoMKgIGZyZWVk
IGFzIHNvb24gYXMgdGhlIGNhbGxiYWNrIGlzIGRvbmUgd2l0aCBpdCwgd2l0aG91dCBldmVyDQo+
ID4gYmVpbmcNCj4gPiDCoMKgwqAgcmVtb3ZlZCBmcm9tIGRlbF9yZWNhbGxfbHJ1Lg0KPiA+IMKg
wqDCoCANCj4gPiDCoMKgwqAgU3ltcHRvbXMgc2hvdyB1cCBsYXRlciBhcyB1c2UtYWZ0ZXItZnJl
ZSBvciBsaXN0IGNvcnJ1cHRpb24NCj4gPiB3YXJuaW5ncywNCj4gPiDCoMKgwqAgdXN1YWxseSBp
biB0aGUgbGF1bmRyb21hdCB0aHJlYWQuDQo+ID4gwqDCoMKgIA0KPiA+IMKgwqDCoCBTaWduZWQt
b2ZmLWJ5OiBKLiBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAcmVkaGF0LmNvbT4NCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4g
PiBpbmRleCBiZmFkOTRjNzBiODQuLjhlMDYzZjQ5MjQwYiAxMDA2NDQNCj4gPiAtLS0gYS9mcy9u
ZnNkL25mczRzdGF0ZS5jDQo+ID4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiA+IEBAIC01
MTU5LDE1ICs1MTU5LDE2IEBAIG5mczRfc2V0X2RlbGVnYXRpb24oc3RydWN0IG5mczRfY2xpZW50
DQo+ID4gKmNscCwNCj4gPiBzdHJ1Y3Qgc3ZjX2ZoICpmaCwNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGxvY2tzX2ZyZWVfbG9jayhmbCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oGlmIChzdGF0dXMpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91
dF9jbG50X29kc3RhdGU7DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBuZnNk
NF9jaGVja19jb25mbGljdGluZ19vcGVucyhjbHAsIGZwKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqBp
ZiAoc3RhdHVzKQ0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF91
bmxvY2s7DQo+ID4gwqANCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZzdGF0ZV9sb2Nr
KTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZmcC0+ZmlfbG9jayk7DQo+ID4gLcKg
wqDCoMKgwqDCoMKgaWYgKGZwLT5maV9oYWRfY29uZmxpY3QpDQo+ID4gK8KgwqDCoMKgwqDCoMKg
aWYgKHN0YXR1cyB8fCBmcC0+ZmlfaGFkX2NvbmZsaWN0KSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGxpc3RfZGVsX2luaXQoJmRwLT5kbF9yZWNhbGxfbHJ1KTsNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHAtPmRsX3RpbWUrKzsNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IC1FQUdBSU47DQo+ID4gLcKgwqDCoMKg
wqDCoMKgZWxzZQ0KPiA+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gaGFzaF9kZWxlZ2F0aW9uX2xvY2tlZChkcCwgZnAp
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmZnAtPmZpX2xvY2spOw0KPiA+IMKg
wqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmc3RhdGVfbG9jayk7DQo+IA0KPiBXaHkgd29uJ3Qg
dGhpcyBsZWFrIGEgcmVmZXJlbmNlIHRvIHRoZSBzdGlkPyBBZmFpY3MNCj4gbmZzZF9icmVha19v
bmVfZGVsZWcoKSBkb2VzIHRha2UgYSByZWZlcmVuY2UgYmVmb3JlIGxhdW5jaGluZyB0aGUNCj4g
Y2FsbGJhY2sgZGFlbW9uLCBhbmQgdGhhdCByZWZlcmVuY2UgaXMgcmVsZWFzZWQgd2hlbiB0aGUg
ZGVsZWdhdGlvbg0KPiBpcw0KPiBsYXRlciBwcm9jZXNzZWQgYnkgdGhlIGxhdW5kcm9tYXQuDQo+
IA0KPiBIbW0uLi4gSXNuJ3QgdGhlIHJlYWwgYnVnIGhlcmUgcmF0aGVyIHRoYXQgdGhlIGxhdW5k
cm9tYXQgaXMNCj4gY29ycnVwdGluZw0KPiBib3RoIHRoZSBubi0+Y2xpZW50X2xydSBhbmQgbm4t
PmRlbF9yZWNhbGxfbHJ1IGxpc3RzIGJlY2F1c2UgaXQgaXMNCj4gdXNpbmcgbGlzdF9hZGQoKSBp
bnN0ZWFkIG9mIGxpc3RfbW92ZSgpIHdoZW4gYWRkaW5nIHRoZXNlIG9iamVjdHMgdG8NCj4gdGhl
IHJlYXBsaXN0Pw0KPiANCg0KT0suIExvb2tzIGxpa2UgbWFya19jbGllbnRfZXhwaXJlZF9sb2Nr
ZWQoKSBkb2VzIGNhbGwgbGlzdF9kZWwoKSBvbg0KY2xwLT5jbF9scnUgb24gc3VjY2Vzcywgc28g
SSdtIHdyb25nIGFib3V0IHRoYXQuDQoNCkhvd2V2ZXIgSSBkb24ndCBzZWUgd2hlcmUgYW55dGhp
bmcgaXMgcmVtb3ZpbmcgZHAtPmRsX3JlY2FsbF9scnUsIHNvIEkNCnN0aWxsIHRoaW5rIHRoZSBs
YXVuZHJvbWF0IGlzIGNvcnJ1cHRpbmcgdGhlIG5uLT5kZWxfcmVjYWxsX2xydSBsaXN0Lg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KQ1RPLCBIYW1tZXJzcGFjZSBJbmMNCjQ5ODQgRWwgQ2FtaW5v
IFJlYWwsIFN1aXRlIDIwOA0KTG9zIEFsdG9zLCBDQSA5NDAyMg0K4oCLDQp3d3cuaGFtbWVyLnNw
YWNlDQoNCg==
