Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086614F89B8
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 00:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiDGUiX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiDGUiP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 16:38:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2100.outbound.protection.outlook.com [40.107.100.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0C29FC6D
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 13:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQmxFHPHEbIQm9/TKuXwXlNI6EBgvzTZgwEEX5kzoo90AZ1c01/NG35+Jgyty2LheFO0HBzw/IRKA9hXPIGSm0llJN6ZyxkpZ5xRo6+JXIsiIkzhWU1Yx1Jcs7dkEiNSBH27xisiWCsmd813pfc3txAMDy+g3tGM941kc7sntPzajbDVHeVPN7QkfxH1gu6GOSGHR4vGY0z3q8Q+soJRPEr9XnJPvHqlmdNT/DZAKlB8qqe98W1E/IUKsBJr2j5SfclQhT39ifHKUp/CgM0OKGgcF/amGZNLQnmBWsyAX6+juCVPECh9CBev5pUppUEWT8BnIUz7fHyxFlXQv8IWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvHLHiGJ/6lgsW/B4Ybzll1guNcf8GNRgp9TcvPhEE8=;
 b=BA+5a0pW2C1QUkxX/eexNl2vUiONuwJRqv5MzZcsuxntVThlwUeorJdMKefYvGrgf5YrIewFzQVMzIJNIrYfXHFctRQAP9btnKRTas/J2Aa7OWnt67znrmBQSSEUl3G3Sbk9TVTqqqaOuKfpMZBcE8VheX/6safEBgtNJ6vt6dtdSdtXVbSGC6ozcbW49yoroFd/ZV0kjTA64gngto7/1SBOqwYsOi5Rc8KlEGJuRk0IDS+egBmSzgyOhg42+Hqa236l+Ex+GVw2wZyJuZ1Hivz4Ths1OuamWXnl/Lzb/KL4y1diORywRvlnoufjdX/GnOFT21MDk1rOIfmOP7a6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvHLHiGJ/6lgsW/B4Ybzll1guNcf8GNRgp9TcvPhEE8=;
 b=K8j1PbaAQHNuJ2Waw8eRZ42phReDg4dYctLf789l05TZ5rCcOaFVm1rnEXkUVpVA4k6EHymdGonL7dcPyiL7FGP4Y6u/L/w1OK+EvTLxMkng9e42fADLQvSczoXqrTR5Mw+us8l+PGxpn992lzrtOdxouTiu5zyYgVyV99rZoqk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB4912.namprd13.prod.outlook.com (2603:10b6:806:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Thu, 7 Apr
 2022 20:31:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5164.008; Thu, 7 Apr 2022
 20:31:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/2] SUNRPC: Fix NFSD's request deferral on RDMA
 transports
Thread-Topic: [PATCH v3 1/2] SUNRPC: Fix NFSD's request deferral on RDMA
 transports
Thread-Index: AQHYSqcB/XUejKdAwk6aKefBvsENJKzk57yA
Date:   Thu, 7 Apr 2022 20:31:56 +0000
Message-ID: <bce2e3d990c54f4cc3c846429c4926888a1dfc90.camel@hammerspace.com>
References: <164935330144.76813.17862521591948764594.stgit@klimt.1015granger.net>
         <164935340273.76813.7096678268046264254.stgit@klimt.1015granger.net>
In-Reply-To: <164935340273.76813.7096678268046264254.stgit@klimt.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5fa14cb-a206-414f-0060-08da18d5a8fa
x-ms-traffictypediagnostic: SA1PR13MB4912:EE_
x-microsoft-antispam-prvs: <SA1PR13MB49122FC743A60C21FBBF211BB8E69@SA1PR13MB4912.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+/NDZps66SeLsOqxsCwUmoIrGX3uc8oA4lyMdo0YyAOcQbNHie3kbiSvTckNEenp5oPub+HCaOCu2oWt23ciKk9RwWTNjj12e/R+KBZ/RaK7z2SflQsO9ZIlCZODgrUrfOnbP1fA+gr+CoAVusQSVeb1jEmgi/OgI/pIvhWffEL+Qp3oKmbLbZ0u6lY6j2DobHace+O1gPVTLfUhpDoGeZb9f7wyrdOzLc2zsFI0Ba9cUD6gpMv3m0YCX8SoUJ9WySp9lfo3NkyBMK08TsvO4IOLNlg+hI5ak8E0mwYuRx+Bz6q7gyzH9jDl/X7O8c3DA7cofapPHEAJNI9I+EBrLfTx1fSHKER3uF4cjXWEs0AOkDUfMJa9BwTum3tqM4rYFuG0ul6Oiy6HoUG13aUY9wT/M8STi5RZklHQO7GLjC3svIs2ENAUTXXKsZbQ8MCsKwTFwnC9PKKNpbv2kX2Ayh6gr904IfV4AuK9dHWClNzBaBdvGrbKKkPtCF9gQR+Fci1p+j4fSEvF5x9WDZT7Xtok2Y9LCialJzcW72wotzLOgAkHO5ESAWxj+CqkN3k9e2rPBG/Vl3vtzmu3aFwuVF4e4wfxRPYPqKZqRrWB/ZXdj0a1NPZHwXwBbqWgiz/7Uf22/imqijgqDDHmyFlk4AkjlAWGuk5uZ36Ju05J0w5DnVanwz4hUlgkU6C3tKK3hW4p6FFOc7IRMVQbve+fHZzpvXbn1EazpotqaxLGFOlrTxayie2ATLjvaZba7zf3d9EoH6YQTKF1/lNguHmb+eV8WIyN2GLZcArn5EiIIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(83380400001)(6506007)(38100700002)(86362001)(38070700005)(316002)(186003)(966005)(508600001)(71200400001)(110136005)(6486002)(2906002)(26005)(66946007)(4326008)(76116006)(2616005)(6512007)(5660300002)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVBUk5FTnd2dDdhY0MvdEVPY1pyYTljZ21WYjZGUWtMYXN1dkhObFF1M0FQ?=
 =?utf-8?B?YytHWkl3OTBRWnpYTG1jTllUb1hjaDhIbzJuWmNxaFhibTN0RURjRTJEY2Y4?=
 =?utf-8?B?OWpVRWpxd1dvSmZOM01LcXI5dktFMzRESFdjZG81Q0locEUvcGVjREVNdFVL?=
 =?utf-8?B?QWU1SU5tclRyQlE4RWZTcVlBL1NlWnR6TnByWklQaE9WcmxUaVBxWEZxOUta?=
 =?utf-8?B?c2gvUEtNWk5mWkg3U2RVbHBrZkYwQmJYWXpiaWJ6UEMvc2dUaUVoalBHVzNS?=
 =?utf-8?B?QmZJeXhjcEo0czBFSkgvVDQxeWxySFZzcEVLNVRoRUl2RUdQZjZLYXdXeU13?=
 =?utf-8?B?Z1NuWk5DNVdMSDVScXJ4YlA1RnpZMDc4OTVDTVZCb2x6aFkzb2VwU3RhMHpQ?=
 =?utf-8?B?RlBYc0JNQUhraUhQM3htS05zVE9qY2tJZ0hjdHlLM20wK0N5aDg1N1ozL1hS?=
 =?utf-8?B?bkx1K0hNd0JyQjBlSUZ6MVRKUlJhdnpQN01zQ1JyMUQrV2ZlQWZZeUdPdjZU?=
 =?utf-8?B?RG83SVBsVWZWR1lmdGRlSEZkUVBKSFNwV2x2VWh1R1lQY3lUakNoWnhIOGxj?=
 =?utf-8?B?MnZ4Z0J1RUpuK0NvYUVHZnBMT0VBY1N0MnN2bDkwUndIWTFwelcyQmwrOFV4?=
 =?utf-8?B?WTV6aVlMaVJTNmxJakUvb2pGaU9jZ3c5NzZDWjFQSThabUpnNExyeG5yQm9m?=
 =?utf-8?B?M3JDVUplbHRhcEJkeWMyT3VmUmg0K2labDRQUUVrMks0S1d6a2tnNXkxVktr?=
 =?utf-8?B?RDl2NWIyRVFOajIySXZtSDZHRkhyUWlWb3d6NUhnVUdQQlA2bndlWHRpbFU4?=
 =?utf-8?B?ZkUxa2V1VzNJUnVvMzhUejJzSXZYSWNrWkZCSWlSUEVEMFFRUWNTbmJGeFFY?=
 =?utf-8?B?U0hWaWxGdXdlUi9RRHdFUTNTdnVoVUg0dGYxVmQxVlI2cE9WZ3g3a2twL1lJ?=
 =?utf-8?B?RE9DV3plSTIxQUV3OXdoUUVMN3BkZk9rWlFDSUZ5SWV0MlBBTHByT0c2QjRF?=
 =?utf-8?B?UVV2cXNmWSs2a2gyUTQzWldKa2NHeHpiV2lUeHB6ZUhGbjQ5a0p1Q3lkSHgw?=
 =?utf-8?B?enB2WG1kb3ZlRjhrMTd4Zy9rSXRocDloMmF2dDh1UHpjWXFrQTg0cEZvYmls?=
 =?utf-8?B?UmRGV2h5YUFMa0dadHNvWVJoWVZJWlplMFBsbnV3WnR4MnNNcjhVeUd3K1Yw?=
 =?utf-8?B?dllwSm5zekZya3FhYm5lK1Z4elRDZ2p1TjluNUUxUzcwVTNBZS9HU3RRbkhO?=
 =?utf-8?B?QkNuc0lXUU11Y0VhWDhyK09laE14YUNiN0U5RmJPWVB3ZStLUTY0ZGNldU5o?=
 =?utf-8?B?bTNYeTZjekgwVkdmTU1RdG03Nmo4KzNZQnY2T3RGSVBYOCtRWnFuaXhXbGd2?=
 =?utf-8?B?c2NTbTNYUnRPZW1JTmE5eHhmZDFUSUZpbVRZNW50SVdqdHNSam9aQXdDZldW?=
 =?utf-8?B?bUdNWkdWR3dCdXJYQitlc2dCTlQ1cVJ0T3lpa1d1cFc0Z1RBbDE1RVQvYmht?=
 =?utf-8?B?b1l0Q29VWDdZZzhZQTVEQWFXTDlkdVkwOFJOOEdYcXVSZyt4bnBpdkdWL21B?=
 =?utf-8?B?QVlYOUsvdDZnMTNUdzRMUXdCRmtWYVZsUVplejBrNXMrbEVuQlEyby9FYVZy?=
 =?utf-8?B?WWYzWWhxUE5NTG5xTlA5WHhWL2xDZjBDRDNlbm1zYTM5UG5VM3dZZnZ3d2tD?=
 =?utf-8?B?NlJvdWtsM3YwdmtuSmROWm92MmFGN3d1dCtJdE5MQ05RQnJBRk9ieS9aeUI0?=
 =?utf-8?B?N2IyOHpGak1va0lzNkVpMUhrUzIyK0lGOUlxVUhrWmhEMlVXZzRZOGFHQ0tC?=
 =?utf-8?B?MytJT2xGWEJ4K0NMY2dCWXhFN0k5N2kwQmtaSHJ3WG1lU2kxcEYvQk1yRTNm?=
 =?utf-8?B?U003OXlBMXVodXpiTWZtN0U5ZmxMK01nYTVRU2xKK3c0UmhhSVJvN3JkNHZF?=
 =?utf-8?B?LzZCZDVOWS80amJ0WC9WaS9JRURqNlRnRllDaVVaTU5BOTRWNWcvUkhVOHh0?=
 =?utf-8?B?NS9MdWl4QXdxUTlEdzJ3REYwVWgxZlJJcTBSRVhPY2E2L0V6aWwrRDJ0djNV?=
 =?utf-8?B?MS9OK05SU1AwOGNrNDJDK3AvUUE5dkgrNDgzQTBzdStYMjROSUJUenR6Y0V5?=
 =?utf-8?B?ZkZta1F0VnY4V2JLUWFacmtQRzRZcTZXczM3SVRka2tBN0ZJMHdPRVlOYXhu?=
 =?utf-8?B?eVFDdFRkczJBOURvTE1TLzJzUXpuV1FPa25Db0FiU1dIRkh4bWlQa0czcGl5?=
 =?utf-8?B?WTN0T1lKbUh3T0hKVGVLdElyU2t6RWhwemY5QzJOU2hOc2daZWNjRkRxSXRD?=
 =?utf-8?B?eW1LODlCNnZQNFJMWXpMTHpUME1JQmtoRTV4REtGY0RtT0dZYk9kdXJualBz?=
 =?utf-8?Q?RkfveBmm4hfw0Bec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13631A065340BB40AE0E4F0093690043@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fa14cb-a206-414f-0060-08da18d5a8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 20:31:56.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pyyib0bkUNgxODg+eahaaXl2ga95pKumoEpb9cAQBU5kMmDpUMBwypAgaxQIXA9r9iwQ7vsFThIBylhqmt23Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDEzOjQzIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToKPiBU
cm9uZCBNeWtsZWJ1c3QgcmVwb3J0cyBhbiBORlNEIGNyYXNoIGluIHN2Y19yZG1hX3NlbmR0bygp
LiBGdXJ0aGVyCj4gaW52ZXN0aWdhdGlvbiBzaG93cyB0aGF0IHRoZSBjcmFzaCBvY2N1cnJlZCB3
aGlsZSBORlNEIHdhcyBoYW5kbGluZwo+IGEgZGVmZXJyZWQgcmVxdWVzdC4KPiAKPiBUaGlzIHBh
dGNoIGFkZHJlc3NlcyB0d28gaW50ZXItcmVsYXRlZCBpc3N1ZXMgdGhhdCBwcmV2ZW50IHJlcXVl
c3QKPiBkZWZlcnJhbCBmcm9tIHdvcmtpbmcgY29ycmVjdGx5IGZvciBSUEMvUkRNQSByZXF1ZXN0
czoKPiAKPiAxLiBQcmV2ZW50IHRoZSBjcmFzaCBieSBlbnN1cmluZyB0aGF0IHRoZSBvcmlnaW5h
bAo+IMKgwqAgc3ZjX3Jxc3Q6OnJxX3hwcnRfY3R4dCB2YWx1ZSBpcyBhdmFpbGFibGUgd2hlbiB0
aGUgcmVxdWVzdCBpcwo+IMKgwqAgcmV2aXNpdGVkLiBPdGhlcndpc2Ugc3ZjX3JkbWFfc2VuZHRv
KCkgZG9lcyBub3QgaGF2ZSBhIFJlY2VpdmUKPiDCoMKgIGNvbnRleHQgYXZhaWxhYmxlIHdpdGgg
d2hpY2ggdG8gY29uc3RydWN0IGl0cyByZXBseS4KPiAKPiAyLiBQb3NzaWJseSBzaW5jZSBiZWZv
cmUgY29tbWl0IDcxNjQxZDk5Y2UwMyAoInN2Y3JkbWE6IFByb3Blcmx5Cj4gwqDCoCBjb21wdXRl
IC5sZW4gYW5kIC5idWZsZW4gZm9yIHJlY2VpdmVkIFJQQyBDYWxscyIpLAo+IMKgwqAgc3ZjX3Jk
bWFfcmVjdmZyb20oKSBkaWQgbm90IGluY2x1ZGUgdGhlIHRyYW5zcG9ydCBoZWFkZXIgaW4gdGhl
Cj4gwqDCoCByZXR1cm5lZCB4ZHJfYnVmLiBUaGVyZSBzaG91bGQgaGF2ZSBiZWVuIG5vIG5lZWQg
Zm9yIHN2Y19kZWZlcigpCj4gwqDCoCBhbmQgZnJpZW5kcyB0byBzYXZlIGFuZCByZXN0b3JlIHRo
YXQgaGVhZGVyLCBhcyBvZiB0aGF0IGNvbW1pdC4KPiDCoMKgIFRoaXMgaXNzdWUgaXMgYWRkcmVz
c2VkIGluIGEgYmFja3BvcnQtZnJpZW5kbHkgd2F5IGJ5IHNpbXBseQo+IMKgwqAgaGF2aW5nIHN2
Y19yZG1hX3JlY3Zmcm9tKCkgc2V0IHJxX3hwcnRfaGxlbiB0byB6ZXJvCj4gwqDCoCB1bmNvbmRp
dGlvbmFsbHksIGp1c3QgYXMgc3ZjX3RjcF9yZWN2ZnJvbSgpIGRvZXMuIFRoaXMgZW5hYmxlcwo+
IMKgwqAgc3ZjX2RlZmVycmVkX3JlY3YoKSB0byBjb3JyZWN0bHkgcmVjb25zdHJ1Y3QgYW4gUlBD
IG1lc3NhZ2UKPiDCoMKgIHJlY2VpdmVkIHZpYSBSUEMvUkRNQS4KPiAKPiBSZXBvcnRlZC1ieTog
VHJvbmQgTXlrbGVidXN0IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4KPiBMaW5rOgo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy84MjY2MmI3MTkwZjI2ZmIzMDRlYjBhYjFiYjA0
Mjc5MDcyNDM5ZDRlLmNhbWVsQGhhbW1lcnNwYWNlLmNvbS8KPiBTaWduZWQtb2ZmLWJ5OiBDaHVj
ayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmc+Cj4gLS0tCj4gwqBpbmNsdWRlL2xpbnV4L3N1bnJwYy9zdmMuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgwqAgMSArCj4gwqBuZXQvc3VucnBjL3N2Y194cHJ0LmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCAzICsrKwo+IMKgbmV0L3N1bnJw
Yy94cHJ0cmRtYS9zdmNfcmRtYV9yZWN2ZnJvbS5jIHzCoMKgwqAgMiArLQo+IMKgMyBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9zdW5ycGMvc3ZjLmggYi9pbmNsdWRlL2xpbnV4L3N1bnJwYy9zdmMuaAo+
IGluZGV4IGE1ZGRhNDk4N2U4Yi4uMjE3NzExZmM5Y2FjIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
bGludXgvc3VucnBjL3N2Yy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9zdW5ycGMvc3ZjLmgKPiBA
QCAtMzk1LDYgKzM5NSw3IEBAIHN0cnVjdCBzdmNfZGVmZXJyZWRfcmVxIHsKPiDCoMKgwqDCoMKg
wqDCoMKgc2l6ZV90wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRkcmxlbjsK
PiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2XCoGRhZGRyO8KgwqAvKiB3
aGVyZSByZXBseSBtdXN0IGNvbWUgZnJvbQo+ICovCj4gwqDCoMKgwqDCoMKgwqDCoHNpemVfdMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRhZGRybGVuOwo+ICvCoMKgwqDCoMKg
wqDCoHZvaWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnhwcnRfY3R4
dDsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGNhY2hlX2RlZmVycmVkX3JlcSBoYW5kbGU7Cj4g
wqDCoMKgwqDCoMKgwqDCoHNpemVfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHhwcnRfaGxlbjsKPiDCoMKgwqDCoMKgwqDCoMKgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgYXJnc2xlbjsKPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9zdmNf
eHBydC5jIGIvbmV0L3N1bnJwYy9zdmNfeHBydC5jCj4gaW5kZXggMGMxMTdkM2JmZGE4Li5iNDJj
ZmZmYTczOTUgMTAwNjQ0Cj4gLS0tIGEvbmV0L3N1bnJwYy9zdmNfeHBydC5jCj4gKysrIGIvbmV0
L3N1bnJwYy9zdmNfeHBydC5jCj4gQEAgLTEyMzEsNiArMTIzMSw4IEBAIHN0YXRpYyBzdHJ1Y3Qg
Y2FjaGVfZGVmZXJyZWRfcmVxCj4gKnN2Y19kZWZlcihzdHJ1Y3QgY2FjaGVfcmVxICpyZXEpCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkci0+ZGFkZHIgPSBycXN0cC0+cnFfZGFk
ZHI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkci0+YXJnc2xlbiA9IHJxc3Rw
LT5ycV9hcmcubGVuID4+IDI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkci0+
eHBydF9obGVuID0gcnFzdHAtPnJxX3hwcnRfaGxlbjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZHItPnhwcnRfY3R4dCA9IHJxc3RwLT5ycV94cHJ0X2N0eHQ7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJxc3RwLT5ycV94cHJ0X2N0eHQgPSBOVUxMOwo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBiYWNrIHVwIGhlYWQgdG8gdGhlIHN0
YXJ0IG9mIHRoZSBidWZmZXIgYW5kIGNvcHkKPiAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc2tpcCA9IHJxc3RwLT5ycV9hcmcubGVuIC0gcnFzdHAtCj4gPnJxX2FyZy5oZWFk
WzBdLmlvdl9sZW47Cj4gQEAgLTEyNjksNiArMTI3MSw3IEBAIHN0YXRpYyBub2lubGluZSBpbnQg
c3ZjX2RlZmVycmVkX3JlY3Yoc3RydWN0Cj4gc3ZjX3Jxc3QgKnJxc3RwKQo+IMKgwqDCoMKgwqDC
oMKgwqBycXN0cC0+cnFfeHBydF9obGVuwqDCoCA9IGRyLT54cHJ0X2hsZW47Cj4gwqDCoMKgwqDC
oMKgwqDCoHJxc3RwLT5ycV9kYWRkcsKgwqDCoMKgwqDCoCA9IGRyLT5kYWRkcjsKPiDCoMKgwqDC
oMKgwqDCoMKgcnFzdHAtPnJxX3Jlc3BhZ2VzwqDCoMKgID0gcnFzdHAtPnJxX3BhZ2VzOwo+ICvC
oMKgwqDCoMKgwqDCoHJxc3RwLT5ycV94cHJ0X2N0eHTCoMKgID0gZHItPnhwcnRfY3R4dDsKPiDC
oMKgwqDCoMKgwqDCoMKgc3ZjX3hwcnRfcmVjZWl2ZWQocnFzdHAtPnJxX3hwcnQpOwo+IMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gKGRyLT5hcmdzbGVuPDwyKSAtIGRyLT54cHJ0X2hsZW47Cj4gwqB9
Cj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHJkbWEvc3ZjX3JkbWFfcmVjdmZyb20uYwo+
IGIvbmV0L3N1bnJwYy94cHJ0cmRtYS9zdmNfcmRtYV9yZWN2ZnJvbS5jCj4gaW5kZXggY2Y3NmE2
YWQxMjdiLi44NjQxMzFhOWZjNmUgMTAwNjQ0Cj4gLS0tIGEvbmV0L3N1bnJwYy94cHJ0cmRtYS9z
dmNfcmRtYV9yZWN2ZnJvbS5jCj4gKysrIGIvbmV0L3N1bnJwYy94cHJ0cmRtYS9zdmNfcmRtYV9y
ZWN2ZnJvbS5jCj4gQEAgLTgzMSw3ICs4MzEsNyBAQCBpbnQgc3ZjX3JkbWFfcmVjdmZyb20oc3Ry
dWN0IHN2Y19ycXN0ICpycXN0cCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdv
dG8gb3V0X2VycjsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCA9PSAwKQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZHJvcDsKPiAtwqDCoMKgwqDCoMKgwqBycXN0
cC0+cnFfeHBydF9obGVuID0gcmV0Owo+ICvCoMKgwqDCoMKgwqDCoHJxc3RwLT5ycV94cHJ0X2hs
ZW4gPSAwOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChzdmNfcmRtYV9pc19yZXZlcnNlX2Rp
cmVjdGlvbl9yZXBseSh4cHJ0LCBjdHh0KSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gb3V0X2JhY2tjaGFubmVsOwo+IAo+IAoKVGhhbmtzIGZvciB0aGUgcGF0Y2gsIENo
dWNrIQoKR2l2ZW4gaG93IHRoZXJlIGRvZXNuJ3QgYXBwZWFyIHRvIGJlIGFueSBwb3NzaWJsZSBh
bHRlcm5hdGl2ZSB3YXlzIHRvCmdlbmVyYXRlIHRoYXQgcGFydGljdWxhciBzdGFjayB0cmFjZSwg
SSdtIGZhaXJseSBzdXJlIHRoaXMgd2lsbCBmaXggdGhlCmlzc3VlIHdlIHNhdywgYnV0IEknbGwg
bWFrZSBzdXJlIHdlIGdpdmUgaXQgYSB0aG9yb3VnaCB0ZXN0aW5nLgoKLS0gClRyb25kIE15a2xl
YnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
