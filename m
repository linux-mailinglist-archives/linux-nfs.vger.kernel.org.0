Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43345468157
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Dec 2021 01:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbhLDAi7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 19:38:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15208 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383805AbhLDAit (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 19:38:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3MqBhl014831;
        Sat, 4 Dec 2021 00:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3zvEUVNm6neLNEOPWk4cu2CP+zBSQF0/8GeApOWczCc=;
 b=uD897F39gkBKy+MhziOt4ASL/QIER6AfBWseEZxX1DupO5CKOin9yaw3tTVRbdsGnt0y
 +pIJ6XcM3d5wNx4bprojT4/0qh881xfA6IU73RskJtRPU4xYiNFwFpoEamSqNOHhnhPu
 0LlAKKEZFeO4TTYV+dl7nanvvlHOL6POg97kJoli3QuAJxrbbEafmzqA+6Eh+VbX5n1/
 NnKcvSCMmdnvztVwqF+fBMx3QfdB5VK+94+Wn3MJ8p6yNPHJuZ7raAtnwLAbKF8kQJAF
 Su05OHbL/5r86yCVgUzNXKXX6SuXvl6ooCcSYOJAxwcj0EHAKHAoGaT91MfK2aVJvrdM AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqkx5kvnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Dec 2021 00:35:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B40PpQx087319;
        Sat, 4 Dec 2021 00:35:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by aserp3030.oracle.com with ESMTP id 3ckaqn0tvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Dec 2021 00:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY/lX5lKu9+zaxKOkDFaveo2rvLkmFE5NTAjrp4DdTqhsEfWCVFAVMurqzoxNE/JaEtsoEUb7OHIm2ZsrrjkXQwmajBSZR92u1gilFjLpt/7j8kvMNdVMuCqC9ikEvD2tk+1ZsxxCCJLLdhqiS4qp3ufDgV1UEjSqtIBGudCj81Vg3lSe6UCFOl1dYFJot2SHmI3qCbx2EsTRbKaiF8WQ5czxdzr2HwQmwro1JyONWqP/0zLCepK7ZpAJFaO5gye1TnEhTglOLdB31ZpE/E9UPz+tF+frZlywUg/fWjjdo7qRF2gvhnpA2q4uLcVQdCgCPh/r3iBQ1a+eeebbYjoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zvEUVNm6neLNEOPWk4cu2CP+zBSQF0/8GeApOWczCc=;
 b=DpN9tDLSmirIOWTpKqNW632UtUmxVjLKJuNGWZcT4kDc66EF/QQmJyXtmAU2bLIenHiW5s+AZwHsCnzYRDXpRoyi1/3NsquDaZgHIfzgrIf4H4162DPmV7LdGy17l53+OV7uR4XxNqUpEiwg6nJy7tfJRLabYf9Ue1zY4zdlRepqDf8JqVeTRIIoBDZHf9q6qmFnc1XPGSyQYlXDyD28Va3gIzJ3b1KXB+v8Q85ytT8cPMkq+XQcaWCyM8RsNHgRQeF1mdapVt9uv1DW/p3dLGM3RhdAdCZA2CsGsK37kUv8robeUPm08e7rpflHclI51gC99qYSqhlr6dXsFlsVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zvEUVNm6neLNEOPWk4cu2CP+zBSQF0/8GeApOWczCc=;
 b=HJbFPtaZQHgR96PjXOZmtVtMuBhxBXJP+gH0S2TqwJ2Zc4kwMHI4W6UY8VPfq3mBYmJCU179sM7tFxYVv5PzJl66lSzAL5JoVyEplG6v3tD/8hhHGeBqL2KDkskL1OQ8+C9kmLAeA/MEYvZHQ1pnqAK4BiS90DymKhyLWxMt8rk=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Sat, 4 Dec
 2021 00:35:11 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%7]) with mapi id 15.20.4734.022; Sat, 4 Dec 2021
 00:35:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Steve Dickson <SteveD@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsdcld: use WAL journal for faster commits
Thread-Topic: [PATCH] nfsdcld: use WAL journal for faster commits
Thread-Index: AQHX6JCDa1WFhrhup0+3fBDNUtx+YKwhUyaAgAAI84CAACBd6g==
Date:   Sat, 4 Dec 2021 00:35:11 +0000
Message-ID: <915221EC-387C-4F50-83C6-8DCF02DD2A5D@oracle.com>
References: <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org> <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org> <20211201195050.GE26415@fieldses.org>
 <20211203212200.GB3930@fieldses.org> <20211203215531.GC3930@fieldses.org>
 <469DF1ED-C2AB-43CE-AB70-BFD2AFC2A68D@oracle.com>
 <20211203223921.GA6151@fieldses.org>
In-Reply-To: <20211203223921.GA6151@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 034ed980-f08e-4988-fdae-08d9b6bdee91
x-ms-traffictypediagnostic: CH2PR10MB4200:
x-microsoft-antispam-prvs: <CH2PR10MB4200E85E98F34166C074279C936B9@CH2PR10MB4200.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cHNzgJtaKi8r1B2U+SZoINu+43JypO7nCrGGXgsrSQL/ttfCc7vqN7lkS6BJGGwQrsuFToPbFAUr8/QLaQWf/Jfo2LzrR1peAQTpAcvq9cUJ2dU1SW3x3EBMdBSzceBnCJOaGqSBpk9WogxwIo2i+BROzACWNkVJ/zJU/crgrtE0ibXESaBPOvUKdIN9Qs6DfBfy6igbL+HCMFBRUvJQoeqwUddP3c3TVJOE1R+8gcH+O/x2iXMPAbESbb2vCbSTCy+fM/ziG4BUwEgLN1UqF908rJzuB9xDl8y8rAWxWbd4RKG3A6jCAKBwJ8QRkxfAGEuVFn5rx2Fe26pcMePDNNuKOIJRxYsZARD5tFAjZ65i/eRXdXgvmtcwk7RsrRfh2vK1Nf3MQbmnpBYku4k6bCyvm/C5EHfV/bvqrIHmW/nvebFY/NlSo3P2wUmiIHvovsa/ZB1YsPAh8X7qeBA87jjEUzMJbn9kTbL1W1ApFcwS8jEOjmT2OG2sv718GnIqZOFtOmi6PAxjdBVkuCfdaOgdiyMdHYXt9BjBGVcjGkuzwqRshWgqz2eEo8jZHgVfK6I1u9nxPYUZLxy7MH0kX8HneFYTBYOBHLDqaSIQgUwcN5iNeyCFkc7gycQlgF2mYMjpEXMcSQmyrqqjm4PBpeFK9CQLEAvDzCjWws+npZita5EbnGh1DL1Fl8mvKz6cYPUnDtUkMEgXEDmNniydnzvDiyVTLSEs/CxoZeCxyi+wQbQst2hcJDHZw4cLS6o87/7vkFN4arWmx8pLZfKNhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(86362001)(6506007)(2906002)(6916009)(36756003)(316002)(53546011)(66946007)(38070700005)(83380400001)(6486002)(38100700002)(122000001)(64756008)(66446008)(5660300002)(71200400001)(76116006)(66556008)(54906003)(4326008)(66476007)(186003)(2616005)(8936002)(508600001)(33656002)(6512007)(8676002)(133343001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0tRVHRyd1A2NGs4VXR5azVMRXVrU1o1Q2VVbklhajVyL3gxdVJGM2t1SVBw?=
 =?utf-8?B?TU0rVDdPd3g3dDRpazdsOGVsS3RLeUFhSnVSZXZXcUNwcXR3VDRRVEc5RE1L?=
 =?utf-8?B?cEhONjFkeHpBdEZkcEVFRUNLTnZFdUVOUVk5STFlNnJkYnZtUlM1NFY0Y2JJ?=
 =?utf-8?B?QUhKUGg1cnlINFNpSEgxajVkTGhiOTl4OGxlZWFiZkV0MFhYR1NXZ0lrb2ZS?=
 =?utf-8?B?YVRMZUFEb0lFaytFL3JQZ0x6TzlKMDJROTJnRWtmZVhHTmhpb1hnem56VFJJ?=
 =?utf-8?B?WFlSc1k5RWVSYitibEdmVnRYK21ZRlhrN0JQRmpHWDE5WTd1RDJnc0JpSVd6?=
 =?utf-8?B?ZFRaSVRiaFJjNHFvMEI3R2dnamF2WnZHYkpJVVc0S25VNDkvOXlTMCsrRU5m?=
 =?utf-8?B?SHRDTmkvYU9IaXRsd21mTU1yR3RFd3h2T3pUL2dmbWdEVnh2M1BYZFVLT1Fy?=
 =?utf-8?B?V3JuamQxWDdFeFlLNms3dVl1ekRaRUxldVhrSWo4V2dSREVRSDh1am1yMXEy?=
 =?utf-8?B?cFZEQ0loMzc2NHVqOUZ1VW1UVUNmOTRQcVRlK0xQN0JlZXdwR2VlY2R3RjVQ?=
 =?utf-8?B?M0pKcnJsTlc3cTgxaDNmYmdwZWRjTWpZa0xTdEhZUlgrYmVPUWQrRHNjS1FD?=
 =?utf-8?B?bjBzNjZPOGtqMlFaSWRvZU0zMGJkNDl3V2pIZHFJdjhJNTRxajlQNlBvR25L?=
 =?utf-8?B?T2ZKUkU3QW9zVk1uZ3lVNUhtdnRra0Y2RHJBM2NBN29XV1BNVUtQd25wYTRx?=
 =?utf-8?B?VDFrNmZxY1FWNzZvaURZLzJ6ckFhM3ZIdi9MTElEYzZUWGtUeEJxNkdkbmRN?=
 =?utf-8?B?TFptSUx5VE5DRXBzRm1ySnJ6Y1JKR3pmbWlzdTdXanJveG5FbHpZbmNuNUk1?=
 =?utf-8?B?L0tRbVBEVzFseHJ5T1hGMDhZUzRhOEV1b3AxVXZMdHNaRWUvZGt1UXZxdDJU?=
 =?utf-8?B?Q1F4R05hTnZld0g0bW9FVjgvaW1ybldtRENOSDV2REZmaU56Z1p0RGFHQW5M?=
 =?utf-8?B?ZVRFS0pkc0VkdnNCaUZyMXB4dEVhUlFQUmhRdWFkeVNJTnRnbzhiS2wzVVVK?=
 =?utf-8?B?N242TlRxMjNUMzhCVVpaMGFHT0hpNEJWRTF0b1ozRWtlWVd3WDFJblhVM1Nz?=
 =?utf-8?B?NW1aL1AyRU1LY0s5TW9odFRoNFYzTy9yTHZibktHQ1I1UzUwbFRFaE1wMytQ?=
 =?utf-8?B?UktLdWRvTlRpZ3VGRVdhczZCcWMvOVNsc1BFT1BzeWovaTVqUHdjTjdISHo0?=
 =?utf-8?B?QXdXN28vOXdMK3ZXN1FIbVVlM3hESVZwaE5jbW9iZjdoWmZyT0pYb1MvT3hr?=
 =?utf-8?B?LzFlQS9ldjlMQjZnNWhBazd2aW52STVZSFN0UDhWSUtxZnV4dXVlVjNtbG1n?=
 =?utf-8?B?c2xEYkdvWVU3RVlmOFljZ2NCV0V2K25nTEZCcVBrU092SXBqNEpwSFJ5Rktt?=
 =?utf-8?B?aHphZTBLY21zZHdPV3ZNMGd1bDlWQ3lIZVI5WVFjaGZnc29iY3dHZHVFUmhi?=
 =?utf-8?B?aU5NK2FyZURBeVNHVG5sZ1gwTTMrUmFrQ2pSbWRjSjNpRkxGWjJVeGUvcXhR?=
 =?utf-8?B?TzJEaTF3a1FINmYvbEJ3bUFSeXo1cGkwNnhYRVM5M0F2akZSYWJ4bnhIRmNJ?=
 =?utf-8?B?cnAxVFFhY1hzeDk0VFZ4ZEJDc2prdjhtZ0YranFxVmtIOFBUMTRYa0c0bHpM?=
 =?utf-8?B?M3JXVnFXcnFFQ2ZqalVsd3RGUmZ1MnJyNi9sL1JZVjlYdFRMNkNkT3VyaWt0?=
 =?utf-8?B?OUZyV2lkWXpZc3FZdWFucCtPSTVjQW1UbmpmNThlZTNFVzVGZ2lJdVdkL2dG?=
 =?utf-8?B?TU0xMnkveHFySDRqcmtYSUVZd3VVc3hmUFQ5WG9IZEt0RjkwMndwQ2NSSERS?=
 =?utf-8?B?WG4vNnVhOGxlbTFqbVFVVjQrVGJEMFgzNnhXSnpVbmgrR1lMKzRhUThiOXo1?=
 =?utf-8?B?c2tROTExUzNwMXIrZ3g5NEF6Y1FkRkIwNjZNSEFCYVhsQ1hZZnpIaUpoa2pG?=
 =?utf-8?B?a2s2bEppenJIc3RSY01GNXd0VVNJMlZEUDB0NCtUSW1uUkptN050Y05rb2Zx?=
 =?utf-8?B?ZnhMU2F0T2hQU0JwM0FXQnBta3VkQXFCdzh2WS9FYUlrTE5Xd3RESDFMUUtI?=
 =?utf-8?B?a2liWmQ5YTJ0QWpRbnMyNDZSUGNBQk9PV2dzamM2Z0FtRkcwRXBTYlVMT3ZX?=
 =?utf-8?Q?Te+BXLGuiBnDF16SmDR095A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034ed980-f08e-4988-fdae-08d9b6bdee91
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 00:35:11.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zed5G4D6o0WD/TOXjYpF+WA92iVVN2G29S7ymI55fwpMoD7KyeK9g9tY7OQ0cYyuT9JCt1ATdc/Z88hUuLU7xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10187 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112040001
X-Proofpoint-GUID: bXWcrgfo87XQ6ZzVI7woXglyq7Bh1csm
X-Proofpoint-ORIG-GUID: bXWcrgfo87XQ6ZzVI7woXglyq7Bh1csm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIERlYyAzLCAyMDIxLCBhdCA1OjM5IFBNLCBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAZmll
bGRzZXMub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIEZyaSwgRGVjIDAzLCAyMDIxIGF0IDEwOjA3
OjE5UE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4+IE9uIERl
YyAzLCAyMDIxLCBhdCA0OjU1IFBNLCBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAZmllbGRzZXMub3Jn
PiB3cm90ZToNCj4+PiANCj4+PiBGcm9tOiAiSi4gQnJ1Y2UgRmllbGRzIiA8YmZpZWxkc0ByZWRo
YXQuY29tPg0KPj4+IA0KPj4+IEN1cnJlbnRseSBuZnNkY2xkIGlzIGRvaW5nIHRocmVlIGZkYXRh
c3luY3MgZm9yIGVhY2ggdXBjYWxsLiAgQmFzZWQgb24NCj4+PiBTUUxpdGUgZG9jdW1lbnRhdGlv
biwgV0FMIG1vZGUgc2hvdWxkIGFsc28gYmUgc2FmZSwgYW5kIEkgY2FuIGNvbmZpcm0NCj4+PiBm
cm9tIGFuIHN0cmFjZSB0aGF0IGl0IHJlc3VsdHMgaW4gb25seSBvbmUgZmRhdGFzeW5jIGVhY2gu
DQo+Pj4gDQo+Pj4gVGhpcyBtYXkgYmUgYSBib3R0bGVuZWNrIGUuZy4gd2hlbiBsb3RzIG9mIGNs
aWVudHMgYXJlIGJlaW5nIGNyZWF0ZWQgb3INCj4+PiBleHBpcmVkIGF0IG9uY2UgKGUuZy4gb24g
cmVib290KS4NCj4+PiANCj4+PiBOb3QgYm90aGVyaW5nIHdpdGggZXJyb3IgY2hlY2tpbmcsIGFz
IHRoaXMgaXMganVzdCBhbiBvcHRpbWl6YXRpb24gYW5kDQo+Pj4gbmZzZGNsZCB3aWxsIHN0aWxs
IGZ1bmN0aW9uIHdpdGhvdXQuICAoTWlnaHQgYmUgYmV0dGVyIHRvIGxvZyBzb21ldGhpbmcNCj4+
PiBvbiBmYWlsdXJlLCB0aG91Z2guKQ0KPj4gDQo+PiBJJ20gaW4gZnVsbCBwaGlsb3NvcGhpY2Fs
IGFncmVlbWVudCBmb3IgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzDQo+PiBpbiB0aGlzIGFyZWEu
IFRoZXJlIGFyZSBzb21lIGNhdmVhdHMgZm9yIFdBTDoNCj4+IA0KPj4gLSBJdCByZXF1aXJlcyBT
UUxpdGUgdjMuNy4wICgyMDEwKS4gY29uZmlndXJlLmFjIG1heSBuZWVkIHRvIGJlDQo+PiAgIHVw
ZGF0ZWQuDQo+IA0KPiBNYWtlcyBzZW5zZS4gIEJ1dCBJIGR1ZyBhcm91bmQgYSBiaXQsIGFuZCBo
b3cgdG8gZG8gdGhpcyBpcyBhIHRvdGFsDQo+IG15c3RlcnkgdG8gbWUuLi4uDQoNCmFjbG9jYWwv
bGlic3FsaXRlMy5tNCBoYXMgYW4gU1FMSVRFX1ZFUlNJT05fTlVNQkVSIGNoZWNrLg0KDQoNCj4+
IC0gQWxsIHByb2Nlc3NlcyB1c2luZyB0aGUgREIgZmlsZSBoYXZlIHRvIGJlIG9uIHRoZSBzYW1l
IHN5c3RlbS4NCj4+ICAgTm90IHN1cmUgaWYgdGhpcyBtYXR0ZXJzIGZvciBzb21lIERSIHNjZW5h
cmlvcyB0aGF0IG5mcy11dGlscw0KPj4gICBpcyBzdXBwb3NlZCB0byBzdXBwb3J0Lg0KPiANCj4g
SSBkb24ndCB0aGluayB3ZSBzdXBwb3J0IHRoYXQuDQo+IA0KPj4gLSBXQUwgbW9kZSBpcyBwZXJz
aXN0ZW50OyB5b3UgY291bGQgc2V0IHRoaXMgYXQgZGF0YWJhc2UgY3JlYXRpb24NCj4+ICAgdGlt
ZSBhbmQgaXQgc2hvdWxkIGJlIHN0aSBja3kuDQo+IA0KPiBJIHdhbnRlZCB0byB1cGdyYWRlIGV4
aXN0aW5nIGRhdGFiYXNlcyB0b28sIGFuZCBmaWd1cmVkIHRoZXJlJ3Mgbm8gaGFybQ0KPiBpbiBj
YWxsaW5nIGl0IG9uIGVhY2ggc3RhcnR1cC4NCg0KQWguIE1ha2VzIHNlbnNlIQ0KDQoNCj4+IC0g
RG9jdW1lbnRhdGlvbiBzYXlzICJzeW5jaHJvbm91cyA9IEZVTEwgaXMgdGhlIG1vc3QgY29tbW9u
bHkNCj4+ICAgdXNlZCBzeW5jaHJvbm91cyBzZXR0aW5nIHdoZW4gbm90IGluIFdBTCBtb2RlLiIg
V2h5IGFyZSBib3RoDQo+PiAgIFBSQUdNQXMgbmVjZXNzYXJ5IGhlcmU/DQo+IA0KPiBNYXliZSB0
aGV5J3JlIG5vdDsgSSB0aGluayBJIGRpZCBzZWUgdGhhdCBGVUxMIGlzIGFjdHVhbGx5IHRoZSBk
ZWZhdWx0DQo+IGJ1dCBJIGNhbid0IGZpbmQgdGhhdCBpbiB0aGUgZG9jdW1lbnRhdGlvbiByaWdo
dCBub3cuDQo+IA0KPiAtLWIuDQo+IA0KPj4gDQo+PiBJIGFncmVlIHRoYXQgbmZzZGNsZCBmdW5j
dGlvbmFsaXR5IGlzIG5vdCBhZmZlY3RlZCBpZiB0aGUgZmlyc3QNCj4+IFBSQUdNQSBmYWlscy4N
Cj4+IA0KPj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJl
ZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gdXRpbHMvbmZzZGNsZC9zcWxpdGUuYyB8IDMgKysrDQo+
Pj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQg
YS91dGlscy9uZnNkY2xkL3NxbGl0ZS5jIGIvdXRpbHMvbmZzZGNsZC9zcWxpdGUuYw0KPj4+IGlu
ZGV4IDAzMDE2ZmI5NTgyMy4uYjI0OGVlZmZhMjA0IDEwMDY0NA0KPj4+IC0tLSBhL3V0aWxzL25m
c2RjbGQvc3FsaXRlLmMNCj4+PiArKysgYi91dGlscy9uZnNkY2xkL3NxbGl0ZS5jDQo+Pj4gQEAg
LTgyNiw2ICs4MjYsOSBAQCBzcWxpdGVfcHJlcGFyZV9kYmgoY29uc3QgY2hhciAqdG9wZGlyKQ0K
Pj4+ICAgICAgICBnb3RvIG91dF9jbG9zZTsNCj4+PiAgICB9DQo+Pj4gDQo+Pj4gKyAgICBzcWxp
dGUzX2V4ZWMoZGJoLCAiUFJBR01BIGpvdXJuYWxfbW9kZSA9IFdBTDsiLCBOVUxMLCBOVUxMLCBO
VUxMKTsNCj4+PiArICAgIHNxbGl0ZTNfZXhlYyhkYmgsICJQUkFHTUEgc3luY2hyb25vdXMgPSBG
VUxMOyIsIE5VTEwsIE5VTEwsIE5VTEwpOw0KPj4+ICsNCj4+PiAgICByZXQgPSBzcWxpdGVfcXVl
cnlfc2NoZW1hX3ZlcnNpb24oKTsNCj4+PiAgICBzd2l0Y2ggKHJldCkgew0KPj4+ICAgIGNhc2Ug
Q0xEX1NRTElURV9MQVRFU1RfU0NIRU1BX1ZFUlNJT046DQo+Pj4gLS0gDQo+Pj4gMi4zMy4xDQo+
Pj4gDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCg==
