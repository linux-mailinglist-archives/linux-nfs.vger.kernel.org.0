Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5394A69B257
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Feb 2023 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBQSWl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Feb 2023 13:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQSWk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 13:22:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65910582AD
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 10:22:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HGPm7a017268;
        Fri, 17 Feb 2023 18:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GrOy9bZKDqle1Gb1shGxJa5fEpQKzs5jaHcrxNpqSiA=;
 b=KGCWpK1Iwc/cuf9leA0EUs0lTuAefqidt/n1Ay4v+/JZe6LOqRk+zhwU3E22ND7mnGBk
 0lntBwtZckg60INUIBQMlxlsxDG6P3nyQQbME1/m3hY+UnSutpiRp0ucyfXVxFktXR6x
 E/bADEv4qejSS//+LXSJHlcxl6PzwfIEisk0X/66s/gNnTxNPlBrcRz90LygbIv4IYSo
 Y7qK2eOu9gBdrs6Zs7ThpKmqVJlA7lUbtEzcoyGoSTj6RBV7or/fSYkLuhowuyFN6f3X
 2IeSdZsNTVj+k+7++pn63l8d6G93vmVdxcth7icBxQiejp3AVo9Gbhlm6Wl9ABP4neLx NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2wa6nhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 18:22:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HGbKvV013825;
        Fri, 17 Feb 2023 18:22:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa406y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 18:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5ULErP3bgjf8zj7+yfNSs01h9YnU6m+YrUaBsFzetJb18xa4spyTPTfFZPJXpHpDaC4vHePyBtx7RIjmYhNduDuT8m3nU5Q7zZi7Ytnp/B3oDgCy/qKv2FfAWBuimoFDHtskoYt1nu5Cs+/+2H+GMD5FBUxWK5I93CuL8KVQiJJtdALeCR05mQuEbMDa5OJTJOj6z7HA0xPrEtmLcbuuc96IoMsPXnP5WZ7QvO3VXqq+kss9DLn75Q9SXnKQg44HFBEcoIMfEQ6MYalgcIWG3fzDZjTrKApamQxWcNK0a/j3iu94ER2ZSjX/W4qerLQ7cpnTZ42b0iIwijsbiFEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrOy9bZKDqle1Gb1shGxJa5fEpQKzs5jaHcrxNpqSiA=;
 b=c+6IvAkdXI1lnAzAjtCeu9MGzUmKAQP5Kt60bbX6DNAiLK4FCZJa+wd0LlEH1XUXN7aV+a1ERwxdbBbj+WHDR77IjMn1F+PlJRz/oSt2FpmjCG7fziIZNwcuoU6TqnaBsPPoQz+8P/WLSdVSGHDE3KiZLk73n+DUMMSlUoarcypiD6HcYbSmOND69w1vUy6q6LWEUuf4zQQXoPEZJ2YZuD1gSMcWmqs379n9P8d2WuWtQ5VZcausU4892lTajkGjZzunUzKCPLv7XegkcXUfNnwRZVwkdYFy/h0xJnqJBKVFDCtswFAYYBgSItzgJR/JGghWsY/ICRbfZ7N8ScTdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrOy9bZKDqle1Gb1shGxJa5fEpQKzs5jaHcrxNpqSiA=;
 b=nylUM9cPkTp0YHYW34UPyxPhODYMBkzMet/1I1qvbJKCSZfS76Z3kL0Ltf3Dpk8DJmbEhqUUrClghHkc0Zs8+46RvBeAGvdlAm+piT2Ut3I3K9F5RGM+Dm8KvPFgDOLUtmzVp7psbSytFdmF3dkr7R+yrDiiy8IWw2VTyM+ac2E=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 18:22:34 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b%4]) with mapi id 15.20.6134.011; Fri, 17 Feb 2023
 18:22:34 +0000
Message-ID: <d0673e79-fa19-3452-0fef-f2c06683037c@oracle.com>
Date:   Fri, 17 Feb 2023 10:22:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC PATCH 1/1] SUNRPC: increase max timeout for rebind to handle
 NFS server restart
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
References: <1676016656-26195-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1676016656-26195-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:a03:100::48) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA3PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b1c053-135b-42b4-e544-08db1113f05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+9SxZtbhC+G7Rs0jZBcagK6y8p9cvTGWPVM1xiBruofHssot29JwB/xsEc6g8aVU3vLEqVI6fJ+ZLBsPv2A3wtBnjfSKkR6UitO30sR92naFlATeRFer2l7tjrjdoNt7Z2g8YAMBDu0InCTx9Wc+vAzBEl3/lu9K/J/uyq60+JrhczeOUdk9ONJgEasvYTKSBW57TbyTXOc5Px2b7iOe8fuVGrZknyx63julT+evWG7HCli0L77xdNuiUolKrfA7dEQx9wGvQD0QyrWT7oebjQT7NywipuIONA5mvFOs7nidJgraRo3g5DOdXAlFSgUZgA2gdySjYROZhKcvEkOfR6DiT790fAcaY+5WpUJO/wQ4kHya/2LytfWy1FEpUwHZ+/VX1rnGHevDPRDn20KQowQYiX9oqTkhxgm7kIKWUrwiZw4rLxmgWsuTQ1z/U/TLnTcX9UJp/JVEvR+qs4QTu8h16Q+tdtwkufdeIQ9xvLCsU6gokRK+HVVpXVk9CROsHu04h57HUOX7S8nQQaj6O609iV7m0r+o3c98dhA9MWTgz2D8eBZN7Va82FJrAALnpFnDEdX9cN3GqCyXLV9Y2zZZ6d8Y77R6dmZBtJ9nThl1w7FHUm/ytMXSVOQitKc8+n+FhyZph9IlLLOYQYyhS59fvDV5vWo84ruK0Gfqn189QiqcBPPMntQX26BLeADT5EVfao7inuB6mfaULnbWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(41300700001)(66946007)(83380400001)(66556008)(8676002)(66476007)(6916009)(316002)(4326008)(8936002)(5660300002)(6666004)(2616005)(186003)(53546011)(6512007)(26005)(478600001)(6506007)(6486002)(36756003)(9686003)(31696002)(2906002)(86362001)(38100700002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGpTSTRuR1BHRmdSTFViUUtKbERSVlEvdDdneXdhVktYMnRtajRuZk9CQlRU?=
 =?utf-8?B?cEUrOEdvN21TczU5QndsaDQ5U2NxbHRwK3NDdzBnY3pIbjdsczIrM1lTdkZx?=
 =?utf-8?B?MkV0SjkxejZKNXFheWEzbHd6UFdtQnNEZEpJcis5RDdta0d0TnBwR0oycDVG?=
 =?utf-8?B?cGkwWFc3UzdvT1RMRm1DcDlxMWxwb29raVhNb3l4YWc1amVUY3prL3lMWVNu?=
 =?utf-8?B?bktPemlZdHV3TGl5alp6UG8zQXVjY0FDVnFOOERxRWszcUQxNDRMdGxHMTE3?=
 =?utf-8?B?ckhaSURoZ2VOUjYxQWdlT0x6UWg0d0ZuK01DQmJYMXg3SnJTTDBjY1lVMTBx?=
 =?utf-8?B?bGxrVUlKMFpnZHAxdDVJQ09pOWR1SVljT1IrTVdqMkJkS3dTWmd2cnpvL2ZH?=
 =?utf-8?B?VXhabXJxR29FQ1Arakl4NzJJMkEwWEI1OENXL244NWNKZXBTM0NobkJDck9B?=
 =?utf-8?B?RjRpa0tDTjRyTWN0TlZqMGIwQnZ3Slp4UWMzdzRTTktsZFF4d1NUbzVwQkU3?=
 =?utf-8?B?eHh4cCtDYytvZnM1ZjY3MXRRYWFFZEVMa2JIaWF0RW5KekVOci9wYW9KOUd0?=
 =?utf-8?B?YWYxUFlEVHVZaW4vcWNFVWhIRUcreEo2NVVXVldoaThTQ0dMTC9XOFRCL3dT?=
 =?utf-8?B?RHhsUGEzakJEMUJ0RHltZWkrOWM4N1hBTGpzZ05Hcnl1QXdrYzdJQ0hhcGxR?=
 =?utf-8?B?b2xTeGRBT01rdGQybGdNaGszWVJWbGJPTk9CS1lRSFkyNHdWM2VFemcxQ2dv?=
 =?utf-8?B?ME1PWVJZaGt1SWRHalhvRkY3T3ZNTDFFOEYwUkxkNjc3djlHTDFwQjk2RE9Y?=
 =?utf-8?B?QXpWUml4OENlcUQvb3B6RUFlaHN4L2xTSnp2T0RzS0IwT2VFMk9VQUMzL0l5?=
 =?utf-8?B?cUpnczQyaGVXSllnSWxRN3FPM2QxWGpCd1pQTUdWZ3JLN3JGOWcrMmhxdWh1?=
 =?utf-8?B?ck12SWlaWDZBVVJTRDRaQkE3VmNBTW95d0lNQkFLeVovd0tYZjlmMS8wTVU3?=
 =?utf-8?B?VzFiOGlESjZjai81c1RndzNrSFZjYkR0bk52OEJYc0FBc2Q3TE96WlJkR3Za?=
 =?utf-8?B?aVd0QnNiazhzU284WnF5UWphTE42Rkp0VVhseHdpZUF4VGp6eFdZUDZncTF2?=
 =?utf-8?B?OFRmcmRIYjBOSVIyVVZybTIyblJFMkx1dFQ3cS92RTRNSWdBSUF5Z00wUTRM?=
 =?utf-8?B?S0JOSGFQRjFrbEFuNFUxSmhPU21iTHE3RE93aU8xd3VFcFMvTUFhZjZCd1NM?=
 =?utf-8?B?eDkwRG1ScWx4TE5wQ0x5RUhib3FnNkhGVGUvSmI1bkJIdVo4WVBoeFhFalIx?=
 =?utf-8?B?bytZYldUbVVPZysvc3JkVTZpYXJJNXdKVzROSzR2UkZXK3dVSURCRzBqYXFV?=
 =?utf-8?B?VWdZaDViMFFBUE1YVlQzazh1S0oySldVQng1NllFUFVHSnJIRGk5NmFFNmpW?=
 =?utf-8?B?NWtnSGVaNk1TRzNDaTlyRzF0aEZXMjhYMWlZdWdQN1E5YU8xVGtGZ0dxOE9u?=
 =?utf-8?B?NGMvMXFZWkYrdVVCQzR3WWpTUElxOGxESXQyNGd0L0xJdXV2L2pDT2NYVWV0?=
 =?utf-8?B?Ylh4b0FucG8wSlI5Y2hoTDVSN3YyVEErc2kwd3p0aUo4U2dISnp6Y3JNa3R4?=
 =?utf-8?B?UzRhQVovWTNnN0dlc1BGRmo2dGNIZVhkWUdkUlAvQUo4VHR5M3oxN1A1TW93?=
 =?utf-8?B?OUU4T0JrMWFGR2tNRzE1ZFdwUUxGaDVhMVN2Wm1YRVlQclgveXMvdmNHdUFq?=
 =?utf-8?B?UllncEx6MjloVEFieHZnUjhTeTRkQW45WmlGenREK3NnSGlielBiRlZFb3hz?=
 =?utf-8?B?WDdUQ1RsY0hOR0NIRWFjck0xYTcycGZVTGVuUVRMRWNrMU92dnJmb3hBWTNv?=
 =?utf-8?B?Z0h6eWhVVW5IWXlSa0ozUm1za3A3WEpIZzFqM0x0RWJzVXNPTDZQeXFiaC9M?=
 =?utf-8?B?Rjh4QjBYNXgzTjU2MnIxWmdIeGVLWVFiMDBiWkc1cDdPbUcyUVpIVGkxWHpX?=
 =?utf-8?B?bklIZHZwTnJtdTA3RHVvb3l4OEo0cTV4VHVOZmg4VDJNUlNmZmMrYVNLdjhU?=
 =?utf-8?B?c2JhSHRVVUpEeG1ZQkUraG91NjJpVXJBNGt1ajJGSjVuMzVMVzdCNzdUVTdM?=
 =?utf-8?Q?e7lvlrfRi+TZC/9Tx3IwqKHCQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AWYHwWZlU4n23qUVoOeJm0i3oVGxM2ZDM6nK6PWMYV7uWw3jBfFIWbLpkHHKgwNRLnjeBV0jAWTL7yowd/sgQADxWRamVsLS9FMIlzorLJB0v7Nln6FjL8e4PArycbmtAmyr3u2EeQVVe8G9AOg/S0BNxBCvCVGYWQUFfOXEPUkhOg2NQQmlxLnV/5v/6fH/Yv9PDTBF9A29AVgje6GTN93Q1ISEoECWc7MueBzxJpE37Kpfy/saPcezhpcXNjJTjq81NAxfH2j70gi59nTbo2eyrNwNUJnpf5P81YxT/0FVmI96rsLd9NYUA7mdfZugk3JO+UgoMPP4yex9/VWNbtTzB2YUfo+f4gcA9xv/Mgs3cYqu6Y6QqfEAhmzK0ZkUc4xwyZhynwQzAjTboGKdHronNVMvR4HyBpn7y4hH4nkw0Kw2o5audXpe5/Pqca6wz60RwZ2TqZPnvTm3sn7bCDtzE9aalCeV0s/jtkzBO7fi5+/Pl7chWcJAoj2LW+qaHyB62oveBKkdCLOMcjHEHIeSp24o5f2XLzO/m4arZzKk2CKrJU7jfflEqziADrsY/wkhJGmYzMnKhVwbFV/h/BNxBX1/RKNOpQq4bHlgBDypvV7b1AWC75oeEfRrmg2xDbZYbc6eDMxB/QOu+NBF0a2WvEGyoS6Wj+V7fuUGem8l0ne5ncTSVUBsxDZjudp9FFoBtoLYG4vih7fx3zo2eMnEkKHYztcDQVag8jyIGcwMY9Exh5tEdSlvUpzP/PGNYqJb9dGP2iVqERoAesmlI7byVUZoWS+b6/F+sUCXhwci9GmZUhy7n8wDwiaxdO8E
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b1c053-135b-42b4-e544-08db1113f05d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 18:22:33.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTb8p3NwVtRVNaTke2MT9fPpmfEnCeVJByflvhTMkWiSaMjj4VOR0wwNpBFVxQAlHYNc6ebpDCl1kg+aCUhWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_12,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170162
X-Proofpoint-GUID: loIsPAKvvytPVl426t5TMXfCRoJsCVJf
X-Proofpoint-ORIG-GUID: loIsPAKvvytPVl426t5TMXfCRoJsCVJf
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Could you please let me know your opinion on this patch?

Thanks,
-Dai

On 2/10/23 12:10 AM, Dai Ngo wrote:
> Occasionally NLM lock and unlock request fail with EIO and ENOLCK
> respectively. This usually happens when the NFS server is restarted
> while NLM lock test is running.
>
> Currently there is a 9 seconds limit for retrying the bind operation.
> If the server is under load the port mapper might take more than 9
> seconds to become ready after the NFS server restarted.
>
> This patch increases the timeout for rebind from 9 to 30 seconds
> allowing a bit more time for the port mapper to become ready.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   include/linux/sunrpc/clnt.h  | 3 +++
>   include/linux/sunrpc/sched.h | 4 ++--
>   net/sunrpc/clnt.c            | 2 +-
>   net/sunrpc/sched.c           | 3 ++-
>   4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 770ef2cb5775..7f2dee56c121 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>   #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
>   #define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
>   
> +#define	RPC_CLNT_REBIND_DELAY		3
> +#define	RPC_CLNT_REBIND_MAX_TIMEOUT	30
> +
>   struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>   struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
>   				const struct rpc_program *, u32);
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index b8ca3ecaf8d7..e9dc142f10bb 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -90,8 +90,8 @@ struct rpc_task {
>   #endif
>   	unsigned char		tk_priority : 2,/* Task priority */
>   				tk_garb_retry : 2,
> -				tk_cred_retry : 2,
> -				tk_rebind_retry : 2;
> +				tk_cred_retry : 2;
> +	unsigned char		tk_rebind_retry;
>   };
>   
>   typedef void			(*rpc_action)(struct rpc_task *);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0b0b9f1eed46..6c89a1fa40bf 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>   		if (task->tk_rebind_retry == 0)
>   			break;
>   		task->tk_rebind_retry--;
> -		rpc_delay(task, 3*HZ);
> +		rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>   		goto retry_timeout;
>   	case -ENOBUFS:
>   		rpc_delay(task, HZ >> 2);
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index be587a308e05..5c18a35752aa 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task *task)
>   	/* Initialize retry counters */
>   	task->tk_garb_retry = 2;
>   	task->tk_cred_retry = 2;
> -	task->tk_rebind_retry = 2;
> +	task->tk_rebind_retry = RPC_CLNT_REBIND_MAX_TIMEOUT /
> +					RPC_CLNT_REBIND_DELAY;
>   
>   	/* starting timestamp */
>   	task->tk_start = ktime_get();
