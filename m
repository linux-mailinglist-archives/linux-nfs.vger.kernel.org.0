Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64690716646
	for <lists+linux-nfs@lfdr.de>; Tue, 30 May 2023 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjE3PKn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 May 2023 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjE3PKm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 May 2023 11:10:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2091.outbound.protection.outlook.com [40.107.93.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1409185
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 08:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrXJiCsIso1sfCkhX01iPYl4XRKrxaPXgF/N5CM/2kldh5yq2bIn7YzB6Mqbgr6eS9/QuSsrKexkhEReH+BtEPIMpZllb3u31mh/NBp3MHBeLvLa+o6NTM4lBTdORXkhrLfOViAaG18xmDOEewLUp6i4FRmuXiiqOKOvFEeqHoFYwMrzZRoi7Z1eoykoPVIbo8pQaTf4ViNZM/GncP+oNRKPCKtAUk6TGkiPCKItt2sddAaGrwHS9zvWAskv2wJzlbAjI2jVXq1zshlsjGj2fLcDbgtHk7NLlz0WmVQes4/PcEPOyG8ZqwzntcPHByQ1NBKJD1DPODz1WhIvOgXRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n9CzZgqRpVdq4WgSgVU6q9viDDDOpCmMvFc4HTmFeU=;
 b=OIBmOkmhsFji7VACU+3fg521fy4juxo4MYs0sVHUuadk6ufXN4pjq7/ZF899+KYulFJxw4Fm7IeZpEfwhPzUQuYlGSf+I1IARiw1yjr/2RkO72xwKfnPNvYternu1jKAA2GmyOZ6zaqSK5Bxds5SdSV3ANgYsbJgDoeTpYJnVQfJpjWqPbLlGRHp6ShwrFaDsjvb0WNpOiUJOxtd+xsKdpd0fx/77p3OjfsR/KbghCVeFSAvNZtNJzqqATeKKtO5BbzqrvjdR+k4BWtUR74sqCN0AQEM3My5lK8NzgCGrpkfKcDVa9bXdXgYpGF8hO3M1ss50XrJj5OJSv6AsmfEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n9CzZgqRpVdq4WgSgVU6q9viDDDOpCmMvFc4HTmFeU=;
 b=Gk3pwF85Q/zXa8byElS0jkttN6Oz+WbyW2agHWEyBRo2NLGOaci40ZBlrK6s+XWr9xKFa6msYzSd7V7WqyTZY7qgqK0zSNbimF14FfTQ3PFnJZUw8Aalp8ZGOk8V+YkGKfjDK1fhbLzF26CbNGKfrdA8q496HTxBWDEej24tk40=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5714.namprd13.prod.outlook.com (2603:10b6:510:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 15:10:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88e3:f301:d677:4f33]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88e3:f301:d677:4f33%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:10:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "cel@kernel.org" <cel@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 07/11] SUNRPC: Add a connect worker function for TLS
Thread-Topic: [PATCH v3 07/11] SUNRPC: Add a connect worker function for TLS
Thread-Index: AQHZkwAz5p89tbA6okeUn7rpvUipMK9y666A
Date:   Tue, 30 May 2023 15:10:19 +0000
Message-ID: <d9f3c0ef1fe52a6798d5e9da31adb11dca1a6fcc.camel@hammerspace.com>
References: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
         <168545567896.1917.14080628021266912546.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168545567896.1917.14080628021266912546.stgit@oracle-102.nfsv4bat.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5714:EE_
x-ms-office365-filtering-correlation-id: 713e005c-03d5-480a-2f64-08db611ffb8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67uQtVRdyiQioQkX+So/Eb/N59lGSWxye66aiJnHhgaO6Qw5lSCElUqnb05we21HXGd9Kv5LVPslU27Ww8OSQpomIGAmDrkMLBW0dUvdM6fY9/zxKaWEkfRKrV+QVNBO67ClLGrYGQVcoxZ/mqxWWNrZugQQiXCaOnrWw1opE7FB8r9QkdJcnaCZyr8PUqQaLugTYWOrQp7duHx6Ge5DVdFA5VFuhwpgyFZTLTbgDTMiSkuOOE73ymTieEWqPi4EztySOjat7H1rh0CRjuBEXUfMdOA/WVZOj5gt7eCY6TLUnGnUwavxRFcSTzhI5QZvg0rZXOWOVBfBDaX7S+BN8sd1R/PUqTUy35L/Y8I9oHmtEp3F7exzzvCm4GMHILUZkxL7ZtnIEfbfV/RiEWcadt4PxXnyCrWeHoy3PN28BR9tZxG83mnhCXoLDgattgVLSppiD9dMWJlnVB2Pu91Wq37iba6Bq7ih8AD5+L8g/lCIcuLSTTjOi5F39LSS7k9nDztrACv3kz0CJQywfBbyp5kXUGEoH/XMOJirtf0uKJgnSJFb7Nx812EK261uI5aWV09+AHMW3co/taLE7VyOSMOK42SToNEITxl9KWFDGMSZ8m/Z3wwLxeKIRB016ffDxJ8Muq14HlyEb8KBKaGtT8zs6DaOyg4EhlUo6vO4d9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39840400004)(451199021)(83380400001)(2616005)(2906002)(186003)(38070700005)(36756003)(38100700002)(122000001)(41300700001)(316002)(71200400001)(6486002)(5660300002)(86362001)(8676002)(8936002)(478600001)(54906003)(110136005)(66556008)(66446008)(64756008)(76116006)(66476007)(66946007)(4326008)(26005)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M25UMkhoam9DWmhSOTFVV0FHWGIyZWFWMFpuYnRBdjhBQlN2SXE5UFdNUjND?=
 =?utf-8?B?NG5EZjlYbUNXYmx4cUNlWmxVUVpUViswMFdTQmFUOVdUN2R1UWF1RHdIVXV5?=
 =?utf-8?B?WDRkTEFMUXpEQmJkcGJOd05TZDBiRGhsU2dHNTNvMThOM2J4RmFlcnlMOEN4?=
 =?utf-8?B?UFBONnRqenFTdkdXVHdnaFc2RUw1MktsTnRud0RvVXVzRnk1Q3V3aFBsMTdl?=
 =?utf-8?B?L0V0QjRGNENwWFlsYVJuU1dKNk94Sm1ZYXBDbUNCL2xtMXRGYVVLNnpNYVdG?=
 =?utf-8?B?WVNXOEVnZmU1aDVva1dFa1JlYUtNNERRc3JocHlxSVprUGdhU3dXSndsMEhK?=
 =?utf-8?B?WVZTQUtFd2RwMXYxYjA1YU5iMVkzL2MyTWRtSzdPclN3SmZVTnlJY0NhVjBE?=
 =?utf-8?B?YjhnT2FJdkdLdWQxcFNQSkJrSmNUV2JtU00zcFJRa2hxQUxqcENvZXhObWZB?=
 =?utf-8?B?V0RaWU5aNVFhT1NMZ08vZzgrNnM1YmQ2SzFSdDJxOEJTaXJGaUpZanE3dERQ?=
 =?utf-8?B?SmdHMys2ejNYVS9QaUVtRDZPaGJ6OExuOHRvaDEvdk1sQkpWYUpCSmhlN2Rq?=
 =?utf-8?B?OHhEOHRjekwxNmtDU0dJY2ducE90Y2E0YzNPSUtiWW9lTzBTSEZnSzVoblRO?=
 =?utf-8?B?TDlwbjJRWUo4M1cyT2ZnRVVSeWIyc2tqZnBvdW5HMzhCa2ZsMFN6TEJHVWND?=
 =?utf-8?B?V1pYNmZNRzVYUmJXQzA5d3NycnFkVnVxaW1EQUtvZzdHNDVwd2E1eDhhSEFC?=
 =?utf-8?B?SU1NS3lQQkN4M2VEMGdSaithdGRjMmdRVFIzc0Ivc3FGbmpEaVN3NW01NHI1?=
 =?utf-8?B?Z3dBd3JzN3c4d05TMm1mRC9EbHZ2aEJ0Sk90QytIQU9qL04yYmlRTTA1WHdP?=
 =?utf-8?B?Z3lGQm8yQkRsdCtCc2FLTVdNSjZCZlhlMHhOcnVPaVQ0c2VIVkttR2NDV1N1?=
 =?utf-8?B?ckErV3pxK2hrcFJGQjFHSmJVNm1IVWpheHc3NGpQSWJyRFczZkkrdVRWK1R5?=
 =?utf-8?B?OSsxS3BSTHFZOCtEYWdPQWc2ckRYbTk0aFlGN0JjZUV5T1V5enBTM2ZwelR4?=
 =?utf-8?B?SW0rTWEydjR5cDVvanpteHdZRVJnOUVvWmlsWjBVREVNdnBRaUhLblpUZ2du?=
 =?utf-8?B?WkZIVmRic2ZKbHV2WElRTW1SbS82YXZZUGhscmozZmJ3YnI4Qm40SUlpKzZk?=
 =?utf-8?B?eTV1Q3l2MmlPY24rM1dWTXBkb1VTakYvRmIxWElyclFja1pLVzYyVkplUmJy?=
 =?utf-8?B?VFpLS0ZLYkdNT2F3Zko2ZDBlb1RrNytZSXhUOVo4MEo3N3h2c1RmellRRkRr?=
 =?utf-8?B?WDR6VERobzhvRUkxeFFDY1dRRFVxVlVsWDFmYXdOTHN5RU9leUNzZUowbkVl?=
 =?utf-8?B?cmp2TlBYV0JTejM5VjR0Q01TeTNvTDd4VGNlZk1xVHRHaC9wcEZLTGVkRCtF?=
 =?utf-8?B?T21HWjM5c0FwYWJCRUs5eWNjb2dTZGhhYlBFMzFSRFBzb3c4UmVJNXN6MXFV?=
 =?utf-8?B?RDh4a0R6RzUrVm1ZWXN0bEZ1M3JzcGNwbmNzU3M4ZTUzdkRDSjU5VWlyaGM5?=
 =?utf-8?B?ZzJJRzhnaElGSTVXNVArV2RmS2VIWmJGeGdGMjZSazR4VEorMThnSXlXNER1?=
 =?utf-8?B?aC83UkZ2L2tLZTlqbHNXd1lMa28xVkNlaEw4cDBoV0JEZmVTaC9XSDJ6OHdn?=
 =?utf-8?B?aWJNc0ptdi9MUDJrWmpXTjVCTGhWM1EyamNlWkRxSjhRVWxIZEt6YlZPZzFy?=
 =?utf-8?B?UFhvcmM4Yk5IRzFTb2hPNXFtd2FiZWh2RDU1bHZaSDJ1N2xtZUROeFo5angw?=
 =?utf-8?B?WEh4Ykp3Z2xkMjNHaHIxNzl0WTltc2pURlpCa05WTHpSaVVVUEh3Wk9UZFBW?=
 =?utf-8?B?OHNYT2F5MWlkdUt3R1hCNjhEV0ZPRlF5ejRleDFOU200QUtVa2luUFhjRWFL?=
 =?utf-8?B?WFFyRFlMVUNJUmdiRE5SN0VBQmRCSVB0Vm11Q09wem9JRG1XZ1BJKzNJS1pN?=
 =?utf-8?B?VmtLalR3NTNQY25odllJZlRwRmRpclpINWdOMzdhWEd5R2xFd2NkR1I0NEs1?=
 =?utf-8?B?QTh2ODdYaTNSaWVaWGVWMElDVlVKR2ZVUGJ6VUdZZVNNa1hzSHRrL3dibEFt?=
 =?utf-8?B?eERLT0t1a2NlalZYZzZEK0d5TStibUgrRnR1Wm5OVmVuTVNYYjJuRWI5b3dS?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2BCD873760030409DF8F286C7203911@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713e005c-03d5-480a-2f64-08db611ffb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 15:10:19.4934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOXjlsy69AiNP+BcBaydh0B8yVwmGYAD7asPmb1FdK0/6XrwtZciG+RkszTQiC5Qu5i45m3vsA0PTQgeTy+W3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTMwIGF0IDEwOjA4IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToKPiBG
cm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4KPiAKPiBJbnRyb2R1Y2Ug
YSBjb25uZWN0IHdvcmtlciBmdW5jdGlvbiB0aGF0IHdpbGwgaGFuZGxlIHRoZSBBVVRIX1RMUwo+
IHByb2JlIGFuZCBUTFMgaGFuZHNoYWtlLCBvbmNlIGEgVENQIGNvbm5lY3Rpb24gaXMgZXN0YWJs
aXNoZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+Cj4g
LS0tCj4gwqBpbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0c29jay5oIHzCoMKgwqAgMSArCj4gwqBu
ZXQvc3VucnBjL3hwcnRzb2NrLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA3MAo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA3
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvc3VucnBjL3hwcnRzb2NrLmgKPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnRzb2Nr
LmgKPiBpbmRleCBkYWVmMDMwZjQ4NDguLjU3NGE2YTUzOTFiYSAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3N1bnJwYy94cHJ0c29jay5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9zdW5ycGMv
eHBydHNvY2suaAo+IEBAIC02MCw2ICs2MCw3IEBAIHN0cnVjdCBzb2NrX3hwcnQgewo+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZcKgc3JjYWRkcjsKPiDCoMKgwqDCoMKg
wqDCoMKgdW5zaWduZWQgc2hvcnTCoMKgwqDCoMKgwqDCoMKgwqDCoHNyY3BvcnQ7Cj4gwqDCoMKg
wqDCoMKgwqDCoGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhw
cnRfZXJyOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNfY2xudMKgwqDCoMKgwqDCoMKgwqDC
oCpjbG50Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qCj4gwqDCoMKgwqDCoMKgwqDCoCAqIFVE
UCBzb2NrZXQgYnVmZmVyIHNpemUgcGFyYW1ldGVycwo+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBj
L3hwcnRzb2NrLmMgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMKPiBpbmRleCA2ZjJmYzg2M2I0N2Uu
LjdlYTU5ODRhNTJhMyAxMDA2NDQKPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMKPiArKysg
Yi9uZXQvc3VucnBjL3hwcnRzb2NrLmMKPiBAQCAtMjQxMSw2ICsyNDExLDYyIEBAIHN0YXRpYyB2
b2lkIHhzX3RjcF9zZXR1cF9zb2NrZXQoc3RydWN0Cj4gd29ya19zdHJ1Y3QgKndvcmspCj4gwqDC
oMKgwqDCoMKgwqDCoGN1cnJlbnRfcmVzdG9yZV9mbGFncyhwZmxhZ3MsIFBGX01FTUFMTE9DKTsK
PiDCoH0KPiDCoAo+ICsvKioKPiArICogeHNfdGxzX2Nvbm5lY3QgLSBlc3RhYmxpc2ggYSBUTFMg
c2Vzc2lvbiBvbiBhIHNvY2tldAo+ICsgKiBAd29yazogcXVldWVkIHdvcmsgaXRlbQo+ICsgKgo+
ICsgKi8KPiArc3RhdGljIHZvaWQgeHNfdGxzX2Nvbm5lY3Qoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHNvY2tfeHBydCAqdHJhbnNwb3J0ID0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGFpbmVyX29mKHdvcmssIHN0cnVj
dCBzb2NrX3hwcnQsCj4gY29ubmVjdF93b3JrZXIud29yayk7Cj4gK8KgwqDCoMKgwqDCoMKgc3Ry
dWN0IHJwY19jbG50ICpjbG50Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBjbG50ID0gdHJhbnNwb3J0
LT5jbG50Owo+ICvCoMKgwqDCoMKgwqDCoHRyYW5zcG9ydC0+Y2xudCA9IE5VTEw7Cj4gK8KgwqDC
oMKgwqDCoMKgaWYgKElTX0VSUihjbG50KSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBvdXRfdW5sb2NrOwo+ICsKPiArwqDCoMKgwqDCoMKgwqB4c190Y3Bfc2V0dXBfc29j
a2V0KHdvcmspOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBycGNfc2h1dGRvd25fY2xpZW50KGNsbnQp
Owo+ICsKPiArb3V0X3VubG9jazoKPiArwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gK30KPiArCj4g
K3N0YXRpYyB2b2lkIHhzX3NldF90cmFuc3BvcnRfY2xudChzdHJ1Y3QgcnBjX2NsbnQgKmNsbnQs
IHN0cnVjdAo+IHJwY194cHJ0ICp4cHJ0KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHNv
Y2tfeHBydCAqdHJhbnNwb3J0ID0gY29udGFpbmVyX29mKHhwcnQsIHN0cnVjdAo+IHNvY2tfeHBy
dCwgeHBydCk7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJwY19jcmVhdGVfYXJncyBhcmdzID0g
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmV0wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgPSB4cHJ0LT54cHJ0X25ldCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LnByb3RvY29swqDCoMKgwqDCoMKgwqA9IHhwcnQtPnByb3QsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5hZGRyZXNzwqDCoMKgwqDCoMKgwqDCoD0gKHN0cnVjdCBzb2NrYWRkciAq
KSZ4cHJ0LT5hZGRyLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWRkcnNpemXC
oMKgwqDCoMKgwqDCoD0geHBydC0+YWRkcmxlbiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLnRpbWVvdXTCoMKgwqDCoMKgwqDCoMKgPSBjbG50LT5jbF90aW1lb3V0LAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc2VydmVybmFtZcKgwqDCoMKgwqA9IHhwcnQtPnNl
cnZlcm5hbWUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5ub2RlbmFtZcKgwqDC
oMKgwqDCoMKgPSBjbG50LT5jbF9ub2RlbmFtZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLnByb2dyYW3CoMKgwqDCoMKgwqDCoMKgPSBjbG50LT5jbF9wcm9ncmFtLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucHJvZ251bWJlcsKgwqDCoMKgwqA9IGNsbnQtPmNs
X3Byb2csCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC52ZXJzaW9uwqDCoMKgwqDC
oMKgwqDCoD0gY2xudC0+Y2xfdmVycywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LmF1dGhmbGF2b3LCoMKgwqDCoMKgPSBSUENfQVVUSF9UTFMsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5jcmVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gY2xudC0+Y2xfY3JlZCwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnhwcnRzZWPCoMKgwqDCoMKgwqDCoMKg
PSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucG9s
aWN5wqDCoMKgwqDCoMKgwqDCoMKgPSBSUENfWFBSVFNFQ19OT05FLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZmxh
Z3PCoMKgwqDCoMKgwqDCoMKgwqDCoD0gUlBDX0NMTlRfQ1JFQVRFX05PUElORywKPiArwqDCoMKg
wqDCoMKgwqB9Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKHhwcnQtPnhwcnRzZWMucG9s
aWN5KSB7Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSBSUENfWFBSVFNFQ19UTFNfQU5PTjoKPiArwqDC
oMKgwqDCoMKgwqBjYXNlIFJQQ19YUFJUU0VDX1RMU19YNTA5Ogo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB0cmFuc3BvcnQtPmNsbnQgPSBycGNfY3JlYXRlKCZhcmdzKTsKCk5BQ0su
IHJwY2lvZCBzaG91bGQgbm90IGJlIGNhbGxpbmcgcnBjX2NyZWF0ZSgpLiBXaHkgY2FuJ3QgeW91
IHByZS0KY3JlYXRlIHRoaXMgY2xpZW50IGF0IHNldHVwIHRpbWU/Cgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0Ogo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0cmFuc3BvcnQtPmNsbnQgPSBFUlJfUFRSKC1FTk9U
Q09OTik7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICt9Cj4gKwo+IMKgLyoqCj4gwqAgKiB4c19jb25u
ZWN0IC0gY29ubmVjdCBhIHNvY2tldCB0byBhIHJlbW90ZSBlbmRwb2ludAo+IMKgICogQHhwcnQ6
IHBvaW50ZXIgdG8gdHJhbnNwb3J0IHN0cnVjdHVyZQo+IEBAIC0yNDQyLDYgKzI0OTgsOCBAQCBz
dGF0aWMgdm9pZCB4c19jb25uZWN0KHN0cnVjdCBycGNfeHBydCAqeHBydCwKPiBzdHJ1Y3QgcnBj
X3Rhc2sgKnRhc2spCj4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZHByaW50aygiUlBDOsKgwqDCoMKgwqDCoCB4c19jb25uZWN0IHNjaGVk
dWxlZCB4cHJ0ICVwXG4iLAo+IHhwcnQpOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgeHNfc2V0X3Ry
YW5zcG9ydF9jbG50KHRhc2stPnRrX2NsaWVudCwgeHBydCk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKg
wqBxdWV1ZV9kZWxheWVkX3dvcmsoeHBydGlvZF93b3JrcXVldWUsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJnRyYW5zcG9ydC0+Y29ubmVjdF93b3Jr
ZXIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVs
YXkpOwo+IEBAIC0zMDU3LDcgKzMxMTUsMTcgQEAgc3RhdGljIHN0cnVjdCBycGNfeHBydCAqeHNf
c2V0dXBfdGNwKHN0cnVjdAo+IHhwcnRfY3JlYXRlICphcmdzKQo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoElOSVRfV09SSygmdHJhbnNwb3J0LT5yZWN2X3dvcmtlciwKPiB4c19zdHJlYW1fZGF0YV9y
ZWNlaXZlX3dvcmtmbik7Cj4gwqDCoMKgwqDCoMKgwqDCoElOSVRfV09SSygmdHJhbnNwb3J0LT5l
cnJvcl93b3JrZXIsIHhzX2Vycm9yX2hhbmRsZSk7Cj4gLcKgwqDCoMKgwqDCoMKgSU5JVF9ERUxB
WUVEX1dPUksoJnRyYW5zcG9ydC0+Y29ubmVjdF93b3JrZXIsCj4geHNfdGNwX3NldHVwX3NvY2tl
dCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHhwcnQtPnhwcnRzZWMgPSBhcmdzLT54cHJ0c2VjOwo+
ICvCoMKgwqDCoMKgwqDCoHN3aXRjaCAoYXJncy0+eHBydHNlYy5wb2xpY3kpIHsKPiArwqDCoMKg
wqDCoMKgwqBjYXNlIFJQQ19YUFJUU0VDX05PTkU6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoElOSVRfREVMQVlFRF9XT1JLKCZ0cmFuc3BvcnQtPmNvbm5lY3Rfd29ya2VyLAo+IHhz
X3RjcF9zZXR1cF9zb2NrZXQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVh
azsKPiArwqDCoMKgwqDCoMKgwqBjYXNlIFJQQ19YUFJUU0VDX1RMU19BTk9OOgo+ICvCoMKgwqDC
oMKgwqDCoGNhc2UgUlBDX1hQUlRTRUNfVExTX1g1MDk6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoElOSVRfREVMQVlFRF9XT1JLKCZ0cmFuc3BvcnQtPmNvbm5lY3Rfd29ya2VyLAo+
IHhzX3Rsc19jb25uZWN0KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7
Cj4gK8KgwqDCoMKgwqDCoMKgfQoKVGhlIHBhdGNoIHNlcmllcyBzZWVtcyB0byBiZSBhY2N1bXVs
YXRpbmcgYWxsIHRoZXNlIGlkZW50aWNhbCBzd2l0Y2gKc3RhdGVtZW50cyBpbiB0aGUgVENQIGNh
bGxiYWNrcy4gSW5zdGVhZCBvZiB3aGl0dGxpbmcgYXdheSBhdCB0aGUgVENQCnRyYW5zcG9ydCwg
d2h5IHNob3VsZG4ndCB3ZSBqdXN0IGRlZmluZSBUTFMvVENQIHRoaXMgYXMgaXRzIG93bgp0cmFu
c3BvcnQgY2xhc3Mgd2l0aCBpdHMgb3duICdzdHJ1Y3QgeHBydF9jbGFzcycgYW5kIGl0cyBvd24g
c2V0IG9mCnN0cnVjdCBycGNfeHBydF9vcHM/Cgo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHN3aXRj
aCAoYWRkci0+c2FfZmFtaWx5KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgQUZfSU5FVDoKPiAK
PiAKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
