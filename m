Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81916DFD3A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDLSJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLSJk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 14:09:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E219A0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 11:09:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CHEExd028957;
        Wed, 12 Apr 2023 18:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eFHuag+RArkrEcvZKSAf+8rhVbZmmABHFccWFyg1V5o=;
 b=CWZTpg4XUmzB3F8ymXvr76BJ9vklIFfPgCCN2jBjejuLdWCA1hj57s7aKqr5U0CZiLaQ
 x4KUJyGgxBq3fH0kkwu1ZUyCHP8pampu75Qy942wmi9K2VSsySXpbsDl2Q80JJDG6goy
 Dh4sHd+HkrcLk+ZAaKLOXvz4IO0+At63VG75a9WJan/da34zA1Kb+Ce0szfFkXfNIXkE
 rwbhrdVSaKZ8Rgbh5/sh6+WNmkMA5kyEZDRv6q48qM51elJwzmTcFRaukIh8pZeuu1w4
 0li9WZnl4AH5EYYpABz+2OiwEwR1FzU36QEPcyP19XkTalBb+WhhdGBtvw/11b8VpHL3 ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etrwmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:09:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGnPHq013201;
        Wed, 12 Apr 2023 18:09:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw93e84b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF3+bnlDyKP710eWdcKn1FsPqk2pkpPRjGdlFQ5SifN6NdIDRytdS4Pf3rdVdAvvIsm3hEKRs2S+uiTt1i9dqyCwEubRBrODPuK8wd9PHy+LxGpePJnSthY7D/TBBw33ypGM3xOc8pX1mQQO1Brgppg7AUFFDFK7J5872ZytHk1XDtUMWki7w9fqckaVYm+EFgLp48f9WgosbloOAeCMjmZIfF/Sp3iB6OvJZfPU1/pQtygTE3mtt7bDmSGmeXrMqVxrAEFvbukwOppj60Uxy2BYDx9aVaNRNYlQq4bUKCKxw5rjYYU3yp16MJkanD8uArGPRhHsouK0XxF/JVdouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFHuag+RArkrEcvZKSAf+8rhVbZmmABHFccWFyg1V5o=;
 b=fED5pvIphdw9NHHAtQWx7ZHocvGKc4EuyfE0wfQXOCVZ50OV4yUVLUl+4Wmr7WJV1bhzwXw4SJSwKfi9wtHYbOojn3Sv5UDE6v+5DuVXBFPke6AS4DhB/kh/YOCdIypBpzP4UCOIJh+OxGiuKstnJGbEe9gaJ4XscaSBMFxKeMFG84E97gUEfwpEFRozG9jAXLM4oE+E+I9j222KXYXc/FEoBXitIDy+RbFJP+zJpajG4gqezacAAnTKoda7eVzbr3pDIj07qeBYQb4nTWU59PdZxe/Vdwo5ewzzui+8aGwhtcMjFtZ+uYSYnQvotBHo1dF8S+piglIYjGxbLp4mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFHuag+RArkrEcvZKSAf+8rhVbZmmABHFccWFyg1V5o=;
 b=XfZUl0NEkDEQE90XwjzPuQF5eldDIXZx2ra1j+67ptgGxqka1tshYHU2j7z/GMmUgIJerDonxyjWWMU/547yiCeo7kQXsXJjpsvXTcMFwwYCV7U5S9HH+kP0B5MkB+48YzQUgv5iav4akdk43YVcc+B0+hUa94Qa1HVx0lwdHmk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB5247.namprd10.prod.outlook.com (2603:10b6:5:297::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 18:09:31 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%6]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 18:09:30 +0000
Message-ID: <e86f8f27-5271-a517-1e54-572fd0b0fefa@oracle.com>
Date:   Wed, 12 Apr 2023 11:09:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <9b97325926ccb7d983455b13617a35c9e83dd7be.camel@kernel.org>
 <561C2E8E-4DE3-4EFC-8821-B7A2C49B42E9@oracle.com>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <561C2E8E-4DE3-4EFC-8821-B7A2C49B42E9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:806:130::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS7PR10MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e763b4-ae47-4dc9-8209-08db3b810fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2w1ZOJ837PZG+yNUm0gqErB7ttoBmWDwR16IN4bmeYJ051Y1DsB+2q6mxIIYBbEu4Yw3WI+TbPF05U3dOyDAOdUYNHnHZM/lbUhDab6otVlwoYFUVHBpCbOC2oCUVQz8P07tCuGIXggDCF7TdTeE3cEvOpLKiKkkQ69cHLhR3/S5mJ9bK41mPWxtnSd0Y+SrAvbv3ReYthTPeOTqIGV+CkhkzIrLEfZUdqeyJfPEemT2V4Kg3xPXRJvFAQN5l32YxDK9D6RdBBrOwk2+lMRHItHmMZGGfsI8gFuxDa7tjGDhPwBzYD+jQtiCKDPmoanyZ/5FNqm8DwC9yWl4qzGEAGvUks4+RZntJMnFcxbwVoMjNeyyYgGpZxbR2CPyExbW+U6xDa+cPhAwHefwxE28XFpstzxObW2IN+HsaFubsN38ZoSCJPuLsfwYsdYIb28Rop+uyqnJMtpc1kfVH7loTKTZEwxSEP0f782FZNhVv7u6uOdM+Sz2jCy86pyAEbwV0xUqzaX9bwgOGJ2OmmW6gQUcQzthvm7GAi1p2LEDCMIj0QKG2tilFm89jDaP5HygCfUzMZMzM+ByznfpEEnaQaDAaGjiqm6Cz4ImA2dIuW4WAmxn6OPix4vtWQu1VcOS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(2906002)(31686004)(8676002)(8936002)(5660300002)(478600001)(41300700001)(316002)(66946007)(36756003)(66476007)(66556008)(83380400001)(54906003)(110136005)(4326008)(186003)(31696002)(6486002)(38100700002)(86362001)(9686003)(26005)(53546011)(6506007)(6512007)(2616005)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3Y0L3BuL0VWRUJ5dGc5d2pqY1lnTVZRenVja1liS0xxaUNHSDZISjdTbHM2?=
 =?utf-8?B?OVp4NWdhRTdoY3FxeVdyOGFScnJBYkVjZWZVQnlqWDA3ZmxUUlZEdDNLbWRn?=
 =?utf-8?B?aXV2MVBoRDFNNlFxQmdVcVFQTzdNU1MvWVJGaFJHeDJqYkRIN0VQL05TaVly?=
 =?utf-8?B?Tnd3V2JXeWl3K2UvOEdGajlmL00rdmJhV3M3YUtCams4VlBOZCtxMUZZSU91?=
 =?utf-8?B?ZTY4MDYySzJGK29pYnRKM09rSHl1WFVScUh4bENUTFR5YWltaGVjek0xODFI?=
 =?utf-8?B?TkNqRXpCZVZqb0VVUVhTcTNQUHpSVFhLcFVYZXdaRGk4cHBUWHlIdlFNSGor?=
 =?utf-8?B?N3RiZ1R2Umo5bkFWamhENU1HTkhWYjhLZTMrU28zb0gvK3FQNzRBK0lEcjBL?=
 =?utf-8?B?dVlvWFphT3k1VUpXcWRFSkZBRTZUMllPVFREKzd2enBYY1RiMHRQdmtaM05u?=
 =?utf-8?B?UWdjM2lRRXVka3FnNUJVaGJFM0hxQ1MyQS8zYWF4K2k4MG9vQVRYR3B2WTRO?=
 =?utf-8?B?ZXRuM2tROFJvZzJBVTZ0a09sazhUd0l1anBTWHN3V1NrMDh5RzFIM3pyTjVT?=
 =?utf-8?B?eHJNVTZsYmZlbGI3NkNKZWM4d0g1cUR4eVNzWVIwWEt5djBhOG9PaFJuc25l?=
 =?utf-8?B?N3oyYm91V0JscjV5aTlId3RSb3Uzd2QrNW0zdml4U1BFcnBsaUc3NTBReklU?=
 =?utf-8?B?bm44YXNuMEhCcGJQRXJIMzVJWWlxeEg3T0NHaFRHSGxyVGdsWFdLTVcxNSsw?=
 =?utf-8?B?WlU1Q1ZuV2pBU09kTnlaK3g0RXViQU5FbDF3eFpxNVhlNHRIRjRCd3VpdDlu?=
 =?utf-8?B?WmZpVjMzMUlLOUQ3K3ljQm44VTB1YzFnSG9uUUlmRUNhYjFCYjhJWm94bnd3?=
 =?utf-8?B?UGZIOVIyTnZRZnhiUDBKNkRnRzRVK3o3c1dhZm80WWo5d045TlNaR1JCUDJR?=
 =?utf-8?B?bFQ0ZU1oZGxNNzJIZEEvYUVheXUrOFRVby9LNy9NMEZrY2JpZ0o2eHliT05B?=
 =?utf-8?B?a0NaaGdWWHdJY3lHTlNYc3RtQ3BDSnRMRmZ2Vm8vR1JmQ3U3a0V1UzRoU3ZY?=
 =?utf-8?B?Q29VYUJWQStzaFgya011M0twQWd1dHNqZHB5U3dESWo5dEkva29VRWdzeGp1?=
 =?utf-8?B?S1BnWGc1OUFMRTZINWJZQWNYQ3d4R05hbEdsSlR0NnlqMzRBM3hHMW1FWVhF?=
 =?utf-8?B?RzllenJ0NmdoODNHbzdCcXVZeGZJM2NjendLZFVSbzcvZWhKTjcwQllsRm4x?=
 =?utf-8?B?SFNvRFJheFU4WTZ1UlhzU3l6NFVPQnE2WDM3MEpKcm1QL2ltWlhtMmJwZFlm?=
 =?utf-8?B?ZlZsR0xJVEUrZnE2Witob2t3SjVyTEc1R04zaVJCUWRKODlxY2FnWWpSZG53?=
 =?utf-8?B?UWNjZDFYRmVGeGxWRmgxeHFDWWlsUnU1U2hIamRsQUtrSEswZGhxTnBKU0tH?=
 =?utf-8?B?Q2NwcDhvWUV4VTBEOFhvVjUxZzF5TjUvTzExU2tRbWpCM0JTNnNIT0o1VUI2?=
 =?utf-8?B?VEQ2WXkvS3VtTHpHZVd4VHBsdGNUbEdRdUlmVjhiWStEQnZCeGJnS3Q3alpX?=
 =?utf-8?B?WVp6U1FvZjZrK2xXWXhqUGVETzdDblNmUnQxZEVlWWREbVgvZEdtcFp6R0hv?=
 =?utf-8?B?TlMwYS9WeGlrWVJCN0RlRlNUeGJhcUxQVEl4RFdmVEJ4anQ2Q3ZNUjA5MGMr?=
 =?utf-8?B?bkt2NVozb1BYSnJoV0RLWnZ2b2ZJUGdoWWZqVXRhMUZ0UlVPdXpUNGxpZ1Nv?=
 =?utf-8?B?cnNEdkE4YnJKVU1ub1pzbnVJQllMRmhqMHBzMGx1cnRHbGhkTEYrTnlQb01F?=
 =?utf-8?B?ZGtwSVhhK1pxT0s3U0xWeEVBTVVRRTNxRFM3c2lSS0NzZVFMOUo2R2lTNHpD?=
 =?utf-8?B?ZkJwbG1tMUs5ZVBFbDQ3aVJlajQxY3JoTUx1QmQxVnhQN0RHQTJKZnIxNmp4?=
 =?utf-8?B?cHF5QnNzVkVtQlNFTlZEb2Z3UlphdHVwbTBGY1ppdVhLbnpBV29oTVBvVXFO?=
 =?utf-8?B?cngxUE8vTWRjUldRbFdHZnZENHh6SVlBSTBKWEdZKzN5UWNXd3g2NTNhL3Rv?=
 =?utf-8?B?RHdVaUdXNEtCemI0WURycHc5d3BYS3d6d3UzQXRPWklFWXd3MGFjMW5TMDBm?=
 =?utf-8?Q?7EXXG/z5Ki5DHJPEwu+EpPa7I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Il3eumaYWk/vWMlSNSM6EbM/3RqOa1R/Jb+TIcyUvPlXYr+wZXYrQisI0hKegxmyP43iwUdRqRYR9+KywVqME3kFqSA8Bdnimo5iQArG2gjMz2iWXQeRMlGEqnojnz4v2UJCIh7UySycOC0KwO02p5iT2ydTxeCvzSqDXkAnZrBMTaanj4OT9y+sMmdZNwoMzeE9QW3WOXSQ4exaIE+TBkupfXysaY8TqSaFwkdRF7Bf5+LfPJxQn6FWAvb5phy6nYAerCmvukggdx0v8f8m+zayBJZLpW5lhMtvNumrmNssFnhEEa55rSXk8ufXs7+5m+fPXjv4oxXB7Rnx6WvCBagYq3YkZSk9oDatORh/d5uftXuIBypMazmPJkbJP+P2bVG0VVpbaNAWEssyXeHCL+gDIjTRix3LvBwQBpiqbYQxaB9/F4viy7+dWODiPjteEu0XyYa5+OgHk4WimxsEU4wpZ+/mYi2EGjCIFMFPobkybWpYUklvCdqEOe8p9TGMkmklFNJQAX9EtxTFxca8RQ1zBXODEXcMOFc+mVVW8K+J4iI3SQD3mSxCInN0gWlK/Pi9EZRjkQqI463pgxjaXQ5py6Hi1Mhg8l1fv3R0YegwUF2jo2eiuu5Fjsgmxjas1aAR7ld/o7lrsrR0jMN4goZMHJWobLJ69ydTuKVVYyuMTKAKW283hIcidag0n7eLU7a12gZ7ApHIuWOjJ4P7Q+DbklSYhYKktfKkKx2qpDLDci2DlLP4b1/5dVRFOIQxU40/J9ZxVG2MpZCK5qI3H4qknQnhLGU9JVPvJ04bx9rBm+h48oONvtVSNjJWDi9BO/+w5eGPzmqCHyTACaKoFw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e763b4-ae47-4dc9-8209-08db3b810fea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 18:09:30.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN+oVIcX/IderO0Ao9ESmpIZJxcjifNA4XGEIHswfi6A7T9nEYpIn+qfUxSyPjSpzd6VxYZ5Cl4Ymx4CY7QlvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120156
X-Proofpoint-GUID: HICLCeqm3ytdzzOudeZqJ5byQOl6AvOV
X-Proofpoint-ORIG-GUID: HICLCeqm3ytdzzOudeZqJ5byQOl6AvOV
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/12/23 10:55 AM, Chuck Lever III wrote:
>
>> On Apr 12, 2023, at 1:50 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>>> Currently call_bind_status places a hard limit of 9 seconds for retries
>>> on EACCES error. This limit was done to prevent the RPC request from
>>> being retried forever if the remote server has problem and never comes
>>> up
>>>
>>> However this 9 seconds timeout is too short, comparing to other RPC
>>> timeouts which are generally in minutes. This causes intermittent failure
>>> with EIO on the client side when there are lots of NLM activity and the
>>> NFS server is restarted.
>>>
>>> Instead of removing the max timeout for retry and relying on the RPC
>>> timeout mechanism to handle the retry, which can lead to the RPC being
>>> retried forever if the remote NLM service fails to come up. This patch
>>> simply increases the max timeout of call_bind_status from 9 to 90 seconds
>>> which should allow enough time for NLM to register after a restart, and
>>> not retrying forever if there is real problem with the remote system.
>>>
>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> include/linux/sunrpc/clnt.h  | 3 +++
>>> include/linux/sunrpc/sched.h | 4 ++--
>>> net/sunrpc/clnt.c            | 2 +-
>>> net/sunrpc/sched.c           | 3 ++-
>>> 4 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
>>> index 770ef2cb5775..81afc5ea2665 100644
>>> --- a/include/linux/sunrpc/clnt.h
>>> +++ b/include/linux/sunrpc/clnt.h
>>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>> #define RPC_CLNT_CREATE_REUSEPORT (1UL << 11)
>>> #define RPC_CLNT_CREATE_CONNECTED (1UL << 12)
>>>
>>> +#define RPC_CLNT_REBIND_DELAY 3
>>> +#define RPC_CLNT_REBIND_MAX_TIMEOUT 90
>>> +
>>> struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>> struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *,
>>> const struct rpc_program *, u32);
>>> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
>>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>>> --- a/include/linux/sunrpc/sched.h
>>> +++ b/include/linux/sunrpc/sched.h
>>> @@ -90,8 +90,8 @@ struct rpc_task {
>>> #endif
>>> unsigned char tk_priority : 2,/* Task priority */
>>> tk_garb_retry : 2,
>>> - tk_cred_retry : 2,
>>> - tk_rebind_retry : 2;
>>> + tk_cred_retry : 2;
>>> + unsigned char tk_rebind_retry;
>>> };
>>>
>>> typedef void (*rpc_action)(struct rpc_task *);
>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>> index fd7e1c630493..222578af6b01 100644
>>> --- a/net/sunrpc/clnt.c
>>> +++ b/net/sunrpc/clnt.c
>>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>>> if (task->tk_rebind_retry == 0)
>>> break;
>>> task->tk_rebind_retry--;
>>> - rpc_delay(task, 3*HZ);
>>> + rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>>> goto retry_timeout;
>>> case -ENOBUFS:
>>> rpc_delay(task, HZ >> 2);
>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>> index be587a308e05..5c18a35752aa 100644
>>> --- a/net/sunrpc/sched.c
>>> +++ b/net/sunrpc/sched.c
>>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task *task)
>>> /* Initialize retry counters */
>>> task->tk_garb_retry = 2;
>>> task->tk_cred_retry = 2;
>>> - task->tk_rebind_retry = 2;
>>> + task->tk_rebind_retry = RPC_CLNT_REBIND_MAX_TIMEOUT /
>>> + RPC_CLNT_REBIND_DELAY;
>>>
>>> /* starting timestamp */
>>> task->tk_start = ktime_get();
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Thanks!
>
> Since we still haven't heard from the client folks on this,
> I can take this fix through the nfsd tree.

Thank you Jeff and Chuck!

-Dai

