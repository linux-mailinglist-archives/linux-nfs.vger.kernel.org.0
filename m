Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2842E442
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 00:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhJNWie (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 18:38:34 -0400
Received: from mail-bn7nam10on2121.outbound.protection.outlook.com ([40.107.92.121]:36065
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230030AbhJNWid (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Oct 2021 18:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzxDdWDDLjksfOujKjijHeWf7KkygqerkIg+tqggJvgz3+MidLgwpkVftWQ0oEp1tWH9K8CpG+2mytr8fQCOoRHozbWCTg9g780QmW1QIGz6WqFHk36daVooOwsCSrGNjj+azZ1AWz6bhYtKhiCZVzQWjdSrN549LirKGHemiRcM3/XJYPzpSAXnjaipeA4z23ENLDrKH0Xf4jaUoNDh1mZ4Rijc9P6MUwBjm7b/ce70n1SVqCDYGXucwNQ5TVANGAfCOgB/sFeaST9VXa8+TPMXSmMfEL4FRzh9KIyaMs90ogOYofJd3RbGZw1sUUX0f8fV09nHmjVEFO4BxoqH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+ZbhciLTf5V10mHtzHv7C7IwuNe/IiqOUs63SRK0E4=;
 b=DxkbKGU9DOJ67dqeyMZyuIEeQ96VU/isKguMDeVUNoyqUUOGYYZxZA98pjJBOSoRJ+u1JrPcP/bp9Nx78i7svFlsGHYIEeRX045uUB+SDZSujFMMRBG/rj+beyyFe1FZyn58Pau81ILd7zi4WzJVwwubM5M2Nho6WYWuD9sdZzstPJvKxzv4EjJG7nHer4QW1JK493nqLvIXTT9dcck08nTC0qEqmY8JNvM/PFJ7Mv9+6NH7qs2CRGBfsLc3j7dB+F91iGd3wgQ6TU70K8zSAjB18BjhAoUiU4Nftbxd79MpA3xi6WvaABaifSROWlZAvF5xoKWHJPiERl3Pox4lHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+ZbhciLTf5V10mHtzHv7C7IwuNe/IiqOUs63SRK0E4=;
 b=Qd78P11IReadV9tv01zzwN9HjJp5TvkXiYwybePsIZqI+F4ZUXLLLtflU/Wkj2Kj6ctxP8BE+FCt7ClQHlWTOBmwlScCAw9oZ9GAEycso0catbib1YRPGPG3d/C4zNZVHElOH30d9YUgh86aUJp1ZJOFERY0WNRYdoEYZI+RdSo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3431.namprd13.prod.outlook.com (2603:10b6:610:21::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.12; Thu, 14 Oct
 2021 22:36:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 22:36:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRuB0AHyAgAQPnwCAAHMZgIBZgYoAgAFhwQCAAvGUAIAAI06AgABZrYCABMHGAA==
Date:   Thu, 14 Oct 2021 22:36:25 +0000
Message-ID: <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>     ,
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>        ,
 <20210812144428.GA9536@fieldses.org>   ,
 <162880418532.15074.7140645794203395299@noble.neil.brown.name> ,
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>     ,
 <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>      ,
 <20211011143028.GB22387@fieldses.org>  ,
 <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>
         <163398946770.17149.14605560717849885454@noble.neil.brown.name>
In-Reply-To: <163398946770.17149.14605560717849885454@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fc21293-a18f-40c6-49e3-08d98f630e90
x-ms-traffictypediagnostic: CH2PR13MB3431:
x-microsoft-antispam-prvs: <CH2PR13MB3431D25728B93631E772DB43B8B89@CH2PR13MB3431.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofEay2comgwxTSa/M8EFMzTmLINYaK5b9LYI1/F52aBP7cv5ixYMsUu1IoQIUiBWqqldvk4kjA5EQziERTYYyV4B20GwvR1A4WGuGVZejxULBT0cMtumT6WrkfGyiN2Av1IESu6d0jP76P8vOyN0OYfGIFn2VaM2c41UjjpvxPrqqrLylkBW5OZzGM6zWwOdawepnCvm8cDMRLFdIV4keYOzhArD77TwV2+FHOFEzMKFNy67dZ7SZuaTyIMl2Hv85O+CZ7rHHAwq4JMJhbfxKvMvr6V1r/JFajnsiwJ5tToAN4kktU/dmZCGZctdlsTiLg9jdDxv/bmU3UygwhQy5+M9EeQZSGG00wXtgZcZKoDHC9hxZhbALQpL5gJ9YLXMc/HCQMFQjM7thxiU+f6ZOuLGWVdNPqmuQvxbJr3J7yOi5Ci/NPL/MFYS0DS+YmXUIEZ//oSY3yVm1SL4rVjLk0XGFsd/kiTA0hh/SMIU4+DwsxmwvN8zRpIocpgbzvSwjzxbYAFYGt7RxikT8saFSBLl7bok4ACm6paEepX7owmYW07xZIZtB0bE3OrU7XimKIGv12uINFt4rCKd+bu2e8K8KSiWqGKrCFtHJL2VOiRGR4zDfni4vKfg/eqyM43U9cO5NNVUchBVcZGeTmyn0OH0wkiJinsLm3fbrxvwjpF0CuPfwLiRGESwSuI+nBcunx1ngGwR4/DBQXvHd7uR4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(316002)(186003)(6506007)(86362001)(8676002)(38100700002)(6486002)(8936002)(508600001)(2616005)(26005)(76116006)(54906003)(5660300002)(4744005)(2906002)(71200400001)(66476007)(66946007)(66556008)(91956017)(6512007)(4001150100001)(64756008)(36756003)(4326008)(66446008)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZYSmNMZkIzdStwQk05NVNMMUtXQ2dLQ2RxSTJjTG9idE1NaStNMk5WRUNt?=
 =?utf-8?B?ejhvdkVJeXlLY3VPOHJkS3ZpQlcxYVVpZ2g5UVZDRnBWRlZGWTVsdTZVdlBX?=
 =?utf-8?B?Q2htYmcwVk95TkptcFNvRGoyUkFtc0RVWnNDS0FjeXNCT2tPQ09VK3pLSGE4?=
 =?utf-8?B?WmdnR1JsNURxRHJBRE91SFczaVNrNlZhNndQK0pZeWhjdFlRZ2hvZHpmK3hW?=
 =?utf-8?B?NmlkaUNSRkdRWi9HZ1ovcFFUQ0Zyc0V3dy8xTm5tSUJTcWtycWtudUlNb3Rm?=
 =?utf-8?B?VERqdjR5bE4zSW1lUHQzSXppM1o0bEEvYVkrTk9RaWE4a2IvNVFmV0ZNVURD?=
 =?utf-8?B?TVJ5dktGVVJoNGl6YWNBWE5BYktleTJhTUl1aUlvaTR0cFUwQUJ2bjcrckRm?=
 =?utf-8?B?ZWZiOGhIZUN1Qjg0b1E0UGUrNnFoUjVMOU1kaU52WUg0THVhZE9uanNxOXZX?=
 =?utf-8?B?Qmx5Y21JNTI1R2NpYWlKVTIwRWtqL2pVUmVZQjNjQ3Vjc2ljejlCekpDYW5u?=
 =?utf-8?B?SUpGbDVKWmh5K0ZaQ1pNVUR2OVNtZEFGd0lXR0dMb2NWeXJadmdYTzV3bFBD?=
 =?utf-8?B?KzhmYitadHhEUGpaby90alhCRFR3Tkk1T1RSaW53YTRQY3oybUdyaWhyVEJj?=
 =?utf-8?B?em1DN3U2a0FRRXViUml5OWpDQ2J4NjdMYVlhcUpFbi9TSjE4dTlwb0M2aTha?=
 =?utf-8?B?Q1FCWUJZTGMwZTF4ekFnS0dOdmFTU0RBc1VmV1M2ckZ3OXZ6M0xwRWw4QjVm?=
 =?utf-8?B?NnJYNlpqaU5uWXJLa01vRGxxMUlqNFpJYURxRjJXWEduZ3oyRndROVFqY1dH?=
 =?utf-8?B?Uk1uWU1xb0FCQVlNNGl5ZXI3RHIrUlBMVGlkSDY3dyt2US9sVE9PZVJCSnk1?=
 =?utf-8?B?SlBkUmhpZ29jdDBNY21CbHVzYmFnbDh2ZzBOL291Z1hKM3hTYktZTSs2bStY?=
 =?utf-8?B?dDBHMU0vSWJLT0ErVm1QL3ZXM3VyMzdnVTg2OFg2MURaRGlSY2JadFI4V1Jw?=
 =?utf-8?B?a2VaZFFNa3paLzBFWmxvT2E4YU13d0hvb3NpZXZqbkxRRHcwUDdjd3lSVTVz?=
 =?utf-8?B?V0hJSGlUNUIyVEpzUE1qNVRBRldaSW05d1hmNnhrWFM2ODVSTzdIdC9NRHov?=
 =?utf-8?B?ZEpkaU83MWMwc3ZOamZySGRvM0FxTTRoQnd6KzVvTXRwdlAwbEdML2tkZnVp?=
 =?utf-8?B?TTJCampVNUl5UzJJNXI1a1ZxZ3NzOXMrVm5DVlgyOXNmN1JCMDNDd1dOVWZt?=
 =?utf-8?B?VnRLM3g2SHZLUEJFa1c1RGlWOHVMS1JJVjU0d0RuVFBlcWFqMHg4dVZlVHM1?=
 =?utf-8?B?ZHhoLzVIbitKWTBxUzRIa09FQjkrT2NYYlVOdnFFR0dMbTQwbHdkUzczVThR?=
 =?utf-8?B?d3pBa2xxTnQrbm9iVEFQS3hDaG1YanBRenp0L29kR1c1T2ZJWnVyeHV4ZE5a?=
 =?utf-8?B?SWhMalltMkVmRU1IRUkzaEtuMzdpSGtudytPY1RSU2xkblA0Q0I5VTFna2RN?=
 =?utf-8?B?QWdVQzVEQm53MWlUOWU5Tm9kYVloNmdweENuUnNTSGZqSWEweElaUWh2NkhB?=
 =?utf-8?B?amxGMWRHUHlkcWtRVE0rQXdTc2VSNXc0c2tkOSswOENqQWpNNDhDQXg2b0s4?=
 =?utf-8?B?cXl2NVFOb01uWnEwdzUvcWtKMDBMRUdoRDJZbXRaamFuYmFJdFZ5OUpJZnhQ?=
 =?utf-8?B?R3hJaTdVU0d1V2MzTlgwRy9IOU1jaWVHQ3dDTHFKaTNpRzYyMG5SUFBlV1U3?=
 =?utf-8?B?bWtjaEMwUFBiWDR2YVQrQ0RyWjE0RjNkdDByM1dPOCtCM0FVSVZuNlFBN0tv?=
 =?utf-8?B?cDIvSXgySVh3MEpvN0Jydz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB435F89B52DE74FBA94734ABA4B3E9D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc21293-a18f-40c6-49e3-08d98f630e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 22:36:25.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lv5BvQGqVb8QJtlRU5bzbemaaikKombwX+qeQGHkjR2ySISfvtnKIpULZ3zh+H40MsP23+lZ3QdRQ4uzBPpysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3431
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTEwLTEyIGF0IDA4OjU3ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMTIgT2N0IDIwMjEsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiANCj4gPiBTY290
dCBzZWVtcyB3ZWxsIHBvc2l0aW9uZWQgdG8gaWRlbnRpZnkgYSByZXByb2R1Y2VyLiBNYXliZSB3
ZQ0KPiA+IGNhbiBnaXZlIGhpbSBzb21lIGxpa2VseSBjYW5kaWRhdGVzIGZvciBwb3NzaWJsZSBi
dWdzIHRvIGV4cGxvcmUNCj4gPiBmaXJzdC4NCj4gDQo+IEhhcyB0aGlzIHBhdGNoIGJlZW4gdHJp
ZWQ/DQo+IA0KPiBOZWlsQnJvd24NCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9z
Y2hlZC5jIGIvbmV0L3N1bnJwYy9zY2hlZC5jDQo+IGluZGV4IGMwNDVmNjNkMTFmYS4uMzA4ZjU5
NjFjYjc4IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3NjaGVkLmMNCj4gKysrIGIvbmV0L3N1
bnJwYy9zY2hlZC5jDQo+IEBAIC04MTQsNiArODE0LDcgQEAgcnBjX3Jlc2V0X3Rhc2tfc3RhdGlz
dGljcyhzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2spDQo+IMKgew0KPiDCoMKgwqDCoMKgwqDCoMKgdGFz
ay0+dGtfdGltZW91dHMgPSAwOw0KPiDCoMKgwqDCoMKgwqDCoMKgdGFzay0+dGtfZmxhZ3MgJj0g
fihSUENfQ0FMTF9NQUpPUlNFRU58UlBDX1RBU0tfU0VOVCk7DQo+ICvCoMKgwqDCoMKgwqDCoGNs
ZWFyX2JpdChSUENfVEFTS19TSUdOQUxMRUQsICZ0YXNrLT50a19ydW5zdGF0ZSk7DQo+IMKgwqDC
oMKgwqDCoMKgwqBycGNfaW5pdF90YXNrX3N0DQoNCldlIHNob3VsZG4ndCBhdXRvbWF0aWNhbGx5
ICJ1bnNpZ25hbCIgYSB0YXNrIG9uY2UgaXQgaGFzIGJlZW4gdG9sZCB0bw0KZGllLiBUaGUgY29y
cmVjdCB0aGluZyB0byBkbyBoZXJlIHNob3VsZCByYXRoZXIgYmUgdG8gY2hhbmdlDQpycGNfcmVz
dGFydF9jYWxsKCkgdG8gZXhpdCBlYXJseSBpZiB0aGUgdGFzayB3YXMgc2lnbmFsbGVkLg0KDQo+
IGF0aXN0aWNzKHRhc2spOw0KPiDCoH0NCj4gwqANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=
