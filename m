Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DF243629B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJUNTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 09:19:08 -0400
Received: from mail-dm6nam08on2134.outbound.protection.outlook.com ([40.107.102.134]:43329
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230283AbhJUNTH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Oct 2021 09:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsOlLh3fO3vEvD7dAt9B8qGJnfyr4RkCYx1EvzFOuW1W+Kpl7IaKM7n9JcOqja1kP9irmc/TmHmu6mFnyohLs5wi6BuDMTI5shq2CDHceAheg1kUwT14qYTQlhSMfxfcR7snq4XY5PNBw3j7OrfwqlwsR3np+MSvU2c+cTf1U0vHxAj8NfPu8SWEmT8IHMPCz+1K1EceOLZVwwO+yJCrTMqF4fG943aackB/c6ISp+6yTBEpZZIXgyhRdkEWi+xi7js/GFRmZxQkGry7IOa5mHo/A+GQuB2Mnrr3p6Il9wKNBsD/PGtnAiX19LpsIt2gvGRT0JfbgMPftzXxFVUSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fw2dodm9qwyQ7ex0Ij1XndO3yFf9pOjS9ay1AZnhBo=;
 b=P2BoBUg2Y+LeIjwflu1AvZK+97cclNa++8LassbpPKBlr0+4I4TQpwBDt/ZZcGluWX3zZdrPtTo3uJPt6rfW3WDhNVDJLu0vntEBCxhuqvGV/ljnBr1pQ5dp5bQHA2qDQEmcBAqMyCgP/1Q4VjIbaE/Qr+QpnI01GZHp1cYtj5ngmHnSolIU2neugZWizOyf2zmViXmYYszcmC35GfgkZDafosYkhGF9fnAJWR0agUpW9ZeCQaObnO6KA4qkvwpY3YTMcLfMuOsrpUkGyNaqas6lFg/tya3qUPRNaP5ibaMliQ6qaBpg8mgQvGDTf9X8/N97kMBAE6Bo8LoIhsJsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fw2dodm9qwyQ7ex0Ij1XndO3yFf9pOjS9ay1AZnhBo=;
 b=FcWf09wBurIryhnnPOS318OF/kVpJi5w7lT3aEqsy7eARCZk9AjjpCn//YQXiRn4hgbZnn5rJDbHdDngaya6MnA/GLztKMVmb6xp84DFrLGITOpK3TFL10c6zfNuvjThc52JKckK3PIX7PODood8spBYylYeU91UJ7aMHHOTGPE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3831.namprd13.prod.outlook.com (2603:10b6:610:a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.10; Thu, 21 Oct
 2021 13:16:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4628.016; Thu, 21 Oct 2021
 13:16:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "caihuoqing@baidu.com" <caihuoqing@baidu.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] SUNRPC: Make use of the helper macro kthread_run()
Thread-Topic: [PATCH] SUNRPC: Make use of the helper macro kthread_run()
Thread-Index: AQHXxlfA/ysQaLYpQUS9097wJ9k5nKvdbx2A
Date:   Thu, 21 Oct 2021 13:16:48 +0000
Message-ID: <36250e331421cddb10fbb1ca38df72aad812e3a3.camel@hammerspace.com>
References: <20211021084336.2448-1-caihuoqing@baidu.com>
In-Reply-To: <20211021084336.2448-1-caihuoqing@baidu.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95107e46-f584-4a46-8f4c-08d994950a03
x-ms-traffictypediagnostic: CH2PR13MB3831:
x-microsoft-antispam-prvs: <CH2PR13MB3831CDF225218EC5FA004247B8BF9@CH2PR13MB3831.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ny6oWkSHtXPZIePCBpUm55G3U1E24RaeQPsdBdQgOn3m6QZ2Z7TCiZie6tc9wYvKRg59ZzVfcLSJqqariqFML8kcAFaQvygqNzcs/dknJbFHeiFZTUNNW7CblOgidRPo5eFjdnwoNCLvNgYRXU7rrLSK8YKV/9Ul5xSyuVBEi60k0Te2zx7kgrGF/jEsOrkhvkXObEnDjCpgmMj//NjTY4Jvw66zsGZ8RprgkkqUMDrpe1CN97CA47P67mMWhf5jV/LQGwMwG+XiYxw7wuDBE7XcumA0a4LpLTlXDFDUBT8dqyab4Bg2nd/1bZrO3DTUUIgcEJOsmlQuhuWKFXgdikHXaqSG/XA71aKNO8DjSrcuVGuoYmWw8HAEnm2TEcp8YKTNFgVI3vqOiPhgsTetcaxZB3dik2Tb33qLc4N9ktXkwbSpm3dI7RTum08PBsvsFATOR006s9W2Ai5RPn9/huGxwS8m6i9VyGcPN/Jc3dIzrkY6PiAe1dis+BaltlzQnSJ1trH7zb/fmiyDxqGet+KVFhCMUf592OujJo0WlPl/KkoTA4G8R1ifX1hgwVTSlUlzZWRP5jpGsY9JF30ARtNn4UtelWOkLLFzHCU8mZfGphvDFDHVb1NUUt4A8Vtho2CkybICsSpdSU60REVtTdlIscmLl9iiRfNPgfZ60FEsqnncce6z8kB584czkfK1sip6r9gv8sIjH/iiYGAc3qkFovLFVYf05BBq7s346qJWFaPa4+VNGOwFlx9Hpo9q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(6506007)(6916009)(36756003)(186003)(83380400001)(966005)(2906002)(71200400001)(508600001)(8936002)(4001150100001)(316002)(8676002)(2616005)(66476007)(4326008)(26005)(76116006)(66946007)(54906003)(66446008)(64756008)(66556008)(6486002)(86362001)(122000001)(5660300002)(38070700005)(38100700002)(10090945008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUNUQ1dCNFJpWk96UFlYTGg3RHRiVldQYnBpU3B2WWJzOXhmc0JScmFrb21G?=
 =?utf-8?B?bVVQQUJmdDBoVE1aK3FhUDB2czVCRWo0WFAyM3ZTeFZFbnhzeG1pd3dHWGY1?=
 =?utf-8?B?anV3WWQ4U21OSEFRS3YwcCtBOVQ4RnZDUU5QcmRpREpqTW5qcVd1WGp2NmlN?=
 =?utf-8?B?WjdtSXN3dWhyRzBpekNoa2I3djlFT0hWSGdJcEQ2NzkxbDRESzE5TXlVM29B?=
 =?utf-8?B?Wmh0cWNITmo5R1cxRjQrcTloUDd0THpoOFhpemIxajhlSHhXWTMrcnZKR3k1?=
 =?utf-8?B?Zk9CQ0NBaXBXN0RldXRQdUlkT3dqTGplWG9UOEtna3J6TmhHTTZCM1ZHdTkz?=
 =?utf-8?B?NFZOWE5WT2gxbU8wUkt4RlhUSlYxREVJSUtWSmM4QnF3VXdhdWRESEJCN2xo?=
 =?utf-8?B?TlI0ZXp1S2YzOUZ4OHQyNHpUVHZyN0dXOE5pK3VvaFkybTVyVk9qM0NIR1Zo?=
 =?utf-8?B?b2ZwOE4wdGc2YjRrNzE3WHFZYVpyWjJsMXF2dTZoSVFtUDZrc3pFb3hReWVY?=
 =?utf-8?B?dGptNzVqTHJrQ0hadm92KytwRTRnS0dWLzI2TVVEYWFFUmw2TXJ4T01rQVRn?=
 =?utf-8?B?aitxRllKOTVPVFR1dFNDaEVKUWw4M1M1aWIwV1NZM2NnalB2aDJaTHkrb2VM?=
 =?utf-8?B?V0d2ZGg3Q1lSaEd5Wk4wb241TXhYNW9GbTBvVTBobDEvV1pFa3p3UmI0VnZv?=
 =?utf-8?B?MEFVWk5xUEJlMG1WUFJ4azFPZVJxU0RrSUttYWJyTkFYSitJNHpqK2ZKcDFE?=
 =?utf-8?B?QmhaMGYvT1lhdlFQYmdMakxubjRKNEFuN3JHUHNZNlF3d3J0TGt3aFZ4QTVW?=
 =?utf-8?B?M1ZBL0UrRG4vUW5JckxGU2VIbXQ3QXkvbjgwa0ZPNVA3SDJDY1Izb1Mxb2ZQ?=
 =?utf-8?B?b0V1ekRtZGNiZzhMS1VPbWdzZHAxL3NIVEloWjVWUE0rakY4OGZQTG5vWFJC?=
 =?utf-8?B?YlFudXIvbUkycVp1Uy9IWlVENVU5R3BiS1hZTFBFZ2s5SVFRdm9NVjl1dy9C?=
 =?utf-8?B?d3JiOUdMQTF1RGlmc0R2VWNmbFY4WTB4ZFhnZDRiOUVWeitpTTJmTk5Zd1Js?=
 =?utf-8?B?NnBqdmdvYkY1dVcvTENxWm4zZHk2em52bE9kTUEySTZGZlBGNGcwaXo4Zk9D?=
 =?utf-8?B?cGhVZ3FnZ0V5VE1hY3JFaUpmeUNramFoM2ZNY241UE4xdmxYbEQ3R0s0SEtN?=
 =?utf-8?B?NEx3RlF1VWF1V2F6T1VLa0RqNC9BZ0h5OEU4VnhscDkveXJ5eE1zUVp0dXpu?=
 =?utf-8?B?SmNvUmFPN00yODRjMmhHZlVjZjNSZ2k0TmxhMWFNMWovU3d0eVFEWTVqdmNt?=
 =?utf-8?B?VE9TT2VpYndQM3VrV1N3L1NSMHNtcllTRlMzdk5BQzZOMEszc0hLU1RLSzM3?=
 =?utf-8?B?NndFWHY0RVVBYjkwb2RldTByVWpBNkpMcjRQYU0ydFFFWXFKcEsrZlJDM1hV?=
 =?utf-8?B?TXNEWE1QWFN0SGJNRk9ZL3JUMU40bjdGREJQU2dCUkluT3M5a2RRZ0gzNlNW?=
 =?utf-8?B?UnRlTXBMcmN0dUJFTlhETCs1aGNmVXRhNlpNOEVOUlE2RmFIQXljWTIyNDlX?=
 =?utf-8?B?cjVqVjlEN3NUZDBiR2JOMkFibFlzZ2d6ay84OWFKVjJkdm9wRTNoRlNnVnJx?=
 =?utf-8?B?WXNlOW9OK0VobG9MS3FKdHhxdkQ4RksxSEdNVG5ORWJCTG9veU15NTNlQXQy?=
 =?utf-8?B?Y2tYZVdiQUp0dzZrelZFY2hpMk1FN0loZjVZY2Y3TUM3UDcwS0xTTVlmVW12?=
 =?utf-8?B?SHdDSmlGOFNjeHlMK0hEbGpyVlUzOVJOODFWbzh5Wk5vOTFKdXE3WGM4WnBX?=
 =?utf-8?B?S2ZOT1dhdzVRaXBYZHNmNXZwdW9tL1NZU1hjQW1tajBtNjN5UkpoeldjaGow?=
 =?utf-8?B?UFFIekJUcUgxc2ZoTVYxWnJiRTY4WHR4VTgzSStyZ1JsL2dGeDlMUUw3K0Ri?=
 =?utf-8?Q?Y0o1qxtVxDKvzqH/xC9XmXF7PdvcGkEt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C25E9D4E37430D4AA81D5FA06AF78F20@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95107e46-f584-4a46-8f4c-08d994950a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:16:48.7086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3831
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTEwLTIxIGF0IDE2OjQzICswODAwLCBDYWkgSHVvcWluZyB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBjYWlodW9xaW5nQGJhaWR1LmNvbS4gTGVh
cm4gd2h5IHRoaXMNCj4gaXMgaW1wb3J0YW50IGF0IGh0dHA6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uLl0NCj4gDQo+IFJlcGFsY2Uga3RocmVhZF9jcmVhdGUvd2FrZV91
cF9wcm9jZXNzKCkgd2l0aCBrdGhyZWFkX3J1bigpDQo+IHRvIHNpbXBsaWZ5IHRoZSBjb2RlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2FpIEh1b3FpbmcgPGNhaWh1b3FpbmdAYmFpZHUuY29tPg0K
PiAtLS0NCj4gwqBmcy9sb2NrZC9zdmMuYyB8IDMgKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2xvY2tk
L3N2Yy5jIGIvZnMvbG9ja2Qvc3ZjLmMNCj4gaW5kZXggYjIyMGUxYjkxNzI2Li45MzRkYzEzYTcw
MTEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2xvY2tkL3N2Yy5jDQo+ICsrKyBiL2ZzL2xvY2tkL3N2Yy5j
DQo+IEBAIC0zOTcsNyArMzk3LDcgQEAgc3RhdGljIGludCBsb2NrZF9zdGFydF9zdmMoc3RydWN0
IHN2Y19zZXJ2ICpzZXJ2KQ0KPiDCoMKgwqDCoMKgwqDCoCBzdmNfc29ja191cGRhdGVfYnVmcyhz
ZXJ2KTsNCj4gwqDCoMKgwqDCoMKgwqAgc2Vydi0+c3ZfbWF4Y29ubiA9IG5sbV9tYXhfY29ubmVj
dGlvbnM7DQo+IA0KPiAtwqDCoMKgwqDCoMKgIG5sbXN2Y190YXNrID0ga3RocmVhZF9jcmVhdGUo
bG9ja2QsIG5sbXN2Y19ycXN0LCAiJXMiLCBzZXJ2LQ0KPiA+c3ZfbmFtZSk7DQo+ICvCoMKgwqDC
oMKgwqAgbmxtc3ZjX3Rhc2sgPSBrdGhyZWFkX3J1bihsb2NrZCwgbmxtc3ZjX3Jxc3QsICIlcyIs
IHNlcnYtDQo+ID5zdl9uYW1lKTsNCj4gwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihubG1zdmNf
dGFzaykpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yID0gUFRSX0VS
UihubG1zdmNfdGFzayk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludGso
S0VSTl9XQVJOSU5HDQo+IEBAIC00MDUsNyArNDA1LDYgQEAgc3RhdGljIGludCBsb2NrZF9zdGFy
dF9zdmMoc3RydWN0IHN2Y19zZXJ2ICpzZXJ2KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXRfdGFzazsNCj4gwqDCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoMKgwqDC
oCBubG1zdmNfcnFzdC0+cnFfdGFzayA9IG5sbXN2Y190YXNrOw0KPiAtwqDCoMKgwqDCoMKgIHdh
a2VfdXBfcHJvY2VzcyhubG1zdmNfdGFzayk7DQoNCk5vLiBUaGF0IHdvdWxkIG1lYW4gbmxtc3Zj
X3Jxc3QtPnJxX3Rhc2sgd291bGQgYmUgdW5pbml0aWFsaXNlZCB3aGVuDQp0aGUgdGhyZWFkIHN0
YXJ0cy4gUGxlYXNlIHRyeSB0byB1bmRlcnN0YW5kIHRoZSBjb2RlIGJlZm9yZSBwcm9wb3NpbmcN
CmNoYW5nZXMuDQoNCj4gDQo+IMKgwqDCoMKgwqDCoMKgIGRwcmludGsoImxvY2tkX3VwOiBzZXJ2
aWNlIHN0YXJ0ZWRcbiIpOw0KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gLS0NCj4gMi4y
NS4xDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
