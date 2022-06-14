Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412BF54BAEA
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jun 2022 21:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiFNTs2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jun 2022 15:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345089AbiFNTs0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jun 2022 15:48:26 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2119.outbound.protection.outlook.com [40.107.212.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E223120C;
        Tue, 14 Jun 2022 12:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUO2isl6VXnJ3g90auuBeyzXEzp4OaJAnXnxQ4XlDjPEkCRW3W0H1J9Wwg6IcpKR3eoeLq2wIBLO9/5+kLKZ/vVUOARJNv3drIcbinj1RCF+qYUhryWA3brEKpijHaYo7fkEqWqkjfof3Q4e1r5J2AUS2MMGedS3otlbR9irMZts+9uMi80xlc9sfDfLqCUyxH83Se0fCxpsKxvRdUpm81Lkut0X6adJt+i1GkjDm6xXNJaoz1m/K7gU7YBv8MsB1nJA5mPpVUb6cZBcPAidk03vl+pSV2b4f9vV17YITRxYpiamse3qJM67pyDqXX6dakGCrxRkd1pJCFixSL0DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zblQVur6Uz9ZG8lEIh1Gzj1Bk43bkrv+VLiGIc7YQ1E=;
 b=cmWKjyS/rGVdr3a9YjioVQuQ95k0zbFtRKl5oyNHmSosahG88+bq9FrmS2Qb8JLl7fLzXvqHMYaaNjrz8xEMM4FTOfrEKnKyr6woTvFA8AegYgbuO4v7Dp97jH/ICO34G1hXlrzY3M80PY3ey/soG4AxrjDRL01sVU68Go2EMHZQPs1zmkGWUUWA06Y2Ic5MOnCYjnU9YXinV1PepB2Ga41KUikVNQ5k4Gqu5MS9c6JwsWU/l6Gw6BX7Xn5NcjUrR08rPr1SfI5h0f9APOFGpgR4kie18XEGX0ecWGL5xRbFwVsI87aXea0U3eD85MDu32nQ+0twWegz5a0ML/Zsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zblQVur6Uz9ZG8lEIh1Gzj1Bk43bkrv+VLiGIc7YQ1E=;
 b=LKtPcmyPYYxTyvKCkRpNURPZaKIy/E7vku6cslOhhgAW7v1ailN/gg14nbxDtkVPl5clZUs0hWiU2EKhD5ftTWVglATPQ8LsTNixepGYc0ogntXaIEKGtq7ElErfhfBV7rKb+GzI0qkIX9eYv8BJTE5c6R/zbhqZVWX5MiSkVEw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1418.namprd13.prod.outlook.com (2603:10b6:3:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.11; Tue, 14 Jun
 2022 19:48:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%7]) with mapi id 15.20.5353.013; Tue, 14 Jun 2022
 19:48:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT
 writeback error on close() file
Thread-Topic: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT
 writeback error on close() file
Thread-Index: AQHYgAGRBdlVDWmn/0KFB/DfAtVV6a1PT16A
Date:   Tue, 14 Jun 2022 19:48:19 +0000
Message-ID: <806ae30d4d53886e7d394cc9abb0b2045a314f01.camel@hammerspace.com>
References: <20220614152817.271507-1-chenxiaosong2@huawei.com>
In-Reply-To: <20220614152817.271507-1-chenxiaosong2@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c3c3a2-48f1-4b26-ff5e-08da4e3ed50d
x-ms-traffictypediagnostic: DM5PR13MB1418:EE_
x-microsoft-antispam-prvs: <DM5PR13MB141839BBC0BC93EFD0701A90B8AA9@DM5PR13MB1418.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lIWd6b6JA+sA5KrnPzgYXaAws7PVzRHZv/PkPzCmWd5ohh4TCjRkDFbQ1FQc/tJkwzg6PghictfcWZIvuR/68+ZXluMcoQI+pJN8A6easCoWoJKdkM9eTxZhDIfzept4RybcC0Kdafu1Z3chB715YxBfKptNVGKHDFNeJwGB0LQR1ZRLhHhI4JqKTMh00oUBSvO2aDT2tPND9B25r+RJPPvERxKiQ6ZqX8oVmKNYV5A55uC5UzNWi7KxgfnDviYhV3HrIcTTZLJjpZfqPwdq5mMq2YySYwijkvEjxUlPF2UkZqKiBG3TptjU0eWIgxaBJorQJ2bzonLC3S1qFjFChvfLj8Q/58Q8gUnN9icEpb7NyY5vZL+WvVAFKxKNQBK+eiQJCGUb6A0GFiRwejn6FWkkVK6MjVpXohKPzBAimwXhC7fXZDTbKCr75E6+NsdKmyCXm8g30LhFgkXi0H2O/wE+/qMqE6HpkaKK6JSbg7+fB3nzjW26UCRSN2RzfXn1d8MWDIC0IQRvPrNQp/Wwx5BEm9f7Wt0oocaqp3EYPPXvpCp9TIsdeDmnqAVHWvp0OX5yutAqFPGK9bn0gSFdPg/MC71ZuIz+NQ3A9JZoCUdLrgeRZQH8VYpOsWNG6/IyDTFpRwzPcv1uyGMNrascStFgPG7VgCsIJoymI2UCVSJldKe/SD+JPEdV/kA8Jyq+LfH9XPM5uI3i6g8+eRwbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(346002)(396003)(136003)(366004)(122000001)(66946007)(316002)(76116006)(38100700002)(186003)(86362001)(26005)(66476007)(8936002)(4326008)(66446008)(36756003)(8676002)(38070700005)(66556008)(41300700001)(110136005)(54906003)(2906002)(2616005)(64756008)(508600001)(71200400001)(5660300002)(83380400001)(6512007)(6486002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG8yeCtpVm5YcUZXWXFqRjdoQURDdUd1Qm9PbldxSWRhZVJteEpMZmducUoy?=
 =?utf-8?B?MWdaT3o2c2FTNEhIai8xQ2RoTDhFVEVnREpqWklMMFhkZ3VEZnhlMTYwOFNG?=
 =?utf-8?B?V1dkcUo0U09KeXVXd0FpYjV0NXFjYXJsY2lCaVNNamVrVWpHTzk4NWRNeVZi?=
 =?utf-8?B?cEVsbUdYTFdrZ0RsMnFocmhDUEFPNjJ2VkM4dWI4RTQrYlVQclBuYzlSdmRw?=
 =?utf-8?B?NzhmYVQvV0tycUszaFBOaDNJUzBWenBhMjQyUTcySTJLRnc1QzdqaVpRMGRF?=
 =?utf-8?B?YlNLMEwwaFk1ZkxyM0c0VHMzd2pibkFOVmhpQ001eXNCeFFMenBBell2TWsx?=
 =?utf-8?B?UjdaWUY3cEUvYXdCbmZsUkpXVFhjWGwyQUE0TFg4S2drSzFZdDhjT05KOXh1?=
 =?utf-8?B?M3dhOTlZR0dqcGtmbEpzMnN2WVJSbmtwNUMrVlJReVhDQzByamNaT2dkZzNk?=
 =?utf-8?B?MUFiWVRhbzdJTWVJMkZwVzB0UVp0QVA3dWxYeDlJV1B5U2hVS0Z3TksvUndr?=
 =?utf-8?B?ZHhRblZQRm1FRUxLa09hL2l0R0VDT0JBUWI3Mk1xZE5kNEZTQTh0dkVsSEM0?=
 =?utf-8?B?dXFxVVJYN2dnQ3dYeFFEUXlraXZIQkRvcVllTWJZMGJ3bHozM04ra2dpOHk5?=
 =?utf-8?B?Rk1LRDVzU0tBQUUrdmhOSFgrV0wvVUw4eUp5cmtZQnpGWjU0NXppYTlwdzNy?=
 =?utf-8?B?alcrNUFicTFpQkloR3J6VDhYL1MyTEcva3k4NVpPeXFLYytjZmdkRTJVK0dr?=
 =?utf-8?B?aTk0SVBwWFhyczRhNTJQTlpuYnM1NGoxSk9LTXNKVXpuNFZRVnVwYUhwajJU?=
 =?utf-8?B?UUhBSnNhclhRWTNpQmszcC9NU1llbHZaNE5jQmRoZnY5TDJVNG5kTTl1dldV?=
 =?utf-8?B?c3FqRzI0d1JaZ2dCVjBrUnpYZjNTSU9SRjRlV285NHJyOWtWVGJ1a25qd0Rq?=
 =?utf-8?B?WERjZklhU2pQUzRraFpsTnh5VmMzQ3N0TXlsZURBa2JTYW1HMU9TWVBLZThJ?=
 =?utf-8?B?Q2JrZlJlNFF3L2I0UnRnamdnS3VHRHF0TGtpWVVPSE0rbGdtSEtvSmhIeEdI?=
 =?utf-8?B?VTExRXJUNDEyYUdROThMOU9YNzc4UVFZOEY4Rml6a1ZJOFJEY20vZlFNbUpj?=
 =?utf-8?B?dUZ5WFFTMXhVQXV2R0xEV2ZGSlBDc0hPcEVXRGhFOGFoVUg1bEViSk56a2Nv?=
 =?utf-8?B?MWtQcnA2bUJLT01zaWpuQi92RFU1YUdlR1h4S1ZScmFkM09lLzJ6cFJmK01Z?=
 =?utf-8?B?K3dBYmR4VXZwdnYrTzJhQ0RZeFZsMUJ3LzFKNExOMW5zOHZYREs1K1dCWFRR?=
 =?utf-8?B?Z1prQmpXYm5tc2JWS0xPZ0JFd1Q1aUliYW42Z0RlOVpta0QxWWNBZDljTWc1?=
 =?utf-8?B?QlJuRVJaTlJqV2JXYWpwNCs3Vm4xSG5zOCtHeEcwejB4RmVYQTBzZUx6Ullw?=
 =?utf-8?B?MFl5R01xQ1p2dk0zaVFhbHhGMXZ5MGg3amZ3MktLMjBmaEQxMUNmNCtiU0lh?=
 =?utf-8?B?eGR2NkVZOFlJY1AzYzAwZDdieSt6SStxSGQ5QldVdTdJWG4rLzJnYWUyZGVu?=
 =?utf-8?B?amlLZlBrSFBOVnliVXdYa2JFaE5EVHYxMElXb0RUUkZuVElNblEwSlVZaVZJ?=
 =?utf-8?B?Q2pYc3lERVE0TVYzdE9yQitRbDFNWFh0RGw2ejhoekVWd2U4K1ZRU1VCRjF1?=
 =?utf-8?B?R0N3R2dvWWt2YmxQTmliaUgyNW0wdS9Cd3NrS2JPMEZNa2hYVHJ2dVdXbHl6?=
 =?utf-8?B?aU5RMUQ0TDhoMDVuRnMwdmRaY2hQQUlCdzYrbkxwMmgxendDSkFXSUtKb3Av?=
 =?utf-8?B?UHZzVno2K0ptcnpReFV3a1d6U2svTVUzeWVZUUFKYVU1SnVzSm1zV3RBbnV4?=
 =?utf-8?B?QjlCZGlveG02YVRKNThSUGY3KzExbys2R2t3T0JVWGFvTm1wUUNGazNYcVBM?=
 =?utf-8?B?Y2t0UmYxbnJ4cU5IS1pFdWkyc3N0bklYNDdtNUVMQzJVL0tFWVQyS05kSU80?=
 =?utf-8?B?RFA4VTVZNkVCQWxrdDUxc1FXN2ZUT3pmSWZ6SWJxWnh2L1VXR1R0dTlmR0Rm?=
 =?utf-8?B?OVZjcWs1VGVneUlka0wreGFlTGdjdFdsVGswZm1YVTFlWVFoUFJrSnROMDF0?=
 =?utf-8?B?ck9qTmFsbmsvT2NnbDlkd2dpSlA3UWVIT2xSRldia3dBc2MyZGxwb1VoSHVk?=
 =?utf-8?B?alczOXB1cWlvcGpyN05XTndIUDlSWTFzVXBhOHFrakZUT2ZBU052dVc0aEhr?=
 =?utf-8?B?R1ZwTlphWCt1WU1sclBYcEU1V2U3ZE5yS09KVVFKN3ZKVCttZUJEbW1rNEky?=
 =?utf-8?B?bTI2dytDekhmZHgrWDlEdTVURmFET0pSWmZETDRQRHduV2hhZXgzRGhyTGZQ?=
 =?utf-8?Q?jC/OfHB4vXSYq2i8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EF872FE180B6F44BF83117F688D2A18@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c3c3a2-48f1-4b26-ff5e-08da4e3ed50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 19:48:19.5593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3u/zB3YTaG2ITGisZ+Rduk6Zwo1FY+hlqkonsb+0otdNZa+F28st2WV7VtUPEwo4HYCrswI3hXuO8LD35gP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA2LTE0IGF0IDIzOjI4ICswODAwLCBDaGVuWGlhb1Nvbmcgd3JvdGU6Cj4g
Q3VycmVudGx5LCB3ZSByZXBvcnQgYW5kIGNsZWFyIEVOT1NQQy9FRkJJRy9FRFFVT1Qgd3JpdGVi
YWNrIGVycm9yIG9uCj4gd3JpdGUoKSwKPiB3cml0ZSgpIGZpbGUgd2lsbCByZXBvcnQgdW5leHBl
Y3RlZCBlcnJvciBpZiBwcmV2aW91cyB3cml0ZWJhY2sgZXJyb3IKPiBoYXZlIG5vdAo+IGJlZW4g
Y2xlYXJlZC4KPiAKPiBSZXByb2R1Y2VyOgo+IMKgwqDCoMKgwqDCoMKgIG5mcyBzZXJ2ZXLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgbmZzIGNsaWVudAo+IMKgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiAtLS0tLS0tCj4gwqAjIE5vIHNwYWNlIGxlZnQgb24gc2VydmVywqDCoMKgIHwKPiDCoGZh
bGxvY2F0ZSAtbCAxMDBHIC9zdnIvbm9zcGMgfAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBtb3VudCAtdCBuZnMgJG5mc19zZXJ2
ZXJfaXA6LyAvbW50Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICMgRXhwZWN0ZWQgZXJyb3I6IE5vIHNwYWNlIGxlZnQg
b24KPiBkZXZpY2UKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgZGQgaWY9L2Rldi96ZXJvIG9mPS9tbnQvZmlsZSBjb3VudD0xCj4g
aWJzPTEwSwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAjIFJlbGVhc2Ugc3BhY2Ugb24gbW91bnRwb2ludAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBy
bSAvbW50L25vc3BjCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICMgSnVzdCB3cml0ZSA1MTJCIGFuZCByZXBvcnQKPiB1
bmV4cGVjdGVkIGVycm9yCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IGRkIGlmPS9kZXYvemVybyBvZj0vbW50L2ZpbGUgY291bnQ9
MQo+IGlicz0xMEsKPiAKPiBGaXggdGhpcyBieSBjbGVhcmluZyBFTk9TUEMvRUZCSUcvRURRVU9U
IHdyaXRlYmFjayBlcnJvciBvbiBjbG9zZQo+IGZpbGUsCj4gaXQgd2lsbCBub3QgY2xlYXIgb3Ro
ZXIgZXJyb3JzIHRoYXQgYXJlIG5vdCBzdXBwb3NlZCB0byBiZSByZXBvcnRlZAo+IGJ5IGNsb3Nl
KCkuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hlblhpYW9Tb25nIDxjaGVueGlhb3NvbmcyQGh1YXdl
aS5jb20+Cj4gLS0tCj4gwqBmcy9uZnMvZmlsZS5jwqDCoMKgwqAgfCAxNiArKysrKysrKy0tLS0t
LS0tCj4gwqBmcy9uZnMvaW50ZXJuYWwuaCB8IDEwICsrKysrKysrKysKPiDCoGZzL25mcy9uZnM0
ZmlsZS5jIHzCoCA5ICsrKysrKystLQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZpbGUuYyBiL2Zz
L25mcy9maWxlLmMKPiBpbmRleCAyZDcyYjFiN2VkNzQuLjI3NWQxZmRjN2Y5YSAxMDA2NDQKPiAt
LS0gYS9mcy9uZnMvZmlsZS5jCj4gKysrIGIvZnMvbmZzL2ZpbGUuYwo+IEBAIC0xMzgsNyArMTM4
LDcgQEAgc3RhdGljIGludAo+IMKgbmZzX2ZpbGVfZmx1c2goc3RydWN0IGZpbGUgKmZpbGUsIGZs
X293bmVyX3QgaWQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpbm9kZcKgwqDCoMKg
Kmlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsKPiAtwqDCoMKgwqDCoMKgwqBlcnJzZXFfdCBzaW5j
ZTsKPiArwqDCoMKgwqDCoMKgwqBlcnJzZXFfdCBzaW5jZSwgZXJyb3I7Cj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgZHByaW50aygiTkZTOiBmbHVzaCglcEQyKVxuIiwgZmlsZSk7Cj4gwqAKPiBAQCAt
MTQ5LDcgKzE0OSwxMiBAQCBuZnNfZmlsZV9mbHVzaChzdHJ1Y3QgZmlsZSAqZmlsZSwgZmxfb3du
ZXJfdCBpZCkKPiDCoMKgwqDCoMKgwqDCoMKgLyogRmx1c2ggd3JpdGVzIHRvIHRoZSBzZXJ2ZXIg
YW5kIHJldHVybiBhbnkgZXJyb3JzICovCj4gwqDCoMKgwqDCoMKgwqDCoHNpbmNlID0gZmlsZW1h
cF9zYW1wbGVfd2JfZXJyKGZpbGUtPmZfbWFwcGluZyk7Cj4gwqDCoMKgwqDCoMKgwqDCoG5mc193
Yl9hbGwoaW5vZGUpOwo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBmaWxlbWFwX2NoZWNrX3diX2Vy
cihmaWxlLT5mX21hcHBpbmcsIHNpbmNlKTsKPiArwqDCoMKgwqDCoMKgwqBlcnJvciA9IGZpbGVt
YXBfY2hlY2tfd2JfZXJyKGZpbGUtPmZfbWFwcGluZywgc2luY2UpOwo+ICsKPiArwqDCoMKgwqDC
oMKgwqBpZiAobmZzX3Nob3VsZF9jbGVhcl93Yl9lcnIoZXJyb3IpKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBmaWxlX2NoZWNrX2FuZF9hZHZhbmNlX3diX2VycihmaWxlKTsKCk5B
Q0suIEhvdyBtYW55IHRpbWVzIGRvIEkgaGF2ZSB0byByZXBlYXQgdGhhdCB3ZSBkbyBOT1QgY2xl
YXIgdGhlIGVycm9yCmxvZyBpbiBmbHVzaCgpPwoKCgo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1
cm4gZXJyb3I7Cj4gwqB9Cj4gwqAKPiDCoHNzaXplX3QKPiBAQCAtNjczLDEyICs2NzgsNyBAQCBz
c2l6ZV90IG5mc19maWxlX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwKPiBzdHJ1Y3QgaW92X2l0
ZXIgKmZyb20pCj4gwqBvdXQ6Cj4gwqDCoMKgwqDCoMKgwqDCoC8qIFJldHVybiBlcnJvciB2YWx1
ZXMgKi8KPiDCoMKgwqDCoMKgwqDCoMKgZXJyb3IgPSBmaWxlbWFwX2NoZWNrX3diX2VycihmaWxl
LT5mX21hcHBpbmcsIHNpbmNlKTsKPiAtwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGVycm9yKSB7Cj4g
LcKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
YnJlYWs7Cj4gLcKgwqDCoMKgwqDCoMKgY2FzZSAtRURRVU9UOgo+IC3CoMKgwqDCoMKgwqDCoGNh
c2UgLUVGQklHOgo+IC3CoMKgwqDCoMKgwqDCoGNhc2UgLUVOT1NQQzoKPiArwqDCoMKgwqDCoMKg
wqBpZiAobmZzX3Nob3VsZF9jbGVhcl93Yl9lcnIoZXJyb3IpKSB7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBuZnNfd2JfYWxsKGlub2RlKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGVycm9yID0gZmlsZV9jaGVja19hbmRfYWR2YW5jZV93Yl9lcnIoZmlsZSk7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJyb3IgPCAwKQo+IGRpZmYg
LS1naXQgYS9mcy9uZnMvaW50ZXJuYWwuaCBiL2ZzL25mcy9pbnRlcm5hbC5oCj4gaW5kZXggOGY4
Y2Q2ZTJkNGRiLi5lNDlhYWQ4ZjdkMDkgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL2ludGVybmFsLmgK
PiArKysgYi9mcy9uZnMvaW50ZXJuYWwuaAo+IEBAIC04NTksMyArODU5LDEzIEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBuZnNfc2V0X3BvcnQoc3RydWN0IHNvY2thZGRyCj4gKnNhcCwgaW50ICpwb3J0
LAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJwY19zZXRfcG9ydChzYXAsICpwb3J0KTsKPiDCoH0K
PiArCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBuZnNfc2hvdWxkX2NsZWFyX3diX2VycihpbnQgZXJy
b3IpIHsKPiArwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGVycm9yKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
Y2FzZSAtRURRVU9UOgo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgLUVGQklHOgo+ICvCoMKgwqDCoMKg
wqDCoGNhc2UgLUVOT1NQQzoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsK
PiArfQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNGZpbGUuYyBiL2ZzL25mcy9uZnM0ZmlsZS5j
Cj4gaW5kZXggMDNkM2EyNzBlZmY0Li5kZGYzZjBhYmQ1NWEgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZz
L25mczRmaWxlLmMKPiArKysgYi9mcy9uZnMvbmZzNGZpbGUuYwo+IEBAIC0xMTMsNyArMTEzLDcg
QEAgc3RhdGljIGludAo+IMKgbmZzNF9maWxlX2ZsdXNoKHN0cnVjdCBmaWxlICpmaWxlLCBmbF9v
d25lcl90IGlkKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5vZGXCoMKgwqDCoCpp
bm9kZSA9IGZpbGVfaW5vZGUoZmlsZSk7Cj4gLcKgwqDCoMKgwqDCoMKgZXJyc2VxX3Qgc2luY2U7
Cj4gK8KgwqDCoMKgwqDCoMKgZXJyc2VxX3Qgc2luY2UsIGVycm9yOwo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoGRwcmludGsoIk5GUzogZmx1c2goJXBEMilcbiIsIGZpbGUpOwo+IMKgCj4gQEAgLTEz
MSw3ICsxMzEsMTIgQEAgbmZzNF9maWxlX2ZsdXNoKHN0cnVjdCBmaWxlICpmaWxlLCBmbF9vd25l
cl90Cj4gaWQpCj4gwqDCoMKgwqDCoMKgwqDCoC8qIEZsdXNoIHdyaXRlcyB0byB0aGUgc2VydmVy
IGFuZCByZXR1cm4gYW55IGVycm9ycyAqLwo+IMKgwqDCoMKgwqDCoMKgwqBzaW5jZSA9IGZpbGVt
YXBfc2FtcGxlX3diX2VycihmaWxlLT5mX21hcHBpbmcpOwo+IMKgwqDCoMKgwqDCoMKgwqBuZnNf
d2JfYWxsKGlub2RlKTsKPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gZmlsZW1hcF9jaGVja193Yl9l
cnIoZmlsZS0+Zl9tYXBwaW5nLCBzaW5jZSk7Cj4gK8KgwqDCoMKgwqDCoMKgZXJyb3IgPSBmaWxl
bWFwX2NoZWNrX3diX2VycihmaWxlLT5mX21hcHBpbmcsIHNpbmNlKTsKPiArCj4gK8KgwqDCoMKg
wqDCoMKgaWYgKG5mc19zaG91bGRfY2xlYXJfd2JfZXJyKGVycm9yKSkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZmlsZV9jaGVja19hbmRfYWR2YW5jZV93Yl9lcnIoZmlsZSk7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBlcnJvcjsKPiDCoH0KPiDCoAo+IMKgI2lmZGVmIENP
TkZJR19ORlNfVjRfMgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
