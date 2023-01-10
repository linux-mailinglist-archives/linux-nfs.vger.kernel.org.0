Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963E3664C2C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjAJTSJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbjAJTSI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:18:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77152C67
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 11:18:05 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJAk41024566;
        Tue, 10 Jan 2023 19:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s5P+4BY3p/RudK3Kc92w0HO0aT65DZAIV6cjTznpWaM=;
 b=RhLJ7vvoCvsRx1GslIehI+aCCGA8G3E6YjO5dz1qRSlu8ZCuVFYrhUxVoNwahVPzzCJe
 9OxETyeNxf2zEjMhAW8+XpbrQvAW6++oQ2yIt12EJVmQfwwe7aPaSI9qTs7NDZqH2/k+
 ry8K8PgrdrZGzUYhoBBusMesHacvN41TEzreMpEQQKoSrVl2D0RKWBK2yHgnRCX8xWPn
 9Z66XcrnlvDbyWBg8liauP/rU6qAAnZz/uIaCtWr0DHUIZY1aFx7RDpiLnwmbYVkp3t/
 ozo7wWlepzoWbwS7AcxbPWHqU4bsY7djC7/W/4O3n+t21C90BUSMGJSX0hhpqAR0iulD Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185t8x36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:17:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AJGANh030661;
        Tue, 10 Jan 2023 19:17:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1bnag4j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTGmdv3dlqPIK9BfNIyG/qJPsDs8cEE5wXI2V+7HJ68xaKSGwJkCyIghLEx4LW7+8j+WD0qBRafB82qcrErCHTwKzW0HSorbnYrU37sF8yHe7rUX/n3bMSnd20yRbympif4HYKBV76k+WjJvjsykRbdL12/xp31+Xjx5JCV6B6VL9Q2UFgGT2bj+enF4Rpa3u9WzPe6PmQE1AkjEYnZEaSZ/S2460GqiwgbEtLsl+fxwgDVm48Zw47rupP18ofOP5o/LaPn+LLiCXhZ0jyknb5Mr1Mbndj8Z+eMpeLFh2vCvT26yf+PRR8iD7V0rNwuOneQKrItOJLoUGuaPjrGJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5P+4BY3p/RudK3Kc92w0HO0aT65DZAIV6cjTznpWaM=;
 b=bOlEFWKlU2eTjjPPpBGgt0xTi9ul90i8RnPXKYWZTF0QpSdQVDUYZ1xvfF0ks2/NYr3E7zVAcE7A2aZZMuGbzwrn9O9yuai4SFoWrIyrRw1TwY7XRaad/nuYdqYya5dPBfAZXbeYpPzwPTeAOKJcw5OFckW1Kb8TADW6EdcN3BBXmLrhDHVXDCRN280TkPgaPvD4Lu3EzfiJOSc9PoglfXxRvXKsqHo8P7vgrZcDowmWUL7nO+K4d2QxQf+281o9aREdum070ySkfOrubMXQ7gBGDmGczpVsuyaCQjfRYwqQigV9RAMyqr40w35Kquz3/ln449tGHFNTANLk4zul5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5P+4BY3p/RudK3Kc92w0HO0aT65DZAIV6cjTznpWaM=;
 b=PSTkxgp4jbHi0DIEm+D/d7pD1KfLH6zzsr1hHSR62ESlHX/ngerLHGdS+7vWQ1h3s/lcO0cDI2C9Rnzwxn6X92YUfNx0FldWbiNL6KMN/Ap+em8ZwZk5WM+1Gs2/fGTrwqPoHW0F1ZoVePUazP3tUGeKfMxPwD2W7FjgsFlX/Gs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 19:17:21 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 19:17:21 +0000
Message-ID: <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
Date:   Tue, 10 Jan 2023 11:17:17 -0800
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
From:   dai.ngo@oracle.com
In-Reply-To: <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0623.namprd03.prod.outlook.com
 (2603:10b6:408:106::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 1407ffcb-4b49-430f-5906-08daf33f4c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMpisnQcHFI8HqpaDip1knlCYGrOClUA5/vlYgXoPhS3bdJ7tjB1bGv+ueAaUV4XjQD2TJejZMJz4dGV7xKyELFR3Tb85P822NHLyaAqD2vPYEvhexCj7PQq6mwmF5XEWug1kuZcMkBT2+5VBgHqESUuB2sSrFhupysZMxjB8u8E8r/647hnLnIi/QAZyt3VYa9T+1i4Hmclq/yHZtuHHp9B43Q+KOnIAtvwFpZNstQUHuUngb1ENnuPPrYugizFCoteZXZv1AFAk1pAlriisVJX6o9TZ6zVxzpYZUUDbYSB47N8iusbtRpNZDfdB+Ng1m9YarSKpUi4i3E4opSRoK1f0td6j9WidkN/QY7OiliyNWVPWkQP1IdnUYg+NJwMj/Ne2AqQ+NuU9mW0ZwTF+Mjc8qGn6u109KY7Kg/oXiNUuHs82az2bH0N46+oV64EyF6CuAeB6ktorwB2pq+kycLgLmDks92C5FpJ1IrfkRimAPE/2a/1hdQ9cLwPmCB6xOMPdevXcZQvl9EuUgw4NuWs6jRUR6U7ZCmUOLO0tFVT1CYQg5/OosKflJTMeVohnY1RJ3n8oG12hveBQx50M3qZ6W7l2LOQzidv8a3kIUC2vaYaA8G5ILuLhHdKx07t4HyEUYR4uc992lF4A+ZGd3IXYpR5a6l9ALAcnh6FuNvXIRERR0fmTkYdGz99hvK3ilR///BDtAaZCLvU9rmTKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(36756003)(31696002)(86362001)(8936002)(5660300002)(83380400001)(6506007)(53546011)(6666004)(6486002)(2616005)(478600001)(186003)(26005)(9686003)(6512007)(38100700002)(8676002)(66946007)(66556008)(66476007)(4326008)(316002)(41300700001)(54906003)(31686004)(2906002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHl0ekhNeFMwM3VldTROOFBjSVdrNmpnRzVGbGRodHdYZm4yQ0x1dGlIUXdS?=
 =?utf-8?B?ZmZLRTBybTd2eWtaazlEZWprQ0p1L2hkeG51NXpvVXpWVll0U0dGaW5YaWsy?=
 =?utf-8?B?dlJIaFNTSy9EL2ttSlNwVHBxci9qNStIMkxkMXg4bFdHUmhFNml5ZnVVdTlu?=
 =?utf-8?B?NEI5VDU1S1Bnd0ZEQk9XTW15amo5ZU1UTXcvWGtSK0V0S0F4ZzdmK0w0Mkpn?=
 =?utf-8?B?ZWY3ZUZjZ3YzTVQrc3Y5elFEM2FaTG5YbzJjM0hMY1A4OG1vamV3SlVpa1RG?=
 =?utf-8?B?TkgwTHZqejJ2VWVsZ1Q3ck5ScSttcUt6RG85Q3NINkVlTFRIbmF2OEY5YzhE?=
 =?utf-8?B?cVFBZ3NXb1VacncyR0ZQVVk4R05rTGFLWkszRjd6NHR2VE9GbVFqa0dlS0dv?=
 =?utf-8?B?elgvV3NvVVpCS0NkZW5scU1zclpld3NRWmhCWkZKODhocDVybCtvTnkvUDZ6?=
 =?utf-8?B?dmlYM0dkbVJOL0VsMmFLeGl1a09DWUY4dHNYS3lTSzR6cEhYNjZkdTlxL0VB?=
 =?utf-8?B?anRNZWxXcU9VZ0pSVUR0UXUzKzZhaU1EQUZLZTY0cDh1dkpqZHZiT3Bja0ZL?=
 =?utf-8?B?b25leEFKL2hpRlZOSExxSnBKRDZ0Y1BpYmVJejVuSmhhUUxSbGFUaFJPbWMz?=
 =?utf-8?B?VC8yV0FaMWpLSEhxSE5ES1E4Ti81V0FsL0l4UGdDenJoWVI2M3ZDdzQzcjMx?=
 =?utf-8?B?MmJQbFlsemZ5QjFSWmxsQ2RmSnRzdTVYa2ZCNnpOd0JLUjFCWW91eXhGdk9W?=
 =?utf-8?B?b1NBcC8xU3VXaFB0ZHFLVXpteEpzMThGMUgxSndmYy96eldPYko5azZZa2lC?=
 =?utf-8?B?enBZSi9sdHRVVDBPOVZZS2VrVjkrT1JPRmk1ekF5a2JVa3B3dlpFZlZaclNU?=
 =?utf-8?B?eUQ0Q2JPWVE1bDFmZThXMjVTeXRFcGNxS081eWRkK3AzVVlHV0pLWDErK0Vq?=
 =?utf-8?B?aVRJK2tVOW9EMFdDTytFWngxZk8vZUFBaitBZ2p6eHpTVllMeWY2clVPSmZr?=
 =?utf-8?B?Qy9UZGZsd01HRnQrWWxZUTArVFVDenlKTEg5UGkxVHJDK1JjZDNGWjJzelF3?=
 =?utf-8?B?TGp1dHdEVmxHN094ZGxOcGNKYjJ1Q2xRdU1XUkZSMHVzUXlsLzJtdGExVzZk?=
 =?utf-8?B?OFlENXJaeFk0Y3Z5L0hsNTc2cjA5MWRjSVpWN24ycGN5alFjbTNaWXVlZEFz?=
 =?utf-8?B?Zkc1OVM0TnVjWTdZd1pUNzNPc0l0bWIxMzBINlB1cEdsa3lQbXlhUG55UFJP?=
 =?utf-8?B?NitzeXBUKzQvM1Rud3B5U3JkTmlUL0lUNlVQMmc4SGp0SlRSbEQrdDBCUEpn?=
 =?utf-8?B?RmUwVjhIbjV3TzB3S3JLcWh6UmFaZ0dObHIwbVV0aUdLelRkOU93MTFCK1p1?=
 =?utf-8?B?M1lJTVMwZkkvY01zM3BwdXBpb09tMjVEQ1MvMUZkbmJldVhyUGZYVmdlVDZu?=
 =?utf-8?B?Q1k0T3dHNTdqK0FpVTl3UUJXSFJ2Y0VuZGRsNDV1MmpvaStGV3NsT1ptcXFR?=
 =?utf-8?B?ekdoaUYvdTRIc2w4eVJpaFRJOEFmNzlhay9nQXZPRzVDVmNtcFBUeTRCcTF6?=
 =?utf-8?B?ZVlxUDBmUngvNU14amh5VHl1SDBCWDk0N3psVStGWkZUWDRJMFJXSlJqV1FX?=
 =?utf-8?B?UW1uVm5Hc0R2bzNOcHliYzl1b1BsM0tsYkNyVTliUmJTMnFtY3hjczF5TkVT?=
 =?utf-8?B?SmF3WW9SUHZNZE4vb2pIZS9VOFkybEtGTHhVMlM0a2VuOXptYXhxaWNvOWFr?=
 =?utf-8?B?WlhvTGhPVm4rdG9VbTJJb2E4eDI3TnFiWWNOVnA0WGlvSUluRk9vcG80dlJm?=
 =?utf-8?B?bGdmV0h0cnZFR3Z4ZldBWHZGazZSOWh6bEJpTUtSVURveVpyNWkrbFMrRysv?=
 =?utf-8?B?MDAwMVFoek5tYkVtTWNTZnpmRnJBcWZZUGRjQlpneFZEVDJEeERmTnRZckRL?=
 =?utf-8?B?cVJxRzU0NFk4S0hqOWNja3duaWdCdmk1NFpJZFc3bEN1Z0J6c0pjMVhOUDlU?=
 =?utf-8?B?YnBNSXF4WEVhODBXdkFhT2YyWXU0azY2Y1VYdytkZzJqRUIwbzc4K2kxZ1ly?=
 =?utf-8?B?MHZ3YXc2eWVqcHNwOHJhT24xdTRLdE5DNzViSEdwT0M0Z0RvekhDTUZsVnBZ?=
 =?utf-8?Q?Uc+pkzYHi8/2bnTHlSNeSmwsM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mdWkTN4qFAXl1pagMSOBDBt7WmFwDf7ULN+oUjn+9royyS94r1RDNGTC/KdAqiHdI8mHz9vvTU8eBF/psjE4yPTIUeES81zC2bVN6ogChWjFP+ncqH0hNlrshP6ozT2fap4EiKoD+TBwEtokk2xBHt8rA5PmV7UTarHINhu5BBxlZ1wUoDAm4hPI9iSb15dS74EUFQ+T7gX3PJmhaS1VI/ZUQ7Zidr/I9vzEc/3LhdmwG2fiFH2O6/vU9dKII6Rl5MrV/5Ks+0v1mlhHi2ncuOlRwwJ+3O63NIBCfNGxa7S+XIp/FyB74ULSNo+nmO/pQ70tcbxXNknAByNNY8sjMk2Egv2xZDGUbj2CsiVSp3PftiBXzeEkQDSeGhRjzqrQT/szeV2mT1uYzDAFAuA5pWV0UXGZLiju4JTjWJX8ujaWCDLqiI660UvXz4z19iYicEdzCy6Gp/4Wc+GQYisjll94g3mCITiXHSeMr2f9YagfwwnbaKdXQdXC0bsPTbiiOq/eO7RwIhaN9ryLbWndo7jjOe3edS3SGEYjLHfMMVm61kyInQV2spwTyQC65WTMjN3vImxJ+zLSC7CgdptK+zgwvI/0oSBshaGN/UeRxe3IAUbKAdX5EjWDczIxBeyhnCVjg0ayEAhjB6UseNotj7Ltjjl3Py7A2ofEtryBDMlQZ2hgRMUtgJB7kAUtn4P1c/LvCH6ohiEToMX8h/nntCmOh5BJoIENnqL+0iFfS75q85TE77gjNlKs/gfNiCe9LWo1mh+1LnL17kNAiNgVmVcoUXSQdV22e55fBtr5E48ThXyGnyMQUfJLMxZh+/vP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1407ffcb-4b49-430f-5906-08daf33f4c0a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 19:17:21.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cim8xqqcVi3Zma962TN6/55+9pEtF3c2AhAXW/0iLK2NezciP0zKiJBWg8FkAlNt4oxfv0w3dslqzD/7c2r4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_08,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100126
X-Proofpoint-ORIG-GUID: 90wQatnKE-h_WvpHxrILd4cVpKoybQPy
X-Proofpoint-GUID: 90wQatnKE-h_WvpHxrILd4cVpKoybQPy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/10/23 10:34 AM, Jeff Layton wrote:
> On Tue, 2023-01-10 at 18:17 +0000, Chuck Lever III wrote:
>>> On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>>
>>> On 1/10/23 2:30 AM, Jeff Layton wrote:
>>>> On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
>>>>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>>>>> from nfsd4_state_shrinker_count when memory is low. This causes
>>>>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>>>>
>>>>> This patch allows only one instance of nfsd4_state_shrinker_worker
>>>>> at a time using the nfsd_shrinker_active flag, protected by the
>>>>> client_lock.
>>>>>
>>>>> Replace mod_delayed_work with queue_delayed_work since we
>>>>> don't expect to modify the delay of any pending work.
>>>>>
>>>>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
>>>>> Reported-by: Mike Galbraith <efault@gmx.de>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>   fs/nfsd/netns.h     |  1 +
>>>>>   fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>>>>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>> index 8c854ba3285b..801d70926442 100644
>>>>> --- a/fs/nfsd/netns.h
>>>>> +++ b/fs/nfsd/netns.h
>>>>> @@ -196,6 +196,7 @@ struct nfsd_net {
>>>>>   	atomic_t		nfsd_courtesy_clients;
>>>>>   	struct shrinker		nfsd_client_shrinker;
>>>>>   	struct delayed_work	nfsd_shrinker_work;
>>>>> +	bool			nfsd_shrinker_active;
>>>>>   };
>>>>>     /* Simple check to find out if a given net was properly initialized */
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index ee56c9466304..e00551af6a11 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>>>>>   	struct nfsd_net *nn = container_of(shrink,
>>>>>   			struct nfsd_net, nfsd_client_shrinker);
>>>>>   +	spin_lock(&nn->client_lock);
>>>>> +	if (nn->nfsd_shrinker_active) {
>>>>> +		spin_unlock(&nn->client_lock);
>>>>> +		return 0;
>>>>> +	}
>>>> Is this extra machinery really necessary? The bool and spinlock don't
>>>> seem to be needed. Typically there is no issue with calling
>>>> queued_delayed_work when the work is already queued. It just returns
>>>> false in that case without doing anything.
>>> When there are multiple calls to mod_delayed_work/queue_delayed_work
>>> we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
>>> the work is queued but not execute yet.
>> The delay argument of zero is interesting. If it's set to a value
>> greater than zero, do you still see a problem?
>>
> It should be safe to call it with a delay of 0. If it's always queued
> with a delay of 0 though (and it seems to be), you could save a little
> space by using a struct work_struct instead.

Can I defer this optimization for now? I need some time to look into it.

>
> Also, I'm not sure if this is related, but where do you cancel the
> nfsd_shrinker_work before tearing down the struct nfsd_net? I'm not sure
> that would explains the problem Mike reported, but I think that needs to
> be addressed.

Yes, good catch. I will add the cancelling in v2 patch.

Thanks,
-Dai

>
>>> This problem was reported by Mike. I initially tried with only the
>>> bool but that was not enough that was why the spinlock was added.
>>> Mike verified that the patch fixed the problem.
>>>
>>> -Dai
>>>
>>>>>   	count = atomic_read(&nn->nfsd_courtesy_clients);
>>>>>   	if (!count)
>>>>>   		count = atomic_long_read(&num_delegations);
>>>>> -	if (count)
>>>>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>> +	if (count) {
>>>>> +		nn->nfsd_shrinker_active = true;
>>>>> +		spin_unlock(&nn->client_lock);
>>>>> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>> +	} else
>>>>> +		spin_unlock(&nn->client_lock);
>>>>>   	return (unsigned long)count;
>>>>>   }
>>>>>   @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *work)
>>>>>     	courtesy_client_reaper(nn);
>>>>>   	deleg_reaper(nn);
>>>>> +	spin_lock(&nn->client_lock);
>>>>> +	nn->nfsd_shrinker_active = 0;
>>>>> +	spin_unlock(&nn->client_lock);
>>>>>   }
>>>>>     static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
>> --
>> Chuck Lever
>>
>>
>>
