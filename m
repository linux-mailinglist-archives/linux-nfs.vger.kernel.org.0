Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A262915C
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 06:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiKOFIQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 00:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiKOFIP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 00:08:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220D140FD
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 21:08:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF4B7hF004375;
        Tue, 15 Nov 2022 05:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=t/Zf3s+ubSObQUjLqZmqu0PSr/HjsLZA6V+srz9o5SI=;
 b=uu0Ux3H4G2uU4uPRCymWIFJ5fOH48LCpk+aaXEFEH8rbkEcC9g2WPTjr9YDzPan8KvYw
 9B3qb+5tm6N4KIwvsWLWkG7388shaiB6FbtQglD4n30uBjkg2h0Lz/M/SK3dC0kk7MsI
 Fu0T7m6aeeU4SerfLnJ2uvWYCR1M1RPJc9aDSscvrpXZp0yITCO53AkuPlbVmNTO6Yyw
 6m40zl6Qf6q5LeSG0wrUGFiMvThAkjZ2OIr37eQEnVTLmVbGWFmC0JOMQi9ifrNqUfHD
 3/Zgnh/BNTJHuKE/Oqf63k/MLyiylPD9IS4szB0bX1Tb+p9TA+1AH5YO636/SCsVNzTs rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3h4g2c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 05:08:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AF2OwSg010271;
        Tue, 15 Nov 2022 05:08:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xbegyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 05:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuLxY2jbKrBFlqUPqAdFT1+hMWZ0+i5pJ/620epqMOuWBv9rn0NVvA5flVd5kZrXPWHc6vH+KvUSpYXv94KxB7SuvKig/G5sUYtVhp6hbZHRHL3F+JBS8NIy2lC15V8Bkv2TspAZr9It4T2OLoDaGHVHcTPOUAe4mlwgI1bffBhgM1IjfmJTP4Es/FyCqDPJWcYia8Dhl5bu8atSCZmdR7+9PKN97MlPcP8ZhBZWOC2X8kI2qACpCnWhN+K9unrKAUNOFdcQBQbg7EWhrVrVl3+aqPhSFTqtUrEYwZ6sFy5aetmCrHh2fles30z8kc7x+HVl7h+7xZ0xILnIJydEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/Zf3s+ubSObQUjLqZmqu0PSr/HjsLZA6V+srz9o5SI=;
 b=DTpfNkT60woUPTY3PsYGhY3oIoJnPQ9TZzxVOSetd8lDYcIz5UNgmrbJ8x3mr2fbx69hf8Jgwih7/GYW92ILX+XPhhUXWSvIbGbvYujDWb4+qZfXTyxMSFb0O8iJRVN+1s+Zsa2I1r0AzjvdWKnF6vX1YELk9KHj/iVKGH84gTs1gbIzK7lG93LMjgk7qln1nmlHYV4fhZRiJQGd6cctRUAqRlN73K7R9wZMNHNrSFJQ3gpMpg8scyI88MlfOO/RDlmK2KCj8KqwZUNcO/ROYp99lHNKl60Gqvn+xfVx+yg7wNR2c9oeGHaouFWtN4AGISsyqwgripsSQlE1M1U7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/Zf3s+ubSObQUjLqZmqu0PSr/HjsLZA6V+srz9o5SI=;
 b=sGrHFRuAc3mB3+zf9P5AqjZ/aMshgXXc+uPhFdaCCJ+cCVM+vWtVhXCbin6Ngk5pDtwH2AWIZ8Q8Z5NuiOmDBWnxi8Y41mhgKAXdVA75xz75+rmMyuV61iXvOtV9ZWkH35HKHhymi5K8e8Q5l8a3nGL3GmFsJXc5Kl9ar/6zO5I=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA1PR10MB6808.namprd10.prod.outlook.com (2603:10b6:208:428::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 05:08:08 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 05:08:08 +0000
Message-ID: <3ea87405-ea0e-1a4d-63ca-7bf89188b034@oracle.com>
Date:   Mon, 14 Nov 2022 21:08:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
 <1668053831-7662-4-git-send-email-dai.ngo@oracle.com>
 <F69554A8-20BB-482E-AF8A-94F90B1081FD@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <F69554A8-20BB-482E-AF8A-94F90B1081FD@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:806:125::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA1PR10MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: e3080414-ce24-4a7a-6834-08dac6c762e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sb7vvEl/qcwFPw0RbT71FI4TkjL0mVCi/gwBMO9aOLJSh9sBpueuAUzDUnXvo/NuJEA5KX/frXX8TNiUfMjCcDHu3gcFMuFkKC7SLW/01ojzAuL5cAOzaIEwOZh+VB+kMLtgk1lT78rFGp6tuXfy0TGkLoK8Pz0z044sKGtiVjJC0VVQLI5UZQk2uMOe8oA0LH5BgeGTUxLWiPLsR3z72vroyCCHp1hMff9Q0Qd5F/KdnbSZswiF1t/5jRP2RjPwohBGQAq4W6nHzZa83o+FZCliSC348lyZFruS+mtEd/N2wPoK8+LxOY8T+gF/pJC/6rgrlop/bGFCyFv7M/VRuELpIlUtWPHNOhfTMTeZOruNZJO77ZRSnZozVwgGo8bm/1l166k2vSa95x1lZ5Yg1L03wUZNz8e6EcNOVpu9TnuqNB1W8CeN5FxTjSUL5TiD3eCrsVYl5ciUnKUNEkK+NJI01qN4qBJQlDYcTSrN8vHjvNlcwse7R1r14y4bO2JY9oYwDD1lQUPJTvSwoIDBNNja3F42/Rr+/DjydsXcGVN9eYR7aC6BLTMHALKvhUf9A28Z8kyXXfINSbplOhb3mmtg83GKQWKVjenSnz/TYF5rCiP8hzkj31UzbMHdchGYTYy8q3VZjSdlu5zVnQ2M1ToDeEoBeAoRfI45X9Dri9eV2TtKYNLdYYIHZbf5bag3oXmayJrdfXBavDl3IexrW920tb6DGQOt0YeERVOoPiTIeSGfdc72giFcLpNxIR5V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(31686004)(36756003)(86362001)(31696002)(66476007)(66946007)(4326008)(66556008)(8676002)(5660300002)(38100700002)(83380400001)(6666004)(6486002)(2616005)(41300700001)(478600001)(186003)(6512007)(6506007)(26005)(2906002)(316002)(8936002)(54906003)(53546011)(9686003)(37006003)(6862004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWo4WHdQbG5FVkhCbGp5VHRQWTkxaUlwdGhJV0FaQWlmM0lINEZsbEl3ZG1J?=
 =?utf-8?B?M1E3WmtDakIvUWdRL0l6S2pENE9ZVGQ4UzN0aEtucUd1T05UQ0Z5NE5BL1RD?=
 =?utf-8?B?Y3ZRaU5tNWVyeVZoUWc4SzZHa1RhbzV6UXBYTlVGSEpBUW1LMXRXaVUrUEJ2?=
 =?utf-8?B?YW0rZXhvOWk4MncwMm1SeEZCV05kTkxsN0NJblo1ZEJ6eXdaZEdsN0UzSFZv?=
 =?utf-8?B?a2UrK2VRRklhK0Y1K1hTQjVJUTBTODZZZUx1SlNnTDROaEtuMTJWRU5LcHVx?=
 =?utf-8?B?cGowQ3BzQmtaU3pPWmt0Y3NJOVovOVIrbkpQL0dVdW9ub0s1a2phY0RRTnhX?=
 =?utf-8?B?dHhpZlNqcWdxODhKTnp6Y2VOeGtXQzZIQnd4VkJXdGI5bjBXTjFSSWFZRjF2?=
 =?utf-8?B?RlJndHZDdjIwVXMwc0ZXYlF4MXNZTm9yYWIzZDY2TFh0d1dXR2lINURJdEZ6?=
 =?utf-8?B?bWI5T2UwVzNEK2hYTFBMciszWU9PS1p1cFFjSStOVU5IWUk5cTErWXp4a21r?=
 =?utf-8?B?RXpCcU83R1lwb3d2S1U4d3c2V084N2NGOTdQV3pnR1FRKzFSNkFjZFJrOExy?=
 =?utf-8?B?WGk5WmY5RVIxOWxsS3l3TUZ2V1NNeGdXaXJLbCtpY0lZQkFaSUpESFN6SXdn?=
 =?utf-8?B?U29nb1daWlUzMHpMVXJleEVGQlhEa2daT3JOT1MwRWFoU0gxYnZiRnJySjEr?=
 =?utf-8?B?ZHBOYzU5UVBlQU5OVWlNa0ZRYmhuRkVWRjJtZXFnR29KVnJyTHYydEY5QzEx?=
 =?utf-8?B?ZjY4UGpqRUlkUktjNlZQN2d1N01mZ2s5bklOTXBxRlhadFVZamNHSkJCRks4?=
 =?utf-8?B?WEZLRnFXdThmclg5NjJ1dDJuREtCekQ0b2d0VlRjZDBGdzNzcmJpWUZOYjRM?=
 =?utf-8?B?dTNhemNlZTBYc0tMUy9lY1drempuZ2xuSFMvZ1p3YytFcmJtbWVwRDdRV2or?=
 =?utf-8?B?TmVUNlcyVHMvdUp1Qy9HVkUxRktmUXk2RWNlWUxKZWIveSt6RmZRMmZ1ODZJ?=
 =?utf-8?B?UDc0YnpKbkswKzhTTWxkc28yREUrcVU1ay90ZmdtYnBoM1M1SE9YM2d0bWE3?=
 =?utf-8?B?SW4xMU5vd3JCeUZ5YmdCOVJheXBxcnJudEtQSHRQVWp6UCtLek9aQTd1blpG?=
 =?utf-8?B?VTJ0ZFNtUjRFYTREbWtVekh6cVllNEc4YXBpbEwzSWp3VjJFRWZ3cEgxNC9Q?=
 =?utf-8?B?RzJIK0FMVzNRQ21YTHIxRi9acERqZVlhMjNmVEdaakVSVkJENUdleE9XM0dP?=
 =?utf-8?B?UHc5aUE1bEZGdi80UTdvMFhZcXNmYjI3YlFRMHhRYmMzZnFPOFVsYTJSZG9K?=
 =?utf-8?B?QmJlNStKd1ZZUERUdHFQbzRGV2tVNzVPUHlDNEhnMEExU3c5dnd4Ymhxc3RS?=
 =?utf-8?B?elpxY0Q0YTlPYWhiQUtmT0tibkFFZFpvQUFlRFZjaUdSZ1VnZzcxNnVPQUxR?=
 =?utf-8?B?bzR6Q2xON1JWS1BCdWRqbTZhWEQxaDdudUFBOWU1VWY5V1VWQ0ZJU2g1Lzdw?=
 =?utf-8?B?NHFRbkUzcmVOV2lHWjU3UHUvSGYwQll0cWFFTWtLSGo5ZFIzTDErQ0hCT3I1?=
 =?utf-8?B?cmordVVGeGdUVnh3NHFCUWZ6OTVzeGQxL25JM2pnWjI1Y2NPNHdWYWRZOFhk?=
 =?utf-8?B?dXRRYW1VczRDN3Z3TGUyVm1zcHE0cUZ4MGJxZVR2Sncvemk1ampQc1ZCYTgr?=
 =?utf-8?B?YTJpelhRMFdqTTRsM3VKUyt1TDhYMkYrVXpkY0o1cE9UWlRnUHArSHJ2VzR0?=
 =?utf-8?B?ZWRjYjAwb2pzUFdQUTJJYXRmREFaNk5hTzFVbXgwbTNuSUV4OEg3OTBudXA2?=
 =?utf-8?B?OGRDeEFmWTRVMlR1QktOQkhycEYrL3BWTlIxczd1TVd4QnB6dHVtbjNGdzlr?=
 =?utf-8?B?ekR2d0ZiNTZtN25WODMySHk2bDRKMDVzeUlpRXM2YkFmNnBMdElkSk82VHJR?=
 =?utf-8?B?Sk9iRkhBUVhyak1jQ3RYZDY1NHNzT2ZTUjhCZm5YNmNaeG1NQm5IVnY2a0du?=
 =?utf-8?B?UXc0L2U1WkE4S2thamZ4WnUxUmdwcFRKV3hiUVVha3crUGRjN3lEQkNyTXV2?=
 =?utf-8?B?ejVlMjVGT3VEUG1ZNXNyR3JUS29JQTlLRFdHSnhnRlhHQVBLNHBDRjdLOVM1?=
 =?utf-8?Q?GCIwzQ+aybjzHlT0YuPG/RPsL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IeVuXOY4YqFLt2bYzaMmysTwkFRDDkgwZcBvWi7Guo6XpCM2OSGnihzmk6htkxWPWW0oYsd+2uTvbv0YrLrwci5QaaYn5Ab6NXGfJz8xSzajbaRdohJ5jzCeuPaDxdwKi5DXki65ZpI2Us4woAU1cLJzLFZe1Y+7ujNRQoyf9uGTwXBM8/3corfjcIGctRBHQUvZgVKZ+RzHR98QKK4GNgQjajyhFRucQGNkufV15SvdlimGktPFdkzCSBgIK2uRuSIs5kMP3i1VRA0cwQ3qYLkjmKCSA1xzPTvSqBeQ5LxStkppBb8EkV2WcDeUkHq85R9WtgUrMmM29bVEeKmaXRyJoZj63jlYqjOylNmfZRJDsKehfPjMvMh4NeHPxTHTjQmPWoe392jq1i2X9WG5ycbjRwvs9djdCusIwD0UWwLnEX9kpVjHGMamXB7jClHftD2gdy2OkHd+ut1vVXqUcE7OnUbgi0w3ZERX1/7+WjFJB0hwiyqRaTyQP0qIYLN3OfQO7mWYY4iwlmkZR/aIivu78bBaj5PjUtoKi+xGNTesqYWG0VZHo8JFUzOy2c/FmU0tyLjmkaZyhmQKKyzF/hm4H+DbJAToYhIu361deTwIdK3eOQd0QvTD4lQ5+H+FJQirrdOT4x6EgV0zPaA5Q0YL5xypEgTYSOw4k5HV3ybwpxu05cI21oHUk/ZmZ5geTW3hrTvGfd2kGIMlCUQkjTte7b5MzuRO+7tX24Pa/oMw6jCDx4XorcT6sL6ANCP4XD5HPhydp19BLi/1YjcMtJo86C1ZNvoWkKgFeEPMp7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3080414-ce24-4a7a-6834-08dac6c762e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 05:08:08.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJvAjAlsMn/emMNj5dM5IVWBBFmLPHoO3lNixebDXLDpBRLJNWab921vhHC38R1tG8wlIQZPPvWmDkPxAYa9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150037
X-Proofpoint-GUID: eQXizcOzqQZRg8QlVUibLHe47STOHMEN
X-Proofpoint-ORIG-GUID: eQXizcOzqQZRg8QlVUibLHe47STOHMEN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/11/22 7:25 AM, Chuck Lever III wrote:
>
>> On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add tracepoints to trace start and end of CB_RECALL_ANY operation.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |  2 ++
>> fs/nfsd/trace.h     | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 55 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 813cdb67b370..eac7212c9218 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2859,6 +2859,7 @@ static int
>> nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>> 				struct rpc_task *task)
>> {
>> +	trace_nfsd_cb_recall_any_done(cb, task);
>> 	switch (task->tk_status) {
>> 	case -NFS4ERR_DELAY:
>> 		rpc_delay(task, 2 * HZ);
>> @@ -6242,6 +6243,7 @@ deleg_reaper(struct work_struct *deleg_work)
>> 		clp->cl_ra->ra_keep = 0;
>> 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>> 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>> +		trace_nfsd_cb_recall_any(clp->cl_ra);
>> 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
>> 	}
>>
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 06a96e955bd0..efc69c96bcbd 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -9,9 +9,11 @@
>> #define _NFSD_TRACE_H
>>
>> #include <linux/tracepoint.h>
>> +#include <linux/sunrpc/xprt.h>
>>
>> #include "export.h"
>> #include "nfsfh.h"
>> +#include "xdr4.h"
>>
>> #define NFSD_TRACE_PROC_RES_FIELDS \
>> 		__field(unsigned int, netns_ino) \
>> @@ -1510,6 +1512,57 @@ DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_done);
>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
>>
>> +TRACE_EVENT(nfsd_cb_recall_any,
>> +	TP_PROTO(
>> +		const struct nfsd4_cb_recall_any *ra
>> +	),
>> +	TP_ARGS(ra),
>> +	TP_STRUCT__entry(
>> +		__field(u32, cl_boot)
>> +		__field(u32, cl_id)
>> +		__field(u32, ra_keep)
>> +		__field(u32, ra_bmval)
>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>> +	),
>> +	TP_fast_assign(
>> +		__entry->cl_boot = ra->ra_cb.cb_clp->cl_clientid.cl_boot;
>> +		__entry->cl_id = ra->ra_cb.cb_clp->cl_clientid.cl_id;
>> +		__entry->ra_keep = ra->ra_keep;
>> +		__entry->ra_bmval = ra->ra_bmval[0];
>> +		memcpy(__entry->addr, &ra->ra_cb.cb_clp->cl_addr,
>> +			sizeof(struct sockaddr_in6));
>> +	),
>> +	TP_printk("client %08x:%08x addr=%pISpc ra_keep=%d ra_bmval=0x%x",
>> +		__entry->cl_boot, __entry->cl_id,
>> +		__entry->addr, __entry->ra_keep, __entry->ra_bmval
>> +	)
>> +);
> This one should go earlier in the file, after "TRACE_EVENT(nfsd_cb_offload,"
>
> And let's use __sockaddr() and friends like the other nfsd_cb_ tracepoints.
>
>
>> +
>> +TRACE_EVENT(nfsd_cb_recall_any_done,
>> +	TP_PROTO(
>> +		const struct nfsd4_callback *cb,
>> +		const struct rpc_task *task
>> +	),
>> +	TP_ARGS(cb, task),
>> +	TP_STRUCT__entry(
>> +		__field(u32, cl_boot)
>> +		__field(u32, cl_id)
>> +		__field(int, status)
>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>> +	),
>> +	TP_fast_assign(
>> +		__entry->status = task->tk_status;
>> +		__entry->cl_boot = cb->cb_clp->cl_clientid.cl_boot;
>> +		__entry->cl_id = cb->cb_clp->cl_clientid.cl_id;
>> +		memcpy(__entry->addr, &cb->cb_clp->cl_addr,
>> +			sizeof(struct sockaddr_in6));
>> +	),
>> +	TP_printk("client %08x:%08x addr=%pISpc status=%d",
>> +		__entry->cl_boot, __entry->cl_id,
>> +		__entry->addr, __entry->status
>> +	)
>> +);
> I'd like you to change this to
>
> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_recall_any_done);

TP_PRORO of DEFINE_NFSD_CB_DONE_EVENT requires a stateid_t which
CB_RECALL_ANY does not have. Can we can create a dummy stateid_t
for nfsd_cb_recall_any_done?

Note that nfsd_cb_done_class does not print the server IP address
which is more useful for tracing. Should I modify nfsd_cb_recall_any_done
class to print the IP address from rpc_xprt?

-Dai

>
>
>> +
>> #endif /* _NFSD_TRACE_H */
>>
>> #undef TRACE_INCLUDE_PATH
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
