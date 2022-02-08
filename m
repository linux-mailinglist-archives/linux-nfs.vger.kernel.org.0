Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24294AE399
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387226AbiBHWXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387025AbiBHVrH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 16:47:07 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2126.outbound.protection.outlook.com [40.107.212.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A68EC0612B8
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 13:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zky+QhxPbldtpQ32xbkKJaKnEiKmIFsIImKTWRnHpGihukfKQVFnUBFjh1L2fBUzYbmVy6UvuWE9urrZxYdZH3vXX3bI45UgyZe18OaBlaoToeQeXUG2KgRBd8d0MBxK9r5nwuY6W73+ZlO1T/YvpFsY8XuO0tadD5mA3yFAmAXbbTU2TFHjps/WBVL6K39pqreEhKu1EA1X06N2tbRwNcAAq7hi3LZdSfUhMRoVEBr1GnaXLhUfvbBSCpCXYY0TikVNrwkwdRGdi7P2Y2xtuO8z1POqtnwImqRWbKtuWm+Wub++MHotjWaO2FmsASf4GTtrNfjCi4ODJcVNRCCbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOQ+k09XbzIJoui8A3qDXUfrWrVDq4RjTGjore5hDC0=;
 b=nwpjJ2K00d8VQnyfbySoA0Xm/yKzT3MhTjyQg6ufqpwN4ZxrntSQ8hToahaI1N0OhY5L3UPo8q5hmDIxbYNvQtJGP4XoO84pHHQQF/ZlvRzg7WrPHwk/jTJ/UGaKegunN5c3qBMR+YrEuuirY0Jzb/RyDvaQvY2wMgWgV0rNwKyVP0WuHcByjWq7sntV780qx8rUIAnJlmxRusqfKfW0Ew5XlLw+zPeKHiFSVnXnTGvGMo2Cf3a+2wyP6LH5PosRk4EmCNIUNBSDN+epqwEjZLRhfCk4pub6BJ1cJFfqwQCujWJ/v76u/JGrpF0djcaP2FcndGV8/HWmxaxwKdI6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOQ+k09XbzIJoui8A3qDXUfrWrVDq4RjTGjore5hDC0=;
 b=Qu6lRG1Fe5fafxtK+9EJtPsoe+GVBNm44fMZ4wagnr2eCqivsqZGz4i0NBSzO5gyXdbVKwr3jVGkiNE4GW0beRQLVaOax5SW1DR+v286fkkLI7B05Q3+Pjn4w0yRNeoE9+3ahjxu++gk0xvCjIA64VU8b1aPTyQrpAA32mSbZYg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB2929.namprd13.prod.outlook.com (2603:10b6:405:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Tue, 8 Feb
 2022 21:47:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 21:47:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Thread-Topic: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Thread-Index: AQHYHScFlqCFQx4T40K//9/WiL9wzKyKGmaAgAATggCAAAKagA==
Date:   Tue, 8 Feb 2022 21:47:03 +0000
Message-ID: <81b7ed0f2ec6771986a01d20358f0f640673b901.camel@hammerspace.com>
References: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
         <189aba691b341f64f653817c9cdf018ef34ac257.camel@hammerspace.com>
         <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
In-Reply-To: <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 301b8386-23e8-459b-f49a-08d9eb4c8b3a
x-ms-traffictypediagnostic: BN6PR13MB2929:EE_
x-microsoft-antispam-prvs: <BN6PR13MB2929DEE7C80385522D7774B2B82D9@BN6PR13MB2929.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OpEXmIl1LOgkBmhPHX034QQQPSVcUihpEWFiSNOy9+Xts8mRoFzu8ILBWZXwztUxO0mKGEhuyuIukYX4+/rMdQLG0mZT0GQtBLQM6x1QynVU5G53zJZBCSPh19HYl5kV1OfIfXQPA7t5heU+WEC00Kwaiu/EqZvziC27r1aFUT9XaE7/Lb8OjXrKQs9BocwwpmuKjvUscaUPni+LJckna46LMOS2gBL+1COWSi0tb7abqS8LHijrH73EBLnNh3lOUS/DZHZcwp2r5YqGNBDoYt9wwHEmCtM0X6FdHKznocBv7VqWhhy9xDVI/0pFQ0ahPc1TQJo/8un9PWZQ9uRVmlAt7v5fgMPIUsRCNrdyvWfwk8XUWzqNfSUhI8cV1IyeTiAvn7whU4WMBEZrA5pWB9nq+p2vyWNnBa7on6M+WwCnpUtB8GMqGfcX7FtgYpHuHYgRN3Qo7lKDrIq6mNVtkoGR0OdPcMnqCMSOmJiKquIP90A6Pczf7BSpnRI0LpPxy6HH/AFbkbg7mB9GwDVBf+UfQEQNTfpp3elbZ066go1I8M5SpZX95IMyuD4PBQONWCNuOfzGj5V896eBtkai87lJ/rb4XlJwJS0hjrQXM3eXMgcr7xxzR5uEv1f0itmjvVytYM0XZ9/qeNf6VdT0i6Ttpup0H39rWR/vLpG5BbEAUZ7rx5snPa2YwpWV2DO1pK6FYB7yH78ZcM/BY8hilw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66446008)(66476007)(66556008)(2906002)(64756008)(8676002)(76116006)(86362001)(83380400001)(38070700005)(8936002)(4326008)(6486002)(53546011)(122000001)(5660300002)(508600001)(36756003)(316002)(38100700002)(2616005)(26005)(6916009)(6506007)(54906003)(71200400001)(6512007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9oMWZ3bFBZNEdmZlZIdlJVNzlZdnlrZjhOWEFTNWtZNHdzai9uaHlRSmN0?=
 =?utf-8?B?WGJXQ2FYOG91cUtJcWsrM0NtWjlJMnR1Wm1QK2tEUSszSGEvZ1Z2WUpocnVW?=
 =?utf-8?B?UDBjZTd0eHkxcUwrcitzOW5mTXBHK21iZHlPcVNaM1dGOWRKcFBlODhQOHRw?=
 =?utf-8?B?SHJvYjRMU3pjUXFIc1hFQVJUNFRRWmVxT1hTRm5jbHZBeDlwN2pobkNPK012?=
 =?utf-8?B?UEJNNEZqbndTcnIwY2hCb3N6Nllndit6ZnlPWGxDUlA3dnRRZklVWEY1Y2Zr?=
 =?utf-8?B?Vld0TFAxT0krVWVTdERlMk5QdzJXRmowa0dNU0M0RTNBMklWQWVLVWFnQmlx?=
 =?utf-8?B?QVpmSGlheEp3NVVCbFhLSno3NkdQYldVRm1hakQyZmc1Z2lMcUxyWUo0WmNP?=
 =?utf-8?B?bStpdUhJSlh6K2g4MzFmVWpKUG1EcFFxNU95UUlCeVBVcTJRbDBmRnJZSGo3?=
 =?utf-8?B?b3dBbDlkV0xxNmNlOEpYZmxsVE1JbzFzbHo2bkdWNnhQZHE1cC8zaTBDazZt?=
 =?utf-8?B?cnYzK2FwdWxYK2dmb3Jud3h5elFmd2NVZjlHa2J2ZUhMcGlST1YvMlpNTTZ2?=
 =?utf-8?B?bVhnNWROSVNQQUlVYnY4OFRKNlI1L09iMHNsSEY0dEtFS08xMk5BSEdab3JL?=
 =?utf-8?B?ZDBFbExUQmZEVVdOQm1hZUkvdkZUNlZzWUdWRW9rS2xsd1FoZW1YanR3N1F3?=
 =?utf-8?B?NVBnVkE1cEhIOTBybldGR0FjRXRJNUhET1BJa0dsYXhjOGwyNGJYV3puR3hq?=
 =?utf-8?B?dTJxV2RIcGtoSi92SksrR3BlUVdRTWxGNDVQODNNZ3d1YkxkYWRvaVF6b2tl?=
 =?utf-8?B?cjNVbkhnNDVkYmpVVHBvZzlhOHpoQ0VJdmV3bzdTS0tOc1liU1ZRM1ZGakZn?=
 =?utf-8?B?eWpYelp1Snd5bW5lcDd3K09XaUlJY3gxVStpd2lLQlNZT0JLTTlYcHRBcm1u?=
 =?utf-8?B?WkxXR0EwR0Y1eUpvQmJ5SDZud0Z6TTdZUWYrS3N1VkNGeWw2a0o4SnZlM0Zh?=
 =?utf-8?B?M0NObnJLOU5oM0ZnQnJxN3F3ZkpBL3hoQlRIb3NTdlg4b3pZaTBaaUVRV0xu?=
 =?utf-8?B?aHJ3OGpVTGQyamlrcWlwSXVYM282MzVKd2ZycFZVeld3V1Z3d2xKcU9ZYk4x?=
 =?utf-8?B?UHY5Qnh4ZmF4T3pvS0dwaWxRMEdIQTJISlZBbDF4WnNnVzRmeHVsMDcvYjZa?=
 =?utf-8?B?WGFDb0IzMS9xbnBJc0MvTm5CdmNEaG5yRi9DUlJJNkNDS1JsSkJuQlVZM1o0?=
 =?utf-8?B?S2NuV3VNd1pLUDdkSFpWK25DLytFaUdlYktUaUg5YTUrQ2s2QnJoSWgzTVpp?=
 =?utf-8?B?YXBPV212d3lLYlNIM2ZEZWpDMEtJSzljYWNNWDVYeUs0QmkzMFJVRVIzMThh?=
 =?utf-8?B?RmJab2R5TWczYUtEZTZMcm44alFiUU82SHNoTitDdWFVa1VEZDFZTEhsb05v?=
 =?utf-8?B?emppNlRHWWJ6cXRJZkE4bjVKemI4TFB3dDd3emJ2Z3lWekYyaTdSOUUwU0hy?=
 =?utf-8?B?Y0Jkd242TWtmcG5ReUdmZVJSUHRRZ3ZjMTVZR0V3SWMyei8xM3NVRGZvem9h?=
 =?utf-8?B?c0YwNCtCWUxXaEVsRjRyTkdWN1J4MGs3RFRDeDFWNHdTbWNmekw4bXI4R0NW?=
 =?utf-8?B?SElkWE9UYXl3a0xzcENEVUpNMXkrdS93RGRpbVNrbHk0TUMwaXNicTVsckJV?=
 =?utf-8?B?Y09vRElyOEE0dDVVMmFjQ0ljbmlPaFE3UGVhU3Q4TnRlV3FWUE1HRVZVZ2w2?=
 =?utf-8?B?ZFNQV0JyaW5JK0YxSzF2WWJtbWNjWVc4OHhSckNGb2tuMFBkUktVMkZxT25E?=
 =?utf-8?B?Wld2L3R5RkZYY2J3RjlEUWJkZ3U4cnNNSlhBRWJDeU9SRnJZdVUvT3k5and2?=
 =?utf-8?B?d1hBaXl6UGx4K0ZSRDBwaFAxUlluVHcxYW9ucnF4ZlZ6ek9wU2QvU1NkKy90?=
 =?utf-8?B?VlNVMVRvcFNadlFvb1pjM0dmZlJLeG5xN2ROT3UzNXZVbWhrK2hJYVc0T0gz?=
 =?utf-8?B?c1VGZkRjQ2pDL2pjSzFkRGIwYWlZWnd6Mmoxei8zWEdMSS9wU0VVclAvak1S?=
 =?utf-8?B?dENDa3o1RkU5cGZVeTZqMVNRNUVVajRZSkJKTkhxaHZNRi9JNUJyVVJUSXN3?=
 =?utf-8?B?M3hHT1krNWRtYXBxZjF5WlZQN3JOMTg1Ryt5cVlEeUxjdW9QbWgwL0RhVStE?=
 =?utf-8?Q?P2ZI6dcK3PhynscexkNuvNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F7BF8E28DE8F1459E55E40ABB69B7F3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301b8386-23e8-459b-f49a-08d9eb4c8b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 21:47:03.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJ72wLNUgpWhF4lUcUv6ysRRCsacq7Oh5r9DCP3FHmjWcZ63BAnzoptJT1evFLK2UvOZ6382jXU3MsQhRRMHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB2929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDE2OjM3IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA4IEZlYiAyMDIyLCBhdCAxNToyNywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBUdWUsIDIwMjItMDItMDggYXQgMTU6MDMgLTA1MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiBJbiBvcmRlciB0byBkaWZmZXJlbnRpYXRlIGNsaWVudCBzdGF0
ZSwgYXNzaWduIGEgcmFuZG9tIHV1aWQgdG8NCj4gPiA+IHRoZQ0KPiA+ID4gdW5pcXVpZmluZyBw
b3J0aW9uIG9mIHRoZSBjbGllbnQgaWRlbnRpZmllciB3aGVuIGEgbmV0d29yaw0KPiA+ID4gbmFt
ZXNwYWNlDQo+ID4gPiBpcw0KPiA+ID4gY3JlYXRlZC7CoCBDb250YWluZXJzIG1heSBzdGlsbCBv
dmVycmlkZSB0aGlzIHZhbHVlIGlmIHRoZXkgd2lzaA0KPiA+ID4gdG8NCj4gPiA+IG1haW50YWlu
DQo+ID4gPiBzdGFibGUgY2xpZW50IGlkZW50aWZpZXJzIGJ5IHdyaXRpbmcgdG8NCj4gPiA+IC9z
eXMvZnMvbmZzL25ldC9jbGllbnQvaWRlbnRpZmllciwNCj4gPiA+IGVpdGhlciBieSB1ZGV2IHJ1
bGVzIG9yIG90aGVyIG1lYW5zLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1p
biBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGZz
L25mcy9zeXNmcy5jIHwgMTQgKysrKysrKysrKysrKysNCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9zeXNm
cy5jIGIvZnMvbmZzL3N5c2ZzLmMNCj4gPiA+IGluZGV4IDhjYjcwNzU1ZTNjOS4uOWI4MTEzMjNm
ZDdmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzL3N5c2ZzLmMNCj4gPiA+ICsrKyBiL2ZzL25m
cy9zeXNmcy5jDQo+ID4gPiBAQCAtMTY3LDYgKzE2NywxOCBAQCBzdGF0aWMgc3RydWN0IG5mc19u
ZXRuc19jbGllbnQNCj4gPiA+ICpuZnNfbmV0bnNfY2xpZW50X2FsbG9jKHN0cnVjdCBrb2JqZWN0
ICpwYXJlbnQsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7DQo+ID4gPiDCoH0N
Cj4gPiA+IMKgDQo+ID4gPiArc3RhdGljIHZvaWQgYXNzaWduX3VuaXF1ZV9jbGllbnRpZChzdHJ1
Y3QgbmZzX25ldG5zX2NsaWVudCAqY2xwKQ0KPiA+ID4gK3sNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oHVuc2lnbmVkIGNoYXIgY2xpZW50X3V1aWRbMTZdOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2hh
ciAqdXVpZF9zdHIgPSBrbWFsbG9jKFVVSURfU1RSSU5HX0xFTiArIDEsIA0KPiA+ID4gR0ZQX0tF
Uk5FTCk7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAodXVpZF9zdHIpIHsNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnZW5lcmF0ZV9yYW5kb21fdXVpZChj
bGllbnRfdXVpZCk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3ByaW50
Zih1dWlkX3N0ciwgIiVwVSIsIGNsaWVudF91dWlkKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByY3VfYXNzaWduX3BvaW50ZXIoY2xwLT5pZGVudGlmaWVyLCANCj4gPiA+
IHV1aWRfc3RyKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiA+ICt9DQo+ID4gPiArDQo+
ID4gPiDCoHZvaWQgbmZzX25ldG5zX3N5c2ZzX3NldHVwKHN0cnVjdCBuZnNfbmV0ICpuZXRucywg
c3RydWN0IG5ldA0KPiA+ID4gKm5ldCkNCj4gPiA+IMKgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBuZnNfbmV0bnNfY2xpZW50ICpjbHA7DQo+ID4gPiBAQCAtMTc0LDYgKzE4Niw4IEBA
IHZvaWQgbmZzX25ldG5zX3N5c2ZzX3NldHVwKHN0cnVjdCBuZnNfbmV0DQo+ID4gPiAqbmV0bnMs
DQo+ID4gPiBzdHJ1Y3QgbmV0ICpuZXQpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgY2xwID0gbmZz
X25ldG5zX2NsaWVudF9hbGxvYyhuZnNfY2xpZW50X2tvYmosIG5ldCk7DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKGNscCkgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBuZXRucy0+bmZzX2NsaWVudCA9IGNscDsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAobmV0ICE9ICZpbml0X25ldCkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXNzaWduX3VuaXF1ZV9jbGllbnRpZChjbHApOw0K
PiA+IA0KPiA+IFdoeSBzaG91bGRuJ3QgdGhpcyBnbyBpbiBuZnNfbmV0bnNfY2xpZW50X2FsbG9j
PyBBdCB0aGlzIHBvaW50DQo+ID4geW91J3ZlDQo+ID4gYWxyZWFkeSBwdWJsaXNoZWQgdGhlIHBv
aW50ZXIgaW4gbmV0bnMsIHNvIHlvdSdyZSBwcm9uZSB0byByYWNlcy4NCj4gDQo+IE5vIHJlYXNv
biBpdCBzaG91bGRuJ3QsIEknbGwgcHV0IGl0IHRoZXJlIGlmIHRoYXQncyB3aGF0IHlvdSB3YW50
Lg0KPiANCj4gSSB0aG91Z2h0IHRoYXQncyB3aHkgaXQgd2FzIFJDVS1lZCwgYW5kIGZpZ3VyZWQg
d2UnZCBqdXN0IGRvIGl0DQo+IGJlZm9yZSANCj4gdGhlDQo+IHVldmVudC4NCg0KSWYgdGhlIHZh
bHVlIGlzIGJlaW5nIHNldCBmcm9tIHVzZXJzcGFjZSwgdGhlbiBpdCBpcyB1cCB0byB1c2VybGFu
ZCB0bw0Kc29sdmUgYW55IHByb2JsZW1zLiBIb3dldmVyIGlmIHdlJ3JlIGFsc28gc2V0dGluZyBh
IHZhbHVlIGZyb20gdGhlDQprZXJuZWwsIHRoZW4gd2UgaGF2ZSB0byBtYWtlIHN1cmUgdGhhdCB3
ZSBkb24ndCBjbG9iYmVyIGFueSBjaGFuZ2VzDQptYWRlIGZyb20gdXNlcnNwYWNlLiBBRkFJQ1Ms
IHRoZSBiZXN0IHdheSB0byBkbyB0aGF0IGlzIHRvIGluaXRpYWxpc2UNCmJlZm9yZSB3ZSBwdWJs
aXNoLg0KDQo+IA0KPiA+IEFsc28sIHdoeSB0aGUgZXhjbHVzaW9uIG9mIGluaXRfbmV0Pw0KPiAN
Cj4gQmVjYXVzZSB3ZSdyZSB1bmlxdWUgZW5vdWdoIGlmIHdlJ3JlIG5vdCBpbiBhIG5ldHdvcmsg
bmFtZXNwYWNlLCBhbmQNCj4gYW55DQo+IGFkZGl0aW9uYWwgdW5pcXVlbmVzcyB3ZSBtaWdodCBu
ZWVkIChkdWUgdG8gTkFULCBvciBjbG9uZWQgVk1zKQ0KPiAvc2hvdWxkLyANCj4gYmUNCj4gZ2V0
dGluZyBmcm9tIHVkZXYsIGFzIHlvdSBlbnZpc2lvbmVkLsKgIFRoYXQgd2F5LCBpZiB3ZSBhcmUg
Z2V0dGluZw0KPiB1bmlxdWlmaWVkLCBpdHMgZnJvbSBhIHNvdXJjZSB0aGF0J3MgbGlrZWx5DQo+
IHBlcnNpc3RlbnQvZGV0ZXJtaW5pc3RpYy7CoCANCj4gSWYgd2UNCj4ganVzdCBnZW5lcmF0ZSBh
IHJhbmRvbSB1bmlxdWlmaWVyLCBpdHMgZ29pbmcgdG8gYmUgZGlmZmVyZW50IG5leHQNCj4gYm9v
dCANCj4gaWYNCj4gdGhlcmUncyBubyB1ZGV2IHJ1bGUgYW5kIHVzZXJzcGFjZSBoZWxwZXJzLsKg
IFRoYXQncyBnb2luZyB0byBtYWtlDQo+IHRoaW5ncyANCj4gYQ0KPiBsb3Qgd29yc2UgZm9yIHNp
bXBsZSBzZXR1cHMuDQo+IA0KDQpTbyB5b3UncmUgZm9sbG93aW5nIHVwIHdpdGggY2hhbmdlcyB0
byBuZnMtdXRpbHMgdG8gY29uZmlndXJlIHVkZXY/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
