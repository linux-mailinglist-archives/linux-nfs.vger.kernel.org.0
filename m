Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6424C3CDA
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 05:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiBYEAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 23:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBYEAx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 23:00:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3134235319
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 20:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEqdBsSpr6UouBOsXaX7Xi4Dmk9sSon7MGJKWr8ZJ+Q7kJI3Pbxm7ihrbHKr2jQuZS0CY8PRVkrFK80vPlzddVbKfBsww6TdZVZ+EjhtVW66F10SqqsVM5jrjpbkAH+ys7Xl3g1kaSnbGhLch7au+i9jUtBWlf8weO8gAnSf/R1mm1PG0bkQqD/OC212+VA9gNj2aiO2smefIGccyC9lRSBEhG83jGxM2E0Ccg6yKkZXiLOye+RNlTJv1tQpO9Khn9eK6EZfsU55RweaL4p2LXjlmPVmwG4ZJ04XMXwWlunyzEV/IIdoW1ZmXpoO/0bZyOW43wtn6kpM/+7836kJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoHC+Rv+I5qgdJAhMbZsOjg9sSSjPtJZpc5LOo2kkC4=;
 b=iPzH53u7lSUNS5KcnT3RgV70zXjKiliHHbidqydeK86m0IdJ8cPv+H+3+dX8llpv7s9BCy1Wk38XVVj6H99zSJdksnZy33vGsygxapjmFa10ryjS9vPAQwseapyjyZPpHruaCWReetBzr9hyANmKvDE1YGUwDor+1ILSd+qu9OLVtdmck6D4VUnb3ZBGccFmyPvpDrESO8NOYNyovXrw+KwVscaBCQzkWGo3ZRocYnSzCDGlZ6GtvOSb/LewZQvdR8iMSErT/ZjvsKP7tYdEMup1s9VybWqv2T5x2LfTywQI0Wh/uM4893PUrATquEBCTzAct5j0SrG+x0Ht73d1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoHC+Rv+I5qgdJAhMbZsOjg9sSSjPtJZpc5LOo2kkC4=;
 b=AtP0fW6ezIDPIjCVhz1p7V569qerjgVLM1inGme6PrevBfh8PJx7zddFpTf3h0A4DdNNcrLXBVgKXk8cDPXGGLl3SzXAEcooT2aKXkHFJLX+BWHiZ5tjqDuGNACD/T9SztqgvdpH36+Nz0NkPSeVebjg1aqiYo5e8K3m9HOEDRM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5840.namprd13.prod.outlook.com (2603:10b6:303:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 04:00:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 04:00:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 00/21] Readdir improvements
Thread-Topic: [PATCH v7 00/21] Readdir improvements
Thread-Index: AQHYKPu3ABcRUoJly0uzFSgdDj/3hayioToAgAEFNIA=
Date:   Fri, 25 Feb 2022 04:00:18 +0000
Message-ID: <f67776ef169f8279e14931d61f9aaeaae04f4b52.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <CALF+zOnjJoy6mEZ9R0UwxDuSKRB5ODJmh=QnjkM+8wC_AJut6A@mail.gmail.com>
In-Reply-To: <CALF+zOnjJoy6mEZ9R0UwxDuSKRB5ODJmh=QnjkM+8wC_AJut6A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd1492b1-c624-40d0-7600-08d9f813569e
x-ms-traffictypediagnostic: MW4PR13MB5840:EE_
x-microsoft-antispam-prvs: <MW4PR13MB58409E2E812F9132708F1DDAB83E9@MW4PR13MB5840.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47SvECsUHj+gGZOaGI1S7oKhQexuphrw6K86oCOHs8vh0emJDMT+7KCe61qWxnvqs73gbGc+jNKsafb5veEa70Q+V6quPr51owQWQLQBJOvdwm4Qgg2i8MJ/TFiVMOEvnTjPEmUyUWNuIhSRKcLkN7fAes7hhX1uimzcDOSRBVrzntF5UEw5Tls4QyPl5XjOiO5EEyclfIfv+NE/hq82McOEwpDVG9f4qIpup3EjbiH0uVGdcQ89ukVBnwTiolFO4/2uJaAJTRYiVeVW595R0LetLbHM4nTK6vcvXvjMBd9d/JI8EyW+ODQpFgIl4Sh+UZkob0j1RVfHC5hwBhCraeQIuc5q8yCwmRXnOspa6Hl1PO4iA8JheVfm7ZkI7xI6D7H3z+kcnVodUYBGThD3lGlmU3Pped7f7F/Jy+XMLjUnWaLSE5RK60kJrg74M9mJTgkgCUBYPGxh9Ug4EjJHdYwCkUX9mF1JfcESYP0rHg7MDGHgRh+zW7sg8BjcQ0vBTiMn80c6/mXI6ZpjYFLXnjtTtBwwMqTruam3o59r4vZtwW1TMOYw2xMdljpqFUonsQpsq9VvT3ZLaEqVxRN1MQveM7761xIQEMf75lBSIOwrHqqolMOsDF7TwnhgzPUy9ZrhkpynZAH0JEODV/7uupZzSEXZ/iZ6U0CI4vNVrk6rbSAKFhO93/3Wn2ok9haMC4Q1UFVgbM0stPefvxuyjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(136003)(376002)(396003)(346002)(39840400004)(4326008)(38070700005)(508600001)(316002)(66446008)(8676002)(66946007)(86362001)(64756008)(66476007)(66556008)(2616005)(6486002)(76116006)(26005)(186003)(122000001)(6512007)(71200400001)(38100700002)(110136005)(83380400001)(53546011)(5660300002)(36756003)(6506007)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YS93OTVSU1luK2w2K1RJMldFbmZDazRXTys4bzdDSkVpUU9rMUtscVJOY3lM?=
 =?utf-8?B?aS9zM21INlg4dFp5RGpSSlExenBrM0J4c3M0ZTZodWRsZm16dzJUKytzT0pT?=
 =?utf-8?B?cmdQOUJZNmFaa3h1WmpHK1NmVjR3K0kvcVIrOFU5U2JPYmE5dHB5elRqcU42?=
 =?utf-8?B?WmFSaWRkRmV2TmhLdC9wNGpHZ2lBdDFqNGxjRXdUZjI2V001Z3pYSUU5OVYv?=
 =?utf-8?B?ZkpJZ0xaS1Z3Y2VrYXo4S0NaQTdXbnhKQUtoeTlCREFIWm1PWlFSZGN0Q1RD?=
 =?utf-8?B?WEl2QW0wYVRld0ZXb2lXN0diTFRMenVUM2RhSXROclV5WUR3cnNpZWpSRFFY?=
 =?utf-8?B?bEFGNnpmSlJXWDdaVnduancxeWJ4YVFhNEh2MHByQ3pMWnZud0VOWHdORzMw?=
 =?utf-8?B?QnNSRk9oaHlod20vS1BCVlpPbm5rQlFQMkF3eTZaNGVHRjhQbEpoMWc2MzRt?=
 =?utf-8?B?MTBwSnRkYktaMHhmWEFlM3NrQ091UEl3UlVVR1lURVlnbTAvV0g5VE9oN0hr?=
 =?utf-8?B?NlF6dUwyb2hhRTBSZmxtYklRTDI2NXhIN2d2c01Ic0FEVFFOTGNpUzZrSHlp?=
 =?utf-8?B?MmhmQ3lkYkxKVU91NzRKb2t2VnRDcUtKeVl2d2h3ZW92ZEtaOGVHQlhkRktp?=
 =?utf-8?B?Qmt3WklRYklLL2JSK2t5UXByY2MrL2tnWkJvWUNWbFkreEV4SjEwYUN6UXpH?=
 =?utf-8?B?QWxxSlFnY2E4U0ZWRHc3Ly8zQjkzSGx4L0JzN2Q5OWtYbWVyejVJMG5wUGlx?=
 =?utf-8?B?QThiR3I0RjQ5cGJzZ2R3bXpScGJNSi9KRTJpLysrdnZnZkdGWlZaZ1FSbUFk?=
 =?utf-8?B?L0JBankzMWQ2aDdINWI2UVNNN2NrMUpkcERZbk9nTm8xZmF1bzI1OVczWFJ3?=
 =?utf-8?B?eGpOVmpXYzdaNDJCaXlQcm1MNGh5MjU2aERGREZXQWN1SUZiQzJSeXlJTkpq?=
 =?utf-8?B?L1F5V0xBemRvZEF4MEFJS1JnZlBRNmQvZ0FSRmxXNk11Ty9lZ1JLUUluekZQ?=
 =?utf-8?B?dzhxQ1FvRnp0TU43MEdHL2ozS21iZkZ2NFlDcUFFdHkvdmdlamFUMktEVDVl?=
 =?utf-8?B?NXcvU3lBNno1QmtjOUpORnhnRGxNOVJGS1MxYUJrNmZ0M1NFSUluTnhsa1Uv?=
 =?utf-8?B?WG5TdUYrVUpFejRqUUJxZnRqQkhJYXJLVlplUVFNQ1NCdDBhTWc4WjViYWVP?=
 =?utf-8?B?emhUQUFYTFFSUTMveFN2dkdKSmNia2IwVktEREkvaTVTRzZjMjl3MjcrcHpy?=
 =?utf-8?B?OVJ2MHFyWFRQeTFJYUJGRzk5alpvdTRKUXNsTEZlRnZBVmRjU1EySHBnMjNR?=
 =?utf-8?B?MHJYVXlQbEF2V256aW9kc2krUGJqTUY4WXMwaVMydXprMnhyazNPaUFpbkpn?=
 =?utf-8?B?TlV1ZWlPVXZRRFVsbDJ6VXJtOGlVMkQvNEltZUZ0eHJFZG9HYnpWM2ZhWWdI?=
 =?utf-8?B?T3FZQVJySE9GRTVHVjlJSjdrdmQ4Tm1PRUFBaVRBMi8vNFFDZUxGTVZ2UXAz?=
 =?utf-8?B?NXZqY000bDBjQzdvVklaTDRYZHVtVno0S21OSXY5UmhCMW5KUGlIamxXNzFD?=
 =?utf-8?B?UW1XRUw3dkxvWlZLdE5WYk03bkdmTXpkSk1oVUNsUGtjUDY4eG5vMHBhdGRp?=
 =?utf-8?B?QzdKNHZyUDJrUnAyaUI5Wlo1cHd0R0xmdWdmMHc1dmo4aWRST093OWpyUXlJ?=
 =?utf-8?B?VThMSkY2T2VWdWQ0UnhvMkoyTFJSS3JXa1pmYWdkNzR6ZWwwWFFNK2dQelFT?=
 =?utf-8?B?UUk0RnNrb2F2TndrRkJBOUhNTXVzcld4eGpremcybGo3SDJVbU83NTY5bThG?=
 =?utf-8?B?Ly9LSTlrWGhhVW5JbFh6S0ZkemlIaEEvUTl5ak12VWVUNlNKQVBlWUdsb25p?=
 =?utf-8?B?Smw4WG9hUHlrdjJKeHl4MXUxdnBZTk5EbU9vOFY4MGZsMXZKbHY5aEhiOXVO?=
 =?utf-8?B?TFp1c3NFSjBXYTJxS1dEMXJZbjFmZUFIRFdEczFOWjBWRi9vWHZaT29Nb3pH?=
 =?utf-8?B?RFk3L1MzdEo4ZmRDdHdsQ0NaUWlsckpQSHNVaW5kVit4Zi8rTWU1UzRCSTdP?=
 =?utf-8?B?Y2ZDRUJjWE5UdXY4Y2dyZEJJak9sU0kvcHlPNzY0SGVxUUw1V0plVGdyWUUz?=
 =?utf-8?B?VEE0NThoVnhWSkhjNU95MVRkRS84K1lMZWpWdEFTK1FmTDhqQXRmb0p0UFV2?=
 =?utf-8?Q?t3lH/dz9XqMVZyBCM1f/2vw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6F45D27451CAC4C912AE0A64A7CD282@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1492b1-c624-40d0-7600-08d9f813569e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 04:00:19.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvmDPu6pSlaYMyWakqXEzl/MZBMmPMkVifqGYxtCQPL9Upyc3/j8YhZKwCg9Gn9qMbRsUpOd2lxT8NdSgPNIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDA3OjI1IC0wNTAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gV2VkLCBGZWIgMjMsIDIwMjIgYXQgNDoyNCBQTSA8dHJvbmRteUBrZXJuZWwub3Jn
PiB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gVGhlIGN1cnJlbnQgTkZTIHJlYWRkaXIgY29k
ZSB3aWxsIGFsd2F5cyB0cnkgdG8gbWF4aW1pc2UgdGhlIGFtb3VudA0KPiA+IG9mDQo+ID4gcmVh
ZGFoZWFkIGl0IHBlcmZvcm1zIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQgd2UgY2FuIGNhY2hlIGFu
eXRoaW5nDQo+ID4gdGhhdA0KPiA+IGlzbid0IGltbWVkaWF0ZWx5IHJlYWQgYnkgdGhlIHByb2Nl
c3MuDQo+ID4gVGhlcmUgYXJlIHNldmVyYWwgY2FzZXMgd2hlcmUgdGhpcyBhc3N1bXB0aW9uIGJy
ZWFrcyBkb3duLA0KPiA+IGluY2x1ZGluZw0KPiA+IHdoZW4gdGhlICdscyAtbCcgaGV1cmlzdGlj
IGtpY2tzIGluIHRvIHRyeSB0byBmb3JjZSB1c2Ugb2YNCj4gPiByZWFkZGlycGx1cw0KPiA+IGFz
IGEgYmF0Y2ggcmVwbGFjZW1lbnQgZm9yIGxvb2t1cC9nZXRhdHRyLg0KPiA+IA0KPiA+IFRoaXMg
c2VyaWVzIGFsc28gaW1wbGVtZW50IEJlbidzIHBhZ2UgY2FjaGUgZmlsdGVyIHRvIGVuc3VyZSB0
aGF0DQo+ID4gd2UgY2FuDQo+ID4gaW1wcm92ZSB0aGUgYWJpbGl0eSB0byBzaGFyZSBjYWNoZWQg
ZGF0YSBiZXR3ZWVuIHByb2Nlc3NlcyB0aGF0IGFyZQ0KPiA+IHJlYWRpbmcgdGhlIHNhbWUgZGly
ZWN0b3J5IGF0IHRoZSBzYW1lIHRpbWUsIGFuZCB0byBhdm9pZCBsaXZlLQ0KPiA+IGxvY2tzDQo+
ID4gd2hlbiB0aGUgZGlyZWN0b3J5IGlzIHNpbXVsdGFuZW91c2x5IGNoYW5naW5nLg0KPiA+IA0K
PiA+IC0tDQo+ID4gdjI6IFJlbW92ZSByZXNldCBvZiBkdHNpemUgd2hlbiBORlNfSU5PX0ZPUkNF
X1JFQURESVIgaXMgc2V0DQo+ID4gdjM6IEF2b2lkIGV4Y2Vzc2l2ZSB3aW5kb3cgc2hyaW5raW5n
IGluIHVuY2FjaGVkX3JlYWRkaXIgY2FzZQ0KPiA+IHY0OiBUcmFjayAnbHMgLWwnIGNhY2hlIGhp
dC9taXNzIHN0YXRpc3RpY3MNCj4gPiDCoMKgwqAgSW1wcm92ZWQgYWxnb3JpdGhtIGZvciBmYWxs
aW5nIGJhY2sgdG8gdW5jYWNoZWQgcmVhZGRpcg0KPiA+IMKgwqDCoCBTa2lwIHJlYWRkaXJwbHVz
IHdoZW4gZmlsZXMgYXJlIGJlaW5nIHdyaXR0ZW4gdG8NCj4gPiB2NTogYnVnZml4ZXMNCj4gPiDC
oMKgwqAgU2tpcCByZWFkZGlycGx1cyB3aGVuIHRoZSBhY2Rpcm1heC9hY3JlZ21heCB2YWx1ZXMg
YXJlIGxvdw0KPiA+IMKgwqDCoCBSZXF1ZXN0IGEgZnVsbCBYRFIgYnVmZmVyIHdoZW4gZG9pbmcg
UkVBRERJUlBMVVMNCj4gPiB2NjogQWRkIHRyYWNpbmcNCj4gPiDCoMKgwqAgRG9uJ3QgaGF2ZSBs
b29rdXAgcmVxdWVzdCByZWFkZGlycGx1cyB3aGVuIGl0IHdvbid0IGhlbHANCj4gPiB2NzogSW1w
bGVtZW50IEJlbidzIHBhZ2UgY2FjaGUgZmlsdGVyDQo+ID4gwqDCoMKgIFJlZHVjZSB0aGUgdXNl
IG9mIHVuY2FjaGVkIHJlYWRkaXINCj4gPiDCoMKgwqAgQ2hhbmdlIGluZGV4aW5nIG9mIHRoZSBw
YWdlIGNhY2hlIHRvIGltcHJvdmUgc2Vla2RpcigpDQo+ID4gcGVyZm9ybWFuY2UuDQo+ID4gDQo+
ID4gVHJvbmQgTXlrbGVidXN0ICgyMSk6DQo+ID4gwqAgTkZTOiBjb25zdGlmeSBuZnNfc2VydmVy
X2NhcGFibGUoKSBhbmQgbmZzX2hhdmVfd3JpdGViYWNrcygpDQo+ID4gwqAgTkZTOiBUcmFjZSBs
b29rdXAgcmV2YWxpZGF0aW9uIGZhaWx1cmUNCj4gPiDCoCBORlM6IFVzZSBremFsbG9jKCkgdG8g
YXZvaWQgaW5pdGlhbGlzaW5nIHRoZSBuZnNfb3Blbl9kaXJfY29udGV4dA0KPiA+IMKgIE5GUzog
Q2FsY3VsYXRlIHBhZ2Ugb2Zmc2V0cyBhbGdvcml0aG1pY2FsbHkNCj4gPiDCoCBORlM6IFN0b3Jl
IHRoZSBjaGFuZ2UgYXR0cmlidXRlIGluIHRoZSBkaXJlY3RvcnkgcGFnZSBjYWNoZQ0KPiA+IMKg
IE5GUzogSWYgdGhlIGNvb2tpZSB2ZXJpZmllciBjaGFuZ2VzLCB3ZSBtdXN0IGludmFsaWRhdGUg
dGhlIHBhZ2UNCj4gPiBjYWNoZQ0KPiA+IMKgIE5GUzogRG9uJ3QgcmUtcmVhZCB0aGUgZW50aXJl
IHBhZ2UgY2FjaGUgdG8gZmluZCB0aGUgbmV4dCBjb29raWUNCj4gPiDCoCBORlM6IEFkanVzdCB0
aGUgYW1vdW50IG9mIHJlYWRhaGVhZCBwZXJmb3JtZWQgYnkgTkZTIHJlYWRkaXINCj4gPiDCoCBO
RlM6IFNpbXBsaWZ5IG5mc19yZWFkZGlyX3hkcl90b19hcnJheSgpDQo+ID4gwqAgTkZTOiBSZWR1
Y2UgdXNlIG9mIHVuY2FjaGVkIHJlYWRkaXINCj4gPiDCoCBORlM6IEltcHJvdmUgaGV1cmlzdGlj
IGZvciByZWFkZGlycGx1cw0KPiA+IMKgIE5GUzogRG9uJ3QgYXNrIGZvciByZWFkZGlycGx1cyB1
bmxlc3MgaXQgY2FuIGhlbHAgbmZzX2dldGF0dHIoKQ0KPiA+IMKgIE5GU3Y0OiBBc2sgZm9yIGEg
ZnVsbCBYRFIgYnVmZmVyIG9mIHJlYWRkaXIgZ29vZG5lc3MNCj4gPiDCoCBORlM6IFJlYWRkaXJw
bHVzIGNhbid0IGhlbHAgbG9va3VwIGZvciBjYXNlIGluc2Vuc2l0aXZlDQo+ID4gZmlsZXN5c3Rl
bXMNCj4gPiDCoCBORlM6IERvbid0IHJlcXVlc3QgcmVhZGRpcnBsdXMgd2hlbiByZXZhbGlkYXRp
b24gd2FzIGZvcmNlZA0KPiA+IMKgIE5GUzogQWRkIGJhc2ljIHJlYWRkaXIgdHJhY2luZw0KPiA+
IMKgIE5GUzogVHJhY2UgZWZmZWN0cyBvZiByZWFkZGlycGx1cyBvbiB0aGUgZGNhY2hlDQo+ID4g
wqAgTkZTOiBUcmFjZSBlZmZlY3RzIG9mIHRoZSByZWFkZGlycGx1cyBoZXVyaXN0aWMNCj4gPiDC
oCBORlM6IENvbnZlcnQgcmVhZGRpciBwYWdlIGNhY2hlIHRvIHVzZSBhIGNvb2tpZSBiYXNlZCBp
bmRleA0KPiA+IMKgIE5GUzogRml4IHVwIGZvcmNlZCByZWFkZGlycGx1cw0KPiA+IMKgIE5GUzog
UmVtb3ZlIHVubmVjZXNzYXJ5IGNhY2hlIGludmFsaWRhdGlvbnMgZm9yIGRpcmVjdG9yaWVzDQo+
ID4gDQo+ID4gwqBmcy9uZnMvZGlyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQ1MCArKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gLS0tLQ0KPiA+IMKgZnMvbmZzL2lu
b2RlLmPCoMKgwqDCoMKgwqDCoMKgIHzCoCA0NiArKy0tLQ0KPiA+IMKgZnMvbmZzL2ludGVybmFs
LmjCoMKgwqDCoMKgIHzCoMKgIDQgKy0NCj4gPiDCoGZzL25mcy9uZnMzeGRyLmPCoMKgwqDCoMKg
wqAgfMKgwqAgNyArLQ0KPiA+IMKgZnMvbmZzL25mczRwcm9jLmPCoMKgwqDCoMKgIHzCoMKgIDIg
LQ0KPiA+IMKgZnMvbmZzL25mczR4ZHIuY8KgwqDCoMKgwqDCoCB8wqDCoCA2ICstDQo+ID4gwqBm
cy9uZnMvbmZzdHJhY2UuaMKgwqDCoMKgwqAgfCAxMjIgKysrKysrKysrKy0NCj4gPiDCoGluY2x1
ZGUvbGludXgvbmZzX2ZzLmggfMKgIDE5ICstDQo+ID4gwqA4IGZpbGVzIGNoYW5nZWQsIDQyMSBp
bnNlcnRpb25zKCspLCAyMzUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gLS0NCj4gPiAyLjM1LjEN
Cj4gPiANCj4gDQo+IFRyb25kIEkgaGF2ZSBiZWVuIGZvbGxvd2luZyB5b3VyIHdvcmsgaGVyZSB3
aXRoIHBlcmlvZGljIHRlc3RzIHRob3VnaA0KPiBub3QgZnVsbHkgZm9sbG93aW5nIGFsbCB0aGUg
cGF0Y2hlcyBjb250ZW50LsKgIEFzIHlvdSBrbm93IHRoaXMgaXMgYQ0KPiB0cmlja3kNCj4gYXJl
YSBhbmQgc2VlbXMgdG8gYmUgYSBob3RzcG90IGFyZWEgZm9yIGN1c3RvbWVycyB0aGF0IHVzZSBO
RlMsIHdpdGgNCj4gbWFueSBzY2VuYXJpb3MgdGhhdCBtYXkgZ28gd3JvbmcuwqAgVGhhbmtzIGZv
ciB5b3VyIHdvcmssIHdoaWNoIG5vdw0KPiBpbmNsdWRlcyBldmVuIHNvbWUgdHJhY2Vwb2ludHMg
YW5kIEJlbidzIHBhZ2UgY2FjaGUgZmlsbGVyLg0KPiANCj4gVGhpcyBwYXRjaHNldCBzZWVtcyB0
byBiZSB0aGUgYmVzdCBvZiBhbGwgdGhlIG9uZXMgc28gZmFyLsKgIE15DQo+IGluaXRpYWwNCj4g
dGVzdHMgKGxpc3RpbmdzIHdoZW4gbW9kaWZ5aW5nIGFzIHdlbGwgYXMgaWRsZSBkaXJlY3Rvcmll
cykgaW5kaWNhdGUNCj4gdGhhdCB0aGUgaXNzdWUgdGhhdCBHb256YWxvIHJlcG9ydGVkIG9uIEph
biAxNHRoIFsxXSBsb29rcyB0byBiZQ0KPiBmaXhlZA0KPiBieSB0aGlzIHNldCwgYnV0IEknbGwg
bGV0IGhpbSBjb25maXJtLsKgIEknbGwgZG8gc29tZSBtb3JlIHRlc3RpbmcgYW5kDQo+IGxldCB5
b3Uga25vdyBpZiB0aGVyZSdzIGFueXRoaW5nIGVsc2UgSSBmaW5kLsKgIElmIHRoZXJlJ3JlIHNv
bWUNCj4gc2NlbmFyaW9zIChtb3VudCBvcHRpb25zLCBzZXJ2ZXJzLCBldGMpIHlvdSBuZWVkIG1v
cmUgdGVzdGluZyBvbiwgbGV0DQo+IHVzIGtub3cgYW5kIHdlJ2xsIHRyeSB0byBtYWtlIHRoYXQg
aGFwcGVuLg0KPiANCj4gWzFdIFtQQVRDSF0gTkZTOiBsaW1pdCBibG9jayBzaXplIHJlcG9ydGVk
IGZvciBkaXJlY3Rvcmllcw0KPiANCg0KVGhhbmtzIERhdmUhIEkgdmVyeSBtdWNoIGFwcHJlY2lh
dGUgeW91ciB0ZXN0aW5nIHRoZSBwYXRjaGVzLiBUaGlzIGlzIGENCnZlcnkgY29tcGxleCBhcmVh
IGR1ZSB0byB0aGUgaW50ZXJwbGF5IG9mIHJlYWRkaXIvcmVhZGRpcnBsdXMsIHRoZQ0KZGNhY2hl
IGFuZCB0aGUgYXR0cmlidXRlIGNhY2hlLCBhbmQgc28gaXQgaXMga2V5IHRvIGdldCBhcyBtdWNo
DQpzdGF0aXN0aWNzIGFzIHBvc3NpYmxlLiBUaGFua3MgYWdhaW4gdG8geW91IGFuZCBSZWQgSGF0
IGZvcg0KY29udHJpYnV0aW5nIHRvIHRoYXQgZWZmb3J0Lg0KDQpUaGFua3MgYWxzbyB0byBCZW4g
Zm9yIGhpcyBjb21tZW50cyBhbmQgcmV2aWV3cy4gSGlzIGluc2lnaHRzIGFyZSBrZXkNCnRvIHRo
ZSBwcm9ncmVzcyB3ZSBhcHBlYXIgdG8gYmUgbWFraW5nLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
