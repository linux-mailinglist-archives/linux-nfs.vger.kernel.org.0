Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1524BB866
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 12:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiBRLlL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 06:41:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiBRLlK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 06:41:10 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D10101F
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 03:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEcw3gnCiKKsg4kRYDfM99Rf8al5QHDUX9E6AgLrbJSKKRJP3OEDMTNqqIXBVFSH2CGT9T1JRBEBdM0EAZuPmu3d+oldAYUBmfwHrXSjungJYzMJQxfkIkvtjB6XNZcJGsUF6Mu/zhmNzvGNPbQS+cVn3qOw61idsq1vNrh45ETdCc1kvE+Qe/RFvJP0+iXeFp1pjJ3oiFlqvNuTKAsbWUNARWrLIrxjk/dvmTxvIImCfgacBoFBRe+kITakKIeg7DGSFfy8Vx6UW/jUFa0I5EXltUbRjdCldC23C3nDrw9/jHShSvy0lubKTBX1z412UIAfJfTfwEGXFNnzCUM1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2kY95teXFT8rdKIHpcyBbhHSq20OqnZbzYNVd0E7gg=;
 b=nfVTuDwIa27OWRWnK9bZ4AxJEV1cbQf7piAOUL8zQjdJPdyyQ7dv5uT2MPV1wzz61pa8tWgVMWZDQzlvMFmd9aiIJyjd5z/XjZCP/wxnFsiZPrgiHimj3oq/timvpWFLAzCkW4a4oqYSedrvuSyYzxdCA08Rm6snHfES8rtos2hZS2HHljPiSzQjUlhIczZNCWRe5QJCB8BVonh4dXgvqhCLddS/aqGBr6+wp3t45rJ8KaEkXemvNquXoVS8WQ46KI6pDamJoFOsQRzex1mCEmq0kMeEQMrBLCYGxG2lkbfbivFjS5ceL6XEtc8Ycs6U/RFjvC20kZW8OEWNPXpiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2kY95teXFT8rdKIHpcyBbhHSq20OqnZbzYNVd0E7gg=;
 b=Z4UNBUEs5b4uaguisE69EsP0xS7ea5j3dMttqQnR6Sa7MVJlECO/lb7534frTeXF2gPaOAdz1toLJjfO+Q2Yz/PkFDQk+tAKjJ4NHnK5wgdsf1Qp6Ggckn4DVNqJc9n1aA7qp/iK044k0DHUxuAVwereVJS5iEhnFgoDNQFfJxI=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BN6PR13MB1777.namprd13.prod.outlook.com (2603:10b6:404:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.12; Fri, 18 Feb
 2022 11:40:49 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9839:95f8:577f:b2b5]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9839:95f8:577f:b2b5%5]) with mapi id 15.20.5017.007; Fri, 18 Feb 2022
 11:40:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] NFS: Don't ask for readdirplus if files are being
 written to
Thread-Topic: [PATCH v4 5/5] NFS: Don't ask for readdirplus if files are being
 written to
Thread-Index: AQHYJE9Roye6ZVI4h0atlaOE5SPeHKyZMCAA
Date:   Fri, 18 Feb 2022 11:40:49 +0000
Message-ID: <a95cebfffb05a4d761f4c89db6bd126d74fad85c.camel@hammerspace.com>
References: <20220217223323.696173-1-trondmy@kernel.org>
         <20220217223323.696173-2-trondmy@kernel.org>
         <20220217223323.696173-3-trondmy@kernel.org>
         <20220217223323.696173-4-trondmy@kernel.org>
         <20220217223323.696173-5-trondmy@kernel.org>
         <20220217223323.696173-6-trondmy@kernel.org>
In-Reply-To: <20220217223323.696173-6-trondmy@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4acbb123-122a-4a23-a792-08d9f2d382cc
x-ms-traffictypediagnostic: BN6PR13MB1777:EE_
x-microsoft-antispam-prvs: <BN6PR13MB1777E11532BE91C2EB098AA2B8379@BN6PR13MB1777.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SpXzWHOAHQKJ1hNVXliiiqZwk3jvchs6JxpxHtkorEqjBLyeyb1mARwt2AVQc0bWhDegxcsH5j/PTTcYbz+wLLonOObgoZios9NPqkb0uG1An6kIC83OjanqUZt7jNmWiElpH/XHGW78O0lr38DPX+wSmyWpeNZjOu4PbYd1zl3yHiEh8fu0CaLxJhusFqjxB+pCRACvpnjj/0FFgbGCep0drPnD8fAzD+QO4mKdvx84+CIWdqS9uqup4eEetD803BY21G08HQDYYXAQtY8Q7FJcYp5yOgdd+B3LH0X2+q7LuvwIPNxLj1Ihc4zJH/0QDBDJKucqrd/72fTHD2wiY9LQekb9H30HR49ktWzuIlUNwtG2CBNraev3mJF6REtWAgZb24aPfPkpvOjielbgxFciOfUoaqzyPXPA7W1DnUF0g1CXMRSWFzljEFtGtz2FAsjyToYoDUmK8Ap5yc/VfDuo0s2YyArbjoxAFMl7mb8BEa3NKrPPB066HdXH3oD8yjH+OmtOAf9bpNBWa/MpW1fZAvzdlSzoH2W2xP5kz8PzeZNZKKyBscIBaBgswB1oMY20Seh3DewlhREBCIw7UaglUGXkpSrMEgDPK8c7WmlaEOKWDRjGB4nglAOVOWPr1NjTkbHcclfXkzv03IvsKSmQ5Fz/CelaeBoKqR3nyGksXftfq4T1Jic6VhMB/gkH/KCRg8TzVYR8Of7R89H6UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(186003)(26005)(6486002)(508600001)(316002)(6916009)(2616005)(71200400001)(36756003)(2906002)(6506007)(83380400001)(5660300002)(76116006)(66946007)(66556008)(91956017)(8936002)(86362001)(38100700002)(122000001)(66476007)(64756008)(66446008)(8676002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDdhdzJjUXVxVGM3TzZJRW5QWXNZbmdLekRiVXBOWE83OTl3N3JvU1VrRWoy?=
 =?utf-8?B?VUFnclg1VkFTa3MwRFFuU2dSMTJHYytsbVpuL2pJaWlzeStZN3RnS1k3U1Fs?=
 =?utf-8?B?K0NtNVErNG9HZ0lLOURjKzZJcWZCdVduUXRpYllkSnhOYkQxK0NLdjEyb1Vh?=
 =?utf-8?B?cTVVL2M2OElnQTZTcFM1WWtSWmpPbFhUUGsyV2M5TlJkWGhnV0ZtM25QNnh4?=
 =?utf-8?B?U1VadVRmSVZWdG8va0VicGtPTmF1NUJmbGdGdnJTck5yZHJHcmdWQzRXSGtP?=
 =?utf-8?B?SmdMTXNxd2hVV2JFWmNJNjhqYTgwNHFBRXVnV081WmhlWG92aElHS1ZSamNX?=
 =?utf-8?B?QVgwUUJaR2ZvM3puWk9kSjQ3NFNGeTN2RU9CN0k3VXJGZmpJcktqU2F1NE9M?=
 =?utf-8?B?TEFMZy9uWjRiSXBKaVc2djNDSHdidzhUR1c4MThjQ1VwcmJwR2VwQ01RYXlE?=
 =?utf-8?B?WlBXSk4wN1RSOVM1V0I1K1NFNlJjWTVkZHFoNFc3bWdmd1BaT3pkRnZ4YmtQ?=
 =?utf-8?B?T0sxWmxFTU9YRGtWRTNPUFRXOVI0SXdjZTJubXVTakpGUkVjM29KbndUZTJY?=
 =?utf-8?B?MGNHZlVISGpMQW53TXFVdzlWWEtTc0lKVDVEa3RBQytKUkw4ZDNjeVhHUUxq?=
 =?utf-8?B?ejY4MEN4WXRaaDk4ZDBXeDJDMm1lRkJHRE1YY3lJT2diaVhiZGllNHlJZ1ZU?=
 =?utf-8?B?ZU5Bb3BJUEx5eWxQbm1KUzFBUW9XZ3RPVmJzZm54RnBrZTA0REx3dnRPaUVz?=
 =?utf-8?B?RmFkZWlSVFAwMmN2VGV4WHZuS1d5aXU4L29jUGRGNWs1Z0I2dnB1enMvNGVl?=
 =?utf-8?B?RzlrVVA4YzZid1VKZnQrSEZnM3NpWmZpVUtKYzc0NXk1Y3BTa0c4bC82a0FI?=
 =?utf-8?B?dW1tTlpnYlFpb0s4bHFVMFRPQnVqMlNrY0Y0b3pCbkt1QnA5TnMrWkFrNWxK?=
 =?utf-8?B?VnRIUTdvcGhJZ09tOFIrVlJJMDJQL0ViNStoNTVOVzcveU1iV0J6N0lXaHVn?=
 =?utf-8?B?dzk3TWpCSXJ4dSsxb2oxZWxTakl6U1ZiQUU5REI0TnlXZ0k4OG9EL0oxUisx?=
 =?utf-8?B?Vlp6U29LSUVCTlpCa21Oc05KYXVJMmFNOVVFaS9EUGhOVmtUNFFzUTkzZ2RU?=
 =?utf-8?B?REMvMHkvMExOb1pvYnNUbzh4MnN1RXI3c0Fla3hJZWUyZVdGRFhxWXpGZmlE?=
 =?utf-8?B?bEpNTStaa3RxYkdCSEVqNExOeG44clh0WG9sRkhCbWRkRkRKUkxPYjgrTlI2?=
 =?utf-8?B?U0NYazJSVi9nUDdEakROdzFFMkJGQTRJRmk3N0lKR0RUckFrWVZpczladk5P?=
 =?utf-8?B?Ti9LMnlUeGtVcDgrUE9KL0psUWV4VmpLTXd1SS9IOXgyU3BRcmZmOCtyUzVm?=
 =?utf-8?B?VndSYmRpOVlUbGpkbm1DQWk5cVBqVm16ZDJ0Mit3TlQzTzEvWGxjcUN2UTE4?=
 =?utf-8?B?K1o0L2NnS0JGd3ZxdDBJZGFmaDhVdVhxVlVyMFgwQktYakdSc2dVMS9OenZz?=
 =?utf-8?B?eTBPaGtGZExlWjVBKzdYYk1TeVhLcGNxMFJ3ZzZRaFc0N2xPZ1BBM2RwTEZW?=
 =?utf-8?B?QzZ5NGtoUng1WGpNK1NkblNMbVV4REJSaEpVMTNUQ2NsUXIvQ0tCYUpjT2xW?=
 =?utf-8?B?ZUl6dFU4TndjK0ZBRXZFd0puV2EwZFJJYzlzZmxJNitKNUhYK1ROaTl5ejV1?=
 =?utf-8?B?VmJUSmRTbnlqc1N3SThtWjN0RHNha2JFSmNSeTNaU0VOUzNzNGJmeXZwV2pT?=
 =?utf-8?B?OUhVa3h4MzhxOWlRSUlMQ3NIbkZ5V0hRdDJYcFYzVmFzSDJMNlplYkNHTUhX?=
 =?utf-8?B?NWNweWdJaTd6VkkwWHp2bWhMUmhjRXB4M0NrYmJJdk9aSjl3MTBMWlhYd040?=
 =?utf-8?B?WG50OHJvV01jQnVSaWx2dkdpRnVPR0trcEM4RmRxVmdTWVRyWk4zYUViZndM?=
 =?utf-8?B?b2VTV1l2d1ZMRWxwRThTUmR2bHhMT3EwQktFK2ZwOEVSYXZWZDdNVUdaNWJ1?=
 =?utf-8?B?L3RSaURIWFMya04xRG1ySnEwdWd4L1JWUWRTbG04NFpmY2FsVUhQSnl1V0Nm?=
 =?utf-8?B?TUE4RXpXdWpFZ2p1a1NyVGtEbVpJdERqTmsvQ3owSFFNY3I0UkhiODRtbi9K?=
 =?utf-8?B?eG1tamdQcnptZzZwRHdheDlJWUdPcFhLTitoT1Vwd2ZmV2d3U1FCc2J2aHFl?=
 =?utf-8?Q?5qvdDWvror1JL3j+oW8vMvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <071816C39C93AE40AAAC46DACDCCA96B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acbb123-122a-4a23-a792-08d9f2d382cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 11:40:49.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0eqzQCXtUNFLCmViBQdHxdqBmLplhI+Qa9BCzOfEKm8K7H1p/OkWc/H26M18UHCfkJl8YzL0IbfXSdoxJm26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTE3IGF0IDE3OjMzIC0wNTAwLCB0cm9uZG15QGtlcm5lbC5vcmcgd3Jv
dGU6Cj4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tPgo+IAo+IElmIGEgZmlsZSBpcyBiZWluZyB3cml0dGVuIHRvLCB0aGVuIHJlYWRkaXJwbHVz
IGlzbid0IGdvaW5nIHRvIGhlbHAKPiB3aXRoCj4gcmV0cmlldmluZyBhdHRyaWJ1dGVzLCBzaW5j
ZSB3ZSB3aWxsIGhhdmUgdG8gZmx1c2ggb3V0IHdyaXRlcyBhbnl3YXkKPiBpbgo+IG9yZGVyIHRv
IHN5bmMgdGhlIG10aW1lL2N0aW1lLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVz
dCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4KPiAtLS0KPiDCoGZzL25mcy9pbm9k
ZS5jIHwgMTMgKysrKysrKystLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2lub2RlLmMgYi9mcy9u
ZnMvaW5vZGUuYwo+IGluZGV4IDFiZWY4MWY1MzczYS4uMDA1MDBjMzY5YzVmIDEwMDY0NAo+IC0t
LSBhL2ZzL25mcy9pbm9kZS5jCj4gKysrIGIvZnMvbmZzL2lub2RlLmMKPiBAQCAtODM3LDYgKzgz
Nyw3IEBAIGludCBuZnNfZ2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UKPiAqbW50X3VzZXJu
cywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsCj4gwqDCoMKgwqDCoMKgwqDCoGludCBlcnIgPSAw
Owo+IMKgwqDCoMKgwqDCoMKgwqBib29sIGZvcmNlX3N5bmMgPSBxdWVyeV9mbGFncyAmIEFUX1NU
QVRYX0ZPUkNFX1NZTkM7Cj4gwqDCoMKgwqDCoMKgwqDCoGJvb2wgZG9fdXBkYXRlID0gZmFsc2U7
Cj4gK8KgwqDCoMKgwqDCoMKgYm9vbCByZWNvcmRfY2FjaGUgPSAhbmZzX2hhdmVfd3JpdGViYWNr
cyhpbm9kZSk7CgpUaGVyZSBpcyBhIHNlY29uZCBjYXNlIHdoZXJlIHJlYWRkaXJwbHVzIHdvbid0
IGhlbHAgc3RhdCgpIHBlcmZvcm1hbmNlOgppZiB0aGUgdXNlciBoYXMgc3BlY2lmaWVkICdub2Fj
JyBvciBoYXMgb3RoZXJ3aXNlIHNldCB2YWx1ZXMgZm9yIHRoZQphY2Rpcm1heC9hY3JlZ21heCB0
aGF0IGFyZSB0b28gbG93LCB0aGVuIGNhY2hpbmcgYnJlYWtzIGRvd24uCgpBbHNvIGZpeGVkIGlu
IHRoZSB2ZXJzaW9uIGNvbW1pdHRlZCB0byAndGVzdGluZycuCgo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoHRyYWNlX25mc19nZXRhdHRyX2VudGVyKGlub2RlKTsKPiDCoAo+IEBAIC04NDUsNyArODQ2
LDggQEAgaW50IG5mc19nZXRhdHRyKHN0cnVjdCB1c2VyX25hbWVzcGFjZQo+ICptbnRfdXNlcm5z
LCBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBTVEFUWF9JTk8gfCBTVEFUWF9TSVpFIHwgU1RBVFhfQkxPQ0tT
Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlmICgocXVlcnlfZmxhZ3MgJiBBVF9TVEFUWF9ET05U
X1NZTkMpICYmICFmb3JjZV9zeW5jKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG5mc19yZWFkZGlycGx1c19wYXJlbnRfY2FjaGVfaGl0KHBhdGgtPmRlbnRyeSk7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZWNvcmRfY2FjaGUpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfcmVhZGRpcnBsdXNfcGFyZW50
X2NhY2hlX2hpdChwYXRoLQo+ID5kZW50cnkpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ290byBvdXRfbm9fcmV2YWxpZGF0ZTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4g
QEAgLTg5NCwxNyArODk2LDE4IEBAIGludCBuZnNfZ2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3Bh
Y2UKPiAqbW50X3VzZXJucywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsCj4gwqDCoMKgwqDCoMKg
wqDCoGlmIChyZXF1ZXN0X21hc2sgJiBTVEFUWF9CTE9DS1MpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBkb191cGRhdGUgfD0gY2FjaGVfdmFsaWRpdHkgJiBORlNfSU5PX0lOVkFM
SURfQkxPQ0tTOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKGRvX3VwZGF0ZSkgewo+ICvCoMKg
wqDCoMKgwqDCoGlmIChyZWNvcmRfY2FjaGUpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC8qIFVwZGF0ZSB0aGUgYXR0cmlidXRlIGNhY2hlICovCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmICghKHNlcnZlci0+ZmxhZ3MgJiBORlNfTU9VTlRfTk9BQykpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChkb191cGRhdGUgJiYgIShzZXJ2ZXIt
PmZsYWdzICYgTkZTX01PVU5UX05PQUMpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG5mc19yZWFkZGlycGx1c19wYXJlbnRfY2FjaGVfbWlzcyhwYXRo
LQo+ID5kZW50cnkpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19yZWFkZGly
cGx1c19wYXJlbnRfY2FjaGVfaGl0KHBhdGgtCj4gPmRlbnRyeSk7Cj4gK8KgwqDCoMKgwqDCoMKg
fQo+ICvCoMKgwqDCoMKgwqDCoGlmIChkb191cGRhdGUpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGVyciA9IF9fbmZzX3JldmFsaWRhdGVfaW5vZGUoc2VydmVyLCBpbm9kZSk7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+IC3CoMKgwqDC
oMKgwqDCoH0gZWxzZQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfcmVhZGRp
cnBsdXNfcGFyZW50X2NhY2hlX2hpdChwYXRoLT5kZW50cnkpOwo+ICvCoMKgwqDCoMKgwqDCoH0K
PiDCoG91dF9ub19yZXZhbGlkYXRlOgo+IMKgwqDCoMKgwqDCoMKgwqAvKiBPbmx5IHJldHVybiBh
dHRyaWJ1dGVzIHRoYXQgd2VyZSByZXZhbGlkYXRlZC4gKi8KPiDCoMKgwqDCoMKgwqDCoMKgc3Rh
dC0+cmVzdWx0X21hc2sgPSBuZnNfZ2V0X3ZhbGlkX2F0dHJtYXNrKGlub2RlKSB8Cj4gcmVxdWVz
dF9tYXNrOwoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
