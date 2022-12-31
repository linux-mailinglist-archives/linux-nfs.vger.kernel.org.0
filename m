Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C40465A186
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Dec 2022 03:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiLaC1G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Dec 2022 21:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiLaC1F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Dec 2022 21:27:05 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Dec 2022 18:27:03 PST
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9F71C921
        for <linux-nfs@vger.kernel.org>; Fri, 30 Dec 2022 18:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1672453624; x=1703989624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iVkkPGJvZHGEF9OYbUfzpkzU1uos59TrRtCxuEkiXiU=;
  b=oe0EM3E/Ycdh9sIuiiMHmt6Kbu0GbfRyNkseyXDNSdVUDCwn9dESkUDr
   LNRbH08fD1QQxJM7nFAjbDPiH9Dzbbn3gqRGxnfhHMg2V7J2SCuL+houf
   pFsoADMOIlP1kd1VDnLwFgpDg5LdYQr4IC52+L9eLBy1vGF2bJ9cPT3Xh
   m92GNZmwN6dyq+6BHPksf9nAXpS2RmjxfECfSJfRIFekPko2E4Td1qVT+
   eKT13w+8LezRMX1A5aoehdFgpcyvdyIyRfL38/Xd3r17fhsenIPxFjlP8
   kv5I6TxZQqlEmJz4EI22sIF8PVyxshdwsEK+gTeHP0ms4GQ9xdwSFba2N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="81852103"
X-IronPort-AV: E=Sophos;i="5.96,288,1665414000"; 
   d="scan'208";a="81852103"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2022 11:25:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvNlUzPglc6NBeUw29HTd8KKD1sEKdb8+JhIgtUOwVmXLMw0JI+FNgKZLwmedag8uLxMY4ee7oY6jHMHdjc2WSHjMCIJdqXts8UJy2Z+RnFi+mO12QCWDY83u/ZZorJIg4dvhm4AVRuVOoutiHCL0TcZhPKCOZg9nxOG9gTAeBWMZstSh8joqICXraVPlhokkiyVAHrqS+QwvGthszEi6E4EGsyxvDdZyCuKIyUKOa4LwgtCYW91PKdEIwGA7bxiQdZPst8TM+V2i1UcwBVk6MItyku2Rp0eEn5mQ8dvFrM+WlBhRgxtDxr9zCkDL1QJWt32XMPv2JMijYNc8wgvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVkkPGJvZHGEF9OYbUfzpkzU1uos59TrRtCxuEkiXiU=;
 b=eWAmSglextKEZIXjkgLjOuxjBZSWr11oooGygUriM4eHMVUUCnzGTv9SlP/Od5pOeQHs+Kpl1PCidPUzyQ7NgtBMVy+i+kjf87Ny2etNx6EcGussttnoFsGGODA5QHjsGqRsyJYBkAp8Q9s36kZToXlPAjl76UB2NUVCONB6sovQjzmHCKy5FWbjR+XA+8EsyfzlOCX8IhVnpquvKH9ISZXq7E1f4ShEU/GsgZinred1V/isMe9TNexxRncLSqMY7Mg1MmfOshIkb2R5vWxZx5VDP7kwMQ8BohdELNl4Z6c8UaIHF8yzPJADHnWYVSIkNcEYol0aFEpGa9R96eY+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB6433.jpnprd01.prod.outlook.com (2603:1096:604:106::14)
 by TYYPR01MB7853.jpnprd01.prod.outlook.com (2603:1096:400:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 02:25:53 +0000
Received: from OS0PR01MB6433.jpnprd01.prod.outlook.com
 ([fe80::acc7:9d08:e2be:4939]) by OS0PR01MB6433.jpnprd01.prod.outlook.com
 ([fe80::acc7:9d08:e2be:4939%9]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 02:25:53 +0000
From:   "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Christian Brauner <christian@brauner.io>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: nfs setgid inheritance test
Thread-Topic: nfs setgid inheritance test
Thread-Index: AdkcP3S1h2MICz3sSoubu+LIQgJSngAJqNYAABYyXpA=
Date:   Sat, 31 Dec 2022 02:25:52 +0000
Message-ID: <OS0PR01MB64334F6BB7530E4334CDD2F4E3F19@OS0PR01MB6433.jpnprd01.prod.outlook.com>
References: <OS0PR01MB64337F9E0954384995085EFDE3F09@OS0PR01MB6433.jpnprd01.prod.outlook.com>
 <20221230154800.pt3hkfzmkmmmtuq7@wittgenstein>
In-Reply-To: <20221230154800.pt3hkfzmkmmmtuq7@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9Mjc4OTNjOWYtODBmZS00MWI0LTkzM2ItYzI0N2EzZjJk?=
 =?utf-8?B?MGIxO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0xMi0zMVQwMjoyMzozM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6433:EE_|TYYPR01MB7853:EE_
x-ms-office365-filtering-correlation-id: c540a536-7111-4d38-b26b-08daead656fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lJM0F7tusHQdMK7qh1abeG2ultN6ZihrQ8MG2cWuOhjkppok/2tn4NMQ2Db1wZeVAeVv2Q7bm5jJcrEbq9hGCk83diGxsas2Ya9l5DononrK6xJVnPcz9a8tRlWSuJ8XI6LiwSNp8UW6YvPddsHDjeMkaiQpN6tRziRZYBx/l0tUHt9kSaY5qdlEjM4B3WEg0pVPVV4DL8TEspdculvuX+EVdXWP9h8lKpCF3N6cMumhZ+RCcCaIosj6UT0COfe/R0xj9EAzOIW7DOjN1pr3Rih1H0y+bFyfMtfzwrHzqnUe2PCk/yzU2JOrTJ16ztG+ppBcvLWVBaFUP1o9aUktcE3sp8NzCGnCPMvovqOvwxk2xk4w7vgUeIqRGj3LhUtsz6bTaH49s8fp2pCmk7enbRs//OCx7DFRofL+66viMBUQfqrG2hr1FPsAxizYxFhr83N/F70PuaUdwLHKoSEMRa/7wUJrh2XSctIu98PDQbGdMRj8YoW5n1wiqkt69TCoXsEvlsMSRrJiQpAtoc6M7ktMT5UrXCSGLqb8aHz8FKFqviGmul6j6vM+t+vRy5FmZ2Th5uJ1DNEdGNdbXoGTY+W1eQ93SFshLpVKkuvKW43jQHhyrU2yd40vmywxeSLdSFiFkwsf5BEZP/VyUjcEYNNRK3vryL76/iHkRDdtHy54s6bTP7cJsbnJk3CXxxk+izcPAk96aLHJyxC6WdnySbodznZ8PhyiYLVz7Ev4Sb4u6CiCptKalYahpT7b+1DVVUPOm5Ea8axy0HKSGi/RZdIsOxnPZrQ3p4AasLi4GElXrmY7a6P0pHJp7WSx1H9pw0O8B1zQVhoO6FKB6xbpvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6433.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(1590799012)(55016003)(9686003)(26005)(38070700005)(41300700001)(186003)(6506007)(53546011)(7696005)(86362001)(478600001)(82960400001)(3480700007)(52536014)(966005)(122000001)(5660300002)(8936002)(4001150100001)(1580799009)(2906002)(45080400002)(71200400001)(83380400001)(33656002)(54906003)(6916009)(85182001)(316002)(64756008)(66556008)(66946007)(66446008)(66476007)(76116006)(4326008)(8676002)(38100700002)(218113003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1E5WGtLeWc5ZUc4My9xcDN2bnQ1MkJ1YnI2cGROOWpzM3NEZWNMTkRCWjI2?=
 =?utf-8?B?MnYraC9SMlN4Mjh6KzhNbEw1NWJXbE5NN0Y1QW1iOUplL0N5S3F4S3QzSlly?=
 =?utf-8?B?Z0NldzJvS2ZoWkJ4dDIxRW5SWVlnWkd2dDBhU0NqVUNwWmIxNEZvWDhUMnlD?=
 =?utf-8?B?L2NLWWh4b2duR2JVT1B0QWsya0o1V2pERWUvOENvQjZUOGZuTUVGRGdROWxw?=
 =?utf-8?B?Vnd2WVFHVUxIVkd1RGh0cmM4b2swRWN1aSt3NlV5d1lPS3BNQUMrUEhScFlu?=
 =?utf-8?B?L3pqRmRFZUprS3dXZHl6UjdYc1VOU2dVaFkzaGowSUN3U3VqMGFkb1h4Vjl1?=
 =?utf-8?B?dVpGTTRQTXZydVc3aUpldjg3cnljVmZ6b0E3Ulo0M1J4OEVzV3IyeHQxZU5U?=
 =?utf-8?B?TVZycVdiTmRFMWtKOXVWd3laRW5CT0tDWmczbDlEaWN0cVlqSWc1KzZqdnJM?=
 =?utf-8?B?R0toV211VTNuT3hUWDhHbXJybG1KQW9WdEV1RGVzYVMxRy91QlhEUDlNdEVG?=
 =?utf-8?B?YUVUM2FNZGp3OSt0emN6cmRBeGxzUVdteS9KNVdTTlZMUFpEcXZ2aTk4RGJ2?=
 =?utf-8?B?ekxNMUhzZ09aOVJFU2VwVXowaC9WSi9wRit6VDMwaWlVejlPYWNhQzMwWi9r?=
 =?utf-8?B?ZUlUQVJIOXRLMHp4K2FvZjU0MmVpLzRES04rMGg1d05nQWV2MGNtRnR3RTht?=
 =?utf-8?B?NFd0VHQraTNkTndUN0Y4M1F4cFYxTktCaXNxQ05GcE1yTENxK25ERHlpeTZD?=
 =?utf-8?B?ZkNxb1cySkpqR1pVK2tMcG5TYkpMeGorb2FaVG9CUVo2Mm52c1lXcmk0QUFB?=
 =?utf-8?B?VjJUc2VsSzM3MUtVR0VMOW5MM2hrY2oxSzZYaFFGRTQzb3lkUzNTeGdyR0t0?=
 =?utf-8?B?V3JNOHVVMFlqT2Zta3MzMDdiMjBzdmdqb0krNVgxTXlGOCtLMnVOQWxvWHlW?=
 =?utf-8?B?S3VlWHZNc3VyL01jRG0yZUNLaVI5Z0JNalM4MEx5WTkrbnkzTXN3V0RCaVZ2?=
 =?utf-8?B?TmlIbmtCYmN4bE83TW92RXNyaDF2OFRXem1QakVwY0Y3OEVUbURVTUU5ays0?=
 =?utf-8?B?bHhBaURrVmg0NXdhRmEzQzBDMG50NzI5eW1QZVlwQ0J2eGFxYWJrT0dFSTFK?=
 =?utf-8?B?aTRLZFA0UjMyWUlId0VLd2djMlM5WFJHSXA3R2NYVk5IMHdsdnRpWG9ERzJw?=
 =?utf-8?B?MXBhVmo1RGI4QWdmTFZMc3RYa0FwVTUrT1hVQ3hBOTJ2OCtpUFJmRkphdVpo?=
 =?utf-8?B?OGU2TGtSQWZPMzZWNG9yZDlVVnZYM3prYmRoU0dVbVo5dVZXTk45YTlBQ1pk?=
 =?utf-8?B?M2xhTE5kYTdUSVN5TkNYbWFFZTRzTWpkV28vR3c2VVNvWFBHVFp2am9MMmVk?=
 =?utf-8?B?WVZLOElRR25SOUlEWjBJSVZwTFl2aHU1aWhZbCtodFQ0dGdqd2ExSjh6eGxw?=
 =?utf-8?B?V2ovdVZoRzBVSHRRdzhGRmxmdStnMG9NQk95S0JhWTR6R2syN1ZKVGI2OFBx?=
 =?utf-8?B?dlJaRDdPS2tCdmhDYTBMK0w1UFY3NFNRM2V3QkxXc3dvV3Zqd2t6ZHd1d0ZZ?=
 =?utf-8?B?NU5Zd0RIb1lHY3Y2VGd1VXJPRStPcWtpZnB2b25SSWVsUGo1WUZLb1d1Ynh0?=
 =?utf-8?B?aDZCQVFCOVptK21HQkVhVUJCa0NWVUcyUHBRVnZMUjV1cUJ3YWIvamdzY0pN?=
 =?utf-8?B?OUk5WVFmc3lRRzVWQUxHWFBGUGlNclJ6aGszcmZoNHgxc0VTSHF6cGVqTThZ?=
 =?utf-8?B?LzFnT1dURzU3S0x3RkhlSmtyV05TNVZ5bGFSdUlwL3pPd1pJam1xNGJRNExG?=
 =?utf-8?B?eGhoYjQzT2VCODhYemlQekZaNnl6ejIzbVV5OXJrMlpBUk9nSjZvVXNpdDE3?=
 =?utf-8?B?NEh4MUt5VS93VnQ3akxRd2FaNjQwMENpNXhoUHBBOTBtSWNtZGN0bmw4V3RX?=
 =?utf-8?B?OWJrLzA5bmowYk1tVzdEWTRxTWdVZmp1RHNFVjYvaUR6clVLdHhzTkVIRE1z?=
 =?utf-8?B?eXVaY0UzKy8rN0Jzc0lpT01HR3M0dkgyK2xJdWZaKzJRbHVpRGtZMXk0SnVo?=
 =?utf-8?B?ZWNBWGc1c1Z2a05BQmpLeUcyTm15azBReTNWc2ZidFE4QlNKTko4Sm9NcnNx?=
 =?utf-8?Q?EBvCat114CY7/0MA0Sd9T4UWl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6433.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c540a536-7111-4d38-b26b-08daead656fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2022 02:25:52.9024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jz603d9gOI1ZW0GOZKtm6Q+iTqlfSG154ZYRLPZbejlx4PDyKBfodC9hQswuJiRyKeXdKdU/SwxtVXvezY2jeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7853
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGksIENocmlzdGlhbg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2UuDQoNCj4gQWZhaWN0
LCBub3RoaW5nIGhhcyBjaGFuZ2VkIGFuZCB0aGUgdGVzdCBzaG91bGQgc3RpbGwgYmUgc2tpcHBl
ZC4NCj4gSSdtIG5vdCBzdXJlIEkgZXZlciBzZW5kIGEgcGF0Y2ggdG8gc2tpcCB0aGlzIHRlc3Qg
c3BlY2lmaWNhbGx5IGZvciBuZnMgdGhvdWdoLiBJDQo+IG1pZ2h0IGp1c3Qgbm90IGhhdmUgZ290
dGVuIGFyb3VuZCB0byB0aGF0Lg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgYWxzbyBzZW5kIHRoZSBl
eGFjdCBzdGVwcyBmb3IgcmVwcm9kdWNpbmcgdGhpcyBpc3N1ZT8NCg0KVGhlIHJlcHJvZHVjaW5n
IHN0ZXBzIGlzIGFzIGZvbGxvd3M6DQoNCkNsaWVudCAmIFNlcnZlcjoNCjEuIEluc3RhbGwgeGZz
dGVzdHMNCjIuICMgeXVtIGluc3RhbGwgbGliY2FwLWRldmVsDQoNClNlcnZlcjoNCjEuIFNldCBl
eHBvcnRzIGZpbGUuDQojIGVjaG8gIi9uZnN0ZXN0ICAgICAgKihydyxpbnNlY3VyZSxub19zdWJ0
cmVlX2NoZWNrLG5vX3Jvb3Rfc3F1YXNoLGZzaWQ9MSkNCi9uZnNzY3JhdGNoICAgICAgKihydyxp
bnNlY3VyZSxub19zdWJ0cmVlX2NoZWNrLG5vX3Jvb3Rfc3F1YXNoLGZzaWQ9MikiID4vZXRjL2V4
cG9ydHMNCjIuIFJlc3RhcnQgc2VydmljZXMuDQojIHN5c3RlbWN0bCByZXN0YXJ0IHJwY2JpbmQu
c2VydmljZSANCiMgc3lzdGVtY3RsIHJlc3RhcnQgbmZzLXNlcnZlci5zZXJ2aWNlDQojIHN5c3Rl
bWN0bCByZXN0YXJ0IHJwYy1zdGF0ZC5zZXJ2aWNlIA0KDQpDbGllbnQ6DQoxLiBDcmVhdGUgbW91
bnQgcG9pbnQgDQojIG1rZGlyIC1wIC9tbnQvdGVzdA0KIyBta2RpciAtcCAvbW50L3NjcmF0Y2gN
CjIuIENvZmlndXJlIE5GUyBwYXJhbWV0ZXJzLg0KIyBlY2hvICJGU1RZUD1uZnMNClRFU1RfREVW
PXNlcnZlcl9JUDovbmZzdGVzdA0KVEVTVF9ESVI9L21udC90ZXN0DQpTQ1JBVENIX0RFVj1zZXJ2
ZXJfSVA6L25mc3NjcmF0Y2gNClNDUkFUQ0hfTU5UPS9tbnQvc2NyYXRjaA0KZXhwb3J0IEtFRVBf
RE1FU0c9eWVzDQpORlNfTU9VTlRfT1BUSU9OUz1cIi1vIHZlcnM9M1wiIj4vdmFyL2xpYi94ZnN0
ZXN0cy9sb2NhbC5jb25maWcNCjMuIFRlc3QNCiMgLi9jaGVjayAtZCBnZW5lcmljLzYzMw0KDQpU
aGFua3MsDQpjdWl5dWUNCg0K4piF4piG4piF4piG4piF4piG4piF4piGRk5TVOOCquODs+ODqeOC
pOODs+OBuOOCiOOBhuOBk+OBneKYheKYhuKYheKYhuKYheKYhuKYheKYhg0KICAgRk5TVOacgOaW
sOaDheWgseebm+OCiuOBn+OBj+OBleOCk++8gQ0KICAgaHR0cDovL29ubGluZS5mbnN0LmNuLmZ1
aml0c3UuY29tL2Zuc3QtbmV3cw0K4piF4piG4piF4piG4piF4piG4piF4piG4piF4piG4piF4piG
4piF4piG4piF4piG4piF4piG4piF4piG4piF4piG4piF4piG4piF4piGDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2Vy
bmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAzMCwgMjAyMiAxMTo0OCBQTQ0KPiBU
bzogQ3VpLCBZdWUgPGN1aXl1ZS1mbnN0QGZ1aml0c3UuY29tPg0KPiBDYzogQ2hyaXN0aWFuIEJy
YXVuZXIgPGNocmlzdGlhbkBicmF1bmVyLmlvPjsgbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogbmZzIHNldGdpZCBpbmhlcml0YW5jZSB0ZXN0DQo+IA0KPiBPbiBGcmks
IERlYyAzMCwgMjAyMiBhdCAxMToxMTo1NkFNICswMDAwLCBjdWl5dWUtZm5zdEBmdWppdHN1LmNv
bSB3cm90ZToNCj4gPiBIaSwgQ2hyaXN0aWFuDQo+ID4NCj4gPiBXaGVuIEkgdGVzdCB4ZnN0ZXN0
cyBvbiBORlMod2l0aCBub19yb290X3NxdWFzaCksIGdlbmVyaWMvNjMzIGZhaWxzIGxpa2UgdGhp
czoNCj4gPg0KPiA+IGdlbmVyaWMvNjMzICAgICAgIFtmYWlsZWQsIGV4aXQgc3RhdHVzIDFdLSBv
dXRwdXQgbWlzbWF0Y2ggKHNlZQ0KPiAvdmFyL2xpYi94ZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmlj
LzYzMy5vdXQuYmFkKQ0KPiA+ICAgICAtLS0gdGVzdHMvZ2VuZXJpYy82MzMub3V0ICAgICAyMDIy
LTExLTIzIDA5OjEzOjQ4LjkxOTQ4NDg5NSAtMDUwMA0KPiA+ICAgICArKysgL3Zhci9saWIveGZz
dGVzdHMvcmVzdWx0cy8vZ2VuZXJpYy82MzMub3V0LmJhZCAgIDIwMjItMTEtMjQNCj4gMDU6NTM6
NDAuODM2NDg0ODk1IC0wNTAwDQo+ID4gICAgIEBAIC0xLDIgKzEsNCBAQA0KPiA+ICAgICAgUUEg
b3V0cHV0IGNyZWF0ZWQgYnkgNjMzDQo+ID4gICAgICBTaWxlbmNlIGlzIGdvbGRlbg0KPiA+ICAg
ICArdmZzdGVzdC5jOiAxNjQyOiBzZXRnaWRfY3JlYXRlIC0gU3VjY2VzcyAtIGZhaWx1cmU6IGlz
X3NldGdpZA0KPiA+ICAgICArdmZzdGVzdC5jOiAxODgyOiBydW5fdGVzdCAtIE9wZXJhdGlvbiBu
b3Qgc3VwcG9ydGVkIC0gZmFpbHVyZTogY3JlYXRlDQo+IG9wZXJhdGlvbnMgaW4gZGlyZWN0b3Jp
ZXMgd2l0aCBzZXRnaWQgYml0IHNldA0KPiA+ICAgICAuLi4NCj4gPiAgICAgKFJ1biAnZGlmZiAt
dSAvdmFyL2xpYi94ZnN0ZXN0cy90ZXN0cy9nZW5lcmljLzYzMy5vdXQNCj4gPiAvdmFyL2xpYi94
ZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmljLzYzMy5vdXQuYmFkJyAgdG8gc2VlIHRoZSBlbnRpcmUN
Cj4gPiBkaWZmKQ0KPiA+DQo+ID4gV2UgaGF2ZSByZXBvcnRlZCB0aGlzIHByb2JsZW0gb24gRmVi
dXJhcnkuDQo+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzL09TM1BSMDFN
Qjc3MDUzOTQ2MkJFM0U3OTU5REFGOEI1Nzg5Mw0KPiA+IDg5QE9TM1BSMDFNQjc3MDUuanBucHJk
MDEucHJvZC5vdXRsb29rLmNvbS9ULyN1DQo+ID4NCj4gPiBBdCB0aGF0IHRpbWUsIHRoZSBjb25j
bHVzaW9uIGlzIE5GUyBzaG91bGQgc2tpcCB0aGlzIHRlc3QuDQo+ID4gQnV0IEkgY2Fubm90IGZp
bmQgdGhpcyBwYXRjaCBpbiB0aGUgbGF0ZXN0IHhmc3Rlc3RzLg0KPiA+IERvZXMgTkZTIHN0aWxs
IG5lZWQgdG8gc2tpcCB0aGlzIHRlc3Qgbm93Pw0KPiANCj4gQWZhaWN0LCBub3RoaW5nIGhhcyBj
aGFuZ2VkIGFuZCB0aGUgdGVzdCBzaG91bGQgc3RpbGwgYmUgc2tpcHBlZC4NCj4gSSdtIG5vdCBz
dXJlIEkgZXZlciBzZW5kIGEgcGF0Y2ggdG8gc2tpcCB0aGlzIHRlc3Qgc3BlY2lmaWNhbGx5IGZv
ciBuZnMgdGhvdWdoLiBJDQo+IG1pZ2h0IGp1c3Qgbm90IGhhdmUgZ290dGVuIGFyb3VuZCB0byB0
aGF0Lg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgYWxzbyBzZW5kIHRoZSBleGFjdCBzdGVwcyBmb3Ig
cmVwcm9kdWNpbmcgdGhpcyBpc3N1ZT8NCg==
