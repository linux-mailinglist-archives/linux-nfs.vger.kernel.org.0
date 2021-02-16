Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885E31CEC4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 18:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBPRNb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 12:13:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55844 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBPRNS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 12:13:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GH5rsM097425;
        Tue, 16 Feb 2021 17:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T+yyAxkSkIA1XpOaiWH8gQgAe7412yJgbeCg50uvM7s=;
 b=I4rpauLMz4NMMTEOtF4KFh74wK++ufh+uNzpsoAw9KHh68aSVJqvP6mzBqFAvISrRkRb
 QhTRSmI7VTIHfihxkzZmc/WOyLXfEpHnEZefWrD/O6yliDXRMEEJhtiNIfKjAh9Ria60
 KRMwk3rL6j+CQSOCRbiarHn6+C4WVJzECqGzip6l6NpX5qEkdpBCzNuLgElwHsZrKk6Y
 IuXmUBXhhrEXCnd4J4u7CEaTXde4ac3H6SbrVg0XAhv+F6B9eDrxRNCXmD5alMzrQZw8
 n4VsBHono6Zm8Lu1IeTzId+iiwF+/Qb3D5hPvToebCuACOLpdvfRntUXoB/AWzneCNMH Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36pd9a734e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 17:12:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GH6LSw154285;
        Tue, 16 Feb 2021 17:12:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 36prbneecd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 17:12:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxMrkKQaw/dMh+v3h9yA10191lFuTWwlAxAMWiT41kPREe/GyaFfFvWi9CRYL3k3X72yyREKLWR+WTZNOzro4okvN2VV2/keKVPKdmD9AkdB/M5xImAWQKHVFay429uROfHAsG3kWB6BI5oSHbfcwdwBiWHrdsRJ/ngRhDQdQOGBUOqK6fT4FXBhlyWnJ/0/V5I9Wf3n6NLA5klBKKZ+pxk+HCVClZ7Q7ICBrbY8RMXiyQdf1GDHVpJJY9So4QmRkq7DsQoDdtLIARr52n0M7oJhucvzP3Jtje2D2OCflGAgM1xbHvZL/q4YCOvISSBnjl3n4/HkQ3MbAm/yU6V1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+yyAxkSkIA1XpOaiWH8gQgAe7412yJgbeCg50uvM7s=;
 b=GEVXp8WTUHm/Q/fef+z3NkmdcPdsRvpyXNtxd/SeI2gu86zxfw7Df9wUipzBM+qGscQjrwfjOGXJYH2qo6xrN4gwqCf+t1N6drUdxIOwcOBZtexKerIXbvCtctZ4uxd0Yqx50KGc9pDbBTOfvygoNk2YjjQR32HW8Gy2kRUP9QW7JwcQGwhVJYLtjLVDM9CvmRINXjxnDwQSHk8sy07kYVcIbZc/IYenZQOfjG5c8QNY+eCgGnwBtX7MEVS4dE/y+82T1bs6U/EJF1C9LIQLKJdnHn8OaDihL0M4Rk8bDMxkzqtQRnlL2mpax3KCO6XkmC4GJUAdru9Av1jrTy7GOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+yyAxkSkIA1XpOaiWH8gQgAe7412yJgbeCg50uvM7s=;
 b=JLFEYHLw3d49m+MEGQp9d2skoAVVUCHpwU0jHlOHVMsdZLkgOt71dDh1vw+vK6STMqli8DV40gniHqp2G59ir6Oy+Wq/+BgWSpxl4i9z9Lq4YNZs/YXgZTVPPdDzt4rs9g9IYOPjyWYcW2pmGAyA+w9pCzbfprZI8UhIMZGKLxI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 16 Feb
 2021 17:12:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 17:12:27 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpa/JkAgAAMEICAAACXgA==
Date:   Tue, 16 Feb 2021 17:12:27 +0000
Message-ID: <F6C97C66-358B-4031-84AF-EEF0878DF23E@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
 <635D6DE6-3E7B-43EB-93A4-075DE91897BB@oracle.com>
 <a0b15faec428fba8d1e10adc7f54cb11a15fc19b.camel@hammerspace.com>
In-Reply-To: <a0b15faec428fba8d1e10adc7f54cb11a15fc19b.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d2435f8-250e-45d7-12c6-08d8d29e0966
x-ms-traffictypediagnostic: BY5PR10MB4306:
x-microsoft-antispam-prvs: <BY5PR10MB4306D71FEDC389169977246893879@BY5PR10MB4306.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zwzma9BbCIsXkhxbQ4PexUkcdWmth61P9SKQpYkLFDIhtMnJsNIfpV9c8dcmD5mDyvtSKO3MYA7k9BV8AjHcRwzTlkFvJBZ0NIGp+dGVwFXpSNtXhxgvqEbSArl4byAZtZLpSeJD6M5osC/O6CmBXy9sASgNSCkaIlbdjAVCZO/tmHi9lpw6gI+avNeDiYj/o2hjj43ApUX3wjqf3FIkBPckpjWkScp66J4S49wV2llmSapOSOOcvJbsvTOc7lu2GzFmjvWZX+KR6bC9ib5l+YTNuHlNn28o6AMpHve6hc9dmMaJY7VUkK4OKb9Y44+P/D4WN/9RVq3k2C9ZeFCaIo6DeN09NTeHhdXRKYxWKaweQSlO3hePZg4GJgV6T1p0R30+CvDbDluY3qLxTWjxk9KJ+zWnTRep1XugHWA6zx7GO/vc9kUZlpRpXdsWAOo3VV+cGoznyz3xE7WCIckgZMzI3UPI5EsAGDCwODUKIpVOy1ysJz9Aipi2crBvu/8iZWc/jLpt/ja20dfDyZAQp1EK/nq3H1rZYYPiZ782UD3E57kT3CCI+rS64M+ZOC8uuqglot39rpIUwHeF426TwUlxjAkqSJhRJsm47Zs6rS3OLxqtIhWiALeXt4lJUF7QdXbW7gmDdZrZ6MY2FNdn8+lWe1Snq5w02fQgQFSc3YY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(66556008)(6506007)(5660300002)(15974865002)(2906002)(53546011)(2616005)(33656002)(91956017)(66946007)(76116006)(186003)(66446008)(66476007)(64756008)(54906003)(6512007)(8936002)(26005)(8676002)(316002)(44832011)(6916009)(4326008)(6486002)(83380400001)(966005)(71200400001)(86362001)(36756003)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UVNDM09OaEdTdmZnUzhBNkdBZEk1czdLYkpDSnJYeXZRNVlHWmowNmdEMHMz?=
 =?utf-8?B?OURWWlFHWGJZRlRkRExmYXFTKzg2MDFuQ1Z2OWlmaG5rbVN2OUZZcXhpenhS?=
 =?utf-8?B?UTZnaGpHSXZBY2NybEhGajRlT1VFTXQ1dVMrZVd5a2s3SER3SFlqYWFwYWhJ?=
 =?utf-8?B?cFJOVlh2QU1VdHNOZ2QrOElEWXVLVTNiU2Z5bDJzL2phN21mZGE1dVQrTWJn?=
 =?utf-8?B?K0JaVCtKSENDU1orcXMyWmxWS2ZKcWprRzU1QXNXK2wwUm1aa29QdEtUeGZS?=
 =?utf-8?B?MWVqQm9HN0N0eU90RlNoUGZrYS9KOC94TVZyQmNMenUrdXNyZUtTbUV5Zmhm?=
 =?utf-8?B?b0VYQSt5N29LdTNpVEg5TmxDU1d5TlNQdVhVeXl4SWhoS01qVm40dkZxd0JN?=
 =?utf-8?B?cFhEYjBqSll5V0lrVEk2TUJFME5RQXdvR040TmI0ck5NMmFuWXEvU3grd1FI?=
 =?utf-8?B?Q1RNalVoMmV4T1RRVHd5TU5KYXhnQmdhSGhRbTBJMXA5R0dyRkJOV2F6T0M5?=
 =?utf-8?B?ZVhOTTI4K3llK21LRkdFUStpRXZ1aFlaU0dZbU1MaHRtS0FDdUdULzlIcVBi?=
 =?utf-8?B?VHU3K3JOQmpwK0hSRnA2bUZCYnBzUFMxZEduaTBIQzg0MTBRMU1lanBQUzlp?=
 =?utf-8?B?alloK01xWXpTaWNiWWNMRXRTb0x6OStvelB5dWxCb0RSOE5QejZwU1hLS0ZS?=
 =?utf-8?B?NlM3bnBubmN4SEhJSFdDcnA0L2c0SFdRanlVV2VySmdnei9hRDNKa1ZtWmNs?=
 =?utf-8?B?bWNWM01iNkRDTEp0Z2J5dEJpcWdHL3BteERQd0RpL2gyelp4WmpsYkJ3V3Nu?=
 =?utf-8?B?cTJuNHpEVVpFYkR2aUpuSWtPVHJJVExESHhtelhBQXMzQUF4UHVrOUhVaWpO?=
 =?utf-8?B?clU2bHAyMG9Ydml1c3pyeDNjSHhqWEc5Y0o2RXZEMzRTSmJaWGRFR3ovVUR4?=
 =?utf-8?B?WFBjTFRaUmxsOW8vdGxaY3A3dlJub0ZUamJ5VWxac3piZkF4SXdHOTVFeDJw?=
 =?utf-8?B?VWkzMjlDclR1WXg4dVI1WFZsTmhuQS9FSUdFS0YrckgzdDdvRno3b0lFZjFh?=
 =?utf-8?B?TXlkazg4UUFPZWZ6aFRES2NXSnZLdnN1ZWd5MlhYRi9hMVB5LzVFM3prNVBX?=
 =?utf-8?B?T1grbDFOUHUwRmNML3BCT3ZuYTIwQnNJNkpCN3JNT3BualI3Tk1mYVlPL29W?=
 =?utf-8?B?aVdXVFRvRWErV0ZrV3J4b0w3RG1aWEpSSEdIM0w2ekhvUk53U3U2VjFhdlU4?=
 =?utf-8?B?cU5lSEhJVDNqcHlnN2tRSDczRUlGUDlxbHZnQTRYYk94S0lrUWw4ajhIUnBC?=
 =?utf-8?B?c01ra2hxblRieHVtOFdGYklCNkR2bnNqL2srcUFoeGhIMnAvUWhvZFNBTXF3?=
 =?utf-8?B?eUYzem1FVytkOEZ0S0NiZkZvclVqN2ZLdG1NcFJTOStlUHc2T1JXc0JZQmlr?=
 =?utf-8?B?MXdoNDRPMEYzZVRwNlM4a2JGQkowZGRwRTVxRno3dHJaVDhYbHhZVVlrSENJ?=
 =?utf-8?B?Qnc0aDY4bGM1MmJ2UVEweGVYMTFEdnJHakN0b3BNSms3eVNuaXkwaE8rNFZS?=
 =?utf-8?B?YUZoYU4ySU1zb2dCV1JQTnV4d0dEKzRNdExkMEJKWEd3cXpKS3UrVzJoTFhp?=
 =?utf-8?B?anRVMXF6aHlGd1dWazA2TGZTWmJBREw5SjM4WGNqeHVEaEJkaWtHVTBGUWNE?=
 =?utf-8?B?K1Fhd2krOVBZQXhhSHlnTHBGYmNsWFF6YVYwRE9Ja2JkeTUrQ1J5ME16Zlpk?=
 =?utf-8?B?KytuNHZyejJBVXp0MTF1WGppN1plc3VNRnBreXNPNDJhcWoySkRGcXRBSWdn?=
 =?utf-8?B?ODdobkRmTGhuRGN0Ui9FQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FE51EE1C53B1D4ABF88555474E0078C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2435f8-250e-45d7-12c6-08d8d29e0966
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 17:12:27.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGs+d1Ceoen/kUCeBzd2knAZSeRu2+1BNUlXUj8ySqwmqrh0EsribpYKUztM+qgXID1LCa1A7k50pgRrDCD5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160150
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRmViIDE2LCAyMDIxLCBhdCAxMjoxMCBQTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDIwMjEtMDItMTYgYXQg
MTY6MjcgKzAwMDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gSGV5IFRyb25kLQ0KPj4gDQo+Pj4g
T24gRmViIDEzLCAyMDIxLCBhdCAzOjI1IFBNLCB0cm9uZG15QGtlcm5lbC5vcmcgd3JvdGU6DQo+
Pj4gDQo+Pj4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tPg0KPj4+IA0KPj4+IFVzZSBhIGNvdW50ZXIgdG8ga2VlcCB0cmFjayBvZiBob3cgbWFu
eSByZXF1ZXN0cyBhcmUgcXVldWVkIGJlaGluZA0KPj4+IHRoZQ0KPj4+IHhwcnQtPnhwdF9tdXRl
eCwgYW5kIGtlZXAgVENQX0NPUksgc2V0IHVudGlsIHRoZSBxdWV1ZSBpcyBlbXB0eS4NCj4+PiAN
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20+DQo+PiANCj4+IExldCdzIG1vdmUgdGhpcyBmb3J3YXJkIGEgbGl0dGxlIGJp
dC4NCj4+IA0KPj4gSSdkIGxpa2UgdG8gc2VlIHRoZSBwcmV2aW91c2x5IGRpc2N1c3NlZCBNU0df
TU9SRSBzaW1wbGlmaWNhdGlvbg0KPj4gaW50ZWdyYXRlZCBpbnRvIHRoaXMgcGF0Y2guDQo+PiAN
Cj4gDQo+IEhtbS4uLiBJIHRoaW5rIEknZCBwcmVmZXIgdG8gbWFrZSBpdCBpbmNyZW1lbnRhbCB0
byB0aGlzIG9uZS4gSSB3YXNuJ3QNCj4gdG9vIHN1cmUgYWJvdXQgd2hldGhlciBvciBub3QgcmVt
b3ZpbmcgTVNHX1NFTkRQQUdFX05PVExBU1QgbWFrZXMgYQ0KPiBkaWZmZXJlbmNlLg0KPiBBRkFJ
Q1MsIHRoZSBhbnN3ZXIgaXMgbm8sIGJ1dCBqdXN0IGluIGNhc2UsIGxldCdzIG1ha2UgaXQgZWFz
eSB0byBiYWNrDQo+IHRoaXMgY2hhbmdlIG91dC4NCg0KT0suIFBsZWFzZSBzZW5kIGFuIGluY3Jl
bWVudGFsIHBhdGNoLiBUaGFua3MhDQoNCg0KPj4gSW4gYWRkaXRpb24gdG8gRGFpcmUncyB0ZXN0
aW5nLCBJJ3ZlIGRvbmUgc29tZSB0ZXN0aW5nOg0KPj4gLSBObyBiZWhhdmlvciByZWdyZXNzaW9u
cyBub3RlZA0KPj4gLSBObyBjaGFuZ2VzIGluIGxhcmdlIEkvTyB0aHJvdWdocHV0DQo+PiAtIFNs
aWdodGx5IHNob3J0ZXIgUlRUcyBvbiBzb2Z0d2FyZSBidWlsZA0KPj4gDQo+PiBBbmQgdGhlIGN1
cnJlbnQgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggaXMgbm93IGluIHRoZSBmb3ItcmMgYnJhbmNoDQo+
PiBvZiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jZWwv
bGludXguZ2l0Lw0KPj4gdG8gZ2V0IGJyb2FkZXIgdGVzdGluZyBleHBvc3VyZS4NCj4+IA0KPj4g
VGhpcyB3b3JrIGlzIGEgY2FuZGlkYXRlIGZvciBhIHNlY29uZCBORlNEIFBSIGR1cmluZyB0aGUg
NS4xMg0KPj4gbWVyZ2Ugd2luZG93LCBhbG9uZyB3aXRoIHRoZSBvdGhlciBwYXRjaGVzIGN1cnJl
bnRseSBpbiB0aGUNCj4+IGZvci1yYyBicmFuY2guDQo+PiANCj4+IA0KPj4+IC0tLQ0KPj4+IGlu
Y2x1ZGUvbGludXgvc3VucnBjL3N2Y3NvY2suaCB8IDIgKysNCj4+PiBuZXQvc3VucnBjL3N2Y3Nv
Y2suYyAgICAgICAgICAgfCA4ICsrKysrKystDQo+Pj4gMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9zdW5ycGMvc3Zjc29jay5oDQo+Pj4gYi9pbmNsdWRlL2xpbnV4L3N1bnJwYy9zdmNzb2Nr
LmgNCj4+PiBpbmRleCBiN2FjN2ZlNjgzMDYuLmJjYzU1NWM3YWU5YyAxMDA2NDQNCj4+PiAtLS0g
YS9pbmNsdWRlL2xpbnV4L3N1bnJwYy9zdmNzb2NrLmgNCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4
L3N1bnJwYy9zdmNzb2NrLmgNCj4+PiBAQCAtMzUsNiArMzUsOCBAQCBzdHJ1Y3Qgc3ZjX3NvY2sg
ew0KPj4+ICAgICAgICAgLyogVG90YWwgbGVuZ3RoIG9mIHRoZSBkYXRhIChub3QgaW5jbHVkaW5n
IGZyYWdtZW50DQo+Pj4gaGVhZGVycykNCj4+PiAgICAgICAgICAqIHJlY2VpdmVkIHNvIGZhciBp
biB0aGUgZnJhZ21lbnRzIG1ha2luZyB1cCB0aGlzIHJwYzogKi8NCj4+PiAgICAgICAgIHUzMiAg
ICAgICAgICAgICAgICAgICAgIHNrX2RhdGFsZW47DQo+Pj4gKyAgICAgICAvKiBOdW1iZXIgb2Yg
cXVldWVkIHNlbmQgcmVxdWVzdHMgKi8NCj4+PiArICAgICAgIGF0b21pY190ICAgICAgICAgICAg
ICAgIHNrX3NlbmRxbGVuOw0KPj4+IA0KPj4+ICAgICAgICAgc3RydWN0IHBhZ2UgKiAgICAgICAg
ICAgc2tfcGFnZXNbUlBDU1ZDX01BWFBBR0VTXTsgICAgICAvKg0KPj4+IHJlY2VpdmVkIGRhdGEg
Ki8NCj4+PiB9Ow0KPj4+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3N2Y3NvY2suYyBiL25ldC9z
dW5ycGMvc3Zjc29jay5jDQo+Pj4gaW5kZXggNWE4MDljNjRkYzdiLi4yMzFmNTEwYTQ4MzAgMTAw
NjQ0DQo+Pj4gLS0tIGEvbmV0L3N1bnJwYy9zdmNzb2NrLmMNCj4+PiArKysgYi9uZXQvc3VucnBj
L3N2Y3NvY2suYw0KPj4+IEBAIC0xMTcxLDE4ICsxMTcxLDIzIEBAIHN0YXRpYyBpbnQgc3ZjX3Rj
cF9zZW5kdG8oc3RydWN0IHN2Y19ycXN0DQo+Pj4gKnJxc3RwKQ0KPj4+IA0KPj4+ICAgICAgICAg
c3ZjX3RjcF9yZWxlYXNlX3Jxc3QocnFzdHApOw0KPj4+IA0KPj4+ICsgICAgICAgYXRvbWljX2lu
Yygmc3Zzay0+c2tfc2VuZHFsZW4pOw0KPj4+ICAgICAgICAgbXV0ZXhfbG9jaygmeHBydC0+eHB0
X211dGV4KTsNCj4+PiAgICAgICAgIGlmIChzdmNfeHBydF9pc19kZWFkKHhwcnQpKQ0KPj4+ICAg
ICAgICAgICAgICAgICBnb3RvIG91dF9ub3Rjb25uOw0KPj4+ICsgICAgICAgdGNwX3NvY2tfc2V0
X2Nvcmsoc3Zzay0+c2tfc2ssIHRydWUpOw0KPj4+ICAgICAgICAgZXJyID0gc3ZjX3RjcF9zZW5k
bXNnKHN2c2stPnNrX3NvY2ssICZtc2csIHhkciwgbWFya2VyLA0KPj4+ICZzZW50KTsNCj4+PiAg
ICAgICAgIHhkcl9mcmVlX2J2ZWMoeGRyKTsNCj4+PiAgICAgICAgIHRyYWNlX3N2Y3NvY2tfdGNw
X3NlbmQoeHBydCwgZXJyIDwgMCA/IGVyciA6IHNlbnQpOw0KPj4+ICAgICAgICAgaWYgKGVyciA8
IDAgfHwgc2VudCAhPSAoeGRyLT5sZW4gKyBzaXplb2YobWFya2VyKSkpDQo+Pj4gICAgICAgICAg
ICAgICAgIGdvdG8gb3V0X2Nsb3NlOw0KPj4+ICsgICAgICAgaWYgKGF0b21pY19kZWNfYW5kX3Rl
c3QoJnN2c2stPnNrX3NlbmRxbGVuKSkNCj4+PiArICAgICAgICAgICAgICAgdGNwX3NvY2tfc2V0
X2Nvcmsoc3Zzay0+c2tfc2ssIGZhbHNlKTsNCj4+PiAgICAgICAgIG11dGV4X3VubG9jaygmeHBy
dC0+eHB0X211dGV4KTsNCj4+PiAgICAgICAgIHJldHVybiBzZW50Ow0KPj4+IA0KPj4+IG91dF9u
b3Rjb25uOg0KPj4+ICsgICAgICAgYXRvbWljX2RlYygmc3Zzay0+c2tfc2VuZHFsZW4pOw0KPj4+
ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZ4cHJ0LT54cHRfbXV0ZXgpOw0KPj4+ICAgICAgICAgcmV0
dXJuIC1FTk9UQ09OTjsNCj4+PiBvdXRfY2xvc2U6DQo+Pj4gQEAgLTExOTIsNiArMTE5Nyw3IEBA
IHN0YXRpYyBpbnQgc3ZjX3RjcF9zZW5kdG8oc3RydWN0IHN2Y19ycXN0DQo+Pj4gKnJxc3RwKQ0K
Pj4+ICAgICAgICAgICAgICAgICAgIChlcnIgPCAwKSA/IGVyciA6IHNlbnQsIHhkci0+bGVuKTsN
Cj4+PiAgICAgICAgIHNldF9iaXQoWFBUX0NMT1NFLCAmeHBydC0+eHB0X2ZsYWdzKTsNCj4+PiAg
ICAgICAgIHN2Y194cHJ0X2VucXVldWUoeHBydCk7DQo+Pj4gKyAgICAgICBhdG9taWNfZGVjKCZz
dnNrLT5za19zZW5kcWxlbik7DQo+Pj4gICAgICAgICBtdXRleF91bmxvY2soJnhwcnQtPnhwdF9t
dXRleCk7DQo+Pj4gICAgICAgICByZXR1cm4gLUVBR0FJTjsNCj4+PiB9DQo+Pj4gQEAgLTEyNjEs
NyArMTI2Nyw3IEBAIHN0YXRpYyB2b2lkIHN2Y190Y3BfaW5pdChzdHJ1Y3Qgc3ZjX3NvY2sNCj4+
PiAqc3Zzaywgc3RydWN0IHN2Y19zZXJ2ICpzZXJ2KQ0KPj4+ICAgICAgICAgICAgICAgICBzdnNr
LT5za19kYXRhbGVuID0gMDsNCj4+PiAgICAgICAgICAgICAgICAgbWVtc2V0KCZzdnNrLT5za19w
YWdlc1swXSwgMCwgc2l6ZW9mKHN2c2stDQo+Pj4+IHNrX3BhZ2VzKSk7DQo+Pj4gDQo+Pj4gLSAg
ICAgICAgICAgICAgIHRjcF9zayhzayktPm5vbmFnbGUgfD0gVENQX05BR0xFX09GRjsNCj4+PiAr
ICAgICAgICAgICAgICAgdGNwX3NvY2tfc2V0X25vZGVsYXkoc2spOw0KPj4+IA0KPj4+ICAgICAg
ICAgICAgICAgICBzZXRfYml0KFhQVF9EQVRBLCAmc3Zzay0+c2tfeHBydC54cHRfZmxhZ3MpOw0K
Pj4+ICAgICAgICAgICAgICAgICBzd2l0Y2ggKHNrLT5za19zdGF0ZSkgew0KPj4+IC0tIA0KPj4+
IDIuMjkuMg0KPj4+IA0KPj4gDQo+PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCj4+IA0KPj4gDQo+PiAN
Cj4gDQo+IC0tIA0KPiBUcm9uZCBNeWtsZWJ1c3QNCj4gQ1RPLCBIYW1tZXJzcGFjZSBJbmMNCj4g
NDk4NCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMjA4DQo+IExvcyBBbHRvcywgQ0EgOTQwMjINCj4g
4oCLDQo+IHd3dy5oYW1tZXIuc3BhY2UNCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
