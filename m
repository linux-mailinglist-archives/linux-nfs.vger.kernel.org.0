Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3958847A21D
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 21:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhLSUt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 15:49:56 -0500
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com ([104.47.66.47]:6046
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233472AbhLSUty (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 19 Dec 2021 15:49:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U06mzr4j9zFOBLa85aoEgR+zkbQlVoQP2WU5dfZ1V3nPsfm21pOO4X34u85y607nwCYtGgjx0IZDhRDjGnOElAntnyVH7ORceLAMkzLDAiKiGO+nyTBkMts1AOv5jxNH97gcvjBB7K5tkPBfb2VkHkwJXZNfoeoJBN+hkQEOFjRKgPkTdgyw3R7SSttHlKXrHHf/l9uqALIpYk9hwMnV5yYahZTbUxREz2R0ehIOYk4b8MW1twGMv44isf04yJVx8Tn5ISnTUgM/6hZhH0BiHonSL23ARGau56PMXr7pACoT4jIuf59ekQQvDsmhFwdPB2r0/59+ha3IoD9dkDJwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENbGPe9X9UiQlvqVB9KfaCo4w6EHj6HnyHyZZcZRN24=;
 b=LRGq2edrmkXpAQd86oiGvu3qB+eSKGzYF6zHYalwvWM/osH8qT5wbpn42t0saCVaesJvFJx4S5ExQVo7mdutt0hS6AUONMLNbGN154XFvIgf/OiSrKhpVXXY7a2GDJkif1zdHz7h6cRA6mBI0mLAjNM12TabvSF5OWc7g0sm4QxtId685mHvDXEM9AGVOeFr2sY32/cJg04qklydwl7yHGHRDogEvlwWO+Hz3sixMKw87oYc8uOZVU12qAt8HWs708er+FYTEy56arz5hVduEDZeA6o0RvFNt2BvY3sR58ZRlGYCMmtyoV5yBFg7z3EVHfExD/MawonacMRjNdyrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENbGPe9X9UiQlvqVB9KfaCo4w6EHj6HnyHyZZcZRN24=;
 b=Cbv3T8QCnQTaMpObqlx+b4+Ef6szE2derfGuAZpp989PA5E/wHgJO9ttOhJjYyXbflfMShaUJnqOx19m4y/odGRnhngdShJSc6RDbtmzmO2nd/G+Y4xjEO2MxmkrO76absU+FXXUyZdyFf4ZLZ1YviwEPH+zwS+3HFWwB0h9HAw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5715.namprd13.prod.outlook.com (2603:10b6:510:116::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8; Sun, 19 Dec
 2021 20:49:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4823.014; Sun, 19 Dec 2021
 20:49:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Topic: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Index: AQHX9HoJzJa8MHrJokmLlev6qmlSfqw6H8CAgAArNwA=
Date:   Sun, 19 Dec 2021 20:49:50 +0000
Message-ID: <3167a9a815ac9c82700bd58d8c421de31eee8b91.camel@hammerspace.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
         <20211219013803.324724-2-trondmy@kernel.org>
         <20211219013803.324724-3-trondmy@kernel.org>
         <20211219013803.324724-4-trondmy@kernel.org>
         <20211219013803.324724-5-trondmy@kernel.org>
         <20211219013803.324724-6-trondmy@kernel.org>
         <20211219013803.324724-7-trondmy@kernel.org>
         <20211219013803.324724-8-trondmy@kernel.org>
         <20211219013803.324724-9-trondmy@kernel.org>
         <20211219013803.324724-10-trondmy@kernel.org>
         <20211219013803.324724-11-trondmy@kernel.org>
         <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
In-Reply-To: <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36840fcf-305d-46d4-449f-08d9c3311a06
x-ms-traffictypediagnostic: PH0PR13MB5715:EE_
x-microsoft-antispam-prvs: <PH0PR13MB57153397C4034C5B4FD97635B87A9@PH0PR13MB5715.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +O3I+3KEdGmVO8YhywgvRHS8gz2hx5lwu+fBt/tG1YUTAWzVGmHqeGKCKaDnPIiH3OzHXw0Bm9tiVmjpGrknzWPzyBSvseho9pu2EKSOwDrV0gogfPbEaWKiPqXCqiGCYqkzrZbplkJo6/76Z5UxXUe+QZ7k8CX/vnZI3OEJ2NvbUZy+5uSf/WUj8BXyoMDX85Jf6Ej57k6bQ18MsvjoQ+N+BorORjSk6eeC5+WI77umIOMPdX6uSUgwMfaBe+uiNRXFdqDJk4947C/ZjYVAStmznydG8OTJrCGHC1l8/oM/42cKH1S7bHe2Kr6RIHunHGREav+J2FNUM7XzGBmPg1xeUQEta60vqdutMgB+K+YidadvTTwkMAzQcy3d6O8YAtGFyJtUAD7rS6619Puo7Q6WWKTOAO/CJv2WdSL6XLiWxopmwO5B5MFCfudvHy3qi9JrNrtvqm/Nj5z1RdEK5KXaKb8e0RrVVJWcxlRQ/5iQ2gNoAlzzELn/vGMDwqqny65u+oL4/pApfGNA/WQpNS1Pc0wU3jjvxrNIJN9XC4afwWA+9duBU4J+1nuPNf2vf7JZsAXN4pKzQiz5NX9eN22fQ75mlBy5167fOqZkeEDbDn1tsl9Hh0eOiM4AhHRMCtG0B/Bqm4nwTd8vHN560pBcd/CYSSfyKnvb+WB0Qn2/pI7iLBPIxX/hblFS628ht91EbMhW66AAZQXlIpxm3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(376002)(136003)(39830400003)(346002)(396003)(316002)(110136005)(66446008)(76116006)(8676002)(83380400001)(66556008)(8936002)(54906003)(4326008)(4001150100001)(64756008)(66476007)(122000001)(38070700005)(86362001)(38100700002)(4744005)(6512007)(71200400001)(2616005)(53546011)(66946007)(508600001)(6486002)(6506007)(5660300002)(36756003)(2906002)(26005)(186003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVVXdGh3S3BWK2t4MHhBV1FSLzUrNGJhZHRlVFBibERaT0UvbVBveC9SYm1m?=
 =?utf-8?B?QTRScWxKR3VRWi9aUnBkWXBNaVFFUHFkbG5RWENTWXZxRmtiOGxpZC9VajI2?=
 =?utf-8?B?THhoc3gyaXF2ejN2NXptVmp5bnNjRzZYd1R3bXNVeGR2R0ZYODVqQUxzbE14?=
 =?utf-8?B?czZpdmRjQ29qU0RLTUVwNWZ1YWhRMjRoWHlYeFBqRVNDTmg5czI3WDFrUjdG?=
 =?utf-8?B?bGRlV2pLajRoaENHOXl3NWx4alRrWkUya093eGVwZy9PR21WcU1EUENUc29D?=
 =?utf-8?B?TUJCZkV2amZLcmxTUlFsK3NrL0VVQnN5b0kzQmhHOVRMOXdydmNWU25FaStm?=
 =?utf-8?B?ZVgwZkM1WVJkSHJlYzVKMm1LVTlrVkpCejFJUVF3TTdzU1hObW5VeHNnQnE4?=
 =?utf-8?B?c1dETEo3czUrd0xwd01nU1FaOUw5Q0FUTWovMmR4ZkdDMk5iekFOSXR3NHFv?=
 =?utf-8?B?aEpuUktCWGJjRDFlWUtwUGpIK2NNelRTbHU4UmI2cFdyYlp3Mm03L1FqQmRZ?=
 =?utf-8?B?aWpyS0F2elV2dllmOVpTdWdqREJmVVVKWlhkQXBrb0MyMzRvVnRGUEtndkFL?=
 =?utf-8?B?RFFNTC9lUnFpM3dVVWhWTjJla1BHTWFzbENmK1FhdnF2T25TdU5uTVErSzJB?=
 =?utf-8?B?RTkyYW0ySlppLzVmTVlmWTgwRUxrL3R3ZnJUZExaVmFub2ZMOHVRaFNFQkdz?=
 =?utf-8?B?NkU3cmMyV3R5MXk4cEN4ejBjRWhuS25HNTY0aEgreUFMUjdBQU5tTGhnQTZW?=
 =?utf-8?B?NGdRTVA0L3FDbWFNdVJONlFHejBGdzNQQkxYSFgvRzRDS2QrYTY1d0dUQitD?=
 =?utf-8?B?WUsrRVhmRmhGTFNJaVY3UTNvYlJhWG9CRFpZcnVHdEw4Rk14VUUxZllGaDRi?=
 =?utf-8?B?TTZBWldoTlBQazJ1eDhVRUdOQWZVSVZadWNFeU8yaTFuRDhUaUIzSTdJaEhG?=
 =?utf-8?B?TnJLUExFU1MwNVZGNGg0MERwb1ZPcVUzYjlJTFZrVDJMeDBTb3pjWVE5VElj?=
 =?utf-8?B?cVNsQlRxNFV2emtxSHV3dndhWTNpTVNRM2F4cTJyVVVhRjdPUzZaL2dSRFZS?=
 =?utf-8?B?MllzYUdqSzZWK3hZRWwrbWlJSElJQ1R6dzRoWUVEdld3Uzh2NjRTYlNGRHdJ?=
 =?utf-8?B?aUp6UHhjNmdOdG54ZFJTZXJ3K1NlOGU2RDd2YSs3REZIWllGUlZHTjZxL29o?=
 =?utf-8?B?bmkraDBDTGlWK29iWG01WkNJMEllME1PSHdrcjQ4RmU4TC9YMEU3WEpDb01x?=
 =?utf-8?B?VXdKTjJ6VmZQNVNzWHFKM1VXRUNsaldPTjdFQWF0dWlTUE4rc0p3czlTY3Vs?=
 =?utf-8?B?c25zL0pnb2ltWHRJNDdET2dsYXBCZzdRRmJEZEo5YktmWDFnSmorcUFHYzBm?=
 =?utf-8?B?VDdiUVZEY0FQcUNBNmlvR1JqSkpvbm10WG5NWHBHRy9PZEJhbWlMbXZFUEFS?=
 =?utf-8?B?NS9GdjRncGdoRVhzWEYrUzZNejY1RSt5UUF4Mk0xeWRSQ3IwL2ZDSDlBNm1M?=
 =?utf-8?B?eEFGbHJlamRKVlB2R3c1MWZZdWpwTFZFSnRWL3dBbWdoNGc2Y0U5UmVYL2Ft?=
 =?utf-8?B?Y1ZVekswZXlITGxhelZ2SHpOazRxczRLdGJJd2ozb2ViaUtDRW9rZ3lXbEwx?=
 =?utf-8?B?eVBlbThvdUlnQWpINTBhaVR5QjF5Q0hSS3BaR2tzZGpYUDVEODVaWW5nWGZS?=
 =?utf-8?B?Y1M4K1l2emFJYzA3WG5MNVhEKzNPM3lHcFVmY21uRDhBMXpXTTIvSjB0c2s5?=
 =?utf-8?B?SU12ZktpcDNLbTlTZ3ZRVmVWS3VrK2RhTkJoY3FzSlMwR0FPNzhRS1JXdWRx?=
 =?utf-8?B?YVowcjhDeC9odjAwQlZ6OEhlbVE3Q05lYTEwUWdYZlVINXJiN1pXZ295cUNs?=
 =?utf-8?B?VEMxdXI3R2RhcTZxd2N1QkZyL2pEQ1VtUW1jSmg5djl5Wjk4b25GSVRNTmNI?=
 =?utf-8?B?WmthaWlFd1hPdExtVUJYbENpKzNkSlNIV1JwVFRFU1A3QWhOanlFMWZHbGxZ?=
 =?utf-8?B?TlJtUzdHZFlvemp2QnhJRS9EbGlwTzFxVnd6dGdWOStYc3ZXdWZhYzMrc3hW?=
 =?utf-8?B?VEU1cGVhR2N1YlR6TzRySGI5eUNJSW84ZzRvRFJacnhKb28velQ0V2swZytn?=
 =?utf-8?B?T2RKR2VIYkVvSGxlRXdnTHg1VnZuUE5kdnZIcXpTOVQ5YmJPcUZJL0VTdGll?=
 =?utf-8?Q?z7ELHHhbLGpShlMAk557sT0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FF0318D4910B14C816CED143F609332@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36840fcf-305d-46d4-449f-08d9c3311a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 20:49:50.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8CvwNFSxjmtpStHMc+QWO0JgZ0gW5+e8I3zJBTuhrcP5dXzWFvloGjsvqWMS93r+o0iZhxwEAiLiQiTvyo22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5715
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTEyLTE5IGF0IDE4OjE1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiA+IE9uIERlYyAxOCwgMjAyMSwgYXQgODozOCBQTSwgdHJvbmRteUBrZXJuZWwub3Jn
wqB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gTkZTdjQgZG9lc24ndCBuZWVkIHJwY2JpbmQs
IHNvIGxldCdzIG5vdCByZWZ1c2UgdG8gc3RhcnQgdXAganVzdA0KPiA+IGJlY2F1c2UNCj4gPiB0
aGUgcnBjYmluZCByZWdpc3RyYXRpb24gZmFpbGVkLg0KPiANCj4gQ29tbWl0IDdlNTViNTliMmYz
MiAoIlNVTlJQQy9ORlNEOiBTdXBwb3J0IGEgbmV3IG9wdGlvbiBmb3IgaWdub3JpbmcNCj4gdGhl
IHJlc3VsdCBvZiBzdmNfcmVnaXN0ZXIiKSBhZGRlZCB2c19ycGNiX29wdG5sLCB3aGljaCBpcyBh
bHJlYWR5DQo+IHNldCBmb3IgbmZzZDRfdmVyc2lvbjQuIElzIHRoYXQgbm90IGFkZXF1YXRlPw0K
PiANCg0KVGhlIG90aGVyIGlzc3VlIGlzIHRoYXQgdW5kZXIgY2VydGFpbiBjaXJjdW1zdGFuY2Vz
LCB5b3UgbWF5IGFsc28gd2FudA0KdG8gcnVuIE5GU3YzIHdpdGhvdXQgcnBjYmluZCBzdXBwb3J0
LiBGb3IgaW5zdGFuY2UsIHdoZW4geW91IGhhdmUgYQ0Ka25mc2Qgc2VydmVyIGluc3RhbmNlIHJ1
bm5pbmcgYXMgYSBkYXRhIHNlcnZlciwgdGhlcmUgaXMgdHlwaWNhbGx5IG5vDQpuZWVkIHRvIHJ1
biBycGNiaW5kLg0KDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
