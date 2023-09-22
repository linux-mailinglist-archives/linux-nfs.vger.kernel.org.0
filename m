Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087337ABADF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 23:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjIVVHC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 17:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjIVVHB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 17:07:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39024AC
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 14:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrzeHvINneQFmNPM25RQM5yz5ywcxjUxvHk39TZyVhgF5V+Nf1o6M2x2YxzgeM1Wl0IvvqXpR227SXw9T8hZm/M/t+1OUtROSr8IiWB/zymiHCvBETzEnsBj1jkzYhZWjSgPPZdP+X4qsgM5NwOwN6v21/RNkfcIlVuQyRRQdwlFyJjiQerdVkclMhUVjq++TkM+cDzDPuzkC1ScTSFmbgaGDQDWXS+XkOzTw1TtclBnOD0vs3G999UucgmpUk47m4OuoaV4WnasOXB02MFLzcpRffJfEELGDiQoIfDw+dhCCE0bz2OjffimuDm5uq1d4dFvpWYm8RxMqtkIFjmNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMBILYq1IyevpfhwSCdDvLBmemtDsZ/UFhlb5CFdfSQ=;
 b=awsmCIzatn2xzo7SalESDP/njQumeaIqlDtCZE7sitrvE5By3YNlK8+Xf+tLvhpiWQ/xuDu4r33PI3xvdPf0Wqg09GVYmCaOeNrrsH3A09AgYZR7BoJCGGj0bEQhu7AoyRYbZvBgBWYpuvnvQHpu9fXQEGvjo+Ryeu0OqcqCx4h9wT4QW10Yn/qZt7+0WN7QriFWbcJBCCfreFhi0kuNKnZ5dW1fplfGoTPEGpSFN2Nwf8ptuux9IeQYAW5B5OVFn70cOTDWDWrrWYKl3kM2PC7fEjFbY4NRfKuubUFjyQey2QvyeHu/fsbbJUhsRapUyST+tVZ3RRo7MuaSSG85lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMBILYq1IyevpfhwSCdDvLBmemtDsZ/UFhlb5CFdfSQ=;
 b=e5w3exfSXDyYKzNOOns0DPgYnUWC/3iBM4Nf7RWHcQfpPZkILdpdTQseeDNGfz32fk17xTNqRX7qNhrgwj4hL6cX2gAYRqNjmCXRBXfcYLtq1pZc1jWNYp/R7M1dXedUtIz2Koi3UR9TjMK7f3hDJp6qsxrZLnwfHMBd/55axdQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB6461.namprd13.prod.outlook.com (2603:10b6:510:2f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 21:06:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 21:06:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
Thread-Topic: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock
 regression
Thread-Index: AQHZ6bx01N78VobVYEyXXSG5Nx3/F7AkIK8AgABNMACAArF1gIAAHKIAgAAgKACAAAHOgA==
Date:   Fri, 22 Sep 2023 21:06:49 +0000
Message-ID: <c1c6106c3b4a6106ff706130fe551b424512dd34.camel@hammerspace.com>
References: <20230917230551.30483-1-trondmy@kernel.org>
         <20230917230551.30483-2-trondmy@kernel.org>
         <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>
         <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
         <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>
         <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
         <CAN-5tyE8u1HCrS9KWQywc3BDvPG2ceZG4kn_vDkJjS-W2mL1KQ@mail.gmail.com>
In-Reply-To: <CAN-5tyE8u1HCrS9KWQywc3BDvPG2ceZG4kn_vDkJjS-W2mL1KQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB6461:EE_
x-ms-office365-filtering-correlation-id: 2547164c-a2f1-4106-8fbe-08dbbbafd69b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZerH7NfBPUicFDWnLzC+0npTQKZ4G2G/Rh3aipB4aTZYHaMxs2KX1DGoB4JW1lIsVvEUc0n0U9fgN/aFbVPVIGFGfSWoCXfIxv4Eu7RdmcarZiwqZiSDJHGtgCMHnhNFnNst3McXhmFrgFBR71292RV083M88FLpHGugF7sbHQkXuPrY/cQeEU4erGGjsUv7sgdKmw/AlFH/1OUwA6eQQjEjAq8sOmjSqawpnyvm4DtrdRMQntMJEMMw7rHdOGnv+0GHTbXbv5aIdaZIMHg1tSY0C0KeljYLxxjUGGAj3AQTY2MTFcRF2hWy5018CdeAUH9A2W98mAUP/EVPE7o7EJ0V13kRCE9Am+kIsHOVe2OQpgrOy0TXEDbeMUPQAyfPdHtYwBZ7T7QJEqUqvAjuxHexRb7TGcusQD4zrOhVuMYmjVrS/JIBPLfxCf28dwCK2R7OLlluHrnUfmFl2Ov4eaPJfBRux3GhAsEA1X++dHd+l6Y7DWi5POqMJmEczHJLcLD9pEiP/DJMxlXuy1FlIpcYnSiYxg2qy6DYZc7FmoYfdSCKWAzpyf47FZMIHveAjyHwvo2lLOyGu0LRMZbXXUpOKDbrDSzhyJ9x0X+glgl8LjHe5MF+Iy4dAdNJQah0s9UajNcr80CQqxFVH9XfSMmhCR0ZJD2YguyxPGOjYwk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39840400004)(136003)(396003)(366004)(1800799009)(451199024)(186009)(26005)(2616005)(8936002)(2906002)(83380400001)(5660300002)(66446008)(76116006)(8676002)(66946007)(66476007)(316002)(4326008)(66556008)(41300700001)(6916009)(478600001)(38070700005)(38100700002)(86362001)(36756003)(54906003)(64756008)(71200400001)(6486002)(6512007)(6506007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFd5QzVHRHJWU0pJNG9PeUVJM0ZRczNvcnZrN3RMQ2pqemFXTVpjb0RCTnRS?=
 =?utf-8?B?QkF1WDZsdmkrRDd6QldEYnJ1QUJvUHkzZEZyaS9PV0VTS2U5MFJ2R1BsTDBj?=
 =?utf-8?B?WnRaQnZxNWlJUGZaVWRiTmtHc1NMUGR5VlhNaXpnWnlEdWZ0eDBrYmU3Yml0?=
 =?utf-8?B?U0Z5M0dnNzl5TWU2MlBjdWo4QUpjeU9qdDkzck9HdmxiSncrVG9OS0IzWlA0?=
 =?utf-8?B?RUhyeDl0T21iUDJGQTZ6aHFxV1FMb000cW9XMVFIdHNZRndpbFJickRwTDB6?=
 =?utf-8?B?K0pBRk5Ua3ZOMzJXRHR1RTA0S3U5N2ovWVpZcHBjbGJ5bVl6YXJ4dGM2QXQ3?=
 =?utf-8?B?SytiUU13ZEZFRy9QRldZVnE4VFVTanFibFhlSmtJRktCVnVwWml1WDZBQ3ZS?=
 =?utf-8?B?WC92QkhOZkdGY1VmVXdsVDJQOHpKUlQ1Qm00cTRIcHFVRGdwdTFaSUJ4RW9p?=
 =?utf-8?B?MG1URTd2TXJFeXdLRURuRis2YUI0ekNlTUlpTmRaYjdJWUVKZkhtbEd5aldr?=
 =?utf-8?B?OFdORkhSMlJrRFF4NDAxVXBZdmN0Nnd0UkZSVkhxZTZpUkhhcFh2S29IK0o3?=
 =?utf-8?B?MDdFN2dnZUpuTENlM2RiWWZDL0FJcHVnN25WdTFvY1Ayb1ZCM1VvM1c1OFlu?=
 =?utf-8?B?NEs0d0hpYVFqdnBnWHczNkRlQ1ViTWdtSjBXdkR0Q1FuV3RpMm9OSHFZUXYw?=
 =?utf-8?B?NXBrMlBpTzVQVTRFdWNRVmU1dmZadHh5M0M2R0pmMGE0MmtLVlByeE9JZ0RY?=
 =?utf-8?B?blVxdXJ4ZWN0Tm16eEpoVGsvdGpyZytNUUowcFBHVElFUUR1OGp0d3ZidThM?=
 =?utf-8?B?ckpBcjRCSzExaytad3FCZ3A3dExBc2RDV1RHbWF3SFdBZ241cUtMYzQzTFo1?=
 =?utf-8?B?ZVVZeGhJaW45UytTMldvSVpKNEs3cit0enFzOGppSEhKcHp5ZUN6Rmp4YUtk?=
 =?utf-8?B?dVZZcnRMdGJ4d2NId3lFTll0YS8xUEFLK1BoRXVZN0FYQlcrWXVQV1VNdVNV?=
 =?utf-8?B?YTNEOXBpNkRCUEtFMUd4bVpyblpEalMvQ0o4ZTBuVUl1cUtFank5clU3b0Rp?=
 =?utf-8?B?TXo2ZERmM0FMa3NMWUd2L3NQSlNzczhDdEpObHBRT2FLZng1emlraVMzYnlD?=
 =?utf-8?B?bk1FY2tNL3JhS0p1SnpEd0JvV3N0MzlZVEV0dUVleGc0WEtkN2grUk9aZldl?=
 =?utf-8?B?UkttRUJicm4rck9ZR2JVRnJnVmVQeldJcnZDZzVrRzFrVXRlNTlyQmtHWjIx?=
 =?utf-8?B?MXJ5K0Q5dDVnVi9SSEpURloxcnNOL1JLaG5MSnF2d3FkUTdJMkgxdm1pS3pC?=
 =?utf-8?B?QWNBaXlQWUpIOUk3NmN0bStjaFArSmUwc3Vocm9sMkdIR2lBb2xINHlsZHp5?=
 =?utf-8?B?T3VjR2IyRENaQnpBRmZsQVcwS1BySFo3RGpCL0dpaERIZ2ErblBSaW9LZXhO?=
 =?utf-8?B?Z0hybVZxL2puR3lQVTdCZGwyc244WVphQkJ5YXhuT3BBSGtvZTdCdmowVlVp?=
 =?utf-8?B?Q2FYTXJtbHB3WmJaQjhSY1d6eUlTY2d5cFVVNEVGNjhvQ08vTzVic2UvNm0x?=
 =?utf-8?B?V2lwdGsvLzJyckNPYzZmWERIZG40ZDhGeFdEVzZTa0tselVDWW5Zb3BhOWtl?=
 =?utf-8?B?TXFqcCthYitUSTVnWGY1V3BTeDR4RWFrNGs5K0EwcFpMWG9OZEdOK3ovOUxp?=
 =?utf-8?B?WmhsMk4vNE9oekRhSk9GSnFxL0thdVlXb1lWT0huOWVGZDBLWnVZTHYvZmNU?=
 =?utf-8?B?UVQvTUJvSitaS1dYdFVNT2JFUzVIZFFGaithaE5SRFhISDAwWVVvejM5MUo2?=
 =?utf-8?B?Yzl6R0lPa1JMVDhnTkJEOFN5dU1TNXI4amNTc2lUTVMzQVlrb3hOeTZYbHpj?=
 =?utf-8?B?S21IUVlSRUlScW1VT3NIS0duZVlyNnNrZ1F3cmlVNFpQMllkbXZ5Y1JZRkZi?=
 =?utf-8?B?TDg5djBPQndENUs1SDlPb3hpVitlOGRMRUxSaFNscEkrdGxKdmZnMkVVaWw1?=
 =?utf-8?B?Wm9CTVp6WGZ6TElIaDVpeUhNQ1AzVFJlUGJNY0dRTWZ3MjlBdEFrNG8wOUJw?=
 =?utf-8?B?STB2ZGdqNUhod0FWbHhTUXNaKy9UL2tRVG11RzB3cnBaZlpkT0VGa3VrWTIv?=
 =?utf-8?B?WjhzOFd4UGFoVGJlQlg4MVloOElFNDZ3UWhWTm9sMHlSZFFxd1RZa2FwZmR3?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60CB994FD61ABD4FA5644E3FBCA530A5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2547164c-a2f1-4106-8fbe-08dbbbafd69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 21:06:49.7234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6l8GJlwBmV9XEDOiCavmoZb7mhdeOt9ettlR24pQrll+OHAiA5lW7nHLD+S1/OTbv0XGNs6FCIjCdZ99LJq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDE3OjAwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMzowNeKAr1BNIFRyb25kIE15a2xlYnVzdCAN
Cj4gPiANCj4gPiBPaCBjcmFwLi4uIFllcywgdGhhdCBpcyBhIGJ1Zy4gQ2FuIHlvdSBwbGVhc2Ug
YXBwbHkgdGhlIGF0dGFjaGVkDQo+ID4gcGF0Y2gNCj4gPiBvbiB0b3Agb2YgdGhlIG9yaWdpbmFs
LCBhbmQgc2VlIGlmIHRoYXQgZml4ZXMgdGhlIHByb2JsZW0/DQo+IA0KPiBJIGNhbid0IGNvbnNp
c3RlbnRseSByZXByb2R1Y2UgdGhlIHByb2JsZW0uIE91dCBvZiBzZXZlcmFsIHhmc3Rlc3RzDQo+
IHJ1bnMgYSBjb3VwbGUgZ290IHN0dWNrIGluIHRoYXQgc3RhdGUuIFNvIHdoZW4gSSBhcHBseSB0
aGF0IHBhdGNoIGFuZA0KPiBydW4sIEkgY2FuJ3QgdGVsbCBpZiBpJ20gbm8gbG9uZ2VyIGhpdHRp
bmcgb3IgaWYgSSdtIGp1c3Qgbm90IGhpdHRpbmcNCj4gdGhlIHJpZ2h0IGNvbmRpdGlvbi4NCj4g
DQo+IEdpdmVuIEkgZG9uJ3QgZXhhY3RseSBrbm93IHdoYXQncyBjYXVzZWQgaXQgSSdtIHRyeWlu
ZyB0byBmaW5kDQo+IHNvbWV0aGluZyBJIGNhbiBoaXQgY29uc2lzdGVudGx5LiBBbnkgaWRlYXM/
IEkgbWVhbiB0aGlzIHN0YWNrIHRyYWNlDQo+IHNlZW1zIHRvIGltcGx5IGEgcmVjb3Zlcnkgb3Bl
biBidXQgSSdtIG5vdCBkb2luZyBhbnkgc2VydmVyIHJlYm9vdHMNCj4gb3INCj4gY29ubmVjdGlv
biBkcm9wcy4NCj4gDQo+ID4gDQoNCklmIEknbSByaWdodCBhYm91dCB0aGUgcm9vdCBjYXVzZSwg
dGhlbiBqdXN0IHR1cm5pbmcgb2ZmIGRlbGVnYXRpb25zIG9uDQp0aGUgc2VydmVyLCBzZXR0aW5n
IHVwIGEgTkZTIHN3YXAgcGFydGl0aW9uIGFuZCB0aGVuIHJ1bm5pbmcgc29tZQ0Kb3JkaW5hcnkg
ZmlsZSBvcGVuL2Nsb3NlIHdvcmtsb2FkIGFnYWluc3QgdGhlIGV4YWN0IHNhbWUgc2VydmVyIHdv
dWxkDQpwcm9iYWJseSBzdWZmaWNlIHRvIHRyaWdnZXIgeW91ciBzdGFjayB0cmFjZSAxMDAlIHJl
bGlhYmx5Lg0KDQpJJ2xsIHNlZSBpZiBJIGNhbiBmaW5kIHRpbWUgdG8gdGVzdCBpdCBvdmVyIHRo
ZSB3ZWVrZW5kLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
