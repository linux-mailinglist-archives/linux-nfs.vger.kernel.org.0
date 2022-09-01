Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB75A9EDE
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIASW1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 14:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiIASW0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 14:22:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226A47C1F6
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 11:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/tgh1HW2nKWV0oezz4K1rca+kOdOip63Ji5aDHtn+23XIMViRrj1RsiG+wTgrPfkqSlFB3iSc/y6A5SrwblfBrYpq3P/0Dt1CmtjfKAcCurHMQ+hLmwNNrMgfhycsj0cIPlnaekpHUNkxS21wBjBgVMHiXcKR5uFR45vzeB4tixvilr8WpP4UDe6d2lKHYAItXZ5pRiUh9UPzTujASBuh8R4rnz/gaEzuqoSNFLLfpxYqf+dGjExLnGr7+1J20daK+KU2yH7NOg96P/xCCy2pOBb9KG/aipR3sRcyS0MW3HfQMOxZrEHQ7/eMhgz049ajMaxbNimWzz/Qlqg3U2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OM3W/f1FwRx7B7QuwNBuSxw2ORnqeF8pHEMUZYTFqI=;
 b=EOaNTbVAvuaJ7m/ql6pGyFlL5l/3usb+Pnp0nVWJV7zuNb6wFipemWqk1LPNkUuZzNmO1nZ9C5pocDJGHLqff01Lxru1pep6SdHn0TCMG2610vpwuAaMRYEVzVFTP+04tJwfQj48V06oR8LTnHLJ4UcEBJewwHRsZ9lZJ//mkxqTAAxDpI4xijhrUkXVeSZj8uuxkBYk8ns71Y/dp8CKkKrAg+JcGiwFFvqsy14l61YFK1FZjEYLLHQyK13gkEulSpIxgfGY1d0mEPItMRDAMnoEcYSSO/+f4vKtM73sfr7A2qnpp5ck0AWn4ecQBnYJtTo1gbBOrjXBJs6QDio/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OM3W/f1FwRx7B7QuwNBuSxw2ORnqeF8pHEMUZYTFqI=;
 b=BRhIVndG09ThEs5LBl3GaXRITMx6aXlo+ri1d2W9D14AIEMueGQruoYExrKq6QViJR4Xux9xAtpYJi/P0R4eGZeu4gmWR9kdsAxUnxdE1FWDU+EdtCuEUOS1RphB4jEvfOqfhRobH8Cp2y1dpicNdvtAoQIFdcJXXEXVkqnCGLQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1525.namprd13.prod.outlook.com (2603:10b6:903:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Thu, 1 Sep
 2022 18:22:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.005; Thu, 1 Sep 2022
 18:22:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
Subject: Re: [PATCH v2] NFSv4.2: Update mode bits after ALLOCATE and
 DEALLOCATE
Thread-Topic: [PATCH v2] NFSv4.2: Update mode bits after ALLOCATE and
 DEALLOCATE
Thread-Index: AQHYvi1gGF86nZmxlkGuRMvCBNP1Lq3K4y4A
Date:   Thu, 1 Sep 2022 18:22:22 +0000
Message-ID: <c38f77a54257fcf8c59b6e628cc13679fb3fb48d.camel@hammerspace.com>
References: <20220901180503.1347290-1-anna@kernel.org>
In-Reply-To: <20220901180503.1347290-1-anna@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CY4PR13MB1525:EE_
x-ms-office365-filtering-correlation-id: 053fa988-50ca-4e5c-a4a6-08da8c46ea1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9B07kCkgWoeX5Q9Pq2FDYo/giin6p9wT+QB6N519JMRZjdUxK4nisbGZX8Z+1VbIivn9Pw+8F2ZISi8sc9j8w43cfq/9LZiBcZMcMsAtDS0YPj7wDjb198rM72RX/ol5eJNpQfZvlWTb+ail+spl44BoU1BmWSl5ywpULW6ooWyG7Y7shTr4fEf4x4NBhprSDf5xJAq2M+MYehaAjNy9U6jlcjeZ+O0BTeFSrCXsjIJC6wg9tbeqdQjNvuPeiVB+e0NDmArnsMc4FmLontjwQrjN4eHbUBBwD/IKf9/HQB2jdT5T8qU6Seb5RSIvFoRYzr/0P2lJYoVoZKb75NGUi49EUcZQq14rOE9WV7RCzY9E1/hqltegjedF+9aPJ0yjRP1fN7PDxViY671k0a9BEkTzebJ8XyDsksi+/im8EeYrh83D9/IukarKv28iN/fjU9khNHoqNXQeSpXDyKI/E/CsjWIFhjrCJkN12Oc3frjS7IyTDqRVKJxuFLEgBMaHMGVmd4DYHy6zbH8Um+x2NJk2RZamtO3HcWTJR/DNt8JNkUevXW73FHg2K9bnEVexKSC68j5ra3JgTqFBSIQQZyxxDkDRcQktNf2QTcmatdy/uMw+IMuyu7lME6Q53nCG7+41rMAbHU6wmnMHFpS2LwSTo1HHdqOCBXcSdA5Tq6huRcjjvwvFbf0POTiaHPz5VdE/E+URDU+bbCq3vHe03hfG6+MVyxmT0mpnJVuKHj1LUQ1et1omimL/bNnAmIdzFQS+AX0iRCYAMxxGE09Sjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(39840400004)(136003)(83380400001)(122000001)(4326008)(8676002)(66446008)(64756008)(76116006)(66946007)(66556008)(66476007)(110136005)(316002)(15650500001)(38100700002)(2906002)(8936002)(5660300002)(6506007)(6512007)(186003)(2616005)(71200400001)(26005)(6486002)(86362001)(478600001)(38070700005)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJ6ZnFVajJzWDQ3S010NzdDOTBrZ3BoT2g4blIvN1FWZlRMZU5EZVB3TTlu?=
 =?utf-8?B?dXhOcXYzSGFOUmNTWUFRQ1JTUEg0ckI5RDJJZFY0RkNWb3dNUjFvamI0bmo0?=
 =?utf-8?B?dlJuZDNVWW9MSCs1bWxCOFRXc0JLTVpnVmRoWForY0xsZmZvV3hBalB4OHRs?=
 =?utf-8?B?bnlJRjJuOEVwdFVZUEJTbFhJN214ekZkWFFDdEhkdWxOK1JqN2hXUWdtSHdT?=
 =?utf-8?B?ZmtSYmtHSTlqOXMrLzRxUks0SDNNeWE0UzdJZE10QURoR3VBSlk5UkhoSFV6?=
 =?utf-8?B?cUkzYUNlTjF2Qi8ycGFIcGQwR2EwRytwWlNGY0o2QW5hOEFXSXRhNGxlaStP?=
 =?utf-8?B?NW9kYU1pSzRXT0t2aUg3cEdQSUNGbzUwdm1lTnhPNjdkTGt4Vm1tQThUL2Ni?=
 =?utf-8?B?Q2lLNS8wTnZJaHpoeENtdlk4VnpiaVVEdHh6OEhwWGZDbWZ2YXB6d0t1TDVV?=
 =?utf-8?B?bXd4K1BqS3c5VkJwaVZNQ0g0cGttWVgrYklnbmorWktFVzA1UWVGaVkyRUFL?=
 =?utf-8?B?KzNVOUZGUlM1QVA1MHAyT3BnSVZrbzFsc0ViUUhBODcrUDBkRUhTbHdPM2kx?=
 =?utf-8?B?WVV3VnhTYWZKMGVUMHg3N0lqakpvUWtxcm4vMU5PTFYzU3orc3RLVkg5ZG5z?=
 =?utf-8?B?QnZaYnVMSkp6SkNDdG5HZFduM1NSdXJnbS9Pa1Y5dVNXWnlsQ1VUTHJpcTlG?=
 =?utf-8?B?dGR3UStiVFRROWt5clJRUVFDYXVlVWo1SVNoRGcwWHNNQkh0bmJ0NFI5QVdM?=
 =?utf-8?B?U2FhNkIxdlM0QnJueTFHZVdqbkRTMUF1d0xyZ2pPcUw4TEFnOHFPT3IweVdP?=
 =?utf-8?B?N3NYQllTcmtPaTJQNzY0L1A3K09hcE5FSVpiM3ZZUmd1akNwb0dBRFBPV2lZ?=
 =?utf-8?B?UXBCOGNwNnMvY2ovSWtUNlNFRkFvQStXTC9vNEpkazlvbk8yMTNCTGl4YTd5?=
 =?utf-8?B?NGs1ZmlHMzFHd3ArbGlnd25EZU1ETnlzVHdjRnVZVTZJb1A1L1lhN0daZ1dX?=
 =?utf-8?B?TkVKNFc4S1VoQWRTTWVHS0dBNXowakwzZXNaK256V3VqMGFWakNBSzVZWjBT?=
 =?utf-8?B?QUpwcXp0emZsdTJpT0NiRjloRk5UTFRneDVJMDNrWlpNY1NsRkJuQmRHNmVt?=
 =?utf-8?B?NWdJaGpUQUFtT1ZpVDdxZUVvUmt1V3BWRDZVSTVpWDFNbWM3MmF1SmFaUGd0?=
 =?utf-8?B?ZGdhdkc5Tk0weEtWRmVvV09EUkxwQjNOOUhxL1c1R05ObkdnT0FZZ2lxZjFp?=
 =?utf-8?B?UWlOY2M1Vm5JeFg3cXBJWU94cEFBMnpwTzZhMmNBRTNDdGtzcncrZDUySXo3?=
 =?utf-8?B?cEl2NURVbTBXdStrNExHTEc2MWw5K2ZGVTV4NWR2K3Y4VUp3NkZFWnFUSnNt?=
 =?utf-8?B?bW5sSWZURXRjbC9IS0ZXZ0dsRlJIRVlsd1JmbzJIRy9MZ1lFL05mQjd4K2to?=
 =?utf-8?B?K00xeHNVMWdCNEtxTnM2MUtrZjVpZGUxRVVRNGtwU2hlSnZkMERwTDBxREpy?=
 =?utf-8?B?RTRIZ1JEeGNnRks4bzJuMjMyc2s5a2RLcjFGS1VjRklIMU51NWZDbnJDVFpn?=
 =?utf-8?B?dzhXdGxzOUhOcWZzSlNYbk9obnFCd09Hei9YNi8yNnljbU93eWdWWmptYlE1?=
 =?utf-8?B?UjBNa2Z6REhibTNXMjJHUmgwNFZwZ2dVUFZEMVJUczRYQTNuZUQ4dDJ5ck12?=
 =?utf-8?B?cUdkQXVLUVgwcVl0OEJXcXlRaEd0UWZKTlVmc3dEWlhHOHZUMDVkYkRPajdQ?=
 =?utf-8?B?UnhhQ3FNN01NczVsWGlqbGNhRFlOZTVhTm1ZNkZtTkZWTXdwMU80VWorRFAr?=
 =?utf-8?B?b2p1T3BBK3pVcldKRFk4VXRRSjQ0TVRjVHJrNm9lckpvV24rNWlCL2t0YW9a?=
 =?utf-8?B?RkFPV0paalZSVXZoQUdJT3FkY0xhMllDTm9SY210bi82cDJEQVpXaXViWUF3?=
 =?utf-8?B?Qk82aXBCdVFBY2ZqNU9SR2V3Tlhta3IvWFZOeTE0UWNSdFZhRFEzQ1o0dlBu?=
 =?utf-8?B?eTR1d2pRbUM5RThuVkFzS3M5Z2NiZDBBU2ZFYW1qZjJoRmpXWWtoZUt2bkhH?=
 =?utf-8?B?dEJiWVlrbTNXbFhjbnVzd1FFNGtSc2hUMTU5VTExNlpML1N0ZDhsWVVPY3FQ?=
 =?utf-8?B?elRHZUJQZThCMk5hZWxOZ2E1MksvN1RUd1MzdDB6MGNYUHExc0VsTGgyaXFV?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC931685750B543B6DCDD8FE0425F85@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1525
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTAxIGF0IDE0OjA1IC0wNDAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToK
PiBGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBwLmNvbT4KPiAKPiBU
aGUgZmFsbG9jYXRlIGNhbGwgaW52YWxpZGF0ZXMgc3VpZCBhbmQgc2dpZCBiaXRzIGFzIHBhcnQg
b2Ygbm9ybWFsCj4gb3BlcmF0aW9uLiBXZSBuZWVkIHRvIG1hcmsgdGhlIG1vZGUgYml0cyBhcyBp
bnZhbGlkIHdoZW4gdXNpbmcKPiBmYWxsb2NhdGUKPiB3aXRoIGFuIHN1aWQgc28gdGhlc2Ugd2ls
bCBiZSB1cGRhdGVkIHRoZSBuZXh0IHRpbWUgdGhlIHVzZXIgbG9va3MgYXQKPiB0aGVtLgo+IAo+
IFRoaXMgZml4ZXMgeGZzdGVzdHMgZ2VuZXJpYy82ODMgYW5kIGdlbmVyaWMvNjg0Lgo+IAo+IFJl
cG9ydGVkLWJ5OiBZdWUgQ3VpIDxjdWl5dWUtZm5zdEBmdWppdHN1LmNvbT4KPiBGaXhlczogOTEz
ZWNhMWFlYTg3ICgiTkZTOiBGYWxsb2NhdGUgc2hvdWxkIHVzZSB0aGUKPiBuZnM0X2ZhdHRyX2Jp
dG1hcCIpCj4gU2lnbmVkLW9mZi1ieTogQW5uYSBTY2h1bWFrZXIgPEFubmEuU2NodW1ha2VyQE5l
dGFwcC5jb20+Cj4gLS0tCj4gwqBmcy9uZnMvaW50ZXJuYWwuaMKgIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrKysrKwo+IMKgZnMvbmZzL25mczQycHJvYy5jIHwgMTMgKysrKysrKysrKysrLQo+
IMKgZnMvbmZzL3dyaXRlLmPCoMKgwqDCoCB8IDI1IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
PiDCoDMgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9pbnRlcm5hbC5oIGIvZnMvbmZzL2ludGVybmFsLmgKPiBp
bmRleCAyN2M3MjBkNzFiNGUuLjg5OGRkOTViYzdhNyAxMDA2NDQKPiAtLS0gYS9mcy9uZnMvaW50
ZXJuYWwuaAo+ICsrKyBiL2ZzL25mcy9pbnRlcm5hbC5oCj4gQEAgLTYwNiw2ICs2MDYsMzEgQEAg
c3RhdGljIGlubGluZSBnZnBfdCBuZnNfaW9fZ2ZwX21hc2sodm9pZCkKPiDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIEdGUF9LRVJORUw7Cj4gwqB9Cj4gwqAKPiArLyoKPiArICogU3BlY2lhbCB2ZXJz
aW9uIG9mIHNob3VsZF9yZW1vdmVfc3VpZCgpIHRoYXQgaWdub3Jlcwo+IGNhcGFiaWxpdGllcy4K
PiArICovCj4gK3N0YXRpYyBpbmxpbmUgaW50IG5mc19zaG91bGRfcmVtb3ZlX3N1aWQoY29uc3Qg
c3RydWN0IGlub2RlICppbm9kZSkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHVtb2RlX3QgbW9kZSA9
IGlub2RlLT5pX21vZGU7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGtpbGwgPSAwOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqAvKiBzdWlkIGFsd2F5cyBtdXN0IGJlIGtpbGxlZCAqLwo+ICvCoMKgwqDCoMKg
wqDCoGlmICh1bmxpa2VseShtb2RlICYgU19JU1VJRCkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGtpbGwgPSBBVFRSX0tJTExfU1VJRDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgLyoK
PiArwqDCoMKgwqDCoMKgwqAgKiBzZ2lkIHdpdGhvdXQgYW55IGV4ZWMgYml0cyBpcyBqdXN0IGEg
bWFuZGF0b3J5IGxvY2tpbmcKPiBtYXJrOyBsZWF2ZQo+ICvCoMKgwqDCoMKgwqDCoCAqIGl0IGFs
b25lLsKgIElmIHNvbWUgZXhlYyBiaXRzIGFyZSBzZXQsIGl0J3MgYSByZWFsIHNnaWQ7Cj4ga2ls
bCBpdC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqBpZiAodW5saWtlbHko
KG1vZGUgJiBTX0lTR0lEKSAmJiAobW9kZSAmIFNfSVhHUlApKSkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKga2lsbCB8PSBBVFRSX0tJTExfU0dJRDsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgaWYgKHVubGlrZWx5KGtpbGwgJiYgU19JU1JFRyhtb2RlKSkpCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBraWxsOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4g
MDsKPiArfQo+ICsKPiDCoC8qIHVubGluay5jICovCj4gwqBleHRlcm4gc3RydWN0IHJwY190YXNr
ICoKPiDCoG5mc19hc3luY19yZW5hbWUoc3RydWN0IGlub2RlICpvbGRfZGlyLCBzdHJ1Y3QgaW5v
ZGUgKm5ld19kaXIsCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0MnByb2MuYyBiL2ZzL25mcy9u
ZnM0MnByb2MuYwo+IGluZGV4IDA2OGM0NWIzYmMxYS4uMjMwMjNkZGY3NWQxIDEwMDY0NAo+IC0t
LSBhL2ZzL25mcy9uZnM0MnByb2MuYwo+ICsrKyBiL2ZzL25mcy9uZnM0MnByb2MuYwo+IEBAIC01
Niw2ICs1Niw3IEBAIHN0YXRpYyBpbnQgX25mczQyX3Byb2NfZmFsbG9jYXRlKHN0cnVjdCBycGNf
bWVzc2FnZQo+ICptc2csIHN0cnVjdCBmaWxlICpmaWxlcCwKPiDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IG5mczQyX2ZhbGxvY19yZXMgcmVzID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLmZhbGxvY19zZXJ2ZXLCoMKgPSBzZXJ2ZXIsCj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4g
K8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGludmFsaWQgPSAwOwo+IMKgwqDCoMKgwqDCoMKg
wqBpbnQgc3RhdHVzOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG1zZy0+cnBjX2FyZ3AgPSAmYXJn
czsKPiBAQCAtNzgsMTAgKzc5LDIwIEBAIHN0YXRpYyBpbnQgX25mczQyX3Byb2NfZmFsbG9jYXRl
KHN0cnVjdAo+IHJwY19tZXNzYWdlICptc2csIHN0cnVjdCBmaWxlICpmaWxlcCwKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBuZnM0X2NhbGxfc3luYyhzZXJ2ZXItPmNsaWVudCwgc2Vy
dmVyLCBtc2csCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCZhcmdzLnNlcV9hcmdzLCAmcmVzLnNlcV9yZXMsIDApOwo+ICsK
PiArwqDCoMKgwqDCoMKgwqBpZiAoIXJlcy5mYWxsb2NfZmF0dHItPnZhbGlkKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnZhbGlkIHw9IE5GU19JTk9fSU5WQUxJRF9BVFRSOwo+
ICvCoMKgwqDCoMKgwqDCoGlmIChuZnNfc2hvdWxkX3JlbW92ZV9zdWlkKGlub2RlKSkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW52YWxpZCB8PSBORlNfSU5PX0lOVkFMSURfTU9E
RTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoaW52YWxpZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBzcGluX2xvY2soJmlub2RlLT5pX2xvY2spOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBuZnNfc2V0X2NhY2hlX2ludmFsaWQoaW5vZGUsIE5GU19JTk9fSU5WQUxJ
RF9NT0RFKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2soJmlu
b2RlLT5pX2xvY2spOwo+ICvCoMKgwqDCoMKgwqDCoH0KClRoaXMgYWxsIHJlYWxseSB3YW50cyB0
byBnbyBpbnRvIHRoZSAnaWYgKHN0YXR1cyA9PSAwKScgYmVsb3cuCj4gKwo+IMKgwqDCoMKgwqDC
oMKgwqBpZiAoc3RhdHVzID09IDApCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
dGF0dXMgPSBuZnNfcG9zdF9vcF91cGRhdGVfaW5vZGVfZm9yY2Vfd2NjKGlub2RlLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAK
PiByZXMuZmFsbG9jX2ZhdHRyKTsKPiAtCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChtc2ctPnJwY19w
cm9jID09Cj4gJm5mczRfcHJvY2VkdXJlc1tORlNQUk9DNF9DTE5UX0FMTE9DQVRFXSkKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRyYWNlX25mczRfZmFsbG9jYXRlKGlub2RlLCAm
YXJncywgc3RhdHVzKTsKPiDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+IGRpZmYgLS1naXQgYS9mcy9u
ZnMvd3JpdGUuYyBiL2ZzL25mcy93cml0ZS5jCj4gaW5kZXggMTg0M2ZhMjM1ZDliLi5mNDFkMjRi
NTRmZDEgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL3dyaXRlLmMKPiArKysgYi9mcy9uZnMvd3JpdGUu
Ywo+IEBAIC0xNDk2LDMxICsxNDk2LDYgQEAgdm9pZCBuZnNfY29tbWl0X3ByZXBhcmUoc3RydWN0
IHJwY190YXNrICp0YXNrLAo+IHZvaWQgKmNhbGxkYXRhKQo+IMKgwqDCoMKgwqDCoMKgwqBORlNf
UFJPVE8oZGF0YS0+aW5vZGUpLT5jb21taXRfcnBjX3ByZXBhcmUodGFzaywgZGF0YSk7Cj4gwqB9
Cj4gwqAKPiAtLyoKPiAtICogU3BlY2lhbCB2ZXJzaW9uIG9mIHNob3VsZF9yZW1vdmVfc3VpZCgp
IHRoYXQgaWdub3Jlcwo+IGNhcGFiaWxpdGllcy4KPiAtICovCj4gLXN0YXRpYyBpbnQgbmZzX3No
b3VsZF9yZW1vdmVfc3VpZChjb25zdCBzdHJ1Y3QgaW5vZGUgKmlub2RlKQo+IC17Cj4gLcKgwqDC
oMKgwqDCoMKgdW1vZGVfdCBtb2RlID0gaW5vZGUtPmlfbW9kZTsKPiAtwqDCoMKgwqDCoMKgwqBp
bnQga2lsbCA9IDA7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoC8qIHN1aWQgYWx3YXlzIG11c3QgYmUg
a2lsbGVkICovCj4gLcKgwqDCoMKgwqDCoMKgaWYgKHVubGlrZWx5KG1vZGUgJiBTX0lTVUlEKSkK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga2lsbCA9IEFUVFJfS0lMTF9TVUlEOwo+
IC0KPiAtwqDCoMKgwqDCoMKgwqAvKgo+IC3CoMKgwqDCoMKgwqDCoCAqIHNnaWQgd2l0aG91dCBh
bnkgZXhlYyBiaXRzIGlzIGp1c3QgYSBtYW5kYXRvcnkgbG9ja2luZwo+IG1hcms7IGxlYXZlCj4g
LcKgwqDCoMKgwqDCoMKgICogaXQgYWxvbmUuwqAgSWYgc29tZSBleGVjIGJpdHMgYXJlIHNldCwg
aXQncyBhIHJlYWwgc2dpZDsKPiBraWxsIGl0Lgo+IC3CoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKg
wqDCoMKgwqDCoGlmICh1bmxpa2VseSgobW9kZSAmIFNfSVNHSUQpICYmIChtb2RlICYgU19JWEdS
UCkpKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBraWxsIHw9IEFUVFJfS0lMTF9T
R0lEOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBpZiAodW5saWtlbHkoa2lsbCAmJiBTX0lTUkVHKG1v
ZGUpKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGtpbGw7Cj4gLQo+
IC3CoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IC19Cj4gLQo+IMKgc3RhdGljIHZvaWQgbmZzX3dy
aXRlYmFja19jaGVja19leHRlbmQoc3RydWN0IG5mc19wZ2lvX2hlYWRlciAqaGRyLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG5mc19mYXR0ciAqZmF0dHIpCj4gwqB7
CgpPdGhlcndpc2UsIGxvb2tzIE9LLgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20KCgo=
