Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE33A079D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhFHXOO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 19:14:14 -0400
Received: from mail-bn7nam10on2133.outbound.protection.outlook.com ([40.107.92.133]:42176
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235458AbhFHXOK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 19:14:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0YaXfT5+xlSNlPBJ9Wl00cjm1+KBxI2oa0Y7NywX/jJ8K6jvUraUhGrFvcWJKXucgFDq4hA0rWnCREYkH7Zq+lmmq/VCFygvV+DNNxdxL6F3/S87yb4oZrHmN1js/zkbTSee3zr6wRi/VjrgaEdRlxm0FNcFdgeRB+wUIJ6224tqUWD6oxKARUMntHTsNb6SyL0TMqCNDnu0v5ZNXJD0yCCo0vekjBjmB2PCkuHodaHyhlszjs5hIN61/TkMhD7buASmvgKFe+y3WtuW07PH/4HzU7spU+RwS23n87FgrENtH2NAlGrM3V1LNbxj9HSWph2bXIoEg6HBvPrnbPbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GcVol8Dydisix6gBeMizIGn0FnS1qO/3PwJK6lwHCU=;
 b=RMXMw98EQnDw+Bh/4UwtN+HufdD6XfJby3bJHPaMR1VPrCbh2ac84xAoOsH2+xH9PPkgdeyq9/kuGpTTDIgHpWyoug/0eQTl+PsqSgPWp9jq49DiCfg0lwORDp3by+4PdUL3FdW1m/H5aBhkMKSi+hkicUBcDt1Kp5ANmwpEb319lFQYEvNpbceQEXS8XtoSg351yc4+PPpSShGLNKiUbl0Sq++ufUWuvqDBmYsWgqV6bOhucCQ/FFTjT6rv+EvinhnI92K/TyuYkIeUToQonjLz+B24ZbTxGA8hIq15vt8f2Ds9ewOQLrxlZTAp7MV/GtVYRYP7bRcPKO/ydEjeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GcVol8Dydisix6gBeMizIGn0FnS1qO/3PwJK6lwHCU=;
 b=NlHINW7Uh3V478bF4rVFGOH6bZwv45nh2gY/sYcqJWicArdF39ttHxH5LqWG9gEVc6dT6eIrzGL4RvJ2ufc34ZnpiEcf1F8jHbYecmLZaClZA+w6K3rjmiSjhe7uoNjIdc6W3te3iSnnIw+HDEctZBIKQZPfSwVxUKb0X3oyN20=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3052.namprd13.prod.outlook.com (2603:10b6:5:196::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12; Tue, 8 Jun
 2021 23:12:13 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 23:12:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAAA5OAgAAB/QCAAAE6AIAAArsAgAALcACAAALLAIAAAgwAgAAGsACAAAKVAA==
Date:   Tue, 8 Jun 2021 23:12:13 +0000
Message-ID: <c59a989f47e507170320e1b9ee9ca6854b05ef08.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
         <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
         <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
         <CAN-5tyHsVprR9_0Q98X8Dd5zYgaX79V7R76KPSzDwQFMYL2qcA@mail.gmail.com>
         <e136a646089d862c476b555ea6b009cf19f5fadd.camel@hammerspace.com>
         <CAN-5tyG+fmfXsgT6rEURBKT3xUn5_pgwY=JzYCtFWKPpbnkzZQ@mail.gmail.com>
         <ba534fc8bb625870f31c086528c7f6d879b9156e.camel@hammerspace.com>
         <CAN-5tyEJTfG9R7qA2JKar0mFzSNqnJT1ffavj-ik1buaZoqbAw@mail.gmail.com>
         <27a8050d05d12a2bd294fe0b035ad7a39e63aaca.camel@hammerspace.com>
In-Reply-To: <27a8050d05d12a2bd294fe0b035ad7a39e63aaca.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c92e00f6-33dc-4eb8-ce2a-08d92ad2d995
x-ms-traffictypediagnostic: DM6PR13MB3052:
x-microsoft-antispam-prvs: <DM6PR13MB3052DC95C86D883025AC94D8B8379@DM6PR13MB3052.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvPCOUT2vrx5mGK8TYJQ7HMr5gYlMygQSbkYVidnum2BA1Ru1IgsrEFdMJkRK+X1OeT7J4aDzmDSO4uwArpYkQRzazJkzcF4mCrf6lFhrnQ27Mjb5wJibVhDI3tkoD/lF/gHDpYMNkbBIGScLjogtAeN1szPOf9hJnhlwRS8JlcDfuYya+qgTiawk8W1zHupz3E7m94Is8Aiv0VFPnTOL/Cso+lcTT7fociTlS36vImgcqwWMAsONu5+7Y9SoQqdWqQXFddvV1CTzsH3ogUWDbHAk+Pzd18yP32zWMhGmqq33WRwW4IRHrJI2LFvoITb+iq7RKHcvqnwChtOFRFD5EiCsqNPqgni+4JKluZ9KJbRuxzusv4P3S4DKaFhdDrHn6z6aSfvfnYKVMqMfFjglaoaTqdCqCNDlSBqJDIq2l/Mf/V7Incvh07kzGL+RavIVkCEsiwRqiHQEvDHxbN6QnKGYp2q1JZBVsSvseVHshNDjRkOl9a7McP7m8tqg7+PaOyWU1QTRcNVjkIcWerOGn2n7iSuOcApobj7ohTHOFFZfj/OKSocFKe3nGK0EhH562wl+XTuSxg2oAg3kKIlZv0dliz7DgpIvBjhSEp+GmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(122000001)(5660300002)(8936002)(6512007)(2906002)(54906003)(38100700002)(26005)(6916009)(8676002)(36756003)(64756008)(66476007)(66556008)(76116006)(66446008)(498600001)(186003)(71200400001)(86362001)(6506007)(4326008)(66946007)(2616005)(91956017)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9BTk1zUmZXTlhkR0ovTDY2ZEVFd1drYWoxaFRIbEFzN2hGNVhNakpQQ0VL?=
 =?utf-8?B?MXB5UERXaXZMYXdnd2pGaWJyMWdLS3BkVHZQVURUWXNidG9tVkVFZWpMSm9S?=
 =?utf-8?B?V2hhL2h2K2pQRXFITmE3dEJDY1ZrZ3VoNDhleG9weEVHb0ZhSEgveXQ4aXFM?=
 =?utf-8?B?WDYxRXJnemtESVBsM0VvYjZZRE9ySENEVkpUWmUwNHcrSEhpQVpuNGQ0MGVw?=
 =?utf-8?B?L2Rvb29vMXkzUml4ekRXMFgwdmNjWlFIVEI3aHRaK2xBemNRVjA2cGdDKzNa?=
 =?utf-8?B?YzQ1VmFabkRSK3IzUmRJZTExSlFMQU5iSkppSGtGL3REV1NoSnFCMi9pN2ln?=
 =?utf-8?B?ZFBMODR1dkpwOFo2UGtzRjd6bUFOaEhiWVkxRzZxVTVEeDQ1cnYvWFpGUjNO?=
 =?utf-8?B?R3VlZlJwUjFjWkY5N20yTndyUUtCWUY2dzlwV3RJbVpKRi9Lb25GMTJ2Zis2?=
 =?utf-8?B?QTFBTXhQQmcwWVZ5MllHallndE9yZFZJdWQwZjc0SDlKS1B3T0h6MWxoN1VO?=
 =?utf-8?B?SjlFdUlFM29JSDVSMytNeUl4Y2QyR1p3Q2xiaFhvc244cXBENmFOUWhheUNH?=
 =?utf-8?B?eG5vMFBzTldjVUxYa09Cemh3NmY4VnBFa1RUUThlZER4UENSVnY1Tm1DdEV1?=
 =?utf-8?B?Y3FlbGc2aTRHc1VZSFFlOFMrVS9zdDEyTGdwcEp2ZDY0bmR2S01CY1l1TUIx?=
 =?utf-8?B?VmM0dHY5aE83QU9Wa3BlVXhjZUhkN3gwOEFoTkovWC9FMUdCamJjdDF2ZkdW?=
 =?utf-8?B?dUthc2NSUFdpZW10Q1pPZEVTRHl6VFAzZVlpOWZLdkczV3ppK2o5MitOd054?=
 =?utf-8?B?WVREc2FhTGJQdEhqUlNMNm9tT2xMZmlYSWtBVWNKQkFNcDdWK0ZGNEFNekNj?=
 =?utf-8?B?OE8ybWlhWDFRYmhudURORkErRVNteklad0dBTThCQ2VQQWNZSWJaL1diWUU2?=
 =?utf-8?B?SVkxWGxNRzZqMy9zWXJCY1dCUWZtZVEwenpPb2lWeGJQdjcwK3ZHWU1OcUZh?=
 =?utf-8?B?RTJxZTF5UklUY2ZLbEtMYlM1cStUMER2SG5NdnJDQ1BSR3NWV05DWUJaRzFC?=
 =?utf-8?B?SVAvdlUyS2diT1R3aVgyVEFBRHpPdUFNRmRMTmh5QXRkS1pQTFRxWTFxOVZx?=
 =?utf-8?B?RHVUakY0Z25zSlpML0hBMjJJSW16YXEvekkvVWxGd2IvdlhjRy9tS1pxT3VW?=
 =?utf-8?B?Tm9nbzcwenFKSmk5angzR1Y2WUl6V013S1dyLzNVb2ZNSWhtRHlvcHRLb0k2?=
 =?utf-8?B?OVJhR21IeENNblovUjN1SzIrZkVQSGJId1FXREZuOVFwbUhnaDZXWmpSdTF1?=
 =?utf-8?B?bC9GMkg4MjNCYkFEZ3E4T0locDZtUVU2OXplVWV0TnpJNU1tZk4wQ3paTGFF?=
 =?utf-8?B?Ym5sQjNLZmJ4eTB3cExNNURNTjI2K1E1cTlsK0xTbVhCdnpsaWFzbzNaQ3Zj?=
 =?utf-8?B?YVI3SzNsMXRFQTkrRHUzNVI0NkorRm9La2ZLYjhiVXR4TkF3OXV2VFFuWkJN?=
 =?utf-8?B?c1lwQkE1V0U0RHgzRnQrOGRqV0lLSlo4bkFyU0pySlJORnEySjB6azVWTGpk?=
 =?utf-8?B?cjVqeklWQ1pXd1BHaTJhVEVtNW8vVmRDVzVPUWRLWHpkQmhQRngrM2RWaUU4?=
 =?utf-8?B?V1Q0N2FqbzFualA3YzVBMTRQazMxVEdCUUxpcnpZcGlFczRpQ3BMaWVyaWda?=
 =?utf-8?B?Y01Zc1RDNUpxM1JwNDMyT0lJaGUwM3JGclN6OVZ6alRHeERUSkZmWlF6Ynk1?=
 =?utf-8?B?VG0vVUxvcFNXMXMwN1NtYXduSFg4Tnh4NWF2YnZGblBzRUNvbXNUQVJOTHgx?=
 =?utf-8?B?TEJhWm9DR3JFMFZEbEt4UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <83B7101BB214544492DE921E1ECCBC22@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92e00f6-33dc-4eb8-ce2a-08d92ad2d995
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 23:12:13.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gS+xUXtgzL8tjq2l6Ng+WEJ9rtcOjA7/tKGrW7uIENxoDDufFaWw+Ng4nqid6fyclw1cmbOpp+2DjTvNEN9J3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3052
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDIzOjAyICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IFNvcnJ5LiBJIHNob3VsZCBoYXZlIHdyaXR0ZW46ICdycGNfY2xudF9hZGRfeHBydCgpIHdp
dGgNCj4gcnBjX2NsbnRfc2V0dXBfdGVzdF9hbmRfYWRkX3hwcnQoKScsIHdoaWNoIGlzIHdoYXQg
cE5GUyB1c2VzIHdoZW4NCg0KR3Jvd2wuLi4gTXkga2V5Ym9hcmQgaXMgaGV4ZWQgdG9kYXkuIEkg
bWVhbiAncnBjX2NsbnRfYWRkX3hwcnQoKSB3aXRoDQpycGNfY2xudF90ZXN0X2FuZF9hZGRfeHBy
dCcuDQoNCj4gY29ubmVjdGluZyB0byBORlN2MyBzZXJ2ZXJzLg0KPiBpLmUuDQo+IA0KPiDCoMKg
IHJwY19jbG50X2FkZF94cHJ0KGNscC0+Y2xfcnBjY2xpZW50LCAmeHBydF9hcmdzLA0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19jbG50X3Rlc3RfYW5kX2Fk
ZF94cHJ0LCBOVUxMKTsNCj4gDQoNClRoZSBhYm92ZSBsaW5lIGlzIGNvcnJlY3QuLi4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
