Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6353A063F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhFHVnB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:43:01 -0400
Received: from mail-mw2nam10on2111.outbound.protection.outlook.com ([40.107.94.111]:32736
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234277AbhFHVm7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 17:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2RpHb6QheuNHc9gGUtxlratG3vQvsQOUl1IP/Fef5bDTpdOAUMlW/rbAIFGkpdOljP25WcvUP/iMnGQ4wzq5r6rBP6C7wT101TB5M1A3GgJuuK6AOLhA49a05UtBr6T+9PgI/8pnW4MOj2eEVZCV/Ev7VDzT4EM3/RJ6zWyWRKDSHpaAgs2U77iOuYpLcb241KVXsDIMP9/1r0bjzgkChmBHbLTlXWM5Q4pfpyr3yUVW+0MQD2GcQBuLozf/cCiBryI6UfM7BzXsjdAuWhCqMI76t6hcFg9g89Lof5rFC4zxZYsVDU2TNbh9LuYWPUv2BfGkMqoS9BOxm//9i2ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hfExvErVZ1+x+ZWm8LY5Ok+sqchfPG8Gvn5EJNJh+o=;
 b=RHIFlgWpYZ+fydi3oeG8kNZ81UWLwG5KXHz9qYp0TA7Y0so8CAvJzcf93TS9aaok7VRWRPcnynZH9Jo1lqEAUFx0wT/S44Rx3O2AmIiMyDv4lqi/MsrQ43Ss2J6CybiS9Z0yLZn0XzUJUwTxrTl6D6vcwH/ym49410yOkyqW9zaq9/g8jYWpg5iF8+u6Dev73LFFVBcUmXGFMBqs11JxZs3BiAzyb//SFTG6mVr1yecpqpTggrUoXcCOofVXi57XvdS2qJawFLWPGvqI+07WDyFolDW1Zk1okovUNWl/icdQYowl4muVBUOMMUT+n4TDXDWG5m2dqhEywzfb4GV2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hfExvErVZ1+x+ZWm8LY5Ok+sqchfPG8Gvn5EJNJh+o=;
 b=b7jc2z2dsmtOdP+gD77fsfnTIdKDkQlbP0dIYryJp9XY91kAHhto5Zk4XlSM1MOtVQF2Fyz+/pIt4rId2n1isHhUu+CaLQJHuUWAkEaUgfW1oHChLu7/OF7kG0wv3v+hu8ZV0kJdjCjTFciyqbnpMQDYzN1shurZghpjt4ykd1k=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3561.namprd13.prod.outlook.com (2603:10b6:5:149::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12; Tue, 8 Jun
 2021 21:41:04 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 21:41:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAAA5OAgAAB/QCAAAE6AIAAArsA
Date:   Tue, 8 Jun 2021 21:41:04 +0000
Message-ID: <e136a646089d862c476b555ea6b009cf19f5fadd.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
         <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
         <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
         <CAN-5tyHsVprR9_0Q98X8Dd5zYgaX79V7R76KPSzDwQFMYL2qcA@mail.gmail.com>
In-Reply-To: <CAN-5tyHsVprR9_0Q98X8Dd5zYgaX79V7R76KPSzDwQFMYL2qcA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ff8ea63-1a32-4ee5-1d64-08d92ac61e0a
x-ms-traffictypediagnostic: DM6PR13MB3561:
x-microsoft-antispam-prvs: <DM6PR13MB3561DC6DDDF35B13E8C74F2BB8379@DM6PR13MB3561.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m493UZJkwm8Mzf8jS5l69ptl9cXmikzP0y0uzKB7+5HNJUlj4ikhxEHHSqWH1foEX+V8f63NQ3VUrfr+Qt9x4YCq5DtmcmtzkjJ1K+vJu+Moj2ZFegAzBpz03b94BilDIdSrVqLagPXmyAEyswJvZ4sGqoFLaiIWvUQOD1q/L8yQWkskE6ztanIfTnPauu/TcAi1gNG0mvANGPk5qWvKGq247V1Er6i/eBQNC2XM9j6iNw1IkkwD5XhDsywaqLxMyP1M6/OgIJfANYC4LN18tIlhNYEnCqeobscs3JbkUQmrk7j+NoEBRf1gbtP5EVimRc1C/zBxZchc1d2OS/EJrtTz0KG+9EBZIG7HVlWUsJfQ62hvP71jfHHzamCk6m7tzkVd4sF4rIBmb3m1feggY7Z+fmmKv5kXVGEXUsTBfhOnsItOPHeZU5MVlsqh7gc2RpNXU67DaNPHfFmZFLffwm8T5LRPpNvou6ervPP0L7GaoKU1SouF8+wbBL33J3j4KvmA0EauZV1wQv3zpWZ8lJKqQBX5BBlatlIGKHb8v9DpJJB83zLVf2ylk8ds9NwvtOQaQFbQdfVCWnrQeTq+AM2+eVpuW3WVNFcwAukwnVo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39830400003)(86362001)(122000001)(2906002)(2616005)(38100700002)(186003)(4326008)(478600001)(6506007)(83380400001)(66446008)(71200400001)(6512007)(66556008)(64756008)(76116006)(8936002)(66946007)(91956017)(53546011)(66476007)(8676002)(36756003)(5660300002)(6486002)(26005)(316002)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGthYWtHWEQ1NzVyNG9IbnBxQ053SWpRUEdQcXcwS2ZCRGxmWVM4aExleWVE?=
 =?utf-8?B?aHFWa2E2OGp4TTZxbGhFN01ka3VDZzJLMjI2OUFHY3E2OFczMCtXSUFIVHBI?=
 =?utf-8?B?ZERqb1o4Z3lnNWdjcS9EMWpyVENKVU55eWhGdXdWK1hyalJGbjM2bmd1aVRm?=
 =?utf-8?B?elVqcktBNjkrcVc2aFk4dVlIUm14WHVMVUdOU1p4cDdmYUpOanR0RGppWmVj?=
 =?utf-8?B?dDdWWngxaktZTDNpL3FtcEZDcmFaZmh1OEUvNEpUdHZrcVpBcWs1WjlsTTJ1?=
 =?utf-8?B?TzZ1eGRORTkwWWtZUGlWTlBlYTBHb3FWanNVajBJMTlCMjM4R1ZudHE4dUtQ?=
 =?utf-8?B?NUsraWFISHlBblplWnhQaVZURXBtYkM0TlhqTGtmSjZXeHBmUzBQTERERE1G?=
 =?utf-8?B?SUQzdEFVV0pTWDBqc21xWGpKOVlkMlc0TnVXSXl6V0JtcUxNeUk5ZGc2aThT?=
 =?utf-8?B?VHFWUVFaS2Z1TEZ1ZmhVbmdoZkEwNU5KRWdmRzhLcTRzZVAyVDhZYThvWm0v?=
 =?utf-8?B?YjQ1MjVlWlpFTlh5dDVKNXVDSi9DZGxIR2lKNUUrVVgzZlJnWjM0UmVLSG11?=
 =?utf-8?B?NmcvZktjZ3lVMHA3aTFreFp2QlBuZmdZempBSFNIRUJaZDRldm1BeERYeVVQ?=
 =?utf-8?B?bk93Ums5Q1ZuM1UvZ00wU3FsMFVmV2tLY0ZUbW9EOUk2UHdsVFlnb2xQaTQv?=
 =?utf-8?B?dThsNUh5L0hHYzJjWmNzcXExVWsvUTZmQlFzZERsVEVsZEdFWUZXYWFIK0Fp?=
 =?utf-8?B?MitFeGIzOVFiamZSeEFFclE4V3dKOUY2d09ZMEgrRGpPQ2g5VlFLWTRIZWRC?=
 =?utf-8?B?SUtrK1Q4NmRBMEZVRHRqaThheHA4RDZHZVFiaGJ3dTJlRG85ZXA2M0hHbmw1?=
 =?utf-8?B?TitaSFpIcy96bENiRU1OQ29OeWRheDJQWGZFNEt2NGpkMVVjV2dacHpZYnpB?=
 =?utf-8?B?eWtLbkFOeDY4MzFmOEJpYTdtbmZhcEFZeXB1OHJkRTNEYndTQ0xvaDdudmlx?=
 =?utf-8?B?SXFOZWg5REh4NVJ0bWFpMWFWVU1KOEFJYTZWN3d3MWJsZmtHRWoxd3gySU9T?=
 =?utf-8?B?RncyblF4RUpTRmowL3AzQ1ZBa25mdnY0dCsxUk9NOXBPa25Nemd6KzhEMHB4?=
 =?utf-8?B?TlBVc1U3ZEgxUEdOWG5vSFEwZGZlWXphWGJXL1FmMC9NdW50a2ZwZkRqaFpK?=
 =?utf-8?B?MWNWS2ZUV0lsSVdOdmVMVlZBanhoMVV3UkdQdlgyYlFVSlJCa2FNdDYwZHp0?=
 =?utf-8?B?RWFEMXk3ajdmTGd6VjJZNGNxa1VFSXIwVk1aRHlMNTlDK1U2eDQwa3owYzJh?=
 =?utf-8?B?blB4U3JSc2xnWDlmRHp2RHNwQWJmbjdMb2wzVkErT0NjVWliT2plYURmMmFo?=
 =?utf-8?B?RitPWjlOTWJ6RVJwa2dxRFZ5eWI5VXlUL2ZKazBhZGJiUmJ6RDgrL0t6YmQ1?=
 =?utf-8?B?Nm1JR1g1M0crdm1iWEFRWnpBTFZvd084TTJ2dUFGQ0RIZ1hIV2x0VVZNWWRq?=
 =?utf-8?B?VnRQanZsSXpTRDVzcmtUSW5iRXB0KzBVSG5FMmN1RWJMSzMzcDdmVk55dk1l?=
 =?utf-8?B?NnpFZXVESXBlUm5CU1M2ZmQzc3pMbWJrSm9vOHpzMzhoLysyMlM0ZTd4MnJQ?=
 =?utf-8?B?eWRHSDc5ZXdsWDdESnpIREhEZVV2eHVWNGNqc0ZvR1ljYkFIK1UyNHRMUE9u?=
 =?utf-8?B?cEN2NDNSSUMwQWZLSExQQ0tybXdVRlR0Y3lMeURYQ0NvTFRRRy9nYTlDbldx?=
 =?utf-8?Q?yL+vmuKisxOlLXtlqOnw3Fv+O7lGXix0gTKPlLK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA7801A99AEAAA47B6231D32416E281B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff8ea63-1a32-4ee5-1d64-08d92ac61e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 21:41:04.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khUFOuRVMRjzkUQ6rHEHF4NUXmFl6rEtuXPNQKIXEcM2fkNg2TTrCIOjMmkspeNb8O3QZsYNKkYsBa80hnB3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3561
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDE3OjMwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBKdW4gOCwgMjAyMSBhdCA1OjI2IFBNIFRyb25kIE15a2xlYnVzdCA8IA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDIx
LTA2LTA4IGF0IDIxOjE5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIDIwMjEtMDYtMDggYXQgMjE6MDYgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4g
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIEp1biA4LCAyMDIxLCBhdCA0OjU2IFBNLCBP
bGdhIEtvcm5pZXZza2FpYSA8DQo+ID4gPiA+ID4gb2xnYS5rb3JuaWV2c2thaWFAZ21haWwuY29t
PiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBUdWUsIEp1biA4LCAyMDIxIGF0IDQ6
NDEgUE0gQ2h1Y2sgTGV2ZXIgSUlJIDwNCj4gPiA+ID4gPiBjaHVjay5sZXZlckBvcmFjbGUuY29t
PiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gT24gSnVuIDgsIDIwMjEsIGF0IDI6NDUgUE0sIE9sZ2EgS29ybmlldnNrYWlhIDwN
Cj4gPiA+ID4gPiA+ID4gb2xnYS5rb3JuaWV2c2thaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBu
ZXRhcHAuY29tPg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gQWZ0ZXIgdHJ1bmtpbmcg
aXMgZGlzY292ZXJlZCBpbg0KPiA+ID4gPiA+ID4gPiBuZnM0X2Rpc2NvdmVyX3NlcnZlcl90cnVu
a2luZygpLA0KPiA+ID4gPiA+ID4gPiBhZGQgdGhlIHRyYW5zcG9ydCB0byB0aGUgb2xkIGNsaWVu
dCBzdHJ1Y3R1cmUgYmVmb3JlDQo+ID4gPiA+ID4gPiA+IGRlc3Ryb3lpbmcNCj4gPiA+ID4gPiA+
ID4gdGhlIG5ldyBjbGllbnQgc3RydWN0dXJlIChhbG9uZyB3aXRoIGl0cyB0cmFuc3BvcnQpLg0K
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2
c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4g
PiBmcy9uZnMvbmZzNGNsaWVudC5jIHwgNDANCj4gPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gPiAxIGZpbGUgY2hhbmdlZCwg
NDAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2ZzL25mcy9uZnM0Y2xpZW50LmMgYi9mcy9uZnMvbmZzNGNsaWVudC5jDQo+ID4gPiA+ID4g
PiA+IGluZGV4IDQyNzE5Mzg0ZTI1Zi4uOTg0Yzg1MTg0NGQ4IDEwMDY0NA0KPiA+ID4gPiA+ID4g
PiAtLS0gYS9mcy9uZnMvbmZzNGNsaWVudC5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2ZzL25mcy9u
ZnM0Y2xpZW50LmMNCj4gPiA+ID4gPiA+ID4gQEAgLTM2MSw2ICszNjEsNDQgQEAgc3RhdGljIGlu
dA0KPiA+ID4gPiA+ID4gPiBuZnM0X2luaXRfY2xpZW50X21pbm9yX3ZlcnNpb24oc3RydWN0IG5m
c19jbGllbnQgKmNscCkNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqAgcmV0dXJuIG5mczRfaW5pdF9j
YWxsYmFjayhjbHApOw0KPiA+ID4gPiA+ID4gPiB9DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiArc3RhdGljIHZvaWQgbmZzNF9hZGRfdHJ1bmsoc3RydWN0IG5mc19jbGllbnQgKmNscCwN
Cj4gPiA+ID4gPiA+ID4gc3RydWN0DQo+ID4gPiA+ID4gPiA+IG5mc19jbGllbnQgKm9sZCkNCj4g
PiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBzb2NrYWRkcl9z
dG9yYWdlIGNscF9hZGRyLCBvbGRfYWRkcjsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVj
dCBzb2NrYWRkciAqY2xwX3NhcCA9IChzdHJ1Y3Qgc29ja2FkZHINCj4gPiA+ID4gPiA+ID4gKikm
Y2xwX2FkZHI7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qgc29ja2FkZHIgKm9sZF9z
YXAgPSAoc3RydWN0IHNvY2thZGRyDQo+ID4gPiA+ID4gPiA+ICopJm9sZF9hZGRyOw0KPiA+ID4g
PiA+ID4gPiArwqDCoMKgwqAgc2l6ZV90IGNscF9zYWxlbiwgb2xkX3NhbGVuOw0KPiA+ID4gPiA+
ID4gPiArwqDCoMKgwqAgc3RydWN0IHhwcnRfY3JlYXRlIHhwcnRfYXJncyA9IHsNCj4gPiA+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuaWRlbnQgPSBvbGQtPmNsX3Byb3RvLA0K
PiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uZXQgPSBvbGQtPmNsX25l
dCwNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2VydmVybmFtZSA9
IG9sZC0+Y2xfaG9zdG5hbWUsDQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCB9Ow0KPiA+ID4gPiA+
ID4gPiArwqDCoMKgwqAgc3RydWN0IG5mczRfYWRkX3hwcnRfZGF0YSB4cHJ0ZGF0YSA9IHsNCj4g
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuY2xwID0gb2xkLA0KPiA+ID4g
PiA+ID4gPiArwqDCoMKgwqAgfTsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBycGNf
YWRkX3hwcnRfdGVzdCBycGNkYXRhID0gew0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC5hZGRfeHBydF90ZXN0ID0gb2xkLT5jbF9tdm9wcy0NCj4gPiA+ID4gPiA+ID4g
PnNlc3Npb25fdHJ1bmssDQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LmRhdGEgPSAmeHBydGRhdGEsDQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCB9Ow0KPiA+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBpZiAoY2xwLT5jbF9wcm90byAhPSBvbGQt
PmNsX3Byb3RvKQ0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
bjsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGNscF9zYWxlbiA9IHJwY19wZWVyYWRkcihjbHAt
PmNsX3JwY2NsaWVudCwNCj4gPiA+ID4gPiA+ID4gY2xwX3NhcCwNCj4gPiA+ID4gPiA+ID4gc2l6
ZW9mKGNscF9hZGRyKSk7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBvbGRfc2FsZW4gPSBycGNf
cGVlcmFkZHIob2xkLT5jbF9ycGNjbGllbnQsDQo+ID4gPiA+ID4gPiA+IG9sZF9zYXAsDQo+ID4g
PiA+ID4gPiA+IHNpemVvZihvbGRfYWRkcikpOw0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
PiA+ICvCoMKgwqDCoCBpZiAoY2xwX2FkZHIuc3NfZmFtaWx5ICE9IG9sZF9hZGRyLnNzX2ZhbWls
eSkNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4g
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRfYXJncy5kc3RhZGRyID0g
Y2xwX3NhcDsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRfYXJncy5hZGRybGVuID0gY2xw
X3NhbGVuOw0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCB4cHJ0ZGF0
YS5jcmVkID0gbmZzNF9nZXRfY2xpZF9jcmVkKG9sZCk7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDC
oCBycGNfY2xudF9hZGRfeHBydChvbGQtPmNsX3JwY2NsaWVudCwgJnhwcnRfYXJncywNCj4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJw
Y19jbG50X3NldHVwX3Rlc3RfYW5kX2FkZF94cHJ0LA0KPiA+ID4gPiA+ID4gPiAmcnBjZGF0YSk7
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElzIHRoZXJlIGFuIHVwcGVyIGJvdW5kIG9uIHRo
ZSBudW1iZXIgb2YgdHJhbnNwb3J0cyB0aGF0DQo+ID4gPiA+ID4gPiBhcmUgYWRkZWQgdG8gdGhl
IE5GUyBjbGllbnQncyBzd2l0Y2g/DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBkb24ndCBiZWxp
ZXZlIGFueSBsaW1pdHMgZXhpc3QgcmlnaHQgbm93LiBXaHkgc2hvdWxkIHRoZXJlDQo+ID4gPiA+
ID4gYmUgYQ0KPiA+ID4gPiA+IGxpbWl0PyBBcmUgeW91IHNheWluZyB0aGF0IHRoZSBjbGllbnQg
c2hvdWxkIGxpbWl0IHRydW5raW5nPw0KPiA+ID4gPiA+IFdoaWxlDQo+ID4gPiA+ID4gdGhpcyBp
cyBub3Qgd2hhdCdzIGhhcHBlbmluZyBoZXJlLCBidXQgc2F5IEZTX0xPQ0FUSU9ODQo+ID4gPiA+
ID4gcmV0dXJuZWQNCj4gPiA+ID4gPiAxMDANCj4gPiA+ID4gPiBpcHMgZm9yIHRoZSBzZXJ2ZXIu
IEFyZSB5b3Ugc2F5aW5nIHRoZSBjbGllbnQgc2hvdWxkIGJlDQo+ID4gPiA+ID4gbGltaXRpbmcN
Cj4gPiA+ID4gPiBob3cNCj4gPiA+ID4gPiBtYW55IHRydW5rYWJsZSBjb25uZWN0aW9ucyBpdCB3
b3VsZCBiZSBlc3RhYmxpc2hpbmcgYW5kDQo+ID4gPiA+ID4gcGlja2luZw0KPiA+ID4gPiA+IGp1
c3QgYQ0KPiA+ID4gPiA+IGZldyBhZGRyZXNzZXMgdG8gdHJ5PyBXaGF0J3MgaGFwcGVuaW5nIHdp
dGggdGhpcyBwYXRjaCBpcw0KPiA+ID4gPiA+IHRoYXQNCj4gPiA+ID4gPiBzYXkNCj4gPiA+ID4g
PiB0aGVyZSBhcmUgMTAwbW91bnRzIHRvIDEwMCBpcHMgKGVhY2ggcmVwcmVzZW50aW5nIHRoZSBz
YW1lDQo+ID4gPiA+ID4gc2VydmVyDQo+ID4gPiA+ID4gb3INCj4gPiA+ID4gPiB0cnVua2FibGUg
c2VydmVyKHMpKSwgd2l0aG91dCB0aGlzIHBhdGNoIGEgc2luZ2xlIGNvbm5lY3Rpb24NCj4gPiA+
ID4gPiBpcw0KPiA+ID4gPiA+IGtlcHQsDQo+ID4gPiA+ID4gd2l0aCB0aGlzIHBhdGNoIHdlJ2xs
IGhhdmUgMTAwIGNvbm5lY3Rpb25zLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHBhdGNoIGRlc2Ny
aXB0aW9uIG5lZWRzIHRvIG1ha2UgdGhpcyBiZWhhdmlvciBtb3JlIGNsZWFyLg0KPiA+ID4gPiBJ
dA0KPiA+ID4gPiBuZWVkcyB0byBleHBsYWluICJ3aHkiIC0tIHRoZSBib2R5IG9mIHRoZSBwYXRj
aCBhbHJlYWR5DQo+ID4gPiA+IGV4cGxhaW5zDQo+ID4gPiA+ICJ3aGF0Ii4gQ2FuIHlvdSBpbmNs
dWRlIHlvdXIgbGFzdCBzZW50ZW5jZSBpbiB0aGUgZGVzY3JpcHRpb24NCj4gPiA+ID4gYXMNCj4g
PiA+ID4gYSB1c2UgY2FzZT8NCj4gPiA+ID4gDQo+ID4gPiA+IEFzIGZvciB0aGUgYmVoYXZpb3Iu
Li4gU2VlbXMgdG8gbWUgdGhhdCB0aGVyZSBhcmUgZ29pbmcgdG8gYmUNCj4gPiA+ID4gb25seQ0K
PiA+ID4gPiBpbmZpbml0ZXNpbWFsIGdhaW5zIGFmdGVyIHRoZSBmaXJzdCBmZXcgY29ubmVjdGlv
bnMsIGFuZCBhZnRlcg0KPiA+ID4gPiB0aGF0LCBpdCdzIGdvaW5nIHRvIGJlIGEgbG90IGZvciBi
b3RoIHNpZGVzIHRvIG1hbmFnZSBmb3Igbm8NCj4gPiA+ID4gcmVhbA0KPiA+ID4gPiBnYWluLiBJ
IHRoaW5rIHlvdSBkbyB3YW50IHRvIGNhcCB0aGUgdG90YWwgbnVtYmVyIG9mDQo+ID4gPiA+IGNv
bm5lY3Rpb25zDQo+ID4gPiA+IGF0IGEgcmVhc29uYWJsZSBudW1iZXIsIGV2ZW4gaW4gdGhlIEZT
X0xPQ0FUSU9OUyBjYXNlLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSdkIHRlbmQgdG8gYWdy
ZWUuIElmIHlvdSB3YW50IHRvIHNjYWxlIEkvTyB0aGVuIHBORlMgaXMgdGhlIHdheQ0KPiA+ID4g
dG8NCj4gPiA+IGdvLA0KPiA+ID4gbm90IHZhc3QgbnVtYmVycyBvZiBjb25uZWN0aW9ucyB0byBh
IHNpbmdsZSBzZXJ2ZXIuDQo+ID4gPiANCj4gPiBCVFc6IEFGQUlDUyB0aGlzIHBhdGNoIHdpbGwg
ZW5kIHVwIGFkZGluZyBhbm90aGVyIGNvbm5lY3Rpb24gZXZlcnkNCj4gPiB0aW1lDQo+ID4gd2Ug
bW91bnQgYSBuZXcgZmlsZXN5c3RlbSwgd2hldGhlciBvciBub3QgYSBjb25uZWN0aW9uIGFscmVh
ZHkNCj4gPiBleGlzdHMNCj4gPiB0byB0aGF0IElQIGFkZHJlc3MuIFRoYXQncyB1bmFjY2VwdGFi
bGUuDQo+IA0KPiBOb3QgaW4gbXkgdGVzdGluZy4gTW91bnRzIHRvIHRoZSBzYW1lIHNlcnZlciAo
c2FtZSBJUCkgZGlmZmVyZW50DQo+IGV4cG9ydCB2b2x1bWVzIGxlYWQgdG8gdXNlIG9mIGEgc2lu
Z2xlIGNvbm5lY3Rpb24uDQo+ID4gDQoNCkFoLi4uIE5ldmVyIG1pbmQuIFRoZSBjb21wYXJpc29u
IGlzIG1hZGUgYnkNCnJwY19jbG50X3NldHVwX3Rlc3RfYW5kX2FkZF94cHJ0KCksIGFuZCB0aGUg
YWRkcmVzcyBpcyBkaXNjYXJkZWQgaWYgaXQNCmlzIGFscmVhZHkgcHJlc2VudC4NCg0KSG93ZXZl
ciB3aHkgYXJlIHlvdSBydW5uaW5nIHRydW5raW5nIGRldGVjdGlvbiBhIHNlY29uZCB0aW1lIG9u
IHRoZQ0KYWRkcmVzcyB5b3UndmUganVzdCBydW4gdHJ1bmtpbmcgZGV0ZWN0aW9uIG9uIGFuZCBo
YXZlIGRlY2lkZWQgdG8gYWRkPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
