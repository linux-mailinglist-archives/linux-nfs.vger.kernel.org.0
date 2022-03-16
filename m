Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4304DB1D3
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 14:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbiCPNtW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiCPNtU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 09:49:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FB1AD9E
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 06:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEIFS3Es/G1nR5sc4oOkWTcPcIQ6/3031VnNoSDr/4G/JS98Sp2T9lvvblQx5/0ml6wUFz2HBf8O/atOTkbtNLZWS0Spc8K3/pfyHWYENQoaCIbXFtAio8lsai7qCCsgRT6JXm8PcHa3wZdfsXTpfw5R3UHZtsPH6IriUZ0BV0rrMwv6zikdV8vf90+Yg/Eiv+wsqlG1S7DKB4SeiWIUHykQU3ipsRuhfQwWJoIqSJYEaNkLIsNrvv4D9K2UkBlztDuFxeI2bHb2UCEiDCzab3crjGdy/5+ZuI2geAdGvKGx3KrQpd7CqFJE/BNOyeMnY8JFBj4xNJ893ba6LcMBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SWqx/QC0H0iNffnOhMB5cclTBwTcVfMWCPZ1b0eA8o=;
 b=SEDvtuTdNET5RbKDRq251H3GJVjRlUS3L8taH8F6sH9iXP+vnP0Buqx2K7KOqS41oGGJLY3V+NBv6tm66f+E7iNGWsEZhRtFVQXS26UOVU0xmvA/tcFgE03CDF8ebsFvjYxV85N2IAS1Ti6+547qECHWVCAJhxxPN1B3yK+xpvmfVkEyu3ufPkff2FFjlfLtfSBhK7qgyhnNW4NwKad4PO94ej9mWgf6Yu+GBsJhHS6TUn+Z23UW5u3TFi0wOjMAxcfgrRqLkiBHKX5w8CGRjhr/MEE72LcsFJc8qsq66j80ahK7IkvR4yEBFPDAm5JMZfIQFqMRSf4w4BWbSqR5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SWqx/QC0H0iNffnOhMB5cclTBwTcVfMWCPZ1b0eA8o=;
 b=dQogykTdVFlgMrR+moSGfp69hwwm5UM1KXHI1pBx1SMYnHJwEjvmk/5HgRivelfnq9VNaAfOKKWefMMbLhlse/hnm9dGGRm8bWwJbOzeUZRQpGsZ+J2eCcGvZ+aof1v3e9k7mcayF9tSCinbuyo/k01/VRwhfyWNieHvhdlny2o=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB0868.namprd13.prod.outlook.com (2603:10b6:404:4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 13:47:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 13:47:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix memory allocation in rpc_malloc()
Thread-Topic: [PATCH] NFS: Fix memory allocation in rpc_malloc()
Thread-Index: AQHYOImPM+V+a1AQSkC9Wjhr9k+IAKzBQBMAgADHuwA=
Date:   Wed, 16 Mar 2022 13:47:58 +0000
Message-ID: <b93457f73c1e9df6c74fcb6d42374ddd3e202385.camel@hammerspace.com>
References: <20220315162052.570677-1-trondmy@kernel.org>
         <164739558440.9764.6759307849718646101@noble.neil.brown.name>
In-Reply-To: <164739558440.9764.6759307849718646101@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f6754be-4afc-4f8a-afca-08da075394bc
x-ms-traffictypediagnostic: BN6PR13MB0868:EE_
x-microsoft-antispam-prvs: <BN6PR13MB08683670D158812AF4188697B8119@BN6PR13MB0868.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHaK1NMT/jTTEyXg/2ZRj2Rw6thGakjzCd+84eZMsKPyxDV8FhuzdRwgw7DXeQD49BMFiesEEgeEwmxCKvpYEktjn1uMiJFakF/gzDrPkOvmFhq4Bo5b6AqmF1vwtX24jPvq4crvQmz8gU8rUtf+9ngJ1mIxcITEPwjORZH+BqxNjnmlhiBDVzL+6LTS9V2DnbrVtaW5XIVwSFVrutMByD1Dhd5VWrNiwrJ0WqA90UOa8d+0KeXf/NiA6w8lUm5wLbSWnp/STWVr/8hg7rcjznNQGs1NOPqTywaKFJVaQi2w0nYMUrVjSfkw80qK1t3XDM+KZ9NBD7RCAuye5a87XTwAlKUzpTRHT1c3ATlV1zPFgdowALpm1Y1rWssOTp+hzJzCUB/XvbCRooeYP56WZbKEq1C5OmOG750THQI1CTPRQC04W0yFR6KLtrC6yzWIhNQLqtz6HY6j+WXoclKAjX7yzSkYD6yh85pwNV0GlWemCZ5z5ah1x6hzJXRt9dVnoZ0WboXpzwYrO6rV4QN/gvKtnlgbttzbap008pC0fNlcQkavS03E/5YwA1eHk/hEl19f17boEtN39jBvI0NBmq4invVWVzA0Z7/nGYnQv33vsvcaFCvhb+GgNQHWBAoqrPTEbuHtVyoVIgqTIBbSxGBKysw8GduXJTtDcB4iQ8KYqSDn5kb7i40aj5ZCe5r4dOw7n+I1pjrt6DeoqlGVdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(38100700002)(8676002)(38070700005)(66556008)(66476007)(64756008)(66446008)(76116006)(186003)(6506007)(26005)(66946007)(86362001)(71200400001)(6486002)(6916009)(8936002)(2906002)(316002)(83380400001)(508600001)(4326008)(6512007)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZnUzlFY1RUOW9nQTVkR2ZtRVlyNjI3NVQzeERqTHREOWhsazE0NDhKbmRI?=
 =?utf-8?B?UVl5QzRGNWZPQThiSHY1c1g2M05EK0FleEtLd3JreWNHMWV3alN3bzdkRXlw?=
 =?utf-8?B?MXcxYVJsWkN3WXdNM3c5L0ZoT29FOGRlUkJJWHBROFR0OXl3SG1MOFNMRDYx?=
 =?utf-8?B?c25SNnY5YWhnTzB5R211Wmw2YTFLaHRUR1VySnZodWt5RzhSaXZZMENBSG9F?=
 =?utf-8?B?RGJ6M0RCWm94S1hjU2l4V09UTmdnV3lxY2NISUNwUXgyclA3UE90N0NhNzZp?=
 =?utf-8?B?Q01hTk1MdW5WZVpJTnZVcmQvODcyczZmelh4RCt4Z3p3VFFMSXBHYTBBMldw?=
 =?utf-8?B?ZEpMU2MxVEhLVi9PM01TZTI1NzFJaTU3QTVIcXBGUW1XMkFPZ0ptMzRGWUsx?=
 =?utf-8?B?djV0ZGQzYkwxajM5SEFTU3lCQUI3UVhGMG1KU0I5T0N6MmhkZlV4S2ZydXFQ?=
 =?utf-8?B?eWpibndOREFrMVphdjVLTHI1Y2lidGNzU0R5QWdjdDhuTEtpNHVrMmwxSGEy?=
 =?utf-8?B?NlRZMVc3SGtxTGwxSjFmZXhLdzJWR2tsMHl5SjVvQTg4d1VGMzdHaEtnRmlK?=
 =?utf-8?B?akFteGtROWdWRFN0SEsyNStXcGFoTlJVMGQ2bkFIbUdCRGhqVXFPeWNNTG5j?=
 =?utf-8?B?c2Mvb2RXSVVHZGU3b3BMSlJ3U1FxYWZYV09yOTFUU2M3RDlLY2ZoYTNFUFJG?=
 =?utf-8?B?NlBNckN5d1dpSmVIYzQ5U0J3dXZRUi8xMXNZRXI5SndzNHFrdm9UTzRuY3Br?=
 =?utf-8?B?bkd6ZjJ2WGRURVdYcm5zb0RNRFhWNFY2aHEyMWJ6Tm5nWTdWMUxsTVd5M2Rt?=
 =?utf-8?B?VEsySlJ1RnB6UllPMDM4YWw3c3VsejFkdzJ6UElFaW0xV2ROT3RMU2NvK2Rl?=
 =?utf-8?B?SzdmYXFBeEdlWUNCTm1xemJnT2tLUFF2QlpXZkdBazBsekpPOENhUnUzbktw?=
 =?utf-8?B?elVKamZEQ0NrL3EycDJjUExmMm13QnF1VVBkUVMxaWpqbGlHUkJXMzVNcUFM?=
 =?utf-8?B?WmljS2VQcGVhaWVqTVpUWXVpQ1dWakErM0pRc2xrYzAyV09lZmc4UVh6cFlO?=
 =?utf-8?B?TDcwTTBCTGkxZGVEbFZ1OWNmaXViU3BZcnc5WnlpNFB6dUZwQUEzS2wrblBE?=
 =?utf-8?B?bHlJc1haYTMzSll1akdNUEJKYVdmcjFhcjV6dVZkcTYrcFZaNXdDWmFxdnhB?=
 =?utf-8?B?T3AwbG41Ym0zU3lQZDgzL3JqdEdjelVrcFBtZXZKNVdDUldzaURVZEVVOGhp?=
 =?utf-8?B?cVBjZU0rbHFjTkFYWHluOGZSZ0lWcDdPd0NBamtRVE01SFZScDJDbTlRSGdo?=
 =?utf-8?B?cm1KSFNmTHZLYS9uNHp5UjFPbnExRnNva2dMQUdCVE5GdU9PM0pkVmYzK0tG?=
 =?utf-8?B?OE1YaGlzZHp1OEU2VG5YWHluU0MwaG9zQllVQlhIc3lkZER1Vmh3c2xtUTFU?=
 =?utf-8?B?Q09BMWwwdW5GY3RKMVBPY3JnOFJnTWZ4RThHN25pUG5aSWxkOVFyUGZzWFZO?=
 =?utf-8?B?bEF0eE8zQWNqNFBDRXRLdm5HTlNtTGwrQTdhWHR4THZ0M2l5OXVEQjRkbDVP?=
 =?utf-8?B?VXF0ZVJhTFBJMkZ3VVJWT0dRa01LejV5V1NBVERKa1VEZmdORWFzaDB0VzEx?=
 =?utf-8?B?V1BjSVVDT1FXRjJhMHAzK0UwTzhIMHJWZ2pvV3UvNTl6QjQrWXprT0RuZzBt?=
 =?utf-8?B?OFBld21HdXlHTXdCd0x1LzB4SkNkaXdpSThhZ2dCL1dBYkZLbnBTZkFjMjdP?=
 =?utf-8?B?NzVzOWViRFZtRmREL2RRQ2hiZFlSbDAwRXRCeHBkTzRRMUd0MWNZMUY3YVZY?=
 =?utf-8?B?bmVwRjV0dWIxZVowbUhoZVVjUGdEYmh1QjRoUlh5RFlKYmUybjQ4cytYcjFD?=
 =?utf-8?B?WmhQd3J5cUFwY3JnM205cnllb2NtRXhDUlBsTHdYd0hGK1pJYzNjck04VmN2?=
 =?utf-8?B?a2IwM1pBSHd3RW14anA0K3V0SE45aVl6VmU4VHdXOU0wa0RGWkVKck5kZEJW?=
 =?utf-8?B?TnJnQzFyWjVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31509376009952429B7559E8F31B9A72@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6754be-4afc-4f8a-afca-08da075394bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:47:58.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97l8CNvP3mDvGxMb2rwnVDaMFACtWsJ8BjLlCdjnbGj/m54/xMFGArENhVnnoXp6tDXKArTaUtO48lgPCzLPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB0868
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTE2IGF0IDEyOjUzICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMTYgTWFyIDIwMjIsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTog
VHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0K
PiA+IFdoZW4gYWxsb2NhdGluZyBtZW1vcnksIGl0IHNob3VsZCBiZSBzYWZlIHRvIGFsd2F5cyB1
c2UgR0ZQX0tFUk5FTCwNCj4gPiBzaW5jZSBib3RoIHN3YXAgdGFza3MgYW5kIGFzeW5jaHJvbm91
cyB0YXNrcyB3aWxsIHJlZ3VsYXRlIHRoZQ0KPiA+IGFsbG9jYXRpb24gbW9kZSB0aHJvdWdoIHRo
ZSBzdHJ1Y3QgdGFzayBmbGFncy4NCj4gDQo+ICdzdHJ1Y3QgdGFza19zdHJ1Y3QnIGZsYWdzIGNh
biBvbmx5IGVuZm9yY2UgTk9GUywgTk9JTywgb3IgTUVNQUxMT0MuDQo+IFRoZXkgY2Fubm90IHBy
ZXZlbnQgd2FpdGluZyBhbHRvZ2V0aGVyLg0KPiBXZSBuZWVkIHJwY2lvZCB0YXNrIHRvIG5vdCBi
bG9jayB3YWl0aW5nIGZvciBtZW1vcnkuwqAgSWYgdGhleSBhbGwgZG8sDQo+IHRoZW4gdGhlcmUg
d2lsbCBiZSBubyB0aHJlYWQgZnJlZSB0byBoYW5kbGUgdGhlIHJlcGxpZXMgdG8gV1JJVEUNCj4g
d2hpY2gNCj4gd291bGQgYWxsb3cgc3dhcHBlZC1vdXQgbWVtb3J5IHRvIGJlIGZyZWVkLg0KPiAN
Cj4gQXMgdGhlIHZlcnkgbGVhc3QgdGhlIHJlc2N1ZXIgdGhyZWFkIG11c3RuJ3QgYmxvY2ssIHNv
IHRoZSB1c2Ugb2YNCj4gR0ZQX05PV0FJVCBjb3VsZCBkZXBlbmQgb24gY3VycmVudF9pc193b3Jr
cXVldWVfcmVzY3VlcigpLg0KPiANCj4gV2FzIHRoZXJlIHNvbWUgcHJvYmxlbSB5b3Ugc2F3IGNh
dXNlZCBieSB0aGUgdXNlIG9mIEdGUF9OT1dBSVQgPz8NCj4gDQoNClRoZXJlIGlzIG5vIHBvaW50
IGluIHRyeWluZyB0byBnaXZlIHJwY2lvZCBzdHJvbmdlciBwcm90ZWN0aW9uIHRoYW4NCndoYXQg
aXMgZ2l2ZW4gdG8gdGhlIHN0YW5kYXJkIG1lbW9yeSByZWNsYWltIHByb2Nlc3Nlcy4gVGhlIFZN
IGRvZXMgbm90DQpoYXZlIGEgcmVxdWlyZW1lbnQgdGhhdCB3cml0ZXBhZ2VzKCkgYW5kIGl0cyBp
bGsgdG8gYmUgbm9uLXdhaXRpbmcgYW5kDQpub24tYmxvY2tpbmcsIG5vciBkb2VzIGl0IHJlcXVp
cmUgdGhhdCB0aGUgdGhyZWFkcyB0aGF0IGhlbHAgc2VydmljZQ0KdGhvc2Ugd3JpdGViYWNrcyBi
ZSBub24tYmxvY2tpbmcuDQoNCldlIHdvdWxkbid0IGJlIGFibGUgdG8gZG8gdGhpbmdzIGxpa2Ug
Y3JlYXRlIGEgbmV3IHNvY2tldCB0byByZWNvbm5lY3QNCnRvIHRoZSBzZXJ2ZXIgaWYgd2UgY291
bGRuJ3QgcGVyZm9ybSBibG9ja2luZyBhbGxvY2F0aW9ucyBmcm9tIHJwY2lvZC4NCk5vbmUgb2Yg
dGhlIHNvY2tldCBjcmVhdGlvbiBBUElzIGFsbG93IHlvdSB0byBwYXNzIGluIGEgZ2ZwIGZsYWcg
bWFzay4NCg0KV2hhdCB3ZSBkbyByZXF1aXJlIGluIHRoaXMgc2l0dWF0aW9uLCBpcyB0aGF0IHdl
IG11c3Qgbm90IHJlY3Vyc2UgYmFjaw0KaW50byBORlMuIFRoaXMgaXMgd2h5IHdlIGhhdmUgdGhl
IG1lbWFsbG9jX25vZnNfc2F2ZSgpIC8NCm1lbWFsbG9jX25vZnNfcmVzdG9yZSgpIHByb3RlY3Rp
b24gaW4gdmFyaW91cyBwbGFjZXMsIGluY2x1ZGluZw0KcnBjX2FzeW5jX3NjaGVkdWxlKCkgYW5k
IHJwY19leGVjdXRlKCkuIFRoYXQgc3RpbGwgYWxsb3dzIHRoZSBWTSB0bw0KYWN0aXZlbHkgcGVy
Zm9ybSBkaXJlY3QgcmVjbGFpbSwgYW5kIHRvIHN0YXJ0IEkvTyBhZ2FpbnN0IGJsb2NrIGRldmlj
ZXMNCndoZW4gaW4gYSBsb3cgbWVtb3J5IHNpdHVhdGlvbi4gV2h5IHdvdWxkIHdlIG5vdCB3YW50
IGl0IHRvIGRvIHRoYXQ/wqANCg0KVGhlIGFsdGVybmF0aXZlIHdpdGggR0ZQX05PV0FJVCBpcyB0
byBzdGFsbCB0aGUgUlBDIEkvTyBhbHRvZ2V0aGVyIHdoZW4NCmluIGEgbG93IG1lbW9yeSBzaXR1
YXRpb24sIGFuZCB0byBjcm9zcyBvdXIgZmluZ2VycyB0aGF0IHNvbWV0aGluZyBlbHNlDQpjYXVz
ZXMgbWVtb3J5IHRvIGJlIGZyZWVkIHVwLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
