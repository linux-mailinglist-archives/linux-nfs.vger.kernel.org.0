Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50327E160C
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Nov 2023 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKET26 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Nov 2023 14:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKET25 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Nov 2023 14:28:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA26D47
        for <linux-nfs@vger.kernel.org>; Sun,  5 Nov 2023 11:28:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5HW1gT019693;
        Sun, 5 Nov 2023 19:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : to : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=M1sPOztnIs9KUIL3knE5jgY533b7p/jLxnUOrx2zfMA=;
 b=eB5NV+QCXXD7EqFknbAYIe54/B9pfO9lIisvBpvlEatX8J/dLDX7CacJd+GmjHQJMiPA
 KFuvli5rM901xx5O21dagfyro34m1m4nucrx0WD5W9kghYfBnm4z59PGaw8msYVAJAU3
 Lil2wcOpJO1tHz5O0NEG2eD0umHuwvh+veHHKCpHGXgwxo/xHO6UUfyntllTrdosw30+
 57apSf4+6x9Et9pVVbGRI+fSvaYdgMssvXXQTZLtYVBA/QTJ1FCm7Zc6/Mijt4cca38D
 NJIGrMdL+INMEO+YX+HOxOFAoqVGxFpDOrj+4U+IrPtZ7+MOSTstn7c5HxMOXmpr550O Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5dub1q8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Nov 2023 19:28:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5FJfxX038257;
        Sun, 5 Nov 2023 19:28:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cdamfkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Nov 2023 19:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHmU5Xmo2bweUKDQIYo7KQ/GPYK8UkYmU45knZWc97laZliffUq31KjPBokDHLFkxs5dJruaPHKK0wFE5maFee9fCAlYQ55AuqOmtaX62cuwY/C5zRblvv4RSs43J4MEpaj0TvsCEDaqS1SwXHqHkOSBHTilLQQvQgZ4BJMiauCNB2JKIyBPHFI/JYi6bSByC8fYOTwIR84FHxppCNx35rlvodQmtcjoRF3avyyLKUBc1eQiOvt9CSEKmNeb03DY422XGHaFFb3XhDgjElzCuoZD7ZpHWHDOW/bz2l4VPBnrqeQaa1lxtstSxxJLUvW7CDuchNASVvwzARvUYdXqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1sPOztnIs9KUIL3knE5jgY533b7p/jLxnUOrx2zfMA=;
 b=lnlfg8uyZ4ZPFFCWa2cGJil3Qbk2sw71yVD1e9vyYb+gfCCkrdfbDmb8jktcPFpgfLr1wCLzEFA9he5seQWnM71JzCeS/HVEC9yeGIWoezo/4a4iW/8zRg0/3xTd9vtn3MYGH62yo/SmjUlV/k6NXU7W9gvIdfuIOCeXaIsvjOeFKVCYg/b7+0c6Htw2Nc+z+n6ogtUFUkqVpk5j/D6sCve2Rg9gtI0BHNUPQgFHwthMCHcsKdqwQBUQGVcMe0vCFAEt6ZLZHtd167WNyN063EH/wNkYyPlu3vta8O2fLDVjP4zeonB4Y+S8rzYZ1lBG0L/5qkSOEyE2SGrlf0Zuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1sPOztnIs9KUIL3knE5jgY533b7p/jLxnUOrx2zfMA=;
 b=ojXr6ZTgW8zksR+s8zFwEm0oCqhr8KZMUhlTFo7AjbBDYTw2dZZCTWo1AmA7dizm0mwcfgZ2NyEZvj1KevYJbmKZB425QdQZdb3JL9I/+h/DRIRDntIEdsR8nc2Js4tjEDchUH8oI3ZT7qEfaDbWfmPoYrxURu5tyyBGBoLiAIg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 19:27:55 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92%6]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 19:27:55 +0000
Message-ID: <151d80cb-33dc-4266-a3ba-4b89ea80e49f@oracle.com>
Date:   Sun, 5 Nov 2023 11:27:53 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: General protection fault in nfs4_setup_sequence caused by delegation
 return task
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:510:5::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH2PR10MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcb33e8-f75b-4056-6c2c-08dbde354fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCfS0TMX+Vc4aYk5Vs6jtUIJ4IZ6hdifvmHr+Pz74YIEa8cNe4h63RwWGk0qSgcR2KnG3WaXL6kCE1Uafb1lvG4uMndtY30HSENFa4Fqw6pgcMYTroO+RHGgEOVEWEidAhZb3KTNh80R6YRO0qf7jyD6R7AH+YISOZc+mMeEHxWZVhAO3YEvPlaIGLu4OaykEyz7ODtEVLdTMEKolMr1Izgn+ixZJFfty5zISbozxtDDhbwnJLVG7pW1RudFU+RPSDz2+KuM11pEKf95wtq8FMnfZoCPAYer4EyZ/wFAWQ93atfrlduAyQJqh7A2HTvgcrQgQnDNAuAG4kYzdx8FPme7qltPMqjIy1UgFPDLLAXoQzgc7ALGG7VVmG6GrmNjf4QyEmYHwTYc+8A9lO+bboj61cZUsc23WQcMcEXG88MisiZ25+Uphf6HhyR+dFhbEuVtFYEY0NpEcAwBmFIdpRZb+KRQsQU6mLeDUOH3EvZhcSDAwEVQAGJlcflFRZZV7qp/MsBN1pt4UmrcKhu0+vsJ9zuvgqHa5m6/WAsWVoWGqOoBXFATjtRlhZtVmLrd791oEmumJM9zTqfJqhKd4Fdk/8P4cxEd+wDGlFuQTUi0VN/U9nNwP76+Ds6P1+yE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2906002)(41300700001)(5660300002)(6486002)(478600001)(8936002)(8676002)(110136005)(66946007)(66476007)(316002)(86362001)(66556008)(26005)(6506007)(6512007)(36756003)(2616005)(9686003)(83380400001)(38100700002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBNTGtoQ2tPejMrSzBrR0RqdEVHRUlqRWFRTWMxbWthNEZGeEFFZlVRV05X?=
 =?utf-8?B?TEV3cGtxMmc2QXVFWEVmOWhXVm5GU2xoelpRZmNUWW1mbVVad2FRdkxCSFgv?=
 =?utf-8?B?MmJzaUR4QnMzRzhsQ3RxQ3BZR2F5bmJuRVZSaG1pYTY0ZHpCbTNneklYN3FN?=
 =?utf-8?B?dzIrTXVTbEVlRkZxTWVQdC8vVXMzOFlvK2ZQSkQ2MlZqS2VIZTVUMFRQTW9L?=
 =?utf-8?B?aWZXbjk5QWVnS3NFSkY5UW9XMHlBMkFxSnBKK0g0ajdUbDA5RGVXQWg3RWpC?=
 =?utf-8?B?MGR6WHZWZXpmZmJ6VHFYU05TTkZhcjF3amVZMHlCZmNhMC9yUWNyMWd6THM1?=
 =?utf-8?B?aGFBd2lsUFgrS1JJYW9GSXc2Uy9LTXZobnd1R29lc2ZlT29qZ2U3Q25zbGcy?=
 =?utf-8?B?ZnFBak5rd2lQQzNvcUpYaFpQS3FBTzN4L0EwWEFLZlNwdlQ1UFp2bVNsWVN0?=
 =?utf-8?B?aEprNkY1WjNUbHJsWkcxTWRaOE9aS1R1MHIzYzhyTU1Ra0FKbUUwdi9HbUcx?=
 =?utf-8?B?eVF3Ym9GMnRrTDdLUFhrTXlxNHR6SnNVVDN0Vk16eEdFOXFSMjNQam9NN3BT?=
 =?utf-8?B?SGJJVVFTTU1oVTcxUVEyWld1Q0NueUo5VitQZlRkNC81UlpmakZUb0x0R2ll?=
 =?utf-8?B?VFFSTmpkeWVjK0xsM2JXMnBPVC9NMTZrbXJqeGU5djVYeXcrdmxmdnVDNlZv?=
 =?utf-8?B?S3lkL2drL2hUR0NkcmdBQU92cHc1Wmd2MTBkUysrQmZwUkIvSnc3RnoxSEJ2?=
 =?utf-8?B?L1hCeDF2SFNTUTQ1ZldMM1pnOHhmTTFoeGtpSGM2MHErVk9wWXBKUVFKaTRw?=
 =?utf-8?B?YjRMMys2U3RwRkFwNkIxWGJDa3R0OFlzQS83akZ5QnlIYVZWaVVjMTUwb3l0?=
 =?utf-8?B?WXFaa0p6NHRXcDBJdCtrRDhrcWQ3NWNVL3VOT1dmTzdIWnJXSm1yekYvK0tp?=
 =?utf-8?B?cnVwZVJvc05YdUpUdmtqOFFiK2FKaUh0MGxlbnBtTnVXbGJBL2RTQ0VtTzEx?=
 =?utf-8?B?Y1hWenFUMmR3bjVGNEUrM0hkK2QwdWNJTHMxRkM1MndOSVM5ek41V01zcld3?=
 =?utf-8?B?eDBIWmdqWWF1VGlNdDZhTWRHa1I5eFlrWFZUS3FnT0ZPV2QzZDFwNmdkeEc4?=
 =?utf-8?B?NzdTcVNoRmhaVVZ6eDdFTGpuemY5WnlJdmFuZlA0ZmVpMEd5NWFrZmp2cmky?=
 =?utf-8?B?QjhEVWpGVXJkSUxJMWN4bjN3Rm44RzVXQXJBd0xhVTZEcGJhd3pNdW1xdGZT?=
 =?utf-8?B?UlFoaytpa05FTHVMSUtPMHp1Q3o4VExObDg3OGoyMUUrVmttYkdHWGlJZVR4?=
 =?utf-8?B?NkFEd01OajRERFB6TVA5a1ZwTjFLR0NwZ2lNSVBvRGNKY1VVWC8rVU96WGZZ?=
 =?utf-8?B?TFBNdEh2OE5BdTVHQ1BwMzI5WmJTOFptVWpScHVJbk42VXFzZTNUSnhXSFZ5?=
 =?utf-8?B?YTNaUlk4ZUFuY1lXZ0JjSHFBeWJScUpOcllYV1ZaQkdHVTBoVk84dUZQZ1da?=
 =?utf-8?B?dy9KdXpFQ0FSYUE4TUN4YVl2R2dIWmVQV3RlWFFON1MyUERYWE1oR3JSckQw?=
 =?utf-8?B?NEZjdXVEUVh3aHQycDhWNjFlVUk2K0hsNmY0UElEbGhRM2pZd0xpS3c5ZUEr?=
 =?utf-8?B?bGpqL1pkeHpId0E0TXRrVElLNVdJN3VQNUkvSC9zd2NBZHFLcExVRFdIVXpt?=
 =?utf-8?B?cHVNam52VElmRlQrUHhla2hVVWZFZEpLZXU1TUhSTzkrQTN1UENnUHpBWmZP?=
 =?utf-8?B?SzEvUmJ6bTg0cSt5YWlwY3poVEN0bG1abWR6LzZkMkdBenRsNmdyM001a2Jj?=
 =?utf-8?B?MUk4RkVaNjdwakE3QUVpc2N3Y0hCbm1KOXFnQlFRTVVrbnR5RkZkVWJjczV4?=
 =?utf-8?B?Ky9kbm1BZGZFKy9iMzdEcWx4N0djSE1GaDkwbFQ0M3htYnZLZ1A4QXMzNTNY?=
 =?utf-8?B?elBTV3NUUEhqYTA0Zk4wbUExVnJiUVJZWDdKakZLT2t1TEtrcm9WOVNyK2h4?=
 =?utf-8?B?T2JkV3VUNkJmMlFpSUcxek9rRFhQSUtRa1I0S2lUSVArMnErL0o5WEhEQUgx?=
 =?utf-8?B?dkZSb2plRVIxS2FvRnRTS04vUzBrQVFUVkdnRXhPVUhmVkVOaXg4M09naDQy?=
 =?utf-8?Q?et81PAaZPj0JXRzc8UiicvBNT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zM2PGVgf6of2EyvH7pWntiLQXoOLIeavqwBCFHGZSsU9I5qkNsi9cTwpP+C3QoZHkaQFfBv64/kGQC4OgH3bzgTt5cJe0LxsiwUZ8tb2QP0S5U49nKgxhLQzK+6YRwkOM4SQjwCeg/fFtgqh0O1CsbP5TbSBWnaLBWzNoBdiSwNxCBGneVLSg15KNLU1PVEY/xC50FpjHEpdVj1zgA4EW8AcYEmR0+7vgcG4ID5+0hsVVfRgluLWktkA4PZQ1fd4yfUdLiOgVKZd0sjzJLFpwnl+oR5aAYYYxrnWkFXqXbbeIDVDBeRIMQZsbJN7L2s+lytvkecY/X2gp5/FfK4sSz+WuKKF+1UE8NrLcD3nsOSwKTcvyQC2IGzUqAuFqZS05vzILqsgOU1RJLYgk+8ZAsTfA1c0bC7vmdrWms2dIifIKHrnpU25OSL8ourYXYgXHc7N0jDPjgPXC+kWOaCvEUZg9EC4mzlduFZ6zPlpEu47MA/L1UTJI1/eoZQkycQxPVyUEKjqqckrbR7iMrl9XDDehyxIxn+GlAlV8BcApmcVRCbK3nU1I1oLMxo2OMA2Smh3hj5c9HQleNe2u6JVBqT/NGP588Kq/4hpHvgmDpI0cBUY1z9WRgwP6c666yDkDrjVIJYnWEYvb10oHk94aFd/9Vf+oznJeC8T4/zZqA+6RAtHIBXnrF1oDpBWEEaULjrCq5ah69ophtKYf9h7t5enzlnisBkof49e6riviGKsfKpkZZ9KIkTK8bJTECL4w2KEQgJh7h4hZxjwFhyMBoBgF46jdKSGPf4vSXGiQJCcsv+9keiRcyhmhcLtYTgv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcb33e8-f75b-4056-6c2c-08dbde354fa9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 19:27:55.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ctzpHLI4TTU0Pi3xXtKW9H54iHd2JrBNbk8lpT81U+ZcEK2RjjPWfdXRJHbWEKdrD6ReGnA46RJf6M8Rf6lfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_18,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=982 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311050169
X-Proofpoint-GUID: RrjgKmX1QOML6fJAx7Ix9uWCWjyiYIB7
X-Proofpoint-ORIG-GUID: RrjgKmX1QOML6fJAx7Ix9uWCWjyiYIB7
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

When unmonting a NFS export, nfs_free_server is called. In nfs_free_server,
we call rpc_shutdown_client(server->client) to kill all pending RPC tasks
and wait for them to terminate before continue on to call nfs_put_client.
In nfs_put_client, if the refcounf is drecemented to 0 then we call
nfs_free_client which calls rpc_shutdown_client(clp->cl_rpcclient) to
kill all pending RPC tasks that use nfs_client->cl_rpcclient to send the
request.

Normally this works fine. However, due to some race conditions, if there are
delegation return RPC tasks have not been executed yet when nfs_free_server
is called then this can cause system to crash with general protection fault.

The conditions that can cause the crash are: (1) there are pending delegation
return tasks called from nfs4_state_manager to return idle delegations and
(2) the nfs_client's au_flavor is either RPC_AUTH_GSS_KRB5I or RPC_AUTH_GSS_KRB5P
and (3) the call to nfs_igrab_and_active, from _nfs4_proc_delegreturn, fails
for any reasons and (4) there is a pending RPC task renewing the lease.

Since the delegation return tasks were called with 'issync = 0' the refcount on
nfs_server were dropped (in nfs_client_return_marked_delegations after RPC task
was submited to the RPC layer) and the nfs_igrab_and_active call fails, these
RPC tasks do not hold any refcount on the nfs_server.

When nfs_free_server is called, rpc_shutdown_client(server->client) fails to
kill these delegation return tasks since these tasks using nfs_client->cl_rpcclient
to send the requests. When nfs_put_client is called, nfs_free_client is not
called because there is a pending lease renew RPC task which uses nfs_client->cl_rpcclient
to send the request and also adds a refcount on the nfs_client. This allows
the delegation return tasks to stay alive and continue on after the nfs_server
was freed.

I've seen the NFS client with 5.4 kernel crashes with this stack trace:

!# 0 [ffffb93b8fbdbd78] nfs4_setup_sequence [nfsv4] at ffffffffc0f27e40 fs/nfs/nfs4proc.c:1041:0
  # 1 [ffffb93b8fbdbdb8] nfs4_delegreturn_prepare [nfsv4] at ffffffffc0f28ad1 fs/nfs/nfs4proc.c:6355:0
  # 2 [ffffb93b8fbdbdd8] rpc_prepare_task [sunrpc] at ffffffffc05e33af net/sunrpc/sched.c:821:0
  # 3 [ffffb93b8fbdbde8] __rpc_execute [sunrpc] at ffffffffc05eb527 net/sunrpc/sched.c:925:0
  # 4 [ffffb93b8fbdbe48] rpc_async_schedule [sunrpc] at ffffffffc05eb8e0 net/sunrpc/sched.c:1013:0
  # 5 [ffffb93b8fbdbe68] process_one_work at ffffffff92ad4289 kernel/workqueue.c:2281:0
  # 6 [ffffb93b8fbdbeb0] worker_thread at ffffffff92ad50cf kernel/workqueue.c:2427:0
  # 7 [ffffb93b8fbdbf10] kthread at ffffffff92adac05 kernel/kthread.c:296:0
  # 8 [ffffb93b8fbdbf58] ret_from_fork at ffffffff93600364 arch/x86/entry/entry_64.S:355:0
         
Where the params of nfs4_setup_sequence:
      client = (struct nfs_client *)0x4d54158ebc6cfc01
      args = (struct nfs4_sequence_args *)0xffff998487f85800
      res = (struct nfs4_sequence_res *)0xffff998487f85830
      task = (struct rpc_task *)0xffff997d41da7d00

The 'client' pointer is invalid since it was extracted from d_data->res.server->nfs_client
and the nfs_server was freed.

I've reviewed the latest kernel 6.6-rc7, even though there are many changes
since 5.4 I could not see any any changes to prevent this scenario to happen
so I believe this problem still exists in 6.6-rc7.

I'd like to get your opinion on this potential issue with the latest kernel
and if the problem still exists then what's the best way to fix it.

Thanks,
-Dai

