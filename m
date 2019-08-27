Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4396C9EC26
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfH0PPl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 11:15:41 -0400
Received: from mail-eopbgr700106.outbound.protection.outlook.com ([40.107.70.106]:53472
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbfH0PPl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:15:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGt0cAmC5a8zWmaDlnetWNH6v1R3rULR81PCc5O1ttrh60bPZZ9YEHR8CIx7+zijXCWStIt9Te271x+rLTp7Q0FKsLVFsQkhNgemJTIkoNKLXEu+gkYNULr+jDTnkJe/WYhPKH7wWfQnIOZBFiu2wz4VUYHTGzDdXGg6BBvNiEC9Pl3qCc3buHt0cRuh52c6+hE6IcC/yGf48s+/V0VLBekj+iBSV+Kuvpx4A5Eo0f8/SKaSgHZQSYBxP2k8evwgRravP7WIjjEaxRZAPQlDQKV94ZcJnbzO2cn67gvkZFrFTcBY70vztZ3qx8Cd0WV6Tq8ZjbNmksgYAdXuKREO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9TQffmatEXLg51oUoycEnfdyW6wi6Dad38gt+w22DY=;
 b=Iml0uWKM0Z1uNe5pq0iLt5yduZk5rU2pRT+lAi8EY4fJtcSA3md1cGuk/f+ndxV/4p3l24EFON1aQZZVm14dTVCOlV0QL8ErwkGtTh+9vm2nfCAPbxwmvJRDYXNt7MXUkl/ACwXewAap+G7aXuGhXpyNLSYNtdaFggv4U+8hoqVr0V0VgIHXEJc7zNMVFi4904YDGs9Ld0ovge3Sb0HmjK8SOkzjKE++Awvosx+FQ+sL+1ncRxjrqxwuZimuGDxwQ6Ol2pOY7w8ijDV5Sg0wOJtjIexGu1lgGAjPR7H2jZIjYL2HlFnr2sLHMRUyPlXS8ZAcTKwLbOaBgrG+TFmSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9TQffmatEXLg51oUoycEnfdyW6wi6Dad38gt+w22DY=;
 b=SqxSTPg3e/3n/9tkf69yiuN5qeAhLO37l8M52Tx5m5jx+PsCJ6dln7lqHDE7o6Awx+CmivOWWN1Lh4dMDTgAi082v8wcjAAZqu5Rg4oqkG5T+Sqi0PJD/thoTnI8r4FoPHSdruPh3QGaozkfMaH6whnDH85HKGQv/rUq2SnUu+4=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1577.namprd13.prod.outlook.com (10.175.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Tue, 27 Aug 2019 15:15:36 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 15:15:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@poochiereds.net" <jlayton@poochiereds.net>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Topic: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Index: AQHVXC7WXUD5cV8FEUS4EYbsSk6I0qcN59MAgAAC84CAARwhgIAADvgAgAABfYCAAAA/AIAABJIA
Date:   Tue, 27 Aug 2019 15:15:35 +0000
Message-ID: <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
         <20190826205156.GA27834@fieldses.org>
         <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
         <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
         <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
         <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
In-Reply-To: <20190827145912.GC9804@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a76a2124-ee98-4540-d1e3-08d72b01698e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1577;
x-ms-traffictypediagnostic: DM5PR13MB1577:
x-microsoft-antispam-prvs: <DM5PR13MB15770010753235D39256F07FB8A00@DM5PR13MB1577.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(366004)(346002)(376002)(136003)(189003)(199004)(86362001)(71190400001)(486006)(5640700003)(76116006)(66476007)(66556008)(64756008)(66446008)(26005)(102836004)(2351001)(186003)(91956017)(229853002)(66066001)(118296001)(54906003)(81156014)(1730700003)(81166006)(8676002)(8936002)(71200400001)(478600001)(66946007)(14454004)(6116002)(3846002)(7736002)(305945005)(6506007)(446003)(36756003)(4326008)(5660300002)(6246003)(11346002)(2616005)(76176011)(316002)(256004)(2501003)(6512007)(476003)(2906002)(53936002)(99286004)(6486002)(6436002)(6916009)(25786009)(17423001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1577;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z0Okpsa3Cb955JZBJTsgv62O48XpRUhQbqwgNV/cI4OGZcTfg8sm3hkL2soExT1HcyauHagelK7jLzVxsUq9Zz92CZwO4NUocUmnG1Zixq7bHKE0VsPsp9hSltj5k7fCvg+Um5T89i0PgLV+bNcHeMJS1LVqYkKUcAoORL7o86iFUmFTDThSLPNnbZ1Bss/VnIeFgCKBDZMBAGkhZgEUl6EOeka+o6jkQssM2C4+ex40qRM43w0+SUCg/gM7a8l3HeeL7Fiy0W/MMiYyfJD+bLpgR3wcXO4zRPRIwyNCGVAX+wD6COL0WVrgOQq5KpYg0D3aYHXTNE9mlU/TAaS/TA2BE91Bleb3C7uYHal8uAdiiEbjFlk52UL04R0WJQYdM8uH04FNGMtGq1NC3ptXdwnE/RocEN0L5OLhuVuiEB8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <67087AD39AA4944BA5AEABF1EFEA48D1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76a2124-ee98-4540-d1e3-08d72b01698e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 15:15:36.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bw4Ff5gqxzW7GvvqH4qqmCFAVaVZB3hi44kqyQiU2vz22mXdILYsrGu0wGE+cOuUVvb0VoY30kmmrr3dWcNKKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1577
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDEwOjU5IC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgMTA6NTg6MTlBTSAtMDQwMCwgYmZpZWxk
c0BmaWVsZHNlcy5vcmcgd3JvdGU6DQo+ID4gT24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgMDI6NTM6
MDFQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gVGhlIG9uZSBwcm9ibGVt
IGlzIHRoYXQgdGhlIGxvb3BpbmcgZm9yZXZlciBjbGllbnQgY2FuIGNhdXNlDQo+ID4gPiBvdGhl
cg0KPiA+ID4gY2xpZW50cyB0byBsb29wIGZvcmV2ZXIgb24gdGhlaXIgb3RoZXJ3aXNlIHN1Y2Nl
c3NmdWwgd3JpdGVzIG9uDQo+ID4gPiBvdGhlcg0KPiA+ID4gZmlsZXMuDQo+ID4gDQo+ID4gWWVh
aCwgdGhhdCdzIHRoZSBjYXNlIEkgd2FzIHdvbmRlcmluZyBhYm91dC4NCj4gPiANCj4gPiA+IFRo
YXQncyBiYWQsIGJ1dCBhZ2FpbiwgdGhhdCdzIGR1ZSB0byBjbGllbnQgYmVoYXZpb3VyIHRoYXQg
aXMNCj4gPiA+IHRveGljIGV2ZW4gdG9kYXkuDQo+ID4gDQo+ID4gU28gbXkgd29ycnkgd2FzIHRo
YXQgaWYgd3JpdGUgZXJyb3JzIGFyZSByYXJlIGFuZCB0aGUgY29uc2VxdWVuY2VzDQo+ID4gb2YN
Cj4gPiB0aGUgc2luZ2xlIGNsaWVudCBsb29waW5nIGZvcmV2ZXIgYXJlIHJlbGF0aXZlbHkgbWls
ZCwgdGhlbiB0aGVyZQ0KPiA+IG1pZ2h0DQo+ID4gYmUgZGVwbG95ZWQgY2xpZW50cyB0aGF0IGdl
dCBhd2F5IHdpdGggdGhhdCBiZWhhdmlvci4NCj4gPiANCj4gPiBCdXQgbWF5YmUgdGhlIGJlaGF2
aW9yJ3MgYSBsb3QgbW9yZSAidG94aWMiIHRoYW4gSSBpbWFnaW5lZCwgaGVuY2UNCj4gPiB1bmxp
a2VseSB0byBiZSB2ZXJ5IGNvbW1vbi4NCj4gDQo+IChBbmQsIHRvIGJlIGNsZWFyLCBJIGxpa2Ug
dGhlIGlkZWEsIGp1c3QgbWFraW5nIHN1cmUgSSdtIG5vdA0KPiBvdmVybG9va2luZw0KPiBhbnkg
cHJvYmxlbXMuLi4uKQ0KPiANCkknbSBvcGVuIHRvIG90aGVyIHN1Z2dlc3Rpb25zLCBidXQgSSdt
IGhhdmluZyB0cm91YmxlIGZpbmRpbmcgb25lIHRoYXQNCmNhbiBzY2FsZSBjb3JyZWN0bHkgKGku
ZS4gbm90IHJlcXVpcmUgcGVyLWNsaWVudCB0cmFja2luZyksIHByZXZlbnQNCnNpbGVudCBjb3Jy
dXB0aW9uIChieSBjYXVzaW5nIGNsaWVudHMgdG8gbWlzcyBlcnJvcnMpLCB3aGlsZSBub3QNCnJl
bHlpbmcgb24gb3B0aW9uYWwgZmVhdHVyZXMgdGhhdCBtYXkgbm90IGJlIGltcGxlbWVudGVkIGJ5
IGFsbCBORlN2Mw0KY2xpZW50cyAoZS5nLiBwZXItZmlsZSB3cml0ZSB2ZXJpZmllcnMgYXJlIG5v
dCBpbXBsZW1lbnRlZCBieSAqQlNEKS4NCg0KVGhhdCBzYWlkLCBpdCBzZWVtcyB0byBtZSB0aGF0
IHRvIGRvIG5vdGhpbmcgc2hvdWxkIG5vdCBiZSBhbiBvcHRpb24sDQphcyB0aGF0IHdvdWxkIGlt
cGx5IHRvbGVyYXRpbmcgc2lsZW50IGNvcnJ1cHRpb24gb2YgZmlsZSBkYXRhLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
