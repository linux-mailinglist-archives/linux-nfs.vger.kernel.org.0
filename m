Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CED471E1E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Dec 2021 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhLLVxk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Dec 2021 16:53:40 -0500
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com ([104.47.55.109]:6094
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229662AbhLLVxk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 12 Dec 2021 16:53:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxBtW/EM7eWCd/VfFHY99K4Nc5JBxC3U+fLYvIp7tgm7clU2GIMYDFvA63WarNduU4oJbyXGtufQXtBUlr8Qndy24ulYU7N6v+/ZqoANP2HdDyTUQRxpHQuXo7n/NISo6Nmc3PwwbYc5MHJBsM4WjSjMVm5hczCPuLf2hoCMXE+bDuxaSir6Y1YevdLJwTVcd20vVbKEBQU4h00ySkDc5THlNEfDhvZgR/DsvKHzIn8m8Ryg02DxxBxv+B0k5gwaMkiWAI3sqPrcuYTb9QXqXNZgbMeROUNIqZiMS3ye1iLdJl4wt3YzRcuQ3CqRvhCLCQd4vDxA6Fxc5rw0LCu48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY2wJWa2BILMJYOykLrfFo4DVmMV7NrDC0ngKUxdLio=;
 b=dYwMHuh2JUE1heOT2byCXrirMwf1CviEldddIC3te5Jf9Nn6TxviqHeJUWcvfHVbWwn5sbt482Qqik2swAr+V3aiRHLl0KPprjjrCI6VCxYgN+N5UGdrs+tBkj/EQFA5ehqydkDNOitOJ1kjkFQMfLL0cbvk3RRjGy37nnTZjHcqFnwLYghxrxDvHBy8zRi1aLCx6dF2ABhY52KpUzGM/7dINLM6/NcC8oGRiwRFQZFe/vf/MD4xai/pSPB66CkpGz53Me1/5khJHxouGgUA9yJmgetY+19IEuSoGV2KTupm8T/oJ9lwF7iGUCYD+cqOWxG3X9K7ie9FTOPV5BXyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY2wJWa2BILMJYOykLrfFo4DVmMV7NrDC0ngKUxdLio=;
 b=gSju9VJPUbe7iqwgLNs+ekZ9tCtCpJ050V6Y4+fw57ZakQJXBzMwxghQ5HyTKxPbmWDT/9x+M/yPzM0qm2GTdRERj68Yf7ZmyrPY3QtXu/vh+ZuefW4ET3v2oYQhtbR/ZzAM/PNGywsc+CoTPIcXD85dJI6FlOM7qBkFDquvFPI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3784.namprd13.prod.outlook.com (2603:10b6:610:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.12; Sun, 12 Dec
 2021 21:53:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4801.013; Sun, 12 Dec 2021
 21:53:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "richard@nod.at" <richard@nod.at>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "david@sigma-star.at" <david@sigma-star.at>
Subject: Re: [RFC PATCH] NFS: Save 4 bytes when re-exporting
Thread-Topic: [RFC PATCH] NFS: Save 4 bytes when re-exporting
Thread-Index: AQHX75ta92YY4WU8k06yTBIDlSm7OawvXNEA1wwF3iuo9AOGgA==
Date:   Sun, 12 Dec 2021 21:53:36 +0000
Message-ID: <7a8d59679ed2ab948b8b694eb1df94e3a90fcc8a.camel@hammerspace.com>
References: <20211212210044.16238-1-richard@nod.at>
         <dd3aec8fed9bab9b3e62fc2093803688b7b71682.camel@hammerspace.com>
         <1812588409.160456.1639344774221.JavaMail.zimbra@nod.at>
In-Reply-To: <1812588409.160456.1639344774221.JavaMail.zimbra@nod.at>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ae60a3c-87e9-42b7-36d4-08d9bdb9d999
x-ms-traffictypediagnostic: CH2PR13MB3784:EE_
x-microsoft-antispam-prvs: <CH2PR13MB3784D1085DE68A7485636B0AB8739@CH2PR13MB3784.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRxnO1DD6a3K6fmq/0EVLvoTC3I9gK2wQyec366PPwBd/I4da5G/FnVQLuRObEWaCDpq+WY34xNb0U2zV+6x0Jdf96ilJoVuSHbkJjqYy487wf/KBwKSvsibMSHZz4HHgZs49inY2HgugolR+24NRm8asPg6Oib4eAFT0B+oBt+rq3RX+9iB6R4oaM2q2o8w1EESA2BPLTWQcMq9dA4lwSnCYQtsFwYs4F33Auc90rvzqREPsBrzNGTex/0rX45+3fJLPwdDqqM8wrOyAFyxuZ8pJJ/B0b63YC6aVN9bobNFg243Gp25zugZShIlLk2HAWOEiw5p25uVFFlWwyJKTXdyq1Dgv871Zyo8TH9UwvFsS/TOXo7Dm3aON226wm/t7RQOwGyzVQJflteubZdcQbkgZfG3SDvZwq9ICNbDFXyezUZxCv+iET2//UagXWnhsn8B0DM56T7yHFzEJG3ruC1wErKwoq2yuCxLtA0NpwCx1bg9toypKUOwK8vsvLxPpXE+AW87QoKalTWDa2kj0Z5Hr9QL1qB43wTYWJ/+gTzu0w7L3Im0UsfOOFvmfAFp/j3yFRms/g/UQ2ZRJ6rzk3oPNyOmhuXGUdalREnVwKzTYKp2ICjaqKKPxGkM25N1YLOmUBjyh4mRlkyFowNkM9+Fyfo8m05vzbgU93kGEfop2/vmp8ZhEBER5AAC2zqRN0IzxMB6Ii8hm0M2xCBNmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(136003)(39830400003)(376002)(346002)(66556008)(66476007)(4326008)(64756008)(38100700002)(66446008)(86362001)(2616005)(8936002)(8676002)(122000001)(76116006)(508600001)(316002)(26005)(71200400001)(186003)(54906003)(66946007)(6916009)(6512007)(38070700005)(6486002)(6506007)(66574015)(4001150100001)(36756003)(2906002)(5660300002)(83380400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXBjMEV3NldDeE1iYTZrSFBwMEc3MThUUlZGeXJZWWEyZStEb0ZscERmS29Y?=
 =?utf-8?B?R2pVd0hVdzBxdWloZkkwVlhET1MvRHlNU09VWjd6eitLNlNobGtsMGdkYmNa?=
 =?utf-8?B?SmVEWU14VmRnQTNteXdTZDNOd1dxaEFyQXpleTRNZ1NjMzlVblcyQnNxR29r?=
 =?utf-8?B?TXROZlQyUXM3OFhKN1ZsRE52WUtwY08wbkVkeWVXUVlodUZBYURiNGozNHhP?=
 =?utf-8?B?TTdjRHVhUDRmSkNybEs1T2diYUszMGpzSGM0bWZocUw4ekRJVGJOTlFmU0hS?=
 =?utf-8?B?d3pHUzNhZnY3aEprV3Jjb2Q3WDZxUkR0YXIwVXdrTjBIMnVreWNFZ2w1dFIx?=
 =?utf-8?B?TVhGbDRLWXNpa3RQYzRPNmVoVlh2L3JRVjB1ZVlJYUpMZCtKME83WDlVb0ZW?=
 =?utf-8?B?THMvYnA1ZklPdUliL0dZWmRkcU5xcXZSdjIrWSt0emFvcklVMWFpZzE4dmMw?=
 =?utf-8?B?M1JOZHRyOFo5b01xZ202UHMwSmU2ZkN0dElJa0hhOWV3T3ZrTHhCdHR2c1dU?=
 =?utf-8?B?K1dHQXNCVWtISGpkMi90M0FqaEsybi9qeTRmVmZCb2pRY3NuTWI0TmIwWGVO?=
 =?utf-8?B?ZmQ3QjZSRmtIZXloRVNtQkNJNFN3bVg0YUN5d01hdFpmQWVqN3U3WGEweUda?=
 =?utf-8?B?SWpoaDJ4eDVrSzE1dlJ1VndiaE5OSGhwTVNxd1NHNHlHdG1uQS9aNi9hUUpY?=
 =?utf-8?B?dnQ4RUNTN1gwY0VjTXFmcE5CZThZZ0RWVVVlYzhraytFMzZKOTBpN3JMSk1p?=
 =?utf-8?B?ejhNekpPYSswQ1B5WmhUVjQ0TlM3WUFlWVZEOUN3VEhDUi9qeVQwcnJiTlNv?=
 =?utf-8?B?dVpDSGhZWUQ1MmpqeEhwaHU3RHhNMDhFV3hkcVpLejNEaFEvUk1qUk1JY3FC?=
 =?utf-8?B?VEZjV21TOXExUjIvQXZzM0pVSzdFU2dMcWtudzM2ZlhGK21wcHdYWlh0N3g3?=
 =?utf-8?B?RDdjZUZhT3hOeWFYWFhCbGFKd2NTWS9qZkdRNjgxc0dOUmJGMnBaYjgzOWlC?=
 =?utf-8?B?R1lmSE5ZU1dZd2JadCtTR0lYWXJGVER6cE9adHVVWGZHMExqb2IvT1hMMHhi?=
 =?utf-8?B?WjVncGdXQTBMYktTamU3RHFSRmMrMDZ3Q05TbTkwazNkMnNJZG83R0E3SzMy?=
 =?utf-8?B?bW8rWmUzemc2Y1RybEhlMkRLYWZob3FVWUlLYzd1L0tMNThTakdhU1FRcS9F?=
 =?utf-8?B?Tk9uSkFnR2phUXRnZmlMRk9ycU5CcEZUa3BlRkhMVEVybmtHemlrTHVHeDNh?=
 =?utf-8?B?WHNKZDlvaVNodDVTWC9scWwxMmxmNlhaZW5CS01wK3hnNTNiM092NFZzWm13?=
 =?utf-8?B?Vkk3QXhZZ1QxV09KelM1L0dvanNYMHFqZDg0bG9xTUo1SEQrd0ZwWTRiY3Nz?=
 =?utf-8?B?VG13Ry82WmZIbk5qS2xEVWlySStvN0R2aUtJLzV4MFZFbWFab1FIek1LU3ZZ?=
 =?utf-8?B?OGFEWjlTYmdqN2ZEM0NvK2hVVXZXK0JIZGhCQWVhaFEwWWpmQUpyaDlSUUMy?=
 =?utf-8?B?UW1NbU9wVm56TXg2d2o3dmlSbHhoN3kyU0IyTWxkM3Zwb2tHTHZFTzlZSkdk?=
 =?utf-8?B?eFFHanQ4R2tIdlBXVXk1TmlleFJuYm8vWVlMYUwvVjFTVml6V1RrejgxM2RZ?=
 =?utf-8?B?bDg5WnlTYThTdWhjRjlMTkp1Q3VJVmJOUUQ5VWt1WDJEbmxFSTZCTWZqa3ox?=
 =?utf-8?B?eWs5ZTlFTUV2cER1K2xSQ2ZnSyt4MU9kQm15VGdMbWF1N2VVdDlabEk3YlVH?=
 =?utf-8?B?WWhyKzljMnZRT3lsOHRNNG13NkVpUWZScHZvL3laMmRaU21QeG1pZHVsZ1pv?=
 =?utf-8?B?QkVnMUh6WUh0TE5sWWRNWXRUYllQT0Z5L0l0Vi9YR2orYzNIYmlOWGR3SXQ1?=
 =?utf-8?B?cjk3K3pJTnAvOEhlVEthcTRGVzRIS0p4dnlvb2pjcTd2a3JkT3JNV2xvaDZi?=
 =?utf-8?B?b0VGa3RXYWduZVh2cFFaUlZ2bkpzOGpORkt6dlR4czZrK2NKVVZHdm85VFZF?=
 =?utf-8?B?YU0zRFEwbFdlZklCMjRPcmo1TkxKL1NoVHp3bUNJc2Q4Wm5WaWlONmJ3YndS?=
 =?utf-8?B?bE1xYjIyaWR3S29ReXMrdmNseXhVTXZpVFBJL1ZOQlpWQVl4dG15N2hNU0ZM?=
 =?utf-8?B?RlR2Z1ZHNVVPaVRhRSs5ZGJGTkU1dlFhaFU2M2o0aXBFcmNqYlBXcElGWUtM?=
 =?utf-8?Q?NjIvvczywyqf8A8RBsEC4SE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB4E8222AAAABE478B0AFAD6B423C686@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae60a3c-87e9-42b7-36d4-08d9bdb9d999
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2021 21:53:36.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJNv6/NbB6yLHeTCzfyvM+3KI89gPqOF+dwbi1jq7YDsRbV7UkRllBv6LqF6sBopJfPp/Q++8vmoMCFUlazZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3784
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTEyLTEyIGF0IDIyOjMyICswMTAwLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3Jv
dGU6DQo+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0NCj4gPiBWb246ICJUcm9uZCBN
eWtsZWJ1c3QiIDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiBPbiBTdW4sIDIwMjEtMTIt
MTIgYXQgMjI6MDAgKzAxMDAsIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToNCj4gPiA+IFdoZW4g
cmUtZXhwb3J0aW5nLCB0aGUgd2hvbGUgc3RydWN0IG5mc19maCBpcyBlbWJlZGRlZCBpbiB0aGUg
bmV3DQo+ID4gPiBmaGFuZGxlLg0KPiA+ID4gQnV0IHdlIG5lZWQgb25seSBuZnNfZmgtPmRhdGFb
XSwgbmZzX2ZoLT5zaXplIGlzIG5vdCBuZWVkZWQuDQo+ID4gPiBTbyBza2lwIGZzX2ZoLT5zaXpl
IGFuZCBzYXZlIGEgZnVsbCB3b3JkICg0IGJ5dGVzKS4NCj4gPiA+IFRoZSBkb3duc2lkZSBpcyB0
aGUgZXh0cmEgbWVtY3B5KCkgaW4gbmZzX2ZoX3RvX2RlbnRyeSgpLg0KPiA+ID4gDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pg0KPiA+ID4g
LS0tDQo+ID4gPiBXaGlsZSBpbnZlc3RpZ2F0aW5nIGludG8gaW1wcm92aW5nIE5GUyByZS1leHBv
cnQgSSBub3RpY2VkIHRoYXQNCj4gPiA+IHdlIGNhbiBhbHJlYWR5IHNhdmUgNCBieXRlcyBvZiBv
dmVyaGVhZC4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBlbWJlZGQgdGhlIGZ1bGwg
c3RydWN0IG5mc19maCBhbmQNCj4gPiA+IGNhbiBza2lwIC0+c2l6ZS4NCj4gPiA+IA0KPiA+IA0K
PiA+IE5BQ0suIFRoaXMgd2lsbCBicmVhayBleGlzdGluZyBydW5uaW5nIGNsaWVudHMuIEFueSBj
b2RlIHRvIGNoYW5nZQ0KPiA+IHRoZQ0KPiA+IGZpbGVoYW5kbGUgZm9ybWF0IG11c3QgYmUgYWNj
b21wYW5pZWQgd2l0aCBjb2RlIHRvIGRldGVjdCBhbmQNCj4gPiBzZXJ2aWNlDQo+ID4gZmlsZWhh
bmRsZXMgdGhhdCBhcmUgcHJlc2VudGVkIGluIHRoZSBvbGQgZm9ybWF0Lg0KPiANCj4gT25lIHBv
c3NpYmxlIHdheSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIG9sZCBhbmQgbmV3IGZvcm1hdHMNCj4g
aXMgbG9va2luZyBhdCB0aGUgbGVuZ3RoIG9mIHRoZSBkYXRhLg0KPiAyICogWERSX1VOSVQgPSBu
ZXcgZm9ybWF0ICh3aXRob3V0IC0+c2l6ZSkuDQo+IDMgKiBYRFJfVU5JVCA9IG9sZCBmb3JtYXQu
DQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQoNCllvdSBkb24ndCBhIHByaW9yaSBrbm93
IHRoZSBsZW5ndGggb2YgdGhlIHVuZGVybHlpbmcgZmlsZWhhbmRsZSBvciBpdHMNCnN0cnVjdHVy
ZS4gQWxsIHlvdSBrbm93IGlzIHRoYXQgeW91IGhhdmUgbiBieXRlcyBvZiBkYXRhLCBhbmQgaXQg
aXMNCnBvc3NpYmxlIHRoYXQgdGhlIGZpcnN0IDIgYnl0ZXMgcmVwcmVzZW50IHRoZSBzaXplICdu
LTInLiBIb3dldmVyIGl0IGlzDQphbHNvIHBvc3NpYmxlIHRoYXQgdGhvc2UgMiBieXRlcyBhcmUg
c29tZXRoaW5nIGVsc2UgdGhhdCBqdXN0IGhhcHBlbnMNCnRvIG1hdGNoIHRoZSB2YWx1ZSAnbi0y
Jy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
