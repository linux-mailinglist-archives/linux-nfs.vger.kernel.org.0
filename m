Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF77B3DB5
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Sep 2023 04:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjI3C5f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 22:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3C5e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 22:57:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2122.outbound.protection.outlook.com [40.107.102.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11CFA
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 19:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeM9tnkkK4pTlZBR5dayNgsuAAWjYumfsepVf6dTSiW3YdFoLbRiofPBboNMYRBdtCpU9PEH5HY/jNNYIGmjwHqcIDV/Ae9Hh+SD9jyIGDzqUAsErKzcpfsEYSpmoOlLhBCkaMkPFSwzZpYCcM1oARGfw3sQjliyPJGy8s92SeG6f5a8u4ElixvrK3InPC/N+RBsUGhMmNrgd+VPgaRGHLPzvTFBkWTJ7owhvqZhTCZGKiDl6FzbOyevcH4UMpvCK7RegwsHLiYf0ef8HzKM8mZ+I8bvVy+2xtwPZWF19/0j0EoIeM5/B1WRrs5Cr8fmU7ilar9HZS0GsVaKbkgaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRihagRCdNboShynOMPftS75WxIVLUhGcBocRF1dMMY=;
 b=VTp4TWrvP5yyQ3lHOd+RKbbp8P5b1LjU+0Ub5dxjVvuhiTwlJV/L+AAF/etDijJ5XjeBmF+tJI5oDV0AhN+bSe4drpaLGrRkGRP0WflNJpqd1WI60pkg49b9H/rz0HNTEvFbP1RTLWq+Z8YBnM8HmidvXMAVuDH1Ywv3OwZmZV8jjcXrlGOHCWJvXzGZgco2DOXCumVN/zCCfc7ULjb6BzHKjYCbRH2cRvYwM36M+oDh4m4nW9xM+3Z4qQdfHxr02wl1mGajujR4NfwHAskHUyRLeIG3MBWz9tV+ZTs5YNYUbIMtvEJnfMftIDMU/PztuPz7teeAMV/20hV5Kl34AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRihagRCdNboShynOMPftS75WxIVLUhGcBocRF1dMMY=;
 b=b+grTbjL3DX7diPenRfBsnQijdSOCnW7xD3TRgCXBYWOe9YyOdStlMwn7XRVwACKCcuoXsz1f7PnsEZE0unmhnDVaauClCD4JcFLplnZhHvZ7aygS21Qj3H/OAnlgKG0ifCOYtCFPU3Es3FYnMHRV2Jiw07V2bf56w4N7IU8sGc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5229.namprd13.prod.outlook.com (2603:10b6:408:158::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Sat, 30 Sep
 2023 02:57:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20%7]) with mapi id 15.20.6838.027; Sat, 30 Sep 2023
 02:57:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Don't retry using the same source port if
 connection failed
Thread-Topic: [PATCH] SUNRPC: Don't retry using the same source port if
 connection failed
Thread-Index: AQHZ8XlxPe7O6soAskaOyFDp5noXCLAwVWwAgAJbUYA=
Date:   Sat, 30 Sep 2023 02:57:28 +0000
Message-ID: <c32aec7b2a8b226a1617ff9755b7b5ce64ad3114.camel@hammerspace.com>
References: <20230927192712.317799-1-trondmy@kernel.org>
         <CAN-5tyF9rKdu0D-7nUFQtq1BWQABb+mdY3sLrDY1-sU_Q2p8fA@mail.gmail.com>
In-Reply-To: <CAN-5tyF9rKdu0D-7nUFQtq1BWQABb+mdY3sLrDY1-sU_Q2p8fA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5229:EE_
x-ms-office365-filtering-correlation-id: 044a8144-5c95-45bc-061f-08dbc160fb75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDBKE0NR9dSw0dmD7Mo8zqnYCiwOWsXPxvl8MirHguFFxSDos7Mm6t0dvdqe9J6Wj/0KA25LOvk172u6joUB5XpWUdfttMogF3LSgL/SZjOZz+7YS/Uji1ooMnCsk4hcRHqjwdvuLXIuM7qX9EyAb37FR2Isfa6gPJzfFtt6S9L9GVvlVVQyAMOVlH9gBtqLYFsq9udHNTqgRS8K4jbt0alxpgRxW4BxY36fwgjETCzndxZJ/yflw/m7qDsVmHKzIutE9X43jJ+kG8jSy2K4levpqs+FRkCdJ1NzevftBzvDKlpg+gbRTZnxo8ep+fy3DFR8PiQR3PpZBU2PLoW/aRvbaYi6Fwp7CbBDQZVkzQIok7Dp+RtzwWfcGk8YSIzhOeKqFhoB23+JwpmZl4PQDYvTl2S0ws/PZNh2gzunN8JZA1ahYsNbgkMTCotOJQzDvmFl0kOXa75oGnYLcvWHALg0xOm7RDIb+Q8+uapiT8HlnjOcj13aHRoIowFSEwPi869LRszHFEqc30eLWBXwtE3wOURQ+j/5+0B5/N58i67jjYzvSPYR+TJJAuR9BxoKBTC8jd5Q/t3IQK5cRRoy5fwDPYbiQP8ilYZAyJ38cAVIVn4zvRUeovZrsBmiPyxDXj+HFNduJKPJMJS2QiVXQw3hdfxNqyg5FlxXNDiv68w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39840400004)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(6506007)(122000001)(2616005)(26005)(66556008)(64756008)(86362001)(53546011)(71200400001)(6486002)(478600001)(38070700005)(38100700002)(83380400001)(316002)(2906002)(6916009)(66946007)(8676002)(8936002)(4326008)(66446008)(76116006)(66476007)(41300700001)(5660300002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cllYanUyTEJDZkN5MWtka2JQN1c5bTA2czlqYjBwOWdlczhWWkJYNitUTGlo?=
 =?utf-8?B?eFNiSytaVzFYaEZ1QUpMcy9sam9Dc3ZCVTdidHo4ZGZwSzhLN3FIbUhtelp3?=
 =?utf-8?B?cTIvTnhWWlhacWVEY3JoaDMzZzV5Vi9EU29NTFM3UU42WnY3T0RvUzJ6Nlor?=
 =?utf-8?B?c3ltY2ZFZlljWlJDVUhGUHhWMzhZMnFOdzRFT0JTQVVHc3FUeW9HbzFRcTF6?=
 =?utf-8?B?cmp4bzJ4bDlzVEhKVmxRcVVocTJXMXBKOEdTdDk4cUQwa2t4czhFUlpEVnZI?=
 =?utf-8?B?UlV5bWxiUFE5OWxnb1UrcndNMUp5WjZFU0NuYjBzNTVMU1BUNVNIaEtjcWxa?=
 =?utf-8?B?SjR5K0RIWk9vTFhvOC9BN1IvbXRmVjZvaVovYVJBOXV2RUZmdmJrblVYVjl5?=
 =?utf-8?B?aTk5cFl1bVFIdmErNHVvNEJySDVGNVNOcGQ5OWtGb0FYMXFOaU0yYW9QWFRj?=
 =?utf-8?B?VXBTUVpRdFV4RTh0eDUzaktBNmpsZE9OdmgwY2lsTU9ZWTYrUWx4YldodnQz?=
 =?utf-8?B?MUVWT0txUm5HbVhjbjluS2FWN0Z6cWhjVDh6YStCdTVKcFQwZnVPL3YveGkv?=
 =?utf-8?B?N1lhYkhnOXc4bTR1QlJGaUhkemh6TDBQK3UwTVdFQXFLVEZGd1BkelFzOHhG?=
 =?utf-8?B?M3R1Ly95cDVWb1d2NVVoZ1NIcVdqa2h5UWZ4eHgwTUkrbStYSFFmeEhHVTNX?=
 =?utf-8?B?RW0zNndWMGxoaTIwY1ZkTDRzSUM5ZXJwRnRtTGpnNDJaSTg0aHY3bTNvMEdH?=
 =?utf-8?B?SjlQVzFhOWQ3RXhWNzN6S3hKbzRaTHhIRmxWUGZnQjJlSjdtR1BIcXBCV3lT?=
 =?utf-8?B?dTR4cjhSWEVabGJPQUF2ck1NUnJ3U2FRYjZmZWVBRGpSU1FBL1JyUmZ0ZFdt?=
 =?utf-8?B?K2x4Z3RxNG5PaVlGUWNicEJhdURsekF3S05yVHdZdnQvUjFpZ0NmV3E1OW9z?=
 =?utf-8?B?RFVjZ1hTd1l5UldjWHpIUlRPUWoyajRGeGFNRTJqdjRBLzhEYWJCMEpUSm9I?=
 =?utf-8?B?R1Z1cXpkdU1sNmM4RWpIRjloc3hQby9QRGVBMEEvanBqTTJEOTVkNnhvRzVB?=
 =?utf-8?B?TjFSQjEvYlJGWldORFBtblVtMk1jcmh3MVE2K1ZpOXhpYzUvQWhqYkVaOVBi?=
 =?utf-8?B?TDlXRmVBREFrcWJRL3E5TDlhcGNSeGt5b3U4ZDZjVEYrWW5JTEx2UGtYMjRC?=
 =?utf-8?B?aFlXeVhLdDJ1bzRDVEpKNEtTTWpMT0VuUUtUeWtlOFhqWnRHS0NOMWhpUnhx?=
 =?utf-8?B?QlU3STQ1Z0JQTGVIY1YyUjd4dnJZSmFUK1dmUnNTbXB2TEphMGlJY2xweHhw?=
 =?utf-8?B?blV3Q01xZnZES0tWL1RrVGMrVnhIenFpSVBCN1liSDV5bFNCME9TRG5RcVZo?=
 =?utf-8?B?L2c4dFNjZ2oxQTVsdmJJeHh5ay93ekRhL1FOS2pHbFlWVzZOWUxHL2VxWG1O?=
 =?utf-8?B?Ym43cWZhVWRKekpLUVpwR2c5SzdtYkgxbFY3dmtwWWliNnFvYTZvclZDT1Vo?=
 =?utf-8?B?VVBOQ0x5SXFqdEpiK0dIN2FDQWQ5aFhrTWRVU3ZQUmxEUGVQQnJOVm9CR0Qx?=
 =?utf-8?B?Vkgxb05FUWlyM1ljdUNlVXIraWU0TmZ1bS9FcFRVUHVtTzFPbGFYUUY0SlVq?=
 =?utf-8?B?bmk3clpuUlpBN3lualdINnZPUVVTTWM1UzNka3JPZ1E0eVZiUHlXbkJyeVVO?=
 =?utf-8?B?QkU2WlFiRjUzU2VRcUU2VEZRci9qN0dVV3E5QmxIQXYvYjBaMmxnTHA4bm12?=
 =?utf-8?B?SHY1cFhOQ2o5Yzc5T2c1aTR5TWVMYlFMSjVwUGp5cVdVWkdTMEdhL2dReHpI?=
 =?utf-8?B?SzYraCt6WDJLNG1FcDZNWlJ5LzM2ZkZRMHpkTGI3Yjg2dnRycU9aamRaUHl1?=
 =?utf-8?B?U0ZWT3NONHNaNGNaNmdYWEpzemtvYklrN2NXYzBVT2F0d3MySGJ0dWlqUmtk?=
 =?utf-8?B?bnJEZkZwb1Nta2MybGNFWE9JeWdzQ1hBRmowdDJQUmE1NDVRODlHRXZ2d0h1?=
 =?utf-8?B?aDRTYmZXc01rYmJZQnlsbTR6L2VEdVF4cFN4dS9jenFFZWhuaDJBWGFHaVBa?=
 =?utf-8?B?UnB3Q0k3SkN3bEVTdGlaT2ZMRklocWFwRU0xb3ZIalYvSVlncXJoY2pvcDBz?=
 =?utf-8?B?MW0zd042R3FYOHhBU2hpUFpGb2xENHpRU25FVGJzdzZNWHNsdTJReS9WOXpD?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC621C44A8893B478A76D0694FF3A84D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044a8144-5c95-45bc-061f-08dbc160fb75
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2023 02:57:28.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZITMMqHe6TrbA+V+xZR3wjzejlN0Gw4DmlCUei5A3E0+uQ9oaV7eOWbipzt7ZyJdd3/iTFBIX9Qg83LutIoCuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5229
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTI4IGF0IDEwOjU4IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBTZXAgMjcsIDIwMjMgYXQgMzozNeKAr1BNIDx0cm9uZG15QGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiANCj4gPiBJZiB0aGUgVENQIGNvbm5lY3Rpb24gYXR0
ZW1wdCBmYWlscyB3aXRob3V0IGV2ZXIgZXN0YWJsaXNoaW5nIGENCj4gPiBjb25uZWN0aW9uLCB0
aGVuIGFzc3VtZSB0aGUgcHJvYmxlbSBtYXkgYmUgdGhlIHNlcnZlciBpcyByZWplY3RpbmcNCj4g
PiB1cw0KPiA+IGR1ZSB0byBwb3J0IHJldXNlLg0KPiANCj4gRG9lc24ndCB0aGlzIGJyZWFrIDQu
MCByZXBsYXkgY2FjaGU/IFNlZW1zIHRvbyBnZW5lcmFsIHRvIGFzc3VtZSB0aGF0DQo+IGFueSB1
bnN1Y2Nlc3NmdWwgU1lOIHdhcyBkdWUgdG8gYSBzZXJ2ZXIgcmVib290IGFuZCBpdCdzIG9rIGZv
ciB0aGUNCj4gY2xpZW50IHRvIGNoYW5nZSB0aGUgcG9ydC4NCg0KVGhpcyBpcyB3aGVyZSB0aGlu
Z3MgZ2V0IGludGVyZXN0aW5nLiBZZXMsIGlmIHdlIGNoYW5nZSB0aGUgcG9ydA0KbnVtYmVyLCB0
aGVuIGl0IHdpbGwgYWxtb3N0IGNlcnRhaW5seSBicmVhayBORlN2MyBhbmQgTkZTdjQuMCByZXBs
YXkNCmNhY2hpbmcgb24gdGhlIHNlcnZlci4NCg0KSG93ZXZlciB0aGUgcHJvYmxlbSBpcyB0aGF0
IG9uY2Ugd2UgZ2V0IHN0dWNrIGluIHRoZSBzaXR1YXRpb24gd2hlcmUgd2UNCmNhbm5vdCBjb25u
ZWN0LCB0aGVuIGVhY2ggbmV3IGNvbm5lY3Rpb24gYXR0ZW1wdCBpcyBqdXN0IGNhdXNpbmcgdGhl
DQpzZXJ2ZXIncyBUQ1AgbGF5ZXIgdG8gcHVzaCBiYWNrIGFuZCByZWNhbGwgdGhhdCB0aGUgY29u
bmVjdGlvbiBmcm9tDQp0aGlzIHBvcnQgd2FzIGNsb3NlZC4NCklPVzogdGhlIHByb2JsZW0gaXMg
dGhhdCBvbmNlIHdlJ3JlIGluIHRoaXMgc2l0dWF0aW9uLCB3ZSBjYW5ub3QgZWFzaWx5DQpleGl0
IHdpdGhvdXQgZG9pbmcgb25lIG9mIHRoZSBmb2xsb3dpbmcuIEVpdGhlciB3ZSBoYXZlIHRvDQoN
CiAgIDEuIENoYW5nZSB0aGUgcG9ydCBudW1iZXIsIHNvIHRoYXQgdGhlIFRDUCBsYXllciBhbGxv
d3MgdXMgdG8NCiAgICAgIGNvbm5lY3QuDQogICAyLiBPci4uIFdhaXQgZm9yIGxvbmcgZW5vdWdo
IHRoYXQgdGhlIFRDUCBsYXllciBoYXMgZm9yZ290dGVuDQogICAgICBhbHRvZ2V0aGVyIGFib3V0
IHRoZSBwcmV2aW91cyBjb25uZWN0aW9uLg0KDQpUaGUgcHJvYmxlbSBpcyB0aGF0IG9wdGlvbiAo
MikgaXMgc3ViamVjdCB0byBsaXZlbG9jaywgYW5kIHNvIGhhcyBhDQpwb3RlbnRpYWwgaW5maW5p
dGUgdGltZSBvdXQuIEkndmUgc2VlbiB0aGlzIGxpdmVsb2NrIGluIGFjdGlvbiwgYW5kIEknbQ0K
bm90IHNlZWluZyBhIHNvbHV0aW9uIHRoYXQgaGFzIHByZWRpY3RhYmxlIHJlc3VsdHMuDQoNClNv
IHVubGVzcyB0aGVyZSBpcyBhIHNvbHV0aW9uIGZvciB0aGUgcHJvYmxlbXMgaW4gKDIpLCBJIGRv
bid0IHNlZSBob3cNCndlIGNhbiBhdm9pZCBkZWZhdWx0aW5nIHRvIG9wdGlvbiAoMSkgYXQgc29t
ZSBwb2ludCwgaW4gd2hpY2ggY2FzZSB0aGUNCm9ubHkgcXVlc3Rpb24gaXMgIndoZW4gZG8gd2Ug
c3dpdGNoIHBvcnRzPyIuDQoNCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlr
bGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKg
bmV0L3N1bnJwYy94cHJ0c29jay5jIHwgMTAgKysrKysrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9uZXQvc3VucnBjL3hwcnRzb2NrLmMgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gPiBpbmRl
eCA3MTg0OGFiOTBkMTMuLjFhOTY3NzdmMGVkNSAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvc3VucnBj
L3hwcnRzb2NrLmMNCj4gPiArKysgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gPiBAQCAtNjIs
NiArNjIsNyBAQA0KPiA+IMKgI2luY2x1ZGUgInN1bnJwYy5oIg0KPiA+IA0KPiA+IMKgc3RhdGlj
IHZvaWQgeHNfY2xvc2Uoc3RydWN0IHJwY194cHJ0ICp4cHJ0KTsNCj4gPiArc3RhdGljIHZvaWQg
eHNfcmVzZXRfc3JjcG9ydChzdHJ1Y3Qgc29ja194cHJ0ICp0cmFuc3BvcnQpOw0KPiA+IMKgc3Rh
dGljIHZvaWQgeHNfc2V0X3NyY3BvcnQoc3RydWN0IHNvY2tfeHBydCAqdHJhbnNwb3J0LCBzdHJ1
Y3QNCj4gPiBzb2NrZXQgKnNvY2spOw0KPiA+IMKgc3RhdGljIHZvaWQgeHNfdGNwX3NldF9zb2Nr
ZXRfdGltZW91dHMoc3RydWN0IHJwY194cHJ0ICp4cHJ0LA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKTsNCj4gPiBAQCAtMTU2NSw4ICsxNTY2
LDEwIEBAIHN0YXRpYyB2b2lkIHhzX3RjcF9zdGF0ZV9jaGFuZ2Uoc3RydWN0IHNvY2sNCj4gPiAq
c2spDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+IMKgwqDC
oMKgwqDCoMKgIGNhc2UgVENQX0NMT1NFOg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAodGVzdF9hbmRfY2xlYXJfYml0KFhQUlRfU09DS19DT05ORUNUSU5HLA0KPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICZ0cmFuc3BvcnQtPnNvY2tfc3RhdGUpKQ0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAmdHJhbnNwb3J0LT5zb2NrX3N0YXRlKSkgew0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4c19yZXNldF9zcmNwb3J0KHRyYW5zcG9y
dCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4
cHJ0X2NsZWFyX2Nvbm5lY3RpbmcoeHBydCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbGVhcl9iaXQoWFBS
VF9DTE9TSU5HLCAmeHBydC0+c3RhdGUpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBUcmlnZ2VyIHRoZSBzb2NrZXQgcmVsZWFzZSAqLw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB4c19ydW5fZXJyb3Jfd29ya2VyKHRyYW5zcG9ydCwNCj4gPiBYUFJU
X1NPQ0tfV0FLRV9ESVNDT05ORUNUKTsNCj4gPiBAQCAtMTcyMiw2ICsxNzI1LDExIEBAIHN0YXRp
YyB2b2lkIHhzX3NldF9wb3J0KHN0cnVjdCBycGNfeHBydA0KPiA+ICp4cHJ0LCB1bnNpZ25lZCBz
aG9ydCBwb3J0KQ0KPiA+IMKgwqDCoMKgwqDCoMKgIHhzX3VwZGF0ZV9wZWVyX3BvcnQoeHBydCk7
DQo+ID4gwqB9DQo+ID4gDQo+ID4gK3N0YXRpYyB2b2lkIHhzX3Jlc2V0X3NyY3BvcnQoc3RydWN0
IHNvY2tfeHBydCAqdHJhbnNwb3J0KQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoCB0cmFuc3Bv
cnQtPnNyY3BvcnQgPSAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+IMKgc3RhdGljIHZvaWQgeHNfc2V0
X3NyY3BvcnQoc3RydWN0IHNvY2tfeHBydCAqdHJhbnNwb3J0LCBzdHJ1Y3QNCj4gPiBzb2NrZXQg
KnNvY2spDQo+ID4gwqB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKHRyYW5zcG9ydC0+c3JjcG9y
dCA9PSAwICYmIHRyYW5zcG9ydC0+eHBydC5yZXVzZXBvcnQpDQo+ID4gLS0NCj4gPiAyLjQxLjAN
Cj4gPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QgTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
