Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6CB2AA1B5
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Nov 2020 01:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKGAQk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 19:16:40 -0500
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:11147
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727129AbgKGAQk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Nov 2020 19:16:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgIvm5yhDbwIApYLI8O85ZNJIBvzEXmco4XExFZ4gDDEmaO6DKpVxcrUrFBc63wMHX2cNNWGBeM8tV3sNW1o1+nPnznfheYX9vW/hWZC8XmuSK7bqn3yhiaZiRIJwNzxHL4sRLjJtV2GOaqIGXrT5jrwQf9/AJJm6g41RJEu+biHATdejiHh5G65JVuHZPJF55wF+9/ilpKiRXJlz47/3ajnJ4OpO/DPaXrKYtZ6aieIaiq0Eq7qXJXUss3ipIs+k1136Sq7e6Ca93A9StdSjg358H8+3VrwHn6H8tpeusmdbqpUcKFUkaKcKrVHQLn8ffclnt/siUMs+KTDzkkDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7BTDNtcCso5Sd6AZG+DugFxw82gHXDn4rNDg3r3F6M=;
 b=Uu+KaIb5JiIopssR+szw6ZGYkBcmo2lA2IVLAL9LwSe33Xu0RYZngRPnvb9TaMwvNmqMfp4j3iqy9opBbDxVUN/qttBnlsnqBJr9kMTpTwG0VD30cKIOW1cO1Q20G4aStXMgtu+SEsFYwGhch3ZpJmNhwKi9SVyqEYONe44yVri2JQ/RTf6a7tZAdeQ1NUcrIgeLc5wwplJkOzUuyvu3KP7+IsekHGeYn9mmktSIUtIUWNGaUWjTAcpehOhGrwRIvBfTrVx+6vaJlp3F9uYLTYhoRI9JUwI3fqL50xRKhyioCnNRR7iL0cpY5xENtAX6Hyb+X251yYqZKr+GuIm3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7BTDNtcCso5Sd6AZG+DugFxw82gHXDn4rNDg3r3F6M=;
 b=f7FKREYPVyJW/r1ztt7aTlAx0BtjVZpM3xNZT6BOPRudPANOdyyYC0xvK1rSXMP1+4kb6K20/08sj8c28SLU8ZpuGVwmgiprvjSVkRvi0hOqJ3gxt6eU3Jdn/0Q7FGyfmUszost1VFMkCr6sDX77ycMMocu4bgGq4YwyDWI6j90=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2638.namprd13.prod.outlook.com (2603:10b6:208:f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Sat, 7 Nov
 2020 00:16:36 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Sat, 7 Nov 2020
 00:16:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "omosnace@redhat.com" <omosnace@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] NFSv4.2: condition READDIR's mask for security
 label based on LSM state
Thread-Topic: [PATCH v5 1/1] NFSv4.2: condition READDIR's mask for security
 label based on LSM state
Thread-Index: AQHWtIBQ4+SDs55K/0i0UUx+kL1BF6m7zX8A
Date:   Sat, 7 Nov 2020 00:16:35 +0000
Message-ID: <7c3f4e443ac7b14cdb5175a1447a9348039908bb.camel@hammerspace.com>
References: <20201106210338.5032-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20201106210338.5032-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d90e4e7-0c24-4330-87df-08d882b2639c
x-ms-traffictypediagnostic: MN2PR13MB2638:
x-microsoft-antispam-prvs: <MN2PR13MB2638CA8D45E2D229DD77D416B8EC0@MN2PR13MB2638.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NN4vEh0dYkD8HG5c07nA/5flmv2Nr2nnCqg2b4/5AjdaiDQ7ZDIZ/AN6UrZ0K5vWBn7A3BlqsE27/ckQYm9NivYWiaHq8xAM+GA1s6UumKfTXB6mtWP3OH5+koS1O9Q0uSHLeMLv2rqFLDAr6hunWTfNaYLfi6vbET4k4Vq5ih8XhAQc/lmqVtTqqHw1SIQAejFojjPmRcYGARUaQ72pyHtXZ/10/ur9EoO7BCnRV/ALDTbdTWXyKWUReo6Av0cY25Z/Gka2XMdYUJPqJhKBJ+hj/kxcY2g+P1bTeKeQ74Mi71xl1FGVQqi2Tx6sAo4N3saGwhHJQe2K91NUqOvXkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(366004)(376002)(136003)(4326008)(71200400001)(2616005)(66446008)(86362001)(6506007)(8936002)(186003)(15650500001)(26005)(83380400001)(2906002)(5660300002)(91956017)(66556008)(6486002)(54906003)(66476007)(64756008)(110136005)(316002)(36756003)(76116006)(6512007)(8676002)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zaJV+k9l5BE4gnVVbv5JAHxBM+q5Y8GFgMk3pzY74hN9f1ZWCjomi00PZTroML6ltPFgapaVSnhF0ww6jjvCHb1OHX8QAdLf1BFH/r6nvLRlGnUsYMTFlGfd59B7pm+Dn+qQzvljDK/LHGPvHN3YBiyc5UC1Rp7PX3Z85Hv5IcaJs2hbabf0D9eolnm9GJDM+EKCAXanzaKfJ7IVbEvhJr6sxKlW2dioN2/9vlVLlHvoxEPAI6z/7BBQCGGFVr65v5o/TbUxUoZPxx+r1JrnAX3EjZzA54pjyO54LFeWKiUsf9XpiNorSvGY5TD67lGtShcSsRQLTmGKhL6yOmz1Vwl+PxOPN7e6RfSzLIHMP1+HZgEcfVkydWW2DALZJT3e7Q4bq2a6/Vdhr3QXoFhgJ7HenJHDOm4lQYh0BSeLmWHmBUiHYZixldMafAj+RpOpCQszLFxQsEoG94KhrSkxKNROK/FP8NDZJ6d7PVUl7ZrFflAZC4zuT9pzYVwvvymO+ty7cmkKgLEdzU1rLjOdf7bNlSar81cP+lUJhMN9ljSOrdQYEiRbnrEalFovSDMUsj+DU3PVI+w2IuGuZ9MDpVbApnNhUTGRqBIqwfUOB+ft3nFw0pMoD1ecLptrPv4cjg42GfNkcfC08V9Da0iuyA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4922A94157ABCD40AA852EB712733F28@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d90e4e7-0c24-4330-87df-08d882b2639c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2020 00:16:35.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaBz8h2W80ba/uYW8D3I7KoHl4Hhz+/tfwtBaket2JCd7cdfyTnEHnBHH0RY5cWxhLZmtPbvHKX1yaDiCROQ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2638
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTExLTA2IGF0IDE2OjAzIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IA0KPiBD
dXJyZW50bHksIHRoZSBjbGllbnQgd2lsbCBhbHdheXMgYXNrIGZvciBzZWN1cml0eV9sYWJlbHMg
aWYgdGhlDQo+IHNlcnZlcg0KPiByZXR1cm5zIHRoYXQgaXQgc3VwcG9ydHMgdGhhdCBmZWF0dXJl
IHJlZ2FyZGxlc3Mgb2YgYW55IExTTSBtb2R1bGVzDQo+IChzdWNoIGFzIFNlbGludXgpIGVuZm9y
Y2luZyBzZWN1cml0eSBwb2xpY3kuIFRoaXMgYWRkcyBwZXJmb3JtYW5jZQ0KPiBwZW5hbHR5IHRv
IHRoZSBSRUFERElSIG9wZXJhdGlvbi4NCj4gDQo+IENsaWVudCBhZGp1c3RzIHN1cGVyYmxvY2sn
cyBzdXBwb3J0IG9mIHRoZSBzZWN1cml0eV9sYWJlbCBiYXNlZCBvbg0KPiB0aGUgc2VydmVyJ3Mg
c3VwcG9ydCBidXQgYWxzbyBjdXJyZW50IGNsaWVudCdzIGNvbmZpZ3VyYXRpb24gb2YgdGhlDQo+
IExTTSBtb2R1bGVzLiBUaHVzLCBwcmlvciB0byB1c2luZyB0aGUgZGVmYXVsdCBiaXRtYXNrIGlu
IFJFQURESVIsDQo+IHRoaXMgcGF0Y2ggY2hlY2tzIHRoZSBzZXJ2ZXIncyBjYXBhYmlsaXRpZXMg
YW5kIHRoZW4gaW5zdHJ1Y3RzDQo+IFJFQURESVIgdG8gcmVtb3ZlIEZBVFRSNF9XT1JEMl9TRUNV
UklUWV9MQUJFTCBmcm9tIHRoZSBiaXRtYXNrLg0KPiANCj4gdjU6IGZpeGluZyBzaWxseSBtaXN0
YWtlcyBvZiB0aGUgcnVzaGVkIHY0DQo+IHY0OiBzaW1wbGlmeWluZyBsb2dpYw0KPiB2MzogY2hh
bmdpbmcgbGFiZWwncyBpbml0aWFsaXphdGlvbiBwZXIgT25kcmVqJ3MgY29tbWVudA0KPiB2Mjog
ZHJvcHBpbmcgc2VsaW51eCBob29rIGFuZCB1c2luZyB0aGUgc2IgY2FwLg0KPiANCj4gU3VnZ2Vz
dGVkLWJ5OiBPbmRyZWogTW9zbmFjZWsgPG9tb3NuYWNlQHJlZGhhdC5jb20+DQo+IFN1Z2dlc3Rl
ZC1ieTogU2NvdHQgTWF5aGV3IDxzbWF5aGV3QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMv
bmZzNHByb2MuYyB8IDEwICsrKysrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJv
Yy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gaW5kZXggOWUwY2E5YjJiMjEwLi43ZmE2M2UyODJh
ZjAgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0
cHJvYy5jDQo+IEBAIC00OTYxLDEyICs0OTYxLDEyIEBAIHN0YXRpYyBpbnQgX25mczRfcHJvY19y
ZWFkZGlyKHN0cnVjdCBkZW50cnkNCj4gKmRlbnRyeSwgY29uc3Qgc3RydWN0IGNyZWQgKmNyZWQs
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTY0IGNvb2tpZSwgc3RydWN0IHBh
Z2UgKipwYWdlcywgdW5zaWduZWQgaW50IGNvdW50LA0KPiBib29sIHBsdXMpDQo+IMKgew0KPiDC
oMKgwqDCoMKgwqDCoMKgc3RydWN0IGlub2RlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKmRpciA9
IGRfaW5vZGUoZGVudHJ5KTsNCj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG5mc19zZXJ2ZXLCoMKg
wqDCoMKgwqDCoCpzZXJ2ZXIgPSBORlNfU0VSVkVSKGRpcik7DQo+IMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgbmZzNF9yZWFkZGlyX2FyZyBhcmdzID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC5maCA9IE5GU19GSChkaXIpLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5wYWdlcyA9IHBhZ2VzLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC5wZ2Jhc2UgPSAwLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5jb3VudCA9
IGNvdW50LA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmJpdG1hc2sgPSBORlNf
U0VSVkVSKGRfaW5vZGUoZGVudHJ5KSktPmF0dHJfYml0bWFzaywNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAucGx1cyA9IHBsdXMsDQo+IMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiDC
oMKgwqDCoMKgwqDCoMKgc3RydWN0IG5mczRfcmVhZGRpcl9yZXMgcmVzOw0KPiBAQCAtNDk4MSw5
ICs0OTgxLDE1IEBAIHN0YXRpYyBpbnQgX25mczRfcHJvY19yZWFkZGlyKHN0cnVjdCBkZW50cnkN
Cj4gKmRlbnRyeSwgY29uc3Qgc3RydWN0IGNyZWQgKmNyZWQsDQo+IMKgwqDCoMKgwqDCoMKgwqBk
cHJpbnRrKCIlczogZGVudHJ5ID0gJXBkMiwgY29va2llID0gJUx1XG4iLCBfX2Z1bmNfXywNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVudHJ5LA0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAodW5zaWdu
ZWQgbG9uZyBsb25nKWNvb2tpZSk7DQo+ICvCoMKgwqDCoMKgwqDCoGlmICghKHNlcnZlci0+Y2Fw
cyAmIE5GU19DQVBfU0VDVVJJVFlfTEFCRUwpKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgYXJncy5iaXRtYXNrID0gc2VydmVyLT5hdHRyX2JpdG1hc2tfbmw7DQo+ICvCoMKgwqDC
oMKgwqDCoGVsc2UNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFyZ3MuYml0bWFz
ayA9IHNlcnZlci0+YXR0cl9iaXRtYXNrOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKgwqBuZnM0X3Nl
dHVwX3JlYWRkaXIoY29va2llLCBORlNfSShkaXIpLT5jb29raWV2ZXJmLCBkZW50cnksDQo+ICZh
cmdzKTsNCj4gwqDCoMKgwqDCoMKgwqDCoHJlcy5wZ2Jhc2UgPSBhcmdzLnBnYmFzZTsNCj4gLcKg
wqDCoMKgwqDCoMKgc3RhdHVzID0gbmZzNF9jYWxsX3N5bmMoTkZTX1NFUlZFUihkaXIpLT5jbGll
bnQsDQo+IE5GU19TRVJWRVIoZGlyKSwgJm1zZywgJmFyZ3Muc2VxX2FyZ3MsICZyZXMuc2VxX3Jl
cywgMCk7DQo+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IG5mczRfY2FsbF9zeW5jKHNlcnZlci0+
Y2xpZW50LCBzZXJ2ZXIsICZtc2csDQo+ICZhcmdzLnNlcV9hcmdzLA0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZyZXMuc2VxX3JlcywgMCk7DQo+IMKg
wqDCoMKgwqDCoMKgwqBpZiAoc3RhdHVzID49IDApIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBtZW1jcHkoTkZTX0koZGlyKS0+Y29va2lldmVyZiwgcmVzLnZlcmlmaWVyLmRh
dGEsDQo+IE5GUzRfVkVSSUZJRVJfU0laRSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc3RhdHVzICs9IGFyZ3MucGdiYXNlOw0KDQpUaGF0IHZlcnNpb24gbG9va3MgZ29vZCB0
byBtZS4gVGhhbmtzIE9sZ2EhDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
