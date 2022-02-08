Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD04ADD3A
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377417AbiBHPoF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 10:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiBHPoE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 10:44:04 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2100.outbound.protection.outlook.com [40.107.223.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E40C061576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 07:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9ZYoSRE++D4+vy+P9hOapY6xdGj+Axz+ZJL8FyNQXxjx/TP6N8+KawmcE3LC2mU5aqUo0AMk2FsWbB0LoLa7SYBDiQ9Q/OSn3d4tgc7qxbVKcs8D3eE9BjCkUbZk9dxYbMwdZZLhwtYPiWXDHDSab27VN2yPuVsTIQ1ZFWbroFYCkK+85CeymZ0vXf5xIyTjlYHVNIc5oH4i7M+hJNWY2p+nFRzi8JvLeooWRFAo3o1kiALjAynhySQHMCggw1pmuBsWcsDKxyMgd3DiXxGpPA2kmUD8ZTykmnVrl/jv+5laZV0a8Cp5qVHu1Bv8NBLPgLDyGYB6klLolgRvNFytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUv16XHkv0N4USkL7WlUYzubujH7XYR4O2G+4eJ0bQ4=;
 b=LmXZUO1B5Ffmub4+pyCBDEz6kKY0YGcrFxU1JbRKikygbKzXfx7hG7irYrThtRd19rDmxNsmEyTq6diT4Vtm6RUVC0vxectewRP7nCrTPgIfrCUmATeslzsk5W8rTBgJxQ+fZLZgRCIbEOOETlerGJhxBwKoCntmZYcN575tItaI1jO0OfgupmNtHG5NCgFSwEFMRd0nXjnFejN0QZJDQkJfJ5tGKStegCNbT3qnisV/q6s6pZBRaxcNEpEK8Y6Txil3IA5cHGRDuOWEo+s9ewh8S3UhqzVytvm6TNulKV5bl7pK/SQjZwAJGubwBUsm+Y2cZ+y6ijie4hzxQ2S4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUv16XHkv0N4USkL7WlUYzubujH7XYR4O2G+4eJ0bQ4=;
 b=gmBvJarsvaHOCWBTSl46NkF6iAsU4LM8PeN0borR1F+9lj9GcZ5fh9jtlMGjRWcrVil0aTFaM8yN0GJDL2DDABDd4MJbstzorIocdQvU1+ijKjS6oCaZsNPwF+GXGYSmLC7wUKeCNywuan8hXG22aH3FI+084L7chMgaC+7Dprw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB4110.namprd13.prod.outlook.com (2603:10b6:806:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8; Tue, 8 Feb
 2022 15:44:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 15:44:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGY+wEK6KvlxECYW5WP2WwW2KyFReGAgAAYO4CAAsQQAIAAHRgAgAA//4CAAEjXgIAAwaaAgAAlW4CAAAwngIAAA42AgAALioCAAAXCAA==
Date:   Tue, 8 Feb 2022 15:43:59 +0000
Message-ID: <50d04869ff78e2f59b78804f100f9127e3352496.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
         <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
         <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
         <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
         <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
         <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
         <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
         <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
         <c9948f895e91abb76a21609bf629b88bbfcf4d9a.camel@hammerspace.com>
         <CEC36879-0474-44A1-984B-BAE69C168274@redhat.com>
         <6211BF2A-2A00-4E00-8647-57D829D41E8D@oracle.com>
         <6AB99AB0-A9A5-4000-BABD-8EFC34FC31D5@redhat.com>
In-Reply-To: <6AB99AB0-A9A5-4000-BABD-8EFC34FC31D5@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43044578-3617-464c-55f6-08d9eb19d34c
x-ms-traffictypediagnostic: SA0PR13MB4110:EE_
x-microsoft-antispam-prvs: <SA0PR13MB4110A400A9808F2B618F4192B82D9@SA0PR13MB4110.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sen9xpsiE7Zov+HuZ14yvPkERmCi5GKnLr2buovOV3EC2FZXW5qWXHRTtT3hf7YRMUw+fBj6egLC2rMfGbLZNahI8brEz64Isb26pFMuY3IVndbJPN4bt7pexW9/OBsQgdMhxLGK+3ZDS8pL/kV+O1/HbY/vI/tnpdnwCRRVWdFsX5hJey7tz9JzQi/s1ZNkuUutZ4N0v2V8NwQWreIB3exa63kXLEdITGqJFRNGy88AQpQyDBN1mIF6xwLsniO6Ea5A8Zv6bOoWiSwqwykcFjZGc3Ah5dJWao5m9EsGUYUG529LbW/AxJXi3PrW8H2ecOYayUwx/GvppKqgwWE+e8ECfYkvDYQ2o3ScfwJ9X60MzlJnedyOh3lqirxijJHUwKuWE9SRXPP6cyqWxD6/lTPV6eYT3SE1QQ1JypyGonYD7+m23Z+W8b5ilswVPHQfL7sGJ0aUoxaPBXNQMAo/wqC0l0ONbzmXF2HHLGOjrwAdJP4m7pOYEtmWcCm6B2cG66qkICcLuDeX4IPG0qI0PmZnhoEyMalSQDivRZ3zvScUx6M4zsj5Rs7JIaOGlF89O7NkIgS5oehuZPidhDverLLUXEuZn0U3nafGMJoVrU0TRtRJvCnHQOEoJxz+Ogc/XLKdst5QDxzluwNp0ctJQ4RLLUMQp0Focmse7UITtrw6gWyMEl564qgCc30MrACJvfxlIxi8fnVkKP6YvLBBaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(38070700005)(6486002)(71200400001)(76116006)(66946007)(316002)(508600001)(2616005)(4326008)(66476007)(66446008)(64756008)(8676002)(66556008)(110136005)(8936002)(38100700002)(36756003)(86362001)(122000001)(53546011)(26005)(5660300002)(2906002)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnFjTVJFSGNpbjVoblpnWTh6Zk42SE5KTkJ4V2VCSGtwNlJTenFCRlNsSUhX?=
 =?utf-8?B?cWNBM0RVYS9ZYVBPSlBPZ2NnNXFySElLelFzbm5PV24vWUwzMEZsK2g3NVJY?=
 =?utf-8?B?eG5BeHJwUGxzT2xneFdnWjRRdHpxU0NwMndXTW43U0VGRUNxQ2gyWUxjRXNq?=
 =?utf-8?B?bld4cEZKN3VHWWZKLzE2aURFeEhUZmdVeFI5cXFSVzV0MHRkQUFscHB4ZXpE?=
 =?utf-8?B?SUJzTlloU0RJTGlMTloxSGZOTzFxMkxKc0YrbXhQaEg1bU5sNjFTOUNvdjhG?=
 =?utf-8?B?dVFveFEyNk9kTTRkOUdmQk5IaHBTdk9SVnJEWmRhalNwdnhCWkxMeW5zendT?=
 =?utf-8?B?SWZaaU9rTlMwb3dpWVJyZjl4UzlaTEFhVzNweENnbjRibTJzc3pnWVlIaUJw?=
 =?utf-8?B?Y25qYXZOdHJvK0JDTkpjWDFxY21PVU9CTWFQV2kvT2ROeVQvQW4rZmVRR0xv?=
 =?utf-8?B?bTlDTVRWYk5PMVFpKy80ekJ2K2p3T2VLZUZJK2Q4RFVaSWhLTENHMCs4VXJB?=
 =?utf-8?B?SkZEcXRoYmhNMVVONE9tUE0xMFNDYk1UbGExb08vY2p0bGFVd0duU3YycGN6?=
 =?utf-8?B?WmNlallyM3UzWFoyR2M4djdxelorRkdVcVVlbmxqbEZhZDFTOStvdDR0SVpv?=
 =?utf-8?B?WE9NeFMvK1hpT1hKTy9pV2lOQnltTzJhOEdoL3V3UXVGcEhJRHZvNC9HbU9w?=
 =?utf-8?B?Zk53M2FVYnhxWE5ZRlUvR1FJSjVCRnNXOTZsV2lzblBCY0JGQlNYNUFiM2cz?=
 =?utf-8?B?eitvampzQ0pLd2tKNURldTdOSmE5U0ZQTXE0YzJpT09CTzZjOVVSeUlQNWVq?=
 =?utf-8?B?TnhIMExid0NyT001NWRKWWZPT0c2bWNXUkExc3lrVzZaZUQxNkZDVmNBMXBk?=
 =?utf-8?B?cnBUM3ZSRnhRb1FoNVBPZ2Uzb1MrMEMzczQ5VkQyalF1QUw3Z0NiOXlkUC9u?=
 =?utf-8?B?K3hHaDB2bW10WEFDajhRRFBLSVBTeXg3a3JNUXBReU1taUptS3ZDZHJuSmZP?=
 =?utf-8?B?ME9KeURiK0Q0SEVsK2RRNXVVT3p3eFdOREtLbjgwME9EVkVFRmxLK0lLVlJX?=
 =?utf-8?B?d0lyb2I4cXlJNCs3RGJORU5DaVR0RW0vNU5WYjYzSGRaSm9UMUl5aXkwbmlt?=
 =?utf-8?B?UTExMTE0WGlybERubU1xY2VpY1I1TFlJZjlPdVNsT2tOVzF3WHV4UVVjZXNY?=
 =?utf-8?B?clpZWEJ1UHQvVnpKenpSRzRXcGYrWGpxaEl3aWlEdDI4YWk0NDM4bDJyNjhy?=
 =?utf-8?B?aDlqKy9VaDBkQjlTNjVxS1UrTmgvR0cvZE5sYVdCTXg1eUJEQ1F3eldLb1E3?=
 =?utf-8?B?cy9vZ0IzeGl2MDMyTDlST0NmNktiMk51Njk1b09QTzBzOWNMZG51VmhrTXRo?=
 =?utf-8?B?WmIwcnFVZWRBTlZGR29hMkNMSjhQdlBIaTZwbHVnMzJxT21Gc3kyd3M4Ry9w?=
 =?utf-8?B?S1VpV1NMd1lRVDNNUHhwaHQrZGJzZnNrZXg4dU95Q3JmWkVRbmp1bDY4SDRa?=
 =?utf-8?B?bXBzZE5hSkpnQ0piQWhvWkVWWGFpb2lrb21NTmY1RFlDRTFyV2pzdkRsc0Nq?=
 =?utf-8?B?cUx0cFlPWFpKOW9NT0xZYm1KSi8wWXRlWHA1YnRqeFg4ODNoUzBNVmNXTTc2?=
 =?utf-8?B?RW1lamRvaGZYcXluQWlaeURqMHdhRm9ZSFBWYjJJTUlzYm9qRWNFb2ErTkJH?=
 =?utf-8?B?UXhPb2M5MlExd01CdERzOTNTQ1VjTEllT3Y0V2FWVXA3c3FxZnlkT0l2Z2dl?=
 =?utf-8?B?RUFtdWQ5NkRwSVV2V09QcWdTOTcrL2duRStXZ01QQUkwN1kxY3U5QkF0emRV?=
 =?utf-8?B?VmxjU01sam5UQWlrMXVqSHphLzl1aFRoWTFBZE1Ubzc2SXE2MXVyb1FkaEIz?=
 =?utf-8?B?bzN5MmQ4aVpUT1lMS2tad2ZkcDFUVWJNMnkyOGNmMzJmcE1RS01IVVRjZDFP?=
 =?utf-8?B?YjJBM3dtVlNXc3lOdEMrUDRhR004QTNydjN5MzR3WUhoUE5XZXJnS01MZSt4?=
 =?utf-8?B?RTY0a1FzZk1ObUxyU2tNbXk1aVZ3cFZaVE5FS1BXS2tEZTk1UVA2NFdJRitZ?=
 =?utf-8?B?ekdnZ2ZNcXJ5QkwzUHJuNkhaMnAvbWVmVlZiTFVSeWx6c0Zsb2hPd1JaT0Rm?=
 =?utf-8?B?ZXFKeFk2YnhVU2hQeXJZUUdYaUpTaW9PNlNZQ2pvblp2Z1J6OWVVSUdaOHYw?=
 =?utf-8?Q?L9PJM+1qRMejIIaiHtGZJt0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FFD57EC91A923419F3874458FDCD86D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43044578-3617-464c-55f6-08d9eb19d34c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 15:44:00.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOPjceX3VX7GkaBPYr478g7AUgM+hbar+qHmLIFWoXbvVHlq+Ss4aJFwfMvgWfuJZx8btuJUxiQyo/MZ/lx/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDEwOjIzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA4IEZlYiAyMDIyLCBhdCA5OjQyLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+
IA0KPiA+ID4gT24gRmViIDgsIDIwMjIsIGF0IDk6MjkgQU0sIEJlbmphbWluIENvZGRpbmd0b24N
Cj4gPiA+IDxiY29kZGluZ0ByZWRoYXQuY29tPiANCj4gPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiBPbiA4IEZlYiAyMDIyLCBhdCA4OjQ1LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiAN
Cj4gPiA+ID4gPiBDYW4ndCB3ZSBqdXN0IHVuaXF1aWZ5IHRoZSBuYW1lc3BhY2VkIE5GUyBjbGll
bnQgb3Vyc2VsdmVzLA0KPiA+ID4gPiA+IHdoaWxlDQo+ID4gPiA+ID4gc3RpbGwNCj4gPiA+ID4g
PiBleHBvc2luZyAvc3lzL2ZzL25mcy9uZXQvbmZzX2NsaWVudC9pZGVudGlmaWVyIHdpdGhpbiB0
aGUgDQo+ID4gPiA+ID4gbmFtZXNwYWNlPw0KPiA+ID4gPiA+IFRoYXQNCj4gPiA+ID4gPiB3YXkg
aWYgc29tZW9uZSB3YW50IHRvIHJ1biB1ZGV2IG9yIHVzZSB0aGVpciBvd24gbWV0aG9kIG9mIA0K
PiA+ID4gPiA+IHBlcnNpc3RlbnQNCj4gPiA+ID4gPiBpZA0KPiA+ID4gPiA+IGl0cyBhdmFpbGFi
bGUgdG8gdGhlbSB3aXRoaW4gdGhlIGNvbnRhaW5lciBzbyB0aGV5IGNhbi7CoCBUaGVuDQo+ID4g
PiA+ID4gd2UgDQo+ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4gbW92ZQ0KPiA+ID4gPiA+IGZvcndh
cmQgYmVjYXVzZSB0aGUgcHJvYmxlbSBvZiBkaXN0aW5ndWlzaGluZyBjbGllbnRzIGJldHdlZW4N
Cj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBob3N0DQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4g
bmV0bnMgaXMgYXV0b21hZ2ljYWxseSBzb2x2ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0IGNv
dWxkIGJlIGRvbmUuDQo+ID4gPiANCj4gPiA+IE9rLCBJJ20gZXllYmFsbGluZyBhIHNoYTEgb2Yg
dGhlIGluaXQgbmFtZXNwYWNlIHVuaXF1aWZpZXIgYW5kDQo+ID4gPiBwZWVybmV0MmlkX2FsbG9j
KG5ld19uZXQsIGluaXRfbmV0KS4uIGJ1dCBtZWFucyB0aGUgTkZTIGNsaWVudA0KPiA+ID4gd291
bGQgDQo+ID4gPiBncm93IGENCj4gPiA+IGRlcGVuZGVuY3kgb24gQ1JZUFRPIGFuZCBDUllQVE9f
U0hBMS4NCj4gPiANCj4gPiBPciB5b3UgY291bGQgdXNlIHNpcGhhc2ggaW5zdGVhZCBvZiBTSEEt
MS4NCj4gPiANCj4gPiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBiZSBhZGRpbmcgYW55IG1vcmUg
U0hBLTEgdG8gdGhlIGtlcm5lbCAtLQ0KPiA+IGl0J3MgZGVwcmVjYXRlZCBmb3IgZ29vZCByZWFz
b25zLg0KPiANCj4gVGhhbmtzISBTaXBoYXNoIGlzIG5pY2VyIHRvby7CoCA6KQ0KPiANCj4gDQoN
CnBlZXJuZXQyaWRfYWxsb2MoKSBpcyBub3QgZGVzaWduZWQgZm9yIHRoaXMuIEl0IGFwcGVhcnMg
dG8gdXNlDQppZHJfYWxsb2MoKSwgd2hpY2ggbWVhbnMgaXQgd2lsbCByZXVzZSB2YWx1ZXMgZnJl
cXVlbnRseS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
