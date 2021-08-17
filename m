Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E663EF5FD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Aug 2021 01:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhHQXGp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 19:06:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24768 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhHQXGo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Aug 2021 19:06:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HN0vfV012074;
        Tue, 17 Aug 2021 23:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XqE2ZD3na0xwKxwEu30w2Kv/t9M3BBWGZt6wy3i75m0=;
 b=DjnbAWNQgLmbn3/h2MANNx7nUYijpj3Y1UQV6at2srar8NVHz9FgHfQEXAJo/N7etz/9
 sUN07e1AhEtN9bc5WMsHXqLRfSzHrH6qe9R6VPA4+AsPc3x38H6oSkr6Cs9QMbdQzwOD
 Zhegh8hIDuD8+VJ04TE8NzRrdrr5Ej1GDOARggoNa+PLXZ2sIbYUnuLJlScWmTuUcmYm
 sdCEpFy999DgYoucdQ6+xTYYW/uOcOGFkNdUQUrQ0Qkpm8o9m7qbcglsrt5Hkao1U68o
 bykDVTkBg9irCu44HGzC/rhJoQRPx11zn1cPK15sSclTB6onyoufsofFCQ8UkBUZpOVu cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XqE2ZD3na0xwKxwEu30w2Kv/t9M3BBWGZt6wy3i75m0=;
 b=CIAyNE7KZnWdbHFbtS+6S8sANFr1yrBHJFgjK314F1yahIQckEFILzpur2FoJ+P4DNSv
 6EM59tyeKy3C4cK51jNoLI0NZXsSknFVT7r4mzNfy09KOEZkr3S4kObo9PqasOWAZgOt
 UGC+sUgzjfNyPNXF2eG247YRraKrlWFjX2zArWt0wpTtQlRQC+1IBW0ReLwoRJ/JFL6I
 Mk2KYaPaLzgpaqhxzxx3fQ8sn3a7L51bAkcW3zb4zAljJoECWoJaFvmUZ8nJu4z9MXzg
 SfvcHzPrmSRiRz2reyKPfe455h1spCD2Qs64iPKAj2LsbZMhhH1UpkfRGM4tfyn8L9Xi Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf1fbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 23:06:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HN10TB081160;
        Tue, 17 Aug 2021 23:06:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 3ae3vgdpmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 23:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw3slCPlsOwVG6lhvQJ+a4Tt5V2ppusTflA3hqfAHL/6QSvw3S89C6JEDOw4mO3YwCQXSHX83djMs45SF1YzJbmutyg8txIo2t9V0ilDkJyR08MZbelmEihQ7v5vNBiqFjlfgwy4EvQJ8md/yhCnRwxxRIqNObxUwKLAKvchASi3G5UZZugXRTuGq/XZe9f0s/JU4X3Y3hLYNW4Si2cKD1UYpmbFKWGmml6I3jaV4zAb+DgBtLFDW6Q/eCLQhV42AJrXtvf8L24YGD7SfVg0we//2tlBgXWfjOQ7qEdrXEYijuv+vWr4gQsxqMWfRsCwvVVDb9xuKfFYTYolLRnCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqE2ZD3na0xwKxwEu30w2Kv/t9M3BBWGZt6wy3i75m0=;
 b=m46AJUDi7SkBO5ps9hDcqqVrQYt6EgNBlJgzoyf/MJBRcT2uEab6K0MEoEsc9hVek+sOAiX9xZs9cRXhdIci0X0vTs+Qy027wIZ5coVbNRmy2Bm5PBoVs6XdPQ5QyY1RdX+xBK6vfNvc6RN8zbMURdlVpZbwS1Mt6cnRnt7oTxCeHM/nFbMlbgx/NRCXfi1PKM6uaSwUnNEyDSUW1ukVA1TMbRYtHPWeOaVcdICqw74vPWHGKnQnMU+4HrhG5hLCOm1J3A0S3Xntj5n9Km/wlATwA53bi03fg+AjcIf3i2Oa33SXKOPdxKy8gGNTyWSFnNdmjYIKEqaLKqSqMJmrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqE2ZD3na0xwKxwEu30w2Kv/t9M3BBWGZt6wy3i75m0=;
 b=YCyy0JwKl6485FhwknNr1ZbTOVERU3e3s3XUQlJ/G97vaGISCwpLEVl7klBs0N2SzAV/VtgmIr8YYyGrno8fqhxz4lK3ebuBNjFtbvLYaKTSd61Jqep8KPAPNv3w8G7tMQAlAGdsCA8AwWbxW+j+GzPKbaxXWxInZDgfg1DLoig=
Authentication-Results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4033.namprd10.prod.outlook.com (2603:10b6:a03:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.20; Tue, 17 Aug
 2021 23:06:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 23:06:01 +0000
Subject: Re: Spurious instability with NFSoRDMA under moderate load
From:   dai.ngo@oracle.com
To:     Timo Rothenpieler <timo@rothenpieler.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
 <7B44D7FD-9D0F-4A0D-ABE9-E295072D953F@oracle.com>
 <97fe445e-6c4f-b7cf-fa39-fd0c4222a89e@rothenpieler.org>
 <baf4f3b0-6717-8e3d-efd5-fa471ae8e7e3@oracle.com>
Message-ID: <94a7f911-84bd-f250-526e-054649a00f23@oracle.com>
Date:   Tue, 17 Aug 2021 16:05:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <baf4f3b0-6717-8e3d-efd5-fa471ae8e7e3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:5::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro.local (72.219.112.78) by PH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:510:5::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 23:06:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d86a176c-ac6a-4ff5-dd7d-08d961d394f3
X-MS-TrafficTypeDiagnostic: BY5PR10MB4033:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB40334A6945187FFDAE0504D587FE9@BY5PR10MB4033.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yh9zyBOrk4BkCBB1EiJHkIrNzDDr+9C7NZGOTW4IrRFvN4vsFVfSS9DVZ/1KrgL4js26SNie6cQdhDFEhbD5Ab/1tErk4izNOQbJdEH6OjRwjuLYB5U0JO04yubyLF3O+Q3OZyDFcGfuJa+kvSE0mP1ho8kXeKcQt6PsYCYkM7jEPhZvHP+P+XXZhnCKfLAEE+J2LqIUYeJFfwwF0WA4td1PuXdlJZp/VomHpKo7AkMv5d2lM4aFlr0/XKiOx5ZqzDgCYE6N1aZkP1g64NPz7EQTyEa8ZR7Jfv5zCb8vxWymoZlG5KKJCoM29EvdqyTx95MAI/ylak6cNSsttoQdkQcKLcxzkjMfChO7QQMxtp1F//fSRXRhMmXuB2sOdnAOiwER3W9bJ673dReSQUgcLM9DuWm4v8+ehYLBlpU1w6xvo8LqcprOTsj0o//v82wWMQO6ApmDn6MZoWaA0ncK1vX6SNcvjVwSSBqI+fqusAJWivdCnmb0+fiNHqES3SKyfpMfKQV1BfHBxtNookfT6+kur+iYrOoOAce9NmrlJwM+TkiKTUXAcPA7XXmBBTwc4kLhdlqq2ElrnuWcPNUg/Q5HMonX3I+AZDhAQ3aDrOsfjn5KMm0VHBDYA4kmMf83VuJeMayBujlc8JUGb6BvMJDDsCm59Pm0IbvgZOdz9U+edfXGUMPNtAYEcZXB4beAYJOri4WyxCoM3M4a8l6s5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(66476007)(31696002)(6486002)(4326008)(478600001)(2616005)(86362001)(66946007)(956004)(66556008)(9686003)(6506007)(26005)(186003)(38100700002)(54906003)(53546011)(36756003)(110136005)(8676002)(5660300002)(316002)(8936002)(31686004)(6512007)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBFK0lsUXpIZ2kxSXBUV2VvMmV0ejNCMGR3ZFFDLzNOTzRtcjVOWjkzV003?=
 =?utf-8?B?R3dydUR3RTRnS1JwZkhPNXJQdWc2dGVKNmJBSFVnVURpNHQ0K3ZJOG5BVzAw?=
 =?utf-8?B?ci9aVSt0dWxuTmlVd2dTODZkL0VYcWNGV29pOE9wMXEvazdTOUlRUFlnRlBQ?=
 =?utf-8?B?T3MzaTIxODY5bGNvelVOeExIK0d0dk1lbUxQNkwvT1h6ZnJhWlJNdE13N3Vl?=
 =?utf-8?B?TUlrSlFUczZ2eHE4ZFdPZSt4TVFkVWM1aTRDYmFpa3ZwY3B5bGlBdWdZbjY0?=
 =?utf-8?B?V3JYd29ZdkhVMEtqREJucHhHVG94RlNsNU5pT1g2QkdDR2s4UGloSStMN3hs?=
 =?utf-8?B?ejFZSm80Z21EdGFJWE1GWFY1Nm9wR2tRbUdHWGRvdDk3eXZ1enRVcjFQdFRn?=
 =?utf-8?B?aGU3cmVLTXFyYk1IdjcyL1VxdlBuZ1VweXYwd1oyMkk5QlF3cUM1OUhNdlMy?=
 =?utf-8?B?YlE4ZUlleitUdmhzRnRDZWpPV3p0c0ZiSkJ6M0lOcDczWjRkT0laeEM0UVpi?=
 =?utf-8?B?OSsvakpZL3grcDNkM0pnUWk4KytiNVF5VUxrbjBxT1JMbnBMQk5NSW13anFt?=
 =?utf-8?B?bjZWVm9UUDNvRmhZWVJIRjMxTkEzYUVGalFUb2t0SUF6QzMyRXhZczQ4QmJB?=
 =?utf-8?B?T3NxQjQyTlowNk1YbURpelZyZ2ZTNElLZWp1WkVrSzRzc0dvQ1QreEtDRnRD?=
 =?utf-8?B?TC9uaXBvdWdmOHdERmtXUXlkNm1lc1dsQUtYV3RZM0hIdTJqUjhJOFNicFoz?=
 =?utf-8?B?YlRNcUNoV2RoaVZuTmM4L0RPZm11MnpPWUVqMmlhRGN1ZjlqR2F4TGJUQUZz?=
 =?utf-8?B?Mm5takxhT0JReUd3czVFZWVnYjhicWM5T216cmRRNW1CU2dsa3ZKb1NhK1dO?=
 =?utf-8?B?dE5OaUVpZDhwbzZNdzVnNUt4U3ZQOXlKU1Ivbk9zN3E4d1RxeEtNblZUOEVX?=
 =?utf-8?B?aks0VWIra1J5c2FrRUdrWkZHbGR3bi8zZ0poMis1bUJBZWRJSHNVWE9pNDdO?=
 =?utf-8?B?ZW5IK2NKZ0RzVFJvSmVSZWszWmxYWUZUUFRCWmJXNVVlTHh5U2Mwd3A2cjFY?=
 =?utf-8?B?Tmg4NUdOOEQ5aUZ3Wm9nd2pSM3ZJN3E2UjFGamZSNEpkbm9YMGgranpYaHkr?=
 =?utf-8?B?Z0tDZExTRXlmcnpUVlAxeGFzcE5BbkxPWUVrRTdod012T2lvVDFMdXZNSENp?=
 =?utf-8?B?YlNTZDBtRG9wTkl2V05PWGJIdVdvNzhmUUgvcm5FNHV5emE4Zk82SHpZK0ZY?=
 =?utf-8?B?akwrbXgyMm1BSlFWV2cxeTQxa1hHN1dROTNVOVBHWkd2aTAweW9DZ0V2WTlw?=
 =?utf-8?B?dnZKcjFWNGV0TzN2MGVpbnhFQkVEWGFXTDVDYVA5K0t3STBkWXJOWGhXRXBB?=
 =?utf-8?B?bDdyNzNkSTAwd2RJbThjZzFNcXdydzVZczVRWnZ0RzBURWdRMEtMMGJjbUFZ?=
 =?utf-8?B?YWY3VmZRV25ieUk3c3Y3UUwvYXVRME1lREJsZzE5QnlOTW9VMDhUbkFDVHdz?=
 =?utf-8?B?SG9pb0JKK0VDeXdQR0VvVENObGtEVXgwOGllUmNjQ3lrOVZ1SmZZUHEyNFNN?=
 =?utf-8?B?YUE0S3dUek1XaUg0UDlpbXVPeHNUZURqWXBnV3RkQzk5YlRyaHpscjlkZGEr?=
 =?utf-8?B?Y2NWOXc3TXY4WEtSSHNJczJ1T1ppejlid0Nwc0dIZnhUMG1HdUJmRjJ0ZTRr?=
 =?utf-8?B?V1VSYXViaXVCcmdiWmtQWW5lem9CTktVMXpSTmhWVWh3SnMreXFXVUFQOUtP?=
 =?utf-8?Q?rpMEDV3i8P07lXrBLO2tHG7M++6Bpq9E5gccteK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86a176c-ac6a-4ff5-dd7d-08d961d394f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 23:06:01.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLT8ZymA01c3J8FNHz9xz84iilz7O0vZMy8+1Ok6xUwJYRKU/dPm2Y13fMS0y7AgCakAOZz647RYaeaVVW4yfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4033
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170145
X-Proofpoint-GUID: 4AjQkVL49oaMVF8rSkIfeZSyEhHRQOI2
X-Proofpoint-ORIG-GUID: 4AjQkVL49oaMVF8rSkIfeZSyEhHRQOI2
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/17/21 3:55 PM, dai.ngo@oracle.com wrote:
>
> On 8/17/21 2:51 PM, Timo Rothenpieler wrote:
>> On 17.08.2021 23:08, Chuck Lever III wrote:
>>> I tried reproducing this using your 'xfs_io -fc "copy_range
>>> testfile" testfile.copy' reproducer, but couldn't.
>>>
>>> A network capture shows that the client tries CLONE first. The
>>> server reports that's not supported, so the client tries COPY.
>>> The COPY works, and the reply shows that the COPY was synchro-
>>> nous. Thus there's no need for a callback, and I'm not tripping
>>> over backchannel misbehavior.
>>
>> Make sure the testfile is of sufficient size. I'm not sure what the 
>> threshold is, but if it's too small, it'll just do a synchronous copy 
>> for me as well.
>> I'm using a 50MB file in my tests.
>
> The threshold for intra-server copy is (2*rsize) of the source server.

The threshold for inter-server copy is (14*rsize). This restriction is 
to be removed in the next merge.

e-Dai

> Any copy smaller than this is done synchronously.
>
> -Dai
>
>>
>>> The export I'm using is an xfs filesystem. Did you already
>>> report the filesystem type you're testing against? I can't
>>> find it in the thread.
>>>
>>> If there's a way to force an offload-style COPY, let me know.
>>>
>>> Oh. Also I looked at what might have been pulled into the
>>> linux-5.12.y kernel between .12 and .19, and I don't see
>>> anything that's especially relevant to either COPY_OFFLOAD
>>> or backchannel.
>>
>> I'm observing this with both an ext4 and zfs filesystem.
>> Can easily test xfs as well if desired.
>>
>> Are you testing this on a normal network, or with RDMA? With normal 
>> tcp, I also can't observe this issue(it doesn't time out the 
>> backchannel in the first place), it only happens in RDMA mode.
>> I'm using Mellanox ConnectX-4 cards in IB mode for my tests.
>>
