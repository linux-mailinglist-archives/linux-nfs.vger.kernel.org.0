Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572D713E0AB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 17:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAPQo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 11:44:58 -0500
Received: from mail-dm6nam11on2137.outbound.protection.outlook.com ([40.107.223.137]:55104
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729010AbgAPQo6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:44:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeneNDBNVde1hA6OJetjB4SrhGjV1oxkwDIlG73if7J1BsraNuCXQNVBNYWn77WW6qPcNcTNqsRdLIQloXZy3IiL4MzK7UIUsvr44KuUA5ZKwxFeiv2Qg3uCCKkoJYMfW9GolJidI5lufEZcGHEtwZNKruY8UQpsKtVsJDXdI45yiUrZxNqI4JzltlCkHuBlG2/+I126EUatHNu/CJlG08/H7WtGfqVwnb1XC/E70xgDcm5FZykviQFo2AAm0gdw6c4VQlzZ7qs2syXg7aU3mScs+wRepUnYGc2BV9+2WgbYFsr2AYkE1guxg6VaYDSB8DbgCxRLMVmJuNEUEHXm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=475eMCesv5i4OO13xzhXGRYVFpodWziFm0WaJ23jVqc=;
 b=E2pkVXF2InYVEdVk7qOOdm017pm7EWaGdZhhw6BKA2Nn25zTEuqduDZGOUjEm8KVfZdVOCXSGsikk3dPCmXdAGqBBIdxQTbY94ih0T9hreEBKnwJDqrSZzwxV37x+vHeHdUvo74dl8ZWID+pMgP7Qg+x5i9+FMVkTzUPeSWJDYCNxtFhKEO3yJ5CuoxmHFxaiE/ym1dNWJSAsvaxa9vtj4IqCoHNKEQGUfLd3IDG6qvCLo/dxan8GGjBCqH+VMvfq6GOjVqji9E0woFD6swubuEWqumAGs8Z7neEhnSBkmKttm141gPd4UuSmFPEjTg7ro8hSaTwlrFEP+mrVo9u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=475eMCesv5i4OO13xzhXGRYVFpodWziFm0WaJ23jVqc=;
 b=Ed2FDTdA33+NlWSRYCn/krg9cXW3JtYxFykmRBAx+h91w1tdZZHARk6hFJQtToVe84GXetGTcoYYMz+AxRGjiyYIyCvTujZUtLXz5hTqya0m6hjUh7v5bc0M6SBHMQd8H+etKwiL0rOs4HyWDR4twGjYR9/mXsGzVsnMlbgr/0c=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2171.namprd13.prod.outlook.com (10.174.181.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.16; Thu, 16 Jan 2020 16:44:54 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.021; Thu, 16 Jan 2020
 16:44:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2] NFS: Don't skip lookup when holding a delegation
Thread-Topic: [PATCH v2] NFS: Don't skip lookup when holding a delegation
Thread-Index: AQHVbvlhXK/ljPJmmUKulFnJAnn0pafuIqIAgAAMCICAAAhYgIAAA5iA
Date:   Thu, 16 Jan 2020 16:44:54 +0000
Message-ID: <3150bc5fb89ceccb53f4625b9e332377a3470ab4.camel@hammerspace.com>
References: <77be993185fa7f114f6856f74f2f7affb5bd411d.1568904510.git.bcodding@redhat.com>
         <6399DBA2-DA9D-40C3-80BC-6DCE94BB9C49@redhat.com>
         <d8639ad40df3b0a814e7396e1e824220c4d21a55.camel@hammerspace.com>
         <C5892E37-4731-4AD5-97FE-D8151C289CE9@redhat.com>
In-Reply-To: <C5892E37-4731-4AD5-97FE-D8151C289CE9@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e33e101c-dd70-48fe-ea0a-08d79aa36a0e
x-ms-traffictypediagnostic: DM5PR1301MB2171:
x-microsoft-antispam-prvs: <DM5PR1301MB2171C9B03A3F40D768E31434B8360@DM5PR1301MB2171.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(376002)(346002)(366004)(199004)(189003)(81156014)(66476007)(64756008)(6512007)(54906003)(66556008)(26005)(8676002)(4326008)(186003)(66446008)(81166006)(71200400001)(478600001)(36756003)(5660300002)(8936002)(2906002)(66946007)(6506007)(53546011)(6916009)(316002)(2616005)(6486002)(86362001)(91956017)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2171;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pWRW3qx6IfvpL0aV4mSV25IfyQ9/bPXFybyKcdyouX0Zf9bFxQMSiEN16AziiCF9p7bBdZs0Jvwk9wP2e0zsbMFcv3RzcVjffMwUVy/kYUKlEyr6Y4JnFrkqamYg6D66C+LKPKQ1eEG+1Glqmz/ZNCVcPwqJOHUxqMhkrUcygzEzSRXtVK3c6NelfBFCrZ3oJte3Za2t5Vud+pc6enmh7TqLZ3n5geCyWnEHrk/FYFEDqTnS3NAHUHKYP31wFR0l+aIqCmxdgBoClRUI3orYgRW25YEclBsklmcV2rQdz1ch8gNqTSNq8g20tm3Ve9Q8zrrdTXrpIgZyXmR0iv96uVGSsghVqQ+TnGLkOXVsJgWar+lnYMJsWdjJUM2lBJN037dxqTBJ4tTkPHtkLEQLczZL6qqbIYnGZc52bEoUuNAIq9fGBD7M/SifXECuTbi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A42CC49A3753EA4D96D042F131B27CA7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33e101c-dd70-48fe-ea0a-08d79aa36a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 16:44:54.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/BhDhkK380g2O3IA7DXZzBsruLQgwbRWzSFB0CNwA3popeHKW6ZNZaA5ij3/JQllmvvbdkCrE5tpi2JbPr8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2171
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDExOjMyIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBKYW4gMjAyMCwgYXQgMTE6MDIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gPiBXZSBzaG91bGQgbmVlZCB0byBwZXJmb3JtIHRoaXMgcmV2YWxpZGF0aW9uIG9uY2UsIGFu
ZCBvbmx5IG9uY2UgZm9yDQo+ID4gdGhhdCBkaXJlY3RvcnksIGFuZCBvbmx5IGlmIHdlIG9wZW5l
ZCB0aGUgZmlsZSB1c2luZyBhIENMQUlNX0ZIDQo+ID4gb3BlbiwNCj4gPiBvciBpZiB3ZSBvcGVu
ZWQgaXQgdGhyb3VnaCBhIGRpZmZlcmVudCBoYXJkIGxpbmtlZCBuYW1lIChhbmQgZGlkDQo+ID4g
bm90DQo+ID4gY3JlYXRlIHRoaXMgaGFyZCBsaW5rIGFmdGVyIHdlIGdvdCB0aGUgZGVsZWdhdGlv
bikuDQo+ID4gDQo+ID4gUGVyaGFwcyB3ZSBjb3VsZCBkZWZpbmUgYSBtYWdpYyB2YWx1ZSBmb3Ig
ZGVudHJ5LT5kX3RpbWUgdGhhdA0KPiA+IGNhdXNlcyB1cw0KPiA+IHRvIHNraXAgcmV2YWxpZGF0
aW9uIGlmIGFuZCBvbmx5IGlmIHdlIGhvbGQgYSBkZWxlZ2F0aW9uPw0KPiANCj4gQ2FuIHdlIHB1
dCB0aGUgZGVsZWdhdGlvbidzIGNoYW5nZV9hdHRyIGluIGRfdGltZSBmb3IgZGVudHJpZXMgdGhh
dA0KPiBoYXZlDQo+IGJlZW4gcmV2YWxpZGVkIHdoaWxlIGhvbGRpbmcgYSBkZWxlZ2F0aW9uPw0K
DQpXZSBjb3VsZCwgYnV0IHRoYXQgc2VlbXMgbW9yZSBjb21wbGljYXRlZCBiZWNhdXNlIGl0IG1l
YW5zIHlvdSBuZWVkIHRvDQpkZWNpZGUgd2hldGhlciB5b3UgYXJlIGNoZWNraW5nIHRoZSBwYXJl
bnQgaW5vZGUgb3IgeW91ciBvd24gaW5vZGUuDQoNCkl0IHNlZW1zIGVhc2llciB0byBqdXN0IGhh
dmUgbmZzX2ZvcmNlX2xvb2t1cF9yZXZhbGlkYXRlKCkgc2tpcCB0aGUNCm1hZ2ljIHZhbHVlIHNv
IHRoYXQgd2Uga25vdyB0aGF0IHRoZXJlIGFyZSBubyBjb2xsaXNpb25zLiBPbmNlIHRoZQ0KcmV2
YWxpZGF0aW9uIGlzIGRvbmUgb24gdGhlIGRlbnRyeSBob2xkaW5nIHRoZSBkZWxlZ2F0aW9uLCB0
aGVuIHdlIGNhbg0Kc2V0IGRlbnRyeS0+ZF90aW1lIHRvIHRoZSBtYWdpYyB2YWx1ZSwgYW5kIHdl
J3JlIGRvbmUuLi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
