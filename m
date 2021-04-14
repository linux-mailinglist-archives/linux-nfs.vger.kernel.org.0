Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0D35FE6D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 01:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhDNX1X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 19:27:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40964 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbhDNX1W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 19:27:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13ENPmH1153156;
        Wed, 14 Apr 2021 23:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=knqI0B7cX4Aa9+B7WH7wlKmP1UnigOnhNP17hbx1SCo=;
 b=ZNkkg1HywqV6Oe4jDV1A7AiwllaFU1cgs/Y6dtd/Rc1lTDlJlYDj63R8TQTsGHx/q8vP
 zRxvewOqEw4jZGP8oLxAOBEwMAc0+9kEpH0xiwvJcyFMUMsFXWqrBKddo+rdzGQ4gcSq
 NQ6siUpA3NiccNEscslKV2YSqvIZbAJR7t6xDr6CGtPaQU3880LavZmKMN5M5x97/bUr
 O/qORCZeeMseMhVvDJ+rSYTktS1MFfYlCGEmvrRSHnzFRqRR+4VtgRkGAseC4keKzKF2
 66AbcNOuc6cI8u5NNisCgZtGLUPgP5iYCgoULVJEeTOZV+O8pJ+vJe1nQR6c5ICezZH1 iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbm6jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 23:26:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13ENPZtV027620;
        Wed, 14 Apr 2021 23:26:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3020.oracle.com with ESMTP id 37unsupu5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 23:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le4SoQyX4UF1AkQJ6uMGFekY1xFmm/ZnTwurAZ4XbBES4SByru03PAE6wMMF9g1lxDIXK9FUQALUeLud/f4kimT0Yu2ztEH+yMmvphzS5Z1ZR0vf1M0ncLRnaoPEbocHB6pvrj0YilzdSS6Itr4rqnxLuQZYW+o90tWDAFWe18yCsWh2TXxzKBccjVJQaTRF6bY5KAxtugaG/uwdnJ6GgO1hUsPA2sgV9z8qphuQjpEL6Q8CH/oDg1E5L1olmuf7YACfkLGsu1io0+CzI2SSp261Zrafq7H0PBu4V9QIPjIv76CE5rQ0wl26oOq2x2M/A2PU/htkn7vSc8beDcgZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knqI0B7cX4Aa9+B7WH7wlKmP1UnigOnhNP17hbx1SCo=;
 b=JakSxPmGN5K3cfGqh6K10AqfX99RZzqcreO18C5PDrP+Rup/aDZ6O19qR86hxGxyuT3pf98+aZguhwlktMlpM6gRnKCuGzB1nieRS7XKW/O2EC/FI+8mv9HdvCuljyPl+uvVNSXloNtnPQ0AwODt5B37t/ecm0744FqDKgJuAa1zjxi70lt3sOebvwtO/uWR/OsK/CNg2EJ9i/DPm9HLd2Vkmiw+vLPk3/jRR6ialCiLKHkHunraLvFJbBN67eRpNyk9f12sIn0kIlni+subVVojoe5x0rzI8DRh06m/COSR15Gplaa4U2gKCJF/JYxzWR1AdU0Psdnu8YcpFoDg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knqI0B7cX4Aa9+B7WH7wlKmP1UnigOnhNP17hbx1SCo=;
 b=mnb51yRDTOG3H3gWQuGpD9ihwwh2+qSikJ4/x0hsnyu6V2xII6hJlifT87JTxzI7lvqns/8OnEQrKccik8ac7vJvwlagZJSltCjo+KytCghb3ED/wH6KxEMwn1nJiu9mKh0iaDnIQGw7JpGFsecVDgdCCCx3G6lhp3bGeqx5ym4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2757.namprd10.prod.outlook.com (2603:10b6:a02:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 23:26:54 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 23:26:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@redhat.com>
CC:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Topic: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Index: AQHXMVl21czF1oj/Wkexg55/eRtUL6q0qJzl
Date:   Wed, 14 Apr 2021 23:26:54 +0000
Message-ID: <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
References: <20210414181040.7108-1-steved@redhat.com>
In-Reply-To: <20210414181040.7108-1-steved@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a15f4536-061e-4cdd-966f-08d8ff9cca44
x-ms-traffictypediagnostic: BYAPR10MB2757:
x-microsoft-antispam-prvs: <BYAPR10MB2757DBE7705DB6E9DD99C08E934E9@BYAPR10MB2757.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOupUtIqATyh1qtRiP6gTHfcLjuaDCuTI580VnImy+gLF6N7A8So28EHTZEwLBACZZl6/+46Zn8tL5IC3M470guR9w2o6EaQiDT/HCzpSySaGAjANzAQv+rJTllwov8lIkdIZdXzESkBr5wsthgTcTWsC5Ys4zRFW1U0VtF32FK1ryghBlx3Je8wCFEL/MJ6UF7V6ohPgTZxs2pZD2jtUdDMjwEaXyPTAZKJ3ELysx79pyYBXGXu4VVGELzegcG4oHoQFc7W4pMKmxPusssEfcG3PCjiyWlzorwVUrEm+CAGh26KeP6KrwwNAaoKUaLxX4huP71muKJ1NJEn1P7lRsyHLNWpXEoicZXs1BPktvARnxLYC91FAdWg9P2pL2O+iIdWo95msU+/0Z+jIat7uEkce512Up1uAPyFfdY8+KB4T9DakZ4q0r4QOReaitFm34HtB5SJ+ujU84CnIQH/F1YDl4BEJ90DF9xotmn2NWp0kbYO1ItFoATnR2nD323twm9/1OiWZ1wjTW5bc/q8BDDlToZvsqFsfz8ZCMb/FUeEc639ni4ZXz55DaHq912J1vuQepcm7+vNmkr5fgAL+y97RS3Pozc1HaUENE9zySIL/BxvSycLxDxL9geiLQErj7YCEMl+1AYOLgWm3supeujDj5bpxA67xjDnPfShF9M3c+cFVixHuumzUfaNAkOf6aOcQbkRG3PGZMTd5wjGcyfAVIpbPaNZY0p95E6BpbdsJ2rxdpWjMnBMSUQP8xKL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(4326008)(6512007)(2906002)(71200400001)(6916009)(6486002)(8676002)(53546011)(83380400001)(316002)(478600001)(186003)(26005)(8936002)(6506007)(2616005)(966005)(86362001)(66446008)(64756008)(33656002)(36756003)(66556008)(66476007)(122000001)(91956017)(66946007)(76116006)(5660300002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UGxjRkViQ1R4dDZSdGRuSkJHa2NHYmFTK2pwUXhRU1hsWUZnSURrdkw0MmFM?=
 =?utf-8?B?TG9YUHhnT3NaWEh0U1pVdUs4VmVYMWpTazBQbC8rN29nWng0ak93RGZPQ1Ev?=
 =?utf-8?B?T2xLOTd6bUZ1eWFhbjNjbHNYSFlSb3k3d25GYlpZVDdwQ2FhTVRPZDlxeXlt?=
 =?utf-8?B?TEo1TnptRVlBTktJV0ZCM2Y4VkRoREp6dDBTV1Yza0tzSTZWOEh3Q0NWd1Y3?=
 =?utf-8?B?Snk0NUNOc1ZnZ2szM05NcDhOUzZ3V0lmbnFhY2hZNmUzTytYU3M5YytpUldn?=
 =?utf-8?B?MXd3N1VQdEEra3BGa1dOYkY1d3BTTmpDQ1JhWmhlWGZFY0hFOTVDdGoxUHlN?=
 =?utf-8?B?MGJzOUhMM1ZQMlJ0RE52M0JjU3ZJV2NwNGgxeW5WRDJkNTRLRG1FRC83bFBW?=
 =?utf-8?B?czlwb1Raa3lXUmRHS0tUN1FEODdWU1pQa1ZNalE4bFRTbmhpSkhlOGxvU1VO?=
 =?utf-8?B?NGx2cjhJbXdWQ29NVmdVSzlaVnZ1NWdiMDV2RW5ueHJScWxnekUvOGZ3OTc2?=
 =?utf-8?B?MWg3bGgxcyt1bHA0ZkQ5TzhKdGluSko1OFFsRVRJN0lUM05MdXBuNEgvL3RM?=
 =?utf-8?B?N3dqK01pTDdQMHlRdUJkZE50dkZyRFZnWGRtRjlvNGtsZk54OUVPY1phUkt0?=
 =?utf-8?B?RW9DZXg0NnJQK3ZCOUEwR0V2enRZZWJrMDNISGdhTEw4UUd4OEw5MlluL09i?=
 =?utf-8?B?MmVrV3VkQjFkaGVmNGtvLzJuWmxPMTArY1V4TmhJV0EvTnYwNDJIdVNsY2lE?=
 =?utf-8?B?QUs5UkMwVFRxR3RMWGdCdWYrSEc4MW1MZjJCaXFDc1FCRmQxSi8wSlA1Q2JM?=
 =?utf-8?B?bWp5ak1HQ1Y3WU5Tc1YvZnVxMmJkZTZOMWt2K0hhZzc5a0Fobm9NWCtOT0ZT?=
 =?utf-8?B?aXF2ajdNMDBOcUZPN2g4LytOTmJhZVZEN3hWNUdodkpHelBDazhmWjdBYzBG?=
 =?utf-8?B?TmlEWVlPTjNjbzdqQlcyOG93ZUIyQjRMeXgvZ01WU1ZYaEhxNE9lenVCSksv?=
 =?utf-8?B?UFJjakhWeWl3MXhtNmVibGV4MGk0bWZlRDRLTjFhOXhwVnpKRStHY21LcG5r?=
 =?utf-8?B?WWFvRkJDK2phSm5nR3p5MWFWMm9CeStLTUVwRUFUV2JValkzVTlUdlN3VmZq?=
 =?utf-8?B?WElkSlVJVEJ1Z2pWelVBeSt5TU9oSUFoSHk0aFMzeTlmWlU2anY0elhBb0NU?=
 =?utf-8?B?U1BTaTdBQ3VwczY1Vy9lQzR3S2xJdmdLekxIdjVqb0xtUFA2aWtzNU4yTnRM?=
 =?utf-8?B?MS9nWk1aZnhSNkQ2QmtmK044eFhmbUZ6TnBLbEpoL2NKT05iSUpNQXR4NzlP?=
 =?utf-8?B?Y1RjMytZRlRiQ00yWk1JcGtlL0d6blV5cWo5QkY3cURmK2ZtT2RPU1liclY1?=
 =?utf-8?B?a3N3cGYxQ3JLQzBKc2xVSmt6b1RHaGxvcGdqRUV3ZmlLSm5aeUxkSVpWN0Jh?=
 =?utf-8?B?VlR4VHVvU3F1UGlTZ3pzdTdYZ3h6WHJOK0h5VktRTUlPSjdkeUtPMDZhVHhO?=
 =?utf-8?B?R3FEM2xNODdlQ3NocGtCTm1tZWo5NGwyZHBZRFM5SzdRY2N0TFBldlpnUHZV?=
 =?utf-8?B?Q015K0w3MzV2SllPR0NBR3Yxcm5CUVpEUXdsV2E4UkxOMVVZRkNPbU1xODhk?=
 =?utf-8?B?a1ExT1RJL0FwZ2Zjd0pjYnVvNFNkUHVZak02UURFcVltUTlROU4wSUc0Zkl2?=
 =?utf-8?B?RjNjWUQ0bzhlNlhJUWxXTlZwNytZbGw2Q1orNFhHd1NxdjBJU2JSM1h5R091?=
 =?utf-8?Q?SuTQGdkEinX04csR7wYkIkpxt9+L8ic4R4O5SZz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15f4536-061e-4cdd-966f-08d8ff9cca44
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 23:26:54.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +q0mrKpqHneBo0PkkZ3/sAgqcyZLL3LJOl8vLi/YZNbpE0ehAc1sHZdd7sUAMvFa9b9mEaRig3ZpPEchAyzxNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2757
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140147
X-Proofpoint-GUID: Z502aL3_1Mbsn73t5jBiBExmJw6ccRPe
X-Proofpoint-ORIG-GUID: Z502aL3_1Mbsn73t5jBiBExmJw6ccRPe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140147
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgU3RldmUtDQoNCj4gT24gQXByIDE0LCAyMDIxLCBhdCAyOjEwIFBNLCBTdGV2ZSBEaWNrc29u
IDxTdGV2ZURAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79UaGlzIGlzIGEgdHdlYWsgb2Yg
dGhlIHBhdGNoIHNldCBBbGljZSBNaXRjaGVsbCBwb3N0ZWQgbGFzdCBKdWx5IFsxXS4NCg0KVGhh
dCBhcHByb2FjaCB3YXMgZHJvcHBlZCBsYXN0IEp1bHkgYmVjYXVzZSBpdCBpcyBub3QgY29udGFp
bmVyLWF3YXJlLg0KSXQgc2hvdWxkIGJlIHNpbXBsZSBmb3Igc29tZW9uZSB0byB3cml0ZSBhIHVk
ZXYgc2NyaXB0IHRoYXQgdXNlcyB0aGUNCmV4aXN0aW5nIHN5c2ZzIEFQSSB0aGF0IGNhbiB1cGRh
dGUgbmZzNF9jbGllbnRfaWQgaW4gYSBuYW1lc3BhY2UuIEkNCndvdWxkIHByZWZlciB0aGUgc3lz
ZnMvdWRldiBhcHByb2FjaCBmb3Igc2V0dGluZyBuZnM0X2NsaWVudF9pZCwNCnNpbmNlIGl0IGlz
IGNvbnRhaW5lci1hd2FyZSBhbmQgbWFrZXMgdGhpcyBzZXR0aW5nIGNvbXBsZXRlbHkNCmF1dG9t
YXRpYyAoemVybyB0b3VjaCkuDQoNCg0KPiBJdCBlbmFibGVzIHRoZSBzZXR0aW5nIG9mIHRoZSBu
ZnM0X3VuaXF1ZV9pZCBrZXJuZWwgbW9kdWxlIA0KPiBwYXJhbWV0ZXIgZnJvbSAvZXRjL25mcy5j
b25mLg0KDQo+IFRoaW5ncyBJIHR3ZWFrZWQ6DQo+IA0KPiAgICAqIEludHJvZHVjZSBhIG5ldyBb
a2VybmVsXSBzZWN0aW9uIGluIG5mcy5jb25mIHdoaWNoIG9ubHkNCj4gICAgICBjb250YWlucyB0
aGUgbmZzNF91bmlxdWVfaWQgc2V0dGluZy4uLiBGb3Igbm93Li4uIA0KPiANCj4gICAgKiBuZnM0
X3VuaXF1ZV9pZCBjYW4gYmUgc2V0IHRvIHR3byBkaWZmZXJlbnQgdmFsdWVzDQo+IA0KPiAgICAg
ICAgLSBuZnM0X3VuaXF1ZV9pZCA9ICR7bWFjaGluZS1pZH0gd2lsbCB1c2UgL2V0Yy9tYWNoaW5l
LWlkDQo+ICAgICAgICAgICAgYXMgdGhlIHVuaXF1ZSBpZC4NCj4gICAgICAgIC0gbmZzNF91bmlx
dWVfaWQgPSAke2hvc3RuYW1lfSB3aWxsIHVzZSB0aGUgc3lzdGVtJ3MgaG9zdG5hbWUNCj4gICAg
ICAgICAgICBhcyB0aGUgdW5pcXVlIGlkLg0KPiANCj4gICAgKiBUaGUgbmV3IG5mcy1jb25maWcg
c3lzdGVtZCBzZXJ2aWNlIG5lZWQgdG8gYmUgZW5hYmxlZCBmb3IgdGhlDQo+ICAgICAgL2V0Yy9t
b2Rwcm9iZS5kL25mcy5jb25mIGZpbGUgdG8gYmUgY3JlYXRlZCB3aXRoIA0KPiAgICAgIHRoZSAi
b3B0aW9ucyBuZnMgbmZzNF91bmlxdWVfaWQ9IiBzZXQuIA0KPiANCj4gSSBzZWUgdGhpcyBwYXRj
aCBzZXQgaXMgbm90IGEgd2F5IHRvIHNldCB0aGUgbmZzNF91bmlxdWVfaWQgDQo+IG1vZHVsZSBw
YXJhbWV0ZXIuLi4gSSBzZWUgaXQgYXMgYSBiZWdpbm5pbmcgb2YgYSB3YXkgdG8gc2V0IA0KPiBh
bGwgbW9kdWxlIHBhcmFtZXRlcnMgZnJvbSAvZXRjL25mcy5jb25mLCB3aGljaCBJIHRoaW5rDQo+
IGlzIGEgZ29vZCB0aGluZy4uLiANCj4gDQo+IFsxXSBodHRwczovL3d3dy5zcGluaWNzLm5ldC9s
aXN0cy9saW51eC1uZnMvbXNnNzg2NTguaHRtbA0KPiANCj4gQWxpY2UgTWl0Y2hlbGwgKDMpOg0K
PiAgbmZzLXV0aWxzOiBFbmFibGUgdGhlIHJldHJpZXZhbCBvZiByYXcgY29uZmlnIHNldHRpbmdz
IHdpdGhvdXQNCj4gICAgZXhwYW5zaW9uDQo+ICBuZnMtdXRpbHM6IEFkZCBzdXBwb3J0IGZvciBm
dXJ0aGVyICR7dmFyaWFibGV9IGV4cGFuc2lvbnMgaW4gbmZzLmNvbmYNCj4gIG5mcy11dGlsczog
VXBkYXRlIG5mczRfdW5pcXVlX2lkIG1vZHVsZSBwYXJhbWV0ZXIgZnJvbSB0aGUgbmZzLmNvbmYN
Cj4gICAgdmFsdWUNCj4gDQo+IGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gbmZzLmNvbmYgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gc3VwcG9ydC9pbmNs
dWRlL2NvbmZmaWxlLmggICAgfCAgIDEgKw0KPiBzdXBwb3J0L25mcy9jb25mZmlsZS5jICAgICAg
ICB8IDI4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+IHN5c3RlbWQvTWFr
ZWZpbGUuYW0gICAgICAgICAgIHwgICAzICsNCj4gc3lzdGVtZC9uZnMtY2xpZW50LnRhcmdldCAg
ICAgfCAgIDMgKw0KPiBzeXN0ZW1kL25mcy1jb25mLWV4cG9ydC5zaCAgICB8ICAyOCArKysrDQo+
IHN5c3RlbWQvbmZzLWNvbmZpZy5zZXJ2aWNlLmluIHwgIDE4ICsrKw0KPiBzeXN0ZW1kL25mcy5j
b25mLm1hbiAgICAgICAgICB8ICAxOSArKy0NCj4gdG9vbHMvbmZzY29uZi9uZnNjb25mLm1hbiAg
ICAgfCAgMTAgKy0NCj4gdG9vbHMvbmZzY29uZi9uZnNjb25mY2xpLmMgICAgfCAgMjIgKystDQo+
IDExIGZpbGVzIGNoYW5nZWQsIDM3MiBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4g
Y3JlYXRlIG1vZGUgMTAwNzU1IHN5c3RlbWQvbmZzLWNvbmYtZXhwb3J0LnNoDQo+IGNyZWF0ZSBt
b2RlIDEwMDY0NCBzeXN0ZW1kL25mcy1jb25maWcuc2VydmljZS5pbg0KPiANCj4gLS0gDQo+IDIu
MzAuMg0KPiANCg==
