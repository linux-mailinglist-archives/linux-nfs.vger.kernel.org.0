Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D842C942F
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 01:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgLAAqL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 19:46:11 -0500
Received: from mail-mw2nam12on2124.outbound.protection.outlook.com ([40.107.244.124]:18689
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbgLAAqL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 19:46:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY4sYOjpz/GPNavdEd8BcijeSFctb5uC5C8Nb5d13qSrOFFE4LJ1MiDauK/r8dryGf4fFwnUIYubxkBgJ7axn1xbvn20Mg89XQ17hTFpbsJikGk3QC4PhFLA1ELv28D1xLSEKDsFB3BLMEVmR0LjkbgIgpTMROnqZqf5qYX/9E5F+ai0tS1NTwuazcXSWBIaNsTjxh5S5+bg5cHwVThsWTPX4BLRrAiNPsjRav2q9FcmR2FLUhUfpL6Fe9u7SLZF+iAEtKP4grnIr+qEMVr5z4I9aVBnxakHUq0J14QJ13/zZ0cdwC7loTKl0y2LRgRera5MdB4qQX1Ayh5LlYrQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kacWUUa3Gw9mpDiPOb/rpkUf3oGh9au80bjFv2O7SMk=;
 b=FAtzzrPK0u33KoHbK+98bApTwPDDqw+4cm+4l4d39t7nfZLnMIvzRQJbszywu/dWkeYhgfoimu5X9defG74Myy5RSJATlOZb9/jM7JVZIHYJGrtgPuh0xzXmucTLsTXlbnfazDn73jVwZ0nyr007UrPTJSVILKsxgVcac5p1XAZp2c2WtQXohXQ7Dvx0eof14ujh15gWd0rvkrSSZSyKKM/vJN8tDdN3nsvt/Y67Rlm9bQdYyFMBi/yzvPvk52tKWp0KpDfWFfMQTOy+cJ1q0IUY1ssOot4RpXPbDjO33w48ZKjkO2To3xuDwCep14VKR/lkkSJcEZ9cDHXaPA8S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kacWUUa3Gw9mpDiPOb/rpkUf3oGh9au80bjFv2O7SMk=;
 b=UBjZ5h+iZMxb3c3VM0vF75XvvqdTWKqwgCMmrxcCfavHR3piBmGlS4sOc394bHAg+eJe3OCoYIWJWma/pKtEnICVk3Qu3HhLzgWHE4iPUSA46+8V4kfKXWbrpqBBL6hEUa8AkVaBdl6tWV/KJn1I1PSOtn4RRsnDc+TpePiVQKw=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3760.namprd13.prod.outlook.com (2603:10b6:208:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Tue, 1 Dec
 2020 00:45:16 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 00:45:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Topic: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Index: AQHWx1999UsH3Pym/kCB2OnbCNS3q6nhSfMAgAAdxAA=
Date:   Tue, 1 Dec 2020 00:45:16 +0000
Message-ID: <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <20201130212455.254469-2-trondmy@kernel.org>
         <20201130225842.GA22446@fieldses.org>
In-Reply-To: <20201130225842.GA22446@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56d00b03-8da9-4696-6dc1-08d895925ee1
x-ms-traffictypediagnostic: MN2PR13MB3760:
x-microsoft-antispam-prvs: <MN2PR13MB3760060FAA615B6D92D06523B8F40@MN2PR13MB3760.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHPK01/0/7Olymh/xnv95sHC5nLrsJ3dhCc+xEcpfC6P+Zo6QuMGsSAoYXMTM3RUgnoiniQL/PUPImIeLGLUFfq3UNMzxXmoMr08Gp8WUVHl4Q6QMXaP8pMYxl5DYjMQ+RumopHovfZF5GPui663Sz6p1TTl9KVEHya/GJceAGahFaoHd81pBTCJeUJOMiBTTsUYWIhOQsH7mMccb/lxmbrhD+N3dnbzlbh2ytUn9R5LI64XgUW8fMxxTVGEwvSvA3/3WwiB1+bixkR1bSAqhy7cwwih5EfjtfTHi/938fICOi/Ng2KazAIzeu5smaZ/y78u6zb9CaDBjzo3eN8q6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39840400004)(136003)(366004)(6506007)(478600001)(36756003)(86362001)(2906002)(8936002)(8676002)(316002)(2616005)(54906003)(6486002)(66446008)(26005)(66556008)(6512007)(4326008)(5660300002)(66946007)(66476007)(6916009)(71200400001)(64756008)(91956017)(186003)(76116006)(4001150100001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V3QxTGVPTXV0MXFVNXNOR2hWVC91L09CTlJzNC9TbHU2aE1IMXdiU0dzbXBm?=
 =?utf-8?B?SnNUVklBeXN2N0dpWDNXZXYveVVqSWMvd1hVOFRLY2JSbHg2MExoOWFGQzk5?=
 =?utf-8?B?VTJvYUcwb01pRndQRkppWHo5VE9IWHl3aDJSMm9LK1UzaVhGVi9oUnVZSkww?=
 =?utf-8?B?VDc3UXljdWpQUm9aMWd5UWdkZmJwOWttT0R5L0J0ZklKNnYwdENqcVVVai9a?=
 =?utf-8?B?LzJoZlcyemxFV1FMT1kwODAvUlRlQml4R0IyVkhYTDgzYkc0ekhlR0VoNHRo?=
 =?utf-8?B?b1d2YytVU2N1cDdLT2pINCtyUTFIN1kySTdpWUFuTTJRYTVvZ1I3Q2ZCeXJX?=
 =?utf-8?B?aTlqNmQ1c0s1dGxmbHl5MTIvZWlrRk9ua1g4NjhscXBVUmxJc3pxUjVuZ0dj?=
 =?utf-8?B?ZFhOZkdrWFJQYUQ4c2R2YWtCRFdvQlQ1OFd0SzdwRWxWWmQ5clRFN1pUaERX?=
 =?utf-8?B?NHpvVUdaelhSV3FNWDV6ZnZmb1Arc0cyM3A0NXVhWnFmSlh4K2JmM1lZQXA3?=
 =?utf-8?B?NVI0UTgxaUdzRlpXVTdxT3B5SUdCNG1OaXFpdXVDdFAyMllEeWIySkZ3ZExv?=
 =?utf-8?B?QzNPM09vdEs5WWx4VStJbi9IczVCVVhZYmRCUjhSREpzdTlPbUhsbk0vMkVN?=
 =?utf-8?B?Z25nbFU5a1BMbUhKRjZDVE1UUTBVUlRycFVTMlFRVmZyeitzOXpwVHJ1YmhM?=
 =?utf-8?B?Qys0Mm96THZSdVZIaHZKNnFWNnpZS1JMT2dpc2pLOVpveHFCeVRvSWxzdG5I?=
 =?utf-8?B?VDJ2SFNURlFuMk5hb3V3dEF0VjFkcmRyKzRMT3kzbWt2UVBrZ3JMYU9YSS93?=
 =?utf-8?B?TFVjam95dkRuNVZ0SXFTbWZldDA2eDUvYnNiQ2tRK2lGc0hFRDRYVGw2Ym5u?=
 =?utf-8?B?M2hiTHppWkRxRmpweEUxR21FSVRmcElFWnlTd2plbWR2cXJvcGRvMlptZFpJ?=
 =?utf-8?B?VC9TK3paUlc1YXpXUjRuZXgzSjdMQlVPRFFaQnB0QXM2NXEwVFZxOVdhZW8x?=
 =?utf-8?B?enIxczl3QlJMM1dUbWVhZFQzYkhiOTk2WTRBT0tpQS80ZGpuYk1OSFlGd2Qv?=
 =?utf-8?B?d2lydTNMZmY5TnNhZXBmR0MxZk5mdEsrQ3ZPU243RXVOOFpjTWc3b0pRM0ZU?=
 =?utf-8?B?VjU2ckVlekxGaUhsZFo2QWZsTmFQLytlK1J5S3V2NWFQUVo4aUJBT3VMWG83?=
 =?utf-8?B?M2lZSmg4K1RWU3hqQVluREI0MGNJd3E4ZTF0UGR1Zm1zKzlYcmxzRGVHZzhL?=
 =?utf-8?B?eUxjdHBYUDUwSXd6RzlYTkxpazk3UmQ0eU5BNGcxVkJwSVNiRE5YWDVoMUpT?=
 =?utf-8?Q?GTzXhAAj61leRiDh+6ku8EAMxZ8pK+rDpH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33D213047847CF4D80C498021FD9938C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d00b03-8da9-4696-6dc1-08d895925ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 00:45:16.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYiKSXulRKTRWqj5ZmF2k9ZXTM5I/cBee8ma68Ozn7SllOwPx0iu8e3I/d/JYXP+LmHvTV64T9l6DcTwuN3Efw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3760
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDE3OjU4IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IFRoaXMgaXMgZ3JlYXQsIHRoYW5rczoNCj4gDQo+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0
IDA0OjI0OjUwUE0gLTA1MDAsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTog
SmVmZiBMYXl0b24gPGplZmYubGF5dG9uQHByaW1hcnlkYXRhLmNvbT4NCj4gPiANCj4gPiBXaXRo
IE5GU3YzIG5mc2Qgd2lsbCBhbHdheXMgYXR0ZW1wdCB0byBzZW5kIGFsb25nIFdDQyBkYXRhIHRv
IHRoZQ0KPiA+IGNsaWVudC4gVGhpcyBnZW5lcmFsbHkgaW52b2x2ZXMgc2F2aW5nIG9mZiB0aGUg
aW4tY29yZSBpbm9kZQ0KPiA+IGluZm9ybWF0aW9uDQo+ID4gcHJpb3IgdG8gZG9pbmcgdGhlIG9w
ZXJhdGlvbiBvbiB0aGUgZ2l2ZW4gZmlsZWhhbmRsZSwgYW5kIHRoZW4NCj4gPiBpc3N1aW5nIGEN
Cj4gPiB2ZnNfZ2V0YXR0ciB0byBpdCBhZnRlciB0aGUgb3AuDQo+ID4gDQo+ID4gU29tZSBmaWxl
c3lzdGVtcyAocGFydGljdWxhcmx5IGNsdXN0ZXJlZCBvciBuZXR3b3JrZWQgb25lcykgaGF2ZSBh
bg0KPiA+IGV4cGVuc2l2ZSAtPmdldGF0dHIgaW5vZGUgb3BlcmF0aW9uLiBBdG9taWNpdGl5IGlz
IGFsc28gb2Z0ZW4NCj4gPiBkaWZmaWN1bHQNCj4gPiBvciBpbXBvc3NpYmxlIHRvIGd1YXJhbnRl
ZSBvbiBzdWNoIGZpbGVzeXN0ZW1zLiBGb3IgdGhvc2UsIHdlJ3JlDQo+ID4gYmVzdA0KPiA+IG9m
ZiBub3QgdHJ5aW5nIHRvIHByb3ZpZGUgV0NDIGluZm9ybWF0aW9uIHRvIHRoZSBjbGllbnQgYXQg
YWxsLCBhbmQNCj4gPiB0bw0KPiA+IHNpbXBseSBhbGxvdyBpdCB0byBwb2xsIGZvciB0aGF0IGlu
Zm9ybWF0aW9uIGFzIG5lZWRlZCB3aXRoIGENCj4gPiBHRVRBVFRSDQo+ID4gUlBDLg0KPiA+IA0K
PiA+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBmbGFncyBmaWVsZCB0byBzdHJ1Y3QgZXhwb3J0X29w
ZXJhdGlvbnMsIGFuZA0KPiA+IGRlZmluZXMgYSBuZXcgRVhQT1JUX09QX05PV0NDIGZsYWcgdGhh
dCBmaWxlc3lzdGVtcyBjYW4gdXNlIHRvDQo+ID4gaW5kaWNhdGUNCj4gPiB0aGF0IG5mc2Qgc2hv
dWxkIG5vdCBhdHRlbXB0IHRvIHByb3ZpZGUgV0NDIGluZm8gaW4gTkZTdjMgcmVwbGllcy4NCj4g
PiBJdA0KPiA+IGFsc28gYWRkcyBhIGJsdXJiIGFib3V0IHRoZSBuZXcgZmxhZ3MgZmllbGQgYW5k
IGZsYWcgdG8gdGhlDQo+ID4gZXhwb3J0aW5nDQo+ID4gZG9jdW1lbnRhdGlvbi4NCj4gDQo+IElu
IHRoZSB2NCBjYXNlIEkgdGhpbmsgaXQgc2hvdWxkIGFsc28gdHVybiBvZmYgdGhlICJhdG9taWMi
IGZsYWcgaW4NCj4gdGhlDQo+IGNoYW5nZV9pbmZvNCBzdHJ1Y3R1cmUgdGhhdCdzIHJldHVybmVk
IGJ5IHNvbWUgb3BlcmF0aW9ucy4NCj4gDQoNClRvIGFuc3dlciB0aGlzIGNvbW1lbnQgKHdoaWNo
IEkgbWlzc2VkIGVhcmxpZXIpOiBJIGRvbid0IGtub3cgdGhhdCB3ZQ0KY2FuIHR1cm4gb2ZmIFdD
QyBmb3IgTkZTdjQuIFRoZSBHRVRBVFRSIGlzIGEgY29tcGxldGVseSBzZXBhcmF0ZQ0Kb3BlcmF0
aW9uLCBzbyB0aGUgc2VydmVyIHdvdWxkIGhhdmUgdG8gc2Vjb25kLWd1ZXNzIHdoYXQgdGhlIGNs
aWVudA0KbmVlZHMgaXQgZm9yIGluIG9yZGVyIHRvIG9wdGltaXNlIGl0IGF3YXkuDQoNClRoYXQg
aXMgd2h5IHRoaXMgcGF0Y2ggaXMgbGFiZWxsZWQgYXMgYmVpbmcgYW4gb3B0aW1pc2F0aW9uIGZv
ciBORlN2Mw0Kb25seSBpbiB0aGUgY29tbWVudHMgYWJvdmUuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
