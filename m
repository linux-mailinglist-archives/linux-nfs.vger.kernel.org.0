Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283CA7AE22C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjIYXVM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYXVL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 19:21:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D0F3
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 16:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuDNDANqK/kMV1aGumrxrGYyXaBlk69ZkKXaf0C2p+JIODlSPNzt2la23DaU1L3UF0BgXAH/Ox0FilSMSqi23rlW/dVUL+HGj+M7m/nnfMVxJfRVnBYMOwLp+AWJgLeRrhlaqL6KL10EZLUA90AHhACbaZ3ot7Bp1/ePUiYD9quh7hbINw0k3YrCurwPW3ux/G68P99I8PWrPpiiqk92COsF6XximfbpqDDP+yid1TmhCAICsSRA8HFAuIRY5CKoNe8ZD3DJ3bjLR49/s2WlBweBd8WfnqUVT+9Ek1DKErLX0QjcJqOknKhd8rR4/8mBKXbFl0r7XxkHjV6WXqgYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZvPqhVhwiwky1YwRjE4fRqHTW8p5d0vnDKGBdwF17M=;
 b=fN2YXo/b8Y3vWZDSTHtM8qW4L0R5A01wnYIj227UaA6HiiGahaYTOM7jMzouKspu25yqNKa/dQtka89+Go93jnsS+qmTgUh0cX9wab13XiruZBcFE/J9mdQqiz6zWTQCWidRJuC6Vc3mOQHh6YN751/pQusBJkUJ4l99VpPdD8KvWNT2hmeDw92xAGwEILzQ5sDJlriHOX1Ysj+XySJaoqHnqz9mCTZhwMry81ZPHDrp5tGMOBYeaj3/z2a7ZKt04mAotF2XbpbkE+C97E7+L1ehUKrBYfTz6dLwMn5ssvGabaAUooVHlsnITgQZKRrOT9LrnB3kkLwwdEDhCwyI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZvPqhVhwiwky1YwRjE4fRqHTW8p5d0vnDKGBdwF17M=;
 b=HiPxMmiPtQ+receI2ZrnJLI9SKpGnJvOVjq44n+ZCEBmq293zRg7l+BHun1eFgxG6lopQosJABPh/VsW+9C7lwKVnJMRpsBS7hqwm+RWDAHtgtJtFNHST6w7dMT14lwSDADv0IcjghyZI6Pq7cvo7sVzJVo8aHRN4fuAYDDwjSw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6376.namprd13.prod.outlook.com (2603:10b6:408:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 23:20:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:20:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
Thread-Topic: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock
 regression
Thread-Index: AQHZ6bx01N78VobVYEyXXSG5Nx3/F7AkIK8AgABNMACAArF1gIAAHKIAgATv1ICAAASKAIAABVyAgAAEtQA=
Date:   Mon, 25 Sep 2023 23:20:58 +0000
Message-ID: <b7aca856b71436fadb95f00abeb848d4185af009.camel@hammerspace.com>
References: <20230917230551.30483-1-trondmy@kernel.org> ,
 <20230917230551.30483-2-trondmy@kernel.org>    ,
 <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>   ,
 <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>       ,
 <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>   ,
 <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>       ,
 <169568091982.19404.4821745630158429694@noble.neil.brown.name> ,
 <ee6c49e086b5ee2393d2bfc375383527eff72af8.camel@hammerspace.com>
         <169568304501.19404.1610884104930799751@noble.neil.brown.name>
In-Reply-To: <169568304501.19404.1610884104930799751@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6376:EE_
x-ms-office365-filtering-correlation-id: d8197750-f2df-449f-7857-08dbbe1e130f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcPVnPzTbsJLGu0Kbe1sMX+DKZCTB2ZbEPgrbqoViNoAsAAkCRM+S+UrXc0yvbUtKzPLj+Snl9smOrhyD6diALjStpTrhwMWA/NBFzvs+bkmaOTzUHxQTTOYPfS2Iq+8Ye3adxSPA2TtZK7ySth8uR3OqrqzkThxVtIFcqZuMGitHSqSnie3RUr7ztdHvqZU5bBjyqrBV7Wp3epJp70tPEwiFGVi7qjTgc6M4aMDd56n2ccUpFVMmeCoIKqVOEYrkUSqLSD5uqPqGX20gLbydZNCHwKhr8eFAP+zjhnwO3SDeuvC0T8zG5uDkGXI3axDi9HxRh57vTUcwgbwdF/Q5FTLSiOIaJEZxXF40nJngYEotTdwzesMvbbTGmQhBNhTP5iZ2WlkgQWv9nN70rvXd8TQqzsjfplRlQcsHDtKQB3iyeVsYUiXv0xU9u2ftU8RUFQa/b0IcKPbTAgZwfYKpvt4AIHN+8LP6DDqPCC0me8boqDnk4TFmdbPguOa5KeWs/58GEX1vQjJHwKDSosBiJbR3C3b3jjbQgkRhhiClxx8Hj8N2gvcdOJ64cKqFEkhf1KvuJtd8EgaYxC2J4upcnEzsyruGzEWldIxVdvSNwS7fuA9F35kd3iXh2OHLXzKt/da9s4v1GWvXBBrbU1qvEO9DgRwKePQC7lHCVa8Vso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39840400004)(346002)(230922051799003)(451199024)(1800799009)(186009)(4744005)(6486002)(83380400001)(8936002)(36756003)(5660300002)(478600001)(26005)(4326008)(8676002)(122000001)(2906002)(71200400001)(86362001)(38100700002)(38070700005)(66556008)(66446008)(6916009)(66476007)(316002)(64756008)(54906003)(66946007)(76116006)(41300700001)(2616005)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWRHSTBTcTFpRFNoS09WNmFHeGpCR2hkN2VHMVU4bGd3R2tlTlhnRDJEOURm?=
 =?utf-8?B?SDczRDVUYVRuWkNaNUVaeTl5VEF5MVZaMjd5alYwczkwTDVWdEpIbzk2U2l5?=
 =?utf-8?B?NVI1QnpRMFhBZ3VWOXgvczMvTm9xNEtuZVNYZENZcjNibGhwbUNIU3l1dkZM?=
 =?utf-8?B?QmtZQnFjMW8zbDlTdG10ZDQ2b0Era0VIKzVkUjdudm5JMitja3NyVjgrUDVj?=
 =?utf-8?B?clljbXIweVV3NGhKWFN3VFB2c0t0TEFFT05KZ0RRNzVJRGJGajB5cHlralF1?=
 =?utf-8?B?WkVoTVdrdVkwN0Nxd3VBOFZ1bUk2NE1JY1p0eDNLZ3R6V05kOFgvSVJnRTJR?=
 =?utf-8?B?Q2d2L0UxWGNuQ09LMkV4NkU4RUQ5cnlPTkZDcDBZVnZTRkF2TURsUXd3UzJU?=
 =?utf-8?B?bXlqOUNkVGpUWmtnQjVYUzYwcEs4MGtYNVhkbmhMbFhXN292N2FSMlI2TjVw?=
 =?utf-8?B?MXYxNlRIanhZb3c2Vkd6QjdJYktQWDI5WHA1b0cxbjlsOVNBaUtMRU9HekQz?=
 =?utf-8?B?WEpxN3ZZcm5mTUZmNFpTa0IwQStSWjBFd0hRZDJRMFhaTG1UTGlPZnp0SGE1?=
 =?utf-8?B?WE5Wb0pBNmh6ek1vaUZxZHVubXhxMnFNL21kTlM0b3dDa3R1Z3ZDN3RrVHNH?=
 =?utf-8?B?eHF5V1EwRVc5QVgwYTlqOEZvb1lLRklvZXZBdzQ2T0NXc3hhRWdvUXB3VmxX?=
 =?utf-8?B?RFU0T05CeTlnRUt5VWFFTFlFdWNDcjRKd0duZXRkTjhHU0w0aEY4Q3htK0hD?=
 =?utf-8?B?YjRkTmxDQUxSSnlWalNoZnUvYWNJNWlJdEdidUtqM3hrVTJaWXF2aWtPZytU?=
 =?utf-8?B?Vzc2U1J4aUlZYTMyWjNvbndqYmRJYVpPNHBGM1NROVB6aU5yV0dkVm1DdkNv?=
 =?utf-8?B?NFZpd014WmNDMXgxNEZXb3drVSs2dGQxL24zeUQ3dHIrSzRSUWNLTlQvQUpU?=
 =?utf-8?B?bG5LTHFqVElBRHNnYzByV0ZLVWp5MnRYbjlLTzI0eEhZVlU4R3dyVGZVdFI3?=
 =?utf-8?B?ZFd0RHBGZVd2dDMybU1GMHp2U0Y3cm5WUkp5UGpMdFEwT3BySDZNSkh4eWJ5?=
 =?utf-8?B?WElyYVdKbzhIaFJnZXRzczdxV081dVVESWcrblU0WTVIdVdidm9pRWxvQmxW?=
 =?utf-8?B?NGg5NmFsbXB5RjkzcWhEMWk1RUNkTk8zUXo1QlJqeUh3T2VqVy9ZclNBSUY2?=
 =?utf-8?B?NnZTSHFTRHU4Mk90RzgzL1JmVlZicVIrd0psaWZDN3ExaUtPZG9udjB4YWZJ?=
 =?utf-8?B?TU1jTTFsNTJVTFcrSU5FT1c1bG1TQ09PZW1vRUFYRTNmRVNqM3BJMTBKdFJY?=
 =?utf-8?B?bU8weGtNNWJBbVB3WUNMaXZWbk94UFFyNnlqRFRINzdqdFFrRmxwMjhmNmJI?=
 =?utf-8?B?aVIxNHQyYW5GbVY3NEx0aDZzVm94WUhKanhnUnVPWE9ZN2JHMzJCL25aYlNr?=
 =?utf-8?B?WVBSL1dpOFVKS1BrMWtGaGdRUHYyRWhMMUhrdlFLbWVkVzF6bXNvcmN5bXVE?=
 =?utf-8?B?aDBVNzFuWjh3S0ptM3ZmR0l0Wm1walJBb01qYWFoYlQxdm9QVEhHbXpDWkN6?=
 =?utf-8?B?M0NnZjJoTVJaVEZBUGYyQTFGYmtKTURhcWZsQ1loVUY0TWgxb3c2UlpsSmlY?=
 =?utf-8?B?NVduemUreUFYMXdnb00rSFB6ZTdIeUtULytxeWJ3U0E2V1o2T2NkS0FTRDBU?=
 =?utf-8?B?bXNTVzFweE03RVFiUmV4cDVWY3drV0hQeCszc2txdnY2eDg2ZmNDTE5xdlNj?=
 =?utf-8?B?NDZyK2JQZXdyQ1habHE5TkEwL05qSmI2Q2l5NzNFdmdZa3A1YmxCaWxFVzFn?=
 =?utf-8?B?cm5iYWhPN2FsajFEa1NJWnU2ZzBTWE9xcmdrTC92QjVPNDBpTktKQk1abzZl?=
 =?utf-8?B?OUZuUG1iVmcvRW5EMUdMekt2OXZ1TXJHQ2NwWnFtMTJTY2haYmZyN2hPeHBq?=
 =?utf-8?B?emV1b2hMNWlUVFFaWnpTQWMwRnpxUG1EVFFhV3NCT3V2ZTdiSkNMTmIrYkJn?=
 =?utf-8?B?NVdFOXJGMHd1OUdpQVF4eE5NZzR0aHp3K1RlNjd5a3orRzRDUFB5YlVJQnQ0?=
 =?utf-8?B?UlJLK1pkU1JCYStucGp4bmVXYUVDUjlDWGVVdEQ0bVpFRlEyY1BtMFRzVmxX?=
 =?utf-8?B?MHRrVmErWXF0bE5QaURicEVDcEo4NnozTE9nUUR6Mm1NQURwTWpHTmNmSUhk?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13DF40332F66F946AAF50BADB754FD17@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8197750-f2df-449f-7857-08dbbe1e130f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 23:20:58.1051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UddmqqO1gp+B2mLGCFVlnZFoM/Kdh9Wybm38jR5EaOLEgddxlAuwcf0vQjPEYtdufi8GNmKhxgd+RkD6ivc+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDA5OjA0ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBBcmUgd3JpdGVzIGJsb2NrZWQgd2hpbGUgdGhlIGRlbGVnYXRpb24gcmV0dXJucyBwcm9jZWVk
cz/CoCBJZiBub3QsDQo+IHdvdWxkDQo+IGl0IGJlIHJlYXNvbmFibGUgdG8gc3RhcnQgYSBzZXBh
cmF0ZSBrdGhyZWFkIG9uLWRlbWFuZCB3aGVuIGEgcmV0dXJuDQo+IGlzDQo+IHJlcXVlc3RlZD8N
Cj4gDQoNClRoYXQncyB3aGF0IHdlJ3ZlIGRvbmUgaGlzdG9yaWNhbGx5Lg0KDQpXZSBpbml0aWFs
bHkgbWFkZSBpdCBiZSB0aGUgc2FtZSB0aHJlYWQgYXMgdGhlIHN0YW5kYXJkIHJlY292ZXJ5IHRo
cmVhZA0KYmVjYXVzZSB3ZSBkbyB3YW50IHRvIHNlcmlhbGlzZSByZWNvdmVyeSBhbmQgZGVsZWdh
dGlvbiByZXR1cm4uIEhvd2V2ZXINCnRoZSByZWNvdmVyeSB0aHJlYWQgaGFzIHRoZSBhYmlsaXR5
IHRvIGJsb2NrIGFsbCBvdGhlciBSUEMgdG8gdGhlDQpzZXJ2ZXIgaW4gcXVlc3Rpb24sIHNvIHRo
YXQgcmVxdWlyZW1lbnQgdGhhdCB3ZSBzZXJpYWxpc2UgZG9lcyBub3QNCmRlcGVuZCBvbiB0aGUg
dHdvIHRocmVhZHMgYmVpbmcgdGhlIHNhbWUuIEluIHByYWN0aWNlLCB0aGVyZWZvcmUsIHdlDQp1
c3VhbGx5IGVuZGVkIHVwIHdpdGggbXVsdGlwbGUgc2VwYXJhdGUgdGhyZWFkcyB3aGVuIHJlYm9v
dCByZWNvdmVyeQ0Kd2FzIHJlcXVpcmVkIGR1cmluZyBhIGRlbGVnYXRpb24gcmV0dXJuLCBvciBp
ZiBhIHNpbmdsZSBzd2VlcCBvZiB0aGUNCmRlbGVnYXRpb25zIHRvb2sgdG9vIGxvbmcuDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
