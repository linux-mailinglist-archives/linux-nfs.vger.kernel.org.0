Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912684595E9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 21:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhKVUJv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 15:09:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63862 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233933AbhKVUJr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 15:09:47 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJUEYh031839;
        Mon, 22 Nov 2021 20:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J5k61I910YN5te/uVLsmtiGvqd1Aopb6lmiD6/K5kD8=;
 b=o37uFqF9Nz3j6Y5BJxgVW8qAl/gzt5FX6Y3d9nE01RPVsyUi0p/a9DSkGQSKdK529D5X
 3KWnV1CnGytmdYxHk1WcQdojddX+CmNvUybSYwnpHIOLMH+IYtKGTt9YPc6dnz4id41X
 8vKW/E5AqORqkyM5gt8V0Fs3IjedOVcz1Qk/2653mcQ+XPGt/BEUWIcnEEqKc5ZPsgSP
 7T0zuSLSF814w1lz8672T6w8Hy4aI28NjhMdeZDQ2CDP5ckZnX4AWPB5vm/3dXOYT3uZ
 oVhoM3tKep3+gavcIQBi94r1M79qwXxc5vC6wdYlG1xd+mPyBwZAeOmBN4uznHyk2JVv Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg461cghh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 20:06:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMK0oLG119971;
        Mon, 22 Nov 2021 20:06:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3cep4x8909-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 20:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUHl1+nllReDbbtlvPXLwrFyOIsrODoY3bUJzKlvNYgyZ13PjumLECxx4tJX4maR6P0kdBOX0b90lCK/sX0APhKtE4Cm8AeKLZ5gQVLwD2nspzerQM7FT7paCO7FZjqbRm6dp2XZPIVCwwPGozIECJXsL+I6JKk4Ktw3upav36OwNKqEt081hZ8j1qG1IneZb+Wg+zBMuYebm/mqNZVERnS6O4lT6nIDwb0b4TJ0fAS8sJb8gSduMSNAP1u4875AfLvNRIynDeg+GtxvUVZwft0MwcNKAvvEwHtjq9KrAa9gVGy9W1/eEnZysADLt14R0QBFampZldLkRx8Gsu4vdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5k61I910YN5te/uVLsmtiGvqd1Aopb6lmiD6/K5kD8=;
 b=Vddb9Ijx9s9W6JSnWE6DMw1ftMsIInslAo4A3oh1rvYTCRQ0vjzANx3CHSKCINVWEJHiFz7vI/BvpjRfscnxFpmf2VWNZYlG8rnra9i6cqMtPgfp3VasZCPT8fwVrf/MIkm5dU/VRc/xx3P+YQVSLolK81gnnItw+k9RXTyUCq71R/9KYmJK2tOKnM6dZegJa3nRH3mOOXlIpo5sirybyGpfrWuQEMJ7bWCKQI+VrQwYrY8ysp6TCblcaNgLg/eT4YEfTuJs4/nIRBNUlqxUfZ/EYzFB7uWjvqQcb+BfLG4liie8rwUhZxFLkM42jN3wo22sOm9JIta9BiI2a34ZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5k61I910YN5te/uVLsmtiGvqd1Aopb6lmiD6/K5kD8=;
 b=wfZCshFofemz8Tm1sr3P2qVJTDpqo1YorddNCFOY34RU5n6vYE1OYmpxvQGggsRrevcwzWFk/ZauhC9EXyEEpEE6BFVzzGD9lubSwOkpFROnCfYGJMgFOmj+Cn4+WIZ1shrgmPZHJX28RnyNFPjHGFr/trsia7N01h8nFMfaTIU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3671.namprd10.prod.outlook.com (2603:10b6:a03:11c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 20:06:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Mon, 22 Nov 2021
 20:06:05 +0000
Message-ID: <e72ec739-b055-c1d8-4551-c38d4d453d4a@oracle.com>
Date:   Mon, 22 Nov 2021 12:06:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: fs_locations question
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyEXpxcfWSjOrWsCRiyYvZmh6pk7gZKBz=XApr0d4z1fGQ@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyEXpxcfWSjOrWsCRiyYvZmh6pk7gZKBz=XApr0d4z1fGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:806:d0::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.131.147] (138.3.200.19) by SA0PR11CA0057.namprd11.prod.outlook.com (2603:10b6:806:d0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend Transport; Mon, 22 Nov 2021 20:06:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a03133f4-ca72-45eb-cb11-08d9adf383d1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3671:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3671D6990D9F5491879745AB879F9@BYAPR10MB3671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtZmp9KYSpBINZbEPQbIoLN1YrmjBIdeqR3FgFiOeartPSbnYNBkkh0TbcxMiNoU8i3/ilwI9KzHiitg1iblLwV28VAGYnCP9QpLMPhrZhkBoPXH0n8PES2NW99HNKzOYXs1iet5gpiN6Hv4T7CyXHjB0kBItqf74Kt+HYFt/RtVdRp+81DOSBY+30Xx2ywLY2JEsRcdhvvYMDuwaAXjXGF3GGO10lO+vv0Ja6waaWZCBXoMah6L6glNJJnwJ74j0e5udc+Y3NoYMkKKxGv1JxEVBZpZrtEPtyJH7fpu5oLa2qWl4OY7IESA/uIMZptUoUa0d0TECQM3Z2I7YLxrxg/9sCf8DHSbDenKBUH8rD0gRiaEi/U2VMZO8feM4ZPoPqhaKxI4QXamanKH5K8vYsU7lQfkDnjuCja8Nk7kFjMVxCaEg9xYeTy93pY6gWP4Sq41IfNkE1xkAz1EOoCWtcWnqsauGtl4IOjhrxff6thSdXUtgi3r5v0f2W9mN3K+vQyccLYKcRnAvhw3jA3bZqE1YuWCmAGTI+suK4fwxQXmw9Fv+m67y1Q9XVnCUdGzZD9uhKAgBp8zQNbc/6XlzAMbEGFG5AxXgztMITptfO/cUm53XAzH8FW+LE7p8arbY1a3B+qihYcYxly7eyHTGFYR6EqacKv2ge/tXhYRpZ6nmYBuDz7E40Pwim7a3vwc+9U0K9vTxndVHsg3P76V8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(9686003)(2616005)(26005)(66556008)(66476007)(508600001)(36756003)(66946007)(186003)(5660300002)(31686004)(31696002)(316002)(2906002)(53546011)(6486002)(7116003)(86362001)(38100700002)(16576012)(110136005)(4326008)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVESFRMaHgvL1BwOXppZ29VZXZZb3dEZEJTS2pZSjhXZFM1emdud08yK0VD?=
 =?utf-8?B?UndQeGEwRU1ySlJMWG9nVTJ1V3RqelR4ZTdZMWM0WFNIN2h0VkxQS1RXaUYy?=
 =?utf-8?B?V3c2WEIra1Iwem5WWXg0RkllWnVPSEplSDRTZzRRZXhtM0xGdGl2cHVZaENX?=
 =?utf-8?B?VDBxcTMzekN4R21ER3lBTmJES2hXMVdBS1BxQ0ltS3ZFSFRLbmJqL09jVDNn?=
 =?utf-8?B?UGdPZXBYZ2JIbXMvYUtLWVVwSTBTRlJaakI0TEJOKzd1ZkpOeDAwL1VmSFpX?=
 =?utf-8?B?WmNSTDc4bHdhRTNiR2Nsb2lrUFNVNXZXZnluOEJMeFhxb3dNTGdyVkhudXZR?=
 =?utf-8?B?V1MvTkRmb0trVkhlSWNsSGdPS1l0d3VLNnFHZVM1dUpDOEdNWEhEbWpMNXkv?=
 =?utf-8?B?Wnc1U0tscEtwWXE2NEQ5SlVxOG1wL1I2RkxRK0lFd21UUUxnSjBPM25hQmN5?=
 =?utf-8?B?dFRSUkZFMERWQnRZR3dqUzJWd0RHekNhMDhaN2lCMXFCRk1TQ1BBVnVwcVhX?=
 =?utf-8?B?cXFvMmxZMlRBT2gvN3lvUVUxRTZ0U0VraytlZ2dZTFBVZlZaTFNuNEpWbHZE?=
 =?utf-8?B?MkQxd3ZKUHdHSFNJb2VtdVd0U0pLTmdQd3FKUmRrRDNtSXVXQTFUamNjWTQz?=
 =?utf-8?B?WmRKQ3lVQU83WldDekxhQkJBbGIwYVVqYTFzY3E5NjdnbUhtUGpnZ1cvZmx1?=
 =?utf-8?B?UkZ3T1VQRGg4S0RBQ2VnUUxUcW9ESjRMbGlJdU8ra1dvWGlDa3l2YnE5eTZ2?=
 =?utf-8?B?Sm1JTDIwaFlubkh5OG4rV3NVc0pSSVRWSERzek5RaE5GS1c2ZWgxK2xvUGhq?=
 =?utf-8?B?THkzak9vNVRKSDFMSDR3emFSMy9OMDhURTlyZU1kdGVFMnVoMVNVRzRLbHBy?=
 =?utf-8?B?NEJ2OXBlRjR1SmNNcFErdCttREJsR3g2WHRrQ2NCNjJIU3ZkemxHWWtlV3pY?=
 =?utf-8?B?eFhWSmxHVk81clBTSmk1Nk03Y3ZiMUJiSkZmWWNaRldhSlY4QlIzTWt2anBK?=
 =?utf-8?B?blRsUnNIb0N3cVBxZElOc2hiZUsrUXBjdTNEc1FsbkZiQzBmSnhJYlhCb0t5?=
 =?utf-8?B?M252Rk9QSEJGWjFVWTVZM2ZEa3kzZlA3QURNSjdteTB3T3hoNTlhQkNXekpt?=
 =?utf-8?B?dHZRTFB4WThQSnJ1KzVoeFUwWHpCTWswTHpxTE9DOTkyNkVYZ3lIQ3FtNDFM?=
 =?utf-8?B?QVNoWVhqclZqRDJDYitpczZYNjFsSE1ubm1aUzY4TFN4YjE1YjFRWTJzUm1T?=
 =?utf-8?B?VE1TeGZCeTJjcERnOURVSDNCbndpZENIYkZPNlpIOStaZzdYRlZ0ZXptUXNl?=
 =?utf-8?B?ZnlhN04va1l0bHpZSEV5YjhEZmxSYlhmekxZdEtWUnRkMmIrK3pTbGlLeXht?=
 =?utf-8?B?TkFCWVRQeGJ0TkVIanZyNXJ6cVdHZThtei9va2RsVzdCR1NleDltTXhVTEk1?=
 =?utf-8?B?UC9ramdkdXR2MnRKQytDZjdNQ0V0RWo3cEwvVXdDbUpnY295RkgwSG9EQ0ls?=
 =?utf-8?B?UkxqZ0w1OGJnK1BMa0xhQjlud29SRjc2Y1lkQkNFbjlBSGg3Y0FoOXI0ZGds?=
 =?utf-8?B?YUM2RWVJT1V0N041Z0UxK0h6TXgycW9ZQXh1eStLRkhlYyt5eHZBZTdKLzFq?=
 =?utf-8?B?QituVWNpMW51ZEgrWEFLTDQzVk44UGxrd2NPaFR5WFNLNXB6UHJBbEJtL3BS?=
 =?utf-8?B?dXRrWkhEbUN6RkpJT1N1SklsWnJMK05zTEhDWVFJT04wYUdYZ1l2b08rVExU?=
 =?utf-8?B?NW1XTzNZOHRMREtCRnQ1b2N5UGtkUVNSYUsrbWxLVTRiQ2I0bnNUUFNhaTVs?=
 =?utf-8?B?VGZJRTZ6QnhXclhvMjF6bU9hMFM5akN4NU9kSHNscitVWjBraUpLVTJ4ckJH?=
 =?utf-8?B?WnJCWnNmL0xKaEU0VXRnS1c0SHoxWW9YUFRPb214MkVKOVdJbjd0eUN4TENa?=
 =?utf-8?B?ZStoYkhnRFZJdVhiblN2OEl2V1VMUEtubzZrQzFFbEc1eXQ2ZTE0NU9EUHcw?=
 =?utf-8?B?cTcrVFVrREYxY1Z6UFVJZUpjN2REN3N3WFp4dlRINDhXblhaNWQ4TS8zQjZ3?=
 =?utf-8?B?SWN6dk5ZdTUzdmFjMEh2ckxHZkRLK1JnQ0MrMDdxdTJZYWU4MlcyYklGR2pF?=
 =?utf-8?B?amlCMFN0clRzd1FFOHZNUnM0OWF6Y0FvcDFSN1pVaFZaNkNob0p1a1hFV2Jy?=
 =?utf-8?Q?ptnTOQoAGpyvD5DH7pHgFu0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03133f4-ca72-45eb-cb11-08d9adf383d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 20:06:05.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wTKwDWj3kNwjL14Zcm93D7lKxd1GQgKeTynarx8Mx8zSTi5zqmsipTsndHoWSdfEQsiMvnitjhVTwrg9GyRtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3671
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220100
X-Proofpoint-GUID: DOpb9AQOP-4vgbaHfq8uTYBA5gBvgsBk
X-Proofpoint-ORIG-GUID: DOpb9AQOP-4vgbaHfq8uTYBA5gBvgsBk
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/22/21 10:46 AM, Olga Kornievskaia wrote:
> Hi Bruce/Chuck/Trond,
>
> Question for you: currently, the linux server replies back with
> FS_LOCATIONS as a supported attribute. Yet if the client were to ask
> it for FS_LOCATIONS (on a root of the filesystem), the server's reply
> is a 0 value. I'm not finding anything in the spec that talks about
> what the reply should (or shouldn't) be. Is it the client's
> responsibility to interpret the 0 value reply as no other locations
> are available. Or is this an invalid reply and there should be at
> least the current IP present in the reply?
>
> It's unclear to me what and how this situation should be solved: on
> the server side or client side?

I found this from section 11.9 in RFC 5661:

    When the fs_locations attribute is interrogated and there are no
    alternate file system locations, the server SHOULD return a zero-
    length array of fs_location4 structures, together with a valid
    fs_root.

seems like server is doing the right thing.

-Dai

>
> Thank you for your help.
