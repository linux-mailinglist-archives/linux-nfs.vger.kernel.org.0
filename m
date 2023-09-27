Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34207B0F43
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 01:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI0XA1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 19:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI0XA0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 19:00:26 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2100.outbound.protection.outlook.com [40.107.212.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B257B7
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 16:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP9iEaRGS/kMhVSYpOBN8BA3GE9RAo0K7LCbxwJIS56w5T1j0wcTCxMtnK3D3lf0STanj6s8YMKvosTUndtxXwhAgF4Pg3NEKgqqbmh/HxVQMa2OaJMjyZMG1YTrnyNlDEvq/LoCEZdsZ+zW+kAmwHMmah0hBMHZ9ArWIDTtx48Ykz149bh8kxz17KE1EDL/u2b0O+18jNZnYaxToV05sIvapmzDGVSvZgPRbuOGt1PgWQvuAGfC7AyygcCYU31KHOHwM0mgxAfV2XOUlgCbSZ48GXUGr1iS2F/JjQGrUyFcs6lgBHCXs92LpYPBC7mXVGh2rv3ry8lAP48k11tHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySgrdZkzRgQUGXCyu3xueCNifKqzsYZH7utjgunEUxU=;
 b=FhFoGI4FM1olD76nX3I0Xld7tMw6LDwSDBguwvSc3/5OU4JrH2PeYa/7hzGLPsCoxUHGEGl//Vbukf/vTBfFezh0CD0gjNOHCkKkhqTAydzEbC0lpaxfPwfEun9iy0cRkXEIThOOLQtPNXabOElNLG8ZKGZ1eTOyCp9K2Jg9btGxvfwrIYmw+m5cFgM4UpjHxXccvxuS5MX5bhzs7PrmGcwDOncyz8ZBUWP/NEbMV0RcC4tiTljuKELkwze9QbH9zqeVC/9k5Ps4p6P/duXiWLXZ5fkhomyhU2OrbcFyT2IV7y12ZvjX3hU03v2lB/APT/LzhLKRJmoVPdmLdMb6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySgrdZkzRgQUGXCyu3xueCNifKqzsYZH7utjgunEUxU=;
 b=bFndLfhJvytGycelBsJ7v/qmeGNISqA345I5DBS0lDDPSBLFi+blF7rivX44ueEs3NcxygJchRq6DdJNydBcRJC5Kh8Xffq91QwevFysgHruluB2YaO+hdlaQ6lT93tfjf+jJcr46C+NmSuzflpY8HUXTeBJf6TGN5mEMwWuFwM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB6391.namprd13.prod.outlook.com (2603:10b6:510:2ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 23:00:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 23:00:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "steved@redhat.com" <steved@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: help with understanding match_fsid() errors in nfs-utils
Thread-Topic: help with understanding match_fsid() errors in nfs-utils
Thread-Index: AQHZ8OfE9RNLBpL0OUu1L/KY8Cstj7AvSvOA
Date:   Wed, 27 Sep 2023 23:00:18 +0000
Message-ID: <7e00fd2c44df1bc34c219902498d95cb811de850.camel@hammerspace.com>
References: <169578061136.5939.6687963921006986794@noble.neil.brown.name>
In-Reply-To: <169578061136.5939.6687963921006986794@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB6391:EE_
x-ms-office365-filtering-correlation-id: fc5ae3d8-7728-45f2-e845-08dbbfad8544
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xTgU8bTKjBeRf6sGHlkRgfx7F0INXZzpZ0JF3cxJkx/ZfKDlkAsSuvcdLmXnhTKqFu05OFNFZaVpv6/baZJLD3qrzAlyPLXaCA01v01l06jemV5r+1iGcQ68zreFk4/qCUwhBL8B1BHpijS7P+oLhYvhJAyNw8bwAMLAu7ht+0qUx6OVLwRbLGwhUsEgB5JYMPMlNdVGlbuwRM5f2ZrkSwlTSfFu8H0o5hNzBVQzSCAwZbBElkB/jTYRlfaew3Opjq7s37sCpUAc7mtQgamo/1jIjRRcRehyzcOolL9QjnfNeWBEEWUTrwWf/yeRTDgLe8gaj0ycFZ/ga2Q7+cRmKjkhb0AjsGFLX38e/aMvtxkAaArW8Zjp1JxszOO9ViLpZYg1VuYzWgnRo6t+xlhNeJE4EeOv1pzWcGWtl3GjYZI+ncqk+pSSRzSCt9HdKBfm1otTJeXaHvYJLfSh5J6HTG45vge5vOzsKOZnXb1ZaX4rXFx+o3f9Yz7dHb6FoOjKijnBdAC2+oEqZrqRMfXrcEYK1qVovZqCEgi537JAJlBKWfLzppYYIlxCrKqgimG1q22QpthxNVHTcWHh85AI9B3KaQktunWd0Gl7NjWanMN1bo8BnYE2Jo2W0QExQfWXZ3Ll1QYF/0MLMauf1crnrPADKDFLEoWFS3XLwLhXtyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39830400003)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700005)(6486002)(71200400001)(6506007)(478600001)(6512007)(83380400001)(26005)(2616005)(41300700001)(5660300002)(64756008)(66946007)(8676002)(66556008)(66476007)(110136005)(8936002)(66446008)(4326008)(36756003)(2906002)(316002)(76116006)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXRJYzFFQmJsNlh6UTZLUWcxK09SN3RVNGlQc1c0QkJ2czZTQ0Q2MzB3VUt6?=
 =?utf-8?B?QVJwaWhic01JL0lFVnFTVlYvSHlLeUZoa3RKaGFSUVhITGltYjBWRWhDYnh5?=
 =?utf-8?B?SG5rZS91TVJzQmp3RTV5bDlPR0lBZW8rMHAzUmFqbzI1bXRNSG9Ddit2RkhZ?=
 =?utf-8?B?N285UExHQjBwaThmUFJTZzZJNnZEd0FlSnZISUs2UlU4UmlFRHY4YmlhV2Q3?=
 =?utf-8?B?bHJzK25LRlZ1encySEhPOXFoZ0U0aWtjV3g2MXovRlI4K3VxS1ZhL0lrcUtY?=
 =?utf-8?B?enFIK3NSSDlvMEIxTzIzY3hZZXF2VmZZc0ViaDdPOFEwcUtrdEJrRDdIQ01U?=
 =?utf-8?B?ZVpNcTZ4a0VzYk1xSjBWVWtsQ0Z2d3lPcElVYVFMUlg1SmxBZTVtQk5YV2JD?=
 =?utf-8?B?NlBITVJEZFFNbHVLbHZCaU50RE5uQUhBdGgrVXc5ZktpZFc5R0h0bUtMbUxy?=
 =?utf-8?B?eWl3Tm5SeWhhYXpsRm9oTW11VjgxS2oxUiswZFRVeVkrY2EvVFgvcGk1eE1n?=
 =?utf-8?B?bG5DWVRXREw5dFNBOEN2aEhtU0ZsOE4vcS9jN2lTWDh3eHFHeStLU2hxTEIw?=
 =?utf-8?B?RDkyeThFYmNjRzZJZkxtVWtVUlIya1ExeVFIZzlnN3dTYzR5ekVzQTBlRVVs?=
 =?utf-8?B?YVdhUjRWdzZKRDM3RFU1UWY4RExqSHVZSzBpZGo2a2hYSml4WUFPNFNYZ0pY?=
 =?utf-8?B?ampMZGtvV3pOVTJTU0RibnBYMjBJdEJnL1BMOUFYdFF1blVHeW16eHkyK29U?=
 =?utf-8?B?UnBEcUlHa0RVOGxJcnZxc1VQcHZDUGcwSUU0MGYwbmRlV0tQMGRzU1VjOS9a?=
 =?utf-8?B?T2MzaTFHZCtRWm4wV0lPS2RKNjBJb1o2R0p6MUlLbU9RSVpJYisySmVkSHRm?=
 =?utf-8?B?TmtXSnowRTdRUDc3VU90dzEySWlQMUkyb1c0UDlzZjR3dW1SQjAxVjVxbHNh?=
 =?utf-8?B?d0xIcDlyRWptemxXanlrRjdYY3dJSUpyS1VsVkd3TzlESWx4aWVIWHA4b1h3?=
 =?utf-8?B?ZS81T0tZS1dJTlBrNjd6VnVDbUFxMjNNSTM0SnZ0UFMwSTdTcXZVR1U1SVZU?=
 =?utf-8?B?MEs0N1dNa05nNllGZXEyNG40WlFWYU44RUtzZXhKekkxL0dGSnlUcTUzT2Zw?=
 =?utf-8?B?bVk2NHBVa3R0MjFISENvZVV6ZnE3NnNDSEkzOFFOUWJmSTlETHhmNkIrUzN4?=
 =?utf-8?B?TWc3cks2Q0FmMjNmUUdoS0FXUlJ2NFdhbktCVWRkZ0VrVFplMzhzSTR0aG5O?=
 =?utf-8?B?WXp0YjhmbHcvbDl6bFBMd2xuRzRPeEJKNklNQ2FLVTRBZ3ZNMmxJUXYzK0NC?=
 =?utf-8?B?SWdoWFM1SzJxcS9QSWRyM21xcFVleHllZjEyeWZ4U0R3dnVrTmZlMzRGNkN2?=
 =?utf-8?B?MnkvU25wZzFQS3dKWmpER2ZnaVk0NTBYVjZ2UG53Zll5ZGN0RkVBanAzRWJt?=
 =?utf-8?B?R3Budm8rc2NFVENhYWdIclpLd3JDQ0lZZDlQQTNPZzhUZ1RMUE1DV3FXYXRN?=
 =?utf-8?B?d3A0aXIrTXMreCt5MTFjdU14a3owdW9HYjB2TzQwRHVWWCtIQk54NUNWdGts?=
 =?utf-8?B?K1phcVNTTW1lR3NMSFdub0tZV2MxS2R0YjFJWExBYVpnNEpXU1ZmaE5scVdG?=
 =?utf-8?B?dis2NG0xbGNVWDZMMmNmVmEyVSsyNkRlZHQ0QXdsd2JEdkJtZVN5dHRMdlFV?=
 =?utf-8?B?UVpnNXMrNGU0UzBZNHlQZW9BZ3h6dW5sNjhhSnRzZGVBTm9wSitwbE93NUtS?=
 =?utf-8?B?YXkwOGdzd3A0QTB3dVdPT3lQcytLYjk4NXd1dm9pY29nemVIZVpwa3ozV1hr?=
 =?utf-8?B?SXhPRHFvU2dXdWZGaklKYkFXMjFNeE9kMktSZHRXWmxKUzlwZEdJbHRIeFhu?=
 =?utf-8?B?b05qT0t5NEZhUEN3YTQ2NGFoVGViejdNM2ZraE1UWlhZUzQ3VHFkQUdtaGRM?=
 =?utf-8?B?dVY2TXlJSVAreGpFNFYxajVVUnlwMk1jMUtGU3pwc3JQZk9pdXVxT3BBOXVo?=
 =?utf-8?B?Z3h2UWlVZGRwTmd3M2tjZ292U0xZSVJXbHFXL1NNcFU1RzRuV2xOZDVwMFlz?=
 =?utf-8?B?RFVwN05hMXR4RDF6M3lKemJHK2lBNTkrVVg2NEtmeGVhN0ZaVU8vdGNwb0M2?=
 =?utf-8?B?eW13aXN1TlNFY1EyN0VlWFRpSFdKWEwxYS9OTU9ZVmQ1R0d0TVZCYVlqMXIz?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A83A6D5BFAB9E4B998D05343CA2821E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5ae3d8-7728-45f2-e845-08dbbfad8544
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 23:00:18.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sc0oNh7o1vsp79yysucOSLg5P0RKassss0Dh3XRaNyTdIZuQr1gtNRWawhSolfL+xAMJQPtJNJiLVFCzKoiIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTI3IGF0IDEyOjEwICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBoaSBUcm9uZCwNCj4gwqBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQNCj4gDQo+IMKgQ29tbWl0
IDc2YzIxZTNmNzBhOCAoIm1vdW50ZDogQ2hlY2sgdGhlIHN0YXQoKSByZXR1cm4gdmFsdWVzIGlu
DQo+IG1hdGNoX2ZzaWQoKSIpDQo+IA0KPiDCoGluIG5mcy11dGlscy4NCj4gDQo+IMKgVGhlIGVm
ZmVjdCBvZiB0aGlzIHBhdGNoIGlzIHRoYXQgaWYgYSAnc3RhdCcgb2YgYW55IHBhdGggaW4NCj4g
wqAvZXRjL2V4cG9ydHMgb3IgYW55IG1vdW50cG9pbnQgYmVsb3cgYW55IHBhdGggbWFya2VkIGNy
b3NzbW50IGZhaWxzDQo+IMKgd2l0aCBhbiBlcnJvciBvdGhlciB0aGFuIG9uZSBvZiBhIHNtYWxs
IHNldCwgdGhlbiB0aGUgZnNpZCB0byBwYXRoDQo+IMKgbG9va3VwIGFib3J0cyB3aXRob3V0IHJl
cG9ydGluZyBhbnl0aGluZyB0byB0aGUga2VybmVsLCBzbyB0aGUNCj4ga2VybmVsDQo+IMKgZG9l
c24ndCByZXBseSB0byB0aGUgY2xpZW50IGFuZCB0aGUgbW91bnQgYXR0ZW1wdCBibG9ja3MNCj4g
aW5kZWZpbml0ZWx5Lg0KPiANCj4gwqBJIGhhdmUgc2VlbiB0aGlzIGhhcHBlbiB3aGVuICIvIiBp
cyBleHBvcnRlZCBjcm9zc21udCwgYW5kIHdoZW4gYQ0KPiBzdGF0DQo+IMKgb2YgL3J1bi91c2Vy
LzEwMDAvZG9jIHJldHVybnMgRUFDQ0VTLsKgIFRoaXMgaXMgYSAiZnVzZSIgbW91bnQgZm9yDQo+
IHVzZXINCj4gwqAxMDAwLCBhbmQgcHJlc3VtYWJseSBpdCByZWplY3RzIGFueSBhY2Nlc3MgZnJv
bSBhbnkgb3RoZXIgdXNlci4NCj4gDQo+IMKgQ291bGQgeW91IHBsZWFzZSBoZWxwIG1lIHVuZGVy
c3RhbmQgd2hhdCB0aGlzIHBhdGNoIHdhcyB0cnlpbmcgdG8NCj4gwqBhY2hpZXZlP8KgIFdoYXQg
c29ydHMgb2YgZXJyb3JzIHdlcmUgeW91IGV4cGVjdGluZyB0aGlzIHRvIGNhdGNoPw0KPiDCoFdv
dWxkIGl0IG1ha2Ugc2Vuc2UgdG8gc2lsZW50bHkgaWdub3JlIHRoZSBzdGF0IGZhaWx1cmUgZm9y
IHBhdGhzDQo+IHRoYXQNCj4gwqB3ZXJlIGZvdW5kIHdoZW4gc2Nhbm5pbmcgdGhlIG1vdW50IHRh
YmxlLCBhbmQgb25seSB0YWtlIHRoZSBtb3JlDQo+IMKgZHJhc3RpYyBhY3Rpb24gZm9yIHBhdGhz
IGV4cGxpY2l0bHkgbGlzdGVkIGluIC9ldGMvZXhwb3J0cyA/Pw0KPiANCj4gDQoNClRoZSBwb2lu
dCBpcyB0aGF0IGlmIHRoZSBmaWxlc3lzdGVtIGlzIHJlLWV4cG9ydGVkIE5GUywgYW5kIHlvdSBt
b3VudA0KYXMgJ3NvZnRlcnInIGluIG9yZGVyIHRvIGF2b2lkIGhhbmdpbmcgeW91ciBrbmZzZCBz
ZXJ2ZXIgb24gZXBoZW1lcmFsDQplcnJvcnMsIHRoZW4geW91IGhhdmUgdG8gYmUgbW9yZSBjYXJl
ZnVsIGFib3V0IHdoaWNoIGVycm9ycyBhcmUgZmF0YWwsDQphbmQgaGVuY2UgbmVlZCB0byBiZSBw
cm9wYWdhdGVkIHRvIHRoZSBrZXJuZWwgZXhwb3J0L3BhdGggY2FjaGUsIGFuZA0Kd2hpY2ggb25l
cyBhcmUganVzdCB0ZW1wb3JhcnkgZHVlIHRvIGEgbmV0d29yayBwYXJ0aXRpb24gb3Igc2VydmVy
DQpyZWJvb3QuDQoNCkhlbmNlIHRoZSBjcmVhdGlvbiBvZiBwYXRoX2xvb2t1cF9lcnJvcigpIHdo
aWNoIGRpZmZlcmVudGlhdGVzIGJldHdlZW4NCnRoZSB0d28gY2FzZXMuDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
