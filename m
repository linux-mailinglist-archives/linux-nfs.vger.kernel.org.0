Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E644C4FC6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 21:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiBYUmA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 15:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiBYUl6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 15:41:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2110.outbound.protection.outlook.com [40.107.236.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491A2177C5
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 12:41:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noxYx3MFH/SEQNYahPgo0G+CArn9aIjXJWRrm7CAayQ0H2mDA9Wq94tA2MwBceymRZD6s04d95Z8Ep2AfcPNvP9sOWxlj3kPM48Oag1oN7PUkI4lY2FA3ZZ/+ei1dPp3y6oyGgQM5gisQ5liJSR1oU0/wOQxDQ4gv9dfbqCP8dwuJVnnlEIeZq/KQEbMpCG0YwCggNvt/IzWErFcYOebdPrK88kJDhggpk6xv42m/y53pQISVOCCX0XvaXwLCjNIbxyzRSGyXy0JLoHIv1gssiVpIbphYgTFDnEEFVIfODCI5qxGf+TQE+5AYnK4+NcPQF56uyrOqwjtGZ9hqycjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/sFGGS8MLD0ajQoDwYhqRAFRYWD5osFeEDhrugh624=;
 b=EApmd79GummlFTzLJoGWF3nQk9OS48JdwaHy+bMQXmOCMauvxlmEf+R76r8eKSaXq/WQvVSelq+xCY8J8NsAfgLeWEHlFiceGB0yDPqmII43JUrBJB8ThUlm5FjrVmk1Shs4IRN4uI2ZBsj0SOwfz2sQEVYPhJLLG2I5WjoH6WFvKx5W7U/le1fAZ2IbndEw17tSv93BHOY74+rrCN5ihXRyx6eRwB4kzrzyXZH8ukCHgGQJyANY34v/czCdG5kIWWB5jWEOWAXXdo3+AVYS5AvWzb1b2tz9+4Hz/LWAdy0VO0ChtlrWgwj//uD3CpwjahadyCn0Wl8VGO0IUGZh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/sFGGS8MLD0ajQoDwYhqRAFRYWD5osFeEDhrugh624=;
 b=Czk4561qVI3ULyXBl2MeQQXrFUz9KaSZfyoioh4HNcu81QQg4nqnsZgmj0P7DodvmsVS878ZuXps2zHCyNsHGaC6xZBKyfpXToF91rsZmt0xJMB7ReX/1OcatmNQ3a3cHNR4pRI3e+3mN6w9C9x4Kwhzap0u9IYe8K5Z2XS61Bw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB2782.namprd13.prod.outlook.com (2603:10b6:208:f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 20:41:22 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.010; Fri, 25 Feb 2022
 20:41:22 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 05/21] NFS: Store the change attribute in the directory
 page cache
Thread-Topic: [PATCH v7 05/21] NFS: Store the change attribute in the
 directory page cache
Thread-Index: AQHYKPs4DPebyPXb0kmsTNMhrdh+Eqyiyo0AgADBr4CAABeuAIAAgosAgAAZkwCAABpUAIAACXGAgAAEpYCAAFDHAIAABOcA
Date:   Fri, 25 Feb 2022 20:41:22 +0000
Message-ID: <a9411640329ed06dd7306bbdbdf251097c5e3411.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <20220223211305.296816-6-trondmy@kernel.org>
         <0DBE97BF-3A88-49FD-B078-012B5EDA5849@redhat.com>
         <1ca16f7e7be9588d15525e3afa4f7a80eb66b12b.camel@hammerspace.com>
         <9506801a7b7b6330ce2807721da5e03d77cf5c78.camel@hammerspace.com>
         <640B2705-35C6-4E9E-89D2-CC3D0E10EC3A@redhat.com>
         <eb2a551096bb3537a9de7091d203e0cbff8dc6be.camel@hammerspace.com>
         <11744FC6-5EFB-427A-ADB4-D211BA1C74F4@redhat.com>
         <f9ca09baa9e41000ab6286a27de567ca306f6991.camel@hammerspace.com>
         <6878D746-0A5E-4815-A520-5CE7CD98A1E2@redhat.com>
         <FDB38E78-8980-46CA-B936-F82C7C104071@redhat.com>
In-Reply-To: <FDB38E78-8980-46CA-B936-F82C7C104071@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23a8f32c-73d9-4294-15df-08d9f89f2f05
x-ms-traffictypediagnostic: MN2PR13MB2782:EE_
x-microsoft-antispam-prvs: <MN2PR13MB27824F4E4152CE9F52DD31CDB83E9@MN2PR13MB2782.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOFLhpTaeOHbu2NFIH6grXIhtgbOPPDBYcZYep+QhwYHjMpOjAfwsbrDqw3rnIgnxz81we9m6Vk2cLm+DF50ZS2aswoepiNQu0ZvVypeVyrEDMKXJltsdjfIjDa/L0fj44ZmiUlmjy8Nlmu+UwqB1mhOSV1NZsTJEQpzh3OsPVlDWUT+ARIWL8qYfoP0CPdt1cyeJLgA0TLj++ZFYJP53iIVktL2IJmx6W0KS9TufPTApgh2G/cDr/8kNDmAZjDjM+eRTd9foL53p1N19fpFFnHO/HFs4hQdghnWfZ3CH+AL6m1yf76ztvUV64At/gg3Nrgr18dYFxVPuIoatolmn24/76U+824zC1ePW2MuF5iGhZnRhGymST9FzJJAHurN+hkZjRsYu9+Ck7fWYun63tJPUXnLOxCeTDqqGSCB6+vWGwt3w/DMXua0bYFnXCzC+pcfzskkQAeWIzUslcYhgVcadVIRmFFDl31Q1VpHa4aFofwOvje75K1mg8RzMK3Im1pJhehpnOMxqllTaTEFmGK+vsmuh64mS166PxGbx69WyAPbVgIuNzdidunatQPyfK0rUyDaRV2iIpcxI6fkbKKCoo8mjNpckghkGhWHzCZQII6JSDkKvtJCTip0uTkwD4uJaz0V0mhDrWgl5WXJg4n/43LoA06PeKmhXDBL9EQS1liP53Y5mzCZ3kpVtGifsa2pPUWhmTlvIUokyl3XgmFV2WAFmuP2v84Aypbz72ePqB0BiRdaSNKNbGPmFC36
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(396003)(366004)(376002)(39840400004)(346002)(8936002)(38100700002)(76116006)(6916009)(6512007)(6506007)(64756008)(66946007)(66446008)(5660300002)(8676002)(53546011)(66556008)(36756003)(83380400001)(66476007)(4326008)(71200400001)(2616005)(26005)(122000001)(38070700005)(2906002)(186003)(508600001)(6486002)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDhWM3B0ODNscldQRGN6cExRS1k3c2pFS2JVTzNxRmU4VnFrMUU0M0FuaEZY?=
 =?utf-8?B?RDNlTlJoLzg4TFU4MzJlMm1XNUhTVlM1TjM5NTZHdzNRMjF1T3c1ei9PWlE4?=
 =?utf-8?B?WHg4VlZUYkpWa3NQRlQwa1gxR0pSZW1sWitpS0RUQUZjaXRmOHFtZDRrbDZ1?=
 =?utf-8?B?UmpuekdFZ2lkOU5EbXB4eUNDRVFvdTY3T1lkeTNLbENlZSsydVRveFRtN3Ev?=
 =?utf-8?B?VVR2aHF1dWpacDlnVnM1Zkg2aS9maHhLREptQlNQNkc1cXd5Rk1QU0I3TC9p?=
 =?utf-8?B?cm5tM3VWWmtKUXV3cHY2ZVhFWHFra043bnZSbXc0dnF6eVZTRlRramxjZTRs?=
 =?utf-8?B?ZGQ4TnJzWjhmWFFoejNOdUh6RkE1RldPZ0cxaEErdXJ5RklhUGIvYUdkblFY?=
 =?utf-8?B?WVRKYm45SDUvdzQ3aytVU0l5bGE5em1PTm9DUUlGSEdqVVVWVGhVMmtPQVRz?=
 =?utf-8?B?L0ZTT05SK1M0UHRGc0JlVW1oaU9FdDBBWHQ3dFJVNEkwdFh2U2RhY1BWS1Zv?=
 =?utf-8?B?ZHNmaUxrNnRRNm80bVV0ZGRxdGhKa1N5d0lpa3NOYXdXTVA4R29KcUxlTXBo?=
 =?utf-8?B?OVJWVDdMZVRXVy93QzdKM2JiSitxemtMZGpqQkMxWEV6Tk5Md3UrMUwyakVY?=
 =?utf-8?B?WmhOa1d1THpCUXlBMm1FM2VyT3dDcGVpK3lXMEZGZ1BUYTk0QnBUaTRHajkw?=
 =?utf-8?B?U0ZoZDJ5K0o0VVlIdVB5d1IySFAyNnlDeXdEamtIV0ZaMWVGQ24wQTJjRXll?=
 =?utf-8?B?V2lTTGpOWEJWc0NseHI5VmQyWmc0cUdYRVRjQXRQbi9uT3BHeGd6eFpUODVq?=
 =?utf-8?B?SXBoT3Nick45ME9weC9LUDBIVHJObCt0RWVoUjFCK3BhTURRT045MEorbEwy?=
 =?utf-8?B?WWV4aWRyN0RBVzRYd1oxTFNQZ25wRW5abDJLYy9Jd3U5TG5PRkt6UEJwRzd5?=
 =?utf-8?B?Sm9oL3Z3djk2UkFrTS9RbllFTlVoaEw3anYwb1ZCU01wVXphZHNySDhELzdC?=
 =?utf-8?B?eEZRYXNXaFNqb0lnZzZEeURaVG1RM0hVeUkvK2pRa0JhY0UxYVJDTUNnanFj?=
 =?utf-8?B?TldVQ2wwM1JSTllzS2VpbVY0cldvY0Nvd1NPUVlYekNoQ3RYV1ZCdDhKYk84?=
 =?utf-8?B?MnB3M1hHUnVVQlhoNHMyZ2RTVHZoSEcxMGd2alBrOHp3Qm5tMzI3RXJuVHZM?=
 =?utf-8?B?MzBQNHREZFpBTFpRTmlJT1Y4bjFIaUgyVWI5anpvcEFiY01tTTFnbDlpK3Vu?=
 =?utf-8?B?bmJsQkswR3drU2dsVU8va0t1VEhha3FGV1owd2UwYmxBdXI1WS9aYkFlMGlM?=
 =?utf-8?B?VU9TYm5oREtWaXV4NWNhakV6Rjd4ZC80anp3RjVjY21vMVhsS2lxNUFXTTZo?=
 =?utf-8?B?TnBKMGpxbVZZZE5TSkEwYStRbnBEeEZ2VmVtaS9iTFhkbFljajl3a08zZngx?=
 =?utf-8?B?d1JFYzArS2JYWndBMmRqc1c4bjBucWFUSEc2c1lDcVFHeHpZOGJtdlkvN3RS?=
 =?utf-8?B?Q3BCYnRKRENYMHZnS3lLMUNBV1JQTWZLRWRBbFQ2cFJRY2tsbE5EOWtsbUdO?=
 =?utf-8?B?TUNNelBHR3lJa29aS2lkajVaZzViTVhKSlRGZ2pGMC9pZlhNRks5bGI2ZHhw?=
 =?utf-8?B?RXBYd1VMMG8rUStnSFpKQnR3K0VHUjhVV29qdDNOMXBaK2tUN2c2WTJPWDZR?=
 =?utf-8?B?bndIRFd0NDhRS3I2bEJ5N29NTXdpR3M5a2hhalR1V29sck9qMWdRbzhpQ1dx?=
 =?utf-8?B?VzdiOTdtZnpXcmQ2RVlzNnRJdmRMUVB0Z3RocGVNZnR0dzdGeE1mUWlGUVRE?=
 =?utf-8?B?YmMxZE81VXdEc2c0MVVrSWk5L0pmVnhzejVkWnk4cmhLT3BoeVpkZ0JJdjhj?=
 =?utf-8?B?VjdLTjByZXZiV3dBNGR5ODdMUlJHOFE3RCt0UlZzYitUUDk4WndlU2JvaTVx?=
 =?utf-8?B?UVRxVXFTY2VobFhhRkllRXlGK2R0VlNUTVVLY3hBUDByTTdXbHJ0aHhhWk9u?=
 =?utf-8?B?bXZHa0QzY3pPM1lYYXNIRm9NMER6SWI2bEJ3VHllM0pHQTRDMVZsQzJJMUxh?=
 =?utf-8?B?ejZaeWVObTVQMnJCajdQR3A1bWxyVlpyOWFmUTlKMnRGTEFwUHRzTmJTL1Jj?=
 =?utf-8?B?UlRtSzJVWEh2YTVKSTk3T0IrRlBONmRHeW1qZG56WnFvTVZRWWMxVXlkQ2o3?=
 =?utf-8?Q?mTs3bSqTb/0N76bY0/f67jo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAD1677D97ED1042AE10D3A908361163@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a8f32c-73d9-4294-15df-08d9f89f2f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 20:41:22.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQLsPqRAJMk6x4G2PEChcJh378x+xwRwePQu7JoHgWbhOE6GVB+i7f8M2XEKiTstF1MzMeoD+zRmuAsY0ovfJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTI1IGF0IDE1OjIzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOgo+IE9uIDI1IEZlYiAyMDIyLCBhdCAxMDozNCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90
ZToKPiA+IE9rLCBzbyBJJ20gcmVhZGluZyB0aGF0IGZ1cnRoZXIgcHJvb2YgaXMgcmVxdWlyZWQs
IGFuZCBJJ20gaGFwcHkgdG8KPiA+IGRvIAo+ID4gdGhlCj4gPiB3b3JrLsKgIFRoYW5rcyBmb3Ig
dGhlIHJlcGxpZXMgaGVyZSBhbmQgZWxzZXdoZXJlLgo+IAo+IEhlcmUncyBhbiBleGFtcGxlIG9m
IHRoaXMgcHJvYmxlbSBvbiBhIHRtcGZzIGV4cG9ydCB1c2luZyB2OCBvZiB5b3VyCj4gcGF0Y2hz
ZXQgd2l0aCB0aGUgZml4IHRvIHNldCB0aGUgY2hhbmdlX2F0dHIgaW4KPiBuZnNfcmVhZGRpcl9w
YWdlX2luaXRfYXJyYXkoKS4KPiAKPiBJJ20gdXNpbmcgdG1wZnMsIGJlY2F1c2UgaXQgcmVsaWFi
bHkgb3JkZXJzIGNvb2tpZXMgaW4gcmV2ZXJzZSBvcmRlcgo+IG9mCj4gY3JlYXRpb24gKG9yIHBl
cmhhcHMgc29ydGVkIGJ5IG5hbWUpLgo+IAo+IFRoZSBwcm9ncmFtIGRyaXZlcyBib3RoIHRoZSBj
bGllbnQtc2lkZSBhbmQgc2VydmVyLXNpZGUgLSBzbyBvbiB0aGlzCj4gb25lCj4gc3lzdGVtLCAv
ZXhwb3J0cy90bXBmcyBpczoKPiB0bXBmcyAvZXhwb3J0cy90bXBmcyB0bXBmcyBydyxzZWNsYWJl
bCxyZWxhdGltZSxzaXplPTEwMjQwMGsgMCAwCj4gCj4gYW5kIC9tbnQvbG9jYWxob3N0IGlzOgo+
IGxvY2FsaG9zdDovZXhwb3J0cy90bXBmcyAvbW50L2xvY2FsaG9zdC90bXBmcyBuZnM0IAo+IHJ3
LHJlbGF0aW1lLHZlcnM9NC4xLHJzaXplPTEwNDg1NzYsd3NpemU9MTA0ODU3NixuYW1sZW49MjU1
LGhhcmQscHJvdAo+IG89dGNwLHRpbWVvPTYwMCxyZXRyYW5zPTIsc2VjPXN5cyxjbGllbnRhZGRy
PTEyNy4wLjAuMSxsb2NhbF9sb2NrPW5vbgo+IGUsYWRkcj0xMjcuMC4wLjEgCj4gMCAwCj4gCj4g
VGhlIHByb2dyYW0gY3JlYXRlcyAyNTYgZmlsZXMgb24gdGhlIHNlcnZlciwgd2Fsa3MgdGhyb3Vn
aCB0aGVtIG9uY2UKPiBvbiAKPiB0aGUKPiBjbGllbnQsIGRlbGV0ZXMgdGhlIGxhc3QgMTI3IG9u
IHRoZSBzZXJ2ZXIsIGRyb3BzIHRoZSBmaXJzdCBwYWdlIGZyb20KPiB0aGUKPiBwYWdlY2FjaGUs
IGFuZCB3YWxrcyB0aHJvdWdoIHRoZW0gYWdhaW4gb24gdGhlIGNsaWVudC4KPiAKPiBUaGUgc2Vj
b25kIGxpc3RpbmcgcHJvZHVjZXMgMTI0IGR1cGxpY2F0ZSBlbnRyaWVzLgo+IAo+IEkganVzdCBo
YXZlIHRvIHNheSBhZ2FpbjogdGhpcyBiZWhhdmlvciBpcyBfbmV3XyAoYnV0IG5vdCBuZXcgdG8g
bWUpLAo+IGFuZCBpdAo+IGlzIGFic29sdXRlbHkgZ29pbmcgdG8gY3JvcCB1cCBvbiBvdXIgY3Vz
dG9tZXIncyBzeXN0ZW1zIHRoYXQgYXJlIAo+IHdhbGtpbmcKPiB0aHJvdWdoIG1pbGxpb25zIG9m
IGRpcmVjdG9yeSBlbnRyaWVzIG9uIGxvYWRlZCBzZXJ2ZXJzIHVuZGVyIG1lbW9yeQo+IHByZXNz
dXJlLsKgIFRoZSBkaXJlY3RvcnkgbGlzdGluZ3MgYXMgYSB3aG9sZSBiZWNvbWUgdmVyeSBsaWtl
bHkgdG8gYmUKPiBub25zZW5zZSBhdCByYW5kb20gdGltZXMuwqAgSSByZWFsaXplIHRoZXkgYXJl
IG5vdCAvc3VwcG9zZWQvIHRvIGJlIAo+IGNvaGVyZW50LAo+IGJ1dCB3aGF0IHdlJ3JlIGdldHRp
bmcgaGVyZSBpcyBnb2luZyB0byBiZSBmYXIgZmFyIGxlc3MgY29oZXJlbnQsIGFuZAo+IGl0cwo+
IGdvaW5nIHRvIGJlIGEgbWVzcy4KPiAKPiBUaGVyZSBhcmUgb3RoZXIgc2NlbmFyaW9zIHRoYXQg
YXJlIHdvcnNlIHdoZW4gdGhlIGNvb2tpZXMgYXJlbid0IAo+IG9yZGVyZWQsCj4geW91IGNhbiBl
bmQgdXAgd2l0aCBFT0YsIG9yIGdldCBpbnRvIHJlcGVhdGluZyBwYXR0ZXJucy4KPiAKPiBQbGVh
c2UgY29tcGFyZSB0aGlzIHdpdGggdjMsIGFuZCBiZWZvcmUgdGhpcyBwYXRjaHNldCwgYW5kIHRl
bGwgbWUgaWYKPiBJJ20KPiBub3QganVzdGlmaWVkIHBsYXlpbmcgY2hpY2tlbiBsaXR0bGUuCj4g
Cj4gSGVyZSdzIHdoYXQgSSBkbyB0byBydW4gdGhpczoKPiAKPiBtb3VudCAtdCB0bXBmcyAtb3Np
emU9MTAwTSB0bXBmcyAvZXhwb3J0cy90bXBmcy8KPiBleHBvcnRmcyAtb2ZzaWQ9MCAqOi9leHBv
cnRzCj4gZXhwb3J0ZnMgLW9mc2lkPTEgKjovZXhwb3J0cy90bXBmcwo+IG1vdW50IC10IG5mcyAt
b3Y0LjEsc2VjPXN5cyBsb2NhbGhvc3Q6L2V4cG9ydHMgL21udC9sb2NhbGhvc3QKPiAuL2dldGRl
bnRzMgo+IAo+IENvbXBhcmUgIkxpc3RpbmcgMSIgd2l0aCAiTGlzdGluZyAyIi4KPiAKPiBJIHdv
dWxkIGFsc28gZG8gYSAicm0gLWYgL2V4cG9ydC90bXBmcy8qIiBiZXR3ZWVuIGVhY2ggcnVuLgo+
IAo+IFRoYW5rcyBhZ2FpbiBmb3IgeW91ciB0aW1lIGFuZCB3b3JrLgo+IAo+IEJlbgo+IAo+ICNk
ZWZpbmUgX0dOVV9TT1VSQ0UKPiAjaW5jbHVkZSA8c3RkaW8uaD4KPiAjaW5jbHVkZSA8dW5pc3Rk
Lmg+Cj4gI2luY2x1ZGUgPGZjbnRsLmg+Cj4gI2luY2x1ZGUgPHNjaGVkLmg+Cj4gI2luY2x1ZGUg
PHN5cy90eXBlcy5oPgo+ICNpbmNsdWRlIDxzeXMvc3RhdC5oPgo+ICNpbmNsdWRlIDxzeXMvc3lz
Y2FsbC5oPgo+ICNpbmNsdWRlIDxzdHJpbmcuaD4KPiAKPiAjZGVmaW5lIE5GU0RJUiAiL21udC9s
b2NhbGhvc3QvdG1wZnMiCj4gI2RlZmluZSBMT0NESVIgIi9leHBvcnRzL3RtcGZzIgo+ICNkZWZp
bmUgQlVGX1NJWkUgNDA5Ngo+IAo+IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKPiB7
Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBpLCBkaXJfZmQsIGJwb3MsIHRvdGFsID0gMDsKPiDCoMKg
wqDCoCBzaXplX3QgbnJlYWQ7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBsaW51eF9kaXJlbnQg
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG9uZ8KgwqDCoMKgwqDCoMKgwqDC
oMKgIGRfaW5vOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb2ZmX3TCoMKgwqDC
oMKgwqDCoMKgwqAgZF9vZmY7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZCBzaG9ydCBkX3JlY2xlbjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNo
YXLCoMKgwqDCoMKgwqDCoMKgwqDCoCBkX25hbWVbXTsKPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiDC
oMKgwqDCoCBzdHJ1Y3QgbGludXhfZGlyZW50ICpkOwo+IMKgwqDCoMKgwqDCoMKgwqBjaGFyIGJ1
ZltCVUZfU0laRV07Cj4gCj4gwqDCoMKgwqAgLyogY3JlYXRlIGZpbGVzOiAqLwo+IMKgwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCAyNTY7IGkrKykgewo+IMKgwqDCoMKgwqDCoMKgwqAgc3ByaW50Zihi
dWYsIExPQ0RJUiAiL2ZpbGVfJTAzZCIsIGkpOwo+IMKgwqDCoMKgwqDCoMKgwqAgY2xvc2Uob3Bl
bihidWYsIE9fQ1JFQVQsIDY2NikpOwo+IMKgwqDCoMKgIH0KPiAKPiDCoMKgwqDCoMKgwqDCoMKg
ZGlyX2ZkID0gb3BlbihORlNESVIsCj4gT19SRE9OTFl8T19OT05CTE9DS3xPX0RJUkVDVE9SWXxP
X0NMT0VYRUMpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZGlyX2ZkIDwgMCkgewo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGVycm9yKCJjYW5ub3Qgb3BlbiBkaXIiKTsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAxOwo+IMKgwqDCoMKgwqDCoMKgwqB9
Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoHdoaWxlICgxKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBucmVhZCA9IHN5c2NhbGwoU1lTX2dldGRlbnRzLCBkaXJfZmQsIGJ1ZiwgQlVG
X1NJWkUpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG5yZWFkID09IDAg
fHwgbnJlYWQgPT0gLTEpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmb3IgKGJw
b3MgPSAwOyBicG9zIDwgbnJlYWQ7KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGQgPSAo
c3RydWN0IGxpbnV4X2RpcmVudCAqKSAoYnVmICsgYnBvcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHByaW50ZigiJXNcbiIsIGQtPmRfbmFtZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRvdGFsKys7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJwb3MgKz0gZC0+ZF9yZWNs
ZW47Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqAgfQo+IMKgwqDCoMKgIHByaW50Zigi
TGlzdGluZyAxOiAlZCB0b3RhbCBkaXJlbnRzXG4iLCB0b3RhbCk7Cj4gCj4gwqDCoMKgwqAgLyog
cmV3aW5kICovCj4gwqDCoMKgwqAgbHNlZWsoZGlyX2ZkLCAwLCBTRUVLX1NFVCk7Cj4gCj4gwqDC
oMKgwqAgLyogZHJvcCB0aGUgZmlyc3QgcGFnZSAqLwo+IMKgwqDCoMKgIHBvc2l4X2ZhZHZpc2Uo
ZGlyX2ZkLCAwLCA0MDk2LCBQT1NJWF9GQURWX0RPTlRORUVEKTsKPiAKPiDCoMKgwqDCoCAvKiBk
ZWxldGUgdGhlIGxhc3QgMTI3IGZpbGVzOiAqLwo+IMKgwqDCoMKgIGZvciAoaSA9IDEyNzsgaSA8
IDI1NjsgaSsrKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBzcHJpbnRmKGJ1ZiwgTE9DRElSICIvZmls
ZV8lMDNkIiwgaSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCB1bmxpbmsoYnVmKTsKPiDCoMKgwqDCoCB9
Cj4gCj4gwqDCoMKgwqAgdG90YWwgPSAwOwo+IMKgwqDCoMKgwqDCoMKgwqB3aGlsZSAoMSkgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbnJlYWQgPSBzeXNjYWxsKFNZU19nZXRk
ZW50cywgZGlyX2ZkLCBidWYsIEJVRl9TSVpFKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChucmVhZCA9PSAwIHx8IG5yZWFkID09IC0xKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZm9yIChicG9zID0gMDsgYnBvcyA8IG5yZWFkOykgewo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkID0gKHN0cnVjdCBsaW51eF9kaXJlbnQgKikgKGJ1ZiArIGJwb3Mp
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludGYoIiVzXG4iLCBkLT5kX25hbWUpOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0b3RhbCsrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBicG9zICs9IGQtPmRfcmVjbGVuOwo+IMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKg
IH0KPiDCoMKgwqDCoCBwcmludGYoIkxpc3RpbmcgMjogJWQgdG90YWwgZGlyZW50c1xuIiwgdG90
YWwpOwo+IAo+IMKgwqDCoMKgwqDCoMKgwqBjbG9zZShkaXJfZmQpOwo+IMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gMDsKPiB9CgoKdG1wZnMgaXMgYnJva2VuIG9uIHRoZSBzZXJ2ZXIuIEl0IGRvZXNu
J3QgcHJvdmlkZSBzdGFibGUgY29va2llcywgYW5kCmtuZnNkIGRvZXNuJ3QgdXNlIHRoZSB2ZXJp
ZmllciB0byB0ZWxsIHlvdSB0aGF0IHRoZSBjb29raWUgYXNzaWdubWVudApoYXMgY2hhbmdlZC4K
CgpSZS1leHBvcnQgb2YgdG1wZnMgaGFzIG5ldmVyIHdvcmtlZCByZWxpYWJseS4KCi0tIApUcm9u
ZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
