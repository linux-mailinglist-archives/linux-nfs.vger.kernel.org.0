Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA14F1B69
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377425AbiDDVUR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379033AbiDDQVG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 12:21:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4D8B844
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 09:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLoNsUqKao0QLbzb7PCUrWG8wj9bbKBBbjes5daBo1AwinWv8P7UIreOAwWNbPRrxXebCfIXEYwjB/F9ZD+alwIUMKvY9J0OR4feFVWLSNf5WBb15P2iqcUHwQc4xViLd1oxxEdALbDbrLfotpB+q4xETZpFyEPBIVs26Je2Vsd9xFmNxv7owEaIXfEpbwNFdgKak+PxSAB0J0hcHCBOEnE+sRyG+sL0YE6+TDzZ8DpH3n9+1r6xzmBy6KcViVEy9LVrM3f3DPhtop8aD86VJ0ZArScc3Tm2mvZ998Ryzzz2Ximscz4Nmh7f/fy1wI/PzpKMtoniWG+FwzA78cRxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcfZIdSr0nbRwEBTAMYfNOIuj/p0/mRL5gLYIx1dxOs=;
 b=XD2jVgzGouW2nobBK2rWgBoKY+hHS59JyvAhC5pg46Vcsix1C/KVoRZZJjARj98oPVMwM1PHWDqVZfyyAPVjnFzwoTIp1uiX7OnkJ3CfcXxcpe7Q89RzqIPmhPCkAkAOBwIyQdvYopm7QXy22GhAbipf6xQp5NHJU9bXl1KCfGjF/a49Wpbtn8+WP4PS/SucWXCIY4cePV2aBjF2eVHamGx9SxMmNEpROXLPZRE6WevdxCVrDzI/L4bIEMSG1ygOBQ5FyFz8Dk/dVsZqOUZlZnxJ4lUTBWyhgDxPISBDIt+BPxa//5Wta9JJn6ViPqmUWnAkn+0xgmNggJjybfm6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcfZIdSr0nbRwEBTAMYfNOIuj/p0/mRL5gLYIx1dxOs=;
 b=So2S4gfMaBYhZsZCfl9RJM9kJSlz/1/impuyHdDbGJ4Z3E2EPAIYxD6CsNsxCKlVCGYi0964pzhQRwHL/zSDL2TOy+w0LmhfJgIjeZ/Fcl8HIZGYR3GBXU2lHTuy+2uUm1hFQSBmmUZPXkGlu75Pa7rzdNceG0uokDjgpsvAuXk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4669.namprd13.prod.outlook.com (2603:10b6:5:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.16; Mon, 4 Apr
 2022 16:19:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5144.016; Mon, 4 Apr 2022
 16:19:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oRE6zZm94AgAAKfQCAAARwgIAAAYeAgAABP4CAACmZAIAAFQAAgAX8lACAAAyJAA==
Date:   Mon, 4 Apr 2022 16:19:05 +0000
Message-ID: <50ea0e392fd8b0b1bec987e5c5f923c7baef439f.camel@hammerspace.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
         <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
         <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>
         <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>
         <2E4807E4-5086-4F15-B790-8D952B394FE5@oracle.com>
         <974fa169124661c2ce5ed549d499837435cc7b4c.camel@hammerspace.com>
         <E7FD566B-0570-4D14-9936-5C737B619E0B@oracle.com>
         <b9b98ad9b21f228566a5ebd643198c669c9f3408.camel@hammerspace.com>
         <930A468B-E674-4F5D-8BC0-DB9F45611A9D@oracle.com>
In-Reply-To: <930A468B-E674-4F5D-8BC0-DB9F45611A9D@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f88fe99-a333-4efe-eb14-08da1656d702
x-ms-traffictypediagnostic: DS7PR13MB4669:EE_
x-microsoft-antispam-prvs: <DS7PR13MB46694F60E48AEFA05A005D3FB8E59@DS7PR13MB4669.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqRfCImt1wLjvf+ApzFFUPjcRqksjyqelaK/d9iNnzBNurtQ7Y/UyQGLEp2Of0JUggbBGlydkvsGmD4R8yCj6gFs5T/yjEYJK8mMu8BAE1hCI6jurex5TmGF4uac5ypB0rnkH/m8J4CIMUR/CS8gIYmMHU7h03F2htcA9JhFb8GXtsjuj6F7gkVNjmqlgw7BHAbML4uHq7/xGzLeamgZpVHcNbv7M466qvzILMCLHXA/+r0c113Kh6mdSq1zTHF9GeAxR0hwLmkT0hW0Ptpj4FdtrIZnv647UOsMwcZsFtR+R0B6+yX5toqXQ9mYl9iGg06kOOJ5o7tNR4V7uoE+atsbPD7aS9UvoqiV6reKBO1cW5I2oX4xG+ZrqPUeqKCkjxKLBKQybiWuQuz65QjZ7X8mo7Hv4jNIX2JEqJ+wMSz5Kgy8JDADme6Lm1EyBbCdti5fnVPDIRJa88toQ629vc/5S3UUgkwjtv2GT/Fm0kvWslM/WnJqX3HD8QZDsNc4SXhFhzciN0S6xJgXC9tqvB4PF+hIPJ+IhtPwQqvHjkOKDl7u8/ebVcZgSpLMTIp30+56W6ZeUouUDZ2lGLIeQErAp1l1uUqa9F7eKP1+nHuveZIYC5X3NfhK8w0QBsJ3mGYV27xOJc2GhGebAvlmTpmYINO5qeDYhRpaLXxJqcn7s/fTbvKscmQIopJ9paX/234dTgsp5Si/eYcLW3140g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(3480700007)(2616005)(2906002)(83380400001)(36756003)(26005)(53546011)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(508600001)(8676002)(71200400001)(6512007)(8936002)(6506007)(5660300002)(76116006)(38100700002)(6486002)(4326008)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3FtRGZYL3ZneXltSWFQTWhpTzV1aTl1bm5MZDhQWC9pZ2VxODJORHRRdHNY?=
 =?utf-8?B?Y0NNRnQwd0RPeDVKcjN4aFNqQlU2OGovbWQ2NEcwSEFReEFuZDFNZSs1QTYv?=
 =?utf-8?B?Rm56VHJhNGNuWFkydmdpcitDcjJPemh1MlB0M3J2dVlNb2xQd2lXNE9tK1hv?=
 =?utf-8?B?TDl0Z1luUzgxRktrQ3hVQmI3QktmRzVUa2VFdkVVTWtOWHN4bzB0N3UvVUY0?=
 =?utf-8?B?SE85QmtBc0dYUGdRdDhqWmVielZYaEErc0d6VkdDK2txVkNLNW5XUG9Lek90?=
 =?utf-8?B?VEVsVVRadGxoOGRFY1hWaHIySFU5Smg3NzREVzJHcnpIZVJPaTl1SDhSKzBz?=
 =?utf-8?B?Sk5jbHJmTG9rVzdadElWQ3haYUhlRGU4YnF1OXR3QU9XZXA0ejh5dTc5cHRM?=
 =?utf-8?B?a1dyaHNpdEJPTDJLbDVJdElnUjkyTURJWHhuM0k5TEZIN1BpbDJmT1c5RWFT?=
 =?utf-8?B?VkpUeTV2bmQ2T3JINUVFWkQzY0JwNEN2SlFkdkVjalJzVlJDMWpGWDV3c0Rv?=
 =?utf-8?B?TzJmYjF4RGJ2UnBkOUhmaXJvNElNYTFYWHFIaTBERmt2NjNqWnlSSnBBdFNw?=
 =?utf-8?B?VDVOaXdwUThCWEUwek03RHAwcFp2YXRxZ3F1eG1sV0pFWk5BUnRmOWI0cnVC?=
 =?utf-8?B?Mk52eG5WbFYwcWFTZjhHazJYdVlQSHdwUXRJZC9lT2ZXS1dSSEs1ZUZ0TExB?=
 =?utf-8?B?RlBwQ2JLTnBzZnRuUnQrMnNHMm1uMFMzSVlHWVBqd2x4SC9OQzVMTjVZY1Q5?=
 =?utf-8?B?d2UwNFdRVDBZeTRPb3B3UGRrRGt0NVkzVmVicXErZHk5NnY3RDgweUZFWkJS?=
 =?utf-8?B?UmlJYktVZ25MRDNKVVhOdlZWc3JONU1INlVFMTJmeTdJKzQ3dFMrcUhtVkZL?=
 =?utf-8?B?Q0FrMVA0WjAzT1NKVHFzQ3ErOHJBL3F6VGRSMmd5OUNCbDJQTnYxS1ZpN3Rj?=
 =?utf-8?B?SmVOdC9Sa2wxdUxDNEhwSkh3WDlsbERGQ0dqVzc0OXBqVFB6UEhRTWNwRXFB?=
 =?utf-8?B?aW5rNjBiUU9uK05BZDhwTGRnazdNYXFyWExnOTgxWlp5NWRyTk1ZNFB1WHgz?=
 =?utf-8?B?WkxTVmhVY3FFRXhSd1pUa3BDNDZ3MFp2THhlOUNmVUV0WlFSL3ppUUZHZ2pV?=
 =?utf-8?B?UkhLNzBzT0tGN0p4dlFvcnlNZXREV3JmS3llc0JpTmJPcXVoN0wzNEg5Wlps?=
 =?utf-8?B?cTREWjFzWmRKR0ZMTnNUa0t1VEJxNnEwUjAxM0lCZ3V0ZjRJRkVHTUZYWkx0?=
 =?utf-8?B?T1pkT2NZMUhUMWF6Zk96Z2ZSdUliTzBrVjJKUWRldTIydlpHbmpyZDNRMWdV?=
 =?utf-8?B?S3kyY2VwOW1TeFNtR25IZDNCanVpdFdRbS9ncEwwSUVmK2xwTjh4Wk5DN2NB?=
 =?utf-8?B?U0JOemdyRlo4ZkZhWlZCRWpxT1JjTUhYR0J4UCtBcTJVVjNrdk5mQnEyRk5N?=
 =?utf-8?B?cklpaHFzZ0dxbHNLWEdwQkRjVllYOTc3NEYzdnk1dkFGeTFxYTRqTk1rYjU0?=
 =?utf-8?B?ZXhrRzIyWStxYWx1NDVwTmRna2FRaklVTGk0ZzB5RDFVb3hKb0RxWUZnODNC?=
 =?utf-8?B?ZDB4RURienpYT3UvV1BQKzA1c1BUbDNFeDRYbkZrbGpwS25paGw2d04yOUV6?=
 =?utf-8?B?SU9mWkFiTkI3QS94QTczZTREYVd2Mm9tY1FqTXJNMFJPTytvZ3o0YTh1SDRi?=
 =?utf-8?B?Nks0T0plMEoxWWJlajBkU29sSHU5MWVaSmRMTGxzRlRYdEFNbHpncnZmSmdO?=
 =?utf-8?B?QkNDTHlNUDFPREhLSnFWR05tNmUzbnlka093MEg0M3BPd3hQY2VwTXJ0M2lt?=
 =?utf-8?B?bDlZaVA3TVZiQmV5K0VjRzlKUUM5VVcrQnFCdWo1cnY4dWd1bmZhWHBleTNF?=
 =?utf-8?B?cHNuQWZ0dHNzNlVQMUtTbExyRDhUL1pVTDF0S1lwZFpxYTR0KzR2bVFKL1g0?=
 =?utf-8?B?K1Q1dE14SnRqMzNLclo2dGtTd0dXM283b3lOQmd1Zk8wTWgyam9NUFV5aEht?=
 =?utf-8?B?UUMxOGFjZlVTZFBMZmtiMzVNUXBzSFVqWnIwclJyQkRxZjdXc3FoZ0hWRDF4?=
 =?utf-8?B?N0pIdVJ4cEljbnRJTWtBcVhjMU9pVDR2dXIvMHcxS2NINWZxOWZBUXZWL1Bz?=
 =?utf-8?B?eDhMaVA4aXpEWmZkdTJOMG5ES1BFTjMvUWNmWVBGb0pTVGxqdVRqM3VhaDhU?=
 =?utf-8?B?OGFUN0V5c2c5NkdYTDJDbEthRkRhNHJnR1VKUERJQUsxS2dkZEZyaUorUXFT?=
 =?utf-8?B?YmkxRkxSUHdxR0MybEtOQ3RsN2dLTkxIMmlia2dMaFRnd1VMb1dQNjd6d1c4?=
 =?utf-8?B?Z2ZFbmgvdml0ZWt5T1o4T0xDY2FZaWNpc01Qb01VZGlQYTRLN0tCbE44bjRh?=
 =?utf-8?Q?WqqpbmmETL2yoKEU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F7FD57F1B994A419F677A628BDA88BF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f88fe99-a333-4efe-eb14-08da1656d702
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 16:19:05.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFJIOUH3hCbyPnoLs6fOS4znrvXmkxOM7PZfXhTUZt0iVBhJMNt2pvKEIu596r/pHbKydCqOLoudTXfJc7EKzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA0LTA0IGF0IDE1OjM0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgMzEsIDIwMjIsIGF0IDQ6MDggUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1
LCAyMDIyLTAzLTMxIGF0IDE4OjUzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiANCj4gPiA+ID4gT24gTWFyIDMxLCAyMDIyLCBhdCAxMjoyNCBQTSwgVHJvbmQgTXlrbGVidXN0
DQo+ID4gPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+
ID4gPiBPbiBUaHUsIDIwMjItMDMtMzEgYXQgMTY6MjAgKzAwMDAsIENodWNrIExldmVyIElJSSB3
cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIE1hciAzMSwgMjAyMiwgYXQgMTI6MTUg
UE0sIFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29t
PiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSG1tLi4uIEhlcmUncyBhbm90aGVy
IHRob3VnaHQuIFdoYXQgaWYgdGhpcyB3ZXJlIGEgZGVmZXJyZWQNCj4gPiA+ID4gPiA+IHJlcXVl
c3QNCj4gPiA+ID4gPiA+IHRoYXQgaXMgYmVpbmcgcmVwbGF5ZWQgYWZ0ZXIgYW4gdXBjYWxsIHRv
IG1vdW50ZCBvciB0aGUNCj4gPiA+ID4gPiA+IGlkbWFwcGVyPw0KPiA+ID4gPiA+ID4gSXQNCj4g
PiA+ID4gPiA+IHdvdWxkIG1lYW4gdGhhdCB0aGUgc3luY2hyb25vdXMgd2FpdCBpbiBjYWNoZV9k
ZWZlcl9yZXEoKQ0KPiA+ID4gPiA+ID4gZmFpbGVkLA0KPiA+ID4gPiA+ID4gc28gaXQNCj4gPiA+
ID4gPiA+IGlzIGdvaW5nIHRvIGJlIHJhcmUsIGJ1dCBpdCBjb3VsZCBoYXBwZW4gb24gYSBjb25n
ZXN0ZWQNCj4gPiA+ID4gPiA+IHN5c3RlbS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQUZB
SUNTLCBzdmNfZGVmZXIoKSBkb2VzIF9ub3RfIHNhdmUgcnFzdHAtPnJxX3hwcnRfY3R4dCwgc28N
Cj4gPiA+ID4gPiA+IHN2Y19kZWZlcnJlZF9yZWN2KCkgd29uJ3QgcmVzdG9yZSBpdCBlaXRoZXIu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVHJ1ZSwgYnV0IFRDUCBhbmQgVURQIGJvdGggdXNlIHJx
X3hwcnRfY3R4dCwgc28gd291bGRuJ3Qgd2UNCj4gPiA+ID4gPiBoYXZlDQo+ID4gPiA+ID4gc2Vl
biB0aGlzIHByb2JsZW0gYmVmb3JlIG9uIGEgc29ja2V0IHRyYW5zcG9ydD8NCj4gPiA+ID4gDQo+
ID4gPiA+IFRDUCBkb2VzIG5vdCBzZXQgcnFfeHBydF9jdHh0LCBhbmQgbm9ib2R5IHJlYWxseSB1
c2VzIFVEUCB0aGVzZQ0KPiA+ID4gPiBkYXlzLg0KPiA+ID4gPiANCj4gPiA+ID4gPiBJIG5lZWQg
dG8gYXVkaXQgY29kZSB0byBzZWUgaWYgc2F2aW5nIHJxX3hwcnRfY3R4dCBpbg0KPiA+ID4gPiA+
IHN2Y19kZWZlcigpDQo+ID4gPiA+ID4gaXMgc2FmZSBhbmQgcmVhc29uYWJsZSB0byBkby4gTWF5
YmUgQnJ1Y2UgaGFzIGEgdGhvdWdodC4NCj4gPiA+ID4gDQo+ID4gPiA+IEl0IHNob3VsZCBiZSBz
YWZlIGZvciB0aGUgVURQIGNhc2UsIEFGQUlDUy4gSSBoYXZlIG5vIG9waW5pb24NCj4gPiA+ID4g
YXMgb2YNCj4gPiA+ID4geWV0DQo+ID4gPiA+IGFib3V0IGhvdyBzYWZlIGl0IGlzIHRvIGRvIHdp
dGggUkRNQS4NCj4gPiA+IA0KPiA+ID4gSXQncyBwbGF1c2libGUgdGhhdCBhIGRlZmVycmVkIHJl
cXVlc3QgY291bGQgYmUgcmVwbGF5ZWQsIGJ1dCBJDQo+ID4gPiBkb24ndA0KPiA+ID4gdW5kZXJz
dGFuZCB0aGUgZGVmZXJyYWwgbWVjaGFuaXNtIGVub3VnaCB0byBrbm93IHdoZXRoZXIgdGhlDQo+
ID4gPiByY3R4dA0KPiA+ID4gd291bGQgYmUgcmVsZWFzZWQgYmVmb3JlIHRoZSBkZWZlcnJlZCBy
ZXF1ZXN0IGNvdWxkIGJlIGhhbmRsZWQuDQo+ID4gPiBJdA0KPiA+ID4gZG9lc24ndCBsb29rIGxp
a2UgaXQgd291bGQsIGJ1dCBJIGNvdWxkIG1pc3VuZGVyc3RhbmQgc29tZXRoaW5nLg0KPiA+ID4g
DQo+ID4gPiBUaGVyZSdzIGEgbG9uZ3N0YW5kaW5nIHRlc3RpbmcgZ2FwIGhlcmU6IE5vbmUgb2Yg
bXkgdGVzdA0KPiA+ID4gd29ya2xvYWRzDQo+ID4gPiBhcHBlYXIgdG8gZm9yY2UgYSByZXF1ZXN0
IGRlZmVycmFsLiBJIGRvbid0IHJlY2FsbCBCcnVjZSBoYXZpbmcNCj4gPiA+IHN1Y2ggYSB0ZXN0
IGVpdGhlci4NCj4gPiA+IA0KPiA+ID4gSXQgd291bGQgYmUgbmljZSBpZiB3ZSBoYWQgc29tZXRo
aW5nIHRoYXQgY291bGQgZm9yY2UgdGhlIHVzZSBvZg0KPiA+ID4gdGhlDQo+ID4gPiBkZWZlcnJh
bCBwYXRoLCBsaWtlIGEgY29tbWFuZCBsaW5lIG9wdGlvbiBmb3IgbW91bnRkIHRoYXQgd291bGQN
Cj4gPiA+IGNhdXNlDQo+ID4gPiBpdCB0byBzbGVlcCBmb3Igc2V2ZXJhbCBzZWNvbmRzIGJlZm9y
ZSByZXNwb25kaW5nIHRvIGFuIHVwY2FsbC4NCj4gPiA+IEl0DQo+ID4gPiBtaWdodCBhbHNvIGJl
IGRvbmUgd2l0aCB0aGUga2VybmVsJ3MgZmF1bHQgaW5qZWN0b3IuDQo+ID4gDQo+ID4gWW91IGp1
c3QgbmVlZCBzb21lIG1lY2hhbmlzbSB0aGF0IGNhdXNlcyBzdmNfZ2V0X25leHRfeHBydCgpIHRv
IHNldA0KPiA+IHJxc3RwLT5ycV9jaGFuZGxlLnRocmVhZF93YWl0IHRvIHRoZSB2YWx1ZSAnMCcu
DQo+IA0KPiBJIGdvdHRhIGFzazogV2h5IGRvZXMgY2FjaGVfZGVmZXJfcmVxKCkgY2hlY2sgaWYg
dGhyZWFkX3dhaXQgaXMgemVybz8NCj4gSXMgdGhlcmUgc29tZSBjb2RlIGluIHRoZSBrZXJuZWwg
bm93IHRoYXQgc2V0cyBpdCB0byB6ZXJvPyBJIHNlZSBvbmx5DQo+IHRoZXNlIHR3byB2YWx1ZXM6
DQo+IA0KPiDCoDc4NMKgwqDCoMKgwqDCoMKgwqAgaWYgKCF0ZXN0X2JpdChTUF9DT05HRVNURUQs
ICZwb29sLT5zcF9mbGFncykpDQo+IMKgNzg1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcnFzdHAtPnJxX2NoYW5kbGUudGhyZWFkX3dhaXQgPSA1KkhaOw0KPiDCoDc4NsKgwqDCoMKg
wqDCoMKgwqAgZWxzZQ0KPiDCoDc4N8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJx
c3RwLT5ycV9jaGFuZGxlLnRocmVhZF93YWl0ID0gMSpIWjsNCg0KDQpUaGF0IHRlc3QgZ29lcyBh
bGwgdGhlIHdheSBiYWNrIHRvIGNvbW1pdCBmMTZiNmU4ZDgzOGIgKCJzdW5ycGMvY2FjaGU6DQph
bGxvdyB0aHJlYWRzIHRvIGJsb2NrIHdoaWxlIHdhaXRpbmcgZm9yIGNhY2hlIHVwZGF0ZS4iKSwg
c28gcHJvYmFibHkNCm1vcmUgb2YgYSBxdWVzdGlvbiBmb3IgTmVpbC4NCkkgZG9uJ3Qgc2VlIGFu
eSBpbW1lZGlhdGUgcHJvYmxlbXMgd2l0aCByZW1vdmluZyBpdDogZXZlbiBpZiBzb21lb25lDQpk
b2VzIHNldCBhIHZhbHVlIG9mIDAsIHRoZSB3YWl0IGNvZGUgaXRzZWxmIHNob3VsZCBjb3BlLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
