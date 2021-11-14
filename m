Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49CD44FBEA
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Nov 2021 22:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhKNWBt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Nov 2021 17:01:49 -0500
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com ([40.107.236.94]:64288
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232001AbhKNWBr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 14 Nov 2021 17:01:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL+HhPgib/4S3t+Yn3YYnrgQ5UHmFKEL4qAzXwXJs4H6qx2Kuf05NofkTUExiPooB7bd4UkTgxMMIbEkAdNMxf3tlE73IAbuRWnyzclPouhsbhnZArKsmjdqnbGHDPT0T61x5oebZ0NW2E46wRe9A67wik6Y5K4UDRzU40gMSu2XHaqCGlyzSSctXF4jKY19HFhAw0TVQZXPcds+CMCoXXRMbBgxD4A83F65E0enMomvyLMc5ZsSL2Tx0XFT3zUIfDfuci8Z5c7J5P3wBzst77/a1enGAAHN+CDB77lSi3bw04pxDH3vi2k7FUao2h0LpHxo+PRvlP27qklZX2hwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw5+s0z8D0Xp6r5ninVNDMCum1b6Q6jWSrc8Lz8NszU=;
 b=aaspK8QZfvcq9oONATzvObMYIMGSPLExd/9kWX2oV3CrMXRmn40c2JAeAE5JpaWfkCO0faJp5h1wpEioMxlhITDhbRCJVUEtVWHRge/GJIWNzQBR3IfJlOc1z2N+lVQyLBwPxLrV8u03r16+5nOSuvDuVpnUVKSiWe2oHohu5ZyF5jy7yxDlvX/kVxPt3VTA4e1K2FRx6Vzf33dL8+f6LHUuCvbHRnknJ5KIqs0jnGFfMJCB+wQiN1yYETaxr74h9xURw8ZeUArVf+RGEo3oPDKzSsjrghXzC43mHe09SlvCsNykwxQ8/HCoN/gCJhiiTbm2CK091VADWkAv5lM2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw5+s0z8D0Xp6r5ninVNDMCum1b6Q6jWSrc8Lz8NszU=;
 b=fOvM5AGvmWW73O0UbnR6D24NT+b5PLe5MomoMkYHYajtdaUayQ/ywUn4j/BeOk+6XOYJw9chAWLht+L3H/hAf+6yoPi2whgeGJ8rlH2mduZiqiOdS6qrjP4wBP9RcK0pFBC47WqZNXSo+DiWYOqvF3AxahDFPJjeWbgZ/l2F9m4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3861.namprd13.prod.outlook.com (2603:10b6:610:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17; Sun, 14 Nov
 2021 21:58:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.018; Sun, 14 Nov 2021
 21:58:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: Fix exposure in nfsd4_decode_bitmap()
Thread-Topic: [PATCH v1] NFSD: Fix exposure in nfsd4_decode_bitmap()
Thread-Index: AQHX2ZR4Zk05iB8eAUu0FSUn0NwRFKwDknKA
Date:   Sun, 14 Nov 2021 21:58:51 +0000
Message-ID: <41221367b0ac816400bd207e08a3c4e17af1c21e.camel@hammerspace.com>
References: <163692036074.16710.5678362976688977923.stgit@klimt.1015granger.net>
In-Reply-To: <163692036074.16710.5678362976688977923.stgit@klimt.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 064ed4d2-5d82-41bc-a744-08d9a7b9f19d
x-ms-traffictypediagnostic: CH2PR13MB3861:
x-microsoft-antispam-prvs: <CH2PR13MB386146127767BB4ECF5CEE85B8979@CH2PR13MB3861.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRJMz9dhFgx6pd5lRjKh/W4JbQ3CWNFE7BBlc6tQa7pnzLhe02VLpbqwfC/qHbLQ62vMPlQVv1fmiApK9aZjx1QuwDkhmcTb889W/QY9TPrlguZXOzSxz/zpPaWeTNMT0VPVjpEGz4N77vVMbEp2TOq7nY3AjqhE4V0cXjO2z8BdDWG6uaIkAV6dHrUCVGEVcw/Hve0XionB6Zwb6SyjLPhHkx/70bd1XA2CA91CiXB4ofAQ/kjllYcixReskmxfiiVGxGybH0OICceV7bjPLOdhmWhGQPvYFyfOnGuuRQF+Lh8RxlJJqKrCOC39pH2Musj5uTjfI7p8TzBmPDU6RjfcJ9iwPg8hbg754w4R4yd+HmeKwlYM4fumfPdX55Q1Xy9yHR4MOH8Z+7mUt074alr2nHVe/C/4whRWgfKc5M5ZL9sldDjcC6eG8rLewYcLrkYMNFL+hmm2YRCIE/9vYmafGU9hbINwKCOjutB/qGPnS66rqkh3Vt3OiDjyG1rSvdgUREYaYBXOfzYNo1MXP4J7Xk5+5HrrMX8VWNDTe7UCeHb/MRVQU2Gf6wLU/xrTJTBSRNZmMXeeRW3eHMB4Ni3+H+h5wXuqJs9z56ea4LQTYh6fDz78wjJvIdWBD3h64Rve7iDpFXI8Q++Afu+nbpi/eoTxmoKmphBy2I9eU/btzftJ1Vs52vKaZ7CM6rwccbrIBCPXrblsAybjAUeb8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(396003)(376002)(346002)(66446008)(8936002)(110136005)(6506007)(66476007)(66556008)(6486002)(86362001)(8676002)(64756008)(316002)(6512007)(66946007)(508600001)(2906002)(4326008)(76116006)(186003)(36756003)(122000001)(5660300002)(38100700002)(2616005)(83380400001)(71200400001)(4001150100001)(26005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azRlSjBWdTY1bCtPb2gwZ1lIQWhSVUZJekIzR2RrNEtTNHdwUnQ4WVlCSWdl?=
 =?utf-8?B?VW8zOFlDQmxhVDRSZWpZWFlac0xmNnNNNzFNQmcwRk9rVldXQldtWlZ4Q09t?=
 =?utf-8?B?Q3k0Ymo2Vm4wMC9mUnYwMWN6dXZkazU0Q3lUT2NXUnRqbldnSlpBamFxQmt1?=
 =?utf-8?B?YzFSSGMrQzdoR2wwRzl1alFZMXpQWFlaTlBVY2pteEZCNy9BRDZXYTZ5YVVX?=
 =?utf-8?B?T0RTUkFjMUlSK1dFZFRDYkp0ZTlkaEh1KzYzYUFzOU1FeUJhTjUzV0s3R0M4?=
 =?utf-8?B?M0JmOGkxdmRmUXR6NWZJN1FIWlQxejJEdHhyejVqb2NNalY1N0RndEJMVmZV?=
 =?utf-8?B?bytob2F5UDl4S1lTSTdpTzBXeEZhOXM3cTVqU2Vyb2NBS2xvS3FOZ3kyNGx3?=
 =?utf-8?B?UDZEb0d2anRZem5XSlk3eDcvWFBNRWNXUnZCQ2c5Nk9kRDFtQXM0OXV6Vjkz?=
 =?utf-8?B?KzhvbXR0REtaMDlxTFJtdGY2Z1g3bVlNVUlNMHZoWE1semdTRXlqNjZNTS9v?=
 =?utf-8?B?elUrMVpiQnhwLzk3Mzc1Y2lobFFNZk5QQWdlemI2V2ZkdTBmQ2pDSmFDQmpB?=
 =?utf-8?B?U3Z5bUFmb09EajFydnlPbXBCWHpUNjh5bC9TTS82dlNWbU5CMmYzeHd5djdV?=
 =?utf-8?B?WE1VVFBLQ1U0cDdBaFVnY3oxc3FsNTNIOExrWGtLV2UrNnNHbVZGTFYrWHhQ?=
 =?utf-8?B?SEoxdG5OZS9RelVuYUpmb0hjaU5TV1I0MHFVOUllcEg0ZzM5RCtYL0JmQ0xI?=
 =?utf-8?B?T2Fndkx4TmlrbVRxbzIySjVZbExuazgvYWFLdE1hRkFoSVg4ODRyaTFFaTYy?=
 =?utf-8?B?dXdaajR4OVZZVm9xb2taazBVNkpzSHhRQ1d1Wnp1cXVTdXlVSlRsVjZ3aSs5?=
 =?utf-8?B?WE00ejVjVWJIMVFmcnI4VXNyWmV5MEN2M1RTU3MzcmtOMWNSc29sRVByeDMz?=
 =?utf-8?B?QTZ0ZklyRFRKL21YUkcrMmdIbkg0Nm9YNGNpUFpTVHQ1UVpMbzdRcXp5MGwz?=
 =?utf-8?B?TEtvWUpmU1BvcFVHTXgwMXJuM2dXK0xQSlI0SnBldmxPV0JIZmZ3V0orcmZK?=
 =?utf-8?B?dzg1K0daNC90T1RIUDViMzhrU0o4bzhJV1NmUWp5VDRYSGFOZnNOM1hWSkpi?=
 =?utf-8?B?NDBiclZZc012S21sRENpdm9SUmRpcE4vNEFyU1BpVkxPNWwyNlJvK2s5UGUz?=
 =?utf-8?B?cUhrbXZPQlFmcGZJNHpXKy9SUEp6NmdUSlU2WkhIUm0yOXYyVS8zMVovdmho?=
 =?utf-8?B?S09SaXBhS3hBMHNVTzEvbGhYZmJWVkNKd29TUk0zODhDcFFETTNhL2RDZnJu?=
 =?utf-8?B?bXByQUxWWlRrV1liSXBkYW4yTG5TVVV3T2pNOWwzMk9XR2pUYkowdWUzcElp?=
 =?utf-8?B?SVJwbjdDTmFxbTFDSnR4V0ZRL2NUYS9wam9EakEwcy9FdGNTS1AxYTFDZjFL?=
 =?utf-8?B?cHNjOHpRYTB1TlNseG5kbHN0bkk2TlZtRlQzbVBsYUJQZHZqVTdNNVJTMXND?=
 =?utf-8?B?ZGhsTlJTMWNFMTN2UElEUExSdDBZSHIyZHpqOFFWVytqUStQWjhaL1BhTWVJ?=
 =?utf-8?B?L3dOKytpSFFkWUpndE5qeE9abksvOUNVZGk2TkN1MjhzeHZRby9ma1BMbUpM?=
 =?utf-8?B?dkRTdCtQenFkc3FZaXhtbDM0SSt1dGhpYXkrcVZ0WWNzUTJnOHFPejNtQ1JY?=
 =?utf-8?B?NDhTaGYvYUJTb2pGRDlHTjgvTndkanRLL2QwUUNEZ3RQNkRtbjlCS28xYzIz?=
 =?utf-8?B?Z0w4VUhFcVh4WldBQ1BOU0hQMmhkZEQ4NlV2VmRjSmlxK056M2NmenhiQWxx?=
 =?utf-8?B?UStpS1RSK1FrdmVUMFVnZXB2UmN1bGRXTUlsZmI4d3NpSFJQNjl1MGwrRThF?=
 =?utf-8?B?ZktBTkdqRHd4L2dBdXB2WHlBZnN4dTBySWEvcHBHaHUyMDNFdFBRY290cVlF?=
 =?utf-8?B?ODFtakx6K3E2SUR0YVlJVjZVdVhicmlKc0NhNTgydmlsL2QxbU51MnlUNGx1?=
 =?utf-8?B?cEdRRU9hQ0NGRUJReGFHUnh5ODZNbGsrNG4welZtaENwVHZPYVZSUDZQdGt4?=
 =?utf-8?B?QWF2bkVpWldYb2t5NHBtSklpdndTV1l2aFZpbUpPNU91R1MwUWRTRTdZNUxE?=
 =?utf-8?B?Zmo4ZzR0eCtkZUJJOUtIV01xbmd6VmhGQTc1eHU4cm1RdFRwbGlrWkpDM2F3?=
 =?utf-8?Q?qehTtiDrLIQQqc1pSi4+OPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D69B20BF574D44C884A35C3DC99AA00@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064ed4d2-5d82-41bc-a744-08d9a7b9f19d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2021 21:58:51.2512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8ztAl6ri4FOCXlliqmSIMMAl4crfq7/cQdyad9sXMw0xdkT4vZphxeoYb+2dw8w1lfJEkxo5RxBEL+k0N6zRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3861
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTExLTE0IGF0IDE1OjE2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
cnRtQGNzYWlsLm1pdC5lZHXCoHJlcG9ydHM6DQo+ID4gbmZzZDRfZGVjb2RlX2JpdG1hcDQoKSB3
aWxsIHdyaXRlIGJleW9uZCBibXZhbFtibWxlbi0xXSBpZiB0aGUgUlBDDQo+ID4gZGlyZWN0cyBp
dCB0byBkbyBzby4gVGhpcyBjYW4gY2F1c2UgbmZzZDRfZGVjb2RlX3N0YXRlX3Byb3RlY3Q0X2Eo
KQ0KPiA+IHRvIHdyaXRlIGNsaWVudC1zdXBwbGllZCBkYXRhIGJleW9uZCB0aGUgZW5kIG9mDQo+
ID4gbmZzZDRfZXhjaGFuZ2VfaWQuc3BvX211c3RfYWxsb3dbXSB3aGVuIGNhbGxlZCBieQ0KPiA+
IG5mc2Q0X2RlY29kZV9leGNoYW5nZV9pZCgpLg0KPiANCj4gUmV3cml0ZSB0aGUgbG9vcHMgc28g
bmZzZDRfZGVjb2RlX2JpdG1hcCgpIGNhbm5vdCBpdGVyYXRlIGJleW9uZA0KPiBAYm1sZW4uDQo+
IA0KPiBSZXBvcnRlZCBieTogcnRtQGNzYWlsLm1pdC5lZHUNCj4gRml4ZXM6IGQxYzI2M2EwMzFl
OCAoIk5GU0Q6IFJlcGxhY2UgUkVBRCogbWFjcm9zIGluDQo+IG5mc2Q0X2RlY29kZV9mYXR0cigp
IikNCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+
DQo+IC0tLQ0KPiDCoGZzL25mc2QvbmZzNHhkci5jIHzCoMKgwqAgNyArKy0tLS0tDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IEhpIEJy
dWNlLQ0KPiANCj4gVGhpcyB2ZXJzaW9uIGlzIGNsZWFuZWQgdXAgc2xpZ2h0bHkgYW5kIGhhcyBi
ZWVuIHRlc3RlZCBhcyBmb2xsb3dzOg0KPiANCj4gLSBJIGFtIG5vdCBhYmxlIHRvIGNyYXNoIGEg
cGF0Y2hlZCBzZXJ2ZXIgdXNpbmcgcnRtJ3MgbmZzZF8xDQo+IC0gTm8gbmV3IEZBSUxVUkVzIHdp
dGggTkZTdjQuMSBweW5mcyB0ZXN0cw0KPiAtIE5vIG5ldyBmYWlsdXJlcyB3aXRoIHhmc3Rlc3Rz
IG9uIE5GU3Y0LjEgb3IgTkZTdjQuMg0KPiAtIE5vIG5ldyBmYWlsdXJlcyB3aXRoIHRoZSBnaXQg
cmVncmVzc2lvbiBzdWl0ZSBvbiBORlN2NC4xIG9yIE5GU3Y0LjINCj4gLSBObyByZXBvcnRzIG9m
IE5GUzRFUlJfQkFEWERSIG9yIEdBUkJBR0VfQVJHUyBkdXJpbmcgeGZzIG9yIGdpdCByZWdyDQo+
IA0KPiBIb3BlZnVsbHkgdGhhdCBleGVyY2lzZXMgZW5vdWdoIHVzZXMgb2YgbmZzZDRfZGVjb2Rl
X2JpdG1hcCgpIHRvIGJlDQo+IGNvbmZpZGVudCB0aGF0IGl0IGlzIHdvcmtpbmcgcHJvcGVybHku
DQo+IA0KPiBJIHRlc3RlZCB0aGlzIG9uIHRvcCBvZiBteSBYRFIgdHJhY2Vwb2ludCBzZXJpZXMs
IHNvIHRoZSBsaW5lIG51bWJlcnMNCj4gbWlnaHQgYmUgYSBsaXR0bGUgb2ZmIGZyb20geW91ciBj
dXJyZW50IHRyZWUuIEhvd2V2ZXIsIGl0IHNob3VsZA0KPiBvdGhlcndpc2UgYXBwbHkgY2xlYW5s
eS4NCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczR4ZHIuYyBiL2ZzL25mc2QvbmZzNHhk
ci5jDQo+IGluZGV4IDVmZjQ4MWU5Yzg1ZC4uNDc5ZDM0NTJjZTZjIDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnNkL25mczR4ZHIuYw0KPiArKysgYi9mcy9uZnNkL25mczR4ZHIuYw0KPiBAQCAtMjg4LDEx
ICsyODgsOCBAQCBuZnNkNF9kZWNvZGVfYml0bWFwNChzdHJ1Y3QgbmZzZDRfY29tcG91bmRhcmdz
DQo+ICphcmdwLCB1MzIgKmJtdmFsLCB1MzIgYm1sZW4pDQo+IMKgwqDCoMKgwqDCoMKgwqBwID0g
eGRyX2lubGluZV9kZWNvZGUoYXJncC0+eGRyLCBjb3VudCA8PCAyKTsNCj4gwqDCoMKgwqDCoMKg
wqDCoGlmICghcCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gbmZz
ZXJyX2JhZF94ZHI7DQo+IC3CoMKgwqDCoMKgwqDCoGkgPSAwOw0KPiAtwqDCoMKgwqDCoMKgwqB3
aGlsZSAoaSA8IGNvdW50KQ0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm12YWxb
aSsrXSA9IGJlMzJfdG9fY3B1cChwKyspOw0KPiAtwqDCoMKgwqDCoMKgwqB3aGlsZSAoaSA8IGJt
bGVuKQ0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm12YWxbaSsrXSA9IDA7DQo+
ICvCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBibWxlbjsgaSsrKQ0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgYm12YWxbaV0gPSAoaSA8IGNvdW50KSA/IGJlMzJfdG9fY3B1
cChwKyspIDogMDsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBuZnNfb2s7DQo+IMKg
fQ0KPiANCg0KV2h5IG5vdCBqdXN0IGNvbnZlcnQgaXQgdG8gdXNlIHhkcl9zdHJlYW1fZGVjb2Rl
X3VpbnQzMl9hcnJheSgpIGluc3RlYWQNCm9mIG1haW50YWluaW5nIHRoaXMgc2VwYXJhdGUgb3Bl
biBjb2RlZCB2ZXJzaW9uPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
