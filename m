Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF74BEB7D
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 20:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiBUT7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 14:59:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiBUT7G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 14:59:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2522531
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 11:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eukXweGh5Q0e3n7fu1Br8GdUks5vuLgUI7kIaakiq3pVHyvNfsKq21flSVsrYGbcBzeP5FSmv75V0rEvihDg4R9N+aACBqCGMozJvPfVMbsrVz6hbdX3aqxeviOCXM1g/VuIE3PSdG5NCsbpqyO6HZOKLAdSb10sDsG0PSIGJe1MeeOxOF0rYVI3C9dUmeRQGrGcxrKMAsjJC2mpp9w+7fK+LqcwFriIQiu+i0nrFRNehOuWVdk0targDU7qRqNuykzBRTYRIWobY5OlXRmTdi4jLCtAOKSRRpyqN/VVVb312X2ET/XRGm4l1vEi36A9kX+uSQkSoiFflCD7v39GTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z22Bit51jT3eua+qJLBaAarpg1gmAsFkPdTbr8DU6o=;
 b=azUXfHKSkyRnPLtmAx4merXw1dOKK3JTcT0MKW02XehvSn8ne9/ukbYRfTxut2p7Npj62cpuFdPaPglddjjSCq9isQPmJvK8WDeVMAcUCLG2orYzXExE9k6j282xWJFSZGl90WsRB9yh4gi3UPrS1rPtbjN7lUR592KMiMiUTuNKkv85wdcmSup/l8k2YxYIchZYPcGjFHeFImbyA5RAt5QV83k8MV6dBYnwQCRpjUhKIbLclcvC8M9Zdj9ZkuoTEJu3MzdMH8ZfazRcYMLsv1S+XQ1JRR4XGXyrvI9mGUvCTJEo9dIu0J9hgrNobPdZaR1ylkOAgHtkFLvYxoW7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z22Bit51jT3eua+qJLBaAarpg1gmAsFkPdTbr8DU6o=;
 b=bYmVVUM87bTTNYc1M3Uug9fqFt2qcZ8KIKM/yqOo2yLQXfMKWSAvdkVr78YnBUmwmaX4IorWzpuORTi6ECY5e+vwTTp/CFjbsxdzBzRXW0LCOeF2gyEA4UD6A2IKZnbghEdgb876lLiIxZCksnaOkJajVoBfJNtjKfqts09JkTU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2582.namprd13.prod.outlook.com (2603:10b6:a03:b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.13; Mon, 21 Feb
 2022 19:58:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%8]) with mapi id 15.20.5017.021; Mon, 21 Feb 2022
 19:58:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Topic: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Index: AQHYJz5fkvZWF2nTREGh+HaYGEm7A6yeNkSAgAA2EQA=
Date:   Mon, 21 Feb 2022 19:58:37 +0000
Message-ID: <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
         <20220221160851.15508-2-trondmy@kernel.org>
         <20220221160851.15508-3-trondmy@kernel.org>
         <20220221160851.15508-4-trondmy@kernel.org>
         <20220221160851.15508-5-trondmy@kernel.org>
         <20220221160851.15508-6-trondmy@kernel.org>
         <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
In-Reply-To: <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d1fce9c-c59c-40b5-72cd-08d9f5748d14
x-ms-traffictypediagnostic: BYAPR13MB2582:EE_
x-microsoft-antispam-prvs: <BYAPR13MB25828C328106C085AA925870B83A9@BYAPR13MB2582.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HA+JNWJTmoh2yeqbKRdHsMQts2ZdSJinDgyujgTTpAhXp/51K40taH/nYCTIr+0IzTLDNH8EewNMxi2qenxW1TJHdh5AkIzydsx8v84a7QhQMm7RSmcWwqhUo9nXKjfJ/mxNqgiY/08kZDK41pWsfrIbodECKF68GpZqB7gThF3Ils4oG7FZXOece64IsEoBCwIRrQ0bE1aHpXHpxtV51oO7Slk6ODMb1FuqE846CYV/EsuGxInCivOPYM6FJBx7WQ7msM7qrqppMWraQMoVWQjHCL9VmP7KKNdKDwD31v8UQocjiwNw/YBj7foEvXf/7pZYZ1tMtAV3/jDv/aBLt0WPMJsSfCr2Vz2vPatrDuVzE34Gr90JVaOWRda7E1XQ6ykAf6tT+1Ce6E4HEyR/GPg5KNYX5uXlzJFKjj2ACuObgvb5xK2xhF2QkKx8/c0Xb9tu1P2eVpEV6PL89CwIdsHA+YMDbrZ235t+BPtnEBZQxpiBa10UiRmCBcQp6kb2dsO5NKXwBg1kYAt63ZD+YgY2oql7At8YIK4k3vK+R85DuqhPYm6JwOcHsjxftTbXKiLxahuuS2pMqPcB6mzXdH9jsuGKa7R0XVzwFcbR8voR8+7O8r0sPE0hNa625ubMszMWzwCi2H7JXxb8qfTVOxl7Ze1Q70DMDaxjTLOtFsTA3Xp36WHyu+DDSHWwRO3/VBu2rORsaF1BdtzQloxT9xWbQoFDjGmQ+SP2tvDY2dZT9b/fYMjUCqzLVlx9af9b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(122000001)(6486002)(508600001)(8676002)(38100700002)(66556008)(66476007)(64756008)(6506007)(6512007)(86362001)(5660300002)(66946007)(66446008)(76116006)(2906002)(6916009)(316002)(4326008)(38070700005)(36756003)(71200400001)(53546011)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N21qdnd0NWRwZlJoUTFNY1g2NC9aR1ZHVERCM1Z6ZDY3L1haVGg1ZjVCVnBx?=
 =?utf-8?B?Tkcwd1JRaFo2YXFoMXphQ1RkbnlLSVlLVC9SMzhJTmVHYSszU0ZXMTh4WjUw?=
 =?utf-8?B?WUU2L245QzZOWVJXN2FnU1JyUzFzQTNlbTRhVnMvejNmVkJ4bGZEaHF2RTda?=
 =?utf-8?B?YWt0QWQ2VGlFRkZhRWhCWk9vc2pjOGJQNWFaTVRucCs4SUd2OCtLbGo0OWRT?=
 =?utf-8?B?L3dMU3REb1Z4c1Qvd2NLNmhKMXFhMUtNcnArOEtEa1V2Q3NBTW1xRzcvL2hy?=
 =?utf-8?B?VUQxUkF2QjQzdG12QUVUcERGWGQ0c0VyMWY0akRKbTRyd1hLWFBSZ1BSakR1?=
 =?utf-8?B?UThyZXIxeDE0V2RtNzlIZzdsUm9MVHFwdkNrRlFRVFBEZkJFSlJDTm1uRlFv?=
 =?utf-8?B?aHJyM2tXa3JJNVZuVm53N21oTzVnZHZwOHZSYTA3RlA4cmI2VzZsWlc3MzZR?=
 =?utf-8?B?UHNCREg1SUt2WW5HV1l5M25GSHE2TTI2QU5FWEFNZ3o5cEhiNGVLUnZFbFA0?=
 =?utf-8?B?UmRxcW5ZR3YxY0E5ZlBLdjFwRjMzZTI2K0YxeSs5MmpTK1ZXL213WmI4R0Yw?=
 =?utf-8?B?Z0VUU21CcXErQmNWY0dKRHlVZ0Y0TldTejhzYXRraWk2WjJXcThCeEhqd1JC?=
 =?utf-8?B?dHJ3eE1hVkhlY2xDWlN0dnFxL1pVQ05YUG9Pek5KRHlvU2JFcGNaNEVtRDZq?=
 =?utf-8?B?U2l4VDJDU1lra3JWNjRhNlUyQm5TSG9jU0lQWk9Ea2tNbld4VkViYS85eUlp?=
 =?utf-8?B?RkY1S3lKdklUVEUxSnJISnN5anBDVnZxRFB4clVxRTVQYndFeXRTR0J5cnQv?=
 =?utf-8?B?VEtSNHB2ajduaTJtVEVBNHdQcGxoaE91OWpXV2hld2dzWUJKYk9xZEZoMEpY?=
 =?utf-8?B?eWY5b0E1SktsV1VYRGR4ODJmdWo2U0tUa1J0QmI2T2lmTm5zY0c5ZmxjKzFv?=
 =?utf-8?B?ZmpCUjFEN0hHVTFsSkh0RmtGZzFnbndnRHE2STVIVHRjK0JkZU12MFoxR1hy?=
 =?utf-8?B?eXF5RGhWWnNvcnZaTUg0V2tseDBjKzFleWxLT0xKdmt6cUpaS2JTeFJHeDVs?=
 =?utf-8?B?R1FhZmtEdVFtSGtMVm5XK0FMWmpjNEVWYkFxaUVtdmI4bFhZakNsR0pxWHY4?=
 =?utf-8?B?bFNpYm5xSG5IMktDNFlNcWJhL1pnMENKcnZOdWdmQmxYelZFUlNVUWlXcUxV?=
 =?utf-8?B?d1RvUUt1bnlwaWl3TGN6T1dRRkF1UXNmRXA1dEtFYm1vNEF2SkFSK1FsS2lV?=
 =?utf-8?B?ZnRKSVN1ckdIN0NEUHpjeUhTQTZIYXFWdkxDQSs5bjZtaStYTS8vQVNOVnBM?=
 =?utf-8?B?bTd5R2szdGNXY1QzQnhtQnoxSTBKUkNKMzg3OHhzeTdWa3VRK3hjMUNjbTl2?=
 =?utf-8?B?bWt2TGJVcXNHTkhyUUdrOXc2S0Z3eWo0VTk2YXJWK0FkbGVtZHJ6ZHJhcE9H?=
 =?utf-8?B?QisxQmxHam45NVNNd3JNUzlhVmdsZXF6UkwvYVlJWk94RXhsQ3F5bTNGVlFl?=
 =?utf-8?B?U3pmUnk2S1k4WStXaGNLTlpVMUE5T093ajFZMklqVzlibHpoYmpIRUxkdm1a?=
 =?utf-8?B?UjVySGZFRE0walBXclFwYmRLK1NBeVIraEhlSHozMzB0TUQyY2xxRmZIMVZQ?=
 =?utf-8?B?UE5hV3c0WlB1T0s4cmROVStOSytIdGxEcVo4MEdtdFhCdThycmR0YWRUMWov?=
 =?utf-8?B?MGVqZ2tWalIyVDJCTjJ4TExvbVJncENPblp6NWhUeUxDQUpleTgxYWs4d3FU?=
 =?utf-8?B?T1Y3NW5rSFplZ05CUEtZZWc0TGgvRmxPR1hDR3dxMHNrcnR0S0p6YlVkNUVZ?=
 =?utf-8?B?MjlwVStZRXVZV3YwU0JJa2NhN0F5bU5HRGhnMkhaeTcyQ3FhOXJURlpPOTgw?=
 =?utf-8?B?cmVGbUNreTU3bjZRMmZYRm8wWS82U0JYNTY0WEpuTHRBL2pxcVY0NlZKN3hu?=
 =?utf-8?B?VWM3ZzA3bmQwVzBTa3NSWkJlQm5XWGN1NFQrL214T1c1eEdZTEFLL2Rzay9U?=
 =?utf-8?B?dXAyOENkMXdoaXppaC9QUWpTTXo3aXQ5TzFqZUNIQUw0NlZVdHNySitZRm1h?=
 =?utf-8?B?V1k3R3dUZzhGSlpya2pPRU1rTlB3YlBHbTVscU50V25Uczk4R0FpeTJ6eDI1?=
 =?utf-8?B?eWRpd3BHb0dBa1VzRGNuUHVGZFdoc24zQ0lIOGFLbXU1OTFDQmFJVTROMjNS?=
 =?utf-8?Q?FR/PwMU8gcMMfTImP8pycHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0043934675B1354C932074C81DC5BC42@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1fce9c-c59c-40b5-72cd-08d9f5748d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 19:58:38.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSRuLfH/MzXO4kbrneazBkyJOMvAiJONsUgUZUB+y7FZ9Pq3k6tSVC+oPwmQ4oTTScckmrPYGyMTeuPCMTMelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTIxIGF0IDExOjQ1IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMSBGZWIgMjAyMiwgYXQgMTE6MDgsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3Jv
dGU6DQo+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbT4NCj4gPiANCj4gPiBXaGVuIHJlYWRpbmcgYSB2ZXJ5IGxhcmdlIGRpcmVjdG9y
eSwgd2Ugd2FudCB0byB0cnkgdG8ga2VlcCB0aGUNCj4gPiBwYWdlDQo+ID4gY2FjaGUgdXAgdG8g
ZGF0ZSBpZiBkb2luZyBzbyBpcyBpbmV4cGVuc2l2ZS4gUmlnaHQgbm93LCB3ZSB3aWxsIHRyeQ0K
PiA+IHRvDQo+ID4gcmVmaWxsIHRoZSBwYWdlIGNhY2hlIGlmIGl0IGlzIG5vbi1lbXB0eSwgaXJy
ZXNwZWN0aXZlIG9mIHdoZXRoZXINCj4gPiBvciBub3QNCj4gPiBkb2luZyBzbyBpcyBnb2luZyB0
byB0YWtlIGEgbG9uZyB0aW1lLg0KPiA+IA0KPiA+IFJlcGxhY2UgdGhhdCBhbGdvcml0aG0gd2l0
aCBzb21ldGhpbmcgdGhhdCBsb29rcyBhdCBob3cgbWFueSB0aW1lcw0KPiA+IHdlJ3ZlDQo+ID4g
cmVmaWxsZWQgdGhlIHBhZ2UgY2FjaGUgd2l0aG91dCBzZWVpbmcgYSBjYWNoZSBoaXQuDQo+IA0K
PiBIaSBUcm9uZCwgSSd2ZSBiZWVuIGZvbGxvd2luZyB5b3VyIHdvcmsgaGVyZSAtIHRoYW5rcyBm
b3IgaXQuDQo+IA0KPiBJJ20gd29uZGVyaW5nIGlmIHRoZXJlIG1pZ2h0IGJlIGEgcmVncmVzc2lv
biBvbiB0aGlzIHBhdGNoIGZvciB0aGUNCj4gY2FzZQ0KPiB3aGVyZSB0d28gb3IgbW9yZSBkaXJl
Y3RvcnkgcmVhZGVycyBhcmUgcGFydCB3YXkgdGhyb3VnaCBhIGxhcmdlDQo+IGRpcmVjdG9yeQ0K
PiB3aGVuIHRoZSBwYWdlY2FjaGUgaXMgdHJ1bmNhdGVkLsKgIElmIEknbSByZWFkaW5nIHRoaXMg
Y29ycmVjdGx5LA0KPiB0aG9zZQ0KPiByZWFkZXJzIHdpbGwgc3RvcCBjYWNoaW5nIGFmdGVyIDUg
ZmlsbHMgYW5kIGZpbmlzaCB0aGUgcmVtYWluZGVyIG9mDQo+IHRoZWlyDQo+IGRpcmVjdG9yeSBy
ZWFkcyBpbiB0aGUgdW5jYWNoZWQgbW9kZS4NCj4gDQo+IElzbid0IHRoZXJlIGFuIE9QIGFtcGxp
ZmljYXRpb24gcGVyIHJlYWRlciBpbiB0aGlzIGNhc2U/DQo+IA0KDQpEZXBlbmRzLi4uIEluIHRo
ZSBvbGQgY2FzZSwgd2UgYmFzaWNhbGx5IHN0b3BwZWQgZG9pbmcgdW5jYWNoZWQgcmVhZGRpcg0K
aWYgYSB0aGlyZCBwcm9jZXNzIHN0YXJ0cyBmaWxsaW5nIHRoZSBwYWdlIGNhY2hlIGFnYWluLiBJ
biBwYXJ0aWN1bGFyLA0KdGhpcyBtZWFucyB3ZSB3ZXJlIHZ1bG5lcmFibGUgdG8gcmVzdGFydGlu
ZyBvdmVyIGFuZCBvdmVyIG9uY2UgcGFnZQ0KcmVjbGFpbSBzdGFydHMgdG8ga2ljayBpbiBmb3Ig
dmVyeSBsYXJnZSBkaXJlY3Rvcmllcy4NCg0KSW4gdGhpcyBuZXcgb25lLCB3ZSBoYXZlIGVhY2gg
cHJvY2VzcyBnaXZlIGl0IGEgdHJ5ICg1IGZpbGxzIGVhY2gpLCBhbmQNCnRoZW4gZmFsbGJhY2sg
dG8gdW5jYWNoZWQuIFllcywgdGhlcmUgd2lsbCBiZSBjb3JuZXIgY2FzZXMgd2hlcmUgdGhpcw0K
d2lsbCBwZXJmb3JtIGxlc3Mgd2VsbCB0aGFuIHRoZSBvbGQgYWxnb3JpdGhtLCBidXQgaXQgc2hv
dWxkIGFsc28gYmUNCm1vcmUgZGV0ZXJtaW5pc3RpYy4NCg0KSSBhbSBvcGVuIHRvIHN1Z2dlc3Rp
b25zIGZvciBiZXR0ZXIgd2F5cyB0byBkZXRlcm1pbmUgd2hlbiB0byBjdXQgb3Zlcg0KdG8gdW5j
YWNoZWQgcmVhZGRpci4gVGhpcyBpcyBvbmUgd2F5LCB0aGF0IEkgdGhpbmsgaXMgYmV0dGVyIHRo
YW4gd2hhdA0Kd2UgaGF2ZSwgaG93ZXZlciBJJ20gc3VyZSBpdCBjYW4gYmUgaW1wcm92ZWQgdXBv
bi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
