Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9F4DA0AF
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350337AbiCORBY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350326AbiCORBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 13:01:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C07857B3B
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 10:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIkT1lKJmrX+c0ejawqvJqejZajMoBYAdEEvkYQQwWPHxFVyd497Pk5RIoA5IGuw+/TMMQd/4z8gc1LE+alH42fdL28Dq9ppqzwc1407ZrB0Ljgk5wutCgLtzbXSGwc5WV8Ku/nMz0ubWB9jo3OH+S5QgwAtZFu12IFCW6WrKXgwcFYY4GqezkBwx1cdTt0qe40O6QFDDFmeMRDpz5Pu3TtcmQfZIzilp+oJXsqBldHLB3tsfCBzHY1R5+dr1qC9vuVmKZXcUBkP4RWMEmApzXtmhbYbqOopYhklpudBU+6deT1QL5LPnF8eQyofjxGBveS1eNZKm9aM8j/VOJa6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh7aZgNtcbNYDLDctczTqz1/qzz2KfdGSM8yZZ16K5U=;
 b=Ug1mr/ZqGdYqCIsqjji5kF4CSqstINya+H14iT0L/eitTZ7n7ydz5NcbqH6Cezrbsax9jpVvSZk8Yjywy+LeCTdOjTwiJSeq+DpWwaOOS/zUYwAIy8WtScDbYG/tfmwa31wC4/GZJVsVDl/tmG5Q4HnRp5di9ql7a/IPlfXfYr2MeCKJF44nQ5o4m0S2t/5OUDBAQqLjz47YwdM9+F4i14Vb15UdZTip3+Wch+IqYglfPjjhH9PNtQhGSQnHk32T3bTSH2g5mQvBMVg3NngE8rK19eOJDw0cyCZZGWrmzu3dBanma7akQjSsewvffMuxRO+J9+bYRSyooVnXLLx6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh7aZgNtcbNYDLDctczTqz1/qzz2KfdGSM8yZZ16K5U=;
 b=WcCPkV4hrYrEh3dlDh1/XRUCF7I/K3Lv3+jMoqwyanFTmFRFakn626ONegtC8gM6h2LBTVx/gc6PiJPwTQnvOuo//+Pfidmf+stFdPPpv9XZ60MaAoD1tSw44DJGKsrkXXtQlHtXpkwpEJOd1U5tXaPoyDGldNstTLGWnVZBrfQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB0931.namprd13.prod.outlook.com (2603:10b6:404:1c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 17:00:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 17:00:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix memory allocation in rpc_malloc()
Thread-Topic: [PATCH] NFS: Fix memory allocation in rpc_malloc()
Thread-Index: AQHYOImPM+V+a1AQSkC9Wjhr9k+IAKzAqG6AgAACvAA=
Date:   Tue, 15 Mar 2022 17:00:07 +0000
Message-ID: <28c7dd1e84d3011cb2d88c015e65e9bbeab280e9.camel@hammerspace.com>
References: <20220315162052.570677-1-trondmy@kernel.org>
         <74453705-B296-4992-921B-68D287ECA4D1@oracle.com>
In-Reply-To: <74453705-B296-4992-921B-68D287ECA4D1@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6f1176b-31d0-4cb1-5c87-08da06a54213
x-ms-traffictypediagnostic: BN6PR13MB0931:EE_
x-microsoft-antispam-prvs: <BN6PR13MB0931C01B13B868D3CCB843E5B8109@BN6PR13MB0931.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/Ez4kDEtmtrOzdOYWNZDBQjLxieIj2/XFQKvDIfJmuEVVbo+1jntjp0LD7j6hZa113/qrAG9mf/WAC6f/jkB4JZXax20dI9NmVNDP1po8QpHt/W4sgKzk5ZjJgbs2oPQ+57ATqwBXBe06AIxnjhysLOWmDNTXI/BmbJNRSXhaxIx3gFzio/IPn6RRHDQ7mY0TvHU+uw41KMIX9TUpiQE3aTTvn8xucU1hcmm0Lmb48CTqjDgePsxOy2i3GTdO11f6Gs4Rnvsd4BtK/3DSdkv7CiEG4m308PkATRmjzBXc3j8SBy9f4X1R2M8uGEpf+1Co1hz85IG59gTUh4XyBNcfflyMERIcGjgHM/OgH8hHyaRCImQLJa/yTM4eppSdeG5+hdbiJ8+4Uz5dVe0EFRXEaPzy/UCC+j+C71hvDr8h5Vt+pBWFy0y2O4IbNJJrH5rIwtIYKpx2HU9x+leazHzi83EL9PQhd+mWtqECWZYTpEKt4K7LlA8w1oiHhQ/42KvxNG/OjKSMGckRMuW4LiC6QxU2XmEmLqzPpMLSVT/Q4wL0lI+76qv6KFlYAUwF1yXYcpatdFZBR58VK6azf99+szjB1O0/5UklSzKuHZfkIB+Ckltr47b+jJ6o5ruWimxEGeRlMa86UHKaAhG0aoiYX0PiEtoEbGP+Sz6KksDjiAMb8mviDGTuT9jA+xFXIjJXyokuaRUQkXUsbHUok5xNYOH7wkCuxjW95b2k1DeHQsB2lApXxVUXHFu308rgnk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(64756008)(66946007)(76116006)(66476007)(66556008)(5660300002)(36756003)(4744005)(8936002)(508600001)(6486002)(26005)(8676002)(4326008)(66446008)(6506007)(6512007)(53546011)(186003)(2906002)(71200400001)(2616005)(86362001)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVE0MXM1WU5WRnVyMytTZVg5SXF1a1VBNkJVdW0yclVYVE5aMEtjMDRSNlND?=
 =?utf-8?B?cC9hZ3ZWYVppOStxaXkyelIvakJzY0JrWkFEc2l4NTJPSGVSeGkwTjA3aWFW?=
 =?utf-8?B?c09leHdjQXEvVEoxcytmMGtIcFk3KzBMRHBwN0xSOGNQUGE4VFNPdGkrQ3dk?=
 =?utf-8?B?Qk4yUmYyYWhlN3hkSEJmVFQrQ2dDSEhFMUVReEdoVEorRVArR3ZzTTJFdXMr?=
 =?utf-8?B?T3ZCNE15MUdDQ0RtcjBuMXlQVHc3Z2tRZnJvK0pLbWVLcW5mWk8wbUg1M1Bu?=
 =?utf-8?B?SW0zZmRIc2NRKytKRHo0TzZYNjZQMVNMMFNVaVR3YjlTaUpoTGF3YWYwdmlh?=
 =?utf-8?B?ekpDc0lBRXErWnd6U2FXMDhwdnA4eWpXeDlFRmllS0VsMVd5eXdvTlp5cWdD?=
 =?utf-8?B?SXR2Q0MzTU0zMmJSQ1ZDeGVNck5YaVA2NWJ1bmJIcjA0VE83ZzNEUnFic3Jj?=
 =?utf-8?B?QnFHaGZaRldlSmJmQWpSTWlxWWRyakx2L0tGZzdOWDlJSnpEQjdDYWx4SnZB?=
 =?utf-8?B?UVpnM3ZQbEpZanFqeHRpbytWeDJLd1pRRW1CQUh3Rk5CQXJlM0VWVWlFUmxu?=
 =?utf-8?B?THU3OEtwRW1uKzc0YS9PL0VwZEpzd3R1T2ZtU2lYZ1lIb2N2TnJQeHFpN3NT?=
 =?utf-8?B?NkN2d0Z6WGhRYzJsTTM4MUhleEhPcHFGbVViaklNMGdGQTEyUDhrdHRDWmhL?=
 =?utf-8?B?Sy9LekJjMHJndVQxOTlnV1Q4OUpHalMyeTZGeXR1VVJmaWFxUWxKaE1aV290?=
 =?utf-8?B?UFJMejdGd0NBTDRQR01XT2hHaDUrTWNGeGRUd0MyVzVEWmpRMnVMN1J4dzFY?=
 =?utf-8?B?MElOMzBNbVR0TG9vcGYraHlac0NVUXVPM2l5UGhQV3hXYWJQYUFJcHpCUW5w?=
 =?utf-8?B?SnZwYWs0VUN1OUhnVmxMTXJMWG52MFZUdEpoRHdrcVljZFBWN3BUMGhhN002?=
 =?utf-8?B?RGFrZXJMRytOMi9rL1ZqOVBxc2IrK3RySFdIK21lSlVHeG9ISW1OR2RiQlV3?=
 =?utf-8?B?VDFtYTQxdXFLdzcxOXFZR0J0bXp2bDMvbURwOWxjTXVtU2VQdWlOVVJtS0l4?=
 =?utf-8?B?SWVuSGxCQzhGdzFkSkNiZEhuUEkyMUkxaUZGSFBld2Q2QWl6QlE2a000NzIx?=
 =?utf-8?B?VE94WUkrdUhsM3Mxa2t6bUlITXZ2UHNpcE1vUzdNbWZSa0xLZko4dFJQcnUz?=
 =?utf-8?B?d25TMEpwQmZMTDJSRzV1UzB1OUtOaWd4OEdvSTEzN0tDdEY2bnFGamJuNFFo?=
 =?utf-8?B?WVdnelc1UCtJYnJERHEvK1pTZG9mNGdybUZ3dURUbmU0amFMQkwvS0xMdGNw?=
 =?utf-8?B?M1VVbWQzaTE4Tk5wcUNmbjNrY0V0R2RDdUVDK1h3K2VUY2hjUE52dzl6RytY?=
 =?utf-8?B?RG44TjduSEtib1o5cHBMZ0hRUTZnekppajg1VGxaNXVVQS8zVWJmTWs0eC9a?=
 =?utf-8?B?c0Q4NTF3NjNtMFlpT3YvQUkvOHlKMjA5L2ZtUlBCQXJOY0NaVlVSME81TC9t?=
 =?utf-8?B?YjNZdy9XOGdsOEhFRlZtdVJ5c0NacE45SFMvdGtxcTR2OG84RU9oSzJCenZT?=
 =?utf-8?B?Z1Zqakg5bCtJdko4ckI5YUYzSVA4T0VMbmwySmlaN09sYVNBTW81ayt2K3Jt?=
 =?utf-8?B?VktMZVBlNEJMRzMvVzhaM0dYWFdqZ252U3l5ZGlvdDJzbFR1YzZBV1Y0QW1i?=
 =?utf-8?B?ekIxdlEzdVludnhsNUowaEF0ZFRmQTdpL01vTVl5TUZJNWtleVF5Y1pZU3c2?=
 =?utf-8?B?NGtha0V5MzlnK004MmlUakN2bktvWkpoeTQzc0pDSlQzTThPMGswWVJDaU8z?=
 =?utf-8?B?Vm1IMUQ5alRrOUZQeVAxS3N1ejZZSW9hcmFra2s4eUs3WXdKNUJoV081OVl1?=
 =?utf-8?B?YURqRnZYL3dBTmRaNjdoVHNnRlYxM0tTblB5aVc2SS9ReGlJTkNzSVRnU0FS?=
 =?utf-8?B?QWF6R1F4MzVRKzc0R3hVUTVGNnB2c3NyVE9lNUdpVlhrb1BZSGZSSmRnNDFP?=
 =?utf-8?B?eFJHOE9WNytnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57286E6FE1354E4F9D547FD21FC352E8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1176b-31d0-4cb1-5c87-08da06a54213
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 17:00:07.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/LL2my4ena83S+6K1iBTT2Fof0Iuul08QNijgwpnAzcbJ/cw+WW5GRUdkenxC7W7wL2GGjXNBtytEPx0HAu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB0931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTE1IGF0IDE2OjUwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgMTUsIDIwMjIsIGF0IDEyOjIwIFBNLCB0cm9uZG15QGtlcm5l
bC5vcmfCoHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiANCj4gPiBXaGVuIGFsbG9jYXRpbmcgbWVtb3J5
LCBpdCBzaG91bGQgYmUgc2FmZSB0byBhbHdheXMgdXNlIEdGUF9LRVJORUwsDQo+ID4gc2luY2Ug
Ym90aCBzd2FwIHRhc2tzIGFuZCBhc3luY2hyb25vdXMgdGFza3Mgd2lsbCByZWd1bGF0ZSB0aGUN
Cj4gPiBhbGxvY2F0aW9uIG1vZGUgdGhyb3VnaCB0aGUgc3RydWN0IHRhc2sgZmxhZ3MuDQo+IA0K
PiBJcyBhIHNpbWlsYXIgY2hhbmdlIG5lY2Vzc2FyeSBpbiB4cHJ0X3JkbWFfYWxsb2NhdGUoKSA/
DQoNCkl0IGxvb2tzIHRvIG1lIGFzIGlmIHRoYXQgd291bGQgYmUgYSBzYWZlIGNoYW5nZSwgYW5k
IHdlIHNob3VsZA0KcHJvYmFibHkgYWxzbyBjaGFuZ2UgdGhhdCBkZWZpbml0aW9uIG9mIFJQQ1JE
TUFfREVGX0dGUCB0byBtYXRjaA0KR0ZQX0tFUk5FTC4NCg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
