Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A983C78757D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbjHXQfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbjHXQfC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 12:35:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D687E6A
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 09:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMvDGsk8CFaY3BC5nBwQj3b13GYj5rjrQieMygDAjuRAjj2+/sLk2Irr+1KjbwVWtMToksuvtY074YFSBG3fz/tyohQDwri0s2fGNs2cnOGc/Ewr+jsXYpwvE2bTm7yJPnowHCZhI13jUIpWrqem+HWshsRUH1BSV+/1Xoe6z1JM0Z2F7XPOzt7+xSeby4AQtKOnRtp3XvJ95jpemKX7w2WBCCHnnxSBMdepZ4t9sLKs/gXtZXqH5EyTzAaC+iRS6XGBhucU9FZIyA0YAMm0BVYAv7Q3WPjt29BjrOJdnWER1GbgPJK3XPiX0dFgnWKXq8ZAiLqFf04VxRRupCEhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mozXlNwicGMjBi0JKvaNvzv4BD2r7FDfvJny/IA4xY=;
 b=i0lCsy9WakfUerP5kaEyYRTmhALClxcjjMy+PvYmcUL78uSx7TCtjA+ydXrWgkR3t0GLFCnbJmzCRZuWwJlEItCdkXKKMBr83gf+0r/8ynpKVx/gVnAOYEuDaRLO1/SmflTqiQco50PA8XXGVbMgZXrjRUp1CzNnxgV/dv1f78ys9ksGXrza8iXX89RHEX59jtLzsDKssVq8/zlTTs/drClhlEMzBd/eIeDTj04xlURAsujFt6V03rJngynenMmuMfMI4yavwPlh3lUwVhZVpt/2+jAFSeG38PUpYHzeHc702AWidOQA9YND9j3zxuPPq+8IxR/LrbgEy/ykpbVkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mozXlNwicGMjBi0JKvaNvzv4BD2r7FDfvJny/IA4xY=;
 b=QRHKTiFA8X5m+AE//y3p2yONFoFZLfsU0KVMJInhJqaWPV1F7DzdDNgCN41npzOcuP5SH/CtpEDbWQG2nvwDEuImwGB4UArOiIxS595f6iEb9byg6DZ8v44sqzsxmkwDIxMeiMqXIBU9roTd2+w2aLqyzvfTSN4LbAukjwnr2Lg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN7PR13MB6131.namprd13.prod.outlook.com (2603:10b6:806:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Thu, 24 Aug
 2023 16:34:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:34:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Topic: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Index: AQHZ1qM5a8kJqkV85kS+OyPQjyhCTK/5m0iAgAAC7gCAAAZYAA==
Date:   Thu, 24 Aug 2023 16:34:57 +0000
Message-ID: <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
         <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
         <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
In-Reply-To: <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN7PR13MB6131:EE_
x-ms-office365-filtering-correlation-id: 1182ed82-8c99-418d-4b40-08dba4c00ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xr4D+VzwmE3/Je/yGBLxggyro0L2icrtOvISQwwnm1p+ootgRT9O7FDMCxSJP/K0cOiwJSa7kL20VdAFp/Efi3h/Dnsv8OHMT2ybFd4EhnPEH1oWWnhN5F/Hr+96tGZi1qm+6C/HkdB7/A00CGqNtCMnkvV7wnPAs9UC62WKk2Ug6PNhFCdIgLhy6UpLQClGLe/Kn7MsBoaVtou7mfj6LFFQI0V2Gem8r8019yW//assM+jULQQeT2f4mCHtKO7d1Y4fnlUbdtsMJWkeFbabzKQF+A5/A7j+DUat5xfx/1M1zAEL08/E4+Sy+y+r3nYW/DhRxqxH218jGy+2I8vAaWhW0NMQ21m0ToqLpeDn6mW2t+aqKkHLXhM+pSsHS1GyeMVmKJaX4+uBax2Cvs33B4RAIuh4yJQKChK77qc1Ge1CCMUrzGqHz3yM99XsnrbIekasE8beEvy6lL10cMUedxbW5V53rNDfwX/WgHniFMTrVtuxWEyMmj9So2CO55m6UeVSYAIlGkrm6uPRnBUc3d/VZhNT3MNpTcK5iTFkyfPCy6M7zrspV4i1fUOLw/0HerNl9TCrJDBhRdNseRHT7QXKeodExt+itqpdOCwW+x+Dw5YjAwRgvdtLRkWNZrNpylXKZPlFXS4qoGyG6IwqhsIBmpbpuWv5OSHnVRdYuibAn3NjC0CFm8WuFwxKVxPc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39850400004)(396003)(186009)(451199024)(1800799009)(2616005)(8936002)(53546011)(8676002)(4326008)(478600001)(5660300002)(38100700002)(86362001)(38070700005)(122000001)(6512007)(26005)(6486002)(71200400001)(6506007)(41300700001)(83380400001)(64756008)(66476007)(15650500001)(316002)(36756003)(66446008)(76116006)(110136005)(2906002)(66946007)(66556008)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emV5RFJoSEx6YU41WDF1Q3VsT1k3Q3ZGNmJnbGJ0V2k4SnZGOEl1N09qSVF5?=
 =?utf-8?B?QXRwdnc5RTRBT0RSdWRQaXo5YzdsRVBNdFJYSEFCWmEzeEFGZ21udVFmTlpC?=
 =?utf-8?B?YlcvYXdwZENFUVp2ZEdsdFZBbUVEd1U2T0QrUkYrcGJKd1JRWWxxejRpcUZl?=
 =?utf-8?B?dzZCOXhPY1l3b1l2blhicjcxTnNsMDRzNWdSNlY4YnpUbUllSjZXbzhvU1gx?=
 =?utf-8?B?NFRKQnpKaUVpUnpOL2JQaFh4Q0hPeWFRTGpCRVRuNnFwemtjN3NvQkhmUzhK?=
 =?utf-8?B?bG1Bd3JodVQ5a1YwQjMzeHJQMnZrTzYwUFhTZmUwWjhqOWE4ZmQ1NllGTm5M?=
 =?utf-8?B?UDZrbDhtazFHU05KTlpOQm9mL1Q2NFFvTTFlK3hNTmh3bXd4emVpbzRwK0xn?=
 =?utf-8?B?U1FpUG9nTStaOGczZ2IzMUZjSDVwUHZxZ09SMEVzbUhRamxYdVAvOTJ1U3dK?=
 =?utf-8?B?TlNHSkVtdFdUckd2VmZEZWh0WGlzS0dNMnIzOVJ4aDFmVUxidG42aHNRbHZP?=
 =?utf-8?B?VURsMVNvTDZERlJreEplbFFpYVk5MTNZTjlIVTRTVTE3cW5VQjFxWWhXblVh?=
 =?utf-8?B?Q2RSd1hOQmJPM2hCSEo4WUprMWw1aExGVi9mWkZjRk9FY0NabjdIOUovNGQy?=
 =?utf-8?B?WWhFZy9PZDhtdDBuSUJDWWMvSjRZVDJXTHprVmFDR2lTSzJPLzRaWXpLbmgv?=
 =?utf-8?B?UmhNZFBiaGg5N01ueWNvMmlwd2lWcFVsYVJ5aTNsTzVxQ0NqeGVlV1g3dnRN?=
 =?utf-8?B?cnNrUGVSN09rZFFsUWlkRGc0VUR1MG5XU25oTGtOQmo3WnpuMm1mZ0RSUGZN?=
 =?utf-8?B?REZDK0ZJTHVxblZoUEgyTEJqWWZpdTFwcVduT3dBb1FkWmFHaXlyTTVXWVpI?=
 =?utf-8?B?NHFHYzc3VlpPY2lvcTJtbnUrTkM1Ky9BSVhaSmpkblUxSFZTQ21Vdk1kTHhO?=
 =?utf-8?B?ZWNYTkVFR280QmRkTWoxUjVqKzA3S2M3cWJhVjlRNVBHQ1haWDNiRWIrTGUy?=
 =?utf-8?B?SlJ2bW5yd2M3Wm1CREp0R1dCMHZEblNFcGU1OXh5WVg4VklrYWhQUnBkZ3Ex?=
 =?utf-8?B?djNLZytVY3ZnTXk1cVJCeUZoQm1OS1BRRHZxUjVvNlA2OFlZSnNOc3lTZGtu?=
 =?utf-8?B?T3dDdnp5TkRnYm1qKzdLc3hIQ0FFRVk2UWJOeGR0ZE9mUW16TWhIWkNIOXJ2?=
 =?utf-8?B?SGM4NTA5RkczTkJuRTZrV3RTazJmZC9wTFRWN0xYRnFSZ3o4dm16MjJOb09O?=
 =?utf-8?B?cjIvbHNUS2QxV2ZXbGwyU1ZKTU5BTjlqamhYT0lMMFllMEhseTN2bUt5QktM?=
 =?utf-8?B?aTgwODEweDN1bTFWeFVTaFVXa1U1eGozZndja1FmK1RyNElkbkNtTzAxTHZt?=
 =?utf-8?B?NDdSSm4wcStZVGtoZ0xPbVZVR011YWV1d0lDUFVGUGtxQ0hPelMxWlFPSzdC?=
 =?utf-8?B?SFZOdk5MTGFXeDRUZE81M2xYdEpzaFZkd2xSK1h1OTR0Y2VnTUNDNzg0RUpO?=
 =?utf-8?B?RFM0dlhSbDhzOGdXcFBWV281T3B1NlhtY09ZekdzWFAyVVJCc3hOMzNONlEx?=
 =?utf-8?B?dVZQeTVNTTIwcWZpdGhkMTg2MWl5L1FZNWs4S3o5RHNsQytKUE1GR1hVaVlZ?=
 =?utf-8?B?ZklEYjBWcEM4UGFQMGZXUERrdWpsZXBLZ21uU2Z5S1FqVGlNT3VtSTJqZzlB?=
 =?utf-8?B?SGQ5NzhZUURzdmp2YnBZV3UycjBHeXpHZ3pOdEJnSE4vdHlJcURiOFlndS8r?=
 =?utf-8?B?T0VyUmVxZFhwWDVFeXAvWHJMY29VaTF0WG41UGY5NEoxTm5RZU90QnBwUFlP?=
 =?utf-8?B?UzFpbStWWUFxbVFEdXpxOEdOQVE0UmJIRFpIK1dSV0JOKzFZRk0zNUR4UkZk?=
 =?utf-8?B?c0ZUUWhDUVYybXVRd2xYZUE2emNQRjRlUGRyUEFpZndTczdiRU9hQUkxUzRF?=
 =?utf-8?B?anRjcE9RbFVRSjNMOGVwMDlIMTltRG5wY09XM3VCVFc5L2l6bStKaHNidUd5?=
 =?utf-8?B?bTR4a0cwemJOaEpVdkN3VmEzNHlVaUhkQmU3Rmk1dFVDZDk4TTUwb0xuRXRG?=
 =?utf-8?B?eHU1YW5ZbDJubTkvcHBaMzNPb2dKenlmcGEyL3JqREJLWENxUkgyU2Zib1Vr?=
 =?utf-8?B?cXh3VnlBcS9MdnI5S2tadTdWYUYzRWtYNWh0dWRDSmQyU3M0ajdJNUxMcXhW?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AD43CD557612A4581E80D06E1E12CAD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1182ed82-8c99-418d-4b40-08dba4c00ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 16:34:57.6102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8ylIyx9Mgl+vcdetmQD2Hz7Pa2qf1PiE8BXWWOMZo0paaWAMTDetAIb6nT+YbmOCudRE+F+CYkVNCfUnTlvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDA5OjEyIC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6Cj4gCj4gT24gOC8yNC8yMyA5OjAxIEFNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6Cj4gPiBP
biBUaHUsIDIwMjMtMDgtMjQgYXQgMDg6NTMgLTA3MDAsIERhaSBOZ28gd3JvdGU6Cj4gPiA+IFRo
ZSBMaW51eCBORlMgc2VydmVyIHN0cmlwcyB0aGUgU1VJRCBhbmQgU0dJRCBmcm9tIHRoZSBmaWxl
IG1vZGUKPiA+ID4gb24gQUxMT0NBVEUgb3AuIFRoZSBHRVRBVFRSIG9wIGluIHRoZSBBTExPQ0FU
RSBjb21wb3VuZCBuZWVkcyB0bwo+ID4gPiByZXF1ZXN0IHRoZSBmaWxlIG1vZGUgZnJvbSB0aGUg
c2VydmVyIHRvIHVwZGF0ZSBpdHMgZmlsZSBtb2RlIGluCj4gPiA+IGNhc2UgdGhlIFNVSUQvU0dV
SSBiaXQgd2VyZSBzdHJpcHBlZC4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhaSBOZ28g
PGRhaS5uZ29Ab3JhY2xlLmNvbT4KPiA+ID4gLS0tCj4gPiA+IMKgwqBmcy9uZnMvbmZzNDJwcm9j
LmMgfCAyICstCj4gPiA+IMKgwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNDJwcm9jLmMgYi9m
cy9uZnMvbmZzNDJwcm9jLmMKPiA+ID4gaW5kZXggNjM4MDJkMTk1NTU2Li5kM2QwNTAxNzE4MjIg
MTAwNjQ0Cj4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0MnByb2MuYwo+ID4gPiArKysgYi9mcy9uZnMv
bmZzNDJwcm9jLmMKPiA+ID4gQEAgLTcwLDcgKzcwLDcgQEAgc3RhdGljIGludCBfbmZzNDJfcHJv
Y19mYWxsb2NhdGUoc3RydWN0Cj4gPiA+IHJwY19tZXNzYWdlCj4gPiA+ICptc2csIHN0cnVjdCBm
aWxlICpmaWxlcCwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gPiDCoCAKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgbmZzNF9iaXRtYXNrX3NldChiaXRtYXNrLCBzZXJ2ZXItCj4gPiA+ID5j
YWNoZV9jb25zaXN0ZW5jeV9iaXRtYXNrLAo+ID4gPiBpbm9kZSwKPiA+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTkZTX0lOT19JTlZBTElEX0JMT0NL
Uyk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
TkZTX0lOT19JTlZBTElEX0JMT0NLUyB8Cj4gPiA+IE5GU19JTk9fSU5WQUxJRF9NT0RFKTsKPiA+
ID4gwqAgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoHJlcy5mYWxsb2NfZmF0dHIgPSBuZnNfYWxs
b2NfZmF0dHIoKTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFyZXMuZmFsbG9jX2ZhdHRy
KQo+ID4gQWN0dWFsbHkuLi4gV2FpdC4uLiBXaHkgaXNuJ3QgdGhlIGV4aXN0aW5nIGNvZGUgc3Vm
ZmljaWVudD8KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBuZnM0X2NhbGxfc3lu
YyhzZXJ2ZXItPmNsaWVudCwgc2VydmVyLCBtc2csCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZhcmdzLnNlcV9hcmdz
LCAmcmVzLnNlcV9yZXMsIDApOwo+ID4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RhdHVzID09IDAp
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChuZnNfc2hvdWxkX3Jl
bW92ZV9zdWlkKGlub2RlKSkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3NldF9jYWNoZV9pbnZh
bGlkKGlub2RlLAo+ID4gTkZTX0lOT19JTlZBTElEX01PREUpOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZpbm9kZS0+aV9s
b2NrKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IG5mc19wb3N0X29wX3VwZGF0ZV9pbm9k
ZV9mb3JjZV93Y2MoaW5vZGUsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IHJlcy5mYWxsb2NfZmF0dHIpOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+IFdlIGV4cGxpY2l0bHkgY2hlY2sgZm9yIFNVSUQg
Yml0cywgYW5kIGludmFsaWRhdGUgdGhlIG1vZGUgaWYgdGhleQo+ID4gYXJlCj4gPiBzZXQuCj4g
Cj4gbmZzX3NldF9jYWNoZV9pbnZhbGlkIGNoZWNrcyBmb3IgZGVsZWdhdGlvbiBhbmQgY2xlYXJz
IHRoZQo+IE5GU19JTk9fSU5WQUxJRF9NT0RFLgo+IAoKT2guIFRoYXQganVzdCBtZWFucyB3ZSBu
ZWVkIHRvIGFkZCBORlNfSU5PX1JFVkFMX0ZPUkNFRCwgc28gbGV0J3MKcmF0aGVyIGRvIHRoYXQu
CgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
