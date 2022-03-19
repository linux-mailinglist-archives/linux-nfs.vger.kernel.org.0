Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE774DE4E1
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Mar 2022 01:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiCSAha (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Mar 2022 20:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiCSAha (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Mar 2022 20:37:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2137.outbound.protection.outlook.com [40.107.102.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81C2DF3E9;
        Fri, 18 Mar 2022 17:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoicLKyDcnHk9jAVCDj31igh5JlWA6jL/Eadh77sosc+Ix++HWRKc8RwfyQzm8zj5eVrLDb2V5FdPUDkvLmj9Qu5W6JAwg2/xz55PpMCYBNTVrL2Ed7rpgTfCM7P+4Oac+BEW+29T8jGKw1E9jQctuZ0VclBWMZi9lfOCodgadgrBS1905JmTZwZ/cZf/FCFTtuQqLakaC3QChG01ZZyFY0wOdQAssi2Rq1c5pDfPTDF6dVEJI6gwYDKC970j9/jZJhkozqS2EylrrAXo8DM2NzCCdpqPPnM94PJ76Z2OgkzkDdRB+AFBw4ZLtMAWOZtxOWY+70wlHTAr+AZlIeQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuG98TcIXs9jrhW0P0ZJ4aoIgCnQyv8FQUTQiVMoSOE=;
 b=lU7nd8Gg8SJdzVY7I8DZBJHzw7FrVgAo+qvjGGzUvcsrkA2RmADE+SSEGCfGwODDjyp5Ayz2UAbgjvcMmDrsb6nYXhVdaWcry6p+6UMA8bQIaBm90efS7IUn/lOeAz8RZ9TXq2YTR8DhXBh4KMhWocivZK1Cm9IE5hz43vCfq0TgGeGZK7qhOA8ZOuZSKIlQoWQQhWfEIAft+5tyAB0J+XK5Y2P3U1V9NSB7vVbvcjpt1Wut/c6bp3TQYs7FUS/DvNqWRuy3E+ZQ0nJAMsktSdM2NCnq4ueiCBA7dn/0GiUelDHKLEHXoTltp4/Cl+nCdQO6YSDxTu5HDJkDDAQkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuG98TcIXs9jrhW0P0ZJ4aoIgCnQyv8FQUTQiVMoSOE=;
 b=en+d9EvmEAPIA3Zhu5D3J7K+rHITvjL3b62O5v/dAgEiRnXlj3VpPcEw+qi7AsmGubstrOAcTMigT8Cd9BBCIQm+zKDoMojkO5qY2pBDj5jqlzeS9D7nf122ext6XdfTk9+77GwdGMVBuF68M8PYGpu9+nFTfpfiIa9H0Jgi0Ew=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB3997.namprd13.prod.outlook.com (2603:10b6:806:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Sat, 19 Mar
 2022 00:36:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5102.011; Sat, 19 Mar 2022
 00:36:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "khazhy@google.com" <khazhy@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Thread-Topic: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Thread-Index: AQHYOyajLa8/8HRLJEmjaX9teCCEe6zF3FKA
Date:   Sat, 19 Mar 2022 00:36:05 +0000
Message-ID: <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
References: <20220319001635.4097742-1-khazhy@google.com>
In-Reply-To: <20220319001635.4097742-1-khazhy@google.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fef2f54-53a5-4585-595a-08da09407443
x-ms-traffictypediagnostic: SA0PR13MB3997:EE_
x-microsoft-antispam-prvs: <SA0PR13MB3997554B6DE734AA4369D4D4B8149@SA0PR13MB3997.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXQxO8Nbnw2JvdvGgvj9mAqPs8MkNXZfz4FoJbwHpz31XWQWxaILpNY6qoiEU83T9oM5JWmlrK6BQXiXtOMyl+TGCVT8R4kgh5H+gNLz/0LU5Y7Xl2utoJjLx0+QpvFze8qsZkY6gt6TuRwaEAYtdi+i8UXVzGdRpYyfzQ1QASndXTdDZh+dclF1fvjFU8x6REDh4wvdghYW2w/YI8xrA66U8h8QE31rLzDkUSPTmVUYkRnhU7srnhEUwHkv15n1ApNgqaRtVg6TwReI+vBW7AIXkOux5IBbv37aXxOFiAEJ0drIAbgwO4QbgmH4b1vK5TvU0LxGIDTmQCHNBUG/jh3zrjLYlVxWgGav8Gz4/hofeVN1lGhC329L2UQoVU7HejzNks/qJIrN1zS1i4MwFH2o+JN+O6gCxXrpPbKTM0O2D9niyjUfExz7zYOSUpwijbG63RS4NVeXI+YpXj+ZP/miopBmq7NPhq8ycI87Y9HCpLIyPKU/I7azxCRcn8dIv6czfZX/rnfpvOKkHvs0G5q+t45tkeRKp2KSelIjchLTk1y7OnjbumoMLvivX3DnPGELmMrdpVoVslelE3x+zQgbRehLYyBujjQjv+w4/axQEV1VN8XmA4HAxtWC7FmJViVCGL6vTbmpz6AVzpqFQ8GqGD+qAk6JaAm11pa3JeaCD8L3jvhuFA0FJxQMBxfjoRtAIupxKgeMD+lPMe7lxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66446008)(66476007)(66556008)(64756008)(66946007)(76116006)(316002)(6486002)(54906003)(508600001)(122000001)(86362001)(38070700005)(36756003)(38100700002)(110136005)(2616005)(186003)(26005)(6506007)(71200400001)(6512007)(5660300002)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TExrWUFkODFicnlwME5xbURtNEljRTZzYjV5UkxmNjVXeUc2MWkwSGRyc0Ri?=
 =?utf-8?B?Z0FuaGhhbUtvdVVIWVlpMGsyOTBMYUkrTDZKRk93UnRtc2RsQ1kxNjlHeUxP?=
 =?utf-8?B?LzNXZmR1ZlBYVjVpcmtyWGd1cGJkZ1lOMVJnUGxmV0w3M0NTNC9FQ09xa0VY?=
 =?utf-8?B?eTM1b1lZTDBFTVhTQU84WWtoYmVEQTVDdHZub0tqNGlTUmU2VTJiOFNBS05r?=
 =?utf-8?B?N0xaSEJPYmdDY3A4ZXUxU2E4TWN4Z3BrN0tzem43YlYzRk9KSE9CMTY5TEFw?=
 =?utf-8?B?Um1UWEpsT0xyZThpRFg0UldqMFZTdUdhWm1WS2o2MjVzci9iMHdpSERQZ2li?=
 =?utf-8?B?bWFMbkpSRnZvWXBpWnZjbzhBRGRRdkxGbEpHTit2ZWxpLy8zZWFrSC9YMXNL?=
 =?utf-8?B?YkpVTUlvRzJPc0M5V3NzaHl1U2E5MjNvcXg4MXBwL0FENlIrenpwWXR6eEJT?=
 =?utf-8?B?NDZJNVgxdTZtS1VXOTlENk9WaXVpMXBvTU5IbnN5UGpMSjBiMzhlc1JyUFda?=
 =?utf-8?B?NkhUMmJENVkwZmx4SlQvZ3l0VGp5NDk2RnJtem1RSU82TE9UaFRXdUI3eEpa?=
 =?utf-8?B?SmZsSGl1WlFQc0xEelZReTRNUG9ZVDNIVXFUTjdSTGJ4NlBSY2JPYzN4VmI4?=
 =?utf-8?B?b0RvblZxVFNkQ2tzMXdTV1h6dk9HdEFoZ0UrV2xSNTZFeU0weEM5U05UdWxx?=
 =?utf-8?B?cGR0aFRhdFZma0J6MzQ5Njk0Z1oyWDZVRkdhelM1QkU1YVJvK2gxeGZkUThD?=
 =?utf-8?B?dkd4ZThOYXFhNEhHczI3ZExNekx0VGF2M1VjQ0hjaE1VcXdwNndRWXpYcUJL?=
 =?utf-8?B?cCthYkFWdW00aWNZT2ZRVk0wUlFxWjVFS09sZVVKaXFXcG1uYTdyTzFtZVN1?=
 =?utf-8?B?ZzYvQkVTZndjWnE3aXQwNTNVWnE0aVJhS0ZsY1NwVVlwVGIwaTNXMHhPQkRW?=
 =?utf-8?B?U0FtQnR4dVk5d04vTnBrSEp1dkxoWDZFa2h5eXo3c1pqZjl5M3NPME85d2U4?=
 =?utf-8?B?cktOMU9kb29TcGs3YWtlcitRZFpYbXh6VmZZRFdOenk5c0xPL0RETUc0cFBu?=
 =?utf-8?B?THIydXlxUmx3M3EwcDVxUldBRFpUZXpqWDRYRlRnaVdpekl0R2pFZE82dXdX?=
 =?utf-8?B?Z2JPRmg3NnRmazRuVzA2ZjhFSFh5UEdaUTkrZGtTU2hGYkhvYVNDL1lGeURt?=
 =?utf-8?B?eXR1NmZLaVZmeDEySDRFK1c0WUFuWUJQamdGaXl0cGdad3BOUzRtT3ByVVdJ?=
 =?utf-8?B?MTRvd09UVTFmckxURmdUWElEa3FyR3dKRSszWHZCOTltTmFIcFIyM1g3L0NL?=
 =?utf-8?B?dlhEMmMrRWxER2dHaEJLVmRjUEc4MU93UkJFMjN1NGlmNXprNC9RTCs0ZGJU?=
 =?utf-8?B?eXd1cFFIUG10NGRNQk1aclRubER5MldTLzFPWnMvM0VHUVZkNXRhalY3b3Ur?=
 =?utf-8?B?dDg3MHgvZ2NsbVBhaVptZUJyaUFRNS9TWkpkcndiZ015QzNBZUp5TTJVMEtL?=
 =?utf-8?B?d0ZGYUJTdG9nN29taTZCdXF3d1pCejNERFhQNjFBSjVvSTNwVjF1ajFHRWtn?=
 =?utf-8?B?Q0hlMThTMkZycnc4ZWRvdHYwK0Zka1lkbHhpU3NmSzFMN2FKM0t6TDZUOFoz?=
 =?utf-8?B?RUdVVFNsWkpxSnRQU0lQa215QlpTRE1BVFJtWkFXRmJlSVBKdTYxQTlZa2J1?=
 =?utf-8?B?cXJyYTVjZitlcHM3ZW4yV1F6VmIrbWF5clJUM3dpM2tjUGh1dEV5MWRKVTNz?=
 =?utf-8?B?UEd4ZStPZHB1OWxnOUR4aTVVazdNeXYrYzVrYWwreTFnQTNwZ3U3VFZjVUhz?=
 =?utf-8?B?L0hQVXdmRFUwSDlrT3E4d2J4OGtsb3ZyUS9CSEYyVkFFUWJXeWNtUElGeHhI?=
 =?utf-8?B?THI0REdYVmxJUTR6TVQzVmU4V2JrNXlTcjl6K1VpTS8rdWtTaEZON0tqK0xE?=
 =?utf-8?B?OFRvcVR1QTZRVndxTUk4b3BjOWJPVVlLcW1DZVlQNW9oOEdmS3Ezb2VHWFZ4?=
 =?utf-8?B?dnk4SHMvWjVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39A1E20288061447B2A4628A0739C724@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fef2f54-53a5-4585-595a-08da09407443
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 00:36:05.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRecbVshvkTU7ZLq9c7a+VaQe8qwfqH6zloMXRSO8CSetrYBOTWuWUI6FH+RVWBApWGuqvzvmyJXFzjn7gGA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTE4IGF0IDE3OjE2IC0wNzAwLCBLaGF6aGlzbWVsIEt1bXlrb3Ygd3Jv
dGU6DQo+IGZzbm90aWZ5X2FkZF9pbm9kZV9tYXJrIG1heSBhbGxvY2F0ZSB3aXRoIEdGUF9LRVJO
RUwsIHdoaWNoIG1heQ0KPiByZXN1bHQNCj4gaW4gcmVjdXJzaW5nIGJhY2sgaW50byBuZnNkLCBy
ZXN1bHRpbmcgaW4gZGVhZGxvY2suIFNlZSBiZWxvdyBzdGFjay4NCj4gDQo+IG5mc2TCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIETCoMKgwqAgMCAxNTkxNTM2wqDCoMKgwqDCoCAyIDB4ODAwMDQwODAN
Cj4gQ2FsbCBUcmFjZToNCj4gwqBfX3NjaGVkdWxlKzB4NDk3LzB4NjMwDQo+IMKgc2NoZWR1bGUr
MHg2Ny8weDkwDQo+IMKgc2NoZWR1bGVfcHJlZW1wdF9kaXNhYmxlZCsweGUvMHgxMA0KPiDCoF9f
bXV0ZXhfbG9jaysweDM0Ny8weDRiMA0KPiDCoGZzbm90aWZ5X2Rlc3Ryb3lfbWFyaysweDIyLzB4
YTANCj4gwqBuZnNkX2ZpbGVfZnJlZSsweDc5LzB4ZDAgW25mc2RdDQo+IMKgbmZzZF9maWxlX3B1
dF9ub3JlZisweDdjLzB4OTAgW25mc2RdDQo+IMKgbmZzZF9maWxlX2xydV9kaXNwb3NlKzB4NmQv
MHhhMCBbbmZzZF0NCj4gwqBuZnNkX2ZpbGVfbHJ1X3NjYW4rMHg1Ny8weDgwIFtuZnNkXQ0KPiDC
oGRvX3Nocmlua19zbGFiKzB4MWYyLzB4MzMwDQo+IMKgc2hyaW5rX3NsYWIrMHgyNDQvMHgyZjAN
Cj4gwqBzaHJpbmtfbm9kZSsweGQ3LzB4NDkwDQo+IMKgZG9fdHJ5X3RvX2ZyZWVfcGFnZXMrMHgx
MmYvMHgzYjANCj4gwqB0cnlfdG9fZnJlZV9wYWdlcysweDQzZi8weDU0MA0KPiDCoF9fYWxsb2Nf
cGFnZXNfc2xvd3BhdGgrMHg2YWIvMHgxMWMwDQo+IMKgX19hbGxvY19wYWdlc19ub2RlbWFzaysw
eDI3NC8weDJjMA0KPiDCoGFsbG9jX3NsYWJfcGFnZSsweDMyLzB4MmUwDQo+IMKgbmV3X3NsYWIr
MHhhNi8weDhiMA0KPiDCoF9fX3NsYWJfYWxsb2MrMHgzNGIvMHg1MjANCj4gwqBrbWVtX2NhY2hl
X2FsbG9jKzB4MWM0LzB4MjUwDQo+IMKgZnNub3RpZnlfYWRkX21hcmtfbG9ja2VkKzB4MThkLzB4
NGMwDQo+IMKgZnNub3RpZnlfYWRkX21hcmsrMHg0OC8weDcwDQo+IMKgbmZzZF9maWxlX2FjcXVp
cmUrMHg1NzAvMHg2ZjAgW25mc2RdDQo+IMKgbmZzZF9yZWFkKzB4YTcvMHgxYzAgW25mc2RdDQo+
IMKgbmZzZDNfcHJvY19yZWFkKzB4YzEvMHgxMTAgW25mc2RdDQo+IMKgbmZzZF9kaXNwYXRjaCsw
eGY3LzB4MjQwIFtuZnNkXQ0KPiDCoHN2Y19wcm9jZXNzX2NvbW1vbisweDJmNC8weDYxMCBbc3Vu
cnBjXQ0KPiDCoHN2Y19wcm9jZXNzKzB4ZjkvMHgxMTAgW3N1bnJwY10NCj4gwqBuZnNkKzB4MTBl
LzB4MTgwIFtuZnNkXQ0KPiDCoGt0aHJlYWQrMHgxMzAvMHgxNDANCj4gwqByZXRfZnJvbV9mb3Jr
KzB4MzUvMHg0MA0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2hhemhpc21lbCBLdW15a292IDxraGF6
aHlAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+IMKgZnMvbmZzZC9maWxlY2FjaGUuYyB8IDQgKysrKw0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IE1hcmtpbmcgdGhpcyBS
RkMgc2luY2UgSSBoYXZlbid0IGFjdHVhbGx5IGhhZCBhIGNoYW5jZSB0byB0ZXN0IHRoaXMsDQo+
IHdlDQo+IHdlJ3JlIHNlZWluZyB0aGlzIGRlYWRsb2NrIGZvciBzb21lIGN1c3RvbWVycy4NCj4g
DQo+IGRpZmYgLS1naXQgYS9mcy9uZnNkL2ZpbGVjYWNoZS5jIGIvZnMvbmZzZC9maWxlY2FjaGUu
Yw0KPiBpbmRleCBmZGY4OWZjZjFhMGMuLmExNDc2MGY5YjQ4NiAxMDA2NDQNCj4gLS0tIGEvZnMv
bmZzZC9maWxlY2FjaGUuYw0KPiArKysgYi9mcy9uZnNkL2ZpbGVjYWNoZS5jDQo+IEBAIC0xMjEs
NiArMTIxLDcgQEAgbmZzZF9maWxlX21hcmtfZmluZF9vcl9jcmVhdGUoc3RydWN0IG5mc2RfZmls
ZQ0KPiAqbmYpDQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZnNub3RpZnlfbWFya8KgwqDCoMKg
Km1hcms7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzZF9maWxlX21hcmvCoMKgwqAqbmZt
ID0gTlVMTCwgKm5ldzsNCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpbm9kZSAqaW5vZGUgPSBu
Zi0+bmZfaW5vZGU7DQo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBwZmxhZ3M7DQo+IMKg
DQo+IMKgwqDCoMKgwqDCoMKgwqBkbyB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgbXV0ZXhfbG9jaygmbmZzZF9maWxlX2Zzbm90aWZ5X2dyb3VwLT5tYXJrX211dGV4KTsNCj4g
QEAgLTE0OSw3ICsxNTAsMTAgQEAgbmZzZF9maWxlX21hcmtfZmluZF9vcl9jcmVhdGUoc3RydWN0
IG5mc2RfZmlsZQ0KPiAqbmYpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV3
LT5uZm1fbWFyay5tYXNrID0gRlNfQVRUUklCfEZTX0RFTEVURV9TRUxGOw0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZmNvdW50X3NldCgmbmV3LT5uZm1fcmVmLCAxKTsNCj4g
wqANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIGZzbm90aWZ5IGFsbG9jYXRl
cywgYXZvaWQgcmVjdXJzaW9uIGJhY2sgaW50byBuZnNkDQo+ICovDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBwZmxhZ3MgPSBtZW1hbGxvY19ub2ZzX3NhdmUoKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSBmc25vdGlmeV9hZGRfaW5vZGVfbWFyaygm
bmV3LT5uZm1fbWFyaywgaW5vZGUsDQo+IDApOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgbWVtYWxsb2Nfbm9mc19yZXN0b3JlKHBmbGFncyk7DQo+IMKgDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBJZiB0aGUgYWRkIHdhcyBzdWNjZXNzZnVsLCB0aGVuIHJldHVybiB0aGUgb2JqZWN0Lg0K
DQpJc24ndCB0aGF0IHN0YWNrIHRyYWNlIHNob3dpbmcgYSBzbGFiIGRpcmVjdCByZWNsYWltLCBh
bmQgbm90IGENCmZpbGVzeXN0ZW0gd3JpdGViYWNrIHNpdHVhdGlvbj8NCg0KRG9lcyBtZW1hbGxv
Y19ub2ZzX3NhdmUoKS9yZXN0b3JlKCkgcmVhbGx5IGZpeCB0aGlzIHByb2JsZW0/IEl0IHNlZW1z
DQp0byBtZSB0aGF0IGl0IGNhbm5vdCwgcGFydGljdWxhcmx5IHNpbmNlIGtuZnNkIGlzIG5vdCBh
IGZpbGVzeXN0ZW0sIGFuZA0Kc28gZG9lcyBub3QgZXZlciBoYW5kbGUgd3JpdGViYWNrIG9mIGRp
cnR5IHBhZ2VzLg0KDQpDYzogdGhlIGxpbnV4LW1tIG1haWxpbmcgbGlzdCBpbiBzZWFyY2ggb2Yg
YW5zd2VycyB0byB0aGUgYWJvdmUgMg0KcXVlc3Rpb25zLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
