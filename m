Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8562C940C
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 01:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbgLAAej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 19:34:39 -0500
Received: from mail-bn8nam11on2107.outbound.protection.outlook.com ([40.107.236.107]:42305
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389113AbgLAAej (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 19:34:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hosd4hQF+Q380E/1JfCndZwRwMKiJrQ4n8mvUUagYNo++uAG/5pQLDecMBRctlIIcCxeRsZgZ/ardKehOyUH3x/SHn2tP/4WYnvvQUOYyNHJkmzsQN7ApDQQMrK7dptjRx9a70g986VCGM2NbVYypqX3i+pWu38EbQPQ68OZUAuOuJ4e0qtpEW9p/fx6pGyn4Lrv9sNXF+S91xCZolHO7sx+bYUtzOELc3tJinruvUq7R5T+smm1aCqRAMQWJBl/PBjfaXFicWQzl/qdtVmfVr1vPYi3bR2sbOeeU5/vFRUtQ1qSeDLUtFw0ssdG2e9Q4OREoU7qE/EyY4r4ATmGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g14tLiokFeyr33Gzu2qON8l8PMWdnDvhvMw1n1uOmZA=;
 b=bkXImGk+LinS9EP1vvMlLG/En1is1zuUbef8tDNlL0MRVnkSoCDFR70IHqPezJUh4msuEwYp5OcbXfqRn5nd5FAeTKRFyF6Dcz7Q4pbfMcIpSvcdQmeC8CSRXc4zMBF8yRqeWULuQ4Kg6noZdvE/QhIeT9mRqdm4hgrI0EtknhXDjaGjNEO4i2Y4ixcCIBs3AXZ1E8IAqdzuLOsaB6O0YRFN9xW+IlLw3yjs1QYN8moSeH8hMp9k6ErNJKCYkv+fJR97d+qVqFzvYR6BnaohuGI4aOdIfoPAoIYVEV0vT/vpBIKlEZneXj9B7N+GoJ3DW7CyVcLZvPOwVnk9sellCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g14tLiokFeyr33Gzu2qON8l8PMWdnDvhvMw1n1uOmZA=;
 b=UfttH95+/L6qi4D6hfNBOC0Lb1KjORuE5/gLUHxwYLux46SOxY6ESlTydKTnaJfRJ0g48jFvKiEiyYFIU2aeIDhWFYcaKReYz67qlhoyuGlfaZw1iscMjubSaKqlXBgdZU4kZIx4ZYVOZ28vnbcDfUb0/QvirWu9SrH8K7lzyC4=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3261.namprd13.prod.outlook.com (2603:10b6:208:152::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.8; Tue, 1 Dec
 2020 00:33:44 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 00:33:44 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Topic: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Index: AQHWx1999UsH3Pym/kCB2OnbCNS3q6nhSfMAgAAaiwA=
Date:   Tue, 1 Dec 2020 00:33:44 +0000
Message-ID: <b6025d96f7413b05cc527c89b1d5fa239345fa03.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <20201130212455.254469-2-trondmy@kernel.org>
         <20201130225842.GA22446@fieldses.org>
In-Reply-To: <20201130225842.GA22446@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d2926b3-7d35-4d1c-009f-08d89590c280
x-ms-traffictypediagnostic: MN2PR13MB3261:
x-microsoft-antispam-prvs: <MN2PR13MB3261E1FA72FE3755E91ABF42B8F40@MN2PR13MB3261.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zdvoaAkJEBfMETKqqCjKjPD+JoQ7GiChF5UOZ9TnOGspm1lGI7nLMq0ToVhY7JW2GWZw5XW5+ASfoKCL4Cf6BRFLq4hF+IEOP3K5K1hMTtFDbsZrU6uasQ3qxwFEKW1pscNLc/fOTxc52Wz43ZVzVHtP7XWgNFGpwCwnnW8pmnjvibu21VurCPrIfMiB8ej+Ewynleh1+jAX5qEpgUqFWqXkG5JwpGrSAG/FMB+E/1MZltmFSsqAfwBn/VVa2IYBxHP8ceZspRNjYvzYPFbp/UEAZNf6I1HGsOoNxjPpuIwLzmTRVYeGH4KgPgU0Zz4xx0N4Xgl9VAshdQRWPhHOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(39840400004)(396003)(2906002)(6486002)(8936002)(86362001)(5660300002)(4001150100001)(66946007)(316002)(2616005)(6512007)(6506007)(54906003)(76116006)(66476007)(71200400001)(91956017)(64756008)(6916009)(66446008)(66556008)(26005)(8676002)(36756003)(186003)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bUpPSUxFcmtuQlhjV1hhNHdVOVpwOWVQYk02bmxjYzQwWHAveHFLMkZaMS9Z?=
 =?utf-8?B?WGpnYzZkR1VJaDJlTHNKVnlHN2d6SklCRTN6d1g2NFRjL1E4ZlJzc1o2SWNl?=
 =?utf-8?B?SlAvYXBJMG5NTFJ6bDA1c3N4aXZSVTVwWDh0MG4xOENHNENHMjd6VVAwUVp4?=
 =?utf-8?B?Vm5aWUlXVW1kM3RUcWpia01Cc01QY2ZjQnpFVGh6M1hTVTQ4elE3S0ZGMFJh?=
 =?utf-8?B?SnVDOHlUUFVNUk8zUVFLd2V6a1JBc1ZUVHhFODVaSjFHUnBoaDE0azFKblRl?=
 =?utf-8?B?RTdTQ3paeHN5cDNvaHo0UGJZVXkzQm0zNjEvbXVybGJoK2l5ampKeUFLSWFh?=
 =?utf-8?B?WEx1QWRZY21xcFpDM0ZzQkt1OUFvaS9vRm1MMzJxOEJCaENVSjkraWxRUEtN?=
 =?utf-8?B?YngzdGtmQWxTR0JVdy9oMDBCTXFKNlBPUC91YzR2UTRjUlV4bzJBQnBOQzFv?=
 =?utf-8?B?RndCQnR5bFRYVzgzTFV1L3pUbG82QWxmbCtkZUhXNy8yMEhjQXpMcjFsajl4?=
 =?utf-8?B?L051UCtDN0tsSFBVMEE0N255T2tHbS8va1NXTmVUSFJKWVR0U3NMemRia204?=
 =?utf-8?B?cFJmamtGNzNpdXpCQ1pZbTFSb2ZSc0x6dnViZ2VyUEI5aDZ4OUtaVVpzeHcr?=
 =?utf-8?B?Y2o1b3RTekxwOU5lZ0t6R2Mxc3NpWW9BQ01PTFJrSmhnMUpYSFU4Wnd2eG5u?=
 =?utf-8?B?ZGdQRUdjWG5wd3BjVHJ4dkxNMnQ5OHVnR3JlR0tPRmFpbmFzYjgyczdZS0ZT?=
 =?utf-8?B?QW9VZDc4N1MzVURwM252RHFPcFNQYnFKUndRWVR5UFJ3UVhzRUV0bHhMRGMw?=
 =?utf-8?B?a0V2S0dpU1VoNlY4V0RFbjBLM211Z0hXTE9mRmhDMnFWeklYa1h0NUt3eHNx?=
 =?utf-8?B?dGRtaWZhSzFvVitrUjM0QzlaeXZsQ0xscy8wMVRxY2pBamYzY2JVZEtrSTZ3?=
 =?utf-8?B?eTdKSGVpaFNFMWN0V2hXOFVISEdFSjkwSllBNlRSNk16UXppczhLQWNsMGNQ?=
 =?utf-8?B?TmY3cW0reTNwditCUU1EMXlHTXV1YmZjZHlXOXBjd0lKYkRkcXZ6dTByaXdZ?=
 =?utf-8?B?bVJiVzRWQUtzNWdTclN3T0NyRjJUclk2d1l4WDdydnIvd1ZZdm5yT0w1aHZs?=
 =?utf-8?B?cTBsa2NrSE9QNTdpY0YwYUcraWNubnRrbjg1QkZyZjc4eEI4UkZSZTJRcnJC?=
 =?utf-8?B?Qk9CUkt5QjBxRXBvelZ0RUhtbVMvRDFXZkNJNlhVeVMvSFJNSTcvem1GUTRu?=
 =?utf-8?B?WDdpLzJ0UmpYQldPNXhZN2dQaFVsTklFQnR2aWRTZ2MyZmIxRVJSVjdodGlM?=
 =?utf-8?Q?vSTTKGsz0Ta0+vjzOaM1kWp+UEO9jBdMmN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCF93DAE3D089742BCCB0ADE2880AC78@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2926b3-7d35-4d1c-009f-08d89590c280
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 00:33:44.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RWEMtblX3Q0kYjLjMtqNvJj01qm+hvrtmvS24pMA2vKbLKCKq4miHqstj1bPSRqJYNXxkNzHvtxciNFgsBV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3261
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDE3OjU4IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IFRoaXMgaXMgZ3JlYXQsIHRoYW5rczoNCj4gDQo+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0
IDA0OjI0OjUwUE0gLTA1MDAsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTog
SmVmZiBMYXl0b24gPGplZmYubGF5dG9uQHByaW1hcnlkYXRhLmNvbT4NCj4gPiANCj4gPiBXaXRo
IE5GU3YzIG5mc2Qgd2lsbCBhbHdheXMgYXR0ZW1wdCB0byBzZW5kIGFsb25nIFdDQyBkYXRhIHRv
IHRoZQ0KPiA+IGNsaWVudC4gVGhpcyBnZW5lcmFsbHkgaW52b2x2ZXMgc2F2aW5nIG9mZiB0aGUg
aW4tY29yZSBpbm9kZQ0KPiA+IGluZm9ybWF0aW9uDQo+ID4gcHJpb3IgdG8gZG9pbmcgdGhlIG9w
ZXJhdGlvbiBvbiB0aGUgZ2l2ZW4gZmlsZWhhbmRsZSwgYW5kIHRoZW4NCj4gPiBpc3N1aW5nIGEN
Cj4gPiB2ZnNfZ2V0YXR0ciB0byBpdCBhZnRlciB0aGUgb3AuDQo+ID4gDQo+ID4gU29tZSBmaWxl
c3lzdGVtcyAocGFydGljdWxhcmx5IGNsdXN0ZXJlZCBvciBuZXR3b3JrZWQgb25lcykgaGF2ZSBh
bg0KPiA+IGV4cGVuc2l2ZSAtPmdldGF0dHIgaW5vZGUgb3BlcmF0aW9uLiBBdG9taWNpdGl5IGlz
IGFsc28gb2Z0ZW4NCj4gPiBkaWZmaWN1bHQNCj4gPiBvciBpbXBvc3NpYmxlIHRvIGd1YXJhbnRl
ZSBvbiBzdWNoIGZpbGVzeXN0ZW1zLiBGb3IgdGhvc2UsIHdlJ3JlDQo+ID4gYmVzdA0KPiA+IG9m
ZiBub3QgdHJ5aW5nIHRvIHByb3ZpZGUgV0NDIGluZm9ybWF0aW9uIHRvIHRoZSBjbGllbnQgYXQg
YWxsLCBhbmQNCj4gPiB0bw0KPiA+IHNpbXBseSBhbGxvdyBpdCB0byBwb2xsIGZvciB0aGF0IGlu
Zm9ybWF0aW9uIGFzIG5lZWRlZCB3aXRoIGENCj4gPiBHRVRBVFRSDQo+ID4gUlBDLg0KPiA+IA0K
PiA+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBmbGFncyBmaWVsZCB0byBzdHJ1Y3QgZXhwb3J0X29w
ZXJhdGlvbnMsIGFuZA0KPiA+IGRlZmluZXMgYSBuZXcgRVhQT1JUX09QX05PV0NDIGZsYWcgdGhh
dCBmaWxlc3lzdGVtcyBjYW4gdXNlIHRvDQo+ID4gaW5kaWNhdGUNCj4gPiB0aGF0IG5mc2Qgc2hv
dWxkIG5vdCBhdHRlbXB0IHRvIHByb3ZpZGUgV0NDIGluZm8gaW4gTkZTdjMgcmVwbGllcy4NCj4g
PiBJdA0KPiA+IGFsc28gYWRkcyBhIGJsdXJiIGFib3V0IHRoZSBuZXcgZmxhZ3MgZmllbGQgYW5k
IGZsYWcgdG8gdGhlDQo+ID4gZXhwb3J0aW5nDQo+ID4gZG9jdW1lbnRhdGlvbi4NCj4gDQo+IElu
IHRoZSB2NCBjYXNlIEkgdGhpbmsgaXQgc2hvdWxkIGFsc28gdHVybiBvZmYgdGhlICJhdG9taWMi
IGZsYWcgaW4NCj4gdGhlDQo+IGNoYW5nZV9pbmZvNCBzdHJ1Y3R1cmUgdGhhdCdzIHJldHVybmVk
IGJ5IHNvbWUgb3BlcmF0aW9ucy4NCj4gDQo+IChPdXQgb2YgY3VyaW9zaXR5OiBoYXZlIHlvdSBz
ZWVuIHRoaXMgY2F1c2UgYWN0dWFsIGJ1Z3M/KQ0KPiANCg0KTm90IHNvIG11Y2ggYnVncywgYnV0
IGl0IGRlZmluaXRlbHkgY2F1c2VzIGluZWZmaWNpZW5jaWVzLiBUaGUgY2xpZW50DQpoYXMgdG8g
Z28gdG8gdGhlIHNlcnZlciBmb3IgZXZlcnkgb25lIG9mIHRoZSBXQ0MgR0VUQVRUUiBjYWxscywg
YW5kDQpuZWVkcyB0byBzZXJpYWxpc2UgdGhhdCB3aXRoIHRoZSBvcGVyYXRpb25zLiBJdCdzIGp1
c3QgYSBsYXRlbmN5IGhvZw0KZm9yIHZlcnkgbGl0dGxlIGdhaW4gd2hlbiB5b3UgYXJlIGRvaW5n
IGJ1bGsgd3JpdGluZy4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
