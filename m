Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB1361646
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 01:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhDOXap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 19:30:45 -0400
Received: from mail-dm6nam10on2107.outbound.protection.outlook.com ([40.107.93.107]:2496
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237446AbhDOXao (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Apr 2021 19:30:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mds9GU/YL5o+K75cBh1SYO0jBULBpC3aXrapyL5tRtzWKce6FJrnqJiw53lvdy7bHEdKbO7PLixQrWspRVv5+5Gh1WyNIeRjSI6DJjKq+NU6wptmKxVW/WbEuAKsheGVCh3ddZlXRKL4PMWnjIq8TLga078hMgTTZpACuiWCV6LoTCg/8vrW9uFzI68jHEWebF6/0RihaGNY2V/ywh8AcPTRV4slbLiZdMdoRHmdPzSMfr/QGXhPq0wG7sdqGJ+YoxSKHNN6ECLnRyD3Xb3gnbeiNZVkWG5qe98WsuprwQQmBUptj2wGsfQcLla/joDHdgaK2RzgAIEkneubn2PKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+BM3ILw2d0aCpThFIh9Lgh3EyrYRnhWQt1qwISESd8=;
 b=oWcWpwG/N/vMSX8icXJR5tspPy+n7QaC6hBG+TUKZJYyxFUqoMex19s3eSLpUCN0cvcHXxbxXMCny6+AnKeX1HPCPh+e7gnx7CejUlV+3Gng+UQOAoPW98Ta3uCaft2NZaPYlkq8TMXbaRjHR6emGzixtNTzs9jRuUdM8O2+0Lk2JJZ5bHd/r2oOFoAJmgRU/dOjxdguHR19c3LwykXFKDTpJJVqlzRmef5/l5VVwVi9btTkGL7QgBCMVHnnQBBq7r/AmU3eaYglSBcYpiwk/Ph2kx8fyn3XJ+k3RtPdG8Enhf4GZB87YHyqywzARPf3qjpt0qU3caCLiDizefjqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+BM3ILw2d0aCpThFIh9Lgh3EyrYRnhWQt1qwISESd8=;
 b=dLuMdYc1ZumPG/6Z9+MsMKqRgEJsTeJz2PzLaG0VcLQQi6OjnSWeezQ5+F/0Y4UI0iLzh1zru6AlqAxjrwHkqGNL5M/PG3OLq91MYSI3i7TZzAECvEyc/W561zG47zIeaa+hLHToOsS4pRI7YKwq+E8U8rYg2URGBZjxik++fJY=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3866.namprd13.prod.outlook.com (2603:10b6:5:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.7; Thu, 15 Apr
 2021 23:30:16 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4065.006; Thu, 15 Apr 2021
 23:30:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "ajmitchell@redhat.com" <ajmitchell@redhat.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Topic: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Index: AQHXMVl4VT45tjmxiUS0kqeKowHWU6q0qJsAgAEODwCAABHMAIAAc2kA
Date:   Thu, 15 Apr 2021 23:30:15 +0000
Message-ID: <bf7a7563989477a30490e3982665f90bdcfa1016.camel@hammerspace.com>
References: <20210414181040.7108-1-steved@redhat.com>
         <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
         <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
         <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
In-Reply-To: <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 684cbae9-21e6-4d10-9089-08d900666cb0
x-ms-traffictypediagnostic: DM6PR13MB3866:
x-microsoft-antispam-prvs: <DM6PR13MB38666483A90CDCD962CE38FFB84D9@DM6PR13MB3866.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VqSjjrNKnNpKY5IuqEejPgp3INq4sZRw1g7RCY2hrbB1kJfb7FeneoFWEi4Ym2sF4AcT7zJFYCwzScBqBp2v6ljS41xbLNmmVGa1LNjM6YHvMztFFf95Kd1wfP1LgmLQQj1DrGKFJBjQsAOxN4rTbBN6kdYPwCaF01M+cwq1PVaDStqLs9uUBfgUpRkgx6eAfGBfrlgBcqV4oEwJD+TDrdte4jXpEI3vfv1iYtPno9uMvv5pj6HOw/Pc4ZY9LEWST8N8HVfbAOmIYRlQ+7bw7PxSfzEfBlixWA3PDuyhb0d7va/DtUgvF3EZFMoFm+RY8JS5Qe9mD5y+1jYxuLSGmBcl69FMfYpz/2/jhQnlONKdFsKjcRY7OkjE/MMoimNComXnl1dedLLqBE5NItyiqcTGpWWMEyoUOZ/N44lI7diuVI59rK4iS5Lxyk44UBNduNELqLK3rbt7az5Xn5Hw/LbX9WasN2YDcyxky+EKjpx3UnxJ+Hns60ktUCHuDF34gUHwgslUbnLm5Gr45qalYxcUBFAvVzHkRRiaAUN6CqOXFqTNzLZGwU/PIWsBUNs7bQg8P5wZfGI2H1HE5U/YrnDVNKCnzVNcCBp3GhdKGXgxSK3oS8ju83LGL6eXdj41mZJ65V4QiVWKIr6vfji69Mx9LAX4Nr0rA2jP0dVVKlE5irQGcH6ulsCxsZ5hFaIe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39840400004)(86362001)(36756003)(186003)(4326008)(478600001)(8936002)(2616005)(8676002)(26005)(5660300002)(53546011)(83380400001)(2906002)(110136005)(316002)(6512007)(91956017)(38100700002)(76116006)(71200400001)(64756008)(66946007)(66446008)(6486002)(966005)(122000001)(66556008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TEh3WG5tL3EvNzhkelA4TFdWL0F4SlNjUDliaUdmTWhLM1ZYNXlaVUVXeU9n?=
 =?utf-8?B?dmY0Q3ZRMEFSSkh3UGY1R1BLeTBSMzZrSDJ3RXg3RWdnNk5QbTNnTTZJWXBp?=
 =?utf-8?B?ZEpNNGJvaEJxNlF4N3RSTW5rcXBLQ0F5ZW5DdjhQQzhmWHdDM3JOL0hqa055?=
 =?utf-8?B?YklDdTJVL0lURHFJRUFnMkl4NjcvZklpYWtBYmpHWFhNMVY5WUJrZVlNTXI2?=
 =?utf-8?B?cXBpSXlMeFRrQzhVaUNlcjdDckdSeDY2TzRQV2k1YWRrZEZ3WWozU0k4Y1pM?=
 =?utf-8?B?QUpNRkI4bkpLSDRRdWxRSTdFakl4ZEpKYk96cmlKb2xiZjJYYVZ4Y0N6d29F?=
 =?utf-8?B?dGZMVTNIN0pZamhOTjRIdnRQU0YyZmRNWkIvdCtYUDM1RXp0cXFHZGtoTWVm?=
 =?utf-8?B?akZpaTNXYkpKYU5QWmdNaXRwdnQ0N2hkcEtudXdicnhEQjRRS1RNc2pUd2NN?=
 =?utf-8?B?cG1HT2FzVVltbHNmTlViZWxYN0JVekNwVCtMMWxLaWpNb2lGQnMyZzRWdlRE?=
 =?utf-8?B?V3NCb1c1ZXk4WkJuZ2dhR09zOWI1eGFGM1hzV0ZDcy9JRm1QYUdXcGNhUWl5?=
 =?utf-8?B?a3dQRUg4cHpSTFB6VjgzSExkRDd2VlpTc3JrMlRETGQ4SkVDNGc1SVFNMFpQ?=
 =?utf-8?B?blJ5Q0Zzb2huMGY0dHVFTXk3SGhoYU9QRXZvWlloMXVJQmZGSDEySzZqeGZB?=
 =?utf-8?B?UHB0T3VJeDRzT25vb3RseXpuTmVuT0Y3d1FyMEs5ZEF5R043WmR1R2V4KzJh?=
 =?utf-8?B?bmhqS3BLd3RNbXFMUFJXM3dWek80UmsydEtRN0dVdmcrNi9HK1RRa2lmUW5U?=
 =?utf-8?B?L3V6U2EremRRMEpUOGJTdjRIREdqMDNnY0h0ZGNYZ29QOGNIaHFJdVFxbzBk?=
 =?utf-8?B?RlRRRnIzTEhBNjl4aHNMMGxHWVdYbDVEOEE3ZmhDbjhLck1reFpmZldGamgx?=
 =?utf-8?B?TVM1YUdsQytQYk5KaTJlUlJEU0dGWFZ1UGUrelp0QXREZWduK3NEZFdwMkht?=
 =?utf-8?B?ZDlZV3ZOcVBKWTFTcy90OHJ1b21EalVrVGZpMnBHZFpFOE1lbTlFdmpkYmRa?=
 =?utf-8?B?QWluYjBxMlU3YzFUUDQ4bnBlTk10aXJBYjZqWmUvMVlwSHd4cFR0YTV5WWR6?=
 =?utf-8?B?Y1lZZ0ZVZm4xNUM4akxvNFVYYkI2V3htNzZxYW43bWRkWlFKR2d0dktVNTZY?=
 =?utf-8?B?TDJmRG1IZ2RIdnFJV0pIdW9JTmtjSk5kMlhVSnR3d3dKZ0tBS2lCN3hOQm5Q?=
 =?utf-8?B?eHBlT1hEZGtvRlNoSUt4REtQRnpDRkFMN20zOWtWaXZJd01QT082ckd2ZDBK?=
 =?utf-8?B?MXhRZmFVemdkb1gxVTlpUnprUWVCL252d3ZDTUVhZjF5c1dWbUJIeG9rU0Qw?=
 =?utf-8?B?Z2FVcVhMWHIwSEJaTkNhejVxZ0E1WGI2WVpHdVprZm42aWhWV2NtM203RnFh?=
 =?utf-8?B?Z0VUVWsxSmEvRVRiL0F3eVpwcGZQd0RpZkNIMUFUeVRWVEI1dUxiOFgzbUc5?=
 =?utf-8?B?NnN3bkVNWUhGZ2lUWHBtY21tenJiQnV5VFdJYkZWYWozRkQvNEJialRZampY?=
 =?utf-8?B?Vkp4cWwxNFFUSWNkYXpvejdwdG1wSmd3d0V2S0xlZE1QZ05jY2FGVDlwZGdi?=
 =?utf-8?B?RWY0c3J6Tzg3MzRVTWFUTm5iN2R2STRKK0I0WVZVaXlWQmN1THErZDRqVzRL?=
 =?utf-8?B?WExHdVpuNVVTWW9ETi9EMW9VTWUxVTEyWTMrL1BTY29DS2NaNlp4S2FXQkc2?=
 =?utf-8?Q?erPwOKdusuYjU+oRBlLgoVuN/O5neZjFiCghl5R?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E400C181E73348498337677CA8008B2C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684cbae9-21e6-4d10-9089-08d900666cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 23:30:15.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvzGVZGa5Rn97Rc63HxqkNaUcvCXvXEEH2eZoanAzCfeecqkqD0UOwDzS/nKcOTiOR31+AF4AyTl2T94iKAoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3866
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDE2OjM3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBBcHIgMTUsIDIwMjEsIGF0IDExOjMzIEFNLCBTdGV2ZSBEaWNrc29u
IDxTdGV2ZURAUmVkSGF0LmNvbT4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBIZXkgQ2h1Y2shIA0K
PiA+IA0KPiA+IE9uIDQvMTQvMjEgNzoyNiBQTSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+
ID4gSGkgU3RldmUtDQo+ID4gPiANCj4gPiA+ID4gT24gQXByIDE0LCAyMDIxLCBhdCAyOjEwIFBN
LCBTdGV2ZSBEaWNrc29uIDxTdGV2ZURAcmVkaGF0LmNvbT4NCj4gPiA+ID4gd3JvdGU6DQo+ID4g
PiA+IA0KPiA+ID4gPiDvu79UaGlzIGlzIGEgdHdlYWsgb2YgdGhlIHBhdGNoIHNldCBBbGljZSBN
aXRjaGVsbCBwb3N0ZWQgbGFzdA0KPiA+ID4gPiBKdWx5IFsxXS4NCj4gPiA+IA0KPiA+ID4gVGhh
dCBhcHByb2FjaCB3YXMgZHJvcHBlZCBsYXN0IEp1bHkgYmVjYXVzZSBpdCBpcyBub3QgY29udGFp
bmVyLQ0KPiA+ID4gYXdhcmUuDQo+ID4gPiBJdCBzaG91bGQgYmUgc2ltcGxlIGZvciBzb21lb25l
IHRvIHdyaXRlIGEgdWRldiBzY3JpcHQgdGhhdCB1c2VzDQo+ID4gPiB0aGUNCj4gPiA+IGV4aXN0
aW5nIHN5c2ZzIEFQSSB0aGF0IGNhbiB1cGRhdGUgbmZzNF9jbGllbnRfaWQgaW4gYSBuYW1lc3Bh
Y2UuDQo+ID4gPiBJDQo+ID4gPiB3b3VsZCBwcmVmZXIgdGhlIHN5c2ZzL3VkZXYgYXBwcm9hY2gg
Zm9yIHNldHRpbmcgbmZzNF9jbGllbnRfaWQsDQo+ID4gPiBzaW5jZSBpdCBpcyBjb250YWluZXIt
YXdhcmUgYW5kIG1ha2VzIHRoaXMgc2V0dGluZyBjb21wbGV0ZWx5DQo+ID4gPiBhdXRvbWF0aWMg
KHplcm8gdG91Y2gpLg0KPiA+IEFzIEkgc2FpZCBpbiBpbiBteSBjb3ZlciBsZXR0ZXIsIEkgc2Vl
IHRoaXMgbW9yZSBhcyBpbnRyb2R1Y3Rpb24gb2YNCj4gPiBhIG1lY2hhbmlzbSBtb3JlIHRoYW4g
YSB3YXkgdG8gc2V0IHRoZSB1bmlxdWUgaWQuDQo+IA0KPiBZZXAsIEkgZ290IHRoYXQuDQo+IA0K
PiBJJ20gbm90IGFkZHJlc3NpbmcgdGhlIHF1ZXN0aW9uIG9mIHdoZXRoZXIgYWRkaW5nIGENCj4g
bWVjaGFuaXNtIHRvIHNldCBhIG1vZHVsZSBwYXJhbWV0ZXIgaW4gbmZzLmNvbmYgaXMgZ29vZA0K
PiBvciBub3QuIEknbSBzYXlpbmcgbmZzNF9jbGllbnRfaWQgaXMgbm90IGFuIGFwcHJvcHJpYXRl
DQo+IHBhcmFtZXRlciB0byBhZGQgdG8gbmZzLmNvbmYuIENhbiB5b3UgcGljayBhbm90aGVyDQo+
IG1vZHVsZSBwYXJhbWV0ZXIgYXMgYW4gZXhhbXBsZSBmb3IgeW91ciBtZWNoYW5pc20/DQo+IA0K
PiANCj4gPiBUaGUgbWVjaGFuaXNtIGJlaW5nDQo+ID4gYSB3YXkgdG8gc2V0IGtlcm5lbCBtb2R1
bGUgcGFyYW1zIGZyb20gbmZzLmNvbmYuIFRoZSBzZXR0aW5nIG9mDQo+ID4gdGhlIGlkIGlzIGp1
c3QgYSBzaWRlIGVmZmVjdC4uLiANCj4gPiANCj4gPiBXaHkgc3ByZWFkIG91dCB0aGUgTkZTIGNv
bmZpZ3VyYXRpb24/wqAgV2h5IG5vdA0KPiA+IGp1c3Qga2VlcCBpdCBpbiBvbmUgcGxhY2UuLi4g
YWthIG5mcy5jb25mPw0KPiANCj4gV2UgbmVlZCB0byB1bmRlcnN0YW5kIHdoZXRoZXIgYSBtb2R1
bGUgcGFyYW1ldGVyIGlzIG5vdA0KPiBnb2luZyB0byB3b3JrIGluIG5mcy5jb25mIGJlY2F1c2Ug
dGhhdCBzZXR0aW5nIG5lZWRzIHRvDQo+IGJlIG5hbWVzcGFjZS1hd2FyZS4gSW4gdGhpcyBjYXNl
LCB0aGlzIHNldHRpbmcgZG9lcyBpbmRlZWQNCj4gbmVlZCB0byBiZSBuYW1lc3BhY2UtYXdhcmUu
IG5mcy5jb25mIGlzIG5vdCBhd2FyZSBvZg0KPiBuZXR3b3JrIG5hbWVzcGFjZXMuDQo+IA0KPiAN
Cj4gPiBQbHVzIHdlIGNvdWxkIGRvY3VtZW50IGFsbCB0aGUga2VybmVsIHBhcmFtcyBpbiBuZnMu
Y29uZg0KPiA+IGFuZCB0aGUgbmZzLmNvbmYgbWFuIHBhZ2UuIFRoZSBvbmx5IGRvY3VtZW50YXRp
b24gSSBrbm93IA0KPiA+IG9mIGlzIGluIHRoZSBrZXJuZWwgdHJlZS4NCj4gDQo+IE9LLCBidXQg
dGhhdCdzIG5vdCByZWxldmFudCB0byB3aGV0aGVyIG5mcy5jb25mIGlzIHRoZQ0KPiByaWdodCBw
bGFjZSB0byBzZXQgbmZzNF9jbGllbnRfaWQuDQo+IA0KPiANCj4gPiBBcyBmYXIgYXMgbm90IGJl
aW5nIGNvbnRhaW5lci1hd2FyZS4uLiB0aGF0IG1pZ2h0IHRydWUNCj4gPiBidXQgaXQgZG9lcyBu
b3QgbWVhbiBpdHMgbm90IHVzZWZ1bCB0byBzZXQgdGhlIGlkIGZyb20NCj4gPiBuZnMuY29uZi4u
Lg0KPiANCj4gWWVzLCBpdCBkb2VzIG1lYW4gdGhhdCBpbiB0aGF0IGNhc2UuIEl0J3MgY29tcGxl
dGVseQ0KPiBicm9rZW4gdG8gdXNlIHRoZSBzYW1lIG5mczRfY2xpZW50X2lkIGluIGV2ZXJ5IG5l
dHdvcmsNCj4gbmFtZXNwYWNlLg0KPiANCj4gDQo+ID4gQWN0dWFsIEkgaGF2ZSBjdXN0b21lcnMg
YXNraW5nIGZvciB0aGlzIHR5cGUNCj4gPiBvZiBmdW5jdGlvbmFsaXR5DQo+IA0KPiBBc2sgeW91
cnNlbGYgd2h5IHRoZXkgbWlnaHQgd2FudCBpdC4gSXQncyBwcm9iYWJseSBiZWNhdXNlDQo+IHdl
IGRvbid0IHNldCBpdCBjb3JyZWN0bHkgY3VycmVudGx5LiBJZiB3ZSBoYXZlIGEgd2F5IHRvDQo+
IGF1dG9tYXRpY2FsbHkgZ2V0IGl0IHJpZ2h0IGV2ZXJ5IHRpbWUsIHRoZXJlJ3MgcmVhbGx5IG5v
DQo+IG5lZWQgZm9yIHRoaXMgc2V0dGluZyB0byBiZSBleHBvc2VkLg0KPiANCj4gSSBkbyBhZ3Jl
ZSB0aGF0IGl0J3MgbG9uZyBwYXN0IHRpbWUgd2Ugc2hvdWxkIGJlIHNldHRpbmcNCj4gbmZzNF9j
bGllbnRfaWQgcHJvcGVybHkuIEkgd291bGQgcmF0aGVyIHNlZSBhIHVkZXYgc2NyaXB0DQo+IGRl
dmVsb3BlZCAoeW91LCBtZSwgb3IgQWxpY2UgY291bGQgZG8gaXQgaW4gYW4gYWZ0ZXJub29uKQ0K
PiBmaXJzdC4gSWYgdGhhdCBkb2Vzbid0IG1lZXQgdGhlIGFjdHVhbCBjdXN0b21lciBuZWVkLCB0
aGVuDQo+IHdlIGNhbiByZXZpc2l0Lg0KPiANCg0KUmlnaHQuIFRoZSBvbmx5IHNlbnNpYmxlIHNv
bHV0aW9uIGluIGEgY29udGFpbmVyaXNlZCB3b3JsZCBpcyBhIHVkZXYNCnNjcmlwdCB0aGF0IHNl
dHMgL3N5cy9mcy9uZnMvbmV0L25mc19jbGllbnQvaWRlbnRpZmllciB3aGVuIHRyaWdnZXJlZC4N
Cg0KTm90ZSB0aGF0IHdlIHJlYWxseSB3YW50IHNvbWV0aGluZyB0aGF0IGdlbmVyYXRlcyBhIHJh
bmRvbSB1dWlkLCBhbmQNCnRoZW4gcGVyc2lzdHMgaXQgc28gdGhhdCBpdCBjYW4gYmUgcmV0cmll
dmVkIG9uIHJlYm9vdCBvciByZXN0YXJ0IG9mDQp0aGUgY29udGFpbmVyLiBTb21ldGhpbmcgc2lt
aWxhciB0byBzeXN0ZW1kLW1hY2hpbmUtaWQtc2V0dXAsIGJ1dCB0aGF0DQpjYW4gYmUgY2FsbGVk
IGZyb20gdWRldi4NCg0KPiANCj4gPiBzdGV2ZWQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiBJ
dCBlbmFibGVzIHRoZSBzZXR0aW5nIG9mIHRoZSBuZnM0X3VuaXF1ZV9pZCBrZXJuZWwgbW9kdWxl
IA0KPiA+ID4gPiBwYXJhbWV0ZXIgZnJvbSAvZXRjL25mcy5jb25mLg0KPiA+ID4gDQo+ID4gPiA+
IFRoaW5ncyBJIHR3ZWFrZWQ6DQo+ID4gPiA+IA0KPiA+ID4gPiDCoCAqIEludHJvZHVjZSBhIG5l
dyBba2VybmVsXSBzZWN0aW9uIGluIG5mcy5jb25mIHdoaWNoIG9ubHkNCj4gPiA+ID4gwqDCoMKg
IGNvbnRhaW5zIHRoZSBuZnM0X3VuaXF1ZV9pZCBzZXR0aW5nLi4uIEZvciBub3cuLi4gDQo+ID4g
PiA+IA0KPiA+ID4gPiDCoCAqIG5mczRfdW5pcXVlX2lkIGNhbiBiZSBzZXQgdG8gdHdvIGRpZmZl
cmVudCB2YWx1ZXMNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqAgLSBuZnM0X3VuaXF1ZV9p
ZCA9ICR7bWFjaGluZS1pZH0gd2lsbCB1c2UgL2V0Yy9tYWNoaW5lLWlkDQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoCBhcyB0aGUgdW5pcXVlIGlkLg0KPiA+ID4gPiDCoMKgwqDCoMKgIC0gbmZz
NF91bmlxdWVfaWQgPSAke2hvc3RuYW1lfSB3aWxsIHVzZSB0aGUgc3lzdGVtJ3MNCj4gPiA+ID4g
aG9zdG5hbWUNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGFzIHRoZSB1bmlxdWUgaWQuDQo+
ID4gPiA+IA0KPiA+ID4gPiDCoCAqIFRoZSBuZXcgbmZzLWNvbmZpZyBzeXN0ZW1kIHNlcnZpY2Ug
bmVlZCB0byBiZSBlbmFibGVkIGZvcg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gwqDCoMKgIC9ldGMv
bW9kcHJvYmUuZC9uZnMuY29uZiBmaWxlIHRvIGJlIGNyZWF0ZWQgd2l0aCANCj4gPiA+ID4gwqDC
oMKgIHRoZSAib3B0aW9ucyBuZnMgbmZzNF91bmlxdWVfaWQ9IiBzZXQuIA0KPiA+ID4gPiANCj4g
PiA+ID4gSSBzZWUgdGhpcyBwYXRjaCBzZXQgaXMgbm90IGEgd2F5IHRvIHNldCB0aGUgbmZzNF91
bmlxdWVfaWQgDQo+ID4gPiA+IG1vZHVsZSBwYXJhbWV0ZXIuLi4gSSBzZWUgaXQgYXMgYSBiZWdp
bm5pbmcgb2YgYSB3YXkgdG8gc2V0IA0KPiA+ID4gPiBhbGwgbW9kdWxlIHBhcmFtZXRlcnMgZnJv
bSAvZXRjL25mcy5jb25mLCB3aGljaCBJIHRoaW5rDQo+ID4gPiA+IGlzIGEgZ29vZCB0aGluZy4u
LiANCj4gPiA+ID4gDQo+ID4gPiA+IFsxXSBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9s
aW51eC1uZnMvbXNnNzg2NTguaHRtbA0KPiA+ID4gPiANCj4gPiA+ID4gQWxpY2UgTWl0Y2hlbGwg
KDMpOg0KPiA+ID4gPiBuZnMtdXRpbHM6IEVuYWJsZSB0aGUgcmV0cmlldmFsIG9mIHJhdyBjb25m
aWcgc2V0dGluZ3Mgd2l0aG91dA0KPiA+ID4gPiDCoCBleHBhbnNpb24NCj4gPiA+ID4gbmZzLXV0
aWxzOiBBZGQgc3VwcG9ydCBmb3IgZnVydGhlciAke3ZhcmlhYmxlfSBleHBhbnNpb25zIGluDQo+
ID4gPiA+IG5mcy5jb25mDQo+ID4gPiA+IG5mcy11dGlsczogVXBkYXRlIG5mczRfdW5pcXVlX2lk
IG1vZHVsZSBwYXJhbWV0ZXIgZnJvbSB0aGUNCj4gPiA+ID4gbmZzLmNvbmYNCj4gPiA+ID4gwqAg
dmFsdWUNCj4gPiA+ID4gDQo+ID4gPiA+IGNvbmZpZ3VyZS5hY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gPiA+IG5mcy5jb25mwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0NCj4gPiA+ID4gc3VwcG9ydC9p
bmNsdWRlL2NvbmZmaWxlLmjCoMKgwqAgfMKgwqAgMSArDQo+ID4gPiA+IHN1cHBvcnQvbmZzL2Nv
bmZmaWxlLmPCoMKgwqDCoMKgwqDCoCB8IDI4Mw0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+ID4gPiA+IHN5c3RlbWQvTWFrZWZpbGUuYW3CoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAzICsNCj4gPiA+ID4gc3lzdGVtZC9uZnMtY2xpZW50LnRhcmdldMKgwqDC
oMKgIHzCoMKgIDMgKw0KPiA+ID4gPiBzeXN0ZW1kL25mcy1jb25mLWV4cG9ydC5zaMKgwqDCoCB8
wqAgMjggKysrKw0KPiA+ID4gPiBzeXN0ZW1kL25mcy1jb25maWcuc2VydmljZS5pbiB8wqAgMTgg
KysrDQo+ID4gPiA+IHN5c3RlbWQvbmZzLmNvbmYubWFuwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
OSArKy0NCj4gPiA+ID4gdG9vbHMvbmZzY29uZi9uZnNjb25mLm1hbsKgwqDCoMKgIHzCoCAxMCAr
LQ0KPiA+ID4gPiB0b29scy9uZnNjb25mL25mc2NvbmZjbGkuY8KgwqDCoCB8wqAgMjIgKystDQo+
ID4gPiA+IDExIGZpbGVzIGNoYW5nZWQsIDM3MiBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMo
LSkNCj4gPiA+ID4gY3JlYXRlIG1vZGUgMTAwNzU1IHN5c3RlbWQvbmZzLWNvbmYtZXhwb3J0LnNo
DQo+ID4gPiA+IGNyZWF0ZSBtb2RlIDEwMDY0NCBzeXN0ZW1kL25mcy1jb25maWcuc2VydmljZS5p
bg0KPiA+ID4gPiANCj4gPiA+ID4gLS0gDQo+ID4gPiA+IDIuMzAuMg0KPiA+ID4gPiANCj4gPiAN
Cj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+IA0KPiANCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
