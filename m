Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0C32C6CB
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451115AbhCDAaF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:30:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbhCDAKs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 19:10:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123LVpMb082386;
        Wed, 3 Mar 2021 21:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pvwVndGjlPH51zB0dP4SWFkxCfKMzJKeOUxoPNoEVl4=;
 b=SL+XQVyHM6Wir0Hqmeqe/YT3xVFIMm53y9b/UO4i0vvtVv24kZ/Fyy8U0WlbZYDmer8J
 LYVPqz2+gmZmf0his8bGPwo5zHJf1qTYwJMfVreH7j0pwzPHXBlxqr1h7QFODrinN4J8
 GT3RFM0xIjZ9BnYPGff1xlvr+iSTSpmB9CW9NDs0CzLPQfUhKV92mmUASvmWthQxOsgy
 bLkregVsIia2dwZMvP3pv9xLvR/0KE1yuEGoffAn+9n9g/iHQ8wmOUsRIfg4WSURVU1n
 0fi3tsSq14sFwz340Ep7+r+fD6eCy0guEuKga8AxybKsXMeFagkIoOVpD8+R6fzpz0Io Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3726v7ajjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 21:35:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123LV6mI142566;
        Wed, 3 Mar 2021 21:35:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3020.oracle.com with ESMTP id 370001twdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 21:35:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajzfT6E8EwrLg+BCptHtHA9UqR6WmajtvoYQ1i2WqJnOb8bxf9wBA+ro9dsCvTn5t8qLlznLBfzcl4BmDdgNAquWBtMbDtgU5X0qWq47URMsdGYbq9RytHhkAyzs99d10Byot0cSgbrlW5ge2WmZflz2QCpFYjpDEx+GM+JgKaoVxQAaLw8PR0kCwP+m7sr7tRglFDDlI7DFiMN1M8TeJyGwsPfvPJBYTMjvV0s5Ei+si4j7Zn0zdblKDEKxXehAKh21zEV+rZqmPPn0TRezxG2WWdYfdzieKgrW2hx9iwxApMFaeSIorwdgmAedEG/swX2YqpuH1aZjV14gQTNxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvwVndGjlPH51zB0dP4SWFkxCfKMzJKeOUxoPNoEVl4=;
 b=HkC7Bho/2LcHBoLaEqIwJLRxz36KWRyDW5t1qBpsEqhpKZlSre2hhZAuHy1hPTYtJiM0D7VvyVnNBLeLn+BC8l6hpRZKG8k4Q49VSLWK46uPbMIQaxGLdQno4YO9P17Ls/AX04Mv4HG8Y7q2V1/PVNs49gpw9Kf/SwYPvwi0ntV60nNc0UwSMj0B/5ffYSpMP4pn/t5VMcuYsuosLVo6cINNHwFDV5VbOuDKCjlKOb/bLbt3o734wZSjejtKITS5rWD8cMEHP7oz1ONk/PXhsDzZd+BRRZ0jwqvHS2kYDrGXIZseK28UQmV2K8239U2lMx1VxEn/qif4jAzeJgyoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvwVndGjlPH51zB0dP4SWFkxCfKMzJKeOUxoPNoEVl4=;
 b=lYJyXClcdqZZR3N9Jap8n5uxJBk9lG3soz6NhQmRtJ14OR4+UUQzLKnAUHY+xyp8cdUPS4OKtqz4EK6qPDxp1rq/2Mf0/r7Puh5HBWs2WfS6u1I1XrxuwCHExkDIc/nPnLS5yfx2Gtb0u57PKkb8HU5W6lVtJpLPaYikEYCp5FE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2918.namprd10.prod.outlook.com (2603:10b6:a03:8c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 21:35:18 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 21:35:18 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: helper for laundromat expiry calculations
Thread-Topic: [PATCH] nfsd: helper for laundromat expiry calculations
Thread-Index: AQHXD3s3GSu7nxFDKU+a9rc0Y7q7iqpyyz8A
Date:   Wed, 3 Mar 2021 21:35:18 +0000
Message-ID: <AC0F5679-8B32-4D75-B28B-67171027B70D@oracle.com>
References: <20210302154623.GA2263@fieldses.org>
In-Reply-To: <20210302154623.GA2263@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 561c11ec-9d06-437b-8e85-08d8de8c3dca
x-ms-traffictypediagnostic: BYAPR10MB2918:
x-microsoft-antispam-prvs: <BYAPR10MB2918E03557913E65C977755493989@BYAPR10MB2918.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rIDCpvPpGB0Gt3Y2g2VchAgb7lK0w4Up2EmvXQMQXRqIESccPaG1ji44rmfnrNH/epib5ihu1u8nsFJs03YoUWK56k6f9XVZVoGLECAv3327jtRxoCtzfvDpttNw9IHc+Va2zW/phbuwEFbkRYSu0Xx0i97Zz9jSxXKKKJYg15swx7HkIOfq4Rj+OPKNr515OENUD3xhy6q/vYrM9NyE+GnEhOVJwEiVITDXM7NF4gFiwq0gXTZR68XZtD7enOiEZxGHLwsqrM0pRCGmXyueipLtnt0gG+KPiEyVY6ufeDssbfJ+jyDGgTCcCR64TchZcxUzEOwokgaBMNTh5z6EwnKOi5s4q1p2SNXnzrQmBkZQR9De3anYEOXILUs5gEEs5tN7EqixGiIlD2bNxj30AGKJnrWRzI29UgIgo7Z0IJfXGbVklfS8deVNkcGrlVkzEurFaZM27NDYXT3yJQIj7K24yYnZJlt5s1VdHcg/OZjLyAjBq/3BrO9eyPTRFoz3aI9Tq3d6/wTqtPCFakxgJYWy60Rh+KNEXjgshFZaRWCrZHnTFr1erhBKSOb5pBf0lnow5bNauw7ymPkA+p0CBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(6512007)(33656002)(316002)(2906002)(2616005)(83380400001)(8936002)(8676002)(26005)(186003)(6916009)(4326008)(36756003)(53546011)(5660300002)(66476007)(66946007)(76116006)(6506007)(66446008)(66556008)(64756008)(86362001)(478600001)(91956017)(44832011)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RlpDRVNtekVXcUxmdFdFTkZiRGtJMWt1ZFQ3TnhDQXVqTVBIVVZYbzBwdFhU?=
 =?utf-8?B?R3ZpbE5wd1AwYW9HZ0NsRldqZE5CbXovT1lOZFUyTkZ6elVBUS9Hd3ZvNVI0?=
 =?utf-8?B?SGZDa2lNdktQUTNoWEJNVnFhVlZXL1pqS1ZuQ24rSGtMV25HMDliTStVTmor?=
 =?utf-8?B?UkpXak83UmkzcER6ZjVGRHRZTnBKV1FlYzREeERuR2t5blpnczliL2VGaU5u?=
 =?utf-8?B?SVJZa1R4V1E1Z01haHBqY2krT21qRjhDMEZIKytyUlVHL0FQSHNWdjI5TzZi?=
 =?utf-8?B?TjRqVTNNNDB3MVM0ajNDcXYwdGhJa0xXSDB1ZG9QWUlScjFhSzlEeVFWd2pl?=
 =?utf-8?B?ZGx2b2RGMWhzODNTNGQ1WVhXV3pHbmNNTnJGdnAwclNsOFEyOXM4aVZRMTBJ?=
 =?utf-8?B?MHIxakdsbHNCbDREL29NQytMYnZ5MWlsK3pMSnBpRkRTeldGSHdibDZwZUJL?=
 =?utf-8?B?dzl0N2FTeG9Pd2wyVUZpMkFYa3BaVFhSdmNpYkRuT2hyYjlBaStsU3paS0ZZ?=
 =?utf-8?B?WCtqTE51dDJiNUR1RmRTN0x2QXYvQ3g2NVhaS2EwTTYxbEZWank5UmsxOUZr?=
 =?utf-8?B?WUlldWdYYkdhSkhCSHIzeWNKbm5iTFl2R1llRjRaMzBYbVRxTXlJQlJKMHhz?=
 =?utf-8?B?T0IzeFBGWm9ONzl1Q0RFcmNJTmc2Qjh6RDJXUTltYnNJVnk1VDM5OTFZZlpm?=
 =?utf-8?B?aEZoTmxtSk5WL2VrRjlmMllneG5DSUo5c1gwZ1NRUUt4emxsbzF6TW1uRm4r?=
 =?utf-8?B?Tzc3Q21GWkR1Wkc5VVlBak9DbEpJMnBMNjBQaXJ2b00xclhmOFY0REVqV3N4?=
 =?utf-8?B?b0JhMERXc214YVZEME5hemdPaDd0aDgyWjZ0WS8xaDNzYlJHb2JwTUttZFVF?=
 =?utf-8?B?TzVBZTlXWGorSld1cHhlcGhMR3hlb0xVOERramdrS3pYb2w1Z1czNkEvMXRO?=
 =?utf-8?B?TFBpbnhMT1U0eVdjVlNOcnNvQlNXai9zamFLaDd0SXAwZ0tpazN5eDVveGxT?=
 =?utf-8?B?d0pRRFRHWlBPVEs4RGtJSkhCMFhvYUgyS1dPd2JrbE9DVndBL2JxMEM3bkdr?=
 =?utf-8?B?d0N0N1JzM3h1T3pWcWVGM0J4ejQvR010eU1LQ1E3VjRVNTUvTTRhc3YvVGNT?=
 =?utf-8?B?YWNVakYxaWxWODFqU2Y2dWV4OW9mOTIrWUNCVmtqUUlBSkhlNWRrT0d0NTMv?=
 =?utf-8?B?enVHT05lMGQ3RWNwNklVY0tOeExmNVYySVRhazg4K3dvOVNqZEN0TXA4Zjha?=
 =?utf-8?B?MEZYWG00aWFhWlhHb3BKcnZueERhdFB4L05GT1djVFZ6b2dRTTRROWhta0R6?=
 =?utf-8?B?SU1nWTZHZlNidTFmNzJSTlFTMGZHVWFDMEtic1BNWTA4UFYwV2ZtZzJsY2ky?=
 =?utf-8?B?dXZuMm4wZEpYcXh2VzM2VEpXVUsxYzN4ZEFnMTVMMHE5b1IvK3FxRlYxaDRr?=
 =?utf-8?B?OXF3bVdBLzZnbmNNRlE0cFNuWFZLOCtaMVFsQjVWcUM3V2Z2THZYY1ppSlh4?=
 =?utf-8?B?dnZKT0ExUUNzS0xJUnRKclFxM0JFVDYyQ0RnSzlnR2pnZlVRQ1NmOGlvK3Jm?=
 =?utf-8?B?dVNoZHU3cVdIYTJDeG90MFl1VjdBR2IrVWRHQS9JQW0wY0xLbEN2T21odXRa?=
 =?utf-8?B?dnBOZy9IK0ZEQnk1ejNhUWYwNTJ0cHNzb0M4OGg5MHhKeHA0U2NMMU9rZ1Aw?=
 =?utf-8?B?c0thUThQVTR4ZW1iSmV2M2JBNDVyZnZmeUl5VUxISkYwcjhVd3E4cGtrZFpO?=
 =?utf-8?B?ais5YmdKODBIenNzNkovM0xrYmlXT2ZRV2RGTmxJL29sSmdTWkRlUWtXMFJC?=
 =?utf-8?B?eGVzTXNjVFdRZk9tY0hFQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CDCC0A677D8C54BADB54A83D7D6C07C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561c11ec-9d06-437b-8e85-08d8de8c3dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:35:18.6059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJWZ327x/V22/glzyN8iKaUfndwrQ922sYbNjIVe5XBIQkzlfc2y1e4utPu4urj/bKxUEXdmW+zR3zBv8Mq3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2918
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030153
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDIsIDIwMjEsIGF0IDEwOjQ2IEFNLCBCcnVjZSBGaWVsZHMgPGJmaWVsZHNA
ZmllbGRzZXMub3JnPiB3cm90ZToNCj4gDQo+IEZyb206ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmll
bGRzQHJlZGhhdC5jb20+DQo+IA0KPiBXZSBkbyB0aGlzIHNhbWUgbG9naWMgcmVwZWF0ZWRseSwg
YW5kIGl0J3MgZWFzeSB0byBnZXQgdGhlIHNlbnNlIG9mIHRoZQ0KPiBjb21wYXJpc29uIHdyb25n
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJlZGhhdC5j
b20+DQo+IC0tLQ0KPiBmcy9uZnNkL25mczRzdGF0ZS5jIHwgNDkgKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRp
b25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+IE15IG9yaWdpbmFsIHZlcnNpb24gb2YgdGhp
cyBwYXRjaC4uLiBhY3R1YWxseSBnb3QgdGhlIHNlbnNlIG9mIHRoZQ0KPiBjb21wYXJpc29uIHdy
b25nIQ0KPiANCj4gTm93IGFjdHVhbGx5IHRlc3RlZC4NCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9u
ZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiBpbmRleCA2MTU1MmU4OWJk
ODkuLjhlNjkzODkwMmI0OSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiAr
KysgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+IEBAIC01MzYzLDYgKzUzNjMsMjIgQEAgc3RhdGlj
IGJvb2wgY2xpZW50c19zdGlsbF9yZWNsYWltaW5nKHN0cnVjdCBuZnNkX25ldCAqbm4pDQo+IAly
ZXR1cm4gdHJ1ZTsNCj4gfQ0KPiANCj4gK3N0cnVjdCBsYXVuZHJ5X3RpbWUgew0KPiArCXRpbWU2
NF90IGN1dG9mZjsNCj4gKwl0aW1lNjRfdCBuZXdfdGltZW87DQo+ICt9Ow0KPiArDQo+ICtib29s
IHN0YXRlX2V4cGlyZWQoc3RydWN0IGxhdW5kcnlfdGltZSAqbHQsIHRpbWU2NF90IGxhc3RfcmVm
cmVzaCkNCj4gK3sNCj4gKwl0aW1lNjRfdCB0aW1lX3JlbWFpbmluZzsNCj4gKw0KPiArCWlmIChs
YXN0X3JlZnJlc2ggPCBsdC0+Y3V0b2ZmKQ0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKwl0aW1lX3Jl
bWFpbmluZyA9IGxhc3RfcmVmcmVzaCAtIGx0LT5jdXRvZmY7DQo+ICsJbHQtPm5ld190aW1lbyA9
IG1pbihsdC0+bmV3X3RpbWVvLCB0aW1lX3JlbWFpbmluZyk7DQo+ICsJcmV0dXJuIGZhbHNlOw0K
PiArfQ0KPiArDQoNCi9ob21lL2NlbC9zcmMvbGludXgvbGludXgvZnMvbmZzZC9uZnM0c3RhdGUu
Yzo1MzcxOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYc3RhdGVfZXhw
aXJlZOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQogNTM3MSB8IGJvb2wgc3RhdGVfZXhwaXJl
ZChzdHJ1Y3QgbGF1bmRyeV90aW1lICpsdCwgdGltZTY0X3QgbGFzdF9yZWZyZXNoKQ0KICAgICAg
fCAgICAgIF5+fn5+fn5+fn5+fn4NCg0KU2hvdWxkIHRoaXMgbmV3IGhlbHBlciBiZSBzdGF0aWMs
IG9yIGluc3RlYWQgcGVyaGFwcyB0aGVzZSBpdGVtcw0Kc2hvdWxkIGJlIGRlZmluZWQgaW4gYSBo
ZWFkZXIgZmlsZS4NCg0KPiBzdGF0aWMgdGltZTY0X3QNCj4gbmZzNF9sYXVuZHJvbWF0KHN0cnVj
dCBuZnNkX25ldCAqbm4pDQo+IHsNCj4gQEAgLTUzNzIsMTQgKzUzODgsMTYgQEAgbmZzNF9sYXVu
ZHJvbWF0KHN0cnVjdCBuZnNkX25ldCAqbm4pDQo+IAlzdHJ1Y3QgbmZzNF9vbF9zdGF0ZWlkICpz
dHA7DQo+IAlzdHJ1Y3QgbmZzZDRfYmxvY2tlZF9sb2NrICpuYmw7DQo+IAlzdHJ1Y3QgbGlzdF9o
ZWFkICpwb3MsICpuZXh0LCByZWFwbGlzdDsNCj4gLQl0aW1lNjRfdCBjdXRvZmYgPSBrdGltZV9n
ZXRfYm9vdHRpbWVfc2Vjb25kcygpIC0gbm4tPm5mc2Q0X2xlYXNlOw0KPiAtCXRpbWU2NF90IHQs
IG5ld190aW1lbyA9IG5uLT5uZnNkNF9sZWFzZTsNCj4gKwlzdHJ1Y3QgbGF1bmRyeV90aW1lIGx0
ID0gew0KPiArCQkuY3V0b2ZmID0ga3RpbWVfZ2V0X2Jvb3R0aW1lX3NlY29uZHMoKSAtIG5uLT5u
ZnNkNF9sZWFzZSwNCj4gKwkJLm5ld190aW1lbyA9IG5uLT5uZnNkNF9sZWFzZQ0KPiArCX07DQo+
IAlzdHJ1Y3QgbmZzNF9jcG50Zl9zdGF0ZSAqY3BzOw0KPiAJY29weV9zdGF0ZWlkX3QgKmNwc190
Ow0KPiAJaW50IGk7DQo+IA0KPiAJaWYgKGNsaWVudHNfc3RpbGxfcmVjbGFpbWluZyhubikpIHsN
Cj4gLQkJbmV3X3RpbWVvID0gMDsNCj4gKwkJbHQubmV3X3RpbWVvID0gMDsNCj4gCQlnb3RvIG91
dDsNCj4gCX0NCj4gCW5mc2Q0X2VuZF9ncmFjZShubik7DQo+IEBAIC01Mzg5LDcgKzU0MDcsNyBA
QCBuZnM0X2xhdW5kcm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4gCWlkcl9mb3JfZWFjaF9l
bnRyeSgmbm4tPnMyc19jcF9zdGF0ZWlkcywgY3BzX3QsIGkpIHsNCj4gCQljcHMgPSBjb250YWlu
ZXJfb2YoY3BzX3QsIHN0cnVjdCBuZnM0X2NwbnRmX3N0YXRlLCBjcF9zdGF0ZWlkKTsNCj4gCQlp
ZiAoY3BzLT5jcF9zdGF0ZWlkLnNjX3R5cGUgPT0gTkZTNF9DT1BZTk9USUZZX1NUSUQgJiYNCj4g
LQkJCQljcHMtPmNwbnRmX3RpbWUgPCBjdXRvZmYpDQo+ICsJCQkJc3RhdGVfZXhwaXJlZCgmbHQs
IGNwcy0+Y3BudGZfdGltZSkpDQo+IAkJCV9mcmVlX2NwbnRmX3N0YXRlX2xvY2tlZChubiwgY3Bz
KTsNCj4gCX0NCj4gCXNwaW5fdW5sb2NrKCZubi0+czJzX2NwX2xvY2spOw0KPiBAQCAtNTM5Nywx
MSArNTQxNSw4IEBAIG5mczRfbGF1bmRyb21hdChzdHJ1Y3QgbmZzZF9uZXQgKm5uKQ0KPiAJc3Bp
bl9sb2NrKCZubi0+Y2xpZW50X2xvY2spOw0KPiAJbGlzdF9mb3JfZWFjaF9zYWZlKHBvcywgbmV4
dCwgJm5uLT5jbGllbnRfbHJ1KSB7DQo+IAkJY2xwID0gbGlzdF9lbnRyeShwb3MsIHN0cnVjdCBu
ZnM0X2NsaWVudCwgY2xfbHJ1KTsNCj4gLQkJaWYgKGNscC0+Y2xfdGltZSA+IGN1dG9mZikgew0K
PiAtCQkJdCA9IGNscC0+Y2xfdGltZSAtIGN1dG9mZjsNCj4gLQkJCW5ld190aW1lbyA9IG1pbihu
ZXdfdGltZW8sIHQpOw0KPiArCQlpZiAoIXN0YXRlX2V4cGlyZWQoJmx0LCBjbHAtPmNsX3RpbWUp
KQ0KPiAJCQlicmVhazsNCj4gLQkJfQ0KPiAJCWlmIChtYXJrX2NsaWVudF9leHBpcmVkX2xvY2tl
ZChjbHApKSB7DQo+IAkJCXRyYWNlX25mc2RfY2xpZF9leHBpcmVkKCZjbHAtPmNsX2NsaWVudGlk
KTsNCj4gCQkJY29udGludWU7DQo+IEBAIC01NDE4LDExICs1NDMzLDggQEAgbmZzNF9sYXVuZHJv
bWF0KHN0cnVjdCBuZnNkX25ldCAqbm4pDQo+IAlzcGluX2xvY2soJnN0YXRlX2xvY2spOw0KPiAJ
bGlzdF9mb3JfZWFjaF9zYWZlKHBvcywgbmV4dCwgJm5uLT5kZWxfcmVjYWxsX2xydSkgew0KPiAJ
CWRwID0gbGlzdF9lbnRyeSAocG9zLCBzdHJ1Y3QgbmZzNF9kZWxlZ2F0aW9uLCBkbF9yZWNhbGxf
bHJ1KTsNCj4gLQkJaWYgKGRwLT5kbF90aW1lID4gY3V0b2ZmKSB7DQo+IC0JCQl0ID0gZHAtPmRs
X3RpbWUgLSBjdXRvZmY7DQo+IC0JCQluZXdfdGltZW8gPSBtaW4obmV3X3RpbWVvLCB0KTsNCj4g
KwkJaWYgKCFzdGF0ZV9leHBpcmVkKCZsdCwgZHAtPmRsX3RpbWUpKQ0KPiAJCQlicmVhazsNCj4g
LQkJfQ0KPiAJCVdBUk5fT04oIXVuaGFzaF9kZWxlZ2F0aW9uX2xvY2tlZChkcCkpOw0KPiAJCWxp
c3RfYWRkKCZkcC0+ZGxfcmVjYWxsX2xydSwgJnJlYXBsaXN0KTsNCj4gCX0NCj4gQEAgLTU0Mzgs
MTEgKzU0NTAsOCBAQCBuZnM0X2xhdW5kcm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4gCXdo
aWxlICghbGlzdF9lbXB0eSgmbm4tPmNsb3NlX2xydSkpIHsNCj4gCQlvbyA9IGxpc3RfZmlyc3Rf
ZW50cnkoJm5uLT5jbG9zZV9scnUsIHN0cnVjdCBuZnM0X29wZW5vd25lciwNCj4gCQkJCQlvb19j
bG9zZV9scnUpOw0KPiAtCQlpZiAob28tPm9vX3RpbWUgPiBjdXRvZmYpIHsNCj4gLQkJCXQgPSBv
by0+b29fdGltZSAtIGN1dG9mZjsNCj4gLQkJCW5ld190aW1lbyA9IG1pbihuZXdfdGltZW8sIHQp
Ow0KPiArCQlpZiAoIXN0YXRlX2V4cGlyZWQoJmx0LCBvby0+b29fdGltZSkpDQo+IAkJCWJyZWFr
Ow0KPiAtCQl9DQo+IAkJbGlzdF9kZWxfaW5pdCgmb28tPm9vX2Nsb3NlX2xydSk7DQo+IAkJc3Rw
ID0gb28tPm9vX2xhc3RfY2xvc2VkX3N0aWQ7DQo+IAkJb28tPm9vX2xhc3RfY2xvc2VkX3N0aWQg
PSBOVUxMOw0KPiBAQCAtNTQ2OCwxMSArNTQ3Nyw4IEBAIG5mczRfbGF1bmRyb21hdChzdHJ1Y3Qg
bmZzZF9uZXQgKm5uKQ0KPiAJd2hpbGUgKCFsaXN0X2VtcHR5KCZubi0+YmxvY2tlZF9sb2Nrc19s
cnUpKSB7DQo+IAkJbmJsID0gbGlzdF9maXJzdF9lbnRyeSgmbm4tPmJsb2NrZWRfbG9ja3NfbHJ1
LA0KPiAJCQkJCXN0cnVjdCBuZnNkNF9ibG9ja2VkX2xvY2ssIG5ibF9scnUpOw0KPiAtCQlpZiAo
bmJsLT5uYmxfdGltZSA+IGN1dG9mZikgew0KPiAtCQkJdCA9IG5ibC0+bmJsX3RpbWUgLSBjdXRv
ZmY7DQo+IC0JCQluZXdfdGltZW8gPSBtaW4obmV3X3RpbWVvLCB0KTsNCj4gKwkJaWYgKCFzdGF0
ZV9leHBpcmVkKCZsdCwgbmJsLT5uYmxfdGltZSkpDQo+IAkJCWJyZWFrOw0KPiAtCQl9DQo+IAkJ
bGlzdF9tb3ZlKCZuYmwtPm5ibF9scnUsICZyZWFwbGlzdCk7DQo+IAkJbGlzdF9kZWxfaW5pdCgm
bmJsLT5uYmxfbGlzdCk7DQo+IAl9DQo+IEBAIC01NDg1LDggKzU0OTEsNyBAQCBuZnM0X2xhdW5k
cm9tYXQoc3RydWN0IG5mc2RfbmV0ICpubikNCj4gCQlmcmVlX2Jsb2NrZWRfbG9jayhuYmwpOw0K
PiAJfQ0KPiBvdXQ6DQo+IC0JbmV3X3RpbWVvID0gbWF4X3QodGltZTY0X3QsIG5ld190aW1lbywg
TkZTRF9MQVVORFJPTUFUX01JTlRJTUVPVVQpOw0KPiAtCXJldHVybiBuZXdfdGltZW87DQo+ICsJ
cmV0dXJuIG1heF90KHRpbWU2NF90LCBsdC5uZXdfdGltZW8sIE5GU0RfTEFVTkRST01BVF9NSU5U
SU1FT1VUKTsNCj4gfQ0KPiANCj4gc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpsYXVu
ZHJ5X3dxOw0KPiAtLSANCj4gMi4yOS4yDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoNCg==
