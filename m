Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740BD5BD44B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Sep 2022 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiISR7l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiISR7j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 13:59:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49082601
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 10:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb0VEHcnPL42GCEbtRtbbjtAYoqp/h15nLJODoEWM9mTFH4OH5EhsTnIX+f6ZxBLviv1Ek9S+xkCZ7nFpJYGRpjZH0gr59SSN6CJ/5y50WhkEgTaS/+zw0okxl5MaNxl1TWx3bGOfW2lZy5gr0kjGsB2vQfiQa94jB78wXO7WKAB2ESl02JNG4lzEWdMBfY00YBfeqygN/NgWHtSElkcF0LmpcQFWPNnsofbyqLpAUa2TRK2qOOTn3w79c7Y5N3b4VuyC4o0J0t6OQlupHD213FKxOBR29hP9qkat/7CyEkx2i+IQE/2Vo4qVCeNDKHupbblKLWaWIdB1vU31eOPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz/PYa3gyld3AH2vdKGB/YgLqRPLeJVy3NJGQFtUAy0=;
 b=FT4f9nHHsOPMw/pTKaNXZzX5aLHcBKKu3vXWx4oGSbKp47aeBng0UdNUhuPG6Ehx6z0X3B4ZsQ/A0fMoWa+IGigZbt5KcFiZNY8kgou9KFPABNI9/SD+FxwWffIuAlliSmEviyXMO4WQMI0z/9UGVzc0nsFXa42hCknb+cEEFRe2tk0FwIGeShL5smF/kaEm2/vOye+JZvTRoyyUUSPyt9KIAYdAD0msK+T9BmJkz+TgXTe0vBs0tPjPKRtyESkCUl9ku3AgezCMQmKHAidS17INnW/hHXHoxShA+t0qy4blEpfLy04pUQOfaQe3fsIhNY0EYKui2Zr1pKFJpgwJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz/PYa3gyld3AH2vdKGB/YgLqRPLeJVy3NJGQFtUAy0=;
 b=VT2qTy62j0aQsQacCtMMMsd9vOBy+vYGMUpiqND6idshNIHUYxtIM9PrFeBucNMEC8RKRvt0dHInGJBtM4kOTopLXykbbMnRJcXkwGziuCQ+J2DKSQVGQgFsbgQ9Mf65fWv5Q0GCwgmIjyyBO6LP3l109vQzBqgi3Sou2dIZwrw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4681.namprd13.prod.outlook.com (2603:10b6:610:df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Mon, 19 Sep
 2022 17:59:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5654.014; Mon, 19 Sep 2022
 17:59:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: NFSv4.0 callback with Kerberos not working
Thread-Topic: NFSv4.0 callback with Kerberos not working
Thread-Index: AQHYzDzsbeh4Wv/4SkKDzJtBHUqbV63nCqwA
Date:   Mon, 19 Sep 2022 17:59:35 +0000
Message-ID: <4e79b32842427aa92bf62c5c645430bd23b413e4.camel@hammerspace.com>
References: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
In-Reply-To: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB4681:EE_
x-ms-office365-filtering-correlation-id: dd6eabb9-11e6-4ecb-b520-08da9a68b68b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsEalrOLJPdR3WgmdqiwHzMGLnPZI+tZA8ddAWp5heRuAleyDBlYCgFGgCmjhaLo3fc9xawst8yYMo9e+YFZ5xlC95s9ILp9QaRuH+DmYZZ0jZUjvoyPS1mhjs8LgfalGL4rt2v/vj1ggf1SKspXVnLS0Ce0VJHauQyxXrj/4SmLFWP9A4+eyZpa58OdZ6vzYqt1iOC9JNZREhEaROktNorErG0VGNKFvmG710+z2QiidV8iYBKegBAGYWOyp8is6UPTzHKbSbzC0/T1ufH0K18bWe0u97U9h10ADOkYE06ddyxIjN5pH2N1buuLMqx4vQPGWIagsbTnvUlwMTeyvDA8PvYfphLn/MCrLoTJ/VVKPuOKqgQRXmbhw6338SAlaTrh6G0qlG8HLiRy8yNYttvLs1Yva0kdTJKM1UY19MGcUn2XRckr/dCMV6NGb/r/2O2TvTHBPg0hAUgnBk05YzxxVVZxR0nCpxBV+myZWVwNWXj3aytev2KGT6OegUFXVyFqT+Cl1l25zemSjVpAILTdeSXM55+Eepjg8y1cnDA/7jo3wkP0DrYc2iVTl/R3uEzj5cV9yOK4NU8vGWaRIYethT8wTPuMKPTUXnUQ3nB6r9hVgWOA5kgYqQLfV4kMoobQzOQp+YfQNqoDakvWTPG+2Dc3dKXFt9L99vSuh70oGr2MXoifiYZrCCVomca23CvzTmHLT4lcSkGl6qt9vE3SCzeQD8H+DiW+mkgLekhfjEbDMsIeWFhDcYgKoyx2KMXImJchXjj10K4UW/GkPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(39830400003)(366004)(451199015)(38100700002)(6512007)(26005)(122000001)(64756008)(6506007)(8676002)(76116006)(4326008)(2616005)(2906002)(66446008)(41300700001)(38070700005)(186003)(5660300002)(36756003)(478600001)(86362001)(8936002)(71200400001)(316002)(110136005)(66556008)(66476007)(66946007)(83380400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3FSd1dnY3VrLzNGR011TzJrUndmbGpuMDdHRmNDbWVwR0llMHVzK0hvU0Zt?=
 =?utf-8?B?b1BMSjloYk5mMlNtdVBETGhxT25OWmNKV1ZjQ2xFRjVVbktuU21lMnJRRFFa?=
 =?utf-8?B?NnFDbDdNZElubXhuOG44SGpzaFE5WE9mWWlsait4cThMNS84Q2ZFc0xuZ1Fu?=
 =?utf-8?B?dUhrSlh1dXNiR3pEY04yNjBLR1dIS2dwc3Z6TlliRGgvL2xQV3g5ZHBjTlM2?=
 =?utf-8?B?ZGxIM3orM0t2UnhlbjcxUUhXaDI2K0htVlplR0U5eE1KKzZDUTc1aXlURjJY?=
 =?utf-8?B?WnFqSnpBWWMwVjkrMUtvd0c1cklzd1VVVk9iVjdEdnBZZ09uRjIvZHNxTzVJ?=
 =?utf-8?B?elFkKzJ0NjY4R0Z3aEhPQnVla1RDb2FGcnJjRyt4b2JBNmRvemtoUCt4cHk0?=
 =?utf-8?B?c0hDVHNMUSs3a2Fjb1I0d2lRQ1hMby80WHdzUk11dTM2N1pXTjh3ZzdNWUxJ?=
 =?utf-8?B?ZEorNEFGd29PNHYyTWVONVpUWldjR3YvdnJyUXlaeXYvM2ZPT1UwaFRlVUVl?=
 =?utf-8?B?dFFDUmxQY05qcEtFM01RVnIza3d3Sk5pMDRGcDhKOGZtZDNablN6eXp6V3Jr?=
 =?utf-8?B?b3h4ZW9UR0JVNDA5b1AySkQ1NWM3VDFTR2VmNmRTWTlEVXpEREJkQ1VFbVRi?=
 =?utf-8?B?WE45WkZnSDgzUE8zdU9rUmhwWFJVK1JGdUZwYndKUS8rNitzQVkwc0FabWla?=
 =?utf-8?B?UEVqUlFZVHpUTkFQWDNmdjd1V1FZY1lQMUovRWJ6Z3kzUTIzWFRRRzZLSXMw?=
 =?utf-8?B?bDk1b1pPYnVpejF1cjFMQnVsNGFxajZZMlVlZ1g5eFRDUjVUbnVocHlnNXMr?=
 =?utf-8?B?M1ByY0hoSjhmSUQyRE5wL1ExQUZrOUxKT2lXMzk0dmdqejl0aXQ2Z2FIbW9V?=
 =?utf-8?B?MHJML1VPN2w2bzNYZVd3N3BrbUxuNlFJd3ljY1FWY1l3RU4raEhwSk9zK2w3?=
 =?utf-8?B?U29Jb0lDQlU0WHAvcGlQYXQ4OXd5aExqY08ySzliTEU3eUZ1aC9YM3IwS21V?=
 =?utf-8?B?NG8zbUJkRU96clJNcFhFZnJBdG5ESElraURjSk5GTHgwSFdSQ1lPQy9wYUJ0?=
 =?utf-8?B?RnNPSUxTVnVicXhkb2grMmdERjRlZWxMcnZiZ25vaDdQeXAvV2JUV2I2a1lY?=
 =?utf-8?B?YWRuTWh0aFpLUEdGUG9aNlNSUkJjSU9IOVFjaHJTaVRETWU1OGFneWhXNjJy?=
 =?utf-8?B?YUFMTGdUd3VmQThWVXViS1htRVZmQ0VteW56UlBXaTJNSGhycUkrN1NtczFO?=
 =?utf-8?B?a0N3MHJaQTAxM3RVUDJaWUNYWkFYU2NqNG5XVjU0VUVzbWJBUjVHVDZoaGhv?=
 =?utf-8?B?YkdXZVcyRURXRGY3QU4yd2pGR1JsVUlxSGs2TTl0S3dFZjFsRnpvbXJURWJT?=
 =?utf-8?B?c24yYTlHY1lMT2c4QmpkK3VNR29yL3pReUFSQzZUY0U3RytGTE1DQ09uNmNl?=
 =?utf-8?B?MXVMUnpzcnBNZ0U4QjRHaUNHUnJ3bWlvMGlhN3dEbGV2QUZWVC8vK3FUZU5B?=
 =?utf-8?B?djA3VGNIeUxkRzQram11aE1vTXlDN2NXZkdKQTdHUVVKZlh6TVpDbjFseTRa?=
 =?utf-8?B?Uk8ycFQ5dGtrMVMwQlpuQnpLVEZKWlMyaVpwejI5YmpEUmlFOHMweUZKSmwy?=
 =?utf-8?B?aDhkZ1pRNHZJY1pLektMQWE4eHpEUDRXejFDMk5LTG8vQnlDQUdjTHo1d1R0?=
 =?utf-8?B?SG5QZmtsbEZVR0JwcVRFNXluK1FuVU8vK002bXVxRWNxVW9LbUJYUHRkZjFa?=
 =?utf-8?B?WGx5bHNCVzFUN25XTzVmMzZhMzZoSzN5aUFqQU9IY3FhUEFxRjFIVkRaeFVO?=
 =?utf-8?B?eEtNeXltN3lXakNBMlJtenp4VHIyYURTOFByUVBJZzBsVjdTZ092akpzcm5u?=
 =?utf-8?B?NCttdE5QRXc3MjY2ZlhOTDNwbm1zRHBJa1RuZFZHaTk5cFhLSE5JRk9UTXhm?=
 =?utf-8?B?K05iTmpucWl2NkcxY1FxajNzV1pqeVlrTWhtSURROUJyU0REWlVzd2Y0Y0w1?=
 =?utf-8?B?amhCbGJ4Mk5XTDl1YUxRUXlGa0Q5MzBnR3h1SWt6VFZqRk03TjJGZFlsZkhT?=
 =?utf-8?B?VG5zRmRrczdKM1NTcFVyMDE0OExVbG9yd284VUQyKzNqUTlrMnBqNUlJRW9n?=
 =?utf-8?B?VGF0NUpYUWhDRkpxNjRxcWJNSmVkZ2xYY0xNMXUxZDhtMWt1RmMyTkRJYzN1?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB8FB4DC4BDDD34FAEC2BB95F892DBF2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTE5IGF0IDE1OjMxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpLQ0KPiANCj4gSSByZWRpc2NvdmVyZWQgcmVjZW50bHkgdGhhdCBORlN2NC4wIHdpdGgg
S2VyYmVyb3MgZG9lcyBub3Qgd29yayBvbg0KPiBtdWx0aS1ob21lZCBob3N0cy4gVGhpcyBpcyB0
cnVlIGV2ZW4gd2l0aCBzZWM9c3lzIGJlY2F1c2UgdGhlIGNsaWVudA0KPiBhdHRlbXB0cyB0byBl
c3RhYmxpc2ggYSBHU1MgY29udGV4dCB3aGVuIHRoZXJlIGlzIGEga2V5dGFiIHByZXNlbnQuDQo+
IA0KPiBCYXNpY2FsbHkgbXkgdGVzdCBlbnZpcm9ubWVudCBoYXMgdG8gd29yayBmb3Igc2VjPXN5
cyBhbmQgc2VjPWtyYioNCj4gYW5kIGZvciBhbGwgTkZTIHZlcnNpb25zIGFuZCBtaW5vciB2ZXJz
aW9ucy4gVGh1cyBJIGtlZXAgYSBrZXl0YWINCj4gb24gaXQuDQo+IA0KPiBOb3csIEkgaGF2ZSB0
aHJlZSBuZXR3b3JrIGludGVyZmFjZXMgb24gbXkgY2xpZW50OiBvbmUgUm9DRSwgb25lDQo+IElC
LCBhbmQgb25lIEdiRS4gVGhleSBhcmUgZWFjaCBvbiB0aGVpciBvd24gc3VibmV0IGFuZCBlYWNo
IGhhcw0KPiBhIHVuaXF1ZSBob3N0bmFtZSAodGhhdCB2YXJpZXMgaW4gdGhlIGRvbWFpbiBwYXJ0
KS4NCj4gDQo+IEJ1dCBtb3VudGluZyBvbmUgb2YgbXkgSUIgb3IgUm9DRSB0ZXN0IHNlcnZlcnMg
d2l0aCBORlN2NC4wIHJlc3VsdHMNCj4gaW4gdGhlIGluZmFtb3VzICJORlN2NDogSW52YWxpZCBj
YWxsYmFjayBjcmVkZW50aWFsIiBtZXNzYWdlLiBUaGUNCj4gY2xpZW50IGFsd2F5cyB1c2VzIHRo
ZSBwcmluY2lwYWwgZm9yIEdiRSBpbnRlcmZhY2UuDQo+IA0KPiBUaGlzIHdhcyB3b3JraW5nIGF0
IG9uZSBwb2ludCwgYnV0IHNlZW1zIHRvIGhhdmUgZGV2b2x2ZWQgb3ZlciB0aW1lLg0KPiANCj4g
DQo+IEhlcmUgYXJlIHNvbWUgb2YgdGhlIHByb2JsZW1zIEkgZm91bmQ6DQo+IA0KPiAxLiBUaGUg
a2VybmVsIGFsd2F5cyBhc2tzIGZvciBzZXJ2aWNlPSogLg0KPiANCj4gSWYgeW91ciBzeXN0ZW0n
cyBrZXl0YWIgaGFzIG9ubHkgIm5mcyIgc2VydmljZSBwcmluY2lwYWxzIGluIGl0LA0KPiB0aGF0
IHNob3VsZCBiZSBPSy4gSWYgaXQgaGFzIGEgImhvc3QiIHByaW5jaXBhbCBpbiBpdCwgdGhhdCdz
DQo+IGdvaW5nIHRvIGJlIHRoZSBmaXJzdCBvbmUgdGhhdCBnc3NkIHBpY2tzIHVwLg0KPiANCj4g
TkZTdjQuMCBjYWxsYmFjayBkb2VzIG5vdCB3b3JrIHdpdGggYSBob3N0QCBhY2NlcHRvciAtLSBp
dCB3YW50cw0KPiBuZnNALg0KPiANCj4gVGhlcmUgYXJlIHR3byBwb3NzaWJsZSB3b3JrYXJvdW5k
czoNCj4gDQo+IGEuIFJlbW92ZSBhbGwgYnV0IHRoZSBuZnNAIGtleXMgZnJvbSB5b3VyIHN5c3Rl
bSdzIGtleXRhYi4NCj4gDQo+IGIuIE1vZGlmeSB0aGUga2VybmVsIHRvIHVzZSAic2VydmljZT1u
ZnMiIGluIHRoZSB1cGNhbGwuDQo+IA0KDQpUaGVyZSdzIGFsc28NCg0KYy4gUHV0IHRoZSBuZnMg
c2VydmljZSBwcmluY2lwYWwgaW4gaXRzIG93biBrZXl0YWIgYW5kIHVzZSB0aGUgJy1rJw0Kb3B0
aW9uIHRvIHRlbGwgcnBjLmdzc2Qgd2hlcmUgdG8gZmluZCBpdC4NCg0KSG93ZXZlciBub3RlIHRo
YXQgJ2hvc3QvPGhvc3RuYW1lQFJFQUxNPicgaXMgbm9ybWFsbHkgdGhlIGV4cGVjdGVkDQpwcmlu
Y2lwYWwgbmFtZSBmb3IgYXV0aGVudGljYXRpbmcgYXMgYSBzcGVjaWZpYyBob3N0bmFtZS4gU28g
SSdkIGV4cGVjdA0KY2xpZW50cyB0byB3YW50IHRvIGF1dGhlbnRpY2F0ZSB1c2luZyB0aGF0IGNy
ZWRlbnRpYWwgc28gdGhhdCBpdCBpcw0KbWF0Y2hlZCB0byB0aGUgaG9zdG5hbWUgZW50cnkgaW4g
L2V0Yy9leHBvcnRzIG9uIHRoZSBzZXJ2ZXIuDQoNClRoZSAnbmZzLzxob3N0bmFtZUBSRUFMTT4n
IHdvdWxkIG5vcm1hbGx5IGJlIGNvbnNpZGVyZWQgYSBORlMgc2VydmljZQ0KcHJpbmNpcGFsIG5h
bWUsIHNvIHNob3VsZCByZWFsbHkgYmUgdXNlZCBieSB0aGUgTkZTdjQgc2VydmVyIHRvDQppZGVu
dGlmeSBpdHMgc2VydmljZSAoc2VlIFJGQzU2NjEgU2VjdGlvbiAyLjIuMS4xLjEuMy4pIHJhdGhl
ciB0aGFuDQpiZWluZyB1c2VkIGJ5IHRoZSBORlMgY2xpZW50Lg0KVGhlIHNhbWUgcHJpbmNpcGFs
IGlzIGFsc28gdXNlZCBieSB0aGUgTkZTdjQgc2VydmVyIHRvIGlkZW50aWZ5IGl0c2VsZg0Kd2hl
biBhY3RpbmcgYXMgYSBjbGllbnQgdG8gdGhlIE5GUyBjYWxsYmFjayBzZXJ2aWNlIGFjY29yZGlu
ZyB0bw0KUkZDNzUzMCBzZWN0aW9uIDMuMy4zLg0KDQpTbyB3aGF0IEknbSBzYXlpbmcgaXMgdGhh
dCBmb3IgdGhlIHN0YW5kYXJkIE5GUyBjbGllbnQsIHRoZW4gJyonIGlzDQpwcm9iYWJseSB0aGUg
cmlnaHQgdGhpbmcgdG8gdXNlICh3aXRoIGEgc2xpZ2h0IHByZWZlcmVuY2UgZm9yICdob3N0Lycp
LA0KYnV0IGZvciB0aGUgTkZTIHNlcnZlciB1c2UgY2FzZSBvZiBjb25uZWN0aW5nIHRvIHRoZSBj
YWxsYmFjayBzZXJ2aWNlLA0KaXQgc2hvdWxkIHNwZWNpZnkgdGhlICduZnMvJyBwcmVmaXguIEl0
IGNhbiBkbyB0aGF0IHJpZ2h0IG5vdyBieQ0Kc2V0dGluZyB0aGUgY2xudC0+Y2xfcHJpbmNpcGFs
LiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlIGN1cnJlbnQNCmJlaGF2aW91ciBpbiBrbmZzZCBp
cyB0byBzZXQgaXQgdG8gdGhlIHNhbWUgcHJlZml4IGFzIHRoZSBzZXJ2ZXINCnN2Y19jcmVkLCBh
bmQgdG8gZGVmYXVsdCB0byAnbmZzLycgaWYgdGhlIHNlcnZlciBzdmNfY3JlZCBkb2Vzbid0IGhh
dmUNCnN1Y2ggYSBwcmVmaXguDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
