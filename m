Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E9B3B6DAD
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhF2Ena (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 00:43:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29182 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhF2Ena (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 00:43:30 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T4eoqM024115;
        Tue, 29 Jun 2021 04:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YdVy3Djsac0zvtXNjc2ylj7FsjDi3bWxfRcllIpTV4o=;
 b=DlMA9lwx47bMmecrCrXGJjGHXbCa6IK1EY7kccNvITLiC5/NRs+J/GzpbNCOhSvdQQ+4
 VtPdUqT2BDToHHx1Zb/wxQ2MQtFjXSduINLxsPhOaV/sGbeZyawsSNJbnj7skH/9W0c8
 OVyFBRVmjKzsHgwAjIr4krLsMXMrM3ozjAwgt2BtrjYzJyIKA7rOP+CmrgmQJY6PPkpc
 bmKX67IxcL1HSooQxX8b2IfjLgANVGmFG41AySTKKXjSFzUts1pLECyp/e7Lb548d1z3
 AeQslFjRNSh0mbF7aRoObkdKUq7rOj78oFJ0cRHc/BZyhtjvfw6gBOJ6Cj43OBlrMEpj nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f174jqfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 04:41:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15T4Zpl0021404;
        Tue, 29 Jun 2021 04:41:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3020.oracle.com with ESMTP id 39dv24up50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 04:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu6JGi8u8iJKFv7aafcGVIva7TF+pQFi0wo74g+aSnwe5GonW095YT3AizgKZibcQ47dgpZO9uzGBktO3TNyBlQoDsP/KzMAdiJydZ77COjPw2bEaa7BOnj4ee8BoT6AZBlGSardLN2lLIvlpfT5NWkfEUMVP/3A80mFG5iRWF8bu5oEmGidFKg8kUGmLgyJjH8PGlLiKALwfdWW88osQMB4gAHtJluBgPRoab+ZYkChuxvCqqMVTVfh+v+n1qw27cohafNiSir0IYiUq84WTkQL/xoOZNXA7O4r9HLWK5Web17fhUF0q55hPknhZqtJB0qumJexFa0TcKh9U1wF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdVy3Djsac0zvtXNjc2ylj7FsjDi3bWxfRcllIpTV4o=;
 b=k7Nx0HYkEmlai5Vw9HwtxboLl4HyDGICXPYxTPX4qlRroJotz8XRACAxi5x27Fw20nh9s5T4+FfmvihJ+o/EgQD5dDh0D1HfCll1kBSB7dAjnrhydPOiuubncHSUF9G99J7MSBhdjmaHrrtetuJ5EmuDy1xwqWi6o4OVYjfXoT5Xm/C+akJtGWX2Zh2VG0m01Ra2Hfdf7jNLpMyctFu9WttlaAVT+3fj1wOJJXrHtH41vvwVdb/X4gXffpvmzW/NyLYISC1D/+LPk2Is7k3pT6mvVdIrodB+GV7kZNPRyFlBqzPNh4eiXHIiK6zTLuyaRWU31aMQ5Um5JY5DIPiTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdVy3Djsac0zvtXNjc2ylj7FsjDi3bWxfRcllIpTV4o=;
 b=H5E514/VD5+R8og97AY5VLJq9U2xpbc1pwK9R8AfxF4+IeFLHqDt2WOk+rzqyS9Yqr249bGo74CFOvApb7qfIzaRJnlkFCZW077uHONHhfPAhKzgx8seR+NjL4h4Af3Kq5EehwAo506L+DDC2MOnjt/hZybUGTriu/x/K+MuY5M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 04:40:58 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 04:40:58 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
From:   dai.ngo@oracle.com
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
Message-ID: <fae4d46d-286c-013b-7606-97231fb1c17e@oracle.com>
Date:   Mon, 28 Jun 2021 21:40:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-224-184.vpn.oracle.com (72.219.112.78) by BYAPR08CA0038.namprd08.prod.outlook.com (2603:10b6:a03:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend Transport; Tue, 29 Jun 2021 04:40:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9adff30-1fa6-434a-0d43-08d93ab81701
X-MS-TrafficTypeDiagnostic: BYAPR10MB3718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB371891CB1DF68D61256FA83487029@BYAPR10MB3718.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hX5sFX+RK3XjN5sQ0gXJQ0I0D+jSnmDVIrI5J+eZxiH9r8hwyX6rGjwGtdD7FNdlEnlNe1GSthOmlbC1ziVqhhPJM/zI71E01FhqWfrwAs5jLtORCG4cw1d0bALBoG/RcUQLwSqOLYrgNg4od7Jm7v8RsTWRFXd8Ti/7Cv9v3eqLarx/CWSN3W1QMSDYTnN+OSqS2MqoRmPjIDpJBkDkcCh2R+5PK9RpQVoXJ7CQlRytBG7gHY3NkLJyWdwgMLyjmRpOnxmQXrCj9PmwyXOs5jddw32oL//RVtIhTBrRuJkN6FJuYZfn5M9wZOOK+A0tgb+bA147TCBr/Kv8Y3R8cIdXs7HDy1Xq4bBNrQpvd6UgksEHsCwf/sp2XHZnuN+dfHT9Yczq+e+bd0CAJGcLVA8AZcOQMRK3lXbt8rZbDio206ceyg06Hh4Tw2pSk41/o8Bw0AMKmjkijQNs3SOE6g/fPEfwfSxnieWHqdN2MsRpVgO0ovmsHiPdyhj4VikEvkLdvKwVHA8h9uEaWXQ44Vi9G/boeW0IvlWGsZ4O19+D1RQmtnK+z0vaMK5/xoJoQgWHV5ZPV2un72uPxDfF4gVuG57RAk1ZnIqslZHD/rG+AtVpPKlEhURQtScKMxz+pZXiibyDDasoaYGY+Z7Me8w4ETBE2gqcWKn/RWprRwxOfItuCe7Fhcv7slR/75fUZ2Ic9ha6DkvevMztQVHKWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(31696002)(31686004)(86362001)(16526019)(26005)(8676002)(6916009)(9686003)(4326008)(2906002)(186003)(2616005)(36756003)(53546011)(5660300002)(38100700002)(956004)(316002)(478600001)(8936002)(83380400001)(66556008)(66946007)(66476007)(6486002)(7696005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzQ1YW53NHdDY3NJN2o1MU9Ja2Zmekh6dWJydXpGV21SUFlBOGZZelhkemk4?=
 =?utf-8?B?b2h0QkNtdXhyVVZFVk1yMjVCcWJUZ04reW9zNmNqb3Yzekl3bUVSeTdnUmNL?=
 =?utf-8?B?RjlxcFpzNFBTamdjUVl1ZC9qejVRNGI3bVVOUXlLZWw0L2lmaXpTaWtkaERW?=
 =?utf-8?B?S3NRQmgyRVdKT0JwMGVpekxOYVllMHg0Qm44bEhPbXhXcmJib2JtWkJXL1pD?=
 =?utf-8?B?YzNLYy84emxXMDdoRzc2N2FmcDQ1bWxaNjd2MndYYWJsZi8vVlZOOWJuOVpE?=
 =?utf-8?B?Nnl1U3ZXQ2Z5MGF0VGowU2FUNWVFMG40R05iWU80dGxMQ1lYSEViWmJPck9G?=
 =?utf-8?B?YjFqbW1Cc3hCZXFkUW15aFIwZEhQV0VnRGJiNXcvVjJIdlZxbndKazNMcUNs?=
 =?utf-8?B?elVxci9kNFZjWGxxMVo4U25lRC8yaWJFQWxLNzB2YlFhT3N2OTJWYlcyNldE?=
 =?utf-8?B?RGJUZVJTVVBFZ0NWeXFuUG1hUW9XSGFYN29iQ0QzVTBDYS9CR0pKNms5Rklj?=
 =?utf-8?B?UHFYWUZpREdDYVJRYXo2M0cxZnQzSFJ2NlI4anMwbHV5YWlibDl4RjNuMDJV?=
 =?utf-8?B?WHBWeFdtN1lkc1pHOTBDdEd0aU9aR09qLzRsQ2pSQTFlTlBDUy81Szdkb1pi?=
 =?utf-8?B?ZkhkdVdxUWp0ZVArYVc2ZnFhQ1lJQmZuSWFiTnVkNkxCdlIzZVRiQXkyTnM0?=
 =?utf-8?B?MVFjZkd2eGJNZkh5dDVhV3RLMTdPNkptSHRHeGJQTlluMmpmUTVSOXlpRUVO?=
 =?utf-8?B?bEd4RjEyZTExNnNJSm0rY0RHV2poV1ZoMHU1Mzd5NExsYkM3d08xdFFVU2g2?=
 =?utf-8?B?WnVDRmo0VHZHVW50Ni9tNlVpbUgyYmF3eHVqK082UVdJb1hFZytLM2RJZnpN?=
 =?utf-8?B?NjJVM0JUWTAxeFp4U3R3bExBU0Z3V1RIODNrOVJIMVBGK29NaERScEtnNXNm?=
 =?utf-8?B?R0JsQ2Y4am9QdU5WMUZzYWVBNEw3RmFXbjZ6ckI3NGQxeFIxaVM4ZlJpeWQr?=
 =?utf-8?B?TVJOMGZaZ2czcDdUNXpiNzhrUmtLVCs5ei9KUTZmYmNuU1NUYjBJUE5ENEhZ?=
 =?utf-8?B?b0JQNzVLZTUvWURrRXBXSTFac1RrQnZ3cEpTakFDaDJVeFhBeEZKV0xnaEtn?=
 =?utf-8?B?MC80a0lSQTdSK3ozcDhwd0hJTi90QytSMjh2OXdLZUNOaGJ5WVR5SHNQZkRY?=
 =?utf-8?B?Mm5vWVhNTStIallvVHZxWHliMDB5anNuelFrUUMrbStZL2RSOXFBS0ZpcE5v?=
 =?utf-8?B?SjZVaU4zSWpRcHRnc3IwOFhVZnJ2bnF2QVh2ZVROWnBJQkc3YUhBQmM4S290?=
 =?utf-8?B?M0dobDhvVmRuV0QrRkg0L0NKVUJzaU9uZUxRU1I0aTZsUU90SnBBVXpjdmxW?=
 =?utf-8?B?a2d3dFlQMUdNbzdLLzk0UElGRjVldENCalF5VHJvM2pQNmYrNWxnWEdkUVBO?=
 =?utf-8?B?ZTcxeWRuRHk2WktsKytHL1FjT1pMQVJZenVQY0pMSmplSUJxbGpLQUJPZDZi?=
 =?utf-8?B?UGhDQVR6WFdtL0g0ekg1QnNQL1dQQ0lTdmh2Mnhoc2NBRU91cjVBRWNNcjdU?=
 =?utf-8?B?YzlUK2FMYjI1MUJQdTdiTmd5MVJZaW9WQkJVTjRBMDRJNFB3Ni9HV2Q3Zlh5?=
 =?utf-8?B?YksyU1dvOE5OYkhYWXZDWHlQZjFTUXRZNmRaRXh6dDA3VzRQaERoaWovaHpJ?=
 =?utf-8?B?OWt2ZVNWa1RKTWZpVW10bHJ5c092cUV0YThDTE4vSmtsNEZHNUk3NS9BU3lG?=
 =?utf-8?Q?/2dVGpUMkUeyfafI1wh61IOjuG0BVxmCMsmBvE0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9adff30-1fa6-434a-0d43-08d93ab81701
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 04:40:58.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A7gdFYCqIvaFh/Eok2e+8G6s1Sy7muV8Nc8AyYJPOK4vPUESSB9WTD6Qk6kUH/R9kDXpdDBAuAR5BDyrFyZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290032
X-Proofpoint-GUID: OTBAHL8en_KDF_IShikufzKeFHrUASHb
X-Proofpoint-ORIG-GUID: OTBAHL8en_KDF_IShikufzKeFHrUASHb
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/28/21 4:39 PM, dai.ngo@oracle.com wrote:
>
> On 6/28/21 1:23 PM, J. Bruce Fields wrote:
>> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>>> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct 
>>> nfsd4_compound_state *cstate,
>>>       case -EAGAIN:        /* conflock holds conflicting lock */
>>>           status = nfserr_denied;
>>>           dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
>>> -        nfs4_set_lock_denied(conflock, &lock->lk_denied);
>>> +
>>> +        /* try again if conflict with courtesy client  */
>>> +        if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == 
>>> -EAGAIN && !retried) {
>>> +            retried = true;
>>> +            goto again;
>>> +        }
>> Ugh, apologies, this was my idea, but I just noticed it only handles 
>> conflicts
>> from other NFSv4 clients.  The conflicting lock could just as well 
>> come from
>> NLM or a local process.  So we need cooperation from the common 
>> locks.c code.
>>
>> I'm not sure what to suggest....

One option is to use locks_copy_conflock/nfsd4_fl_get_owner to detect
the lock being copied belongs to a courtesy client and schedule the
laundromat to run to destroy the courtesy client. This option requires
callers of vfs_lock_file to provide the 'conflock' argument.
This option, let's call it option 1, is similar to what you suggested
below (option 2). Both of these options can handle lock conflict between
NFSv4, NFSv3/NLM and NFSv4 client.

Option 1:
For lock request that uses F_LOCK, the client retries lock request on lock
denied. The lock request that gets denied also causes the courtesy client
to be destroyed. Client succeeds on next retry.

For lock request that uses F_TLOCK, the request failed with lock denied,
the client does not retry and returns the error to the application. If the
application tries again it will succeed since the courtesy was destroyed
when the lock conflict was detected by nfsd4_fl_get_owner. I think this
behavior is ok since the client can not rely on a specific lease expiration
time maintained by the server.

Option 2:
For lock request that uses F_LOCK, since the new call, fl_expire_locks, is
called out of a spinlock context, we can call expire_client to destroy the
courtesy client in this new call and modify posix_lock_inode to retry the
loop. With this option, the conflict lock request is allowed to succeed
without the need for the client to receive denied then retry.

For lock request that uses F_TLOCK, the conflict lock request is allowed
to succeed same as in F_LOCK case. The application does not need to retry.

Option 1 does not need any modification in fs/lock.c to add new call and
do the retry. It does need to modify fs/lockd/svclock.c to add the
'conflock' arg for vfs_lock_file.

Which option you think we should take, I'm open to either one.

Regarding local lock conflick, do_lock_file_wait calls vfs_lock_file and
just block waiting for the lock to be released. Both of the options
above do not handle the case where the local lock happens before the
v4 client expires and becomes courtesy client. In this case we can not
let the v4 client becomes courtesy client. We need to have a way to
detect that someone is blocked on a lock owned by the v4 client and
do not allow that client to become courtesy client.  One way to handle
this to mark the v4 lock as 'has_waiter', and then before allowing
the expired v4 client to become courtesy client we need to search
all the locks of this v4 client for any lock with 'has_waiter' flag
and disallow it. The part that I don't like about this approach is
having to search all locks of each lockowner of the v4 client for
lock with 'has_waiter'.  I need some suggestions here.

-Dai

>>
>> Maybe something like:
>>
>> @@ -1159,6 +1159,7 @@ static int posix_lock_inode(struct inode 
>> *inode, struct file_lock *request,
>>          }
>>            percpu_down_read(&file_rwsem);
>> +retry:
>>          spin_lock(&ctx->flc_lock);
>>          /*
>>           * New lock request. Walk all POSIX locks and look for 
>> conflicts. If
>> @@ -1169,6 +1170,11 @@ static int posix_lock_inode(struct inode 
>> *inode, struct file_lock *request,
>>                  list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>                          if (!posix_locks_conflict(request, fl))
>>                                  continue;
>> +                       if (fl->fl_lops->fl_expire_lock(fl, 1)) {
>> + spin_unlock(&ctx->flc_lock);
>> + fl->fl_lops->fl_expire_locks(fl, 0);
>> +                               goto retry;
>> +                       }
>>                          if (conflock)
>>                                  locks_copy_conflock(conflock, fl);
>>                          error = -EAGAIN;
>>
>>
>> where ->fl_expire_lock is a new lock callback with second argument 
>> "check"
>> where:
>>
>>     check = 1 means: just check whether this lock could be freed
>>     check = 0 means: go ahead and free this lock if you can
>
> Thanks Bruce, I will look into this approach.
>
> -Dai
>
>>
>> --b.
