Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D894E77BC0D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjHNOvo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 10:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjHNOvc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 10:51:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679861726;
        Mon, 14 Aug 2023 07:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSGxWYgQKj2JjxlqKkQKdbyOBS9mQimzfToCffCITvsNXRTrKhmuEEMOGHnCGk8mGjITa1sUTTjXi4lTgj9WxQASaSuCsXlDatK4Oedxwyuh1hTMfeQP0lkTAmqmACSfXgSBB3uOw7fSzhuYnPT1759cwXd5DmuWNtMOn2j3HYbFOv8eKZUlJhgPXDPJvEowRszyz1sdY64ompIVXs5QPb2+9t/mg9K/awYjDWq43fLenCvfryaWc0neQQRKkcMRjSbV+NvvTOwx/NVuVSximaieYOCCO18ji2Am186EMIMifqq+wqP1VZrYB8TrPvPQ5UxvI+i8xglmQRKbJ1hv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0Vm42Cs6ITpEsk7x/TQAZL/DunxcfLpxuv5aYW3gTM=;
 b=NhUAzrHsuy87sSULBA/CVLWBdG/OzhyoxsQZt7qg6fp+wBG2xoUEnMq+Hfex1/MhD/XOs97tJMQFbbu4vuf7a72maKOTeqYgp9XSMkfEO+HaZKfwkWo6COhmapYszWwZvCOjkFd8oiyIW0StEzrJ+nM3s0jdjOD+//croE+UVvtGTYxvPk7fzGMjnrWHsl97Qr6AaxfyHm3YGm+bCP3ZxUdJ8KKeb+2Aa0fVoXad0jnwn6FA6UxgGbtklcXBF0Ryqq+etXyIv5N/242GWaiob9KRL6H9uUOYcIjFDqyaFJLCyFOQuSNdn81g70PbgiB/xpjpGWv96CGMkzCpJDpRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0Vm42Cs6ITpEsk7x/TQAZL/DunxcfLpxuv5aYW3gTM=;
 b=ZSsqNFwb+cb6OouwIBsMmzvqUpOvBQg3Hul7pMBW30VCL2bJlUseKlEB24ov6RsrxWc1P3kuGA4/hLJMOy63I07N3dN6oRTOhwjijaczQ6AlY+96atM1Z4ZFOZq379E2EU7065Aas9gemx+OKP8wycbqr/+ppjH95myxXCIHFIk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4033.namprd13.prod.outlook.com (2603:10b6:5:2a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:51:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:51:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: account for xdr->page_base in xdr_alloc_bvec
Thread-Topic: [PATCH] sunrpc: account for xdr->page_base in xdr_alloc_bvec
Thread-Index: AQHZzrwiqR/4ob1NIEu17gkC2rEGSa/p4BuA
Date:   Mon, 14 Aug 2023 14:51:23 +0000
Message-ID: <40adb882f4c809b8a404e167c05bbbc9a1de6fa0.camel@hammerspace.com>
References: <20230814-sendpage-v1-1-d551b0d7f870@kernel.org>
In-Reply-To: <20230814-sendpage-v1-1-d551b0d7f870@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4033:EE_
x-ms-office365-filtering-correlation-id: 444af5cc-79bc-4381-220b-08db9cd5ee10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e15oTEtphp2x+zLip5ddYFKsSLotnG8k+hJKzcS/KlK0zTbm9dedKEnWHOYWA3wcwlrnIeWbcrvx4h1Ki8ApUN30k/c4bmJG6Vx+svJLlwosVnGjqI/ntgf81XGsX5sNN4wnEUL6OENvTaFX2XB0QfyuJsTyEH+7IotQz+sjsNy3t8pH6NBqUQP4FxjyUtb6lMjldlvhK3cwkd/pNLq7iybKV2XjxVEZ+U3nbZ+d7U1+4Epqx7+uTbWXcqdpSDm7Fi9qVL7QwUzkczO+PYWaudH63uEzjeWd4XwesoFNIyy3/53zyEn3cJLh0nHOrYAQ5unFB+CAsJRMyKOe6KO4kTLPK1jGCxvJMpI5D/86XIWY4p1wL51VPCv0LtCey+X/rzekYR5KOtULh9oidLp4czKBEc45FXIS7ao+RZ2pzK/yhnuPRrliS0gUGufvYPcfxIDl1SVjiDHRA2p1mmdr+quf32BNW8kKTk+t/wMnJ9DZFMF3gFQ1hoLLkF21Bd4tHpViiJBCrRoXJAg2AnPUlOHX3P52JSyGzC0Wbauqe9sie1SgrIRE3vhPHipuUsEbwn8STV235wZWNyrFF2IgMsnUHaXdDju359vgv6zk/Gag6Sj2p1yVhfiAf7BQNk8VpKPWv05rjjtTrk5N5J+29CS1xNn895ofbyPab9jhyzfdzjccTXqTb82b/t30AJFSgNHIIimZQdyIE3ZWRVYChw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39840400004)(366004)(346002)(451199021)(186006)(1800799006)(6486002)(6512007)(478600001)(110136005)(36756003)(54906003)(71200400001)(6506007)(26005)(15650500001)(2906002)(316002)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(41300700001)(8676002)(8936002)(7416002)(2616005)(5660300002)(921005)(122000001)(38100700002)(86362001)(38070700005)(83380400001)(12101799016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnV5c29NZEdJWG1sV2tHSVdMQlgrdlJ2M01QNmYwV3pOVjlqQnU4ckhXTGhh?=
 =?utf-8?B?MFBaL254eUlGVkc1enBTRWdlZWdZT3ZZNjNTdDEyb0ZEMHg1cGpuaytWb2JM?=
 =?utf-8?B?WXE5QlhLVGhremRCNTNmemNLVWJHTW11VGR0ZmNUdnZZaXorRmZ2MXMwK2Yv?=
 =?utf-8?B?TXdZUjJPaTNGVGtzN1RPaXk4Q3ZkZWdKYnkvblA3bW5mbnZ4NFJiRjZwb3lz?=
 =?utf-8?B?U1RtdlFNd2ZWNWdXanZaekRNbk8wRzdZQU5hcnJOSW5nYWM4eGt4TnhidDEv?=
 =?utf-8?B?b0MrSjFPS0xYNk9sOEFWeTcwWm1JU0hIeUpRRTQ5ZVVUaXllNFpRbW9YZEZC?=
 =?utf-8?B?UWdZQkQvZnFjTlBSWXozeFl4OXZUbGo3VTNOSkJEMFNrNm1LTUNBcVlzYzJH?=
 =?utf-8?B?V255R1FFSE9QcE9lMlQwOEY4QysyVm90ZVZTbTFCaFJ3Z2IrNzBwYXFwQTly?=
 =?utf-8?B?VEdSQUY5NkhVamRZdHA2S254ZU84RENQSnZBaXNTdkRTWk1nUVltcGdWUWta?=
 =?utf-8?B?cGM0aGdPUi9RL1BJQnZTRHk1dWxTM0dpZXN3enMvSFFxQldQekJzN0lSTzNZ?=
 =?utf-8?B?YWFFTWRianZDM0hkVk1vQlNRZS9BbEsrVVVpUHBoLzAxSFhjcDlOdHM5Z3o5?=
 =?utf-8?B?U2JqODlwQjFBOVdkbzduUHZYNDUxeVN3VS9xbkl2ZnJncDBIbUNhOFFKQ2lF?=
 =?utf-8?B?YzNCRHRyaVBZVkpScXMvVUVTdFpLbjF1OUtGRTNOWXl4WGc5V0xNeDhEMFpC?=
 =?utf-8?B?U2E0TnMwM1U0U290NDRPZUt1cWhLRVNUN1pRYk5hRndJeHdGTkV3RTZldWU0?=
 =?utf-8?B?a2VieDgwTVpDRkVqcGF3MXBIOGRudUZENDFUWW1teHhRZGttUFEvY1d1NzZu?=
 =?utf-8?B?YjZpTE5zamdIVDBoWm9TWHg1VkR0WFMraUVoVnllM3BXZlo1Uk5DSHQ1K1NI?=
 =?utf-8?B?VjJTWTRFZVIxNUpmYmt0RlRsWFhTcEpXT2NUeWczcVh3MTY4cmx0TlhPY0NZ?=
 =?utf-8?B?TVQrQWZnNTA5QTRrWlVhbENqTWx1S3BaUTRyWEZmQmZtNmZ3dENCbktGSHVZ?=
 =?utf-8?B?MDVHeXpYN1lNakMrU1BGOFlVTDlYYW1DVmtQeS9xYW0xdnNQbEV4NXhtNkt1?=
 =?utf-8?B?NmtuaUN6RXd3U3dEYUlhNEpBS1pvUkNxNm1MSFBkME93Ry9lYmtKdGg2Umh5?=
 =?utf-8?B?dmFzWU82UFI3aE9IWEFDZzQwSUFuVEZBYlVneHRoUFBXWkJOTkZrUmpCVWRj?=
 =?utf-8?B?aUpvYUlONXYwdm43NlljWVdBeFhyeDRWeXp6SXdlRmxSRHdHZHhYdXBzZnJE?=
 =?utf-8?B?RXZVeGxZbnFLV1gwamxGRzlabXp3bHVOQ21sTzBET2V5bUJCSGxiN2hnWnpO?=
 =?utf-8?B?U29tcHpRamdTejhIRWRDOG1ldzlaU2hBMXBidXc0Qjg0ZU5CdGVXZGFUcVpt?=
 =?utf-8?B?YnE1bFdFRVZZYWticG1Qb2ErUUdyei8wUlJvNUxlSVdUZGFxK3JOUVR2b0g4?=
 =?utf-8?B?REdSN0tuOXJYVTFKTmJPN2VJd3NPM1Z2aGN2M0lJM2ZPYnFFaTQ5b056REsr?=
 =?utf-8?B?Mjh4RDZJYllFczV6aGxnYkxZQ2VpRlJjZFg3dUJsVmd3K3hmMmJGVlJpNzFi?=
 =?utf-8?B?elJodDlVUk10eG1WdzJlZjNZbGhrWVVidm1FV1lTVWQrM3F6aGVwVVRCaENq?=
 =?utf-8?B?MWI3LzRTd01TbER3dkZxb2xLRkFJaFV2eDBPTmc5MFhKZUhEcFlhNVFyL3Ru?=
 =?utf-8?B?d0htUWczeGpLV3VkZXlQdXJ6d1M3TmhuOE5NK0RwRUc2dTFVZWsveFZCVVVR?=
 =?utf-8?B?c3pYUTZBeGg3dGVndHdHSWpEOFA2Nm5vQU5sN0xrRUZFd2pIc05BVzluRloy?=
 =?utf-8?B?K1krZm5HQUtVRG4wSFRnc3VLMmRFeC9wdlpuVXY3OE9yZDg5Z1FuK01TL0dB?=
 =?utf-8?B?VzZZUUgzY04vR05zWFIvdWpTcGFmTHdGa29Ib3ZBZVhGeVU2bUdCUTNwaG16?=
 =?utf-8?B?aVhzaTJ1ckVVYXJvK21lQktWNnBHREpEUktrVnB1S3lCVEhyMWFLWFhXMXdl?=
 =?utf-8?B?M3NYS1NNNlUzcjlZalZUZmRGY2xzLzdzQlNYWW45MHBQbkZZVGFjeU16SUMz?=
 =?utf-8?B?SkMyQ3JWb3lGZ2MzUStha0Fvd2VoNW50bVAyUEt0V3d1aGlqUklEdER4NlpQ?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5F6D5A3E6AA7B4398A48F9FB411263C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444af5cc-79bc-4381-220b-08db9cd5ee10
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 14:51:23.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/JeeC0/PaYbL8x9AaFcorbzCahgdhDRdhQo/0c1Q+BAKt2elzoM27qDF7soZLuHpsdU6OyYAbWYtOUPaYcmxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDEwOjMyIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToKPiBJ
J3ZlIGJlZW4gc2VlaW5nIGEgcmVncmVzc2lvbiBpbiBtYWlubGluZSAodjYuNS1yYykga2VybmVs
cyB3aGVyZQo+IHVuYWxpZ25lZCByZWFkcyB3ZXJlIHJldHVybmluZyBjb3JydXB0IGRhdGEuCj4g
Cj4gOWQ5NmFjYmM3ZjM3IGFkZGVkIGEgcm91dGluZSB0byBhbGxvY2F0ZSBhbmQgcG9wdWxhdGUg
YSBidmVjIGFycmF5Cj4gdGhhdAo+IGNhbiBiZSB1c2VkIHRvIGJhY2sgYW4gaW92X2l0ZXIuIFdo
ZW4gaXQgZG9lcyB0aGlzLCBpdCBhbHdheXMgc2V0cwo+IHRoZQo+IG9mZnNldCBpbiB0aGUgZmly
c3QgYnZlYyB0byB6ZXJvLCBldmVuIHdoZW4gdGhlIHhkci0+cGFnZV9iYXNlIGlzCj4gbm9uLXpl
cm8uCj4gCj4gVGhlIG9sZCBjb2RlIGluIHN2Y190Y3Bfc2VuZG1zZyB1c2VkIHRvIGFjY291bnQg
Zm9yIHRoaXMsIGFzIGl0IHdhcwo+IHNlbmRpbmcgdGhlIHBhZ2VzIG9uZSBhdCBhIHRpbWUgYW55
d2F5LCBidXQgbm93IHRoYXQgd2UganVzdCBoYW5kIHRoZQo+IGlvdiB0byB0aGUgbmV0d29yayBs
YXllciwgd2UgbmVlZCB0byBlbnN1cmUgdGhhdCB0aGUgYnZlY3MgYXJlCj4gcHJvcGVybHkKPiBp
bml0aWFsaXplZC4KPiAKPiBGaXggeGRyX2FsbG9jX2J2ZWMgdG8gc2V0IHRoZSBvZmZzZXQgaW4g
dGhlIGZpcnN0IGJ2ZWMgdG8gdGhlIG9mZnNldAo+IGluZGljYXRlZCBieSB4ZHItPnBhZ2VfYmFz
ZSwgYW5kIHRoZW4gMCBpbiBhbGwgc3Vic2VxdWVudCBidmVjcy4KPiAKPiBGaXhlczogOWQ5NmFj
YmM3ZjM3ICgiU1VOUlBDOiBBZGQgYSBidmVjIGFycmF5IHRvIHN0cnVjdCB4ZHJfYnVmIGZvcgo+
IHVzZSB3aXRoIGlvdmVjX2l0ZXIoKSIpCj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGps
YXl0b25Aa2VybmVsLm9yZz4KPiAtLS0KPiBOQjogVGhpcyBpcyBvbmx5IGxpZ2h0bHkgdGVzdGVk
IHNvIGZhciwgYnV0IGl0IHNlZW1zIHRvIGZpeCB0aGUgcHluZnMKPiByZWdyZXNzaW9ucyBJJ3Zl
IGJlZW4gc2VlaW5nLgo+IC0tLQo+IMKgbmV0L3N1bnJwYy94ZHIuYyB8IDQgKysrLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1n
aXQgYS9uZXQvc3VucnBjL3hkci5jIGIvbmV0L3N1bnJwYy94ZHIuYwo+IGluZGV4IDJhMjJlNzhh
ZjExNi4uZDBmNWZjODYwNWI4IDEwMDY0NAo+IC0tLSBhL25ldC9zdW5ycGMveGRyLmMKPiArKysg
Yi9uZXQvc3VucnBjL3hkci5jCj4gQEAgLTE0NCw2ICsxNDQsNyBAQCBpbnQKPiDCoHhkcl9hbGxv
Y19idmVjKHN0cnVjdCB4ZHJfYnVmICpidWYsIGdmcF90IGdmcCkKPiDCoHsKPiDCoMKgwqDCoMKg
wqDCoMKgc2l6ZV90IGksIG4gPSB4ZHJfYnVmX3BhZ2Vjb3VudChidWYpOwo+ICvCoMKgwqDCoMKg
wqDCoHVuc2lnbmVkIGludCBvZmZzZXQgPSBvZmZzZXRfaW5fcGFnZShidWYtPnBhZ2VfYmFzZSk7
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG4gIT0gMCAmJiBidWYtPmJ2ZWMgPT0gTlVMTCkg
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVmLT5idmVjID0ga21hbGxvY19h
cnJheShuLCBzaXplb2YoYnVmLT5idmVjWzBdKSwKPiBnZnApOwo+IEBAIC0xNTEsNyArMTUyLDgg
QEAgeGRyX2FsbG9jX2J2ZWMoc3RydWN0IHhkcl9idWYgKmJ1ZiwgZ2ZwX3QgZ2ZwKQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVN
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IG47IGkr
Kykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ2
ZWNfc2V0X3BhZ2UoJmJ1Zi0+YnZlY1tpXSwgYnVmLT5wYWdlc1tpXSwKPiBQQUdFX1NJWkUsCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAwKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldCk7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvZmZzZXQgPSAwOwoKTkFD
Sy4gVGhhdCdzIGdvaW5nIHRvIGJyZWFrIHRoZSBjbGllbnQuCgo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAwOwo+IAo+IC0tLQo+IGJhc2UtY29tbWl0OiAyY2NkZDFiMTNjNTkxZDMwNmYwNDAxZDk4
ZGVkYzRiZGNkMDJiNDIxCj4gY2hhbmdlLWlkOiAyMDIzMDgxNC1zZW5kcGFnZS1iMDQ4NzRlZWQy
NDkKPiAKPiBCZXN0IHJlZ2FyZHMsCgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQoKCg==
