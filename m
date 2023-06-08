Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDEA7283C6
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jun 2023 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFHPda (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jun 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjFHPd3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jun 2023 11:33:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1A2D47
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 08:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMItl+lc2uRjSjFIHNvYZb3D4mYJtcinYVlPMfSkUq2capWYphdDt6+qed2iYd1ZA3HUA9bptRM7+3uN+0oUlS98+eVFwkLzyv+GsAl+7OZ0VQA3PQcHpRcB/3Ji2gu4GuXO7Bo9K0BqIQ2Inkk8XV3a3nQ8yorJGX5ezSPLvJ38NhyX45xI9GvOnujzEtY0C2ecMZF5Uj9ClZiydeChdlZofArDCZrJQyGeLl7jVF5va5Z5wKbw/Pa+M6KUhgOUWUAvtNCvQdC53aGziy5yLuEb/pcvRL576vzMveBUJOagYM5TwuVgXtBv0+Z+FdWTuC0Uuxi6pnK7DG6j/uMoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCouGr3ssToNWFEQ+iJJbLWcLJIYr+xqzKpM0uORKb8=;
 b=efZ7GouZ/DdTMlYkOLrf0pIDU9PzxWUMjxsSaFTmDjAuYr8rLiNk+TeZPn4g3rdGFJIygBaYSXeDdivdZ0LBXhCfaZyRkDB6JkkAiT1D47XvsC1mKFtQZbJ+bKUKyU7PbA+AsjxykCSybcVFqI52b33Z37GpxjWamwHQ4dxhPQTGRCOy++Ba1doBkpOwZoiZP1IjEQqhTFrtTSsj5MXQzY/m6/pykPTLaOnpMD6XbR5Sli3rY7gbPcypJDg7W6CxZPFPkff1oeyMetW1GZnp0FjZBUoMQepKUZCdCl3ZZ+lpRxnLLJJDtOCgU1CZ3Rew4Cg/kvJUQ1HOoR+QgdplWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCouGr3ssToNWFEQ+iJJbLWcLJIYr+xqzKpM0uORKb8=;
 b=K6QqpoLzhAkF406G97LbH+GL/1Zvhjf74JgFy7A6HmyXQSCR2XVuo3wbJO888dIvzHVMDY5wWzI+qJd6LWFX5Xk6T7EXgRvX4dpHhGv1cyjDNA+2v1ZwZjumIeLflKdE46NSE6uvSBaeLYAYQxnPJRYQKGRQH7rCHUbycX1qsek=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5738.namprd13.prod.outlook.com (2603:10b6:a03:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 15:33:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%6]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 15:33:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
Thread-Topic: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
Thread-Index: AQHZmhiBcPmt9J8+TUWQbzQkXHpsSa+BCOMA
Date:   Thu, 8 Jun 2023 15:33:16 +0000
Message-ID: <cfde2b7b2a7f24f2652ce0bb82727cb0b810c758.camel@hammerspace.com>
References: <20230608144933.412664-1-tigran.mkrtchyan@desy.de>
In-Reply-To: <20230608144933.412664-1-tigran.mkrtchyan@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5738:EE_
x-ms-office365-filtering-correlation-id: a7ed2eef-e424-4921-9ab5-08db6835adec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZET2LpJFk65kjeIc88HjMww4lhLMzjp3eEdvKFsAu239tTeIZtHkFz2dINrv1PiKKO0iwSWyY1N7IjMxjFYvp6kDc5jXprDCZ65TNmMwVRdm7uUfarFrQFubsR8V9rVEiFnV5rSiFfSsEtErSwP9EByYcPxIMRF/W4N04L6scDYry/4eRe7nF3dqUg/jpE6sWAtKNfEqCxMOBFqLCZBOgicywu8rD682xQXIKVn3hZI+NBiPMwDP2JpcYdQAYdTs8w89zg8Z6Jfi4CgsqI/RVskzNh817sVs/wTYyw0ryKykexKjc1++E4qMDqLL9UrFRT3/M+BfYRK7fc+3EzoEkvlg1IL9EXarJmpcqlTJ/2egttYd+pomBGiLPst8VlKaM9z07i0JHPs+/DfR6GTycjTyfTpn2YdWYGHJsDJHuggBaT7y/ni2/mFkwd3cESjNdD2DlmdSxQumQptapkvNa3vRK8QubfKSonwttDjh/4KA1ITbZ0cG1rllkjDoCDMMHxOKaAR+5k6T7fcxy4ygCPzrO8LRxUQznmTAXhHIS3HzaCjaL/g7m8saW/KBvyVZOjeY+WVJ7/tnlBb8TkcNZH+4rnsWK/kYx0cavEJ90UL/LXZrZCtqr7sbf+DmePu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(346002)(366004)(136003)(396003)(451199021)(76116006)(316002)(186003)(6486002)(26005)(6506007)(36756003)(110136005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(5660300002)(6512007)(66446008)(64756008)(2906002)(478600001)(38100700002)(122000001)(71200400001)(41300700001)(38070700005)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDZRL2ZxalZTb1ZnM1pFbk9wY3UvQ2VQMnA5UzBNN1lhVDRLTnBaKzlpOUxj?=
 =?utf-8?B?RWRNazVxY016b3Y1OHFOcVUxVUJoUDZzcGVHOHVhZ2plVjRwVWZaRmwyNzdF?=
 =?utf-8?B?Z1ZMMEprNnE3LzdOcW1GcmxFeWM1b3JjajVwd2FYZTJaMnd4ZWR4emxDbjhT?=
 =?utf-8?B?Z1BWelc2K3FZV0JlVzZBZzlJeTdyRXpQNGg5VFBZTWZFdEllV0c4QkxJME5r?=
 =?utf-8?B?bVFuTDFsdExSUkFJRnJ4RGRCRytkVkgrNEd2ajE1UHlHRGg3RW9oZE1MN016?=
 =?utf-8?B?eHhQVDdmV0V0ZFpyMzJvZHpLRVQ2bHdNQjNEV3lPd0J1dDErTUJaRGc1Sncv?=
 =?utf-8?B?RW02SytLYmd4UTYxWnVaaDdRQ2pFSlA1dTcrbG9UdXg5bFhqQ2F5VUhCSnk3?=
 =?utf-8?B?SSs5NjFrLy9OMHVjUHQvUHNEamVGMlNDUVVKc1Z0RUtMTm1BSCthUjk1dFVr?=
 =?utf-8?B?STRoaEZYbmZEa2tmM0t3eHZHd2RFeDFaTzVsNUQzajdGWSt2YjJDb0VEdzdH?=
 =?utf-8?B?M0NwN0I2d08xQVpqVGFSb1NPR1E0V3V2NTFUUlE1Qkg3T0V6SG1OMjJ0ZElh?=
 =?utf-8?B?UjZZZ011Nk9ITk9KRmlaSVRSdHNpUzUxa3d3ZGRPRjNsR2ZyYm5uZDErSFdv?=
 =?utf-8?B?d1FqT00rTUh1eWcveGo2cTB2Mmx1MmViNGxOV2huR29MM3l5RTdDZFdzaUUz?=
 =?utf-8?B?blkyTGhpT0Mwc216Smw2Ti9aSmhBYm9CejI5S2NEKzFTakR1YjdrUllIYXFa?=
 =?utf-8?B?TlJDYlZqUW1qVUlDYkFibUFsamp2N09VMWNmR2FRSlMrU1NtRU1GemlKYjBk?=
 =?utf-8?B?M1ZDbkttWWN5WDdwc3FyQlZOM3hzQ0JOMzgrejQwaWhvVExSY1NaR1g2WWVL?=
 =?utf-8?B?Yko2SnlyenZQOWFiMWtKVDZhKytWRFVXSjRJTm55QTBJZGNWclhSVXUzS2Vj?=
 =?utf-8?B?RVRrN21TaWlVdG5vRzhORWd0bnFTMWRWbGlIdVpGOHkzTDVzWmIvREIvN3Fh?=
 =?utf-8?B?Nkx4dzVRTmprcEZJRDJndUpIc2ZaQ0xESTRpZ1RWN2lDRWI0WGw0MndvUU1J?=
 =?utf-8?B?S2FYd3Mwc1ppVXVMQUpQQ2hYTSthUHZGVFEvTCtlbGlwWjVxQXZJVGtVVDVJ?=
 =?utf-8?B?MHV5bmhlU2tRMmZ1NEhleDFkRTdpMWdzWFkxUVN4OVJtNmxKTmVESzBqeDg1?=
 =?utf-8?B?OFF6RDV5clIwcFcrS21ScjBBS3pKVWtOZzZUVGtXTExYbTA2NGVHZzRKYlcr?=
 =?utf-8?B?MGZpamxYS1kxbFhUanJPZjJjc00wSC9Lak9jY0dLcCtOb2lMcjd0NCtqSU5R?=
 =?utf-8?B?a085QmN3WWpwSkptaHJVSmlWWTEvUDU2WGdZSHhUclIxU2RaM2gweTZJTHg4?=
 =?utf-8?B?MXROMFhpWFloa0hPTWo5NCtkbHhmUDE0WE1wZmNZZWJHWTFsMmZNWUphc1hW?=
 =?utf-8?B?K2JLKzZiNzF0bjJ3T0xYS2hDUUdrajdjVGtmTFlkcWZ2L0MxTCtXSEVydGgr?=
 =?utf-8?B?ekhtRE4wbTlrUFBKaTJUQ1JmZFBvUEoyYys2SVRQelRWYlFNT0tzWHg1ZXlR?=
 =?utf-8?B?aEM2cVBUTHFMUWo2MncwaG96bVN1U2RsUUVhQktqZTR1MnliZVV5K2taS3Q0?=
 =?utf-8?B?VG1zcnkwUVJkU1JFODFWSTBRUWcwN0FoYnRiRlhQcXU4ZG00WDh1b0pDSDd4?=
 =?utf-8?B?SWhRbjQyS0t3TEpDT1J6aEVCVjN5WnRCaEtIZFppZ0E0eFRKZDA2Qk5mTG1r?=
 =?utf-8?B?N1Jra1Z4WEpKZlU5ckdxN3kyZy9zdVEzcTZqRDVidkJJM3d6NXRURkFKNEds?=
 =?utf-8?B?Z3kvMkVtd1B4cloxdUtQUmV2ekduN1orRHRjLy9yZ1dycHhqVGJ2ZmhKOTJ4?=
 =?utf-8?B?VWgxaVpCRkRuNzhXVTROZ215ZGpDQlBZd2wrd1RsRVJ2clRHZzVDTmNZTHI1?=
 =?utf-8?B?Q3FuNFZmZllzQTdvQW5QeG94R1hoNjRWZXdPVjB3dnI4MEh4c2V5ODhQY2RG?=
 =?utf-8?B?V3FNRjhyWVAxaGdEOExBdEp0cUt3U2FaQ0wxVlhSdjVza0ExdXJzZnlqL1kw?=
 =?utf-8?B?VW5HY0tSWnU2clZZMW5xUW0rd0d6bTl6L2xETjRQVEEyQzFEM202UUZPNDg3?=
 =?utf-8?B?T21UVzdpeS9nS1h6MnNXZEtyQnN3N2s0YXR5bkorTkM4RGhlUFlRYnBoZ3pi?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AED9003850313499FB7180CB4AFD17E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ed2eef-e424-4921-9ab5-08db6835adec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:33:16.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgWjDBrgvfJQ60ek3F4AQ56EIkeePY6mLRVGGMdzs3/PQ7L/BFJXu3DX9eMqj95RkBErCF2Way+Cilekd4sjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5738
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgVGlncmFuLA0KDQpPbiBUaHUsIDIwMjMtMDYtMDggYXQgMTY6NDkgKzAyMDAsIFRpZ3JhbiBN
a3J0Y2h5YW4gd3JvdGU6DQo+IHRoZSBuZnM0X21hcF9lcnJvcnMgZnVuY3Rpb24gY29udmVydHMg
TkZTIHNwZWNpZmljIGVycm9ycyB0byB1c2VybGFuZA0KPiBlcnJvcnMuIEhvd2V2ZXIsIGl0IGln
bm9yZXMgTkZTNEVSUl9QRVJNIGFuZCBFUEVSTSwgd2hpY2ggdGhlbiBnZXQNCj4gbWFwcGVkIHRv
IEVJTy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRpZ3JhbiBNa3J0Y2h5YW4gPHRpZ3Jhbi5ta3J0
Y2h5YW5AZGVzeS5kZT4NCj4gLS0tDQo+IMKgZnMvbmZzL25mczRwcm9jLmMgfCAyICsrDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gaW5kZXggZDM2NjUzOTBjNGNiLi43
OTUyMDVmZTRmMzAgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2Zz
L25mcy9uZnM0cHJvYy5jDQo+IEBAIC0xNzEsMTIgKzE3MSwxNCBAQCBzdGF0aWMgaW50IG5mczRf
bWFwX2Vycm9ycyhpbnQgZXJyKQ0KPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9MQVlP
VVRUUllMQVRFUjoNCj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfUkVDQUxMQ09ORkxJ
Q1Q6DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FUkVNT1RFSU87
DQo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfUEVSTToNCj4gwqDCoMKgwqDCoMKgwqDC
oGNhc2UgLU5GUzRFUlJfV1JPTkdTRUM6DQo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIC1ORlM0RVJS
X1dST05HX0NSRUQ6DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1F
UEVSTTsNCj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfQkFET1dORVI6DQo+IMKgwqDC
oMKgwqDCoMKgwqBjYXNlIC1ORlM0RVJSX0JBRE5BTUU6DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7DQo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRF
UlJfQUNDRVNTOg0KPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9TSEFSRV9ERU5JRUQ6
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FQUNDRVM7DQo+IMKg
wqDCoMKgwqDCoMKgwqBjYXNlIC1ORlM0RVJSX01JTk9SX1ZFUlNfTUlTTUFUQ0g6DQoNCkhtbS4u
LiBBcmVuJ3QgYm90aCB0aGVzZSBjYXNlcyBjb3ZlcmVkIGJ5IHRoZSBleGNlcHRpb24gYXQgdGhl
IHRvcCBvZg0KdGhlIGZ1bmN0aW9uPw0KDQpzdGF0aWMgaW50IG5mczRfbWFwX2Vycm9ycyhpbnQg
ZXJyKQ0Kew0KICAgICAgICBpZiAoZXJyID49IC0xMDAwKQ0KICAgICAgICAgICAgICAgIHJldHVy
biBlcnI7DQoNCkFzIEkgcmVhZCBpdCwgdGhhdCBzaG91bGQgbWVhbiB0aGF0IGVyciA9IC1ORlM0
RVJSX0FDQ0VTUyAoPSAtMTMpIGFuZA0KZXJyID0gLU5GUzRFUlJfUEVSTSAoPSAtMSkgd2lsbCBn
ZXQgcmV0dXJuZWQgdmVyYmF0aW0uDQoNCkFyZSB5b3Ugc2VlaW5nIHRoZXNlIE5GUzRFUlJfQUND
RVNTIGFuZCBORlM0RVJSX1BFUk0gY2FzZXMgaGl0dGluZyB0aGUNCmRlZmF1bHQ6IGRwcmludGso
KSB3aGVuIHlvdSB0dXJuIGl0IG9uPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
