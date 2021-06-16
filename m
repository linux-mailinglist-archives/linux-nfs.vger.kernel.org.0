Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67FE3A9EB6
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhFPPQ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 11:16:26 -0400
Received: from mail-dm6nam08on2111.outbound.protection.outlook.com ([40.107.102.111]:54400
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234507AbhFPPQ0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Jun 2021 11:16:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUQO2kOi5+SPFVovNxa0UVGm/cIQp5XhvtGrIpvUeRim+bOPFh+vD7GBA1r91CMu/029OsTm0usOa1PXRDOhuyahk64uEa8hTmSVDFJLZ44M19Iah3FIrgeX3uxlO4F5YLbP/XTKrb6NGr9HeHjhEslYsD4zqGHvLuKmKPSi0c61SJIbMAmEzelUvcBGrTEE7PW0o4u9DfgjWBZ6mw4/enoenDys0+t/Jit/mmzbTJwW2b+NSG0ND5KYsGzw+o3k2snRJ6ipdprlUthgCNYPeofNoY/hFw7pNtmrK/IOzMnaL2YON4mVNgQgzbJ3gaLaciMbTmrhx1WUJC6+zl1hhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD53In8J5/QTVWDFiRAPJYMBsFPae3wc+Ay9B0AAafs=;
 b=bTGwT78Ht/sWObPcYbwYWCDz83bMYr3sRS00V5nmHaBMgSNddWYKlvgraLd2lbbe5RGAiOyMXjjWKH/Y8FutJCpa9pkv59FJMCPT+UFyYCW1edJaRChRknj0nrsoxW16gP3iiHovN0lpd7ywvSx73Lcen8Kpuifp7zzEVrzDEo/ywA/IOXgpIvkeQGOGdbQN5H4J+05uG2wJfCIIZ6Sb7J1EHeTdRr5I0T9hURSnpUl2zyCfDcHt6Ycv++SfpOpZXWcAMIOFeGqbs69TVSy5i7q/Fqv2QMUflg89MTovVyq/JtV7QSVybXl8dvmU1fvs/lAaq2Yn4Fx07nTyETcVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD53In8J5/QTVWDFiRAPJYMBsFPae3wc+Ay9B0AAafs=;
 b=Px5b0ylk5v7iIGv8cJC3btTKHUyTs0sPq2QRe4ZZvnPiABtSJsgM46m0CVrSx6aCZq5hOQf1gqmzrGcf6bOaZVw+LQQFAxQiPZGiy3E77BxcF6nAtD0G6l1/nrLkMxXxBGle3sVABJ+kRbK0Lo/WR146g/0NKZK2u95Ni7oU6lQ=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM8PR13MB5096.namprd13.prod.outlook.com (2603:10b6:8:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.13; Wed, 16 Jun
 2021 15:14:17 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.018; Wed, 16 Jun 2021
 15:14:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Thread-Topic: [PATCH] nfs: set block size according to pnfs_blksize first
Thread-Index: AQHXYq1gTBPriIHjLEyaSjnxbRPdFqsWptwAgAAFcoCAAAPyAIAABc0AgAAJIAA=
Date:   Wed, 16 Jun 2021 15:14:17 +0000
Message-ID: <80199ffaf89fc5ef2ad77245f9a5e75beed2dc37.camel@hammerspace.com>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
         <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
         <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
         <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
         <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
In-Reply-To: <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09f3f288-0b73-4ba3-3032-08d930d968c1
x-ms-traffictypediagnostic: DM8PR13MB5096:
x-microsoft-antispam-prvs: <DM8PR13MB5096BA511B6AF8031314D25CB80F9@DM8PR13MB5096.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +P1nP8dUfSt+dcxycSFZyHmiTTpYV+NfMR1NWa4tK0d7zMl8fM7i6ikReo+oI2JnNDVFzx82CwkKfTUMPCUq+YT2Ptr/0/XgOX3VeIpYjfu4mhy2DeQFzM7EUzpIznWNe51VZsC/XkNOohtoYpKEpC9xVTXi11CelbZ14m8JQ3rfn2MnEJuvxvUQApWR/1Oh0vF6D8h4bKfNm3S0MqLAXck93sj8gG3KxuGAD4LPz92TzMxDaGjXeliSzxJ/wHkwGw4rG8xF346QNv2wGqdmmKbj2Jk/3N3b1XHKvVOx+/bJFzY2BwBw3z0eEweHPSGO3lImCrhG/Ovr9p29lWGoX2BdfUntw5PpkRwhrCBNOhs/99SgQ4/BylPzap0QE6+kM2T+OR7QUPg60VgT0A9KyQQq4g5UqaPBiFVgYMvvTNsiBWEtVyL/xfn1b7mIpHR/paQlQJX9EVdsCcFv1FUpJ27n7G43pmgyvGxNMbSn/dv9wY8eVpzFqozH7bTwneFyeyQBH1UopFKZe4yZLCAn2MGCzNMbYsj1ZjkXBdIo4fTH1mtpqqKYU2d8i6e8UVqJWq5/VRUUjdfQv4aU7RC7ZLA8bmw5q3y7aBWwNRLTAA7M7olXYbYyQtW8r6NKMO6+FWykY63v8Nxq/gWPQKvz4evDaiQ8KdAgNEd956AMMthAsiF/0eDEssAZ/0xRokaIuF22M3KZDhJ9V+pFYrmXFcPZfd0ikLyVwb7Mfuch121fQACJjj4vxuwgF+XP3HiJ2A8wPoWfb2dzfaxeY+NwGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39830400003)(366004)(376002)(346002)(91956017)(86362001)(76116006)(38100700002)(6512007)(54906003)(186003)(26005)(64756008)(66556008)(8936002)(122000001)(966005)(6916009)(71200400001)(66946007)(316002)(4326008)(66446008)(66476007)(5660300002)(6486002)(2906002)(8676002)(2616005)(478600001)(83380400001)(6506007)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVVEZm96NWlpazhkN3pnUGpnbXVoRGVoZ1B2aUFUNk1KWmpZSUdOelFsWFE4?=
 =?utf-8?B?STR1V3ZrTXNKTU9sSGlwRTZteXQrckViTkhxU3lEcHd1WlNkUHpaTmF3bGJy?=
 =?utf-8?B?YWcxcjdiWkRkNldjeW1tNjNWNDFQekxvamovbHpCY2h0OThJYVd5QlhCQ1Zj?=
 =?utf-8?B?a3h1TmlacDc2SFdhYksxemF5cVlaM0Zjb2JucWJ4dmI0YlM5R3NmN0JhV2NC?=
 =?utf-8?B?ZjhtK2RVM29hemFGb0E0N0IwNnd6Vk9wNml0UXRMaS82UU82ZXBUVU95MjJP?=
 =?utf-8?B?SGp6dUU4Y05EZW9sK0JmOFRZMmwza3dhcEozc2xJM1ljQW1ia2tKUnVEWWZn?=
 =?utf-8?B?eDNralRNTU5ZNVdxMnhZdTlPVUZMbGM2UU9vYXJQSkZqU1pOSk1KMW0yS1M4?=
 =?utf-8?B?MENkV0VFc3NJcGVnV0paL2pZUjFoWTAxNW1JVzhiYWRwY1QvRUdibVhEWXdl?=
 =?utf-8?B?b0FSTGlRUnZLSVZNMFN5OGF6QVFZVEdTWXNmNENIcDdWWDVSQlNKalN2TGM5?=
 =?utf-8?B?RFREUEVibWlPNEVaT2pFT0wyZTh3bTFjT25mRGFrYys1RXQ1MXJkd1RwYVBJ?=
 =?utf-8?B?eTkwSVFyWCs3SWdyb1JITFFzODdXdDM5TyszZVpkM1NyZXVvYTNYZ2dEZnV3?=
 =?utf-8?B?aFl2Zy9HSUovMzA2Qi9qdFlndkNidnNRK3hCOWpRekVxajFtYUxnTlZpZ2Zh?=
 =?utf-8?B?MDNSYnJCcm4vbkdPRmR5STZOMGpTQ25uQ3kwcjNxSUVHLzM0RlBhRGZMN2dr?=
 =?utf-8?B?ZkVkUnVlQ0M5bEJHWUVUQkErOSttK210SEw4VHZhdElCQUd6Zkxncmc3dzJO?=
 =?utf-8?B?Tlo4RHFieU5Fb1R2b21GMWVLSVlPRHRQdEhlckMrbVpwTlFDWEZhTk1UMW5D?=
 =?utf-8?B?UXVVTU4wN0Rpc2cxTWlFKzNBSFROZXRWaEZmaXY3Y0FWU2cwT0dkT2tickNx?=
 =?utf-8?B?YW9GdTE5b21meklydXlhZnhJNlZvaE1ZMnBJWGNhVUlFWmhSdjVGZFNjTUNk?=
 =?utf-8?B?V1RObmVjczVVQW95TFozNXBON040NStPdmRHV3F1NnVUck9kQzdSZkVxM3do?=
 =?utf-8?B?UDVuMEVoZkh1TzJMS1lrWm1sbkxheGpNNEZ5RlpoRTV4WENHU25Va3JERlI4?=
 =?utf-8?B?K1RLQm8yOUpzQnl6WFB1eTgyYTZOY0NaVDR6WElpZFB0SnZLdjlyaTR6djFF?=
 =?utf-8?B?UStzUmtFbFRIeTVhUVJIbEVHS2tQZ1dZOUlOdENJWVhxWmx2cVRRazQ4MHBi?=
 =?utf-8?B?blRWT2VXZytVbGVnRWJtaU02cWV3RHVBL3g5YU4xN3dxejIvVFpyVjlPbnVh?=
 =?utf-8?B?M2tuT0hOaTBhMWJDRllXdVpWY1hJWmROaSszdWRDY3NUWjl3QksxZUpMcVZl?=
 =?utf-8?B?VlgwZG1RTGJXWmcyT2d6cGMySXVrcm1hM2RZZDFkdmFyT08wcmpEM2xTYTZF?=
 =?utf-8?B?bzA5NUJ2S1FyeDk5eFVScmM3N2pQN09UaSt1ZTFyYzZwT3BNd1psd0Uvak1V?=
 =?utf-8?B?dWhYM0p1NUtZVlZIbnBPNXpFSGNoSW01eHlORUxRbDFYU2tEK1pZMlZENzU0?=
 =?utf-8?B?MEdPSFgwV2lac09YaUllTWFaYW5xWFM1TFdsaU5QNVFrdTZKcTNObE0xSnZh?=
 =?utf-8?B?cE1xSEtFZnhraUpqbGpIbXZDQkJOU1VodXVJejMvclNuZHJ3dmVXanNHZXZZ?=
 =?utf-8?B?dkIySGZzWVhEM1FmS3dHUlAyVytOUGJlb2N5NEZtUkh6NittYy9VK3E2eFlD?=
 =?utf-8?Q?SbNgjlLWZtTYkZH8Ybn7sZ4KjmiInQ2JQMcABX0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B3811815F30BE48A913A47FABCCC4A1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f3f288-0b73-4ba3-3032-08d930d968c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 15:14:17.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSDkYrsze7jRoZcrRetcwmNhh9Oog/zVlmf6fMuwTNbkzfyDaJ8Fup8jC10Q0PH4OACWPoHDCekuVF/lV5oinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5096
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDIyOjQxICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IEhp
IFRyb25kLA0KPiANCj4gT24gV2VkLCBKdW4gMTYsIDIwMjEgYXQgMDI6MjA6NDlQTSArMDAwMCwg
VHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMS0wNi0xNiBhdCAyMjowNiAr
MDgwMCwgR2FvIFhpYW5nIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBKdW4gMTYsIDIwMjEgYXQgMDE6
NDc6MTNQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDIw
MjEtMDYtMTYgYXQgMjA6NDQgKzA4MDAsIEdhbyBYaWFuZyB3cm90ZToNCj4gPiA+ID4gPiBXaGVu
IHRlc3RpbmcgZnN0ZXN0cyB3aXRoIGV4dDQgb3ZlciBuZnMgNC4yLCBJIGZvdW5kDQo+ID4gPiA+
ID4gZ2VuZXJpYy80ODYNCj4gPiA+ID4gPiBmYWlsZWQuIFRoZSByb290IGNhdXNlIGlzIHRoYXQg
dGhlIGxlbmd0aCBvZiBpdHMgeGF0dHIgdmFsdWUgaXMNCj4gPiA+ID4gPiDCoCBtaW4oc3RfYmxr
c2l6ZSAqIDMgLyA0LCBYQVRUUl9TSVpFX01BWCkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiB3aGlj
aCBpcyA0MDk2ICogMyAvIDQgPSAzMDcyIGZvciB1bmRlcmxheWZzIGV4dDQgcmF0aGVyIHRoYW4N
Cj4gPiA+ID4gPiBYQVRUUl9TSVpFX01BWCA9IDY1NTM2IGZvciBuZnMgc2luY2UgdGhlIGJsb2Nr
IHNpemUgd291bGQgYmUNCj4gPiA+ID4gPiB3c2l6ZQ0KPiA+ID4gPiA+ICg9MTMxMDcyKSBpZiBi
c2l6ZSBpcyBub3Qgc3BlY2lmaWVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IExldCdzIHVzZSBw
bmZzX2Jsa3NpemUgZmlyc3QgaW5zdGVhZCBvZiB1c2luZyB3c2l6ZSBkaXJlY3RseSBpZg0KPiA+
ID4gPiA+IGJzaXplIGlzbid0IHNwZWNpZmllZC4gQW5kIHRoZSB0ZXN0Y2FzZSBpdHNlbGYgY2Fu
IHBhc3Mgbm93Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENjOiBUcm9uZCBNeWtsZWJ1c3QgPHRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiA+ID4gQ2M6IEFubmEgU2NodW1h
a2VyIDxhbm5hLnNjaHVtYWtlckBuZXRhcHAuY29tPg0KPiA+ID4gPiA+IENjOiBKb3NlcGggUWkg
PGpvc2VwaC5xaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBH
YW8gWGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiBDb25zaWRlcmluZyBic2l6ZSBpcyBub3Qgc3BlY2lmaWVkLCB3ZSBtaWdodCB1c2Ug
cG5mc19ibGtzaXplDQo+ID4gPiA+ID4gZGlyZWN0bHkgZmlyc3QgcmF0aGVyIHRoYW4gd3NpemUu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gwqBmcy9uZnMvc3VwZXIuYyB8IDggKysrKysrLS0NCj4g
PiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9zdXBlci5jIGIvZnMv
bmZzL3N1cGVyLmMNCj4gPiA+ID4gPiBpbmRleCBmZTU4NTI1Y2ZlZDQuLjUwMTVlZGYwY2Q5YSAx
MDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9mcy9uZnMvc3VwZXIuYw0KPiA+ID4gPiA+ICsrKyBiL2Zz
L25mcy9zdXBlci5jDQo+ID4gPiA+ID4gQEAgLTEwNjgsOSArMTA2OCwxMyBAQCBzdGF0aWMgdm9p
ZCBuZnNfZmlsbF9zdXBlcihzdHJ1Y3QNCj4gPiA+ID4gPiBzdXBlcl9ibG9jaw0KPiA+ID4gPiA+
ICpzYiwgc3RydWN0IG5mc19mc19jb250ZXh0ICpjdHgpDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoHNucHJpbnRmKHNiLT5zX2lkLCBzaXplb2Yoc2ItPnNfaWQpLA0KPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIldToldSIsIE1BSk9SKHNiLT5zX2RldiksIE1J
Tk9SKHNiLT5zX2RldikpOw0KPiA+ID4gPiA+IMKgDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKg
aWYgKHNiLT5zX2Jsb2Nrc2l6ZSA9PSAwKQ0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBzYi0+c19ibG9ja3NpemUgPSBuZnNfYmxvY2tfYml0cyhzZXJ2ZXItPndzaXpl
LA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChzYi0+c19ibG9ja3NpemUgPT0gMCkgew0K
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgYmxr
c2l6ZSA9IHNlcnZlci0+cG5mc19ibGtzaXplID8NCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNlcnZlci0+cG5mc19ibGtzaXplIDogc2Vy
dmVyLT53c2l6ZTsNCj4gPiA+ID4gDQo+ID4gPiA+IE5BQ0suIFRoZSBwbmZzIGJsb2NrIHNpemUg
aXMgYSBsYXlvdXQgZHJpdmVyLXNwZWNpZmljIHF1YW50aXR5LA0KPiA+ID4gPiBhbmQNCj4gPiA+
ID4gc2hvdWxkIG5vdCBiZSB1c2VkIHRvIHN1YnN0aXR1dGUgZm9yIHRoZSBzZXJ2ZXItYWR2ZXJ0
aXNlZCBibG9jaw0KPiA+ID4gPiBzaXplLg0KPiA+ID4gPiBJdCBvbmx5IGFwcGxpZXMgdG8gSS9P
IF9pZl8gdGhlIGNsaWVudCBpcyBob2xkaW5nIGEgbGF5b3V0IGZvciBhDQo+ID4gPiA+IHNwZWNp
ZmljIGZpbGUgYW5kIGlzIHVzaW5nIHBORlMgdG8gZG8gSS9PIHRvIHRoYXQgZmlsZS4NCj4gPiA+
IA0KPiA+ID4gSG9uZXN0bHksIEknbSBub3Qgc3VyZSBpZiBpdCdzIG9rIGFzIHdlbGwuDQo+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+IEl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggeGF0dHJzIGF0
IGFsbC4NCj4gPiA+IA0KPiA+ID4gWWV0IG15IHF1ZXN0aW9uIGlzIGhvdyB0byBkZWFsIHdpdGgg
Z2VuZXJpYy80ODYsIHNob3VsZCB3ZSBqdXN0DQo+ID4gPiBza2lwDQo+ID4gPiB0aGUgY2FzZSBk
aXJlY3RseT8gSSBjYW5ub3QgZmluZCBzb21lIHByb3BlciB3YXkgdG8gZ2V0IHVuZGVybGF5ZnMN
Cj4gPiA+IGJsb2NrIHNpemUgb3IgcmVhbCB4YXR0ciB2YWx1ZSBsaW1pdC4NCj4gPiA+IA0KPiA+
IA0KPiA+IFJGQzgyNzYgcHJvdmlkZXMgbm8gbWV0aG9kIGZvciBkZXRlcm1pbmluZyB0aGUgeGF0
dHIgc2l6ZSBsaW1pdHMuIEl0DQo+ID4ganVzdCBub3RlcyB0aGF0IHN1Y2ggbGltaXRzIG1heSBl
eGlzdCwgYW5kIHByb3ZpZGVzIHRoZSBlcnJvciBjb2RlDQo+ID4gTkZTNEVSUl9YQVRUUjJCSUcs
IHRoYXQgdGhlIHNlcnZlciBtYXkgdXNlIGFzIGEgcmV0dXJuIHZhbHVlIHdoZW4NCj4gPiB0aG9z
ZQ0KPiA+IGxpbWl0cyBhcmUgZXhjZWVkZWQuDQo+ID4gDQo+ID4gPiBGb3Igbm93LCBnZW5lcmlj
LzQ4NiB3aWxsIHJldHVybiBFTk9TUEMgYXQNCj4gPiA+IGZzZXR4YXR0cihmZCwgInVzZXIud29y
bGQiLCB2YWx1ZSwgNjU1MzYsIFhBVFRSX1JFUExBQ0UpOw0KPiA+ID4gd2hlbiB0ZXN0aW5nIG5l
dyBuZnM0LjIgeGF0dHIgc3VwcG9ydC4NCj4gPiA+IA0KPiA+IA0KPiA+IEFzIG5vdGVkIGFib3Zl
LCB0aGUgTkZTIHNlcnZlciBzaG91bGQgcmVhbGx5IGJlIHJldHVybmluZw0KPiA+IE5GUzRFUlJf
WEFUVFIyQklHIGluIHRoaXMgY2FzZSwgd2hpY2ggdGhlIGNsaWVudCwgYWdhaW4sIHNob3VsZCBi
ZQ0KPiA+IHRyYW5zZm9ybWluZyBpbnRvIC1FMkJJRy4gV2hlcmUgZG9lcyBFTk9TUEMgY29tZSBm
cm9tPw0KPiANCj4gVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24uLi4NCj4gDQo+
IEkgdGhpbmsgdGhhdCBpcyBkdWUgdG8gZXh0NCByZXR1cm5pbmcgRU5PU1BDIHNpbmNlIEkgdGVz
dGVkDQo+IA0KPiBmc2V0eGF0dHIoZmQsICJ1c2VyLndvcmxkIiwgdmFsdWUsIDY1NTM2LCBYQVRU
Ul9SRVBMQUNFKTsNCj4gd2l0aCBleHQ0IGFzIHdlbGwgYW5kIGl0IHJldHVybmVkIEVOT1NQQywg
YW5kIEkgdGhpbmsgaXQncyByZWFzb25hYmxlDQo+IHNpbmNlIHNldHhhdHRyKCkgd2lsbCByZXR1
cm4gRU5PU1BDIGZvciBzdWNoIGNhc2VzLg0KPiBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1w
YWdlcy9tYW4yL3NldHhhdHRyLjIuaHRtbA0KPiANCj4gc2hvdWxkIHdlIHRyYW5zZm9ybSBpdCB0
byBFMkJJRyBpbnN0ZWFkIChhdCBsZWFzdCBpbiBORlMNCj4gcHJvdG9jb2wpPyBidXQgSSdtIHN0
aWxsIG5vdCBzdXJlIHRoYXQgRTJCSUcgaXMgYSB2YWxpZCByZXR1cm4gY29kZSBmb3INCj4gc2V0
eGF0dHIoKS4uLg0KDQpUaGUgc2V0eGF0dHIoKSBtYW5wYWdlIGFwcGVhcnMgdG8gc3VnZ2VzdCBF
UkFOR0UgaXMgdGhlIGNvcnJlY3QgcmV0dXJuDQp2YWx1ZSBoZXJlLg0KDQogICAgICAgRVJBTkdF
IFRoZSBzaXplIG9mIG5hbWUgb3IgdmFsdWUgZXhjZWVkcyBhIGZpbGVzeXN0ZW0tc3BlY2lmaWMN
CmxpbWl0Lg0KDQoNCkhvd2V2ZXIgSSBjYW4ndCB0ZWxsIGlmIGV4dDQgYW5kIHhmcyBldmVyIGRv
IHRoYXQuIEZ1cnRoZXJtb3JlLCBpdA0KbG9va3MgYXMgaWYgdGhlIFZGUyBpcyBhbHdheXMgcmV0
dXJuaW5nIEUyQklHIGlmIHNpemUgPiBYQVRUUl9TSVpFX01BWC4NCg0KPiANCj4gSWYgbmVjZXNz
YXJ5LCBJIHdpbGwgbG9vayBpbnRvIGl0IG1vcmUgdG9tb3Jyb3cuLi4uDQo+IA0KPiBUaGFua3Ms
DQo+IEdhbyBYaWFuZw0KPiANCj4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IEdhbyBYaWFuZw0K
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgc2ItPnNfYmxvY2tzaXplID0gbmZzX2Jsb2NrX2JpdHMoYmxrc2l6ZSwN
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnNiLQ0K
PiA+ID4gPiA+ID4gc19ibG9ja3NpemVfYml0cyk7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
fQ0KPiA+ID4gPiA+IMKgDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoG5mc19zdXBlcl9zZXRf
bWF4Ynl0ZXMoc2IsIHNlcnZlci0+bWF4ZmlsZXNpemUpOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqBzZXJ2ZXItPmhhc19zZWNfbW50X29wdHMgPSBjdHgtPmhhc19zZWNfbW50X29wdHM7DQo+
ID4gDQo+ID4gLS0gDQo+ID4gVHJvbmQgTXlrbGVidXN0DQo+ID4gTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCj4gPiANCj4gPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
