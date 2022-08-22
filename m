Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6259C142
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 16:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiHVODH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiHVOCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 10:02:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2111.outbound.protection.outlook.com [40.107.94.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B753B3AB1C
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 07:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuD8mBf7SwJsYPXyDGcbJOUHY0neZ1lXg/htOB4WR+YSJllPA0d5nLvMUuRtczEKuNA8wFcEI12py9pkVTwAphI+H9+XelVTqZO+YfgrPndltb+1iLRgTjYOfqsB8Ge1KvsMsUioQiJ8CqNjTmYYMtV3IJvlCniZMv5b08zb4BeQ7NZxSDgvDa7V7whL70I2gdHurPytEm70KzpoDPYniI9OULFKSmWU97F+hS9954wnxWJsktI0Tdjdzhnua46c6i/fTWNEvKFvvLwtfnCJV01Lr8rtUiNnZPa0ME9Zeh9byHCkswzsySM4kUAQR+LzQ3jsJUPOaGqrQoJ42TDTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9BWN3nWqj/usYheMopogHpVjw8nseOKyVcXUMClebs=;
 b=l2EOGy4808mcT1ArDqTA6uVz5VqL0/WtYrE3SJ2ma1UR0wn0akOQs4a9yeF1fky60AJJ8rUnkp2R++Gr05EzFYfM/82z59n121Qcr1NDIAd7kmUl7SYwbfrpLhsCRwGCquu7EbwlRNIk37ezPNM7Eb6VLsTOkZWHdsgDOLjlNSYNvRhgWIh13jIjCHbboK1R9JRlgrDu7xfP2fXbaQsgJkbsizoIZoeHVskrR1uoOFj9r8g+6r3OSQjEfhtBwuFljKwhjc64lVYVsLOJVLHXPw8Kk8tr015Ayd7BaBwPmSEj/RwDNVG1/hXOXar4pGGiCvcgfgPfY94WIHH7WUm41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9BWN3nWqj/usYheMopogHpVjw8nseOKyVcXUMClebs=;
 b=guNrIajQO/b/eWZCqgbtqvykVLgGT45fNT6lpdwEbjoYhuIKkvE2fRqYNoGNRtu2IgrYsfZLA9vXamnsnl5eOt/7XnR/Cy2rGvUwNtMODCfdlARZFB8rVN5YreGLr96z6sPNOIQahW8pVUSnFuFqtMDf8YQcHqEosmU3o2n5MiU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB4423.namprd13.prod.outlook.com (2603:10b6:a03:1de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 14:02:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Mon, 22 Aug 2022
 14:02:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "igor@gooddata.com" <igor@gooddata.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Regression: deadlock in io_schedule / nfs_writepage_locked
Thread-Topic: Regression: deadlock in io_schedule / nfs_writepage_locked
Thread-Index: AQHYtf93d5SRXUGPYkyFYNes7xsaQa2686EA
Date:   Mon, 22 Aug 2022 14:02:33 +0000
Message-ID: <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
In-Reply-To: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 977dc605-80e9-4e1b-e6b3-08da8446f5fb
x-ms-traffictypediagnostic: BY5PR13MB4423:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5mM9nmzVjpvMfy3AtVMAlhRQw6YP93kfnTjQvr0fRqyiL4XTF/Au1j5sN6HHB9VYApntjiyg1oub+R2heFnGNwULnJurz2eZGWJNIyfysUMH6QqZvpvB+I3bLpP08hhOtSdMyD2TAKsFsBOna9GEtFTwGH8k4GFhJ0M4sNURLNjyvz1kcUHfQ8GMrNVS8k1ZsGdUECwJa1ZQ7osVXRznE8M5OCt8Gy5GzMpEd11Q/M1CNN9tI8yyXaMX8WkgrkHCcl5l8zbjkQciEETE0guSSqmZ4Y5LJO/Q0wrwkeeOwk1xA4Uj0tloaJQaCh2s7rbWecgKgCm60EegBhISyIRkOqD3sfK6USqYPH0Z4HYbcMiF3qm16UyJOeae03wDeWKBLfkrh8kRqfUYSsfm2ikyEA4yNgjbTitMZJev13uEpu1KUhZCbmtRPUaN2VPqjPhaG28nTozJQh7vkXTK7oIAZmpxunqD7PQtGlMtd9LxJEFpX+BPNqGWIqyj7hGTxabHNbl/elNRvGnC/wKVdjnRMneS9QNJEQ6lk0pMNb44GtAUKB+RCNhtTVcuTYZesE7nLXRtSAqLNFL4pq363vLykDymI4DyW+zNoqdlb+9crkxvPh9OcOt+efqbkRG7D6VyoXvZ5mR5diD0l53bXAqS592sz9QCzCAMUOSDCxqndQxGe2f1OY3sJD5zonWC4/WSblPWyhTe7XPHrsZ91k2lQHk8OnKU2+llI+3iHxzatGSiRZA5GeRAvIY299kTpBuZMBEdqVFbWfKng7wPrIeYofZXPbcYlsUzvddVnMimYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(376002)(136003)(39830400003)(66476007)(64756008)(8676002)(66446008)(66556008)(76116006)(66946007)(8936002)(41300700001)(966005)(71200400001)(36756003)(316002)(6486002)(478600001)(5660300002)(110136005)(6512007)(2906002)(26005)(2616005)(186003)(86362001)(83380400001)(38070700005)(6506007)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEd6YmF5VXNVRzJOY2s1dHlSL04xVzlwQnlYdnR3N1J3M1YrKzYwVUtMdVE2?=
 =?utf-8?B?ZWxtcUhMbnkxTEl2LzBrckZVQTlzdkJBSWp2Q09Tcjhmb3ZCOFFUTDNabmhl?=
 =?utf-8?B?dFhxQlNjenhkRkM4aEIzWjZaZEh2YXh5V09GRktuVEFQRzNuZ3pXSHhqL21o?=
 =?utf-8?B?VnEvZ3VPZEZRZEVEWGlPQmMxSEpqbE50MkVIalVDelFlbG01aDcvVWw1ekUx?=
 =?utf-8?B?ZHIwZTlNRDVNMmZPNVQwNnk4d0srdU1hcHRRSDY2d040V21vZllNbW02cXVY?=
 =?utf-8?B?NkJ4YnNHTElad3dXaTYxSlpTVXBHaXJNdkgxcE14a0U5ZExxQTZLNEpEMWJq?=
 =?utf-8?B?TDlDNlkzekd0UW9WTUVKYjRwelNsWUJUaXBkQkU4ZzVmaU9xWjZ6SStqVXpI?=
 =?utf-8?B?NXpwUUxCVzZvMVc3T3owZ0QrL3pGWFFVNUlCZFI5Rm5yUG5qU1diMVhuWjAy?=
 =?utf-8?B?RlU3Nk5KSThTMllSK0Q2aEp2VlNqZkVrODZRRlJxenVURGQ4ZUdKZ1NGZmFo?=
 =?utf-8?B?NGovaTB6ME5mMjJsOWx6dzRlRVdmMFQ2OTNYeWVLR1ZUV3FOT1BXNjlKY29P?=
 =?utf-8?B?M3NUaVovT3ZXbmkxRFNsMDV0Tk9IQUxtQlZUMFo5YXNjS3hvQy84OGtURjBO?=
 =?utf-8?B?RG5FcmJaNFlGQktWWTNWRzZoRDkxRnpmRGd3WVZCQWFSZG5EUjZNb0ViVUl1?=
 =?utf-8?B?OU1YdGJTZ1lqUjlWczFQdUhOemtkRi8xVFlRcWxYYUpEOERyaitlSmdJUG9n?=
 =?utf-8?B?TUlkTFdqS3pTR3RNcDY2eTJpeTZnQ29xMWU2c3VRRHVod1RnYTNHaW1tZnRa?=
 =?utf-8?B?bXBFOVZTVEtlcURFTG1DdEpBdDV3TlVwVGxFb1BVYmtNdFZFd05ucE1hMGNy?=
 =?utf-8?B?cmZnVFNHdTNERkpCUEk1alVmcXYvV0tWOFQybWhmQm1kaEJqQWs1L2xJM2hm?=
 =?utf-8?B?TW9UVDdrQVBidzR2Mlg1WFo2ZzI0c04zTWx1MTBtVFhmRFcwZEFEZVZVSFlz?=
 =?utf-8?B?Ykp6bWJ5LzlaNEkzVFowU3RSc2RhTGV3ZWtFQUovQUJWTzZkWEhFNlppQmFy?=
 =?utf-8?B?Nm00VFhSZGJraFM2SHVIMkpjTURtTXJ3UlMzWEZ6SHRFQk52ZzkxTjVKU1JB?=
 =?utf-8?B?clNjTTkvaUZiMXBmMkFNUUJXM1dmQ0dMVmc3S1ZMa29NcXBqZWcyQTJ3eFNV?=
 =?utf-8?B?WmVXNEhsZ3Z4ZVlhS01ibDQ2WU0rZnlpb1huWUgxRVZLSi9mSC9NU0I2Zis0?=
 =?utf-8?B?Y1hhNUhuZkJVUDZabG91bDc1elk2RGpDc2lRL01MdjFZL295ajd3bklxenZk?=
 =?utf-8?B?TmpQVmZXUmRhNXR2dDUxOVNNTlVqN0ZVUlEzSFlJSDNqVTNBNkJxamQxb3hF?=
 =?utf-8?B?RStmZWd2QUVYcEMzRWZUT1Ribncyd3V4dkE5V1AwRTZ3U3RnRXRWSzIxaGFZ?=
 =?utf-8?B?cVhwT25xZnZWL3pjelZZV0MzRDZXUUhBM3VZc1h6a09xbU5PYlZYOUlOdTll?=
 =?utf-8?B?d1FLNkZWT2diZzZPL0RyMkRCRnFlWTJtWE5NaHZ3Yis4eFRCK1MySlJwaSth?=
 =?utf-8?B?VWx2S2hJd2pMOWdzME5xMEdDaGJ1QVhpNS9jRWtOblJLMWlxZ1dwRDNQNmVT?=
 =?utf-8?B?R2JETi8xUHI2Y2ExYnJNVzcwbGttM2UrdHJONnRDWFM4bldMMUtXeWdmT0w2?=
 =?utf-8?B?MWZieUUySytZUllSQlhTQ0pYRm5XVksreWl1UmtPZG13RmNNQUZyYmN4eWtB?=
 =?utf-8?B?Sm5sRzZTUXB3N09QWDl1VVVxamZrQm5rUmNwb2FsVFRyV1RweEVqMWlVbzVX?=
 =?utf-8?B?dFhhNlkrVG9kcDc2c21tZTAwOTZodmRWUHBkU0JDRzMvWUZWYUlqc0g2a1Fv?=
 =?utf-8?B?UW9ZUjIrS3BtZFF4T05hK0FNTXlEZmZnNG5wTDFDU2RpSFFYLzFEMEMrNThy?=
 =?utf-8?B?SXVKZVcyYkxjL2Uwb3hDa2JjVWh6UlBwdXFUNmo2K0J1WkFZVWVDNU9YQUxW?=
 =?utf-8?B?eG02NnU4eWhtN3hPUWpGL1pFbFZKaWZENzV4QVUrZzdqN20yR3pnT1U5UThj?=
 =?utf-8?B?M1FIL01UWEpyNzVLdnY0dVloTDBzSGlnbVlvNCttQk9IMmgva0VWbkY0UWhu?=
 =?utf-8?B?NSs0Tmlqd3FZbmFDV3ZwQ0YrZms1enNBTy93WFZ4SjJKZE1jUXBISXZhUzVs?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <359461FDBCEDFE4E8E9B7D6E885CA82B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977dc605-80e9-4e1b-e6b3-08da8446f5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 14:02:33.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hipJawTqGy2BLDTi889at+JkbE0F8L+RAGEADWAtkg0FMFx0vmsEWqL7lcrDXepjJCpWpUarxQBuJmmGGryDfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTIyIGF0IDEwOjE2ICswMjAwLCBJZ29yIFJhaXRzIHdyb3RlOg0KPiBb
WW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGlnb3JAZ29vZGRhdGEuY29tLiBMZWFybiB3
aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRl
cklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiBIZWxsbyBldmVyeW9uZSwNCj4gDQo+IEhvcGVmdWxs
eSBJJ20gc2VuZGluZyB0aGlzIHRvIHRoZSByaWdodCBwbGFjZeKApg0KPiBXZSByZWNlbnRseSBz
dGFydGVkIHRvIHNlZSB0aGUgZm9sbG93aW5nIHN0YWNrdHJhY2UgcXVpdGUgb2Z0ZW4gb24NCj4g
b3VyDQo+IFZNcyB0aGF0IGFyZSB1c2luZyBORlMgZXh0ZW5zaXZlbHkgKEkgdGhpbmsgYWZ0ZXIg
dXBncmFkaW5nIHRvDQo+IDUuMTguMTErLCBidXQgbm90IHN1cmUgd2hlbiBleGFjdGx5LiBGb3Ig
c3VyZSBpdCBoYXBwZW5zIG9uIDUuMTguMTUpOg0KPiANCj4gSU5GTzogdGFzayBrd29ya2VyL3Uz
NjoxMDozNzc2OTEgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMiBzZWNvbmRzLg0KPiDCoMKgwqDC
oCBUYWludGVkOiBHwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFwqDCoMKgwqAgNS4xOC4xNS0xLmdk
Yy5lbDgueDg2XzY0ICMxDQo+ICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190
aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMNCj4gbWVzc2FnZS4NCj4gdGFzazprd29ya2VyL3Uz
NjoxMMKgIHN0YXRlOkQgc3RhY2s6wqDCoMKgIDAgcGlkOjM3NzY5MSBwcGlkOsKgwqDCoMKgIDIN
Cj4gZmxhZ3M6MHgwMDAwNDAwMA0KPiBXb3JrcXVldWU6IHdyaXRlYmFjayB3Yl93b3JrZm4gKGZs
dXNoLTA6MzA4KQ0KPiBDYWxsIFRyYWNlOg0KPiA8VEFTSz4NCj4gX19zY2hlZHVsZSsweDM4Yy8w
eDdkMA0KPiBzY2hlZHVsZSsweDQxLzB4YjANCj4gaW9fc2NoZWR1bGUrMHgxMi8weDQwDQo+IF9f
Zm9saW9fbG9jaysweDExMC8weDI2MA0KPiA/IGZpbGVtYXBfYWxsb2NfZm9saW8rMHg5MC8weDkw
DQo+IHdyaXRlX2NhY2hlX3BhZ2VzKzB4MWUzLzB4NGQwDQo+ID8gbmZzX3dyaXRlcGFnZV9sb2Nr
ZWQrMHgxZDAvMHgxZDAgW25mc10NCj4gbmZzX3dyaXRlcGFnZXMrMHhlMS8weDIwMCBbbmZzXQ0K
PiBkb193cml0ZXBhZ2VzKzB4ZDIvMHgxYjANCj4gPyBjaGVja19wcmVlbXB0X2N1cnIrMHg0Ny8w
eDcwDQo+ID8gdHR3dV9kb193YWtldXArMHgxNy8weDE4MA0KPiBfX3dyaXRlYmFja19zaW5nbGVf
aW5vZGUrMHg0MS8weDM2MA0KPiB3cml0ZWJhY2tfc2JfaW5vZGVzKzB4MWYwLzB4NDYwDQo+IF9f
d3JpdGViYWNrX2lub2Rlc193YisweDVmLzB4ZDANCj4gd2Jfd3JpdGViYWNrKzB4MjM1LzB4MmQw
DQo+IHdiX3dvcmtmbisweDM0OC8weDRhMA0KPiA/IHB1dF9wcmV2X3Rhc2tfZmFpcisweDFiLzB4
MzANCj4gPyBwaWNrX25leHRfdGFzaysweDg0LzB4OTQwDQo+ID8gX191cGRhdGVfaWRsZV9jb3Jl
KzB4MWIvMHhiMA0KPiBwcm9jZXNzX29uZV93b3JrKzB4MWM1LzB4MzkwDQo+IHdvcmtlcl90aHJl
YWQrMHgzMC8weDM2MA0KPiA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzOTAvMHgzOTANCj4ga3RocmVh
ZCsweGQ3LzB4MTAwDQo+ID8ga3RocmVhZF9jb21wbGV0ZV9hbmRfZXhpdCsweDIwLzB4MjANCj4g
cmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4gPC9UQVNLPg0KPiANCj4gSSBzZWUgdGhhdCBzb21l
dGhpbmcgdmVyeSBzaW1pbGFyIHdhcyBmaXhlZCBpbiBidHJmcw0KPiAoDQo+IGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29t
bWkNCj4gdC8/aD1saW51eC01LjE4LnkmaWQ9OTUzNWVjMzcxZDc0MWZhMDM3ZTM3ZWRkYzBhNWIy
NWJhODJkMDAyNykNCj4gYnV0IEkgY291bGQgbm90IGZpbmQgYW55dGhpbmcgc2ltaWxhciBmb3Ig
TkZTLg0KPiANCj4gRG8geW91IGhhcHBlbiB0byBrbm93IGlmIHRoaXMgaXMgYWxyZWFkeSBmaXhl
ZD8gSWYgc28sIHdvdWxkIHlvdSBtaW5kDQo+IHNoYXJpbmcgc29tZSBjb21taXRzPyBJZiBub3Qs
IGNvdWxkIHlvdSBoZWxwIGdldHRpbmcgdGhpcyBhZGRyZXNzZWQ/DQo+IA0KDQpUaGUgc3RhY2sg
dHJhY2UgeW91IHNob3cgYWJvdmUgaXNuJ3QgcGFydGljdWxhcmx5IGhlbHBmdWwgZm9yDQpkaWFn
bm9zaW5nIHdoYXQgdGhlIHByb2JsZW0gaXMuDQoNCkFsbCBpdCBpcyBzYXlpbmcgaXMgdGhhdCAn
dGhyZWFkIEEnIGlzIHdhaXRpbmcgdG8gdGFrZSBhIHBhZ2UgbG9jayB0aGF0DQppcyBiZWluZyBo
ZWxkIGJ5IGEgZGlmZmVyZW50ICd0aHJlYWQgQicuIFdpdGhvdXQgaW5mb3JtYXRpb24gb24gd2hh
dA0KJ3RocmVhZCBCJyBpcyBkb2luZywgYW5kIHdoeSBpdCBpc24ndCByZWxlYXNpbmcgdGhlIGxv
Y2ssIHRoZXJlIGlzDQpub3RoaW5nIHdlIGNhbiBjb25jbHVkZS4NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
