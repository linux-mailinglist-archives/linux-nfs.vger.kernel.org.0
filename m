Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9024371F18
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhECSDH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 14:03:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhECSDH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 May 2021 14:03:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143I0Juj120148;
        Mon, 3 May 2021 18:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yIums4JGbVGe4IANG4edLVE+SGrXEiwPL3wcQ4JTv5I=;
 b=UI2h+bLneoW7jzwYqxRnnmLsZVjHtKqvhr7GcEZxK5qk9N2g0XAYY93rBoRgwzc7vH2R
 eOyEABNiJcQJcp4flF5khla0Y//GgsTjPOZbb+KUJk+3GLXmSG+jJn6h5EsdnqkSKuQq
 Dp+HOvrjTy9jjCvOMxUp9ey0v4G/DdZq8/IEEe/hFZcJtc3wFg7uVVnIM5bc0EDSiVAv
 a6wwm0gw8rLuQ5h+bl5zvbVnHgXHfo/nFTVlNGLDmOAZLlhm8yfUE4AuAZJkvuhjxbbH
 xs2OGtsGWxRdVK8/ccFOIq+tGNyG0X+rdBSw/xdYjXHdzUvtjWbB0efZmqoi13n9ZmyH wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 389h13udb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 18:02:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143I1MaK186203;
        Mon, 3 May 2021 18:02:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 388w1cyp3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 18:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB9iU/5/qTHkt+WeGk39sJ3MTx8IR+1jwLn7A5bnWb1MxvKZrpl3BrLXCIav5WQz36WXFdoLSw7OwsGWr5071jP4G8Sa4TbcOOLxKyzm8KM+s2WNbXcyzIHACPcB0knVPZtuN56rcyyeKTPX6fzbPRXD6SNjM1GfR1NPmhVkEF8BlW1VR+jys4H/vBpwL20nLa++fI8qy9W3xpf9jZFZKFe/Ag6fO4CKJQ+ScQPVHFJtkUM2qf6WuokTYQRfmuni8mF5MLN2UXPP4sLIjd+op9LzIqoSbNoEDCKLBIfhTp6FbBdbg6IfoaPXwtFq4rPq44UjcrnPNkVWqZ/tiZ4N0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIums4JGbVGe4IANG4edLVE+SGrXEiwPL3wcQ4JTv5I=;
 b=FgavOlFKSQpAjF64D2vMLezzQXby0NScj/UIE9fF1wOk8GOpN4bqmChDMOLFTeDf2IWJknjCvt6oHRtMBSB7QixdSx/+9eLHle6sXdlOx/IyqlsmcJj4XXTp2Sqs4JHHugQBDW3cNWCzpk3vr37N3QmyiQ8WC/GDQv1Nc5NXFTkH5ToAEbs5mg7mPa3n6wA1JXxLYcnsDOyGj+R5B9vEsyl2IL0r3R3Rv6qRwNUd0Kdqciod71SDrjZx4wiuG2iq2opS/Dr/W/rdmuLtIaTYPLUe+Y0+MIaDbWy8zAMb17EVpLVk4bucR3kgLFbTRThLf6TxJ+zUGJXSdv4CZVWgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIums4JGbVGe4IANG4edLVE+SGrXEiwPL3wcQ4JTv5I=;
 b=TUuZjEdsguDgZ66GnSNAKx4HllAQuabAm7jMfx/NTCXlkwA/Wzf99/sXCF0Ft+dKnnadvjyAvAPU4Obz7qQzckn8yCHB6YPnwd5YPgfgACu3fRQmJY7o3HyPrM6YSERfK+9tsWXNK+92wid3BYHbD2TtDo9APpSTp1Wbrxq7m4Y=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 18:02:10 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 18:02:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 00/29] server-side lockd XDR overhaul
Thread-Topic: [PATCH v1 00/29] server-side lockd XDR overhaul
Thread-Index: AQHXQDAw6Kf6el8xGkaS8Y2w4uktuKrSC7GAgAAAzAA=
Date:   Mon, 3 May 2021 18:02:09 +0000
Message-ID: <CD0083F8-BCA1-465F-B308-C063FF03CB25@oracle.com>
References: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
 <20210503175917.GA18779@fieldses.org>
In-Reply-To: <20210503175917.GA18779@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d40adad-67c9-4292-5396-08d90e5d9269
x-ms-traffictypediagnostic: BY5PR10MB4259:
x-microsoft-antispam-prvs: <BY5PR10MB4259C1000EE7443D359B641A935B9@BY5PR10MB4259.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSqescNbzwVDMaN4jS4vH4ULwd96Ws/foawd8JKtPKHwGGT/Mq5x7SQVgiors266InMfyWLdSQJz8r2eKNxFrV1lqM+bMgPCtbycLKklQisWtDM7bYy+IYD2usLbInPMuOde4fLVY0mLwsA1CaiHyh3+EL3ybLiCG0osEY9r8N4zNRtH/mGpVvQxCgkkEjVkVlDXODtUGlFi2vMXjYhD98Rh06Rt4WCxrFABSS4o0oYb9BN85MgWntwQTGlFvj9iRilcP9X0aAdHXYxcbmrTsNjxKJODqhoepLwJZQfnUb27yR4C/Zdk8utaocQlNjkK9jrsbKm8lGGSqPYicN+IqvzmQFtA6uw5iJei7/acg1VAQv14tCMUbNEkRxvUoo/Q4jym2RQMcVxfLHN3FZvB5i0U+GCkoKM6UT0iGBOOGxo7szpe1J+OFp70ax0xwss31vIzKm5jis/gWtNtgUdZlyFbDVSvKDWSkIwSbLvKo6APQV7GheWBPZk3iUGE/ieR2whykiYDQ+nATEP46kUPJHcxpESsQbZzsqXMA/41RbZeIiwSv1+KWG5f5+WwD1YeMJsZpdpOFF32Bria1KvW7YrLpJT6iVV5TzWc+j6WhUBkikAumtVlHQKYmsqpSJ07TbZkQrbPLMfBCmFjIhiwbjTzudBHJbHMz4ltTAgyV6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(6512007)(71200400001)(6486002)(38100700002)(86362001)(2906002)(2616005)(83380400001)(66446008)(64756008)(316002)(5660300002)(66556008)(36756003)(8936002)(33656002)(66946007)(6506007)(186003)(8676002)(122000001)(91956017)(6916009)(4326008)(76116006)(53546011)(26005)(478600001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cXl2NHJnUUp4Z1hFeE96M3RSeHk2MWRKY0djVTdtQXpLdFIvN080dmFLM01S?=
 =?utf-8?B?R05OUVhWMzM4aDRTMW5xRWxFODN4WGlMK0w4R0ZtN3lPSUw1R0lieEl0YUty?=
 =?utf-8?B?WjY4eW53cUNjM3RIWjk3WFY2UTVORndXOThmemdZd3NMR3psUXdjNVZER1V3?=
 =?utf-8?B?QmZnaG5wdkUwcDlvQkJxY0hLVGVWMWFOSHF2YjhibVFSd0dsc0hKdUowdGZu?=
 =?utf-8?B?cnA5MHA3Rms1S2xoM1JYSFl5azN1WFJmRmd3dXQrMDZaekFnNlRzeDVlbG4w?=
 =?utf-8?B?VTRmRFhkekg1MGk4cnVldmNvZzdVVTVaZ1VXN1hTeHJ6dEJLT25RbkRyOVR3?=
 =?utf-8?B?QVYrQXRkdVhxeDRGYzBkVGxRYW9zRnl6bGtVUlpxbVdwVXNJMlQzU1ZTamVR?=
 =?utf-8?B?SFUramYwUkJtYU42RnU3RkhrSGt0NVFNejNjTnNmMGdMOUhxay90V1VqaVQ1?=
 =?utf-8?B?cFRGbHVyU05tbWZwbWw3MHNpMGhMczQ3d0JpejhxVDU5czZvUDl1bitHb2l2?=
 =?utf-8?B?VFFaOStZU3h1dURCajRHc1kvY0lQT1lraStCTEtJbThFY1ZkZVU4WjZoS050?=
 =?utf-8?B?Zy84emtrNnVpN2xwYU9LNC9UenVWMmFiUi8wMDNZdHVrNlNodzVnWllhd3R1?=
 =?utf-8?B?YjR0dk5pQmRXRG5BdUNqL2tFUFNlblV0b1lyNG9wbHpudkZ5cDRlVGZvSnl5?=
 =?utf-8?B?ZmxVTEdJdm16ZmpYYURoKzRzL1NCREVpazFGeGlDcXMrVDA1RTZpNHlzVEVl?=
 =?utf-8?B?dzVFajhBWHlXaUN4ZGdobWlteUlxcjZYK2V2MHNzUHg1YVBUNE10MlJyT3Bh?=
 =?utf-8?B?WlFxeGMxODVxMW82SDlnbDBKSkFyMi9ubTkyMXNFWlBxT2NpaVUyV2xpMzRO?=
 =?utf-8?B?WnhhRURYbGloMVFxbmRhelJPS3QrNTdoZ05INnJZMGE3c3ZZbktrK3JXQWI3?=
 =?utf-8?B?ZldSM2UwQlFFYXM3bUN5TU1BV0hzNjMva0ZqZDNTWTVXZ2pUam1CUHozbzRq?=
 =?utf-8?B?YUM3WXQvWSsvcnRpbXVXbENkUzhuSXQ3OVAzVnl1VEdXOWdmU1BtKzVPK1Ni?=
 =?utf-8?B?STVpaGJBQU53UngyYlVscm5Ld3MwMXZtMnNET3c0aGhMaUluTGYzbGpIa0xl?=
 =?utf-8?B?R0xiY2tDSUltYmZaY3Fiamh3M1YrSlV0NUFkQlhWNnV4ajhyMDlnV2FKbEsy?=
 =?utf-8?B?OXFaTXM0WVV1aXpNSW55b29mOWJxWDVqaWlBQjE3RVhvQm5waERSaUV0NzhG?=
 =?utf-8?B?MXloVjVKSGJLeTVOYytFVHFBbi9SMWwwSHNGSUJ2dnZnODdWUk9GVmlYVzV6?=
 =?utf-8?B?dGNRRWtMeXJWSnQ3UTRNd2pHODlQUW95Nmo5N3FCakZEdFgzUzNoOXNsOHd2?=
 =?utf-8?B?RU1LcVYzTnB3MDlXS21hT25SZjQzM1QzNWlsN1BOZmNhd2lVaUxucmN3RTFu?=
 =?utf-8?B?by9RK3JVbUVJWnNDcmdhTXdMT2ZlWCtSUnVNOE00MHF4N2VPbE4zUW9XNUZ1?=
 =?utf-8?B?MDMxcEYwbU00NHUwcXlqV0tvdmlCM3NpUmxPNlVxUk42aHNnblUzSjlnTU1r?=
 =?utf-8?B?Z0dvODBsWTh0M09xcFNCVkQreWlMUlNxV3l1eTFVeTBBN2srOUx4VFJOelc3?=
 =?utf-8?B?N1ZCLzJFcms1VXlvOUNseEE2TDZVbW4xZTVOTGFhUTU5ZXNodlo0VGRyQzJG?=
 =?utf-8?B?eG9rbkNvSTVjWE9JRDVZMFdJV0VYN0krZ210UnVlQ1d2TDNwenRPT3NwT252?=
 =?utf-8?Q?bcBTPKM9bcM27SNzbSVdqaVjkdrBpNcLrpfVhip?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D033A1BBB0A3468CD1F115EE1FE3E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d40adad-67c9-4292-5396-08d90e5d9269
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 18:02:09.9584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9GS6zJQCbXPHkiqDO6NVso3rYOxus0LTWynLAP5F8CkmYimOUYYWFrmehtS8Cklr367HeNC/Is3aCCRUKOiUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030119
X-Proofpoint-ORIG-GUID: ImMJP3S_CQky1lBeFFQKS5Kplp_wqhh3
X-Proofpoint-GUID: ImMJP3S_CQky1lBeFFQKS5Kplp_wqhh3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDMsIDIwMjEsIGF0IDE6NTkgUE0sIEouIEJydWNlIEZpZWxkcyA8YmZpZWxk
c0BmaWVsZHNlcy5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBNYXkgMDMsIDIwMjEgYXQgMTE6
MjI6NDdBTSAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+PiBTYW1lIGFwcHJvYWNoIGFzIHdo
YXQgaGFzIGJlZW4gZG9uZSBmb3IgTkZTdjIsIE5GU3YzLCBhbmQgTkZTdjQ6IFhEUg0KPj4gZGVj
b2RpbmcgYW5kIGVuY29kaW5nIGZ1bmN0aW9ucyBoYXZlIGJlZW4gdXBkYXRlZCB0byB1c2UgeGRy
X3N0cmVhbS4NCj4+IFRoaXMgYWRvcHRzIGNvbW1vbiBYRFIgaW5mcmFzdHJ1Y3R1cmUgZm9yIHRo
ZXNlIGZ1bmN0aW9ucyBhbmQgbWFrZXMNCj4+IGNvbnN0cnVjdGluZyBhbmQgcGFyc2luZyBtb3Jl
IHNlY3VyZSBhbmQgcm9idXN0Lg0KPiANCj4gTm90aGluZyBvYmplY3Rpb25hYmxlIHRvIG1lIG9u
IGEgcXVpY2sgc2tpbSwgYnV0IGl0IGRvZXNuJ3QgYnVpbGQgd2hlbiBJDQo+IGFwcGx5IHRvIDUu
MTIgKGZzL2xvY2tkL3N2Yy5jOjc5NDo5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YN
Cj4gZnVuY3Rpb24g4oCYc3ZjeGRyX2luaXRfZW5jb2Rl4oCZKS4gIFNob3VsZCBJIHRha2UgaXQg
ZnJvbSBhIGdpdCB0cmVlPw0KDQpJdCBhc3N1bWVzIHRoZSBsYXRlc3QgdjUuMTMsIHdoaWNoIGNv
bnRhaW5zIHN2Y3hkcl9pbml0X2VuY29kZS4gQnV0IGl0DQppcyBhdmFpbGFibGUgaW4gdGhlIG5m
c2RfeGRyX3N0cmVhbSB0b3BpYyBicmFuY2ggaW4gdGhpcyByZXBvOg0KDQogIGdpdDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jZWwvbGludXguZ2l0DQoNCg0KPiAt
LWIuDQo+IA0KPj4gDQo+PiAtLS0NCj4+IA0KPj4gQ2h1Y2sgTGV2ZXIgKDI5KToNCj4+ICAgICAg
bG9ja2Q6IFJlbW92ZSBzdGFsZSBjb21tZW50cw0KPj4gICAgICBsb2NrZDogQ3JlYXRlIGEgc2lt
cGxpZmllZCAudnNfZGlzcGF0Y2ggbWV0aG9kIGZvciBOTE0gcmVxdWVzdHMNCj4+ICAgICAgbG9j
a2Q6IENvbW1vbiBOTE0gWERSIGhlbHBlcnMNCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxN
djEgdm9pZCBhcmd1bWVudCBkZWNvZGVyIHRvIHVzZSBzdHJ1Y3QgeGRyX3N0cmVhbQ0KPj4gICAg
ICBsb2NrZDogVXBkYXRlIHRoZSBOTE12MSBURVNUIGFyZ3VtZW50cyBkZWNvZGVyIHRvIHVzZSBz
dHJ1Y3QgeGRyX3N0cmVhbQ0KPj4gICAgICBsb2NrZDogVXBkYXRlIHRoZSBOTE12MSBMT0NLIGFy
Z3VtZW50cyBkZWNvZGVyIHRvIHVzZSBzdHJ1Y3QgeGRyX3N0cmVhbQ0KPj4gICAgICBsb2NrZDog
VXBkYXRlIHRoZSBOTE12MSBDQU5DRUwgYXJndW1lbnRzIGRlY29kZXIgdG8gdXNlIHN0cnVjdCB4
ZHJfc3RyZWFtDQo+PiAgICAgIGxvY2tkOiBVcGRhdGUgdGhlIE5MTXYxIFVOTE9DSyBhcmd1bWVu
dHMgZGVjb2RlciB0byB1c2Ugc3RydWN0IHhkcl9zdHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0
ZSB0aGUgTkxNdjEgbmxtX3JlcyBhcmd1bWVudHMgZGVjb2RlciB0byB1c2Ugc3RydWN0IHhkcl9z
dHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxNdjEgU01fTk9USUZZIGFyZ3VtZW50
cyBkZWNvZGVyIHRvIHVzZSBzdHJ1Y3QgeGRyX3N0cmVhbQ0KPj4gICAgICBsb2NrZDogVXBkYXRl
IHRoZSBOTE12MSBTSEFSRSBhcmd1bWVudHMgZGVjb2RlciB0byB1c2Ugc3RydWN0IHhkcl9zdHJl
YW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxNdjEgRlJFRV9BTEwgYXJndW1lbnRzIGRl
Y29kZXIgdG8gdXNlIHN0cnVjdCB4ZHJfc3RyZWFtDQo+PiAgICAgIGxvY2tkOiBVcGRhdGUgdGhl
IE5MTXYxIHZvaWQgcmVzdWx0cyBlbmNvZGVyIHRvIHVzZSBzdHJ1Y3QgeGRyX3N0cmVhbQ0KPj4g
ICAgICBsb2NrZDogVXBkYXRlIHRoZSBOTE12MSBURVNUIHJlc3VsdHMgZW5jb2RlciB0byB1c2Ug
c3RydWN0IHhkcl9zdHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxNdjEgbmxtX3Jl
cyByZXN1bHRzIGVuY29kZXIgdG8gdXNlIHN0cnVjdCB4ZHJfc3RyZWFtDQo+PiAgICAgIGxvY2tk
OiBVcGRhdGUgdGhlIE5MTXYxIFNIQVJFIHJlc3VsdHMgZW5jb2RlciB0byB1c2Ugc3RydWN0IHhk
cl9zdHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxNdjQgdm9pZCBhcmd1bWVudHMg
ZGVjb2RlciB0byB1c2Ugc3RydWN0IHhkcl9zdHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0
aGUgTkxNdjQgVEVTVCBhcmd1bWVudHMgZGVjb2RlciB0byB1c2Ugc3RydWN0IHhkcl9zdHJlYW0N
Cj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxNdjQgTE9DSyBhcmd1bWVudHMgZGVjb2RlciB0
byB1c2Ugc3RydWN0IHhkcl9zdHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxNdjQg
Q0FOQ0VMIGFyZ3VtZW50cyBkZWNvZGVyIHRvIHVzZSBzdHJ1Y3QgeGRyX3N0cmVhbQ0KPj4gICAg
ICBsb2NrZDogVXBkYXRlIHRoZSBOTE12NCBVTkxPQ0sgYXJndW1lbnRzIGRlY29kZXIgdG8gdXNl
IHN0cnVjdCB4ZHJfc3RyZWFtDQo+PiAgICAgIGxvY2tkOiBVcGRhdGUgdGhlIE5MTXY0IG5sbV9y
ZXMgYXJndW1lbnRzIGRlY29kZXIgdG8gdXNlIHN0cnVjdCB4ZHJfc3RyZWFtDQo+PiAgICAgIGxv
Y2tkOiBVcGRhdGUgdGhlIE5MTXY0IFNNX05PVElGWSBhcmd1bWVudHMgZGVjb2RlciB0byB1c2Ug
c3RydWN0IHhkcl9zdHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0ZSB0aGUgTkxNdjQgU0hBUkUg
YXJndW1lbnRzIGRlY29kZXIgdG8gdXNlIHN0cnVjdCB4ZHJfc3RyZWFtDQo+PiAgICAgIGxvY2tk
OiBVcGRhdGUgdGhlIE5MTXY0IEZSRUVfQUxMIGFyZ3VtZW50cyBkZWNvZGVyIHRvIHVzZSBzdHJ1
Y3QgeGRyX3N0cmVhbQ0KPj4gICAgICBsb2NrZDogVXBkYXRlIHRoZSBOTE12NCB2b2lkIHJlc3Vs
dHMgZW5jb2RlciB0byB1c2Ugc3RydWN0IHhkcl9zdHJlYW0NCj4+ICAgICAgbG9ja2Q6IFVwZGF0
ZSB0aGUgTkxNdjQgVEVTVCByZXN1bHRzIGVuY29kZXIgdG8gdXNlIHN0cnVjdCB4ZHJfc3RyZWFt
DQo+PiAgICAgIGxvY2tkOiBVcGRhdGUgdGhlIE5MTXY0IG5sbV9yZXMgcmVzdWx0cyBlbmNvZGVy
IHRvIHVzZSBzdHJ1Y3QgeGRyX3N0cmVhbQ0KPj4gICAgICBsb2NrZDogVXBkYXRlIHRoZSBOTE12
NCBTSEFSRSByZXN1bHRzIGVuY29kZXIgdG8gdXNlIHN0cnVjdCB4ZHJfc3RyZWFtDQo+PiANCj4+
IA0KPj4gZnMvbG9ja2Qvc3ZjLmMgICAgICAgICAgICAgfCAgNDMgKysrKw0KPj4gZnMvbG9ja2Qv
c3ZjeGRyLmggICAgICAgICAgfCAxNTEgKysrKysrKysrKysrKysNCj4+IGZzL2xvY2tkL3hkci5j
ICAgICAgICAgICAgIHwgNDAyICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gZnMvbG9ja2QveGRyNC5jICAgICAgICAgICAgfCA0MDMgKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLQ0KPj4gaW5jbHVkZS9saW51eC9sb2NrZC94ZHIuaCAgfCAgIDYgLQ0K
Pj4gaW5jbHVkZS9saW51eC9sb2NrZC94ZHI0LmggfCAgIDcgKy0NCj4+IDYgZmlsZXMgY2hhbmdl
ZCwgNjEwIGluc2VydGlvbnMoKyksIDQwMiBkZWxldGlvbnMoLSkNCj4+IGNyZWF0ZSBtb2RlIDEw
MDY0NCBmcy9sb2NrZC9zdmN4ZHIuaA0KPj4gDQo+PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCg0KLS0N
CkNodWNrIExldmVyDQoNCg0KDQo=
