Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59B15C944
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 18:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBMRQv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Feb 2020 12:16:51 -0500
Received: from mail-mw2nam10on2137.outbound.protection.outlook.com ([40.107.94.137]:19169
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbgBMRQu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 Feb 2020 12:16:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJTabr9C9oOM/4P8P74aqkeFBjaDG3JDUIcx3gQqCvF6Q8vK47U8lTMBHQIKkG6S0uOVIlKW13tzP+Y35IlLwW/KUfnYurJvmzCmW5fWfHlVFS0HIC7vizAWameb8rWXOnRNYhqI4ZYI4mUKWC44qFucJMLmM/j5Ywn9TKEzHBHk970C12nXnDZDDcWGmUzBZU/K+ty/TAxrBArJQNyOIBOfzff+7oz3knacfnH1z+7hHmaaR/wPFSCLCWVpGxSZaoXL31MjKZ0B6Hibp/pDVGCTrDR0G6W/yPElw5G+ZZ83zIYTH7HFI1lwAHn30zD3VLMBRtdicSBcOGF4PBombw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBxjZIKdYa2ZUG2nlU0CyojeHnkj9T0fHx/E8w1TYSE=;
 b=E/mMDlHWxGW88gpQ3TH9THhU25+aFvcjWq6S80PSmHHIBx8TB99XQY16PHOqydt51BsD8nkCln+snm/iSQikeO43zg8QJOMmUHXrOEaa/F6EztcuC6aMPMJSTLljhAm91JwMsrwgMlRJsW4Ys1eStS+wVeHPm91j0zb4EtCrk1hwPcagWHnS91D5mCok9yKx41GFZ9d3usYZG/jF8RpAKq618KmXA2/9fH1PmJhfOKenSx2wcYoiSbfwYeFLPfuN3vwgVDkASH1SAaHxdbWuP1T5NK7FmnTFow/a2ejBV+t+kozQWeF2+IRbbD1Zan3KX9LCKfK+zrKLqDIx6LSaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBxjZIKdYa2ZUG2nlU0CyojeHnkj9T0fHx/E8w1TYSE=;
 b=abeGdba8u89hZkjGUT1/4z9WcjqdUDaFx69ZFsSd486rtQ+qsjqrQokO6F/N57CgkAQWLVxU3shy3LzexwLwqKs3z+H8L0wdEYp4Yq5Kf7xgd8AFBmdcs4a28FUff/IWK/PbgVU3VYdDSn6ScqR1v1wY2NF7iXunYbUzMBRv7M0=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2074.namprd13.prod.outlook.com (10.174.182.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.14; Thu, 13 Feb 2020 17:16:44 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 17:16:44 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.x behavior of 'soft' in unresponsive server cases - bounded
 time for application to wait on NFS?
Thread-Topic: NFSv4.x behavior of 'soft' in unresponsive server cases -
 bounded time for application to wait on NFS?
Thread-Index: AQHV4nw8/N/W1yMg306Etax9KqAr7qgZXcCA
Date:   Thu, 13 Feb 2020 17:16:44 +0000
Message-ID: <d6986ea7f91e3c792792299a568ccc9f32d2945d.camel@hammerspace.com>
References: <CALF+zOm77MCP1QbLihn0hB65SB9JxkHEVSy8=-QgwW9H9E1Hng@mail.gmail.com>
In-Reply-To: <CALF+zOm77MCP1QbLihn0hB65SB9JxkHEVSy8=-QgwW9H9E1Hng@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c481fa0-90e3-4f18-08df-08d7b0a87ffc
x-ms-traffictypediagnostic: DM5PR1301MB2074:
x-microsoft-antispam-prvs: <DM5PR1301MB20749DEA44CBF9FF4D583BCFB81A0@DM5PR1301MB2074.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39830400003)(199004)(189003)(316002)(478600001)(186003)(2906002)(966005)(2616005)(6486002)(86362001)(71200400001)(6916009)(66946007)(64756008)(66446008)(66476007)(8936002)(5660300002)(81156014)(8676002)(81166006)(91956017)(6506007)(66556008)(76116006)(4326008)(26005)(36756003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2074;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lc1SUUpBQ2JXFeMqdmYIggZiHzLSymXDbDXBWToUbDKBjzhHkrjdTKbwIE855ZxZ/ZeABbX3TjvuAVIrxDFZTRNjouaOg/5AtR6DwPl/TiKhg6R334iaQUO8JMEoL9+zab4d+UrhLHV9QAJspujsHEk5J6NKsvRHJ252+nBzNKLFl+2bihGQ98NtVfppYFjLWNtragiu+UVG+fooQkYFR+whJRuagKEoOYxkvsnEMjmccdUGnWhvRxmnRUQnNIyVU5EtHrzaIMNFEM/etcUp/CimjqoTdwVOa54dqZ8y7Ob/d3g0jcSQ7onZ3Znzfvh9CmBgHObZEWkBoGxI7ezi4joPSSXw5NBKBhJsQXXi/q07VCZnznE8wsSYrnjTeKZARwaA48CRGWdGs+YEJBi/kMhcMyYxePCujxTaMblPC8T7/aEvq2BwsJ/UWLata5TcWnhvRMoTwbtUQPB+Vp5/v7poLzrcHe/8gjyqppBGDg1LK5Bc36GhNlVcNUKzBBG9YbCq7uDJY1UjStM25HYdRw==
x-ms-exchange-antispam-messagedata: u1qN2n8Qi9UB9pwM34Zqq5kIKTMY6E/+NpD221f6kZRA3lK5INGtGme2Oi+srqZYs7mPnyCE16MCwZdftSiWgqfcaur6xtNLe6untbupZfgpY0C8M/6fUsAYpMwYepIbviscqstTq1vQkc/UrSK00g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DE2863ED225F148B885F055E1A7457A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c481fa0-90e3-4f18-08df-08d7b0a87ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 17:16:44.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0JcOrmbiaptg9t6HwSKBLy8MYdpIXWJz04s3isQy/ePLbRaJ4CyJWArndfO6zxninGVL+xERbJkbsgGnWn+Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2074
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRGF2ZSwNCg0KT24gVGh1LCAyMDIwLTAyLTEzIGF0IDA5OjQ0IC0wNTAwLCBEYXZpZCBXeXNv
Y2hhbnNraSB3cm90ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBJJ20gZ2V0dGluZyB1cCB0byBzcGVl
ZCBvbiB5b3VyIHBhdGNoc2V0IGZyb20gbGFzdCB5ZWFyIHRpdGxlZCAiRml4DQo+IHVwIHNvZnQg
bW91bnRzIGZvciBORlN2NC54Ig0KPiBodHRwczovL3NwaW5pY3MubmV0L2xpc3RzL2xpbnV4LW5m
cy9tc2c3MjQ2Ny5odG1sDQo+IA0KPiBTcGVjaWZpY2FsbHkgSSBoYXZlIGNvbmNlcm5zIGFib3V0
IHRoaXMgcGF0Y2ggYmVjYXVzZSBhZnRlciBpdCwgc28NCj4gZmFyIEkgY2Fubm90IGZpbmQgYW55
IHdheSB0aGF0IGFuIGFwcGxpY2F0aW9uIGNhbiBhY2hpZXZlIGEgYm91bmRlZA0KPiB3YWl0IG9u
IGFuIE5GUzQgb3BlcmF0aW9uOg0KPiBlNGVjNDhkM2NjNjEgU1VOUlBDOiBNYWtlICJubyByZXRy
YW5zIHRpbWVvdXQiIHNvZnQgdGFza3MgYmVoYXZlIGxpa2UNCj4gc29mdGNvbm4gZm9yIHRpbWVv
dXRzDQo+IA0KPiBUaGUgcGF0Y2hzZXQgY2hhbmdlZCAnc29mdCcgc2VtYW50aWNzIGFuZCBJIHdh
bnQgdG8gYmUgc3VyZSBJDQo+IHVuZGVyc3RhbmQgdGhpcyBhbmQgd2hhdCB0aGUgaW50ZW5kZWQg
YmVoYXZpb3IgaXMgaW4gdGhlIGNhc2Ugb2YgYW4NCj4gdW5yZXNwb25zaXZlIHNlcnZlci4gIFNw
ZWNpZmljYWxseSBJIGFtIGludmVzdGlnYXRpbmcgVENQIGFuZCB0d28NCj4gY2FzZXM6DQo+IGEp
IHNlcnZlciBpcyByZXNwb25zaXZlIGF0IHRoZSBUQ1AgbGV2ZWwgYnV0IG5vdCBhdCB0aGUgTkZT
IGxldmVsIHRvDQo+IHNvbWUgb3BlcmF0aW9ucyAoc2xvdyBJTyAtIHJlYWQgb3IgYSB3cml0ZSkN
Cg0KVGhpcyBpcyB0aGUgY2FzZSB0aGF0IHRoZSBORlN2NCBwcm90b2NvbCBjb3ZlcnMgaW4gUkZD
NzUzMCBTZWN0aW9uDQozLjEuMS4gKCJDbGllbnQgUmV0cmFuc21pc3Npb24gQmVoYXZpb3IiKSBh
bmQgUkZDNTY2MSBTZWN0aW9uIDIuOS4yLg0KVGhlIGJlaGF2aW91ciB3ZSBhcmUgYWRvcHRpbmcg
aGVyZSBmb3IgJ3NvZnQnIGlzIHNwZWNpZmljYWxseSBkZXNpZ25lZA0KdG8gYmUgY29tcGxpYW50
IHdpdGggdGhvc2UgdHdvIHNlY3Rpb25zLg0KDQo+IGIpIHNlcnZlciBpcyBub3QgcmVzcG9uc2l2
ZSBhdCB0aGUgVENQIGxldmVsIChuZXR3b3JrIHBhcnRpdGlvbikNCj4gDQo+IFByaW1hcmlseSBJ
IGFtIHRlc3Rpbmcga2VybmVsIHY1LjUgd2l0aCAnYScgc2luY2UgSSB0aGluayAnYicgaXMNCj4g
Y292ZXJlZCBieSBhIHJlc2V0IG9mIHRoZSBjb25uZWN0aW9uIGFmdGVyIGl0IGxvb2tzIGxpa2Ug
MiBtaW51dGVzLiANCj4gSSByZWFsaXplIHRoZSBORlM0IGNsaWVudCBjYW5ub3QgcmV0cmFuc21p
dCBhbiBSUEMgcGVyIHRoZSBORlM0IFJGQy4gDQo+IEhvd2V2ZXIsIGlzIHRoZXJlIHNvbWUgd2F5
IHRvIGFjaGlldmUgYSBib3VuZGVkIHdhaXQgb2Ygc2F5ICdUJyBhbg0KPiBhcHBsaWNhdGlvbiBh
ZnRlciB0aGlzIHBhdGNoIGluIGJvdGggb2YgdGhvc2UgaW5zdGFuY2VzLCBiYXNpY2FsbHkNCj4g
c29tZXRoaW5nIGxpa2UgInNvZnQscmV0cmFucz0wLHRpbWVvPVQiPyAgSXMgdGhlcmUgYW4gb3B0
aW9uIHRvIGZvcmNlDQo+IGEgcmVzZXQgb2YgdGhlIFRDUCBjb25uZWN0aW9uIGluIGNhc2UgJ2En
IGFmdGVyIGEgc3BlY2lmaWVkIHRpbWUsIG9yDQo+IGlzIHRoaXMgaW1wb3NzaWJsZSBmb3Igc29t
ZSByZWFzb24/ICBPciBpcyB0aGUgbWluaW11bSB0aW1lb3V0IG5vdA0KPiBib3VuZGVkIGJ5IGFu
eXRoaW5nIHNwZWNpZmllZCBvbiB0aGUgbW91bnQgb3B0aW9ucyBidXQgYnkgb3RoZXINCj4gZmFj
dG9ycyBzdWNoIGFzIHNlcnZlciByZXNwb25zaXZlbmVzcyB0byBhbiBvcGVyYXRpb24gKGNhc2Ug
J2EnKSBvcg0KPiBUQ1AgY29ubmVjdGlvbiB0aW1lb3V0IC8gcmVzZXQgKGNhc2UgJ2InKT8NCj4g
DQo+IFRoYW5rcy4NCg0KWWVzLCB0aGVyZSBpcyB0aGUgb3B0aW9uIG9mIGNsb3NpbmcgdGhlIFRD
UCBzb2NrZXQgb24gdGhlIGNsaWVudC4NCkhvd2V2ZXIgdGhhdCBicmVha3MgcmVwbGF5IHNlbWFu
dGljcyBvbiBORlN2NC4wIGFuZCBpdCBqdXN0IGZvcmNlcyB1cw0KaW50byBhIGxpdmVsb2NrIHNp
dHVhdGlvbiBpbiB0aGUgY2FzZSB3aGVyZSB0aGUgc2VydmVyIGlzIHJlc3BvbnNpdmUsDQpidXQg
c2xvdy9jb25nZXN0ZWQuIFRoaXMgaXMgcGFydGljdWxhcmx5IHRydWUgb2YgTkZTdjQueCAoeD4w
KSwgd2hlcmUNCnRoZSBzZXNzaW9uIHNlbWFudGljcyBtZWFuIHRoYXQgd2UgY2Fubm90IHNlbmQg
YSBuZXcgcmVxdWVzdCBvbiB0aGUNCnNsb3QgYmVmb3JlIHRoZSBvbGQgb25lIGhhcyBjb21wbGV0
ZWQgYmVpbmcgcHJvY2Vzc2VkIGJ5IHRoZSBzZXJ2ZXIuDQoNClNvIHllcywgdGhlIG5ldyBzZW1h
bnRpY3MgYXJlIGEgY29tcHJvbWlzZSwgYnV0IHRoZXkgYXJlIGRlc2lnbmVkIHRvDQphZGRyZXNz
IHRoZSBzaXR1YXRpb25zIHdoZXJlIHRoZSBzZXJ2ZXIgcmVhbGx5IGlzIGdvbmUgYXdheSwgYW5k
IGFyZQ0KZGVzaWduZWQgdG8gYXZvaWQgb3ZlcmxvYWRpbmcgdGhlIHNlcnZlciBmdXJ0aGVyIGlu
IHNpdHVhdGlvbnMgd2hlcmUgaXQNCmlzIGFscmVhZHkgY29uZ2VzdGVkLg0KDQpDaGVlcnMNCiAg
VHJvbmQNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
