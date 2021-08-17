Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8B3EF088
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Aug 2021 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhHQRBU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 13:01:20 -0400
Received: from mail-bn8nam08on2067.outbound.protection.outlook.com ([40.107.100.67]:35169
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229699AbhHQRBU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Aug 2021 13:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBFOxMkKfRx3vqgT+9hSVyFBUJffJeiCXgx+CZpp/4DS38BtD6jMcCz6uSEUSvkO6LpRQZnU6NWcU4JHU0LsAQzklrL5OZKp1lgfEkDDFuSEjfEjp3cOhASCJ7H78bYpU278YiTjzmolEYJpU0qBrd7nhA4bYVQjAYy+YWQMtsIiYnQTvd/VqCSetGPv4j2Yv761kfQY9eH3kpuzI5aTyAjVQdtSQS9U8vB8/vs+2T8ZZrNdM+g7C9T5pKF6Tmzc5boabt1CkslX3zv8M8z3bxrINkmTb+xNKA88sk+jECLoXqnI/23fZQjSuxeViAWFN7pBMkS+TT29wsziwC4aUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG1z1O18LyD6bjZkCHZWVxn5cF+SU1hR05jKvkHOCJQ=;
 b=ZlA2OERYm8OPFnIBjC+O5EJXbyU+ZMcLS9VVqsjj3d56I3y93TbOJ9hb6btoGiW5gccQ1tmpw5StBpugCMBpO9ZmlSzr3h2By+allv/NCnA/SMJggKREiq0z6Wv0Wk9XPIKuVcO2R7n3aRjZ9kutBIXHx8B5kA4ADKTsnAf4XJ0scSvRn1LJ10x/VUIUjuUy8DTj1FdG6t9t+BNuuly8mIbAhjI8cOF5r7uNWRrz2hff7v4k8Nhy/nj0aXaIlsavaHfC8XQrmCeEVnT2NR3CX7lOUeAVnccVYRMc5qxp8C1bcqO/PUY9x3DBMXngdvV8BaMsqtTY3Mco8JAWMhHWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG1z1O18LyD6bjZkCHZWVxn5cF+SU1hR05jKvkHOCJQ=;
 b=f76qNBaywFP91USJtVMVGbEl2hMiXBVOR7rRXaa92N3Wwyu0M5MZtCCfjL/g527PJCRVoyUV6Nz52a1FNzJgpVGdVYRceKfNCaOCAai03H7iw1ezbzVlW1Aeuunib0f1XsjOWPinYvAh5jS/OIlT8jGB8G0hdFtfJFe877NBIguMpmOEtJ+lNUFoK3cXyXi6jPJNoTVrYr05LG4qcNbHvpm8QviDYEogDWoFzeNzXk4uM467YlJZ0NY+62sWLg+IfNjcIm5y/H2H8mkgOWrbMET6HBHuLwK2uOckv76AT4Qr8Z50Xzx+ZgKaTJ93nzfDO0XblZplk4ildZaj5qyy7g==
Received: from BYAPR06MB4296.namprd06.prod.outlook.com (2603:10b6:a03:10::20)
 by BY5PR06MB6625.namprd06.prod.outlook.com (2603:10b6:a03:23d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 17:00:44 +0000
Received: from BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::7d63:de76:f951:c981]) by BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::7d63:de76:f951:c981%2]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 17:00:44 +0000
From:   "Mora, Jorge" <Jorge.Mora@netapp.com>
To:     "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        steved <steved@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v2 7/9] nfs-sysfs.py: Add a command for changing xprt
 state
Thread-Topic: [PATCH v2 7/9] nfs-sysfs.py: Add a command for changing xprt
 state
Thread-Index: AQHXiwAjN0reBtMdKUWkrdSIE5zWa6t3mD6A
Date:   Tue, 17 Aug 2021 17:00:44 +0000
Message-ID: <FC648158-9FA0-44A8-ADF1-AA8C78FF8F90@netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
 <20210806201739.472806-8-Anna.Schumaker@Netapp.com>
In-Reply-To: <20210806201739.472806-8-Anna.Schumaker@Netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.52.21080801
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56532c45-4248-4688-3252-08d961a08d63
x-ms-traffictypediagnostic: BY5PR06MB6625:
x-ld-processed: 4b0911a0-929b-4715-944b-c03745165b3a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR06MB66253D8DF415748A537A8B62E1FE9@BY5PR06MB6625.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZa/DUVIl/r+d1KAS6Rw8fhNessHWnw8s6ucWB5tKsU7exwZqHBfFHY4U91bjU2FsrvVL3Y6LYeL0MkvymvdFSmxVpQIKJ8jsmcyC7esfqIBsRfsNWrTLgjMf2rp/Y8EwHnvPL1pMMqepoTHv2nZZZEJ9dUtfRTF580J5GqgAFSe2YIqwCFn8yiEtgJBmGKdsEEmL8NJYBmna91hAnq9pIicaVUanDoSElz2dPNL37951JP5euCQPh+NsexXhjJVl/yZRcZPv3IgQpLPB4KZAEIbkCQGM0KGPJ0527Km194MdXCwZJYVM9ZtDahY2ckNTdFvRoxU+bn92u3B6Qx5IZFfefPp6YI7rwvaDR6YDGyvhTHQYbrW2g8WDkaTfVpSEpb9qx0hmyLt67MlRUYAuP7Roxmp67qxuarFn0MiesTJLXbp+7oLV6+A1RTqU/jKYFifT4U+XTkw/yKnWkE/IwCKoGHy72nQDHghoUaLMG3fgWS64dboPFyrxZCjKRbgxFm4HvWQCzopwAzA5fx82PoOfbd8yz6OnTHfQO9qsrGv763fBl4lUViyPe5NQ8zW2ZW9+MjDba1yfUNIu+LFfipg83bK5MYoWepFadXhS6VfCmgGsmEZdL9lLGXcUxk6sCfJwoswAxJLwI6tSAAltvjpakHIyhj54YNVAs60JJ4t4y9C3YFk7IwcJQ/p7itMNxcG9TFHatDRlNjiHnK5yh9IMddsspfiMkAv3RoNslRMf5Y6B6siJ/Eag+AXNU5t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4296.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(38100700002)(6512007)(122000001)(66946007)(110136005)(86362001)(91956017)(76116006)(6486002)(33656002)(26005)(83380400001)(2906002)(186003)(66476007)(66556008)(64756008)(66446008)(6506007)(316002)(2616005)(5660300002)(71200400001)(36756003)(8936002)(107886003)(8676002)(478600001)(4326008)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDhwYjl2cmJWWDArV2h0WlRITUs5dUthOWNmM0NXSER3akk0QjVuTVk4UzE2?=
 =?utf-8?B?Mm91Q0VxOGxxMDRLOGExdzd5cmdYNXlXeHJ5UUdWYThDVVFlNjhRcDVydVlr?=
 =?utf-8?B?WnQrdTI4U3hhaUptaFBUWFUvaEV6TFNBR0p6M2lIT2FLVFpIbSt5K1JCS0hU?=
 =?utf-8?B?aWtUSVNLSUlqc0RvTWN5RjJUYWxLSjhQaFlTWGhoVkhCdkxOY1Y5UzFndXFJ?=
 =?utf-8?B?ZGlNbWFFb0k3aXR1QnQrRHNzaVBHQnF2T0NIajMxUXJLejlLVXhlc2ZYV1JF?=
 =?utf-8?B?N3dtdzlrU0h3OENBU3JuS0g1OFNyNGZYWVM3R3YxYmx0NmNYblRVYkxTK0Rj?=
 =?utf-8?B?N2g0UnpJUktHVEd6UElvYUxLcnZRSDJORDBkWFl3N1NmdGhHamcyTkwrZFA2?=
 =?utf-8?B?UGVRMG5pZjBxbSs2b0duenBCQnpmZ3ZLL0JoRG1DSFJmOS9hdks1akl2b0pa?=
 =?utf-8?B?M1BOS2pGR2kyUXlyNUxGcEowbW5ZMGIzcjdwd2hTWlM3L2IxM2tkN2hCR2RT?=
 =?utf-8?B?SWFSRUp2TFdEeDJZVHdkTVBvaE1IbGNiMEhWNUtRRU9iUmljZXpSbEV5WS80?=
 =?utf-8?B?dGp2dm4wWEx3WVh5YkF0T2VFaG5ueU9mVW9IQW10OG1OclpldFZxTEwvdHh4?=
 =?utf-8?B?SlpHdWZIV0lScHB4VG9MK1lmMVlqclgybGpiRHJ6bjZHSDMrbTJhSk0vdTNW?=
 =?utf-8?B?VFNBN0g3TmxyVXJ6aTNGL21DN1R4cGNaOWpGdjdvUWEvWFF0cjh0dmhoNGV6?=
 =?utf-8?B?cGNuSjJvSER5Y0xIcVRHaERNdHB3Wnp2UEErNUM4Y2FkRjlPVjJOTG9CSERv?=
 =?utf-8?B?cWEzYS9nMlhxb1E5MWZvb2ZJeEc1RFErYXB5YjJDTGVIYWFKVExNMzhmckdF?=
 =?utf-8?B?NkFwODVjcjBTOW1GMVl5RlNWL3NNRldaZzFQd1JIS1pRd3c3TFp4UThkbW4w?=
 =?utf-8?B?Q1NqU1h0VnNNWXdoK3pYbkxQQWU3MjBFaDF2Wk1ERk1PZWxudldVbTlxWjdn?=
 =?utf-8?B?U3dvZjhQbm1iRng5a1VFQkpGdFhwV0c1enFRZG1SNnhVbmRCM3BGT2ptSitH?=
 =?utf-8?B?cmd6SVg3emV5NWRINHM4VXFyRGNSMFdVNjQ2eU1URll0ZGxEdlFZT0o2NnAy?=
 =?utf-8?B?R2kzaTFCR3VMdGhhRmRTdWt5akprYmRlcEEwZUIzZ3B4THNCbzc4a2VyMXRK?=
 =?utf-8?B?YVJhaTVndnB5RFpTSy9pTjl6b21QUzh1R3ozR1RKRTEzQUZZRlUrM3ErbWR0?=
 =?utf-8?B?SkI4eXU4eUsyNllnYmMwdE15KzQza3NseTQ5TCtNTjFpMWwrVXZnNUFPYWYw?=
 =?utf-8?B?RHNPOWtGZkJWSlVvbkZwY2g3cXR1TEl3NFNWMUsvKzcwekt5K2h3aTZpdWR2?=
 =?utf-8?B?a2NqZm1wcjB6UWRUWGlycysyWGNVY0tRaHJ3aTRQMHAyWGw2ZmlrNE0yaU1V?=
 =?utf-8?B?U1RnYzRMTWRkQkVXZXRVS2xmMGFaWndpaE93NndOSk9hRU5nZmZzWXg1eEdx?=
 =?utf-8?B?VFpPVGU2OWFQTEh0NEFpRkxRditrUDFWOVpoQUZYbWM0bWtyaThua1FJWE1Y?=
 =?utf-8?B?M0RRS3ZUM3FrNHZZMGM3YlJKb3o4d3lOTnV4WmU1akhDWFRuK1czRURkNFBo?=
 =?utf-8?B?d0RNV0VlWHNHbVZmSW5LenBTekJzaGk3NHo0cUwweE9TLzBCd0luMzFhaEZK?=
 =?utf-8?B?QWhUU055cjVNNDZRa1dsdFFSTzFNK2x1andEakpVd09SVnowRWNZaGFaWDhq?=
 =?utf-8?Q?y0KkZ0tTSI47hStJtIJsFUC++T2YgfSWzv4XLdR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D6A741CC3FBB045BAECEE3ECED14758@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4296.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56532c45-4248-4688-3252-08d961a08d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 17:00:44.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDP14Ra+Y05cTxnb+qNu739RkIZfE8kyUquO6A2kbs70wdoSVNNZiBZMu+L8gCq5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6625
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGVsbG8gQW5uYSwNCg0KQ29tbWVudHMgYXJlIGlubGluZToNCg0KLS1Kb3JnZQ0KDQrvu79PbiA4
LzYvMjEsIDI6MTcgUE0sICJBbm5hIFNjaHVtYWtlciBvbiBiZWhhbGYgb2Ygc2NodW1ha2VyLmFu
bmFAZ21haWwuY29tIiA8c2NodW1ha2VyYW5uYUBnbWFpbC5jb20gb24gYmVoYWxmIG9mIHNjaHVt
YWtlci5hbm5hQGdtYWlsLmNvbT4gd3JvdGU6DQoNCiAgICBOZXRBcHAgU2VjdXJpdHkgV0FSTklO
RzogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KDQoNCg0KDQogICAgRnJvbTogQW5uYSBTY2h1bWFrZXIgPEFubmEu
U2NodW1ha2VyQE5ldGFwcC5jb20+DQoNCiAgICBXZSBjYW4gc2V0IGl0IG9mZmxpbmUgb3Igb25s
aW5lLCBvciB3ZSBjYW4gcmVtb3ZlIGFuIHhwcnQuIFRoZSBrZXJuZWwNCiAgICBvbmx5IHN1cHBv
cnRzIHJlbW92aW5nIG9mZmxpbmVkIHRyYW5zcG9ydHMsIHNvIHdlIG1ha2Ugc3VyZSB0byBzZXQg
dGhlDQogICAgc3RhdGUgdG8gIm9mZmxpbmUiIGJlZm9yZSBzZW5kaW5nIHRoZSByZW1vdmUgY29t
bWFuZC4NCg0KICAgIFNpZ25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtl
ckBOZXRhcHAuY29tPg0KICAgIC0tLQ0KICAgICB0b29scy9uZnMtc3lzZnMveHBydC5weSB8IDI5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAyNyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQogICAgZGlmZiAtLWdpdCBhL3Rvb2xzL25m
cy1zeXNmcy94cHJ0LnB5IGIvdG9vbHMvbmZzLXN5c2ZzL3hwcnQucHkNCiAgICBpbmRleCAyMTYw
Y2IwYTk1NzUuLjkyYjgzZWJjNGNkMSAxMDA2NDQNCiAgICAtLS0gYS90b29scy9uZnMtc3lzZnMv
eHBydC5weQ0KICAgICsrKyBiL3Rvb2xzL25mcy1zeXNmcy94cHJ0LnB5DQogICAgQEAgLTgsMTUg
KzgsMTggQEAgY2xhc3MgWHBydDoNCiAgICAgICAgICAgICBzZWxmLnR5cGUgPSBzdHIocGF0aCku
cnNwbGl0KCItIiwgMilbMl0NCiAgICAgICAgICAgICBzZWxmLmRzdGFkZHIgPSBvcGVuKHBhdGgg
LyAiZHN0YWRkciIsICdyJykucmVhZGxpbmUoKS5zdHJpcCgpDQogICAgICAgICAgICAgc2VsZi5z
cmNhZGRyID0gb3BlbihwYXRoIC8gInNyY2FkZHIiLCAncicpLnJlYWRsaW5lKCkuc3RyaXAoKQ0K
ICAgICsgICAgICAgIHNlbGYuZXhpc3RzID0gVHJ1ZQ0KDQogICAgLSAgICAgICAgd2l0aCBvcGVu
KHBhdGggLyAieHBydF9zdGF0ZSIpIGFzIGY6DQogICAgLSAgICAgICAgICAgIHNlbGYuc3RhdGUg
PSAnLCcuam9pbihmLnJlYWRsaW5lKCkuc3BsaXQoKVsxOl0pDQogICAgKyAgICAgICAgc2VsZi5y
ZWFkX3N0YXRlKCkNCiAgICAgICAgICAgICBzZWxmLl9fZGljdF9fLnVwZGF0ZShzeXNmcy5yZWFk
X2luZm9fZmlsZShwYXRoIC8gInhwcnRfaW5mbyIpKQ0KDQogICAgICAgICBkZWYgX19sdF9fKHNl
bGYsIHJocyk6DQogICAgICAgICAgICAgcmV0dXJuIHNlbGYuaWQgPCByaHMuaWQNCg0KICAgICAg
ICAgZGVmIF9fc3RyX18oc2VsZik6DQpKTTogRG8gbm90IGNvbXBhcmUgd2l0aCBUcnVlIG9yIEZh
bHNlIGp1c3QgdXNlIGJvb2xlYW4gYXMgaXM6DQogICAgICAgICAgICAgIGlmIG5vdCBzZWxmLmV4
aXN0czoNCiAgICArICAgICAgICBpZiBzZWxmLmV4aXN0cyA9PSBGYWxzZToNCiAgICArICAgICAg
ICAgICAgcmV0dXJuICJ4cHJ0ICVzOiBoYXMgYmVlbiByZW1vdmVkIiAlIHNlbGYuaWQNCiAgICAr
DQogICAgICAgICAgICAgc3RhdGUgPSBzZWxmLnN0YXRlDQogICAgICAgICAgICAgaWYgc2VsZi5t
YWluX3hwcnQ6DQogICAgICAgICAgICAgICAgIHN0YXRlID0gIk1BSU4sIiArIHNlbGYuc3RhdGUN
CiAgICBAQCAtMzEsNiArMzQsMTMgQEAgY2xhc3MgWHBydDoNCiAgICAgICAgICAgICAgICAgICAg
IChzZWxmLmJpbmRpbmdfcV9sZW4sIHNlbGYuc2VuZGluZ19xX2xlbiwgc2VsZi5wZW5kaW5nX3Ff
bGVuLCBzZWxmLmJhY2tsb2dfcV9sZW4sIHNlbGYudGFza3NfcXVldWVsZW4pDQogICAgICAgICAg
ICAgcmV0dXJuIGxpbmUNCg0KICAgICsgICAgZGVmIHJlYWRfc3RhdGUoc2VsZik6DQogICAgKyAg
ICAgICAgaWYgbm90IHNlbGYucGF0aC5leGlzdHMoKToNCiAgICArICAgICAgICAgICAgc2VsZi5l
eGlzdHMgPSBGYWxzZQ0KICAgICsgICAgICAgICAgICByZXR1cm4NCiAgICArICAgICAgICB3aXRo
IG9wZW4oc2VsZi5wYXRoIC8gInhwcnRfc3RhdGUiKSBhcyBmOg0KICAgICsgICAgICAgICAgICBz
ZWxmLnN0YXRlID0gJywnLmpvaW4oZi5yZWFkbGluZSgpLnNwbGl0KClbMTpdKQ0KICAgICsNCiAg
ICAgICAgIGRlZiBzbWFsbF9zdHIoc2VsZik6DQogICAgICAgICAgICAgcmV0dXJuICJ4cHJ0ICVz
OiAlcywgJXMlcyIgJSAoc2VsZi5pZCwgc2VsZi50eXBlLCBzZWxmLmRzdGFkZHIsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmIiBbbWFpbl0iIGlmIHNlbGYubWFp
bl94cHJ0IGVsc2UgIiIgKQ0KICAgIEBAIC00MSw2ICs1MSwxMSBAQCBjbGFzcyBYcHJ0Og0KICAg
ICAgICAgICAgICAgICBmLndyaXRlKHJlc29sdmVkKQ0KICAgICAgICAgICAgIHNlbGYuZHN0YWRk
ciA9IG9wZW4oc2VsZi5wYXRoIC8gImRzdGFkZHIiLCAncicpLnJlYWRsaW5lKCkuc3RyaXAoKQ0K
DQogICAgKyAgICBkZWYgc2V0X3N0YXRlKHNlbGYsIHN0YXRlKToNCiAgICArICAgICAgICB3aXRo
IG9wZW4oc2VsZi5wYXRoIC8gInhwcnRfc3RhdGUiLCAndycpIGFzIGY6DQogICAgKyAgICAgICAg
ICAgIGYud3JpdGUoc3RhdGUpDQogICAgKyAgICAgICAgc2VsZi5yZWFkX3N0YXRlKCkNCiAgICAr
DQoNCiAgICAgZGVmIGxpc3RfeHBydHMoYXJncyk6DQogICAgICAgICB4cHJ0cyA9IFsgWHBydChm
KSBmb3IgZiBpbiAoc3lzZnMuU1VOUlBDIC8gInhwcnQtc3dpdGNoZXMiKS5nbG9iKCIqKi94cHJ0
LSoiKSBdDQogICAgQEAgLTYwLDYgKzc1LDEzIEBAIGRlZiBzZXRfeHBydF9wcm9wZXJ0eShhcmdz
KToNCiAgICAgICAgIHRyeToNCiAgICAgICAgICAgICBpZiBhcmdzLmRzdGFkZHIgIT0gTm9uZToN
CiAgICAgICAgICAgICAgICAgeHBydC5zZXRfZHN0YWRkcihhcmdzLmRzdGFkZHJbMF0pDQpKTTog
RG8gbm90IGNvbXBhcmUgd2l0aCBUcnVlOg0KICAgICAgICAgICAgICBpZiBhcmdzLm9mZmxpbmU6
DQogICAgICAgICAgICAgIGVsaWYgYXJncy5vbmxpbmU6DQogICAgICAgICAgICAgIGVsaWYgYXJn
cy5yZW1vdmU6DQogICAgKyAgICAgICAgaWYgYXJncy5vZmZsaW5lID09IFRydWU6DQogICAgKyAg
ICAgICAgICAgIHhwcnQuc2V0X3N0YXRlKCJvZmZsaW5lIikNCiAgICArICAgICAgICBlbGlmIGFy
Z3Mub25saW5lID09IFRydWU6DQogICAgKyAgICAgICAgICAgIHhwcnQuc2V0X3N0YXRlKCJvbmxp
bmUiKQ0KICAgICsgICAgICAgIGVsaWYgYXJncy5yZW1vdmUgPT0gVHJ1ZToNCiAgICArICAgICAg
ICAgICAgeHBydC5zZXRfc3RhdGUoIm9mZmxpbmUiKQ0KICAgICsgICAgICAgICAgICB4cHJ0LnNl
dF9zdGF0ZSgicmVtb3ZlIikNCiAgICAgICAgICAgICBwcmludCh4cHJ0KQ0KICAgICAgICAgZXhj
ZXB0IEV4Y2VwdGlvbiBhcyBlOg0KICAgICAgICAgICAgIHByaW50KGUpDQogICAgQEAgLTczLDQg
Kzk1LDcgQEAgZGVmIGFkZF9jb21tYW5kKHN1YnBhcnNlcik6DQogICAgICAgICBwYXJzZXIgPSBz
dWJwYXJzZXIuYWRkX3BhcnNlcigic2V0IiwgaGVscD0iU2V0IGFuIHhwcnQgcHJvcGVydHkiKQ0K
ICAgICAgICAgcGFyc2VyLmFkZF9hcmd1bWVudCgiLS1pZCIsIG1ldGF2YXI9IklEIiwgbmFyZ3M9
MSwgdHlwZT1pbnQsIHJlcXVpcmVkPVRydWUsIGhlbHA9IklkIG9mIGEgc3BlY2lmaWMgeHBydCB0
byBtb2RpZnkiKQ0KICAgICAgICAgcGFyc2VyLmFkZF9hcmd1bWVudCgiLS1kc3RhZGRyIiwgbWV0
YXZhcj0iZHN0YWRkciIsIG5hcmdzPTEsIHR5cGU9c3RyLCBoZWxwPSJOZXcgZHN0YWRkciB0byBz
ZXQiKQ0KICAgICsgICAgcGFyc2VyLmFkZF9hcmd1bWVudCgiLS1vZmZsaW5lIiwgYWN0aW9uPSJz
dG9yZV90cnVlIiwgaGVscD0iU2V0IGFuIHhwcnQgb2ZmbGluZSIpDQogICAgKyAgICBwYXJzZXIu
YWRkX2FyZ3VtZW50KCItLW9ubGluZSIsIGFjdGlvbj0ic3RvcmVfdHJ1ZSIsIGhlbHA9IlNldCBh
biBvZmZsaW5lIHhwcnQgYmFjayBvbmxpbmUiKQ0KICAgICsgICAgcGFyc2VyLmFkZF9hcmd1bWVu
dCgiLS1yZW1vdmUiLCBhY3Rpb249InN0b3JlX3RydWUiLCBoZWxwPSJSZW1vdmUgYW4geHBydCIp
DQogICAgICAgICBwYXJzZXIuc2V0X2RlZmF1bHRzKGZ1bmM9c2V0X3hwcnRfcHJvcGVydHkpDQog
ICAgLS0NCiAgICAyLjMyLjANCg0KDQo=
