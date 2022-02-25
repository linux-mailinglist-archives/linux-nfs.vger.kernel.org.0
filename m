Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1874C458B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiBYNMV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 08:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbiBYNMU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 08:12:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF57A574B7
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 05:11:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFl5LfDECb6NfUfG5aJ8MSaUS8QbEM6Okt2VCiSlL0Zs2Q6qDSP6RU/MU1BI/TjbDvfMnjmdug+zvKpMeecKmmhLA1FrlIzlsvpDsOouIyH4nDiWC66SGH/CIsgaP9KvRBylY1XhrxwteVCDVKvyvmwvnnsKddX5A0TP98WoypAdZOnDL2t6ep1RwJSuJInWA3n4heFVPCfXgGB/6uiKWxGQer1/Sc3RaaOy3gOiVXqKIAIzUupNnzdfosNe73OgFwUU2o1oHJYd1UkZpdCy5OYH61sm7sYmtCsmxiUb3s00kW5PwR3vgdvj6wuIIJPhpsn1TEpRUlS/fCHEcsY7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A5xfTde90QW6zZ8xGKMkxZ2HIgwv1S2aGANaPujESY=;
 b=dO+/9KjZoFhX19CyU0glJfe/VIQ6LnT+o9hPG3ug2S4n/7TDbiCdVcGAuslMauxtBv/XshxXf8hL+P2ekf3a2JQWbnEU0g2gICA1MSwqN1BEsS5G65o605WZCBR3OVJyNBa9SYyBkYy8b6LUg+HBCacW8mDXxZ6Mji48qswO6KL2AK3PT91+zus0ZJGJloYK/ikau4jooHKR6SmDm338oPa/HFrlTOoBeU6jXEaZ5mxyf352Dv2Cpjm7jlG2J3hdoFP1uShVmRF+cUnkyXNf2oCGwDpz3bXTFWgjsb3kE53mx5TbUbDo3RUoO4MQgoN5l2cOztt47nwgJ1hDJMN8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A5xfTde90QW6zZ8xGKMkxZ2HIgwv1S2aGANaPujESY=;
 b=cLJTJgWFUNwpz4dL8y3mcO74zSmTlzxIRkkv7bkU+FX/1cgCAJq8BYfZDGyPYHtt5iio+tpl+W6OehcUz17N0emP/jdyLWt+CS6GB/L9vZ1bCvAk7uBxC4mYoijGZGIeiHfwWkBOX8QaCAXlDxsyj/NDgSeTtqhWYrmdJIdL+WY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4728.namprd13.prod.outlook.com (2603:10b6:408:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 13:11:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.010; Fri, 25 Feb 2022
 13:11:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Topic: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Index: AQHYKPtgN77REpvsVUWcQtB9d3Bbtayi9t8AgACXPoCAAAx0gIAAEsgAgACIY4CAAArBAA==
Date:   Fri, 25 Feb 2022 13:11:41 +0000
Message-ID: <7252c8e5c9e2a2729758ad64e0e6e75cd5e0d730.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <20220223211305.296816-6-trondmy@kernel.org>
         <20220223211305.296816-7-trondmy@kernel.org>
         <20220223211305.296816-8-trondmy@kernel.org>
         <20220223211305.296816-9-trondmy@kernel.org>
         <20220223211305.296816-10-trondmy@kernel.org>
         <20220223211305.296816-11-trondmy@kernel.org>
         <20220223211305.296816-12-trondmy@kernel.org>
         <20220223211305.296816-13-trondmy@kernel.org>
         <20220223211305.296816-14-trondmy@kernel.org>
         <20220223211305.296816-15-trondmy@kernel.org>
         <20220223211305.296816-16-trondmy@kernel.org>
         <20220223211305.296816-17-trondmy@kernel.org>
         <20220223211305.296816-18-trondmy@kernel.org>
         <20220223211305.296816-19-trondmy@kernel.org>
         <20220223211305.296816-20-trondmy@kernel.org>
         <EF67F180-F1D8-4291-92C8-86E5D10D1F25@redhat.com>
         <73e0a536c0467693db87c3966cf02e20ff3d889b.camel@hammerspace.com>
         <164575906990.4638.4113048743095971193@noble.neil.brown.name>
         <4f1a9a7b5e3ac59e365c5e40ee146ceb0f4e1429.camel@hammerspace.com>
         <AA3FF18A-38CE-4F5A-87FE-6C235C6CD9BD@redhat.com>
In-Reply-To: <AA3FF18A-38CE-4F5A-87FE-6C235C6CD9BD@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98eb851b-281b-4c44-428e-08d9f8605d7d
x-ms-traffictypediagnostic: BN0PR13MB4728:EE_
x-microsoft-antispam-prvs: <BN0PR13MB47280816369ABAAE12E3A995B83E9@BN0PR13MB4728.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xq7wRePvkWWRZ+L0ayY2lRM028LCSQzoNULOKlGchZTiAwDl5RZCRbjMmF+FlJNIUpDcjcEgz6PdcGSLc15xuQgnTNspeLepBH8BcYFEWn9GdsSEgvVwttKXUNR5J6a3Ui0nWMDdGAz/sD0d67DmmjuQZJr6+ZGgRnUADV8Gketlgdedf0vxpTSq4RMASWZA0HbpEI1s+63GK/3CHXbvgvS2J1gWzefGxR9YGk/U0e5xh26Tr55knPgTWgdS2V1mOHojuGuFATGy+TL95i2DztcWi792xun35GVVOih10JWj7UtH9Ia8Hf+FBhaTaQhP8SuhfbciHIk+mv42EMVh7VvNeZxl0MM/gu/KrWA52gKRlMfcX+UwLpoBbGeAe01zhYHt6C6a88se9aytq2FvCjSyv5q2WmsuaeERW+4J3zg06/UGDsAz23pAVwSNF1vClCMN0yZzhWnu1g98rx2lr4j7IE9h6/FMaMZc1s4pC1dnKzL4pq7Ewj5SWuZrMzWs07ixYnFUpEwta+zJskb0BA4aK5WZNmbuntNtuNu8xLOHdO9+6EsFUzmlYf3bXBfB9uarwTXHLBGYhRZOROK/ZHfLvWUrBftmjg3aeGXhJnLDq3a/Hpe8yqAq62nlcwdyAKxKDTBPUXw49JVj02NVhpJmAqrd1TegH/IY4nghBphGsXCTodKTtQ2zKXm514VQkuWO/EKIoeRd5Zu3JULEqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(39840400004)(396003)(346002)(136003)(376002)(71200400001)(4326008)(2616005)(38070700005)(8676002)(83380400001)(6486002)(6506007)(86362001)(53546011)(508600001)(76116006)(66946007)(66476007)(64756008)(66556008)(186003)(66446008)(6916009)(316002)(54906003)(6512007)(122000001)(26005)(2906002)(38100700002)(36756003)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEIya3hxT1R1TVd0UHJWSDlMQzJxUVlYQnBLTExId0ltU2Jhay92L1R0STJs?=
 =?utf-8?B?bmN4ekFaU3F6SVRXLzc3VVl0SkJoY1JPRHFSckRQRndqK0NzbWJ5Sk1PcjdT?=
 =?utf-8?B?TEZFdmNBTWNZZUZmb3RYS2k0enBrYUlmSExqMlZZZnlTZ1ltVzZPZEl6OXVu?=
 =?utf-8?B?TnpSRDliTnVEcmdGdjFkSlNSZGtIUGR3SURWR2RCU0VYVWpOMGRXZTAzOHdo?=
 =?utf-8?B?S29VRkwyOHRnZ2tEY0JVVFJrSXlwc3orMDgzMldZTGZvelB5UkRXNnByUmpC?=
 =?utf-8?B?ekxFSnRDNUpNOEg2KzNxWmgrNk1qRXg3UHV3aW9mWjhUaXkxMmcxc0k3amto?=
 =?utf-8?B?QnlncTU4V05kQjBPQU1oNktaeWJOZ20rL2VNRFZoTE94NUZRVTdSS055c1Nt?=
 =?utf-8?B?QnJ4S1NlVlJ3RnUrVU9sZjNzZXhLOENZc0U4aUM0SEk4TWlmclJTOUk4amJJ?=
 =?utf-8?B?eDBpZVExcWk3NTJkWmZHQVhna2Z2dm9SMGllYXJKNnlYNVRrTUFlYllEaDZT?=
 =?utf-8?B?R1BMZ0dmVW94RXdSRlBaWGhTcjJHMWxGRUI0M3dkR1dmeUlXUGFTVmVqNllC?=
 =?utf-8?B?dnAvaHhpdDhsVGFPckVudWREdEZvWEdSVytrY1BPNG5lRXZaVW1HelUvR2ls?=
 =?utf-8?B?VWt4dTk4T0pwNERjN3hodUNaSGlSRHp4L3k4OExIQVg4WTFYUVh0b2syTytu?=
 =?utf-8?B?R3JuTjhOKzI0c1d6TnJRUTR0TzBtdjZPTldFaVlPR2NDQWpsUGo1a2pNMlFr?=
 =?utf-8?B?T2VxdTBVMTJ0ajBTOTFiSmp4YU0wLzZzQVorbnhET0dJeEpFamkzTXZuaGhC?=
 =?utf-8?B?U0dsZ1dJVjkwNDRjaVhDQ1ZPOEVEL3VqeGxuR1BINUFnaXRCdGQ4Mkh5d3ND?=
 =?utf-8?B?SldMV3NNcVBDMGg0cStJTEJ4ZGFtU2JSL0lkdm1JbFRPVmxuQ1Y1K2lrM200?=
 =?utf-8?B?MmY4bUxpeGxpM3lnckNiSFVkeTNiMlJSQ3NxdlNiSWJuWXIveEZ5WWFLT2tZ?=
 =?utf-8?B?Z0dpa1YxSHZjRVg1TW9mdDhMUXd0SlpjdWZJZ1o5Y09PazVVaUlpNXdzSjda?=
 =?utf-8?B?c042cWsvWlZUcmJoZmFGUHJyZUR5SHRsSktDd1BSaTRvN3JjaGEzQ0JzSlE5?=
 =?utf-8?B?SUFvbnhFQzZsZjJwTHRsOFNYQ3FHalZGcDllVTV5RTl1QUI1eVlyUXp0Tk14?=
 =?utf-8?B?clhlR09HeHE5Q3k4dHhUMzV2emFCM1VQbUpzTHRUSlZ4SkZ2NTNJVHZualZ4?=
 =?utf-8?B?aHlQYVVpRHRhQUtHK21oK1JMZ011bi9DYi94ejJ5WFJxaGtLTTd2N1VjMFRY?=
 =?utf-8?B?U0Y4cjJmYUl2ZXFuTE0yeWEvdHBqaFRYY3RVYm4vc3JvMUF0akJMZnpmYVNh?=
 =?utf-8?B?V1NMbUk0UWg0QmZuT2VXVitkczUzRncvQ3BCaVR4RjlIbnpnRnZtM2pEOFl4?=
 =?utf-8?B?STV0bzc4VTVvZlJPRjVlMjc5ZUl4YVAvQWErV2MvNzRESGNySW5IQVc0OW0x?=
 =?utf-8?B?enpWdXpzTlZrNVA0cERMSStwak1TZlB5SFNpY0NYOVlJak8ya1ZheE5ReUJI?=
 =?utf-8?B?K05ERGN5UVFoQm1TdVkwWGhSQkdyclRvblJYSGd6THBadzJwNXN1cTB4ejlu?=
 =?utf-8?B?YWJrdHdaL29DeW0rNjlXZ21qM001cm9UT3RQQlEzOUFVWVhnRDdZOGZuOEZn?=
 =?utf-8?B?c2w3WDY3VEJIK1EyY0c0L3QwK09iRWVWUkVIMWFoQ1d2Z1N0S0xLWktmcmth?=
 =?utf-8?B?cHpNQnA4czh5VGdBeExVQ1RJMytubi9OVjdJU0g2VU1oK1IybVFtRHJBNVJ0?=
 =?utf-8?B?Q3YzMnZNOW1yOWZValQvd3Q4Z1BmWW8rYjVKZXRCVVh0eXNWcTltcTRkUkho?=
 =?utf-8?B?T2ZsMnp3eGxpZUZRVkRVd2RtU3pJZ0ZodTJCcE1GWnEva3ZmZXpVbHpoZkdQ?=
 =?utf-8?B?YVI3Q1hIcU15UjByRkcwUUg4S29TdzNPaEtTSmk3K2ozemE3cnlMRll2b1lv?=
 =?utf-8?B?UGhwQURWMnN6eVNRV2toTzAzQTlMK2g4ZzY5S3RjMmdTbk54WGlkNm1Sb3Ix?=
 =?utf-8?B?bTQwVXJsd0c3engzU0RuOHFPa3NKaG5JNHpuZGZEYmYyY2p5R21NMEZUWCtv?=
 =?utf-8?B?Q3FUdzVGcFdKemlHYkZJZlNoYVp5Q29Yb1ZnT3kxTkQzREtEdThWZkx3QnlL?=
 =?utf-8?Q?0UIh3WJJQ3+ebSytzn7UGU0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C6808B965669A478347D04B4A83CBF2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eb851b-281b-4c44-428e-08d9f8605d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 13:11:41.7425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDuEGB3t9MdYvGKR63hRoK/KrRHiw4j/UYDYAEIpBLFCZyzbE/UXtDUvshT6vtbvuqHNipYN/Xkkpw998EGhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTI1IGF0IDA3OjMzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNCBGZWIgMjAyMiwgYXQgMjM6MjUsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gRnJpLCAyMDIyLTAyLTI1IGF0IDE0OjE3ICsxMTAwLCBOZWlsQnJvd24gd3Jv
dGU6DQo+IA0KPiA+ID4gSSBoYXZlbid0IGxvb2tlZCBhdCB0aGUgY29kZSByZWNlbnRseSBzbyB0
aGlzIG1pZ2h0IG5vdCBiZSAxMDAlDQo+ID4gPiBhY2N1cmF0ZSwNCj4gPiA+IGJ1dCBYQXJyYXkg
Z2VuZXJhbGx5IGFzc3VtZXMgdGhhdCBwYWdlcyBhcmUgb2Z0ZW4gYWRqYWNlbnQuwqAgVGhleQ0K
PiA+ID4gZG9uJ3QNCj4gPiA+IGhhdmUgdG8gYmUsIGJ1dCB0aGVyZSBpcyBhIGNvc3QuwqAgSXQg
dXNlcyBhIG11bHRpLWxldmVsIGFycmF5DQo+ID4gPiB3aXRoIDkgYml0cw0KPiA+ID4gcGVyIGxl
dmVsLsKgIEF0IGVhY2ggbGV2ZWwgdGhlcmUgYXJlIGEgd2hvbGUgbnVtYmVyIG9mIHBhZ2VzIGZv
cg0KPiA+ID4gaW5kZXhlcw0KPiA+ID4gdG8gdGhlIG5leHQgbGV2ZWwuDQo+ID4gPiANCj4gPiA+
IElmIHRoZXJlIGFyZSB0d28gZW50cmllcywgdGhhdCBhcmUgMl40NSBzZXBhcmF0ZSwgdGhhdCBp
cyA1DQo+ID4gPiBsZXZlbHMgb2YNCj4gPiA+IGluZGV4aW5nIHRoYXQgY2Fubm90IGJlIHNoYXJl
ZC7CoCBTbyB0aGUgcGF0aCB0byBvbmUgZW50cnkgaXMgNQ0KPiA+ID4gcGFnZXMsDQo+ID4gPiBl
YWNoIG9mIHdoaWNoIGNvbnRhaW5zIGEgc2luZ2xlIHBvaW50ZXIuwqAgVGhlIHBhdGggdG8gdGhl
IG90aGVyDQo+ID4gPiBlbnRyeSBpcw0KPiA+ID4gYSBzZXBhcmF0ZSBzZXQgb2YgNSBwYWdlcy4N
Cj4gPiA+IA0KPiA+ID4gU28gd29yc3QgY2FzZSwgdGhlIGluZGV4IHdvdWxkIGJlIGFib3V0IDY0
Lzkgb3IgNyB0aW1lcyB0aGUgc2l6ZQ0KPiA+ID4gb2YgdGhlDQo+ID4gPiBkYXRhLsKgIEFzIHRo
ZSBudW1iZXIgb2YgZGF0YSBwYWdlcyBpbmNyZWFzZXMsIHRoaXMgd291bGQgc2hyaW5rDQo+ID4g
PiBzbGlnaHRseSwNCj4gPiA+IGJ1dCBJIHN1c3BlY3QgeW91IHdvdWxkbid0IGdldCBiZWxvdyBh
IGZhY3RvciBvZiAzIGJlZm9yZSB5b3UNCj4gPiA+IGZpbGwgdXAgYWxsDQo+ID4gPiBvZiB5b3Vy
IG1lbW9yeS4NCj4gDQo+IFlpa2VzIQ0KPiANCj4gPiBJZiB0aGUgcHJvYmxlbSBpcyBqdXN0IHRo
ZSByYW5nZSwgdGhlbiB0aGF0IGlzIHRyaXZpYWwgdG8gZml4OiB3ZQ0KPiA+IGNhbg0KPiA+IGp1
c3QgdXNlIHh4aGFzaDMyKCksIGFuZCB0YWtlIHRoZSBoaXQgb2YgbW9yZSBjb2xsaXNpb25zLiBI
b3dldmVyDQo+ID4gaWYNCj4gPiB0aGUgcHJvYmxlbSBpcyB0aGUgYWNjZXNzIHBhdHRlcm4sIHRo
ZW4gSSBoYXZlIHNlcmlvdXMgcXVlc3Rpb25zDQo+ID4gYWJvdXQNCj4gPiB0aGUgY2hvaWNlIG9m
IGltcGxlbWVudGF0aW9uIGZvciB0aGUgcGFnZSBjYWNoZS4gSWYgdGhlIGNhY2hlIGNhbid0DQo+
ID4gc3VwcG9ydCBmaWxlIHJhbmRvbSBhY2Nlc3MsIHRoZW4gd2UncmUgYmFya2luZyB1cCB0aGUg
d3JvbmcgdHJlZSBvbg0KPiA+IHRoZQ0KPiA+IHdyb25nIGNvbnRpbmVudC4NCj4gDQo+IEknbSBn
dWVzc2luZyB0aGUgaXNzdWUgbWlnaHQgYmUgImdldCBuZXh0Iiwgd2hpY2ggZm9yIGFuICJhcnJh
eSIgaXMNCj4gcHJvYmFibHkNCj4gdGhlIG9wZXJhdGlvbiB0ZXN0ZWQgZm9yICJwZXJmb3JtIHdl
bGwiLsKgIFdlJ3JlIG5vdCBkb2luZyBhbnkgb2YNCj4gdGhhdCwgd2UncmUNCj4gZGlyZWN0bHkg
YWRkcmVzc2luZyBwYWdlcyB3aXRoIG91ciBoYXNoZWQgaW5kZXguDQo+IA0KPiA+IEVpdGhlciB3
YXksIEkgc2VlIGF2b2lkaW5nIGxpbmVhciBzZWFyY2hlcyBmb3IgY29va2llcyBhcyBhIGJlbmVm
aXQNCj4gPiB0aGF0IGlzIHdvcnRoIHB1cnN1aW5nLg0KPiANCj4gTWUgdG9vLsKgIFdoYXQgYWJv
dXQganVzdCBraWNraW5nIHRoZSBzZWVrZGlyIHVzZXJzIHVwIGludG8gdGhlIHNlY29uZA0KPiBo
YWxmDQo+IG9mIHRoZSBpbmRleCwgdG8gdXNlIHh4aGFzaDMyKCkgdXAgdGhlcmUuwqAgRXZlcnlv
bmUgZWxzZSBjYW4gaGFuZyBvdXQNCj4gaW4gdGhlDQo+IGJvdHRvbSBoYWxmIHdpdGggZGVuc2Ug
aW5kZXhlcyBhbmQgaGVscCBlYWNoIG90aGVyIG91dC4NCj4gDQo+IFRoZSB2YXN0wqAgbWFqb3Jp
dHkgb2YgcmVhZGRpcigpIHVzZSBpcyBnb2luZyB0byBiZSBzaG9ydCBsaXN0aW5ncw0KPiB0cmF2
ZXJzZWQNCj4gaW4gb3JkZXIuwqAgVGhlIG1lbW9yeSBpbmZsYXRpb24gY3JlYXRlZCBieSBhIHBy
b2Nlc3MgdGhhdCBuZWVkcyB0bw0KPiB3YWxrIGENCj4gdHJlZSBhbmQgZm9yIGV2ZXJ5IHR3byBw
YWdlcyBvZiByZWFkZGlyIGRhdGEgcmVxdWlyZSAxMCBwYWdlcyBvZg0KPiBpbmRleGVzDQo+IHNl
ZW1zIHByZXR0eSBleHRyZW1lLg0KPiANCj4gQmVuDQo+IA0KDQojZGVmaW5lIE5GU19SRUFERElS
X0NPT0tJRV9NQVNLIChVMzJfTUFYID4+IDE0KQ0KLyoNCiAqIEhhc2ggYWxnb3JpdGhtIGFsbG93
aW5nIGNvbnRlbnQgYWRkcmVzc2libGUgYWNjZXNzIHRvIHNlcXVlbmNlcw0KICogb2YgZGlyZWN0
b3J5IGNvb2tpZXMuIENvbnRlbnQgaXMgYWRkcmVzc2VkIGJ5IHRoZSB2YWx1ZSBvZiB0aGUNCiAq
IGNvb2tpZSBpbmRleCBvZiB0aGUgZmlyc3QgcmVhZGRpciBlbnRyeSBpbiBhIHBhZ2UuDQogKg0K
ICogVGhlIHh4aGFzaCBhbGdvcml0aG0gaXMgY2hvc2VuIGJlY2F1c2UgaXQgaXMgZmFzdCwgYW5k
IGlzIHN1cHBvc2VkDQogKiB0byByZXN1bHQgaW4gYSBkZWNlbnQgZmxhdCBkaXN0cmlidXRpb24g
b2YgaGFzaGVzLg0KICoNCiAqIFdlIHRoZW4gc2VsZWN0IG9ubHkgdGhlIGZpcnN0IDE4IGJpdHMg
dG8gYXZvaWQgaXNzdWVzIHdpdGggZXhjZXNzaXZlDQogKiBtZW1vcnkgdXNlIGZvciB0aGUgcGFn
ZSBjYWNoZSBYQXJyYXkuIDE4IGJpdHMgc2hvdWxkIGFsbG93IHRoZSBjYWNoaW5nDQogKiBvZiAy
NjIxNDQgcGFnZXMgb2Ygc2VxdWVuY2VzIG9mIHJlYWRkaXIgZW50cmllcy4gU2luY2UgZWFjaCBw
YWdlIGhvbGRzDQogKiAxMjcgcmVhZGRpciBlbnRyaWVzIGZvciBhIHR5cGljYWwgNjQtYml0IHN5
c3RlbSwgdGhhdCB3b3JrcyBvdXQgdG8gYQ0KICogY2FjaGUgb2YgfiAzMyBtaWxsaW9uIGVudHJp
ZXMgcGVyIGRpcmVjdG9yeS4NCiAqLw0Kc3RhdGljIHBnb2ZmX3QgbmZzX3JlYWRkaXJfcGFnZV9j
b29raWVfaGFzaCh1NjQgY29va2llKQ0Kew0KICAgICAgIGlmIChjb29raWUgPT0gMCkNCiAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KICAgICAgIHJldHVybiB4eGhhc2goJmNvb2tpZSwgc2l6ZW9m
KGNvb2tpZSksIDApICYgTkZTX1JFQURESVJfQ09PS0lFX01BU0s7DQp9DQoNClNvIG5vLCB0aGlz
IGlzIG5vdCBhIHNob3ctc3RvcHBlci4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
