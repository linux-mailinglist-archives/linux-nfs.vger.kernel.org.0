Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811AE4212FE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhJDPr7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 11:47:59 -0400
Received: from mail-mw2nam12on2118.outbound.protection.outlook.com ([40.107.244.118]:9824
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235938AbhJDPr6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 11:47:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUq4HlEevYH51V3WgGJTpEKv4k9l0Uj0x8pzZxTFPB1RSU38WDAoihNW5JVM2SGuNaHf1aPLUim5O2Y9cYydkrARMiHzdAqfth9drp7RmpoNr9ylMM+/06xBemNxImSyFMeMh5B5MbMHx2vJmlq81J4WrH04E2itI3E1iUIatRjoFeG1z1grjEiBIbVGpRixL/+yd25JhynHDUEDmmDyexoWZAV4Rh+Xc43UbC1YAl9oplU9OmRo8eFRy5k6F3z1R7KAu3wt6+bM+KgXaTnBJFbutBcJQI++FPve6gTnbxDQB0IOJzgJd0GRQ8Q/3eBSWk2q6FAZey7UP+9uzfZmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nnz2ULAJ0uq9OXRf+X5dScPQ4KUwTuQwlZpNV9TB6hs=;
 b=kndU0uc2YWTpirdqoTmXvKCJYzrTUXb9uoEjSjix3MPn/eMTEcMB0dkXFdVJI2WpztBzX5JKcuXnksOZnZkvYNsBMRL8FcO3P7ndSFpmmhRkxnO2S1LmxWeaN+KlytWYezRlMiv5glIa03wFbbuSdqDvnpysrSrFzng5QLtz5IuGovItXwZsWPP65SJgi6cXwc7LcgFPv0Jb3hIpdfUKP96vng4QUy/uLcxdt9cpN8BY/9H4AMrgFt9b36FaojGq56WYMpTukR4jSwZ58Nm+KUUTxMdl40PFBkN/zfXyW39cnDsPBlHkTjXlGRZW5olmbBZQtDJBnA08Mr5SVUvi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnz2ULAJ0uq9OXRf+X5dScPQ4KUwTuQwlZpNV9TB6hs=;
 b=CpUEpGTNY/W+7pakgEl0UOBoyzPcdQw97FSv5Df1ltCLVDIO7zgnUemEEcrbz8uvb9tKkbc31X1JFq46CTlaSld8qmz9kZ3MzQhvf5n6VESHKhxdnx9NIHf75f/syRNxGolSeHh2JDKHaaDuwXFSl4i26Rtf3gckBiWwx407FvY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4633.namprd13.prod.outlook.com (2603:10b6:610:ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.12; Mon, 4 Oct
 2021 15:46:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%6]) with mapi id 15.20.4587.017; Mon, 4 Oct 2021
 15:46:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] A collection of NFS client tracepoint patches
Thread-Topic: [PATCH 0/4] A collection of NFS client tracepoint patches
Thread-Index: AQHXuSmC2Q7lJLR2kESK8MV0gwvHFqvC+48A
Date:   Mon, 4 Oct 2021 15:46:07 +0000
Message-ID: <b47160ac25bc7781855517d61a586efd78fedd8e.camel@hammerspace.com>
References: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
In-Reply-To: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20b5a724-fc57-4b0a-f5e4-08d9874e1498
x-ms-traffictypediagnostic: CH0PR13MB4633:
x-microsoft-antispam-prvs: <CH0PR13MB4633CA5284F2AC63B7A5EB2DB8AE9@CH0PR13MB4633.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w58D8uEQOS6SgfMhwBTIp65/KiDrsWNJcIeLMGOY2j5rNstJPOh7KAx/qYG2TTp4gsEB83SKv+Ab/S5awxHBK8whK1y87EkKc1X7u5teXmx1qAwia4Unou1INro3bEHRrpsAf48bVo2NyVDeY3IsAqcoSuXXEix5sw0l3YTaKM5tm91gMKqeOt1PzPhDPSHEE563zw3qRNuwq1URshX4p3pFjRlczep8UF0oN82LZuoMcW5glHv2Rr3KxA2epJZ6tCSJ55UqiNtFHVmtQsJZwz6zo4X+3Jrim0A/XlF0BNB3/oFpEHTdHg8mS1tMNC7dwvVs0f0rdY1Z3m6mmFyJoxBj9KtKmb8ltPP8B2mMbLKZrlGVVYPq5AA0/EtffFj52RtOXc+71YBjRLyKYcIXCwpvPU+0F5b1oQDUVceGyM7RUguGmx/EjKHb7WizoAeY3mOYsJdoqV2iakhw2fbYg/CQz14BwrTjjgLsZdYwopmXua2YtzJdWfdoyW0oWhH28USmXurRDXBgXc614VyEzhJLBPNvpMewZYwSfc4JnZ7b2W64gDq3rPsS9utJ3n4JXrxSqOT5PpBjvasHQBVezi3XBngJ0IELkrdTdJvVMQy9yXlPVbG4v1fBVaYc1PIYF2zt/iwjgLfAm3Wz4gDLdf/kUL46SFxFxFuKA0faZn5t8wqiD2eMknWxXR7h+SKGPGxRmd+GzOVf3WwjgBo2OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39830400003)(26005)(8676002)(186003)(2616005)(4326008)(6512007)(38070700005)(8936002)(38100700002)(122000001)(2906002)(86362001)(5660300002)(6486002)(71200400001)(110136005)(36756003)(316002)(6506007)(4744005)(83380400001)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzZNYllkZTFmbjVMa0JNeGVyUTlDbGtSdmphclRxNU5WMXBKUWZDZlA4czNF?=
 =?utf-8?B?WWJrYUt5NTZ3VndqQnZ6KzBCd1NjUmZQdXNrZWlNRnNoQndqVit0b3U4RU9u?=
 =?utf-8?B?akdoV1ZNdERzcXVML0dPM1NRSGl4eEhlOHY5dU5kbFU4TTFJdVdSc0FxclJZ?=
 =?utf-8?B?RXNsVVlGaEJHRkdZMTR3K1NMV3ZBenErNGJXbzB1a0h2QmJGYmxUQ1gxTHlk?=
 =?utf-8?B?d3ZmVkUvMkhoZ0lwWk9GaUtLeWpLUXEwcVRtb1JBbDh1QUg3SDgrRC85T0Zk?=
 =?utf-8?B?TUtPN3hEd1dYbTJ4blhEcmpkZXJSMmlIandUM3lRY3ZxZi9BSjZySEZ6OTV0?=
 =?utf-8?B?TFZUWGpSeTFUREt4Y2tMVkNCVVZycHpMOHVyZndKdTNzeDlNaHpsZmJtNVk0?=
 =?utf-8?B?OVpIUDNoVjVMVStjLy9RYTNDZWI5MUlmc2JUUXFyZVFhSHQ3UnVsWnJTSmJx?=
 =?utf-8?B?bGJwQzhjcElmZC9FUnJjRngyVmRpdDdXREN4eXBQM0ppU1JSYXl2T3BLaUh6?=
 =?utf-8?B?dEhEemVyVXNXRlZBY0dENWc1YzR5WmxhY01RcFFpMHlnZ1pHTVVQV1ZLbG5X?=
 =?utf-8?B?WTFHRk9KUkl1eXVQamdDTmFlNVdSK1M2L0dCL2F2b0hzYmRzQy9CNGdzbHVO?=
 =?utf-8?B?VzQxSUQxdmVWVjNxeVp0OXNMb2ZFZENoYnluZnkvNEU1UEFHZVV4Nm92cUtu?=
 =?utf-8?B?MUh1dlpUV3d2dGpxeHpvQW1NUTd1NkNnM0tVT25LZzNtRDJ2ZGJvbEpHd3hr?=
 =?utf-8?B?OEtZN0xZVDRYcGpDdVREbHA4SVFJVGN4eEdzd2YvRVc0SVllYVdSaksrdHcv?=
 =?utf-8?B?b25RSk1rT2l4azRYZkFNZXpGOHc5UTVZNnp3bVdYN0swVG92d0dIOC85aEly?=
 =?utf-8?B?YVhScjlXUmFxc1RCRFIrNlh1UllqMG1yYXlLSnIzOHpQRE11WlYvNVFueEJx?=
 =?utf-8?B?MXlwaWdFODduTGtMQ3VJU0x4a2tmYWlWTVlEcEhoK0taN1FkTFh3OHRCdDRC?=
 =?utf-8?B?cm55WUdmUVNrVkx2ZUVZWFk3Sml6QVdzbzQvUlZGUTlnNVBDUXByeW03dU02?=
 =?utf-8?B?NmlRRlFHS3ZkY25hbFU2VWs5VEs4UHVtMEdCa29pSXhQVkRnVjlxSnNLT3Vw?=
 =?utf-8?B?MjlGNDE1Sit2TnNmNjdsT1VSaDBNeFc1dEJjWXVMWVhQUGNSek1Vbi80VWFW?=
 =?utf-8?B?RVFYL3hpSENGTGFKMlZNck5lSEUyTnJ0NGJISkJESFJMYmZyQU5hM252eWVx?=
 =?utf-8?B?OGRwaWFPKzc2bXRFUjc1bHF5SWNOQTNnQ2loSEx5bjA1dW1WRWt2N1pBdjZ2?=
 =?utf-8?B?UUg1U3RVL0FZRW03YkxLMDZlNzN1ekdYTmZ1RHhCYkdPNzRCNk5rRFJmUWw1?=
 =?utf-8?B?VTJDV1NuUWJJYnFBQWFSTDhtaW81UHZIZzhjYWdqNEgrRG83SWlsN2c0NmIz?=
 =?utf-8?B?TlFaTDBKdmJBcXpjTnpiREZGeW95Z2cxam92Vy9xUDh4cHNoYzNsUElRTUsv?=
 =?utf-8?B?N2paMVlESzBCZXZFaGlNNi9OcFY0ZGliclpwN0ZnZm5mOCtaaUxEdFFjS1J4?=
 =?utf-8?B?VGROTldFZytPeTBBaHo2SHBjSWFUb1NiVTh1S3hZMkhkZEhlT3hiUVdML1o2?=
 =?utf-8?B?WThpeWtubUdrdjhDN3lJOVNpVUltSGpIcFR4NHNuTjBXRE1xeTZldUh3MVlu?=
 =?utf-8?B?UjFLbk82Q2d4K2lRc1JYTk9INkpZM2t4cTdpS3RQbllhTmJPRzNUbUsyaG9V?=
 =?utf-8?Q?tNFebQzeFsMESEsocOj1B5xWbUkDq7hMy48FNQT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7546D07AF9B4646BF56DFC037ABCCFA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b5a724-fc57-4b0a-f5e4-08d9874e1498
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 15:46:07.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hCOeELTQXTtaojfu3yO1iFCU+SYHn8LPmVV62MGh74LhOMaZuWNv+gazWc3GHB6OwZ3zFj+A6yYfvqDH/TqpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4633
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTEwLTA0IGF0IDEwOjA5IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGktDQo+IA0KPiBUaGlzIHNlcmllcyBwcm9wb3NlcyBhIHNtYWxsIGhhbmRmdWwgb2YgdHJhY2Vw
b2ludC1yZWxhdGVkIGNoYW5nZXMuDQo+IA0KPiBUaGUgZmlyc3QgcGF0Y2ggaXMgY2xlYW4tdXAu
DQo+IA0KPiBUaGUgc2Vjb25kIGFuZCB0aGlyZCBwYXRjaGVzIGFyZSBwYXJ0IG9mIHRoZSBvbmdv
aW5nIGVmZm9ydCB0bw0KPiByZXBsYWNlIGRwcmludGsgd2l0aCB0cmFjZXBvaW50cy4NCj4gDQo+
IFRoZSBsYXN0IHBhdGNoIGFkZHMgc29tZSB0cmFjZXBvaW50cyBJIGZvdW5kIHVzZWZ1bCB3aGls
ZSBkaWFnbm9zaW5nDQo+IHRoZSByZWNlbnQgTkZTdjMgZnN4IGZhaWx1cmVzLg0KPiANCj4gLS0t
DQo+IA0KPiBDaHVjayBMZXZlciAoNCk6DQo+IMKgwqDCoMKgwqAgTkZTOiBSZW1vdmUgdW5uZWNl
c3NhcnkgVFJBQ0VfREVGSU5FX0VOVU0oKXMNCj4gwqDCoMKgwqDCoCBTVU5SUEM6IFRyYWNlcG9p
bnRzIHNob3VsZCBzdG9yZSB0a19waWQgYW5kIGNsX2NsaWQgYXMgYSBzaWduZWQNCj4gaW50DQo+
IMKgwqDCoMKgwqAgU1VOUlBDOiBQZXItcnBjX2NsbnQgdGFzayBQSURzDQo+IMKgwqDCoMKgwqAg
TkZTOiBJbnN0cnVtZW50IGlfc2l6ZV93cml0ZSgpDQoNCkknbSBmaW5lIHdpdGggYXBwbHlpbmcg
cGF0Y2hlcyAxLCAzIGFuZCA0IGZvciBub3csIGJ1dCBJIGhhdmUgc3Ryb25nDQpyZXNlcnZhdGlv
bnMgYWJvdXQgcGF0Y2ggMi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
