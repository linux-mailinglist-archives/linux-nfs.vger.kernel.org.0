Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C75A9984
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiIANzr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiIANzp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 09:55:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2101.outbound.protection.outlook.com [40.107.237.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65356248E3
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 06:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6J1ul3K05UEbBqSiPBWk+NfH4uBnfv6xPGIVGHODeNIA4wYRZo7+aqsU5ri8AgYoYcgH7n2tngHsWIFvbIpvM5IQFNALaprOBa+mnjU+9D6+nJXX+MtXFlgGbkqlsKTMkqDL1yPJAn1XePcXqubzX4ucE6ph/T28UzC00vC/FVoGbzcluERTlddSS1kG0l4u7XrpR+EcmtLnKalVCGAu7Cth6Bfk7GixEPQMHYWXXGYdi5ImZcm3YxylehBgL1X3PlwPYmgTgpLA/S6OnCNRhl67SRLm4PaPocL6uKoZAl3+jR1q6ub+OvqFT2nE5msUsSSjO9JUVKXqNVMTBfPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhBG4O+OjshPzeqrHyMamE6Pxj1TfggRomWZaUm9Zcs=;
 b=VTI/r0cO8cC43pRTqjqFoooddzd72PdT2yMAodE02tAee/G6ChQSAODdGmgASqE2tZoPkNybLfVC3yhPH4vnH/4WquTvxDEhk373PvZPsuAfH07Bilko/LZqUe3CbyPnFXn4cTesy2TIkBe2T3rF1aYOCUosh2BhSAVZtJzEATiomqsnrf76wVdIZiZe/pWtA/STaofu0/99OwSzGVO5pLKQJZvIiz2vfs/sU5R7367UyVm2UELohSsRXa/k/lR9B5pduQU9Fp1YdAr+CCxSLwNyqEXCAh4wN1cjfqssJwav2gvGVS/hZSD3DybyygkEMVDgHtdCcZgEL+WhsHgTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhBG4O+OjshPzeqrHyMamE6Pxj1TfggRomWZaUm9Zcs=;
 b=OKZ+tueZDW1aCqNwu1vy0l89AbaWvErtORGhxV87jJEz0m4zEhv+Sw6S3CrmQJ8HgossL+6maJIirY0ql/w6/HyvtHvA/yJGrP3u+m1Ro18OhiYY3Do732OlGP7vdvCU4sjfdROE95tA5dt9Z9Ns9Du4+23pW0OLW9xBmQT2z6c=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4882.namprd13.prod.outlook.com (2603:10b6:a03:36e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Thu, 1 Sep
 2022 13:55:37 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.005; Thu, 1 Sep 2022
 13:55:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: directory caching & negative file lookups?
Thread-Topic: directory caching & negative file lookups?
Thread-Index: AQHYvgepinoQ18GCcUu67eOreR0vTa3KmPSA
Date:   Thu, 1 Sep 2022 13:55:37 +0000
Message-ID: <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
References: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
In-Reply-To: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4882:EE_
x-ms-office365-filtering-correlation-id: 5c19ff71-a493-4124-c45d-08da8c21a628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Co5eijC7zTMoOtb12ZWJR2dElLufqgtufv1aSkApn+o/GuUbIXDGWW5AcofyWYw9ZXBrYvwXTt4W7EP/o5So6BVg0vQtkY3Z1d58b8BzjymmG2KUpMRuvAh2ECQ09Qst0FYasMvqz7u8+/HA7cvfaQ7KW2Ll/AKWlBQmuUlvAAXIIZz9MmCAfuPMrKYtzmqgxPerUQXXWyEndzXuwNyzRQmo3GKcfsxD3HE15oTDqh91MUStfZDA3gxvAnqTOirz7QQ5owOIVNyKapdw86U0V08EHYsMh0cp2ASdInI3kDzwbqs4sTTZlK11/5kr39mnY6hc/HtWDa+v3ZmGVA+zTZEUefmvu2y0NwfkvtFnxdograSOouFhLtXtRtDxApyqqKxzx9fW5ZaEVoTB433VDA7YiM70SGGWBF9tSIoAICjPjP3z/3vyKd0OakzvdNJdFScawHziHJIvbs7naYAODQOv3R5/CqTdOwA1Rd3eHIXNc9JQt5YjMs1dA5wUA89NRQZzy9yac6FOrc+rWVxRwfpWeAVm1630LBS/qcFhMrS68rrPuEoB3Hwrq7OqcBpi/rJ+PduyfARpRrL3am+GTswcFDwzNtWmRBUv5dOo15RGFO4d8ooYJgZ9v7D3WE2uCSVoZCZjiZRtztG7PnCKJAP4yXaVogebTaRHMpt+JfeMlfCgQne3LJciGsKFfdb4tnNoyJlWtX5rnh82CDsveAR7HpoZtQlLSH9p5OcLImIdeifjUX1jcSO4y4i8KZAf8q3wyrUNiL2FyNn+gh5H5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39840400004)(346002)(2616005)(316002)(83380400001)(186003)(110136005)(6486002)(71200400001)(8936002)(76116006)(5660300002)(6506007)(36756003)(26005)(41300700001)(2906002)(6512007)(38070700005)(86362001)(66946007)(66446008)(66476007)(66556008)(478600001)(64756008)(122000001)(38100700002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWpDdXU4UkxrS3l3T1NwTFcxVnJuZ3NPbHczWDdyR1MxeHBib0RkZEVFa1kz?=
 =?utf-8?B?ZGlXa0laQll5MEhnWk12NHA2WjdqLytweFFVZHZPTDRYRWtyY1lhaXdFcGdT?=
 =?utf-8?B?Vlc1QW81LzhvU2hWaCttUXNOY3ltUEZTdW0wdHpJdmdTTzg2SVhGZmY5ZExG?=
 =?utf-8?B?aVcxenpkYTZOcTl2V0l1dmJXUHhDejhZckJGVEZzZm5LYkxNS0F6aTUrcXdo?=
 =?utf-8?B?aHltcmIyd0E3cm9MZnlSUDlweUFQMExHMkJWbytNZXgzQTkrcDRWYnVxSFVC?=
 =?utf-8?B?TkhVbnpHTVNjMXNIOFRISjd6NUExM2tmNldGaGp0YmxtMWJCQnBFOTVET3JG?=
 =?utf-8?B?MXdpeXRhZHlxbUJ3SUxXQzBDa0MwU2E5TjhIdnJ4UEo1K2dpMWppNWY0Q25X?=
 =?utf-8?B?WjdGYXJEOFlaYUs3clpuZjlGdE0yQTYzQUJpRytlMHZNdDRHM044MlNpOUhX?=
 =?utf-8?B?SCswd2FWdUlNZGEwNUQ1TjJ5OG8zQ1phcWdIUVY2MzhYTENORVhYT1h3YktW?=
 =?utf-8?B?RWpRT2ZnRkFXVzRqbG1SVmJhTmhIcVRWcmR2cU1nSlkybW1zUFJIYzUvQzJY?=
 =?utf-8?B?VTZqMEpzaWdjeWJZU3N6UHAzL1I1bzJ0U1Z2b3AvSml2TkE2VytZVUJvL3Mz?=
 =?utf-8?B?eE5jUkxuWkl3ZFpjUGFKeERuQ1VJdlo0QWxLOGdpR0YyV3MwMHFvUEdGMlpm?=
 =?utf-8?B?WEhxMm5JQmVoUHRFYUNFKzBucnUyZ3R4b2RWZTJJcFFldHNKZlRCRHhDY3p1?=
 =?utf-8?B?a2tZcnRvU2dBMVZidU5aZENnRGJXalpTa1FWNEs5K2J0bjRPZG1ibkFiZVMr?=
 =?utf-8?B?Y3R0QjBucFAxbk1JRyszMGpOc1pPcTgxV1lqU0JYOGVERkY4VXRlbThCQkFh?=
 =?utf-8?B?UDljU1VZWXNkeGxBNDYzRUlOMzk0UWhQTlE2VmZMZy9WckppM25uaXhlaWxx?=
 =?utf-8?B?MEpmQ01SZUJUc0szZjVYdDRSVFUwdDBnQ0tmaU0relRXUFdqNmRYUHhpaXU1?=
 =?utf-8?B?SGl2dUNraW9xdmdyZkJqQjlYTzNnRThGZ1RRUmhaMDdyUEhHemRUTkh2Tlkv?=
 =?utf-8?B?ZDV0UWE3dFJiNk9ONzE5R3huSW9jem9Db2YyV0tJU241ODRIOVU1T1lkclFH?=
 =?utf-8?B?K1Q2YkF4SmtiZE95Vy9wK0RPUVE2dFMwYXYyTGlIb1hzaWpveS9zdU5sUjNv?=
 =?utf-8?B?R1pjRW9STjVGN2hJT0xoMEthTnptMWlOZ0VmY3F3Z1AvT2VpMFRXMFo4aGpk?=
 =?utf-8?B?c1RUQThmeC9VOVp6bFlFRWU5Ny9rdFF4cyt0M08vK0JOelc5bTJOTFZDYjNE?=
 =?utf-8?B?UUdOM0NGTFNMd2djNWN5QzUxR3M0cHYyeXpiaE1GNm1VVUxRTFFFeVlBdkVu?=
 =?utf-8?B?ekljMGJtZ3VLaXFqa0txcDJLdTlUS3hBRmQ0alZrWE5zY1cxTjh4S3BER1h1?=
 =?utf-8?B?Z20yRlUvQWJqa2NoZi9PSElYVjJ2MUcxV2xYVVNHd3ZrRVVEZ0F0aDZKN3Vs?=
 =?utf-8?B?eUVGbUVhMmVDTW9zYkk2M3V5N2xJSlprL2cwUWVDQlg3bVhPejl0anZsNGJH?=
 =?utf-8?B?SVd6SG5pNFFzTjhFWWo5U3N1Vm1zMUM1V25ubHFXVDhhNHR5NmdFTEVQOVda?=
 =?utf-8?B?YUl4ZStZalJlOGJRekRtUkUrcHFhVDBtMVhWamNLbjBYZjVNTFRLZ3dnSzFq?=
 =?utf-8?B?bld1ZktUbjhsRUlCNlg4bmJzejBjTlFBTC9KejdidjFMUDVQSmRaN1E5Mis4?=
 =?utf-8?B?M21iYUR3RGZaQ2JOdmo5TTBPSk5IS2hxMVpDVEJMUHZRQUFGcm9tcGtiNU13?=
 =?utf-8?B?Yjl4bm1vRUloMFJWM3JuR3g5WFFqcTFsclMzc3JkMkw5TkNlOUU4dERkK2Nx?=
 =?utf-8?B?TVdDeVoxSEVrRWxtWXo4RkhYaGd5ZWV6d0J3YzFCUUc4czl6ZUdCb2hOV054?=
 =?utf-8?B?SG5zN1orTDJtWmUwTXZvSFVESzFXN3FscUM0Y2hDU0M1dUtFWXpkbFY1MzhX?=
 =?utf-8?B?ZndIT3ZEcFMwTkxTdEJXYU05eGFScGovaW1pWDJhN0NicUNWd3V1TDQ1amtZ?=
 =?utf-8?B?U3RzUVlMYTZCWUh5RlhuUzBWVHIxQ1d3eW5TTEFEb2dxR09wODhUQ0xzMml3?=
 =?utf-8?B?V3gyOHVmYmF3SjlIYUdUbHdkMm1aNTRGTVdYMjZNM05qNkkyVjV5MUZWdUhV?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28CED80EACF3DE4081D5D2048CC8A8C2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4882
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTAxIGF0IDE0OjMyICswMTAwLCBEYWlyZSBCeXJuZSB3cm90ZToNCj4g
SGksDQo+IA0KPiBTbyBJIGhhdmUgYSBiaXQgb2YgYSBuZXdiaWUgcXVlc3Rpb24gKGFwb2xvZ2ll
cykgdGhhdCBjYW1lIHRvIG1lDQo+IHdoaWxlDQo+IGRlYnVnZ2luZyBzb21lIGNvZGUgdGhhdCB3
YXMgc3BhbW1pbmcgb3VyIE5GUyBzZXJ2ZXJzIHdpdGggbG9va3Vwcw0KPiBmb3INCj4gbm9uZXhp
c3RlbnQgZmlsZXMuDQo+IA0KPiBJZiB3ZSBjYW4gY2FjaGUgZGlyZWN0b3J5IGVudHJpZXMgKHJl
YWRkaXIpIGFuZCBldmVuIGFsbCB0aGVpcg0KPiBhdHRyaWJ1dGVzIChyZWFkZGlycGx1cykgZm9y
IHNvbWUgc3BlY2lmaWVkIHBlcmlvZCBvZiB0aW1lIChhY3RpbWVvLA0KPiBub2N0bykgb24gYSBj
bGllbnQsIHRoZW4gd2h5IGNhbid0IHdlIHVzZSB0aGF0IGRhdGEgdG8gc2VydmUgbmVnYXRpdmUN
Cj4gbG9va3VwcyBmb3IgZmlsZXMgaW4gdGhhdCBkaXJlY3RvcnkgdG9vIChpZiB3ZSBzbyBjaG9v
c2UpPw0KPiANCj4gVGhlcmUgYXJlIHByb2JhYmx5IHZlcnkgZ29vZCByZWFzb25zIHlvdSBhbHdh
eXMgbmVlZCB0byBkbyBhDQo+IChuZWdhdGl2ZSkgZmlsZSBsb29rdXAsIGxpa2UgYmVpbmcgYWJs
ZSB0byByZWFkIGZpbGVzIHJlY2VudGx5DQo+IGNyZWF0ZWQNCj4gb24gYW5vdGhlciBjbGllbnQg
KGRlc3BpdGUgeW91ciBsb2NhbCBjYWNoZSBmb3IgdGhhdCBkaXJlY3RvcnkpLCBidXQNCj4gSSdt
IGp1c3QgY3VyaW91cyB3aGF0IHRoZSBvZmZpY2lhbCByZWFzb25zIGFyZS4gSWYgd2UgY291bGQg
Y2hvb3NlIHRvDQo+IHNlcnZlIG5lZ2F0aXZlIGxvb2t1cHMgdXNpbmcgdGhlIGRpcmVjdG9yeSBl
bnRyaWVzIGNhY2hlIGZvciBhDQo+IHJlYWQtb25seSBvciB1bmNoYW5naW5nIGZpbGVzeXN0ZW0s
IHdvdWxkIHRoYXQgc3RpbGwgYmUgYmFkPyBXZQ0KPiBhbHJlYWR5IGNob29zZSB0byB1c2Ugbm9j
dG8gZm9yIHNvbWUgd29ya2xvYWRzLi4uDQo+IA0KPiBJbiBvdXIgY2FzZSB3ZSBzZWUgdGhlc2Ug
a2luZHMgb2YgaGVhdnkgbmVnYXRpdmUgbG9va3VwIHdvcmtsb2FkcyBmb3INCj4gbmV0d29yayBp
bnN0YWxsZWQgc29mdHdhcmUgKDEwMCBlbnRyaWVzIGluIFBZVEhPTlBBVEggaXMgYmFkKSBhbmQg
aW4NCj4gYnVnZ3kgc29mdHdhcmUgKHJhbmRvbWx5IGdlbmVyYXRlZCBmaWxlbmFtZSBsb29rdXBz
IGFyZSByZWFsbHkgYmFkISkuDQo+IE9mIGNvdXJzZSwgdGhpcyBvdmVyaGVhZCBnZXRzIHJlYWxs
eSBiYWQgYXMgeW91IGFkZCBsYXRlbmN5IGJldHdlZW4NCj4gdGhlIGNsaWVudCBhbmQgc2VydmVy
Lg0KPiANCj4gRGFpcmUNCg0KbWFuIDUgbmZzDQoNCkxvb2sgZm9yIHRoZSBzZWN0aW9uIG9uIHRo
ZSAnbG9va3VwY2FjaGU9bW9kZScgbW91bnQgb3B0aW9uLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
