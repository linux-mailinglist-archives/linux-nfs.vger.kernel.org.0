Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8362342FCF0
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 22:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhJOUVb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 16:21:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21736 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235360AbhJOUVa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Oct 2021 16:21:30 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FJjBgA013279;
        Fri, 15 Oct 2021 20:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0RU39u7WCBUCKEqdxQZLx8ifa7E52ux0WSL1ebCZYCg=;
 b=ABbm3kmy15o6CeO9TNGqVrjWCG+PDQnKHz7e1MOCL/57itWZPqf0w8hyVdJFRZjh0STb
 acGK+WHWI54//wdUEXDpZmj6qH5Wyq+nEoTQKlaBjkpiO082vy07UAEqe3CdvKhPgBXp
 eMfQUDzd4v5GD/WvOdbQP6Ladj5bVquHEXwKGPvBREbkoUVJxqkcC/oSymWbsRpm0w1L
 c9k3h5kENnZKtgKwmTxvztxgBFHrOwRrR71TL84sXdjzHfxZF9TLoq8PK0GQ3JSZKCTT
 ERYYWNaDdSogEUwcD1MgY89BWY9AHNc2ZnEKzKbJPq6ZdjaKCm6Wt8f0xBmSSVt6nld3 dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqbgp9yv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 20:18:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19FK1Hhu090715;
        Fri, 15 Oct 2021 20:18:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3bkyvf02pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 20:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxYly8BfQQSordL878fcL4IupNJt+kjsHhdkJpn3cFSjCUdEDOhVvJYQoRZ1MUxEDYcVmEqf3kRoO5ZyNDYgicrG4gth7fAuUWEYPmBucfr51P5MJyy/TjTIa56/zs764R8VvpdMSvdJVi8Mrzc7ZMtVzdrB852rZfkdVgMqEdT/iHt0KzqW4rttZLRnfvh+vCyLpwdDd+HvXyBuyaAjgtk9T+K+CfuVtqlXe23jzIg847bRuKIrcpcSdNInRJQbOaGIbc/JhY7BWKdehKiIZB5BoxRFwsEUzSHNxi8FSAizoaoHxKXJd6u1Ii0uJQGy4O/u+QAOs+amilkYSN4plA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RU39u7WCBUCKEqdxQZLx8ifa7E52ux0WSL1ebCZYCg=;
 b=kCT25dl3OlCpz5TjZllGpzD2C1ww3diLGkBwbePgdUTgJuHBD9n20+r+uqB6BpgVZ4+1nUsTFpLRit8yvW1evJ+79dGsEOwEV8rZdGFKXPTovlQWgcRgWRGkwa73/Q+Bn9698nyVQv1Quy95i7euzngSG2b+sFJCKpG51T1fG2gKYcfy19q1h2pdYSfbV35U4BqRXopM0lSBlCusHpEE9hIf5VuopjaTOIkY+sGuOTSTDiSctqcnxxvhIbkvdOmttzr5sIT9IxLxMn5E2cgm6M08Z580FFodSRJBjqVTXKwYVxHamAsE9PnQUh9OVkae01tQnziS2mitxYLHlEZohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RU39u7WCBUCKEqdxQZLx8ifa7E52ux0WSL1ebCZYCg=;
 b=nN9jI1mJmSNKceXM5G/7HCFM34VPPXTll+Kmy4F+Ade+8AYnVm/Xh1KT/Qr2Mdy3gqKKPQRrSwvyOHeekjhnYHsT608KhMghQ3WZqjOYctS/8A03WZFSRtqqT6WcY655t/ThLGDj5xEDMKB1ETd4Q+sqx9q/7woGF0qjq3KnWxQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2439.namprd10.prod.outlook.com (2603:10b6:a02:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Fri, 15 Oct
 2021 20:18:40 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 20:18:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] NFS: Convert from readpages() to readahead()
Thread-Topic: [PATCH 1/1] NFS: Convert from readpages() to readahead()
Thread-Index: AQHXu9PCTxWz7e0uNku4Se2Jl0pkd6vJJJuAgAqUFgCAANNXNg==
Date:   Fri, 15 Oct 2021 20:18:40 +0000
Message-ID: <E3E18FD8-5895-4C4D-90BF-2588A3C346E9@oracle.com>
References: <1633649528-1321-1-git-send-email-dwysocha@redhat.com>
         <1633649528-1321-2-git-send-email-dwysocha@redhat.com>
         <3F1E7B93-EB8D-4744-8143-D44654CA6451@oracle.com>
 <1fe6dbeac820b58f0790dcff492b62b7dd7e4fea.camel@hammerspace.com>
In-Reply-To: <1fe6dbeac820b58f0790dcff492b62b7dd7e4fea.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a3c4e98-7b76-4b74-01e2-08d99018faa4
x-ms-traffictypediagnostic: BYAPR10MB2439:
x-microsoft-antispam-prvs: <BYAPR10MB243943448E82CDD3C3983AF993B99@BYAPR10MB2439.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V979x+2zCjIBXeA71j3hOeRPW3iVBqtTFBKq/zoZdS/6bf3Y08cia0MjTf15NtdXp5DvKvg845JiS1gbBZRqWWbiCRmnqCPhZ0hCPHIE1fxpTJ48Yykbg8IqYURharKMRFf34oqPsLoiq3vfeyuG8st+o9eHSy/U9C1wmelxXj/6oJsgGOEcF61FOvTkNqm5EaAwTJ9pFrLk5D0gWHgRfk/dBir0DqxR/h8+lnumb0/nldCYLXAOLkLoef+RrJnwSx13A5MWe+yOg+tzNPPgwTBuABpswVSRzLlwyNXNnszWmK4NELzEIpk7FXJryn8a3cNX0AFlnqZzer2wHrxi7Ik7xuX6dSEyb91dRAHm7S34BMakaemWAyEa3rIIrVDHCIs36VBz/aNlmestMetVIDQIrDQyF7LgvK0CikH8elSlPDLGPm9ndxVMetRykNjHpGxJ6dWJpyV1uHoZnltDsRjKDw3OcvuhMdinrBGN6hzRYRKIHvNoYj8QzkbLIkoYJ+0NfEg0y2r/I7pYtC41Wkj4PXpMrfSqMUIGxHbIrZenAMXjXi3HAg16av6FM7+rl8Pyq35SvBiE7hgZGl4D6zsZmDjn+zrtmrWgHceJQ5jRCq6wynD0/k8xMBgbpxSseU9wlRlBzYLqB90EtNiHu3sjSA237FFwVGlVTWXtsi0fVjUtiSUMXlgYNLo36ZYb0c3GEHiOgImz0yt0nVFRsjLGOZjzjKJ8w+ezOYOHXCE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(8676002)(2616005)(91956017)(186003)(33656002)(6486002)(38070700005)(4326008)(2906002)(86362001)(76116006)(6512007)(508600001)(53546011)(54906003)(66446008)(6506007)(66476007)(66946007)(38100700002)(316002)(83380400001)(5660300002)(66556008)(64756008)(122000001)(6916009)(71200400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajJBaU1iZVYvU3pxeEdmcEZBaHlqQ0wwSFFzNTVDc2RSclkxUFdxSnZUQlJW?=
 =?utf-8?B?YXU4aGdxNkRxa1JJdGpCR2NVRG9XNHVNczdpWFl3N29LdHNzZkluZEN3bXV2?=
 =?utf-8?B?ZStYQ3Z0OG55OGEzUnNCM0hlaVNCS3pybG1QS2tUNmdBdDUzRzRIQjJtUnZZ?=
 =?utf-8?B?STV3cS9ySThNSDZFLzVGYWtIWFpLZ09GZXpqVEhWRktScGZpZnJJa0FUd3dz?=
 =?utf-8?B?MnptU0xBTmNUUkV0OXJ1MWlXTjJvS2p0TTNvN2FDSHFVeGFJbTFyRkVoUmp5?=
 =?utf-8?B?dTlxZ0RHZDlKQ3dUU2czNWFmZmNMRnRnYkhqRmpZNTJTSndibEpPSWwzejFE?=
 =?utf-8?B?WSthZUc3b05ucCtXY2tpK0JRUzEwZDk3WEZLcHdMendWYXQzeU8zWDViclZV?=
 =?utf-8?B?SkowbTZxTmE4M1dSVzc0bG92dVNmQlMzby93WlUwUWhVMGJ3L0htRU5ZcUN4?=
 =?utf-8?B?bWRzcUFsNjBTbFgrL0xhd2JVL21hYndCbDQ0R1JzTlpwUXo2cDhIbUtQSHRC?=
 =?utf-8?B?QWR5TE1zajVHcTY5RjI1akRBaGUxS0RyOXppOFNjdEl2SkdVeDFsR28rZEtB?=
 =?utf-8?B?VTRGNnZjM1lpR1RXcHM5aFNWVHlIK2ZUa3JYTlNvUzArV0FaM3B5OUVJaDVL?=
 =?utf-8?B?TGx1TGpzbW8ralRKT1RQVE01TTdQWW80TldwRW9TdnByVFZIblRENHV5Wm9j?=
 =?utf-8?B?clUwb0pyZmlBNiswSFFYTUZPS3A3UHp4cUV0T1IvZW0zU21vQXpwRkR5K05J?=
 =?utf-8?B?QlRLcml0emNiUndudDl1cTNxR1p5SFVBNWN0OGFwYkE4dXJ2WjlZRjIzTFFi?=
 =?utf-8?B?M0xWMzcvdTBwSGsxZjE4WG5Ud1FBMGZ4T0dHdXdCM1phdjJnbTRJaGFHQjhT?=
 =?utf-8?B?VWlMY2ZZbkdqMXJma2pyaDdlSlQ1RFUyNjdsN3NOSllJSldKd3lKUi9CZWlC?=
 =?utf-8?B?NGdEakRkNTdGUElXMS8wa3pyWDRUT0xQUFVPVGpPSjVVdFFGdkV5VkZDeGQ3?=
 =?utf-8?B?aDBZdTNOeHBVWWdYRUFTMjZ0TVlEbnJDR2ZyL0h2dk5yc1pnVVQ5dHhaaVVr?=
 =?utf-8?B?a1BpNTAzSzYxektwNW9RVTF6VFFwc1BLUW5DN2Y5cVZUT002NEVnZkZRNDN0?=
 =?utf-8?B?WndBZFZwakozYjNkbjBZUWJXTUJFZ1J6YVRvNmhzci9vdTB3YnVBYnBoSTF3?=
 =?utf-8?B?bVRnWUJ4NHMyWE5mczFsZTMrMDB2dmxURzhzTHNvYzZtem05WEltLy9wdFZl?=
 =?utf-8?B?czVsR05nTTZkUS9vM2RwalZXbms2R28wdXdzSGQ5KzZqVUJnVG5CMXVzUFZZ?=
 =?utf-8?B?YWpmMHQvVit5eCsvWW1tblFvWFlSb2ljQmIzWEczMFduNytCcHh0RDFKNHZ4?=
 =?utf-8?B?R292eXpIaTJFOXJ1THByeHljRmxmanBycHJFUG9nZUVaQ2h5TG1mdTdwcWts?=
 =?utf-8?B?cnBjVy9jbFQxU0h2UTlzc0ZIc1U5T242Q2ZVeTExdUYyL296d29yVitmMldE?=
 =?utf-8?B?YlJwNlFjRVU5WlRqSzc5N2RCeDNWbWRRMFQwWTRqTDlsUERDUThoNlV0dEVa?=
 =?utf-8?B?M0lGQ3R4eWtCV0xBWVdvZXFVYVlqVGlJWWFZME51bFVMN09TSkxGZXZCUXM4?=
 =?utf-8?B?QmhvUkV5V3BLZGF1RnBSVUMyMUtDbXhhcE5HNm5VZlp5aXRUVmZVcFV2cm5I?=
 =?utf-8?B?aTVRekYyOERjNU0xd2t3R1dCajhldmVjTWJuaStlQlExdm5lTVJCWjBRWTFT?=
 =?utf-8?B?WGdKYU1zV2NkYW1sYjBxemJzazJ2SkN0UFl6cktYZzgxR0dnellTeTJlK2o4?=
 =?utf-8?B?N2xqNkVmQkYzSnpjbHRxRm1rbDhzU3ZJOUFSemw4WHFHcmtRNG14cDZiM1or?=
 =?utf-8?Q?GwqiJTJF9ntOT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3c4e98-7b76-4b74-01e2-08d99018faa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 20:18:40.6839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhFy9set0V9g133a9Eh3oUas1SbFjjQw9D/4IjAHZg0b5ny4jgodhwuuuNkPGsXWkAd7tKXKaTfyhn99RpXFQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2439
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110150121
X-Proofpoint-GUID: 5ZX0h6W1Zhl5mS9orVrtwrPOUcfqM99m
X-Proofpoint-ORIG-GUID: 5ZX0h6W1Zhl5mS9orVrtwrPOUcfqM99m
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIE9jdCAxNSwgMjAyMSwgYXQgMzo0MiBBTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9uZG15
QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBGcmksIDIwMjEtMTAtMDggYXQg
MTQ6MDkgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gT2N0
IDcsIDIwMjEsIGF0IDc6MzIgUE0sIERhdmUgV3lzb2NoYW5za2kgPGR3eXNvY2hhQHJlZGhhdC5j
b20+DQo+Pj4gd3JvdGU6DQo+Pj4gDQo+Pj4gQ29udmVydCB0byB0aGUgbmV3IFZNIHJlYWRhaGVh
ZCgpIEFQSSB3aGljaCBpcyB0aGUgcHJlZmVycmVkIEFQSQ0KPj4+IHRvIHJlYWQgbXVsdGlwbGUg
cGFnZXMsIGFuZCByZW5hbWUgdGhlIE5GU0lPU18qIGNvdW50ZXJzIGFuZCB0aGUNCj4+PiB0cmFj
ZXBvaW50IGFzIG5lZWRlZC4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFd5c29jaGFu
c2tpIDxkd3lzb2NoYUByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+IGZzL25mcy9maWxlLmMgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4+PiBmcy9uZnMvbmZzdHJhY2UuaCAgICAgICAgICB8ICAyICst
DQo+Pj4gZnMvbmZzL3JlYWQuYyAgICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKystLS0t
LS0NCj4+PiBpbmNsdWRlL2xpbnV4L25mc19mcy5oICAgICB8ICAzICstLQ0KPj4+IGluY2x1ZGUv
bGludXgvbmZzX2lvc3RhdC5oIHwgIDYgKysrLS0tDQo+Pj4gNSBmaWxlcyBjaGFuZ2VkLCAyMSBp
bnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZnMv
bmZzL2ZpbGUuYyBiL2ZzL25mcy9maWxlLmMNCj4+PiBpbmRleCAyMDlkYWMyMDg0NzcuLmNjNzZk
MTdmYTk3ZiAxMDA2NDQNCj4+PiAtLS0gYS9mcy9uZnMvZmlsZS5jDQo+Pj4gKysrIGIvZnMvbmZz
L2ZpbGUuYw0KPj4+IEBAIC01MTksNyArNTE5LDcgQEAgc3RhdGljIHZvaWQgbmZzX3N3YXBfZGVh
Y3RpdmF0ZShzdHJ1Y3QgZmlsZQ0KPj4+ICpmaWxlKQ0KPj4+IA0KPj4+IGNvbnN0IHN0cnVjdCBh
ZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMgbmZzX2ZpbGVfYW9wcyA9IHsNCj4+PiAgICAgICAgIC5y
ZWFkcGFnZSA9IG5mc19yZWFkcGFnZSwNCj4+PiAtICAgICAgIC5yZWFkcGFnZXMgPSBuZnNfcmVh
ZHBhZ2VzLA0KPj4+ICsgICAgICAgLnJlYWRhaGVhZCA9IG5mc19yZWFkYWhlYWQsDQo+Pj4gICAg
ICAgICAuc2V0X3BhZ2VfZGlydHkgPSBfX3NldF9wYWdlX2RpcnR5X25vYnVmZmVycywNCj4+PiAg
ICAgICAgIC53cml0ZXBhZ2UgPSBuZnNfd3JpdGVwYWdlLA0KPj4+ICAgICAgICAgLndyaXRlcGFn
ZXMgPSBuZnNfd3JpdGVwYWdlcywNCj4+PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mc3RyYWNlLmgg
Yi9mcy9uZnMvbmZzdHJhY2UuaA0KPj4+IGluZGV4IDc4YjBmNjQ5ZGQwOS4uZDJiMjA4MDc2NWE2
IDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25mcy9uZnN0cmFjZS5oDQo+Pj4gKysrIGIvZnMvbmZzL25m
c3RyYWNlLmgNCj4+PiBAQCAtOTE1LDcgKzkxNSw3IEBADQo+Pj4gICAgICAgICAgICAgICAgICkN
Cj4+PiApOw0KPj4+IA0KPj4+IC1UUkFDRV9FVkVOVChuZnNfYW9wc19yZWFkcGFnZXMsDQo+Pj4g
K1RSQUNFX0VWRU5UKG5mc19hb3BzX3JlYWRhaGVhZCwNCj4+IA0KPj4gSW4gdjIgYW5kIHYzIG9m
IG15IHBhdGNoLCB0aGlzIHRyYWNlcG9pbnQgaGFzIGFscmVhZHkgYmVlbg0KPj4gcmVuYW1lZCB0
byBuZnNfYW9wX3JlYWRhaGVhZC4NCj4gDQo+IERvZXMgdGhhdCBtZWFuIHlvdSdyZSBnb2luZyB0
byByZXNlbmQsIENodWNrPw0KDQpJIHJlLXNlbnQgdGhpcyBvbmUgcGF0Y2ggYSBmZXcgZGF5cyBh
Z28sIGJ1dCBJIGNhbiByZS1zZW5kIHRoZSB3aG9sZSBzZXJpZXMgYWdhaW4gdG8gYmUgc3VyZSBl
dmVyeW9uZSBoYXMgdGhlIGxhdGVzdC4NCg0KDQo=
