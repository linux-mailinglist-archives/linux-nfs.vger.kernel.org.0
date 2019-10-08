Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9CCF9D0
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2019 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfJHMcD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Oct 2019 08:32:03 -0400
Received: from mail-eopbgr700138.outbound.protection.outlook.com ([40.107.70.138]:21728
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730834AbfJHMcC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Oct 2019 08:32:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RedTaPdtavZgs1B0cBYIMWqt4TJca3/GhJwdvIi31ofLuUfwWHHDyNgB24Ic9Zj0QqZwPHUSj3b2HjMlUX/L6O1t0evLfKZlRwmDwkWsGgMBrYrPalpNlQwQWdR2wED1nk/MiubQca46AWOh6MZ8wHX/7Xx92DF5SmxsV2JxrCwTu3d+lN3ZFoEcMlg7alIRa4fItGhRA1ewtgoqUN+TmbR8xQhlQotQTh48HhgxQZFj5aGOA9pMQdJoKV/cZgxmPXu07AgdmSyvDVwKIBcKqTK0P5HEKsry3Cbn4TsXScG557HZosprbl3THBsW6GRxTkPb18nH5MxR244yvjJ5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoThyTATPHVCGXSqKYbYLwq38FXgtUNWxH9TSSE/5NE=;
 b=fai4Bc92HaAeyXFukOv3JFh8po17ugG7GtXB3mU353PeD4gjDACoSq/Ez7jwEmH7FaVN/OQsb+1EYLxIzCFMjpAItNOn2wvkvpzcSAVRRaQxf9QLsyFHYCedSS0rsuo9LPH6Pw6b3qpMU1nRRgALk9209oI4Eo9IpY13u7BCgmoIfMyEpnDvon9a3OO64tI1X6IAGDKvfyXwA8JSoO967Z4J4JtSoOlgRXTUHxaP29ZbFfS2foY7eo3cMGoFA6RGXhjg9LN4QhcFL12M+DVOtko2Oa8Wu4ILzgFcu3RZ0EKBlhH0dE8AuwAhkULNeg3cf8dUYF/HzYRRHitPJpeeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoThyTATPHVCGXSqKYbYLwq38FXgtUNWxH9TSSE/5NE=;
 b=RRwTykZ852hTVF89PrNUI/Hv0Dxbxu1PrDNrDEhwBDsygebHQtTOD7OD4XE8Y8A5rzl8kZO+JnPS6KR867EQl9PLlFTy3mVLsVS/+EawLq7bCrb6bF5p2Jzds70K/fw+t7DDLxgHCqhjD+igzYRB83nyfeWKPUOe7rmoP/NI/dQ=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0939.namprd13.prod.outlook.com (10.168.239.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.13; Tue, 8 Oct 2019 12:31:58 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e%10]) with mapi id 15.20.2347.015; Tue, 8 Oct 2019
 12:31:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
Thread-Topic: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
Thread-Index: AQHVdDLYBQhYO0+XeUeeglb5KXlRoKdLVoQAgADNdgCAAAf7AIAD49yAgACwhQA=
Date:   Tue, 8 Oct 2019 12:31:58 +0000
Message-ID: <6bcba56d1f7888e46d4b69a7ab9f7b7554def07f.camel@hammerspace.com>
References: <1569479378-128669-1-git-send-email-zhangxiaoxu5@huawei.com>
         <08ce0101-e8df-509a-f3e5-07063aa5492e@huawei.com>
         <5c50a4be3562877a5d96523e943b9976a3792e23.camel@hammerspace.com>
         <cb955e718bd3c62f9c23661e95db77efa65d7177.camel@hammerspace.com>
         <4096d9e4-f6a2-b1e1-4f52-81cf44fc4a1f@huawei.com>
In-Reply-To: <4096d9e4-f6a2-b1e1-4f52-81cf44fc4a1f@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76e8a35a-59d0-4144-f010-08d74beb834c
x-ms-traffictypediagnostic: DM5PR13MB0939:
x-microsoft-antispam-prvs: <DM5PR13MB0939FC903BF7E41CAAD27BC8B89A0@DM5PR13MB0939.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39830400003)(376002)(51914003)(189003)(199004)(186003)(3846002)(6116002)(76176011)(7736002)(66066001)(2201001)(36756003)(118296001)(86362001)(8936002)(99286004)(26005)(81166006)(8676002)(81156014)(102836004)(5660300002)(486006)(305945005)(446003)(2906002)(6506007)(2501003)(2616005)(476003)(11346002)(66946007)(14444005)(256004)(14454004)(6246003)(478600001)(229853002)(25786009)(110136005)(6512007)(91956017)(76116006)(66446008)(64756008)(71190400001)(6436002)(66476007)(71200400001)(66556008)(316002)(6486002)(76704002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0939;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3JfTLCfNbzy4MFsmurDHeB4JnpSg22hzZxHU45UIyjlThBpfuiW3EICs+Yfij8lfLPJOdtq5L0ksZf92G+0kK0ZPB4KhLzxE+qftc0n4PhiQE9QDXWJsFQjmKMu/zcz0/6vDI1sIkMwcwBKtLTm0zKmyXNAyKZH+c40LNqr66UWEcOR46MByv9i2jdIoUmCRneY5T/qkOnPD8PWIzUJIDjNYjz9FJm2vOw69NXSxP+rmkAlt0Dh/NJIXXkIcWmF2DE+GAKS2CJwZYclM6SzzZTIu+qrXqMviA/4gIo0tuInfv4vg7QMeXIt1eA7o8CwiGmh7UQP9Q7NuPbd1z2KjSbGHog5h6hU+WTVEvaaVB1pTqEsygTbA1CYyca87R1HWsmW63qktk5cFZi+zJCXBuwNjOu+9tdPg6EgXe/L+P8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <31C29B77CFBB554FB6CBBC024779DB07@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e8a35a-59d0-4144-f010-08d74beb834c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 12:31:58.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gQzDQu2lE32plNsSTxedULX1pmSNv0aMs6kqlTg/lHXp9FadoUwjoHQCuXQBpLYHEeeGTC/wvtBUfugUtsoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0939
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTA4IGF0IDEwOjAwICswODAwLCB6aGFuZ3hpYW94dSAoQSkgd3JvdGU6
DQo+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+IA0KPiBJIHRoaW5rIFBHX1JFTU9WRSBhbmQg
UEdfSU5PREVfUkVGIGNhbid0IGJlIGJvdGggc2V0dGVkIGV4Y2VwdCBpbg0KPiAnbmZzX2lub2Rl
X3JlbW92ZV9yZXF1ZXN0JyBmdW5jdGlvbi4NCj4gDQo+IG5mc19pbm9kZV9yZW1vdmVfcmVxdWVz
dA0KPiAJLy8gbWF5YmUgc2V0IFBHX1JFTU9WRSBoZXJlLg0KPiAJbmZzX3BhZ2VfZ3JvdXBfc3lu
Y19vbl9iaXQocmVxLCBQR19SRU1PVkUpDQo+IAkJbmZzX3BhZ2VfZ3JvdXBfbG9jayhyZXEpOw0K
PiAJCW5mc19wYWdlX2dyb3VwX3N5bmNfb25fYml0X2xvY2tlZA0KPiAJCQlXQVJOX09OX09OQ0Uo
dGVzdF9hbmRfc2V0X2JpdChiaXQsICZyZXEtDQo+ID53Yl9mbGFncykpOw0KPiAJCW5mc19wYWdl
X2dyb3VwX3VubG9jayhyZXEpOw0KPiAJLy8gQnV0IGFsc28gY2xlYXIgdGhlIFBHX0lOT0RFX1JF
RiBmbGFnLg0KPiAJdGVzdF9hbmRfY2xlYXJfYml0KFBHX0lOT0RFX1JFRiwgJnJlcS0+d2JfZmxh
Z3MpDQo+IA0KPiAnbmZzX2xvY2tfYW5kX2pvaW5fcmVxdWVzdHMnIGFsc28gbmVlZCB0aGUgUEdf
SEVBRExPQ0sgZmxhZzoNCj4gDQo+IG5mc19sb2NrX2FuZF9qb2luX3JlcXVlc3RzDQo+IAluZnNf
cGFnZV9ncm91cF9sb2NrKGhlYWQpOw0KPiAJCXRlc3RfYW5kX2NsZWFyX2JpdChQR19SRU1PVkUs
ICZoZWFkLT53Yl9mbGFncykNCj4gCW5mc19wYWdlX2dyb3VwX3VubG9jayhoZWFkKTsNCg0KRmFp
ciBlbm91Z2gsIGFuZCB0aGUgcmFjZSBiZXR3ZWVuIG5mc19pbm9kZV9yZW1vdmVfcmVxdWVzdCgp
IGFuZA0KbmZzX2xvY2tfYW5kX2pvaW5fcmVxdWVzdHMoKSB3aXRoIHRoZSBzZXR0aW5nIG9mIFBH
X1JFTU9WRSBhbmQgdGhlDQpjbGVhcmluZyBvbiBQR19JTk9ERV9SRUYgaXMgcHJldmVudGVkIGJ5
IHRoZSBwcmVzZW5jZSBvZiB0aGUgUEdfTE9DSy4NCg0KT0suIEkgYWdyZWUgd2l0aCB0aGF0IGFy
Z3VtZW50LiBUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbiENCg0KQ2hlZXJzDQogIFRyb25kDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
