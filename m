Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E819537FA5C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhEMPOo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 11:14:44 -0400
Received: from mail-bn8nam11on2126.outbound.protection.outlook.com ([40.107.236.126]:61057
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230401AbhEMPOj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 11:14:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GczU2oxyojULw4xHqMcfax7fcBefV6MB/EJcmTFHtB2+Al80a9cMnYQb2ziHWqvM22vlofZSZDysx72LEktGZRNsDYaEuiBznPGFracPI+37pZ6gxxfAB778egpps4IG41DtnbuT39h+4zq42EYsb82L+0ou31sx6PGAP1mRhV1H27LKxntlm1e0paF96GBT/s9n7mj8F0rE4zQBb4owDKSBGnmwQbFhbLGhNOZwM4h4NAEzpOERIg4ILuV7famGiYkWfCfSfdSneS6KvqJCb+dMQhtsYTryFrVqWUXpToURd6ohTbgYjknV3ABHtVGKMH5lWcv87PrnGpel4Nkw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py4cYuDmgHwKI2iE4X+ObouA82OKZL3mzK39lLFhUdk=;
 b=l2Z9DrviWfnWt15m8PFUTuOzPbvvF/HsYwGCCJj4zt7q8mEMUgZe09ZhX9aho4dRgX6QISmfFymV9CGotptUbR06bHIs7uGE9t/zI2gInQy39aMoxxhjCRv8GnZVU0qX/JICOZ7A0IcRWivqr32EXNz018hgqJD+20HSbSJTTPWFGGHdRDhFik+zgw3BXT59PU7Jh11UcnWe+UigscBUVcKtEi0FftXM4MCkoZe3eSykk3d2gHWwZz1L79NuN9MHFmoJ85cj1S4rhPjjVbjF//G2QI2q34loVAbFn22qGzEXA6zXJ6wJGKeLhpNoCcwSbHkdh6O7qgadWNmZ/OWRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py4cYuDmgHwKI2iE4X+ObouA82OKZL3mzK39lLFhUdk=;
 b=fvxbKNp30MEuOP3YE596DF7+TrVMOm8gHJfcHULoS3+2KJJGWaXnFdek1csGA3t8aNSK0KIYh94dP2ogfL/lnjq2GUFo8yTYUAyUb+E/bZBy9w70LQiTRp42kbiB6WCGnbBZniUJ2IV2Q6tv3hD1jC4gMpLtI15pBoArqEpiewo=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4688.namprd13.prod.outlook.com (2603:10b6:5:297::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.23; Thu, 13 May
 2021 15:13:25 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4150.011; Thu, 13 May 2021
 15:13:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan@kernelim.com" <dan@kernelim.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Thread-Topic: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Thread-Index: AQHXOsBkqqNSHlZlfUyUZTJCDMwqZKrHyeIAgAB96YCAF3magIAAMPqAgAAA8ACAAAJQgIAAB6aAgAGiQwA=
Date:   Thu, 13 May 2021 15:13:25 +0000
Message-ID: <c85066f64c19e751c1bdef9344a43037bb674712.camel@hammerspace.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
         <20210426171947.99233-10-olga.kornievskaia@gmail.com>
         <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
         <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
         <20210512104205.hblxgfiagbod6pis@gmail.com>
         <CAN-5tyEoaKseyjOLA+ni7rCXG7=MnDKPCC3YN68=SHm9NaC_4A@mail.gmail.com>
         <CAN-5tyHy8VR4apVCH0kFgmvceWynx5ZwngdT3_V6abDXZnmDgg@mail.gmail.com>
         <CAN-5tyG68pQwW_0+GqqF1w+CmCOUU8ncN6++jAA7i_wqibturw@mail.gmail.com>
         <20210512141623.qovczudkan5h6kjz@gmail.com>
In-Reply-To: <20210512141623.qovczudkan5h6kjz@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5d68bf6-5db2-4f81-8405-08d91621a7fd
x-ms-traffictypediagnostic: DS7PR13MB4688:
x-microsoft-antispam-prvs: <DS7PR13MB4688E4288715FEF40E215EEBB8519@DS7PR13MB4688.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9Kg9n8Kjsf/m6gDVCfI+7N8OxS2d2KOpt5YfHRieqquVBmYdp9NxCsynNoQ5kqGAH+MFvXsM2Lk9EqYQlEAu5GOwIbUPtf4MSehGL3wyREjCqganJLeNErGgAI8sTkJ/yjWBjQn4Q6M7X97n670WWTgL9GzamfeNzrz4kYXoeAyS26eIrE4vSZKj6k4zOifN0iMEQjfchusG6mESz+u2ouvxocdLYxe1kOhGDSVK+hIoao50cu2D604hgQb1Ec10iX4woGiL4nLE7oI4FtN6A5MioDtCli+1KXcSBevFqAqA64wrN98t+Ups7UYNsiP2gDdeceukSV6TYXbchOvCbiUOQ27sc4/63eXrzBtf7iyak+NQnxpiJjmJ5fuK7oHPNzqmFy+7qr086At+66b5HXXFyW8xRqpHy9NSgodNU9P7mMa8EpYgVLlz6cFy5qDYVlOmbO2675X8JhCBCPLYIi4zl7duW3qKfhogPbEkcWOSPLPSp3eES8cWbZ0JCUlxbyhg2MrEq+SBohGoaiLa1LvSc/LQV4TwW5TLoIPFjAm0VXqMjfzLJ4D7Nk3hTIOVnN4iR3C99p6CjslQoy+aw5RUA7UHpOi/PdTPanLiOo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(376002)(366004)(136003)(66446008)(2906002)(66476007)(38100700002)(122000001)(5660300002)(66556008)(54906003)(36756003)(2616005)(6512007)(66946007)(53546011)(6506007)(64756008)(71200400001)(110136005)(4326008)(316002)(86362001)(8676002)(26005)(76116006)(91956017)(478600001)(6486002)(186003)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SWJxNncyTWZZVjB3cnIxS2xjTS9kT1hZZDkrQVFjd2lZSDR1a0RKY093R2hx?=
 =?utf-8?B?Wlc5bTZpTHhNSDFoblJCRzNLbW52a1F5VUdwc1RQQ1I0MWlxVjhBc0VwUWgv?=
 =?utf-8?B?cnVBMytzZGVxZU0vUUdCTUQ2ajBySXU2UG1JOXBRS3Uxbi9oL3BOb2RXVGRF?=
 =?utf-8?B?NEpiM0g1RDR2K1ZTbDFGa2FvRUNabm13VEpzRzZhcFcwbGJPSkd1VGlMaEtI?=
 =?utf-8?B?OWRyYmpGOXhRUHFLME5yVW5UYktBSlRJOVh5bXZidDZLSG5rbUZUdFVxN01D?=
 =?utf-8?B?bm95UENic01TM1FOUVk1bHJEdWYreWp4R0RweWhKZHNmWlNEMmRkcGx0VFd6?=
 =?utf-8?B?b0JlZzZzNERXUVdLUUdydis5Rnc4Ymw2N0kxbmhmVmV6QXd3Q3RoWDBFYTZq?=
 =?utf-8?B?VE5ZcGtub21kVWtSKzE0djUzTFcrdHE4MUQ2VkxEbVBlZVNvSGRCcWlGeGli?=
 =?utf-8?B?cEFoNHJIWiszMVFrd3J4TkNDZE5BMTRWTEZKV1RxQVNldDkxY2Y0Y3IyOEp2?=
 =?utf-8?B?N1hwWkNvV2VPWCtjKyttZ2tVamgrWEF3S0t2REgwY0NaOHBPYUJDdFZsYmdh?=
 =?utf-8?B?cEdtc3piN05aRkxpMlgxdXIxY0JTY0EzSnZiclhSM0M2NC9xaWhVWnJSZ2tm?=
 =?utf-8?B?K1Y4TXpCZldRN1dEdEhWR1h0SmtLRjFrWmtabS9sRHFOSWFEUmpSQzg0bGU2?=
 =?utf-8?B?Ym1wSU9DL2dZd1oySTRFS25vUHpteVRaMXI2RDJOYkc3emxSVjhaRVFDaXph?=
 =?utf-8?B?c1ltZnh2QWNtaUFMaTcwbkRrNXA2Z3k3K3NhblJxSEdhekhTUmhMSVZqeVlC?=
 =?utf-8?B?dXgxYllNbUhmUDhSM3FGbDhOcS8vamp6L3Nkd3JCN0NFOWpMVTZCNEpqdDVh?=
 =?utf-8?B?bytOTTZ5NHF1UzlNSDI4NlE2c0VEMGplLzNERGx0ZkFjQTZtMHlaNmZ4Uzdj?=
 =?utf-8?B?MkFUREQzQ1RoaHFtQ2hXRXZ2UFN6MXoyZUt0MUJHUlZsYWxrVmNtK2NHRTBF?=
 =?utf-8?B?YXkxbGNTYjBhL2ZBZG5KKzFHQk45Ylh0WnlGemdXSndKVlVxNlJjZGpCU2xX?=
 =?utf-8?B?L21QdUg5eGx6Y3V6dUVWWEFXYmxZVHpES3NmalhoWEtjREpuWEl6TlNrT0Jp?=
 =?utf-8?B?YzdkWk0rUjlNTUNFWUVTTVRoeWdYSG5MVWgwSnFGbTRNbzR6S2s4NGFFOXF2?=
 =?utf-8?B?UzNlWEwrT3NwNTJvSEtDQnQ4dmU4S3lBL0hYOFlNeEczeVhYRHFKQ21helpw?=
 =?utf-8?B?cFJCZWVsaXV3TDBvNndoRjF2aDR4Sms0VDcwc0FNc3B4WXpGS1lnc2RPRWlJ?=
 =?utf-8?B?UUNDUzRoZXo0SUlDcVBhOVpVVWZHQnJpc1VHbFh4ek1pVTUrcURvTnAyWVg0?=
 =?utf-8?B?amZTMUxmcllienJvMm91aDI3dmNmSENmdW1mb1QwRzZiMlZiK2ZRMDk3dHEy?=
 =?utf-8?B?MDNZbzhwT1RQNXlzN2RzVWR6Um5XSFZoLzBXMVJuRGRXNEY2cjFRcitncmhY?=
 =?utf-8?B?aStNZXRTci9DcW1wOWhncGRGbWNrM252OEN1b2FXS00vNTdNak54Y1A0dDBv?=
 =?utf-8?B?UlNSZjk2TlJsUnlEdzBEa2luK2xaRk9sc0h1Rlg3bnNoSkVoVnVXbDR1eFlQ?=
 =?utf-8?B?eGlmTlpOam5CY3N1aExtdWZYc0NBYWs2VTE2NEZCRzZGYWRkd1NXajlkZi92?=
 =?utf-8?B?aFVWYVJUdEVpUkgybFlncDUyYUxXSldoZlBQRjgweVJ3dEZ1NHkwTkl4bDFn?=
 =?utf-8?Q?UaJV9hATUAhyDJiMXJBpUOxgOic/tCkppWwJz5X?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <80F0B983135E134E980779DFA0C3CB86@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d68bf6-5db2-4f81-8405-08d91621a7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 15:13:25.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aREmuWppqkS3gvH1JwM+qWikvQdcNugwxQ49LUQYQqhCMYowZDLWAHzjwbTBl72gs6+trIwgJVlr2emWcnNNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4688
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTEyIGF0IDE3OjE2ICswMzAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IE9u
IFdlZCwgTWF5IDEyLCAyMDIxIGF0IDA5OjQ5OjAxQU0gLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlh
IHdyb3RlOg0KPiA+IE9uIFdlZCwgTWF5IDEyLCAyMDIxIGF0IDk6NDAgQU0gT2xnYSBLb3JuaWV2
c2thaWEgPA0KPiA+IG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+
ID4gPiBPbiBXZWQsIE1heSAxMiwgMjAyMSBhdCA5OjM3IEFNIE9sZ2EgS29ybmlldnNrYWlhDQo+
ID4gPiA8b2xnYS5rb3JuaWV2c2thaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gT24gV2Vk
LCBNYXkgMTIsIDIwMjEgYXQgNjo0MiBBTSBEYW4gQWxvbmkgPGRhbkBrZXJuZWxpbS5jb20+DQo+
ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgQXByIDI3LCAyMDIxIGF0IDA4OjEyOjUz
QU0gLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhDQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
PiBPbiBUdWUsIEFwciAyNywgMjAyMSBhdCAxMjo0MiBBTSBEYW4gQWxvbmkgPA0KPiA+ID4gPiA+
ID4gZGFuQGtlcm5lbGltLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI2
LCAyMDIxIGF0IDAxOjE5OjQzUE0gLTA0MDAsIE9sZ2ENCj4gPiA+ID4gPiA+ID4gS29ybmlldnNr
YWlhIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xn
YUBuZXRhcHAuY29tPg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEFuIHJwYyBj
bGllbnQgdXNlcyBhIHRyYW5zcG9ydCBzd2l0Y2ggYW5kIG9uZSBvcmUgbW9yZQ0KPiA+ID4gPiA+
ID4gPiA+IHRyYW5zcG9ydHMNCj4gPiA+ID4gPiA+ID4gPiBhc3NvY2lhdGVkIHdpdGggdGhhdCBz
d2l0Y2guIFNpbmNlIHRyYW5zcG9ydHMgYXJlDQo+ID4gPiA+ID4gPiA+ID4gc2hhcmVkIGFtb25n
DQo+ID4gPiA+ID4gPiA+ID4gcnBjIGNsaWVudHMsIGNyZWF0ZSBhIHN5bWxpbmsgaW50byB0aGUg
eHBydF9zd2l0Y2gNCj4gPiA+ID4gPiA+ID4gPiBkaXJlY3RvcnkNCj4gPiA+ID4gPiA+ID4gPiBp
bnN0ZWFkIG9mIGR1cGxpY2F0aW5nIGVudHJpZXMgdW5kZXIgZWFjaCBycGMgY2xpZW50Lg0KPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmll
dnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+IC4uDQo+ID4gPiA+ID4gPiA+ID4gQEAgLTE4OCw2ICsyMDQsMTEgQEAgdm9pZA0KPiA+ID4g
PiA+ID4gPiA+IHJwY19zeXNmc19jbGllbnRfZGVzdHJveShzdHJ1Y3QNCj4gPiA+IHJwY19jbG50
ICpjbG50KQ0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqAgc3RydWN0IHJwY19zeXNmc19jbGll
bnQgKnJwY19jbGllbnQgPSBjbG50LQ0KPiA+ID4gPiA+ID4gPiA+ID5jbF9zeXNmczsNCj4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgIGlmIChycGNfY2xpZW50KSB7
DQo+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFyIG5hbWVbMjNd
Ow0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNucHJpbnRmKG5hbWUsIHNpemVvZihuYW1lKSwgInN3aXRjaC0lZCIsDQo+ID4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBycGNf
Y2xpZW50LT54cHJ0X3N3aXRjaC0NCj4gPiA+ID4gPiA+ID4gPiA+eHBzX2lkKTsNCj4gPiA+ID4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5c2ZzX3JlbW92ZV9saW5rKCZycGNf
Y2xpZW50LT5rb2JqZWN0LA0KPiA+ID4gPiA+ID4gPiA+IG5hbWUpOw0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gSGkgT2xnYSwNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IElm
IGEgY2xpZW50IGNhbiB1c2UgYSBzaW5nbGUgc3dpdGNoLCBzaG91bGRuJ3QgdGhlIG5hbWUNCj4g
PiA+ID4gPiA+ID4gb2YgdGhlDQo+ID4gPiBzeW1saW5rDQo+ID4gPiA+ID4gPiA+IGJlIGp1c3Qg
InN3aXRjaCI/IFRoaXMgaXMgdG8gYmUgY29uc2lzdGVudCB3aXRoIG90aGVyDQo+ID4gPiA+ID4g
PiA+IHN5bWxpbmtzIGluDQo+ID4gPiA+ID4gPiA+IGBzeXNmc2Agc3VjaCBhcyB0aGUgb25lcyBp
biBibG9jayBsYXllciwgZm9yIGV4YW1wbGUgaW4NCj4gPiA+ID4gPiA+ID4gbXkNCj4gPiA+ID4g
PiA+ID4gYC9zeXMvYmxvY2svc2RhYDoNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IMKg
wqDCoCBiZGkgLT4NCj4gPiA+ID4gPiA+ID4gLi4vLi4vLi4vLi4vLi4vLi4vLi4vLi4vLi4vLi4v
Li4vdmlydHVhbC9iZGkvODowDQo+ID4gPiA+ID4gPiA+IMKgwqDCoCBkZXZpY2UgLT4gLi4vLi4v
Li4vNTowOjA6MA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIHRoaW5rIHRoZSBjbGllbnQg
aXMgd3JpdHRlbiBzbyB0aGF0IGluIHRoZSBmdXR1cmUgaXQNCj4gPiA+ID4gPiA+IG1pZ2h0IGhh
dmUgbW9yZQ0KPiA+ID4gPiA+ID4gdGhhbiBvbmUgc3dpdGNoPw0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEkgd29uZGVyIHdoYXQgd291bGQgYmUgdGhlIHVzZSBmb3IgdGhhdCwgYXMgYSBzd2l0Y2gg
aXMNCj4gPiA+ID4gPiBhbHJlYWR5DQo+ID4gPiBjb2xsZWN0aW9uIG9mDQo+ID4gPiA+ID4geHBy
dHMuIFdoaWNoIHdvdWxkIGRldGVybWluZSB0aGUgc3dpdGNoIHRvIHVzZSBwZXIgYSBuZXcgdGFz
aw0KPiA+ID4gPiA+IElPPw0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhvdWdodCB0
aGUgc3dpdGNoIGlzIGEgY29sbGVjdGlvbiBvZiB4cHJ0cyBvZiB0aGUgc2FtZSB0eXBlLg0KPiA+
ID4gPiBBbmQgaWYNCj4gPiA+IHlvdSB3YW50ZWQgdG8gaGF2ZSBhbiBSRE1BIGNvbm5lY3Rpb24g
YW5kIGEgVENQIGNvbm5lY3Rpb24gdG8gdGhlDQo+ID4gPiBzYW1lDQo+ID4gPiBzZXJ2ZXIsIHRo
ZW4gaXQgd291bGQgYmUgc3RvcmVkIHVuZGVyIGRpZmZlcmVudCBzd2l0Y2hlcz8gRm9yDQo+ID4g
PiBpbnN0YW5jZSB3ZQ0KPiA+ID4gcm91bmQtcm9iaW4gdGhydSB0aGUgdHJhbnNwb3J0cyBidXQg
SSBkb24ndCBzZWUgd2h5IHdlIHdvdWxkIGJlDQo+ID4gPiBkb2luZyBzbw0KPiA+ID4gYmV0d2Vl
biBhIFRDUCBhbmQgYW4gUkRNQSB0cmFuc3BvcnQuIEJ1dCBJIHNlZSBob3cgYSBjbGllbnQgY2Fu
DQo+ID4gPiB0b3RhbGx5DQo+ID4gPiBzd2l0Y2ggZnJvbSBhbiBUQ1AgYmFzZWQgdHJhbnNwb3J0
IHRvIGFuIFJETUEgb25lIChvciBhIHNldCBvZg0KPiA+ID4gdHJhbnNwb3J0cw0KPiA+ID4gYW5k
IHJvdW5kLXJvYmluIGFtb25nIHRoYXQgc2V0KS4gQnV0IHBlcmhhcHMgSSdtIHdyb25nIGluIGhv
dyBJJ20NCj4gPiA+IHRoaW5raW5nDQo+ID4gPiBhYm91dCB4cHJ0X3N3aXRjaCBhbmQgbXVsdGlw
YXRoaW5nLg0KPiA+ID4gDQo+ID4gPiA8bG9va3MgbGlrZSBteSByZXBseSBib3VuY2VkIHNvIHRy
eWluZyB0byByZXNlbmQ+DQo+ID4gPiANCj4gPiANCj4gPiBBbmQgbW9yZSB0byBhbnN3ZXIgeW91
ciBxdWVzdGlvbiwgd2UgZG9uJ3QgaGF2ZSBhIG1ldGhvZCB0byBzd2l0Y2gNCj4gPiBiZXR3ZWVu
DQo+ID4gZGlmZmVyZW50IHhwcnQgc3dpdGNoZXMuIEJ1dCB3ZSBkb24ndCBoYXZlIGEgd2F5IHRv
IHNwZWNpZnkgaG93IHRvDQo+ID4gbW91bnQNCj4gPiB3aXRoIG11bHRpcGxlIHR5cGVzIG9mIHRy
YW5zcG9ydHMuIFBlcmhhcHMgc3lzZnMgY291bGQgYmUvd291bGQgYmUNCj4gPiBhIHdheSB0bw0K
PiA+IHN3aXRjaCBiZXR3ZWVuIHRoZSB0d28uIFBlcmhhcHMgZHVyaW5nIHNlc3Npb24gdHJ1bmtp
bmcgZGlzY292ZXJ5LA0KPiA+IHRoZQ0KPiA+IHNlcnZlciBjYW4gcmV0dXJuIGJhY2sgYSBsaXN0
IG9mIElQcyBhbmQgdHlwZXMgb2YgdHJhbnNwb3J0cy4gU2F5DQo+ID4gYWxsIElQcw0KPiA+IHdv
dWxkIGJlIGF2YWlsYWJsZSB2aWEgVENQIGFuZCBSRE1BLCB0aGVuIHRoZSBjbGllbnQgY2FuIGNy
ZWF0ZSBhDQo+ID4gc3dpdGNoDQo+ID4gd2l0aCBSRE1BIHRyYW5zcG9ydHMgYW5kIGFub3RoZXIg
d2l0aCBUQ1AgdHJhbnNwb3J0cywgdGhlbiBwZXJoYXBzDQo+ID4gdGhlcmUNCj4gPiB3aWxsIGJl
IGEgcG9saWN5IGVuZ2luZSB0aGF0IHdvdWxkIGRlY2lkZSB3aGljaCBvbmUgdG8gY2hvb3NlIHRv
DQo+ID4gdXNlIHRvDQo+ID4gYmVnaW4gd2l0aC4gQW5kIHRoZW4gd2l0aCBzeXNmcyBpbnRlcmZh
Y2Ugd291bGQgYmUgYSB3YXkgdG8gc3dpdGNoDQo+ID4gYmV0d2Vlbg0KPiA+IHRoZSB0d28gaWYg
dGhlcmUgYXJlIHByb2JsZW1zLg0KPiANCj4gWW91IHJhaXNlIGEgZ29vZCBwb2ludCwgYWxzbyBy
ZWxldmFudCB0byB0aGUgYWJpbGl0eSB0byBkeW5hbWljYWxseQ0KPiBhZGQNCj4gbmV3IHRyYW5z
cG9ydHMgb24gdGhlIGZseSB3aXRoIHRoZSBzeXNmcyBpbnRlcmZhY2UgLSB0aGVpciBwcm90b2Nv
bA0KPiB0eXBlDQo+IG1heSBiZSBkaWZmZXJlbnQuDQo+IA0KPiBSZXR1cm5pbmcgdG8gdGhlIHRv
cGljIG9mIG11bHRpcGxlIHN3aXRjaGVzIHBlciBjbGllbnQsIEkgcmVjYWxsIHRoYXQNCj4gYQ0K
PiBmZXcgdGltZXMgaXQgd2FzIGhpbnRlZCB0aGF0IHRoZXJlIGlzIGFuIGludGVudGlvbiB0byBo
YXZlIHRoZQ0KPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIG9mIHhwcnRzd2l0Y2ggYmUgbW9kaWZp
ZWQgdG8gYmUgbG9hZGFibGUgYW5kDQo+IHBsdWdnYWJsZSB3aXRoIGN1c3RvbSBhbGdvcml0aG1z
LsKgIEFuZCBpZiB3ZSBhcmUgZ29pbmcgaW4gdGhhdA0KPiBkaXJlY3Rpb24sIEknZCBleHBlY3Qg
dGhlIGFkdmFuY2VkIHRyYW5zcG9ydCBtYW5hZ2VtZW50IGFuZCByZXF1ZXN0DQo+IHJvdXRpbmcg
Y2FuIGJlIGJlbG93IHRoZSBSUEMgY2xpZW50IGxldmVsLCB3aGVyZSB3ZSBoYXZlIGV4YW1wbGUN
Cj4gdXNlczoNCj4gDQo+IDEpIE9wdGltaXphdGlvbnMgaW4gcmVxdWVzdCByb3V0aW5nIHRoYXQg
SSd2ZSBwcmV2aW91c2x5IHdyaXR0ZW4NCj4gYWJvdXQNCj4gKGJhc2VkIG9uIHJlcXVlc3QgZGF0
YSBtZW1vcnkpLg0KPiANCj4gMikgSWYgd2UgbGlmdCB0aGUgcmVzdHJpY3Rpb24gb2YgbXVsdGlw
bGUgcHJvdG9jb2wgdHlwZXMgb24gdGhlIHNhbWUNCj4geHBydHN3aXRjaCBvbiBvbmUgc3dpdGNo
LCB0aGVuIHdlIGNhbiBhbHNvIGFsbG93IGZvciB0aGUNCj4gaW1wbGVtZW50YXRpb24NCj4gJ1JE
TUEtYnktZGVmYXVsdCB3aXRoIFRDUCBmYWlsb3ZlciBvbiBzdGFuZGJ5JyBzaW1pbGFyIHRvIHdo
YXQgeW91DQo+IHN1Z2dlc3QsIGJ1dCB3aXRoIG9uZSBzd2l0Y2ggbWFpbnRhaW5pbmcgdHdvIGxp
c3RzIGJlaGluZCB0aGUgc2NlbmVzLg0KPiANCg0KSSdtIG5vdCB0aGF0IGludGVyZXN0ZWQgaW4g
c3VwcG9ydGluZyBtdWx0aXBsZSBzd2l0Y2hlcyBwZXIgY2xpZW50LCBvcg0KYW55IHNldHVwIHRo
YXQgaXMgYXN5bW1ldHJpYyB3LnIudC4gdHJhbnNwb3J0IGNoYXJhY3RlcmlzdGljcyBhdCB0aGlz
DQp0aW1lLg0KDQpBbnkgc3VjaCBzZXR1cCBpcyBnb2luZyB0byBuZWVkIGEgcG9saWN5IGVuZ2lu
ZSBpbiBvcmRlciB0byBkZWNpZGUNCndoaWNoIFJQQyBjYWxscyBjYW4gYmUgcGxhY2VkIG9uIHdo
aWNoIHNldCBvZiB0cmFuc3BvcnRzLiBUaGF0IGFnYWluDQp3aWxsIGVuZCB1cCBhZGRpbmcgYSBs
b3Qgb2YgY29tcGxleGl0eSBpbiB0aGUga2VybmVsIGl0c2VsZi4gSSd2ZSB5ZXQNCnRvIHNlZSBh
bnkgY29tcGVsbGluZyBqdXN0aWZpY2F0aW9uIGZvciBkb2luZyBzby4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
