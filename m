Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA804AE384
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387315AbiBHWW6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386410AbiBHU2F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 15:28:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2091.outbound.protection.outlook.com [40.107.93.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40F6C0613CB
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 12:28:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3i32yv0eMsF6w8mfUP71ogN9u+SOw2RlLA+TFxrWv9AXzRa+O5dj2Mq8S6enHZyTZjmutNBXoU7sPOS0jvySJfOrCUvvmCbIL2wmddb8scsxUQWhEvfBN+JTyrIqwW8utDcxV8eMC+tmOx1y4YOiyXsoH/zh7FcWDRtsJ0ijtT01cTAcohYLcDE3iG9/cwbb4NtIZEATqpdpprPfWYENzeYSvfjbAc3Kl2LXIdcvN5Vl2f7wkHMn0mg//Go6llZmD2TcCDcbd1m6n4p+/eY7ryFgWEzaCxzOPkk/5ten242teRvmOKbpPiFWLQYIiJa1BGCv52ZnmQoVZZCCMk3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGtIMAZhLUAAfNugR9/SqeGpmcIVecQAChfv4pVVVoI=;
 b=g5q0r10mnFvOLT+9CJy20NbCmUn96NQkOj0X6KfFlXZSx0PblBzIOtzj4KpUwPIGmgUkRHn9bL4ShPVj1iNRL3GEdqOpVJMpSbusGXx5ErxBLoDt9LP8QIdz4KzIUu/IT/QiiEnlW8L1cygj0RlLmLzuTyjvhhVKqlK9XNtPd5KLiLYLfLoKbmBor4JmoXEhCN0FSXZbcGTMqNLJb6mrk7bfotsa+y8CMXorOUeggeJzbfmSRVCuwP3xfoFpt4dTWV9zimn7fxQFkn+XwNiD0jAMVAzzJp/gjRaEX4dWvMagDRI4lITYHHWqcKsXD5ggTIKv/0velJClydmOtlW+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGtIMAZhLUAAfNugR9/SqeGpmcIVecQAChfv4pVVVoI=;
 b=LBHwVwKeka5YRgAG71wP4irAYTh7LN3K0sKkZXqm9QoL7gBZQ9TZdnC2A/g2/KBOHvhpkRcbZiD883RgiDrr4nT867wu5wzmgPsaBY9gSezJ4unKFCnpHHxu69GfmP16prysVA9KT3vnexk1Pf46nj5xpt+PNR20mZ5ucvXUNJc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR1301MB2199.namprd13.prod.outlook.com (2603:10b6:910:41::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 20:27:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 20:27:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Thread-Topic: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Thread-Index: AQHYHScFlqCFQx4T40K//9/WiL9wzKyKGmaA
Date:   Tue, 8 Feb 2022 20:27:58 +0000
Message-ID: <189aba691b341f64f653817c9cdf018ef34ac257.camel@hammerspace.com>
References: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
In-Reply-To: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1140e76-2038-4475-636f-08d9eb417ed7
x-ms-traffictypediagnostic: CY4PR1301MB2199:EE_
x-microsoft-antispam-prvs: <CY4PR1301MB219975DD86DB021C84C527D6B82D9@CY4PR1301MB2199.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BpO1D7iSLq9hcctAjjbQas2/IXWdne8uwizKBRfIECJX95hn5n8JxBg/gb/vaFUZc9xbs/dhyL1octxCf1Sq/I9RngXybb6HQXPhjuNJ6cjbuEZCN3dndsAGKvVMv1QDMUZn3J/TeFyzCHFjLV1QTlp51d4NkyqaiHLbeO0L8SraLkM+z3HQ6vy/03r+zFyuBfs4Hhj7rP16ixj1/D/Ob90s6xPKjaKwOacjqYr4bqm/r2b1fzSPSnvuz1m/nIuAKWrnJTRAzadBk2CdwvcDqpBxR+cdVnGkrEnwqitNg3Q7vtttxieA3jY4S156RY3m3rBqOLsnO5MKN8pRhofyX8sexzGQR4UG6qmhhLOWJaiWF0xHeK3EQ/p8GHyQkDf97zD+gonODM3h1cKBjaPQHIYOwBkusbffaYroHweBrUaUwgGQcQ86ndwLgnP3HOIZqKXOESW5hYpBuNbSYaJl91gzYzDjDIVgd8qb4BlVFMFW7G1UlE9HKeGVNOJbzCfEOI2XeFb/KsrmAlaXsEXTBcEgXj/lL9vYsF8PaBU0IvL1olNHDo6x/aTJAMq+h/tyaa4koJV6+RFvI4EipZtodiHya9xNCqojBOMlqag6mlcWBXhW1JBb6idVMF8NPRIj4vYVkjAvhRsz1BGl+X2nt+PJgj/8BI8u9ZoYUUB4+jptWMLbnvNS8sIAtebXiz2htjPIPy0xHZ3jKeEhzNCV6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(86362001)(64756008)(66476007)(76116006)(4326008)(5660300002)(122000001)(6486002)(36756003)(66446008)(83380400001)(66556008)(38100700002)(8936002)(110136005)(38070700005)(316002)(6512007)(71200400001)(2616005)(26005)(6506007)(2906002)(186003)(508600001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjl5K3JCOE1qNmNBT21ySlZJQXJEbG9XUlVrUHo4WDdkWmhnLzY4Z1lBQXFT?=
 =?utf-8?B?OEpTekhxbEJ3NDRaQ245cEJxeDF5amhhbjJGRG5vdEdUOXF6S3RUTzAxc2p0?=
 =?utf-8?B?S2xoYXpqZFFsUFNqWUVrU01ta1BRbXJFNkRpL0kwWGJVRjMrR1RaRUtaRG1K?=
 =?utf-8?B?WjNaQk9QemtzUEVZT0hEbnliUlJVOFBkdU9HK0tGM1paTWJ4ZE1DdVFPVHp1?=
 =?utf-8?B?cnVqeXJOZHo2SmhBT1dXbkNFZlNlOGd6NkxNczRTUHlTNjRRbjhpTFkxOU8r?=
 =?utf-8?B?YkIvcHJUMEVkTEtiUG5NdWdqcTN2UlNUbVliZVFDYUI1TElzK3I4M0Zncngr?=
 =?utf-8?B?UUNib3J6cGxhZVVabEZHZDBGSkIrWldOZXJhY0FBaHJtUXdBSHN1b1B6TTll?=
 =?utf-8?B?UDZrd21xQnNXK1VsSTZ1dlROZms5RTNVZktDMlFTZyswa3NNM1FjZFdWSE5G?=
 =?utf-8?B?ZmxOc3pVU3NaZHJlOHNqNHFuVG9OSFdmamhSdEJuMUpFeS9pR2I3MUtwVis4?=
 =?utf-8?B?VXpRSWxoSlRXdzBsa3QyTGx2TU8vNDNDSGRUSUNYamJnTHNpS2tWZjlzTVIz?=
 =?utf-8?B?N0lkWTdrL3lUbkhmNjJDTTFxS0Z4YVE3TUM3RXlmK1dFR3ZlUSsyVUJYdlc2?=
 =?utf-8?B?ZHJia0F6bE5UNElIbjJRdzZCbXBYQjRVV1IzblphRUdtaXJFWVNZZldiMzRj?=
 =?utf-8?B?VEh3ZnVvdjJ0ckh3WGlqcXBaQ2V2RUFGeGtqUnpRMVhaMUhDclNOWHlNK3oy?=
 =?utf-8?B?Q2VxZDZsN1RxWXVreTA3UjZlYW95K0VrNU10Y2praUxGWnhjTGhCWWh5ZDA0?=
 =?utf-8?B?OUlhMi9VcGVWajFJUDBJbFJ6T0JlMVl0YUJCaHJwcFZxVFpzNi9MMnZ1T3M0?=
 =?utf-8?B?Qk92UUduMVlBUEFqM0tXODV6aWtRNlpHdTg1cXBVMHJWUm5mVVZ6cERKeE1y?=
 =?utf-8?B?ZFZPaXVha3JDbWF2cEZIM3dJYzUzbXgyVUNrWDA2c3FBSnJSelArQW40L3hN?=
 =?utf-8?B?NndVOWRUWnQzU2VHck43VEZUWXNib0VXZm9HdU4rRDM1V0ZlQXlmWUt6Rkh5?=
 =?utf-8?B?aVZXOVhkVS8vSTJJWSt2NkxZREdwdGZuUTE1OUlLYThveUp3VXBSUzJseEk1?=
 =?utf-8?B?ejk0cExaQ1JCVEFGUjRLNFZMbHdEcGNPR2JLSXAyVG5pMU45NWtjc1Z6dHBa?=
 =?utf-8?B?SHl6dlRHLzJZVzZBeUZJdUJWdGtLUUE2N3pTWjBONE5jWE5TSjE2Wit3MGdE?=
 =?utf-8?B?cERTTUg3N0FKaTY1VXFiNnFjc21EMW1JczBzWndlVXVER3NHem52U1ZzdWNi?=
 =?utf-8?B?d2ZQa0prN3NHNGYxRWhOQnN6WWVxK2NvMW0zUDZ6RE80ZnhmYVZhc0tPV2dy?=
 =?utf-8?B?QVp1VXVrZWlmd0w3dzk5U0p2M0I5ZFRZeE1EQklveGJ5RlpCSUF5Mlo3dFNH?=
 =?utf-8?B?U244WmpGVFBKajdDUDk1RUZFRERKWU52NWxwRi9ET1Y0YTVPb1VSbS8xZCsw?=
 =?utf-8?B?RllwSE5nR2s3U3V3cTVVRlcraUdQOVNaWXhoUkFmcUVtTnF0aG5xV3pzeU1S?=
 =?utf-8?B?eW5Nak9OTTNUQTcxdzh6ajE1aTlHdXR6aVN3VTlXWjltU0hLbTBzWFFXcE1v?=
 =?utf-8?B?d1NWckV6c3A0T1dFOUlDb2tOczFjeU9KdFlRZUJiSUR6N2EwL0tqUkVaVkFP?=
 =?utf-8?B?clhIV0V2NnBVQTBsSnB0UlE3MjdQdDRySnpaT0lnZW9MajVPMlNwMnNxSXFO?=
 =?utf-8?B?NkZJK1NMTmRzU01PR0RQVnhyZEhSNWw5aVgrSEJPWFZxbDhMc1E5UmszL0kv?=
 =?utf-8?B?ZnFhbWdyaXJ5MnhWL1RCUWs4ZERDWTJaZUtmYlJpQVdSY1U2MktJMHhpdDFP?=
 =?utf-8?B?U0pGSngzTmdRRDZ1RGh1cHBIT3oyb2drdmI1eGJyajhhNGplem5UYTA1MlJu?=
 =?utf-8?B?S1VmYnpqSzdpcEtjcDROZDhlZWN0ZCtoVDZyWHd0aFVPQXQ3S3Z3UzNsckdi?=
 =?utf-8?B?NGRBZmJWVmkvMmNBQ1JSaXBzdHEwVDhuVmZTMnp3WFlZbVY2cytEMUwwZUtO?=
 =?utf-8?B?S1VRa1dUdDZvYXVPeVllaXEzL2ozdVo2SnZkWDA0NDVNL2dPVm95Si9tdlZa?=
 =?utf-8?B?Z0xGZ2IxaHgzYytYVENnVi9CSXJMZzZWSnE0Z1ZTV3VMSXpMZkJ2dUQ4SnIw?=
 =?utf-8?Q?srHb9qPAMhFI3PPWEu1YHjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A587AA738173AF49A5A7E9CD86E48333@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1140e76-2038-4475-636f-08d9eb417ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 20:27:58.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtBT5XZjlISEpHNidKa5kXPrBtyzOwtoELG8NTJxvYsfdV+BJqnN7WPMbdeI/2gjjr+iOVlvc9Zgc5rOvCdTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDE1OjAzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOgo+IEluIG9yZGVyIHRvIGRpZmZlcmVudGlhdGUgY2xpZW50IHN0YXRlLCBhc3NpZ24gYSBy
YW5kb20gdXVpZCB0byB0aGUKPiB1bmlxdWlmaW5nIHBvcnRpb24gb2YgdGhlIGNsaWVudCBpZGVu
dGlmaWVyIHdoZW4gYSBuZXR3b3JrIG5hbWVzcGFjZQo+IGlzCj4gY3JlYXRlZC7CoCBDb250YWlu
ZXJzIG1heSBzdGlsbCBvdmVycmlkZSB0aGlzIHZhbHVlIGlmIHRoZXkgd2lzaCB0bwo+IG1haW50
YWluCj4gc3RhYmxlIGNsaWVudCBpZGVudGlmaWVycyBieSB3cml0aW5nIHRvCj4gL3N5cy9mcy9u
ZnMvbmV0L2NsaWVudC9pZGVudGlmaWVyLAo+IGVpdGhlciBieSB1ZGV2IHJ1bGVzIG9yIG90aGVy
IG1lYW5zLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5n
QHJlZGhhdC5jb20+Cj4gLS0tCj4gwqBmcy9uZnMvc3lzZnMuYyB8IDE0ICsrKysrKysrKysrKysr
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9m
cy9uZnMvc3lzZnMuYyBiL2ZzL25mcy9zeXNmcy5jCj4gaW5kZXggOGNiNzA3NTVlM2M5Li45Yjgx
MTMyM2ZkN2YgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL3N5c2ZzLmMKPiArKysgYi9mcy9uZnMvc3lz
ZnMuYwo+IEBAIC0xNjcsNiArMTY3LDE4IEBAIHN0YXRpYyBzdHJ1Y3QgbmZzX25ldG5zX2NsaWVu
dAo+ICpuZnNfbmV0bnNfY2xpZW50X2FsbG9jKHN0cnVjdCBrb2JqZWN0ICpwYXJlbnQsCj4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOwo+IMKgfQo+IMKgCj4gK3N0YXRpYyB2b2lkIGFzc2ln
bl91bmlxdWVfY2xpZW50aWQoc3RydWN0IG5mc19uZXRuc19jbGllbnQgKmNscCkKPiArewo+ICvC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGNoYXIgY2xpZW50X3V1aWRbMTZdOwo+ICvCoMKgwqDCoMKg
wqDCoGNoYXIgKnV1aWRfc3RyID0ga21hbGxvYyhVVUlEX1NUUklOR19MRU4gKyAxLCBHRlBfS0VS
TkVMKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHV1aWRfc3RyKSB7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdlbmVyYXRlX3JhbmRvbV91dWlkKGNsaWVudF91dWlkKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3ByaW50Zih1dWlkX3N0ciwgIiVwVSIsIGNs
aWVudF91dWlkKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmN1X2Fzc2lnbl9w
b2ludGVyKGNscC0+aWRlbnRpZmllciwgdXVpZF9zdHIpOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiAr
fQo+ICsKPiDCoHZvaWQgbmZzX25ldG5zX3N5c2ZzX3NldHVwKHN0cnVjdCBuZnNfbmV0ICpuZXRu
cywgc3RydWN0IG5ldCAqbmV0KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX25l
dG5zX2NsaWVudCAqY2xwOwo+IEBAIC0xNzQsNiArMTg2LDggQEAgdm9pZCBuZnNfbmV0bnNfc3lz
ZnNfc2V0dXAoc3RydWN0IG5mc19uZXQgKm5ldG5zLAo+IHN0cnVjdCBuZXQgKm5ldCkKPiDCoMKg
wqDCoMKgwqDCoMKgY2xwID0gbmZzX25ldG5zX2NsaWVudF9hbGxvYyhuZnNfY2xpZW50X2tvYmos
IG5ldCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChjbHApIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoG5ldG5zLT5uZnNfY2xpZW50ID0gY2xwOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAobmV0ICE9ICZpbml0X25ldCkKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFzc2lnbl91bmlxdWVfY2xpZW50aWQoY2xwKTsK
CldoeSBzaG91bGRuJ3QgdGhpcyBnbyBpbiBuZnNfbmV0bnNfY2xpZW50X2FsbG9jPyBBdCB0aGlz
IHBvaW50IHlvdSd2ZQphbHJlYWR5IHB1Ymxpc2hlZCB0aGUgcG9pbnRlciBpbiBuZXRucywgc28g
eW91J3JlIHByb25lIHRvIHJhY2VzLgoKQWxzbywgd2h5IHRoZSBleGNsdXNpb24gb2YgaW5pdF9u
ZXQ/Cgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga29iamVjdF91ZXZlbnQoJmNs
cC0+a29iamVjdCwgS09CSl9BREQpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqB9CgotLSAKVHJv
bmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
