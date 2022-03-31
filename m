Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB74EDC8A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 17:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiCaPSX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiCaPSW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 11:18:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2098.outbound.protection.outlook.com [40.107.244.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F5211ECF
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 08:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcssAcM9HuwVpvnd9XYVQyozPIskgZ1Jgdvn/EKfkTkA/1WXPg7/XRHqKx5MKsw8dkhlagT/LUOXOsDTM3jtR54tQ3zFRFyAd4McdOJGK6k6dRwHzlhxypaKGeh+nzg1P5QL7pC9B3n9f2q+x1TDAueJjxK80xiGyZ93cfgYt6SEkSGQKGSDasrvUqEswj7nc6G7PY1pLfiZeralbeHd3SKLrPkdKwaFqL6jMpOZgtoSeGV7bk8hIGqWKPGsUjFbOinauaLpJCtPOngbURYfcGSawrMe1wrDXken7HWUDGGHlIjQtugESUIV1dmbBExFkEKZz+ozNJ9dFjGCfQGuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjMTVTm8gGQ9DlTM/jlh98yhyRWQF625cFiX3d8IpdM=;
 b=ixVfcI4KAWPNgL9TnW0ghkqTDGcbhkUsq7m0WD9LOmlesJXUovELTrq0NJqLV1V3kuqyNM5JlmO0Higetp8xJRW6+K3fekIvPr489ATlPNnUGYVote2yWQZrUAQTOirHQIFL5KcuELXfTwb6hn86cDrm/FJuvK9DlAa1bTlOIPgoV8ItnksSazPVy5awEptLn5CpxcRs/3RN3y5TH0ijD7r9Wzwc1PXbT7s0itrmdcHBi0tu9IgJhIPRArcGUKBKzVL4hqG2BCK1wmg8pqem+Xlx6VFR3gbS+jpZ/bFPxaS1u24cVWGQnXnKe07MtEOilyHahIG6LEGuEn5WbZMpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjMTVTm8gGQ9DlTM/jlh98yhyRWQF625cFiX3d8IpdM=;
 b=PLErce89IMY76/Ju1kSKaG7pQevmrPoPoiBS0I6WRxkM57L0WOqbF7i+F2T6+W7yBJIIIWv53JP1uqY8ES05noergNbmkhyzLfCzXM/o/mAl73YEkL2tkPk/r2UaF8qG7QvUwXdo9bC3wEY9VAyJLWCdU3rB3aj4AAS6M5Qyvxc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4671.namprd13.prod.outlook.com (2603:10b6:5:3a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 15:16:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 15:16:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Chuck.Lever@oracle.com" <Chuck.Lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oREw==
Date:   Thu, 31 Mar 2022 15:16:31 +0000
Message-ID: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edc2d8b8-057a-4590-545f-08da13297014
x-ms-traffictypediagnostic: DS7PR13MB4671:EE_
x-microsoft-antispam-prvs: <DS7PR13MB4671503750640BC6A474B555B8E19@DS7PR13MB4671.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQIhv/VsUniEXYnD4SmcGqM31+a3w8X3so1t8fjdh1D60BCxblcHJB6OSlWpBw6yl4CKsDaRhiYcVqeZrKSgqgps5xndFUjTt1IsiCfm37BkEUpaEH5UmrN1CgnkeFnGVWXbALm23uzbr+bddC31X7GM3x8GZ8Wutc6WM0xb1J5J8eGE3VG6+7pJlv3QCIjs4ORZCNSllWaH3MemxSkqc91c8Klc7IY3ArbiNifvf+EK+wwOk6v9zFgP0GIJsF8IOSMUq7xx4faz5u4rgKAb/ACXr7t8GJET2vR2vIDK8XAZHkAGIvNE/t1m5ykkcMi0FYhDLaMYlHorn3KzuY3FQ/nBqBJfbL9wiDG3k3UJTXN2vjHudHkqm+Li8fzqsQOzgYmpVrvPizwKTUmQ8J77H3I/vVA32y2VHXUxBo34cSu1IgyFTTR6gVCactaIk1IjqfrAb54dbN+ExaDXiWuNdcyzLhe57vDuZx87Ga1C3mAFdhrfP68+xjj9T0arsQx+Yb1m6NQesCF3aN7bfmJE5Nf7BxEc42lxFNXZRBacntzlUDiEzQ+3pG2RKRjiqoEs6uFhdZWoQyXRvn85hfuwWH3/OHtqXRXS9pnorKjdk3jPJBZayRpt5VQX0lt5yHFkYsURun7D4FeV8S0MMB+YmuxoW4VBeCpKkQg71rZVqfY6F/HYIp6oy66hJ373u58cjNg65TscU5Zw78S9UlXbnKPy3Yg1vsQ9POB1pNZwf/ONgdQg6ei3hIbk9MrLmK46
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(2906002)(38100700002)(86362001)(8676002)(122000001)(508600001)(71200400001)(6486002)(45080400002)(6506007)(6512007)(4326008)(66446008)(5660300002)(66476007)(66556008)(66946007)(76116006)(6916009)(316002)(3480700007)(64756008)(2616005)(186003)(26005)(8936002)(83380400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE9YTUtkSnlmVUgwb1NNTlVYdW8zNHZKQkt1RzI4YUdqaDhJNUhyTlVKaVpa?=
 =?utf-8?B?MnRtcnlVd2pWd1E3OVQxYVRmOTY2N2h5ZVdSUkFnWUNsS3loVFFuNkVQZldC?=
 =?utf-8?B?eXF0RGlvdU9nUWE2UDBjZjFCUEU2WE9BY2ErUmVCS3M3M0RsZFoyMHFVZU00?=
 =?utf-8?B?MHhJRzZhZTJBOTNxemJrSnVrY2tHdW12bTBIREJkNEp5Nlcya3djTGNSRnFW?=
 =?utf-8?B?NmNtZUpSSUNsRUtpeVJuQTNrYUsrcHFiS3Irb0FxMGdGZFpPaEViUDZDRStx?=
 =?utf-8?B?bjNBdVZ0YTBYY1Rqb3pTY3RoQm9mVldpeTlBcUNtVGluTnpSUGJTbU90Sk9W?=
 =?utf-8?B?V25NNk82VjZjeXRDdnlxY1NMeUM1ZXcrM0xOWWdQUkpaa0U0eG5zS3R2VUV2?=
 =?utf-8?B?Z2dnZkFZZjJoODUzcGRkaG1EbkYrTXBZaURxUlpXSHVCQ3JWc0UySzVHczFR?=
 =?utf-8?B?TTFBMVR1b0NoaHJiNmVqWXlMOWdWbkgySXN2U3NOOVRsakJwZXl5ZG9CcGs2?=
 =?utf-8?B?V2l2MjB5dDh4UkU1T2xBeCtNbTVFR0w2NG9QeEVSNFBTdmFWTnBveW9wSmd3?=
 =?utf-8?B?YnY0bHdic3RlcDdMOHd4RXZFbzRFakhwT3ZrZHM5T2pZQm1SeW1HZEhMa0ti?=
 =?utf-8?B?bGpzcHcxd0NFVFFhL1MrS2dyRWFsemlMNG00Q0FnK1pUOE5lbkVMMlBIazZF?=
 =?utf-8?B?ZWxQalFYU3lsSy9OejBxZHdrMmRmbkpvTm5ITjNqcURVbk0rSWE3TjdocDhi?=
 =?utf-8?B?MUsyYkNnSHppeU1BbXpjeEpLaVN3Q2xVWWUwSHZvdkVyM0ZjdnRlUUxvbElr?=
 =?utf-8?B?NWwxMVNORHhFaEhVeE1YSk80VEUwaDVlM1dLMHhnanBGZC9odFNqczdqNGFo?=
 =?utf-8?B?Q09SMDhidmFRY1pOZGlJNlYzNTBSMDFERHRLNVpOcDdQQUxhdWFjSVRsR0hu?=
 =?utf-8?B?UFN1RUlXbzBlZHhYazE5UlJBR3lzMFNHMFptV1N1eDlJd3QvZHdQQTg1V2xH?=
 =?utf-8?B?SlMyZldZUHErb0wvU2Zvd1NhZkd0WTYxZnNuZm1EVXNuUzkrUjdpVWRHVVRO?=
 =?utf-8?B?UE5pOFY0eUQrdWZwamFCb2xqZlJVbjlzRCtOeCttbGxzZzU5RTFDb01KY2l4?=
 =?utf-8?B?cXdIcWNjanBDMkdtRDk4VmRYb3BMTDN5eGJveEthdVF4TGRjdWVpS2xGMHpQ?=
 =?utf-8?B?SWhyR0FSN2c1dEc5OUFndGozbHJ5Z216Mk9FRlc2YTV2eVMyNGZ2ZENnQ2Qz?=
 =?utf-8?B?QzAzdW0yWGZsamVhM1luSkhDdkNoVEdBUjF6WDl3NUVVMUpGaWdPMkUyNWFM?=
 =?utf-8?B?dWtOekNQUUUzcmFnbUs3WlJqSFF4RHlZMnpteDlqODhMelJWWGJwZnZ5Qi9C?=
 =?utf-8?B?Tk5lRFBuWEJ1L1NjRDc0djAzclhZc09KS2dabEU4ZjNQZ211aURYblozdG0x?=
 =?utf-8?B?a3NqRGt5dml0c1hPcS9zZTVtQ0p6QnJ4a1NBRlRYd1ZmODUvNURpeUpnb0Mz?=
 =?utf-8?B?V1dtY2t3R1doNCt6YmZSbHZBYjFPdS9oQ2VpWXpKWjgwYk05Y1g3ZDRwQ3FW?=
 =?utf-8?B?Z2szYVJHUVo0RXZJVkYzNmdlbms3WVZOdmVsMFVYZHRNSTVTZ1c2R1JmeFFs?=
 =?utf-8?B?OFhpdlZudmhHTk50by90TGM4RGlNNU9TamlXbzBweXpTZGFyUkNJSndDelZo?=
 =?utf-8?B?NUV1eXRBN1g2NjJMbGNPa01FQ3pQRnk0NGtnQnN3K3hLYk5mRWJSYXp5cjFi?=
 =?utf-8?B?NFBNSGFyS2w3bEk0blZWckc1UllNcVBpcDNTUG5sY1VEc2c4aUxiVVRQeFk2?=
 =?utf-8?B?c2ZGaC9HZFUwTVhzZUYyQlM3UDl6NHIzUUFoanNIdUJ4Ny8rb0ZLM1NpZnFW?=
 =?utf-8?B?YzVzMEJEaG5rdUNQNGliNEpSUDl1a3ovRDZLMTZEdGVndXdkM214KzYrS2l6?=
 =?utf-8?B?bjgwYkEzVTNiK2xjUkF0Vk1SWi9CM3Q3aVNDYmFXeUYrK2labVhla2ZSQ0Yx?=
 =?utf-8?B?VjE1SHdVcld4bXBYUGJzT28vN3BscUZ6V0NCU284Z0lBajJFMmpBVnYvSkJm?=
 =?utf-8?B?YnpBbTdNa3lKQ2NLRDlDVEtuUnI2Q0pSQVB4NXp6MXlLUlhQYUFwNU5BdHBz?=
 =?utf-8?B?WGE5NWpqbkVIL0pCU0pSaHRWZGtremhQU0dVTTFENDJVQmN5NmZmSThkMmN6?=
 =?utf-8?B?dmNpRDdKcGN5RGd1TUpJeHVpYVNlSll0ankwZytyNEFPdm1QVUJjQm50aExz?=
 =?utf-8?B?NXVXUy9wOWtlQjhmTmg3OXFSRDBvekNGK3RkQlR0bVpKQ1lBNHNOVFR5eVVL?=
 =?utf-8?B?bnpESTAwSkJaZUwrM0lNaU1CVHBRbDN1Q0Jpd1p3MU1Dc0tVcDdQdUlUbEVm?=
 =?utf-8?Q?f7UfMEJO1UnQ/RmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EF2A40D9036A14DA7853A7CF844DB38@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc2d8b8-057a-4590-545f-08da13297014
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 15:16:31.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs1GFAczDeDHHfThHgJHc63mZol/5yI3EeV+tHFl19RuCRAm/4P2w9B5UY5xM0K04y36z6UaLesX6N/nTYJDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4671
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgQ2h1Y2ssDQoNCg0KSSdtIHNlZWluZyBhIHZlcnkgd2VpcmQgc3RhY2sgdHJhY2Ugb24gb25l
IG9mIG91ciBzeXN0ZW1zOg0KDQpbODg0NjMuOTc0NjAzXSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwNTgNCls4ODQ2My45NzQ3Nzhd
ICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KWzg4NDYzLjk3NDkx
Nl0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlDQpbODg0NjMuOTc1
MDM3XSBQR0QgMCBQNEQgMA0KWzg4NDYzLjk3NTE2NF0gT29wczogMDAwMCBbIzFdIFNNUCBOT1BU
SQ0KWzg4NDYzLjk3NTI5Nl0gQ1BVOiA0IFBJRDogMTI1OTcgQ29tbTogbmZzZCBLZHVtcDogbG9h
ZGVkIE5vdCB0YWludGVkIDUuMTUuMzEtMjAwLnBkLjE3ODAyLmVsNy54ODZfNjQgIzENCls4ODQ2
My45NzU0NTJdIEhhcmR3YXJlIG5hbWU6IFZNd2FyZSwgSW5jLiBWTXdhcmUgVmlydHVhbCBQbGF0
Zm9ybS80NDBCWCBEZXNrdG9wIFJlZmVyZW5jZSBQbGF0Zm9ybSwgQklPUyA2LjAwIDEyLzEyLzIw
MTgNCls4ODQ2My45NzU2MzBdIFJJUDogMDAxMDpzdmNfcmRtYV9zZW5kdG8rMHgyNi8weDMzMCBb
cnBjcmRtYV0NCls4ODQ2My45NzU4MzFdIENvZGU6IDFmIDQ0IDAwIDAwIDBmIDFmIDQ0IDAwIDAw
IDQxIDU3IDQxIDU2IDQxIDU1IDQxIDU0IDU1IDUzIDQ4IDgzIGVjIDI4IDRjIDhiIDZmIDIwIDRj
IDhiIGE3IDkwIDAxIDAwIDAwIDQ4IDg5IDNjIDI0IDQ5IDhiIDQ1IDM4IDw0OT4gOGIgNWMgMjQg
NTggYTggNDAgMGYgODUgZjggMDEgMDAgMDAgNDkgOGIgNDUgMzggYTggMDQgMGYgODUgZWMNCls4
ODQ2My45NzYyNDddIFJTUDogMDAxODpmZmZmYWQ1NGMyMGIzZTgwIEVGTEFHUzogMDAwMTAyODIN
Cls4ODQ2My45NzY0NjldIFJBWDogMDAwMDAwMDAwMDAwNDExOSBSQlg6IGZmZmY5NDU1N2NjZDg0
MDAgUkNYOiBmZmZmOTQ1NWRhZjBjMDAwDQpbODg0NjMuOTc2NzA1XSBSRFg6IGZmZmY5NDU1ZGFm
MGMwMDAgUlNJOiBmZmZmOTQ1NWRhODYwMWE4IFJESTogZmZmZjk0NTVkYTg2MDAwMA0KWzg4NDYz
Ljk3Njk0Nl0gUkJQOiBmZmZmOTQ1NWRhODYwMDAwIFIwODogZmZmZjk0NTU4NmI2YjM4OCBSMDk6
IGZmZmY5NDU1ODZiNmIzODgNCls4ODQ2My45NzcxOTZdIFIxMDogN2YwZjFkYWMwMDAwMDAwMiBS
MTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQpbODg0NjMuOTc3NDQ5
XSBSMTM6IGZmZmY5NDU2NjMwODA4MDAgUjE0OiBmZmZmOTQ1NWRhODYwMDAwIFIxNTogZmZmZjk0
NTVkYWJiODAwMA0KWzg4NDYzLjk3NzcwOV0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdT
OmZmZmY5NDU4NmZkMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KWzg4NDYzLjk3
Nzk4Ml0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0K
Wzg4NDYzLjk3ODI1NF0gQ1IyOiAwMDAwMDAwMDAwMDAwMDU4IENSMzogMDAwMDAwMDFmOTI4MjAw
NiBDUjQ6IDAwMDAwMDAwMDAzNzA2ZTANCls4ODQ2My45Nzg1ODNdIERSMDogMDAwMDAwMDAwMDAw
MDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQpbODg0NjMu
OTc4ODY1XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzog
MDAwMDAwMDAwMDAwMDQwMA0KWzg4NDYzLjk3OTE0MV0gQ2FsbCBUcmFjZToNCls4ODQ2My45Nzk0
MTldICA8VEFTSz4NCls4ODQ2My45Nzk2OTNdICA/IHN2Y19wcm9jZXNzX2NvbW1vbisweGZhLzB4
NmEwIFtzdW5ycGNdDQpbODg0NjMuOTgwMDIxXSAgPyBzdmNfcmRtYV9jbWFfaGFuZGxlcisweDMw
LzB4MzAgW3JwY3JkbWFdDQpbODg0NjMuOTgwMzIwXSAgPyBzdmNfcmVjdisweDQ4YS8weDhjMCBb
c3VucnBjXQ0KWzg4NDYzLjk4MDY2Ml0gIHN2Y19zZW5kKzB4NDkvMHgxMjAgW3N1bnJwY10NCls4
ODQ2My45ODEwMDldICBuZnNkKzB4ZTgvMHgxNDAgW25mc2RdDQpbODg0NjMuOTgxMzQ2XSAgPyBu
ZnNkX3NodXRkb3duX3RocmVhZHMrMHg4MC8weDgwIFtuZnNkXQ0KWzg4NDYzLjk4MTY3NV0gIGt0
aHJlYWQrMHgxMjcvMHgxNTANCls4ODQ2My45ODE5ODFdICA/IHNldF9rdGhyZWFkX3N0cnVjdCsw
eDQwLzB4NDANCls4ODQ2My45ODIyODRdICByZXRfZnJvbV9mb3JrKzB4MjIvMHgzMA0KWzg4NDYz
Ljk4MjU4Nl0gIDwvVEFTSz4NCls4ODQ2My45ODI4ODZdIE1vZHVsZXMgbGlua2VkIGluOiBuZnN2
MyBicGZfcHJlbG9hZCB4dF9uYXQgdmV0aCBuZnNfbGF5b3V0X2ZsZXhmaWxlcyBhdXRoX25hbWUg
cnBjc2VjX2dzc19rcmI1IG5mc3Y0IGRuc19yZXNvbHZlciBuZnNpZG1hcCBuZnMgbmZzZCBhdXRo
X3JwY2dzcyBuZnNfYWNsIGxvY2tkIGdyYWNlIHh0X01BU1FVRVJBREUgbmZfY29ubnRyYWNrX25l
dGxpbmsgeHRfYWRkcnR5cGUgYnJfbmV0ZmlsdGVyIGJyaWRnZSBzdHAgbGxjIG92ZXJsYXkgbmZf
bmF0X2Z0cCBuZl9jb25udHJhY2tfbmV0Ymlvc19ucyBuZl9jb25udHJhY2tfYnJvYWRjYXN0IG5m
X2Nvbm50cmFja19mdHAgeHRfQ1QgeHRfc2N0cCBpcDZ0X3JwZmlsdGVyIGlwNnRfUkVKRUNUIG5m
X3JlamVjdF9pcHY2IGlwdF9SRUpFQ1QgbmZfcmVqZWN0X2lwdjQgeHRfY29ubnRyYWNrIGlwNnRh
YmxlX25hdCBpcDZ0YWJsZV9tYW5nbGUgaXA2dGFibGVfc2VjdXJpdHkgaXA2dGFibGVfcmF3IGlw
dGFibGVfbmF0IG5mX25hdCBpcHRhYmxlX21hbmdsZSBpcHRhYmxlX3NlY3VyaXR5IGlwdGFibGVf
cmF3IG5mX2Nvbm50cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdfaXB2NCBpcF9zZXQgbmZu
ZXRsaW5rIGlwNnRhYmxlX2ZpbHRlciBpcDZfdGFibGVzIGlwdGFibGVfZmlsdGVyIHZzb2NrX2xv
b3BiYWNrIHZtd192c29ja192aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbiB2bXdfdnNvY2tfdm1jaV90
cmFuc3BvcnQgdnNvY2sgYm9uZGluZyBpcG1pX21zZ2hhbmRsZXIgdmZhdCBmYXQgcnBjcmRtYSBz
dW5ycGMgcmRtYV91Y20gaWJfaXNlciBsaWJpc2NzaSBzY3NpX3RyYW5zcG9ydF9pc2NzaSBpYl91
bWFkIHJkbWFfY20gaXdfY20gaWJfaXBvaWIgaWJfY20gaW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFw
bF9jb21tb24gY3JjdDEwZGlmX3BjbG11bCBtbHg1X2liIGNyYzMyX3BjbG11bCBnaGFzaF9jbG11
bG5pX2ludGVsIHJhcGwgaWJfdXZlcmJzIGliX2NvcmUgdm13X3ZtY2kgaTJjX3BpaXg0DQpbODg0
NjMuOTgyOTMwXSAgZG1fbXVsdGlwYXRoIGlwX3RhYmxlcyB4ZnMgbWx4NV9jb3JlIGNyYzMyY19p
bnRlbCB0dG0gdm14bmV0MyB2bXdfcHZzY3NpIGRybV9rbXNfaGVscGVyIG1seGZ3IGNlYyBwY2lf
aHlwZXJ2X2ludGYgdGxzIGF0YV9nZW5lcmljIGRybSBwYXRhX2FjcGkgcHNhbXBsZQ0KDQpEZWNv
ZGluZyB0aGUgYWRkcmVzcyBzdmNfcmRtYV9zZW5kdG8rMHgyNiByZXNvbHZlcyB0byBsaW5lIDky
NyBpbg0KbmV0L3N1bnJwYy94cHJ0cmRtYS9zdmNfcmRtYV9zZW5kdG8uYw0KDQppLmUuDQoNCjky
NwkJX19iZTMyICpyZG1hX2FyZ3AgPSByY3R4dC0+cmNfcmVjdl9idWY7DQoNCndoaWNoIHNob3dz
IHRoYXQgc29tZWhvdywgd2UncmUgZ2V0dGluZyB0byBzdmNfcmRtYV9zZW5kdG8oKSB3aXRoIGEN
CnJlcXVlc3QgdGhhdCBoYXMgcnFzdHAtPnJxX3hwcnRfY3R4dCA9PSBOVUxMLg0KDQpJJ20gaGF2
aW5nIHRyb3VibGUgc2VlaW5nIGhvdyB0aGF0IGNhbiBoYXBwZW4sIGJ1dCB0aG91Z2h0IEknZCBh
c2sgaW4NCmNhc2UgeW91J3ZlIHNlZW4gc29tZXRoaW5nIHNpbWlsYXIuIEFGQUlDUywgdGhlIGNv
ZGUgaW4gdGhhdCBhcmVhIGhhcw0Kbm90IGNoYW5nZWQgc2luY2UgZWFybHkgMjAyMS4NCg0KQXMg
SSB1bmRlcnN0YW5kIGl0LCBrbmZzZCB3YXMgaW4gdGhlIHByb2Nlc3Mgb2Ygc2h1dHRpbmcgZG93
biBhdCB0aGUNCnRpbWUsIHNvIGl0IGlzIHBvc3NpYmxlIHRoZXJlIGlzIGEgY29ubmVjdGlvbiB0
byB0aGF0Li4uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
