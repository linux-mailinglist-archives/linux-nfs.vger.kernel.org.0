Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2194A6ADE
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 05:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiBBEZh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 23:25:37 -0500
Received: from mail-bn8nam08on2121.outbound.protection.outlook.com ([40.107.100.121]:51393
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232908AbiBBEZg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Feb 2022 23:25:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux4UXFOVPZzvVto3DzYoeKcjZVeRlo4mHFHCIptjribOU7jd5xaPvlytZ1uXvhNnq3bSlC90OO/EanftZBBGkmXsie92GxSH8enMSANcBgk7IZ1Cs63KcwAIg9d+yCvBoiu53SJKkAhtBK9LwUCaeC3caVWTGkeVkSAu2WFaChGpuLi5mJvhf1ggF9kZkvr6oC4neHNudLdUs9YhAmqchae1IWFXoBD/qtEUIzGF+UvddmfuvD7Mxe8a1gFymzGvtwEvmRvoXGwVbqXxozIq6/sjQaPeZWkZfOIfaEwjd/sqoYZir0TJ1gPvZjG30RaNh8iD3OQdCo1eK+412qm30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tASSfEc50uAI1bvIs4udssML22F6jzsazq5H1Nmd9M=;
 b=oE+vZI4oDhQ5CChc8Igk6W2lVM7+sITD4YDlfQrkeLXe49jZFT8EZz/SwVN23w0VWgXGQFJdCpmoA4twpEkJDcd9X8+t/mA29fD1ltrnTLJ1nndsx/KszyE3c5Mx8IQX3eYCXi7YAZ4PA870jWjzLHGT801+uynTU+2ZHMl0P38WniTD23OaNiqArvziHLjNFQS1jdycX1c84jFmGvB7oRR1V+S0sGWX9+r75pYWoLP7fjQQ6jWsXzd1IS3Fb46FmUPP4XGSHbttks11gdBKJkClphH+YlZBhyIHwj2IIOXbX4e2zXTE0pTTLqpWunHglt0gT0Yszg8CbECupn7BZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tASSfEc50uAI1bvIs4udssML22F6jzsazq5H1Nmd9M=;
 b=S99/OTQySBNNYH/M8tkyffFEZvVIri1pQe2aT86aQ96YItoVYDtUwlW/1KXtqvCCBRhlygYalO05zFEdPy7oEjqQH9ChESSMWG7Mm+7Lkc/fUDU7CjGi1n9tSSi9xX2Cj37tcd/eAzp27c9imsh8537MPpL8NBRA31AbNFI4JGU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR1301MB2097.namprd13.prod.outlook.com (2603:10b6:405:2e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 04:25:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%6]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 04:25:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqKDxq04E9R4EezGQhAvzMsOqjeMTgAgABM3wCAAF7VgIAF4BMAgJ9AToCAAArJgILGzxlrgAooz4CAAR4sAIAANXEAgAAxJICAAAZDAIABJ3WAgADSFICABkfwgIAMmo1KgBfyoICAAAR0gA==
Date:   Wed, 2 Feb 2022 04:25:34 +0000
Message-ID: <ec6f560da09520397063f4230e182d499928ab01.camel@hammerspace.com>
References: <20201001214749.GK1496@fieldses.org>        ,
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>   ,
 <20201006172607.GA32640@fieldses.org>  ,
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>        ,
 <20220103162041.GC21514@fieldses.org>  ,
 =?utf-8?q?=3COSZPR01MB7050F9737016E8?=
 =?utf-8?q?E3F0FD5255EF4A9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?=
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>       ,
 <20220104153205.GA7815@fieldses.org>   ,
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>       ,
 =?utf-8?q?=3COSZPR01MB7050C5098D47514FFEC2DA82EF4B9=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <20220105220353.GF25384@fieldses.org>  ,
 <164176553564.25899.8328729314072677083@noble.neil.brown.name> , =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050A3B0D15D38420532CD31EF579=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E?=
 <164245842205.24166.5326728089527364990@noble.neil.brown.name>
         <OSZPR01MB7050DF6073AB2EC4F82A589AEF279@OSZPR01MB7050.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7050DF6073AB2EC4F82A589AEF279@OSZPR01MB7050.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1046ae4-1e5c-4c1d-a614-08d9e6040e5a
x-ms-traffictypediagnostic: BN6PR1301MB2097:EE_
x-microsoft-antispam-prvs: <BN6PR1301MB2097A483A3571C9508BBE7E3B8279@BN6PR1301MB2097.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ln1TQHE9g9IlD/GvdEaMBXH79pBNg56iyQDOAQqJg8TIkGleCOWMseIp4LceVjCk8vcmAzgoCzPn74TPnWZ+M8+Qo2OqngIi+84k7+dSnmFwoTnlp3dH8JpZAdzvSM34kIPnxV4lQJaqBuE1W0+pRY3esr4VE9sc9onRL6deXk86bqkGXdh8njzT18nHDbeBWiqL7S/rDmxgrzH/8mSGA084HX1jNpnq4rr8nSZjwU9MhiWzjOThb552745sOwqBFeLLETyn6zpLs4Wki8qA2Wwn9G4v+Ucy5yjC4dWi9wwtcIZdfIqkxD8ccMIW5t2Z219qgP7xbOUkIK87pLVNzm1XJzsz51E+j+CeXxG8tup9ojTO0IsX3BixEV2d4m3PX5WmrXBT75Q7Rw1MEKFW84eEQQblzjzxy3iugwFQRgTE9cYr/KFZg4IM63EBhI7VXm2Q0bXdnfg2OlhJKGtSl1mMbMZZ9tbP+rC+CLVAnQMTctJW/6Mivk6BAVyfHFmToOBMg29JiiYcbXY/zkUY8ySNHWSF6dVpPzqclD85JnLlko2rPHu7R8emU2C3GPj7wT4eVycwY+HbanM/JvD6QT3SVi29o/ungZu6yKN78q9kI1isbt27xAmpFFejoYKNyseZZ4vK3Lg+5bfkZNq8uE4PHMukYTMrF5Q97JY31Jh48BZap15WnVZkmsfM2gkj0B++AFA9hKGDdkbV4QtSig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(346002)(376002)(396003)(136003)(8936002)(36756003)(64756008)(8676002)(2616005)(66446008)(122000001)(71200400001)(5660300002)(26005)(66556008)(66476007)(4326008)(2906002)(186003)(76116006)(66946007)(38070700005)(83380400001)(38100700002)(6506007)(3480700007)(508600001)(316002)(110136005)(86362001)(54906003)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1NxMEh1R2N2S0dWem5WWnVidTZ0MUlCWEhRa2hScVUzN214Yk04UXh2T1lE?=
 =?utf-8?B?LzFQSnhadllMbi83UFFGbml5ZzNzOVZUNmtaWW1NMkNtc1BrUXpCcGFtSE90?=
 =?utf-8?B?QTNHZ0NQVjVQeXhKYWkxYW1XeloxT3NPWDVMTkN5bXA0bDlXTG1qNWJJRlls?=
 =?utf-8?B?ZnJPeUdWRUNRbWFaQWwrYTVXMS9RZllGeW9MVStQRnhadHB4anM5OXpxaWdy?=
 =?utf-8?B?NXFVL0oyRE51dEl0cGI5SDJwb3NBcjFVUloyMzVHekhQbFFyKzl3MEZQdzlM?=
 =?utf-8?B?cG5wUDBEZGl2NmdzZ3h4SjRzcU1oM3hnQVFWOHB5UEFmZFVTRDB5WlZqNTNU?=
 =?utf-8?B?QkJaN2NXL1ZXK2Y4bmxYTHVneUxlY0k1cFNJRGl5ZFFsOGRrc1NZSHpjL2Zy?=
 =?utf-8?B?UGE0cDBiTU5odkVTL3VMeHZMak00NUNLam1FS2J0UjgrTXhjb0RrRmREOXJo?=
 =?utf-8?B?RWpxbEovWHhsNXN6Mk4zTEsrdzYzQkUwd0d4MERrYUllVmw0RkRwTGhZWXpT?=
 =?utf-8?B?cWJlQWU3ZldsYTd3aGZncmoyMVZPZ1JSbHR1amhvQ2JMMWlFOE1JL1E3aTZN?=
 =?utf-8?B?dnp6K0pEOThqamsvSnhmV3RZY1hLL3k3ZkgyUEhnSTZSUFhGZWhucUk3aGxY?=
 =?utf-8?B?WDdaTXpWRkJCMFJDUlM1VUxJMDBuSWdMaFcrajE5dW9zbDlyb3JZcW1aUkZm?=
 =?utf-8?B?SW1lUWRoL29sK2xXZFpCT2c2TlBmdnBUUzlkZzhaY3lxL2dqakNoOEJDa3gy?=
 =?utf-8?B?cVQzT2RvL0t3SUdHTXFhSXFFM0s3SG5PWnR3aHBiMjBhRjR5azhteGRCOVlG?=
 =?utf-8?B?RVNmZzNxcmhKaFIxbTEwcXIwcGRlS3lBTnd1Sk1NR1hhWnFwd2lDYlk2Ump3?=
 =?utf-8?B?WlRnTFFsekpqQXRsL1BPTHVsR3NVMWhBWDhmZlZwcllBT3p2VmY5anZlWERW?=
 =?utf-8?B?N3EyVStwckhWT1hOc0JBVExyWHhFYThXVWorb1VmdDlzYlM3bTVyYU5mMkpY?=
 =?utf-8?B?V3RjYVljMzBJdzl5TGJjY1hXWUxSUUJ4UHMzZk9PdmNaUmVBaitOZ2VWbkVT?=
 =?utf-8?B?ZFBmbm5xemtPekVydjdPTURaZzErVWw3cllLUCs4NmZWcFJrRTNJRkExQ3RY?=
 =?utf-8?B?eENscTBEMlI2NU9Ka09nMUN1UmVIeFFkRm9NK2VCb3NobTJYVmozbnh6UGo1?=
 =?utf-8?B?Nk5Wa3VpcFQ2c0dlODZGU05CdDc2WG50elNUZnVPSFhuV2d2VHlmdkxzR1cv?=
 =?utf-8?B?WlFzYW9aaE0zWEVUZDlueDVjQ0hSTDJXOEtvc3VNc0Q4ZDBJWnM0S2ZaWHhp?=
 =?utf-8?B?a2g5am91T1B2YWJScVFqNUZBNlVPY0tiT1hPdnJsdVlONlZLSW85TWxRbE1X?=
 =?utf-8?B?cHlmaDEyVFNXd0RieStHZHliL0xpcE5WT1FNZmU2eEhzNTEvOHlBclovczUv?=
 =?utf-8?B?Zkp6a2MraGoreGg1ZDJwTGErN1RtZDJQZXRmbnFZTDlmdHNISHJYc1lVeS9Z?=
 =?utf-8?B?ZFljakllZmtBUVdPZVE3eVNheTZnckYxZVcrbFpwZDk5LzJuUjJBRnExdGNi?=
 =?utf-8?B?cmFwNllzR0JlMWRvcHdzdlp1OUNKSGZPN3g5eXd2d2lKb0tZKzN1cS9HTE9O?=
 =?utf-8?B?MVdKZG83UXRCR0FnQklhM2JSSmpuM044aTFpWE1pMFVQanRQQTBnS0FhUUpH?=
 =?utf-8?B?VG9kU2hzVkFVMjh6ZndWL080R2JYRXhZZFNleGF0NkRPalpSVllpODZqL1FQ?=
 =?utf-8?B?am5jK25rN015ZXVSby9mMmF5UzQvMGo4TUlCRmlwSUY3L2VrY05DN0lCV0JU?=
 =?utf-8?B?U2g0aDdvYzZyYXJ1UmVWTHUzMjRycDBlRWdOekc1dEFmQWhXMjBlQy9LS2N4?=
 =?utf-8?B?QWpCRzg1dlNLRVB3Y3FtSzFiSThFaWxOZUFuNFdiUW9VaFJ0L3AwbmVNdGFK?=
 =?utf-8?B?bklnSUxwd1VtTGJjRlVqbDJQQzkwYkhjK1k0Q0NGYzhPWVdnNUZ4aS9XQjh2?=
 =?utf-8?B?VU1wbU5IWFFnVDR5NXN3VU9wNkZRNWhjeWRjVTFMa2g2azlWWUhUbkVaQ3Ev?=
 =?utf-8?B?NkdzVUJmMi93U3I3b2ltVGV1aVZVQXhJMU5oVTFsdlhXSmpJQ3pWS25CRXhu?=
 =?utf-8?B?WGhzanFmdnFUZ3BkRFhUNzdaT3lxZjgyTTY5WUlleGtPVS9EL3p6NHlnUHVW?=
 =?utf-8?Q?JRsj7HGb8hZ78emkEA/SHTE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD1ADF58F97D524CA06F9A51A0742AB3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1046ae4-1e5c-4c1d-a614-08d9e6040e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 04:25:34.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcsNf90gw5N523I49cAXK4BSZ6jud0WkXVqWtNlsZPsFsXqiOUSAXAFxj7NSAAPW647m3yg+aD0uESfYFbt+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB2097
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAyLTAyIGF0IDA0OjA5ICswMDAwLCBpbm9ndWNoaS55dWtpQGZ1aml0c3Uu
Y29tIHdyb3RlOgo+ID4gSSBkb24ndCB0aGluayB0aGF0IGNhc2UgYWRkcyBhbnl0aGluZyBpbnRl
cmVzdGluZy7CoCBXaGVuIHRoZSBmaWxlCj4gPiBpcwo+ID4gY2xvc2VkLCB0aGUgbG9jayBpcyBk
cm9wcGVkLsKgIElmIHRoZXJlIHdlcmUgYW55IHdyaXRlcyB3aXRob3V0IGEKPiA+IGRlbGVnYXRp
b24sIHRoZW4gdGhlIGNoYW5nZWlkIGlzbid0IGEgcmVsaWFibGUgaW5kaWNhdGlvbiB0aGF0IG5v
Cj4gPiBvdGhlcgo+ID4gY2xpZW50IHdyb3RlLsKgIFNvIHRoZSBjYWNoZSBtdXN0IGJlIGRyb3Bw
ZWQuCj4gCj4gSSd2ZSB1bmRlcnN0b29kIGl0LiAKPiAKPiBJJ3ZlIG1hZGUgdGhlIHBhdGNoIGJh
c2VkIG9uIHlvdXIgaWRlYS4gSXQgaW52YWxpZGF0ZXMgdGhlIGNhY2hlCj4gYWZ0ZXIgYSBjbGll
bnQgd2l0aG91dCB3cml0ZS1kZWxlZ2F0aW9uIHNlbmRzIENMT1NFIGNhbGwuCj4gTXkgT3BlbiBN
UEkgdGVzdCBwcm9ncmFtIGNvbmZpcm1lZCB0aGF0IHRoaXMgZml4IHJlc29sdmVzIHRoZQo+IHBy
b2JsZW0uCj4gCj4gVGhlIHBhdGNoIGlzIGFzIGZvbGxvd3MuIFdoYXQgZG8geW91IHRoaW5rPwo+
IC0tLS0tCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9j
LmMKPiBpbmRleCBiMThmMzFiMmM5ZTcuLjY3MDIxNzg2MDM0ZCAxMDA2NDQKPiAtLS0gYS9mcy9u
ZnMvbmZzNHByb2MuYwo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jCj4gQEAgLTM3MTEsNyArMzcx
MSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnBjX2NhbGxfb3BzIG5mczRfY2xvc2Vfb3BzCj4g
PSB7Cj4gwqAgKi8KPiDCoGludCBuZnM0X2RvX2Nsb3NlKHN0cnVjdCBuZnM0X3N0YXRlICpzdGF0
ZSwgZ2ZwX3QgZ2ZwX21hc2ssIGludAo+IHdhaXQpCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoCBzdHJ1
Y3QgbmZzX3NlcnZlciAqc2VydmVyID0gTkZTX1NFUlZFUihzdGF0ZS0+aW5vZGUpOwo+ICvCoMKg
wqDCoMKgwqAgc3RydWN0IGlub2RlICppbm9kZSA9IHN0YXRlLT5pbm9kZTsKPiArwqDCoMKgwqDC
oMKgIHN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIgPSBORlNfU0VSVkVSKGlub2RlKTsKPiDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgbmZzX3NlcWlkICooKmFsbG9jX3NlcWlkKShzdHJ1Y3QgbmZzX3Nl
cWlkX2NvdW50ZXIgKiwKPiBnZnBfdCk7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG5mczRfY2xv
c2VkYXRhICpjYWxsZGF0YTsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmZzNF9zdGF0ZV9vd25l
ciAqc3AgPSBzdGF0ZS0+b3duZXI7Cj4gQEAgLTM3NzMsNiArMzc3NCwxNSBAQCBpbnQgbmZzNF9k
b19jbG9zZShzdHJ1Y3QgbmZzNF9zdGF0ZSAqc3RhdGUsCj4gZ2ZwX3QgZ2ZwX21hc2ssIGludCB3
YWl0KQo+IMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IDA7Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKHdh
aXQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IHJwY193YWl0X2Zv
cl9jb21wbGV0aW9uX3Rhc2sodGFzayk7Cj4gKwo+ICvCoMKgwqDCoMKgwqAgaWYgKHN0YXR1cyA+
PSAwICYmICFORlNfUFJPVE8oaW5vZGUpLT5oYXZlX2RlbGVnYXRpb24oaW5vZGUsCj4gRk1PREVf
V1JJVEUpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3NldF9jYWNoZV9p
bnZhbGlkKGlub2RlLCBORlNfSU5PX0lOVkFMSURfQVRUUgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgTkZTX0lOT19JTlZBTElEX0RBVEEKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IE5GU19JTk9f
SU5WQUxJRF9BQ0NFU1MKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IE5GU19JTk9fSU5WQUxJRF9B
Q0wKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IE5GU19JTk9fUkVWQUxfUEFHRUNBQ0hFKTsKPiAr
wqDCoMKgwqDCoMKgIH0KPiArCj4gwqDCoMKgwqDCoMKgwqAgcnBjX3B1dF90YXNrKHRhc2spOwo+
IMKgwqDCoMKgwqDCoMKgIHJldHVybiBzdGF0dXM7Cj4gwqBvdXRfZnJlZV9jYWxsZGF0YToKPiAt
LS0tLQoKTkFDSy4gVGhhdCBpcyBjb21wbGV0ZWx5IHVuYWNjZXB0YWJsZS4KCi0tIApUcm9uZCBN
eWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
