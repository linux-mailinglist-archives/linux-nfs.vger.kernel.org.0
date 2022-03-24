Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33404E6AE4
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbiCXWwj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiCXWwh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 18:52:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194FEBAB9C
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 15:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td/US/ldAZaQuDMWCyyBK1FXQWdEhVU+htiKtkqvDWaG8meP9GDKJ0mIUxOXkCVu3oV+8LV5+LLs3nx0POxZmNPu69RxHhzHEZycFyhVn2/yRZdjZ7bPDNsbqcpaPhvqFlU1WE4kHdMSu4wBUihrBfsIClzMok/6i7U1Sv+nbQYsLxvh1GwFr+OilgWbJOtP2npr9adLfcpQOyCxT2dDNmRPQ6NiBBGn57YAo+AMz87o1eCad1pkD7v2MF9bznwmyOlsJb44/nkDgKT6oauZZMlOrcJXYUf2q8b9gbnXIaX7qVTQQlPEqn+Jax6GOAcMCSSFBdSU1fXhO/yMrKkiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3gV3xURvm9bR8LWnsKCPfTihUTeOL96I744OvuKo/Q=;
 b=KaT3bHk6dqA4oohvXRk6jv7iRIj9w5JxfNicZaZEUcLMwX7cdD8O0ftyH+qrZCQSsHaIw6l4P0VDz7C0Bwh2Z88f/Nvze/+i+vTkwcvOogMJucZp+zPTswo43u+8Iv3F6QfC+gLyGpEY2A9jWNrDydUCzlZs8SrkRhnB6CtMADoSb5vogZTwfv3uI8X4rVHVvJ7lsauGvduUI3I1Gde7vQVsy+ZWsdq8LikzBh1l2+BZzkdj8VFefAZ0jaBiIaVGuIuj9XHUfq7M+ntki3tz2NP4aZ7j726+jCO5JLZCXEb7HT2FOoGiE9mFXqgJVRPAauMbGQQeiAAMVy18SQwzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3gV3xURvm9bR8LWnsKCPfTihUTeOL96I744OvuKo/Q=;
 b=ccA1l5mi9s+Mh7wTS4sfqF2Bohi2fBgZFelOjEfS4BsAPvnfpClfMMDt6mCpzr7GjNzEKNfTV2ivD6FoMSJKz097qwA+luvz3qodNmnzeOy+SYw8lGJR2ITefQMNp9ifmkIw3kmfhtrK3fvLRlSwBvJqmbyp0V/cnqiJun4wcGE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN8PR13MB2788.namprd13.prod.outlook.com (2603:10b6:408:8c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Thu, 24 Mar
 2022 22:51:01 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 22:51:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Topic: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Index: AQHYP8uo0WXZgCK6JkiCUMP0y6+YoKzPI6kA
Date:   Thu, 24 Mar 2022 22:51:00 +0000
Message-ID: <83b0b0292bda06ffa56487ea1a019ea142107fa3.camel@hammerspace.com>
References: <164815968129.1809.12154191330176123202.stgit@manet.1015granger.net>
In-Reply-To: <164815968129.1809.12154191330176123202.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f1f7d15-e237-4a42-d110-08da0de8c4d9
x-ms-traffictypediagnostic: BN8PR13MB2788:EE_
x-microsoft-antispam-prvs: <BN8PR13MB2788A30C076B4ADA824A02F9B8199@BN8PR13MB2788.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRPCgtKMILxymRR6F6ohwNza8L6vhZFkV6cBrqjPZrKlnek/ZDuX3C+MgRFYEYfzucjoTTrTYJIavCFGaKunbe/6oQxTtzcTODjOO9vim/mYy+9ndtMOjRIdDwUjjdfXOnvLz65mQiZo6UEI81PHuuVsTzR08o/vyPjm3D169IU0r8jho2VnM2y93KHwhoTjJbVknPRACLmLGV8mM9PZIGRGx5lpQu0p0FqFEaLQA04SDloVpvh+sesx+GxXyNq6A/YH4+gKwEu37W7lwaExyxWXKOIGdLnT8eln0Bj9o1ZSyGJy5e2qzWOMJrHADraJY4g2d/iHSGh5fsPERAT4ztDKiSNksG6ulVjx3b84JS0wHS9OZME4cOhYzZ03SDulpTTqCTEsAukbSwQONz6egn1Afc3zG4Exxu08QTuqxxHPtoVCg30d9lOY0FF28Uk4mqzTQ3L3h7GFK4dNo/FSFTJkLPQ1UfHneTXLcNNRp0j1/xgXB3dGU1TmEh2RkxADOU0nkIMQ0mwcxH279FriZbNX4/umi1Jj+CFkYfBlW7+vGa8iYtUFN+gPmRuVfmCsLFU8JiZKZLexJDAlnMGEt3XUdlhU9gikKF/yIaS1KA3g7vQL8ifvHmZsvliaGltCkvZqQYKXLwH4IlOTFZpTb22sqh8sQGo/DcACG0NM4rKcvbJrfKIirYYxN7Xpu/hD/zqfp9/DzU3b/2Ht+cAmw7/xrFyiar6GYlLQC3V09YqZyhg2ql0P25FPOkB24rYW56KNvMzZsG2SQxnRM95q14DCary2KAXNola123j60C5cyUHj1LGoiE4Br+6UpTkvXHLK6PH0/g1trjmaYs1uUzkgHNIpGlym7BVwy1NDRiyN40X9Rl9UakjVavQ981rE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(83380400001)(38070700005)(8676002)(36756003)(76116006)(4326008)(5660300002)(66556008)(66446008)(66476007)(64756008)(66946007)(86362001)(122000001)(110136005)(8936002)(2906002)(316002)(54906003)(6512007)(6506007)(2616005)(6486002)(966005)(186003)(508600001)(26005)(71200400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG1OUUhqMnd1TmpuSUVSN3JKSVlnU2ZjZE1OS0c5Wm9ERUpWTm1JT25VN1ZY?=
 =?utf-8?B?NUdGc3d0RThSb0MxSXd0UzVkeGljenJPNXRRRWlSZ0pOdFlaenkzamtqWHRC?=
 =?utf-8?B?VXFsbmxlRzZQdVU0TFlmNy80ODZ1bWVWWUNMOVk3LzR3OFYza2QraGpUL2cz?=
 =?utf-8?B?QU9nRm9WMUJxVFRFYlNRQWRqTmVjQXBZVFVqa3ppdFd1MGVpVmJPdzUvR0tS?=
 =?utf-8?B?NEIwZlNnRW5lQ2xHeFh3aG5CWU92K0doMkpFRTlvVUFZMkRCUW1zRThDRTNu?=
 =?utf-8?B?a05TelJFcU8zVnl2L0dBTlAvYnp4aGx0UlNWNm0wNnNKYTVZdlNtNDRYVStG?=
 =?utf-8?B?NXlzRUFwVjY1UXpEYnBnYldvQ2VvUGttZlo3MmxCNVh1VHRQV1FNVVRJSFd5?=
 =?utf-8?B?NUZPd2phbkFEek1VaWp2Y1RkVkU4UzkrY040d2hrSm9uUFN0NmNwazczU0kz?=
 =?utf-8?B?eTdOTm1sQXdyRFplQkxScDFEdlg4SDNsbUNDWG5zNjRWQ0dUUXBnWEpkV0VE?=
 =?utf-8?B?aWRabyszbjJZVERRcEw0SllSVklLdFFCWVM1OFRGU2ZtOG1nOGVkdDh6RDlr?=
 =?utf-8?B?ZWU5cVFsa24xZGh5cm1GQUVNYkIxVVdMb2UwKzdwSkFiTWRiblNEWFA4Sjg0?=
 =?utf-8?B?RkJwWkp4dVlMbEJCWTQyRHlqUFFnckZWb3R5RExKcCszSzFvRVowVU5rTkxE?=
 =?utf-8?B?QmdiTndCcGIzbTJLT2Z2ZVNYOU5WYURNcU1kYklxWUFjcnREZEpMQURoOFNQ?=
 =?utf-8?B?OTM1c2dDdDlER25pUnFJUW5XNGdMSXpmcWNSLzF6Q3ovK0MvMjQ1aFdGMzF0?=
 =?utf-8?B?ZzFoRSs1Z1FsdFhUKzlRQ1llRHdnUGFlZHh4bk9WVFd3aTZBdnRScXRrWUxF?=
 =?utf-8?B?Z3dGaXVUZ21mdXIyUU00THpQdncxK1JTSS9tTWk4Yi9YWjR4d3N2ZTNqUVAw?=
 =?utf-8?B?VlNmVDdhaEVacXo1NnBhR0NURXc3VmoyYzFPeURQVFNvK2d2UExaa0dvMVVj?=
 =?utf-8?B?MlNXa0szWXJ2Y2JhV0RrbDBOUkRlRWwrOTBtOVJuWVFhVG41bVdHamY0cHpS?=
 =?utf-8?B?UTg3eUhWU0k1RmxnMXM5VUk1ekNWZElXMnZEZnZwTTZhb0psL0p3Rlp3RjU0?=
 =?utf-8?B?QUlHUi9NZTlHNWxQemVPekZJUEhkRTBOZHQ1QjF1cHJxNVl5VkdiYVhsVGI3?=
 =?utf-8?B?dXAxN3E4eVorTTJoU3FvMUJaNEsxaXFRKzlhNmhoYjFjZG5uZlV4QVpvNkpz?=
 =?utf-8?B?ZUNVaGZJVzBLY1doOWdLY29WcVUrUzNyQlBZWldqeDA4UmhISjZpN2RNTGhj?=
 =?utf-8?B?WmszSUh1TXlWMkVNV1YzQjFlMXl6V2RZSWRHY1JESS9SU1FDclFpcHlnU1A3?=
 =?utf-8?B?bUhFa09EZjkxd1BWS0VOc05TOUNmRE04VGwzdTlLZXlqRDNST0pESFRCVHVl?=
 =?utf-8?B?aE9qaDZTZ1ZrSC92cFZnOUc1b0dFMmwzWmRQTEdwT3VuSmxIWmxHKzFJUjRR?=
 =?utf-8?B?cTJrMFdvUkpxMVltcmZvaThhQ2tCNnJFVUFBaE9PMlloOUJsOXBQSHF3VUdh?=
 =?utf-8?B?d0FaNThGK2tkNW1YS3MwK0ZjSW5oL0p2dmMxMGdpeWsxdDZiMVAzRTkxa3NQ?=
 =?utf-8?B?SHRtVXdkUnRzOU9CTlhtM1FEMUowdUxtdHg4VmtLb3N0WE1wbGkvTmdabHdp?=
 =?utf-8?B?N29IWFhXV1dXQ3FCc3g0ejRmQU9LTCtrK1lobzhyemhkd0kwR2Jub3VWbU5x?=
 =?utf-8?B?M0lQcldnczVDTU94KzlqN2p0UjVxNFVFQkxucUFFWmRnSTBFSWNudENIN09P?=
 =?utf-8?B?MGZndzFnTWZSeFNiYXRBK1FIb3FLZEpYOGJ1MXlJK2VYY3RmTEZyRWlHUXZ4?=
 =?utf-8?B?SWdMSHhmVGZ3NVBTZlBLZ2pvUGJ2M2c2WXhkdG1OalQ0cFJaTXlQcnpVbnRm?=
 =?utf-8?B?akZmVVltL01UUEtJQzhIdTlqNWNkV3VhejVVL3ZjQWN0VWRCaDhCRzhNTWxB?=
 =?utf-8?B?RmxyK25BWFV1QVh3YmYreTZ2V3p2QVVNV05SckRsR2wvZCsxd3BmMEdPckoz?=
 =?utf-8?B?SWJwNnk3MzBqZFZUbHFUZEoyTzRlLy9IL0lpa09CcXhSaVlwai9vUGE1cGhW?=
 =?utf-8?B?YkZVcnhSK04xcnExenJhQXJ1UE13TXhVZHFMMm8yZTVzNW0yd25pN0dmbXF0?=
 =?utf-8?B?NEw0U0pvU1luMkRWS0lUMGJ1WXJtRXY0NWoyRXZjUi9IMmxsalVSdmdSZGxP?=
 =?utf-8?B?Z3lXRTdaaWg0Um90NzJvazBJVno0aGk2TFExdCsyNWtCdGdTM2ZBVjJuTW9O?=
 =?utf-8?B?Q1c5dzFhMnNySk1NWTB1K05iVGR4UUpXQ3pRTVQ3ZnJTSFpzTzNFVDBwZHZo?=
 =?utf-8?Q?CdEs1XWd6q+atczI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FD87C9E4CABEF469DF2F5503EE4E7C1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1f7d15-e237-4a42-d110-08da0de8c4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 22:51:00.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CX641DmfLdRzZwALuJ6yYNgcoP7THs7KJ6HCbbDz+diV+hcUwkJkLm3J6uPagctb7SYxm5CMtR27biWpqP3wNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTI0IGF0IDE4OjA4IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
VGhlcmUgaGF2ZSBiZWVuIHJlcG9ydHMgb2YgcmFjZXMgdGhhdCBjYXVzZSBORlN2NCBPUEVOKENS
RUFURSkgdG8NCj4gcmV0dXJuIGFuIGVycm9yIGV2ZW4gdGhvdWdoIHRoZSByZXF1ZXN0ZWQgZmls
ZSB3YXMgY3JlYXRlZC4gTkZTdjQNCj4gZG9lcyBub3Qgc2VlbSB0byBwcm92aWRlIGEgc3RhdHVz
IGNvZGUgZm9yIHRoaXMgY2FzZS4NCj4gDQo+IFRoZXJlIGFyZSBwbGVudHkgb2YgdGhpbmdzIHRo
YXQgY2FuIGdvIHdyb25nIGJldHdlZW4gdGhlDQo+IHZmc19jcmVhdGUoKSBjYWxsIGluIGRvX25m
c2RfY3JlYXRlKCkgYW5kIG5mczRfdmZzX2dldF9maWxlKCksIGJ1dA0KPiBvbmUgb2YgdGhlbSBp
cyBhbm90aGVyIGNsaWVudCBsb29raW5nIHVwIGFuZCBtb2RpZnlpbmcgdGhlIGZpbGUncw0KPiBt
b2RlIGJpdHMgaW4gdGhhdCB3aW5kb3cuIElmIHRoYXQgaGFwcGVucywgdGhlIGNyZWF0b3IgbWln
aHQgbG9zZQ0KPiBhY2Nlc3MgdG8gdGhlIGZpbGUgYmVmb3JlIGl0IGNhbiBiZSBvcGVuZWQuDQo+
IA0KPiBJbnN0ZWFkIG9mIG9wZW5pbmcgdGhlIG5ld2x5IGNyZWF0ZWQgZmlsZSBpbiBuZnNkNF9w
cm9jZXNzX29wZW4yKCksDQo+IG9wZW4gaXQgYXMgc29vbiBhcyB0aGUgZmlsZSBpcyBjcmVhdGVk
LCBhbmQgbGVhdmUgaXQgc2l0dGluZyBpbiB0aGUNCj4gZmlsZSBjYWNoZS4NCj4gDQo+IFRoaXMg
cGF0Y2ggaXMgbm90IG9wdGltYWwsIG9mIGNvdXJzZSAtIHdlIHNob3VsZCByZXBsYWNlIHRoZQ0K
PiB2ZnNfY3JlYXRlKCkgY2FsbCBpbiBkb19uZnNkX2NyZWF0ZSgpIHdpdGggYSBjYWxsIHRoYXQg
Y3JlYXRlcyB0aGUNCj4gZmlsZSBhbmQgcmV0dXJucyBhICJzdHJ1Y3QgZmlsZSAqIiB0aGF0IGNh
biBiZSBwbGFudGVkIGltbWVkaWF0ZWx5DQo+IGluIG5mLT5uZl9maWxlLg0KPiANCj4gQnV0IGZp
cnN0LCBJIHdvdWxkIGxpa2UgdG8gaGVhciBvcGluaW9ucyBhYm91dCB0aGUgYXBwcm9hY2gNCj4g
c3VnZ2VzdGVkIGFib3ZlLg0KPiANCj4gQnVnTGluazogaHR0cHM6Ly9idWd6aWxsYS5saW51eC1u
ZnMub3JnL3Nob3dfYnVnLmNnaT9pZD0zODINCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIg
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiDCoGZzL25mc2QvdmZzLmMgfMKgwqDC
oCA5ICsrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9mcy9uZnNkL3Zmcy5jIGIvZnMvbmZzZC92ZnMuYw0KPiBpbmRleCAwMmE1
NDQ2NDViNTIuLjgwYjU2OGZhMTJmMSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC92ZnMuYw0KPiAr
KysgYi9mcy9uZnNkL3Zmcy5jDQo+IEBAIC0xNDEwLDYgKzE0MTAsNyBAQCBkb19uZnNkX2NyZWF0
ZShzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4gc3ZjX2ZoICpmaHAsDQo+IMKgwqDC
oMKgwqDCoMKgwqBfX2JlMzLCoMKgwqDCoMKgwqDCoMKgwqDCoGVycjsNCj4gwqDCoMKgwqDCoMKg
wqDCoGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaG9zdF9lcnI7DQo+IMKgwqDCoMKgwqDC
oMKgwqBfX3UzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2X210aW1lPTAsIHZfYXRpbWU9MDsNCj4g
K8KgwqDCoMKgwqDCoMKgc3RydWN0IG5mc2RfZmlsZSAqbmY7DQo+IMKgDQo+IMKgwqDCoMKgwqDC
oMKgwqAvKiBYWFg6IFNob3VsZG4ndCB0aGlzIGJlIG5mc2Vycl9pbnZhbD8gKi8NCj4gwqDCoMKg
wqDCoMKgwqDCoGVyciA9IG5mc2Vycl9wZXJtOw0KPiBAQCAtMTUzNSw2ICsxNTM2LDE0IEBAIGRv
X25mc2RfY3JlYXRlKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdA0KPiBzdmNfZmggKmZo
cCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpYXAtPmlhX2F0aW1lLnR2X25z
ZWMgPSAwOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqAvKiBB
dHRlbXB0IHRvIGluc3RhbnRpYXRlIGEgZmlsZWNhY2hlIGVudHJ5IHdoaWxlIHdlIHN0aWxsDQo+
IGhvbGQNCj4gK8KgwqDCoMKgwqDCoMKgICogdGhlIHBhcmVudCdzIGlub2RlIG11dGV4LiAqLw0K
PiArwqDCoMKgwqDCoMKgwqBlcnIgPSBuZnNkX2ZpbGVfYWNxdWlyZShycXN0cCwgcmVzZmhwLCBO
RlNEX01BWV9XUklURSwgJm5mKTsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGVycikNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFRoaXMgd291bGQgYmUgYmFkICovDQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsNCj4gK8KgwqDCoMKgwqDCoMKgbmZz
ZF9maWxlX3B1dChuZik7DQoNCldoeSByZWx5IG9uIHRoZSBmaWxlIGNhY2hlIHRvIGNhcnJ5IHRo
ZSBuZnNkX2ZpbGU/IElzbid0IGl0IG11Y2ggZWFzaWVyDQpqdXN0IHRvIHBhc3MgaXQgYmFjayBk
aXJlY3RseSB0byB0aGUgY2FsbGVyPw0KDQpUaGVyZSBhcmUgb25seSAyIGNhbGxlcnMgb2YgZG9f
bmZzZF9jcmVhdGUoKSwgc28geW91J2QgaGF2ZQ0KbmZzZDNfcHJvY19jcmVhdGUoKSB0aGF0IHdp
bGwganVzdCBjYWxsIG5mc2RfZmlsZV9wdXQoKSBhcyBwZXIgYWJvdmUsDQp3aGVyZWFzIHRoZSBO
RlN2NCBzcGVjaWZpYyBkb19vcGVuX2xvb2t1cCgpIGNvdWxkIGp1c3Qgc3Rhc2ggaXQgaW4gdGhl
DQpzdHJ1Y3QgbmZzZDRfb3BlbiBzbyB0aGF0IGl0IGNhbiBnZXQgcGFzc2VkIGludG8gZG9fb3Bl
bl9wZXJtaXNzaW9uKCkNCmFuZCBldmVudHVhbGx5IG5mc2Q0X3Byb2Nlc3Nfb3BlbjIoKS4NCg0K
PiArDQo+IMKgIHNldF9hdHRyOg0KPiDCoMKgwqDCoMKgwqDCoMKgZXJyID0gbmZzZF9jcmVhdGVf
c2V0YXR0cihycXN0cCwgcmVzZmhwLCBpYXApOw0KPiDCoA0KPiANCj4gDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
