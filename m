Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDE7E2E18
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Nov 2023 21:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKFUV7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Nov 2023 15:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjKFUV6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Nov 2023 15:21:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C06D75
        for <linux-nfs@vger.kernel.org>; Mon,  6 Nov 2023 12:21:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSTP1954lkuNeHr27lME3IR2P1/SsABxukYmy0fiU+h1EtIV2RRTgo3y6YHXAaSBuvOrMogktMbryeWh5L0XI8g+RRD+v57U8heGIoQK8mTXwBJxDQgM5rEZBQ52CTEWL1au07lNJp8qJbC5JPJxpZhAwmIOuWeSPALWNJxMr9yCI/MTeB0MXsEGJV2e9xJk4/kXqXl3lxwlYO/+QM5CdfJtnQ0fCZd/SNZXoiaecDB49ylPasswzMWLhq+356rmHhDg2s0AuLl3n94ajGmTz7Pd/p4ilo6IzcbCC5daEfLPC6tdlxcytVTOjX6EMGMiwka0Bc5qdxczPPFHIeXkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEld9dtIsdqEwjTO99/s6TsS0RRXgEDCgCzlSATGGyM=;
 b=Z9w9Mrsh97lJ9NO4E8T/44G0JOCj/CQ70s4FgmdKoZSeTcLmH9hpYziRrqad6olzlY/IcU7iO4rHZ0H045fSpNR13nD+eMGfFBg58ZY144+vFudBROA5wDu454oKac3GNlEsg13nTrv0PjKG57kwv1TYFMz9PIRr1BiDiXML3euJgqfMTNuekR2fyRuYRlWTtSBncAL+LGojjgXCiLl39VGGhShYrYHAffCY9xKrG5C8J5ckhWB26Q7Ek7SfwnHeNZ4+n1XTTgzyx/ajpvMjQMBggy/AMQMjXjk2Q+PjVvJ+f0OHoIxa/uX3AtDCB/aFyPN2CTvuEtXLejcGeYqkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEld9dtIsdqEwjTO99/s6TsS0RRXgEDCgCzlSATGGyM=;
 b=EsvhF5KCbhwSBlQU4j0j+UzqVITasFbawusou5EPxLCeO7eLCOiZ5PNQIvovYNllZ3BB9xqjrgldkHtj/DxnEesB2d8u/XuJFOWyhsyjvxxIUgMZG6+ScKoMrrQfzL0bNajr88RFFETr0QUGqMPiwTTlbd8IrYPLnl6xUfB1nsU=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 CH2PR13MB4474.namprd13.prod.outlook.com (2603:10b6:610:6d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 20:21:49 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:21:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Thread-Topic: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Thread-Index: AQHaEB5BKQ5QGSlnh06Lj6cEjRIJpLBtfMoAgAAeP4CAAAdBgIAAGGeAgAACzwA=
Date:   Mon, 6 Nov 2023 20:21:49 +0000
Message-ID: <2c54034283923ce7464ea1a93b09905a1a4fae61.camel@hammerspace.com>
References: <151d80cb-33dc-4266-a3ba-4b89ea80e49f@oracle.com>
         <971e0321c1637fa4bb8625b618734fa8b229b0e0.camel@hammerspace.com>
         <c53af0da-58f4-4981-9006-a6acbf404de4@oracle.com>
         <ed79385ef7c8ce2c6ff6753bcf8c5301f2d39584.camel@hammerspace.com>
         <84f065ca-435d-42a5-b190-44546d549681@oracle.com>
In-Reply-To: <84f065ca-435d-42a5-b190-44546d549681@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|CH2PR13MB4474:EE_
x-ms-office365-filtering-correlation-id: 3b572081-e9ef-4fbb-07bb-08dbdf0601d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0Iy8WKCtRkV4up57c0km63jft/wfjt7aUyoA9qSXwtRfh3xFctjvEkucU8+nLQB/aidFnBKFy6c1cNvLQcruVH1h3Op4oTf6SSXIGv+rPQHdsaCwee41Ln2B9BFphsrtcXwGO51z3+gO2kqDqfE0LpDHfRH6RbbDvpg/lWP0b/I67nnHmHonU5hH7SkpUBkeOSQxxRgulqs8MMQeLEDSdCme56sQZ09xjfj2IkzKMPbiGY0b27j2gqI4sfeoZN0cey8KPoeuOgGoQBqRLNOG3/qoT3wwuEI7XcSYfVftmmYOGYp7jRFAZx19SBjFvMsQO4azxyHpX/h1nQi1Qmh81vjy2r10Pz8bzdrAjBKYLMzVNHoqTs3zUvFwlhlaRuBUFbXUkek9lWPgQuNFMIJJpBjmmrCFxGrJWvuyGL+esYgFB3pL0IJDw5JE/C6Xwsw4kaaaLqJV2pcc75qKCHygvNo8Lq816t95JmAA1MCaJvRTPpUTYCRqJ+tqKmAIR7QzM97wZ+IwqZUa0K5G6e6V+FvEzCMUuvZh02FIL7UrBbC5auFNCP4Ty6BoSqmmxrFtG63DgBBXHfVk7Dr6AkCPRTrV1bObxDTalMXAiM/YUU0s+ae7WeyxhH1H4BFxBfXwyzJbXTNgJ5TSM6x3LT4KKR+Y6jf1i6Ns+HlJeInsxk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(41300700001)(66946007)(66446008)(478600001)(316002)(64756008)(66476007)(66556008)(76116006)(91956017)(38100700002)(8676002)(8936002)(36756003)(5660300002)(86362001)(38070700009)(6486002)(110136005)(83380400001)(122000001)(2616005)(6506007)(71200400001)(53546011)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTlOMVJ2TGREd3huM1VHbnBrRnVBc3BRU2pMT29YY0pvUGp1ckY5VEdESSsz?=
 =?utf-8?B?bDJTYXNZaCtqeXJmWEwxOEU0M2k0V0F3Y242WVlCakdLcE1vY2pwMTlwblp4?=
 =?utf-8?B?dXBzK0FNQ1JEUUp1dlptQWM4SCtpNExueUpmUE1wYnE5VWJPM3Npc05OQWE2?=
 =?utf-8?B?MzZYVEM4R1dyMXFLNndlZk5DWU4rNHhIdkdBa3RSY2pWOXNNYzB5MTRybFoy?=
 =?utf-8?B?TEVwM3B4NXZ1eFJ1eTJrUlFhcUpHdTZDVzBVekdlVVpZZzVBMytyQXZRLzh0?=
 =?utf-8?B?b2EwdG9sOU1tOTNZdWxwQng2eDlON3BTZGRKR01ydkJ2MkxNMDBKMnBlRHdP?=
 =?utf-8?B?T2kwbXlQSFdLQ3FaaDRRUFlCOVhRS21DaW9CUUdEbGJLaHl6QzRSdkV6QnBn?=
 =?utf-8?B?TEJ6bWJUVUszZUV5Z1NSK09YS3Q2dUFoZkphVnB0MmJaaVpHazEvYzl4Qkty?=
 =?utf-8?B?RDdLU0VmWE1WbW1odGp1aDBJL3pYRCtQelp3ZmhkTmp6Ull6WFc4NzllU3Z4?=
 =?utf-8?B?QnhlanM2TlVLamViaXlnZ292UXVWS0FianMyQU9Vd09ZTndGTXJZUHM1WGR1?=
 =?utf-8?B?VVZweTB3NDBYNnRmN2x6RFcvY01XYWRlWEkxNzVzK0lDSWJGRTk4OHJSWVph?=
 =?utf-8?B?N0ZVK2xxdGh2OG8xTW12UWVnWVF3QytSaTVZQWpJYmEwaCs4TXd5UTVIK2pl?=
 =?utf-8?B?a1kyOGtBODRhZlI3TGRvRWJhZVBmLzQ0V2tNN3ZBdGltTXczYUtjZ3Z3UEFF?=
 =?utf-8?B?cU5EcXdKUXlSRnJueWxIR21yVXh0TGRCSzZrSEYwMjkxcUFSQXBYenlieEwz?=
 =?utf-8?B?RldWLzc1VEFsM0dWa0RlZTE3L0JSVFplanAzNG1WT2pPdmJFdUNhazE2THhj?=
 =?utf-8?B?UzVnUUFXZll5OHBHTUx6aHhXY1ljUHlYakJBblJvVjJqdFdQRDdOU1d3S3c3?=
 =?utf-8?B?N1VjcHJHQVRNK1hTeHVpL2ZLbXRsaDJvN2trU1BTK2JSOFhDU1RFL3RhcEtj?=
 =?utf-8?B?K2gwOTRSQzUrdUJIMHlqOXExWFVYOElzbTNnMnB1SFRlS0lTTUJmRURzVVI3?=
 =?utf-8?B?aU5ML1ZzNS9OcEo0RitHQTRoQ09WNjl3RTg4WGEvVmtsNTc1MnRrSE55bUR6?=
 =?utf-8?B?OU1qRXVoRUF6VE9NN0xMWVl5Si9HQ21Qb0FDQk1LYUhHTUVaOFV1RjlNaG5B?=
 =?utf-8?B?ZUpNUFBnYndXenpSM0twb2JramdPWDl1cFJwWmxRZ1J2aWFoSzhFVG5iTS9s?=
 =?utf-8?B?MzlkY0Zic0d2ZjlCa1IzbXBQblJvR2IrZ2N0WjVXMEZQbXRpZDBNMWl5blJ5?=
 =?utf-8?B?bnlYUDh4aldFUkkyUkllQjRrV3o3ZWE0U1pwNWN4UXJsOTI3UEp0ZDRVTGll?=
 =?utf-8?B?OEUzVTR4KytZTTNGQnY4OExmdkNqMU5BczNwbkU0UVN4MnliSktrVTFObHd2?=
 =?utf-8?B?ZW9IdVl0c1ZQaVlwSkpKY3kxeWNGM3lhNHBrcXR5RjNYTU9OSE9KbGNSMjZO?=
 =?utf-8?B?SkxRUm5hWGQxS0ozS0d2UkJ3TnFoNHdHRWpQRjZhWlZDK2xVdis5eDFBRXVm?=
 =?utf-8?B?ZFFTamhXVG5JWDlZaHZ6K1U0dW12aHJrQk9IVTh6N0pzMjlkMkxFMnRQb1RF?=
 =?utf-8?B?a2VUaUllSnNBZUtReDdWc3hSMldJRWY2THhtTEVhV0RCSm5qWmV0OUZ6R2Fa?=
 =?utf-8?B?SlUxM3lqVG1TYmlCWU5FMEJDek9KWHVnN2l0VkUyUGVncGFxQWdyN2MrVU1u?=
 =?utf-8?B?YTVGeFk0RDVaaUppUDZleVVzaitKSWM0SGFhTGZ0b202dmEzY0l0YnJTQmkx?=
 =?utf-8?B?TXladVNqbnpDV2pTbjIwYmZSc2k3czc0dnNtQldvYk55R2oxTmVSZzMzVU1s?=
 =?utf-8?B?R28zSkZpZDNDMnJFcWxxcjVvTUloczhOS3JYVEYrcW9VQkhCUkNqN2phUDVZ?=
 =?utf-8?B?QzhVRzVFck9EUjFta3BSWGdIMWtnbldjTEcrMFJ2OVQ0TmNSYjdOM09WSVJ3?=
 =?utf-8?B?VXUrV2kvZEd3dkx2ZU91TnRmY1loV2o4ZEtUUm5VNytzYU02TEVTYTFaNkE2?=
 =?utf-8?B?ckVxb042NmJtZ1BkUkIzcWNwcjhBYzZpckNxSE4wdU1KOXRhUGEzSHlmeEVI?=
 =?utf-8?B?b001TzFhZ0xRb2xuUXowNjFRbXhoZ2VpWTZXcEg1VXFxaTRXaytPbFd3bXBq?=
 =?utf-8?B?WXRZaW1nT2diVmpmaTVqZmVISWhnL1NoRDNEMWlyRTk5RVRKYUd0YlNHZ1FE?=
 =?utf-8?B?ZUhNL0c4R2tybzlaYTRWZENKVmh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <196FF6FB873EA5429D545DB2FD4D74DA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b572081-e9ef-4fbb-07bb-08dbdf0601d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:21:49.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUNr2BNLi5yq0RmsXFLcfcevhr42S+45qga3J7V3iwBmkaYXmpxcAQYDmldgRBZUxG9ofiVNMw9zFielmMcyPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTA2IGF0IDEyOjExIC0wODAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6DQo+IA0KPiBPbiAxMS82LzIzIDEwOjQ0IEFNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+
ID4gT24gTW9uLCAyMDIzLTExLTA2IGF0IDEwOjE4IC0wODAwLCBkYWkubmdvQG9yYWNsZS5jb23C
oHdyb3RlOg0KPiA+ID4gT24gMTEvNi8yMyA4OjMwIEFNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gPiA+IEhpIERhaSwNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFN1biwgMjAyMy0xMS0wNSBh
dCAxMToyNyAtMDgwMCwgZGFpLm5nb0BvcmFjbGUuY29twqB3cm90ZToNCj4gPiA+ID4gPiBIaSBU
cm9uZCwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXaGVuIHVubW9udGluZyBhIE5GUyBleHBvcnQs
IG5mc19mcmVlX3NlcnZlciBpcyBjYWxsZWQuIEluDQo+ID4gPiA+ID4gbmZzX2ZyZWVfc2VydmVy
LA0KPiA+ID4gPiA+IHdlIGNhbGwgcnBjX3NodXRkb3duX2NsaWVudChzZXJ2ZXItPmNsaWVudCkg
dG8ga2lsbCBhbGwNCj4gPiA+ID4gPiBwZW5kaW5nDQo+ID4gPiA+ID4gUlBDDQo+ID4gPiA+ID4g
dGFza3MNCj4gPiA+ID4gPiBhbmQgd2FpdCBmb3IgdGhlbSB0byB0ZXJtaW5hdGUgYmVmb3JlIGNv
bnRpbnVlIG9uIHRvIGNhbGwNCj4gPiA+ID4gPiBuZnNfcHV0X2NsaWVudC4NCj4gPiA+ID4gPiBJ
biBuZnNfcHV0X2NsaWVudCwgaWYgdGhlIHJlZmNvdW5mIGlzIGRyZWNlbWVudGVkIHRvIDAgdGhl
bg0KPiA+ID4gPiA+IHdlDQo+ID4gPiA+ID4gY2FsbA0KPiA+ID4gPiA+IG5mc19mcmVlX2NsaWVu
dCB3aGljaCBjYWxscyBycGNfc2h1dGRvd25fY2xpZW50KGNscC0NCj4gPiA+ID4gPiA+IGNsX3Jw
Y2NsaWVudCkgdG8NCj4gPiA+ID4gPiBraWxsIGFsbCBwZW5kaW5nIFJQQyB0YXNrcyB0aGF0IHVz
ZSBuZnNfY2xpZW50LT5jbF9ycGNjbGllbnQNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IHNlbmQN
Cj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiByZXF1ZXN0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IE5vcm1hbGx5IHRoaXMgd29ya3MgZmluZS4gSG93ZXZlciwgZHVlIHRvIHNvbWUgcmFjZQ0KPiA+
ID4gPiA+IGNvbmRpdGlvbnMsDQo+ID4gPiA+ID4gaWYNCj4gPiA+ID4gPiB0aGVyZSBhcmUNCj4g
PiA+ID4gPiBkZWxlZ2F0aW9uIHJldHVybiBSUEMgdGFza3MgaGF2ZSBub3QgYmVlbiBleGVjdXRl
ZCB5ZXQgd2hlbg0KPiA+ID4gPiA+IG5mc19mcmVlX3NlcnZlcg0KPiA+ID4gPiA+IGlzIGNhbGxl
ZCB0aGVuIHRoaXMgY2FuIGNhdXNlIHN5c3RlbSB0byBjcmFzaCB3aXRoIGdlbmVyYWwNCj4gPiA+
ID4gPiBwcm90ZWN0aW9uDQo+ID4gPiA+ID4gZmF1bHQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
VGhlIGNvbmRpdGlvbnMgdGhhdCBjYW4gY2F1c2UgdGhlIGNyYXNoIGFyZTogKDEpIHRoZXJlIGFy
ZQ0KPiA+ID4gPiA+IHBlbmRpbmcNCj4gPiA+ID4gPiBkZWxlZ2F0aW9uDQo+ID4gPiA+ID4gcmV0
dXJuIHRhc2tzIGNhbGxlZCBmcm9tIG5mczRfc3RhdGVfbWFuYWdlciB0byByZXR1cm4gaWRsZQ0K
PiA+ID4gPiA+IGRlbGVnYXRpb25zIGFuZA0KPiA+ID4gPiA+ICgyKSB0aGUgbmZzX2NsaWVudCdz
IGF1X2ZsYXZvciBpcyBlaXRoZXIgUlBDX0FVVEhfR1NTX0tSQjVJDQo+ID4gPiA+ID4gb3INCj4g
PiA+ID4gPiBSUENfQVVUSF9HU1NfS1JCNVANCj4gPiA+ID4gPiBhbmQgKDMpIHRoZSBjYWxsIHRv
IG5mc19pZ3JhYl9hbmRfYWN0aXZlLCBmcm9tDQo+ID4gPiA+ID4gX25mczRfcHJvY19kZWxlZ3Jl
dHVybiwgZmFpbHMNCj4gPiA+ID4gPiBmb3IgYW55IHJlYXNvbnMgYW5kICg0KSB0aGVyZSBpcyBh
IHBlbmRpbmcgUlBDIHRhc2sgcmVuZXdpbmcNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBsZWFz
ZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaW5jZSB0aGUgZGVsZWdhdGlvbiByZXR1cm4gdGFz
a3Mgd2VyZSBjYWxsZWQgd2l0aCAnaXNzeW5jID0NCj4gPiA+ID4gPiAwJw0KPiA+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiA+IHJlZmNvdW50IG9uDQo+ID4gPiA+ID4gbmZzX3NlcnZlciB3ZXJlIGRyb3Bw
ZWQgKGluDQo+ID4gPiA+ID4gbmZzX2NsaWVudF9yZXR1cm5fbWFya2VkX2RlbGVnYXRpb25zDQo+
ID4gPiA+ID4gYWZ0ZXIgUlBDIHRhc2sNCj4gPiA+ID4gPiB3YXMgc3VibWl0ZWQgdG8gdGhlIFJQ
QyBsYXllcikgYW5kIHRoZSBuZnNfaWdyYWJfYW5kX2FjdGl2ZQ0KPiA+ID4gPiA+IGNhbGwNCj4g
PiA+ID4gPiBmYWlscywgdGhlc2UNCj4gPiA+ID4gPiBSUEMgdGFza3MgZG8gbm90IGhvbGQgYW55
IHJlZmNvdW50IG9uIHRoZSBuZnNfc2VydmVyLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoZW4g
bmZzX2ZyZWVfc2VydmVyIGlzIGNhbGxlZCwgcnBjX3NodXRkb3duX2NsaWVudChzZXJ2ZXItDQo+
ID4gPiA+ID4gPiBjbGllbnQpDQo+ID4gPiA+ID4gZmFpbHMgdG8NCj4gPiA+ID4gPiBraWxsIHRo
ZXNlIGRlbGVnYXRpb24gcmV0dXJuIHRhc2tzIHNpbmNlIHRoZXNlIHRhc2tzIHVzaW5nDQo+ID4g
PiA+ID4gbmZzX2NsaWVudC0+Y2xfcnBjY2xpZW50DQo+ID4gPiA+ID4gdG8gc2VuZCB0aGUgcmVx
dWVzdHMuIFdoZW4gbmZzX3B1dF9jbGllbnQgaXMgY2FsbGVkLA0KPiA+ID4gPiA+IG5mc19mcmVl
X2NsaWVudA0KPiA+ID4gPiA+IGlzIG5vdA0KPiA+ID4gPiA+IGNhbGxlZCBiZWNhdXNlIHRoZXJl
IGlzIGEgcGVuZGluZyBsZWFzZSByZW5ldyBSUEMgdGFzayB3aGljaA0KPiA+ID4gPiA+IHVzZXMN
Cj4gPiA+ID4gPiBuZnNfY2xpZW50LT5jbF9ycGNjbGllbnQNCj4gPiA+ID4gPiB0byBzZW5kIHRo
ZSByZXF1ZXN0IGFuZCBhbHNvIGFkZHMgYSByZWZjb3VudCBvbiB0aGUNCj4gPiA+ID4gPiBuZnNf
Y2xpZW50Lg0KPiA+ID4gPiA+IFRoaXMNCj4gPiA+ID4gPiBhbGxvd3MNCj4gPiA+ID4gPiB0aGUg
ZGVsZWdhdGlvbiByZXR1cm4gdGFza3MgdG8gc3RheSBhbGl2ZSBhbmQgY29udGludWUgb24NCj4g
PiA+ID4gPiBhZnRlcg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IG5mc19zZXJ2ZXINCj4gPiA+
ID4gPiB3YXMgZnJlZWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSd2ZSBzZWVuIHRoZSBORlMg
Y2xpZW50IHdpdGggNS40IGtlcm5lbCBjcmFzaGVzIHdpdGggdGhpcw0KPiA+ID4gPiA+IHN0YWNr
DQo+ID4gPiA+ID4gdHJhY2U6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gISMgMCBbZmZmZmI5M2I4
ZmJkYmQ3OF0gbmZzNF9zZXR1cF9zZXF1ZW5jZSBbbmZzdjRdIGF0DQo+ID4gPiA+ID4gZmZmZmZm
ZmZjMGYyN2U0MCBmcy9uZnMvbmZzNHByb2MuYzoxMDQxOjANCj4gPiA+ID4gPiDCoMKgwqAgIyAx
IFtmZmZmYjkzYjhmYmRiZGI4XSBuZnM0X2RlbGVncmV0dXJuX3ByZXBhcmUgW25mc3Y0XQ0KPiA+
ID4gPiA+IGF0DQo+ID4gPiA+ID4gZmZmZmZmZmZjMGYyOGFkMSBmcy9uZnMvbmZzNHByb2MuYzo2
MzU1OjANCj4gPiA+ID4gPiDCoMKgwqAgIyAyIFtmZmZmYjkzYjhmYmRiZGQ4XSBycGNfcHJlcGFy
ZV90YXNrIFtzdW5ycGNdIGF0DQo+ID4gPiA+ID4gZmZmZmZmZmZjMDVlMzNhZiBuZXQvc3VucnBj
L3NjaGVkLmM6ODIxOjANCj4gPiA+ID4gPiDCoMKgwqAgIyAzIFtmZmZmYjkzYjhmYmRiZGU4XSBf
X3JwY19leGVjdXRlIFtzdW5ycGNdIGF0DQo+ID4gPiA+ID4gZmZmZmZmZmZjMDVlYjUyNw0KPiA+
ID4gPiA+IG5ldC9zdW5ycGMvc2NoZWQuYzo5MjU6MA0KPiA+ID4gPiA+IMKgwqDCoCAjIDQgW2Zm
ZmZiOTNiOGZiZGJlNDhdIHJwY19hc3luY19zY2hlZHVsZSBbc3VucnBjXSBhdA0KPiA+ID4gPiA+
IGZmZmZmZmZmYzA1ZWI4ZTAgbmV0L3N1bnJwYy9zY2hlZC5jOjEwMTM6MA0KPiA+ID4gPiA+IMKg
wqDCoCAjIDUgW2ZmZmZiOTNiOGZiZGJlNjhdIHByb2Nlc3Nfb25lX3dvcmsgYXQNCj4gPiA+ID4g
PiBmZmZmZmZmZjkyYWQ0Mjg5DQo+ID4gPiA+ID4ga2VybmVsL3dvcmtxdWV1ZS5jOjIyODE6MA0K
PiA+ID4gPiA+IMKgwqDCoCAjIDYgW2ZmZmZiOTNiOGZiZGJlYjBdIHdvcmtlcl90aHJlYWQgYXQg
ZmZmZmZmZmY5MmFkNTBjZg0KPiA+ID4gPiA+IGtlcm5lbC93b3JrcXVldWUuYzoyNDI3OjANCj4g
PiA+ID4gPiDCoMKgwqAgIyA3IFtmZmZmYjkzYjhmYmRiZjEwXSBrdGhyZWFkIGF0IGZmZmZmZmZm
OTJhZGFjMDUNCj4gPiA+ID4gPiBrZXJuZWwva3RocmVhZC5jOjI5NjowDQo+ID4gPiA+ID4gwqDC
oMKgICMgOCBbZmZmZmI5M2I4ZmJkYmY1OF0gcmV0X2Zyb21fZm9yayBhdCBmZmZmZmZmZjkzNjAw
MzY0DQo+ID4gPiA+ID4gYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzozNTU6MA0KPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgIA0KPiA+ID4gPiA+IFdoZXJlIHRoZSBwYXJhbXMgb2YgbmZz
NF9zZXR1cF9zZXF1ZW5jZToNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBjbGllbnQgPSAoc3Ry
dWN0IG5mc19jbGllbnQgKikweDRkNTQxNThlYmM2Y2ZjMDENCj4gPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoCBhcmdzID0gKHN0cnVjdCBuZnM0X3NlcXVlbmNlX2FyZ3MNCj4gPiA+ID4gPiAqKTB4ZmZm
Zjk5ODQ4N2Y4NTgwMA0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJlcyA9IChzdHJ1Y3QgbmZz
NF9zZXF1ZW5jZV9yZXMgKikweGZmZmY5OTg0ODdmODU4MzANCj4gPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoCB0YXNrID0gKHN0cnVjdCBycGNfdGFzayAqKTB4ZmZmZjk5N2Q0MWRhN2QwMA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFRoZSAnY2xpZW50JyBwb2ludGVyIGlzIGludmFsaWQgc2luY2UgaXQg
d2FzIGV4dHJhY3RlZCBmcm9tDQo+ID4gPiA+ID4gZF9kYXRhLQ0KPiA+ID4gPiA+ID4gcmVzLnNl
cnZlci0+bmZzX2NsaWVudA0KPiA+ID4gPiA+IGFuZCB0aGUgbmZzX3NlcnZlciB3YXMgZnJlZWQu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSd2ZSByZXZpZXdlZCB0aGUgbGF0ZXN0IGtlcm5lbCA2
LjYtcmM3LCBldmVuIHRob3VnaCB0aGVyZQ0KPiA+ID4gPiA+IGFyZQ0KPiA+ID4gPiA+IG1hbnkN
Cj4gPiA+ID4gPiBjaGFuZ2VzDQo+ID4gPiA+ID4gc2luY2UgNS40IEkgY291bGQgbm90IHNlZSBh
bnkgYW55IGNoYW5nZXMgdG8gcHJldmVudCB0aGlzDQo+ID4gPiA+ID4gc2NlbmFyaW8gdG8NCj4g
PiA+ID4gPiBoYXBwZW4NCj4gPiA+ID4gPiBzbyBJIGJlbGlldmUgdGhpcyBwcm9ibGVtIHN0aWxs
IGV4aXN0cyBpbiA2LjYtcmM3Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEknZCBsaWtlIHRvIGdl
dCB5b3VyIG9waW5pb24gb24gdGhpcyBwb3RlbnRpYWwgaXNzdWUgd2l0aCB0aGUNCj4gPiA+ID4g
PiBsYXRlc3QNCj4gPiA+ID4gPiBrZXJuZWwNCj4gPiA+ID4gPiBhbmQgaWYgdGhlIHByb2JsZW0g
c3RpbGwgZXhpc3RzIHRoZW4gd2hhdCdzIHRoZSBiZXN0IHdheSB0bw0KPiA+ID4gPiA+IGZpeA0K
PiA+ID4gPiA+IGl0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiBuZnNfaW5vZGVfZXZpY3RfZGVsZWdh
dGlvbigpIHNob3VsZCBiZSBjYWxsaW5nDQo+ID4gPiA+IG5mc19kb19yZXR1cm5fZGVsZWdhdGlv
bigpIHdpdGggdGhlIGlzc3luYyBmbGFnIHNldCwgd2hlcmVhcw0KPiA+ID4gPiBuZnNfc2VydmVy
X3JldHVybl9tYXJrZWRfZGVsZWdhdGlvbnMoKSBzaG91bGQgYmUgaG9sZGluZyBhDQo+ID4gPiA+
IHJlZmVyZW5jZSB0bw0KPiA+ID4gPiB0aGUgaW5vZGUgYmVmb3JlIGl0IGNhbGxzIG5mc19lbmRf
ZGVsZWdhdGlvbl9yZXR1cm4oKS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNvIHdoZXJlIGlzIHRoaXMg
Y29tYmluYXRpb24gbm8gaW5vZGUgcmVmZXJlbmNlICsgaXNzeW5jPTANCj4gPiA+ID4gb3JpZ2lu
YXRpbmcNCj4gPiA+ID4gZnJvbT8NCj4gPiA+IFRoZSBpbm9kZSByZWZlcmVuY2Ugd2FzIGRyb3Bw
ZWQgaW4NCj4gPiA+IG5mc19zZXJ2ZXJfcmV0dXJuX21hcmtlZF9kZWxlZ2F0aW9ucw0KPiA+ID4g
YWZ0ZXIgcmV0dXJuaW5nIGZyb20gbmZzX2VuZF9kZWxlZ2F0aW9uX3JldHVybi4NCj4gPiA+IA0K
PiA+ID4gSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoeSBkbyB3ZSBjb250aW51ZSBvbiB3aXRo
IHRoZQ0KPiA+ID4gZGVsZWdhdGlvbg0KPiA+ID4gcmV0dXJuDQo+ID4gPiBpbiBfbmZzNF9wcm9j
X2RlbGVncmV0dXJuIGFmdGVyIG5mc19pZ3JhYl9hbmRfYWN0aXZlIGZhaWxzIGFuZA0KPiA+ID4g
aXNzeW5jDQo+ID4gPiA9IDA/DQo+ID4gSSdtIG5vdCBzZWVpbmcgaG93IHRoYXQgY2FzZSBjYW4g
b2NjdXIgYXQgYWxsLg0KPiANCj4gU2luY2UgdGhpcyBjcmFzaCBpcyBhbG1vc3QgcmVwcm9kdWNp
YmxlIHdpdGggNS40IHVuZGVyIGEgdGVzdCBzZXR1cCwNCj4gSSBjYW4gYWRkIGEgcGF0Y2ggdG8g
Y3Jhc2ggdGhlIHN5c3RlbSB3aGVuIG5mc19pZ3JhYl9hbmRfYWN0aXZlIGZhaWxzDQo+IGFuZCBp
c3N5bmMgPSAwLg0KPiANCj4gPiANCj4gPiBJZiBuZnNfc2VydmVyX3JldHVybl9tYXJrZWRfZGVs
ZWdhdGlvbnMoKSBpcyBob2xkaW5nIGEgcmVmZXJlbmNlIHRvDQo+ID4gdGhlDQo+ID4gc3VwZXJi
bG9jayBhbmQgdG8gdGhlIGlub2RlIGFjcm9zcyB0aGUgY2FsbCB0bw0KPiA+IG5mc19lbmRfZGVs
ZWdhdGlvbl9yZXR1cm4oKSwgdGhlbiBpdCBzaG91bGQgbm90IGJlIHBvc3NpYmxlIGZvciB0aGUN
Cj4gPiBjYWxsIHRvIG5mc19pZ3JhYl9hbmRfYWN0aXZlKCkgdG8gZmFpbA0KPiANCj4gWWVzLCB0
aGlzIGlzIHdoZXJlIEknbSBzdHJ1Z2dsZSB0byBmaW5kIG91dCBob3cgY2FuDQo+IG5mc19pZ3Jh
Yl9hbmRfYWN0aXZlDQo+IGZhaWxzIHdoaWxlIHdlIGFscmVhZHkgaGFkIGEgcmVmY291bnQgb24g
dGhlIG5mc19zZXJ2ZXIuIFRoZXJlIG11c3QNCj4gYmUNCj4gYSBzY2VuYXJpbyB0aGF0IGNhdXNl
cyBuZnNfaWdyYWJfYW5kX2FjdGl2ZSB0byBmYWlsIHNpbmNlIHRoZQ0KPiBuZnM0X2RlbGVncmV0
dXJuZGF0YS0+aW5vZGUgaXMgTlVMTCBpbiB0aGUgY29yZSBkdW1wLg0KPiANCj4gSXMgaXQgcG9z
c2libGUgdGhhdCB0aGUgaWdyYWIgaW4gbmZzX2lncmFiX2FuZF9hY3RpdmUgZmFpbHMsIHRoZQ0K
PiBpbm9kZQ0KPiB3YXMgbWFya2VkIHdpdGggSV9GUkVFSU5HIHwgSV9XSUxMX0ZSRUU/DQo+IA0K
DQpUaGUgaW5vZGUgc2hvdWxkIG5ldmVyIGJlIG1hcmtlZCB3aXRoIGVpdGhlciBJX0ZSRUVJTkcg
b3IgSV9XSUxMX0ZSRUUNCnVudGlsIHRoZSBjYWxsIHRvIGlwdXRfZmluYWwoKSwgd2hpY2ggaXNu
J3QgY2FsbGVkIHVudGlsIHRoZSBpbm9kZQ0KaV9jb3VudCBpcyB6ZXJvLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
