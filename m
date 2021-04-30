Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7736FF70
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Apr 2021 19:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhD3RZM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Apr 2021 13:25:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55758 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3RZL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Apr 2021 13:25:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UHK58V112837;
        Fri, 30 Apr 2021 17:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bWk5w3B/4ub7jsg4cwJ3M/X4Kpo8+9sx3/aQw+RpPAM=;
 b=UygD1IsrvxH2+excT7XPZtOPs86pWy5E+ooHF0AheYTjOv6591bD/vZWct39sMoBlns3
 K3I2wTT4iiDgFpqYz7tVSasB1MdDmLRn6qAxluyJ7LOsp8/ka6BSSZ+xdoYgJx0Ov5b1
 UwmBItBBww+kfqH4ESTr3Or/iE75e8pbpvzgYi60zmCE0eLDc/iNfZo1fKnfBoYXnTRc
 GWXSKC3lxWvUmaKuTa4EbNKTx6G9uH2le1QPcAcBmzR8gklml28FBnniaU+jo6dbaKu6
 uMtJDn8jxNf0IS9S2rZt2lDpq5kpVXo/ghvHKxbZQzkfNY4l25yMpJGKUHl+evmelA6M ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 385aeq8e3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 17:24:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UHM3vp001482;
        Fri, 30 Apr 2021 17:24:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by aserp3020.oracle.com with ESMTP id 384b5ca1d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 17:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGEvWdM8eW+Mka8MkkBhqyL0yKbZhA9BOjy6DRhaSzQroqNQa0dbCrGck+FOdRWQqaR7Rnzsp1UAUTD8eLhgtgbYEj2hA449txcaFTp8rn+uyVsH5VGCA7aeuWqfE5pD2JamhYm1lylpCS8L2cRXXA2iqBGFNLW5YUbnXwmq+O4xOw2PUJEdSHEue21FAIAroNNZN7BGfG/llnTbzxDFShd8bHtFUOT6uCdmx2y4OsTjak1xkIAPdSXXEqjngfbRSajSxAW7CtJcVHodbrq1m4gYAjzC4Zq9n30dkmMZE+LAcON7NAbW1NeGVjYLYxQYUV73P90az0fv9z5hrxJ+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWk5w3B/4ub7jsg4cwJ3M/X4Kpo8+9sx3/aQw+RpPAM=;
 b=TpP8n/VhQNFSWKXOiHTeHPm/u5NdvDG/XsPobjW+IqfQ7Cgo5BJzNv3cHl868cnOTbTdscqevPOXHgaPbNQ05yQi1AnHlKQEy8bt/tfjgLSi3tGP09vqxVyRKDQC+saURwwwpJ5UY3abLf1K38CSmMknrtr/pk4nHWkFYNHemdKselm6dG329vIlxFEv2qHKni/dlz28QN6KvvCVU/0JwzDdsZ/8vH1cadE4CsGJ8Wd/q4V4c+9c0xrseoE6tWlLWK7oGgM6O69bTXifNEUKPGsL3gWHrn3Ufzi0rsafv30ua0wTmxYSIKLoOCs5cUvu5R9tNCnQpB/he00iuMsbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWk5w3B/4ub7jsg4cwJ3M/X4Kpo8+9sx3/aQw+RpPAM=;
 b=Um4ttlOvc16nYaWpVbGJLNwM35sVCUSkm+qyGZilxs+g89vfpsQNOpyykWzSE6n2XHuNrifkpcRmE6UpI21zVq/588sFFRJqbJNl+uH9oQoVBHX2evENumzBxjVJGVYaxXwNwIv707ikXMpHnFzbc639GyakBO0xM+KMreoaTr4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 17:24:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 17:24:14 +0000
Subject: Re: [PATCH 1/1] NFSv4: can_open_cached needs to be called with
 so_lock
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210430050900.106851-1-dai.ngo@oracle.com>
 <8fadf7c12b188eacf5c2bb577a2fbf938e51ebaa.camel@hammerspace.com>
From:   dai.ngo@oracle.com
Message-ID: <6ecdca6f-85a8-87d5-a5ce-069b98533a10@oracle.com>
Date:   Fri, 30 Apr 2021 10:24:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <8fadf7c12b188eacf5c2bb577a2fbf938e51ebaa.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-138-225.vpn.oracle.com (72.219.112.78) by SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 17:24:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 812a64d3-0bba-4a9e-3892-08d90bfcc6a6
X-MS-TrafficTypeDiagnostic: BY5PR10MB4130:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4130EE6B6DECCD96DD518D4C875E9@BY5PR10MB4130.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5+llTpLcEvvCT0FlwySpIbQWp04c0YD9uJrUGJSNRxEVkmX1tIpeHmTnzMavFx6ub68Km03IKMEJx5JGACJ6Sncb8MtvQAsxbuffXSVTuFrvrS7dtOGl/GWjGIK1JtHrkmMZ4XK842vaaQhlw68qwXCTYY61xb7lGxBjCX7/lik+FUuSe/oOXInxR5cPKu498s0IuOPvwZpPhrozvfjK7/iwORHs/LZKUeuwDabqfkqvYbrJQj6XowOTENWyoD/k0hC8hWzd4SNwB5wXTfrpMLJlMgYGJBZ4fjQ37LTjlXr6K6rSU7lcjvuA8Mfoqsd6uEhWBwDzU3+8/p/zlpU5Uqyz+fEYYrWZPcToYum99wdREtCuG/Y6zD+4N7UcAHFLII/tR0TiH6Wwvr5nUBjEPKm1FvZHqUZebBktPwDu1fRUQe7GQWZhB8K58Xmwdpv1C2c/S4Z6USM7N/Wf4k4MJG1uXyvtNk13uzs4hbldQ57lGolQuAr1czulDKDZDJNNS1RU48fCO2J0svVkec57s+0ioiKjArsdDrZJVTSwhe6DVX3oES7oAn0NYitRHl5J7yxiOW5baPdVy+Lzq7zpsaS02L4midWfy0RZRBS2dSrcvra0UWclBpjkdrefA2nopyySX1i8lDLJZf7UU1JjrIqBdtOnunZsXBIspLM54g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(4326008)(478600001)(83380400001)(2616005)(53546011)(86362001)(31696002)(7696005)(5660300002)(38100700002)(956004)(31686004)(2906002)(8676002)(9686003)(186003)(316002)(6916009)(8936002)(36756003)(26005)(6666004)(6486002)(66476007)(66556008)(16526019)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjhUcW1ZZlZYNFJJZDVLUEpIejBVejFscWRqbVQ2cGltS2E0clJlMEMrb0hD?=
 =?utf-8?B?Y2RWeHplRWxiUkJEWHB3UkJNOXhUSkIxdVBaVXBtRGsrZ1o4U3dIbm1ReDN1?=
 =?utf-8?B?aWd2T3VpWDJKa2NYdFFwVUFwRzJUWVlmWnhNOGpBQkxyMG5GekhpeXlrR2xN?=
 =?utf-8?B?UTJLeUIrM1F1R2dMaFF5N0ROdHpHdWwrT29wdlRvdDVPTWhjUlpUZFdDRDJt?=
 =?utf-8?B?M1RDNDc2dWVTSUZGaHNIdS84bnFuck9WUW1YK2lvUXNVZ3JwaEtUWDBUMGV0?=
 =?utf-8?B?dnQ2eGovanJGZ01oUlQ3bnFiUzFGK1IwWlp5NmV5NmRKTTFBcDcycTlncGdv?=
 =?utf-8?B?TWZJanZTUGg0VTBKVlJrQ1FQZHE2UC9UQzVrVUI4cGgvMzZ2OFlkN1VlMmJi?=
 =?utf-8?B?aWZZdDZRKzlmdlJQRU5nY3NXNVZ6cGsrRDhmbmM1OStpSGJKSjVrNHFUcHZT?=
 =?utf-8?B?WTNHd3ZOajFnclhwS1ZmelVkS1JyVjhmekNxeUEvWUJTZkRjOWwwMFVOa3U5?=
 =?utf-8?B?RnBoSjBFTGtoYThiMi83Nk5vZCsxMjJoNGVmTytJWjgvUGQxcnlzS2tzZndI?=
 =?utf-8?B?azluTHlyM2w4ZWxSTDJkZGFZeXBzVXY2T2hPS0FvQVJYQXhwVzNWOGlFSk1X?=
 =?utf-8?B?TWQxaVVpVVhQYll5UEducy9CVG54MkdyTlNXZkZTQS9wb2t1Q3NEc0RJaUZU?=
 =?utf-8?B?eWRVOG05R2JyYng1T0QwYjFNZnBCbnNnSnlxTUpXck4yeXpoZVNrRStFdnhV?=
 =?utf-8?B?ZUltd2s3UytXRDdBK1h3SmRlbWtFR2hBUTBBVkh6cDV5WnFGVC9RWDhITElk?=
 =?utf-8?B?enpvK2QvTUl1QW9xaVZrRkV2b2xOYlp2ZlQ3STE5YXBmdFplTzNKSDhMM1d0?=
 =?utf-8?B?RUh1VlhlNU1seTJVS1NnV0tvL0NQV2RwUmlNNzJxZ1d2TnBRU3VkRG5FdUNr?=
 =?utf-8?B?WnJGWG9XQmZOS0ZMNFFveDRNeE8xRmRoQjZmcW9UL0tjMWNpd0RldXljV1lT?=
 =?utf-8?B?YjdKWEJ3Q0k3K2tHSDNJeTlNVHphdzJSMm5USWg3U1VadWU4dWRUZ2o4Zmpj?=
 =?utf-8?B?c3kyK1hQVmtXMEVTb3hPUkNFRWJCR1d6MVFaeFh4ckJNNVN3SU1mVTFqemcr?=
 =?utf-8?B?QXRHUzZkbWNMRGRqdk1oZUZVZkNjUnhKNVZVdC9IeVVpazV4N2NTZk1lYkc4?=
 =?utf-8?B?QkVrTDZRNXJHOXdHcGlzZVhTaXF0R1lUb29sT1VVZU9iQXQvVkpXVVUyVTVG?=
 =?utf-8?B?WWNscVJsWmY0TXBSZm5WbGszc0x5OEsycWhJNksyaFZKSHN3R2R4OTkzM0l6?=
 =?utf-8?B?M2tQYVBmSnlkY0JWdk5vbUh1MEovaHdkd3E1dDFlU3oxa3NzaG9MUmRNbHVj?=
 =?utf-8?B?YUR2djJQK1FYU1RpOVpSUDlpcC92YnMxVFBQUW5kQ052ZncyQWNmcEgrdXdi?=
 =?utf-8?B?OGd6RUdCa2pIRzlMS2xTWExaNHZJSDVzVXl6cXRDU04vbjBrdGJWSnBPSWxl?=
 =?utf-8?B?OXVybzBmdUJyQnNRQ3JFZkVVQjV6YThoaGJIMENaTUZMNmplWWhFTWNBYS9L?=
 =?utf-8?B?b0FnQWRFYm1RUC9ONlRPVWx1Q3lRbXNoRnlXaUJZblJUemtjNG8xMVBQNWFD?=
 =?utf-8?B?bytSb0ZseTFyb1ZkQzhOZEVMc3E5RmU2V3N0QUxqWnpQTTNzUGtSeU9oNDI3?=
 =?utf-8?B?WW9qV3lMc1JML1Vpb01MdERUQUtWZGoxaWZWR2dOaXk1T3RtQVBKejdKMG1h?=
 =?utf-8?Q?/ZcxQtDRuGefojgkqjQ8ht5QCdn5pZfr4tMPBAb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812a64d3-0bba-4a9e-3892-08d90bfcc6a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 17:24:14.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToeYskh9CepIvFUPTvnozVKy8j47B6VS1247LHQAYlmmgsTTymjcqEnyXVRJtjKrppLAhJwVGfJzpQItsv+3Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300114
X-Proofpoint-ORIG-GUID: BVbiZGdx_8qUHebkSShY6l--oaMmHQ-i
X-Proofpoint-GUID: BVbiZGdx_8qUHebkSShY6l--oaMmHQ-i
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300114
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I have a question below:

On 4/30/21 5:42 AM, Trond Myklebust wrote:
> On Fri, 2021-04-30 at 01:09 -0400, Dai Ngo wrote:
>> Currently can_open_cached accesses the openstate's flags without the
>> so_lock and also does not update the flags of the cached state. This
>> results in the openstate's flags be out of sync which can cause the
>> file to be closed prematurely.
>>
>> This patch adds the missing so_lock around the call to
>> can_open_cached
>> and also updates the openstate's flags if the cached openstate is
>> used.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfs/nfs4proc.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index c65c4b41e2c1..2464e77c51f9 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -2410,9 +2410,15 @@ static void nfs4_open_prepare(struct rpc_task
>> *task, void *calldata)
>>          if (data->state != NULL) {
>>                  struct nfs_delegation *delegation;
>>   
>> +               spin_lock(&data->state->owner->so_lock);
>>                  if (can_open_cached(data->state, data->o_arg.fmode,
>> -                                       data->o_arg.open_flags,
>> claim))
>> +                               data->o_arg.open_flags, claim)) {
>> +                       update_open_stateflags(data->state, data-
>>> o_arg.fmode);
>> +                       spin_unlock(&data->state->owner->so_lock);
>>                          goto out_no_action;
>> +               }
>> +               spin_unlock(&data->state->owner->so_lock);
>> +
>>                  rcu_read_lock();
>>                  delegation = nfs4_get_valid_delegation(data->state-
>>> inode);
>>                  if (can_open_delegated(delegation, data->o_arg.fmode,
>> claim))
> This is going to introduce stateid leaks. The actual update of the open
> state flags happens in nfs4_try_open_cached(), which is called from
> nfs4_opendata_to_nfs4_state().
>
> While we could put spinlocks around the call to can_open_cached() here,
> there is little point in doing so, since this is just a read-only
> advisory check. The real check is performed, as I said, in
> nfs4_try_open_cached().

If we wait to update the flags in _nfs4_opendata_to_nfs4_state after the
RPC thread decides to use the cached state, the file could be closed by
another thread before _nfs4_opendata_to_nfs4_state is called by another
thread. The client in this case will retry the open from nfs4_do_open and
everything is ok.

However, if we update the flags nfs4_open_prepare then it will prevent
the file from being closed and this saves one CLOSE and one OPEN rpc
request to the server.  Is this correct and is it worth it to consider
doing anything since this is a rare scenario?

Thanks,
-Dai

>
