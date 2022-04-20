Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30F508FA1
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Apr 2022 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbiDTSoq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Apr 2022 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiDTSop (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Apr 2022 14:44:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008AE419A3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 11:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2qW7Z1ydWq5esbaFDu7nZW6qHMNqsRI7WCGtGdTky9F6oHdpKqltm22JxPxM3mxkLR9ZODGXKVwTbpEL+ZaoI9S241kcN8N5pF8YL5KIEC3hogKDSzNQqeCQIRaFb2wUvJ9TzTFMV8ewW3A8Q+bfowRmj5sn0W2OT8TxSLf9mP6Yhbhpf6Bl0VUY99pO5EoLvMcYhrJC6Vr8eLI7hLMoJQFM3OUXqeLPwE/wHT5zBKeIgPMJD5dTAZEcRBdJtahQbV/Gd8rjDuBg11IChPz3PSBhN7/y8dbN/PSTLK8lmrx/5rv9aX1jlK0TpEK2zrtP8UIZbQLIFvk8Bk91pC2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaWXWHUibaR/eTGwOaqbKHBaaQJ7xNEK001WXqAKieU=;
 b=ct7vlagsfpsXBxrstauGwHLfOtHUYazvTX6G+gIDc+A9bzv5LLA3/RPZx7jbwP7LWfNfSrTDZNILGIJysS1jdqK+LIX52jno6NUxWTaUedjxeQUwHd6j+CFZKt2MAxFx5txWYYxp2sqGZHeU0YRkqdqcCzFii8G9EflQ/VbzatUaGcvr8D0oR3gRoz7S3XMrvuBUf0OdyyJOhcABu0npySJUqjMlR5XRh5+QBnEPkW8pZB/k5dBhgVPT7k5g6aSlZ5EAHJVEA4MRFa7uI6NxxdbzrfKIJwrCJdwBDv5feS+B5JPM3iDQU3V2CG75dZD3WHLAlPpBADlG3andEeanDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaWXWHUibaR/eTGwOaqbKHBaaQJ7xNEK001WXqAKieU=;
 b=TPRiZ1ND28+hbm7alUz5wR1swf0gTvb7d30oipUvGid3WZyl4BZvYIU4plHjnGXfKwNIYrXnFGJx8/AnWg7L95jESF1yc9fsZ7M2pBCX01Aag5BznbPytnKsNq34ViV36CTaT8c4UPZ44ohYlN+crU74kd89M37x0GVA93FW1FE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM4PR13MB5978.namprd13.prod.outlook.com (2603:10b6:8:47::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6; Wed, 20 Apr
 2022 18:41:55 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 18:41:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC release the transport of a relocated task with
 an assigned transport
Thread-Topic: [PATCH 1/1] SUNRPC release the transport of a relocated task
 with an assigned transport
Thread-Index: AQHYVON0V2egYkNuT0WYVsIunZLFkaz5ItSA
Date:   Wed, 20 Apr 2022 18:41:55 +0000
Message-ID: <95d95ddaa7c2d15cbd291f56e053083282ca755f.camel@hammerspace.com>
References: <20220420182121.87341-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20220420182121.87341-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1bbcda2-de46-4dc6-9acd-08da22fd717a
x-ms-traffictypediagnostic: DM4PR13MB5978:EE_
x-microsoft-antispam-prvs: <DM4PR13MB59782719D9EB922568AF4F8DB8F59@DM4PR13MB5978.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POTjsZUvLmuH0uNyRY0SQoWETTTRVAfLsmsdkSFeb3TK6n7K0JHVWRtKHnFfq+L7asVh6DObmOGBLNmwP8fjChXOObfs/H/6Ebkg7xM8wpREPCT7bVZOeoQMEgvthSJzI6dLwbdTPkKxB6UM0jYyVhd6cb4FqBkqDOu1FCJJWqzTSdpkkAVo42Uvinf1IxtqW2VCUlg+7Fv1l/Tv4SHhwmAncR+4NBecNKRbuHFtbp5uopCtnEuQhGQmB2QB8L6/MXjM0AZXGYyALAxDMsG8FDc6WemgiBRRE/fzK2LJUIDs/lVQJ3yGBXxSDx4deaxIyziZ2Sd5vCzwv5gotupAHTvOKMipdZV7zr49c7Hf+hkX4DOUSkIm/zRhYfbiveSdrIiA24IZpBq+9u3H6GPOe45ibvTX1WfhGjktvWyCV7ZCb1r1Rzr246YxjvD8X2SdOTKKAXtp4rNk1qeIFrCeJ41HptXZd9PWAdnGDErDf1ffs8/WZLKJsOtEjcT2fZqcXv1WD2sb+WuKIsr24+UfE1cdeH9HqZvtHTOHiGjHjCapYKvG6shClVUc2xDPWVX4vF9ZGgV7MCaggabsb8OaOhiJjydxAGc9XRfJ9AicH4Q8V4TIrMjZ7gsWs63Tj3a5sCYvV9caQL4RAfhutBPgCw7Hlo6rUXiKo27v9sqiDqIWmZiA8EFPosWsgZLr09kIV8fVVXnoL5fqmNNN6VNAaWVfyTWMxH4LDshwhS4RHMeftOcRWJAJFJ6YLCLX17ur
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(4326008)(71200400001)(64756008)(26005)(66446008)(5660300002)(6506007)(508600001)(8936002)(8676002)(6486002)(36756003)(2906002)(110136005)(38070700005)(38100700002)(2616005)(186003)(122000001)(83380400001)(66476007)(66556008)(86362001)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2w3R0pNMWVWVXZhWE5wSkdaR3RTK0paQ2xBc3JOWVdvR1Exczl1MXlvMlk0?=
 =?utf-8?B?dytQblJWZ0tDaHZrSkxVSXZGd0EyMmE3TERsQmdId2hUMVhTMDhIRDlmUDBw?=
 =?utf-8?B?V25RVm1CbXR2VTNid2lUTkxiL0sxeHhtbTNFM0xCR2pVSVBWWDVBK3FPNkdm?=
 =?utf-8?B?a21pRzhZMmE0UGZGZVpUaDJvdzIyUHFaR2RzMFJMRmtIT0g2M1pmSVJlRlpE?=
 =?utf-8?B?TUpiRUdMWlpDSDZ3MDlyak9Vc2pidzA3dnJkZFJHY3hWbDhCbTN1VlAySE50?=
 =?utf-8?B?RzBvQU9XaTV6N0wvVncyQXZQbU5EUUU4RkhUbnZCVGRlZnZ3K2FLZzNvNzkw?=
 =?utf-8?B?L2xXRy9HOWhSeGI4WHE0ZFM4bG9VRTRjSXloWE9rME53cXlpT3JrMjVPYWI0?=
 =?utf-8?B?MEptM2RsVlhvTUZDTktHcTRJMWxDajAvR3hWeExaQnEzbmg2eWc2Mi9aNFRr?=
 =?utf-8?B?WWYrbUN0SEpXVUkrOXdsbDgzcWZYOGVWSnJxY3lhbGdxUVZ4aWxSRFFPb1Bw?=
 =?utf-8?B?K1RRUnZjdk9kSGNLeXlJamZTUW9aY0NBZ2krZ2dZS0VML05FTkw1aUQ4d3dT?=
 =?utf-8?B?MHl3Sm90MG82cksxcTduS09ia2JONmkzK3Z0RlU4Z1doVTkxYXZTdzFaeFBT?=
 =?utf-8?B?akFCc3VEWit3V1NpTnRDWnRON1FjbkNSL1czQm9ZQXFhL3R5ZFYyRlRVQ1FZ?=
 =?utf-8?B?blk1QXFMN0NncWxkOTAzUm5NdnZNLzVFYUtSYVVYTTRjK2tMUDE5RktNMmxT?=
 =?utf-8?B?WXBnNGh5eTJsTTY1Z3JBOUU0SEd5Q1VjbU5XYnVFTkxLODV2SlhweUJEcjNO?=
 =?utf-8?B?UjI2MFd6STlDMWZMOVBVRjdJQnhtM0kwMTZwTlRZUTkvNmpoUWp6NjJreGQ1?=
 =?utf-8?B?ZVhFMTQxUnBJL0RucHdFTG9vdDB5eHdOYXpSZStQRk1KaFBXWWlKK2tNckhC?=
 =?utf-8?B?UEhpejFOUktDYklWdXJGZGJSSXVWeFdoMTZmbjREbENsYmxDTWxadnFGVm1O?=
 =?utf-8?B?bkpTSWpYZ0FCVXRBaDl3dmxFQjV1VCtITUt3d1RQZXQ2NjUvZTdkenRMSW9M?=
 =?utf-8?B?a1Vaa09WaVVjQ244R3NFUFpPUFlTS01zMXl3U3FGbjRqR0hZSkVZSjdUR0xM?=
 =?utf-8?B?M2tRcmhmNTJKMnBURG9rZ0tmbSt2SWxKVWJHS04wU0NIaE1Yb3AvRElmbzBE?=
 =?utf-8?B?Q2pXRXdpaFdEVEYzdkhBZXIzNGZrajRBcUt4bXpXVmhQd3NqYzd2VTVNWFEy?=
 =?utf-8?B?NVBkN05tQ09DUlptOGNiRVYrUGkvQk0vSk5DZmh0Y2ZKMG0ySHFIUkNoZG45?=
 =?utf-8?B?RFhad0NZTFdOSmtyd3V3RUZqeGxyalpXRXpZN1VGTU9GSHgwNFVmM0JPbG56?=
 =?utf-8?B?cGlsRGN3M2RvdGMxTDc1dGNBRXhEQW9xSnZuQVorME0yVlBTYS9JMWdwMFo0?=
 =?utf-8?B?VUhTZys2OHZ5dmU5TGl4U3l3cmhKMkFqbW1Ud3lSd1BTTGVuWUJmdFdKbU01?=
 =?utf-8?B?dEQ3TjFGc0Vqa3dEQ05BK3JoS1VPMU4venhmK0hHdThQNWZ3eFVTQzlZMjN0?=
 =?utf-8?B?ZkhraFY0SXJ2VCtQVlBjRzlqM2VKL0RVc1NtRG9xR0NQZFRqYTFlMnI2ejB3?=
 =?utf-8?B?K01Va0JPR09BVUN2Vkc5QW95NU8yT2VQOUUwOFhYVjlMaThScmNxRVUwQkdX?=
 =?utf-8?B?N2wraVNYWVNHQ25YZWJxL0FhcmZFZDhKOTZFR0ZWbjQ1M1hJSjZsd1AzOXJ4?=
 =?utf-8?B?bUxHMjE0NU9rakErOTNmeDQ1OXI1aWovWjc2anFWdU9qd3J0Uyt5VW5KOU5y?=
 =?utf-8?B?eDZ0Nk1HaXVTMTB1ZytVMkRDdC9vU1VxbEdWZDFjZHgzb2NrRUE3Y2pqMGhS?=
 =?utf-8?B?OGF6MVNuMDBoM2VZR1hOaWk0SU12L0pGWHJmRE1vZVpNb0dVSjExVlRqM25X?=
 =?utf-8?B?MG9BdDNSbVRJdEpDbURLeWlqMTIwWkdRSTBLWXZyMU1WWFVQSnRvSStQcUN4?=
 =?utf-8?B?Ni9xb0ljODhtc3J0aVBsM3E4NUFhbk1RS2tDbmtyejRta0NtTjdXcVJQalVy?=
 =?utf-8?B?SEIxSW5PTGVVdzc0bzNWaG8xWVZ5cnFLa3dhQ0dIWStZanhnN2w0K2daMmVT?=
 =?utf-8?B?d1ZZSDFHSnBWbzVFV0xWR0lyMmxyOUtiZ1JoZlY0MXJ5cTd2MExESWRNekNa?=
 =?utf-8?B?TUloeXNtY09RUGdBU2U4U3BzQTlrOERwUmdPRTIxU3JFTHJ4R2xPRStRTUhK?=
 =?utf-8?B?NjYvQSsyQ1ozR2RFT294cGVsMFc0c3hhS0t4OUo0WTlteWhrRE1xY09XSUtB?=
 =?utf-8?B?MTl2R1M5cnpVZUlTeGFhN3M0N0twUGMxTzBJMWRFSUJUNXY5U2FGb3RFQTR6?=
 =?utf-8?Q?a//4XPGzqvUdzcr4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69960EFC1D300E4BABFF98FD44A3DEB8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bbcda2-de46-4dc6-9acd-08da22fd717a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 18:41:55.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnVcVpkmo6HII7wnvDN3aiRyH5akT+lod0Zgcnkrylp+tukWfl47ksyGcPxafSQH5sed8CdsHzpv7hgny0+jSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTIwIGF0IDE0OjIxIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToKPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4KPiAKPiBBIHJl
bG9jYXRlZCB0YXNrIG11c3QgcmVsZWFzZSBpdHMgcHJldmlvdXMgdHJhbnNwb3J0Lgo+IAo+IEZp
eGVzOiA4MmVlNDFiODVjZWYxICgiU1VOUlBDIGRvbid0IHJlc2VuZCBhIHRhc2sgb24gYW4gb2Zm
bGluZWQKPiB0cmFuc3BvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxr
b2xnYUBuZXRhcHAuY29tPgo+IC0tLQo+IMKgbmV0L3N1bnJwYy9jbG50LmMgfCA0ICsrKy0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvbmV0L3N1bnJwYy9jbG50LmMgYi9uZXQvc3VucnBjL2NsbnQuYwo+IGluZGV4IGFm
MDE3NGQ3Y2U1YS4uOTVkZTQ1NGE4NThiIDEwMDY0NAo+IC0tLSBhL25ldC9zdW5ycGMvY2xudC5j
Cj4gKysrIGIvbmV0L3N1bnJwYy9jbG50LmMKPiBAQCAtMTA2Nyw4ICsxMDY3LDEwIEBAIHZvaWQg
cnBjX3Rhc2tfc2V0X3RyYW5zcG9ydChzdHJ1Y3QgcnBjX3Rhc2sKPiAqdGFzaywgc3RydWN0IHJw
Y19jbG50ICpjbG50KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodGFzay0+dGtfeHBydCAm
Jgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCEodGVz
dF9iaXQoWFBSVF9PRkZMSU5FLCAmdGFzay0+dGtfeHBydC0KPiA+c3RhdGUpICYmCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHRhc2stPnRrX2ZsYWdz
ICYgUlBDX1RBU0tfTU9WRUFCTEUpKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCh0YXNrLT50a19mbGFncyAmIFJQQ19UQVNLX01PVkVBQkxFKSkpIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhwcnRfcmVs
ZWFzZV93cml0ZSh0YXNrLT50a194cHJ0LCB0YXNrKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybjsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoGlm
ICh0YXNrLT50a19mbGFncyAmIFJQQ19UQVNLX05PX1JPVU5EX1JPQklOKQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgdGFzay0+dGtfeHBydCA9IHJwY190YXNrX2dldF9maXJzdF94
cHJ0KGNsbnQpOwo+IMKgwqDCoMKgwqDCoMKgwqBlbHNlCgoKSSBkb24ndCB0aGluayB0aGlzIHBh
dGNoIGlzIGNvcnJlY3QuIEl0IGlzIGNoYW5naW5nIHRoZSBjYXNlIHdoZXJlCndlJ3JlIG5vdCBj
aGFuZ2luZyB0aGUgdmFsdWUgb2YgdGFzay0+dGtfeHBydCwgd2hpY2ggd2FzIG5ldmVyIGEKcHJv
YmxlbSBiZWZvcmUgY29tbWl0IDgyZWU0MWI4NWNlZi4KCldoYXQgbmVlZHMgdG8gY2hhbmdlIGlz
IHRoZSBjYXNlIHdoZXJlIHRhc2stPnRrX3hwcnQgaXMgc2V0LCBidXQgd2UncmUKZ29pbmcgdG8g
Y2hhbmdlIGl0cyB2YWx1ZSBhbnl3YXkgYmVjYXVzZSBvZiB0aGUgdGVzdHMgZm9yIFhQUlRfT0ZG
TElORQphbmQgUlBDX1RBU0tfTU9WRUFCTEUuCkluIHRoYXQgY2FzZSB3ZSBuZWVkIHRvIGNhbGwg
eHBydF9yZWxlYXNlKCksIGZvbGxvd2VkIGJ5IHhwcnRfcHV0KCkuCk90aGVyd2lzZSB3ZSdyZSBs
ZWFraW5nIHNsb3RzLCBsb2NrcyBhbmQgcmVmZXJlbmNlcyB0byB0aGUgb2xkIHRhc2stCj50a194
cHJ0LgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
