Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1103E8734
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhHKAUh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 20:20:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21910 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235692AbhHKAUg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 20:20:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B0GStD032733;
        Wed, 11 Aug 2021 00:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8of6rr5cbA7aBmX++NzUkMKAjsM+l4GS5t7zUONTt7c=;
 b=qTSFMTrolGEhcVAaqDGQgfj5Ot4o67ER51qiptxD/aq4gZ2vnIiEeyTlIDXPNnQ92HlY
 +l4qDoVygGpNg1bCe8weLd+FITEIRkWkqli4w8/lWvKj/N8utOQXfbSUSutt6A9I+Q2N
 7GL+wHC5M3nzECC1rab3ygF+W5baefpRipNU9NmWLOJs7y9PrNbO0UthyAq3PJ8DU9MJ
 JgdyPYbgMaA6ZRoe9S0qzhZ7nTSAB00muODq7GCKcAcwvW0q7f+yr87lM2s+WiF4crQ3
 7Cn3b4Nc6yL35V2mpB8uyVzjmIKG5c1v4ZqHKHNmXAPlQAfeWErWQAvdartw9dR5Cx9o kA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8of6rr5cbA7aBmX++NzUkMKAjsM+l4GS5t7zUONTt7c=;
 b=eQTsjowji6TYXCMv7YwUJyoOPhOlroyRXTU/wJa2usJhl7KhCIUk5tCzLqlrnJWWSZDA
 Th+vizG7cKvY17CVkckga5B22HHKvtEhzeXL15zMapwzGKI4TLii2mtj9R7e/NVNkdGR
 s0nTdPaUAP5fZV0hT3zI6pCalkJNwWA6wVF/aDtAhGk4rqPNaqLJmSzLAntIU2feSatk
 SkT+WOHE5ELVlrPIQ83J7TTCzPR4dAKkS/KAHHNkcJ7xERH8GGeayuUP4BHR4qpO8hfl
 46GgF6/OqsbkExFl2cVf2BarDjgcQk+SsHlPWpxVIBsKW/V9ZTgjZcV0J0yMspji0h9e Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt449cjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 00:20:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17B0GO7K104283;
        Wed, 11 Aug 2021 00:20:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by aserp3020.oracle.com with ESMTP id 3a9vv5k30s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 00:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSb8/N7TOsZ2NMVESy0aMIQlxmV/kWDbl2DfbEawlj5BFwfDao5rYcDsykAPFOrvnp6QWdvnc0eZLACtNUpDCvUKl2bIyNqjD1txbYVejvFvPb3H1c7SMckgieDNLtC3IpAWHUDNKvI4RRXPnOeDW9kfpnLq/fyGF1ajaLTtevucvsA/Xe4OvOBDaU2sXilyHvnIgT0nxBeKEnyikKEkOnhMzaUnwgToxqhCN7G8r6z8Ys7mSTEf429xYKmQD3prW4WW2zZ4GhKPMKhqxHkU9JEzsXbOUkoulsvFB654B4irl22dwBviV3yReiZPLP6VDjwSoXTOD9f+t3yigVVf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8of6rr5cbA7aBmX++NzUkMKAjsM+l4GS5t7zUONTt7c=;
 b=d+abkZRt2DMYslx461aIpiWds+7fmZ08k+XI/T7Jdz1ne8t4pdSDU/I9V1HnmVyvTkzWGWJ6KJvLD0M4i5DRb+DAeJzKUHfi7mjOHFRr0qXIKT7Lqo/Ehae4FjJYFEPwOqjwo6coDbvmKfAcBdK7MDOC3mGbhX58rK/1HaybMDkyfD85+KSgJgKwScJH6exH1YEGMlsv8S2HX3v7aii0Lvx49VDvSoa9MNnl6PNzPIdV/cKO/dVEfpC92T9bbR11koxd5JHyWJRVPBCzLFswN6uXS82/hc4KfHlJttPVHcCoeLi/txYRwpdTOGKlN7psTKPaHc2xpS0A6jfdpBJuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8of6rr5cbA7aBmX++NzUkMKAjsM+l4GS5t7zUONTt7c=;
 b=gVJ78+ATmb6tgVTh58Av97GhdeBACvn6gYqDbeFWxkpp8oz59PRVjhDR+4TIsMLPSVHJc9vjGUNZ8Og8C/ZHdd9BajyXoOi+4AZqPXsITAoXxlOCJYu4B5AqopIHAtenUedIwKcTtCYf2Y9Izw22zyrZqAF2B++BGxZsdRd1Flc=
Authentication-Results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN8PR10MB3172.namprd10.prod.outlook.com (2603:10b6:408:cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 00:20:07 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::4c6d:c359:aba9:87e6%5]) with mapi id 15.20.4415.014; Wed, 11 Aug 2021
 00:20:07 +0000
Message-ID: <afee51cb-96ee-dbe5-4ecd-17eedb2bfc12@oracle.com>
Date:   Wed, 11 Aug 2021 01:20:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:92.0)
 Gecko/20100101 Thunderbird/92.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Language: en-GB
To:     Trond Myklebust <trondmy@hammerspace.com>
References: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
 <4c1c058e-2b52-db5f-807b-b0dd9d6cb1a8@oracle.com>
 <38bf58eb523ae26028ff1cc158ec648f2dc56e95.camel@hammerspace.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: =?UTF-8?Q?Re=3a_open=28O=5fTRUNC=29_not_updating_mtime_if_file_alre?=
 =?UTF-8?Q?ady_exists_and_size_doesn=27t_change_=e2=80=94_possible_POSIX_vio?=
 =?UTF-8?Q?lation=3f?=
In-Reply-To: <38bf58eb523ae26028ff1cc158ec648f2dc56e95.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0327.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::8) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (84.71.130.115) by LO4P123CA0327.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 00:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad106470-65c2-46b0-76a3-08d95c5dc5ea
X-MS-TrafficTypeDiagnostic: BN8PR10MB3172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB31729F954F46BBBDCBE8DC45E7F89@BN8PR10MB3172.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AICfrirnDwhvJdKjR5g36RFtqhP7QO+BGThd3PHwZEtuF8UrH5d4LlbLsX7kkSBVtmNFiPq2pyclvobWg1wKGvpvHQmkOF3jPzwAieV/bR6DfMhFV1h7rn2wxl+9qjvZcDpZysQQmFMUGtvxlkvC3MGCQHZoowyMyhb8Phh8M35lFTrJweDphkApSfNILwd0+mJpqPpxZneIxxmPuR5NTPIfXMe2E7Zbj3OkQNFs4I5IdMs0E8rca3iwlVNWkgAn7RlVDWVdygsyANpFSI+WJ9sec5TNwSAvsbwZg0ONwY0wUW6f2tYPLe4aDTN+u12vrKmYOU96ROdZexK92TJv84PQv5TBkbtRYZFLgEfLWUGBO1X4FY96R1K03Z4cGQ/Njbr1VWCTrEBm/66W6jI2ytxBLRarLJPftAjhqwmTjxPhRk2ueyw77YV/r6CdZecIsv/zS8yhc7OP/KlqOmSQGa4ze3SRbVJLWCheISJefIrQh0hjz2I5ENIJl28W9aYVAY8aoO4HgmbjlU/VWDfmFp/PtTTioIFarh2qaMBnGbGBXQrLycy6JUlh5lro2EwfMfsbjdiQrcmoCVblwDoZvd36SIRCObwCgc2HcabBdrnU2u6n6EXxImzzizuHlwxGS/sHsfItPEChSbMUzQqJb09lF4aefSM0LbTDFtpprhtqvcsqSV4U4GF00QxYNLdsFLsFql8q/XDysTNNnZ61mCxRmurAnGaxH1lWcJbacHoq5Mt0QR68L11x+0M5jT0oi9Uvv3As+XX/1nWPIkMpyAWLrhkv5N1QDtZvZQ2BI24iDx0kE6EeukREoiws9FSE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(2616005)(8936002)(36916002)(66946007)(66476007)(66556008)(956004)(5660300002)(26005)(2906002)(966005)(44832011)(31696002)(53546011)(6486002)(186003)(83380400001)(508600001)(38100700002)(36756003)(16576012)(54906003)(6666004)(6916009)(31686004)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlkamFYR2tOUUpYS3RMWVc5MmRKQkw2NXdCSVdEdkt1Ynd6TTErRHFYcWFp?=
 =?utf-8?B?Nnl3NEo5WkhxUzVkOStrLzgySy9jUDZSeTc4TzZIZFBFemlaRU9lTHJLTTlT?=
 =?utf-8?B?NDBEVmxHLytzck1xd0tHd2J3dml1Y3JxOGgzL2VOeVJkQlFYbU9FbGxxYits?=
 =?utf-8?B?MTNRdGVMT1RZM0ZNc0VIVnFRU1NIWC9ZUVBzcnoxUWlEY3N6VHpHbnlnSWkz?=
 =?utf-8?B?NUlnaVRxNGNjMzFHL3o0WUlVLzFWUnNBcHRmYlJRMUxGWmQ5UzJZS2UyZFNm?=
 =?utf-8?B?c08yVWZwSlF3MERmRy9UaXpQUTlRYmkzY0lrZDI3ODRoOWNaYSsyWUhmek1a?=
 =?utf-8?B?S0lmVzRYdmxkR2NoYzBGbjJYdm5Ya2QvcTZvdE9IYnNrakloWWxDWVZUbC96?=
 =?utf-8?B?RjJlRDFJM243RU9QYjNWcjEyc2txck54YkpxWEIrdjlYTmZ1TkQ4SCtpTVNa?=
 =?utf-8?B?b2c5ak9OOW03L2VxTTRyZjZkaE5wdGVmcTJ3aS83MjlHZG5lZitxczRvbDNi?=
 =?utf-8?B?L0k5bVJGaEpKS3ZadjBBcWZFNlVJaG1VMklqQVBRcEQyZk9KUUY5MmVOdVBG?=
 =?utf-8?B?S245aS9UM3Ziamdtd0JERUc5ZUVla2g1SmpHSkxLalJTVHhyTFFLRS9mMk1V?=
 =?utf-8?B?ME9zaGdTY0dJV09LUDJmMUw5R1Vrd3BhVGhUSlpGRkNOZzBCc2MvdFdZVXRK?=
 =?utf-8?B?aWYwT2o3c2tQcFVzdk93ZWlpTDlDUm5GMGZ3M3lRSnpoQ3VteWN4UHlRZkJo?=
 =?utf-8?B?TW04WG8xbTlnQUJVZHhYbnFicmVoTjdQSnRWUmZValRsZGNoeE5pNjFNL2JG?=
 =?utf-8?B?SUdvaDZDY1QxQnZGb3JZWElUODlXZ1dGVER5L3pKVmEzUUxXbzlDMkU2cmZv?=
 =?utf-8?B?MHh4dlJKWVl3L0lqazI0UWo5Z3pQM0FWSklPZjBUYVN5aEJ1eHZtVnpJVmRV?=
 =?utf-8?B?bEpsWThHajdnMEx5enZ4aFl3N09wZWJnR1VwLzYrRXZvb3hmdHhtc0dLNWNN?=
 =?utf-8?B?ZlUwY1U4cUI3SWdscnRDMXEvMkw3MmdEak9PSlYwbTl4WVI0dm5ZaVo1bDVI?=
 =?utf-8?B?ckUxYURxdzZHTzFBUzI1cUpua1VqQ3k5dmRCWkJIT01sTkNPTGVyenZFdnRZ?=
 =?utf-8?B?U3hDVTBvSGx4T0lnZU81N2xvdnpjYW5NV21xM3VSUGNxblU1akk5VHlTRExu?=
 =?utf-8?B?ZmhpTVQ3L3Q3SlZyYjlCS2tOK0U3UXV1clo3eTFtejNtTVRmN1NVWnEwb3FB?=
 =?utf-8?B?WEFuZWFTWUxKNXJoVlZsck9JK3pnOFB1MXNHUmxBaXBwRVgvd2Qwbm9JNUsz?=
 =?utf-8?B?ZE5UTUlpZVEvQVlKY3Y5Tkhqc1ExeG5KTlZyZG8rNEpRZ0Q2S0owczA3TzFM?=
 =?utf-8?B?U1doclJUTS9tOWFkZkRNZTJ0NUZlNkVmeGFqbDNoWjFNNVgrQWFhNlhWT0Vh?=
 =?utf-8?B?WVBPV1V6VnNLbDVHejVZQlNWSFArdU0za1MzV0l5RXhIR0FWT3RQTnVsM2o2?=
 =?utf-8?B?eHhsd3pMd2NIOFkxaEhSeVZQdkhKNlUrRGhRajJzTXN3ckxYSHFLUVM3MG93?=
 =?utf-8?B?NlllZzRDK0kzc3VVYWZ5WCtkLzg2dWRXcGRWN1Bmbm9mVm9XMWtobVZHeVRP?=
 =?utf-8?B?eE0wNlYxOU41MlIwOVNhTmJhTnA0emw0SEhldGY3eGVWMVl2Ny9SeFdjQXkz?=
 =?utf-8?B?MHg2a0FrTEp4K2F1S3FwVFJJeThCZU5IWFg1ZEZvdEsyWkNLUEV2U0RkbkZ6?=
 =?utf-8?Q?+UCzApeeTqOMJEQ3ErttsNcSCjT6BSZzJSyBQe7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad106470-65c2-46b0-76a3-08d95c5dc5ea
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 00:20:07.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuPzgpyYLVMgdOTwYbT2tH9XslNaJK+7T02s8DD76x+97jtuzrXlt6jLV5SSnAvd8qFHHFtUfYrMfuJiflTk5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3172
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110000
X-Proofpoint-ORIG-GUID: qEAELtVa0GUDgKKkE5-6aiOTOSfj1JSa
X-Proofpoint-GUID: qEAELtVa0GUDgKKkE5-6aiOTOSfj1JSa
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11/08/2021 1:01 am, Trond Myklebust wrote:
> On Wed, 2021-08-11 at 00:52 +0100, Calum Mackay wrote:
>> and I forgot to add…
>>
>> On 11/08/2021 12:36 am, Calum Mackay wrote:
>>> hi Trond,
>>>
>>> I had a report that bash shell "truncate" redirection was not
>>> updating
>>> already zero.
>>>
>>> That's trivial to reproduce, here on v5.14-rc3, NFSv4.1 mount:
>>>
>>> # date; > file1
>>> Tue 10 Aug 14:41:08 PDT 2021
>>> # ls -l file1
>>> -rw-r--r-- 1 root root 0 Aug 10 14:41 file1
>>>
>>> # date; > file1
>>> Tue 10 Aug 14:43:06 PDT 2021
>>> # ls -l file1
>>> -rw-r--r-- 1 root root 0 Aug 10 14:41 file1
>>>
>>>
>>> open(O_TRUNC):
>>>
>>> 10581 14:52:36.965048 open("file1", O_WRONLY|O_CREAT|O_TRUNC, 0666)
>>> = 3
>>> <0.012124>
>>>
>>> and a pcap shows that the client is sending an
>>> OPEN(OPEN4_NOCREATE),
>>> then a CLOSE, but no SETATTR(size=0).
>>>
>>>
>>> I think this might be because of this optimisation, in the inode
>>> setattr
>>> op nfs_setattr():
>>>
>>>       if (attr->ia_valid & ATTR_SIZE) {
>>>
>>>           …
>>>
>>>           if (attr->ia_size == i_size_read(inode))
>>>               attr->ia_valid &= ~ATTR_SIZE;
>>>       }
>>>
>>>       /* Optimization: if the end result is no change, don't RPC */
>>>       if (((attr->ia_valid & NFS_VALID_ATTRS) &
>>> ~(ATTR_FILE|ATTR_OPEN))
>>> == 0)
>>>           return 0;
>>>
>>> and, indeed, there is no change here: the file already exists, and
>>> its
>>> size doesn't change.
>>>
>>> However, POSIX says, for open():
>>>
>>>> If O_TRUNC is set and the file did previously exist, upon
>>>> successful
>>>> completion, open() shall mark for update the last data
>>>> modification and
>>>> last file status change timestamps of the file.
>>>
>>> [
>>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/open.html
>>> ]
>>>
>>> which suggest that this optimisation may not be valid, in this
>>> case.
>>
>> This has been discussed before, way back in 2006:
>>
>>          
>> https://lore.kernel.org/linux-nfs/4485C3FE.5070504@redhat.com/
>>
>> "if and only if the file size changes" which isn't in the POSIX IEEE
>> Std
>> 1003.1-2017 I quoted above.
>>
>>
>> So, I take it that this is still intentional?
>>
> 
> Sort of...
> 
> We implemented the current functionality as an optimisation back when
> the SUS was the most up to date authority. We could undo that today in
> order to be POSIX compatible, but any change we make on the client will
> rely on the server implementing the POSIX and not the SUS semantics.
> 
> IOW: in doing so, we'd be moving the problem to the server.

Quite.


As an added dimension, I note that with NFSv3, it /does/ update the 
mtime [same client, same (Solaris) server], via a SETATTR(mtime: set to 
server time; size: no value).

Indeed, this was how my reporter noticed: they moved from NFSv3 to 
NFSv4, and their scripts started producing different results.


Presumably the other problem with changing v4 to match POSIX, now, is 
then upsetting all the people who are used to the current SUS behaviour.


thanks,
calum.


