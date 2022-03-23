Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF584E5BB3
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 00:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbiCWXL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiCWXL2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 19:11:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222D5523C
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 16:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEQKfHcplAWmdqFBNJbipj++iikPpTjZRj23Y0orZrllh2TV+k1OriitRORQ+5m5/vGpxXv7bExG/BsVS6hFcBZ2bXlD4EDcUZQCV7ff3w8jwUr24xBGApxh5xOdlQfdzT18m8b1UIzPO7VpeafWog5QjN+6Cea63ti7FfreZOfEZ9wGqX39nkXaOK/LXxVirIahPn9tnlN95YgY2OFxoh5ruTu3jFIaxrG/R4zkza54N/1y85wp5Kew7xdKOJaWodIoFypEj3DZQXG7AWXRDhslKmEKgnVc8H9KEaLpNMALi8Tv764T7VzJno79Gt3dBFVSr8bEWvro4b/Nhoh/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sPNLI/RvelqkU9F6UZkeOYPIkoOoNiNd6yhYd2FWJY=;
 b=ncZKzdtYfZOxBBlT+EJodtx2Lpca9fwHf2VZJ5jAGe3avLnHKUbjBUc7hJACVtDAPfI3hSl+QiZLKBxnYfE66H6shCAjYJuL3N9PtViL+7fOoGvAiqZ79/+4aPwfB21xQB/tzcj0nw05NjXNyvUNMkopFgq2LRYl2dALj+Is+eEHaRwctK2xYwGD/+hxMJHCbti3m/YaguYpDGgjuYEKWy0Rgk07l7aMk9MHexw7m7Y4ZO7tBty3V5MLvtT73TehQIl1cm8TEwYTSdPjqY9FE0psPZo4DRyfN0tD7M+4Oorqvk1J74AmZIQIk3bMg+hGmlqYLiotYKou7gSEaZTImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sPNLI/RvelqkU9F6UZkeOYPIkoOoNiNd6yhYd2FWJY=;
 b=TPhB9GunZ5jj6tM2SsNU9Pj2dWYlxdub1UNPkI5AKhN0rdkGTSfnUwnsf2i/sicEYR7+j5HEXybz6739wixu9fq5beP3YoVLDvWMLV7sexvHtJu0Y/L7rgBgrybLZ0Ejox74w6yP4XjfSmx71cSPSlS0jceCi/F/wRS8MwcLzc8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Wed, 23 Mar
 2022 23:09:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 23:09:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] Crossing our fingers is not a strategy
Thread-Topic: [PATCH v2 0/9] Crossing our fingers is not a strategy
Thread-Index: AQHYPYtYH+1IcMpbWkG6bXWa+kbsEKzNl5cAgAADgwA=
Date:   Wed, 23 Mar 2022 23:09:51 +0000
Message-ID: <e2bb280b0a2e609a3063731cbebcd99d3715ad65.camel@hammerspace.com>
References: <20220322011618.1052288-1-trondmy@kernel.org>
         <164807623644.6096.16226567748741917177@noble.neil.brown.name>
In-Reply-To: <164807623644.6096.16226567748741917177@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d09a598-4636-4960-a2a2-08da0d223c75
x-ms-traffictypediagnostic: SJ0PR13MB5545:EE_
x-microsoft-antispam-prvs: <SJ0PR13MB554539CB2817A4F40230BCD4B8189@SJ0PR13MB5545.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9hLAF3vgMK6gj01Sk8zfM22WhyWUbzCbZwHPeM956Y/eqsKSWwLBr/Aah5/9J1xdhSa+bfSc1rDXKgWbQrRkyr8x38vmTHmL7+ncIYl2EZBRHgkX5rv3j40TQFcobqolYVb5yALuljKwqEOf0qpocdcBB47H6u3yVwIx9yuWzX5zq+ZoAmTEwfY7vI6aOFnoJf72m6RNDF8DNlsGPwIS5WVzaOcrxd/5KDZFPSJYaX5DwEpsJyjyDBZ0hIgoGbRXcw/FVu7/L3GTZ+V0VlNhYFxl+l6IoaiMA7JLp+TbP3pXg6U2SKQQBsYO+j9PqzBKViJX0JnKoMUsfqGjbHVsr0DPe9pbCuEO/OWV9nBHiOWzOIMYvIOErVAmExTaETaKVx/2XZ0ujj4Tw74TwQi7Jp4wLGu4wiCe9FzHkUmTCnSgFWEFzybIzD5hIWX3C51pRRcTvmYa5kUa+Adi5kjyjyyjJd3XvTxwBfROKu2Quq2my+7lfdjgn0swD72++JmOBE6mJr1UCiWrE2p3nwETcCTLXHNGeJZ1UA9VH6wLGPub8hM3V/RAt/xbH2nzpYGhuC5NRvThAtoS+JLsUpL1PzXEOWo43wIN3AumZj0GatKcD20ZdihZjSfj4K1t2IKTLr2IS+AMhsju5AJPGsaL9huz1XoU5grahSrhdiNxe6JqJdK0qHZmqySPRIiCsZkiuqCXZEWQQXicjeh0UVyNSmSHh1ofXFKzJB1tiJRl2XXojyfCRXf0km9k8wAWwwJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66446008)(71200400001)(6512007)(66476007)(8676002)(6916009)(66556008)(4326008)(83380400001)(76116006)(122000001)(316002)(6506007)(508600001)(66946007)(2906002)(38100700002)(6486002)(8936002)(5660300002)(38070700005)(4744005)(36756003)(86362001)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3I1dXYxVFh1aDY3czVPTmtVZ2hlTWN2K1l3RE82c1k2c0M4WlZYOTU1bVNX?=
 =?utf-8?B?RjFIVlVIRDVOVE1Kc1VzbVNENDFFZXZnTzVjM2tsb2xzMHdjdXkxNCtROUZp?=
 =?utf-8?B?N0dELzJqc20xQkUzTVFITjM2dGJUQnovaEVQeXBwODNBVi9ubnU0ZzhTaytC?=
 =?utf-8?B?eHcrUTZHQ3hZS1ZXTk00UDJJYkF5WXVFeTBVVlRhSFJlcVovZURIT2FFM2gr?=
 =?utf-8?B?YU9lK0UrRjd1OHJyclp3T0VpOEFXanlvMnUzR212RVg1dFVVUGVQV3BleW1r?=
 =?utf-8?B?NzdQOTB3dzJIVVY2RTIrT3Fha1d1bjYyU25VU3NFb1hoWG40K0ZzcVprS0tx?=
 =?utf-8?B?SmdacVdwa3BocXpaYm1XOVRaTFhndG1ZNmNTclVvRElPQzZtbEpBSUxLNEZR?=
 =?utf-8?B?YldiUlpTTURMSS92eDJUVmR5M2s4WjhLaDc5M3N0YmRYVnU3ckhZelhCMXhq?=
 =?utf-8?B?ZlJqbTFEYS9oaUJPQkFENW5ZZUt4REpMbmIrWXplcU9UWTU2SUJEVEVodXdu?=
 =?utf-8?B?VDM5WVZaVXVaZnBqMk9XUFZ3cEpDMndhaktlQlhvVDJnWHF6QWZHWWh6SnlW?=
 =?utf-8?B?RS9ESjd4c2RVTkFyeTIzNTA5UlZXZCt4Q2VjeWQzaWlJUFViOGFNNkVqS3Aw?=
 =?utf-8?B?b0dFMGg1R0ZGL25sbGVIY0xpMkVGQUtFQTFyNDhVNFNHWEkxWEJ1VTNtalp6?=
 =?utf-8?B?aHFaNzJRRHROMEpwUHFTVFF2a1pNY0NVUnZXbmhQYXpmb3ZuUUlSNndBQ3dt?=
 =?utf-8?B?RHBGTzREdFZkRk5ZRXVnWGxtM2xYMmh4S3ZIS0VvSXlXTU0xVzJzU2VkMVVU?=
 =?utf-8?B?Y1JiU294WDl4K2pFSldIenRBNlZnVGcveFdWNjZKRzVHR0tVRk9MUGpBZUds?=
 =?utf-8?B?TFZKYkNZdGMzWjhwS2kyakVoN3AxTXlJTDQvUVNQM1dHQ2lYQ1pJU0hDYXRU?=
 =?utf-8?B?MHBQSFBJWmFlUW10VHZlVUIxMlJIQmNyT1c1WTBDZ2hBUEp5WFlkV3U5WEU5?=
 =?utf-8?B?MmJ1QXdRVWdnSWlPUGhDeHdjdHcwOTU3b1RJdGtRYk4ra2NtcTgwck9qd3ZJ?=
 =?utf-8?B?S1loaDJRRFZHdmZOMnluV1h2c3lUQis5ZnVrdkJxUWNiV21ydVdUbmxZdTR6?=
 =?utf-8?B?NTdIRGsrQVVoYlhnVjJaUWN1YW9YdjRSV3JtdTlzeW1LVElQZTNrcUszY0VW?=
 =?utf-8?B?QVNBRlpxL1J5NmZMYk1SeE0vMXZ4SUxWT2VPRDlqU1dxcUdhVlNXMkV0YVQx?=
 =?utf-8?B?S2Rma1g3Uy9kZDl6VTRYRmRMa2lxRFJzbW56d1A0YlpCeWtNVmRkNHlucjNh?=
 =?utf-8?B?Zkc1Mk1uU0VuZ2Y4emNvSFd3V1I0a1hTcnRiVUIzVnJhNGsrQ1JnWGt4cUZ4?=
 =?utf-8?B?QjFWUmE1S0FaSjhlZFk0ZlhuWXN1Z1l5bHpvcWlMaFk2bzd0ZjBzUE4zUUJi?=
 =?utf-8?B?V2JnSjlSalZpMC9iWnJYQ1ZvUFRZd3o4VUo2RjdvMDVFQVg2WUNpT3B5c2lL?=
 =?utf-8?B?VWN1Ykl4UUNvcjZUMHV6TmQvTVUwdGlMUnRSa3poMC83ZkRHT3hlb2hoNU11?=
 =?utf-8?B?Z1dzbzlLMTk1WmVKNFNmTi92U1padU9lcGlmMGdLWTdkQndmMkxGUm1BZUxQ?=
 =?utf-8?B?UW8rSXdlS2FIK3V5emhmeHJldXViQlZyR3hmRjcwV1lKNzBNSDNyM2hNd285?=
 =?utf-8?B?ODhUTWF4ZXhUY2gxcmhad2JnRnV4YWNqbFFHNnZscWpyVDB3cEl6UXRkVXRD?=
 =?utf-8?B?NFBjaG9rUlZNaU80ZmVOc212bmFkWktoRmU2UGtYcUg4cGM3VGFxVEc2ZTgr?=
 =?utf-8?B?cng3enhUdWlseWJJcHRwSXFEeU9zZ0NCS1NtUTlwTDNsckFrWkJIbng3Ry81?=
 =?utf-8?B?TjNlQXA3ZmQvSGZFSVpYUkF4QW5JMkVSajRwZGY4eG53R1N2dmV6U3V0VFFw?=
 =?utf-8?B?cmFKQTVNL1h0L203OS9FWDJwVTVGbTlTZ1ltOEN2eVZLZC90VlV0QXlDRW04?=
 =?utf-8?B?Sm85bzVweUl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03A5274676A6234FB19E63AE937B29E5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d09a598-4636-4960-a2a2-08da0d223c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 23:09:52.0112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0WAHzHglBRv5GCDY/l4Zifrh5SsWEE06rPfZTa5dgTte62uNIRL+MJrB9x01rBYdwTmV3QAVc8y+fsiHSMgQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5545
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTI0IGF0IDA5OjU3ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMjIgTWFyIDIwMjIsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTog
VHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0K
PiA+IFdlJ2QgbGlrZSB0byBhdm9pZCBHRlBfTk9XQUlUIHdoZW5ldmVyIHBvc3NpYmxlLCBiZWNh
dXNlIGl0IGhhcyBubw0KPiA+IGZhbGwtDQo+ID4gYmFjayByZWNsYWltIHN0cmF0ZWd5IGZvciBk
ZWFsaW5nIHdpdGggYSBmYWlsdXJlIG9mIHRoZSBpbml0aWFsDQo+ID4gYWxsb2NhdGlvbi4NCj4g
DQo+IEknbSBub3Qgc3VyZSBJIGVudGlyZWx5IGFncmVlIHdpdGggdGhhdC7CoCBHRlBfTk9XQUlU
IHdpbGwgZW5zdXJlDQo+IGtzd2FwZA0KPiBydW5zIG9uIGZhaWx1cmUsIHNvIHdhaXRpbmcgYnJp
ZWZseSBhbmQgcmV0cnlpbmcgKHdoaWNoIHN1bnJwYyBkb2VzDQo+IG9uDQo+IC1FTk9NRU0gKGF0
IGxlYXN0IG5pIGNhbGxfcmVmcmVzaHJlc3VsdCkgaXMgYSB2YWxpZCBmYWxsYmFjay4NCj4gDQo+
IEhvd2V2ZXIsIEkgZG8gbGlrZSB0aGUgbmV3IHJwY190YXNrX2dmcF9tYXNrKCkgYW5kIHRoYXQg
ZmFjdCB0aGF0IHlvdQ0KPiBoYXZlIHVzZWQgaXQgcXVpdGUgd2lkZWx5Lg0KPiANCj4gU286IGxv
b2tzIGdvb2QgdG8gbWUuwqAgSSBoYXZlbid0IGNhcmVmdWxseSByZXZpZXdlZCBlYWNoIHBhdGNo
IGVub3VnaA0KPiB0bw0KPiBzYXkgUmV2aWV3ZWQtYnksIGJ1dCBJIGRpZCBzZWUgYW4gZWFzeSBw
cm9ibGVtcy4NCg0KVGhhbmtzIE5laWwhDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
