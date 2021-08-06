Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D96C3E3119
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhHFV0M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 17:26:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51840 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhHFV0M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 17:26:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176LHuPA020464;
        Fri, 6 Aug 2021 21:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=yNDYnY4LL85sewYUIuBjEJsrOUMBKmvO/LWmhTmqUlI=;
 b=RfSdHsSjLFFJfUXdDYaCeQ+3pVW/IYBS6cxayngRssI0eSw9XYBy3+10AXlIuGjqrW9j
 gjZ1PGAovDytkfee0KLklZ0Ir0vLbLq7IS1S8LPpw0uP8mMPxvs8lVBMR04COAn69prA
 QTpr+VYxWeAKWV1q0NBNjFgSDnm1+ub0ZCAgSPAk1U8Wcg8di5VI/Vqxovq6HeAGeYjJ
 6cBOVgU9cN77utDYhmxZg2bxCVQ1aBGCZUay5VAMMGeC/WRelHt8KLEU2Q+qi+brgNgC
 wyYw6dMs1oCDKx2s4ANd/qo1lpRQxk+Sii6cNSTLCeQtH+Dm+n9RQXwnW8QHWQsSFGYK 5w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=yNDYnY4LL85sewYUIuBjEJsrOUMBKmvO/LWmhTmqUlI=;
 b=SF5KBg3WkkmWluNnwC3BapDSK88Z6U20qMlIuNRnVLJfhSlmjMuVwbQ31bzVyZBB+dA4
 hFl3MInu6haTzWCnQPEYMcU2HyviHQI5uxbq+NEZdmuLzL+yHU1nGCjsrmWO3q6nqu/z
 5Agkx99ZXSC7YoaO33ZO5vAiigyNTznUPCsA7KOn7vroKYtZiFWt2czn1VUK3NdpksxV
 YXFl09GGnjaZC3wOnNKEWc4CHkHAjT3XOTgJshKnlEJnn2O+WpN2rV2DnBC53gW/ckqm
 OlFMTHEbkym1jeaFDjPCx7b0cLZTBS+ISarhP79fSUz+blNF/C22I7Uz0+vck+H8yXuP ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a8p6rjmrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 21:25:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176LFjiW082233;
        Fri, 6 Aug 2021 21:25:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 3a962pdu48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 21:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjxFzwsdoVoHCxS4leCImFOnnEMVVzAsvC64u2oFbEmKCbttLsNWd9XlJIgAGXtWOt9dmGheyrGHj1QM/IpQ3dXBHNJY5hQKIKZHftU2HPZELr8+Nhg8DJynmwfPqJXWdji+xYS7Tc0Fc25nBTFKTgBOEn7T/QwUmrll2utaeY25QxSUAwZjSc3hw71cyTSQx2ziknwkN3Wp25n0G6tdfNymUYQ7phPOvmvd/TsBRMbVLW5qwlpDmd+dumksZky4i/6gWs8sLPysXavVTI7F9R/K+2OK4GfyqH46xD7ND5xxTvxrHoevDslop6yG4RJa4KyczimENyaQ/u9XN2K4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNDYnY4LL85sewYUIuBjEJsrOUMBKmvO/LWmhTmqUlI=;
 b=BJT9yUSzsTav1fk/45pD56bbifXBo27wiPepXo+Wke1yHXVwkrLGoMS0YFKFEdSCdEaQugey8NZqC2UT6wk6tNujfdv0QWWZlAhfZ85OBP17e02GJQVEtf42ZRHMLBIpF56cvkLHvjMBVjygAhnKSH4ZniFpkIzwE6JNjTjHOUPLvqnLCmFSOGSRqDe5nFItfJuWlfePXBHw/Jc5+EKUnmVFg+aFRdAV3/S/Kzbi0NEfdqTnF1TyW1EGiHGlv3XK8d4FvTLc/a6w8CeiSgvJw4YJJg1BLR8m+3wyVEmaSTyCAdHSf0JeCWx3fERSs8sEfX80fGhVvAr4ycNAn4TtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNDYnY4LL85sewYUIuBjEJsrOUMBKmvO/LWmhTmqUlI=;
 b=RiDKIiV1RDPJPmQ1gaqkTlo7y0oeHWSgPOTbooqtX6580SO5qyheWpy9Q7z4CawRZ98RZPNdwge7id9r9qiPJR1LN/B4W87N4FUj5NfrM5c1pDE/bTnw0DWE8Q0PG77HVHT+pfku5vpv5n+qy68tXp/I5XwOMuvEYncdRPlG4Aw=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN0PR10MB5366.namprd10.prod.outlook.com (2603:10b6:408:12b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 21:25:50 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6%5]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 21:25:50 +0000
Message-ID: <5869cf8c-3339-f6a1-9ced-f2c6fdb853be@oracle.com>
Date:   Fri, 6 Aug 2021 22:25:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:92.0)
 Gecko/20100101 Thunderbird/92.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>
Content-Language: en-GB
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
 <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
 <f270f45b-b5f9-5241-83c8-97c5f5482c56@oracle.com>
 <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: Re: nfs_page_async_flush returning 0 for fatal errors on writeback
In-Reply-To: <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mVyLThJDegBL90wdA5w6lRll"
X-ClientProxiedBy: LO2P265CA0496.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::21) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (84.71.130.115) by LO2P265CA0496.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 21:25:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aeda693-b90e-4ba9-e318-08d95920c319
X-MS-TrafficTypeDiagnostic: BN0PR10MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB5366DF812CA2AE86B4A7D8A4E7F39@BN0PR10MB5366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0v3IlQIXOLwb+hZ9kmnpQ7eR6+XWOpvz/yb68ryPSSAkkE3321mrKv467xI2LHVUvudwQ3C6aq6+kdPwFVRm0lCrzCzjuWXwASBNIkf+J3tM+JvwIr6YGXBoqLBGHu7yhG7csCqB5h3UVZA2wnwpdpp8zdZM+Cv4HMfp8hTDvHsddO9U46eCIUxq7KoH4+qxE9YaNfmKl+iPEq+5PW2Vc4A/fFD9vYFGgXu00ioL7znuX5mhPs/kVGixheoVs5+eAZKErTid1HzeOM6rmIXuFFM9YaUvZu/68VLEuYJuTQSIhBuTR4mYhR4Yf24pUnmz5ZQ/2xQkCmz9deE6g5yr0sEIyDlHggXiOVd9RlXhY5HR49h5MSF9Vyz5dnqEpx0kSjHVVrWlxm2K+ylGyLcZI5i5wshexk+RwEExfyGmHOcTDaKWrh449YoCBIkwdbzW4U2yc41x+kuRo7rYOvCuGjnTbZPPVrKJE+Ky5djTtbsfTq5eWEmeku5UqSrK9e8CEOA3f+jkm2SbEcuOeCNTBcerjW4vR06aOt5r9wncByTJa9cemDIuD5Rk+lnXfPVbeo2kR4xvq08cwpSRx+/oJJzmUF5oNsjSM5c0aaf8TqoCRvrfvkisxk2LAB+ir8m7Y5k5ZDejSZmWfcWezJJ+KY2fnwpGX/tVMm7fZXjGqZxDpddiZb04yve9YYpuBY8o3NUukIh2UX0yRyw0vopRHcst5UCxPqtgcvD1AI6fOdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(316002)(235185007)(6666004)(86362001)(5660300002)(83380400001)(8936002)(44832011)(16576012)(8676002)(33964004)(66556008)(2906002)(186003)(956004)(6486002)(66946007)(66476007)(478600001)(110136005)(36916002)(31696002)(53546011)(2616005)(21480400003)(26005)(107886003)(36756003)(38100700002)(4326008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU8yaHQwK2MxVlg4UzNXbi9ReFE2NTRRNDJmU1NWQkZMQjJKVU1vcXlpSDBm?=
 =?utf-8?B?UzZVbG9DZVFycXhpSEJIRFRPRTEya2VSWnZjd0V3bWQ1OWFnZHdlajkzS3My?=
 =?utf-8?B?aG5yRTFwVkYvaDhOS2JYd3QxRC9KNmVjRW5WYlF6V1Y4dlo0UG5iY2QrTlFu?=
 =?utf-8?B?S1dMUXQrVTQ3WjhWSjEyRmNIWDY2anlnYWdFTlMrWHRnN2V5bG1FUDcxZWMx?=
 =?utf-8?B?UXcwMmx4b1pkV1hwNmdCUU9ncVZycEJ1QWMxbFhZU01hdDVnYVlXUWVudFo0?=
 =?utf-8?B?NXk4SU1BSjRMcHg5WEJhSkk1blQxc3NHQy9FSU42RU9tSThnZzNYM1pQREls?=
 =?utf-8?B?UjNpZzQzaGxDUXdKaXV6cmV0elBxc3J2N29aYmQ5MVFGbVdGa3hoaFltK3ov?=
 =?utf-8?B?b3l1NHN5L2VxdnZINDI1Y1BBNlZKU3pSd2Y0NzIwTVVwWFFvbUxVL00zWXg0?=
 =?utf-8?B?OHV5dGloS0FjR01CNzBDcHoyTEw2Q3cvL0ZpSSsxU3BYME9TSkwvbW51TDZR?=
 =?utf-8?B?S0wrNThwbGRKTmNQcGhlUHcyMVRWbXdsZzdncy9sRXp3MVAwSmplbG9qaE5L?=
 =?utf-8?B?ZTJJR3V2R2d4K3ozdW52U2d2UzFQKzhZZU9seXg2VE5NOHZndzNkYnFROHR6?=
 =?utf-8?B?eTRCa1BuTGVnWWV2T1dGYXJqYm55ZXI4QkYyZkdibytHU3FobHZXLzlnV29R?=
 =?utf-8?B?ZEgzUTh1Sk03a1BLdkhRV2VqK04rMHVhOGZibGVHeVpkWjdlWXhRSFhqZHZh?=
 =?utf-8?B?V0txaDIxekVIcUZxYlpMT09uWG56T2d3cmt4YVIramllbHdSaWFUSWVjd2Y1?=
 =?utf-8?B?NFRlQUFQc2RMa2NMZDlBWmVVQURVU1FZakZrcUN4QVZZdEE4akhzZzEyUytv?=
 =?utf-8?B?Q3d2a0ZGS1BCWm9URzEwWTB5U3JURnpzUjhDUXlLb3JiaHVIVjVidVE0elAw?=
 =?utf-8?B?QzMycjkwWnFpR1ZIY25EVTJ6Z0tnSlE2cFcvbWx4R1ozUktxNHdjcDQ4YW9J?=
 =?utf-8?B?NGprM04wcDNEODlxWG42QjB6YVkvZUVCSkh2dEFSWkdQV1Z2UkJ3ZFI3NUhG?=
 =?utf-8?B?bnVNOHM5VnNNUGRnN1h5eUlIZjdGSTBoQ014aU0rQ1N6VHVNQkE4VlVNeWl0?=
 =?utf-8?B?NGVIMHFoR3k1SnQwZ1NhSklBdmwwS3pwNlFrTzZtOWk5UUY3d00vUmp3ZG1t?=
 =?utf-8?B?MkQ3SWxnWCtXdFZoTlhESGlzbVRLb3FBSllPRUFPWEZRQ20wTnRDUEJaczNM?=
 =?utf-8?B?NjBJZXY1UGJuN0NtcGtSVXNLRmdSYlVQdTh5emNNZ0Z3RmI0cFc5a3RIRHl2?=
 =?utf-8?B?bjlsV1BBTS9mdWhzNWpwbkJjc283dWcrMUVybFRhZ0VwME5xZm9VcklVM0tM?=
 =?utf-8?B?bVp0V3JoZm1ZYndCUUw3c3k4K2ExS1FFYzNsZURnbzRrTEJNcTgyRDAyWk82?=
 =?utf-8?B?VFpMSy9HeVd3dVlDSEtSSHB0bVVBdUZObEpWcENudzJvQStldXhQVUtxRyts?=
 =?utf-8?B?VEYvNXdYbENIaCtJemdubkZjbjhGMUMzd3IzaHl6aFRLeStRVHNoSGdFYytP?=
 =?utf-8?B?WVIyR3daQm1oN0xibDFsS1d3RHl3elhYZCtla0xtbTFEeVJOVDhwL1BCV0c4?=
 =?utf-8?B?K0o3bDkrb0FuR2xyT05wZnpZOEg2UE5lZGhKSE56amowWTFhL0dZaElQbnBy?=
 =?utf-8?B?MFRSc1g2OXhsNVVoaE1iSDRtVmlHN1d3cktoM0ZNNWFHRUIrRjA1UGM5TlRx?=
 =?utf-8?Q?QzIFv1EJOWERInwWN13nL4o1Cun8URnQ1uFYsHY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeda693-b90e-4ba9-e318-08d95920c319
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 21:25:49.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxOtYuggDhoaNotW8a4SPlPMOpt/Ka1zO1m/ga0wFDbg++bI7b4XE1nX7A5slm56eWiweY261PHlXhvyMkGi1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5366
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060139
X-Proofpoint-ORIG-GUID: _wxn0w4cnbHzsKWni04sNPM6MZZ2sFh5
X-Proofpoint-GUID: _wxn0w4cnbHzsKWni04sNPM6MZZ2sFh5
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------mVyLThJDegBL90wdA5w6lRll
Content-Type: multipart/mixed; boundary="------------qjisVIH5zzgEN2g7gi2YAC4E";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <5869cf8c-3339-f6a1-9ced-f2c6fdb853be@oracle.com>
Subject: Re: nfs_page_async_flush returning 0 for fatal errors on writeback
References: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
 <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
 <f270f45b-b5f9-5241-83c8-97c5f5482c56@oracle.com>
 <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>
In-Reply-To: <421b63750c5d80bdda1184c854d7ab3489c7ff01.camel@hammerspace.com>

--------------qjisVIH5zzgEN2g7gi2YAC4E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGkgVHJvbmQsDQoNCk9uIDA4LzA3LzIwMjEgMTI6NTAgYW0sIFRyb25kIE15a2xlYnVzdCB3
cm90ZToNCj4gT24gVGh1LCAyMDIxLTA3LTA4IGF0IDAwOjEzICswMTAwLCBDYWx1bSBNYWNr
YXkgd3JvdGU6DQo+PiBPbiAwNy8wNy8yMDIxIDExOjAxIHBtLCBUcm9uZCBNeWtsZWJ1c3Qg
d3JvdGU6DQo+Pj4gT24gV2VkLCAyMDIxLTA3LTA3IGF0IDE5OjUxICswMTAwLCBDYWx1bSBN
YWNrYXkgd3JvdGU6DQo+Pj4+IGhpIFRyb25kLA0KPj4+Pg0KPj4+PiBJIGhhZCBhIHF1ZXN0
aW9uIGFib3V0IHRoZXNlIHR3byBvbGQgY29tbWl0cyBvZiB5b3VycywgZnJvbSB2NS4wDQo+
Pj4+ICYNCj4+Pj4gdjUuMjoNCj4+Pj4NCj4+Pj4gMTRiZWJlM2M5MGIzIE5GUzogRG9uJ3Qg
aW50ZXJydXB0IGZpbGUgd3JpdGVvdXQgZHVlIHRvIGZhdGFsDQo+Pj4+IGVycm9ycw0KPj4+
PiAoMg0KPj4+PiB5ZWFycywgMiBtb250aHMgYWdvKQ0KPj4+Pg0KPj4+PiA4ZmM3NWJlZDk2
YmIgTkZTOiBGaXggdXAgcmV0dXJuIHZhbHVlIG9uIGZhdGFsIGVycm9ycyBpbg0KPj4+PiBu
ZnNfcGFnZV9hc3luY19mbHVzaCgpICgyIHllYXJzLCA1IG1vbnRocyBhZ28pDQo+Pj4+DQo+
Pj4+DQo+Pj4+IEkgYW0gbG9va2luZyBhdCBhIGNyYXNoIGR1bXAsIHdpdGggYSBrZXJuZWwg
YmFzZWQgb24gYW4gb2xkZXItDQo+Pj4+IHN0aWxsDQo+Pj4+IHY0LjE0IHN0YWJsZSB3aGlj
aCBkaWQgbm90IGhhdmUgZWl0aGVyIG9mIHRoZSBhYm92ZSBjb21taXRzLg0KPj4+Pg0KPj4+
PiAgwqDCoMKgwqDCoMKgwqDCoCBQQU5JQzogIkJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyDQo+Pj4+IGRlcmVmZXJlbmNlDQo+Pj4+IGF0DQo+Pj4+IDAwMDAw
MDAwMDAwMDAwODAiDQo+Pj4+DQo+Pj4+ICDCoMKgwqDCoMKgIFtleGNlcHRpb24gUklQOiBf
cmF3X3NwaW5fbG9jaysyMF0NCj4+Pj4NCj4+Pj4gIzEwIFtmZmZmYjE0OTNkNzhmY2I4XSBu
ZnNfdXBkYXRlcGFnZSBhdCBmZmZmZmZmZmMwOGYxNzkxIFtuZnNdDQo+Pj4+ICMxMSBbZmZm
ZmIxNDkzZDc4ZmQxMF0gbmZzX3dyaXRlX2VuZCBhdCBmZmZmZmZmZmMwOGUwOTRlIFtuZnNd
DQo+Pj4+ICMxMiBbZmZmZmIxNDkzZDc4ZmQ1OF0gZ2VuZXJpY19wZXJmb3JtX3dyaXRlIGF0
IGZmZmZmZmZmYTcxZDQ1OGINCj4+Pj4gIzEzIFtmZmZmYjE0OTNkNzhmZGUwXSBuZnNfZmls
ZV93cml0ZSBhdCBmZmZmZmZmZmMwOGRmZGI0IFtuZnNdDQo+Pj4+ICMxNCBbZmZmZmIxNDkz
ZDc4ZmUxOF0gX192ZnNfd3JpdGUgYXQgZmZmZmZmZmZhNzI4NDhiYw0KPj4+PiAjMTUgW2Zm
ZmZiMTQ5M2Q3OGZlYTBdIHZmc193cml0ZSBhdCBmZmZmZmZmZmE3Mjg0YWQyDQo+Pj4+ICMx
NiBbZmZmZmIxNDkzZDc4ZmVlMF0gc3lzX3dyaXRlIGF0IGZmZmZmZmZmYTcyODRkMzUNCj4+
Pj4gIzE3IFtmZmZmYjE0OTNkNzhmZjI4XSBkb19zeXNjYWxsXzY0IGF0IGZmZmZmZmZmYTcw
MDM5NDkNCj4+Pj4NCj4+Pj4gdGhlIHJlYWwgc2VxdWVuY2UsIG9ic2N1cmVkIGJ5IGNvbXBp
bGVyIGlubGluaW5nLCBpczoNCj4+Pj4NCj4+Pj4gIMKgwqDCoMKgIG5mc191cGRhdGVwYWdl
DQo+Pj4+ICDCoMKgwqDCoMKgwqDCoCBuZnNfd3JpdGVwYWdlX3NldHVwDQo+Pj4+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBuZnNfc2V0dXBfd3JpdGVfcmVxdWVzdA0KPj4+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX2lub2RlX2FkZF9yZXF1ZXN0DQo+Pj4+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJm1hcHBpbmctPnByaXZh
dGVfbG9jayk7DQo+Pj4+DQo+Pj4+IGFuZCB3ZSBjcmFzaCBzaW5jZSB0aGUgYXMgbWFwcGlu
ZyBwb2ludGVyIGlzIE5VTEwuDQo+Pj4+DQo+Pj4+DQo+Pj4+IEkgdGhvdWdodCBJIHdhcyBh
YmxlIHRvIGNvbnN0cnVjdCBhIHBvc3NpYmxlIHNlcXVlbmNlIHRoYXQgd291bGQNCj4+Pj4g
ZXhwbGFpbg0KPj4+PiB0aGUgYWJvdmUsIGlmIHdlIGFyZSBpbiAoZnJvbSBhYm92ZSk6DQo+
Pj4+DQo+Pj4+ICDCoMKgwqDCoCBuZnNfc2V0dXBfd3JpdGVfcmVxdWVzdA0KPj4+PiAgwqDC
oMKgwqDCoCBuZnNfdHJ5X3RvX3VwZGF0ZV9yZXF1ZXN0DQo+Pj4+ICDCoMKgwqDCoMKgwqAg
bmZzX3diX3BhZ2UNCj4+Pj4gIMKgwqDCoMKgwqDCoMKgIG5mc193cml0ZXBhZ2VfbG9ja2Vk
DQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgIG5mc19kb193cml0ZXBhZ2UNCj4+Pj4NCj4+Pj4g
YW5kIG5mc19wYWdlX2FzeW5jX2ZsdXNoIGRldGVjdHMgYSBmYXRhbCBzZXJ2ZXIgZXJyb3Is
IGFuZCBjYWxscw0KPj4+PiBuZnNfd3JpdGVfZXJyb3JfcmVtb3ZlX3BhZ2UsIHdoaWNoIHJl
c3VsdHMgaW4gdGhlIHBhZ2UtPm1hcHBpbmcNCj4+Pj4gc2V0DQo+Pj4+IHRvIE5VTEwuDQo+
Pj4+DQo+Pj4+IEluIHRoYXQgdmVyc2lvbiBvZiB0aGUgY29kZSwgd2l0aG91dCB5b3VyIGNv
bW1pdHMgYWJvdmUsDQo+Pj4+IG5mc19wYWdlX2FzeW5jX2ZsdXNoIHJldHVybnMgMCBpbiB0
aGlzIGNhc2UsIHdoaWNoIEkgdGhvdWdodA0KPj4+PiBtaWdodA0KPj4+PiByZXN1bHQgaW4g
bmZzX3NldHVwX3dyaXRlX3JlcXVlc3QgZ29pbmcgYWhlYWQgYW5kIGNhbGxpbmcNCj4+Pj4g
bmZzX2lub2RlX2FkZF9yZXF1ZXN0IHdpdGggdGhhdCBwYWdlLCByZXN1bHRpbmcgaW4gdGhl
IGNyYXNoDQo+Pj4+IHNlZW4uDQo+Pj4+DQo+Pj4+DQo+Pj4+IEkgdGhlbiBkaXNjb3ZlcmVk
IHlvdXIgdjUuMCBjb21taXQ6DQo+Pj4+DQo+Pj4+IDhmYzc1YmVkOTZiYiBORlM6IEZpeCB1
cCByZXR1cm4gdmFsdWUgb24gZmF0YWwgZXJyb3JzIGluDQo+Pj4+IG5mc19wYWdlX2FzeW5j
X2ZsdXNoKCkgKDIgeWVhcnMsIDUgbW9udGhzIGFnbykNCj4+Pj4NCj4+Pj4gd2hpY2ggYXBw
ZWFyZWQgdG8gY29ycmVjdCB0aGF0LCBoYXZpbmcgbmZzX3BhZ2VfYXN5bmNfZmx1c2gNCj4+
Pj4gcmV0dXJuDQo+Pj4+IHRoZQ0KPj4+PiBlcnJvciBpbiB0aGlzIGNhc2UsIHNvIHdlIHdv
dWxkIG5vdCBlbmQgdXAgaW4NCj4+Pj4gbmZzX2lub2RlX2FkZF9yZXF1ZXN0Lg0KPj4+Pg0K
Pj4+Pg0KPj4+PiBCdXQgSSB0aGVuIHNwb3R0ZWQgeW91ciBsYXRlciB2NS4yIGNvbW1pdDoN
Cj4+Pj4NCj4+Pj4gMTRiZWJlM2M5MGIzIE5GUzogRG9uJ3QgaW50ZXJydXB0IGZpbGUgd3Jp
dGVvdXQgZHVlIHRvIGZhdGFsDQo+Pj4+IGVycm9ycw0KPj4+PiAoMg0KPj4+PiB5ZWFycywg
MiBtb250aHMgYWdvKQ0KPj4+Pg0KPj4+PiB3aGljaCBjaGFuZ2VzIHRoaW5ncyBiYWNrLCBz
byB0aGF0IG5mc19wYWdlX2FzeW5jX2ZsdXNoIG5vdyBhZ2Fpbg0KPj4+PiByZXR1cm5zIDAs
IGluIHRoZSAibGF1bmRlciIgY2FzZSwgYW5kIHRoYXQncyBob3cgdGhhdCBjb2RlDQo+Pj4+
IHJlbWFpbnMNCj4+Pj4gdG9kYXkuDQo+Pj4+DQo+Pj4+DQo+Pj4+IElmIHNvLCBpcyB0aGVy
ZSBhbnl0aGluZyB0byBzdG9wIHRoZSBwb3NzaWJsZSBjcmFzaCBwYXRoIHRoYXQgSQ0KPj4+
PiBkZXNjcmliZQ0KPj4+PiBhYm92ZT8NCj4+Pj4NCj4+Pj4NCj4+Pj4gcGF0aCBJIHN1Z2dl
c3QgYWJvdmU/IE9yIHBlcmhhcHMgSSdtIG1pc3NpbmcgYW5vdGhlciBjb21taXQgdGhhdA0K
Pj4+PiBzdG9wcw0KPj4+PiBpdCBoYXBwZW5pbmcsIGV2ZW4gYWZ0ZXIgeW91ciBzZWNvbmQg
Y29tbWl0IGFib3ZlPw0KPj4+Pg0KPj4+DQo+Pj4gSW4gb3JkZXIgZm9yIHBhZ2UtPm1hcHBp
bmcgdG8gZ2V0IHNldCB0byBOVUxMLCB3ZSdkIGhhdmUgdG8gYmUNCj4+PiByZW1vdmluZw0K
Pj4+IHRoZSBwYWdlIGZyb20gdGhlIHBhZ2UgY2FjaGUgYWx0b2dldGhlci4gSSdtIG5vdCBz
ZWVpbmcgd2hlcmUgd2UnZA0KPj4+IGJlDQo+Pj4gZG9pbmcgdGhhdCBoZXJlLiBJdCBjZXJ0
YWlubHkgaXNuJ3QgcG9zc2libGUgZm9yIHNvbWUgdGhpcmQgcGFydHkNCj4+PiB0byBkbw0K
Pj4+IHNvLCBzaW5jZSBvdXIgdGhyZWFkIGlzIGhvbGRpbmcgdGhlIHBhZ2UgbG9jayBhbmQg
SSdtIG5vdCBzZWVpbmcNCj4+PiB3aGVyZQ0KPj4+IHRoZSBjYWxsIHRvIG5mc193cml0ZV9l
cnJvcigpIG1pZ2h0IGJlIGRvaW5nIHNvLg0KPj4+DQo+Pj4gV2UgZG8gY2FsbCBuZnNfaW5v
ZGVfcmVtb3ZlX3JlcXVlc3QoKSwgd2hpY2ggcmVtb3ZlcyB0aGUgc3RydWN0DQo+Pj4gbmZz
X3BhZ2UgdGhhdCBpcyB0cmFja2luZyB0aGUgcGFnZSBkaXJ0aW5lc3MsIGhvd2V2ZXIgaXQg
c2hvdWxkbid0DQo+Pj4gZXZlcg0KPj4+IHJlc3VsdCBpbiB0aGUgcmVtb3ZhbCBvZiB0aGUg
cGFnZWNhY2hlIHBhZ2UgaXRzZWxmLg0KPj4+DQo+Pj4gQW0gSSBtaXNyZWFkaW5nIHlvdXIg
ZW1haWw/DQo+Pg0KPj4gdGhhbmtzIHZlcnkgbXVjaCBUcm9uZDsgbXVjaCBtb3JlIGxpa2Vs
eSBJIGFtIG1pc3JlYWRpbmcgdGhlIGNvZGUgOikNCj4+DQo+Pg0KPj4gTXkgdGhlb3J5IHdh
cyB0aGF0IHdlIGhhdmUgbmZzX3BhZ2VfYXN5bmNfZmx1c2ggZGV0ZWN0aW5nDQo+PiBuZnNf
ZXJyb3JfaXNfZmF0YWxfb25fc2VydmVyLCBzbyBjYWxsaW5nIG5mc193cml0ZV9lcnJvcl9y
ZW1vdmVfcGFnZQ0KPj4gKHRoaXMgaXMgYW4gb2xkZXIgdjQuMTQuNzItaXNoIGtlcm5lbCku
DQo+Pg0KPj4gVGhhdCB3b3VsZCB0aGVuIGdlbmVyaWNfZXJyb3JfcmVtb3ZlX3BhZ2UgLT4g
dHJ1bmNhdGVfaW5vZGVfcGFnZSAtPg0KPj4gdHJ1bmNhdGVfY29tcGxldGVfcGFnZSAtPiBk
ZWxldGVfZnJvbV9wYWdlX2NhY2hlDQo+Pg0KPj4gdGh1cywgYXMgeW91IHNheSwgcmVtb3Zp
bmcgdGhlIHBhZ2UgZnJvbSB0aGUgcGFnZSBjYWNoZSwgd2l0aA0KPj4gX19kZWxldGVfZnJv
bV9wYWdlX2NhY2hlIGNsZWFyaW5nIHBhZ2UtPm1hcHBpbmcuDQo+Pg0KPj4NCj4+IFdpdGhv
dXQgeW91ciB2NS4wIGNvbW1pdCwgbmZzX3BhZ2VfYXN5bmNfZmx1c2ggd2lsbCB0aGVuIHJl
dHVybiAwLA0KPj4gdmlhDQo+PiBuZnNfZG9fd3JpdGVwYWdlLCBuZnNfd3JpdGVwYWdlX2xv
Y2tlZCwgbmZzX3diX3BhZ2UgdG8NCj4+IG5mc190cnlfdG9fdXBkYXRlX3JlcXVlc3QsIHdo
aWNoIHRoZW4gcmV0dXJucyBOVUxMIHRvDQo+PiBuZnNfc2V0dXBfd3JpdGVfcmVxdWVzdC4N
Cj4+DQo+PiBuZnNfaW5vZGVfYWRkX3JlcXVlc3QsIHdoaWNoIGl0c2VsZiB0aGVuIGRlcmVm
ZXJlbmNlcyB0aGUgbWFwcGluZzoNCj4+DQo+PiAgwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9j
aygmbWFwcGluZy0+cHJpdmF0ZV9sb2NrKTsNCj4+DQo+PiB3aGljaCBpcyB3aGVyZSB3ZSBj
cmFzaC4NCj4+DQo+Pg0KPj4gT2J2aW91c2x5LCB0aGVyZSBhcmUgYSBudW1iZXIgb2YgYXNz
dW1wdGlvbnMgaW4gdGhlIGFib3ZlLCBzbyBJDQo+PiB0aG91Z2h0DQo+PiBpdCBtdXN0IGp1
c3QgYmUgYSBwb3NzaWJsZSBwYXRoIHRoZSBjb2RlIGNvdWxkIHRha2U/DQo+Pg0KPj4gRG9l
cyB0aGF0IHNvdW5kIHBsYXVzaWJsZSAoZ2l2ZW4gdGhhdCB2NC4xNC43Mi1pc2ggY29kZSk/
DQo+Pg0KPj4NCj4+DQo+PiBIb3dldmVyLCBJIG5vdGUgdGhhdCBpbiBhIHN1YnNlcXVlbnQg
djUuMiBjb21taXQ6DQo+Pg0KPj4gMjI4NzZmNTQwYmRmIE5GUzogRG9uJ3QgY2FsbCBnZW5l
cmljX2Vycm9yX3JlbW92ZV9wYWdlKCkgd2hpbGUNCj4+IGhvbGRpbmcgbG9ja3MNCj4+DQo+
PiB5b3UgcmVtb3ZlIHRoZSBjYWxsIHRvIGdlbmVyaWNfZXJyb3JfcmVtb3ZlX3BhZ2UgZnJv
bQ0KPj4gbmZzX3dyaXRlX2Vycm9yX3JlbW92ZV9wYWdlKCksIGFuZCB0aGF0IGlzIGl0c2Vs
ZiB0aGVuIHJlbmFtZWQNCj4+IG5mc193cml0ZV9lcnJvcigpLCBhcyBwYXJ0IG9mIGEgbGF0
ZXIgdjUuMiBjb21taXQ6DQo+Pg0KPj4gNmZiZGE4OWIyNTdmIE5GUzogUmVwbGFjZSBjdXN0
b20gZXJyb3IgcmVwb3J0aW5nIG1lY2hhbmlzbSB3aXRoDQo+PiBnZW5lcmljIG9uZQ0KPj4N
Cj4+DQo+PiBXaXRob3V0IHRob3NlIGNvbW1pdHMsIGFuZCBhbHNvIHdpdGhvdXQgeW91ciBh
ZGp1c3RtZW50cyB0bw0KPj4gbmZzX3BhZ2VfYXN5bmNfZmx1c2ggSSBtZW50aW9uZWQgZWFy
bGllciwgaXMgaXQgcG9zc2libGUgdGhhdCB0aGUNCj4+IGNvZGUNCj4+IHBhdGggSSBwcmVz
ZW50IGFib3ZlLCB3aGVyZSB0aGUgcGFnZSAvaXMvIHJlbW92ZWQgZnJvbSB0aGUgcGFnZQ0K
Pj4gY2FjaGUsDQo+PiBjb3VsZCByZXN1bHQgaW4gdGhlIGNyYXNoIHdlIHNhdz8NCj4+DQo+
Pg0KPiANCj4gT0ssIHllcyB0aGF0IGlzIHBsYXVzaWJsZS4gVGhlIGNhbGwgdG8gZ2VuZXJp
Y19lcnJvcl9yZW1vdmVfcGFnZSgpDQo+IHdvdWxkLCBhcyB5b3Ugc2FpZCwgcmVtb3ZlIHRo
ZSBwYWdlIGZyb20gdGhlIHBhZ2UgY2FjaGUsIGFuZCB0aHVzIGNvdWxkDQo+IHJlc3VsdCBp
biB0aGUgY3Jhc2ggeW91IGRlc2NyaWJlLg0KDQpEbyB5b3UgdGhpbmsgdGhhdCB0aGlzIGNv
bW1pdCBvdWdodCB0byBiZSBjb25zaWRlcmVkIGZvciBzdGFibGU/DQoNCjIyODc2ZjU0MGJk
ZiBORlM6IERvbid0IGNhbGwgZ2VuZXJpY19lcnJvcl9yZW1vdmVfcGFnZSgpIHdoaWxlIGhv
bGRpbmcgDQpsb2Nrcw0KDQpvdGhlcndpc2UsIEkgdGhpbmsgd2UgYXJlIG9wZW4gdG8gdGhl
IGNyYXNoLCBzaW5jZSB0aGUgY29tbWl0IHRoYXQgDQpjaGFuZ2VzIG5mc19wYWdlX2FzeW5j
X2ZsdXNoKCkgdG8gYWdhaW4gcmV0dXJuIDA6DQoNCjE0YmViZTNjOTBiMyBORlM6IERvbid0
IGludGVycnVwdCBmaWxlIHdyaXRlb3V0IGR1ZSB0byBmYXRhbCBlcnJvcnMNCg0KaXMgaXRz
ZWxmIGluIHN0YWJsZS4NCg0KDQpjaGVlcnMsDQpjYWx1bS4NCg0KDQotLSANCkNhbHVtIE1h
Y2theQ0KTGludXggS2VybmVsIEVuZ2luZWVyaW5nDQpPcmFjbGUgTGludXggYW5kIFZpcnR1
YWxpc2F0aW9uDQo=

--------------qjisVIH5zzgEN2g7gi2YAC4E--

--------------mVyLThJDegBL90wdA5w6lRll
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmENqNgFAwAAAAAACgkQhSPvAG3BU+Jv
kQ//SVAJ0a2SbsHBaLpwoSMgb3ZhIkjj+4P36d2cajekq8Js0kjeFePVf7ZSK9SQ/DEcwCma8ghf
eZBIiKi4ff81y4TqOqRnOBZA9p4Gp93rqqoXcqYyXXvTFRZezjXDKI2tUYlKKJT4Rj4bZXVqDzvE
y6ccS6MHabCgOZb/RGE0WJdbalUZYoyoiICt5A09uYPv9qGCLRoQSZmDr/TeMWYQCX0Rg6LAO2bC
iRWvoWlxcZ7KU5HaKNndQ9kz0QF4AnYlVPgDQtom4tIly4PGjVBAVNz+tz8/Ixks+aJ/uwv3Aidl
zZIKP+l35VnLrxJh6HhH671/t/h93l/CWi7NLtbsFo8GlHH8uM6/74y5RZxU30+MY930x/KdDiNG
ZaEuX468NpJn9ho1B9AdfhhxCr1kpFAAxOFLmSd4JmSVurgO8Z6JmHsA4s68ZgVEOQp6oeEhmyqy
tE51Ji8MTFzhgZVZy8Ac+ZpTKoqbpB5hW4dDYdSuD7rPRjGIRwlFRghnokPI4wPIDi4aw4idNU17
/liiah4riWvkZiFVvgUKhjH31/vBMfFynQE4P62wLGAmhvHb9Bu5S7flcUlzMylkBGP1Yxp5v/EG
86R1/sFQ5LkG2cYY+i9GUnDj8pBBzp4I/qt2JXJwwn+1Y7GL71Ff4IPZiV03zEQETosjpsG9D8FP
bbQ=
=FqpS
-----END PGP SIGNATURE-----

--------------mVyLThJDegBL90wdA5w6lRll--
