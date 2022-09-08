Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B65B238B
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiIHQZi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIHQZc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 12:25:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2118.outbound.protection.outlook.com [40.107.244.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFEB7DF55
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 09:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkqcEv7lujcMqLeEWuvjxql9hXoIu8MrbmmvRvosC70qPTQjLENmfQv9jb4uzvxnvU7JIeqOL4sxdNfEQifun/3daHyWQ010ZQnGIpxWH27R9CUj4AeWIhHhZlCNBe/ELWsq0o8Pp606CuWBpLULB/jJ10aBHdfs9HjauiRxnqDGTw/QNv+up6IBpPz0bvyaRLgpwo5+30VowIfkjAAYjn3cmxRldCxVlT9sQFYZ12WC3BZCbQItyIsio84fFhD6Yv/lS5OkEtplY/sqcAwsjsCxP4SkgSqYgrpPGJWKYmba5XN30/7TE+C3dWtSLb+JAPZ+gosIKnrNnA5e/btHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVYdbNuMgMIfs6EudMHSJS1u9I5IYd8EMwBUp1u+TQY=;
 b=kcVs+9bOXaeNFaJ2V41YgS5UTN+GBAy8hVSIegwMwvgCMaf7AynCxIpAN4ee91l9ttkb6iNhFbva0Zx0W3woOEFiemDZCW6P3eGET3T4VPKzQF/xkOIdLSetHktgq0Srj/3xcSO/eEWokBJw9I2jBvXeLlQCLXBsQbwHkDYDP2xzgue+4lQ69ErLQjmql0A+X+hlA29Qfoy0+au4OVcfpitRBdqBsIrYrgtynK7P2PwMzhXXTpPtVONNrGU4G13C/k6OgTxrNgAJvV9LxawSaTxsoRXzZeAAmWdBzEbbnHbAf0vlMLriAmrEf8TIjq2U594mwi7zl2yLUwIqRSjddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVYdbNuMgMIfs6EudMHSJS1u9I5IYd8EMwBUp1u+TQY=;
 b=AAN1XtB/iwyxEVAhT6Bz+liTqiexnv9jBvl4fgKB7XXDggb3CbTgN0s1fGRENM9LcItOFdy0kDXAaRPVOT5soeKZcQxH6/d31ZQBOE+Rnz5vNUp+BPiQtd8IVAS//HcBdLA7i7do3mlPEjC1Mz5cjICjmSvT4kjWoqS3FWAlAo4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB3981.namprd13.prod.outlook.com (2603:10b6:806:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 16:25:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 16:25:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYwvN1RpiF6zCX3UGMD/I7WdRkFq3UaziAgAACIoCAAAPjgIAAHHkAgAEd8gCAAA2lAA==
Date:   Thu, 8 Sep 2022 16:25:28 +0000
Message-ID: <883e90539f1df508ca973279be48d5999aab8c70.camel@hammerspace.com>
References: <20220907195259.926736-1-anna@kernel.org>
         <20220907195259.926736-2-anna@kernel.org>
         <06EA863F-8C11-4342-8D88-954E99A07598@oracle.com>
         <CAFX2JfnNa80uhdeg=8YMiVWQGimkC7VrPHORjB=8SyOVw35Z_g@mail.gmail.com>
         <9DE01D1A-9328-4F10-9E9B-9A788E1F249E@oracle.com>
         <8141d61fbff18bf2632ae7fd9506618fd42c7f1d.camel@hammerspace.com>
         <6BFC6BB6-732D-4832-8B83-2F8FB33E84F3@oracle.com>
In-Reply-To: <6BFC6BB6-732D-4832-8B83-2F8FB33E84F3@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA0PR13MB3981:EE_
x-ms-office365-filtering-correlation-id: 77fe386c-8c4b-49a6-0acc-08da91b6bdfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXm1bYnKml/HFIVR3B2qN+zh2QUeFrP3tVf+SNfKF+JrJnceXrtapfviXmoxXdQP4GA1MxSlECtCFJ5Yvfh4CGSGqnpRStXjHC5uV+L6DSC2zv7f6iEKyh++JKImUVZCGqWn5HECdYcuZY1oNjbHWXjWTf7jcIwClXQKuvzpil171rcx2EaE88avNk0U0hA1TOHtp3Wh3lnSsNBOne9yuYYgU1Zl6F4ms/WGoSoeb4OVjKsJrkmh6R52NRwFXNDIkTk2qjEzu1hqhq1ZtPWfnQoUOhtXMKvwim9P/vk9c7aYBlVlWoFn2+mHabeMKSt7jjWium+5nEw3PjT+NnIOEzwVZpEJczANJJz0IJi9VpDJD+DMu6K4gGlm6356w20lC+61tmcHEj1L0q9klD2b66Osg7WzCdIeIyzaUY21hbvZTK+Rpmr49bpILd4uhZrdYZ8Pr7Of+8uRbnAR7xFZ8Xns+DVHs+vT+w14s/C62W6Ux6af/nEUdPgOOm+Jm+sZoajuQIaaCN1NSFOh85E+lItICpNzOcs9h94b6/L2L1sBrKvTuMMi6CrbCS6l+rzE+R2E8kCUS6tVPzDvQNbljaPD2008cMvE8cFe6cFZP2iA2Yr1x0+ekJJI/IrDqqx7OCyNOogIBvbckHyhWDqL3L5D3Jcqo1juGwBceXQ7p9SzoUj//C1w1VJX30zmFAC4y6AwsJ43IssJkI/e0XSz2v4pF1pTnL59PE9pGU16TwDKVURyPEQREdxbHHHNzZyv96V9EM9lCLtJVlsSVcKM9Wcb50ptnAcXy3FB4t+41MgbLe7z18+C8I0hORGUJumM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(39850400004)(346002)(8676002)(41300700001)(71200400001)(478600001)(6506007)(53546011)(6512007)(26005)(66556008)(66476007)(66446008)(2906002)(76116006)(86362001)(54906003)(36756003)(6916009)(316002)(38070700005)(6486002)(186003)(38100700002)(66946007)(2616005)(5660300002)(122000001)(64756008)(8936002)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVlPMUpKcnplaENJOFBZdkU1WVBKTWQxdlFGaFRQRVkxNk80SE8wU1RDcS94?=
 =?utf-8?B?eFJtdmJLK2ZkQmtNUEcxZkRrKzNnbWNLNjNLYXdQZlF2dWpZdit1WlZidDhV?=
 =?utf-8?B?RHQ2TEVmQm84bUI3S0pMUTQzRTg3NHZoNzJXalFQMVMvUFNHYmdTVFloaDVG?=
 =?utf-8?B?UjRKdW9SeWJEci9IdVAzS0hHZVNoWXRqSGIyN1BXOGkxTmZYalg4aHM3N1Vu?=
 =?utf-8?B?RHpDcmdEM0pZNU9tYlZYTHdWTCtnTDFJbmZPcUErQ3RNVlRpcTlWRytpTm1P?=
 =?utf-8?B?bWFuNDZ6TlIrRXVFNnJqYkxQMU1yd1ZNMUEyTUNXdUJ3ZUhGTnlFWWQ2Q1d1?=
 =?utf-8?B?YWRzUGNpcUxhRmExei9vRDU5U0JudlRvTU8zVFNCR2ppYmJVNnRkUDNVajhN?=
 =?utf-8?B?UlJvSFhSWjJQR1hnQkFGd2xCcjQ3MTZpWUhUTkZ2aHJrTDBCTGNXbEM5TytR?=
 =?utf-8?B?d1FpUElWOEh1cmp0TlRublM3TzZNMlZMQjFmdWNKKy83MXFxNHdhUGtManY4?=
 =?utf-8?B?TlRzSGZoVHEwblEvWTBVUVNLbDZNNm5lZHlVREVBOGc2V2xGVzFIOStLVy9Q?=
 =?utf-8?B?dVlGWXRIbXlWZFVoM3d1cEUwVm5rYnlNQzg2R1NSZkJFNGw4VVZBRFE5bHhl?=
 =?utf-8?B?UlJXWUdwbWdkNFpwdlU2dlFDaHp3VXRTOVArK3phUmZnMksreGZNNkxGMnEw?=
 =?utf-8?B?Z1hpWm4yU0s1cFAyd0pCRXY1MjRoam4xT0VweWdyVk1pLzQyQm8zYmJnVGJl?=
 =?utf-8?B?VTlxN0xxN1BIcjZRMHZmV3hIWUVCUG9oY3NaS2lHWUJZMmR2REdsdUdhcFNF?=
 =?utf-8?B?WjJjTmpGL3hJQzBJMXRBWEV4QmhsaitPT3lsM0hRNWhKZmhLeFY4U3laK2Nr?=
 =?utf-8?B?WmNEZkVWYnpJK1lxdVpMVnJaOFM2UG9XQ2NCTlM5eGtDVVIvcmFGdzArMS9T?=
 =?utf-8?B?aWxBUjJNbGxERkZNRjFkNmY2VlBORkM5NmptRUJsdnByTkNNQStJUWFlaGhE?=
 =?utf-8?B?akVPZGRCR2xZNnBiZ3RmUUt4WU9NdTVVQ1Z4NzAraXB1SnZsUTZYNlBkMjJy?=
 =?utf-8?B?cSsxUXNsV01vYXMrU0hpQ1Aybkkvd2NKaDZTdHBFSzN1RVl4NHpuUG9RMC8x?=
 =?utf-8?B?VEFPZGRjNUZ1MlpnTHROL2ZkcDBsMVY3OENGa1BtVzZpUzZVNXpRQ3BBdmNI?=
 =?utf-8?B?N3FzVUZyWExsZHB3K21VV251UktPS0lubXNSR3FOUDNTQ3hvRGNEVEpFTUxD?=
 =?utf-8?B?NDdTU2xxYW5LNHJhekd0RE9zZFpmTlR6SFRvOEh3TmVIQytFMUdZcTNONFd6?=
 =?utf-8?B?U3hPUWNTbVNNWFFIb1lUYjUxTEU5UGpDWXVDb2kwUXZrckZHWkZTeFZKbDlr?=
 =?utf-8?B?U0h2T0FTTWVJTWNya1Q2dVZodGM1MnVyM3BZRkVPUXNDakZOUForMWdMd2l5?=
 =?utf-8?B?RmlnMXMxQmFSSDMwOHpHdFRzZ1U5bVJ1WWRoL292RnQ3OGt4cmF5eGpkeGFh?=
 =?utf-8?B?N3VtRjFCZ1c3T1h1ME81U3hpQ3VmVWtMUlM3Rnl3MmVGblFUVFBtbGY1ZVJW?=
 =?utf-8?B?MFJ3QVZrRkFOcmhKZmpwMlRxVXNRZ3lDVHpsYk9uVGZPQ2JzNEZLSTc2cjlU?=
 =?utf-8?B?TXFmT0dkM3JzT2xRZFRYQmdrWklDcHBpelVWSDRPRHJWZ1hCQmJkaE4rb0Q0?=
 =?utf-8?B?bmZCUXJrMFc5RTY1d0t1dGNqUFJ2anNHNUlDcEtVc2QyV0VSaWp0UUJRNVZG?=
 =?utf-8?B?V1p6VVNJTWlaa2tXaStXcVFVN1lSZGVkZ1p5T0lOUDR0VHVWS25zKzVFbHhN?=
 =?utf-8?B?cDJTQVBzVWViR3FSNE5KUHlhU2x0VVFJYkEzL1Zma1JERzYyUlA4YnBZeUww?=
 =?utf-8?B?NmE4UmI2Z3FjUnYza0s2Z2VSdmRjYmNuNWNtcDlvSElkemh2cjY1Qko3RGJo?=
 =?utf-8?B?NkxGYlovcnI4Q3JxbDV5eGZocHdUTXJ3b2N3RW0rTEdLeFp1UmJJOHcrQlVI?=
 =?utf-8?B?OGY3ZEl0LzkrUUNKQU0wdW5hblkyU1R1TUhtYkJDT2dXeWcvTkhRaFNJbU9j?=
 =?utf-8?B?Q1dyR2ZzWkh4VVU2RTZrWk1ld09zbFJDcHNkaW9XMmRzb2N4T3JUTGlGWXoz?=
 =?utf-8?B?MHFjNCt0aiszMUV0Rll1dkF3WEdNS09MNlhpay9IUHJDV05Vbm5ld2ROSnBL?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03EF6F989BD8024793E10FB8B470EF0C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTA4IGF0IDE1OjM2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBTZXAgNywgMjAyMiwgYXQgNjozMyBQTSwgVHJvbmQgTXlrbGVidXN0
DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQs
IDIwMjItMDktMDcgYXQgMjA6NTEgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiA+
IA0KPiA+ID4gDQo+ID4gPiA+IE9uIFNlcCA3LCAyMDIyLCBhdCA0OjM3IFBNLCBBbm5hIFNjaHVt
YWtlciA8YW5uYUBrZXJuZWwub3JnPg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+
IE9uIFdlZCwgU2VwIDcsIDIwMjIgYXQgNDoyOSBQTSBDaHVjayBMZXZlciBJSUkNCj4gPiA+ID4g
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJl
IHN1cmUgdG8gQ2M6IEplZmYgb24gdGhlc2UuIFRoYW5rcyENCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IE9uIFNlcCA3LCAyMDIyLCBhdCAzOjUyIFBNLCBBbm5hIFNjaHVtYWtl
cg0KPiA+ID4gPiA+ID4gPGFubmFAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFr
ZXJATmV0YXBwLmNvbT4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQ2h1Y2sgaGFkIHN1Z2dl
c3RlZCByZXZlcnRpbmcgUkVBRF9QTFVTIHNvIGl0IHJldHVybnMgYQ0KPiA+ID4gPiA+ID4gc2lu
Z2xlDQo+ID4gPiA+ID4gPiBEQVRBDQo+ID4gPiA+ID4gPiBzZWdtZW50IGNvdmVyaW5nIHRoZSBy
ZXF1ZXN0ZWQgcmVhZCByYW5nZS4gVGhpcyBwcmVwYXJlcw0KPiA+ID4gPiA+ID4gdGhlDQo+ID4g
PiA+ID4gPiBzZXJ2ZXIgZm9yDQo+ID4gPiA+ID4gPiBhIGZ1dHVyZSAic3BhcnNlIHJlYWQiIGZ1
bmN0aW9uIHNvIHN1cHBvcnQgY2FuIGVhc2lseSBiZQ0KPiA+ID4gPiA+ID4gYWRkZWQNCj4gPiA+
ID4gPiA+IHdpdGhvdXQNCj4gPiA+ID4gPiA+IG5lZWRpbmcgdG8gcmlwIG91dCB0aGUgb2xkIFJF
QURfUExVUyBjb2RlIGF0IHRoZSBzYW1lIHRpbWUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAuY29t
Pg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiBmcy9uZnNkL25mczR4ZHIuYyB8IDEzOSAr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiA+ID4gLS0tLQ0KPiA+
ID4gPiA+ID4gLS0tLS0tLQ0KPiA+ID4gPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlv
bnMoKyksIDEwNyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2ZzL25mc2QvbmZzNHhkci5jIGIvZnMvbmZzZC9uZnM0eGRyLmMNCj4gPiA+ID4gPiA+
IGluZGV4IDFlOTY5MGEwNjFlYy4uYmNjOGMzODVmYWYyIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0t
IGEvZnMvbmZzZC9uZnM0eGRyLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2ZzL25mc2QvbmZzNHhkci5j
DQo+ID4gPiA+ID4gPiBAQCAtNDczMSw3OSArNDczMSwzNyBAQCBuZnNkNF9lbmNvZGVfb2ZmbG9h
ZF9zdGF0dXMoc3RydWN0DQo+ID4gPiA+ID4gPiBuZnNkNF9jb21wb3VuZHJlcyAqcmVzcCwgX19i
ZTMyIG5mc2VyciwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gc3RhdGljIF9fYmUzMg0KPiA+
ID4gPiA+ID4gbmZzZDRfZW5jb2RlX3JlYWRfcGx1c19kYXRhKHN0cnVjdCBuZnNkNF9jb21wb3Vu
ZHJlcyAqcmVzcCwNCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG5mc2Q0X3JlYWQgKnJlYWQsDQo+ID4gPiA+ID4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGxvbmcgKm1heGNvdW50LCB1MzINCj4gPiA+ID4gPiA+ICplb2YsDQo+ID4gPiA+ID4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvZmZfdCAqcG9z
KQ0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgbmZzZDRfcmVhZCAqcmVhZCkNCj4gPiA+ID4gPiA+IHsNCj4gPiA+ID4g
PiA+IC3CoMKgwqDCoCBzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyID0gcmVzcC0+eGRyOw0KPiA+ID4g
PiA+ID4gK8KgwqDCoMKgIGJvb2wgc3BsaWNlX29rID0gdGVzdF9iaXQoUlFfU1BMSUNFX09LLCAm
cmVzcC0+cnFzdHAtDQo+ID4gPiA+ID4gPiA+IHJxX2ZsYWdzKTsNCj4gPiA+ID4gPiA+IMKgwqDC
oMKgIHN0cnVjdCBmaWxlICpmaWxlID0gcmVhZC0+cmRfbmYtPm5mX2ZpbGU7DQo+ID4gPiA+ID4g
PiAtwqDCoMKgwqAgaW50IHN0YXJ0aW5nX2xlbiA9IHhkci0+YnVmLT5sZW47DQo+ID4gPiA+ID4g
PiAtwqDCoMKgwqAgbG9mZl90IGhvbGVfcG9zOw0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgIF9fYmUz
MiBuZnNlcnI7DQo+ID4gPiA+ID4gPiAtwqDCoMKgwqAgX19iZTMyICpwLCB0bXA7DQo+ID4gPiA+
ID4gPiAtwqDCoMKgwqAgX19iZTY0IHRtcDY0Ow0KPiA+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ID4g
LcKgwqDCoMKgIGhvbGVfcG9zID0gcG9zID8gKnBvcyA6IHZmc19sbHNlZWsoZmlsZSwgcmVhZC0N
Cj4gPiA+ID4gPiA+ID5yZF9vZmZzZXQsDQo+ID4gPiA+ID4gPiBTRUVLX0hPTEUpOw0KPiA+ID4g
PiA+ID4gLcKgwqDCoMKgIGlmIChob2xlX3BvcyA+IHJlYWQtPnJkX29mZnNldCkNCj4gPiA+ID4g
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKm1heGNvdW50ID0gbWluX3QodW5zaWduZWQg
bG9uZywgKm1heGNvdW50LA0KPiA+ID4gPiA+ID4gaG9sZV9wb3MgLSByZWFkLT5yZF9vZmZzZXQp
Ow0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgICptYXhjb3VudCA9IG1pbl90KHVuc2lnbmVkIGxvbmcs
ICptYXhjb3VudCwgKHhkci0NCj4gPiA+ID4gPiA+ID5idWYtDQo+ID4gPiA+ID4gPiA+IGJ1Zmxl
biAtIHhkci0+YnVmLT5sZW4pKTsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgeGRyX3N0
cmVhbSAqeGRyID0gcmVzcC0+eGRyOw0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHVuc2lnbmVkIGxv
bmcgbWF4Y291bnQ7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqAgX19iZTMyIG5mc2VyciwgKnA7DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IMKgwqDCoMKgIC8qIENvbnRlbnQgdHlwZSwgb2Zmc2V0
LCBieXRlIGNvdW50ICovDQo+ID4gPiA+ID4gPiDCoMKgwqDCoCBwID0geGRyX3Jlc2VydmVfc3Bh
Y2UoeGRyLCA0ICsgOCArIDQpOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqAgaWYgKCFwKQ0KPiA+ID4g
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbmZzZXJyX3Jlc291cmNlOw0K
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbmZzZXJyX2lvOw0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdvdWxkbid0IG5mc2Vycl9yZXBfdG9vX2JpZyBiZSBhIG1v
cmUgYXBwcm9wcmlhdGUgc3RhdHVzIGZvcg0KPiA+ID4gPiA+IHJ1bm5pbmcNCj4gPiA+ID4gPiBv
ZmYgdGhlIGVuZCBvZiB0aGUgc2VuZCBidWZmZXI/IEknbSBub3QgMTAwJSBzdXJlLCBidXQgSQ0K
PiA+ID4gPiA+IHdvdWxkDQo+ID4gPiA+ID4gZXhwZWN0DQo+ID4gPiA+ID4gdGhhdCBleGhhdXN0
aW5nIHNlbmQgYnVmZmVyIHNwYWNlIHdvdWxkIGltcGx5IHRoZSByZXBseSBoYXMNCj4gPiA+ID4g
PiBncm93bg0KPiA+ID4gPiA+IHRvbw0KPiA+ID4gPiA+IGxhcmdlLg0KPiA+ID4gPiANCj4gPiA+
ID4gSSBjYW4gc3dpdGNoIGl0IHRvIHRoYXQsIG5vIHByb2JsZW0uDQo+ID4gPiANCj4gPiA+IEkg
d291bGQgbGlrZSB0byBoZWFyIG9waW5pb25zIGZyb20gcHJvdG9jb2wgZXhwZXJ0cyBiZWZvcmUg
d2UgZ28NCj4gPiA+IHdpdGggdGhhdCBjaG9pY2UuDQo+ID4gDQo+ID4gSSdkIGFncmVlIHRoYXQg
TkZTNEVSUl9SRVBfVE9PX0JJRyBpcyBjb3JyZWN0IGlmIHlvdSdyZSBub3QgYWJsZSB0bw0KPiA+
IGV2ZW4gcmV0dXJuIGEgc2hvcnQgcmVhZC4gSG93ZXZlciBpZiB5b3UgY2FuIHJldHVybiBhIHNo
b3J0IHJlYWQsDQo+ID4gdGhlbg0KPiA+IHRoYXQncyBiZXR0ZXIgdGhhbiByZXR1cm5pbmcgYW4g
ZXJyb3IuDQo+IA0KPiBNYW55IHRoYW5rcyBmb3IgcmV2aWV3aW5nIQ0KPiANCj4gSW4gZ2VuZXJh
bCwgSSBtaWdodCB3YW50IHRvIGNvbnZlcnQgYWxsIE5GU3Y0IGVuY29kZXJzIHRvIHJldHVybg0K
PiBlaXRoZXIgUkVTT1VSQ0Ugb3IgUkVQX1RPT19CSUcgd2hlbiB4ZHJfcmVzZXJ2ZV9zcGFjZSgp
IGZhaWxzLiBJDQo+IGNhbiBwb3N0IGEgcGF0Y2ggb3IgdHdvIHRoYXQgbWFrZXMgdGhhdCBhdHRl
bXB0IHNvIHRoZSBzcGVjaWFsDQo+IGNhc2VzIGNhbiBiZSBzb3J0ZWQgb24gdGhlIG1haWxpbmcg
bGlzdC4NCj4gDQo+IA0KPiA+IEl0IGxvb2tzIHRvIG1lIGFzIGlmIHRoaXMgZnVuY3Rpb24gY2Fu
IGJpdCBoaXQgaW4gYm90aCBjYXNlcywgc28NCj4gPiBwZXJoYXBzIHNvbWUgY2FyZSBpcyBpbiBv
cmRlci4NCj4gDQo+IEludHJpZ3VpbmcgaWRlYS4NCj4gDQo+IEZvciBSRUFELCBpZiB4ZHJfcmVz
ZXJ2ZV9zcGFjZSgpIGZhaWxzLCB0aGF0J3MgYWxsIHNoZSB3cm90ZS4NCj4gSSB0aGluayBhbGwg
dGhlc2UgY2FsbHMgaGFwcGVuIGJlZm9yZSB0aGUgZGF0YSBwYXlsb2FkIGlzIGVuY29kZWQuDQo+
IA0KPiBGb3IgUkVBRF9QTFVTLCBpZiB4ZHJfcmVzZXJ2ZV9zcGFjZSgpIGZhaWxzLCBpdCBtaWdo
dCBiZSBwb3NzaWJsZQ0KPiB0byB1c2UgeGRyX3RydW5jYXRlX2VuY29kZSgpIG9yIHNpbXBseSBz
dGFydCBvdmVyIHdpdGggYSBsaW1pdCBvbg0KPiB0aGUgbnVtYmVyIG9mIHNlZ21lbnRzIHRvIGJl
IGVuY29kZWQuIFdlJ3JlIG5vdCByZWFsbHkgdGhlcmUgeWV0LA0KPiBhcyBjdXJyZW50bHkgd2Ug
d2FudCB0byByZXR1cm4ganVzdCBhIHNpbmdsZSBzZWdtZW50IGF0IHRoaXMNCj4gcG9pbnQuDQo+
IA0KPiBJIGZlZWwgdGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgaXQncyBwcmFjdGljYWwgb3IgYSBm
cmVxdWVudA0KPiBlbm91Z2ggb2NjdXJyZW5jZSB0byBib3RoZXIgd2l0aCB0aGUgc3BlY2lhbCBj
YXNlcy4gRW5jb2RpbmcgYQ0KPiBSRUFEX1BMVVMgcmVzcG9uc2UgaXMgYWxyZWFkeSBjaGFsbGVu
Z2luZy4NCg0KV2hhdCBJJ20gc2F5aW5nIGlzIHRoYXQgeW91IGFyZSBtb3JlIGxpa2VseSB0byBo
aXQgdGhpcyBpc3N1ZSB3aGVuIHlvdQ0KaGF2ZSBhIHJlcGx5IHdpdGggc29tZXRoaW5nIGxpa2Ug
IjxkYXRhPjxob2xlPjxkYXRhPiIuLi4NCg0KSWYgdGhlIHNlY29uZCAiPGRhdGE+IiBjaHVuayBo
aXRzIHRoZSBhYm92ZSB4ZHJfcmVzZXJ2ZV9zcGFjZSgpIGxpbWl0DQooaS5lLiB0aGUgZmlyc3Qg
Y2FsbCB0byBuZnNkNF9lbmNvZGVfcmVhZF9wbHVzX2RhdGEoKSBzdWNjZWVkcyBhcyBkb2VzDQp0
aGUgY2FsbCB0byBuZnNkNF9lbmNvZGVfcmVhZF9wbHVzX2hvbGUoKSksIHRoZW4geW91IGp1c3Qg
d2FudCB0bw0KcmV0dXJuIGEgc2hvcnQgcmVhZCBvZiB0aGUgZm9ybSAiPGRhdGE+PGhvbGU+IiBp
bnN0ZWFkIG9mIHJldHVybmluZyBhbg0KZXJyb3Igb24gdGhlIHdob2xlIFJFQURfUExVUyBvcGVy
YXRpb24uDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
