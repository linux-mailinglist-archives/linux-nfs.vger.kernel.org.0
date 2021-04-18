Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE93636D8
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Apr 2021 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhDRQvp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Apr 2021 12:51:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58724 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhDRQvn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Apr 2021 12:51:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13IGpAbp082884;
        Sun, 18 Apr 2021 16:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Q72aRGKGZZTLVV3hKFWWY8a3diDxyjx0oYg7lZ5q180=;
 b=S4cF1/xLHYS7P6D15UN6niXhvFeWHdE4aSKihniQXb2RJwsZvu+hhXeBkaxUHKtS90RG
 k+DyrcnYSS6qdlW43DmkeypR/yT1yTnIeQXrTX4TXe9d4FesRkIoqjb3ADhv43v1I5AP
 CyB+J/EIjD6yZtELqrDJXmA08IfS99cTIn7gFZpBLdhi5rRCBv6hBTcEXlsji3n3LK72
 YBwWK5S1N6841BELxLwSuMKKBSRbl7uCuEtcKGu/8J3Lw/NW0zHRbnCmKXyN9wCREUVy
 C1kAPPyiDVmoHbwaCJWkp9rGWpYJrkdqO90sBpXn1sGI7DJfxzlM4HaORFI1z1amIALG eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37yqmn9p0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Apr 2021 16:51:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13IGoarW048610;
        Sun, 18 Apr 2021 16:51:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3809jwukqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Apr 2021 16:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9H032VxFwLmjTb9CbWIZZHWsqyCMkVSEiTunocGxpufwf0BPO32p7+vXh5Vaal8xbZtggAJHXry30/YICuhUE+jl3QfX9gCSB42kP9B/7hYfyZKV07pgKewygoFl/dtC+SRrA3F9GdGFetohHGjyYp3UFvN5opKrSwmls8oQAtR7mI0ozHx5O5nunTAFGoQlHqhiXnGEVo4Cq/Lq3tsBn/pxyO79nmyMksisTeEad6JjQNc8eJnvOIrpP7j/zp0O7uB3ZJRxS2lkKkiIaFXarEOu1xF2vi4gBlsCNsjyeNoR+176404J3mk0aXDeh+4da44F1uP9cbgWxK+5xQ88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q72aRGKGZZTLVV3hKFWWY8a3diDxyjx0oYg7lZ5q180=;
 b=PybxMrz4O2kIZsfy3cSgAuurPSPWh06yvq2cglfJPBKUZLLdjXWNH/rKjYUxQ+E7yb1V3Mqq3VNBX7wbChAxMMNsMbl4yN0WGQLjUXmtpL2hhzu0sPRWu/dlCJ2V9z/OaUnJzwatwpD07a/aprtGtUX+uSTHzrraMgCMPlM9o5amBSHPdehvVl4esjP/6+CiJ379wXrSwQoyNOpNJ8RLfOHkHGeL564o3ox7bwB2EFQf8ZhzfQ7rSVTe1wSxKnpZbRx5HYt1jEcbTXafFm09oJGtP8m2zJ7SWHOWBrcoAvXNoM8BDHawR32rK3DnSkCQMcbZqlkYMBwqBR4cFpI4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q72aRGKGZZTLVV3hKFWWY8a3diDxyjx0oYg7lZ5q180=;
 b=AVmyoRL7YN/tR6ffx1j1a7nr7fql2KaRY5F6mQpml89b+oudklDFV3ObRPTLv78dYq5WrDYHEhh0XDQO7gu1E8/HfaPyp9esbBM9jAN7CLjiD1oU46Y/GD5EGCrdEfzyDkMG61uFVaC0VMeZ7IR38iRyREQf4trbB9+po81yQHo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3414.namprd10.prod.outlook.com (2603:10b6:a03:15d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Sun, 18 Apr
 2021 16:51:08 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.024; Sun, 18 Apr 2021
 16:51:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@RedHat.com>
CC:     Alice J Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Topic: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Index: AQHXMVl21czF1oj/Wkexg55/eRtUL6q0qJzlgAEODgCAABHLgIADH5IAgAAEy4CAABTeAIABgakA
Date:   Sun, 18 Apr 2021 16:51:07 +0000
Message-ID: <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
References: <20210414181040.7108-1-steved@redhat.com>
 <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
 <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
 <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
 <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
 <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
 <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
In-Reply-To: <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: RedHat.com; dkim=none (message not signed)
 header.d=none;RedHat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b169616f-8684-4fa7-dac7-08d9028a29b7
x-ms-traffictypediagnostic: BYAPR10MB3414:
x-microsoft-antispam-prvs: <BYAPR10MB34149ED07395C10ACFB0B8B0934A9@BYAPR10MB3414.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CdBiG/9g1KD2uA6qDsGOwTR2nSH/WBNGi/2JYSnGHAwW/bwt1H7/df839WyWnYKOrhiEB3zIgdIv1tNvfNehwbbUBkXGVxRBgrvlbqqejMLGjXwTFgrP5tCGKG6srAo6f/Hfptw9LLm5St/ygP8gvt3rXd2lHBK8F0eJ/N9f5AfPxE8kYumSN397vIZb0qG23/VOfhda/uJO0888nh11t/6GhCDiPhUuybagcEaCQhHzDUFaWaNn41tW2mosOPVte8BxcnPt3wBlolt5FKHV67sbl1dg7zOyhVF/tj8x8ZwQMspiQXdybpG9+Gcg0IqkUpaUyJIqZulAqLjfCLimSRrcg0iJKQl2IYKsR1qVGkxZ7Avq4/hQ2O1pPRJsMpoBJI72WxjNT2ryUZm5Fml+yEYyJyRiB5vf848iRDGkhRGREgdlGwAMDcug6ZuNzTqkoDq1LisqfQgbHyA0xnfUSJah7egr9CHcshotqVeI2MY/O7L/Zwd/ft+EQqrL1HUSylhgs0lc7P+Z77PG1OSnHaAhqKBhpldFgnal3uOsyMa9N1Lc2dKrszXZ08aINdlW2AAu89uZlqleNTYdhhBC8A4KNTquxNXKBZJcV4cH9p2bAc8MVQMqC4TfJZAWSNBYGPjXNI9DHmCSxrC5Eh1EY+Xo6wgULqbNKZkULe91lZK2CZSraOdIdR6tn38Verq02sUsyAfVsXjpe/FxV4mr5Q4gG5AXRZJLvoxtb8y2hLDUHxYnmup2n5O2h5RReqX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(53546011)(478600001)(66446008)(122000001)(76116006)(66556008)(4326008)(36756003)(6916009)(6506007)(54906003)(316002)(91956017)(5660300002)(64756008)(966005)(66476007)(86362001)(2616005)(83380400001)(2906002)(8936002)(6486002)(66946007)(33656002)(26005)(71200400001)(186003)(38100700002)(8676002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QURJTkl2cGt3V0Nnbm9RWUFYUWpRVExuSys1SUxhR3pFbDd0SWNlZlg2ZkNo?=
 =?utf-8?B?YXMvVU84dTIzYWVILzFiRjRMYnVBRDhCbGIvY3ZQS2RBTlBEcEVMV1VtdHJF?=
 =?utf-8?B?bCtDRHRsSlh2YmtEY2xjTTNaejk4eGVIUFNlUEJxR2VtYjF6ZW0vKzVXOG1h?=
 =?utf-8?B?aGtZNUFZSFMyd1o2cTN5cndUNUx3cFBLNXdYU200cXJ5c3hkM2Ftem41N2FP?=
 =?utf-8?B?NEFTRkltVjl3a2pvbWxtMGdZY2doYTJINERBQ1kwMkk0WW5tR1FvckFkMXln?=
 =?utf-8?B?Q1pyYmh2dEc5T2xneDh3ZSswYnJ2WmhBNjhzRG91U3lDV1BkaGo1YjZGdE4r?=
 =?utf-8?B?YmdVTkFJcENLdit0M0NnSWlzSGIxQVB6dWNWNmlTMCtRWmcxYWlWUE9KQml4?=
 =?utf-8?B?M1drU09FbGdBQlg1eVFjQ29MaVBRTTBCbm40Mnd1QkhZdjZQdlVhRldCVnBz?=
 =?utf-8?B?VXRrSG5hSmp0L21TL3BEVDNWOHc1M2xqRS9hQjExaTZicVpHYXMzQmY0clZo?=
 =?utf-8?B?dGRPcEgvandyUklMN1Bwb2xXSU5WTUVVUDZYNzRpVVdwUVhRUWVia1VkSHRZ?=
 =?utf-8?B?MlZlRlBZK2d4V3pjZ2lJUU9xUElyWElSMmE2ZXMrVEpCeTU4b1RXQ2VvU1dP?=
 =?utf-8?B?WEx0Z3B4VWZLa1dWekY0ZWNmcGZJNWlLTXpScGdVVzJLQ1lrSnlxWFhqcjdY?=
 =?utf-8?B?bXVyRUlSN1ZHMkFtSk81d3MwVnUzRDdaZTVsVENtcFl2V0Z3ODQrb3FNS0sw?=
 =?utf-8?B?MWk1cTl2Q2tWZC9PK0EyckhiZzVYNUNkeGo1dXdkQ0NmZC96Q2pkOWd4K01H?=
 =?utf-8?B?c1BBL2JTWDdXaUhtdEMwUVBLZmlCOXlDTU9lYmRyYU50OGpLVWFjV1FCUWlL?=
 =?utf-8?B?Rm5JcXBJM29ucVloNXVQVGN0RUswNmJPL1BINDM1YzBYcDh0cUlyR24wRXla?=
 =?utf-8?B?MERXV093WFRLTlcyeDZ6cHlOR2dyWnhEWHg5dXZnYi9YOTRHUEwwZUN0YU5s?=
 =?utf-8?B?WHl3eW13VWN4WUhaVm5SaW1oSXhQcXV6OTRhTW9MdDZCTUdJdHV0aTh4ZW9p?=
 =?utf-8?B?MndrZzljU21DQkZQUlpwU1hkRWFvNWhiYlJDZTFNR0owTGRkb0RFcTBQaFVQ?=
 =?utf-8?B?UDRueDRpRm5Uc0dwMXZJa1BLWTdhTWgyejlMQS9KYVFqM0JZbmZ3K2tkT1dt?=
 =?utf-8?B?cks2ZXVCeWhFcExSaUpQcE0zMUszM3NUQ3p3aTYzazQwZ0JuTm5OSUpxVmZ5?=
 =?utf-8?B?bzlLTDF0RmNIWkQxQWpmYWF4aGtyUXQyNWNZYm9lVUUzNUZGMTZIS0NIa0Zh?=
 =?utf-8?B?OTN2Nkh0YXFlZmZZazFjVnhpZ2tFWkhTQnYrQ3pPTC9SMVZNT2k0T0lkVkRQ?=
 =?utf-8?B?ZUFJbTNBbDBrYUZ5eGJwY05Ub084NjFFNnNuMmNSNWMrL1ptcVJiYndnM1lt?=
 =?utf-8?B?RTZ3WklZMElXTXBNVTFxL1lzLzZ6WXNKVU5NYnIyV29zeHRnSFVEbUtNcUdt?=
 =?utf-8?B?cTBaZ1hnWTZRcVFpdERMMzBNUGp0NEpwT0VRUnZPMkUwWnpJR1NlZTlKY205?=
 =?utf-8?B?R2RqaTVlNy9FMC9VYlhGR25pd1dQZzFXUGN1aFpCNGZmQ2NxdU9ORkdacWtP?=
 =?utf-8?B?ZUF6bTZyRU5JblJCS09qcU1WdnpDUzJaeS9XNHVqZFBPOERsaStxTk5tbXdy?=
 =?utf-8?B?eFhYdmFVZTlMVzdkQmt2SHhUK1hSS1orRS9aMDJraXh0SGsyRndOcG5SVEMw?=
 =?utf-8?Q?IfCALgSO7PB00vanpa55US9OBZoneOZByafKGE3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <568AAB1AD4F609478E23497D4571BAE8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b169616f-8684-4fa7-dac7-08d9028a29b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2021 16:51:07.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4pcP8VfqywZxOy/Z1xNikO+JxP7evYFKC6JXcpaEkjWSVw1TtP7zo+m7Ah+JYTxLs2P4ZZkFRds1tp9dKeD1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3414
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9958 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104180118
X-Proofpoint-ORIG-GUID: LVZsU1tfcQs0URB448FHYlwb49BfBHe3
X-Proofpoint-GUID: LVZsU1tfcQs0URB448FHYlwb49BfBHe3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9958 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104180118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXByIDE3LCAyMDIxLCBhdCAxOjUwIFBNLCBTdGV2ZSBEaWNrc29uIDxTdGV2ZURA
UmVkSGF0LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDQvMTcvMjEgMTI6MzYgUE0sIENo
dWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXByIDE3LCAyMDIxLCBhdCAx
MjoxOCBQTSwgU3RldmUgRGlja3NvbiA8U3RldmVEQFJlZEhhdC5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IA0KPj4+IA0KPj4+IE9uIDQvMTUvMjEgMTI6MzcgUE0sIENodWNrIExldmVyIElJSSB3cm90
ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gQXByIDE1LCAyMDIxLCBhdCAxMTozMyBBTSwgU3Rl
dmUgRGlja3NvbiA8U3RldmVEQFJlZEhhdC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBIZXkg
Q2h1Y2shIA0KPj4+Pj4gDQo+Pj4+PiBPbiA0LzE0LzIxIDc6MjYgUE0sIENodWNrIExldmVyIElJ
SSB3cm90ZToNCj4+Pj4+PiBIaSBTdGV2ZS0NCj4+Pj4+PiANCj4+Pj4+Pj4gT24gQXByIDE0LCAy
MDIxLCBhdCAyOjEwIFBNLCBTdGV2ZSBEaWNrc29uIDxTdGV2ZURAcmVkaGF0LmNvbT4gd3JvdGU6
DQo+Pj4+Pj4+IA0KPj4+Pj4+PiDvu79UaGlzIGlzIGEgdHdlYWsgb2YgdGhlIHBhdGNoIHNldCBB
bGljZSBNaXRjaGVsbCBwb3N0ZWQgbGFzdCBKdWx5IFsxXS4NCj4+Pj4+PiANCj4+Pj4+PiBUaGF0
IGFwcHJvYWNoIHdhcyBkcm9wcGVkIGxhc3QgSnVseSBiZWNhdXNlIGl0IGlzIG5vdCBjb250YWlu
ZXItYXdhcmUuDQo+Pj4+Pj4gSXQgc2hvdWxkIGJlIHNpbXBsZSBmb3Igc29tZW9uZSB0byB3cml0
ZSBhIHVkZXYgc2NyaXB0IHRoYXQgdXNlcyB0aGUNCj4+Pj4+PiBleGlzdGluZyBzeXNmcyBBUEkg
dGhhdCBjYW4gdXBkYXRlIG5mczRfY2xpZW50X2lkIGluIGEgbmFtZXNwYWNlLiBJDQo+Pj4+Pj4g
d291bGQgcHJlZmVyIHRoZSBzeXNmcy91ZGV2IGFwcHJvYWNoIGZvciBzZXR0aW5nIG5mczRfY2xp
ZW50X2lkLA0KPj4+Pj4+IHNpbmNlIGl0IGlzIGNvbnRhaW5lci1hd2FyZSBhbmQgbWFrZXMgdGhp
cyBzZXR0aW5nIGNvbXBsZXRlbHkNCj4+Pj4+PiBhdXRvbWF0aWMgKHplcm8gdG91Y2gpLg0KPj4+
Pj4gQXMgSSBzYWlkIGluIGluIG15IGNvdmVyIGxldHRlciwgSSBzZWUgdGhpcyBtb3JlIGFzIGlu
dHJvZHVjdGlvbiBvZg0KPj4+Pj4gYSBtZWNoYW5pc20gbW9yZSB0aGFuIGEgd2F5IHRvIHNldCB0
aGUgdW5pcXVlIGlkLg0KPj4+PiANCj4+Pj4gWWVwLCBJIGdvdCB0aGF0Lg0KPj4+PiANCj4+Pj4g
SSdtIG5vdCBhZGRyZXNzaW5nIHRoZSBxdWVzdGlvbiBvZiB3aGV0aGVyIGFkZGluZyBhDQo+Pj4+
IG1lY2hhbmlzbSB0byBzZXQgYSBtb2R1bGUgcGFyYW1ldGVyIGluIG5mcy5jb25mIGlzIGdvb2QN
Cj4+Pj4gb3Igbm90LiBJJ20gc2F5aW5nIG5mczRfY2xpZW50X2lkIGlzIG5vdCBhbiBhcHByb3By
aWF0ZQ0KPj4+PiBwYXJhbWV0ZXIgdG8gYWRkIHRvIG5mcy5jb25mLiBDYW4geW91IHBpY2sgYW5v
dGhlcg0KPj4+PiBtb2R1bGUgcGFyYW1ldGVyIGFzIGFuIGV4YW1wbGUgZm9yIHlvdXIgbWVjaGFu
aXNtPw0KPj4+IFRoZSByZXF1ZXN0IHdhcyB0byBzZXQgdGhhdCBwYXJhbWV0ZXIuLi4NCj4+IA0K
Pj4gVGhlIGNvdmVyIGxldHRlciBhbmQgdGhlIHF1b3RlZCBlLW1haWwgYWJvdmUgc3RhdGUgdGhh
dA0KPj4geW91IGFyZSBqdXN0IGRlbW9uc3RyYXRpbmcgYSBtZWNoYW5pc20gdG8gc2V0IG1vZHVs
ZQ0KPj4gcGFyYW1ldGVycyB2aWEgbmZzLmNvbmYuIEkgZ3Vlc3MgdGhhdCBzdGF0ZW1lbnQgd2Fz
IG5vdA0KPj4gZW50aXJlbHkgYWNjdXJhdGUsIHRoZW4uIFRoYW5rcyBmb3IgY2xhcmlmeWluZy4N
Cj4gSSB3YXMgdHJ5aW5nIHRvIGtlZXAgdGhlIGNvbnZlcnNhdGlvbiBvZmYgb2Ygd2hhdA0KPiB3
YXMgYmVpbmcgc2V0IHRvIGhvdyBpdCB3YXMgYmVpbmcgc2V0Li4uIA0KPiANCj4gSSBoYWQgbm8g
aWRlYSB0aGUgZW50aXJlICJvcHRpb25zIG5mcyIgQVBJIGlzIGNvbXByb21pc2VkDQo+IHdoZW4g
aXQgY29tZXMgdG8gY29udGFpbmVycy4uLiBOb3Qgc3VyZSB3aHkuLi4gYnV0IEkgd2lsbA0KPiBi
ZWxpZXZlIHlvdS4uLg0KDQpNb2R1bGUgcGFyYW1ldGVycyB0YWtlIGVmZmVjdCBmb3IgYWxsIG5h
bWVzcGFjZXMuIEl0J3MNCm5vdCBqdXN0IG5mcy5rbyB0aGF0IGhhcyB0aGlzIGlzc3VlLg0KDQoN
Cj4+IElmIHRoZXJlJ3MgYSBidWcgcmVwb3J0IHNvbWV3aGVyZSB0aGF0IHJlcXVlc3RzIGENCj4+
IGZlYXR1cmUsIGl0J3Mgbm9ybWFsIHByYWN0aWNlIHRvIGluY2x1ZGUgYSBVUkwgcG9pbnRpbmcN
Cj4+IHRvIHRoYXQgcmVwb3J0IGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCj4gSSBqdXN0IGFz
c3VtZWQsIHNpbmNlIGl0IGhhZCBhIGN1c3RvbWVyIGNhc2UsIHRoZSBieiB3YXMgDQo+IHByaXZh
dGUuLi4gaXQgdHVybnMgb3V0IG5vdCB0byBiZSB0aGUgY2FzZQ0KPiBodHRwczovL2J1Z3ppbGxh
LnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE4MDEzMjYNCg0KPj4+Pj4gQWN0dWFsIEkgaGF2
ZSBjdXN0b21lcnMgYXNraW5nIGZvciB0aGlzIHR5cGUNCj4+Pj4+IG9mIGZ1bmN0aW9uYWxpdHkN
Cg0KSHJtLiBUaGUgcmVwb3J0ZXIgb2YgMTgwMTMyNiBpcyBkd3lzbywgYSBSZWQgSGF0IGVtcGxv
eWVlLA0Kbm90IGEgY3VzdG9tZXIuDQoNCkFsc28sIEkgc2VlIG5vdGhpbmcgdGhhdCByZXF1aXJl
cyBpdCB0byBiZSBzZXQgaW4gbmZzLmNvbmYuDQpTbyB3aGF0IGFjdHVhbCBmdW5jdGlvbmFsaXR5
IGlzIGJlaW5nIHJlcXVlc3RlZCwgYW5kIHdoeQ0KY2FuJ3QgaXQgYmUgYWRkcmVzc2VkIHdpdGgg
YSB1ZGV2IHNjcmlwdCwgd2hpY2ggaGFzIGJlZW4NCnRoZSBkZXNpZ24gYWxyZWFkeSBpbiB0aGUg
d29ya3MgZm9yIG1hbnkgbW9udGhzPw0KDQoNCj4+Pj4gQXNrIHlvdXJzZWxmIHdoeSB0aGV5IG1p
Z2h0IHdhbnQgaXQuIEl0J3MgcHJvYmFibHkgYmVjYXVzZQ0KPj4+PiB3ZSBkb24ndCBzZXQgaXQg
Y29ycmVjdGx5IGN1cnJlbnRseS4gSWYgd2UgaGF2ZSBhIHdheSB0bw0KPj4+PiBhdXRvbWF0aWNh
bGx5IGdldCBpdCByaWdodCBldmVyeSB0aW1lLCB0aGVyZSdzIHJlYWxseSBubw0KPj4+PiBuZWVk
IGZvciB0aGlzIHNldHRpbmcgdG8gYmUgZXhwb3NlZC4NCj4+PiBJZiB3ZSBzaG91bGRuJ3QgZXhw
b3NlIGl0Li4uIExldHMgZ2V0IHJpZCBvZiBpdC4uLg0KPj4+IFlvdSBhZGRlZCB0aGUgcGFyYW0g
aW4gdGhlIGZhbGwgMjAxMi4uLiBJZiBpdCBoYXNuJ3QNCj4+PiBiZWVuIHVzZWQgY29ycmVjdGx5
IG9yIGNhbid0IGJlIHVzZWQgY29ycmVjdGx5IGZvcg0KPj4+IGFsbCB0aGVzZXMgeWVhcnMuLi4g
d2h5IGRvZXMgaXQgZXhpc3Q/DQo+PiANCj4+IEJlY2F1c2UgYmFjayB0aGVuIHdlIGRpZG4ndCBj
YXJlIGFib3V0IGNvbnRhaW5lciBhd2FyZW5lc3MNCj4+IGVub3VnaCB0byBtYWtlIGl0IGFuIGlu
aXRpYWwgcGFydCBvZiB0aGUgZmVhdHVyZS4gV2Ugd2VyZQ0KPj4gdHJ5aW5nIHRvIGFkZHJlc3Mg
dGhlIHByb2JsZW0gb2YgaG93IHRvIGVuc3VyZSB0aGF0IHRoZQ0KPj4gbmZzNF9jbGllbnRfaWQg
aXMgdW5pcXVlLiBCdXQgY2xlYXJseSBpdCB3YXMgb25seSBoYWxmIGENCj4+IHNvbHV0aW9uLg0K
PiBSaWdodC4uLiBJIHdhcyBqdXN0IHRyeWluZyB0byBidWlsZCBhIG1lY2hhbmlzbSB0bw0KPiBz
ZXQgdGhlIHZhbHVlLCBhbmQgbm90IHdvcnJ5aW5nICh5ZXQpIGFib3V0IHdoYXQgdGhlDQo+IHZh
bHVlIGlzIHNldCB0by4uLiANCj4gDQo+IFNvIGF0IHRoaXMgcG9pbnQsIGFsbCBvZiB0aGUgbmZz
IGtlcm5lbCBtb2R1bGUgcGFyYW1ldGVyDQo+IGNhbiBiZSBzZXQgdGhyb3VnaCB0aGUgc3lzZnMv
dWRldiBpbnRlcmZhY2U/DQoNClRoZSBvbmx5IG1vZHVsZSBwYXJhbWV0ZXIgdGhhdCBoYXMgYmVl
biBleHBsaWNpdGx5IHJlcGxhY2VkDQppcyB0aGUgb25lIHRoYXQgc2V0cyBuZnM0X2NsaWVudF9p
ZCwgYXMgZmFyIGFzIEkgYW0gYXdhcmUuDQpUaGVyZSBtaWdodCBiZSBzb21lIG90aGVyIHNldHRp
bmdzIGF2YWlsYWJsZSBpbiAvc3lzOg0KDQojIGxzIC9zeXMvbW9kdWxlL25mc3Y0L3BhcmFtZXRl
cnMNCmRlbGVnYXRpb25fd2F0ZXJtYXJrICBsYXlvdXRzdGF0c190aW1lcg0KIw0KDQpbY2VsQG1h
bmV0IGxpbnV4XSQgZ2l0IGdyZXAgTU9EVUxFX1BBUk0gLS0gZnMvbmZzLw0KZnMvbmZzL2NhY2hl
X2xpYi5jOk1PRFVMRV9QQVJNX0RFU0MoY2FjaGVfZ2V0ZW50LCAiUGF0aCB0byB0aGUgY2xpZW50
IGNhY2hlIHVwY2FsbCBwcm9ncmFtIik7DQpmcy9uZnMvY2FjaGVfbGliLmM6TU9EVUxFX1BBUk1f
REVTQyhjYWNoZV9nZXRlbnRfdGltZW91dCwgIlRpbWVvdXQgKGluIHNlY29uZHMpIGFmdGVyIHdo
aWNoICINCmZzL25mcy9kaXIuYzpNT0RVTEVfUEFSTV9ERVNDKG5mc19hY2Nlc3NfbWF4X2NhY2hl
c2l6ZSwgIk5GUyBhY2Nlc3MgbWF4aW11bSB0b3RhbCBjYWNoZSBsZW5ndGgiKTsNCmZzL25mcy9m
aWxlbGF5b3V0L2ZpbGVsYXlvdXRkZXYuYzpNT0RVTEVfUEFSTV9ERVNDKGRhdGFzZXJ2ZXJfcmV0
cmFucywgIlRoZSAgbnVtYmVyIG9mIHRpbWVzIHRoZSBORlN2NC4xIGNsaWVudCAiDQpmcy9uZnMv
ZmlsZWxheW91dC9maWxlbGF5b3V0ZGV2LmM6TU9EVUxFX1BBUk1fREVTQyhkYXRhc2VydmVyX3Rp
bWVvLCAiVGhlIHRpbWUgKGluIHRlbnRocyBvZiBhIHNlY29uZCkgdGhlICINCmZzL25mcy9mbGV4
ZmlsZWxheW91dC9mbGV4ZmlsZWxheW91dC5jOk1PRFVMRV9QQVJNX0RFU0MoaW9fbWF4cmV0cmFu
cywgIlRoZSAgbnVtYmVyIG9mIHRpbWVzIHRoZSBORlN2NC4xIGNsaWVudCAiDQpmcy9uZnMvZmxl
eGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXRkZXYuYzpNT0RVTEVfUEFSTV9ERVNDKGRhdGFzZXJ2
ZXJfcmV0cmFucywgIlRoZSAgbnVtYmVyIG9mIHRpbWVzIHRoZSBORlN2NC4xIGNsaWVudCAiDQpm
cy9uZnMvZmxleGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXRkZXYuYzpNT0RVTEVfUEFSTV9ERVND
KGRhdGFzZXJ2ZXJfdGltZW8sICJUaGUgdGltZSAoaW4gdGVudGhzIG9mIGEgc2Vjb25kKSB0aGUg
Ig0KZnMvbmZzL25hbWVzcGFjZS5jOk1PRFVMRV9QQVJNX0RFU0MobmZzX21vdW50cG9pbnRfZXhw
aXJ5X3RpbWVvdXQsDQpmcy9uZnMvc3VwZXIuYzpNT0RVTEVfUEFSTV9ERVNDKGNhbGxiYWNrX25y
X3RocmVhZHMsICJOdW1iZXIgb2YgdGhyZWFkcyB0aGF0IHdpbGwgYmUgIg0KZnMvbmZzL3N1cGVy
LmM6TU9EVUxFX1BBUk1fREVTQyhuZnM0X2Rpc2FibGVfaWRtYXBwaW5nLA0KZnMvbmZzL3N1cGVy
LmM6TU9EVUxFX1BBUk1fREVTQyhtYXhfc2Vzc2lvbl9zbG90cywgIk1heGltdW0gbnVtYmVyIG9m
IG91dHN0YW5kaW5nIE5GU3Y0LjEgIg0KZnMvbmZzL3N1cGVyLmM6TU9EVUxFX1BBUk1fREVTQyht
YXhfc2Vzc2lvbl9jYl9zbG90cywgIk1heGltdW0gbnVtYmVyIG9mIHBhcmFsbGVsIE5GU3Y0LjEg
Ig0KZnMvbmZzL3N1cGVyLmM6TU9EVUxFX1BBUk1fREVTQyhzZW5kX2ltcGxlbWVudGF0aW9uX2lk
LA0KZnMvbmZzL3N1cGVyLmM6TU9EVUxFX1BBUk1fREVTQyhuZnM0X3VuaXF1ZV9pZCwgIm5mc19j
bGllbnRfaWQ0IHVuaXF1aWZpZXIgc3RyaW5nIik7DQpmcy9uZnMvc3VwZXIuYzpNT0RVTEVfUEFS
TV9ERVNDKHJlY292ZXJfbG9zdF9sb2NrcywNCltjZWxAbWFuZXQgbGludXhdJCBnaXQgZ3JlcCBN
T0RVTEVfUEFSTSAtLSBmcy9uZnNkLw0KZnMvbmZzZC9uZnM0aWRtYXAuYzpNT0RVTEVfUEFSTV9E
RVNDKG5mczRfZGlzYWJsZV9pZG1hcHBpbmcsDQpmcy9uZnNkL25mczRwcm9jLmM6TU9EVUxFX1BB
Uk1fREVTQyhpbnRlcl9jb3B5X29mZmxvYWRfZW5hYmxlLA0KZnMvbmZzZC9uZnM0cmVjb3Zlci5j
Ok1PRFVMRV9QQVJNX0RFU0MoY2x0cmFja19wcm9nLCAiUGF0aCB0byB0aGUgbmZzZGNsdHJhY2sg
dXBjYWxsIHByb2dyYW0iKTsNCmZzL25mc2QvbmZzNHJlY292ZXIuYzpNT0RVTEVfUEFSTV9ERVND
KGNsdHJhY2tfbGVnYWN5X2Rpc2FibGUsDQpbY2VsQG1hbmV0IGxpbnV4XSQNCg0KRWFjaCBvZiB0
aGUgYWJvdmUgaGFzIHRvIGJlIGNvbnNpZGVyZWQgb24gYSBjYXNlLWJ5LWNhc2UNCmJhc2lzLCBJ
TU8uDQoNCg0KPiBJZiB0aGF0IGlzIHRoZSBjYXVzZS4uLiBoYXZlIHRoZSB2YXJpYWJsZXMgaW4g
DQo+IG5mcy5jb25mIGNyZWF0ZSBzeXNmcy91ZGV2IGZpbGUgd291bGQgd29yayBiZXR0ZXI/DQoN
ClNlZW1zIHRvIG1lIHdlIGhhdmUgdGhlIHNhbWUgYXJndW1lbnQgZm9yIGEgc2VwYXJhdGUgZmls
ZQ0KdG8gc3RvcmUgdGhlIG5mczRfdW5pcXVlX2lkIHRoYXQgd2UgaGF2ZSBmb3IgYnJlYWtpbmcN
Ci9ldGMvZXhwb3J0cyBpbnRvIGEgZGlyZWN0b3J5IG9mIGluZGl2aWR1YWwgZmlsZXM6IG5vDQpw
YXJzaW5nIGlzIG5lY2Vzc2FyeS4gU2NyaXB0cyBhbmQgYXBwbGljYXRpb25zIGNhbiBzaW1wbHkN
CnJlYWQgdGhlIHN0cmluZyByaWdodCBvdXQgb2YgdGhlIGZpbGUsIG9yIHVwZGF0ZSBpdCBqdXN0
DQpieSB3cml0aW5nIHRoZSBzdHJpbmcgaW50byB0aGF0IGZpbGUuDQoNCkNvbnZlcnNlbHksIHRo
ZXJlJ3Mgbm8gY2xlYXIgbmVlZCBmb3IgYWRtaW5pc3RyYXRvcnMgdG8gYmUNCmF3YXJlIG9mIHRo
ZSBzZXR0aW5nLCBvbmNlIGl0IGlzIGJlaW5nIHNldCBwcm9wZXJseS4NCg0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQoNCg==
