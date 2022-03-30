Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A484EC7B2
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbiC3PFY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 11:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347764AbiC3PFX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 11:05:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2101.outbound.protection.outlook.com [40.107.220.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440196437
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 08:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6wWXkYeApQr4w3TMvoli+hMU0lkZCx6JXBLfitifXXGy7IyH5WxTqM7Q4NNVbOFf6n8T7pfEW7YkECzkGsow/gl82b2nO/czFjNICyGtIsm67y+j/jwZ/4dYtb/dGoGbo71w2g1oK9Li8/0jxjKLBLjhgUgPdrZnniFWDn5W1fqrhR3+DYJsPDROnCdTe+45s1hLUUtITPsnG7N8dcg8wJ97chBOn06Kx+Q466NlXlT4foViL5V+4fNAjK98QcKT5N4F8IZLEMxCfmn4WSJ2VSMDiqApAbSAFzeGSll0HfnaJol083kTjBETCbzqwQrJltqlmbAOkM1/n7gwyvZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wuArLWXH3ddZL47sJN6zWlkqVJxiAjTxlkaU1SHnm4=;
 b=YJf48TrgwdMQthPfK+3kgG+9+DVjnw6HJbPreZ66dhbGmYFLyKQEjyNDnAQS9ENOjAxOvJ83qEs7RNPp9w9RFb0+IQX1c9tmtJHWT7WxZAnBqQmp/G5OKtIDRP+oN91KQmbzTAQH1r0boJBDXm2Yx83i/2SbUa8Aw3uVIdY4XTkwfDiPGSIo/yVDyo7oFO4kTTn6lV3mtAOjU2OumiKOJUxewkxAMa05JCeSNGms8fk+x8G0STrhT7qa2wMBsTRl6ntMu9j5hTMRPo/pAQNhq9F3G9L7HBdLmBn+J+pXnTtvbX3HUs/XDepPQfOp6yNU8NtHn15ojSKN5tIO3ETGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wuArLWXH3ddZL47sJN6zWlkqVJxiAjTxlkaU1SHnm4=;
 b=YYfK/WeAtUAWEZFz1P4djrF9ysD9TxyDIQcKVE9v0r304mWsxl+F48AAAYqdO2SQyvGopkKyTT0NNpPSo2BYbhYYzSEhHWEMr0aiTSC3rfELuQFo6RfP6xuLf+X1q4rtq5Q5eWirXFYyM2h3yV91yAt9UDSbPhmTHF6ZPb174Ug=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5939.namprd13.prod.outlook.com (2603:10b6:303:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.10; Wed, 30 Mar
 2022 15:03:30 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.021; Wed, 30 Mar 2022
 15:03:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jack@suse.cz" <jack@suse.cz>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Performance regression with random IO pattern from the client
Thread-Topic: Performance regression with random IO pattern from the client
Thread-Index: AQHYRCHURuyBsHzGwUylCk6TFFITcqzYBlsA
Date:   Wed, 30 Mar 2022 15:03:30 +0000
Message-ID: <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
In-Reply-To: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4508f125-77e7-4dba-5f18-08da125e739c
x-ms-traffictypediagnostic: MW4PR13MB5939:EE_
x-microsoft-antispam-prvs: <MW4PR13MB5939AAEC9463D8917B5217D9B81F9@MW4PR13MB5939.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNs5zUwEqidKhFnl90NKmfCzq6HiNQ8/M+6rLW7o27uMYx/maGPBo6RSmTRx704n0dJDwTzmH1nmiFcg5bB9PZFrR/2Az2kV+r5TdauAJELIQp0E4/csrokscj79JetIIOxSNv3erTJ/QaEF+89NVcDVRhrq89sWhF1YuFEXUkavpUo2t4XkbaVVkOzK2jZ27n82fLwV5MuSnRE+hj/ZfaWkF/JB2NHb6+s1Nq7acqFlgpNA9Klu0oxAu+PGKNzD+pk2ra0s4ZmHqBEEYEDSpyiYol4l4B5LThtJeWjt3rvoS5qfXyl7V3V8YX1bpVBTpCW0J6/hq0fBzTkGGQnZSN4pVw6OcII1XKnRWT7tPA5f3+A7NAqJ4pIuNUqzdncUMdqPW4ez8rXe7rDfchlatWS4KNcBH9kq0gEKbd80LWzqDzHP0xYwfSahpFoutEABHzEMymumFRemlbqjpw9e8GI4OiNK1CFlaOefTuXo9Lv2kPL968Fr0s3sDTlFgvOBKGbppLpsf+KZiofSUgy478aVEUXwZmqU48XCgJhQIp2kCHAnMzY1AknyqlFHFjgOMN2umyb/PHS0+uJ630zclXUNMP7XT8JgZH69tpbct57wHwTtlV3/XFKEFQpufP0ddp3BjUOgXNwOuvxx8UiznxohblHZM6JIGq8vO7LgWnWnjStp34MgPZwE3W2P0vojcYT6icA+QnNSm/Cdn2yRhKnwmywE4myMSw84YhT7zEuuL97V7xAfb0+pxrEr7k1u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(54906003)(186003)(19627235002)(36756003)(38070700005)(5660300002)(122000001)(71200400001)(316002)(86362001)(6486002)(26005)(508600001)(76116006)(4326008)(8676002)(66446008)(66946007)(66476007)(66556008)(64756008)(8936002)(83380400001)(2616005)(2906002)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmhSL3pSSjlybjI2RW5aVHIrbEUvdVd0RklkSE1RRzQzRnF1ZVdESy81QTlm?=
 =?utf-8?B?WWZsTjdKVDVScDd3dHpkVUxqdVJ6WFRiZmtZRDlqUEJtNHcyZUp0Qm9vamli?=
 =?utf-8?B?OWxtbE9Za2puQ2hVdXNrMkRrNFNFdGxuR1BFZTdXeFR4ekZiVzRwS3NkK2Na?=
 =?utf-8?B?YjdEKzl5dFFtRkd4VGlEbDdiT2dXd1NpdXc3T2lvTGp3R3ZYWTdGZlBjUElP?=
 =?utf-8?B?M1RpV3pjdFpLd094eVl5RnVLWmFsUG5VdjRiWFRmbFBGLzVXUFJlcTJxZVBy?=
 =?utf-8?B?dXZ6aWZDME5CUGdmaUhJaVlSYTR3c1pKOTdabWw0b1NmRm0xc3JjRWsyK0ps?=
 =?utf-8?B?aUMzMWF6T0JTbFBycE9KMjhRMDg5dXFuZ2Nja3hRUmRJUVVCdzZtM09NS29S?=
 =?utf-8?B?V0ZFSTdwSThuRnJOZ3VIUlRRWmVSZGZjRUxDL1FQbnFhMysxODArV3pmS1ZD?=
 =?utf-8?B?N2tkd1hKL3FMUkFuZ0xFUnRDYmNiNGNyZ3lONG1uNnBYc0toNUlaVUt2KzBp?=
 =?utf-8?B?bXB2ZTU4aFpvZGlsc3ErQWdqa2k5NnhnZjF0bnBYaTF2YTY0b3F0L1FxYThM?=
 =?utf-8?B?V254cVZnMXQzU1E2SlJmTnF3QzR3UmRpUjJLcGdFcmRML0VDSW53NGdyaGhv?=
 =?utf-8?B?VDVGN3Vvb3FIZko3SjY2dUhJdytjaWdiS1BtWkZUeThLUS96VUVJU2pmQmw1?=
 =?utf-8?B?NXpCK3k0amxxejhQb1VVOXZIMUFQZnljZ2FLaUVrdmo2SW0zVERXdjN5aG90?=
 =?utf-8?B?RUxBdktkTHdTSTNZY0J2QVJtL256eFBaSzdyVFNnRE5MQ1V3bkMxeWk4dmtt?=
 =?utf-8?B?c2V0dlNXV05uRm9YQ1M4MUpoZDlWYVFVcERZNnd3bkdrbnpzTlg5d1ByMnZv?=
 =?utf-8?B?ampFL1NzUDlpNU04OFBCSUNDREJOaGlMZ2dZbEhhcHlCYmZYUHdPbm1QS0Np?=
 =?utf-8?B?MWZPUXU1ZXhnMUtPWWRSNUU0bmFDVVpXRVNJNGhTeW9XK3YxdzcrU004cDBU?=
 =?utf-8?B?WW9sUEVYUlI3NlRlM0tiZnFOeVVRRE9ZN3hXcFlGell1VjVjVzF1V005N21o?=
 =?utf-8?B?QnZZQ1ozNWF0Y3VJTWF1NUt2NmRaR3oxWjYxUHhKd0pzQXk3c050MkEvZDAr?=
 =?utf-8?B?d3hYWGZkMmFHOGt2YVBTbnNLNEpWV2YzUDFXN09MLzVVVndtWVNsTnQvLzJr?=
 =?utf-8?B?V2dtU0VibG9HYTI0cGNOcTcyMnJwQVlQQU8zT1I5NlJ2WUU5Nm1Fd2x1M1NH?=
 =?utf-8?B?UDk0ckpKT0VPRWpKdEQya284UXRRMEZyNjB5LysrYzVZZkczM2VlQXV5Sm9N?=
 =?utf-8?B?UHpXbnhHczhpZkp1bkdzS0FhYkVxNHFZMGFEcXhpVWRBNmRLMjUvWlFJM3pa?=
 =?utf-8?B?RDB2Z3J0TUVJOVEzZEdUbHFpMWNUTG9UMUM0Z05nMGVkMnRkTWIrbEdFRGlt?=
 =?utf-8?B?dFZ3bWdubTdjOU5FRXlEVjZweWpiblRpYk8vMlBmZlRKeHl5TEE0eVdqVEpR?=
 =?utf-8?B?dGpjdmtvbWQzQjhoc0IzNUp4WFNWRm5kY04renBSN09QbEVJY3ljcmIvM3Ur?=
 =?utf-8?B?c3hpRTJNME5DM1R0UnJic0hhdEZVQmgvS25GdWRoNG1iOGJYdDdRU2VxUDBs?=
 =?utf-8?B?UHkrL3dBcWxQS3FQRmw0d1dYVGpWNmM0SE9pdXhlN1JOQ2RNSTFWYTBRVW9u?=
 =?utf-8?B?M3lyUHhsT2ZLZlAxc0k0TG5EL2VKb2F2aExEekM0eFhMRHFPdFp1czE5d0ZH?=
 =?utf-8?B?dTNnYTZtMDBzVy96NEpsVXNyZ1VuaHBpVy9zckRTalczMlNSSm5Wb3hxTElU?=
 =?utf-8?B?MGZpbEdQbVpiYWQyMUJ0Y0Z5YmRQUkc3NndkOFE5V1BJWUlKcUd6U3ZmWEMz?=
 =?utf-8?B?Y2wvRkhPRVU3RUsweFAveVNzbmlITHVicnVSa00xWVREODFCS0p3eWp3NVNG?=
 =?utf-8?B?aG9JTWtab1NBTnUxMmwwUWlla0lqRkhBQzY2L0cyQWRtZXlsTy9HWUIwUEdH?=
 =?utf-8?B?aEdSUC9iN2NqUXV4SUg0VXlXN0YxRlJua3JIU3Vjb2h2Mk1PdE1UYUNUVTJx?=
 =?utf-8?B?T2ljZTFtOTV6aXJxWkEydmxxaHpLMHlhTDhoSVRHcFlDTk1kVzc5MjBkajU0?=
 =?utf-8?B?TkwyMC9IRUlVdTFCM1IvcmYzemZ0d01CdUVOWkFuQTUrS05IVW5tQlNjZ0l4?=
 =?utf-8?B?UlNTRXFZWFROaXAvSFZ3T3Q1WjlVM2hDOXlIdlZiNnQyYXlycC9tZUNsbVVs?=
 =?utf-8?B?cnpaSG51TllJNEJjUFRFdi8xZ2FhR0VTSllXWmprUE4xR1Vad1V0RU44MkVn?=
 =?utf-8?B?d0tkcmJ5TzlHWmFKVTJpR0UyYnU0dWxBdUhJbzJRSEtqVlUrQncwYjBUSHB3?=
 =?utf-8?Q?mBWDSM13DZUtcwE4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CACBF1D2AA41C4E8E57B0CE2DEA62BC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4508f125-77e7-4dba-5f18-08da125e739c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 15:03:30.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5kp5wO1adHxErbwPCyqhfeU/8bc+4/wx9AA4MgO/QxU5P2oHnD/1p2TEeQShte7DrIks6nI5vtRl2xpZwDBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTMwIGF0IDEyOjM0ICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gSGVs
bG8sDQo+IA0KPiBkdXJpbmcgb3VyIHBlcmZvcm1hbmNlIHRlc3Rpbmcgd2UgaGF2ZSBub3RpY2Vk
IHRoYXQgY29tbWl0DQo+IGI2NjY5MzA1ZDM1YQ0KPiAoIm5mc2Q6IFJlZHVjZSB0aGUgbnVtYmVy
IG9mIGNhbGxzIHRvIG5mc2RfZmlsZV9nYygpIikgaGFzIGludHJvZHVjZWQNCj4gYQ0KPiBwZXJm
b3JtYW5jZSByZWdyZXNzaW9uIHdoZW4gYSBjbGllbnQgZG9lcyByYW5kb20gYnVmZmVyZWQgd3Jp
dGVzLiBUaGUNCj4gd29ya2xvYWQgb24gTkZTIGNsaWVudCBpcyBmaW8gcnVubmluZyA0IHByb2Nl
c3NlZCBkb2luZyByYW5kb20NCj4gYnVmZmVyZWQgd3JpdGVzIHRvIDQNCj4gZGlmZmVyZW50IGZp
bGVzIGFuZCB0aGUgZmlsZXMgYXJlIGxhcmdlIGVub3VnaCB0byBoaXQgZGlydHkgbGltaXRzDQo+
IGFuZA0KPiBmb3JjZSB3cml0ZWJhY2sgZnJvbSB0aGUgY2xpZW50LiBJbiBwYXJ0aWN1bGFyIHRo
ZSBpbnZvY2F0aW9uIGlzDQo+IGxpa2U6DQo+IA0KPiBmaW8gLS1kaXJlY3Q9MCAtLWlvZW5naW5l
PXN5bmMgLS10aHJlYWQgLS1kaXJlY3Rvcnk9L21udC9tbnQxIC0tDQo+IGludmFsaWRhdGU9MSAt
LWdyb3VwX3JlcG9ydGluZz0xIC0tcnVudGltZT0zMDAgLS1mYWxsb2NhdGU9cG9zaXggLS0NCj4g
cmFtcF90aW1lPTEwIC0tbmFtZT1SYW5kb21SZWFkcy0xMjgwMDAtNGstNCAtLW5ld19ncm91cCAt
LQ0KPiBydz1yYW5kd3JpdGUgLS1zaXplPTQwMDBtIC0tbnVtam9icz00IC0tYnM9NGsgLS0NCj4g
ZmlsZW5hbWVfZm9ybWF0PUZpb1dvcmtsb2Fkcy5cJGpvYm51bSAtLWVuZF9mc3luYz0xDQo+IA0K
PiBUaGUgcmVhc29uIHdoeSBjb21taXQgYjY2NjkzMDVkMzVhIHJlZ3Jlc3NlcyBwZXJmb3JtYW5j
ZSBpcyB0aGUNCj4gZmlsZW1hcF9mbHVzaCgpIGNhbGwgaXQgYWRkcyBpbnRvIG5mc2RfZmlsZV9w
dXQoKS4gQmVmb3JlIHRoaXMgY29tbWl0DQo+IHdyaXRlYmFjayBvbiB0aGUgc2VydmVyIGhhcHBl
bmVkIGZyb20gbmZzZF9jb21taXQoKSBjb2RlIHJlc3VsdGluZyBpbg0KPiByYXRoZXIgbG9uZyBz
ZW1pc2VxdWVudGlhbCBzdHJlYW1zIG9mIDRrIHdyaXRlcy4gQWZ0ZXIgY29tbWl0DQo+IGI2NjY5
MzA1ZDM1YQ0KPiBhbGwgdGhlIHdyaXRlYmFjayBoYXBwZW5zIGZyb20gZmlsZW1hcF9mbHVzaCgp
IGNhbGxzIHJlc3VsdGluZyBpbg0KPiBtdWNoDQo+IGxvbmdlciBhdmVyYWdlIHNlZWsgZGlzdGFu
Y2UgKElPIGZyb20gZGlmZmVyZW50IGZpbGVzIGlzIG1vcmUNCj4gaW50ZXJsZWF2ZWQpDQo+IGFu
ZCBhYm91dCAxNi0yMCUgcmVncmVzc2lvbiBpbiB0aGUgYWNoaWV2ZWQgd3JpdGViYWNrIHRocm91
Z2hwdXQgd2hlbg0KPiB0aGUNCj4gYmFja2luZyBzdG9yZSBpcyByb3RhdGlvbmFsIHN0b3JhZ2Uu
DQo+IA0KPiBJIHRoaW5rIHRoZSBmaWxlbWFwX2ZsdXNoKCkgZnJvbSBuZnNkX2ZpbGVfcHV0KCkg
aXMgaW5kZWVkIHJhdGhlcg0KPiBhZ2dyZXNzaXZlIGFuZCBJIHRoaW5rIHdlJ2QgYmUgYmV0dGVy
IG9mZiB0byBqdXN0IGxlYXZlIHdyaXRlYmFjayB0bw0KPiBlaXRoZXINCj4gbmZzZF9jb21taXQo
KSBvciBzdGFuZGFyZCBkaXJ0eSBwYWdlIGNsZWFuaW5nIGhhcHBlbmluZyBvbiB0aGUNCj4gc3lz
dGVtLiBJDQo+IGFzc3VtZSB0aGUgcmF0aW9uYWxlIGZvciB0aGUgZmlsZW1hcF9mbHVzaCgpIGNh
bGwgd2FzIHRvIG1ha2UgaXQgbW9yZQ0KPiBsaWtlbHkgdGhlIGZpbGUgY2FuIGJlIGV2aWN0ZWQg
ZHVyaW5nIHRoZSBnYXJiYWdlIGNvbGxlY3Rpb24gcnVuPyBXYXMNCj4gdGhlcmUNCj4gYW55IHBh
cnRpY3VsYXIgcHJvYmxlbSBsZWFkaW5nIHRvIGFkZGl0aW9uIG9mIHRoaXMgY2FsbCBvciB3YXMg
aXQNCj4ganVzdCAiaXQNCj4gc2VlbWVkIGxpa2UgYSBnb29kIGlkZWEiIHRoaW5nPw0KPiANCj4g
VGhhbmtzIGluIGFkdmFuY2UgZm9yIGlkZWFzLg0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBIb256YQ0K
DQpJdCB3YXMgbWFpbmx5IGludHJvZHVjZWQgdG8gcmVkdWNlIHRoZSBhbW91bnQgb2Ygd29yayB0
aGF0DQpuZnNkX2ZpbGVfZnJlZSgpIG5lZWRzIHRvIGRvLiBJbiBwYXJ0aWN1bGFyIHdoZW4gcmUt
ZXhwb3J0aW5nIE5GUywgdGhlDQpjYWxsIHRvIGZpbHBfY2xvc2UoKSBjYW4gYmUgZXhwZW5zaXZl
IGJlY2F1c2UgaXQgc3luY2hyb25vdXNseSBmbHVzaGVzDQpvdXQgZGlydHkgcGFnZXMuIFRoYXQg
YWdhaW4gbWVhbnMgdGhhdCBzb21lIG9mIHRoZSBjYWxscyB0bw0KbmZzZF9maWxlX2Rpc3Bvc2Vf
bGlzdCgpIGNhbiBlbmQgdXAgYmVpbmcgdmVyeSBleHBlbnNpdmUgKHBhcnRpY3VsYXJseQ0KdGhl
IG9uZXMgcnVuIGJ5IHRoZSBnYXJiYWdlIGNvbGxlY3RvciBpdHNlbGYpLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
