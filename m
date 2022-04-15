Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E257502D02
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Apr 2022 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355262AbiDOPjn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Apr 2022 11:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356230AbiDOPjW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Apr 2022 11:39:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578853A702
        for <linux-nfs@vger.kernel.org>; Fri, 15 Apr 2022 08:36:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FDv9dK028053;
        Fri, 15 Apr 2022 15:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iz0lK/0MZvwnOB7DvYYZbNQvNAPDmyf7Yo8IdV1OC6o=;
 b=Ndcx88xTP+ZB8as7zHvvAWHtyMRji4h2jmE+weLtFGt4J7Z1tZyCMpgYOL9tyWv7xZcw
 vquLHmSBO6yWlFitSgaFi+KHo3R/jXn3wnSoXv54M45boshRADf3rwacuywJJ3IFem2G
 cgL4rFq8tf018qBmHJePErgk+TUlw++BWzEVMXUOzU3/6s2Li/LrYEawPf99CPw6eXTK
 gD5dniSVIvwP0PD76ZVCADzfTVKDpIjqGGCmZD1OnT0rAR03i1Zg+0WArKjEFZFd4+Xf
 m8mVqNtDGSdhdt+evyCnjSGwQqEBkjDYQ4eUDXUOYW8IA2FTKCYhUqsP8jLCJIqNOoMx MA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a6vqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:36:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FFVSRh015856;
        Fri, 15 Apr 2022 15:36:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k5scwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdF1eUKI2CFQEG5FLWVmEYz40gxGldkDKzWTIUy15tRF6iEtzWnFunGPpx1JEQ+o+/3ndY6JlBWbna8YE9Onv5P3axsGH0AF3gKcsul0/YckEc7nLkG6mhO18jN59931j7mtoBZSYhz9rrWgUyJmD0wz6W3v/rXvGo2A1eJnj87tv8RDJIy4hyZV2pbfTMMGD6AIJsxotRHCs+WsyNsT/Zn22/oXggxWweM8E3MlmH7yB1ahDWcP90FmqlRorzCmOSbEyeDqT4dNrePS3n9G4dxcp2piMGa2NXzFEVe69EPJTt6TD67NwZZqAJVBqCs+ixT1G+Pr7yi4w3lk57yM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz0lK/0MZvwnOB7DvYYZbNQvNAPDmyf7Yo8IdV1OC6o=;
 b=NBfGEatwVUDEMpsGbz+GZ4714HOo/8vTgni57UnCThUZdrDvU7+Zmart8ge3lkN6rlArpZT135Swoh2KPEBHUW80dXGoAaC3BmrAESAIVtxhACRe0EtE9dedKCmY6gvgotBeNR8IQgaD7cqVv43OwycwkSQa4x/DEqrcWK5Nb/iTFtcAs0CxWakw7yNQoPeoDbzYpO7sHpXarnry6IzD+YeCFYF4ecGt+gJzZOtFlq52w2r2YmKrUReSKWyWiNEPqjWz/WQAfXYYnru0CrvLlTTZHLoirA0qtwJJVl1ewC8zWYX74sTB0vtkgz3IAN6AJNvYDvQ6sgSLC9LewFg6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz0lK/0MZvwnOB7DvYYZbNQvNAPDmyf7Yo8IdV1OC6o=;
 b=vuij6xmeg/uFx/UGFN/yjuEKwy50sbcuWoUGVyKffiebFlC5FL6ZvL0DH7CH42dT8JjwMN1NmNwx/LvwP+kRlB86MvhUXPgeKiTBuisB1ihROD8He7m9DYnagKZWHz3slh29pwzgmyjpw8ZbZZtaowuUJ46FjsbC8AAz880hHvM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN7PR10MB2754.namprd10.prod.outlook.com (2603:10b6:406:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 15:36:48 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14%2]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:36:48 +0000
Message-ID: <845b09da-6022-2fcd-7a5d-13e9307769b1@oracle.com>
Date:   Fri, 15 Apr 2022 08:36:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
 <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
 <20220413125550.GA29176@fieldses.org>
 <fae06919-13de-9ebb-8259-108f6e18c801@oracle.com>
 <eaf758e8-077d-f7fe-1e02-cfaa49830d97@oracle.com>
 <20220415151959.GA24358@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220415151959.GA24358@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:806:121::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84aabd75-9c2e-4e37-7836-08da1ef5c15a
X-MS-TrafficTypeDiagnostic: BN7PR10MB2754:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2754C985007845E9140E9C0F87EE9@BN7PR10MB2754.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8jUCJktCGc/lrT1y3rrPTeP0xR+iYXaA4QMj7c2Y58pxVbLKrwdxJyu732UfagrAT7JTb7B9E5ec5Uu1wXP0MUiNQ42kUlxUXXdZU8wKeo4aQwx7IcBq8ZemNpcsOisMZKd2qGEqY5zoailkPaRSYWtHunShRUey9VWeBYTtLQ9PSpDL6RaPZZGhtrQQINOoBVCuI8JQdzHcNo7HED3WQ4yvlQm2EmNtEXyLNRtklRVBLKcyG2RHNtNlU5yzmtfO8rql+7dOyh0Wx7mji84ZZH7SmPNqccSUhtHXIYdQ++94ctN81xZnHUlJKbzeqSU4u8KeDQHlue37W6P9jo8vMpBHwKMOlP+T+nuzHQnbf3dTNwrmeedDV+OVWn1KbeRXqF01zyeZIrHidCZa3BFu+sNq8hxoZeAJ6lTSlU1sOpMQMUUiK9esHoqv2pAWI1jnh8CJy7z9z+3FJXAq1hesOvBKiZxsSUfUWX9XBAZR4if4m5fd7lFsZCSSAtppH2MXNrBBt5/+yHRfdnwa5PT31NqPdO6OFjom9QbHw3LmB71iNLnNRiCxhotS3lYcxFF6RYfWLOup20sI3lbW5vZ0mbLvvc1kIxLdNd4ey/AM/bOGPlZ3wO1SVW9EiS3k91MMDbStyyednxprCDiMpLg/Wagnu2NcEx5mmcZse7s3Clp7LpNJ+7ZcwhLSJzOTXE0DLmPzWkGXFpjmvY7pH/eMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38100700002)(4744005)(86362001)(8936002)(2906002)(508600001)(31696002)(6486002)(6916009)(54906003)(83380400001)(316002)(6506007)(26005)(9686003)(53546011)(36756003)(6512007)(186003)(31686004)(2616005)(66556008)(4326008)(6666004)(66476007)(8676002)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFB3MTVxQ29CWk1nbzNvZEFrTWZLODRINlJYQlllK0pPWUZhTVR2WW44UWZC?=
 =?utf-8?B?TDRvOXlRR3FSRmNSdHRNdmhlUnRiZTYydy8vcHBwLzJWNlVkYjQvWXNWaVRU?=
 =?utf-8?B?UnNUQXZxMmZTT3VBYkZhems4L0sxWGQrNDhqVTZ5N1d6UytsdGlrbnNaR0tX?=
 =?utf-8?B?TGIzNHE1RmZsMGgzeUswTWttZzdRUng1cnEyaUR6bWZKVk5IdEpJZWpOOUd0?=
 =?utf-8?B?YkZhSGZyWFlJZnR3bTRibWlFbkxYUDg3T3hiMUhKWll2aWRQcmY1S1V4dCtu?=
 =?utf-8?B?WWYzQlVHWEJrTUY5QmxPK0p2NDMrdjI1YncvMnZrTFJlcEJvNjVsdG1lSEhG?=
 =?utf-8?B?REVoTkJISDdBYy9MbUt5NUxKdCtqUEFXeUNyVjRvdGNEM3lXQWxZUXM2VVRv?=
 =?utf-8?B?c0Jpa1J1a2Y5WmRqcVJUWUF0MkFBVHlxQkRjWEd0R214MXV2T0pMTGV6Ly9K?=
 =?utf-8?B?Mm9JWmhySmYvRjBmOGI5Rm1GcE14OEl3MWpWTSs3TkNIazB0eW9XamVINHha?=
 =?utf-8?B?TDF4MzRraStudzJ5ZnltU1UwTTlLOThsSlZObEk2MDY1cFNIbGN5cGF3QnZx?=
 =?utf-8?B?ejVTRjJjOENVNFUzT2VDNEVMTUlXVG1oR290VDA1WmtCZ3pLd3hvL2ROYTc2?=
 =?utf-8?B?a1V2NEFrOGhjclBESDloTTVpT0VJdnUwVVl6MCtvMXNyemhSVmxSeFVmeVhy?=
 =?utf-8?B?Rld4QUN2dUlJZkx1ckpyUnNWdVhROTRGYnRGbTMwZ1pLazVCQnBPT3h3MTRQ?=
 =?utf-8?B?Q3R0SEpjSGIyc0JScEEyV1VOUFR4eHdwNkhFU2s3Q1QrRy8wWS9kRWJuRTRL?=
 =?utf-8?B?ZlZncmdMVk12K0dhT2oySy9VRnJDSlRra3RQcThpV2s3b295VHpCcVpwaWs2?=
 =?utf-8?B?WDJNVmpVazZKVkhmd3d6cnlycU5WREJGRFZJTHJhOFlma1pmV2dNSUlmcEtx?=
 =?utf-8?B?bW5rT1F6ekNtSjZMWFgvNVJ1WVQ3cm9EazlPVnMxNEd2eXcvTVhVejdwRGFK?=
 =?utf-8?B?VEl3OUdSTURIcitXT3hNTlNYMlYwMXpkdVdXUzZrT3VDajBBM3N1VytYSDU2?=
 =?utf-8?B?SU1oWHQzNXdZNkVMVGJxd3R0aW1BdXpIenFRTExxZ1E0Zk54alVOL2lIcjhS?=
 =?utf-8?B?b0U0MGRzZFFrTnROVWJ1TjVFTGx5eXJMNElpRERLNFNUS0xmWmtlSXJGYmxl?=
 =?utf-8?B?NldyaEMzNzExRnVBNk8rZCt2TTgxZ2hSNDR5V1kxR1FldnRjejdHK0pERzFR?=
 =?utf-8?B?aFNFUFoxYjNHaENVcVQxZmh3dGNmNWhOcVVTb2JGZmdmV3lqakF3dU00SkVE?=
 =?utf-8?B?eElMZC9uY2NFQWFOMkd4QmJJTjgxV0dYaldLbkZjK2h0WVphYmJqSm00R25z?=
 =?utf-8?B?TXlqcjEreGozTG5sZ0V6UmRISkdIbG4zV3ZLdjJXd3M5cDY4RWFCY01zZmNJ?=
 =?utf-8?B?MVpQN3Nyb2EzWkpEWkpab2ZXSEo3Y2R5eVMyNGt2aUlRZG5Rc21VZGQrUnVi?=
 =?utf-8?B?L2h1MC9qdXdyY2dVb0NoTFhTTkpyWkJiOHk2ZFQyMlJ1Ym9BNGIwRmduZytW?=
 =?utf-8?B?djZtNW5EalV2THJKSXArY2JOS29QemZGSkV5VEhGTVlLQzIycWZmSEpFTktP?=
 =?utf-8?B?dHZxdGVwZUFJUFZaRkdYVWVoYmxUMTg4NzE3NCtSMGFwWmY2WnI3dFh1UU9N?=
 =?utf-8?B?MkoyUlAxTnNVbmt3OW1INklrZDFXQlkrbkFJTHlDcjR1M2M0cEQ0UG5mNTd3?=
 =?utf-8?B?TFk4NHZDanhRSURMZWtEV0liLzJHMHJndTNjaXozUzhSWFhRWHZVWUR5M3dY?=
 =?utf-8?B?RzVBWDJVNXZLVjFhQ1Z0cWVPc0hkTjc4L2l6SGdBaUl2Qld5R1hBMGhGekMw?=
 =?utf-8?B?WkdmUDF2TmRCdFVtb1d6TTZSdnV2bVBjNmFoblJtd1RiYm9wMVdRNVo2c2Z3?=
 =?utf-8?B?bG00V2srdDRPVEJqRm9oaWsyWFgyZXRIeU5YMzI5UWtHTkM5SU5La1Q0N1Fv?=
 =?utf-8?B?bjhEeWYyVGUxbXlpZitQVEtJTkQvWlFGaDRuZXRYeEZ1dXEyNUlCVUtodTAy?=
 =?utf-8?B?Mi9Ec2hSazhBQTd2aVRaSTNmTktMaVE4c0NOWUo4NUdTMDZpSVExeGZaYXZM?=
 =?utf-8?B?cThianhNQWwwZGpxOVRRSGFMbTZRdVRpYUZ3ejZneWl2UWpibUY0OFVoRkFK?=
 =?utf-8?B?bmJid3RoSFhQYWFXckJaUmZ4Y1JYaHFDZDZLb3ZqRW43YTQwY0d3Mmp0cm1Q?=
 =?utf-8?B?dVRGdHJmNGlVVzJway9tTDY5N05yYWNzWXcwR202ck5qVERkdDBTbEFYUVpJ?=
 =?utf-8?B?c1ZDdCtkc2h3MUd6V3lBM0hXaWZ2cGNIdUNsa21EQXpIeXdOYzhqUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aabd75-9c2e-4e37-7836-08da1ef5c15a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 15:36:48.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQJiwMkiJ9HPNWffCY8axk1xQyyLs2BX0I4Wa67x6OJvtzGniqtwRvIEd4IWaqyRrFt93Lak99vx+P82QV+fog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2754
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=982 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150091
X-Proofpoint-GUID: zKuc0DnDbIqic8ERGsH1dxdMzM5X5aJj
X-Proofpoint-ORIG-GUID: zKuc0DnDbIqic8ERGsH1dxdMzM5X5aJj
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4/15/22 8:19 AM, Bruce Fields wrote:
> On Fri, Apr 15, 2022 at 07:56:06AM -0700, dai.ngo@oracle.com wrote:
>> On 4/15/22 7:47 AM, dai.ngo@oracle.com wrote:
>> >From user space, how do we force the client to use the delegation
>>> state to read the file *after* doing a close(2)?
>> I guess we can write new pynfs test to do this, but I'd like to avoid
>> it if possible.
> Right, this would require pynfs tests.  If you don't think they'd be
> that bad.  But if you don't want to do tests for each step I think
> that's not the end of the world, up to you.

ok, thanks Bruce. I'll leave open state alone but don't do anything
with share reservation yet until patch 2.

-Dai

