Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B467A4C7074
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiB1PRN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 10:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiB1PRK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 10:17:10 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE1811A6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 07:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY0A5uasq/hk+Lv+u6ZXSOiLo8IT7+0xVeMIzLeSt7duZX6LqU4CR2b8aMCuzdnnMkPsoSZI3XpzYdRhwbOsPnq4KRfo35L5qgKa+p2zvY23pvJwazYzFVfYpxBqjfa6jVH1hG+v0Aa7GZaoZvuAvMOATJLy/ZTJ7OwiRCXoTirJbW57kPIeU8GXjEL1bXVeEK69Dnyc3dIAsaH7z7pbuiOjhvxof44MLUTSmVIX+jwaXrMcgqywZt97sS0l2h/WastgIq8iLSdEcP732vTxprSl5BTSEvSLSZNkANANx5M/C8dFlpniv36i2C4AtXdTxH+FrusT/7VEShKJumKkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw9yj91bOGm0qSy5vl1JBWx2fldHek1cKxXcmZPQ3qM=;
 b=TvgbwgJTU7AKBGr1z/U+TtKkqaQbTWGHjEeuYco5UKYsvGTR+F2QkkJ/Ax1ddUU0TKsMDhvzAK5bYkG/PSqqJ0bFVX5Xwqt0anj83Vf9eijAsooWAFn+U+WCUW9xsYM/MYQCn9xcVdJ9t5+lzdzkvO07Oq4a0EZyxZgQKxlcz2RuF9sSs+gz+7jorbj0fE7qsTYLaMHF6+5icCt6odTh5PG95NpPmwGN3yNUv5xhvvGWXYChNvA6JXfokALos9Myc3xD4ZKOiEK49Z8l8GFd+QRoUuyfoEpDE3R3iBgeU9DbLBMBLXYzKWQ73bfDDGyGT08XqsuOeV4+q05jQUR9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw9yj91bOGm0qSy5vl1JBWx2fldHek1cKxXcmZPQ3qM=;
 b=ZzbBQ5gWWDitdVuVkzRghAWA4W2sGObaEjC1mcZ/40Y/b1szXuGS8/J0wc65NwSvFv179LV3fKOPfloTXzlUgQ2Lty0g7Gn5bVp8O60EZ1Sd6q44DXye63HLv9+jF1qjBwDZ/g2U7PsYGHDZ9rLVCJejL+6xMsM/IQZJY5Rtxd4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4600.namprd13.prod.outlook.com (2603:10b6:408:129::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Mon, 28 Feb
 2022 15:16:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.013; Mon, 28 Feb 2022
 15:16:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Thread-Topic: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Thread-Index: AQHYHScFlqCFQx4T40K//9/WiL9wzKyKGmaAgAATggCAHgF+AIAA+UiAgAAJTwA=
Date:   Mon, 28 Feb 2022 15:16:25 +0000
Message-ID: <88a6445c7d7cde971479cae70ca0eb62f68ff96e.camel@hammerspace.com>
References: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
         <189aba691b341f64f653817c9cdf018ef34ac257.camel@hammerspace.com>
         <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
         <164600585213.15631.6635814364853064416@noble.neil.brown.name>
         <BA04DD0D-4B05-48AD-9E22-AB7524E737C3@redhat.com>
In-Reply-To: <BA04DD0D-4B05-48AD-9E22-AB7524E737C3@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65d8a408-7e4a-4593-4148-08d9facd49a4
x-ms-traffictypediagnostic: BN0PR13MB4600:EE_
x-microsoft-antispam-prvs: <BN0PR13MB460073613C5284BDD1F71DADB8019@BN0PR13MB4600.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DmoSAkw8+vXDWNwLrRDjt/ENLGfzmdy1Ce/IuFK3rp9E++YQcQfnKzKrhGA0m2mEvO2CAJP5NMm5Fy5K/2CnJAwZgA4l/YnjExboPqvJ2hrhn+AQ5Ids1HV0QAQ38gGH/swOmN0sgx0vpQKawj44xmkG0gGIBi90pSNp6oANmKe4ihEPQpcuTvMqDypOkfs+UwgCwymPsyqbJYG/IPk5HizB0LKWK9TDDYG/ZAvFVpNXvzyu4UEkWuaXPjrikw+OLTiHihX3qbVxr1I1DuEAuw/1x28YS/z2MnQuFYdipiTYua1pdXdVpGacP+bntPEMZwAEsvJElyazsviwmCK14jcPEZ624JK1RmxoQV/mNWEvj/gwMwWhIvZQOV7s/lQtXWlSx4zBV0eXacC5eCV/RKZSeb8aZVK2pEcfpRA8pMz36J2q2bhnhS4CEMmBHf/pwy9fFtJDhA0ypMdindCqTroY2RDoS2PW8bDjvzO3uPWROXWhEqc6dkQLOpOfNTEhPpM/Ovs2f2pD2/PiXa1v43sjzF16bxx0aR0hXsJk4IPhn5hbOoEl5ppPi1oceXAPW9d9/ijk4iXt/ZEnCCRDuF6sdZTd0l7QhBycBuOc8XGJ6DrTD5F5zlrWgYlxszu/hVAamMOaKjBcOYUDaNhg0NhezWX3pNw/KnVuYkpKQIsbtvsDF4BCtdykye3MDkKmxfmI1D6BTkG/1aZOLaOa3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(122000001)(38100700002)(83380400001)(8936002)(5660300002)(36756003)(2906002)(2616005)(38070700005)(71200400001)(66446008)(66556008)(66476007)(66946007)(8676002)(64756008)(4326008)(26005)(6506007)(86362001)(6512007)(316002)(53546011)(110136005)(54906003)(76116006)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUxLQk9GUTRSRlgvK0ZsVVE1b1RXTDBEWkdGdlc4MFRrTWtFMWtHTWtrcUg4?=
 =?utf-8?B?NHpaNjZ0VEw0WjJEYlRDOFlpTTJ0b1Z6M080MWh0OHBOeGRkUEV1dUJNaFpZ?=
 =?utf-8?B?N1IwU1RmS2xMQVRsZlppcEUzZmlqckZqcG9nalc0RzRtS29wdHpRM3VURW43?=
 =?utf-8?B?emZvYkhVamRSNVA4RVlmNkJJWXVoQ3RkaVkzcXNqMHZ3OTJOaHBRV0U4NWZD?=
 =?utf-8?B?anNvbnd6ZG9HT0V6bnI4Sm1UN0hNcm8yZ2pPc1VEWFBIazNYSENMQzVPNWpK?=
 =?utf-8?B?d2dHbWx1K2RjTk5rVllPbFZleGQ2RnpmcHFwNWxyWHlSS09KdWJXUlNKYUxE?=
 =?utf-8?B?VU9xZ05ybmRlVE5aK3ZBTjROdFBqeTV4QVEzZ2wzNXc3ZmpNcnFiamdKY05P?=
 =?utf-8?B?eS91VzA3NlplOW5TT051K3UyU2dLbytwU2x0VG9wdzR3OUhNSW1UUUtTS2pI?=
 =?utf-8?B?bDdUa2VEaE9zTmhCUFgxblVSdkFGQnVkeC9uUWdYRjNpRDFSamlja0dhYVA1?=
 =?utf-8?B?RVIra3JINGcvOGVQWnhFNW9VTkNSZkpvU0UzdVFSUnNDZDZYRVB4OHJpMWdH?=
 =?utf-8?B?M1lpc0YrbmNPa01qclMrQ2g3dHVrMzlOV1RhWlZkditLbVpNY1U1TGZXeHF5?=
 =?utf-8?B?bEE0OFczQ2tvdG5uNmJOYmlqYUo0V3ltTXJ1OVZCUkM4UVNzQ2twK0EwUHBG?=
 =?utf-8?B?Z1ZDazArQk9uRzd4REFZZVMvSlk4WjVta2hvUE9TZ2lkWFVaQzBHSmNLOUhQ?=
 =?utf-8?B?K0phTkVMeGkxQmlyRFRMWGIvejM1VlJrOUZ1N3NKaDJVc2VZbHdIWjJTOUtL?=
 =?utf-8?B?VGtSRkJqM0lXeFhOSTdPNHdrSzM2MUpRUXBkM1htaGVMWXNmZnQ2aDVSVlh3?=
 =?utf-8?B?UklaWDl2M1ZFQlpvd0V5UjhGR01UWnd1VzlKL1JoQjVlK2ZhalFiRnlweEtG?=
 =?utf-8?B?T3RMZVQ0dkNZVVlMZUpQQWpUZGU2QXlWQ3daSGI5ZmJtb2dSNjZaMFl4SW9w?=
 =?utf-8?B?REZneGdqdWo4ZXZNdkZ1eFZkaHVkVFRodmE3WDhtNWY1M3M1YmlRU1VkSFJJ?=
 =?utf-8?B?c1lJV0NvYWxlY0krTnFzUW5rSWtrYXpKemF4OEFUaEdTT0swaTQ3UHVsQlpJ?=
 =?utf-8?B?RDNJZjdFd2ZNVUdtMDE4WGc0dnZ2YnlFNDRjdklBclR2M3l4OW5adTNpK2kz?=
 =?utf-8?B?c2g2WGdpMUZnWkZ0NjU3VW50Qm5wbEt0TUo5TGFWSHREZjlpZFgzeWR4T21F?=
 =?utf-8?B?aWxBdm5yclY5dFg4OGxvZExSL2tpV0htT3hrekNkcHdXZWZQb0hZMTY5bkJ3?=
 =?utf-8?B?STBNQWdqeWlGbmRvMXF2WnZVRVZ4ZVY0S1kyNVRha3o0QVZUU0V6bGZNMjQw?=
 =?utf-8?B?MWwwNmxHYUZHNzVSakl4UnovakhRTEU4RCtqTXFFR2FDZGxjV2RESkx1VVBx?=
 =?utf-8?B?ZmtRSVl1NDRPb05NT0pHWVVvRnpsSDZvcFJJNEVqOW1veWNiRGsvWHRwa1VN?=
 =?utf-8?B?ZStjeEp6Q1M3aUlsaDA5S0loNnZTV1I5QXJhM0JOaVV1amRUdEVxSkNPaFBZ?=
 =?utf-8?B?QkIrbjlqWUl2eDBDQ0o1ZFptNGNzei9zRVMrYkRtWGZ3Ym1WK0pFbUsybi92?=
 =?utf-8?B?ZVNYWlF4bjh6MFRaUlZxcVVFb0FzbWsrSGwrb0lDSTFhSVY2SnQwTEt5RGZY?=
 =?utf-8?B?OUtTZ2IzR0l0QkVDb1UvQlFnTGlLcmRpc081UkFnUlJQMDdUWW1jVTQ1STBv?=
 =?utf-8?B?SnR3Y2hzOGpXUmZYZVNvV2NHNnNaN3dBTFlmZFlnM21UbjFxc1h2QkRGbjhK?=
 =?utf-8?B?TE9jTGU5blNOd1dFbktNSUQ0QUY2bWg2UkJRWkxtWmpWUEJPOGVXMzdVQ2Jk?=
 =?utf-8?B?aTE1MEdCSmRZT2E4eGNyZlR6ZHN4amc2a2pFL1hxdEY4RVRGUkx4Y3JWVmdF?=
 =?utf-8?B?czNIWmszTmpRUm05ZWZ3Qm00SmsxUlEwakY5R0ovZlE0cXVGVTBaaUVLMmVL?=
 =?utf-8?B?TGpyaHYraUVpNVJTY3dySHdZNGJmZ2ZoeFBmamYxem4vMmtuamphSDJOT3ZN?=
 =?utf-8?B?ZWNCRGJ2MkRZVWZwZnh2SEVtT2s0QnZBU3dZMUQrVXllaEp6SXdWbEducWZs?=
 =?utf-8?B?Y0hFcWtPd3E1SEprWDFVME5JcXhJNUdaVVBrRUdrcVBHVExhclBNem55WEZv?=
 =?utf-8?Q?ILHvJFuyAgT2bY0JniZy5DI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9CD112256719C46B2F85D638C2E59F3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d8a408-7e4a-4593-4148-08d9facd49a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 15:16:25.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyMBYaw8GLJoioJpgBDwVJcT4HEykkNyj7qWoTmwdaqOlVQAvkfG62zfsHhh8CTNhAXd7g2isB7yyfPbUKYe0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTI4IGF0IDA5OjQzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNyBGZWIgMjAyMiwgYXQgMTg6NTAsIE5laWxCcm93biB3cm90ZToNCj4gDQo+
ID4gT24gV2VkLCAwOSBGZWIgMjAyMiwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gPiA+
IE9uIDggRmViIDIwMjIsIGF0IDE1OjI3LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiAN
Cj4gPiA+ID4gT24gVHVlLCAyMDIyLTAyLTA4IGF0IDE1OjAzIC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gPiA+IEluIG9yZGVyIHRvIGRpZmZlcmVudGlhdGUgY2xpZW50
IHN0YXRlLCBhc3NpZ24gYSByYW5kb20gdXVpZA0KPiA+ID4gPiA+IHRvIHRoZQ0KPiA+ID4gPiA+
IHVuaXF1aWZpbmcgcG9ydGlvbiBvZiB0aGUgY2xpZW50IGlkZW50aWZpZXIgd2hlbiBhIG5ldHdv
cmsgDQo+ID4gPiA+ID4gbmFtZXNwYWNlDQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiBjcmVhdGVk
LsKgIENvbnRhaW5lcnMgbWF5IHN0aWxsIG92ZXJyaWRlIHRoaXMgdmFsdWUgaWYgdGhleQ0KPiA+
ID4gPiA+IHdpc2ggdG8NCj4gPiA+ID4gPiBtYWludGFpbg0KPiA+ID4gPiA+IHN0YWJsZSBjbGll
bnQgaWRlbnRpZmllcnMgYnkgd3JpdGluZyB0bw0KPiA+ID4gPiA+IC9zeXMvZnMvbmZzL25ldC9j
bGllbnQvaWRlbnRpZmllciwNCj4gPiA+ID4gPiBlaXRoZXIgYnkgdWRldiBydWxlcyBvciBvdGhl
ciBtZWFucy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBD
b2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
IMKgZnMvbmZzL3N5c2ZzLmMgfCAxNCArKysrKysrKysrKysrKw0KPiA+ID4gPiA+IMKgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZnMvbmZzL3N5c2ZzLmMgYi9mcy9uZnMvc3lzZnMuYw0KPiA+ID4gPiA+IGluZGV4IDhj
YjcwNzU1ZTNjOS4uOWI4MTEzMjNmZDdmIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9z
eXNmcy5jDQo+ID4gPiA+ID4gKysrIGIvZnMvbmZzL3N5c2ZzLmMNCj4gPiA+ID4gPiBAQCAtMTY3
LDYgKzE2NywxOCBAQCBzdGF0aWMgc3RydWN0IG5mc19uZXRuc19jbGllbnQNCj4gPiA+ID4gPiAq
bmZzX25ldG5zX2NsaWVudF9hbGxvYyhzdHJ1Y3Qga29iamVjdCAqcGFyZW50LA0KPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsNCj4gPiA+ID4gPiDCoH0NCj4gPiA+ID4gPiDC
oA0KPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBhc3NpZ25fdW5pcXVlX2NsaWVudGlkKHN0cnVjdCBu
ZnNfbmV0bnNfY2xpZW50DQo+ID4gPiA+ID4gKmNscCkNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGNoYXIgY2xpZW50X3V1aWRbMTZdOw0KPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoGNoYXIgKnV1aWRfc3RyID0ga21hbGxvYyhVVUlEX1NUUklOR19MRU4g
KyAxLA0KPiA+ID4gPiA+IEdGUF9LRVJORUwpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqBpZiAodXVpZF9zdHIpIHsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZ2VuZXJhdGVfcmFuZG9tX3V1aWQoY2xpZW50X3V1aWQpOw0KPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcHJpbnRmKHV1aWRfc3RyLCAiJXBVIiwg
DQo+ID4gPiA+ID4gY2xpZW50X3V1aWQpOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByY3VfYXNzaWduX3BvaW50ZXIoY2xwLT5pZGVudGlmaWVyLA0KPiA+ID4gPiA+
IHV1aWRfc3RyKTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiA+ID4gK30NCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gwqB2b2lkIG5mc19uZXRuc19zeXNmc19zZXR1cChzdHJ1Y3Qg
bmZzX25ldCAqbmV0bnMsIHN0cnVjdCBuZXQNCj4gPiA+ID4gPiAqbmV0KQ0KPiA+ID4gPiA+IMKg
ew0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX25ldG5zX2NsaWVudCAqY2xw
Ow0KPiA+ID4gPiA+IEBAIC0xNzQsNiArMTg2LDggQEAgdm9pZCBuZnNfbmV0bnNfc3lzZnNfc2V0
dXAoc3RydWN0IG5mc19uZXQNCj4gPiA+ID4gPiAqbmV0bnMsDQo+ID4gPiA+ID4gc3RydWN0IG5l
dCAqbmV0KQ0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBjbHAgPSBuZnNfbmV0bnNfY2xpZW50
X2FsbG9jKG5mc19jbGllbnRfa29iaiwgbmV0KTsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
aWYgKGNscCkgew0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV0
bnMtPm5mc19jbGllbnQgPSBjbHA7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChuZXQgIT0gJmluaXRfbmV0KQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXNzaWduX3VuaXF1ZV9jbGllbnRpZChjbHAp
Ow0KPiA+ID4gPiANCj4gPiA+ID4gV2h5IHNob3VsZG4ndCB0aGlzIGdvIGluIG5mc19uZXRuc19j
bGllbnRfYWxsb2M/IEF0IHRoaXMgcG9pbnQgDQo+ID4gPiA+IHlvdSd2ZQ0KPiA+ID4gPiBhbHJl
YWR5IHB1Ymxpc2hlZCB0aGUgcG9pbnRlciBpbiBuZXRucywgc28geW91J3JlIHByb25lIHRvDQo+
ID4gPiA+IHJhY2VzLg0KPiA+ID4gDQo+ID4gPiBObyByZWFzb24gaXQgc2hvdWxkbid0LCBJJ2xs
IHB1dCBpdCB0aGVyZSBpZiB0aGF0J3Mgd2hhdCB5b3UNCj4gPiA+IHdhbnQuDQo+ID4gPiANCj4g
PiA+IEkgdGhvdWdodCB0aGF0J3Mgd2h5IGl0IHdhcyBSQ1UtZWQsIGFuZCBmaWd1cmVkIHdlJ2Qg
anVzdCBkbyBpdCANCj4gPiA+IGJlZm9yZQ0KPiA+ID4gdGhlDQo+ID4gPiB1ZXZlbnQuDQo+ID4g
PiANCj4gPiA+ID4gQWxzbywgd2h5IHRoZSBleGNsdXNpb24gb2YgaW5pdF9uZXQ/DQo+ID4gPiAN
Cj4gPiA+IEJlY2F1c2Ugd2UncmUgdW5pcXVlIGVub3VnaCBpZiB3ZSdyZSBub3QgaW4gYSBuZXR3
b3JrIG5hbWVzcGFjZSwNCj4gPiA+IGFuZCANCj4gPiA+IGFueQ0KPiA+ID4gYWRkaXRpb25hbCB1
bmlxdWVuZXNzIHdlIG1pZ2h0IG5lZWQgKGR1ZSB0byBOQVQsIG9yIGNsb25lZCBWTXMpIA0KPiA+
ID4gL3Nob3VsZC8NCj4gPiA+IGJlDQo+ID4gPiBnZXR0aW5nIGZyb20gdWRldiwgYXMgeW91IGVu
dmlzaW9uZWQuwqAgVGhhdCB3YXksIGlmIHdlIGFyZQ0KPiA+ID4gZ2V0dGluZw0KPiA+ID4gdW5p
cXVpZmllZCwgaXRzIGZyb20gYSBzb3VyY2UgdGhhdCdzIGxpa2VseQ0KPiA+ID4gcGVyc2lzdGVu
dC9kZXRlcm1pbmlzdGljLg0KPiA+ID4gSWYgd2UNCj4gPiA+IGp1c3QgZ2VuZXJhdGUgYSByYW5k
b20gdW5pcXVpZmllciwgaXRzIGdvaW5nIHRvIGJlIGRpZmZlcmVudCBuZXh0DQo+ID4gPiBib290
DQo+ID4gPiBpZg0KPiA+ID4gdGhlcmUncyBubyB1ZGV2IHJ1bGUgYW5kIHVzZXJzcGFjZSBoZWxw
ZXJzLsKgIFRoYXQncyBnb2luZyB0byBtYWtlDQo+ID4gPiB0aGluZ3MNCj4gPiA+IGENCj4gPiA+
IGxvdCB3b3JzZSBmb3Igc2ltcGxlIHNldHVwcy4NCj4gPiANCj4gPiBJIGxpa2VkIHRoaXMgcGF0
Y2ggYXQgZmlyc3QsIGJ1dCBJIG5vIGxvbmdlciB0aGluayBpdCBpcyBhIGdvb2QNCj4gPiBpZGVh
Lg0KPiA+IA0KPiA+IEl0IGlzIHF1aXRlIHBvc3NpYmxlIHRvZGF5IGZvciBjb250YWluZXJzIHRv
IHByb3ZpZGUgc3VmZmljaWVudA0KPiA+IHVuaXF1ZW5lc3Mgc2ltcGx5IGJ5IHNldHRpbmcgYSB1
bmlxdWUgaG9zdG5hbWUgYmVmb3JlIHRoZSBmaXJzdCBORlMNCj4gPiBtb3VudC4NCj4gPiBRdWl0
ZSBwb3NzaWJseSBzb21lIGNvbnRhaW5lcnMgYWxyZWFkeSBkbyB0aGlzLCBhbmQgYXJlIHdvcmtp
bmcNCj4gPiBwZXJmZWN0bHkuDQo+ID4gDQo+ID4gSWYgd2UgYWRkIG5ldyByYW5kb21uZXNzLCB0
aGUgdGhleSB3aWxsIGdldCBhIGRpZmZlcmVudCBpZGVudGlmaWVyDQo+ID4gb24NCj4gPiBlYWNo
IGJvb3QuwqAgVGhpcyBpcyBiYWQgZm9yIGV4YWN0bHkgdGhlIHNhbWUgcmVhc29uIHRoYXQgaXQg
aXMgYmFkDQo+ID4gZm9yDQo+ID4gIm5ldCA9PSAmaW5pdF9uZXQiLg0KPiA+IA0KPiA+IGkuZS7C
oCBJIGJlbGlldmUgdGhpcyBwYXRjaCBjb3VsZCBjYXVzZSBhIHJlZ3Jlc3Npb24gZm9yIHdvcmtp
bmcNCj4gPiBzaXRlcy4NCj4gPiBUaGUgcmVncmVzc2lvbiBtYXkgbm90IGJlIGltbWVkaWF0ZWx5
IG9idmlvdXMsIGJ1dCBpdCBtYXkgc3RpbGwgYmUNCj4gPiB0aGVyZS4NCj4gPiBGb3IgdGhpcyBy
ZWFzb24sIEkgdGhpbmsgdGhpcyBwYXRjaCBzaG91bGQgYmUgZHJvcHBlZC4NCj4gDQo+IEkgYWdy
ZWUsIFRyb25kIHBsZWFzZSBkcm9wIHRoaXMgcGF0Y2guDQo+IA0KPiANClNpbmNlIGl0IHdhcyBh
bHJlYWR5IHB1c2hlZCB0byBsaW51eC1uZXh0LCBpdCB3aWxsIGhhdmUgdG8gYmUgcmV2ZXJ0ZWQu
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
