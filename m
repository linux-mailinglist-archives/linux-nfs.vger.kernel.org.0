Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B857F6AB
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Jul 2022 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiGXTKy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jul 2022 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiGXTKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Jul 2022 15:10:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66AADFFC
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jul 2022 12:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRr+6VPE5x0oOe5t+K2FRl05bPc5tXEMVI12RknDx/ypSLyY/LFsj4bQNlRIRgIRuIVWzwMeiehI/8mLMv8SJ8uclLJFGGkM04kcAQkCVvHMrS2q/779WSCBl2ND1w9t7HLAehHtlZOzIGJQS/7V15fSrHLuQ5X8YnwdcCKhBfA4K24/1cAyhGOPqHNlIywIBpl1gJzL5KvlxATW1Mb05swmvDSVqXs7swx/IcdYniyFtV/ReXX5T03eWEIZb0pGeZrT4Mv/mdKWIVkY39e7Yj7W342Lj35n2sqEXv7dVFMZ8MEk7ujq+P+rTuot3vSyrYFmz8YCjv7hChl7J7DG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/YAkmMW9usLYVtwbv06eiNU74VtInn1JXjXpHnpYcQ=;
 b=cO5U2rSibPkhij7jojKRkFX6dSPpPxtq7LjoiNHGQr5IcaSwaUeNt/SRGfIH3hNwp5Y/ev8Ig2/eCjI2ebbG4OW5IF8Pep1FIgKbppg7va+VPM/doUTr9zzjmn7sQXgUj5UfG3wYdVvcomoOITuFAb4+wxCfQT8CUAEiC8qzffFmy7njkXP1zfXguFi4DM8e/b0pf17+H4i16BLr/afwid7vJB2lviujWXHEXHGNxPqVKnlWDzjyuen+6wcSajYat8VSlwqacg/cJ9j/TKkJrdm5jm4I+sycLxyVlIB/OZ6dr1JOZwhYzZUzgGBlpxDuzZTsdzlskNJvxsREiFHFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/YAkmMW9usLYVtwbv06eiNU74VtInn1JXjXpHnpYcQ=;
 b=Tw6HJPJ6DRpN+Jg3lN4f1CvFLgwYfUSJSZ05i5z2UZ+p06DqD0sDiM7UTrrFuT4WP5PnBkb32w7gpxj3x1J+hlj5n+HWWh5J1IkXhaR1EE0XtlMK7fD8fnvN1JOJhUn3QcT0HRZIMUnwj3yTXp6FWITv06iVpSQpXFLaTZwg22Q=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR1301MB1996.namprd13.prod.outlook.com (2603:10b6:4:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.10; Sun, 24 Jul
 2022 19:10:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%9]) with mapi id 15.20.5482.006; Sun, 24 Jul 2022
 19:10:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "bxue@redhat.com" <bxue@redhat.com>
Subject: Re: [PATCH 0/3] nfs: fix -ENOSPC DIO write regression
Thread-Topic: [PATCH 0/3] nfs: fix -ENOSPC DIO write regression
Thread-Index: AQHYnfaaDPf4fauhz06BX9UrDdUC1K2N5iIA
Date:   Sun, 24 Jul 2022 19:10:27 +0000
Message-ID: <950a7026534945a1090d4dd671bd56c363bd9417.camel@hammerspace.com>
References: <20220722181220.81636-1-jlayton@kernel.org>
In-Reply-To: <20220722181220.81636-1-jlayton@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d86dee5-0249-4dea-e6ce-08da6da82bb0
x-ms-traffictypediagnostic: DM5PR1301MB1996:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFjEWz4sQS5hdhbjDJ0MWsYPi9x1x+DvEt/Qbcj8+xNzqWKgSGQeZ4CkHBEgquvtGkVRPH4I+ObJYRItos1Wjih+3H25R0sOjZdxEhlVw1kkkdEivIq54g+MDBYbJVPpyip9/MddG383/lmM7Vu/AcLCVUuLyfq/MC9dg4qmZ7OJnu6W++AHkl4bBS4VY1+KXSazN/QctHBQT+I74TZxVju7JdhtkL7iU7AMhbjtlDZHAU6Z9490yDEgDfSC+NZaaaisdEefffHn45UQBBvxj7xqWsw1b4ICXQ5iCWe93OJ9+dbraI7bUKQ9F4vt1U8mqN199lWUYbQ7Rvp3948CYe2/VSAtAv992B/WbFQkgr6OEhdy0X3oGiWzpu2OK2odEP4j6rMSyquffBYJX8go1GJPFhllr1Z7LMdix59d3Gzg5FjBU4Bu+6i6dILmbuH0gmBNWoBIt7D3uaGODrGdpBVZF19y7eF+/ecFq0PYx/Sgi27Walp/OZzPj+2JRw6WYq5mYvHLi0Yb1u1w9x3UTXrRYEScD0AWo6cMxiPuX1AsmOJtNNsFs1UXW04u0kX/S/tTWQxxZcElCXW5W0uAtfAWQJJt9JufLnQSeZXhcNSVR0W2L36FFwfNMBonsJ5sr0u1OkFV6TkLEzLfDXz7ia0LbNaAoTyttTojMyqAljdF6MjPyfdvt/vtfE2zjTID2evg8eoEdI4H9c6JRKZmDqeWaWzTiyZrpIzCpaTSANfWgTjLpMbDDW03fXHl+6oFiCggqJJOLeU4sohiazSRtzS05cie6EFNyWx3g5eJhhOZE/IyWFYSHE04fNrTz4qlO2vXKVVt9K+LZo4fnelg5/QkTm5KH6U6kxIlqQHCqCw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39830400003)(136003)(366004)(346002)(38100700002)(66556008)(5660300002)(2906002)(6512007)(26005)(6486002)(76116006)(36756003)(66446008)(6506007)(41300700001)(4326008)(38070700005)(478600001)(122000001)(86362001)(2616005)(8936002)(186003)(316002)(54906003)(66476007)(83380400001)(64756008)(8676002)(71200400001)(110136005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1UzcVM4S0t1WDJxVEY1cEVTdlhuUmcydHBCcVo0Rjloa3BJcGFhWkpXZVZJ?=
 =?utf-8?B?b1Qra0RNYUVadDVqN2crZEtzYkpXUURKZWRBU05JcDRSMnljREhQNURiaEJL?=
 =?utf-8?B?VWNFUkJHSzRLWHFuYWJqZ05CK0svTk9rS0ZUSUFMUFFxYXF0OHVVOFJqRmhY?=
 =?utf-8?B?UHp1QkFXWXhZR01QbmJzVHdKdERNcnpZTzFuZG1iVCtRUkI2ZHhVZitTeC9B?=
 =?utf-8?B?S2N1VDU1akNDWVc1TXF6ZjFCVG1menhyMytUTUdHaHU1a3lJL0doclNpY0dB?=
 =?utf-8?B?S1RXNURZZW1CL2xNVDIyekp0L0YxNFYwQ1hGKzBJQnZ6Ukh0Z1o2Ujd5b1lC?=
 =?utf-8?B?T0VnU01CbTFtSnp4ZjRzT0M1Yk5LbTNtMW1MTFhNMDBCbVFBL2lzanpxY25l?=
 =?utf-8?B?dEVYK2RxME03aGF1Y29HSytUK0VzcEpKZVc5Uy9kcHB4djNaSU1BYnFVQllY?=
 =?utf-8?B?Yk1iRlJOMmNjelMyNE80MFZGRHpkbjJQTGkwVTljVCtVTjhNWmRObG1aTHZO?=
 =?utf-8?B?ckMvWG9oKzdUbmZ6Q3RxUWRRRkZKK3QvUTNwVGphTzQ2bFNzdmxlS1Y2TnZJ?=
 =?utf-8?B?NENrZmhWdUd1M1JEcE9oUEdqYzQ0U3ZnWGJsUFdKSUVTMGZKazBwbmFwWGRE?=
 =?utf-8?B?UkM1VlNmU1pScjVOdWdvQlh5YnRETisrZWI1L0QxVjlVSHlXbjJmTndTeUVJ?=
 =?utf-8?B?TDd3dUlxUHVDQ1AxbGwxbCs2U1kzVkFOZWthclBqSnpSRkhRZTlVK2pEQUhk?=
 =?utf-8?B?Yjhkck9YY3NIRjJtRXpDcUwxN2hCQ3d5MjBjQWlHOUVWNFV2L3dvUFVqekhI?=
 =?utf-8?B?dTZmRG80Mkp1QmdkVktJdkF5ekZMOURCeERaYkhuQmdKWFlUdmdkb2RjSitX?=
 =?utf-8?B?a3B3VUhQRnFHM2kzMmFBNXoraHo3NHlwdjRKekpiNHd2cFBGNHVRanIwZnQx?=
 =?utf-8?B?bU8wTnVPOFVXeWpaZjBiNnVjYXN2U3E2aTFpRUNCZHFHWGVvOGlTUVViVlBy?=
 =?utf-8?B?L3RoU3dTdDErUTBZOE4rSnNEbzlpWFJxYjk3QTZCZ0xtblAwbGNTUDRTYWVw?=
 =?utf-8?B?YXVRc3NKLzE5bGh1L0hSVk1vUmV2YmxSYjRqSmxLeVNYNEpwRG9WOXpNOGRX?=
 =?utf-8?B?S0Z4dGhIRnN5azhjUDl6b3NIcjFHTE5oU0N1alFnNWFoN2EyekczZ2xCTDEz?=
 =?utf-8?B?OXZEd2ZsRzhDYStjM0xnMlB4aWIyblNkNnQ3ME4yenZhZWN0YlMyTWdsTFhx?=
 =?utf-8?B?SUJDeWNOcERzOURaTlliaXRSTjMwcHB5VmhNazZNUVFYQjQyL3orS09VQW9O?=
 =?utf-8?B?bTB3N2ZSNzdCaFNrcWpzRnBiQ0VoNStzZjN2bnBvS2cxNVNSbVduWTJsam9q?=
 =?utf-8?B?NStkU25TOTd4a2UxL25iRm91U0YxUXZhL1dIRjBvL3JMR29menRBQi9NN1FS?=
 =?utf-8?B?YkxIYjF0WlVOM0xFcEIxWWtTUVJ4MTN1QnJpdnA5OGdIdUVlQXQ4ZWZRR3Zi?=
 =?utf-8?B?NUJYR1NHdUN0WjNxNVlkNE8rVitOeWV0RGRjT0FFK0pCend4bFJXUU9NNDB2?=
 =?utf-8?B?WHA2K3NuYytuMmdMVTFoYjAyR21TajdtQjhlcUFtZnRvSldGSVBUMzFDZ2NP?=
 =?utf-8?B?Z0xZTTJvV0xKTzlaUWpQK05ROS9Yc2xTL2p1Q2ROc2hveDNrWVJXc0liejky?=
 =?utf-8?B?WHUzL1A2QktzK2hrbm5jd3ZFc010cnBRM0Q0anhvVGU5cnFHYWhmbVU4R2hU?=
 =?utf-8?B?bU9Gem13dlNmMHFCZUcrQjIxWGtaTzEwQ1BKWXFEenY3T2dvMEpWM1dmTWFu?=
 =?utf-8?B?d2FhQWI0cjB2ZzV4aTc0NFFPZmw2NngvcWJLb1RnMitRMjdtNDFMQ1VyaXNO?=
 =?utf-8?B?RHR0VjhBZHBuMHFOUmlEM0ltTTB2ak5BYldLZSs2akR0LzBiU0RjeVVMWjYv?=
 =?utf-8?B?NTlNS1dNRHFiZGllckh0OFUvZDBDUDdmcFovVDdwYlZzR0pSMUI1MXhxSkoz?=
 =?utf-8?B?RlI5RlFEcVZHZHVzdHpSeW13VllBUjM3M3U5aXg5d21GQjdyRGN2cGJZWXRx?=
 =?utf-8?B?bm45dEJjNWtDT2tLVG9VZWJpTmNyMHNXcDBMVk1Wd0YyK2FoMXN5YTd1Q2dU?=
 =?utf-8?B?UVRyL25ZS3dKQWZQZEc0a1h1SU5tYmE4cGNYdkdzRzdnTHBkNzRNbnE1SnlE?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25B7BFEE691675428C716D386B1325C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d86dee5-0249-4dea-e6ce-08da6da82bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 19:10:28.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8DbGuaUF9lYMbTeTxtNXoR4IsWsAdsMD0pqdhl9xj9UTnL64XH1WAmeI5B3jJcsiy5lI+wtvKbF6QKh7emwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDE0OjEyIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
Qm95YW5nIHJlcG9ydGVkIHRoYXQgeGZzdGVzdCBnZW5lcmljLzQ3NiB3b3VsZCBuZXZlciBjb21w
bGV0ZSB3aGVuDQo+IHJ1bg0KPiBhZ2FpbnN0IGEgZmlsZXN5c3RlbSB0aGF0IHdhcyAidG9vIHNt
YWxsIi4NCj4gDQo+IFdoYXQgSSBmb3VuZCB3YXMgdGhhdCB3ZSB3b3VsZCBlbmQgdXAgdHJ5aW5n
IHRvIGlzc3VlIGEgbGFyZ2UgRElPDQo+IHdyaXRlDQo+IHRoYXQgd291bGQgY29tZSBiYWNrIHNo
b3J0LiBUaGUga2VybmVsIHdvdWxkIHRoZW4gZm9sbG93IHVwIGFuZCB0cnkNCj4gdG8NCj4gd3Jp
dGUgb3V0IHRoZSByZXN0IGFuZCBnZXQgYmFjayAtRU5PU1BDLiBJdCB3b3VsZCB0aGVuIHRyeSB0
byBpc3N1ZSBhDQo+IGNvbW1pdCwgd2hpY2ggd291bGQgdGhlbiB0cnkgdG8gcmVpc3N1ZSB0aGUg
d3JpdGVzLCBhbmQgYXJvdW5kIGl0DQo+IHdvdWxkDQo+IGdvLg0KPiANCj4gVGhpcyBwYXRjaHNl
dCBzZWVtcyB0byBmaXggaXQuIFVuZm9ydHVuYXRlbHksIEknbSBub3QgcG9zaXRpdmUgd2hpY2gN
Cj4gcGF0Y2ggX2Jyb2tlXyB0aGlzIGFzIGl0IHNlZW1zIHRvIGhhdmUgaGFwcGVuZWQgcXVpdGUg
c29tZSB0aW1lIGFnby4NCj4gDQo+IEplZmYgTGF5dG9uICgzKToNCj4gwqAgbmZzOiBhZGQgbmV3
IG5mc19kaXJlY3RfcmVxIHRyYWNlcG9pbnQgZXZlbnRzDQo+IMKgIG5mczogYWx3YXlzIGNoZWNr
IGRyZXEtPmVycm9yIGFmdGVyIGEgY29tbWl0DQo+IMKgIG5mczogb25seSBpc3N1ZSBjb21taXQg
aW4gRElPIGNvZGVwYXRoIGlmIHdlIGhhdmUgdW5jb21taXR0ZWQgZGF0YQ0KPiANCj4gwqBmcy9u
ZnMvZGlyZWN0LmPCoMKgwqDCoMKgwqDCoMKgIHwgNTAgKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gwqBmcy9uZnMvaW50ZXJuYWwuaMKgwqDCoMKgwqDCoCB8IDMzICsrKysrKysrKysr
KysrKysrKysrDQo+IMKgZnMvbmZzL25mc3RyYWNlLmjCoMKgwqDCoMKgwqAgfCA2OQ0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoGZzL25mcy93cml0ZS5j
wqDCoMKgwqDCoMKgwqDCoMKgIHwgNDggKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiDC
oGluY2x1ZGUvbGludXgvbmZzX3hkci5oIHzCoCAxICsNCj4gwqA1IGZpbGVzIGNoYW5nZWQsIDE0
OCBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkNCj4gDQoNCldpdGggdGhpcyBzZXJpZXMg
YXBwbGllZCwgSSdtIHNlZWluZyB0aGluZ3MgbGlrZSB4ZnN0ZXN0cyBnZW5lcmljLzAxMw0KbG9v
cGluZyBmb3JldmVyLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
