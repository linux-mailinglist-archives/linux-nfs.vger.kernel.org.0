Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED14F47C7E1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 21:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhLUUAJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 15:00:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31148 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhLUUAJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 15:00:09 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLHKBhA015422;
        Tue, 21 Dec 2021 20:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1ql6tVIIwbuvA9ogtvebSYPqvmxUPEo79TspA6vdQNw=;
 b=g8/qEM2p/yz4sm5GrHDhQ6eDaMcfVySz8uSecOzjL+3V7znT6+xlEB2eC7FscRrTMume
 nC3jnZ4PLV0MQanpTacPiGNL9axGFy3tTOxylDXaOWdRDumFN91Zv3k/9SCrL3y8Lie7
 bzeBaQnBtThSKkdrF5qqJsNxjjpyGwJP77e2PANDmQ8ECXxKiqoFsZYK0uktI26uZis1
 +jTp61tFCUuQvBu8nO33RAKSRwIVoDjGLk+2HTA4AhqkXHnWAOW0gIlkBG2Pk/wgc1YL
 4yMhsT8zBd5IV+sN4GGBJgiUMg89P5TS8TVcWFyxB0R6Y3qMprqqunehYdW2XBMtTKMg GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2qpd473p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 20:00:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BLJonq8173955;
        Tue, 21 Dec 2021 20:00:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3030.oracle.com with ESMTP id 3d15pdpqwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 20:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ef7/C4pRba1TY5DkUNAlfzfQTnJ6yvEar0fpRTIpU0gTKtTtLonXJ3XsEnyP6CqLU90WVuHT/9OjssNp8TVWFvcx1O1xNCYAxGK+czLeZ5DTpT0E1unRrvOiVIzW1d6RIeiSN7c5kPFkqmCeoGdSZcm5RWTsEDTFccdpsd3FKI8Zm6T4K4ByP3q+vFaOqreKb8L8X2uUJksnnibHWC9Ap98YI1/sUiMxf3W3ruXKZqLoM3jwCEt3aFnk/yuCARb9jtZ0LjA/BALx1i4oe59AoqgaIECWkw1eI288ePoxPPh/LqOd/XsGFyzAtP8jWAIv+1PPODTXwUJcb9PGeiRiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ql6tVIIwbuvA9ogtvebSYPqvmxUPEo79TspA6vdQNw=;
 b=RRVpfFdF8arxu1oV33s+mZ5+H9bn1LLzvQhw3O4BY7x6pOIYOLp0dzzFpaIaDyIVMaThS19TgOpY6sxvD09waA1mYVjx5ABz82SOpHcB0RW/Te8RIQCoVmsg+DBFDr+llzcS7/dwJM+Lhj5v+WujCuhRc8EH+gtSvy6Q+g4QbZyphQnQ/3g2gBMDU1xYS4TyP/8TdjHcqBSmgtWarX8UzYvejGhWDilqz1kI8EXuHZGsWb3+9Ty7ZEIxs3VnwiP5539K5rmB4Neb0+YTntltFIqzRyDOsMFkksqh6ZAfWSBbZASyC7YUbFHbE2Exp6WQguMcfpkppmte2OPys/8aTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ql6tVIIwbuvA9ogtvebSYPqvmxUPEo79TspA6vdQNw=;
 b=DPe+YugH2du6ZapthyQbMQcUJlrEUwtrVhcF8ZRoA9o/9T9v97m/DHurwObbfhPy1nL7mHuoEhzF1bbmwMovqBaEggaQhoLn5hbOe6SVSSHrgtO6gWEYFVfHD5CT7zeh9xlj4rlJ9DKcoL7gglQJn5t+2SPbpm6encwFzJbz7bI=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 20:00:01 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 20:00:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] nfs: check nf pointer for validity before use
Thread-Topic: [PATCH] nfs: check nf pointer for validity before use
Thread-Index: AQHX9pxedgjax2OgckSGsJxm21wKzKw9XXIA
Date:   Tue, 21 Dec 2021 20:00:01 +0000
Message-ID: <05877B02-900A-4B22-9460-D2F0D20931DC@oracle.com>
References: <YcIjJ4jN3ax1rqaE@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <YcIjJ4jN3ax1rqaE@debian-BULLSEYE-live-builder-AMD64>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1109de7b-18e8-4e13-c9c3-08d9c4bc7930
x-ms-traffictypediagnostic: CH2PR10MB4279:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4279134F253C7AA584040058937C9@CH2PR10MB4279.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxEqIFbzgM9EIB5UGrDqimTgz8sshu/RC1RZeHWZGAPCiTJUXi/aoPTkry4pb8gfvzVnzYgRPPz2cZB1QUEmIUY8yzwNtH9lnviXyWR8sGte34i6Mij4byH9hG5IAIE9ADkShczc4oGrqiHJIjYHf43pB9t3jHCzD2q7AzNILoZSSrdqYL0XE3jPyBRSwLaooqRTuWSWr4ICX7yNbGH5uJI21pEleVB4ElAaSaK3oL7djGSbRXmaqdIl4SX2ZacQB+m03UP/xlYL+9x2VVCBMh+UCzdiPEer9OqWS67V8kPd9kpQAIkaIMxHIxcAAfJntxbDjHaCvf2L8zS/d+fkDYKJz/R0ghWpF3NBwdcyL4qag8JUOmgoIgi/9wZFjRB5rlI7YrfXJp48Eqmb4PHioy25TXgikJxq6fyAFgPPwATk/W2GLjYlbHAnHYtKLxONpc1xB0duLJJAjbziRiiTtG2ccEeJhyZ7XTtoex5aVzostoGo9iEdq5A4EA9NbieOdjsxGoKJpVlE+3mKr1QJ8Te7g0kGqjDeqUe9CGy1dSY9FmJHL8ZRWDqerE95AzRaA8HbfCeA4nELPWYIsF6Gxuz2eIFEHgxvwXFkq9eYgJKSUoB2gH0D11yR1OFMePYhxuVZcok7BslZu6oxq/GMsEAiBmo0TCUO8rdTQXZTsyULr6TozEVkt+NDwNeKVaeSk+DzElNa3YzMXXyp32bAg3ep6+kSQbT6JaFCrhY3cQAKsnvfsm/nafMtxWWP0XcLdgjQk6XxjTsjwymL44FZkN9tX4kEKrYBUUX9xLBEmm2XyUASxnw/WZw6CgiKwNwMMuJZZV4lKNeLhV+L8zWyJngZkStFPlSCeKqhp1f+tyo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(33656002)(38070700005)(26005)(6512007)(2906002)(6486002)(36756003)(966005)(76116006)(53546011)(66476007)(66446008)(54906003)(316002)(8676002)(86362001)(8936002)(84970400001)(186003)(71200400001)(508600001)(5660300002)(4326008)(2616005)(66556008)(64756008)(66946007)(6506007)(122000001)(38100700002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlJhUTh6Z0Q3WjUya0s1bHFxMEN6V1lKTk84ZEx0Qk8zcTJDK2xZK0I1Rkhj?=
 =?utf-8?B?czhPOUxMazdZZ3hjanQ1WW1XMTRCUmlXV1htandVMTdlN0lUdkd3UnNWMEoy?=
 =?utf-8?B?K3A4clJUL1FjRk12TGl5VXpET0VuNUJmVDNKMGJTbUFCYUQrZHJVMlp1eVhR?=
 =?utf-8?B?NHhaU0FzcFpDUmhDWFlpU3B0WmlkUnF6bFM2SDBUYkdqWUR4bTN0YVUrYW1Z?=
 =?utf-8?B?OUNoYzZsK1hJUFVzMWlNSGM2ZVN4QTZBNjJza2lHcWc3RzRoU0d0Z2dyWFBp?=
 =?utf-8?B?SXZCQktyNlJ5L01CT1FGZUFkTDBlRDBHVGVvc3hxdGtOQWhjZS9nbWw0cW5W?=
 =?utf-8?B?SkMwZ0U3OUgveGxQN25yT1lsb3Zaam9PZWRyT1RmeVNtNnFVUVU0azJoa0VO?=
 =?utf-8?B?OWhhZFduSTI5ejRXN1hHbFk3YWhpNGVwTDNtOTgzaXl4L1RRNzNXZlp6TEpN?=
 =?utf-8?B?ZVB4WG9BTHJua0VLRGpYYVJZSnZ4Q21XK29uZ1h1ZnVOZTVCOWJwRXF2Uks1?=
 =?utf-8?B?V1F3QlVZOWpNaU5yVGVTZlRmOXNDYjloaGZGVXI0U0R6N1F1SGNVeVhPNnUz?=
 =?utf-8?B?WlRtQTV4TjVid1lOdnorT09KajZvRy9yZUNJcEVXTnJCZEtYQURWL21rYjlT?=
 =?utf-8?B?Ry9ZdjhaczZYNWY4OUpMT0pTdTh3ZUtyU1NGd2piR3RLWE5HZ29PVWN5ZG5B?=
 =?utf-8?B?OWowRjRNTGR5Q29zcHJ2TmpnNTFZZ2lkUzIyS1lwbTI2SHZXQmRDN21meTc5?=
 =?utf-8?B?cHJIbWcrQXkrd1ZmeURpYnlIb25LTnBpWjk2TVFrVGZHRHZMTUxzYTFiYVBG?=
 =?utf-8?B?bW9QMEJ2bVA1UXNZTzBDNit2RzlwdWl5RXRWaGlmOE42NHJkalZWZ2xiczlP?=
 =?utf-8?B?S0JnbkMycXhoZVU5SFpDZHhxZ3JjRExLWHBDVGFpRWRzVVFsaWFUVmFKTlZ0?=
 =?utf-8?B?dG00Sk4vNk5VUDRaOCtlYzJ4c0NQdHR0TXgzeUcxSU5LWWZDb0JIUkhzRVYz?=
 =?utf-8?B?VzNLMnl5UTRNRjVuMkhVeTVYZVlQMGZrMVNETkE1cUVXS3ZISjgvOVZ5WWdU?=
 =?utf-8?B?Q0RLUWk1Sk40eWhNQzJIc093akRNVVNkckV4MlhKaWkzWWNxZ2JHYzM5UnQz?=
 =?utf-8?B?dkJkaFVpOXhLN2NkY2tDZy9ZMVdsVVRCZm4yV21kOVZLTTV3RUVPK0pOR29w?=
 =?utf-8?B?ZExVd01EejZ5aFEzVEIxRTVMcHdqaHErZHNTNFFtNk9GWEJnUWFIUDlzdmtm?=
 =?utf-8?B?alg3bTIyM1U3MHJMSnFxU1I2ckNIcDdxNzU1RTFHSzIxT0dycFRFNGpHcVlW?=
 =?utf-8?B?bzl1d0RCOUlJWHcra0EzZTFPV1FFRWNFbWd3c0hPZkpXWDE3N1F0Q3IyVm05?=
 =?utf-8?B?d3BlN2p3eHlXZXJUelVOMHZZUnlJTzBibVVRWXgxaEpBUVg1ZS9WdmRUeE52?=
 =?utf-8?B?UXZzQVg4WFNJOTdNS0pJQ2JOSWtnTmd0SzVGYWNXSzdOZ1VGY0FSV2pTZUp0?=
 =?utf-8?B?MWxmWWlpYnlINklVQVJIVzBuTlVPNTN6dmhwcldydTFMaVNMaEF6LzUzbytS?=
 =?utf-8?B?MEp4cHJMM01VdCtyK3NhL3FyR3lXRzBTcXdHSm45WWx4UDQyMVp1SDBtdzF3?=
 =?utf-8?B?QzBPM1Z5UC9Wd2s4cXRRMFlBb0UyZmdhTDFCbnRldGZUQ3JPMzFXei8wc1RW?=
 =?utf-8?B?RjFhRTZEeW1MYVNidVgyV0dBeGxTaHUxcmI4MytNRDlrUHprYlJKeWo2dElk?=
 =?utf-8?B?eUlSSU1BYlBYTmppUHdwWkFjS0twV1RCQ3hLWnlmNzNqVGM1dFRMWWhXeWlh?=
 =?utf-8?B?RTAzNlZ2VmliKzBKVk9KQmlReDNqZDlGN0Q0Z1I4dFBPNkxGdlJGWm44cmNr?=
 =?utf-8?B?b09scG90VHZIVXUyVEd2REZYQmRKMk0vNFZtcVZrSXJOaEhFb2VXOFNESzQ4?=
 =?utf-8?B?ZjVHK3ZYVHBjM2tMVSsxNWkyMXU5Qzh3Rk8zbXl4UGxYVk5GRlJ2V2ljdU8v?=
 =?utf-8?B?MFJLb2VtRWhaVUN3d2tVTWQyWjNHVjJXcTNRMDNKbFIyU3hzT2RFd1IxRGh3?=
 =?utf-8?B?c0I5dzhpbjFxZkprSlhwZ1VLRm51R1dDSEMrY3psdmFVUisvcGEzQVU4NkY3?=
 =?utf-8?B?UVB5VmREMFpEZlFzV2FhRzNza3VjY1V3ak1TVytiS1JhbEt3cTVqMzFxbHlI?=
 =?utf-8?Q?0vivDP4dYoHEbTWebO/KIZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A66A43F57F551F4A8D7E989538D046E7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1109de7b-18e8-4e13-c9c3-08d9c4bc7930
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 20:00:01.4991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ShnyCwl3D7iKYpBItbb09OkP7mm75j0G3BI71SG3hcH0vdSpU0a7SRVPi/i4SDariln4i4jsTpqewnzo6NywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210099
X-Proofpoint-ORIG-GUID: oNNfksxz93rVb916xPBZb0z8K9EATDYu
X-Proofpoint-GUID: oNNfksxz93rVb916xPBZb0z8K9EATDYu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGktDQoNCj4gT24gRGVjIDIxLCAyMDIxLCBhdCAxOjU1IFBNLCBNdWhhbW1hZCBVc2FtYSBBbmp1
bSA8dXNhbWEuYW5qdW1AY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+IA0KPiBQb2ludGVyIG5mIGNh
biBiZSBOVUxMLiBJdCBzaG91bGQgYmUgdmFsaWRhdGVkIGJlZm9yZSBkZXJlZmVyZW5jaW5nIGl0
Lg0KPiANCj4gRml4ZXM6IDg2MjgwMjdiYTggKCJuZnM6IGJsb2NrIG5vdGlmaWNhdGlvbiBvbiBm
cyB3aXRoIGl0cyBvd24gLT5sb2NrIikNCj4gU2lnbmVkLW9mZi1ieTogTXVoYW1tYWQgVXNhbWEg
QW5qdW0gPHVzYW1hLmFuanVtQGNvbGxhYm9yYS5jb20+DQoNClRoYW5rcy4gVG8gYXZvaWQgY29u
ZnVzaW9uIEkndmUgc3F1YXNoZWQgdGhpcyBpbnRvIDg2MjgwMjcgYW5kDQpyZWZyZXNoZWQgbXkg
Zm9yLW5leHQgYnJhbmNoLg0KDQpCdHcsIGI0IGNvbXBsYWluZWQgYWJvdXQgY29sbGFib3JhLmNv
bSdzIERLSU06DQoNCltjZWxAYmF6aWxsZSBsaW51eF0kIGI0IGFtIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LW5mcy9ZY0lqSjRqTjNheDFycWFFQGRlYmlhbi1CVUxMU0VZRS1saXZlLWJ1
aWxkZXItQU1ENjQvcmF3DQpHcmFiYmluZyB0aHJlYWQgZnJvbSBsb3JlLmtlcm5lbC5vcmcvbGlu
dXgtbmZzL1ljSWpKNGpOM2F4MXJxYUUlNDBkZWJpYW4tQlVMTFNFWUUtbGl2ZS1idWlsZGVyLUFN
RDY0L3QubWJveC5neg0KQW5hbHl6aW5nIDEgbWVzc2FnZXMgaW4gdGhlIHRocmVhZA0KQ2hlY2tp
bmcgYXR0ZXN0YXRpb24gb24gYWxsIG1lc3NhZ2VzLCBtYXkgdGFrZSBhIG1vbWVudC4uLg0KLS0t
DQogIOKclyBbUEFUQ0hdIG5mczogY2hlY2sgbmYgcG9pbnRlciBmb3IgdmFsaWRpdHkgYmVmb3Jl
IHVzZQ0KICAtLS0NCiAg4pyXIEJBRFNJRzogREtJTS9jb2xsYWJvcmEuY29tDQotLS0NClRvdGFs
IHBhdGNoZXM6IDENCi0tLQ0KIExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvWWNJako0
ak4zYXgxcnFhRUBkZWJpYW4tQlVMTFNFWUUtbGl2ZS1idWlsZGVyLUFNRDY0DQogQmFzZTogbm90
IHNwZWNpZmllZA0KICAgICAgIGdpdCBhbSAuLzIwMjExMjIxX3VzYW1hX2FuanVtX25mc19jaGVj
a19uZl9wb2ludGVyX2Zvcl92YWxpZGl0eV9iZWZvcmVfdXNlLm1ieA0KW2NlbEBiYXppbGxlIGxp
bnV4XSQNCg0KVGhlIHBhdGNoIGlzIG9idmlvdXNseSBjb3JyZWN0LCBzbyBJIGFwcGxpZWQgaXQg
ZGVzcGl0ZSB0aGUNCmF0dGVzdGF0aW9uIGZhaWx1cmUuDQoNCg0KPiAtLS0NCj4gZnMvbmZzZC9u
ZnM0c3RhdGUuYyB8IDEwICsrKysrLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0
ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiBpbmRleCBhNTI2ZDQxODMzNDguLmJkZDMwOTg4
ZTYxNSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiArKysgYi9mcy9uZnNk
L25mczRzdGF0ZS5jDQo+IEBAIC02OTQ3LDYgKzY5NDcsMTEgQEAgbmZzZDRfbG9jayhzdHJ1Y3Qg
c3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4g
CQlnb3RvIG91dDsNCj4gCX0NCj4gDQo+ICsJaWYgKCFuZikgew0KPiArCQlzdGF0dXMgPSBuZnNl
cnJfb3Blbm1vZGU7DQo+ICsJCWdvdG8gb3V0Ow0KPiArCX0NCj4gKw0KPiAJLyoNCj4gCSAqIE1v
c3QgZmlsZXN5c3RlbXMgd2l0aCB0aGVpciBvd24gLT5sb2NrIG9wZXJhdGlvbnMgd2lsbCBibG9j
aw0KPiAJICogdGhlIG5mc2QgdGhyZWFkIHdhaXRpbmcgdG8gYWNxdWlyZSB0aGUgbG9jay4gIFRo
YXQgbGVhZHMgdG8NCj4gQEAgLTY5NTcsMTEgKzY5NjIsNiBAQCBuZnNkNF9sb2NrKHN0cnVjdCBz
dmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBuZnNkNF9jb21wb3VuZF9zdGF0ZSAqY3N0YXRlLA0KPiAJ
aWYgKG5mLT5uZl9maWxlLT5mX29wLT5sb2NrKQ0KPiAJCWZsX2ZsYWdzICY9IH5GTF9TTEVFUDsN
Cj4gDQo+IC0JaWYgKCFuZikgew0KPiAtCQlzdGF0dXMgPSBuZnNlcnJfb3Blbm1vZGU7DQo+IC0J
CWdvdG8gb3V0Ow0KPiAtCX0NCj4gLQ0KPiAJbmJsID0gZmluZF9vcl9hbGxvY2F0ZV9ibG9jayhs
b2NrX3NvcCwgJmZwLT5maV9maGFuZGxlLCBubik7DQo+IAlpZiAoIW5ibCkgew0KPiAJCWRwcmlu
dGsoIk5GU0Q6ICVzOiB1bmFibGUgdG8gYWxsb2NhdGUgYmxvY2shXG4iLCBfX2Z1bmNfXyk7DQo+
IC0tIA0KPiAyLjMwLjINCj4gDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg0K
