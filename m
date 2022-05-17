Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD65296CB
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 03:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiEQBgw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 21:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiEQBgv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 21:36:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2136.outbound.protection.outlook.com [40.107.100.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB962E68F
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 18:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuqLOLCef4buITYYr3lYL9rQxTzq5Whp3TsYBYo7LPNgtkbwvwi1fkwJG5fDDrLCTrc/i38W4JWB/Qd95Mm5L3aBshoGY9VezREnuVIVMxv1uAymzGMOwmImJAWWTJmynHjDKzfWco5j11xCJv0KwpkqzDArQSlq/m2Eh20kzSy3RJNCIo4ROIYqYUL69PxvHA8hxda9qwU4s4vmZOEfsPJuqZpbuuq1mBOfB5Rl7RhKDCcm+CR+cfd2/vyOGBBpRL8999MNFrFlxQ1kO6I08XoWAWvtZYxW78LXcyS++euV+zRNuV9jg9Kq8IFwzgafiacI+mK3ouNXZqgZvfUB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzMRP/EfD786SngjHes+X9CC1pcRGc2iEMwNBLyRfJ8=;
 b=JZER3pzBEL+1UcaBYwLohhIkpm6M3xgwC8QNw+EhLsyP9dcpTRGQaMXT73LzfV9tYxPv+Cry58KiRilVEzWlBuxmndPEHcekv6lFOwwYUHn6T6+tEUCvW/XHDoTk2lOkve3e3Ygk6DElz9+Q0P7ngPjldyw/VaylJ93SYmeDxwooenCqnhRkvw3zU1t7ETacoP3J2Vuh7YW+AYaAs8h7PdNLtMl2wrMyTDc6QET2fxZtGUI/CC4C2WdffOPoQhRiqwX65vJYbR4uSIJB0pAWv+YF/7vYiThMljSJJWR730zpjL+oPjXP4Rl/7fvIZeIycARe81R7lV3S9zWud+P53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzMRP/EfD786SngjHes+X9CC1pcRGc2iEMwNBLyRfJ8=;
 b=D3c/cTDp/o6IaUGaATlAZL4uB1ATFD2gSvJaxLCGFXeGZPyrzlHmydPEzBBgCNWOHHuNvPubEQlfv+J34GcdzxVzUwIZFJ6glh0kqS60Ae8wfqfPTPvgaFHS69cSFs7hqlwbW5ge1y4ERAWcjbM5jmcF/MjhkZ7W/z6EQ6mDglg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4631.namprd13.prod.outlook.com (2603:10b6:408:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Tue, 17 May
 2022 01:36:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 01:36:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74A=
Date:   Tue, 17 May 2022 01:36:48 +0000
Message-ID: <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>   ,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>        ,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>       ,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>        ,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>       ,
 <165274950799.17247.7605561502483278140@noble.neil.brown.name> ,
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
         <165275056203.17247.1826100963816464474@noble.neil.brown.name>
In-Reply-To: <165275056203.17247.1826100963816464474@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07336356-3691-4c9e-75dd-08da37a5b5fb
x-ms-traffictypediagnostic: BN0PR13MB4631:EE_
x-microsoft-antispam-prvs: <BN0PR13MB46311AC941C878D191DC42FBB8CE9@BN0PR13MB4631.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJ+17CpKUVBPlhJ8MIyaYxw5LB8OkPYGQqHieZSXXJ8L8haoH5Y9KdTnljIvUTK35l6Ji+ciPdwRCbE8dnCMgYiDbhM9/wVxT+MJePnOm2nvRnyuB3ozoX7P2ze1LVpGCi7i0G2TGlxe0lL7Pk3faYxPTSdB8wcgiJYdZJY5MQhU8KSpaJPb9Txl6n3tkqkj1LNJcfZl6UWLVuwkXJM2EreQLZvAfFd0ULJMkw86cTaLkSr9I3sYCwJqVMPOYScpu7/eR0JHa7oJwfz2119VU4TV82cwGZe89ceJ5ARBcql9mA5yiKM8TgXkEDaG1LHPttOHzIry3tB5umpPRqasHP6NbfsMm0LnFLSBUw6PnAtie0czxhBtBN0x9gAVLbNFWswgq6Ogtwpxuc2LBGXqvzySauVqvG36bvytyf5e6vkQ0+gXlwm03E2cjj5fo+t+MFgsycvCVObjgv2ReyDA1LWw4ahzIIiaytjE/iZ7DXCpME+NsvZCsLctaDqm2D+92IqXqX2s5lf8kYUGFFTqyhj5ww7PCVHu0avIqz16sbmhnfTSkL3pUTI+HGAJc33igaxWyR0sCWiXzgojSpDVkIs6qEhcN7DJ1D4tUKy9YbP3S7ewle5Hdzxi3TaE8fFhVHmkNvoipxidT8L8jyeSRUSftVdW4LJouDrPbtZQhmtIqgUnUVtWbR96ErmNOATSaGNAVu5KdKZi+Jz4u2EMylPFwbPeQ5oE5ymTsqlXsUMNXhusxDswSthxW3sbwyxy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(66946007)(6486002)(122000001)(4326008)(26005)(66556008)(76116006)(66446008)(66476007)(6506007)(64756008)(71200400001)(2906002)(38100700002)(38070700005)(8936002)(316002)(36756003)(54906003)(6916009)(186003)(2616005)(5660300002)(8676002)(508600001)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGxUSEczbmlQRVhGblZWa3J3RDZnTEN5em8xa0MxVVBjdHZaRWEzZGZtQVBy?=
 =?utf-8?B?VitKS3BFSTZpaDFmYXQrRjRuL0dsYitrUTZEM3lkbTlOY1l0N0xDNmlMNktO?=
 =?utf-8?B?S1JjZGtZWG1zekd4dVFiTm5oZU15QjNvYlpoWTgrVURYMXc0dHVFdnF5OEJL?=
 =?utf-8?B?Ny9YWDllaHAwd0JxaUgwUTNqNjI3NXNlOUpoR1RoOGd2NlVRZ2Vzd080M1Rz?=
 =?utf-8?B?UUpmT242RzNzUzdIZnVnUGZkbEhESndLVnNaa215YWZQVkc5eUNnMFdNN1U2?=
 =?utf-8?B?RDRkZ0M4cGJHeUg0Q3VkZnhtUGlqb0hnRDhwaU83NmNmU20wVWZtUWVNaHB5?=
 =?utf-8?B?Q2t1U0tlUFI5RUYvNlNWcktUR2RjOTVHeUxYN1N4bGFmb0R0R1lSNmRIY2dG?=
 =?utf-8?B?OGxHUzgrcGUvMzVVYzRDRi9CcnM2SVZwaFRvQVQzWEphZTdDbDhlZmhPaXdW?=
 =?utf-8?B?a1dVZXE1L3hoZ1Z6U3hvNjZzODdCMm1ESlZHdlhlL3ZlL3czZjcyUnB3MUI3?=
 =?utf-8?B?V3R6ZndiVzI2ZzFOU3pla1lhcWM3djVHb2pIbDlEbzNhVExabDh3S1J2aWov?=
 =?utf-8?B?Y0hOd3IxR3BBa01sL0V4UysrVlExWndmendvSmtBbDZycDhWZXZjSzVQRzRi?=
 =?utf-8?B?WVZwYjhZRVhuZk02aHJ6TktaUmNjN3RJMjNaZ1E2bGxiUUJHeHY3TVZTTVlS?=
 =?utf-8?B?bCtVcnBPekV5MzA4Y0Q1bU5yMTNuODJmaXJiZUp6Z1NXUzAvaTltVmtzYUJG?=
 =?utf-8?B?L1R6Z2NpMHMvcGUxZkoyd3d4UG9OQ2VtU29aMUxjNFkzSHNSVCt0dUhiZDdn?=
 =?utf-8?B?SzJOS3lhOXJLTjFaK1BEVXorZHlDcnY3dTRaNURuVzVqbWFxVGxuRlZoYmRw?=
 =?utf-8?B?NFRZd1Y5UWhNZ0Q5OWl5QjRONUZBQm95U3RiREh4RTFIWDdRYWg5OHJvVkNM?=
 =?utf-8?B?cldrUGg5SnFwS0dMdE1HcFJVMGJ1UkpiWTFTOW85Vjg0VG9Rb1cyeU5sMmdF?=
 =?utf-8?B?ZjdNRTM0MjJ4N29XQ0kzaTJ5b1dra2hXUWJUaVZXbDNoUHFmVitkMkkxMm9Z?=
 =?utf-8?B?MktXMmFMbVZVR1RrWHhLR0dGN1V2Mk1hcFZ6SmlxU0toNG5ET1IrUjhtZEVL?=
 =?utf-8?B?OXEzSm91dnhoWGFBYlJJcWxqS25JeGY0Qy9mM0FHbXN3MHRqN1hwa2R1ZFVV?=
 =?utf-8?B?WjFPT2p5NnRoZ0tOLzZHTTkrVGdwUERSUEp5MlpwL2owUVJER1RCRy9aY2l0?=
 =?utf-8?B?QkllK1N0RUdLWVlZczhURTJZVVUrVW1mcHdPcUtYMUVXcGFhSVBRNExXM0ZO?=
 =?utf-8?B?bFRNS1dFZnpGSSswVEVYRmJPVmhQSG04Q3BPWXhMUkVMWmhpaE50YTVjS3Vl?=
 =?utf-8?B?K2YxMGNBVGU0MkZPNTU4RkpaSFZFTTBNcWY1dUZzYjlQNkdTbGlrK3daZzRN?=
 =?utf-8?B?LzgxNkxTclU5U1VDd05Eekc2Nm9jVUZQb2E4ODdvT1FqYTlQVmtNZlNCdk8x?=
 =?utf-8?B?QnBBTU1JTmQ2OERRVzhxVUY1cys4ejFyR0o0TnByRlYxVzl0S0VPRlpTTmRi?=
 =?utf-8?B?akFvdjc5SVBRc3pRTnpWOVQ1WFF0UTBDaWZRdlpuendJUUxLSzVVQStwaWMv?=
 =?utf-8?B?L1NCOE5TRHJVVDhtZjhCUGFTSHIzeHdLSzJkc3VLYnpMR1BYL3JoTDRLcmJx?=
 =?utf-8?B?T2FSclpNRk16UFdQNEwrQ0R3UDcyWnhUMi9oZ1dBSDNWeDBDWmdiV1BFd0Ix?=
 =?utf-8?B?K2NOamxyNDBRR1dkU0E1MXlQTWNTa1dyK0JpK3N2a3BNR2lCbWhvN09kdkFX?=
 =?utf-8?B?dWlpQVFLS2RLam1wT3JLV0VXTFpHVnF5ZWYzTUJEbHk3bEwxYkIwRUtyWjFK?=
 =?utf-8?B?cVg5YUcwOXAvZm9hRHVXclc0UjA1Yi9EWnhkTi8yRUY1em5NelNrT2RzWDEv?=
 =?utf-8?B?ZDcrM09qV3VMSnJNd0kzTVd2YmxxYWpwbll4aFVyd2dwVVliZGZmckxhbW9D?=
 =?utf-8?B?RDk5M0U3dTExbjJrais4eWNrK29JL0l4UzVnS0xEbEFuTVNsVXBGLy8xanFI?=
 =?utf-8?B?cERNRDUzdDJ0Z2podTZnRHE0U3R1MWNoOC9xa1FTMWNJTXg4VlBZNS96bDU3?=
 =?utf-8?B?Rms1NWM3MVdpSFlRZWtHNU8rd3IxTGJtMkZ0MUMzQmVxYmNYQVBzM1ZyU0Vi?=
 =?utf-8?B?cGVSUHAvek1jZksveVdERmVjY1kwZnI5eWZQV1Z3TEUvSG9vMWFGVGIwRUpJ?=
 =?utf-8?B?czE1Nzh6VDNlWnlpMi9JQ0pIRUk1SGh4eEVPTDQvNG00Z2g5ajFMUkNYbGd3?=
 =?utf-8?B?cThvRWhXcjJvZWFtbmUySzR4L3N5VFBBaEF2WjRxdTZxSUM4dG5sNldkZlRk?=
 =?utf-8?Q?DlnEU/cBxiZcNfa0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F423C74A3C67645969885F42CDB8D61@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07336356-3691-4c9e-75dd-08da37a5b5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 01:36:48.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtS7EcaQ2JLiEmefE0AxPnJ4iUwc9oRMJ3cxyuxo8OtralIKPFSLDQpc5zcu6TmRmHhjDqgadcpTbMSTCzbisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDExOjIyICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMTcgTWF5IDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjItMDUtMTcgYXQgMTE6MDUgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
MTcgTWF5IDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIy
LTA1LTE3IGF0IDEwOjQwICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVl
LCAxNyBNYXkgMjAyMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gVHVl
LCAyMDIyLTA1LTE3IGF0IDEwOjA1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPiA+ID4gwqBhbnkgdGhvdWdodHMgb24g
dGhlc2UgcGF0Y2hlcz8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBU
byBtZSwgdGhpcyBwcm9ibGVtIGlzIHNpbXBseSBub3Qgd29ydGggYnJlYWtpbmcgaG90IHBhdGgN
Cj4gPiA+ID4gPiA+IGZ1bmN0aW9uYWxpdHkNCj4gPiA+ID4gPiA+IGZvci4gSWYgdGhlIGNyZWRl
bnRpYWwgY2hhbmdlcyBvbiB0aGUgc2VydmVyLCBidXQgbm90IG9uDQo+ID4gPiA+ID4gPiB0aGUN
Cj4gPiA+ID4gPiA+IGNsaWVudA0KPiA+ID4gPiA+ID4gKHNvDQo+ID4gPiA+ID4gPiB0aGF0IHRo
ZSBjcmVkIGNhY2hlIGNvbXBhcmlzb24gc3RpbGwgbWF0Y2hlcyksIHRoZW4gd2h5IGRvDQo+ID4g
PiA+ID4gPiB3ZQ0KPiA+ID4gPiA+ID4gY2FyZT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
SU9XOiBJJ20gYSBOQUNLIHVudGlsIGNvbnZpbmNlZCBvdGhlcndpc2UuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gSW4gd2hhdCB3YXkgaXMgdGhlIGhvdCBwYXRoIGJyb2tlbj/CoCBJdCBvbmx5IGFm
ZmVjdCBhDQo+ID4gPiA+ID4gcGVybWlzc2lvbg0KPiA+ID4gPiA+IHRlc3QNCj4gPiA+ID4gPiBm
YWlsdXJlLsKgIFdoeSBpcyB0aGF0IGNvbnNpZGVyZWQgImhvdCBwYXRoIj8/DQo+ID4gPiA+IA0K
PiA+ID4gPiBJdCBpcyBhIHBlcm1pc3Npb24gdGVzdCB0aGF0IGlzIGNyaXRpY2FsIGZvciBjYWNo
aW5nIHBhdGgNCj4gPiA+ID4gcmVzb2x1dGlvbiBvbg0KPiA+ID4gPiBhIHBlci11c2VyIGJhc2lz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBSRkMgMTgxMyBzYXlzIC0gZm9yIE5G
U3YzIGF0IGxlYXN0IC0gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBUaGUgaW5m
b3JtYXRpb24gcmV0dXJuZWQgYnkgdGhlIHNlcnZlciBpbiByZXNwb25zZSB0bw0KPiA+ID4gPiA+
IGFuDQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBBQ0NFU1MgY2FsbCBpcyBub3QgcGVybWFuZW50LiBJ
dCB3YXMgY29ycmVjdCBhdCB0aGUNCj4gPiA+ID4gPiBleGFjdA0KPiA+ID4gPiA+IMKgwqDCoMKg
wqAgdGltZSB0aGF0IHRoZSBzZXJ2ZXIgcGVyZm9ybWVkIHRoZSBjaGVja3MsIGJ1dCBub3QNCj4g
PiA+ID4gPiDCoMKgwqDCoMKgIG5lY2Vzc2FyaWx5IGFmdGVyd2FyZHMuIFRoZSBzZXJ2ZXIgY2Fu
IHJldm9rZSBhY2Nlc3MNCj4gPiA+ID4gPiDCoMKgwqDCoMKgIHBlcm1pc3Npb24gYXQgYW55IHRp
bWUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ2xlYXJseSB0aGUgc2VydmVyIGNhbiBhbGxvdyBh
bGxvdyBhY2Nlc3MgYXQgYW55IHRpbWUuDQo+ID4gPiA+ID4gVGhpcyBzZWVtcyB0byBhcmd1ZSBh
Z2FpbnN0IGNhY2hpbmcgLSBvciBhdCBsZWFzdCBhZ2FpbnN0DQo+ID4gPiA+ID4gcmVseWluZw0K
PiA+ID4gPiA+IHRvbw0KPiA+ID4gPiA+IGhlYXZpbHkgb24gdGhlIGNhY2hlLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFJGQyA4ODgxIGhhcyB0aGUgc2FtZSB0ZXh0IGZvciBORlN2NC4xIC0gc2Vj
dGlvbiAxOC4xLjQNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAid2h5IGRvIHdlIGNhcmU/IiBCZWNh
dXNlIHRoZSBzZXJ2ZXIgaGFzIGNoYW5nZWQgdG8gZ3JhbnQNCj4gPiA+ID4gPiBhY2Nlc3MsDQo+
ID4gPiA+ID4gYnV0DQo+ID4gPiA+ID4gdGhlIGNsaWVudCBpcyBpZ25vcmluZyB0aGUgcG9zc2li
aWxpdHkgb2YgdGhhdCBjaGFuZ2UgLSBzbw0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IHVzZXIN
Cj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+IHByZXZlbnRlZCBmcm9tIGRvaW5nIHdvcmsuDQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGUgc2VydmVyIGVuZm9yY2VzIHBlcm1pc3Npb25zIGluIE5GUy4gVGhl
IGNsaWVudCBwZXJtaXNzaW9ucw0KPiA+ID4gPiBjaGVja3MNCj4gPiA+ID4gYXJlIHBlcmZvcm1l
ZCBpbiBvcmRlciB0byBnYXRlIGFjY2VzcyB0byBkYXRhIHRoYXQgaXMgYWxyZWFkeQ0KPiA+ID4g
PiBpbg0KPiA+ID4gPiBjYWNoZS4NCj4gPiA+IA0KPiA+ID4gU28gaWYgdGhlIHBlcm1pc3Npb24g
Y2hlY2sgZmFpbHMsIHRoZW4gdGhlIGNsaWVudCBzaG91bGQgaWdub3JlDQo+ID4gPiB0aGUNCj4g
PiA+IGNhY2hlIGFuZCBhc2sgdGhlIHNlcnZlciBmb3IgdGhlIHJlcXVlc3RlZCBkYXRhLCBzbyB0
aGF0IHRoZQ0KPiA+ID4gc2VydmVyDQo+ID4gPiBoYXMNCj4gPiA+IGEgY2hhbmNlIHRvIGVuZm9y
Y2UgdGhlIHBlcm1pc3Npb25zIC0gd2hldGhlciBkZW55aW5nIG9yIGFsbG93aW5nDQo+ID4gPiB0
aGUNCj4gPiA+IGFjY2Vzcy4NCj4gPiA+IA0KPiA+ID4gSSBjb21wbGV0ZWx5IGFncmVlIHdpdGgg
eW91LCBhbmQgdGhhdCBpcyBlZmZlY3RpdmVseSB3aGF0IG15DQo+ID4gPiBwYXRjaA0KPiA+ID4g
aW1wbGVtZW50cy4NCj4gPiA+IA0KPiA+IA0KPiA+IE5vLiBJJ20gc2F5aW5nIHRoYXQgbm8gbWF0
dGVyIGhvdyBtYW55IHNwZWMgcGFyYWdyYXBocyB5b3UgcXVvdGUgYXQNCj4gPiBtZSwNCj4gPiBJ
J20gbm90IHdpbGxpbmcgdG8gaW50cm9kdWNlIGEgdGltZW91dCBvbiBhIGNhY2hlIHRoYXQgaXMg
Y3JpdGljYWwNCj4gPiBmb3INCj4gPiBwYXRoIHJlc29sdXRpb24gaW4gb3JkZXIgdG8gYWRkcmVz
cyBhIGNvcm5lciBjYXNlIG9mIGEgY29ybmVyIGNhc2UuDQo+ID4gDQo+ID4gSSdtIHNheWluZyB0
aGF0IGlmIHlvdSB3YW50IHRoaXMgcHJvYmxlbSBmaXhlZCwgdGhlbiB5b3UgbmVlZCB0bw0KPiA+
IGxvb2sNCj4gPiBhdCBhIGRpZmZlcmVudCBzb2x1dGlvbiB0aGF0IGRvZXNuJ3QgaGF2ZSBzaWRl
LWVmZmVjdHMgZm9yIHRoZQ0KPiA+IDk5Ljk5OTk5JSBjYXNlcyBvciBtb3JlIHRoYXQgSSBkbyBj
YXJlIGFib3V0Lg0KPiANCj4gV2hhdCwgc3BlY2lmaWNhbGx5LCBhcyB0aGUgY2FzZXMgdGhhdCB5
b3UgZG8gY2FyZSBhYm91dD8NCg0KVGhlIGdlbmVyYWwgY2FzZSwgd2hlcmUgdGhlIGdyb3VwIG1l
bWJlcnNoaXAgaXMgbm90IGNoYW5naW5nIG9uIHRoZQ0Kc2VydmVyIHdpdGhvdXQgYWxzbyBjaGFu
Z2luZyBvbiB0aGUgY2xpZW50LiBXaGV0aGVyIGl0IGlzIHBvc2l0aXZlIG9yDQpuZWdhdGl2ZSBs
b29rdXBzLiBJIGNhcmUgYWJvdXQgdGhlIGFiaWxpdHkgb2YgdGhlIGNsaWVudCB0byBtYW5hZ2Ug
aXRzDQpjYWNoZSB3aXRob3V0IGdyYXR1aXRvdXMgaW52YWxpZGF0aW9ucy4NCg0KVGhpcyBpc24n
dCBldmVuIHNvbWV0aGluZyB0aGF0IGlzIHNwZWNpZmljIHRvIE5GUy4gVGhpcyBpcyBob3cgbG9j
YWwNCmZpbGVzeXN0ZW1zIG9wZXJhdGUgdG9vLg0KDQpTbyB1bnRpbCB5b3UgaGF2ZSBhIGRpZmZl
cmVudCBzb2x1dGlvbiB0aGF0IGRvZXNuJ3QgaW1wYWN0IHRoZSBjbGllbnQncw0KYWJpbGl0eSB0
byBjYWNoZSBwZXJtaXNzaW9ucywgdGhlbiB0aGUgYW5zd2VyIGlzIGdvaW5nIHRvIGJlICJubyIg
dG8NCnRoZXNlIHBhdGNoZXMuDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=
