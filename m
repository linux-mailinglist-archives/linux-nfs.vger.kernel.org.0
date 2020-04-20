Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436961B0907
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDTMOM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 08:14:12 -0400
Received: from mail-eopbgr750123.outbound.protection.outlook.com ([40.107.75.123]:24136
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgDTMOL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 08:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjpFacCGz3YbeOcspvs2LIgOgrfTqE86gR8JsMJE58FhBYI+LRg4KcS3QUm/EfS5ZTFV/+F698aLcCjqzfHk1zYAIRWpDTnlL4jdickImWqIEPJsg+N6YHJQUvczWqtJl4krsOzqeEKXBePq8FjgLKmhdMqTUm5NfhxN8H7Z2F35xPYmOMRnNBd+7tIdP5NO0DkhKs868TvC3IXJJU8tLr3elK2rOjhmcMSrkxFM2QmDIvCBHro/YqHpxE6uMZz+Dt3HKH7r932HhzuhHJMtfPoo3dw19NDI2kyvbC5Jtnf3YqZWHf1fUs64RhegeN670DHYRwdTnaQXXF+EaDQK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCCUzwmN6NI/c9+DTdhRSnktdV6f4Y7Z/ucs6ljFdyc=;
 b=TKGy/ycECkJwuvRrh9qzGzXQnISMYxwFpOt4g0g4iM+BFoa60YLZTa36d2p21ctjRTkuvhflAiIXoSorxxSPIhj3fNZQZsSv3tBn7tUcMKtvWg9rnCCADY7iebEBP64BtJ22vZyzTFgyxqKpftnILMZwIfbAlYJIHLLiu/tciRf/qaMFguJtoR/o3I4yVrv2I9IwMGcWpZgYLacN95dPLetthvjIPo7hBII/+Tvvo1wSons47g7h9usjXmt91OF0/CoLdq8OKE9l1XkyeafUdi0wYD0cz7sI5Ygp746IGU0Y2zvJqegRftHqXhzvVlHcFEXGs35yJSH/22D4NgVYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCCUzwmN6NI/c9+DTdhRSnktdV6f4Y7Z/ucs6ljFdyc=;
 b=QXfrr80vuvR5UtsqdbnIt1OLRSETFzjS4HO7VtFYz3WC2SCMD6jj9zMhtBJVS+Hd5k2SfcK9Jb+0rsWMAd3mGaBnHZIc4Bwgmj4cNOpJaQvsxksg5JWMFNqQGdIVoMaAPY9PjHYbENUO/C9+NkOXVfVf3A4Wy2sxLjbu5JtO8cA=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3719.namprd13.prod.outlook.com (2603:10b6:610:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.9; Mon, 20 Apr
 2020 12:14:07 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 12:14:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "akpm@osdl.org" <akpm@osdl.org>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "agruen@suse.de" <agruen@suse.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "okir@suse.de" <okir@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>
Subject: Re: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Topic: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Index: AQHWFta2cwgyqFk5TU+ydXFUjCaulaiB7LGA
Date:   Mon, 20 Apr 2020 12:14:07 +0000
Message-ID: <7b95f2ac1e65635dcb160ca20e798d95b7503e49.camel@hammerspace.com>
References: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5100ae6b-01dc-4ee3-a7f9-08d7e5245345
x-ms-traffictypediagnostic: CH2PR13MB3719:
x-microsoft-antispam-prvs: <CH2PR13MB3719DB82BA4DE0D55F92FE4AB8D40@CH2PR13MB3719.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(396003)(39830400003)(346002)(7416002)(91956017)(76116006)(71200400001)(8936002)(81156014)(8676002)(2906002)(4326008)(6512007)(6486002)(54906003)(86362001)(36756003)(6506007)(2616005)(26005)(186003)(316002)(110136005)(5660300002)(66556008)(66446008)(478600001)(64756008)(66476007)(66946007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Q4BW+7fc/+782fG0oKpT9wSJUVS6InytXY36G+YutXvBE8AngXKOQdhO/1rvwV5N934lq8McQmsI4Uv3QhLtDrc8JRau6xbAlRF69oo8ornskCdTUn6JlqgIoGemL93INOJBb0W6a8vNkj4MLECT1ouoQO9K5w411IXk7yu/7z3AOaJ09H1Ex5Z+jdO1YyKUYwPCabg8R8trWTE87UTMzsYdKcWD5zEuakmy3f2dEx7lukYB7Yxi4apLqg8gioAzzV0YZdmFvpknZnAgiec+BzlzFHPjCMpGeNwRgkN+dBdn+CWqIsUWyKzAoj9NKmauauszFa/F669iwV+2XkSCR/sJz/LJT2RNfkzDUjWgImwT3FrYo3GO7YtkEGzhuGqqTiD8gQTF/3avA+xouREMF43ctoHPwQ4FwrwjuO9IvM0vlyWb369Q9Mj1iTsvnU/
x-ms-exchange-antispam-messagedata: i6iiXyFmPkI2ePl6brq3skSkJmXv1EkKE4kjlak+ihhPawC7i1Q/n8234Y93TYL4GrkjToHWesXkFoxnMEP3Hglx5og/m2ZmUtryf3iU49wB+XxXu0NQZncsXc0INnWf9fLaEQspmbHTesadiRvUMTJjKLSpovJ929h5ZEP1tvoO8yqmncrKdfS0dbKhPcBlEshtmlRf5zOnq4CRR/N0ffdpCiNlhlyWzLDs91k3ux2Mm2VsBGSj8XaGXYzO9scEO7qm8Xp5c1g9loPFfvaQM/t4WNOIaE5ggN68zaFp84W2CRtUOPiXQsoHtS/Yxr+ihPlVMeRgT54+E2p3GoQFeFwXGX0eXiUDGQMZ5lz+JpFnZn6ZsvvcY8ozBEkVV7BNN5tOSgDztUs9qi65boZ7iXzHZdzVXS0cN/kmFLIzfrlPT8mqDaBiMWURuJrcRVjf20BWBp9w5hR0ctInSCCK8UTYCMxxBa0bzT79QwJItUoYYMlq16XgFQlS+jsnYrGDxVvZs3aG6hF5SRGtK473LaTEiBm+T1ZCkXKZlFLUVlLgZCbMXPaM6mUODThQ6WrFimz41FzZ6aGW/MTti19cyxjUYdbQALS5qakGlvC9+0T5K6a4PTDHd8SjG6Oi9WLJoDxCr8iBVvSUxichCLDnx6dKaJsrnIAbKB0g1RSifPW76b5pkhhBix/zf1ftNqqVr/iv6rphVI8/6qqZ2DYw3RRIoGOVQO+9bodOt7D9We20QvoiVLwxh+rTULctBeQxDjsU+5Ky8ti4wlISe/BOOWHXzXDDUbyLe7OLnoWVMxM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7454D5109B41B34DBA461750FF41DD3B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5100ae6b-01dc-4ee3-a7f9-08d7e5245345
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 12:14:07.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mS2guQaAOri7+uswsN4AexZOmHQ8GJuKvaVJxFyj+YJnV1sxTQV2aYJAfpZEbLJGO9eH0vioyH+Tkc25BHvQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3719
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDEzOjQzICswODAwLCBYaXl1IFlhbmcgd3JvdGU6DQo+IG5m
czNfc2V0X2FjbCgpIGludm9rZXMgZ2V0X2FjbCgpLCB3aGljaCByZXR1cm5zIGEgbG9jYWwgcmVm
ZXJlbmNlIG9mDQo+IHRoZQ0KPiBwb3NpeF9hY2wgb2JqZWN0IHRvICJhbGxvYyIgd2l0aCBpbmNy
ZWFzZWQgcmVmY291bnQuDQo+IA0KPiBXaGVuIG5mczNfc2V0X2FjbCgpIHJldHVybnMgb3IgYSBu
ZXcgb2JqZWN0IGlzIGFzc2lnbmVkIHRvDQo+ICJhbGxvYyIsICB0aGUNCj4gb3JpZ2luYWwgbG9j
YWwgcmVmZXJlbmNlIG9mICAiYWxsb2MiIGJlY29tZXMgaW52YWxpZCwgc28gdGhlIHJlZmNvdW50
DQo+IHNob3VsZCBiZSBkZWNyZWFzZWQgdG8ga2VlcCByZWZjb3VudCBiYWxhbmNlZC4NCj4gDQo+
IFRoZSByZWZlcmVuY2UgY291bnRpbmcgaXNzdWUgaGFwcGVucyBpbiBvbmUgcGF0aCBvZiBuZnMz
X3NldF9hY2woKS4NCj4gV2hlbg0KPiAiYWNsIiBlcXVhbHMgdG8gTlVMTCBidXQgImFsbG9jIiBp
cyBub3QgTlVMTCwgdGhlIGZ1bmN0aW9uIGZvcmdldHMgdG8NCj4gZGVjcmVhc2UgdGhlIHJlZmNu
dCBpbmNyZWFzZWQgYnkgZ2V0X2FjbCgpIGFuZCBjYXVzZXMgYSByZWZjbnQgbGVhay4NCj4gDQo+
IEZpeCB0aGlzIGlzc3VlIGJ5IGNhbGxpbmcgcG9zaXhfYWNsX3JlbGVhc2UoKSBvbiB0aGlzIHBh
dGggd2hlbg0KPiAiYWxsb2MiDQo+IGlzIG5vdCBOVUxMLg0KPiANCj4gRml4ZXM6IGI3ZmEwNTU0
Y2YxYiAoIltQQVRDSF0gTkZTOiBBZGQgc3VwcG9ydCBmb3IgTkZTdjMgQUNMcyIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFhpeXUgWWFuZyA8eGl5dXlhbmcxOUBmdWRhbi5lZHUuY24+DQo+IFNpZ25lZC1v
ZmYtYnk6IFhpbiBUYW4gPHRhbnhpbi5jdGZAZ21haWwuY29tPg0KPiAtLS0NCj4gIGZzL25mcy9u
ZnMzYWNsLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczNhY2wuYyBiL2ZzL25mcy9uZnMzYWNsLmMNCj4gaW5k
ZXggYzVjM2ZjNmU2YzYwLi5iNWM0MWJjY2E4Y2YgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnMz
YWNsLmMNCj4gKysrIGIvZnMvbmZzL25mczNhY2wuYw0KPiBAQCAtMjc0LDYgKzI3NCw4IEBAIGlu
dCBuZnMzX3NldF9hY2woc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0DQo+IHBvc2l4X2FjbCAq
YWNsLCBpbnQgdHlwZSkNCj4gIAl9DQo+ICANCj4gIAlpZiAoYWNsID09IE5VTEwpIHsNCj4gKwkJ
aWYgKGFsbG9jKQ0KPiArCQkJcG9zaXhfYWNsX3JlbGVhc2UoYWxsb2MpOw0KDQpUaGlzIHdpbGwg
cmVzdWx0IGluICdkZmFjbCcgYmVpbmcgZnJlZWQgd2hpbGUgaXQgaXMgc3RpbGwgaW4gdXNlLCBz
bw0KY2FuJ3QgYmUgY29ycmVjdCBlaXRoZXIuDQoNCj4gIAkJYWxsb2MgPSBhY2wgPSBwb3NpeF9h
Y2xfZnJvbV9tb2RlKGlub2RlLT5pX21vZGUsDQo+IEdGUF9LRVJORUwpOw0KPiAgCQlpZiAoSVNf
RVJSKGFsbG9jKSkNCj4gIAkJCWdvdG8gZmFpbDsNCg0KSSBkb24ndCByZWFsbHkgc2VlIGFueSBh
bHRlcm5hdGl2ZSB0byBhZGRpbmcgYSAnZGZhbGxvYycgdG8gdHJhY2sgdGhlDQphbGxvY2F0ZWQg
ZGZhY2wgc2VwYXJhdGVseS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
