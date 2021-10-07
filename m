Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217314258C8
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbhJGRFs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 13:05:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64764 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241576AbhJGRFr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 13:05:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197GelsQ004062;
        Thu, 7 Oct 2021 17:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PRqPR6CnczLR6MQcLRXSyNUKK3FBRMszthuDb/l91r8=;
 b=nIntR8y+j12Q3iMTJTPdR3dNjHn6+rshewMNEVPzTPLqk2GSvr60Sfnrdd+0fnRBjgIG
 2Kp2Xe/meI2r9qI67EN3M2uYlKJak+7BfpYchQwE+RHXAd4wB6R4cEixH1q7xqPgJ8qF
 O1wHm/9s7zR5cDjlSSZAn7PFnKNgYG5vP1yI1Yy6Hpy42/fdcltBnQKN11VHbK7uQsux
 02OU/MmrMMsfOrr0VvZmTVE5vrVkUAxS1qXtg1RubYaIEg0RflzwJGWRDepxXWJWg/C8
 2srpJ01rYNTZS9c9u9nKYXXRkSOcVak2NeVpB6jy+0w6VYvehun6UZMXti+imL5WQxjn pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhxbs361c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 17:03:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Gsnmw181583;
        Thu, 7 Oct 2021 17:03:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3020.oracle.com with ESMTP id 3bf16x5bfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 17:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmzCvaGTfcrcp10/uBPeDBypjQjn42vQpfBxqHdfwSc+bQkMhglW1k1UYr91AbOLYD2eDuLdef5uB9pTtw5wXxWpP0fQFG00XU+ROBPejdbSp4EIk6xL6mZemp3gdSouIWHuvV0FJKZ93d7b9Tu8fbRVWgCZN5ilJuW73rD+Ry/+oQ1qS4+7Z65ajV9son3cxlhawwgQbpEvf9HYAycbor1uGmRCnSYHysr4Mm9iJv54VSPZveWAhg570jmzGa+hzDp3d9ecBp7dZrYutG+UWu8W8JW+UnucbHiDS3225854k5NbRejdxHgWWIdY8ba/3a9acauhMKWW8fs8VZlWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRqPR6CnczLR6MQcLRXSyNUKK3FBRMszthuDb/l91r8=;
 b=RllMIXKMzSRVHbBOi4GakyNNED1tp7Y39xXTJu41MpcuNi/h96Z35wtt9U7K4gagUfufawKpoQGNe7UHKRoVKsHhO0WaiMjB7XIwW2PSJyL7hQiz2lAOcwZTzkdPAkQMgTpVwuQYazR8uyL/C5DB29m2q0WLOnPqmq0P3gsGWunSx7wlKcIalayKa0YN7Cuq7xbrlk3x2UNZxaJjU7WWhhLCET6+/TbdN7MjP4ImmiXRmO9q4aIOzC8oCDVaBubp9DTQu4mF5k7zZbDgWbF+sBu8G4Ojn5qrJj0dX2A6BJAeyLpQxyN6FMXM73kLMM7Oe9As1JGubtAuqhUtyTKFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRqPR6CnczLR6MQcLRXSyNUKK3FBRMszthuDb/l91r8=;
 b=H7Ewj96LwnVyRVcZxvtOn1htT/xZxDfubXbUOU2Kc6OhR4pXY4wNaqqej3V4MdgG1ckWA99SOW0JEhZQKgF2Ddq5lia2UZMWyUVj9MaopcZqB6JVBuYtqt5wX4RllJ/8rJXCCFhfw6zVuHmIOfN6I4H1KpBe84biJy3ZXAmNowE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3605.namprd10.prod.outlook.com (2603:10b6:a03:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 17:03:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%8]) with mapi id 15.20.4587.019; Thu, 7 Oct 2021
 17:03:37 +0000
Subject: Re: Locking issue between NFSv4 and SMB client
From:   dai.ngo@oracle.com
To:     Bruce Fields <bfields@fieldses.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
Message-ID: <4c98a686-3be9-6f95-ea1a-8f03fbf3ea0c@oracle.com>
Date:   Thu, 7 Oct 2021 10:03:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-146-236.vpn.oracle.com (138.3.200.44) by SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 17:03:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a032551-0118-4d99-5010-08d989b46787
X-MS-TrafficTypeDiagnostic: BYAPR10MB3605:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3605AF9AF641F9BC6B53800087B19@BYAPR10MB3605.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkdje9Iui+8wJXvYMD4HviseEbA4nHxSC+nxt7FTT4WdIzlli7FJ1gKcqbo8BkhVZXThzTcjZyMsFxLzygBwZla/psmxcfS1JPSXqr6GtF+zH5jCzJ/Iu1oAkpPyBZcLXH8ARNVVBwmEWp5sxcm+5ttDSrjI3SDGKrutGIH0zqCNFED0DyjgdzlENBw3NltZgZ0Zh7b7Qb/etoDTBx+bFVUrDXZH5ztwarjOqTUPq7wD9gMyP+S4JoHQfeM+wO2lBMKWGMeKTPT3EOD0K0u6o08kvzlFGwymGuWuXQPeifhs84hXwJs8m0/bm7y/47Tv+90uZ7nkO3nDlXUlNqJ2UdL9eC+caHvNAG69WpVR8xLNszMMtXcfTGg5I0g7D4rgl4norVKUDA9FA0AkqGTlLan3gbyUmz66PBxox4GkszN+48wftMgOWICieSdiaWfPOFx56gEqqjs8iZmJ973f0SLOd0NweKdWL1ay6InQCFsgroAE3GYfblYm249Olj3yoQKY59QPlidnkHcCDK1Bpf/ClQyopJPmlzJI4YLh9APW3tRVLT1mFJO1HpgHwaINv6ATzxAs5zJOAAr0t7JwclBHjRBZWG1Zq/c1MfhSZRb8ScgvRFW0Psb0x90x/UwYGwfyyIyyNIxIMIDgkfCIUnyplBw9826Ky+vXgpjuDWWYIj0qGhPfN/0DXUIPQ98P3cwKEgrP6KWpTYLZSBL3uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(4326008)(2906002)(53546011)(7696005)(31686004)(6486002)(31696002)(36756003)(6916009)(186003)(83380400001)(956004)(9686003)(2616005)(66476007)(66556008)(508600001)(66946007)(86362001)(38100700002)(8936002)(54906003)(316002)(8676002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VnaTR0anVyZ1hFZUkxblkwNjR3V2taUzc1S2ZQcyt6Q0pPY2RHK2llY3ZC?=
 =?utf-8?B?Z2FmbTcvQ2R1NmMzNWM1cE9SMVBycG1YK252QzcvRERUZUN6VStiaFNYNWpS?=
 =?utf-8?B?MWNPRFVpUzZvNGRLNkg5Zld2WkRyaDZtZ2tkQnZyYXRJcW5BMHVUVmNENURH?=
 =?utf-8?B?T2xrR0NYdG5hK25UcVJlN1N0aUdHZ3dHdHlMZlRmaGwvamU1djJPek9PRXJo?=
 =?utf-8?B?bmZrMDh0OGpVemkzaFYvSEpIOW1QYTNjaDNCVnlsemhsMDVwYjJXbjVLME1l?=
 =?utf-8?B?TVhmc2NHOUM1ZkM3M0tyS0FaUzYxY0tiN1Z1anJ0WG1qSVNHR291SVBsdzJE?=
 =?utf-8?B?elhNMFkvSWM0dTZodzlweVU5WlA0Y1F2S0FVaW0vUkNYT2dWVUxOSzJkZzcw?=
 =?utf-8?B?L2svZTJ5TUliVmJjTXBPR09VSE8yYUJzVlpONUVwc1V6RHBZbENmZmE5KzhZ?=
 =?utf-8?B?ekpLcCt5c0NzaHREVGJFOFg2OEJERHZDSGpEUHE2R0pyc3JrVWRicnROLys3?=
 =?utf-8?B?dVhaUnk2TCtLRW9BbzUra0V3azhNdWJuL2hxbnhMN2RyQUlsNDA1cG9CbWhu?=
 =?utf-8?B?c3UxZnFYekJ3KzdkcERXUEgySVBSTktUa1IwNDZNbEk5alZFWkYybzdLMlRU?=
 =?utf-8?B?WG55RzhDV0dHcENhMFFzVnRVNEZyZU5YQktPZDkrU0Zub3l6czFhbFNsN1VE?=
 =?utf-8?B?N1dIYW9PWjdEeU9wSWF6ZGFKWlVuWUhXY1dISWNBdzRsbVBzNm5sWk93bnFr?=
 =?utf-8?B?NGhNdmpsVWx5eGl0ZUwwOVlJUHc4c0N3L05GTUxtQmkzdmltZWRrenlMajBk?=
 =?utf-8?B?SUFVUGRpbXRYTDdFakw5NUQ2QlZaRC9pd3hmVnlzb1F3SXZyUEpGUkgxN2Zp?=
 =?utf-8?B?dkRZbE1sU1pnMlM2QmRoQXo0dHd5QjgvVnBrS0FLMnhoUWduSW1uV0xhelU2?=
 =?utf-8?B?cmFIUU1KR2xKNEtWQTU1dTE3a0syWTlrTGdUS21oYWxSZVRTWUlra0t3MHdZ?=
 =?utf-8?B?ek02eEJlc3dFdTBubnVJaFYvd3RtcWFIMi9QVXh5Z2U3VWJvTXFMK01RL2Mz?=
 =?utf-8?B?MEdOQ1J6bnNPby9Wb0hTRFdtTEpCODlob1BFczJKQ3JZQjFLVFYvMkxvdHNP?=
 =?utf-8?B?U1g5Q0FXVHZPa2puay92NzBPdFJlZUNIM3UvQWg2OUVpR2daNmcvbk1maVVR?=
 =?utf-8?B?WUE2Si82cEhYZ25idWxBaDV5L1k3cGJxaldMN1E5elhnK040ZUMvZzkraEdY?=
 =?utf-8?B?M3d2dGJaTWd1YkdyejRTc1ZleVJIUmU3N2hiWlBrekVvZnE2cGNPWjhUa1h0?=
 =?utf-8?B?aHZzNGUrT1F0VFYzQ0dpMjhkTW0rUm5XcEcxNS9peFdtN0F1TTRQNWF4MlVV?=
 =?utf-8?B?WVA3OWRBN0JtZnNhY3JXYTJOck9OTWhIRjhNVWtEclE2NXRPelg3ZUdzUmRz?=
 =?utf-8?B?OE9NUnJHRnlKNVNMeDN5V3JIbkw4UklpTVVqRkQvbDk0bHJDNWd6TXhnNXJp?=
 =?utf-8?B?NTQ0Q0VrZkttUGpON2J3eHJpUFBBNVVqVlZSWlpiaXNMS2JpcGlQYTNVeFJM?=
 =?utf-8?B?VFVndy9NeWk0a29vaWZrVWtvYnc0Y1dIM0ppQnFEOWlGaXVlN2pyVUFjenFR?=
 =?utf-8?B?aHdrNlRHdWt5VzN4Rm1ZbHFnUVV4NUZTZ0tqaHo4UmVrczNrMURQTVdheUN2?=
 =?utf-8?B?VnhFUG1kL2grYnVCWTREQWMvTHlOSmpyNU0vbVQyZUtQaldmYXk0bjNsbU5U?=
 =?utf-8?Q?/D1RSkMA8kLHrXKOPI8AriFvsrMy1mjvDRXfS2Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a032551-0118-4d99-5010-08d989b46787
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 17:03:37.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRZHpsjJJhcuIy5YQX9v56JKybLRLVS+P43V4AMZ10H3LnqEAWN9wTYVwCCGRViDmyFhodm7njG0KgXgJfwZvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3605
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070110
X-Proofpoint-GUID: 0cU2Zm5ltxy2sHuOIlCwKSszVZrUYcCz
X-Proofpoint-ORIG-GUID: 0cU2Zm5ltxy2sHuOIlCwKSszVZrUYcCz
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/23/21 3:39 PM, dai.ngo@oracle.com wrote:
>
> On 9/23/21 2:50 PM, Bruce Fields wrote:
>> On Thu, Jul 15, 2021 at 04:45:22PM -0700, dai.ngo@oracle.com wrote:
>>> Hi Bruce,
>> Oops, sorry for neglecting this.
>>
>>> I'm doing some locking testing between NFSv4 and SMB client and
>>> think there are some issues on the server that allows both clients
>>> to lock the same file at the same time.
>> It's not too surprising to me that getting consistent locks between the
>> two would be hard.
>>
>> Did you get any review from a Samba expert?  I seem to recall it having
>> a lot of options, and I wonder if it's configured correctly for this
>> case.
>
> No, I have not heard from any Samba expert.
>
>>
>> It sounds like Samba may be giving out oplocks without getting a lease
>> from the kernel.
>
> I will have to circle back to this when we're done with the 1st
> phase of courteous server.

I disabled oplock for the SMB share and locking between NFSv4 and SMB
client works as expected. It appears that smbd does not set the VFS
lease on the file after granting oplock to smb client.

-Dai

> -Dai
>
>>
>> --b.
>>
>>> Here is what I did:
>>>
>>> NOTE: lck is a simple program that use lockf(3) to lock a file from
>>> offset 0 to the length specified by '-l'.
>>>
>>> On NFSv4 client
>>> ---------------
>>>
>>> [root@nfsvmd07 ~]# nfsstat -m
>>> /tmp/mnt from nfsvmf24:/root/smb_share
>>> Flags: 
>>> rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,
>>> proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.80.62.47,
>>>         local_lock=none,addr=10.80.111.94
>>> [root@nfsvmd07 ~]#
>>>
>>>
>>> [root@nfsvmd07 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
>>> Lck/file: 1, Maxlocks: 10000000
>>> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing 
>>> F_LOCK..
>>> LOCKED...
>>>
>>> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
>>>
>>> [NFS client successfully locks the file]
>>>
>>> On SMB client
>>> -------------
>>>
>>> [root@nfsvme24 ~]# mount |grep cifs
>>> //nfsvmf24/smb_share on /tmp/mnt type cifs 
>>> (rw,relatime,vers=3.1.1,cache=strict,username=root,uid=0,noforceuid,gid=0,noforcegid,addr=10.80.111.94,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)
>>> [root@nfsvme24 ~]#
>>>
>>> [root@nfsvme24 ~]# smbclient -L nfsvmf24
>>> Enter SAMBA\root's password:
>>>
>>>     Sharename       Type      Comment
>>>     ---------       ----      -------
>>>     print$          Disk      Printer Drivers
>>>     smb_share       Disk      Test Samba Share <<===== share to mount
>>>     IPC$            IPC       IPC Service (Samba 4.10.16)
>>>     root            Disk      Home Directories
>>> Reconnecting with SMB1 for workgroup listing.
>>>
>>>     Server               Comment
>>>     ---------            -------
>>>
>>>     Workgroup            Master
>>>     ---------            -------
>>> [root@nfsvme24 ~]#
>>>
>>> [root@nfsvme24 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
>>> Lck/file: 1, Maxlocks: 10000000
>>> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing 
>>> F_LOCK..
>>> LOCKED...
>>>
>>> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
>>>
>>> [SMB client successfully locks the file]
>>>
>>> The same issue happens when either client locks the file first.
>>> I think this is what has happened:
>>>
>>> 1. NFSv4 client opens and locks the file first
>>>
>>>      . NFSv4 client send OPEN and LOCK to server, server replies
>>>        OK on both requests.
>>>
>>>      . SMB client sends create request with Oplock==Lease for
>>>        the same file.
>>>
>>>      . server holds off on replying to SMB client's create request,
>>>        recalls delegation from NFSv4 client, waits for NFSv4 client
>>>        to return the delegation then replies success to SMB client's
>>>        create request with lease granted (Oplock==Lease).
>>>
>>>        NOTE: I think SMB server should replies the create request
>>>        with Oplock==None to force the SMB client to sends the
>>>        lock request.
>>>
>>>      . Once SMB client receives the reply of the create with
>>>        'Oplock==Lease', it assumes it has full control of the file
>>>        therefor it does not need to send the lock request.
>>>
>>>      . both NFSv4 and SMB client now think they have locked the file.
>>>
>>> pcap:  nfs_lock_smb_lock.pcap
>>>
>>> 2. SMB client creates the file with 'Oplock==Lease' first
>>>
>>>      . SMB sends create request with 'Oplock==Lease' to server,
>>>        server replies OK with 'Oplock==Lease'. SMB client skips
>>>        sending lock request since it assumes it has full control
>>>        of the file with the lease.
>>>
>>>      . NFSv4 client sends OPEN to server, server replies OK with
>>>        delagation is none. NFSv4 client sends LOCK request, since
>>>        no lock was created in the kernel for the SMB client, the
>>>        lock was granted to the NFSv4 client.
>>>
>>>       NOTE: I think the SMB server should send lease break
>>>       notification to the SMB client, wait for the lease break
>>>       acknowledgment from SMB client before replying to the
>>>       OPEN of the NFSv4 client. This will force the SMB client
>>>       to send the lock request to the server.
>>>
>>>      . both NFSv4 and SMB client now think they have locked the file.
>>>
>>> Your thought?
>>>
>>> Thanks,
>>>
>>> -Dai
