Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B545FFE6
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Nov 2021 16:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355348AbhK0PhT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Nov 2021 10:37:19 -0500
Received: from mail-bn8nam11on2125.outbound.protection.outlook.com ([40.107.236.125]:41344
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350380AbhK0PfT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 27 Nov 2021 10:35:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epvLYd30JuwhKKAYAvGswaaIVjOnHcQymfyGnfvjABey7zCIt9TFkPzXYoiotWFrNSX3FJxrzOGDJFp9wCYPs0kCsu5yXseHred93kNcdS1ObJB9FarM5Rxe7x9ajKmk5pPNc1VVBycG3uDK1TLA1MlCwwAoQPTdbnUos2cnBEBHARhjGSy3nWTQMzAsPORAMX3G2PxMx7Te+KJjw3k8izI3X4hurKKc5v/Oogt7wz4VDD/0ybWkcIotcmq64YqMH4yAxG358OtIIo28pDG6k9vILGAfs3EGGQMd5iNREdbYrMz6lcNhLl61YH+l4z9YDevr9w7v/gZmAqm6ZhI+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSd+cDRtihg3WTIeTjRHFxRRNl1yAfpG+xfoofEGnQU=;
 b=fTTBbUqEwOl60U0Qz6gLQF1xOxnG9mn6n3T0CljGkZQyUNIEwRBM/fQ5HZ+DsnKYaGeNIuldicvJ00SB6g4iQdwgD/7A5U/F8kzBJuA0AtWGp7GOcZjp3HPqxXSpaeVXY8QSHk0q48Nq5vCC/GcOYwR6c0HE9feRua54tJ3c+00r/gCOD/NXU1B0SYV2n/O+9Na0Zf28I1N6qWRb1kmWB31HU6ABX7O7E303u51FgFdexemwATj9MLBMJa/VI9CTAfxJDcbKvzKdwNQh0gXuaTiB8U725tEBFpOmkgb+yjiw3kGsku6zlu4gHDCXCU8lIE461fV7VyrsNJeXZJORrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSd+cDRtihg3WTIeTjRHFxRRNl1yAfpG+xfoofEGnQU=;
 b=Bu7O1V3hJuQpOfI6qAwdJH8H13n+jTVJ3A8L7WPQGl8AKBW2AV2uj9VU/T8ONDK7jPOnTJ5QoqE4tQYUNOnZ4bDzh6PzPUxuzgzBBA18VrxXJn/BkDFXL0IXDTufZyDiVJm5L/rF7FAg66A7mYXzxfYCVYNt1QqADhkVZF97MLY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3608.namprd13.prod.outlook.com (2603:10b6:610:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7; Sat, 27 Nov
 2021 15:32:01 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4755.008; Sat, 27 Nov 2021
 15:32:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client fixes for 5.16
Thread-Topic: [GIT PULL] Please pull NFS client fixes for 5.16
Thread-Index: AQHX46Psabp0oVl0N0ONw48k31ZNhA==
Date:   Sat, 27 Nov 2021 15:32:01 +0000
Message-ID: <8b451da7c237eae6e008f00cfc3b8aad6f5d8b67.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c9c09e4-3dac-4cce-1214-08d9b1bb0f05
x-ms-traffictypediagnostic: CH2PR13MB3608:
x-microsoft-antispam-prvs: <CH2PR13MB360854F0089C4C000E00D588B8649@CH2PR13MB3608.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6I33SxMeo218w8tICEEMw32+oniG/05D+57tsUB62f9tr5vhJ50c0HYcWOAMF1QypsUPFLE4AeYoqKEehL3pPgsRNpAcJiHyRdxn/3JnYIlLdmh+/X6/9wWDr9MRmm07VycRhB3WX1eIVqT4cwnrL2kWqkETXF4zCTiYbxbuB5/Ed9Ezkk0C77sbmA33lWtnbadBAi9w8fi6ZmilCiwzUKXGmKhCGGt4itqF7SpFpu7EzbysDjSZNa2pm0614iUez+ahipK9Wf7cF1adLrzXOS3h62q+IvMt1sXc6TqiJfu9DQ4l3Zpwc4prVwm9+qmJWxRKWmgCwuHw1SHspuJscueTGIoxA3PoimJZszlgTwsO7OKIeReCQ3s7zWLKQPPkWjWRZuL2q5rvBmQvzep3nh9eXjj30zu+84Q9qIHvtAqdsE6Fgg0FA5u+4t6RUOrk7q0LKuigl/ci6WSOJtx+9QRVR3hjVkd0djAEan8ZbLszonUIewUPKq84K8baFbF5NHpHogCaU1ZVf4qFjYIha95cydPbAwTUK/ES1mWe/ySnPa7qQm5rG5nPwCNkzk3nhmb582D/oV3EuIlZelj6SGadC0jeAOU+eOdmy9AMPV2F09+8slfCDBidh1mrOcv7Kfu0UcuG17EaI65dNl13u0aPwdJ+76wYdKH41fWCQ9VVPlJfE5eBhqbFuLWHuVKs3fBDXmIMvJNnwwZVzwVH2yiI5TBvrAqONrqI4fZMTmzRZRS4alOuBiaL7MI/xH6y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39830400003)(346002)(136003)(6916009)(36756003)(8936002)(6506007)(4001150100001)(5660300002)(8676002)(2616005)(86362001)(6486002)(38070700005)(54906003)(66946007)(2906002)(316002)(66556008)(66476007)(122000001)(66446008)(64756008)(6512007)(508600001)(71200400001)(186003)(26005)(76116006)(4326008)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVk3cTEvWnJCa0RocGNTbTlUVUN3VGJZUVNFUmRJSis1YlJJZlhUaFU4SmpR?=
 =?utf-8?B?ckVSQzg5Y3o5V1JacXlqNFJXaHd6S1R1UjYwRGJHZFllUHFVK3ZLazhVbDdM?=
 =?utf-8?B?d2dtWlBsUlpwY2JNdndjTGV2MzdiUDcvV2ZzTkZPcGtrSTR3dFQzbVU2bHJQ?=
 =?utf-8?B?Q1ZDTWpsdjl4RVp5UzV0ZnNITmtZUTZ6TmR1bE5iQUlXeHIxVm5lbmpmaHNU?=
 =?utf-8?B?S2NRWnhIbWhrK091Tk9WSWxSZjZlMXUwb0dkYkpDVVhuUjFqMWIwaDJBSStZ?=
 =?utf-8?B?UzhBU3lQZWtEaE9SQlZ5bWNEa1FvVnpJL2ZoZGI4aXhtRG11aUxnS2RubUZX?=
 =?utf-8?B?dWpYM1ZpcjFiQ29kdkVodTV4R00veTNKWk1JQjY1RysvZVNmZndkaWd5MnJJ?=
 =?utf-8?B?NklKL09CZkxtNHVEUlFPWDZsRW1adS9kN0REQUNuK0M5YnNLQWtKeWg3S1NW?=
 =?utf-8?B?YW1MUUcwdVU3b2x4OG9YTGZiWldJUnIyZG0raFNJV1o4WEs2RTMrVWFrWDN3?=
 =?utf-8?B?SmxCVE9RMUROTmVoT1o2Qm5DS3ZoRDRnaFJMeWN3akZERmg0MDA3RzFqSldo?=
 =?utf-8?B?d3ZRbGNpSEpXYUhEM2NJK1BWU2xTVWxqN0VkSDZNa2VMVGFPWitwNVZVeGVT?=
 =?utf-8?B?bUgyajMxaG9uZXVmelZRNTIxblFjNkRmT2dycGJReWd5cER4U2RuVENFL2xM?=
 =?utf-8?B?K0EwaWxsVlRtbkxZWFNtZ3VRU2JkTW9WUlJFb05EbTFSZ0FBSlF6ZW5IWjhm?=
 =?utf-8?B?dEI3YTEramlXTWlUSE1LRHVkSmE1QXpCVGdtM2JzaW11TFVPTmNoUVM4Ylls?=
 =?utf-8?B?c3RsVGJXczA3RkFIVTBqdnYxejB3YjljamUwaUswRzV5Sk1kSzB2MDVoQU5L?=
 =?utf-8?B?QlRaRnRrenh1Q2tNMytaK05lZ2xwZlBjRHJlU0xxR2xGYmttUXcwNXhRcE0r?=
 =?utf-8?B?cGo2S2pUUjhQMXd1bDVrNm5tOHFmRmVTQWdNekR6VFcxY2lQZDlUcEp2Uit1?=
 =?utf-8?B?THJwM0RLYTFLL3huR1o2Y1RyZnUvN0ovNXBOTWx3V24rYmJ3TnRTOEZqemll?=
 =?utf-8?B?bUx1N1hVUW4yUE12K2tOSjZ5a1lOSGd1dnZQYU82OFZwWTZnZkRZOVFvd2sw?=
 =?utf-8?B?aUtiTk85N2FETUx2UUhMOWRYdHI4QlFzQXBLRExwbkVzYWtHeFExNHl6WWxY?=
 =?utf-8?B?RlBqU2Z5NDdCMzJ4NDJiYVU4NHNFcmFJSjl1dFhVOFpHaXgyWlkzQ0M0akNl?=
 =?utf-8?B?UERFa2NRNERZWDZuSnA3dzc2d25ER2taYTNMYVY3UGFBSmdFbXcyeHlwM1BQ?=
 =?utf-8?B?RGE3MFVCektKdW1RV0ZzMnNvNFdwdEkzWE1VcU9NcFhYQnNJYnJkQ0VQYnRz?=
 =?utf-8?B?UitVa2pmMXpmbGppK3NaeHRsUWd1WFdSMTFsVzE4TUsrbFRsaTU2YWk4a2N5?=
 =?utf-8?B?RmF4elRPcGZFczNEeWU0ZHg0ZC96djdaenhZeWRzOUUzZ0NJMEoyTGdoR1Ja?=
 =?utf-8?B?K3RJR2Qzek12VFE3NlB6cDVKWUkxWW1rMFpqT0tGZnFpeVpqbTBsdkV6K2x3?=
 =?utf-8?B?ZzNWdlNkdU9CNGQ1OGRqQTV3RWdUUE5McE9DZGpwempNRUNDdjFLUlVBaE1j?=
 =?utf-8?B?YXFicU1Lb0NwSGRpSHJGUFJYTXJ1bCthenlNbUsxTWJiU29xOUdoL2IyREwv?=
 =?utf-8?B?SzBvZlE0RlpOTElvL1JWK2R1QmpjcHBlcVltVEJTSjU3Qjk4Wkl6MEZhbVgv?=
 =?utf-8?B?OExmaEZ4TXBDL1IvUWVqR1lpdjN0SmVWaWJ5cHJWckNjMFlyd0YvU0JvUGZ1?=
 =?utf-8?B?YkgxVWpZS3lLbHNneVVJNjV2ZDB4ODExTnlxOHNCOUtsUjdtNi9YdUFtYnFr?=
 =?utf-8?B?RHp0aVJoZ01pZTRYSzRnK3h1TFVBYmpDL0pXdkJhY3FYd002S21sYXVDeHJK?=
 =?utf-8?B?d2NPdkR1a0JhNndrWHJQdDdDc0JMVE9EOWFUSE1iMWNTUnBidlU4bDFYMUNh?=
 =?utf-8?B?c1NUOGY1c2dDWkxGTlBOMUF0VnhYRURqKzBVOEtuT1dMOEZpdzBDU1FJOXVu?=
 =?utf-8?B?ZlU4K1FJRWZEMjdUYWM3OWdzblNQc0NCNUlKMW5heWpENmQ2U0tENzhlQ3Mr?=
 =?utf-8?B?alVnTGkyS1d5U0x4Z2RMcThVWEhkWE04ejI5L3RTSzRuWFJmVVhvMm1GRURx?=
 =?utf-8?Q?Jqubww2aG30cwPvhnwozRdo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D29585BB005E4940AC4BBCD68A9015B7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9c09e4-3dac-4cce-1214-08d9b1bb0f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2021 15:32:01.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdMZYU0ttaV4W8Ra5dAEH6I8s96GgWFNzQElSsyetEZvYrUJPFhZffjcqCWY52jVUERxfvQJnHJRmPylrq1Hag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3608
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZjk2ZjhjYzRh
NjNkZDY0NWUwN2VhOTcxMmJlNGUwYTc2ZWE0ZWMxZjoNCg0KICBORlN2NDogU2FuaXR5IGNoZWNr
IHRoZSBwYXJhbWV0ZXJzIGluIG5mczQxX3VwZGF0ZV90YXJnZXRfc2xvdGlkKCkgKDIwMjEtMTEt
MDcgMDk6MjM6MTQgLTA1MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KDQogIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3RzL3Ryb25kbXkvbGludXgt
bmZzLmdpdCB0YWdzL25mcy1mb3ItNS4xNi0yDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byAwNjRhOTE3NzFmN2FhZTRlYTJkMTMwMzNiNjRlOTIxOTUxZDIxNmNlOg0KDQogIFNVTlJQ
QzogdXNlIGRpZmZlcmVudCBsb2NrIGtleXMgZm9yIElORVQ2IGFuZCBMT0NBTCAoMjAyMS0xMS0y
MiAxNzo0NDo0OSAtMDUwMCkNCg0KVGhhbmtzIQ0KICBUcm9uZA0KDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpORlMgY2xp
ZW50IGJ1Z2ZpeGVzIGZvciBMaW51eCA1LjE2DQoNCkhpZ2hsaWdodHMgaW5jbHVkZToNCg0KU3Rh
YmxlIGZpeGVzOg0KLSBORlN2NDI6IEZpeCBwYWdlY2FjaGUgaW52YWxpZGF0aW9uIGFmdGVyIENP
UFkvQ0xPTkUNCg0KQnVnZml4ZXM6DQotIE5GU3Y0MjogRG9uJ3QgZmFpbCBjbG9uZSgpIGp1c3Qg
YmVjYXVzZSB0aGUgc2VydmVyIGZhaWxlZCB0byByZXR1cm4NCiAgcG9zdC1vcCBhdHRyaWJ1dGVz
DQotIFNVTlJQQzogdXNlIGRpZmZlcmVudCBsb2NrZGVwIGtleXMgZm9yIElORVQ2IGFuZCBMT0NB
TA0KLSBORlN2NC4xOiBoYW5kbGUgTkZTNEVSUl9OT1NQQyBmcm9tIENSRUFURV9TRVNTSU9ODQot
IFNVTlJQQzogZml4IGhlYWRlciBpbmNsdWRlIGd1YXJkIGluIHRyYWNlIGhlYWRlcg0KDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpCZW5qYW1pbiBDb2RkaW5ndG9uICgyKToNCiAgICAgIE5GUzogQWRkIGEgdHJhY2Vwb2lu
dCB0byBzaG93IHRoZSByZXN1bHRzIG9mIG5mc19zZXRfY2FjaGVfaW52YWxpZCgpDQogICAgICBO
RlN2NDI6IEZpeCBwYWdlY2FjaGUgaW52YWxpZGF0aW9uIGFmdGVyIENPUFkvQ0xPTkUNCg0KTmVp
bEJyb3duICgxKToNCiAgICAgIFNVTlJQQzogdXNlIGRpZmZlcmVudCBsb2NrIGtleXMgZm9yIElO
RVQ2IGFuZCBMT0NBTA0KDQpPbGdhIEtvcm5pZXZza2FpYSAoMSk6DQogICAgICBORlN2NC4xOiBo
YW5kbGUgTkZTNEVSUl9OT1NQQyBieSBDUkVBVEVfU0VTU0lPTg0KDQpUaGlhZ28gUmFmYWVsIEJl
Y2tlciAoMSk6DQogICAgICBzdW5ycGM6IGZpeCBoZWFkZXIgaW5jbHVkZSBndWFyZCBpbiB0cmFj
ZSBoZWFkZXINCg0KVHJvbmQgTXlrbGVidXN0ICgxKToNCiAgICAgIE5GU3Y0MjogRG9uJ3QgZmFp
bCBjbG9uZSgpIHVubGVzcyB0aGUgT1BfQ0xPTkUgb3BlcmF0aW9uIGZhaWxlZA0KDQogZnMvbmZz
L2lub2RlLmMgICAgICAgICAgICAgICAgfCAgMSArDQogZnMvbmZzL25mczQycHJvYy5jICAgICAg
ICAgICAgfCAgNCArKystDQogZnMvbmZzL25mczQyeGRyLmMgICAgICAgICAgICAgfCAgMyArLS0N
CiBmcy9uZnMvbmZzNHN0YXRlLmMgICAgICAgICAgICB8ICA0ICsrKysNCiBmcy9uZnMvbmZzdHJh
Y2UuaCAgICAgICAgICAgICB8ICAxICsNCiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9ycGNnc3MuaCB8
ICAyICstDQogbmV0L3N1bnJwYy94cHJ0c29jay5jICAgICAgICAgfCAxMCArKysrKy0tLS0tDQog
NyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
