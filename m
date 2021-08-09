Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E473E4AF5
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhHIRhy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 13:37:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44232 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233847AbhHIRhx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 13:37:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179HWGVZ018171;
        Mon, 9 Aug 2021 17:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zq/W0V67XGKsPBsdtBFUmlKyHOEEw5khENuScYX1IDU=;
 b=oCrue/C3ZDHL8iGbl/yVRzyRRaOjIPtfMqkWrPf1AZIfJqOMHXoRSYg4stR2TKiBnZaZ
 1FknEpQPAEB2EHCPKHGR5tlbMIfn3EXEtiJFzqGmPEIVdi930MFQoNZ4E4NP7J0Uw6Le
 JVYnC4wzpmJDZeebl94Mz1B+iCAPPoF2ktr5p5JYijTDWL5k2v08s27pUZrmnuNS/sgb
 8kMHrxYpnQO+2ob+XqPb7Ei+wobSuR3l1/XIiwtpOYP2tlD/dpVW4QjJqq8A3d0Rw7tL
 xgZrcC768zKl01+SPSx8XnaXD6kiZopOQf/BzflV2rWbZVJeoWURdLIGEfvfnCdIIgqI Gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zq/W0V67XGKsPBsdtBFUmlKyHOEEw5khENuScYX1IDU=;
 b=jEADK39YiQ0+v12KW/20rZT3JcbE9skhdWH90iU+ouD6fw8cqB1CoROzXya3zwq1IHq5
 I6NUws4SEznCEeLneUnpkfuJSp6g0Ro2zUDCZeWx3ldXUk5Sy2zGfm7+drJFwk5XPoN+
 fIDDmhKpyb6MEEGlCazfRinWK7p1bBfgFJFL9fA3oczHFqL6nQnjM51H1aEBubvl4sJ6
 SZr1u6FCTmRQoxAEdVa1TlzGd7yrTNmpeoViWOK+MVdYLNKoz4XyKx6nSBTGM4qvNhBx
 x26V+wAKi9rQr3tJ7bRRSHR4sDtHkE8aHJhCtg9XTFwrmbHPzqDdfxrQA4q17EV/VAcp UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaq8a9xk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 17:37:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179HaQYw186006;
        Mon, 9 Aug 2021 17:37:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 3aa8qrpt3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 17:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv7aAJBbObQTCH17qmI2saASRvzZsAasm2znkwAOGZblEHq2b2S1spM8B4IOnw7PX84f7KZNVpIYY1q+Ea+BJX5z//R4HZoQdRLkIgpkqRrLjoDKcwKCKwSBrI5J6enLmk+tNINZRUzR6WvTiDCw/+N0VTwL4cTQDlF8mIYkC/AhZ322S6xb4eRh6JiFNx+6FvqOE9e84ny04eqj0MdOhT8GY9CAXb/VsK5P656ygDxCeBzWGmypr4Ag1jAf5xe4wAxny0GNMVPilu+nsg7ZE8XSqCmnC/dALE+EnYPk9R78l1kEjXRJg0D/NisB7iFtxEE/SKukdrnuR+IsGo2tgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq/W0V67XGKsPBsdtBFUmlKyHOEEw5khENuScYX1IDU=;
 b=gBwkFekUDbxPMgUR0tb4X0rA7vn8dxOsWViYOV417LF+W/o7vQLOqqtI+gnYcyp5qDMwm18LNS1AXma9Z96Rqxok8CtF2KrUMpQdBumb8a1AvEsXwvld6nqd3Zv1wQLDBFIdH+XVcdZNy37Qds3Hkx1rEyqJWoZelMfdMhuktr/GCim1YsNHlgrXt1gMCB2vzuK2s0uXqAAtDLrwSAVCjn0GXFIM2opKFpAqmidaIfJZ8oWn8DP1hA7cCI3TY/jpJ98avJ+dGvh+58vUWNt6OF3jZYZqhB+eckDaG8rtNZcMQ/G624+tGg5iAhHt9M6OlqkpmWqCOGWGwbbueKcgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq/W0V67XGKsPBsdtBFUmlKyHOEEw5khENuScYX1IDU=;
 b=Ioj4dVfp7znl1K4HjguYT2aP+MTBbeWhWnszNXcaEpMFSEUpGImlxwXwc4ouCgBVVYtrUMfNePpwMTmMJOAFFn5pZ4fEYWGKb2L3Fje/i69lwiqCCt+kGr3OzkndLMWAhmHEkkdHv8l651Kot8BuWc4t/qRxwME/T3SvhJSgOjI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3670.namprd10.prod.outlook.com (2603:10b6:a03:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 17:37:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 17:37:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "hedrick@rutgers.edu" <hedrick@rutgers.edu>,
        Timothy Pearson <tpearson@raptorengineering.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRnsuG+zO3JoCWACAAAPHgIAACdwAgAACeYCAAAYTAA==
Date:   Mon, 9 Aug 2021 17:37:19 +0000
Message-ID: <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com>
 <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu>
 <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu>
 <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
 <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
In-Reply-To: <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rutgers.edu; dkim=none (message not signed)
 header.d=none;rutgers.edu; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d234070a-c9b0-41f6-6bba-08d95b5c5674
x-ms-traffictypediagnostic: BYAPR10MB3670:
x-microsoft-antispam-prvs: <BYAPR10MB3670E0F58FA08BF9767ADE2F93F69@BYAPR10MB3670.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7d8Y11i30rENr2pXJo3olasy2RUSvA2uBHPDsJCe5DbG58H1/B7FRm4rC4LBiQiOsmnPCz+Wmoe+UC5K4Va0WhaL46+4/8NVSnmv0ecbAFGz0POeRGOWbFLFN2rugl+1xuqZXoehXbzWeKNnEzFiW9e6sbOehJHY2yHkxisgfKHTDRYiq/jsRFgT6ySe1vjW43a8L7DuYoiSijiEUE2pdA/iaFIHGQjjQzIWB7zzquu2aEiyyJ/MrlZTHP/ITXI1K6q7dJdV/ioOESxpIDfWu4NB35tjScMQChO7Dpdt675tHwGgEEuVnfzi6KQfjtKgxjtgNJ/ewtLEEiscMJ1XWIh9vSUOexL/do+/ICKZALtb1WmyMaAF03I0lcouesZu8bYrrcdkhcJsjB3oZ/v+lV7H41wRjUFjsKzLZEyhbzbXnwYLTRVLWnWJ3wRTAbf1t+cQBsteruv0XhOm8EhKPncGmSMTct0VerOyBPXgTVKYofHN5je9zBT5hygqQdyO+USD6ICYq9FcDm56m4hoLS+xBinakx4EKhPFa2Qlg0EObcsyCGL/dhT+76kU5R6lK3q3TV3YPZvr7p3AHMQaZDXF7f3MoNQ4/ZjKPm6V1n0MoUgHkV7l7hzTbt9Ko3Em7QueaxPjuLv9Z6NNyiLf0EjLBbWzwBIA3l8QsMsb66n3I3EYvjQGiDyOmELxYJ9odqjTRpfqB9ELSAEx3aUkfHKHP5DW8opRX4PByQ2Vj7QyDoWiVyL6zSW+W4LwgHR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(366004)(136003)(66446008)(91956017)(76116006)(38070700005)(478600001)(66476007)(66556008)(4326008)(64756008)(186003)(53546011)(6512007)(66946007)(2906002)(71200400001)(86362001)(6486002)(54906003)(110136005)(6506007)(8676002)(8936002)(2616005)(316002)(33656002)(83380400001)(5660300002)(26005)(36756003)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFQvVDBsSUs1bWYzWHRZSGtkN1Z1QThBQzJBREl2MWoyRWFnN0NzdUlVdkV5?=
 =?utf-8?B?MjBQVFJ2RXRUQ3hIY3BmaWdwTlpCL1FqQXkwZ2drWDRCVyt2WDZLR0dOamkv?=
 =?utf-8?B?M01JY1B3eThSYUJ6Z2NNeUdQekRHVTlJYzk3emJLZjBocE9PZWVEeDVqTThq?=
 =?utf-8?B?QkVqeU9ZUlErcnJtcDgyaTd1YjVYU0NtdmFNQklBMXg3dTZFV0tuUkxtMTBW?=
 =?utf-8?B?dXEzV0JLV29kektqVTR6UFNyZDUrRm5uOWRrcVRLcDR5NGh6U0NIZmcxWnN1?=
 =?utf-8?B?ZkE5SFF3NnR0RFh1NEZvd0pMMHFHcUNOYUNTNXZTK1dZOU5ZMjhSRXdHUWQ0?=
 =?utf-8?B?YmtFMDkwWkRDUHFENGJHdDAxYXY2VlRuOXJtbUpvbmVMT2ZFaUZaVWFPMWxF?=
 =?utf-8?B?R2JIVzN5Yk1lQlc3enc3SjlXKzRVOTdRbGNyRmxtaTc2ZldkTkxrSEFlZ1ZK?=
 =?utf-8?B?TkdVd3VyS0pHdndpaHlQMUVScEZ5TWhHMkpGdFo2TlgwWWdaTWR4VFdSQVdR?=
 =?utf-8?B?WWd2STI4R1hQd1puOTZWNGUySVZqR1QrelpKeXVnRFp4QWQ3NEd4YmhQL1Fo?=
 =?utf-8?B?NCsxbDFHZm9iakFSNXQzcy9MczFOQ3hHZFB0OGRIVWcxT21jeWpaNVQ2MENE?=
 =?utf-8?B?NjNEYVNnZ2FYK3FWYWFlVnd6NUQ1RUxza21UMUFyOXpacnkrRDlOMUpQOEts?=
 =?utf-8?B?NGQ3N1VsWkEweW40RXI1ZG9aazN1a25uL3BpZGJjWFRab3QvZDR2TGtTb0hx?=
 =?utf-8?B?VnZNVE1ZdEFLN3p3TjEzQ1RBUHgzQUkwaHI5M0MrTlVmVWVuTS9CU0phZkxh?=
 =?utf-8?B?dlFBakdKNnJNeUNLSHdseTNOQnJRc1FDVWp4ZCtHaXlVamdrT1piMHJBUE1J?=
 =?utf-8?B?ZHF1emxFb01yelgySDJ0VlUwYTY0Mk9WV1lib3hNTlIyZXREWkViWkxGdU5i?=
 =?utf-8?B?cGpSMC9yRnhvdTVQYUlWWmdkUmZ5dXE3M1BlaGJvWndrOWpOZ1RaWlFuOWhL?=
 =?utf-8?B?TllzNWprT0NpdlJmQlUrZFJEQWE5Wmx3QktsVHBlQ0FobHEzLzZZZnhGZFE3?=
 =?utf-8?B?eEFXc1BTelV1dGlkZG12NVZiY0YrVFhQSHJJTGh3WjNnVXZyL2oreUtLYm10?=
 =?utf-8?B?aXFwekZJb1QyNnd5Z2paZ0ZodnBmd0lyQjV2STFrWmdYYnprL1ZCeDRldTRI?=
 =?utf-8?B?TVY5NWJNb1dsdUJKV1RGWFRCazd2cks5S0dvVGNBMGhGUlRGdmNQU2pSM29l?=
 =?utf-8?B?WkJUMTJSNzAvZ0FCUC9KUTVSZkNnVi8vQnN6MHJuQ2RtRHptaVpoNzEvd1Fi?=
 =?utf-8?B?am1PZkxuRWhubU1uSThRVmRIVHZVVG5DR1U1TitHcDlWWHdXRzNuUmw3eVZ2?=
 =?utf-8?B?VjRyVEcrU2RjbjJ0N3dvcndWYVpaL1ptN3B4L2dXS1hiRGRkdnZXZTFTNTlW?=
 =?utf-8?B?dzJZbG5tanFxclErdVRXNzFBSkhLZFR4OGhKdnl3anQyM3BFS080NXdJUFY2?=
 =?utf-8?B?RGxoUndTU3FGUGdndFJTV2RzRm9uU0M4TWpsa0N2eCtLeUora1dNT3I2K0RQ?=
 =?utf-8?B?Q1ZjMlVRWVNFR1Zlc3Y5UHd5WnMzeUxMREVQRVJ3Y0JrUHJWMm5lQkNLcU0x?=
 =?utf-8?B?a3BzVkZKZ2p5NlM1eFhkQytLRUIrNHVZVlI4SXNWMUZIY3cyVENKVVNkVDRv?=
 =?utf-8?B?M1pxZkUwZUlLbzBhRUswdEltL0RBTjY3SDNsYld0RVUva2ZyRzBEajZ3Q2tX?=
 =?utf-8?B?cEcybWhneVlVSWdOOUNxcHNIRE5JaDdnbUFzNCs3bzNBUzAzOFpBSU5GUzQ5?=
 =?utf-8?B?a3BMaWNzY3B3ZXFVNThWZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F31E593589368A4A8086E5276544B96E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d234070a-c9b0-41f6-6bba-08d95b5c5674
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 17:37:19.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YoNywR1cPP0f6v9ERedAx+KfKH/WvgQy1G4/ZgFuDNB3ymn4e9x8lyKffF7Irhfx0p+fomjTqi4cKe9GJY5dBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3670
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090124
X-Proofpoint-ORIG-GUID: -c7Nr00xqdvE03vWjLi9pcmaf1ac5zFg
X-Proofpoint-GUID: -c7Nr00xqdvE03vWjLi9pcmaf1ac5zFg
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXVnIDksIDIwMjEsIGF0IDE6MTUgUE0sIGhlZHJpY2tAcnV0Z2Vycy5lZHUgd3Jv
dGU6DQo+IA0KPiBUaGVyZSBzZWVtcyB0byBiZSBhIHNvZnQgbG9ja3VwIG1lc3NhZ2Ugb24gdGhl
IGNvbnNvbGUsIGJ1dCB0aGF04oCZcyBhbGwgSSBjYW4gZmluZC4NCg0KVGhlbiB3aGVuIHlvdSBz
YXkgInNlcnZlciBoYW5ncyIgeW91IG1lYW4gdGhhdCB0aGUgZW50aXJlIE5GUyBzZXJ2ZXINCnN5
c3RlbSBkZWFkbG9ja3MuIEl0J3Mgbm90IGp1c3QgdW5yZXNwb25zaXZlIG9uIG9uZSBvciBtb3Jl
IGV4cG9ydHMuDQoNCkEgc29mdCBsb2NrdXAgaXMgdHlwaWNhbGx5IGNhdXNlZCBieSBhIHNlZ21l
bnRhdGlvbiBmYXVsdCBpbiBjb2RlDQp0aGF0IGlzIG5vdCBydW5uaW5nIGluIHByb2Nlc3MgY29u
dGV4dC4NCg0KDQo+IEnigJltIGN1cnJlbnRseSBjb25zaWRlcmluZyB3aGV0aGVyIGl04oCZcyBi
ZXN0IHRvIG1vdmUgdG8gTkZTIDQuMCwgd2hpY2ggc2VlbXMgbm90IHRvIGNhdXNlIHRoZSBpc3N1
ZSwgb3IgNC4yIHdpdGggZGVsZWdhdGlvbnMgZGlzYWJsZWQuIFRoaXMgaXMgdGhlIHByaW1hcnkg
c2VydmVyIGZvciB0aGUgZGVwYXJ0bWVudC4gSWYgaXQgZmFpbHMsIGV2ZXJ5dGhpbmcgZmFpbHMs
IFZNcyBiZWNhdXNlIHJlYWQtb25seSwgdXNlciBqb2JzIGZhaSwgZXRjLg0KPiANCj4gV2UgcmFu
IGZvciBhIHllYXIgYmVmb3JlIHRoaXMgc2hvd2VkIHVwLCBzbyBJ4oCZbSBwcmV0dHkgc3VyZSBn
b2luZyB0byA0LjAgd2lsbCBmaXggaXQuIEJ1dCBJIGhhdmUgdXNlIGNhc2VzIGZvciBBQ0xzIHRo
YXQgd2lsbCBvbmx5IHdvcmsgd2l0aCA0LjIuIFNpbmNlIHRoZSBwcm9ibGVtIHNlZW1zIHRvIGJl
IGluIHRoZSBjYWxsYmFjayBtZWNoYW5pc20sIGFuZCBhcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGF0
4oCZcyBvbmx5IHVzZWQgZm9yIGRlbGVnYXRpb25zLCBJIGFzc3VtZSB0dXJuaW5nIG9mZiBkZWxl
Z2F0aW9ucyB3aWxsIGZpeCBpdC4NCg0KSW4gTkZTdjQuMSBhbmQgbGF0ZXIsIHRoZSBjYWxsYmFj
ayBjaGFubmVsIGlzIGFsc28gdXNlZCBmb3IgcE5GUy4gSXQNCmNhbiBhbHNvIGJlIHVzZWQgZm9y
IGxvY2sgbm90aWZpY2F0aW9uIGluIGFsbCBtaW5vciB2ZXJzaW9ucy4NCg0KRGlzYWJsaW5nIGRl
bGVnYXRpb24gY2FuIGhhdmUgYSBwZXJmb3JtYW5jZSBpbXBhY3QsIGJ1dCBpdCBkZXBlbmRzIG9u
DQp0aGUgbmF0dXJlIG9mIHlvdXIgd29ya2xvYWRzIGFuZCB3aGV0aGVyIGZpbGVzIGFyZSBzaGFy
ZWQgYW1vbmdzdA0KeW91ciBjbGllbnQgcG9wdWxhdGlvbi4NCg0KDQo+IFdl4oCZdmUgYWxzbyBo
YWQgYSBoaXN0b3J5IG9mIGlzc3VlcyB3aXRoIDQuMiBwcm9ibGVtcyBvbiBjbGllbnRzLiBUaGF0
4oCZcyB3aHkgd2UgYmFja2VkIG9mZiB0byA0LjAgaW5pdGlhbGx5LiBDbGllbnRzIHdlcmUgc2Vl
aW5nIGhhbmdzLg0KDQpMZXQncyBzdGljayB3aXRoIHRoZSBzZXJ2ZXIgaXNzdWUgZm9yIHRoZSBt
b21lbnQuDQoNCkVuYWJsaW5nIHNvbWUgdHJhY2Vwb2ludHMgbWlnaHQgZ2l2ZSB1cyBtb3JlIGlu
c2lnaHQsIHRob3VnaCBpZiB0aGUNCnNlcnZlciB0aGVuIGNyYXNoZXMgd2Ugd291bGQgYmUgaGFy
ZCBwcmVzc2VkIHRvIGV4YW1pbmUgdGhlIHRyYWNlDQpyZWNvcmRzLiBJZiBpdCdzIHByZXR0eSBj
b21tb24gdG8gZ2V0IG11bHRpcGxlIHJlY2VpdmVfY2JfcmVwbHkNCmVycm9yIG1lc3NhZ2VzIGlu
IGEgc2hvcnQgdGltZSBzcGFjZSwgeW91IG1pZ2h0IGVuYWJsZSBhIHRyaWdnZXJlZA0KdHJhY2Vw
b2ludCBpbiB0aGF0IGZ1bmN0aW9uIHRvIHN0YXJ0IGEgNjAtc2Vjb25kIHRjcGR1bXAgY2FwdHVy
ZSB0bw0KYSBmaWxlLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg0K
