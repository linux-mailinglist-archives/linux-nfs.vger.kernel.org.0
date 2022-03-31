Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3E4EE25A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiCaUKw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiCaUKv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 16:10:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20707.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::707])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868619E0BA
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 13:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHzzj+DeyseeOrtD7nAqc5/fq4CdisTORJIf/6eymaBB/2sWkj4xaqT85VdC4FUwPXWllT2dIRRb5OxTLVboLYN82Ln1FcYFXX40wTRsvK3zNk49eu0EWGmioNbpRZX4MDPKvCWCScY2UV+fF81OEkRECgPK31W9w32vuXth3C5mbRz5ffuFO2v2DlCaA6ayjFVIiLvc1yBxFqsYQhNuNSEsPxPj2oMNbgN4Bs1nRELm7XbnFbXNQMbOtcB+9MYNHpWPhxj5vrxoJdPE3Mt7DQQ7nVqZXZQh0TFipMKAjUjleAhtQmRNYem247vjpKE1xpTeQjwFrz6931p09Ukojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fipYMyxuEqnrA666ojhaJo/XXmT+UIkHtJ6JI0QS7ms=;
 b=iJmJF2ewWgh1EzZeVf+kR1ndFF/+PSvONmYOeNiGw57nZPKQFPZVr57JO5krBql0h2jf5qbhCNd4WlEQiqe/GGEkMghXm47pa0625UdplpYXLrG830AMuNzmYGNQxmTAA3uO/qenDISEbrHrTEu4TDwW83C1DUdtvLn7c4R+okZSQRxc7vw3G8ULHawjmmi7ZG2P84lp4kpGojU0RKDGXgG4gYKrk0H0FvK5Kmv3veERT1U27TQ9W5XFOaERJ1QLlGX8yg0bSXNRTqW7TIQIgBGeUI1GkfYGE2sVPi9OJCCWpKi+YX3oqzxMNGxKOGCukM+J7fr7Pw/i1cUCXLhkrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fipYMyxuEqnrA666ojhaJo/XXmT+UIkHtJ6JI0QS7ms=;
 b=gEDaUW9FCwqfhcZPV2CEcuBZnvh2QLi36HXF66I44wJbNj+8KxKiG2R+9a4gvPBGAIUC0HxE7btsMwSFX9xfsZZnshMYSvS62m+v8ZyhZdTVTSOqGADp3VG6nNyj8/lebp+q3TQRklDoLho9HCfDDL+iwy3BQyyn0YZL/F/652A=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3943.namprd13.prod.outlook.com (2603:10b6:208:264::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 20:09:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 20:08:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oRE6zZm94AgAAKfQCAAARwgIAAAYeAgAABP4CAACmZAIAAFQAA
Date:   Thu, 31 Mar 2022 20:08:59 +0000
Message-ID: <b9b98ad9b21f228566a5ebd643198c669c9f3408.camel@hammerspace.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
         <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
         <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>
         <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>
         <2E4807E4-5086-4F15-B790-8D952B394FE5@oracle.com>
         <974fa169124661c2ce5ed549d499837435cc7b4c.camel@hammerspace.com>
         <E7FD566B-0570-4D14-9936-5C737B619E0B@oracle.com>
In-Reply-To: <E7FD566B-0570-4D14-9936-5C737B619E0B@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dc7c639-212d-4f04-6b7b-08da13524b5e
x-ms-traffictypediagnostic: MN2PR13MB3943:EE_
x-microsoft-antispam-prvs: <MN2PR13MB394312A0EAE6DD1C775081DCB8E19@MN2PR13MB3943.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quBcMhUX9qxvLToBeuPDIK42RcMLzlvv3LqMhrymDGtmVV+nflZS8aj6mR20KUDbAaOYNu9fX+KOOxSSeEHRX4toAL8y//8eTbcrroeqHefv2TyGPrB5ee+QAs219jju93v5QggNmrj8YscvAL1JHHoDqqjrsa1U66V90pov1ztQcwyYS8innWy8AlY8oH3xxP/EHwUe7M0oddMmSJn5zxTNV0nz09SUyvx97K7IMFSYkjWy/zr0X3PvI9oHL+4M5PYqH0mO2cwcA4p1Bsqc3dzWpG8UZz/7jttBc4gjLJ0C1liTo8BFxPSGo/3fGursSxtxWYp+6wUaOaET9OP/QOVhUMVxdOJiKm/f9mbxZRISvoC3GmyyBcG8NRZuFK45DfvAcaK4cm1bW4q1nCYx/4X5/5sauEUaFQHFrqPU2TYDCmBBSsVobNwJRqVafCTysaJ+2oPgtrz0SSXYewPxtNH3K4VNYCGlsIVNxaJLFVGV5M+zIzQndYDg0p0Rb+rRa5pvXLPAHNspW4ZxCW4QUVevGp1NDCOTYmjudB+q9zJAmA6vwxPTH5oH3/gN/fKsBb9uEFALkzIXsjbtXGk7YEfTGs49UTilGrb3Fp1DmEsa/LeVI72RBIIe1QXoDGK/HA9TlDnlVpjGOhzHrV3ZJD19O9JVxIy1CZFR37UvoGHEaciuXGE4qd5rYEkepYg5MEksWMXUxWutotQ5Ft4Pug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66946007)(66446008)(76116006)(4326008)(66476007)(122000001)(38070700005)(66556008)(508600001)(8676002)(53546011)(6916009)(86362001)(6486002)(6512007)(38100700002)(6506007)(71200400001)(8936002)(316002)(83380400001)(36756003)(2906002)(5660300002)(2616005)(186003)(3480700007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3VCZ25BeWpBdGRwY3VNN0Y4eStLanhnUFdYUW4xVHVMWWhiVEUvRkVNZUlF?=
 =?utf-8?B?cUxPd29GZzd1RnVKNFpwRUI1VVV1N09nS3FpT0pIbHBVbm5zczJ6VnAzVXk2?=
 =?utf-8?B?ZkxsczlZeXQ4Qm9NMEEvcERQRUplZThaZ0NrVlRja29BMExxR1BBT2pvaXJv?=
 =?utf-8?B?M2dsbkVMMUh5VWV1MnBBR3c4RkxnT0cyYUh2bVd0QXd2NU1kWUpoVzRkVDFG?=
 =?utf-8?B?QzFnR2pxVXF4Unl1dktqNXBNc3g1SDFWTzNmUHQrZGprR3UrL1Z6RUp0MVBB?=
 =?utf-8?B?eWtFUmY0TnF3dXJseVFqdXhBcFkxRGwzb2ZmdnpiWTB4SUlmS1MwTFNha25F?=
 =?utf-8?B?VXBScVh2WVZGMU1zQU4xT1h0NVBWaERQcHcxR2tEeisrcStsaElESkh1MUhH?=
 =?utf-8?B?eGlxNVV0VDJlbXhmVVM1QytnTkRiVHZIKzNqazd6amoyZ3V1RUpNOWNjRUlo?=
 =?utf-8?B?SWdMc05zRlJWZ3NrNTBIVThITEpjbHJ2ekdBOVhHZ2QwK1NqY2U3WSsxVjN0?=
 =?utf-8?B?Y0Z5UjlzcnNjQXpMcVRPRGcrdlhkUzRkRE9ncEVZR3VEUEtqb1JMalovTWFS?=
 =?utf-8?B?SmtFdVRBd3VIN08xWC8zOUFtbkdjdFR2QXBQYVIyMUZOWTlETWV5V0h2SmZx?=
 =?utf-8?B?eUV6VWNhMmdOVlR4TE1vVnRyblNyZFAyTjBDazdLRVR1Qlh1WEUzV2czV1la?=
 =?utf-8?B?am1UMjEzL09Nbmx5STRtUDFGUy9ZbjVvS3U2aUFUZEp5aFlDaWJKTzhBQmJR?=
 =?utf-8?B?dkZxMjVmT3FUR3dWV040cGpWQmhveGYyZy9yKzlLdHNjY3d6TzFxK2VyaDZu?=
 =?utf-8?B?WVdJeDFkUHdsQjY4cWZzNFAwTjgwTmZNRVR2UlRBT0E3aWZ0WldNbmhXc2JY?=
 =?utf-8?B?d3NFb3ZPSjRzSlBQOWU3WWdoSFEyQ01qQWticjhhQUUvV25kWGRmMThHbk1Q?=
 =?utf-8?B?ckc3YnVCVzJlc0JPQTZoT2diVjQ4MS9mWTN3dXFmeHNLK3NSSzRzT2E2Z25v?=
 =?utf-8?B?YVJMMlZ0cElFdDJCeUdwRDNoYkhmK2VQeE1lSXRhMWNZdFZrSGRDcEozcnRi?=
 =?utf-8?B?eG1OdCtUcnF3WGRPek5LM1E5WEtlVmhuWVlpc1c4dzlldUVpTjdpeG5qdHJY?=
 =?utf-8?B?SElNcWYvSEFuU2J0ZzBRT0c2TWl2ZnZQTlVuNXZiQmwrdDNTeWFzQkRnL2hS?=
 =?utf-8?B?MjNack92bCsySG8xY3Q0TERVSVdGS2QwSmRUQ0tnT1N6L09hdjU5Y1dlVmZr?=
 =?utf-8?B?UUlobU1MNUhGWmFma1RNTm1OUFJNSHdDcjZRaVc3WVFRV2Q0VE9QZkluc0NJ?=
 =?utf-8?B?VmJkSkVUNWQwaXBJTm41b045UUNVUWNUWVN0Wk9yWDE5WndQUm9zekQ3N0tV?=
 =?utf-8?B?QlE5eStKY1hmV2wzUXpoVjRFRFJZMlNFSmRKN3Q3MW8xTC80NnM4ZHZEOUdn?=
 =?utf-8?B?MnNxckd6SnBRNWpveGZEY01BTjRkQS9DM2xVRUJFYjRXYnpNOVQ3Mk5BRWZK?=
 =?utf-8?B?cHk0VCtzUnBjYTRFdXdiT2RvajE0cThDa295S09GUU1KcVNNbWZDOEk1c2xv?=
 =?utf-8?B?QXFnTDlLYXFkVC81V3dTaFBtd1BhZ3ZZNFgwcmQ0eEdlWExDS3BQK3JvVC93?=
 =?utf-8?B?eDE3WjZJNjhkbmVoTmN2QzBEZ1hTRW9KSDhOUlZsY2oyNTJqZkYyT0Yvd0o2?=
 =?utf-8?B?ekVMeE1icW9wai9uOFY2UXRpTGJXK2RpRDFaYjVkVGNrcXpzR2UwaXpYV1pV?=
 =?utf-8?B?ak91WnlzUWFZaHdPcU9GTDdNZ3lpZERkaVE3SytIbDE2dG1BaTgzeGZ6SDR1?=
 =?utf-8?B?cm90dDNvcWxhUWtNOU1aWEIrZkFMeElBWXV4aEVxczhuejQ0YVE1cnNhN05X?=
 =?utf-8?B?RTN4Y0RxNkc0dUl0VGRMNytRWDlkVXZEUjZTODJXU0wrUlBLaGk4ekhNRHZE?=
 =?utf-8?B?a1VrWC8rc2REeXM5aEkzV2RxdkNWczlPZjhHSWl1Ri9URlkzOVVhOCtZVS9y?=
 =?utf-8?B?Z0FpNEdXUitZUEZuQXhxazVsSXJSV3cyUFJKZlp3a0Z5dDFiTm1hYzAwUWlT?=
 =?utf-8?B?eEJFQWZNNjBUQUtHNGl1RHhTMTRvSmdUaE9GSURhUzgyVzdtdkVZa1dGOTht?=
 =?utf-8?B?cDJST29lMUYwMmcvcWg0b1UzWDhPZStrOS9VUTh4UC9iTG03dk1qTFQ1UGUr?=
 =?utf-8?B?ZTM3TVZadjJSYTZOQkwvcFpEM295S0tPSERnMUJhNEJrU1JCaXZDNTBIcG9E?=
 =?utf-8?B?S0I3K014bXh1TkhrbVZKOFZDOXJxK3FwRXZxNlRtUzNBUVJjMUNieVVvUlA4?=
 =?utf-8?B?UzhyREE4WDNjRlNFWmdlRUwxOFI0VEZGQ2c2dDN4eW1XeXRsMG4xQndpeWox?=
 =?utf-8?Q?pZz6GiC/9D4vx5+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD5B69F52BA4F94AA96CE8E901E4D669@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc7c639-212d-4f04-6b7b-08da13524b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 20:08:59.8133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmdQrzKTtnGPeFElSwYkhSnv4UOpGEulBuzWqi3cOwnfPTBL/f+C0kkdmFomp4I6Am27/FzXWfMwmlP5nqW7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTMxIGF0IDE4OjUzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiA+IE9uIE1hciAzMSwgMjAyMiwgYXQgMTI6MjQgUE0sIFRyb25kIE15a2xlYnVzdA0K
PiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAy
MDIyLTAzLTMxIGF0IDE2OjIwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4gPiAN
Cj4gPiA+ID4gT24gTWFyIDMxLCAyMDIyLCBhdCAxMjoxNSBQTSwgVHJvbmQgTXlrbGVidXN0DQo+
ID4gPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4g
PiBIbW0uLi4gSGVyZSdzIGFub3RoZXIgdGhvdWdodC4gV2hhdCBpZiB0aGlzIHdlcmUgYSBkZWZl
cnJlZA0KPiA+ID4gPiByZXF1ZXN0DQo+ID4gPiA+IHRoYXQgaXMgYmVpbmcgcmVwbGF5ZWQgYWZ0
ZXIgYW4gdXBjYWxsIHRvIG1vdW50ZCBvciB0aGUNCj4gPiA+ID4gaWRtYXBwZXI/DQo+ID4gPiA+
IEl0DQo+ID4gPiA+IHdvdWxkIG1lYW4gdGhhdCB0aGUgc3luY2hyb25vdXMgd2FpdCBpbiBjYWNo
ZV9kZWZlcl9yZXEoKQ0KPiA+ID4gPiBmYWlsZWQsDQo+ID4gPiA+IHNvIGl0DQo+ID4gPiA+IGlz
IGdvaW5nIHRvIGJlIHJhcmUsIGJ1dCBpdCBjb3VsZCBoYXBwZW4gb24gYSBjb25nZXN0ZWQgc3lz
dGVtLg0KPiA+ID4gPiANCj4gPiA+ID4gQUZBSUNTLCBzdmNfZGVmZXIoKSBkb2VzIF9ub3RfIHNh
dmUgcnFzdHAtPnJxX3hwcnRfY3R4dCwgc28NCj4gPiA+ID4gc3ZjX2RlZmVycmVkX3JlY3YoKSB3
b24ndCByZXN0b3JlIGl0IGVpdGhlci4NCj4gPiA+IA0KPiA+ID4gVHJ1ZSwgYnV0IFRDUCBhbmQg
VURQIGJvdGggdXNlIHJxX3hwcnRfY3R4dCwgc28gd291bGRuJ3Qgd2UgaGF2ZQ0KPiA+ID4gc2Vl
biB0aGlzIHByb2JsZW0gYmVmb3JlIG9uIGEgc29ja2V0IHRyYW5zcG9ydD8NCj4gPiANCj4gPiBU
Q1AgZG9lcyBub3Qgc2V0IHJxX3hwcnRfY3R4dCwgYW5kIG5vYm9keSByZWFsbHkgdXNlcyBVRFAg
dGhlc2UNCj4gPiBkYXlzLg0KPiA+IA0KPiA+ID4gSSBuZWVkIHRvIGF1ZGl0IGNvZGUgdG8gc2Vl
IGlmIHNhdmluZyBycV94cHJ0X2N0eHQgaW4gc3ZjX2RlZmVyKCkNCj4gPiA+IGlzIHNhZmUgYW5k
IHJlYXNvbmFibGUgdG8gZG8uIE1heWJlIEJydWNlIGhhcyBhIHRob3VnaHQuDQo+ID4gDQo+ID4g
SXQgc2hvdWxkIGJlIHNhZmUgZm9yIHRoZSBVRFAgY2FzZSwgQUZBSUNTLiBJIGhhdmUgbm8gb3Bp
bmlvbiBhcyBvZg0KPiA+IHlldA0KPiA+IGFib3V0IGhvdyBzYWZlIGl0IGlzIHRvIGRvIHdpdGgg
UkRNQS4NCj4gDQo+IEl0J3MgcGxhdXNpYmxlIHRoYXQgYSBkZWZlcnJlZCByZXF1ZXN0IGNvdWxk
IGJlIHJlcGxheWVkLCBidXQgSSBkb24ndA0KPiB1bmRlcnN0YW5kIHRoZSBkZWZlcnJhbCBtZWNo
YW5pc20gZW5vdWdoIHRvIGtub3cgd2hldGhlciB0aGUgcmN0eHQNCj4gd291bGQgYmUgcmVsZWFz
ZWQgYmVmb3JlIHRoZSBkZWZlcnJlZCByZXF1ZXN0IGNvdWxkIGJlIGhhbmRsZWQuIEl0DQo+IGRv
ZXNuJ3QgbG9vayBsaWtlIGl0IHdvdWxkLCBidXQgSSBjb3VsZCBtaXN1bmRlcnN0YW5kIHNvbWV0
aGluZy4NCj4gDQo+IFRoZXJlJ3MgYSBsb25nc3RhbmRpbmcgdGVzdGluZyBnYXAgaGVyZTogTm9u
ZSBvZiBteSB0ZXN0IHdvcmtsb2Fkcw0KPiBhcHBlYXIgdG8gZm9yY2UgYSByZXF1ZXN0IGRlZmVy
cmFsLiBJIGRvbid0IHJlY2FsbCBCcnVjZSBoYXZpbmcNCj4gc3VjaCBhIHRlc3QgZWl0aGVyLg0K
PiANCj4gSXQgd291bGQgYmUgbmljZSBpZiB3ZSBoYWQgc29tZXRoaW5nIHRoYXQgY291bGQgZm9y
Y2UgdGhlIHVzZSBvZiB0aGUNCj4gZGVmZXJyYWwgcGF0aCwgbGlrZSBhIGNvbW1hbmQgbGluZSBv
cHRpb24gZm9yIG1vdW50ZCB0aGF0IHdvdWxkIGNhdXNlDQo+IGl0IHRvIHNsZWVwIGZvciBzZXZl
cmFsIHNlY29uZHMgYmVmb3JlIHJlc3BvbmRpbmcgdG8gYW4gdXBjYWxsLiBJdA0KPiBtaWdodCBh
bHNvIGJlIGRvbmUgd2l0aCB0aGUga2VybmVsJ3MgZmF1bHQgaW5qZWN0b3IuDQo+IA0KDQpZb3Ug
anVzdCBuZWVkIHNvbWUgbWVjaGFuaXNtIHRoYXQgY2F1c2VzIHN2Y19nZXRfbmV4dF94cHJ0KCkg
dG8gc2V0DQpycXN0cC0+cnFfY2hhbmRsZS50aHJlYWRfd2FpdCB0byB0aGUgdmFsdWUgJzAnLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
