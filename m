Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE765A7168
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 01:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiH3XPQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3XPP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 19:15:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89704186F1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 16:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laXxPNwgE0TrhfCbD4dqdLfBYAViu58amua4XoyTHc2hVniSAodtxrrHB1LvI9vvc7WyT9eyQSoIJ4uNHZ3GLWjkcmdR9zKA5GyR30NB9inuhUZrAwC7VKJV89fo9rDp6OSvEILSF/jugMvos8HHDksvhQwtdruKAlAzYk/ODb5t8WOW1PJz2Qhk/v2OLaVlSsj6gX46wV6DElMw698Q0INKr1kWudD9VKZLVxb4cfjZR15Gq38eThfv9+c8T/2x0XF4la26xQ9RWbks4NN/tSSXF8yN/Ljwo0AJzcEjQ2m83GeEUf8JpgBnwhIeFIZUHOckopo+6RHlioePCxQ28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUPC20TkzxeLcOWzcVHK3w4RcQJ7wco0Isz8w2oVMA8=;
 b=Bm94GMAXM8okabn9YmUFxeCG2jaRWPIvFq20a0jw7K3K+R7gyqr7BUJ3HPmHVajsfia90JauirxaPRzYWhoA6HNpFvX9PeuTTcIPqQnYmCArhjf/Mte+Leo7C81FCQ+0ffd5lUHYCsrRCsh8go6XWwXHwbvRiwB0k50vbnuhjdLRgQIkQl3bfDTzL2OGNaE1uEpFqQ7lnwMuqQULwCs2gZZ5vxWhGeapDuMjfjauZ2yz83XYaywm5ffBfc1Gn8lAqm/MnxoHtT5My2A5AoXXSst2bvHkKH3ZhCIr3DSe0IrcM9Z7PV5O/4MvR4/4ok15OG6gOxFlBICl9SH59WeDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUPC20TkzxeLcOWzcVHK3w4RcQJ7wco0Isz8w2oVMA8=;
 b=CtJDsT8r+oW37de9oXu1guFFa3rd/erP+xdVO6osMqe3YM0J4OCrgO3+Hc2PiauGVoAUXNaemrp9RWmeG4ZUKsetKd5ISjc/OnR8/KRrWQE5O7Kuu6FaHkk4JsSiYqArckMc7GsUVbiyBlmIckmejLRcCEakeoubghHH0g501/U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN4PR13MB5812.namprd13.prod.outlook.com (2603:10b6:806:21c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Tue, 30 Aug
 2022 23:15:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 23:15:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
Subject: Re: [PATCH] NFSv4.2: Update mode bits after ALLOCATE and DEALLOCATE
Thread-Topic: [PATCH] NFSv4.2: Update mode bits after ALLOCATE and DEALLOCATE
Thread-Index: AQHYvLNATqeT+9g1CUOMqtxpCJQAvq3IE0uA
Date:   Tue, 30 Aug 2022 23:15:10 +0000
Message-ID: <d15dba38fc8648447363eaa4bd731497eaac8334.camel@hammerspace.com>
References: <20220830205821.641180-1-anna@kernel.org>
In-Reply-To: <20220830205821.641180-1-anna@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0afee37a-cfde-44c8-db41-08da8add7c87
x-ms-traffictypediagnostic: SN4PR13MB5812:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMqvVPOeaZXrnlf454f/b8/P4YuFbCrVnQ7DILH+N767W/6HgzRjJgbHfcuYQdjjWpqOOkFwwfO1P14Unfu3lPwMiDM3ywRyitxmuCxPPXzOz4X0/3S9oK2CmuRNgwG8bOyDpx+JFad4luuP/aE/ThonYuDs+2QMzJ7RMM24BmKLgFvNSehs86r7jyRntMiYb+LqF7PPJLkTu8asj9otbmubzVSP96g2kAblZg0butt1QJ365VbJhdQKaAkgDQVnIc9lcNI+0E2wtfneqeM2IX59o1h8LOupmjkPgZT0Pe79neo36hNJDV0ZN+60Ekp5HKo4O1dCDIBc1I1i0T+iMa1bTdtlWryId4pdooRVfR5ahhF8J72hpswXM9ssBeM6jKSjURW0giP8ZARLzkZajOopoy/U6TgtGozFGUbVyoSnorKlADlcq6tCRd3N+DkyRmeCeiC7ZBrWnPp1iogy9GmEg47fWHNxG5ZqN82Jgh7U1+ozmXlh/Xm9VpssfRPfNH3+Gl3RX2MO0sCVDUH6ESfQ1gdq4fCGxtMBlPEGhqfFLqyQW76MYul0eZVhVy5JwGgDpUWVLazOD8pUIraPze094kl5UQoOuOiYUTxGrGHZCEwK525rrOK5KLCSrC7oMFHzDcPZ6yoo3vzihBSUGrSxybZ3++y1BUmDXByKQegKwDlTwXmx69rxiv0QYyd9aTBopIKLK1oYLK6wmpPl10Oipet8jCrK7PXU7Z9IJcA3ig/HLuPfR0IUoyo0oKh9MycOzlDOundgmohjc01na3etu4ULdT119+65HfwMvBM5tZDQtpqGtYHg3rcow/0p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39840400004)(366004)(396003)(346002)(376002)(15650500001)(110136005)(26005)(41300700001)(186003)(5660300002)(8936002)(36756003)(6506007)(2616005)(2906002)(6512007)(76116006)(8676002)(86362001)(38070700005)(4326008)(83380400001)(66556008)(66446008)(6486002)(316002)(478600001)(66476007)(122000001)(66946007)(64756008)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UStWZnNTL2Exc1ZkV3UzanFlSFpIampKeVlMYVVQdCtxanlKa2h5NmVWZ0U2?=
 =?utf-8?B?RHVyd2JXZnF1UFFWLzlKZEF3SDd1VHVPbzBlWHVSOERacm9XeURMNFZ0Y0Jw?=
 =?utf-8?B?RFFiZ1NRQURoa3h1MXFTaGJjNTZoWjYvUE1ab0c3SEUvdHowMHh3cXdmK2dC?=
 =?utf-8?B?QUVDQ0xvRDNlbXJLUngzZ1FmZ1BQWWNtdzdDd0xJMDA3dTNEZUtJU0w2d0x2?=
 =?utf-8?B?ZklFNzVBUHhMSFJ1WERCOXRMTm81azBTQkZ0QWZydmRVWlUvcDN0aUIvUWlT?=
 =?utf-8?B?K0p1bnVvZXA5OEtuRDZydUZSeDVIQUhDb2l4SWxYWEZyWUY5VHdYdHNROFNX?=
 =?utf-8?B?Sno3eEszTG51UE9ibXc0eDJhNndmNHJpcFFkMFJ3aVVyMmh5eG5PRG4ranVJ?=
 =?utf-8?B?Qit0S2JVTGZyWDFac3RVUm9hU3RaM3gyN3M0UGFiNjU5Rkk2VWlsOGdHYStu?=
 =?utf-8?B?SHBpU1FtejZTOVlXRlQ0MWlLSTlDZkJNMTZ3NklUM0NnV2FnRG5TNzYzSkRU?=
 =?utf-8?B?Tk1iY1c4WjBoZU1uRm96NVBCSFBoZms3R2hpNnEydnhWRTVrVzhuWmRwbGpl?=
 =?utf-8?B?QlNESHdrejBtaHBPL1JNVUhEcDJVWEdCaWF4RzQ5MGo0OUl1MVN4dGc2SUpK?=
 =?utf-8?B?WE4rUDdZVU5zSkZFK2h3bHl5YlUxZ2hZNENHL3gzaWk0TzhlUkQzT3FGTGxh?=
 =?utf-8?B?OU56M1VvQWJZSTdqWFN6NS9MNzdTQkJ6UzVQVDQyTWtWcVB0OStITERXTVpB?=
 =?utf-8?B?Wi9CNzJKeW1td2VIWHUrK1dMVVk5eVR6REJvK1RZbEo5M0tRdmM3RnkvZHZy?=
 =?utf-8?B?WkoyZlQyaGxXMHduQUJkUklzdHU2M0tSVnowajJCQ3BaN1BNc1B5UGlFcHB6?=
 =?utf-8?B?RjBEcWRqZFAyMTJ1RTd0T3dDUHJ1SHhhaWFqaUM4YSs0aDBKWjA1cmtzTVN2?=
 =?utf-8?B?K1htK290Qzh2RmNsVUdMd0hCVEFGRWp1NC82aU1CQWpNVlNiOVhROFFtTmtQ?=
 =?utf-8?B?ODRic0FTUmJIbk1qbkk0UXZRK1Z3YkpJYml6NjN6L0VOUS9FT1c0OHI1M1ZE?=
 =?utf-8?B?VDBHQmRLMUlNWExlNUVpUDJTcDd3ZnRpdkZlcFZqVWpjS0lwSXN1S05UaW1q?=
 =?utf-8?B?eWU0b29HZ1grei9pREJwS2xwZ0ZKeXRxRUorYlA1NHRkekN6bWRIT3VUdWZJ?=
 =?utf-8?B?by9QK0FzcXl6clJqYXN6Y29XOW1pQjNoaTVYOTdKTU5LMEJNTnVsbnU1OFRS?=
 =?utf-8?B?bVpWSnk1dGJDV2kza1phWkdZRkJ3MS9YTzEzZGJMNmhOMTdLN1RiL0NXTE0z?=
 =?utf-8?B?NTJGYmwzUUhWZGo4cVFaWHhxYVhZMlhnYmZzenJJekVSQzBaNVFkV3c5NHJP?=
 =?utf-8?B?bUt0NmgvTVpCQ0FiV0hzKzlTL2htcEQzUjB0UzFQdHZLZGczVDNnYzdXMHBK?=
 =?utf-8?B?d3JHZUJ6RUtLRFhTSzErV1RPM3c4OS9vM0dMRTNEZ1RGb0YyZnVrZU82Rkxu?=
 =?utf-8?B?Um1xbHJTUnBPcHlBVDlIdm14WTBSVU16QTVQZUlzejB5SDBFZm1FT2tPM0h5?=
 =?utf-8?B?c01QcVg1Sk9Gd056MTdHbFJTVmtxWE5nN1F1ZG8rcHc5cnh4cm83aHhMVENW?=
 =?utf-8?B?M3ZyUHUxQmtiQWIvYUFCQXdKdnpVTnpEaGNEcGZwVHhnbGg2bGowWmlsNWpJ?=
 =?utf-8?B?akZXNXU1RHY5MFpGTnRIdWVqR2k1UEM0UDJua1NtWERYR1RYRXlMYkcxaVBS?=
 =?utf-8?B?NDVrczU1YWlIVFhyZGNtOEJUNmM2eks2ZS8yL0ZSNkNHMVUrOVlyQTN6ZlNN?=
 =?utf-8?B?SW0xZTJNalFsZWFyL25YNHJFdnVKYUxyZXlFZzEvVTlrT0hqeUJxTE9JeDJ6?=
 =?utf-8?B?cGxKSG12ZEIwNnlKeXRMV1grUTZDbW9LVDM2RlY5M25pS2JORG90dm1YNisy?=
 =?utf-8?B?RDV6cGkyMDNMdWdGMFI4VnJ0ZGV3UHAxalhTNmNYaE9BY1FrRWJ6RmErNHZy?=
 =?utf-8?B?UFJLVUE0RXJRVUo2cWtuZWIrV29jSTRISEhaRGhUbTI2Q3ZtSHg5bEpEckZS?=
 =?utf-8?B?dUs3L2tlN3NWTEFGUGNNbXh2VkJySWRjdjg1THZ3Yi9obmh6bGUxTE9SYzFJ?=
 =?utf-8?B?RitNY2VYYjRzSzNmbitva3BnTUxGM0NtZ001RHgxMERtNGVEdDREWHBxa1E3?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E339B7F86D2CD84D9B0E1EF1C1137A9F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afee37a-cfde-44c8-db41-08da8add7c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 23:15:10.7561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCpLAfUn9fKgjikpzMXB45y9xddl9HKpBxBeYf9mUe5rG+AYSxWv7cMezo7Y6+SaPETJ1V1F4qGffYUAaXPiow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDE2OjU4IC0wNDAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToN
Cj4gRnJvbTogQW5uYSBTY2h1bWFrZXIgPEFubmEuU2NodW1ha2VyQE5ldGFwcC5jb20+DQo+IA0K
PiBUaGUgZmFsbG9jYXRlIGNhbGwgaW52YWxpZGF0ZXMgc3VpZCBhbmQgc2dpZCBiaXRzIGFzIHBh
cnQgb2Ygbm9ybWFsDQo+IG9wZXJhdGlvbi4gV2UgbmVlZCB0byBtYXJrIHRoZSBtb2RlIGJpdHMg
YXMgaW52YWxpZCB3aGVuIHVzaW5nDQo+IGZhbGxvY2F0ZQ0KPiBzbyB0aGVzZSB3aWxsIGJlIHVw
ZGF0ZWQgdGhlIG5leHQgdGltZSB0aGUgdXNlciBsb29rcyBhdCB0aGVtLg0KPiANCj4gVGhpcyBm
aXhlcyB4ZnN0ZXN0cyBnZW5lcmljLzY4MyBhbmQgZ2VuZXJpYy82ODQuDQo+IA0KPiBSZXBvcnRl
ZC1ieTogWXVlIEN1aSA8Y3VpeXVlLWZuc3RAZnVqaXRzdS5jb20+DQo+IEZpeGVzOiA5MTNlY2Ex
YWVhODcgKCJORlM6IEZhbGxvY2F0ZSBzaG91bGQgdXNlIHRoZQ0KPiBuZnM0X2ZhdHRyX2JpdG1h
cCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRh
cHAuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvbmZzNDJwcm9jLmMgfCAyICstDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzL25mczQycHJvYy5jIGIvZnMvbmZzL25mczQycHJvYy5jDQo+IGluZGV4IDA2OGM0
NWIzYmMxYS4uYTFiMjY0YjFhMDlmIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNDJwcm9jLmMN
Cj4gKysrIGIvZnMvbmZzL25mczQycHJvYy5jDQo+IEBAIC03MCw3ICs3MCw3IEBAIHN0YXRpYyBp
bnQgX25mczQyX3Byb2NfZmFsbG9jYXRlKHN0cnVjdCBycGNfbWVzc2FnZQ0KPiAqbXNnLCBzdHJ1
Y3QgZmlsZSAqZmlsZXAsDQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IMKgwqDCoMKgwqDC
oMKgwqBuZnM0X2JpdG1hc2tfc2V0KGJpdG1hc2ssIHNlcnZlci0+Y2FjaGVfY29uc2lzdGVuY3lf
Yml0bWFzaywNCj4gaW5vZGUsDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE5GU19JTk9fSU5WQUxJRF9CTE9DS1MpOw0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBORlNfSU5PX0lOVkFMSURfQkxPQ0tTIHwN
Cj4gTkZTX0lOT19JTlZBTElEX01PREUpOw0KDQpIbW0uLi4gQ291bGQgd2UgcGxlYXNlIHNldCBO
RlNfSU5PX0lOVkFMSURfTU9ERSBvbmx5IGluIHRoZSBjYXNlIHdoZXJlDQp3ZSBzZWUgdGhhdCBl
aXRoZXIgdGhlIFNfSVNVSUQgb3IgU19JU0dJRCBiaXRzIGFyZSBzZXQsIGp1c3QgbGlrZSB3ZSBk
bw0KaW4gbmZzX3dyaXRlYmFja19kb25lKCk/DQoNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoHJl
cy5mYWxsb2NfZmF0dHIgPSBuZnNfYWxsb2NfZmF0dHIoKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGlm
ICghcmVzLmZhbGxvY19mYXR0cikNCg0KTm90ZSBhbHNvIHRoYXQgeW91IHJlYWxseSBzaG91bGQg
KGNvbmRpdGlvbmFsbHkhKSBjYWxsDQpuZnNfc2V0X2NhY2hlX2ludmFsaWQoKSBhdCBzb21lIHBv
aW50IGJldHdlZW4gdGhlIFJQQyBjYWxsIGNvbXBsZXRpbmcsDQphbmQgdGhlIGNhbGwgdG8gbmZz
X3Bvc3Rfb3BfdXBkYXRlX2lub2RlX2ZvcmNlX3djYygpLCBqdXN0IGluIGNhc2UgdGhlDQpzZXJ2
ZXIgZmFpbHMgdG8gcmV0dXJuIHRoZSBhdHRyaWJ1dGVzLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
