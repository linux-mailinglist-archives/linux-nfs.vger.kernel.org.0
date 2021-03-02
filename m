Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7857632A952
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580778AbhCBSUU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:20:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56784 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382690AbhCBQUH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 11:20:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122FjWD9012965;
        Tue, 2 Mar 2021 15:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1FpwGNuiKqdJ64zSSYufRW9NCEBnUQR4xxeHtpJ3HdE=;
 b=rFSrwzB0+i5QbVhQ9AiwNPd4IqNxLu6PaPR1l8lYe/3+vEl3nFBVyTEHHBnjzdr23Vkc
 2NfScqH5txVXcX8XpKQn6r6UaYOhGZN+mwneXF0rk8iFuBgWd3zZ2Jerb4ZhOqBe+mBW
 e4OIgXHf/j8HQiHl4ug/Hjct+8NspA6Dieci+GGARtxUn+W5PQtJxjeZVTGsdPhXwQ3g
 4n6OBkwjlt9VnZ+BVJvX37mbJiZ9AjFTgFzcGXgS3SIiufh9QkzC/GbuH75SwaYdogbn
 9S+AvOyTNCqWb6npGjL3FYrsnD/o2LLyHAyYFfyQTxpskm5ZaHRjR5/71r2L1af5p6or 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36ybkb8739-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 15:48:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122Fj0LY159521;
        Tue, 2 Mar 2021 15:48:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 36yynparrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 15:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhR9iUOfZQYHK9WkniDWMdUsHjTt8C327j+ViftcwnIBA8jSiw/wrwlxp3cr7bdLbIaMXwWDpSievVDTBsH/eSUByVlJZ4ERZFxI6Nb13u94xk4RtDUcN+XgmzxBt5g+h3GRqYePPyMlgHUgwYVT9HCewxdWeawXQQHlRroLBfhhjRfxQOONozwVn6wDfQUVcNoKoW5CNzhLpwPucuCxhrIbQzTydOEKMjckt4a1u/u6yLs/m3Mv/rucSLudpkqWRXH0MjkspSBcmv4/VO8pOGN3K/GM4J+bk7aCogcYMaRPZ0kgv6VSk1V8oqoDPsqm9yIfFO44WJEvQb6faXaV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FpwGNuiKqdJ64zSSYufRW9NCEBnUQR4xxeHtpJ3HdE=;
 b=NSLmJgT5YXdmMtiqWyzCQKRSAZiaVAHESR9dec38tZsbOHy8SwrW61eCVtrYYnQf35whcE4QWd7JeOnlLPHAL1bNztV6HEOc3gKtWQdVYwmCjZXPnXSiJEDUyjSI78xVXSktCe5wskowDRIe4QcwRZrcJoScta3bjtrGH5JsDoJZuGZvUSX9+LalS1X8uHnh+fY6nf1Vsf7JpJU/XBkxBjhjpCs1rDVLzStAnK6U350zZRJGAG6Uxkk3CYGjF/yPxinG83KCHED+IYMWBM+GOq41J/2BluY80CR/y/6ZQhfuf7xCPWlsKGsM6eHH/GKpxyhDsBdtexc6rjrWEhaQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FpwGNuiKqdJ64zSSYufRW9NCEBnUQR4xxeHtpJ3HdE=;
 b=odOtxG2xLYYUrd+7wnReIq4qIg4fHlhaNzbhBD+Ra+aGXp8tbJOdWaK5Kn/HOLVpnz3uXNl/3S53cRv+jjVy/Q7Z0yiRXAwJ1LXL+ocfW0wpwG+ynxEmDN5p6ZnIEiw/kLHhsvTEeBIdWKGT8Z6+17JlD/99iYyeNdY72D7yl7c=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4275.namprd10.prod.outlook.com (2603:10b6:a03:210::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 15:48:07 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.030; Tue, 2 Mar 2021
 15:48:07 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Daniel Kobras <kobras@puzzle-itc.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Topic: [PATCH] sunrpc: fix refcount leak for rpc auth modules
Thread-Index: AQHXDJPLGG4N2gFkYEKpGIw1cGBThqpvQ6UAgAAS+wCAABUlgIABL6oAgABCSAA=
Date:   Tue, 2 Mar 2021 15:48:06 +0000
Message-ID: <3F1B347F-B809-478F-A1E9-0BE98E22B0F0@oracle.com>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
 <20210301162820.GB11772@fieldses.org>
 <F2DE890D-C2D7-476A-AF6F-949B105728E9@oracle.com>
 <61920dd6-31d6-b12a-9a9b-7e7a662a12c3@puzzle-itc.de>
In-Reply-To: <61920dd6-31d6-b12a-9a9b-7e7a662a12c3@puzzle-itc.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: puzzle-itc.de; dkim=none (message not signed)
 header.d=none;puzzle-itc.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cefe606a-3a1b-47e9-8d1a-08d8dd9292c5
x-ms-traffictypediagnostic: BY5PR10MB4275:
x-ms-exchange-minimumurldomainage: puzzle-itc.de#0
x-microsoft-antispam-prvs: <BY5PR10MB42754AC222269C8420DA9E7F93999@BY5PR10MB4275.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0rE/OnET7TuBdHSkK290yrpMQqTfUNV61Lk86PsRuo1ADOUMSaebHWtBYZgKBx8RA68reLDctnZ5Wy1Jq99cabDclyM25vc9t2+7eMXiSTjG91ic6vHT8kewPVWNGPAmCJPmxxn8acoy8tfLBmyErr1uciqE0IgVEJQCCCNTJNpfXpbJOL8bhbm32m2IFOVd+miAD/IaMnlFJHcSN2XB9+O6ZXkzxUtMOxS0P+1IWYcM/vFYllEHRNly2Zpdtikx9mtjHoVUsPONG/jWFeOaf67QdoZlfklMj8mYOmbQMc3w9XA/aJ5/4201XLgc1YPr2Bn5RwFn/UXz70UrHpjhwafES74c5fD6CJPWSUHkP55ABVl7P4zXKNTWmmMGHW74QWzSaB1+8jJcxw5JiPC0XuYvvvctps3jknJUj1tJVUg/2j2wI/qYWL42oU9ZtCdOiU9T57sbLh2canPAXjxLtQGLhjCW6F9poPsCZBnZhFT2kwcqLKR2O0BlHaUejbudGDsuGA4nghONhPrLkpkmexYm0nCeCDs6hqxu8+mykQ75l98x5xtTJPqMd2UehsaLxYjHVA+B7WhLpouNSSYPO3RtmLi5eOqf1xbVhj8MYl68QKZIDJGu7gKtnr2kXTquYHybAN3HgcBzu/sjqDvND3ImPdjKLMJVteMNmJNHYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(66556008)(91956017)(64756008)(66476007)(83380400001)(186003)(76116006)(6512007)(66446008)(66946007)(15974865002)(26005)(6506007)(53546011)(71200400001)(66574015)(478600001)(54906003)(8676002)(2906002)(6486002)(44832011)(4326008)(33656002)(316002)(6916009)(86362001)(2616005)(5660300002)(8936002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RDBXWUlYczlybUx0MDVtSzFGZ2hLNkxZZGJrM25XeE4zOGQ5Z0hEVjdpMGxl?=
 =?utf-8?B?VmdCd21IUFFXRlhheWlETDBmRkxaMXRDZ3hSZWYrQXd5cGVuK3BBS3dublJm?=
 =?utf-8?B?a3F4RktQSFBlSjEzRkJhaUZMMUZ2WVhabDdLWld3RXhaWVZjOEYyOGNrV0Rm?=
 =?utf-8?B?QzlDL1JPamRRTHBJcVRabUZud29hS2dJT2dFL2wxS3dqQm12TXdpdmN0MHB1?=
 =?utf-8?B?eTVDRXcyWFVZNzliUUVDTU9FVWFvS2VVVGpwUXloUGtsOE1TaUNqNDNmNmZM?=
 =?utf-8?B?eEF3VGF2NXNVWlBkM1QreEdpcmxHbkxCTGZnVjFiVE1GdjNiNlVEZlZ0Njcv?=
 =?utf-8?B?NTdpUjYwZkhxQ09SbU1RRkx5U0NWRmNwak4xcDFtNThGQTBoRWVVU3dFTGln?=
 =?utf-8?B?ejNoSFlRaisybmJta3UvNHNSYmV0b2lHNllmNHhnL05MdndDS21vTTZsMngr?=
 =?utf-8?B?VHExUkFpL0hiVFlGQlR4N3NjaDBtU1R1aTNkMFM3Y3YxMk1aRFo4akh5Tzhh?=
 =?utf-8?B?UWlRL0J1WHdnM0RqTXpieXA2MVNybTFkc0dVd05KbU5rMEl3aTJIaHZNMStD?=
 =?utf-8?B?bFpEWWt5M1NxbVZuQWFsYndQWHRVUnAvTnRQQWl5ckt4NnlyU0dlSXNGME9L?=
 =?utf-8?B?aVhUNWZ1MVVFTzkyajNnWUVuTkJ6dGtzK1VoRHoxQWZpZmtQSFRTdEVrZnpx?=
 =?utf-8?B?SFppYSswdEdkeGZ6UEdpS3ExV01SaFJLdEJwcHAxZzdOY3p1Z3JEcVRVUE5z?=
 =?utf-8?B?L0lyNllJZU1SYzVaUHNVUFEreFI0eDJSNzNOR0pzai9VVXZnV2JnamhHeVJR?=
 =?utf-8?B?RVZkVy9uaml4NThqTDZQRmZQYWRScWJkQWhVdzh6WitJdmliNEVwRVhvTTJC?=
 =?utf-8?B?cEd0ODhMTVJUSG83WTVXVDJRWnVFcTVQWnV3NXd3cUJlZVNneGhPc2xTR3A5?=
 =?utf-8?B?VS9Rc3hUNStRQ3RiOFB4UkZuRlV6bExYR3Q2aG9GOEZKbHd0UHV2ejN3K09X?=
 =?utf-8?B?QjhJeVI3NEVxUzhvbFMxRjhBY1ljazFLeTIvekN4UFZ2Z1I0WmZlMi9VSUpF?=
 =?utf-8?B?cXBHN0VodjYzZU5kckdlR0Jadjhkb0Y2SkwrQUZGQmhpVUNJZ0NmNXhsQkxh?=
 =?utf-8?B?Rk1pUjQwaTJMWTVTQnhZa1pGQUdMY0FxMW9ObUFLcFFMQVF6c2xIOURwZE1q?=
 =?utf-8?B?ZEpqVUJLQ0pQUEpsMFpVNDhVQ3A5N2ZHOGkvN2tzMTV2RW4xTVZzSXdxaHBC?=
 =?utf-8?B?RlBRRDJ3a1lkQ0lOdGtUUlpaUHBjU0RSM3lvZ3gvOEN2QU1HMmZXR3Q1NURY?=
 =?utf-8?B?d2Q4dUpQc3QvS01RSUdCbWFlYXg0UFF0aC96dGd6TlNRNjZtazMremNqdzFU?=
 =?utf-8?B?c2JzcXdkZzhMbVFwalh2MHFUM3E5YWlSKzRrYiswcFNQcmVwb0dDanhGS1Rr?=
 =?utf-8?B?c3dRQm9wUVlWeDNBV2Rvdm1Od3RVeGIxZk5MdDVFang2QjQ4NjNqVEErbThC?=
 =?utf-8?B?Wm8xZC85MzcrWWdVMFZVd2RvL3lwaHlrTGlrK0I1akhpR1lJLy85Zk1xVEJs?=
 =?utf-8?B?Rks5NE1HT3pXR3hrRnBSQjAzalRZT3A0RWNWRlFEQlBEdzl1Z0NvVlYvY3VJ?=
 =?utf-8?B?YUdhRHhJMXF1T0FtNmVoSnpHRVVtdnd2NDg5amtQNEU4ZEJlTXowVk9Ra25E?=
 =?utf-8?B?RU8vdnBRZ21lV2QxVXlyNkVWT2tlL0ZzU3pCM2NIMUtjQ1F5TFRvUHJySXpi?=
 =?utf-8?Q?3e76xaB/CAMAoJuThTTqMY8VLoDtLmvtGwrBUYA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <81B330A06A47D0439B0F7A59816B3C6B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefe606a-3a1b-47e9-8d1a-08d8dd9292c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 15:48:06.9194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHWWZX73JZVaw/n+v2shORWldySgTofuLeCFeCNWGR/e0wMBgF5/2nv6cWwo29KgwMmT23Xu79rU0aa95eHmxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4275
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020126
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RXhjZWxsZW50LCBEYW5pZWwuIFRoYW5rcyBmb3IgZm9sbG93aW5nIHVwISBJIHdpbGwgYWRkIGEg
TGluazogdGFnDQp0byB0aGlzIHRocmVhZCBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQoNCg0K
PiBPbiBNYXIgMiwgMjAyMSwgYXQgNjo1MCBBTSwgRGFuaWVsIEtvYnJhcyA8a29icmFzQHB1enps
ZS1pdGMuZGU+IHdyb3RlOg0KPiANCj4gSGkgYWxsIQ0KPiANCj4gQW0gMDEuMDMuMjEgdW0gMTg6
NDQgc2NocmllYiBDaHVjayBMZXZlcjoNCj4+PiBPbiBNYXIgMSwgMjAyMSwgYXQgMTE6MjggQU0s
IEJydWNlIEZpZWxkcyA8YmZpZWxkc0BmaWVsZHNlcy5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9u
IE1vbiwgTWFyIDAxLCAyMDIxIGF0IDAzOjIwOjI0UE0gKzAwMDAsIENodWNrIExldmVyIHdyb3Rl
Og0KPj4+PiANCj4+Pj4+IE9uIEZlYiAyNiwgMjAyMSwgYXQgNjowNCBQTSwgRGFuaWVsIEtvYnJh
cyA8a29icmFzQHB1enpsZS1pdGMuZGU+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBJZiBhbiBhdXRo
IG1vZHVsZSdzIGFjY2VwdCBvcCByZXR1cm5zIFNWQ19DTE9TRSwgc3ZjX3Byb2Nlc3NfY29tbW9u
KCkNCj4+Pj4+IGVudGVycyBhIGNhbGwgcGF0aCB0aGF0IGRvZXMgbm90IGNhbGwgc3ZjX2F1dGhv
cmlzZSgpIGJlZm9yZSBsZWF2aW5nIHRoZQ0KPj4+Pj4gZnVuY3Rpb24sIGFuZCB0aHVzIGxlYWtz
IGEgcmVmZXJlbmNlIG9uIHRoZSBhdXRoIG1vZHVsZSdzIHJlZmNvdW50LiBIZW5jZSwNCj4+Pj4+
IG1ha2Ugc3VyZSBjYWxscyB0byBzdmNfYXV0aGVudGljYXRlKCkgYW5kIHN2Y19hdXRob3Jpc2Uo
KSBhcmUgcGFpcmVkIGZvcg0KPj4+Pj4gYWxsIGNhbGwgcGF0aHMsIHRvIG1ha2Ugc3VyZSBycGMg
YXV0aCBtb2R1bGVzIGNhbiBiZSB1bmxvYWRlZC4NCj4+Pj4+IA0KPj4+Pj4gRml4ZXM6IDRkNzEy
ZWYxZGIwNSAoInN2Y2F1dGhfZ3NzOiBDbG9zZSBjb25uZWN0aW9uIHdoZW4gZHJvcHBpbmcgYW4g
aW5jb21pbmcgbWVzc2FnZSIpDQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgS29icmFzIDxr
b2JyYXNAcHV6emxlLWl0Yy5kZT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gSGkhDQo+Pj4+PiANCj4+Pj4+
IFdoaWxlIGRlYnVnZ2luZyBORlMgb24gYSBzeXN0ZW0gd2l0aCBtaXNjb25maWd1cmVkIGtyYjUg
c2V0dGluZ3MsIHdlIG5vdGljZWQNCj4+Pj4+IGEgc3VzcGljaW91c2x5IGhpZ2ggcmVmY291bnQg
b24gdGhlIGF1dGhfcnBjZ3NzIG1vZHVsZSwgZGVzcGl0ZSBhbGwgb2YgaXRzDQo+Pj4+PiBjb25z
dW1lcnMgYWxyZWFkeSB1bmxvYWRlZC4gSSB3YXNuJ3QgYWJsZSB0byBhbmFseXplIGFueSBmdXJ0
aGVyIG9uIHRoZSBsaXZlDQo+Pj4+PiBzeXN0ZW0sIGJ1dCBoYWQgYSBsb29rIGF0IHRoZSBjb2Rl
IGFmdGVyd2FyZHMsIGFuZCBmb3VuZCBhIHBhdGggdGhhdCBzZWVtcw0KPj4+Pj4gdG8gbGVhayBy
ZWZlcmVuY2VzIGlmIHRoZSBtZWNoYW5pc20ncyBhY2NlcHQoKSBvcCBzaHV0cyBkb3duIGEgY29u
bmVjdGlvbg0KPj4+Pj4gZWFybHkuIEFsdGhvdWdoIEkgY291bGRuJ3QgdmVyaWZ5LCB0aGlzIHNl
ZW0gdG8gYmUgYSBwbGF1c2libGUgZml4Lg0KPj4+Pj4gDQo+Pj4+PiBLaW5kIHJlZ2FyZHMsDQo+
Pj4+PiANCj4+Pj4+IERhbmllbA0KPj4+PiANCj4+Pj4gSGkgRGFuaWVsLQ0KPj4+PiANCj4+Pj4g
SSd2ZSBwcm92aXNpb25hbGx5IGluY2x1ZGVkIHlvdXIgcGF0Y2ggaW4gbXkgTkZTRCBmb3ItcmMg
dG9waWMgYnJhbmNoDQo+Pj4+IGhlcmU6DQo+Pj4+IA0KPj4+PiBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2VsL2xpbnV4LmdpdA0KPj4+PiANCj4+Pj4gWW91
ciBidWcgcmVwb3J0IHNlZW1zIHBsYXVzaWJsZSwgYnV0IEkgbmVlZCB0byB0YWtlIGEgY2xvc2Vy
IGxvb2sgYXQgdGhhdA0KPj4+PiBjb2RlIGFuZCB5b3VyIHByb3Bvc2VkIGNoYW5nZS4gV291bGQg
dmVyeSBtdWNoIGxpa2UgdG8gaGVhciBmcm9tIG90aGVycywNCj4+Pj4gdG9vLg0KPj4+IA0KPj4+
IFNvLCB0aGUgZWZmZWN0IG9mIHRoaXMgaXMgdG8gY2FsbCBzdmNfYXV0aG9yaXNlIG1vcmUgb2Z0
ZW4uICBJIHRoaW5rDQo+Pj4gdGhhdCdzIGFsd2F5cyBzYWZlLCBiZWNhdXNlIHN2Y19hdXRob3Jp
c2UgaXMgYSBuby1vcCB1bmxlc3MgcnFfYXV0aG9wcw0KPj4+IGlzIHNldCwgaXQgY2xlYXJzIHJx
X2F1dGhvcHMgaXRzZWxmLCBhbmQgcnFfYXV0aG9wcyBiZWluZyBzZXQgaXMgYQ0KPj4+IGd1YXJh
bnRlZSB0aGF0IC0+YWNjZXB0KCkgYWxyZWFkeSByYW4uDQo+Pj4gDQo+Pj4gSXQncyBoYXJkZXIg
dG8ga25vdyBpZiB0aGlzIHNvbHZlcyB0aGUgcHJvYmxlbSwgYXMgSSBzZWUgYSBsb3Qgb2Ygb3Ro
ZXINCj4+PiBtZW50aW9ucyBvZiBUSElTX01PRFVMRSBpbiBzdmNhdXRoX2dzcy5jLg0KPj4gDQo+
PiBQZXJoYXBzIGEgZGVlcGVyIGF1ZGl0IGlzIG5lY2Vzc2FyeS4NCj4+IA0KPj4gQSBzbWFsbCBj
b2RlIGNoYW5nZSB0byBpbmplY3QgU1ZDX0NMT1NFIHJldHVybnMgYXQgcmFuZG9tIHdvdWxkIGVu
YWJsZQ0KPj4gYSBtb3JlIGR5bmFtaWMgYW5hbHlzaXMuDQo+IA0KPiBJJ3ZlIG1hbmFnZWQgdG8g
Y29tZSB1cCB3aXRoIHNpbXBsZSByZXByb2R1Y2VyIGZvciB0aGlzIGJ1ZzoNCj4gDQo+IE9uIGEg
d29ya2luZyBrcmI1IE5GUyBtb3VudCBmcm9tIGEgdGVzdCBjbGllbnQsIGNoZWNrIHdoaWNoIGVu
Y3R5cGUgaXMNCj4gdXNlZCBpbiB0aGUgdGlja2V0IGZvciB0aGUgTkZTIHNlcnZpY2UuIFRoZW4g
dW5tb3VudCwgYW5kIGV4Y2x1ZGUgdGhpcw0KPiBlbmN0eXBlIGZyb20gcGVybWl0dGVkX2VuY3R5
cGVzIGluIHRoZSBzZXJ2ZXIncyAvZXRjL2tyYjUuY29uZi5bKl0NCj4gVHJ5aW5nIHRvIG1vdW50
IGFnYWluIGZyb20gdGhlIHRlc3QgY2xpZW50IHNob3VsZCBub3cgZmFpbCAoRVBFUk0pLCBhbmQN
Cj4gZWFjaCBtb3VudCBhdHRlbXB0IGluY3JlYXNlcyB0aGUgcmVmY291bnQgb2YgdGhlIHNlcnZl
cidzIGF1dGhfcnBjZ3NzDQo+IG1vZHVsZSAoYnkgMjIgaW4gbXkgdGVzdCkuDQo+IA0KPiBFeGNo
YW5naW5nIHN1bnJwYy5rbyBmb3IgYSB2ZXJzaW9uIHdpdGggdGhlIHBhdGNoIGFwcGxpZWQsIGFu
ZA0KPiByZS1ydW5uaW5nIHRoZSBzYW1lIHRlc3QsIHRoZSByZWZjb3VudCByZW1haW5zIGNvbnN0
YW50IGluc3RlYWQuIFRoaXMNCj4gY29uZmlybXMgdGhlIGluaXRpYWwgYW5hbHlzaXMsIGFuZCBp
bmRpY2F0ZXMgdGhlIGZpeCBpcyBhY3R1YWxseSBjb3JyZWN0Lg0KPiANCj4gWypdIEZvciBhIHF1
aWNrIHRlc3QgaW4gYSBzdGFuZGFyZCBzZXR1cCwgSSd2ZSB1c2VkDQo+ICAgICAgW2xpYmRlZmF1
bHRzXQ0KPiAgICAgIHBlcm1pdHRlZF9lbmN0eXBlcyA9IGFlczEyOC1jdHMtaG1hYy1zaGExLTk2
DQo+ICAgICAgKC4uLikNCj4gICAgdG8gbWFrZSB0aGUgbm9ybWFsIEFFUzI1NiB0aWNrZXRzIGZh
aWwuIEEgbW9yZSByZWFsaXN0aWMgc2NlbmFyaW8NCj4gICAgd291bGQgYmUgYSBjbGllbnQgdGhh
dCdzIHJlc3RyaWN0ZWQgdG8gUkM0LCBhbmQgYSBzZXJ2ZXIgd2l0aA0KPiAgICBSQzQga2V5cyBv
biB0aGUgS0RDLCBidXQgb25seSBBRVMgYWxsb3dlZCBpbiBrcmI1LmNvbmYuIERlZmF1bHQNCj4g
ICAgYmVoYXZpb3VyIG9mIHR5cGljYWwgQUQgam9pbiB0b29scyBtYWtlcyBpdCBlYXN5IHRvIGVu
ZCB1cCBpbiBhDQo+ICAgIHNpdHVhdGlvbiBsaWtlIHRoaXMuDQo+IA0KPj4+IFBvc3NpYmx5IG9y
dGhvZ29uYWwgdG8gdGhpcyBwcm9ibGVtLCBidXQ6IHN2Y2F1dGhfZ3NzX3JlbGVhc2UNCj4+PiB1
bmNvbmRpdGlvbmFsbHkgZGVyZWZlcmVuY2VzIHJxc3RwLT5ycV9hdXRoX2RhdGEuICBJc24ndCB0
aGF0IGEgTlVMTA0KPj4+IGRlcmVmZXJlbmNlIGlmIHRoZSBrbWFsbG9jIGF0IHRoZSBzdGFydCBv
ZiBzdmNhdXRoX2dzc19hY2NlcHQoKSBmYWlscz8NCj4+PiANCj4+PiBGaW5hbGx5LCBzaG91bGQg
d2UgY2FyZSBhYm91dCBtb2R1bGUgcmVmZXJlbmNlIGxlYWtzPw0KPj4gDQo+PiBJIHdvdWxkIHBy
ZWZlciB0aGF0IG1vZHVsZSByZWZlcmVuY2UgY291bnRpbmcgd29yayBhcyBleHBlY3RlZC4gV2hl
biBpdA0KPj4gZG9lc24ndCB0aGF0IHRlbmRzIHRvIGxlYWQgdG8gcGVvcGxlIChzYXksIG1lKSBo
dW50aW5nIGZvciBidWdzIHRoYXQNCj4+IG1pZ2h0IGFjdHVhbGx5IGJlIHNlcmlvdXMuDQo+IA0K
PiBUaGUgcmVmY291bnQgbGVhayBpcyB0aGUgZWFzaWx5IHZpc2libGUgY29uc2VxdWVuY2UsIGJ1
dCB0aGUgc2tpcHBlZA0KPiBjYWxsIHRvIHN2Y2F1dGhfZ3NzX3JlbGVhc2UoKSBwcm9iYWJseSBh
bHNvIGxlYWtzIGEgc21hbGwgYW1vdW50IG9mDQo+IG1lbW9yeSBmb3IgZWFjaCByZXF1ZXN0LiBS
ZXBlYXRpbmcgdGhlIHRlc3QgY2FzZSBhYm92ZSBmb3IgYSBsb25nZXINCj4gcGVyaW9kIG9mIHRp
bWUgKGVnLiBieSB0aHJvd2luZyBhbiBhdXRvbW91bnRlciBpbnRvIHRoZSBtaXgpLCB0aGlzIG1p
Z2h0DQo+IGV2ZW50dWFsbHkgYmVjb21lIG5vdGljZWFibGUuDQo+IA0KPj4+IERvZXMgYW55b25l
IHJlYWxseSAqbmVlZCogdG8gdW5sb2FkIG1vZHVsZXM/DQo+PiANCj4+IEFueW9uZSB3aG8gd2Fu
dHMgdG8gcmVwbGFjZSB0aGUgbW9kdWxlIHdpdGggYSBuZXdlciBidWlsZCB0aGF0IGZpeGVzIGEN
Cj4+IGJ1Zy4gSXQgYXZvaWRzIGEgZnVsbCByZWJvb3QsIGFuZCBmb3Igc29tZSB0aGF0J3MgaW1w
b3J0YW50Lg0KPiANCj4gU3dpdGNoaW5nIGZyb20gcnBjLnN2Y2dzc2QgdG8gZ3NzcHJveHkgd2l0
aG91dCB0YWtpbmcgZG93biB0aGUgbWFjaGluZQ0KPiBhcyBhIHdob2xlIHdhcyB0aGUgc2l0dWF0
aW9uIHRoYXQgb3JpZ2luYWxseSBwcm9tcHRlZCBtZSB0byBsb29rIGludG8NCj4gdGhpcywgYnV0
IEkgYWRtaXQgdGhhdCdzIGEgcmF0aGVyIHJhcmUgdXNlIGNhc2UuDQo+IA0KPj4+IEFuZCB3aWxs
IGJhZCBzdHVmZiBoYXBwZW4gd2hlbiB0aGUNCj4+PiBjb3VudCBvdmVyZmxvd3MsIG9yIGRvZXMg
dGhlIG1vZHVsZSBjb2RlIGZhaWwgc2FmZWx5IHNvbWVob3cgaW4gdGhlDQo+Pj4gb3ZlcmZsb3cg
Y2FzZT8gIEkga25vdywgYnVncyBhcmUgYnVncywgSSBzaG91bGQgY2FyZSBhYm91dCBmaXhpbmcg
YWxsIG9mDQo+Pj4gdGhlbSwgc2hhbWUgb24gbWUuLi4uDQo+Pj4gDQo+Pj4gLS1iLg0KPj4+IA0K
Pj4+PiANCj4+Pj4gDQo+Pj4+PiBuZXQvc3VucnBjL3N2Yy5jIHwgNiArKysrLS0NCj4+Pj4+IDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+PiANCj4+
Pj4+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3N2Yy5jIGIvbmV0L3N1bnJwYy9zdmMuYw0KPj4+
Pj4gaW5kZXggNjFmYjhhMTg1NTJjLi5kNzZkYzlkOTVkMTYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9u
ZXQvc3VucnBjL3N2Yy5jDQo+Pj4+PiArKysgYi9uZXQvc3VucnBjL3N2Yy5jDQo+Pj4+PiBAQCAt
MTQxMyw3ICsxNDEzLDcgQEAgc3ZjX3Byb2Nlc3NfY29tbW9uKHN0cnVjdCBzdmNfcnFzdCAqcnFz
dHAsIHN0cnVjdCBrdmVjICphcmd2LCBzdHJ1Y3Qga3ZlYyAqcmVzdikNCj4+Pj4+IA0KPj4+Pj4g
c2VuZGl0Og0KPj4+Pj4gCWlmIChzdmNfYXV0aG9yaXNlKHJxc3RwKSkNCj4+Pj4+IC0JCWdvdG8g
Y2xvc2U7DQo+Pj4+PiArCQlnb3RvIGNsb3NlX3hwcnQ7DQo+Pj4+PiAJcmV0dXJuIDE7CQkvKiBD
YWxsZXIgY2FuIG5vdyBzZW5kIGl0ICovDQo+Pj4+PiANCj4+Pj4+IHJlbGVhc2VfZHJvcGl0Og0K
Pj4+Pj4gQEAgLTE0MjUsNiArMTQyNSw4IEBAIHN2Y19wcm9jZXNzX2NvbW1vbihzdHJ1Y3Qgc3Zj
X3Jxc3QgKnJxc3RwLCBzdHJ1Y3Qga3ZlYyAqYXJndiwgc3RydWN0IGt2ZWMgKnJlc3YpDQo+Pj4+
PiAJcmV0dXJuIDA7DQo+Pj4+PiANCj4+Pj4+IGNsb3NlOg0KPj4+Pj4gKwlzdmNfYXV0aG9yaXNl
KHJxc3RwKTsNCj4+Pj4+ICtjbG9zZV94cHJ0Og0KPj4+Pj4gCWlmIChycXN0cC0+cnFfeHBydCAm
JiB0ZXN0X2JpdChYUFRfVEVNUCwgJnJxc3RwLT5ycV94cHJ0LT54cHRfZmxhZ3MpKQ0KPj4+Pj4g
CQlzdmNfY2xvc2VfeHBydChycXN0cC0+cnFfeHBydCk7DQo+Pj4+PiAJZHByaW50aygic3ZjOiBz
dmNfcHJvY2VzcyBjbG9zZVxuIik7DQo+Pj4+PiBAQCAtMTQzMyw3ICsxNDM1LDcgQEAgc3ZjX3By
b2Nlc3NfY29tbW9uKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBrdmVjICphcmd2LCBz
dHJ1Y3Qga3ZlYyAqcmVzdikNCj4+Pj4+IGVycl9zaG9ydF9sZW46DQo+Pj4+PiAJc3ZjX3ByaW50
ayhycXN0cCwgInNob3J0IGxlbiAlemQsIGRyb3BwaW5nIHJlcXVlc3RcbiIsDQo+Pj4+PiAJCQlh
cmd2LT5pb3ZfbGVuKTsNCj4+Pj4+IC0JZ290byBjbG9zZTsNCj4+Pj4+ICsJZ290byBjbG9zZV94
cHJ0Ow0KPj4+Pj4gDQo+Pj4+PiBlcnJfYmFkX3JwYzoNCj4+Pj4+IAlzZXJ2LT5zdl9zdGF0cy0+
cnBjYmFkZm10Kys7DQo+Pj4+PiAtLSANCj4+Pj4+IDIuMjUuMQ0KPj4+Pj4gDQo+Pj4+PiANCj4+
Pj4+IC0tIA0KPj4+Pj4gUHV6emxlIElUQyBEZXV0c2NobGFuZCBHbWJIDQo+Pj4+PiBTaXR6IGRl
ciBHZXNlbGxzY2hhZnQ6IEVpc2VuYmFobnN0cmHDn2UgMSwgNzIwNzIgDQo+Pj4+PiBUw7xiaW5n
ZW4NCj4+Pj4+IA0KPj4+Pj4gRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgU3R1dHRnYXJ0IEhS
QiA3NjU4MDINCj4+Pj4+IEdlc2Now6RmdHNmw7xocmVyOiANCj4+Pj4+IEx1a2FzIEthbGxpZXMs
IERhbmllbCBLb2JyYXMsIE1hcmsgUHLDtmhsDQo+Pj4+PiANCj4+Pj4gDQo+Pj4+IC0tDQo+Pj4+
IENodWNrIExldmVyDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPiANCj4gS2luZCByZWdh
cmRzLA0KPiANCj4gRGFuaWVsDQo+IC0tIA0KPiBEYW5pZWwgS29icmFzDQo+IFByaW5jaXBhbCBB
cmNoaXRlY3QNCj4gUHV6emxlIElUQyBEZXV0c2NobGFuZA0KPiArNDkgNzA3MSAxNDMxNiAwDQo+
IHd3dy5wdXp6bGUtaXRjLmRlDQo+IA0KPiAtLSANCj4gUHV6emxlIElUQyBEZXV0c2NobGFuZCBH
bWJIDQo+IFNpdHogZGVyIEdlc2VsbHNjaGFmdDogRWlzZW5iYWhuc3RyYcOfZSAxLCA3MjA3MiAN
Cj4gVMO8YmluZ2VuDQo+IA0KPiBFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBTdHV0dGdhcnQg
SFJCIDc2NTgwMg0KPiBHZXNjaMOkZnRzZsO8aHJlcjogDQo+IEx1a2FzIEthbGxpZXMsIERhbmll
bCBLb2JyYXMsIE1hcmsgUHLDtmhsDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg0K
