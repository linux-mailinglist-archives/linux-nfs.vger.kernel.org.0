Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11D4F6ACD
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 22:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiDFUHP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiDFUG0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 16:06:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2109.outbound.protection.outlook.com [40.107.243.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054E9D7905
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 10:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYSAsc3h2J2ruO/wPGEl2VOaUdR83bHlw+7JxuiNwXkuaAnNlr9qLJobXoXj23YgcthV55RRUzjp0eOwimgMFdHG5W6B3ijFuvk9A0E8T6Uc72cukeIZyMLICYWXyQzXR56DruRwP3UupnhEmrl6ZW3aSq8XeXq5PQHZ15ZI4qPAFQZDY6jU7U4yPp+QA9277wvhMfTyNMhheVKL97Rexh6R8KbcgWrfua39Bo3/30CXJTVEjhM+IRRZMYLKom1btcqOUiNgAj25RY6W40TNlqdrMURxs1Yl58wVZknpHzsIdl6nfCDDG5SUrVkjj2HYH6A79eD9H9QZdnCTCB59FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tm3h8rVfRyQSAWQVS0YFw4kwpMqlwh3PXSwaKWyM4EY=;
 b=is3hhQi97JKG1X+5XMeKHAegTO6AJv5Gt7fcKBQQeJHpemcSdrHnmtMsC6hPHwdmK5N3N5wj/dUDOf4lUuwCuDLG44Wgd2lgld04PA5Hx38bO/lUCgImlTbGzmuKfxGBFc1HmrDaxjBgari4KeIMunrPDIQ3KsSydE1DF6fo7q9plngKbGi1qJJxM+m9Q3HMemCbEd7VZ3lmjLYJPoUF2jWb0Q5ZYyu5KcImwquUUnrH1xDQDQ9kLqL7euhYRFBUrLeLCRbW33aKAfkkZuIgAecfVAR3Jl05eUQ89CBo9eDVp1RI/gzXAAdrU1sUyF8eGDDSDrhS90Mw/l53YEuI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm3h8rVfRyQSAWQVS0YFw4kwpMqlwh3PXSwaKWyM4EY=;
 b=JB7apcd4Wx/QAR5ZyjzIwxYwOTm22TJnH7t3L2aOAxtfNcQgiQJrbNBhbRIx6lVr0s1EAaqkELgWvUPXs3um7U4+NPebiAHEz2o2QV6831JiPS6StIiGM2gym4K3qhaBsP+zlPGg16LGZo3cP6w311XCPZCWuMcwEtAaBxqT5Pc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR1301MB2012.namprd13.prod.outlook.com (2603:10b6:4:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.7; Wed, 6 Apr
 2022 17:39:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 17:39:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Possible NFS4 regression on 5.18-rc1
Thread-Topic: Possible NFS4 regression on 5.18-rc1
Thread-Index: AQHYSdiMZdAqZEceQ0Wd3Ajd22fef6zjJsaA
Date:   Wed, 6 Apr 2022 17:39:16 +0000
Message-ID: <23f11c6151f9bbfbb09d2699f4388d4a09a87127.camel@hammerspace.com>
References: <20220406142541.eouf7ryfbd7aooye@basti-XPS-13-9310>
In-Reply-To: <20220406142541.eouf7ryfbd7aooye@basti-XPS-13-9310>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5124ffad-03dc-4b15-e8b1-08da17f45f64
x-ms-traffictypediagnostic: DM5PR1301MB2012:EE_
x-microsoft-antispam-prvs: <DM5PR1301MB20121B7E49EDDA840A679813B8E79@DM5PR1301MB2012.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gez+o9BpdSXkLrmRhaQd8R5rjMUNbhKyvIQMXcCg4SagFyrytMzWHI/iQ0eraO0aJYmIqa0gvvZhg8OoQxjE1UJTFknNdsW83A63r1P7MkbIl0QaKA2Liip/X3DToKktnXTPgYtwUv/GoZygtIxDhLUbsmG7QcWxNggM8Xat0b3tYvBTeezdF7g7BRJcY3X3aiuz7M/v0BBivPwwTmndZfTIo/tPonay8e/GLz36qk+YgF9S42JnvpKiRFH0VgYXhcBk6fVq3I7S3j8bndyaThkejfzcpKJNTnlQ2zjAfux8AsuYlJwPeWfcSokb+PcirxG7Vg+WB8X8KlEFF2aw47htdyJBbHL3K/5Qxb7nUUQjK32fkIsPRF/dVEgEloAvh7xMX+4XrKIjLVgPKiqGMByYhnHHlRp6DGXWRoy/Nfms3jHB3FnxlknecCzmlUkCRUNfW8a2oTUbmbPcRn6NQdB5LWnLDrWUoMwxqjFL5EHt9Ihk68dYRHvOf26QQZwXwdcu5LyCsGQMm2PPtUXdcK+F343PntWfavYqQv9Lpiu9qErg9kt4eO3/TkISfJTWhQqKy8PB26yXQZjiFeAvKrhsP82jzIu82Nh0bcrNqwwkhT4EmJSrYzdQ1+O60Ho45izmyhex5KRGL8CSKrOsvT+zRxXRDDQAhkuZsixyhH3vKA7N6j4d2w7Uxw0rucggdNmaqiCI2zggZTZldhwy7U4NEgpPtAeOInsJ41AAhpLSG59PmUQ9hgs8v34umGLJqq92mwUGHR6Zv98u0G1VOC4q3aQltZbAi7e4FjKZzZ2ko+8Yy7JG/3mIs68kJLMD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(5660300002)(6512007)(2906002)(2616005)(86362001)(8936002)(36756003)(38100700002)(110136005)(966005)(38070700005)(71200400001)(316002)(6506007)(26005)(186003)(66556008)(45080400002)(76116006)(66446008)(8676002)(64756008)(66476007)(508600001)(66946007)(6486002)(10090945011)(299355004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T29Jc3V1WEJYaDI5bDQ3ZU1xeENSRlg0WndON2hzQ0EwdDFONUgyNS9Fb0d3?=
 =?utf-8?B?L05FL2VZcWJYeFdydmEwUVNmN2pOT2VyS0VacThVVm05WDZZWDdzeG53aVMr?=
 =?utf-8?B?ZWYxVVV3MEdLRHZKaUhKQkJuNjhzdU5qVWRxeThqV0xZYWxXTlhHc1pIbjdZ?=
 =?utf-8?B?VnpWNElBb0JPOFZTQ2pOcjR2RXFCMEM2V0F6VUpxdW5QMkRjalVCUmhiUXZS?=
 =?utf-8?B?SmJHYmE5K2ErSVAxK3JrSTFZUjV3QnBYRGtWY1Z3WnRLdkdxRlpKNDFwTTVp?=
 =?utf-8?B?MUlZZWZlZWVXM2IxTndITmhzZ09kaXNyZ0tGV0kvWTc2UkxHMExKOXpsRnZx?=
 =?utf-8?B?NENVMUt1S01jdHEyZmxJcVN4amxmcHhwY1JCUkNqZ0dvc08wV3lha3I2WkRv?=
 =?utf-8?B?UkpkSkRNUUJ5RkZjR3o0UkVKOTEydEptTzh2MXJRMzFDWnV1WFRwT3BoWkZj?=
 =?utf-8?B?SzNJVEswUFBUUmZmdDFGWVZLNmtMQllVZ0FTRk0wbkh5bW9YZGRUQkxVQVR0?=
 =?utf-8?B?TERmQlFPenk0ak5mMVpuY25Ra3hxQUxaMHBsb3ArYnJ0dTVXMDFFQXJIOXpB?=
 =?utf-8?B?UmppNm5WSyt3b0pKYkJvSm1XRFhkWE9rYmpGOGh1Qk1vUlZ3Mk5vYXdKbUd0?=
 =?utf-8?B?Q3VQeUdqQ3psSGVteFhUSHVDYnQ3emQ2WGVjWjZtZ1FKdUtNQlBCb2VoWG9a?=
 =?utf-8?B?aWhQSUhDbGU1WDU0aVh6V1E5c0JmRjdvdGZsY1VnSk91UDVuTDBTeEMzNmRp?=
 =?utf-8?B?K05WLzdRYllrd24wbmlvWlNrdHhwOFBTZTJuTFowemk2K3BBc1R6cG5SZHN1?=
 =?utf-8?B?aWt0QTJRL0UxWDNyWE1tT0pqS1NvNGwwS0FaeUZpbHBMaWFYYkpQUHR2ekVW?=
 =?utf-8?B?QzBOeElHSGVtaVhVQTVISUhjSjJjakZnSDVocWhkVkFsNVpYMEFJUUJMdVpU?=
 =?utf-8?B?d2o3YllSOFJ1NnJnQ2RvNFJ0a3hLMHFXck1mUXg5UVNKMm5rWlpDdmo2eGVu?=
 =?utf-8?B?dVdpWGYvSEJtTnJYQnFsYjBiVGJJYnM3OUw5dFlRR2oxWkhPK29xa0M4Q3lx?=
 =?utf-8?B?YkFwa0lRSjZ2cjNFU1orRWphUGp0aE1kaFZOS05rYXY1RHQwM3NGRm0wRloz?=
 =?utf-8?B?L1prWWhsQmlvV1RPc0lLaytQdDRtWXdhbnpwcXlJOHBMS3lrbkdUOTdHdEIr?=
 =?utf-8?B?bWdscitrYlR1cE5MMG1VV0xrVHlraU4xaGE5ME9LWnpmb2ZlSHJ3aXJCaW5T?=
 =?utf-8?B?azAxS1Yva2tHbENJcEdSS2VHL2ZKZzFJbnZYUmNLTTJUWEhOczFsNmQzaDVO?=
 =?utf-8?B?bk1uWUxjOHhkY3RTUUpJY283dnZZK21YNXdoRkVtcndQQ1VaOGVJSzVwcGVZ?=
 =?utf-8?B?NStyT2c5L2FvR1NHd3M3TDNFNS90NmxDbjR2MGx2dlAva2JrWndzQ01qOVdR?=
 =?utf-8?B?S1J1bnpHUFRpVFI3Zi91eTY5Qm5uQTI2NXRHa3V4alhYdHlLaituNTU3MEp5?=
 =?utf-8?B?Q0tCRTM4cTcvQkwybk55ZW9FOEtzWjNMb2IwVzZtOWVQbTVqdTd6R09LVGpJ?=
 =?utf-8?B?Wms4ZTdzNnppL2hRRWxwZmJHQ01VSklQT204WHRRN1dLWURjV01IUzJFZEZN?=
 =?utf-8?B?bi9zbktDVW94TzFzRS9ITlp4d3V2U2F1RVpDaHFWVHFUdGxoSHlhcVJYRVJE?=
 =?utf-8?B?eDU3MldtNUR0YUp5R0Y0TTRjMS85S2pUSHRHSkt4NXFKTjYyTVNNUnlsZHNv?=
 =?utf-8?B?dzNGc1FoSGorSFExL3p0eTRVSFdZV3czQWpMM2JUVUQ1NzNpcXdHTU9mOG04?=
 =?utf-8?B?U1hEc080L0tJUE5yVnFFSEdWakpoM014NGtrMjMvdllZWEJLdkpvZzNaV2JC?=
 =?utf-8?B?VkxjREVPOW8wSFdwb3VyV1lLRjZocnlxUVd6aDYxS2poVFhSOHFpTUlmVTI0?=
 =?utf-8?B?NVEyTEx5K0gwZmRPQ2k5Qis2RlpPOEF5WWZrMlBUT3FGc3ZVekVRYXZQSUxr?=
 =?utf-8?B?NGZaZUREVnVHcjJmL09COHl6dmJRTmlCTGtKNGNzd3BVSEhhb1l1Q3R1S2wx?=
 =?utf-8?B?V3dYdms4V0lUUGQ0cXJiNHhMREt1WFRITDRzY3ZBQ2lXakt6dkFZUkRUL0Ny?=
 =?utf-8?B?bXNxVnd0SWx6UzlISDhpTy9HTWt6UXB6bGRjT0ZhR1h0eTdjTCtmdDg3c3lh?=
 =?utf-8?B?SFZBREVjdUN3aUV2NWVoL3dRVExXWnh0U0hBSVluSW1ENWszWjBza0hobzJB?=
 =?utf-8?B?TkhHTGNnS3hhL0h5UUtJaUFpcjduTnJCeWdzZ28xdis4Sm4xYjlRR0VZaHFY?=
 =?utf-8?B?ZTRWejlLbXQ1Z29MR1FIZ2ZaZEwveFdvQVFoYnh0bWlkS3k0aWZsajlLUUhv?=
 =?utf-8?Q?7grFINYd9YDjPDW0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D485B92B7CAC0F4692BD1EE295220BF9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5124ffad-03dc-4b15-e8b1-08da17f45f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:39:16.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VD/YraYcaTqPW8xSQ81Q3qmK+mefjEx+sHRiILJ4Ny7NKX5w7NtHUtUhtBzsdU6gEjUznsiki94Fp1DCy8QpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTA2IGF0IDE2OjI1ICswMjAwLCBTZWJhc3RpYW4gRnJpY2tlIHdyb3Rl
Og0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHNlYmFzdGlhbi5mcmlja2VAY29s
bGFib3JhLmNvbS4gTGVhcm4NCj4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0DQo+IGh0dHA6Ly9h
a2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uLl0NCj4gDQo+IEhlbGxvIGZvbGtz
LA0KPiANCj4gSSBhbSBjdXJyZW50bHkgZGV2ZWxvcGluZyBhIFY0TDIgZHJpdmVyIHdpdGggc3Vw
cG9ydCBvbiBHU3RyZWFtZXIsDQo+IGZvcg0KPiB0aGF0IHB1cnBvc2UgSSBhbSBtb3VudGluZyB0
aGUgR1N0cmVhbWVyIHJlcG9zaXRvcnkgdmlhIE5GUyBmcm9tIG15DQo+IGRldmVsb3BtZW50IG1h
Y2hpbmUgdG8gdGhlIHRhcmdldCBBUk02NCBoYXJkd2FyZS4NCj4gDQo+IEkganVzdCBzd2l0Y2hl
ZCB0byB0aGUgbGF0ZXN0IGtlcm5lbCBhbmQgZ290IGEgc3VkZGVuIGhhbmcgdXAgb2YgbXkNCj4g
c3lzdGVtLg0KPiBXaGF0IEkgZGlkIHdhcyBhIHJlYmFzZSBvZiB0aGUgR1N0cmVhbWVyIHJlcG9z
aXRvcnkgYW5kIHRoZW4gSSB3YW50ZWQNCj4gdG8NCj4gYnVpbGQgaXQgd2l0aCBuaW5qYSBvbiB0
aGUgdGFyZ2V0LCB0aGlzIGZhaWxlZCB3aXRoIGEgc2VnbWVudGF0aW9uDQo+IGZhdWx0Og0KPiBg
YGANCj4gZ3N0cmVhbWVyfCBDb25maWd1cmluZyBsaWJnc3RyZWFtZXItMS4wLnNvLjAuMjEwMC4w
LWdkYi5weSB1c2luZw0KPiBjb25maWd1cmF0PQ0KPiBpb24NCj4gU2VnbWVudGF0aW9uIGZhdWx0
DQo+IEZBSUxFRDogYnVpbGQubmluamE9MjANCj4gL3Vzci9sb2NhbC9iaW4vbWVzb24gLS1pbnRl
cm5hbCByZWdlbmVyYXRlDQo+IC9ob21lL3VzZXIvZ3N0cmVhbWVyX2Nyb3NzYnVpbGQgPQ0KPiAv
aG9tZS91c2VyL2dzdHJlYW1lcl9jcm9zc2J1aWxkL2J1aWxkIC0tYmFja2VuZCBuaW5qYQ0KPiBu
aW5qYTogZXJyb3I6IHJlYnVpbGRpbmcgJ2J1aWxkLm5pbmphJzogc3ViY29tbWFuZCBGQUlMRUQN
Cj4gYGBgDQo+IA0KPiBBbmQgb24gdGhlIGtlcm5lbCBzaWRlIEkgZ290IGEgT09QUzoNCj4gDQo+
IGBgYA0KPiBbIDQ1OTUuMTkzNDMzXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgYXQNCj4gdmlydHVhbCA9DQo+IGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAw
OA0KPiBbIDQ1OTUuMTk0MjU5XSBNZW0gYWJvcnQgaW5mbzoNCj4gWyA0NTk1LjE5NDUxOF3CoMKg
IEVTUiA9M0QgMHg5NjAwMDAwNg0KPiBbIDQ1OTUuMTk0ODU3XcKgwqAgRUMgPTNEIDB4MjU6IERB
QlQgKGN1cnJlbnQgRUwpLCBJTCA9M0QgMzIgYml0cw0KPiBbIDQ1OTUuMTk1MzQzXcKgwqAgU0VU
ID0zRCAwLCBGblYgPTNEIDANCj4gWyA0NTk1LjE5NTYyMl3CoMKgIEVBID0zRCAwLCBTMVBUVyA9
M0QgMA0KPiBbIDQ1OTUuMTk1OTA4XcKgwqAgRlNDID0zRCAweDA2OiBsZXZlbCAyIHRyYW5zbGF0
aW9uIGZhdWx0DQo+IFsgNDU5NS4xOTYzNDhdIERhdGEgYWJvcnQgaW5mbzoNCj4gWyA0NTk1LjE5
NjYxMF3CoMKgIElTViA9M0QgMCwgSVNTID0zRCAweDAwMDAwMDA2DQo+IFsgNDU5NS4xOTY5NThd
wqDCoCBDTSA9M0QgMCwgV25SID0zRCAwDQo+IFsgNDU5NS4xOTcyMjldIHVzZXIgcGd0YWJsZTog
NGsgcGFnZXMsIDQ4LWJpdCBWQXMsDQo+IHBnZHA9M0QwMDAwMDAwMDA0NTBhMDAwDQo+IFsgNDU5
NS4xOTc4MDddIFswMDAwMDAwMDAwMDAwMDA4XSBwZ2Q9M0QwODAwMDAwMGYxODEyMDAzLA0KPiBw
NGQ9M0QwODAwMDAwMGYxOD0NCj4gMTIwMDMsIHB1ZD0zRDA4MDAwMDAwMzkwYmYwMDMsIHBtZD0z
RDAwMDAwMDAwMDAwMDAwMDANCj4gWyA0NTk1LjE5ODc5M10gSW50ZXJuYWwgZXJyb3I6IE9vcHM6
IDk2MDAwMDA2IFsjMV0gUFJFRU1QVCBTTVANCj4gWyA0NTk1LjE5OTMwMF0gTW9kdWxlcyBsaW5r
ZWQgaW46IHJwY3NlY19nc3Nfa3JiNSBhdXRoX3JwY2dzcyBuZnN2NA0KPiBuZnMgbG9jPQ0KPiBr
ZCBncmFjZSBmc2NhY2hlIG5ldGZzIGlwdGFibGVfbmF0IG5mX25hdCBpcHRhYmxlX21hbmdsZSBi
cGZpbHRlcg0KPiBpcHRhYmxlX2Y9DQo+IGlsdGVyIGJ0c2RpbyBpcDZ0X1JFSkVDVCBuZl9yZWpl
Y3RfaXB2NiBpcHRfUkVKRUNUIG5mX3JlamVjdF9pcHY0DQo+IHh0X3RjcHVkcD0NCj4gwqAgeHRf
c3RhdGUgeHRfY29ubnRyYWNrIG5mX2Nvbm50cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdf
aXB2NA0KPiBuZnRfY29tcGE9DQo+IHQgbmZfdGFibGVzIG5mbmV0bGluayBoYW50cm9fdnB1KEMp
IHJvY2tjaGlwX3ZkZWMoQykgaGNpX3VhcnQNCj4gdjRsMl92cDkgcm9jaz0NCj4gY2hpcF9yZ2Eg
djRsMl9oMjY0IGJ0cWNhIHZpZGVvYnVmMl9kbWFfY29udGlnIGJyY21mbWFjDQo+IHZpZGVvYnVm
Ml9kbWFfc2cgdjRsPQ0KPiAyX21lbTJtZW0gYnRydGwgc25kX3NvY19lczgzMTYgc25kX3NvY19h
dWRpb19ncmFwaF9jYXJkDQo+IHZpZGVvYnVmMl9tZW1vcHMgYnQ9DQo+IGJjbSBzbmRfc29jX2hk
bWlfY29kZWMgc25kX3NvY19zaW1wbGVfY2FyZCBzbmRfc29jX3JvY2tjaGlwX2kycw0KPiBzbmRf
c29jX3NwZD0NCj4gaWZfdHggYnJjbXV0aWwgdmlkZW9idWYyX3Y0bDIgc25kX3NvY19zaW1wbGVf
Y2FyZF91dGlscyBidGludGVsDQo+IHZpZGVvYnVmMl9jPQ0KPiBvbW1vbiBzbmRfc29jX2NvcmUg
Ymx1ZXRvb3RoIGNmZzgwMjExIHNuZF9wY21fZG1hZW5naW5lIHZpZGVvZGV2DQo+IHNuZF9wY20g
c249DQo+IGRfdGltZXIgZHdfaGRtaV9pMnNfYXVkaW8gbWMgZHdfaGRtaV9jZWMgc25kIHJma2ls
bCBzb3VuZGNvcmUNCj4gY3B1ZnJlcV9kdCBzdT0NCj4gbnJwYyBpcF90YWJsZXMgeF90YWJsZXMg
YXV0b2ZzNCBjbHNfY2dyb3VwIHBhbmZyb3N0IGRybV9zaG1lbV9oZWxwZXINCj4gZ3B1X3NjPQ0K
PiBoZWQgcm9ja2NoaXBkcm0gZHJtX2NtYV9oZWxwZXIgZHdfaGRtaSBkd19taXBpX2RzaSBhbmFs
b2dpeF9kcA0KPiBkcm1fZHBfaGVscGU9DQo+IHIgZHJtX2ttc19oZWxwZXIgY2VjIHJjX2NvcmUN
Cj4gWyA0NTk1LjE5OTcwMl3CoCBkcm0gZHJtX3BhbmVsX29yaWVudGF0aW9uX3F1aXJrcyByZWFs
dGVrKEUpDQo+IFsgNDU5NS4yMDc3NTldIENQVTogNCBQSUQ6IDM3MTYgQ29tbTogbWVzb24gVGFp
bnRlZDogR8KgwqDCoMKgwqDCoMKgwqAgQ8KgDQo+IEXCoMKgwqDCoCA1LjE9DQo+IDguMC1yYzEt
cm9ja3BpZGVidWcyICM5NA0KPiBbIDQ1OTUuMjA4NTMyXSBIYXJkd2FyZSBuYW1lOiBSYWR4YSBS
T0NLIFBpIDRCIChEVCkNCj4gWyA0NTk1LjIwODkzOF0gcHN0YXRlOiA2MDAwMDAwNSAoblpDdiBk
YWlmIC1QQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMNCj4gQlRZUEU9DQo+ID0zRC0tKQ0KPiBbIDQ1
OTUuMjA5NTUyXSBwYyA6IGxpc3RfbHJ1X2FkZCsweGQ0LzB4MTgwDQo+IFsgNDU5NS4yMDk5MDdd
IGxyIDogbGlzdF9scnVfYWRkKzB4MTVjLzB4MTgwDQo+IFsgNDU5NS4yMTAyNjNdIHNwIDogZmZm
ZjgwMDAwYjc1YmJmMA0KPiBbIDQ1OTUuMjEwNTU2XSB4Mjk6IGZmZmY4MDAwMGI3NWJiZjAgeDI4
OiBmZmZmMDAwMDA1Y2Q5ZDgwIHgyNzoNCj4gZmZmZjAwMDAwNTY9DQo+IDkyYTEwDQo+IFsgNDU5
NS4yMTExODhdIHgyNjogMDAwMDAwMDAwMDAwMDBmMCB4MjU6IGZmZmYwMDAwMDE5NjIwMDAgeDI0
Og0KPiBmZmZmODAwMDAxOD0NCj4gZDdhODANCj4gWyA0NTk1LjIxMTgxOV0geDIzOiAwMDAwMDAw
MDAwMDAwMDAwIHgyMjogMDAwMDAwMDAwMDAwMDAwMCB4MjE6DQo+IDAwMDAwMDAwMDAwPQ0KPiAw
MDAwMA0KPiBbIDQ1OTUuMjEyNDQ5XSB4MjA6IGZmZmYwMDAwMDc4ZmRjODAgeDE5OiBmZmZmMDAw
MDEzYmU4ODA4IHgxODoNCj4gMDAwMDAwMDAwMDA9DQo+IDAwMGMwDQo+IFsgNDU5NS4yMTMwODBd
IHgxNzogMDAwMDAwMDAwMDAwMDAyMCB4MTY6IGZmZmZmYzAwMDEwMjg2MDggeDE1Og0KPiBmZmZm
ZmMwMDAxMD0NCj4gMjg2MDANCj4gWyA0NTk1LjIxMzcxMF0geDE0OiAxNjAwMDAwMDAwMDAwMDAw
IHgxMzogMDAwMDAwMDAwMDAwMDAwOCB4MTI6DQo+IGZmZmYwMDAwZjc3PQ0KPiBkZjI3OA0KPiBb
IDQ1OTUuMjE0MzM5XSB4MTE6IDAwMDAwMDAwMDAwMDAwMDAgeDEwOiBmZmZmMDAwMGY3N2RmMjU4
IHg5IDoNCj4gZmZmZjgwMDAwODg9DQo+IDFmMTJjDQo+IFsgNDU5NS4yMTQ5NzBdIHg4IDogZmZm
ZjAwMDAwMWJiZDMwMCB4NyA6IDAwMDAwMDAwZWNjMDdiMzEgeDYgOg0KPiAwMDAwMDAwMDAwMD0N
Cj4gMDAwMDENCj4gWyA0NTk1LjIxNTYwMF0geDUgOiBmZmZmMDAwMDAxZjA0MTAwIHg0IDogZmZm
ZjgwMDAwYjc1YmJiMCB4MyA6DQo+IDAwMDAwMDAwMDAwPQ0KPiAwMDAwMA0KPiBbIDQ1OTUuMjE2
MjI5XSB4MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDoNCj4g
MDAwMDAwMDAwMDA9DQo+IDAwMDAwDQo+IFsgNDU5NS4yMTY4NThdIENhbGwgdHJhY2U6DQo+IFsg
NDU5NS4yMTcwNzddwqAgbGlzdF9scnVfYWRkKzB4ZDQvMHgxODANCg0KSSBkb24ndCBoYXZlIGFu
IEFSTTY0IHN5c3RlbSB0aGF0IEkgY2FuIHVzZSB0byBkZWNvZGUgdGhpcy4gQ291bGQgeW91DQp0
aGVyZWZvcmUgcGxlYXNlIGRvIG1lIGEgZmF2b3VyIGFuZCBkZWNvZGUgaXQgZm9yIG1lPw0KDQpU
byBkbyBzbywgcGxlYXNlIGluc3RhbGwgZ2RiIG9uIHlvdXIgc3lzdGVtLCBhbmQgdGhlbiBydW4g
dGhlIGZvbGxvd2luZw0KY29tbWFuZDoNCg0KZ2RiIC1leCAnbGlzdCAqKGxpc3RfbHJ1X2FkZCsw
eGQ0KScgLS1iYXRjaCB2bWxpbnV4DQoNCg0KVGhhbmtzIQ0KICBUcm9uZA0KDQo+IA0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
