Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB77A328255
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhCAPV2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:21:28 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37920 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbhCAPVM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 10:21:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121F9JZg166998;
        Mon, 1 Mar 2021 15:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=L5XIHe/qvrCpMUg1axGfdGKZycTUsMTAs8vW+wvOJ0A=;
 b=TqCpR0c25WnlZHOEs3ELF6yXBC7Wfavh1MoCBXwGYyLBp9TG4ytJWSAmbuZBHYhQF6ud
 lR2oOJ9p+shmPPIrH4h4iFAKD4IfVNM5s51vyXrx9JGZPRFAAy0vb9xWwylOpJwyij5E
 T0tx9+m0ju1M9oLTaciswH2LgUpDl20toLYOof/QM8yU/3fF/oZCKqqVUltVQJs+opIZ
 2tzk5GFTp+BM8ZSDOZcAHsWtPgkbRzLQse/SWHk4nvRUcxZt1g7HG77OqsB7eijaWAc1
 nzeKzEise1eYhnJwpW/sE+r9UJjCL1bZGZKJ+lx+8x6KA4VI7+O5FJ5FdSWrHU6jBCgd JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36ybkb4b3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 15:20:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121FF3En052850;
        Mon, 1 Mar 2021 15:20:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3030.oracle.com with ESMTP id 37000vp78x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 15:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCoFJf7T+vyaapeBTfNKezbZsyM9FXcisvFIb2Kb/wua9SQML8Z0RMSG+Q2n1aWmSw7JJAnW4DQGFPWT9P5oe1FXuNzPXjukRccwu8wiv2xIBhX63D9gEAI/KpwCqzNxY7o4go/sGALAbExfkmAPEwx5ib+p/CU7cjS39oWV7yqm2kapDqkhB32tNxhX3iQFMyeRyBFTdy6BZh/9gOsg77ibKSRpMjUScxgSLxxhdquanruLKzAzSbn7txQSA1+jEl2MRT2NlDeTXXkDr/wFLyXd7msJEhDgFHSyVLNyrXLRchuThcZgw7kSwsSYVyxyPrR3MHWIuqUnJLBwyGHDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5XIHe/qvrCpMUg1axGfdGKZycTUsMTAs8vW+wvOJ0A=;
 b=Ayf4TXmFPJoY6tiWn5dFYVpC9MQfSiusSZdh2IZJHMujxCtXkT3fdguSWIWa8J2mpZ5KkLVQx+x9sv4HIuPgsk5UGtK30io+1jPk5ksItvFH6Y/fj0M3BMt4jHk/p1Ik58569lKuGIiC0/BJnO//IJgLn8z5Tvh6KOEjyBWILq+JUEHbwOxeDvRNo4W3qMCC+AbgXnZGYLfyQ0j/vmWrkL1rYpNCmIFbMHOatBrxfshVHj3pPXRXHP9sClt8YJaMxJagIySJs8JbK1i4xbqJ81q2b0ON7zAtcgB5101ALBkH4sUAaMG5/0Ll0AALgoYq3uLEQ97S0pplWJTc50EzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5XIHe/qvrCpMUg1axGfdGKZycTUsMTAs8vW+wvOJ0A=;
 b=BlRBcdLDDtH1CQGslek1Yy+ySq4/JajA++LjUxE6RHH0BtKVsxF/TlyayBWP+mR/cXp7pOz8dvoTivO54QdTq/PK5QykrAgrD0LxBlqeH4eEH+ysoFYXXVPtUMI+EjxDjIFbvQiw3un02KXLQTc3WRlyHnTEFRJgsNuTyMvTV5s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4558.namprd10.prod.outlook.com (2603:10b6:a03:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 15:20:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 15:20:25 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Daniel Kobras <kobras@puzzle-itc.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Topic: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Index: AQHXDJPLGG4N2gFkYEKpGIw1cGBThqpvQ6UA
Date:   Mon, 1 Mar 2021 15:20:24 +0000
Message-ID: <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
In-Reply-To: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: puzzle-itc.de; dkim=none (message not signed)
 header.d=none;puzzle-itc.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6faae148-e91a-4013-a238-08d8dcc589b9
x-ms-traffictypediagnostic: SJ0PR10MB4558:
x-microsoft-antispam-prvs: <SJ0PR10MB4558F49C3285627FADE27EF4939A9@SJ0PR10MB4558.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6B0qief0Vi4QLQQuPztee2MG/D5iKLDvb58tyHtL/VR69+58arakYOJjwKzIWHKB0SbK6vgX+U0FqlOyzTSm+MyJ2WV7G4dobVdLkHaDNnD65084gVAnYoRt8++w4xJh7sOeMWHl7qwFjXGh4Hm3kwBtIkUIEN/XQDc0hf8JrqjH6TYSmVh6vu70QW/U026cD8oKUzhYR6lID5EngTc48aZCg5fln5qykdEBvXVIeLjXaxeQTCJXkwmgFSeY0FD11MmVfNHYj9vgRFAE69BYHGulprhlJEB4DTVCM9ordkFDicZjpDwX0oDr6qA6fHi4IE6EDcAEDl56N2ISL8/iBWGousvnocrNrh0GhJG2zzkZ28be8F98uUEbnVwD19s528KNmPrdqE9kqYjkyKf64F+LFHcPw6YNwjwWhSwu1GyTD8tmB5FoBNgdysKqqfc47Bz+KhW8/1vHviMj3QNzTnJPuND+n6Hm+FIFhVOlnhPBg9qWICSX2URx+EIGapVFhoFfRo2wgkVDC9pZ0FmBYIgamRDg5FRPpwHgyUvwaW3JtRK+Em+BQ8zOZQYDL2AF43PuLoPKyxt+HOdAPr68qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(39860400002)(346002)(76116006)(478600001)(5660300002)(66446008)(66556008)(66476007)(2906002)(64756008)(26005)(6512007)(66946007)(91956017)(83380400001)(53546011)(6506007)(8676002)(54906003)(44832011)(2616005)(316002)(6486002)(186003)(86362001)(4326008)(36756003)(71200400001)(33656002)(6916009)(8936002)(66574015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ejV1MDArSm41ajZianh2cEgxS1QveUZrcFpXRGxLdHdudUlQbTJ0T2RzNTZC?=
 =?utf-8?B?WmplcVZuSEZUOXo0VWJZam43TllsYWpwcXUrRi9hWXhhVUZqTzRDR2x0dHVa?=
 =?utf-8?B?MmhmdHdUb244ei94RnRrKzdOakxCYk9JVjNyekY3TFg2S2QxU0k5NTBRaGE3?=
 =?utf-8?B?am1TMlBpTmVPUCszWGwxeHpDMlFteExONjJzdEtueFdLc1BvNm5uZU5LZG5F?=
 =?utf-8?B?MFN0amZ0TG91ckNKY2lISGVrNGV6NlBYZHJxZXh6TFVUdFp0Nm9oZmwvUjlN?=
 =?utf-8?B?KzhNRVpINTNVTkkvV3hqMUlCdW9ZMkJTS00xL0kwbmVXdjdtcUF3UzcrOWgr?=
 =?utf-8?B?ZW4yTlFpVUh5ZXkvbXM0UnhrV0I5M1BxVUxiTzhicGJONHgrWEZSWnl4clRt?=
 =?utf-8?B?SlFDdlgybnJsNk5VaXdmeFg1RjVnRWRkaHFKMDFLWHFYNk9JUC9RZ2R3U05H?=
 =?utf-8?B?MXQrNzhUcG5ZZVFqMWUvcFA3ampuRm5KMWwwYmVvSUMycENZYmF6S1NlZ200?=
 =?utf-8?B?S0ZHODFJV2R2VHI0RGJqNTJZVGZuMTBFZlRhUnUxR05vaHA4bE42bjZMVlRJ?=
 =?utf-8?B?d1lvS3ZTR2pCeEdRempSZDNmbUhveGVVZFNFTiswYU5CTXVOSURZUm0zL1U2?=
 =?utf-8?B?aEtid09GUnZmbnhkZzVZRVlGQk5OcEpmOTRZR1lMRndWWTFuWHhieGVnODFZ?=
 =?utf-8?B?Ulh4ZlplSHM3ZFE0SThWeVY4OE5iSEhrYUwzZUZWUGV0WE9lWlNDRlRFMzll?=
 =?utf-8?B?VVdPbjFqeWFkYUpxdzBwODZvRHVnV093YjhKaWFQeEUrNTVKSkFPejBKbFJP?=
 =?utf-8?B?bkxmZDUydklnL242L1U1REhNQ2o4NFlPOUR1S3ZSSDBoV29XcTVEMUpUNUV3?=
 =?utf-8?B?S05CV0J2MCtZaGh5UGk3L0ZVNTFWMDVFSDVSOWlCNnhyaWJWbURzM1VHVDEz?=
 =?utf-8?B?Sm1QOG16Mlg2dGl0L3pmRjd3cDVyN0VyOEdCOEdZTUt0Sy8yOXBPV2VOeFRm?=
 =?utf-8?B?S2RTRUJ3VC8vNW5wSWR2TlNNTmd1blN1bEJNdnNHb21LNVgxdWpUOThONXdl?=
 =?utf-8?B?SlRKREpUZzZXNHZtd0hrcE9RWGt1YkRDZXk3WGNFYUF5L1dpa3ExSTFvRkI1?=
 =?utf-8?B?K1FCSE9LSDl6dW4wUllnTTRXVnlNQi9MUGJQaTJkYVJvRy9SY2JUTUx0ZlJW?=
 =?utf-8?B?YlpvMjVUak9FdGtiQ2k4Z04vSFVqN1pOWnQzekNKeDlmem0wYi9UN0ZUVXR6?=
 =?utf-8?B?amhrR2lhZUVHSkZ3SGd4UTEzdktYcEpSaldFaVBpUk9KZjVQRFVDcytxNkcv?=
 =?utf-8?B?NG5sandjZHVqSHJkeGEyL0NEejd5cUlraUVkWXVvODRNSVQ3Nzl5aEJTZ21I?=
 =?utf-8?B?MTZzM054VU05U1BENnFvRU9OdEhGWVlhMXgwb01rQW5LQUk0OVlwcmROcTkx?=
 =?utf-8?B?Ri9iMzltOHl0LzdWNktpR01CT3VpNUhRU2c2REhYemRkSTdxV0xvMWU0QTly?=
 =?utf-8?B?eWRpR2VLREd5NnBpa3g1Q05nb0x4SW9TYlhia1dCbG5VbXdaK2xUMEtjWjJR?=
 =?utf-8?B?RU5JMEw3clVHR3NtUXNLNiswVm9wTUtmT2tOZEUwOFd6ckJaYTdLeWVMMFBz?=
 =?utf-8?B?R0xyNW5XMHFBeXVRVWQ2dHFER2hxQlJGdU43anRpeGpLVHNwZGFYam5IY3px?=
 =?utf-8?B?SXhHWE5Bc0hVOXJWenhwd1pGdXk2UDl5Z3oxcFZyWFZMRDM1cEFqY0hkajVY?=
 =?utf-8?Q?HhwTcJBAGdmXaNv1/Rx72QlwliRF/Jm2334477M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F46A78066C59445BC111C4F53C6F0E9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faae148-e91a-4013-a238-08d8dcc589b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 15:20:24.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uq7B2UdncEdE+4Lp48oyCQnBuz0eX9O4rY74yHsXdnBq4LlcfmCQbnxDhyXbFXFehzYD0CF6540z0G7UBxnbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4558
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010129
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIEZlYiAyNiwgMjAyMSwgYXQgNjowNCBQTSwgRGFuaWVsIEtvYnJhcyA8a29icmFzQHB1
enpsZS1pdGMuZGU+IHdyb3RlOg0KPiANCj4gSWYgYW4gYXV0aCBtb2R1bGUncyBhY2NlcHQgb3Ag
cmV0dXJucyBTVkNfQ0xPU0UsIHN2Y19wcm9jZXNzX2NvbW1vbigpDQo+IGVudGVycyBhIGNhbGwg
cGF0aCB0aGF0IGRvZXMgbm90IGNhbGwgc3ZjX2F1dGhvcmlzZSgpIGJlZm9yZSBsZWF2aW5nIHRo
ZQ0KPiBmdW5jdGlvbiwgYW5kIHRodXMgbGVha3MgYSByZWZlcmVuY2Ugb24gdGhlIGF1dGggbW9k
dWxlJ3MgcmVmY291bnQuIEhlbmNlLA0KPiBtYWtlIHN1cmUgY2FsbHMgdG8gc3ZjX2F1dGhlbnRp
Y2F0ZSgpIGFuZCBzdmNfYXV0aG9yaXNlKCkgYXJlIHBhaXJlZCBmb3INCj4gYWxsIGNhbGwgcGF0
aHMsIHRvIG1ha2Ugc3VyZSBycGMgYXV0aCBtb2R1bGVzIGNhbiBiZSB1bmxvYWRlZC4NCj4gDQo+
IEZpeGVzOiA0ZDcxMmVmMWRiMDUgKCJzdmNhdXRoX2dzczogQ2xvc2UgY29ubmVjdGlvbiB3aGVu
IGRyb3BwaW5nIGFuIGluY29taW5nIG1lc3NhZ2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwg
S29icmFzIDxrb2JyYXNAcHV6emxlLWl0Yy5kZT4NCj4gLS0tDQo+IEhpIQ0KPiANCj4gV2hpbGUg
ZGVidWdnaW5nIE5GUyBvbiBhIHN5c3RlbSB3aXRoIG1pc2NvbmZpZ3VyZWQga3JiNSBzZXR0aW5n
cywgd2Ugbm90aWNlZA0KPiBhIHN1c3BpY2lvdXNseSBoaWdoIHJlZmNvdW50IG9uIHRoZSBhdXRo
X3JwY2dzcyBtb2R1bGUsIGRlc3BpdGUgYWxsIG9mIGl0cw0KPiBjb25zdW1lcnMgYWxyZWFkeSB1
bmxvYWRlZC4gSSB3YXNuJ3QgYWJsZSB0byBhbmFseXplIGFueSBmdXJ0aGVyIG9uIHRoZSBsaXZl
DQo+IHN5c3RlbSwgYnV0IGhhZCBhIGxvb2sgYXQgdGhlIGNvZGUgYWZ0ZXJ3YXJkcywgYW5kIGZv
dW5kIGEgcGF0aCB0aGF0IHNlZW1zDQo+IHRvIGxlYWsgcmVmZXJlbmNlcyBpZiB0aGUgbWVjaGFu
aXNtJ3MgYWNjZXB0KCkgb3Agc2h1dHMgZG93biBhIGNvbm5lY3Rpb24NCj4gZWFybHkuIEFsdGhv
dWdoIEkgY291bGRuJ3QgdmVyaWZ5LCB0aGlzIHNlZW0gdG8gYmUgYSBwbGF1c2libGUgZml4Lg0K
PiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gRGFuaWVsDQoNCkhpIERhbmllbC0NCg0KSSd2ZSBw
cm92aXNpb25hbGx5IGluY2x1ZGVkIHlvdXIgcGF0Y2ggaW4gbXkgTkZTRCBmb3ItcmMgdG9waWMg
YnJhbmNoDQpoZXJlOg0KDQpnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvY2VsL2xpbnV4LmdpdA0KDQpZb3VyIGJ1ZyByZXBvcnQgc2VlbXMgcGxhdXNpYmxlLCBi
dXQgSSBuZWVkIHRvIHRha2UgYSBjbG9zZXIgbG9vayBhdCB0aGF0DQpjb2RlIGFuZCB5b3VyIHBy
b3Bvc2VkIGNoYW5nZS4gV291bGQgdmVyeSBtdWNoIGxpa2UgdG8gaGVhciBmcm9tIG90aGVycywN
CnRvby4NCg0KDQo+IG5ldC9zdW5ycGMvc3ZjLmMgfCA2ICsrKystLQ0KPiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25l
dC9zdW5ycGMvc3ZjLmMgYi9uZXQvc3VucnBjL3N2Yy5jDQo+IGluZGV4IDYxZmI4YTE4NTUyYy4u
ZDc2ZGM5ZDk1ZDE2IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3N2Yy5jDQo+ICsrKyBiL25l
dC9zdW5ycGMvc3ZjLmMNCj4gQEAgLTE0MTMsNyArMTQxMyw3IEBAIHN2Y19wcm9jZXNzX2NvbW1v
bihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3Qga3ZlYyAqYXJndiwgc3RydWN0IGt2ZWMg
KnJlc3YpDQo+IA0KPiAgc2VuZGl0Og0KPiAJaWYgKHN2Y19hdXRob3Jpc2UocnFzdHApKQ0KPiAt
CQlnb3RvIGNsb3NlOw0KPiArCQlnb3RvIGNsb3NlX3hwcnQ7DQo+IAlyZXR1cm4gMTsJCS8qIENh
bGxlciBjYW4gbm93IHNlbmQgaXQgKi8NCj4gDQo+IHJlbGVhc2VfZHJvcGl0Og0KPiBAQCAtMTQy
NSw2ICsxNDI1LDggQEAgc3ZjX3Byb2Nlc3NfY29tbW9uKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAs
IHN0cnVjdCBrdmVjICphcmd2LCBzdHJ1Y3Qga3ZlYyAqcmVzdikNCj4gCXJldHVybiAwOw0KPiAN
Cj4gIGNsb3NlOg0KPiArCXN2Y19hdXRob3Jpc2UocnFzdHApOw0KPiArY2xvc2VfeHBydDoNCj4g
CWlmIChycXN0cC0+cnFfeHBydCAmJiB0ZXN0X2JpdChYUFRfVEVNUCwgJnJxc3RwLT5ycV94cHJ0
LT54cHRfZmxhZ3MpKQ0KPiAJCXN2Y19jbG9zZV94cHJ0KHJxc3RwLT5ycV94cHJ0KTsNCj4gCWRw
cmludGsoInN2Yzogc3ZjX3Byb2Nlc3MgY2xvc2VcbiIpOw0KPiBAQCAtMTQzMyw3ICsxNDM1LDcg
QEAgc3ZjX3Byb2Nlc3NfY29tbW9uKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBrdmVj
ICphcmd2LCBzdHJ1Y3Qga3ZlYyAqcmVzdikNCj4gZXJyX3Nob3J0X2xlbjoNCj4gCXN2Y19wcmlu
dGsocnFzdHAsICJzaG9ydCBsZW4gJXpkLCBkcm9wcGluZyByZXF1ZXN0XG4iLA0KPiAJCQlhcmd2
LT5pb3ZfbGVuKTsNCj4gLQlnb3RvIGNsb3NlOw0KPiArCWdvdG8gY2xvc2VfeHBydDsNCj4gDQo+
IGVycl9iYWRfcnBjOg0KPiAJc2Vydi0+c3Zfc3RhdHMtPnJwY2JhZGZtdCsrOw0KPiAtLSANCj4g
Mi4yNS4xDQo+IA0KPiANCj4gLS0gDQo+IFB1enpsZSBJVEMgRGV1dHNjaGxhbmQgR21iSA0KPiBT
aXR6IGRlciBHZXNlbGxzY2hhZnQ6IEVpc2VuYmFobnN0cmHDn2UgMSwgNzIwNzIgDQo+IFTDvGJp
bmdlbg0KPiANCj4gRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgU3R1dHRnYXJ0IEhSQiA3NjU4
MDINCj4gR2VzY2jDpGZ0c2bDvGhyZXI6IA0KPiBMdWthcyBLYWxsaWVzLCBEYW5pZWwgS29icmFz
LCBNYXJrIFByw7ZobA0KPiANCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
