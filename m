Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4019526333
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiEMNjE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381006AbiEMNaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 09:30:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFF17E0F
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 06:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7KOOCDiBp92EozvJeBw8DBTp4mApnbqCH2Ei7I6tPw6KzXjFhLkp6DLZqCd7UaNvdq/0fAj1NNOESAdrwti7ibLl9W2v+0g1dwccwZwAeUp0YIfdCmUwuf06k2mrpNDoqLMgW/lg8vJhHkV9exy6Gdj2JhYaS79tAsx54Bddtfq0xra9G6HKDC/L18uRJu4LaYQ7qbraN2N7HWe+5c1A4m1OFg+Y/x7ywzEpiy/LRUtHof+zjhqGD7IS8yE1q9QR/jNz2ETyptpQYaoIGL2zp3mfPls8tuFZFswNr3tkjhNlu8j3bGah/XfnoGeHu6E/SpYZjWf/Is3Ic9d9Dluiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLkeGzIdMC0koHaMl6LI7lydyA2ocba2+Oj5cUwRE8c=;
 b=WR0rAKLS2KNP3MX7QknrRB/i1SGuPhU5pdyyLceQtAPAW6W1DxS8bDlQhcukIM0nxVrakz3k6bBHKk90Mbo/qb6lkBEdxmboPQygZ79EomVENHVyDKSsTRZ39Sr66Sdct8BanKMjr1PbzugELsiV+sVQ9Mvct2NSbZ45anhejBpLuSCjrw7VWmohmuDjI1JlwZFYA818cebNaARJLP/qJJeq1q47kh7+LfTCTKtNA5GdHlFLFUSytivC5PQhyEox3NowjvhLcmwdtPGdfKibSux9LpGYgaf3U+GECbnuKSGQOY0lrVKAW0eaJeQPZ2eU79NT1m3Le3uniD3ZVkq0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLkeGzIdMC0koHaMl6LI7lydyA2ocba2+Oj5cUwRE8c=;
 b=daUXRsQmmG5k1NzRf6c561XzyigfavNM1+Ntfq3r0aeGB/qwpcijpMFgyT8B1pVqvqnCV4urX97Op1xOe/BIlZ0rSXoVa5kTflNzxqyCOAMj9Thy6CD3qHIG2LVVdmWpR308dPbIgZoVrOISmctWp5lVBLKR4bPm037naFsHhcM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2855.namprd13.prod.outlook.com (2603:10b6:a03:ff::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Fri, 13 May
 2022 13:30:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.005; Fri, 13 May 2022
 13:30:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>,
        "dennis.dalessandro@cornelisnetworks.com" 
        <dennis.dalessandro@cornelisnetworks.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCs+SbXmjJVWUyBjwAfi09dZ60Faq4AgAAMfoCAAERPAIAAApAAgAEckwCAAAwFgIAK/HeAgAroagCAABmegA==
Date:   Fri, 13 May 2022 13:30:13 +0000
Message-ID: <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
         <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
         <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
         <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
         <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
         <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
         <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
         <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
         <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
In-Reply-To: <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5d0060c-b889-4563-1210-08da34e4b5d6
x-ms-traffictypediagnostic: BYAPR13MB2855:EE_
x-microsoft-antispam-prvs: <BYAPR13MB28554943E1563374658B7482B8CA9@BYAPR13MB2855.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DggpEOEFxLdoa608Bp16xcqTUpGjQ+sXtkNEhpOnoMJFuX77nPj1ok7oXWd66ukDq9K1l3KyqolZ9p+4EYZmtwJrpC68KuTnaOU/SenfLuKeF+8eHPs0wW2xeLHh+9/aZNfpKSECc4Acb60VZby5shBkyzhTymM/iTvv1sZjmdAAyWfqV3gUz09BtKGiO1G5EMiPZt9DxB0hyV7zT9zPLWg4fS5CwlZSr5uPxDqa1pa/i0hImAhexcu8YXubfuMmcA+zG+kARGZ+gEvmH+wHe9dWe9hunEutwWA8E7muE1kf54+3VFUs4UvxOQq6PaynR+7W7NIUHN08jLK9+4dlFUfB6ht3VHVBi/ReGJCaXVrKbQC8eyyY1K7LOv4W2Hn1yP+fgRJBzR1UgGSAof0bXzx7CdhtS6nrU5SqLeKOR2iypf2cZJQWxfdcus2MK5Vodut0Rn/0ABs+FI7l/O0ikS3L1swwOZoIOlEMFP+et16ZqHtV1XqoyQ4pP55HSTD1zaE1qI9mBUN1o4wixNOGca7cte7Qv94yO1YplTGV5qKTOnSVrc0ravuurCNV64qDp258gktomgy1Qa2jJduNZbpCyyIq+0F4ynPhhFvtuMrraIJX5OUNcByJ3pZrGUY93XATXyB8bh3uFYXAEu8qOMn6UQH+4efmEfHU98V4WICJNI25tDSlUrzui5JrBEQJpWhaV3LOW7GWR6mVr8AVTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(316002)(76116006)(66446008)(66476007)(66946007)(66556008)(4326008)(64756008)(83380400001)(5660300002)(8936002)(110136005)(508600001)(6486002)(36756003)(2906002)(26005)(6512007)(6506007)(122000001)(53546011)(86362001)(38100700002)(38070700005)(2616005)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm9oeFQreXdCQm56U2wxMUhha0hwbTJMV2RCMkUxa1h6NU54Rjl3WElKNG5O?=
 =?utf-8?B?bUk2cUNsa2Q1WWFGYms0akQ3SVZhV3V3ZHBzWkxGbHgxQy8zZWNUSVY5ZXZH?=
 =?utf-8?B?bzk0ajNkR3Y0c2p2K0RHZU9hRkI3VitSWUx1T0FuSFgrcGtpYW1BT3RsRmFT?=
 =?utf-8?B?MTVNYXh3MTNIVzh4ZGRyR1FCbkQ3czVKbFRwcmdydFB6eUJBRlpLOHNlNVZZ?=
 =?utf-8?B?RTdkeERoNzY1K1pDYUR3ZlY2aStFUnRhMTVCQWdKT04wQXlFZ051by9JQU9J?=
 =?utf-8?B?VTMrbTZONGhZVzBEVWVobHBtRC9IWWg1NXRvY2dLUEdyT0FHK0dmNlFnZlFH?=
 =?utf-8?B?VWVaVFUzWUY0d3hLUVRma3FxekV5TmJ6dkRRTEc3T3dtbFVTTjdYbUhEYmNk?=
 =?utf-8?B?TjgyOWhXb09VSU9XVmdNMk14OGk5ZzY1aUxJTWlpU3hQNFc2ekpKM09ZcElF?=
 =?utf-8?B?aVdvdHZyVlgxMnZlb0lKTktSQ0s4OGNYdEdjTU9pTU9tZ0N5RWV6eDdmenMz?=
 =?utf-8?B?VTVkQjN5N293bDBNYlZSOXVsbDR0MzZDeG1zODFVSUg1ejdmRjE1cFNydzRW?=
 =?utf-8?B?aUhTeTZtSnlIUjZhY1BmU2NWdno2MStVSXVQOVBVdnU5eis2Rlg4UE12WGds?=
 =?utf-8?B?d0MxWUc0eEhWWGU3b0FDU24wUkdzTVlmTlZmSkRQcktnVTE1SWFueFVkZU5F?=
 =?utf-8?B?SEJXUjZQekpKSE92ZnU2N3ZKMU5qZzQ0MGpHVldhOHdJc1cwZ0hRbjk2Q2VD?=
 =?utf-8?B?dEx1a0IyVkk0anhmaWpjc20rTEJnTi91TmRHbldmTEdiamwvbkpYTk90RkVD?=
 =?utf-8?B?VEk3aWJVaXhxeis0RVVTV0pab29ZN2lrWThVM0d5blk1QmpTYmJ6Tk9jNG1o?=
 =?utf-8?B?N3BaUGxpdGRVUytFTDRJMzg2Z1FCWlE0bnF3Y0JHaGxrSy9OTGNpMHJVWnlu?=
 =?utf-8?B?ejF6THVFK0YrcGYrYlJMeXZsM2pSbWowWmQxRkVZR0FvR0hxMjlqNW9NQ0Ez?=
 =?utf-8?B?d2VKYW5aL1IxbmkrcndIbTNxZDhtaEw0OGlCVGZJemtGT0xsOVVDa0t6NlF6?=
 =?utf-8?B?MUtPa2ZRV0xFZDRnM2V4TTV5WlhQU3Qvb2s2eC83a1dab3ltZjZYdTA0L055?=
 =?utf-8?B?QmVhYnFmRkUya0xhbit4VURUV25ncG5nSk1NOTBCNVordG9UV3B4bEhlRnBQ?=
 =?utf-8?B?cTVnekYzTm4zdDhWQk1xZzN3MTdtRG51S3cwcWxuYmcxTGo4UmlDWVBEcDdD?=
 =?utf-8?B?YlZ0UjJJb3kwdHljTUcvdWgwOGNCaXN6YURXVTNDZWpRN1dCVElSSHZYZWpY?=
 =?utf-8?B?YmoySUMrVmZnYmhXMncxYUR6OWE3ZDNmM3l1ZU5adlJTQ0RLc3BEY0xTZEFi?=
 =?utf-8?B?MmFaR0ZFdFcrQkg3L055M2xyREFZNGhlc2F2OEh5NFVzYWxmZjBXd1pwQ3RB?=
 =?utf-8?B?eVl6RHVhamtRSFpiRlNZcEtpYXFicXZnMFhxczhlVkphT1B4UEJzZStVejli?=
 =?utf-8?B?YU9YMUZXclZyajk0Mm5NdHA4UjFzMzlHQkthOE1scDhmY1FWYzI4QUI3NUhU?=
 =?utf-8?B?Qk91K3duT0Y2TW5QMlhpN2RrRmlTM1NseXM0NlRuTUY1UGdnaTQ2bDl0RHVL?=
 =?utf-8?B?SFhvZzkvQzY4NWlVTkZXSlJmdTFWa1RwTTYwYjdRVWtoVDdPS1N1bFlDMktX?=
 =?utf-8?B?OHM4SUVVaE5jcXNsUlJCM3hPNzQ0TndwQ2JwMmNUT1gzUkNOZ3J5RWdjVUl4?=
 =?utf-8?B?YnZOTENFYUFVQ1FQVU9yNjhzaThDaVRGZ1RZdnNqYWJVY0h6UFY5TWUrdnJ2?=
 =?utf-8?B?K2puRmhkOW9mTWlQQncyaUVGbW9TbUlacWVpMmMvUFNHdjVHUFdmei9NZjda?=
 =?utf-8?B?bzlvNDRaWG4yc3ZKQk85SE9kRGJ3V09yRlBDTHEyWmtaUjRQQkw0d2JDeVRQ?=
 =?utf-8?B?cGkyVmRRb2dKcDFJTDBYYldKVU10bUEwZFFVZDJFRE9uazJWWmhPaUhDUnJN?=
 =?utf-8?B?d3ZDRVpwb1VCWVJSMlZDcnl3NlVSMzNyM2NZQk5pQTlsSksrUExOZUdGdHFE?=
 =?utf-8?B?Zno1ek9CQnRhY0RXSHVNRGlMTDZaSlhPWWlIYW9IcTJmQmpFMk9UV3gxUHFQ?=
 =?utf-8?B?YWhoL3Y2NzRmZWtGV3NWdzdzUEpvZExoVTdXdWdBTElCK3NhUEhIRDhNcTBI?=
 =?utf-8?B?d1luSnJoTVZISmF0d0F3R0M2dHRSanhOekRKSXRqZUl2NmlSSVljT1lJV0lR?=
 =?utf-8?B?bFE4ZHVlUGhRN0FsQ2xzSmRrWG5mS3RrazFremEybm9UZUFnV2RDenpJV2NN?=
 =?utf-8?B?Uy9qQS9wTjBFZ3FOY09sclpWUVZaWDBPeHRqdkRRaHYxenBJS05xUjIwTTZi?=
 =?utf-8?Q?jetHig1vAORJAvcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF9D40EDA64D7A42A03438B6F10D992C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d0060c-b889-4563-1210-08da34e4b5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 13:30:13.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OywcuE6/jJB3X799XotXaazl3rKFvU1u3V3RoAGnYham/+L59SwuEzRziQL/LJEboOiwQrimMF2hE593LIs4/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTEzIGF0IDA3OjU4IC0wNDAwLCBEZW5uaXMgRGFsZXNzYW5kcm8gd3Jv
dGU6DQo+IE9uIDUvNi8yMiA5OjI0IEFNLCBEZW5uaXMgRGFsZXNzYW5kcm8gd3JvdGU6DQo+ID4g
T24gNC8yOS8yMiA5OjM3IEFNLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4gPiANCj4gPiA+
IA0KPiA+ID4gPiBPbiBBcHIgMjksIDIwMjIsIGF0IDg6NTQgQU0sIERlbm5pcyBEYWxlc3NhbmRy
bw0KPiA+ID4gPiA8ZGVubmlzLmRhbGVzc2FuZHJvQGNvcm5lbGlzbmV0d29ya3MuY29tPiB3cm90
ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDQvMjgvMjIgMzo1NiBQTSwgVHJvbmQgTXlrbGVidXN0
IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgMjAyMi0wNC0yOCBhdCAxNTo0NyAtMDQwMCwgRGVu
bmlzIERhbGVzc2FuZHJvIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gNC8yOC8yMiAxMTo0MiBBTSwg
RGVubmlzIERhbGVzc2FuZHJvIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiA0LzI4LzIyIDEwOjU3
IEFNLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBPbiBBcHIgMjgs
IDIwMjIsIGF0IDk6MDUgQU0sIERlbm5pcyBEYWxlc3NhbmRybw0KPiA+ID4gPiA+ID4gPiA+ID4g
PGRlbm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IEhpIE5GUyBmb2xrcywNCj4gPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gSSd2ZSBub3RpY2VkIGEgcHJldHR5IG5hc3R5IHJl
Z3Jlc3Npb24gaW4gb3VyIE5GUw0KPiA+ID4gPiA+ID4gPiA+ID4gY2FwYWJpbGl0eQ0KPiA+ID4g
PiA+ID4gPiA+ID4gYmV0d2VlbiA1LjE3IGFuZA0KPiA+ID4gPiA+ID4gPiA+ID4gNS4xOC1yYzEu
IEkndmUgdHJpZWQgdG8gYmlzZWN0IGJ1dCBub3QgaGF2aW5nIGFueQ0KPiA+ID4gPiA+ID4gPiA+
ID4gbHVjay4gVGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBwcm9ibGVtIEknbSBzZWVpbmcNCj4gPiA+
ID4gPiA+ID4gPiA+IGlzIGl0IHRha2VzIDMgbWludXRlcyB0byBjb3B5IGEgZmlsZSBmcm9tIE5G
UyB0byB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+IGxvY2FsDQo+ID4gPiA+ID4gPiA+ID4gPiBkaXNr
LiBXaGVuIGl0IHNob3VsZA0KPiA+ID4gPiA+ID4gPiA+ID4gdGFrZSBsZXNzIHRoYW4gaGFsZiBh
IHNlY29uZCwgd2hpY2ggaXQgZGlkIHVwIHRocm91Z2gNCj4gPiA+ID4gPiA+ID4gPiA+IDUuMTcu
DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IEl0IGRvZXNuJ3Qgc2VlbSB0
byBiZSBuZXR3b3JrIHJlbGF0ZWQsIGJ1dCBjYW4ndCBydWxlDQo+ID4gPiA+ID4gPiA+ID4gPiB0
aGF0IG91dA0KPiA+ID4gPiA+ID4gPiA+ID4gY29tcGxldGVseS4NCj4gPiA+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiA+ID4gSSB0cmllZCB0byBiaXNlY3QgYnV0IHRoZSBwcm9ibGVtIGNh
biBiZQ0KPiA+ID4gPiA+ID4gPiA+ID4gaW50ZXJtaXR0ZW50LiBTb21lDQo+ID4gPiA+ID4gPiA+
ID4gPiBydW5zIEknbGwgc2VlIGENCj4gPiA+ID4gPiA+ID4gPiA+IHByb2JsZW0gaW4gMyBvdXQg
b2YgMTAwIGN5Y2xlcywgc29tZXRpbWVzIDAgb3V0IG9mDQo+ID4gPiA+ID4gPiA+ID4gPiAxMDAu
DQo+ID4gPiA+ID4gPiA+ID4gPiBTb21ldGltZXMgSSdsbCBzZWUgaXQNCj4gPiA+ID4gPiA+ID4g
PiA+IDEwMCBvdXQgb2YgMTAwLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEl0
J3Mgbm90IGNsZWFyIGZyb20geW91ciBwcm9ibGVtIHJlcG9ydCB3aGV0aGVyIHRoZQ0KPiA+ID4g
PiA+ID4gPiA+IHByb2JsZW0NCj4gPiA+ID4gPiA+ID4gPiBhcHBlYXJzDQo+ID4gPiA+ID4gPiA+
ID4gd2hlbiBpdCdzIHRoZSBzZXJ2ZXIgcnVubmluZyB2NS4xOC1yYyBvciB0aGUgY2xpZW50Lg0K
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhhdCdzIGJlY2F1c2UgSSBkb24ndCBrbm93
IHdoaWNoIGl0IGlzLiBJJ2xsIGRvIGEgcXVpY2sNCj4gPiA+ID4gPiA+ID4gdGVzdCBhbmQNCj4g
PiA+ID4gPiA+ID4gZmluZCBvdXQuIEkNCj4gPiA+ID4gPiA+ID4gd2FzIHRlc3RpbmcgdGhlIHNh
bWUga2VybmVsIGFjcm9zcyBib3RoIG5vZGVzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBM
b29rcyBsaWtlIGl0IGlzIHRoZSBjbGllbnQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IHNl
cnZlcsKgIGNsaWVudMKgIHJlc3VsdA0KPiA+ID4gPiA+ID4gLS0tLS0twqAgLS0tLS0twqAgLS0t
LS0tDQo+ID4gPiA+ID4gPiA1LjE3wqDCoMKgIDUuMTfCoMKgwqAgUGFzcw0KPiA+ID4gPiA+ID4g
NS4xN8KgwqDCoCA1LjE4wqDCoMKgIEZhaWwNCj4gPiA+ID4gPiA+IDUuMTjCoMKgwqAgNS4xOMKg
wqDCoCBGYWlsDQo+ID4gPiA+ID4gPiA1LjE4wqDCoMKgIDUuMTfCoMKgwqAgUGFzcw0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBJcyB0aGVyZSBhIHBhdGNoIGZvciB0aGUgY2xpZW50IGlzc3Vl
IHlvdSBtZW50aW9uZWQgdGhhdCBJDQo+ID4gPiA+ID4gPiBjb3VsZCB0cnk/DQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IC1EZW5ueQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRyeSB0aGlzIG9u
ZQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guIFVuZm9ydHVuYXRlbHkg
aXQgZG9lc24ndCBzZWVtIHRvIHNvbHZlDQo+ID4gPiA+IHRoZSBpc3N1ZSwgc3RpbGwNCj4gPiA+
ID4gc2VlIGludGVybWl0dGVudCBoYW5ncy4gSSBhcHBsaWVkIGl0IG9uIHRvcCBvZiAtcmM0Og0K
PiA+ID4gPiANCj4gPiA+ID4gY29weSAvbW50L25mc190ZXN0L3J1bl9uZnNfdGVzdC5qdW5rIHRv
DQo+ID4gPiA+IC9kZXYvc2htL3J1bl9uZnNfdGVzdC50bXAuLi4NCj4gPiA+ID4gDQo+ID4gPiA+
IHJlYWzCoMKgwqAgMm02LjA3MnMNCj4gPiA+ID4gdXNlcsKgwqDCoCAwbTAuMDAycw0KPiA+ID4g
PiBzeXPCoMKgwqDCoCAwbTAuMjYzcw0KPiA+ID4gPiBEb25lDQo+ID4gPiA+IA0KPiA+ID4gPiBX
aGlsZSBpdCB3YXMgaHVuZyBJIGNoZWNrZWQgdGhlIG1lbSB1c2FnZSBvbiB0aGUgbWFjaGluZToN
Cj4gPiA+ID4gDQo+ID4gPiA+ICMgZnJlZSAtaA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdG90YWzCoMKgwqDCoMKgwqDCoCB1c2VkwqDCoMKgwqDCoMKgwqAgZnJlZcKgwqDCoMKg
wqAgc2hhcmVkwqANCj4gPiA+ID4gYnVmZi9jYWNoZcKgwqAgYXZhaWxhYmxlDQo+ID4gPiA+IE1l
bTrCoMKgwqDCoMKgwqDCoMKgwqDCoCA2MkdpwqDCoMKgwqDCoMKgIDg3MU1pwqDCoMKgwqDCoMKg
wqAgNjFHacKgwqDCoMKgwqDCoCAzNDJNacKgwqDCoMKgwqDCoA0KPiA+ID4gPiA4ODlNacKgwqDC
oMKgwqDCoMKgIDYxR2kNCj4gPiA+ID4gU3dhcDrCoMKgwqDCoMKgwqDCoMKgIDQuMEdpwqDCoMKg
wqDCoMKgwqDCoMKgIDBCwqDCoMKgwqDCoMKgIDQuMEdpDQo+ID4gPiA+IA0KPiA+ID4gPiBEb2Vz
bid0IGFwcGVhciB0byBiZSB1bmRlciBtZW1vcnkgcHJlc3N1cmUuDQo+ID4gPiANCj4gPiA+IEhp
LCBzaW5jZSB5b3Uga25vdyBub3cgdGhhdCBpdCBpcyB0aGUgY2xpZW50LCBwZXJoYXBzIGEgYmlz
ZWN0DQo+ID4gPiB3b3VsZCBiZSBtb3JlIHN1Y2Nlc3NmdWw/DQo+ID4gDQo+ID4gSSd2ZSBiZWVu
IHRlc3RpbmcgYWxsIHdlZWsuIEkgcHVsbGVkIHRoZSBuZnMtcmRtYSB0cmVlIHRoYXQgd2FzDQo+
ID4gc2VudCB0byBMaW51cw0KPiA+IGZvciA1LjE4IGFuZCB0ZXN0ZWQuIEkgc2VlIHRoZSBwcm9i
bGVtIG9uIHByZXR0eSBtdWNoIGFsbCB0aGUNCj4gPiBwYXRjaGVzLiBIb3dldmVyDQo+ID4gaXQn
cyB0aGUgZnJlcXVlbmN5IHRoYXQgaXQgaGl0cyB3aGljaCBjaGFuZ2VzLg0KPiA+IA0KPiA+IEkn
bGwgc2VlIDEtNSBjeWNsZXMgb3V0IG9mIDI1MDAgd2hlcmUgdGhlIGNvcHkgdGFrZXMgbWludXRl
cyB1cCB0bzoNCj4gPiAiTkZTOiBDb252ZXJ0IHJlYWRkaXIgcGFnZSBjYWNoZSB0byB1c2UgYSBj
b29raWUgYmFzZWQgaW5kZXgiDQo+ID4gDQo+ID4gQWZ0ZXIgdGhpcyBJIHN0YXJ0IHNlZWluZyBp
dCBhcm91bmQgMTAgdGltZXMgaW4gNTAwIGFuZCBieSB0aGUgbGFzdA0KPiA+IHBhdGNoIDEwDQo+
ID4gdGltZXMgaW4gbGVzcyB0aGFuIDEwMC4NCj4gPiANCj4gPiBJcyB0aGVyZSBhbnkga2luZCBv
ZiB0cmFjaW5nL2RlYnVnZ2luZyBJIGNvdWxkIHR1cm4gb24gdG8gZ2V0IG1vcmUNCj4gPiBpbnNp
Z2h0IG9uDQo+ID4gd2hhdCBpcyB0YWtpbmcgc28gbG9uZyB3aGVuIGl0IGRvZXMgZ28gYmFkPw0K
PiA+IA0KPiANCj4gUmFuIGEgdGVzdCB3aXRoIC1yYzYgYW5kIHRoaXMgdGltZSBzZWUgYSBodW5n
IHRhc2sgdHJhY2Ugb24gdGhlDQo+IGNvbnNvbGUgYXMgd2VsbA0KPiBhcyBhbiBORlMgUlBDIGVy
cm9yLg0KPiANCj4gWzMyNzE5Ljk5MTE3NV0gbmZzOiBSUEMgY2FsbCByZXR1cm5lZCBlcnJvciA1
MTINCj4gLg0KPiAuDQo+IC4NCj4gWzMyOTMzLjI4NTEyNl0gSU5GTzogdGFzayBrd29ya2VyL3Ux
NDU6MjM6ODg2MTQxIGJsb2NrZWQgZm9yIG1vcmUNCj4gdGhhbiAxMjIgc2Vjb25kcy4NCj4gWzMy
OTMzLjI5MzU0M13CoMKgwqDCoMKgwqAgVGFpbnRlZDogRyBTwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDUuMTguMC1yYzYgIzENCj4gWzMyOTMzLjI5OTg2OV0gImVjaG8gMCA+IC9wcm9j
L3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyINCj4gZGlzYWJsZXMgdGhpcw0KPiBt
ZXNzYWdlLg0KPiBbMzI5MzMuMzA4NzQwXSB0YXNrOmt3b3JrZXIvdTE0NToyMyBzdGF0ZTpEIHN0
YWNrOsKgwqDCoCAwIHBpZDo4ODYxNDENCj4gcHBpZDrCoMKgwqDCoCAyDQo+IGZsYWdzOjB4MDAw
MDQwMDANCj4gWzMyOTMzLjMxODMyMV0gV29ya3F1ZXVlOiBycGNpb2QgcnBjX2FzeW5jX3NjaGVk
dWxlIFtzdW5ycGNdDQo+IFszMjkzMy4zMjQ1MjRdIENhbGwgVHJhY2U6DQo+IFszMjkzMy4zMjcz
NDddwqAgPFRBU0s+DQo+IFszMjkzMy4zMjk3ODVdwqAgX19zY2hlZHVsZSsweDNkZC8weDk3MA0K
PiBbMzI5MzMuMzMzNzgzXcKgIHNjaGVkdWxlKzB4NDEvMHhhMA0KPiBbMzI5MzMuMzM3Mzg4XcKg
IHhwcnRfcmVxdWVzdF9kZXF1ZXVlX3hwcnQrMHhkMS8weDE0MCBbc3VucnBjXQ0KPiBbMzI5MzMu
MzQzNjM5XcKgID8gcHJlcGFyZV90b193YWl0KzB4ZDAvMHhkMA0KPiBbMzI5MzMuMzQ4MTIzXcKg
ID8gcnBjX2Rlc3Ryb3lfd2FpdF9xdWV1ZSsweDEwLzB4MTAgW3N1bnJwY10NCj4gWzMyOTMzLjM1
NDE4M13CoCB4cHJ0X3JlbGVhc2UrMHgyNi8weDE0MCBbc3VucnBjXQ0KPiBbMzI5MzMuMzU5MTY4
XcKgID8gcnBjX2Rlc3Ryb3lfd2FpdF9xdWV1ZSsweDEwLzB4MTAgW3N1bnJwY10NCj4gWzMyOTMz
LjM2NTIyNV3CoCBycGNfcmVsZWFzZV9yZXNvdXJjZXNfdGFzaysweGUvMHg1MCBbc3VucnBjXQ0K
PiBbMzI5MzMuMzcxMzgxXcKgIF9fcnBjX2V4ZWN1dGUrMHgyYzUvMHg0ZTAgW3N1bnJwY10NCj4g
WzMyOTMzLjM3NjU2NF3CoCA/IF9fc3dpdGNoX3RvX2FzbSsweDQyLzB4NzANCj4gWzMyOTMzLjM4
MTA0Nl3CoCA/IGZpbmlzaF90YXNrX3N3aXRjaCsweGIyLzB4MmMwDQo+IFszMjkzMy4zODU5MThd
wqAgcnBjX2FzeW5jX3NjaGVkdWxlKzB4MjkvMHg0MCBbc3VucnBjXQ0KPiBbMzI5MzMuMzkxMzkx
XcKgIHByb2Nlc3Nfb25lX3dvcmsrMHgxYzgvMHgzOTANCj4gWzMyOTMzLjM5NTk3NV3CoCB3b3Jr
ZXJfdGhyZWFkKzB4MzAvMHgzNjANCj4gWzMyOTMzLjQwMDE2Ml3CoCA/IHByb2Nlc3Nfb25lX3dv
cmsrMHgzOTAvMHgzOTANCj4gWzMyOTMzLjQwNDkzMV3CoCBrdGhyZWFkKzB4ZDkvMHgxMDANCj4g
WzMyOTMzLjQwODUzNl3CoCA/IGt0aHJlYWRfY29tcGxldGVfYW5kX2V4aXQrMHgyMC8weDIwDQo+
IFszMjkzMy40MTM5ODRdwqAgcmV0X2Zyb21fZm9yaysweDIyLzB4MzANCj4gWzMyOTMzLjQxODA3
NF3CoCA8L1RBU0s+DQo+IA0KPiBUaGUgY2FsbCB0cmFjZSBzaG93cyB1cCBhZ2FpbiBhdCAyNDUs
IDM2OCwgYW5kIDQ5MSBzZWNvbmRzLiBTYW1lDQo+IHRhc2ssIHNhbWUgdHJhY2UuDQo+IA0KPiAN
Cj4gDQo+IA0KDQpUaGF0J3MgdmVyeSBoZWxwZnVsLiBUaGUgYWJvdmUgdHJhY2Ugc3VnZ2VzdHMg
dGhhdCB0aGUgUkRNQSBjb2RlIGlzDQpsZWFraW5nIGEgY2FsbCB0byB4cHJ0X3VucGluX3Jxc3Qo
KS4NCg0KDQpGcm9tIHdoYXQgSSBjYW4gc2VlLCBycGNyZG1hX3JlcGx5X2hhbmRsZXIoKSB3aWxs
IGFsd2F5cyBjYWxsDQp4cHJ0X3Bpbl9ycXN0KCkswqBhbmQgdGhhdCBjYWxsIGlzIHJlcXVpcmVk
IHRvIGJlIG1hdGNoZWQgYnkgYSBjYWxsIHRvDQp4cHJ0X3VucGluX3Jxc3QoKSBiZWZvcmUgdGhl
IGhhbmRsZXIgZXhpdHMuIEhvd2V2ZXIgdGhvc2UgY2FsbHMgdG8NCnhwcnRfdW5waW5fcnFzdCgp
IGFwcGVhciB0byBiZSBzY2F0dGVyZWQgYXJvdW5kIHRoZSBjb2RlLCBhbmQgaXQgaXMgbm90DQph
dCBhbGwgb2J2aW91cyB0aGF0IHRoZSByZXF1aXJlbWVudCBpcyBiZWluZyBmdWxmaWxsZWQuDQoN
CkNodWNrLCB3aHkgZG9lcyB0aGF0IGNvZGUgbmVlZCB0byBiZSBzbyBjb21wbGV4Pw0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
