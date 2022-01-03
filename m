Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6614B483815
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 21:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiACUvq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 15:51:46 -0500
Received: from mail-dm6nam11on2117.outbound.protection.outlook.com ([40.107.223.117]:58816
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbiACUvp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jan 2022 15:51:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWzjMZCOG5ZyFMb0QYQsZdtznVdy54N2CMMyxLjwAE5lyMM4up2U8a4ZTVpP9iNmpUB8Pwa4gI7jotJ4NauSviKogQ0MlNvYq+PjNf9kjmxBUuKMrxWvbviDr1bgR2fPLz5sAP/uE9pO4MW9tw/2Dn3/lQ2tab7f/4mHT4If9nMtV/GgkSzwvyw6tFyYiyNUBP6bgMUq7eu63xw88RJgTiQ8H68MkILtDjFTGf/IsCN6SEisHDdHORVd9loechUbRAIgSLvCSYs/cVXUxtFV3+WyKvieltXHjJNuj9GJc2jKk72N56YpIO79440n4PS6GdGit25b3va7orN8r8klzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSFJg5J6rFWJsUSBTMKOyr/fIad567mWxpViEBtfYIQ=;
 b=m45ebVtT90/SYNOXVQu3FH2cD68j8nYMneACumsu+OjvH8Tq7jEdNoRZvQfttiZFE4xqv+qazmMRf6PpG5+1FRJtnwPCl+lJql3V4iNM3GsZF1s8obeeF2SveMt5LZRARcVnc3ujBb8QuWk4McIfF2PI4li57LBYkwdr9H9+Z+GtSiG4bNE/B6M+pEd4hnZhGMPp8ZWH51OGyMfFFVSUIncAd+jMQVxmanHV+sHKE6qDvXVS7sa3VLKhLjysS4qtwyuSTn3ll9g2mbSre8dlFCypnUhtG2/QasXGHlfZK4++CSd5KiSFLBQX5IjCmUcSMsZUh/FFvkGPTnHRfSIqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSFJg5J6rFWJsUSBTMKOyr/fIad567mWxpViEBtfYIQ=;
 b=CwmxMjhVaU3OFjK60E5XzAn6jKNqPRcsAje8f4FIi06zidhgSjW0MyjShisn6YgllBIRX6iazvPvUJI6aQI+DDHVPuPUqNu2ZOTiWlLIdXR8cP/+CjCTcd43oLY81qbJ5hpdu+NJpsO9Yo/L5u5zJaCveMX8B7jaonZMxYnbSuI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5038.namprd13.prod.outlook.com (2603:10b6:806:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4; Mon, 3 Jan
 2022 20:51:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.006; Mon, 3 Jan 2022
 20:51:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHX84heTqWsdlviIkSCjyYpUqzp8qxR4CyAgAAAK4A=
Date:   Mon, 3 Jan 2022 20:51:41 +0000
Message-ID: <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
References: <20211217204854.439578-1-trondmy@kernel.org>
         <20220103205103.GI21514@fieldses.org>
In-Reply-To: <20220103205103.GI21514@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5934322-89e4-4a49-c780-08d9cefad87f
x-ms-traffictypediagnostic: SA1PR13MB5038:EE_
x-microsoft-antispam-prvs: <SA1PR13MB5038D874353D44F1BA82E041B8499@SA1PR13MB5038.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDFVby0XpGZ14AG+MyZdVWtHBtfd+gu5sSYBpZm4Qn2MQILoWcFaSjKrAveil0H3t1vwfEaFOx2n9hBNIGgOqd1YdK06bWy/THA1IdtsS98jTHIBMV8PbLtDh1v6qqKJrJ4ttyCePB8CRPYGlmy3zDhIBJb1oEXMx66fqP9pdnwb6HpzzwRk02EzuapA52HP7EuWVx3WU2k9xghYW413HbRpkNcnHQ3H3h9G/v+r7ReVXZ21RGCnvbu6vNZPhunXPIliQ0IVSdquCdQ+qoQH6AYyDV3A91BNJArhkiqk+zxtrDU4Z7zHSIgImPmDkb504UPaa4cZfqNGWvr1VcuydULZsTvWhNjaE7M1FtWw+rdq79fnskCsrRBnlgL9J4/xp3c0Fk8HzPALcoU4suzkVMB/0MVa9Ix0HhAUJziQv4aJw1OZROOZk2tzcUKJsVUiVGlMjPG49KBspmaHuH4XF4W/Rpt5e8bbVeHg3DXG9HCMcOtTbpN5b/YxRZCthIDENPjVKb3hktmvSAEqArDlRLRjpoxoNlx3tfdFl6CbSXuQpFPMg1M3wzXQUuAR+LoSae3MXPCh1o+0M+ybYXt343Xv09ZAQiVOwMMWYHayePtEDM0f+XV3Gt64b+YFe3dZQ80wSKhGn+JI1d6XCbBFtLj6BPhYYVaGSAnFW84QWmynS7TgqtI4L9uHHm3+cl14IDJhzPJPLu/tPOWKZPNvUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(396003)(366004)(346002)(376002)(136003)(54906003)(6486002)(76116006)(66556008)(316002)(64756008)(86362001)(110136005)(38100700002)(122000001)(2906002)(66476007)(66946007)(2616005)(5660300002)(4326008)(66446008)(26005)(38070700005)(508600001)(83380400001)(6506007)(8676002)(8936002)(36756003)(186003)(71200400001)(6512007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTRqQUEwQW1ISVk3cmRBRlBmZURqS1luNStjRXdxUGVGVWVpNStVWjNRNm5Z?=
 =?utf-8?B?dVZjN1hQSGx5WGdMa2FLSWh0alU1RGE1UGxIbjYrRU44N3BtWFp6UGh1dWlN?=
 =?utf-8?B?TG83Z1JVOWVqcjhhZ01Mb1FRTXVXRjcrZlU0QlkzWVZkb0ZPL010cXNEMTlS?=
 =?utf-8?B?OHY5aFZ1OWZDWWRmNWhvWjA4aklLQkpLc3RjS0IyWVlqK1NsS2thdDBBSTVF?=
 =?utf-8?B?bHhjRlNNMGtxN1NuMVBrVXU4ZzZxUlROOFgwY21tWG9jQ2pVZzBPVkUyWk1F?=
 =?utf-8?B?S1BZZHdRdnlKL3pqVERhSGl1NkIyaU9RMjhSTDBQTEFra0RXNnR4cnRZQ0lx?=
 =?utf-8?B?M2Y3QmZ3YnVrZGYreSs5Y3JxeU1OZTNlNjd3L1RYWENBd1BOdWZtaXpVdTd6?=
 =?utf-8?B?K0l1SlY1OVlmb1RYaFRCQWhiUCtSMWlIZXNrRWlrOWNUTU1NaityNTMyRWtl?=
 =?utf-8?B?TGRyYU5FcVNaNGZ2QVhGMC8ybnVUWGs5SExtelF0ZEl0cm1Bczh5WmhTMlR1?=
 =?utf-8?B?MGVZSFZrM0haMTBYR0RudmNZMG5yNVB3b0FOd29wZTQzQk5LRTY2dHVxWDF1?=
 =?utf-8?B?WnltbWNIU2JWaGlrODAvelArYnFIVWh4THpZdmNUVmZ5TjZQT3JrMVI4OUs3?=
 =?utf-8?B?c1h2WENXYllwQnJEL09aSlFVWXJMRjhIVTNIVDR3R3I5WXdaOWxBSnNtTURy?=
 =?utf-8?B?OFlLckxFY0lRZVZVUGRGK1dsVE9tZGRqVkdZaFE3WGtLd3ZHbHcxM003R2hK?=
 =?utf-8?B?MjllWXo0eHBRTktIU3dwd2wvNmRJWW9yZnhWbU5WYmd6MkZaeU9OVTRvcFk0?=
 =?utf-8?B?ZDQyOXNoKy9VUlZFQmFXb2dKK0xFUTgzUkJIeUxvZE5rR3JlSWpNdFRxYytE?=
 =?utf-8?B?ZDVFV3lQaXRnOTB4a2NlcHdPSm5JMktGMGVrblpleHZTNlk3a28raEZTeGpa?=
 =?utf-8?B?K0FFS0dvdUNpWlhPU3d2WGdPTFRMaitHSnMzUTdmOGRmdEsxK1FxZVNPWHFZ?=
 =?utf-8?B?bXNCS0FZN0lqVDZocm9Bb25wSmx1WTRKbE9LazVKdXB3TUs2eXBXNlh0RFlR?=
 =?utf-8?B?dWlJbjhGWkpIbFcrSk84em1XS1V0cnVkMjltZ09SeUhpOTNwc2dwOHUxNWJB?=
 =?utf-8?B?OHYrYzJZc1dmc05tTzNMV0l4Q1JIeU1LTm4xMmJmNHdLV20xNUhLM2dXWlQw?=
 =?utf-8?B?bmxnVzRLd2dmZGJNNjRkeEtHY3UrQ3gvMkU3eDAzaFBNbVFqSXFza1ora2I3?=
 =?utf-8?B?Y0JpY0hLUWlSK002UEpuNEl6ZUtiSFkyWE5wcHUxNmFQYnZSZHNnMllUQkN0?=
 =?utf-8?B?QnU4QmZlOWhNczJPNEs4bXlpcjNrWHRxUWN0VGpzSlg5S3dqWGZhT3pZcERQ?=
 =?utf-8?B?K1FMYWd0dFplMzhTbWVrdVpiRlFXUlZTa2d3V0ovSlQrM2E5TXBCTThtUUJ6?=
 =?utf-8?B?U2VtVFUxSGNKazEyc3dxcXNYaDc2R3J1UHAvL2lqZmVkN2h2TzlqS1BSd3FE?=
 =?utf-8?B?UFRYckdrb3prNFdTYXJCRUxIZEptbmp3aGtSdVNJaUpuY0tidUx6b0pJUXNH?=
 =?utf-8?B?dWR3OUpwdmFsVGhubHlXanpXdUFxRncvVi82dGdlR3NvakpLYjZER3ZZRkNu?=
 =?utf-8?B?QTV0M3FtYk1ScTRHakIrWkorVHNsMEpNeUpIcmNIanlpelh5b1hrLytRZTRV?=
 =?utf-8?B?VnBTVjE0ekdWemVFaVNud29pckZtdm41bVArUDZZbVN6cWRaRHd5ZjN1b3Ju?=
 =?utf-8?B?d3VvYkxabU5hSENDc3h1UDdxK2FmdDRSSXA0YUlWelZneDNRUU1pZ2hGZlIv?=
 =?utf-8?B?eHFIWmtlSVFyTGZzVyt5NHhvby9NamhBUllZeFE1bDNYY0FBTTh4cHlVUU1Z?=
 =?utf-8?B?TXdvd2RldjQ1RThEVkFZcFprbXZ1Zm4vUzhzUDFlK1VHdDJiVytDZEFrT0h1?=
 =?utf-8?B?YVoxbGZMcHJPVmJUejVmeitpd29Ka2tLNDR3Lzdpd2NEZjRJaC9oR3BEeWtD?=
 =?utf-8?B?YmlSTFpKcWEwalZVLzVkdlp0NVo2MVdJdENIRlc4WERTMFpLTTh3bkQ0ckox?=
 =?utf-8?B?bzJvNzJ5NFNHRllpMDlaVWd5NFJNZG40a2JjWEd1Q2IzTGhtdFFFWXgreHhR?=
 =?utf-8?B?SGlRRVd1eGdVajdDb2ZrN3V4NUY5U0ZKbzFkR0NwTldUMytheVhTV0M0YXB2?=
 =?utf-8?Q?YDmFOefWQ9dLf0OarsfT9Pk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <565912633AF2C7479553BE257D72B223@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5934322-89e4-4a49-c780-08d9cefad87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 20:51:41.6873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdUmZ8oXO/efPUqLHUuiptFw9mrkbqM0qvWFXEMkP0ouLTZYLlhkT1CW7h9cKzjmvwEv6f5OEhtS0XHbvxylMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5038
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTAzIGF0IDE1OjUxIC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDE3LCAyMDIxIGF0IDAzOjQ4OjQ2UE0gLTA1MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IE5GU3Y0IGhhcyBzdXBwb3J0IGZvciBhIG51
bWJlciBvZiBleHRyYSBhdHRyaWJ1dGVzIHRoYXQgYXJlIG9mDQo+ID4gaW50ZXJlc3QNCj4gPiB0
byBTYW1iYSB3aGVuIGl0IGlzIHVzZWQgdG8gcmUtZXhwb3J0IGEgZmlsZXN5c3RlbSB0byBXaW5k
b3dzDQo+ID4gY2xpZW50cy4NCj4gPiBBc2lkZSBmcm9tIHRoZSBidGltZSwgd2hpY2ggaXMgb2Yg
aW50ZXJlc3QgaW4gc3RhdHgoKSwgV2luZG93cw0KPiA+IGNsaWVudHMNCj4gPiBoYXZlIGFuIGlu
dGVyZXN0IGluIGRldGVybWluaW5nIHRoZSBzdGF0dXMgb2YgdGhlICdoaWRkZW4nLCBhbmQNCj4g
PiAnc3lzdGVtJw0KPiA+IGZsYWdzLg0KPiA+IEJhY2t1cCBwcm9ncmFtcyB3YW50IHRvIHJlYWQg
dGhlICdhcmNoaXZlJyBmbGFncyBhbmQgdGhlICd0aW1lDQo+ID4gYmFja3VwJw0KPiA+IGF0dHJp
YnV0ZS4NCj4gPiBGaW5hbGx5LCB0aGUgJ29mZmxpbmUnIGZsYWcgY2FuIHRlbGwgd2hldGhlciBv
ciBub3QgYSBmaWxlIG5lZWRzIHRvDQo+ID4gYmUNCj4gPiBzdGFnZWQgYnkgYW4gSFNNIHN5c3Rl
bSBiZWZvcmUgaXQgY2FuIGJlIHJlYWQgb3Igd3JpdHRlbiB0by4NCj4gPiANCj4gPiBUaGUgcGF0
Y2ggc2VyaWVzIGFsc28gYWRkcyBhbiBpb2N0bCgpIHRvIGFsbG93IHVzZXJzcGFjZSByZXRyaWV2
YWwNCj4gPiBhbmQNCj4gPiBzZXR0aW5nIG9mIHRoZXNlIGF0dHJpYnV0ZXMgd2hlcmUgYXBwcm9w
cmlhdGUuIEl0IGFsc28gYWRkcyBhbg0KPiA+IGlvY3RsKCkNCj4gPiB0byBhbGxvdyByZXRyaWV2
YWwgb2YgdGhlIHJhdyBORlN2NCBBQ0NFU1MgaW5mb3JtYXRpb24sIHRvIGFsbG93DQo+ID4gbW9y
ZQ0KPiA+IGZpbmUgZ3JhaW5lZCBkZXRlcm1pbmF0aW9uIG9mIHRoZSB1c2VyJ3MgYWNjZXNzIHJp
Z2h0cyB0byBhIGZpbGUgb3INCj4gPiBkaXJlY3RvcnkuIEFsbCBvZiB0aGlzIGluZm9ybWF0aW9u
IGlzIG9mIHVzZSBmb3IgU2FtYmEuDQo+IA0KPiBTYW1lIHF1ZXN0aW9uLCB3aGF0IGZpbGVzeXN0
ZW0gYW5kIHNlcnZlciBhcmUgeW91IHRlc3RpbmcgYWdhaW5zdD8NCj4gDQoNClNhbWUgYW5zd2Vy
Lg0KDQo+IC0tYi4NCj4gDQo+ID4gDQo+ID4gQW5uZSBNYXJpZSBNZXJyaXR0ICgzKToNCj4gPiDC
oCBuZnM6IEFkZCB0aW1lY3JlYXRlIHRvIG5mcyBpbm9kZQ0KPiA+IMKgIG5mczogQWRkICdhcmNo
aXZlJywgJ2hpZGRlbicgYW5kICdzeXN0ZW0nIGZpZWxkcyB0byBuZnMgaW5vZGUNCj4gPiDCoCBu
ZnM6IEFkZCAndGltZSBiYWNrdXAnIHRvIG5mcyBpbm9kZQ0KPiA+IA0KPiA+IFJpY2hhcmQgU2hh
cnBlICgxKToNCj4gPiDCoCBORlM6IFN1cHBvcnQgc3RhdHhfZ2V0IGFuZCBzdGF0eF9zZXQgaW9j
dGxzDQo+ID4gDQo+ID4gVHJvbmQgTXlrbGVidXN0ICg0KToNCj4gPiDCoCBORlM6IEV4cGFuZCB0
aGUgdHlwZSBvZiBuZnNfZmF0dHItPnZhbGlkDQo+ID4gwqAgTkZTOiBSZXR1cm4gdGhlIGZpbGUg
YnRpbWUgaW4gdGhlIHN0YXR4IHJlc3VsdHMgd2hlbiBhcHByb3ByaWF0ZQ0KPiA+IMKgIE5GU3Y0
OiBTdXBwb3J0IHRoZSBvZmZsaW5lIGJpdA0KPiA+IMKgIE5GU3Y0OiBBZGQgYW4gaW9jdGwgdG8g
YWxsb3cgcmV0cmlldmFsIG9mIHRoZSBORlMgcmF3IEFDQ0VTUyBtYXNrDQo+ID4gDQo+ID4gwqBm
cy9uZnMvZGlyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNzEgKystLS0NCj4gPiDC
oGZzL25mcy9nZXRyb290LmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArLQ0KPiA+IMKgZnMv
bmZzL2lub2RlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTQ3ICsrKysrKysrKy0NCj4gPiDC
oGZzL25mcy9pbnRlcm5hbC5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMTAgKw0KPiA+IMKgZnMvbmZz
L25mczNwcm9jLmPCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiA+IMKgZnMvbmZzL25mczRf
ZnMuaMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzEgKysrDQo+ID4gwqBmcy9uZnMvbmZzNGZpbGUu
Y8KgwqDCoMKgwqDCoMKgwqAgfCA1NTANCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+IMKgZnMvbmZzL25mczRwcm9jLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTc1
ICsrKysrKysrKysrLQ0KPiA+IMKgZnMvbmZzL25mczR0cmFjZS5owqDCoMKgwqDCoMKgwqAgfMKg
wqAgOCArLQ0KPiA+IMKgZnMvbmZzL25mczR4ZHIuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDI0MCAr
KysrKysrKysrKysrKystLQ0KPiA+IMKgZnMvbmZzL25mc3RyYWNlLmPCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDUgKw0KPiA+IMKgZnMvbmZzL25mc3RyYWNlLmjCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDkgKy0NCj4gPiDCoGZzL25mcy9wcm9jLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MSArDQo+ID4gwqBpbmNsdWRlL2xpbnV4L25mczQuaMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4g
wqBpbmNsdWRlL2xpbnV4L25mc19mcy5owqDCoMKgIHzCoCAxNSArKw0KPiA+IMKgaW5jbHVkZS9s
aW51eC9uZnNfZnNfc2IuaCB8wqDCoCAyICstDQo+ID4gwqBpbmNsdWRlL2xpbnV4L25mc194ZHIu
aMKgwqAgfMKgIDgwICsrKystLQ0KPiA+IMKgaW5jbHVkZS91YXBpL2xpbnV4L25mcy5owqAgfCAx
MDEgKysrKysrKw0KPiA+IMKgMTggZmlsZXMgY2hhbmdlZCwgMTM1NiBpbnNlcnRpb25zKCspLCA5
NCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLSANCj4gPiAyLjMzLjENCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
