Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8636880F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhDVUcB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 16:32:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58708 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236877AbhDVUcA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 16:32:00 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MKUx0r024098;
        Thu, 22 Apr 2021 20:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wqv142h+f247mMpn+cBYhh3pGwdYVLIJRtw1Fo1kOrw=;
 b=Ohbzek9AUEqLd14CT+nebaUGUS4vtzegveyDwGZBrhecnWGDWG1GnIm1yO6ce4gbSCUq
 zg9Q9o50ip5dHTHetj0u5lnxM7BsKYNv1K0Vg4/2crXMz3KHG3wplud2gvU/saaV226w
 NqLk0zt9HiFs9mkNmdO9TMSWaHfys/+zHw6CGMgeR5vjdHkJAbPtGztwx0EtCBoz7Lzl
 IGTLbvUibLKflK8Mq8KbNDFajB41o4wvjySXeRr0TYlRhBEvqMsv2P/ahrWKZY9JWcXB
 xeIC8QH9W+GrxWRpP74zCFnDAEQE2aKJrm2rbJMFvb3vSUNZEf3V6iOVY1GgTtmemnIZ Jw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 382yqs8cfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 20:31:19 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13MKVI5Q015613;
        Thu, 22 Apr 2021 20:31:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 383cg9jtsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 20:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0c/P+bk9AoAqDmribuzOdh8Tpp66pvr7NvXvpoIhNpE5mG+1m4/Abnspy/jqzjP30+2OAdWT70ALQAzGF+WxEGNGJMBbTqfUEN+dEGGGqbBvn0tTHgaH2DaWwr3M8rlXKR43AW96BYjSi2JGJe8EHek6PauNYSLFjWkEMhBitvimQB63FtqlG71/jIW44x1DGF2tmDE3c4ZaQnVDwNg9XUsbd4ressOyPrFRtMnpBUue3wzxuhQdra954Of16ydNYIup5Nksd4b3HPWgf12Mq6qj8ALdC8WIPxgb5F+O1DdTzjfdiVFxxHkC1/eEVrmYgpbgvJi2WqT6cqPvnLi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqv142h+f247mMpn+cBYhh3pGwdYVLIJRtw1Fo1kOrw=;
 b=UN5qq7X2/s89o830tLuXrJECyQJf4s4hGaH9rnVErqaPdqWFaDJ2SlcN83pRE7szEvBR9duXXOn/0se6Hs4vkbZtOUVimpFXjQP/X5ua5ZzGMB2yqxCB4jkjpfsg5LabWfdTalB6NIIi2S/mDQueA+gyPLeqPiXEu8ROA5pLkb75S3WxLkk+qsW+4lenQJHLPYbYwCOEtlAolczbXGJ5z+PMGxh+L7n9mZnvFpm7lLNxIaKAFLpqlD4g+JW5UiXFNtyKvzFdiJZ0txxV2+nYqcuqwU4SCioUdhUsAfoVBWsMiLN0P4IMge+CIyVrM+b3o95HBidgDgKG1+BdXdltGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqv142h+f247mMpn+cBYhh3pGwdYVLIJRtw1Fo1kOrw=;
 b=m04TuDuM8cvWkG1mP02vwqBXDTbAi/zZRhNEcr43GZXx7DpRizi9ZJ/XlyWO44dNyYH7ezAyoS3vZ07l5ZYE2KAkn6zKuV3r3FZh9dSip1hr73NOYQoc9Gb1OBJREx3mrqDJgIlHCHihAfteOeLxZKzTGiWgG/VL9BJA8bS9InU=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3272.namprd10.prod.outlook.com (2603:10b6:a03:157::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 20:31:15 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 20:31:15 +0000
Subject: Re: [PATCH v3 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20210409180519.25405-1-dai.ngo@oracle.com>
 <20210409180519.25405-2-dai.ngo@oracle.com>
 <CAN-5tyF_B9LK3soGfbrp8hpS3RG4CdmFxK246u2ADVn+2s0JHw@mail.gmail.com>
 <5d7c26c2-1964-7fec-afb4-5f088830f4a4@oracle.com>
 <CAN-5tyF4U-4Yxa_eJ6PE-MfgFbSzDnnx0Ty9kVAQ5UbZmnZdcQ@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <96b4b25c-daff-ad3f-1a78-be2b82fa7f8e@oracle.com>
Date:   Thu, 22 Apr 2021 13:31:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAN-5tyF4U-4Yxa_eJ6PE-MfgFbSzDnnx0Ty9kVAQ5UbZmnZdcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-254-102.vpn.oracle.com (72.219.112.78) by SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 20:31:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d91ba2-2701-4548-b9f9-08d905cd9398
X-MS-TrafficTypeDiagnostic: BYAPR10MB3272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3272A8411B7B46D436D4A22487469@BYAPR10MB3272.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+vGe1HTSL3s0FC5wjFalY88AzwZANKCh3QRDNas+k84aoGKd3iuu9DnG535KvcSOWpfUumfa+4RGrhS5jqV3RZlgcdJHXfQtk8tEnPa3gsccX9tM2gVW+lkPZ81prtR2TkhrnNXFc9fEoM8jFHwWF08FqHQT9YJ2wrGETnPsXw0hcTuWR/oRTzESLYQn19+mmsUvXhn5t9KAlLQPZ9sZjqTb6vyOnjfO0dt5y0aV8GISF0uA/hohUs2+zKiODUVbUrE8GZB/BX5UtwJ/suxmEmYGOerC6z5QeaTZ/2lGAYwROGrsWhRdOiryxXCk4ImINKolTyQhrJT2Z0JLd8AAeeld7QbrlB8aeNpxqO4rciT79CWvl8jdbzNf09af7WjLs4PqgRS15s5TkpU1Etibrii+TLfr8gRYifRVwOrtTKbvNgrQUzxhba07/T13Q7F8m4pebopsj1fFpRx7sMOIHjZpTOZ6iKD3EkDkCRX3CqcgS7WPrihGmCQOuBnEncrdlOEgHVdrZruoGKo/Ra+BJfKP5jqFa4tPRgM36MS2s+B6pO+XpsfznwNEA5iFlZTiA1g88B6BvnZB3kJdGmzq3PL+ZTxzP4h6kdrstceEGFTd8Y+6BIVQxH+D0cPD+gjNVFyY2eHhr0jzGiMIBeK7t93oQds6CTmsfDvb3Vn1bQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(376002)(396003)(316002)(6916009)(2906002)(30864003)(54906003)(86362001)(2616005)(31686004)(956004)(8936002)(53546011)(7696005)(8676002)(186003)(478600001)(38100700002)(83380400001)(66476007)(66946007)(26005)(36756003)(66556008)(16526019)(5660300002)(107886003)(6486002)(31696002)(9686003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWJqVi9UcjVCL05HYTRVZUsrUUpraEJYeFBkTFRJQm5IamJKT2ljQ1BWOTJx?=
 =?utf-8?B?S1dndHZuVzB1TzZEV3lKRTVOYkxOeU9oZDR2T1N2QUhqZmFTWU52eWtQdktz?=
 =?utf-8?B?dWtiQm05ZkU3VC80L2E0aklpTlRTVlB4elZ4ZERiektBa1R6cGhuN2h3Q1U2?=
 =?utf-8?B?a2tNbHp1cWhiNFBhd0R1T0Q4Tks0aDZWcDZLS1VaOWVTcnh1b2R6Q3FpZFF5?=
 =?utf-8?B?NjVUSzlNSldNdU1mMFU2d1ZBNVZLMGxUMnpxWEtJbzFqMG5oT0wvWmQrcVFE?=
 =?utf-8?B?VmVtcFBua1JLT00rZURkT0VJR0lzRXhLNXBwWmZEd045TER3ZWk4TDZuN25P?=
 =?utf-8?B?NW9LTDYwM0k5bEo0dXFMb1RaMkZSaVZ6K3dkK0dGdTdOUDNvUFBrTU9tNVNn?=
 =?utf-8?B?RGdyL2RJSE0vNUErUjdxQ1l5ZWE2WHNkbzZXMDNRN2hSUmx3UnZYSk1iYW9P?=
 =?utf-8?B?Y2U0SzdQcmRHVmJDS2JzVnp6bGpWZFNSV2FKNEc2cEd2NS9ocFp2YVhCaUtH?=
 =?utf-8?B?T3YxNzg3V01YdjFkRU92eXREVVY3Zk5PM0R2blpjTjBnNnVBU09WTExkaHI1?=
 =?utf-8?B?VS9zQUZob1NJanFlZGc5QVM2Q3cyZjFWWUxCYXlnZlFHN0xlYnR1RmkyTERo?=
 =?utf-8?B?Uk1Dbmp3bkxraGNIYlBmOVBQQVU3K0xUUk9Jc1ZxOERGVHd3UkluU1R1ZVM0?=
 =?utf-8?B?T0RVdmdGakFVcENDdHR6TWtwTkp5VkIzM0dYU1hVSlRLQStEc1pwUGRsT3gx?=
 =?utf-8?B?SllpWEorMm5zY1BUdDZxMDVYYjJtVnBsTGZYdmUySlFVb1BLbENka2hqYmg2?=
 =?utf-8?B?SHU1Nkg2U1dZMDFhSW9QMzdoaXJpUjJJM3hGZ2ZzZmI3STZCcE1RcmhLbTR3?=
 =?utf-8?B?Zy9OMjNlZmpITnI3bW1yOCtkd2liY21nS3Y4R1BiRHdyV2ZCV2lyV0Nac1Jr?=
 =?utf-8?B?UmdXWmVBVlFKeExWQXRSNWFxT3g1M2I0cTVoaVJJQUM4MnhBY081dDh0TlhF?=
 =?utf-8?B?MHdwL29oZVQ5R1lJN1VtS2p5T3dObEZieHU0UlpyNDROYjE2bTkvME5BYWN2?=
 =?utf-8?B?TkIyWGJQSlhscG9TMWtvUTltaDJXak1SQlFQNWErd243VCtjcktmenNteXVO?=
 =?utf-8?B?NERnVmY4WkZodG9BT1FtYUlEVXgxQndNTk1mVW9DTHZ4dTlDZlJPdlIyWDFC?=
 =?utf-8?B?L0s1OXZFNVo0Z3ZXL29xU01Sczk2TjZEYndBTDBoTlJwc0ZtSlUwT05IVldV?=
 =?utf-8?B?QmQ2VHI5eEs1QUhVdkxnYU5UYi8zTXZEUDAxK2J2dkMzdmNOcHZrUUE2MDh2?=
 =?utf-8?B?SG5sT1NvWU1Tdjh5T1VSb1RKQU1wbXVrMk9vazNvamVNQUlySmNjK2huN1NZ?=
 =?utf-8?B?SUZwSDhPb0RuQWVjTXZVWXEvODZkcmdzQjRaUmZ3aDhNLzNzR2JSZ2NpMzA2?=
 =?utf-8?B?YWpWeURLQ3k0NkdTR3VuWTFzZW1GSmhBRXJtQUV5N29jbXE5UkkvUTZKYXJS?=
 =?utf-8?B?NEQrbVJvU0JpLzZncENENzVzRVpxY1NpTEMzdGU1WUNMZFFFUnRaVFR6Tkl3?=
 =?utf-8?B?bFR1K3hWcHA1YUQ4dktGcmo0NEREbzdsNUxKTG5XODBBQkpnaW10WU1nMlJh?=
 =?utf-8?B?R2JxaUtVZ0k2MmovMHh5T0l1cVZpR1hiTmw2Q1h6SGxRSWtVRURZVkhRRDYw?=
 =?utf-8?B?dUtaOHhKZElnMGhiUE1PZ2lUS1BqYW9PVER4VnY4anRoOWRmLy9QWTNOQVox?=
 =?utf-8?Q?kd67BIVyfuu0HGi+Bx/REQI8QDFWKQyRucQE5xs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d91ba2-2701-4548-b9f9-08d905cd9398
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 20:31:15.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74/1YHvrxZQeo9eCIRJ2bExwYfwkGGYpXCEd4DILlBXG6M/CtiguF+mxVwCp/G4fbnU1s7raBbuNQXUFZObLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3272
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220152
X-Proofpoint-ORIG-GUID: Gw0ZvhyML-NOjP8MCysV_KE438cWGw4X
X-Proofpoint-GUID: Gw0ZvhyML-NOjP8MCysV_KE438cWGw4X
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/22/21 12:55 PM, Olga Kornievskaia wrote:
> On Thu, Apr 22, 2021 at 2:42 PM <dai.ngo@oracle.com> wrote:
>> Thank you Olga for reviewing the patch and doing the performance
>> testing, greatly appreciated!
>>
>> On 4/21/21 5:31 PM, Olga Kornievskaia wrote:
>>> On Fri, Apr 9, 2021 at 2:07 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>> Currently the source's export is mounted and unmounted on every
>>>> inter-server copy operation. This patch is an enhancement to delay
>>>> the unmount of the source export for a certain period of time to
>>>> eliminate the mount and unmount overhead on subsequent copy operations.
>>>>
>>>> After a copy operation completes, a delayed task is scheduled to
>>>> unmount the export after a configurable idle time. Each time the
>>>> export is being used again, its expire time is extended to allow
>>>> the export to remain mounted.
>>>>
>>>> The unmount task and the mount operation of the copy request are
>>>> synced to make sure the export is not unmounted while it's being
>>>> used.
>>> I have done performance testing of this patch on the hardware used to
>>> test initial SSC code and there is improvement on the lower end copy
>>> filesize (4MB-16MB) with this. Unfortunately, I can't quantify how
>>> much difference this patch makes. Why? Because I'm getting very
>>> different results on every set of runs (each set does 10runs to get
>>> the mean and compute standard deviation too).  The most varied time
>>> from run to run is commit time. However, standard deviation for both
>>> types of runs (traditional and ssc) is (most of the time) <1% which
>>> should still make the runs acceptable (i did re-runs for others).
>>> Runs with filesize 128MB+ have more consistent performance but they
>>> also don't show as much improvement with this patch. Note I didn't
>>> concentrate on  >1G performance at all this time around.
>> I think user would appreciate more if copying of large files is
>> faster since that reduces the time the user has to wait for the
>> copy to complete. Copying of small files happen so quickly (<1 sec)
>> it's hard to see the different.
> I'm not sure what you are commenting or arguing for here.

just a comment :-).

>   Smaller
> copies is what delayed unmount helps more than large copies. AGain
> given that numbers were not stable I can't stay what exact improvement
> was for small copies compared to the large(r) copies. but it seemed
> like small copies had 10% and large copies had 5% improvement with
> this patch. I think this patch is the reason to remove/reduce client's
> restriction on the small copies.  I think I'm more comfortable
> removing the 16MB restriction given the numbers we have.

ok, I will remove the nfs4_ssc_inter_server_min_size restriction and
keep the 'sync' flag restriction.

>
>>> Also, what I discovered is what also makes a difference is the
>>> following COMMIT rpc. The saving seems to come from doing an
>>> vfs_fsync() after the copy on the server (just like what is done for
>>> the CLONE i might note) and I'm hoping to propose a patch for it some
>>> time in the next few days.
>> I think this is a good enhancement.
> Perhaps, the argument against it if SOME implementation wanted to send
> a bunch of copies and later on wanted to commit separately then making
> each async copy do NFS_FILE_SYNC would hurt their performance. I have
> to say this change is very linux-client tailored and thus it's RFC.
> Current linux implementation is user-space (eg cp) would do a single
> copy_file_range() system call for the whole file and linux client
> doesn't break down the request into smaller copies, and after that it
> would send a commit, so this optimization makes sense for linux.
>
>>> A few general comments on the patch:
>>> 1. Shouldn't the "nsui_refcnt" be a refcount_t structure type?
>> I will convert to refcount_t in the v2 patch.

v4

>>
>>> 2. Why is the value of 20HZ to retry was chosen?
>> This is when a thread doing the mount and either (1) there is another
>> thread doing another mount to the same source server or (2) the export
>> of that server is being unmounted by the delayed task. In this case
>> the thread has to wait for the other thread to be done with the source
>> server and try again.
>>
>> I think we should not have the thread waits forever so I just pick
>> 20secs which I think should be long enough for the mount/unmount to
>> complete in normal condition. I'm open to suggestion on how to handle
>> this case.
> I understood the need for the timeout value, I just didn't know why 20
> and not say 5? Seems like a long time to have the copy wait? I'm not
> sure how to simulate this condition to see what happens.

Yes, 20secs seems to be a long time to wait but I think this would be
a rare scenario. Can we just leave this 20secs, or setting it to a
smaller value for now and making a note in the code to revisit?

-Dai

>>> 3. "work" gets allocated but instead of checking the allocation
>>> failure and dealing with it then, the code has "if (work)" sections.
>>> seems like extra indentation and the need to think why "work" can be
>>> null be removed?
>> There is nothing that we need to do if the allocation of work fails.
>> We still have to continue to do the mount and just skip the work of
>> setting it up for the delayed unmount.
> Ok.
>
>>> Here are some numbers. Comparing pure 5.12-rc6 code with 5.12-rc6 code
>>> with Dai's delay umount code and for kicks the last set of numbers is
>>> +delay umount +vfs_fsync() on the server. In general over 128MB
>>> provides 50% improvement over traditional copy in all cases. With
>>> delayed umount, we see better numbers (~30% improvement) with copies
>>> 4MB-128MB but still some dips and for copies over 128MB over 50%
>>> improvement.
>> I think the improvement from the delayed mount and commit optimization
>> is significant.
> I agree that a delayed umount is beneficial and should be added.
>
>> -Dai
>>
>>> pure 5.12-rc6
>>>       INFO: 14:11:16.819155 - Server-side COPY: 0.472602200508 seconds
>>> (mean), standard deviation: 0.504127857283
>>>       INFO: 14:11:16.819252 - Traditional COPY: 0.247301483154 seconds
>>> (mean), standard deviation: 0.0325181306537
>>>       FAIL: SSC should outperform traditional copy, performance
>>> degradation for a 4MB file: 91%
>>>
>>>       INFO: 14:12:54.584129 - Server-side COPY: 0.401613616943 seconds
>>> (mean), standard deviation: 0.100666012531
>>>       INFO: 14:12:54.584223 - Traditional COPY: 0.376980066299 seconds
>>> (mean), standard deviation: 0.0149147531532
>>>       FAIL: SSC should outperform traditional copy, performance
>>> degradation for a 8MB file: 6%
>>>
>>>       INFO: 14:14:37.430685 - Server-side COPY: 0.727260971069 seconds
>>> (mean), standard deviation: 0.24591675709
>>>       INFO: 14:14:37.430787 - Traditional COPY: 0.858516097069 seconds
>>> (mean), standard deviation: 0.203399239696
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 16MB file: 18%
>>>
>>>       INFO: 14:16:25.318145 - Server-side COPY: 1.08072230816 seconds
>>> (mean), standard deviation: 0.168767973425
>>>       INFO: 14:16:25.318245 - Traditional COPY: 1.21966302395 seconds
>>> (mean), standard deviation: 0.0862109147556
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 32MB file: 12%
>>>
>>>       INFO: 14:18:20.913090 - Server-side COPY: 1.47459042072 seconds
>>> (mean), standard deviation: 0.118534392658
>>>       INFO: 14:18:20.913186 - Traditional COPY: 1.74257912636 seconds
>>> (mean), standard deviation: 0.041726092735
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 64MB file: 18%
>>>
>>>       INFO: 14:20:40.794478 - Server-side COPY: 2.27927930355 seconds
>>> (mean), standard deviation: 0.0502558652592
>>>       INFO: 14:20:40.794579 - Traditional COPY: 3.3685300827 seconds
>>> (mean), standard deviation: 0.0232078152411
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 128MB file: 47%
>>>
>>>       INFO: 14:23:54.480951 - Server-side COPY: 4.36852009296 seconds
>>> (mean), standard deviation: 0.0421940712129
>>>       INFO: 14:23:54.481059 - Traditional COPY: 6.58469381332 seconds
>>> (mean), standard deviation: 0.0534006595486
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 256MB file: 50%
>>>
>>>       INFO: 14:28:57.776217 - Server-side COPY: 8.61689963341 seconds
>>> (mean), standard deviation: 0.110919967983
>>>       INFO: 14:28:57.776361 - Traditional COPY: 13.0591681957 seconds
>>> (mean), standard deviation: 0.0766741218971
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 512MB file: 51%
>>>
>>>       INFO: 14:36:45.693363 - Server-side COPY: 15.330485177 seconds
>>> (mean), standard deviation: 1.08275054089
>>>       INFO: 14:36:45.693547 - Traditional COPY: 22.6392157316 seconds
>>> (mean), standard deviation: 0.62612602097
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 1GB file: 47%
>>>
>>>       (another run for 1g to get a better deviation)
>>>       INFO: 15:33:08.457225 - Server-side COPY: 14.7443211555 seconds
>>> (mean), standard deviation: 0.19152031268
>>>       INFO: 15:33:08.457401 - Traditional COPY: 23.3897125483 seconds
>>> (mean), standard deviation: 0.634745610516
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 1GB file: 58%
>>>
>>> This run is with delayed umount:
>>>       INFO: 16:57:09.750669 - Server-side COPY: 0.264265751839 seconds
>>> (mean), standard deviation: 0.114140867309
>>>       INFO: 16:57:09.750767 - Traditional COPY: 0.277241683006 seconds
>>> (mean), standard deviation: 0.0429385806753
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 4MB file: 4%
>>>
>>>       INFO: 16:58:48.514208 - Server-side COPY: 0.301608347893 seconds
>>> (mean), standard deviation: 0.027625417442
>>>       INFO: 16:58:48.514305 - Traditional COPY: 0.376611542702 seconds
>>> (mean), standard deviation: 0.0256646541006
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 8MB file: 24%
>>>
>>>       INFO: 17:00:32.726180 - Server-side COPY: 0.804727435112 seconds
>>> (mean), standard deviation: 0.282478573802
>>>       INFO: 17:00:32.726284 - Traditional COPY: 0.750376915932 seconds
>>> (mean), standard deviation: 0.188426980103
>>>       FAIL: SSC should outperform traditional copy, performance
>>> degradation for a 16MB file: 7%
>>>
>>> another run for 16MB for better deviation
>>>       INFO: 17:26:05.710048 - Server-side COPY: 0.561978292465 seconds
>>> (mean), standard deviation: 0.176039123641
>>>       INFO: 17:26:05.710155 - Traditional COPY: 0.761225438118 seconds
>>> (mean), standard deviation: 0.229373528254
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 16MB file: 35%
>>>
>>>       INFO: 17:02:21.387772 - Server-side COPY: 0.895572972298 seconds
>>> (mean), standard deviation: 0.18919321178
>>>       INFO: 17:02:21.387866 - Traditional COPY: 1.28307352066 seconds
>>> (mean), standard deviation: 0.0755687243879
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 32MB file: 43%
>>>
>>>       INFO: 17:04:18.530852 - Server-side COPY: 1.44412658215 seconds
>>> (mean), standard deviation: 0.0680101210746
>>>       INFO: 17:04:18.530946 - Traditional COPY: 1.7353479147 seconds
>>> (mean), standard deviation: 0.0147682451688
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 64MB file: 20%
>>>
>>>       INFO: 17:06:40.127898 - Server-side COPY: 2.18924453259 seconds
>>> (mean), standard deviation: 0.0339712202148
>>>       INFO: 17:06:40.127995 - Traditional COPY: 3.39783103466 seconds
>>> (mean), standard deviation: 0.0439455560873
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 128MB file: 55%
>>>
>>>       INFO: 17:09:56.186889 - Server-side COPY: 4.2961766243 seconds
>>> (mean), standard deviation: 0.0486465355758
>>>       INFO: 17:09:56.186988 - Traditional COPY: 6.56641271114 seconds
>>> (mean), standard deviation: 0.0259688949944
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 256MB file: 52%
>>>
>>>       INFO: 17:15:02.522089 - Server-side COPY: 8.4736330986 seconds
>>> (mean), standard deviation: 0.0896888780618
>>>       INFO: 17:15:02.522242 - Traditional COPY: 13.074249053 seconds
>>> (mean), standard deviation: 0.0805015369838
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 512MB file: 54%
>>>
>>>       INFO: 17:22:59.745446 - Server-side COPY: 15.9621772766 seconds
>>> (mean), standard deviation: 2.70296237945
>>>       INFO: 17:22:59.745625 - Traditional COPY: 22.5955899239 seconds
>>> (mean), standard deviation: 0.682459618149
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 1GB file: 41%
>>>
>>> another run for 1GB to get a better deviation:
>>>       INFO: 17:35:02.846602 - Server-side COPY: 14.6351578712 seconds
>>> (mean), standard deviation: 0.19192309658
>>>       INFO: 17:35:02.846781 - Traditional COPY: 22.8912801266 seconds
>>> (mean), standard deviation: 0.682718216033
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 1GB file: 56%
>>>
>>> And this run is for yet unpublished patch of delayed umount +
>>> vfs_fsync after the copy
>>>       INFO: 18:28:34.764202 - Server-side COPY: 0.209130239487 seconds
>>> (mean), standard deviation: 0.0366357417649
>>>       INFO: 18:28:34.764297 - Traditional COPY: 0.275605249405 seconds
>>> (mean), standard deviation: 0.030773788804
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 4MB file: 31%
>>>
>>>       INFO: 18:30:12.278362 - Server-side COPY: 0.263212919235 seconds
>>> (mean), standard deviation: 0.017764772065
>>>       INFO: 18:30:12.278459 - Traditional COPY: 0.373342609406 seconds
>>> (mean), standard deviation: 0.0235488678036
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 8MB file: 41%
>>>
>>>       INFO: 18:31:56.740901 - Server-side COPY: 0.653366684914 seconds
>>> (mean), standard deviation: 0.201038063193
>>>       INFO: 18:31:56.741007 - Traditional COPY: 0.719534230232 seconds
>>> (mean), standard deviation: 0.144084877516
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 16MB file: 10%
>>>
>>> another run for 16Mb
>>>       INFO: 20:18:09.533128 - Server-side COPY: 0.508768010139 seconds
>>> (mean), standard deviation: 0.172117325138
>>>       INFO: 20:18:09.533224 - Traditional COPY: 0.712138915062 seconds
>>> (mean), standard deviation: 0.162059202594
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 16MB file: 39%
>>>
>>>       INFO: 18:33:44.203037 - Server-side COPY: 0.774861812592 seconds
>>> (mean), standard deviation: 0.141729231937
>>>       INFO: 18:33:44.203140 - Traditional COPY: 1.24551167488 seconds
>>> (mean), standard deviation: 0.0520878630978
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 32MB file: 60%
>>>
>>>       INFO: 18:35:44.104048 - Server-side COPY: 1.50374240875 seconds
>>> (mean), standard deviation: 0.132060247445
>>>       INFO: 18:35:44.104168 - Traditional COPY: 1.76330254078 seconds
>>> (mean), standard deviation: 0.0339954657686
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 64MB file: 17%
>>>
>>> another run for 64MB
>>>       INFO: 20:22:39.668006 - Server-side COPY: 1.32221701145 seconds
>>> (mean), standard deviation: 0.0595545335408
>>>       INFO: 20:22:39.668108 - Traditional COPY: 1.73985309601 seconds
>>> (mean), standard deviation: 0.0301114835769
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 64MB file: 31%
>>>
>>>       INFO: 18:38:06.184631 - Server-side COPY: 2.11796813011 seconds
>>> (mean), standard deviation: 0.0407036659715
>>>       INFO: 18:38:06.184726 - Traditional COPY: 3.36791093349 seconds
>>> (mean), standard deviation: 0.029777196608
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 128MB file: 59%
>>>
>>>       INFO: 18:41:20.944541 - Server-side COPY: 4.19641048908 seconds
>>> (mean), standard deviation: 0.041610728753
>>>       INFO: 18:41:20.944641 - Traditional COPY: 6.569201684 seconds
>>> (mean), standard deviation: 0.0398935239857
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 256MB file: 56%
>>>
>>>       INFO: 18:46:23.973364 - Server-side COPY: 8.34293022156 seconds
>>> (mean), standard deviation: 0.108239167667
>>>       INFO: 18:46:23.973562 - Traditional COPY: 13.0458415985 seconds
>>> (mean), standard deviation: 0.0399096580857
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 512MB file: 56%
>>>
>>>       INFO: 18:54:05.741343 - Server-side COPY: 14.4749611855 seconds
>>> (mean), standard deviation: 0.122991853502
>>>       INFO: 18:54:05.741549 - Traditional COPY: 22.6955966711 seconds
>>> (mean), standard deviation: 0.461425661742
>>>       PASS: SSC should outperform traditional copy, performance
>>> improvement for a 1GB file: 56%
>>>
>>>
>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4proc.c      | 171 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    fs/nfsd/nfsd.h          |   4 ++
>>>>    fs/nfsd/nfssvc.c        |   3 +
>>>>    include/linux/nfs_ssc.h |  20 ++++++
>>>>    4 files changed, 194 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index dd9f38d..66dea2f 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -55,6 +55,81 @@
>>>>    MODULE_PARM_DESC(inter_copy_offload_enable,
>>>>                    "Enable inter server to server copy offload. Default: false");
>>>>
>>>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>>> +static int nfsd4_ssc_umount_timeout = 900000;          /* default to 15 mins */
>>>> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
>>>> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
>>>> +               "idle msecs before unmount export from source server");
>>>> +
>>>> +static void nfsd4_ssc_expire_umount(struct work_struct *work);
>>>> +static struct nfsd4_ssc_umount nfsd4_ssc_umount;
>>>> +
>>>> +/* nfsd4_ssc_umount.nsu_lock must be held */
>>>> +static void nfsd4_scc_update_umnt_timo(void)
>>>> +{
>>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>>> +
>>>> +       cancel_delayed_work(&nfsd4_ssc_umount.nsu_umount_work);
>>>> +       if (!list_empty(&nfsd4_ssc_umount.nsu_list)) {
>>>> +               ni = list_first_entry(&nfsd4_ssc_umount.nsu_list,
>>>> +                       struct nfsd4_ssc_umount_item, nsui_list);
>>>> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
>>>> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
>>>> +                       ni->nsui_expire - jiffies);
>>>> +       } else
>>>> +               nfsd4_ssc_umount.nsu_expire = 0;
>>>> +}
>>>> +
>>>> +static void nfsd4_ssc_expire_umount(struct work_struct *work)
>>>> +{
>>>> +       bool do_wakeup = false;
>>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>>> +       struct nfsd4_ssc_umount_item *tmp;
>>>> +
>>>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
>>>> +               if (time_after(jiffies, ni->nsui_expire)) {
>>>> +                       if (ni->nsui_refcnt > 0)
>>>> +                               continue;
>>>> +
>>>> +                       /* mark being unmount */
>>>> +                       ni->nsui_busy = true;
>>>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +                       mntput(ni->nsui_vfsmount);
>>>> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>>> +
>>>> +                       /* waiters need to start from begin of list */
>>>> +                       list_del(&ni->nsui_list);
>>>> +                       kfree(ni);
>>>> +
>>>> +                       /* wakeup ssc_connect waiters */
>>>> +                       do_wakeup = true;
>>>> +                       continue;
>>>> +               }
>>>> +               break;
>>>> +       }
>>>> +       nfsd4_scc_update_umnt_timo();
>>>> +       if (do_wakeup)
>>>> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>>>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +}
>>>> +
>>>> +static DECLARE_DELAYED_WORK(nfsd4, nfsd4_ssc_expire_umount);
>>>> +
>>>> +void nfsd4_ssc_init_umount_work(void)
>>>> +{
>>>> +       if (nfsd4_ssc_umount.nsu_inited)
>>>> +               return;
>>>> +       INIT_DELAYED_WORK(&nfsd4_ssc_umount.nsu_umount_work,
>>>> +               nfsd4_ssc_expire_umount);
>>>> +       INIT_LIST_HEAD(&nfsd4_ssc_umount.nsu_list);
>>>> +       spin_lock_init(&nfsd4_ssc_umount.nsu_lock);
>>>> +       init_waitqueue_head(&nfsd4_ssc_umount.nsu_waitq);
>>>> +       nfsd4_ssc_umount.nsu_inited = true;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
>>>> +#endif
>>>> +
>>>>    #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>>>>    #include <linux/security.h>
>>>>
>>>> @@ -1181,6 +1256,9 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>           char *ipaddr, *dev_name, *raw_data;
>>>>           int len, raw_len;
>>>>           __be32 status = nfserr_inval;
>>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>>> +       struct nfsd4_ssc_umount_item *work, *tmp;
>>>> +       DEFINE_WAIT(wait);
>>>>
>>>>           naddr = &nss->u.nl4_addr;
>>>>           tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
>>>> @@ -1229,12 +1307,63 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>                   goto out_free_rawdata;
>>>>           snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>>>
>>>> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
>>>> +try_again:
>>>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
>>>> +               if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
>>>> +                       continue;
>>>> +               /* found a match */
>>>> +               if (ni->nsui_busy) {
>>>> +                       /*  wait - and try again */
>>>> +                       prepare_to_wait(&nfsd4_ssc_umount.nsu_waitq, &wait,
>>>> +                               TASK_INTERRUPTIBLE);
>>>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +                       if (signal_pending(current) ||
>>>> +                                       (schedule_timeout(20*HZ) == 0)) {
>>>> +                               status = nfserr_eagain;
>>>> +                               kfree(work);
>>>> +                               goto out_free_devname;
>>>> +                       }
>>>> +                       finish_wait(&nfsd4_ssc_umount.nsu_waitq, &wait);
>>>> +                       goto try_again;
>>>> +               }
>>>> +               ss_mnt = ni->nsui_vfsmount;
>>>> +               ni->nsui_refcnt++;
>>>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +               kfree(work);
>>>> +               goto out_done;
>>>> +       }
>>>> +       /* create new entry, set busy, insert list, clear busy after mount */
>>>> +       if (work) {
>>>> +               strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
>>>> +               work->nsui_refcnt++;
>>>> +               work->nsui_busy = true;
>>>> +               list_add_tail(&work->nsui_list, &nfsd4_ssc_umount.nsu_list);
>>>> +       }
>>>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +
>>>>           /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>>>           ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>>>>           module_put(type->owner);
>>>> -       if (IS_ERR(ss_mnt))
>>>> +       if (IS_ERR(ss_mnt)) {
>>>> +               if (work) {
>>>> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>>> +                       list_del(&work->nsui_list);
>>>> +                       wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>>>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +                       kfree(work);
>>>> +               }
>>>>                   goto out_free_devname;
>>>> -
>>>> +       }
>>>> +       if (work) {
>>>> +               spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>>> +               work->nsui_vfsmount = ss_mnt;
>>>> +               work->nsui_busy = false;
>>>> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>>>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +       }
>>>> +out_done:
>>>>           status = 0;
>>>>           *mount = ss_mnt;
>>>>
>>>> @@ -1301,10 +1430,44 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>    nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>>>                           struct nfsd_file *dst)
>>>>    {
>>>> +       bool found = false;
>>>> +       long timeout;
>>>> +       struct nfsd4_ssc_umount_item *tmp;
>>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>>> +
>>>>           nfs42_ssc_close(src->nf_file);
>>>> -       fput(src->nf_file);
>>>>           nfsd_file_put(dst);
>>>> -       mntput(ss_mnt);
>>>> +       fput(src->nf_file);
>>>> +
>>>> +       timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list,
>>>> +               nsui_list) {
>>>> +               if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
>>>> +                       list_del(&ni->nsui_list);
>>>> +                       /*
>>>> +                        * vfsmount can be shared by multiple exports,
>>>> +                        * decrement refcnt and schedule delayed task
>>>> +                        * if it drops to 0.
>>>> +                        */
>>>> +                       ni->nsui_refcnt--;
>>>> +                       ni->nsui_expire = jiffies + timeout;
>>>> +                       list_add_tail(&ni->nsui_list, &nfsd4_ssc_umount.nsu_list);
>>>> +                       found = true;
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>> +       if (!found) {
>>>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>> +               mntput(ss_mnt);
>>>> +               return;
>>>> +       }
>>>> +       if (ni->nsui_refcnt == 0 && !nfsd4_ssc_umount.nsu_expire) {
>>>> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
>>>> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
>>>> +                               timeout);
>>>> +       }
>>>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>>    }
>>>>
>>>>    #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index 8bdc37a..b3bf8a5 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -483,6 +483,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>>>>    extern int nfsd4_is_junction(struct dentry *dentry);
>>>>    extern int register_cld_notifier(void);
>>>>    extern void unregister_cld_notifier(void);
>>>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>>> +extern void nfsd4_ssc_init_umount_work(void);
>>>> +#endif
>>>> +
>>>>    #else /* CONFIG_NFSD_V4 */
>>>>    static inline int nfsd4_is_junction(struct dentry *dentry)
>>>>    {
>>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>>> index 6de4063..2558db5 100644
>>>> --- a/fs/nfsd/nfssvc.c
>>>> +++ b/fs/nfsd/nfssvc.c
>>>> @@ -322,6 +322,9 @@ static int nfsd_startup_generic(int nrservs)
>>>>           ret = nfs4_state_start();
>>>>           if (ret)
>>>>                   goto out_file_cache;
>>>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>>> +       nfsd4_ssc_init_umount_work();
>>>> +#endif
>>>>           return 0;
>>>>
>>>>    out_file_cache:
>>>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>>>> index f5ba0fb..bb9ed6f 100644
>>>> --- a/include/linux/nfs_ssc.h
>>>> +++ b/include/linux/nfs_ssc.h
>>>> @@ -8,6 +8,7 @@
>>>>     */
>>>>
>>>>    #include <linux/nfs_fs.h>
>>>> +#include <linux/sunrpc/svc.h>
>>>>
>>>>    extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
>>>>
>>>> @@ -52,6 +53,25 @@ static inline void nfs42_ssc_close(struct file *filep)
>>>>           if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>>>                   (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>>>    }
>>>> +
>>>> +struct nfsd4_ssc_umount_item {
>>>> +       struct list_head nsui_list;
>>>> +       bool nsui_busy;
>>>> +       int nsui_refcnt;
>>>> +       unsigned long nsui_expire;
>>>> +       struct vfsmount *nsui_vfsmount;
>>>> +       char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
>>>> +};
>>>> +
>>>> +struct nfsd4_ssc_umount {
>>>> +       struct list_head nsu_list;
>>>> +       struct delayed_work nsu_umount_work;
>>>> +       spinlock_t nsu_lock;
>>>> +       unsigned long nsu_expire;
>>>> +       wait_queue_head_t nsu_waitq;
>>>> +       bool nsu_inited;
>>>> +};
>>>> +
>>>>    #endif
>>>>
>>>>    /*
>>>> --
>>>> 1.8.3.1
>>>>
