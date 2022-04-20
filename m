Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B054509174
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Apr 2022 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348222AbiDTUfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Apr 2022 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiDTUfV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Apr 2022 16:35:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2117.outbound.protection.outlook.com [40.107.93.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8D7377C7
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 13:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6acFaZKgHvD98ZVdzceA1ryhnYmk8caWCtgQcs2OVUTTu+y5K7BAJ3J0K5Rzrzr36gqZQPF6UlOYhoCnR1KEsz5d82lvoqxRD+KqHvw8Jpfc40mE/3GbTlZml7cACxTaK5aYLDXfoLmkYU2nvZHrZelhtxC3T/mlOBvzA1EATwDBcFulevsWlyyO1zijW3NGGeUes4O6/wd2bslpcg1qV022EURpVo+4tcToZ7AbS/sTJDBLV4PPznS+fHOuCW5KeRdYE35z1WG/utnRze3uQpym90Ns2C8EPTUxke0t4bRxqOnPOeJCfke0n598rNb0svaI/l8tnCiXkaYxOGrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPTmBN6F4I04xdxMiQt/gjGs3fFX0/72zwtHJxuhaKM=;
 b=UJwKLC6oirQf4CocLXe/JSsB1taFaSqb4mMcx61trjIRWyMfXgkA6cVlgeG9nJxhJWdlM16THyEhIJCohOHklLySLkfWpgBScUktIEt5MrC29sqnZAdFTM4h8i28BTkm6R0bxIeCeG5sojh1bo8pHAg988587o6C/dpiIIrw8WB5c79Mr0t3lGPxMDvIPqK1igMDQUuM62KG4be4CVmQhILUTQQ7sztt3JYpWB13zmpm9EEUuTlNjcsMsdGDtHPSnoo38J2EcXPMNkk0BgQYfuTKOsQ5Ym3v0nto59xQI1w9O+4E6SN4hZXeRY5aXPhGRQ0yCZK5rRT8NiONmWBEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPTmBN6F4I04xdxMiQt/gjGs3fFX0/72zwtHJxuhaKM=;
 b=L5x5tgXXwwN5M2VYMlnpRQCNIjVB5YA8ue/Fzq+/mWcLhawMx6B7kPRnVxblkLsYlla+Gy9q4HRqmrus0Y2RHZYnDIcr0T1sNhLBPnqi17jmzrnM4PHL1X4KuvZwfrB7V2dgxCO07XW5k3kWO8iAxTBDU2T1dVXOTiFMow1XCJE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB3997.namprd13.prod.outlook.com (2603:10b6:806:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6; Wed, 20 Apr
 2022 20:32:31 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 20:32:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] SUNRPC release the transport of a relocated task
 with an assigned transport
Thread-Topic: [PATCH v2 1/1] SUNRPC release the transport of a relocated task
 with an assigned transport
Thread-Index: AQHYVPSGxykn3raxrEW3BtXEs30muaz5QZmA
Date:   Wed, 20 Apr 2022 20:32:31 +0000
Message-ID: <e7f74c26fe13a88b6b8fd51defc983aef61c7061.camel@hammerspace.com>
References: <20220420202333.90903-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20220420202333.90903-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7203ffd1-634c-466d-06d7-08da230ce4c9
x-ms-traffictypediagnostic: SA0PR13MB3997:EE_
x-microsoft-antispam-prvs: <SA0PR13MB399742B694FF3245FA3D629BB8F59@SA0PR13MB3997.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6DDSqEC3W8s9mzscpznqSF1Q0sLvEwELguuBTwT/guZ2jLXUjWPtcNRCEYuizhfYrtXjnscwpYe3+gapbfMpwzmKlVhaC3/WeXmjDsd5/hZHfy+K5pf2nHu9Rle+LXxj9G/+X7jXdpEaZIh4EyI6Ex0gIHc9Hko8wbiYsgf5/ZeC5pMrhbYi/zEI7PYItxA71yVvfK6W+e4REq9KTNpTpQFB0UMFjCKBxo6W7BXJC4H0obJrQuKpXFcmahR4cEIXZqHgMC8ZwPwZouJ4kh2dvQDb2lg2mg01jLRll+LY5ILQaBr9GGNt+chZ9zBIcoT7y7Dlucak2eU3B8MLakOsmY7smb1Izb2hLRxQK01wI5eRjvrALqpdZX2h9cRdYcmQRK133rj6+MUlzzazmFEKPDPmTYRwwYV7t3nJI2b3ioy5szLgQY4sdzMBuJ+dGeeVGb76m//fIGfYiC8QvgbDirBSDl2O4EgZuGSRPWRSzQUDklWb2xb9QIuqi/NVoU64lM4GCojaYuYCJpnX+mk5OfnFHoY5Ie1aNFDCRUiiik9lkyYYEYht64M2YcdxclG7ZF4d2XKMB67k2Zrv3EAHZdXwJq0J9L2Ua6N7+JtxeOWg5sMUPMEmPcC7WKO44AKPw/bkmJpdjLM/MNNrbR2F3thXWiFdIf8ZHEdKrgF2AP7h9kUSm+KWf5itx8kIu5K0+YmmK5RvEJZ3EmypwUIFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(2906002)(2616005)(508600001)(5660300002)(8936002)(38070700005)(86362001)(66556008)(66446008)(66476007)(6486002)(64756008)(186003)(26005)(122000001)(38100700002)(76116006)(66946007)(71200400001)(316002)(83380400001)(36756003)(4326008)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFOeTFYRjVMNkxqeDBkREVZT09ya25EWWQ2a2g5MTBFZHIyZUdPUWJIRTZQ?=
 =?utf-8?B?Ky9GQjJkSzhHUTE1eTZVd1UyM05ibnN3dzh0Nkt2a1lqTDBnb3lQOVVEYmd3?=
 =?utf-8?B?SDlFSWQzQTFYSCtCZzVuNmtDeXo3RkhXNU5jUDF4TWNQdzc0S3UwelFHL3dI?=
 =?utf-8?B?NUtsdHRqVk9sVXpJMFFjdFZSaHNxK2FKT1l0cmNNRzVrb2duYXJsSXdFZGVY?=
 =?utf-8?B?aklka2RBSXYxRmU1Y1d1am9NcitWYjVUY0J0amcyMDVRWXBzYnB0cUJMWlBP?=
 =?utf-8?B?Zk85U0RPZDB0VEhlNHZFUGRNbkUwUHR2NndMOURmbUdSZ0RuK1dlMVhySGFR?=
 =?utf-8?B?WXBQU2dsNmFJUVdNUFZCOHFwak9qZ09oZGhvUXNncmlHdVBqd2IvRDhEcTlJ?=
 =?utf-8?B?Uk1XdGptZ0xtTnVzd2o5K01uRlRDeEFxN0g0YWV6TVE2SVlNL0dRRUpWNEpT?=
 =?utf-8?B?WFZKY0RjSUVSNUFBT3hKQVJESmRsa2NtTDNvTWdtWTBjQkVpcCtEdE5ScUVO?=
 =?utf-8?B?T2VpU2F4RTJxa0FzbFJTTHNGREFVVnVKcEp2M081V3pkc0ViYXlUZmxVR1hp?=
 =?utf-8?B?MEM2RldiMjNFcUo4OExRWloyRVY0VzFsNUVwbFFId1RiQUdBS0gvWFZTOG93?=
 =?utf-8?B?MWplVEZhS1ExM1RHbHpmSDVHTDdMNnhFVVFzbVZSNTBrbFp0U0dJNVJ2d0lt?=
 =?utf-8?B?NEVBTWpCN0ZIbmF5Qkh0NWw4aUJmbDZlU0pLV2o2UmdORDFpSzk2VEMzUFoz?=
 =?utf-8?B?QldrMnBmWTlZTkFQZTZyRXU3a0JSMUEya0xnZlltcnhGOGdHUExyUGdxYW42?=
 =?utf-8?B?SmlpYm14K1lyRzEybmFzVkQ5ZkRobmdVbEJhNWxEckFXSE4vZDN0SWFvRk5X?=
 =?utf-8?B?eVc5YjBCK2c2SUtaWXlUeitRcU9YVHFaU3NjNnI4ZlRJSVg3N091YTNBV0py?=
 =?utf-8?B?WXBjRThlQldOb3YrQVBGRE41OXVQcENsWEVRRTRLajJFbWhMcEhNeXU4TklF?=
 =?utf-8?B?MWE3OE1CU080YUZ4d1N6S3BrTlhNSGZMNm5UQkU3ZmV3SjNvekEyeGcrN21k?=
 =?utf-8?B?TEtvVkxYeWF0bE0zekpVTGZ2RjVmc3FhVEhoQkdsL1lNc2xjQVRHdlZBV0I0?=
 =?utf-8?B?eUNnbE04aEdZZlMzVzRiREc2RWE3T0UwaTgrYS9oOHdaQVIzdnFYd1JzK1Nh?=
 =?utf-8?B?a09lbFhVMC9xaWZSRldqTllxUXVrd0tJMXJpMVgwNFVUNFN1alkvY3U4QnJ4?=
 =?utf-8?B?NlFnM3RZTUVmMW1JcGpHVVU1VVJ5MDVKbXVZL1RVUXZlQTd1dTdTVHBnYnhh?=
 =?utf-8?B?bUNPejJxcmRXU0x2VmZGeEJmQzl4WmJ3MGxFZnFqckJqcDNnczJOS3B4Qi9i?=
 =?utf-8?B?TGlpV3FLMElITTQ2TitMZ2Vqemkxcm8xbi9MT0g1bU13VzcxNEVUOGQ4RVE4?=
 =?utf-8?B?SHpGd2NwcTBIYXQxdlRpUXNXTjFUSUNRbFg5QUpJSG1jdGRpNUJ6Yk1PZkE2?=
 =?utf-8?B?V1RxZEhrbjBVbEw4Mi9uREFIQUNYU1M5V1dMaE5qMmZBWUFGcEdBL0hza0Rt?=
 =?utf-8?B?akhXQ2loNWFNRmlKT1B4K1l0YW5LL2RBK0kwTUlxUzhiaHpNSDUrRmprdGQ5?=
 =?utf-8?B?Y2k4Ym1sdnFTRGxrTWQydHlnN3o2K0N4WWFwQ1hqbC9rbG1jSjMzR0hqRFdJ?=
 =?utf-8?B?VGxaYSthUExmYzJ0T2E4M1RYOVhkUUZURVRzODhqV2VycXdGUHZUUmcvRHFT?=
 =?utf-8?B?R0lCM21LMGpmWFpyQm5OY3Z5WTdKSjNlWjdNemxONmxCaEZLWTVLZFRaajk5?=
 =?utf-8?B?OUgycTVYYkxkOHlMRGhEaWFxM2hnRXN4NnRCZk93c05UR2ZzY1ZXMjAyM1lN?=
 =?utf-8?B?RWEwOFVWTnBLREJ3em9yUlVDV0o1UFh3c1VpcU9sWG1tOTVGVkxpeU5Qd0NK?=
 =?utf-8?B?ZGdFbkJET29LTi8yZlNQbFBwSTQydVZkaUpOeHo0bWx3YWJzeDd4YzVjQ3Ux?=
 =?utf-8?B?cC9XTGZDYWlKTjhvUW5xM2w4czBpbThMMEVLeXlOVE14a1hlNDRkS1UwcjN5?=
 =?utf-8?B?cGpEVHZiOUVzTHkwenNELzVhVSsxRVdFeFJ1QnpObG1vaDZLblROZnYxQVZF?=
 =?utf-8?B?V1NWVHU3cHRISjBLVlRVbk1IMnkyY2U4QW14TGtoaHZWL2RkcHBnUFNENHgz?=
 =?utf-8?B?aXpsZUZIbzg4a1dZVmdKZ1BDSDhoWkhscXJLSTR1NzliVko1aTI2R3ZkWVA3?=
 =?utf-8?B?YkRqbEtweXZ0N05xdFZuYXZVOG1SZDRzc2pnSkN0NnExY1VqWDhGL2s1b2U2?=
 =?utf-8?B?aFdzUTU5Q1BnV2NDWDc1eFdqZkROb0VMQTNGRnhXRmplOE9RTEhiRDlxdlBJ?=
 =?utf-8?Q?THJkZ2iebilrExqY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0639431C70BA224D826465F01FBCC36E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7203ffd1-634c-466d-06d7-08da230ce4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 20:32:31.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0RiXY8IWjXywV6taWPYK7HZ6boYCkApIBqPY/e5u67HF8QHu+OpPnan08F1xtGyRFhEdgyTC2Gi6DX7uKZRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTIwIGF0IDE2OjIzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToKPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4KPiAKPiBBIHJl
bG9jYXRlZCB0YXNrIG11c3QgcmVsZWFzZSBpdHMgcHJldmlvdXMgdHJhbnNwb3J0Lgo+IAo+IEZp
eGVzOiA4MmVlNDFiODVjZWYxICgiU1VOUlBDIGRvbid0IHJlc2VuZCBhIHRhc2sgb24gYW4gb2Zm
bGluZWQKPiB0cmFuc3BvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxr
b2xnYUBuZXRhcHAuY29tPgo+IC0tLQo+IMKgbmV0L3N1bnJwYy9jbG50LmMgfCAxMCArKysrKysr
LS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jCj4g
aW5kZXggYWYwMTc0ZDdjZTVhLi43ZmIzY2RlZjJhNjAgMTAwNjQ0Cj4gLS0tIGEvbmV0L3N1bnJw
Yy9jbG50LmMKPiArKysgYi9uZXQvc3VucnBjL2NsbnQuYwo+IEBAIC0xMDY1LDEwICsxMDY1LDE0
IEBAIHJwY190YXNrX2dldF9uZXh0X3hwcnQoc3RydWN0IHJwY19jbG50ICpjbG50KQo+IMKgc3Rh
dGljCj4gwqB2b2lkIHJwY190YXNrX3NldF90cmFuc3BvcnQoc3RydWN0IHJwY190YXNrICp0YXNr
LCBzdHJ1Y3QgcnBjX2NsbnQKPiAqY2xudCkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBpZiAodGFz
ay0+dGtfeHBydCAmJgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgISh0ZXN0X2JpdChYUFJUX09GRkxJTkUsICZ0YXNrLT50a194cHJ0LQo+ID5zdGF0ZSkg
JiYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodGFz
ay0+dGtfZmxhZ3MgJiBSUENfVEFTS19NT1ZFQUJMRSkpKQo+ICvCoMKgwqDCoMKgwqDCoGlmICh0
YXNrLT50a194cHJ0KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghKHRl
c3RfYml0KFhQUlRfT0ZGTElORSwgJnRhc2stPnRrX3hwcnQtPnN0YXRlKQo+ICYmCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAodGFzay0+dGtfZmxhZ3Mg
JiBSUENfVEFTS19NT1ZFQUJMRSkpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB4cHJ0X3JlbGVhc2UodGFzayk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4cHJ0X3B1dCh0YXNrLT50a194cHJ0KTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuOwo+ICvCoMKgwqDCoMKgwqDCoH0KCvCfmYIgVGhpcyBtYXkgY2FsbCBm
b3IgYSB2My4gSSB0aGluayB5b3UgbWF5IGhhdmUgaW50ZW5kZWQgc29tZXRoaW5nIGxpa2UKCglp
ZiAodGFzay0+dGtfeHBydCkgewoJCWlmICghKHRlc3RfYml0KFhQUlRfT0ZGTElORSwgJnRhc2st
PnRrX3hwcnQtPnN0YXRlKSAmJgoJCSAgICAgICh0YXNrLT50a19mbGFncyAmIFJQQ19UQVNLX01P
VkVBQkxFKSkpCgkJCXJldHVybjsKCQl4cHJ0X3JlbGVhc2UodGFzayk7CgkJeHBydF9wdXQodGFz
ay0+dGtfeHBydCk7Cgl9Cgo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodGFzay0+dGtfZmxhZ3MgJiBS
UENfVEFTS19OT19ST1VORF9ST0JJTikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHRhc2stPnRrX3hwcnQgPSBycGNfdGFza19nZXRfZmlyc3RfeHBydChjbG50KTsKPiDCoMKgwqDC
oMKgwqDCoMKgZWxzZQoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
