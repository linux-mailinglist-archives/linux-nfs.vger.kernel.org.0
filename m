Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4B363131
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Apr 2021 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhDQQgi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Apr 2021 12:36:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40210 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhDQQgh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Apr 2021 12:36:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13HGa9Ii016177;
        Sat, 17 Apr 2021 16:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XfgS30q5ymSiAAnW2TRWnZdm5ah5nWdm5zMhGLVpvkk=;
 b=V4aF7J2w+kJNUWx0h4CzKqZD6lmtqtwhQPZKNwJ3RBLpnHMd2xAYY7TX6QBDygUblztu
 3CXuEwpKooKt7XZRpncw7acZrXIbKamrRQYPekSwtYdMbjKCi2QKWjEeiz4I04hRpFc9
 rP+LbixSdPJMHsatkl0MrfFw835e3RCmFHXfIIbk/o2JPgBk02qtNN8yu+8tnTMfdpWH
 JSzByMovc2qVzJ9lFWHpYeBEvdHiMRyTvst2KShAgoK0O81eWzgLRiG0xKsVYdS+ct7/
 xEBQ4nHomXM9HZQfiicGesenX801Vv4QZrcWOyNYJVGXb/FveInZSdwMHHvDLuow1e5P qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37yn6c0qkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 16:36:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13HGZw6L002932;
        Sat, 17 Apr 2021 16:36:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 37yqg24763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 16:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtdxxv/vt0MGlh+sPUkvKqdn4HokFbwDdz/egZoFOqKGCce6BNz31lIFB8jI1dtQNrHtX0Vt/V2EmpUtvGWXmV0yRfxvt4MhUonL22BHDRuwpntssnrLV4Nnps1rXAwn2Hok9+1OqLxXIs/GUsIP2GZdbHYOt8ipI+PZ0k1MulT1FkBBuifATkkLv30HFug6tYAo08z59nCtUNONI2PVhEM8OQjPEcUU/YOX9cyzdTfP/PZkeNLDaEbk5Iw6KPdb65cq02+RdisuDoz6b2TMp/7JLk0x7tIoD2tqgTlNlliENWi+jKCUuiNYlSnWkVkrmAx2ndDNk/1LRaFau7wsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfgS30q5ymSiAAnW2TRWnZdm5ah5nWdm5zMhGLVpvkk=;
 b=RUL9KT/hVj74whfZ//iQCZ3JNWwpYfPscgUYIEYvZlzjL3hbtP91JPzf0K7EfK+Yg5bYNMwIq71zdpbiVthszkNqakO3woU5tdWmwsnbfDJhkdf3GPz60NjY26fsP2JmlDwYfNPKLKdVN0Vuo4SJCBAmSeiE7fl76zIeJo3hdqFBeHhwDznXdJR2kpy7RYXMjMs2iPW08pGLh4VHbxzWTZQ0q5XYoJQG+0evfHGwV3NWI81aKoKwwN9oqDl5VYXe2vytbfFjztq4q5A/R1BoTBgvrJi+RTP5FjhsU+64bD8couzpuQSChxhQ0F9GyTb8xqlKW6rSHwB1MtZEUn887w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfgS30q5ymSiAAnW2TRWnZdm5ah5nWdm5zMhGLVpvkk=;
 b=jX4FdAt0RBQ7H+q2qzZ0cVbz3y7GXOBZoULVkakpmQGE3AjNjJd/reDPbdki810oi26VfEcVIES1lrHLM/1tYE3B7aXD2qsFDVNe2whsdXSqUX3DKceTYDGXZtec7Fqzi1yWivEUqAWCxUDQQ0kvC1QuTLuTPeENtm1P2nqmUg0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Sat, 17 Apr
 2021 16:36:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.020; Sat, 17 Apr 2021
 16:36:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@RedHat.com>
CC:     Alice J Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Topic: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Index: AQHXMVl21czF1oj/Wkexg55/eRtUL6q0qJzlgAEODgCAABHLgIADH5IAgAAEy4A=
Date:   Sat, 17 Apr 2021 16:36:06 +0000
Message-ID: <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
 <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
 <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
In-Reply-To: <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: RedHat.com; dkim=none (message not signed)
 header.d=none;RedHat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb81a36c-ce8e-41eb-f9cd-08d901bee615
x-ms-traffictypediagnostic: SJ0PR10MB4478:
x-microsoft-antispam-prvs: <SJ0PR10MB4478BB598950E3B980DFC336934B9@SJ0PR10MB4478.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSdZZnEh4fqLzRm8SDp6Nz21q7zR+Fa+NlOLyl3RinbI+8M8Qbu54vFtsoIUlGNjLlhgoIX5geRm+8cGKY/cCCEh0CHUWKULZyzmMuRAAKyebAvODl0BI7/zGn5lCdKFinnjwePJzmGtktZwHsdpdOw+S2bl0YjghZRv8MIkUrQ17/jEZGVwgN1cOP4DjXOYj39bEFitJeeJscz6IEtFX9P9AzNnpUFU1c8LxD1Qr3rcdpqxHAOSmyudb3/SZk09VOsuogc1fGYwPkVzEAQx7OMIGPR44uF2IokMqOUKzHqOsdUIqKFmoNHvFlrVffjbZHjxSEPa1/hj91hRaYbXnRHIOJqHXLSQfmVgwzurmDTnXM6dJJP1gwfAiPDM8hAHYEuNvTAnPNVfTHmdiCCDK29jxuUiBe80dhaQGa+3+CACySgVA9fYYYC4QtTckZn93mMECJxpOotTfqbpxZfVtapeuB3l2yRkoEpO3WrwxRaF6UMG82qtj+UG3kYLJ68RiOHapHdFnrta7iZaZFwst21ppsbqWZ5hIRMbNPrKqolppfhxHNJc/cT+C4SokmbjBUBBfONHvkCd3NNXSZxbrIfWR0ZzWorD4wrifinThZa2Jd1ACDTmJlmMdnMmd2ZFzn9FW/bI5fdxylkgy884H7BIQg2oL0ldWffNxCPpFsQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(6512007)(91956017)(66476007)(36756003)(64756008)(53546011)(66556008)(6506007)(66946007)(76116006)(316002)(71200400001)(66446008)(4326008)(83380400001)(2906002)(5660300002)(33656002)(6916009)(54906003)(26005)(186003)(6486002)(2616005)(478600001)(122000001)(8936002)(38100700002)(8676002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WDdNUmpjYmpBUEc1MjUrcURpVW5Kb0NsbVBINDFRc0xqMnVWQ251KzU2T21l?=
 =?utf-8?B?ek1HdllhdTBFaVVnK0JwUDJkbEtjVjlBaHhMcmQva3RJUE40VXhrRmFCdlNy?=
 =?utf-8?B?Z0JDZEhLSmlZUmpEOEEwTSs3NG5LZ1VrZTBYdU80dGFGcy82M1hPVHNMcERP?=
 =?utf-8?B?bHRKL2dyWWxCZ1lOQUhrb0NZUDQvckZYUEJZeEt6cXNUaFZBNmRlYzRSMUhH?=
 =?utf-8?B?L1dIeG9HeHczRjUyYzVkYlhYU1YxclJtU2VZeDk0WEdySWExaVM5TTdQWW5O?=
 =?utf-8?B?ZGd0dlczek53RldtbHhLaUg4YlpsQWduV1VPQlBGOXIzUFVkVUd4OVR4ejhZ?=
 =?utf-8?B?MC9xdVE3clZ0N0FSSDRXQU1SYXIyTWpWT1EreHF4ZVU4eVVSSk53YnNwT3Rl?=
 =?utf-8?B?d1Q0N3Zwa2pJTm15cVg0L3FEUzdWenBtRGlvQ3A3VWhTL0VFV2RKKy8zNVkw?=
 =?utf-8?B?WTFuMG05WDlmWTdxV1ZUUkw5MnNJZmd6bldDOWo3ZlozTzFhdW1pejlqUCtu?=
 =?utf-8?B?L3hEUU91WlRkY2tLUGdldXJQRkdMVUt2RHpISkFxZ1dhNEpyaEFyYUtFMWly?=
 =?utf-8?B?S3dBWFNMWnBTWVVHNkIvVHpjZ1lmMjZTMTlXdmhkOGZtQVoyVWRqZ05nN3Mr?=
 =?utf-8?B?VmxzSlRxaDFKaWcycHlRMkhreWtiTnVZbGg2N0RXdTM5S3lURzZaSDFkL2RK?=
 =?utf-8?B?RFNyWGRvLy9VUEp0a1lOV0FyNHljNnJjaWdCNG40USsyV0c5KzdpRjAzTHFP?=
 =?utf-8?B?ZVlUR256RE05VXlWM0pMWUh5UUptS09jSERMN0J6cFphY0FOUGljWGFqTVI1?=
 =?utf-8?B?U3dDOVdFVjFHbThqKys1R25lSkw3Zy9JeUlxRThaMjNZcHJUZ2VvQWI5a1ZP?=
 =?utf-8?B?dUlpc1U0S0MzUU10eXYvK1kxZGY1R3BRS2lOTTNCUC9RYUtENjlRcW5ZNGtR?=
 =?utf-8?B?bzI4aW1qdVFFSHVlRkpXV3V3citKcnVkT241OStNc0pmaFhJbkNRQVNKWEdp?=
 =?utf-8?B?Q1NoY00zeDVOWVcxbTZBMHc5ZmsxUlVOMUVrdWV5clBnUXp0ZWw2ZjJ0ZkZ5?=
 =?utf-8?B?aE1xOE12RTRCVHlwZ1d6a1VLNGlzNWFuUlMrMnJRNmxwK0JiTDUzRGQ5Rjdp?=
 =?utf-8?B?WDRSZnpuenhzTDllQ2JrOUE3ZUlVS1JGMkhIelllY3A4a3NQR04rM3hZZ1R0?=
 =?utf-8?B?OU5vRWdMSmt1VVJuMGxudW51YnFZcGd1V0lkdmovMCs1RGQ0ZjNnN1pCTHJi?=
 =?utf-8?B?dUwxRjlGeGIwWmhsV1JSbEFidlpqaW83cTVKeTJ0THRFVGRsYjltT2xab1U4?=
 =?utf-8?B?WDFlcE0zdWF5aEF4NnFWYmFwM1lTMEQrOWZTVk81T1RWbGRqV2EwMGcxYXBt?=
 =?utf-8?B?Qll2SWpUaWpoWnhocGFiWGQ4Mm1kd3lGU1ByY0RPOC9zeUtLSXhwMFRvR2Ez?=
 =?utf-8?B?Vzc4UTdpSndCMlZ1dCtINy9tcGUzM1o0RUI2WURUWFlJSW5kajJjd2JSMDRZ?=
 =?utf-8?B?cklidC9BdUdxUEFJemZwWjZkbStqYi9xdXgwazlhbDZORWJVQ3VQWU4yYnVE?=
 =?utf-8?B?UkZqYzJkNERnZVlFZERKWkh4YnZlTFZXV1RndWF5UjVQQ2tBV0dqdXFweW82?=
 =?utf-8?B?bGwvY2pOU1d2dVJPV21FVnRseWoxUWJtWmFRNVdkSzFEN1dVdHA5SllvVU15?=
 =?utf-8?B?a05VQzFPclU4MWg5UlRPb0o2N3JsMnJXKzlxRDhncFRCTzNkaktTbHBzZnhv?=
 =?utf-8?Q?T9txDzc3wPNtPI5gKUb0cQkXBIaMDsrwKzQOQo4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2263C56468CFA647AB1B214950F4E313@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb81a36c-ce8e-41eb-f9cd-08d901bee615
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 16:36:06.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAue5i2epTNtEWRD+bCDdQNRTmgD1xb+9rNmAMNKVr/dia1r49SIalBKpV7EswDmXw/60gNkRM/IAde4sKeCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9957 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104170118
X-Proofpoint-GUID: va2i216lVH4qe51l6hASpKWBTHfzFHvC
X-Proofpoint-ORIG-GUID: va2i216lVH4qe51l6hASpKWBTHfzFHvC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9957 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104170118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXByIDE3LCAyMDIxLCBhdCAxMjoxOCBQTSwgU3RldmUgRGlja3NvbiA8U3RldmVE
QFJlZEhhdC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBPbiA0LzE1LzIxIDEyOjM3IFBNLCBD
aHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEFwciAxNSwgMjAyMSwgYXQg
MTE6MzMgQU0sIFN0ZXZlIERpY2tzb24gPFN0ZXZlREBSZWRIYXQuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBIZXkgQ2h1Y2shIA0KPj4+IA0KPj4+IE9uIDQvMTQvMjEgNzoyNiBQTSwgQ2h1Y2sgTGV2
ZXIgSUlJIHdyb3RlOg0KPj4+PiBIaSBTdGV2ZS0NCj4+Pj4gDQo+Pj4+PiBPbiBBcHIgMTQsIDIw
MjEsIGF0IDI6MTAgUE0sIFN0ZXZlIERpY2tzb24gPFN0ZXZlREByZWRoYXQuY29tPiB3cm90ZToN
Cj4+Pj4+IA0KPj4+Pj4g77u/VGhpcyBpcyBhIHR3ZWFrIG9mIHRoZSBwYXRjaCBzZXQgQWxpY2Ug
TWl0Y2hlbGwgcG9zdGVkIGxhc3QgSnVseSBbMV0uDQo+Pj4+IA0KPj4+PiBUaGF0IGFwcHJvYWNo
IHdhcyBkcm9wcGVkIGxhc3QgSnVseSBiZWNhdXNlIGl0IGlzIG5vdCBjb250YWluZXItYXdhcmUu
DQo+Pj4+IEl0IHNob3VsZCBiZSBzaW1wbGUgZm9yIHNvbWVvbmUgdG8gd3JpdGUgYSB1ZGV2IHNj
cmlwdCB0aGF0IHVzZXMgdGhlDQo+Pj4+IGV4aXN0aW5nIHN5c2ZzIEFQSSB0aGF0IGNhbiB1cGRh
dGUgbmZzNF9jbGllbnRfaWQgaW4gYSBuYW1lc3BhY2UuIEkNCj4+Pj4gd291bGQgcHJlZmVyIHRo
ZSBzeXNmcy91ZGV2IGFwcHJvYWNoIGZvciBzZXR0aW5nIG5mczRfY2xpZW50X2lkLA0KPj4+PiBz
aW5jZSBpdCBpcyBjb250YWluZXItYXdhcmUgYW5kIG1ha2VzIHRoaXMgc2V0dGluZyBjb21wbGV0
ZWx5DQo+Pj4+IGF1dG9tYXRpYyAoemVybyB0b3VjaCkuDQo+Pj4gQXMgSSBzYWlkIGluIGluIG15
IGNvdmVyIGxldHRlciwgSSBzZWUgdGhpcyBtb3JlIGFzIGludHJvZHVjdGlvbiBvZg0KPj4+IGEg
bWVjaGFuaXNtIG1vcmUgdGhhbiBhIHdheSB0byBzZXQgdGhlIHVuaXF1ZSBpZC4NCj4+IA0KPj4g
WWVwLCBJIGdvdCB0aGF0Lg0KPj4gDQo+PiBJJ20gbm90IGFkZHJlc3NpbmcgdGhlIHF1ZXN0aW9u
IG9mIHdoZXRoZXIgYWRkaW5nIGENCj4+IG1lY2hhbmlzbSB0byBzZXQgYSBtb2R1bGUgcGFyYW1l
dGVyIGluIG5mcy5jb25mIGlzIGdvb2QNCj4+IG9yIG5vdC4gSSdtIHNheWluZyBuZnM0X2NsaWVu
dF9pZCBpcyBub3QgYW4gYXBwcm9wcmlhdGUNCj4+IHBhcmFtZXRlciB0byBhZGQgdG8gbmZzLmNv
bmYuIENhbiB5b3UgcGljayBhbm90aGVyDQo+PiBtb2R1bGUgcGFyYW1ldGVyIGFzIGFuIGV4YW1w
bGUgZm9yIHlvdXIgbWVjaGFuaXNtPw0KPiBUaGUgcmVxdWVzdCB3YXMgdG8gc2V0IHRoYXQgcGFy
YW1ldGVyLi4uDQoNClRoZSBjb3ZlciBsZXR0ZXIgYW5kIHRoZSBxdW90ZWQgZS1tYWlsIGFib3Zl
IHN0YXRlIHRoYXQNCnlvdSBhcmUganVzdCBkZW1vbnN0cmF0aW5nIGEgbWVjaGFuaXNtIHRvIHNl
dCBtb2R1bGUNCnBhcmFtZXRlcnMgdmlhIG5mcy5jb25mLiBJIGd1ZXNzIHRoYXQgc3RhdGVtZW50
IHdhcyBub3QNCmVudGlyZWx5IGFjY3VyYXRlLCB0aGVuLiBUaGFua3MgZm9yIGNsYXJpZnlpbmcu
DQoNCklmIHRoZXJlJ3MgYSBidWcgcmVwb3J0IHNvbWV3aGVyZSB0aGF0IHJlcXVlc3RzIGENCmZl
YXR1cmUsIGl0J3Mgbm9ybWFsIHByYWN0aWNlIHRvIGluY2x1ZGUgYSBVUkwgcG9pbnRpbmcNCnRv
IHRoYXQgcmVwb3J0IGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCg0KDQo+Pj4gVGhlIG1lY2hh
bmlzbSBiZWluZw0KPj4+IGEgd2F5IHRvIHNldCBrZXJuZWwgbW9kdWxlIHBhcmFtcyBmcm9tIG5m
cy5jb25mLiBUaGUgc2V0dGluZyBvZg0KPj4+IHRoZSBpZCBpcyBqdXN0IGEgc2lkZSBlZmZlY3Qu
Li4gDQo+Pj4gDQo+Pj4gV2h5IHNwcmVhZCBvdXQgdGhlIE5GUyBjb25maWd1cmF0aW9uPyAgV2h5
IG5vdA0KPj4+IGp1c3Qga2VlcCBpdCBpbiBvbmUgcGxhY2UuLi4gYWthIG5mcy5jb25mPw0KPj4g
DQo+PiBXZSBuZWVkIHRvIHVuZGVyc3RhbmQgd2hldGhlciBhIG1vZHVsZSBwYXJhbWV0ZXIgaXMg
bm90DQo+PiBnb2luZyB0byB3b3JrIGluIG5mcy5jb25mIGJlY2F1c2UgdGhhdCBzZXR0aW5nIG5l
ZWRzIHRvDQo+PiBiZSBuYW1lc3BhY2UtYXdhcmUuIEluIHRoaXMgY2FzZSwgdGhpcyBzZXR0aW5n
IGRvZXMgaW5kZWVkDQo+PiBuZWVkIHRvIGJlIG5hbWVzcGFjZS1hd2FyZS4gbmZzLmNvbmYgaXMg
bm90IGF3YXJlIG9mDQo+PiBuZXR3b3JrIG5hbWVzcGFjZXMuDQo+IFlvdSBwcm9iYWJseSBjYW4g
c2F5IHRoYXQgZm9yIGV2ZXJ5IC9ldGMvKi5jb25mIGZpbGUuLi4gIA0KPiBub3QgYmVpbmcgbmFt
ZXNwYWNlIGF3YXJlLi4uIGhvdyBjYW4gdGhleSBiZS4uLg0KPiANCj4gSW4gdGhlIGtlcm5lbCBk
b2N1bWVudCB5b3Ugc2F5ICJTcGVjaWZ5aW5nIGEgdW5pcXVpZmllciBzdHJpbmcgaXMgDQo+IG5v
dCBzdXBwb3J0IGZvciBORlMgY2xpZW50cyBydW5uaW5nIGluIGNvbnRhaW5lcnMuIg0KPiANCj4g
V2h5IGlzbid0IHRoYXQgZW5vdWdoPw0KDQpCZWNhdXNlIHRoYXQgc3RhdGVtZW50IGlzIG5vdGlu
ZyBhIGxpbWl0YXRpb24gd2hpY2ggaXMgYQ0KYnVnIHRoYXQgaGFzIHRvIGJlIGFkZHJlc3NlZCB0
byBzdXBwb3J0IE5GU3Y0IHByb3Blcmx5IGluDQpjb250YWluZXJzLg0KDQoNCj4+PiBBcyBmYXIg
YXMgbm90IGJlaW5nIGNvbnRhaW5lci1hd2FyZS4uLiB0aGF0IG1pZ2h0IHRydWUNCj4+PiBidXQg
aXQgZG9lcyBub3QgbWVhbiBpdHMgbm90IHVzZWZ1bCB0byBzZXQgdGhlIGlkIGZyb20NCj4+PiBu
ZnMuY29uZi4uLg0KPj4gDQo+PiBZZXMsIGl0IGRvZXMgbWVhbiB0aGF0IGluIHRoYXQgY2FzZS4g
SXQncyBjb21wbGV0ZWx5DQo+PiBicm9rZW4gdG8gdXNlIHRoZSBzYW1lIG5mczRfY2xpZW50X2lk
IGluIGV2ZXJ5IG5ldHdvcmsNCj4+IG5hbWVzcGFjZS4NCj4gSG93IGRvZXMgdGhpcyBicmVhaz8g
SWYgYWxsIHRoZSBjbGllbnRzIGhhdmUgdW5pcXVlIGlkcw0KPiB3aGF0IGJyZWFrcz8NCj4gDQo+
IE9yIGFyZSB5b3Ugc2F5aW5nIHNldHRpbmcgdGhlIHVuaXF1ZSBpZCBsaWtlIHRoaXM6DQo+IA0K
PiBvcHRpb25zIG5mcyBuZnM0X3VuaXF1ZV9pZD0iNjRmZDI2MjgwNDUxNTY2ZDY0OGFiMGUwYjcz
ODQ0MjEiDQo+IA0KPiBpbiBtb2Rwcm9iZS5kL25mcy5jb25mIGlzIG5vdCBuYW1lc3BhY2Ugc2Fm
ZT8NCg0KU2V0dGluZyB0aGUgY2xpZW50X2lkIHZpYSBtb2R1bGUgcGFyYW1ldGVyIGlzIG5vdA0K
bmFtZXNwYWNlLWF3YXJlLiBUaGF0J3MgdGhlIGJ1ZyB0aGF0IHRoZSBzeXNmcy91ZGV2DQpjb250
cmFwdGlvbiBpcyBkZXNpZ25lZCB0byBmaXguDQoNCg0KPj4+IEFjdHVhbCBJIGhhdmUgY3VzdG9t
ZXJzIGFza2luZyBmb3IgdGhpcyB0eXBlDQo+Pj4gb2YgZnVuY3Rpb25hbGl0eQ0KPj4gDQo+PiBB
c2sgeW91cnNlbGYgd2h5IHRoZXkgbWlnaHQgd2FudCBpdC4gSXQncyBwcm9iYWJseSBiZWNhdXNl
DQo+PiB3ZSBkb24ndCBzZXQgaXQgY29ycmVjdGx5IGN1cnJlbnRseS4gSWYgd2UgaGF2ZSBhIHdh
eSB0bw0KPj4gYXV0b21hdGljYWxseSBnZXQgaXQgcmlnaHQgZXZlcnkgdGltZSwgdGhlcmUncyBy
ZWFsbHkgbm8NCj4+IG5lZWQgZm9yIHRoaXMgc2V0dGluZyB0byBiZSBleHBvc2VkLg0KPiBJZiB3
ZSBzaG91bGRuJ3QgZXhwb3NlIGl0Li4uIExldHMgZ2V0IHJpZCBvZiBpdC4uLg0KPiBZb3UgYWRk
ZWQgdGhlIHBhcmFtIGluIHRoZSBmYWxsIDIwMTIuLi4gSWYgaXQgaGFzbid0DQo+IGJlZW4gdXNl
ZCBjb3JyZWN0bHkgb3IgY2FuJ3QgYmUgdXNlZCBjb3JyZWN0bHkgZm9yDQo+IGFsbCB0aGVzZXMg
eWVhcnMuLi4gd2h5IGRvZXMgaXQgZXhpc3Q/DQoNCkJlY2F1c2UgYmFjayB0aGVuIHdlIGRpZG4n
dCBjYXJlIGFib3V0IGNvbnRhaW5lciBhd2FyZW5lc3MNCmVub3VnaCB0byBtYWtlIGl0IGFuIGlu
aXRpYWwgcGFydCBvZiB0aGUgZmVhdHVyZS4gV2Ugd2VyZQ0KdHJ5aW5nIHRvIGFkZHJlc3MgdGhl
IHByb2JsZW0gb2YgaG93IHRvIGVuc3VyZSB0aGF0IHRoZQ0KbmZzNF9jbGllbnRfaWQgaXMgdW5p
cXVlLiBCdXQgY2xlYXJseSBpdCB3YXMgb25seSBoYWxmIGENCnNvbHV0aW9uLg0KDQpUaGUgbW9k
dWxlIHBhcmFtZXRlciBzdGlsbCBleGlzdHMgYmVjYXVzZSB0aGUgZ2VuZXJhbCBydWxlDQphYm91
dCB0aGVzZSB0aGluZ3MgaXMgdGhhdCBtb2R1bGUgcGFyYW1ldGVycyBhcmUgcGFydCBvZiB0aGUN
Cmtlcm5lbCBBUEksIGFuZCBjYW4ndCBqdXN0IGJlIHJlbW92ZWQuIElmIHRoZXJlJ3MgYSBwcm9j
ZXNzDQpmb3IgcmVtb3ZpbmcgaXQsIHRoZW4gSSB3b3VsZCBhZ3JlZSB0byB0aGF0IG5vdyB0aGF0
IHdlIGhhdmUNCmEgc3lzZnMgQVBJIHRvIG1hbmFnZSB0aGUgbmZzNF9jbGllbnRfaWQgc2V0dGlu
Zy4NCg0KDQo+PiBJIGRvIGFncmVlIHRoYXQgaXQncyBsb25nIHBhc3QgdGltZSB3ZSBzaG91bGQg
YmUgc2V0dGluZw0KPj4gbmZzNF9jbGllbnRfaWQgcHJvcGVybHkuIEkgd291bGQgcmF0aGVyIHNl
ZSBhIHVkZXYgc2NyaXB0DQo+PiBkZXZlbG9wZWQgKHlvdSwgbWUsIG9yIEFsaWNlIGNvdWxkIGRv
IGl0IGluIGFuIGFmdGVybm9vbikNCj4+IGZpcnN0LiBJZiB0aGF0IGRvZXNuJ3QgbWVldCB0aGUg
YWN0dWFsIGN1c3RvbWVyIG5lZWQsIHRoZW4NCj4+IHdlIGNhbiByZXZpc2l0Lg0KPiBJJ2xsIGFk
ZHJlc3MgdGhpcyBpbiBUcm9uZCdzIHJlcGx5Li4uIA0KPiANCj4gdGhhbmtzIQ0KPiANCj4gc3Rl
dmVkLg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoNCg==
