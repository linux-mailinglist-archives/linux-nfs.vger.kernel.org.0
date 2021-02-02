Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41930CEB3
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 23:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhBBWVE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 17:21:04 -0500
Received: from mail-dm6nam10on2101.outbound.protection.outlook.com ([40.107.93.101]:46784
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234084AbhBBWSp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Feb 2021 17:18:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI/pag8ALIIqeDlWWzxsw3Gip1MiRJEcO+AUJfVHWIq9fd0mQyNzFMz6ReLES6hUWYGbQsLkjbbB/+L+NrjXVDktEpFVR9oLfSSxuQ42+6Eh2jROkhHCUQwCdOInm8UnFW6iSGqEQ2fh1yclSeUeW/t9yTjG22COISgT3YCBlAlul7mbrVBrwmhk++tpl+nH4YN586iBcc+MODNig83mJFzCCLbm9YH93OX7cmRmDJN2VIRs1WMNRKnWEezEC9uxtRghoQs6fitW+k9hnntyVJzxYRzjmnS9uAubdCbWd29Jg15+gs9lVsIjf5zjWdQimGlLZOFh5VUuW3lTL1KXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If0Adnie16QPiCUqzukUxIOccNdsmsFUO1lAqfcD2Z8=;
 b=kDRlMdA2IhDPLX7PeCtea6CWZcjBwv8uO5Xk3+Kio3PDV5ZDEpeTm5mC1U8/SRusTUn5jsl1aQIqJz6c7L0Noe6Uw/vwOhzs9xSF+RN813/uThJ5FF4dSiHJF57EM4FHoGlzQrprLT1EK6rVDXwqUebkwIYqogzGuLPqOUftk9PDoVSqlRDQgDNQh8kbhwfN+mRteWLSFUcnOXr4aH01XOG+eSDj1w3Zlwano6ay5YxVTfWTfoIqij1OZ7Ji8nxGXFP3rKDFnhDvr4q0j+SdgihfbefNA4WM/D1pv/63r7lYjnLb15Tky7kFaI1SR3dWyT/A+rKv7JYE3qag3khjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If0Adnie16QPiCUqzukUxIOccNdsmsFUO1lAqfcD2Z8=;
 b=dXTI0Jto24kz8U3DOGApWphg+bi/oDlQRWiQHTx5ms0Ck8UWqPa1Dy/tIELpDtCpUHxNuB2EFng7RqPpLrkK+PaVTTYpVGWwOTc5FqvWuZ8/Fo5iZvoR/Tea8dhIM359Byy9tvXYLAck8+hjxnnaSDzPEBEZOchgT4Z62TmbaNI=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB3718.namprd13.prod.outlook.com (2603:10b6:610:9e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19; Tue, 2 Feb 2021 22:17:52 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3825.019; Tue, 2 Feb 2021
 22:17:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan@kernelim.com" <dan@kernelim.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Topic: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Index: AQHW+ZOgOm5dsTpDO0+RCMzuTmcxr6pFNttlgAAH/ICAAAcVAIAAKWWA
Date:   Tue, 2 Feb 2021 22:17:51 +0000
Message-ID: <7dfd7e3b9fb39da71f1654347ca2f2feba4fc04d.camel@hammerspace.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
         <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
         <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
         <20210202192417.ug32gmuc2uciik54@gmail.com>
         <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
In-Reply-To: <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bea5661-3974-4fc8-b117-08d8c7c861b8
x-ms-traffictypediagnostic: CH2PR13MB3718:
x-microsoft-antispam-prvs: <CH2PR13MB371819AB8311C16A3CAB27AAB8B59@CH2PR13MB3718.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2rFFtFDfzMwmYD+shmNmxfoAsdRThGjJq67RzbTLtJZk+44e3dzW2laStWJEhIBgCMBZeuUcFLmD6RaMmIit+hl0x0LiIYSWoarzcCOplfTZuWxMrY+QrtHb0UFNQfpWTcfxa321Gy/SRRSdlbT3e4WySxxf1vhZ94EmZYhdG+AgV1PAih1lMqkH49V4vUJLBesQ6Yew4WMnRoKueG9beJDQgHlTyuX3/PudG0kPtiBLplDj3afqCCN5mjsiPOiUnmJo7t19HYpl1zUTEkeypPY8OcIRxXNX6oShitBPsumPiL8277oHDp7J22Vtj3tEHl1hizv7P30XxTMrkjTYa73Kwe1LucQpGVt0cNZWjhd5usetplev5UsdfiRQyg0l8k4SjkLyuqUZYISZjyQPf50gRyEaMk3mp2IMBdAioDEfl1OB8XX0ghG8vnaQjdB4u3LPJY3Vm1pwyUxddDn4NdEaIRD0jKV+vIS8Sap6uBOQmBYryHrCXAc20nXCi+q6YHY2kooe6uIOcI6Ccz2Jjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39840400004)(346002)(376002)(366004)(316002)(86362001)(76116006)(4326008)(6486002)(110136005)(66946007)(66476007)(66446008)(66556008)(64756008)(83380400001)(2906002)(8936002)(2616005)(54906003)(53546011)(36756003)(186003)(6506007)(71200400001)(478600001)(5660300002)(8676002)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K3hGWm1TcTkrK0xWL3oyZ1VpYjBnTHNaWGdoOEM3RzFYSEw3aGE2L083emM5?=
 =?utf-8?B?bFZCQXlBUDRtV2Vsd01YakNuSUtlWXo4aUJJd2pyWUxlb0RXb1Q1QnlGQWpp?=
 =?utf-8?B?RTQ3ZHgydEVEMDFERmRqeHo0cmk1M2l2clZKREMvMTJFSm5oNnR3bDk4QkpB?=
 =?utf-8?B?cXhzQUN2b0g2VE5wMFRoNWU2b2xsSDcyV2pCdUtJczR1LzZhc3phZEFvM1pK?=
 =?utf-8?B?TTE3QWZZRitncXE2RmJJcU1YRzNsN0Y5TVNEWEcrZXFNN1FxalkvVEh5Rm1J?=
 =?utf-8?B?ZGJ6OTM3dU1CWnRqbFdtWWdhWld2ODFVeTVPQnMvanFzU0hYdGJoU3JjU2dr?=
 =?utf-8?B?dFRWbDBhR0xOWEljWlNvVk82Ry90YXV5VXFJVU5ETFV6L3YwdkVTK2tFU2JL?=
 =?utf-8?B?ckNOTWpEVHQ4ZlUxMVpXam9lWmE0ZmxkNWhVM21QN0VKb21TUXZPaVVSVnI2?=
 =?utf-8?B?SGJBZnhkZU1OYWpKVE1KUkI3eXpEYU5MbjdYZy9Sa2tDWnVyOHNJZm0vMzNZ?=
 =?utf-8?B?THJ1OWRKaE1aRTI2aVplbTU3ZkI2T3JYQWp4Y2Z0MEptbDdSdEdqeTFrKzBL?=
 =?utf-8?B?eTFXV2FDU3FQcEFpN3ltOG9qS3k3UDhRSGcwRUw3NFU0Sy9BeG1XeTFpZGdn?=
 =?utf-8?B?ZHBERTByUDFscTdnNVZKZzMzVHhnRVY1WkN5Q2V5THlISHllMDZ3V1Q5WHor?=
 =?utf-8?B?WTQwVGxkZ3FjRWFuc0ZJK2NUdE84NS9OYWw4bWM5V3o5dTBUNEhONnpQZVo3?=
 =?utf-8?B?d20xVzB0YjNTYjRBQ1JvYWhvaWpTN2laa3l3aEhCc3NGTEJtR3YzaDF3TW5o?=
 =?utf-8?B?ejF6cjVEclczTlVjbkMwTnZqVk5MUkJtbzRLVDlkQUFLaU1NNzNsVFJWTUVG?=
 =?utf-8?B?TnprWGw5cnd4aGFKN2l6WUV2OEc2Y1ZjSGdwMVlPd1NsWnRUdkgrR3lRbDBF?=
 =?utf-8?B?MGNLbWwzZmZJZDh4bDZ1NktQcHpCRk5SL3lORWZqNk14dmFJYi9uV2l4OFhU?=
 =?utf-8?B?eGZLVEFWbGlIaVFvSkw5T3IrMzBtYW45aC9OOGZoQUNiZFRoSGJSenpzZ1cw?=
 =?utf-8?B?YngwUXdxWFR6SkhCWEN3UTVNU0dqS2ZXTFFGMEw2M1M0S1U5dnoyU0VKWXl2?=
 =?utf-8?B?TWhGaHE4VTVEVEUrMGRpbXU3TFhDL1prUzVPcm5EWXIzZkxwWFVUNEhDZFhP?=
 =?utf-8?B?YWxkMHlKSHZ6YUZVQnphRVlVTVF0YmdsVlZsRTQ5b25TQ0VmWmROb1dmZ2g2?=
 =?utf-8?B?cFdZdGg4eVhtV0krUnZTZkRTUXA3T3NaVlZudGhXWC9la2N2OVNWbUlVdldU?=
 =?utf-8?B?TVJydkViRkdsUFlxTnhoYzFwVFlDKzRZN0JvWTVZQU9PVGpXM1FVY2pFZEtm?=
 =?utf-8?B?RXlTMml0SDNIeGg4cFkxNmdLNDBlVHBXMzAxWGg5TytkeFVldDFWYnpNSVJO?=
 =?utf-8?B?VzlQTm44U1o4VGpVb3BUQkUyZE1MMGN5YTRIZVFnPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFB26191A31C254AB69F20BA2ABCE335@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea5661-3974-4fc8-b117-08d8c7c861b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 22:17:51.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fznc/wmca2c5uCjQ0PG058IU6/shHbjKvsyZRK3dyatjbmVP8/GE71gbV0t6EIUlLpi0vwUTdHw3jEGm+TLH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3718
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTAyIGF0IDE0OjQ5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyIEZlYiAyMDIxLCBhdCAxNDoyNCwgRGFuIEFsb25pIHdyb3RlOg0KPiANCj4g
PiBPbiBUdWUsIEZlYiAwMiwgMjAyMSBhdCAwMTo1MjoxMFBNIC0wNTAwLCBBbm5hIFNjaHVtYWtl
ciB3cm90ZToNCj4gPiA+IFlvdSdyZSB3ZWxjb21lISBJJ2xsIHRyeSB0byByZW1lbWJlciB0byBD
QyBoaW0gb24gZnV0dXJlIHZlcnNpb25zDQo+ID4gPiBPbiBUdWUsIEZlYiAyLCAyMDIxIGF0IDE6
NTEgUE0gQ2h1Y2sgTGV2ZXINCj4gPiA+IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4gPiA+ID4gDQo+ID4gPiA+IEkgd2FudCB0byBlbnN1cmUgRGFuIGlzIGF3YXJlIG9mIHRoaXMg
d29yay4gVGhhbmtzIGZvciBwb3N0aW5nLA0KPiA+ID4gPiBBbm5hIQ0KPiA+IA0KPiA+IFRoYW5r
cyBBbm5hIGFuZCBDaHVjay4gSSdtIGFjY2Vzc2luZyBhbmQgbW9uaXRvcmluZyB0aGUgbWFpbGlu
Zw0KPiA+IGxpc3QgdmlhDQo+ID4gTk5UUCBhbmQgSSdtIGFsc28gb24gI2xpbnV4LW5mcyBmb3Ig
Y2hhdHRpbmcgKGRhLXgpLg0KPiA+IA0KPiA+IEkgc2VlIHNyY2FkZHIgd2FzIGFscmVhZHkgZGlz
Y3Vzc2VkLCBzbyB0aGUgcGF0Y2hlcyBJJ20gcGxhbm5pbmcgdG8NCj4gPiBzZW5kDQo+ID4gbmV4
dCB3aWxsIGJlIGJhc2VkIG9uIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiB5b3VyIHBhdGNoc2V0IGFu
ZA0KPiA+IGNvbmNlcm4NCj4gPiBtdWx0aXBhdGguDQo+ID4gDQo+ID4gV2hhdCBJJ20gZ29pbmcg
Zm9yIGlzIHRoZSBmb2xsb3dpbmc6DQo+ID4gDQo+ID4gLSBFeHBvc2UgdHJhbnNwb3J0cyB0aGF0
IGFyZSByZWFjaGFibGUgZnJvbSB4cHJ0bXVsdGlwYXRoLiBFYWNoIGluDQo+ID4gaXRzDQo+ID4g
wqAgb3duIHN1Yi1kaXJlY3RvcnksIHdpdGggYW4gaW50ZXJmYWNlIGFuZCBzdGF0dXMgcmVwcmVz
ZW50YXRpb24NCj4gPiBzaW1pbGFyDQo+ID4gwqAgdG8gdGhlIHRvcCBkaXJlY3RvcnkuDQo+ID4g
LSBBIHdheSB0byBhZGQvcmVtb3ZlIHRyYW5zcG9ydHMuDQo+ID4gLSBJbnNwaXJhdGlvbiBmb3Ig
Y29kaW5nIHRoaXMgaXMgdmFyaW91cyBvdGhlciB0aGluZ3MgaW4gdGhlIGtlcm5lbA0KPiA+IHRo
YXQNCj4gPiDCoCB1c2UgY29uZmlnZnMsIHBlcmhhcHMgaXQgY2FuIGJlIHVzZWQgaGVyZSB0b28u
DQo+ID4gDQo+ID4gQWxzbywgd2hhdCBkbyB5b3UgdGhpbmsgd291bGQgYmUgYSBzdHJhaWdodGZv
cndhcmQgd2F5IGZvciBhDQo+ID4gdXNlcnNwYWNlDQo+ID4gcHJvZ3JhbSB0byBmaW5kIHdoYXQg
c3VucnBjIGNsaWVudCBpZCBzZXJ2ZXMgYSBtb3VudHBvaW50PyBJZiB3ZQ0KPiA+IGFkZCBhbg0K
PiA+IGlvY3RsIGZvciB0aGUgbW91bnRkaXIgQUZBSUsgaXQgd291bGQgYmUgdGhlIGZpcnN0IG9u
ZSB0aGF0IHRoZSBORlMNCj4gPiBjbGllbnQgc3VwcG9ydHMsIHNvIEkgd29uZGVyIGlmIHRoZXJl
J3MgYSBiZXR0ZXIgaW50ZXJmYWNlIHRoYXQgY2FuDQo+ID4gd29yaw0KPiA+IGZvciB0aGF0Lg0K
PiANCj4gSSdtIGEgZmFuIG9mIGFkZGluZyBhbiBpb2N0bCBpbnRlcmZhY2UgZm9yIHVzZXJzcGFj
ZSwgYnV0IEkgdGhpbmsNCj4gd2UnZA0KPiBiZXR0ZXIgYXZvaWQgdXNpbmcgTkZTIGl0c2VsZiBi
ZWNhdXNlIGl0IHdvdWxkIGJlIG5pY2UgdG8gc29tZWRheQ0KPiBpbXBsZW1lbnQNCj4gYW4gTkZT
ICJzaHV0ZG93biIgZm9yIG5vbi1yZXNwb25zaXZlIHNlcnZlcnMsIGJ1dCBzZW5kaW5nIGFueSBp
b2N0bA0KPiB0byB0aGUNCj4gbW91bnRwb2ludCBjb3VsZCByZXZhbGlkYXRlIGl0LCBhbmQgd2Un
ZCBoYW5nIG9uIHRoZSBHRVRBVFRSLg0KPiANCj4gTWF5YmUgd2UgY2FuIGZpZ3VyZSBvdXQgYSB3
YXkgdG8gZXhwb3NlIHRoZSBzdXBlcmJsb2NrIHZpYSBzeXNmcyBmb3INCj4gZWFjaA0KPiBtb3Vu
dC4NCg0KUmlnaHQuIFRoZXJlIGlzIHBvdGVudGlhbCBmdW5jdGlvbmFsaXR5IGhlcmUgdGhhdCB3
ZSBkbyBub3QgbmVlZCBvcg0KZXZlbiB3YW50IHRvIGV4cG9zZSB2aWEgdGhlIG1vdW50IGludGVy
ZmFjZS4gQmVpbmcgYWJsZSB0byBjYW5jZWwgYWxsDQp0aGUgaHVuZyBSUEMgY2FsbHMgaW4gYW4g
UlBDIHF1ZXVlLCBmb3IgaW5zdGFuY2UsIGlzIG5vdCBzb21ldGhpbmcgeW91DQp3YW50IHRvIGRv
IHRocm91Z2ggZnNvcGVuKCkgYW5kIGZyaWVuZHMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
