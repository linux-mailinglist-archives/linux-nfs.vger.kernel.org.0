Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE04F718A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 03:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiDGBdv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 21:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiDGBcI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 21:32:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2097.outbound.protection.outlook.com [40.107.95.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240B1DF649
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 18:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ1jyaSmDOZ8v4C/VzNBarTyq3REhV5uKpfmaGK7amabY/i7USfp8i0m+9FbhKC5yirjSd9F+Z/48vELgn6YygwEeqofRefFQfNr3g9bTNAdxIilM3oVZgPibKUIsO/APu+B11FyjJlsT5JHmOk/tXV6TYW9jm3TrQvODED8S4IpZX8VNVnmp76vCxFr5Qjp5PPdq1x1MLY+6ZJLZnxmI4fQL5W50+7TRbwGIfEpHuQ4isJH6kIvdbIcJXVLjszIZY84jwM3gnC5ysRR3/0lbQhaWI8e6GyP/w5WBy6N1wXivnwdNL5gAdJE2ug7MdoSG50YqR0cT5MClq8qebw9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIyOcjLpaePaDOmbWxFw9OFZeAAhPCKYNql9S+LFuQk=;
 b=oALjxnmDCa24g2tlfoi4Y9ZBmwnWnAPSy/8xUCyt+cLf01Y1aPm0JTVTh5Wf8ftU74UZDDKLxBKWoduTWK+pqNSguxA7AQc5d4N2C3G5W9arW7EcseVaE8junLWAdk5zJVOdBnOurM3azYjORmXt/l6KJXfbI07RNXCbvQSMk9WPxW+8KwPViFJbpfYsqSg4AiDnKl2MnPJ1t5a0C8S2z3C65KZMziTba1czrde/4LlYJFG12GKK5H2pJB5D4EKCris4mqXuZVXGN+BgPc0D9B2R9Jd/1BvO019VXAeZrKuP+ACypgiO2/v3Z0A0NgqL583L4xsXB7GcUobPM0WK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIyOcjLpaePaDOmbWxFw9OFZeAAhPCKYNql9S+LFuQk=;
 b=YLqumZOU9q3Q9Rcs/PCxa8Io4qpsomoNnEMNSzPlzlj5RCOJXVu0gnZof9tkW/WIPfJE6BTfslj6RQHzTDZQkpBFRcenhK3r8ri+e6NS5iQCdjvkNq+bMmtA2zRtZowXUTkxM5kpz8eTGctYhRduYX5vqZB/NJ76j2oVcmALb1s=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1589.namprd13.prod.outlook.com (2603:10b6:903:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.14; Thu, 7 Apr
 2022 01:28:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5144.019; Thu, 7 Apr 2022
 01:27:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Topic: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Index: AQHYSe+HymHLwioJ0U2H/VB83m8N4KzjV6+AgAAFtQCAAAYbgIAAN/wAgAAOEwA=
Date:   Thu, 7 Apr 2022 01:27:59 +0000
Message-ID: <7056cbfe6de0331b5938ef199676fbe6d261b9a3.camel@hammerspace.com>
References: <164926821551.12216.9112595778893638551.stgit@klimt.1015granger.net>
         <164926848846.12216.6872977249610829189.stgit@klimt.1015granger.net>
         <7976abc7a7ea7bbc445256884d0164a1b3ac5bb6.camel@hammerspace.com>
         <0942D638-0F40-4811-9820-AECAA65D529B@oracle.com>
         <c4bea3892c7d219138c3a9ee961bab40e3d1c246.camel@hammerspace.com>
         <CF55C9CB-539D-4A65-913E-E339A05CD6F0@oracle.com>
In-Reply-To: <CF55C9CB-539D-4A65-913E-E339A05CD6F0@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc1552fe-a1b1-474d-635e-08da1835da17
x-ms-traffictypediagnostic: CY4PR13MB1589:EE_
x-microsoft-antispam-prvs: <CY4PR13MB1589D02DB7F3AADF1A836F0FB8E69@CY4PR13MB1589.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zy/hKvCcgEOkpbJkMUU36XQE4wVUT9rB3Y2C20FTU1+nLQaqBIcWqnOlVHPldRVApqf4jDDM1lCHJ6ah31wY3SMpueny+ZK0RXjjPKVO53Az3MdAeIhILhWX2eJIbm/jTlChEKT+ooYV7zH8ml0KTiFqDhEbejm47P2OSmlKRZJU5XQv/TzntiQo6Xp+VdBqEUNVf6Kdna1St3jrVC6Jgiec+R5YCXWNLTgU0LnSfpPJB5yPwNRZoV2N1aKiKvZN76CbaMzt8Q8/Me0ZIuH3lH0/MYjcz6aOAhjMlBjRIuiY4pWkrYoDYi955RmiCVpGs3V4P7n4FnJN5+EJJ0JJZI3KUCzTJEpPhXvxs69D7IEmeRNEEsaoEIWYb1xDh4tBFEM/5MwV9pVKrfMzm6xlrJQJr+Di+ikLi+bvc6cfZSSSyYDeJ4zI72dvCpKKA/Ud2EjWpzAPwAWnPboRPU9jyop1a0Z8/8T9mUZoroD4NCYq4DEQdcWvAB+9u1qxHWX3Oj48gokmIoCrIi5W5FnrAg3tSzkBaL8Zhzcy7jm0ddtTPsH/qInqdZnhQI6oNjJh6JpDV/DzS287uilV0N+WT+iXIHzu0B5fjy1PLLxMjcgYYRKvBFABOW4JJ1WTH0rGeWc1bDkjaUsw8SPIP5mgSFH+HNDXSxb+57uX9Lu/tTaT6av6mPaHBG3K3fZUxzDSoSYQgeD+xhCqZ73u8jPsdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(66946007)(6486002)(6506007)(66556008)(66476007)(2906002)(66446008)(83380400001)(4326008)(76116006)(6512007)(8676002)(64756008)(8936002)(5660300002)(186003)(86362001)(26005)(53546011)(2616005)(71200400001)(6916009)(122000001)(38100700002)(36756003)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RSs3Tk9mR1pRVWRkQTN2NEw4T2VLR1I5VnEyQUhKSzRxTEJTSGh0RWpMSUVx?=
 =?utf-8?B?eVdQY3RINGtvY1V2R1VWaUJ0OFdOVzVnSElXcUxuc0Z5UlB1Vmw2VkRnMVVS?=
 =?utf-8?B?cTVERW9EbnBnU0g4S1lZSDZTQ2dnKy9nczRjaXJuZFNwaVI5cnRuTk9OSWRF?=
 =?utf-8?B?em40VWZoeDFlRWhqemoxM0JtOTByVEYyaFBlMkJjdTFSbUlNUzFHOHMvbkZw?=
 =?utf-8?B?Z2tTRGZzWW0vR0wvbmVTU0Jhb0tqOENlRnlYaGxwVUNlYTRZTjZ5QVRZaXVu?=
 =?utf-8?B?Ymt3YmdQN2RVVVJzM1p0QktwTDhpczVmRElhYjJCZGNCTElDRnB6VWYxVHR0?=
 =?utf-8?B?emtrV1JNU0xEeUNXODU5MDFXQ0dVQU8vVTFXaTdKcU5FNjVtYjhnbmZ1SUtv?=
 =?utf-8?B?Tm12MmR4ZEp1eXVxVEtPdWNFOXRJSnFJVTRCQnZZcEp0QnlVczI2dnhQbjFV?=
 =?utf-8?B?Rk5TVFZVRWJlWU5DVENZWWZhZ3N0eEEzNnQ4dStjL2xWamVDRERwRU5yWEJh?=
 =?utf-8?B?MTJObXM4T1h4Z1FyVEdVOW14TDVyNmJ5VnV5YUU0T2Q4aTF5cVBTeEgrNytK?=
 =?utf-8?B?QVB5YndXTS9vcUo4NVNhd1ozZWhjMGM5VThxNndsUFJ2QVNzQVlzZUJSY2ZT?=
 =?utf-8?B?OC9EdElpNDhpc0xzVWV3azd4ZzJKWEEvelY0cFFJb2N5TnN0UWFIQXp0T0VU?=
 =?utf-8?B?LzBoczhiM0EzUkRLei9Mb2EyOGI3TFh3TnhaYkF0cENlaEwwUWVNeE5helJQ?=
 =?utf-8?B?ZGNDNDZjL3JHL3lVTGNmMGhKK0I2THJNTEhaamxlS21jL09uSlkwR0NqSzBX?=
 =?utf-8?B?cWtGamRPZ1NNVndKeGhkQ2w5Z3VXYzhLbElXdk9LZzE2NDRINk1UUXJxRGwx?=
 =?utf-8?B?N1hYNDRESStBYlF1WWVFYjdjenl6Y3ppWHRoTGZLdnpyUzNEdW9mTkUyYzBV?=
 =?utf-8?B?Q1IxUzJCaHE2WjFSM0NpTzQrcE5BSkYzeWFDUXZyYjVkSGpSUDh1dDJxVWkx?=
 =?utf-8?B?QmFHT3VoWjAzYU1rTHhqNkRYejBwd0VwcHROeU8xQnUrZm9XL3loeHpoeTFr?=
 =?utf-8?B?M28wM1kvbmNaMzREdVY1WDZPajJKWWdxUW5GWmdDV0NHQmd0ZVlEMk40WU1N?=
 =?utf-8?B?N1dqODZTUTNaaXIwYVZuMWMwbTFKOWwvRE1iL1N0eXRTK3dSUVUxK2FXdGRk?=
 =?utf-8?B?WmZsTzJ2ZSt2UGd4dTFGU0w5Tms5djJMOEM3cXpZZnh1Nzd3WEZ4bExocS8w?=
 =?utf-8?B?ZHJVTHEyZ1djOC85ZEsxZE9ReUs5S1lBeit4SlI5ZnRQVVhRaFNwZmp2dlAx?=
 =?utf-8?B?VXJaaVJGZHcxZUNnSkc5emJPTlRTT3BLVFdnRFZOMWgyTGpyeFZxTVVxd0ht?=
 =?utf-8?B?aFN1Y21uZDBzTTcrR3RzM0FJU1ZSVk1FajhublphSkVLRFBDeWNQRGNMVmZ2?=
 =?utf-8?B?T2Frc1Y0a0Y2V2NWSmNZS3hidjdPU25uYlY3d2xvbUhLaDh4amlCOHhBdHJ1?=
 =?utf-8?B?SjVuL0o1dlRlNGN0RURCdzJ0b2JlR082cUkrdlg3TjhHbEMwdCtydkxHcWZ3?=
 =?utf-8?B?UnFBSk5tNVorYnhiUXNPdzVkU3QzanlsRnk2T3FWQ3RYL1c5ZE12alhUN3dZ?=
 =?utf-8?B?Ui9lZVpXQXA3VWlZdUVMRDlYZ1RGU3Npd00vaXlQYnp2Yk9QcENEQ3p1MnJN?=
 =?utf-8?B?aEtOcHhsQVZ0MkIvdjhmWkJWUHRnajZSV0V5eGd3TGZGMXNpQmZweDJtMkV3?=
 =?utf-8?B?YzZTSHoybTRLVTlyZDhhcVZHWTI0cEdDWE15YXJKRzltNlk3ZjR4WU5ueU1y?=
 =?utf-8?B?VUQrMHJRN2lCTEkvZGU5aVZlZzVGelVNUTBsc2VGRzhVK1ZnV05YdzRVN1Ni?=
 =?utf-8?B?eWJNNFppbGdJVlk4R0tVRjY0Z3IyRjdFRUpqcFJMZmhXK0ZibWY2T0duc1F6?=
 =?utf-8?B?VENZeTFqNk5yckg1U1RsdVdDdW94ZnRiSkRIaGJQeG1udVNTQXlzUjRXbzA0?=
 =?utf-8?B?T3daQnAveGpSQkx3ZWViVHdBaW9XR2hCVDJIVGIvRzUxRUx1MDBlbW56OWZR?=
 =?utf-8?B?MXhGeDBMOURrMWpld0pSUWxwS1Y1aDg2R0NRVzdjV3AyYm51TlYvQm1tZ0d4?=
 =?utf-8?B?alBMdTh3dGJIdFNZU3JoQXhTWDRXdmFyTHhOVWg0M0I0bWJEc2xZZ0xuS1lV?=
 =?utf-8?B?T3JZb1ZYQWF1bTBkMkdXK1hyVTcwNUpibG9NbURDZkhTZjcwQjg1WjBKUVdI?=
 =?utf-8?B?QWpneDc5M3laRWhuc2t5K2NWUVB1eEJXSlZwRnV1cC9aOURnZXpveTV5bG5j?=
 =?utf-8?B?bW43YWxvN3hBeEVNNkRVWk4rNEpQRVdOUXJsbENkYVRjRmx1UmkzMGJTOUtn?=
 =?utf-8?Q?oFLcX9iwURKifQiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB2F96185284004E866003BF484988C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1552fe-a1b1-474d-635e-08da1835da17
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 01:27:59.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xc5yjzswDhj7Yh69nOVBZsHpGtyxxuF5CxMPhV/AQiQKQE7x7awN3n6P0TLAQGMHI+s/C1kOgkFreTEdjEDy5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDAwOjM3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiA+IE9uIEFwciA2LCAyMDIyLCBhdCA1OjE3IFBNLCBUcm9uZCBNeWtsZWJ1c3QNCj4g
PiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IO+7v09uIFdlZCwg
MjAyMi0wNC0wNiBhdCAyMDo1NSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+ID4gT24gQXByIDYsIDIwMjIsIGF0IDQ6MzQgUE0sIFRyb25kIE15a2xl
YnVzdA0KPiA+ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiAN
Cj4gPiA+ID4gPiBPbiBXZWQsIDIwMjItMDQtMDYgYXQgMTQ6MDggLTA0MDAsIENodWNrIExldmVy
IHdyb3RlOg0KPiA+ID4gPiA+ID4gRml4IGEgTlVMTCBkZXJlZiBjcmFzaCB0aGF0IG9jY3VycyB3
aGVuIGFuIHN2Y19ycXN0IGlzDQo+ID4gPiA+ID4gPiBkZWZlcnJlZA0KPiA+ID4gPiA+ID4gd2hp
bGUgdGhlIHN1bnJwYyB0cmFjaW5nIHN1YnN5c3RlbSBpcyBlbmFibGVkLg0KPiA+ID4gPiA+ID4g
c3ZjX3JldmlzaXQoKSBzZXRzDQo+ID4gPiA+ID4gPiBkci0+eHBydCB0byBOVUxMLCBzbyBpdCBj
YW4ndCBiZSByZWxpZWQgdXBvbiBpbiB0aGUNCj4gPiA+ID4gPiA+IHRyYWNlcG9pbnQgdG8NCj4g
PiA+ID4gPiA+IHByb3ZpZGUgdGhlIHJlbW90ZSdzIGFkZHJlc3MuDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFNpbmNlIF9fc29ja2FkZHIoKSBhbmQgZnJpZW5kcyBhcmUgbm90IGF2YWlsYWJs
ZSBiZWZvcmUNCj4gPiA+ID4gPiA+IHY1LjE4LA0KPiA+ID4gPiA+ID4gdGhpcw0KPiA+ID4gPiA+
ID4gaXMganVzdCBhIHBhcnRpYWwgcmV2ZXJ0IG9mIGNvbW1pdCBlY2UyMDBkZGQ1NGIgKCJzdW5y
cGM6DQo+ID4gPiA+ID4gPiBTYXZlDQo+ID4gPiA+ID4gPiByZW1vdGUgcHJlc2VudGF0aW9uIGFk
ZHJlc3MgaW4gc3ZjX3hwcnQgZm9yIHRyYWNlIGV2ZW50cyIpDQo+ID4gPiA+ID4gPiBpbg0KPiA+
ID4gPiA+ID4gb3JkZXINCj4gPiA+ID4gPiA+IHRvIGVuYWJsZSBiYWNrcG9ydHMgb2YgdGhlIGZp
eC4gSXQgY2FuIGJlIGNsZWFuZWQgdXAgZHVyaW5nDQo+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4g
PiBmdXR1cmUgbWVyZ2Ugd2luZG93Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBGaXhlczog
ZWNlMjAwZGRkNTRiICgic3VucnBjOiBTYXZlIHJlbW90ZSBwcmVzZW50YXRpb24NCj4gPiA+ID4g
PiA+IGFkZHJlc3MgaW4NCj4gPiA+ID4gPiA+IHN2Y194cHJ0IGZvciB0cmFjZSBldmVudHMiKQ0K
PiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IMKgaW5jbHVkZS90cmFjZS9ldmVu
dHMvc3VucnBjLmggfMKgwqDCoCA5ICsrKysrLS0tLQ0KPiA+ID4gPiA+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvc3VucnBjLmgNCj4gPiA+
ID4gPiA+IGIvaW5jbHVkZS90cmFjZS9ldmVudHMvc3VucnBjLmgNCj4gPiA+ID4gPiA+IGluZGV4
IGFiOGFlMWY2YmE4NC4uNGFiYzJmZGRkM2I4IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvaW5j
bHVkZS90cmFjZS9ldmVudHMvc3VucnBjLmgNCj4gPiA+ID4gPiA+ICsrKyBiL2luY2x1ZGUvdHJh
Y2UvZXZlbnRzL3N1bnJwYy5oDQo+ID4gPiA+ID4gPiBAQCAtMjAxNywxOCArMjAxNywxOSBAQA0K
PiA+ID4gPiA+ID4gREVDTEFSRV9FVkVOVF9DTEFTUyhzdmNfZGVmZXJyZWRfZXZlbnQsDQo+ID4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBUUF9TVFJVQ1RfX2VudHJ5KA0KPiA+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZmllbGQoY29uc3Qgdm9pZCAqLCBkcikNCj4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKHUzMiwgeGlk
KQ0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19zdHJpbmcoYWRk
ciwgZHItPnhwcnQtPnhwdF9yZW1vdGVidWYpDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBfX2R5bmFtaWNfYXJyYXkodTgsIGFkZHIsIGRyLT5hZGRybGVuKQ0KPiA+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgKSwNCj4gPiA+ID4gPiA+IMKgDQo+ID4gPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoCBUUF9mYXN0X2Fzc2lnbigNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBfX2VudHJ5LT5kciA9IGRyOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZW50cnktPnhpZCA9IGJlMzJfdG9fY3B1KCooX19iZTMy
ICopKGRyLQ0KPiA+ID4gPiA+ID4gPmFyZ3MgKw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChkci0NCj4gPiA+ID4gPiA+ID4g
eHBydF9obGVuPj4yKSkpOw0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgX19hc3NpZ25fc3RyKGFkZHIsIGRyLT54cHJ0LQ0KPiA+ID4gPiA+ID4gPnhwdF9yZW1vdGVi
dWYpOw0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtY3B5KF9f
Z2V0X2R5bmFtaWNfYXJyYXkoYWRkciksICZkci0NCj4gPiA+ID4gPiA+ID5hZGRyLCBkci0NCj4g
PiA+ID4gPiA+ID4gYWRkcmxlbik7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCApLA0KPiA+
ID4gPiA+ID4gwqANCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqAgVFBfcHJpbnRrKCJhZGRyPSVz
IGRyPSVwIHhpZD0weCUwOHgiLA0KPiA+ID4gPiA+ID4gX19nZXRfc3RyKGFkZHIpLA0KPiA+ID4g
PiA+ID4gX19lbnRyeS0+ZHIsDQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBfX2VudHJ5LT54aWQpDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIFRQX3ByaW50aygi
YWRkcj0lcElTcGMgZHI9JXAgeGlkPTB4JTA4eCIsDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoc3RydWN0IHNvY2thZGRyDQo+ID4gPiA+ID4gPiAqKV9fZ2V0X2R5
bmFtaWNfYXJyYXkoYWRkciksDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBfX2VudHJ5LT5kciwgX19lbnRyeS0+eGlkKQ0KPiA+ID4gPiA+ID4gwqApOw0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBIYXZlIHlvdSB0ZXN0ZWQgdGhpcz8gSSBmb3VuZCBt
eXNlbGYgaGl0dGluZyB0aGUgd2FybmluZw0KPiA+ID4gPiANCj4gPiA+ID4gImV2ZW50ICVzIGhh
cyB1bnNhZmUgZGVyZWZlcmVuY2Ugb2YgYXJndW1lbnQgJWQiDQo+ID4gPiA+IA0KPiA+ID4gPiBp
biB0ZXN0X2V2ZW50X3ByaW50aygpIHdoZW4gSSB0cmllZCB0byB1c2Ugc29tZXRoaW5nIHNpbWls
YXINCj4gPiA+ID4gZm9yDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBORlMgY29kZS4NCj4gPiA+IA0K
PiA+ID4gVGhlIHdhcm5pbmcgaXMgZml4ZWQgYnkgYzZjZWQyMjk5N2FkICgidHJhY2luZzogVXBk
YXRlIHByaW50DQo+ID4gPiBmbXQgY2hlY2sgdG8gaGFuZGxlIG5ldyBfX2dldF9zb2NrYWRkcigp
IG1hY3JvIikuIEkgdGhpbmsNCj4gPiA+IHRoaXMgbWVhbnMgdGhhdCBhbG9uZyB3aXRoIHRoZSBh
Ym92ZSBwYXRjaCwgYzZjZWQyMjk5N2FkIHdpbGwNCj4gPiA+IG5lZWQgdG8gYmUgYmFja3BvcnRl
ZCB0byBzb21lIHJlY2VudCBzdGFibGUga2VybmVscy4NCj4gPiA+IA0KPiA+ID4gSWYgeW91J3Jl
IGFkZGluZyBkeW5hbWljYWxseS1zaXplZCBzb2NrYWRkciBmaWVsZHMgaW4gdHJhY2UNCj4gPiA+
IHJlY29yZHMsIEkgaW52aXRlIHlvdSB0byBjb25zaWRlciBfX3NvY2thZGRyL19fZ2V0X3NvY2th
ZGRyKCksDQo+ID4gPiBhZGRlZCBpbiB2NS4xOC4NCj4gPiA+IA0KPiA+IA0KPiA+IEludGVyZXN0
aW5nLi4uIEkgaGFkbid0IHNlZW4gdGhhdCBjaGFuZ2UuIEl0IGxvb2tzIGhvd2V2ZXIgYXMgaWYN
Cj4gPiB0aGF0DQo+ID4gaXMgZXhwbGljaXRseSBjaGVja2luZyBmb3IgdGhlIF9fZ2V0X3NvY2th
ZGRyKCkgc3RyaW5nLCBzbyB5b3UnZA0KPiA+IGhhdmUNCj4gPiB0byBjb252ZXJ0IHRoaXMgcGF0
Y2guDQo+IA0KPiBXZWxs4oCmIHYxIG9mIHRoaXMgcGF0Y2ggL2RpZC8gdXNlIF9fZ2V0X3NvY2th
ZGRyKCkuIEkgdGhvdWdodCBJIGNvdWxkDQo+IGNvbnN0cnVjdCBhIGJhY2stcG9ydGFibGUgdmVy
c2lvbiBvZiB0aGUgcGF0Y2ggdGhhdCB3b3VsZCBub3QgbmVlZA0KPiBfX2dldF9zb2NrYWRkcigp
IGJlY2F1c2UgaXTigJlzIG5vdCBhdmFpbGFibGUgaW4gLXN0YWJsZSBrZXJuZWxzLg0KPiANCj4g
SXQgc291bmRzIGxpa2UgdGhlIG9ubHkgY2hvaWNlIGZvciBmaXhpbmcgdGhpcyBpc3N1ZSBpbiAt
c3RhYmxlDQo+IGtlcm5lbHMgaXMgdG8gcmVtb3ZlIHRoZSBhZGRyIGZpZWxkIGZyb20gdGhlc2Ug
dHJhY2Vwb2ludHMgZW50aXJlbHk/DQoNCkluIHJldHJvc3BlY3QsIGFmdGVyIHRyeWluZyB0aGUg
YWJvdmUsIEkgZm91bmQgaXQgd2FzIGVhc2llc3QganVzdCB0bw0KZG8gdGhlIGNvbnZlcnNpb24g
dG8gYSBzdHJpbmcgcmVwcmVzZW50YXRpb24gdXAgZnJvbnQgaW4gdGhlDQpUUF9mYXN0X2Fzc2ln
bigpIGlmIG5lY2Vzc2FyeSwgYW5kIHRoZW4gc3RvcmUgdGhlIHJlc3VsdC4NCg0KSU9XOiBpbiBU
UF9mYXN0X2Fzc2lnbigpLCBhbGxvY2F0ZSBhIGNoYXJhY3RlciBidWZmZXIgb2Ygc2l6ZQ0KSU5F
VDZfQUREUlNUUkxFTiArIDEwIG9uIHRoZSBzdGFjayBhbmQgZG8gdGhlIHNucHJpbnRmKCIlcElT
cGMiLi4uLA0KdGhlbiBhcHBseSBfX2Fzc2lnbl9zdHIoKSB0byB0aGUgcmVzdWx0Lg0KDQpUaGF0
IGhhcyB0aGUgZXh0cmEgYWR2YW50YWdlIHRoYXQgaXQgZG9lc24ndCByZXF1aXJlIHlvdSB0byBy
ZXNlcnZlIGFuDQplbnRpcmUgc29ja2FkZHJfc3RvcmFnZSB3b3J0aCBvZiByaW5nIGJ1ZmZlciBz
cGFjZS4g8J+Zgg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
