Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E704AE577
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 00:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiBHXeZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 18:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiBHXeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 18:34:23 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2129.outbound.protection.outlook.com [40.107.94.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825EDC06173B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 15:34:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMOtjZxKt3S+hedbyxeRnxOPfiJp9V/TcaiD//t8i4Kwm58ZFMFn8z/I+2yV6m2HY63Ih097dsqFQFZor0XloXU1YRpLVazzmM8DCo/i1WK3EngQT1S2umB2VHC5uEnu7wlPE+qV+NxcwMSCjpNmOzpLD2t79wwLtFVUHszXIJ/FlZCjaNLUemXDbr3IKgg/P0Kph2H6HUrh83hn3iZ9jEVBWafPhTRBjZbSO1yDztjmmHtqXMuWEBXpuBlpjOLCccu7Y2WvC1hZ+I7tmOMOF76jJXqplMvPISid6vguNHtKcbA69+ZLiqAcXTLVPkhD1DJb4m82R5GD9onk/t+5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9juwwA8Hx80o+TMwgVtaHMW94j2C7o8HSSP6SC9ZTQI=;
 b=nnvjmM+ykpKKi1l+al6G91R+yp+m27LXktk2XInNEEnqkilhRqBtgww5HWYejCZI5zkQ7KklgNY74wVjzZiBOZEL+ZPYnlZdBcNUU/n+FrHrKfg1BIC6gUP7vx4Yjxegr1B0gaGGVbjoXtMBtoqCe7kvNNDc8xiEhZHqAU6wWnFe8vWrP8plF1P04KSdgLgoNAH2WEzdPi0hZtJl1gIZFfQGtl3vFB3BistJzWsnvsQU3jY2a0ozn82wivdjq/8SAXi5mtjYzxNKHEFEI9xgO2y+aNqesU+4/DU3CqowaW8+er3mMpwcuN+wK1nd/pDnNv1wrUD/uwWUgErx/O8xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9juwwA8Hx80o+TMwgVtaHMW94j2C7o8HSSP6SC9ZTQI=;
 b=Y+ssTv0FIizckg9RCSVhaNKiR1ExgBE1NGQvDVrzC/M/68+QwenBpaCsVqvCxdVJUOUmVymau4Er4l9I7faKHORLuFiZa7n6gzP4uA7f+/FXnEUUPkJ7GWyRiuXrt+j+uEzwd8N/yhMvABx5tiaw+5EMwAsoHyhw6QgrnKMZBG4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB2862.namprd13.prod.outlook.com (2603:10b6:208:f1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 23:34:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 23:34:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGY+wEK6KvlxECYW5WP2WwW2KyI6csAgAClogCAAJfdAIAALDgA
Date:   Tue, 8 Feb 2022 23:34:19 +0000
Message-ID: <06e2a692e587d1ffcccd14d465136df228149e4c.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>   ,
 <164428557862.27779.17375354328525752842@noble.neil.brown.name>        ,
 <A677D8A9-FD0B-43E5-82D6-E660CCB8B185@redhat.com>
         <164435376000.27779.4059629372785561121@noble.neil.brown.name>
In-Reply-To: <164435376000.27779.4059629372785561121@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a940ad3f-6f65-4e2a-ab57-08d9eb5b874f
x-ms-traffictypediagnostic: MN2PR13MB2862:EE_
x-microsoft-antispam-prvs: <MN2PR13MB286268B1925392B97BA9C0C8B82D9@MN2PR13MB2862.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DyRNJhk42lde3klXYpEpjIE7J4yrWxzpP41VhMYDDdvc6KKcfbnqQb5LqKlfpI/DVncfBbFyOiY05fpFe0ttpe35/iiK5k3zEr9O9mAxP+tNazTesT2Om/8Cc+iLoJGwjNQC/eX01hcSMFU4mznksKuXMOBd6+1/3wa2VyhpcLzWaTAZbKuisW6K8JfcKQeAALNWe6IgrFxb7Zb4ghtxbXvWzXWzi16pjMEMlkkjU71ZTUm9vr640vKY38mRqTKZoQ/+S/0qHtTYN0ZOGgFQyKeccVGik7tL9JonilYh6FqhEv6zN0uKNA4/216BDSr8lEN248xDHMtXw7eAphnOir9MnP4MnqmlEYiiEgBLqM5vThF3ad5YuI37HeuyrXc9PT0MDswoGY43C+25QoNIAodzrtgzmyihQbaaXJahhxA2dyD8jJytHIx40VTHBQuGXd3hVcl8PjhoGXGDXgflQGlaPwVN5oplwPVq8scn1Gta4+Y2Y0ttgA8qK02YjDz7JMv+/M26wWw0HDUbiJzGOMFHqFqhUTZhxtFmVr30VUYmw13Dm6TLt+5CG7IL9T1Cjqk8zmyPgtySFwKWwWHIlwD16daMJ/1rOhWR6iurBhig8DPUOgZa9yZSDGf873WUcc8hHgSZ3gQjsxQIdPxLddCY9aGMVqebH0hOgWQzZrmlS5RaVVu8E1tpaiWIH/XTztggWWW3XeEL/O+jHlgH/NyWO2V7v1EUBEoKP13eb77OhuOydLpA/BuEREA2XKYyOwz4yYQ6jUU5XrE6IGBYo9ucoaQ1h6GEvj02365pJJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(26005)(86362001)(38100700002)(6506007)(36756003)(64756008)(66476007)(66556008)(8676002)(71200400001)(4326008)(66446008)(122000001)(316002)(2616005)(186003)(8936002)(966005)(6486002)(76116006)(110136005)(38070700005)(53546011)(66946007)(5660300002)(6512007)(83380400001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVZOQm9XdTU3U00wbzRYNWFqOTc1WmFLMHFMeTVkSU5LTXZySjR0NXk2OXg2?=
 =?utf-8?B?U0JFZGFBa0s0ZWlvWHhTQytjcUxXNk00TmhPY3VEYm1IeTJOZlQvMnh3b1N0?=
 =?utf-8?B?OXpacVZSd1MwUnJ6UEFZL1gvd0pvRTFBUEdvWjQ2eUVtc3ptY1pyNUIxZlpH?=
 =?utf-8?B?ai9uc00wWmg3WWVjU0RnZGJrSXdIRVlZczdvMmNXUzU0YUtJTyswczY3K2Mx?=
 =?utf-8?B?d2RkdGlueURSdjdyUDdpS3dIMnJPZDFtc1Y5eERidTQ0Y3ZoUjJuM1dsdnhK?=
 =?utf-8?B?b3JoUzFVV0gzWXFCVGpuejlPRGgyTzQ4MHp0eGRBS1o5SUlHZ0IvYUFoVVRB?=
 =?utf-8?B?Wk8zVWJrNGFITG4yMWIxa0VWRzBySFMvVE1US2tHaDFjL1BLZDFxdTNaYmJY?=
 =?utf-8?B?Y25WVjBqOVN3azd5SUhiQmNmekVGcjNZV1J3bTNlQUdINkFPd1gxRVVNbkhU?=
 =?utf-8?B?VWdScVN5V1drVlhIdmI0RCtCVVRSR2diRmFMSzB2QTJacnlGV1RnWEZXRzNk?=
 =?utf-8?B?K0tOVmc4OVNJbFFXb25IenFReGVTa1hXbjRNMm9EK1ZzckdOUEZYWUQ0Qnd4?=
 =?utf-8?B?V1hwNHhPNnBjMi9Idi9rQzA0b3YrelIzZVZaWXg2c2g4NVlXZE5MNm9ncm9D?=
 =?utf-8?B?VEdMdk8rZkVRZS9YV2tHdE5QTVFsQU9vNS90L1BhNVpnYmJ5d3NNdmNGbVl4?=
 =?utf-8?B?VEkrbGkramxzNmRkQkk3eW5reTBtTndzMzV4dVpqeGpXOGp3Y2ExVVhRTW5i?=
 =?utf-8?B?OVU2T3p4YVl6Q0N6MHkxdjJ5NXc1d3N4dUpLRFpFUUNLN2NodFZSOHBvaTZu?=
 =?utf-8?B?cUJpeXJJSUJmakpVaE5qaVFOSFNNUXFUVGQzdENDZWU5MHlLMXRMYVZhTnFE?=
 =?utf-8?B?MjZmQVJPVGkyb0szQTlyeU0ycTBlVU5ud20vemZkTW9zNDhTSjkxLy9PMXpR?=
 =?utf-8?B?T0t4cU03QjJ1L2JVNW1iY2sxTmlqbnpuQVN3SGZFTDgxQzNabmhjZzlnMTA2?=
 =?utf-8?B?YTVnRmxGMEpBd0RTSnRlMlI5NnFFakNOV0RoT2YrQUxuRjhMUHRISGtUaGJO?=
 =?utf-8?B?Y1djODNpRGRVcmh6ZzlCMHM5WGZBUG9hTGM5Q3Z4N2JUeGJTTTdieWpab3cv?=
 =?utf-8?B?Z2p0bE9SVGx6YUgvSTlCenZueXoydWgyaFV1OTlTeVJPcWFJYjdLeDIzTjc2?=
 =?utf-8?B?MkJ2MWFvWXdKY2hJbEJQUVBOVjNZVWU1dzZyWEJ2NXNVNXVlWnN0R3pGZGZo?=
 =?utf-8?B?WTZJUnZoaEdLMXYvTENkT05MRGduMVhnREdtbFJpTzhTSTZpTEd1RnI5Ui8z?=
 =?utf-8?B?S25UODNZMkVrVFdKMWYrQlBXL2dTWXpCQzJSK1NjZ3h3amtyYjFhWVRSUjRl?=
 =?utf-8?B?dGo0bDQrZ25zYzFWRkZ2SlN4aktEVTR1Y2llenAyZEF3TzNKR2xFZU1yc0h6?=
 =?utf-8?B?bUZMeG9WRnJvWHhsMnNLM21CU0VveVdpeGd0L1FPNW1pOW9zMlRnRllEQmg4?=
 =?utf-8?B?V2IzR3RSRFJxYXcwRzZuSm9aQURMYWVNTDNXNGkyL2dGajNvN3VBTEVqM1Uw?=
 =?utf-8?B?a0dHV1VBSzVrc2E2R1FaODlGZEswWUJ2VGRrelNjV3hVc3Y1VDJmd0d1ZkdF?=
 =?utf-8?B?K2srMmpFKzh6b1FwbTAvbVRuZXdBWWxMbkl2Q3kvcndkQm0xbG9vNGtKcDNo?=
 =?utf-8?B?aS8vQUxoNUFXcVJnL1IzQmpiZ3dKT1VDa3E1K25pUUF0U3FoMTNWQmF6SHZu?=
 =?utf-8?B?K2J1eUUwSUx3ZU5OVlBiNldjUHltN1pXeFJ0QUY0V2U0R2xVSHZNUHNWdm9x?=
 =?utf-8?B?YVRuSno3TWEvR3Q1YTRtWmlqZW9DY09GTkFFNlVMV2ZnZTBaYnAxSk9NdFZE?=
 =?utf-8?B?L0NSNkVkQkE5ellPVC8wb1Z5SjkyTnZJZGMyWCtBTEdRU2k5SHdyaEE3bEZO?=
 =?utf-8?B?VXpVWm0zYjh5Snl3cnZRUkwvbU56a0hHWUdkZUlIdkNWblBJNmlwb3U5UU5z?=
 =?utf-8?B?WTBRekVwcTlpaFdjcTNFQjZwYnBhb3hFRWdvTkZraGdwMDMvdkZMUzFKdFE3?=
 =?utf-8?B?S2IyTHNJVnRlODRyZitPSENBcEJjWnZXTnJkZTR0ellpN0RKTzZXeWlqRFFk?=
 =?utf-8?B?dWlyejAybkI4K2Vhdm02NVBJdGkxamljSXU4eVdSQmtmMTlkNG4xQ2E1QVZa?=
 =?utf-8?Q?ToVwTB4LA+63Th26kqSDo4M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <352EDC463B69BA4984745322B586BD6B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a940ad3f-6f65-4e2a-ab57-08d9eb5b874f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 23:34:19.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7x1jJMniE4JzRJLHP9/j4UWWldkDz8r6rzC8+Gdpvqv49fofnSHBRKsBuNyq2vUShnA3kAbjkPvmPjmJrU/qcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAyLTA5IGF0IDA3OjU2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMDggRmViIDIwMjIsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4gT24gNyBG
ZWIgMjAyMiwgYXQgMjA6NTksIE5laWxCcm93biB3cm90ZToNCj4gPiANCj4gPiA+IE9uIFN1biwg
MDYgRmViIDIwMjIsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4gPiA+IEhpIGFsbCwN
Cj4gPiA+ID4gDQo+ID4gPiA+IElzIGFueW9uZSB1c2luZyBhIHVkZXYoLWxpa2UpIGltcGxlbWVu
dGF0aW9uIHdpdGgNCj4gPiA+ID4gTkVUTElOS19MSVNURU5fQUxMX05TSUQ/DQo+ID4gPiA+IEl0
IGxvb2tzIGxpa2UgdGhhdCBpcyBhdCBsZWFzdCBuZWNlc3NhcnkgdG8gYWxsb3cgdGhlIGluaXQN
Cj4gPiA+ID4gbmFtZXNwYWNlZCB1ZGV2DQo+ID4gPiA+IHRvIHJlY2VpdmUgbm90aWZpY2F0aW9u
cyBvbg0KPiA+ID4gPiAvc3lzL2ZzL25mcy9uZXQvbmZzX2NsaWVudC9pZGVudGlmaWVyLCB3aGlj
aA0KPiA+ID4gPiB3b3VsZCBiZSBhIHByZS1yZXEgdG8gYXV0b21hdGljYWxseSB1bmlxdWlmeSBp
biBjb250YWluZXJzLg0KPiA+ID4gDQo+ID4gPiBDb3VsZCB5b3Ugd2FsayBtZSB0aHJvdWdoIHRo
ZSByZWFzb25pbmcgaGVyZSAtIG9yIHBvaW50IG1lIHRvDQo+ID4gPiB3aGVyZSBpdA0KPiA+ID4g
aGFzIGJlZW4gZGlzY3Vzc2VkLg0KPiA+IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW5mcy8yMDIxMDQxNDE4MTA0MC43MTA4LTEtc3RldmVkQHJlZGhhdC5jb20vDQo+IA0KPiBU
aGFua3MuwqAgSSBkaWQgcmVtZW1iZXIgdGhhdCBkaXNjdXNzaW9uIHRob3VnaCBpdCB3YXMgaGVs
cGZ1bCB0bw0KPiByZWZyZXNoDQo+IG15IG1lbW9yeSwgYW5kIHRvIGJlIHN1cmUgdGhlcmUgaXMg
bm90aGluZyBlbHNlLg0KPiANCj4gPiANCj4gPiA+IEl0IHNlZW1zIHRvIG1lIHRoYXQgbW91bnQu
bmZzIGlzIHRoZSBwbGFjZSB0byBzZXQNCj4gPiA+IG5mc19jbGllbnQvaWRlbnRpZmllci4NCj4g
PiA+IEl0IGNhbiBiZSB0b2xkICh2aWEgL2V0Yy9uZnMuY29uZiBvciAvZXRjL25mc21vdW50LmNv
bmYpIGhvdyB0bw0KPiA+ID4gZ2VuZXJhdGUNCj4gPiA+IGFuZCB3aGVyZSB0byBzdG9yZSB0aGUg
aWRlbnRpZmllci7CoCBJdCBjYW4gY2hlY2sgdGhlIGN1cnJlbnQNCj4gPiA+IHZhbHVlIGFuZA0K
PiA+ID4gdXBkYXRlIGlmIG5lZWRlZC7CoCBBcyBsb25nIGFzIHRoZSBpZGVudGlmaWVyIGlzIHNl
dCBiZWZvcmUgdGhlDQo+ID4gPiBmaXJzdA0KPiA+ID4gbW91bnQsIHRoZXJlIGlzIG5vIHJ1c2gu
DQo+ID4gPiANCj4gPiA+IFdoeSBkb2VzIGl0IG5lZWQgdG8gYmUgZG9uZSBpbiByZXNwb25zZSB0
byBhIHVldmVudD8/DQo+ID4gDQo+ID4gSSB0aGluayB0aGUgYXNzZXJ0aW9uIHdhcyB0aGF0IGl0
IHdhcyB0aGUgb25seSBzZW5zaWJsZSB3YXksIGFuZCBpdA0KPiA+IGRvZXMNCj4gPiBzZWVtIHRv
IGJlIGJldHRlciB0aGFuIGV4cG9zaW5nIHlldCBhbm90aGVyIGtub2Igd2hlbiBhbGwgdGhhdCdz
DQo+ID4gbmVlZGVkIGlzIGENCj4gPiB3YXkgdG8gZGlzdGluZ3Vpc2ggYW5kIHBlcnNpc3QgTkZT
IGNsaWVudHMgd2hlbiBuZXR3b3JrIG5hbWVzcGFjZXMNCj4gPiBjYW4gY29tZQ0KPiA+IGFuZCBn
byBhdCBhbnkgdGltZSwgYW5kIHRoZXJlIGNhbiBiZSBhIGxvdCBvZiB0aGVtLg0KPiANCj4gImFz
c2VydGlvbiIgaXMgYW4gYXB0IHdvcmQuwqAgVGhlcmUgd2Fzbid0IGEgd2hvbGUgbG90IG9mIHJl
YXNvbmVkDQo+IGFyZ3VtZW50LCBtb3N0bHkganVzdCBhc3NlcnRpb25zLg0KPiANCj4gVGhlIGJl
c3QgYXJndW1lbnQgd2FzIHRoYXQgIm5mcy5jb25mIGlzIG5vdCBuYW1lc3BhY2UgYXdhcmUiLCB3
aGljaA0KPiBpcw0KPiBvbmx5IHNvbWV3aGF0IHRydWUuwqAgVXNpbmcgImlwIG5ldG5mcyBleGVj
IiB3aWxsIG1ha2UNCj4gbm9uLW5hbWVwc2FjZS1hd2FyZSB0b29scyB3b3JrIGNvcnJlY3RseSBp
biBuYW1lc3BhY2VzIHByb3ZpZGluZw0KPiB0aGVpcg0KPiBjb25maWcgZmlsZXMgYXJlIGluIC9l
dGMvbmV0bnMvTkFNRSAtIHRoZXkgZ2V0IGJpbmQtbW91bnRlZCBvdmVyIHRoZQ0KPiBmaWxlcyBp
biAvZXRjLg0KPiBBbmQgb2YgY291cnNlIC9ldGMvbmZzLmNvbmYgY2FuIGJlIE1BREUgbmFtZXNw
YWNlIGF3YXJlLg0KPiANCj4gVGhlcmUgaXMgYWxzbyBhIHJlYXNvbmFibGUgYXJndW1lbnQgdGhh
dCBhdXRvLWVkaXRpaW5nIC9ldGMvbmZzLmNvbmYNCj4gcmlza3MgY29sbGlzaW9uIHdpdGggYW4g
YWRtaW4sIGJ1dCB0aGF0IGlzIHdoeSB3ZSBoYXZlDQo+IC9ldGMvbmZzLmNvbmYuZA0KPiANCj4g
Rm9yIG1lLCB0aGUgd2Vha2VzdCBwYXJ0IG9mIHRoZSBTdGV2ZSdzIGNhc2Ugd2FzIHRoYXQgaGUg
cHJlc2VudGVkIGl0DQo+IGFzDQo+ICJzZXR0aW5nIG1vZHVsZSBwYXJhbWV0ZXJzIHZpYSBuZnMu
Y29uZiIgcmF0aGVyIHRoYW4gImNvbmZpZ3VyaW5nDQo+IGNsaWVudA0KPiBpZGVudGl0eSB2aWEg
bmZzLmNvbmYiLsKgIEEgbnVtYmVyIG9mIHRoZSBlYXJseSBuZWdhdGl2ZSByZXNwb25zZXMNCj4g
d2VyZQ0KPiBmb2N1c2VkIG9uIHRoZSBkaXN0cmFjdGlvbiBvZiBhIG1vZHVsZSBwYXJhbWV0ZXIg
YmVpbmcgaW52b2x2ZWQuDQo+IA0KPiBUaGUgd2Vha25lc3MgZm9yIHRoZSBhbHRlcm5hdGl2ZSwg
b2YgY291cnNlLCBpcyB0aGUgZmFjdCB0aGF0IHVzaW5nDQo+IHRoZQ0KPiB1ZGV2IG1lY2hhbmlz
bSByZXF1aXJlcyBydW5uaW5nIHVkZXZkIGluIGVhY2ggbmV0d29yayBuYW1lc3BhY2UsDQo+IHdo
aWNoDQo+IGlzIGFuIHVubmVjZXNzYXJ5IGJ1cmRlbi4NCj4gDQo+IFNvIEkgc3RpbGwgU1RST05H
TFkgdGhpbmsgdGhhdCB0aGUgaWRlbnRpdHkgc2hvdWxkIGJlIHNldCBieQ0KPiBtb3VudC5uZnMN
Cj4gcmVhZGluZyAoYW5kIHdyaXRpbmcpIHNvbWUgZmlsZSBpbiAvZXRjIG9yIC9ldGMvbmV0bmZz
L05BTUUsIGFuZCBJDQo+IHdlYWtseSB0aGluayB0aGF0IHRoZSBmaWxlIHNob3VsZCBiZSBpbiAv
ZXRjL25mcy5jb25mLmQvIHNvIHRoYXQgdGhlDQo+IHJlYWRpbmcgaXMgYXV0b21hZ2ljLg0KPiAN
Cg0KTm8uIEl0J3Mgbm90IGEgcGVyLW1vdW50IHNldHRpbmcsIHNvIGl0IGhhcyBubyBidXNpbmVz
cyBiZWluZyBpbiB0aGUNCm1vdW50IHByb3RvY29sLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
