Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8D2D475C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgLIRAS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:00:18 -0500
Received: from mail-dm6nam12on2101.outbound.protection.outlook.com ([40.107.243.101]:40646
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732200AbgLIRAO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 12:00:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzoBp+3I0pewT6W+iG8nsjc3Yb90abozYCxM1xArnTYUUrWRuHVehSZww8DdMVzQ8k+wn43qtvMYBsTjBJNXCkK+xzvlHB4xoc5J6Tay2MJNzx0CWTEsUPkKBiwixv5aEA2/z0HO2fuyZPOeb76x6yTq98Xeiaoli+MiUCkE21KqnzaBKb79pAwn+c8xqyQMIq5uRxe8UBnSdQflsMdElkybES+s80ejbD3o/qdDxkYbliliw6Lx37qtwf4dtxGxE2wYzma6QLYXhkXt/RBqrXzoNJpiJrqP4V1LbI6L3XvyWbKJY2hAwfBVO3lU8Ex/28NMPQ3PmkwK0uRq43xL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDWGQCRC5hmWPSlPUUoSg7yfTedvUvEKxzZbMW6DrLU=;
 b=crw2iqUME0kwWqMSeA606X6k/PQlBMxQTXt0FBMr0a/ENp7pEl75fnJ+iJY24HvR68SWrcs1ljfmU0yZLmx5DuqKc7tWieQIaYjiVeLInNQ5X4ASS1zu3qWGhXrijqIj5zXtsmmxO6c0qimxeGjc/sOyjk1HKY/M6rlH7qL+voWBLwjhrSLxH8KWacsIDqeKIRBUOAmi84L8sUiqvgCx47Q8+oSF7bb1NbliGl8SPkp2JbZ53STLjIMcXbX53NfR3rezv4AKSVgflJk2GRSIvOBMdjgyDCu2ygJSIMYRtasIWGMc0WLSuKWeH+4jMywYgretqwz9C/lCMipGxwdaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDWGQCRC5hmWPSlPUUoSg7yfTedvUvEKxzZbMW6DrLU=;
 b=axou16eX5KhmtxsJMv4C7mY1zno5K14MCLAeo9lpQgjOIwjm530ovRWSwIbOVUeHU52Hbg9g7b8TK+U/3tOwLtSyl3B1s4KuflwDpSFx8j9QbwEmS+y8CcBQHn6mWCHPBTYlYK6p6JVfqUnDZEcqi0vbCunk3qpe5W6a2qQevAQ=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3359.namprd13.prod.outlook.com (2603:10b6:208:16c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7; Wed, 9 Dec
 2020 16:59:17 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3654.009; Wed, 9 Dec 2020
 16:59:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
Thread-Topic: [PATCH 0/3] NFS: Disable READ_PLUS by default
Thread-Index: AQHWybGmaIjlThqGT0GKib773fRGxannFjQAgABGpgCAB6kDAA==
Date:   Wed, 9 Dec 2020 16:59:17 +0000
Message-ID: <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
         <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de>
         <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
In-Reply-To: <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: desy.de; dkim=none (message not signed)
 header.d=none;desy.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f6792f7-5c26-4fba-435a-08d89c63c3e6
x-ms-traffictypediagnostic: MN2PR13MB3359:
x-microsoft-antispam-prvs: <MN2PR13MB3359C92D879F5FE676402DD0B8CC0@MN2PR13MB3359.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9siXWd5AbstMEGy6ap7+e+LUliLUUiYM3N6oCDNZsjIxegZnG7TrF3SJKFM/SBWqDhTRxPm2i1CW9wKWy6ammuvE4HHJxrl98I2wfpYUUh7Hae71OlvIR00VZbpcQ2Jpaw5gZPy4z81dXPiQEBoUoXc0eyIQVBU6loSoQ0lvjvn8eOz76g6GJqg2HoVWXEUaxXu4A0dqaC6xp98le7ZToRuKRFTDaSUWL8iIChubA6lD0l8RxWltk0Hv5r66KsCwKz6RJs3MeqW+pMgvvRMu80nUirGC8eo+M9XMXJQ87QAogi3f/BXnT/D1zjvHHicunsEVcz8rFnv6z6faDGZPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(66946007)(186003)(64756008)(66556008)(66476007)(76116006)(26005)(8676002)(6512007)(91956017)(6486002)(6506007)(2906002)(8936002)(4744005)(2616005)(86362001)(36756003)(110136005)(54906003)(508600001)(66446008)(5660300002)(4326008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWEzWUluTVVlU05JS1NrajFwem9vQ05Ta2VudkJrRDNRMzc3OFkzSUhicUlK?=
 =?utf-8?B?ckVWYTZtVjZQcXlGa3lIU3hoTmxLRjZSZytoUDJHeVRoSEhBSS9sMlJxdzlE?=
 =?utf-8?B?eXJRZHVQeDFZRXc5bGMyYld6N09GWnYzQUE2R2lzQ0hhV2hyYmlBVHM1bS9j?=
 =?utf-8?B?UXFUTkM5eXpSaFNaYVVGV1pJeVpaQ0I5aEZCcVcxV0pUSU1vMDd2dU5Ca24r?=
 =?utf-8?B?UE93ek1NckgrTHpJalB2MWVTNGtNUS9uT05nYXRqM3hDTkZzanBKK3JJQXdx?=
 =?utf-8?B?RWlnU2tONUwvM1U3b0V0dTRaeWRrUm90cmxLdUs1QzY2NG9nZ0kzaTgzOHRV?=
 =?utf-8?B?bDA5a2RWUy8xN04weHJyYmFlU0RtWEphODJGL24xNUY3YUl0V1JhSXNhS3Zh?=
 =?utf-8?B?N1p4c1l6NUk4UVVmOHFIcHpBU1ZEc25rT2twTitUTlE0WE1sQWRSTGFnVUpQ?=
 =?utf-8?B?QmUxYTlwdmJOTzYwZFQrWldWcmNpdDljblJMY29PU2ZTV0pLYXo5VDJKeFU5?=
 =?utf-8?B?eWtZWkV4eHVTZnFUeGZOL3U5SUVaL1RqaWVzRElHdTdaTFN3RTRHaVArQVdj?=
 =?utf-8?B?SHdFemVmMXE2dmZrUkozMW1ZMGp1bVR6LzlKUngxUGp4bGVpN0xlYkpTTjdS?=
 =?utf-8?B?V202WkJNVW0vcDRzRmMyZVNSMVJkSFNXNTJvZTk5cGJBMDh3RFhtRjFvNmsv?=
 =?utf-8?B?TllBVm9VL2pwM1F0OTBNTGZNaWkvZ2p4ZGtEN0lnNGd6WkRWUWZxK25mZ1RZ?=
 =?utf-8?B?SDBWckU4cDBXTTAxdHVUbTBRYXl3WmwzdEUxajVPbm9CSlpsdndQRDdTWVVs?=
 =?utf-8?B?M1ZzYnFQbE1HTDllZWMvL0RySHdBbnFINDJqQmE3dlJLODFQQTBRM094UElm?=
 =?utf-8?B?MnRkd09mSldha1c3NEVBdkhPc2lISGpqNVZFTVY0aDBTNms0VVpEdjJvM3By?=
 =?utf-8?B?VjdpOVZKQmw2enhBUXFKaWFFV05NdW5RZmlSY1E5ekNKSExxTUEzb1pIUEFq?=
 =?utf-8?B?dmI4SGpWYmRGNWtKbUdSYmVpTzN6aWtxQjBwbTFiT2xhanFjTmVTeWpWREw4?=
 =?utf-8?B?WEl2cGc0cEdEbHFHRWF5R3FhNXAvNHJtRTNzUWoxZk4wT0RBM1cvTHNneE0r?=
 =?utf-8?B?c3hHU2lzMldJK2N4cTJTREE5YkRWc1VjR0wwNDY1NkIrclY3WUlTOGRuKzQ1?=
 =?utf-8?B?M2QwVXhickxTamR6TDhvUFl5TE8rTkJ0UlBrTkU0a0pWTUF6VVkvWndIMFV0?=
 =?utf-8?B?Sll1TXNZM2ZBOGxCMEV2b29DUklCMmhhLzUvUDNuK0pKVzhOMW03TldBbW1V?=
 =?utf-8?Q?TpOW/ykyPcS3UG3GcEA0tx2V80sIxgu+R3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <24700B1E18C5ED4FAEB47B4B0D10AEC6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6792f7-5c26-4fba-435a-08d89c63c3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 16:59:17.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPpyqAJ4kooL8p7sUR7wBlI92x4LENh0lThLvwtmKq+7eJYDAB4J1lfrg+YChnKKAXdYs4KvoVA8PHC4CiYUIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3359
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDE1OjAwIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSSBvYmplY3QgdG8gcHV0dGluZyB0aGUgZGlzYWJsZSBwYXRjaCBpbiwgSSB0aGluayB3
ZSBuZWVkIHRvIGZpeCB0aGUNCj4gcHJvYmxlbS4NCg0KSSBjYW4ndCBzZWUgdGhlIHByb2JsZW0g
aXMgZml4YWJsZSBpbiA1LjEwLiBUaGVyZSBhcmUgd2F5IHRvbyBtYW55DQpjaGFuZ2VzIHJlcXVp
cmVkLCBhbmQgd2UncmUgaW4gdGhlIG1pZGRsZSBvZiB0aGUgd2VlayBvZiB0aGUgbGFzdCAtcmMN
CmZvciA1LjEwLiBGdXJ0aGVybW9yZSwgdGhlcmUgYXJlIG5vIHJlZ3Jlc3Npb25zIGludHJvZHVj
ZWQgYnkganVzdA0KZGlzYWJsaW5nIHRoZSBmdW5jdGlvbmFsaXR5LCBiZWNhdXNlIFJFQURfUExV
UyBoYXMgb25seSBqdXN0IGJlZW4NCm1lcmdlZCBpbiB0aGlzIHJlbGVhc2UgY3ljbGUuDQoNCkkg
dGhlcmVmb3JlIHN0cm9uZ2x5IHN1Z2dlc3Qgd2UganVzdCBzZW5kIFtQQVRDSCAxLzNdIE5GUzog
RGlzYWJsZQ0KUkVBRF9QTFVTIGJ5IGRlZmF1bHQgYW5kIHRoZW4gZml4IHRoZSByZXN0IGluIDUu
MTEuDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
