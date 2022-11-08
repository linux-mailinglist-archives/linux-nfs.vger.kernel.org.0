Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E43621CA5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 20:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKHTDn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 14:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKHTDm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 14:03:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2103.outbound.protection.outlook.com [40.107.92.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CADDF4E
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 11:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7ipa1fmoHhV9LSJSlFQUH93+Gm9hktjgixME6jhQGQsG8QM6W5QDNMdsTAlvxdeiqMcI20dMFlT45OMV0NYr/YdiIqqGmeV3/tuOaW5LWfWi0gSiNTIlTAe3YrOfZj1UVs2ESrIC2sbcgbsPvWUFVv3Zsvmfe+w3cTm+b8k0fzwABRMbGyM0zhYyiRRhUPp73pIWKmj49+1TDsP2UqF2bAQpFDz3u3V8531Kup6JYedb+QQOnFt6BumpiS74cFzY11ZZj2VZmha3TZ0jFdLnF2/k5r54g7Ze3HWDyIdvlWdI4340Ek62dhVkWN8Nlpno/l8uNa1FOcvTITGFsqpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz0bF0sobcCYa0IPDIf5/Wud2qg15GPpzPQcfa1p/WE=;
 b=G8uxYr4FhDHreolefbKWQ81cF783EBQ2HKzDW9/uLZPn6ifLaIdkFZEwGMMyfHuqQhr4KlJb6IcGEkyNb79bWOIYAQ5Mcab92cMO0YsOrSeuIfq6xvhKuRW4M7p11tTlFdaR8co4KdgdAM+yVUwslGuTDrhnhB3u8Fr3Mi3T+Fdt47vcJf9jIby9b5Nk29PJjtHj95dxG28gyb7pHqN7MG4AVJfavwC6lBF6lF4mkV0NKKIMqQE0b8x/beCfhU87/EnPreyYuXOJDgUMu8wMzzh5PuawmAUdLlPc8JJ8Dz+3YLViJpuMu3wAyrINjcnu/10FzBO0AiXz4RUSKmpt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz0bF0sobcCYa0IPDIf5/Wud2qg15GPpzPQcfa1p/WE=;
 b=SiBvTEz1zkO79fiTzyXof/HEif3bqQUa4lcQL6G9S03jdKNY2bxwcTKhDeynz5VwvqTrHcnMt8nRj5GdxWlwXgWwmgqj1b//TtlfXsZZow/NdecW9Gu9N2yqgfjo4ggFJDDGEi3mTpy9ji3OJ/SZ75SXmDWe9mKWMW9c9INaChc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5519.namprd13.prod.outlook.com (2603:10b6:510:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 19:03:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 19:03:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     Jeffrey Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNCCVE1uG9XTE231alNVaBdka4zSOCAgAC6T4CAAR2kAIAARJSA
Date:   Tue, 8 Nov 2022 19:03:35 +0000
Message-ID: <91278D2D-CE1C-4378-BC17-3EEE7EEA2598@hammerspace.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
 <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
 <B6C6DFDF-3AEC-4BAD-8810-76A47824E282@oracle.com>
In-Reply-To: <B6C6DFDF-3AEC-4BAD-8810-76A47824E282@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5519:EE_
x-ms-office365-filtering-correlation-id: 93777bcd-f706-44e3-67b5-08dac1bbefea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Z9EWKl/3dQ3KAUKsdGgidYqnzNs1aqluFV7xv159YzH0LSbtTsC8brnHciVD61pe83vG4kD40Sdlp4HRxLT4BEvg8HnVwZ6+8IMZ9DaFKtyxPwl3TeNWC6YXdnCcCteAx8iV8EjANCCjbTtJc69eHS9eyEyICERbuF7epX2qByNJ8isQpRPL6yxcvJ+PSVFFFwTW5txuwfeVYt+LERyflQptDb17fCgzzgP//Da7MRq0c4q4FFgk6eYpZQk53khaCatGjSKKTbfPc1F7cRJ2fqooUORywMz43oSHqQyLvPhMMq0jGOaONpERIxiKCuhJte632/RzCA1LKxXrGBrPDSNPsLxhnNsI1BlcrAVe01KrNnpR6bAPz70JskIEh/ixCRm2mEpMXClOvsvqP4NAWSfAcl2r4bdUYxFWjhiBktDbrRnkmAf3UKLSa2a//4FX2xdj+Fx254Frpb0LAMKOXSQeQcrBndvsgvNM/46rmAHy1pcwCQgdG7LALyLRPVHzDCLR4/OTmSlzzSJiBOTpBXpZPP7wGYxWHreQV487m6Mits+yoec95Jy4Sr5m8deH8pFg00ZeTEkkrmXAv2xYhXRD+h2s5cOup/NuHkRJzZQlACyf9YRoiS44NkaJbqCmq0RBV0tgCFYDhTpM8X8KIKWyFyx9mPOerCdpc33zp6xeVBEgvM7hhGtxAu0Wkj/w8YfzDIqpNPVnYSyQ92XyrsmaLdPBvKA9s3GAMgxCSAr1B4Mnpted+xFNZxWrzylUv71RXOXDnYvSf03Os846M3g97RvYTLge1JcEGTHN0fEZbHHpxy4Nj7X3sBIve18F/IWDHARFDqgyOQmyNz/pA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(366004)(396003)(136003)(346002)(376002)(451199015)(2616005)(186003)(6506007)(53546011)(38070700005)(26005)(6512007)(38100700002)(36756003)(33656002)(66556008)(4326008)(122000001)(66446008)(8676002)(66946007)(76116006)(64756008)(66476007)(2906002)(5660300002)(86362001)(71200400001)(8936002)(4744005)(41300700001)(478600001)(54906003)(6486002)(6916009)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFh0RzczZlc1RWNuVWdOTmx3UkFsWWovL3BHVncrd21SU0JYdC9DMDBTOS9E?=
 =?utf-8?B?Y2o3b0hrRE5Bei9HMExFYzRveEQrWVpuYi94VTAxSi9RZmRtc2h1QkNKaEJu?=
 =?utf-8?B?TmpkOEpDNmJFTUFNeHRXMlNBcXE5ajh4bUhzcHRxU3phbTRVVHE1dHF4NVRz?=
 =?utf-8?B?SUN5RUFXYjUzbVp3UlZnRjhER1JSKytXMXhITnc3TVZHdkxsYUw3T0daeFhU?=
 =?utf-8?B?TGdBc3Q3Njg3aWF0ZjFnRjFqd1RqSHVPb3NRaTZOdjhIc01EclNtbXcrM2J5?=
 =?utf-8?B?d1NsT2VROTRFUDJENHhOZkFTQ1AxbGVSekVUZGVlcHVQRk4rY25uMlpFK3Jv?=
 =?utf-8?B?R0VCL3pWRXYxQUU1c0tLbDdpRDU4OHphRmpGa2RHZCs4bDJXOVVNcDg5dEpC?=
 =?utf-8?B?SFRFcElJdzU0Y01JT1hhbEoyZVJzUE1CS1QxWkJWQmYrNU5wRHZxaEVoNlJm?=
 =?utf-8?B?cXdkeGR3TjBTeXBMZE5uRmpGNEg5ZjZDeXJSK3pmaHNRS2owejNNSVNjdUtR?=
 =?utf-8?B?Y0pTRUVwNVNEbHRKcHozWUlWYXVBZFkxaHB0UTBBYTFOTUpINW0zVld1cEtO?=
 =?utf-8?B?bGJTSXB0eW9sZFVPWnpwQ1pDdDNzakFnaERhbHFXd1kyNDkxWDQ2d0RhTmtZ?=
 =?utf-8?B?T09UK2JnZTdoRTRmSEtlL0dBa0lKbU9yb2ZDaDZtZ2FpUFh1KzFyZFplRW0z?=
 =?utf-8?B?VG1KVWpZdThxcFg4VWJFZGZDQVcyV0d1YjhPZGQzcEpocVZycXFFMXc1TGRr?=
 =?utf-8?B?VTFRWnJ1ZTBXd0RVVWNKbXFKaVFpME9hU1BValU2aEVGQzZqZFFENzV2Unl1?=
 =?utf-8?B?cGhHcm8vMDJ6VGZESmJBek9QR2RXODBTbFI5bGdxZ0RxVkZHejB2NWM4aHR6?=
 =?utf-8?B?N0R4TGtYWldGTXM0cFJBNGU1VTYvVUxPb2JhZ3VkckxtV3pJYTYxM2k5cGpi?=
 =?utf-8?B?VEJOS3JCT3g4bVBGaElGZFNKM29vMGtjL2Y4eWJIWnowa0JZc0g2b0lOcUt5?=
 =?utf-8?B?VVFuN3F0RFZxRUN6aEVFdzJSWjNyOXE4cWhWcjh1ZHFrOVpaek5kemhsZHRm?=
 =?utf-8?B?eFZYQnNaMkJqWDNpLzRqUTZoVk1zd0dIbUF2eDh0NXJtdEtKb1c2aFUxeklU?=
 =?utf-8?B?c3FENStMN1VjZEF0V3dQMlN1alNid3VybU5WT2lQU2VmUENWcVBaVVBoLzk2?=
 =?utf-8?B?cWwwcWg2WTViaWZYYWJnS2lzMVV2aFh2eGo2dG9GVTg3bTByek4yZFJJYm51?=
 =?utf-8?B?ZExwbHdOZ3YzNkl0bWpvSENLazlXeWpkSTZ4M3ljQlYwdWoxRFU2TlhBZ1Bt?=
 =?utf-8?B?WXE5NGI5Yko2Y2NjclFPV256SXljcWpLWVErN3IrakJmKzk1K3ZTcXQzNUhT?=
 =?utf-8?B?UFJ6TWc2UExqNVQ4M1p6SzlJWmx1aFA4SDlHNURSRU1xanFUYStzTjJidHBU?=
 =?utf-8?B?QUU3TEQ3L2lmZHZJREFCV0xGZDRlc0tObkFPU25XNjJEUitPSnlkYkYzRnJY?=
 =?utf-8?B?ejhXUEljQTZTd1RsKzM3R1FqY2ozUTN4cnc1eldTWGdOcFVtT0F2NzlGaVJR?=
 =?utf-8?B?WkNlcWtUa3RWRHFBQU13QjN2MEtJTGNUdXpkU1QzdXV3UFF6ZjFNakR2STRm?=
 =?utf-8?B?TUF3S1JXSFVXbGNrbGFiRVE3amdiRlBCK0RUYzVFTXhRWHpqRjExbHllRlYv?=
 =?utf-8?B?eEJPd2Z1cjZnUlM3R2FlWnlzL3RVUEhVY0l5R25RbFRhNFgzNEhWL091dTNt?=
 =?utf-8?B?aVRrclRnSlVnWE52ZXc5TXdWNTlkcmhCcmVaR1pRd2hsZEMrVll4YjYzL2Rq?=
 =?utf-8?B?MFoxR3dRVnJnRU1MY0V4cjFhVDlwWWdKa0ViQmFKUnJ3dmRwMU9wbVVlWmlM?=
 =?utf-8?B?MjVUMU9tc1JNOUNGTytxOWJweUFzVnZ1WXEwWWJUMXMwSjN2d1g1enlHVDVS?=
 =?utf-8?B?SkV4b1N4andWRFBlWmJjOGVzM3psTG9Cclp2aWNVNmhLRkN3cjUrWUIxdTVC?=
 =?utf-8?B?QnYwd0ZERmpJaDJSNlc5UVo0TnVtbStWdUR0ZGt0b3c3dVVKdFdZM2E0S28w?=
 =?utf-8?B?VDVDSE42RjNGYkdkM1Q0RUdtanZLZ1AyQVFwbmwvTjBIeGwyblVXOFJPWVcz?=
 =?utf-8?B?bExuNFlrT2Z0S1hxcjhIeTFUY1dZWGYxOEpyNjQ2bWNlcFNBTGdWMkVvY2VD?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1384159010CCCF42B415B3AA15C1F41A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93777bcd-f706-44e3-67b5-08dac1bbefea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 19:03:35.3883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwkbjERt1979tw6f8uCcWBfSZH/HBH54aY12nqK2wFjiBwJuEk26f4ecoH6PuUjVgpKCvtB/VphlE/r0TyLzPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDgsIDIwMjIsIGF0IDA5OjU3LCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gU2luY2UgVHJvbmQgaGFzIHJlLWFzc2lnbmVk
IHRoZSBrZXJuZWwub3JnIGJ1ZyB0byBtZS4uLiBJJ2xsIGJsYXRoZXIgb24NCj4gYSBiaXQgbW9y
ZS4gKFllc3RlcmRheSdzIHBhdGNoIGlzIHN0aWxsIHF1ZXVlZCB1cCwgSSBjYW4gcmVwbGFjZSBp
dCBvcg0KPiBtb3ZlIGl0IGRlcGVuZGluZyBvbiB0aGUgb3V0Y29tZSBvZiB0aGlzIGRpc2N1c3Np
b24pLg0KDQoNClNvLCB0aGUgbWFpbiByZWFzb24gd2h5IEkgYXNzaWduZWQgdGhlIGtlcm5lbC5v
cmcgPGh0dHA6Ly9rZXJuZWwub3JnLz4gYnVnIHRvIHlvdSBpcyBiZWNhdXNlIHNvbWVvbmUgZGVj
aWRlZCB0byBhcHBlbmQgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBzdGFjayB0cmFjZSwgZm9yIHdo
YXQgYXBwZWFycyB0byBiZSBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IGJ1ZywgYW5kIHRoYXQgbG9v
a3MgbGlrZSBhIHB1cmUga25mc2QgaXNzdWUuIE1pZ2h0IGV2ZW4gYmUgYSByZWNlbnQgcmVncmVz
c2lvbuKApg0KDQpCb24gYXBww6l0aXQhIDotKQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQo=
