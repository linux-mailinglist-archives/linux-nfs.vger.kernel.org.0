Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D09B361041
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhDOQhk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 12:37:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46598 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOQhj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 12:37:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FGZilO105392;
        Thu, 15 Apr 2021 16:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BQCcd3nZhLOvOJqTPeljhfDjBCNAjZHrLF59vJWiL1s=;
 b=LbFbzTwRg3W+VmyKt1Flqm18xsz+1/yYZ+D5ZWtDfxXsa/FNny4xozeKsGylXVfx49Eu
 zJuE+rIPB4GnJVRLBdpB4IWeQOSIbXzvB5TuAWAlTRu2yXhTGfK2R6y6aGSzjUj3BFyI
 CwaN6T6/QseKDLGsBcZYzcHqJPqqCOYuvh3qjn4zbSQi+JuSZzEh9p+sjIVKGzAgF2p3
 DJU45MCuU+klhk8VIsuiCjnWzHOqydt3OpwmAP/kUqu2hCBciUn1neaiphp+b9kJDS6E
 MJi6KUOk9JiOQ91UK2xvqmHtPmEdELtwA88syBbh0S1b/3e197I6Mq7R3Mt8NqUwznCv zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbpnk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 16:37:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FGZbBS078884;
        Thu, 15 Apr 2021 16:37:12 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by userp3020.oracle.com with ESMTP id 37unsvuth6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 16:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBvMEFqcb7ZD3lwMgLIJNnsdDfAhJYjhoSU38bhwZBTw+S1gM63HjLV95fRc7T/rtCzswDtw6OapNW6muVwQWnNLv3P7EM+TG8hpoX9dPeQQgH261xJ0KJLXQfwq+Y3zSuiF4D2efZxKzD6QrHy8BefFduGm2sSp2ZV72hD6zX25BH+47eFpEI8LkHYihQ95ug3E6OnLymxNRXLI0LaMAkPrPjP7evQqVmd2g1t9GH3VMgK4ySX3qBv7lNrFt8IT5w0BT7aNONZ+XOW67Lgsg5mZ7b8k6oAYbCie7WAwBJnQrM0Jj5TbRhbcfOyLZ52tR3j60o8FueBguuUj0dcCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQCcd3nZhLOvOJqTPeljhfDjBCNAjZHrLF59vJWiL1s=;
 b=GNxeqBfwsHniGoarn+3fPaW0qaids2622XEONY1cfuQpLViHGYutWYKDulPwH7B35az4nSy479QMzx0Y4IiGad0bb0Llhr0LDeqUe+Dz9SnTC7DXSoWVE6Qyt0xN+QGWNlLzcH3mexomPoY9hus3QE6um5ew9QFVOhOp1m54wPev3E6yCs01c2bhKnjNoe01cuOduns6RqwjV15Yzv9g5Aqp2tReW1o29+/yHvo1QXq6KkSnd6yYylxNLOKuqwmFuLJtswwXq1n4z9lPer4TLVZnyb6AfTlUZAiZEAtBOcw/4J3bMMB206/5/zf4BeZmbs5YHDBxyOjiSHKXyqqhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQCcd3nZhLOvOJqTPeljhfDjBCNAjZHrLF59vJWiL1s=;
 b=ga5Vhit7JvNTTs7xHAHYKw+qTGIGy7E2ws2MKjcQbCi9wJflzVOUJAE7y3jEnokR0EC9Sop0Qq7l4O4YdfcSuNrMcPUoPapy6yh0sAoXYWOgsubq0NM17RQ3IjbYJs/rloZsDhoJEVyhS7hW1Dd3QaIGj7awrW9KK2ndKlJijNM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 16:37:10 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 16:37:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@RedHat.com>,
        Alice J Mitchell <ajmitchell@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Topic: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Index: AQHXMVl21czF1oj/Wkexg55/eRtUL6q0qJzlgAEODgCAABHLgA==
Date:   Thu, 15 Apr 2021 16:37:10 +0000
Message-ID: <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
In-Reply-To: <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: RedHat.com; dkim=none (message not signed)
 header.d=none;RedHat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6952131b-2121-4d53-2628-08d9002cb775
x-ms-traffictypediagnostic: BY5PR10MB4321:
x-microsoft-antispam-prvs: <BY5PR10MB432134336C82D8D097867C78934D9@BY5PR10MB4321.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dD70G3DlVHoGJnSCu0wWZX2WnrKMS4/gkNIP4ETlwV8viL/xrCEhbpxweQVtWDYPIdzTesXFEPGoFlBrgE+S26AT1VsvTUPtAF2GCuIOk9k5jpbfOOVAAmm4Xmjw+ttAYnhpUlwvUJk7doGnzklgIJRkYNm/Fi4InvK4Uiagu8s9G9ZDVwX5lnwVmQAEv+fQJlgB8HLe/ELyMz/TgLod8p/RYFJLx9PKIsryHucQbESLaUkOm7NI+9KcZ+11eBie/K5hyyrnQuLHn3kDsMWvjPMoZ1lp+UEcq3/F7AEoNJu3p1HkEQUkHKMROJK6ti76ZXWehan2YJGzuCQVmCL+61YteYpWW9XyavHdAxYU8aVMIF71nJZctmNkOh1rGFUT7JvSPQdm3OGRzbLqDo5VPuGbUMR33jj7jCBCw1WyGqhahBllQAeIcTn0uHv5kdArADRV3wceKdcv9BNBxq2E6hhax8VGQXrRqYqOqVbvhh5OOsM/BTNRgzX28HORPNGZsSJutnEOpItyg/DIqGeiNgL1meHOhLsVQsNA8XmtCrwybwKZHEA/ZW7EEsIj85gD++uaGxPhQzOfJfujHOnQQYzbcjp1lNAXIkiUtbYJCZaQMpD7msn9S6BLca/3F3zdtv1/XcMmk4lbrvSzuZ3gIN/eVOxdbv4zJzJ6JetnPomqBXCdpuKheY6DAWHjyc7PyYmOPhJ1BjahRaNuQ4VdZ1v7KDoJOc0B1qwEoAIrwtIBXyARMIgen26kDiVz8P8k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(8936002)(33656002)(186003)(66556008)(76116006)(71200400001)(66946007)(86362001)(38100700002)(91956017)(83380400001)(64756008)(66476007)(8676002)(2616005)(2906002)(6512007)(4326008)(122000001)(6506007)(478600001)(53546011)(6486002)(316002)(5660300002)(966005)(26005)(110136005)(36756003)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L3pWRy9qamJ2MFJVQWYrWFpKT0h4V1NJQXE5NDFCM2R3K3NndFV3MVp3cVM2?=
 =?utf-8?B?VWozY0JwNWhMZzVPZ2lKNEtrZ05vc2dCSlhBY2w0RDJXSXhLUWhNeEdQRGpQ?=
 =?utf-8?B?VXFRZzc1NUxyUjhTZTEwbWxtY3Bob3ZXSzRZNFkxUVVILy9GUUlqOWxOaUxq?=
 =?utf-8?B?TmgxRXBjNGx4dnFLdE1weFNQeFlyRG1QVE9pNEc1bG53cGQxWnBSRE1SUk4x?=
 =?utf-8?B?QmthRGNIK0RueU1odVB4V1JLNE9BcW5iNHNrRkRJRUVadUI2QitHY2FpM1Nx?=
 =?utf-8?B?MmdsdElrSGI4SXVQM2lTUS9LbXYwSlZjVFN0Si9TbTVsbW1QeVptQ2ZhWk14?=
 =?utf-8?B?THB4bXFxaG11NlJaWDYvSEU2RGFSb2t4RGUvc2Rwc1pNZXFaVkFlMlV1UlR2?=
 =?utf-8?B?RDZBNVlwUCt1cGE1SjFRak5kTkQ2amN0cVpLblJhT0tvNjV3SUx1a0VJS2FU?=
 =?utf-8?B?V3QyYTJUSnU1V2Z6dDlrVEF6Z3FJSU9RRGtSNHNxNHFDbnNxcFdFMEkzSVRV?=
 =?utf-8?B?TEVzY2pMT2FjN285UWpPSVcxY0NzRm5SRHVjMFJNcWtKWXhudU5kdWVDQzRn?=
 =?utf-8?B?dEpuWVNPQnhOS2EyYmdJQzIyK1VXOEhMdHR4Z2ZDM2RkQ2RFVzRMOXBEQWVS?=
 =?utf-8?B?ZHhQNjJXdkJnT0VRVnZlTWo4VnpHTGhIc0tuejJlR3Z5NVQ5bkljQ1lXZlow?=
 =?utf-8?B?cHM1dmR5ODVRcm1lT2hTc3lZMHJubk5pOUVJM0pna3NUQTFHNVRwd0JKaGUv?=
 =?utf-8?B?VTdxcXpjMkNzNGMvSmpuUmMvWGdnTGJsQU1rTHJvbnQvbDVTYUQySDlqOXZj?=
 =?utf-8?B?Mi8vaHNGZW1TU0kvS1B6RU1iMWxyS1drRFI0cUlHbzNRNnZrRzNFaTZaUFZl?=
 =?utf-8?B?bkhEY2V5ZXNyRFg3Yms4QVNvdVhBTnJsUWhzZmdtVE9uZWZzUXFIWktPSXhO?=
 =?utf-8?B?d1NReEU1NHdUdXJ1UkcxdXdVUXZyeFNaT2d2MWZjV3pBMDV3cnorQTZUaXla?=
 =?utf-8?B?dHlXVDBlQXhtOGFrWUNtekFVMXI0TTVpdkZkci9PMURnRHliSkNrTzFxOC9I?=
 =?utf-8?B?UVZIZmJIOXkvR3FqY2ZUWEFnSTJ3VzB4d05peTMwMFI0N2xmVDlHUS9TSjV3?=
 =?utf-8?B?NnNoT0RwTWd4eWJpY2dJYldGTU5qTG1LL2JHTGtNTFBPalBhMWcwTTFKM3F4?=
 =?utf-8?B?eEpVa042TzFZbTA2TmRzM0ZSMzhud2VXeWFUaWxwRXFDL2x5dktvY2FSUjEv?=
 =?utf-8?B?OGJXOGwxS1ZudXhic3AyQUQrZVBwRWNYQ0prcExLZTBlZ2tBeDlGcERuTmhN?=
 =?utf-8?B?U3lOdEtMeWs4WG5XS3ljZ2hUbzVUeW02UUZLY1VaMWc2VktlNkJyRi84NW91?=
 =?utf-8?B?djdJODJIV0o3OGd2VHNPcHlINUsyQXYzbXN1c0tKZFZxdDlFUnVYbEVmU3BR?=
 =?utf-8?B?aHcxZXZjTE1CTGNwYU0wQ0pnNWdZalA3T3BaRXl3QmhSZkhjcTd2eTZpY3pv?=
 =?utf-8?B?ellSUjhWbS9tMnN6dHdsR3pPajQ4cUlRbFRkcDRtQlVWMnJSdDNKcDYvVFEw?=
 =?utf-8?B?dE41SmlaZHo1ZW43dE85NW5yaXNVTTRMdWtqSzU4dWdkLzQwY0hxczA1bEtB?=
 =?utf-8?B?T2xMUWk1SFZzeEp3UnJjSTl3N1lpUlRaeFNwZkNqZnRldFFuRm0zd2hKZk5x?=
 =?utf-8?B?ZU4vR3Y0Wkt2Q2trUDYzcWhlbmI5Nm5VbWhyQzJ3SDRkWVBPWXFwU2dyS09Y?=
 =?utf-8?Q?0nsP54HJQP8zQqL6PdNmYqlass+ea2QAqZUOQvo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1DA691124C3841AFAD1272399AC88C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6952131b-2121-4d53-2628-08d9002cb775
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 16:37:10.4999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9kt/JAme1eiiBS19RaFP+UC4eT/2KfmGI2BkiOxUs6JBEdgLbmIJx4LnjX7WMRMlRkHSFgM6Kx0OO8A2kfNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150104
X-Proofpoint-GUID: UNfe_4a5nN7kCxIeksMWDJcCYIusUkyr
X-Proofpoint-ORIG-GUID: UNfe_4a5nN7kCxIeksMWDJcCYIusUkyr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150104
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXByIDE1LCAyMDIxLCBhdCAxMTozMyBBTSwgU3RldmUgRGlja3NvbiA8U3RldmVE
QFJlZEhhdC5jb20+IHdyb3RlOg0KPiANCj4gSGV5IENodWNrISANCj4gDQo+IE9uIDQvMTQvMjEg
NzoyNiBQTSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gSGkgU3RldmUtDQo+PiANCj4+PiBP
biBBcHIgMTQsIDIwMjEsIGF0IDI6MTAgUE0sIFN0ZXZlIERpY2tzb24gPFN0ZXZlREByZWRoYXQu
Y29tPiB3cm90ZToNCj4+PiANCj4+PiDvu79UaGlzIGlzIGEgdHdlYWsgb2YgdGhlIHBhdGNoIHNl
dCBBbGljZSBNaXRjaGVsbCBwb3N0ZWQgbGFzdCBKdWx5IFsxXS4NCj4+IA0KPj4gVGhhdCBhcHBy
b2FjaCB3YXMgZHJvcHBlZCBsYXN0IEp1bHkgYmVjYXVzZSBpdCBpcyBub3QgY29udGFpbmVyLWF3
YXJlLg0KPj4gSXQgc2hvdWxkIGJlIHNpbXBsZSBmb3Igc29tZW9uZSB0byB3cml0ZSBhIHVkZXYg
c2NyaXB0IHRoYXQgdXNlcyB0aGUNCj4+IGV4aXN0aW5nIHN5c2ZzIEFQSSB0aGF0IGNhbiB1cGRh
dGUgbmZzNF9jbGllbnRfaWQgaW4gYSBuYW1lc3BhY2UuIEkNCj4+IHdvdWxkIHByZWZlciB0aGUg
c3lzZnMvdWRldiBhcHByb2FjaCBmb3Igc2V0dGluZyBuZnM0X2NsaWVudF9pZCwNCj4+IHNpbmNl
IGl0IGlzIGNvbnRhaW5lci1hd2FyZSBhbmQgbWFrZXMgdGhpcyBzZXR0aW5nIGNvbXBsZXRlbHkN
Cj4+IGF1dG9tYXRpYyAoemVybyB0b3VjaCkuDQo+IEFzIEkgc2FpZCBpbiBpbiBteSBjb3ZlciBs
ZXR0ZXIsIEkgc2VlIHRoaXMgbW9yZSBhcyBpbnRyb2R1Y3Rpb24gb2YNCj4gYSBtZWNoYW5pc20g
bW9yZSB0aGFuIGEgd2F5IHRvIHNldCB0aGUgdW5pcXVlIGlkLg0KDQpZZXAsIEkgZ290IHRoYXQu
DQoNCkknbSBub3QgYWRkcmVzc2luZyB0aGUgcXVlc3Rpb24gb2Ygd2hldGhlciBhZGRpbmcgYQ0K
bWVjaGFuaXNtIHRvIHNldCBhIG1vZHVsZSBwYXJhbWV0ZXIgaW4gbmZzLmNvbmYgaXMgZ29vZA0K
b3Igbm90LiBJJ20gc2F5aW5nIG5mczRfY2xpZW50X2lkIGlzIG5vdCBhbiBhcHByb3ByaWF0ZQ0K
cGFyYW1ldGVyIHRvIGFkZCB0byBuZnMuY29uZi4gQ2FuIHlvdSBwaWNrIGFub3RoZXINCm1vZHVs
ZSBwYXJhbWV0ZXIgYXMgYW4gZXhhbXBsZSBmb3IgeW91ciBtZWNoYW5pc20/DQoNCg0KPiBUaGUg
bWVjaGFuaXNtIGJlaW5nDQo+IGEgd2F5IHRvIHNldCBrZXJuZWwgbW9kdWxlIHBhcmFtcyBmcm9t
IG5mcy5jb25mLiBUaGUgc2V0dGluZyBvZg0KPiB0aGUgaWQgaXMganVzdCBhIHNpZGUgZWZmZWN0
Li4uIA0KPiANCj4gV2h5IHNwcmVhZCBvdXQgdGhlIE5GUyBjb25maWd1cmF0aW9uPyAgV2h5IG5v
dA0KPiBqdXN0IGtlZXAgaXQgaW4gb25lIHBsYWNlLi4uIGFrYSBuZnMuY29uZj8NCg0KV2UgbmVl
ZCB0byB1bmRlcnN0YW5kIHdoZXRoZXIgYSBtb2R1bGUgcGFyYW1ldGVyIGlzIG5vdA0KZ29pbmcg
dG8gd29yayBpbiBuZnMuY29uZiBiZWNhdXNlIHRoYXQgc2V0dGluZyBuZWVkcyB0bw0KYmUgbmFt
ZXNwYWNlLWF3YXJlLiBJbiB0aGlzIGNhc2UsIHRoaXMgc2V0dGluZyBkb2VzIGluZGVlZA0KbmVl
ZCB0byBiZSBuYW1lc3BhY2UtYXdhcmUuIG5mcy5jb25mIGlzIG5vdCBhd2FyZSBvZg0KbmV0d29y
ayBuYW1lc3BhY2VzLg0KDQoNCj4gUGx1cyB3ZSBjb3VsZCBkb2N1bWVudCBhbGwgdGhlIGtlcm5l
bCBwYXJhbXMgaW4gbmZzLmNvbmYNCj4gYW5kIHRoZSBuZnMuY29uZiBtYW4gcGFnZS4gVGhlIG9u
bHkgZG9jdW1lbnRhdGlvbiBJIGtub3cgDQo+IG9mIGlzIGluIHRoZSBrZXJuZWwgdHJlZS4NCg0K
T0ssIGJ1dCB0aGF0J3Mgbm90IHJlbGV2YW50IHRvIHdoZXRoZXIgbmZzLmNvbmYgaXMgdGhlDQpy
aWdodCBwbGFjZSB0byBzZXQgbmZzNF9jbGllbnRfaWQuDQoNCg0KPiBBcyBmYXIgYXMgbm90IGJl
aW5nIGNvbnRhaW5lci1hd2FyZS4uLiB0aGF0IG1pZ2h0IHRydWUNCj4gYnV0IGl0IGRvZXMgbm90
IG1lYW4gaXRzIG5vdCB1c2VmdWwgdG8gc2V0IHRoZSBpZCBmcm9tDQo+IG5mcy5jb25mLi4uDQoN
ClllcywgaXQgZG9lcyBtZWFuIHRoYXQgaW4gdGhhdCBjYXNlLiBJdCdzIGNvbXBsZXRlbHkNCmJy
b2tlbiB0byB1c2UgdGhlIHNhbWUgbmZzNF9jbGllbnRfaWQgaW4gZXZlcnkgbmV0d29yaw0KbmFt
ZXNwYWNlLg0KDQoNCj4gQWN0dWFsIEkgaGF2ZSBjdXN0b21lcnMgYXNraW5nIGZvciB0aGlzIHR5
cGUNCj4gb2YgZnVuY3Rpb25hbGl0eQ0KDQpBc2sgeW91cnNlbGYgd2h5IHRoZXkgbWlnaHQgd2Fu
dCBpdC4gSXQncyBwcm9iYWJseSBiZWNhdXNlDQp3ZSBkb24ndCBzZXQgaXQgY29ycmVjdGx5IGN1
cnJlbnRseS4gSWYgd2UgaGF2ZSBhIHdheSB0bw0KYXV0b21hdGljYWxseSBnZXQgaXQgcmlnaHQg
ZXZlcnkgdGltZSwgdGhlcmUncyByZWFsbHkgbm8NCm5lZWQgZm9yIHRoaXMgc2V0dGluZyB0byBi
ZSBleHBvc2VkLg0KDQpJIGRvIGFncmVlIHRoYXQgaXQncyBsb25nIHBhc3QgdGltZSB3ZSBzaG91
bGQgYmUgc2V0dGluZw0KbmZzNF9jbGllbnRfaWQgcHJvcGVybHkuIEkgd291bGQgcmF0aGVyIHNl
ZSBhIHVkZXYgc2NyaXB0DQpkZXZlbG9wZWQgKHlvdSwgbWUsIG9yIEFsaWNlIGNvdWxkIGRvIGl0
IGluIGFuIGFmdGVybm9vbikNCmZpcnN0LiBJZiB0aGF0IGRvZXNuJ3QgbWVldCB0aGUgYWN0dWFs
IGN1c3RvbWVyIG5lZWQsIHRoZW4NCndlIGNhbiByZXZpc2l0Lg0KDQoNCj4gc3RldmVkLg0KPj4g
DQo+PiANCj4+PiBJdCBlbmFibGVzIHRoZSBzZXR0aW5nIG9mIHRoZSBuZnM0X3VuaXF1ZV9pZCBr
ZXJuZWwgbW9kdWxlIA0KPj4+IHBhcmFtZXRlciBmcm9tIC9ldGMvbmZzLmNvbmYuDQo+PiANCj4+
PiBUaGluZ3MgSSB0d2Vha2VkOg0KPj4+IA0KPj4+ICAgKiBJbnRyb2R1Y2UgYSBuZXcgW2tlcm5l
bF0gc2VjdGlvbiBpbiBuZnMuY29uZiB3aGljaCBvbmx5DQo+Pj4gICAgIGNvbnRhaW5zIHRoZSBu
ZnM0X3VuaXF1ZV9pZCBzZXR0aW5nLi4uIEZvciBub3cuLi4gDQo+Pj4gDQo+Pj4gICAqIG5mczRf
dW5pcXVlX2lkIGNhbiBiZSBzZXQgdG8gdHdvIGRpZmZlcmVudCB2YWx1ZXMNCj4+PiANCj4+PiAg
ICAgICAtIG5mczRfdW5pcXVlX2lkID0gJHttYWNoaW5lLWlkfSB3aWxsIHVzZSAvZXRjL21hY2hp
bmUtaWQNCj4+PiAgICAgICAgICAgYXMgdGhlIHVuaXF1ZSBpZC4NCj4+PiAgICAgICAtIG5mczRf
dW5pcXVlX2lkID0gJHtob3N0bmFtZX0gd2lsbCB1c2UgdGhlIHN5c3RlbSdzIGhvc3RuYW1lDQo+
Pj4gICAgICAgICAgIGFzIHRoZSB1bmlxdWUgaWQuDQo+Pj4gDQo+Pj4gICAqIFRoZSBuZXcgbmZz
LWNvbmZpZyBzeXN0ZW1kIHNlcnZpY2UgbmVlZCB0byBiZSBlbmFibGVkIGZvciB0aGUNCj4+PiAg
ICAgL2V0Yy9tb2Rwcm9iZS5kL25mcy5jb25mIGZpbGUgdG8gYmUgY3JlYXRlZCB3aXRoIA0KPj4+
ICAgICB0aGUgIm9wdGlvbnMgbmZzIG5mczRfdW5pcXVlX2lkPSIgc2V0LiANCj4+PiANCj4+PiBJ
IHNlZSB0aGlzIHBhdGNoIHNldCBpcyBub3QgYSB3YXkgdG8gc2V0IHRoZSBuZnM0X3VuaXF1ZV9p
ZCANCj4+PiBtb2R1bGUgcGFyYW1ldGVyLi4uIEkgc2VlIGl0IGFzIGEgYmVnaW5uaW5nIG9mIGEg
d2F5IHRvIHNldCANCj4+PiBhbGwgbW9kdWxlIHBhcmFtZXRlcnMgZnJvbSAvZXRjL25mcy5jb25m
LCB3aGljaCBJIHRoaW5rDQo+Pj4gaXMgYSBnb29kIHRoaW5nLi4uIA0KPj4+IA0KPj4+IFsxXSBo
dHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1uZnMvbXNnNzg2NTguaHRtbA0KPj4+
IA0KPj4+IEFsaWNlIE1pdGNoZWxsICgzKToNCj4+PiBuZnMtdXRpbHM6IEVuYWJsZSB0aGUgcmV0
cmlldmFsIG9mIHJhdyBjb25maWcgc2V0dGluZ3Mgd2l0aG91dA0KPj4+ICAgZXhwYW5zaW9uDQo+
Pj4gbmZzLXV0aWxzOiBBZGQgc3VwcG9ydCBmb3IgZnVydGhlciAke3ZhcmlhYmxlfSBleHBhbnNp
b25zIGluIG5mcy5jb25mDQo+Pj4gbmZzLXV0aWxzOiBVcGRhdGUgbmZzNF91bmlxdWVfaWQgbW9k
dWxlIHBhcmFtZXRlciBmcm9tIHRoZSBuZnMuY29uZg0KPj4+ICAgdmFsdWUNCj4+PiANCj4+PiBj
b25maWd1cmUuYWMgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+Pj4gbmZzLmNvbmYgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4+PiBzdXBwb3J0L2luY2x1ZGUvY29uZmZpbGUuaCAg
ICB8ICAgMSArDQo+Pj4gc3VwcG9ydC9uZnMvY29uZmZpbGUuYyAgICAgICAgfCAyODMgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+IHN5c3RlbWQvTWFrZWZpbGUuYW0gICAg
ICAgICAgIHwgICAzICsNCj4+PiBzeXN0ZW1kL25mcy1jbGllbnQudGFyZ2V0ICAgICB8ICAgMyAr
DQo+Pj4gc3lzdGVtZC9uZnMtY29uZi1leHBvcnQuc2ggICAgfCAgMjggKysrKw0KPj4+IHN5c3Rl
bWQvbmZzLWNvbmZpZy5zZXJ2aWNlLmluIHwgIDE4ICsrKw0KPj4+IHN5c3RlbWQvbmZzLmNvbmYu
bWFuICAgICAgICAgIHwgIDE5ICsrLQ0KPj4+IHRvb2xzL25mc2NvbmYvbmZzY29uZi5tYW4gICAg
IHwgIDEwICstDQo+Pj4gdG9vbHMvbmZzY29uZi9uZnNjb25mY2xpLmMgICAgfCAgMjIgKystDQo+
Pj4gMTEgZmlsZXMgY2hhbmdlZCwgMzcyIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0K
Pj4+IGNyZWF0ZSBtb2RlIDEwMDc1NSBzeXN0ZW1kL25mcy1jb25mLWV4cG9ydC5zaA0KPj4+IGNy
ZWF0ZSBtb2RlIDEwMDY0NCBzeXN0ZW1kL25mcy1jb25maWcuc2VydmljZS5pbg0KPj4+IA0KPj4+
IC0tIA0KPj4+IDIuMzAuMg0KPj4+IA0KPiANCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
