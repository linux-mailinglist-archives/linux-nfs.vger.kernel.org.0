Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74C3B6B7E
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 01:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhF1Xmt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 19:42:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12086 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhF1Xme (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 19:42:34 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SNaNS7016232;
        Mon, 28 Jun 2021 23:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oSc179tTZB3UvfyfPuLhtHYIbLrxNGLiiIYKasslzqs=;
 b=ZJXXTmD7YsfuSvXWO19H80ssSR3b14CNeeHEprGSfmKLokzktkh6fRYU309pCZEBhQsk
 y7nSGkjRjxZRdSOzqYGi0/8I11HLwYWF6ftxNEu8L9JY9FEa7TZJUZFHY8Pt/DBmnW5F
 he/Wk6X/BCAeF8kvRwLAxxzxvzP2mLni/m+l2JGodlCIrVUN+Jr0PhjpXq6eHPQC31iF
 Nz9Jom5zY5QXEtJHE+eCxQLCO5B6xHridggwa6qjbuV9/BYvkkSLW5ekTwljAqudlh7G
 EFANv0x3wFDs0SxsK5pFjzTf1tHZSJNxVkQraf2KEdomFu8hSH8Zg/klbvu065cynyZ4 qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f7uu244e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 23:40:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SNe0xC153921;
        Mon, 28 Jun 2021 23:40:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 39dt9dm6nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 23:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnK4Unej8xROzanxa3zU+tdXlePF/0X1MXNsQXT+uiVVc3lCpG0wdMFMwVZfSX96yEdD4r1UhKgnjPWZHHO6CTC6X8wMEiJIx+r1xJ2+9XYdTGx3CmJ3CvOesraL1jnRpyNI+HPbcl1fkoHHOwTVbbS6vu29k7zPABudogu/lk7mZGO1d4wkjJl1bjFQs8A34eL3Y+s4aVcf0JoNY1p6NTOeOVadkgCQEi7fVAvuowP314YJT3Nk4ZzIFYlYLQpAWL7OdkZTdwUAGyf/rDtA1lzTyows8bhKZmkbUZW1IuQiIlc7uXGppcDHw614LIPdbOvEmrWVjwAvCUW7LNg9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSc179tTZB3UvfyfPuLhtHYIbLrxNGLiiIYKasslzqs=;
 b=E/6qQpynuSJPiXeiWMhUYX7/l07Ci85oLX3hq4Dis0FG6yExrQ2meLDnW4MCOtQMHeFwqvs02N74pxmVCgpypOLCv/TVEIKbyM9rIDsmvPyXvwHFEwP8OzpuTueGt3iORXFvOfeAf0vZN8m/fLgZ8m+RnvomHF3ITO11Qf6nXvLiR9Pflnr4JaYer5wZT69iJ9tvjXK7feDnVdjnAQqgc0ikgfNpyCXTm5YiZ+xWbbm426cXsF/FtLC2A5gEWddPiCGr2HmrbUGKFa8Vm/9qxknEufuticy8rhPmETgDhJva/6K/OMmbTvc0qJy6PCFvrjv3l8j31UPY6PW2VEheoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSc179tTZB3UvfyfPuLhtHYIbLrxNGLiiIYKasslzqs=;
 b=Ooqq/h/wT2m9X0cOIGJEqEnj8hOJjWImYEoSuBpI83kwwCW+FVuQCxwSFO/B+6FRanBohB30gqjosauOhoNwXopYRJAc2BuQ4Tp+mSLOMOVsqFUlqXIlfiDkxWi3z8AKfuaqWB55PlCql/QiJr8HnB3krPq6aSFILrBDU17P2fY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3031.namprd10.prod.outlook.com (2603:10b6:a03:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 23:39:54 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 23:39:54 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
Date:   Mon, 28 Jun 2021 16:39:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210628202331.GC6776@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-65-149-77.vpn.oracle.com (72.219.112.78) by SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 23:39:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bca7e648-1c8f-424c-a971-08d93a8e07ff
X-MS-TrafficTypeDiagnostic: BYAPR10MB3031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3031C9CA27199BF0F3BBCCC687039@BYAPR10MB3031.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AV8MB3W6mEAmXk91lB3NvOHnP74ntyvPEifJwNm0jvazpvYFOwuIAYnEsXRSuvZgZ4VO0GPowgC05tpYT2FqxLd2PaNr/SWTCtTXmu4D4SmymtpFIljmlIbE1g96mjNDVwBQwu8styUCC+eFA/Me+4p7lfDyCLG42/Yb8nhpAYu1qjZJnpAOJcqo/GSxljBd3ogpDeqlQxGpF1hIin7DFeAGhZ5PfKBJESlRg3fnSTZsEBpqHytaANMpVsEFl1xvRG9mq0jK9BOZAwJYL/dsBwL6+egy/1zmkUzMzKGXgCnOd6HlLZZI1PBhyOcmFLUyM44pcIv0BsDJxP1CMjt9LBvKIW7OyHZ2Ro9127SnS8SL9TQEP0nYkyrtidUs1ZtzOwUT1Yg9AAQx/KRifsn+d8BBX5Q6H3JPMjtyOY6Ykqr8de3SZu+She72+7yIN6X51CgR232gF/7tMEiy2KjA5QM5yEWujbjFRtKvEG4TpLlhKjLCoVa/wBo4R1sLLsLPJhK8PBjo4SHXCBKJhscgqZVMJhCl5caTUZGUwZBFme+cetyykFFDJUXNRm/hDDwvZh8q3NsNuPQJg0xXzMObxGueLX5K3/xUI/aU3BwVXnDRqdcfHfFUt0Jtl2VlYVj1zFAXt7su7CtvpIW6pKMGX8i/nluhEjcOAdBLHiUp64ZCAdWwN1Z7WaQqDwolSvZIs1O+uWuuaj3I8Fh9pEy/qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(136003)(366004)(316002)(956004)(2616005)(16526019)(186003)(26005)(53546011)(7696005)(8936002)(31686004)(6916009)(6486002)(4326008)(31696002)(86362001)(2906002)(5660300002)(36756003)(66476007)(66556008)(38100700002)(66946007)(9686003)(8676002)(478600001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1A1QlpxdWVxcnJyNVlRdFBqTGhKWlVRQVlrQjJmRHZHOVhiUFFLR0pjS21Q?=
 =?utf-8?B?dEplbmg3Sk1zaXlCZHp0S0lIQWtqdytXeTNpbURFT0NHWE8rc2VwNkRDeUdW?=
 =?utf-8?B?SHdScGRlUmkwcE44aWM2cWpGdVA5ZFRySk13TXZJK1ZGR3RudEQ3aDFwcXRz?=
 =?utf-8?B?eURUcXYwU1RUNVBVeUNZSDdHMkxtNGgwcE94aVk1Wkw5bW8xY3VlUHE1MTc1?=
 =?utf-8?B?ZVdoNStyWkJYL0IzbGIyd1hDZkllMVZETU0wZUhGQWtMWDJPMWRrTGtVNDlo?=
 =?utf-8?B?c3NEYVYzekhLazdwRzJWWkIwVDN2NVRNc2pHVWVSM01FSEtqU2ZmZkZLdWpp?=
 =?utf-8?B?SnEvYTBLYW5OUFhaMWF6dWZLUGpHSC9uRGpoeU54MG5QQWZyZzRSUXM1dWFR?=
 =?utf-8?B?M3lzQ2MrdzFFb1A5VzVadHhWREg3ZzdJQTk1a3F4YllsbGxqc3VnMm9GNXlx?=
 =?utf-8?B?aXN2R2Q3R0p3ZnpFLzduRjRCSG9JVXpGNGJqSkJ0eFQyV0JFaU8rOFVpcHRw?=
 =?utf-8?B?RWg5L0RrMWRHdzVpS1NMZ0MzakVzRE51NjdiNUZuekJ0Nk5adGtrZ0JUV3RG?=
 =?utf-8?B?NWFKa09CMTFVZ1JibWROV25oZFN0RDlzbmtiYnpsbzYydi9qM01OaEYrM3lU?=
 =?utf-8?B?ZEROTlVsV0VaRWFZcHh1bXhhTHBuRHJFT05TOHFwM0dXOWZuT2xTWDlHUzFN?=
 =?utf-8?B?a0JkVGF3dnFLSDA0dkNudWlZNmtWQURrRFc4UThNTk81RVo3WmRSNW5mWTBJ?=
 =?utf-8?B?c1cwNEMwa2M2NE15WC9GTlZxd2hyM2ZENHZwWk9BeUJwMFBGdHFqR3FaUlRJ?=
 =?utf-8?B?N3NwSHJkaCt2aWRvelZKaWpRT080K0kvcGM2UnZoMm00cmFxSDBCcENoZWZ3?=
 =?utf-8?B?a2JELzNqSnVacjdGdmJ1YU92N3Qwd09jbGVheXhSUExETFVaZmgrdDZHaDRF?=
 =?utf-8?B?Q1Z2d25ERUE4N0RpbThTUVF0N0tFVDV0SXBHek96UkV4YmFGaGZpUmRyM3J1?=
 =?utf-8?B?ck1TS1ZnY29LQ3hmRVI5NFE1V0tZdUg4c3A3QjAyTm5iN1JqcUh1RHUycloy?=
 =?utf-8?B?aE91aFRVdmJEZ3VJSnNiZ3BwRCt4OGIzNkpGY0hDSUM1YlNLMG5malMxYWhX?=
 =?utf-8?B?UWZEd1dRL21hempZUVFlMGg2YnIxRjV0Z2t3YjJRd1pCVzJHbXdYVXgrTHRz?=
 =?utf-8?B?Ym9IN2Q5Y0tTd2ozeTlFazllQVZwVFhkTS83dUNDU3NrVmRBOE9TbHQxY2xx?=
 =?utf-8?B?RExJc3J3d3pUNkh0QUY1UGJqd1c3NHMwcmpBTjVmREhDcnNXVnd4OEFhV3BY?=
 =?utf-8?B?elhRdFdENkFSQk1OelVVSkNHMGpDaHlVNkg4Tk13RUpnWGJ5a2JPeXVoTDVa?=
 =?utf-8?B?eTVrOWVHUUZ5TlNqTkI1a0Yxd1ZhSSt1QnBLTzg4QlFqV1pMQm0wbWYycXBY?=
 =?utf-8?B?V0dNaTYzOTlJZHlZY2srcmxjbmlFL3ZKRFJpSEk0b1hmQ1ZjT1NBY0E3dnFE?=
 =?utf-8?B?ait5K0lyQ0I4enlrZDd2Tm1pdWpKY2JXQTVXNnpGMzZncFBWRC9sZmRNTjAy?=
 =?utf-8?B?ZUFneWQyejVpM1FUQ1ZDZTNWbThvWWtuZEdLbENKOHZFYk1Nenp0MlBkK1ps?=
 =?utf-8?B?d0pWaEYxOVpjZVNzcDZ6c0NZVk5HVS9nRTlTOU5aa1V0ZWxBUmdyMCsyWk9N?=
 =?utf-8?B?VUJucWhvVmFCVUwvOUJNQkFBRnZUd3duMXVBb0kzSEpZdnRySXZiTThQYTRF?=
 =?utf-8?Q?m8worbrxfE9zWjwQCgvZZevOcMOTbZhABZYu0mT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca7e648-1c8f-424c-a971-08d93a8e07ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 23:39:54.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHzC8BFFt4diRL3AEYwmGodOim5+1L0apCMRjS+ypTozzTblJ9QnRwzM0gotMiQIdoIVzu+0ncbcAjAcPn/GVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3031
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280153
X-Proofpoint-ORIG-GUID: zs_i3ZfqzYKuMAE42Vz5jn6EsdC4sklc
X-Proofpoint-GUID: zs_i3ZfqzYKuMAE42Vz5jn6EsdC4sklc
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/28/21 1:23 PM, J. Bruce Fields wrote:
> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	case -EAGAIN:		/* conflock holds conflicting lock */
>>   		status = nfserr_denied;
>>   		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
>> -		nfs4_set_lock_denied(conflock, &lock->lk_denied);
>> +
>> +		/* try again if conflict with courtesy client  */
>> +		if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == -EAGAIN && !retried) {
>> +			retried = true;
>> +			goto again;
>> +		}
> Ugh, apologies, this was my idea, but I just noticed it only handles conflicts
> from other NFSv4 clients.  The conflicting lock could just as well come from
> NLM or a local process.  So we need cooperation from the common locks.c code.
>
> I'm not sure what to suggest....
>
> Maybe something like:
>
> @@ -1159,6 +1159,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>          }
>   
>          percpu_down_read(&file_rwsem);
> +retry:
>          spin_lock(&ctx->flc_lock);
>          /*
>           * New lock request. Walk all POSIX locks and look for conflicts. If
> @@ -1169,6 +1170,11 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>                  list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>                          if (!posix_locks_conflict(request, fl))
>                                  continue;
> +                       if (fl->fl_lops->fl_expire_lock(fl, 1)) {
> +                               spin_unlock(&ctx->flc_lock);
> +                               fl->fl_lops->fl_expire_locks(fl, 0);
> +                               goto retry;
> +                       }
>                          if (conflock)
>                                  locks_copy_conflock(conflock, fl);
>                          error = -EAGAIN;
>
>
> where ->fl_expire_lock is a new lock callback with second argument "check"
> where:
>
> 	check = 1 means: just check whether this lock could be freed
> 	check = 0 means: go ahead and free this lock if you can

Thanks Bruce, I will look into this approach.

-Dai

>
> --b.
