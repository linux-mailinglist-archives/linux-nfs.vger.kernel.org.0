Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8007895B2
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Aug 2023 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjHZKBj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Aug 2023 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjHZKBL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Aug 2023 06:01:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886D9B;
        Sat, 26 Aug 2023 03:01:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37Q6pClQ016988;
        Sat, 26 Aug 2023 10:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6cfB3UAiJ1N2wJPeNYYajsxYRCMz4NPlAc5SHE6Jakw=;
 b=Hm2a0hGhPGfSEx9aoWluDTTYNZFCt93yYvQDmxbZwe9bLMtKayjA7gFPwhLgSUBK85X+
 PsEiwDeHDfUIZMHmg0Ow+arKoGnTstjeFqMpPs6KN1xkOUJxgSvg431YDrCJlRXwIEjm
 7jNlBPkFuBUAf9MgbN0hBBoecc3IubnMWlEcFFvDVw/iRxRDCLdTZO0vw63jDsEGxcqj
 nQPyIpneaf54AjehP/dSH4xovF+ZRqcIhsQnolPRqwNgQ667Ko++eZhkit2EZtSLSur3
 BjAhAYo8sQjjTl1hlLD9vXFssWTP9UhG/OvR8yEwkNV237XuKmWEEbPFlsH7hSptkYK2 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcg9va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Aug 2023 10:00:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37Q7Voom040957;
        Sat, 26 Aug 2023 10:00:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sq7u88yk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Aug 2023 10:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVNjcx6K16npA+H0XAaBhY0JbugcgnUcJY+hjXyvU/Clj4gH+E27PYZ1lexyH1r/L/qpRt7hBSSkQe93aLZXsIy2pFldmWFgmyHoTeVn3EwYX6JnoWdtc1HTuq7Rubiz9dljHgXBXBFqL03Y4z+TanUFfu6qMS2l5WJT5LbGQADgHmD1KwbXLtu/9IPCNDDPuE/2SSefRXQd0j27JFe8rOK4zsmQiXoU85nZcsT4/Xhw64lTMCJfFgddIMSkkTfJdFF+ojF4hZRW0FDlc/LjvQH053it9IxnScQ0n9rmGy7nc+vAG1toBGO0PBP2hJTohIZccZ62dZs/y0JL0iuiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cfB3UAiJ1N2wJPeNYYajsxYRCMz4NPlAc5SHE6Jakw=;
 b=gViLlo5R4mnSz5aLEYP+ZPA9UkrMSjh13alk457HOsdETpQsyawFSoUnCpwW5MutV8sZDYOKZM5GBwZYbKBiIHs/beFfQKuArUuWQMe3dfDklubqyWXguR4/77eU6xLx7vivNK7z7zNdqLUewyxplcyfMNs8CyjI4iYfjOXD6Cnfo17ePlNVQa4Q2koncf/ISmWnd5xzKbF2yZW87+Am1IbMavDxlFbq7UpzFsSqd57e/kGx6bdb3VXL8EszCL9W54ZLzLeW2hL5zcNeE6czrpOhqa0sU4Y9njaGeK5zsCsjEEoHWWlbc/er3jOhxm8yH1bQAfiZq3R+2UuZJMMu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cfB3UAiJ1N2wJPeNYYajsxYRCMz4NPlAc5SHE6Jakw=;
 b=O44kU6dkyKd8zhhyLIRjK36uGopP4TpmwvbR7W/gRHAQb3ZoVJobV51zXq/q2DgJtek0DaMY72n5KgcKfNvvQZrJ4D9Pa94DcOv1fqGVa2kA4SShgxM2xg81oItjDPLfD1FHY3qhvCfBcmsNgZVrR8Hzf96zNdZSAJxYka4M8JM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB7227.namprd10.prod.outlook.com (2603:10b6:8:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Sat, 26 Aug
 2023 10:00:52 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 10:00:52 +0000
Message-ID: <cb30fbcd-485c-6cb0-fb5b-f3031599d4e9@oracle.com>
Date:   Sat, 26 Aug 2023 15:30:39 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 6.1.y 0/2] Address ltp nfs test failure.
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     brauner@kernel.org, chuck.lever@oracle.com, bfields@fieldses.org,
        stable@vger.kernel.org, linux-nfs@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, jlayton@kernel.org,
        vegard.nossum@oracle.com, naresh.kamboju@linaro.org
References: <20230825161603.371792-1-harshit.m.mogalapalli@oracle.com>
 <CAEUSe7_L2UtPi3Lcr4owKC83FO2zhCYDzNaWn-PKgfn9USNPvg@mail.gmail.com>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAEUSe7_L2UtPi3Lcr4owKC83FO2zhCYDzNaWn-PKgfn9USNPvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::35) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a318b9-7d7a-4510-7502-08dba61b54aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A08J2zdiMBaI72fbJvZYQMGxS2vW5I/cfmapisTPfyqOtYRCVkujiuaNVTFMKmNbB8CU38D2Ls9O/TYvslvCUO5+LjpfxDkoz1CZnN3NUAVTHcKa1L9b9xOJOBvF5anDbnK6hVjWBYMOvMtO6GHPzWtj62XdWSVt6JwYXIhn7l7ltucqYnjgC8Ne7WYsPb6+XTZ9lagXph1jstvnBEj7XrtAO5Utyj4U5RYU83nNg9GEA1CVkqWEpUzt53dT3imEJo2dd+eo3vh9o5C+PfGoZWQxNb462bPi8v/xOOWJiHa9TMg6KOq5Wnah0EC9Oy2Lk0Iif0aq+FhM69uVqiCMbcUODxvqJTzEvuYoMPyUhJcdQNd3A6+gU3/pZHWwHRcr/BbLXw4BlHNYghXk2pTrpB7I5Y4z+IgujZE5k+eRXkNkeYt+Zm7U8FkS/9iiBgsESyQ3hz3a0NPy1XfWISRBX4jJuvIMGZQFgZPBGRGvcMAXxyAPclKg+UJUZEuzdOJ5v47DyJm/6Zpx6D8Jr1z7UK6lPhwAuBljSy0s/t6xEUMv834NBIbaBJmOpX9JnA/ZXpb200ZBjw6nGCCY+F8vBSNWPSl7hIk1Id5kirL3xUQDryBIzfFytz/Io7u9HRDa312OLdylPyabxbZ3aQe7pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(1800799009)(186009)(451199024)(6506007)(53546011)(6486002)(6512007)(6666004)(83380400001)(31696002)(86362001)(66574015)(38100700002)(36756003)(26005)(316002)(2616005)(66946007)(2906002)(6916009)(66556008)(41300700001)(66476007)(31686004)(8936002)(4326008)(8676002)(5660300002)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZZYkRvNVdLRjRxSTBlR09FMHJwa0N5TWMyWHlXczlkUE9QSjhDTk1vTk5t?=
 =?utf-8?B?TXJaTnlMVmNPQndhckRkaTVnLy9Lc1c1WmttMFpvZ25OTzlqTDVNZ3Q4V25K?=
 =?utf-8?B?azVDREFZaGdwcEFEVjhGd2hCTnNFb0RheWxsOWJORHA2L0J5c0d3Y2hYZExZ?=
 =?utf-8?B?QUVneVh5b0k0ZGdxUjNjUzlOL2g2MEtidHpnaTBSTThHWnZhckF1dE1McTF0?=
 =?utf-8?B?V29sbFRvM25MK1k5TC9GdFpOYTZSd2ZxTlpCZUkzNTBTNzB3NXhXcUJHVkl2?=
 =?utf-8?B?ak9pcHpwMnJjWHRpWHU2N0FCclh6aGlvdWRTYVRpaitEV293SWhxemZ3M1ZX?=
 =?utf-8?B?dVJRV0w0Z2paMnByb29MaWc2bWZqVkJxaFVSaHNCZGxOR25Mekd6SDY3ck50?=
 =?utf-8?B?TXUyeEg1Sy80SDdaNUFMVlJZcnJxZGhiVEFudmNMVDd5Z1d4UkdvbndHeDlm?=
 =?utf-8?B?NTM2c1MxclF1K2RvUEFHZTdDU1l2bjNJdlNvUlJJZTJDQTlra24vS2FQUkNz?=
 =?utf-8?B?d1FSa3NUSGhrbGtadU5IeFFzMTYwdHl6NHl2TXVIcElSQ1FqS0gvMFV2RHN4?=
 =?utf-8?B?NGxZdWlienYra1A1QWdMd2tDYXU3THJRaFdCR2tkMVBubk1sVTl1U2hsRTRk?=
 =?utf-8?B?UERDYjZtZVlOZk1GVWd2RTNtNXBINzE5cmFmc2R0OWMxeVFIS2toNTQ5T1pX?=
 =?utf-8?B?azkxdHQ3WXpVLzRGbmJFWUZJVWdxaXFpd0NWK2Fhb0NZU0ZjTmFxMk5IeWRz?=
 =?utf-8?B?Q2VLSWJMZ1ZUZkppKzArQ2U5NzJHZVV1UmUvd3NrM2dNR25DaXZxWVhtalFC?=
 =?utf-8?B?bHR1RTE4cUFUTDQ0KzFlKzcyRHRidTl0N2ZlOFh5cjhhTzgzUjk0THJmOEpJ?=
 =?utf-8?B?L3BjT0MyUHRjK1ZxaGEvdFRTRWtSVzlmWmNnejZPbkRaTmJNTjBwaWlBeWM2?=
 =?utf-8?B?ZlRUYU01eTdGdmFhb0twZnA0NnpCbllObFdqMitneVJOQlZId1BTak9uUE5y?=
 =?utf-8?B?R3JKTE9wUklBV2R6RVlBSUkxeGxmM1dZQnBCSDdKdmNIVWZUMWpSSmw0MWNF?=
 =?utf-8?B?QVVaSkoybnplOUhUKzhmVXY4QlpSc0thU3YxdktUd0czV0pIcVNGYnRlc3Vv?=
 =?utf-8?B?ZjVQT0RTcnJhUTJlYmxweG9odmtzOFkwUWNEVlc2Tmo4MGs4cDJVZzFkZ0xC?=
 =?utf-8?B?aXRaL1ZPamhCYk93TDI5cDZoWTlOb05ZUndKdmk5SStMQ295bmNtcEMvcHQ3?=
 =?utf-8?B?TXVkM1RVUFpDeHF4aTVaLzBJM3dwWCtXdHp6Rk0wRnA0L21pbUZmWDVXTUZS?=
 =?utf-8?B?NUh6OHhueGJtVkxLRGJCUzBaemtrMEhCbjFieG1ocnZDRy9kSHN4R1lkNitu?=
 =?utf-8?B?SXozb0xnWjhSL0kwcUVxb1k5eEhRUU5qN1FLSE1JZlc5RzJmRE5KcmF6clN3?=
 =?utf-8?B?QjFUV1QwUFlsZlJUNzhOT0NRWWdTMEdNZFU0NG0yUEl5U3B0YWJRd3V6dllq?=
 =?utf-8?B?ZEJyYnk1cjA2ZmdBZTM4eXdzS2dZa2J5ZzBHZS9UaGlQKzZsc0RkQUZhNFI5?=
 =?utf-8?B?aHAySjNSNG02WWVVN2JsYzBuU01pbEQvTUN4OHdwSjR1ZUdmTG5YeGY1N1BU?=
 =?utf-8?B?bzNDNjhoZ3ZHL3hHZHVTaXBtd2U0NllYN2F1ZDJaOEtsWHpTaEVUcU1QUS82?=
 =?utf-8?B?M3g2OG90cVowM0c3Um53ZWN1SXQ1WXJFR2pIc3BKRFFmYnc5MlN5cStPV094?=
 =?utf-8?B?cFNVdjU3Q1kyU3pLLy9rVjI1WFM2bnNRUFJNTG9rc3BzeTRscVZHUE4rTVBk?=
 =?utf-8?B?OC92WUdnTXVOOGlpeGhoSjlMa0xXZGFETDJ3ZUc0WStiWk5nMDE4Tk96Q1Yx?=
 =?utf-8?B?MmFZVlJSSWJJREdXaFRhekZFbTlLZ3hUTU9DUG1EeXVWTzVwZFFveE5qTWZi?=
 =?utf-8?B?RlZWSjQ1Tk5aeDRlUG1FSFdKd1NKUGxOa3l4SkxYRjd2emlTNXdaS1VTTkRR?=
 =?utf-8?B?aWVGUnRVaHJjK1ZVcnRUQzBBdzRvSkRxZzVWNjlvNVA1L3ZQLzd6TnZKdVFX?=
 =?utf-8?B?MHZFS0hBcEpDbGVSVWZISlhVZTRXSjBIOHVZcThuR2ZrNnNFT21mMG9SRlds?=
 =?utf-8?B?ZHRnTXdkVFJYQUZEVFJpRUdRRU9xeFJmR3lsSHZPQTR3Qkg0Nm0vNjk0MEp6?=
 =?utf-8?Q?qUOeoEIviaOKjXgveg5TZdQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B9SW8M0vuJ5q2Hj68FW+o96Zfrvsq1nRtQCEhy+Ev9efrXMXo0JKsTPgM9lUCDrxEblps5sxhFdK6F3dDUa7z4ndiE8Rx+5LNFChDgePDNmMsRKojO7krS6deksiRLfsZU2LiKu7qnlVHe3l4JB+L6OyF5xKNpT2Dd+030ki9qDQFiHzfLOwcXl1tmBQzC/uWNKsdU92YSITR/x6jWM9xcoLcXN3afPW6+eAnJliUqR8ilqsF2XWOxVHrg1HiDLOrBglIbYlRtjSPGI/NRwY6gGvzLrSd7FQl+QkmGzcTKLX0S7SBdWBwrdK7is67IyDxsJAT271ny+8EPXfbBHMXgFUD94vmU4vMgk1nbQF4RNTouwBpGX9YXcbGDVuycq2SHXeu+oKYZMeGvtGWCX0Vtn/IIkHS2fIh/229ClqDbBSjXIcz2rEvb5YyyYj6AySCqvGtAtL3LZJ7mGM4aEHML+Zdo+JiBhtk/LAbfLqCHCvnlN5ORWh/1NWJup52mQAmVL2qelOrMmwqeMjDGkeLQEzaTWRkyidFBPOdsNp+vkDxyffVojxsgyhz0tmIgZ9PDw/ay0qRy26EeZr4yLy1eEofLPzEoAu6POPQvetuSOjKvb21HRf7Gh7pAHhmP3Ogxp0JMbNXiAM9+LET0SfRGCU9RsR+WfOSxHAu4SqKAjfTktcCbGmsz3lS/geu1iJd5Y1uff4RdtePdJrjfBAUb8eT5MrzQImltpKgwrj4mal+bnE4JWU5J6BbBVrl9+yQDTO1DqK2fHvsUh8adYHfc4gBVl3Lqw7h9VmTjDWn2cOltXnyWZ6n2Vo5brWHh7NAeCZCgJlKrtFFuRWEaglRzkh/m/9d+4oNWVGy3a70/J6y5zEv/iTArDruvG2JHjNhdBRzM7T1i4//0phrTu6qFgK5jSMgN34AbebRlN/b3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a318b9-7d7a-4510-7502-08dba61b54aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 10:00:51.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBlNv8dE1xfcjfvWm5a1CraGyPiP+OhGQX7wOlaTNxLjj1/bZgpo2UPlK5qxMJumZTmq1qkArh0WkOBjM3IDNw0KWNgHPaTNwHcjmiMuOty4hH6F9wZc8p+jQgU/vevV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-26_07,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308260093
X-Proofpoint-ORIG-GUID: LgLR481wZZrSA7CMSCqHXvuvsMhLsXCs
X-Proofpoint-GUID: LgLR481wZZrSA7CMSCqHXvuvsMhLsXCs
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Daniel,

On 26/08/23 4:41 am, Daniel Díaz wrote:
> Hello!
> 
> On Fri, 25 Aug 2023 at 10:17, Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
>> These two are backports for 6.1.y. Conflict resolution in done in
>> both patches.
>> I have tested LTP-nfs fchown02 and chown02 on 6.1.y with below patches
>> applied. The tests passed.
> 
> I have given this a go but did not see better results.
> 
> On 6.1.48-rc1, without any extra patches:
>    https://lkft.validation.linaro.org/scheduler/job/6685964#L3814
>    https://storage.tuxsuite.com/public/linaro/lkft/builds/2UR2OCpseRQ0lu76phKZBw6l2xf/
> 
> On 6.1.48-rc1 plus this series of patches:
>    https://lkft.validation.linaro.org/scheduler/job/6692637#L3832
>    https://lkft.validation.linaro.org/scheduler/job/6692642#L3818
>    https://storage.tuxsuite.com/public/linaro/daniel/builds/2UUHtMsTAQeuei3gGM32NWZx82w/
> 
> In both cases:
>    chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
>    chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
>    chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700,
> expected 0102700
> [...]
>    fchown02.c:57: TPASS: fchown(3, 0, 0) passed
>    fchown02.c:57: TPASS: fchown(4, 0, 0) passed
>    fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
> expected 0102700
> 
> The exact same thing happened with the 5.15 patch series.
> 

Odd, I just tested 5.15 based kernel again.

Unpatched kernel:

<<<test_start>>>
tag=fchown02 stime=1693034274
cmdline="fchown02"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1561: TINFO: Timeout per run is 0h 00m 30s
fchown02.c:58: TPASS: fchown(3, 0, 0) passed
fchown02.c:58: TPASS: fchown(4, 0, 0) passed
fchown02.c:68: TFAIL: testfile2: wrong mode permissions 0100700, 
expected 0102700

Summary:
passed   2
failed   1
broken   0
skipped  0
warnings 0

-----------

patched kernel:

<<<test_start>>>
tag=fchown02 stime=1693034615
cmdline="fchown02"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1561: TINFO: Timeout per run is 0h 00m 30s
fchown02.c:58: TPASS: fchown(3, 0, 0) passed
fchown02.c:58: TPASS: fchown(4, 0, 0) passed

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0


Test steps:

mkdir /tmpdir

yum install nfs-utils  -y
echo "/media *(rw,no_root_squash,sync)" >/etc/exports
systemctl start nfs-server.service
mount -o rw,nfsvers=4 127.0.0.1:/media /tmpdir
cd /opt/ltp/
./runltp -d /tmpdir  -s fchown02


Thanks for testing.

Regards,
Harshit
> I'll be glad to test more patches.
> 
> Greetings!
> 
> Daniel Díaz
> daniel.diaz@linaro.org
> 
> 
>> I would like to have a review as I am not familiar with this code.
>>
>> Thanks to Vegard for helping me with this.
>>
>> Thanks,
>> Harshit
>>
>> Christian Brauner (2):
>>    nfs: use vfs setgid helper
>>    nfsd: use vfs setgid helper
>>
>>   fs/attr.c          | 1 +
>>   fs/internal.h      | 2 --
>>   fs/nfs/inode.c     | 4 +---
>>   fs/nfsd/vfs.c      | 4 +++-
>>   include/linux/fs.h | 2 ++
>>   5 files changed, 7 insertions(+), 6 deletions(-)
>>
>> --
>> 2.34.1
>>
