Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA35A2CE6
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiHZQ4d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHZQ4c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 12:56:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2106.outbound.protection.outlook.com [40.107.96.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406266134
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 09:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZC1HIIZRpOkQJWNikDqzh61FuqngPTCeco1Ic/etPBNZ9k6i4yWA3Kr2of986OW9GdU65jcyPWeg2OsyxhIDVTWxdXFA3ONcLn2g8++GapJaKePjJEBfQaxObghJiKlGNUsiGnSdTNyYCmAiYrfsijAXyGFwYEYU0t2Pebn37a8bAvJMLv+VbxsoGqOyBedhVmaTMP0JmlLFKH+gj4YgXtUlQT8looTJew00vQDTV+rdnmFrP0D2RQz8IadnS3+jRz3+7J5xRCVgKiwzK1olq4xjc1Y6GpcLPX33zOlUMExH00LA32zZj648CpJX1L773MAFg8yqwvJbZNjCOXBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwhEeJRckpXkVWWfXmdRsP5ow0pjC+vEVDnPtL/llL0=;
 b=m2BKo2pqOoCcmgWma9QDmBlCitBW3RpnkiyzNgHIg/gcFj9BekiKykW55nXL+JC4CSwCFUTyNYPLpVnrWXHj8D2SttXzo2zIfRJxkolNYB1dcM+IUpKzv2yJeLl4mQtYuyyhT8yk3GUnsZeka05L6rwbhHmqfQD0cPzznhUZKyPDxUAG87TcK7abdRYlgzttZAj79cyq6D4HXSUS2J9Ywid3bXS465lcRiaQWxulXyyLTy8JKmn6/pvma2NxZOnp0SBuk2y/BxUoXEUARqlWqJVA9LIDHrwSNZGatbgr+Bv8MNnE1rzwi5bRoTpiZ+8JyI4hffhvSEOoZ0SwHo859Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwhEeJRckpXkVWWfXmdRsP5ow0pjC+vEVDnPtL/llL0=;
 b=ClK/l/jdOl8p7eXQ3+QP0zrNJ2xnwgXouVhhcM+LFdKIP25yo6FKJWB0z2Jd73LSrPbY2XxtbkUQxoQAagCZpmvl0PZmHeCbB5CxdKexmtNhDoTdl9En/LxEwQ43i5nfW4DSg63AUICMe3JZ7wLGia5Us3SwaJuO82unZm4vCNw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1174.namprd13.prod.outlook.com (2603:10b6:903:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Fri, 26 Aug
 2022 16:56:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Fri, 26 Aug 2022
 16:56:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiAgAAQloCAAAOHAA==
Date:   Fri, 26 Aug 2022 16:56:28 +0000
Message-ID: <f5a2163d11f73e24c2106d43e72d0400d5a282b6.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
         <165274590805.17247.12823419181284113076@noble.neil.brown.name>
         <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
         <165274805538.17247.18045261877097040122@noble.neil.brown.name>
         <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
         <165274950799.17247.7605561502483278140@noble.neil.brown.name>
         <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
         <165275056203.17247.1826100963816464474@noble.neil.brown.name>
         <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
         <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
         <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
         <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>
In-Reply-To: <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04891f62-73a2-48cd-da99-08da8783eb60
x-ms-traffictypediagnostic: CY4PR13MB1174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWjdWukHpj7mpVKXZwEvnpW/xim/AgeYyiEqR84hEFaUM1NMih7Yihg019GQ5GJQB5zhNDCofTlezG7UFt/MOxVJhWH67zw1dijRSpHBwcsX+j80/vfE0XkFpckvxEzkHngMKJMFXCr654jRMu/JHu4UHqSNzE2GrX67hVqCKFlgISuAu+IW0onCOj3HBETgxEfkKO6SCFBHpz8/qIK0mY0QEO8n39ykseX7RxDiXXQOGvrZ4K2pcUgGpLh4M+ghtHEeEXeEkGEmDXVKTUIQjxuyLq53qummUAvC/G9sNWuCpE0yI5pMEYQL64yxQdOOau5x/5qPf2ohPEU32Eu6IAsrVe/GTpok8t1Sa76o+ECU56JqEZlNI3U/+OKyfMvK+fFFJ262AcA9ZJe+RmtjdUFZQvud4rQGgoW5hOVAWwdXrq8eQnDLz2TMsahl1ApYatcAr2mqFV4NgOWns1u/WH1cB1n2hzyHSsgBbVfs5VAONtYi+IG4BiWctJ5XFA+FMUvkR8ZbnBZvITLZQKxLZ34rOPWMWiAxgRTFAenuiQh+kfvJd/ciuZtexxqycrc8LobFWuu9PcL5F0a1X/2PclWmTLxD/FwXetLtVKoQZFc4EzljKQZKx1hjhGweIcnzYGeJ49zbZPUo9tFc5ZNc/t2c2EKVtRGZQyDxuPsl7yJXTK2NG1ZvM9wnYsSS4dnAgpaeR3lKv7RKmIgczqlDxCPGYtS4Whhz8WXs7OBhZf4GkeK3cB5N2XY1lYwlC+KO9xPIvi3FcFGdUDKwTCpJWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(376002)(136003)(366004)(346002)(396003)(86362001)(122000001)(478600001)(64756008)(38070700005)(66946007)(66446008)(6486002)(66556008)(8676002)(4326008)(76116006)(66476007)(2616005)(71200400001)(6512007)(26005)(53546011)(41300700001)(2906002)(6506007)(38100700002)(8936002)(36756003)(6916009)(5660300002)(186003)(54906003)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWRmVDhDc2V1dlFGVXpxTzFYdmV2VHdUTWo1VHJHc1dnQjEzcXFtQWNqZDZ3?=
 =?utf-8?B?Q01KN0FSRlBROWVIaGRINFhEem5Bd2VMejlleURPMXZkYm1waG5oalhrTEN1?=
 =?utf-8?B?TG1YQ2k1Y3VHOGNmVHdBWUZ4dXhBaklObHE5bTFDWnFBWUU5M2JGYUxuNGFj?=
 =?utf-8?B?OHpYUU5DTG92T3ZBY0ZqTmUweXg5WmJlSUxESDA3WFBITDJrSWU5RFR2SnRn?=
 =?utf-8?B?YzFlZnJSOGV3NVBDQTV0eHdrWXIwTFl3L1NnbjdxRldKNHdtSk9haS9ZL3lX?=
 =?utf-8?B?cUVMbm1BbVpMMWF2UjJHK0ExUTdXQ1N0TU54Z3l1MUdXQ3FnNnh0bmw5dUg4?=
 =?utf-8?B?N3BMc1RNZFY3VStsTFczVDJmYzlJb25mWkZlbjZLbCszZnQ5NEtGbjNONXM5?=
 =?utf-8?B?RDF2a3FjWjRxRk5GT0F5eTNNby8wWitsWlI2QVM2ZTA3eGxETVNFRlVpb1Bv?=
 =?utf-8?B?MXczRUtGbEdYY3k2SFZOVTc3aGlCa1VZamhJUm1TZkh0MFAybDJRVExnNVJo?=
 =?utf-8?B?ZEZNZHV4YTZlSXRsYitUNmRDUlhVSVFNTEk5NHl1U01JMm1DNlorc0xaV1RH?=
 =?utf-8?B?dldZczFJWWR6TDU5VnNCNDRaMTc2U0xrL3YvL0luU1crVzFxL0NOVnlsWkY5?=
 =?utf-8?B?aGE1TVk2aHR5aENuYjlFbmQ2c0dYWWRSclNDOFhVQkpidzhOZ0RxTzE5MU12?=
 =?utf-8?B?YkIwTDMyemJnYWFLenl5eVU4aHNCNVJaei8rN0dFMHN2TW82ZDVOVVE2a0d3?=
 =?utf-8?B?SnFIL0dpNWNEKzVua1NQL090ZElxb254NGV5eVhMbHA0UGd6cytsbDVPTjhm?=
 =?utf-8?B?NC91VEcrb0tzd1FteS9XR1luNGJHanFXK1pXMHZkdEI2VnRIekV6dEdodTBX?=
 =?utf-8?B?SyszTGRvYnlPNWpGWEVNUkhUZEg0VENGM3dUQXJqZ1ZCL1czeTA4ZkMyRlBM?=
 =?utf-8?B?SGMxd2FpaHNKTkp4ZWdNWTdlZjRDSWxtOVdGMk0zZTFDS1c4VEpQWHZwWW9Z?=
 =?utf-8?B?dmNTTW12N25aY0FnUVFORU9iMktEeXRsTzg2M2FIdisxZ0pwVDZoMEZ2dXZx?=
 =?utf-8?B?Y3N6N1prWWM0OUtqWUxjUUpuMGp3N2NLT3o0Q1oxaEIvRkx3Qm96TzZRbXpi?=
 =?utf-8?B?OWVHWW4zQWl2TEh4d3F0Wi9VZCs5dW9xeHJMVDZpcU5DdE55ay9uaEc1cm1L?=
 =?utf-8?B?WUtQamZhYzJXc0VQeFNNeWJxZUxmWTdwQVBBd0gzeUZRc1A2Y04vc3p1M0Nl?=
 =?utf-8?B?OSsxL2NmaUZKdVNmaytaVlNlY1krcHR2K0laUXFuVGNrR0R3WDBtdDRpazds?=
 =?utf-8?B?ODlHVjBCM01XQzgzbjh4Yzd4bCtBVk1HaGtDdWtTZUtSRHgvc29uNVROamNH?=
 =?utf-8?B?ZnRja2d4dWl2Z2orY21tS0d5MGVSNStHOUU3cnExbTFmY2pXUjZNZjUybE04?=
 =?utf-8?B?TTgyNVpValVLWTFrSFFWWlJIWWJYLzFkZnNEemJUUi9CUkxxa0ttT3Q4TlZS?=
 =?utf-8?B?dTNEclNadmRkYnp2UjluUlVVRVFMbk03UDRFVXlhSlhVdnRTTk9SWSthWkYy?=
 =?utf-8?B?TU42QWFDMDhyZjhOUTRJcGU3aWdrRXE3NnJjb096RkdJUGZJQ0RIT2N0SUNS?=
 =?utf-8?B?TU96c0NqZDltbWw1Zi9LRGYzTEFOUHhjWkV6SE8zd0dTcTNpcFY5RTdEQUVM?=
 =?utf-8?B?azllT3FMUmUrMjBESlY3SHh2Nld3QXZtWkQzOXM0d01qWGFDVEYrRS9zUmIy?=
 =?utf-8?B?NFlYWGk1QW0vNFowVlF6WDFyaitqbXFEaXRXMS9BSXEwVm1rL0JuMVdKeE5s?=
 =?utf-8?B?NFBQTFFaL21ocXZSK3QrTTgvVTdvWnMvR21jR1FUbVZzV2RlZWhyMVBDaE9M?=
 =?utf-8?B?OHZiN2FtUkZrUVVFdUVaNm5WZEFzZ1NENlRLS0VZKzVxeE5QN0VtWnM2NVFV?=
 =?utf-8?B?dVZXMjh0dGwvcTArQXdQVnB0SDdOZ1Q4M09id3lUOWlTTldvZy9mM0Z4NGdk?=
 =?utf-8?B?WFVZMmdzZUJIaGFYVGRBYWowTlArWTlYaHF6dXV6V29wR1dTVG1kVDZMazFn?=
 =?utf-8?B?TkUzVmhVYXRpQjVBZkcvNlhTYnJYL1JUa1ptbkRLL3MwWmlFblNGSG9ENzI4?=
 =?utf-8?B?K2YzbUpHUGo1OWIvU01oRVZ1OGpRRnNMK25SMk9WeGVxZ01uR0lMdkJPWmRF?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA15646C3601D845A16426B92698970E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04891f62-73a2-48cd-da99-08da8783eb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 16:56:28.5492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ztiheXI5ztReNF+HqslcvQGuF5tBX/9rNyvUmHldbapJOeShv6opsT/d8h7mr/Gq8T4haHNgmDE6TEdPKYsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDEyOjQzIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNiBBdWcgMjAyMiwgYXQgMTE6NDQsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gRnJpLCAyMDIyLTA4LTI2IGF0IDEwOjU5IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMTYgTWF5IDIwMjIsIGF0IDIxOjM2LCBUcm9uZCBNeWts
ZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IFNvIHVudGlsIHlvdSBoYXZlIGEgZGlmZmVyZW50IHNvbHV0
aW9uIHRoYXQgZG9lc24ndCBpbXBhY3QgdGhlDQo+ID4gPiA+IGNsaWVudCdzDQo+ID4gPiA+IGFi
aWxpdHkgdG8gY2FjaGUgcGVybWlzc2lvbnMsIHRoZW4gdGhlIGFuc3dlciBpcyBnb2luZyB0byBi
ZQ0KPiA+ID4gPiAibm8iDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHRoZXNlIHBhdGNoZXMuDQo+ID4g
PiANCj4gPiA+IEhpIFRyb25kLA0KPiA+ID4gDQo+ID4gPiBXZSBoYXZlIHNvbWUgZm9sa3MgbmVn
YXRpdmVseSBpbXBhY3RlZCBieSB0aGlzIGlzc3VlIGFzIHdlbGwuwqANCj4gPiA+IEFyZQ0KPiA+
ID4geW91DQo+ID4gPiB3aWxsaW5nIHRvIGNvbnNpZGVyIHRoaXMgdmlhIGEgbW91bnQgb3B0aW9u
Pw0KPiA+ID4gDQo+ID4gPiBCZW4NCj4gPiA+IA0KPiA+IA0KPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0
aGF0IGFuc3dlcnMgbXkgY29uY2Vybi4NCj4gDQo+IEEgbW91bnQgb3B0aW9uIHdvdWxkIG5lZWQg
dG8gYmUgc2V0IHRvIGVuYWJsZSB0aGUgYmVoYXZpb3IsIHNvIHRoZQ0KPiBjYXNlcw0KPiB5b3Un
cmUgY29uY2VybmVkIGFib3V0IHdvdWxkIGJlIHVuYWZmZWN0ZWQuDQo+IA0KPiA+IEknZCByYXRo
ZXIgc2VlIHVzIHNldCB1cCBhbiBleHBsaWNpdCB0cmlnZ2VyIG1lY2hhbmlzbS4gSXQgZG9lc24n
dA0KPiA+IGhhdmUNCj4gPiB0byBiZSBwYXJ0aWN1bGFybHkgc29waGlzdGljYXRlZC4gSSBjYW4g
aW1hZ2luZSBqdXN0IGhhdmluZyBhDQo+ID4gZ2xvYmFsLA0KPiA+IG9yIG1vcmUgbGlrZWx5IGEg
cGVyLWNvbnRhaW5lciwgY29va2llIHRoYXQgaGFzIGEgY29udHJvbCBtZWNoYW5pc20NCj4gPiBp
bg0KPiA+IC9zeXMvZnMvbmZzLCBhbmQgdGhhdCBjYW4gYmUgdXNlZCB0byBvcmRlciBhbGwgdGhl
IGlub2RlcyB0bw0KPiA+IGludmFsaWRhdGUNCj4gPiB0aGVpciBwZXJtaXNzaW9ucyBjYWNoZXMg
d2hlbiB5b3UgYmVsaWV2ZSB0aGVyZSBpcyBhIG5lZWQgdG8gZG8gc28uDQo+ID4gDQo+ID4gaS5l
LiB5b3UgY2FjaGUgdGhlIHZhbHVlIG9mIHRoZSBnbG9iYWwgY29va2llIGluIHRoZSBpbm9kZSwg
YW5kIGlmDQo+ID4geW91DQo+ID4gbm90aWNlIGEgY2hhbmdlLCB0aGVuIHRoYXQncyB0aGUgc2ln
bmFsIHRoYXQgeW91IG5lZWQgdG8gaW52YWxpZGF0ZQ0KPiA+IHRoZQ0KPiA+IHBlcm1pc3Npb25z
IGNhY2hlIGJlZm9yZSB1cGRhdGluZyB0aGUgY2FjaGVkIHZhbHVlIG9mIHRoZSBjb29raWUuDQo+
ID4gDQo+ID4gVGhhdCB3YXksIHlvdSBoYXZlIGEgbWVjaGFuaXNtIHRoYXQgc2VydmVzIGFsbCBw
dXJwb3NlczogaXQgY2FuIGRvDQo+ID4gYW4NCj4gPiBpbW1lZGlhdGUgb25lLXRpbWUgb25seSBm
bHVzaCwgb3IgeW91IGNhbiBzZXQgdXAgYSB1c2Vyc3BhY2Ugam9iDQo+ID4gdGhhdA0KPiA+IGlz
c3VlcyBhIGdsb2JhbCBmbHVzaCBvbmNlIGV2ZXJ5IHNvIG9mdGVuLCBlLmcuIHVzaW5nIGEgY3Jv
biBqb2IuDQo+IA0KPiBXZSBoYWQgdGhlIGV2ZXJ5LXNvLW9mdGVuIGZsdXNoIHBlci1pbm9kZSBi
ZWZvcmUgNTdiNjkxODE5ZWUyLg0KPiANCj4gSGVyZSdzIHRoZSBzZXR1cCBpbiBwbGF5OiB0aGVy
ZSdzIGEgbGFyZ2UgbnVtYmVyIG9mIHYzIGNsaWVudHMgYW5kDQo+IHVzZXJzLA0KPiBhbmQgbWFu
eSB0aW1lcyBlYWNoIGRheSBncm91cCBtZW1iZXJzaGlwIGNoYW5nZXMgb2NjdXIgd2hpY2ggZWl0
aGVyDQo+IHJlc3RyaWN0DQo+IG9yIGdyYW50IGFjY2VzcyB0byBwYXJ0cyBvZiB0aGUgbmFtZXNw
YWNlLg0KPiANCj4gVGhlIGZlZWRiYWNrIEknbSBnZXR0aW5nIGlzIHRoYXQgaXQgd2lsbCBiZSBh
IGxvdCBvZiBleHRyYQ0KPiBvcmNoZXN0cmF0aW9uIHRvDQo+IGhhdmUgdG8gdHJpZ2dlciBzb21l
dGhpbmcgb24gZWFjaCBjbGllbnQgd2hlbiB0aGUgZ3JvdXAgbWVtYmVyc2hpcHMNCj4gY2hhbmdl
Lg0KPiBUaGUgZGVzaXJlZCBiZWhhdmlvciB3YXMgYXMgYmVmb3JlIDU3YjY5MTgxOWVlMjogdGhl
IGFjY2VzcyBjYWNoZQ0KPiBleHBpcmVkDQo+IHdpdGggdGhlIGF0dHJpYnV0ZSB0aW1lb3V0LsKg
IEl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBhIG1vdW50IG9wdGlvbg0KPiB0aGF0DQo+IGNvdWxk
IHJlc3RvcmUgdGhlIGFjY2VzcyBjYWNoZSBiZWhhdmlvciBhcyBpdCB3YXMgYmVmb3JlDQo+IDU3
YjY5MTgxOWVlMi4NCj4gDQoNClVzZXIgZ3JvdXAgbWVtYmVyc2hpcCBpcyBub3QgYSBwZXItbW91
bnQgdGhpbmcuIEl0J3MgYSBnbG9iYWwgdGhpbmcuDQoNCkFzIEkgc2FpZCwgd2hhdCBJJ20gcHJv
cG9zaW5nIGRvZXMgYWxsb3cgeW91IHRvIHNldCB1cCBhIGNyb24gam9iIHRoYXQNCmZsdXNoZXMg
eW91ciBjYWNoZSBvbiBhIHJlZ3VsYXIgYmFzaXMuIFRoZXJlIGlzIGFic29sdXRlbHkgbm8gZXh0
cmENCnZhbHVlIHdoYXRzb2V2ZXIgcHJvdmlkZWQgYnkgbW92aW5nIHRoYXQgaW50byB0aGUga2Vy
bmVsIG9uIGEgcGVyLW1vdW50DQpiYXNpcy4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
