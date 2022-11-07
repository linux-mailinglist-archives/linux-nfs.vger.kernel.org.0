Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902F61FE2C
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKGTGo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 14:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKGTGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 14:06:43 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078B183AC
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 11:06:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9Vyyx9H/tZrlazw4IKFqmWNOF9vr5JEmbTsZbC+QTwXNebugVQIP9YIzv8/poWzmBi5OodDtLazPt1G2Tqiu8ZtIf2jkNXlx2llHSS/jlDFOKHF4yoiGSTgazkYBwh3UeCW0TscLVWJswM9I/yB98Ra5QyqsoSQ+IoDVB4fMVBRNjTsKnh2sXS3Eyn/mDFPIh9dIGElydRXk9WAVBWVQBseiRj0bvS1ikDzxeBZLDuE2MGzXUAKZpJk78mW/8Y/R/UPC/Rs3Rqgm/7d8bSzml292okzHGSd4Z4GKUevDcW60H5/cl/i19J/tCN8EgniIk4JzhGc+lVwPAPQaj1ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbelqR3uy4rGn/ytsXoDw92q9XOw0oZwSrB43tmq1C4=;
 b=n1vKRkIGrrcBnK7Hy43ebUheneWvXCN6cERECH7gedNIMLUgkifPmDTFuA4vUdhz8jVL7ykaTX2nbbc2SAdOvySVavA3R7rZD2BgBrC0u/4hPbDiXkfWSsZpY/BNkv/aSYiTp1OLmF2fn+i3PCvmbHwR2qcRuHcXp06Ot9xiE1LiMi55pKwgCjoCygirODp8KLBBDxXfWPwbBqBDgmHh+JjOMc0891eciu2w1pB7SiJXLMCH5fkfASAun9C14wMZ0tg6Vvahk5Y+JrxxsCjTGreRqyEor65KAEuAKGVzpdboe46TDtCpE+MrCiAVskB5Y4RMaMIUmG1vogw59BwJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbelqR3uy4rGn/ytsXoDw92q9XOw0oZwSrB43tmq1C4=;
 b=ZEfzpMg5/PvD3mds6NYwnSJHEUxzHUbytqFYJvclXXZaFzDGQuJAxRoa/B+P3B+Y/FIIRlFKZqHx+7vNCiVxoo+eh6ChNoKi9yyXpNXn6zAVq5gtbbvNMTX+szPNiRhpu8fsAiYOlmg8kBwy1RlGZt/PYJ/zsj4GL+ofFV1Dyng=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM8PR13MB5144.namprd13.prod.outlook.com (2603:10b6:5:315::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.19; Mon, 7 Nov
 2022 19:06:40 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 19:06:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Jeffrey Layton <jlayton@kernel.org>
CC:     Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove dedicated nfsd_filecache_wq
Thread-Topic: [PATCH] nfsd: remove dedicated nfsd_filecache_wq
Thread-Index: AQHY8svtiadHoZawZUiw7K/seqhM0q4ztxuAgAANf4CAAAgnAIAABbyA
Date:   Mon, 7 Nov 2022 19:06:40 +0000
Message-ID: <53271EA7-326E-427C-B9D4-3AB75924508C@hammerspace.com>
References: <20221107171056.64564-1-jlayton@kernel.org>
 <61876142ab0115a7bf39556e5caebfd1a635f945.camel@kernel.org>
 <CDEA2A36-B0EC-426B-8489-2BB524C6266A@oracle.com>
 <0dffb0a8508511229880545245948c3f512a374a.camel@kernel.org>
In-Reply-To: <0dffb0a8508511229880545245948c3f512a374a.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM8PR13MB5144:EE_
x-ms-office365-filtering-correlation-id: 23e5477d-c38f-4384-5eca-08dac0f333e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fS59YRrhlppKQMvWW80ifk5Jv84cjleevWmNd/UBKlGBwaKhlKSjxCnffMyiAD5jLj7/e5hUNjbGk+TCl4z/R6zgHxfKtPZeqaDPLg6TH8EjVngmdHLSnlfn1JocemKxAhtHpSVSJxNwvJvm86m1aKL33BiS9fmcl4LPct4UXY2/eN6pfKuOh1UnczfWSofBmK+I+hxl1WID3tgW+UdOZbe6LiooM6hCSl5wqztRA2NclYDSPhfMPPvLmaQXlzJkIN8ZkiJbB7F0OrnZ4avFJkyO+Td0YZqeGKsYazDNEnhbK3TOA1cgQzeHnKMgXPIhhdmDluRNjC/h4H8b+MXD2aslG59Nxe9hDMT1kY6dLZyQQr9Aze+UIxyPiVcjcjMal8SsGx1sRYMT0WMDCe+SlM0Gi/6CZNJ0WtvjuUi0e0SVe0DGH3ZhjUv/tgdTiFCreUfNh6Mnn4RrKIBUBPqoGAUBN9P8nHdzaFzKu5dx0r31RQfl0/HlN57KUA2MMJQ0NThMbZK2UUkYf7FBvJfaEZAsHWoSZza/BPTTuMlktCrlvol0hoi6O7sqbAELJyDflRb1I7I7Xcv58ax1KJMrvgV4/mT6NwCdIcL+aA9vVrwRbJWdrzWPoFw34lpV9FdHsfomcaAF1qU716RKFURYmMDqqbkpcvUTGaZlmUUpj/MQVHAv1ZHSBHYdTDAKarcidc6MOpjVIjPk6Gc/ntck3jwnKEewe4G0Ir706/sd8qwZlQ187ODTu20vgyv/q2TMelMg+jEuPW2+AQ2TOxYcN66uAwo308TgI2EJ6K2nALg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39840400004)(451199015)(186003)(2616005)(478600001)(5660300002)(71200400001)(38070700005)(6486002)(83380400001)(66946007)(6512007)(53546011)(8936002)(6916009)(26005)(38100700002)(54906003)(8676002)(36756003)(66446008)(41300700001)(4326008)(64756008)(2906002)(86362001)(316002)(33656002)(66556008)(6506007)(66476007)(76116006)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFBtZ2hNYUk2ejlGdHlXNW55bWN0SlFJVVRVT05YKytqZ3BIamRpejJodnZr?=
 =?utf-8?B?bEJFTWVmYVNTZlNMeXlJWmNSdy9iVDRzamM3Rk1tV3hEdkZwSGR2WmZBTTFx?=
 =?utf-8?B?aWlSTWovc2NXYU1yVVp3VVB5N29Mam5YZDlEVkZVZHJhTTk0RGdSanhVQ2Y5?=
 =?utf-8?B?TU9nV0tlQzM5eDNlanpzNk9FQlRJZHNneWtaZ2JTN2V6c0YwSUxYTkE0QWRr?=
 =?utf-8?B?S3lSNXJSUjI5UkNPQXUwb29CQzJrUVNNL1NpSitjTmFtWU05dnlKMk5Xbkx2?=
 =?utf-8?B?THVmNkNTTjY2eStraTVmdmREb0RyQVJaYkt6WjRhTXVwUVJVUkNoU1lmL0hB?=
 =?utf-8?B?ZHhRcUtnMjlFN0ZyemVTTFBOdzJ5QUxSK1JNSWsxMTh0QkJscFFnSjhMWjJH?=
 =?utf-8?B?RTh3QUI0Z1NDeUJ0YjZvcnlwTjl6dVoyQkFldDNmNzI5YjNGVWxrT1lhSm55?=
 =?utf-8?B?b2xiMkFHcDhVZjJFSmRlYkd4eTZXR09FMTN2VVFwZ3hEQTJkaXB5Mzh3WGY0?=
 =?utf-8?B?dDEyQ09DaHFCWlMrb2RTNk9WSnA2UVovWURqaW4vamo0c3lGdUVuMlM1NkVV?=
 =?utf-8?B?L0dsWXdEZ1BXRXZEVkUvalJTU1hpS3AyS3laZVdIQklXdnloN1ArYjhoN1l4?=
 =?utf-8?B?V0hWWEFrMGxkUzUzeUhxdzRqMGhnajNPSWF1QVlieWtWNy9wVVozOU1zMDY4?=
 =?utf-8?B?cm44cm1iZmVoMndkOEJaS2pDRDVXMUx4WTRMRTJzakcrOVJORlVYQ0ltUnhL?=
 =?utf-8?B?WVNyTGFOd3VucGw0SUhINnB5RGJybk1vZWZVOWY0bFJiWkFUaHdOb2R4akc1?=
 =?utf-8?B?KzhwMHdBUWkxTjFzNjZmWDNMVExMaUpKOFl6dXVPQVJRUTNvU2RvS0hCYXM5?=
 =?utf-8?B?NEgzRHdEcFZMVlAreVFmekYxUFRpOE5FdXZRbG9CWTRSdEFkNU5PR094ZDNP?=
 =?utf-8?B?VExQdytVWWNVSnRpTjAzdUxCMG1oYXpLY0lzSU9Lb1V0UnJKK3Z1SnZ1ZFU2?=
 =?utf-8?B?K3JDc3hBVEpCRW9TUlNTT2wyV1R3VVNxNkNpVU04dXlwWmRLbjZYNHMxKzBx?=
 =?utf-8?B?MzV4QWJMWGtxL3diVFd6SUt4ck5Tc3VwMUVZMGM0dTI4b1hqRXZBZlFCb2g2?=
 =?utf-8?B?WGQ3OWh0S2V3ZjZTdTcvb3gzdDJhQ3NaWXBldlp3QXB6L0Z3bVpFa1NrUEZ6?=
 =?utf-8?B?TDZGbHp1TTc0WjB0NnBoTzdyMGVwbFllZ2xiK1ozL29UQ2g5d1pWVGtrT2Jh?=
 =?utf-8?B?TzhoV2hmcnp4RldsM3ArUTVFaUZ0L3VJdHlHWUVHNDRYbkhLeCtEeW5HeW5n?=
 =?utf-8?B?cGxFVFNmWHEvaFQ5d3MzeGdlRGoveS9UK3JhN3UybE9kaGljamd1SEd6MXo3?=
 =?utf-8?B?TmNWN3ZLZFQ1dm1KQkFPb3BBY1JzdEE5UExSRkxJT2hVcFJrcXpMdTU3WjNE?=
 =?utf-8?B?YksrLzNqSng4UDlUZlEvZkRsemJidEh2RlN3dlpsTS84NUhYVTNOaE9tZzlD?=
 =?utf-8?B?cThBOThnV3JlblhQRzg1K3FLY2ZtOElVNUFveDAzNGZwQjZUWlo2YjlJR1ZB?=
 =?utf-8?B?dmNTVzB5SFRHdisxQUh1L1VVaGtHMmgrZFNTMVF0R1FEQjUvVkVMWlRrUWFW?=
 =?utf-8?B?YVhrNStJc3N6UXVCTEMyNDBlWCtCM09Rd2hRUmtLSkl6U1ZhMmNGWnVRd3JC?=
 =?utf-8?B?Y1JiUVk4Vjg3RXZqR21pWVViNkhwVml3U1VXSUpEdmRJR2V6Z1R3V0Q1UURD?=
 =?utf-8?B?U01RZzgyNk04aVR2WkVsbGtoRFEyR0J5Vnkwc05qbWNkeXB3MVRkZFhhNjJG?=
 =?utf-8?B?UGZlbEs4RnY5c3ljY1crQytkd1NJNERZVHBReEZscnU3NXYwdnk1NVI5azFs?=
 =?utf-8?B?SitXSFdXZUkzU1JwSDkrN0RhTmFQV3ZMOEorTERkSllDRUNscEY0TGpNQkk1?=
 =?utf-8?B?UnhZeTFzdC9IV3RLV3RGdUhhUWhNcGdXeWVmWHpPZTlMRlNZUW1PNGd2aUU4?=
 =?utf-8?B?SzAzQW50QkpuWDgxbDJIU3p4ckFJWlJaZ0hDdExtSjZKVllma1hiR1g4bUlG?=
 =?utf-8?B?UW1PbytzSDMxL3BuSUNpeGJTR3VtcjJmN3RkV1dyRkhXaU5ydTlMME9KZlFK?=
 =?utf-8?B?eTNGMG1DUkp5WW94bXF1enVDSDcyb0VFUDBQVVJNSjRaak54aERUelRHdEF0?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7D2010557CA4945B2E39E883B0B60D4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e5477d-c38f-4384-5eca-08dac0f333e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 19:06:40.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPkdhLw1/15/Ob6V6J4lKvn9CbaxjC/brkl6pkSqdh0//XnN72NN2TSAw47UDnDtelxv0F5LCPMI7mStxElYgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDcsIDIwMjIsIGF0IDEzOjQ1LCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMjAyMi0xMS0wNyBhdCAxODoxNiArMDAwMCwg
Q2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4gT24gTm92IDcsIDIwMjIsIGF0IDEyOjI4
IFBNLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBP
biBNb24sIDIwMjItMTEtMDcgYXQgMTI6MTAgLTA1MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+
PiBUaGVyZSdzIG5vIGNsZWFyIGJlbmVmaXQgdG8gYWxsb2NhdGluZyBvdXIgb3duIG92ZXIganVz
dCB1c2luZyB0aGUNCj4+Pj4gc3lzdGVtX3dxLiBUaGlzIGFsc28gZml4ZXMgYSBtaW5vciBidWcg
aW4gbmZzZF9maWxlX2NhY2hlX2luaXQoKS4gSW4gdGhlDQo+Pj4+IGN1cnJlbnQgY29kZSwgaWYg
YWxsb2NhdGluZyB0aGUgd3EgZmFpbHMsIHRoZW4gdGhlIG5mc2RfZmlsZV9yaGFzaF90YmwNCj4+
Pj4gaXMgbGVha2VkLg0KPj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGps
YXl0b25Aa2VybmVsLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+IGZzL25mc2QvZmlsZWNhY2hlLmMgfCAx
MyArLS0tLS0tLS0tLS0tDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTIg
ZGVsZXRpb25zKC0pDQo+Pj4+IA0KPj4+IA0KPj4+IEknbSBwbGF5aW5nIHdpdGggdGhpcyBhbmQg
aXQgc2VlbXMgdG8gYmUgb2ssIGJ1dCByZWFkaW5nIGZ1cnRoZXIgaW50bw0KPj4+IHRoZSB3b3Jr
cXVldWUgZG9jLCBpdCBzYXlzIHRoaXM6DQo+Pj4gDQo+Pj4gKiBBIHdxIHNlcnZlcyBhcyBhIGRv
bWFpbiBmb3IgZm9yd2FyZCBwcm9ncmVzcyBndWFyYW50ZWUNCj4+PiAoYGBXUV9NRU1fUkVDTEFJ
TWBgLCBmbHVzaCBhbmQgd29yayBpdGVtIGF0dHJpYnV0ZXMuICBXb3JrIGl0ZW1zDQo+Pj4gd2hp
Y2ggYXJlIG5vdCBpbnZvbHZlZCBpbiBtZW1vcnkgcmVjbGFpbSBhbmQgZG9uJ3QgbmVlZCB0byBi
ZQ0KPj4+IGZsdXNoZWQgYXMgYSBwYXJ0IG9mIGEgZ3JvdXAgb2Ygd29yayBpdGVtcywgYW5kIGRv
bid0IHJlcXVpcmUgYW55DQo+Pj4gc3BlY2lhbCBhdHRyaWJ1dGUsIGNhbiB1c2Ugb25lIG9mIHRo
ZSBzeXN0ZW0gd3EuICBUaGVyZSBpcyBubw0KPj4+IGRpZmZlcmVuY2UgaW4gZXhlY3V0aW9uIGNo
YXJhY3RlcmlzdGljcyBiZXR3ZWVuIHVzaW5nIGEgZGVkaWNhdGVkIHdxDQo+Pj4gYW5kIGEgc3lz
dGVtIHdxLg0KPj4+IA0KPj4+IFRoZXNlIGpvYnMgYXJlIGludm9sdmVkIGluIG1lbSByZWNsYWlt
IGhvd2V2ZXIsIGR1ZSB0byB0aGUgc2hyaW5rZXIuDQo+Pj4gT1RPSCwgdGhlIGV4aXN0aW5nIG5m
c2RfZmlsZWNhY2hlX3dxIGRvZXNuJ3Qgc2V0IFdRX01FTV9SRUNMQUlNLg0KPj4+IA0KPj4+IElu
IGFueSBjYXNlLCB3ZSBhcmVuJ3QgZmx1c2hpbmcgdGhlIHdvcmsgb3IgYW55dGhpbmcgYXMgcGFy
dCBvZiBtZW0NCj4+PiByZWNsYWltLCBzbyBtYXliZSB0aGUgYWJvdmUgYnVsbGV0IHBvaW50IGRv
ZXNuJ3QgYXBwbHkgaGVyZT8NCj4+IA0KPj4gSW4gdGhlIHN0ZWFkeSBzdGF0ZSwgZGVmZXJyaW5n
IHdyaXRlYmFjayBzZWVtcyBsaWtlIHRoZSByaWdodA0KPj4gdGhpbmcgdG8gZG8sIGFuZCBJIGRv
bid0IHNlZSB0aGUgbmVlZCBmb3IgYSBzcGVjaWFsIFdRIGZvciB0aGF0DQo+PiBjYXNlIC0tIGhl
bmNlIG5mc2RfZmlsZV9zY2hlZHVsZV9sYXVuZHJldHRlKCkgY2FuIHVzZSB0aGUNCj4+IHN5c3Rl
bV93cS4NCj4+IA0KPj4gVGhhdCBtaWdodCBleHBsYWluIHRoZSBkdWFsIFdRIGFycmFuZ2VtZW50
IGluIHRoZSBjdXJyZW50IGNvZGUuDQo+PiANCj4gDQo+IFRydWUuIExvb2tpbmcgdGhyb3VnaCB0
aGUgY2hhbmdlbG9nLCB0aGUgZGVkaWNhdGVkIHdvcmtxdWV1ZSB3YXMgYWRkZWQNCj4gYnkgVHJv
bmQgaW4gOTU0MmU2YTY0M2ZjICgibmZzZDogQ29udGFpbmVyaXNlIGZpbGVjYWNoZSBsYXVuZHJl
dHRlIikuIEkNCj4gYXNzdW1lIGhlIHdhcyBjb25jZXJuZWQgYWJvdXQgcmVjbGFpbS4NCg0KSXQg
aXMgYWJvdXQgc2VwYXJhdGlvbiBvZiBjb25jZXJucy4gVGhlIGlzc3VlIGlzIHRvIGVuc3VyZSB0
aGF0IHdoZW4geW91IGhhdmUgbXVsdGlwbGUgY29udGFpbmVycyBlYWNoIHJ1bm5pbmcgdGhlaXIg
b3duIHNldCBvZiBrbmZzZCBzZXJ2ZXJzLCB0aGVuIHlvdSB3b27igJl0IGVuZCB1cCB3aXRoIG9u
ZSBzZXJ2ZXIgYm90dGxlbmVja2luZyB0aGUgY2xlYW51cCBvZiBhbGwgdGhlIGNvbnRhaW5lcnMu
IEl0IGlzIG9mIHBhcnRpY3VsYXIgaW50ZXJlc3QgdG8gZG8gdGhpcyBpZiBvbmUgb2YgdGhlc2Ug
Y29udGFpbmVycyBpcyBhY3R1YWxseSByZS1leHBvcnRpbmcgTkZTLg0KDQo+IA0KPiBUcm9uZCwg
aWYgd2Uga2VlcCB0aGUgZGVkaWNhdGVkIHdvcmtxdWV1ZSBmb3IgdGhlIGxhdW5kcmV0dGUsIGRv
ZXMgaXQNCj4gYWxzbyBuZWVkIFdRX01FTV9SRUNMQUlNPw0KDQpJbiB0aGVvcnksIHRoZSBmaWxl
cyBvbiB0aGF0IGxpc3QgYXJlIHN1cHBvc2VkIHRvIGhhdmUgYWxyZWFkeSBiZWVuIGZsdXNoZWQs
IHNvIEkgZG9u4oCZdCB0aGluayBpdCBpcyBuZWVkZWQuDQoNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
