Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C64D90D3
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 01:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiCOAH2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 20:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiCOAH2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 20:07:28 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2098.outbound.protection.outlook.com [40.107.101.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842A1D332
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 17:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlcmN3W5ww25z5ci7br0omyfooAMgMNGiBCAGcm4mTvi+lFVeZb20l68qBTHAWBCU5rLVnnBfJBq7blviCfhYnJs9ud8iWysI1mj/CgomdXHaUJNxbCd738Pi4YKPGBZpFXJGTB7hVRd5WmAu7uBmWEo8IU57MNLjqGrl6GuV3tfMe3p+rZpdeKMViETAO0NWCPryxI3QpYxQh3wm6FhhrLEYQue2WTZ2bvXZPsFZYF/Dhx6iwltePcO53GU37FnQNeSJ6vx9c9qZ2qpgE4Msg8q7IqbNGZLzKEa0pPQayHEqfBDVDgijfNtYNfvIw8Ra4XJU6737QnefgtJYaVbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhnoJxltjiNZFRd6vfwewTwf+QooCWpuIpC4tACeEaw=;
 b=S2iFc5SWpa91SFZYCcWUnaIuUUbB3DydPDJckjcGCmQHKsm0S4/d1pFUiPXO7+pGvA8Yrghp9yLThFOQ70nmX+TnNLP1191U64v25psN8wMxOZf/sxFcz7ituCgrPDPFtTLZCNUFU3iKVt8Td1ZygPoB5NHQpwdyEOl8n9hXbBdczHuRC/hAAgDq6GxaP3LbDypNGm8Ahx5y/zpycBcw9EAEhXc0UQylNyq1N5ECdiRP3jM7yLW+0iGZW7WaxAsnHnx2qnuoz8s72cJ9q1Gwld0cW26v1dePeorFXyKOMerRal+NWWQOviHBW818nogoZvmrB3VAU0kw0ZlP06MrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhnoJxltjiNZFRd6vfwewTwf+QooCWpuIpC4tACeEaw=;
 b=PQb/fy6rGWfjf9Bp3r3Ce+d2QEDH7xAqffT/UM/9BFCMRhpnKYIUOQb7ClIkdebnGnw3ARapsdz5zLKATeFQ8h2tgiXvZKAI2ISTqcu5SjJXl7gd6qTegEpDZ55TDY6wxWv3Usn16EZ8izucRqurQ0Z+JcqMv7PvP6veiWBDfHk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1500.namprd13.prod.outlook.com (2603:10b6:3:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13; Tue, 15 Mar
 2022 00:06:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.013; Tue, 15 Mar 2022
 00:06:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: write_space and software kTLS
Thread-Topic: write_space and software kTLS
Thread-Index: AQHYN+t1B+vqcaPqcEao3l2OCHLB2ay/kR2A
Date:   Tue, 15 Mar 2022 00:06:12 +0000
Message-ID: <378c5635b97c237f869234e24030ac0018b684b3.camel@hammerspace.com>
References: <B7F08FCD-0EC1-4D7E-A560-6ADA281605AE@oracle.com>
In-Reply-To: <B7F08FCD-0EC1-4D7E-A560-6ADA281605AE@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79293564-c8ef-4b28-6cd3-08da06179de7
x-ms-traffictypediagnostic: DM5PR13MB1500:EE_
x-microsoft-antispam-prvs: <DM5PR13MB15001FA5D17BC68A26C7F3B8B8109@DM5PR13MB1500.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zwn9ovgACtSfxJ+pz/Gy6zquqFEL256Ire6aTIBUhsHiYmqt3pF+7oSFqAmijQH1wp0W0XAbAegWENjBAqiwF4wnvoaAiMLqT7zDHGfFAPpz84q/anonPM+c0Eg0C06ZjZ+A0e3jJPJ8BjAgNbnhZB3j3iTr0I3W3uEdUJGmZOhahSWKWCJ5SQqhxfvDE3hfrmJEKYjUKWtrDylfwqJcIdDdNkjXsUz2ElJe1CSUknFl+5KyfpqPR1UyfEVPYdoyj9dH/1upFgcuLNLw+TyZnHj2rv5wLLlSLSQp6iEhQ9Bu0Ras2tbYD4Cv5+dLyvL9XSBbF9DQ5+lQK8v/TCrz00QhVHczTkH3jT7ftmoMi2FP9sVToGnw+AdH4o+T6vPrmJeDZjOabn5J0+fSmWajHd6iGL8RLREsuuLHXcMbYyOpgsiTgvtbhrkDD2XaBx1aJqRusKBlgOsskB1MzyVIHSR+sFV3q7kF0PoFlzAhMnKTjJKr7+WpKxqvTjpJHYT2a0UqR2Khc2FAmht0+0IrtPOWqslXdxn++TjLXwbymzqwyunaQa3D+J04aLugdz/GFdl+qnAC6lqohQTfw8/LAPH177zdEOXjSoeuBdExzs439OVrNHnBMWKhWtMzc6EyNgzWSVQUJepnXzsD9DrWh1wNFRrJr8AwNQSVyKzUmTcDEpklbN7yRKLf6GANL1ODjtwrm1Likkw3TMABtfJMC2kUNaLHTWc+IpeVNN5esbGPEmm5jrwU+lYYs47j3TXD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(66946007)(8676002)(5660300002)(8936002)(66556008)(26005)(186003)(2616005)(2906002)(64756008)(66446008)(4326008)(76116006)(36756003)(122000001)(86362001)(508600001)(38100700002)(6486002)(71200400001)(6512007)(6506007)(83380400001)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVlKZlF3aG5tVTRxeFhsNHZOaG1PeUdtaGppL1VSSjFlQ1liU080bSt1enhp?=
 =?utf-8?B?anF4dlpKQzV5LzhEQjJ0WitjbzlNQzFsVGhLMVZpZ3J0L3FHQ0hVdU14a0xS?=
 =?utf-8?B?ODNyYzRlTk1qYi9PZTU4dkFnNEd5NEEzbVNhVWpoNUUzMElPZGRhbUgzOEdq?=
 =?utf-8?B?UlJ0eVI1RHJIUG1SYUVjSFlnWmE5R3FMdk1GSGpVWWlYcUQyajA5V0Q1b2VT?=
 =?utf-8?B?TW8zNU9XTjdLSVR0Qy9mNkEzRnNMSjdnZ2s0NnlCTGd0MHNTWUEyWXlDc1Vv?=
 =?utf-8?B?MlZuT0VmN3RISG1RYzBPdkdablZZbmdIY0U3TXdnYjh3eWtpK3M0ZHQ3K1lE?=
 =?utf-8?B?ekI2SDVkV2lOMkxMbkJwVW1SWGFQb1dzcXRudzBtRHFQWW9PVjZ6MmdqbDh5?=
 =?utf-8?B?OEVKQnBjcm5Rb3Y3S1FNdnlpMUFVbU91OWRob3hneDNzaVBFZDRobkY5dTI0?=
 =?utf-8?B?U2JZeEVLT21Yakl2Nlg5Y1JpOU1tWFdSTDY4Slc2dWJIZWdMbVUrTU5Xa0cx?=
 =?utf-8?B?Tkg2djVuWXo0L001VlN4V0Z6blFSczhPNkxmKzljcG1WQXRHNzlmMlg1Y0lC?=
 =?utf-8?B?bmNUYXZIaUkyZ21nQ0ltZTJOOUc1WkE4M3QxT296aTY1YndLREpCdHBSUk5H?=
 =?utf-8?B?bjZmS0hzTmpUMEc3bWdzWlVpaUJ1Q3dhemFFRTZOTE9nT2RKUFQwVUNpOXE4?=
 =?utf-8?B?U3M5REo4RG9Dd3NBNnJHVzN5SzRIUjFQRHdPSDJXbm96Zm5MUFR4ZDJwUlBU?=
 =?utf-8?B?bUJZVXM5OC8xU0Urayt1RWZ5TCt3UnB1S0ZMaFUvUVBhdW5nU204c2lOVWZB?=
 =?utf-8?B?R2JhdzVRVmRPK0tVWDl3ZzczVVB1MFZmNzNhV0JrYVVkZzZSOUphdG5OdlNn?=
 =?utf-8?B?cUhlSFRBakJKNVkzc2ZOTzEwenVGRklrSHVBWWQ2cEljR1pDUWs3a2F1T1E3?=
 =?utf-8?B?VUhCcWI0MzVWYXdJVThiUWFKTGdiUkhEejNuLzRRbXdJT1JobzhITkRkcWdp?=
 =?utf-8?B?amNYMHM0QnE3YllWM2diRDhIMVYyeE1LTjhLUStLS2JONXNIMEF6VTlGaEtJ?=
 =?utf-8?B?R0dadFptaW1IN25UOW5PeGR2d0QwRm1XMVIreWw4N1hoaXg3b0pVTzZYRk5x?=
 =?utf-8?B?dnBuYk1rYWtFUFhBdUxVekMyYTBaZER6ajhLUGRZeWc1VGljUFFOdXo2Y3lj?=
 =?utf-8?B?Z2pMN1lGc0FEZVhrOHJBZU84Z0M5czZ4VzZhVGZQR2lRNDcvcFNxZE1wb1E5?=
 =?utf-8?B?TktOK0FHWXhPWWRJUEFTVE1yYlVidGVGMXNuZlhSRmtXY0pDVWV3S2h5a3FD?=
 =?utf-8?B?U0dWK3ZpS2ZDWXNTa3NsQVZaWEY5TWgrZjg4bVdhZ3BNRFBiWW4rNktRdDYw?=
 =?utf-8?B?YzREWEdpdGMvWUFuOGRpM0RvdUU4ME5UcWN6TUt5R0RHTVc2TnNzQTdZd3V3?=
 =?utf-8?B?cloreERNZi9pQUFuUW1MUjNsN0hGWEJZbm1JYVM2UlhnSE5mamVYTFhKZUJO?=
 =?utf-8?B?OFhFcU41NFE3d0RHekNzTnpWTlFvTXNVaG1XTi84ZkRTQ3Fybmw3V1dGVjlX?=
 =?utf-8?B?K3h4bWRaSFpzSUdBbURGMzM3ZE5PZzVDOTJkOGNoVzNTRm1HQTg0TjFoMUNt?=
 =?utf-8?B?SGNhQktIRG03eWcyRFV4dkRUZ2ZVSVNoWHJIN2thRjRaWnZPbDJCSVRwaENV?=
 =?utf-8?B?MWhBRVRUd0N5Uk5YNXlQZlFZVE1zWkRjRlBPOGN2TzhHWmxTUVo3c3VoR0lK?=
 =?utf-8?B?alR6Uy9SMTArV2lBSGhnRzh5UzNDbjMzU2lLM1VoeXJIOHRWWlBLc1dUT2U4?=
 =?utf-8?B?YXpmRE1zT3kyQWZZTzlZd2tMTEpkcHRybjJmUGJ5UTl5cGJza0VXQnZETTdK?=
 =?utf-8?B?MSswWXBDQmxyV0lacld5eHppWkhGMllvUXA0djBidnpRcW95dUtGNGpJS2ZE?=
 =?utf-8?B?dGlMN0EzK1JyT3o2eXlza2R4MFJYN1NndkovRW1yNUs2K3lCYURMVTRKYlB2?=
 =?utf-8?B?dkNUR0JneGpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EC39BCA280E294698D578DDD76A1B14@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79293564-c8ef-4b28-6cd3-08da06179de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 00:06:12.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eK3QNn89FBdGbGq1NiALPmx+cd4Um2v4xeS6Av2x85Q6T/bXZ6tbBYuedTwKYide2pF8fADjl1VQjnn5HFtIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTE0IGF0IDIxOjM1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhleSBUcm9uZC0NCj4gDQo+IEkndmUgbWFkZSBzb21lIHByb2dyZXNzIGdldHRpbmcgUlBD
LXdpdGgtVExTIHdvcmtpbmcgaW4NCj4gdGhlIExpbnV4IE5GUyBjbGllbnQsIGJ1dCBJIHJlY2Vu
dGx5IGhpdCBhbiBpbnRlcmVzdGluZw0KPiBzbmFnIGFuZCBjb3VsZCB1c2UgYSBsaXR0bGUgYWR2
aWNlLg0KPiANCj4gVGhlIHNvZnR3YXJlIGtUTFMgaW5mcmFzdHJ1Y3R1cmUgdXNlcyBkb190Y3Bf
c2VuZHBhZ2VzKCkNCj4gdW5kZXIgdGhlIGNvdmVycywgYW5kIHRoYXQgZnVuY3Rpb24gaXMgY2xl
YXJpbmcNCj4gU09DS1dRX0FTWU5DX05PU1BBQ0UgZnJvbSB1bmRlciB4c19ub3NwYWNlKCkuIFRo
YXQNCj4gcHJldmVudHMgeHNfcnVuX2Vycm9yX3dvcmtlcigpIGZyb20gd2FraW5nIHVwIHhwcnQt
PnNlbmRpbmcsDQo+IHN0YWxsaW5nIGFuIFJQQyB0cmFuc3BvcnQgd2FpdGluZyBmb3IgbW9yZSBz
b2NrZXQgd3JpdGUNCj4gc3BhY2UuIEknbSBub3Qgc3VyZSBob3cgdG8gYWRkcmVzcyB0aGlzLCBh
bmQgSSdtIGludGVyZXN0ZWQNCj4gaW4geW91ciBvcGluaW9uLg0KPiANCg0KSG93IGlzIGl0IGFj
aGlldmluZyB0aGlzPyBXZSBvbmx5IHNldCBTT0NLV1FfQVNZTkNfTk9TUEFDRSBhZnRlciB0aGUN
CmNhbGwgdG8geHBydF9zb2NrX3NlbmRtc2coKS4NCg0KPiBGb3IgZXhhbXBsZSwgd2h5IGNoZWNr
IHRoYXQgZmxhZyByYXRoZXIgdGhhbiBqdXN0IHdha2luZw0KPiB1cCB4cHJ0LT5zZW5kaW5nIHVu
Y29uZGl0aW9uYWxseT8NCg0KVGhlIHNvY2tldCBjb2RlIGNhbGxzIC0+d3JpdGVfc3BhY2UoKSBp
biBhbGwgc29ydHMgb2Ygc2l0dWF0aW9ucywgc28gd2UNCm5lZWQgdG8gZGlzdGluZ3Vpc2ggYmV0
d2VlbiB0aGUgY2FzZXMgd2hlcmUgd2UgYXJlIGFjdHVhbGx5IHdhaXRpbmcgZm9yDQpidWZmZXIg
bWVtb3J5LCBhbmQgdGhlIHNpdHVhdGlvbnMgd2hlcmUgd2UgYXJlIG5vdC4gT3RoZXJ3aXNlLCB3
ZSdkIGJlDQpjYWxsaW5nIHhzX3J1bl9lcnJvcl93b3JrZXIoKSBhbGwgdGhlIHRpbWUuDQoNCj4g
DQo+IEFsc28ganVzdCBmb3IgbXkgb3duIHVuZGVyc3RhbmRpbmcgb2YgaG93IHRoZSB3cml0ZV9z
cGFjZQ0KPiBtZWNoYW5pc20gaXMgc3VwcG9zZWQgdG8gd29yayBmb3IgUlBDLCBJIGluc3RydW1l
bnRlZCB0aGUNCj4gY29kZSB0aGF0IGJ1bXBzIGFuZCBkZWNyZW1lbnRzIHNrX3dyaXRlX3BlbmRp
bmcsIGFuZCBmb3VuZA0KPiB0aGF0IHVuZGVyIG5vcm1hbCB3b3JrbG9hZHMsIHRoZSB2YWx1ZSBv
ZiB0aGF0IGZpZWxkIGdvZXMNCj4gbmVnYXRpdmUgYW5kIHN0YXlzIHRoZXJlLiBJJ20gbm90IHN1
cmUgdGhhdCdzIGludGVuZGVkLi4uPw0KPiANCg0KSXQgaXMgbm90IGludGVuZGVkLCBuby4gTG9v
a3MgbGlrZSB0aGVyZSBoYXZlIGJlZW4gdmFyaW91cyByZWZhY3RvcmluZ3MNCnRoYXQgaGF2ZSBt
YW5nbGVkIHRoYXQgY29kZS4gRnJvbSB3aGF0IEkgY2FuIHNlZSwgdGhlIHNvY2tldCBjb2RlDQph
c3N1bWVzIHRoYXQgc2tfd3JpdGVfcGVuZGluZyBzaG91bGQgYWx3YXlzIGJlIGJ1bXBlZCB3aXRo
IHRoZQ0Kc29ja19sb2NrKCkgaGVsZC4NCg0KTGV0IG1lIHdyaXRlIGEgZml4IGZvciB0aGF0Li4u
DQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
