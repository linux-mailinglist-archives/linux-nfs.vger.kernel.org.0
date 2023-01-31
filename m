Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5F6838D8
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjAaVqZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 16:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaVqY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 16:46:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80F58652
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 13:46:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQwVKwTCAVU2Ua0crwAqHseW6JsixabO+aXmNp4GVAvS4Jrn4itLi+gQWVQ/8U+LYhubbWLMC5ybbbr4vN1Yef7oyjv4EmfREhMVSvbmp+Vd/ZyDOg7CFzsDMmdffbX802msVQZ7X+7DSUBenDGIr8yJpM01O+PYn0CVFbAtaos7UlVAXbxCTjd/XbiaIVusScju2+yS4Ox5WZ3esTqRJZNIm4gEuT9aTUQGaHYCzVciVe+EGfHE1t/NGs0mw7veqm3LZNfyCnUebxR7qu2QvGfX5Scy65KfjFRJKQAJXibvP/l9jX/4aHfr3gx0p32bRiKOwLq9pOKF3y4lcKvhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2fvRZE6y3yyNLFLTvVJJCpx2xHU/3wWC59W5Yh5/F4=;
 b=UCWiWO57fmLBkeFj+gMcXIeCg7rnlo057g/SHGte8cfEWcBw1acqgmn4wkfKF0WdiiUW+0jTyHIP27PatGrVF42es46/iL9A6EMMA8u8pwLiA0Idt64IsrGmZ+Amx8gst9KfNGCQ+764xOIaERaDic5boHQCVmRCntDjLKdh6C3naVTAb24BikaCmGFOE62JXZqJSPYuCLe4K6qM8S34L77LfjE18rOc497nq5WiHlmey3oAgOKaMoNIrGvQGb+brlrRA/SEQbgI35etKdDGC0g/yydImP/qSyjf0N01v8baB/XxRgu5ja90bjzMMRemx6tu/O5M3VKQo2595ZiaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2fvRZE6y3yyNLFLTvVJJCpx2xHU/3wWC59W5Yh5/F4=;
 b=tAviAkqf1Vw3M/IkIejHJpQqVoBDIRoOzqZaaRq6pk5hoPzXvGR2SiolB7BlImMv9VG9r8ivUgnkZEVlOGVxyo0yzA9cQwEQR5MQrl1V1rbZ/T3sAJir11yPVtEozoYbugPNT1ShYwWvvyd30nTRphSpkUm7AS66iltlCWQYDYFioRq0n1qdFw9YXSgvDCuFHDlyXAFNxdjoquRiU9svdJj8yqiyAlculeUFlWcM7ggVwCOvpi6yP7XPuPMfY7sYR45CBomWKjDU/pFewQ8x0e2zwJieYn4dIR2Qe1gMI1R2yzrdfpg/50nPnzLnC7uxJ7XQt0Xt1qftkbS5dJ0vZA==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by PH0PR09MB8604.namprd09.prod.outlook.com (2603:10b6:510:65::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 21:46:19 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 21:46:19 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Frank Filz <ffilzlnx@mindspring.com>,
        'Olga Kornievskaia' <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64t7qAgAAfS4CAABEKAIAAJNMAgAACp7A=
Date:   Tue, 31 Jan 2023 21:46:19 +0000
Message-ID: <SA1PR09MB7552EAF2316BA0C70C6D05E7A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyFro=naMgub9uAZ0wa20WhZwV2Rh6xv_meNice1EG+Dug@mail.gmail.com>
 <046e01d935a0$7b3a2d30$71ae8790$@mindspring.com>
 <CAN-5tyE+wKVtHWr+DF67DLN0pvO332dDajvBbeGyCFu1fyqdRQ@mail.gmail.com>
 <048001d935bb$6a264630$3e72d290$@mindspring.com>
In-Reply-To: <048001d935bb$6a264630$3e72d290$@mindspring.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|PH0PR09MB8604:EE_
x-ms-office365-filtering-correlation-id: c4f2f70e-bf6b-42d2-393d-08db03d49654
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4nTqRRnvCiEvOojDq2f/+vOhG9LhDFy/dVHyxAaW88Y9jVP2URIUVRUR7NdJPrw/0Wdz2AxrzZrvHBbkGkLT2QpTtznyws9rv9h++uFB2VUgJbPLZawIuTiLVsrTZUQ49IboELu+gVKrAsotHQieanho4hKXCB2tBXtZ5kXhw69Cu1MNgrYKYVOeeHvGASOWk7Qvdiql9krszfTg6zkCqnEXmLs8vhp8iV/PcbGIbQs5MZw3nmJFJSU9vP/HDiTTJhIt0ZJ2744jhNic64d5bJlQ45h2n2gygs5DQt3B3No5Z6CbGWIBcMiOvYg07qNC79ivRYAumh2p9HjjWVAE+XNPqCFlAcLoR0E3WprfDfDSfJRoI8zIY5aZq60t9IK5LYRRL3Hmt4aBm1LtFsvqOLEdD74pvBLNh0wUGNrAhRYSBiYwJwN+L/ofXlfyxTOAZzmIc3ajAKzGvLo0JcYIWB5Rz6wBsQscjMndSfQlL2KxI/uzgQsMDBb7jSx6jIx612nIbXzfmPM/sYLwRatqnrS3xF6LmiQa71WKQkvoQebYgFyzGbCz8yAEUUGOXFQVSZF9t8mg1odogHnpRHMxsfyPdCS93nw9r77WLez5Im7njloIdPuWj6f4OwhrGW5ghU8+hel+hy8kDM32jO33fyqUO5G6ZmBtinBaNxLFODiN0+0p8Lsx5JZ7LaT7dGR0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(38070700005)(86362001)(38100700002)(122000001)(55016003)(82960400001)(66556008)(64756008)(33656002)(66946007)(8936002)(5660300002)(52536014)(76116006)(4326008)(110136005)(66476007)(66446008)(8676002)(2906002)(4744005)(83380400001)(7696005)(508600001)(186003)(26005)(6506007)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGMrNEpiOU9pb09PMjd4Uy9PMGNSK1c5UEZ5MmVzaE9Jam5pSklTMW96dWFB?=
 =?utf-8?B?MTEzQkwxK2M1UzNOMlkrTDZCMEtUWVNiZi9FUmhLeFViZ2RCSU1oODZtajFI?=
 =?utf-8?B?Yi9jTys5cnh0TEFsT0lqTXg2MVk1Q3VwQmlXQWdEcE9QdUt2blFrRDUxdlZp?=
 =?utf-8?B?RitjUnVRUjVWMlkyWXVqVmR3TUNFdkdtaEtmRFlKYWpISWNpMlVuMGdLdUFt?=
 =?utf-8?B?UWgxVnQzNjZjVWFkRzM3akQvcVhXZU9tRTRPWlEzdjdmVnJYRGpzVGJydGVL?=
 =?utf-8?B?TG1reEJ6cFNFZEpyclNybVpWSThzQ3RlblRLZHozanh3a3hLTFo0QTdoUWNW?=
 =?utf-8?B?RXJkOUY1U1RPMGFlSGpOZ01jbkhRWlRpSHkvNG1EZWJFOURSSklUbC9HRG5Q?=
 =?utf-8?B?TGhDZUtiTytFcWZHT1NucTUrNXZ5S3UzT2l6eDhEVmJ1akY5dFpRRll1Q2pl?=
 =?utf-8?B?NmhhbGU4QmRwRzkrSnZVbHl0cnpQVmY1dWxDem5rZlhkeTE3RVYwcDBXcURT?=
 =?utf-8?B?UTU1SzBXc2w4b0pIcy9HTStJcE8zV1NZbTlEeFdaSGt4aGZkdFNtSVgvTXgr?=
 =?utf-8?B?OG1ZWkNJRm95VEZJdWpBcmZ4Z2VTdjVzTllWUTNXREdJUXl5N3dpb0FYWUQw?=
 =?utf-8?B?RTkraGdMbVFRR0MzcTQ3aFVEVUMyVndnOFJaQkdaTGZFbGRsNmJtL1lSaXNH?=
 =?utf-8?B?Uk5Pd1lYeVBwRWdCaWp1WmFkQWNKZUpzWUVicG1jeHJmNlllR01tWmhiS0lL?=
 =?utf-8?B?d2xLcCtkTDYvek5FWVplaExXMWhGdkhxaTFGQWxWYjJ6ZnVZNmk3Z29MaWZB?=
 =?utf-8?B?S3dCV29aak13ZGRzK2tDOVY5VkVnM1haWStNNit2T3BNbjFNZzlCenhJQUdm?=
 =?utf-8?B?VzdpUjJsWTlUVHNIazN2NzlIWU5tWEcwTitrbWtjNzJnYTFFN3hoMzUxODA1?=
 =?utf-8?B?S0VlYTMxTk9lOVZaaVFHODNON0ZHc2MzMkxpS3U0U1JTTmVlRmVYU0NRUzZw?=
 =?utf-8?B?UHJvZjBidE93SG5TTWhSY3piU2ppaUtubnFyR2pRWi96N1lLMkFlb081OWFW?=
 =?utf-8?B?Uk9mNkdIaGRlUXhRcGJ4bURNSGVBbG43dDV3cjd3STJ3WGdxTTBSQUVwVHQ5?=
 =?utf-8?B?dlJGam1FREZubkdCelNxNVlvVG5RMFpUWFRjZVkxWVNGNno0eHZ1MnJYdjQ1?=
 =?utf-8?B?QnNsU0tnVXJBb25nT2ZhV0lLNDVWSGgrWTExSXVJc1BQUXlpTUZPNE1JdGh0?=
 =?utf-8?B?YXcrRHhRanQrMnIrR3JCWXVzdElEMGpCNmpIdHhBRlN2TU1Kd2tyNDRJcFlO?=
 =?utf-8?B?S0EyUWhmYUplcDBOWVMzUy81ZFlMakNFdytFajJQZ0F5dzQxS3JsLyt3K2RO?=
 =?utf-8?B?d2p2MkVucDI2Rk9DcUdweGxudUVtdW0yOFNwckVPZGp0TEU3MzdLaVJVYnhZ?=
 =?utf-8?B?ekRWM0xiMytDSFdNRUVQTUQ0SFM3bjBGS0tFdU81SitkajFsM0t5S0FJTHFh?=
 =?utf-8?B?T3lpUE95T29HMXBtQ1gyNHY5OEFLWFhnMVR4NksyeVB6SkdCS0pacHdjOVky?=
 =?utf-8?B?aHJrMzE1TlN6WWlERnJYZWVMZ0pzUE52SjhDSFN2RitFZ0RuMTJIVUk2cjdo?=
 =?utf-8?B?VVBGT0J3VFBHOVlqbGpNMnoxVVV1Vmh6M1FVcGNIQ3hWYlc1NjJmRi9CckdJ?=
 =?utf-8?B?MGxvYkdEZWdKWVZ2SHJQbzRxcFFYVFpzMTJXODhMU3ZYRlMvMzFCQUVjQ3Bu?=
 =?utf-8?B?UCtGUW1aYjQ5WnkwODZoSFRIbC8zWHRvVHE5aXdGeXgyckNJTXhZS0hkYlRC?=
 =?utf-8?B?UDdHYTJreVBTckw0aXJvQ3JxSjdadXRBK090Ty9SdHIyNmpkazNPMDVUWloy?=
 =?utf-8?B?R2l0a3dSemRxNVp6NmpwSWNreVZoVEt0SjFoRUVWdVFzUnJqc0xXb3BOcWFL?=
 =?utf-8?B?cEg3Z2ViOXhDUGU0ck5DdFpZSU90dnI1S1ljUjJWTTNrVE9CTGE2MS9tL0lm?=
 =?utf-8?B?SVEyeFBUbDFVYWpSWWx6cHZLUUtSeFVZcEUwWG1HREZtNGRIRk5rTDB6Q2hj?=
 =?utf-8?B?czZmR2txQ2JxZm4xSjBtTDZlY281YkZYMlRDNUp2bW16RE1YYTAzZDh1SzNR?=
 =?utf-8?Q?tp4L9gzAdX5cIvUZU4rdYOOPR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f2f70e-bf6b-42d2-393d-08db03d49654
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:46:19.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR09MB8604
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCiANCj4gQW5kIHllYSwgaWYgdGhlIGNsaWVudCBpcyBhbGxvd2luZyBjcmVkZW50aWFscyB0
byBleHBpcmUgd2hpbGUgYSBmaWxlIGlzIHN0aWxsIG9wZW4sIHRoYXQncyBhIHByb2JsZW0uDQoN
ClNpbmNlIHVzZXJzIGFjcXVpcmluZyBjcmVkZW50aWFscywgIHRoZSBjcmVkZW50aWFscyBnZXR0
aW5nIHB1dCBpbnRvIHRoZSBrZXJuZWwgY29udGV4dCwgIGFuZCB0aGUNCnVzZXIgb3BlbmluZyBm
aWxlcyBhcmUgYWxsIGFzeW5jaHJvbm91cyBhY3Rpdml0aWVzLCBJdHMgbGlrZWx5IHRoYXQgc29t
ZSBvZiB0aGUgdGltZSB0aGUgaXNzdWUNCndpbGwgbm90IGJlIGR1ZSB0byBiYWQgdXNlciBiZWhh
dmlvciAoIGxlYXZpbmcgZmlsZXMgb3BlbiBmb3Igd2lkZSBwZXJpb2RzIG9mIHRpbWUgKSwgaXQg
d2lsbA0Kc29tZXRpbWVzIGJlIHNpbXBseSBhIGZpbGUgYmVpbmcgb3BlbmVkIHRvbyBjbG9zZSB0
byBjcmVkZW50aWFscyBnb2luZyBhd2F5DQoNCg0KPiANCj4gRnJhbmsNCg0K
