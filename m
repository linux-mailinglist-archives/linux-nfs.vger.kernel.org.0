Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F036387F07
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351264AbhERRzJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:55:09 -0400
Received: from mail-dm6nam10on2093.outbound.protection.outlook.com ([40.107.93.93]:63591
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237923AbhERRzJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 18 May 2021 13:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/Uea1lraKmfqK/tJ9+qAU+1533g6pkDxUTmpp5xVT627QXT2ShJA1hWuF9Kh339+MOJMUfa7nWxpLpXYdvuT5xYzcHiZSgBs7Wi7bAGyfP46pqWVVumaz+RNUOGz+7fFKda0xtxIcPTKVih9PduRK46xFgxhtvuLA/WBoLh9fs0W1FZknPRVsV7RIULI9b0yRJyqSb9KFWvsVkvMpIlBW42F8EvwwdoCh3x3IVZSBROyLwyChYsrP7huWmvQFgtc+vrmuF1S1z3ZHEMi3Eb4SC9TSdRA+bjY/VagGje7bMEbi6OQymbJEPYEDWEPj60dqGihDzW3o6eCIaInbSeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDSnGUM3sun98XFgDyFgcrGBTfWYKCshCxJrZqekPcI=;
 b=B4wwBNIo4ZfoLriv7u4V0OEzlYu4CNy1gEkheeo+O2Zv66fOf63z3F31GkrTxMB9rAISYwHCOi+1CTVuSFiq/zNJjVXcEIktofaSZLrw2okgficHGpaOrTMIpYEhPwtxIWfV7eqm2JornLPnItBIURkw4YGTUBL9Uzgx4cwF1N1jnaTdplkMPous4xdSTee82vRPr6kphe1+Z+daqkkJP53DleRFwXndR2/BnLvGtYAuVgJ/5NiTyhWTTO5Y87YQSG82LBsOho6VXqL3/CL/gkCE0fwhQKn8QKLs0uRvzDn1LTKSGJC1fvUYJgYmL/CzDgA1mbs2XthdGB/mc9pp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDSnGUM3sun98XFgDyFgcrGBTfWYKCshCxJrZqekPcI=;
 b=MNfRVZA0Ne2s2teDRtBZNzI5bwOcYfa877SOJYpWO9VEbNV+rhwe4/tIay/pa5ys6eR92l3Y2303lyvD4JhIQbHbnOjoB1AnjkyOGZMqWJJ4YMtN6/PGEkssEybh+QJq+P2t1Ym9woRQhxA3hY5b9hb2vGl5tLCQ7dHHrrUoM9g=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB4081.namprd13.prod.outlook.com (2603:10b6:5:2a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11; Tue, 18 May
 2021 17:53:47 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4150.011; Tue, 18 May 2021
 17:53:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Thread-Topic: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Thread-Index: AQHXSHWIwC4sG/njP0aIKkyiTSP2PqrjH9EAgAD/2YCABWzqAA==
Date:   Tue, 18 May 2021 17:53:47 +0000
Message-ID: <4387867bd64c5d3d8c67830a633b90e4a7e1ba38.camel@hammerspace.com>
References: <20210514035829.5230-1-nickhuang@synology.com>
         <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
         <YJ9yD1S6Yl2m0gOO@infradead.org>
In-Reply-To: <YJ9yD1S6Yl2m0gOO@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58293c6c-60e8-462c-0e00-08d91a25e32e
x-ms-traffictypediagnostic: DM6PR13MB4081:
x-microsoft-antispam-prvs: <DM6PR13MB40816CCEB96365426FF42D52B82C9@DM6PR13MB4081.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DS7nKUXkLh7FzWnKiTL7Rb6jPEtEPS55Acqra+I7X/4p5uPUTwibe11kOLSUJo0fVYAtv/cG9d9sMkyO8bnUXlzrTPZIX1a+VXeOBIPKx0TW3R/VkoAmCKgHQYRZ7GfqbEEdnbqvcxWMtO4RdfbmNu8DUk9RrwNZiHSQl0fSsJnz8td6km6ltnrnHel86WOW7+nwBRiXMZWY4pJkxCGf/qZ+YgxD/+WUkn/ZE8hPoOMAcc3u089QmBX5TLjS9DRJ8zwpYONRS9WUTMkKVm2QMDrY11aMcE6tnirNuFDVgT2c6I9sFKF0tBi36k0/KH942UrcxQD5IEbGEFh4l6Dt9U2JVLQnrcu9tfV656uC2nvJDpTHiOQd4CyvuXenaQEsaPIgRrpIOLvv9ZGh+btqZx0d69ld/g3jSH6+Jvaxx9fhUToiPCJ/9bEHR8yZJL2ZrYr4VDmzWHIy9/Sh+wLfnSwFYFxAwLALnbq1JdQfNRRqPqHTvZjg5R9bPVDsQnJy6j2DlyMUd+X3UmKyO152ycKYTp7rxCq2ttAxE1hwb48B+XTesdg2VisUen5clNkUlrk3PMaJO9hd4ISYWvsFvgv8ISbBmJ1s24gnBZx874Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39830400003)(366004)(346002)(122000001)(54906003)(71200400001)(38100700002)(316002)(6512007)(478600001)(5660300002)(186003)(2906002)(83380400001)(26005)(6486002)(36756003)(4326008)(4744005)(86362001)(91956017)(2616005)(66946007)(6506007)(8676002)(66446008)(64756008)(76116006)(66556008)(6916009)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R0hpZTBuaTBSSlQ3em0vZmZMbnpUb1pSV3hoK0haUlRDQWloU3BCelFSRmY1?=
 =?utf-8?B?NHZOVGV3RTdOZnFhcGtpcDBBUVp2VTJNZDM1dWJPRjdmVnhhNk90Ri9SRUVS?=
 =?utf-8?B?VnF0ckZQdG15RldqOFA5T0JQZjdpZ3ZyZldBUmZPd1NiWmtNSEJLYkZpc3hI?=
 =?utf-8?B?dW5SMmhNMTU5Y2RXcHg4NEdQOU9aRGd2K3M5L0o2cklXOU5ZZHR6dWc3RHBa?=
 =?utf-8?B?clJkNGREQldSMFB1RjZ5VWsxRFpjbnEzOXU4UEs1cGlMVnFESVFjS0NwSXlI?=
 =?utf-8?B?M0c1WDJKUWtWKzhkTW5oekh1djZBWEV5ck5NSGNGMW5hdW5mbkgycTM0RGph?=
 =?utf-8?B?MnhYV1gzK01iVWxOc25IV2JMZXl1Q0FxbzBlZEVYV01nd2dJNGlSb210dTM2?=
 =?utf-8?B?V2FSNmU2WktNOXNlL2tKTlFIR2RaalUrcURVcmk3Q1JNektnank2OWFaM1Jy?=
 =?utf-8?B?ZzBtQmJBOFRaaHQwK3l5MUV3c3VjSEFyUlgwSnQ1dTVkbjJNRU1MbUdYaXEz?=
 =?utf-8?B?dGladURCcmMyNkVMcmQ0eVllQUIyOUZPdTVxdUkzNHZ0YXVVMjkvYmV2c2pw?=
 =?utf-8?B?b2dFcVBYTkRqMGpYbGRraXdjMkZDcW9RVEJyaEVRVnZJWlU3c1dJdVRvcEFY?=
 =?utf-8?B?Q0ZNb0tFenpnS3ZXM3JaMG9Nenl4Nnk1NkN6WG9Nb0c3SUZMcUNZRTBpSFhn?=
 =?utf-8?B?TXB3ckVkVzhwaDBSaG1mM1RjbVRBdGRmMk04b210OWd5TmxmaTBwRzhUemhW?=
 =?utf-8?B?OVVkT09wWS9QTEpHSnJrSzBSdVJock1xb1BCZFd4WEpnUmU1T1lxZFdyTGRw?=
 =?utf-8?B?OGFnNDU0NVF3SmpJcGwzVkhoN09zdFBUcWNJcC9XbFNMN2FmZzBDcWtYRFdk?=
 =?utf-8?B?cEg2S2QxamtMa1RJYWY5dDVxZ05hNXhsNWdpZTFXMGJZVTAxSy9NekhZVzhP?=
 =?utf-8?B?bW9KRU9VQWovWmZqbjRFM3lTaGpSR1pVaW02VTQ3L3JaVVY0bHBCb0R3NWY3?=
 =?utf-8?B?UTFEaTJYNlU5SGpYeHRBaUoyYVU4dVE0K3V3QnliSGFzTm5QODVvVldaeEFn?=
 =?utf-8?B?M0pPQUh5VXJzb2JBTGJGRXRFempVY2tlL3R6UCs4U1hPRjlQRnl3V0t2V201?=
 =?utf-8?B?RUNndm9MWFEzZ0NEMVBBQTR3bFZBWUlaTDBlWVFPTXJtSmd2Y0hVL05nSTFQ?=
 =?utf-8?B?dGY5UnZqT2lPd29LbDNGcnFQRFc2bGVxQm1JMEZMbndUZkdKVzFzdkNvbTJs?=
 =?utf-8?B?Z2gzOFNlK1RrUVBxU0RkdmdkSU5ZUWZyczdLV0J5MHUwUVhZdDZod3NWU1dt?=
 =?utf-8?B?dnZYUlBpdGd1MG5mMGNVQUtCVkFpSHByU0U3cnJVVm56QVBoVWM2NzJUWE1I?=
 =?utf-8?B?eVJTZVJHOUVlbDZwU0dacTNZclpiMFZ0UVRzTWpGdEdmS3hVbWc0d21PdUJF?=
 =?utf-8?B?WVhCcEdwZUJ4ZGxiSGUyeDFXQ3lCcUU2WXJ6d2EzS1JaWDRkNGVmN0NLZTBJ?=
 =?utf-8?B?cjIzNlFudTBVMEswQ3BXaVhlRndwZjMwa3FuejNUWUo1ZDVPZVhPZ1pYdUNq?=
 =?utf-8?B?cmJzSlMzYUFSQmhEUG9ENThsZ1JrbFF5cUpnWGFIV21GVEtKblMyMEtlQ3J1?=
 =?utf-8?B?R0tEYWZvL1JMcGg0bjc2aGVISWNXWmszdHhEQW9jc2xERHg4MmpXLy8xTCtk?=
 =?utf-8?B?UUVvU1ZSOFNMSk5Gdm1hTVdPNVJPRTYyTDNidmdRRWRKMFFNSnJyU09Ua1hk?=
 =?utf-8?Q?5DRz8GjJeB/MDoT6PGLTWuaSl+8GYb3kdIAOXyw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B5B340E28CD5A43B35A04A9860AB8CE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58293c6c-60e8-462c-0e00-08d91a25e32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 17:53:47.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVelEmx1dtiyBdVkLXf1c1DSyS5yiE8FeBsYjNX1x2pq9kEKISf4LLF9kleMBAAiZNcRnvqfCqHrXS8ArJ9egg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4081
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIxLTA1LTE1IGF0IDA4OjAyICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBNYXkgMTQsIDIwMjEgYXQgMDM6NDY6NTdQTSArMDAwMCwgVHJvbmQgTXlr
bGVidXN0IHdyb3RlOg0KPiA+IFdoeSBsZWF2ZSB0aGUgY29tbWl0X21ldGFkYXRhKCkgY2FsbCB1
bmRlciB0aGUgbG9jaz8gSWYgeW91J3JlDQo+ID4gY29uY2VybmVkIGFib3V0IGxhdGVuY3ksIHRo
ZW4gaXQgbWFrZXMgbW9yZSBzZW5zZSB0byBjYWxsDQo+ID4gZmhfdW5sb2NrKCkNCj4gPiBiZWZv
cmUgZmx1c2hpbmcgdGhvc2UgbWV0YWRhdGEgdXBkYXRlcyB0byBkaXNrLg0KPiANCj4gQWxzbyBJ
J20gbm90IHN1cmUgd2h5IHRoZSBleHRyYSBpbm9kZSByZWZlcmVuY2UgaXMgbmVlZGVkLsKgIFdo
YXQNCj4gc3BlYWtzDQo+IGFnYWluc3QganVzdCBtb3ZpbmcgdGhlIGRwdXQgb3V0IG9mIHRoZSBs
b2NrZWQgc2VjdGlvbj8NCg0KSXNuJ3QgdGhlIGlub2RlIHJlZmVyZW5jZSB0YWtlbiBqdXN0IGlu
IG9yZGVyIHRvIGVuc3VyZSB0aGF0IHRoZSBjYWxsDQp0byBpcHV0X2ZpbmFsKCkgKGFuZCBpbiBw
YXJ0aWN1bGFyIHRoZSBjYWxsIHRvDQp0cnVuY2F0ZV9pbm9kZV9wYWdlc19maW5hbCgpKSBpcyBw
ZXJmb3JtZWQgb3V0c2lkZSB0aGUgbG9jaz8NCg0KVGhlIGRwdXQoKSBpcyBwcmVzdW1hYmx5IHVz
dWFsbHkgbm90IHBhcnRpY3VsYXJseSBleHBlbnNpdmUsIHNpbmNlIHRoZQ0KZGVudHJ5IGlzIGp1
c3QgYSBjb21wbGV0ZWx5IG9yZGluYXJ5IG5lZ2F0aXZlIGRlbnRyeSBhdCB0aGlzIHBvaW50Lg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
