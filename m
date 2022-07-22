Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5E57E626
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiGVR7w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiGVR7v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 13:59:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36BD7436E
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 10:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byFq2eBQpp4CflpjVrMTmBF6ePYSigHd1r69VrT0AVuvSOp1kOFJuyQ0E+klWE1kRmJkHfh/XhGW+5XZkig4xb43XAbuCf1wDrDbmL/nYbKLPiazyFUUxb2OkVaAwNLKzlvIplJ56ewNKifTGJovjG+XRC1SXjCVDRoDCd9miVOtnq+PXpTVUVJbpq2YJ5XR1JlQItPTcDPRtrbK+UdIgO/tUSiQ+V0HWNbO0lsobCX7MXF7exFP0UsjQhFtwxliL12nHixJg8ymdndAyhkSnZyHT5mIHKEcG/+oLUS0fCM2fr0hKoDJKMtDNm5httoQQ9lCdzS/UV8iTURzwNkpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHtP8Yl2qzYyv1U4CmMIrkPK9EXs5KefGqVmmPU84LM=;
 b=VGGEjuVHr4fhlqZmFn6dc23Kj36BFxR1MLF5wMwy5vJH6d3phRsoilr1HxoMIsq+lFN+UN1YRjboJxNxWSRSB5hTNedAWLFRIAG58tBbgXVR7BjhmHzTQ6hcQORLj/CKQY3wUS3ToLZenQ7mACunqrYIu4szB5D99+sYlWhoDup0DHJq4OhOU06+EvTVUS2jCtYYzrQUYx1ZwSoQlRTTw+HPNW3UTW52NZ1YvJ1PosvrKr6pxT6w0qh9LGvWO/OlHiAfL6AONh9PrblNEz7pJygEuVl+COiy6WLBGECIlH4mC9+snCAFAAQNP59LUfG5pRi0QqvubJu01veDYCZxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHtP8Yl2qzYyv1U4CmMIrkPK9EXs5KefGqVmmPU84LM=;
 b=f3GWW3EH3FZoskWM/FWNMCBCnprCrBsXFnYVD1oOWQy1mnIiy51hHudwLBYv6PK78Y3+5irhr5gpEzrNnhG+skctPM6QsGM7pyq+uxzQRU8sBCE/hyi1/SEHOnA661SyDL/lcGoUGVYsYyhO5WcCipkeNDubnZh71y+mc/wctcw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB2235.namprd13.prod.outlook.com (2603:10b6:5:c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.16; Fri, 22 Jul
 2022 17:59:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%9]) with mapi id 15.20.5482.001; Fri, 22 Jul 2022
 17:59:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] SUNRPC: Replace dprintk() call site in xs_data_ready
Thread-Topic: [PATCH 3/4] SUNRPC: Replace dprintk() call site in xs_data_ready
Thread-Index: AQHYnfAWSnxnXeTSJUakmvtDQMcyLq2KrccA
Date:   Fri, 22 Jul 2022 17:59:47 +0000
Message-ID: <66371b9db4210fe853e98a8ec68b0f780ba886af.camel@hammerspace.com>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
         <165851074247.361126.17205394769981595871.stgit@morisot.1015granger.net>
In-Reply-To: <165851074247.361126.17205394769981595871.stgit@morisot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214b0f14-7dfa-4c30-7b39-08da6c0bf752
x-ms-traffictypediagnostic: DM6PR13MB2235:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: US1ZrYc26+JYnUTt/seWQQHMGDT5/0nqzXo070sJz5NapyRHyZ2doB3siTid/N7ZgofqJgd/iwDGBX/cHtn5fPfbt3dQWDYntFocmGeWIvm+K6LfpIcND3R0LKGn3yKIMA7g1/yD7qgk/RaWUENtq+QK21a7Kyr945UiN0E41N8Hf+DQ/9pWOZmg9N6zw5CaE6M5EJh65EkHv3ZFsX72B/wR+EJrafDaPENn5x8eXiEiV2rZCoSPNAdPYJXX40KEfZ0vgTGStuL6HPETT2mAnDmqqObXxykQyFH/7oFYKi++3wGfXk9y9/2/jSllt9o3K/eSVWK4WpOIBq97gYUnXCDNCxrMqrTpD+nQWaHbhg4OdnQ4c64rGy32FtnyMOO9gnqN3Q5V1zWF0ijHKfzqblFTpKckPhVs2bxsnKSB70P6NLdVXpecKpKckrKrSMYvVZAWdjpvOpHxhWqHP76W/i/U10STu0vhTRuIcKxtlONcrhGD9MwcLw+GeOwfxA1a7bWzcjDk5FaBXjpjhegQ7pl/6C4U2ayTc9GFaMompZUX7vkboXqve3xDfUC/jkbBaErroKIe3XNlbnkKpmgLFV0Iwb/7rRUhDrN8whX+ptyHJ/CzMfRcb+IjT/GTfnkJE4Hr1ziKEVHf/bJEx6vv5MUo+hojWS0XgQrAF3cdCq7Cj2AebveGgyFBG1zH7nDluumYSh+Gwhb3NCMmQEtCCfqenSb/mIIBsLwaoq+cM97WNwWnqqWDdqMgRkaBSbfnSacDCAZspExOBDKLXi1a/ixn+eYR9FKH7niobVMdYPk9PahZFpF1QGCgZJv666XN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39840400004)(376002)(86362001)(64756008)(41300700001)(71200400001)(8936002)(2906002)(66556008)(83380400001)(66946007)(122000001)(76116006)(5660300002)(66446008)(4326008)(6512007)(8676002)(26005)(6486002)(110136005)(38100700002)(6506007)(66476007)(38070700005)(186003)(316002)(36756003)(478600001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUI5RjR6Yld3TGsrTXY2eGtyR2Q1UkplbmJKOHNvM1o3MkxVaENjWGFjeVlm?=
 =?utf-8?B?TnlyUVhNVURnbzBsSlVOa2JKOWdDM25SUDFLdU9yTWN1OHptYnUzZHViZGJu?=
 =?utf-8?B?UDNkNXRyRUptMkNCVXU3aUcxNTZFRG5sZG41ZEVaaHlkeEJVZmFPVVBtSlhj?=
 =?utf-8?B?WDVzWEIwQXc2cEJMWnBMdVlFbzRSNDFwNm44bms1UWxqMTJTZkZCWDkwRW1m?=
 =?utf-8?B?bE5FR1JwN1lmVnpMc2ZJbTB2SnpNVVR5ZkNOMFNFVnNxOWU0QlZieDhtSnlU?=
 =?utf-8?B?aTRvWEJTTlhXdmIxUVZqUGJNZWZxcTRvWVpvb3VEWHN4YVlpZFVVeTZJMTdn?=
 =?utf-8?B?ZWlYanNnQVdzMnB2TFZ0RmlCems4Uldob2VqZW1OL01MUHdCc2Y4MWpXeWlY?=
 =?utf-8?B?c1J6dWFscEpTNEdwWUdwMzQzUXhkOGJIbEZ6N245bHZncmR5RXBwcWNPTlhR?=
 =?utf-8?B?elU4a09MYjgxM2JlM0ptUi9MMDdiWXZqOUZNSEYva1FPNmV0RlgxSGQ4UE9V?=
 =?utf-8?B?L1kyZHVaNUxZOGw1M1FueGRFTlZFMExNZ2tQQyt2dTVLOW96UnlFOVNkSG5M?=
 =?utf-8?B?Y2oyZlB3QVRzVUVyQlFmVHFtQXJrNUh3Vm84RUtsZUZlREVGOEhPRU9HaXRv?=
 =?utf-8?B?cnlyOHI2Yi9aaGlBWUJhSDFGdU5SNUVqS3kyOERZZkVsU284bEJLbzhSaG5G?=
 =?utf-8?B?TVFBb3p4S1JoQWJRN1ZTZWp6U2JKUFhiV01wNHdLUGdmbXFvdnlLbVNobHNt?=
 =?utf-8?B?dzBWUjZnTnVTbjdUTnFYcHZBSXllbU1Uay9nQzc1THMycUVwQlpVazdVZUI0?=
 =?utf-8?B?RXBtR2VjMDExQW5BdHlpRDBtOFlmdGVwMU4yREFnVXhKeEdRSkppajA0Ymgv?=
 =?utf-8?B?VjZLVjduWXJ3NUwrSSt5b05KdS8wZW95RXFGSkJXN25jMEZ6NGIvWXlWSjBt?=
 =?utf-8?B?OTRjUEFLMGt3SjdsU005T3ZKa3grSnhsUDZJS2xVRGx6NUNsVE1ocGcvT2JJ?=
 =?utf-8?B?QjM3YXhwekowTm01T0dIeVdlWGVvMXBZZWI3bWpFdTFabkhhekhFaHU1SEpk?=
 =?utf-8?B?eE9OMXVYUlpRZzdyTzZLbjUwNHh5L1QyTk9LQ1hrTm9uVzN1amNtSmo0blll?=
 =?utf-8?B?b2RDc05VUWN4UGtmR1ZBbW9saXpqM0VNWWxXaDNsVTIyU2M4QUM0Z211MDNF?=
 =?utf-8?B?cnlpWVBrZ1MxS09LMVdLZEZNMExOV0pScXB0MnZzanc0Z04xdWJTQ1lsbnJN?=
 =?utf-8?B?WGRLdXc4V0Z4SThZMDNLOW9vbytvLzBiWTdYdDdrMWV2TUdHZVNOUDJ3Q2xo?=
 =?utf-8?B?L1g3b040ZG52RVNxVFdCNVJiOVdBTmlhaFhkOGRqbzVzM3pJYndvZzNDRE41?=
 =?utf-8?B?K3dtdFNrNmdkTUxJNVNHaXFQbTRiaUlPQnUvbzJ4Qk8xR3EvWERVMUZYWEdy?=
 =?utf-8?B?ZFFQSnV0SW8zL1A3Y2pKYmZyVkxId1c4blpjVWhmSW9yNFJxaUx3aVIzRVYr?=
 =?utf-8?B?Tyt4Uy9MWEZ4bkxNc0dEZFBCajNRNE5vODdLVklNWFFIblhLbGVjL3Q5SFdw?=
 =?utf-8?B?MnBYeXFZVy9FL2N1d0s1bnViM1kzTms4RXB5c3RLMUdXQzVHK0cwc25qNS96?=
 =?utf-8?B?dVJMTUpaTUJRZjhLKzc1QkJ1Z1NkZVhBQ0Zublo0U2RwWjdsb0JCOWNsVGYw?=
 =?utf-8?B?eFlVN0VvNXkrSlBJUENoTlgxUGxjVldxUHowZXM4YWJxUm55QlNUd3dVekZa?=
 =?utf-8?B?UmdjdXZJSTA0L0VlMjhFSVExMlBib3I0VmxhM1MwWXVKZ2dJV2lVWFVCa2ow?=
 =?utf-8?B?M1RVczR5VjZwUXpnaGl4ZVZ5NFNzTUZkd0J6VFM3UUV4QlE3cFcwa0VKSEc3?=
 =?utf-8?B?SWRzMlRITHNVeWhtSlFPWEdFbE9mNlJUQnV1M1pIOThOMFBTbmhKcVpoS0NY?=
 =?utf-8?B?bHVndzZNeS8yeDd5ME9LeUc5alYvMmRsb1lQeWJHeDdoK3dpQVhoejJLMEhD?=
 =?utf-8?B?TDh3eXI0Tk5GVFpheFhpdmZ6ZE1PU2l5VlBGclUvdjkvMDVvL2E5b0kvYW96?=
 =?utf-8?B?eEFpcWZFSWpKa2t3clhWdzdLVlovT3NodkRSYTBFOHorOG5WWTdkczBxS2Ux?=
 =?utf-8?B?VG9iN1I5V01uK3M3eDVHY1ZoYjBiZnFBMzN5ZEZzaWIwRnNDMnZ2UldOWU1J?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <826E7B9A4D441040935AA5B07A8B9374@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214b0f14-7dfa-4c30-7b39-08da6c0bf752
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 17:59:47.5851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8uDIqzoF/yRfU99axvVFUnlJEVM8GXP+r4Iuk5zDeVyBZ1qXFxBd7eczSOPeFmUFtXA/fkJacNW5t4hcI3eZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDEzOjI1IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToKPiBT
aWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4KPiAtLS0K
PiDCoGluY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oIHzCoMKgIDE4ICsrKysrKysrKysrKysr
KysrKwo+IMKgbmV0L3N1bnJwYy94cHJ0c29jay5jwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDYg
KysrKy0tCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oCj4gYi9p
bmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaAo+IGluZGV4IGI2MWQ5YzkwZmEyNi4uMDRiNjkw
M2I2YzBjIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oCj4gKysr
IGIvaW5jbHVkZS90cmFjZS9ldmVudHMvc3VucnBjLmgKPiBAQCAtMTI2Niw2ICsxMjY2LDI0IEBA
IFRSQUNFX0VWRU5UKHhwcnRfcmVzZXJ2ZSwKPiDCoMKgwqDCoMKgwqDCoMKgKQo+IMKgKTsKPiDC
oAo+ICtUUkFDRV9FVkVOVCh4c19kYXRhX3JlYWR5LAo+ICvCoMKgwqDCoMKgwqDCoFRQX1BST1RP
KAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgcnBjX3hwcnQg
KnhwcnQKPiArwqDCoMKgwqDCoMKgwqApLAo+ICsKPiArwqDCoMKgwqDCoMKgwqBUUF9BUkdTKHhw
cnQpLAo+ICsKPiArwqDCoMKgwqDCoMKgwqBUUF9TVFJVQ1RfX2VudHJ5KAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBfX3NvY2thZGRyKGFkZHIsIHhwcnQtPmFkZHJsZW4pCj4gK8Kg
wqDCoMKgwqDCoMKgKSwKPiArCj4gK8KgwqDCoMKgwqDCoMKgVFBfZmFzdF9hc3NpZ24oCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fYXNzaWduX3NvY2thZGRyKGFkZHIsICZ4cHJ0
LT5hZGRyLCB4cHJ0LT5hZGRybGVuKTsKPiArwqDCoMKgwqDCoMKgwqApLAo+ICsKPiArwqDCoMKg
wqDCoMKgwqBUUF9wcmludGsoInBlZXI9JXBJU3BjIiwgX19nZXRfc29ja2FkZHIoYWRkcikpCgpO
QUNLLiBQbGVhc2UgcmVzb2x2ZSBhbmQgc3RvcmUgdGhlIHN0cmluZyB1cCBmcm9udCBpbnN0ZWFk
IG9mIHN0b3JpbmcKdGhlIHNvY2thZGRyLiBNb3N0IHZlcnNpb25zIG9mIHBlcmYgY2FuJ3QgcmVz
b2x2ZSB0aG9zZSBrZXJuZWwtc3BlY2lmaWMKJXAgcHJpbnRrcyBhbmQganVzdCBlbmQgdXAgYmFy
ZmluZyBvbiB0aGVtLgoKPiArKTsKPiArCj4gwqBUUkFDRV9FVkVOVCh4c19zdHJlYW1fcmVhZF9k
YXRhLAo+IMKgwqDCoMKgwqDCoMKgwqBUUF9QUk9UTyhzdHJ1Y3QgcnBjX3hwcnQgKnhwcnQsIHNz
aXplX3QgZXJyLCBzaXplX3QgdG90YWwpLAo+IMKgCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMv
eHBydHNvY2suYyBiL25ldC9zdW5ycGMveHBydHNvY2suYwo+IGluZGV4IGZjZGQwZmNhNDA4ZS4u
ZWJhMWJlOTk4NGY4IDEwMDY0NAo+IC0tLSBhL25ldC9zdW5ycGMveHBydHNvY2suYwo+ICsrKyBi
L25ldC9zdW5ycGMveHBydHNvY2suYwo+IEBAIC0xMzc4LDcgKzEzNzgsNyBAQCBzdGF0aWMgdm9p
ZCB4c191ZHBfZGF0YV9yZWNlaXZlX3dvcmtmbihzdHJ1Y3QKPiB3b3JrX3N0cnVjdCAqd29yaykK
PiDCoH0KPiDCoAo+IMKgLyoqCj4gLSAqIHhzX2RhdGFfcmVhZHkgLSAiZGF0YSByZWFkeSIgY2Fs
bGJhY2sgZm9yIFVEUCBzb2NrZXRzCj4gKyAqIHhzX2RhdGFfcmVhZHkgLSAiZGF0YSByZWFkeSIg
Y2FsbGJhY2sgZm9yIHNvY2tldHMKPiDCoCAqIEBzazogc29ja2V0IHdpdGggZGF0YSB0byByZWFk
Cj4gwqAgKgo+IMKgICovCj4gQEAgLTEzODYsMTEgKzEzODYsMTMgQEAgc3RhdGljIHZvaWQgeHNf
ZGF0YV9yZWFkeShzdHJ1Y3Qgc29jayAqc2spCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBycGNfeHBydCAqeHBydDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGRwcmludGsoIlJQQzrCoMKg
wqDCoMKgwqAgeHNfZGF0YV9yZWFkeS4uLlxuIik7Cj4gwqDCoMKgwqDCoMKgwqDCoHhwcnQgPSB4
cHJ0X2Zyb21fc29jayhzayk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICh4cHJ0ICE9IE5VTEwpIHsK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBzb2NrX3hwcnQgKnRyYW5z
cG9ydCA9IGNvbnRhaW5lcl9vZih4cHJ0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc29ja194cHJ0LCB4cHJ0
KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRyYWNlX3hzX2RhdGFfcmVh
ZHkoeHBydCk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdHJhbnNwb3J0
LT5vbGRfZGF0YV9yZWFkeShzayk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAv
KiBBbnkgZGF0YSBtZWFucyB3ZSBoYWQgYSB1c2VmdWwgY29udmVyc2F0aW9uLCBzbwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhlbiB3ZSBkb24ndCBuZWVkIHRvIGRlbGF5
IHRoZSBuZXh0IHJlY29ubmVjdAo+IAo+IAoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20KCgo=
