Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DED3F2413
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 02:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhHTAPX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 20:15:23 -0400
Received: from mail-dm6nam10on2114.outbound.protection.outlook.com ([40.107.93.114]:64970
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234160AbhHTAPU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Aug 2021 20:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPIu7XzJGMupCmmHnb5uWrmfPg9j9RCDmEgZ+07Sw2+TkV81xDUgiP/qE5cx3P9jC4M7bmxBNEVICjv1P2Cq1XPO1lPvbxJKr8WCCpnGQQzd3ghC789wVgmhdfmhdao71npjn8v6EdZVd6usMCgUyx+4VlLMu97T94ciHSBwJ2fy8ZBG1A4zUAskeGy84hQZ3lfpya09eerAT/1E4mIe7ywDIrwMEDuWQeBBvTH2Yx/aYOkaSIkiKmcXk4vNcoGJF2uB+whMFhwCn5u84BqQiUxcKlAnhc4E1LDfFdAYs6ax5gh7wDM5a60/jF5Vg+pAxKuGUt1XO8e10ZpOmVGyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiMdsaSIUgTRpv/vGHCQpVxSoGN8IEcnB9M4Blmp9MQ=;
 b=bh4q6CGF5yLSvjQt3//zEGYLMA5/Rek+zfDJT2GmfVF/rYn5NcBCKITVqjO2jjMBtGmCRpeuDg9eMeWLvqCJsVOll8kXvmJrs6uvdG3sQUvC5ZCUsHssUiZQff8/HFHgmduy1tFcD2fCq+b/dG6irEJ0VkJZOrErMVekXTMidQFocfPSSv9HUFpMvbjUx0yMk7OsDR50VBSS6yqx8hPcRKFaT5yUxSF5L2Yowxvy0fEJtiMzL/PsnJPDpyzfpoleX31bDf/Dc3mRYYzTHTAOnRc5YZzENWnPUZUjuw3M8Dqs0ohVhEuo2pv51ehbsjIz3YQbz8RvbBZSAAS1tG+fIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiMdsaSIUgTRpv/vGHCQpVxSoGN8IEcnB9M4Blmp9MQ=;
 b=XlVOE5OV3CKl/WMuTjIS1ixoPVOrRXNZmmw9aZSGYQDu9UBrBOijOSms0qWKkyhHiGXvoWWBQztGf92Syg6TSWo1AhCmzhz0b7xpG0Kz0BJgQHJ7jSI80/5CYqvpo4Ke+7oJaMObg9qiBO0ZEXEOATn055BXSeZOX98oxKPa+jA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5203.namprd13.prod.outlook.com (2603:10b6:610:f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9; Fri, 20 Aug
 2021 00:14:40 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%7]) with mapi id 15.20.4457.006; Fri, 20 Aug 2021
 00:14:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Topic: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Index: AQHXlPXbrsxTI02VrkeJ/wH346Zxu6t6ysMAgAAEEICAABBWgIAABaWAgACiAYA=
Date:   Fri, 20 Aug 2021 00:14:40 +0000
Message-ID: <ff2b05ffaecf066331c9f74ed0938f86a0e5a4a5.camel@hammerspace.com>
References: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
         <ed3fbd005a9a2e3a6217085ebe05e80cd78766ba.camel@hammerspace.com>
         <6D4FFB37-B5CB-410B-A3C9-AAC92F611520@oracle.com>
         <69e8d4c3ae302ba51a92e20c927006ad33b2486c.camel@hammerspace.com>
         <24B4FABF-C6D5-4FF6-89B7-68EFDC3AB415@oracle.com>
In-Reply-To: <24B4FABF-C6D5-4FF6-89B7-68EFDC3AB415@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d2baf51-a73d-4fd8-7138-08d9636f8101
x-ms-traffictypediagnostic: CH0PR13MB5203:
x-microsoft-antispam-prvs: <CH0PR13MB5203A76DB61D8EF78603480DB8C19@CH0PR13MB5203.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KkcV5NXwiFfOCu+65SK9AGsIWnRKr622NiNHwSp81WcN/IGlEWy7j1rhP0jK4/puclzBsBWLgM23SUwBF+xG0GRqf07ZvLW+5wF6Mvw6KQsZn0OmjBObtpvFHQjiZzXoRBHex6G3Thcid4EwEesoa/vAFWBrkrCyCLeAzTklPqn5GUZxKi++LeUP1LDXMMO2mmQ70ZHeBi56YKqM0hpThpbKISXgEvjkqxLuvDQ4taTNA7eDRQKni/30lzLq4fkRFJHxp1vQLOPgvtZJc+q+XbBy+y6cMSv9/MH3tINz9QBmLXu/aEQm9rXy21HSkG5AEqeeoOHxWUj4r7X/aVhPEVHdnHayhFqShSzX9pBJkQnhaWDA9cl9nBB/ZK1T9b/kfFqMe/yZGpkcVNxwg3gJjIDM50tEbyT9orZ2TtB8S94vmytoD8t3AF55BjbPta4XkpIaMoE3agTIbPUYGG3AXD1aNCfqAO+kII+2wxonsjPx9/y0qTaMjztPrAaICeE+w9O7DdYc9po92fwQOLN/NXtQRcjBPHEJ4kvvLUaeltOOSWblZ3wMKsO73zitFf7tItw0rjva3EjmBswHPiFLxUHKkuiA/dq5nYvoeH/vlU2/r6MPuO9m5cKc5WaJf+0Kq4hTGi4x8ahTcnkVBr9rs1uuNcvw3vWOWFyj4L2mWpqL/6Jlgp+AYwC329rloCdMo93twH7y6Q/mEIWaMLzLR4mXyyUZRx3upcqE31gKVOsIUAEdNUBwEBfXWcI2T1EMk62090PqNbj7a1ZJg/7gS9xdoSK4ZyxEaigiT851vS+tULSO6BW7oYH+SzbHdUFy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39830400003)(26005)(186003)(71200400001)(316002)(64756008)(66946007)(66446008)(76116006)(83380400001)(66476007)(66556008)(2906002)(36756003)(8936002)(38070700005)(8676002)(122000001)(38100700002)(478600001)(4326008)(966005)(5660300002)(86362001)(6506007)(53546011)(6916009)(6512007)(6486002)(2616005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW5kNEFteUc0bEI4ekxIaEc2cHdSMHdic0w3SE4ya1ZCTjFJSkw2ZTZQWmlJ?=
 =?utf-8?B?UzZSdEhPQ1B6S2pzUzMvNWpqcmNFUVJmVkRUNmJpMHYzdERqNi9DV1NjRVFV?=
 =?utf-8?B?NGlRWFZrdEVkR2xMc1MvSDBWbW1vdE9NV2dhVkw5Z1d3a1IrNVBFdmd3VExI?=
 =?utf-8?B?bkFmbStwN3RpdVZKbVlLVk5yTEU1SXMwNHFSY1J1ai9pM2o3d0pVbFFILzd5?=
 =?utf-8?B?Mmx5RG5QZGJzc1Jtc2xzQmx1UDdzQWsxN3FDVzhKeDh5Sk5VZ094V29CdGJi?=
 =?utf-8?B?TjcrbENSV0NER2F2WndodFFGRElVeXRnK0Rkd2VFN0JhTnNNTGFvcmtkQnBT?=
 =?utf-8?B?disrOFJLbUZob2ttam8ycmVyMXA2TFdGcWltZHJqTDJhbndnR1Z2Q3pRZW1h?=
 =?utf-8?B?M1dzWUU4R2JBbmRKU1FPOWNrc3dMVFp2enBkWmFBRG00THcraG8xc2VKZC9Z?=
 =?utf-8?B?aGFnSXVoMStPRVZ4eVFVTnNqNStvQXNpekUxVXovT0NRUnAydEZGelVqdTNi?=
 =?utf-8?B?b2hrMUE1OFhHajlkQzZWR0FIUnF0Z1hoU1cxcGVkR3hzcXVROWIwdFhkMEJX?=
 =?utf-8?B?V0daS3I0ZUh2eWNzS2hsTDZQWHgrVFBScGdETU9xVjhncXU4UjNRTHBaajFD?=
 =?utf-8?B?U0h1dUt6RXQrQzkwNlpjTFpoSXhyY1FXVjR2UzlSK3Q3UmoycUdKVzdGZFpS?=
 =?utf-8?B?TVJjWnFybUhNRW5IclVGMGhFcGZZaTlOZ0lhaGF2V2JoSW55eGFUbElQSzF5?=
 =?utf-8?B?QkxBUjl1bE9jWm9hRGFVNXNsLzh1WndlN0cyKzFVblN3dmlrdU5zV1hoZ0tF?=
 =?utf-8?B?YUppMWs1TlFEMTNZb1FMQUsycGwvUWdxeGlUc2dObVc3MTN0elNJSjVkMmdt?=
 =?utf-8?B?Wm9RQVZEWGRUYzc0eHZHUTFuR2JRV28yVkVUNDlrQVVUM0lMN2QvbVlaZWJB?=
 =?utf-8?B?a0pTUGpwcDhQTjJra0tjY1N1eDN0Q214eHdJYk9udDJrRVdYd3lJamV0bXVu?=
 =?utf-8?B?RWc3bUVHd2NYMjFCUHpZdzl6VXY2L1NOK1dVbHlhS01qVExnWW8zdjRIVTcw?=
 =?utf-8?B?QW1peGlZNHFvZno2M3JjeVBuKyt3RVNIWFhCdFBZZ3hISVlDQzljdlNoOHY3?=
 =?utf-8?B?WkZaYXJ5NEh2RXg4a1VZbVFFb015NmtzYmUrTGJZMHlWU0lIczFqNlBpVGd6?=
 =?utf-8?B?UjVoOUx5RTJUSk1Ga09ONTU1QWIwTEV4QXY4WEdsb0pyNXQ2dDhaYjUxMm1x?=
 =?utf-8?B?dGQyZWE1aG9WUDc0Zm1xZmpITlBFV2RyaFY5aUhuU1hzUXRBSGNab1dZMVI5?=
 =?utf-8?B?b1A1UkkwSU9Eb2tOTldyci9wOFFyQk1FRWVUUEdjSTNyZ29XYVdXaTg5NlNl?=
 =?utf-8?B?ZUJrYXJMSlZKV0c0RktoL1BiWUZ0T2ZLTFg1TnJlbk1rcjk4TXRUWWthZ2JB?=
 =?utf-8?B?NkpaRnZBa3RNa3NBZDRkOXhUVU9vNkFCNVdoY0R2eENMaEkyNXR2RWE5RVhn?=
 =?utf-8?B?V3lBNm5GSzRoY1ltZnBjZ2lTbDRFYjYzUnJ3dEwyNmJEUGpSdjZWZkVoQ29H?=
 =?utf-8?B?VUlvVktxU0F5cDRoMzNYRUQ1U043aWd6NDBJQ1ArcVFBR3VyN2JtdU1MMWdy?=
 =?utf-8?B?NkVzQXhUbzNDOXdYSzZDVVlRQ2dwK1FXdUhzK2Q1aGpvcVNidXdxYytjYUFn?=
 =?utf-8?B?UWZLN1VwVzVQS1hRc3NBTndOdVUxWkJzTlR3cGRDemsvQ3NsZ2RLSHBlL2Vn?=
 =?utf-8?Q?N/rUxXHTRAoQQDdjaxC86LtweorYni04nBX3VmI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAAF330DB6CC0943B06562A5EE4332EF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2baf51-a73d-4fd8-7138-08d9636f8101
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 00:14:40.5156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AP8/mSKw/dO2C5ODIDY+F4dFRtidoIBvy42S+0e3OJhBHRNWH2/i8LGtLgYRmrRq0rMRCEfKSXLDbnEWbDtC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5203
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTE5IGF0IDE0OjM0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBBdWcgMTksIDIwMjEsIGF0IDEwOjE0IEFNLCBUcm9uZCBNeWtsZWJ1
c3QNCj4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRo
dSwgMjAyMS0wOC0xOSBhdCAxMzoxNiArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiANCj4gPiA+ID4gT24gQXVnIDE5LCAyMDIxLCBhdCA5OjAxIEFNLCBUcm9uZCBN
eWtsZWJ1c3QNCj4gPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+
ID4gDQo+ID4gPiA+IE9uIFRodSwgMjAyMS0wOC0xOSBhdCAwODoyOSAtMDQwMCwgQ2h1Y2sgTGV2
ZXIgd3JvdGU6DQo+ID4gPiA+ID4gV2l0aCBORlN2NC4xKyBvbiBSRE1BLCBiYWNrY2hhbm5lbCBy
ZWNvdmVyeSBhcHBlYXJzIG5vdCB0bw0KPiA+ID4gPiA+IHdvcmsuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4geHBydF9zZXR1cF94eHhfYmMoKSBpcyBpbnZva2VkIGJ5IHRoZSBjbGllbnQncyBmaXJz
dA0KPiA+ID4gPiA+IENSRUFURV9TRVNTSU9ODQo+ID4gPiA+ID4gb3BlcmF0aW9uLCBhbmQgaXQg
YWx3YXlzIG1hcmtzIHRoZSBycGNfY2xudCdzIHRyYW5zcG9ydCBhcw0KPiA+ID4gPiA+IGNvbm5l
Y3RlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBhIHN1YnNlcXVlbnQgQ1JFQVRFX1NFU1NJ
T04sIGlmIHJwY19jcmVhdGUoKSBpcyBjYWxsZWQgYW5kDQo+ID4gPiA+ID4geHB0X2JjX3hwcnQg
aXMgcG9wdWxhdGVkLCBpdCBtaWdodCBub3QgYmUgY29ubmVjdGVkIChmb3INCj4gPiA+ID4gPiBp
bnN0YW5jZSwNCj4gPiA+ID4gPiBpZiBhIGJhY2tjaGFubmVsIGZhdWx0IGhhcyBvY2N1cnJlZCku
IEVuc3VyZSB0aGF0IGNvZGUgcGF0aA0KPiA+ID4gPiA+IHJldHVybnMNCj4gPiA+ID4gPiBhIGNv
bm5lY3RlZCB4cHJ0IGFsc28uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUmVwb3J0ZWQtYnk6IFRp
bW8gUm90aGVucGllbGVyIDx0aW1vQHJvdGhlbnBpZWxlci5vcmc+DQo+ID4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gPiA+ID4g
LS0tDQo+ID4gPiA+ID4gwqBuZXQvc3VucnBjL2NsbnQuYyB8wqDCoMKgIDEgKw0KPiA+ID4gPiA+
IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
ZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvY2xudC5jIGIvbmV0L3N1bnJwYy9jbG50LmMNCj4gPiA+
ID4gPiBpbmRleCA4YjRkZTcwZThlYWQuLjU3MDQ4MGE2NDlhMyAxMDA2NDQNCj4gPiA+ID4gPiAt
LS0gYS9uZXQvc3VucnBjL2NsbnQuYw0KPiA+ID4gPiA+ICsrKyBiL25ldC9zdW5ycGMvY2xudC5j
DQo+ID4gPiA+ID4gQEAgLTUzNSw2ICs1MzUsNyBAQCBzdHJ1Y3QgcnBjX2NsbnQgKnJwY19jcmVh
dGUoc3RydWN0DQo+ID4gPiA+ID4gcnBjX2NyZWF0ZV9hcmdzICphcmdzKQ0KPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4cHJ0ID0gYXJncy0+YmNfeHBydC0+eHB0X2Jj
X3hwcnQ7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh4cHJ0
KSB7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB4cHJ0X2dldCh4cHJ0KTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgeHBydF9zZXRfY29ubmVjdGVkKHhwcnQpOw0KPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJw
Y19jcmVhdGVfeHBydChhcmdzLCB4cHJ0KTsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIH0NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE5vLiBUaGlzIGlzIHdyb25nLiBJZiB0aGUgY29u
bmVjdGlvbiBnb3QgZGlzY29ubmVjdGVkLCB0aGVuIHRoZQ0KPiA+ID4gPiBjbGllbnQNCj4gPiA+
ID4gbmVlZHMgdG8gcmVjb25uZWN0IGFuZCBidWlsZCBhIG5ldyBjb25uZWN0aW9uIGFsdG9nZXRo
ZXIuIFdlDQo+ID4gPiA+IGNhbid0DQo+ID4gPiA+IGp1c3QNCj4gPiA+ID4gbWFrZSBwcmV0ZW5k
IHRoYXQgdGhlIG9sZCBjb25uZWN0aW9uIHN0aWxsIGV4aXN0cy4NCj4gPiA+IA0KPiA+ID4gVGhl
IHBhdGNoIGRlc2NyaXB0aW9uIGlzIG5vdCBjbGVhcjogdGhlIGNsaWVudCBoYXMgbm90DQo+ID4g
PiBkaXNjb25uZWN0ZWQuDQo+ID4gPiBUaGUgZm9yd2FyZCBjaGFubmVsIGlzIGZ1bmN0aW9uaW5n
IHByb3Blcmx5LCBhbmQgdGhlIHNlcnZlciBoYXMNCj4gPiA+IHNldA0KPiA+ID4gU0VRNF9TVEFU
VVNfQkFDS0NIQU5ORUxfRkFVTFQuDQo+ID4gPiANCj4gPiA+IFRvIHJlY292ZXIsIHRoZSBjbGll
bnQgc2VuZHMgYSBERVNUUk9ZX1NFU1NJT04gLyBDUkVBVEVfU0VTU0lPTg0KPiA+ID4gcGFpcg0K
PiA+ID4gb24gdGhlIGV4aXN0aW5nIGNvbm5lY3Rpb24uIE9uIHRoZSBzZXJ2ZXIsDQo+ID4gPiBz
ZXR1cF9jYWxsYmFja19jbGllbnQoKQ0KPiA+ID4gaW52b2tlcyBycGNfY3JlYXRlKCkgYWdhaW4g
LS0gaXQncyB0aGlzIHN0ZXAgdGhhdCBpcyBmYWlsaW5nDQo+ID4gPiBkdXJpbmcNCj4gPiA+IHRo
ZSBzZWNvbmQgQ1JFQVRFX1NFU1NJT04gb24gYSBjb25uZWN0aW9uIGJlY2F1c2UgdGhlIG9sZCB4
cHJ0DQo+ID4gPiBpcyByZXR1cm5lZCBidXQgaXQncyBzdGlsbCBtYXJrZWQgZGlzY29ubmVjdGVk
Lg0KPiA+IA0KPiA+IEhvdyBpcyB0aGF0IGhhcHBlbmluZz8NCj4gDQo+IFRoZSBSUEMgY2xpZW50
J3MgYXV0b2Rpc2Nvbm5lY3QgaXMgZmlyaW5nLiBUaGlzIHdhcyBmaXhlZCBpbg0KPiA2ODIwYmY3
Nzg2NGQNCj4gKCJzdmNyZG1hOiBkaXNhYmxlIHRpbWVvdXRzIG9uIHJkbWEgYmFja2NoYW5uZWwi
KS4NCj4gDQo+IEhvd2V2ZXIgd2UncmUgc3RpbGwgc2VlaW5nIGNhc2VzIHdoZXJlIGJhY2tjaGFu
bmVsIHJlY292ZXJ5IGlzIG5vdA0KPiB3b3JraW5nLiBTZWU6DQo+IA0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1uZnMvYzNlMzFlNTctMTVmYS04ZjcwLWJiYjgtYWY1NDUyYzFmNWZj
QHJvdGhlbnBpZWxlci5vcmcvVC8jdA0KPiANCj4gQXMgYW4gZXhwZXJpbWVudCwgd2UndmUgcmV2
ZXJ0ZWQgNjgyMGJmNzc4NjRkIHRvIHRyeSB0byBwcm92b2tlIHRoZQ0KPiBidWcuDQo+IA0KPiAN
Cj4gPiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlIG9ubHkgdGhpbmcgdGhhdCBjYW4NCj4gPiBj
YXVzZSB0aGUgYmFja2NoYW5uZWwgdG8gYmUgbWFya2VkIGFzIGNsb3NlZCBpcyBhIGNhbGwgdG8N
Cj4gPiBzdmNfZGVsZXRlX3hwcnQoKSwgd2hpY2ggZXhwbGljaXRseSBjYWxscyB4cHJ0LT54cHRf
YmNfeHBydC0+b3BzLQ0KPiA+ID5jbG9zZSh4cHJ0LT54cHRfYmNfeHBydCkuDQo+ID4gDQo+ID4g
VGhlIHNlcnZlciBzaG91bGRuJ3QgYmUgcmV1c2luZyBhbnl0aGluZyBmcm9tIHRoYXQgc3ZjX3hw
cnQgYWZ0ZXINCj4gPiB0aGF0Lg0KPiANCj4gPiA+IEFuIGFsdGVybmF0aXZlIHdvdWxkIGJlIHRv
IGVuc3VyZSB0aGF0IHNldHVwX2NhbGxiYWNrX2NsaWVudCgpDQo+ID4gPiBhbHdheXMgcHV0cyB4
cHRfYmNfeHBydCBiZWZvcmUgaXQgaW52b2tlcyBycGNfY3JlYXRlKCkuIEJ1dCBpdA0KPiA+ID4g
bG9va2VkIHRvIG1lIGxpa2UgcnBjX2NyZWF0ZSgpIGFscmVhZHkgaGFzIGEgYnVuY2ggb2YgbG9n
aWMgdG8NCj4gPiA+IGRlYWwgd2l0aCBhbiBleGlzdGluZyB4cHRfYmNfeHBydC4NCj4gPiANCj4g
PiBUaGUgY29ubmVjdGlvbiBzdGF0dXMgaXMgbWFuYWdlZCBieSB0aGUgdHJhbnNwb3J0IGxheWVy
LCBub3QgdGhlDQo+ID4gUlBDDQo+ID4gY2xpZW50IGxheWVyLg0KPiANCj4gSWYgaXQncyBhIGJ1
ZyB0byBtYXJrIGEgYmFja2NoYW5uZWwgdHJhbnNwb3J0IGRpc2Nvbm5lY3RlZCwgdGhlbg0KPiBh
c3NlcnRzIHNob3VsZCBiZSBhZGRlZCB0byBjYXB0dXJlIHRoZSBwcm9ibGVtLg0KDQpJdCBpc24n
dCBhIGJ1ZyB0byBtYXJrIHRoZSB0cmFuc3BvcnQgYXMgZGlzY29ubmVjdGVkLiBJdCBpcyBhIGJ1
ZyB0bw0KbWFyayBpdCBhcyBkaXNjb25uZWN0ZWQgYW5kIHRoZW4gdG8gY29udGludWUgdXNpbmcg
aXQgYXMgaWYgaXQgd2VyZQ0KY29ubmVjdGVkLg0KDQo+IA0KPiBXaGF0IGlzIHRoZSBwdXJwb3Nl
IG9mIHRoaXMgY29kZSBpbiBycGNfY3JlYXRlKCkgPw0KPiANCj4gwqA1MzPCoMKgwqDCoMKgwqDC
oMKgIGlmIChhcmdzLT5iY194cHJ0KSB7DQo+IMKgNTM0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgV0FSTl9PTl9PTkNFKCEoYXJncy0+cHJvdG9jb2wgJg0KPiBYUFJUX1RSQU5TUE9S
VF9CQykpOw0KPiDCoDUzNcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhwcnQgPSBh
cmdzLT5iY194cHJ0LT54cHRfYmNfeHBydDsNCj4gwqA1MzbCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoeHBydCkgew0KPiDCoDUzN8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4cHJ0X2dldCh4cHJ0KTsNCj4gwqA1MzjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJwY19jcmVhdGVf
eHBydChhcmdzLCB4cHJ0KTsNCj4gwqA1MznCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9DQo+IMKgNTQwwqDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KDQpBcmUgeW91IGFza2luZyBtZSBv
ciBCcnVjZT8NCg0KSSdtIG5vdCBtdWNoIG9mIGEgZmFuIG9mIHRoaXMgY29kZSBzbmlwcGV0IGVp
dGhlcizCoGJlY2F1c2UgaXQgZG9lc24ndA0KcmVhbGx5IGFwcGVhciB0byBoYXZlIG11Y2ggdG8g
ZG8gd2l0aCB0aGUgbm9ybWFsIGZ1bmN0aW9uIG9mDQpycGNfY3JlYXRlKCkuDQpIb3dldmVyIGFz
IEkgdW5kZXJzdGFuZCBpdCwgdGhlIHB1cnBvc2UgaXMgdG8gY3JlYXRlIGFuIGluc3RhbmNlIG9m
DQpzdHJ1Y3QgcnBjX2NsbnQgd2hlbiBwcmVzZW50ZWQgd2l0aCBhbiBleGlzdGluZyBpbnN0YW5j
ZSBvZiBzdmNfeHBydC4NCkl0IGRvZXMgbm90IGN1cnJlbnRseSBtb2RpZnkgdGhhdCBzdmNfeHBy
dCBpbnN0YW5jZSBpbiBhbnkgd2F5IHRoYXQNCmJyZWFrcyBsYXllcmluZy4gQWxsIGl0IGRvZXMg
aXMgdGFrZSBhIHJlZmVyZW5jZSB0byB0aGUgeHB0X2JjX3hwcnQNCmZpZWxkLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
