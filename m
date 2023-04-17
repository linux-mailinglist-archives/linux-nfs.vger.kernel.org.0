Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C836E5424
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDQVxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDQVxe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 17:53:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778C271B
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 14:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOk0RsYlvS5AeObSXiX72MH8si91xzXVM/XkRPs1HglLXb70g1LdEbIyIHbRCJzYVUO5dXekjEFFDdlE1Q8Ntkr18CBaVqba06nqD6wTQEwruRXtJ7PEYZhwRloSCeuZOiD8j/9WsVWnit0jM/oRTocUPHDFyeBwJFRT+cZ8G0CtvCdnhWbkdcrA/CPHO6hInrFAMpkdhFE7xdOTG/DKBRca4euDhDF1vSkH8dsKw/CZLLS7gByXguxgvFwZ0MQ5fWT5/XAKRBExXKi5h75XOcPSx1OMCW2MM4BLp8cA/8DUePARSvLES35twDbY5MYJECdQ396YBYjZa6U7Ut1mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KZuRVmIuDlpEehEdzlGud5SAoP2wvON4zAEx3Vlv+M=;
 b=EQLEiTge3GrpfIrhe3ApPvybuAdKoOo4yBfaQ9Ja/tsU1sFxp67tWQxD5W32Vl4YKpECY00y//77kI7UJdkX8SmVfj90IGLLzdrjdj6Bu/f8b19qk0sXFJcu2XvEn5AX5nfrp5KHruFdRchNjjMVSVJE64+MLl3JUpPS8pybHXc4xVEMbdjE7SPQxGiHWkoXl7E5mj3frJxB+KiYfmx3vol2VbewHB85zG9MihJUdWvKmCsBcpKVh3W7lFSGr1TpcFYHrXvKIc1GsCBVLMFMn8JXyA2aD8U/ifkGYJKPie+PjSabhHFq1vMVMTsfSG3J9r18WbOfvaf/1aNPxVFmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KZuRVmIuDlpEehEdzlGud5SAoP2wvON4zAEx3Vlv+M=;
 b=CqdH6q2dJ+xFPKnnaLkyUT3ekcVyPvXrSNcUZhhj1aalspkpbj+S2DdbI2rOidAlAIbvpUkVhxw73Mz3Hlv71mJcW68jE96AVL5V5DZQLSaMNWXE3YZfQaEGiNUCLOqkujZskJZ/ENu356JMKqCfum2BA+7zHnrZBzZk5wwAMgA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO6PR13MB5308.namprd13.prod.outlook.com (2603:10b6:303:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 21:53:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 21:53:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp/6QlIRljOckmeDtcvLmj9Dq8wCLWAgAAOegCAAAHKAIAAARIAgAAAdQA=
Date:   Mon, 17 Apr 2023 21:53:29 +0000
Message-ID: <d0a5cf8b8c8dbdbf83658b9456afb798af5d7941.camel@hammerspace.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
         <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
         <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
         <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
         <19bf7b21-fc68-5281-e587-b7d290899456@oracle.com>
In-Reply-To: <19bf7b21-fc68-5281-e587-b7d290899456@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO6PR13MB5308:EE_
x-ms-office365-filtering-correlation-id: 4225c4c6-8a63-4bf6-cae5-08db3f8e2e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VyvNQKKPmfE5Uc4Kl8SHhCfSZfPNPsYZGvtrWaWR/raGWeoiaPQgNdkd+1esmSEeFJ4xAMjWDpFIlqlP6KRTynJ7En9J+RiTLa/BwyM/sokIvtfF0Wx7VBH18tp2rrnUF4EuOj4b4o//ORQ/vnKIEe1IjsKKAUBwyrTkqYNenPTJ3UV1dQbFSFmt1GrNlL+SQUO2+fMG9xAa9uaT/VNVq3NpWFHDaw9wXYhABxRPqgC6hqf6yBddiY9wxm9g3pukCNRz37H1q8dKdHOE+krV4BRTD51iYpbIFzDQrA9TCeUEBXh0ucVA4KN2CG7fjXF+Hq50+RSKwL3QZ3XZK4WnaoVoRS1T6/fo+oc/M0YSbPqbqTM08dBZssFh9RIX0Qj1ng3pdGe/orLpxmMfHr3N9ngyrzVQbgEjrSWmxeXkMzptMj4hWI1ei9yoVVdGRFw8jL1KWdUSQWJJDoBELRcBO248R0Etx1AiePAEwucxQw3AvNld9eWkmL38ZrUtwY2VaLSds43A9sr1QpjX83b330iYmlHbFZ2NVYQSSHMJC5O92zfXmHSrV3w6mwXB2zLW1+ubTkXoCgWmTg2d5LDkKZfFvxo5C8mjhEmN5BRdSbxQ9DnguMC4P/AMvW6B/EfpmuYQbJDiyNfr0q6etJLEJmTiGg6dyBvm3oOqDjq6z3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(346002)(376002)(366004)(136003)(451199021)(2906002)(76116006)(8676002)(8936002)(5660300002)(478600001)(41300700001)(316002)(64756008)(66946007)(66476007)(36756003)(83380400001)(66556008)(54906003)(66446008)(4326008)(110136005)(122000001)(6506007)(86362001)(38070700005)(38100700002)(53546011)(6512007)(186003)(6486002)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFNRGNzeU9GcmEvVUZPYWxsUjVMTzFOVFZiN3ZLWlF0ZmdEYVVVUXlxYTB0?=
 =?utf-8?B?YlcyeG1lT25MYVd3MmhTandRd1RrSklQR0lLUEFKSkp5cDB4T3hhMUo0Snp5?=
 =?utf-8?B?Zk96WDl6b0pMZ0dJK0FXdGl1NldkNzVRbFJjUC9wbGljdXh4ZjBUSllCTUxt?=
 =?utf-8?B?YXUzUEZkNklVemUwS1hWSExaWGtvcTJtcGdjSjJtWVN3bW9nT2lFTXY4djZR?=
 =?utf-8?B?Y3VrZXZqMnhURXhNZjUzV3B4TjBRU2NFS2s4ZnI4Y0dna3hDaTRZOGVmNVRL?=
 =?utf-8?B?S3BWM3JLbnh6ODdpdUFLcE9kOCtxYUR6dmVhSFhxaitjbkZxUWFZNkU3N1R2?=
 =?utf-8?B?UXBmNXk1a1czWkRtdWROcUE5RmdaVjVIUEdudSs1dnlOWGJHOEJwM0lwZk9k?=
 =?utf-8?B?N1JNejc3RGxyY05NNkw3b0VVZDlmWWtIMTN1VGx5a1FxS0NVQSsyMDBnVko3?=
 =?utf-8?B?dEtiRHU5UDNhWG9mdlFXUkxYUjlXalA2NjVramhyQ2YwVUttZkRDM1VybW5s?=
 =?utf-8?B?NEtQMDJHT1pjcThxK2lOSzRVMmpkN2VTcmxjaisyOUR1UjNsb3ZUVEFpcDRK?=
 =?utf-8?B?ME16TGlHRk5kK3ZrTklLWVF3ZXB2OThSaTJibmhxaXFOZk9IeHpwc1RzTzhQ?=
 =?utf-8?B?UTc5T25KdTd0Snh1MW9RYnVlclg4b0o5Y25JdVJjSVY4MXlWRElnaUZOQkhr?=
 =?utf-8?B?RWpqbUl5NzV3NTVmZzV3eEFraGhKcDZmM0w0bHhFS3AzUVRRalowZW5Vajd2?=
 =?utf-8?B?c2Yyb09SZllIKzB3RlRFOER2dnl3MW9oSU81V0lFenlPVGFBRXlIRjNRNUdZ?=
 =?utf-8?B?TGZHM3VvWk9CbkhzVnVBTTZvWUtPVmVWQ0J4bm11Si8xYnhzNEdMSldIcVBI?=
 =?utf-8?B?ZVE4QTlENm03blVNRytWeFVCY0dvS0FNa0cwNmVrSHo5WXhzUmZHTnNTMDNi?=
 =?utf-8?B?VXZGL2g4TGlrYVdnYStHMXh3NU5MOHhYSlQwd2YzdTVmTGx0bE0xQ2lrc1pI?=
 =?utf-8?B?SGNzZ1FobEkwOGIwYVVuOEU5K0x0blJuM1poMjd2MFU5WlUwMytkWDRtMXFM?=
 =?utf-8?B?TElsYmxUT1lSajdFOFA5eVE2NTY5ejZsKzlnZXkvK1huOUVGK3lZbXVQV2ky?=
 =?utf-8?B?WktsaC9pV1V3Wms3M3ZhQ0wzRnVOUW42N0RKSkhTbXdBSmF1YytQZ3pmRXl5?=
 =?utf-8?B?NjNpdXZUR0lHVHVhVmxFSWsxM0xpb1k2WlQ1NGl5L0YwQ0Z1Mk95eFlhSzkz?=
 =?utf-8?B?OEZwUVhBUGw1ek8zaGs5QmU5RjhVTVlZYVZMdjZkN1lmZXhKZVJ4YzdBNjlU?=
 =?utf-8?B?Vk02L0VOQ1JlMCtPTjJBQ2tRRXRqNEp4L0RQUmVaRkE5TXA0TFhOOHU5YXlL?=
 =?utf-8?B?RThNTXpOZmovRFpDaWs5aWgrQ2VzeEFlcDVHcU81bXRaYUFtWVIzY0RTT1Zy?=
 =?utf-8?B?QzAvbUFidzhtMUR2TzFJeEdMZjYxemdyZ3ZISmY1MlFLY2dnUnVrUXVyS29u?=
 =?utf-8?B?b1VqQ1pySExGRFI0cUVmczFCTDV3TkVsZmFOaWJXbkw0Vy9BTER4NjYzdVBh?=
 =?utf-8?B?YjVZbUdEY1JBcXhrZTlvcU5BcUlmYkNHcUVlcFl0Y1pibzdvK3dyV1FnQ1k5?=
 =?utf-8?B?d0dkQlM5T2ltNW1IS2lLejFOcUx0bTZ3Z1NYTGlHcm5ycGhHWWFlRjBrUUtz?=
 =?utf-8?B?ZnlmbmlvOUQ3MUJTbVZqeFhvS2Y4VC9ORElzbXJsZ05VUjFBRTF3U2t5aWZE?=
 =?utf-8?B?MnRyK3NvZytGTUw0Tnd3U3BKbWo0cWt6SVBUdk9OYjBLNVNhS3JEY3RpdG1s?=
 =?utf-8?B?ckN4UEg3endNUmM4dno1WU5aSUFkWmZ5NWFINnFpc3FXbUVBSjl6cFcveFd4?=
 =?utf-8?B?K1daVzVlMlIvcTd6RmJrdGZadVQ0NEtFSFNTcVBuckQycDd5NjBZc1d2T2lD?=
 =?utf-8?B?Q0JKd1B1bXRpb3JhTFhGSXl6alNlZGx5TVVlMVRSNWRlTFp0VklTZlR4WEtQ?=
 =?utf-8?B?bnpEVHdKUTg5RDBsY05DRUh2NDZnQ2gzNkJDVjhGdEd4bzRPUkRJQStwV2lm?=
 =?utf-8?B?QjJEREtSVXZNQytVUUo4V1dORDBpM3pSeDBtbklZRE1iUlMyYUFIVUkrcVcx?=
 =?utf-8?B?Q0VFOHJPZVl1RXhQL01rbWg4dkk4M2RkckhpUHlUUnd6aXJJWndYUGk2dktu?=
 =?utf-8?B?Z1NrZXBaVG1WT2x0RFdZSm1lU0tkb1JyblJjZlEyODl1cXRFbDVjckRHekl1?=
 =?utf-8?B?ZitOM0VGaHlkNkFZVFRKRUszRUhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EEFC7A485BB1447B8E3F3BE63C9046A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4225c4c6-8a63-4bf6-cae5-08db3f8e2e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 21:53:29.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtqM/zy7OPosgrU7nfLg866heLB0LV9FnNbNI2y/hy/DznDLWcQas1+n9OSWccaAT33n0yIBeXIAhzw2f9Iuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTE3IGF0IDE0OjUxIC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6DQo+IA0KPiBPbiA0LzE3LzIzIDI6NDggUE0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4g
PiBPbiBNb24sIDIwMjMtMDQtMTcgYXQgMjE6NDEgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gPiBPbiBBcHIgMTcsIDIwMjMsIGF0IDQ6NDkgUE0sIFRyb25kIE15
a2xlYnVzdA0KPiA+ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gT24gRnJpLCAyMDIzLTA0LTA3IGF0IDIwOjMwIC0wNzAwLCBEYWkgTmdvIHdy
b3RlOg0KPiA+ID4gPiA+IEN1cnJlbnRseSBjYWxsX2JpbmRfc3RhdHVzIHBsYWNlcyBhIGhhcmQg
bGltaXQgb2YgOSBzZWNvbmRzDQo+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4gcmV0cmllcw0KPiA+
ID4gPiA+IG9uIEVBQ0NFUyBlcnJvci4gVGhpcyBsaW1pdCB3YXMgZG9uZSB0byBwcmV2ZW50IHRo
ZSBSUEMNCj4gPiA+ID4gPiByZXF1ZXN0DQo+ID4gPiA+ID4gZnJvbQ0KPiA+ID4gPiA+IGJlaW5n
IHJldHJpZWQgZm9yZXZlciBpZiB0aGUgcmVtb3RlIHNlcnZlciBoYXMgcHJvYmxlbSBhbmQNCj4g
PiA+ID4gPiBuZXZlcg0KPiA+ID4gPiA+IGNvbWVzDQo+ID4gPiA+ID4gdXANCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBIb3dldmVyIHRoaXMgOSBzZWNvbmRzIHRpbWVvdXQgaXMgdG9vIHNob3J0LCBj
b21wYXJpbmcgdG8NCj4gPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiA+IFJQQw0KPiA+ID4gPiA+IHRp
bWVvdXRzIHdoaWNoIGFyZSBnZW5lcmFsbHkgaW4gbWludXRlcy4gVGhpcyBjYXVzZXMNCj4gPiA+
ID4gPiBpbnRlcm1pdHRlbnQNCj4gPiA+ID4gPiBmYWlsdXJlDQo+ID4gPiA+ID4gd2l0aCBFSU8g
b24gdGhlIGNsaWVudCBzaWRlIHdoZW4gdGhlcmUgYXJlIGxvdHMgb2YgTkxNDQo+ID4gPiA+ID4g
YWN0aXZpdHkNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBORlMgc2Vy
dmVyIGlzIHJlc3RhcnRlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJbnN0ZWFkIG9mIHJlbW92
aW5nIHRoZSBtYXggdGltZW91dCBmb3IgcmV0cnkgYW5kIHJlbHlpbmcgb24NCj4gPiA+ID4gPiB0
aGUNCj4gPiA+ID4gPiBSUEMNCj4gPiA+ID4gPiB0aW1lb3V0IG1lY2hhbmlzbSB0byBoYW5kbGUg
dGhlIHJldHJ5LCB3aGljaCBjYW4gbGVhZCB0byB0aGUNCj4gPiA+ID4gPiBSUEMNCj4gPiA+ID4g
PiBiZWluZw0KPiA+ID4gPiA+IHJldHJpZWQgZm9yZXZlciBpZiB0aGUgcmVtb3RlIE5MTSBzZXJ2
aWNlIGZhaWxzIHRvIGNvbWUgdXAuDQo+ID4gPiA+ID4gVGhpcw0KPiA+ID4gPiA+IHBhdGNoDQo+
ID4gPiA+ID4gc2ltcGx5IGluY3JlYXNlcyB0aGUgbWF4IHRpbWVvdXQgb2YgY2FsbF9iaW5kX3N0
YXR1cyBmcm9tIDkNCj4gPiA+ID4gPiB0byA5MA0KPiA+ID4gPiA+IHNlY29uZHMNCj4gPiA+ID4g
PiB3aGljaCBzaG91bGQgYWxsb3cgZW5vdWdoIHRpbWUgZm9yIE5MTSB0byByZWdpc3RlciBhZnRl
ciBhDQo+ID4gPiA+ID4gcmVzdGFydCwNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiBub3QgcmV0
cnlpbmcgZm9yZXZlciBpZiB0aGVyZSBpcyByZWFsIHByb2JsZW0gd2l0aCB0aGUgcmVtb3RlDQo+
ID4gPiA+ID4gc3lzdGVtLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZpeGVzOiAwYjc2MDExM2Ez
YTEgKCJOTE06IERvbid0IGhhbmcgZm9yZXZlciBvbiBOTE0gdW5sb2NrDQo+ID4gPiA+ID4gcmVx
dWVzdHMiKQ0KPiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBIZWxlbiBDaGFvIDxoZWxlbi5jaGFvQG9y
YWNsZS5jb20+DQo+ID4gPiA+ID4gVGVzdGVkLWJ5OiBIZWxlbiBDaGFvIDxoZWxlbi5jaGFvQG9y
YWNsZS5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFpIE5nbyA8ZGFpLm5nb0BvcmFj
bGUuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IMKgwqBpbmNsdWRlL2xpbnV4L3N1bnJw
Yy9jbG50LmjCoCB8IDMgKysrDQo+ID4gPiA+ID4gwqDCoGluY2x1ZGUvbGludXgvc3VucnBjL3Nj
aGVkLmggfCA0ICsrLS0NCj4gPiA+ID4gPiDCoMKgbmV0L3N1bnJwYy9jbG50LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMiArLQ0KPiA+ID4gPiA+IMKgwqBuZXQvc3VucnBjL3NjaGVkLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDMgKystDQo+ID4gPiA+ID4gwqDCoDQgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N1bnJwYy9jbG50LmgNCj4gPiA+ID4gPiBiL2luY2x1
ZGUvbGludXgvc3VucnBjL2NsbnQuaA0KPiA+ID4gPiA+IGluZGV4IDc3MGVmMmNiNTc3NS4uODFh
ZmM1ZWEyNjY1IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL2Ns
bnQuaA0KPiA+ID4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaA0KPiA+ID4g
PiA+IEBAIC0xNjIsNiArMTYyLDkgQEAgc3RydWN0IHJwY19hZGRfeHBydF90ZXN0IHsNCj4gPiA+
ID4gPiDCoMKgI2RlZmluZSBSUENfQ0xOVF9DUkVBVEVfUkVVU0VQT1JUwqDCoMKgwqDCoCAoMVVM
IDw8IDExKQ0KPiA+ID4gPiA+IMKgwqAjZGVmaW5lIFJQQ19DTE5UX0NSRUFURV9DT05ORUNURUTC
oMKgwqDCoMKgICgxVUwgPDwgMTIpDQo+ID4gPiA+ID4gwqAgDQo+ID4gPiA+ID4gKyNkZWZpbmXC
oMKgwqDCoMKgwqDCoCBSUENfQ0xOVF9SRUJJTkRfREVMQVnCoMKgwqDCoMKgwqDCoMKgwqDCoCAz
DQo+ID4gPiA+ID4gKyNkZWZpbmXCoMKgwqDCoMKgwqDCoCBSUENfQ0xOVF9SRUJJTkRfTUFYX1RJ
TUVPVVTCoMKgwqDCoCA5MA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiDCoMKgc3RydWN0IHJwY19j
bG50ICpycGNfY3JlYXRlKHN0cnVjdCBycGNfY3JlYXRlX2FyZ3MgKmFyZ3MpOw0KPiA+ID4gPiA+
IMKgwqBzdHJ1Y3QgcnBjX2NsbnTCoMKgwqDCoMKgwqDCoCAqcnBjX2JpbmRfbmV3X3Byb2dyYW0o
c3RydWN0DQo+ID4gPiA+ID4gcnBjX2NsbnQgKiwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0
cnVjdCBycGNfcHJvZ3JhbSAqLA0KPiA+ID4gPiA+IHUzMik7DQo+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc3VucnBjL3NjaGVkLmgNCj4gPiA+ID4gPiBiL2luY2x1ZGUvbGlu
dXgvc3VucnBjL3NjaGVkLmgNCj4gPiA+ID4gPiBpbmRleCBiOGNhM2VjYWY4ZDcuLmU5ZGMxNDJm
MTBiYiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3N1bnJwYy9zY2hlZC5o
DQo+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zdW5ycGMvc2NoZWQuaA0KPiA+ID4gPiA+
IEBAIC05MCw4ICs5MCw4IEBAIHN0cnVjdCBycGNfdGFzayB7DQo+ID4gPiA+ID4gwqDCoCNlbmRp
Zg0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgY2hhcsKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRrX3ByaW9yaXR5IDogMiwvKiBUYXNrDQo+ID4gPiA+ID4gcHJpb3JpdHkNCj4gPiA+
ID4gPiAqLw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGtfZ2FyYl9yZXRyeSA6IDIsDQo+ID4gPiA+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0a19jcmVkX3JldHJ5IDogMiwNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRrX3JlYmluZF9yZXRyeSA6
IDI7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0a19jcmVkX3JldHJ5IDogMjsNCj4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGNoYXLCoMKgwqDCoMKgwqDCoMKgwqDCoCB0a19yZWJpbmRfcmV0cnk7
DQo+ID4gPiA+ID4gwqDCoH07DQo+ID4gPiA+ID4gwqAgDQo+ID4gPiA+ID4gwqDCoHR5cGVkZWYg
dm9pZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKnJwY19hY3Rpb24pKHN0
cnVjdA0KPiA+ID4gPiA+IHJwY190YXNrICopOw0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQv
c3VucnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+ID4gPiA+ID4gaW5kZXggZmQ3ZTFj
NjMwNDkzLi4yMjI1NzhhZjZiMDEgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvbmV0L3N1bnJwYy9j
bG50LmMNCj4gPiA+ID4gPiArKysgYi9uZXQvc3VucnBjL2NsbnQuYw0KPiA+ID4gPiA+IEBAIC0y
MDUzLDcgKzIwNTMsNyBAQCBjYWxsX2JpbmRfc3RhdHVzKHN0cnVjdCBycGNfdGFzayAqdGFzaykN
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodGFzay0+dGtf
cmViaW5kX3JldHJ5ID09IDApDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRhc2stPnRrX3JlYmluZF9yZXRyeS0tOw0KPiA+ID4gPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19kZWxheSh0YXNrLCAzKkhaKTsNCj4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBycGNfZGVsYXkodGFzaywgUlBDX0NMTlRf
UkVCSU5EX0RFTEFZICogSFopOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGdvdG8gcmV0cnlfdGltZW91dDsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGNh
c2UgLUVOT0JVRlM6DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cnBjX2RlbGF5KHRhc2ssIEhaID4+IDIpOw0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvc3Vu
cnBjL3NjaGVkLmMgYi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+ID4gPiBpbmRleCBiZTU4N2Ez
MDhlMDUuLjVjMThhMzU3NTJhYSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9uZXQvc3VucnBjL3Nj
aGVkLmMNCj4gPiA+ID4gPiArKysgYi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+ID4gPiBAQCAt
ODE3LDcgKzgxNyw4IEBAIHJwY19pbml0X3Rhc2tfc3RhdGlzdGljcyhzdHJ1Y3QgcnBjX3Rhc2sN
Cj4gPiA+ID4gPiAqdGFzaykNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIC8qIEluaXRpYWxp
emUgcmV0cnkgY291bnRlcnMgKi8NCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHRhc2stPnRr
X2dhcmJfcmV0cnkgPSAyOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgdGFzay0+dGtfY3Jl
ZF9yZXRyeSA9IDI7DQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoCB0YXNrLT50a19yZWJpbmRfcmV0
cnkgPSAyOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgdGFzay0+dGtfcmViaW5kX3JldHJ5ID0g
UlBDX0NMTlRfUkVCSU5EX01BWF9USU1FT1VUIC8NCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoA0KPiA+ID4gPiA+IFJQQ19DTE5UX1JFQklORF9ERUxBWTsNCj4gPiA+ID4gV2h5IG5vdCBq
dXN0IGltcGxlbWVudCBhbiBleHBvbmVudGlhbCBiYWNrIG9mZj8gSWYgdGhlIHNlcnZlcg0KPiA+
ID4gPiBpcw0KPiA+ID4gPiBzbG93DQo+ID4gPiA+IHRvIGNvbWUgdXAsIHRoZW4gcG91bmRpbmcg
dGhlIHJwY2JpbmQgc2VydmljZSBldmVyeSAzIHNlY29uZHMNCj4gPiA+ID4gaXNuJ3QNCj4gPiA+
ID4gZ29pbmcgdG8gaGVscC4NCj4gPiA+IEV4cG9uZW50aWFsIGJhY2tvZmYgaGFzIHRoZSBkaXNh
ZHZhbnRhZ2UgdGhhdCBvbmNlIHdlJ3ZlIGdvdHRlbg0KPiA+ID4gdG8gdGhlIGxvbmdlciByZXRy
eSB0aW1lcywgaXQncyBlYXN5IGZvciBhIGNsaWVudCB0byB3YWl0IHF1aXRlDQo+ID4gPiBzb21l
IHRpbWUgYmVmb3JlIGl0IG5vdGljZXMgdGhlIHJlYmluZCBzZXJ2aWNlIGlzIGF2YWlsYWJsZS4N
Cj4gPiA+IA0KPiA+ID4gQnV0IEkgaGF2ZSB0byB3b25kZXIgaWYgcmV0cnlpbmcgZXZlcnkgMyBz
ZWNvbmRzIGlzIHVzZWZ1bCBpZg0KPiA+ID4gdGhlIHJlcXVlc3QgaXMgZ29pbmcgb3ZlciBUQ1Au
DQo+ID4gPiANCj4gPiBUaGUgcHJvYmxlbSBpc24ndCByZWxpYWJpbGl0eTogdGhpcyBpcyBoYW5k
bGluZyBhIGNhc2Ugd2hlcmUgd2UNCj4gPiBfYXJlXw0KPiA+IGdldHRpbmcgYSByZXBseSBmcm9t
IHRoZSBzZXJ2ZXIsIGp1c3Qgbm90IG9uZSB3ZSB3YW50ZWQuIEVBQ0NFUw0KPiA+IGhlcmUNCj4g
PiBtZWFucyB0aGF0IHRoZSBycGNiaW5kIHNlcnZlciBkaWRuJ3QgcmV0dXJuIGEgdmFsaWQgZW50
cnkgZm9yIHRoZQ0KPiA+IHNlcnZpY2Ugd2UgcmVxdWVzdGVkLCBwcmVzdW1hYmx5IGJlY2F1c2Ug
dGhlIHNlcnZpY2UgaGFzbid0IGJlZW4NCj4gPiByZWdpc3RlcmVkIHlldC4NCj4gDQo+IFRoYXQn
cyBjb3JyZWN0Lg0KPiANCj4gPiANCj4gPiBTbyB5ZXMsIGFuIGV4cG9uZW50aWFsIGJhY2sgb2Zm
IGlzIGFwcHJvcHJpYXRlIGhlcmUuDQo+IA0KPiBJIHRoaW5rIENodWNrJ3MgcG9pbnQgaXMgc3Rp
bGwgdmFsaWQuIEl0IG1ha2VzIHRoZSBjbGllbnQgYSBsaXR0bGUNCj4gbW9yZQ0KPiByZXNwb25z
aXZlOyBkb2VzIG5vdCBoYXZlIHRvIHdhaXQgdGhhdCBsb25nLCBhbmQgdGhlIG92ZXJoZWFkIG9m
IGENCj4gUlBDDQo+IHJlcXVlc3QgZXZlcnkgMyBzZWNvbmRzIGlzIG5vdCB0aGF0IHNpZ25pZmlj
YW50Lg0KPiA+IA0KDQpJdCBpcyB3aGVuIHlvdSBkbyBpdCAzMCB0aW1lcyBiZWZvcmUgZ2l2aW5n
IHVwLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
