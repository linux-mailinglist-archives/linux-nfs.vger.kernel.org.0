Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1836B7A4019
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 06:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjIRElI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 00:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbjIRElE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 00:41:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D783F103
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 21:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDwJCiKMebjPT4QyqmffAuUv5Cxkv5678qza8L19PQhocIPRSGsPEQZ9yzKX/GZxlGvO9YL4P53r4luugVucprhcj9kt8KfMWHdcwc+XsSmstFfOswjmbxD82i/2rL0ltwgHM+/9cRLbhWpCPaAGg7wJKgXI6FdCvpkKKZRoeT4+TqvDw0rjDIJlorPkZWt3wPnFxChdPBhp7fNTvuY1rec3JulhUD8EnhGekP7vCA//iFk76TWaYlz8r2aX3B5mI2T6oTemv/7Tpq3M3tdtgD8mO4yyXJ8uoBQTu6sIKfupH+XTuIx6XeOJ98G4iXbeP8f1QefEsEYJxosR1cdfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCUl/r2SZhsDQkdXd7ZB56ACPUogApVh2jANARah1OA=;
 b=VZHUgznv4LtsZWvlr0TkOJfYvOBek8UhuQMUKpYq560KCp1zhDdI3mPauD0VTRdfyTjhTRWF0Wu8oCIDm+8CmJPt2cSbBnOmlzn4B5uaEGAnbeIyxOKAE/wNneT93qeXTbNLZK6Bl4fSwo/+Dii5ivgnDtFLa5SprP9jUCt9lkg9iuOCj63qVDqRR0FovYvKELRqWWv+NTsEnBpGZVm9bjrxFEAICfoy5QBMg51+HAgci8Sa9bTbJLiW+0iuhy+itZty6/N00D1OLY8uCtAaZDqvF+Akci95NYbqo8ysfZtey/1ODPKvrbFUPgM/n8qD2JLhG/ZHRQf15bfKtaRfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCUl/r2SZhsDQkdXd7ZB56ACPUogApVh2jANARah1OA=;
 b=WXWsp4wOSo0A+rXFM1OMOE2e33RTlC1Nleq6zN/xBZKu2xnAzJkr/AiR1HgU45bxBtL3ZcZaIlcTs8qIiYMKSweUSHtRZVrPxhCLM7489q4oSgY1y/uToPPnOUj6wcgcwnzGkYyIYy6kaN+wZaXe7A8jRYGiJS8J7Z/LymMZFvw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5494.namprd13.prod.outlook.com (2603:10b6:510:128::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 04:40:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6f5a:139d:2430:b061%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 04:40:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH] Revert "SUNRPC dont update timeout value on connection
 reset"
Thread-Topic: [PATCH] Revert "SUNRPC dont update timeout value on connection
 reset"
Thread-Index: AQHZ6b+Bh4mNMoEmyEy3qL72WSVsKrAf45sAgAAdgQA=
Date:   Mon, 18 Sep 2023 04:40:53 +0000
Message-ID: <aee5111422ac88916aa088a03cba8d758c211651.camel@hammerspace.com>
References: <20230917232646.30810-1-trondmy@kernel.org>
         <CAN-5tyFFNY30PzjAD58dweDYfLKS04NgkOryF93Pu22adbLr_w@mail.gmail.com>
In-Reply-To: <CAN-5tyFFNY30PzjAD58dweDYfLKS04NgkOryF93Pu22adbLr_w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5494:EE_
x-ms-office365-filtering-correlation-id: 3511b2b0-f847-43f7-93fe-08dbb8017127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDPD2JLqq0CBcIgAfqTT13APnmYV9LQ904b1sEhBxmj+VOXj3JilKurgrOiIykcK9nRIwRI0DFWQM36Ms70usbkBSNJoOp66JBumduNy5+G50ZvPkMl9F9syZqmAt8Uk6nPh8mdw8xVVfznog45tWdNa2aWRBn7wE/ItOe9T+kMIz2xGbcbMzZ/LSZtoZmBBiGpsBCYR3vtZazABouDU3lCIYLI/XauG2dOQnmvssB74NpHOnX5EIDGmR3ITdiiJ/f+DSi3seyng7vFXEQ+XSG9NBMJKLVpxQ2AwRKvWpurmQ2qpEGOVcog6E4GC4BkTRl570JIXIOCnrkH9SaRR0ACWA4xqHP9pI91OKtqIdZe2pwtD5Y6c0qe69u4fgoERxavLcsnR1oN1dsbChL4JAWcYdEBHhqBh1yU65tQYyzzzNbjggUzoVm0hT+3z3Hu8w2Mt0QYjBCfKTadrRX31yI9al8lgjbXyPNXZ8X8VLIaD+LvVICv7BGCf8ASQ5zlggEFM/9dvvFk84vduKxUYazq+QmqQ3Xb6C4S5na3nRG3sJPIw2ix27w/UmHWvc2Ps20bqWRD0RvC3hnOAQa7QEf7HeGdHQOn4SQWA9P8OWkAa6CrY2G9UZxpi8gznebWZWoeI39Zg7QPvhKmr+vxnUDD5smDKd3FvueFrTPRMjQVVMN4+85ICmU18jmqjJiEA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39830400003)(346002)(376002)(186009)(1800799009)(451199024)(83380400001)(6512007)(26005)(2616005)(6916009)(316002)(41300700001)(64756008)(54906003)(66946007)(66446008)(66476007)(66556008)(15650500001)(76116006)(5660300002)(8676002)(4326008)(8936002)(71200400001)(53546011)(6486002)(6506007)(2906002)(478600001)(86362001)(36756003)(122000001)(38070700005)(38100700002)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW9KRVZpb1h0aWpWbVNJMFZMUWxLdS92VmZraE9UUStaa1gvOFBkQ0xLTVMz?=
 =?utf-8?B?MTRUY1BRL0xpcGJhTGFDdTRrRzVURldocGRKQUloQk1oS3I3OExzOWNDL2M2?=
 =?utf-8?B?YkVnTWxtcGFUMDBtdjY3OTUySG5yUWdRWXJDSEg0SXlNNmkxWjdZSnBQVXlm?=
 =?utf-8?B?Sm5jS2d4L3FneWtDOW93QlEvOUVwbUlQZk1LRm1kTTNaYlpMam0xbE5Fc1BB?=
 =?utf-8?B?THFUTUw0Y1kvN3JHbDYrLzlwcGNoQmdlWkM3Y2UyZERiaGl2cnRUelJ5QnZI?=
 =?utf-8?B?bHAxUFVtY1lQMXk3SVdpMCtKZGFTN3ZVU3FoNm96K2RFY3JlZkd5amdRVkZ0?=
 =?utf-8?B?Q2o1TklrU1ptaDFMSHNEamJ3L2hoOWQ3enFtVFpjaUVGd3YwOGs0TDdUTWNj?=
 =?utf-8?B?SEFmeFh3QWxLYm9oWmVNa0FvREIwM2lXR0IxeVFUd3NGOXJRekRFY1Q2UE1U?=
 =?utf-8?B?WXlPbkp6dVlMemE2RVNqQjBpY0djNmlTV2pEcTIyUisyZWxTUi9KUkpVOE9B?=
 =?utf-8?B?OHBTWVE2eDY1dXNHNEFrSlR2RVJyWkRLYUp2Qk5iWjgrVkxQZElHWkhwdmVa?=
 =?utf-8?B?OHMyVU8xaUVSUFFiS1YvZXVTdTNoTWNVNkJrQXh3bTZONTdZa09qanJmZzhu?=
 =?utf-8?B?WDF1TTUya0hzc291M2Nkdzhzdzd6aTVKVkk2Rno0V2dXbloyYUc3QkhnQ0ha?=
 =?utf-8?B?Sm0rSWRBMUEzWVk5TUlqQTRmOVRCZnpwcUdMNDlRWkk0dHdnUG1CRDBld0tr?=
 =?utf-8?B?dktZQWZES2xxblFzTzNqdEtSeStBYWpScjRVQk5XSDd3eXFiKy9qS0g2NG5Y?=
 =?utf-8?B?VUh6OTBmNjQyQThzMmFzUlFsZ1gvaW5qMVNFWkdmNzZZaUprektWUE1GZ2N6?=
 =?utf-8?B?SWhjZ2VHV2sweTlqWFFBT0kyWVBZUDJSNmp5NU42UnZlNG8xYjRpVGUzUUFa?=
 =?utf-8?B?MGJDQUhUQ3Zzei84UEMxSnYvNkxNRkp0NFphS3p5MHB3QjE0dXE5ekw1NUdR?=
 =?utf-8?B?TzVGVEVEWllicXJpZU5iemwraCtWUFF2ejlET1V2Z0J0VXNaNVVqYkUxdmlB?=
 =?utf-8?B?VFlRVkJwalRXd1NpNnd1Y1UycGY3QUlVZG1UTnJkREg0bHVwMnRKNVB3QVBM?=
 =?utf-8?B?dldnb2IzUFpoZnA0TDlvVWRnMmdrT0psanBkdDh5V2x5V2FTRUhRakZ1OTJp?=
 =?utf-8?B?eEVXUnlCTXk3R2NxK0VkWlkvUlFRRE5NZ0FwZkd5SnVnbU40MVhWMFJuUC9Q?=
 =?utf-8?B?L1B1YlJyaUw1VUp3ZnFpWmpwZE5ZZnhuUEh0TFRJWVJaR3IrSENpdFBkaDlx?=
 =?utf-8?B?a3NvZGFRdDhwWXVyYzc2WHByc0Z4WEE0TmtCRXRPTFhUdGh1TGFMOVcwRmo2?=
 =?utf-8?B?UzlLUmZPWnpIenJPTkg0dWJrcVlBVXpMc2h0Sm1ZTW8veVJTcGZZcUFxb0xN?=
 =?utf-8?B?R1RYQkoyT0VpdEN2b1o3Y3FZcHZ0T1k3cUlQbDUwejRodFpEREU5aTM5dUFn?=
 =?utf-8?B?b1NCemlYMTBJQ2pkQS92aGlOQnRHSlBRS0ZlbnRsRXBqOVNYV0ZOMTdlUTJx?=
 =?utf-8?B?YzNtSWQzcWoyckQ4YUtzVExlZUo2T3hBbFk2d1FKWUllcTZqdzlSWmtjd3Iw?=
 =?utf-8?B?K1k1S1JaanBLVEF0eGJBV011N255eUpYU3E1K052WS9OSVpzb1dUdVQ3azFh?=
 =?utf-8?B?eE9PMGh2am9iWHZSd1VNcEtrN3owQi9VVUxKcUNYRC8vYVZUOGF2c3FyQVpK?=
 =?utf-8?B?MVp6a2JoZ0swa2MzMzVxdmxGZVBueGR3dTQxU29tdUg0N3FXSTNyTW53RUtq?=
 =?utf-8?B?dkV1M2hQS1k2UWMwakpZblJ6T0NVYVFmWm10enhQaFlRdFJqZWJWaTBnL0x1?=
 =?utf-8?B?WHFiN3B6VklHR2diNW9WWjhTdFJtQU5VTTdMbU5wMHRCbWphTXZUNmptQnhL?=
 =?utf-8?B?Um9RZjNYc0U3Qi9DcU41ZXlxYnlPTWl3M2ZyTGpXSUYzODg4TnA5NnVyNWdX?=
 =?utf-8?B?bEk4RjhZUVhzYUpHY1RvbmNQcFlhWURXaC85VlRxcDVVR3dscTVnOElGZ0F6?=
 =?utf-8?B?Rnd1amdnV21EWXFhdVpsWTV5MXJMZWlzU1J4L0FBZFQ5a1VxODVIVHpTczQz?=
 =?utf-8?B?L3pBaGVnN1k4ekJjL1B2Qy9EeXJhRXI5Tk5oak1YbmlZRk8ybnhhckh1cGtm?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EDEB9708480994AA03C288FDB84EA1B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3511b2b0-f847-43f7-93fe-08dbb8017127
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 04:40:53.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MTI3oQEohPUPzvExCxGndzWHm6kTr9OXcWGoqUdhydCfWubdFQ8pZ553B5L7TIiLeyQWnQpW0ALIU4b+VYTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIzLTA5LTE3IGF0IDIyOjU1IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gU3VuLCBTZXAgMTcsIDIwMjMgYXQgNzozOOKAr1BNIDx0cm9uZG15QGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiANCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IDg4NDI4
Y2M0YWU3YWJjYzg3OTI5NWZiYjE5MzczZGQ3NmFhZDJiZGQuDQo+ID4gDQo+ID4gVGhlIHByb2Js
ZW0gdGhpcyBjb21taXQgaXMgaW50ZW5kZWQgdG8gZml4IHdhcyBjb21wcmVoZW5zaXZlbHkNCj4g
PiBmaXhlZA0KPiA+IGluIGNvbW1pdCA3ZGU2MmJjMDlmZTYgKCJTVU5SUEMgZG9udCB1cGRhdGUg
dGltZW91dCB2YWx1ZSBvbg0KPiA+IGNvbm5lY3Rpb24NCj4gPiByZXNldCIpLg0KPiA+IFNpbmNl
IHRoZW4sIHRoaXMgY29tbWl0IGhhcyBiZWVuIHByZXZlbnRpbmcgdGhlIGNvcnJlY3QgdGltZW91
dCBvZg0KPiA+IHNvZnQNCj4gPiBtb3VudGVkIHJlcXVlc3RzLg0KPiANCj4gQW5kIGlmIHdlIHJl
dmVydCB0aGlzIGNvbW1pdCB0aGVuIHdlIGdldCBiYWNrIHRoZSBwcm9ibGVtIHRoYXQgd2hlbg0K
PiB0aGUgc2VydmVyIFJTVHMgdGhlIGNvbm5lY3Rpb24gYmV0d2VlbiB0aGUgdGltZW91dHMgdGhl
biB0aGUgY2xpZW50DQo+IHdhaXRzIGRvdWJsZSB0aGUgdGltZSAoaW5zdGVhZCBvZiB0aGUgY29y
cmVjdCB0aW1lKS4NCg0KTm8sIHdlIGRvbid0LiBUaGF0J3Mgd2hhdCBjb21taXQgN2RlNjJiYzA5
ZmU2IChtZW50aW9uZWQgYWJvdmUpIGZpeGVzLg0KDQo+IA0KPiA+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnwqAjIDUuOS54OiAwOTI1MjE3N2Q1Zjk6IFNVTlJQQzogSGFuZGxlDQo+ID4gbWFq
b3IgdGltZW91dCBpbiB4cHJ0X2FkanVzdF90aW1lb3V0KCkNCj4gPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZ8KgIyA1LjkueDogN2RlNjJiYzA5ZmU2OiBTVU5SUEMgZG9udA0KPiA+IHVwZGF0
ZSB0aW1lb3V0IHZhbHVlIG9uIGNvbm5lY3Rpb24NCj4gPiByZXNldA0KPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnwqAjIDUuOS54DQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVi
dXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKgbmV0
L3N1bnJwYy9jbG50LmMgfCAzICstLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2Ns
bnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+ID4gaW5kZXggNWE3ZGU3ZTU1NTQ4Li43ZjUzM2Mx
MDQxYTQgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3N1bnJwYy9jbG50LmMNCj4gPiArKysgYi9uZXQv
c3VucnBjL2NsbnQuYw0KPiA+IEBAIC0yNDc2LDggKzI0NzYsNyBAQCBjYWxsX3N0YXR1cyhzdHJ1
Y3QgcnBjX3Rhc2sgKnRhc2spDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gb3V0X2V4aXQ7DQo+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+IMKgwqDCoMKgwqDCoMKgIHRh
c2stPnRrX2FjdGlvbiA9IGNhbGxfZW5jb2RlOw0KPiA+IC3CoMKgwqDCoMKgwqAgaWYgKHN0YXR1
cyAhPSAtRUNPTk5SRVNFVCAmJiBzdGF0dXMgIT0gLUVDT05OQUJPUlRFRCkNCj4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBycGNfY2hlY2tfdGltZW91dCh0YXNrKTsNCj4gPiArwqDC
oMKgwqDCoMKgIHJwY19jaGVja190aW1lb3V0KHRhc2spOw0KPiA+IMKgwqDCoMKgwqDCoMKgIHJl
dHVybjsNCj4gPiDCoG91dF9leGl0Og0KPiA+IMKgwqDCoMKgwqDCoMKgIHJwY19jYWxsX3JwY2Vy
cm9yKHRhc2ssIHN0YXR1cyk7DQo+ID4gLS0NCj4gPiAyLjQxLjANCj4gPiANCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
