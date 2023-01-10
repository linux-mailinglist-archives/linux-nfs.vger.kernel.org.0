Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B4664CE2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjAJT7K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjAJT6x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:58:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4CABC98
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 11:58:52 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJoNxG031340;
        Tue, 10 Jan 2023 19:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=N8KgbBaoRBFk9QpgzjbQWOBS8EeP1ZoO2W6L7znHqa0=;
 b=JETBmGja2niEc/odLcmUbsh7yoAp6MP2aPbrWp+ejorysecSMWMRKUfe/Rw8ecTJaNQO
 x6BA1kImlhzfUOZrjJaASY/XbJXxyaFjiJ16Kr9wjjXtBaIx5RVMyB/EbDewqlkMq6sY
 Yb4VLKWoaPB7HpWzcuMlvmqJaVLa5zXs7iNVaJqT6Y7IRuHjGf9oaeDoDd933HWLOePl
 LwB8CHATm9Y2i+vX/gQVuS/w3wd2oIgry4Wy+bRTSIcfut5taOVS4XOQxOwuRsKbUboD
 LlhqpWSGBjVlLQ6VE3NX9ZzKPxk525wTaXS/u/UXc/QRnBENTlMcGY1LzUW7m5xji6bE ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btp882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:58:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AJmhsY039578;
        Tue, 10 Jan 2023 19:58:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1egm0ck4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7+sP2uidH1Qi+Pv1gayq7E9jqC10YDACKd82gSFfivhgm80wl5B+CSH+C96qClSyxS3lyvep0sFpuq3ZHwSNCT9RgNzh2AkDuhWJ8W4BkCr3treBKgRC8WLsU5FYuI7O4jYLlrCyPjPrKOtXxCQ75AQjgLeJUeDp0HBjO/K0Hem8k/Y6O5zt0n4C+X7BkYzfO8QqovxZ3egxlufnnSIWl7iQAi1a3T1unoJk6zr9t3DNXMubiTsOh9c5c2D5niSxqlFEd7cJfCD5JMG+LCE2hfueoHEhf82FnN2tbkvXr6iTdpLZZ5ms/eaybUawwhAHXS23fXA055P/LKK+4d6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8KgbBaoRBFk9QpgzjbQWOBS8EeP1ZoO2W6L7znHqa0=;
 b=ZIYIWCyglsCsPGQH8w7T9To9QblP+Z4gYh/N9PQ4Z6wud8+lzskaHNcTKcHqdNR2SrWOVEA+0aRe0l2N4pp4gdZYun/WltPWSYvYZvBkClHxlAD0ar2RiB/khCkVwh4xVZY2Y78P6I+NHreIovWXLyvCdoiSHT1Qm12b6zUUiKwcjh/6gay+65NIIpdsqlP7rXtK6nwf72e9vkYgW7ptrBiu3HDRDQyJJQqF+wH6sml8hvlc8zMQukpAHkez17R4u6RAsDgNwMiTH7X9G7CYDhPAuMwGGwShsbjJGIBoKQUOA3b3IBSP+TUrl3+h5rqqRAFA5yuf7nW53Lw5Bly3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8KgbBaoRBFk9QpgzjbQWOBS8EeP1ZoO2W6L7znHqa0=;
 b=Bul4S48A4Pl5ssncASVNfpHLi8Rui/w03XvP94ahZpKbtoxaPvrkxkXJBWWsJaKax9pjnlntrIv7jTdGQyN447HNGb11ZqT+FpkNzD5hibMjR1/xt3ex4xXvlMW4/lNUmY2y71ayWKcBlUF0Hg+2Rt43Z5IbvQJ2VqZTzTfvWio=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH8PR10MB6598.namprd10.prod.outlook.com (2603:10b6:510:225::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 19:58:43 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 19:58:43 +0000
Message-ID: <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
Date:   Tue, 10 Jan 2023 11:58:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
 <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
 <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
 <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
 <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
 <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
 <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::25) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH8PR10MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b015c45-d884-4440-663c-08daf345139c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gz0PgVRVS+bUMm3S2i2wWq9t6YGRKCTFqgXDJvmweIfj0vLvdbgo+Yjtqq5xMMuDaCnuD98hjjIQR9aTCdRej+zeDSnoI0PQ3fG62dbgUr0xYVKvjpzPXgBwPUE1Y9/+JkbNOulwfDorvKg/NIfNcszUUDxcipe2/pbFI/liba86WdAxA1IbH2+ED2eGOEO6OuiLzu5jbjnYyGtYWzgCbIeC+iWZjnbM/ectTulU5HUf7zgKVg48gwEUE+v6X3dKWE4Vxtdd3usv41MU/VWO75yXXvTmy1FWkWWlezbXTvmTlZURAR6XGfz0riC5IwIa7+uS5shEt6SfI8mCNYKEdsImqfxEgSxFuafnqcABYJye43yTNXE4iGheXBUP0n1Lm6+nIOlloAtjg66ePl44i7UVTS55DawfoGiCBZCkqlfMAbRwiROT9TyeajALU794K8YzQiZlq3iMWfZ4qLHLXbaIzD52GyejoWRA9XAClNPVaesOGqj8h8NtH/aueVMKMSK0VSd3VED6ftysznnQ9BZg3B4zTwNvootMsnSe6rpdXqf9Tzw2VgVe8am9SWNXNiJAgXRP0PGQLZECiD9zLtievbRKeMk/NfliwPHcq+3NnLXF1uvnNxF2Bq+6k8elwktmGbi2OpO6IfcNfkYBnpkt/AUCJiaNI1SGBNKJh5YkpsQ17WRY5zJNxTjN7Xwv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(6486002)(478600001)(36756003)(2906002)(86362001)(38100700002)(2616005)(83380400001)(6512007)(9686003)(26005)(186003)(53546011)(6506007)(31696002)(4326008)(5660300002)(8936002)(66946007)(8676002)(66476007)(66556008)(41300700001)(31686004)(316002)(54906003)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFQ5Qi9ZRUhTRVQ5QkJrK1VweFd6bThlcExtOEsreHZjUXZUUDJ5V2NtM2Uy?=
 =?utf-8?B?YU9TcmNkK2pJSi9yaERUNE9aTTZBd2Vlb0VvUHR3V2orbTZqU1RoOVVrZm9p?=
 =?utf-8?B?UnZ1cGMyV1BYK2x2OU5hc0JFb0FpZk43QUpWSmw2emhlL3BlQ0lzc0tacGhu?=
 =?utf-8?B?a0EzN0RNVUxjRnlXOXd0c3RiSDIrSWJJUDBVR3l0UHk1U2MxaUFkQk9wSXZE?=
 =?utf-8?B?MGl6b2lDTU9PUVE4bEFlVVFIbFNQR2xuSHhqVDBKdk9qbUVuZTY5eE5lZHZm?=
 =?utf-8?B?WEtmM3F1SHFsdmFLOGQwa0I0aUQya0l1WWRMOHB4MkJLcFpJZFdIK1MyNWE2?=
 =?utf-8?B?ZlNidnlnWVlEbklBZUorc2gzQWY5QmhaOWJia3cyY3puWnMweUFRcCtlTDRp?=
 =?utf-8?B?YXg1TXhCM0U1MWs2M2JpcWNpQkhSZk1uRzhuQXBBWG5FdkpndmRVM1Q5cDFu?=
 =?utf-8?B?cytQVXpwb3BTZkNLeFFyREU1aTJsZGdTOWMrSzhWbTZQZTQ0cmdqcmRGTHJT?=
 =?utf-8?B?Sy83TUZKUEUwUXMxRklvV2dRaTg3eXdwNTg0MHhJZXVQYk85bDE5eTVQWUZ6?=
 =?utf-8?B?WCt6YVg1WXMzNXhWQU1YQmh0SUZkNmc5dHlNYnpKcU9uV1p1SVc2alVMbndC?=
 =?utf-8?B?ZTJOdjU2dUNWaWJEelQvOVE2ZjFGd3cxSEpMZ0JCa3dtZyttbm1VSXpjWFlp?=
 =?utf-8?B?UTVlbzl3ZTE3NEJCOE55YUM5ODNyVFRlcUJHK0grQTU2ZmtRMlNRUTZlVFdI?=
 =?utf-8?B?NkwwZW1pNHdSOWJwVzgxaXl1a1pyekdndHRtbzlTL1FNd3VZUkk4cVZ1UTBl?=
 =?utf-8?B?ZjFxdEFPdFpCRldoQmpsKyt1cVNTSndlZGc4WmhnYktlTkR5QzU0Z0FDYzBa?=
 =?utf-8?B?Ump4dWlqWmNTUHJ0bDNwQVdKYU1PSWtvZlhGNi9qSUIxTGN0cGJOUFFlNVAy?=
 =?utf-8?B?cGJLUkozSXQzMlMrR2JjUm1URS9PaWtiMjZDOW96N1Zmc1dwSmI3R1ljdTRv?=
 =?utf-8?B?bE5UdUl6TnpMY3Z2aVZVOWlpenJkRUNzbFBMakM4TXpYTzAwSWp4VitYMjhq?=
 =?utf-8?B?NDcvSXlIbVVwZ2p1RTVrVG1uRWhhSFZuK2pOWDVCeEhsVmx4RHg3S3I0eVZ6?=
 =?utf-8?B?UWE4WlpxeVhObmp1MTVIOWNGdVl5UG5rU3RrVVRpa1lUOEF2TDJIdEFyMWFr?=
 =?utf-8?B?clZkdUxFRXZmSXluMU1kcE0xU1FCT0VHdDMzWHNkZ3hGcVlmTjJUdWxIRlB6?=
 =?utf-8?B?RmhDNkRRejdPak9Wd3g3VHFaUUkzNGl6dWdMdUtiNHA0L2FGdk9wdUVpQy8x?=
 =?utf-8?B?SjdyQ21BN3ltdkxkeHJHUnZQY1F2ZU05WGpHS2xaOU02SkhqcmtjTERoK3N2?=
 =?utf-8?B?UU1EeEJvYjZibjV2TEFmd011UEFqeGdtYjBDZlRtcVlPa0ptSVJ4S2FlYWVP?=
 =?utf-8?B?Z3hJa0ZnS3BxbzYvRTBMWDdGZEZQdHEvRi9MSjVGaHZhM0VRdHF1OUJmK2xG?=
 =?utf-8?B?TGF3endKVjE5ZFZRRDhqQ2MwQytoMkNUaEJFSlJjNXRBU3ZHdFJDd2YyZWd6?=
 =?utf-8?B?NXpaV1pDNnIrVitvZDllTXVVeG5ndTQwemlGWm1SOVBJUktHVmNiNkhmQkd1?=
 =?utf-8?B?ZGgxbXJsajFkcGlManJFY0RyaFNpcERad3RiOHJsZXEyQmpORWVrN1IvMU9D?=
 =?utf-8?B?MWRzQVRIYjZ2ZVBhQXVpL0QrQXVpM21DZUJMQW8rbDErNG1iQS9LSVVkUGpa?=
 =?utf-8?B?THhpVW9Kb1A5THR3Nnk5bWpMZ2tCMFpsVC9aZUZwdjQ5UnNUajczZFhodVJR?=
 =?utf-8?B?bDcrMVIyZ2g5M2NRMjQ0SFRRVUtsc0EvbCtwN2xiK3owNUh4YnlnYjNLRGh2?=
 =?utf-8?B?VitqSEhxSGxWN0tmVlhvSG5oRm8rTUcyRjVyQVI4MWdITFZ5RjNjeGRRZEUz?=
 =?utf-8?B?L0VwekV6cWdjZkFOYkorM1ROQXZXdnJ0ampPR1MvKzhLMURmSHRVa0RiR29G?=
 =?utf-8?B?d0EvVTRjcTJJZ2oyNjFhelRpK0cxSGpsNjJGcFRTQmZPYVpBTHg2Vk91WEts?=
 =?utf-8?B?dTQrZUxLV3JOVDJVQWxTUzhCbEVYaW9oTzRKT0VZTDVNL0NxblRSSCtML3Fk?=
 =?utf-8?Q?qhogjJu1x7lnmlb2T6GbRZfLO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IfJjlQE2ebvP35fbPDNy+nOQqPzCDPEgalsf6NY4QtKeRI7YrnDW1lG2II5k9pDC+yyxE+fFzMyxhc3NWMsO20J8rVnEP31bs+afnzOOiA/xbXYxpJftX9Fwvvj/cf6M2I+dr+rVBzU2CnmztqFkdgJPTbzWxHMopf/4eNfsDQ/a70CU2T4FZ3/GrnvsQtW9G37+IN7+EJB7fqz367RWePKyHknp6rUMsnaPBunduvxSHM398Jan/VruVbXGJPodslQ7I16GdXdRBw+dNu7qukUxchRZI1anGXUf7joHBKch8KGp/XRn+Sd5c72UeUh/PKAinp+Zf363YF90rVx9qvt/gmkrQHMKVjK7QZtULMgl81ECQO5+xz7+3dRuyDAfdFK48R47hzlCQK5DtQAupvSGg3/Cq1rHOYLGqAaJ0K9kE0qlnxsMDxZjtUT7z8H+V0XGZLTgVCWI3N+ultmWnbSjc3dj+oJQjvfeOX7WGnQIMuq+7Qq290IltXv49VyfvIR77JLLiKME72ZkD5xdbSulp3LkyHu1EgknHJYLXUtJ/+X4H7mgrWblnPBQx8lDxltuA6IcOTemGYKdWd1mHvXtYBw9LJRvPoZ2e0b5TGY/lRsh2tiYeyAeoPgWoShfHg7ti4Yem9fc2v3P3ucecOp+9AO/7YOyIAV3HQb12+aFgzcpptsnt7CdUiOJKohtSehnts9UtPBj6Nba7zuNU8ZFazcCEXf8rafhX0DRhReS6OlwuH58K8TRe2DWt4vO7H41S7gUAC2Crduzv4/oVgRzi5nUODNntTj7M4NF5BaJVSPpSMgOKWfTNi/l6fBC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b015c45-d884-4440-663c-08daf345139c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 19:58:43.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGfKuRPJOxC/ExgxnubeT/zis+xIWZKaHWMHmqCslrwaO43ss90rF/eNRu0ewen+hvsSGSzfRjG3BGf3Gcf3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100132
X-Proofpoint-GUID: sX2s7C0y7y4aQGNTem8dR8drhOCasv8M
X-Proofpoint-ORIG-GUID: sX2s7C0y7y4aQGNTem8dR8drhOCasv8M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/10/23 11:30 AM, Jeff Layton wrote:
> On Tue, 2023-01-10 at 11:17 -0800, dai.ngo@oracle.com wrote:
>> On 1/10/23 10:34 AM, Jeff Layton wrote:
>>> On Tue, 2023-01-10 at 18:17 +0000, Chuck Lever III wrote:
>>>>> On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>
>>>>>
>>>>> On 1/10/23 2:30 AM, Jeff Layton wrote:
>>>>>> On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
>>>>>>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>>>>>>> from nfsd4_state_shrinker_count when memory is low. This causes
>>>>>>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>>>>>>
>>>>>>> This patch allows only one instance of nfsd4_state_shrinker_worker
>>>>>>> at a time using the nfsd_shrinker_active flag, protected by the
>>>>>>> client_lock.
>>>>>>>
>>>>>>> Replace mod_delayed_work with queue_delayed_work since we
>>>>>>> don't expect to modify the delay of any pending work.
>>>>>>>
>>>>>>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
>>>>>>> Reported-by: Mike Galbraith <efault@gmx.de>
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> ---
>>>>>>>    fs/nfsd/netns.h     |  1 +
>>>>>>>    fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>>>>>>>    2 files changed, 15 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>>>> index 8c854ba3285b..801d70926442 100644
>>>>>>> --- a/fs/nfsd/netns.h
>>>>>>> +++ b/fs/nfsd/netns.h
>>>>>>> @@ -196,6 +196,7 @@ struct nfsd_net {
>>>>>>>    	atomic_t		nfsd_courtesy_clients;
>>>>>>>    	struct shrinker		nfsd_client_shrinker;
>>>>>>>    	struct delayed_work	nfsd_shrinker_work;
>>>>>>> +	bool			nfsd_shrinker_active;
>>>>>>>    };
>>>>>>>      /* Simple check to find out if a given net was properly initialized */
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index ee56c9466304..e00551af6a11 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>>>>>>>    	struct nfsd_net *nn = container_of(shrink,
>>>>>>>    			struct nfsd_net, nfsd_client_shrinker);
>>>>>>>    +	spin_lock(&nn->client_lock);
>>>>>>> +	if (nn->nfsd_shrinker_active) {
>>>>>>> +		spin_unlock(&nn->client_lock);
>>>>>>> +		return 0;
>>>>>>> +	}
>>>>>> Is this extra machinery really necessary? The bool and spinlock don't
>>>>>> seem to be needed. Typically there is no issue with calling
>>>>>> queued_delayed_work when the work is already queued. It just returns
>>>>>> false in that case without doing anything.
>>>>> When there are multiple calls to mod_delayed_work/queue_delayed_work
>>>>> we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
>>>>> the work is queued but not execute yet.
>>>> The delay argument of zero is interesting. If it's set to a value
>>>> greater than zero, do you still see a problem?
>>>>
>>> It should be safe to call it with a delay of 0. If it's always queued
>>> with a delay of 0 though (and it seems to be), you could save a little
>>> space by using a struct work_struct instead.
>> Can I defer this optimization for now? I need some time to look into it.
>>
> I'd like to see it as part of the eventual patch that's merged. There's
> no reason to use a delayed_work struct here at all. You always want the
> shrinker work to run ASAP. It should be a simple conversion.

ok, I'll make the change in v2.

>>> Also, I'm not sure if this is related, but where do you cancel the
>>> nfsd_shrinker_work before tearing down the struct nfsd_net? I'm not sure
>>> that would explains the problem Mike reported, but I think that needs to
>>> be addressed.
>> Yes, good catch. I will add the cancelling in v2 patch.
>>
>>
> Looking over the traces that Mike posted, I suspect this is the real
> bug, particularly if the server is being restarted during this test.

Yes, I noticed the WARN_ON_ONCE(timer->function != delayed_work_timer_fn)
too and this seems to indicate some kind of corruption. However, I'm not
sure if Mike's test restarts the nfs-server service. This could be a bug
in work queue module when it's under stress.

-Dai

>
>>>>> This problem was reported by Mike. I initially tried with only the
>>>>> bool but that was not enough that was why the spinlock was added.
>>>>> Mike verified that the patch fixed the problem.
>>>>>
>>>>> -Dai
>>>>>
>>>>>>>    	count = atomic_read(&nn->nfsd_courtesy_clients);
>>>>>>>    	if (!count)
>>>>>>>    		count = atomic_long_read(&num_delegations);
>>>>>>> -	if (count)
>>>>>>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>>>> +	if (count) {
>>>>>>> +		nn->nfsd_shrinker_active = true;
>>>>>>> +		spin_unlock(&nn->client_lock);
>>>>>>> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>>>> +	} else
>>>>>>> +		spin_unlock(&nn->client_lock);
>>>>>>>    	return (unsigned long)count;
>>>>>>>    }
>>>>>>>    @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *work)
>>>>>>>      	courtesy_client_reaper(nn);
>>>>>>>    	deleg_reaper(nn);
>>>>>>> +	spin_lock(&nn->client_lock);
>>>>>>> +	nn->nfsd_shrinker_active = 0;
>>>>>>> +	spin_unlock(&nn->client_lock);
>>>>>>>    }
>>>>>>>      static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
>>>> --
>>>> Chuck Lever
>>>>
>>>>
>>>>
