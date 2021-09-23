Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7EA416827
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 00:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbhIWWlc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 18:41:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30192 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243435AbhIWWlc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 18:41:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NLZ0AP024819;
        Thu, 23 Sep 2021 22:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LHhP152PdivEa6r1XZBIdsZggSX4Xzte4fOwsxUrcro=;
 b=oUBfsODAkReHD91bbkjmW3sR8CFHufG8f/dkWlI69gaz9hZ6Uk5pCBt0aYRNHfBmdB/z
 ZRFcd8ojdeJR4TvvlS3wfwb5ao099gCuzVNkxHSNwFA+eUy6s7tvZ94GvV/MqV1A6Mse
 ucNNUGPnjNZN2aDo95jLPYRuA3pOWzArzxRcvClnsFGoha+3GK+GdemcGEVnXQr0BqSu
 2xVB5v7p8qCPrMAW3gchH/wCkO7g3WovTXRlNqEYBtz3amVnwUQ13gX+zNCagYvRCt9P
 hTNulgAuouUecLwTKhpwa2JWdl+rTMaJabpEpC63HusLxuKFBy/TjyTJSQeWPrQ6F6/j iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b91mfg93g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 22:39:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NMUqJe144593;
        Thu, 23 Sep 2021 22:39:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3b91msst99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 22:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW5q6RqdhUOQwxzYFiL7wmt1Zu9ZD75t91Es6xe7tE4ZbPDSzCqm3a5Qn93SInCs1aL2Iz59Fjhfwaqiv8RE2KEx7R7SFOEHj2TceYudsIwjVZwK3Vu14xPLUClPUO0eMpd//z0YtJwNS+O5V+ukGB0ob7C9ORZPIVZbsgwRUnI0E4CdSj2/E4uHiMmwX6mLrMPhXXObEeCyURIUgOMCa4UXFh2AEk83hh+Z3EbkkOQ8dfXkt8wEtVpGbO8G5HhhVcbqm4uDK08nL1QeRp7yf3eTQ6FSV30Fn/aZUUBYx34JcrNjm7Ejr0v2wLDg9NiHIqnSp5ROQv/lssrOtlsBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LHhP152PdivEa6r1XZBIdsZggSX4Xzte4fOwsxUrcro=;
 b=MA6ZxMAvQMYaI2hrvGP44YQRPDLbaOrzop1+O/PPZZcfGwuyNwf1WKXW87wzWYcxztRD/2wnQ1FxDTTUpy2pSHCbmGZ8CwZPhx+NK88yYd5HSzrogMD0sB93PaygmpNWXehJm5Q/kyFvJOTX5Va2kbXfHpLVHd5Joyk6jxxlrRsKjqOBpRXRKqSdx2/M6Zrkkt4GOMAsLpnQvMl/sGDm90tBzmKIqhRUa8Swtix5+dcXN975XrFE5IU0/vvGsp7qEVd2M2SIaFgxSuYUOFw6Abg4WWlTE6bxrCVcuJ0m7P7xgwafXRxRJ9oBTK1AxodNGAgeVvvR+Uj7U4iJdvsZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHhP152PdivEa6r1XZBIdsZggSX4Xzte4fOwsxUrcro=;
 b=u1R4I1+3gaGnOiMwj0FvKTyFddSFN5+qCaaHThkOqM1Dqel4QHPPOT1BLHHmsi1QWQFQz9S3kh6jvRFhgm5akzJr/faBZ3IKGh2FbjT9nm+iTvWNXVdy3Hh8apB+DjKnJdxQ9uoe6/4gY+cHfoAiSn6wLA7SC/HeZVSHVS8QqyM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3510.namprd10.prod.outlook.com (2603:10b6:a03:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 23 Sep
 2021 22:39:55 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 22:39:55 +0000
Subject: Re: Locking issue between NFSv4 and SMB client
To:     Bruce Fields <bfields@fieldses.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
Date:   Thu, 23 Sep 2021 15:39:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210923215056.GH18334@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:806:6f::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-131-192.vpn.oracle.com (138.3.200.0) by SA0PR12CA0023.namprd12.prod.outlook.com (2603:10b6:806:6f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 22:39:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 290ccd35-cfac-48fd-d716-08d97ee310bc
X-MS-TrafficTypeDiagnostic: BYAPR10MB3510:
X-Microsoft-Antispam-PRVS: <BYAPR10MB351023FC0D723466B8B05AF687A39@BYAPR10MB3510.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9Qgd/XbHnNMvahzzt3nCKMHKJu6Ev4MuqPizdYu/niNUEFK8DqHswnhwGna1M0G8ujL9g5ZwN0+IFL4dV+cLLGEnIRrHRH/qoHW41VhBOtDhNGZydsNoYcp7qIwf97bEnp4/gFQZrtkpSBy66Yf8zrpjE5R7zFDQvLvb/59zA5teShIwj92DCoiKvQr8PGGpHJ4CCfGO1dt5JDh81XfumhCtUXjcJq7GCGFY0UCIovVg9x8Ua0QTQAwQV4y6vThrx4+AQ4yV3HbL0IO6bszR/Ob8hMoiAOEf7MkvA50/GwEhij3/fa4bk4ho6JIVnn1bwQWDlfOq0v5uYjtLSj8xaRoA+s6miDJ9HcPPQO8C8S7HoJZoedrgQOwAuvDmHUVZ+JnWOOzcDMSuROOxf23JhhTIZ6C13v5ELIBOuTS7pw1D2q1utoh79NfuCr/GH4jR+E4puJPiLgWfMq/Z/Jm+VcrUJel+G4eXdS9SoslbTsLzMGKkkaZk+Kl88ONrmiGZO+67g5Bxta9ttrzr/VH1mvE7r8lxPYIFgiu2jPF6i4AXY9ZcsUhi44Q3JYg5BigQjNrNMZFkL0JnIsByUpIOeiNtrF499q0aurXmMgc4VM+N1bZiBMhCgVXCGuiplJ12m58LmR7NuKHIsOWLyERJE1sDaBb+hNUIZtkrIoTDMAfXkvOj6CfDW9k4UNn1bXVg/e3k8QDLJk4IFqIFgUtPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(53546011)(66946007)(4326008)(8936002)(38100700002)(66476007)(66556008)(6916009)(7696005)(31696002)(86362001)(508600001)(956004)(186003)(2906002)(54906003)(26005)(8676002)(2616005)(6486002)(316002)(9686003)(36756003)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1R1VFdhMnlaOXlnTHptVStlYjNrRGJ6dFZnUVVyTms0bWMwaWhrREtxdTZK?=
 =?utf-8?B?ZG5WcXlVVFNHcTlIYkxTOW9xU3hUc0hLaVhDYlVWMmdkS0dzU3FEc1lvNFZ6?=
 =?utf-8?B?MDFNM3FzRjRSR3hPZHc0WXlyR0VQSE5jTHI3empHRXljd3p6YVM5czRqemFO?=
 =?utf-8?B?OExFcDNVSGdNN0liYklZWms4NnBxQ0NPeHBjeXh5RFcxT2FVbFltZ1BuR2F3?=
 =?utf-8?B?TFNjRVhDTThUaXE5c1phSnJpbzd5ZnVZV0tGaUU3ZEtrallnV2pkVjlBalB3?=
 =?utf-8?B?QTFCcm0wYXdWR2tMQVA3VEd2NitnWmQxZGRWS29vbVRtQTVYck5mL1FOdlc3?=
 =?utf-8?B?NEFyK1hPb1MrdWVmUStQMlQrOUVwcTI0c0dJTDV1c1BxVHhzSXJvQklwRkJo?=
 =?utf-8?B?dTRzMEFqRWxudjhTeFE5OENBbCtzOFJDbDdYaHdiQjljdEw3VTdMWXh3S0Ez?=
 =?utf-8?B?OGcyR0NxNkJrd2Q2Q1Bwai9hQUYxYjg0aTBNNWhnazVRMisydVN0Q0NFakt5?=
 =?utf-8?B?cmMzTlczVkRoS1MxN0IwYUtZUTBTbEhydzdPcEU1aENRZVNWSlphbmpjcTVm?=
 =?utf-8?B?R2lXUjRCUTNmazlDajdLWXliVEQrcVU5ZWx1SGcycGx0Yjl5d2sxaENkQnpY?=
 =?utf-8?B?QytRNkwybEdwZ0t4VXpUeFgrWFdUNVl1d2E4Yi9yQndGQUhvTzhJU05OZ2VH?=
 =?utf-8?B?U1dMU0ZBQ3hvWTcyQ1VGcEh6Mjk0S2VPaW5nbG55a0NWT0swdjdqeUpZM0tn?=
 =?utf-8?B?MFRWcUdLOS96N2JmVGs5N2FFSlMxanEyN3g5NWhVZHdyY3JyclluYnZ6OEN3?=
 =?utf-8?B?R0FhM2ZGZGJKUEREdzJkZDA2ZkVkTUZuNHpRL3pURTUvamVRdm4xUzRiVlRK?=
 =?utf-8?B?YjBjZ2VnUFBRTGlJNHArVHVEd0plbnFKa2E2cXBOZnBQcjlmdExkQjhlZ0JO?=
 =?utf-8?B?blI3TElDZnI0OGlCMTBSbzNFeU1jZ0pHQmNSVms4Z1FxcFBHWGJEb0haSVdh?=
 =?utf-8?B?a1BINjlqS1ZsOEE0RGlTbzh0T0VNd1o5eGdFSTQ4eDMvczhBMzNqenRKV2Jk?=
 =?utf-8?B?VXJSem1ja2l2RENmWG9XTlBUdXQ0OEJSekNEYnFJRGk3Ri9VRUY5dmU5MVlm?=
 =?utf-8?B?amh0UVlDOW1BcEJKUlBYc05Kd2c4V21QWlNsUGZKc3IxSDQ4Q0FpNWRUVTIz?=
 =?utf-8?B?dEpCVmNSdXdIbnZuSDlud0VUb0k0WmxQZzl6a0FIamJPMlVFOVg1NVlsM0dk?=
 =?utf-8?B?aXoreWt5V0VsM1FONEMzcXV1blg1aUNRcW9rMGR6RVl0Rm5iSkF1ZDlIYnZ4?=
 =?utf-8?B?ZkNXZ242d3A5Y0thbmJ2TGxSSHo5K0tVbEsrNTNUbUJNeXFFVit0UndKU1Nl?=
 =?utf-8?B?WFIwYXZSVmx1WWdrMXVpYk9LbEpKazJuSXd4MmxYczV2emVJQVBnU2lqNzV6?=
 =?utf-8?B?djFtWUg1VkFOMG5jRS9Cb1VWeHE0OU05azB3QThpbHVCc3hSZHpGN1ZEa3Nm?=
 =?utf-8?B?dUhZLzhUODhzVjg4VXNBRTNIREY0eUg4RjVTdDFMeHpURjhBSEdJQzVVc1VS?=
 =?utf-8?B?WklqZSt6VVNuNjQ5UndGNXVpanY2NnRqbDFmMnZTaW1yZk9Kby96ekVEc245?=
 =?utf-8?B?NW5Ib093cTRsbk4xOExFcjZIcEV4WnJNR2g1M24waVhVei8rL0pjVUg3UWts?=
 =?utf-8?B?a1owQzZ3bTg3ZEVpSW9OTGJQS3JmK0hmQlA0V0lHNTJVaDZJekFhMHVNRUZ0?=
 =?utf-8?Q?Xf026nW5IoYoKYbfVds9TeMSoIM8ohfRvWZ5Pun?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290ccd35-cfac-48fd-d716-08d97ee310bc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 22:39:55.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR8bOkYe7uuL2+j+m23MUfp2C+XMXT1xAhmR8GPvR95W+21Zv6kYfy+cIkbzX5URGb+xS0mmRRCQybxcGhPVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3510
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230000 definitions=main-2109230131
X-Proofpoint-ORIG-GUID: EUskdep-Qyk9YGrxz93BsCIzZI9d2VmK
X-Proofpoint-GUID: EUskdep-Qyk9YGrxz93BsCIzZI9d2VmK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/23/21 2:50 PM, Bruce Fields wrote:
> On Thu, Jul 15, 2021 at 04:45:22PM -0700, dai.ngo@oracle.com wrote:
>> Hi Bruce,
> Oops, sorry for neglecting this.
>
>> I'm doing some locking testing between NFSv4 and SMB client and
>> think there are some issues on the server that allows both clients
>> to lock the same file at the same time.
> It's not too surprising to me that getting consistent locks between the
> two would be hard.
>
> Did you get any review from a Samba expert?  I seem to recall it having
> a lot of options, and I wonder if it's configured correctly for this
> case.

No, I have not heard from any Samba expert.

>
> It sounds like Samba may be giving out oplocks without getting a lease
> from the kernel.

I will have to circle back to this when we're done with the 1st
phase of courteous server.

-Dai

>
> --b.
>
>> Here is what I did:
>>
>> NOTE: lck is a simple program that use lockf(3) to lock a file from
>> offset 0 to the length specified by '-l'.
>>
>> On NFSv4 client
>> ---------------
>>
>> [root@nfsvmd07 ~]# nfsstat -m
>> /tmp/mnt from nfsvmf24:/root/smb_share
>> Flags:	rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,
>>         proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.80.62.47,
>>         local_lock=none,addr=10.80.111.94
>> [root@nfsvmd07 ~]#
>>
>>
>> [root@nfsvmd07 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
>> Lck/file: 1, Maxlocks: 10000000
>> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing F_LOCK..
>> LOCKED...
>>
>> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
>>
>> [NFS client successfully locks the file]
>>
>> On SMB client
>> -------------
>>
>> [root@nfsvme24 ~]# mount |grep cifs
>> //nfsvmf24/smb_share on /tmp/mnt type cifs (rw,relatime,vers=3.1.1,cache=strict,username=root,uid=0,noforceuid,gid=0,noforcegid,addr=10.80.111.94,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)
>> [root@nfsvme24 ~]#
>>
>> [root@nfsvme24 ~]# smbclient -L nfsvmf24
>> Enter SAMBA\root's password:
>>
>> 	Sharename       Type      Comment
>> 	---------       ----      -------
>> 	print$          Disk      Printer Drivers
>> 	smb_share       Disk      Test Samba Share       <<===== share to mount
>> 	IPC$            IPC       IPC Service (Samba 4.10.16)
>> 	root            Disk      Home Directories
>> Reconnecting with SMB1 for workgroup listing.
>>
>> 	Server               Comment
>> 	---------            -------
>>
>> 	Workgroup            Master
>> 	---------            -------
>> [root@nfsvme24 ~]#
>>
>> [root@nfsvme24 ~]# ./lck -p /tmp/mnt/messages -W -l 100000000
>> Lck/file: 1, Maxlocks: 10000000
>> Locking[/tmp/mnt/messages] Offset[0] Len[100000000] N[0]...doing F_LOCK..
>> LOCKED...
>>
>> Locks[1] files[1] took[2.000s] sleep waiting...Hit Control-C to stop
>>
>> [SMB client successfully locks the file]
>>
>> The same issue happens when either client locks the file first.
>> I think this is what has happened:
>>
>> 1. NFSv4 client opens and locks the file first
>>
>>      . NFSv4 client send OPEN and LOCK to server, server replies
>>        OK on both requests.
>>
>>      . SMB client sends create request with Oplock==Lease for
>>        the same file.
>>
>>      . server holds off on replying to SMB client's create request,
>>        recalls delegation from NFSv4 client, waits for NFSv4 client
>>        to return the delegation then replies success to SMB client's
>>        create request with lease granted (Oplock==Lease).
>>
>>        NOTE: I think SMB server should replies the create request
>>        with Oplock==None to force the SMB client to sends the
>>        lock request.
>>
>>      . Once SMB client receives the reply of the create with
>>        'Oplock==Lease', it assumes it has full control of the file
>>        therefor it does not need to send the lock request.
>>
>>      . both NFSv4 and SMB client now think they have locked the file.
>>
>> pcap:  nfs_lock_smb_lock.pcap
>>
>> 2. SMB client creates the file with 'Oplock==Lease' first
>>
>>      . SMB sends create request with 'Oplock==Lease' to server,
>>        server replies OK with 'Oplock==Lease'. SMB client skips
>>        sending lock request since it assumes it has full control
>>        of the file with the lease.
>>
>>      . NFSv4 client sends OPEN to server, server replies OK with
>>        delagation is none. NFSv4 client sends LOCK request, since
>>        no lock was created in the kernel for the SMB client, the
>>        lock was granted to the NFSv4 client.
>>
>>       NOTE: I think the SMB server should send lease break
>>       notification to the SMB client, wait for the lease break
>>       acknowledgment from SMB client before replying to the
>>       OPEN of the NFSv4 client. This will force the SMB client
>>       to send the lock request to the server.
>>
>>      . both NFSv4 and SMB client now think they have locked the file.
>>
>> Your thought?
>>
>> Thanks,
>>
>> -Dai
