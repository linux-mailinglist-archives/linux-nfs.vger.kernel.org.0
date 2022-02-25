Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A44C3B80
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 03:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiBYCMb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 21:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiBYCMa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 21:12:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2091.outbound.protection.outlook.com [40.107.93.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8334761A11
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 18:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSczAMl/DEJo/vMAkq4y/LfZJtjeZRqAPx+QjvBMOvc1Kmbj2w5eFHuWunHGiF4P4+MrgkXPoWDZiuWLr9AAWrYP309XVIp/Kd6pMKiFyi0Zj8W1S5iFFdjtNdANWzH+RqCMq1Ev4t2cCJqDofRDQmKm6OY6ZpauSeKS7xDPpdhuYUWdVP1yHGMt8Kj0Dom8kNf7iAE/D+HH9OUTm/n/wRsRqMpmhTGkxvf7mF/J7zO+2ZaJEqlsC+p/xlwdRnF74eVxr8bHWZmBo2tU0Hvt+12NvUF2D7Dkkn3VH9Fhr0r4cI5sHRNaBymM8rkZ+kgE7lARGNkIhrbEsCJMPebDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y9Z/yvNeOEgrfOoQRUdKP9UViI6xF29osXIGEAXFXg=;
 b=ItTrbgEpnLSftGHOu+dUsnIzNUMNVtJyd40FDD2JoB3WsbGtvrfPNlpsy+Wwh7UZkJLFZzW3Mz+7unR+c3Sr7bY9CIQQxFSliGJsnw8Ianzf6Y7momBwnuRnb8SbMfpAXmj0Vui6KNDu5CJzPROkUUXKDDyzOkIaIuYGET2g43Pk61aaHTrvq1FEv7Yd7YcKom/y25DNb95F/of/O9easEed4sYMyTF7qlBjgeGOhopTtFvN6kWx559/7iY5IT1cGcm2ZlFOkeZgrkCgtlMTezokp9KgJvbJj/yr+6wjSVI4dfX7ESS7UXJbhbVDD3jRpfLRaOmHc6AliaIeQpNwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y9Z/yvNeOEgrfOoQRUdKP9UViI6xF29osXIGEAXFXg=;
 b=bixzEKuJJVv8Xspge4w8FzmsOPDxZ+rS6z6bZPCcNEbn8eM0CNP/ho8dspvTVX1K40xwYglF62w3yQ4VVm74NSvUyDo/KYk+PXBmaw3RRNEgfCCS7PZxzliDr35I7m9Y/2XZ7ZKq2yk9rfmjXsHiIcUcEt1Nw791afYIWPFKrZo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB4958.namprd13.prod.outlook.com (2603:10b6:806:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 02:11:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 02:11:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 04/21] NFS: Calculate page offsets algorithmically
Thread-Topic: [PATCH v7 04/21] NFS: Calculate page offsets algorithmically
Thread-Index: AQHYKPs5ywYBluV2MUGDuP/AJsbtLqyiwBoAgADICgA=
Date:   Fri, 25 Feb 2022 02:11:54 +0000
Message-ID: <e2ee4448d8deff22d3949b4828d5334a72542701.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <EA90387C-B33D-4C81-BB80-8C0AB3251E5E@redhat.com>
In-Reply-To: <EA90387C-B33D-4C81-BB80-8C0AB3251E5E@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5e9f51b-81b8-4aaf-ed6b-08d9f8043191
x-ms-traffictypediagnostic: SA1PR13MB4958:EE_
x-microsoft-antispam-prvs: <SA1PR13MB4958E51A834780217123ADBAB83E9@SA1PR13MB4958.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEIDxBnJByyOukrxoPcK6Cu/SWgcMoNhtJm8ctn3PO4KtVWxRhMKdPxReD4SrpE77Np3NXM3CjbOZtjYNVMJ0GWukP45pfFcPnkMvLUSZqhzFuCgdWDX87hso7FHnl435HyK92ppyTHCRwhM+9SFHoGhWTHDl9AhrQhejTsvCnIX+Q969TdbvzWjOxlDCyFVjiqOXEtpKG2rMLVKUEKCBiNEx1uFa3+RbVXgviN4HWd111ppIis2tm8OUhKteoe8cWfsXilnvXn20FR8gVzzIRk4Hokgxl66m5mqpweXE6r4aM/MxLXKK01UT2OvaTwi9yAk6RH8eXxGyMMxlL/xyx8iE9DWf/KQftp+fhE+cWqiH5VY18hqRHeRWvldr+gp6a2Lu3x/TMpwIVQ76Dp++VhA63luybd4G6UQZovHckb/6OWuyNwfPbdF9JDs3SbDQK/9K/u1IA2CIieQAasiOurbiGHrLU0i0nG7ffB7UyFdrACArCE7lhn51cIUvMHqVv/xdt8DbHoFNDXO8gIxKjiMkNA1NO6tOJydu4kdXCLacKIqNksFlEzQyuXGrlTbvMLnPCV8kG+BsPfmEA3xvDaKuAyH+e0DS+q7G7LBRJ/uZIyNwbumb5JPZ++8Kiw5beUSmoL3Z6UO/CzxpZOuqr13mIFLG+yq0GA72w3LQ2LUznKlpcMsZhjx53w/WxWGj2vj/kEHDYomZAifUhsu8HJ2+tHwF1ppDUHoL1/LU17YJbxIcO/fYN6wj3vm/MFx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(396003)(366004)(376002)(39840400004)(346002)(8936002)(66946007)(4326008)(8676002)(66556008)(76116006)(66446008)(64756008)(508600001)(6486002)(66476007)(38070700005)(71200400001)(38100700002)(6512007)(5660300002)(6506007)(53546011)(86362001)(110136005)(316002)(2616005)(26005)(186003)(83380400001)(36756003)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b29XS3UyQW9VZzAyYXFIUXlud1FjNnRmRFlXSE95RFhWSlozZzQxV2xiSW84?=
 =?utf-8?B?bXFKeldZaW1Xb3ZEV0xkWjZPKzBuOHBTL3EwT1pneElkenhXQmVGK3lJVksy?=
 =?utf-8?B?b0o2dGRlbXRSL0pZVkdsTDdZS0ExL0R3dzVQN09waERHcWNOMWNtTkxXc2JU?=
 =?utf-8?B?K2VVNU1rT2NBcWFVSGRxM1RUaTJ6SnpQcXdsU0x2NnVHQU0yRVkzUUZSUlV6?=
 =?utf-8?B?YzM5bmZJZGNyeUxIUXhERmdVZ2ppLzFiQlJmV3lSeUs1SlJ3WGhYZVVEM2dz?=
 =?utf-8?B?eTRvdXJBeC9EczhSWDhoT0wwaGRHZGxkMzNOL3l5NHdONWdQdXo1c1d5aUZn?=
 =?utf-8?B?eWZybWlCR2ZCZ2NaeHlJUUVBajdXSEF3MHpNdEgvNU5ZM291REtNMTRYZ1FH?=
 =?utf-8?B?SC91Nm5ld2Z0Q3BOZ0xkR1VzRi8wYXVPRVRFdy81VFNGV2Q4MU55SmtGL3NS?=
 =?utf-8?B?aFJYdDMyNjNDWUlyalRIY1NzNTFhMjBYSWw5aFp5cUZFU2lVbHZPcDlCc1BU?=
 =?utf-8?B?dmhUV3pmeHlVV0c1dXZTU3liV1BMKytsWndVbU5wUUhjY0FIS2ZNSnZmVXpx?=
 =?utf-8?B?T3hjS2xIbDlpNTM0OE5VYk1hSm1KVlFUOHBGS3NWS2l4d3B0eGpJNnlud3dw?=
 =?utf-8?B?M3dpcVRsV3pvRVlGc0kraW1zTkpEMkx5QkozdGNtczU1SXdvNWQvZGFsMnRH?=
 =?utf-8?B?a1E0L245bzAyd0p3eTFnb3Z3Z2tHdXNhdkxIcHRMZWNoWnk3TEgvUzRmZzNB?=
 =?utf-8?B?enhUcHpYUUZGNkpXVEJzNlhTN2F2TWpEbVVSOXJhelMraEtjL2k3YkhBR2lW?=
 =?utf-8?B?a0pMdldxNkwxcWVSU3h0Mi9NeDRZdEl3QVUrZjVuY1ZNK29CdTR2MC85NXFP?=
 =?utf-8?B?eC93dUM0YVN3cEM1ZmFLUloySVAvY1llS1EyN3lMQS9BNXBqRzNudlB0YWlN?=
 =?utf-8?B?ZEw0MEUySXNhTGtrRkJzVTFkMHd4ZUtnR09pNk9wcGVnQ1BpMmYzVlNRRHJJ?=
 =?utf-8?B?Rk9Cd3R2bU8rNVFNVktmamt3cW1BNGFldVUya3ZqUnJHakJTdm5IQVg5UDd6?=
 =?utf-8?B?NFJVUWp1MWlsbEcyTk1rOVozaStxdUZJSVIzekhZVE13UERoNWZVdldFeGdE?=
 =?utf-8?B?L2w2YzlnWWdHNXJVVHhnY1U4WHJEajlVbHpIb1hDVmY0Z05aeWk4Q0Q5d2p4?=
 =?utf-8?B?VDBBdG1CeFF2eXdldVBSdXRHL245bWJvQjQ1T3NWVERJcGdDZ01YYW1aSHNF?=
 =?utf-8?B?ZUthNHdBMVRHajV4dDdBekJwYnFpRHNaeldmTmxpdkpuallXMXFVUldqdmtR?=
 =?utf-8?B?M290OUFZSUhhZUpLTkRjeXdyRW9iM0FUSlBUc2Vid1JuaTMrQlc4ZkhlaG80?=
 =?utf-8?B?S2FYTEt1aDFNV0lCbENRdXQxcWt0YmRPSm1mZlozM21NaUh4bThmWE9iby9R?=
 =?utf-8?B?bFhRVjRoNUsySmxqUC9kc2FVdTBVdjlXUVBxNmZEM0g5TTdjTjNNdFN0UThx?=
 =?utf-8?B?TldVVkhzam9TWlVtc1Z3MkV3YWxQMjZvV2JKaGhkd2tSb1NjQ0FueFpodTFG?=
 =?utf-8?B?SThoSlhza2NlNmVEVTVFYU9GRlBEMGRkdFJId1ZIVDJ6M1krQUdRQnFrUXg0?=
 =?utf-8?B?cnQ3M0ptdndrZXBmR0ZvaGptQUdBR0szQ2dYSUVPdERCRHR0MCtBbXBmMEFT?=
 =?utf-8?B?dkRsbkpBVTFMREIrdVdRSzJBK0ppNU8rT3N6RmcwM0pMa2lGbUZsbGZoaUpT?=
 =?utf-8?B?dGxrWE1pWU9TS0RSQTlNZWltYU9qREs1TVpYR3RtVCtvNTBFNUdMZXZ2YVdL?=
 =?utf-8?B?VzJScU9VSGxGZDRUSVhKUE1IQkpDSzI0TFFEZXVXajdjenNiOStiVnRPZ1Rz?=
 =?utf-8?B?QjdGSU5adUtDN3lmTVJuSVZuSmhmMWx1VVVEWjBSMEp4WHJsUS90RGRqeUVF?=
 =?utf-8?B?czU4SGN3UkhEZ0l5TkczQlcyOEdwWnRjTmd4OWtWRE12SWt2VlBzN3A1dlBq?=
 =?utf-8?B?aWQ0SDE1RnJuNVh3Z2JoU0dTSmJ0eC95bDFrcjN0R3lsdFA0RnpGV3pjbDF2?=
 =?utf-8?B?Z3lHQzk1dW9vamswN3ZvY3NtUmwycGF5cFptbHpaOUdvSytUY1dwNnNFOVd3?=
 =?utf-8?B?Q3BKTVp5cEZ0S2FCT2dpc1JpcFFXazl4N1pNS29ONWdHalQySnhYOWJZM1c1?=
 =?utf-8?Q?GXZmKSoqI0G9+qx3WMUCdPw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51DC3175B1CBC5438ABF1A69EF7CE6C3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e9f51b-81b8-4aaf-ed6b-08d9f8043191
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 02:11:54.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4imI5uX8oMIoWyWD+8Qy0/kcmqnLIwYffo+r66YNKnfycEkQ3zSOdXM56OcnExKx/Adl9DUKyMmbszW9ReajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4958
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDA5OjE1IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMyBGZWIgMjAyMiwgYXQgMTY6MTIsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3Jv
dGU6DQo+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbT4NCj4gPiANCj4gPiBJbnN0ZWFkIG9mIHJlbHlpbmcgb24gY291bnRpbmcgdGhl
IHBhZ2Ugb2Zmc2V0cyBhcyB3ZSB3YWxrIHRocm91Z2gNCj4gPiB0aGUNCj4gPiBwYWdlIGNhY2hl
LCBzd2l0Y2ggdG8gY2FsY3VsYXRpbmcgdGhlbSBhbGdvcml0aG1pY2FsbHkuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzL2Rpci5jIHwgMTggKysrKysrKysrKysrKy0t
LS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jDQo+
ID4gaW5kZXggOGYxN2FhZWJjZDc3Li5mMjI1OGU5MjZkZjIgMTAwNjQ0DQo+ID4gLS0tIGEvZnMv
bmZzL2Rpci5jDQo+ID4gKysrIGIvZnMvbmZzL2Rpci5jDQo+ID4gQEAgLTI0OCwxNyArMjQ4LDIw
IEBAIHN0YXRpYyBjb25zdCBjaGFyDQo+ID4gKm5mc19yZWFkZGlyX2NvcHlfbmFtZShjb25zdCAN
Cj4gPiBjaGFyICpuYW1lLCB1bnNpZ25lZCBpbnQgbGVuKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gcmV0Ow0KPiA+IMKgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgc2l6ZV90IG5mc19yZWFkZGly
X2FycmF5X21heGVudHJpZXModm9pZCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVy
biAoUEFHRV9TSVpFIC0gc2l6ZW9mKHN0cnVjdCBuZnNfY2FjaGVfYXJyYXkpKSAvDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgbmZzX2NhY2hlX2FycmF5X2Vu
dHJ5KTsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IFdoeSB0aGUgY2hvaWNlIHRvIHVzZSBhIHJ1bnRp
bWUgZnVuY3Rpb24gY2FsbCByYXRoZXIgdGhhbiB0aGUNCj4gY29tcGlsZXIncw0KPiBjYWxjdWxh
dGlvbj/CoCBJIHN1c3BlY3QgdGhhdCB0aGUgZW5kIHJlc3VsdCBpcyB0aGUgc2FtZSwgYXMgdGhl
DQo+IGNvbXBpbGVyDQo+IHdpbGwgb3B0aW1pemUgaXQgYXdheSwgYnV0IEknbSBjdXJpb3VzIGlm
IHRoZXJlJ3MgYSBnb29kIHJlYXNvbiBmb3IgDQo+IHRoaXMuDQo+IA0KDQpUaGUgY29tcGFyaXNv
biBpcyBtb3JlIGVmZmljaWVudCBiZWNhdXNlIG5vIHBvaW50ZXIgYXJpdGhtZXRpYyBpcw0KbmVl
ZGVkLiBBcyB5b3Ugc2FpZCwgdGhlIGFib3ZlIGZ1bmN0aW9uIGFsd2F5cyBldmFsdWF0ZXMgdG8g
YSBjb25zdGFudCwNCmFuZCB0aGUgYXJyYXktPnNpemUgaGFzIGJlZW4gcHJlLWNhbGN1bGF0ZWQu
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
