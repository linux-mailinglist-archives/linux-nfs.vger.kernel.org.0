Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070C813DD89
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgAPOf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 09:35:29 -0500
Received: from mail-eopbgr760135.outbound.protection.outlook.com ([40.107.76.135]:46148
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbgAPOf2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Jan 2020 09:35:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN2OYaaarmCSgx98gx4cYdsQgVI5IUw48/zIuIfQpCzMXO26S4gOvJRzvsiMK2aEvVa+UANv8t6ZzD4fGtj9jHtUBvCVdB12uBj76Z/4uwa2m33+xNqeccvtMDGMQPMmJ3RBR6WKOmIRiGzEk8FW7tX6Ftkanm+ycntTao+IqVXzu7CgCdhqHDl30Ih29kVvCLHubWwBKmWcDk3ni9Ko2qEdkLpdlLqbqskrcdTzHqDgdg6pjYxKWf4WV7GkFVVMSWXngbb4pORpZiusV4zZBcoN9DzL7U6ti6pfz8LjCO/F7ApF/MwBCxcPkJdajyDgsIyfJGJSOeXqT0XeZWqCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXRN0a8/zJMASfYBuh4hqzbErZQMPCOQCPfmWSy3uno=;
 b=oYX9O0wjJ6HTDPu49r/EbnZtvGuZwGLyK6x4XVp/2kIggpsPVe2YuJ9PSvswv645YwsnSHuQ8H3vk4Puk19YnCWFZCLXxHlXcL/qhzoVx6AzfXYA/X7/n1dOL1m+6JJaVBBlVcWSy7CNKl5ze5q6+uGvETZQVxBUm9axkKR4hnaPz8W+InDdUz4i6jMz/kXDD4uIdr2R3qMBAitTlgxfpQ6kc2hKDE08UMTm4NfAKbEqSdCWDJZxBZh9ExRmBp2oshkoYLLMZtt8T1JvLd7rGGDvtQkOrD7phA/Xsv4pvSY+6ARhX10wb28ZvWya6A30KJDHAm6JIhctgF4VADJv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXRN0a8/zJMASfYBuh4hqzbErZQMPCOQCPfmWSy3uno=;
 b=RZuoY9Td2ywDMJcGsosXtziiSPMKGTvzF9lcTlPar+bcZ59Dr3lZvpXjm1wf3s6n/O1/1GCSFQ4tZRaKaF2qItOzO5HaWm8i+Iu0zYjpyj+s67Y0dhmB8sbcT51Vc24aohNJLGJjm5GxjVgBJm62zkMHRHFWW/zOvtVztbR+5UE=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1930.namprd13.prod.outlook.com (10.174.187.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.12; Thu, 16 Jan 2020 14:35:25 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.021; Thu, 16 Jan 2020
 14:35:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Lookup revalidation for OPEN_CLAIM_FH
Thread-Topic: Lookup revalidation for OPEN_CLAIM_FH
Thread-Index: AQHVzHQOQmnjbX8Fb0WPSO1cRvS5YaftW3aA
Date:   Thu, 16 Jan 2020 14:35:25 +0000
Message-ID: <7eae4162d7c8a85bbb7fddab3a818472ec2ebc54.camel@hammerspace.com>
References: <31B20BC3-A089-47F9-9821-7A3543FF7413@redhat.com>
In-Reply-To: <31B20BC3-A089-47F9-9821-7A3543FF7413@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f873ae6-a4ea-490d-afff-08d79a915360
x-ms-traffictypediagnostic: DM5PR1301MB1930:
x-microsoft-antispam-prvs: <DM5PR1301MB1930FC16923C09A1A2D22229B8360@DM5PR1301MB1930.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(6506007)(86362001)(36756003)(316002)(6916009)(8936002)(4326008)(64756008)(66946007)(81166006)(66446008)(186003)(2616005)(478600001)(66556008)(8676002)(6486002)(91956017)(26005)(5660300002)(2906002)(76116006)(71200400001)(6512007)(66476007)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1930;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y11LLoQpNDn7Bxstu8pAaL6W/FIhOVhfAyIWjyRTyNtbZUEFkTNY7dp+vkQZL31J/Vql+uq+PkZzwcQaDRrXQdM61mXaaZGVcSLVc8QESyWgSztWw0BsATtTzXKr+YYSkeuyiEEsuaNQhW2Pz2lHeexfKiMouborWr8YPItpwqYkTcyjJRWOf3mHm7S+Rg6FsyrEP9ivECjGuUgIUs9NNA3Ffe1nGkl5ZBYQGFbmOETCpiil8484gQqxVZyxoWGaOE2giDC0GgkOzrpFm1Gf627WEsVn8Cmx10nNnbT2KIztMtvqZChr4j3xg58d3Xsmn7mtHLAgiu2+vV457SPGNw/CoU9HDTsRZCtIsnyHodvpRJP1LvmMZnXWAoxx7copp3vwifvVN0bqunOf3YGkzPOV1eLzwTu4K808XnrRodoZh1uS4Gw+Mjgf8OxkSxy2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F02FBB3902214E478FC21AB2B1BFCB3F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f873ae6-a4ea-490d-afff-08d79a915360
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 14:35:25.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vC4WWgd4XYuQnJVI5pBfelgB5Y2OcAh0RVmLiNkuZcWgfIl5tkK87UMd4Xa3K3E5mawrkf9+Y0rY14FZUiFtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1930
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDA4OjUxIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBIaSBUcm9uZCwNCj4gDQo+IEknZCBsaWtlIHRvIGZpeCB1cCBsb29rdXAgcmV2YWxp
ZGF0aW9uIGZvciB2NC4xKyB3aGVuIHRoZSBjbGllbnQgaXMNCj4gdXNpbmcNCj4gT1BFTl9DTEFJ
TV9GSC4gIFRoZSBmaXhlcyBhIHdoaWxlIGJhY2sgZm9yIFN0YW4gSHUncyBjYXNlIGRvIG5vdCBz
ZWVtDQo+IHRvDQo+IGltcHJvdmUgdGhpbmdzIGZvciB2NC4xLCBhbmQgYWN0dWFsbHkgbWFrZSB0
aGUgYmVoYXZpb3IgYSBiaXQgd29yc2UNCj4gc2luY2Ugd2UNCj4gbm8gbG9uZ2VyIHBhc3MgdGhy
b3VnaCBuZnNfbG9va3VwX3ZlcmlmeV9pbm9kZSgpLCB3aGljaCB3b3VsZCBjYXRjaA0KPiB0aGUN
Cj4gY2FzZXMgd2hlcmUgbmxpbmsgPT0gMC4NCj4gDQo+IFdvdWxkIHlvdSBhY2NlcHQgd29yayB0
byBfYWx3YXlzXyByZXZhbGlkYXRlIHRoZSBkZW50cnkncyBwYXJlbnQgZm9yDQo+IENMQUlNX0ZI
PyAgQWx0ZXJuYXRpdmVseSwgaXQgc2VlbXMgdGhhdCBDTEFJTV9OVUxMIHdvdWxkIGJlDQo+IHBy
ZWZlcmFibGUgZm9yDQo+IHRoaXMgY2FzZSwgdGhvdWdoIEkgZG9uJ3Qga25vdyBob3cgdGhlIGNs
aWVudCB3b3VsZCBrbm93IHdoZW4gdG8NCj4gZGVjaWRlDQo+IGJldHdlZW4gdGhlbS4NCj4NCj4g
SGVyZSdzIGEgc2ltcGxlIHJlcHJvZHVjZXIgZm9yIGNvbnZlbmllbmNlLCBJIHRoaW5rIHdlJ3Zl
IGFscmVhZHkgYWxsDQo+IGFncmVlZA0KPiB0aGF0IHRoZSBiZWhhdmlvciB3ZSB3YW50IGlzIGZv
ciB0aGUgc2Vjb25kIG9wZW4gYnkgYGNhdGAgdG8gcmVmbGVjdA0KPiB0aGUNCj4gcmVzdWx0cyBv
ZiB0aGUgbW92ZSBvbiB0aGUgc2VydmVyLCBvciBhdCBsZWFzdCBldmVudHVhbGx5IGxhdGVyIG9w
ZW5zDQo+IHdvdWxkDQo+IHJldmFsaWRhdGUgdGhlIGRlbnRyeToNCj4NCj4gIyEvYmluL2Jhc2gN
Cj4gDQo+IHNldCAtbyB4dHJhY2UNCj4gdmVycz00LjENCj4gDQo+IGV4cG9ydGZzIC11YQ0KPiBl
eHBvcnRmcyAtbyBydyxzZWM9c3lzLG5vX3Jvb3Rfc3F1YXNoICo6L2V4cG9ydHMNCj4gDQo+IG1r
ZGlyIC9tbnQvbG9jYWxob3N0IHx8IHRydWUNCj4gDQo+IHJtIC1mIC9leHBvcnRzL2ZpbGV7MSwy
fQ0KPiANCj4gZWNobyB0aGlzIGlzIGZpbGUgMSA+IC9leHBvcnRzL2ZpbGUxDQo+IGVjaG8gdGhp
cyBpcyBmaWxlIDIgPiAvZXhwb3J0cy9maWxlMg0KPiANCj4gbW91bnQgLXQgbmZzIC1vdiR2ZXJz
LHNlYz1zeXMgbG9jYWxob3N0Oi9leHBvcnRzIC9tbnQvbG9jYWxob3N0DQo+IA0KPiB0YWlsIC1m
IC9tbnQvbG9jYWxob3N0L2ZpbGUxICYNCj4gc2xlZXAgMQ0KPiANCj4gIyB0aGlzIGlzIGZpbGUg
MQ0KPiBjYXQgL21udC9sb2NhbGhvc3QvZmlsZTENCj4gDQo+ICMgb3ZlcndyaXRlIHRoZSBmaWxl
IG9uIHRoZSBzZXJ2ZXI6DQo+IG12IC1mIC9leHBvcnRzL2ZpbGUyIC9leHBvcnRzL2ZpbGUxDQo+
IA0KPiAjIHRoaXMgaXMgZmlsZSAyDQo+IGNhdCAvbW50L2xvY2FsaG9zdC9maWxlMQ0KPiANCj4g
a2lsbGFsbCB0YWlsDQo+ICMgdGhpcyBpcyBmaWxlIDINCj4gY2F0IC9tbnQvbG9jYWxob3N0L2Zp
bGUxDQo+IHVtb3VudCAvbW50L2xvY2FsaG9zdA0KPiANCj4gDQo+IFN3aXRjaGluZyB0aGUgJHZl
cnMgdmFyaWFibGUgYmV0d2VlbiB2NC4wIGFuZCB2NC4xIGluIHRoaXMgc2NyaXB0DQo+IHNob3dz
IHRoZQ0KPiBkaWZmZXJlbmNlIGluIGJlaGF2aW9yLg0KPiANCg0KSWYgc29tZWJvZHkgbmVlZHMg
c3Ryb25nZXIgbG9va3VwIGNhY2hlIHJldmFsaWRhdGlvbiwgdGhlbiB0aGF0J3Mgd2hhdA0KdGhl
eSBoYXZlIHRoZSAnbG9va3VwY2FjaGU9bm9uZScgbW91bnQgb3B0aW9uIGZvci4gV2UgaGF2ZSB0
aGVzZQ0KJ2xvb2t1cGNhY2hlJyBtb3VudCBvcHRpb25zIGluIG9yZGVyIHRvIGFsbG93IHVzZXJz
IHRvIHRhaWxvciB0aGUNCmNhY2hpbmcgYmVoYXZpb3VyIChvbiBhIHBlci1tb3VudCBiYXNpcykg
c2hvdWxkIHRoZSBkZWZhdWx0IGJlaGF2aW91cg0KYmUgaW5zdWZmaWNpZW50bHkgc3RyaWN0Lg0K
DQpTaW5jZSB5b3VyIHRlc3RjYXNlIGRvZXNuJ3QgdXNlIHRoYXQgbW91bnQgb3B0aW9uLCBJIGRv
bid0IHNlZSB3aGF0IGl0DQppcyBwcm92aW5nIG90aGVyIHRoYW4gd2hhdCB3ZSBhbHJlYWR5IGtu
b3cgYWJvdXQgdGhlIGRlZmF1bHQgbG9va3VwDQpjYWNoaW5nOiBuYW1lbHkgdGhhdCBpdCBzYWNy
aWZpY2VzIHNvbWUgYWNjdXJhY3kgaW4gdGhlIGludGVyZXN0IG9mDQpmaWxlIG9wZW4gcGVyZm9y
bWFuY2UuDQoNCkJ5IHRoZSB3YXksIE5GU3Y0LjEgd2lsbCBhY3R1YWxseSBoYW5kbGUgdGhpcyBz
aXR1YXRpb24gYmV0dGVyIHRoYW4NCk5GU3YzLCBzaW5jZSB0aGUgc3RhdGVmdWwgb3BlbiBlbnN1
cmVzIHRoYXQgZXZlbiBpZiB0aGUgZmlsZSB0aGF0IHdvbg0KdGhlIHJhY2Ugd2FzIGRlbGV0ZWQg
YnkgdGhlIG90aGVyIGNsaWVudCwgdGhlbiB0aGUgc2VydmVyIHdpbGwgcHJlc2VydmUNCnRoYXQg
ZmlsZSBhbmQgaXRzIGNvbnRlbnRzIHVudGlsIG91ciBjbGllbnQgY2FsbHMgY2xvc2UoKS4NCg0K
SW4gY29uY2x1c2lvbjoNCg0KICogV2l0aCBhIGRlZmF1bHQgbW91bnQgb3B0aW9uIG9mICdsb29r
dXBjYWNoZT1hbGwnLCB3ZSBkb24ndCBwcm9taXNlDQogICAxMDAlIGFjY3VyYWN5IGluIHRoZSBm
YWNlIG9mIDNyZCBwYXJ0eSBjbGllbnQgY2hhbmdlcyB0byB0aGUNCiAgIG5hbWVzcGFjZS4gV2Ug
b25seSBwcm9taXNlIHRoYXQgd2Ugd2lsbCBldmVudHVhbGx5IHBpY2sgdXAgdGhlDQogICBjaGFu
Z2VzLiBJZiB3ZSdyZSBmYWlsaW5nIHRvIGRvIHRoYXQsIHRoZW4gbGV0J3MgbG9vayBhdCB3aHks
IGJ1dA0KICAgJ2xvb2t1cGNhY2hlPWFsbCcgaXMgbm90IGd1YXJhbnRlZWQgdG8gaW1tZWRpYXRl
bHkgZmluZCBuYW1lc3BhY2UNCiAgIGNoYW5nZXMuDQoNCiAqIFdpdGggJ2xvb2t1cGNhY2hlPXBv
cycsIHdlIHByb21pc2UgdGhhdCB0aGUgY2xpZW50IHdpbGwgaWdub3JlDQogICBuZWdhdGl2ZSAg
Y2FjaGVkIGRlbnRyaWVzLCBhbmQgaGVuY2Ugd2lsbCBhbHdheXMgZmluZCBhIGZpbGUgdGhhdA0K
ICAgd2FzIGNyZWF0ZWQgdXNpbmcgZXhjbHVzaXZlIGNyZWF0ZSBvbiB0aGUgc2VydmVyLiBIb3dl
dmVyIEknZCBleHBlY3QNCiAgIHRoYXQgdG9vIHRvIGZhaWwgeW91ciB0ZXN0IGFib3ZlLg0KDQog
KiBJZiBpdCBmYWlscyB3aXRoICdsb29rdXBjYWNoZT1ub25lJywgdGhlbiBJIHdvdWxkIGFncmVl
IHRoYXQgd2UgaGF2ZQ0KICAgYSBwcm9ibGVtLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
