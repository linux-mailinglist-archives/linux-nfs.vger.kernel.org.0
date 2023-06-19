Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21D735DD7
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jun 2023 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFSTUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jun 2023 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSTUB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jun 2023 15:20:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2102.outbound.protection.outlook.com [40.107.244.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2347E53
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jun 2023 12:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mgt0qKUQF5AKNa8b/wLsqmWBN0+4mnWUi75NSW3lsuvhnpRzekLfZZo0PsQ5vmsEJZS9Zha8r370p17u1nGWzHJ63ik/Hokgqr1ATnCi0WNi1DJ5quA4JBncyJ8MddZTS++TRZOm7uWf9zSdphBVQJJLrPcis2KP4/Ta2rnbw8Yfw4cYgjUmlo60UNZ0ayAEbwZKSy3iQHk85V979L8rt1dcqEcUdvYb1OXsC3AW422msR4KvdIiW8Aoj+pamat3+gAhX6DO1MaK5JPr5nK0KyDons1G5ubEAFOUXzp7theiBRaGnhqjbWerxWO2/cIy7vdpb+2c6OPNd0M69+WCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/GT9xuUOpuNW74xJjY+FcDb3udw3Gm0yFDpnTvj2uE=;
 b=BqIToTmJna7n2h3LgYOfatAYdAAql1RBEEgaoa5FHUXMkE74xZKaL87R/Gezj64MLDXzZmVOOuOJ706or7NiS42kBnRsYVsWcvr0UYks/5hp4Tsg0xTXpH9nsBiYRvnv6uUX7mUNRWtD1PF0OiKuwZ7O941FCavnV62nm+3QWA1UUUBcgVDwnf74CkXRpPsKY6oKZTpXRO0s2C6wpGH8ORmudJWQ+olFV5ntPeumXfoHDc44XhY1H10Qb/66IfxiXCLsAfILnTgmllOJfBc3UdNPctMTA+H/4NwqCy9OErj+RX9z2NpL8CEOYF1188hm1jg/CLy45jYCBDkMoqoo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/GT9xuUOpuNW74xJjY+FcDb3udw3Gm0yFDpnTvj2uE=;
 b=SnIqHwoeTaJCDcCzLDJnvWhOWY5PfmeQhji3pJOExDoohG4mdzjsMHTN5FoCmkZZ0MsUr0QA8FCcg0Rxe1sizuSc8+c3Fo38DeOjBhq8baqI2+5Q8kbZ9MMXfQtPKC3WbyUI0t64wbCi3ctsBpYNO9yREgXW4YNbWCs0Mc/HwHU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN7PR13MB6278.namprd13.prod.outlook.com (2603:10b6:806:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 19:19:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 19:19:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.0 Linux client fails to return delegation
Thread-Topic: NFSv4.0 Linux client fails to return delegation
Thread-Index: AQHZos/Q4xRI4OBFakm+oIbfuQpI0q+SgG4A
Date:   Mon, 19 Jun 2023 19:19:56 +0000
Message-ID: <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
In-Reply-To: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN7PR13MB6278:EE_
x-ms-office365-filtering-correlation-id: 033f9b6c-b945-4671-d95b-08db70fa2a94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wp0gpasBWGC9Tcp35HmMCFdChcTeWM+0uJcqqSmgQzf3+Odt8Sf1lFWvz+5nJnf61hq24FjeJMrx52jwJzn05aUazHtylbR4n4D5+1kIj8faP2aSMX4ne++jD7H/T3xgOHSWBXg2hoZ4z3KXH4az/OMkpM4WRH1mhBDrwqOLpWUtRmDUZx9x4KibpoaYvUNc/BsYfme7O45wE9yf1Y/3SgGHSmzCpFamcrpZg3yVIx084gWbTR+DlNyfp0Ukyg0TYZdXaDnXDm9b9ENIrQW4vHSpi/f2WDtuMAtxQC0d1XazrshFMREvKOYxQfay+OHfszNR5cNiviV/qCkOpoHK+tsJduv4QnChhTVwk6jE8yCelgE9IbqMApIaS5DWWwjMqzDS8qpjRAk5FVSSLnEOnlynrovkJjAs9WTWj/2azG7HccxUrogtGmiWFpAI2PkEUWZO5TcAvups75LosMtcBs4tE0x4F19FaFlt+Lw0GD5QmcVfCJwMQZIRAp77hvg2My8GqJDiajbl64Efpj3AEpHhD0rDsEuDq6NOtgkwM+jTMSvIwcoPYwXX4ZuztAZLVLEhcNnxh2CGsuE19CoP/j15WVXvOAPa8rLHM7JkNjqPLM+4vDeSRB/3RTKux/DDdXlTs+dQXCOA49lcU0/UGnS+3tuVra3vWynw55vgM2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39840400004)(366004)(396003)(451199021)(186003)(478600001)(71200400001)(6486002)(86362001)(6506007)(6512007)(2616005)(316002)(38100700002)(83380400001)(76116006)(66946007)(66556008)(66446008)(64756008)(122000001)(66476007)(6916009)(4326008)(8676002)(8936002)(5660300002)(2906002)(41300700001)(36756003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0t4Z1hHWWIwMHlEVC9ZOElzNTZFVEZUN2FFSnJDR1BIKzdncGRDQmt2ZjhX?=
 =?utf-8?B?TTViQXlIZ2JXMUxpOGNXWFplZDBsd01JYkFVdURJcHRDdCtwUTdpbTNGNWs5?=
 =?utf-8?B?bDN4RmlwUExLVXlTRy9qaU5yQlNqRmt6dHNtOFhRdmhxaUxxQURLeEVrUFpE?=
 =?utf-8?B?eHNyb0psdDFoTjJ2NnZDVkpkMHVuZkdtdEo3N3JxaGJkNHBsb0xqMllqMkE1?=
 =?utf-8?B?eC9kUldkckEyTFVWbnlJMEZ1bUVCaGV4cEJoWVZWajl1Vml5Q2VVQ0Q0ZzRD?=
 =?utf-8?B?WkJBK2I5Qzc5UlJ6bnJoRmNxd1o4SlM1dnkwSWZPYTFUZlJoTUQrV1VGUXF1?=
 =?utf-8?B?dFFHazlMK2lVcGVTa09ia3RHZXlmbVJUTklueHMzSEdMRitRN2t2amZrWWk5?=
 =?utf-8?B?bHJBRytNVDVadUxMQ05mbVp1VTVJVExmaTFiTVIxT3ltUVlyUDc1OE1Cdkd2?=
 =?utf-8?B?TjNSRjZ5alcrWDk1SlhzeTJQT0c3dWxKekE4akxjYXh5Y0VJNUdsa0NhWFFn?=
 =?utf-8?B?N2U4OFdrUFVWVnhUNFlnTS9RMEJVaXJGZGJDamV5WExFd0FQN1ZlbTNIYXZx?=
 =?utf-8?B?UXVRdXVFYUU1WjJjc2tjZEZ6TDFOdFJyVWRVZ0VlTmNyNmRqQmgwQzIrRDZS?=
 =?utf-8?B?c0lUdks0d1dlR2tEalV6cTJwbTdndGRBZ1B0Z0FSNkhvR0FPeXdTNVBiczM5?=
 =?utf-8?B?aVMxS2dBYlcvbXVRTmJDenYveGNUdGIvc3dyWUFwR0V2N0dqblQxbzZHanE4?=
 =?utf-8?B?dFlETXk2cXB5akdEOWswSDU4NVdITkdPSUJxQ1JKMFB2bFNBVkRQQXRLOG45?=
 =?utf-8?B?RFdZWXFZb2JCZFQyRnlVK2Zrb3FsREJYRVFEQmVjUUc5RkxUaW92M3VERkRy?=
 =?utf-8?B?L3lsQ0xnamg3MFdyYkkyOGwzR1lMVXZaWGdwM3B4V0h1STI2WUhDaW1KYitY?=
 =?utf-8?B?STM3bU41VktYWnJuSUcrcHFKVUpZNmJzc1NWUldHUllrZis2MFhTUHBZQ1VV?=
 =?utf-8?B?amp2V1Z4cEhJZTNvSFZ0b20xRFVYNXJmb3l2am16VDQ2NjNNNTNCVS9RUGJW?=
 =?utf-8?B?dDB4ajR5MFZIT05KWHU2NkZadHpMTGgzeFdSMmNPSEJQem1KVlNMOXNzNkNT?=
 =?utf-8?B?Vkc2aTdiYTJEVEQ4UGxnTXFuMGF3dWVmVmdtUHRQVzczYU5iNllFQUxOREQv?=
 =?utf-8?B?WHVxSFhvQ2ljNzN0RmNQeEpoU3VFdXRaaXZTSnpOK2NQMHNTZnJ2clRkajEv?=
 =?utf-8?B?eXk1cWNlNFdLWld2MVpLWG5zQnN3WHpkelp3cllhczRKdzg1alNOZnJKbG8y?=
 =?utf-8?B?OXp5ZXovUXZraHJkTW83RzZ2R3ZlaWsrcW1qZmZuSjZDR082NXhmRHgzWStt?=
 =?utf-8?B?aWxSajlqNUpEN1VPK1dISHpyR1Z0UTNBMW1DTWhBbHZpY2JtUVg2TTRiODdx?=
 =?utf-8?B?Zkl2Qk9aOVN1c0RqS0Z3SmQzTHh3cXk5WFFhQ2JFK0xjbGVmTmE4WUtZYUVS?=
 =?utf-8?B?elorODFSSUs2MmZ2dzZJYklLNEtOL2M3T0NCWStsOVFGWUE5eWllYWxqMGxD?=
 =?utf-8?B?dUFqTW0wa0huZzlFRS9GYm8yaHA5b3h1OG12UDh2TGpQSGRadG5wb05DNkxz?=
 =?utf-8?B?NDhteFVaZ1lxakphbnU4VEVyR2cxY2hTcW5sbE1CcmJvamk2K3g5M3VPU3dm?=
 =?utf-8?B?Tmdrend3N00wOFZpeE55eGVyWllKVit2MFdFY2ZFaDE2c3VpUmlaajVBMGEz?=
 =?utf-8?B?U0hXb09ZbGxkckJybkR1UXZZSGxQcEtOZ0hVWSt6dlRLUWE4Sk9kTUtuY0FT?=
 =?utf-8?B?dG16c2VhTmFHUU1oZTc3THpJeFRmOEJjcjRBbUgwSXFIRHNMUHhjb2Q4UnFh?=
 =?utf-8?B?S1FxcitzOE9jT3R3WXNLUWVIUmpmZGkrVjMxYlhEaWVFcEZINkh5RUhWQUl3?=
 =?utf-8?B?WVlpT3N3NlI2eFdCOHJkOVdVUzNYNnZhcTdKOVlvS00zeEFRUW5nd1ZzSTdy?=
 =?utf-8?B?SXlRWlY2MTVuejRtbUFGNVBPbUhzREk3MHI0YitxMkZBNmpTd2dEZStoQ1dT?=
 =?utf-8?B?dkhCejhhbXhQb2xSOHBqWlBTelFSa2EzNFlQK0M0bGhDZklaSnAxTXNaNklk?=
 =?utf-8?B?UWZZZ1I1SjN2OFVZeWx3eUZqTWI2UVN1dGU2Q1V2ODU1Z1J6SXJhMkl4V3Zi?=
 =?utf-8?B?eFNEYnRDRTFWZlprNTNPVU91TTFvUnV5TWhXOEpObVhvUG0zVnJaRms5T1ox?=
 =?utf-8?B?RklOY0pHRTAxMjAxYjJ6Z29VQ1dnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBE68D57FB195C48A81C6485609DD875@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033f9b6c-b945-4671-d95b-08db70fa2a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 19:19:56.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vD6PhX14c7h/oN+ilO7RTNdG+Ffpu8uL6uG9+6bdfLT6k6x3YWwZ+4MNQ56PoW2ol502/+EDnSoOPIyzCkmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6278
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRGFpLA0KDQpPbiBNb24sIDIwMjMtMDYtMTkgYXQgMTA6MDIgLTA3MDAsIGRhaS5uZ29Ab3Jh
Y2xlLmNvbSB3cm90ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBJJ20gdGVzdGluZyB0aGUgTkZTIHNl
cnZlciB3aXRoIHdyaXRlIGRlbGVnYXRpb24gc3VwcG9ydCBhbmQgdGhlDQo+IExpbnV4IGNsaWVu
dA0KPiB1c2luZyBORlN2NC4wIGFuZCBydW4gaW50byBhIHNpdHVhdGlvbiB0aGF0IG5lZWRzIHlv
dXIgYWR2aXNlLg0KPiANCj4gSW4gdGhpcyBzY2VuYXJpbywgdGhlIE5GUyBzZXJ2ZXIgZ3JhbnRz
IHRoZSB3cml0ZSBkZWxlZ2F0aW9uIHRvIHRoZQ0KPiBjbGllbnQuDQo+IExhdGVyIHdoZW4gdGhl
IGNsaWVudCByZXR1cm5zIGRlbGVnYXRpb24gaXQgc2VuZHMgdGhlIGNvbXBvdW5kIFBVVEZILA0K
PiBHRVRBVFRSDQo+IGFuZCBERUxFUkVUVVJOLg0KPiANCj4gV2hlbiB0aGUgTkZTIHNlcnZlciBz
ZXJ2aWNlcyB0aGUgR0VUQVRUUiwgaXQgZGV0ZWN0cyB0aGF0IHRoZXJlIGlzIGENCj4gd3JpdGUN
Cj4gZGVsZWdhdGlvbiBvbiB0aGlzIGZpbGUgYnV0IGl0IGNhbiBub3QgZGV0ZWN0IHRoYXQgdGhp
cyBHRVRBVFRSDQo+IHJlcXVlc3Qgd2FzDQo+IHNlbnQgZnJvbSB0aGUgc2FtZSBjbGllbnQgdGhh
dCBvd25zIHRoZSB3cml0ZSBkZWxlZ2F0aW9uIChkdWUgdG8gdGhlDQo+IG5hdHVyZQ0KPiBvZiBO
RlN2NC4wIGNvbXBvdW5kKS4gQXMgdGhlIHJlc3VsdCwgdGhlIHNlcnZlciBzZW5kcyBDQl9SRUNB
TEwgdG8NCj4gcmVjYWxsDQo+IHRoZSBkZWxlZ2F0aW9uIGFuZCByZXBsaWVzIE5GUzRFUlJfREVM
QVkgdG8gdGhlIEdFVEFUVFIgcmVxdWVzdC4NCj4gDQo+IFdoZW4gdGhlIGNsaWVudCByZWNlaXZl
cyB0aGUgTkZTNEVSUl9ERUxBWSBpdCByZXRyaWVzIHdpdGggdGhlIHNhbWUNCj4gY29tcG91bmQN
Cj4gUFVURkgsIEdFVEFUVFIsIERFTEVSRVRVUk4gYW5kIHNlcnZlciBhZ2FpbiByZXBsaWVzIHRo
ZQ0KPiBORlM0RVJSX0RFTEFZLiBUaGlzDQo+IHByb2Nlc3MgcmVwZWF0cyB1bnRpbCB0aGUgcmVj
YWxsIHRpbWVzIG91dCBhbmQgdGhlIGRlbGVnYXRpb24gaXMNCj4gcmV2b2tlZCBieQ0KPiB0aGUg
c2VydmVyLg0KPiANCj4gSSBub3RpY2VkIHRoYXQgdGhlIGN1cnJlbnQgb3JkZXIgb2YgR0VUQVRU
UiBhbmQgREVMRUdSRVRVUk4gd2FzIGRvbmUNCj4gYnkNCj4gY29tbWl0IGUxNDRjYmNjMjUxZi4g
VGhlbiBsYXRlciBvbiwgY29tbWl0IDhhYzJiNDIyMzhmNSB3YXMgYWRkZWQgdG8NCj4gZHJvcA0K
PiB0aGUgR0VUQVRUUiBpZiB0aGUgcmVxdWVzdCB3YXMgcmVqZWN0ZWQgd2l0aCBFQUNDRVMuDQo+
IA0KPiBEbyB5b3UgaGF2ZSBhbnkgYWR2aXNlIG9uIHdoZXJlLCBvbiBzZXJ2ZXIgb3IgY2xpZW50
LCB0aGlzIGlzc3VlDQo+IHNob3VsZA0KPiBiZSBhZGRyZXNzZWQ/DQoNClRoaXMgd2FudHMgdG8g
YmUgYWRkcmVzc2VkIGluIHRoZSBzZXJ2ZXIuIFRoZSBjbGllbnQgaGFzIGEgdmVyeSBnb29kDQpy
ZWFzb24gZm9yIHdhbnRpbmcgdG8gcmV0cmlldmUgdGhlIGF0dHJpYnV0ZXMgYmVmb3JlIHJldHVy
bmluZyB0aGUNCmRlbGVnYXRpb24gaGVyZTogaXQgbmVlZHMgdG8gdXBkYXRlIHRoZSBjaGFuZ2Ug
YXR0cmlidXRlIHdoaWxlIGl0IGlzDQpzdGlsbCBob2xkaW5nIHRoZSBkZWxlZ2F0aW9uIGluIG9y
ZGVyIHRvIGVuc3VyZSBjbG9zZS10by1vcGVuIGNhY2hlDQpjb25zaXN0ZW5jeS4NCg0KU2luY2Ug
eW91IGRvIGhhdmUgYSBzdGF0ZWlkIGluIHRoZSBERUxFR1JFVFVSTiwgaXQgc2hvdWxkIGJlIHBv
c3NpYmxlDQp0byBkZXRlcm1pbmUgdGhhdCB0aGlzIGlzIGluZGVlZCB0aGUgY2xpZW50IHRoYXQg
aG9sZHMgdGhlIGRlbGVnYXRpb24uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
