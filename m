Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C82562C1EF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Nov 2022 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiKPPKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 10:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKPPKK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 10:10:10 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2120.outbound.protection.outlook.com [40.107.95.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF21403C;
        Wed, 16 Nov 2022 07:10:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7IoLeR5gkbE4cHlWz4v5C10mI7kkG3W4Wmb9FpGX9uqYUgJIPu/Lhjd5BKNKPunSel5y8tkx8fydDzvqmZTHUOUzA2Ee1HpXSQsN8XrcvHz67LsBT5pp8/E5qYZWcHiUF+3L80ervwGQf93tUrHl548wGOG6SB5/1pptDZjdZcSB9u7RNSvHdKoAM0v4tPOdeyXPyu8sjAhrum0KX9QKyi0qEnm1eKhqURmcJgTgb21beB0Hir4yPA11DkrW+9f9txGc/nEuaHPS+dfyV6HyVNY/33akbENyPKVZKnbYJSKj2K1p6PK5P0yaCR9t37foRX2OZL0e9EDZeb1qCpI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biRZwHkR4zVeMOVqzCKlbLj7SCRJloG8w5cxZbQmgew=;
 b=cGBv20WHKYUkySF2kIFzW/BtnrC3vhVLNDPwYWu8P2nvXpJu/lovPpFu9OGZ6MSLoXtzAMmysT0b0Kx38hH+BYCiHh/XZKTj8WkSR+LP+eqeQ6x3hR4p+de6Zzp7Zi2/BWs4d5ioIbK7jcznmiB7jiiW7BxfJlTBwIyvryqaShCuTPYHbaRkyN7nAh/t4WbK5rmamUxqfEKDTE1tN60uPT68wVopX5OFQz613Tbb4IRt18OEaJ8eC2qWX67+eIBIyS/JjnYaxIsn1bA0Uf2Hl1VJjQLMqfq8m1fhXxRUD8NY/V/keafePMBWFmeHbwtyqBEWPAUnU14//+769m+Ojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biRZwHkR4zVeMOVqzCKlbLj7SCRJloG8w5cxZbQmgew=;
 b=KZ59BP0xkr/C/ntA0jI67h1vJmNDXXP7LjBYSYZra1OVfDML8tdpHg3Ok831kSxvE4lxU/X8Bzgyz8jx6kAsWZwIZKhkfwWIZEMEnxDGGzQm44LItpz/R1v8eVikyfZP3I/dVdNqpkf9YXLG7jvi9kbJe8Lo5Cy1NbPasYR9KIE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5461.namprd13.prod.outlook.com (2603:10b6:303:190::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 15:10:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%3]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 15:10:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Denis Arefev <arefev@swemel.ru>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>
Subject: Re: [PATCH] nfs: Added pointer check
Thread-Topic: [PATCH] nfs: Added pointer check
Thread-Index: AQHY+c2C6g3F/wV7MkqQv46o2Fcvdg==
Date:   Wed, 16 Nov 2022 15:10:06 +0000
Message-ID: <6643835B-81A8-4CAD-80D9-5D86048692BB@hammerspace.com>
References: <20221116121556.91060-1-arefev@swemel.ru>
In-Reply-To: <20221116121556.91060-1-arefev@swemel.ru>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5461:EE_
x-ms-office365-filtering-correlation-id: c7dd6cea-a41f-49d5-6d57-08dac7e4a531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSx9ezZVoJk1+ZE3q8MeADCVmBnu+HM6T7GxyKC4J+ZANtnIlbWYpjVJrOFLC5/T/QlAGrYYOHB21aFKkErpaGGOSaj6JCv+MbdPFQGtthaJOixSnTkZ3D9ch2sVZ6RdvTAn5utVf98XSc4lz17vggOyS43VHovVePjhXY20hOqBn8sI8SzKWRHyS59oTF53aLet1WPfiaY9MdcaehOFUAQanZGwX9srSYxC0+JlNNniBf35qnRCaPzjP3WEGibo55q4OZgYhPEm+nYu6boeA/VlQsBwc0iu3Ze+quR4MZdMw4a48J9PdzrDC+cYh/uzOGOtt87NpbVlfMRJrgmgxfvWhkebHZo2JZCA1AeuzNMq5ROXqRM2S8OHOUaAayFDn2bvx2NMMM0ldCzicPwgisvHM/hIjtCFT0kxuyQlkRXqcZBrqSMChHxlBU5U3NRTiv9CtPlO/QYG9xO9v4BEquFsuu4TedrlfbMXJCPfI1VBnTSoIbc23k22uEDYyc5m3zI5n/1z/IWWaGth51bA4kWhCgeuXqA/Sat3C5UlUAzNZQGhAC23mW6y1q3rwUcR5g1CiSifozw9U3lZWdNgYSRoQRuuZCWb+9IGSyk1NdFjSZZv49rkUKOABOqHGFsXnacIUvCjDp8fMwGq9MEuHuw7SuiQTN4HoEqRCFZ2d3gMgwiYAKfOGn96QN2xHow2iNxEeZameehjHcgPlT02PWsvUqxn7ttJRTKuBOfeamPzXQ9fsMTyWiytuB5/FafqynP4uc9I7lNgJZ3fggfoVUEpEAgt7Hk13mpfX839WLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(346002)(39840400004)(451199015)(316002)(66476007)(66446008)(64756008)(6916009)(54906003)(38100700002)(2906002)(122000001)(8936002)(66556008)(76116006)(71200400001)(8676002)(478600001)(66946007)(966005)(53546011)(2616005)(6486002)(186003)(33656002)(83380400001)(26005)(41300700001)(86362001)(36756003)(6512007)(6506007)(38070700005)(4326008)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGpTaGFUZWpIN1VWbERaNGk0c0sySGNvbjBLR2xuQVpoM0pITlZvREZ3a0V2?=
 =?utf-8?B?OFFsNGl6eHhqVW9jTmV5V09PQzc1QXdCejJRQXlqQjY4b1NXZ21mSFRVUXk0?=
 =?utf-8?B?dlJ4L2dOM1YyQU5DVzFVL1loalBVK2JYK1Rrb2phb1ZZTFpNb3ZiUTNMcU1S?=
 =?utf-8?B?YUo4VS9WdHRYMkNXS0d5T0p4Sks0QkRrelFZRlZvRFg3WmpUZkZGR2tkWWtS?=
 =?utf-8?B?d2hveTA1WS9SRnIveFd4NTFZS0tYMEhGSVY0M0dNeE5HelFuZ2dINmEydGRs?=
 =?utf-8?B?REVzd09HaHp5dUhKU0JNWkdJa3pYYUxwRjhpRDVrNmhuL21zN2k2Sk1neXJN?=
 =?utf-8?B?eUxlcWpaMlBDbitUem1BYW9FZ0VZclZPWmg3S3FBUVRqZnVoTnJHaGlyd0M0?=
 =?utf-8?B?eDBIMmVEajFQOVpZRWVreWdGeW50VmRqYlZWQVgwWWRhTWs5ZDhSSGszU0dJ?=
 =?utf-8?B?c2UwU2g2eU5NSFF3NlA1dEYrZ0hocGtWOGI5T2V5WGJxNHZUZHcvQ2s0L3Ix?=
 =?utf-8?B?SzhnZFljbU9uUFJlRVhsUXlLMk9uelhObzhYYUhCQW94Tnl2L3dWMXlrcmJ1?=
 =?utf-8?B?OWNnb21lMXNVc2FyL1JzRjVrTXdkSDhzenhSNHFTYkxiYnBCVGc5Vit3eXFH?=
 =?utf-8?B?RnYvYWU1dm9FSEZ3VDBVRStrZWVvWnFLN05IaTZVNFNUYlRJbGliTURUZldR?=
 =?utf-8?B?QzdSaVI2YXdpY01sbTluYXdsV3pLMjU1L0pMbUFzVE1jaWtnR3R6Uk14M0lO?=
 =?utf-8?B?MVlnc1ZoSWRpRnFjSUVRdTZEbFZMWVI1WjlwUXZyQkd0SnAxczRjK05mQU5z?=
 =?utf-8?B?QnphaHgvM1J5MXBJUmlBYzBCZWpGZURzMGpTUURPRVJrdmVEYTNmUE02Q1k4?=
 =?utf-8?B?UzlUQVk4dDkyQitjOEQ2bjlHZnBSbmZXQWE4Ly9FeXdkME96VkNJQ1RUcEVH?=
 =?utf-8?B?dktveCt0MHREMEhBaU9uQ3ZpNjZsZU5sRDlzWER2aWVnTUowMGNyUGYrUVJU?=
 =?utf-8?B?M3hYZW1BRzVHZjUzOUd5TzREbnVxR0pwWVVmVTRyZ3hBalRRbWFiREo2Mk1k?=
 =?utf-8?B?SldlYTBBMUpuUDhFRlRhRVJ5K1doaXpBOG1ETFBqUFNtNkVLQ1J2OTdMTVN2?=
 =?utf-8?B?ZEVPYU5pWmthRFQ0dlJ4RU83OTFNcVBmSmVDR2craG52K2srbFhLbk1YR2Jk?=
 =?utf-8?B?endGOEtUb1FES3Y1ajJ1WW0wbWZjUVlONVFmSVR4MWtaZStuVDZwRWxFUi9S?=
 =?utf-8?B?bGVCTDc0YmJmaytaN0VuWkpscW4wOEhuWFRuTXhkRi9jL21pREF6UmpteU5m?=
 =?utf-8?B?RTJ2TUR6YWdOUGVlR1pVdGd2NndjYTI3bkZtVnVrbUFjSXl0eXZwNWx5SHhx?=
 =?utf-8?B?Tms3TGcyT2tpNlA0VS9WNUtBMEVSblNzSGNweW5sL20rdUlJZzhwdTFENXJX?=
 =?utf-8?B?UXhHbzNjeUtHanIrd2phMzBvOXZha1dxWU5yUXpFQlJleEFIbXMyaVZ6MGww?=
 =?utf-8?B?WDhFS0ZYckR1Y2NxTnFNTUN2WnRKKzhIcHhpMy93UVlzL0N1WGxDVE5jc1Rp?=
 =?utf-8?B?UmVWMk9QZXZtMUdMUlZpUlJIZzByWHpicmFhNnFjMStxNkR2NHdyYmgveThI?=
 =?utf-8?B?b3k4RXM4QThBTFZRNkh3T1RCRW1USSthRFhQckM0VjdLVVNSOWt1ZGkvTmFI?=
 =?utf-8?B?dDZsNXlLdXpqaFZpcUptSHQ1S1V2bjNlV2hVY212NHJhQUdTSTBXTkxmMFRR?=
 =?utf-8?B?OEFPWTd4TmdPSm5QWEhNNXV1TUxhVDRGWEYya09ZV0VKM3FmWjRCOWtJN1FW?=
 =?utf-8?B?UWU0VzdxeUZ1dGNiZTVSMjVaUEVYanVuVC9SWTlzWEFmVlZ5dlo0NkJCZTVB?=
 =?utf-8?B?WTFzTnlvalVPUzd2Z0diSm1iSmw0ZE5TaWVZMERZN1dsZnFRVkgva2xUbE9a?=
 =?utf-8?B?aGZHM0JPek1QZHJXR1ROem9KcytrKzVDV0hvdHR1OUh3WlErSEFrU2E0bTVC?=
 =?utf-8?B?NmgxS1B5VGVCTmlaYlA2UDRCN3UwcnVNUWM5YTBGTkJnajV1UWR0YnNrbGNq?=
 =?utf-8?B?bFhjZStKWlpOY2RMT0ZIMndkK1VpTS9CTHhmOVBWQ29STGVVVEVaUDUzM1lT?=
 =?utf-8?B?ZW9rTkhOTVcwcm16b29zWEF2Vm0rMG5MUFU1Wm9TR0dOZDM4SHdGaTRra3RX?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9385B373A01BBC4A827481839A01FA9D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd6cea-a41f-49d5-6d57-08dac7e4a531
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 15:10:06.4141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZCLZ+vT6kybSFVkJRqHuyOS5Yo+nze71LHn1CVgguvtp5B6ME5BwDsuuKgNgqNZ0AVwpBM1YlMErswRVWuF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE2LCAyMDIyLCBhdCAwNzoxNSwgRGVuaXMgQXJlZmV2IDxhcmVmZXZAc3dl
bWVsLnJ1PiB3cm90ZToNCj4gDQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gYXJl
ZmV2QHN3ZW1lbC5ydS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBSZXR1cm4gdmFsdWUg
b2YgYSBmdW5jdGlvbiAneGRyX2lubGluZV9kZWNvZGUnIGlzIGRlcmVmZXJlbmNlZCBhdA0KPiBu
ZnM0eGRyLmM6NTU0MCB3aXRob3V0IGNoZWNraW5nIGZvciBudWxsLA0KPiB1dCBpdCBpcyB1c3Vh
bGx5IGNoZWNrZWQgZm9yIHRoaXMgZnVuY3Rpb24NCj4gDQo+IEZvdW5kIGJ5IExpbnV4IFZlcmlm
aWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEZW5pcyBBcmVmZXYgPGFyZWZldkBzd2VtZWwucnU+DQo+IC0tLQ0KPiBmcy9u
ZnMvbmZzNHhkci5jIHwgMiArKw0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczR4ZHIuYyBiL2ZzL25mcy9uZnM0eGRyLmMNCj4g
aW5kZXggYzZkYmZjYWU3NTE3Li41NzFjYzYzZWNiNjEgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9u
ZnM0eGRyLmMNCj4gKysrIGIvZnMvbmZzL25mczR4ZHIuYw0KPiBAQCAtNTUzMyw2ICs1NTMzLDgg
QEAgc3RhdGljIGludCBkZWNvZGVfb3BfbWFwKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIHN0cnVj
dCBuZnM0X29wX21hcCAqb3BfbWFwKQ0KPiAgICAgICAgaWYgKGJpdG1hcF93b3JkcyA+IE5GUzRf
T1BfTUFQX05VTV9XT1JEUykNCj4gICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ICAgICAg
ICBwID0geGRyX2lubGluZV9kZWNvZGUoeGRyLCA0ICogYml0bWFwX3dvcmRzKTsNCj4gKyAgICAg
ICBpZiAoIXApDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gICAgICAgIGZvciAo
aSA9IDA7IGkgPCBiaXRtYXBfd29yZHM7IGkrKykNCj4gICAgICAgICAgICAgICAgb3BfbWFwLT51
LndvcmRzW2ldID0gYmUzMl90b19jcHVwKHArKyk7DQo+IA0KDQpUaGlzIGJ1ZyB3YXMgZml4ZWQg
aW4gTGludXggNS4xNiBhbmQgbmV3ZXIgYnkgY29tbWl0IGYxMTQ3NTljMzIyZSAoIk5GU3Y0OiBG
aXggcG90ZW50aWFsIE9vcHMgaW4gZGVjb2RlX29wX21hcCgp4oCdKS4NCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0K
