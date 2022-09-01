Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C05A9BF2
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiIAPnw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiIAPnv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 11:43:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D498A6E6
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 08:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDqM2Pb1jAwbHlECCBpfvi3P5QsnBw77rjqEloSaD6JkGwYYBdYomMixW6f4eJJFZiWQTw+gqYiAL3GoEbED+uTckuok0lm+kncWmI/LoxvB+mzc0h+N7fFinf4EasNAsfSIx0ei9luo1YppwfZ5HjKEUFuL52k3SnMGgoBQ3509Vgbk3NyTPbGsp0CNud96ElgaSXCnFJH2DWeqk0CUF/EAZf8Ep5FFwkK12laH9WKus7mWEjW8sZTak1Kpg9BwFuo12Rg/oZ9RNRgC2kKosxfqylylhmqg5v7Y+vGpmnalxFrsdm7z6926Ym5jIJQg44ksw7osSIJxesNLg1dmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N409w5kNu26Re9xqWJhhF4M6BhWwwR7wMMrqNl4p9Wo=;
 b=TkhhvPIfy9Fe3xuEGug8KpQflFh74ycisPluXzMqSizAtN6+PT3reFFlyBTPL8mrmSA4pZUHZeEQ879+tQ8xmJdvPXoZ53LsMQHirRp4WwUbVAO1FLENeRgD67oVAS+bfwV6sIOXh1K75fHtKyYSZCC+RWdtwdXArIAsiMbf5DC/BpTXJSfVaA/8xChGF22qjtenkI9NTbDUJ5b8Mna/hLPw8IUB+4tBH7r9ca7eXjp+nXi/uOfUAPdJk+bgrXsLvHc+8cU/lJJQmYtrnJcwtwpkikgv8IfqIjbSIRDq9Yp5XniVPdGpfCjzSD5S88Hvzp91gbwMf0PIkHN3uW3eLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N409w5kNu26Re9xqWJhhF4M6BhWwwR7wMMrqNl4p9Wo=;
 b=bmQfmjEoNMdOosB0EWY19tauqlojF5e8JqILaHOhSkC4Jd3uLqJGdqmdkwVsuwmeJwiUMKNxNDLTOyB0W7oXbLlaST/ZuILkVj88iegm+hiIscS3qcw8ZzL3K+UET0z+6KJ8s4+3XVKH/GZOVnBVyjv8WvVBTf4euhO2nH7iqIM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW3PR13MB4011.namprd13.prod.outlook.com (2603:10b6:303:2c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Thu, 1 Sep
 2022 15:43:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.005; Thu, 1 Sep 2022
 15:43:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "daire@dneg.com" <daire@dneg.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: directory caching & negative file lookups?
Thread-Topic: directory caching & negative file lookups?
Thread-Index: AQHYvgepinoQ18GCcUu67eOreR0vTa3KmPSAgAAZvoCAAAR6AA==
Date:   Thu, 1 Sep 2022 15:43:47 +0000
Message-ID: <561ef18af88ecda0f7b8abf55c1dfb2b66cf5dea.camel@hammerspace.com>
References: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
         <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
         <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com>
In-Reply-To: <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW3PR13MB4011:EE_
x-ms-office365-filtering-correlation-id: b3793d4d-361d-44c8-5966-08da8c30c22f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+bLTBhanRl3Y16l1SopSMggItORgRH2mualYXRJBckpaUeyEM010XxTdNwmib6FihtmT/aAa0GdtK31TWsni2RitdT6yzOqITs5ogpwe6gnle93ybBRlFVFDbGgRfBROsB0kmebm5lZxKxY8kmZkeBbnykF0YxwIN4hHeERqd7DNgSQFpajt8LnuhWQEY+zDXnWiN8FL+VY/KZoMypYRuAoZyo28JBQIa/2feq0zPj2ypNU/cYks+/8B8gCkxB4vR3z8aPZq6sl35IMxU7r80/FrF0Fm8rQ5jXeak0cq6YGfWiZiAmS/4ICO4Z+UzY9um32IyivKCe50dWkXj7eJXaOFJcAuSjN2eK+Y+eD8YBn/GegsKggGBHKGG6keRW155keAqdAhc/NfKNrJ9Rf4GxnoRaoeT1jTRMvR8Innw3OLMe4AEIVQl46DgOO9VozJZRl7ILUimXgdFL7Vwa38MxsFAMzTu1K4OSMk/bNyjsUc0cu826IgvLNbq3sjUeOQhyXEOgqvnGXZnpLq0+pluUvsvSSJqXYvMgwWZn3vy/HW7JcHQIhOvzP4xgxG/hasmq9VbFkAKTwvXuV7hx22J2wQIuFkWYKCbWqYWcFOhLX/XvHRPajQCSmVEu9q5fp2QUzMHgU5SMrli0Y2lUtXE/BRXOKg6dsoMspn6ahe0SnB4KZSEqi4Pp47jWPLLdDyy940w3nbibOtW9W/MfK77tC7AL3o8sqmF6M1i33WwykDrEkdRbwLGHm2k+f9uFhrTHWAC3kTZdI2UguVs859/Tfy4qJxY4mJzJslYyy61f0NT4JlPkn5+4rD0puWhDU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(136003)(39840400004)(366004)(122000001)(38070700005)(5660300002)(38100700002)(41300700001)(71200400001)(6916009)(36756003)(316002)(83380400001)(6506007)(186003)(86362001)(2906002)(2616005)(8936002)(26005)(66946007)(6486002)(8676002)(66476007)(66556008)(64756008)(66446008)(76116006)(478600001)(6512007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlRFYm9oUXZnMlV2MEZwNm5HSTdUQmdlWHNaeHhSSTNMNEREYTVjeUpza2J6?=
 =?utf-8?B?Z3h0c0grSlZ4UDFYQjl4Mm1Pc0V5Ly9HY1BCTDFqaml4alF1bWEyMDhhR2lU?=
 =?utf-8?B?TDU3VFZ2a25PUkVQQ3BlZ2p4TWdnRHdBNTVKalgwbFJRMnZEY0Z5VGVTZUdz?=
 =?utf-8?B?VGVZcGo0SHNTeENmbncwREdwVG15QzA0bEZjZ2cvZzd4QUNZcmRIN1hwMFcv?=
 =?utf-8?B?YWdYNEJNZFA4KzBBNktqN3lwL0FWUU1OL2lQMnpwamxCYWY2cnFCWlVEUjl3?=
 =?utf-8?B?eC9OMzMwUy9jNDh2VjA2NlFib2sxUkYycUI2c2FNRGxKcEdtWHFtYnp1bFIz?=
 =?utf-8?B?NURVS1RDaGM2TXN5WmZQRzNPWGdmTzNmN1lwUjlpeVhuamQyYzhCemZicElm?=
 =?utf-8?B?WjJzc2VWcjB0dGZ5eDZpWDg0OUFRMm1PdjZtUmJWNDZGRE4yUDVKUUltNjBS?=
 =?utf-8?B?UnF6V1ZTd2tUOTJLR3YyaUhqYWZseVpPL1RaTkVsQXA3L2JERzNNcW5vT0JR?=
 =?utf-8?B?KzNDZkdnYmZCY2RjTXl1b2NEcEJCRnQzK1g2R2kzam8wc0dzVlRvVEY3eURS?=
 =?utf-8?B?UkpwNUxPNEFYVXBoOFh4TWNaY00wK3p3ZFVNOE1aMGdvMnIvMUdUTEh2UzNW?=
 =?utf-8?B?Y1ZzRVhYcUc4T0xkeFFiMHNoRm5vNktYOE1Mc2tSUXVMb2RpZE5GWkxOblhm?=
 =?utf-8?B?MzltdlhyeWZ5alJDVkFDbFhZSFF6TWNtNVE3MUlVRUM1bW1hTHdMYWo0YlpR?=
 =?utf-8?B?S2ptOXRMdEphcFp1YWozK0dwTGprQWp5NnpnMHNzZ2I3cDRpTUNySS91ZlB3?=
 =?utf-8?B?OHlvMThxSVpZMURXbUFIUnd1WUQyc2hrUVhyUTJWNkp0Y2VodGFVNjBpMTNK?=
 =?utf-8?B?YTZPYlRDOFlpaUJicWpFUkordDBTR2h5a1pzSS9FallGTHJyVnozVHJUZUpq?=
 =?utf-8?B?NUdZR24vdlR5VC9CcUVGNkpTak12aldOS1Bmd0tlUDlwbk4wa1Y4YkVCS0Zk?=
 =?utf-8?B?M1lUaThYTU9XQUNxN1JtMlZacmx6SnVON2w5dFhhV3FLRVJ5SWZ1QUhwWWZ6?=
 =?utf-8?B?WUVhWHZzTzZGZW5jZDF0T2c4QzhkSmdPUk9JZEpMckZRc0VGSGdGOVJXVjA4?=
 =?utf-8?B?MTkxM2xBcWJkdTFyUW9VM2FkNUxpRXorSlZ5Zk5SaVVadXNwMnR0L1l4STNl?=
 =?utf-8?B?YzFBQWViNkEyVlVXVnZ4RGJUc0VKcE9tenFEU2dBT1pibzY5N0ZEakloWHA4?=
 =?utf-8?B?aEI3ZnVsNlBGcWYyeFRkWjh4WVA0RjJORnJHcm41ci9EZjBNQ3FUbzRDeEZl?=
 =?utf-8?B?YW9JNCtMVkYzV2hKbnFrb21HajgxWk5QMlQzeU9jMC9YTHJpYWN3TXM3M2xI?=
 =?utf-8?B?WnFtcC80TVcveUdhc09RM1dSTzgzOHlLRjZ3SWd6S2U3bmJJZHp0N2c5TUJJ?=
 =?utf-8?B?NVFEUHRUeFhUOGRncVZ1MWwyRWl6MDVQSzlIbVp6dXM4SEFEZExTajl0RHF5?=
 =?utf-8?B?TlpEUHhHZHhnUlk1MGFMVDRnRUVhU0UxVXVXK3IwcFppUzNEUXUyNzh2OG9B?=
 =?utf-8?B?Q0Z0b1FuMEh2U1Z1MGFVWTZpYjBGZHVxSE9yM3YwSWxVNEJUNCtHa0JqQXRF?=
 =?utf-8?B?dzdBb1kyalJqc2QrOHVWbUtURXdoWGNQQmJTejdrUDNXd1pVNHczN0Jzc1ov?=
 =?utf-8?B?eFg4RHc3RXJXMmc5a2pCb0FHejhGK2JYRmlnTmxzTTlqTVZvOFVCUDFQdG01?=
 =?utf-8?B?dnhNbzNDalllckttakhWVmhaeDJ2VEpnWWJmV1JCblpNQmRCRkhUMkM4VFZq?=
 =?utf-8?B?SmM0SzVaUTEvNDVoaTZJZGllRkEreFgwTXlxKzVDdlRGMVUyTzhVN0d1N09Y?=
 =?utf-8?B?TEE0dUpnaXBLZTQ1TVhrcUxrMUZQWE16WUxBZjJCZXFXdzRIcVhKcW5hOGxk?=
 =?utf-8?B?aUNoMmRXQ09HR283NWVjSVFFZDhCVEJBZTduYlNnN0ppZGIrWHJIMTlJSUY4?=
 =?utf-8?B?bEVCdFpqNTRGV00xRTAwRkloYzdEMWd5RkM0YnlaaXdaRmZZQXN3czFHK3lG?=
 =?utf-8?B?TnBjcFljaDdoSGpuZ2ZpVCtYek9jSFNWeDBuNVJ0Z2lNMVVnR1V2WkJ5Rk5o?=
 =?utf-8?B?VjQzSm10TW4xeXRhS3NyS215SHp2enV5aW9VZUVsaGcraHZZUjZjNzEwbytS?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A449B74E88E853428DA673250B0E063B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTAxIGF0IDE2OjI3ICswMTAwLCBEYWlyZSBCeXJuZSB3cm90ZToNCj4g
T24gVGh1LCAxIFNlcHQgMjAyMiBhdCAxNDo1NSwgVHJvbmQgTXlrbGVidXN0DQo+IDx0cm9uZG15
QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gbWFuIDUgbmZzDQo+ID4gDQo+ID4gTG9vayBm
b3IgdGhlIHNlY3Rpb24gb24gdGhlICdsb29rdXBjYWNoZT1tb2RlJyBtb3VudCBvcHRpb24uDQo+
IA0KPiBTbyBJIGdldCB0aGF0IHRoZSBjbGllbnQgY2FjaGVzIG5lZ2F0aXZlIGxvb2t1cHMgb25j
ZSB3ZSd2ZSBtYWRlIHRoZW0NCj4gKHRoZSBkZWZhdWx0IGxvb2t1cGNhY2hlPWFsbCksIGJ1dCB3
aGF0IEknbSB3b25kZXJpbmcgaXMgaWYgd2UgaGF2ZQ0KPiBhbHJlYWR5IGNhY2hlZCB0aGUgZW50
aXJlIGRpcmVjdG9yeSBjb250ZW50cyBiZWZvcmUgdGhlIChuZWdhdGl2ZSkNCj4gbG9va3VwLCBj
YW4gd2Ugbm90IHJlcGx5IHRoYXQgaXQgZG9lc24ndCBleGlzdCB1c2luZyB0aGF0IGluZm9ybWF0
aW9uDQo+IHdpdGhvdXQgaGF2aW5nIHRvIGdvIGFjcm9zcyB0aGUgd2lyZSB0aGUgYXQgYWxsIChl
dmVuIHRoZSBmaXJzdA0KPiB0aW1lKT8NCj4gDQo+IE9yIGlzIHRoZXJlIG5vIGNvbmNlcHQgb2Yg
ImNhY2hlZCBkaXJlY3RvcnkgY29udGVudHMiPyBJIHRob3VnaHQgdGhhdA0KPiBtYXliZSByZWFk
ZGlyL3JlYWRkaXJwbHVzIGtuZXcgYWJvdXQgdGhlICJmdWxsIGNvbnRlbnRzIiBvZiBhDQo+IGRp
cmVjdG9yeT8NCj4gDQo+IE15IHRoaW5raW5nIHdhcyB0aGF0IGlmIHdlIGRpZCBhIHJlYWRkaXIv
cmVhZGlycGx1cyBmaXJzdCwgd2UgY291bGQNCj4gdGhlbiBkbyBsb29rdXBzIGZvciBhbnkgcmFu
ZG9tIG5vbi1leGlzdGVudCBmaWxlbmFtZSB3aXRob3V0IGhhdmluZw0KPiB0bw0KPiBzZW5kIGFu
eXRoaW5nIGFjcm9zcyB0aGUgd2lyZS4gTGlrZSBJIHNhaWQsIGEgbmV3YmllIHF1ZXN0aW9uIHdp
dGgNCj4gbGltaXRlZCB1bmRlcnN0YW5kaW5nIG9mIHRoZSBhY3R1YWwgaW50ZXJuYWxzIDopDQo+
IA0KPiBEYWlyZQ0KDQpUaGVyZSBpcyBubyBjb25jZXB0IG9mIGEgJ2Z1bGx5IGNhY2hlZCBkaXJl
Y3RvcnknLiBUaGUgVkZTIGFuZCB0aGUNCm1lbW9yeSBtYW5hZ2VtZW50IGNvZGUgYXJlIGZyZWUg
dG8ga2ljayBvdXQgYW55IHVudXNlZCBjYWNoZWQgZW50cmllcw0KZnJvbSB0aGUgZGNhY2hlIGF0
IGFueSB0aW1lIGFuZCBmb3IgYW55IHJlYXNvbi4gU28gdGhlIGFic2VuY2Ugb2YgYW4NCmVudHJ5
IGlzIG5vdCB0aGUgc2FtZSBhcyBhIG5lZ2F0aXZlIGVudHJ5Lg0KDQpGdXJ0aGVybW9yZSwgY2Vy
dGFpbiBmZWF0dXJlcyBsaWtlIGNhc2UgaW5zZW5zaXRpdmUgZmlsZXN5c3RlbXMgb24NCnNlcnZl
cnMgbWFrZXMgaXQgaGFyZCBmb3IgdGhlIE5GUyBjbGllbnQgdG8ga25vdyB3aGV0aGVyIG9yIG5v
dCBhDQpzcGVjaWZpYyBuYW1lIHdpbGwgb3Igd29uJ3QgbWF0Y2ggYW4gZW50cnkgcmV0dXJuZWQg
YnkgcmVhZGRpci4gSW4NCnRob3NlIGNpcmN1bXN0YW5jZXMsIGV2ZW4gaWYgeW91IHRoaW5rIHlv
dSBoYXZlIGNhY2hlZCB0aGUgZW50aXJlDQpkaXJlY3RvcnksIHlvdSBhcmUgbm90IGd1YXJhbnRl
ZWQgdG8ga25vdyB3aGV0aGVyIHRoZSBsb29rdXAgd2lsbCBmYWlsDQpvciBzdWNjZWVkLg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
