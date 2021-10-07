Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA524259A5
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbhJGRkr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 13:40:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63616 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242882AbhJGRkq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 13:40:46 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197H5OXv014727;
        Thu, 7 Oct 2021 17:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BWBK7N3A5WDvr2dscxe5QFs4Pza/dI9qDXZfWuf1NWk=;
 b=vvzbCacXx2wTIXRjjlKE/Qgk4nuOnf+AaI6DbskS4zvYDsSOXwrR2IHXXbjZ8JnexjkN
 6QmpFSd8lpXX3Sh8dfglJMjJqTBIDNBe0alstHxGoT+4xTtR1Lx0Dx0x+gFyDzPSpbJ+
 1ujzZlxgRyuZtO1lJNjwA+eTTrh1QKEP/qBEMchzaITG/4LWqryg2K8yK9KZaiKBuZ+u
 gglLj7HZlt5tnRFFs7kNSSEbImYZYjoSEPjYlpAwlzvy1ROi5hL1zzRebi4VqvVBwDkU
 Mqmfl+M8PIYXv/Esk9Q5wbnFldi+OwijnAmldGjtQzWHtxLjmeFfnMaA9uikf3u8rikq bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj02jjj35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 17:38:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197HURZT156757;
        Thu, 7 Oct 2021 17:38:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 3bev91b270-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 17:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOmgyYA/DHg7EGbX+gC634AQ0lHYIfxUi8zyc1xNla8DWICC7/I6+Rwq25wOIED+DRffwKv8ijRGcZx400tvupn7PoHgJAJgWxZ7CLNLBar12zCbDJf2RdBTBq3OqjHh+ic+EH5y+XAwi3B7f45jpEq9c4ZfF5C92PoO1HeinX8jG4rTJU11gpJL/Ti8lc0fVCIJRwiUJyYZFY0Lj/1k0eIej10onij+5t26FPHOnFvg0ceSoj0R1ZmG5QNxziUiMq6A6V82wmIL16UHLaPtOAeHYr/8stqNR7vHfyZsJCMqqpPVFTzn4jsO+TCJOhxh3dD+wdmj+GVAyFOtrH1RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWBK7N3A5WDvr2dscxe5QFs4Pza/dI9qDXZfWuf1NWk=;
 b=A3Ju8RR7ja3jSe/Bs/JH++RTBTb9giAAEsqtu7GNJEdDsxGOC+jzEQ3JaJjAc//02CHTaHv5p/dwnp2au/iBj7ckBPtKy8O+GW1yLyOGGpmI+FkLEDncMwcXpl8ZK9jQSwWzrAxmQLomPeZQzRBCEkFMTWYenenI8YgeN3eLRTF2sVZ4bOAaEUXp5m3XeQSKf7z2gaQ1RX1SDHGAyXvm1h3tBrsrvG+esiMl7OgZsMpKbr5BoD08kGxITN1M2Aec2YqoBgfCJiu27X6OeXyOKhB6KGyu57c3/XmCJE59GKuzd/b4vfRuqlgQ8Z09eVRsZcySOhlwh2B2HwzguIlT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWBK7N3A5WDvr2dscxe5QFs4Pza/dI9qDXZfWuf1NWk=;
 b=R0tEGuGPZvsELL/3Z1KmEQ36znh7rpC0xpyc1BGPnJTqXMtQFU3464K/FhKC58CwDUr4d94C4U30XVrxUt/J4jGGTNeTajySb8L2l8H+A26y76VrIE1eguh+fGjxM1So+IeyHBjNABQsbAWs3P2X3GvU4XU/QxidyPgy1UkVSkU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 17:38:48 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%8]) with mapi id 15.20.4587.019; Thu, 7 Oct 2021
 17:38:48 +0000
Subject: Re: Locking issue between NFSv4 and SMB client
From:   dai.ngo@oracle.com
To:     Bruce Fields <bfields@fieldses.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
 <4c98a686-3be9-6f95-ea1a-8f03fbf3ea0c@oracle.com>
Message-ID: <adb4f18d-1b2a-1cf6-3209-f34cdc95d4f0@oracle.com>
Date:   Thu, 7 Oct 2021 10:38:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <4c98a686-3be9-6f95-ea1a-8f03fbf3ea0c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN1PR12CA0094.namprd12.prod.outlook.com
 (2603:10b6:802:21::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-146-236.vpn.oracle.com (138.3.200.44) by SN1PR12CA0094.namprd12.prod.outlook.com (2603:10b6:802:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 17:38:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f18caf-b388-4113-2f7d-08d989b95194
X-MS-TrafficTypeDiagnostic: BY5PR10MB4387:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43870FFB15A97672A264B6E487B19@BY5PR10MB4387.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAlYF3Isu8ckk0lfxoqM20SqOscN296UYGbMmTAFQv/4A4hFXNGAyhIXm/3DmW43i7J71Sbw/AVZ/M+yCKtpIclhUGEKd/Uovqz05sLWqlAViuFl5owAmzmb4qjl7iFdM5XoKvD2y6ysq+mTkwXohaIRdd0cOAeDNu6ZUP4pP3Ufg43XW1b6UapC71oGHhS9kD/f36yqTfokGs1lR0ksrvWDkYMWL8HazEd8jS+xp6+n6mwPKpnsUPHuGAJqibcOSfJxXSItKV7NlqJKmwFAaBoSqsb5k0zdDgDxGQEQIlig2ygOC1rpl6Lp+XTUFCfshv8kQsfXigGF4oUB6l1ryOqdx2qHRlJJPBhVJwR2Ej/gKyXNqaFh1GeLid8eiMsv3KGeq+7PUktIS5yx3NVsNSUz2nHYT2R66gcl3pcoYqYMmChcjaKlgkxlHXm6FDAmHkwV9bJDvrk8wFRhMPS8IGQl4FWBfj2qVxIZLRDqA6k0Q/1LpbIqqlI9VDyAbHrdJSDDW37fxxuqKVu3IrdGjYM0dBlSrPtqXBStizRGaGc8tZdVlbYGerwpMgZM/bf03NeBJHvSbEIMdmQO7FUSG39vcIrAfeHZ9u2Gbwt0fVs7rP+mNAU7FrwnW8QXA0jqF5bd4BH7hQIMAmwK4/MUZVz6yIwhha8GhcRSOfSeM1xwtO0SFRfmv0TvWIN/hV3af7k8OwAZaJnkC5DYwexJNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(8936002)(38100700002)(4326008)(36756003)(83380400001)(2906002)(956004)(2616005)(66556008)(5660300002)(9686003)(6486002)(66476007)(66946007)(7696005)(53546011)(54906003)(316002)(26005)(31696002)(86362001)(508600001)(6916009)(31686004)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1yVit2T2tIblQ2UnFSNTE0VlIxRG82MzlHSnVFODZvTE4vVjU1aTB6cm96?=
 =?utf-8?B?Y0E3cGUzOHlEeTc1RW85Zlh1emRMOGxuYk1sWnJJQkFIMDdPMFk0U1Ayb2V0?=
 =?utf-8?B?TTkybzlpeFEzWWF6S3VHSksrY1VXejY1d3JrRjY3WDMveCtadzZXZFZ5UVd2?=
 =?utf-8?B?S2g1S1pGcHlGczRvaFBTSzJLcFpNdzhUSENReG9OQTA4S3E3V2Z4UGFVTHRF?=
 =?utf-8?B?b2wybVQrWFl0VFI1aGtSUFg5QjFpeXpQQThNUXRsVlZpNVFxUkpCYS9LVlZj?=
 =?utf-8?B?UHAvNll0TlNPeURVbEtwaW1veEpaamQzYnNMZVdVUUlrdSs0OEdEMGtSejhN?=
 =?utf-8?B?YW5SMFZXMEMyYm9RSzh2VnpKaDd6cU1Ua0ErclpadHRHakJ4N05qclF3K2Fn?=
 =?utf-8?B?K0lnb1ZIVHNlMmZwWTlFOW1JSTVFQXhvN3hHbVVrTk15RS9MNFI0S04xYmZ5?=
 =?utf-8?B?UkhVNUFyRjUzYWhHUE5FUXFNblJZMS9oN0U3YW1mSFpneFhCbGJuVkovdFd1?=
 =?utf-8?B?S2dyYSs4NFBjd09ka0V2QmIwTUtWNzd6aDRzYnl2SHEvdWVsUUV6amRGbDlH?=
 =?utf-8?B?VElBM2lGMFdZMENia0FjZENjMUpkVGxqZEwrQm9lQkJYUlVzWFE3MXE3ZE9p?=
 =?utf-8?B?dkh4eEhmSGRpYm5xdkFoUDJoelZERURQMS93dzh0dGV6ci8vVmZtWkZGdWZa?=
 =?utf-8?B?RFFhQ3VoN01Zbmd6WWhrMnFIYnMzZUVqdjRqQ1NtL1F5NnJnZHJFNlpSdG1K?=
 =?utf-8?B?d2FuR2pzOGltd0U3eWNtYnljNmtkTnVwaVJtMmFGSzhGbEZRQ0l6UE5jM2cx?=
 =?utf-8?B?ZEVVZjdscjRQNzg5amVESGg3YWp5VG5JSDZjY0xFYjViOWRhUHZyUmxpRVl1?=
 =?utf-8?B?bDhiOUFmNFozWHk3UkMrOTd3NS9WSlNoVHJnbHhyZ1lraFQrYlJBSHhFYXpU?=
 =?utf-8?B?ZDczcWNxblI4bU1KNjhFbVEwdi9rRVZoM2J5aFAxWlN1ZFRCWlBjVll4eGVk?=
 =?utf-8?B?bGdQTldQL2dIejJrRWR6Z0FLclI3UlFGRzRIdDZnTEhVMERGdEJjVEl2TlA2?=
 =?utf-8?B?ZU0rUkc5WGExcVpmMW0xKzJ6cng0UnNkbUFpbS9OWWRLYTV6QnV5VzhZd0Uz?=
 =?utf-8?B?TnUrYnNIUWdsV084SDRjWXQvWFY3c1QzVDlqa2VwenJ2ZGNsc3psdE1YQStY?=
 =?utf-8?B?TjZNUDlreFludDRiM2lnWWFaQ1V5ZDBJRDUwWFNVVFZ0M0thc3UvNHVOTGk0?=
 =?utf-8?B?QS9uRTdxVkxhSlEybkZKR2Q2QnJnTlQrTUtOSE9CQkxGcHN0QUNvc0FQbmsr?=
 =?utf-8?B?a3dZVEcxZWtiUlBNNzlQNlNQSk1sTEhleU1xYnpQdnNHZDZIMktQKzZlTnhq?=
 =?utf-8?B?SExIWDJobkN3V1VpQlovdWNuTkdIcXQ3cUNRMjNPYnMrR0J6K1pOcmpFUVl3?=
 =?utf-8?B?QTN2ZWU2dm9TdVlsa09LTTdUSE43azdGVXp2V0pYMUJ5cVJhYUNiQ1VkNHpu?=
 =?utf-8?B?UGwwVTQ5d0JFVlhUWmFHRXVtVVFNYzlKczIxQXU3M1F3eWNQWHp5TlhxaHBD?=
 =?utf-8?B?aGJINlNjR2UyYkRQcFpyc1N6cnFQR0VFNWk3M2lZcnhRVzJ4cFlMdlVYVjc1?=
 =?utf-8?B?ZHhzZzJNQmptWWh6Njk0NllUSkF1bEFOYkN2M1hoTjFUc0E2cnkxaHA5alFQ?=
 =?utf-8?B?UldGVzVabTRERklaR2lJMU5Yc2l6VE8rcEUxcEVqZ0FrYUlVQVlnYjFkMkFy?=
 =?utf-8?Q?+WuPSq5KHnipn49lyOf6/3OVItb06bRI4kaW4iL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f18caf-b388-4113-2f7d-08d989b95194
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 17:38:48.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdIz5r0zWHWa8V+8Vlk3YpP7I1qE2fOAEOr415vqkmLdbN6uxmMnicUMmSWUScn3WROF2HhE32kj5QgkTZv3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070113
X-Proofpoint-ORIG-GUID: RqjucoQmYzRKRgeTu5EAvVm2Fn_oQbGG
X-Proofpoint-GUID: RqjucoQmYzRKRgeTu5EAvVm2Fn_oQbGG
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/7/21 10:03 AM, dai.ngo@oracle.com wrote:
>
> On 9/23/21 3:39 PM, dai.ngo@oracle.com wrote:
>>
>> On 9/23/21 2:50 PM, Bruce Fields wrote:
>>> On Thu, Jul 15, 2021 at 04:45:22PM -0700, dai.ngo@oracle.com wrote:
>>>> Hi Bruce,
>>> Oops, sorry for neglecting this.
>>>
>>>> I'm doing some locking testing between NFSv4 and SMB client and
>>>> think there are some issues on the server that allows both clients
>>>> to lock the same file at the same time.
>>> It's not too surprising to me that getting consistent locks between the
>>> two would be hard.
>>>
>>> Did you get any review from a Samba expert?  I seem to recall it having
>>> a lot of options, and I wonder if it's configured correctly for this
>>> case.
>>
>> No, I have not heard from any Samba expert.
>>
>>>
>>> It sounds like Samba may be giving out oplocks without getting a lease
>>> from the kernel.
>>
>> I will have to circle back to this when we're done with the 1st
>> phase of courteous server.
>
> I disabled oplock for the SMB share and locking between NFSv4 and SMB
> client works as expected. It appears that smbd does not set the VFS
> lease on the file after granting oplock to smb client.

Enabling kernel oplocks has the same effect, smbd does not grant oplock
to client forcing it to send lock request.

-Dai

>
> -Dai
>
>> -Dai
>>
>>>
>>> --b.
>>>
>>>> Here is what I did:
>>>>
>>>> NOTE: lck is a simple program that use lockf(3) to lock a file from
>>>> offset 0 to the length specified by '-l'.
>>>>
>>>> On NFSv4 client
>>>> ---------------
>>>>
>>>> [root@nfsvmd07 ~]# nfsstat -m
>>>> /tmp/mnt from nfsvmf24:/root/smb_share
>>>> Flags: 
>>>> rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,
>>>> proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.80.62.47,
>>>>         local_lock=none,addr=10.80.111.94
>>>> [root@nfsvmd07 ~]#
>>>>
>>>>
>>>> [root@nfsvmd07 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
>>>> Lck/file: 1, Maxlocks: 10000000
>>>> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing 
>>>> F_LOCK..
>>>> LOCKED...
>>>>
>>>> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
>>>>
>>>> [NFS client successfully locks the file]
>>>>
>>>> On SMB client
>>>> -------------
>>>>
>>>> [root@nfsvme24 ~]# mount |grep cifs
>>>> //nfsvmf24/smb_share on /tmp/mnt type cifs 
>>>> (rw,relatime,vers=3.1.1,cache=strict,username=root,uid=0,noforceuid,gid=0,noforcegid,addr=10.80.111.94,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)
>>>> [root@nfsvme24 ~]#
>>>>
>>>> [root@nfsvme24 ~]# smbclient -L nfsvmf24
>>>> Enter SAMBA\root's password:
>>>>
>>>>     Sharename       Type      Comment
>>>>     ---------       ----      -------
>>>>     print$          Disk      Printer Drivers
>>>>     smb_share       Disk      Test Samba Share <<===== share to mount
>>>>     IPC$            IPC       IPC Service (Samba 4.10.16)
>>>>     root            Disk      Home Directories
>>>> Reconnecting with SMB1 for workgroup listing.
>>>>
>>>>     Server               Comment
>>>>     ---------            -------
>>>>
>>>>     Workgroup            Master
>>>>     ---------            -------
>>>> [root@nfsvme24 ~]#
>>>>
>>>> [root@nfsvme24 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
>>>> Lck/file: 1, Maxlocks: 10000000
>>>> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing 
>>>> F_LOCK..
>>>> LOCKED...
>>>>
>>>> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
>>>>
>>>> [SMB client successfully locks the file]
>>>>
>>>> The same issue happens when either client locks the file first.
>>>> I think this is what has happened:
>>>>
>>>> 1. NFSv4 client opens and locks the file first
>>>>
>>>>      . NFSv4 client send OPEN and LOCK to server, server replies
>>>>        OK on both requests.
>>>>
>>>>      . SMB client sends create request with Oplock==Lease for
>>>>        the same file.
>>>>
>>>>      . server holds off on replying to SMB client's create request,
>>>>        recalls delegation from NFSv4 client, waits for NFSv4 client
>>>>        to return the delegation then replies success to SMB client's
>>>>        create request with lease granted (Oplock==Lease).
>>>>
>>>>        NOTE: I think SMB server should replies the create request
>>>>        with Oplock==None to force the SMB client to sends the
>>>>        lock request.
>>>>
>>>>      . Once SMB client receives the reply of the create with
>>>>        'Oplock==Lease', it assumes it has full control of the file
>>>>        therefor it does not need to send the lock request.
>>>>
>>>>      . both NFSv4 and SMB client now think they have locked the file.
>>>>
>>>> pcap:  nfs_lock_smb_lock.pcap
>>>>
>>>> 2. SMB client creates the file with 'Oplock==Lease' first
>>>>
>>>>      . SMB sends create request with 'Oplock==Lease' to server,
>>>>        server replies OK with 'Oplock==Lease'. SMB client skips
>>>>        sending lock request since it assumes it has full control
>>>>        of the file with the lease.
>>>>
>>>>      . NFSv4 client sends OPEN to server, server replies OK with
>>>>        delagation is none. NFSv4 client sends LOCK request, since
>>>>        no lock was created in the kernel for the SMB client, the
>>>>        lock was granted to the NFSv4 client.
>>>>
>>>>       NOTE: I think the SMB server should send lease break
>>>>       notification to the SMB client, wait for the lease break
>>>>       acknowledgment from SMB client before replying to the
>>>>       OPEN of the NFSv4 client. This will force the SMB client
>>>>       to send the lock request to the server.
>>>>
>>>>      . both NFSv4 and SMB client now think they have locked the file.
>>>>
>>>> Your thought?
>>>>
>>>> Thanks,
>>>>
>>>> -Dai
