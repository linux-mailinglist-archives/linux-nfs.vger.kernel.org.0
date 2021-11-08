Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9E4478A3
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Nov 2021 03:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhKHCn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Nov 2021 21:43:57 -0500
Received: from mail-mw2nam08on2105.outbound.protection.outlook.com ([40.107.101.105]:26131
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229878AbhKHCn5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Nov 2021 21:43:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnOKLo4BGZJhMFhNSYCXFZt7D4AZMTSgcFHCdaDcm0x6MI+j1Sy96XJcKf0y3msvGk+GqYd9Mu8QDQRpz5YNvWWC5yuiFPY0TbamzC/PuLxcdpY3LqKfRK90hr/0V03NpIkasZoRVibPjg/eJ6RFOqqzKgJCh853exjMd5RmWGYCcgY2J0TMM3xEq9e0FqV4LLJzVtgLGAsaldDPMpPAcIAlylJd47WlZDj0F5ayZopOSidRznFwVMskv+ujuWSUyw4vSKTYKJl1jnIdxfIRpO+XzyWdNyFnhknKEVZxh6YAQhjNwOvYNQJ/sEjd3w6hdQ+hcGl8MwQ4NRJuJ1Mr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q7nxDYrp6m5yMslJweQ0LZP0PZt5VWI0Elt+EP58CY=;
 b=V8XkzGoOxGVOQuKFC16HDQev6RzEKBqX+YAIe41Ci0fBvS0kpToY/iMJpCl9EIocTqiV2sxM7xtSlIt2TFVKxtzUwjquZHLIsrmmtR2quLRABztIUT/I5r3LNrtZTL7Sw+5aixg1Xj9aInAXZ0qS6djVUJ3qyyMbILjfc1fCM2/fBIjeL9eTtNhAWR4IePSdAl0UgOFMDt2CQqZ4TN4X/gXf94n23SC36j585ju9kzxk8C/NuJs6BI8L3rSn69M0D9bhu+2RZNAQ1yXsi5EDhKyzXgQp/01cUjM7jUFo5apL1xUOEcPQIw2OEHBi47ZpsnU1EhN9vI3ObthYvdQaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q7nxDYrp6m5yMslJweQ0LZP0PZt5VWI0Elt+EP58CY=;
 b=YIZnJ6+ohzfj58TbMQg3xZLirWefiJ2dyYphqUt055zxoMHP1B1mhZIXp5jprrwHGYoaOV2bs/RkDoz8VPQwIYyCsOMN0pXWWw0loCsusaD4fA+zMCRDdKNjG5zG2RyNjEdtW0R12+F+x6T8prpUe7W1ywd7/xAKhKH7Q5vXzm8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3302.namprd13.prod.outlook.com (2603:10b6:610:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5; Mon, 8 Nov
 2021 02:41:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a921:472b:221c:11b8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a921:472b:221c:11b8%4]) with mapi id 15.20.4690.014; Mon, 8 Nov 2021
 02:41:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmacklem@uoguelph.ca" <rmacklem@uoguelph.ca>
Subject: Re: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Topic: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Index: AQHX02npTtMx6BHF6UKeTijQBaPp7Kv3MpsAgAG1HlyAAAWdAA==
Date:   Mon, 8 Nov 2021 02:41:10 +0000
Message-ID: <82059fc8fc33631bfba14fa2f5ec5db494667fc7.camel@hammerspace.com>
References: <YQXPR0101MB09684E992DCE638E82493DA9DD8F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
         <02a742e36c985769c95244c1340f5fc0601fd415.camel@hammerspace.com>
         <YQXPR0101MB096808F771834883F48894DEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB096808F771834883F48894DEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be8fd282-c173-484f-a9c9-08d9a2613918
x-ms-traffictypediagnostic: CH2PR13MB3302:
x-microsoft-antispam-prvs: <CH2PR13MB33024C02DE66A3039A2CB787B8919@CH2PR13MB3302.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIactPhvideyCuGLV9i5anO6qJCC7B6COynlBA5ZhRrJaN/oOzlFo418/Cpx5izfLfVk1ITizgyfu3FWQ1pC+jHrgsLt9th85pr8Xv3QCGPbNyPy1+4xtulArX++rnOrfIWtkA8ie853hcyMnWFqo2DzsB8jaezNQcrLgaYbViyeJ6DWzkpfCgWpWE7wM3d96F0wY+KIUeAB10tq2QwhRVyVHmdVERQWroW9RplJnJF6KDYimmjwIxlq7cjq9vrZjYZMyX3VAeMjoC+SR7iafFZAXlEM0DfeSh/H7YGrdeQTsi2cjgMmQjGHb11y6iAaBHhemrhCJZdpcT1LN2zCVsWlU+3TWa1+AYOaejF6Y38RRG5UTqK9FK1I/DVeuaEcUs00M+m4sO/uo+7L4rAWSEvf+3XHbgR6Z+aSaKLQAZTxv4uy8SWDM3AJpsh9HbWfgZ8T7S6lW1L02fbl3Jwhrforig8lPpys6Z/poBFgbzpohyMHZh3DXx7B0ikb9L+p7s1jb2k0tT6AJk+xT96c9gt7OiMfhSS3QTf5FNOIuGU7pfVj9GGmbDyw/zc5TJK4eHovYZ06HUxtfZY0t7uOrflLThD2rYMC3pZ4wvgymS7LaDCYEle75SUMaHZre0JUTEwILDTjLlRndOHfk/pKnRqTXiJTPmi5gWAq/UHBAZHy8JDMu7Zdlzd54im6iZiwx6Ip/Jake3KV7YAriEpXJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(38100700002)(316002)(76116006)(66446008)(83380400001)(66476007)(38070700005)(122000001)(66556008)(2906002)(6486002)(2616005)(5660300002)(186003)(64756008)(110136005)(86362001)(66946007)(6506007)(8676002)(8936002)(508600001)(26005)(6512007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0UrVG9mV3VjeVBNWVpGa2t1clJNa1FCTUZXcEpjUVIxQU5GcnFvTjY3THNa?=
 =?utf-8?B?enJucTNUWkwwaDh3aFlqNzV2M0tjMC9vSm1TS2xQZ1FUUFFnUUduRDJMQkJa?=
 =?utf-8?B?UTY3ZnZ4L3p1OVo2QjVSTjFTZHJ0c0hZbWk1TXRteHFaMjh4NkdETVFTWCs4?=
 =?utf-8?B?b3FHZFcwYnpmSVpDSndmcWRBaks5RTFNS0lIUlp2bmsreitPZWVTOUp0SHAy?=
 =?utf-8?B?SHAzcTU5ZDdQWWNiQjIvUVI3a0R6bzZ5VkhJRE9uZGxlK2pncGJ4VTkxUEtU?=
 =?utf-8?B?Q0t5eWVDa25TZU5OUDQ0OUJ0K1cvcGhOZ3N6K1QyU3hJVmVDZ2tHeWNMYmdp?=
 =?utf-8?B?S3d0Y3hMVDhyUkd3QmhRRXE2V1pIOW9CZU5PWXpIMTBlcDV0S2RFcXB3LzV5?=
 =?utf-8?B?RkhkRHh6SW93d3N0dXNrSFZvZmFRNlNvT0RvUmlWbUJ4TWliR0hXQzlHQ2th?=
 =?utf-8?B?blJkZzh0WWhaNEIxY1o3aG05YkRiTmZJQXZUb01LaVJKbXAwbEJsUnc1TWRJ?=
 =?utf-8?B?OGpsbmQ5NzQvckxxQ0tJTlBjR0wxSkxLN2EyU09MNGhpNXM0ZGwyYnpISXll?=
 =?utf-8?B?QnA3K0N3SWExQVFWNFZoVlNnSGsyMTQvVFRWSGJCaklIa1dMWlVtU0YrcmtW?=
 =?utf-8?B?L1BjaEVielhXelBJWGxuNHNWdG9LRkp4UnJZZHRjOGdMQXhJSHNyT0lKYkh3?=
 =?utf-8?B?bVZ3YUxCSDJOVmJBN2l2WjBKZTB3TjZiTmFxdkxrV0Y4NGFpaGtSMmJ2RlJG?=
 =?utf-8?B?Y0drdzdnYkhnUG0wWWdKbm1sNy9adEl3SmpzaS93S3JRbjNCTFJOZGdVOXBK?=
 =?utf-8?B?cVZldEhyd2t1N3lUTDBPQU1SRno2QllCY3FuL3Z1SGU5b2NlT3E1cmQzMTdH?=
 =?utf-8?B?bHptM3lJa1ZMdExkSkxSWkNIRklxMHZJYXpTZmdCSmZ0OWJTK3VvQU9nbGRh?=
 =?utf-8?B?QmZQYUs5eDV1S3piQVhtTmk0SlkrM0dwSHdYTldHSkdabVpyTzFYaGNONDdS?=
 =?utf-8?B?dksvWlBGTDlRN1FlQWtHL2dXbEJOQWw0NWUzQkhYM3BKT0d3S0VJSE5CaitY?=
 =?utf-8?B?NTUydUNUVmlrVXBjY29md24xenVKckZkRnpFSGlSOVFGTEtCTWlsb3pUNDM1?=
 =?utf-8?B?RDBSdUNob1lyZ2xzZ2U2TERVWGk1R0gwNkMxSmpsS0N1WTR0UmJESWhvd1o1?=
 =?utf-8?B?M0NBN0VNTHROZ0YyYi92UHY5eWNtNzYyQTJsUDJQK0tXdVNCaDZNalhQeDJF?=
 =?utf-8?B?eWZJV1dNNXpGeEJBdkh3UEthZUNTK2cwNUJrNFZjcTcvWVhnbG8rdCsxM09Z?=
 =?utf-8?B?TWVURFE2UWlPTnR1aGdURlJJVVdkMWk4bE5SaUdpZzFzZU1hZzlrcGZPc0Zn?=
 =?utf-8?B?dmt4eitYcjVoMlQ2V0xLc3pTOHZrakZISWUyaHVqa3hRbGY5UU9KUEVJL3Qy?=
 =?utf-8?B?S2ZlZkhIbzR0cThvMkg5dldhdTVHQ1pUM1NuZm9qOXlUNmplc2hueENtRlJ5?=
 =?utf-8?B?b3hxT0wwNGoybkltcFNMMEdidU82WkhXa0hLazFzZlB6NkV6azE1aGxXNDBU?=
 =?utf-8?B?ZEx5NmlUVWdFQkZ4TWdCNVFkT0ZabmhKN2hpbHRXUG9sZW1rcHlWSkhyODVw?=
 =?utf-8?B?UU5wY3h1K1RWK2N5enFWZk1Mb2RxbUFyRnNFZG5WWFJrVzFMbTdRZnNyVThF?=
 =?utf-8?B?SEJkd2JMck4yMllZTTA0ZThzY0x6WnhuaEJIeThqQUk2OXJxWC9DSUsybXF6?=
 =?utf-8?B?S1Fzb1FCalNuK21UaThqWlJUdzdTb3dnOTg1bTBVM0JmL1JITU9teG5KUkth?=
 =?utf-8?B?R2VqS3luYit6S0lqU25XNUpYdngwcXR4ZDlMT3BBT2lrdVkwU24vZVBMMjVw?=
 =?utf-8?B?Wkk3YmxIRzVxVmZGb2N0Mm5YOEwvblZvcDhoSUo0Zk1icGtwQ3R4dGNJbXlj?=
 =?utf-8?B?aGl0d3NmMzlmVDJ6SGRGcmkzM1VhdjZCNzVQU1JHczVOZENYR29PbXB2TGJt?=
 =?utf-8?B?blk5RUZMZlFLeW1UNlhqNW01QUM3WDY2RFZ1TzFFWU5MTjZCbC9LdEhpUVNr?=
 =?utf-8?B?MXJjSkdUWGhOb0hVVytteVVIMTdWZ1ZnQ3o1WmZIcWVhWDk3eGdzRlNvVG9B?=
 =?utf-8?B?UFhPZWk3dkdVVHZDaVd2NkwrV3JOS3ZOMmFWYWMzZFhIQ2ZCeEd0eHdGUGtL?=
 =?utf-8?Q?Dpb8M2EwAM3/LEGj9wdrYGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FC5B17CA31C9B41B89305ABD581102E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8fd282-c173-484f-a9c9-08d9a2613918
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 02:41:10.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zrg7RvdD7xS5lek1bTAGshyvcMl0GHoumotJcjGCM+t9g8WcnfWkM83Iz9kqj0tXnkFsAi/lFUqdpU2S6ovLXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3302
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTExLTA4IGF0IDAyOjI3ICswMDAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMjEtMTEtMDcgYXQgMDA6MDMg
KzAwMDAsIFJpY2sgTWFja2xlbSB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBJIHJh
biBhIHNpbXBsZSB0ZXN0IHVzaW5nIGEgTGludXggNS4xMiBjbGllbnQgTkZTdjQuMiBtb3VudA0K
PiA+ID4gYWdhaW5zdCBhIEZyZWVCU0QgcE5GUyBzZXJ2ZXIsIHdoZXJlIHRoZSBEUyBpcyBvdXQg
b2Ygc3BhY2UNCj4gPiA+IChpbnRlbnRpb25hbGx5LCBieSBjcmVhdGluZyBhIGxhcmdlIGZpbGUg
b24gaXQpLg0KPiA+ID4gDQo+ID4gPiBJIHRyaWVkIHRvIHdyaXRlIGEgZmlsZSBvbiB0aGUgTGlu
dXggTkZTIGNsaWVudCBtb3VudCBhbmQgdGhlDQo+ID4gPiBtb3VudCBwb2ludCBnZXRzICJzdHVj
ayIgKHdpbGwgbm90IDxjdHJsPkMgbm9yICJ1bW91bnQgLWYiKS4NCj4gPiA+IC0tPiBUaGUgY2xp
ZW50IGlzIGF0dGVtcHRpbmcgd3JpdGVzIGFnYWluc3QgdGhlIERTIHJlcGVhdGVkbHksDQo+ID4g
PiDCoMKgwqDCoMKgwqAgd2l0aCB0aGUgRFMgcmVwbHlpbmcgTkZTNEVSUl9OT1NQQy4gKFNhbWUg
Ynl0ZSBvZmZzZXRzLA0KPiA+ID4gwqDCoMKgwqDCoMKgIG92ZXIgYW5kIG92ZXIgYW5kIG92ZXIg
YWdhaW4uKQ0KPiA+ID4gLS0+IFRoZSBjbGllbnQgaXMgcmVwZWF0ZWRseSBzZW5kaW5nIFJQQ3Mg
d2l0aCBMYXlvdXRFcnJvciBpbg0KPiA+ID4gwqDCoMKgwqDCoMKgIHRoZW0gdG8gdGhlIE1EUywg
cmVwb3J0aW5nIHRoZSBORlM0RVJSX05PU1BDLg0KPiA+ID4gDQo+ID4gPiBJJ2xsIGxlYXZlIGl0
IHVwIHRvIG90aGVycywgYnV0IGZhaWxpbmcgdGhlIHByb2dyYW0gdHJ5aW5nIHRvDQo+ID4gPiB3
cml0ZSB0aGUgZmlsZSB3aXRoIEVOT1NQQyB3b3VsZCBzZWVtIHByZWZlcmFibGUgdG8gdGhlDQo+
ID4gPiAic3R1Y2siIG1vdW50Pw0KPiA+ID4gLS0+IFJlbW92aW5nIHRoZSBsYXJnZSBmaWxlIGZy
b20gdGhlIERTIHNvIHRoYXQgdGhlIFdyaXRlcw0KPiA+ID4gwqDCoMKgwqDCoCBjYW4gc3VjY2Vl
ZCBkb2VzIGNhdXNlIHRoZSBjbGllbnQgdG8gcmVjb3Zlci4NCj4gPiA+IA0KPiA+IA0KPiA+IFRo
ZSBjbGllbnQgZXhwZWN0YXRpb24gaXMgdGhhdCB0aGUgTURTIHdpbGwgZWl0aGVyIHJlbWVkeSB0
aGUNCj4gPiBzaXR1YXRpb24sIG9yIGl0IHdpbGwgcmV0dXJuIGFuIGFwcHJvcHJpYXRlIGFwcGxp
Y2F0aW9uLWxldmVsIGVycm9yDQo+ID4gdG8NCj4gPiB0aGUgTEFZT1VUR0VULg0KPiBUaGFua3Mg
VHJvbmQsIHRoYXQgd29ya2VkIGZpbmUgZm9yIE5GU3Y0LjIuIEkgdHdlYWtlZCB0aGUgcE5GUyBz
ZXJ2ZXINCj4gdG8gcmVwbHkgTkZTNEVSUl9OT1NQQyB0byBMYXlvdXRHZXQgYW5kIHRoYXQgd29y
a2VkIGZpbmUuDQo+IChUaGlzIGlzIHRyaWdnZXJlZCBieSB0aGUgTGF5b3V0RXJyb3IuKQ0KPiAN
Cj4gRm9yIE5GU3Y0LjEsIHRoaW5ncyBkb24ndCB3b3JrIGFzIHdlbGwsIHNpbmNlIHRoZXJlIGlz
IG5vIExheW91dEVycm9yDQo+IG9wZXJhdGlvbi4gVGhlIExheW91dFJldHVybiBoYXMgdGhlIE5G
UzRFUlJfTk9TUEMgZXJyb3IgaW4gaXQsDQo+IGJ1dCB0aGF0IGRvZXNuJ3QgaGFwcGVuIHVudGls
IGl0IGZpbmlzaGVzICh3aGljaCBkb2Vzbid0IGhhcHBlbiB1bnRpbA0KPiBJIGZyZWUgdXAgc3Bh
Y2Ugb24gdGhlIERTKS4NCg0KSG1tLi4uIFRoZSBFTk9TUEMgZXJyb3IgZnJvbSB0aGUgRFMgc2hv
dWxkIGluIHByaW5jaXBsZSBiZSBtYXJraW5nIHRoZQ0KbGF5b3V0IGZvciByZXR1cm4uIFlvdSdy
ZSBzYXlpbmcgdGhhdCB0aGUgcmV0dXJuIGlzbid0IGhhcHBlbmluZz8NCg0KRG9lcyBhIG5ld2Vy
IGNsaWVudCBmaXggdGhlIGlzc3VlPw0KDQo+IEJ1dCBJIGNhbiBsaXZlIHdpdGggb25seSA0LjIg
d29ya2luZyB3ZWxsLiBJIGNhbid0IGJlIGJvdGhlcmVkDQo+IGVuZGxlc3NseQ0KPiBwcm9iaW5n
IHRoZSBEU3MgdG8gc2VlIGlmIHRoZXkgYXJlIG91dCBvZiBzcGFjZS4NCg0KQWdyZWVkLiBZb3Vy
IHNlcnZlciBzaG91bGQgYmUgYWJsZSB0byByZWx5IG9uIHRoZSBsYXlvdXQgZXJyb3IgcmVwb3J0
cw0KZnJvbSB0aGUgY2xpZW50IChlaXRoZXIgaW4gTEFZT1VURVJST1Igb3IgaW4gdGhlIExBWU9V
VFJFVFVSTikgaW4gb3JkZXINCnRvIGZpZ3VyZSBvdXQgd2hlbiB0aGUgRFMgbWlnaHQgYmUgb3V0
IG9mIHNwYWNlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
