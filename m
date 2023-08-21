Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5E782D29
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Aug 2023 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbjHUPYf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Aug 2023 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjHUPYe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Aug 2023 11:24:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82463100;
        Mon, 21 Aug 2023 08:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiLmVIusx2aenE1DVyN0ZhNQTYlly6rXqgOztB17puZwYfbVqMN2PW4zT4P7vnGY9ZUwqCcyJ5XQFY70PMtRGU6l9P3YJy07N/XfqAHJOnvBnXXfaIPk44LDF/sKJ0XmVie8mca10LxLOG4cfgONM8a3n5sxMDgQ56up5CN1PEdu86apwKB7SnDJ1vTnZkrgeo5dxscX8aqpJpDw27ARBLo6ohWQc4HKojQdnLrdtYqYljucGeID1yfgJ4lU3ScFAK8fE4Y0/DCa5D9zRUDPihV0qdDXxn6hE6jeZ5hJ9WIxO4YOMZyPwK51RmxqGut9kgWGkQ1xhKg8ud7Xaak+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLnoWQplv7vrc7oEUHVLe9QwgR2nkRIvZkAye7ScOFk=;
 b=EkO7ujJxhBwKCs3DEFskqg49h0N4aKwYuvIG4qzHnzrf+oIhFibmZIKCncbhioqDMtpf8LpK/RLQT84pkY4GNzJm6IUYgPhkSDqsooeJkTfqqAQ/j1Z0y8BtVq9izXDs5vpA3gN7JcbHD+vB2OoigksoXE68grBQqCM6B+h/TNWajr6OXFgFWh8VQK5REh3UoakSigKP6H/7BPoCjcTKcrrDwFGWLy6Ad1tYca5YdBdJQf0UW+57ScOKXxu+UCz5DKe6Rqaxre0xbAHip10vLnGYGhfIIQfHKVWWsAQxe8JYEwAB/Y3YVZyNkR5DkXJqnyv5xVR6qyGR5ZXzl+1oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLnoWQplv7vrc7oEUHVLe9QwgR2nkRIvZkAye7ScOFk=;
 b=Xs1hyVAy7+ZlfXBcMKjgoz7kiPKVXfOW0jYA4WVpM6dE97d5HiJUKSqTaYv2i2T+hpGNh1uKU70oYjnPsB11jCjehxSz3TrcP+wzAyuFAwyvRIK2itXX9jWzm6uvfo6Z8Y0T38u/dVZ2CbGROYuKdtRXlop7IsYfrfuM+03Qjoc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ2PR13MB6427.namprd13.prod.outlook.com (2603:10b6:a03:55d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 15:24:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 15:24:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for Linux 6.5
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for Linux 6.5
Thread-Index: AQHZ1EOQ7g8wIu24Jk+KaizdfL6hjQ==
Date:   Mon, 21 Aug 2023 15:24:23 +0000
Message-ID: <10efd849aa3c182bae0009523ad9c5fbe3be4e8b.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ2PR13MB6427:EE_
x-ms-office365-filtering-correlation-id: 10f792cd-0862-4349-923e-08dba25ab2b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNvNRLuc3Hgac1u48gXMUphaPOYYtpAfaLh8ONzp5uQVYABzF85Jt2ziznp1S9ImITTWDGPWKF1Yl3m70qtttvV6bqO/lCkp9eoJaglaBbOvcWknHqI8TfqnL1BKw4pAWsIInz5ockU/jRtg3WfN/JcPchWMF8XPsHVTWPa1kjeTg4qk9kwc0q6OGR7dLMQIFZHJgR5jXnpPdYtMQfofc4SRKVWDHX6LtL8CoWnYFIWKzYo1vwwTJBnD5gaR8+5HCyUmeeWx1Nbcx/6bBhb+ZdKTM+8ovbuAFse+ZP708F7ooYOJrlVpPpBLQxgW6Q99XDk2bFeY2u26FGJkCvQWKCU3mDlTWKIkRmABaFBOiSQId9GO3x2TQAzEjbDzgGTb/VRkC0mTRuoFaqgoZ+JHYr93gjctq4PDPHMa3FImvDThbWdZI+WqWrYJRwcD38D8C8xavNcOo1cTNUtYtf7eBCDfZlUUV4GQRoFcn97+fW3uy2iluQrPsK8aNVzcVriJM/0XFecf8OFewCcPQK7v6g//2Jdj4xe+lg0fFxUC/pbJbAVrv9fDfL+uzqdgL8JDGbzvnfTKXYMoY1bnYj67Q370yLU9DSl7rUEHgKjAo6+rfmBHLL2YmLYOyI07xc4Lmb7nayFbdyZcdyHMYTtdOnc5VLLO7Lg4WHMvjpnHqiXtBnny9w7k1YiUvmvYelfJ+qQoJYWsH8pkVx6u7cm63Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(396003)(136003)(366004)(346002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(6512007)(12101799020)(26005)(83380400001)(8676002)(4326008)(8936002)(36756003)(122000001)(316002)(41300700001)(38070700005)(38100700002)(86362001)(2906002)(5660300002)(71200400001)(478600001)(66446008)(54906003)(64756008)(6916009)(76116006)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGl3MDlrNjhsSW1oV2R5bXRlb0pIYkd4Qk1sTXFTVGJ1d2hyTlpsWGJYTWFD?=
 =?utf-8?B?YjMwSG5WcWYzTm4rRDlkSk9Ybk96Nk9UeWFaRWNBdk96VUlKZ0RxOVVoelUz?=
 =?utf-8?B?ZmJqY0E4dXlwMVZwTjNTSHlSamh1eGVPRkF4eXBBYmt2bnkwL3JXNmRqRUlh?=
 =?utf-8?B?bDZtRldqNW9RbFhYNGtqVTVUMUpBWk9GQnptd1ZVYVFJdnV6UEpJT1EvNnFP?=
 =?utf-8?B?UmtGeDlZRi9mZERLSmNDcURMQWhGVEYwcHpoWmJhUzFhMy82cjg0TUZPWXRp?=
 =?utf-8?B?bXRmZ0kxbmdQaG1mQkRRblJhT1FvblhCNEEyY0ZWajUyWjk1Q0NEeGp3ajVj?=
 =?utf-8?B?VElLamYrbjNWS0pySnB1K1NvMjdNRmRhSDFJeUIyMThWeXBEcExkbVJTYTJ1?=
 =?utf-8?B?WlN4RUNJZ3RyWDh3OFNvRkdRbWVPLzMwZVVOeFYxVjBoSlJHTERSempJcncv?=
 =?utf-8?B?SGZFTmkzOU1UNEJ0NVpIY0IxVVBzTzhkeFNqU3h0bTNOWHAvL2ZLUThzcHNG?=
 =?utf-8?B?cXNicGtZMzU3eDZOYnV4TDBRMkNBdGtaYk1pQTE5d29zMXZPeDVOcFFNZERs?=
 =?utf-8?B?YnZIQ2tZUWVPcUJIYmQzeUFLWU0xa1k3WDEvMlAyZ3dueHJnMzh3VEZ4aFYv?=
 =?utf-8?B?TEdiODdpNFdMbXBtdlJyWXBBUTN3dzU0Wjgxc0xYam5mK3g5TEd3S3FDeWtq?=
 =?utf-8?B?TXR3NVhuUyswQVRkUjBycTQ4VjhvMUErSVVzNzFSOHplWUtqREx2ZmVEdy9C?=
 =?utf-8?B?R0h5cEREaFNtSUtQQldXK3VIQi9mWWNWUHNQdHg0alZmcm5zM2dWditwUERu?=
 =?utf-8?B?UENqb0hRdyt1eitHUys1WkNHcnR4cGJ0ZituWkNRT0hBaW42SngzdlBjaEJs?=
 =?utf-8?B?ei9kMW50YXBCSjRDQW9xT1JIalI5eUpCL3N6ZVgwWmtHNWZha05ZbmlLN3Bt?=
 =?utf-8?B?bWxjaGZYV3ZPeWxvaGEzRnNYaTRWeW1kbVZmbkZESkEzaTBYeWx0VEVQMk15?=
 =?utf-8?B?VUY5NlFZMFpXTG11czhOdEJ3SjdjaGxJOFMxZUY4OVZkclZtY1lqK2cwaTQ4?=
 =?utf-8?B?d2xicmZaSGZMWnJEdTZtTkwzU245WjBod2lwT25Lb3dxcWIycXYzS2dtZEc0?=
 =?utf-8?B?ZHlKNElUVEx4enhkSDlUOHFYUTJmYy92OGxQa3pkNnc5RDFBRTlXZEZwYUly?=
 =?utf-8?B?ZjF5V3dnd2VkQnBQWlZIR2ZWY1BnbEgvenVBbUI4VU85WDZ0eFBmMWllQkky?=
 =?utf-8?B?dlN4V1EyejNZbUhJTngrcXl0dEw5WUp6TWdkdE1hbldRdkc1ejNkWWJMWUxY?=
 =?utf-8?B?SHB2cFZPL0E0YTJMbjhMb3NncDl4UnVyL09vNnRGRDZZYzdneWdSMys3YUFC?=
 =?utf-8?B?TG9GN3dGUWJUQkR5NXQ0ZUhLblFya0NTaVBZdGtwek9IQ0dZMnA2alJneEdk?=
 =?utf-8?B?M29TeGFCOGpoRWNaeUVFKzVUZlpjNmNHWjVwNE1MWmorTWhUTnRHUm9mRk9v?=
 =?utf-8?B?b0dJRDlyUzFaRHNuQWRRQzF3bEJramZrUy9vMlQwNkVocVRrcVVsdEt2Snhw?=
 =?utf-8?B?TWJrQ0R2bVN5L0IwMUJmaFRQNEZ3ZEpBQWptYW5NRU1ZaWcrdHhJNk4xNTdO?=
 =?utf-8?B?R2Y2NFNEeHd3UzB3WWdiK2UrWURQZjNrY0ZxbzNWNTRTcW9CaXpvTmRWSTl5?=
 =?utf-8?B?Ynpvam9rWEVpTmVPdVUvMkM5emx2V1EwNjRlMzd6TU1UN2J2TmpDeHUzbEwy?=
 =?utf-8?B?TDNGZlJ1M3RIenNKVTAvY1Z5QTNZQmlEY2JVV0VxM1prMjFIeWt4QW5lSDgr?=
 =?utf-8?B?R3ZWbi9NcVQ0VzVtd08yMnVMSlEwUnhwZTlaWU45WVdKcENINkcwM0ZUOUNG?=
 =?utf-8?B?UW82TE1Reks1TVNld2xEVTZJcG9zZ20zd3JkZldLY2s5YkJoeEQyRGRiNGx5?=
 =?utf-8?B?N2o2NjNVSzgwamxUVjVhNjFVVDZOWUZSR28va05DLzBNZE5OMW9HYVUvcGFU?=
 =?utf-8?B?cEphOVBPaUdWNE9uMGRwd1N2dFB5aVJFVmNKSmVsRitiRzRNeE40a2N3MXVH?=
 =?utf-8?B?TFVvUWMvWjU3QmVPQlp1RHlyV0w1WVdteWl2TkVQMVVDdUloa3ZBd0M0UWhl?=
 =?utf-8?B?Zjg3eTFpMDA1OGViaDRmbGtZODlDaXAxWCtqOFc4WWdFRzIyUWpMSDVOek5r?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5157FC008F750947836A0F8DF4DF873A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f792cd-0862-4349-923e-08dba25ab2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 15:24:23.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tas9W8gm6WjwdEHeizX+st7Di5GETmWPioGIdc5cQLFbDnHDrOnwvqkK5xXvZ6VNGGQeT+nCJJuUJXAm3q9kxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNWI0YTgyYTA3
MjRhZjFkZmQxMzIwODI2ZTAyNjYxMTdiNmE1N2ZiZDoNCg0KICBSZXZlcnQgIk5GU3Y0OiBSZXRy
eSBMT0NLIG9uIE9MRF9TVEFURUlEIGR1cmluZyBkZWxlZ2F0aW9uIHJldHVybiIgKDIwMjMtMDYt
MjkgMTQ6MjU6MzUgLTA0MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KDQogIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3RzL3Ryb25kbXkvbGludXgt
bmZzLmdpdCB0YWdzL25mcy1mb3ItNi41LTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIDg5NWNlZGMxNzkxOTE2ZThhOTg4NjRmMTJiNjU2NzAyZmFkMGJiNjc6DQoNCiAgeHBydHJk
bWE6IFJlbWFwIFJlY2VpdmUgYnVmZmVycyBhZnRlciBhIHJlY29ubmVjdCAoMjAyMy0wOC0xOSAx
MDoyNjoyOSAtMDQwMCkNCg0KVGhhbmtzLA0KICBUcm9uZA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZTIGNsaWVudCBm
aXhlcyBmb3IgTGludXggNi41DQoNCkhpZ2hsaWdodHMgaW5jbHVkZToNCg0KU3RhYmxlIGZpeGVz
DQogLSBORlM6IEZpeCBhIHVzZSBhZnRlciBmcmVlIGluIG5mc19kaXJlY3Rfam9pbl9ncm91cCgp
DQoNCkJ1Z2ZpeGVzDQogLSBORlM6IEZpeCBhIHN5c2ZzIHNlcnZlciBuYW1lIG1lbW9yeSBsZWFr
DQogLSBORlM6IEZpeCBhIGxvY2sgcmVjb3ZlcnkgaGFuZyBpbiBORlN2NC4wDQogLSBORlM6IEZp
eCBwYWdlIGZyZWUgaW4gdGhlIGVycm9yIHBhdGggZm9yIG5mczQyX3Byb2NfZ2V0eGF0dHINCiAt
IE5GUzogRml4IHBhZ2UgZnJlZSBpbiB0aGUgZXJyb3IgcGF0aCBmb3IgX19uZnM0X2dldF9hY2xf
dW5jYWNoZWQNCiAtIFNVTlJQQy9yZG1hOiBGaXggcmVjZWl2ZSBidWZmZXIgZG1hLW1hcHBpbmcg
YWZ0ZXIgYSBzZXJ2ZXIgZGlzY29ubmVjdA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpCZW5qYW1pbiBDb2RkaW5ndG9u
ICgyKToNCiAgICAgIE5GU3Y0OiBGaXggZHJvcHBlZCBsb2NrIGZvciByYWNpbmcgT1BFTiBhbmQg
ZGVsZWdhdGlvbiByZXR1cm4NCiAgICAgIE5GUzogRml4IHN5c2ZzIHNlcnZlciBuYW1lIG1lbW9y
eSBsZWFrDQoNCkNodWNrIExldmVyICgxKToNCiAgICAgIHhwcnRyZG1hOiBSZW1hcCBSZWNlaXZl
IGJ1ZmZlcnMgYWZ0ZXIgYSByZWNvbm5lY3QNCg0KRmVkb3IgUGNoZWxraW4gKDIpOg0KICAgICAg
TkZTdjQuMjogZml4IGVycm9yIGhhbmRsaW5nIGluIG5mczQyX3Byb2NfZ2V0eGF0dHINCiAgICAg
IE5GU3Y0OiBmaXggb3V0IHBhdGggaW4gX19uZnM0X2dldF9hY2xfdW5jYWNoZWQNCg0KVHJvbmQg
TXlrbGVidXN0ICgxKToNCiAgICAgIE5GUzogRml4IGEgdXNlIGFmdGVyIGZyZWUgaW4gbmZzX2Rp
cmVjdF9qb2luX2dyb3VwKCkNCg0KIGZzL25mcy9kaXJlY3QuYyAgICAgICAgICAgICB8IDI2ICsr
KysrKysrKysrKysrKystLS0tLS0tLS0tDQogZnMvbmZzL25mczQycHJvYy5jICAgICAgICAgIHwg
IDUgKystLS0NCiBmcy9uZnMvbmZzNHByb2MuYyAgICAgICAgICAgfCAxNCArKysrKysrKysrLS0t
LQ0KIGZzL25mcy9zeXNmcy5jICAgICAgICAgICAgICB8ICA0ICsrKy0NCiBuZXQvc3VucnBjL3hw
cnRyZG1hL3ZlcmJzLmMgfCAgOSArKysrLS0tLS0NCiA1IGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
