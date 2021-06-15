Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182E43A8424
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 17:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhFOPkh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 11:40:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22630 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhFOPkh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 11:40:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FFVY2x007386;
        Tue, 15 Jun 2021 15:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=OKK0NQ0dYKV0EQpPgbKmrERVLsH5A65Xjh14mQGo9FU=;
 b=Ve7FqCmpkOIErN4cOLLr2iA+DhVdE7+vOV0fNgIzZqZY9e5UHl+XkPIvou5WR50UdcWt
 2Fhi8E2LNSvXqDWcTuSCmk6YBm2rxDb4nj0bfamx21yggzwO/B4lgiqilYmpnWXYFbdD
 X9GruQDSNZQBqGa7Pmg7FhThM8i8ClXdO/XqcYlS79TKxmtBKIUUATDW4XtkzWOSlmBU
 Rsrvzz4r94KiWZ2gCR/GLYlns5qm0nJP+cqPiOUWghgtFul5fDvsrh9QMJefJx0xvBZG
 urOL6hd4v4LHmEfrvz+fuDp7fC6QGay/veHVBFZSa57MMkHX5WCxvMyVCXl2yFw3EbvO zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x9qruvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 15:38:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FFalm3047181;
        Tue, 15 Jun 2021 15:38:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 396wamm655-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 15:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1FUD9aVXP7ucpChRZjs7D8HMmwGxkjJd35I/QWMFRGEAF+uRHpWxshwVvhRftYfq47eVGveOZyZ9xli3ZuF31DkdSKfHWIOlX+3loP2BOeKGpGPdeT0CYp+QahqRLCF3zDnT86YnRQu3cSPAV1tcHt/0uB2x3ZeJ9k0oAUtQnDTAD0yprolP0MXMOddrEZ3FiDYT98J7BJrO0oKzkxJ48kPzfSbguUYTTqsudj3fG0A1vqKCIZ8WOsbggGLyNX+WepvfxjEO4InoBJpI77NaQOr2MVbrBjS79l1qopVNiB/QQTvCoXIn6zpVYOvrjE9KqadfEq8BF0MpsCadiSbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKK0NQ0dYKV0EQpPgbKmrERVLsH5A65Xjh14mQGo9FU=;
 b=PKnGcUK/ne0rUCNaJZ+5PuYrQm18mOag4Ij2GmPdlEGO/z/EYPi/LhmCeiMcWVC/XS4+ANSP1i4sUtiSRbL1bhIQAiGI9xUwYuho7ScEqZ7UA1QO7zxktT6WbIP092ZpXKtIh2cHOOdjK4/wFPURjD+ijjkKVoFt+x3oHdq/miyXWGBmvLkMJuBQNIJm4mDdswyjRspHOsSqo49vG+QybLXRtVH/OD+RZlim0uX3aC3HeENqbUOQOq3p3lyGOF4s4fP2SzIzAuv0/qaJxsRIrymmH5Oc0SKryLFFJxUuytoNJg57QvXx3CfKJM06CTJrKu96UGEQcmNE/a+RTqh9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKK0NQ0dYKV0EQpPgbKmrERVLsH5A65Xjh14mQGo9FU=;
 b=WBHIiyo1i3EL3bQRtqrZHkdRn9YoRLiStdsNRMIlW2s87WuFqBm3Mi97yFiP1e/M73KnH4vkw8hCj5w2zs6AHOArFCtSeMk0LyI7d71VCYv8+audp5kt08IEn0ARSCNuMK6rS4rjvOkXzfIPMDN+GLdws9js+0vR6Bb5sAkkZRY=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 15:38:22 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e%7]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 15:38:22 +0000
Message-ID: <3f7ee699-bbd6-9025-82b5-40c37cbb6d9c@oracle.com>
Date:   Tue, 15 Jun 2021 16:38:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Content-Language: en-GB
To:     "J. Bruce Fields" <bfields@fieldses.org>
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <91f1d7df-b63c-4aa3-cc03-a8e1cbb2ecb1@oracle.com>
 <20210615144724.GB11877@fieldses.org>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
In-Reply-To: <20210615144724.GB11877@fieldses.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EyukaTaDpE27ihNlR6U72maS"
X-Originating-IP: [90.247.86.106]
X-ClientProxiedBy: LO4P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::17) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (90.247.86.106) by LO4P123CA0012.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:150::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend Transport; Tue, 15 Jun 2021 15:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d32e662-e087-4cdd-9684-08d930139ba3
X-MS-TrafficTypeDiagnostic: BN0PR10MB4886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB48864D344EE770BF54F53168E7309@BN0PR10MB4886.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8jPQUenU8H3B8DLv5leJv6sTH+uI9Wz1C8mPSBowhGuLh1SQeLD0aGYRa3D/oO2y0JGCAIMJm8ZxdE9SQNmAieBtN5/nquZrNVL7TXqQPST3eV4s3q27rrCErMnhE9wt1uq1M2YJRUSmvXjJ+KeEjYkJWEYPDf+4ZccT2iBMkGd6Nmtya+u4EHSBkmzmerqmSS4nhmoRv0sjEGmSt8zyekp/u2ItbTcKcUwmGgVmSyFcaq/dp7apyy3Z1AjlpGvNmLWuKcGlnoQn3MBWmsgnwLCG/gvsNfcWyA3sl8SVrAqg5/WJh2xtQrXG5g5QlgmEvTWcWVWt3yq1s+4XDy2B0hDT0agua/7jC32NoKjlireiO9UqwLorZ9NKVC/R3pSjakpsERy395s6nOs/zgcTUQUH/aQh6VsVXrYlOY163hMNSjeJqR9znLctKjkAYPIjXpKcyudrVMNNAs5LM02dYXRVche5ZMcDvRVzl8jVsnipGZpeEcxnUA6DLcT0GG5OBUdrJbR9Oq5nIMt7hY0JEJOf1zRiLQ3xiYCQ8EjdxH4UilD16Pp+iNNdvVi+p9IlPZIIZsVzwEqGQe7XLRgpHkRhLX8YdCF7vYVGKBocn250vE7elcLYTG/o+ajQemRztY/LpcYR3HJNgBwPxfOs9wvJVXW8E3AbsAS4i/DFc3I7aFn+Yfd+hY1Ib6p/MwWLq/eGK2sIprtft6N/Z0jpgeA0Y+qfR23WdfH4UeY88dGgdxOe2kcBcRbjDb8vSZxxiZeDSlL1wYI719SJo9SfdrZ4y9jJLOEQOwZ2Dm41V4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(36756003)(83380400001)(38100700002)(6916009)(44832011)(33964004)(66556008)(36916002)(966005)(66946007)(16576012)(66476007)(54906003)(235185007)(5660300002)(31696002)(16526019)(4326008)(8936002)(86362001)(53546011)(8676002)(6666004)(45080400002)(26005)(21480400003)(2616005)(186003)(31686004)(6486002)(498600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkpaWkl2OUxKL2tKR3V2eDJkVFlKN1FNR3VzYS8va1FscDBnTUNzdEtETnpj?=
 =?utf-8?B?Z3pXTE5zUDJEM1BPbmpMWmoyTVpHT1dnOStGbzdyVjErekJ2b0ZicVg5aVAv?=
 =?utf-8?B?U01VS0JCTm1Cd1k2YStTalBtNFlGZDdidFFRZVVneGZIdXFTdlZ3VEpvbjVO?=
 =?utf-8?B?ZkpROEw3QTRBblFKVlYxdVFKVzdwWkMwUzBsaG9sdkRXaU1sWkF1NlJOa3Nx?=
 =?utf-8?B?WCtCNVcwOWtXc2NqK0RMRWhmS1gxakdYQXlna0tOTjB2L3dQeXM5NWJNckF4?=
 =?utf-8?B?Y3F3ZUhkQ0c5WlV1UStObzRsM0FNSUFydWdwNm04cnE2ajNIN0tWL0xvV2ky?=
 =?utf-8?B?YXJrQmZMVGRCbTVBNGRIU3NKZDdsWnYxbXB4S0cwaThmeWJHQmVHVGVkUitR?=
 =?utf-8?B?RXdyN1MyTmk3RVhCbDVEK0kvUXhiOTFSbXRPSGNHcjRTTEpySG85NUZMQnlH?=
 =?utf-8?B?c3hRWUJGNXU4UXZYTDlwZlNwTlRreVlDTWlvNlhQeGxJRm9sZ3ZwTjFQOVVD?=
 =?utf-8?B?OFdGWEZuL0M2QzFxQmhpL253NmxtWHpwaGFuTzBZSkVaVzRxYmtJSzhXdEty?=
 =?utf-8?B?SWNrUlg2TXpySUJrUEVySWl3djlCS3dMeDhXSE5CSm0zV0lPeTNvVUR4a2dY?=
 =?utf-8?B?N0xyMkgwaFhIb0lBV3JGRWdEK3JBMVl3Q1BUWWE4MTg1TlQxZWdUUXRtalpU?=
 =?utf-8?B?NGhqU1BVc0RXdEJrWG1KQitHR0grTmhiRFJUZ0hKWFNyMjlVa2ZHbDdMOXRp?=
 =?utf-8?B?bmdjeHJIcGJTZW9MRE5XREp3YnJwZy9YQy9jaWpiZDdvcGxOekhCMTNGeG9h?=
 =?utf-8?B?VjFTTERCSjBnTyt5Y0Jkb1FkT1RudjlMaHFseHdZY2NRU3M4ZFRwcEEyVU04?=
 =?utf-8?B?TjVjdUw0b3RiejhWUWtCYWRRZS9oVmg1OHlpcndDeURMVTFGK0NWRHhZdnBs?=
 =?utf-8?B?UXlQcFpBUWh0c3dYVGtqUjZBbEx6cjd2ZXpxSnJsOFZpeThiWEJQL2NQYUJN?=
 =?utf-8?B?SHgvSG5Yczc1UUZuREp1ODQvQ01FUHd5RndUM2U2YmkxNlBsMlBHd3A1TVA0?=
 =?utf-8?B?K0RCbmxNbjM2dTJ0TU1mVThhSlZSd3FnZVhMakdWNlVkYXZ2bm1rT2ZGSzB5?=
 =?utf-8?B?c3pseHdrakp5V3RwTkpiUWdXaXY1ZExHWHducWtiU0IzbTRRTXFKakRjdFc5?=
 =?utf-8?B?ZHNsSmZqdHJ2VS9kdFlwS2hkbEdjRXZsbndQcXBVRVQ4c0E4UHF4VklZSnBx?=
 =?utf-8?B?eExyenlvTlVQWGhlbmVETm4rRVkxUWRkeUI1ZGw1WUJ5NVFlZXRkeG4rTEN0?=
 =?utf-8?B?Y09pMHhrY0dhMHVJUDg4dnNyeU1jS3AzK1hLTlFTQy9BZGY5L2I5blJaYUYz?=
 =?utf-8?B?RkV2OUR0WWwzMmhPNjRveVNVOENjQmlXVDJtYlYzWkJRTCtyM2hFTm1ORjFO?=
 =?utf-8?B?R1NNeXNqejdNbXgrVDA3Wmw1SFJXdHNaUmhoZElxV2lCZnROVTBNa2U1UjVj?=
 =?utf-8?B?TTdJOXRyRndYZ1VLazhFUXBKVUViRGxHZmpiMWd4NjAycVRadThLNElNUklI?=
 =?utf-8?B?UmlaYlZCb2ZDZlp1eXA5ZGdJRzRFMVlVL0ZvVmdhT2dZeWcyWDBmRWdRYnBh?=
 =?utf-8?B?MzZ4SUFlRXBBY0FwRmtBd05jNWFNa1R6UWFDQ3dCUm14bWk4QXQrQWEyakwy?=
 =?utf-8?B?SlNQS3Vrdms4NlozUzlIeU5RVlJQbG9XWmJhNzZ5dS9XSWRRYm9iTmhCR08x?=
 =?utf-8?Q?7QHWN3X53IjKrCNj8NW7LbZNW2syWcHjqfJSfdd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d32e662-e087-4cdd-9684-08d930139ba3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:38:22.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2AOmKukeZornYAbKfcbcQI1z5V42VX8Fbn0vhQRF/RggS3bCyXbO9Owd8RwTS4jZjZu2t71netuWWMk71j1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150097
X-Proofpoint-ORIG-GUID: 3qEGrwL05-FF6oDlg8ov-a_R-1IZFGHq
X-Proofpoint-GUID: 3qEGrwL05-FF6oDlg8ov-a_R-1IZFGHq
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------EyukaTaDpE27ihNlR6U72maS
Content-Type: multipart/mixed; boundary="------------diUmKbecFTeqY8fZcVMpq8kE";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "bfields@redhat.com" <bfields@redhat.com>
Message-ID: <3f7ee699-bbd6-9025-82b5-40c37cbb6d9c@oracle.com>
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <91f1d7df-b63c-4aa3-cc03-a8e1cbb2ecb1@oracle.com>
 <20210615144724.GB11877@fieldses.org>
In-Reply-To: <20210615144724.GB11877@fieldses.org>

--------------diUmKbecFTeqY8fZcVMpq8kE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUvMDYvMjAyMSAzOjQ3IHBtLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+IE9uIE1v
biwgSnVuIDE0LCAyMDIxIGF0IDA5OjUwOjM0UE0gKzAxMDAsIENhbHVtIE1hY2theSB3cm90
ZToNCj4+IE9uIDEwLzA2LzIwMjEgMjowMSBhbSwgc3V5LmZuc3RAZnVqaXRzdS5jb20gd3Jv
dGU6DQo+Pj4gVGhlIHRlc3QgZmFpbHMgb24gdjUuMTMtcmM1IGFuZCBvbGQga2VybmVscy4g
QmVjYXVzZSB0aGUgc2Vjb25kIHNlc3Npb24NCj4+PiBkb2Vzbid0IHNlbmQgUkVDTEFJTV9D
T01QTEVURSBiZWZvcmUgYXR0ZW1wdGluZyB0byBkbyBhIG5vbi1yZWNsYWltDQo+Pj4gb3Bl
bi4gU28gdGhlIHNlcnZlciByZXR1cm5zIE5GUzRFUlJfR1JBQ0UgaW5zdGVhZCBvZiBORlM0
X09LLg0KPj4+DQo+Pj4gICAgICAjIC4vdGVzdHNlcnZlci5weSAke3NlcnZlcl9JUH06L25m
c3Jvb3QgLS1ydW5kZXBzIENPVVIyDQo+Pj4gICAgICBJTkZPICAgOnJwYy5wb2xsOmdvdCBj
b25uZWN0aW9uIGZyb20gKCcxMjcuMC4wLjEnLCAzOTIwNiksIGFzc2lnbmVkIHRvDQo+Pj4g
ICAgICBmZD01DQo+Pj4gICAgICBJTkZPICAgOnJwYy50aHJlYWQ6Q2FsbGVkIGNvbm5lY3Qo
KCcxOTMuMTY4LjE0MC4yMzknLCAyMDQ5KSkNCj4+PiAgICAgIElORk8gICA6cnBjLnBvbGw6
QWRkaW5nIDYgZ2VuZXJhdGVkIGJ5IGFub3RoZXIgdGhyZWFkDQo+Pj4gICAgICBJTkZPICAg
OnRlc3QuZW52OkNyZWF0ZWQgY2xpZW50IHRvIDE5My4xNjguMTQwLjIzOSwgMjA0OQ0KPj4+
ICAgICAgSU5GTyAgIDp0ZXN0LmVudjpDYWxsZWQgZG9fcmVhZGRpcigpDQo+Pj4gICAgICBJ
TkZPICAgOnRlc3QuZW52OmRvX3JlYWRkaXIoKSA9IFtlbnRyeTQoY29va2llPTUxMiwNCj4+
PiAgICAgIG5hbWU9YidDT1VSMl8xNjIzMDU1MzEzJywgYXR0cnM9e30pXQ0KPj4+ICAgICAg
ZmlsZWInQ09VUjJfMTYyMzExOTQ0MydjcmVhdGVkIGJ5IHNlc3MxDQo+Pj4gICAgICBJTkZP
ICAgOnRlc3QuZW52OlNsZWVwaW5nIGZvciAyMiBzZWNvbmRzOiB0d2ljZSB0aGUgbGVhc2Ug
cGVyaW9kDQo+Pj4gICAgICBJTkZPICAgOnRlc3QuZW52Oldva2UgdXANCj4+PiAgICAgIHNl
c3Npb24gY3JlYXRlZA0KPj4+ICAgICAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioNCj4+PiAgICAgIENPVVIyICAgIHN0X2NvdXJ0ZXN5LnRl
c3RMb2NrU2xlZXBMb2NrICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoNCj4+PiAgICAg
IEZBSUxVUkUNCj4+PiAgICAgICAgICAgICBPUF9PUEVOIHNob3VsZCByZXR1cm4gTkZTNF9P
SywgaW5zdGVhZCBnb3QNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgTkZTNEVSUl9HUkFD
RQ0KPj4+ICAgICAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioNCj4+PiAgICAgIENvbW1hbmQgbGluZSBhc2tlZCBmb3IgMSBvZiAyNTUgdGVz
dHMNCj4+PiAgICAgICAgT2YgdGhvc2U6IDAgU2tpcHBlZCwgMSBGYWlsZWQsIDAgV2FybmVk
LCAwIFBhc3NlZA0KPj4+DQo+Pj4gUkZDNTY2MSwgcGFnZSA1Njc6DQo+Pj4gIldoZW5ldmVy
IGEgY2xpZW50IGVzdGFibGlzaGVzIGEgbmV3IGNsaWVudCBJRCBhbmQgYmVmb3JlIGl0IGRv
ZXMgdGhlDQo+Pj4gZmlyc3Qgbm9uLXJlY2xhaW0gb3BlcmF0aW9uIHRoYXQgb2J0YWlucyBh
IGxvY2ssIGl0IE1VU1Qgc2VuZCBhDQo+Pj4gUkVDTEFJTV9DT01QTEVURSB3aXRoIHJjYV9v
bmVfZnMgc2V0IHRvIEZBTFNFLCBldmVuIGlmIHRoZXJlIGFyZSBubw0KPj4+IGxvY2tzIHRv
IHJlY2xhaW0uIElmIG5vbi1yZWNsYWltIGxvY2tpbmcgb3BlcmF0aW9ucyBhcmUgZG9uZSBi
ZWZvcmUNCj4+PiB0aGUgUkVDTEFJTV9DT01QTEVURSwgYW4gTkZTNEVSUl9HUkFDRSBlcnJv
ciB3aWxsIGJlIHJldHVybmVkLiINCj4+Pg0KPj4+IFNlbmQgUkVDTEFJTV9DT01QTEVURSBi
ZWZvcmUgdGhlIGZpbGUgb3BlbiB0byBsZXQgdGhlIHRlc3QgcGFzcy4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBTdSBZdWUgPHN1eS5mbnN0QGNuLmZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+
ICAgbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY291cnRlc3kucHkgfCAzICsrKw0KPj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L25mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2NvdXJ0ZXN5LnB5IGIvbmZzNC4xL3NlcnZlcjQx
dGVzdHMvc3RfY291cnRlc3kucHkNCj4+PiBpbmRleCBkZDkxMWEzNzc3MmQuLjM0NzhhOWQ5
M2RiZiAxMDA2NDQNCj4+PiAtLS0gYS9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3VydGVz
eS5weQ0KPj4+ICsrKyBiL25mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2NvdXJ0ZXN5LnB5DQo+
Pj4gQEAgLTc0LDYgKzc0LDkgQEAgZGVmIHRlc3RMb2NrU2xlZXBMb2NrKHQsIGVudik6DQo+
Pj4gICAgICAgYzIgPSBlbnYuYzEubmV3X2NsaWVudChiIiVzXzIiICUgZW52LnRlc3RuYW1l
KHQpKQ0KPj4+ICAgICAgIHNlc3MyID0gYzIuY3JlYXRlX3Nlc3Npb24oKQ0KPj4+ICsgICAg
cmVzID0gc2VzczIuY29tcG91bmQoW29wLnJlY2xhaW1fY29tcGxldGUoRkFMU0UpXSkNCj4+
PiArICAgIGNoZWNrKHJlcykNCj4+PiArDQo+Pj4gICAgICAgcmVzID0gb3Blbl9maWxlKHNl
c3MyLCBlbnYudGVzdG5hbWUodCksIGFjY2Vzcz1PUEVONF9TSEFSRV9BQ0NFU1NfV1JJVEUp
DQo+Pj4gICAgICAgY2hlY2socmVzKQ0KPj4+DQo+Pg0KPj4gSSdkIHN0aWxsIGxpa2UgdG8g
Y2hlY2sgd2hldGhlciB0aGlzIGlzIHRoZSByaWdodCBwbGFjZSB0byBmaXggdGhpcy4NCj4+
DQo+PiBJbml0aWFsbHksIEkgd2FzIGNvbmZ1c2VkIGFzIHRvIHdoeSB0aGUgZmlyc3QgY2xp
ZW50ICJjMSIgZG9lc24ndA0KPj4gZmFjZSB0aGUgc2FtZSBpc3N1ZS4gQSBuZXR3b3JrIHRy
YWNlIHNob3dzIHRoYXQgYSBSRUNMQUlNX0NPTVBMRVRFDQo+PiBpcyBpbmRlZWQgc2VudCBm
b3IgYzEsIGRlc3BpdGUgbm90IGFwcGVhcmluZyBleHBsaWNpdGx5IGluDQo+PiB0ZXN0TG9j
a1NsZWVwTG9jaygpLiBXaGVyZWFzIG9uZSBpc24ndCBzZW50IGZvciBjMiwgaGVuY2UgdGhl
DQo+PiBwcm9ibGVtLg0KPj4NCj4+IFRoaXMgaXMgcHJvYmFibHkgYmVjYXVzZSBjMSBpcyBp
bml0aWFsaXNlZCB3aXRoOg0KPj4NCj4+ICAgIDYxICAgICBzZXNzMSA9IGVudi5jMS5uZXdf
Y2xpZW50X3Nlc3Npb24oZW52LnRlc3RuYW1lKHQpKQ0KPj4NCj4+DQo+PiBhbmQgYzIgd2l0
aDoNCj4+DQo+PiAgICA3NCAgICAgYzIgPSBlbnYuYzEubmV3X2NsaWVudChiIiVzXzIiICUg
ZW52LnRlc3RuYW1lKHQpKQ0KPj4gICAgNzUgICAgIHNlc3MyID0gYzIuY3JlYXRlX3Nlc3Np
b24oKQ0KPj4NCj4+DQo+PiBUaGUgYzEgY2FzZSByZXN1bHRzIGluIGEgUkVDTEFJTV9DT01Q
TEVURSwgYnV0IHRoZSBjMiBjYXNlIGRvZXMgbm90Lg0KPj4NCj4+IEknbSBub3QgeWV0IHN1
cmUgd2hldGhlciB0aGF0IG91Z2h0IHRvIGJlIGRvbmUgaW4NCj4+IG5ld19jbGllbnQoKS9j
cmVhdGVfc2Vzc2lvbigpLiBJZiBzbywgdGhlbiB0aGVyZSB3b3VsZCBiZSBubyBuZWVkIHRv
DQo+PiBhZGQgaXQgZXhwbGljaXRseSBoZXJlLg0KPiANCj4gVGhlcmUncyBkZWZpbml0ZWx5
IGNhc2VzIHdoZXJlIGNsaWVudHMgd2FudCB0byBiZSBhYmxlIHRvIGNyZWF0ZSBhIG5ldw0K
PiBzZXNzaW9uIHdpdGhvdXQgc2VuZGluZyBhIG5ldyBSRUNMQUlNX0NPTVBMRVRFLg0KDQp0
aGFua3MgQnJ1Y2U7IHllcywgSSB3b25kZXJlZC4NCg0KDQo+IEFueSByZWFzb24gd2UgY2Fu
J3QgcmVwbGFjZSB0aG9zZSB0d28gbGluZXMgYnkgYSBzaW5nbGUNCj4gbmV3X2NsaWVudF9z
ZXNzaW9uKCk/DQoNCkkgd2Fzbid0IHF1aXRlIHN1cmUgb24gdGhlIHNlbWFudGljcyBvZiB0
aG9zZSBjYWxscy4NCg0KV2Ugd2FudCB3aGF0IGFwcGVhcnMgdG8gdGhlIHNlcnZlciB0byBi
ZSBhIG5ldyBjbGllbnQgYzIsIG5vdCBhIG5ldyANCnNlc3Npb24gZnJvbSBhbiBleGlzdGlu
ZyBjbGllbnQgYzEuIEkgd2Fzbid0IHN1cmUgd2hldGhlciANCm5ld19jbGllbnRfc2Vzc2lv
bigpIHdvdWxkIGdpdmUgdXMgdGhhdD8NCg0KUHV0IGFsdGVybmF0aXZlbHksIHdoYXQgaXMg
dGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBuZXdfY2xpZW50X3Nlc3Npb24gYW5kIA0KbmV3X2Ns
aWVudC9uZXdfc2Vzc2lvbj8gSXMgaXQganVzdCBhIGRpZmZlcmVudCBncmFudWxhcml0eSwg
YW5kIHRvIGdpdmUgDQp0aGUgb3B0aW9uIGUuZy4gb2Ygbm90IHVzaW5nIFJFQ0xBSU1fQ09N
UExFVEU/DQoNCg0KSSdsbCBoYXZlIGEgZnVydGhlciBsb29r4oCmDQoNCnRoYW5rcyB2ZXJ5
IG11Y2gsDQpjYWx1bS4NCg0KDQoNCj4gSSdkIGRvIGVpdGhlciB0aGF0IG9yIGp1c3QgYWRk
IHRoZSBleHBsaWNpdA0KPiBSRUNMQUlNX0NPTVBMRVRFLg0KPiANCj4+IFtJIHN1c3BlY3Qg
dGhpcyB3YXMgbWlzc2VkIGluIG15IHRlc3RpbmcsIHNpbmNlIHRoZSBTb2xhcmlzIHNlcnZl
ciBJDQo+PiB1c2VkIG1heSBiZSBsZXNzIHN0cmljdCBhYm91dCByZXF1aXJpbmcgdGhlIFJF
Q0xBSU1fQ09NUExFVEVdDQo+IA0KPiBUaGF0J3MgYSBzZXJ2ZXIgYnVnOg0KPiANCj4gCWh0
dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2h0bWwvcmZjNTY2MSNwYWdlLTE3Mw0K
PiANCj4gCS4uLiBORlM0RVJSX0dSQUNFIG11c3QgYWx3YXlzIGJlIHJldHVybmVkIHRvIGNs
aWVudHMgYXR0ZW1wdGluZw0KPiAJYSBub24tcmVjbGFpbSBsb2NrIHJlcXVlc3QgYmVmb3Jl
IGRvaW5nIHRoZWlyIG93biBnbG9iYWwNCj4gCVJFQ0xBSU1fQ09NUExFVEUuDQo+IA0KPiBJ
J3ZlIGNvbXBsYWluZWQgYWJvdXQgaXQgYmVmb3JlLiAgSSBoYWQgc29tZSBpZGVhIGl0J2Qg
YmVlbiBmaXhlZCwgbWF5YmUNCj4gbm90Lg0KPiANCj4gLS1iLg0KPiANCg==

--------------diUmKbecFTeqY8fZcVMpq8kE--

--------------EyukaTaDpE27ihNlR6U72maS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmDIyWcFAwAAAAAACgkQhSPvAG3BU+J6
LxAApBhvSmvWN3KL4SURaO2FsOCAf+y3fCiHQlAhNlrKIk1+GArwL48KFPoxuhiN89n3s8Z5k22Q
+nuka7fJS06VcWhVqIwj1ivpbfUgjb6JR1wfxgOVuWdGAMiyvlmLf+ntQVi3g4rsm3eEiLP0QxRu
qvC9a7R2ypMqo8HZ2vZWT3eVhlXhpivBI1f5SWY5FKomHX4hZFV7NezVFcieSUInmbba1xilgVDV
qbD+eU9vYHUh8VFu2Hpddm0tJ+623DdK2iWUm7OtbaT4sGkeBPk6KzaYqfruLxb5LSf02BWE6mwR
QfmfnVfssZBTEJeeqeFVvcSPL5Z8rDstRE6srYpc4DUREGssw0w67j9lSBpecPSevk9ZvvFHLT6k
xNLedXHGq7qPBVZRltoWtKbciL93veFhJvGQ/qpHkd/OHumejttAr+/mJ+O2X3pYJzNAeJFDgWlc
S/gVCn0JqQT+h8CHSQJv8Q+MzJJ1c0fqGKCApcZb8C6gn3K73RA0+LamA9h4VxTn4AtFm1vR/Ove
jXN2o93mGid5EeKFprGxM5Y/hLivfV23Iu236Q89161PX9PYAFusWNHCsdCzo9mmHdCBVNAmRpXR
7XMURvM6HFLNbow3CZGHYuPs4Ihrsc/IK8Z8S8Gr2zMZTpKM2vAbALIj/dgh52eCcVwm9ZlyPatW
9l0=
=uDG+
-----END PGP SIGNATURE-----

--------------EyukaTaDpE27ihNlR6U72maS--
