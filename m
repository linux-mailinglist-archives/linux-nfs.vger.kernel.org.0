Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800D2518CE2
	for <lists+linux-nfs@lfdr.de>; Tue,  3 May 2022 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiECTOl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 May 2022 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiECTOk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 May 2022 15:14:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC7255A9
        for <linux-nfs@vger.kernel.org>; Tue,  3 May 2022 12:11:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243I2L2J026110
        for <linux-nfs@vger.kernel.org>; Tue, 3 May 2022 19:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=FitmgPhRpHTwnbGybYIjCfC5R/URhOPG1chqwYYtyvE=;
 b=owQxztyVgRoYlSiiWXea2FQ8OhRiSnlMkOg7XsO/STnCgMmTN/5fX4XFbotxhpKbfs9W
 AGXCSijTYNhX3M8qGsp1T5CPFD6NECrLR3tXtTrJzZGk/5TIqSVHJPB4aIv40KMLWlFu
 H4pku+5HUg8sPs/rgyt+FsDi3C3NJlKtWP3L5hvgWb8jpq7TUtG7v1KRjoMkM2+XLNoo
 xYKpsS0hJFM+e6xLdSPks5vN2LCuUYrTIWTcRNjR6ML7hA3tFSrFrqRjm1Ak2Iu4futg
 OhzMuFjTWphzTy+b0cG5Sth12oyhpH31ICLVKLBw6xz3zJ263LtvpZTnrrDNxofoBkfe 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc6ghw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 03 May 2022 19:11:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 243JArMD009881
        for <linux-nfs@vger.kernel.org>; Tue, 3 May 2022 19:11:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj8tu5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 03 May 2022 19:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsVR6qUrWRR5aapY63E7CSdw3LSnuYZDzGntYNZ0dQFU3Do3gO2tefVSNdALoRziztOUzX34Zy9SETIpuAnoWYxBq0UJBbjMGneRUPMcp7GkHbWgBoTbhEz9jZom9fUsbSvZ+AAXoX7DPNw2qhpAW6jypvqvezgZTzlR8Ig0e3or1JO6T66TU4F3BPq6AUrcGd8dNyudyujMeiDepF4z1RpRmxIwtoGoI93hzseY7+eIYvbEr65XJk9NnVTnCMAdJDyKFMxmf6fx1/Ea8rnIRuZ3VbPnzatfP2SiWkIZe4r64flHwPzn9V3IS0pIdLVKGSoJl5FWG7DIN1067395ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FitmgPhRpHTwnbGybYIjCfC5R/URhOPG1chqwYYtyvE=;
 b=CHmeSHEVOUMqFrUlTYYhTZSEgv8HbG3+G/S91iJF6BZsgR0YqmmNUoAYIQWUKonMY7Mbh4nkG3b/XIE8UfIA2buGp93mJxSTbK9PZQP1XDOqfIJmSNVY/R+CMBHktaYX4L7R4jTftValbYjwaZj23SECdP9yX2pH/3sClGT4KCjSWq04eM6s//79tpCVLv23rSrsVJuldY51bJlkW6xjKEb/6sLC91jxIMSaiGUvaWlEp/OXIpv7kIlMHHdJt+4/Y3MiXdFEUR1i/4ykly9BIJDsMW9i3kDOWF1/qWQlPAuBbe6Kn7l1FvVI+q4H9hTkRt2P2RBCw+vgHweNA88Hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FitmgPhRpHTwnbGybYIjCfC5R/URhOPG1chqwYYtyvE=;
 b=JpLWojwOYouoZRjcS7PWAOXyGDw5BbKdAAOq5T98va1R5vBcApWCn1YoDYA9+kwdENJD3XjDnZCyoNy8c7vXoDPgu+YNpUjeq9GjX6uDJKMQeTg/HKRxth0rFMeVOriOEh8rjdvoRpX+gV2gcMl1zer5fQzVIsnutyy6w/gloNU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN8PR10MB3377.namprd10.prod.outlook.com (2603:10b6:408:cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 19:11:02 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 19:11:02 +0000
Message-ID: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
Date:   Tue, 3 May 2022 12:11:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Content-Language: en-US
From:   dai.ngo@oracle.com
Subject: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fda7ecbe-0d3c-4be2-82ee-08da2d38a9e4
X-MS-TrafficTypeDiagnostic: BN8PR10MB3377:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3377DAFC4CE0BF787881E07987C09@BN8PR10MB3377.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BS3799KIfnLjfycrLAmSQH2uVxA8JmwKxdnu26kwGkK2kB+2VLGopOhEJvEcxegJgwQYiNsOa924xDhCrfdNz7F8bEbxAqMP/lNT4q8BTC6GA7RU/FokUKv4aQck5srwuC6PtaG2Hezrh0R5XiYgoQXdY4mFwSeWXwl8l/cvBVWr+GpQ/ImQ2lMc7CY+9ECUwKAth/FCdrKpX3B4AK5TVimaHFHqgFjwoq7FxmFdXTsoKQYJ4zOlTtSFa47ORT2YINcHGa7zS7xFvsuaEvpIxXyPaxQEWI3UL3sHGI8IE8eu+3vc9ISMFfaFMSql0/jCBCu7CQBZvYhaCHj31USWKd1wGlJ7X6KrD5qPGwzgzDHRfoK2xc1kXiXAwgoWbLE9cqn0m1XJrG+7nePhOZJVIRz/gyhFpxw5lmm7POSY0fHBPJnaFzd/rpMUzV8ax/KLjJUvl2oh89p0Bmlx5G0yEk0Vns7IzXVDqHs5Hd7sTU1nFqrw/H4ptDmm7RBpGa2YI3I7IplQzwrCHVf+okxeXtWe436eXK9al8cEpxjj5GF91xjvx6vYeRxhSyU3o2PjxoO3GBCZUdbK1553OOdtRwZ+V+l6dKI9BC/MlIeWBr3ffZk45p9X+jtkbX//J0ouFBEUmIzGKyZ5zPGbCwc6PCN+CXJBCIyGLO014jJMkKND/yCCdtANfibiXCrDEA7KyPBv9xnogjZN1O+ncktiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(83380400001)(6506007)(26005)(2616005)(31696002)(9686003)(6512007)(316002)(86362001)(186003)(36756003)(5660300002)(8936002)(8676002)(6916009)(66556008)(66946007)(66476007)(2906002)(508600001)(31686004)(45080400002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjN6VUF0bzdPU3J3aUpGVG4xbVpGVVpQK0RDazJaK0VNV0lmL2t3UjQ2dFFy?=
 =?utf-8?B?SThOOGpPcWdBcEtjSjN1bXlEU2ZTK1FEeEpOMmVMS1ZJZTQvNEZ2MU40aXEy?=
 =?utf-8?B?L0l2ZUJyZVBDYkxWVkxiQk9ZOTBmdERWRWdRYU82NktXeXU4MjhtWXJ6UFQy?=
 =?utf-8?B?cHZKNlJzeXNreW9IT2RSVEdFSmhjRW5oRHJySXh3SjBOeTJHRk9jenlzMGY3?=
 =?utf-8?B?Y0hyKzVKZm1VZmMrSGdxaVd5UytpbkZZM3UxbmtvaTBoZWlXZVdlRG93TWpK?=
 =?utf-8?B?Q2xWWVcyMkFnZDhVSU1TNHlDenVwWlZwNXBJMzcwSXZCRkNVNGNBWFVScDhB?=
 =?utf-8?B?SW1ZU01Ca1NOaXJGUm9UYXAwZU1tRyswRlh0Zk15Zk41UFpMN2F1d1ZBb3hQ?=
 =?utf-8?B?WHZoUUdYVzUrR3kzMTB2MUdUc1BRd1hiRnNxekYyNUlsZmpaTVBRL3cyZW5I?=
 =?utf-8?B?VGhBUlgxc1NSamhPV3l2dU4rOFFuMnpLaTlaRXZFWW84QVI3OGw2NlhSaXJn?=
 =?utf-8?B?bHJTbSt2SzZZK1J3SXhNR1NFanQvS1ZsUE45Y1JYRkNDY25XMDNGU20ya1Z0?=
 =?utf-8?B?K2dDbnpTbU1Qajg4TEpwZld0NU5vZGFoTTRuK1FEbGI4VjBDOXJydnlOazcr?=
 =?utf-8?B?RkxXZnJiTzBQZHBTQ0hRak1zL3NpcU41WlNtbUV1RjU0WlJldGlXdFFsV1lB?=
 =?utf-8?B?WDd5ZFdEdVZiRHQwUythcEU1YitDVG1TY0t3QmRHd3VLREpaU1prbFN1TE1D?=
 =?utf-8?B?b0YvSFMxb2IvNHc1QVdzTE82dFhwTnFFa0xwdm94bVE2eUs4R1hnTkVLaEsy?=
 =?utf-8?B?QnNUd0tPaURGWjlvVHMvVC83TVRIRzBNQmgwYXQwSWdYYzZVQVFqVFZ0azc3?=
 =?utf-8?B?VzZENHRzN0Y1b3dXNUNBZFFhMEtxWU5PRDV1dy9zVGpiNGJZVllTSERNNnUy?=
 =?utf-8?B?STlJVGNiS2FSTDhvZFZmdU5nZlNwZGs2M3VNMDZhbUhsVHZYS25sbjhYRkhO?=
 =?utf-8?B?THFUdzF5ZVlOeEhFaERMWnptTzlOcnhFVGJzUWJiT2xtNzhnSkNkdUUzTkVj?=
 =?utf-8?B?d1VPSE4rdVBJbE5sQXBXc3E0STBMQnA1aXVQa0Q4ZmpkKytvWlFFdXVsRnc4?=
 =?utf-8?B?ZlBqRjNraW56dmtwaXFSZWZsb3hPZWNaNk1BWkszaDlEUS9aTFcwYVkrOHdI?=
 =?utf-8?B?UUxUV241WlpYT1NIeE54a0ZPTVpZaW40Z2wvZXRrNGxuMXgvNWxhZDlYVm0z?=
 =?utf-8?B?bGtUK1AvV2t3QlQxM0VHN2NWVC9RSFRpZnpYcGtKdHQ4TGtCd3ZBaXhoNU9Z?=
 =?utf-8?B?ckE3elZRYWliSWZQT0xvWjljcDl4bFFEdzJFWXovZlcxVVhaUk8xeXBDeU9a?=
 =?utf-8?B?RnhIYjRPWTJMY21YNkVOK05jQnBsYzVXTnVPMHE3eDIvVWFKSlhWTFNEZFRp?=
 =?utf-8?B?VEJSMlVrV211MkRRaUhFdkhIMFZaRnNRZWRoZTdQaENvWGpmUVhLc2lsODBl?=
 =?utf-8?B?V1liZi9lQVd1OXBOMERRc0l0cXdmTks1dkZObXJya1lEZE51dUF0ZHd4Qm95?=
 =?utf-8?B?TU1EZVRhUVh1MHZTSXBYMGNGKzE3eE1LWDNCQU1OTUhwQTdZdjY2azVZZDJh?=
 =?utf-8?B?bm5sdEd4UkQzNWg4OEhWcGhPNFMweVZqbGlLSllCTHl0bFJHNmkwcis0bS9V?=
 =?utf-8?B?WmxDZzRMMkRsSzBxU1ArbjdGMkpjbndnVHdSaHQvbTZySnFJK1RsVzFzM2pt?=
 =?utf-8?B?a1V0bWFHcHE4MXd6NTR1Q1JRbG5XV1QrSFlXdW14elpaK3lidU5CN2JuUlpi?=
 =?utf-8?B?ZmRNaFFNQ2lyYnk4VkZod3RvVThleStqWGFOdy8rc1lYMUVBelZTSEVFSmxH?=
 =?utf-8?B?eHdOWDZPSERnWGs0UjVUUHNzUE9WeTBiV1o1WUt6M3VhQk9NMEhzR2syenJY?=
 =?utf-8?B?QnJPRllMZ1Frclg5QUFrM0ZtZ1VuZmJONGlyVHNKa29VR0lpaFBIbEVqY2Qr?=
 =?utf-8?B?dzc5Q3pDWm1obVRMbEZuTXpDU1RudkxXMGhTVjZOamp3SmFmajdFN05xV1Jk?=
 =?utf-8?B?cFlCMHJJSXlGME5EaThQRGZoZ3BORWdTalU0dkFVMWhaNDlPN0xYbVVuS1Z6?=
 =?utf-8?B?RWF6RVJ6T2NJTi90bXB2VDR4aG9RKzBCcUxmdnN3Q3NtYWpQSnhiQ0dFRTdB?=
 =?utf-8?B?ZFFiTEN0bG9RbGFqSmp2cHB6dDZ5SFI3MWVld2ZJYyt0RlZaWEx0Nm44RnNK?=
 =?utf-8?B?TWR5WHFYdUp0czMzSlNIRkR6dXpSb0hqd1FTdFk4NnJXaU1kWWZXL2V5VVZ2?=
 =?utf-8?B?WWZHUUFVcnY2bWlKK21mZFJkSFlIcjA5ZjBSTG9tVlo0Ujd1U0g0dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda7ecbe-0d3c-4be2-82ee-08da2d38a9e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 19:11:02.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSeG2oOPWBtTGPRFsYF4fGRah0NNmlXv6A1HSla+jV22KdZ+FUw2nqWWDYfpzruM6+w40MU5kFOYaatB7YxoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_08:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205030121
X-Proofpoint-GUID: Hyak4udt1o0jMjyeqpwq_fNNuzyi9YJ9
X-Proofpoint-ORIG-GUID: Hyak4udt1o0jMjyeqpwq_fNNuzyi9YJ9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I just noticed there were couple of oops in my Oracle6 in nfs4.dev network.
I'm not sure who ran which tests (be useful to know) that caused these oops.

Here is the stack traces:

[286123.154006] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1585
[286123.155126] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3983, name: nfsd
[286123.155872] preempt_count: 1, expected: 0
[286123.156443] RCU nest depth: 0, expected: 0
[286123.156771] 1 lock held by nfsd/3983:
[286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-{2:2}, at: nfsd4_release_lockowner+0x306/0x850 [nfsd]
[286123.156949] Preemption disabled at:
[286123.156961] [<0000000000000000>] 0x0
[286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not tainted 5.18.0-rc4+ #1
[286123.157539] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[286123.157552] Call Trace:
[286123.157565]  <TASK>
[286123.157581]  dump_stack_lvl+0x57/0x7d
[286123.157609]  __might_resched.cold+0x222/0x26b
[286123.157644]  down_read_nested+0x68/0x420
[286123.157671]  ? down_write_nested+0x130/0x130
[286123.157686]  ? rwlock_bug.part.0+0x90/0x90
[286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
[286123.157749]  xfs_file_fsync+0x3b9/0x820
[286123.157776]  ? lock_downgrade+0x680/0x680
[286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
[286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
[286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
[286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
[286123.158088]  check_for_locks+0x152/0x200 [nfsd]
[286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
[286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
[286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
[286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
[286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
[286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
[286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
[286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
[286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
[286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
[286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
[286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
[286123.159043]  nfsd+0x2d6/0x570 [nfsd]
[286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
[286123.159043]  kthread+0x29f/0x340
[286123.159043]  ? kthread_complete_and_exit+0x20/0x20
[286123.159043]  ret_from_fork+0x22/0x30
[286123.159043]  </TASK>
[286123.187052] BUG: scheduling while atomic: nfsd/3983/0x00000002
[286123.187551] INFO: lockdep is turned off.
[286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl lockd grace sunrpc
[286123.188527] Preemption disabled at:
[286123.188535] [<0000000000000000>] 0x0
[286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Tainted: G        W         5.18.0-rc4+ #1
[286123.190233] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[286123.190910] Call Trace:
[286123.190910]  <TASK>
[286123.190910]  dump_stack_lvl+0x57/0x7d
[286123.190910]  __schedule_bug.cold+0x133/0x143
[286123.190910]  __schedule+0x16c9/0x20a0
[286123.190910]  ? schedule_timeout+0x314/0x510
[286123.190910]  ? __sched_text_start+0x8/0x8
[286123.190910]  ? internal_add_timer+0xa4/0xe0
[286123.190910]  schedule+0xd7/0x1f0
[286123.190910]  schedule_timeout+0x319/0x510
[286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
[286123.190910]  ? usleep_range_state+0x150/0x150
[286123.190910]  ? lock_acquire+0x331/0x490
[286123.190910]  ? init_timer_on_stack_key+0x50/0x50
[286123.190910]  ? do_raw_spin_lock+0x116/0x260
[286123.190910]  ? rwlock_bug.part.0+0x90/0x90
[286123.190910]  io_schedule_timeout+0x26/0x80
[286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
[286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
[286123.190910]  ? wait_for_completion+0x330/0x330
[286123.190910]  submit_bio_wait+0x135/0x1d0
[286123.190910]  ? submit_bio_wait_endio+0x40/0x40
[286123.190910]  ? xfs_iunlock+0xd5/0x300
[286123.190910]  ? bio_init+0x295/0x470
[286123.190910]  blkdev_issue_flush+0x69/0x80
[286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
[286123.190910]  ? bio_kmalloc+0x90/0x90
[286123.190910]  ? xfs_iunlock+0x1b4/0x300
[286123.190910]  xfs_file_fsync+0x354/0x820
[286123.190910]  ? lock_downgrade+0x680/0x680
[286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
[286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
[286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
[286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
[286123.190910]  check_for_locks+0x152/0x200 [nfsd]
[286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
[286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
[286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
[286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
[286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
[286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
[286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
[286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
[286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
[286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
[286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
[286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
[286123.190910]  nfsd+0x2d6/0x570 [nfsd]
[286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
[286123.190910]  kthread+0x29f/0x340
[286123.190910]  ? kthread_complete_and_exit+0x20/0x20
[286123.190910]  ret_from_fork+0x22/0x30
[286123.190910]  </TASK>

The problem is the process tries to sleep while holding the
cl_lock by nfsd4_release_lockowner. I think the problem was
introduced with the filemap_flush in nfsd_file_put since
'b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()'.
The filemap_flush is later replaced by nfsd_file_flush by
'6b8a94332ee4f nfsd: Fix a write performance regression'.

-Dai


