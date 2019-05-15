Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300381F6AC
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2019 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfEOOi5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 May 2019 10:38:57 -0400
Received: from mail-eopbgr740110.outbound.protection.outlook.com ([40.107.74.110]:13935
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbfEOOi4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 May 2019 10:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHqMoKVn47gCEfKx8vbkBp/VViVx2367bxlHWhhwVTU=;
 b=OFoijG5kdCwLE8spzfiAwjmuI6eCgtPb2TY6CFOQYQpZACkcTNfxJx9wqtb4XH925UUUY3zTeUNKFQcEKdoAAIHfDW1gVD6fH3++7jBkN0a68CA0AKqhR16tRtCngPgNCvwJ6zb8HyVWr26yiRzb657wJBEmwckpYE3s0NmXcJM=
Received: from BN6PR13MB1844.namprd13.prod.outlook.com (10.171.180.8) by
 BN6PR13MB1716.namprd13.prod.outlook.com (10.171.174.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.5; Wed, 15 May 2019 14:38:51 +0000
Received: from BN6PR13MB1844.namprd13.prod.outlook.com
 ([fe80::281c:9b1c:5cdd:bad7]) by BN6PR13MB1844.namprd13.prod.outlook.com
 ([fe80::281c:9b1c:5cdd:bad7%10]) with mapi id 15.20.1900.010; Wed, 15 May
 2019 14:38:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "steved@redhat.com" <steved@redhat.com>
Subject: Re: [RFC PATCH 0/5] Add a chroot option to nfs.conf
Thread-Topic: [RFC PATCH 0/5] Add a chroot option to nfs.conf
Thread-Index: AQHVCpX1sbmXWB4h6EGExdCXloMSiaZsOCIAgAAKg4A=
Date:   Wed, 15 May 2019 14:38:50 +0000
Message-ID: <fc8f468f9f9086d8be51d570916fda330a42bbee.camel@hammerspace.com>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
         <20190515140112.GA9291@fieldses.org>
In-Reply-To: <20190515140112.GA9291@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [209.17.40.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 822348f8-b6fd-496a-98c7-08d6d9430c4e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR13MB1716;
x-ms-traffictypediagnostic: BN6PR13MB1716:
x-microsoft-antispam-prvs: <BN6PR13MB17165663DBB4658D1A0774BFB8090@BN6PR13MB1716.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(376002)(366004)(346002)(189003)(199004)(86362001)(2351001)(11346002)(476003)(446003)(486006)(256004)(2616005)(71200400001)(71190400001)(5660300002)(66556008)(186003)(66476007)(26005)(66446008)(64756008)(66946007)(73956011)(2906002)(6512007)(5640700003)(305945005)(7736002)(76116006)(91956017)(3846002)(6116002)(68736007)(25786009)(478600001)(229853002)(54906003)(6916009)(118296001)(8676002)(14454004)(6506007)(81156014)(1730700003)(6486002)(6436002)(76176011)(81166006)(102836004)(99286004)(66066001)(36756003)(2501003)(4326008)(6246003)(316002)(8936002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR13MB1716;H:BN6PR13MB1844.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RdCWHkRafK21qgkaaaCR3sB6hP7EjQYREfGdiKklTIouIW7IBDcYZgSEE8OKaJlzbzgLkm8IxUfOB1JJZX3cwxdzZHHONzs+14cie4IesXM1vWv9Vi5dZ2jVloS4sFVY/mTSautCJQmLPaO+yN5gu1DqKL5c52CzEHay3hCZ/j/uC5jFeKIvwOsBn9XM0N9Si6xditBUDrwQyDgfTsomxsTWMASplwssqCndWdN9lk+h4nWWj1wTjFdkAa6IYLkp/IG4jtODVXHLGVfwbp0bacZn7nkPNjPYaNLW08jbwb7ZHzEpTNyMtrLIAgRBor09QZcRhADA6Ql4ECzDHnEIOIxt5hpkBGtpXgz2B6N9hZQhgbWT9YAWjzmUHzV7icIgd/etst0L2Sm7j4E4Z2KnT4zRT2xkjsLTILfKRHkHT68=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B62C79F6DA0B7442A75ED532B9B2CDD6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822348f8-b6fd-496a-98c7-08d6d9430c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 14:38:50.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1716
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTE1IGF0IDEwOjAxIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgTWF5IDE0LCAyMDE5IGF0IDA0OjQxOjQ4UE0gLTA0MDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBUaGUgZm9sbG93aW5nIHBhdGNoc2V0IGFpbXMgdG8gYWxsb3cgdGhl
IGNvbmZpZ3VyYXRpb24gb2YgYSAnY2hyb290DQo+ID4gamFpbCcgdG8gcnBjLm5mc2QsIGFuZCBh
bGxvd2luZyB1cyB0byBleHBvcnQgYSBmaWxlc3lzdGVtIC9mb28gKGFuZA0KPiA+IHBvc3NpYmx5
IHN1YnRyZWVzKSBhcyAnLycuDQo+IA0KPiBUaGlzIGlzIGdyZWF0LCB0aGFua3MhICBZZWFycyBh
Z28gSSBkaWQgYW4gaW5jb21wbGV0ZSB2ZXJzaW9uIHRoYXQNCj4gd29ya2VkIGJ5IGp1c3Qgc3Ry
aW5nIG1hbmlwdWxhdGlvbnMgb24gcGF0aHMuICBSdW5uaW5nIHBhcnQgb2YgbW91bnRkDQo+IGlu
DQo+IGEgY2hyb290ZWQgdGhyZWFkIGlzIGEgbmVhdCB3YXkgdG8gZG8gaXQuDQo+IA0KPiBJZiBJ
IHVuZGVyc3RhbmQgcmlnaHQsIHRoZSBvbmx5IHBhcnQgdGhhdCdzIGJlaW5nIHJ1biBpbiBhIGNo
cm9vdCBpcw0KPiB0aGUNCj4gd3JpdGVzIHRvIC9wcm9jL25ldC9zdW5ycGMvKi9jaGFubmVsIGZp
bGVzLiAgU28gdGhhdCBtZWFucyB0aGF0IHRoZQ0KPiBwYXRoDQo+IGluY2x1ZGVkIGluIHdyaXRl
cyB0byAvcHJvYy9uZXQvc3VucnBjL25mc2RfZmgvY2hhbm5lbCB3aWxsIGJlDQo+IHJlc29sdmVk
DQo+IHdpdGggcmVzcGVjdCB0byB0aGUgY2hyb290IGJ5IHRoZSBrZXJuZWwgY29kZSBoYW5kbGlu
ZyB0aGUgd3JpdGUuDQo+IA0KPiBUaGF0J3Mgbm90IHRoZSBvbmx5IHBsYWNlIGluIG1vdW50ZCB0
aGF0IHVzZXMgZXhwb3J0IHBhdGhzLCB0aG91Z2guDQo+IFdoYXQgYWJvdXQ6DQo+IA0KPiAJLSBu
ZXh0X21udCgpLCB3aGljaCBjb21wYXJlcyBwYXRocyBmcm9tIHRoZSBleHBvcnQgZmlsZSB0bw0K
PiBwYXRocw0KPiAJICBpbiAvZXRjL210YWIuDQo+IAktIGlzX21vdW50cG9pbnQsIHdoaWNoIHN0
YXRzIGV4cG9ydCBwYXRocy4NCj4gCS0gbWF0Y2hfZnNpZCwgd2hpY2ggc3RhdHMgZXhwb3J0IHBh
dGhzLg0KPiANCj4gRXRjLiAgRG9lc24ndCB0aGF0IHN0dWZmIGFsc28gbmVlZCB0byBiZSBkb25l
IHdpdGggcmVzcGVjdCB0byB0aGUNCj4gY2hyb290PyAgQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8N
Cj4gDQoNCkdvb2QgZmVlZGJhY2suIFRoYW5rcyENCg0KWWVzLCBJIGRvIG5lZWQgdG8gZml4IHVw
IHRob3NlIGNvbXBhcmlzb25zIHRvby4gSSBzdXNwZWN0IHRoYXQgd2Ugd2FudA0KdG8gZG8gdGhl
IHN0YXQoKSBpbiB0aGUgY2hyb290ZWQgbmFtZXNwYWNlIHNvIHRoYXQgd2UgcmVzb2x2ZSBzeW1s
aW5rcw0KZXRjIGNvcnJlY3RseS4gVGhhdCBzaG91bGQgYmUgZWFzeSB0byBhZGQ6IHRoZSB3b3Jr
cXVldWUgaW1wbGVtZW50YXRpb24NCmlzIGdlbmVyaWMsIHNvIGFkZGluZyBhIG5ldyBvcGVyYXRp
b24gaXMgcHJldHR5IHRyaXZpYWwuDQoNCkZvciB0aGUgcGF0aCBjb21wYXJpc29ucyBpbiBuZXh0
X21udCgpLCB0aGluZ3MgYXJlIGEgbGl0dGxlIG11cmtpZXIuDQpJJ20gbm90IG92ZXJseSBoYXBw
eSB3aXRoIGEgc29sdXRpb24gd2hlcmUgdXNlciBzcGFjZSB0cmllcyB0byByZXNvbHZlDQpwYXRo
cyBiZWNhdXNlIHRoZSBwcmVzZW5jZSBvZiBzeW1saW5rcywgYmluZCBtb3VudHMsIGV0YyBjYW4g
YW5kIGRvDQptZWFuIHRoYXQgdXNlciBzcGFjZSB3aWxsIGdldCB0aGF0IHdyb25nLiBQZXJoYXBz
IHRoZSByaWdodCBzb2x1dGlvbiBpcw0KdG8gZG8gYW4gb3BlbigpIGFuZCBjaGVjayB0aGF0IGl0
IGVuZHMgdXAgaW4gdGhlIHJpZ2h0IHBsYWNlIChpLmUuDQpjaGVjayB0aGUgZnNpZC9pbm9kZSBu
dW1iZXIgd2l0aCBhIGZzdGF0KCkpPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
