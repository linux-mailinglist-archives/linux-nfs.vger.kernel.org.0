Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C54C129B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiBWMSl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 07:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiBWMSk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 07:18:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20728.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::728])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2BD9E9EB
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 04:18:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBvENPGGm/C4+XyBEQCnmqoKkIXZWMlKc8tFPlqSogNZJlE8/sLucfzcQADJLgveISVaiyfzquxt7AUbKj6VHViUPzTMlzlnsKgHufeETh41b4MnXsWTVSz11Q028fe+sNGioBrCPhypUcBQkCsQaYKXwl9spDEguONe+DYxbDTNkPgCS0GAcUi+NpNCXqMauRjVZ3B5WkXY8GFbVE9qsBOrTvYJHERhywUvOhgSMD6qyELCzxEpFhMIfNADrwmJS3DM9WduuR4eDAmSE/Qe6nxwKW4F6cj/UvHA5N4UfEXc4QxrEoPWR6xhhCA2uil0dmhzBKxN/X9CqYqVg5uEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGekfw8MzdbJesDpC/Us/1cXwD3THQM3gPu5Pa08kbQ=;
 b=jHEEGcfIU5OUdv86i2/ddVe8/5WteU0PeSMaoVsORVtu+lM8Jopf1zq1apIZe1Mfb2K9IJZ1VX/O+Kd8pYC4w9Z5dgRcrWTLuzF7Z2TtDn2vo9ntTvQjRBr32Q/guyVQC2DrH8T/nPxPzLSEe5c9htT7WXBL9piEIfoznNepFOHduZTVlpKe2NHto1BNMQ5E54taOinNREyHpJDB3iztzkvuxSD9KY5XuMWZ1k81bX3OL2qwEUDOmcxSZSMdsnuJWh4qvaaqND6qQZJ5wyxR+NLWFiddg5z0NyVjMK+5YED8RWSoJbusWPRoIc3JWMRs9SbB/I6y0eYky/CsBwRyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGekfw8MzdbJesDpC/Us/1cXwD3THQM3gPu5Pa08kbQ=;
 b=fksOmp1Ty4mMQ1aWRZFA3haJWjTLLN+L8OdDS7FwzzZkCUYXpC0yzPMBaCKw/X3DRgGLjUGPzZOnxpJGs1FTs6vgusecJT44l4BwuWHG7EorurCg6Hs+qVBW76+y5y+MYqUTBgRLrWlwdZcaqI3J2bMcAdpuUqg8g198n6IsujA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN8PR13MB2756.namprd13.prod.outlook.com (2603:10b6:408:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 12:17:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Wed, 23 Feb 2022
 12:17:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Topic: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Thread-Index: AQHYJz5fkvZWF2nTREGh+HaYGEm7A6yeNkSAgAA2EQCAAAazAIAACUeAgAAEHICAACQ5AIAA4liAgAB7MoCAAALgAIABCvyA
Date:   Wed, 23 Feb 2022 12:17:04 +0000
Message-ID: <eaf28ee264047b141ce7881361a19379768ee466.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
         <20220221160851.15508-2-trondmy@kernel.org>
         <20220221160851.15508-3-trondmy@kernel.org>
         <20220221160851.15508-4-trondmy@kernel.org>
         <20220221160851.15508-5-trondmy@kernel.org>
         <20220221160851.15508-6-trondmy@kernel.org>
         <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
         <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
         <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
         <b097f18981260e9a2d75f654a5c4f229391bb8bb.camel@hammerspace.com>
         <9DBD587E-C4CA-4674-B47D-92396EEEA082@redhat.com>
         <79a2c935bd5b9044c216c90ebfac3dc2e8e6b888.camel@hammerspace.com>
         <17D70218-EECB-456B-9BCA-E7FC128A4864@redhat.com>
         <4f1963e80028d6c162512465cee403c10fa2ab77.camel@hammerspace.com>
         <1C8B1E6A-F4B2-4ED0-8DF1-5E33E07924C5@redhat.com>
In-Reply-To: <1C8B1E6A-F4B2-4ED0-8DF1-5E33E07924C5@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 611e1345-f015-404b-50cf-08d9f6c6676a
x-ms-traffictypediagnostic: BN8PR13MB2756:EE_
x-microsoft-antispam-prvs: <BN8PR13MB27564376604FC2101BCBF8B1B83C9@BN8PR13MB2756.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhgx5Nvjp6NnyI2eC+kk1o2udhJuh7jhxMjn3zNyFBElOj0MJjancRiS6d0XV1kp2YKX+bNZVybjSj3sPhyvmjjZ0H210EZuWAfUMG4URylzP/CiXU0eYQq4b5BA9yBNHV5QvSEpJcF1BkfvKCeF2/k1lEjKbXa6d1A6tjsU9M6QfwpDXk2Lr0eo8ZeNfy+lJ6eHmZDQc+LkkN58GgjEfApaZ3K9sEmT+gMf8qRxHBoNrbJZ1tn+UB0DT2lN1GiOOGh9pli1fgLAlzUcv+nMCdWN1F9ckVJ+OUN+n1xSLpij5nh9DqVBLoLgOugly6JX2WZ3dB3NL7MN/HBH6TXbagpqQYSgDSGelHlqJYN7ZUKplzxn1hQ7Nw1Lz1GRtl7x2/YF/ItGbSak8Z5NRhvv//qEwlbJg5zDRdFw6Zl7x8j1y8y4ABNmSknh338C4dATQ9NfIKlQTBgdZZMlQcZ2Vx6+5jzt0mqa/XVFMBDOXF7RYNuMYEXf8iQbiKvH87vAN2Z26DuRR9li/6vbB1F5kWNuUrDr2+XLs77G7gnWsOdVZRXTOccDlICl4OewDmXvL1sdK2zyMrshBALAwycACvIWUsvmAG6dr6Lkbkn88bjrQuxD3Z+oT95wVgAL0xVcF/TpObDzRi5QtDWP614Hsh+/fTJAD+bG9ywN5MEMrW6g9LnIMtBEcpdtKwKw7k2Cis1xmvfznYPUdTtBeIgWerAFi0rD8RjzBB3eCUXiXqv5NObVQWErEViw+k94OLwHrPn6kdhx54qyfK/mEiW11/g5iERjqwwCJvt1VmXzKN5ItWVuPnIJQy6vPFFsfs34o4K8zGCOwkjB5QXb6mEnEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6512007)(6506007)(966005)(2616005)(6486002)(71200400001)(86362001)(316002)(122000001)(6916009)(186003)(26005)(508600001)(76116006)(64756008)(66556008)(38070700005)(66946007)(38100700002)(66446008)(66476007)(36756003)(4326008)(83380400001)(5660300002)(8676002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG0xOVRPbytPbE14ZlBabFVCUHlvcm9zMUxsS3ppVjBQME5NUDdKaDZLbGJr?=
 =?utf-8?B?NUovRnlCcGhubU4yTjBDcGZCUTVzckxOSjEwd3luZmtSR0E0aXJUejJubWZu?=
 =?utf-8?B?NzFqc08weWVPN2VJTzFOSGdWSDlZU3BrMHdFTHF4ZE8yQzRMQ21mNC93VTRs?=
 =?utf-8?B?NjBNaHFha3ZzYVc4cDFkNlhOVjUwUTdaNDJVZEFzenl1eFlBTHJGNXMvT2pl?=
 =?utf-8?B?TzdQeldaREdqOGEzM0krQ0s1M00rWEphYjJBQXNFUldKeUUyeXh3dHZFTUVw?=
 =?utf-8?B?MjBxZVBtYURST3lIVW0xN0kxclNtd2U3dlJGMUFhNExBRUFNZUxzelJmRndX?=
 =?utf-8?B?NWlRVzlwRzhzQ1VaZ1pjaW02aUdlTTdwWERvdmFGbTBjd3R6TFA5VHBJVWhB?=
 =?utf-8?B?RGtGTkVsUUxMc3czSGNMWEtNTENacXJRZEhvakp4R0dVQWx2SU9qdTk2c0Jm?=
 =?utf-8?B?aGIxMGgwRjFxOC93ZmVkQVdBcjZjMjhNbndzTjNVK2dCcTYwL1hmQ1BFR21j?=
 =?utf-8?B?dy8rZ2ZSbndlc1BIcUpuTytSTXJGWXN4NUZOaURmYktmV2ZkdHFrWWd5VjE1?=
 =?utf-8?B?ZGVLSUhHWWhSYytwUUw1NTNwK2RJYm40UHl3d3laYU5qUmc0blc4d0t2WVFU?=
 =?utf-8?B?MFZRV2luc04yVUZ0UkxKVit3U2grYTREV25zTHlCQzFYOFcwVmNLVCtOWmYr?=
 =?utf-8?B?UTYzbG5zSnMwNlBHNm55WEMrakVJaXdmYXY0REZES3Fuc3g3OGdGWGFVMDVi?=
 =?utf-8?B?UE8xTHA1L1FxR05ERE1ITHJnc05pcDZIMzRxZzNsQW1nTWRyRGZUQTdGZFdt?=
 =?utf-8?B?UXNnOW5OcHU3UVN6c2o4Z0FuNWdqeHYzSXg5WnQreWlKQ2pqejFYMkZkMFp3?=
 =?utf-8?B?cGxNcjFXWVRma3FpYXYyNzgxTGlRMU9xbDIrK0dSVEZkWERUbldUMjZVVXF6?=
 =?utf-8?B?UlR5MlpZSVovaGIxMWdFTVlZR1hzVkh6cnNhdmFYeHlhQ0xDY09lQmhyenFW?=
 =?utf-8?B?dWNtd1Y0VXhRM09GQyszb041c0lZS25tN0h6ZFNjMU9mZTFySmlhTUs1Mmc1?=
 =?utf-8?B?YWdYVk5KK0JWcVpqdEljN3VDNGYrZVpmL0lla0lHLzlpczZOZnVVSTBTdWVP?=
 =?utf-8?B?dUxYQlZKS0FjbTJXejA0N3lXK2RQMzh3V0JzaEc2VmhCNG1jaEJYTkM4RVRu?=
 =?utf-8?B?OFg0dXAzeVBTY3Q0cTB1WVc1QkhxZnliclV2aWI5bEN4Z1lyVEloekZ2SlFL?=
 =?utf-8?B?a2kyUERpNyt1MEhsUzlNaFFmdU9UYlp3Y0VFOWJ3TjJOTmZsaG9zUjJoL3N2?=
 =?utf-8?B?UW95MTBSbkE2OThpbVRmTEdnOTU2OUxRYzRFdEJkQlAvaFZGYlJFQ0xwNzF2?=
 =?utf-8?B?WmM3RUdtV0h5MldTaGljOUFvMndzd05MNWtPTFdUMW14eGRRUjRYMjk0SFo4?=
 =?utf-8?B?Uy9rNFU0ZjFkNzVibWRvb0FrZ25zd2pORFlMOWlqYXBZWHhDQU44N2Vsb3RS?=
 =?utf-8?B?WTNyYXR1aDlPU3AzRm4vRHJvUTJ3bml6K0Q2dytHQ2N4Q3IwWStmVWVSWjFl?=
 =?utf-8?B?SmJNWU43Y2ZZbkExNVJnaXdWc1Fja3hObURTK3JwM0ZQZmNOOU5PZmszZFBq?=
 =?utf-8?B?Tnk3VUdXME5JZnMxTkNnQkFhRnB0SkVOMnllaFNkL1JjTFdwcHdCaTJlbTBj?=
 =?utf-8?B?Q0VJWkZLWDhHdG1aUGxuWmY0aVQrQXE4bGI1UXBwT0ZPWHJLc1J0NjNGUmJz?=
 =?utf-8?B?OSs5eFNlUXRSN3o5WHhYTnV0MEVZajlnWG9hcVdBczlaaFp3VTQ5QS9LNW1T?=
 =?utf-8?B?T2wyTkcrQXAvOVZIQmlQRWo0YTJKTUoxckJrc1BibzR6SjhrQTVPMHFqSUlh?=
 =?utf-8?B?dGErb2J3U3pIVVRNWXpjTk44WTJZd3pHTTJBYmovT083OWk4UjdrNE91bnlF?=
 =?utf-8?B?cm5POTNkTHhqMG1vQ1JBcDhZeWtrdWZRSVZWS1BLVmJDMHNDWUFIV3RwbWMr?=
 =?utf-8?B?dXBtMWtBNkR6ZEhrTTBadTFwUE1jYmFuUEsyalhuTlZxWGkycXFUZUIyWFJE?=
 =?utf-8?B?WXVLRDRpRS9EVlEreDI5WVNVdUZCNUpYNklZVk5aeHoxYTZsK2QzUGVUZUlU?=
 =?utf-8?B?dGN3UUpWMEo5VmZTd2xKNGdSTWQrQmVUK1ZSN1NqelFJVk5GdmxxR0R0bkpp?=
 =?utf-8?Q?HXjb6kb31Q1Y+UBILSdPxOI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F6829543D28724BA685C729F58477EF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611e1345-f015-404b-50cf-08d9f6c6676a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 12:17:04.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7iaeCkbc3lVV2U0QwcjbTzS+B+JJWvygKI97eKsk8uAsSTGInS0VGpWhZhn4eN1yfwNn45B2zua6ssnwTNR3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTIyIGF0IDE1OjIxIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMiBGZWIgMjAyMiwgYXQgMTU6MTEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gVHVlLCAyMDIyLTAyLTIyIGF0IDA3OjUwIC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMjEgRmViIDIwMjIsIGF0IDE4OjIwLCBUcm9uZCBNeWts
ZWJ1c3Qgd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gT24gTW9uLCAyMDIyLTAyLTIxIGF0IDE2OjEw
IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdyb3RlOg0KPiA+ID4gPiA+IE9uIDIxIEZlYiAy
MDIyLCBhdCAxNTo1NSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBXZSB3aWxsIGFsd2F5cyBuZWVkIHRoZSBhYmlsaXR5IHRvIGN1dCBvdmVyIHRvIHVu
Y2FjaGVkDQo+ID4gPiA+ID4gPiByZWFkZGlyLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFllcy4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElmIHRoZSBjb29raWUgaXMgbm8gbG9uZ2VyIHJldHVy
bmVkIGJ5IHRoZSBzZXJ2ZXIgYmVjYXVzZQ0KPiA+ID4gPiA+ID4gb25lDQo+ID4gPiA+ID4gPiBv
ciBtb3JlDQo+ID4gPiA+ID4gPiBmaWxlcyB3ZXJlIGRlbGV0ZWQgdGhlbiB3ZSBuZWVkIHRvIHJl
c29sdmUgdGhlIHNpdHVhdGlvbg0KPiA+ID4gPiA+ID4gc29tZWhvdyAoSU9XOg0KPiA+ID4gPiA+
ID4gdGhlICdybSAqJyBjYXNlKS4gVGhlIG5ldyBhbGdvcml0aG0gX2RvZXNfIGltcHJvdmUNCj4g
PiA+ID4gPiA+IHBlcmZvcm1hbmNlDQo+ID4gPiA+ID4gPiBvbiB0aG9zZQ0KPiA+ID4gPiA+ID4g
c2l0dWF0aW9ucywgYmVjYXVzZSBpdCBubyBsb25nZXIgcmVxdWlyZXMgdXMgdG8gcmVhZCB0aGUN
Cj4gPiA+ID4gPiA+IGVudGlyZQ0KPiA+ID4gPiA+ID4gZGlyZWN0b3J5IGJlZm9yZSBzd2l0Y2hp
bmcgb3Zlcjogd2UgdHJ5IDUgdGltZXMsIHRoZW4gZmFpbA0KPiA+ID4gPiA+ID4gb3Zlci4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBZZXMsIHVzaW5nIHBlci1wYWdlIHZhbGlkYXRpb24gZG9lc24n
dCByZW1vdmUgdGhlIG5lZWQgZm9yDQo+ID4gPiA+ID4gdW5jYWNoZWQNCj4gPiA+ID4gPiByZWFk
ZGlyLsKgIEl0IGRvZXMgYWxsb3cgYSByZWFkZXIgdG8gc2ltcGx5IHJlc3VtZSBmaWxsaW5nIHRo
ZQ0KPiA+ID4gPiA+IGNhY2hlIHdoZXJlDQo+ID4gPiA+ID4gaXQgbGVmdCBvZmYuwqAgVGhlcmUn
cyBubyBuZWVkIHRvIHRyeSA1IHRpbWVzIGFuZCBmYWlsIG92ZXIuwqANCj4gPiA+ID4gPiBBbmQN
Cj4gPiA+ID4gPiB0aGVyZSdzDQo+ID4gPiA+ID4gbm8gbmVlZCB0byBtYWtlIGEgdHJhZGUtb2Zm
IGFuZCBtYWtlIHRoZSBzaXR1YXRpb24gd29yc2UgaW4NCj4gPiA+ID4gPiBjZXJ0YWluDQo+ID4g
PiA+ID4gc2NlbmFyaW9zLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgdGhvdWdodCBJJ2QgcG9p
bnQgdGhhdCBvdXQgYW5kIG1ha2UgYW4gb2ZmZXIgdG8gcmUtc3VibWl0DQo+ID4gPiA+ID4gaXQu
wqANCj4gPiA+ID4gPiBBbnkNCj4gPiA+ID4gPiBpbnRlcmVzdD8NCj4gPiA+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IEFzIEkgcmVjYWxsLCBJIGhhZCBjb25jZXJucyBhYm91dCB0aGF0IGFwcHJv
YWNoLiBDYW4geW91DQo+ID4gPiA+IGV4cGxhaW4NCj4gPiA+ID4gYWdhaW4NCj4gPiA+ID4gaG93
IGl0IHdpbGwgd29yaz8NCj4gPiA+IA0KPiA+ID4gRXZlcnkgcGFnZSBvZiByZWFkZGlyIHJlc3Vs
dHMgaGFzIHRoZSBkaXJlY3RvcnkncyBjaGFuZ2UgYXR0cg0KPiA+ID4gc3RvcmVkDQo+ID4gPiBv
biB0aGUNCj4gPiA+IHBhZ2UuwqAgVGhhdCwgYWxvbmcgd2l0aCB0aGUgcGFnZSdzIGluZGV4IGFu
ZCB0aGUgZmlyc3QgY29va2llIGlzDQo+ID4gPiBlbm91Z2gNCj4gPiA+IGluZm9ybWF0aW9uIHRv
IGRldGVybWluZSBpZiB0aGUgcGFnZSdzIGRhdGEgY2FuIGJlIHVzZWQgYnkNCj4gPiA+IGFub3Ro
ZXINCj4gPiA+IHByb2Nlc3MuDQo+ID4gPiANCj4gPiA+IFdoaWNoIG1lYW5zIHRoYXQgd2hlbiB0
aGUgcGFnZWNhY2hlIGlzIGRyb3BwZWQsIGZpbGxlcnMgZG9uJ3QNCj4gPiA+IGhhdmUgdG8NCj4g
PiA+IHJlc3RhcnQNCj4gPiA+IGZpbGxpbmcgdGhlIGNhY2hlIGF0IHBhZ2UgaW5kZXggMCwgdGhl
eSBjYW4gY29udGludWUgdG8gZmlsbCBhdA0KPiA+ID4gd2hhdGV2ZXINCj4gPiA+IGluZGV4IHRo
ZXkgd2VyZSBhdCBwcmV2aW91c2x5LsKgIElmIGFub3RoZXIgcHJvY2VzcyBmaW5kcyBhIHBhZ2UN
Cj4gPiA+IHRoYXQNCj4gPiA+IGRvZXNuJ3QNCj4gPiA+IG1hdGNoIGl0cyBwYWdlIGluZGV4LCBj
b29raWUsIGFuZCB0aGUgY3VycmVudCBkaXJlY3RvcnkncyBjaGFuZ2UNCj4gPiA+IGF0dHIsIHRo
ZQ0KPiA+ID4gcGFnZSBpcyBkcm9wcGVkIGFuZCByZWZpbGxlZCBmcm9tIHRoYXQgcHJvY2Vzcycg
aW5kZXhpbmcuDQo+ID4gPiANCj4gPiA+ID4gQSBmZXcgb2YgdGhlIGNvbmNlcm5zIEkgaGF2ZSBy
ZXZvbHZlIGFyb3VuZA0KPiA+ID4gPiB0ZWxsZGlyKCkvc2Vla2RpcigpLiBJZg0KPiA+ID4gPiB0
aGUNCj4gPiA+ID4gcGxhdGZvcm0gaXMgMzItYml0LCB0aGVuIHdlIGNhbm5vdCB1c2UgY29va2ll
cyBhcyB0aGUgdGVsbGRpcigpDQo+ID4gPiA+IG91dHB1dCwNCj4gPiA+ID4gYW5kIHNvIG91ciBv
bmx5IG9wdGlvbiBpcyB0byB1c2Ugb2Zmc2V0cyBpbnRvIHRoZSBwYWdlIGNhY2hlDQo+ID4gPiA+
ICh0aGlzDQo+ID4gPiA+IGlzDQo+ID4gPiA+IHdoeSB0aGlzIHBhdGNoIGNhcnZlcyBvdXQgYW4g
ZXhjZXB0aW9uIGlmIGRlc2MtPmRpcl9jb29raWUgPT0NCj4gPiA+ID4gMCkuDQo+ID4gPiA+IEhv
dw0KPiA+ID4gPiB3b3VsZCB0aGF0IHdvcmsgd2l0aCB5b3Ugc2NoZW1lPw0KPiA+ID4gDQo+ID4g
PiBGb3IgMzItYml0IHNlZWtkaXIsIHBhZ2VzIGFyZSBmaWxsZWQgc3RhcnRpbmcgYXQgaW5kZXgg
MC7CoCBUaGlzDQo+ID4gPiBpcw0KPiA+ID4gdmVyeQ0KPiA+ID4gdW5saWtlbHkgdG8gbWF0Y2gg
b3RoZXIgcmVhZGVycyAodW5sZXNzIHRoZXkgYWxzbyBkbyB0aGUgX3NhbWVfDQo+ID4gPiBzZWVr
ZGlyKS4NCj4gPiA+IA0KPiA+ID4gPiBFdmVuIGluIHRoZSA2NC1iaXQgY2FzZSB3aGVyZSBhcmUg
YWJsZSB0byB1c2UgY29va2llcyBmb3INCj4gPiA+ID4gdGVsbGRpcigpL3NlZWtkaXIoKSwgaG93
IGRvIHdlIGRldGVybWluZSBhbiBhcHByb3ByaWF0ZSBwYWdlDQo+ID4gPiA+IGluZGV4DQo+ID4g
PiA+IGFmdGVyIGEgc2Vla2RpcigpPw0KPiA+ID4gDQo+ID4gPiBXZSBkb24ndC7CoCBJbnN0ZWFk
IHdlIHN0YXJ0IGZpbGxpbmcgYXQgaW5kZXggMC7CoCBBZ2FpbiwgdGhlDQo+ID4gPiBwYWdlY2Fj
aGUNCj4gPiA+IHdpbGwNCj4gPiA+IG9ubHkgYmUgdXNlZnVsIHRvIG90aGVyIHByb2Nlc3NlcyB0
aGF0IGhhdmUgZG9uZSB0aGUgc2FtZSBsbHNlZWsuDQo+ID4gPiANCj4gPiA+IFRoaXMgYXBwcm9h
Y2ggb3B0aW1pemVzIHRoZSBwYWdlY2FjaGUgZm9yIHByb2Nlc3NlcyB0aGF0IGFyZQ0KPiA+ID4g
ZG9pbmcNCj4gPiA+IHNpbWlsYXINCj4gPiA+IHdvcmssIGFuZCBoYXMgdGhlIGFkZGVkIGJlbmVm
aXQgb2Ygc2NhbGluZyB3ZWxsIGZvciBsYXJnZQ0KPiA+ID4gZGlyZWN0b3J5DQo+ID4gPiBsaXN0
aW5ncw0KPiA+ID4gdW5kZXIgbWVtb3J5IHByZXNzdXJlLsKgIEFsc28gYSBudW1iZXIgb2YgY2xh
c3NlcyBvZiBkaXJlY3RvcnkNCj4gPiA+IG1vZGlmaWNhdGlvbnMNCj4gPiA+IChzdWNoIGFzIHJl
bmFtZXMsIG9yIGluc2VydGlvbnMvZGVsZXRpb25zIGF0IGxvY2F0aW9ucyBhIHJlYWRlcg0KPiA+
ID4gaGFzDQo+ID4gPiBtb3ZlZA0KPiA+ID4gYmV5b25kKSBhcmUgbm8gbG9uZ2VyIGEgcmVhc29u
IHRvIHJlLWZpbGwgdGhlIHBhZ2VjYWNoZSBmcm9tDQo+ID4gPiBzY3JhdGNoLg0KPiA+ID4gDQo+
ID4gDQo+ID4gT0ssIHlvdSd2ZSBnb3QgbWUgbW9yZSBvciBsZXNzIHNvbGQgb24gaXQuDQo+ID4g
DQo+ID4gSSdkIHN0aWxsIGxpa2UgdG8gZmlndXJlIG91dCBob3cgdG8gaW1wcm92ZSB0aGUgcGVy
Zm9ybWFuY2UgZm9yDQo+ID4gc2Vla2Rpcg0KPiA+IChzaW5jZSBJIGRvIGhhdmUgYW4gaW50ZXJl
c3QgaW4gcmUtZXhwb3J0aW5nIE5GUykgYnV0IEkndmUgYmVlbg0KPiA+IHBsYXlpbmcNCj4gPiBh
cm91bmQgd2l0aCBhIGNvdXBsZSBvZiBwYXRjaGVzIHRoYXQgaW1wbGVtZW50IHlvdXIgY29uY2Vw
dCBhbmQNCj4gPiB0aGV5IGRvDQo+ID4gc2VlbSB0byB3b3JrIHdlbGwgZm9yIHRoZSBjb21tb24g
Y2FzZSBvZiBhIGxpbmVhciByZWFkIHRocm91Z2ggdGhlDQo+ID4gZGlyZWN0b3J5Lg0KPiANCj4g
TmljZS7CoCBJIGhhdmUgYW5vdGhlciB2ZXJzaW9uIGZyb20gdGhlIG9uZSBJIG9yaWdpbmFsbHkg
cG9zdGVkOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1uZnMvY292ZXIuMTYxMTE2
MDEyMC5naXQuYmNvZGRpbmdAcmVkaGF0LmNvbS8NCj4gDQo+IC4uIGJ1dCBJIGRvbid0IHJlbWVt
YmVyIGV4YWN0bHkgdGhlIGNoYW5nZXMgYW5kIGl0IG5lZWRzIHJlYmFzaW5nLsKgDQo+IFNob3Vs
ZCBJDQo+IHJlYmFzZSBpdCBhZ2FpbnN0IHlvdXIgdGVzdGluZyBicmFuY2ggYW5kIHNlbmQgdGhl
IHJlc3VsdD8NCg0KTXkgMiBwYXRjaGVzIGRpZCBzb21ldGhpbmcgc2xpZ2h0bHkgZGlmZmVyZW50
IHRvIHlvdXJzLCBzdG9yaW5nIHRoZQ0KY2hhbmdlIGF0dHJpYnV0ZSBpbiB0aGUgYXJyYXkgaGVh
ZGVyIGluc3RlYWQgb2YgaW4gcGFnZV9wcml2YXRlLiBUaGF0DQptYWtlcyBmb3IgYSBzbGlnaHRs
eSBzbWFsbGVyIGNoYW5nZS4NCg0KSGF2aW5nIGZ1cnRoZXIgc2xlcHQgb24gdGhlIGlkZWEsIEkg
dGhpbmsgSSBrbm93IGhvdyB0byBzb2x2ZSB0aGUNCnNlZWtkaXIoKSBpc3N1ZSwgYXQgbGVhc3Qg
Zm9yIHRoZSBjYXNlcyB3aGVyZSB3ZSBjYW4gdXNlIGNvb2tpZXMgYXMNCnRlbGxkaXIoKS9zZWVr
ZGlyKCkgb2Zmc2V0cy4gSWYgd2UgZGl0Y2ggdGhlIGxpbmVhciBpbmRleCwgYW5kIGluc3RlYWQN
CnVzZSBhIGhhc2ggb2YgdGhlIGRlc2MtPmxhc3RfY29va2llIGFzIHRoZSBpbmRleCwgdGhlbiB3
ZSBjYW4gbWFrZQ0KcmFuZG9tIGFjY2VzcyB0byB0aGUgZGlyZWN0b3JpZXMgd29yayB3aXRoIHlv
dXIgaWRlYS4NClRoZXJlIGFyZSBhIGNvdXBsZSBvZiBmdXJ0aGVyIHByb2JsZW1zIHdpdGggdGhp
cyBjb25jZXB0LCBidXQgSSB0aGluaw0KdGhvc2UgYXJlIHNvbHZhYmxlLiBUaGUgaXNzdWVzIEkg
aGF2ZSBpZGVudGlmaWVkIHNvIGZhciBhcmU6DQoNCiAqIGludmFsaWRhdGVfaW5vZGVfcGFnZXMy
X3JhbmdlKCkgbm8gbG9uZ2VyIHdvcmtzIHRvIGNsZWFyIG91dCB0aGUNCiAgIHBhZ2UgY2FjaGUg
aW4gYSBwcmVkaWN0YWJsZSB3YXkgZm9yIHRoZSByZWFkZGlycGx1cyBoZXVyaXN0aWMuDQogKiBk
dXBsaWNhdGUgY29va2llIGRldGVjdGlvbiBuZWVkcyB0byBiZSBjaGFuZ2VkLg0KDQpJIHRoaW5r
IHRob3NlIGFyZSBzb2x2YWJsZSBwcm9ibGVtcy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QgTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0K
