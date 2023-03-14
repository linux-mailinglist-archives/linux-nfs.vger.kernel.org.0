Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C726B9EC7
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 19:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCNSlL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 14:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNSlK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 14:41:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2108.outbound.protection.outlook.com [40.107.223.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A786B2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 11:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfFyf4LRmunryZoPEci1BEYQXM/L3MIxEoArruAGb8SQ9W10Klxln/B9ls7IrXTJqbLZjUU+AZSHDI2X6Cf9UXkMJPzFr6jtVmnAeh2L7fHkh+0PGJ+e4nrAt+PTAfnWs4vQpuHJ672qSTYGMzMempPGKTyjNqdFnc6pBunEAU+FD8UTWySJpZCBigL9+k2v55mksiNRJKjKz0fGcnQa3wRFO+IgRkYKyXRPhHAgTec4Wi39CQ2Yn3NDIDJNCrAA4LKp6VjE97urHaqoA2i+X8Q7afivrLOnDyny6yoozqzQqJy70TpI7dkeq4Ps4CMLLD8iZ6qNS/2925/dbNv2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XWQ0mt8zWPPklDKjrUlMCE0Nm8oYqfhXmtfM3SQ64o=;
 b=gKfOiCL7+zyonI0vrDGwOyIYQXAoL5ASZSkVAQSlP7Ph3TCDrHraV2yuw/RFXZgzFKbAP93MZwYTXAZokOnSwA6srfIJw4VLIqcF/5f/wYnMSku2KEj+vaB6m5WK8U37ntifDm3PasHxS0sMs4c+KWyLl9cvRl82VWE/uWxJTanStPYf4F23n97j6taSGWGsYbYo55V54sDdrvAA5WRAncPPVKSpOALl3xt3GKz8YADDDKtOBtDEkgocfXAsd/eyQDsRNOfFHCwmgW6uvIqJisT6XcJ8TlnVSoTxaSPd286v5vhl/wLkSYG53g1oC6MSn1dq1kmi9KqtRVG2WjfrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XWQ0mt8zWPPklDKjrUlMCE0Nm8oYqfhXmtfM3SQ64o=;
 b=SYQGMFGIPsb/NYRntIALDcEA7yydVDDVliWF4QzDI21fd/aFPCA8hbB5qgTgIYWrFS4G2mGHGRHvuMSPGw1pRKJ5VtVHBIUQiza0z0PxUcHuyXA2cfnWScw4o2zJ1Rl5d2Luq1XonXuQVmbQOm059fLEtkSJ88aWobRV5kceHUA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5333.namprd13.prod.outlook.com (2603:10b6:a03:3d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 18:40:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::d23a:123:3111:e459]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::d23a:123:3111:e459%6]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 18:40:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Andrew Klaassen <andrew.klaassen@boatrocker.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC: Use rpc_create_args->timeout to initialize
 rpc_xprt->timeout
Thread-Topic: [PATCH 1/1] SUNRPC: Use rpc_create_args->timeout to initialize
 rpc_xprt->timeout
Thread-Index: AQHZVb7+Nlj0kCmyVUeejcb8scrmpK76nUKA
Date:   Tue, 14 Mar 2023 18:40:08 +0000
Message-ID: <FD077033-023F-4214-A9A4-BECCF319F973@hammerspace.com>
References: <20230313151716.34280-1-andrew.klaassen@boatrocker.com>
In-Reply-To: <20230313151716.34280-1-andrew.klaassen@boatrocker.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5333:EE_
x-ms-office365-filtering-correlation-id: 13e3aef4-1c04-4f01-c3b9-08db24bb8923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmK8N6m0/haIAdz6IoqsL6+35P6UgtEIUzey5Z793iQHFk8AR71uwTa0uU1C8eDKx0AJ9hJfQclJfSEV7HUmkm7RW7vMosXwbkyL/blqWFiXrQqZ8/SQqM3Wj43XAgyMDibAAXye2HNurZdxy4bvWUUUwy5iH1GqDd5rvalvHW5BpOw+RZVFsXWTpQL3sbyWuRLK/q2x9C+6i/9Wtop9xy+apZcI+YI6ZY2r3TbpPpg/aXGOmWYCndE9xpGulboFDot0KYR3CW1WtYk3WS0g/tXX9rRZaQeKj3bHoRco5J5c3cpBOsER1kM6sDYdQSAOicjgeATapn4BI9JrVVRaQqzSh/KkM2klXSWBQmrcJPkzkBpaIcz1kHFbUQQwmk+gGWkOtKhrEeoDLGi/pEJ4zJur5QUMKqRMGeh+VSmFedtDZb2Nq6joiPi0S0YsLj9j8eWWPAjIfVI3SsJD63FeiRub/qWNS7CsqJdR2cjPGmTz8PVA/EXULjD2x5wGmlLyZ8iC+GmVDSub688h0GZyydQOwbXy5Q/yWKKPVIpqagd1c6FF2diDLeuNEJbd2MBlARIKcm02YR+YQcbwwy2UL5iFDrkAIinc3JJA64JeaIUe4Mygyfn2D7c1OeBAPWghjcys83GkFp/f/pN+H75Y8MCIiXCa/XPd5+4u5AVjWFPyKRLaQY8kSHtwrUA1G3iYCwtS8mbWQSBeS+sJLlZ7h0Qev6LqWhy00yawrzHK9S2aPFOFJPcJD3p9AYlCJX8l8Px4zd33rgjUOKX/oxERwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(39840400004)(346002)(376002)(451199018)(8936002)(478600001)(66899018)(54906003)(316002)(71200400001)(6486002)(966005)(41300700001)(4326008)(8676002)(66476007)(6916009)(5660300002)(66946007)(76116006)(66556008)(64756008)(66446008)(2906002)(36756003)(83380400001)(2616005)(26005)(38100700002)(122000001)(33656002)(38070700005)(6506007)(186003)(6512007)(53546011)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVhhRjNtalBVTXhIVXBGTnREc2VwR0JsbWhQMzZjcjkvdWIxS25sQmtMcGJP?=
 =?utf-8?B?THVud0ZWaTdYckdNbk5KcUtCczM4b21hYTF0aTRyZ0NmNnFLWWZSZjBNSjBM?=
 =?utf-8?B?REVaRGxnRWxNVytmWEZpdFlXM0Z5N0Q3eXNLM0pkSHo1WlIvK0htWjFXcUQ2?=
 =?utf-8?B?aUZVQmQ1a0E2VDc1VGtudHRKS1drUFoxTHpBcFoxU25FN3lsWGcxQ2JVb1lN?=
 =?utf-8?B?ZUQ5dHcxY3J4MU5QOGFScEU3WnFEU2hHRm1mWVFxcnc0UG1aTHZDdkxUeWhR?=
 =?utf-8?B?OU9mV3QvTW5peUtXTE5RclYzZ2p5TEFtNnhBbUNoamhnend1RVFod0RhL0NW?=
 =?utf-8?B?T29vUnl0V0JCYlRsMk1nb215WlhIaTVhZVZzOHRqVG5TSHpSVjNIWkh5WWRj?=
 =?utf-8?B?eTJsVWtGZmE2SkVVY3BtS1NWVFJpTFd5djRSblRtdkxIaVVNTWxVWFZaWGZs?=
 =?utf-8?B?ZFZYQ0FHdUg5TDhrWDZ0NE82UEE4dnRlM01MMmh5K0x2OGpzZ1NrMUJPWmVp?=
 =?utf-8?B?THJlTVRGR0toVy9BcXQ0TXhnakFKRVM3NzhZandHRkg0eHp1cmNObHdyNnFB?=
 =?utf-8?B?MkRrdCtqL0JkeTduQ1F2Z3RGdnFOTm5lVUJ6STA3TTBQN25CYVE1VmdCalFC?=
 =?utf-8?B?YnJXQVV4VHdZZmxTMDEyb3ExUzljZGhVbVdzQ3NKVy92V3FlWkVLaTZQUDBm?=
 =?utf-8?B?S1BYZDZ5bkhBWGFrMlRHemowTWcwYnRPeEwrVzUwTFN5TXlmaVIwNkloSmwx?=
 =?utf-8?B?dEU1eXNMQkNxcFE0bi81WExBK3RpK0liZThadEE4V0xVS3JjY0w3akl1RGh2?=
 =?utf-8?B?OElXUGwwNnlKYzNuQlZ5TlFSOHAvK1poZTBjZmJtdHd1azNzQjJZRDl1WWZW?=
 =?utf-8?B?cEJyNWlBS3ZoeU41NDRCblk4cU40Mmg4VHZyR05BSmg5Q1dyTU1IQ0hBK0pB?=
 =?utf-8?B?d1JNM0xmQVZVckxmNHVIcU1zTlJ1Rzl6Q2lrU2pFWnpkdW1qWXZkeHpMVndY?=
 =?utf-8?B?M2dmeUxqb2pVUnNaN2lUQzdkQzRqWFVpVjl2b3hFVDJiWjlpWFR5S1FEUTdt?=
 =?utf-8?B?OTZodHA4MTkra3NESFQvRlY4QThoSmtpQmxiSG1RUHF5TFF0M3RZMVl6eExZ?=
 =?utf-8?B?OXFuWU5VZHB5ckh5VUhLWDVUUGhTOVdJL0JScncrQzdHVC8wVnhjcVJtVDFv?=
 =?utf-8?B?UDhaRnA3S2k0Sm5HNDBNREdlNWE5WmVmOEhzaGZ0N25EbHdsQ0tOYTlPdlhk?=
 =?utf-8?B?dVFvT3BzemFGNUVxbGJqeDRFVExaK0VsQUxoMjZlZVFoNkJpY1VvcndZZEt5?=
 =?utf-8?B?aUhWTFNrSyt3YUxFSjI3aktVaC9zaERpYjBKUFZEV1cxaFZMMDhyN3g2MHlw?=
 =?utf-8?B?N0pkRDdBT0JpUE1MVTU5VEJnNUI3eUF1bjlOczViekRzdFdaMFBnbFNydUF1?=
 =?utf-8?B?RkMyRGpUbG5jMzdPclBPSVk4UWFROStZKytrSFJndTlwRmlxWGs2MkRyV2dh?=
 =?utf-8?B?MjhCL0NqNWN4VlZlM0RjbWUwZUJBaHdnY3VPZlFOWk0rbTJybFo3bzZCSlIv?=
 =?utf-8?B?MUlkajQrb0hnMUpIODlGZ1ZVYkN1V1RvdTJmRnBQbFlNRDArWnlHZ1hsRzhV?=
 =?utf-8?B?eWE5bXM2eHBzVHczeTlJckxtZVJuaFh0Uk9yV25HYnZBVzlwbjhyd0Qwayth?=
 =?utf-8?B?Rkh2Q1hHVTJGSWVLLzZRMXJhaEFYaEVnTS82bDV0NmxvSmVWa1lkK1B2akhN?=
 =?utf-8?B?ajJ6dDhSSDN0c3N2RkhVM0R3ODd0bUJPMlE1Q0xEMUtxd1pRMGxEbmpYVjdj?=
 =?utf-8?B?ekVuQ0FIZnBUUVVNcmhPZXBwQk8wcDZ3NmNrcVFHcS9Yb0hDMmcvOTRPalA4?=
 =?utf-8?B?a1I4Rlp2WC9ZaTBJRjFGYlcxRWxYanRYS1ZBSng5QmJtUzBmNnRXVm5DdGZ6?=
 =?utf-8?B?N0pCRlZzYlJUSjFYekNoSlFkVmVSZ0ZyUXVvZWYzVDNzZHJtWW1lU3hEaWU3?=
 =?utf-8?B?ZmNnQ1BMcS9oaEhOS01LLzZ3WnB4RllKYjZRVlRsdmJDNFI2Y3Z1S1pMeThj?=
 =?utf-8?B?ZDVhSzdlRVVEZ3dUbXhnQ09HOEplQmdiMm95TXk0cnhYM1dpaHUwdVVrQnBj?=
 =?utf-8?B?UWdJN3NSM1VzdDdtdW1kUHpCMmRxbkpTMXZBNGRQclZ5L3o4RUVzbWtCbW1B?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F894C06AC3DE9C47BC7023773B648B76@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e3aef4-1c04-4f01-c3b9-08db24bb8923
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 18:40:08.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtYAmSWLOMsx8yZabNGbYXBeOPt8UJlFfW8oZ4ev1PNDq6Zmmz4+pwimwmg+es2V7BuWnwvUrE0rIOiYbo5hJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDEzLCAyMDIzLCBhdCAxMToxNywgQW5kcmV3IEtsYWFzc2VuIDxhbmRyZXcu
a2xhYXNzZW5AYm9hdHJvY2tlci5jb20+IHdyb3RlOg0KPiANCj4gV2UgYXJlIHVzaW5nIGFwcGxp
Y2F0aW9ucyB3aGljaCBoYW5nIGlmIGFueSBORlMgc2VydmVycyBmYWlsIHRvDQo+IHJlc3BvbmQu
ICBXZSB3b3VsZCBsaWtlIHRvIGJlIGFibGUgdG8gY29udHJvbCBORlMgdGltZW91dHMgc28gdGhh
dCB3ZQ0KPiBjYW4gY29udHJvbCB0aGUgbWF4aW11bSB0aW1lIHRoYXQgdGhlIGFwcGxpY2F0aW9u
cyBoYW5nLiAgV2UgY3VycmVudGx5DQo+IGNhbid0IGRvIHRoYXQgd2l0aCBUQ1AgTkZTIG1vdW50
cywgc2luY2UgUlBDIGNhbGxzIG1hZGUgdG8gYW4gZXhpc3RpbmcNCj4gTkZTIG1vdW50IGFyZSBm
aXJzdCBzdWJqZWN0IHRvIHRoZSBkZWZhdWx0IHVudHVuZWFibGUgU3VuIFJQQyB0aW1lb3V0DQo+
IG9mIDIgbWludXRlcy4NCj4gDQo+IChJJ2xsIG5vdGUgdGhhdCB0aGUgZXhpc3RpbmcgTkZTIG1h
bnBhZ2Ugc2VlbXMgdG8gbm90IGRlc2NyaWJlIGN1cnJlbnQNCj4gYmVoYXZpb3VyIGNvcnJlY3Rs
eSwgc2luY2UgaXQgc2F5cyB0aGF0IHRoaXMgdHdvLW1pbnV0ZSB0aW1lb3V0IGFwcGxpZXMNCj4g
dG8gaW5pdGlhbCBtb3VudCBvcGVyYXRpb25zICh3aGljaCBpdCBkb2VzIG5vdCksIGFuZCBkb2Vz
IG5vdCBzYXkgdGhhdA0KPiB0aGUgdHdvLW1pbnV0ZSB0aW1lb3V0IGFwcGxpZXMgdG8gb3BlcmF0
aW9ucyBvbiBleGlzdGluZyBtb3VudHMgKHdoaWNoDQo+IGl0IGRvZXMpLikNCj4gDQo+IEFuIGV4
aXN0aW5nIHRocmVhZCBkaXNjdXNzaW5nIHRoaXMgcGF0Y2ggY2FuIGJlIGZvdW5kIGhlcmU6DQo+
IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1uZnMvNDVlMmU3ZjA1YTEz
YWJhYjc3N2IzYjA4Njg3NDRjZGJmYzYyM2YyZC5jYW1lbEBrZXJuZWwub3JnL1QvDQo+IA0KPiBU
aGlzIHBhdGNoIHVzZXMgdGhlIFJQQyBjYWxsIHRpbWVvdXQgdG8gc2V0IHRoZSB4cHJ0IHRpbWVv
dXQuICBJbiB0aGF0DQo+IGRpc2N1c3Npb24gdGhyZWFkLCBKZWZmIExheXRvbiBoYXMgcG9pbnRl
ZCBvdXQgdGhhdCB0aGlzIG1heSBvciBtYXkgbm90DQo+IGJlIHRoZSBpZGVhbCBhcHByb2FjaC4g
IEkgaGF2ZSBzdWdnZXN0ZWQgdGhlc2UgYWx0ZXJuYXRpdmVzLCBhbmQgd291bGQNCj4gYmUgaGFw
cHkgdG8gZ2V0IGZlZWRiYWNrOg0KPiANCj4gLSBDcmVhdGUgc3lzdGVtLXdpZGUgdHVuZWFibGVz
IGZvciB4c19bbG9jYWx8dWRwfHRjcF1fZGVmYXVsdF90aW1lb3V0Lg0KPiBJbiBvdXIgY2FzZSB0
aGF0J3MgbGVzcy10aGFuLWlkZWFsLCBzaW5jZSB3ZSB3YW50IHRvIGNoYW5nZSB0aGUgdG90YWwN
Cj4gdGltZW91dCBmb3IgYW4gTkZTIG1vdW50IG9uIGEgcGVyLXNlcnZlciBvciBwZXItbW91bnQg
YmFzaXMgcmF0aGVyIHRoYW4NCj4gYSBzeXN0ZW0td2lkZSBiYXNpcywgYnV0IGl0IHdvdWxkIGRv
IGluIGEgcGluY2guDQo+IA0KPiAtIEFkZCBhIHNlY29uZCBzZXQgb2YgdGltZW91dCBvcHRpb25z
IHRvIE5GUyBzbyB0aGF0IFJQQyBjYWxsIGFuZCB4cHJ0DQo+IHRpbWVvdXRzIGNhbiBiZSBzcGVj
aWZpZWQgc2VwYXJhdGVseS4gIEknbSBndWVzc2luZyBuby1vbmUgaXMNCj4gZW50aHVzaWFzdGlj
IGFib3V0IG9wdGlvbiBibG9hdCwgZXZlbiBpZiB0aGlzIHdvdWxkIGJlIHRoZSB0aGVvcmV0aWNh
bGx5DQo+IGNsZWFuZXN0IG9wdGlvbi4gIEknbSBndWVzc2luZyB0aGlzIHdvdWxkIGFsc28gaW52
b2x2ZSBjaGFuZ2luZyB0aGUNCj4gU3VuIFJQQyBBUEkgYW5kIGV2ZXJ5dGhpbmcgdGhhdCBjYWxs
cyBpdCBpbiBvcmRlciBmb3IgaXQgdG8gYWNjZXB0IHRoZQ0KPiBzZWNvbmQgc2V0IG9mIHRpbWVv
dXQgb3B0aW9ucy4NCj4gDQo+IC0gVXNlIHRpbWVvIGFuZCByZXRyYW5zIGZvciB0aGUgUlBDIGNh
bGwgdGltZW91dCwgYW5kIHJldHJ5IGZvciB0aGUNCj4geHBydCB0aW1lb3V0LiAgT3IgZG8gdGhl
IG9wcG9zaXRlLiAgVGhlIE5GUyBtYW5wYWdlIGRlc2NyaWJlcyB0aGUgY3VycmVudA0KPiBiZWhh
dmlvdXIgaW5jb3JyZWN0bHksIHNvIHRoaXMgYXQgbGVhc3Qgd291bGRuJ3QgbWFrZSB0aGUgZG9j
dW1lbnRhdGlvbg0KPiBhbnkgd29yc2UuICBJIGFzc3VtZSB0aGlzIHdvdWxkIGFsc28gaW52b2x2
ZSBjaGFuZ2luZyB0aGUgU3VuIFJQQyBBUEkuDQo+IA0KPiBVc2UgcnBjX2NyZWF0ZV9hcmdzLT50
aW1lb3V0IHRvIGluaXRpYWxpemUgcnBjX3hwcnQtPnRpbWVvdXQNCj4gDQoNCkp1c3QgYmVjYXVz
ZSBzb21ldGhpbmcgY2FuIGJlIGRvbmUgaW4gdGhlIGtlcm5lbCwgaXQgZG9lc27igJl0IG1lYW4g
dGhhdCBpdCBzaG91bGQgYmUgZG9uZSBpbiB0aGUga2VybmVsLiBJZiB5b3XigJlyZSB1bmhhcHB5
IHdpdGggc3VucnBjIHRpbWVvdXRzLCB0aGVuIGl0IHNob3VsZCBiZSBxdWl0ZSBwb3NzaWJsZSB0
byBkbyB0aG9zZSBjYWxscyBpbiB1c2Vyc3BhY2UsIGFuZCBwYXNzIHRoZSBwb3J0IG51bWJlciBk
b3duIGFzIHBhcnQgb2YgdGhlIG1vdW50IHN5c2NhbGwuDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg==
