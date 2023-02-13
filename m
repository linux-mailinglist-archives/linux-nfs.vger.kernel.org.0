Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD02694B52
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 16:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBMPi1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 10:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBMPi0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 10:38:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D93E3BD
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 07:38:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clmtVnce74dSXWto2ce4u6a+KGoyhYcmfDtIncLrsOGyeBBaAXYkiUNt8ZaphXvG8o/tyII/kHMTzsd1ZSHJ5O+wyGrglKohKW4uzpisF/poAkpB6BTM8/PQq021yvHJdfZj9wU5Cw1f2dUvXELThTHyJZRiwR1BwNVRHMisqe+CauIDcjMIEG7MbFRJa1+dbdEzlZaK+Xjq802VhoQaAJ75mzoaYg1GZ7c7aH35sv1jnfHX+a3JONjAq/S+9x9X9IkTXe1VyYjyR1pF6S+iSQSs+dediNa0BySRq5RJdORDvM8FjdnlrMQF6SvjYo8plLNuLaoPWBNl57NnjYzY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlclAKFSKc31EbfodRz9tS/H1WWsoJtSubb+mdEQaK8=;
 b=ii5ZHinh1EpLp0r2vKc9tx8Qq9M/OKjwP3TTVmxmj+DtNRiAHCE9IJcXnfsnKm34kdveeLjY21DQjAFcfBFho0PPEXaksdf0Yjjulk3JtaRSK2TuiAYsrs10Dd+LJX2gMCAj5+91bRW3n0TsCAXOlMUSjfbSjl+Uc1ANoK2jsIREZkiKZtHAJ6uwqzUkfmACovDvJCJy0tLqL77Xk7BKlRj6rOOGMlhc/tWzYBhWLFqJI/TqmzwBK+yIyesRc79MHfqAOcMqtMnsSmA8XlVzUYXb/oHMi1Jxj9eevINHQbQ5bDvAj5PY8Cf1X3s+wNwhFI4Pnh/HO7PI15KcsLyzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlclAKFSKc31EbfodRz9tS/H1WWsoJtSubb+mdEQaK8=;
 b=dMcETyyEeRn8F/YrUYeY2HeqPWRFefTGpM4Oe4JYcpzjDZj4peaY1ZIA/92kDTsStlY5XYOF1sbMBMSbRdTmwPEuzTVymMRknKFilopcg4rAvgYW3ts+/tLdMRwpqDhM8+O+aHtu2IgRdibIEDu64wYTI9H3Xv3qu2L914G3OjM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BLAPR13MB4561.namprd13.prod.outlook.com (2603:10b6:208:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 15:38:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%5]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 15:38:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Charles Edward Lever <chuck.lever@oracle.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: question about the performance impact of sec=krb5
Thread-Topic: question about the performance impact of sec=krb5
Thread-Index: AQHZPqeIc1D065FmHkKyiuzVHqYKv67LlteAgAFiJ4CAAAwLgA==
Date:   Mon, 13 Feb 2023 15:38:20 +0000
Message-ID: <8EBEDCF0-BB9E-4F18-9D67-F5CC47F51A96@hammerspace.com>
References: <20230212140148.4F0D.409509F4@e16-tech.com>
 <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
 <CAN-5tyE-DfbJOZCLzpgfEt+2u=UogLKn_gKs6mDbYpRUq+WXsA@mail.gmail.com>
In-Reply-To: <CAN-5tyE-DfbJOZCLzpgfEt+2u=UogLKn_gKs6mDbYpRUq+WXsA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BLAPR13MB4561:EE_
x-ms-office365-filtering-correlation-id: 5f3f12fe-71bb-45fc-3f52-08db0dd85575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxoPW9ELM53QRElHqHl20rNYDSRWhIIMHGl/Oe8E19SNCYiGASY5YBOTOv4sLVhCfZONwT9FyITjF3TL0fe1thvdRl5kLVGNyiQcpAJWvZJZMWozVmDgWUifT+bG3hehWp4oKpNvu5KeFsb9+b3ftaAb8R14m8p8Ao5ZvRndOcug+oY6lcczqFe2uiVi1oImkppLl7v+vU0lTE8FtzmUhy8msl/B5HnS+eEMEyFH1siMFGGi/DKtlPG87tn6n6Lkr76L1w0P2cnL9h123ekrch9zh+2FcBLv7z4VuwkmH41QPKf10iTkzYs5SyeGPNcRlAGuGoKXT/5gS1AJXGJwc7XvkMpiY4O0LFkiYii7isfrQuIiGvm2ffTkzV7PcswuLgY6AEzgvy1zAVnHmG9/g+oJ3+rjkMYlVCO8e3KO4AOqVNdPF/IcGYDcQxtlKZQDeV+dOzj5c+CiWooCAiUR786ay0tOnxCD162hcGWb4yoMCWmYMdkoSMMVBrkBEJS91hjyIOdTSQXaQAqb15XYvSbpU/nMifiW90eihkH6qLD7xMzhx6OzQdhINJqhIXsZeEnyTQ4pXHHnGMkNfuqDD7MhsHsE6+pqP/U6sZTy8owFVb5ZRUGJyOhFqnzAP8kFZgNy9+7a38fiWVI1F6yoAn97kWh+NKEzSsQEM0sHDRrcT+ojtWrwMm1dllSz6pKnWUA5FeawCAN0GOe6uWYLxjkYDkXKUHVgfzeZGYMbGPCDKhwwi1didfvC4BWy0xO+2zKgpvn7V1RjCGIR3rxLIdBiN6acA5v4YKC6Ps+u4qK1vq5wnyT+egrYkh0GeiQk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39830400003)(396003)(451199018)(66899018)(186003)(6512007)(66946007)(76116006)(8676002)(4326008)(71200400001)(966005)(122000001)(54906003)(316002)(86362001)(36756003)(33656002)(53546011)(2616005)(6506007)(38100700002)(38070700005)(66556008)(83380400001)(6916009)(41300700001)(66476007)(478600001)(6486002)(2906002)(64756008)(8936002)(66446008)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEtTMlFYaFJubWxLc1hmbmlJWkp0R3pHQ2lrRGNreEVHVi9hVithOWE1U1dS?=
 =?utf-8?B?NUppNUlWMmhaSFJXUDdTK0Y3NTU0c01tSDlZRVp6aVpUb2lTTVpZYXlkQ0Jp?=
 =?utf-8?B?R1Y3RlNvOHkxYUFJT2FVMU9hT2pJdklSUjJ2ZE12MUdTSXhrcSt4YnZiU0xr?=
 =?utf-8?B?QjZIOExRd3d4aHZzRG5KZEc2bW45ZUhiWFFPcnl4SUpEVFN5K3RjMWF0anFD?=
 =?utf-8?B?VThxdlFwZ1JDbkJ5THNMQzl1SjBRQXd6alJyVFJVanpIdDlVZkRkM2YrdGJV?=
 =?utf-8?B?Rkl1ZjJDKzlDOE1MZG1hNDhFVXpSRTZtdlFJYzYwRG1mZUI3QjZCSWdpOEhK?=
 =?utf-8?B?QVVuOTBrUnVsRTd2WHVEckE3N2tIN1piNTB3cE0wSmo3RnhiV3k5M3BBU1Rn?=
 =?utf-8?B?ckhvZzkrbVdGWllLTmp2ck9hODM3S0ZDaFkrSWwrb2I0RTYxcEtpdnJmbWxk?=
 =?utf-8?B?WWZvM1FCRG15WmdvUmxtaUlNVlZONlJIWnBDUUVVRWFWVDFwVG5UMFdyMElK?=
 =?utf-8?B?YzBoZnlvQlRQTnNxNjBDcmZnNUdkc09yblZCQ3dmdkVkK3grbitVbmtLT252?=
 =?utf-8?B?TEh3TmR4SHJPWmljUGdZUVJ4a3NmM2FZTTZoSFR2RmcxbjRxYmlsRnI4MG1I?=
 =?utf-8?B?Y3lvMTlFQmtwZzNxa1ExSW9mYWRxUC9XZXA3dHBzMEErWnpCd0VKTm9Bekc0?=
 =?utf-8?B?cmtWeWE4MWdZVTZIc2pRWDhuTXU2dGJVOGNOV1VZRFJXeTFMdlpmeEVkbDBE?=
 =?utf-8?B?ZTQrVjA3NXgyMkIzTWUva2ZRNk9EZGErTDBMTlhhSzZyM0plb3F4YVR1UmV0?=
 =?utf-8?B?cEtqWmpiSUJFNm9idXJSNWdKcms5Qi93d1FZVWJFK2FyS0lVNXFtSkV5cnJN?=
 =?utf-8?B?aGtjTHZyQWhFOC85NCtXa0ZSR2pwVGFlcWhhRG9LaHNwdzBKdTFDeG9OaXEw?=
 =?utf-8?B?aGhoeHh0UTJEdThjclNSWnVFVUxBdU9mQWdPbmdFY2hBd2xrN0FKSlRjdWxj?=
 =?utf-8?B?bmtxT1l5S3VZSDB4QmZJQXlqL3gydE9BSkxjVVFTMk0zZ1FXWUJMYXI3dXo4?=
 =?utf-8?B?SDVFU1pBbVRiSHBpbVlSVlp3ZTcrY2lYN0gwVGpSdU5kQ2J3TzZWY1M3UDRR?=
 =?utf-8?B?Qkx6MlJ5WUZ1eGs0eDd4ZThDNWlWNjVtUXZPdUtUV0FqNmFMS3RMTFZvNGVF?=
 =?utf-8?B?TmVSTHkrSGd2TjhpMHNJMXprS3dlaFlxVDVYRndtTm8zbk5uenU5b2xxbWpv?=
 =?utf-8?B?UjVxVHlzQ3lxeWZFOVk5ZlFOcnNYMzVHUmVSd3lLZTZ5clE3THNhS0xiZmZz?=
 =?utf-8?B?Wm5ucWlnMHprdnFTWWhjZDVteUZYNVRHYXMzSjFxcHV1aHpGMEF1L2JTdVZp?=
 =?utf-8?B?eUVMQWZsbGF3eURnZUxnQVZnL2U0ckZDU0ZTS3Vod05WQkVuY0RVL3VQVjRU?=
 =?utf-8?B?Mjg4c3c2WWFXeWNTcEVUTFp1alZWbjZOdCt0aVdkZXVvM2M1MEVYclNLZDVt?=
 =?utf-8?B?eXgzL3dEWjFERStKNW16NHNQMlpNd1Qwam9tcjN1cytsaE1SbHp2WkIwRmFq?=
 =?utf-8?B?dlBrcUppazR0WFJiSGNQWVVRU1pHREx5R2E2MythUWFaV2lLSENjSXNGOUY3?=
 =?utf-8?B?cHgvWjg3S0VPcG5xMTlSL2Q5NHJVTzhhR1U1UjZEUlFMZGVpQi9MTnFNOUR5?=
 =?utf-8?B?MndNUnJUcDFXLzVpR09DQUFKTjRtd1BNbWRPbVFlR1NOLzNsLzlXM3Flb3lh?=
 =?utf-8?B?NGdiTXdPa2tNR0YvQmVxQS8vcUV0UGtIc2NJaUc5MTRiWlJXRlF6WmRCQW12?=
 =?utf-8?B?ZUFwUmVUR1lDWllmdDBhTDVsVFVpSWtnbCtlU2hqRE96dlFqZS9MUU92Nk83?=
 =?utf-8?B?MWZONDRaOUNCNjV0aTJuOHpRMFN4eS9nSVBLY3lWUkIvQ0NVYk9zZExGSkxW?=
 =?utf-8?B?UktvV1lyL3BscjAvNzJ1dmp4ZDlZeXRKRXZPS1VjZ25vWUtFZGlzRVBmY1VR?=
 =?utf-8?B?TDkrY2RhcnNTZ2d1L2xGR0xRUXo1ZVcxZ1ZTSDBuM0ZXbFRaMGxYNnZDMlZv?=
 =?utf-8?B?YVhLbWU1UWk4aERET1dWKzBrc0FDWWQ1WWg0YUtRMEJmOE9QMTVLWUtUL1ND?=
 =?utf-8?B?aWhBdDlnZE1FUG9jbE4xcmE1dXFvRHZiRWZ5OHpwK1RhOE1xV3c2dWQrNW5R?=
 =?utf-8?B?c2R5WFJOWVl0eVc0bTNtYVZXemFuZFZ4OGNaenhWWXk4Rk1zQXBjbmFONkhC?=
 =?utf-8?B?YlhBOCs4MnJ3K1U2RUExQzBSaWF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7533C6944396941A96CD388817490C2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3f12fe-71bb-45fc-3f52-08db0dd85575
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 15:38:20.0744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +sYNSJlnMeWrjhkPgdyHGKHnralytr1YaD3L7T6UIOW3UQs1/QYidEilRFZnhM+te5vLCgwSqDuwNU/OzyLsrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRmViIDEzLCAyMDIzLCBhdCAwOTo1NSwgT2xnYSBLb3JuaWV2c2thaWEgPGFnbG9A
dW1pY2guZWR1PiB3cm90ZToNCj4gDQo+IE9uIFN1biwgRmViIDEyLCAyMDIzIGF0IDE6MDggUE0g
Q2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4g
DQo+PiANCj4+PiBPbiBGZWIgMTIsIDIwMjMsIGF0IDE6MDEgQU0sIFdhbmcgWXVndWkgPHdhbmd5
dWd1aUBlMTYtdGVjaC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEhpLA0KPj4+IA0KPj4+IHF1ZXN0
aW9uIGFib3V0IHRoZSBwZXJmb3JtYW5jZSBvZiBzZWM9a3JiNS4NCj4+PiANCj4+PiBodHRwczov
L2xlYXJuLm1pY3Jvc29mdC5jb20vZW4tdXMvYXp1cmUvYXp1cmUtbmV0YXBwLWZpbGVzL3BlcmZv
cm1hbmNlLWltcGFjdC1rZXJiZXJvcw0KPj4+IFBlcmZvcm1hbmNlIGltcGFjdCBvZiBrcmI1Og0K
Pj4+ICAgICAgQXZlcmFnZSBJT1BTIGRlY3JlYXNlZCBieSA1MyUNCj4+PiAgICAgIEF2ZXJhZ2Ug
dGhyb3VnaHB1dCBkZWNyZWFzZWQgYnkgNTMlDQo+Pj4gICAgICBBdmVyYWdlIGxhdGVuY3kgaW5j
cmVhc2VkIGJ5IDMuMiBtcw0KPj4gDQo+PiBMb29raW5nIGF0IHRoZSBudW1iZXJzIGluIHRoaXMg
YXJ0aWNsZS4uLiB0aGV5IGRvbid0DQo+PiBzZWVtIHF1aXRlIHJpZ2h0LiBIZXJlIGFyZSB0aGUg
b3RoZXJzOg0KPj4gDQo+Pj4gUGVyZm9ybWFuY2UgaW1wYWN0IG9mIGtyYjVpOg0KPj4+ICAgICAg
4oCiIEF2ZXJhZ2UgSU9QUyBkZWNyZWFzZWQgYnkgNTUlDQo+Pj4gICAgICDigKIgQXZlcmFnZSB0
aHJvdWdocHV0IGRlY3JlYXNlZCBieSA1NSUNCj4+PiAgICAgIOKAoiBBdmVyYWdlIGxhdGVuY3kg
aW5jcmVhc2VkIGJ5IDAuNiBtcw0KPj4+IFBlcmZvcm1hbmNlIGltcGFjdCBvZiBrcmI1cDoNCj4+
PiAgICAgIOKAoiBBdmVyYWdlIElPUFMgZGVjcmVhc2VkIGJ5IDc3JQ0KPj4+ICAgICAg4oCiIEF2
ZXJhZ2UgdGhyb3VnaHB1dCBkZWNyZWFzZWQgYnkgNzclDQo+Pj4gICAgICDigKIgQXZlcmFnZSBs
YXRlbmN5IGluY3JlYXNlZCBieSAxLjYgbXMNCj4+IA0KPj4gSSB3b3VsZCBleHBlY3Qga3JiNXAg
dG8gYmUgdGhlIHdvcnN0IGluIHRlcm1zIG9mDQo+PiBsYXRlbmN5LiBBbmQgSSB3b3VsZCBsaWtl
IHRvIHNlZSByb3VuZC10cmlwIG51bWJlcnMNCj4+IHJlcG9ydGVkOiB3aGF0IHBhcnQgb2YgdGhl
IGluY3JlYXNlIGluIGxhdGVuY3kgaXMNCj4+IGR1ZSB0byBzZXJ2ZXIgdmVyc3VzIGNsaWVudCBw
cm9jZXNzaW5nPw0KPj4gDQo+PiBUaGlzIGlzIGFsc28gcmVtYXJrYWJsZToNCj4+IA0KPj4+IFdo
ZW4gbmNvbm5lY3QgaXMgdXNlZCBpbiBMaW51eCwgdGhlIEdTUyBzZWN1cml0eSBjb250ZXh0IGlz
IHNoYXJlZCBiZXR3ZWVuIGFsbCB0aGUgbmNvbm5lY3QgY29ubmVjdGlvbnMgdG8gYSBwYXJ0aWN1
bGFyIHNlcnZlci4gVENQIGlzIGEgcmVsaWFibGUgdHJhbnNwb3J0IHRoYXQgc3VwcG9ydHMgb3V0
LW9mLW9yZGVyIHBhY2tldCBkZWxpdmVyeSB0byBkZWFsIHdpdGggb3V0LW9mLW9yZGVyIHBhY2tl
dHMgaW4gYSBHU1Mgc3RyZWFtLCB1c2luZyBhIHNsaWRpbmcgd2luZG93IG9mIHNlcXVlbmNlIG51
bWJlcnMu4oCvV2hlbiBwYWNrZXRzIG5vdCBpbiB0aGUgc2VxdWVuY2Ugd2luZG93IGFyZSByZWNl
aXZlZCwgdGhlIHNlY3VyaXR5IGNvbnRleHQgaXMgZGlzY2FyZGVkLCBhbmTigK9hIG5ldyBzZWN1
cml0eSBjb250ZXh0IGlzIG5lZ290aWF0ZWQuIEFsbCBtZXNzYWdlcyBzZW50IHdpdGggaW4gdGhl
IG5vdy1kaXNjYXJkZWQgY29udGV4dCBhcmUgbm8gbG9uZ2VyIHZhbGlkLCB0aHVzIHJlcXVpcmlu
ZyB0aGUgbWVzc2FnZXMgdG8gYmUgc2VudCBhZ2Fpbi4gTGFyZ2VyIG51bWJlciBvZiBwYWNrZXRz
IGluIGFuIG5jb25uZWN0IHNldHVwIGNhdXNlIGZyZXF1ZW50IG91dC1vZi13aW5kb3cgcGFja2V0
cywgdHJpZ2dlcmluZyB0aGUgZGVzY3JpYmVkIGJlaGF2aW9yLiBObyBzcGVjaWZpYyBkZWdyYWRh
dGlvbiBwZXJjZW50YWdlcyBjYW4gYmUgc3RhdGVkIHdpdGggdGhpcyBiZWhhdmlvci4NCj4+IA0K
Pj4gDQo+PiBTbywgZG9lcyB0aGlzIG1lYW4gdGhhdCBuY29ubmVjdCBtYWtlcyB0aGUgR1NTIHNl
cXVlbmNlDQo+PiB3aW5kb3cgcHJvYmxlbSB3b3JzZSwgb3IgdGhhdCB3aGVuIGEgd2luZG93IHVu
ZGVycnVuDQo+PiBvY2N1cnMgaXQgaGFzIGJyb2FkZXIgaW1wYWN0IGJlY2F1c2UgbXVsdGlwbGUg
Y29ubmVjdGlvbnMNCj4+IGFyZSBhZmZlY3RlZD8NCj4gDQo+IFllcyBuY29ubmVjdCBtYWtlcyB0
aGUgR1NTIHNlcXVlbmNlIHdpbmRvdyBwcm9ibGVtIHdvcnNlICh2ZXJ5IHR5cGljYWwNCj4gdG8g
Z2VuZXJhdGUgbW9yZSB0aGFuIGdzcyB3aW5kb3cgc2l6ZSBudW1iZXIgb2YgcnBjcyBhbmQgaGF2
ZSBubw0KPiBhYmlsaXR5IHRvIGNvbnRyb2wgaW4gd2hhdCBvcmRlciB0aGV5IHdvdWxkIGJlIHNl
bnQpIGFuZCB5ZXMgYWxsDQo+IGNvbm5lY3Rpb25zIGFyZSBhZmZlY3RlZC4gT05UQVAgYXMgbGlu
dXggdXNlcyAxMjggZ3NzIHdpbmRvdyBzaXplIGJ1dA0KPiB3ZSd2ZSBleHBlcmltZW50ZWQgd2l0
aCBpbmNyZWFzaW5nIGl0IHRvIGxhcmdlciB2YWx1ZXMgYW5kIGl0IHdvdWxkDQo+IHN0aWxsIGNh
dXNlIGlzc3Vlcy4NCj4gDQo+PiBTZWVtcyBsaWtlIG1heWJlIG5jb25uZWN0IHNob3VsZCBzZXQg
dXAgYSB1bmlxdWUgR1NTDQo+PiBjb250ZXh0IGZvciBlYWNoIHhwcnQuIEl0IHdvdWxkIGJlIGhl
bHBmdWwgdG8gZmlsZSBhIGJ1Zy4NCj4gDQo+IEF0IHRoZSB0aW1lIHdoZW4gSSBzYXcgdGhlIGlz
c3VlIGFuZCBhc2tlZCBhYm91dCBpdCAodGhvdWdoIGNhbid0IGZpbmQNCj4gYSByZWZlcmVuY2Ug
bm93KSBJIGdvdCB0aGUgaW1wcmVzc2lvbiB0aGF0IGhhdmluZyBtdWx0aXBsZSBjb250ZXh0cw0K
PiBmb3IgdGhlIHNhbWUgcnBjIGNsaWVudCB3YXMgbm90IGdvaW5nIHRvIGJlIGFjY2VwdGFibGUu
DQo+IA0KDQpXZSBoYXZlIGRpc2N1c3NlZCB0aGlzIGVhcmxpZXIgb24gdGhpcyBtYWlsaW5nIGxp
c3QuIFRvIG1lLCB0aGUgdHdvIGlzc3VlcyBhcmUgc2VwYXJhdGUuDQotIEl0IHdvdWxkIGJlIG5p
Y2UgdG8gZW5mb3JjZSB0aGUgR1NTIHdpbmRvdyBvbiB0aGUgY2xpZW50LCBhbmQgdG8gdGhyb3R0
bGUgZnVydGhlciBSUEMgY2FsbHMgZnJvbSB1c2luZyBhIGNvbnRleHQgb25jZSB0aGUgd2luZG93
IGlzIGZ1bGwuDQotIEl0IG1pZ2h0IGFsc28gYmUgbmljZSB0byBhbGxvdyBmb3IgbXVsdGlwbGUg
Y29udGV4dHMgb24gdGhlIGNsaWVudCBhbmQgdG8gaGF2ZSB0aGVtIGFzc2lnbmVkIG9uIGEgcGVy
LXhwcnQgYmFzaXMgc28gdGhhdCB0aGUgbnVtYmVyIG9mIHNsb3RzIHNjYWxlcyB3aXRoIHRoZSBu
dW1iZXIgb2YgY29ubmVjdGlvbnMuDQoNCk5vdGUgdGhvdWdoLCB0aGF0IHdpbmRvdyBpc3N1ZXMg
ZG8gdGVuZCB0byBiZSBtaXRpZ2F0ZWQgYnkgdGhlIE5GU3Y0LnggKHg+MCkgc2Vzc2lvbnMuIEl0
IHdvdWxkIG1ha2Ugc2Vuc2UgZm9yIHNlcnZlciB2ZW5kb3JzIHRvIGVuc3VyZSB0aGF0IHRoZXkg
bWF0Y2ggdGhlIEdTUyB3aW5kb3cgc2l6ZSB0byB0aGUgbWF4IG51bWJlciBvZiBzZXNzaW9uIHNs
b3RzLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQo=
