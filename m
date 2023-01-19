Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E64674378
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 21:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjASUWt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 15:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjASUWr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 15:22:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216E5D122
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 12:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDtGoPVdMt6JpiIyVU0XrlL0cyriBQVF2zCxo9lQnrb209Cl8xPweT+W+BIYXP0vrSpuN0rlaPHiOuUOYRZBsh19/XRIwOjULdApW5yQyeF0wWo5Ogd0ihk0UOdGMK7om3Si4zDpppT68ZBzWSbiw0Eav7iEBYzP6qHHIzLjW+FyRT15Rj3Zj6j1AIC+6Pl1m8dZNK60jB93loLf4nDHm6jCWoRhRk8kBVm24vXlkK07xFW4F7xmT36plTej67hHTqsPQIEI+fuq7cxtqcN8M0shMmKscc8Qeday1HKKGa7mJcNwv4D3EBAAPMKlQwPshPbZDWwHL+Uu5HwWZYlYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iamn+oY9fbCGGAGBEk4Elux6vv9d1sd/acu7sxBnxI=;
 b=hSlxAcHNVGeSrQK6UFKT6FUs8FCdlZv+jADff6FCoaXGib0CT9QGgb2buxBurFtpGEQQCoyx804Ln+i2atQ3vYd/Bl/8X3mVUUJuaqrNUOIvtRGGrkxb3SEHnEJ/CAm+1fXnXBje7UHewfWBv3QlxnZMDgsiXPPnpjO1m8XSJuSz6kn3pR5JBXgqvUqS01ubNVs26pStRDI9Anna52Wx6nzjAcGZLIqYPeY7urJYEoGDOV5iNaGR55fvZIt/a2U/cm1vJIMOEsNfo/cKJOIhz7EsBT1JPQpOGw9WD3ahgydr8GyTyDohicBv/Un1HPePHdNNtE9VDdZtQdxct6oX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iamn+oY9fbCGGAGBEk4Elux6vv9d1sd/acu7sxBnxI=;
 b=OlltJJyhORIvyv1m4b9XSFsFJABjQhe4w/fWH6MCn/HG0NhJf9+mPqPlvzKxorGnD8fnPxbKN+ddWIb55VefLtLXIYzZ2wTvQzyK2DrLr7i6lqYecyRQtWNSL331X7SnLueZpsF0L6fdGjG9W3S7YXB393EEz/736ygNyNx+YoM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3844.namprd13.prod.outlook.com (2603:10b6:a03:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 20:22:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%4]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 20:22:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] pNFS/filelayout: treat GETDEVICEINFO errors as
 LAYOUTUNAVAILABLE
Thread-Topic: [PATCH 1/1] pNFS/filelayout: treat GETDEVICEINFO errors as
 LAYOUTUNAVAILABLE
Thread-Index: AQHZLC5+WV3KtMEgS0CPt+y/JtfSTa6mDiyAgAAVRACAAAvAgA==
Date:   Thu, 19 Jan 2023 20:22:41 +0000
Message-ID: <FB31E5A9-55E0-446F-A1FF-EE0427E85178@hammerspace.com>
References: <20230119175010.57814-1-olga.kornievskaia@gmail.com>
 <C3BB5432-E3A1-4BC0-983F-0A1B11E828A0@hammerspace.com>
 <CAN-5tyE6pnnNxsVC+FpJ6rb6=66+KX6RAZb4Y-UfDH=bAr=JPA@mail.gmail.com>
In-Reply-To: <CAN-5tyE6pnnNxsVC+FpJ6rb6=66+KX6RAZb4Y-UfDH=bAr=JPA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB3844:EE_
x-ms-office365-filtering-correlation-id: 52e3550b-8b79-4f98-6385-08dafa5aea5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ACeBQrH8Oc+9ZHKXUJwlyIIAA4CbVFGholfEWS6dHubsdV6c/SgwlmKZMk6cAEJ0jYHdHnI4nGxZTS6Y5zNDErbn8SHDSRhiCt43meqKhh334VpBZ2Ch9vci6/0sXfe9W+nKh9ffSZxnrIaFXT1qHzQuAUI5L99+J/j3DDVowQV+kOJyh9447JyjCkMMEsd4+ROYmvy+Ttx0gHdWafQvMJPFgB6jk9IkI8bd5ltdBk7KvBpoYOfjXUoYi/+93Bs38o2ubBhUESqojFOlIvU4odWPCD8yPjDacbehGfX2hCqIqopkDVJy8H9kdynIT0aq5n9qC4IBBHycv1C5eURbLcetjL9D9DEKEb6MNqDhQWFQcqiC6f+Xfw5+xIBdVZaU95SVPPIpgiLJeU0ZhWtgP/cIO5e8gG+EdCjE9XLUTXhHHtzRKYP1KDqb/XI6RSJqm34zvh/bTANJZG57Y6nUnshbHDcH8F4RWmU4Kdri6fS1NuofWXC7CT9BNfzdtgaPIp7sv4gCg01Y51LHMEAVau/TwVh6dx+RvZm7249hO7q/Lb6A2wNBauomJmtBjixksQsK1DF9oFKB5/TBM0Pnp1dnKBktiQW0QkoOywLYjIASsbcGDVOjObnWi9no8TTHe9l8wvcfNrcZqovXmWxw1mh11O4lNIyirCvSEw0tZSs1o3zUC/NupdooYmvSZmpsMoPi5OxZpYfja+p+UUi/aIjSEXmi2E4wapzApNPNIaDMgA1Dq/IhibNII99B1NEJghEo/cWwSZf2b6ouyqr40A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39830400003)(366004)(396003)(451199015)(6506007)(33656002)(478600001)(54906003)(71200400001)(53546011)(6486002)(4326008)(6916009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(316002)(186003)(6512007)(5660300002)(8936002)(36756003)(41300700001)(2616005)(2906002)(83380400001)(86362001)(38100700002)(122000001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGxMSzd0bzJIcUVwTm9NTDdCVy9aL3ZRK0JpODEvV2o5cUhIZzQxVE5KRWhS?=
 =?utf-8?B?ZFk1MjFMc1hZN1d4c3p2TVVQL1ZFc0Q2NSsrM2VlbUgxTXVDUzJ0N05BV2FH?=
 =?utf-8?B?Q1ExamFqTjRTMmd2dW5qM0UrMmM1T0hpYUYwcnZKT29XdjFkb05RQUpvWjJZ?=
 =?utf-8?B?UmdTelNoN0pUSjQvTzk0SDJhaSt6K3hrU1NQNVR1dU9zUkVnQVN0NU9NLzhT?=
 =?utf-8?B?VmNDL1djTnE0c09SNEpuZVFBbERkVXJSTlAxVDhBdW5YQzZOa2pmdEh4UVBW?=
 =?utf-8?B?NmFxbFFPZGNobFpQL0xybXQ4WFhPYTJqbjBtUExJUVVFTWwwQUM1dGJVUWxy?=
 =?utf-8?B?bnVTNFY0M2owRHFPZXhYNUJ1cis2aVdCTWpUeXFNOVE5SjBEODJhNnVrQmdJ?=
 =?utf-8?B?amtOUVQwclp3Z1FqN0EramhqNFBnSk1MNlJkZFVEeVdDcWpHNnFLRDRUcjlU?=
 =?utf-8?B?MXlEUnlrQWpsZnNaRVVvcGNVbEN5c2RvNmxGSXhMWGZNZnVVRDVURTgwM0VD?=
 =?utf-8?B?cHpJS3FrMzZaS1B0K2kvZVBFWUZLL2d2THdUeEs1c3gwN2c5VGVJais4NHJa?=
 =?utf-8?B?WlFPVUM1dTNHOC9xWFZmMktpTXBHYjF5OGhyeEJyMndPNk81b01XVzlmVldR?=
 =?utf-8?B?ZFcwZ0thMkdGV204RUxFS3Z0WnovSEtIM2RWcW9iODl2WGJYUTNGNWNWUVFC?=
 =?utf-8?B?RlNHMW1xSTZPZEl2T0d3amJhRHpFQmxwM01lNWppcStLQkxJUEZPK2dsNm12?=
 =?utf-8?B?QlFoNURYWkRjSFkrcUNUNXo5cVBDcitLZGk2S2NGNHZBK2RGaFJsWVZobUhx?=
 =?utf-8?B?Tm5aRnNyeGJscFIyTjVVVUZscitVUC8vcGJSWGg4QjlnNUdockdZNjlZNVBY?=
 =?utf-8?B?NjFQUDVZN1ZFbzV1c0psL0lGU1dBZUVPL2tBcVNXSHZqSHBFOGFzSnYwTzNx?=
 =?utf-8?B?ajB0c3BMV3I3NWJXZmdQdXYyWUYwcFVPaHRuNDlMdVFpbFh3bXQ0ck1CS01M?=
 =?utf-8?B?clVxMldCdm0wcHZUMDNsNkV0Q3FPNVptL3VrQmlhcWZzbUNraFUzbXZrbmc3?=
 =?utf-8?B?Y3hWUG01S3dvNXVTQUg0em5mTy9nRDRmcitNa1VRYTBSNEJ2cEJLbHdKMTVU?=
 =?utf-8?B?UTJ2VzlTdnJhMFRiNE5nUFlHT3pOa0N5enZqcHJ1dU5MTnhkd3FGd0lieXND?=
 =?utf-8?B?RkdVU3J6L1NLbmQ5Y29oV2pjZnpRc1dtR1YzdGY2ZXkybUN1eE1aLy9iNGNZ?=
 =?utf-8?B?MllMeURGclFjeU9aYUpCVCtBNWRHckxpVnh1L2dpQmJ1SHB4VDEzS1hZMTB2?=
 =?utf-8?B?Q1c5QVU0VHZhdkwwZ0J2R2k5d3ZVc1pJYjVtRk5oQmRROXZtSUlxNCttRC9U?=
 =?utf-8?B?a1dvZnNoRTExRCtGa2hvUERIczVOa2pUOENvdEdSTUpkMDIzZzFMcnNlSDRR?=
 =?utf-8?B?UHA3NHZQOG1RRW1jNTF3QWtwdFBFT2FSL2lQaUNMMTJNQjcybWtSdjA2RkZw?=
 =?utf-8?B?MEtCRUFRNmZ2dytMM2lSeml5NjdsbXJPTmdqQXNqSUMyR3ZHYXJEdFFzOHVz?=
 =?utf-8?B?OXVQcVNsbkp1akdjc1l0Q056akE4U3JSeEVzREQ0REdzeFpCYzQxbkhnY2Mr?=
 =?utf-8?B?dU1naXphS1lpTnZrTnpoSkJXT21ydWE3NjhJdTNPVzlhOStTUHRxbUlDTTBk?=
 =?utf-8?B?eDlhMmI3ZVZFb1JWdEZBWjFzaUk3RGFkN3ZKMXhxOVZ4L1cvSDRVdjZ4TVlw?=
 =?utf-8?B?QlhxZGxvMGtsZVF4U3JUTUZUbEdyR2tncFBQNjB0eU5yNlRvOXhrWlFsVDJL?=
 =?utf-8?B?VERwNHJNVkI0dHhGdFJFWXNMaUZEMW9DTXAxM0twSDFVK1c4UEpUeitWcmg4?=
 =?utf-8?B?eW5qZ1RCeHJIWHJUeFRMRGJKVmFtdGhVaHByNUo5UXU5QzdoOHNPL2w4RzFh?=
 =?utf-8?B?WFRPQjNRaG0vSTlrMExpWVJzUVV6QWw3b2xVNU96Rlp2bm8xM001RmhYVUVn?=
 =?utf-8?B?WkQyS01OZUJXaHl1a0tadk1qelBMcjhtOTN0bWpsckJXdEUwUHJlNmg5VWg1?=
 =?utf-8?B?OUQyOUJndUJiOTJZSE5lbDZPVklqN3RoMFpMdzF6U2pRd2FuNSt1aklOaXhG?=
 =?utf-8?B?TjVaT0JjUmhpSkI1TCs5Q1JvN2NobUhSYkRBaS83ZllDS3lvQUhUZHNhNmtE?=
 =?utf-8?B?OTZHT1hPRWtjNExINHgvKzh1MTVyRmYzLzNKMExoMXBqcGN3dGpLbEFGUlp1?=
 =?utf-8?B?SFNFR1Z5VlcrWTlUMkJtc0JsMTFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B6335FFEEC1B348A5DCD29DA4B235FC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e3550b-8b79-4f98-6385-08dafa5aea5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 20:22:41.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s13mPsoyrAUI0Hkvv/7D6+x8UR0fdkuah0LWa0zOcprTS+5uoIgnnkl5a+t62zgNjQrxsNA3EWBLdGbwiGIwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSmFuIDE5LCAyMDIzLCBhdCAxNDo0MCwgT2xnYSBLb3JuaWV2c2thaWEgPG9sZ2Eu
a29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiAxOSwgMjAy
MyBhdCAxOjI0IFBNIFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdy
b3RlOg0KPj4gDQo+PiANCj4+IA0KPj4+IE9uIEphbiAxOSwgMjAyMywgYXQgMTI6NTAsIE9sZ2Eg
S29ybmlldnNrYWlhIDxvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IElmIHRoZSBjYWxsIHRvIEdFVERFVklDRUlORk8gZmFpbHMsIHRoZSBjbGllbnQgZmFsbGJh
Y2sgdG8gZG9pbmcgSU8NCj4+PiB0byBNRFMgYnV0IG9uIGV2ZXJ5IG5ldyBJTyBjYWxsLCB0aGUg
Y2xpZW50IHRyaWVzIHRvIGdldCB0aGUgZGV2aWNlDQo+Pj4gYWdhaW4uIEluc3RlYWQsIG1hcmsg
dGhlIGxheW91dCBhcyB1bmF2YWlsYWJsZSBhcyB3ZWxsLiBUaGlzIHdheQ0KPj4+IHRoZSBjbGll
bnQgd2lsbCByZS10cnkgYWZ0ZXIgYSB0aW1lb3V0IHBlcmlvZC4NCj4+PiANCj4+PiBTaWduZWQt
b2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4+PiAtLS0NCj4+
PiBmcy9uZnMvZmlsZWxheW91dC9maWxlbGF5b3V0LmMgfCAxICsNCj4+PiBmcy9uZnMvcG5mcy5j
ICAgICAgICAgICAgICAgICAgfCA3ICsrKysrKysNCj4+PiBmcy9uZnMvcG5mcy5oICAgICAgICAg
ICAgICAgICAgfCAyICsrDQo+Pj4gMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+
Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXQuYyBiL2Zz
L25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXQuYw0KPj4+IGluZGV4IDQ5NzRjZDE4Y2E0Ni4uMTNk
Zjg1NDU3Y2Y1IDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXQu
Yw0KPj4+ICsrKyBiL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXQuYw0KPj4+IEBAIC04NjIs
NiArODYyLDcgQEAgZmxfcG5mc191cGRhdGVfbGF5b3V0KHN0cnVjdCBpbm9kZSAqaW5vLA0KPj4+
IA0KPj4+IHN0YXR1cyA9IGZpbGVsYXlvdXRfY2hlY2tfZGV2aWNlaWQobG8sIGZsLCBnZnBfZmxh
Z3MpOw0KPj4+IGlmIChzdGF0dXMpIHsNCj4+PiArIHBuZnNfbWFya19sYXlvdXRfdW5hdmFpbGFi
bGUobG8sIGlvbW9kZSk7DQo+Pj4gcG5mc19wdXRfbHNlZyhsc2VnKTsNCj4+PiBsc2VnID0gTlVM
TDsNCj4+PiB9DQo+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9wbmZzLmMgYi9mcy9uZnMvcG5mcy5j
DQo+Pj4gaW5kZXggYTVkYjUxNThjNjM0Li5iYWMxNWRjZjk5YmIgMTAwNjQ0DQo+Pj4gLS0tIGEv
ZnMvbmZzL3BuZnMuYw0KPj4+ICsrKyBiL2ZzL25mcy9wbmZzLmMNCj4+PiBAQCAtNDkxLDYgKzQ5
MSwxMyBAQCBwbmZzX2xheW91dF9zZXRfZmFpbF9iaXQoc3RydWN0IHBuZnNfbGF5b3V0X2hkciAq
bG8sIGludCBmYWlsX2JpdCkNCj4+PiByZWZjb3VudF9pbmMoJmxvLT5wbGhfcmVmY291bnQpOw0K
Pj4+IH0NCj4+PiANCj4+PiArdm9pZA0KPj4+ICtwbmZzX21hcmtfbGF5b3V0X3VuYXZhaWxhYmxl
KHN0cnVjdCBwbmZzX2xheW91dF9oZHIgKmxvLCBlbnVtIHBuZnNfaW9tb2RlIGZhaWxfYml0KQ0K
Pj4+ICt7DQo+Pj4gKyBwbmZzX2xheW91dF9zZXRfZmFpbF9iaXQobG8sIHBuZnNfaW9tb2RlX3Rv
X2ZhaWxfYml0KGZhaWxfYml0KSk7DQo+PiANCj4+IEkgc3VnZ2VzdCByYXRoZXIgdXNpbmcgcG5m
c19sYXlvdXRfaW9fc2V0X2ZhaWxlZCgpIHNvIHRoYXQgd2UgYWxzbyBldmljdCB0aGUgbGF5b3V0
IHNlZ21lbnQgdGhhdCByZWZlcmVuY2VzIHRoaXMgdW5yZWNvZ25pc2VkIGRldmljZWlkLiBJbiBm
YWN0LCB0aGVyZSBpcyBhbHJlYWR5IGFuIGV4cG9ydGVkIGZ1bmN0aW9uIHBuZnNfc2V0X2xvX2Zh
aWwoKSAod2hpY2ggY291bGQgZGVmaW5pdGVseSBkbyB3aXRoIGEgYmV0dGVyIG5hbWUhKSB0aGF0
IGRvZXMgdGhpcy4NCj4gDQo+IEknbSBub3Qgb3Bwb3NlZCB0byB0aGlzIGFwcHJvYWNoLiBJbiB0
aGUgcHJvcG9zZWQgcGF0Y2gsIEkgdHJlYXRlZCBpdA0KPiBhcyB0aGUgbGF5b3V0IGJlaW5nIHN0
aWxsIHZhbGlkIGJ1dCB1bmF2YWlsYWJsZS4gTXkgcXVlc3Rpb24gaXM6IEkNCj4gdGhpbmsgd2Ug
bmVlZCB0byByZXR1cm4gdGhlIGxheW91dCBiZWZvcmUgZG9pbmcgdGhpcywgY29ycmVjdD8gU2hv
dWxkDQo+IEkgYmUgbWFraW5nIGNoYW5nZXMgdG8gZXhwb3J0IHNvbWV0aGluZyBsaWtlDQo+IHBu
ZnNfc2V0X3BsaF9yZXR1cm5faW5mbygpIG9yIHdvdWxkIGFkZGluZyBhIG5ldyBmdW5jdGlvbiB0
byBwbmZzLmMNCj4gdGhhdCBkb2VzIHBuZnNfc2V0X2xvX2ZhaWwgYW5kIHJldHVybnMgdGhlIGxh
eW91dD8NCg0KSSBzdWdnZXN0IHJhdGhlciBjaGFuZ2luZyB0aGUgY2FsbCB0byBwbmZzX21hcmtf
bWF0Y2hpbmdfbHNlZ3NfaW52YWxpZCgpIGluIHBuZnNfbGF5b3V0X2lvX3NldF9mYWlsZWQoKSBh
bmQgbWFrZSBpdCBjYWxsIHBuZnNfbWFya19tYXRjaGluZ19sc2Vnc19yZXR1cm4oKSBpbnN0ZWFk
Lg0KDQo+IA0KPiBzb21ldGhpbmcgbGlrZQ0KPiArdm9pZCBwbmZzX2ludmFsaWRhdGVfcmV0dXJu
X2xheW91dChzdHJ1Y3QgcG5mc19sYXlvdXRfc2VnbWVudCAqbHNlZykNCj4gK3sNCj4gKyAgICAg
ICBwbmZzX2xheW91dF9pb19zZXRfZmFpbGVkKGxzZWctPnBsc19sYXlvdXQsIGxzZWctPnBsc19y
YW5nZS5pb21vZGUpOw0KPiArICAgICAgIHBuZnNfc2V0X3BsaF9yZXR1cm5faW5mbyhsc2VnLT5w
bHNfbGF5b3V0LCBsc2VnLT5wbHNfcmFuZ2UuaW9tb2RlLCAwKTsNCiAgICAgICAgICBeXl5eXl5e
IHRoaXMgd29u4oCZdCBzdWZmaWNlIHRvIGludmFsaWRhdGUgdGhlIGxheW91dC4NCg0KPiArfQ0K
PiArRVhQT1JUX1NZTUJPTF9HUEwocG5mc19pbnZhbGlkYXRlX3JldHVybl9sYXlvdXQpOw0KPiAN
Cj4gICAgICAgIHN0YXR1cyA9IGZpbGVsYXlvdXRfY2hlY2tfZGV2aWNlaWQobG8sIGZsLCBnZnBf
ZmxhZ3MpOw0KPiAgICAgICAgaWYgKHN0YXR1cykgew0KPiArICAgICAgICAgICAgICAgcG5mc19p
bnZhbGlkYXRlX3JldHVybl9sYXlvdXQobHNlZyk7DQo+ICAgICAgICAgICAgICAgIHBuZnNfcHV0
X2xzZWcobHNlZyk7DQo+ICAgICAgICAgICAgICAgIGxzZWcgPSBOVUxMOw0KPiANCj4+IA0KPj4+
ICt9DQo+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBuZnNfbWFya19sYXlvdXRfdW5hdmFpbGFibGUp
Ow0KPj4+ICsNCj4+PiBzdGF0aWMgdm9pZA0KPj4+IHBuZnNfbGF5b3V0X2NsZWFyX2ZhaWxfYml0
KHN0cnVjdCBwbmZzX2xheW91dF9oZHIgKmxvLCBpbnQgZmFpbF9iaXQpDQo+Pj4gew0KPj4+IGRp
ZmYgLS1naXQgYS9mcy9uZnMvcG5mcy5oIGIvZnMvbmZzL3BuZnMuaA0KPj4+IGluZGV4IGUzZTZh
NDFmMTlkZS4uOWY0N2JkODgzZmMzIDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25mcy9wbmZzLmgNCj4+
PiArKysgYi9mcy9uZnMvcG5mcy5oDQo+Pj4gQEAgLTM0Myw2ICszNDMsOCBAQCB2b2lkIHBuZnNf
ZXJyb3JfbWFya19sYXlvdXRfZm9yX3JldHVybihzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPj4+IHZv
aWQgcG5mc19sYXlvdXRfcmV0dXJuX3VudXNlZF9ieWNsaWQoc3RydWN0IG5mc19jbGllbnQgKmNs
cCwNCj4+PiAgICAgZW51bSBwbmZzX2lvbW9kZSBpb21vZGUpOw0KPj4+IA0KPj4+ICt2b2lkIHBu
ZnNfbWFya19sYXlvdXRfdW5hdmFpbGFibGUoc3RydWN0IHBuZnNfbGF5b3V0X2hkciAqbG8sDQo+
Pj4gKyAgZW51bSBwbmZzX2lvbW9kZSBpb21vZGUpOw0KPj4+IC8qIG5mczRfZGV2aWNlaWRfZmxh
Z3MgKi8NCj4+PiBlbnVtIHsNCj4+PiBORlNfREVWSUNFSURfSU5WQUxJRCA9IDAsICAgICAgIC8q
IHNldCB3aGVuIE1EUyBjbGllbnRpZCByZWNhbGxlZCAqLw0KPj4+IC0tDQo+Pj4gMi4zMS4xDQo+
Pj4gDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
