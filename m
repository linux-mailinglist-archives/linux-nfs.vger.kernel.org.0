Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45144571EFF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGLPZC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiGLPYs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 11:24:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2093.outbound.protection.outlook.com [40.107.102.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891830F4E
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 08:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO3to1XpQ7UuZKiymYQ7CexMC5KwMNRY/m7kKSV2z86HjmmofL1ejc/nda8r3KssPcGoWegdqN6uhCTx9ztKsSQHz+ng1cMBSUKWPB9eEY8KOGagtOvvU5yTd2B3DaJ9v7RxUHJhE5McQQEGPzhc9CxVCkFltnvyCogc6ikt5x11nEMUOgY9XfmcMvPt3k+2M6fITUvEOzONA6jN69ihCvV7esF5/CQ3tjHoDu9De1UjbHaB1j4CWfLeiDchgJ960tz8sot7vUjVZwlX1FZ6oatEpAi2c/AhxEvWfCMe/dNNxvVsHOeDM3BvZuZplbZkvHcQ/A1yEPbqtF870zbbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZOoCxzxjNzqexXtsHNZ6pAzuh5LPtGwPmAOI+JhYbw=;
 b=OA+Ld2v9ZFfdic2g86LhGyc4eSotpaTpEe3agaOcu8lKPvhWPrqSjatwNKooZ0/4BXnr45WrtzV5xSKExndAiU5EMQ2VRYEeKWGRUBjM1KpCW/lc6SI49gFxnoCFp+HCOEDiYvSmIUM4xDjmCy8g2t+hF7ffeWMULdKbm5GkjdOFDbUuhWLUP/07fyQT3GYhFGMRYXt6L/wYa6SQYgVRIIUqVrixFXvsIdjvlfj87bpLfBdz9J+E2mVU7b+tExxFgDOJSl3sSy/86dv3xhaAJp7DfUYPiABzprgfcmD/lM7bMbCoHkMDgbTMzSbcwyROHwAPT11b0cbDzkQeEqkbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZOoCxzxjNzqexXtsHNZ6pAzuh5LPtGwPmAOI+JhYbw=;
 b=RLTdiiz+BFEzWEe0iqZHKSxpBNCYXStqW/53BsQhUy1Kvs0T4FVKncTEzntCOblQHvGwvlitHNXb3e2Oxwql3EtIxCd3u0Azh6P2ZSXXOWMzpsdj+kR2vvimARXQ2qn+mf/Mhbjgs/zIXpuHuOlAPSsFR4Hqeko7kBEhfKyZnkc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB1411.namprd13.prod.outlook.com (2603:10b6:404:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Tue, 12 Jul
 2022 15:24:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%7]) with mapi id 15.20.5438.011; Tue, 12 Jul 2022
 15:24:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 02/12] SUNRPC add function to offline remove trunkable
 transports
Thread-Topic: [PATCH v1 02/12] SUNRPC add function to offline remove trunkable
 transports
Thread-Index: AQHYhLnaeUXxZXrq8kipuxZbvueowa16/W6A
Date:   Tue, 12 Jul 2022 15:24:14 +0000
Message-ID: <ad8fdf73ef81e405b7fb0e07bff6ac41d562658e.camel@hammerspace.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
         <20220620152407.63127-3-olga.kornievskaia@gmail.com>
In-Reply-To: <20220620152407.63127-3-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 353a7b7d-c929-490f-5bd5-08da641a9427
x-ms-traffictypediagnostic: BN6PR13MB1411:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yc5hqRYBe6CKWt561bnikZDDP0M36Y9a+EMjZV8RpHmBqZt8IPLyHnrH+ZWyOfPyWd9eefs/32vTUxwxfAGWmbva42Y54BZ94KR6mZ3+/yzeF0Ofz5quU6qyz5OHyaS2oUEK8U8U2hnarTd9iM7aJtnhJDlhFvZnGbAe78KsRfOoiTxgyHOG42HtWbgsr12zuc83/gUG/wLYYoxeqg1+vP02ufuOer4HYIyh7VxrTltLlsqUq+mIbk0ywDzspf3uudQ6mwaeuy38oYm/da/Pyst6liAuzQx+2hFT1b+N+miUiOQw1ygx/jDcDRm3ZnTCEcci5Zm/+/EiPjPpu9VCL6ne2yecd8hiA6sEYXXdMnRfYPTpMntaHMnuKvqS2DvaWLgkkywaaTTq6GkanCDG60mKSFJXM7IWaT0VU9RbNsOSfgoKj8AywJuB2o0TsTBrnMLzNXbcYyxEWzB4Gtmx2LMtWkn6DrEhVqSoNh+/ZVIf+HHD/YTVSQxbp294zNJrhopCm0LEC1UI1atjAWUGHX9DAQFQiMImD+QhIsZODKofXRXPbu0IXGx3ShaklN3/X4+2Bc/teoAqGJe8t39E0KZK/cjmoo5okY2HxunS5gAxUToz0vr7FebkVD8R7rq9wOvyTFcLAR5NHAsywyZ0V6k1JNCQYcY/dD8XSm6WLvfAbmhNr1aZQtBAQlw/NX/0s1bSMIV2T9wUMIKkDXYq5GfUIMG73kLVDQ61xtAZD5YZkb2FYbQusg5oUSPg8QU9ZJ+haopuxxVF6n/rl7Uhc/L8DNq2rXqNK/IR4pv1//qJYIwHGDEpUlwsZbgnBK2o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39840400004)(316002)(38100700002)(8936002)(186003)(83380400001)(66946007)(38070700005)(86362001)(76116006)(4326008)(6486002)(71200400001)(66476007)(8676002)(110136005)(64756008)(66556008)(36756003)(5660300002)(2906002)(2616005)(66446008)(122000001)(6512007)(26005)(478600001)(6506007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0hCVmJ3eGNHOHMya0ozR3FGWWRMRDVSUjhnNnhVUjNBR2NJTUNsa0VUNGxM?=
 =?utf-8?B?VHJVcjhIZ2dWTTlzdDRLNHBTbXJ3RGFKRlkwaktralVuNytFazFydmY2NzB5?=
 =?utf-8?B?LzVaU3hYTXdsUlR5eDhyd2hpWlZFbnZEOGRlM21KZEZnZ0ZKUzlHODIrV0dz?=
 =?utf-8?B?c2luV0E0NWdYSVRhVTA1QTJvTG42eW9CcmdaN0drNDVXbkJsdFlOc2RpQUlX?=
 =?utf-8?B?UVFoZ1JBUTd3QXBvN2hrQ0RrZFR5QnVkYmJnYUpockRxc205Q2J1cU82QjVn?=
 =?utf-8?B?emlueFE0Y2FJMFA3WmI5SVI1Rlk3Mi8xQ21IdndGNUphaU8vUEpSQjFRQVcw?=
 =?utf-8?B?RXFEYUxlWTNSQ2pUdG5sVFNNeUNsZUVSTzIvQk0zSWF1RVdtYkJFOGdqRFd0?=
 =?utf-8?B?NUZWVlozZTlmdFFnOWI2R0I1dmUweEhmcXdjVU1LTjlqSkxmUCtvd2VYTmw2?=
 =?utf-8?B?WTV5bWVxRlg2elcxckl3eVMwZkhEc1JESERZY0loTlQwdFYrZm90bDJkbFkr?=
 =?utf-8?B?KzY1LzVTd2Q4V0RSRDJ1b0x2SVNZSEo3cExBWVl2WVp5TEFYcmR4UmdPMXpI?=
 =?utf-8?B?ZmJ0R3dEb0xPVVYrdFBNOFd0dkxCVTQ4eFg5SzUxYkd3djlBTXJiMWVhVU5P?=
 =?utf-8?B?Qzl4d0pVS0hJVEdGSjE4TjkxRHJvZTN6RERCVnNkS3k0TzR0R3MxYWE0SmFw?=
 =?utf-8?B?blJqS3RuOGlLcUJXWXRoVGE3OExzRkx4V3g2a0Riem9oRkkveitRTFlxN3Fv?=
 =?utf-8?B?cVR2ZktZVXJKMGg1K3ErSFlGcVVwTC9GLys5bUtPWDkvbGlGeVZoRVE5YVda?=
 =?utf-8?B?NkpGZGV3bkw2UDZEZGxnbk53dzVjbTJZdERRcEFhRGNhSHBIWjJWSHM4MjdV?=
 =?utf-8?B?N3FoU1pBaDFIQ1E2bmYrY3dIb2RMVC9QTlNJRVlZd0U4VnNPaGErNEJrZkFi?=
 =?utf-8?B?aXRQdFcyQ3lrMXFINjFjSUlEUUhQSlc1cEswaDZCeHkzNjBRclZrTTRMdlNw?=
 =?utf-8?B?TWRLdW5lMWdRNWY0R01ZaW14SU00Zlk1QmR5VkJWWFJlN1pobkoycHlEMUlq?=
 =?utf-8?B?dVRSbk5zaGdnSEU3Skd2YnBmd01veXd5UzNKVlpDaTEvMHc5dGVVaHF3TllB?=
 =?utf-8?B?QnlFS1dONG5WY2NjMTdMRlF2MWhROGo0Q3BBczBKc3htYWp0QXZUS2Z3Uk1G?=
 =?utf-8?B?MlJEMFN5WGxoK2NlZkhHSkgvYUtPK0xiaHFkS1RmNW0yZEpmamo1ZDh3MGV2?=
 =?utf-8?B?R3dtZ2lNRTladWMwTFlmbXlwczBZQjRxVVB3YXB4TkdWZ2tUa0lMVnY1SWRU?=
 =?utf-8?B?SkQwU2RiMk1SemV6dnlvZWo3T3lic2ZBdnBkbWhmQXVieG1ndmc5ZGEweEhs?=
 =?utf-8?B?MkQrbjZrTnc4MmVmVlFSTWpDbFBacURnRzZXZ0YzZEUweXFHQ1R0eUZnS3d1?=
 =?utf-8?B?K2dINUhjNENuTlZFdzZMM29IZG9lR0lMUFk2WHdHVUFGL08wZmZVTDVMd3Er?=
 =?utf-8?B?dDVZZzU1QVhPTXhLOGNuRVRmL3VNRlExL3lFVmhoYjFjSmNyZXlJaE9pTWtC?=
 =?utf-8?B?aGx4Q2lmVkVsV043a1BZcWlNbDBHMENPaTQ1cHIwaUVoYk1qVEZuLzBiS09S?=
 =?utf-8?B?SnNtSFJiS0xOMHArOU93ZERYakJDcGR0eGhSSHR4eEVWYlVvbkhKQmxmd0lv?=
 =?utf-8?B?L1FJMnBGVVFMODE0WkxOR1VkV1VNdmltdEY0L2dJcTZ4NU5YWjlQOHlpTVJa?=
 =?utf-8?B?L3FhQ2xtVkhQUDZ4U2hwUkRpRjFOUjlDaGVXU3RGVk95di9CWDVteUpFOFM4?=
 =?utf-8?B?aE9aZ3hYNHA1WEFNSWZIYWNYM0IrSkVrNEtzMDhGQkc3TDJ1ZEZBVTg1Slo5?=
 =?utf-8?B?YzFzaWNid1ZCOFRnU0pPWmlWZ2VsTUpvVWFTUTI2MVBwbmhLbmJxT1RKdlJN?=
 =?utf-8?B?ejBhb0wxRWwvRnZacVMyOU14cVJoNmlqVmswQk9ueXBxSEdRQUVkaVRsa3ZF?=
 =?utf-8?B?SnArQmpVQmh5THd6aGwySGR0L25BeXRLR2NqdW5CYkRwd0VNQ3dYYmdmaWpa?=
 =?utf-8?B?T2ttSUtPbHR5WnVuRWZCS3p3V0dTRUpMRVVNRVBKZ1dKTTBrV2p0WEVZYUha?=
 =?utf-8?B?WGR3Ty9nYjJsQU1seVJuTGhoa040YUNsbk01eUZHRDNWU0NYcTdPL1FpOS9W?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A00F5D45ADC2AD45924A803619A490D8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353a7b7d-c929-490f-5bd5-08da641a9427
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 15:24:14.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cqj5S7oKIfVbBDew7EAZ/oZAoBVNeMzAtoXDkowHHaUXwiSetlNqd5zpsHYi1KcNSwqGxN8W2IhSY16JbUFCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA2LTIwIGF0IDExOjIzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToKPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4KPiAKPiBJdGVy
YXRlIHRocnUgYXZhaWxhYmxlIHRyYW5zcG9ydHMgaW4gdGhlIHhwcnRfc3dpdGNoIGZvciBhbGwK
PiB0cnVua2FibGUgdHJhbnNwb3J0cyBvZmZsaW5lIGFuZCBwb3NzaWJseSByZW1vdGUgdGhlbSBh
cyB3ZWxsLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRh
cHAuY29tPgo+IC0tLQo+IMKgaW5jbHVkZS9saW51eC9zdW5ycGMvY2xudC5oIHzCoCAxICsKPiDC
oG5ldC9zdW5ycGMvY2xudC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0Mgo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoDIgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N1bnJwYy9jbG50LmgKPiBi
L2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaAo+IGluZGV4IDkwNTAxNDA0ZmE0OS4uZTc0YTA3
NDA2MDNiIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaAo+ICsrKyBi
L2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaAo+IEBAIC0yMzQsNiArMjM0LDcgQEAKPiBpbnTC
oMKgwqDCoMKgwqDCoMKgwqBycGNfY2xudF9zZXR1cF90ZXN0X2FuZF9hZGRfeHBydChzdHJ1Y3Qg
cnBjX2NsbnQgKiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgcnBjX3hwcnRfc3dpdGNoICosCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJwY194cHJ0ICosCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdm9pZCAqKTsKPiArdm9pZMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBycGNfY2xudF9tYW5hZ2VfdHJ1bmtlZF94cHJ0cyhzdHJ1Y3QgcnBj
X2NsbnQgKiwgdm9pZAo+ICopOwo+IMKgCj4gwqBjb25zdCBjaGFyICpycGNfcHJvY19uYW1lKGNv
bnN0IHN0cnVjdCBycGNfdGFzayAqdGFzayk7Cj4gwqAKPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJw
Yy9jbG50LmMgYi9uZXQvc3VucnBjL2NsbnQuYwo+IGluZGV4IGUyYzZlY2EwMjcxYi4uNTQ0YjU1
YTNhYTIwIDEwMDY0NAo+IC0tLSBhL25ldC9zdW5ycGMvY2xudC5jCj4gKysrIGIvbmV0L3N1bnJw
Yy9jbG50LmMKPiBAQCAtMjk5OSw2ICsyOTk5LDQ4IEBAIGludCBycGNfY2xudF9hZGRfeHBydChz
dHJ1Y3QgcnBjX2NsbnQgKmNsbnQsCj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MX0dQTChycGNfY2xu
dF9hZGRfeHBydCk7Cj4gwqAKPiArc3RhdGljIGludCBycGNfeHBydF9vZmZsaW5lX2Rlc3Ryb3ko
c3RydWN0IHJwY19jbG50ICpjbG50LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcnBjX3hwcnQgKnhw
cnQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKmRhdGEpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgcnBjX3hwcnQgKm1haW5feHBydDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcnBjX3hwcnRf
c3dpdGNoICp4cHM7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGVyciA9IDA7Cj4gK8KgwqDCoMKgwqDC
oMKgaW50ICpvZmZsaW5lX2Rlc3Ryb3kgPSAoaW50ICopZGF0YTsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgeHBydF9nZXQoeHBydCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJjdV9yZWFkX2xvY2soKTsK
PiArwqDCoMKgwqDCoMKgwqBtYWluX3hwcnQgPSB4cHJ0X2dldChyY3VfZGVyZWZlcmVuY2UoY2xu
dC0+Y2xfeHBydCkpOwo+ICvCoMKgwqDCoMKgwqDCoHhwcyA9IHhwcnRfc3dpdGNoX2dldChyY3Vf
ZGVyZWZlcmVuY2UoY2xudC0KPiA+Y2xfeHBpLnhwaV94cHN3aXRjaCkpOwo+ICvCoMKgwqDCoMKg
wqDCoGVyciA9IHJwY19jbXBfYWRkcl9wb3J0KChzdHJ1Y3Qgc29ja2FkZHIgKikmeHBydC0+YWRk
ciwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAoc3RydWN0IHNvY2thZGRyICopJm1haW5feHBydC0+YWRkcik7Cj4gK8KgwqDC
oMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gK8KgwqDCoMKgwqDCoMKgeHBydF9wdXQobWFp
bl94cHJ0KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIG91dDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHdhaXRfb25fYml0
X2xvY2soJnhwcnQtPnN0YXRlLCBYUFJUX0xPQ0tFRCwKPiBUQVNLX0tJTExBQkxFKSkgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAtRUlOVFI7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+ICvCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKg
wqDCoMKgwqB4cHJ0X3NldF9vZmZsaW5lX2xvY2tlZCh4cHJ0LCB4cHMpOwo+ICvCoMKgwqDCoMKg
wqDCoGlmICgqb2ZmbGluZV9kZXN0cm95KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB4cHJ0X2RlbGV0ZV9sb2NrZWQoeHBydCwgeHBzKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgeHBy
dF9yZWxlYXNlX3dyaXRlKHhwcnQsIE5VTEwpOwo+ICtvdXQ6Cj4gK8KgwqDCoMKgwqDCoMKgeHBy
dF9wdXQoeHBydCk7Cj4gK8KgwqDCoMKgwqDCoMKgeHBydF9zd2l0Y2hfcHV0KHhwcyk7Cj4gK8Kg
wqDCoMKgwqDCoMKgcmV0dXJuIGVycjsKPiArfQo+ICsKPiArdm9pZCBycGNfY2xudF9tYW5hZ2Vf
dHJ1bmtlZF94cHJ0cyhzdHJ1Y3QgcnBjX2NsbnQgKmNsbnQsIHZvaWQKPiAqZGF0YSkKPiArewo+
ICvCoMKgwqDCoMKgwqDCoHJwY19jbG50X2l0ZXJhdGVfZm9yX2VhY2hfeHBydChjbG50LAo+IHJw
Y194cHJ0X29mZmxpbmVfZGVzdHJveSwgZGF0YSk7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwo
cnBjX2NsbnRfbWFuYWdlX3RydW5rZWRfeHBydHMpOwoKV2h5IGlzIHRoaXMgZnVuY3Rpb24gdGFr
aW5nIGEgJ3ZvaWQgKicgYXJndW1lbnQgd2hlbgpycGNfeHBydF9vZmZsaW5lX2Rlc3Ryb3koKSB3
b24ndCBhY2NlcHQgYW55dGhpbmcgb3RoZXIgdGhhbiBhbiAnaW50IConLgpJdCB3b3VsZCBiZSBt
dWNoIGNsZWFuZXIgdG8gaGF2ZSAyIHNlcGFyYXRlIGZ1bmN0aW9ucywgbmVpdGhlciBvciB3aGlj
aApuZWVkIG1vcmUgdGhhbiBvbmUgYXJndW1lbnQuIFRoZW4geW91IGNhbiBoaWRlIHRoZSBwb2lu
dGVyIHRvIHRoZSAnaW50JwppbiBlYWNoIGZ1bmN0aW9uIGFuZCBhdm9pZCBleHBvc2luZyBpdCBh
cyBwYXJ0IG9mIHRoZSBBUEkuCgpJbiBhZGRpdGlvbiwgYSBmdW5jdGlvbiBsaWtlIHRoaXMgdGhh
dCBpcyBpbnRlbmRlZCBmb3IgdXNlIGJ5IGEKZGlmZmVyZW50IGxheWVyIG5lZWRzIGEgcHJvcGVy
IGtlcm5lbGRvYyBjb21tZW50IHNvIHRoYXQgd2Uga25vdyB3aGF0CnRoZSBBUEkgaXMgZm9yLCBh
bmQgd2hhdCBpdCBkb2VzLgoKPiArCj4gwqBzdHJ1Y3QgY29ubmVjdF90aW1lb3V0X2RhdGEgewo+
IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGNvbm5lY3RfdGltZW91dDsKPiDCoMKgwqDC
oMKgwqDCoMKgdW5zaWduZWQgbG9uZyByZWNvbm5lY3RfdGltZW91dDsKCi0tIApUcm9uZCBNeWts
ZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
