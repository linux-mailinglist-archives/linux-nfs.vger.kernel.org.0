Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC177286A8
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jun 2023 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjFHRxN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jun 2023 13:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbjFHRxM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jun 2023 13:53:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2119.outbound.protection.outlook.com [40.107.92.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD52D7B
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 10:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCrkCGffXD2kafnMWVnTkObkt+8dAeRnyl/FyX7K28BG9F/6QFwgGoGZNBL4g2mY816yKJ65muybpylMnhCjjxM/W48Aeq5qnR1sHrKR40arNRajM5CjtTX5xPQUp360XWsprMqAXuFVoLksWUdf8Cn4lMA54LNO4EqSBfTk7X9YXrtSkWOXlDFQkYenTDs7n3W6y88zmHTigaavOzR3EM6hOSyMrKhHRiQGizNasCzP4JokSfr4POmqodvfEwLJP8Ff7pUm7z4TIfjQPVcvbdnaggZlRk97ZMpRCvmdNx5tgDSkC5aF3zyeQRc4YW7ilDPLQOUyuUqgsfiPFp6Mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m54wSn60uFH7BTbXEOX0sOJfOlbuxmQZ/9qAwR8mkD0=;
 b=d6HGPWKPIjHB/qXGfCKuj72XDSv6WzI8OFgY1H1Plrq+65O9LNYULjGLNGAl96X2t5UnyEBE/LLZTw4JwLk2pmq07JJc9hzWAmASKbEfhfmPLnukl04n/+XH/q9Duq/VcuCMJyM0uOoY9zB9UnQ52EzYF3Xx1Rj0n2uV+Ycrq5m2RncM1Z89CjGGiylan4pU4MscpnW1vmghMYqFhj76Bk9UCT6Fv0cDuHUJgF3syWsValvo/juBMwJaHiw/Q2O1g2oaDlW6fjeCchUoGidJU/CJSkTuEqPXx4mQ+WnekwikCz+RzkHn+vaAM7xtknBTYUWTR0sAYMRnXYyhwts5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m54wSn60uFH7BTbXEOX0sOJfOlbuxmQZ/9qAwR8mkD0=;
 b=Y2ZDGukfrz1Vm3Kh3jvdttHpIKkUzO6kBarfsCVviOl/4tiwmqBFn8Az1pf1I0O78bki9JkAcuv4rUWqkYO/T12jSw1rej3rGUvBqM8NipXeng6vQKvetoOxthyhF95S4ZWb6Q/jfO9RdXCIf+0WwxZ4A2CO/HSgRy4cqKoBEJ4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6352.namprd13.prod.outlook.com (2603:10b6:408:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 17:53:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%6]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 17:53:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
Thread-Topic: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
Thread-Index: AQHZmhiBcPmt9J8+TUWQbzQkXHpsSa+BCOMAgAAkEgCAAAMCAA==
Date:   Thu, 8 Jun 2023 17:53:07 +0000
Message-ID: <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com>
References: <20230608144933.412664-1-tigran.mkrtchyan@desy.de>
         <cfde2b7b2a7f24f2652ce0bb82727cb0b810c758.camel@hammerspace.com>
         <AD6C85BF-50F9-42BB-83E8-16BCE03D3CF1@desy.de>
In-Reply-To: <AD6C85BF-50F9-42BB-83E8-16BCE03D3CF1@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6352:EE_
x-ms-office365-filtering-correlation-id: 3572f244-94a6-4edf-0af2-08db6849378f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZ+1ewJeuJBp03ZSbaA1iv7+PU+zw66T04Hrer/UhVUF1reRleZRpeRCwkVbi/ZceabWqUi4DCkEq6MW5uS8F2UEgZSHJU2ObSHgLt+VHIWqb7oDlW/EZRSw2dbVKABUja1d77P3/Te1YzDD7Fotujnj7GeQqm9+bMelqgdIQgcl0Cie+LaBqyO6NJHtvCs5U9fEbaSTa72JsrpAkTFOkL22QtSEUs6+/O3ci7+x3Fjc79fgxFrksa1lxKkSbx96lR/Rx1jcwfOY3N4JRIL3UOo0s/J+XqwtP3M8fA9P5lFBZOdTn5AM0ZA/Fha/TVve8WvczPhmF/8bX5gT1heYGkyq2BZ5ctwoUh64yCqF77IcvJH+mgD4P4UHBVUrIPby4B2RoBp9ZIGQPJNZJpP4u+7mksqVgZeLkWaWREZSJ9Xu3LkIZBZStFNHXXeRPjmrG0YpA/XeYbTXuqC7v4HEFy6ooveqzb0jYg6Hm0M0aOaeFnWVNxG1mUaRj86rgx0ZS/9qNOLI3/h3LzBf07yhX4cNmV3+taJu9hXZFjLntpOXW6KpyfLtnQcF/FmaAs8BzqVo07HnN6gw+ivbIfOb8Zh6ppzx07SBVFRxGRhIUkJm6OyzJGsk5wDHOWl9yjY0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39840400004)(396003)(136003)(346002)(451199021)(66476007)(76116006)(478600001)(66946007)(66446008)(4326008)(316002)(2906002)(64756008)(8936002)(41300700001)(8676002)(110136005)(66556008)(5660300002)(71200400001)(6486002)(6512007)(26005)(6506007)(2616005)(122000001)(38100700002)(186003)(36756003)(83380400001)(86362001)(15974865002)(38070700005)(18886075002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0Y5c2FMU29SeFJoQ25SNkRrODRuWE9FaDdBblVKelVGYUlCZVBJSVN3V1BW?=
 =?utf-8?B?bjZIZm5Tb3VPQU9KS2N5QW1mMmtHM01aSFhXVmRvR05LM3FzYVUzRXpZN1dJ?=
 =?utf-8?B?aml1RGlCNHQ1bW03VmFNTWRvcW5jY3dic0hGRlNMTzBma05YY1R3ejZYNXFy?=
 =?utf-8?B?N2FYQ2IycEg2c1FZblJTR2J4SHExMTI0dTJHOUpiby91N2VPRWZsdHAxY3JE?=
 =?utf-8?B?ZHhrbXFDQTdHZGVuQk9mZEl1UGJ1cFhNOEpIb2ovZThDM2NYWDVWK1J1dzhn?=
 =?utf-8?B?WlJaY29Ba1NxS2I4OHJlWmF5VDNJQWtGdlA5Uk4xZ2N4RERkTEcvOWRzaWJI?=
 =?utf-8?B?MVRHbFhoVm5kM1VNVG53ZEtNOWtpZmNkZHNKWjNzWmdScWh5YkgrNnhwNi8z?=
 =?utf-8?B?UWhrUTE0S2ZYNGgxVlJUWEJqem5BaXJxVFJUQm5tVVZaa1NCdVR6T3dIYUZi?=
 =?utf-8?B?d2FBT1hseDgzTnRpVWZsdlRrS3FPcEZuTHBOeGhuTDd1ZWI2dHdNU0c4eUt0?=
 =?utf-8?B?ck5RTzUrVDJ5d1djS2ZUMFdWT1VhWG5sbWRiNXhsNmtsaEpmZVdIT0dSYkpH?=
 =?utf-8?B?bmdmOUNuVnhmNEZxdUtMTlowTFpDTXhDY3pUTlR1dzdOYWVLVUhrcHlPdWNG?=
 =?utf-8?B?aE56K2ViSVNiOTQzZDZMaEZETGcvclo0aWl4SDBKWks0YlpCQVo3R080VnZv?=
 =?utf-8?B?Vjdjbk1UTUcrWjVhbDNJRXVJUFNMWHB3QVhBaVNtc25XaSsvM3RBaXd1UnlO?=
 =?utf-8?B?czh3d2tDZnRKY1EwZFNiTlpGejBRbWE4ZVd3c252UEFIV2lIK0pScHJTQzVh?=
 =?utf-8?B?QkZnejR1THE3djZHaU0yNGJLakhxUmtZeFNYOWJHT0ZVSldrUG15RExoam9v?=
 =?utf-8?B?RXIwSHpqWG9oZUZLSFQrK1QzTUpKTnVweFJxZ1l3NDRRZi9rVmM2Vmt5blJx?=
 =?utf-8?B?eDljQjFIMy9GWTVDdFdpazdwdjdCVU5TRVhwSFBxK1VDQXZUeVZlMElpcTY4?=
 =?utf-8?B?b0h2V2toNkt3bFc0TzM4bEZVQ09RV1BIckEzYTRWc0dnaGVnK2JpZXhjUmdK?=
 =?utf-8?B?eVJzOEFMdW1IQVIvY3dYd2FjMlpvVE1zSjZIUmxYd0xZVk9RSlUxNUhzK2JJ?=
 =?utf-8?B?Ym1FTWtYd3M5aFRqR2ZYdE8zSWJlK0RTL1ZGOFY2M29MckJsN3kyVmoySVBm?=
 =?utf-8?B?eElRTkVKNTRZWHNsMVBaa1Ntb0lIV2dTQ1JmRjBxWUtKVzF4dnhoaWlVRmhH?=
 =?utf-8?B?dmZZNVgxWjNoK0FSQ2VlK0IrZVZGdk5DN2xjQWFVL2VXaTFOek5iRXFuQ3hT?=
 =?utf-8?B?c3V4d01xQ3JnaXZHQlJRd2drNVNCZkdXNnZzbThlc2lQbGdVcHdVYmFHdVRt?=
 =?utf-8?B?SWtCM2VqNFdNaVNhSjJranYzWENMSDFwWHVaY0w1eDJYU1lSUTBnRllnU1U2?=
 =?utf-8?B?cnlNQm5IeldCOHB2VmkycFlrbXFzMUtjOW9VOTB3RFQwcXBFSXFadm1xcDJ5?=
 =?utf-8?B?UW9yMnVnVEZna1NLSm9oRkcvYnZHVG02eUhtNGsvTTJJclZpTExCcXZqQjRs?=
 =?utf-8?B?VjFTSWV5QzVPVnc3SHNOUTM3NkxSUUk3U3V4OFE1UlRYbFRVemFsTDhNTWw5?=
 =?utf-8?B?REVyRmh1d3YyQU5DenJZaU9RRzdjbDhSTEN4WVVHVTJKQ0wyMk90dS8yRVNx?=
 =?utf-8?B?UHZnUm1NSmRTamVoYTdtV1hBUWRrRXlrVGdKa3pkYzZjS0ttS1hST2ZHSVBK?=
 =?utf-8?B?Y2UzMWZlRzl1NVZ4ZlRNUDRSWFFQTHZQZ3RrV1QxMHhlazJxNzZQdFh4M1o2?=
 =?utf-8?B?RmlQT2pTalpNWEZ1SmdWRklVRWdKRXVvVzh2UGk5allGcXJ5TU81SGdoYnJU?=
 =?utf-8?B?ci90RDNQeWszbXh0UEFsM1FhaWg5b1pHcGtKY0tJYlR0MXJ6bmRoZ05UVWJ0?=
 =?utf-8?B?ZzdCVit1WWlDMWw1KytJbXYxMWZnV2FNYjd2eTdRdnNxUy9tdlJKYnhkditv?=
 =?utf-8?B?Q2FTQW90dDdrSHRJLzYvdm5LN1M2bnB1dVdQdlFXaU1STnNnMUhEYzYwZE5v?=
 =?utf-8?B?dVkvOWFDNW5zdUtpNEdvVktPcHdOUkYzR09taUU2ODZ6YStvbjlSaDd2TTkr?=
 =?utf-8?B?azJ3end6TlNOTS9WdVdTdG12MkZPR3BRMkFsVzFjTm41VjVWd2ZsRndTMXpt?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <739F1186BE694A4DBB24621F223A3FE6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3572f244-94a6-4edf-0af2-08db6849378f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 17:53:07.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cfq1RIJjMAZwgPW13BJndw9a1nVivOhg9JXrSivdxX+vS9/QruNQrLh9asCTNF+E60lM6p65vLsvGybBfvmWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6352
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTA4IGF0IDE5OjQyICswMjAwLCBUaWdyYW4gTWtydGNoeWFuIHdyb3Rl
Og0KPiBIaSBUcm9uZCwNCj4gDQo+IEkgd2lsbCBjaGVjayBhbmQgbGV0IHlvdSBrbm93LiBXaGF0
IHdlIHNlZSBpcyBFQUNDRVNTIG9uIGxheW91dGdldA0KPiByZXBvcnRlZCBhcyBFSU8gdG8gdGhl
IGFwcGxpY2F0aW9ucw0KPiANCg0KSWYgdGhpcyBpcyBmb3IgYSB3cml0ZSwgdGhlbiB0aGF0IG1p
Z2h0IGp1c3QgYmUNCm5mc19tYXBwaW5nX3NldF9lcnJvcigpLiBJbiBuZXdlciBrZXJuZWxzLCBp
dCB0cmllcyB0byBhdm9pZCBzZW5kaW5nDQplcnJvcnMgdGhhdCBhcmUgdW5leHBlY3RlZCBmb3Ig
c3RyaWN0bHkgUE9TSVggYXBwbGljYXRpb25zLg0KDQpDaGVlcnMNCiAgVHJvbmQNCg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IFRpZ3JhbiANCj4gDQo+IA0KPiBPbiBKdW5lIDgsIDIwMjMgNTozMzoxNiBQ
TSBHTVQrMDI6MDAsIFRyb25kIE15a2xlYnVzdA0KPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+
IHdyb3RlOg0KPiA+IEhpIFRpZ3JhbiwNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjMtMDYtMDggYXQg
MTY6NDkgKzAyMDAsIFRpZ3JhbiBNa3J0Y2h5YW4gd3JvdGU6DQo+ID4gPiB0aGUgbmZzNF9tYXBf
ZXJyb3JzIGZ1bmN0aW9uIGNvbnZlcnRzIE5GUyBzcGVjaWZpYyBlcnJvcnMgdG8NCj4gPiA+IHVz
ZXJsYW5kDQo+ID4gPiBlcnJvcnMuIEhvd2V2ZXIsIGl0IGlnbm9yZXMgTkZTNEVSUl9QRVJNIGFu
ZCBFUEVSTSwgd2hpY2ggdGhlbg0KPiA+ID4gZ2V0DQo+ID4gPiBtYXBwZWQgdG8gRUlPLg0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUaWdyYW4gTWtydGNoeWFuDQo+ID4gPiA8dGlncmFu
Lm1rcnRjaHlhbkBkZXN5LmRlPsKgZnMvbmZzL25mczRwcm9jLmMgfCAyICsrDQo+ID4gPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+IGluZGV4IGQzNjY1
MzkwYzRjYi4uNzk1MjA1ZmU0ZjMwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzL25mczRwcm9j
LmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiBAQCAtMTcxLDEyICsxNzEs
MTQgQEAgc3RhdGljIGludCBuZnM0X21hcF9lcnJvcnMoaW50IGVycikNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqBjYXNlIC1ORlM0RVJSX0xBWU9VVFRSWUxBVEVSOg0KPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoGNhc2UgLU5GUzRFUlJfUkVDQUxMQ09ORkxJQ1Q6DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRVJFTU9URUlPOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
Y2FzZSAtTkZTNEVSUl9QRVJNOg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJf
V1JPTkdTRUM6DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9XUk9OR19DUkVE
Og0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVQRVJNOw0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfQkFET1dORVI6DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9CQUROQU1FOg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGNh
c2UgLU5GUzRFUlJfQUNDRVNTOg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJf
U0hBUkVfREVOSUVEOg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gLUVBQ0NFUzsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIC1ORlM0RVJSX01JTk9SX1ZF
UlNfTUlTTUFUQ0g6DQo+ID4gPiANCj4gPiANCj4gPiBIbW0uLi4gQXJlbid0IGJvdGggdGhlc2Ug
Y2FzZXMgY292ZXJlZCBieSB0aGUgZXhjZXB0aW9uIGF0IHRoZSB0b3ANCj4gPiBvZg0KPiA+IHRo
ZSBmdW5jdGlvbj8NCj4gPiANCj4gPiBzdGF0aWMgaW50IG5mczRfbWFwX2Vycm9ycyhpbnQgZXJy
KQ0KPiA+IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGVyciA+PSAtMTAwMCkNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBlcnI7DQo+ID4gDQo+ID4gQXMgSSBy
ZWFkIGl0LCB0aGF0IHNob3VsZCBtZWFuIHRoYXQgZXJyID0gLU5GUzRFUlJfQUNDRVNTICg9IC0x
MykNCj4gPiBhbmQNCj4gPiBlcnIgPSAtTkZTNEVSUl9QRVJNICg9IC0xKSB3aWxsIGdldCByZXR1
cm5lZCB2ZXJiYXRpbS4NCj4gPiANCj4gPiBBcmUgeW91IHNlZWluZyB0aGVzZSBORlM0RVJSX0FD
Q0VTUyBhbmQgTkZTNEVSUl9QRVJNIGNhc2VzIGhpdHRpbmcNCj4gPiB0aGUNCj4gPiBkZWZhdWx0
OiBkcHJpbnRrKCkgd2hlbiB5b3UgdHVybiBpdCBvbj8NCj4gPiANCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QgDQpDVE8sIEhhbW1lcnNwYWNlIEluYyANCjE5MDAgUyBOb3Jmb2xrIFN0LCBTdWl0ZSAz
NTAgLSAjNDUgDQpTYW4gTWF0ZW8sIENBIDk0NDAzIA0K4oCLDQp3d3cuaGFtbWVyc3BhY2UuY29t
DQo=
