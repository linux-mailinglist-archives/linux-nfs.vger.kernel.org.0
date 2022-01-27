Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C3749EEB6
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 00:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiA0XPy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 18:15:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12748 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241229AbiA0XPy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 18:15:54 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RLHiWp012335;
        Thu, 27 Jan 2022 23:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+NPjXSXUG4MdBsSCwnPUltrV9QosDui/4ToDuyOqA/w=;
 b=jMShN5gzUvJAUlm6GQRQX7rH0FarG11mYj07M34ZC8Eq80a/NxxeGdJEo6W66nv+N/dr
 MTCESYRf/2toKCuXSCfRAj2DhZpwkT2kkuKvLdq2CKR6QsbMKoGvemWEFBc9y64LfJjz
 Tj9Rx6puW6kfodEdvrKh410HEisDndjtMY5vjWt7QLsBgJSjJ4NZBoyuSkkkez9lacYS
 mIVXsvXZm3D6f0bBMuDoh9IHvT5zblUk0F9ODpQ+ol2A9nS5iD42uOY5EHOMNBKt0SGO
 28asLNPBG2L/tvNVBwwidkr4BU1l/7GIRmj+5HvqZI6E3Tb7BOFkPJXhQikMmikk32Bh 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnk9pbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 23:15:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RNAY8h143272;
        Thu, 27 Jan 2022 23:15:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3drbcuhaum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 23:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFjMm7z4+R2eGzB8NxuVLRqUR8iKadtSqA2a/X9YoKtbPB/vEAv9QpMXdcULI+DSmZGmkhZWO+e+twXQWaVU6E03W3Hz7nHpHJEqZpOcBM7MUw1aIO6i9LmQgIR9Bp52aBzGLLdTPmVnXhDPVILngwSKAzMSZhp6VQfKJcq8uzB+kTLgSr0v2Xcx3KYtvOIzCCa8tNLkbKZdjaJKxfDi2pCDNGLfZxpQ2QomW9DzVPn8X9E8qGPrrradpu6wsFMMR33QXzayzucmhbHMnK++yTsqcKOeHWCS9C9HBA72eYlgCCSRZYtxnr6HFdN0PAtF0w/opbS2VfsLzaUf016K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NPjXSXUG4MdBsSCwnPUltrV9QosDui/4ToDuyOqA/w=;
 b=m/xs0qHjEhwQYJww9mvhIW+7qvTKx/FGmg/DH/3y740UFv1Qn229S0i3iZmhLi2pb9HR41P0iIXK9FocSbVDyFQro5AwoKPkscQP60Y6o0YX+etSW6rPCft671+6DvnUUHPwP1kjltNauaclzksBU2Hi0DlJ58IZM8aK+R1jd2/AGJYhRYVZiJ/WDfMnbLnkc3LErV39FRgbbNWA2y/h4D/RqJpUASm0+8DOSMrjdm1pCkAvhUHEd4bnzdIZMMXiBUCOG4olcKUf/X/9x3Y/1Fwyf4oV+WNk1ldQEuKPvyy6Zt+oK5QvotK9HJz+2V7U8iMBEC1Id1QxEvwKnajPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NPjXSXUG4MdBsSCwnPUltrV9QosDui/4ToDuyOqA/w=;
 b=KlDyX5501YcfjiLbXEwvc9S2M/DPkzPumffra2Gi37zPDgSgkRDM4lVYHYGChJFoihRjgJx0TGfBWnBsmv6m2CtDa6TbRZvT6sNWCm4J8oIBYcB6Rs2qri/+GKCuZ8EfqmEU/xkeDrbu2+vn8RaGOEhF7Hhw2Vvrdwgs9ETwNN4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 23:15:48 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 23:15:47 +0000
Message-ID: <0aa72200-4ea8-16bd-e665-06f4852b0d66@oracle.com>
Date:   Thu, 27 Jan 2022 15:15:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>
From:   dai.ngo@oracle.com
In-Reply-To: <164332328424.5493.16812905543405189867@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0040.prod.exchangelabs.com (2603:10b6:804:2::50)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eab8be9-8c8c-482d-851f-08d9e1eaf3c1
X-MS-TrafficTypeDiagnostic: BN0PR10MB4936:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB4936BCC98B1DC6E069BEC6CF87219@BN0PR10MB4936.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSguwIzYB5GQo9/yzve6+PBeScZOgl9kkpag41cKhCy6enaiihmDOm2ivjUH9StOmCG9/iFh+BrXUWERpb7IrPEoUlS3qQVDYh0CCr0QCqJKAKK8ZfmaWcT5Gx8x/zfbwi1cFEcfxosf8F/+pZA8DoLz5RKj9+dW7rpJ3FEs6PRPFnqTvBAk3IIdrbjXun5O2yJVUh5Ay0D5wH5dxLDBvL9DNWKI6v3y2+auDWIZk/OtUOXewwrokcWD9V7qJsfdpPUeCkDa68Hs7rTc6RYMsoVW77PL58eYDCmB3id7yb6B4TpjBNWToJfP86Sb7X9wa+TMY51ekSaEKgotOr+y+R5J1EE9OAdu/G7buFo4/jYUKaiEOOosRzCb1upJQc7z7gX2HDwmRO5MMnCChGtrwcK6cDfSN0J1pNfp2pRBkN4czijeMNQ28lRrbOftockSIV7mXtdGhvoX5OM9flsgK09yw38AfPtsdfFYhYhh3yolq2GS9Wlf1+swcd5T2zgLmR5d/diaP8B6GVStLc9M7OAsUFmTY/2T4rP0ocHoxHXkLYyur1Ty5CFY/Z3I+x+pFCXJj/FiEa4fOEMtH9N16Zn9LmnNOONRpFpPI13OZ5iZR4Nizj5LmrLrfqu5RobD25iuufkCTtZmvsEIBRnOWtXCbradGR4nVnJ9lfRlG7AqK2KEXsfXVgmW87jsS/oXGftSbdC7mTh4QuDEkIKS0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(5660300002)(66476007)(66556008)(8676002)(2906002)(8936002)(83380400001)(2616005)(86362001)(31686004)(4326008)(66946007)(36756003)(6486002)(186003)(53546011)(38100700002)(6666004)(110136005)(316002)(6512007)(9686003)(6506007)(508600001)(31696002)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmhMVHFvVUxsQ2NlSyt3dDRqejJxQisxVFM3VzZMSnJIRE5mWWkwMnVNTmxy?=
 =?utf-8?B?REEwS0gwOXMrYWRXVmpqVTlWQWdvODlXVEZUbDd3S0wxWVZDcndSV2xtd0Rh?=
 =?utf-8?B?KzIyYU9PdmVVUUlDbVg3MkVybkdiK1AxMXozYUpsNi9rSG44VkZjNFdnWkV3?=
 =?utf-8?B?UHBmakh3UFBSa0FmUVNyQk05WUI0ZmNsZzBUczNSV2ZMc0VvN3BDSDIwR0ln?=
 =?utf-8?B?eFVtN1J4QWdWOGJEaWl5cCtvRVFDNmVMZDVjYUlsam9GWnZVblZ6L1ZxRDFy?=
 =?utf-8?B?Z0NUbW56bHBrVmZyMFpHc0NjazM3dS8vZ1JpV2Z6Q3YvNjdJUDhCVTBuUDJD?=
 =?utf-8?B?Ny84T0o2eHNXNnB3VnJFTWtCaW1VU1prVW5nNlNWbEluQ2FpcW5mRHgwWDBB?=
 =?utf-8?B?NzNWbTgyNFFwSmxCOTVKMWhiejAxT3k2STNZMmpoSU1UeDZMenJGaXJwb3h3?=
 =?utf-8?B?VlpYaDk2bVBkS2VNSTlIeldOZUJ5S1lFN05DZ05ZOHJzUzJheHRsM01IL2dP?=
 =?utf-8?B?UjlBQnhkVC9KN2J2TU5WRmpuaEFBTXZ1WlU5Ryt5MUtvZWMzWnZnWVc4Y0gv?=
 =?utf-8?B?R1VWWnFRcGdQYkFwbUpVNU1POUFEdHFwd21FV2h4T1lydmZYZFYzSnFQRW44?=
 =?utf-8?B?UENYUFBRcVNJekE0YTFyS2pqejR4QThtMWsxSmpqMzhpVFpzYlBHamN2bXRZ?=
 =?utf-8?B?RTd5TTdXOFl6amt6QjRLMGJjbTNHaGVJem5CbS9jd1l0WjFjdGZNZXkyUHpm?=
 =?utf-8?B?NEFtOFZ0SlB4dmNja0YyU0cyeUE4L2swckV0QjhmS2pFcnRFZDdnalpGZngv?=
 =?utf-8?B?WG13QnRoWlhyRU05Tld3TTJMZ1NpSkR0OXp4T0RwdVpMZEpsOG10cXNlQjhp?=
 =?utf-8?B?bi9tWFFUekNHcDF2U3F5L3BSMlV6bUpOTmZhWGNMbEFjQUFRYUxCcS9qMHFN?=
 =?utf-8?B?SklWeE1GdStCeDFwK2pLamVQTmxzcGVoY21YR3dzZFV3V2ZLbEh0QzhkbGkv?=
 =?utf-8?B?clR5ZjA5KzFKTGo2NEZzVUhaM2VVNGR2SXJIUzVJYkFJSTg5WE8rb1NaVEhW?=
 =?utf-8?B?SElFNTk3eU1WOEk5Ujh6T3ozOHJTSFBJSFNlK1piZXBWTGlCRjBBRzN6RmdS?=
 =?utf-8?B?a1B5ckRTcmlVaHlLTkxMU2kvZlJJMDl1Q2I4blNBdm5zVW1OcFNESjBLRmpm?=
 =?utf-8?B?c1lwNkt6UXBJUHdhU2dDZUdhaUpkOEpiZExkRGxGNVZsZ1Uvb3J2QXlDR0J0?=
 =?utf-8?B?VThkMnNuRDhMbkUxSlYxY0FxNDJ2Z3FzS2gzU1UwYzJCTjRYZFlZWjBDNVlu?=
 =?utf-8?B?clF6bDNvZytmaU5MUS9DZDlZSzRuOFNJY2kyNEVldDRDN2hyVWJPTGUvTjht?=
 =?utf-8?B?cW4zQURjVXBYTWJBbVc0azZyUDk2NGVRUXFSdi8wOXp1b2d4aldsd0F3d1Az?=
 =?utf-8?B?eHkvVXZDeWlkOElpS0ZpZlBsN2piMEZzS2ZwWFJVTWx1aHVKUXRacE1FUzdB?=
 =?utf-8?B?ZjF2aDdzNUNzWkJxSy9yN3REa2g5bXh6eWxxS0l1VHZ3ajU5TXMxK0szMVVC?=
 =?utf-8?B?M2VRVkxtRVp5aEZCbDJQMnZiWjBtQzZ6TDQzSGdxVGtJSTlnT2l1UTlYekov?=
 =?utf-8?B?K2w4RzUxaktLMmhNL3JnS2dZTkpjeGN1UTdCdUJ4cGpOdDFiMERwWE1BdGZk?=
 =?utf-8?B?eHV1Vnp2ZGdDV1A3MGprUmRyNmg3RGErZWJ6NTMrdU90WU1lM3o3OXlHb3p0?=
 =?utf-8?B?NGpFZ1hReXB3OTZvNnZEV1l3QURDczZseHUwWkVET1doWkdyNEFHNjZEWDFU?=
 =?utf-8?B?UmcxaGZ2cktlSjBxNWMvcFZ3b24rd0dibDhxLzZod0xDZ0dvT2U3cEhzcnh4?=
 =?utf-8?B?QzVGMGV3MmMxaTNjbUpnRGZQNGoxbXhQdW5zeUhEYko5WHZnNVRpbU9HQ0Er?=
 =?utf-8?B?U0w1cVA5dzBmQlhiNDNVTnZSUDZyMWhvNkxOUFJtbXdDUlEycjFUWVBnTEpB?=
 =?utf-8?B?OUZVdEZhZmdnTmNGeFNjcmMycXEwM2pVYjFMb3JSajlaTmxHNkhDM2d2OGJw?=
 =?utf-8?B?aVU4NGtaYksyVlU1cVVrbUprbFNwbzdBMkV6K2FzaTYyTUszREhFNWpjektM?=
 =?utf-8?B?OVl6V3VHUmhCeGF6UlB6Mk52NGFNbi8wR2JGOElWUkgwYnJ2bk5DaTBraXNP?=
 =?utf-8?Q?7wqu2Jvagz4+7HF+up1YeCM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eab8be9-8c8c-482d-851f-08d9e1eaf3c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 23:15:47.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPwxFAD8JUEciuCH/GafkUg1BPfQHlabhZH63xAivkwp8E16DQgmzMURJqAHuaL0p46QX69lKMtPJ/z0mgVWMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270130
X-Proofpoint-GUID: tCj0dtTz0aiciZO2QAh4uc7-uOmPviPT
X-Proofpoint-ORIG-GUID: tCj0dtTz0aiciZO2QAh4uc7-uOmPviPT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/27/22 2:41 PM, NeilBrown wrote:
> On Fri, 28 Jan 2022, Chuck Lever III wrote:
>> Hi Neil-
>>
>>> On Jan 26, 2022, at 11:58 PM, NeilBrown <neilb@suse.de> wrote:
>>>
>>> If a filesystem is exported to a client with NFSv4 and that client holds
>>> a file open, the filesystem cannot be unmounted without either stopping the
>>> NFS server completely, or blocking all access from that client
>>> (unexporting all filesystems) and waiting for the lease timeout.
>>>
>>> For NFSv3 - and particularly NLM - it is possible to revoke all state by
>>> writing the path to the filesystem into /proc/fs/nfsd/unlock_filesystem.
>>>
>>> This series extends this functionality to NFSv4.  With this, to unmount
>>> an exported filesystem is it sufficient to disable export of that
>>> filesystem, and then write the path to unlock_filesystem.
>>>
>>> I've cursed mainly on NFSv4.1 and later for this.  I haven't tested
>>> yet with NFSv4.0 which has different mechanisms for state management.
>>>
>>> If this series is seen as a general acceptable approach, I'll look into
>>> the NFSv4.0 aspects properly and make sure it works there.
>> I've browsed this series and need to think about:
>> - whether we want to enable administrative state revocation and
>> - whether NFSv4.0 can support that reasonably
>>
>> In particular, are there security consequences for revoking
>> state? What would applications see, and would that depend on
>> which minor version is in use? Are there data corruption risks
>> if this facility were to be misused?
> The expectation is that this would only be used after unexporting the
> filesystem.  In that case, the client wouldn't notice any difference
> from the act of writing to unlock_filesystem, as the entire filesystem
> would already be inaccessible.
>
> If we did unlock_filesystem a filesystem that was still exported, the
> client would see similar behaviour to a network partition that was of
> longer duration than the lease time.   Locks would be lost.
>
>> Also, Dai's courteous server work is something that potentially
>> conflicts with some of this, and I'd like to see that go in
>> first.
> I'm perfectly happy to wait for the courteous server work to land before
> pursuing this.

Thank you Chuck and Neil, I'm chasing a couple intermittent share
reservation related problems with pynfs test. I hope to have them
resolved and submit the v10 patch by end of this week.

-Dai

>
>> Do you have specific user requests for this feature, and if so,
>> what are the particular usage scenarios?
> It's complicated....
>
> The customer has an HA config with multiple filesystem resource which
> they want to be able to migrate independently.  I don't think we really
> support that, but they seem to want to see if they can make it work (and
> it should be noted that I talk to an L2 support technician who talks to
> the customer representative, so I might be getting the full story).
>
> Customer reported that even after unexporting a filesystem, they cannot
> then unmount it.  Whether or not we think that independent filesystem
> resources is supportable, I do think that the customer should have a
> clear path for unmounting a filesystem without interfering with service
> provided from other filesystems.  Stopping nfsd would interfere with
> that service by forcing a grace-period on all filesystems.
> The RFC explicitly supports admin-revocation of state, and that would
> address this specific need, so it seemed completely appropriate to
> provide it.
>
> As an aside ...  I'd like to be able to suggest that the customer use
> network namespaces for the different filesystem resources.  Each could
> be in its own namespace and managed independently.  However I don't
> think we have good admin infrastructure for that do we?
>
> I'd like to be able to say "set up these 2 or 3 config files and run
> systemctl start nfs-server@foo and the 'foo' network namespace will be
> created, configured, and have an nfs server running".
> Do we have anything approaching that?  Even a HOWTO ??
>
> Thanks,
> NeilBrown
