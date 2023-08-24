Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9082787853
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbjHXTBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbjHXTBz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 15:01:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C091BCE
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 12:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahbDkzp5QJVcV9FEKnB5hW/LvTTwPmBshBqGtZbyoTdNWh66LEDvjb7GvYHjomu2n6PkbmNCKSNwkaM4QgfQMQYwvOQve5Kv1geNsMQYnzlnckWc7cbgxPQyiL1N+Q6eHjlAPd9WuGyqoXTc4+nx5CnA0QkZCNb8nru1vgnphd72TiYx587bwMdE7tjcMGeKSZKnKVu7/f3+FUVDaRrOppqj/c5hWTwS6W+WcvdYOQqf6nQKzLnX55jnQfNBiUr+3hBF7mJZC6zjX/ul3xTHG7mx2+EFaGPd8czsdK3g79X3CL9eOTSJCmyUvc5OUIOXd3M6R6G1uqASn8+i2EsZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6vueGnSpC9hhqLdlsBcWK4J6F01oJsIjJdjAM8cO/Y=;
 b=UqeqUsq5wFnbR79tyvvLJKLgZMVbqW1hEtyMkFFOGAKoEufs3SgpwU/dn4wGvC9rqy9GB2ezoifhR6RPbFdeFL0BtHvhq1KKpzHp6jfVerCgsRwzKtXv9dhlqotqA02Ohx/Pc0PYklohTelcU6iOz4GGRHtzFpjPbh22HRrGrdsjBE43ZAQ/qAUT2KkEqIYqDzJ49gK0yu701QyBXii2FMeppSvzk5aor0RsYwsG3uMplt+WDhneK93tM6NmN34k1uIJAlc9Ga8LJxdU085Rl9Egm6FfSlVIGb5UCGkSixYkjbjmPzJuMh0GQjvn/nqsPrjgeEsYswsyS1tY+g/I/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6vueGnSpC9hhqLdlsBcWK4J6F01oJsIjJdjAM8cO/Y=;
 b=aJjSpABu9pW9UzqQl+i7j9pRshleWhEgM5khOQsGTqJkIVnHrpOUxWY1EvjpkHln9bynV0eBaX5L2aHeZeOYOzPPlbhX8yfXXBFdWU6NoEuAJO5NfcNYLNkQROrgWkUCkG0v/hAws4FtDwfGgdri6RZ99rX5yGNUTAKM4nyJTDg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN4PR13MB5758.namprd13.prod.outlook.com (2603:10b6:806:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 19:01:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 19:01:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Topic: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Index: AQHZ1qM5a8kJqkV85kS+OyPQjyhCTK/5m0iAgAAC7gCAAAZYAIAAAPmAgAAitwCAAAVVgA==
Date:   Thu, 24 Aug 2023 19:01:46 +0000
Message-ID: <737abceb902411f583f731108fbc7eb235120eaf.camel@hammerspace.com>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
         <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
         <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
         <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
         <24ae5b14-0fe3-15e8-37e8-e8aed0cdefa9@oracle.com>
         <5b0bc635-40bb-2c3e-28dd-b9a71814a7bb@oracle.com>
In-Reply-To: <5b0bc635-40bb-2c3e-28dd-b9a71814a7bb@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN4PR13MB5758:EE_
x-ms-office365-filtering-correlation-id: 5885b020-7b34-4788-ec9a-08dba4d49090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DCKs+Ixttxx6JIvX0Qw4Liz1wOIGdCHPKVw/90nFmwG0IVkPAuf3qOanfCYOdF1QteLQ1yrdwgU4e/EfpxIqXAugqgoJZSYSNgTtMH5PIlRjrsD+Gp4sJA0o1HH9Wf71ZqzP0nAGzWi25bx/spNse9lyX4hUlSDybwB86iLh0GM7Ml7iS1DeocCQsU1vRkLRkMw2we84j0ks4cPys7mTtSvXIusxlYKG8uGHnnUkkk3/agDVrRLnTK9WK6D8PLoMWCv/zNlDtLfgCTvlYdMRt7Bx+QLQ1h0J2VilumFKQOXWmGweGwGN13/CqXNcyzb9vwhWnO6KoWuB355CiXnBfVr2aO9L90g345VvaQIq2rteOxfB9J6EWYsvxMPRu5g9g6nwIHdp2ZkKECVEHJE8JPxPxOZHEAHa4/ixdPlmUdQ/NMKwLpH4rj+04yirxJTYIP5AWy0gYt4OOMoFiwzcNM7huxFpOUdfLaKFArWwaqS+qbVG50ONG6PM5bjujUE3l/90MhwCY0/Zpmi7ySokt34xJuIN//NSSdlh/iRuLQo7/maJmbNclXoAXZJM8Uq+OizI2bdoyO5zNhwIpeWpV32O5oXcwEnZByB58fhNGm8U0VejEVmlBdGg6EuJWbMhG1MvTWe1HVCi3bzCqoO48Pi511HlQXs/OpNjBcEB2Fwt+oLMxjPcrTtuqNdTsYuX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(376002)(366004)(136003)(1800799009)(451199024)(186009)(12101799020)(8676002)(4326008)(8936002)(2906002)(316002)(41300700001)(15650500001)(64756008)(5660300002)(66556008)(76116006)(66946007)(66476007)(66446008)(83380400001)(38070700005)(38100700002)(122000001)(6512007)(2616005)(26005)(53546011)(86362001)(110136005)(478600001)(36756003)(71200400001)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alVqWlpNL0xMMnFibTd2S3JNRUl5QjdVYXUzd3dIWUh5RDZMQVp2MXRzb3Qw?=
 =?utf-8?B?WTJVSGRacHZqc3d2elhpTUx2dE4wamp4V3RDeE52T3gvRFExbnVVclVGWDlU?=
 =?utf-8?B?YWU2UTFldlZoMmU2LzU0YnAxK2taVnJIUmlRc0V4RzRRRFQrWTY5bjBSQ2ZK?=
 =?utf-8?B?YWl5d3ZSZmF0cWhCSGFVb1IxYU9SanZscmk5VmEvUmRuMEFzR0VXTm82Q0li?=
 =?utf-8?B?YURvcDNaTXVBVkZtRDdGRUFZU1E0djJ3WVVrYlZQR1Z0WUUzWi9ZNHFzcjdi?=
 =?utf-8?B?bnUwTnNxeWNVdXlZZCt5U1l1eHRtWlZFSDNNY29Wc1lvaVYxQW1UeHBlTXRs?=
 =?utf-8?B?SjJjdEl0dVV1SVRkNVo2RVVpWjMwUDhaeTVMbkt4TUpBeU5nQUVSQkF4aWh0?=
 =?utf-8?B?YStHd05GTnM5Nm5kcFZ5a3lsTGt2YVNJVHFCbUQwV21CeG9oaEpMcHJ2YkRW?=
 =?utf-8?B?TEdqSHlkZDY3Qko2Q1pFU2pJSHJScWNrTmtzUldBRGVYdHZSV1U3emU4STl3?=
 =?utf-8?B?RldZbENkWUU3c0ZOdk12RDkrZTlFdDlEVUdCMTdrVmVwZy9KN0E2NVc0OWJS?=
 =?utf-8?B?VFNONjUrUTlOTzVGTDFlYTc5RmIzMXRJSlg4TWNhcXdYb3NJd3ZuQzNKOFZr?=
 =?utf-8?B?TFJMc2JJbER4MXRiQ0lCTlh5V25hTzN6ZC85SVJNVnV4bUExVVduaFRkaXZW?=
 =?utf-8?B?R2Y2SEEzeGxDU2VVa2hnSzZyZzl0NUczd3pSNHl1Z0g5TExIdC9Gd1BxWjRB?=
 =?utf-8?B?dk4xR0Q3cklpVWl3ZGt2aEFqTjlacDVBUE51cVoyL29jVmd1UTByQ3JER1J1?=
 =?utf-8?B?clBUNzZDakFBaTgyVnRmcFpvRk5kak8vaCtHOG54a3dsRFAvdmFHcXdHWVVU?=
 =?utf-8?B?L1h2bEl3K0pzTUM3cFJ1QmJQRjN1clpxWHVEMEE3aDZzZ2ZBUDFjZEdzYmw3?=
 =?utf-8?B?V01nNmRLTzQ4SmNwS2FJbzYrUHc1NitPWGxybEN1QlRzZDUzamR2RTdkQTFS?=
 =?utf-8?B?OE9MVEJQa2s3VFk2WWVrVXpiY3BISjNWaC91NmIwZ0wrYXlKOUc0clhTMDVS?=
 =?utf-8?B?M0VlK2QyWE11Szl2YVduMVFPNGh0OGcvVngwdmZCL04yZGowVFFCQUpCZEZv?=
 =?utf-8?B?aWk1Sk95U0NDdmFjVVNtNGx6djUxeng5U0Z3ZTRvSkpVQnhNTWNRakh5clNx?=
 =?utf-8?B?UGhKQ1dxZmt3Nm1jbUZJZVRRUXN6bFVYS1pmemMrNm1WN3dQbzBlVFFjemJH?=
 =?utf-8?B?dzEwRUNNdzFEUHZHUHJMZ2ZOVDI0YTF2b0JzbXdQN2hmUnBPejJOaHc1Qysy?=
 =?utf-8?B?UUJlQTRwTXViYXp4RDlkTlYweXR1dWhoRk5pL1hpZDA0RTI3ZEw1eW0relVV?=
 =?utf-8?B?ZDhicGNSSE9zZ2JqZ1BJUk8ySUYyK2F0UUtkeklVNmhPdDVrTC9RZmRzU2Fu?=
 =?utf-8?B?MEIyR0pwSU03aXJuT2ZodDBjMVpnZnMyOWt5d3pPdFRJQ3hYSHVJQVUyak5a?=
 =?utf-8?B?UVVsNldZd1J5MFEydXhSOFRyU0x5V29oMG5jWUJXYTUvOE9WRStoZlpaUUhm?=
 =?utf-8?B?eFExaDB5dzZWQXJjQ1VmUzBDWnR4b3ZVQ3RzcG9oNTFhVlN1d2REZExyOEdO?=
 =?utf-8?B?RXhFWEUxc1MySjVEUHgweGlpZXdCc1dTSk9lVW1WYkROQnFuUlc1ekY5ejJF?=
 =?utf-8?B?Kzk5bXJSdlpRU2lHVlQvZ21EOGlOVDZhejR1T3BES0NqbjNNb3dJdUprQU84?=
 =?utf-8?B?ZldwbjNsZHBKMHEzOFBqT3FvaFp1dDlpaW0zRFY5ZlJwaHJiZW95dWFXUFFW?=
 =?utf-8?B?WEwra1hCcUN4TVZmeUJxV3d0UkcwaVR0QmszcU02bHNOSTJvM1Bzc0NaTU8y?=
 =?utf-8?B?cnYvMFpQS21IOE8vUEo5aVg4MG53SXBadlJlUlQxNHd5REJUeGxLYWxCZWF1?=
 =?utf-8?B?WDdvelRGeElQVmgvczFQNElUcFRJN0tya2U0ZkRkUktORU95ZmtUWW92bWRv?=
 =?utf-8?B?WWVFRjA3eS9wNEthRTFTY1ZYRzRyRGplWmhTTVJSVEN5aG4xQW9xeHFUYzJx?=
 =?utf-8?B?bEl4SXAyam9ZTlRKSVBrTVV0Tkp0aEw5NzZwT3I1MmF1Nk9mRVlDbWl2anlk?=
 =?utf-8?B?Y1FWUWhyRkoyemdMMFpZQlhPUXZkSk8rZE5SbjUwMmNyZGRQeitFaklYb2JB?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F72B66D137C6846B7791D92E2383D51@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5885b020-7b34-4788-ec9a-08dba4d49090
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 19:01:46.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42JiGavcl+lm5aJz2or3FixzbgaE5sc91MK0t7HVTIsG2GL6zzCke0ZdCmhvCkAXfYu9vS8HgmH8fPS3ctldLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDExOjQyIC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6Cj4gCj4gT24gOC8yNC8yMyA5OjM4IEFNLCBkYWkubmdvQG9yYWNsZS5jb23CoHdyb3RlOgo+
ID4gCj4gPiBPbiA4LzI0LzIzIDk6MzQgQU0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToKPiA+ID4g
T24gVGh1LCAyMDIzLTA4LTI0IGF0IDA5OjEyIC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb23CoHdy
b3RlOgo+ID4gPiA+IE9uIDgvMjQvMjMgOTowMSBBTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+
ID4gPiA+ID4gT24gVGh1LCAyMDIzLTA4LTI0IGF0IDA4OjUzIC0wNzAwLCBEYWkgTmdvIHdyb3Rl
Ogo+ID4gPiA+ID4gPiBUaGUgTGludXggTkZTIHNlcnZlciBzdHJpcHMgdGhlIFNVSUQgYW5kIFNH
SUQgZnJvbSB0aGUgZmlsZQo+ID4gPiA+ID4gPiBtb2RlCj4gPiA+ID4gPiA+IG9uIEFMTE9DQVRF
IG9wLiBUaGUgR0VUQVRUUiBvcCBpbiB0aGUgQUxMT0NBVEUgY29tcG91bmQKPiA+ID4gPiA+ID4g
bmVlZHMgdG8KPiA+ID4gPiA+ID4gcmVxdWVzdCB0aGUgZmlsZSBtb2RlIGZyb20gdGhlIHNlcnZl
ciB0byB1cGRhdGUgaXRzIGZpbGUKPiA+ID4gPiA+ID4gbW9kZSBpbgo+ID4gPiA+ID4gPiBjYXNl
IHRoZSBTVUlEL1NHVUkgYml0IHdlcmUgc3RyaXBwZWQuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+Cj4gPiA+ID4gPiA+
IC0tLQo+ID4gPiA+ID4gPiDCoMKgwqBmcy9uZnMvbmZzNDJwcm9jLmMgfCAyICstCj4gPiA+ID4g
PiA+IMKgwqDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0MnByb2MuYyBi
L2ZzL25mcy9uZnM0MnByb2MuYwo+ID4gPiA+ID4gPiBpbmRleCA2MzgwMmQxOTU1NTYuLmQzZDA1
MDE3MTgyMiAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL25mczQycHJvYy5jCj4gPiA+
ID4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0MnByb2MuYwo+ID4gPiA+ID4gPiBAQCAtNzAsNyArNzAs
NyBAQCBzdGF0aWMgaW50IF9uZnM0Ml9wcm9jX2ZhbGxvY2F0ZShzdHJ1Y3QKPiA+ID4gPiA+ID4g
cnBjX21lc3NhZ2UKPiA+ID4gPiA+ID4gKm1zZywgc3RydWN0IGZpbGUgKmZpbGVwLAo+ID4gPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gPiA+ID4gwqDCoCDCoMKgwqDCoMKgwqDC
oMKgwqDCoG5mczRfYml0bWFza19zZXQoYml0bWFzaywgc2VydmVyLQo+ID4gPiA+ID4gPiA+IGNh
Y2hlX2NvbnNpc3RlbmN5X2JpdG1hc2ssCj4gPiA+ID4gPiA+IGlub2RlLAo+ID4gPiA+ID4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBORlNfSU5PX0lO
VkFMSURfQkxPQ0tTKTsKPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBORlNfSU5PX0lOVkFMSURfQkxPQ0tTIHwKPiA+ID4gPiA+ID4gTkZT
X0lOT19JTlZBTElEX01PREUpOwo+ID4gPiA+ID4gPiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmVzLmZhbGxvY19mYXR0ciA9IG5mc19hbGxvY19mYXR0cigpOwo+ID4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmICghcmVzLmZhbGxvY19mYXR0cikKPiA+ID4gPiA+IEFjdHVhbGx5Li4u
IFdhaXQuLi4gV2h5IGlzbid0IHRoZSBleGlzdGluZyBjb2RlIHN1ZmZpY2llbnQ/Cj4gPiA+ID4g
PiAKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBuZnM0X2NhbGxfc3luYyhz
ZXJ2ZXItPmNsaWVudCwgc2VydmVyLAo+ID4gPiA+ID4gbXNnLAo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICZhcmdzLnNlcV9hcmdzLAo+ID4gPiA+ID4gJnJlcy5zZXFfcmVzLCAwKTsKPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RhdHVzID09IDApIHsKPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5mc19zaG91bGRfcmVtb3ZlX3N1aWQoaW5vZGUp
KSB7Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzcGluX2xvY2soJmlub2RlLT5pX2xvY2spOwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3NldF9jYWNoZV9pbnZh
bGlkKGlub2RlLAo+ID4gPiA+ID4gTkZTX0lOT19JTlZBTElEX01PREUpOwo+ID4gPiA+ID4gc3Bp
bl91bmxvY2soJmlub2RlLT5pX2xvY2spOwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0YXR1cyA9Cj4gPiA+ID4gPiBuZnNfcG9zdF9vcF91cGRhdGVfaW5vZGVfZm9yY2Vfd2Nj
KGlub2RlLAo+ID4gPiA+ID4gcmVzLmZhbGxvY19mYXR0cik7Cj4gPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqAgfQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBXZSBleHBsaWNpdGx5IGNoZWNrIGZvciBT
VUlEIGJpdHMsIGFuZCBpbnZhbGlkYXRlIHRoZSBtb2RlIGlmCj4gPiA+ID4gPiB0aGV5Cj4gPiA+
ID4gPiBhcmUKPiA+ID4gPiA+IHNldC4KPiA+ID4gPiBuZnNfc2V0X2NhY2hlX2ludmFsaWQgY2hl
Y2tzIGZvciBkZWxlZ2F0aW9uIGFuZCBjbGVhcnMgdGhlCj4gPiA+ID4gTkZTX0lOT19JTlZBTElE
X01PREUuCj4gPiA+ID4gCj4gPiA+IE9oLiBUaGF0IGp1c3QgbWVhbnMgd2UgbmVlZCB0byBhZGQg
TkZTX0lOT19SRVZBTF9GT1JDRUQsIHNvIGxldCdzCj4gPiA+IHJhdGhlciBkbyB0aGF0Lgo+ID4g
Cj4gPiBvaywgSSdsbCBjcmVhdGUgYSBuZXcgcGF0Y2ggYW5kIHRlc3QgaXQuCj4gCj4gVGhpcyBp
cyB0aGUgbmV3IHBhdGNoOgo+IAo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNDJwcm9jLmMgYi9m
cy9uZnMvbmZzNDJwcm9jLmMKPiBpbmRleCA2MzgwMmQxOTU1NTYuLmVhMTk5MWUzOTNlMiAxMDA2
NDQKPiAtLS0gYS9mcy9uZnMvbmZzNDJwcm9jLmMKPiArKysgYi9mcy9uZnMvbmZzNDJwcm9jLmMK
PiBAQCAtODEsNyArODEsNyBAQCBzdGF0aWMgaW50IF9uZnM0Ml9wcm9jX2ZhbGxvY2F0ZShzdHJ1
Y3QgcnBjX21lc3NhZ2UKPiAqbXNnLCBzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gwqDCoMKgwqDCoMKg
wqDCoGlmIChzdGF0dXMgPT0gMCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKG5mc19zaG91bGRfcmVtb3ZlX3N1aWQoaW5vZGUpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZpbm9kZS0+aV9sb2NrKTsK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19zZXRf
Y2FjaGVfaW52YWxpZChpbm9kZSwKPiBORlNfSU5PX0lOVkFMSURfTU9ERSk7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfc2V0X2NhY2hlX2ludmFs
aWQoaW5vZGUsCj4gTkZTX0lOT19SRVZBTF9GT1JDRUQpOwoKTm8uIFRoZSBhYm92ZSBuZWVkcyB0
byBhZGQgTkZTX0lOT19SRVZBTF9GT1JDRUQuCgpJT1c6IAoJbmZzX3NldF9jYWNoZV9pbnZhbGlk
KGlub2RlLCBORlNfSU5PX0lOVkFMSURfTU9ERSB8IE5GU19JTk9fUkVWQUxfRk9SQ0VEKTsKCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxv
Y2soJmlub2RlLT5pX2xvY2spOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gbmZzX3Bvc3Rfb3BfdXBk
YXRlX2lub2RlX2ZvcmNlX3djYyhpbm9kZSwKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tCgoK
