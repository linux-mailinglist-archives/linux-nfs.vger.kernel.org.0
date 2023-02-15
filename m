Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39518698891
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 00:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBOXFZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 18:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBOXFY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 18:05:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0607E0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 15:05:22 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FMx7Rb021263;
        Wed, 15 Feb 2023 23:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ntW4luF47Ycm+4yJa7CWJxxhkum78MSo755btb0fgYM=;
 b=lW1WIYsz/eXZoHGxlxsOFqcR5JzLaj/zzAgWOGriLgCyYkTM6NSesDvPlwJlHQ/viwnc
 D4XLFfF1aFiyFU3Hg6Z8EbdtLvKKdXzJksZf3d7cJzzoU1N7Ry3gz+WDuBIM8U3dwEuW
 RklNzV4axkLvBldOiE9wvDMz9ZGNEqBrb56mKzpRKqnOLLnzwCLjVWrkvMmKJ4ZLEmIN
 PmLRRjjVkwHKOqSDKFxPH7MXUwo04C/2TEzfTmGdGHaWwpr649I5X6x93qr0xfImt+yR
 dhbcVlMO2IltvDzQrukcDzp3rJj4fC7NSk7tq0FTIOZpeXSiG2YH54Vgifcc6lSwyJRB jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32chreg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:05:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31FLpTg7013584;
        Wed, 15 Feb 2023 23:05:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f7gskw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eshwk6pwwiFIqJ9e+v08IEGaldeA7ATBXEytm7mU9COpqV/qa/dfvmg5kuPvqauIS7RihS9OIwlkzZ14TS+Am4Yd/DqhrYeYwP4hsDS/pdf/POiac5vMtqDont0E8Pk/QWwqvVmKb+xgLaMp24pf5QUpQMnspOwam5eTFQAfAunxdAKyv0xnJL3FKEXcCGcpk8/JcBPzIK41yNEelM4lLfFiNHnCV98X5+sFOaFBjJ2LzMkPXDovCUCYDGwAI7mhVzHCJnXnAK8VTAAFtnNxOS5wuw8sRgyYZtovVOPVb705iTaJEiFfQkzNQmSrn727Xe/j12pzeGXenPKE3LGrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntW4luF47Ycm+4yJa7CWJxxhkum78MSo755btb0fgYM=;
 b=TDkZ5k1bpd3clWRbFAsn3OWzb8hwttsrXGqqSM5y/MreyOscVojEf3+Fob3MAHbcq+aIaas1Au/KeVJdHDD0tsZSEwIoR++kgNGs3cO8ZgET+JT0hMeCRP0TFydaDcatCEHP7KJeADFIPUTRNGkuSGJ/8GHANFJfdX4/kVpdNUCl4GqGVoSDZ31Rsdr44u+SCzcESuen1Ohf9xtnEDfDBHfxwnl2L8wbIbyNcEGyRR+gcIixIq3k0QZgCUhfPptDLOXFreRk0FMGwEYuX5BTLVaRH2yjjL8zbFPJ6/uSFQhpv4GmRED5wvDAzFPFeMQATEvY8GT2vbeyyDdDBbRCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntW4luF47Ycm+4yJa7CWJxxhkum78MSo755btb0fgYM=;
 b=NTqnA4cACl51Ph5NF73YGFuiJ4oCO3IHgo4i9RxlHboNbrOQnufbdHFT/MP44nAxQcBAFwjSGHmPCioHT6sDaPR1sEqtdiX5hi1QQzCG4DUfEpETzfO9j3ly7temVD3XcPBtOtT6D6Q4NcNGiFrGNVTOiGTHnOy5GrfBXiKTsA8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 23:05:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b%4]) with mapi id 15.20.6111.012; Wed, 15 Feb 2023
 23:05:12 +0000
Message-ID: <dab0d056-d2c8-a594-2a8f-c8dc2cefaa14@oracle.com>
Date:   Wed, 15 Feb 2023 15:05:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] nfsd: fix courtesy client with deny mode handling in
 nfs4_upgrade_open
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org,
        =?UTF-8?B?5by15pm66Ku6?= <cc85nod@gmail.com>
References: <20230203181834.58634-1-jlayton@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20230203181834.58634-1-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 91dc37d2-3b6f-4ee6-f3e2-08db0fa91798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4W+rUfhFDTpBc5J0cL1k6QcDZre648qnzLdCon6/J44f8nth9HHu5ubLewk8Lg4alcR8h65AKOzohylfoEwC8VdnAHfMTPj5ZBkkIm21Im5kzermO2i31GXu2yRb4jS6S7gsoDy8Eoj8NZ013PxtEduUt4BqkG53sa3Ryk3Omo8prQB5l/63WjoViPZGnbYBNQQBgWVq/aNA2lrHKe8GQDk117xMRRSlK94YEXGy1NzPyd2EFXrUxQmZylQDZi/WCWBJLxe5+eui7heUBajjsMWtaO5HKfLkT6ZzixaCCFGznFP/IkPbePyntxKw22FjKgBoeGXh8AFoZijIJFxfktSoeNpvotj1OYfyROtLbLt7NSHynypQSQHYuXiBhHnf+MvuaJJtqQduAbBfqGE4DL5PDIxrEvVfjog6WPqImB304M3vvNpbXo+BQIMw8D9DOI98wYlEVWuJCbUZVU/LjyyETTtyP2Lck+JJ8ou4gHSNwhVPwFuWNWKf/YLBXNP3HEaVuWahtbhW2M5y80TNlJebOf4GUPs59bM5WHQ5h7Ru98zf1d/daTbfSnnY2eC6sU15INBaP7wEVsrLp5QVzO2ysgo70UsPXKjChCJRp00f4Dd+G34FwZOg2gDmXbrgC3QoMCJqMFVMYsOF/UEtGBRewXbGbb58yPTocm0XYC0vZmWdWvF8Far2OQOOKl2zC5lH+RdhVEP2yyeI2UxU1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(9686003)(6512007)(2616005)(6666004)(6506007)(83380400001)(53546011)(478600001)(38100700002)(66476007)(8676002)(66556008)(66946007)(41300700001)(4326008)(6486002)(316002)(36756003)(186003)(31686004)(26005)(8936002)(5660300002)(31696002)(86362001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWtab0ZkOTBhQWRvRGJ1ejNIUUsvb3llY0ZEeVJjYjNCUXdGL3Q2K3d6YlAy?=
 =?utf-8?B?SVQ5Y0l4R2hDYy9TWnFxZTl0T3dsbjN4S0x5YndSUlZyNjZwVW5rNFFnakhP?=
 =?utf-8?B?OE43RnUrUUY0aFRENnJGNlUxM1F4L1pqNFVxZUV6NzF2clUvVlFuQUJUKzU5?=
 =?utf-8?B?THpmdmZ0cDZxN2phelQzOGVXUFA2QXFjQXVoSWRpNC9YVk5penRKUVd2OWtL?=
 =?utf-8?B?eWFlVnhqK2RIZGRIOEZoK1cyNFpmd3lRWWNjV1lKWUY2YUkrc3ByKzRUUTFX?=
 =?utf-8?B?MmgvKy92bFN6Z2E5OHVCVWZicnlwdXg2ZmRCc1AyWmdZaUwyclJNTUhscSsv?=
 =?utf-8?B?WlBmS0VSdWdyYzk2WS9jZzNGMlNQQnRWTnJ6RlNPWDE1WXR2eXJ6QU9SMHJM?=
 =?utf-8?B?b2w4bTZ3MXFyVnBjMmZVVS9ZM1hpQ0EwVUE4RG9PMTJQQ3EvelBJUHozTStQ?=
 =?utf-8?B?TkxrRGNuOUdrVkU0NzVjY3U2di83U1F1Zk9udnI3cHFtTmZQMmh4VFNvamlu?=
 =?utf-8?B?azFDK0IvK0I2N1E3MzZVYmlBb1g5SGRka1p1SjBDcTFvSmdKM3kvQU9ZaU9D?=
 =?utf-8?B?YVkxU2hkRmZDdkZCUkhweVJISzdFbitoZ3NGQWhnbWtCVmUrZEljUW5UVkQr?=
 =?utf-8?B?L1NtRTJBa3ptK3lWUEZXOVc1R3haNGNtWkZ5aGozQ3QvTnFJcnRWL01QMzlo?=
 =?utf-8?B?WGswT21ZQjJlZnNCUDl4NjV4emt6aWVUamFPSW02Zm53c1c1MXRrR2VTRzc2?=
 =?utf-8?B?cnVKWG13Q0dleDNDaGRhTjhGTjZGV1NndGwrVFZnRWZqNUlBeHB4NUQ4VUxS?=
 =?utf-8?B?aCtOMFF6UU1LTWZQSGZqOVdMbnB0RERjL2lJeU1IblhVbll6V084aXJXQVhP?=
 =?utf-8?B?Ni9mVkF5NHRPaHhDMG5IK2sya3pKem9QR0pwUDZnUm5TUlo5WDNoYVlnaVpO?=
 =?utf-8?B?Ui9pNWd3T1gwcWJNa3p1ZzAzMEZ3L1FYdnBXV0oxdU1tSkF6YURzNFEvNUg5?=
 =?utf-8?B?TDF1L0tmWEROeUZQbHVtTFFTMGhGMU9TNnRLaHVlcFVvM2FxcTFiWlVHeTV6?=
 =?utf-8?B?V1BKOExLM2R4QVpBNWRKc21BKzF0Ujh5OW9pUldPTHFsM2NiUGkrdWw1blE2?=
 =?utf-8?B?L1lPWlVNRlFFS0NMNzRwZnhoKzVHdjlCR2lib0JwREJEOVFSY2pEN1htYzJa?=
 =?utf-8?B?SGpiQ1VqSGVMdDZFMnk4amdUMGFjNi9oZUtrMFRLMkhLdE9pVEoyYVpqQ1J3?=
 =?utf-8?B?ZzNDQXc0Mys4Nit4OUZKQXJMQ25RUlNXaXBNYVFGcjc3eDFuNzZSWnQ4alBy?=
 =?utf-8?B?T3F2eVpNQ0hqYXY3b2Q4MGIvZGU2cERyajIxZGxrMS9rWWRpSk5VSlRPRkwy?=
 =?utf-8?B?TkFvMnd2WjEzQ2N2VlMwTzRXZFkzQkp0V1haRkk4ejR4eE5nM2tjWXBWazZs?=
 =?utf-8?B?Q25Vc0hiakM5TmRwWU1QeHRkYjUvaW1nWGMvT1c3MlpFRjgyS0VDU3B2VDdz?=
 =?utf-8?B?NGkxaW5hSVZlRTJhL2NDZThOcncvOWZxU1FIVzNMczkzRHVRa1pNcHprSzEy?=
 =?utf-8?B?RW51ajRhelZxeU5vTDBnTXl4MUJuU1haVjY3dHVjZXFZSUdxdVQxdDhydnk2?=
 =?utf-8?B?STlhVEJ0bS8vNllIcUlvQWFIVitGanRZQnIycDN5SGNtdFFKQnBZNjNkM2FF?=
 =?utf-8?B?OG5zWXZuUzB4UERMSmFJd3krS0taOVBSa1dyTldnNnJwQVFGTHpaOVFUOTM0?=
 =?utf-8?B?RnZwWFcwd3dnNWlISDdXazJBWW9maTJUNlo3NlFFVmZlZEZKSGhhZTA3ZTR0?=
 =?utf-8?B?V2V6MDdaRXlhc2w2Tlc0YWpWdk9wZ1ZVMDBDYVd4S25MVklzaEx6ZlZjMFNG?=
 =?utf-8?B?SjQzSytOZ0w2dC9EYTRZQWs4em94MkxPZ2xyNE10WlRlcURyN0t2UjJvUE9s?=
 =?utf-8?B?U1JxMlhoeDVZUjBEUXBCNmorUUtoeWdYcjBlTFoxWndiSzJ4OXJwdjljS2x1?=
 =?utf-8?B?YzVhUnY2dGpobDdremdyWWkyY3A1OC9QT3hCK2M5SDRNWjVtWkRxaHo0T3ZS?=
 =?utf-8?B?WkpLV3RKYWlNTnhPdlVDeDNyU2dyazl0elhFcDVaZGRxWjhmM0x5cVppcy96?=
 =?utf-8?Q?Pj7Rvx4a5Krv0B/WMxBW38G8w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EVhLauYxBgiwm/taAIVXnVMIHmCHAQhI0UpybnUAI914/gHLafTvY9U67rTRYG8IZuVyHOFevQ7ljstW8lG4bw4OWdozPX6TbEb8zlkfP5TvgC2W/yoFrTf1YiCPtK+71ZPlaG/f57+Y1Givee6StaHI7u1Kk3aAhSAUGgjn0BWnHy30HgtwtmnyErhT1BPPR0wvOt0TXjeCZ2lIGgriivzKBHBm748vvOoXtKp0beJjd1bdUtpRQdXtN7XyFfPKqaW5laa48p8TujAijFGDvrdoep6wPdUkMaX8GtyEsoRhE5AqFRHHd3VlzS7Lhs8GkFIzuySQ3Zn2dodSM6wN+OWVLQQQtswqu5qrdsSfi3AUW/guFqhpRsg8xAJvCqZY1eI1ozMUPDib7E4FuQtWoTkeByyJHEeAjZOxftjfZ5/lC2P8SmJLPjOdCbKv2e0K+CzWTkJmGFxRgx8gibQ+pzGbExqpiaF9ERfSyioS/5CBnObZqnkkJn57R+E3Zs69Ocf2ioxIIp5yvfDQhaq9BOppD1Tqn0LykMyc+jj7d6g4T3LLJfegi0kdH/9Q37NN9eiAptfiiTgXnorMAIngRqdjHMWpwVsI5oNG4oTLzlRIFKRBecVsW7dwNs5wo/3q3MQMscRpAa/T9EseEfAidgiWgnk+cxuQn4LGl8KsMA2IBh4uzN19/bXar5ezcQE7TYoocHhznQWIhdE3kBhT5u6S9PqHWAeMDywwP6Jn4L3o3h0xQwm9/ptQcdnnsZ6t9/FxjIO70GMiTgLKdMvw4v9iIj544euk0bNNodfGdhmuX49EfqaFaPyMEn9mz4Hm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dc37d2-3b6f-4ee6-f3e2-08db0fa91798
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 23:05:12.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3IMpWcL22aA6OIz0qqg7P30lRuNw7mEmEmFHgS7WkOtB37guvugro/KqqycsMvo/vOeW+ylPIrn8aMExgZssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_13,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150197
X-Proofpoint-GUID: MKVfYh_u6FkNMXYdFcOgZVVMbNa_oYeG
X-Proofpoint-ORIG-GUID: MKVfYh_u6FkNMXYdFcOgZVVMbNa_oYeG
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff, Chuck,

On 2/3/23 10:18 AM, Jeff Layton wrote:
> The nested if statements here make no sense, as you can never reach
> "else" branch in the nested statement. Fix the error handling for
> when there is a courtesy client that holds a conflicting deny mode.
>
> Fixes: 3d69427151806 (NFSD: add support for share reservation conflict to courteous server)
> Reported-by: 張智諺 <cc85nod@gmail.com>
> Cc: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4state.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c39e43742dd6..af22dfdc6fcc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>   	/* test and set deny mode */
>   	spin_lock(&fp->fi_lock);
>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
> -	if (status == nfs_ok) {
> -		if (status != nfserr_share_denied) {
> -			set_deny(open->op_share_deny, stp);
> -			fp->fi_share_deny |=
> -				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> -		} else {
> -			if (nfs4_resolve_deny_conflicts_locked(fp, false,
> -					stp, open->op_share_deny, false))
> -				status = nfserr_jukebox;
> -		}
> +	switch (status) {
> +	case nfs_ok:
> +		set_deny(open->op_share_deny, stp);
> +		fp->fi_share_deny |=
> +			(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> +		break;
> +	case nfserr_share_denied:
> +		if (nfs4_resolve_deny_conflicts_locked(fp, false,
> +				stp, open->op_share_deny, false))

While trying to write a pynfs test case to exercise this code path,
I realize that we don't need to call nfs4_resolve_deny_conflicts_locked
here since this is an open upgrade so it must comes from the same client
hence there is no conflict to resolve. Same behavior as OPEN_DOWNGRADE.

-Dai

> +			status = nfserr_jukebox;
> +		break;
>   	}
>   	spin_unlock(&fp->fi_lock);
>   
