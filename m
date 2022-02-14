Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8454B5BB7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 22:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiBNVAO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 16:00:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBNVAL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 16:00:11 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2123.outbound.protection.outlook.com [40.107.94.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5FE13194B
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 13:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqe26JrLtzGi+SGiq89xZJerDoBifiXc+ilQyvpw9RdN2q2/ejCC2yYY2cCvxMkYh98i/cbCtHX7kiQle+SstWpPNoY9VtwC+k7/ed1dAcA05kv9Bq6ZfKpg8V5ZWDLakUo0foik88nkTZTxP2zORMqypeLutb+1jjQppLHtK6sn9qT3heSZnrFTiuI5ZdHyKUR6XJ/RiRw3/obhbMD3rmaWACtKATxtDh5gPlhmCLO7Xn/t5i0Q8Kuii/RoEYHFTh2MOj2n1tm3Gis5X+RjWY1PR1/cJrdIx6M5iZgIHHkEAkExHts1LR1Iwnz42lJ3UDyL4z2kN8T42dTOg/6eDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Swc0ylg8wdERSYoROJIg1VxQ5Jgz/6PfXg3iXpkq1M=;
 b=NqU9NHIbQHuoqIK7EXrvVsC/mN2FnsKikysXaRyuxest1+R5WQYqiW3ROf2Op4RY8Qa2oABpA7TCGq5rQszvl1hbpPbesIeRksR/eLAtyRIENDlLtMt0iMPeAVLkJh17OGd9X95XfcYKmQWUnMkHnA9TukWBSwX/FLIZ/TizGdhQtl6JyWAI/K7Pv/McZqJ5fecIUJCT4eA3l8ZP+oBILN0sfQjO0J/8Wb7vtZ+UsL20bkh1TtoeX+RD8/TJEOWCLpGQdy+vE4FOctextdcJFJ4ZjvL9AbfSiQIMjMj2MoKCzU6M5nYFclFEmGAPXVbs3622M98K27vBB3s8bUtFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Swc0ylg8wdERSYoROJIg1VxQ5Jgz/6PfXg3iXpkq1M=;
 b=JVvAPlVbvq7CmDmDV5II0VVNNK5LUhPb5SVrU0yxW6//9wrC1XMHnQ4FrdZayrnHzl+1B44XN4PLP3xV5LlAsWksnkd0+EV5OAUcfexjJhZVkE2Tf95KdR76dIcHpUBQoQbU018THq+UBbxgD1OFpRM+0CaXVYhJcAoFYW5tavQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN8PR13MB4338.namprd13.prod.outlook.com (2603:10b6:408:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.8; Mon, 14 Feb
 2022 19:40:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%8]) with mapi id 15.20.4995.014; Mon, 14 Feb 2022
 19:40:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tblume@suse.com" <tblume@suse.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "libtirpc-devel@lists.sourceforge.net" 
        <libtirpc-devel@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Topic: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Index: AQHYIYhKDk3jkCVie0yBKH6y3YG1OqyTK2AAgAAP9ACAAAUSgIAAMdcA
Date:   Mon, 14 Feb 2022 19:40:02 +0000
Message-ID: <8bf36c74a29198fad7d18434f511dca0fa5dc04c.camel@hammerspace.com>
References: <20220214092607.24387-1-Thomas.Blume@suse.com>
         <F1A91E0B-4544-4739-ADAD-CF9FCC9E8F66@oracle.com>
         <q7n3pnn5-6o3-524-8rn1-q7oprr139258@fhfr.pbz>
         <45A65BD8-8712-4B43-A91E-9DBA21ECE6E3@oracle.com>
In-Reply-To: <45A65BD8-8712-4B43-A91E-9DBA21ECE6E3@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b92d70c7-9913-4282-41cd-08d9eff1cb62
x-ms-traffictypediagnostic: BN8PR13MB4338:EE_
x-microsoft-antispam-prvs: <BN8PR13MB433816C8C30C32F5F9109788B8339@BN8PR13MB4338.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gn0c26qb/77oaLi6KFOKpY2taoE1aIJ9Jx0NFV5OwEH542UhBwkYqrQsqfhloxsMxBMiPqT11mC/qCSb5n2h/cRwS6UxWoy9qmfDppb/hKyTrLGF7bs+iw7vuw5Nmq4IqmoPBJe7NXfAO01Bl7G4zKzpVz4BijLHPxQu9Dit3md266p/0PTIdi4BXGyTVRqwOX9OeGUU3EZSj/bLoHFRZSM8r4RkdS+KdYcaUERsJgNZEmhPNsJrStYiD3FmVi39SEB5hXoVXv225X9dCwpju1NpQI3v5hNXxgcIHMjMbrOcsMRPPdKUT3dGdhFCrd4GEGTsL2GVgHijvPpGuAzX5o2p3JTZINhO0D01JwRJA1ktES9wcJkGm5IkSFJaHdIVws6tt7cHAYPseWaxni+hQXl2ZfZRVI2VvhU00r1bhYCCDn+rSRd7ehISI2ytsfUr9E71lpPThiauV+WJYWOJHT58s4qKIxfABMgd4B2SKGHu+orIsG80NNtFMi3rGRsbUQ4pJgnERwsMc8BPKVe8OcP+0YEPkq2BNQnK09DKWb9U9eH8dQO7NA/uPtzQFRrgpoYzxI3d4i8H0ixVa5uZ8TvnxQcuBrKzKMmWgqPNDiq7Mw1+1Sr823jIIYb/9VQt14ZyNI2K8x+Hk9+NgwM/tPjXyXmIDp8NZYy9wHBkbmq/EF3cojV08Jidw6WbdQuGdS1LJksOYNpJY0S3Os8ICuNcct900vmLrX/xohtQW3exlnDg3oI1qZnxokP/CHjlGcexGQ6syHckb/hUEuC6/B8tzHpUVrN804oaJRytDvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6512007)(186003)(26005)(38070700005)(2906002)(5660300002)(2616005)(83380400001)(66946007)(122000001)(316002)(36756003)(6486002)(966005)(6506007)(53546011)(64756008)(66446008)(66476007)(508600001)(8936002)(54906003)(76116006)(66556008)(110136005)(4326008)(86362001)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEU1RnJoQ09YZThETkRYdnEwd3V3dEY3Q00zVllUWlZFejQ0a0pEN25qTTBv?=
 =?utf-8?B?TXRXZWprM2xCUCt1bVh6Z08zbHNvSGpRWVBhM2xydmkva2FwN2VGVDh4UU13?=
 =?utf-8?B?Z0FyaHRwRjZpQTNoanFUOEhVMXJJM2dockhzbXdwZDVYQlNoa2RHcWZrUVJs?=
 =?utf-8?B?TXZFVFlyNzN0V3p1Tm1EUkVLRTBhOUROdmdUU3VraWpCeFI4eEl3ZWd6V2RH?=
 =?utf-8?B?Tmo3aFFRODlNTkFCOVVNNXlRUlVDM0c0bU12WE9UUWdWdlJzcE5uZWxjR1RJ?=
 =?utf-8?B?MStqMG5UR2I4ZjEraytPM281UXRpT3NtZzlLd3J6bVpaeGovdUgwY3R3VXE0?=
 =?utf-8?B?dkQvbEdaYTBWQ2diUUtkVk1RVEpCaVpGOXM4bmprMU9kSmNXWVJBSG5RWkZk?=
 =?utf-8?B?MUtONmZtSTBmT2lnZ1QrQ2VoZkdqUkZBaTQ2ZysySnJ6SEcrVi81VXpreitV?=
 =?utf-8?B?SUc3RjIrUU9vY3FlQTliL2wvRTVRUnRMeW9BNXBZZFUxU09mV21DTXMzS01l?=
 =?utf-8?B?Z3pCYzVTS3JiK253SDJBWGdTR3JqWDd1RnlNbGdjdnFXOHlmYTBReGFEZktO?=
 =?utf-8?B?S2E0TzFveTJ4NDN2MVF5NTZ6LzIyOGVrMWRPc2VPSWMzR203TUNqVXFpTHox?=
 =?utf-8?B?ZE12Zm5vdDVLOVFmd25laFJ1WE1vdDc1dnFRK1h6Mk04c24vWkZJbU5EL3RY?=
 =?utf-8?B?TnJPSzRYTjF6Y0JUM1lRRjlPT083RmdGMjVyYTlKVGZlNDI3R0VIeUZJK0Jx?=
 =?utf-8?B?eTFqQmNIMlh6aE51dTFUSnM5Q2ROM25GK1F2ZmdnT1MzZnlqeCtmWFlERDBl?=
 =?utf-8?B?elRVdC96MkJwL3lBNFVsTjc4Vk1kRFdRR1NDNitZbEFMOWZnWGkrMS8xVE8y?=
 =?utf-8?B?YzBvVndSK2NOUmlpYzV1LzVuRTNVZVJnN0VOSkRHUVdOQ21wQjh2bkhobUJ4?=
 =?utf-8?B?VFI5V2FmZXFINWhnRkYrUFlUbUdiTnRQbFZNaGM3OG91djhKN1hJMU9QSlFK?=
 =?utf-8?B?UmgwRHdJc0kwLzV2dTZYWHdiai9URWQ2RmMyNUxodFBMc2FrSmlTSmQvaVFo?=
 =?utf-8?B?MXBNbnp5Z1VEUFVZNUJwd2xHYk9nbTFJMUkvUU5rYTRETzFEQkpMdWcrSDBY?=
 =?utf-8?B?MDRUU2wrRU5mdWpnQk42di9Qc3Rrd3AvSUcyTWJuamNDcjNNcGxMU1lBUDUv?=
 =?utf-8?B?MSt1NHk5S3Roa2ZMK25VZi8yeXlPeDExdk1tdXVpbVRWSTRqQWhHVWZia1cz?=
 =?utf-8?B?c0JkMEZTaGNJdkpHTXppbWtLWVlmNEZmRmc2bXZGVUhvTWg5alVQcElKWDJB?=
 =?utf-8?B?c2N3VkFCbmVSMnpVWXBzOU0zbHZRVmo0NVZPTHNyVzF1VjlZYXNFUWNPcTlW?=
 =?utf-8?B?OWJ2WXZEb3YwNHBqMjFUdW4rTWN6T2RKZjZmVkFUUnZRS3FsVUt2bUIyN3dz?=
 =?utf-8?B?S0J0eUFtM0VNMjFXTDhRNS9QUVZpeFdBY1ovN1dubEZJS0J5OTltdzNpUFJL?=
 =?utf-8?B?STFxdS9PWnIrRXZoTDlVelJ0NjVlcGFtTzlTcGtnbjlZZlNjZDkzVXc1bGdZ?=
 =?utf-8?B?YTNRUjBUTmRMUktZajQzQjA4RlkvNDlVZ2w4dkwvcDFCN1hoekZVQXRjWGhn?=
 =?utf-8?B?bkhtejNEY1BXODU0dnRWaXRiRVh0eE1uZmV3aWJVSWRBS1dPeTlGVHY3L296?=
 =?utf-8?B?T3VsdnUycE02VHpTcUFUZzBsVmxJOFlYdXNjRG1aZjNtcEl0Rml6TEdWVDdE?=
 =?utf-8?B?YTBWTHpvUzBPVnF2Z0tRSlJIV0RxeGp1TDVWdk9IbGVCSWhZTGV3ZGZua1Ex?=
 =?utf-8?B?UE1KOSs3N01ldzNURFNBZnBicnZvNE5EOG52d3lsOEVobGh3TXFTRWlLK3dQ?=
 =?utf-8?B?Ui9TYkxMWnhETnk2dldxZDNxWlhlbXdYdTZOWHQydHJXRmFaQTMvM05QdkdH?=
 =?utf-8?B?YityRlNEY2NCQXdXSXhieDc4SVYyc1VJeGZXSFkrLy91VCt1SFZUbmR2RW1J?=
 =?utf-8?B?SnRGSThCUDM5bnphY1RwL3pWMGF4bndLdkg2VEZvT2pmV1hZUGN3eUlQVU9w?=
 =?utf-8?B?cUdPbGJRQ3ZMb2RML2NqdXFyck1MNHF6dEpBV0p5bjMyRmkxZ3VRVE5LUlRB?=
 =?utf-8?B?R1VWS2dXeXJxM1B3VEkxeUhYWGVQbjN6Q3lWZlo2UlZncU5RU1ZxcHZvSTlp?=
 =?utf-8?Q?KC2eE9Q/QFheBI/ZK966pwo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB7C66E1B2E6A449849C16B2BA6FC25@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92d70c7-9913-4282-41cd-08d9eff1cb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 19:40:02.5494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7MJJzLwWXH5Mezf/YF4xoFhOsI7FULAKDZdmlBhhMfMpH9bhYC3VncBLpFkq63jPEfbsH66ALSSlil6QK6tHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB4338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTE0IGF0IDE2OjQxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBGZWIgMTQsIDIwMjIsIGF0IDExOjIzIEFNLCBUaG9tYXMgQmx1bWUg
PHRibHVtZUBzdXNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSGVsbG8gQ2h1Y2ssDQo+ID4gDQo+
ID4gT24gTW9udGFnIDIwMjItMDItMTQgMTY6MjYsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4g
PiANCj4gPiA+ID4gT24gRmViIDE0LCAyMDIyLCBhdCA0OjI2IEFNLCBUaG9tYXMgQmx1bWUgdmlh
IExpYnRpcnBjLWRldmVsDQo+ID4gPiA+IDxsaWJ0aXJwYy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQ+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gSW4gc29tZSBzZXR1cHMsIGl0IGlzIG5l
Y2Vzc2FyeSB0byB0cnkgcnBjIHByb3RvY29sIHZlcnNpb24gMg0KPiA+ID4gPiBmaXJzdC4NCj4g
PiA+IA0KPiA+ID4gQmVmb3JlIGFwcGx5aW5nIHRoaXMsIEkgaG9wZSB3ZSBjYW4gcmV2aWV3IHBy
ZXZpb3VzIGRpc2N1c3Npb25zDQo+ID4gPiBvZg0KPiA+ID4gdGhpcyBpc3N1ZS4gSSd2ZSBmb3Jn
b3R0ZW4gdGhlIHJlYXNvbiBzb21lIHVzZXJzIHByZWZlciBpdCwgb3INCj4gPiA+IG1heWJlIEkn
bSBqdXN0IGltYWdpbmluZyB3ZSd2ZSBkaXNjdXNzZWQgaXQgYmVmb3JlIDotKQ0KPiA+IA0KPiA+
IFdlJ3ZlIGhhZCBhIGRpc2N1c3Npb24gYWJvdXQgMSB5ZWFyIGFnbzoNCj4gPiANCj4gPiBodHRw
czovL3NvdXJjZWZvcmdlLm5ldC9wL2xpYnRpcnBjL21haWxtYW4vbWVzc2FnZS8zNzIyNzg5NC8N
Cj4gPiANCj4gPiBhY3R1YWxseSB0aGF0IGVuY291cmFnZWQgbWUgdG8gc2VuZCBhIHBhdGNoLCBl
dmVuIHRob3VnaCBJDQo+ID4gaW5pdGlhbGx5IHRob3VnaHQNCj4gPiBpcyB3YXNuJ3QgZ29vZCBl
bm91Z2ggZm9yIHVwc3RyZWFtLg0KPiANCj4gSSBhZ3JlZSB0aGF0IGFkZGluZyB0aGUgc2lkZWNh
ciBmaWxlIHRvIHRvZ2dsZSB0aGUgcnBjYmluZA0KPiB2ZXJzaW9uIG9yZGVyIGlzIGEgYml0IHJv
dWdoLg0KPiANCj4gDQo+ID4gPiBUaGUgcGF0Y2ggZGVzY3JpcHRpb24sIGF0IHRoZSB2ZXJ5IGxl
YXN0LCBoYXMgdG8gaGF2ZSBhIGxvdCBtb3JlDQo+ID4gPiBkZXRhaWwgYWJvdXQgd2h5IHRoaXMg
Y2hhbmdlIGlzIG5lZWRlZC4gQ2FuIGl0IHByb3ZpZGUgYSBVUkwgdG8NCj4gPiA+IHRocmVhZHMg
aW4gYW4gZW1haWwgYXJjaGl2ZSwgZm9yIGV4YW1wbGU/DQo+ID4gDQo+ID4gVGhpcyBnb2VzIGJh
Y2sgdG8gYW4gb2xkIFNVU0UgYnVncmVwb3J0IGZvbGxvd2luZyB0aGUgY2hhbmdlIG9mIHJwYw0K
PiA+IHByb3RvY29sDQo+ID4gdmVyc2lvbiAyLCAzLCA0IHRvIDQsIDMsIDIuDQo+ID4gQmVsb3cg
YW4gZGVzY3JpcHRpb24gb2YgaXNzdWUgdGhlIGN1c3RvbWVyIHdhcyBzZWVpbmc6DQo+ID4gDQo+
ID4gLS0+DQo+ID4gQW4gM3JkIHBhcnR5IE5GUyBTZXJ2ZXIgaXMgYmVoaW5kIGEgRjUgZnJvbnQg
ZW5kIGxvYWQgYmFsYW5jZXINCj4gPiBkZXZpY2UuDQo+ID4gVGhlIEY1IGZyb250IGVuZCBsb2Fk
IGJhbGFuY2VyIGRldmljZSBpcyByZXBsYWNpbmcgSVAgYWRkcmVzc2VzIGluDQo+ID4gcGFja2V0
cyBhcw0KPiA+IHRoZXkgaGVhZCB0byBhIE5GUyBzZXJ2ZXIuDQo+ID4gSXQgcmVwbGFjZXMgSVAg
YWRkcmVzc2VzIGluIGhlYWRlcnMgYnV0IGFzIHlvdSBtaWdodCBleHBlY3QgaXQgZG9lcw0KPiA+
IG5vdCByZXBsYWNlDQo+ID4gdGhlIElQIGFkZHJlc3Mgd2l0aGluIHRoZSBSUEMgZGF0YSBwYXls
b2FkLCBpLmUuIHdpdGhpbiBSUEMgR0VUQUREUg0KPiA+IHJlcXVlc3QsDQo+ID4gd2hpY2ggcGxh
Y2VzIGFuIGFkZHJlc3MgdGhlcmUgZm9yIHRoZSB1bml2ZXJzYWwgYWRkcmVzcyBvciBoaW50LsKg
DQo+ID4gV2l0aG91dCBhDQo+ID4gY29ycmVjdCBoaW50LCB0aGUgR0VUQUREUiByZXBseSB3aGlj
aCBjb21lcyBiYWNrIGdpdmVzIGFuDQo+ID4gdW5leHBlY3RlZCBhZGRyZXNzDQo+ID4gd2hpY2gg
aGFwcGVucyB0byBiZSB1bnJvdXRhYmxlIGZyb20gdGhlIG5mcyBjbGllbnQncyBwb2ludCBvZiB2
aWV3Lg0KPiA+IC0tPA0KPiA+IA0KPiA+IFdlIGFncmVlZCB0aGF0IHRoaXMgaXMgcmF0aGVyIGFu
IGlzc3VlIG9mIHRoZSBsb2FkYmFsYW5jZXINCj4gPiBoYXJkd2FyZSwgYnV0IHdlDQo+ID4gd291
bGQgaGF2ZSB0byBhZGRyZXNzIHRoYXQgYW55d2F5IGR1ZSB0byBiYWNrd2FyZCBjb21wYXRpYmls
aXR5Lg0KPiA+IA0KPiA+IFNvLCB0aGUgZmlyc3QgcXVlc3Rpb24gaXMsIGRvIHdlIHdhbnQgdG8g
c3RheSBiYWNrd2FyZCBjb21wYXRpYmxlDQo+ID4gdXBzdHJlYW0/DQo+ID4gV2UgaGF2ZSB0byBk
byB0aGF0IGFzIGRpc3RyaWJ1dG9yLCBidXQgb2YgY291cnNlIHVwc3RyZWFtIGlzDQo+ID4gZGlm
ZmVyZW50Lg0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmVtaW5kZXIuIEkgc3VnZ2VzdCB0aGF0IGl0
IHNob3VsZCBiZSBpbmNsdWRlZA0KPiBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gaWYgeW91IHBv
c3QgYWdhaW4gc28gdGhhdCBpdCBiZWNvbWVzDQo+IHBhcnQgb2YgdGhlIGxpYnRpcnBjIGNvbW1p
dCBoaXN0b3J5Lg0KPiANCj4gDQo+ID4gPiA+IENyZWF0aW5nIHRoZSBmaWxlwqAgL2V0Yy9uZXRj
b25maWctdHJ5LTItZmlyc3Qgd2lsbCBlbmZvcmNlDQo+ID4gPiA+IHRoaXMuDQo+ID4gPiANCj4g
PiA+IEEgbmljZXIgYWRtaW5pc3RyYXRpdmUgQVBJIHdvdWxkIGVuYWJsZSB5b3UgdG8gdXBkYXRl
IHRoZSB3aG9sZQ0KPiA+ID4gcnBjYmluZCB2ZXJzaW9uIG9yZGVyLCBidXQgdGhhdCBtaWdodCBi
ZSBtb3JlIHdvcmsgdGhhbiB5b3Ugd2FudA0KPiA+ID4gdG8gcHVyc3VlLg0KPiA+ID4gDQo+ID4g
PiBJdCB3b3VsZCBiZSBhIG5pY2VyIGlmLCBpbnN0ZWFkIG9mIGEgc2VwYXJhdGUgZmlsZSwgYSBs
aW5lIGlzDQo+ID4gPiBhZGRlZCB0byAvZXRjL25ldGNvbmZpZyB0byB0b2dnbGUgdGhpcyBiZWhh
dmlvciwgb3IgcHJvdmlkZSB0aGUNCj4gPiA+IHdob2xlIHZlcnNpb24gb3JkZXIuIEUuZy4NCj4g
PiA+IA0KPiA+ID4gIyBycGNiaW5kIDQgMyAyDQo+ID4gPiANCj4gPiA+ICMgcnBjYmluZCAyIDQN
Cj4gPiA+IA0KPiA+ID4gUmVhbGx5LCB0aG91Z2gsIHRoaXMgaXNuJ3QgcmVsYXRlZCB0byB0aGUg
dHJhbnNwb3J0IGRlZmluaXRpb25zDQo+ID4gPiBpbiAvZXRjL25ldGNvbmZpZywgc28gYSBzZXBh
cmF0ZSBjb25maWd1cmF0aW9uIGZpbGUgbWlnaHQgYmUNCj4gPiA+IG1vcmUgYXBwcm9wcmlhdGUu
DQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgaGludHMsIGlmIHlvdSBkZWVtIGEgcGF0Y2ggd291
bGQgYmUgc3RpbGwgZGVzaXJlYWJsZQ0KPiA+IEkgd2lsbCB3b3JrDQo+ID4gb24gdGhhdC4NCj4g
DQo+IEknZCBsaWtlIHRvIGhlYXIgb3RoZXIgb3BpbmlvbnMuIEknbSBub3QgdGhlIG1haW50YWlu
ZXIgb2YNCj4gbGlidGlycGMsIEknbSBqdXN0IHNvbWVvbmUgd2hvIGlzIHZlcnkgb3BpbmlvbmF0
ZWQgOi0pDQo+IA0KPiANCg0KUXVpdGUgZnJhbmtseSwgaWYgeW91J3JlIHJlbHlpbmcgb24gdGhl
IElQIGFkZHJlc3MgaW4gR0VUQUREUiBiZWluZw0KY29ycmVjdCwgdGhlbiB5b3UncmUgZ29pbmcg
dG8gYmUgZGlzYXBwb2ludGVkIGluIGEgbG90IG9mDQpjaXJjdW1zdGFuY2VzOiB0aGUgY29tbW9u
IHByYWN0aWNlIG9mIHVzaW5nIE5BVCBhbmQgTUFTUVVFUkFESU5HIGluDQptb2Rlcm4gZGF0YSBj
ZW50cmVzIChwYXJ0aWN1bGFybHkgd2hlbiB1c2luZyB2aXJ0dWFsaXNhdGlvbikgdHlwaWNhbGx5
DQpicmVhayBpdCBwcmV0dHkgYmFkbHkuDQpJbiAxOTk1LCB3aGVuIFJGQzE4MzMgd2FzIHB1Ymxp
c2hlZCwgdGhlcmUgd2Fzbid0IHRoYXQgbXVjaCB3aWRlc3ByZWFkDQp1c2Ugb2YgTkFULCBhbmQg
dGhlcmUgY2VydGFpbmx5IHdhc24ndCBoZWF2eSB1c2Ugb2YgY29udGFpbmVycyBmb3INCmhvc3Rp
bmcgc2VydmljZXMgbGlrZSBORlMsIHNvIGl0IGlzIHVuZGVyc3RhbmRhYmxlIHdoeSB0aGlzIGhh
cHBlbmVkLA0KYnV0IHRvZGF5IHdlIHNob3VsZCBrbm93IGJldHRlci4NCg0KU28gd2hpY2ggYXBw
bGljYXRpb25zIGFyZSBzdGlsbCByZWx5aW5nIG9uIHRoZSBhZGRyZXNzIGZyb20gR0VUQUREUiBp
bg0Kb3JkZXIgdG8gd29yayBjb3JyZWN0bHk/IEFzIGZhciBhcyBJIGtub3csICdtb3VudCcgZG9l
cyBub3QuIEkgc2VlbSB0bw0KcmVtZW1iZXIgdGhhdCAnc2hvd21vdW50JyBpcyBib3JrZW4sIGFu
ZCBuZWVkcyB0byBiZSBmaXhlZC4gT3RoZXJzPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
