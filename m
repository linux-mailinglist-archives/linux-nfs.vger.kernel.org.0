Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1230A52AA7F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiEQSUz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 May 2022 14:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbiEQSUy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 May 2022 14:20:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3083647A
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 11:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8RT5NXgswTKBWG1rhrJKG3ohGuXWsSLqRjZd2Rdy0w6rdUW31WSEnIDYwx8u4AwHb/VpbOAFCkCTkYIw66YGBlFq5umZalf2mhipzCj2T3LCAuOz71s+vYVehmQO1AoPtw+YyaS/FIiUkrV/X9CpM7PGJ6SCPLzNaUjsLaQ0s7I0bBlEjOsukVyFb3TsruNkXAyo8P2ZXy3+RoaMwu9NJLF/7jHBRSbXEROwS0GoNo2lcyahhd7gyqcoTDNa/YvzMtilXuam0Zrwzz+bxnRHxlyKtlrPC2w61treHHA1IjN6eKQLCn4H06AL/LBDY1Vo3EBps85PJt6H6q8+EWtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDqENv9tXOFMiBNx8LMaLO035URSkG728NRjtcHl7Nk=;
 b=m+vG/baklXMfQGmgn9am3W5hmYztfqWWuXVgbui4MVRr4FLrt6oudS+k9QV0qqeVJOjIWrBMXiviJ5xelAvtoDw0Oqx7fRo9XsGGWyJ/GRtzSB/bs/A/50+4S8NbQ/Wdpap8e5AMNi2z0Z8FL5qLapfqTNcW9lns+0Efz7VduIbab89Mp8cTxxunI0tO389mxTZaSpQh1qyGPhzRs2cG3B6vprCj87IbpuDwxOZ8jyJ1nqsI1JK4k9KSJQUbIHy9TtUppXlo3A5Lobn1qA/ezQdxlzhXe80Ep4/FjYLIyID13pBKC02HZeYokMgWKZrfx1OZkOZu8BYJbw+Vp37Kig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDqENv9tXOFMiBNx8LMaLO035URSkG728NRjtcHl7Nk=;
 b=gIcobudO1UUlhpzSRYHmNWLV2+B6D622O9Eb6awuCLbbuuqq2vMN2ER6GyC9HG/bet8OPDsgzQ2Hc2HtF4FOZZTs34VUmoVPFoJZjTVehXDlkLEVqNf+xhYDzfJBTbgNcc5UmY9ILkKsQzeCGmPwu1W+HS0vNqjiXktQVdXlkC0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4351.namprd13.prod.outlook.com (2603:10b6:208:3f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Tue, 17 May
 2022 18:20:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.014; Tue, 17 May 2022
 18:20:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH 5/9] NFSv4: Clean up encode_attrs
Thread-Topic: [PATCH 5/9] NFSv4: Clean up encode_attrs
Thread-Index: AQHYag+yKYVCMutbLUqicMSN22LSRK0jYYoA
Date:   Tue, 17 May 2022 18:20:49 +0000
Message-ID: <7c3b8239c051d33bd385e8a8dad47a6b148ae641.camel@hammerspace.com>
References: <20180320210313.94429-1-trond.myklebust@primarydata.com>
         <20180320210313.94429-2-trond.myklebust@primarydata.com>
         <20180320210313.94429-3-trond.myklebust@primarydata.com>
         <20180320210313.94429-4-trond.myklebust@primarydata.com>
         <20180320210313.94429-5-trond.myklebust@primarydata.com>
         <20180320210313.94429-6-trond.myklebust@primarydata.com>
         <20220517170057.lt6prmdl2kaupo54@gmail.com>
In-Reply-To: <20220517170057.lt6prmdl2kaupo54@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b5d068a-25ef-4067-83a9-08da3831f85c
x-ms-traffictypediagnostic: MN2PR13MB4351:EE_
x-microsoft-antispam-prvs: <MN2PR13MB4351E38B473049D35F73C02FB8CE9@MN2PR13MB4351.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ZOQGKQHDUpU9Ryr1CjLHRN/2SSPvocObX1JYqDaJ6fBHFgbDGIx6KsW4ij9hUxqU9lgd+7HIbSavvRfEgQoAMLMpGlvnKotrHhGZduSMIdoPCmYyRv0DubpYZC0uEMkxJo/np0qwVM6GlrRrST5UOFzEk04KYiaZUuf47gbd9u1nAkfv9qeEgSY8A00gbazursHciLD9vZPb1GLpDckra/dynHIqU2i13EQOTWEtLiv9c+dyplh5qqMypDAcJcxFHcdt4363AGZDR369qavxSpde6X2nTm5XsfdVwhujUiOvbXVnuOUd8SEAyoAGqdqOAeN/lAYqa5f1lR3KQgnJQeHNDnIXs+Wbz86ooC6gVZUQB/FoA75eiFZyPZGH1hh7AghirKG4hGU3JLNY6W3Zm6W9e2LwZjjDjP+DWnDRtMsv8j/D2Sd6t/vHpirzBSfQtaKx3xS1RNbBqxwAU51uF4M8+vcgh0EGzmR3OCToxZzA/v2iK/L/BDyOtpKkivVOrM2agjvRWPQ/sJUNeprSQTkX4WCJNThKCP5pbKZWAer65tD89qLR28/XJZI5kT3VW2jm8wyQ96e5u6DV55njizaIK8uXiSbWgJ7KIBbtX8dwbkut4ZozKsEwy5fcDaCe2DRNsw744SlJWAFra3AuBfpJkK8Ozu6EI2wIUlNdAxAWXDz1F1NNYdPA1qshbOBBeZ2jWfcPlLnXo3Km917yzuuerjRAiCsXWnCY1A8HM/d3NSLAvV6Y3qn5qTixADr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(38100700002)(2906002)(122000001)(86362001)(6512007)(83380400001)(66574015)(186003)(316002)(6916009)(54906003)(36756003)(71200400001)(6486002)(5660300002)(508600001)(76116006)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(8936002)(4326008)(2616005)(26005)(53546011)(6506007)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm9DSW94SU5YajFiaFJrT2JEa0NUeHVtR0hDbWlxN1hLbzlaS3dJTE9lSmw1?=
 =?utf-8?B?UEE4SHBxZktENHhXdEhyVGt6RGN6S0Z0dG9LVFBqREJ4WXR5N0xNTjdsWjd5?=
 =?utf-8?B?Ty8wWFowRXJZNk1oenVCUkwyc2VSU2MzWFV1RUE2dkpCNWJTdHdoeDlTUjlo?=
 =?utf-8?B?NHl1RXBaK2hQZGxvUnIzeU0yZ2o1Mk8zMGx5M2xhdUwxc1lJVDZKZmFEbGJM?=
 =?utf-8?B?bVIxSVJNYTNzT1R5QWpRZDkwVGxWYmZpT2Iyc0xpdkRXUkYwZE5lN1kyTDNI?=
 =?utf-8?B?alRrZElFZUwxQ1NxOWVMa3hWWWtJTUVIT3BBazBVMElOQmpwdzhHQ3IyamZY?=
 =?utf-8?B?MFp3bnl0S25ybnZlMnhtWjFTNitGZ284WjRqd2huWE4rQ1Bmci8yWXAzY3Q4?=
 =?utf-8?B?bUdQdzFMbzhGRmtTdThsZTZZYVBYWkhncktWRGZCL1RDbkR2d0hreThhOEMw?=
 =?utf-8?B?aUFyNThtRmJFVUltZUIwVnN5Y2F6T3hlV3pqTSsrcDZLODNYYkY2dTBsZUFG?=
 =?utf-8?B?K1pEdnkxWlV6YUtUUnFFRHBHWWpuN2VHNCt2WWxIalg0dmxoamxJbDFUZTAz?=
 =?utf-8?B?a1YxaGRZSVRhOVRhL0ZQZjI4K1VPWm9OK3c5aStCSklyejBYaksvZGt4NnRO?=
 =?utf-8?B?WExzMmM5QlFqRHNYUGVSOE80QVhwclVhT2RuUjlZa0NUODFFOXRKSEExNUxF?=
 =?utf-8?B?NGRIUU8wajlRR3ZkMUN6QiswVTRZZWFqaFFjTVVOanVPYmxQRlhCZTR5ZWts?=
 =?utf-8?B?UGJkNkZMcGVNcmMyRi9BbzRTdmlzR0laS2ZqVlhCamUydERtSnVCM2hTckx1?=
 =?utf-8?B?MzBvUWZhNXhNZWZERzBCaUszYmNjYThXOGkvdDN2eWowTklkclFIeFhKU1U4?=
 =?utf-8?B?c3JDcTJ1SllTczBuUW4rbnhzWFR4ekl4RzFVV1JKa1VxcjVBWnhoK01IMG93?=
 =?utf-8?B?VzFDU0Fjbkt0SGpKRVVCazJzL2c3MUhkTFpOMlpMT0x3dTk2R2F1aW43N0lO?=
 =?utf-8?B?QzV1T2E3WDBXUFJsSUdXWncyRW92S1loa2xIRlBxRU9PbmNOVjFWem5tOVYy?=
 =?utf-8?B?ZzdnYUNZelBQRXV3elpqeW5Uc1pDb3kzWG1MaUFnVmJ3alozM3BEREcvYURn?=
 =?utf-8?B?YWViRmM4eDVuZkdoSEtzbmNnZG1OWlhraDVCY3c3cXlxOC9TUVlyOWhqYzhm?=
 =?utf-8?B?VWVBc3oya05BUzJmZ1laMDdkcWl6QmxWVkxTYTZRaUJLby9pOWtyTjBqYTdZ?=
 =?utf-8?B?R3NsTk1TdmNJYkM2ZmxycVFpOUtLcWhFQmduT0E5cFJEMlRSR0F4YmNzeEdD?=
 =?utf-8?B?eUlOQXAxN2tEWklXYnpjMGgxdndiZlpWVTMxVzVQdnNlRUorK3VuUHZ6NzhQ?=
 =?utf-8?B?MmJRaFdlb3dGRnFudDhZVzVrcFNiQmx5WkVNaG5OWDRaeVI4ei9TbTJEb3dZ?=
 =?utf-8?B?b1YwektPQWxyMU53cmVSMC9Sck04OTltY0lPRU9KNkxaU2JUVHJoeU1CU3Nl?=
 =?utf-8?B?bVBYR2RiWTRzZVRJTlFWU2I2S291VVFTdjZVZlg1RXlidVNGZVpJZWx6NDFw?=
 =?utf-8?B?SXFqajBKV3lpNkxFK3RkZWlUMzJ1aUVtVGFjZXoyUWNVc1JMWnphdWNOMDhj?=
 =?utf-8?B?aUtLZkVNRVhiMURscEkrQW5hL0p5UVBEcG85YzJna0pwd2ZPWnFVVVBHMFlp?=
 =?utf-8?B?R1NQTEU5eHRjZjlCNktqNkIwSEtBS2ZEeGhCbDRNNmcyRXJIN2ptT1hTR29r?=
 =?utf-8?B?RW1zTmFmZ3FnalZOaGVOVGFYS3dBdzR2NUdBV0RRUXE0SjNuVTZwYXFkZmQ2?=
 =?utf-8?B?WGZxdCtFMm94cDFjMDZuRGZhbHUvVUxXcWltNkVTQjB4RmtNR1AwbzFaeGZF?=
 =?utf-8?B?U0F0MHFpVzF0alIrQzRFWW9HMHF4NmU4WWF0RGt3ZE9QQkc0UmNXdEsvQ29k?=
 =?utf-8?B?aFR4aFBwZHJNZ1VZd1lmYUdGSUp4VnVWRmdnVlpzWXFxUDBXODRaclU3RHJx?=
 =?utf-8?B?SEs4SjJ6VGkwTUo0UUhjOTNtMEU2a1JGZW1TaHh5WjFCOFBUZUttOElOczB1?=
 =?utf-8?B?bEpYMEw3N3RyR0lKbmhUY2JyQldqVWtaM2s4RnVOWTd5cCtCVS80ck5HS2VZ?=
 =?utf-8?B?dHRYZWJMcG1HeGh6UnFCQU5EVmZ1OWFrMi9VT0dIMXhjMnFhcVM5VGI5anJ4?=
 =?utf-8?B?UUEvR0l3TmVWK1JNQ3NGOUIzd3lDU2gxOXBnMURnQmM5UUQvZmFGZHRMMDcr?=
 =?utf-8?B?KzZwdWJkcFVTbTNFdFdtUVJBdkZhL204c3NSaXpuSk4rWEowbk4yRUZrWk5v?=
 =?utf-8?B?bkJ3Y2x4MEZOMGFmWDFvZU8rNFFQT1lWN05ZRWloM2VWaHp2UUxpUUdneElV?=
 =?utf-8?Q?CD+McWMRlS8ElNoU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE0101F39E384D45AEDBE74C8C2C6CEB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5d068a-25ef-4067-83a9-08da3831f85c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 18:20:49.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+sjrPj0qlW7K65JH+jXw39vtll+YeyfUHAVl32WFRqac7XJCDZ857uQM8j01ohjdDKq9xb3zEdZ3rlFC63P0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDIwOjAwICswMzAwLCBEYW4gQWxvbmkgd3JvdGU6Cj4gSGkg
VHJvbmQsCj4gCj4gV2lyZXNoYXJrIGNsYWltcyB0aGF0IHRoaXMgY29tbWl0IGJyb2tlIGVuY29k
aW5nIG9mIFNFVEFUVFIgKHNlZQo+IGJlbG93KS4KPiAKPiBJcyBXaXJlc2hhcmsgY29ycmVjdCBp
biByZWZlcmVuY2UgdG8gdGhlIFJGQz8KPiAKPiBGcmFtZSA1NjogMjc0IGJ5dGVzIG9uIHdpcmUg
KDIxOTIgYml0cyksIDI3NCBieXRlcyBjYXB0dXJlZCAoMjE5Mgo+IGJpdHMpCj4gRXRoZXJuZXQg
SUksIFNyYzogUmVhbHRla1VfZDA6ZDg6ZmYgKDUyOjU0OjAwOmQwOmQ4OmZmKSwgRHN0Ogo+IFJl
YWx0ZWtVXzdhOjgwOjYzICg1Mjo1NDowMDo3YTo4MDo2MykKPiBJbnRlcm5ldCBQcm90b2NvbCBW
ZXJzaW9uIDQsIFNyYzogMTkyLjE2OC40MC4xLCBEc3Q6IDE5Mi4xNjguNDAuMTEKPiBUcmFuc21p
c3Npb24gQ29udHJvbCBQcm90b2NvbCwgU3JjIFBvcnQ6IDk5OSwgRHN0IFBvcnQ6IDIwNDksIFNl
cToKPiA0MzI1LCBBY2s6IDQ0ODksIExlbjogMjA4Cj4gUmVtb3RlIFByb2NlZHVyZSBDYWxsLCBU
eXBlOkNhbGwgWElEOjB4MzcyNWE3NjAKPiBOZXR3b3JrIEZpbGUgU3lzdGVtLCBPcHMoNCk6IFNF
UVVFTkNFLCBQVVRGSCwgU0VUQVRUUiwgR0VUQVRUUgo+IMKgwqDCoCBbUHJvZ3JhbSBWZXJzaW9u
OiA0XQo+IMKgwqDCoCBbVjQgUHJvY2VkdXJlOiBDT01QT1VORCAoMSldCj4gwqDCoMKgIFRhZzog
PEVNUFRZPgo+IMKgwqDCoCBtaW5vcnZlcnNpb246IDEKPiDCoMKgwqAgT3BlcmF0aW9ucyAoY291
bnQ6IDQpOiBTRVFVRU5DRSwgUFVURkgsIFNFVEFUVFIsIEdFVEFUVFIKPiDCoMKgwqDCoMKgwqDC
oCBPcGNvZGU6IFNFUVVFTkNFICg1MykKPiDCoMKgwqDCoMKgwqDCoCBPcGNvZGU6IFBVVEZIICgy
MikKPiDCoMKgwqDCoMKgwqDCoCBPcGNvZGU6IFNFVEFUVFIgKDM0KQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgU3RhdGVJRAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBbU3RhdGVJ
RCBIYXNoOiAweGFmYTldCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN0YXRlSUQg
c2VxaWQ6IDAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU3RhdGVJRCBPdGhlcjog
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFtTdGF0ZUlEIE90aGVyIGhhc2g6IDB4NjBkZV0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtF
eHBlcnQgSW5mbyAoV2FybmluZy9Qcm90b2NvbCk6IFBlciBSRkNzIDM1MzAgYW5kIDU2NjEKPiBh
biBhdHRyaWJ1dGUgbWFzayBpcyByZXF1aXJlZCBidXQgd2FzIG5vdCBwcm92aWRlZC5dCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtQZXIgUkZDcyAzNTMwIGFuZCA1NjYxIGFuIGF0
dHJpYnV0ZSBtYXNrIGlzIHJlcXVpcmVkCj4gYnV0IHdhcyBub3QgcHJvdmlkZWQuXQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBbU2V2ZXJpdHkgbGV2ZWw6IFdhcm5pbmddCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtHcm91cDogUHJvdG9jb2xdCj4gwqDCoMKgwqDC
oMKgwqAgT3Bjb2RlOiBHRVRBVFRSICg5KQo+IMKgwqDCoCBbTWFpbiBPcGNvZGU6IFNFVEFUVFIg
KDM0KV0KPiAKPiAwMDAwwqAgNTIgNTQgMDAgN2EgODAgNjMgNTIgNTQgMDAgZDAgZDggZmYgMDgg
MDAgNDUgMDDCoMKgCj4gUlQuei5jUlQuLi4uLi5FLgo+IDAwMTDCoCAwMSAwNCBhNiAxNiA0MCAw
MCA0MCAwNiBjMiA4MCBjMCBhOCAyOCAwMSBjMCBhOMKgwqAKPiAuLi4uQC5ALi4uLi4oLi4uCj4g
MDAyMMKgIDI4IDBiIDAzIGU3IDA4IDAxIDE0IGZlIGE2IDAyIGRlIGY0IDA5IDEwIDgwIDE4wqDC
oAo+ICguLi4uLi4uLi4uLi4uLi4KPiAwMDMwwqAgMDEgN2IgZDIgNTMgMDAgMDAgMDEgMDEgMDgg
MGEgNjggYmEgODMgMDMgZTkgZWXCoMKgCj4gLnsuUy4uLi4uLmguLi4uLgo+IDAwNDDCoCA3YyAw
YiA4MCAwMCAwMCBjYyAzNyAyNSBhNyA2MCAwMCAwMCAwMCAwMCAwMCAwMMKgwqAKPiB8Li4uLi43
JS5gLi4uLi4uCj4gMDA1MMKgIDAwIDAyIDAwIDAxIDg2IGEzIDAwIDAwIDAwIDA0IDAwIDAwIDAw
IDAxIDAwIDAwwqDCoAo+IC4uLi4uLi4uLi4uLi4uLi4KPiAwMDYwwqAgMDAgMDEgMDAgMDAgMDAg
MzAgMDAgNDEgODggM2QgMDAgMDAgMDAgMTYgNjMgNmPCoMKgCj4gLi4uLi4wLkEuPS4uLi5jbAo+
IDAwNzDCoCA2OSA2NSA2ZSA3NCAyZSA2ZSA2NiA3MyAyZCA3NCA2NSA3MyA3NCA2OSA2ZSA2N8Kg
wqAgaWVudC5uZnMtCj4gdGVzdGluZwo+IDAwODDCoCAyZSA2MyA2ZiA2ZCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMMKgwqAKPiAuY29tLi4uLi4uLi4uLi4uCj4gMDA5MMKgIDAw
IDAxIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwwqDCoAo+IC4uLi4u
Li4uLi4uLi4uLi4KPiAwMGEwwqAgMDAgMDAgMDAgMDAgMDAgMDEgMDAgMDAgMDAgMDQgMDAgMDAg
MDAgMzUgMzcgMDDCoMKgCj4gLi4uLi4uLi4uLi4uLjU3Lgo+IDAwYjDCoCAwMCAwMCAwMCBhMCAw
MCAwMCAzNiAwMCAwMCAwMCAwMCBhMCAwMCAwMCAwMCAwMMKgwqAKPiAuLi4uLi42Li4uLi4uLi4u
Cj4gMDBjMMKgIDAwIDE0IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAxIDAwIDAw
wqDCoAo+IC4uLi4uLi4uLi4uLi4uLi4KPiAwMGQwwqAgMDAgMTYgMDAgMDAgMDAgMTAgMDAgMDAg
NjkgOGQgNDQgZDggMGUgMzQgMGYgN2TCoMKgCj4gLi4uLi4uLi5pLkQuLjQufQo+IDAwZTDCoCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAyMiAwMCAwMCAwMCAwMCAwMCAwMMKgwqAKPiAuLi4u
Li4uLi4iLi4uLi4uCj4gMDBmMMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwwqDCoAo+IC4uLi4uLi4uLi4uLi4uLi4KPiAwMTAwwqAgMDAgMDAgMDAgMDAg
MDAgMDkgMDAgMDAgMDAgMDIgMDAgMTAgMDEgMWEgMDAgMzDCoMKgCj4gLi4uLi4uLi4uLi4uLi4u
MAo+IDAxMTDCoCBhMiAzYcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLjoKPiAKPiBP
biAyMDE4LTAzLTIwIDE3OjAzOjA5LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBwcmltYXJ5ZGF0YS5jb20+
Cj4gPiAtLS0KPiA+IMKgZnMvbmZzL25mczR4ZHIuYyB8IDE3ICsrLS0tLS0tLS0tLS0tLS0tCj4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczR4ZHIuYyBiL2ZzL25mcy9uZnM0eGRyLmMKPiA+
IGluZGV4IDgwYzViNTE5ZmQ2YS4uM2QwODgyMzBjOTc1IDEwMDY0NAo+ID4gLS0tIGEvZnMvbmZz
L25mczR4ZHIuYwo+ID4gKysrIGIvZnMvbmZzL25mczR4ZHIuYwo+ID4gQEAgLTEwNTIsOSArMTA1
Miw3IEBAIHN0YXRpYyB2b2lkIGVuY29kZV9hdHRycyhzdHJ1Y3QgeGRyX3N0cmVhbQo+ID4gKnhk
ciwgY29uc3Qgc3RydWN0IGlhdHRyICppYXAsCj4gPiDCoMKgwqDCoMKgwqDCoMKgaW50IG93bmVy
X25hbWVsZW4gPSAwOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGludCBvd25lcl9ncm91cGxlbiA9IDA7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgX19iZTMyICpwOwo+ID4gLcKgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgaTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1aW50MzJfdCBsZW4gPSAwOwo+ID4gLcKgwqDCoMKg
wqDCoMKgdWludDMyX3QgYm12YWxfbGVuOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHVpbnQzMl90IGJt
dmFsWzNdID0geyAwIH07Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qCj4gPiBAQCAtMTEy
MywxOSArMTEyMSw4IEBAIHN0YXRpYyB2b2lkIGVuY29kZV9hdHRycyhzdHJ1Y3QgeGRyX3N0cmVh
bQo+ID4gKnhkciwgY29uc3Qgc3RydWN0IGlhdHRyICppYXAsCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGJtdmFsWzJdIHw9IEZBVFRSNF9XT1JEMl9TRUNVUklUWV9MQUJFTDsK
PiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGJtdmFs
WzJdICE9IDApCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm12YWxfbGVuID0g
MzsKPiA+IC3CoMKgwqDCoMKgwqDCoGVsc2UgaWYgKGJtdmFsWzFdICE9IDApCj4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm12YWxfbGVuID0gMjsKPiA+IC3CoMKgwqDCoMKgwqDC
oGVsc2UKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBibXZhbF9sZW4gPSAxOwo+
ID4gLQo+ID4gLcKgwqDCoMKgwqDCoMKgcCA9IHJlc2VydmVfc3BhY2UoeGRyLCA0ICsgKGJtdmFs
X2xlbiA8PCAyKSArIDQgKyBsZW4pOwo+ID4gLQo+ID4gLcKgwqDCoMKgwqDCoMKgKnArKyA9IGNw
dV90b19iZTMyKGJtdmFsX2xlbik7Cj4gPiAtwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwg
Ym12YWxfbGVuOyBpKyspCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnArKyA9
IGNwdV90b19iZTMyKGJtdmFsW2ldKTsKPiA+IC3CoMKgwqDCoMKgwqDCoCpwKysgPSBjcHVfdG9f
YmUzMihsZW4pOwo+ID4gK8KgwqDCoMKgwqDCoMKgeGRyX2VuY29kZV9iaXRtYXA0KHhkciwgYm12
YWwsIEFSUkFZX1NJWkUoYm12YWwpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoHhkcl9zdHJlYW1fZW5j
b2RlX29wYXF1ZV9pbmxpbmUoeGRyLCAodm9pZCAqKikmcCwgbGVuKTsKPiA+IMKgCj4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKGJtdmFsWzBdICYgRkFUVFI0X1dPUkQwX1NJWkUpCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHAgPSB4ZHJfZW5jb2RlX2h5cGVyKHAsIGlhcC0+aWFf
c2l6ZSk7Cj4gPiAtLSAKPiA+IDIuMTQuMwo+ID4gCj4gCgpJcyB0aGUgYml0bWFwIHBlcmhhcHMg
ZW1wdHk/IFRoZSBuZXcgY29kZSB3aWxsIGp1c3QgbWFrZSB0aGF0IGEgemVybwpsZW5ndGggYXJy
YXkuIEknbSBub3Qgc3VyZSBpZiB3aXJlc2hhcmsgd291bGQgZGVhbCBjb3JyZWN0bHkgd2l0aCB0
aGF0LgoKV2Ugc2hvdWxkbid0IGJlIHRyeWluZyB0byBzZW5kIGEgU0VUQVRUUiB3aXRoIG5vIGF0
dHJpYnV0ZXMsIGJ1dCBpdCBpcwpwb3NzaWJsZSB0aGF0IHRoZSBzZXJ2ZXIganVzdCBkb2Vzbid0
IHN1cHBvcnQgdGhlIGF0dHJpYnV0ZXMgdGhhdCB3ZSdyZQp0cnlpbmcgdG8gc2V0LgoKLS0gClRy
b25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
