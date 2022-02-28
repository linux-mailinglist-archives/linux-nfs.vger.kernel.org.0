Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC94C79A2
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiB1UHb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiB1UHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:07:31 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2123.outbound.protection.outlook.com [40.107.220.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613404EF7B
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKTET2R+uTJilXImuqRtg7i80PUoVWZ7KmXXh6TrwFwNh1dV/To2Br4aTEYOBK1vQWGOG2mcGKFfL5bc0qPhy5Xhawjx+WwP3j/Y7b7DL7DMmjQ+wX1sxvGLhOng9+FD80grQepux4NLY8d0Tt0n7XWKlBvMnPJllim6KL9rN0vT2PBsQIOd+1ZzdFWOTmdYBu4o4m7q14+qAP34v117G4T6lvMmUruRlRRnEIC+3M6v0VkWN94chA8PNspN5EyVdohRfSBlyUuom93mumNq8gw2DADyynXGXFLAK3zhCvEv+rmknI+K8wQMCA2261+wNT2vNXMBHBjLYizlM2mOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k99u58AOgUMGSFNqXbdhnzvjVsJKTT9GZo+mAnPH578=;
 b=bb0yZIrwIToKIBauEKGfe62H5uiWKotjrcW4N55Hayhamwvk1ZXkLwEEr+USdrm6O0j1tT67ozhsxVpsXqBRL4aXj+cUwJ6GsGIUE9YGPwLsDYESqbUfUvtKbhZiniWtUoi3dwSZFV+IFEHLHOzV7qr3sSYjN+06GUP2kDisq8zckM6aRv1cXC4fx7XnXFom0sM/Kgs8PGYHgbKS1WvVPJBjYIvrrS3es3aY29T+8Kt7p+nOZcfKovrYZAxbiPMZOD7nWzLXfxm7jo3ZeE4d7bQZPXA6+45KEpUWIYVhwJtekaXF1MfI3MCF9jjSxHLXUCOzjnGpEW3bRFhtAKvSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k99u58AOgUMGSFNqXbdhnzvjVsJKTT9GZo+mAnPH578=;
 b=EkhxvzHzhcgUI+ZYvDUU8VaXlPJXyZdOp32WjDZYqaHa4/zOjC6/0G8rLH9CD8EzEPDEUj5Wv1lFYNiSFe71aPs6nGprMZiUDntOPJH/5oi/YpiwzrZ+mnJDinWL+cMJIcGQSJPWd15T8UplYQ2dvqrRiB2cGD6u0ltQqhIItrI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4883.namprd13.prod.outlook.com (2603:10b6:a03:357::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Mon, 28 Feb
 2022 20:06:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.013; Mon, 28 Feb 2022
 20:06:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Topic: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Index: AQHYI1yGsrbFUuqkvUeUFRfAYTkwhKyXsraAgBGBCwCAABW2AIAAG9OAgAARaoA=
Date:   Mon, 28 Feb 2022 20:06:49 +0000
Message-ID: <01c6aeddf91d0e68d7c497456ea96f4f24145059.camel@hammerspace.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
         <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
         <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
         <73b61ba083df0a8954979fed11d6398d336ee1d1.camel@hammerspace.com>
         <F853D68C-C066-470E-BCFC-988C3D46ABA8@oracle.com>
In-Reply-To: <F853D68C-C066-470E-BCFC-988C3D46ABA8@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e99e233-3e55-47d6-7d38-08d9faf5da9c
x-ms-traffictypediagnostic: BY3PR13MB4883:EE_
x-microsoft-antispam-prvs: <BY3PR13MB48831EB8B67C5D02DFFEB19AB8019@BY3PR13MB4883.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3smdA39A00d0DDB3QZQRxAs9d9VvEmQIvkOlPKlwSxtO5/OamU/2WouDbGqCh5gmLS6S7BNiMt3w6SE5vmsGTHm43jOxCJNRLpZvwLykJO2YC54qO5QtTWwW/FG8hYMTpQMxeoUJcNPQrnyKgF5midMQaO4Bk9Q6wl1axX5M2R5J5lXWk0/16MupclA9G+Y09ZydDH4CajSVZdegqgMpmPHdeD8NQWnJrqHi9uFG4AUAvTe6x9fK3DjCcgDKNXkCaP5yd+d4XD96mx6cTmH/0BoqQFHaSD2jyeXThwBdJKshHTvTCF9ZTUMI4ZYkCKjP7UiaR98REzwimdaRacOkWE2dElyXn2e2D9TIUXlrt2IeeRxqxjcMYfgHrFhizB9Kt18oGZyOTmYXrS932jKZkKuq32fovLi/dmMitIlTK66lBkSt2710FlOekhd86qS7lSZfcnbTNwZDABKFHv40h6//QJ+XAOIAYq3D7Fc64pYXf6I2f175dy2XwdnmHW4G/D3ZSgTBaPGLgH3uweKpzJZZsgoeYIsa5wjTz+0R+E9yZAjF2KwjbxMM8xO7o31o4DfXdo7X/QpUdJcYwD4MwX0zARXvkOXLUcX8+iF7wyFHmXHgtIvattqX2n6bVZPaxZ0lI1+lGpzOcavyIXYZS6EVRWOj3V4VEV6tD/ZeOEKVUUyL4Ca6wAPh1wz+VO1vXMnLH15j/jZSngoZ5b7mgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(186003)(83380400001)(508600001)(122000001)(4744005)(8936002)(5660300002)(36756003)(26005)(2906002)(6486002)(2616005)(38070700005)(71200400001)(66476007)(66946007)(8676002)(64756008)(4326008)(66446008)(6506007)(66556008)(86362001)(6512007)(316002)(53546011)(54906003)(6916009)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlE0Y21aM3N2V3ZoL1VsZVNya1pVK1JhNkJNNDVhMkNSZ0U1U0NxSDdZOTlS?=
 =?utf-8?B?NTY5M0t4d2MvTFNnRnREbVMrTGd5TmgzZmF0cWt1b1ZMQlZHdzJqUk5pWkQ3?=
 =?utf-8?B?S2dCajFHY3BkcXRJdWZNMk1mQUxSOEw1NjBiNDdtTVNjTUk0amNveTBNRGR2?=
 =?utf-8?B?MTZWeHpZMm9PdFVPamFRKzRDaGZac0ZpMkZ5eXE2Qjl1MDVLOFpjc2QxTlo3?=
 =?utf-8?B?MG93RWRHaTdCQnR6ejdaM3VBSElsT0dtOUtUVmpoeU9vQkRxaVJ0cHJCc3Fu?=
 =?utf-8?B?dUlSUEowUTk0NEJnbXNWMGNZNWpueHA0MVVlZHkyZFg0UENCNkQrMnR4RTY3?=
 =?utf-8?B?aXE0b1FMYVRJOEdockNEUU5tdkoxNHFjeXJvTFBSdVBTRG0wRisrWElqRXRn?=
 =?utf-8?B?bnpSaTFBbWhVZ1B5REhFVjd6eE0wMEdHYkxrY1A4WTlwK0F6MFhmZGJYU1VQ?=
 =?utf-8?B?SDZpSExWaDZMMlJQRTR6MVVKN0dVdkcxMDRIdzYwRnR1Z2pzRWhEZGtVZVJo?=
 =?utf-8?B?V3JyeEhlWlJPRThIYVBWVU1yRU84NUhRTEgwSG5rZ085RWwvNTFDY2hxOVEr?=
 =?utf-8?B?SzNqZWN5KzRHaVZKRVE3ZzJ2ck1GZDJEeGVWc0dSNG80amkwM0RWTDQrVk5s?=
 =?utf-8?B?ditYT1dYZXJaakZjWG1JNHRRNCtkalhiNVE0dnZ3Mk1HczVmZExjMkVSaW0w?=
 =?utf-8?B?aXpYN1BjdjdGSW1BUXFYaFI4OUp4OEs1VzV0Mnp3eGhCdWpORHhEMHhEVmow?=
 =?utf-8?B?WFZIQ0U5UEs0STBqMGVEL2RabTlTMTVqbGY0MWtCM2JDNG03blRKRmd0K1ls?=
 =?utf-8?B?RlBEeDlwM2E5UFhVa0hlRzl3bUN2UXhoWmVYRjhCcmJlNU41c0ptTi9uN0lV?=
 =?utf-8?B?REFzVjV3Ty9RY3J4RkFSakdLb2JsNkNNRzRiN2wxZ1YvOWRDTlFuLzJjMW9S?=
 =?utf-8?B?OUJoZU1ENWFBVk1NNFdJbW1md3daWmNGVlh4VVdqck1iM1dWSS9XVStWVEZV?=
 =?utf-8?B?aXJyNm51bmt3Rndzam82dnBqT0hUUGdEUVRXcklBWTdsRzVSZ2o3NGFrMGlK?=
 =?utf-8?B?SGRoOWNWcFJBQW04YTM3REZWNjNRK1IrWGhUWXk4ZnRiTUtUMVRxUzh1MTJk?=
 =?utf-8?B?Y3BFeHdqUGMyZ1hzR1NZNmN3akhjemo3UWdYWXlIa2NXSU9WbDFKU3paVU1R?=
 =?utf-8?B?QVU0SGw5dFN1YWdMZFpvUUlzSzNqWVg5TnJDZHQ1NFRCbEMxaEkrV25ZTWVI?=
 =?utf-8?B?MGR6MDB3cVhPYkNwRVBCcFFiQWhpZ2lmNnQ2SkhpMlhFeEpWWW90RmR2anBz?=
 =?utf-8?B?U1hvSWc4N3A4S3VzTGl6aGJ5T1F4UU9CQ290emRHTTF0YnpUUFUzTEZLb1JU?=
 =?utf-8?B?aFIyQm5yL1k1VUNscDZsZ1drdXg4VSs0dk9sZzJjamhUM3RxanI4TlNmYW9C?=
 =?utf-8?B?VFZEK0lvZ2VyYWV1UktBOVZGODNSZmFuRytWOUpRVDRvZ2xqYU5QeFJxSTFx?=
 =?utf-8?B?MmRQbWNENzZpcWJyeTdTb0gzMkt5SGg1QXluSWVVWjdUR0lwYUw3TVdETnV1?=
 =?utf-8?B?L3RQM0t3Q0NtcHhLb2crVnNad2tOVjcrL09kS2E4dkxpWktMUVNUNDdjbDZh?=
 =?utf-8?B?L2tPTnEyb1VwR0wvWjBrSW5PcGd2ZHRqRlB0ZXNQbzdPTmxRQTYzc3Fob1ZF?=
 =?utf-8?B?akJRV2dJbjNwR2lyOUtBY1d5SjJzMVpoSlgyTmdNY2swc2FtM1UrNG1zNE9Z?=
 =?utf-8?B?UkpxOXBSQ1JsUUhtYzQyZU1qUDY2K3ZTVmxwcTVJSk10S3M5RTN1UE1wbjR1?=
 =?utf-8?B?bUV2R3ZHWWRpSGNlUHhVWW5pbkU2RFdjd1pCVW9YV2V6V2RmQ1FkTzdadms1?=
 =?utf-8?B?N0FiL2Z5QzNYajROV3o3MXZDRU4vbmNlRnFnUEZsOGpidVNFd1R0UEovQkll?=
 =?utf-8?B?SnVQbkkxRHhxUko5Vm00M1lvOHZZbnp5QXg4cm4vcDVqSnE5LzVCZ2p6aGRN?=
 =?utf-8?B?bnI0bkFDMW9JOWRiRTB2SWZqOVFpWGZvZUIySVFUYkthNDdjWWNyRlI4T2VH?=
 =?utf-8?B?Q3NCZ3I0R2dqeUJJTVFWRjA0dkJXYXBNUEF4VWVzNGRibmFFKzMybm1Gd3lO?=
 =?utf-8?B?cmpMK2dTdkpVcUlvVFE4VHAyNXJtZkdhc3I0NnRENGt6UXV0M0F0ZHIxTTFt?=
 =?utf-8?Q?WdNQrYTyYf5qUQVrqjFeMDk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D9FE473CC04D4F92A9C3D6BDBE25BE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e99e233-3e55-47d6-7d38-08d9faf5da9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 20:06:49.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmdCzAVHxJVH9nsHVU5XLaPHHllvYmh0e0vhu0Zwjms5qWB1TeDT/2uVCCQWMkxzslINRMQFUaNEm2JKR3NH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTI4IGF0IDE5OjA0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBGZWIgMjgsIDIwMjIsIGF0IDEyOjI0IFBNLCBUcm9uZCBNeWtsZWJ1
c3QNCj4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gQXR0
ZW1wdHMgdG8gd29yayB0b3dhcmQgc29sdXRpb25zIGluIHRoaXMgYXJlYSBzZWVtIHRvIGJlDQo+
ID4gPiBpZ25vcmVkLA0KPiA+ID4gdGhlDQo+ID4gPiBxdWVzdGlvbnMgc3RpbGwgc3RhbmQuwqAg
VW50aWwgd2UgY2FuIHNvcnQgb3V0IGFuZCBhZ3JlZSBvbiBhDQo+ID4gPiBkaXJlY3Rpb24sDQo+
ID4gPiBzZWxmLU5BQ0sgdG8gdGhpcyBwYXRjaC4NCj4gPiANCj4gPiBBIG5ldyBtb3VudCBvcHRp
b24gZG9lc24ndCBzb2x2ZSBhbnkgcHJvYmxlbXMgdGhhdCB3ZSBjYW4ndCBzb2x2ZQ0KPiA+IHdp
dGgNCj4gPiB0aGUgZXhpc3RpbmcgZnJhbWV3b3JrLg0KPiANCj4gSSBkb24ndCB0aGluayBhIG1v
dW50IG9wdGlvbiB3YXMgcHJvcG9zZWQuIFJhdGhlciwgdGhlIG1lY2hhbmljcw0KPiBvZiB0aGUg
dWRldiBydWxlIHdvdWxkIGJlIGRvbmUgYnkgbW91bnQubmZzIHdpdGhvdXQgYW55IGNoYW5nZXMN
Cj4gdG8gdGhlIGFkbWluaXN0cmF0aXZlIGludGVyZmFjZS4NCj4gDQoNClRoYXQncyBub3QgaG93
IEkgcmVhZCB0aGlzIHByb3Bvc2FsOg0KDQo+IERvIHlvdSBzdGlsbCB3YW50IHVzIHRvIGtlZXAg
dGhpcyBhcHByb2FjaCwgb3Igd2lsbCB5b3UgYWNjZXB0IGENCm1vdW50DQo+IG9wdGlvbiBhczoN
Cj4gIC0gZmlyc3QgbW91bnQgaW4gYSBuYW1lc3BhY2Ugc2V0cyB0aGUgaWRlbnRpZmllcg0KPiAg
LSBzdWJzZXF1ZW50IG1vdW50cyB3aXRoIGNvbmZsaWN0aW5nIGlkZW50aWZpZXJzIHJldHVybiBh
biBlcnJvcg0KDQoNCldoaWNoIGlzIHdoeSBJIHJlc3BvbmRlZCBhcyBJIGRpZC4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
