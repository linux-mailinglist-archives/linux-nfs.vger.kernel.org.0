Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D760B39BD5B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDQjA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Jun 2021 12:39:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDQjA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Jun 2021 12:39:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154GY7d9087861;
        Fri, 4 Jun 2021 16:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mRBMDNjcOFTojCNf+7rgYAIXu6ZVRxxHjWizhbeVqUY=;
 b=x+7+kwD/jqGfBCOC56ob8Wwv10ywviptfvQ1rUrkwkVN5n7xYJWfydcHv4EUC5N4oLIw
 H7x1yDtwOyD8YpMUm6WvwFjJUq6eueIdRWgApiWxfvu88LlBq3T0kHLNQGCyPw2mHtVp
 yLzu56b5rGmhbfNNogZQ50PpSsUQ6ZmLdbi1PIWDQo6NDTLOA6/64hWZJVsMF4cZrRtM
 wr5cBaOkP0Hts89GDDrjzcXvHOW0FiAHXgd3QGD1ekAlVK2phGRY38Vz4EYUUpNqTihU
 CtvpDAwS6wPhgHNf30rroEcW9bMFgtfUJyfbvVJpEkE5dXbddZQtLxzvAu6yz/7wHRgU 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38ud1spd5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 16:37:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154GZcMk088677;
        Fri, 4 Jun 2021 16:37:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 38xyn42wr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 16:37:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFSisaHt4i/6Le3CPzdBS+a0n8lmSiMcweI9QnOl+Ku9JJU8fp6QKNwO7/LEGhe2Rw2x4rjRWINtAauvT2Y7ORJbmFAJ3tyU0gg+SddwqiOWXR/H1jq8+lfWg69ff62jlzQS1NY6iLMXZ1RamqhnuH3XIYthZhWXnmL4PB7J29KUo3gR6rc3HOyRKjvdhezZmy40V2n89Uk613zUEStjfZb509XNxb7VoADx16zMkC0bmY4K803Hv8AxYsZFTCKK/WBgG/liZN2jX6njQbHymHw3C1tBgNI5UGnvm/ghVbhnkSuINlzalI8f6G99qHT3x9J8osoS/A37I67pgEV9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRBMDNjcOFTojCNf+7rgYAIXu6ZVRxxHjWizhbeVqUY=;
 b=ksYiM191trCqQ8XbiqKOsQviT1ev1WwznuZURD8s3tt44nKElH/joJdG0gxIYfuVxTKJLaTeY+HJmIwjmxhky8dlZzUtbeQrNn+OoOwvfudimeDZyByxnIoDW1uUlm7/lxh3D9GcdTZMf97aiDdOnS7YK2yYmviF4qKhpzF2OZapxqV1PtKqKq6nk7DraTWtreBeDk0kwG3ut5W0FLLBMlOKlUdpjoL5bJk/i3HCTyDtnv2Qb9qy6M/+3l3Dp0jhxckbIbARn2xw1VM6zl/ch+RoV5+QOC1oKg9/lXgtb3Use66zZA4DuK91VDaOjHnZ8VHYYVwez5ZXl7SxTqaotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRBMDNjcOFTojCNf+7rgYAIXu6ZVRxxHjWizhbeVqUY=;
 b=gYmB16HmgstI7vIuo2oZT9gPr9inwcAi87Cyvr3/M9ja9J08rQUt3Qy46wscTSsdVNh0aXG/oawzch8B77wMry7uK4Howreto53U+oa2aHjcV+1MQy3p+sMs0z2LXlXHvIG1b5RapWtjWQvqh/h/aiQM7GCCz+A87WhIk2jAkxU=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3272.namprd10.prod.outlook.com (2603:10b6:a03:157::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 16:36:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 16:36:59 +0000
Subject: Re: [PATCH -next v2] NFSD: Fix error return code in
 nfsd4_interssc_connect()
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210604101237.1661615-1-weiyongjun1@huawei.com>
 <20210604144019.GC24620@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <0b183ae2-29d7-06f3-d1aa-02b8ec698141@oracle.com>
Date:   Fri, 4 Jun 2021 09:36:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210604144019.GC24620@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-244-59.vpn.oracle.com (72.219.112.78) by SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Fri, 4 Jun 2021 16:36:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d223429-84e8-4acb-1fc7-08d92776f942
X-MS-TrafficTypeDiagnostic: BYAPR10MB3272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3272C7981C8D2CD725D20E19873B9@BYAPR10MB3272.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urs3DtEWJHLnAqBsGBRDSwj3zgFRo/5nR1uxVw32A8DHcVXecucM3gOi3zCWRTwOPn0zluWQjRWJb623Gc+u+aZaV5Nk7TlfTRJKTTpzO8KaDDP5WHqRmNS0PCaR+oXXLrOv4pfyv6Zd8DPx7U29VzeUJvtLpT9ZBtvTWuSwQcY/X3zlaUNEKgsFK3wDVNKBF0ACG0EMaFtS+hkoaZg6qTPTkP3Qr6r6ZDPHyumwPM9r/9KYd+WqPAU++y2S2+f7OHUVU7JqFYpeUosLS5EKd9f0s30+Dzh0bKP1DbbgFxz0rEYl+P2w3x9UTL5lUHsooWU++Zs4X1V4yg5JyE+OD9Fpqgqm2Wyuj8lr84EujvvzCntFdxAmjmO/gE3qlpBpFMXxc0N5fbu61g66YPnk5TyBpjw5ufJ9/I//YcQNwGNt8IQ3BrDYOPrmuq8v8NnnDWt530/YFDpQvMaKpM2JSnvJF4L54EoAfCkN9q0qFQcsVhPJSwjP3YOEA5dNlhbYDaYDlHHArVBBt1ZndKLmtfPiOBebIvgYOoGPO1/JcXSxpnwPu+8/R2gOnP9B3tXu08TqSQkFDh9ITFpQkikjQGgRaWDSw0jhAIaIwoLBIXsGK5hAmUox3SeYhp1akIZ0VlMcbvBVCTqwHrf/h7HD7TeSBP2B9lukbYhoEQycEZL0iZugW+im4kkbXkE10DJpEq4sgrLvb7pjP/lw2FtztDrvb1vpZ6lYmOFGaPntP84HwsnCEigxUSCatc3/Q0M43eYIbTyMpA8OX6RuynWh7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(6486002)(86362001)(7696005)(9686003)(54906003)(2616005)(956004)(110136005)(316002)(186003)(16526019)(4326008)(36756003)(38100700002)(31696002)(53546011)(8676002)(5660300002)(8936002)(478600001)(66476007)(26005)(2906002)(966005)(66556008)(31686004)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dHV2VkhNT2U0a1VxZzQ0dzJTalZMZ0U5TGl5dDdDVnJTY0RRMWdQam9mZW03?=
 =?utf-8?B?eTZ3R0N1aGtWc29DTHlYWlFORkE4LzBSUUdBTDRYVzlMb1Q3QnF5TWZnem9p?=
 =?utf-8?B?Z3hOcGlERDlHT2NXZGEvc3BBNDduTXQrUlFFZWdsSnZxOFE5TDdhRW8vR2xq?=
 =?utf-8?B?QTR3MDVDRnR3djM5ZnEyWXdZaHJIWjduTCtPY2ordlYza3R4aVRsOTJJak9D?=
 =?utf-8?B?M1k0WVZCTmphM0c0dVF4Y2FiZkZjbTBEc0xXVGdVcG85V0RqV2U5anFkU1Fl?=
 =?utf-8?B?S0t1ZWRCL0Z6ZDRwWXJRL3Y1dE1heWk5dUlaeEg0V0paUCtRNXBHclBiazQ0?=
 =?utf-8?B?MDJiamFzcHdaTjFwakc2eThJclRkZVRDM1ZMaW0yN3o5bkdidlVsbmdQanVr?=
 =?utf-8?B?eXhGMlFjdGwzNjIySUdmcmpmQkxoYXlXVXRSMGNyc2t2T0twMHB4aUxlekNR?=
 =?utf-8?B?UENJZG1IdUprUEhuWk9UWitCZWJYZnJET1M4Wjc2WGxMQkc1ZW1MYStXVGNp?=
 =?utf-8?B?amJIeCtBdEs5RkRXam9DZDNjOXZkd05LMXBnSVQ5QWcvMHpGdTFNOVFCU0lh?=
 =?utf-8?B?dWZYYjIvSXpwY3lrSWorcElabnNaVE9uaWFRdlVIcUo3amhQN0xCMEJpWmJw?=
 =?utf-8?B?d05SUzJ6eStVRDBjRTBHNHRxZitXd0xCV1BURTFtREN1YmhVbVhiQTJRbXBp?=
 =?utf-8?B?VjNpUk9jd3RmREVtRWcvcWtOelIydWhqR1c4M0VlM2Z6dHNxblVrTWxJcDZC?=
 =?utf-8?B?T0RIUElFcXJnR2VydzVyNmVwVFlXb2ZOWlNvamwrODFXZmdRT2czQmZ4Sngw?=
 =?utf-8?B?dFFRbG44RkFuR2pubjZVOWZ5UW1YbUV1UlZTalBLS3dBUlQxd0xrbVlJYWZh?=
 =?utf-8?B?NTBVZ0R5UkVEWmpwQXlNSFdOWDB3WExUbjNRY3ZkQWJ0ZHZram1Sb1VUa0VF?=
 =?utf-8?B?ekJBbmU3NXlWelE4anNjZ09EZTE4aDl3OHc0R1VpMmg2OEo2dEtQWGJ3bWlZ?=
 =?utf-8?B?cUxlSVovamxXU1B2WVUvRVZ1bWQxUzNxUkIxeXR5SFhYZVJSMCs4ejNqcFB4?=
 =?utf-8?B?MmhHcUYxaEFFSnlrdUZKMmwzaEJaYVNsWGdZalRIeTFyY2NSQjZJbzNpckR2?=
 =?utf-8?B?Z2pPOUpEUjZGK3BkcDRob3FmSlcwbFp5b2ZCdE1IempneU5sQzdVdmg5Z3Fn?=
 =?utf-8?B?UXdxdzJ1OUNmTkYzbFJtZDJNNy9weWQ2MGROTW50Z2RyY3IrVXhqYWRreFBD?=
 =?utf-8?B?UlpzVWV6aGI0aWpmWmVsWEtZQ1RScCtZK2swa2FVMmh3alhaaFJvRjZTVUlV?=
 =?utf-8?B?VUppa2MzaEkrY3lsWGdRRXZFQ1ZWb0kyaUMzUStraTJZb0lrTzNMRXhSTWdV?=
 =?utf-8?B?SVVmeHNCcXJWR1JrMEFGcW5IMEVzNWtNWDVNdlVRWFlDdnFIdUozL2pCR3Iy?=
 =?utf-8?B?bHZGb2x6K0QvQTVXSlhTV0VpelVxNWU0MzcrK0dlckIxN2svaSszM205SDRM?=
 =?utf-8?B?dDVPSmhNcGZqU1BsSnFaTmp1SmZrSTl5SzRvc1k3MkphdG50RW5lWks5SDNk?=
 =?utf-8?B?Uzhqbmx2ajVYUDFPTlEvSFZrYjN3ZVR0YW9lSFVQWnJPNXJsemJtQW42K0Q3?=
 =?utf-8?B?MzRYTWNTaEdSbGYxMlI5c01tVW81UlVxOGNuU2U3YjVlbnVRaWk3YkUzR2NC?=
 =?utf-8?B?UGtxeTZmV3VEaElDL28zTk1KRWNlS3NpSmZ2K0RvVjR0UTRvVmlKQmcvZit4?=
 =?utf-8?Q?1GvIXkwUtybkwOFUr7oAuqXeBhxGWAj91QITQ+T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d223429-84e8-4acb-1fc7-08d92776f942
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 16:36:59.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeQuG2B8w1370rKheazuQhip69ibQMz/bvF0L/aRCyAWF9j1Shu/kmaJqGvhJnGOi155va59a7LgO9W/ydddAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3272
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040119
X-Proofpoint-ORIG-GUID: d5g6EBXlFY14OeVSX-lp3GUskPM50T_6
X-Proofpoint-GUID: d5g6EBXlFY14OeVSX-lp3GUskPM50T_6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/4/21 7:40 AM, J. Bruce Fields wrote:
> On Fri, Jun 04, 2021 at 10:12:37AM +0000, Wei Yongjun wrote:
>> 'status' has been overwritten to 0 after nfsd4_ssc_setup_dul(), this
>> cause 0 will be return in vfs_kern_mount() error case. Fix to return
>> nfserr_nodev in this error.
> Why is that the right error?

That was the original error before it was overwritten by
nfsd4_ssc_setup_dul. However, it actually does not matter which
error nfsd4_interssc_connect returns to caller since nfsd4_copy
maps all errors to nfserr_offload_denied before returning it
to the client.

-Dai

> I don't see it mentioned among the errors
> COPY can return:
>
> 	https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc7862*page-50__;Iw!!GqivPVa7Brio!NSHjr5li4vkJl0VAWWz2mrW2wiVn9wcJfK7ZJON3bmM8REVUqI82bS4FFQdajQ$
>
> It might be reasonable to just map the error returned by vfs_kern_mount
> to an nfs error, I don't know--we'd need to think about the different
> errors vfs_kern_mount might return.
>
> OFFLOAD_DENIED seems safe as it should cause a fallback to a normal
> copy.
>
> Same goes for the other spot here where we return nodev.
>
> --b.
>
>> Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>> v1 -> v2: change to return nfserr_nodev
>> ---
>>   fs/nfsd/nfs4proc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 0bd71c6da81d..b082cbde3e07 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1323,6 +1323,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>   	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>>   	module_put(type->owner);
>>   	if (IS_ERR(ss_mnt)) {
>> +		status = nfserr_nodev;
>>   		if (work)
>>   			nfsd4_ssc_cancel_dul_work(nn, work);
>>   		goto out_free_devname;
