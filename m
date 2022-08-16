Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48B595D79
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 15:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiHPNgt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiHPNgr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 09:36:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDFA66125
        for <linux-nfs@vger.kernel.org>; Tue, 16 Aug 2022 06:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaORYq7PZ+6YODMRQ+ype9S4PCJhGuSXVfDTdZYBL8gqDkJ9vOEqkrgByCzxmmSRTpwF2TQdpdPYaYanSULt4tYQ+UIWZaIBStn7HUyTgC/d0nAAlMSu/NrEt0Xzl+kskQwDkk68efNFKP9ZqmVb/bXbEYUEqzsWtZgIlyvBWTnkkASNqK40hlO16sc1GrcbUIRn7IxZOMCiNHwpTEDqycx+xYQkOu5/wruIPE6kaYefx8gOKnD4Mj2/XWgo0/mxBXQFjGAgj5tYi3uHIEtM2VwTrPvSjgNve/1sYk5rC7L3FzVfqCCwFtWJDNa0hESxFrNTrK8IyV5zR+dyiV/agQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqTmit6/Gwm0vux1fLTNVf70I7Ptk9MSyhuVSyXPIok=;
 b=WlBCZf/G7SwG2X9cbG35WuAR+fqR/ecN+kKWZiUUnc4pCzUAcT/VkcGrSa3uijlQVq4YT57yjbX16QSBASGYlzHTsZusJrlUqs0DLcsmf5ZWFPwIrRUS2RHh6FeGk4wNxZstqda+DWlRqnmur8XRKw/DaG5r0B1OAj+ZLOLelz7m0woMw+BJRGDswGUQkbqxI/qv0XuOwlSs9bqGGdQLQRfaN7pzgbb0ON1rVQurX76w/iahWH0teUolZNsunCyxPLfEQlI1uMrONgfVPnAWBFYgvvSHuPJ4kg5GntRFT5McGInTpPFaGMMymLe3jfPH3UYAMnduPTQIdNchWITbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqTmit6/Gwm0vux1fLTNVf70I7Ptk9MSyhuVSyXPIok=;
 b=bHib9pG4exWV2l2WxHt5jHtvXkjrPnrZwiQjkF0B8+UxSJJ8EPUcRNKvLYHP9Hv0OBx4Nf0wDfop3nH6DZ+a3Aze2TF2iYAFLh/MRJZbs2MWOZ1XV51BtUt3a7Dtj2QU9Y1YcJciRgsWcfcdmvBeI/Gy3VeaFUa1tFRKhhOzLcw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4767.namprd13.prod.outlook.com (2603:10b6:5:3b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Tue, 16 Aug
 2022 13:36:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5546.014; Tue, 16 Aug 2022
 13:36:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: Thoughts on mount option to configure client lease renewal time.
Thread-Topic: Thoughts on mount option to configure client lease renewal time.
Thread-Index: AQHYsRznZwAN4fzePUaLFPOYoWLddK2xiDWA
Date:   Tue, 16 Aug 2022 13:36:43 +0000
Message-ID: <e75a36e0a8d6a3df74e0083b91babde01fefb6f5.camel@hammerspace.com>
References: <166060650771.5425.13177692519730215643@noble.neil.brown.name>
In-Reply-To: <166060650771.5425.13177692519730215643@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0a5951c-1abe-4166-503a-08da7f8c5b5a
x-ms-traffictypediagnostic: DS7PR13MB4767:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPPPugsFD/N4dauZE6k46lpPbyZA9tHsTlNqvwFYzoLOOduQUIvPVAsmbDz5OcirCNqeyzqok9SdtrLNvGq8wRG5BWmOh2M1BK1Q6EwTx6BOsh4qqHGiKnADVgQswYa6bebOTzzZXEZJc9stS5lR4R+PWj5hkqhVwMh+HGWLSMU8ctoO+NLj2INWplgelefD0SVEcwea11bVx1+dN1BwEEgv6FeYaHibvaeH3DkQyj2+uAIqZ5GZNozELw116dJhQaDw3LZEBgLujaPO1za4+B23XfhvkClb8ioOr064PZsJ/VIVX+0lNi0RzBFdTQDWHRqFDDvh5jBGjp9N5sm2LXKq0zZBk4cPM+WJ/6BXnChk8d0YZwOlBTtpTTrvLgZw9ejg7pNF0mM7ujBFjRThPOs1q0HiVZsDTH27mRXtTAgP2xN12i4z6u1qX9/hGWpfm71DQjQX1jHOEAH5MrlxFafpEde6Sn+Y6lycD0PKh6hk1QCwrWa3yWvfQaIdDwwg7c6S67xNaI5onf6mosSjDgn/UEImRcxcKiSysSwcQGVnoCarn0T69/hTjYpfS47S4TM3G9VipT10tfVYycFSfWMBa2tLSbtMlUieqSKkFL6YMTfjIbnwfA07XNxry9tf07N9wOooqOACKOFoaVJ72nwWKESeNGX7ymDM/14ko7gEothSIhEzbbZv252qRZpf6jEXrxx8D/tSHsewxNo+Ell9EPfpIub93kV78TnNMFlEIbtZK46D2rss18PFFC2gAwuDzmtrLGH/FNSGPoZ84mL7iCcW/aspA9otJxDURsrwkL8EsH532HlJ/N8nkG0PT6AtBYrXsWMvnmahLhZ5LndgwgtyvvVdxqRhHjVNIEg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39840400004)(376002)(136003)(346002)(366004)(5660300002)(38070700005)(2906002)(86362001)(122000001)(38100700002)(6486002)(478600001)(6506007)(8676002)(6512007)(71200400001)(26005)(66946007)(66556008)(186003)(66446008)(64756008)(41300700001)(76116006)(8936002)(66476007)(2616005)(36756003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2dqUFJ0cjBHdlMwWHlYa0NobC9XR3ZjY3R0Q0NGTjN0THZONE85TmU1VVF1?=
 =?utf-8?B?QnlsQ1VsdXprZ1ovWkZyR1BpeGZUa0xxRTVSOGZMY2x4RlRzb0ZuMld4NUYw?=
 =?utf-8?B?dWFhUkQxVFdXeEJ3bmdtVkE0cGJ1bEpzc01JV042QXFYM0tjaFc4OVlMVFRt?=
 =?utf-8?B?UXpHejliZmNlTmUvZjNHNmZabXRkWGpjZ0ZGRjZwaWYzN2tObzlQMVdDbXAz?=
 =?utf-8?B?b1FUQzQ5bTVvcEJsRk9Ic1ZwUm5hSnMvNzc2OGN6UTk2Nk00eUZoTFJJcy93?=
 =?utf-8?B?QmZIZDdPelBGOS9FM2VXVmFpTENwNE1yTmIzRXR0ZTJZQWR4cDVjK0d1SE0y?=
 =?utf-8?B?SEJ2MSthQmxxWHdUTU85VThzc2EzT01VNHI1QzV2aUVMN0wvTW1sVFpDbFVV?=
 =?utf-8?B?Q2UvWjVaSG5hVDNKbExYU1psZ2ZCeW9Xa3ZkMitKYVpUQXVlS1F4NkdVSGg3?=
 =?utf-8?B?andmNHcxaURRZ1lLUmVtQW91dG1YN1VBUmdaSEpPRXhYaHI2b2dFWllPQUpK?=
 =?utf-8?B?bzBWenRsdDZmaU1obUlQZU85TEVKVE9DVHdCb2NFY0JYbjd4cEhwL3JraFhJ?=
 =?utf-8?B?SmFObklwZnY0NjFZejJPMFdLYzgyTGNlSklXWGVGdTM1QlVUZ2kwRnMvRlRS?=
 =?utf-8?B?djNiSElWUDJlSk8wa2VOWlNOZFFIRmY4dHRYU0lMSWVUTEwzWk9obDJXUDR4?=
 =?utf-8?B?L3djN2xKbzdCTTlSbnlhNVE0KzRYK0VVcnFxMXExK01UbndOR1R5WExKTFM4?=
 =?utf-8?B?UzlzcExhZTd5U0twMmhwSWptdVpMUVMwMnFqSnlJMXd2Y085NHd1VHdKOVVF?=
 =?utf-8?B?dUVYakN0K0FNSXlhb0pkR0FidHJyZVpzVFNlTFUxWGVsNVdlRUVDY3pnWS9s?=
 =?utf-8?B?U1pRUWdHMHFOSmNoVXJXcDcrQ3lRL1A1aG44VFJ4N0xncG96MStKMStSazJl?=
 =?utf-8?B?em1mM3VTTmUxRGZ1c25aUVZaQWRwZUdqZjhmTWdtaURkWmV6SHoyTmRISVg2?=
 =?utf-8?B?bEcxQ0o0ckJQZ3RPQkZLS3JvbngrSVJ0d1ZHOGtlUlBRZGg1WWl6ai85ZFdH?=
 =?utf-8?B?NFltRnFsS0ZPRkpGRHFBZEF6WEU4SzlJRW5obXg1c0V6bFg1MStpTlFYclYx?=
 =?utf-8?B?clNzUEZTWHZyM1p1eDBScmF6Y2cvZUJHbXhGcTU2SVVic3VIYWVWOEQ1SmZ4?=
 =?utf-8?B?WkdlNHlKVDZPaXJRRmRtc1FLWEM5ZVZ6K2FpN1N0VTJycmRmTXgrUTVpdzRm?=
 =?utf-8?B?VUdrNEhCMHh0Z1lydHE1NGtOdHJ1eGxFcXFHa0NKOHhlQklaLzdnc1RqLzhk?=
 =?utf-8?B?Sk9RdjZKQnVtbnJITitrVWJpNGp4NlBoMVdlR2poRlpMdWc0WUV3TXR5Rk5V?=
 =?utf-8?B?UFZQWXRPOTFHWk81VE83R1MzSWRwd2lDN3BnVFRMdFBibVpSMjRjRnhEY0pW?=
 =?utf-8?B?SllqZ01WSXo5LzZQL0tDbTFLTXBNYTNkaHRIUkRNdG1lL01ibUFSRVR3L25r?=
 =?utf-8?B?REcxd3U1Wm5aSExCM2pENGhkYUl6TStBUFpleDNaWE5wT3RXc1JIRXRBMStz?=
 =?utf-8?B?OFcxTHg1RVFySEVyNXhyVTRnZVpJN3BSQTNtS2xMY29vYXliSDFBcFkwRklz?=
 =?utf-8?B?amZtNGlnUy9yUGZhUmtqeXgwdjNQV2FpUHh5VVBRQ1VJNitCbkVRYWlVMjdL?=
 =?utf-8?B?LzZnaHZPV1BGc1I4UFV2MldGSFo1OVM1VHdmRU9OT3dKVE1tR3RocURRUXJB?=
 =?utf-8?B?OHBjMVFFSGZKQi9QZGRONmtncFdNQ1pjb1B1N1F1RWxqZ01qdjNwamw0TFhH?=
 =?utf-8?B?Z0pUOHhuYkdzSFJVK0tIVVFMNkJzN1orT1ZINXhGSVdGV1AzaHlSenJhZnpw?=
 =?utf-8?B?UWZRU2ZjNzErRkU5KzJmYmxXV21jbVpYZFVkYXg1MWNYTzhZa3ROOHgxUERV?=
 =?utf-8?B?QTRqbjVLMGN2dTZVeXdWRUNXd3U3a0NyVitheVZRc2ZQV2xVOFBsOUNzZWxK?=
 =?utf-8?B?djZCZDJPekFaanV6SVl1amUwUWZxV2M4OXFRdytVTmMwdHVSRWU2TDhzQ3Vi?=
 =?utf-8?B?aC9WZHppb0hJNTgzS21COE1UNThRYzZ1eHorVm4veGRUM0t3R1NrRlBDUnV6?=
 =?utf-8?B?WjQ3SFVrY0ZhWVRHa3NHSFUxTTQvSHNRSVVsNjl4UmxYdTVrYVh6WU5PU2Vv?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C5AE4CCCC35BD4781CF9050A9575752@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a5951c-1abe-4166-503a-08da7f8c5b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 13:36:43.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2uOgRnrBVq0EHcxn15km65hmWceNI1pivCBI6zx83zPGylfeQ9+aZLHZqRmFCXUkGT8dPEPWpSvPDm/U5kU1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTE2IGF0IDA5OjM1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBDdXJyZW50bHkgdGhlIExpbnV4IE5GUyByZW5ld3MgbGVhc2VzIGF0IDIvMyBvZiB0aGUgbGVh
c2UgdGltZQ0KPiBhZHZpc2VkDQo+IGJ5IHRoZSBzZXJ2ZXIuDQo+IFNvbWUgc2VydmVyIHZlbmRv
cnMgKE5vdCBFeGFjdGx5IFRhcmdldGluZyBBbnkgUGFydGljdWxhciBQYXJ0eSkNCj4gcmVjb21t
ZW5kIHZlcnkgc2hvcnQgbGVhc2UgdGltZXMgLSBhcyBzaG9ydCBhIDUgc2Vjb25kcyBpbiBmYWls
LW92ZXINCj4gY29uZmlndXJhdGlvbnMuwqAgVGhpcyBtZWFucyAxLjcgc2Vjb25kcyBvZiBqaXR0
ZXIgaW4gYW55IHBhcnQgb2YgdGhlDQo+IHN5c3RlbSBjYW4gcmVzdWx0IGluIGxlYXNlcyBiZWlu
ZyBsb3N0IC0gYnV0IGl0IGRvZXMgYWNoaWV2ZSBmYXN0DQo+IGZhaWwtb3Zlci4gDQo+IA0KPiBJ
ZiB3ZSBjb3VsZCBjb25maWd1cmUgYSA1IHNlY29uZCBsZWFzZS1yZW5ld2FsIG9uIHRoZSBjbGll
bnQsIGJ1dA0KPiBsZWF2ZQ0KPiBhIDYwIHNlY29uZCBsZWFzZSB0aW1lIG9uIHRoZSBzZXJ2ZXIs
IHRoZW4gd2UgY291bGQgZ2V0IHRoZSBiZXN0IG9mDQo+IGJvdGgNCj4gd29ybGRzLsKgIEZhaWxv
dmVyIHdvdWxkIGhhcHBlbiBxdWlja2x5LCBidXQgeW91IHdvdWxkIG5lZWQgYSBtdWNoDQo+IGxv
bmdlcg0KPiBsb2FkIHNwaWtlIG9yIG5ldHdvcmsgcGFydGl0aW9uIHRvIGNhdXNlIHRoZSBsb3Nz
IG9mIGxlYXNlcy4NCj4gDQo+IEFzIHY0LjEgY2FuIGVuZCB0aGUgZ3JhY2UgcGVyaW9kIGVhcmx5
IG9uY2UgZXZlcnlvbmUgY2hlY2tzIGluLCBhDQo+IGxhcmdlDQo+IGdyYWNlIHBlcmlvZCAod2hp
Y2ggaXMgbmVlZGVkIGZvciBhIGxhcmdlIGxlYXNlIHRpbWUpIHdvdWxkIHJhcmVseSBiZQ0KPiBh
DQo+IHByb2JsZW0uDQo+IA0KPiBTbyBteSB0aG91Z2h0IGlzIHRvIGFkZCBhIG1vdW50IG9wdGlv
biAibGVhc2UtcmVuZXc9NSIgZm9yIHY0LjErDQo+IG1vdW50cy4NCj4gVGhlIGNsaWVudHMgdGhl
biB1c2VzIHRoYXQgbnVtYmVyIHByb3ZpZGluZyBpdCBpcyBsZXNzIHRoYW4gMi8zIG9mDQo+IHRo
ZQ0KPiBzZXJ2ZXItZGVjbGFyZWQgbGVhc2UgdGltZS4NCj4gDQo+IFdoYXQgZG8gcGVvcGxlIHRo
aW5rIG9mIHRoaXM/wqAgSXMgdGhlcmUgYSBiZXR0ZXIgc29sdXRpb24sIG9yIGENCj4gcHJvYmxl
bQ0KPiB3aXRoIHRoaXMgb25lPw0KPiANCj4gTmVpbEJyb3duDQo+IMKgDQoNCkkgZG9uJ3Qgc2Vl
IGhvdyB0aGUgTkZTIGNsaWVudCBjYW4gZXZlciBndWFyYW50ZWUgYSA1IHNlY29uZCBsZWFzZQ0K
cmVuZXdhbCB0aW1lLCBzbyBhcyBmYXIgYXMgSSdtIGNvbmNlcm5lZCwgdGhpcyBpcyBub3QgYSBw
cm9ibGVtIHdlIG5lZWQNCnRvIHNvbHZlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
