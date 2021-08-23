Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667B03F4D0A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhHWPHN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 11:07:13 -0400
Received: from mail-bn1nam07on2100.outbound.protection.outlook.com ([40.107.212.100]:26241
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230386AbhHWPHM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Aug 2021 11:07:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjkdTsGl9lxOWMDvS17TZ7i4QhlHxcngUCM+fl0ZQlPUyH2dwlU9VDNHcXJQmO6AsfKEipNwi6NvpF+sL9j3G+wCb53XYEU4SahaCKbz3bijMrRx/VGfaSZ0sfVj/zZuwsVInZlajTgOMQBd6HQkFAQWgNH5RP63gjC9qOjCVfWOK4h6x7kk5UfuPCsHeBXMI4PARxLkNZ0RS0wr2fHQ45UK7EzoLGqbcHnfMA+A8oCod8C+benO2sq0/Qzt8ExDgRkjfEdQfGAaBf11ycOizRijSdXCE7oNCMYDTZEXNEOLTAwqmv/zAgifYHvJgTSY6OiMupZh1cwY0zJ6ecg2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysWEgj1j5Mmv3x4yErV0NfXzpWV3yeIvAPCPk2cROm4=;
 b=Bj5XIsV7aEM343KHBN2YOMtLsHqepwV6LQf9WM87fDiz9uAttjP648+u7a5V6qIRu/IR5eFIKUIPkJw4PlPSvPs7179t3DWI69ntbJh/4RVi2bNrZgiWYXEyojYhsu1f6LrR2Cnli8Qq5PAT3IVIEDDTEdWOI6zhpAnMr7dhDxl/Vy89E9d5XRY7+Ul0N8OS92DJpIgL0cVOgNkhNzzhzLEe/zFVUHhw9AfxERtB3JxLg3X94NVsD2vKfBAYoWwjqcPw3DM0Dja+9P5VjOAmhjTu+El3z7GmMrJAVcc8bi91QtGgTioWVWApZuiQRg5MM84UguG6kfAMYK0z9NOyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysWEgj1j5Mmv3x4yErV0NfXzpWV3yeIvAPCPk2cROm4=;
 b=d9XuDLvr3V7bJWYLUfXEbX40d8LaQIt9mBcUSYq7fG49SDCUmUPK0ilizTA3nd66j3neRQg3RN1RLFO+wGY+JEE+jyoa1T0zuGta0LS0YA/DhLjEC6d4e4+FLBf/sdf9gefHi8i/4X2oXdACU5ThLHtdTd9guOjB/nzXNm0ODLc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5155.namprd13.prod.outlook.com (2603:10b6:610:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.12; Mon, 23 Aug
 2021 15:06:21 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%7]) with mapi id 15.20.4457.016; Mon, 23 Aug 2021
 15:06:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: sporadic generic/154 failure
Thread-Topic: sporadic generic/154 failure
Thread-Index: AQHXmC3hbefhu0lewkmaSw4jUzp7IauBMH8A
Date:   Mon, 23 Aug 2021 15:06:21 +0000
Message-ID: <e3ea3f425fb8765d13e7b73aaf7df5022c4183e5.camel@hammerspace.com>
References: <20210823144802.GA883@fieldses.org>
In-Reply-To: <20210823144802.GA883@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e620f922-14be-4c0f-e01d-08d966479151
x-ms-traffictypediagnostic: CH0PR13MB5155:
x-microsoft-antispam-prvs: <CH0PR13MB515507AEC6F33CE4FCDF2C1BB8C49@CH0PR13MB5155.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/392yxh0tMEgCszx0tmjDhIU7wtMAPVJSWeVySOcpW4M+ARhS5PSBHVj0ysToqSMBXyFIk8lV7i22aN/a4X2KbRifC+TgLF1DMoeDEDI1Jbg3un7fyQtederBbZOpxt8nTPRbD/ovOkwqYVIP+ICQeLzLk21b3SqYQpAiygPF7J1Zcs50ORrwuZVL4dxf5mccYyPjoeVpOVZpYibUNHqPAcZSMWNkUwkUEKzONcXyo+jwE2WgCpO4EjA0qnEhuZVm5+V80kTMORrkbhXFOEfUZfTQWgjRrIBJCM2p8imvX6sCneVMaAjA37wSD2A/2L6J6EP/3Aqky3G8G2/6GJ+vYmJLFBnMvN2zD0y2U7BZqo6lvz06q+Zhncz1R5yQZWfwv0gbv2c/twu4Ir9Sg0UGWlCwXR2soLNWugEyRO/MK4LNkuzHPs+guPor7FJ9KcH1WxCtCxB1m68Sa32N6oWJTb+IjtbF2k0FMGkre7IKze9wqqHCoKaTsu5Tu+c8j4068xns8KX4g9Xcs1c0g8wPYAPXQoVimaJpzoyxJUsmjrU1DeIp6oRJGu7px30l0f3nJEgBVg0G1usaYu1vmrDGD8eppzzN+DsqQWC6KneT3hZgM3q2/AQi6w2x9XeY38euAO68UKk0ILJBe/qERJLi4jybGf7wIXMKMMvtaLAbSa+uPh+HvlmmF2BK8InjL12eusTKi1HaWouCC26ivQVTqHKiou9keKWrUUxPObIdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39830400003)(346002)(376002)(136003)(66446008)(38070700005)(316002)(38100700002)(110136005)(6486002)(64756008)(71200400001)(83380400001)(966005)(6506007)(36756003)(2616005)(76116006)(5660300002)(86362001)(186003)(26005)(8936002)(2906002)(6512007)(8676002)(66946007)(66556008)(122000001)(508600001)(66476007)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZlcll3RzlhaHZMNGlFcDZCRmd6K3FGRzQ1ZCtXcjBMSXkwVkN2OURIVEdM?=
 =?utf-8?B?bUZoeFlsVldGN2s5d0k5akt2TUhMbWNLVm0ra2V4SGE0Z3ZOVzB2eFJseTVv?=
 =?utf-8?B?Y2pQK012UHpHOURUUVdSc0FyRldtajVNSXVZaHFmdWtQeVlSdkpyL0ZiM3lj?=
 =?utf-8?B?R3ZoSEtFTHo1bFFtK01XbzRuL0lxYVlqcm8zUFBHbXJCdlk1eEduUGVzQis2?=
 =?utf-8?B?MlRCY3owY0Z2YVNzcU5CeFZkSHRSejlEOEpOdElzUXYzR1RUdENUSnpDbHpu?=
 =?utf-8?B?Vzdrc3NmSTZTdU1TK2M4V3FuQWVUbG1JR29aNEJPTWtSMkFBQ0p5SGhrMmZh?=
 =?utf-8?B?a091MW82dHJCMmcwTUI2MDcrRVhmWXJsMVZKVmxYdFF4RlBPenUzTHlGUU1w?=
 =?utf-8?B?NzFWQVFrRUlrS1Avc202NythOEZETVRObkNXdGU3bGZuek0yazZwNHIvWEM0?=
 =?utf-8?B?aENtYlRHWk94YVk0b3lEdEZDdVV3QjJZMEh5UDdmMHlRQzcyZ1h4bTVXSi9Z?=
 =?utf-8?B?cWFwZnBnVFp6eGJyemo2U3h2ZjhhVXNHRWo0UVlwaFNoRWVncVhvREl3WEVq?=
 =?utf-8?B?TEJOa21qdjQ0bXd2SkdtUHlmWmU0VlZUOFgxYnRxKzJEZVgyb0w3SFVjT3Bm?=
 =?utf-8?B?RkFRdmNtNWZKL0RRN29XOVFSTjNUMTNselZVMTdYUjlkUU16cnRaNzE4SGph?=
 =?utf-8?B?UUxxNFk0VFVjQ1ZnZk05a0VVRUxTTGl4S0hHNEFCeWZZRGg1NEhLdmkrUDB3?=
 =?utf-8?B?OVdYQnZwQit2THZOTEF1MFVYME9RejVRNWk1REkyWW5xZWRGU0dYYWxiM1Zq?=
 =?utf-8?B?MzRkOHFKM3RsamtwOWhGdk1lYjNrQVpHV0l2YnBwTVp1TVJTc1I1MlBoS3ZS?=
 =?utf-8?B?NmhCaXM5a2dZSUVCeVNxYjY2YnZobnk5dmQ0bDE0MUVTWXYrTHZiRDA2N2pT?=
 =?utf-8?B?OXlVYUhPQzVrcXhEL3N5SzVyVGtGaTNiQ3h3bG4xdWZ4K3BNNTZjUytRei9E?=
 =?utf-8?B?Z3hpKzZDQ1pLeTFEbzc2Q2lEdE9PUWJETE43VDV5SHJkOUttRU9IZEZrNHZR?=
 =?utf-8?B?VW5XZ04rTFRJajZWVXBwWndtMzJ5bnQxbWdvSXl1NnYvSGJFTG5TZVZibERP?=
 =?utf-8?B?eVV6L3Z1Sk0wSjMxSWZLQmlUeUNVeHZkVXlhRWx2dUMwbktMcEJnbit2TGNu?=
 =?utf-8?B?bDdPQjRMOUEyNWZIeExEY3JMNEwwNnJNWFhhRFJQZGtwRmF2NjdON0s1TURR?=
 =?utf-8?B?VUdxUS8xT0NkN01IWlhSaTJ2QS94aXhKVlRqbHdIdzZjektKVVFJOXB6S0lN?=
 =?utf-8?B?SzMwWHBQVlBEMlpiYWUra291Ukx2ZjQvTjRXOENpZXdDS2UrSi9zNUpza0Iw?=
 =?utf-8?B?R2ZHZ29hZUh4RnlhWW1wczE2VHV6bGFIeDJFYW1wam5TZCswelkzVEl4bURk?=
 =?utf-8?B?SHVqS0NIdlkrc0FMMm9VSWNpSkFwbTdVc01VM0Zxb1FmNDEzb3NQSlM0TFpm?=
 =?utf-8?B?RDhhUHhKL015Q2U5MlJnQ1dVM0tXNFhhOHJFTFk1U285cTF2NFhTS3ZhQm1Y?=
 =?utf-8?B?NkNhZG5kVVMwaE9ESjBHZnV3elUzeVpxNWpCeCtrYUhaejlLV2Q3cDdkMWl5?=
 =?utf-8?B?TmFKWklrVzROR1lRN3ErNHljOUIzTGFUWXBxT1J5bFoxZVRyVUlIOWhscHVX?=
 =?utf-8?B?THpEcTV5VW51eUpEOG5LbkNJbGQvSWprZWxHUFprcEZQT1N5MnNJV0Q0a3pp?=
 =?utf-8?Q?wmVh+mRNcbur8JXqxRUABFZohcm6yH3VglEjZV1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <56225ED15078D34E8F54DA55088063F0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e620f922-14be-4c0f-e01d-08d966479151
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 15:06:21.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijZeJGrb3tVmTlLhZLQGHsItUXOCvNs6+Sp6JPUAbzbzBBhV2Sp3QoOSVBYcndS4aRdd161fiXSgek+OkAE3nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5155
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTIzIGF0IDEwOjQ4IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IEknbSBzZWVpbmcgZ2VuZXJpYy8xNTQgZmFpbGluZyBzb21ldGltZXMuDQo+IA0KPiBJdCBk
b2VzIGEgImNwIC0tcmVmbGluayIgKHdoaWNoIHVzZXMgRklfQ0xPTkUsIHdoaWNoIHJlc3VsdHMg
aW4gYQ0KPiAtPnJlbWFwX2ZpbGVfcmFuZ2UgY2FsbCB0aGF0IE5GUyBtYXBzIHRvIHRoZSBDTE9O
RSBvcGVyYXRpb24pLCB0aGVuDQo+IG92ZXJ3cml0aW5nIHBhcnRzIG9mIHRoZSBmaXJlLCBhbmQg
Y2hlY2tpbmcgZnJlZSBibG9ja3MgKHdpdGggInN0YXQgLWYNCj4gL3BhdGggLWMgIiVmIikgYXQg
dmFyaW91cyBwb2ludHMsIGFuZCBmYWlsaW5nIHdoZW4gdGhlIG51bWJlciBvZiBmcmVlDQo+IGJs
b2NrcyBpcyBvdXRzaWRlIGFuIGV4cGVjdGVkIHJhbmdlLg0KPiANCj4gSSBkb24ndCBrbm93IGlm
IGl0IG1pZ2h0IGJlIHNvbWUgY2FjaGluZyBpc3N1ZSwgb3Igc29tZXRoaW5nIGFib3V0IGhvdw0K
PiBORlMgcmVwb3J0cyBmcmVlIGJsb2Nrcy4NCj4gDQo+IEhvbmVzdGx5IGl0IGxvb2tzIHVubGlr
ZWx5IHRvIGJlIGNyaXRpY2FsLCBzbyBmb3Igbm93IEknbSBpZ25vcmluZw0KPiBpdC4uLi4NCj4g
DQoNClhGUyBiYWNrZW5kPyBJdCBjb3VsZCBiZSBzcGVjdWxhdGl2ZSBwcmVhbGxvY2F0aW9uLiBU
aGUgZmFjdCB0aGF0IE5GUw0KY2FuIGRlZmVyIGNsb3NpbmcgdGhlIGZpbGUgKGVpdGhlciBkdWUg
dG8gZGVsZWdhdGlvbnMgb3IgZHVlIHRvIHRoZQ0KTkZTdjMgZmlsZSBjYWNoZSkgdHlwaWNhbGx5
IHJlc3VsdHMgaW4gaXQgdGFraW5nIGxvbmdlciBmb3IgWEZTIHRvIGZyZWUNCnVwIHRoZSBibG9j
a3MgaXQgcHJlYWxsb2NhdGVkLiBUaGF0IGFnYWluIG1lYW5zIGl0IHRha2VzIGxvbmdlciBmb3Ig
dGhlDQonc3BhY2UgdXNlZCcgdG8gc2V0dGxlIHRvIHRoZSBjb3JyZWN0IGZpbmFsIHZhbHVlLg0K
DQpodHRwczovL2xpbnV4LXhmcy5vc3Muc2dpLm5hcmtpdmUuY29tL2pqamZueUkxL2ZhcS14ZnMt
c3BlY3VsYXRpdmUtcHJlYWxsb2NhdGlvbg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
