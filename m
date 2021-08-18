Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF83EF816
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Aug 2021 04:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhHRCck (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 22:32:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36246 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236597AbhHRCck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Aug 2021 22:32:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I2VsML005522;
        Wed, 18 Aug 2021 02:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PJl5Mlh5Ucz35k/yTX910qCwn1ESfnSCjYtgsn4x/Ag=;
 b=JlXDlY72Fqep6V8mfqfZ2nvOBcYmPkKUlNJSIENw4gyYAO3BCr58jkoTvKJfIoDp1eET
 ykDhTXVzXe/8sZUt1A2ljkxdDqIq4dU4ySD9plSjZiRFpqloSla/XDTHJmUsu4+FmvZo
 zieNZDTFhxzfGrYPhvJ+p0RsONHorCftL3NmXUELv1MGP/9Ef3tq85EfyvQN7e+k+uz6
 GvVNSi31pfre407LfIWNMrCrwDYsjkeQ13mW9Zndh15YXSAxGIagmR4jv0CT3pdWlwwj
 oJnQeRXk1zp5nb4W/Ys/WKnUaTbvVGgRI1XUoL3yY8chY/Zo0XPuYgdeLjMr5YEzj0DQ Nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PJl5Mlh5Ucz35k/yTX910qCwn1ESfnSCjYtgsn4x/Ag=;
 b=lMAk2a6ajItKbzHdE3qi0yLlEgHLrD4OXPpvLWl7SvYWwdDMUSKnKLvxMo7tRmajp//g
 A2ias87/WKJfw9HUqXo6r/5kSIx2Knynzq4kABNx6/OpnNQ5KAbLXyITfdLq//uxAHPq
 0Mjr/t6GnBHNY+5BEr/y4mvIDkUVw2nrPQwJAG7OB6i/VIVYfBIxsZKUy9wpgRH/tO3C
 1aJdFuESidlCrGuoA1udXWk3LqD1sKW03yPcAIIUdr7vUimVlnwS1Hi0ZpPAHgw+LUI/
 6LqgQ6cnHyEENCXZtJepwjzLUv2BIJPvm9B/0Q3m/AaIGQRsHscKeGMd1L+K3kM6PCVw QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbdfjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 02:32:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I2UvKa191334;
        Wed, 18 Aug 2021 02:32:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3ae3vgmt82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 02:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFzLXxD5FhN3cxP/R4xTXT9PkWxMEXo9TdBhusuxlEVOJExvChn3q/Rcb69NVzkGKdeglHRQ+yznM85d8HLMUf4BkBXVVQQMKE1FyPY6EGZWn9UIpd22N1LN/nZ/1Hjtxu4GgSqX7ObFj03Bbf9Il5Be32euXNJ9zBc4tu8oncI/TGIVYjN7n5ubHa+6rPcPTE7bPa4WhJ4fObhTJSsjoe2k0301+LMjGzCpkViHOPpF9zIaBGNr6W1Wz1zO/ahRQQsR1ea1kTMiMu4fk/9B6Mc0JcONVGuegJfOipe2LtL8J2VY7UQOD2MHPH3k1Hvjl7k/f1gCg2qPn3zVIIivDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJl5Mlh5Ucz35k/yTX910qCwn1ESfnSCjYtgsn4x/Ag=;
 b=EBTBo9mZ4pNMAxm8LX3j6mwRTpwUHTCv188Od7f4Ut7ZJGDkGIaIe7O0/FzcDnDdSTijos/fTvgUmclVrBa2xGe7lzQCVepwNHqEo9f10laj6o2mTVFq9dF3k5xZPhZgjwaOkZK9rG1E8JQI2FC+e5xhyK6OCWGZrslDGq7J4p9qJveqZTFAIxc1t2R217F6sOcfhR9TzoP5qk2VQviJymLfVfRISTh9kSKUBElEQPN9mFWCnhS0QHk8DxG078N4kG7Zt//M6UOaFkCpAZVlw8C1MACXNs0SB4ZYkLUG+MzABvvT73QI6fKJCmP+8fXWxPW7kDeRalTB10cNO4nAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJl5Mlh5Ucz35k/yTX910qCwn1ESfnSCjYtgsn4x/Ag=;
 b=bAVf2vcmLZ+6Hdol1bNgqcynrE1EtaVszDI6emWogONfS0YGHiEUjUmXUNL5Hk3P+Pr15F1gX+rTDq7b0tsdglKKTsW4wO0sYP6PXtEZF5YJzRHeJL5sLoBNQ5E7Lfu6Mo6/EaCqVFNZEvx4hhcHh65SP7HK52m1lhgAdTs+3nY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3032.namprd10.prod.outlook.com (2603:10b6:a03:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 18 Aug
 2021 02:32:01 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 02:32:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] xprtrdma: Move initial Receive posting
Thread-Topic: [PATCH RFC] xprtrdma: Move initial Receive posting
Thread-Index: AQHXk5UwUCIj+qjZd0mlubzHW4Ifi6t4eseAgAAQgAA=
Date:   Wed, 18 Aug 2021 02:32:01 +0000
Message-ID: <F673EFB1-176A-41CA-AC32-39B546D93C5A@oracle.com>
References: <162922469165.515267.14848799693507242987.stgit@manet.1015granger.net>
 <cbc92df6-ed85-de7f-0589-fb03cef49060@talpey.com>
In-Reply-To: <cbc92df6-ed85-de7f-0589-fb03cef49060@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed6c8277-b2b1-4399-25c9-08d961f05bf8
x-ms-traffictypediagnostic: BYAPR10MB3032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB30325269317CFD3AA3FD5F3D93FF9@BYAPR10MB3032.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTF7WEERNFjgOXqFZHRXwsrbLgPCLMXPHFHyn7j3Bh9Uq8GSuFnyeOvojB0NzioJ2BxVnKY01sOjRE2JfHveKKy++SCpW+gVsZx6vd1TBMrgXFxVZP3VaxClb54EmSF75sVbWu2eDaC8jymKkBNJKdfUxYFNNMnD4HvVwzjvsBtfpczGscShDVu6D5BxkQAh4kX3xxCWAoNLJ5/Y36AkC+8fkyvBfrEfzxX1yc5ilscmPAI6SSqNqVV31tQ9PTlH8duHSjRSoyOEExlSnZPnN+i3+ibr4HObrLGwjiF7Fk7R7nGtVvVRZufSJg510u9M4ofB2YrOfv7iZvngqE/PXeOidaB0+WCNxW2L1zYNJNylYbBd8e2+YJD0E4uwqLPmTVWvebTYLctQZ4cfMZc8Qj47qr3KrTgaKX+KHk4XrDS/ah6D5xdsB95p1STOL5p6QVopCI74tj6jD0XCV3ijZoDdlojAnvRM67Du2KzYxgiBmQ574PAjSNX0TOfrYo2TvScCkDE1euUcEuFTxF9vZB1rDHPVVzBSzxbErW6CpHCnI7hmsJZ2B5FLGB25am5MIN929odqZtk6hbU5WjUgIFhYRM/TQAARXrCra+Of4IZxVCmcsYIAm/6wHdNVnxwXTL+MCe/Oh35ACsvvnLDb6DYc9hRGlLZgJAHz9C/fANEDTLHFk9+Bpnd00FITRUC5V9RbMDXTlWyOwQgbZ87Q9EmVSh7KeqcjIZyzJX7la2UNnICjdhIBJyRy6jwy5H/H/35vw+IitcC4PdU3h4H/jqE0tzboKE142QLiP+GQnfS+Cwo17Us32ZVZs7j6SVaRJIdETF3Qg9X75QIR3sXVOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(6512007)(6916009)(71200400001)(83380400001)(122000001)(38100700002)(36756003)(66574015)(4326008)(6486002)(2616005)(186003)(38070700005)(478600001)(66476007)(26005)(316002)(66556008)(66446008)(8936002)(66946007)(86362001)(5660300002)(53546011)(33656002)(966005)(6506007)(54906003)(8676002)(2906002)(91956017)(76116006)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3E1Z1F0RkRlMkNqeHI0U3lnM3hQVDRWN2Rla2t5MW4vTjNyUXpmbk42VGlL?=
 =?utf-8?B?akppeVB3N1BsdEVwRnlxQ3E0RjhOMytSak5HUkRncTNlS08vaHJjZ1YvT1Z6?=
 =?utf-8?B?Q2xMVytkVitYMURYMyszYXRUdUtMOFNBenV0K0RjTGFrYzh1K1Q2MXB1aEVr?=
 =?utf-8?B?VTAvaDlyTnRrOXp6Vm5qRWkzUlNJSXdSblNsdFZIc25lZXZDc3pSMVFoNk4y?=
 =?utf-8?B?TDRJcUl4bDRKbDh6OTd4Z2Z3OFZtVGRBS0I2b2UrREVJclA1aWszSzZCNW5p?=
 =?utf-8?B?VGpVSkNPYzFlcDFteG5abC8wNkNqQVRNUXNKQkg4aTdqcHI2anliVCttQ3JW?=
 =?utf-8?B?UFZvekNoT0NYaGcxc2ZpNWtMaUszOWk4UWlHamkrdDJDR3dVN05DUnZuczBn?=
 =?utf-8?B?cjcwN0xYVk93VHRmR1F6NTQ2L0MwTGJ3NitiUVVDeXNaSzFSR0wvajE3a21N?=
 =?utf-8?B?aVZrUytmeXlRWGFGbkZ1UU9lcmRjemFva1A0M1NCVlh6UnN4ODc4ZnlqemFq?=
 =?utf-8?B?azVyU2FKOUozMU9sc3pQSTcydUVLdWlRelUvOFYzWm0zZ2FXNU9mN2kxbzY5?=
 =?utf-8?B?eGQ2dHZNR014YWFndHlKaTZGY0x1eGI0MGJUbFQzM1BRQ3dpQjRIREJVQ1h2?=
 =?utf-8?B?NWhBQ1c5cW5COWxLMjEvdlh3cEt3YnZhRDV2T0g5Um51bkpQS1JhMEI3ZnJU?=
 =?utf-8?B?UlA0MlQvdlRmUG5pZGJmaXRHaFBoNndXNjRiQ1pRUnhEM2FnM1I1Yk50ZXk1?=
 =?utf-8?B?YmpzWFd4ZjFKQWdXT1EyRGxWZi9DL3ZSWVoyN0xZNkFQaGhTMm5QblYyUHNi?=
 =?utf-8?B?U3Z5dU5iZlNCYy9JbzliWUxwMytHSG51Y1pqT3FrelFFVVNXS2xOTEVHTVVz?=
 =?utf-8?B?ZkkwYkJLSmpPRHBoT3ZmT0NPZXhXOWVIaEVabmxEOERCQ1NGdFR3dXNlRWZZ?=
 =?utf-8?B?Mk5MRXVudUY1UWVKT2FLUW9yU2xiTDVlYzVLQzBNMUVTRVRSOUpIejBRckZO?=
 =?utf-8?B?enZpbi9zNlhYNDZ0R2hRTzZCVnJrcUU5dFZ1aHlRT2VEcWxzV0F4a0NaeGs1?=
 =?utf-8?B?OHJQL1YwV3lxU1RzVXQ4WXo0dTVmeG1LMnJBMWtVMzREbmY1L3JGbnc0T1c1?=
 =?utf-8?B?ZS9JODc3QlVOMW8vV2gzRkd5NUd1RzNhUzRGWXBSaElaUmlXZUR5WFRlVjRl?=
 =?utf-8?B?cWV0SU1JN0xZWWt1WnpaUCtsVU1YRHp4OGVTdmRBbmV1YW1rMjQrdWx3ZUQ4?=
 =?utf-8?B?Y1RSblhPb1NoQ2FlOCtWT0FWR1JZTjVBNGVacWUrQkVxTFVLMUdpdXpIczAw?=
 =?utf-8?B?R0ZEZVZBSjN5TjQrT3NGRmpJanN4R3A3cmdNb3FtZHJoL21yelBxd1NsR0hj?=
 =?utf-8?B?UTM1MWptTGpzdlB5NWN1SkRHcVdQVW4rUVNwM0liUXJRdkkvOTl3akxHRWd3?=
 =?utf-8?B?azEvRmVMYzA3cGcrRkpwZENSeDdtVThHR25kSXpCeFEvalhNM1VhdVNVOFpl?=
 =?utf-8?B?c2x3WGc5UHQvZnFwVUg2S2hidFdhdzAvMUMyUDJzTmp5U3hvcnRHY1Rnem8w?=
 =?utf-8?B?U3lKTkhyMk1reHlQVmFWWmxZbzB3TG85N0swZ0lsK0NHcUJxVmxaOVdYeS9t?=
 =?utf-8?B?SjIzWUZuT1dvT3hISzMzbXI2QnNaMy9HV0pIYXFJSmhGeW5KTlZ3L21sT1hr?=
 =?utf-8?B?VjR3bk9nSFoxV3ExY2ZoZWFCVHhFcFpCQmdFMndXYzRvWXc4cFlDNURDTnB0?=
 =?utf-8?Q?7gRTHBl5huciz9mL5cYNCxUe/Z/TJ3Djmo0nbCj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C0F4A8A102BC4E9E69E3F3FCCB5426@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6c8277-b2b1-4399-25c9-08d961f05bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 02:32:01.1167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QHu77pZKqTqqRhVQKv9z9xppjfe/rNe0mzpmJfPved5gaYesukLDsLYxsOQqFMLrON1SytJBwFeBtgp5DkguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3032
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180014
X-Proofpoint-ORIG-GUID: Qpcx3hj9GeUiLdYMcZTsgXPRBUQSrCPm
X-Proofpoint-GUID: Qpcx3hj9GeUiLdYMcZTsgXPRBUQSrCPm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXVnIDE3LCAyMDIxLCBhdCA5OjMyIFBNLCBUb20gVGFscGV5IDx0b21AdGFscGV5
LmNvbT4gd3JvdGU6DQo+IA0KPj4gVGhlIGZpcnN0IGF2YWlsYWJsZSBtb21lbnQgYWZ0ZXIgY21f
c2VuZF9yZXEgd2hlcmUgeHBydHJkbWEgY2FuIHBvc3QNCj4+IFJlY2VpdmVzIGlzIHdoZW4gdGhl
IFJETUEgY29yZSByZXBvcnRzIHRoZSBRUCBjb25uZWN0aW9uIGhhcyBiZWVuDQo+PiBlc3RhYmxp
c2hlZC4NCg0KRm9yIHJlZmVyZW5jZSwgSSBzaG91bGQgaGF2ZSBpbmNsdWRlZCBhIGxpbmsgdG8g
SMOla29uJ3MgcmVjZW50DQpyZW1hcmtzIGFib3V0IHRoaXMgaXNzdWU6DQoNCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXJkbWEvQTMyOTc2NDEtNjNCQS00REYxLTg4NkEtMzYyMEUyQTQw
QkEzQG9yYWNsZS5jb20vDQoNCg0KPiBUaGlzIGhhcyBzaWduaWZpY2FudCBpbXBsaWNhdGlvbnMg
dG8gdXBwZXIgbGF5ZXIgcHJvdG9jb2xzLiBJdA0KPiBtZWFucyB0aGF0IHRoZSBsaXN0ZW5lciBj
YW5ub3Qgc2FmZWx5IHNlbmQgdGhlIGZpcnN0IG1lc3NhZ2Ugb24NCj4gYSBuZXcgY29ubmVjdGlv
bi4gVGhpcyBjb25zdHJhaW5zIHRoZSB1cHBlciBsYXllciBwcm90b2NvbCB0bw0KPiBiZSBjbGll
bnQvc2VydmVyIHN0eWxlLCB3aXRoIHRoZSBhY3RpdmUtc2lkZSBVTFAgZmlyc3QgdG8gc2VuZC4N
Cg0KVGhlIGN1cnJlbnQgc2l0dWF0aW9uIGlzIHRoYXQgdGhlIGNvbnN1bWVyIGRvZXNuJ3QgZ2V0
IGNvbnRyb2wNCmFnYWluIHVudGlsIGl0IGdldHMgUkRNQV9DTV9FVkVOVF9FU1RBQkxJU0hFRCwg
d2hpY2ggaXMgYSBiaXQNCmxhdGUsIEkgYWdyZWUuIFdlIGNvdWxkIHBsdW1iIGEgY2FsbGJhY2sg
dGhhdCBpcyBpbnZva2VkIGF0DQp0aGUgIlNlbmQgUkVRIiBzdGVwIGZvciB0aGUgcHVycG9zZSBv
ZiBwb3B1bGF0aW5nIHRoZSBSZWNlaXZlDQpRdWV1ZSBvbiB0aGUgYWN0aXZlIHNpZGUuDQoNCkFs
dGVybmF0ZWx5LCB4cHJ0cmRtYSdzIGNvbm5lY3Qgd29ya2VyIGNhbiBleHBsaWNpdGx5IG1vdmUg
YQ0KbmV3IFFQIHRvIElOSVQgc3RhdGUgaWYgaXQgd2FudHMgdG8gcG9zdCBSZWNlaXZlcyBlYXJs
eS4gSQ0KZG9uJ3Qgc2VlIGEgaGFyZCByZXF1aXJlbWVudCBmb3IgcmRtYV9jcmVhdGVfcXAoKSB0
byBkbyB0aGF0DQpmb3IgdXMuDQoNCg0KPiBJZiB0aGUgQ00gaXMgY2hhbmdlZCBpbiB0aGUgd2F5
IGRlc2NyaWJlZCBoZXJlLCBwZWVyLXRvLXBlZXINCj4gcHJvdG9jb2xzIHdpbGwgYmUgcmVuZGVy
ZWQgdW51c2FibGUsIGFzIHRoZSBwYXNzaXZlIHNpZGUgY2Fubm90DQo+IHJlbGlhYmx5IHNlbmQg
dGhlIGZpcnN0IG1lc3NhZ2Ugc2luY2UgdGhlIGNvbm5lY3Rpb24gd2lsbCBoYXZlDQo+IG5vIHJl
Y2VpdmUgcG9zdGVkLiBUaGUgTVBBIEV4dGVuc2lvbnMgaW4gUkZDNjU4MSBkaXNjdXNzIHRoaXMs
DQo+IGFuZCBzdXBwb3J0IHBlZXItdG8tcGVlciBjb25uZWN0aW9uIG1vZGVscyB3aXRoIHRoZSAi
QSIgZmxhZw0KPiAoc2VjdGlvbiA5LjIpIGVuYWJsaW5nIHBhc3NpdmUtZmlyc3QgVUxQcy4NCg0K
QXQgdGhlIG1vbWVudCwgcG9zc2libHkgdGhlIG9ubHkgcGFzc2l2ZS1maXJzdCBVTFAgaW4gdGhl
DQpMaW51eCBrZXJuZWwgaXMgUkRTLg0KDQoNCj4gUG9zdGluZyByZWNlaXZlcyBhbmQgYXdha2Vu
aW5nIGNsaWVudCBwcm9jZXNzaW5nIGFzIHByb3Bvc2VkIGJlbG93DQo+IGRvZXMgbm90IGNsb3Nl
IHRoaXMgcmFjZS4gQSBwYXNzaXZlLXNpZGUtZmlyc3QgcHJvdG9jb2wgd2lsbCBoYXZlDQo+IGFs
cmVhZHkgYmVndW4gdG8gc2VuZCwgcmVnYXJkbGVzcyBvZiB0aGlzIHJlYXJyYW5nZW1lbnQuIEl0
J3MgYW4NCj4gaW5oZXJlbnQgcmFjZSBhbmQgd2lsbCBub3QgaW50ZXJvcGVyYXRlIHJlbGlhYmx5
Lg0KDQpTdXJlLCBidXQgYXMgZmFyIGFzIEkgY2FuIHRlbGwsIFJQQy1vdmVyLVJETUEgdjEgZG9l
cyBub3QNCmhhdmUgYW4gaXNzdWUgaGVyZT8NCg0KDQo+IFdoeSBjaGFuZ2UgdGhlIENNIEFQST8g
VGhlIElCIHNwZWMgaXMgbm90IGF1dGhvcml0YXRpdmUgb24gdGhpcywNCj4gYW5kIHRoZXJlIGN1
cnJlbnRseSBpcyBubyBidWcsIHJpZ2h0Pw0KDQpUaGUgbWlub3IgYnVnIGlzIGRlc2NyaWJlZCBp
biB0aGUgbGluayBhYm92ZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoNCg==
