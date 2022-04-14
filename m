Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB04550053A
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Apr 2022 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiDNEho (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Apr 2022 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEhm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Apr 2022 00:37:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC154BFFE
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 21:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU4Dvw7KD8JQC+mNTZN/2bAgCjfbO/6Va16uVcR1jyRJwF1l8UStdp+LaC1lYjmPcweixamvQDvuojYVpE/j2roavqL0of+dGkuB1feA14OK1PXsv0McvyEK9CLS77nCfZT7qPOba60X/2QRdP2MONdQ7uC+rhu7l9Xvnmf6o7anVo4gTgCcMI2eFLyEOCoeMcTpLt7LWrr4eGpM4M+PRQJpEm2++0fEE3RzyIo1oe5jcEEz3mc8P4ub9+5PV0+vVVzXgI4jZoBrA4thLoGn3nfpxmQlB0AMntg5L8dIZuySZYVxq7m3ieohN6baMSm9OpQq/ZnAspGxAamiYoZqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGOhGoCRvHMl5QA2egXFkn2lfo6PB539jIc81mNw0U0=;
 b=R9XN599A0KR90aqxa95guWEcyEJ6EL81uainFHwnepQILEfpY2QcCGAihMOeCkCQ2K/+/9jDvYALLL6NqITKpHqPdi8iumXWLof00c5qi86s+CPZ0gL0gn6ccu1pQsZMYafwe+/WVZSaSUEfLMz6EiYGHIZ+hSUwKnb47j8L0KVpdME+wgJRm0oq3RCPCe02XnlD3amqayvKusR6WyfACCI1kVre/LKI6Ltet8bwrwjuHJW/TgaaLjUiVdF4/BAQZzNr7h9qEWuF3PFG5EofYqKxkIhEs5hcu69/xllUlzxpeJoTkjJnNTHXJSqx7k7GDEmPQXl5EE9H61IaUXsU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGOhGoCRvHMl5QA2egXFkn2lfo6PB539jIc81mNw0U0=;
 b=bXtLhMxnNn7NMJ8IFYnsmFAhgmH5aHDXtMbGGjRh7sxCLRC3O7lhP6EBBEGcvq4MXqdEv/kQvYvt4QjNy6eI6ZERLQjSs1dBrJWFwwmt7Prz72lvR04ZaRClz/9RlBMWbyqVMttWBTKWVDMeylPhSOpvqhb9KVsohYtCBNcrDH0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR1301MB2027.namprd13.prod.outlook.com (2603:10b6:4:2b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 04:35:12 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5186.006; Thu, 14 Apr 2022
 04:35:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Topic: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Index: AQHYTeNGiM/oA9hFA0+RaWui6u++96zr2+yAgACIFICAAmwogIAABh+A
Date:   Thu, 14 Apr 2022 04:35:12 +0000
Message-ID: <64807ea6a8d169e426cff4fa75a6de9b16d3ae35.camel@hammerspace.com>
References: <164970912423.2037.12497015321508491456.stgit@bazille.1015granger.net>      ,
 <164974719723.11576.583440068909686735@noble.neil.brown.name>  ,
 <4918188E-9271-47F2-8F5A-D6D5BEB85F36@oracle.com>
         <164990959799.11576.7740616159032491033@noble.neil.brown.name>
In-Reply-To: <164990959799.11576.7740616159032491033@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17b46780-0aa5-41c7-8905-08da1dd02a04
x-ms-traffictypediagnostic: DM5PR1301MB2027:EE_
x-microsoft-antispam-prvs: <DM5PR1301MB2027E099D5205423DD35EAE6B8EF9@DM5PR1301MB2027.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pR1VQqG87mTRVOsMzlil0pfI43jRoM/J3rAD4K90JMrUtvuRHvIjICrbmq/Mt++EYw4CNHO3yLbxtPc9Py/qF12EkI/TT30YgVV+BoSZUdjAeXRsu5ANYUC0lPhfSbJB2hqtgNCctZRVLc5D98e5i6t+ridPeTUpbE9FqB/VwwY1Wg3NkOnba9DQJcXXcXUJoI6+OCfGrPTlOQ8P+QuWBf1cVRr/lS6CKXPCfjv8oJylAE2aLacCnZuwUC1oqTS/EfeYRXyzaEeRqr0vWONpQh0+SFGTc2AMaEUfu25sPqAIdNoLVkPvFuxMXO0TCHXAAGwnVh1rQP2cvDwizqLt8VAOQYtySAzggTghY2cMFyGPDhQcY8AbuGxeIn4IjeykLuQGQYqHYYRkeakCku8P/dFmId23pWW/D3l2bHDB9TdoF2YirhY8upiTPy/8nNcGLpmQ0vDLB99tWj5s4sxqha8S8tP4lMafkls+/mN7YqLyyiQJPLeNWrIkYi9LKT4VJH68CVNebCjgflKKZW6IuCwIMBFs4YGSyC6gx/6xE6JE5lxbUtKighYTrnYP8I3L3VRwlCpVdhKjYiXhGI+Vy7O9ipJYh2l/XKJjp+EZsCxEzSNbJ3hubfrPNHqkXSWioep7D7k9+Ekvse4EhzuM1VHds7ojGr6SxRjva+EX2wbhSlruriae0RqZW2Z/gyn+3mtSNYrXOe3/aPW34Zs3ntok74+Nn6RH/DSC+p63zp76MtNFOzK6TpfvcGD6vrm1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(86362001)(122000001)(36756003)(38070700005)(508600001)(316002)(38100700002)(8676002)(66476007)(64756008)(66556008)(4326008)(66946007)(66446008)(76116006)(8936002)(110136005)(2906002)(5660300002)(26005)(6506007)(53546011)(71200400001)(2616005)(6486002)(6512007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmN6cEEvZ285T3h1Rk9YWWdFVmNoQ2pSTXpZa2VaL1AxM1QrZ3RuanZmUkNv?=
 =?utf-8?B?c3IzeG55WGgrWXN2cklha2toRTd3d1U0WTBGenVCbFRSZGRXVmdRaTQ1WjVs?=
 =?utf-8?B?Vjd6S0RlcHZ4dXVlRlZkVU9ObmFrTUVQWG8zeTB2eWwzTWVIeHZwWGE2a2FM?=
 =?utf-8?B?anhiUHQ0ZDJUVVcyUmpCWkJaWmpRc2k1RjlXOTFPcDhlbDlXYU5NSEJVTEJO?=
 =?utf-8?B?cFdBVEVnR0tvWFV2aExPMGZzYUVQdTlUSTZPR2dTZmJmd21hWjRQS1NMWk5C?=
 =?utf-8?B?bjBTSzdoU0hBcUVEVVdtU2VQeXJiUWdVUXhJMTVRaTVpM1cyY09wdjMra1VH?=
 =?utf-8?B?Y3hLWkZJaTEreEJmajJHMFpOWTdZRFp1YzYvK2lnOWJrZkZWa1pRTU9FVmNI?=
 =?utf-8?B?VEtkb2l0WkVQM3VzRVM3OFplc082dklObHlhVU1KVXY4NUpObU9TS1FaMkd1?=
 =?utf-8?B?R3VCUkFMU0F4WVR3UFBEMFFEdkdKTjh0dVhXUHFuWXBsT3ZLTCtINU1iZDNM?=
 =?utf-8?B?RXZXK2p3Z25yZElOMXRSNWZrNkdyeVpYcU5qS0lHN0lTcU4xSGF4N0NoK25L?=
 =?utf-8?B?cDlrTGxBVHBzYlh3U2xlWnFheUxyT21KenQ3MUY4V0t5alJIQ1FmNHVvbjVQ?=
 =?utf-8?B?QUQra2gvUy9oSVptclJORFBuNU9WNHMzZGxDcll3MHVnSUJqVVhjUGZXazhJ?=
 =?utf-8?B?WGhKOUlsYnFyZFU4OWp0bXhwZ2VEUHJHK2ZTSDZXSitRdnJvOThxZlhNbm4r?=
 =?utf-8?B?bDE5Q3p1clV6Vk9TZWtaWnUrdjVYY3JuclNBRDdHQVRrOXVLYmhJMWh4MXVz?=
 =?utf-8?B?cnZCRlhqK01LUHZUSUJVdUg3VTRrWGRsZEhUWGVTcEJVdHhWSlFpNlhUOVFW?=
 =?utf-8?B?TUJnZlV5ZEovdStoMWlOUStlb3ExZ2hTSC9kWFJnZjRhazNqWEUxQmtneXhT?=
 =?utf-8?B?alNKQThRbHUrRnR2bGJjVFFrdmFtRTJ1b2NqVXJEN1lGSXFkZGFpZkdQa25h?=
 =?utf-8?B?KzcxNjltcFhkT2Y5aldNaVErM3NJTGFwazFrUlB2czRLbTRGRjc2VmFLZ01C?=
 =?utf-8?B?cWI5ZWVydXZOUkMxb2J4cHArQ1djNm1mdzdmSTNTMEpvdFdFRmhPWkliSDdP?=
 =?utf-8?B?S2RqNy96WGQxcU5qUy9UNGY2Q2FPM25ZcHY5OXJBbVp1TXdOMUZEZnlYTkto?=
 =?utf-8?B?TlNybm8vc3MySTFLQnZJV29XSzNoRmVvTWY2WFlOeVpLZlg3cUxDY2JDMi96?=
 =?utf-8?B?Z0Y4U2hrTzZ0SU1TcWR0bGpoV1JUSm8vU2dpa3ZDTXROZm81eGtsMlAwazVU?=
 =?utf-8?B?dnNXUDVvMWVBdDhKWDRYTDB4QXlUWXczZ2toQXVVcGgvN3ViYmQzVWdMSlBO?=
 =?utf-8?B?ZGVmeHE1NXJyNlU5Wi9QcHRpRytYUnBROC9Sam9YMkIvcll3YVpyZWJWdEtF?=
 =?utf-8?B?SU1CQVAzQnNDYzNVK2M0d3Z2RDFDQys4blI2bkdLMWJ1bUU4ZGx3ZDMybVQy?=
 =?utf-8?B?T2FnTmcwa3A0bTNIc3lDOWFwQkE2QTdIcFR3ZWRORmFYN253SmprVVA3Tk5X?=
 =?utf-8?B?UHdmMHBnR1EvRmhIZ2x1THZ3NnBISTFlV0xEMnFCbG5HRWtKMFlCamNpL3ox?=
 =?utf-8?B?Y045ZjFCdExrN0dkaWdhK1VMeXcwVGUzTHFmaTN6NmplTlQwa1pCRy9TRUQy?=
 =?utf-8?B?MCtERzJXaDBmeXdCLzAzYmVvQlVFSVBObXZGMXp0Z3BQazhLWmdDWFl0UTVy?=
 =?utf-8?B?TkM2ZGx6RE1vNWtqVHFFZ0lVWElTRjBnNExyVHloMEgwMTczdlV2Tm1rdWFM?=
 =?utf-8?B?Tkh2Q2VFczFoSnJ3WnY3M3gxNTVXNFR3cFNtZHBCVStvZDJUV1lCUnAwY0d5?=
 =?utf-8?B?bFNFYjMyc291TGNSdkhpODVBcktxS2VyMFl6SzJGZTlPZU5oOXVlcngxWWJt?=
 =?utf-8?B?TDZDMVZDOGZXT1lpOWZWc3RSdUlqRmRqTTdSRGtidHhWSGhzTjQ4NXN0ZVZB?=
 =?utf-8?B?MlpQWTcwQjdrU2xTQjR0bHFPcDRuT1AvcXZ5dnZKQVgrSTFLVThhRWhZWnNr?=
 =?utf-8?B?MEp3MDhuS0t5MFlsdzJzNkpUR1BvUEM3bHhqV2FQNDRROWpNZzF3SldLU2JZ?=
 =?utf-8?B?T3puWmc4a2ZFdlhQcVZkRU53WlZReUM3VnlMY0NPS3daOEdqS2ZleWd5K1ZI?=
 =?utf-8?B?NXErVkVjd2hlQnB3VjFLUFRESDVwaHE3YmpTSTA0a29QMmZUaU9qYUNmWGYz?=
 =?utf-8?B?ZlIrNXlHVlVORFhTc0sxRmJlUnFZN2FaandvSzJJSTZ2dUdsRkU5b1JjeWg4?=
 =?utf-8?B?amJwOXE1cXR0dVp4dUxONlo4VSt3SGNCencxbDJoUi8wWFVhcHpkWlh0N0Zn?=
 =?utf-8?Q?AbI/x267nXz9YoF8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05A588E3D3114549BB67791A3001BD7F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b46780-0aa5-41c7-8905-08da1dd02a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 04:35:12.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yAbVhcsQhJvR1Ct4I/aCwzbKaxJVUjUnCWeZGxPG6f9Ci2/cNQH8urCbda4eDm5rd0ZXYPiJERmMlFIpyqXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTE0IGF0IDE0OjEzICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMTMgQXByIDIwMjIsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiANCj4gPiA+IE9u
IEFwciAxMiwgMjAyMiwgYXQgMzowNiBBTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPiB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gT24gVHVlLCAxMiBBcHIgMjAyMiwgQ2h1Y2sgTGV2ZXIgd3JvdGU6
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK0lmIGEgY2xpZW50J3MgImNvX293bmVyaWQiIHN0cmluZyBv
ciBwcmluY2lwYWwgYXJlIG5vdCBzdGFibGUsDQo+ID4gPiA+ICtzdGF0ZSByZWNvdmVyeSBhZnRl
ciBhIHNlcnZlciBvciBjbGllbnQgcmVib290IGlzIG5vdA0KPiA+ID4gPiBndWFyYW50ZWVkLg0K
PiA+ID4gPiArSWYgYSBjbGllbnQgdW5leHBlY3RlZGx5IHJlc3RhcnRzIGJ1dCBwcmVzZW50cyBh
IGRpZmZlcmVudA0KPiA+ID4gPiArImNvX293bmVyaWQiIHN0cmluZyBvciBwcmluY2lwYWwgdG8g
dGhlIHNlcnZlciwgdGhlIHNlcnZlcg0KPiA+ID4gPiBvcnBoYW5zDQo+ID4gPiA+ICt0aGUgY2xp
ZW50J3MgcHJldmlvdXMgb3BlbiBhbmQgbG9jayBzdGF0ZS4gVGhpcyBibG9ja3MgYWNjZXNzDQo+
ID4gPiA+IHRvDQo+ID4gPiA+ICtsb2NrZWQgZmlsZXMgdW50aWwgdGhlIHNlcnZlciByZW1vdmVz
IHRoZSBvcnBoYW5lZCBzdGF0ZS4NCj4gPiA+ID4gKw0KPiA+ID4gPiArSWYgdGhlIHNlcnZlciBy
ZXN0YXJ0cyBhbmQgYSBjbGllbnQgcHJlc2VudHMgYSBjaGFuZ2VkDQo+ID4gPiA+ICJjb19vd25l
cmlkIg0KPiA+ID4gPiArc3RyaW5nIG9yIHByaW5jaXBhbCB0byB0aGUgc2VydmVyLCB0aGUgc2Vy
dmVyIHdpbGwgbm90IGFsbG93DQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiArY2xpZW50IHRvIHJlY2xh
aW0gaXRzIG9wZW4gYW5kIGxvY2sgc3RhdGUsIGFuZCBtYXkgZ2l2ZSB0aG9zZQ0KPiA+ID4gPiBs
b2Nrcw0KPiA+ID4gPiArdG8gb3RoZXIgY2xpZW50cyBpbiB0aGUgbWVhbiB0aW1lLiBUaGlzIGlz
IHJlZmVycmVkIHRvIGFzDQo+ID4gPiA+ICJsb2NrDQo+ID4gPiA+ICtzdGVhbGluZyIuDQo+ID4g
PiANCj4gPiA+IFRoaXMgaXMgbm90IGEgcG9zc2libGUgc2NlbmFyaW8gd2l0aCBMaW51eCBORlMg
Y2xpZW50LsKgIFRoZQ0KPiA+ID4gY2xpZW50DQo+ID4gPiBhc3NlbWJsZXMgdGhlIHN0cmluZyBv
bmNlIGZyb20gdmFyaW91cyBzb3VyY2VzLCB0aGVuIHVzZXMgaXQNCj4gPiA+IGNvbnNpc3RlbnRs
eSBhdCBsZWFzdCB1bnRpbCB1bm1vdW50IG9yIHJlYm9vdC7CoCBJcyBpdCB3b3J0aA0KPiA+ID4g
bWVudGlvbmluZz8NCj4gPiANCj4gPiBOZWlsLCB0aGFua3MgZm9yIHRoZSBleWVzLW9uLiBJJ3Zl
IGludGVncmF0ZWQgdGhlIG90aGVyIHN1Z2dlc3Rpb25zDQo+ID4gaW4geW91ciByZXBseS4gSG93
ZXZlciB0aGVyZSBhcmUgc29tZSBjb3JuZXIgY2FzZXMgaGVyZSB0aGF0IEknZA0KPiA+IGxpa2Ug
dG8gY29uc2lkZXIgYmVmb3JlIHByb2NlZWRpbmcuDQo+ID4gDQo+ID4gR2VuZXJhbGx5LCBwcmVz
ZXJ2aW5nIHRoZSBjbF9vd25lcl9pZCBzdHJpbmcgaXMgZ29vZCBkZWZlbnNlDQo+ID4gYWdhaW5z
dA0KPiA+IGxvY2sgc3RlYWxpbmcuIExvb2tzIGxpa2UgdGhlIExpbnV4IE5GUyBjbGllbnQgZGlk
bid0IGRvIHRoYXQNCj4gPiBiZWZvcmUNCj4gPiBjZWIzYTE2YzA3MGMgKCJORlN2NDogQ2FjaGUg
dGhlIE5GU3Y0L3Y0LjEgY2xpZW50IG93bmVyX2lkIGluIHRoZQ0KPiA+IHN0cnVjdCBuZnNfY2xp
ZW50IikuDQo+ID4gDQo+ID4gSWYgYSBzZXJ2ZXIgZmlsZXN5c3RlbSBpcyBtaWdyYXRlZCB0byBh
IHNlcnZlciB0aGF0IHRoZSBjbGllbnQNCj4gPiBoYXNuJ3QNCj4gPiBjb250YWN0ZWQgYmVmb3Jl
LCBhbmQgdGhlIGNsaWVudCdzIHVuaXF1aWZpZXIgb3IgaG9zdG5hbWUgaGFzDQo+ID4gY2hhbmdl
ZA0KPiA+IHNpbmNlIHRoZSBjbGllbnQgZXN0YWJsaXNoZWQgaXRzIGxlYXNlIHdpdGggdGhlIGZp
cnN0IHNlcnZlciwgdGhlcmUNCj4gPiBpcyB0aGUgcG9zc2liaWxpdHkgb2YgbG9jayBzdGVhbGlu
ZyBkdXJpbmcgdHJhbnNwYXJlbnQgc3RhdGUNCj4gPiBtaWdyYXRpb24uDQo+ID4gDQo+ID4gSSdt
IGFsc28gbm90IGNlcnRhaW4gaG93IHRoZSBMaW51eCBORlMgY2xpZW50IHByZXNlcnZlcyB0aGUN
Cj4gPiBwcmluY2lwYWwNCj4gPiB0aGF0IHdhcyB1c2VkIHdoZW4gYSBsZWFzZSBpcyBmaXJzdCBl
c3RhYmxpc2hlZC4gSXQncyBnb2luZyB0byB1c2UNCj4gPiBLZXJiZXJvcyBpZiBwb3NzaWJsZSwg
YnV0IHdoYXQgaWYgdGhlIGtlcm5lbCdzIGNyZWQgY2FjaGUgZXhwaXJlcw0KPiA+IGFuZA0KPiA+
IHRoZSBrZXl0YWIgaGFzIGJlZW4gYWx0ZXJlZCBpbiB0aGUgbWVhbnRpbWU/IEkgaGF2ZW4ndCB3
YWxrZWQNCj4gPiB0aHJvdWdoDQo+ID4gdGhhdCBjb2RlIGNhcmVmdWxseSBlbm91Z2ggdG8gdW5k
ZXJzdGFuZCB3aGV0aGVyIHRoZXJlIGlzIHN0aWxsIGENCj4gPiB2dWxuZXJhYmlsaXR5Lg0KPiA+
IA0KPiANCj4gSSBkb24ndCB0aGluayBpZCBzdGFiaWxpdHkgcmVsYXRlcyB0byBsb2NrIHN0ZWFs
aW5nLg0KPiANCj4gLSBnbG9iYWwgdW5pcXVlbmVzcyBndWFyZHMgYWdhaW5zdCBzdGVhbGluZw0K
PiAtIHN0YWJpbGl0eSBndWFyZHMgYWdhaW5zdCBtaXNwbGFjaW5nIGxvY2tzIGR1cmluZyBtaWdy
YXRpb24NCj4gKCJzdG9sZW4iDQo+IC0gc2VlbXMgYW4gaW5hcHByb3ByaWF0ZSB0ZXJtIGFzIG5v
IGVudGl0eSBhbiBiZSBibGFtZWQgZm9yDQo+IHN0ZWFsaW5nKS4NCj4gDQo+IENlcnRhaW5seSBz
dGFiaWxpdHkgb2YgYm90aCB0aGUgaWRlbnRpdHkgYW5kIHRoZSBjcmVkZW50aWFsIGFyZQ0KPiBp
bXBvcnRhbnQuwqAgSWYgdGhhdCBzdGFiaWxpdHkgaXMgbm90IHByb3ZpZGVkIHRoZW4gdGhhdCBp
cyBhIGtlcm5lbA0KPiBidWcuDQo+IEFzIHlvdSBzYXksIGNlYjNhMTZjMDcwYyBmaXhlZCBhIGJ1
ZyBpbiB0aGlzIGFyZWEuDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBkb2N1bWVudCBpcyBhbiBhcHBy
b3ByaWF0ZSBwbGFjZSB0byB3YXJuIGFnYWluc3QNCj4ga2VybmVsIGJ1Z3MgLSB0aGF0IGRvZXNu
J3QgZml0IHdpdGggdGhlIHB1cnBvc2UgZ2l2ZW4gaW4gdGhlIGludHJvLg0KPiANCj4gSSBkb24n
dCBrbm93IGtub3cgaWYgdGhlIGNyZWRlbnRpYWwgY2FuIGNoYW5nZSBlaXRoZXIgLSBJIGhvcGUg
bm90Lg0KPiBJRiB0aGUgY3JlZGVudGlhbCBjYW4gYWN0dWFsbHkgY2hhbmdlLCB0aGF0IHdvdWxk
IGJlIGEga2VybmVsIGJ1Zy4NCj4gSUYgdGhlIHNhbWUgY3JlZGVudGlhbCBjYW5ub3QgYmUgcmVu
ZXdlZCwgdGhhdCBpcyBhIHNlcGFyYXRlIHByb2JsZW0sDQo+IGJ1dCBzaG91bGQgYmUgdHJlYXRl
ZCBsaWtlIGFueSBvdGhlciBjcmVkZW50aWFsIHRoYXQgY2Fubm90IGJlDQo+IHJlbmV3ZWQuDQo+
IA0KPiBJIHdvbid0IGFyZ3VlIHN0cm9uZ2x5IGFnYWluc3QgdGhpcyB0ZXh0IC0gSSBqdXN0IGRv
bid0IHNlZSBob3cgaXQgaXMNCj4gYXBwcm9wcmlhdGUgYW5kIHRoaW5rIGl0IGNvdWxkIGJlIGNv
bmZ1c2luZy4NCj4gDQoNClNlZSBSRkMgNTY2MSwgU2VjdGlvbiAyLjQuMy4NCg0KSXQgaXMgdXAg
dG8gdGhlIHNlcnZlciB0byBlbmZvcmNlIHRoZSBjb3JyZXNwb25kZW5jZSBiZXR3ZWVuIHRoZSBs
ZWFzZQ0KYW5kIHRoZSBwcmluY2lwYWwgdGhhdCBvd25zIHRoYXQgbGVhc2UuDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
