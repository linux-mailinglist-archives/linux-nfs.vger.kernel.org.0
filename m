Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5D2C95AD
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 04:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgLADRb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 22:17:31 -0500
Received: from mail-eopbgr760119.outbound.protection.outlook.com ([40.107.76.119]:27045
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgLADRb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 22:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF4cgEglvKHHGjTMRNqGdRhid/CQlVi4tAZI1azjMSPf5ufJkUCoLINv0HMzhh5bCYTqPzjSEvyKtenyKEQS5AVyBeQiwAqiUj/crLCRmjiLm3UxXfya3UWGjY5UBHOFRfxdS2WgtwHu+Q1RA0zKluy9IMMZgOMe2Kh1FRil6SmqylJm2FbCiNf9Q0dI8pw/lTEdwAdSPch08TCMSfgVJULLxh2goFTb5uy7Y5/xkXGnjkWLJm2v72mftIF4HvIpD102ssL4NReOy/SVX69JGNIKm4vbylDsaxO1YtJJLiJtwO7LwuxxyS4coYvH6ob/nlwU/VyfKGm0eB3WQ4OmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9iY9G9iaCfkOWkNtCk7M7Qpe4ZG22IUsp4kUp7UjTE=;
 b=X+JSox19IfB5WUwkTzpgEeSZQcxMESGDdpKgw51kFyrp+mIiuNYW7jMjDFYNwl1wPqsPKBKBnFlBMx1xLLw2rpUQxSZHLde3dcSJtb1JEM4FfcIiDuWdCUzEDqo+HbXYkLC2GWJJvNfMFCV4Gz/cODSezqdKtNWggsySCB0BnWSKcBkQYwBXn0O6HsIu3+CJR9BZzPCaCqKjw/h2yNnybFKMr2DWzZDSl7NtgbgcleNSfQWfkdoHUV38bHw/FG0IqwVDYONZMHdUW6pt5NRXGGrVRetRXKpOSkDOpBWL5te8NsxwOfQEkvqH8ygzv45IKlo8Yqa0j/c3MCGer4vKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9iY9G9iaCfkOWkNtCk7M7Qpe4ZG22IUsp4kUp7UjTE=;
 b=VpUATwzk8Pk2GyrlYeAe852cmd5cP0Yohhm6C2tOOJguR/XlaOeLW4L8sMWrvVvJuPunbAUSjHH+mvDJB7a5Q+XyfotIQVY3G2OWUEwKQtZ1UxJn6oTAdf7neeW0cLOqc7K64lgL0cqoe/xbGP6qAQLxAIzJll9x3tKB/nm+Ia4=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2765.namprd13.prod.outlook.com (2603:10b6:208:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Tue, 1 Dec
 2020 03:16:42 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 03:16:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Topic: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Index: AQHWx1999UsH3Pym/kCB2OnbCNS3q6nhSfMAgAAdxACAABzfAIAACquAgAABUwCAAAFoAA==
Date:   Tue, 1 Dec 2020 03:16:41 +0000
Message-ID: <213a0908e8c9e743d6ae4d6f3b2679e2e879cce4.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <20201130212455.254469-2-trondmy@kernel.org>
         <20201130225842.GA22446@fieldses.org>
         <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
         <20201201022834.GA241188@pick.fieldses.org>
         <66f93208c6edf2dad70ee41c349c5130b30b8ed4.camel@hammerspace.com>
         <20201201031130.GD22446@fieldses.org>
In-Reply-To: <20201201031130.GD22446@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b299bd1-4295-4000-991c-08d895a78672
x-ms-traffictypediagnostic: MN2PR13MB2765:
x-microsoft-antispam-prvs: <MN2PR13MB276501F7E2B2BA3A83400859B8F40@MN2PR13MB2765.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfeG6lue68bdLRnBbcbOfWBGkBRRFUaAxjhcHGMQlAXGZ898D+Mj2o+d67G9PHaTAJVG+VxIT329FtuDl2KU7gOC53WC/IJNQ1u/YHiTb2NQZnm60Ird5gYPvJk3zJSvePpuXRyb3MWhISnNQ0TxIKzVDK81N/5RAPlShIuCwLlySdOGvlyy7PAr0uM4dTSVjKCMEwI7LYbiD6Sn8MiyYj0Y+sRSOns+ekZziAR3Dph5LcEbjPszbP0gpZBIVhJ/utWGN2BgdY0VqiXb3PuCLhLJS3hBmNMUNC+UTWInLobBB+bbnSf4wPLr1FQSQY6Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(346002)(366004)(376002)(136003)(4326008)(6512007)(71200400001)(64756008)(66556008)(66446008)(6506007)(4001150100001)(66476007)(316002)(26005)(2906002)(76116006)(66946007)(54906003)(2616005)(91956017)(6486002)(478600001)(4744005)(8676002)(36756003)(6916009)(86362001)(8936002)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UVg1OHdZUklJMmtSZkVSaUNROUlybXhzaWY3eU0wVGlRRnZsQ2FZUkFTRk5P?=
 =?utf-8?B?bVFYMzRNVTRjZEJGdEdFeUR2TU5aVHpua09tdHE1WWFkaGZJdHl3cXJNWHhU?=
 =?utf-8?B?MENaZEVMMEl2VWdFc1hObnFmVjByRVNlS3N0ZFliTW02cWFsRWRhYlJham9U?=
 =?utf-8?B?QjRFZmRYOTdpL2N5a0JrYWxmUTZoQWhYSkdrbkV5d28wYzcxblFvTlQrbDRU?=
 =?utf-8?B?djlRd2ovQUlheWxad3NmS2dJTGpQdjNEdVphdkZnc3FiMDBBRzYra2dqREE4?=
 =?utf-8?B?ZjNNSHZ3aURGdmdjNEsvY01Xdm1QU2NmMm5wWi9sWUgxaFFjRldIbGwzanFQ?=
 =?utf-8?B?dTdmeklFSnNscWJKK3hSb2x1dXJBWFNITTNWdEk3U2RmQkNnK2QrWFUxdXlZ?=
 =?utf-8?B?bjlQQmZGazdUcjU5cGRnWWVSek8xT2tzeFBSbGJ2bDhTSWg4THkxejJXSzg3?=
 =?utf-8?B?ZGR6Y05LbUdKejdWbWZzWUNTNjhhSnlRYU1JZS9ZVnZZQ2JXTW9QaFROVmli?=
 =?utf-8?B?Q0doMGNLWHlJWE9LOGVwREpZYURhTHpoaUdab3N4cDJjUFBPTnl1dzRxa3VZ?=
 =?utf-8?B?SE1wR2xMbzgzZTFmWmNSSkxjSExOMXlzQU4xK2dVenFGTmxXZ1p0NXFpVHdD?=
 =?utf-8?B?ai9GckhBbGRoL1JZT3d3am1BdHhmUE1BUFExcE1QcVdyeTdTMDFFU08rS25U?=
 =?utf-8?B?SUhZcDhBUzR3ODNNWEpVakVJenR4dnhhMFNSNi8wR0phYTYyZ29JQ09ZeGhP?=
 =?utf-8?B?aWU3NmFyclhsT1NibHJlSDQwZmozRTJEc1M2cWhCU3dZSVgwR1llWklqQ0pW?=
 =?utf-8?B?T0JXMUMybmE0RVFzL1lNSGJwU1Qrc0tncEhaanNmMTd3ZEhQWC80RmpsZitY?=
 =?utf-8?B?Qk1SU29sQ2pUZWZqVDdPQjZ1N1cxbTFnSzNYaURhZzhyckhxakdYN1ZqVmJF?=
 =?utf-8?B?d3pUbzZqbzZTamxReWQ5eEt0QWdmTWpjRzNxSlRLRG5GSkx5SVc3WFA2OXVZ?=
 =?utf-8?B?MEFaaXoxampnVitOcGxzQjhPU2lycytqUTA1a3Z2bHBhY041d1RjTWtxT0tx?=
 =?utf-8?B?dlRPOW5lVFkvUkxwRlRiVERyUGdodWhLaWF1TWlSWGpNTXZxNjZCNTZxbTNQ?=
 =?utf-8?B?NW5kbGFOYTZ3QXZMTXlXdlVId25DaElvamhUTFVNa2ZncnFKeGZocHlacUNI?=
 =?utf-8?B?UHIrMHJGVVRWRnFzSHlKY2NQbm94M1QrUG9IQVRleWNxS1UrN0orbGl4TWNH?=
 =?utf-8?B?Q1N3aE8vaGtiQWJmZ3AyblJiWkFuRmIwVG1jZmMxRndMTWNXNi9hYXlKdGFH?=
 =?utf-8?Q?LGkO3trXPkZNc08XLV56nlDjWO0OkcTgUn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE01165756FE7B408BE5B0D250CE160F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b299bd1-4295-4000-991c-08d895a78672
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:16:41.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iXNqlCILdNoph2Q11rp0HtAxvLOY4O0JbOqGzTC72WRe2ncLObv+qVQa5vlJZTDNHOFuWIT9GhZnVZ9fQ+ZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2765
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDIyOjExIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBEZWMgMDEsIDIwMjAgYXQgMDM6MDY6NDZBTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IEEgbG9jYWwgZmlsZXN5c3RlbSBtaWdodCBjaG9vc2UgdG8g
c2V0IHRoZSAnbm9uLWF0b21pYycgZmxhZw0KPiA+IHdpdGhvdXQNCj4gPiB3YW50aW5nIHRvIHR1
cm4gb2ZmIE5GU3YzIFdDQyBhdHRyaWJ1dGVzLiBZZXMsIHRoZSBsYXR0ZXIgYXJlDQo+ID4gYXNz
dW1lZA0KPiA+IHRvIGJlIGF0b21pYywgYnV0IGEgbnVtYmVyIG9mIGNvbW1lcmNpYWwgc2VydmVy
cyBkbyBhYnVzZSB0aGF0DQo+ID4gYXNzdW1wdGlvbiBpbiBwcmFjdGljZS4NCj4gDQo+IFdoYXQg
ZG8geW91IG1lYW4gYnkgYWJ1c2luZyB0aGF0IGFzc3VtcHRpb24/DQo+IA0KPiBJIHRob3VnaHQg
dGhhdCBsZWF2aW5nIG9mZiB0aGUgcG9zdC1vcCBhdHRycyB3YXMgdGhlIHYzIHByb3RvY29sJ3MN
Cj4gd2F5DQo+IG9mIHNheWluZyB0aGF0IGl0IGNvdWxkbid0IGdpdmUgeW91IGF0b21pYyB3Y2Mg
aW5mb3JtYXRpb24uDQo+IA0KDQpJIG1lYW4gdGhhdCBhIG51bWJlciBvZiBjb21tZXJjaWFsIHNl
cnZlcnMgd2lsbCBoYXBwaWx5IHJldHVybiBORlN2Mw0KcHJlL3Bvc3Qtb3BlcmF0aW9uIFdDQyBp
bmZvcm1hdGlvbiB0aGF0IGlzIG5vdCBhdG9taWMgd2l0aCB0aGUNCm9wZXJhdGlvbiB0aGF0IGlz
IHN1cHBvc2VkIHRvIGJlICdwcm90ZWN0ZWQnLiBUaGlzIGlzLCBhZnRlciBhbGwsIHdoeQ0KdGhl
IE5GU3Y0ICJzdHJ1Y3QgY2hhbmdlX2luZm80IiBhZGRlZCB0aGUgJ2F0b21pYycgZmllbGQgaW4g
dGhlIGZpcnN0DQpwbGFjZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
