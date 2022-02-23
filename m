Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7F4C1DC3
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbiBWVcE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiBWVcD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:32:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0DDEE9
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:31:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFIWTjXldvL2w2hQlvpwLcnJ7JVi2h1kwlpldw2HMzOqx+g99fbZEpapnvbOCwHkueiFtN0Yb5x7nNHA7H8fhTpfrd0/GNvsTOQEDe0du5WAOP97sEpbodnSEN3AgpU8zXLRSSE3pnho1ZZ0Ht3SfvEIWSGl4jZwH2PUFLQTwY/y3Jx4g21qXA0mo4plbERAsit6vHRjG+cezp11pxAe7leWmB6Oeu2Q+8m7g1QR3ab8FxqumDU03CziiFPdz2PCaz4AAmhUe9pXBUeVkGJcct4prJb6gaoPdyDN1Fq/Z/gt4iltLawTY57Z6U6fyagrIfASSDFAs+5MBm4CtUJOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2YaAOYx2nY9QOY4fzXa+zoiQ4rspz2LIlWkpclSU2g=;
 b=jnHB/FWKagB2Ub4Ey4bote+PMEv/2DtC5FzNpsZzRKm8bG/Qr2aqoHPiD9X4DhA+/2LWqT9mgj+pDNsZChbFM9pIXS0d1Dtt+7GK1iUmVq9PnJcykc8dfRxIlKgN1o7aBpNu9XrlkmHpbs9cfWArMgrLIKn9acEHl9QvofJJ3Y4lnet4i+cCnDRnedJjDK+gFad9aIEkvzMo/1CB1CPgswaifyKE1xEXHQrAO/FSK2PYti/15xVx5oYoifwJ7U5FZt7SgAfPhfcje1mQsX80Ch+MAb6HM3RosgEaLnkOXjxjfc3+5ThiQldM96fOCbzhagRtKqebstd79b02B5m3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2YaAOYx2nY9QOY4fzXa+zoiQ4rspz2LIlWkpclSU2g=;
 b=PHHzBQfzYW1KIdw/q2p6UtoxCCB2x11YKgCkVONSy4EgA09B+jqO7VpK11gH0MdILT2RsKAZZXD2SnFKnEmnEV3ll5yw7Wm+hOWcXhgPYhLI7Kcy+rFbbPXhtv0DP/wfOSNPr3q67IzZI0TxNbW+jCdHX0fBW5YbZDjbw1lgUog=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3238.namprd13.prod.outlook.com (2603:10b6:a03:18a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Wed, 23 Feb
 2022 21:31:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Wed, 23 Feb 2022
 21:31:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Topic: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Index: AQHYJz5fkvZWF2nTREGh+HaYGEm7A6yeNkSAgAA2EQCAAAazAIAACUeAgAAEHICAACQ5AIAA4liAgAB7MoCAAALgAIABCvyAgAAVnQCAAIVJgA==
Date:   Wed, 23 Feb 2022 21:31:29 +0000
Message-ID: <42417e59a1b92b1a2bfc8e775d0ff5bd1b573ed5.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
         <20220221160851.15508-2-trondmy@kernel.org>
         <20220221160851.15508-3-trondmy@kernel.org>
         <20220221160851.15508-4-trondmy@kernel.org>
         <20220221160851.15508-5-trondmy@kernel.org>
         <20220221160851.15508-6-trondmy@kernel.org>
         <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
         <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
         <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
         <b097f18981260e9a2d75f654a5c4f229391bb8bb.camel@hammerspace.com>
         <9DBD587E-C4CA-4674-B47D-92396EEEA082@redhat.com>
         <79a2c935bd5b9044c216c90ebfac3dc2e8e6b888.camel@hammerspace.com>
         <17D70218-EECB-456B-9BCA-E7FC128A4864@redhat.com>
         <4f1963e80028d6c162512465cee403c10fa2ab77.camel@hammerspace.com>
         <1C8B1E6A-F4B2-4ED0-8DF1-5E33E07924C5@redhat.com>
         <eaf28ee264047b141ce7881361a19379768ee466.camel@hammerspace.com>
         <22122A0F-4B12-4B85-9EDA-4A07CADBDDD8@redhat.com>
In-Reply-To: <22122A0F-4B12-4B85-9EDA-4A07CADBDDD8@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0461b5ab-7338-472a-054b-08d9f713dac1
x-ms-traffictypediagnostic: BY5PR13MB3238:EE_
x-microsoft-antispam-prvs: <BY5PR13MB3238ACB433F87404A690C27CB83C9@BY5PR13MB3238.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bgiluCMY1XYz2LuhOQp+f2ZZZ+hlvh/D/J6yDnDTFhhR5Cf/tJGDF4p6Xd4oDQ0roIqIFSSORo+aFoYPYuM3r3h0QZ8L8vrIZdmQxSrBjm5w/fh6tE8JPiSZrZPH+6qPho3cFQj7IKyuTpJc8au5JU0Xcf7iImhyderUKDunG0aj7OotrfHkv+BiJKAYe3BMOOfzD1M09VGRgXAVPdXN1M+cEJXr6IGHcf3OuqZYELruktPe+F9MJHuynjiYIB6+W/fMtyAqb4QHWPP7ascpp6O+O+SRl+JA1GnFECvjDp0nrqMMl8QpyceLK+yF8icDOAl0BM5AI/79gGNMZo9vKd/osafrXwgUKSMPnMqKTzVaEhWbWf7UD09E1sJ1UjWpE3N3Wat37ipSaJm12dTDwFDT2qc5ebt2CvCvEqx3mScpzN9h0hdaLvoM7/tXm4lvBcVB0yQODVyNXFkF5O+DzCAwlguxlpnWCMQ27vw+salIWbtoCG3j5JTEpbsnD6klrtvA6moo4tc5lksKUPr2AMvDmrIXJozBUnZHFDjHuesMbXnuVNlzq1AAZr2igDxqxSpwsqWoAoY5SnB4jkFIXX91LvnMIGo6PwrlVRkxMx5E/G6rPQgkOlXNROcALMaMRGI8RKB0nnlNKO9LrMX+RjyQOYYROu4pv+dd10t90TBJGSe4/3cNV2KDWeSk7HHAjWKkKKqI8ewqYr9+FReD2hfAwxw5K5rVrL8syLzQTeQJRvogzwQmY3viWWqa9mJwvawwZClDo1WDFTmZUpGFtUgk7kh8tH3c979hrpH4XgaGQi47Mq/qLmb1+mF2k3QTb6tvEhFNKDAvToBJjVAUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(346002)(136003)(39840400004)(376002)(71200400001)(53546011)(83380400001)(86362001)(6512007)(186003)(26005)(38070700005)(122000001)(2616005)(6506007)(38100700002)(66946007)(5660300002)(64756008)(8676002)(66446008)(66476007)(4326008)(66556008)(6916009)(8936002)(76116006)(36756003)(2906002)(966005)(6486002)(508600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFpyYnNsMldDdnFyVFF1VllLNmZnanNBaXhZd0lma1VDaGZsdmhzcnFMTDl0?=
 =?utf-8?B?eXp2VFRWVUFzbjRDdGhVcjZFcTR3emU5cUtISkhJK2xZTGs4QkhFaGo0a1dU?=
 =?utf-8?B?MEc1Y1AxZW5MeldoQkVnY3lEdnBLSkNlSXIxZ2pXTEpsU2M0c1BkNno2TVA3?=
 =?utf-8?B?U25KMTVpOEZ4SHF3YncyR0c5M0hsdE1nNXllcXJBcUVpM1FOVGxNUmZ4b3oy?=
 =?utf-8?B?S3NEUHZjZGRTekpLdWpIVlNSbFNUa0J2NlBXSjFreFJicStPS1FyaW1hYVNZ?=
 =?utf-8?B?cVp5dmlZR0pWaXpVcUxwREJqc0tMenNIeTAybkU3MUpmQk5rbVRXU2QvTE9l?=
 =?utf-8?B?elBVRkVxYjdhdDB6dmpWUnAvUDJidlgyd0J0UE9lMDlsUFpGajZyRnBNMFVC?=
 =?utf-8?B?TlJ5SUNTS0pUbVBhaVhGUllSZVpLV0hNeXdwQVFyYmxhaEhiWXNWQXUydStS?=
 =?utf-8?B?dzJkUDBPdFczNE5lMDAvbVdSY2hyV0E1ZUlBeUEyVEpmYmtEelVkTXA5S1o2?=
 =?utf-8?B?ZlFRN3d1d3IxdE5mK3VaNXFBY2NkL3Z5VXJwSS8yTVl6b3lHbHFyc1BRZkZ2?=
 =?utf-8?B?UjNBNTUwMUdXc2EzNjRpVDJ1Rm5GMHNoZGVuRmU4MSsyaEtzQnZBSmU3bHZK?=
 =?utf-8?B?R2w2enpWejIyQTk5OC81UUcxczhNNk1FekVtbWVBeFg4aiszbHEySVg1bnln?=
 =?utf-8?B?aURvMEE4aEZ1UlBoSWt0L1piQ1ZDWWRhaTRHdFV6RGxrRTMyOHg5M1ZyeDFJ?=
 =?utf-8?B?a2RCMmtjUXNSZnZEcVpMYzRHYlVlMmxkOC9obE9UWmtVUDNIbHpFeGZ3eEwr?=
 =?utf-8?B?NWZvTEpZMkVENDY4a1lBdXhtcC9SUUVxV0cwTGZ4VUtSaVhpbXdmbTRUWUtI?=
 =?utf-8?B?RHRvakVZcWJkVndKYUlWSmtQcDB3MHlBWEw4Lzh4alh0cUIxSEVsUXZWWkkv?=
 =?utf-8?B?YnBVeUkrdzUvb2REZnBhSk1nd2wyZlN4MUo1TklwTSsrRmxPblpHRHhFN0RN?=
 =?utf-8?B?Umw0a3dtWnBXakdHQnkvL3JLWVovUlJINEo0aHBSVTc0TldlVjc0emgvNTlZ?=
 =?utf-8?B?TU1hY1VlbDlFTFNac1dQVnovenk1bG1RcXZ6UmlmbGg2ZE1ONlVmMFBNcWZV?=
 =?utf-8?B?SllienhmWHZ5Mkpwd2V5QlBISEJQbWx0SFpZYTk1S2picGl0QlZWL05KNXpT?=
 =?utf-8?B?UzJWNEJWVUY5SkZYUG5wVEpXamdRQnJjRzlBR28vV2hmT0QwYTJwOEU5N3hm?=
 =?utf-8?B?MFcvRDRrZUxvdzFHQkpWY0gvR1I4RUFxUm4zWjBrdjE2azc3MFBhc0pGK3dW?=
 =?utf-8?B?QTM3cU1XT2FXTUpEUUUwTk1WMW81VEswc0RFMnVTMHFTVzBqbnZDOVQyaGxq?=
 =?utf-8?B?dDdsQi90LyttYnNwNERRd1IyMk53RXhLa0IwN004ZTFUU3NJd2Fjb3prb0h0?=
 =?utf-8?B?L2lIMzI2Q0hLU2RHZGluU3NMMzV6Qk4zaTZmUFFBMDBHZkh0eGdUOW5xZWhz?=
 =?utf-8?B?dSszdEtGYnV5bERYc05aTkN5ckdrdWZiTHZGQ3JnY0pJUnpYVUxoclJWSWg3?=
 =?utf-8?B?SFlWMGRLVUxFUnU3WWpGTXFtbU9vcVVTbHhzTXNiZC95RkdvQ29BZ1N0NVR3?=
 =?utf-8?B?d2dSOWRVZi9BQWFCeC9rZy9DSTFEWXJob1J3M0RSemcwRDV3UHhXbU5TcG9t?=
 =?utf-8?B?Y0dBTUpJMm9vYlgzMHhQa2c0Q0ZGd2J5SzdIK1RnZXRkV1pUUXJNVFU5K2pk?=
 =?utf-8?B?L3Y1TTZFU1ZZUHZRUC82NDdielU5dlc1eVF1S05XUERzbmVpeEEzUEdObXBp?=
 =?utf-8?B?UktIT0tyUWYxNkZuYkhzUGQveXhMVGhFY25pUGh0ZXN6K2hLSWZKRnlTMlVk?=
 =?utf-8?B?K1hRTktBTlltbHhiNFpEWVhRdVE3d29kYTkwZWlwWnEyYVN1THVKeWxPZkps?=
 =?utf-8?B?eGhtOTY4cHBRa2dXYU5tTEl5Z0hjUm12TlRMVmo4Sk1RdzlRUjY0cytnQmZm?=
 =?utf-8?B?U0w0NStoZ2dUQW9sRUR5N2E2aVpTVWMrellURnJRZTVQZndOanRYWGY5VmhD?=
 =?utf-8?B?d0hNOHludFdGZFhEUEx5eWh5QzFIR0pZTTFyZUFyNlFlNUsycWFVZXlxTXRT?=
 =?utf-8?B?WnMzOWhUWFpzcm9US0NmSThLQWx4czdBdDlTdis1VnhHQTc4em9jcUp1SFJh?=
 =?utf-8?Q?0xrJwduGWbBvN7gLbX1uOP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39EA34CF3BB59F44AE6F6956E3032841@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0461b5ab-7338-472a-054b-08d9f713dac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 21:31:29.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pfe+dg5cV5gxyWlZxXfjDgjUMla5pCG3YE26SL4rUxQsUSIE8Kj5YcimCbRAsifvU3ta/uY4Lz7SicTikoJPwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAyLTIzIGF0IDA4OjM0IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMyBGZWIgMjAyMiwgYXQgNzoxNywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBUdWUsIDIwMjItMDItMjIgYXQgMTU6MjEgLTA1MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiBPbiAyMiBGZWIgMjAyMiwgYXQgMTU6MTEsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBPbiBUdWUsIDIwMjItMDItMjIgYXQgMDc6NTAg
LTA1MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4gPiA+ID4gT24gMjEgRmViIDIw
MjIsIGF0IDE4OjIwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBPbiBNb24sIDIwMjItMDItMjEgYXQgMTY6MTAgLTA1MDAsIEJlbmphbWluIENvZGRpbmd0
b24NCj4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiAyMSBGZWIgMjAyMiwgYXQg
MTU6NTUsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiBXZSB3aWxsIGFsd2F5cyBuZWVkIHRoZSBhYmlsaXR5IHRvIGN1dCBvdmVyIHRvIHVu
Y2FjaGVkDQo+ID4gPiA+ID4gPiA+ID4gcmVhZGRpci4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+IFllcy4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSWYgdGhlIGNvb2tp
ZSBpcyBubyBsb25nZXIgcmV0dXJuZWQgYnkgdGhlIHNlcnZlcg0KPiA+ID4gPiA+ID4gPiA+IGJl
Y2F1c2UNCj4gPiA+ID4gPiA+ID4gPiBvbmUNCj4gPiA+ID4gPiA+ID4gPiBvciBtb3JlDQo+ID4g
PiA+ID4gPiA+ID4gZmlsZXMgd2VyZSBkZWxldGVkIHRoZW4gd2UgbmVlZCB0byByZXNvbHZlIHRo
ZQ0KPiA+ID4gPiA+ID4gPiA+IHNpdHVhdGlvbg0KPiA+ID4gPiA+ID4gPiA+IHNvbWVob3cgKElP
VzoNCj4gPiA+ID4gPiA+ID4gPiB0aGUgJ3JtIConIGNhc2UpLiBUaGUgbmV3IGFsZ29yaXRobSBf
ZG9lc18gaW1wcm92ZQ0KPiA+ID4gPiA+ID4gPiA+IHBlcmZvcm1hbmNlDQo+ID4gPiA+ID4gPiA+
ID4gb24gdGhvc2UNCj4gPiA+ID4gPiA+ID4gPiBzaXR1YXRpb25zLCBiZWNhdXNlIGl0IG5vIGxv
bmdlciByZXF1aXJlcyB1cyB0byByZWFkDQo+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4g
PiA+ID4gZW50aXJlDQo+ID4gPiA+ID4gPiA+ID4gZGlyZWN0b3J5IGJlZm9yZSBzd2l0Y2hpbmcg
b3Zlcjogd2UgdHJ5IDUgdGltZXMsIHRoZW4NCj4gPiA+ID4gPiA+ID4gPiBmYWlsDQo+ID4gPiA+
ID4gPiA+ID4gb3Zlci4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFllcywgdXNpbmcg
cGVyLXBhZ2UgdmFsaWRhdGlvbiBkb2Vzbid0IHJlbW92ZSB0aGUgbmVlZA0KPiA+ID4gPiA+ID4g
PiBmb3INCj4gPiA+ID4gPiA+ID4gdW5jYWNoZWQNCj4gPiA+ID4gPiA+ID4gcmVhZGRpci7CoCBJ
dCBkb2VzIGFsbG93IGEgcmVhZGVyIHRvIHNpbXBseSByZXN1bWUgZmlsbGluZw0KPiA+ID4gPiA+
ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gY2FjaGUgd2hlcmUNCj4gPiA+ID4gPiA+ID4gaXQgbGVm
dCBvZmYuwqAgVGhlcmUncyBubyBuZWVkIHRvIHRyeSA1IHRpbWVzIGFuZCBmYWlsDQo+ID4gPiA+
ID4gPiA+IG92ZXIuwqANCj4gPiA+ID4gPiA+ID4gQW5kDQo+ID4gPiA+ID4gPiA+IHRoZXJlJ3MN
Cj4gPiA+ID4gPiA+ID4gbm8gbmVlZCB0byBtYWtlIGEgdHJhZGUtb2ZmIGFuZCBtYWtlIHRoZSBz
aXR1YXRpb24gd29yc2UNCj4gPiA+ID4gPiA+ID4gaW4NCj4gPiA+ID4gPiA+ID4gY2VydGFpbg0K
PiA+ID4gPiA+ID4gPiBzY2VuYXJpb3MuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJ
IHRob3VnaHQgSSdkIHBvaW50IHRoYXQgb3V0IGFuZCBtYWtlIGFuIG9mZmVyIHRvIHJlLQ0KPiA+
ID4gPiA+ID4gPiBzdWJtaXQNCj4gPiA+ID4gPiA+ID4gaXQuwqANCj4gPiA+ID4gPiA+ID4gQW55
DQo+ID4gPiA+ID4gPiA+IGludGVyZXN0Pw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gQXMgSSByZWNhbGwsIEkgaGFkIGNvbmNlcm5zIGFib3V0IHRoYXQgYXBwcm9h
Y2guIENhbiB5b3UNCj4gPiA+ID4gPiA+IGV4cGxhaW4NCj4gPiA+ID4gPiA+IGFnYWluDQo+ID4g
PiA+ID4gPiBob3cgaXQgd2lsbCB3b3JrPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEV2ZXJ5IHBh
Z2Ugb2YgcmVhZGRpciByZXN1bHRzIGhhcyB0aGUgZGlyZWN0b3J5J3MgY2hhbmdlIGF0dHINCj4g
PiA+ID4gPiBzdG9yZWQNCj4gPiA+ID4gPiBvbiB0aGUNCj4gPiA+ID4gPiBwYWdlLsKgIFRoYXQs
IGFsb25nIHdpdGggdGhlIHBhZ2UncyBpbmRleCBhbmQgdGhlIGZpcnN0IGNvb2tpZQ0KPiA+ID4g
PiA+IGlzDQo+ID4gPiA+ID4gZW5vdWdoDQo+ID4gPiA+ID4gaW5mb3JtYXRpb24gdG8gZGV0ZXJt
aW5lIGlmIHRoZSBwYWdlJ3MgZGF0YSBjYW4gYmUgdXNlZCBieQ0KPiA+ID4gPiA+IGFub3RoZXIN
Cj4gPiA+ID4gPiBwcm9jZXNzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoaWNoIG1lYW5zIHRo
YXQgd2hlbiB0aGUgcGFnZWNhY2hlIGlzIGRyb3BwZWQsIGZpbGxlcnMgZG9uJ3QNCj4gPiA+ID4g
PiBoYXZlIHRvDQo+ID4gPiA+ID4gcmVzdGFydA0KPiA+ID4gPiA+IGZpbGxpbmcgdGhlIGNhY2hl
IGF0IHBhZ2UgaW5kZXggMCwgdGhleSBjYW4gY29udGludWUgdG8gZmlsbA0KPiA+ID4gPiA+IGF0
DQo+ID4gPiA+ID4gd2hhdGV2ZXINCj4gPiA+ID4gPiBpbmRleCB0aGV5IHdlcmUgYXQgcHJldmlv
dXNseS7CoCBJZiBhbm90aGVyIHByb2Nlc3MgZmluZHMgYQ0KPiA+ID4gPiA+IHBhZ2UNCj4gPiA+
ID4gPiB0aGF0DQo+ID4gPiA+ID4gZG9lc24ndA0KPiA+ID4gPiA+IG1hdGNoIGl0cyBwYWdlIGlu
ZGV4LCBjb29raWUsIGFuZCB0aGUgY3VycmVudCBkaXJlY3Rvcnkncw0KPiA+ID4gPiA+IGNoYW5n
ZQ0KPiA+ID4gPiA+IGF0dHIsIHRoZQ0KPiA+ID4gPiA+IHBhZ2UgaXMgZHJvcHBlZCBhbmQgcmVm
aWxsZWQgZnJvbSB0aGF0IHByb2Nlc3MnIGluZGV4aW5nLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gQSBmZXcgb2YgdGhlIGNvbmNlcm5zIEkgaGF2ZSByZXZvbHZlIGFyb3VuZA0KPiA+ID4gPiA+
ID4gdGVsbGRpcigpL3NlZWtkaXIoKS4gSWYNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4g
cGxhdGZvcm0gaXMgMzItYml0LCB0aGVuIHdlIGNhbm5vdCB1c2UgY29va2llcyBhcyB0aGUNCj4g
PiA+ID4gPiA+IHRlbGxkaXIoKQ0KPiA+ID4gPiA+ID4gb3V0cHV0LA0KPiA+ID4gPiA+ID4gYW5k
IHNvIG91ciBvbmx5IG9wdGlvbiBpcyB0byB1c2Ugb2Zmc2V0cyBpbnRvIHRoZSBwYWdlDQo+ID4g
PiA+ID4gPiBjYWNoZQ0KPiA+ID4gPiA+ID4gKHRoaXMNCj4gPiA+ID4gPiA+IGlzDQo+ID4gPiA+
ID4gPiB3aHkgdGhpcyBwYXRjaCBjYXJ2ZXMgb3V0IGFuIGV4Y2VwdGlvbiBpZiBkZXNjLT5kaXJf
Y29va2llDQo+ID4gPiA+ID4gPiA9PQ0KPiA+ID4gPiA+ID4gMCkuDQo+ID4gPiA+ID4gPiBIb3cN
Cj4gPiA+ID4gPiA+IHdvdWxkIHRoYXQgd29yayB3aXRoIHlvdSBzY2hlbWU/DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gRm9yIDMyLWJpdCBzZWVrZGlyLCBwYWdlcyBhcmUgZmlsbGVkIHN0YXJ0aW5n
IGF0IGluZGV4IDAuwqANCj4gPiA+ID4gPiBUaGlzDQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiB2
ZXJ5DQo+ID4gPiA+ID4gdW5saWtlbHkgdG8gbWF0Y2ggb3RoZXIgcmVhZGVycyAodW5sZXNzIHRo
ZXkgYWxzbyBkbyB0aGUNCj4gPiA+ID4gPiBfc2FtZV8NCj4gPiA+ID4gPiBzZWVrZGlyKS4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IEV2ZW4gaW4gdGhlIDY0LWJpdCBjYXNlIHdoZXJlIGFyZSBh
YmxlIHRvIHVzZSBjb29raWVzIGZvcg0KPiA+ID4gPiA+ID4gdGVsbGRpcigpL3NlZWtkaXIoKSwg
aG93IGRvIHdlIGRldGVybWluZSBhbiBhcHByb3ByaWF0ZQ0KPiA+ID4gPiA+ID4gcGFnZQ0KPiA+
ID4gPiA+ID4gaW5kZXgNCj4gPiA+ID4gPiA+IGFmdGVyIGEgc2Vla2RpcigpPw0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFdlIGRvbid0LsKgIEluc3RlYWQgd2Ugc3RhcnQgZmlsbGluZyBhdCBpbmRl
eCAwLsKgIEFnYWluLCB0aGUNCj4gPiA+ID4gPiBwYWdlY2FjaGUNCj4gPiA+ID4gPiB3aWxsDQo+
ID4gPiA+ID4gb25seSBiZSB1c2VmdWwgdG8gb3RoZXIgcHJvY2Vzc2VzIHRoYXQgaGF2ZSBkb25l
IHRoZSBzYW1lDQo+ID4gPiA+ID4gbGxzZWVrLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMg
YXBwcm9hY2ggb3B0aW1pemVzIHRoZSBwYWdlY2FjaGUgZm9yIHByb2Nlc3NlcyB0aGF0IGFyZQ0K
PiA+ID4gPiA+IGRvaW5nDQo+ID4gPiA+ID4gc2ltaWxhcg0KPiA+ID4gPiA+IHdvcmssIGFuZCBo
YXMgdGhlIGFkZGVkIGJlbmVmaXQgb2Ygc2NhbGluZyB3ZWxsIGZvciBsYXJnZQ0KPiA+ID4gPiA+
IGRpcmVjdG9yeQ0KPiA+ID4gPiA+IGxpc3RpbmdzDQo+ID4gPiA+ID4gdW5kZXIgbWVtb3J5IHBy
ZXNzdXJlLsKgIEFsc28gYSBudW1iZXIgb2YgY2xhc3NlcyBvZiBkaXJlY3RvcnkNCj4gPiA+ID4g
PiBtb2RpZmljYXRpb25zDQo+ID4gPiA+ID4gKHN1Y2ggYXMgcmVuYW1lcywgb3IgaW5zZXJ0aW9u
cy9kZWxldGlvbnMgYXQgbG9jYXRpb25zIGENCj4gPiA+ID4gPiByZWFkZXINCj4gPiA+ID4gPiBo
YXMNCj4gPiA+ID4gPiBtb3ZlZA0KPiA+ID4gPiA+IGJleW9uZCkgYXJlIG5vIGxvbmdlciBhIHJl
YXNvbiB0byByZS1maWxsIHRoZSBwYWdlY2FjaGUgZnJvbQ0KPiA+ID4gPiA+IHNjcmF0Y2guDQo+
ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBPSywgeW91J3ZlIGdvdCBtZSBtb3JlIG9yIGxl
c3Mgc29sZCBvbiBpdC4NCj4gPiA+ID4gDQo+ID4gPiA+IEknZCBzdGlsbCBsaWtlIHRvIGZpZ3Vy
ZSBvdXQgaG93IHRvIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlIGZvcg0KPiA+ID4gPiBzZWVrZGly
DQo+ID4gPiA+IChzaW5jZSBJIGRvIGhhdmUgYW4gaW50ZXJlc3QgaW4gcmUtZXhwb3J0aW5nIE5G
UykgYnV0IEkndmUgYmVlbg0KPiA+ID4gPiBwbGF5aW5nDQo+ID4gPiA+IGFyb3VuZCB3aXRoIGEg
Y291cGxlIG9mIHBhdGNoZXMgdGhhdCBpbXBsZW1lbnQgeW91ciBjb25jZXB0IGFuZA0KPiA+ID4g
PiB0aGV5IGRvDQo+ID4gPiA+IHNlZW0gdG8gd29yayB3ZWxsIGZvciB0aGUgY29tbW9uIGNhc2Ug
b2YgYSBsaW5lYXIgcmVhZCB0aHJvdWdoDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBkaXJlY3Rvcnku
DQo+ID4gPiANCj4gPiA+IE5pY2UuwqAgSSBoYXZlIGFub3RoZXIgdmVyc2lvbiBmcm9tIHRoZSBv
bmUgSSBvcmlnaW5hbGx5IHBvc3RlZDoNCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW5mcy9jb3Zlci4xNjExMTYwMTIwLmdpdC5iY29kZGluZ0ByZWRoYXQuY29tLw0KPiA+ID4g
DQo+ID4gPiAuLiBidXQgSSBkb24ndCByZW1lbWJlciBleGFjdGx5IHRoZSBjaGFuZ2VzIGFuZCBp
dCBuZWVkcw0KPiA+ID4gcmViYXNpbmcuwqANCj4gPiA+IFNob3VsZCBJDQo+ID4gPiByZWJhc2Ug
aXQgYWdhaW5zdCB5b3VyIHRlc3RpbmcgYnJhbmNoIGFuZCBzZW5kIHRoZSByZXN1bHQ/DQo+ID4g
DQo+ID4gTXkgMiBwYXRjaGVzIGRpZCBzb21ldGhpbmcgc2xpZ2h0bHkgZGlmZmVyZW50IHRvIHlv
dXJzLCBzdG9yaW5nIHRoZQ0KPiA+IGNoYW5nZSBhdHRyaWJ1dGUgaW4gdGhlIGFycmF5IGhlYWRl
ciBpbnN0ZWFkIG9mIGluIHBhZ2VfcHJpdmF0ZS4NCj4gPiBUaGF0DQo+ID4gbWFrZXMgZm9yIGEg
c2xpZ2h0bHkgc21hbGxlciBjaGFuZ2UuDQo+IA0KPiBJIHdvcnJpZWQgdGhhdCBpbmNyZWFzaW5n
IHRoZSBzaXplIG9mIHRoZSBhcnJheSBoZWFkZXIgd291bGRuJ3QgYWxsb3cNCj4gdXMgDQo+IHRv
DQo+IHN0b3JlIGFzIG1hbnkgZW50cmllcyBwZXIgcGFnZS4NCg0KVGhlIHN0cnVjdCBuZnNfY2Fj
aGVfYXJyYXkgaGVhZGVyIGlzIDI0IGJ5dGVzIGxvbmcgd2l0aCB0aGUgY2hhbmdlDQphdHRyaWJ1
dGUgKGFzIG9wcG9zZWQgdG8gMTYgYnl0ZXMgd2l0aG91dCBpdCkuIFRoaXMgc2l6ZSBpcyBpbmRl
cGVuZGVudA0Kb2YgdGhlIGFyY2hpdGVjdHVyZSwgYXNzdW1pbmcgdGhhdCAndW5zaWduZWQgaW50
JyBpcyAzMi1iaXRzIGFuZA0KdW5zaWduZWQgY2hhciBpcyA4LWJpdHMgKGFzIGlzIGFsd2F5cyB0
aGUgY2FzZSBvbiBMaW51eCkuDQoNCk9uIGEgNjQtYml0IHN5c3RlbSwgQSBzaW5nbGUgc3RydWN0
IG5mc19jYWNoZV9hcnJheV9lbnRyeSBlbmRzIHVwIGJlaW5nDQozMiBieXRlcyBsb25nLiBTbyBp
biBhIHN0YW5kYXJkIDRrIHBhZ2Ugd2l0aCBhIDI0LWJ5dGUgb3IgMTYgYnl0ZQ0KaGVhZGVyIHlv
dSB3aWxsIGJlIGFibGUgdG8gY2FjaGUgZXhhY3RseSAxMjcgY2FjaGUgYXJyYXkgZW50cmllcy4N
Cg0KT24gYSAzMi1iaXQgc3lzdGVtLCB0aGUgY2FjaGUgZW50cnkgaXMgMjggYnl0ZXMgbG9uZyAo
dGhlIGRpZmZlcmVuY2UNCmJlaW5nIHRoZSBwb2ludGVyIGxlbmd0aCksIGFuZCB5b3UgY2FuIHBh
Y2sgMTQ1IGVudHJpZXMgaW4gdGhlIDRrIHBhZ2UuDQoNCklPVzogVGhlIGNoYW5nZSBpbiBoZWFk
ZXIgc2l6ZSBtYWtlcyBubyBkaWZmZXJlbmNlIHRvIHRoZSBudW1iZXIgb2YNCmVudHJpZXMgeW91
IGNhbiBjYWNoZSwgYmVjYXVzZSBpbiBib3RoIGNhc2VzLCB0aGUgaGVhZGVyIHJlbWFpbnMNCnNt
YWxsZXIgdGhhbiBhIHNpbmdsZSBlbnRyeS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
