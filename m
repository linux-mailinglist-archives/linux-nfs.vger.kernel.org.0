Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47447B2EC
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhLTSfM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 13:35:12 -0500
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com ([104.47.58.169]:35876
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233750AbhLTSfJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Dec 2021 13:35:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9m1CCDtzfw2lTDj1CqAeDQ96KqSVIbFc7RncHzbK4J5zeeuTVEkV+MZszyhgYPRYZslfxjlFOthAXbjbwsIYKeY+ge719kv79IyplUv8+YnVL65mF/ltZLX+2+Ka23MJ7ZIWzGEV+ZAFFrf4sbV09gpqYXFbAQzcS0NBqaTI00fQymNWSsPBbkGExEs4jw8MDM7jhvKNA784e6ohrgB2fxT2byx3ktz08q6xFd4XkNTMr3YokrSfxmp3vD1Yg9BRPUfYNEuptMtOMdFy358HRIX+eBfxisPuWOFWOJL7yI4jq5KyPTDHvJsTMxhRyKeYuXWk60m+llqSfvNgQksqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0m+LbEO+0dd9IWZxW8GBxV8DVxtzHZj9UbyhnT08qFk=;
 b=DmnRWJyGradcphckRln5Wuiyx6/3dL3cI83bu20J9H3gaKs24J1S3WOIKPNJMcwaCb4oTHHMAJSoZHjrVl3rUQJEGc9wk1AnLQCZRlbfqFpZ3svfTFeXQyJX+wAuAopr8004MDcPUgpBU0mAceRjEcYqz3Wv79dy5DxY/3ZKsgGmShSHnm9N3XkW2478xCXa0mooyl1Uyb6QsxLDLQlMoOOGwy8t84PPC/bBmT5EBClFAt1Xf2Ixq3eiAQtKT3oyyt6bfGomNdt/DUW1nVAVTFw5JzqUXDotkXEh/rmOrR9gJqRia2EIS88npKRKX0/CzifWcayurIZPaGV3ELxN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m+LbEO+0dd9IWZxW8GBxV8DVxtzHZj9UbyhnT08qFk=;
 b=fuUz8uIayb1d9DOWEsGgDKVLpBT71H28Z87rvyYCXAph9Cr0rBNNkCl5Qs1UmU9UnzxLE6g+krX5d8oeN2Ej0YynEzvZsNmBlu2cQ3/BkwDfJXlZO6WVcOJ7rTZZZXcfDSEdqGjFY6LSpzwqkbRA94u1JH/hH7MTnzaYaQKmD1w=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1274.namprd13.prod.outlook.com (2603:10b6:3:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Mon, 20 Dec
 2021 18:35:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4823.014; Mon, 20 Dec 2021
 18:35:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Topic: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Index: AQHX9HoJzJa8MHrJokmLlev6qmlSfqw6H8CAgAArNwCAAT7kgIAALcMA
Date:   Mon, 20 Dec 2021 18:35:07 +0000
Message-ID: <9679c6f76f751c6c379bcfb889fd1dcba1671eac.camel@hammerspace.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
         <20211219013803.324724-2-trondmy@kernel.org>
         <20211219013803.324724-3-trondmy@kernel.org>
         <20211219013803.324724-4-trondmy@kernel.org>
         <20211219013803.324724-5-trondmy@kernel.org>
         <20211219013803.324724-6-trondmy@kernel.org>
         <20211219013803.324724-7-trondmy@kernel.org>
         <20211219013803.324724-8-trondmy@kernel.org>
         <20211219013803.324724-9-trondmy@kernel.org>
         <20211219013803.324724-10-trondmy@kernel.org>
         <20211219013803.324724-11-trondmy@kernel.org>
         <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
         <3167a9a815ac9c82700bd58d8c421de31eee8b91.camel@hammerspace.com>
         <316378A4-BCB1-4C8F-A16D-43F8F9DA8FBC@oracle.com>
In-Reply-To: <316378A4-BCB1-4C8F-A16D-43F8F9DA8FBC@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a65ef129-5f6a-4401-1f09-08d9c3e77284
x-ms-traffictypediagnostic: DM5PR13MB1274:EE_
x-microsoft-antispam-prvs: <DM5PR13MB1274BC0494B0AE29830D6D04B87B9@DM5PR13MB1274.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rb2YerYQnBDgaeIhJXxGwGeife+GpS5SPyHTxe0292FYHNRwqRm52336N3+jlIll5ugBJAxJdayoh5/vpFLP+mZyVpOTYul7kMkCmnfubavWEADky6Flp3lt5+l88Prrf/+H+MTjXNHjtW2QagQ4RZkVroBbzJJhsdFdNqZEiuZDd+Yy54sXgDtVXQMt9QDMIOpTw4p7Tw2wit2f49ME03KA0x1qkROAzbFf+8FwLxm9HjUj0UwWQxbttfnpFkGaVwB0ttRM5LTE9w4j+TezIgD8P/+0LWLUSiRh9vKaXhM0IYBhogFAhge/AkzPTrK5BYOaDASiny3DjwWyD6BteqqMOIfnqIVaNLvjogj3rflGn3v1BRmMdr5cL9RLy7+jyGU1jL39Num2uOMXs5NW6ipjoeh4yo0l9iQ4W0rDFBA95+cWton19DhHS16iedwN8qTvUALHKsEAFbkpPLINP1sHSJqn7F/b5zXw4PI+G590qXS+cJRbo8UYkFaVW8NBXwY1RfA7Hcel69jIMpyIBvcdfK9ZPFplzjXf4H0nfL3znIyHylauzzdbOcdZlHsk2X5AlLYo1Ppc7YV6chS0JB4aMnuwvMYFLqj6lgCDAdImDCnMLwqaW6E/3SuFM80hpKRXzlgIc4SFiTTzVmc304uFnqvLf8jkQStWNNypIR3dakk4F/ydy6FAZsiWoWMk7QH4GwO9KwXGX1Nk5bwzHtdSi3yNRKMsq9BWgxlwaRhu8Oer4yZId4vPO5+9ZjPH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(366004)(376002)(346002)(39830400003)(36756003)(71200400001)(2906002)(83380400001)(508600001)(5660300002)(4001150100001)(54906003)(2616005)(38070700005)(53546011)(6506007)(38100700002)(122000001)(66946007)(8936002)(76116006)(66476007)(6486002)(66556008)(66446008)(4326008)(86362001)(8676002)(64756008)(6916009)(26005)(6512007)(186003)(316002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0RIbU93MkVpTDA1SVl4c1lITWR2aWhsQ2M2UEdkMTVyNnZQbk1iUFNFWmFQ?=
 =?utf-8?B?MGhHUTkyWUhDbm1iOHFlTjNCWXVRNUtaaWI4dVNzaEw5YUJrd3lSeWR4cXdX?=
 =?utf-8?B?L0p4cXhOTGZEZlg4RStvREhndEhZd1l2ZkxYdFpHbnQySWU5Z0hoUkxONG9v?=
 =?utf-8?B?Z2tYR2lodmx2UjhBVFU5V1hNMWJjTXJVdHA2eVlKZ0pOV0JtaUpmaHJ0czNV?=
 =?utf-8?B?VXllbThieDRIbW4wT1F6MFJpakFYWE1EcEJMR2Q1RUxjb1cyaXRWenlJdWxB?=
 =?utf-8?B?cy95K281djd5VkpjYkx2WllIR1FDZUxBL2lDY2VBV2ljQnhSYTRCaTh1dHB1?=
 =?utf-8?B?c09NYjcyZVlxeGErNWRrQXNJYkFqbTZjTUFacjNEQW9nWXhuVk9aK01ISGpI?=
 =?utf-8?B?VDZZODM4MEhoczVQcm50R2xUdEVEQ2NLVGtFR3lSaHdmam5sWDZmRE9sZSsr?=
 =?utf-8?B?NVdlWHhLZHJMeTM0Q3VYNXU0RmY2dmhIS0luR21aVUJVc0k0T2E1aVh4cUx2?=
 =?utf-8?B?b1ZnNy9tSFNONkNPM0VTMW1acUk2UkJTb01rM25CYS9IaFk4SVkzR2hmVTZY?=
 =?utf-8?B?WEV2b00xNFZ5RlJzczFQRjJFVTVtc3NBdDh0MVJhVE1ZN1Mza2txeWRKbHZF?=
 =?utf-8?B?blNYVFdvQ1d1Mm1jVVQ3d0tndnpyNDJwYzVLZUp5TXF3WUZRNmFDeDF4U29k?=
 =?utf-8?B?VHlLaUhEdjRVd0ErRzIxelV4dzF3bXFlZllweHpHZFVBbXoxZDN4cVhPeEdH?=
 =?utf-8?B?ZzkvTTI5WVlzQ3RCdi9YUjNXL0lhWWVLTE9mYWVtcWp3U3lSRVVHVEpTb1pv?=
 =?utf-8?B?d2VrbkhraGJSRnh1WlN4ZXJQanNGQVJZRERuNERRMGJROHhmbEFzS1lwTWhJ?=
 =?utf-8?B?WmNZNjVuSUZSL3hWdDRaRjJrVkpiTXd1azFTa29rUWgzZFBoWGlmTzgwMEVa?=
 =?utf-8?B?RmxaeXZCUXlRaUxQdWlrS05RdWExa2hJOWlUbm9KeW5oTFlTMno0SnNvRFVZ?=
 =?utf-8?B?b2dtblFWQWNGR3ZHa1Zjcm05Y1RkVXIzek5GQ0xhMEYrUDRRSVZ0T1l3TlpZ?=
 =?utf-8?B?V1d4blp5WllGK2hTcXVhcENpeDFUb3V6TzlsNWp6cWU3YWN2c3dXWXQ3TEF4?=
 =?utf-8?B?ZnEreTBBNy9RTmJ4MnduSGpzZ1RBK2ZuSG9Cbkkrbk5MSFJuRHNLZkd2VU1K?=
 =?utf-8?B?NFVCMVFsaDczb1NLQkxOalZ5Zy9US1I2cTh1VkNtaXhrTWpRVS9hOHdmL2sy?=
 =?utf-8?B?RzlHNlBTMHpoKzFBUHdKZElLSTdndGRMcnNyU0R6WTZjeHF1aFNRc2p4QzlF?=
 =?utf-8?B?aHVabm1QS2JhbEowMmtDR2NVbWk4UDFkcW5SQjVNaVRTaHJTWEFlSmIwbWlV?=
 =?utf-8?B?ZzdKaGorRGhqRGJTS0s5RkVaU2tWWjRzQXJCWnlQSEZENzRYZFNKakVBQ1lh?=
 =?utf-8?B?Smk0U21SUVk0NTBhbUU4REdCMndCV2FxN1l1MGRHTkZHa3A2NTR6Tm5OdHZ1?=
 =?utf-8?B?VG9kTTNmS2lwM2tUUjUwWHRnSFZRQk8xa2tXMmhqRldjNnZhZ0ZTOUllamN3?=
 =?utf-8?B?WkJVU3N3ZlNYdXhWZGNLS3R6YTliQVptSllEekptTU5WNkNGNGxESkZkRkN2?=
 =?utf-8?B?WEg2MDV5OWJtQXR4ZU1oRStlRU5oSGZLTEk4OWExM043Zmh6TDJoUC9HaG1S?=
 =?utf-8?B?UjIxRHF1TzZpVUpxY3lLakZGQ2RqK0lEcVhGSVVhVEJnakVBc3l0QXBIdTB0?=
 =?utf-8?B?bTgyVzBYWW1rSDV0N1ZtSFpCQXozSlJZWUhEK05aTkN0RUxmR0gzNzVDRWky?=
 =?utf-8?B?akpqODdnRmlPQnBtWWk5UXpmWWgvbUcyTVZDdWRySEE5M2l3aXk4MnUrd1dy?=
 =?utf-8?B?N240OTRjRjYxSFRaOVN5YURJbnBud2hicUJhOUcwSnNvV05QWmp5ekF0RnhX?=
 =?utf-8?B?MWdLNGFxWWx0SFZrYnorVVVOYlUvZ3ZPMTI0QVdNbE5lNTdpYlJwOS8wb3V5?=
 =?utf-8?B?OEpuZWtQQU05TWhCSmRyN1FVdWdnQnl2MGpvN0prTXJtRFFnemcxMTFvNHNX?=
 =?utf-8?B?aGFSRzlYMGZTZlkwR0ltTG5SMm1PcTB5dHEvVi80TVJVZnRIYzVOY0NkZ1Bv?=
 =?utf-8?B?cWl3Y2Y0VUNwMGlBN3VUWmhQc0RLME90YzBVOXRMOXYzOHZ2NnhHVDZ4RExl?=
 =?utf-8?Q?j0W3S9n7ivIAqokPM28ELpk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <614784044D9C0C45A75ADBA03D918CB7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65ef129-5f6a-4401-1f09-08d9c3e77284
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 18:35:07.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MO7CtqfMlaedVu1NKd6DdOWpvd9nbgshTrzuR4vBdDL8n5K8RsopZWHMUS0hZNmvez9U4PVrjzy6N5ph9OMQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1274
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTIwIGF0IDE1OjUxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBEZWMgMTksIDIwMjEsIGF0IDM6NDkgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU3Vu
LCAyMDIxLTEyLTE5IGF0IDE4OjE1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiANCj4gPiA+ID4gT24gRGVjIDE4LCAyMDIxLCBhdCA4OjM4IFBNLCB0cm9uZG15QGtlcm5lbC5v
cmfCoHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gTkZTdjQgZG9l
c24ndCBuZWVkIHJwY2JpbmQsIHNvIGxldCdzIG5vdCByZWZ1c2UgdG8gc3RhcnQgdXANCj4gPiA+
ID4ganVzdA0KPiA+ID4gPiBiZWNhdXNlDQo+ID4gPiA+IHRoZSBycGNiaW5kIHJlZ2lzdHJhdGlv
biBmYWlsZWQuDQo+ID4gPiANCj4gPiA+IENvbW1pdCA3ZTU1YjU5YjJmMzIgKCJTVU5SUEMvTkZT
RDogU3VwcG9ydCBhIG5ldyBvcHRpb24gZm9yDQo+ID4gPiBpZ25vcmluZw0KPiA+ID4gdGhlIHJl
c3VsdCBvZiBzdmNfcmVnaXN0ZXIiKSBhZGRlZCB2c19ycGNiX29wdG5sLCB3aGljaCBpcw0KPiA+
ID4gYWxyZWFkeQ0KPiA+ID4gc2V0IGZvciBuZnNkNF92ZXJzaW9uNC4gSXMgdGhhdCBub3QgYWRl
cXVhdGU/DQo+ID4gPiANCj4gPiANCj4gPiBUaGUgb3RoZXIgaXNzdWUgaXMgdGhhdCB1bmRlciBj
ZXJ0YWluIGNpcmN1bXN0YW5jZXMsIHlvdSBtYXkgYWxzbw0KPiA+IHdhbnQNCj4gPiB0byBydW4g
TkZTdjMgd2l0aG91dCBycGNiaW5kIHN1cHBvcnQuIEZvciBpbnN0YW5jZSwgd2hlbiB5b3UgaGF2
ZSBhDQo+ID4ga25mc2Qgc2VydmVyIGluc3RhbmNlIHJ1bm5pbmcgYXMgYSBkYXRhIHNlcnZlciwg
dGhlcmUgaXMgdHlwaWNhbGx5DQo+ID4gbm8NCj4gPiBuZWVkIHRvIHJ1biBycGNiaW5kLg0KPiAN
Cj4gU28gd2hhdCB5b3UgYXJlIHNheWluZyBpcyB0aGF0IHlvdSdkIGxpa2UgdGhpcyB0byBiZSBh
IHJ1bi10aW1lDQo+IHNldHRpbmcNCj4gaW5zdGVhZCBvZiBhIGNvbXBpbGUtdGltZSBzZXR0aW5n
LiBHb3QgaXQuDQo+IA0KPiBOb3RlIHRoYXQgdGhpcyBwYXRjaCBhZGRzIGEgbm9uLWNvbnRhaW5l
ci1hd2FyZSBhZG1pbmlzdHJhdGl2ZSBBUEkuDQo+IEZvcg0KPiB0aGUgc2FtZSByZWFzb25zIEkg
TkFLJ2QgOS8xMCwgSSdtIGdvaW5nIHRvIE5BSyB0aGlzIG9uZSBhbmQgYXNrIHRoYXQNCj4geW91
IHByb3ZpZGUgYSB2ZXJzaW9uIHRoYXQgaXMgY29udGFpbmVyLWF3YXJlIChpZGVhbGx5OiBub3Qg
YSBtb2R1bGUNCj4gcGFyYW1ldGVyKS4NCj4gDQo+IFRoZSBuZXcgaW1wbGVtZW50YXRpb24gc2hv
dWxkIHJlbW92ZSB2c19ycGNiX29wdG5sLCBhcyBhIGNsZWFuIHVwLg0KPiANCj4gDQoNClRoaXMg
aXMgbm90IHNvbWV0aGluZyB0aGF0IHR1cm5zIG9mZiB0aGUgcmVnaXN0cmF0aW9uIHdpdGggcnBj
YmluZC4gSXQNCmlzIHNvbWV0aGluZyB0aGF0IHR1cm5zIG9mZiB0aGUgZGVjaXNpb24gdG8gYWJv
cnQga25mc2QgaWYgdGhhdA0KcmVnaXN0cmF0aW9uIGZhaWxzLiBUaGF0J3Mgbm90IHNvbWV0aGlu
ZyB0aGF0IG5lZWRzIHRvIGJlDQpjb250YWluZXJpc2VkOiBpdCdzIGp1c3QgY29tbW9uIHNlbnNl
IGFuZCByZWFsbHkgd2FudHMgdG8gYmUgdGhlDQpkZWZhdWx0IGJlaGF2aW91ciBldmVyeXdoZXJl
Lg0KDQpUaGUgb25seSByZWFzb24gZm9yIHRoZSBtb2R1bGUgcGFyYW1ldGVyIGlzIHRvIGVuYWJs
ZSBsZWdhY3kgYmVoYXZpb3VyLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
