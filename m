Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAD4D62C7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 15:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiCKOEA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 09:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbiCKOEA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 09:04:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2136.outbound.protection.outlook.com [40.107.236.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872156C09
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 06:02:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAeM7b2Jgw6wt7gGwUuAhYWoHHRld9+At62VDUbuUbLfh9ND4kkOLtSh5oF5Chldo+OSpcsvsKL04HAhmhGR7sNDlPd76ms/fC4DgsZAL3WayYDKwMYdvbasGCL2MQk6gEQOfiBZXrTw9GjF79bxl5Prh8gpBzfy7agPVJZ5afY+Qg/LLqO/DrJaTETCpDy3M5OgJFxTkSrpw1/0yKqMXlEW2fy1zo/0bKRxkqGkie44P8XEyyMlgtnWNK7VkG0rDt7939IGrbaM9dQRi0K5X+z7KAEyMvxMv5ekAoLNFl48HNFDhWljfaEKtQYTGHkGtbj2J9VGzmNQhewXoH+SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giLzJtA0+u9ZMHzlBvkIAMk+48q9O6ooCsgMOccBNCQ=;
 b=EzElttJflp3YFZwLSW2EeeoWfUL7kVXv7Jcqfb3yAT1fQvGeZUc41FHE6YlwTHvicx/zmDrHGiS2U7e9e4TbM8PHwApYSd3kL8GutOBjuy1NEhKWDMH4a1BaZRZWgwNof+mBaEJlmmv1sFIsIYSNbKl3oWeTCqP3aXFNdT60+g8QAahG+ys4IQw9H30kyGtqhcv06ftHD1tnWWArZYq42DLP3efPdcc2AQwny1siO9bWan89XHFrHtm6Sp5oJX8GC2P7yqETJ50pMFnE0Uy0CEGaSHHlnmSg4CvAaZ/YYjkB/GEK0pTct2g0GlB90kVdcvoQtPnaScSRo4BRszfFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giLzJtA0+u9ZMHzlBvkIAMk+48q9O6ooCsgMOccBNCQ=;
 b=NC3F8S9mKSda/YwImmLDUOs7ex6V7ZmyOJ7yijifdqsiBDP/gai0UsD+Y93f9z+lq6jecewgqlam9mTgWfg5cNp6RjtJ8bSGl68nOqKIWRIC0DYOCQN75FVcRwfRYR58RZoFLUop8sUb9tlFKImVI6+xs88Veo2ElanhsL/pXyk=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 PH7PR13MB5988.namprd13.prod.outlook.com (2603:10b6:510:15c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.16; Fri, 11 Mar 2022 14:02:49 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2133:d05a:fc92:53ce]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2133:d05a:fc92:53ce%6]) with mapi id 15.20.5061.018; Fri, 11 Mar 2022
 14:02:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Topic: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Index: AQHYLDBhnANoa08keUGsN4tf+cdAo6y3iKWAgAGkuYCAAPjQgIAAItCA
Date:   Fri, 11 Mar 2022 14:02:48 +0000
Message-ID: <28acdb3ed40b0ffd4c3ec320cc239f503ae74fcc.camel@hammerspace.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
         <20220227231227.9038-2-trondmy@kernel.org>
         <20220227231227.9038-3-trondmy@kernel.org>
         <20220227231227.9038-4-trondmy@kernel.org>
         <20220227231227.9038-5-trondmy@kernel.org>
         <20220227231227.9038-6-trondmy@kernel.org>
         <20220227231227.9038-7-trondmy@kernel.org>
         <20220227231227.9038-8-trondmy@kernel.org>
         <20220227231227.9038-9-trondmy@kernel.org>
         <20220227231227.9038-10-trondmy@kernel.org>
         <20220227231227.9038-11-trondmy@kernel.org>
         <20220227231227.9038-12-trondmy@kernel.org>
         <20220227231227.9038-13-trondmy@kernel.org>
         <20220227231227.9038-14-trondmy@kernel.org>
         <20220227231227.9038-15-trondmy@kernel.org>
         <20220227231227.9038-16-trondmy@kernel.org>
         <20220227231227.9038-17-trondmy@kernel.org>
         <20220227231227.9038-18-trondmy@kernel.org>
         <20220227231227.9038-19-trondmy@kernel.org>
         <20220227231227.9038-20-trondmy@kernel.org>
         <20220227231227.9038-21-trondmy@kernel.org>
         <20220227231227.9038-22-trondmy@kernel.org>
         <20220227231227.9038-23-trondmy@kernel.org>
         <20220227231227.9038-24-trondmy@kernel.org>
         <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
         <9099fead49c961a53027c8ed309a8efd2222d679.camel@hammerspace.com>
         <466F8F77-E052-4D06-A016-946FCBD9C9BF@redhat.com>
In-Reply-To: <466F8F77-E052-4D06-A016-946FCBD9C9BF@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5056af7-7e11-4d67-6daf-08da0367d365
x-ms-traffictypediagnostic: PH7PR13MB5988:EE_
x-microsoft-antispam-prvs: <PH7PR13MB5988971C003B331E38381FE3B80C9@PH7PR13MB5988.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLyLZNo6vYnmjizUuothG7EgBe/ondftYrDru1MhWfNXzwDPXt3u6u3bIcYCM23r5COIEqwtXBJ8bkNB6Bl24hANA7o5I/nzG/tCXmtO9bwq0yieoikx6ISEtj+AURgqEKhIm8ATQq9BmagwIuuxDlRgao4UFEL5VcSzLBfFy3Ow9zP67NUZP3wOPiQ+6PelKOp9J6bF+9R6nQY2j0txCSXtK9clsMwtvsTD/6Zg+d0dNUYpYAY98kBnXLXRtww21VJkQtAkMGHyq1TQjRADzrK1XAmRuoxY9sRgaXqYaNdV6prCCB1KgGZjLMapqifr+Xh7mwvEhnoey4TwYC4z9LmmiK47BnYQqlNensZStm8KHFKWHNpg4pi3/ZQhupnqHWf4nAgVHgbbmNd3EXe38qmX9Ekq3aQ+o73/FAornaT8pLNJw7/pkFoq/HODfDuvvmWtX0zkXGgt+lY02IVzKBukQOEKXoqRjYtkcZzmDMsT8HHY/F4ZS5k0RUEqAYOp1VsUgW8vVTe1LtkDmy44MhwWjFdv1vjx0M4qnjyn82St/aiDxhUbTMaul5So61XXlL/3MHzndhbrP5pKP1DkXqBWoz2b6YvAsQCS4ivP3CDMyjcqRQdNWPjZEvmxvz0lY0tfJRIpcaK/SqFYYyMDGTV6ixk/PQJEAjyE/S3UIUw4OpjWRq2H69ye89n2X1c958oNIwC/fza08+lRQVtieg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(4326008)(508600001)(76116006)(36756003)(5660300002)(2906002)(71200400001)(83380400001)(122000001)(53546011)(6486002)(6506007)(6916009)(6512007)(8936002)(38100700002)(316002)(64756008)(66446008)(26005)(66556008)(66476007)(186003)(2616005)(38070700005)(66946007)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW5TMENRV2wybXRBalU1QldnU1QzLzN0YWZvdDV4d3VoV0NPR0FQZW9uQisw?=
 =?utf-8?B?WUZDVmptWDNvV0FlWGRwZ0pnL21UcTZYN0pHTEhRbjVET3RVUmtKZ1V1MUhj?=
 =?utf-8?B?aUNUNXUxSVZmREI0TnNSalliVnhTdHQzcVVhUktvZVJGSFc5N2lVMDVCeHcr?=
 =?utf-8?B?a1FQV1NVcHJyUllWbmZMUFFWcVlMRGxkVnlEM2dCWnlKd0dQRVN4OE5VMkZZ?=
 =?utf-8?B?d0JTcGFkZkxvYXRMWnJxR2NoYVNMQ3dvQW1TdGdqRmRZUlFseUFRaWlhU0w2?=
 =?utf-8?B?bkl3MzdtOUhpR3B6eTlvK2xxYTNxZlVES3M1eFZ6NGUwMHFvb2pwc21BdjRV?=
 =?utf-8?B?NlZEcUVzN3ZQYkNGRFllNDk4RW5JMFJNKytkZThmU1NqN2VGa0lvbVQvSUxl?=
 =?utf-8?B?WGFyOUYzSzBpQWJpWXFuMVNpSllSZVN2aUZxSzVWcHM1dmh0cHJMdDN3MnVv?=
 =?utf-8?B?RjI5Q1VJYnlyWVdPbDhqanl2U3U1NGpKOTBVb0k5dG9TcWl1aXNQRlVCNEc3?=
 =?utf-8?B?RGQzV0hhTzdHRUlSeXg2bUpzZyt3emtNaWt6TlR1cUNsRUN5YzB3TjlBQ3BD?=
 =?utf-8?B?ZHRHWXBCc0kwRm1JZ3NLNC9kR2dKdlpSRGhVekg0OUFQRWl3OUpLanFTV2t6?=
 =?utf-8?B?YUVLbFljUE5kV0NRQ2QwbW5EeGJEay9uRHluZ05QN1AzeE1pU0xGcjV1eXln?=
 =?utf-8?B?NFJhTUsrRDFPbnlOTGxOVllLN0o4SFBvaW82dXd6MWFVaTM2ckViS1dtVXd1?=
 =?utf-8?B?OGM0NngvVHRRVEYybTRRQjVVRGdoeGtDZkJUWE9FMzEwSGQvN090OThrVlhW?=
 =?utf-8?B?dmUxUWVGMkVrWUxOSHlHOGl0blVkQzZsNnVIbzJEQ2xVYUxySlI4UmtUN2hG?=
 =?utf-8?B?Tk9zYlBUdFBKZ2hpTVcvWENKMUFBeG1VWkE4SzUwV3daMlYrYlZ6ZFU4ajdu?=
 =?utf-8?B?ejhlVXJIMVc2a2UrS2tVaFhUb0VTSHNaTmVMaEJWS2VGbXUvN0VGSEVUMWV6?=
 =?utf-8?B?aEN1dnRzY01UeVpIWWNQbWl1Vlo1T21TeThyS3JMT1k2MHdZU0I2R1MvK0M3?=
 =?utf-8?B?dVF2VG04eW05V0FCZDB1dDFEd1RtbnZSZUlqeUJYMHdoVi9ETjlFM2VqU0hn?=
 =?utf-8?B?MWp1WXY1QUNyODdIdmk3YWtaUEFRQ0h4aHNLQ0p6RXBBdUNZdEpkZE9DTXpW?=
 =?utf-8?B?MkxKSVBrZWtxUHVIQm9aV1hlb1VtUWtvMUZmbEZCdkpvaml5ZjdIdm1vQ25s?=
 =?utf-8?B?bnI4cGl1MFhhVUQxU2VaNWR0SDEvdnU4M05acnh2cW4wbnZvRzcySEZjbm1t?=
 =?utf-8?B?REZXNm9hUkM4N2V0WFZZM0ZSb2RyR2NXYWdvTWMyZGdGTFlJQjRyWGh6OWww?=
 =?utf-8?B?TmJKemtQU2owSVV5RlBqZklObmMrR3VPeXl2ekE3aktxb3d5M1FuZDRrOW8x?=
 =?utf-8?B?ZlBPRUk0TG4xM1ZVcng0ZjlEU00xMmRCbG5FMWRIcGZnbTNBZW1kSk5nK3JY?=
 =?utf-8?B?Wll1enp0ZXl0MUU1dEdma3hSLzVSN0lLbllmUElWc3pXOUVjcHhKZjhVSGhK?=
 =?utf-8?B?NFhHMU5rb09JUkJHWGdURVl6cGZLaWJqUmd2a3BzVTlROUk0ZjFWdFVMWTQ3?=
 =?utf-8?B?Ry9MNTJIQ2ZscHRDWS9nQlltbGJyc3ZzSEcxTjBSa1dLOTg5UUthMGRjVDRS?=
 =?utf-8?B?WjRxbjNTcjd3S0x5Q2hNQ0JJNGIyb2VnajlMOUF2bmgyR3pET0kxckgzOW0v?=
 =?utf-8?B?WU1ScXR6Y3poUGtOMnMvYkJLQzJvc3BITFAvS0NnOWltL1BBNDgzWTBCdGpR?=
 =?utf-8?B?aEViU01VSXlzNHVZRGdGcVZZRGcvZk43dVc2YkkrZlk0K1BTbVl3bXhQcVdk?=
 =?utf-8?B?Yk8rUmlIWEkvakpsSFUrU2pCaDNwS1U2b24vUVFtVjBlQi9RTkJLRU4wMTRm?=
 =?utf-8?B?R1VZdmFwS2lqMVZEYVpOTFdGOE12MzFIVGlHOFc3Zk5xWlQ1dUk3dTBXWFda?=
 =?utf-8?B?WDA0ekk5RlRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0904BEF56545D844A951F93F1DE53D04@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5056af7-7e11-4d67-6daf-08da0367d365
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 14:02:48.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EESSJrp/kWMIUaV+IKSEuoCZp2t1Efv738TC/aUqohLwkdO5Q4820E7IuW6qsalrpwpb2To2eY3X7ODYSQb9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTExIGF0IDA2OjU4IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxMCBNYXIgMjAyMiwgYXQgMTY6MDcsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gV2VkLCAyMDIyLTAzLTA5IGF0IDE1OjAxIC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMjcgRmViIDIwMjIsIGF0IDE4OjEyLCB0cm9uZG15QGtl
cm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IEluc3Rl
YWQgb2YgdXNpbmcgYSBsaW5lYXIgaW5kZXggdG8gYWRkcmVzcyB0aGUgcGFnZXMsIHVzZSB0aGUN
Cj4gPiA+ID4gY29va2llIG9mDQo+ID4gPiA+IHRoZSBmaXJzdCBlbnRyeSwgc2luY2UgdGhhdCBp
cyB3aGF0IHdlIHVzZSB0byBtYXRjaCB0aGUgcGFnZQ0KPiA+ID4gPiBhbnl3YXkuDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGlzIGFsbG93cyB1cyB0byBhdm9pZCByZS1yZWFkaW5nIHRoZSBlbnRpcmUg
Y2FjaGUgb24gYQ0KPiA+ID4gPiBzZWVrZGlyKCkNCj4gPiA+ID4gdHlwZQ0KPiA+ID4gPiBvZiBv
cGVyYXRpb24uIFRoZSBsYXR0ZXIgaXMgdmVyeSBjb21tb24gd2hlbiByZS1leHBvcnRpbmcgTkZT
LA0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gaXMgYQ0KPiA+ID4gPiBtYWpvciBwZXJmb3JtYW5jZSBk
cmFpbi4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBjaGFuZ2UgZG9lcyBhZmZlY3Qgb3VyIGR1cGxp
Y2F0ZSBjb29raWUgZGV0ZWN0aW9uLCBzaW5jZSB3ZQ0KPiA+ID4gPiBjYW4NCj4gPiA+ID4gbm8N
Cj4gPiA+ID4gbG9uZ2VyIHJlbHkgb24gdGhlIHBhZ2UgaW5kZXggYXMgYSBsaW5lYXIgb2Zmc2V0
IGZvciBkZXRlY3RpbmcNCj4gPiA+ID4gd2hldGhlcg0KPiA+ID4gPiB3ZSBsb29wZWQgYmFja3dh
cmRzLiBIb3dldmVyIHNpbmNlIHdlIG5vIGxvbmdlciBkbyBhIGxpbmVhcg0KPiA+ID4gPiBzZWFy
Y2gNCj4gPiA+ID4gdGhyb3VnaCBhbGwgdGhlIHBhZ2VzIG9uIGVhY2ggY2FsbCB0byBuZnNfcmVh
ZGRpcigpLCB0aGlzIGlzDQo+ID4gPiA+IGxlc3MNCj4gPiA+ID4gb2YgYQ0KPiA+ID4gPiBjb25j
ZXJuIHRoYW4gaXQgd2FzIHByZXZpb3VzbHkuDQo+ID4gPiA+IFRoZSBvdGhlciBkb3duc2lkZSBp
cyB0aGF0IGludmFsaWRhdGVfbWFwcGluZ19wYWdlcygpIG5vIGxvbmdlcg0KPiA+ID4gPiBjYW4N
Cj4gPiA+ID4gdXNlDQo+ID4gPiA+IHRoZSBwYWdlIGluZGV4IHRvIGF2b2lkIGNsZWFyaW5nIHBh
Z2VzIHRoYXQgaGF2ZSBiZWVuIHJlYWQuIEENCj4gPiA+ID4gc3Vic2VxdWVudA0KPiA+ID4gPiBw
YXRjaCB3aWxsIHJlc3RvcmUgdGhlIGZ1bmN0aW9uYWxpdHkgdGhpcyBwcm92aWRlcyB0byB0aGUg
J2xzIC0NCj4gPiA+ID4gbCcNCj4gPiA+ID4gaGV1cmlzdGljLg0KPiA+ID4gDQo+ID4gPiBJIGRp
ZG4ndCByZWFsaXplIHRoZSBhcHByb2FjaCB3YXMgdG8gYWxzbyBoYXNoIG91dCB0aGUgbGluZWFy
bHktDQo+ID4gPiBjYWNoZWQNCj4gPiA+IGVudHJpZXMuwqAgSSB0aG91Z2h0IHdlJ2QgZG8gc29t
ZXRoaW5nIGxpa2UgZmxhZyB0aGUgY29udGV4dCBmb3INCj4gPiA+IGhhc2hlZCBwYWdlDQo+ID4g
PiBpbmRleGVzIGFmdGVyIGEgc2Vla2RpciBldmVudCwgYW5kIGlmIHRoZXJlIGFyZSBjb2xsaXNp
b25zIHdpdGgNCj4gPiA+IHRoZQ0KPiA+ID4gbGluZWFyDQo+ID4gPiBlbnRyaWVzLCB0aGV5J2xs
IGdldCBmaXhlZCB1cCB3aGVuIGZvdW5kLg0KPiA+IA0KPiA+IFdoeT8gV2hhdCdzIHRoZSBwb2lu
dCBvZiB1c2luZyAyIG1vZGVscyB3aGVyZSAxIHdpbGwgZG8/DQo+IA0KPiBJIGRvbid0IHRoaW5r
IHRoZSBoYXNoZWQgbW9kZWwgaXMgcXVpdGUgYXMgc2ltcGxlIGFuZCBlZmZpY2llbnQNCj4gb3Zl
cmFsbCwgYW5kDQo+IG1heSBwcm9kdWNlIGltcGFjdHMgdG8gYSBzeXN0ZW0gYmV5b25kIE5GUy4N
Cj4gDQo+ID4gPiANCj4gPiA+IERvZXNuJ3QgdGhhdCBtZWFuIHRoYXQgd2l0aCB0aGlzIGFwcHJv
YWNoIHNlZWtkaXIoKSBvbmx5IGhpdHMgdGhlDQo+ID4gPiBzYW1lIHBhZ2VzDQo+ID4gPiB3aGVu
IHRoZSBlbnRyeSBvZmZzZXQgaXMgcGFnZS1hbGlnbmVkP8KgIFRoYXQncyAxIGluIDEyNyBvZGRz
Lg0KPiA+IA0KPiA+IFRoZSBwb2ludCBpcyBub3QgdG8gc3RvbXAgYWxsIG92ZXIgdGhlIHBhZ2Vz
IHRoYXQgY29udGFpbiBhbGlnbmVkDQo+ID4gZGF0YQ0KPiA+IHdoZW4gdGhlIGFwcGxpY2F0aW9u
IGRvZXMgY2FsbCBzZWVrZGlyKCkuDQo+ID4gDQo+ID4gSU9XOiB3ZSBhbHdheXMgb3B0aW1pc2Ug
Zm9yIHRoZSBjYXNlIHdoZXJlIHdlIGRvIGEgbGluZWFyIHJlYWQgb2YNCj4gPiB0aGUNCj4gPiBk
aXJlY3RvcnksIGJ1dCB3ZSBzdXBwb3J0IHJhbmRvbSBzZWVrZGlyKCkgKyByZWFkIHRvby4NCj4g
DQo+IEFuZCB0aGF0IGNvdWxkIGJlIGRvbmUganVzdCBieSBidW1waW5nIHRoZSBzZWVrZGlyIHVz
ZXJzIHRvIHNvbWUNCj4gY29uc3RhbnQNCj4gb2Zmc2V0IChpbmRleCAyNjIxNDQgPyksIG9yIHNv
bWV0aGluZyBlbHNlIGVxdWFsbHkgZGVhZC1udXRzIHNpbXBsZS7CoA0KPiBUaGF0DQo+IGtlZXBz
IHRpZ2h0bHkgY2x1c3RlcmVkIHBhZ2UgaW5kZXhlcywgc28gd2Fsa2luZyB0aGUgY2FjaGUgaXMN
Cj4gZmFzdGVyLsKgIFRoYXQNCj4gcmVkdWNlcyB0aGUgImJ1Y2tzaG90IiBlZmZlY3QgdGhlIGhh
c2hpbmcgaGFzIG9mIGVhdGluZyB1cCBwYWdlY2FjaGUNCj4gcGFnZXMNCj4gdGhleSdsbCBuZXZl
ciB1c2UgYWdhaW4uwqAgVGhhdCBkb2Vzbid0IGNhcCBvdXIgY2FjaGluZyBhYmlsaXR5IGF0IDMz
DQo+IG1pbGxpb24NCj4gZW50cmllcy4NCj4gDQoNCldoYXQgeW91IHNheSB3b3VsZCBtYWtlIHNl
bnNlIGlmIHJlYWRkaXIgY29va2llcyB0cnVseSB3ZXJlIG9mZnNldHMsDQpidXQgaW4gZ2VuZXJh
bCB0aGV5J3JlIG5vdC4gQ29va2llcyBhcmUgdW5zdHJ1Y3R1cmVkIGRhdGEsIGFuZCBzaG91bGQN
CmJlIHRyZWF0ZWQgYXMgdW5zdHJ1Y3R1cmVkIGRhdGEuDQoNCkxldCdzIHNheSBJIGRvIGNhY2hl
IG1vcmUgdGhhbiAzMyBtaWxsaW9uIGVudHJpZXMgYW5kIEkgaGF2ZSB0byBmaW5kIGENCmNvb2tp
ZS4gSSBoYXZlIHRvIGxpbmVhcmx5IHJlYWQgdGhyb3VnaCBhdCBsZWFzdCAxR0Igb2YgY2FjaGVk
IGRhdGENCmJlZm9yZSBJIGNhbiBnaXZlIHVwIGFuZCBzdGFydCBhIG5ldyByZWFkZGlyLiBFaXRo
ZXIgdGhhdCwgb3IgSSBuZWVkIHRvDQpoYXZlIGEgaGV1cmlzdGljIHRoYXQgdGVsbHMgbWUgd2hl
biB0byBzdG9wIHNlYXJjaGluZywgYW5kIHRoZW4gYW5vdGhlcg0KaGV1cmlzdGljIHRoYXQgdGVs
bHMgbWUgd2hlcmUgdG8gc3RvcmUgdGhlIGRhdGEgaW4gYSB3YXkgdGhhdCBkb2Vzbid0DQp0cmFz
aCB0aGUgcGFnZSBjYWNoZS4NCg0KV2l0aCB0aGUgaGFzaGluZywgSSBzZWVrIHRvIHRoZSBwYWdl
IG1hdGNoaW5nIHRoZSBoYXNoLCBhbmQgSSBlaXRoZXINCmltbWVkaWF0ZWx5IGZpbmQgd2hhdCBJ
IG5lZWQsIG9yIEkgaW1tZWRpYXRlbHkga25vdyB0byBzdGFydCBhIHJlYWRkaXIuDQpUaGVyZSBp
cyBubyBuZWVkIGZvciBhbnkgYWRkaXRpb25hbCBoZXVyaXN0aWMuDQoNCj4gSXRzIHdlaXJkIHRv
IG1lIHRoYXQgd2UncmUgZG9pbmcgZXhhY3RseSB3aGF0IFhBcnJheSBzYXlzIG5vdCB0byBkbywN
Cj4gaGFzaA0KPiB0aGUgaW5kZXgsIHdoZW4gd2UgZG9uJ3QgaGF2ZSB0by4NCj4gDQo+ID4gPiBJ
dCBhbHNvIG1lYW5zIHdlJ3JlIGFtcGxpZnlpbmcgdGhlIHBhZ2VjYWNoZSdzIHVzZWFnZSBmb3IN
Cj4gPiA+IHNsaWdodGx5DQo+ID4gPiBjaGFuZ2luZw0KPiA+ID4gZGlyZWN0b3JpZXMgLSByYXRo
ZXIgdGhhbiByZS11c2luZyB0aGUgc2FtZSBwYWdlcyB3ZSdyZQ0KPiA+ID4gc2NhdHRlcmluZw0K
PiA+ID4gb3VyIHVzYWdlDQo+ID4gPiBhY3Jvc3MgdGhlIGluZGV4LsKgIEVoLCBtYXliZSBub3Qg
YSBiaWcgZGVhbCBpZiB3ZSBqdXN0IGV4cGVjdCB0aGUNCj4gPiA+IHBhZ2UNCj4gPiA+IGNhY2hl
J3MgTFJVIHRvIGRvIHRoZSB3b3JrLg0KPiA+ID4gDQo+ID4gDQo+ID4gSSBkb24ndCB1bmRlcnN0
YW5kIHlvdXIgcG9pbnQgYWJvdXQgJ25vdCByZXVzaW5nJy4gSWYgdGhlIHVzZXINCj4gPiBzZWVr
cyB0bw0KPiA+IHRoZSBzYW1lIGNvb2tpZSwgd2UgcmV1c2UgdGhlIHBhZ2UuIEhvd2V2ZXIgSSBk
b24ndCBrbm93IGhvdyB5b3UNCj4gPiB3b3VsZA0KPiA+IGdvIGFib3V0IHNldHRpbmcgdXAgYSBz
Y2hlbWEgdGhhdCBhbGxvd3MgeW91IHRvIHNlZWsgdG8gYW4NCj4gPiBhcmJpdHJhcnkNCj4gPiBj
b29raWUgd2l0aG91dCBkb2luZyBhIGxpbmVhciBzZWFyY2guDQo+IA0KPiBTbyB3aGVuIEkgd2Fz
IHRha2luZyBhYm91dCAncmV1c2luZycgYSBwYWdlLCB0aGF0J3MgYWJvdXQgcmUtZmlsbGluZw0K
PiB0aGUNCj4gc2FtZSBwYWdlcyByYXRoZXIgdGhhbiBjb25zdGFudGx5IGNvbmp1cmluZyBuZXcg
b25lcywgd2hpY2ggcmVxdWlyZXMNCj4gbGVzcyBvZg0KPiB0aGUgcGFnZWNhY2hlJ3MgcmVzb3Vy
Y2VzIGluIHRvdGFsLsKgIE1heWJlIHRoZSBwYWdlY2FjaGUgY2FuIGhhbmRsZQ0KPiB0aGF0DQo+
IHdpdGhvdXQgaXQgbmVnYXRpdmVseSBpbXBhY3Rpbmcgb3RoZXIgdXNlcnMgb2YgdGhlIGNhY2hl
IHRoYXQgL3dpbGwvDQo+IHJlLXVzZQ0KPiB0aGVpciBjYWNoZWQgcGFnZXMsIGJ1dCBJIHdvcnJ5
IGl0IG1pZ2h0IGJlIGlycmVzcG9uc2libGUgb2YgdXMgdG8NCj4gZmlsbCB0aGUNCj4gcGFnZWNh
Y2hlIHdpdGggcGFnZXMgd2Uga25vdyB3ZSdyZSBuZXZlciBnb2luZyB0byBmaW5kIGFnYWluLg0K
PiANCg0KSW4gdGhlIGNhc2Ugd2hlcmUgdGhlIHByb2Nlc3NlcyBhcmUgcmVhZGluZyBsaW5lYXJs
eSB0aHJvdWdoIGENCmRpcmVjdG9yeSB0aGF0IGlzIG5vdCBjaGFuZ2luZyAob3IgYXQgbGVhc3Qg
d2hlcmUgdGhlIGJlZ2lubmluZyBvZiB0aGUNCmRpcmVjdG9yeSBpcyBub3QgY2hhbmdpbmcpLCB3
ZSB3aWxsIHJldXNlIHRoZSBjYWNoZWQgZGF0YSwgYmVjYXVzZSBqdXN0DQpsaWtlIGluIHRoZSBs
aW5lYXJseSBpbmRleGVkIGNhc2UsIGVhY2ggcHJvY2VzcyBlbmRzIHVwIHJlYWRpbmcgdGhlDQpl
eGFjdCBzYW1lIHNlcXVlbmNlIG9mIGNvb2tpZXMsIGFuZCBsb29raW5nIHVwIHRoZSBleGFjdCBz
YW1lIHNlcXVlbmNlDQpvZiBoYXNoZXMuDQoNClRoZSBzZXF1ZW5jZXMgc3RhcnQgdG8gZGl2ZXJn
ZSBvbmx5IGlmIHRoZXkgaGl0IGEgcGFydCBvZiB0aGUgZGlyZWN0b3J5DQp0aGF0IGlzIGJlaW5n
IG1vZGlmaWVkLiBBdCB0aGF0IHBvaW50LCB3ZSdyZSBnb2luZyB0byBiZSBpbnZhbGlkYXRpbmcN
CnBhZ2UgY2FjaGUgZW50cmllcyBhbnl3YXkgd2l0aCB0aGUgbGFzdCByZWFkZXIgYmVpbmcgbW9y
ZSBsaWtlbHkgdG8gYmUNCmZvbGxvd2luZyB0aGUgbmV3IHNlcXVlbmNlIG9mIGNvb2tpZXMuDQoN
ClRoZSBoYXNoZWQgaW5kZXhpbmcgZG9lcyBjb21lIHdpdGggYSBjb3N0LCB0aGFua3MgdG8gWEFy
cmF5IGJ1dCB0aGF0DQpjb3N0IGlzIGxpbWl0ZWQgdG8gYSBtYXggb2YgOE1CIHdpdGggdGhlIGN1
cnJlbnQgc2NoZW1lLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
