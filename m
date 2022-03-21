Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF24E33B7
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 00:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiCUXFX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 19:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiCUXFM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 19:05:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2115.outbound.protection.outlook.com [40.107.223.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447403A5EB;
        Mon, 21 Mar 2022 15:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwH8QQ9pc02muYSBuljw+xeqKZS38x3HkSRki+6Tcqen7SMkYFwPwj5oKxKLhMJ6jtYQ94DPutxC0dbHhPuIdFDaIO+A59MgyQW11tRenYTvysVABPMsJ5d9II2a3o487MGypWlTCyAf4jYg08iNvzlImaDDzFeq+OgI1AWdqzIXtitOAO5vpPAtRqX/Avz/Mg1g+nSdXUtU9UpmkA4JnhJU1794TceBumws/jMcpiocQEfnUkIzscLADLYRC3N4upGBghCkHERRT9Bv67wSE6/MEk81unFdpgWW15KXhOkxwNAPTKFvCBlU1mJoE3gHD84ZdYObr2vGC1jPU9XA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTdZgHhIrYZKMZmcSPCPXDIbhAoWgmnDxbj+swU5YgQ=;
 b=joKnRF6IXgtMoaB/M2AXY79kXWpc+xwwmmszXwAuJu6nn/MnZxLn5nE/W1EPvINWVTgNnSi1XyVep+ElA97SnkT6aF7vZ1x/STAz1cWwTdbKr6iaIm/cQeI88lT9X0HFb7xbjTffSUpeDbARzBnlgwovgDtHiVJESTRbHksZoJNQtONJ3VRDRHTNI7iupqNLVVWVUZqB3L4NATdcqFpebwvvTAK8R3LsB+qpjCMoj58Zm6GF+c3C8q+Zj0aR6NeJyBGNyCb1JZ51wdKDVhkaPoR844T+qOexyRKXWgDR1T1/Bwloi3Y4z1SmebxTjhEmq8l9HRRmQ7F10hyLftKPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTdZgHhIrYZKMZmcSPCPXDIbhAoWgmnDxbj+swU5YgQ=;
 b=VRijlJCNSsWpnJCT/0MkB97zyzedDz5yQdOb0/fMXpkjGrjAGlo0SzaEb5meFy9pVASimucR9RTI1oqMtEhivSZ3sOS4tbxa6/20muGp3AxSO9iQf1rQQTa/8ck/qr9TPmQEa+t+V6fhPqQuTlV1wcRo/6kaUwEb5d20npj/dIU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5499.namprd13.prod.outlook.com (2603:10b6:a03:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Mon, 21 Mar
 2022 22:50:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5102.015; Mon, 21 Mar 2022
 22:50:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jack@suse.cz" <jack@suse.cz>,
        "amir73il@gmail.com" <amir73il@gmail.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Thread-Topic: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Thread-Index: AQHYOyajLa8/8HRLJEmjaX9teCCEe6zF3FKAgACW7ICAA0KLAIAAv/GA
Date:   Mon, 21 Mar 2022 22:50:11 +0000
Message-ID: <31f7822e84583235d84b8c7be24360c46c7450f7.camel@hammerspace.com>
References: <20220319001635.4097742-1-khazhy@google.com>
         <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
         <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
         <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
In-Reply-To: <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65a4d814-81e6-4c3e-b07e-08da0b8d27fd
x-ms-traffictypediagnostic: SJ0PR13MB5499:EE_
x-microsoft-antispam-prvs: <SJ0PR13MB5499A7DAD8BCCD32D5CBAF83B8169@SJ0PR13MB5499.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JNCOCvB4gJJ1JGBPyvMHvEKauUHSIdl7/oVvLqQXuDEETv+r9hPZb73jmM9oV9s8Sa9ZIY+hzdtSfXletoBvnuJJEs7vx4OQnyN+tBv4vUaAhWC/oL1Qjn7BHV2BfUKkOYzcmi5El+Pcvi8A5aEv4zH8mOFdUCrpgScqzJkTtcprHeT89D586ipKM4MXDQaWkShfQAsFevI6h/lYWh08Uhruko+lh7MeAjjkvVq6WLcVsfqeXEXpybtCBUCtH+S/IVghs/RyoB8u+zkSRud+/Aied7dJPWg6srkGZ8biJO9aW/8OuouNLBMt5Uee/JxC62deRVdf+LVhPWC1qN9ERj0e5lohY9Xcw95HyNQNX74ucDaTt6PQUhzSWTACXWKjQBCoQdh9lzdnZE4F+Kxp5e5SNXVe0NjIkTssW25eIo2Ft8G9eHhGtI1YUUuFezy1TCpqjd+3q1WZDn7Vi8PrDBE8N1gAGwiFVcLQrwx08xRPVM/GebFbh7UcvtciQhgOla7w92TC1OZeH3/j+JcVGvEYm90PzV/VFb8v9rZcbA7iH+I6sBWAWs9ux5kIveEeqYhd2e8C/9DTWdcmTi7ROwFIMsC57nL/V/R0JVuXY8ZcGpFb8jJ3nKel8yhHdeQVd7YHTNXYPhV9GrmeavsYzO68orrZQlHz1W2+Z50GQ3hccEKPkb5rXGLNw7pPIPhZEui7Y86QgKIoFEpJ5opbYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(2906002)(64756008)(508600001)(66476007)(66446008)(36756003)(66946007)(86362001)(66556008)(54906003)(110136005)(71200400001)(6486002)(8676002)(4326008)(6506007)(6512007)(2616005)(53546011)(316002)(186003)(83380400001)(26005)(122000001)(38100700002)(38070700005)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WElYVTk4OGpINmUrK25xV0dNb3JSeERyNmw3UzUwUnRUdFNCaytLckt1Y2pT?=
 =?utf-8?B?MCtaQ2xORXFNeDlnaEliUDFHUnNPMUx4UjlJMHJ2SkFLL3ZLUG9VTjdyN1cv?=
 =?utf-8?B?S2MvUnZLc3c1c09xRHBNbTMrYW44UkxkeUwxZnlaa29zWHhseG9CTDBBREd3?=
 =?utf-8?B?WUdxcjJ0eUFHWWVhbC81QVBpaXJXT3lveStWcExBcUlMQ2RwS0w3WG9ocWk5?=
 =?utf-8?B?NHdKQ0hjK2h6cVBLbW04Vkhxd0huUWJHaVliU3JtUUlrUTB1aHoyZ21MTldU?=
 =?utf-8?B?NjJ0Y0RiVXgwK2dZWldzQml2emRaRWhSMHJPWHNQRXRtZWVLbHNaend4S3Z5?=
 =?utf-8?B?U3ZzNnZhZUppOXNKZUJaL1VUOHZrYzV1eldnTWR2SUNVS1BzQWo1ekl2cE9q?=
 =?utf-8?B?bjVQVk01ODBGMUV6ditUNHpVYzkvM1pPQXB1OEY3cFMwbEYyYWV3eFhkclFF?=
 =?utf-8?B?N0dpaE5xNEYwNElySDYvL2xXL294enoyY0FjUEthZ0RqNjJuWll4UTc0YjlH?=
 =?utf-8?B?Vkx3MDBMeTFlVUZVK2VFb0poT2t0cXZQbllFUE5kYVJWdGxZVVM0K28xU2E4?=
 =?utf-8?B?ZnNTTFdoSEhGZUYzWXJTckZnU1lIdXVydWF3Rm5KaFBSOU5qT0VVUThIc01u?=
 =?utf-8?B?ZTdicnFTeXpZRHlVYis0WDJUUzJiamtEWHdleEQwZnpiRTkvamdNajQrcFIy?=
 =?utf-8?B?ZEVQYlU2K0g2dWxmM2VOdnJUemp1ODlqYUt5NENNQ0JYRlFDNmwydjVSTjRG?=
 =?utf-8?B?UlNpL3FnMHRxcnEzZG1hRUFLTXVDVmlJM1BPN1UrVEszUm44cG1KZk15eVpw?=
 =?utf-8?B?WjRidGNmNzV5ZW8vUFYyUlFpa05FNkVMbVFNUm5UMHE4eE9KcXM5Vk4wL3h1?=
 =?utf-8?B?OTFKUDdHS2tPeFp0K1FHV1FxU2pkMWlUb3lLL0NnN2xTaHptMCsrT0dJeit5?=
 =?utf-8?B?dkRkNWhUQkJCeW8wNjdtbUs5MTE5ZDgyV09lUkgxbVBTYkdNa2VZN0J6cnQx?=
 =?utf-8?B?Sk13YTFBVXp2Z2Qzd3pkL3ZFc25YN2tRenJyeXRaVkE3N2lPazk4T0xRRlF5?=
 =?utf-8?B?SW4yaU9kZy9IMTBRVUhpaXpNZFpSU0w2N3lvWHRJTWZUZEpwZ0txWTVZQ3Vk?=
 =?utf-8?B?bzZRK3JBMkt1NDI2azYySmllcXdudjEvbGdZK055d0xabDR6TmlMelNvdkI5?=
 =?utf-8?B?TmkxTXpMbjZyeGtGYktQeDY2Z1RaZHUvMXI3N0Q5eDVIRHZUL21xamV6Q3J4?=
 =?utf-8?B?amRsYVlqNmN4SG9kd3lSQ1FEM2ZXZXRZckhwNkNnSEJFOXpBWEs4ekJNQkFB?=
 =?utf-8?B?dm9QeENNTFM1Mmw3SnZPQS9PbGhkMzRwcXV0WnBGdm5mWTFIaUxyZGx5OE5G?=
 =?utf-8?B?K1VwZnRZYy90bHpWM1UyVjZwSG9Fc1B5VmZvUXpuS0NhUllxeTBWSGZSUDNY?=
 =?utf-8?B?ZXNVb3hxdUtkNVlodDZ6UVFaZmtjbGc3azh2M2ZpaTRDSlJSTjNGdmt0Y3R1?=
 =?utf-8?B?S2QxM0ozVjh2R2JTOVFoSnVkK0ZDck1DZytUNHVIaEJnZXFLeU1zaWRIQmRW?=
 =?utf-8?B?YnM3OU5EMk9XeUdQTEluaGI5T1gybEJyQnIzYmhmRlNvUGxZS0RYVW1TQnNq?=
 =?utf-8?B?TXBkNUJTWldiSGV0QjRyTUVYcmhnSnFxZWg2KytHZk5HRzhQdmkyNGRVdUs5?=
 =?utf-8?B?Ti9sT21xY0xDQUVyTTBVMjZUMWZLMDlReUt5aUV6aG1vTktTeCtUbFRtNmhX?=
 =?utf-8?B?anphaXMrQjV6NXd1S21HbzFSUjhPRkZJelRBQXlQOGQxdWJEdWIrcXYweEtn?=
 =?utf-8?B?Ky9rMWRTUnpZTFczanl5VGJ5MkV3UUQwRjFDRVIyaExkZ2tFTm9MVjRMbkE5?=
 =?utf-8?B?Y0JrUjEwTEhyaWdkZERSN1BIbjZJYXRRVm9GYUk3dXg5eFB0ZnJYQnFIV2Y4?=
 =?utf-8?B?d3JWQ09JZWJVVWl1eW9lTGtIS0NBTmp2Vko0dkFFMytyVlcvVXV0d3pudCtB?=
 =?utf-8?B?SVhleDNlUUdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2342523EE17DF4F85FFFE194B4ABF7F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a4d814-81e6-4c3e-b07e-08da0b8d27fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 22:50:11.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALiwQdi0groT2RsxC7J+4QqFkFbD31/ygdv5/rgkEr19cN8pnSGuiFfwGHqMKxheOYYhdmCCyuPvNuqfi0YbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTIxIGF0IDEyOjIzICswMTAwLCBKYW4gS2FyYSB3cm90ZToNCj4gT24g
U2F0IDE5LTAzLTIyIDExOjM2OjEzLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gPiBPbiBTYXQs
IE1hciAxOSwgMjAyMiBhdCA5OjAyIEFNIFRyb25kIE15a2xlYnVzdA0KPiA+IDx0cm9uZG15QGhh
bW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIEZyaSwgMjAyMi0wMy0xOCBh
dCAxNzoxNiAtMDcwMCwgS2hhemhpc21lbCBLdW15a292IHdyb3RlOg0KPiA+ID4gPiBmc25vdGlm
eV9hZGRfaW5vZGVfbWFyayBtYXkgYWxsb2NhdGUgd2l0aCBHRlBfS0VSTkVMLCB3aGljaCBtYXkN
Cj4gPiA+ID4gcmVzdWx0DQo+ID4gPiA+IGluIHJlY3Vyc2luZyBiYWNrIGludG8gbmZzZCwgcmVz
dWx0aW5nIGluIGRlYWRsb2NrLiBTZWUgYmVsb3cNCj4gPiA+ID4gc3RhY2suDQo+ID4gPiA+IA0K
PiA+ID4gPiBuZnNkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEwqDCoMKgIDAgMTU5MTUzNsKgwqDC
oMKgwqAgMiAweDgwMDA0MDgwDQo+ID4gPiA+IENhbGwgVHJhY2U6DQo+ID4gPiA+IMKgX19zY2hl
ZHVsZSsweDQ5Ny8weDYzMA0KPiA+ID4gPiDCoHNjaGVkdWxlKzB4NjcvMHg5MA0KPiA+ID4gPiDC
oHNjaGVkdWxlX3ByZWVtcHRfZGlzYWJsZWQrMHhlLzB4MTANCj4gPiA+ID4gwqBfX211dGV4X2xv
Y2srMHgzNDcvMHg0YjANCj4gPiA+ID4gwqBmc25vdGlmeV9kZXN0cm95X21hcmsrMHgyMi8weGEw
DQo+ID4gPiA+IMKgbmZzZF9maWxlX2ZyZWUrMHg3OS8weGQwIFtuZnNkXQ0KPiA+ID4gPiDCoG5m
c2RfZmlsZV9wdXRfbm9yZWYrMHg3Yy8weDkwIFtuZnNkXQ0KPiA+ID4gPiDCoG5mc2RfZmlsZV9s
cnVfZGlzcG9zZSsweDZkLzB4YTAgW25mc2RdDQo+ID4gPiA+IMKgbmZzZF9maWxlX2xydV9zY2Fu
KzB4NTcvMHg4MCBbbmZzZF0NCj4gPiA+ID4gwqBkb19zaHJpbmtfc2xhYisweDFmMi8weDMzMA0K
PiA+ID4gPiDCoHNocmlua19zbGFiKzB4MjQ0LzB4MmYwDQo+ID4gPiA+IMKgc2hyaW5rX25vZGUr
MHhkNy8weDQ5MA0KPiA+ID4gPiDCoGRvX3RyeV90b19mcmVlX3BhZ2VzKzB4MTJmLzB4M2IwDQo+
ID4gPiA+IMKgdHJ5X3RvX2ZyZWVfcGFnZXMrMHg0M2YvMHg1NDANCj4gPiA+ID4gwqBfX2FsbG9j
X3BhZ2VzX3Nsb3dwYXRoKzB4NmFiLzB4MTFjMA0KPiA+ID4gPiDCoF9fYWxsb2NfcGFnZXNfbm9k
ZW1hc2srMHgyNzQvMHgyYzANCj4gPiA+ID4gwqBhbGxvY19zbGFiX3BhZ2UrMHgzMi8weDJlMA0K
PiA+ID4gPiDCoG5ld19zbGFiKzB4YTYvMHg4YjANCj4gPiA+ID4gwqBfX19zbGFiX2FsbG9jKzB4
MzRiLzB4NTIwDQo+ID4gPiA+IMKga21lbV9jYWNoZV9hbGxvYysweDFjNC8weDI1MA0KPiA+ID4g
PiDCoGZzbm90aWZ5X2FkZF9tYXJrX2xvY2tlZCsweDE4ZC8weDRjMA0KPiA+ID4gPiDCoGZzbm90
aWZ5X2FkZF9tYXJrKzB4NDgvMHg3MA0KPiA+ID4gPiDCoG5mc2RfZmlsZV9hY3F1aXJlKzB4NTcw
LzB4NmYwIFtuZnNkXQ0KPiA+ID4gPiDCoG5mc2RfcmVhZCsweGE3LzB4MWMwIFtuZnNkXQ0KPiA+
ID4gPiDCoG5mc2QzX3Byb2NfcmVhZCsweGMxLzB4MTEwIFtuZnNkXQ0KPiA+ID4gPiDCoG5mc2Rf
ZGlzcGF0Y2grMHhmNy8weDI0MCBbbmZzZF0NCj4gPiA+ID4gwqBzdmNfcHJvY2Vzc19jb21tb24r
MHgyZjQvMHg2MTAgW3N1bnJwY10NCj4gPiA+ID4gwqBzdmNfcHJvY2VzcysweGY5LzB4MTEwIFtz
dW5ycGNdDQo+ID4gPiA+IMKgbmZzZCsweDEwZS8weDE4MCBbbmZzZF0NCj4gPiA+ID4gwqBrdGhy
ZWFkKzB4MTMwLzB4MTQwDQo+ID4gPiA+IMKgcmV0X2Zyb21fZm9yaysweDM1LzB4NDANCj4gPiA+
ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtoYXpoaXNtZWwgS3VteWtvdiA8a2hhemh5QGdv
b2dsZS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGZzL25mc2QvZmlsZWNhY2hlLmMgfCA0
ICsrKysNCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gPiA+
IA0KPiA+ID4gPiBNYXJraW5nIHRoaXMgUkZDIHNpbmNlIEkgaGF2ZW4ndCBhY3R1YWxseSBoYWQg
YSBjaGFuY2UgdG8gdGVzdA0KPiA+ID4gPiB0aGlzLA0KPiA+ID4gPiB3ZQ0KPiA+ID4gPiB3ZSdy
ZSBzZWVpbmcgdGhpcyBkZWFkbG9jayBmb3Igc29tZSBjdXN0b21lcnMuDQo+ID4gPiA+IA0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9maWxlY2FjaGUuYyBiL2ZzL25mc2QvZmlsZWNhY2hl
LmMNCj4gPiA+ID4gaW5kZXggZmRmODlmY2YxYTBjLi5hMTQ3NjBmOWI0ODYgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2ZzL25mc2QvZmlsZWNhY2hlLmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzZC9maWxl
Y2FjaGUuYw0KPiA+ID4gPiBAQCAtMTIxLDYgKzEyMSw3IEBAIG5mc2RfZmlsZV9tYXJrX2ZpbmRf
b3JfY3JlYXRlKHN0cnVjdA0KPiA+ID4gPiBuZnNkX2ZpbGUNCj4gPiA+ID4gKm5mKQ0KPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZnNub3RpZnlfbWFya8KgwqDCoCAqbWFyazsNCj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG5mc2RfZmlsZV9tYXJrwqDCoCAqbmZtID0gTlVMTCwg
Km5ldzsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlub2RlICppbm9kZSA9IG5mLT5u
Zl9pbm9kZTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgcGZsYWdzOw0KPiA+
ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgZG8gew0KPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmbmZzZF9maWxlX2Zzbm90aWZ5X2dyb3VwLQ0K
PiA+ID4gPiA+bWFya19tdXRleCk7DQo+ID4gPiA+IEBAIC0xNDksNyArMTUwLDEwIEBAIG5mc2Rf
ZmlsZV9tYXJrX2ZpbmRfb3JfY3JlYXRlKHN0cnVjdA0KPiA+ID4gPiBuZnNkX2ZpbGUNCj4gPiA+
ID4gKm5mKQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3LT5uZm1f
bWFyay5tYXNrID0gRlNfQVRUUklCfEZTX0RFTEVURV9TRUxGOw0KPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVmY291bnRfc2V0KCZuZXctPm5mbV9yZWYsIDEpOw0KPiA+
ID4gPiANCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogZnNub3RpZnkg
YWxsb2NhdGVzLCBhdm9pZCByZWN1cnNpb24gYmFjaw0KPiA+ID4gPiBpbnRvIG5mc2QNCj4gPiA+
ID4gKi8NCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGZsYWdzID0gbWVt
YWxsb2Nfbm9mc19zYXZlKCk7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlcnIgPSBmc25vdGlmeV9hZGRfaW5vZGVfbWFyaygmbmV3LT5uZm1fbWFyaywNCj4gPiA+ID4g
aW5vZGUsDQo+ID4gPiA+IDApOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtZW1hbGxvY19ub2ZzX3Jlc3RvcmUocGZsYWdzKTsNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIElmIHRoZSBhZGQgd2FzIHN1Y2Nlc3NmdWwsIHRoZW4gcmV0dXJuIHRo
ZQ0KPiA+ID4gPiBvYmplY3QuDQo+ID4gPiANCj4gPiA+IElzbid0IHRoYXQgc3RhY2sgdHJhY2Ug
c2hvd2luZyBhIHNsYWIgZGlyZWN0IHJlY2xhaW0sIGFuZCBub3QgYQ0KPiA+ID4gZmlsZXN5c3Rl
bSB3cml0ZWJhY2sgc2l0dWF0aW9uPw0KPiA+ID4gDQo+ID4gPiBEb2VzIG1lbWFsbG9jX25vZnNf
c2F2ZSgpL3Jlc3RvcmUoKSByZWFsbHkgZml4IHRoaXMgcHJvYmxlbT8gSXQNCj4gPiA+IHNlZW1z
DQo+ID4gPiB0byBtZSB0aGF0IGl0IGNhbm5vdCwgcGFydGljdWxhcmx5IHNpbmNlIGtuZnNkIGlz
IG5vdCBhDQo+ID4gPiBmaWxlc3lzdGVtLCBhbmQNCj4gPiA+IHNvIGRvZXMgbm90IGV2ZXIgaGFu
ZGxlIHdyaXRlYmFjayBvZiBkaXJ0eSBwYWdlcy4NCj4gPiA+IA0KPiA+IA0KPiA+IE1heWJlIE5P
RlMgdGhyb3R0bGVzIGRpcmVjdCByZWNsYWltcyB0byB0aGUgcG9pbnQgdGhhdCB0aGUgcHJvYmxl
bQ0KPiA+IGlzDQo+ID4gaGFyZGVyIHRvIGhpdD8NCj4gPiANCj4gPiBUaGlzIHJlcG9ydCBjYW1l
IGluIGF0IGdvb2QgdGltaW5nIGZvciBtZS4NCj4gPiANCj4gPiBJdCBkZW1vbnN0cmF0ZXMgYW4g
aXNzdWUgSSBkaWQgbm90IHByZWRpY3QgZm9yICJ2b2xhdGlsZSInIGZhbm90aWZ5DQo+ID4gbWFy
a3MgWzFdLg0KPiA+IEFzIGZhciBhcyBJIGNhbiB0ZWxsLCBuZnNkIGZpbGVjYWNoZSBpcyBjdXJy
ZW50bHkgdGhlIG9ubHkgZnNub3RpZnkNCj4gPiBiYWNrZW5kIHRoYXQNCj4gPiBmcmVlcyBmc25v
dGlmeSBtYXJrcyBpbiBtZW1vcnkgc2hyaW5rZXIuICJ2b2xhdGlsZSIgZmFub3RpZnkgbWFya3MN
Cj4gPiB3b3VsZCBhbHNvDQo+ID4gYmUgZXZpY3RhYmxlIGluIHRoYXQgd2F5LCBzbyB0aGV5IHdv
dWxkIGV4cG9zZSBmYW5vdGlmeSB0byB0aGlzDQo+ID4gZGVhZGxvY2suDQo+ID4gDQo+ID4gRm9y
IHRoZSBzaG9ydCB0ZXJtLCBtYXliZSBuZnNkIGZpbGVjYWNoZSBjYW4gYXZvaWQgdGhlIHByb2Js
ZW0gYnkNCj4gPiBjaGVja2luZw0KPiA+IG11dGV4X2lzX2xvY2tlZCgmbmZzZF9maWxlX2Zzbm90
aWZ5X2dyb3VwLT5tYXJrX211dGV4KSBhbmQgYWJvcnQNCj4gPiB0aGUNCj4gPiBzaHJpbmtlci4g
SSB3b25kZXIgaWYgdGhlcmUgaXMgYSBwbGFjZSBmb3IgYSBoZWxwZXINCj4gPiBtdXRleF9pc19s
b2NrZWRfYnlfbWUoKT8NCj4gPiANCj4gPiBKYW4sDQo+ID4gDQo+ID4gQSByZWxhdGl2ZWx5IHNp
bXBsZSBmaXggd291bGQgYmUgdG8gYWxsb2NhdGUNCj4gPiBmc25vdGlmeV9tYXJrX2Nvbm5lY3Rv
ciBpbg0KPiA+IGZzbm90aWZ5X2FkZF9tYXJrKCkgYW5kIGZyZWUgaXQsIGlmIGEgY29ubmVjdG9y
IGFscmVhZHkgZXhpc3RzIGZvcg0KPiA+IHRoZSBvYmplY3QuDQo+ID4gSSBkb24ndCB0aGluayB0
aGVyZSBpcyBhIGdvb2QgcmVhc29uIHRvIG9wdGltaXplIGF3YXkgdGhpcw0KPiA+IGFsbG9jYXRp
b24NCj4gPiBmb3IgdGhlIGNhc2Ugb2YgYSBub24tZmlyc3QgZ3JvdXAgdG8gc2V0IGEgbWFyayBv
biBhbiBvYmplY3Q/DQo+IA0KPiBJbmRlZWQsIG5hc3R5LiBWb2xhdGlsZSBtYXJrcyB3aWxsIGFk
ZCBncm91cC0+bWFya19tdXRleCBpbnRvIGEgc2V0DQo+IG9mDQo+IGxvY2tzIGdyYWJiZWQgZHVy
aW5nIGlub2RlIHNsYWIgcmVjbGFpbS4gU28gYW55IGFsbG9jYXRpb24gdW5kZXINCj4gZ3JvdXAt
Pm1hcmtfbXV0ZXggaGFzIHRvIGJlIEdGUF9OT0ZTIG5vdy4gVGhpcyBpcyBub3QganVzdCBhYm91
dA0KPiBjb25uZWN0b3INCj4gYWxsb2NhdGlvbnMgYnV0IGFsc28gbWFyayBhbGxvY2F0aW9ucyBm
b3IgZmFub3RpZnkuIE1vdmluZw0KPiBhbGxvY2F0aW9ucyBmcm9tDQo+IHVuZGVyIG1hcmtfbXV0
ZXggaXMgYWxzbyBwb3NzaWJsZSBzb2x1dGlvbiBidXQgcGFzc2luZyBwcmVhbGxvY2F0ZWQNCj4g
bWVtb3J5DQo+IGFyb3VuZCBpcyBraW5kIG9mIHVnbHkgYXMgd2VsbC4gU28gdGhlIGNsZWFuZXN0
IHNvbHV0aW9uIEkgY3VycmVudGx5DQo+IHNlZSBpcw0KPiB0byBjb21lIHVwIHdpdGggaGVscGVy
cyBsaWtlICJmc25vdGlmeV9sb2NrX2dyb3VwKCkgJg0KPiBmc25vdGlmeV91bmxvY2tfZ3JvdXAo
KSIgd2hpY2ggd2lsbCBsb2NrL3VubG9jayBtYXJrX211dGV4IGFuZCBhbHNvDQo+IGRvDQo+IG1l
bWFsbG9jX25vZnNfc2F2ZSAvIHJlc3RvcmUgbWFnaWMuIA0KDQpBcyBoYXMgYWxyZWFkeSBiZWVu
IHJlcG9ydGVkLCB0aGUgcHJvYmxlbSB3YXMgZml4ZWQgaW4gTGludXggNS41IGJ5IHRoZQ0KZ2Fy
YmFnZSBjb2xsZWN0b3IgcmV3cml0ZSwgYW5kIHNvIHRoaXMgaXMgbm8gbG9uZ2VyIGFuIGlzc3Vl
Lg0KDQpJbiBhZGRpdGlvbiwgcGxlYXNlIG5vdGUgdGhhdCBtZW1hbGxvY19ub2ZzX3NhdmUvcmVz
dG9yZSBhbmQgdGhlIHVzZSBvZg0KR0ZQX05PRlMgd2FzIG5ldmVyIGEgc29sdXRpb24sIGJlY2F1
c2UgaXQgZG9lcyBub3QgcHJldmVudCB0aGUga2luZCBvZg0KZGlyZWN0IHJlY2xhaW0gdGhhdCB3
YXMgaGFwcGVuaW5nIGhlcmUuIFlvdSdkIGhhdmUgdG8gZW5mb3JjZQ0KR0ZQX05PV0FJVCBhbGxv
Y2F0aW9ucywgYWZhaWNzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
