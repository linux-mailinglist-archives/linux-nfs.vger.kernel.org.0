Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89AC59FAD5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiHXNFO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiHXNFN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 09:05:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2090.outbound.protection.outlook.com [40.107.93.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD39108B
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 06:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxUh+VvT86GG5105iVO95iak8dfLPlbqZB0x0MjRWhSrZEdDzBWc0DkWA8FSUp8gM8PHXG7Z2/kJmD4fjWE5K7AlFnEG/ftyvs6xqOnx5mNYeW0PuX/OZdJRqe6dQ54V45DrNG3lgfGDQu2e24gQPIoUFsXwRaGLlfkxp+MPKGgNhyzB2f7maD0Dg31yPGUtN1NKd+RqV8mOET5WqzEFj5V6cKOvyiW/hcv0Xa6ufUWzC2ikcqO6bJyEB2RZQ7shbbfjH64UUzmxSIKkQN1ayJyMh9yUv2OcprduHCVoQgKn4EwFlXNbEj7/niX/L0qLqNdq+4575bCZEapMFs8FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI8yWisO5afVO1T1p1xUKwGKY+0ekf/UdMI8ZrTu4Wc=;
 b=FNWoAXWd40jcoKb38SBvrOE9Arn6OXYMOJH+LGR3uyCjLd2IhB1AKM9xr0iYk+evABdA3W45qxiHRy2NWtMOhFC1BsGiTYKtnjg4wt97GdeB4AI4fUeGt92OE2ZLBu6SM+2lZg3KrePQCPcQw/tBYIFRsKh1mfzXHgG0I5AljlvWcOopqSh8g5RT/u6Jxs8vIGfpiRzMw01a6fSqar5YZVPTBt9gU6uf4wYtHMZAHL5O61WGIbAX3RrZuIP734IPamyk8nWEYaeQIgq2EU0n/CFRy7IPTeWApahbtJ8Tzd1FS71Cwy6Nu4AicfibJF6y9TuhZglOqhN0VUTzSmWGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI8yWisO5afVO1T1p1xUKwGKY+0ekf/UdMI8ZrTu4Wc=;
 b=RqieAujkZEvGuAzrn8FeTu8uSsp+MjTl/o8VIE33vjcH4nWEqRmycD8LvsTBfBKG+5XFhRdGhQm5WnDY46KZvE4lKcZjxcJEE+PgjzXRFBvy2reQ/44/Gv6RLUhsUbIONASKAN4Al9DI9TpGO9iwDXUw+6NLQW+dKEdnUuM1DOM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB2592.namprd13.prod.outlook.com (2603:10b6:208:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 13:05:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 13:05:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "benmaynard@google.com" <benmaynard@google.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Topic: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Index: AQHYt5zQc0jiP02yL0Kjw6guU1m2RK29/pOAgAAFTACAAAEnAA==
Date:   Wed, 24 Aug 2022 13:05:06 +0000
Message-ID: <da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com>
References: <20220824093501.384755-1-dwysocha@redhat.com>
         <20220824093501.384755-3-dwysocha@redhat.com>
         <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
         <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
In-Reply-To: <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2cb446e-b330-4e50-0157-08da85d1445d
x-ms-traffictypediagnostic: MN2PR13MB2592:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDN0bDBdfhMVYWB2qwVef479YxTQ24nte4UgRaxwTqUKUuKJIwA+fciS25wj0mCzHwavBen9u84ZGrOsp5T4sDqfe1/iSaHFG49lCJIS/PGfrWpcgIA6mNApob/DbKe4/e9kTtEs80+qENfwnZtCbVUoeiEtXQzbF9NqAO2ANm3WPx3FkGYw9EYo0PZkb7syu12Q7I3xf5ZPre+Kaf2FR/1ey9YKTDIdNn9hxLqADz1os0GkfG03tO/zOad7xTk0N3TcGLHkIdVvou95QMmg48yvFo3q/S4kBs/0yzWpp0llr37Hk1jo40A1hG5yv52MuUq/6Sljt14Eyk5d642I04kxBq7UPUi9J4mY0Xr58rBM0YEIHJY0cY8/1G+fRvGdX5DeyLm1spK8owt/W1hoLgFdDs+0uxVWrZYH4OVFIs0pFdRF9jpHfm0+MoLN4Mh7nORJeZjL4zyZ1wxtqOzsYHiK5Sy9cpVPK2y+6AkiYEVij98mgnJiKsPbheDWCmaedtbeILlUVg3Kk7TZXvZQih6tBrObBi4K/DXKySn3/plmXl82gNIv1R2weHGhQA8vBKcg5cvQ7ATCZE5klWKD2JZ71d2n1tALZf3suwk9v1HfJX00Dpm6qt4JyAuFRatNsysLrj+a0JH/gtlQ76UvoUBxW8GDHc6S+/6brBhBKd0IrDCjCo7WNrLXQ7RUxge/Sf5BUwjLtGOh1cttmdavaTJcEZkX9JcPwH3onZkMr4bNVhmDYxqrd9a1fQOkhLbtMg5Mh5DveGVM8kbvKFPACMRPkEWXZrz0yjeoYfn2eAaqcIS4FdWsU3KJvqWB/sBj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(136003)(346002)(39840400004)(86362001)(2906002)(6506007)(26005)(53546011)(2616005)(6512007)(122000001)(38100700002)(83380400001)(186003)(38070700005)(54906003)(6916009)(71200400001)(8936002)(64756008)(66446008)(316002)(4326008)(66476007)(66946007)(66556008)(478600001)(76116006)(8676002)(41300700001)(6486002)(5660300002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azhBb2lEMkZWUGpsRmlSVVFMOHJFenRPbE1PdWNud2ZzWmJXbEMxN0NtaUFx?=
 =?utf-8?B?clVEUmVERWFzVUI4bjBNdFoxbkFwdXZPUmtJT3ozTHUrZ1ZIRDdKblZDWUhQ?=
 =?utf-8?B?S3BFMTU4QmVYMUs3UE1iVTVXOEFubGQ4clhjQ1NCbTZyNEkxbk8yUXRsUXFM?=
 =?utf-8?B?bk1Pa1FveE9CUHRuS3R4b1laSjQwc2MzelVwb1BoWXZWRmo0M2ZUWkcrRzJG?=
 =?utf-8?B?dXNCL2d4VysrRU8rRXlBY0FGMFA4bi9uR0c5OU12bVUyTm5HWlREYjAyOG9V?=
 =?utf-8?B?ZlZneHRpZGRGZlFleFJucXRvd1lXQzFKc0VXeDcvbTEwMzZwNDFiYzNZNkJp?=
 =?utf-8?B?UnVEK2ppY2ZzclN5U3htNGcvUDZyM1ZqOGdvT09HNGhHTGZZamxUMnNoRDVE?=
 =?utf-8?B?RWtPR0RCMVFFZEJJaFdhKzlvbU9MeTBqek90eC8rNDZ4TGhCSkE3Y0hibkt3?=
 =?utf-8?B?a0YxS0lXNndXR2Mvbld1SUdoMngyRlBNT3ZWMDJaNlpmZjdkcExRY0ZrVnI4?=
 =?utf-8?B?cW9zeGhUMG1CNVdtRmpQa08ydTNsR2lkZ1cwZjk5MG0zeVdsa1ExWC85RkRW?=
 =?utf-8?B?U1FqaHhvV1ZUdVY3WjNjL1ZRekhZRjFEN2JoNVdDZ2FwZ0dGcUhWbGUwOGgw?=
 =?utf-8?B?VjlUYmM2VzhObWdxbC9aYkh6TnVCUGpuSkpzelc5YnFMUGpkcG8yNFY2K2Zk?=
 =?utf-8?B?RTlyK3ExRytRbTdSWlByNDZFU1owZUNIMS9zTTBUT243LzNtU3FMMUI3WTlN?=
 =?utf-8?B?RUZndm5UbC9OK1B2cTBxYU5UUmZ5aXRPdlo5U3NCZ01aeGRUbE9sZEpuYXVy?=
 =?utf-8?B?d3FmeSs2VlRINEZ5V1pJZlN5NmVMVFNmK0JHaUlERlVYMWNIbkxSRXJwQm12?=
 =?utf-8?B?dXNFMFN0em92MURIOE1RZXBRTjRkVTQ3OFoyanQyK01UbDdHS2JSMVl5bFM0?=
 =?utf-8?B?ZklxSExNN3FPbEJPNWRvWHdrVW5WeXB6b20vMGEwOU5STXBGSWwzVGtjQzRm?=
 =?utf-8?B?cWpTd2EwZWtlTEZhd2FCZXEvc1hPdnFXblFBR1ZJbUFQaUxxKzlDaEhPdGVS?=
 =?utf-8?B?Z1Bjdm9yYytqblVEc2ltclk3bDk5VHFJaTdwbTg3VFJ1cEV3Zy9hVVFWejhw?=
 =?utf-8?B?MlUrclZ5cDROZWw3MDErY1NmVWpDY2RhMjVXVnVZei9mQUlMRTlzUnZqaWJY?=
 =?utf-8?B?cFQvMXRwUjl0RVJLSUJZQ1NaWEtzejRSb3B1Y1VoS3RIR2h3dzAyMnN0VzAv?=
 =?utf-8?B?Ujd4Vld6WEEvYzFtMnZGR21EUzhYTi9BQmwzRTNUWDVYVXFXa1lPOE1HODV1?=
 =?utf-8?B?Z1hYcXVwWUkxL0JmZ2IvMHRzRmN1blB2RjI2WS9FbkhYQk5LRjFGSDFMdVJG?=
 =?utf-8?B?aUdGYUFTVkdqSWpFQjFpNkc0TXR5WGNJR3ZzUThJSnBGV09YdjVVc1B6d09N?=
 =?utf-8?B?WXNoYlh3N1loYW00Ykd0emFRTEFvVGV5Q00vSlByTHMxbTFNY3NuaWM5eTQr?=
 =?utf-8?B?MEVpT3RJakRCU1Y5VERFRVE4MHgxUmdkbSs2L3JlVGYwL1pmQTFLZ3d2UXJN?=
 =?utf-8?B?SUdFT1I0ZWYzUC9yOE0zdkgvSDFXbzhGZTlQbTZQcmJLTlVBMStXZjZ3Qm8r?=
 =?utf-8?B?TWJpMWMzZUtXQ1MyRGp2N0ZJYXFkMExqaklLMkw3UWMrSzlxWGFZL2hnL2Vm?=
 =?utf-8?B?Z0svM1Q1U0tZRnVpTjN3V1BhdjhZSjR1eWhpZ1hzSlZBcGVOaHJmbUk4Ymc3?=
 =?utf-8?B?b3BvNXRZN2VUVS9RNEpYays3N1pDcEJqWHQ3dmxkd080NGJseUc3QnJTRFZN?=
 =?utf-8?B?b01kRXNkWGJRWnZvZy93TGdoNGlFeWtaMkpWS0F6SU9PaVVTSlRSOWd5bmlX?=
 =?utf-8?B?NDhyaXljNDZxYUhCV0prczlCZCtPSXFIVkYxTHBMMUpVbDF4QTZtaTJKU1c0?=
 =?utf-8?B?eG1obmhhSjJwOW9KY29RUmRoaWM0UVZnYmJScFJ3bUxXR0FFS2phMW45TWVo?=
 =?utf-8?B?aDZRZE1Sekh5MHdTcENRaW9aT0lDQVBTSCtmSFZzYXdSa3NQbDc0T1V4ZFFZ?=
 =?utf-8?B?ZlJiZjM4NGxETEE1WUJEWWx5eU50MzlzT29TVEJlSlkrQkdBeEJ4WGhuNzZk?=
 =?utf-8?B?Ly91Zzh4N2pqZzNTWFBoTnArS2RSWDZLemVoNDQ0a092TkcyWHZXaElxdDd2?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <944916BE0134CB44BDC6F6DF191984A1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cb446e-b330-4e50-0157-08da85d1445d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 13:05:06.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3A6SliVBCHbxXpeK9GKUiAtGVM7VN25U9os0hjkRywDv1GkL4frUfiAhfI5RWQ1w3t/FdXSnSNttCZVYfSUZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDA5OjAwIC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMjQsIDIwMjIgYXQgODo0MiBBTSBUcm9uZCBNeWtsZWJ1c3QNCj4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIDIwMjIt
MDgtMjQgYXQgMDU6MzUgLTA0MDAsIERhdmUgV3lzb2NoYW5za2kgd3JvdGU6DQo+ID4gPiBBcyBm
aXJzdCBzdGVwcyBmb3Igc3VwcG9ydCBvZiB0aGUgbmV0ZnMgbGlicmFyeSwgYWRkDQo+ID4gPiBO
RVRGU19TVVBQT1JUDQo+ID4gPiB0byBLY29uZmlnIGFuZCBhZGQgdGhlIHJlcXVpcmVkIG5ldGZz
X2lub2RlIGludG8gc3RydWN0DQo+ID4gPiBuZnNfaW5vZGUuDQo+ID4gPiBUaGUgc3RydWN0IG5l
dGZzX2lub2RlIGlzIG5vdyB3aGVyZSB0aGUgdmZzX2lub2RlIGlzIHN0b3JlZCBhcw0KPiA+ID4g
d2VsbA0KPiA+ID4gYXMgdGhlIGZzY2FjaGVfY29va2llLsKgIEluIGFkZGl0aW9uLCB1c2UgdGhl
IG5ldGZzX2lub2RlKCkgYW5kDQo+ID4gPiBuZXRmc19pX2Nvb2tpZSgpIGhlbHBlcnMsIGFuZCBy
ZW1vdmUgb3VyIG93biBoZWxwZXIsDQo+ID4gPiBuZnNfaV9mc2NhY2hlKCkuDQo+ID4gPiANCj4g
PiA+IExhdGVyIHBhdGNoZXMgd2lsbCBlbmFibGUgbmV0ZnMgYnkgZGVmaW5pbmcgTkZTIHNwZWNp
ZmljIHZlcnNpb24NCj4gPiA+IG9mIHN0cnVjdCBuZXRmc19yZXF1ZXN0X29wcyBhbmQgY2FsbGlu
ZyBuZXRmc19pbm9kZV9pbml0KCkuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhdmUg
V3lzb2NoYW5za2kgPGR3eXNvY2hhQHJlZGhhdC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IMKgZnMv
bmZzL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiA+IMKgZnMvbmZzL2RlbGVn
YXRpb24uY8KgwqDCoCB8wqAgMiArLQ0KPiA+ID4gwqBmcy9uZnMvZGlyLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMiArLQ0KPiA+ID4gwqBmcy9uZnMvZnNjYWNoZS5jwqDCoMKgwqDCoMKgIHwg
MjAgKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiA+IMKgZnMvbmZzL2ZzY2FjaGUuaMKgwqDCoMKg
wqDCoCB8IDE1ICsrKysrKy0tLS0tLS0tLQ0KPiA+ID4gwqBmcy9uZnMvaW5vZGUuY8KgwqDCoMKg
wqDCoMKgwqAgfMKgIDYgKysrLS0tDQo+ID4gPiDCoGZzL25mcy9pbnRlcm5hbC5owqDCoMKgwqDC
oCB8wqAgMiArLQ0KPiA+ID4gwqBmcy9uZnMvcG5mcy5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTIg
KysrKysrLS0tLS0tDQo+ID4gPiDCoGZzL25mcy93cml0ZS5jwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MiArLQ0KPiA+ID4gwqBpbmNsdWRlL2xpbnV4L25mc19mcy5oIHwgMTkgKysrKystLS0tLS0tLS0t
LS0tLQ0KPiA+ID4gwqAxMCBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA0NyBkZWxl
dGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9LY29uZmlnIGIvZnMv
bmZzL0tjb25maWcNCj4gPiA+IGluZGV4IDE0YTcyMjI0YjY1Ny4uNzliMjQxYmVkNzYyIDEwMDY0
NA0KPiA+ID4gLS0tIGEvZnMvbmZzL0tjb25maWcNCj4gPiA+ICsrKyBiL2ZzL25mcy9LY29uZmln
DQo+ID4gPiBAQCAtNSw2ICs1LDcgQEAgY29uZmlnIE5GU19GUw0KPiA+ID4gwqDCoMKgwqDCoMKg
wqAgc2VsZWN0IExPQ0tEDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBzZWxlY3QgU1VOUlBDDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoCBzZWxlY3QgTkZTX0FDTF9TVVBQT1JUIGlmIE5GU19WM19BQ0wNCj4g
PiA+ICvCoMKgwqDCoMKgwqAgc2VsZWN0IE5FVEZTX1NVUFBPUlQNCj4gPiA+IA0KPiA+IA0KPiA+
IE5BQ0suIEknbSBub3QgYXQgYWxsIE9LIHdpdGggbWFraW5nIG5ldGZzIG1hbmRhdG9yeS4NCj4g
PiANCj4gDQo+IEp1c3Qgc28gd2UncmUgb24gdGhlIHNhbWUgcGFnZSwgYXJlIHlvdSBvayB3aXRo
IG5ldGZzIGJlaW5nIGVuYWJsZWQNCj4gaWYNCj4gZnNjYWNoZSBpcyBlbmFibGVkIGxpa2UgdG9k
YXk/DQo+IA0KDQpBcyBsb25nIGFzIGl0IGlzIGFuIG9wdC1pbiBmZWF0dXJlLCBJJ20gT0suIEkg
ZG9uJ3Qgd2FudCB0byBoYXZlIHRvDQpjb21waWxlIGl0IGluIGJ5IGRlZmF1bHQuDQpBIGNhY2hl
ZnMgc2hvdWxkIG5ldmVyIGJlY29tZSBhIG1hbmRhdG9yeSBmZWF0dXJlIG9mIG5ldHdvcmtlZA0K
ZmlsZXN5c3RlbXMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
