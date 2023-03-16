Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68D6BD2A7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Mar 2023 15:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCPOrx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Mar 2023 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCPOrw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Mar 2023 10:47:52 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2102.outbound.protection.outlook.com [40.107.116.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A65618D
        for <linux-nfs@vger.kernel.org>; Thu, 16 Mar 2023 07:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIU6QLepEO8aY3g/LP2aaUUxbrWwbihg9ENY4MrBLAP4jsm9+KIMFNz17ytRTlMpfOnMOYRTh0+0r+1l3qYkRZOskDQRxPToRhxulWkyGqjUxq1GM3ls+4pVw3kHhBL7ge24VjdMEEmsHlk+wd2ajsyUB0ZHdmagp5heupfyfOWUXtuK6GAEjKyJ/WQjfJbK/8UV2rBQ+0s4U1ugT5QbkfmBADRby40Z0ekL0f8Qo4jdyR+2obF02/By0Q438897oN/nyeCsU1zU9lc0PvxXQ85X3BBMda7goarpbnYeAUhNaD0SElU6x1wEXQtFxRhqew8F47cnrvxFsBkVJTZvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLFaQxUnQuiQ1Amf0J1Rr/ctKUj6QsTtlb8JF/rslSc=;
 b=ArPJpWiq+pYy1NDtW5weC/iaDhlVS7L966Ypbrbs8mrgX50lfkXKr9lxXANn7I+gtAiTSfqF6b0rJAtyBNGcvogiVqW5mBpHJElJWwnGvG6N0PmnpuKiuZvGUce8B3DO9/rVy0iWouCm4p51M7W/0x11IgM2+YiTW5dAsruA8AOVCJ5YpQ426YP6ibypCoIXsb0dWH0wzl8VjcGJSDMO88y4UkAE8mMYxk8MBbabcC52dW7NRkxPRmfuxHbscHGKg5Rih3bIkt0yg0KHvm8ISZRCZ+tb35ZT716Vne4JRPZLDDu2zAn37x4Y55olLteMEtAqodCNHOBhTuzdwW8Jxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLFaQxUnQuiQ1Amf0J1Rr/ctKUj6QsTtlb8JF/rslSc=;
 b=pgcJmTYG6stvG0m0CUSGgZp5P2DBV0Ua3BDaYu7Mrrq1HnALFKlkjglPAxSCtS544ZaARYR8vhA0+FjRYYXtmw25rbkA6GlTV8r/8LoFuDp94/K21OknGMKbAzusRj3dNkyRz+EcvftorKQ5s0X/5rjMAiVOhAeLt9dsK/uXw+Q=
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::7)
 by YQXPR01MB5849.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 14:47:48 +0000
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643]) by YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643%6]) with mapi id 15.20.6178.033; Thu, 16 Mar 2023
 14:47:48 +0000
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [PATCH 1/1] SUNRPC: Use rpc_create_args->timeout to initialize
 rpc_xprt->timeout
Thread-Topic: [PATCH 1/1] SUNRPC: Use rpc_create_args->timeout to initialize
 rpc_xprt->timeout
Thread-Index: AQHZVb74qq7nSKwNxkWOAfXkZrAi8K76nU8AgALfAYA=
Date:   Thu, 16 Mar 2023 14:47:48 +0000
Message-ID: <YQBPR01MB1072400D16E8027064470937D86BC9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <20230313151716.34280-1-andrew.klaassen@boatrocker.com>
 <FD077033-023F-4214-A9A4-BECCF319F973@hammerspace.com>
In-Reply-To: <FD077033-023F-4214-A9A4-BECCF319F973@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10724:EE_|YQXPR01MB5849:EE_
x-ms-office365-filtering-correlation-id: 820f4049-452d-431b-b5c3-08db262d6929
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(66899018)(4326008)(33656002)(41300700001)(52536014)(8936002)(5660300002)(44832011)(2906002)(86362001)(122000001)(38100700002)(38070700005)(7696005)(478600001)(8676002)(76116006)(66946007)(66446008)(64756008)(966005)(71200400001)(66476007)(66556008)(6916009)(55016003)(54906003)(316002)(6506007)(9686003)(53546011)(26005)(55236004)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FO2Hf0u4L9y3KM44VvVIqUIaZzV54umukceGlefX5RLOu/QtChjUdBZ/zRGTScyERLm5f0i06fRyF9MLAg0a1QYj2r5Y+h67QGzvLVA1KKx7uXF9V27jOLm8I9TaRraTh74tcV3kkfeTQxAqpPOBZ4ZnT7YlJHPDWiS5ffA/fuKrZooLt3JgEXbxtvxCwxOneGtwasTnoF/W0u78Tkpa/6BisZT9q8qnu0J2w6oBm4lsOjPpfOUgisf187Xw5xG5jxe1giPXmYWFN++iW6sk+/PqzCg7X3HEuS4y17klQNjsyJ1SMviR6VWmRXsTJbHmAP3icfmLUNrQWFCxDdcDqGxQRtqyw1HqRSBYwJmKbFvAOsXls16fCLi3kkcl/VrXualmftggXicKtiftQh0t09ymKgMZ5tvSvWCyiKFZC0b7kKR/G5fSOzBCWibxv5/m+L2K7I6EsidX9Hv6DK8jtEmBHD8kv5QdZ7QEQT3T5IAUoBhHe23EG/QXGGLW8vDXSyI1GUvYarGS2ao9lfCbH/cVFfjb44aOsJaeEyst8wUK+nGsCl8Ocj30sUQDxsAgT9My0FHKadhgr1UT3asDpFaxxyh1NZnVPHc5Zz7pVWVQeBInBnSJKvEjy4rh9uyIvRaYEw0A99pwA2oa2lBBtpNC/yK95q5tJKEnMaHpl98rj5DNal9wEIRaRTbrXceC
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akNLb3FaaEdHK3A1d1hkRW9TWkxUVVpyT0ZNbVowSUp0d05mTnpoTU9SVnhw?=
 =?utf-8?B?VHZDQnc3TjRYZHRYYlQ3WUp6VHkzSVhHRE5GbkRmMkJVZGZ5TXl6RExsdEov?=
 =?utf-8?B?UCtua29MMFhITHVUSkxtdDBFeDNZNWNZSFhSOGhrTS83ODRSdFo0UVIxZDh3?=
 =?utf-8?B?ZnpmcU5uMnNvdVI1UHJiMk1hTW52czJyY3UrU3QyS3VFMXE5d2hvUXMyNm9h?=
 =?utf-8?B?WGU5YUZTazYyaXk3bncrcHVhOHd0dEk4Mll4Z1Z0ellHOGVYaUZyZHBhMyt5?=
 =?utf-8?B?TDlnTFpJSUVKdTFRYUxSL3JSUkZZMFZMUFZad1BtSTk4V2xLd1NjOWE4eWVS?=
 =?utf-8?B?Ym9qRzgwY1VDaFZIaEpBZ1RnSFF1enhhOFp0cjRUejFZVm95cWxrUHIvN0lQ?=
 =?utf-8?B?QWV0N1NDaWJBVTMrT09ZN0IzakdFVkxuWnJDb2YydEdqTlE5eEcvUzJqMHdk?=
 =?utf-8?B?N3JwRzU2aHBEUWplNlZjVUxJL1Ura2xZWjRudHVza0QybTdVZXRsOGZPeGo2?=
 =?utf-8?B?V0M1Rmd1QnZKaFI2YkdsK1ZublF0V09KbDUyR3gzTG9oSjZpaUUyZnR6R0Q3?=
 =?utf-8?B?SmZaRDZYY0dKak5TSjJ2ZUZmclMxWnNsYTdnMExpdWMrd0U3NlJvalQvVU5s?=
 =?utf-8?B?ZUJKQjUxOXJzQ0ZUVU5ONWNpT3IyM09kN2hBM0FJNGl1dndWbDh4cXFSNG1G?=
 =?utf-8?B?ZENrTUd2aDBFNHdWVFk2SCtmcVFzT3RFR0NKdTM0RUtMUG0vdFV1TFNoaERS?=
 =?utf-8?B?aHBRcXF6WFBPd2R4V1M4NExNaXh6ZVJLdTQrcUt2YWRyd2tpWWpXMDZDMld0?=
 =?utf-8?B?aDcrMk1ZYWE1M3N4VTJCaVY1dG9HNUppSG53SmV6cDZCSmx1bnBOMmY5ekxl?=
 =?utf-8?B?Q2cvTnMwcDlGZUsxcFIzM1ZkUFppNmlhUFZ1RzMvRzVoYUovMHNQMmFINGZw?=
 =?utf-8?B?dTZPRGZPOTBVMHA1OVpVMXA1ajlJTlMvaGF5RkNCWFRZSkdjQ3huZTcrelVt?=
 =?utf-8?B?NEtMeU9JVXNxSmZBN3FCcEFkMlY4VkgvUERxSk05alRCakNXWFF3Z21xb2xF?=
 =?utf-8?B?SmIrMHk5T055dmxjMHJRRmtxWmcyVWc1NWJsazFGaDQ4QTBtWkJNRzhWTW9i?=
 =?utf-8?B?S2h6OE5HUmVTdTdPZlZ5bzE4Zlc2N2pWdlFyWWRoUUNaOXhneDVMQit3MGlw?=
 =?utf-8?B?dnVzM0lQcFdyR285UVNoZ1pDaHdNMTF3cTBVbDd2S21wVVIrUjhVc2ZvRUMr?=
 =?utf-8?B?SmExNXk3TktmMmJmbzFZZjl5UDNkcUVab0tUNFhxSGUwczVPcVNiaUhqbEc2?=
 =?utf-8?B?Vy93VHR1WHpjV3Z6TVNxOTFSbTBJWG8yQUxUWFZjRm5FK2ZhWXJtT2VOeEhS?=
 =?utf-8?B?K2VTMUdWalRGVWxvSERKSncyQnZYOExCOXYraEduRjEwMnUyTk9HQnJDMDR5?=
 =?utf-8?B?NWU4NEh2NndqS0pQUVFHTjV1OHJBbkJnWDh2OW9nRTdaU3UwbnZ1VDByMkFa?=
 =?utf-8?B?S0tEenBaUGdqbHJGRFhRSWQ0MG82bEQ0am13QURVTE9pSElFNitXYTBUSVlH?=
 =?utf-8?B?c3VpZnFQY0Z5NVNWNXpKUklvMVU4cmoyaGJWdFdrM3JOcXhxRVhwQjVLRHM4?=
 =?utf-8?B?UUxhL1V6VE5aUVgxd1NiZ0Y3eTJld3BZbTlCZmJaUUdYZy82MUFYbU43RUNu?=
 =?utf-8?B?b01EZDg5TFVXbm5hdk5GUDg1MUpSaU9WckdDNDBkRUFDOHArVXRRcUNwdkxh?=
 =?utf-8?B?VDlINEVJZkl6QzlyWUtDRS9CUVpPQU41K0NhWVlQSnhCTjloc1dIRE43N0FM?=
 =?utf-8?B?QjhhcGNiRG1aOEJ0M0QvbW5oa25iMTh2TVg5cnJhUStldXJMd09RQksvaVg2?=
 =?utf-8?B?QmNYa0lSUlJONVlOMysrMUZ5WkRXdytjSHpCVDlyYmVncVkyMi96VzdDR0Vy?=
 =?utf-8?B?NVpkVVJWWVFidU1jTDRZZ28zdnhpaXptcVlPdW55VjdQWExkT3c4Tkk2WEdM?=
 =?utf-8?B?R1BvNG84NmkwVHJzcURYWjZtTUpNZ0tXRHk0TmsySUJwQjFLNUVVelFncktR?=
 =?utf-8?B?V01Oc3Nzc1pmcWJDVXpBZE5iQmZYeWM1YzhPa2pWeXZxVEFaVzRKSnhBWWtT?=
 =?utf-8?B?RFFTdDJ4QWJpK1U3bDZEVnVrRmI1YmpPNWRvcUp2OHRGdGVTUkV1d2RaN3Jz?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 820f4049-452d-431b-b5c3-08db262d6929
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 14:47:48.2313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttKYvfs2InRmOZXEZPKfmBbGj4nXzCl1ykgHJPt8BH+RGirKLsm1+SdemjUpFidsv2ub2yQwqEszSRwitdKkfMqgqrvEJE2LqQY2tz6eERo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5849
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCAxNCwgMjAyMyAyOjQwIFBNDQo+IA0KPiA+IE9uIE1hciAxMywgMjAy
MywgYXQgMTE6MTcsIEFuZHJldyBLbGFhc3Nlbg0KPiA8YW5kcmV3LmtsYWFzc2VuQGJvYXRyb2Nr
ZXIuY29tPiB3cm90ZToNCj4gPg0KPiA+IFdlIGFyZSB1c2luZyBhcHBsaWNhdGlvbnMgd2hpY2gg
aGFuZyBpZiBhbnkgTkZTIHNlcnZlcnMgZmFpbCB0bw0KPiA+IHJlc3BvbmQuICBXZSB3b3VsZCBs
aWtlIHRvIGJlIGFibGUgdG8gY29udHJvbCBORlMgdGltZW91dHMgc28gdGhhdCB3ZQ0KPiA+IGNh
biBjb250cm9sIHRoZSBtYXhpbXVtIHRpbWUgdGhhdCB0aGUgYXBwbGljYXRpb25zIGhhbmcuICBX
ZSBjdXJyZW50bHkNCj4gPiBjYW4ndCBkbyB0aGF0IHdpdGggVENQIE5GUyBtb3VudHMsIHNpbmNl
IFJQQyBjYWxscyBtYWRlIHRvIGFuIGV4aXN0aW5nDQo+ID4gTkZTIG1vdW50IGFyZSBmaXJzdCBz
dWJqZWN0IHRvIHRoZSBkZWZhdWx0IHVudHVuZWFibGUgU3VuIFJQQyB0aW1lb3V0DQo+ID4gb2Yg
MiBtaW51dGVzLg0KPiA+DQo+ID4gKEknbGwgbm90ZSB0aGF0IHRoZSBleGlzdGluZyBORlMgbWFu
cGFnZSBzZWVtcyB0byBub3QgZGVzY3JpYmUgY3VycmVudA0KPiA+IGJlaGF2aW91ciBjb3JyZWN0
bHksIHNpbmNlIGl0IHNheXMgdGhhdCB0aGlzIHR3by1taW51dGUgdGltZW91dA0KPiA+IGFwcGxp
ZXMgdG8gaW5pdGlhbCBtb3VudCBvcGVyYXRpb25zICh3aGljaCBpdCBkb2VzIG5vdCksIGFuZCBk
b2VzIG5vdA0KPiA+IHNheSB0aGF0IHRoZSB0d28tbWludXRlIHRpbWVvdXQgYXBwbGllcyB0byBv
cGVyYXRpb25zIG9uIGV4aXN0aW5nDQo+ID4gbW91bnRzICh3aGljaCBpdCBkb2VzKS4pDQo+ID4N
Cj4gPiBBbiBleGlzdGluZyB0aHJlYWQgZGlzY3Vzc2luZyB0aGlzIHBhdGNoIGNhbiBiZSBmb3Vu
ZCBoZXJlOg0KPiA+DQo+ID4gTGluazoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1uZnMvNDVlMmU3ZjA1YTEzYWJhYjc3N2IzYjA4Njg3NDRjZGJmYzYyDQo+ID4gM2YyZC5jYW1l
bEBrZXJuZWwub3JnL1QvDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHVzZXMgdGhlIFJQQyBjYWxsIHRp
bWVvdXQgdG8gc2V0IHRoZSB4cHJ0IHRpbWVvdXQuICBJbiB0aGF0DQo+ID4gZGlzY3Vzc2lvbiB0
aHJlYWQsIEplZmYgTGF5dG9uIGhhcyBwb2ludGVkIG91dCB0aGF0IHRoaXMgbWF5IG9yIG1heQ0K
PiA+IG5vdCBiZSB0aGUgaWRlYWwgYXBwcm9hY2guICBJIGhhdmUgc3VnZ2VzdGVkIHRoZXNlIGFs
dGVybmF0aXZlcywgYW5kDQo+ID4gd291bGQgYmUgaGFwcHkgdG8gZ2V0IGZlZWRiYWNrOg0KPiA+
DQo+ID4gLSBDcmVhdGUgc3lzdGVtLXdpZGUgdHVuZWFibGVzIGZvciB4c19bbG9jYWx8dWRwfHRj
cF1fZGVmYXVsdF90aW1lb3V0Lg0KPiA+IEluIG91ciBjYXNlIHRoYXQncyBsZXNzLXRoYW4taWRl
YWwsIHNpbmNlIHdlIHdhbnQgdG8gY2hhbmdlIHRoZSB0b3RhbA0KPiA+IHRpbWVvdXQgZm9yIGFu
IE5GUyBtb3VudCBvbiBhIHBlci1zZXJ2ZXIgb3IgcGVyLW1vdW50IGJhc2lzIHJhdGhlcg0KPiA+
IHRoYW4gYSBzeXN0ZW0td2lkZSBiYXNpcywgYnV0IGl0IHdvdWxkIGRvIGluIGEgcGluY2guDQo+
ID4NCj4gPiAtIEFkZCBhIHNlY29uZCBzZXQgb2YgdGltZW91dCBvcHRpb25zIHRvIE5GUyBzbyB0
aGF0IFJQQyBjYWxsIGFuZCB4cHJ0DQo+ID4gdGltZW91dHMgY2FuIGJlIHNwZWNpZmllZCBzZXBh
cmF0ZWx5LiAgSSdtIGd1ZXNzaW5nIG5vLW9uZSBpcw0KPiA+IGVudGh1c2lhc3RpYyBhYm91dCBv
cHRpb24gYmxvYXQsIGV2ZW4gaWYgdGhpcyB3b3VsZCBiZSB0aGUNCj4gPiB0aGVvcmV0aWNhbGx5
IGNsZWFuZXN0IG9wdGlvbi4gIEknbSBndWVzc2luZyB0aGlzIHdvdWxkIGFsc28gaW52b2x2ZQ0K
PiA+IGNoYW5naW5nIHRoZSBTdW4gUlBDIEFQSSBhbmQgZXZlcnl0aGluZyB0aGF0IGNhbGxzIGl0
IGluIG9yZGVyIGZvciBpdA0KPiA+IHRvIGFjY2VwdCB0aGUgc2Vjb25kIHNldCBvZiB0aW1lb3V0
IG9wdGlvbnMuDQo+ID4NCj4gPiAtIFVzZSB0aW1lbyBhbmQgcmV0cmFucyBmb3IgdGhlIFJQQyBj
YWxsIHRpbWVvdXQsIGFuZCByZXRyeSBmb3IgdGhlDQo+ID4geHBydCB0aW1lb3V0LiAgT3IgZG8g
dGhlIG9wcG9zaXRlLiAgVGhlIE5GUyBtYW5wYWdlIGRlc2NyaWJlcyB0aGUNCj4gPiBjdXJyZW50
IGJlaGF2aW91ciBpbmNvcnJlY3RseSwgc28gdGhpcyBhdCBsZWFzdCB3b3VsZG4ndCBtYWtlIHRo
ZQ0KPiA+IGRvY3VtZW50YXRpb24gYW55IHdvcnNlLiAgSSBhc3N1bWUgdGhpcyB3b3VsZCBhbHNv
IGludm9sdmUgY2hhbmdpbmcgdGhlDQo+IFN1biBSUEMgQVBJLg0KPiA+DQo+ID4gVXNlIHJwY19j
cmVhdGVfYXJncy0+dGltZW91dCB0byBpbml0aWFsaXplIHJwY194cHJ0LT50aW1lb3V0DQo+ID4N
Cj4gDQo+IEp1c3QgYmVjYXVzZSBzb21ldGhpbmcgY2FuIGJlIGRvbmUgaW4gdGhlIGtlcm5lbCwg
aXQgZG9lc27igJl0IG1lYW4gdGhhdCBpdA0KPiBzaG91bGQgYmUgZG9uZSBpbiB0aGUga2VybmVs
LiBJZiB5b3XigJlyZSB1bmhhcHB5IHdpdGggc3VucnBjIHRpbWVvdXRzLCB0aGVuIGl0DQo+IHNo
b3VsZCBiZSBxdWl0ZSBwb3NzaWJsZSB0byBkbyB0aG9zZSBjYWxscyBpbiB1c2Vyc3BhY2UsIGFu
ZCBwYXNzIHRoZSBwb3J0DQo+IG51bWJlciBkb3duIGFzIHBhcnQgb2YgdGhlIG1vdW50IHN5c2Nh
bGwuDQoNClRoYW5rcyBmb3IgdGhlIGRpcmVjdGlvbiwgVHJvbmQuICBJJ2xsIHNwZW5kIHNvbWUg
dGltZSBnZXR0aW5nIGZhbWlsaWFyIHdpdGggdGhlIGNvZGUgYW5kIHNlZSBpZiBJIGNhbiBtYWtl
IHRoYXQgaGFwcGVuLg0KDQpJJ20gY3VycmVudGx5IGNsdWVsZXNzIGFib3V0IGhvdyB0byBnZXQg
c3RhcnRlZCwgYXMgdGhlcmUgZG9lc24ndCBhcHBlYXIgdG8gYmUgYW55IHdheSB0byBvdmVycmlk
ZSBzdW5ycGMgdGltZW91dCBkZWZhdWx0cyBmb3IgYW55IHN1bnJwYyBjYWxsLCBzbyBJIG1heSBo
YXZlIHNvbWUgZm9sbG93dXAgcXVlc3Rpb25zIG9uY2UgSSBnZXQgbXkgaGVhZCB3cmFwcGVkIGFy
b3VuZCB0aGUgbW91bnQgY29kZS4NCg0KQW5kcmV3DQoNCg0K
