Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E58523FED
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 00:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiEKWE3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiEKWE2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 18:04:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2106.outbound.protection.outlook.com [40.107.243.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180C179401
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 15:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrEtfPmq/9SUrqLClzDgBLM9bhCYxpSKxyn8Zy8ghSnjE9UH/oYiJvKItbq1kO05jurvllCj0uYuoAD3zJ7MpyPI4O37+FeBLSN+QxT/hQGx4U9zHoEMZ20taWTOXaVMgbHLmSMWKlwRIwdTYm8cNmLpslqEaHIsw4e/4n1q5WMv3METmK4KFLfCMw8O2kq6E7QLcopEjlpXzrOGJq5HEsVoDhnOlyEptLrrheDordRyGG0zL6+k4m0WuWtFxyWKoRX29b9SP2EBQmt7XXSg7CDAkw3f/QWoZqyGBeO59lrhmzTz99dXoN3ijS7SPKr3EgcZSlIL5RjaYCFIbXK4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCfiE5SxpmRBMUi13W7ChinmySzO2WqlGXm4SWe2cmw=;
 b=Zy/1O8Wuol0cRvaOO9ewkeuVNAFIpydujBGO5/r6wDH0ptIFEyte8aNVxUIRT+3UgsQvIGcz1CIxeEE2gqY5/Pew3FprZJMj/Va+FxwNCOkgW96CYhfEYsOlmg2+J16GkCppGTMpK1Hpz+xoVy+S1zYGL+XIVj8UiCWBXLWNkl5AJMoCRbCecZGugR4g1C9Zn4RK/5i+naf8pgeNPtQKSQ+7ps7P0if7/P0aMJ6RFk1aS208BaqMrqKTYuS5kZyKnEWhvpmF5CJReMpuOaHJlUA868TaO6wL5yUumL9uQzhx6YEDJTuz+DyIcrhNhBeniaygkJ4PU2DNbnbDDOASoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCfiE5SxpmRBMUi13W7ChinmySzO2WqlGXm4SWe2cmw=;
 b=RO6BzsLiSHJl1hnUfcUE4mAhLsqEWQkqcuE1tQJNjNt/DQEeuyQRkszxXmFjAQifUsDwh10t3tiK4MIzs5qacIvJYejr/i1CfTzlLO7tG3qLgAwSusI+Tt6jVNGVvkPI9r72rA5uCxv1vpimxLbGSViDAwR0vHQNCo60dGQcRo4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4553.namprd13.prod.outlook.com (2603:10b6:610:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.12; Wed, 11 May
 2022 22:04:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%5]) with mapi id 15.20.5250.012; Wed, 11 May 2022
 22:04:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
Thread-Topic: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
Thread-Index: AQHYZYF74uG3Nmjemk6zS6FJgMvJCK0aOyGA
Date:   Wed, 11 May 2022 22:04:24 +0000
Message-ID: <3092c3fc34621e72d39c54f03f5a6753ceeed216.camel@hammerspace.com>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
         <165230597191.5906.5961060184718742042.stgit@klimt.1015granger.net>
In-Reply-To: <165230597191.5906.5961060184718742042.stgit@klimt.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8a4560e-0db6-4c71-ef1d-08da339a35ef
x-ms-traffictypediagnostic: CH2PR13MB4553:EE_
x-microsoft-antispam-prvs: <CH2PR13MB4553E4421CC54C803DF96FB5B8C89@CH2PR13MB4553.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8yB2QixoL9Cz1Hn6SNDtkjf9vKsGRIipYOsZRxVk/56Z7R5BgGoRmqGgxZ917QQ2mj+iTHjFTASjcw65Yaf0GBSAO0Dxqkxd9RJMS9MpScnckH6hCtTFefZ1rB4JsLU7xhwkT2X5G7z6Sxq5UKkvjixm2eyeMfAfBP63pB4HzMraiPjHWhvEFYCMXxoti2+zvYseYwLtQr70ZWyax3kJ34tQXj69ORAToD0fEw3kULVmwkjn163RNC/Hu+6I3CQFasNMR0F+2l2WQyIJ+grS1WvEIPdbhzdXtxFQjY3VfNa8Vsy4j7/VFRDb66Qy+AtBPfrBy7E5vy6ABUOSCm3ZtklWEo+cCqW5dow4F/3KU5+U/MWMipVEXSAF7zCLvt7v/tF5VSMDZJ1gEepZLpbOu9qCXgWJqe3A1qunl1BHRWVLgAdPTt2Uc9H1pZsNBOVS6VsaYU3bbekltuohPNdWB1yHRpm669bIXPpgzmvOcm37bxYGTMCtDUPEQZfG+uEfoMlj4o646W/IawEQ3c8CTZwFScJg0yRcSXrEybeAPEQ6TRO9A8etze3Lb4YMxpLy2kuwTDA6ypGjHc7aZDfIMTldJeyEwgLytrk4GdVcSFJfQwum/bmLd3dFdfEDo1NcgQGkKOWbyMv/F1nGBt3IAhf40ExsiTe65jkEePRP+VXcA6clefM+fmNPY9SBlgv5RQgvcYe1q3GA3/7mQGHo2Xxt1lmYRV4M+69Bqy1xkdfT70Fef+Anj0QFIG4ckx2x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(508600001)(316002)(6486002)(76116006)(38070700005)(38100700002)(54906003)(66556008)(110136005)(8676002)(4326008)(86362001)(66446008)(64756008)(66946007)(66476007)(71200400001)(6512007)(122000001)(6506007)(26005)(83380400001)(2616005)(186003)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVJ3WnFGWnk3cVc4Wks1K1hxQ1ZlSytZZ3BMT044YkQrYXFuQkdRS0JoUlIz?=
 =?utf-8?B?U3QvUTI4Q2JXbGZpT0Z4YzNxdXlET1NUcm5QSmk0c013R1BWOGttdWdsVXF4?=
 =?utf-8?B?UGZKZFZUZW0zZ0Q5bnJxN3F6ejJaQ3JYMmRwNGVFYVRicTc2ZDB1SVpvZlhL?=
 =?utf-8?B?M2k4WEZCU1RBNGh1QWZxZjR4ZmpJeGtmWTBJamQwbUwrdVM0aUw3THZFdGRZ?=
 =?utf-8?B?Qkd3ejNSdGgrZE5ndjR2c0pjL0tBQlJabkNSRWVoR0cvQ2VUUll1YXpWS3B4?=
 =?utf-8?B?UFdHMjNCZGY4U2JkMmM5YmZxaHRTZTEyQU1US05JTERHRllXc3dyVTRsejRX?=
 =?utf-8?B?S3J4MmxqaWNXSkdWdlRmcm52d2h6d1dIUnZKUlgzeG9sNEhPT1Z6MVJna3Vi?=
 =?utf-8?B?cmV5MVBsTWZ6aDBjQnFaVktHdVR4Y01lS0Y1ODVrdFNETWdhZTNNWUNhS0Vk?=
 =?utf-8?B?M0dYY0ozMmVSSFVIVkZGdVhrWnBJbEJaOGV4MFpwWk5ZQ1JFdkZ1QWpBVGJq?=
 =?utf-8?B?V09XbTJaa2hXcEh2NVJteTJnbm90WWdTZkZMTkxaSzRkbkkxdHRlTnJPTHR3?=
 =?utf-8?B?Kzl3dk4rRHVUM1EvVHdCblFYLzIrRkZ0eUdpR3FqOE9jWEQxMEV1MFMwNGV5?=
 =?utf-8?B?QzFsR0UwbjgzRGZHbWNObmxEemJlbUd6ZUliNnI2dmZ4NjdvMmw0N01ZeS9p?=
 =?utf-8?B?bU5TZU53bC94WXNQdHprWW5uNlpWU05XZ01XZ3p1MFVoSjhqbkpPSjg1WXNY?=
 =?utf-8?B?eXhIdE5FWVB1UGtDNHFUKzdrTFBGdTJrK01jcGhYc1FIS3BLcnNGenJhL3ZD?=
 =?utf-8?B?NTdjY2F5V0lYVGt5bkw4c1VxUm1wRGF4N2tua2czL0RVOEU0b0J1RHlUYXZZ?=
 =?utf-8?B?Y0U4Q09XWGFrZHAxY2JGUHdVOHZHcE5IdzFRQm82VDR0am9pdW1XZUgvUURw?=
 =?utf-8?B?QnlpZmxjN1JrMFhvcVJjcXNDNHE4SklENDE5aFc5ZVMyWG5yUVhaVWY5dWtq?=
 =?utf-8?B?UHdUbkZ1bXNXVzVTWmp2SGFDYmM3S3k0eEp6U0RmUkw1YUIyVzRQeW1CTTBu?=
 =?utf-8?B?dndSSGVNVUhoK3pzdFRWa212cEVDSmRITDN1YkpSc29pYjVWblFKTU52Mk5U?=
 =?utf-8?B?V3M1bkFZSHVrZE1BL2FKc2xQSVU0aDNENFh2Z3QzUWFzeGpSZy9DZFI4RjZj?=
 =?utf-8?B?Q2J0ZHh3OWQySk96aUJuZ1FTWnIxOHV5RjA3ZU0vdndDWVpZUit1dTNVdUJO?=
 =?utf-8?B?OHV1dGZiUDRxeHdGUWJkaEIybHlnZzhvNTU4MElLRFN2UzFFaG0zMWV2L2ww?=
 =?utf-8?B?a0V4a2RSVG9xME9DZmF2VGZMaSt6L3RFQnBJS2ZBbXllcWlIZVJLalNndzQw?=
 =?utf-8?B?ZkQ2WTNaTEtaMjdlSlNKSGFzZlkvOFNCMjdSUkZ1ZXdnVkE0aEZ6SGhEZnpP?=
 =?utf-8?B?Yko2cmpCejg5MVZ6TjRLakxFQkZqc0xuRlN6Tm10TFVpTVpSaUpFd2pJSG9z?=
 =?utf-8?B?RzB1ZmZKbHIxVVNQNFo1UzdncG1zaXNJbm4wM2JIdzJaSmJhZjZ2RkpPMTBk?=
 =?utf-8?B?bUUzdzR5R2QzMmhFQ20vWW01NkJKWUNaWWdxUEhqdlJNaXdtMWZOTVF2Syt0?=
 =?utf-8?B?RnVwZTErOWpmT28zUW52cFdwdTVwWWVzRFM4Y2RXRURsb01GMm1CSHpoTWgr?=
 =?utf-8?B?NUxFSXpSdW1UNGtGZHp4dXBWWUc5VitqYzVEWUtORlBQc1hPUjdJZEZIUWpC?=
 =?utf-8?B?VTdJYnZXc3RKQWk0dmtBVWs5bGY3TnZ1SzdCdzdBYlp5YnljUXQ3cDdmNUo3?=
 =?utf-8?B?UDJpdno3RWErT1BsU3hla3FWU0UzZkNqUjU2Z2RZQ0k3eGtRMmNDcHl4enhk?=
 =?utf-8?B?bHlycnVWSWxQMUhxNDhObUFaOE1CK1NqQzR3a1dyQmVaWVFFMHc4TG9tSCty?=
 =?utf-8?B?c3lMd1UrT1VRVXltOVFJS214VlAxSlhVV3dJZVREZll3anE3WFJJdlR6MllO?=
 =?utf-8?B?Rll2V1RzbG5yVGEyaXZ6RkZqUXExcXJnaDZXTFUyT1VEUkhmNVI4RDVVejkv?=
 =?utf-8?B?T2o2dVhEVGF1cENic3U2QzJLU0UwTzM4RHNERC9PNXJ5bFhZQ09UUm5YRDh5?=
 =?utf-8?B?TkVlVUJpSkdNSnRlTGllQmN2SVBCM1FzT0VxVVl2T2V2c0dOcUE3Q3grSmF6?=
 =?utf-8?B?VnRIamhxdS9IYjZ5YzZTQ2szckFlWlp3Uy9xVk5uMmhVcmV5UW9rc2pvNjBR?=
 =?utf-8?B?TmVRbUU5OUJCVWtUWm5SSVl0V2swbWIxdFVPTVdTUUR0dDZSOUFQdlYwRmN4?=
 =?utf-8?B?Wk1HL1U2RzgrcXQrRVgra2tNQmtHTENMNUVqQVo3dkRsWW9iaXBiME1qYjhz?=
 =?utf-8?Q?kYZDZAdfD1REHAsc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2BAC58CA910E34F9939E883EFFAA814@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a4560e-0db6-4c71-ef1d-08da339a35ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 22:04:24.8618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpO2QPQQcFIVc717VciW3SIQe25CeE71bfcwyy2KqEO8sobrmqJrNG6uBfUFnmhg+ma0DrfqHmFWpjZVAbML7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA1LTExIGF0IDE3OjUyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToKPiBu
ZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpIG11c3RuJ3QgaG9sZCBjbHAtPmNsX2xvY2sgd2hlbgo+
IGNoZWNrX2Zvcl9sb2NrcygpIGludm9rZXMgbmZzZF9maWxlX3B1dCgpLCB3aGljaCBjYW4gc2xl
ZXAuCj4gCj4gUmVwb3J0ZWQtYnk6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4KPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Cj4gLS0tCj4gwqBmcy9uZnNkL25mczRzdGF0ZS5jIHzCoMKg
IDU2ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCj4gLS0tLS0tLS0t
LQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUu
Ywo+IGluZGV4IDIzNGU4NTJmY2RmYS4uZTJlYjZkMDMxNjQzIDEwMDY0NAo+IC0tLSBhL2ZzL25m
c2QvbmZzNHN0YXRlLmMKPiArKysgYi9mcy9uZnNkL25mczRzdGF0ZS5jCj4gQEAgLTY2MTEsOCAr
NjYxMSw4IEBAIG5mczRfc2V0X2xvY2tfZGVuaWVkKHN0cnVjdCBmaWxlX2xvY2sgKmZsLAo+IHN0
cnVjdCBuZnNkNF9sb2NrX2RlbmllZCAqZGVueSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRlbnktPmxkX3R5cGUgPSBORlM0X1dSSVRFX0xUOwo+IMKgfQo+IMKgCj4gLXN0YXRp
YyBzdHJ1Y3QgbmZzNF9sb2Nrb3duZXIgKgo+IC1maW5kX2xvY2tvd25lcl9zdHJfbG9ja2VkKHN0
cnVjdCBuZnM0X2NsaWVudCAqY2xwLCBzdHJ1Y3QgeGRyX25ldG9iago+ICpvd25lcikKPiArc3Rh
dGljIHN0cnVjdCBuZnM0X3N0YXRlb3duZXIgKgo+ICtmaW5kX3N0YXRlb3duZXJfc3RyX2xvY2tl
ZChzdHJ1Y3QgbmZzNF9jbGllbnQgKmNscCwgc3RydWN0Cj4geGRyX25ldG9iaiAqb3duZXIpCj4g
wqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBzdHJoYXNodmFsID0gb3duZXJzdHJf
aGFzaHZhbChvd25lcik7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnM0X3N0YXRlb3duZXIg
KnNvOwo+IEBAIC02NjI0LDExICs2NjI0LDIyIEBAIGZpbmRfbG9ja293bmVyX3N0cl9sb2NrZWQo
c3RydWN0IG5mczRfY2xpZW50Cj4gKmNscCwgc3RydWN0IHhkcl9uZXRvYmogKm93bmVyKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHNvLT5zb19pc19vcGVuX293bmVyKQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVl
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHNhbWVfb3duZXJfc3RyKHNv
LCBvd25lcikpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gbG9ja293bmVyKG5mczRfZ2V0X3N0YXRlb3duZXIoc28pKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBuZnM0X2dldF9zdGF0
ZW93bmVyKHNvKTsKCkhtbS4uLiBJZiBuZnM0X2dldF9zdGF0ZW93bmVyKCkgY2FuIGZhaWwgaGVy
ZSwgZG9uJ3QgeW91IHdhbnQgdG8KY29udGludWUgc2VhcmNoaW5nIHRoZSBsaXN0IHdoZW4gaXQg
ZG9lcz8KCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7
Cj4gwqB9Cj4gwqAKPiArc3RhdGljIHN0cnVjdCBuZnM0X2xvY2tvd25lciAqCj4gK2ZpbmRfbG9j
a293bmVyX3N0cl9sb2NrZWQoc3RydWN0IG5mczRfY2xpZW50ICpjbHAsIHN0cnVjdCB4ZHJfbmV0
b2JqCj4gKm93bmVyKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG5mczRfc3RhdGVvd25l
ciAqc287Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHNvID0gZmluZF9zdGF0ZW93bmVyX3N0cl9sb2Nr
ZWQoY2xwLCBvd25lcik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFzbykKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGxv
Y2tvd25lcihzbyk7Cj4gK30KPiArCj4gwqBzdGF0aWMgc3RydWN0IG5mczRfbG9ja293bmVyICoK
PiDCoGZpbmRfbG9ja293bmVyX3N0cihzdHJ1Y3QgbmZzNF9jbGllbnQgKmNscCwgc3RydWN0IHhk
cl9uZXRvYmoKPiAqb3duZXIpCj4gwqB7Cj4gQEAgLTczMDUsMTAgKzczMTYsOCBAQCBuZnNkNF9y
ZWxlYXNlX2xvY2tvd25lcihzdHJ1Y3Qgc3ZjX3Jxc3QKPiAqcnFzdHAsCj4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBuZnNkNF9yZWxlYXNlX2xvY2tvd25lciAqcmxvY2tvd25lciA9ICZ1LQo+ID5y
ZWxlYXNlX2xvY2tvd25lcjsKPiDCoMKgwqDCoMKgwqDCoMKgY2xpZW50aWRfdCAqY2xpZCA9ICZy
bG9ja293bmVyLT5ybF9jbGllbnRpZDsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG5mczRfc3Rh
dGVvd25lciAqc29wOwo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnM0X2xvY2tvd25lciAqbG8g
PSBOVUxMOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnM0X2xvY2tvd25lciAqbG87Cj4gwqDC
oMKgwqDCoMKgwqDCoHN0cnVjdCBuZnM0X29sX3N0YXRlaWQgKnN0cDsKPiAtwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgeGRyX25ldG9iaiAqb3duZXIgPSAmcmxvY2tvd25lci0+cmxfb3duZXI7Cj4gLcKg
wqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGhhc2h2YWwgPSBvd25lcnN0cl9oYXNodmFsKG93bmVy
KTsKPiDCoMKgwqDCoMKgwqDCoMKgX19iZTMyIHN0YXR1czsKPiDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IG5mc2RfbmV0ICpubiA9IG5ldF9nZW5lcmljKFNWQ19ORVQocnFzdHApLAo+IG5mc2RfbmV0
X2lkKTsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG5mczRfY2xpZW50ICpjbHA7Cj4gQEAgLTcz
MjIsMzIgKzczMzEsMTggQEAgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoc3RydWN0IHN2Y19ycXN0
Cj4gKnJxc3RwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHN0YXR1
czsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBjbHAgPSBjc3RhdGUtPmNscDsKPiAtwqDCoMKgwqDC
oMKgwqAvKiBGaW5kIHRoZSBtYXRjaGluZyBsb2NrIHN0YXRlb3duZXIgKi8KPiDCoMKgwqDCoMKg
wqDCoMKgc3Bpbl9sb2NrKCZjbHAtPmNsX2xvY2spOwo+IC3CoMKgwqDCoMKgwqDCoGxpc3RfZm9y
X2VhY2hfZW50cnkoc29wLCAmY2xwLT5jbF9vd25lcnN0cl9oYXNodGJsW2hhc2h2YWxdLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNvX3N0
cmhhc2gpIHsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChzb3AtPnNv
X2lzX29wZW5fb3duZXIgfHwgIXNhbWVfb3duZXJfc3RyKHNvcCwKPiBvd25lcikpCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsKPiAtCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIHNlZSBpZiB0aGVyZSBhcmUgc3RpbGwg
YW55IGxvY2tzIGFzc29jaWF0ZWQgd2l0aAo+IGl0ICovCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGxvID0gbG9ja293bmVyKHNvcCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoc3RwLCAmc29wLT5zb19zdGF0ZWlkcywKPiBzdF9w
ZXJzdGF0ZW93bmVyKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoY2hlY2tfZm9yX2xvY2tzKHN0cC0+c3Rfc3RpZC5zY19maWxlLAo+IGxvKSkg
ewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN0YXR1cyA9IG5mc2Vycl9sb2Nrc19oZWxkOwo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2Nr
KCZjbHAtPmNsX2xvY2spOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzdGF0dXM7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqBzb3AgPSBmaW5kX3N0YXRlb3duZXJfc3RyX2xv
Y2tlZChjbHAsICZybG9ja293bmVyLT5ybF9vd25lcik7Cj4gK8KgwqDCoMKgwqDCoMKgc3Bpbl91
bmxvY2soJmNscC0+Y2xfbG9jayk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFzb3ApCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBuZnNfb2s7Cj4gwqAKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzNF9nZXRfc3RhdGVvd25lcihzb3ApOwo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gLcKgwqDC
oMKgwqDCoMKgaWYgKCFsbykgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGlu
X3VubG9jaygmY2xwLT5jbF9sb2NrKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIHN0YXR1czsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgbG8gPSBs
b2Nrb3duZXIoc29wKTsKPiArwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX2VudHJ5KHN0cCwg
JnNvcC0+c29fc3RhdGVpZHMsIHN0X3BlcnN0YXRlb3duZXIpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChjaGVja19mb3JfbG9ja3Moc3RwLT5zdF9zdGlkLnNjX2ZpbGUsIGxv
KSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biBuZnNlcnJfbG9ja3NfaGVsZDsKCklzbid0IHRoaXMgbGluZSBub3cgbGVha2luZyB0aGUgcmVm
ZXJlbmNlIHRvIHNvcD8KCj4gwqAKPiArwqDCoMKgwqDCoMKgwqBzcGluX2xvY2soJmNscC0+Y2xf
bG9jayk7Cj4gwqDCoMKgwqDCoMKgwqDCoHVuaGFzaF9sb2Nrb3duZXJfbG9ja2VkKGxvKTsKPiDC
oMKgwqDCoMKgwqDCoMKgd2hpbGUgKCFsaXN0X2VtcHR5KCZsby0+bG9fb3duZXIuc29fc3RhdGVp
ZHMpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHAgPSBsaXN0X2ZpcnN0
X2VudHJ5KCZsby0+bG9fb3duZXIuc29fc3RhdGVpZHMsCj4gQEAgLTczNjAsOCArNzM1NSw3IEBA
IG5mc2Q0X3JlbGVhc2VfbG9ja293bmVyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsCj4gwqDCoMKg
wqDCoMKgwqDCoGZyZWVfb2xfc3RhdGVpZF9yZWFwbGlzdCgmcmVhcGxpc3QpOwo+IMKgwqDCoMKg
wqDCoMKgwqByZW1vdmVfYmxvY2tlZF9sb2Nrcyhsbyk7Cj4gwqDCoMKgwqDCoMKgwqDCoG5mczRf
cHV0X3N0YXRlb3duZXIoJmxvLT5sb19vd25lcik7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJldHVy
biBzdGF0dXM7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIG5mc19vazsKPiDCoH0KPiDCoAo+IMKg
c3RhdGljIGlubGluZSBzdHJ1Y3QgbmZzNF9jbGllbnRfcmVjbGFpbSAqCj4gCj4gCgotLSAKVHJv
bmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
