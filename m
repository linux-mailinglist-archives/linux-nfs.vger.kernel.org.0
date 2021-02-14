Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7660531B136
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBNQZL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 11:25:11 -0500
Received: from mail-eopbgr760117.outbound.protection.outlook.com ([40.107.76.117]:54087
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229714AbhBNQZK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 14 Feb 2021 11:25:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB5GUkJp444N/XFb5THhd/4QxMPsOusRTirO5Vfbi5HEWI5zVn7K8TCpDGukmXi5a9Eaf5PJcUeUcYuWNjRBh0nx8ydPBRbDzz/M2QC/PZdtHWFPrvchDpflZon96OuAFAVbVVYnbTOMbKwp2iq9TYR7b5uJat3RfrhoJRpvZKgSwFGq/mECpw7sGDUs8oJwUJWSfdHOh+wm+JiPMdR1YBvZ++ps95zM+MVfPovJJX2yrkRpAM1SPLaKRUWx9zY3//Pfnrcv9icqu/l/erTtatwVDSu62IRhCTsBrkNdGDrmYE+3XkVHBdMF9o4z0BDGEHl8xZ85GLAAFKa9BD4BCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjTWEU5vDEEQHCiYbq3Ex5/ep+ymvI4am+rDoPwE4JY=;
 b=UF5XbJhAqI6lKfyFnz6dsjpSwg2el/Dapbko7DHBnq4aWAkwnr8twALEdkGPcaf3v4BYMAhV5TdkLFaon0s2ItGUmOJj/huSjo0HHZ8lPW7h7iFhAM8fgQVY+fzKda6U3Z69b53br/oXMH2OVExI0Z/AWsbfO0PM6EMQIM8ScE1YT9sLmg/phAqEZFcKyHYXfeNipkRACm6MzjE2O6oe/tfpOFon1srMcJoaUj7PtLNwJFWFeSM/ss5uO4ynvDOFaqkAR8BluCzZYqX1k2yLstXjPyu3t6JLd7WYLsteqlhj4jWR99pfwepazV8LVKck47yjj8UsMXUsfTe+jGrnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjTWEU5vDEEQHCiYbq3Ex5/ep+ymvI4am+rDoPwE4JY=;
 b=ePiQbvuZXIzavuh4K7q7O9TwNkXZApaRGVYWrFzfy8f2HNQMaXvgXDHiXoOSzYVkIoALQFF6kbFDoGDzvVBeTE3OT4yLuLP2+foJ66DHJ1wd684obOxIk8vxZmy9dKVgpG9hNzzflLb6FnS4e8o9nRGXQzTGNWeaRVDsnroYkSw=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB4522.namprd13.prod.outlook.com (2603:10b6:610:62::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Sun, 14 Feb
 2021 16:24:21 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.019; Sun, 14 Feb 2021
 16:24:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "daire@dneg.com" <daire@dneg.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkaKHQ4x2Pj5G0O0h0qlFPlIMKpWoMuAgAAErYCAABZIAIAA9t0AgAAkhoA=
Date:   Sun, 14 Feb 2021 16:24:21 +0000
Message-ID: <bf0d34e25ef39dd90ade63178b829da7c0c2452f.camel@hammerspace.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
         <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
         <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
         <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
         <285652682.9476664.1613312016960.JavaMail.zimbra@dneg.com>
In-Reply-To: <285652682.9476664.1613312016960.JavaMail.zimbra@dneg.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dneg.com; dkim=none (message not signed)
 header.d=none;dneg.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19d91925-6cd5-427f-68de-08d8d104fc13
x-ms-traffictypediagnostic: CH2PR13MB4522:
x-microsoft-antispam-prvs: <CH2PR13MB452214AB5644D9E8AF64ADB9B8899@CH2PR13MB4522.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nHwU7QPFdLRuNn50TD68OUh8CRPUj0SmuaYOPDu5rBj7lJGTHXpbaofkf4++NHW/wqKgENnRm56h5kf3ik29RpjEx9hJZNQRPMnYO2nEMt5T0DLy5tTeJizUUIclzLjCNDueyMvEYt0ptTRsnjiR1vj7YN1NYTq6xXNeiRDkEHluVOd+4Fb3r0Ny4Tw90Mh2GGh9qGdcYrJiZP5l4dVwWJqzvLsdCOch/0oZmEAzdogPcEdG/3n15eQc3XTldnBU4m8KNSwkzTxwAhTjhT9veAQXCGvWQvLKSXygE5hdQgrOeXZcvARU7staoYJbCUWb4qjfs7mOuGWNx8V5Ie1YhexuNaQAbGvRvDEzGseMeLr9oRgl3fcZZdYiyBABR7iioVt7L5kzK9OKBI82bxyWyMw7m3hJfZYuaAiMeK54SH3AAxrIUR9/MsIo3SYBADXlTCi7WweZfz5NmWH17YvPF01r+RDR9opOaIJPObjGVzBJtjssXKMCwHfvxuxTpwjlMpK83+8+vxsp92KYt93vnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39830400003)(396003)(110136005)(5660300002)(54906003)(36756003)(4326008)(26005)(8676002)(2616005)(8936002)(4744005)(66476007)(6506007)(66556008)(316002)(66446008)(86362001)(2906002)(6486002)(66946007)(76116006)(53546011)(6512007)(71200400001)(186003)(478600001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NjZiRzRRTnJnV1ZVWnQ2clpUek50RnpoNGpvUXkyejBlQ1lBSUtVYmtucGcv?=
 =?utf-8?B?eEdQdGpTNTNVSnNRSVRuRWl5NG5PRXdVUDYrdkNJeTFwcEZTV1gvbXhMVXp4?=
 =?utf-8?B?VEVYcTZoZTFSaVdUOE4zQkhpVE45TldnZnFRQVd6TkdrVzl3bFJ0bjF4a1FH?=
 =?utf-8?B?dGFXekQvdjZOd3U3a2g0d2JSOG5LSis2SWZUUFhoNTZkZFdxQ0lOelltaCtZ?=
 =?utf-8?B?djJOQnluaG9Pb3kzNEZZNWxMUi9kVHo2REFIRTRWSGd1WmNXZlFRYjlHZEc2?=
 =?utf-8?B?S0h1Mzk4Rys4ckw4OHFKMThhNHJGN1B3Rmx4ei9CcmNSZVpqUEtmbnhCVVJQ?=
 =?utf-8?B?L3BGczhmYml0MFkydnNqNnBXN2dyR2JLN2dRR01SdlhLN0Z2U1hDbFhTMHVX?=
 =?utf-8?B?eVFtN3d6MXNVYVkwbDZRbWhLTC9oRGIvRFU3RlNkQTNDSVFaNXh3S2QzYisy?=
 =?utf-8?B?OEpia1M0V3ZXWHBYNU8zdk0yZG5nOXJIcGVIbnM3ZVEzYklTOStzR0hxSlFH?=
 =?utf-8?B?eDZFVG1XSzBXdlVHUERkcE03TCtnN29QdmczUTRzclMrN1FIaU1va3pubGRm?=
 =?utf-8?B?dWlrWjUxYUNwLzkwSWZYZW43WmFkNjZQbG9rWXU3ZzNtb1FIWEw2aDlGWTB3?=
 =?utf-8?B?azdMSHlBejFPei92akJVUnYxSXRVRllyVUU0UmU3T1hqRFdtZFQrSWJCSEhM?=
 =?utf-8?B?Zy84U2NxY25qZGZpa2h5cUZDNFp0aFFwamdMS3JvNWlDbzJObEZ6R2dwTVZn?=
 =?utf-8?B?aTdsMUo4WXB6bjhVR2I0OExiWUtqUk9EaTBvMkdRdzFsWDNLaTllL1NnZTh4?=
 =?utf-8?B?TkduVmJnM0s4S3M4RGx0L3NxeFFxWDlUMmFRR3NFbS9lTjd0TzB1NW43MFJW?=
 =?utf-8?B?V29scG93Z0Q1eUJudmZuaEZvY2NrNi9sdEtQUWRVamIwR3o2cHJwc2ZzWW5v?=
 =?utf-8?B?VnN5R0tyV0svV2tYOE5vNGdveFkySmMzbmJZRXRNMWhKcXdQNzZKRnZsdFZq?=
 =?utf-8?B?ZWRJSUlGTmFBa2FUeDNBenFRWjR0T1htZFd5eXE4SzFJMTVES1YxNGN5RTI3?=
 =?utf-8?B?bnYrWi9KbVVPRnFrVHdZUmNEOHMrQXNVelBnUm1UUEl4RVZFS1o3UkE2QllP?=
 =?utf-8?B?RUx3TUlVeGlmcWZGQ0JXejRwaENSUW5zc1Q4akRhcFZ6OGN2LzdpWFlDS2dh?=
 =?utf-8?B?S1NseHZGeTdWaFpmUEp2SzY2aEJTSGtITVhNODBTUWk2ZTZOeERiYStOd2ND?=
 =?utf-8?B?UWlnSk1GaTZmSFVTQzBQVG5FaGx6U0dSV1dSSFpmMVlWV1p5YVFmNDNqcEYr?=
 =?utf-8?B?eHlOUktMT1pITmMxbVEyeDBaY3UrejlKdWFySHNZSHFOMCtWOFU2U0Evd1VR?=
 =?utf-8?B?UDdqUDNnVE8vTTMxRW5YT09keFZ2QllrVVhpbjNzaGNLVG9SMk9rMnl4QjI1?=
 =?utf-8?B?MTNaeHo5WFFxTThnNFdGNjdVdDhxTWpQN3VYWGpSeGhrRlIwcUVCbjJLekZi?=
 =?utf-8?B?TDJRWm5wZGlHOTJSOHQ5cGpQN01SeTdBMXlHK21VYk85VVF1VzVWREt1V2oy?=
 =?utf-8?B?RnVGbk9RU3ZEekZiK0hFQTRaNmw4aHV4c3ZrQW5JcmhXOUlzUHV6K0VGRWh0?=
 =?utf-8?B?VFNjZi9rZkI3T1hObThJdVJGZ1VSVGg3T2JyZlc5dzZuZldGYmxDQ1ZMVXdR?=
 =?utf-8?B?WGhGTjhNQmFFQ1IzZzN3ZC9tVm9obTJYblptdE5DazgydlFqZmpzbDRQWHN4?=
 =?utf-8?Q?R4S5/P0BXcZUG9cYfd49b/W5xD2l9yPo+OUXrlI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A70893F054FFD449379891C545CA897@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d91925-6cd5-427f-68de-08d8d104fc13
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 16:24:21.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIa4PNd9ASD8faV0vuoNK1wtKxCsbq4IgFGCGFABqFtNgxGpoZa0Rsm1bKh7HYN3thy8fCEgx0xyrd9FpcvADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4522
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTAyLTE0IGF0IDE0OjEzICswMDAwLCBEYWlyZSBCeXJuZSB3cm90ZToNCj4g
DQo+IC0tLS0tIE9uIDEzIEZlYiwgMjAyMSwgYXQgMjM6MzAsIENodWNrIExldmVyDQo+IGNodWNr
LmxldmVyQG9yYWNsZS5jb23CoHdyb3RlOg0KPiANCj4gPiA+IEkgZG9uJ3QgaGF2ZSBhIHBlcmZv
cm1hbmNlIHN5c3RlbSB0byBtZWFzdXJlIHRoZSBpbXByb3ZlbWVudA0KPiA+ID4gYWNjdXJhdGVs
eS4NCj4gPiANCj4gPiBUaGVuIGxldCdzIGhhdmUgRGFpcmUgdHJ5IGl0IG91dCwgaWYgcG9zc2li
bGUuDQo+IA0KPiBJJ20gaGFwcHkgdG8gdGVzdCBpdCBvdXQgb24gb25lIG9mIG91ciAyIHggNDBH
IE5GUyBzZXJ2ZXJzIHdpdGggMTAwIHgNCj4gMUcgY2xpZW50cyAoYnV0IGl0J3MgdHJpY2tpZXIg
dG8gcGF0Y2ggdGhlIGNsaWVudHMgdG9vIGF0bSkuDQo+IA0KPiBKdXN0IHNvIEknbSBjbGVhciwg
dGhpcyBpcyBpbiBhZGRpdGlvbiB0byBDaHVjaydzICJIYW5kbGUgVENQIHNvY2tldA0KPiBzZW5k
cyB3aXRoIGtlcm5lbF9zZW5kcGFnZSgpIGFnYWluIiBwYXRjaCBmcm9tIGJ6ICMyMDk0MzkgKHdo
aWNoIEkNCj4gdGhpbmsgaXMgbm93IGluIDUuMTEgcmMpPyBPciB5b3Ugd2FudCB0byBzZWUgd2hh
dCB0aGlzIHBhdGNoIGxvb2tzDQo+IGxpa2Ugb24gaXQncyBvd24gd2l0aG91dCB0aGF0IChlLmcu
IHY1LjEwKT8NCj4gDQoNClRoaXMgcGF0Y2ggaXMgaW5kZXBlbmRlbnQgb2Ygd2hpY2ggc29ja2V0
IG1lY2hhbmlzbSB3ZSdyZSB1c2luZzogaXQNCnNob3VsZCB3b3JrIHdpdGggc2VuZG1zZygpLCBz
ZW5kcGFnZSgpLCBhbmQgZXZlbiB3cml0ZXYoKS4gU28gZmVlbCBmcmVlDQp0byB0ZXN0IHdoaWNo
ZXZlciBjb21iaW5hdGlvbiBtYWtlcyBtb3N0IHNlbnNlIHRvIHlvdS4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
