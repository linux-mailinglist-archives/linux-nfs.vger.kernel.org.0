Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CDC3560A5
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbhDGBXo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 21:23:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDGBXo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 21:23:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1371Ij3U186674;
        Wed, 7 Apr 2021 01:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ow9LWozzmiIqx/tuzziCRuyCmgM0fihEXyMdkwLiabI=;
 b=ipOV2tNHG3QRpFvj3PeIt0ZtAwZQOX14RUo/XKUjRO1QHtt44VHmITxuma3nt7lI88Yq
 yZ93KFbj8Lg1kSndbi2LRJ96QGCJQ7ShT78Ghf4OTpbCAgJS/YkAmL3sf07lzLI5PL22
 C7uMSBEX683RC+uFboE5XmKAjHZi5gxAQ67U0vkbEf4XV/reuluDDeAsaJ1tY0/UD91W
 yPvnWvxLWPCzs/qugLlfQu0F/yD5PXQOnQSgBc/Qko1W4Zy0pRqFpPQB6I5uyGs/r77S
 tFTuI00r2KLGDwsKfnDpeOk5rC1ZEVf8yMRsJlG18t/OBN7HuC2/W67ooK4hXGLZ/WUU aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37rvas0vtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 01:23:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1371G3SQ078632;
        Wed, 7 Apr 2021 01:23:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 37rvbe4dra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 01:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz3iT2c8kbwl0FRMNKagecGUGvWVB5lB4rflo+dq+YhjMfoTCXHro0qgk0EhtGVaC9CcYy4sbpqRdVbkCDWw239bo40gCNOaeNKhCIkx1LSn9mv3BsrfEUbyy4kRZW6uKy4jd1e85Q6fNE1Gtmai+PFQGzUQfRLSCIX1YrpTL7t2fXvPHot1YD3jM0IrtI2nnSeBkS0xSr+XTigYty2W5FI4R8JhH72JJ8IQqcVaFD27Z7BhbXskTXme+gkxJLfa901DJHQ49tswQyd830H7FhyMu4l57n8kJmj+25I9P2RYBQ5G+qSs9qtogILhV7uZLVBkWoDnTss0tx7DBRyK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow9LWozzmiIqx/tuzziCRuyCmgM0fihEXyMdkwLiabI=;
 b=N81EcH6LnydFnQ7Mi2sZwgLvCvhOQdhzsz93oxdjWa+FTulhwCrWfkbV5BchL+eXi8jRpQiSgYu5ifniyXrJmspcJa1GuMocACL6qclYIfpMJG0WphUyf2oRcD1kgvpvnaS6uHOcAvfTmQ0baYoelEOsZWKK8/6SnNYIsETcXFGKFsE2DJ7XG0VOI3AQ8atEdU3yAWhWXnt4K9JMafGiBrA0LZFBBcJ+0/8XO7lj4jsIucvIXXAjjLaDncXt32PGMbn73VGW4oPaP6BoRYJAGBXvp8iGvkWkXHRjzhRucUA/s6cR46/VyUgjr9uQWQQfLKCkxbx6C2cNPBAngL6fkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow9LWozzmiIqx/tuzziCRuyCmgM0fihEXyMdkwLiabI=;
 b=jmB3BtqLTeteBRTHhQYx2TaNd2zopmy/mb3vsGiGRQA1semx+Zo5KQi11xXkAM+BDUjEHaTX8h+PhQlBCAJ/JD5OIM3dt9qp6h3o35KVXj+wqna8JpO1DPw2zDt+KoQsdY8v+LK26JoygbyI3p6R41bihKVe8YHda8iHZEqK0n4=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 01:23:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 01:23:26 +0000
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
From:   dai.ngo@oracle.com
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
 <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
 <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com>
Message-ID: <c16b4437-a554-be60-3c04-fd578b9f88ff@oracle.com>
Date:   Tue, 6 Apr 2021 18:23:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:a03:333::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 01:23:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c19012db-20f0-4091-1412-08d8f963be35
X-MS-TrafficTypeDiagnostic: BYAPR10MB2966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB29665953C2248E97CEA11E7287759@BYAPR10MB2966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8wEPUQqqZe610HjNXUgxAKCxzHqtOlQ5q3JsONQmUdICpEgQnahXVMjhZEoHl5GwdsLh0C0yoz0+xAgP624ywZqtF1w6dxRwdRejhjgdOeRO6n4p80d7ofPKCXHhRuNY93oCjN54tJ0rtdieDxbtkmSlrx5zPTW0jjsNGggkzUsM3B/hrIZNbLv/+9+thbcDZ4HT1lkxJ9XoCjjgtogB8q0hNh+rprT+VzpyCsv2bTecrn1cmYLQqlne+jodCE3IJRehZ/MammKjwfhxZPd1GdRhIm1E6zIQCGCSLe/XxyE03yH78qivTIzIQ4KbpyH/fjtP4vbnGeL+OyIehk3UuUyIbgL1P5L9LTFsxsSYH+6CGni3bGJafCRCKZd34UQ2VsE9FITDmVoHzGnErwcteYH4HtV0SgZ04dduL7TAPwBfk0+Y8zCK7hxuU+y0cW3wndLPMOAMU/vWbTmM13rHsQVbBwpy+5jyVE/xAEvnyI/5FomtXd035JhcMa2R6nmIFSU/HT0+hNDeWV7GDExxpo/IYUpeB72dBE9LQ6ixU1CuTa7X8ZJpUyl842Z2Bmi0UTSXQ9H0py8fa3UWfYgFBmP6APf87/jEt5s9Am01X/hl+Zpoe9kl5qR4SA1O5HmEL2jLw1MQlicd+wIlQotPfCP/iGsSJqLSGs7PSNkWvVt7WeFbabjGxqEqjZDD3TX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(83380400001)(2906002)(956004)(110136005)(186003)(4326008)(54906003)(36756003)(9686003)(478600001)(6506007)(66476007)(66946007)(38100700001)(86362001)(53546011)(26005)(16526019)(31696002)(66556008)(8676002)(5660300002)(6486002)(6512007)(31686004)(2616005)(8936002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGd3S3RkdHNXdkVxbDlYdzlQSm9xeTB1SG1VVG9oeDhma1dOd1Vnbk9MaXR5?=
 =?utf-8?B?ZWVVbHRvUk9yN25IOWU0cXUrcklCbnU2cTA4cE9Ob1lwWk1MMW40TE43ZTVF?=
 =?utf-8?B?Y3R5NFY4Qnk5SmZKRkN6L0JtY2JQTGt2akRmZGwrVVJDRExORVFQdGxZcjJ0?=
 =?utf-8?B?WUFYVUJwNEhwTUUzci9CWTRyaEJmS0dXbmpRVmwxS1ltSmRhYmpXT3MyeVRi?=
 =?utf-8?B?bzRPUThqaGdMNHkxYzVmVGxWdHFGVHdRckhZSkFYaXhtOVhGVlpTdlI2ZGF5?=
 =?utf-8?B?TVMxVWJCTnd3NDFIYTQwenA2RnFVMkZBRHc1bXlMaVNocTE0WjNzK0FvbzdR?=
 =?utf-8?B?eld0VzE3SmVtTVNXZDZNTUtpSVNQNCtrZzlzcXZjTk4wVmpheEVHMmxPd2Rn?=
 =?utf-8?B?TUNPTjR5eEhkbVUra01hU0tvbjVyL3R4VzBWdTBGYU0rcW1HcENaRGNxZnJB?=
 =?utf-8?B?SkRnNnhTOGxDdEZKV1hFR0l2UE50QmtuK0NmMGtyNG91OHpoVmtUeWN4VDQ0?=
 =?utf-8?B?WDkySC9LWlJCTisrdmJibzFLUGJXUkszN2hSUmZqdzdOWHdFNzE2WkZ5MGRG?=
 =?utf-8?B?NzcxNCs1MUZGSEJ4cUtxUit0REVKTFRPS0NiRUVoMysyTkp2VHUyQVFlVzNV?=
 =?utf-8?B?WEU5akRGQkM5NTF6disxQW03a3Nrb3h0dGxiZktTbWhRNmZDUms2dS9Mcms0?=
 =?utf-8?B?Sm9iN0RjMTYvNDUwZGQ1Q0w0aVRrRGI5OTljaFhDSW1INnorczRTdVRSdjRt?=
 =?utf-8?B?eDJPZlFsWFR4dFlwY1l6VTVBcE9mTHNpTFRWWmxJUkVWMk5qRVJlKzk1N0sv?=
 =?utf-8?B?S0VIN1J0dlF6N3lGenMxM09oLzhEREZnVUdKeTNlQ3ZMT2NxaVFxQWVDa0dI?=
 =?utf-8?B?TW1zZFo2WlZmUE4zSnVrbVlpWmJWUm9UT0VzTWNmYmNDZTg3K2E0MGxmQ0sr?=
 =?utf-8?B?czRCTGpDdlh5cjRqb3hUYUZhNVppejdocU9WUk44OVlFZmtvL25TWnE0dFRh?=
 =?utf-8?B?N3pEZ2N2SzRDckVvb2FMSklZYktBQXE3QVFGZGFTV3lqNEMrSTN1dldOSVVu?=
 =?utf-8?B?WUhzbjNmWHJXeHJweG96LzIraTN2TTAyQi9VRE4yNkt3Wi9ZS3pQa1c4R21h?=
 =?utf-8?B?MmVEMWdEd01FUFZtWEdWOFYwdWZZcXVGRFllK3RwRWYrcG9aN3ZnWWFnbzhE?=
 =?utf-8?B?ZGdTdHBlUkxRY2xVKzBzRFZBMmFaTURCZDFuY3RKa1Zla08yWFhwM3U4aHBK?=
 =?utf-8?B?Q1hXN01xTUczZU5scVdrb1lEU3g5cmFKaC9nUnhKK0tHUklUSjRjTnk1UlRG?=
 =?utf-8?B?MkZFb3hRNFRuWXNFYkJNVnk5ZDRpS2dKYTQ0QkpkSURFVllLaXdVMHBGdDIr?=
 =?utf-8?B?bm1tb2xVWW5lckttZEUzcmR1OCtxcFl0ZjIvVURkV1RWdkd6WkFURkd6Y2tp?=
 =?utf-8?B?NnlFWVBJTSsvYk45UVlqTm1ONEVlUU5MNUdWY21tS3NCKy93bGh3VGtJRVRZ?=
 =?utf-8?B?cG5WdXJGZW9aQ1BFSEZHZGpaZ0l5Rk1tWGVvZHNkK3VzVTdpbTM5UThEY3NC?=
 =?utf-8?B?NS9LYUdRUzVMTXlzUVdtUDl1WXE2em9LeUIxMzBQcEpIYm1MZGNYYXVqc0or?=
 =?utf-8?B?ckttWXVFN3lPNks1Wm5tMytkZlRUclFIUW5HNFgrQ2JWVkt5NVlpclY1S3lO?=
 =?utf-8?B?b0N3THpiTStyTHFIZnJBbXhHdnR4VmdqNk1wYnkwQlB0d1V6RitUbGoxRjFE?=
 =?utf-8?Q?y2v9OM9u6r9aus6RJO9+tpG6w2tC9pPMW/tpO1B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19012db-20f0-4091-1412-08d8f963be35
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 01:23:26.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbfcMZJMZAX7oeZfiU9wUMYWjOaOPxZne9Yn+0AdqC8B9YB9YRXo9A8nN/fsvXuBv5OkXeuwbmnyEU8980lPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2966
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070006
X-Proofpoint-GUID: CTcoL3If9FyekLueyXW13R_TNsLFpfGM
X-Proofpoint-ORIG-GUID: CTcoL3If9FyekLueyXW13R_TNsLFpfGM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070006
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/6/21 6:12 PM, dai.ngo@oracle.com wrote:
>
> On 4/6/21 1:43 PM, Olga Kornievskaia wrote:
>> On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III 
>> <chuck.lever@oracle.com> wrote:
>>>
>>>
>>>> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia 
>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>
>>>> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III 
>>>> <chuck.lever@oracle.com> wrote:
>>>>>
>>>>>
>>>>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia 
>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III 
>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Currently the source's export is mounted and unmounted on every
>>>>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>>>>> for each copy.
>>>>>>>>
>>>>>>>> This patch series is an enhancement to allow the export to remain
>>>>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>>>>> export is not being used for the configured time it will be 
>>>>>>>> unmounted
>>>>>>>> by a delayed task. If it's used again then its expiration time is
>>>>>>>> extended for another period.
>>>>>>>>
>>>>>>>> Since mount and unmount are no longer done on each copy request,
>>>>>>>> this overhead is no longer used to decide whether the copy should
>>>>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>>>>> to determine sync or async copy is now used for this decision.
>>>>>>>>
>>>>>>>> -Dai
>>>>>>>>
>>>>>>>> v2: fix compiler warning of missing prototype.
>>>>>>> Hi Olga-
>>>>>>>
>>>>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull 
>>>>>>> request.
>>>>>>> Have you had a chance to review Dai's patches?
>>>>>> Hi Chuck,
>>>>>>
>>>>>> I apologize I haven't had the chance to review/test it yet. Can I 
>>>>>> have
>>>>>> until tomorrow evening to do so?
>>>>> Next couple of days will be fine. Thanks!
>>>>>
>>>> I also assumed there would be a v2 given that kbot complained about
>>>> the NFSD patch.
>>> This is the v2 (see Subject: )
>> Sigh. Thank you. I somehow missed v2 patches themselves and only saw
>> the originals. Again I'll test/review the v2 by the end of the day
>> tomorrow!
>>
>> Actually a question for Dai: have you done performance tests with your
>> patches and can show that small copies still perform? Can you please
>> post your numbers with the patch series? When we posted the original
>> patch set we did provide performance numbers to support the choices we
>> made (ie, not hurting performance of small copies).
>
> Currently the source and destination export was mounted with default
> rsize of 524288 and the patch uses threshold of (rsize * 2 = 1048576)
> to decide whether to do inter-server copy or generic copy.
>
> I ran performance tests on my test VMs, with and without the patch,
> using 4 file sizes 1048576, 1049490, 2048000 and 7341056 bytes. I ran
> each test 5 times and took the average. I include the results of 'cp'
> for reference:
>
> size            cp          with patch                  without patch
> ----------------------------------------------------------------
> 1048576  0.031    0.032 (generic)             0.029 (generic)
> 1049490  0.032    0.042 (inter-server)      0.037 (generic)
> 2048000  0.051    0.047 (inter-server)      0.053 (generic)
> 7341056  0.157    0.074 (inter-server)      0.185 (inter-server)
> ----------------------------------------------------------------

Sorry, times are in seconds.

-Dai

>
> Note that without the patch, the threshold to do inter-server
> copy is (524288 * 14 = 7340032) bytes. With the patch, the threshold
> to do inter-server is (524288 * 2 = 1048576) bytes, same as
> threshold to decide to sync/async for intra-copy.
>
>>
>> While I agree that delaying the unmount on the server is beneficial
>> I'm not so sure that dropping the client restriction is wise because
>> the small (singular) copy would suffer the setup cost of the initial
>> mount.
>
> Right, but only the 1st copy. The export remains to be mounted for
> 15 mins so subsequent small copies do not incur the mount and unmount
> overhead.
>
> I think ideally we want the server to do inter-copy only if it's faster
> than the generic copy. We can probably come up with a number after some
> testing and that number can not be based on the rsize as it is now since
> the rsize can be changed by mount option. This can be a fixed number,
> 1M/2M/etc, and it should be configurable. What do you think? I'm open
> to any other options.
>
>>   Just my initial thoughts...
>
> Thanks,
> -Dai
>
>>
>>> -- 
>>> Chuck Lever
>>>
>>>
>>>
