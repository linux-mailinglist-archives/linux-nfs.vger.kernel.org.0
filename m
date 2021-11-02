Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE34438A8
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 23:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhKBWpS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 18:45:18 -0400
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com ([40.107.237.101]:43872
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229685AbhKBWpR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Nov 2021 18:45:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV/NMn8Srcby7xPtCyeHnAcuXAP69A2fZiDIx1cwG9d+TUVg7JMKZVLeUCApS2QBeOP3HzbCSPXzpuzE8SrNEhZHNweydezMz26QRdLaXL67AEFyExfYtwDGJwbjNOabtTgujf8zzIMBTXTfWsGzakx0uRqMDwjyt6cYUIbbQd5oPbp/4VjY0sAm/6DAgEoqx8IDJzCG1WR19ZluhmrSI9kHNk4zG0RkpX74NqiTKBz5jfHU4HBBpkJXOJEm2GQWGLTkOtsF5ymivGPP8LgeiWWBSyEj6ouuRE8rfRCgz0tQoE2GoEBrb/YdSSoOFhVgS9aHOSFK6HiWika1YKHQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ooqMTNWWaw5jRUxmsM5Nvpd75gFWCz4d7ZaXB8OUFM=;
 b=RYXzmQeuXS5mQGejjOHjIFO/d6D+42BmgTa85suzg34U+iXFXn6IylI7ejL5LBJ4VqFqJsPnFFiqhV5pd7f8lVKRmsjVVzCZn8g5wKO2J3jzaEt0kXnzLNIyaP9j1ky2sRGe+VHWWnbS7KSy9IzckVb0o7cZCQygQwY/jIi9S4qNTdx5FA1ZroRSlNG8GQ7GjCCa770Q2sFYoYp2S0G0QKOXS9TxGOWeeAvvTlmE027puIAZhMu1zSD5M4DoHT8TCvKCwTS+ziK0Q/aifoUGaCeGq3zHaE8IqpCgrbhNlnr34H2fu6+vTR+e4H6x8ArbiKsGjXADF1aoJ8I8OJz0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ooqMTNWWaw5jRUxmsM5Nvpd75gFWCz4d7ZaXB8OUFM=;
 b=YRdj+Og7lMgz3G26YQ+sx78rW63SzAZFQidvA2rUcBkjZdihEwZlv6JKcDo4SnFqqhaUA5nvIiV6WiAgqK9/MYZgEHtzsZsU3eytj9ZpjxrErzPPJENEKM69GGGZ9VcFad+VK//8VLv///RTUAVKlIVjNnJ63S99UkJ4h8ySjeY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4492.namprd13.prod.outlook.com (2603:10b6:610:64::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6; Tue, 2 Nov
 2021 22:42:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%8]) with mapi id 15.20.4669.010; Tue, 2 Nov 2021
 22:42:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/9] nfs: remove unused header <linux/pnfs_osd_xdr.h>
Thread-Topic: [PATCH 2/9] nfs: remove unused header <linux/pnfs_osd_xdr.h>
Thread-Index: AQHX0DVQ984FywqRDkeU7h4MdEH9Tqvw1XOA
Date:   Tue, 2 Nov 2021 22:42:38 +0000
Message-ID: <08d283fbedab1be09a9dd6cf5a296c6a465a9394.camel@hammerspace.com>
References: <20211102220203.940290-1-corbet@lwn.net>
         <20211102220203.940290-3-corbet@lwn.net>
In-Reply-To: <20211102220203.940290-3-corbet@lwn.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d39069b4-a313-47c7-cc1a-08d99e521294
x-ms-traffictypediagnostic: CH2PR13MB4492:
x-microsoft-antispam-prvs: <CH2PR13MB4492B845A433D1EC75D1820DB88B9@CH2PR13MB4492.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IB1Aaw0IGXBn2wv7UzwWReJW0CzuEEtSqxeWmOhIFu+6jLZLOS5LMFOrMan1Xyt6ISYBCcmlcOejfcaSdpjFPNfbq9WtpLsZEuDH2aHRHh22B65679kJJJWA5lWYd6AR3rWoKzcW0Ohk9hEL+W6T4p8/kPAbG50MR1ZWhZNKbqLLVWKgYAM0e0lgouCRDj70ytrDE07upsm1ULPlWMU6cPwYn1aAgiaARyY3ZVIFvLo3HhEP72bxyuk92h6esBiJ5QlsKY8F5BINAVAA8cMqhJhS/XVBm+Mn+wl80EMaQvGe4PFPl0zzqiU6H06gWIQ+xqRqICeCdmORzdrqLYQmkABdSAnv9PgqcFQpjxaS8i1bi4KsyBsZdnqPMOgSslQDBFHG+KSqxrQUvKweehpLsBIrnLsnFmWixMsRviY0S5EAg/eyGNnGqiPslPM8Yt2qSupo/C0w0/7GpRAnJOcrik1hKoSPxe2YbHrL7/w1HAOyTBnRe6UgH3KA8mweatVxoium3oGvCqFSyZ2wbZlcqnnL1g9IeQ8002v/muypKUHnVkCupvem4tJ/xDyftJxoNOwF1L3WAQxKavMGu+kyXwOr4d9DEd3wmhhtH2zYjTk+5RrtQHLMu06krwcujgR6p8HDo2NqRmcT1/dGiotUZxB8M/CwHh7Ui4ySwDiDX7tYHISFjNMgPrY+EGYAc3TQGxH9MM//kJV+MzXtKP/G3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(4326008)(6506007)(38100700002)(5660300002)(8676002)(86362001)(36756003)(6486002)(6512007)(4744005)(71200400001)(122000001)(2616005)(26005)(2906002)(66946007)(186003)(76116006)(38070700005)(66476007)(83380400001)(66556008)(64756008)(66446008)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnQ1K2pCYVI5NlYzUm9OUWExaHlsTXVZcTVhSGNNa203OEZua0FQQXhqQWVy?=
 =?utf-8?B?M1RrUmdYNUlkak5IaE9FWlRBQ0tHYWtwdXF5TzhSNVF3cG5reFpGUjBjNWZN?=
 =?utf-8?B?VFIvOTJGazl0Q09vYnZvMUNDOTRSRnBUL2ZRVTlIQ1YwNlI2L3VpL0lMMFR4?=
 =?utf-8?B?QjE4KzY4MWhmRkYwdnJVbTFxZ3dOL1hJTDhER2l0NzgvZUplR3c0TUs2bmJp?=
 =?utf-8?B?UkxHL0NmdHNIaW9hZzhNdm9KbG8wVmRiS2RiRjFWR0dLU1FVNmYybzE3UDRx?=
 =?utf-8?B?bE9WUUFTQU9ycnlWakszdDhYSUJJTVdjWWhFcDU3L0ZoWFgyWmpZZUM5cUVU?=
 =?utf-8?B?aDlNOGhuZVllR2VIcXlnaWFOK3pHRzRoM1kyQ3VZZXNWbFVhL1MwbjF6dGRU?=
 =?utf-8?B?SlV4c21wY3NnVk5BRW1yMTdidzV4QWl6b1I2UDlZeVpsR0k0SHlwUnU4dzJJ?=
 =?utf-8?B?YWwyc3hMSm0zanVSNzV6dDk2SmtrVnp4NnE3alNNcDNRS1N4cFZWZEVYbEl1?=
 =?utf-8?B?K1pWbGhHUlFPS1IwWUpEaXQySndmZ043dDArSWN4SWIyeTAvMGhkKys0eGpm?=
 =?utf-8?B?S1pTL0RuQ1hPcGd0U3NVYTIweHozYXl3T3UxaURhNWk5dzE2TFV2MjV3UlQ3?=
 =?utf-8?B?c3hoeHhJZWF6bUg5aUhsc2piYVk5b1JlbGRRY21mb0hOVjUyWEc5RzdGbTN0?=
 =?utf-8?B?RDA0MzI5dEdna29WK05ZWUduQUtZTjVuWG1zaVNxbUkxOVJLWXR2OGdLZDNE?=
 =?utf-8?B?c3lmZWxZa1VVbkUzMTJWMmNHb3RIdm1Sb2huZTFUV0NKNFVET1JRaGwwRnd1?=
 =?utf-8?B?bUF4bi9NTG84Z1Ryb24yRDkxMlB2UW5hRkxBc1UrV0c2ODlTUzlaQm1nN1RB?=
 =?utf-8?B?WTlQeGI1eTZlUFlYbzB2eG1Ya3F5UzF5TEUvM0JRNHlSN1BOQW1HTElJUlUw?=
 =?utf-8?B?RkZnVjg2RWYzMTBLLzZ5R1ljMUF6Q0R0cU1RdnliZENuRGVwUlFpdWhiTklx?=
 =?utf-8?B?YUlCTXVBVmw2K3krTlBHeXhZTVFycENLa2NFMnRXbGxqZDdBOW5HdFdhMWtR?=
 =?utf-8?B?TUJjNEw5U2p2dnFXU3kwMFpMM3ZUcGt5b3l6Qm5Sb25QdHRLaEkzaXk4bjQz?=
 =?utf-8?B?YVdZeWZwT1JrencrVm1xR2N4VFRIYWJrWVMvbWNHaXh6aGVDbEptSXlpTFda?=
 =?utf-8?B?TkRuU2tTNTU2dTdmVVFvRXNzd2hGVmFvSUh6ZlNpdXdiVHU2LzdxYTlaaDBJ?=
 =?utf-8?B?ZkorNTZmZHMySnZCTkZLSjk2YVVrNC94VkpIYUlUaVZqODdrVkJ0OVNDODVk?=
 =?utf-8?B?YmF4Qm1xaGpiUjNBcFdOSTduVHlzSW1PYjFPcFVFZ1J0WTJTKy80UEVjL2Ju?=
 =?utf-8?B?ajZOcnpDZE5FRWlNRDgxU21aUjhyam1YL3k1R1VvTjUwUjd1N2gzZ0E5VEVk?=
 =?utf-8?B?aHpIZFVtMHR5b1JOZi9yRnRIY0psbmhIMlE0UWlQUnplU3E5UlZvczFhOEJU?=
 =?utf-8?B?azVUWDJYSVgrbGFjaTNmTitJVFdHeXBuZnlyU3lMbW5mMXhoZE5ka0sxaVY2?=
 =?utf-8?B?TkxFY1VTbUxPRUVjR1dBdVRxbzBuTXJJRmtXTXhGY3h3Ym9DTTU5QUwwYlJL?=
 =?utf-8?B?dytRZTZBV29HdkVxOUZyd3ozbG1hdVkzVmtCYTU1akp3aXk2b3piMG1CUWVt?=
 =?utf-8?B?QTJTNTVMS0ZuclgySnYyTC92alByMFAyQW10UG1OT1NJRHNvRHhWU3hNU1lX?=
 =?utf-8?B?Q3ZNOE5RQlBCNlJpdTBMS3NHR3Q2b0VRZzdiQUdCS2hPZzJjVmZMQ3psS052?=
 =?utf-8?B?UEgyeVJ6ZHNzTzhwMWRJREVFK1IzNTRHSUpLcFpoQTh5dlpkRTN6YnhBSTh2?=
 =?utf-8?B?RElEMU05Rnd2VDlkQkhHUVZCQnJWZ2hBTEtXbS90TGtYUmZsQWo5dFZuR0pZ?=
 =?utf-8?B?YUNXNTVtMXRPeUFnZWZueGxPaFFielRvRXp2eFdja2t3TmZjMndaYTJlSHNJ?=
 =?utf-8?B?TTVBckZxZVRueTFxWENIQjcxNDN2ODdRVHZxMmtzSVdYd1RKYUErdjdOOEI4?=
 =?utf-8?B?emRTUWpJbVBvRHVKaGFDbkNPbk5NQ1lOY3JtREp1d3VSK3R0NjRyVGxQVFpC?=
 =?utf-8?B?VGtEcndBTGRUZm1tZmM5NVB1RmRmdVlPNnJQaFd0MG9jcFJrdEd5OXRic2I3?=
 =?utf-8?Q?v7WM3vq+xLtdWxIdEAdDgkk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <941EEC865608A8499C4D5CF003D2DDFB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39069b4-a313-47c7-cc1a-08d99e521294
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 22:42:38.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVEskcDCsjMDPxCGLCCxSL97YcqTPUgDIOQ/PVyMd8CLpFdw4tTvnnQZ7I4MxilKoC8K7h4tFq50ZUyFXkrSog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4492
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgSm9uLA0KDQpPbiBUdWUsIDIwMjEtMTEtMDIgYXQgMTY6MDEgLTA2MDAsIEpvbmF0aGFuIENv
cmJldCB3cm90ZToNCj4gQ29tbWl0IDE5ZmNhZTNkNGYyZGQgKCJzY3NpOiByZW1vdmUgdGhlIFND
U0kgT1NEIGxpYnJhcnkiKSBkZWxldGVkDQo+IHRoZSBsYXN0DQo+IGZpbGUgdGhhdCBpbmNsdWRl
ZCA8bGludXgvcG5mc19vc2RfeGRyLmg+IGJ1dCBsZWZ0IHRoYXQgZmlsZSBiZWhpbmQuwqANCj4g
SXQncw0KPiB1bnVzZWQsIGdldCByaWQgb2YgaXQgbm93Lg0KPiANCj4gQ2M6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBDYzogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiBDYzogQW5uYSBTY2h1bWFrZXIgPGFubmEuc2NodW1ha2Vy
QG5ldGFwcC5jb20+DQo+IENjOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQoNCkFyZSB5b3Ugc2VuZGlu
ZyB0aGlzIGRpcmVjdGx5IHRvIExpbnVzIG9yIGRvIHlvdSB3YW50IG1lIHRvIHRha2UgaXQNCnRo
cm91Z2ggdGhlIE5GUyBjbGllbnQgdHJlZT8gSSdtIGZpbmUgZWl0aGVyIHdheS4NCg0KPiANCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
