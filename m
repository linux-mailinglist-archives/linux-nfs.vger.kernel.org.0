Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137B2694F80
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBMSgx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBMSgw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 13:36:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2113.outbound.protection.outlook.com [40.107.223.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D735FFF
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 10:36:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoMN+IWbYui+xw8ey9JRMm3NuaK5Nm69/tUaKBvWOiamQiOcQje8uP6T0B9BCjhahFdLg6w/2uD5isaYfhk63R6VQk+BbkqhI6iQQvqR5WFvY9/uHa5tpxfAroMcJ5G8Kb7q7qqQ0mk1xWceqLTbDeWo30Lh2/RNU9ODFFKEkAr9VJ4fflWGkjLLY1Bvw9YSWsP+XAZVOLesjAeqBwko78RNV0bJI++sUzRfwvVcVuSsyvyAknPUCmVOC2/8ksAFPd8/ow3pYu1O1UD0iNRoWGevbjtUongkV0qSG1Vs/cNWfTd0j7/RDxaFB+ZLRGD2zQshYDx40O8T8Zrf8k6SNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=964b3N3fp9WaYqBVh5h7SvsX9TY3lTN6tx9beoxmeUM=;
 b=iGyuCFe0wvwdCaxXFOjl4B9K/T90CkdCTnAi9AC1J8f2R97IQHrSSqsLufpTw5CyyuJeEJnISvJV0qInY/DViKMnlt/SUkOj6mgDz3oN1KUiJ8zPu5GzWQ5/YZe7VpPDfeSAR0bPRBjuHUWU3qvGGJeyszhuCB+bqLbEEgH7B13CGqChY4ivC6ds1voAOrxA6KsfIPFYX1Lypq6Yb+ddGco2Vr3vBp3lrmFV4KWTKLiQc0RD/CMPaibaKb9MRBrxrvphX4fbYoihhdeAyiS5uF7M9Sk3YOdw4OFsVw0DJfyNGJAM5j+KURcuo9RcZttZybVk5kNR1rUiR8jPyJYAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=964b3N3fp9WaYqBVh5h7SvsX9TY3lTN6tx9beoxmeUM=;
 b=PZ8aiSqC4C3ovD5QifM2VzQSHPW6Io3yLoJ2pfohrMIgalGLDMbT46y9JZrOY4BBfS0UbWrlzH+WkJuvVd97fXyIzofqxzKqwyAEleX4Bpv38eH1C5DuD5+WuiPPiUQaxhdX1u0OQj8QCfCrSb+jeq4JcMC3KQ3Hu9gNHOrJkCw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5919.namprd13.prod.outlook.com (2603:10b6:a03:43a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 18:36:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%5]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 18:36:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Charles Edward Lever <chuck.lever@oracle.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: question about the performance impact of sec=krb5
Thread-Topic: question about the performance impact of sec=krb5
Thread-Index: AQHZPqeIc1D065FmHkKyiuzVHqYKv67LlteAgAFiJ4CAAAwLgIAAI4iAgAAORIA=
Date:   Mon, 13 Feb 2023 18:36:34 +0000
Message-ID: <5607B484-D25C-4179-8500-08E9CA8FF158@hammerspace.com>
References: <20230212140148.4F0D.409509F4@e16-tech.com>
 <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
 <CAN-5tyE-DfbJOZCLzpgfEt+2u=UogLKn_gKs6mDbYpRUq+WXsA@mail.gmail.com>
 <8EBEDCF0-BB9E-4F18-9D67-F5CC47F51A96@hammerspace.com>
 <CAN-5tyHSJ5zcT9Q5NMuWSZWRmMSu2Qnp9PfH0sjDgYRDWPrQgw@mail.gmail.com>
In-Reply-To: <CAN-5tyHSJ5zcT9Q5NMuWSZWRmMSu2Qnp9PfH0sjDgYRDWPrQgw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5919:EE_
x-ms-office365-filtering-correlation-id: 93ffdb8e-5137-49db-fd01-08db0df13bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: anmNDpHS9ZX47SDZ0yUJOOz2/LBd27rWDMhzS8OhzfiHOrMC+Gu6M0G8LWeYXi4OZkRBQNpK3FBx0lUDkAy7jh5r8nc1auSRzHC0syiPHtmHJsKRRz2QIuTq4qe2a6mRK1571hBfjdgzOhGLwTV3+pRS0PfCmzVm4kKnfYznBawuRMFt3TROEwMRt9AbGQxyyNTztJPF/wqqG+W+ykxQ4WfkTaEwsbsS3WQaEgd+5ImSEQoNKbYPOJSUpBRtr49Q1OrAwpV+7YaowV9PvQKL5d5MNkzgM2lBx6lrppKWB69HoaOWqDyCKvPqukN0yM1VL/oLfD0YSiw5USGReH2WN5xLCnOEdHjqoH48CNw+cgRVfcqHEeF5UbI4utn6QjHaA+4aO9O+7IWt+Z/xaaLTtwslh9a+wO6aLWhS9f87/jdoFdGDi+9DT1fV69cQDJlGxM+iMnZ8ml6hciuiM0F9CiPjwbMzmOZnIADTx91HBKKr+ea7m+Zt+R0hf2WdTdEUiDuNmH7KuJU+GyCxqSSH12Whu+TMLpFB170UzDdQO6xa67/nMMS9kErAXXevJLeBxA79hTWG/BujQcjlSP+rCVsgMb/k1Deh9cMRfFmU/DsN6tOG01mqomvO6qXpQFx4fmAyv+xH1C6Op2lB376PlJ1renpbQnhNQmefmQJ0qJk6x3qQ0tlD4DWrzvF3SOLViBHpqMrnwlWdd6tbmxYIbaCy7bL8xi2kGpNkSykXkhRSi7slYjITBeZ8xAUl4IrR1UrRsr2A0pn1HKXxYvL7+sAI7YEPxzA2/xusIltW1cqOoURy/O7YZOJo2o7jtros
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(136003)(376002)(39840400004)(451199018)(66899018)(54906003)(83380400001)(71200400001)(186003)(33656002)(86362001)(36756003)(6512007)(2616005)(66556008)(5660300002)(66446008)(41300700001)(8936002)(4326008)(66476007)(478600001)(66946007)(6916009)(76116006)(966005)(64756008)(53546011)(6486002)(6506007)(8676002)(2906002)(38100700002)(122000001)(316002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUNFQS9nSFJhNHA2bkp2NFRJMjZJcU42MTVKaTRkSEVISTZqRWVyRTVheEFj?=
 =?utf-8?B?SEhURDd6M0pJSzJyUGV1VzdqK1NDSmVmcjB3UEFKWENTZjJudVU3d3AzU0NE?=
 =?utf-8?B?c0RvOGRsZDg2M3BodUVHelYxdXJ1Q3FWYzRtclNMcTZKNUp6L3dyM1RtcmpU?=
 =?utf-8?B?cFdjbkpNY1VkbW1lUmxDSDUyeVVjbXJvUGpVbFpHa2ZRNkJIY3VtajdlWUM3?=
 =?utf-8?B?ZnhKakQzYTEwallFWFdwTTJNbHZjbUg4cXhjb1BZaFkyTmR6VngzZUhoUW9p?=
 =?utf-8?B?MGtWb2kwVmU4TVk4R3pNTGhNTFJNeWdyZHIyWkJPQnpHVmpVSCtTcHVkZXYr?=
 =?utf-8?B?Q213b1BQWEQ2L2dWNzB5bG5nTG90cjB2RnJiQnNBZmYxb01vQW5RUHFkMmNt?=
 =?utf-8?B?ZG9PajY3U0NZV05XY1lwZW93dDJ3UEM3WXFIejZLMXpHbFJyV3lKRDFnMGZt?=
 =?utf-8?B?b2l4MmFmZE9odWN6Wm04cFpQSDlKZk5Qelc4a2JaWGs0UG1ZbDg3bzFEdU9x?=
 =?utf-8?B?dEJWNFNucTE2ejYwRkphb1U3Z3UyMWFRayt2RExSVE1abkpjMzJka0J4Uk5h?=
 =?utf-8?B?REdkd3BPRDcyVTYrbkpyQzEwZFplNVBMV0dPYTlZS3dMM0R5REE3UlErN2lh?=
 =?utf-8?B?anREWTJoUGk2ejFpeklMRk9oZ1QwZ1ptdGlyMFpOaG42aitIWVBIQzlOaVQx?=
 =?utf-8?B?ekV5QlNOaXVDeTIwc0VpakRjMjJWblMwYjVhVGZxaytsbXoreVcwcDR6RXdp?=
 =?utf-8?B?SzRKSWdFYXVhUk03OUcyZS85ZUE2MWNOT045ME9PelVGd01RdE5zZUxFU1Ja?=
 =?utf-8?B?RVRVN2VWOFMzVWxmZVl5OUpoQXNMdGhmN2VWM3BmMGw3cktYZ3FNMTZ0aTA2?=
 =?utf-8?B?N0ZkSkI0SGdhMTdoSmlXcjhLMkp1eVR4VjBIQ1NhVnY4M0IxSDJsVHd0Tk50?=
 =?utf-8?B?L3pqaUZjWWhJQXFOVC9wUE1Ub2pUamFCS3BhUW5HMjhWVUNwcVVobWpuOVEw?=
 =?utf-8?B?QkFTU3ZRb21IallqV2phQnh0VXlIQzQwZTdtNEdDbmNpVXlnS2NaQVFINmtR?=
 =?utf-8?B?Nk81c1ViZUJnRkQ4L09kUVozNUhFL3d4Vmt2MzFmSlhCWVVRY01tLzVlVTJ4?=
 =?utf-8?B?NjMzSExkQWtSWEI2OTlFazh3dDZrZ3lGU0wwZ3hyRTRRSE1NTE5JUFRBVWhF?=
 =?utf-8?B?cmNFemswYjRnUFAvMmtiYmMvOTB1cGJ4Z2xNYUxKSGt4TmRXcjNmVFY5MjBY?=
 =?utf-8?B?eFhZdmxXaWc5K3AxaVplRi8vQXVPOFJPcjNad0RzaUxydHhxU1ZtREpheVZG?=
 =?utf-8?B?WmZBN2NmWG5zWVlwd29zZnRHaUxnenkvalZ3WWx2QnZROEpOeFNVWDZuQWl3?=
 =?utf-8?B?QUkwNEdIeWJCWEtha1doTjdlMkpsaWRWUFRsbmJrMTZyZ0FrZ2pibktNMXEw?=
 =?utf-8?B?T1N2V2xCOWdTOE5sTExUeUlROCtQSDhzL2dSZnlqazdSOG52ZkdpWkhHblRH?=
 =?utf-8?B?QzY1VWJXQ3UzZEI3blIvQWJjd3pJbGN5d0RqVTdjWUlnY2l2NTFjMnBNV1hu?=
 =?utf-8?B?TjhhNmRGSlVWSlBKN1Y1THhFRkJLcWFPTXRZZWREbmViRXg1Um5ERzFiNWU0?=
 =?utf-8?B?RHo5Y2FPa1JkYjhUK3V0VTlVYnJLTVRBekRsazEyWnZtM3o3LzUzMm9hQm12?=
 =?utf-8?B?WkdqbGxQYTNyN0hjSTNiUjdjL1Exb3JNMEEwaVdQaGdwZVluRDVSbWJIQ1Z4?=
 =?utf-8?B?TXdIdVZKR3lPOVhUdTlnNXYvbXRQUVVVdG5ydjQ1QmlMditFd0ZUTkJ1WGI3?=
 =?utf-8?B?Yjl5cDFpcGVTVDlZNW5mWWxGdzJpV3VSblFtSW9TL1l6Tnd4QUhYK01LK2Zu?=
 =?utf-8?B?dm1Ud0huMEM3MHNkczI3K0VGRlczaVhnM1RhYnczSVhkbXpEUUowS3JZZ0FC?=
 =?utf-8?B?bm1CbVR4ZlpadGxwWWRUM0tnOXRRcHkwaHdEQWlRSHFZcXNHZVlqbzlkWCtU?=
 =?utf-8?B?VGRrUlZlR25nRG1NakJTMUJtOEt1NGFoVUJmd29iR2loTXA4K1RYREp5dzcy?=
 =?utf-8?B?TnN1L0ZDR09DT1dBb1loNlFHWnh3cURMa0V4TzNNU3R6UGJsZWVXL2NvYXQr?=
 =?utf-8?B?U2xoOER0WFVkbXZNbXdYK1VnNEQvb2ZWOUtiVGNxY1FpTVZxeGpBZ0JyZGZv?=
 =?utf-8?B?dGlkRElTSnV5eGJiRFdMRWpoblErVHNRWWVnd2R4V1BsSm1UNDY0OUNwVS90?=
 =?utf-8?B?Z0ZTaWcvTGVSM2VzUTQzM0g3aWZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A201F477E5A464F900328F8F9428CEF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ffdb8e-5137-49db-fd01-08db0df13bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 18:36:34.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLg/Zk3K1kb7TUhks7uKS8sR1tKpHvAI/xW/zGLntMl/vFsCd1Y1dWtyLlBGIipYZB5Fqu6R0BpKys35rii1yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5919
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRmViIDEzLCAyMDIzLCBhdCAxMjo0NSwgT2xnYSBLb3JuaWV2c2thaWEgPGFnbG9A
dW1pY2guZWR1PiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgRmViIDEzLCAyMDIzIGF0IDEwOjM4IEFN
IFRyb25kIE15a2xlYnVzdA0KPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiANCj4+IA0KPj4+IE9uIEZlYiAxMywgMjAyMywgYXQgMDk6NTUsIE9sZ2EgS29ybmlldnNr
YWlhIDxhZ2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gU3VuLCBGZWIgMTIsIDIw
MjMgYXQgMTowOCBQTSBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdy
b3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gRmViIDEyLCAyMDIzLCBhdCAxOjAx
IEFNLCBXYW5nIFl1Z3VpIDx3YW5neXVndWlAZTE2LXRlY2guY29tPiB3cm90ZToNCj4+Pj4+IA0K
Pj4+Pj4gSGksDQo+Pj4+PiANCj4+Pj4+IHF1ZXN0aW9uIGFib3V0IHRoZSBwZXJmb3JtYW5jZSBv
ZiBzZWM9a3JiNS4NCj4+Pj4+IA0KPj4+Pj4gaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2Vu
LXVzL2F6dXJlL2F6dXJlLW5ldGFwcC1maWxlcy9wZXJmb3JtYW5jZS1pbXBhY3Qta2VyYmVyb3MN
Cj4+Pj4+IFBlcmZvcm1hbmNlIGltcGFjdCBvZiBrcmI1Og0KPj4+Pj4gICAgIEF2ZXJhZ2UgSU9Q
UyBkZWNyZWFzZWQgYnkgNTMlDQo+Pj4+PiAgICAgQXZlcmFnZSB0aHJvdWdocHV0IGRlY3JlYXNl
ZCBieSA1MyUNCj4+Pj4+ICAgICBBdmVyYWdlIGxhdGVuY3kgaW5jcmVhc2VkIGJ5IDMuMiBtcw0K
Pj4+PiANCj4+Pj4gTG9va2luZyBhdCB0aGUgbnVtYmVycyBpbiB0aGlzIGFydGljbGUuLi4gdGhl
eSBkb24ndA0KPj4+PiBzZWVtIHF1aXRlIHJpZ2h0LiBIZXJlIGFyZSB0aGUgb3RoZXJzOg0KPj4+
PiANCj4+Pj4+IFBlcmZvcm1hbmNlIGltcGFjdCBvZiBrcmI1aToNCj4+Pj4+ICAgICDigKIgQXZl
cmFnZSBJT1BTIGRlY3JlYXNlZCBieSA1NSUNCj4+Pj4+ICAgICDigKIgQXZlcmFnZSB0aHJvdWdo
cHV0IGRlY3JlYXNlZCBieSA1NSUNCj4+Pj4+ICAgICDigKIgQXZlcmFnZSBsYXRlbmN5IGluY3Jl
YXNlZCBieSAwLjYgbXMNCj4+Pj4+IFBlcmZvcm1hbmNlIGltcGFjdCBvZiBrcmI1cDoNCj4+Pj4+
ICAgICDigKIgQXZlcmFnZSBJT1BTIGRlY3JlYXNlZCBieSA3NyUNCj4+Pj4+ICAgICDigKIgQXZl
cmFnZSB0aHJvdWdocHV0IGRlY3JlYXNlZCBieSA3NyUNCj4+Pj4+ICAgICDigKIgQXZlcmFnZSBs
YXRlbmN5IGluY3JlYXNlZCBieSAxLjYgbXMNCj4+Pj4gDQo+Pj4+IEkgd291bGQgZXhwZWN0IGty
YjVwIHRvIGJlIHRoZSB3b3JzdCBpbiB0ZXJtcyBvZg0KPj4+PiBsYXRlbmN5LiBBbmQgSSB3b3Vs
ZCBsaWtlIHRvIHNlZSByb3VuZC10cmlwIG51bWJlcnMNCj4+Pj4gcmVwb3J0ZWQ6IHdoYXQgcGFy
dCBvZiB0aGUgaW5jcmVhc2UgaW4gbGF0ZW5jeSBpcw0KPj4+PiBkdWUgdG8gc2VydmVyIHZlcnN1
cyBjbGllbnQgcHJvY2Vzc2luZz8NCj4+Pj4gDQo+Pj4+IFRoaXMgaXMgYWxzbyByZW1hcmthYmxl
Og0KPj4+PiANCj4+Pj4+IFdoZW4gbmNvbm5lY3QgaXMgdXNlZCBpbiBMaW51eCwgdGhlIEdTUyBz
ZWN1cml0eSBjb250ZXh0IGlzIHNoYXJlZCBiZXR3ZWVuIGFsbCB0aGUgbmNvbm5lY3QgY29ubmVj
dGlvbnMgdG8gYSBwYXJ0aWN1bGFyIHNlcnZlci4gVENQIGlzIGEgcmVsaWFibGUgdHJhbnNwb3J0
IHRoYXQgc3VwcG9ydHMgb3V0LW9mLW9yZGVyIHBhY2tldCBkZWxpdmVyeSB0byBkZWFsIHdpdGgg
b3V0LW9mLW9yZGVyIHBhY2tldHMgaW4gYSBHU1Mgc3RyZWFtLCB1c2luZyBhIHNsaWRpbmcgd2lu
ZG93IG9mIHNlcXVlbmNlIG51bWJlcnMu4oCvV2hlbiBwYWNrZXRzIG5vdCBpbiB0aGUgc2VxdWVu
Y2Ugd2luZG93IGFyZSByZWNlaXZlZCwgdGhlIHNlY3VyaXR5IGNvbnRleHQgaXMgZGlzY2FyZGVk
LCBhbmTigK9hIG5ldyBzZWN1cml0eSBjb250ZXh0IGlzIG5lZ290aWF0ZWQuIEFsbCBtZXNzYWdl
cyBzZW50IHdpdGggaW4gdGhlIG5vdy1kaXNjYXJkZWQgY29udGV4dCBhcmUgbm8gbG9uZ2VyIHZh
bGlkLCB0aHVzIHJlcXVpcmluZyB0aGUgbWVzc2FnZXMgdG8gYmUgc2VudCBhZ2Fpbi4gTGFyZ2Vy
IG51bWJlciBvZiBwYWNrZXRzIGluIGFuIG5jb25uZWN0IHNldHVwIGNhdXNlIGZyZXF1ZW50IG91
dC1vZi13aW5kb3cgcGFja2V0cywgdHJpZ2dlcmluZyB0aGUgZGVzY3JpYmVkIGJlaGF2aW9yLiBO
byBzcGVjaWZpYyBkZWdyYWRhdGlvbiBwZXJjZW50YWdlcyBjYW4gYmUgc3RhdGVkIHdpdGggdGhp
cyBiZWhhdmlvci4NCj4+Pj4gDQo+Pj4+IA0KPj4+PiBTbywgZG9lcyB0aGlzIG1lYW4gdGhhdCBu
Y29ubmVjdCBtYWtlcyB0aGUgR1NTIHNlcXVlbmNlDQo+Pj4+IHdpbmRvdyBwcm9ibGVtIHdvcnNl
LCBvciB0aGF0IHdoZW4gYSB3aW5kb3cgdW5kZXJydW4NCj4+Pj4gb2NjdXJzIGl0IGhhcyBicm9h
ZGVyIGltcGFjdCBiZWNhdXNlIG11bHRpcGxlIGNvbm5lY3Rpb25zDQo+Pj4+IGFyZSBhZmZlY3Rl
ZD8NCj4+PiANCj4+PiBZZXMgbmNvbm5lY3QgbWFrZXMgdGhlIEdTUyBzZXF1ZW5jZSB3aW5kb3cg
cHJvYmxlbSB3b3JzZSAodmVyeSB0eXBpY2FsDQo+Pj4gdG8gZ2VuZXJhdGUgbW9yZSB0aGFuIGdz
cyB3aW5kb3cgc2l6ZSBudW1iZXIgb2YgcnBjcyBhbmQgaGF2ZSBubw0KPj4+IGFiaWxpdHkgdG8g
Y29udHJvbCBpbiB3aGF0IG9yZGVyIHRoZXkgd291bGQgYmUgc2VudCkgYW5kIHllcyBhbGwNCj4+
PiBjb25uZWN0aW9ucyBhcmUgYWZmZWN0ZWQuIE9OVEFQIGFzIGxpbnV4IHVzZXMgMTI4IGdzcyB3
aW5kb3cgc2l6ZSBidXQNCj4+PiB3ZSd2ZSBleHBlcmltZW50ZWQgd2l0aCBpbmNyZWFzaW5nIGl0
IHRvIGxhcmdlciB2YWx1ZXMgYW5kIGl0IHdvdWxkDQo+Pj4gc3RpbGwgY2F1c2UgaXNzdWVzLg0K
Pj4+IA0KPj4+PiBTZWVtcyBsaWtlIG1heWJlIG5jb25uZWN0IHNob3VsZCBzZXQgdXAgYSB1bmlx
dWUgR1NTDQo+Pj4+IGNvbnRleHQgZm9yIGVhY2ggeHBydC4gSXQgd291bGQgYmUgaGVscGZ1bCB0
byBmaWxlIGEgYnVnLg0KPj4+IA0KPj4+IEF0IHRoZSB0aW1lIHdoZW4gSSBzYXcgdGhlIGlzc3Vl
IGFuZCBhc2tlZCBhYm91dCBpdCAodGhvdWdoIGNhbid0IGZpbmQNCj4+PiBhIHJlZmVyZW5jZSBu
b3cpIEkgZ290IHRoZSBpbXByZXNzaW9uIHRoYXQgaGF2aW5nIG11bHRpcGxlIGNvbnRleHRzDQo+
Pj4gZm9yIHRoZSBzYW1lIHJwYyBjbGllbnQgd2FzIG5vdCBnb2luZyB0byBiZSBhY2NlcHRhYmxl
Lg0KPj4+IA0KPj4gDQo+PiBXZSBoYXZlIGRpc2N1c3NlZCB0aGlzIGVhcmxpZXIgb24gdGhpcyBt
YWlsaW5nIGxpc3QuIFRvIG1lLCB0aGUgdHdvIGlzc3VlcyBhcmUgc2VwYXJhdGUuDQo+PiAtIEl0
IHdvdWxkIGJlIG5pY2UgdG8gZW5mb3JjZSB0aGUgR1NTIHdpbmRvdyBvbiB0aGUgY2xpZW50LCBh
bmQgdG8gdGhyb3R0bGUgZnVydGhlciBSUEMgY2FsbHMgZnJvbSB1c2luZyBhIGNvbnRleHQgb25j
ZSB0aGUgd2luZG93IGlzIGZ1bGwuDQo+PiAtIEl0IG1pZ2h0IGFsc28gYmUgbmljZSB0byBhbGxv
dyBmb3IgbXVsdGlwbGUgY29udGV4dHMgb24gdGhlIGNsaWVudCBhbmQgdG8gaGF2ZSB0aGVtIGFz
c2lnbmVkIG9uIGEgcGVyLXhwcnQgYmFzaXMgc28gdGhhdCB0aGUgbnVtYmVyIG9mIHNsb3RzIHNj
YWxlcyB3aXRoIHRoZSBudW1iZXIgb2YgY29ubmVjdGlvbnMuDQo+PiANCj4+IE5vdGUgdGhvdWdo
LCB0aGF0IHdpbmRvdyBpc3N1ZXMgZG8gdGVuZCB0byBiZSBtaXRpZ2F0ZWQgYnkgdGhlIE5GU3Y0
LnggKHg+MCkgc2Vzc2lvbnMuIEl0IHdvdWxkIG1ha2Ugc2Vuc2UgZm9yIHNlcnZlciB2ZW5kb3Jz
IHRvIGVuc3VyZSB0aGF0IHRoZXkgbWF0Y2ggdGhlIEdTUyB3aW5kb3cgc2l6ZSB0byB0aGUgbWF4
IG51bWJlciBvZiBzZXNzaW9uIHNsb3RzLg0KPiANCj4gTWF0Y2hpbmcgbWF4IHNlc3Npb24gc2xv
dHMgdG8gZ3NzIHdpbmRvdyBzaXplIGRvZXNuJ3QgaGVscCBidXQgcGVyaGFwcw0KPiBteSB1bmRl
cnN0YW5kaW5nIG9mIHRoZSBmbG93IGlzIHdyb25nLiBUeXBpY2FsbHkgYWxsIHRoZXNlIHJ1bnMg
YXJlDQo+IGRvbmUgd2l0aCB0aGUgY2xpZW50J3MgZGVmYXVsdCBzZXNzaW9uIHNsb3QgIyB3aGlj
aCBpcyBvbmx5IDY0c2xvdHMNCj4gKHNlcnZlcidzIHNlc3Npb24gc2xvdCBzaXplIGlzIGhpZ2hl
cikuIFRoZSBzZXNzaW9uIHNsb3QgYXNzaWdubWVudA0KPiBoYXBwZW5zIGFmdGVyIHRoZSBnc3Mg
c2VxdWVuY2UgYXNzaWdubWVudC4gU28gd2UgaGF2ZSBhIGJ1bmNoIG9mDQo+IHJlcXVlc3RzIHRo
YXQgaGF2ZSBnb3R0ZW4gZ3NzIHNlcXVlbmNlIG51bWJlcnMgdGhhdCBleGNlZWQgdGhlIHdpbmRv
dw0KPiBzbG90IGFuZCB0aGVuIHRoZXkgZ28gd2FpdCBmb3IgdGhlIHNsb3QgYXNzaWdubWVudCBi
dXQgd2hlbiB0aGV5IGFyZQ0KPiBzZW50IHRoZXkgYXJlIGFscmVhZHkgb3V0IG9mIHNlcXVlbmNl
IHdpbmRvdy4NCj4gDQoNClRoZSBORlN2NC54IHNlc3Npb24gc2xvdCBpcyBub3JtYWxseSBhc3Np
Z25lZCBiZWZvcmUgd2Uga2ljayBvZmYgdGhlIFJQQyBzdGF0ZSBtYWNoaW5lIGluIOKAmGNhbGxf
c3RhcnQoKeKAmS4gU28gaWYgeW91IGFyZSBsaW1pdGVkIHRvIDY0IHNlc3Npb24gc2xvdHMsIHRo
ZW4gdGhhdCB3aWxsIHByZXZlbnQgeW91IGZyb20gZXhjZWVkaW5nIHRoZSBHU1MgMTI4IGVudHJ5
IHdpbmRvdy4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
