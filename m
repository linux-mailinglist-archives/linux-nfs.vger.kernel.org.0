Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D4052963B
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 02:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiEQAzj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 20:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiEQAzd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 20:55:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7247344C8
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 17:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T428djlL86ZZU8G4qmBJvmfk3bHbJJWDddLckexX6LIliyItfz9+4OaiRAkciDK9GoY5QmBA0yOfQheGHdEc+Y71nC9UfoIoHesnSRrIhOeP73dcO2lrKyODdm/cgD6c2agFMuRVFaqNlj+FKvtao1zBfuBc6xlC+xAkrM8aZfWNNiTGB7eDgs8VCiodL41YsXg66L4Nx1UpIFiCJRp6wOFdAybc1edH9BQHfOhYOEKh+4D5rd15D0+JOGepZJw+sIfJ0nPiT/yyKS3c2nHwaVr6FwrDKVt4eLYEtR2nXmhS/C9VFyJwGZ3s8vblKl0lUMN0dewxgBvlVSzuLl6hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxXQjmiHcq4t1d5aqLYx6DOFPn/rR4rR0zOqG8/gVyo=;
 b=BipmixEwUz2xktjtBF1QQ0hzH407VkhnQwg10tIwzmaDRAYWfadlTAKm9GvltJnOCfHm7hsxMetVZ8d4MKfFi2ckl5YEhTMbk7kj9nj50hLYiY+Rb9XJyhvj+dhpufiKRNUQRizdjJ63xJK8mYgAUWIEtEg7HHkSQgCTtzFDWL4ELj9/I5Z5ylbxIjXzUDTprzeYorlqXW6+nHn+6ftmxJt0/DgXfVb4yLMEte10EJmd8O8Au/9v07oJISwBRaXBKGhrqka5PihByziFEElD7vS09rSu0eDMSSqKRRT5CGAZw1dvqjB+RVTIZD4ZQLdRZ8gkWaD6h5DoHBluzEzlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxXQjmiHcq4t1d5aqLYx6DOFPn/rR4rR0zOqG8/gVyo=;
 b=NZ2vJbQj2kOX995yG8TLNd29ewbJrpP2XtWIcuiOnd7TpeEVLyXv7CAcLDDlHOE/xuesPKk/Qm3AyVo/F3SvLzazvWIZeTSz0IH+z+nd/NwgMDLTqaM0dmIW7DVR61mon/LQVi10m2jWWPlhvHwLV4Cnhvs5gkyjXWoNamOVWq4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB2930.namprd13.prod.outlook.com (2603:10b6:405:80::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Tue, 17 May
 2022 00:55:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 00:55:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEA
Date:   Tue, 17 May 2022 00:55:29 +0000
Message-ID: <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>   ,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>        ,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
         <165274805538.17247.18045261877097040122@noble.neil.brown.name>
In-Reply-To: <165274805538.17247.18045261877097040122@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9827c42f-d3b2-4c5d-c3f7-08da379ff026
x-ms-traffictypediagnostic: BN6PR13MB2930:EE_
x-microsoft-antispam-prvs: <BN6PR13MB29303B212FC586E086F7C8BEB8CE9@BN6PR13MB2930.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tkjv46b8mAPQHrKjcMfc0eBXOhzj+5soIbChpVh68bfEKq3MsICViijM/bq7SXtsBpIagL7BkWY+lxYSSvfa8grX/x/8x2Zf5Q27sDn8KvtbL6PrVjGo8dD+rlbYHoZFhw2Kvh0143echrpme+mB+aQm0Nr8hiqNqY8H0jXoJTJyijJlO6KIZbS+Kzfe8tezlzkpDuoq2K60HQQ6760g8GFd8DoSuDd9pEXI3k7xxLTtLXXnHJKDbBb7ZHjgKA9nuE3Nu9S6LGD9EHKGa+WDuLT2BjJrStSX6k73ASjBxi11AkO4afYiCtM687YDyFvi3SobdfQjijr/+iGFDd1L2FsLcjtB96atsgF94BKTYAy+aoM0OhuWqeLClbi/PLVPTbIs5a4iFc1iy3fViuW+9/U7jQNznDr6uWqzxW1jVL/t3Y8SpH3JZyht8SMlHFzz5+jfzAuFkzfYP1WGoWb8mnXBjYNlCWAoQGqb5EuhgSWL4veBYKQGnSyCIXzjAkd8W2mwRqYZb0Z1G2MLaWh7vcp1DLuA2wVdRQlKHXyRXIbVcMDkndVfdgb2AXEsq7Z5fXDOF5Xhuuz1tCCRvpV6jncjkC4ffPZDoemkkg2jORpZ9IV4c4YtaVS/WmlhbGJqgKvYOWneRRDEBnaqCx5II32xd08GcfzdRLW5+U0Q1h+6FrfXc3xiJZSt/EOn1d5SYajgyYxKzAh4zrfv/yAKO6AP31xNSxVgOWRvlqwdxeHDvsMMbP7RRV8ZXfsFnv8E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(8936002)(38100700002)(38070700005)(71200400001)(5660300002)(122000001)(86362001)(6512007)(26005)(2616005)(83380400001)(186003)(6916009)(54906003)(2906002)(6506007)(4326008)(76116006)(66946007)(8676002)(66446008)(36756003)(66556008)(66476007)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmgvZHFnakdteEp0QkJrRjZHL04yd01TeXF6U0x1cFBBNkltZ1o2R2Vlb0h5?=
 =?utf-8?B?RXRxdFR2UTdKZ1BYNmZsKzZKVXpDRkZpQ2MrYzZZMjJ6YWJUWEd5dEZPN1BX?=
 =?utf-8?B?WFhLelgvSVFuYWdveHRGMENVRGh0MWtlZGw1N0J1dlJPdklrcmovSklHa2dB?=
 =?utf-8?B?Ulk5T0lyTUo1YkhvL1RKWkd6Nm9JS3IxdXRPSzZCVHVseVVobUdaSWkrSlhQ?=
 =?utf-8?B?TXdPQmErNXNpV3BPMGIva2dMUEVyVzJ4b0N5amdwOUpuMEIya1BZV1RJMFB3?=
 =?utf-8?B?cndVNm9jWmpGTUsrUlNMWC9pdjhySk41SWlwc2N3TEdJdEFDZTBLTjJsbHZ6?=
 =?utf-8?B?a0xIS1JLRHhFOEhvaE51cXhsSUR2VExobWZRb0owUlVENGFpK0c4SjdDK3gr?=
 =?utf-8?B?TTk0cmt1RndMTUVzYWd3SlVoTzhXcnZwWVdIaHlnVkU5V3laNTBaOXZTR2R1?=
 =?utf-8?B?UkFiZER5WGh3VHpqdXBnU2hmOEpwTnZjSFNrNDcxamp1YjJiaHVJVlFRVWND?=
 =?utf-8?B?QUtoRk9uRE1HWDJ3RXAvOUNBSlc0eU1RQlJNOFl6UWsvRVVZWHc2c1ZDM1Jp?=
 =?utf-8?B?RTdyTWRRbWJob1ROSnJ4MzhrZEhyeUdoVWg1ZE56UVp0dFFHVXp1bXRGalR0?=
 =?utf-8?B?clpLOWo0VGdyeSswa3NoK3k0Ymw4bkNxZ1hlK21PTEZvV0lsQWs3THF5YllR?=
 =?utf-8?B?bnpySnhHUWUySlA1ekRpeTFxTEVOcDhSUk5FbzlLMmlmZnNmeGhJZDRPQi9G?=
 =?utf-8?B?eUpNTjhtSkFMYU5hK3lVYzV1cTBoMlR1L3VnSkU2SWlyVFQzSTJWODl2dVla?=
 =?utf-8?B?VHQvYnhOYUNybmgxbVRxTGQzUTBYS0xrY3NWbXo2dlJrZnQvQ0RwdDJxTFJL?=
 =?utf-8?B?UnZiN2ZJTTh5MDRvcEsxOWhIZFo5d1RyU2RnTGVERndPVHJpdkhXc1RuVG9H?=
 =?utf-8?B?QVFHNjQ3L2I1OXk2ZGxMTnh6ZDBINnZFQm1BNjRuajhkZzhWcXJHbWkyK2ti?=
 =?utf-8?B?c2ZnVkdIWlF2dW5Sa0tBL1ZOSnJUbUlzZ2sreHAyVDVmYVl6eW9SSWdrcnFG?=
 =?utf-8?B?bXJRSkQvN2pCMXZ0N3Q2U3BnanZGMlpDTUpUSFo0b3NGVSttVHpPNVpJbEhJ?=
 =?utf-8?B?cFFzcFN2N2JFVXp4NnMyOFFvSGxjdW5KODlqMkc0d1NEOG01cWtuNzRrdm1m?=
 =?utf-8?B?aUhOV2xXRGs2OFJ0WTNVZ0NRZVFIN3pPUzRDT2czbk9qZFJ2RFBVQVdzdjdy?=
 =?utf-8?B?bEJwY2xPajVDWSs0dTM3WUM5NTR2U3dRaWtuaElqaTlyWE1pb0F1Ry9OUG1a?=
 =?utf-8?B?c1ZScHd2STNvdDVmdEpPcGYzbyt4T0srMTZ2NlhvYy9jWjJCR2d0SFhuMzhr?=
 =?utf-8?B?eXFMTzk2V0YwUDFSeTVST1BGK3MxdldYcXkxTGkySUNqWDVzRDg1MlEvVlhC?=
 =?utf-8?B?dUlnY2kzU3B5eTN2VlFOSXZCc3ZoQkkzSUVUd2NvR3UyaytldCt5dXRrcUtO?=
 =?utf-8?B?Mlh0RmpxVldETXMzaHhMaGFVUzdneUE3S2lZYzIrbUo4cEkyZjZ1dzBmcHRO?=
 =?utf-8?B?RFZNZ3hjazJxUjZmU1hkellhdlpXc3FIT0t0aS9MbGdaNkZUb0FCTHpXaGsv?=
 =?utf-8?B?RWF0UXd5c2V5bEtDRG9wcjJ2TE1kUElmSElFL2FEVWliN080aTd4clQvYnNR?=
 =?utf-8?B?eTdVYjEvZHdQS2F5TGt4Uk1SWmgzcFFINVJiQS8vNXpNbkdtWDJIMnpHRzJ6?=
 =?utf-8?B?WVl3cEpSZVhjM2Q2b21aSmM4ZmZBcEVla3RBdnNqZlFpQ21wOVc5SjF1a1pp?=
 =?utf-8?B?OHg0QnlBZGh1QWpDUjUrK2xSbjVVek0yL0pKZ0FrckxJMDk4aDI2U2UydEh4?=
 =?utf-8?B?OXBYNDVXWmxGUVRHT3BrZkFQeHJiNnZDaWpLU0NNS25UR0ZOdXlvb1Nld2E4?=
 =?utf-8?B?LzZqbSt6Rlczem0wOGpMb3QvMmFMRm5NUkYvMlQ2VG91TVZycWJVcFRNUng2?=
 =?utf-8?B?Uy9ZWXpYa1R1ZUJVR09kbVExUi9vOXF5SFdjVVQrMkZlT3QreGRuUk9qQmZx?=
 =?utf-8?B?ZnVxdmlXUHVNRkJlcElhSy9KN2p5OVI1NzdkcnRUS1N4OWp6LzVUQ1ZrVDlh?=
 =?utf-8?B?WGRoNGQrb3l0WmJpV3cvSnh4WlVWOEZyeE1PZ1dxMStBTUpnMWpsbStiRVJu?=
 =?utf-8?B?dWVEMGJVcnlRWkh3SXBVUjZLMHVLZVJ3SmxuTTYxQ2gycGkzVzFjcEpKMDNR?=
 =?utf-8?B?RXBtS001R3A4UDg5S2lRQWlwNSt1MzBXaDBpNFQxTmZjdnpSdU5yUWlNLzZ6?=
 =?utf-8?B?V3p1QnVaWW5LU0RzKzlIUWRJQlFrdDVYMkF4ZGxFWVB2WTBQWEpFRnc2QTU4?=
 =?utf-8?Q?adlDK6WeREExMFJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77DD001EFB3CD049979B16812ADB2136@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9827c42f-d3b2-4c5d-c3f7-08da379ff026
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 00:55:29.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mG6I+LB0lxBpPKLNyFl5Giu4wlmFjHDA+t/DSvY22m0EZWhQGPkTm2XhyBHqhTuwcYDWdj+xtCnVhqu08MNbzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB2930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDEwOjQwICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMTcgTWF5IDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjItMDUtMTcgYXQgMTA6MDUgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
SGksDQo+ID4gPiDCoGFueSB0aG91Z2h0cyBvbiB0aGVzZSBwYXRjaGVzPw0KPiA+IA0KPiA+IA0K
PiA+IFRvIG1lLCB0aGlzIHByb2JsZW0gaXMgc2ltcGx5IG5vdCB3b3J0aCBicmVha2luZyBob3Qg
cGF0aA0KPiA+IGZ1bmN0aW9uYWxpdHkNCj4gPiBmb3IuIElmIHRoZSBjcmVkZW50aWFsIGNoYW5n
ZXMgb24gdGhlIHNlcnZlciwgYnV0IG5vdCBvbiB0aGUgY2xpZW50DQo+ID4gKHNvDQo+ID4gdGhh
dCB0aGUgY3JlZCBjYWNoZSBjb21wYXJpc29uIHN0aWxsIG1hdGNoZXMpLCB0aGVuIHdoeSBkbyB3
ZSBjYXJlPw0KPiA+IA0KPiA+IElPVzogSSdtIGEgTkFDSyB1bnRpbCBjb252aW5jZWQgb3RoZXJ3
aXNlLg0KPiANCj4gSW4gd2hhdCB3YXkgaXMgdGhlIGhvdCBwYXRoIGJyb2tlbj/CoCBJdCBvbmx5
IGFmZmVjdCBhIHBlcm1pc3Npb24gdGVzdA0KPiBmYWlsdXJlLsKgIFdoeSBpcyB0aGF0IGNvbnNp
ZGVyZWQgImhvdCBwYXRoIj8/DQoNCkl0IGlzIGEgcGVybWlzc2lvbiB0ZXN0IHRoYXQgaXMgY3Jp
dGljYWwgZm9yIGNhY2hpbmcgcGF0aCByZXNvbHV0aW9uIG9uDQphIHBlci11c2VyIGJhc2lzLg0K
DQo+IA0KPiBSRkMgMTgxMyBzYXlzIC0gZm9yIE5GU3YzIGF0IGxlYXN0IC0gDQo+IA0KPiDCoMKg
wqDCoMKgIFRoZSBpbmZvcm1hdGlvbiByZXR1cm5lZCBieSB0aGUgc2VydmVyIGluIHJlc3BvbnNl
IHRvIGFuDQo+IMKgwqDCoMKgwqAgQUNDRVNTIGNhbGwgaXMgbm90IHBlcm1hbmVudC4gSXQgd2Fz
IGNvcnJlY3QgYXQgdGhlIGV4YWN0DQo+IMKgwqDCoMKgwqAgdGltZSB0aGF0IHRoZSBzZXJ2ZXIg
cGVyZm9ybWVkIHRoZSBjaGVja3MsIGJ1dCBub3QNCj4gwqDCoMKgwqDCoCBuZWNlc3NhcmlseSBh
ZnRlcndhcmRzLiBUaGUgc2VydmVyIGNhbiByZXZva2UgYWNjZXNzDQo+IMKgwqDCoMKgwqAgcGVy
bWlzc2lvbiBhdCBhbnkgdGltZS4NCj4gDQo+IENsZWFybHkgdGhlIHNlcnZlciBjYW4gYWxsb3cg
YWxsb3cgYWNjZXNzIGF0IGFueSB0aW1lLg0KPiBUaGlzIHNlZW1zIHRvIGFyZ3VlIGFnYWluc3Qg
Y2FjaGluZyAtIG9yIGF0IGxlYXN0IGFnYWluc3QgcmVseWluZyB0b28NCj4gaGVhdmlseSBvbiB0
aGUgY2FjaGUuDQo+IA0KPiBSRkMgODg4MSBoYXMgdGhlIHNhbWUgdGV4dCBmb3IgTkZTdjQuMSAt
IHNlY3Rpb24gMTguMS40DQo+IA0KPiAid2h5IGRvIHdlIGNhcmU/IiBCZWNhdXNlIHRoZSBzZXJ2
ZXIgaGFzIGNoYW5nZWQgdG8gZ3JhbnQgYWNjZXNzLCBidXQNCj4gdGhlIGNsaWVudCBpcyBpZ25v
cmluZyB0aGUgcG9zc2liaWxpdHkgb2YgdGhhdCBjaGFuZ2UgLSBzbyB0aGUgdXNlcg0KPiBpcw0K
PiBwcmV2ZW50ZWQgZnJvbSBkb2luZyB3b3JrLg0KDQpUaGUgc2VydmVyIGVuZm9yY2VzIHBlcm1p
c3Npb25zIGluIE5GUy4gVGhlIGNsaWVudCBwZXJtaXNzaW9ucyBjaGVja3MNCmFyZSBwZXJmb3Jt
ZWQgaW4gb3JkZXIgdG8gZ2F0ZSBhY2Nlc3MgdG8gZGF0YSB0aGF0IGlzIGFscmVhZHkgaW4gY2Fj
aGUuDQpOQUNLDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
