Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD312F4D32
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhAMOfk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 09:35:40 -0500
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:12608
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbhAMOfj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Jan 2021 09:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9kp2r4udBb1x5wWX4xRd/ayIs3qWjzMhq8O/2/ub0lkpwVkCxt5v3VPkRX4KaePu76yxNL6gJshWepfkpSIw1EpqwULT3ReRvdtKsO2jJEAbcQvQV9zz2gm4/jDp874zAm+5Ovjb1wm6Z1PFE7UsUN6QOU2m+YcHODaE6CJGvKnbsUmJnUqFjp259Bxhdq2AZYJJMYwMqoBKiLbMpA2YWE62NThNNsfbpqGmCseJk2RqhGXMjvyDgM7xdAbSxyZ87YUEthOdKFSvJAnTYhBM7u/ft+bEwH8q6WeFcu0TtAQdiy6pwgR8MMnQhDukNwQSKS+6M+SRrDeJL60IL4UTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcMJfFB20lZUk1FqDwrZPTxHOzzG9Fr4VNsa37yvaO8=;
 b=e9wzoNc//ohPLYMWjFNSqKpaoKFK8wa2ZHrrdOk5MHUfNhaP88V+9ZqAqxycVOBp73IwYLcdjr6AgCZaUKwqL7u2Op0s9Q97Iz17bfZn/noz1WRLj0Q08Loj6VWxhQjdiv37FYUDEnGk/uYOVK5PXPNBlM2maed7WCpVX4l2tkBR4cy8varB4zEJhPTlEvjvtq1NL9io/9bX8I/On5L50RtiqIscsfJvpIAKto4BfQY1JW8bMAYb5rmvvRbg0PmQzesY6Ti+iSG0Mw0VCFRMGUxHKxc196+A7qcnsxfH0SQXcI24n2A0tWEnok0xw/jTG2ZeEJy6DWNxJZNRz06B2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcMJfFB20lZUk1FqDwrZPTxHOzzG9Fr4VNsa37yvaO8=;
 b=CUg5zpzZh0b8Y30V9T1irM8zt9lB2C0ROfGk1fnikvoPSXzv5WFdRwEbC+xpAWKENo9w6oW00w9E5EUsIWUHPqu4BQtZWHnYO5TLWk22c4PVMGWbN0eaDali/+NTEuRX/n9zWj9WGurNRc/N+BPE29QJ110yF50HfGrSe4Uo/Ik=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4763.namprd13.prod.outlook.com (2603:10b6:610:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.8; Wed, 13 Jan
 2021 14:34:45 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc%6]) with mapi id 15.20.3763.009; Wed, 13 Jan 2021
 14:34:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "pgoetz@math.utexas.edu" <pgoetz@math.utexas.edu>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Thread-Topic: nfsd vurlerability submit
Thread-Index: AQHW6PgWrSMkggXjGU6epPPdOSc+z6okNQOAgAAHfgCAAAwBAIAA7UQAgABqwQA=
Date:   Wed, 13 Jan 2021 14:34:45 +0000
Message-ID: <0da3d3f1fee1a70eab3f78212f9282b03e21fc4d.camel@hammerspace.com>
References: <20210108152607.GA950@1wt.eu>
         <20210108153237.GB4183@fieldses.org> <20210108154230.GB950@1wt.eu>
         <20210111193655.GC2600@fieldses.org>
         <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
         <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
         <20210112153208.GF9248@fieldses.org>
         <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
         <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
         <20210112180326.GI9248@fieldses.org>
         <20210113081238.GA1428651@infradead.org>
In-Reply-To: <20210113081238.GA1428651@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2138f98a-d110-4b70-3ea6-08d8b7d05f73
x-ms-traffictypediagnostic: CH0PR13MB4763:
x-microsoft-antispam-prvs: <CH0PR13MB4763CF8F22E38DB153446548B8A90@CH0PR13MB4763.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 63kPWlSnvpWf0t2bgVzbdrJttjBp6RTCu7Qjkq/1pyfWuZ3xs27thE0DO4IkMS8rQQZHspNCrCw/eYU7891XTn3eDyzg/zVMMZsGZJ7le/zmy6kgQqdorOcMOQ6rXGa06qhoJJ14zGSLnojjEhIHoT7ReHnFO+dYlXQY+4JoJdhpS0CqeNF7ilolzK7S0iPmh8GCS3cDrp22EFDBUb4nh2+dtpRWQ1hYlm4JZTyCx6Y8nn4ZfE13NXnWa+BOAhJYaA5pM9kTYIGHxXEXMbWysypN+pHYlyd0BYdRDVEKQ3JUgE0YVtR8aWGARzmhdzww/ZlvdtaxAXgbxSokpRcbkBQm3c6S4suA4uSN4/1SXFU83DexLVTjNIHChg6Epwb3WwlXXef+rpilR/zKThPryQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(376002)(346002)(366004)(396003)(8676002)(36756003)(71200400001)(110136005)(316002)(6506007)(6486002)(186003)(2616005)(66476007)(8936002)(76116006)(64756008)(478600001)(83380400001)(66556008)(4744005)(6512007)(7116003)(5660300002)(66446008)(3480700007)(4326008)(26005)(54906003)(86362001)(2906002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eStuZGNONVovekRrNUlFZkJ6T2kwZ3lnYncxL05OSTc3N3dHOFpsVzFJYkQ1?=
 =?utf-8?B?bFEzQ3JuZHRYazZqS3pJVlNHZzVtdFIwbFdSMldtZE5MQmNBNVJvNzlqZVM3?=
 =?utf-8?B?UlpKMk9BQUdjY2NUYXk5bUdEcC9OWGQzSzdyMW1Jc0YwcDlnaWtnV2J2WnRW?=
 =?utf-8?B?MmNwbUNrM1MwT2oxNlhaVHM2SHlwN05KbUZCZ1J1Ym1hMEFndzA2WnBDN2FF?=
 =?utf-8?B?Q3Z5VU1QSEsxbzVIUXdubVVVRVBLUG5yNkZsNjhna21FbDg5bEVjM2N1djJq?=
 =?utf-8?B?RXhCdGlUYjdkeURxU0ZJMGN5MWMyZUo2eTZ1TEVjd3NFMzJlVmp0UE5HNXJ6?=
 =?utf-8?B?QVhKQjVDLzB6dllMVEZSL2pMNUMyL3pCTllselo2TEVvcFNuYy9zOGcyRzY4?=
 =?utf-8?B?dmNsVnA2alZ1enQxNm44eXZZRUthcldqREZiY2krdFRSTWZiZWJIUEZZMXNn?=
 =?utf-8?B?ek8xczBIRmxMRVYwSytzbERPc2JDMDIzTTgxa294Nk1JUTNtUWJTK1JNd1Ju?=
 =?utf-8?B?a3N0Zm9Cb2RxaHpUenQrc0RqM1lpZUgrNUhKNGEvTVc1Sk5QWFQwa0FsUlFu?=
 =?utf-8?B?VmV6YjNJZ2k5c29EZXBhUHhQcnA0Q2lha1FKbzJQMjVjUnIzQ0ZpMk1qWTNC?=
 =?utf-8?B?RjVJOG1JT21yODFncHZSOXAzR0p4S1FNK1YxUWV2a3ZMT1U0MEdJTEpRaXBN?=
 =?utf-8?B?MmxwbjNrWFRQYzF6MFpiNTZaZUc5eDZyYXJYdnlUMTlacUlaaWU0UDFjT2No?=
 =?utf-8?B?SjcxTGdhNVZXOGNaM080K3JvZkZ1YjdLYVpkbERKWEMwVDVpL3BxYU9EdU5n?=
 =?utf-8?B?R3I5OFQ3NW9ScEhLOUpoZnd5bXdTbHNud1h4Z3RRS1ovQWFyenpWcjhzTVVy?=
 =?utf-8?B?UjlSWkp6NmNDbnlzWlV0OUczWVpzNHE3ZGdCenUyWTZWSnYyeDBVQ3hlL1VD?=
 =?utf-8?B?ZnVETVZGcHh4dWcxOVJhQ2tBMjdsT3NwckdqdTNxQUxQSEpZM1l1OWs3SzBZ?=
 =?utf-8?B?RjdmK0JoM0FRcGJQUEs2d0NtN3gxQTZhR3lNVFBUVC9tYThzRWRaaFdRanpS?=
 =?utf-8?B?TWhXUkUwMHZaL3hPQkJpbXMxMDhmQmlVU29wemxNb1BKV2krMXc4WXRUVys4?=
 =?utf-8?B?SWhlOG1SaW9NUjhNMEc1L2NBY3poUU54TjVzZXBOcmtJSnZnVm54RTdmdnVt?=
 =?utf-8?B?QmtqOWNpM0ZsQWpDVVlUTUtzY2Z1UmwxRWZqQldhSFNZb2VhY0hoWlozaXI3?=
 =?utf-8?B?R3V2eExyUDEzb0Z3di96UmFEN0pXL2pWeC9jMXdYS2NKVTdldnhoMXM2TmhR?=
 =?utf-8?Q?e9eoqdZo1qbTeYFf+/4v8kBRelcksdKy/n?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F7D9D42A95A7D449792CEB8EC563C41@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2138f98a-d110-4b70-3ea6-08d8b7d05f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 14:34:45.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtmF7tHYB/DxBHi0/GeEFE0qTS4OsahS7TZzoNgeaZrIlspvB0h6wJKDM3LyKPBcIbWIWiXsASQjj8BmGCMeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4763
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTEzIGF0IDA4OjEyICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRllJLCBpZiBwZW9wbGUgcmVhbGx5IHdhbnQgdG8gdXNlIHNvbWUgc29ydCBvZiBzdWJ0
cmVlIGV4cG9ydHMsIGZvcg0KPiBYRlMNCj4gKGFuZCBwcm9iYWJseSBleHQ0KSB3ZSBlbmNvZGUg
dGhlIHByb2plY3QgaWQgaW50byB0aGUgZmlsZSBoYW5kbGUgYW5kDQo+IHVzZSB0aGUgaGllcmFy
Y2hpY2FsIHByb2plY3QgSUQgaW5oZXJpdGFuY2UgdGhhdCB3ZSBhbHJlYWR5IHVzZSBmb3INCj4g
cHJvamVjdCBxdW90YXMuDQoNCllvdSdkIGJhc2ljYWxseSBuZWVkIHNvbWV0aGluZyBhbG9uZyB0
aGUgbGluZXMgb2YgYSBOZXRBcHAgcXRyZWUuDQoNCmkuZS4gYSBwZXJzaXN0ZWQgdGFnIHRoYXQg
Y2FuIGxhYmVsIGFsbCB0aGUgZmlsZXMgYW5kIGRpcmVjdG9yaWVzIGluIGENCnN1YnRyZWUsIGFu
ZCB0aGF0IGlzIHVzZWQgdG8gZW5mb3JjZSBhIHNldCBvZiBydWxlcyB0aGF0IGFyZSBnZW5lcmFs
bHkNCm5vcm1hbGx5IGFzc29jaWF0ZWQgd2l0aCBmaWxlc3lzdGVtcy4gU28gbm8gcmVuYW1lcyBm
cm9tIG9iamVjdHMgaW5zaWRlDQp0aGUgc3VidHJlZSB0byBkaXJlY3RvcmllcyB0aGF0IGxpZSBv
dXRzaWRlIGl0LiBObyBoYXJkIGxpbmtzIHRoYXQNCmNyb3NzIHRoZSBzdWJ0cmVlIGJvdW5kYXJ5
Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
