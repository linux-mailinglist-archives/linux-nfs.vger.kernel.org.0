Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD231E8A03
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgE2V0q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 May 2020 17:26:46 -0400
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:33793
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727964AbgE2V0p (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 29 May 2020 17:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOkOz71Iux/t75Isml/OQhQGlwXPEfgFFZH0A5KKExhelpTL6zG00ijhEQTAeod3S39izBEhsLER6GbPTRoVNojvbUkDbv77+CHYO52Sv5l6VlKGGTkiWS0Y9khR1koi1P7RNSzVw/H19Q2Byhfls5dyBCvzwQx2Q4T5sn9/8/Ue+iBQEJ5QYrzc3bQNmW2LmVdsr/Ypqp349yOvU+RlmORiMp5HcwudEvAaO+zYUVV3s4HF4qjPsjya+/j7OO/9p0LqiLW0lkOuggPzUfggUP3v4t4JdpvT/K6YHwRcH+H3+J3E7WEBsK9VxnF84gat6K6oaArTFKCruVEEiKqsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwY9LOUyXNJvH3P479jLUJ4x68tS8PkB9ErUfSyTBas=;
 b=SeJEjUy5+3QHtcfwOsOKL9UpOAm9B4m7YwOIl7OBObCG6UdRyYwpsSrDKGLEKOEnP6f9fEHNxJwHt7huopxl6cLIC8PIaZOsiRPwAoT6RAHdERZP/L8hIFjzerfzyDLCt1akLw4yKDrmWovE5aAa9/AqAnGlsfbyZaJZXzEZPBKLWB9tmU5kNIgIHyamFO4Kc/sqr7mdqxO3Cz7bRD+N4l4i6agmzFImNCHQrujzQUc0XpZLATkWpMBdjbt2CIQZT0s66dfRqKy8AHUWHyMT9Qxka8Xs5522Bw5yJ/OG5EZm7ZjAKRXGg6UalrlsTIw54CMWCj823ryF2oy4Y4qmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwY9LOUyXNJvH3P479jLUJ4x68tS8PkB9ErUfSyTBas=;
 b=B4Haq5lSk4InvkccSiMf+1dc0ZpteiyPVWy1023oOp6wV3o4IuqyYahrydOre0RbWQxH774YD1iA0rM0apK9B1EHyXMkzIfl8inBc7skv/v7T7D1bqSWurLTV/AuvveDJ1zy9MaqVzp0nI2PQTBk8GsQ7B1BQkRuXOacO1CWu7w=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3814.namprd13.prod.outlook.com (2603:10b6:610:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7; Fri, 29 May
 2020 21:26:43 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 21:26:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFS: Fix direct WRITE throughput regression
Thread-Topic: [PATCH v1] NFS: Fix direct WRITE throughput regression
Thread-Index: AQHWNeUKAc4aS3htnUGivG2NXu22Qai/k+cA
Date:   Fri, 29 May 2020 21:26:43 +0000
Message-ID: <53954cf837ac830f34abb8bb7cc38307e30e48f1.camel@hammerspace.com>
References: <20200529181440.2510.45116.stgit@manet.1015granger.net>
In-Reply-To: <20200529181440.2510.45116.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8958e8f-010d-4220-31c8-08d80416fbe6
x-ms-traffictypediagnostic: CH2PR13MB3814:
x-microsoft-antispam-prvs: <CH2PR13MB38145FAAD9806248CF4CF854B88F0@CH2PR13MB3814.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zx4LNtfrIeQ3wOFaNHh0cGUKjK19R7J7VorzETzeVSLA1xlUq8TVDvbwnxAbgNPdTotu89UO0sMEdPNaqu0YG9XcP3Aw0NfynMd4kEyhFys7u8XQK2q3eRvQT0zCX1fq33rdKi9Yav8l7rSbwxhmNetPIBj3afhDBvfNpSfhAfXtslgYkX6OSQQ8/JwsaSG/m9T3lWj7B4pVESbWIDM0N891ExcDhJy9saQFSZwAcSZ9cOlNObWAdSF7mYwwBbNoCBXK/twpdTEhj2gWgkhU5YlKvSStbj/7dSUrTV0uTaYF0hewQGMtiK6jWCWYlYKtNJ7fznAFue+ioVmbP/ZKVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(39830400003)(376002)(346002)(86362001)(8936002)(186003)(110136005)(316002)(6486002)(478600001)(83380400001)(36756003)(64756008)(66476007)(66556008)(2906002)(26005)(4326008)(6512007)(66446008)(76116006)(66946007)(71200400001)(6506007)(5660300002)(2616005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Llok/oYdguCIfTenb4MQKaYuCGlcR6S8xBNgyvotNjwopMH75yCJFJ/5nICTJVtuKwiiXR4zTCaf6+jpGEVLbNGT2I6fQAV/j2m1RvQI2ak+8wKeBm7a3gLl8fejgkHNweD3+nLfApqWI+k1tjiI3iv1IDmzWCwZbzjyEv7Ux3UkxdvnqEVH6ZZ2gCjw38ZqlYWs0dueGgbzpqzF45pnwMEWf62y1oaXfqDH413ihHiq9lj5Y6K47HoDYXPSLxdedxwQWVcSZKoxzfkXTjPAxD2vSHKTl/M75mhBykblhYPJw6wph+I2nX3+w08MiEKXkABjuYa5h2rKLqyJhhjGCROZztDj+eDMMvOnwd6al+QvGWhRPw+VsWTrXQ7QARgfn/0D/AxUFJTlcgEqQBm/ksLUATvr3sVyMF+BWx0rrAG/JQRPZA4ONmS6u87XDfnGNo853WxcqBs7uhs0QA8kfVtJbSPSdlqmqoHOS0JBVRc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4380E691C66E8B468DC6D46F94E5AD44@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8958e8f-010d-4220-31c8-08d80416fbe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 21:26:43.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOW7eqeFKPR5lqY7duEXLiPKOzDiDxVZUv+aEoe5Dh8evxdeWI8ECeb9z5icDQlxHRcJ6kGxtPIpUMAnoSe9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3814
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDE0OjE0IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SSBtZWFzdXJlZCBhIDUwJSB0aHJvdWdocHV0IHJlZ3Jlc3Npb24gZm9yIGxhcmdlIGRpcmVjdCB3
cml0ZXMuDQo+IA0KPiBUaGUgb2JzZXJ2ZWQgb24tdGhlLXdpcmUgYmVoYXZpb3IgaXMgdGhhdCB0
aGUgY2xpZW50IHNlbmRzIGV2ZXJ5DQo+IE5GUyBXUklURSB0d2ljZTogb25jZSBhcyBhbiBVTlNU
QUJMRSBXUklURSBwbHVzIGEgQ09NTUlULCBhbmQgb25jZQ0KPiBhcyBhIEZJTEVfU1lOQyBXUklU
RS4NCj4gDQo+IFRoaXMgaXMgYmVjYXVzZSB0aGUgbmZzX3dyaXRlX21hdGNoX3ZlcmYoKSBjaGVj
ayBpbg0KPiBuZnNfZGlyZWN0X2NvbW1pdF9jb21wbGV0ZSgpIGZhaWxzIGZvciBldmVyeSBXUklU
RS4NCj4gDQo+IEJ1ZmZlcmVkIHdyaXRlcyB1c2UgbmZzX3dyaXRlX2NvbXBsZXRpb24oKSwgd2hp
Y2ggc2V0cyByZXEtPndiX3ZlcmYNCj4gY29ycmVjdGx5LiBEaXJlY3Qgd3JpdGVzIHVzZSBuZnNf
ZGlyZWN0X3dyaXRlX2NvbXBsZXRpb24oKSwgd2hpY2gNCj4gZG9lcyBub3Qgc2V0IHJlcS0+d2Jf
dmVyZiBhdCBhbGwuIFRoaXMgbGVhdmVzIHJlcS0+d2JfdmVyZiBzZXQgdG8NCj4gYWxsIHplcm9l
cyBmb3IgZXZlcnkgZGlyZWN0IFdSSVRFLCBhbmQgdGh1cw0KPiBuZnNfZGlyZWN0X2NvbW1pdF9j
b21wbGV0aW9uKCkgYWx3YXlzIHNldHMNCj4gTkZTX09ESVJFQ1RfUkVTQ0hFRF9XUklURVMuDQo+
IA0KPiBUaGlzIGZpeCBhcHBlYXJzIHRvIHJlc3RvcmUgbmVhcmx5IGFsbCBvZiB0aGUgbG9zdCBw
ZXJmb3JtYW5jZS4NCj4gDQo+IEZpeGVzOiAxZjI4NDc2ZGNiOTggKCJORlM6IEZpeCBPX0RJUkVD
VCBjb21taXQgdmVyaWZpZXIgaGFuZGxpbmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZl
ciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvZGlyZWN0LmMgfCAg
ICAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZnMvbmZzL2RpcmVjdC5jIGIvZnMvbmZzL2RpcmVjdC5jDQo+IGluZGV4IGE1N2U3Yzcy
YzdmNC4uZDQ5YjFkMTk3OTA4IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyZWN0LmMNCj4gKysr
IGIvZnMvbmZzL2RpcmVjdC5jDQo+IEBAIC03MzEsNiArNzMxLDggQEAgc3RhdGljIHZvaWQgbmZz
X2RpcmVjdF93cml0ZV9jb21wbGV0aW9uKHN0cnVjdA0KPiBuZnNfcGdpb19oZWFkZXIgKmhkcikN
Cj4gIAkJbmZzX2xpc3RfcmVtb3ZlX3JlcXVlc3QocmVxKTsNCj4gIAkJaWYgKHJlcXVlc3RfY29t
bWl0KSB7DQo+ICAJCQlrcmVmX2dldCgmcmVxLT53Yl9rcmVmKTsNCj4gKwkJCW1lbWNweSgmcmVx
LT53Yl92ZXJmLCAmaGRyLT52ZXJmLnZlcmlmaWVyLA0KPiArCQkJICAgICAgIHNpemVvZihyZXEt
PndiX3ZlcmYpKTsNCj4gIAkJCW5mc19tYXJrX3JlcXVlc3RfY29tbWl0KHJlcSwgaGRyLT5sc2Vn
LCAmY2luZm8sDQo+ICAJCQkJaGRyLT5kc19jb21taXRfaWR4KTsNCj4gIAkJfQ0KPiANCg0KVGhh
bmtzIENodWNrISBUaGF0J3MgYSBuby1icmFpbmVyLi4uIFNvcnJ5IGZvciB0aGUgc2NyZXd1cC4N
CkFubmEsIGFyZSB5b3UgdGFraW5nIHRoaXMgb25lPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
