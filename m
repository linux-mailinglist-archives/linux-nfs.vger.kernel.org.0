Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844FC535701
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 02:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiE0AV3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 20:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE0AV2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 20:21:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2136.outbound.protection.outlook.com [40.107.100.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B724A1AF02
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 17:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRtUKJ4oWgeSy8lowxNJ6iXyK/UepHJFID91Smcq3Ama101FNiNgDqdt9Chq/uSdHjPnwM5BhFrPoCX6j9dbYXzNdxmE4a612OJVMtKnfftu7u+Bkheaxzwxxjq49CmOjyPnB9OzPgyYGx+Mby4BG9fAYaLyU31Y0qijtQsobPF8uhhb0fNg0te2PePeCdz1WzPlO+k/KTzFYCV8yxmp+hOjN2uA5z1e+1xHuZ/70FlmiYTx2C/XHeGEOIzDTLxVoGogReAIBbcUCwuV/536EdkN8nXHYa7ThabMeQHaPTfKLeBRNktgXO6VWsUwpdUZbhmmvkPJlaMlmz1MByy3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8Rjpwyf+KkH4BhRkmOLgI2nX7joBr6KEadZarwtCzI=;
 b=dMUVGK3k6nqHFIl+68J2Gw2DFirbKyckCey6vHZtvfa7kAJLtwvr2id28XEI+Y5puEf0Vg2Z9+3gnHb2q0nJad6DMlMsD5GJpXbIdloDVqlPYTAPGxGLHaqzSO6KWIebyW/Deb+Oq+gdSuHkUbuRyhmNj9CVRcXgyQaywxI9Z9QAHbAAQHuHcPAYtku7z9IO7DR+0ADPBFW6f+FtPADp+U3YGH9JsGO3jaHH9ZqWZpQz3nyJJD0TznBmthb1TdI4QDE8//n6McYmEi68uxnre1LdpBtWAnNciPW1/jZ6sJHrND+a0PSw+3ReCBAhvV2FT5jXT45Z+uOkvnmc5PUmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8Rjpwyf+KkH4BhRkmOLgI2nX7joBr6KEadZarwtCzI=;
 b=nuosln0N+jg9uhT+rrgGMXChlrTjVyPEbfR9EVe0v4IFU1zsCmLaioztznckvmhGzHW21UU7HSLJpyQFcFXtLAfoL1jyZSInhUYwZFfyo7tuQL7NoS5ikqRB3EAXcGzfdv5poLYmXS9nNvAHOqcRtdWx5SaZ8U2ZrGTJIhgSZco=
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by SJ0PR14MB4630.namprd14.prod.outlook.com (2603:10b6:a03:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 00:21:23 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c494:46ce:8dcd:5b89]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c494:46ce:8dcd:5b89%6]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 00:21:23 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>, Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC 0/2] Fix "sleep while locked" in RELEASE_LOCKOWNER
Thread-Topic: [PATCH RFC 0/2] Fix "sleep while locked" in RELEASE_LOCKOWNER
Thread-Index: AQHYZYF71csVDTL9NUeqXs2DPpyw0q0xnP5sgABLkACAAAvTYQ==
Date:   Fri, 27 May 2022 00:21:23 +0000
Message-ID: <24401119-4BFD-4A27-BFE7-15FD92DA8FF6@rutgers.edu>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
 <PH0PR14MB549335582C7A4D4F4D2269B2AAD99@PH0PR14MB5493.namprd14.prod.outlook.com>
 <0387546F-0850-4BD3-B2DB-FCBEE1242610@oracle.com>
In-Reply-To: <0387546F-0850-4BD3-B2DB-FCBEE1242610@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8fb48c6-6972-4202-e927-08da3f76d4bd
x-ms-traffictypediagnostic: SJ0PR14MB4630:EE_
x-microsoft-antispam-prvs: <SJ0PR14MB463001E147D22978F1C1D555AAD89@SJ0PR14MB4630.namprd14.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wgv0FP9jIXNJB8dAvjBeiv2P/RX31cI8ssqRYMBIgEjkDNxaIu6y7xxo3ikyXHlaEqho8h+ZvOZX4DJdOlrvaSdMHQ3qBGFQnbERGNe/cYssovhp1QPn6YMSS7vRuqQfPEqJT8dwx8A1+WpKOMC9lqFydRxSmiCNO2ps6HqYbeSW+jtUI5+MPNXuNc1+BZK2dii91O12Wx9RGoCegGFglPUeht0SGmzi6ei90PVmlea/PYRirS0RxVcqDb4tlstEOeN7dnDZn1bx6CwnsRDRshk8dVwpbWkBCLUEN5+Psus0ZzHu2IVuMv79rs6gVPsSJcrAwt7b5OkXE/Jyy461K9l7YkVjb39bCmP/RA5UQ4rmVXgPDanxC/dYpAUti3BZAsQVJOq9hEzcdd67EllE5lKW3+Z7f26icDeqhs8fPapPDGHbM6YvUwFLQQdhjwJW/LTyL+jyIZgPo7XmDAxE27os73z9Xwudaw2JO8s/WaHN1lLX5RVcg9f1fHu4F9E384zxZJn+7A+qE4KEb3NljaRvI9wG3RLsd/FSqnODJhVSfeP7P/pC/unloZ+HHCN/WjU1/lLPJO6jkOPawgyF0c3TnFl/tv4o/24BljqsJ1m13Z1lzgHsK7AVi0iJ8NylC1jS/nXTmOAZmXrJ+nYXWO4ye8bEh3T+vRTuHAgnOy+vXhphc1NkPXH0d4v8dkaKlzSSqArTY8PclEydP8iru69WjJ+Q9gAk7k+imrTVggomjkUFm9J/TC3yo/B2/eHt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(71200400001)(8936002)(33656002)(76116006)(508600001)(5660300002)(26005)(6506007)(53546011)(6512007)(64756008)(86362001)(91956017)(66476007)(4326008)(8676002)(66446008)(66556008)(66946007)(2906002)(122000001)(38100700002)(38070700005)(2616005)(186003)(54906003)(6916009)(36756003)(83380400001)(786003)(316002)(75432002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXpQMWU1MVhPQVplT3BEVjhMZ1ZXTlFqdDN5RDhrc2pkbzYzSnFhVjlWNDVZ?=
 =?utf-8?B?Y09naENxcW5OaTN1M2I5amJkRDFTRjFoOWZKZDFiQzc5Y0VRRy80N3JnOTk0?=
 =?utf-8?B?TzlJR1dCeTBDcU9BNWxHZ1h1VDJ5aW1BdTk1bi9mN2Jyb0VDZDU4enZMT3ZT?=
 =?utf-8?B?bEpvb3lySXhOODJlZDhvVmNSUnM2Y0ZadTNZemlNQXN3SHV4WVc0ajhRSzds?=
 =?utf-8?B?R284d0VkU2FFdDEyb1NhOTk5RmtiSG1HRVpJb25zL0ZiVzU3dENrSEltdXFm?=
 =?utf-8?B?SGRnZ1BFRGtMYnd5U2c1L0F0Rk5UbWFTNmxyeTE0KytiU0diV1A1MGtqRDU2?=
 =?utf-8?B?WVQwaFhuVjJvOTlsbUFyWnBsTUlmMitMSWxaR0lnbyt1eDNZRjJJdzlBbHNO?=
 =?utf-8?B?UWRvOUFqRXpkVThYbHJPa0srMndvbTRzTzlobWY1TllSaklFNkovWDFrUW5V?=
 =?utf-8?B?cDNEbVlrdysxWVpGUnR3Q2F3QnZSaWxBb2hSRnNTUXIycEZPMUtTS1cwWVI2?=
 =?utf-8?B?SGlFNCs2cnZKMmdNd3BMSEFZQU12SjI2N0FsTFYxZnhZOXZFbkJUWHlTRU0r?=
 =?utf-8?B?TXV0SEFiTkoyYU9wVlpHVHZ5bmdtSzhZaEx4VnhsQ3lBREZUNSt1V1Niazg0?=
 =?utf-8?B?NUtmNWppV0gvQThNenhzTzRTdGdRODR2a3lHLzJFU0x4UFF5WXRWcDhVOTQr?=
 =?utf-8?B?MWZpTnJhVldtaUt2K2xFdjFzSUNTRGxqc0w3ZVZQZDJHUFYwT0cwc2ZMWUpM?=
 =?utf-8?B?WFZrRkVJY2ZSdGZoeDBnSnNiSmduUnR0QXN1QUZ4S0NkUC9zT2V0c2thR1lt?=
 =?utf-8?B?YmUrb3hsNXNwMU80QWREWTlBQjR5VWMxL0YxQytoVllheEdYTDFtWjJTMUN4?=
 =?utf-8?B?VjAzY1lPcHFQaTVlT05wMG9BSGFiYlFlRTNmcHZEV2RyeEpBNTJZWGh1WXJR?=
 =?utf-8?B?QlgxTXZrdVZTYlBtajFtUGFZYzB0VlFiRS9aYXh2cHl0QllocTJReFFvUEdL?=
 =?utf-8?B?RjB3UkE3elMwSXZGM0Q4eWNOQXdpakNweFp6aWxJdk5LMzF1OHJ1RzFzTk15?=
 =?utf-8?B?UU5PVGdpOFZydHB4YysxMkdGWDBFRWpKU1RZTG56Wm5WMXVxQlZUUGs1YlRz?=
 =?utf-8?B?MkRaeXBGN1NrcnkveWdFYmRUZGdZNUtFODh3YTNCeTkzdnBUTklJSWVIajdB?=
 =?utf-8?B?anlHUFJQTHNZSWFMbVRnOW1nSEMvTUFlRmVFdVJrVkpEbXBKRGpnVldzK3lC?=
 =?utf-8?B?L1gyN0RtRGZWNXdsTElVL1ZBaUZPTVByYzNLSDJBakhWR1d5ejVHQnN1L3Rn?=
 =?utf-8?B?ZzJMaGhJNlV6VWZzOVlTMmJ6S0sxRTFLWnhDV2laa2RLdEp5UjVpR1c1SFJr?=
 =?utf-8?B?THNEazVQSHUweTVjYzZLVmpaQUt3UmtiZ2t4aVlBVzFYRGRWSUhkMldHdTVy?=
 =?utf-8?B?NmJvNHNtQUczZmJ5RlkwNGpBc0lDV3krZDJ3LzVBNWtUZytldXl3N3Q2d1NX?=
 =?utf-8?B?aWJ4MUU5U2t3aGRpbUd5OUx0RS9kcDcrek4wMEFINzZjTG1CS24rRjhWSjg5?=
 =?utf-8?B?WmRnaFNYdFRIdjRhN3oyTXdGTGNIMUdOSnpyNXROb1lvYksrK3ZsdkJjNTNZ?=
 =?utf-8?B?RHNOOUZUMmIzenpRdmM2OXM4RlF2Y3VBZTNTUStFeTlKb2RaZ1VPZmdJUnhJ?=
 =?utf-8?B?QU5SQzZiOHZxSjY5RmNjck0xbU1KSnZjTWIwUHhDUithQ0k3SmtKckt5RlEw?=
 =?utf-8?B?MlNGMDhSMzVwSDFvTExZUHJxaWJ3YmlscHZWa1pnamlFUERoZWk2TE9xQXcw?=
 =?utf-8?B?eWRXekRxY3BxVHFwTnBoVGlIREUyNHBJbU1mencxd0lsNTU2WktYSEVrcVZ2?=
 =?utf-8?B?RTBZcjM2NVI4N28xZGFVYnVLK00rUzlGbU9nWEszOGZqcCt0aXZFK1JYRHds?=
 =?utf-8?B?Rlc5dEdEREowME1PWC9uVUhTY0JmOXhvWFlmTGlQV041aU55UWQ0WVpmbjNP?=
 =?utf-8?B?ZGZPMy92NjZWRzJnSW9pdjlCTW1FMUJuczVMYjRueGJ3dlRVMDllSk4xaVoz?=
 =?utf-8?B?K0xqMjNlbGJVcXNEaVdSSmYvOVlqb0NYdGRwSyswSUhtUEl0bjVaWUZxQVc1?=
 =?utf-8?B?OWY5dXdKdEtYNWVvRXhNZHJNcjF5TnpJbVpoRkhubnV3ZEZVbFhXVFMxalM1?=
 =?utf-8?B?bXdXSE12VHJ2V1YycDE1Nnk5WUhxYmYraldiTHZGcER1a2F0MGZ4dFFPK0cv?=
 =?utf-8?B?UnFaUnBBcm9XU1FvdUhwNGE2ejRkbWVySDlJMWdIYjhuMlJlYlFwWUtKd1VB?=
 =?utf-8?B?Q05MaXhmSS9iVi9uL1pneFBvQXBLcytleSttQ094WFpPMnFJaW1abm9Vc1Ur?=
 =?utf-8?Q?ZrXmgVrZIhFGUOSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fb48c6-6972-4202-e927-08da3f76d4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 00:21:23.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zM9PzYouAIu6sME0IkTAAuzLtZI7YCz0MKHpAjxYiWu/fdpchYLIa0KoJT51GGTBxlBBPOn8GfykJFzF9WJWcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4630
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SSB3YXMgaG9waW5nIGl0IHdhcyByZWFzb25hYmxlIHRvIGFzayBmb3IgYmFja3BvcnRpbmcgdG8g
dGhlIGxhdGVzdCBMVFMuIEl0IHdvdWxkIGJlIG5pY2UgaWYgeW91IGNvdWxkIG1ha2UgdGhlIHN0
YXRlbWVudCB5b3UgZGlkIGFib3V0IHRoYXQuIEF0IHRoYXQgcG9pbnQgSSBhZ3JlZSB0aGF0IGl0
4oCZcyBVYnVudHXigJlzIHByb2JsZW0uDQoNCj4gT24gTWF5IDI2LCAyMDIyLCBhdCA3OjM5IFBN
LCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4g
77u/DQo+IA0KPj4gT24gTWF5IDI2LCAyMDIyLCBhdCAzOjE3IFBNLCBDaGFybGVzIEhlZHJpY2sg
PGhlZHJpY2tAcnV0Z2Vycy5lZHU+IHdyb3RlOg0KPj4gDQo+PiBXZSBhcmUgc3RpbGwgc3R1Y2sg
b24gTkZTIDMgYmVjYXVzZSBORlMgNCBsb2NrIG9wZXJhdGlvbnMgaGFuZy4gVHlwaWNhbGx5IHdp
dGggdGh1bmRlcmJpcmQsIGZpcmVmb3gsIGV0Yy4gSSBoYWQgaG9wZWQgdGhhdCBVYnVudHUgMjIg
d291bGQgZml4IHRoaXMsIGdpdmVuIHRoZSBwYXRjaCANCj4+IA0KPj4gVU5SUEM6IERvbid0IGNh
bGwgY29ubmVjdCgpIG1vcmUgdGhhbiBvbmNlIG9uIGEgVENQIHNvY2tldA0KPj4gDQo+PiBJZiB0
aGlzIGlzIHBhcnQgb2YgdGhlIHByb2JsZW0sIHRoYXQgd291bGQgbWVhbiB3ZSBjb3VsZG4ndCB1
c2UgTkZTIDQgdW50aWwgVWJ1bnR1IDI0LCBpLmUuIHN1bW1lciBvZiAyMDI1LCBnaXZlbiBkZWxh
eXMgaW4gcmVsZWFzZSBhbmQgZGVwbG95bWVudC4NCj4+IA0KPj4gVW5mb3J0dW5hdGVseSBJIGNh
bid0IHJlcHJvZHVjZSBvdXIgcHJvYmxlbS4gSXQgZG9lc24ndCBzaG93IHVwIHVudGlsIHdlJ3Jl
IGhhbGZ3YXkgaW50byBvdXIgc2VtZXN0ZXIgYW5kIGxvYWRzIHN0YXJ0IGdldHRpbmcgaGVhdmll
ci4NCj4+IA0KPj4gWW91IHNheSB0aGlzIGlzIGEgbG9uZy1zdGFuZGluZyBpc3N1ZS4gU28gYXJl
IHByb2JsZW1zIHdpdGggTkZTIDQgbG9ja2luZyAoYW5kIGFsc28gTkZTIDQgZGVsZWdhdGlvbiku
IElmIHlvdSBoYXZlIGEgcGF0Y2ggZm9yIGJvdGggb2YgdGhlc2UgaXNzdWVzIHRoYXQgd2UgY291
bGQgcHV0IGludG8gNS40LjAsIEkgbWlnaHQgYmUgd2lsbGluZyB0byB0ZXN0IGl0LCBhc3N1bWlu
ZyB0aGUgcGF0Y2hlcyBhcmUgc2FmZS4gV2UgcHJvYmFibHkgd291bGRuJ3Qga25vdyBpdCBoYXMg
cmVhbGx5IGZpeGVkIHRoaW5ncyBmb3IgYXQgbGVhc3QgNiBtb250aHMuDQo+IA0KPiBDaGFybGVz
LCB0aGlzIG1haWxpbmcgbGlzdCBpcyBhbiB1cHN0cmVhbSBMaW51eCBmb3J1bS4gVGhlcmUgaG9u
ZXN0bHkgaXNuJ3QgYW55dGhpbmcgd2UgY2FuIGRvIGFib3V0IFVidW50dSBiYWNrcG9ydGluZyBw
b2xpY2llcywgYW5kIHdlIGNhbid0IGhlbHAgbXVjaCBhdCBhbGwgd2l0aCBMaW51eCBrZXJuZWxz
IGFzIG9sZCBhcyB2NS40IHVubGVzcyB0aGVyZSBhcmUga25vd24gZml4ZXMgaW4gbGF0ZXIga2Vy
bmVscy4gSXQncyB1cCB0byB5b3UgdG8gZmluZCB0aG9zZSBmaXhlcywgdGVzdCB0aGVtLCBhbmQg
dGhlbiBjb252aW5jZSB0aGUgc3RhYmxlIGtlcm5lbCBmb2xrcyBhbmQgeW91ciBkaXN0cmlidXRp
b24gdG8gaW5jbHVkZSB0aGUgZml4IGluIHRoZWlyIGtlcm5lbC4gVGhlIGZvbGtzIG9uIGxpbnV4
LW5mc0AgYXJlIGxpdHRsZSBtb3JlIHRoYW4gcHJvY2VzcyBvYnNlcnZlcnMgaW4gdGhvc2UgY29t
bXVuaXRpZXMuDQo+IA0KPiBUaGUgUkVMRUFTRV9MT0NLT1dORVIgbG9jayBpbnZlcnNpb24gaXNz
dWUgaGFzIGJlZW4gYXJvdW5kIGZvcmV2ZXIsIGJ1dCBpdCB3YXMgZXhwb3NlZCByZWNlbnRseSBi
eSBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gZml4IGluIHY1LjE4LXJjMy4gQWZ0ZXIgdGhhdCBw
b2ludCwgYSBjbGllbnQgY2FuIGxldmVyYWdlIHRoZSBleGlzdGluZyBsb2NrIGludmVyc2lvbiBi
dWcgdG8gcHJvdm9rZSBhIGRlYWRsb2NrIG9uIHRoZSBzZXJ2ZXIgdXNpbmcgbm9ybWFsIE5GU3Y0
IG9wZXJhdGlvbnMuIFRoYXQgbWFrZXMgdGhlIFJFTEVBU0VfTE9DS09XTkVSIGlzc3VlIGEgcG90
ZW50aWFsIGRlbmlhbC1vZi1zZXJ2aWNlIGluIHRoZSBsYXRlc3Qga2VybmVscywgd2hpY2ggaXMg
cHJpb3JpdHkgb25lIGluIG15IGJvb2suDQo+IA0KPiBJIHN0YW5kIGJ5IG15IHN0YXRlbWVudCB0
byBMaW51cyBpbiB0aGlzIG1vcm5pbmcncyBwdWxsIHJlcXVlc3Q6IEkgY3VycmVudGx5IGtub3cg
b2Ygbm8gb3RoZXIgaGlnaCBwcmlvcml0eSBidWdzIGluIHY1LjE4J3MgTkZTIHNlcnZlciAoSSdt
IG5vdCB0YWxraW5nIGFib3V0IHRoZSBORlMgY2xpZW50KSB1bmRlciBhY3RpdmUgaW52ZXN0aWdh
dGlvbiBleGNlcHQgZm9yIHRoZSBvbmUgSSBtZW50aW9uZWQgaW4gdGhlIFBSLiBJZiB5b3Uga25v
dyBvZiAvc3BlY2lmaWMvIHJlcG9ydHMgb2Ygc2lnbmlmaWNhbnQgaW5jb3JyZWN0IGJlaGF2aW9y
IGluIHRoZSBsYXRlc3QgdXBzdHJlYW0gTGludXggTkZTIGNsaWVudCBvciBzZXJ2ZXIsIHBsZWFz
ZSBwb3N0IGxpbmtzIHRvIHRoZW0gaGVyZSwgb3IgYmV0dGVyIHlldCwgZmlsZSBidWdzIGFuZCBo
ZWxwIHRoZSBhc3NpZ25lZXMgdG8gdHJvdWJsZXNob290IHRoZSBwcm9ibGVtcy4NCj4gDQo+IA0K
PiAtLQ0KPiBDaHVjayBMZXZlcg0KPiANCj4gDQo+IA0K
