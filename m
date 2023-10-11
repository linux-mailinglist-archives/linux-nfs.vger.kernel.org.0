Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2C87C56EA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjJKOds (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjJKOdr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 10:33:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736C90
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 07:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEa7FSqd6KGrsOfOyflPXeuNqHH04QU9FpIsD5fl3nSBbARXWTS6KGv2xuZWUmylZq7CCouiYgKshSKoT9HXdUMtaWJj9kTQ4gMVv5kUCNySLiZNRzC0wNGstSVIT03wnvS0vjFfjxQ4tbF+3lX+QXzXM+k20f7ANESLVhoJ+WsTb/+LlwHtmxHu4UXYz1z737WuBohZKc/gT97K/VuKjfo6Wmc+w/ruzaGsmruUqUamgpmdo0BWCDNfRVGmTqAMhXjjZLygsUPdZEnXIn35IpL/0K7DmFH322xWeOyx2wXYKwyznzRiiKpZHLNO/WhzhzHfiBzbewS9Q8Wmox846w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7tPRBpk+uaS8pve6RrNwy2mc5YlL3J4cWPFdxEgKh8=;
 b=Scm7paHGwpe18vKcreGCUTgJe1ccn6LVk+ldRJkk5F4hU8E07wjsxfxNuPB6qzGSz0121kNco6dzFpFl3YR1bSnYF/iNQAujWZkSTKPGHYQSXZ/yQaPmpLi2FLhOlI8ucW1YungYi7P1NOhxS28Aw1UctBWabGJOUnH/iJBLiC0DL7NORCVNF+L03HOIcrknzoM3oybxMOG4MOBo9cNh9nscwvY4RN75ud0rzNwOnbOx0akJzjx3YzPBnjTqngg4EFc8a1y6cq3aa4F2xLkvu8vegUoygirnoa8bPYba7XhvqZ1a7sEu76TYwNzFHXjCeDlT+yzZ7tJMf77e0LFnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7tPRBpk+uaS8pve6RrNwy2mc5YlL3J4cWPFdxEgKh8=;
 b=PHuwlTlNdjPa7yKzGcugOc/W2Utc+8dHZK8XFL+wtOiOm3r74Q52cr2ZAdxOcv/jtYIfqB+YWFS18hfuGcFjpix6TDFg/XyrznjhcPrGmOXBxmYiEjujmQVuTBqqnLIn+3aEHL9z/bGP2TXlQn0gtMtpsJjati8guKciJCkDnAw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB3981.namprd13.prod.outlook.com (2603:10b6:806:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 14:33:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a927:9364:531e:6924]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a927:9364:531e:6924%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 14:33:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "steved@redhat.com" <steved@redhat.com>
Subject: Re: help with understanding match_fsid() errors in nfs-utils
Thread-Topic: help with understanding match_fsid() errors in nfs-utils
Thread-Index: AQHZ8OfE9RNLBpL0OUu1L/KY8Cstj7AvSvOAgBR49ICAAPohAA==
Date:   Wed, 11 Oct 2023 14:33:41 +0000
Message-ID: <ef541757917da9d3f5a470bbfb23108472d1f455.camel@hammerspace.com>
References: <169578061136.5939.6687963921006986794@noble.neil.brown.name>       ,
 <7e00fd2c44df1bc34c219902498d95cb811de850.camel@hammerspace.com>
         <169698110394.26263.6881855622649039694@noble.neil.brown.name>
In-Reply-To: <169698110394.26263.6881855622649039694@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA0PR13MB3981:EE_
x-ms-office365-filtering-correlation-id: 9c509f30-4731-40aa-aa55-08dbca6710c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Br4Wrx6n/NdP+fsHf9/ZIWbeT/i4+hQWqTBtNUfo6QKTb/111PuVmokGHbMPFKhDt38KCV73MfmGJke7kTAy35Q6wu+Ny7O/IC/VU7aP5wQ+ddf1qDGynKq6icrm/jzVs1pr0QnYDnJABc3nW/kM32HGDdHInLQKXnjazRWJMgmwRAoYYOSieRQbQ47802KGhn3hTnRKiE+jlzocejX1rjGICBNQxl3LD56sUYFnToVh7tjbXY6GVvQol43QZZlTJJW8TL2Tw4w1NOJGF0pV9Ts5bUOEXvWYty92rLy1/O4St9FpfaesfouaBCqPhcHfr/nvC7Sn75dAJFcNx43BdFCKvBzdquclgODahMQ5m21TNSEKsA9ckvHgleNJL2dvDEOF+sU5MiavnrfXpNDZK3YambH/ktxXO7UndFTZ4gxEXWDGl2tkTHoex4f91X9u16bMc2iNcps0KN2TAT6LW7r7+WP5C4tJTDhnFaqBjBKN8GLjGy3fqyohDyJYmesEieBy6wgL355JCPOS4RtP7jDBTmzn1nwFVSHQRqj8GTYu6ID8b7Nv8t4ewdByC9ruY1BBDUibSrufj+PrqZEJvKE8OXajxqVV0koIpiNCldncKJCH5XAt5VLwrSik+qDpxu3QfI3O0Ya8spsGsIrdrhiS2ZexlFDKOU8JOAuPgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(346002)(376002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6512007)(26005)(6486002)(478600001)(6916009)(71200400001)(2616005)(8676002)(6506007)(66556008)(83380400001)(316002)(2906002)(4001150100001)(76116006)(66446008)(91956017)(54906003)(5660300002)(66946007)(66476007)(64756008)(4326008)(8936002)(41300700001)(86362001)(38070700005)(36756003)(38100700002)(122000001)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FYdU1RU2NHeS85SERiejBzZFR6ekFpMkJCWVNhYjRmcnNsc2RvZDhYQUVa?=
 =?utf-8?B?Snpkd0FOMDNKVnh5N1BmSC9ScEF3T1lRY25IdVdXN0Vhc0gxYjkvWFZhcmsw?=
 =?utf-8?B?K1l0a0NqQzZlMFkveG1oZkRPOG1GWG5QZjlnRlpOL1EwYThxWXc2NFFzdkdO?=
 =?utf-8?B?aGNCU252S2JDOS9yMFJBS2FTUG10aGZXWmhRbzRhMUFzczlzYkE5MTErd3A2?=
 =?utf-8?B?b0NscVNIYzZYeGpxb3Uzd083SDUzUVB6KzFBUWJEOGNNMERVd1M1RWEraENw?=
 =?utf-8?B?UUh0YjZ1aHQwK21iQ2NyWUVzQmFzc256bDZwNkhwanN6VHpPNlRKWDJEODM2?=
 =?utf-8?B?Vm42NjhnTG1pL3RSU2I3SlBrRFd1UjNvNHdFQm1lUHBZVXh0NGtDTWV5SXNi?=
 =?utf-8?B?MEc5bEwwOVUxWjMxelBQalA3bzd3MzRLTzhzNkw5c2YvUy9kUWRFU291S0Y5?=
 =?utf-8?B?SXlGbkphZTNWRWp0Wi8wL0ZFUFlHZFRFRlZOelQ5MUQzL0VFNmtvL2RiUXJq?=
 =?utf-8?B?amF6ZDZTNHZndS9YNEZjZ1hLVnByTjVmeER1VHJPTFZhQUJtV3IzbHBnMk1u?=
 =?utf-8?B?MmQ3US8xVmxFWlhPR3kya1lsQmFVZzJESkVtOFNOMmFDNEE5SFFvbUJ0enhZ?=
 =?utf-8?B?c1hTTmorTXl4Y3JBR3ppWEd1YUZlWVdIK1dsL3NKRXBEbS9qOUlTV2M2NUN1?=
 =?utf-8?B?U2kveUc0UndKY1lYdnBJeTdkRjNkNEJUSmpOM2NEc1IyRDV4ZVBSSkFac0l6?=
 =?utf-8?B?QnVrOEFvUE90RTJ0ZW5IZXRTV3JyOGdEeG5FNjcwK25RUjlLeTFUbjFkUS9m?=
 =?utf-8?B?VHRNYVhBNnFSOTFlWEwyVkljY2p0VUV3NnNPQ29EbktZSXhxdVkxQTh4UG1S?=
 =?utf-8?B?aXFaM08vTEl6UE1VcUc0YVZXVkxob3VVVHM4WDJ2TVdOMnJ1TlBTMnljUE00?=
 =?utf-8?B?LzhiU040U0Y1YXBxdlVyT2xDN3cwVlFwWVJGaFF4ZDRpajBKVUlzSWgzNTh3?=
 =?utf-8?B?NU95KytKYWVvenlJQ0g1WEc4YmNwTUZYR3hvTDZySDIxcXdzcFNhaEFmMERD?=
 =?utf-8?B?ZC9MMGJ1L2J6anVaWkdGRUZ1UkZnZmtEZFdQRTVHSzJBcEdWRzNoZnVKUWc1?=
 =?utf-8?B?NnBQUlpvbWh2NEZiUDZjblp4MDBVZzR3VkNVMDE4aitJdHdOMzJ1MGlkcFY4?=
 =?utf-8?B?REUwUHdBbW5ORWNwaGJ4dlRQakFmT25HeEcza25yWWlNMzJrYWxXWVlYR2Y3?=
 =?utf-8?B?VlpLNE5LVGFyN1VFVkI5MlJGR0dkOFpuWXUvZ2pUa3FOa0J3TkxRM3pyWUgw?=
 =?utf-8?B?RXYxOW1BaTZCb1NodUc0eEYzOUhRNHZNYjJZUEdLL2hsempXaVhaWTNVMGtQ?=
 =?utf-8?B?Qy9RYzAzK2lscm9JaEJYdnhsaUhUNzhNbmthbmh5WTBjUzR3M0poZjU2Q3l2?=
 =?utf-8?B?NENJMW5abktGQTFpOVNwVFpKc21JcXUvdlRQNCtaYTE0aitjdmcvZkNyYncz?=
 =?utf-8?B?QkNiWXVabzhmQWRMTUg5dmZlVE5mbEZJWUxLRDNuQWRLSU43djlFNEJ1YWNy?=
 =?utf-8?B?Sk9uR0I3SXJPM2JjeEhRTGtiVUdueWlSczhvNW92eVpkUEtySUtZNmRZeVNH?=
 =?utf-8?B?MzZVTWVzWnV4NkdrSFB6Smd0d3RNWGlFNkdxbUF0RGtxc2NSV2ViS3J1aXp4?=
 =?utf-8?B?ZVM3U3piV0t0aEU5QWZiVFA2aHdtUlhBSmUxY0FzRTc5TXRRbnV6SGN5bkxH?=
 =?utf-8?B?MXpaUFU0K05ZMUNMMkx6WGNHcjh0Qy9kWHd1MkdRcGs3UnZGZGxMQjhFRGVB?=
 =?utf-8?B?eXNSRW1aNFVpV1J4b0JlMEMzcnZGTS9mV2JCYlpPNEVUL0dYT09tTmhHdzRC?=
 =?utf-8?B?KzRMTFBnU29RVWNFa1ZTOTJRTlg2R2t4Y2ZjYytNcW1uNVdIV0dWVDVUWkhw?=
 =?utf-8?B?dTVhRnNIMGVlVGV0S0RXSzJKMkd0ZGwwelRDUWp0eEZnUm5DYXJoOW1ycXly?=
 =?utf-8?B?WWlldXBJR2NmZEhuWWp5ZjZOdk8zU0ZhN08xaUxCeVNXd1RmNG5XTXQ1cHl4?=
 =?utf-8?B?SlI3YXBWeUw5L2VhTGtUSmNGbnJvNTM0d3k2cFhpMlhyWFF1VGxNRHhJZ04x?=
 =?utf-8?B?RXhRNHZKc1NvK0E1SThIdko0T09ET2dnTTZ1TkxZazlCTmhNa3VXd0g4OWQw?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E879EE227372EA4D96DBA750685CD9D5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c509f30-4731-40aa-aa55-08dbca6710c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 14:33:41.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8fZkPF4acl12oZ5H+bMy9Vgj7PbrDWw4M2rp33torJL8DwpdunEs8y1b1Iu32UxUBoNBgOHYTe1e7/h+/ce+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTExIGF0IDEwOjM4ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFRodSwgMjggU2VwIDIwMjMsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MjMtMDktMjcgYXQgMTI6MTAgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
aGkgVHJvbmQsDQo+ID4gPiDCoEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZA0KPiA+ID4gDQo+ID4g
PiDCoENvbW1pdCA3NmMyMWUzZjcwYTggKCJtb3VudGQ6IENoZWNrIHRoZSBzdGF0KCkgcmV0dXJu
IHZhbHVlcyBpbg0KPiA+ID4gbWF0Y2hfZnNpZCgpIikNCj4gPiA+IA0KPiA+ID4gwqBpbiBuZnMt
dXRpbHMuDQo+ID4gPiANCj4gPiA+IMKgVGhlIGVmZmVjdCBvZiB0aGlzIHBhdGNoIGlzIHRoYXQg
aWYgYSAnc3RhdCcgb2YgYW55IHBhdGggaW4NCj4gPiA+IMKgL2V0Yy9leHBvcnRzIG9yIGFueSBt
b3VudHBvaW50IGJlbG93IGFueSBwYXRoIG1hcmtlZCBjcm9zc21udA0KPiA+ID4gZmFpbHMNCj4g
PiA+IMKgd2l0aCBhbiBlcnJvciBvdGhlciB0aGFuIG9uZSBvZiBhIHNtYWxsIHNldCwgdGhlbiB0
aGUgZnNpZCB0bw0KPiA+ID4gcGF0aA0KPiA+ID4gwqBsb29rdXAgYWJvcnRzIHdpdGhvdXQgcmVw
b3J0aW5nIGFueXRoaW5nIHRvIHRoZSBrZXJuZWwsIHNvIHRoZQ0KPiA+ID4ga2VybmVsDQo+ID4g
PiDCoGRvZXNuJ3QgcmVwbHkgdG8gdGhlIGNsaWVudCBhbmQgdGhlIG1vdW50IGF0dGVtcHQgYmxv
Y2tzDQo+ID4gPiBpbmRlZmluaXRlbHkuDQo+ID4gPiANCj4gPiA+IMKgSSBoYXZlIHNlZW4gdGhp
cyBoYXBwZW4gd2hlbiAiLyIgaXMgZXhwb3J0ZWQgY3Jvc3NtbnQsIGFuZCB3aGVuDQo+ID4gPiBh
DQo+ID4gPiBzdGF0DQo+ID4gPiDCoG9mIC9ydW4vdXNlci8xMDAwL2RvYyByZXR1cm5zIEVBQ0NF
Uy7CoCBUaGlzIGlzIGEgImZ1c2UiIG1vdW50DQo+ID4gPiBmb3INCj4gPiA+IHVzZXINCj4gPiA+
IMKgMTAwMCwgYW5kIHByZXN1bWFibHkgaXQgcmVqZWN0cyBhbnkgYWNjZXNzIGZyb20gYW55IG90
aGVyIHVzZXIuDQo+ID4gPiANCj4gPiA+IMKgQ291bGQgeW91IHBsZWFzZSBoZWxwIG1lIHVuZGVy
c3RhbmQgd2hhdCB0aGlzIHBhdGNoIHdhcyB0cnlpbmcNCj4gPiA+IHRvDQo+ID4gPiDCoGFjaGll
dmU/wqAgV2hhdCBzb3J0cyBvZiBlcnJvcnMgd2VyZSB5b3UgZXhwZWN0aW5nIHRoaXMgdG8gY2F0
Y2g/DQo+ID4gPiDCoFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gc2lsZW50bHkgaWdub3JlIHRoZSBz
dGF0IGZhaWx1cmUgZm9yDQo+ID4gPiBwYXRocw0KPiA+ID4gdGhhdA0KPiA+ID4gwqB3ZXJlIGZv
dW5kIHdoZW4gc2Nhbm5pbmcgdGhlIG1vdW50IHRhYmxlLCBhbmQgb25seSB0YWtlIHRoZSBtb3Jl
DQo+ID4gPiDCoGRyYXN0aWMgYWN0aW9uIGZvciBwYXRocyBleHBsaWNpdGx5IGxpc3RlZCBpbiAv
ZXRjL2V4cG9ydHMgPz8NCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gVGhlIHBvaW50IGlzIHRo
YXQgaWYgdGhlIGZpbGVzeXN0ZW0gaXMgcmUtZXhwb3J0ZWQgTkZTLCBhbmQgeW91DQo+ID4gbW91
bnQNCj4gPiBhcyAnc29mdGVycicgaW4gb3JkZXIgdG8gYXZvaWQgaGFuZ2luZyB5b3VyIGtuZnNk
IHNlcnZlciBvbg0KPiA+IGVwaGVtZXJhbA0KPiA+IGVycm9ycywgdGhlbiB5b3UgaGF2ZSB0byBi
ZSBtb3JlIGNhcmVmdWwgYWJvdXQgd2hpY2ggZXJyb3JzIGFyZQ0KPiA+IGZhdGFsLA0KPiA+IGFu
ZCBoZW5jZSBuZWVkIHRvIGJlIHByb3BhZ2F0ZWQgdG8gdGhlIGtlcm5lbCBleHBvcnQvcGF0aCBj
YWNoZSwNCj4gPiBhbmQNCj4gPiB3aGljaCBvbmVzIGFyZSBqdXN0IHRlbXBvcmFyeSBkdWUgdG8g
YSBuZXR3b3JrIHBhcnRpdGlvbiBvciBzZXJ2ZXINCj4gPiByZWJvb3QuDQo+ID4gDQo+ID4gSGVu
Y2UgdGhlIGNyZWF0aW9uIG9mIHBhdGhfbG9va3VwX2Vycm9yKCkgd2hpY2ggZGlmZmVyZW50aWF0
ZXMNCj4gPiBiZXR3ZWVuDQo+ID4gdGhlIHR3byBjYXNlcy4NCj4gDQo+IFRoYW5rcyBmb3IgdGhl
IGV4cGxhbmF0aW9uIC0gYW5kIHNvcnJ5IGFib3V0IHRoZSBkZWxheSBpbiBmb2xsb3dpbmcNCj4g
dXAgLQ0KPiBsZWF2ZSBhbmQgc3R1ZmYuLi4uDQo+IA0KPiBJZiBJIHVuZGVyc3RhbmQgdGhlICdz
b2Z0ZXJyJyBvcHRpb24gY29ycmVjdGx5LCB0aGUgcGFydGljdWxhciBlcnJvcg0KPiBjb2RlIHlv
dSBuZWVkIHRvIGNhdGNoIGluIHRoaXMgY2FzZSBpcyBFVElNRURPVVQuwqAgVGhhdCBpcyB0aGUg
ZXJyb3INCj4gdGhlDQo+IG1vdW50ZCB3b3VsZCBnZXQgd2hlbiBzdGF0aW5nIGFuIE5GUyBtb3Vu
dCB0aGF0IHdhc24ndCByZXNwb25kaW5nLg0KPiBTbyBpdCB3b3VsZCBiZSBzYWZlIGZvciBtZSB0
byBhZGQgRUFDQ0VTIHRvIHRoZSBzZXQgb2YgZXJyb3JzIHRoYXQNCj4gcGF0aF9sb29rdXBfZXJy
b3IoKSBjaGVja3MgLSBqdXN0IGFzIGxvbmcgYXMgSSBkb24ndCBhZGQgRVRJTUVET1VULg0KPiBE
byB5b3UgYWdyZWU/DQo+IA0KDQpJIHRoaW5rIHRoYXQgc2hvdWxkIGJlIHNhZmUsIGJ1dCBpdCBp
cyB3b3J0aCB0ZXN0aW5nLiBJIGRvbid0IHJlbWVtYmVyDQpleGFjdGx5IHdoeSBJIGV4Y2x1ZGVk
IEVBQ0NFUyBmcm9tIHRoZSBsaXN0Lg0KDQo+IEJ1dCBJIHRoaW5rIHRoZXJlIGlzIGFub3RoZXIg
aXNzdWUgaGVyZS7CoCBJZiB0aGUgJ3N0YXQnIG9mIHRoZQ0KPiBtb3VudHBvaW50IHJldHVybnMg
RVRJTUVET1VUIHdlIHdhbnQgYSB0cmFuc2llbnQgZmFpbHVyZSBzbyB0aGF0IHRoZQ0KPiBrZXJu
ZWwgd2lsbCBhc2sgYWdhaW4gLSBwcmVzdW1hYmx5IHdoZW4gdGhlIGNsaWVudCBhc2tzIGFnYWlu
Lg0KPiBUaGF0IGRvZXNuJ3QgaGFwcGVuIHdpdGggdGhlIGN1cnJlbnQgY29kZS7CoCBXaGVuIHRo
ZSBrZXJuZWwgcXVldWVzIGENCj4gcmVxdWVzdCB0byBtb3VudGQsIGl0IGFzc3VtZXMgdGhhdCB0
aGUgcmVxdWVzdCBXSUxMIGJlIGFuc3dlcmVkLsKgIEl0DQo+IG5ldmVyIHJlc2VuZHMgdGhlIHNh
bWUgcmVxdWVzdC4NCj4gDQo+IFNvIG1vdW50ZCBtdXN0IHJlcGx5IHdpdGggc29tZXRoaW5nLsKg
IEkgdGhpbmsgdGhhdCByZXR1cm5pbmcgYQ0KPiBuZWdhdGl2ZQ0KPiByZXN1bHQgd2l0aCBhbiBl
eHBpcnkgdGhhdCBoYXMgYWxyZWFkeSBwYXNzZWQgbWlnaHQgaGF2ZSB0aGUgZGVzaXJlZA0KPiBy
ZXN1bHQsIGJ1dCB3ZSB3b3VsZCBuZWVkIHRvIHRlc3QgdGhhdC4NCj4gDQoNCklkZWFsbHksIHdl
IHByb2JhYmx5IG5vcm1hbGx5IHdhbnQgdG8gcGFzcyB0aGUgZmlsZXN5c3RlbSBlcnJvciBkb3du
DQppbnRvIGtuZnNkIHNvIHRoYXQgaXQgY2FuIGRvIHRoZSByaWdodCB0aGluZy4gRm9yIEVUSU1F
RE9VVCwgdGhhdA0Kc2hvdWxkIHJlc3VsdCBpbiBhbiBORlM0RVJSX0RFTEFZL05GUzNFUlJfSlVL
RUJPWCBiZWluZyBzZW50IHRvIHRoZQ0KY2xpZW50LCB3aGljaCBpcyB3aGF0IHdlIHdhbnQgaGVy
ZS4NCg0KSSdtIG5vdCBzdXJlIGFib3V0IGNhY2hpbmcgdGhlc2UgZXJyb3JzLiBJdCBzZWVtcyB0
byBtZSB0aGF0IHdoaWxlDQpFVElNRURPVVQgbWlnaHQgYWxsb3cgYSB0aW1lLWJvdW5kZWQgY2Fj
aGUsIHRoZSBFQUNDRVMgaXMgYSBwZXItdXNlcg0KZXJyb3IsIHNvIGNhbid0IHJlYWxseSBiZSBj
YWNoZWQgdW5sZXNzIHlvdSBhcmUgYWJsZSB0byBjYWNoZSBpdCBhcyBhDQpwZXItdXNlciB0aGlu
ZyBpbiBrbmZzZC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
