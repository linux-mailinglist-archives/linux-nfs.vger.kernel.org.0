Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD07AE1D7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjIYWpJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjIYWpJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 18:45:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070FC136
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 15:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFAMaWfJYunUfA85PX8p/b5ld4wKWCVuS6loEtYh/u3Zy3MC6Y6uPLqaSO+YM3UZzanMlEbTtu5l15okJwGkTBcmtV9Eubs1aO13YsSouV89/tbU8is1cwhwnKmj6dSKkiexwsioPAPkhfmNeq7VOwanRuhUVwjCFmeuphn7D9xF5nwtfTl7xvb1vGQjHmSTQ2UzZVMw6PU8l3R2wLq+nmTOrXODgHmmQ4ZIt1qnmG1urcdZ+xmsqmPGzym/zrLq0IkZar2HR8X4AINP9WRv2sjIqKoW7jc6h548PJOTM6NePmmo9EjJh6S1/3YTN7DM5Fm2p2GA9CjGM/kZ/ez5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0gXN8nB/5lETM8FwURebwx9iMwYe2yFy//Iz5gwG4Y=;
 b=WRRqvc1kGkfaNMmOPXWVPCj/Dr7RvCqZommUKEsV/tYWdRV61AYI5JcJYrWFP4dsvaQG1ljevdlNYvXuxEkZ30WS1p8fXSZnIxxN00unnmL6rnjsVQf0IYe/qHSVz04yAaXgj999Fo2R1/Nqoc4rF3YjL+igOM91+Wi8kK0n/osbWNieQbdskkuA4IcUSPrTLVK2S+vUz9Q528OxavX6FILmQz07Wce+/Sl92GyrrAYdYwv04ox/rU805ErA4vBZf2QCDsxfoCCQJH3vbD3knJRcbsbbveegM7ptgF85XimKDbbgx1rDSmfaAr/Sh1L2ZsL4PT1WFWw5S/w+2XKFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0gXN8nB/5lETM8FwURebwx9iMwYe2yFy//Iz5gwG4Y=;
 b=Bjemm4z4XZnSfwRDS0/1dzpKH1sAtymD4KOSfdTHkqD8DnmcRu2YeiloBYmHJXhrGnESbz4XbXzmC8QQzxJnJRt/aArDE5px8dWBO8EEiJAhGUpVtYRHuWuaDA6Z/otxLrQoXTdq4525dFzvCb8yypnwEEE2xGw4EsxRsn1SMi4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ2PR13MB6428.namprd13.prod.outlook.com (2603:10b6:a03:55a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 22:44:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 22:44:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
Thread-Topic: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock
 regression
Thread-Index: AQHZ6bx01N78VobVYEyXXSG5Nx3/F7AkIK8AgABNMACAArF1gIAAHKIAgATv1ICAAASKAA==
Date:   Mon, 25 Sep 2023 22:44:56 +0000
Message-ID: <ee6c49e086b5ee2393d2bfc375383527eff72af8.camel@hammerspace.com>
References: <20230917230551.30483-1-trondmy@kernel.org> ,
 <20230917230551.30483-2-trondmy@kernel.org>    ,
 <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>   ,
 <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>       ,
 <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>   ,
 <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
         <169568091982.19404.4821745630158429694@noble.neil.brown.name>
In-Reply-To: <169568091982.19404.4821745630158429694@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ2PR13MB6428:EE_
x-ms-office365-filtering-correlation-id: 2c3f629a-d523-4c29-cc69-08dbbe190a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qiv/xi3G9E8Z0KlrYoYgE3WUfPbhko8kXwo6D9lrKQ98F8E18agPPwZg1Di87ehwWOQHB07VTAA/h8hg2xTCn/Z4MvVrE+RfalnX9MzJ/F1KSYXZTc+r4nJcugcH4pcUajB5z/ImEBP3h6kR3cdsMYx+Av8qYv+dTd6XCmTBQDlgbmc3anQKJsbTmwUc1Iaiz3GCAkkD9zVPUXpDB1OrFdK7LPdk65dno5ozFLBKn+s1KJS3T9b0Ws08xqBc831d1bSlqG67Vqw20r9zzrm4R+Cn8gad0Ogv9CekZS7IIGeGgrx0egMQsdsCd5w0GkUnJpF5MjaKCmFOOjm2wIldv+8gYbjeE3wSezlF6anIQfWW2XS9APvXlmugva8WRYceMmX7TNFNMVnRo0Glq0XO4n/+YRmUJ4RM0xDnrK+CXo+6Z2FvCzxgKssjYm9iD3YkG1I6rAd0l9uBzZbNCQ4E7YxeA/u6/+trp1aO5IL/R+IsRbiZLbbdbAW6ic5uEaqe1LukQTWaqZ+VkCfLMSxDbAzO31jwRgEiygIEHz3u2J7tUrJjhMJ+1+Slu5uqwnIs+ZdJp4mQbijKNq+UqFOCT1B3s4mjk7RBKjsovDYGQUQMpwAH3qJxils4xgH2S0vJnrJ6QnfyHlBx01742h+Iqf6Y46ftheZWg4JFRU5K8co=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39840400004)(376002)(396003)(230922051799003)(186009)(451199024)(1800799009)(316002)(6916009)(41300700001)(54906003)(8936002)(76116006)(66556008)(66476007)(66446008)(66946007)(64756008)(6512007)(8676002)(2906002)(4326008)(478600001)(122000001)(26005)(71200400001)(83380400001)(5660300002)(6486002)(38070700005)(38100700002)(6506007)(53546011)(36756003)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEZxWnBVdkw1SCtKMWlodG5wZXEydXRCMHNmWEdPWGtLUFo5MTFCTUxrTGY0?=
 =?utf-8?B?RnZ2SHBvK0t5Q2h1QTFpbkVMaDNvZUlZNzNJQVMwMmQrVVBtQVIybHBkbXl2?=
 =?utf-8?B?bmQxQ2FySlBzT2o3WmFBd0FJbm5Vc0lOdGdqTDhvWmllUjBzMDBSMzFjSXVR?=
 =?utf-8?B?eWRsMVdyRmN0TGVsZVBiKzN1Q3dGbGlGRS9ITUg4OTJYTEZmMjByMkdpcXBN?=
 =?utf-8?B?Nm5MTVZSZDlRZ1FjUWhhMVliSThsVWJOaGlVNnFCYzlCUERnSXZ5OVhSUlBo?=
 =?utf-8?B?SUhyUEpldHVHb3Q2bTROaEt2UDlaTERQT2RPRURJb0dtY0IvUFNZQlZYc05X?=
 =?utf-8?B?TW9FTGd4TGNwa1dVaVdrTEF6azkyM3pTMGliWk9mTisyQWc2T1hnMk1QQVNn?=
 =?utf-8?B?cW9BQnVkVWhBT2M2M3ZBNE1wOTFrb2xKWjhHZ0YybHFwU0lmaEFsWXdqNlZX?=
 =?utf-8?B?QitpN1BlQnFwZkVDNzFuRUFncCtaTnc1bFdxZmxLdmF3TG5MVVdSUGEycUsv?=
 =?utf-8?B?SWkxdVFrQXJnYTF1alYrdHNXeW9hTmVSMGdhcCtyRHRoU1UyYlQwMGpOSlZH?=
 =?utf-8?B?cUVSbEdObzdlUkdpZGlxNU1aY25SM2RsWjRyQjVtbE5mejNqY3dZTFNYOGV0?=
 =?utf-8?B?Z0NZWXc0VGhRcUMvd1VZN3gxNi9zaE5Rc2QxUy9MZ2VzSUZmeXRLRnNtbTRx?=
 =?utf-8?B?OHU4WU5mRVl0VzB0S0g3emJpSlg1N2dtYkFzRWkrRlk1ZnJmaHVORFloZUFR?=
 =?utf-8?B?dGIxc29hajkwZEd2WllkOWFPTExzaGdrNXZmSHFmN2xpS0huWFRTcWZwQllF?=
 =?utf-8?B?bEkrcFlNYUx2ZUxrNmo0RGJHcGJNQUN5OEl4Q0hQclNMTjJrUGdqdHowdmto?=
 =?utf-8?B?a3VQV3ZrMGF3Q0dqbVl6eHV0R0RWeEEzQ2Z6VUVnUnAzbGhtK09peUwrYTZZ?=
 =?utf-8?B?OHZldDM3aHQ0N3BTb2tKRkxzRk1EanlWS0QxNWYzamdRWHkwTFgzZ2Roa0hV?=
 =?utf-8?B?dkZxOTNLZm5RdzdZNE5PalQ5Ly9ta2JXS2g5YXhBTFdoT0U3ZHBiZkd4U25j?=
 =?utf-8?B?R0dmQk03WlFqQ1YvSkxTZGI3TlM1ZDdqZ0ZqelB5MXp2azRISDRwZW5QNmVh?=
 =?utf-8?B?b3dzVFJuV1VJQ3lUdnZHNk04Ymh4UjhuNUo0VEZNUHp5dW1CeG4rb0ZVMm9h?=
 =?utf-8?B?NmUweXpVUmQrUVhzTXhDM2lUelZ0SkJoMk1ReDhPOC8wejVVTW10V3pQdjB3?=
 =?utf-8?B?UUdwbEhZbHVFN1FHTlp6bFdxVzhweHJHK2IyWVhYeWgvNGdvdnhGSmxFWGYy?=
 =?utf-8?B?YzdDazlLUkQva0RPL1UrSjFUWHlxY1YydDZ1SE0xa1JqZzRibkpGbWFMeGht?=
 =?utf-8?B?d0ZDMUhweFk2M0hMTi8wcGtMSXl3cmhCbERxSUZCU042cHdJQWpab0JWaEht?=
 =?utf-8?B?aURua2xRVFQ2MDA0L3BvZUo2Nm1YUkpPbTgvaEJxTEVZQTVtZk5OV3BNc0pm?=
 =?utf-8?B?NGwxc3RrcjB6Zld5c0N6NkxzYzB0aWZlRmZPMWo2L0hwMUJFWjlrZ2p6MUpR?=
 =?utf-8?B?SnZzUCswT0J3M3ZtQXhQbStKdFBRcmtFZ3hBR0ZwbTdLWWcyQ3Urb1U2K1c5?=
 =?utf-8?B?QUUzcXdVUy9YNms2K0tPQlRkaGFYRnpMRlExUmM2ZnVxb2piajZSekJZMHNW?=
 =?utf-8?B?RERBWmZyaGY4Z0xWcHNCWTBCS25iY3VWV043akpNY2wxQSsrK3NIcVFuU3pK?=
 =?utf-8?B?N1dxaWQ5aUJSR0pZK2tOQmZhQVdTNkFSZ2t6S3lYNlRaOUJ1TEhHVHJWT1NR?=
 =?utf-8?B?QktDZjFHa1ZIQTd2aGRCcVhiR2taMHVhUExMTFNHTHByMjEycjhWVlBIODVY?=
 =?utf-8?B?K2MvYUdkVzVDK2I3MWIrQW5yQkFxTzVCbVY1aXR3bXlmbzBUcTR5NS8ycXJH?=
 =?utf-8?B?dm9BOEJWbHpkWU0yQlpmTVkrNTNKWE9WRDFSRUtTQm1EREQ5Nk5hdjF5cTdQ?=
 =?utf-8?B?Y1BOZDNYR2VTQVNUcU9SNWllMkEvZmFLT0JEMjZadWxwcDArcHM5VFpLNUh2?=
 =?utf-8?B?Z0xNVXJyMzhuelJSYVFHVk0yRG9MU3g5Q2FIM2ZXTlAvUk5KK2s4NzRwTGdz?=
 =?utf-8?B?dUhJMFBQalBnTlV3VWpXc0ZVMkVGbTVURkozek1yb1lmMlEwd01VZGNISm40?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10AB8CA639A96B48A90BA7AB8CA85DD7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3f629a-d523-4c29-cc69-08dbbe190a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 22:44:56.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T55b89zyfyf3pmq4lvBr/g5x4rnz+/B8VgK6fqmf3Izdh6tugyDUz2qAfP2Vaw4FZUF66Y64cPFozA37TzNfMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDA4OjI4ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFNhdCwgMjMgU2VwIDIwMjMsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBGcmksIDIw
MjMtMDktMjIgYXQgMTM6MjIgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4g
T24gV2VkLCBTZXAgMjAsIDIwMjMgYXQgODoyN+KAr1BNIFRyb25kIE15a2xlYnVzdA0KPiA+ID4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdl
ZCwgMjAyMy0wOS0yMCBhdCAxNTozOCAtMDQwMCwgQW5uYSBTY2h1bWFrZXIgd3JvdGU6DQo+ID4g
PiA+ID4gSGkgVHJvbmQsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gU3VuLCBTZXAgMTcsIDIw
MjMgYXQgNzoxMuKAr1BNIDx0cm9uZG15QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20+DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IENvbW1pdCA0ZGM3M2M2Nzkx
MTQgcmVpbnRyb2R1Y2VzIHRoZSBkZWFkbG9jayB0aGF0IHdhcw0KPiA+ID4gPiA+ID4gZml4ZWQg
YnkNCj4gPiA+ID4gPiA+IGNvbW1pdA0KPiA+ID4gPiA+ID4gYWVhYmIzYzk2MTg2ICgiTkZTdjQ6
IEZpeCBhIE5GU3Y0IHN0YXRlIG1hbmFnZXIgZGVhZGxvY2siKQ0KPiA+ID4gPiA+ID4gYmVjYXVz
ZQ0KPiA+ID4gPiA+ID4gaXQNCj4gPiA+ID4gPiA+IHByZXZlbnRzIHRoZSBzZXR1cCBvZiBuZXcg
dGhyZWFkcyB0byBoYW5kbGUgcmVib290DQo+ID4gPiA+ID4gPiByZWNvdmVyeSwNCj4gPiA+ID4g
PiA+IHdoaWxlDQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+IG9sZGVyIHJlY292ZXJ5IHRo
cmVhZCBpcyBzdHVjayByZXR1cm5pbmcgZGVsZWdhdGlvbnMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gSSdtIHNlZWluZyBhIHBvc3NpYmxlIGRlYWRsb2NrIHdpdGggeGZzdGVzdHMgZ2VuZXJpYy80
NzIgb24NCj4gPiA+ID4gPiBORlMNCj4gPiA+ID4gPiB2NC54DQo+ID4gPiA+ID4gYWZ0ZXIgYXBw
bHlpbmcgdGhpcyBwYXRjaC4gVGhlIHRlc3QgaXRzZWxmIGNoZWNrcyBmb3IgdmFyaW91cw0KPiA+
ID4gPiA+IHN3YXBmaWxlDQo+ID4gPiA+ID4gZWRnZSBjYXNlcywgc28gaXQgc2VlbXMgbGlrZWx5
IHNvbWV0aGluZyBpcyBnb2luZyBvbiB0aGVyZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBMZXQg
bWUga25vdyBpZiB5b3UgbmVlZCBtb3JlIGluZm8NCj4gPiA+ID4gPiBBbm5hDQo+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiBEaWQgeW91IHR1cm4gb2ZmIGRlbGVnYXRpb25zIG9uIHlvdXIg
c2VydmVyPyBJZiB5b3UgZG9uJ3QsIHRoZW4NCj4gPiA+ID4gc3dhcA0KPiA+ID4gPiB3aWxsIGRl
YWRsb2NrIGl0c2VsZiB1bmRlciB2YXJpb3VzIHNjZW5hcmlvcy4NCj4gPiA+IA0KPiA+ID4gSXMg
dGhlcmUgZG9jdW1lbnRhdGlvbiBzb21ld2hlcmUgdGhhdCBzYXlzIHRoYXQgZGVsZWdhdGlvbnMg
bXVzdA0KPiA+ID4gYmUNCj4gPiA+IHR1cm5lZCBvZmYgb24gdGhlIHNlcnZlciBpZiBORlMgb3Zl
ciBzd2FwIGlzIGVuYWJsZWQ/DQo+ID4gDQo+ID4gSSB0aGluayB0aGUgcXVlc3Rpb24gaXMgbW9y
ZSBnZW5lcmFsbHkgIklzIHRoZXJlIGRvY3VtZW50YXRpb24gZm9yDQo+ID4gTkZTDQo+ID4gc3dh
cD8iDQo+IA0KPiBUaGUgbWFpbiBkaWZmZXJlbmNlIGJldHdlZW4gdXNpbmcgTkZTIGZvciBzd2Fw
IGFuZCBmb3IgcmVndWxhciBmaWxlDQo+IElPDQo+IGlzIGluIHRoZSBoYW5kbGluZyBvZiB3cml0
ZXMsIGFuZCBwYXJ0aWN1bGFybHkgaW4gdGhlIHN0eWxlIG9mIG1lbW9yeQ0KPiBhbGxvY2F0aW9u
IHRoYXQgaXMgc2FmZSB3aGlsZSBoYW5kbGluZyBhIHdyaXRlIHJlcXVlc3QgKG9yIGFueXRoaW5n
DQo+IHdoaWNoIG1pZ2h0IGJsb2NrIHNvbWUgd3JpdGUgcmVxdWVzdCwgZXRjKS4NCj4gDQo+IEZv
ciBidWZmZXJlZCBJTywgbWVtb3J5IGFsbG9jYXRpb25zIG11c3QgYmUgR0ZQX05PSU8gb3INCj4g
UEZfTUVNQUxMT0NfTk9JTy4NCj4gRm9yIHN3YXAtb3V0LCBtZW1vcnkgYWxsb2NhdGlvbnMgbXVz
dCBiZSBHRlBfTUVNQUxMT0Mgb3IgUEdfTUVNQUxMT0MuDQo+IA0KPiBUaGF0IGlzIHRoZSBwcmlt
YXJ5IGRpZmZlcmVuY2UgLSBhbGwgb3RoZXIgZGlmZmVyZW5jZXMgYXJlIG1pbm9yLsKgDQo+IFRo
aXMNCj4gZGlmZmVyZW5jZSBtaWdodCBqdXN0aWZ5IGRvY3VtZW50YXRpb24gc3VnZ2VzdGluZyB0
aGF0IA0KPiAvcHJvYy9zeXMvdm0vbWluX2ZyZWVfa2J5dGVzIGNvdWxkIHVzZWZ1bGx5IGJlIGlu
Y3JlYXNlZCwgYnV0IEkgZG9uJ3QNCj4gc2VlIHRoYXQgbW9yZSBpcyBuZWVkZWQuDQo+IA0KPiBU
aGUgTk9JTy9NRU1BTExPQyBkaXN0aW5jdGlvbiBpcyBwcm9wZXJseSBwbHVtYmVkIHRocm91Z2gg
bmZzLA0KPiBzdW5ycGMsDQo+IGFuZCBuZXR3b3JraW5nIGFuZCBhbGwgImp1c3Qgd29ya3MiLsKg
IFRoZSBwcm9ibGVtIGFyZWEgaXMgdGhhdA0KPiBrdGhyZWFkX2NyZWF0ZSgpIGRvZXNuJ3QgdGFr
ZSBhIGdmcGZsYWdzX3QgYXJndW1lbnQsIHNvIGl0IHVzZXMNCj4gR0ZQX0tFUk5FTCBhbGxvY2F0
aW9ucyB0byBjcmVhdGUgdGhlIG5ldyB0aHJlYWQuDQo+IA0KPiBUaGlzIG1lYW5zIHRoYXQgd2hl
biBhIHdyaXRlIGNhbm5vdCBwcm9jZWVkIHdpdGhvdXQgc3RhdGUgbWFuYWdlbWVudCwNCj4gYW5k
IHN0YXRlIG1hbmFnZW1lbnQgcmVxdWVzdHMgdGhhdCBhIHRocmVhZHMgYmUgc3RhcnRlZCwgdGhl
cmUgaXMgYQ0KPiByaXNrDQo+IG9mIG1lbW9yeSBhbGxvY2F0aW9uIGRlYWRsb2NrLg0KPiBJIGJl
bGlldmUgdGhlIHJpc2sgaXMgdGhlcmUgZXZlbiBmb3IgYnVmZmVyZWQgSU8sIGJ1dCBJJ20gbm90
IDEwMCUNCj4gY2VydGFpbiBhbmQgaW4gcHJhY3RpY2UgSSBkb24ndCB0aGluayBhIGRlYWRsb2Nr
IGhhcyBldmVyIGJlZW4NCj4gcmVwb3J0ZWQuDQo+IFdpdGggc3dhcC1vdXQgaXQgaXMgZmFpcmx5
IGVhc3kgdG8gdHJpZ2dlciBhIGRlYWRsb2NrIGlmIHRoZXJlIGlzDQo+IGhlYXZ5DQo+IHN3YXAt
b3V0IHRyYWZmaWMgd2hlbiBzdGF0ZSBtYW5hZ2VtZW50IGlzIG5lZWRlZC4NCj4gDQo+IFRoZSBj
b21tb24gcGF0dGVybiBpbiB0aGUga2VybmVsIHdoZW4gYSB0aHJlYWQgbWlnaHQgYmUgbmVlZGVk
IHRvDQo+IHN1cHBvcnQgd3JpdGVvdXQgaXMgdG8ga2VlcCB0aGUgdGhyZWFkIHJ1bm5pbmcgcGVy
bWFuZW50bHkgKHJhdGhlcg0KPiB0aGFuDQo+IHRvIGFkZCBhIGdmcGZsYWdzX3QgdG8ga3RocmVh
ZF9jcmVhdGUpLCBzbyB0aGF0IGlzIHdoYXQgSSBhZGRlZCB0bw0KPiB0aGUNCj4gbmZzdjQgc3Rh
dGUgbWFuYWdlci4NCj4gDQo+IEhvd2V2ZXIgdGhlIHN0YXRlIG1hbmFnZXIgdGhyZWFkIGhhcyBh
IHNlY29uZCB1c2UgLSByZXR1cm5pbmcNCj4gZGVsZWdhdGlvbnMuwqAgVGhpcyBzb21ldGltZXMg
bmVlZHMgdG8gcnVuIGNvbmN1cnJlbnRseSB3aXRoIHN0YXRlDQo+IG1hbmFnZW1lbnQsIHNvIG9u
ZSB0aHJlYWQgaXMgbm90IGVub3VnaC4NCj4gDQo+IFdoYXQgaXMgdGhhdCBjb250ZXh0IGZvciBk
ZWxlZ2F0aW9uIHJldHVybj/CoCBEb2VzIGl0IGV2ZXIgYmxvY2sNCj4gd3JpdGVzPyANCj4gSWYg
aXQgZG9lc24ndCwgd291bGQgaXQgbWFrZSBzZW5zZSB0byB1c2UgYSB3b3JrIHF1ZXVlIGZvciBy
ZXR1cm5pbmcNCj4gZGVsZWdhdGlvbnMgLSBtYXliZSBzeXN0ZW1fd3E/DQoNClRoZXNlIGFyZSBw
b3RlbnRpYWxseSBsb25nLWxpdmVkIHByb2Nlc3NlcyBiZWNhdXNlIHRoZXJlIG1heSBiZSBsb2Nr
DQpyZWNvdmVyeSBpbnZvbHZlZCwgYW5kIGJlY2F1c2Ugb2YgdGhlIGNvbmZsaWN0IHdpdGggc3Rh
dGUgcmVjb3ZlcnksIHNvDQppdCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIHB1dCB0aGVtIG9uIGEg
d29ya3F1ZXVlLg0KDQo+IA0KPiBJIHRoaW5rIGl0IG1pZ2h0IGJlIGJlc3QgdG8gaGF2ZSB0aGUg
bmZzdjQgc3RhdGUgbWFuYWdlciB0aHJlYWQNCj4gYWx3YXlzDQo+IGJlIHJ1bm5pbmcgd2hldGhl
ciBzd2FwIGlzIGVuYWJsZWQgb3Igbm90LsKgIEFzIEkgc2F5IEkgdGhpbmsgdGhlcmUgaXMNCj4g
YXQNCj4gbGVhc3QgYSB0aGVvcmV0aWNhbCByaXNrIG9mIGEgZGVhZGxvY2sgZXZlbiB3aXRob3V0
IHN3YXAsIGFuZCBoYXZpbmcNCj4gYQ0KPiBzbWFsbCB0ZXN0IG1hdHJpeCBpcyB1c3VhbGx5IGEg
Z29vZCB0aGluZy4NCj4gDQoNClRoYXQncyBhICJwcm92ZSBtZSB3cm9uZyIgYXJndW1lbnQuDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
