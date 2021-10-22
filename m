Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB14371D1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 08:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhJVGhM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 02:37:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32574 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhJVGhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 02:37:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19M6Jxfd010002;
        Fri, 22 Oct 2021 06:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IU5grn5W9S6DrGhtyC/VUgI//aHQqYQGuboFuPjvG/w=;
 b=RpOWaiBjlapXx1UtCa6AKrK2ChN2fJRYQLDepFQ1G1AOOPdBjWuVI+AbvYQuBaiXJGl8
 yYsTXWj7rTraDrdjkWpG5WY1/tw0cPKQL4DCTC+5NTFwLk3NTYIRvTsevsYbiwtcgxUI
 T+8twrih2CcmEaZV3hbA5r2HpjHcJyZYc8ioSOUgOcq+8V+ltaTWxINVTVEtm9XXLygW
 Y+EAZxN5N/YqYbWsE8pywUMnLhHthM6+XpMhj+5es2UvfXKkGvJzvTspdjIy5mKXgjj5
 Kq0yG7CC4yaHjbn3M9nz37QIj+EQTcwAndrfLq5xqEckmDqYbfB8aKoafAaA9fFRx8K8 EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bundfggrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 06:34:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19M6Vfpq135495;
        Fri, 22 Oct 2021 06:34:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3030.oracle.com with ESMTP id 3bqkv38w2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 06:34:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwWtQQl4YdzDPlCSCMR3L59BfXM+lTVlzBLpk3dar9A8EHPIu5Vmrpd8qetnT0H94EfOx9OSYAGS1d/eAgc+iaK2mMnAxEMmibil9+kKQmMgstXmS7SsuqHcCoiIIv3YMaut1ttoU3MBJ03dLDFPoEa7YZRa6cSxPb+qTwetKQZ+FBbmAEpAESVganEbw4gILlsQinN4yihyQwQ9hWharSmHMPYpy6ZKwycqoOH82EiRLL2NsDGjc3bkQwI7iDJZBpt5wpqIWQjIFavs/+jue1CrIaSqFX/kXkXCz1nF2rF2BSYLIiZfvPn2g1V2ugJF5n3HPg/Z2tRXc9cTl+HFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU5grn5W9S6DrGhtyC/VUgI//aHQqYQGuboFuPjvG/w=;
 b=XsYOrD7yiR87/NXxUG1ZUie7h/+6hIAH50hDLbsJbEfZ0pwe07Aa73xXBTU3DlxUkzshLR4qalw6OS2pA8I/yB8ZozKcgQzTHg2eovkfNgqot601YMJiHK4FsXW2a68OxODvPPVBq6Wyw7t7/x8lq2bzf8SzsRqeJazCVSWYEZXanW+zSklK06MgQOFPFxFmrgEcwTCluRnJB3B/+9QLUpyY1VNupnRfThTNF2Z4wFxOgvkyx6RzxWjetc+Ll9Ce49Vj5/QVZpM1vNjKK45D514RZLAQqCEc9OLaIaqSf5GGSNeYKhPf7VHke7xXDg2I/rvzC+o4pWsFm51+EWU7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU5grn5W9S6DrGhtyC/VUgI//aHQqYQGuboFuPjvG/w=;
 b=wLAipIM5yG269ZabUg+OZloV5DElgVwN6HSW+YswMAwhxPvGK9jjQxbSiFVS8CnZqfofzTLNu3drIYus1YRkrW1yTvHqwY8YzkC61JxFHaQbjViGA5xvykiK0j1UwPFpXZdih7ERxnkj7jX9eYK0B+W9Iiylt6FBu/0hpEcCEQM=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3779.namprd10.prod.outlook.com (2603:10b6:a03:1b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 06:34:47 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%8]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 06:34:47 +0000
Message-ID: <78839450-8095-01ae-53e8-f0ebf941b5a5@oracle.com>
Date:   Thu, 21 Oct 2021 23:34:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: server-to-server copy by default
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
 <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
 <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
 <20211020202907.GF597@fieldses.org>
 <a009cbf3-cb83-b7c8-aa86-2eee06962b68@oracle.com>
 <20211021140243.GB25711@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211021140243.GB25711@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.227.46] (138.3.200.46) by SN6PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:805:106::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend Transport; Fri, 22 Oct 2021 06:34:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c9e5824-57a4-429a-b18a-08d995260abc
X-MS-TrafficTypeDiagnostic: BY5PR10MB3779:
X-Microsoft-Antispam-PRVS: <BY5PR10MB37792A60A97D734689D6592487809@BY5PR10MB3779.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GECmtdhJZYweMNEhWIL07acS48yswGEKzpv76ui08OAt5Hnl7Ztas+uEEYjHi1u18DymaBvH5ad/vLCja2mud9W151Mg+Fra9/n5VplCvCkZhrZ6IqyxZOrnMx7GvK8llzk5zBs0dO+5U+fXlVV/Wel8WiVtSf++50pKIKMx/6xagQ8osAmpdUSpjfRY28/g07SPqqFrhoSXqL+HZnjfK4e3l4Me0CieaKd5bGBfUzNbHC+6XotSNYgI/wFt5yAAwDNPWwEsyNX0nlLuNK0Yc1xAX+dNSkFrj4ADouRwvk6MEZjAmEjFof+UUI3G1pNaxQ4UltVw0MhkniZgEVWmKgnSNjEwcutMh1oV6Zp4XsW+7QjxaBW4ODZgaz9WbmDvEO9dUrlgYjq+VloVYLXRum7kbE4nIgtpkzJ9ix0nNZvGUiUiZSBQv33e/YovBa6Xch5sRAG3IGKqnaGKVaSgi4e+txNHyFldnLUL833cYlhzPtmVsLEYt7piCvPhN9jxnBxBs8CEGX9xcKkbuybnudd8bTyaUWaWbs3Pnk1Qm/5wpqD/CaI+4LISYaLgB1iogFYwAGSqM6vmjOboM/bJajMFSqxNtK4+l7r2ygO38czW4v4rv3rtpsmTQzXOItWEvfQs0AHWxl7mMLkb5SomK3kaiu20mDvOFy8CsKzJU5X/sY57HnFKPJV9yH9RRZiZeah1c88HmCiDU+rrWVUTlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(508600001)(86362001)(36756003)(53546011)(16576012)(83380400001)(54906003)(5660300002)(26005)(186003)(6916009)(9686003)(2906002)(31696002)(66556008)(316002)(107886003)(956004)(38100700002)(2616005)(66476007)(8676002)(4326008)(66946007)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURvcDFCMllLbXlpSDNpczU2MGpEdlVnNUdzb0VEcDl2SmFKL3BDS1RDaUJG?=
 =?utf-8?B?N2p2c1ZwWCt1ekJ2MFpoRG1XQUdwM3IyNFY3TEZzV1JoVzFyQUhIaTZWUW9V?=
 =?utf-8?B?SEZ1QitmMzB0MnFjZnBYVjhuVElEbDRaS2M2NmVkWk0rNGZKS2czaExubUtJ?=
 =?utf-8?B?VHJJOXI1NjlkR2RucDdGV0JSalk4aE8rTjAxd3BJUHZubWd0RW42QmQ3UzJt?=
 =?utf-8?B?RTlkVHV6SlphdmMxb0pVTkpoSm1SeElBSmVLUmN3V2p5V0NvN1cwUnJncVFy?=
 =?utf-8?B?MThHazVYdE5kWU54MEpTYjRKQWVmWFFuSk16VDYvL0ExakN5Vk9LZElQODV3?=
 =?utf-8?B?MVNjQVVCdzExbURoaE1iY1NiRVZTeTZjMEZnbm5TUE54d1AzTWdUdlVZMGxR?=
 =?utf-8?B?bXBnaTloQWhLV3h2TjBZOHhNdlYwdzFtOGN5enpKTlFGaC9GVkw1ZWM3UmYy?=
 =?utf-8?B?TlJwcVY4QVFURVZGSVhXOFpDMWRDa3RmMVBhMXBQTkpoQUR6QWhwMytlK3pC?=
 =?utf-8?B?RjdDRmhoZUxMeXJUYW4rU1dJVTNZdThnL0xsZkx6bWNOZ1RJcS93c0Q5eTV1?=
 =?utf-8?B?anRaMEs0Z0k4cDhpajJhNHYwRE9nV21MM01KWVVxVTBqa1R5N1BOSS9yaUJy?=
 =?utf-8?B?MWJPSHlZOEk3TmFhcHoxMkh4cjRyekE2NkduYVhuYTdHRWJWZzVOcUdCSmJz?=
 =?utf-8?B?eHMyc3g5V3lDRUU2bERhcXorTHJlL1R3aEFzekZYT3dQZUttcU1xTkZOcnNB?=
 =?utf-8?B?UmpqdmRGL2FLbXZDcUUxZTdjZEF5b1gzVDQxOThSbmFNVWFJaDNwMVo2Mnl4?=
 =?utf-8?B?eHgyTCs3SmMvWVBOeTdPOFRYeGZKWDBUUXNRK2YvWGJXcDI0Rmt5L081TTJQ?=
 =?utf-8?B?QlNJUmNZQUZsak1WQ1dUR05vSzF1eXA1S2pSeDYwQWdFRVdyTE5FNXZ3a0NV?=
 =?utf-8?B?dDE4bzQvVmhMMDJUL2gvUlBERUtLejk3Sy84NSs2R3UrblQzOGpiTmU2QXlY?=
 =?utf-8?B?ejNjaEd0NTUvMGg4Zk1Sa1VFWlptYXdRbm5PU1gzeWx6TURHNzVORzZsRzRo?=
 =?utf-8?B?bDNYRlkrbG1oVDQ5SXBaeTRwYjAyam1LZmNMNWV1QnpXNnlYM09KaG4vQ1hs?=
 =?utf-8?B?aTJvQy93T1l3aDJOb2dqSS9qZys5VTNhYnA2N1hYL2dFRkF4TW9ER2EyNXpj?=
 =?utf-8?B?Njc3WmlUdjlmZ0pnUnJydmdNdmV4bndaa0FDQmhubmY0S2E0TTU2TVpLWFJ3?=
 =?utf-8?B?SnBudWV4VWt4T2E0QTM0VENVSHo1dVlwc2M3dm1sbjNZMy9tRVRiUTVpM2ND?=
 =?utf-8?B?ZXBTNHVuMldpd3JWaUVvM1pETmEyeWVQTjJPdGtSSTBoY29IMFMxdG5odFla?=
 =?utf-8?B?R1Q5MFFwREoyOXFTUjdnVzJlSWkxZkl0M1Z2TlE1NmVaa3RJWTQ0Qkxsbmx6?=
 =?utf-8?B?clV2NDJZcEVGNCsrQVpBRFIzdExBMjlpdStQQjNzclJXd1Y3ZDFHOUI5cjMy?=
 =?utf-8?B?RVVsMXh5NHNsR0d4aTZoK3FUakRrZUh2T3ErbGFBSmkwNDlnaVJaR3ZOb09Y?=
 =?utf-8?B?cW9TUjhWZXFCWCtXY0tuYkpXTkUrN2ttQUZLaitqTGtUampNMktKbmpXLzhn?=
 =?utf-8?B?anh0SHJnSFNTSWRmb3J5eTMyRE1Wd0d6eEt4QXp1eldQRUVacGtlOHVmSVdG?=
 =?utf-8?B?anZhZmFiMTdmTDRTbTZRbStVVXFzbThhOERhNGFhaU81dHlEZE0vNG1RTUdD?=
 =?utf-8?B?WWVNeHIzdXdNa3JiU2dDaHRQUEhQcTRiejhPbXFodCt5eWl4Rm5SNzJQRFpF?=
 =?utf-8?B?cU52SFMvTllHenVDZkhXTWtQS2JJQTBJcS9KR2NtMDB2SHoydlE2NFA0OFZT?=
 =?utf-8?B?Q3pBclkvSVpCL0dWU1BMWjFEL2xYWE81TjAvYWZnS1Z1eXFkVU9GbCtuNTdI?=
 =?utf-8?Q?w4sl+Ml3PfI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9e5824-57a4-429a-b18a-08d995260abc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 06:34:47.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dai.ngo@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3779
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220033
X-Proofpoint-ORIG-GUID: 42ATlQIae3IBFTstPjhH74jzsvwfj2gn
X-Proofpoint-GUID: 42ATlQIae3IBFTstPjhH74jzsvwfj2gn
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/21/21 7:02 AM, Bruce Fields wrote:
> Thanks for the persistence:
>
> On Wed, Oct 20, 2021 at 10:00:41PM -0700, dai.ngo@oracle.com wrote:
>> The attack can come from the replies of the source server or requests
>> from the source server to the destination server via the back channel.
>> One of possible attack in the reply is BAD_STATEID which was handled
>> by the client code as mentioned by Olga.
>>
>> Here is the list of NFS requests made from the destination to the
>> source server:
>>
>>          EXCHANGE_ID
>>          CREATE_SESSION
>>          RECLAIM_COMLETE
>>          SEQUENCE
>>          PUTROOTFH
>>          PUTHF
>>          GETFH
>>          GETATTR
>>          READ/READ_PLUS
>>          DESTROY_SESSION
>>          DESTROY_CLIENTID
>>
>> Do you think we should review all replies from these requests to make
>> sure error replies do not cause problems for the destination server?
> That's the exactly the sort of analysis I was curious to see, yes.

I will go through these requests to see if is there is anything that
we need to do to ensure the destination does not react negatively
on the replies.

>
> (I doubt the PUTROOTFH, PUTFH, GETFH, and GETATTR are really necessary,
> I wonder if there's any way we could just bypass them in our case.  I
> don't know, maybe that's more trouble than it's worth.)

I'll take a look but I think we should avoid modifying the client
code if possible.

>
>> same for the back channel ops:
>>
>>          OP_CB_GETATTR
>>          OP_CB_RECALL
>>          OP_CB_LAYOUTRECALL
>>          OP_CB_NOTIFY
>>          OP_CB_PUSH_DELEG
>>          OP_CB_RECALL_ANY
>>          OP_CB_RECALLABLE_OBJ_AVAIL
>>          OP_CB_RECALL_SLOT
>>          OP_CB_SEQUENCE
>>          OP_CB_WANTS_CANCELLED
>>          OP_CB_NOTIFY_LOCK
>>          OP_CB_NOTIFY_DEVICEID
>>          OP_CB_OFFLOAD
> There shouldn't be any need for callbacks at all.  We might be able to
> get away without even setting up a backchannel.  But, yes, if the server
> tries to send one anyway, it'd be good to know we do something
> reasonable.

or do not specify the back channel when creating the session somehow.
I will report back.

-Dai

>
> --b.
