Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C54BC974
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiBSRAn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Feb 2022 12:00:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiBSRAn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Feb 2022 12:00:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2130.outbound.protection.outlook.com [40.107.102.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABC66AD2
        for <linux-nfs@vger.kernel.org>; Sat, 19 Feb 2022 09:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZbwTBfXwiEaRbNxcLD0ii1fwhUy5NePGHazzsXAwOZxnW85hDiFXMFu57eE0SmdiWQVvdTtu0+815sv//NANPquxSvfU6dGG3wCZSXjbMG2sq9i2HU2RtKX8ZCOCzSS3Dn5UXVserTHBErNQESHsPQvD9+p9Hr1MJYCOCDlUXoaMcVzzlWnHK5/iyjfSc3eaStDVttk4HdOaUVohcAvsmxZFgYzHTMz/bYzWv718leL0XCUWfnY0KPKs6ruJSbvnGuS329feaTBGW8X8/8cnizlpj2z/CTFuVyKvPQMH5/9G+/+ZlcQd2bh3kB8OEEEfyKyptTLO4P7iFcilUTqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEhHIEB2ZelyiobY6y3mGiDjGVCaoPmZnZLsGrqJCS4=;
 b=dw6GrKvvmwN8XDTa1CyD6p9SR5ngrpGm30UwRZ0gB1+2Asii4yzRLMakLmE3rLMrIxLV0kZO1m+uzie/r5gcDFPQLZMdyigi+287hMQN8ag25sL0jJqtqzPPy3Kb9iU11DBYEe9SgGxre5kNvKHlMsZ3Z0l8fPbs53IstMQFZHz+jG7OGSUNyWEYxvZ7fwWcvPYquDKMjzc5/PAMJUCr51lqHipkadpNNBTN9+kUncDnN8zoFLmOKOLfgZ2Ry0bOhrliNqBFdYrwb5LuoKf+2iKkdzrEijDEZFT3hB5wkFjqJgIOY7MyRpTynqDM0cA0SNxms9G7pdDh+oMg3xZPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEhHIEB2ZelyiobY6y3mGiDjGVCaoPmZnZLsGrqJCS4=;
 b=ftWhGQ1xt92c6AU4ESzdvUVIYtwyR3IQGfouDkk9jjSms7cks5lJuAxqEt4PtuS8aYItP11Ynqii7Anzzjz1wSNu18Hbav6ojIb5JyxcS7UJoCQ+/VH/3rbM1PS6iMCFSc8rgqg+sqsmGy0sMSEzj3+lecbaOV9LeQr2nshsCHg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3190.namprd13.prod.outlook.com (2603:10b6:a03:190::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.15; Sat, 19 Feb
 2022 17:00:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%8]) with mapi id 15.20.5017.016; Sat, 19 Feb 2022
 17:00:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "brauner@kernel.org" <brauner@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "l@damenly.su" <l@damenly.su>
Subject: Re: [bug?] nfs setgid inheritance
Thread-Topic: [bug?] nfs setgid inheritance
Thread-Index: AQHYJWjCc3uFudjLBEiBihXxNl6DhayavmkAgABbHIA=
Date:   Sat, 19 Feb 2022 17:00:18 +0000
Message-ID: <55aef6aa0e1825c1709051091c7bf849fccbda32.camel@hammerspace.com>
References: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
         <20220219113412.7ov4tbkisv4vnmo3@wittgenstein>
In-Reply-To: <20220219113412.7ov4tbkisv4vnmo3@wittgenstein>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 853c8d89-c60a-4929-5903-08d9f3c94f0b
x-ms-traffictypediagnostic: BY5PR13MB3190:EE_
x-microsoft-antispam-prvs: <BY5PR13MB3190483340C68F19FA60FE75B8389@BY5PR13MB3190.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oh5qrmuPgXup0c3HaR72OiQNyhSCDedBFA/INAi1ZEd45NaiHzys9R0u/tQU9OQcbBn+AvMK6k+K0KpGKP00hk7oG4Cvv5KJPja+8PvHes9Nk0CNrKspWPKzSIWCFsFjqIlC3AA4M+/3G2AivzawVHohnYSe3qIetlwGxW53Drdk7AzRXrfRKyuO9dILF7dIff7FjeC3dfS+s/f2E/j/r+umZfrU5xph9vfMb+6eI67y5sHIsiZlv24Uh375WZ/GcB2BuUXsnBjtJ5oFhBkg+O+wN8Pfdil0zWdL8X5vtKVHZRzOk0FgYCbmVRGj1KVlDPf3WWT17Gm5/QqRjRmIh2YYaeXkpRArzIztgUVHHpqw0xgFeqLlno9VzZfcU0BugWX1MMk8qjK5sVCSZn4DRf3eOvr2hN+GA9Xzvrnn/4OSf9maMf0JlapmUtMcumn995vKR0E3bPUl4rhoSSro7TbkqRFvl4av76qvrZTjqY32tul7qRsVYhq8LZEjyAKrGXwDY1LfxaWgnMlAFxTNaaWVCZGcoMYC53TCmv1LXo3BlPDUggy5CYEPKEYteVPEqMVnlCRBhIGrXPVc6TPKQHXTPGF3H+jEh+R7B2xvJP8ErIVGvyOLm28lp8u4zRzwzVHzDrrDFpD52lu+2mhrKo73vNwgVjp0JLpl1KldmxPB1INXSh5oUAmXRHX3cImnR5zjK4XxeYedYR7AH25OU6UkQB2znBGFHcn8blkfXUJsKulC0xsAGpV3V43Q1RUgBGUyPzXZpIPsOygfqKK9yWr8IVnM5o1mdQeIp8BjZrY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(6486002)(122000001)(86362001)(508600001)(66946007)(38100700002)(5660300002)(8676002)(316002)(6506007)(66446008)(66476007)(64756008)(66556008)(4326008)(6512007)(83380400001)(54906003)(8936002)(26005)(2616005)(38070700005)(110136005)(36756003)(76116006)(2906002)(186003)(218113003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3phKzc2MWhwZWZKWHFiVDlWZmZpOTdUa2k1WExQMk9GY09XaVJoNDdYZk5o?=
 =?utf-8?B?dm1Jb0FmcEwyN1FJRmFDK0FyQWlYWFNDRkMxc05uODBFVnNEL21aSTV3Zkhq?=
 =?utf-8?B?eGpwVTZsUlFxQ0VkOWNQaVhLZVF0YUlwS3NVTi9CNXpiOUVxUzJieHdzYm83?=
 =?utf-8?B?c284aHhwK0FNa1MxemEzQ2QwaEMyWFpWeHQvM0JjelBLLzI2NmJsUHB5SVBC?=
 =?utf-8?B?OVJmVlZPNVdMTEQzWFJabVd1ZW9TQlpXRHFsUVFiQjF2WkF0Ryt4aUUvK0lD?=
 =?utf-8?B?SkdsZUlrUkZxRlRlMkxWV2h6bmcwUTNpN2lZNjJNblJ3L2kyZStGTWluUzF0?=
 =?utf-8?B?bGRhaFBteTlKYm9mbEVLQTVndkxObWJOSFlodFo3V2xIdFFnSGxOSDJjWEt3?=
 =?utf-8?B?WTFvb0pmTU5yRlZzTHI2bHhVS3dpVS84Q2hUVmwrQUF5RVlGcytFVk1CS0FL?=
 =?utf-8?B?ZUkzZG05eDRKK2xDNzFUT0t4TFZGc0x6eUFlcXVXa0t0K2VjME5pSUxPanFy?=
 =?utf-8?B?cklEbHhkbDlJYTQ1REtlVjFibkhRM2dxWjk0eWVNd3Q0Q25XSitJU2wvZlpV?=
 =?utf-8?B?QlFvN0c0aTJ3Tnl4ZXE2RDBKcCtOampNbG1oL1o5SmI0ZlJZUkt0anllWGpS?=
 =?utf-8?B?WllTakprVFFVaWZINnNVaXRMZzhLK3p1dDQxaDJlU0dDRFdlTTZUM29PWFFk?=
 =?utf-8?B?T0J5U0dHRUpGZnUyenB4TDlITk5LOTdydkJkN0Rtb1JTZUZBTlJacFdTbWo2?=
 =?utf-8?B?alllRW43VDZtbGluSUs5MUh0cUlCNTF4Mk5mTW9QZjdrTHViNUVEU3JLb0Z5?=
 =?utf-8?B?NEhKMktIVkZPdk10SDh1NVljWFc3anl4c1JOa0FPZW5ZV2lvb3BidVcwTjls?=
 =?utf-8?B?ZndLbjR5UmpMRW1qeDFmY1RaNE8venJWZFBZRGlHcld0ZXBMNXY0TUdZV0k0?=
 =?utf-8?B?YTA1c2U5bmNCUjlONlhRaDl4K2NaT1FwYkRIVElxTkN6c2NnaExaUEd3Mk9Y?=
 =?utf-8?B?Ry85cGs2ZXFkUFhyUERVbzhjM1YyK01XMnhJWWtadkJtK2tqUFdLRURsR1Bt?=
 =?utf-8?B?TW9lem5JQUJyUkt6eC9RNHpQZVJPRi9Gd2ZGK0Flb1kzQUNsQkIyUzFYc1RG?=
 =?utf-8?B?N2R2UDdoVGE2SStHSUNidU9IbHFlSS9xalZidmdFdWozZWxtcDRiVHo3K0hr?=
 =?utf-8?B?aGtwNlhKTGoveDJsTElKeEtwWGVNNDhBMlp0RGNySDFoOGRMa2M2Rm5jQU4x?=
 =?utf-8?B?ZTAzdkRYeXR0SjNYb2VETENDMGU4bE12a0ZIdjFMMiszWEgrSGRjZEk2bTlC?=
 =?utf-8?B?WkM4czRqVHN2OEhhMG1TNEJZSlNkRXNveVFjTVRiNFlnRlYzeW1JNnhHVjJD?=
 =?utf-8?B?R0R2cEozTDF0WWc4WCswZ2EybStYY3h6THJYYmVhY1lidVIvZFFPTks2aDVY?=
 =?utf-8?B?T3AralpBZmFHSWhVY21ObUtlZ0F5WmJqSGQvU1BxdS9FMG5Scm5iQnFqdXFl?=
 =?utf-8?B?bGxLQWpRQ2ZLUzFZeWp4ODUwQy9zMnY3eVZickxZNGEwUHRLb1dUbmR6UER5?=
 =?utf-8?B?WlNhRmpOU2o3b2s4elpvZFZXZDlEelpYQ25LaWFwV1ZkTHVKS0thZEtvS3Jl?=
 =?utf-8?B?RHVkMHJVNThaZVhyNXhPYk54QkptZFlHazFxQm1QVE1OcitLdjBnMFFZeXQ2?=
 =?utf-8?B?RHNjRkdGMTBPaUQvaHBKYjRVVFRPOFRZU1hsd2l5eDhGRkV1V2I2VVhjZVUw?=
 =?utf-8?B?RitpOTMyQ2lXd043VGZkdlpYTE5jTmt2WUJtRzRlZ01xM1lUU24zYit5VnpQ?=
 =?utf-8?B?aEFoMDhMNC9BRnhTaFdDRWpXUWgya05ZVEVTa2tRWFRlWUU2ZWV5TitPWlBN?=
 =?utf-8?B?bW1ZcFpXQXo4MkZmeHY2c0JYVlVka1BrQUVtYW1JL3BOaENSbW5mamVKTW1M?=
 =?utf-8?B?TnoxaG9VVkNzcnpic3V5dlpBcHJFcE9EclJRMlFscmhXS2FxR1UzMmJORWFF?=
 =?utf-8?B?Q3hPZ1VQWTZmTnVGQ3BKY1FQcEpOQUFsQ2ljR2lqY2xpMk1oeEVsTVpsc1hq?=
 =?utf-8?B?NnNGbk1qY3RFYXk0a2JuNHZyVzdSZ2JnQlFPcExBeTYwZUdvZnc1T2ZobGZv?=
 =?utf-8?B?TGRuaSthelR4TitaR2dlYTI5akw2SW5uME93NVhrd25IaG56c2RNcnNweTBh?=
 =?utf-8?Q?S/e5T8frdaaWLnj16c5ahzo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B52973BF75BD9444B15168917D645500@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853c8d89-c60a-4929-5903-08d9f3c94f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 17:00:18.8818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7z0/cgLaPIkSApwP1VAe87CLKiPKaJ4ANXD5cfGzJGwicDnJcmJ3jdOCwjUDcHiMXnPAzEd9UvMpH3BCXW7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTAyLTE5IGF0IDEyOjM0ICswMTAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90
ZToNCj4gT24gU2F0LCBGZWIgMTksIDIwMjIgYXQgMDg6MzQ6MzBBTSArMDAwMCwgc3V5LmZuc3RA
ZnVqaXRzdS5jb23CoHdyb3RlOg0KPiA+IEhpIE5GUyBmb2xrcywNCj4gPiDCoCBEdXJpbmcgb3Vy
IHhmc3Rlc3RzLCB3ZSBmb3VuZCBnZW5lcmljLzYzMyBmYWlscyBsaWtlOg0KPiA+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gRlNUWVDCoMKgwqDCoMKg
wqDCoMKgIC0tIG5mcw0KPiA+IFBMQVRGT1JNwqDCoMKgwqDCoCAtLSBMaW51eC94ODZfNjQgYnRy
ZnMgNS4xNy4wLXJjNC1jdXN0b20gIzIzNiBTTVANCj4gPiBQUkVFTVBUIFNhdCBGZWIgMTkgMTU6
MDk6MDMgQ1NUIDIwMjINCj4gPiBNS0ZTX09QVElPTlPCoCAtLSAxMjcuMC4wLjE6L25mc3NjcmF0
Y2gNCj4gPiBNT1VOVF9PUFRJT05TIC0tIC1vIHZlcnM9NCAxMjcuMC4wLjE6L25mc3NjcmF0Y2gg
L21udC9zY3JhdGNoDQo+ID4gDQo+ID4gZ2VuZXJpYy82MzMgMHMgLi4uIFtmYWlsZWQsIGV4aXQg
c3RhdHVzIDFdLSBvdXRwdXQgbWlzbWF0Y2ggKHNlZQ0KPiA+IC9yb290L3hmc3Rlc3RzLWRldi9y
ZXN1bHRzLy9nZW5lcmljLzYzMy5vdXQuYmFkKQ0KPiA+IMKgwqDCoCAtLS0gdGVzdHMvZ2VuZXJp
Yy82MzMub3V0wqDCoCAyMDIxLTA1LTIzIDE0OjAzOjA4Ljg3OTk5OTk5NyArMDgwMA0KPiA+IMKg
wqDCoCArKysgL3Jvb3QveGZzdGVzdHMtZGV2L3Jlc3VsdHMvL2dlbmVyaWMvNjMzLm91dC5iYWQg
MjAyMi0wMi0xOQ0KPiA+IDE2OjMxOjI4LjY2MDAwMDAxMyArMDgwMA0KPiA+IMKgwqDCoCBAQCAt
MSwyICsxLDQgQEANCj4gPiDCoMKgwqDCoCBRQSBvdXRwdXQgY3JlYXRlZCBieSA2MzMNCj4gPiDC
oMKgwqDCoCBTaWxlbmNlIGlzIGdvbGRlbg0KPiA+IMKgwqDCoCAraWRtYXBwZWQtbW91bnRzLmM6
IDc5MDY6IHNldGdpZF9jcmVhdGUgLSBTdWNjZXNzIC0gZmFpbHVyZToNCj4gPiBpc19zZXRnaWQN
Cj4gPiDCoMKgwqAgK2lkbWFwcGVkLW1vdW50cy5jOiAxMzkwNzogcnVuX3Rlc3QgLSBTdWNjZXNz
IC0gZmFpbHVyZTogY3JlYXRlDQo+ID4gb3BlcmF0aW9ucyBpbiBkaXJlY3RvcmllcyB3aXRoIHNl
dGdpZCBiaXQgc2V0DQo+ID4gwqDCoMKgIC4uLg0KPiA+IMKgwqDCoCAoUnVuICdkaWZmIC11IC9y
b290L3hmc3Rlc3RzLWRldi90ZXN0cy9nZW5lcmljLzYzMy5vdXQNCj4gPiAvcm9vdC94ZnN0ZXN0
cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy82MzMub3V0LmJhZCfCoCB0byBzZWUgdGhlIGVudGlyZQ0K
PiA+IGRpZmYpDQo+ID4gUmFuOiBnZW5lcmljLzYzMw0KPiA+IEZhaWx1cmVzOiBnZW5lcmljLzYz
Mw0KPiA+IEZhaWxlZCAxIG9mIDEgdGVzdHMNCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiA+IA0KPiA+IFRoZSBmYWlsZWQgdGVzdCBpcyBhYm91dCBz
ZXRnaWQgaW5oZXJpdGFuY2UuIA0KPiA+IFdoZW7CoCBhIGZpbGUgaXMgY3JlYXRlZCB3aXRoIFNf
SVNHSUQgaW4gdGhlIGRpcmVjdG9yeSB3aXRoIFNfSVNHSUQsDQo+ID4gTkZTwqAgZG9lc24ndCBz
dHJpcCB0aGXCoCBzZXRnaWQgYml0IG9mIHRoZSBuZXcgY3JlYXRlZCBmaWxlIGJ1dA0KPiA+IG90
aGVycw0KPiA+IChleHQ0L3hmcy9idHJmcykgZG8uwqAgVGhleSBjYWxsIGlub2RlX2luaXRfb3du
ZXIoKSB3aGljaCBkb2VzDQo+ID4gdGhlIHN0cmlwIGFmdGVyIG5ld19pbm9kZSgpLg0KPiA+IEhv
d2V2ZXIsIE5GUyBoYXMgaXRzIG93biBsb2dpY2FsIHRvIGhhbmRsZSBpbm9kZSBjYXBhY2l0aWVz
LiANCj4gPiBBcyB0aGUgdGVzdCBzYXlzIHRoZSBiZWhhdmlvciBjYW4gYmUgZmlsZXN5c3RlbSB0
eXBlIHNwZWNpZmljLA0KPiA+IEknZCByZXBvcnQgdG8geW91IE5GUyBndXlzIGFuZCBhc2sgd2hl
dGhlciBpdCdzIGEgYnVnIG9yIG5vdD8NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gSSdt
IG5vdCBzdXJlIHdoeSBORlMgd291bGQgaGF2ZSBkaWZmZXJlbnQNCj4gcnVsZXMNCj4gZm9yIHNl
dGdpZCBpbmhlcml0YW5jZS4gU28gSSdtIGluY2xpbmVkIHRvIHRoaW5rIHRoYXQgdGhpcyBpcyBz
aW1wbHkNCj4gYQ0KPiBidWcgc2ltaWxhciB0byB3aGF0IHdlIHNhdyBpbiB4ZnMgYW5kIGNlcGgu
IEJ1dCBJJ2xsIGxldCB0aGUgTkZTDQo+IGZvbGtzDQo+IGRldGVybWluZSB0aGF0Lg0KPiANCj4g
WEZTIGlzIG9ubHkgc3BlY2lhbCBpbiBzbyBmYXIgYXMgaXQgaGFzIGEgc3lzY3RsIHRoYXQgbGV0
cyBpdCBhbHRlcg0KPiBzZ2lkDQo+IGluaGVyaXRhbmNlIGJlaGF2aW9yLiBBbmQgaXQgb25seSBo
YXMgdGhhdCB0byBhbGxvdyBmb3IgbGVnYWN5IGlyaXgNCj4gc2VtYW50aWNzIGlpdWMuDQoNCk9L
LCBzbyBob3cgZG8geW91IGV4cGVjdCB0aGlzICdpZG1hcHBlZC1tb3VudHMnIGZ1bmN0aW9uYWxp
dHkgdG8gd29yaw0Kb24gTkZTPyBJJ20gbm90IGFza2luZyBhYm91dCB0aGlzIGJ1ZyBpbiBwYXJ0
aWN1bGFyLiBJJ20gYXNraW5nIGFib3V0DQp3aGF0IHRoaXMgaXMgc3VwcG9zZWQgdG8gZG8gaW4g
Z2VuZXJhbC4NCg0KQXQgYSBxdWljayBnbGFuY2UsIGl0IGxvb2tzIHRvIG1lIGFzIGlmIHRoZXNl
IGlkbWFwcGVkIG1vdW50IGhlbHBlcnMNCmFyZSBqdXN0IGhhY2tpbmcgZGlmZmVyZW50IHZhbHVl
cyBpbnRvIHRoZSBpbm9kZSBjYWNoZSByZXByZXNlbnRhdGlvbg0Kb2YgZmlsZXMsIGFuZCB0aGVu
IHNvbWVob3cgZXhwZWN0aW5nIHRoYXQgdG8gcmVzdWx0IGluIGRpZmZlcmVudA0KYmVoYXZpb3Vy
Lg0KVGhhdCdzIG5vdCBnb2luZyB0byB3b3JrIHdpdGggTkZTLCBmb3IgdHdvIHJlYXNvbnM6DQog
ICAxLiBTZWN1cml0eSBpcyBlbmZvcmNlZCBieSB0aGUgc2VydmVyIGFuZCBub3QgdGhlIGNsaWVu
dC4gSWYgeW91DQogICAgICB3YW50IHRoZXNlIHZhbHVlcyB5b3UncmUgcG9raW5nIGludG8gdGhl
IGlub2RlIGNhY2hlIHRvIGNoYW5nZQ0KICAgICAgdGhlIGJlaGF2aW91ciBvZiB0aGUgc2VydmVy
LCB0aGVuIHRoZXkgaGF2ZSB0byBiZSBwcm9wYWdhdGVkIGJ5DQogICAgICB0aGUgY2xpZW50IHRv
IHRoYXQgc2VydmVyLiANCiAgIDIuIFRoZSBORlMgc2VjdXJpdHkgbW9kZWwgaXMgYXV0aGVudGlj
YXRpb24gYmFzZWQuIEluIHBhcnRpY3VsYXIsDQogICAgICB3aGVuIHN0cm9uZyBhdXRoZW50aWNh
dGlvbiBpcyBiZWluZyB1c2VkLCB0aGVuIG15IGlkZW50aXR5IGlzDQogICAgICBlc3RhYmxpc2hl
ZCBieSB1c2VyK3Bhc3N3b3JkIHRoYXQgSSd2ZSBsb2dnZWQgaW4gYXMgdG8gdGhlDQogICAgICBr
ZXJiZXJvcyBzZXJ2ZXIgKG9yIHdoYXRldmVyKS4gU28gd2hpbGUgdGhlIGlkbWFwcGVkIG1vdW50
IHN0dWZmDQogICAgICBtYXkgYmUgcG9raW5nIHZhbHVlcyBpbnRvIG15IGNyZWRlbnRpYWwgb3Ig
dGhlIGlub2RlIGNhY2hlLCB0aGUNCiAgICAgIHNlcnZlciBpcyBnb2luZyB0byBpZ25vcmUgYWxs
IHRoYXQgYW5kIHRlbGwgbWUgdGhhdCBhbnkgZmlsZSBJDQogICAgICBjcmVhdGUgaXMgb3duZWQg
YnkgdXNlciB0cm9uZEBkb21haW4uIEl0IHdpbGwgbm90IGFsbG93IG1lIHRvDQogICAgICBjaGFu
Z2UgZmlsZSBvd25lcnNoaXAgb3IgdG8gb3ZlcnJpZGUgYWNjZXNzIHBlcm1pc3Npb25zIHVubGVz
cw0KICAgICAgdHJvbmRAZG9tYWluwqBoYXBwZW5zIHRvIGJlIGEgcHJpdmlsZWdlZCB1c2VyIHN1
Y2ggYXMgcm9vdC4NCg0KSSdtIHByZXR0eSBzdXJlIHRoZSBjaWZzL3NtYiBjbGllbnQgd2lsbCBo
YXZlIHRoZSBzYW1lIHByb2JsZW0uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0IExpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg==
