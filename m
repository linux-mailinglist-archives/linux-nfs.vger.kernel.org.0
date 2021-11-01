Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E904420BC
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhKATY7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:24:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56992 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhKATY7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:24:59 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1JCYt7005977;
        Mon, 1 Nov 2021 19:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HG7+jbk5ZETazll2+iRYuP4MkL1aMpcsuT3tEL/W86g=;
 b=FK1unQ1OMd9MVQ2s7ve9LYmS/wNR+/t7SrRpbfPGcxCIPrj4vKj3zSDe4rjxA5b0udj9
 wCcGCOnVI75prH8MhyYrZwTZ2qApocEEOffmm7ZvXXxB1vqG7bnjUkiFXMUDgGv+FgFa
 q7+qB/Nl8+i2gxN0yfnyD4IDX2NmLLmI+cl5c3uBd5qrJXyls5saeiJ36gmQeKy8gbtw
 8NXw84HF2Oe4xFbUo3VXuHqoQCeLWKNMxvl0GWjUt2vCwt/6ZMFY+MqgT/s2EEXDCL2c
 IFnscQTywBwmyPLV5ViU10qe6Cb4ytUf1Rg82ZdMYobohmmvW3qb7jbGbIkXs0KKW8cF pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c27r5bmmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 19:22:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1J5os7139372;
        Mon, 1 Nov 2021 19:22:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3020.oracle.com with ESMTP id 3c0wv38utf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 19:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFVkwo/FEZBVNDACKih+BTWk+PTKKaxjkGNh5Gyx2SaIgFaJmmcGzMRtj8a7ryJi7+QT8j9Oolmj/BLosAsSDo+mGGz2gpUE3lLIcTTl63nOq4tbdJLXiQLhrRn8CdJkAjMOV5tc9ZWwzFqE7bYZLoJf2wrU2f+ZdTW1xJgq17crzMH4EQQd5OzsCX9Dt+bS/NYjS10T8R+LGI2Kbrc1BPIodt5BtF3xqYOtWY131YrhKNoeA40eDC5OsV3LLCo2Ozg6sgDXjpTg/Nfpn7h5AYXLNajpSCjzrD3fboiozg7/Zvb9rw0xyHpgT00iBs/oelCjO0Butjyj1SkPtKul1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG7+jbk5ZETazll2+iRYuP4MkL1aMpcsuT3tEL/W86g=;
 b=h6BP9xRg/9MNQsaDWe3YuwHqNakEIfFJT5quvKWokAeUuvzKUPBj4ZvZ4ZdXGIDz1ji2RTB2kQfaINu9k6FSni2lqeKc8dhQnDl+8dSzHURvhfAa+Kj7K69w2d3dkYn3JyZ0LlnkIJkh6DirNJ/dAAGgCcpv9GUcjWnLnZ6WC6MCi2Bq0aQ/PGOUUMWlJOww09mi5qVp3QHZFHe5yxiWSB0BY866JAWXotUiGqSx2ZQXHzuLd1zfFyx8Hp3/r5kfTH3BrWW/VpFfp8EC9cYAZRT/EwHUpVc8mpqj7ifMWP/4E94DvMuinOIAWfmV5IVe2CVrLp99LhukjjvJzcozTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG7+jbk5ZETazll2+iRYuP4MkL1aMpcsuT3tEL/W86g=;
 b=H0UCgKXDihdNl5s+xwJD6sXplLdb219X7GMAcLm266gboFEWLfb0F6b41Lb8O24pSSzcYH2mqBaSWWTBXBtyV8m34/aCR4ThK5G0Lhj7zb7Zy1YpUN+W+PJamXfUzjREY5AUbsQ0d/9oweukLlwxsb4hNDoH5QK6tYhzwbwIBqA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3112.namprd10.prod.outlook.com (2603:10b6:a03:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 19:22:20 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 19:22:20 +0000
Message-ID: <93c09b22-9439-3404-ed07-e99cbbc12052@oracle.com>
Date:   Mon, 1 Nov 2021 12:22:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     Steve Dickson <steved@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <badaecc5-2936-4ab7-53e9-fabee0b51493@redhat.com>
From:   dai.ngo@oracle.com
In-Reply-To: <badaecc5-2936-4ab7-53e9-fabee0b51493@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:806:a7::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.39.219.222] (138.3.201.30) by SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 19:22:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f4b0446-1745-4645-f4c3-08d99d6cecbf
X-MS-TrafficTypeDiagnostic: BYAPR10MB3112:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3112CA058D62353076A10A4C878A9@BYAPR10MB3112.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HlaK7NAevQlGVRnZWANuQwrnt4wxj95uwEeG/BaSZhuS9V81nGNTaNNKxgQmi1+nkQ3Szva6m590T6rfQsRCa8gBmUBXaxqEnLG+SFLG9214ZC5+1NqOEhkJVMjNtYS871g7VmzlT8CoudaXvwvxV0m15y7b0yGvOENHCbSMiG0q/uXHfIZgCb2yQyiOfJh0CePwRaKFUgb/tearpcedxE36VlbhVGs9YusLwknFauaXcs75NsF/XQdMOPNb3jjmGPZOvwmHIZOTBbVEXZqHtIfGhvQLVFxXIS4fvqZv4k3fXh8vSINdc0kWi2KkOS3uyPN+5npcpfGZsYXYK0COX2k871dY6skYBfL6fIEsyQMMCErNh2hqfFVB0LrF60+Wi13SPR1NFyn7O4gd+7vZPb7Avnzl60zzMGlOlsVe43PHmj6ECIUEnF2+kpSWmHF+fDmYLxcLW3Z+AmXScuxQNyoGqeAwHh3s6WXFyOYZJFJ5bbniOcO1ZczP+TX17m+fK63OQUEL+Ik+vF4NUQU7rI59AQg0GUn9Y07oNIaNaxEPT+V6ekogtSHnFhieUVc8UcNFg8gD9AJNXl05eoYbP+lhkKN6RiUEowWHH0M1NNxJj9QYgGPfGBudSfPHyT28zwbWyvN5miJSuiXpLIV50z3LMV3vNpWdRmj/JJGV1nRuvLHmA8tzyUH6dijP/MhqsBNPUHUnrcPIKcx5vqXTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(2616005)(956004)(110136005)(86362001)(5660300002)(6486002)(83380400001)(4326008)(2906002)(16576012)(316002)(9686003)(8936002)(31696002)(186003)(6666004)(38100700002)(36756003)(53546011)(66556008)(66476007)(31686004)(66946007)(508600001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlKcXFqVzM4eWJsT2Rkcm5tNVI3dzZyZnlUWkltRmZpQndCVjl5RXNoVFVw?=
 =?utf-8?B?MmxWcXA5dFpJY21kZ3RGcXUwRTV5dFV0L2I5OEhTbmpBbGZMSVFmYU1YZ3BX?=
 =?utf-8?B?ZFlBeGo1UGxmQW1FQVRIdGJXNUMwSG00bkdmMGRJSUJkUHhkY2pBTjNMQUdx?=
 =?utf-8?B?a2l3Q0pRc2xRaFF2UFhINTVObGdYSEhGMlRrVmlTOGlvQlRlOTFCK3IwZDZ1?=
 =?utf-8?B?U2E1V3N0TjVGSmM1Z3JoWXI2TXBHbW5JdU5aaEh6YVVIbWNRdTcxZG12eGxX?=
 =?utf-8?B?dW1oRVRKTG5KVUNnZ0N0byt4VGY0Z3NDeFZDc2VpMVBUcnNOb3hhUG1xN2dr?=
 =?utf-8?B?TWFaNDFVdCsvWWNLYmZYcE84OUNneVdHNjVkUE8xMjc5YVduN3Rxc2Jlc29I?=
 =?utf-8?B?U2dEWndOVnV3ZStYWWNQbHJTOU1hd3p4cTNpZTVabjQ3MEhHV0pidTB5dkx1?=
 =?utf-8?B?bkdxUWVadW1Gd3lDUSttazllcHpHK2p4VmpPR2ZQMVBwYzM4ZzBYUzUyY0N2?=
 =?utf-8?B?Zk5PUkVyUnIyL213cE9XckpPTStHbWtZaXBRY3ZPbFFMekZ1ZFRTcFc4UWhD?=
 =?utf-8?B?SzVZeWpaUlZ6T1NJa3VQYzhtUkdPZ09BQmxhb3NoUkhSZUdwNnJmdFVwaysz?=
 =?utf-8?B?eC9mTUJsVkNvbk1YU0RYMFV2cSsxdWQ4V1FmOGUycWdQbmJ0NWN1MGI0VmNP?=
 =?utf-8?B?azJndzZ2Q3lMYzlTeGF1enN0b2dmajJyNlNTM1hrbU5GNzdrek5aZXUvMTVz?=
 =?utf-8?B?SEordXpISlYxblVmYzRaNGdrbXVORGp6WXU5ZFpMVFp5ektNdFNZNDhvN3l1?=
 =?utf-8?B?Nm9lZ1grY3Axa0VyRitxWlZIYU96NEdNdGJSaFc1Qzhlb0hwSTZpeG5RV21h?=
 =?utf-8?B?UEpTTlo0REdmTldhSElteHdvZEMxUXM4NGNRR3ZqeDNHaUEyVk1aRkt5djRo?=
 =?utf-8?B?c0ZneGpLMjBVWjdUbXpGQlUzYlErVVppUlVseld5RU45YUtsU3RUWmUwMHNw?=
 =?utf-8?B?VjB6MjRNWTNaU0JDMjYvWktRWHBBekhSMUtZdjlrN3g3bk5WamhrdlNrSU94?=
 =?utf-8?B?bXdONzBZbXBHQ0RWbDlGQ2dwV0RZcHptdjAzUlB6aEduMHFjWk01bGJCTTM2?=
 =?utf-8?B?bDU5M1ZLdjc5WVl5SzZtUHVNa0hZbVFVdE44eGZYUmk1Y1JQUExmSFlKNkFT?=
 =?utf-8?B?Ukk4S2pmazRhTURUY0tEVUU1bTZ1VGFYOTYyS0VQblI3WGVndXBnN2Jnc1h1?=
 =?utf-8?B?OTZqS1RYb25zVFFKRzBIUFZncnFJUDBKT0pTZElkbWhSRThZTi9Hbmx6RGFG?=
 =?utf-8?B?NXh1eDlPQTAwelJ3YmtSVXhVbHJyS1NCUU5UNE5MVFFXWmM3UHhUTjlLMUIw?=
 =?utf-8?B?bzRaT1JaeWsyZXlGbWNsVVRjSExoUWZmcTNtU1lnOVVPSHcxVGswSnpQd043?=
 =?utf-8?B?Ni91WllaN1U3dTNKN0w4NUFCUDRDRkpYNTNobmtiWnhQMldwVzE4Zi9RakRs?=
 =?utf-8?B?cGxtenZLdnZHZmF5RkZzSmNXejR5dnB5bWx5N3l6M3M5ejl4dWVBenowQ0JQ?=
 =?utf-8?B?WUxab21lUWUyTzYrYnI0VW5NU3NMa2w1aGEzbU5ncnd3Z3kxK29VeXpkTUxW?=
 =?utf-8?B?MXVNd0duZmx4cm5BMEg0VzZrTFVOYWNVaXNpa1hyZzFmZEd4M1pXMzJRMXls?=
 =?utf-8?B?d04vU1BhTXRBQWE1U25FWTRPeGpibHVCSDZISkt2MkUrcE1OMnFneXozZUUv?=
 =?utf-8?B?ck9odEdtaGdEWm9jMnVxdEgyMGNaVmMwTDZYM1VWbXdiMkRiNk5ST1J4NVZn?=
 =?utf-8?B?SVNyajc3QmljUDBSSWl1b1hIZVJwSGJ4cU1mTVkrUHBtczAwZ3paZ3NNRDRN?=
 =?utf-8?B?SVRCcWZFcGtVbmZ5OWp0Z3k2YzI1S0l0enZJRTVaN2R3TnV4R3IwYXJXTU1W?=
 =?utf-8?B?dkdhaGpQYkd0Z1ZubVN3c2tVMnpSSGM2eVRNbmpHVTlkKzVzQXFDci8xN3No?=
 =?utf-8?B?aUhXNjRmZm9MbTJQdmc1bkNkM1dXcHQ0N09IVWFLUjIzTThFMlB5ZTlTYnNq?=
 =?utf-8?B?MjVwSlZtblhYQWE2akVxN1hOMmp3YXBRbklnTm03MTRsQXZPa3V6aVY0V3d6?=
 =?utf-8?B?UEFGQTR2S3dNaEFxdjRreHdjQzdtNXJNLzZqbjBBYk95RUFYYXlFWW0zQ3pX?=
 =?utf-8?Q?5a9cgtSXud6ckpDkGqtMwJY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4b0446-1745-4645-f4c3-08d99d6cecbf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 19:22:20.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOhKlKJKjD8qD9gPC5kqXhTxIVd0py/FGRPtgTXH+IPIB1yf1z6WeDpKGWZSSlm4z0VRZ5Oveyar1zJnvrI6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3112
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010103
X-Proofpoint-ORIG-GUID: 0N1ja4VrqAwpjK6ic8LXYFCeLL3yqGLa
X-Proofpoint-GUID: 0N1ja4VrqAwpjK6ic8LXYFCeLL3yqGLa
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/1/21 12:02 PM, Steve Dickson wrote:
>
>
> On 11/1/21 11:40, J. Bruce Fields wrote:
>> On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
>>> Hey!
>>>
>>> On 10/29/21 15:14, J. Bruce Fields wrote:
>>>> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
>>>>> On 10/29/21 12:40, J. Bruce Fields wrote:
>>>>>> Let's just stick with that for now, and leave it off by default 
>>>>>> until
>>>>>> we're sure it's mature enough.  Let's not introduce new 
>>>>>> configuration to
>>>>>> work around problems that we haven't really analyzed yet.
>>>>> How is this going to find problems? At least with the export option
>>>>> it is documented
>>>>
>>>> That sounds fixable.  We need documentation of module parameters 
>>>> anyway.
>>> Yeah I just took I don't see any documentation of module
>>> parameters anywhere for any of the modules. But by documentation
>>> I meant having the feature in the exports(5) manpage.
>>
>> I think I'd probably create a new page for sysctls (this isn't the only
>> one needing documentation), and make sure it's listed in the "SEE ALSO"
>> section of the other man pages.
>>
>>>>> and it more if a stick you toe in the pool verses
>>>>> jumping in...
>>>>
>>>> If we want more fine-grained control, I'm not yet seeing the argument
>>>> that an export option on the destination server side is the way to do
>>>> it.
>>>>
>>>> Let's document the module parameter and go with that for now.
>>> Now that cp will use copy_file_range() when available,
>>> what are the steps needed to enable these fast copies?
>>
>> 1) Make sure client and both servers support NFSv4.2 and
>> server-to-server copy.
> Something is already figuring this out... The only time
> the client sends a COPY_NOTIFY and COPY is when both
> mounts are 4.2. I have not looked into but that is what
> the network traces are showing.
>
>>
>> 2) Make sure destination server can access (at least for read) any
>> exports on the source that you want to be able to copy from.
> How can one server know what the other server has exported
> or access to??
>
>>
>> 3) echo 1 >/sys/module/nfsd/parameters/inter_copy_offload_enable on the
>> destination server.
> Who would be doing this? Plus this would not survive over a reboot.
> An export would as well a /etc/modprobe.d/ file.

You can add a line in /etc/modprobe.d/nfsd.conf:

options nfsd inter_copy_offload_enable=Y

to enable the option.

-Dai


>
> I can see the admin setting up the export but I really
> don't see the admin doing the echo or creating the file
> esp since the neither would is documented.
>
> steved.
>
